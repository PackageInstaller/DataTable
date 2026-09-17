local this = class("mountManager", G_EventManagerBase)
local _mountTpl = L_GameTpl:getMountTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _commonPetSatietyTpl = L_GameTpl:getCommonPetSatietyTpl()
local _templateValueTpl = L_GameTpl:getTemplateValueTpl()
local maxRouletteCount = 8
this.event = {
  onCSEntityMountStateChange = "onCSEntityMountStateChange"
}

function this:ctor()
  this.super.ctor(self)
end

function this:initialize()
  self.onMountStateChangeHandle = self.onMountStateChangeHandle or handler(self, self.onCSEntityMountStateChange)
  C_ExternalManager.AddEvent(C_EExternalEventType.MountStateChange, self.onMountStateChangeHandle)
end

function this:dispose()
  if self.onMountStateChangeHandle ~= nil then
    C_ExternalManager.RemoveEvent(C_EExternalEventType.MountStateChange, self.onMountStateChangeHandle)
  end
end

function this:onCSEntityMountStateChange(args)
  AzurWorld.mountMgr:ReqChangeMountStatus(args.state)
  self:sendEvent(this.event.onCSEntityMountStateChange, L_CommonUtil.enumToNum(args.state))
end

function this:reqSetMountRoulettePos(mountId, pos, callback)
  if math.isEmpty(pos) then
    pos = self:getMinCanAddMountRoulettePos()
    if math.isEmpty(pos) then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_mount_without_slot"))
      return
    end
  end
  
  local function endDo()
    AzurWorld.mountMgr:ReqSetMountRoulettePosData(mountId, pos, function(errCode, rspData)
      if errCode == L_Const.errorCode.ErrCodeSucc and callback then
        callback()
        local pet = L_PetStore:getPetItem(mountId)
        L_HomeStore:reqPetExitHomeHub(pet:petGuid())
      end
    end)
  end
  
  local pet = L_PetStore:getPetItem(mountId)
  local gameplayStatus = pet:getGameplayStatus()
  if gameplayStatus == L_Const.PetState.PET_WORKING or gameplayStatus == L_Const.PetState.PET_RESTING or gameplayStatus == L_Const.PetState.PET_HUB then
    L_GameUtil.showCommonTip({
      txtContent = L_WordsTpl:getValue("notice_qibo_confirm_farm_mount"),
      confirmCallback = endDo
    })
    return
  end
  endDo()
end

function this:reqRemoveMountFormRoulettePos(pos, callback)
  AzurWorld.mountMgr:ReqRemoveMountRoulettePosData(pos, function(errCode, rspData)
    if errCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:getMinCanAddMountRoulettePos()
  local mountMap = L_MountStore:getMountMap()
  for i = 1, maxRouletteCount do
    if math.isEmpty(mountMap[i]) then
      return i
    end
  end
  return 0
end

function this:getMountSpeed(guid, satietyPer)
  if guid == 0 then
    return 0
  end
  local serverData = L_PetStore:getPetItem(guid)
  local tpl_base = _templateValueTpl:getTplById(serverData.id)
  local petBaseAttr = _templateValueTpl:getPetBaseAttribute(tpl_base)
  local tpl_growth = _templateValueTpl:getTplById(5001000 + serverData.lv)
  local petGrowthAttr = _templateValueTpl:getBaseAttribute(tpl_growth)
  local baseSpeed = 0
  if petBaseAttr[L_PetConst.PetPropertyId.Speed] then
    baseSpeed = petBaseAttr[L_PetConst.PetPropertyId.Speed] + baseSpeed
  end
  if petGrowthAttr[L_PetConst.PetPropertyId.Speed] then
    baseSpeed = petGrowthAttr[L_PetConst.PetPropertyId.Speed] * baseSpeed
  end
  baseSpeed = baseSpeed / 10000 * (serverData.speed / 10000)
  local speedFactor = L_GameConstTpl:getData("PET_RIDERSPEEDMULT", L_Const.GameTplType.int)
  local satietyStatus = L_SatietyStore:getPetSatietyStatus(guid, satietyPer)
  local commonPetSatietyTpl = _commonPetSatietyTpl:getTplById(satietyStatus)
  baseSpeed = baseSpeed * _commonPetSatietyTpl:getMoveSpeedSp(commonPetSatietyTpl)
  return math.floor(baseSpeed * speedFactor)
end

function this:getStatusBySpeed(guid, speed)
  local serverData = L_PetStore:getPetItem(guid)
  local tpl_base = _templateValueTpl:getTplById(serverData.id)
  local petBaseAttr = _templateValueTpl:getPetBaseAttribute(tpl_base)
  local tpl_growth = _templateValueTpl:getTplById(5001000 + serverData.lv)
  local petGrowthAttr = _templateValueTpl:getBaseAttribute(tpl_growth)
  local baseSpeed = 0
  if petBaseAttr[L_PetConst.PetPropertyId.Speed] then
    baseSpeed = petBaseAttr[L_PetConst.PetPropertyId.Speed] + baseSpeed
  end
  if petGrowthAttr[L_PetConst.PetPropertyId.Speed] then
    baseSpeed = petGrowthAttr[L_PetConst.PetPropertyId.Speed] * baseSpeed
  end
  baseSpeed = baseSpeed / 10000 * (serverData.speed / 10000)
  local speedFactor = L_GameConstTpl:getData("PET_RIDERSPEEDMULT", L_Const.GameTplType.int)
  local res = L_PetConst.SatietyStatus.LESS
  for _, v in ipairs(_commonPetSatietyTpl:getValue()) do
    local moveSpeedSp = v.move_speed_sp
    local tempSpeed = math.floor(baseSpeed * speedFactor * moveSpeedSp / 10000)
    if speed > tempSpeed then
      res = res + 1
    end
  end
  return res
end

function this:getIsMountUnlock(petGuid)
  local pet = L_PetStore:getPetItem(petGuid)
  local tpl_pet = _petTpl:getTplById(pet.id)
  if not _petTpl:getIsMount(tpl_pet) then
    return false
  end
  local tpl_mount = _mountTpl:getTplById(pet.id)
  local needItemId = _mountTpl:getUnlock(tpl_mount)
  return AzurWorld.mountMgr:GetIdMountSaddleUnlock(needItemId), needItemId
end

function this:getCanFly(petId)
  local tpl = _mountTpl:getTplById(petId)
  local canMountFly = _mountTpl:getMountCanFly(tpl)
  return canMountFly
end

return this
