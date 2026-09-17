local this = class("modulePetCatchBtn", G_UIModuleBase)
local _worldCityTpl = L_GameTpl:getWorldCityTpl()

function this.bind()
  return {fill_maskCatchPet = 0, go_disableCatch = true}
end

function this.methods()
  return {
    onDown_petCatch = function(self)
    end,
    onUp_petCatch = function(self)
      if not L_PetManager:judgeCanCatchPet() then
        return
      end
      L_PlayerManager:firePetCatch()
    end
  }
end

function this:open(...)
  this.super.open(self, ...)
  self.petCatchNum = 0
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "moduleBattleControl.modulePetCatchBtn.update")
  L_BattleDataManager:addListener(L_BattleDataManager.event.petCatchNotice, self.onEvent_onPetNotice, self)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshPlayerStatus, self.onEvent_refreshPlayerStatus, self)
  self:initSystem()
  self:refreshPetCatchStatus()
  self.cdNum = C_EntityManager.MainPlayer.data.catchCoolDown
end

function this:update()
  local playerData = C_EntityManager.MainPlayer.data
  local coolDown = playerData.catchCoolDown
  local cd = playerData.catchCd
  if self.cdNum > 0.01 and coolDown == 0 then
    self.bindComponents.petCatchAnimation:SetTrigger("Ready")
  end
  self.cdNum = coolDown
  local fill_maskCatchPet = (cd - coolDown) / cd
  if 0.01 < math.abs(self.bind.fill_maskCatchPet - fill_maskCatchPet) then
    self.bind.fill_maskCatchPet = fill_maskCatchPet
  end
end

function this:onEvent_onPetNotice(args)
  if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.catchPet) and args.noticeType == "noticeCatchMonsterCount" then
    if args.catchCount > 0 and args.catchCount > self.petCatchNum then
      local coolDown = C_EntityManager.MainPlayer.data.catchCoolDown
      if coolDown <= 0 then
        self.bindComponents.petCatchAnimation:SetTrigger("Ready")
      end
    end
    self.petCatchNum = args.catchCount
  end
end

function this:onEvent_refreshPlayerStatus()
  self:refreshPetCatchStatus()
end

function this:refreshPetCatchStatus()
  local playerInMount = L_PlayerStore:playerInMountStatus()
  local sceneId = AzurWorldInstance.CurWorldId
  local tpl = _worldCityTpl:getTplById(sceneId)
  local isCatchPetDisable = _worldCityTpl:getIsSystemDisable(tpl, L_SystemConst.enum.catchPet)
  self.bind.go_disableCatch = isCatchPetDisable or playerInMount
end

function this:close(...)
  this.super.close(self, ...)
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
  self:destroyAllLocker()
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshPlayerStatus, self.onEvent_refreshPlayerStatus, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.petCatchNotice, self.onEvent_onPetNotice, self)
end

function this:initSystem()
  self.systemToTrans = {
    [L_SystemConst.enum.catchPet] = {
      self.bindComponents.rect_cellPetCatch
    }
  }
  for systemId, v in pairs(self.systemToTrans) do
    v.locker = C_IntegrateMgr.SystemUnlockModule:TryGenerateLocker(systemId)
    if v.locker then
      self:refreshSystem(systemId, false)
      v.locker:setCallback(self.refreshSystem, self, self.gameObject)
    end
  end
end

function this:refreshSystem(systemId, isUnlock)
  local node = self.systemToTrans[systemId]
  local locker = node.locker
  for _, v in ipairs(node) do
    locker:tryShowOrHide(v, isUnlock)
  end
end

function this:destroyAllLocker()
  for _, v in pairs(self.systemToTrans) do
    local locker = v.locker
    if locker then
      C_IntegrateMgr.SystemUnlockModule:RemoveLocker(locker)
    end
  end
end

return this
