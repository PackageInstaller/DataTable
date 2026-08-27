local base = require("Game.Formation.Ctrl.FormationCtrlBase")
local FormationSceneCtrl = class("FormationSceneCtrl", base)
local UIN3DFormation = require("Game.Formation.UI.3DFormation.UIN3DFormation")
local FmtPlatformEntity = require("Game.Formation.Entity.FmtPlatformEntity")
local FmtHeroEntity = require("Game.Formation.Entity.FmtHeroEntity")
local FmtEnum = require("Game.Formation.FmtEnum")
local util = require("XLua.Common.xlua_util")
local FormationUtil = require("Game.Formation.FormationUtil")
local ExclusiveWeaponEffectUtil = require("Game.ExclusiveWeaponEffect.ExclusiveWeaponEffectUtil")
local FixedFmtHeroData = require("Game.PlayerData.Hero.FixedFmtHeroData")
local EpRoleHeroData = require("Game.Formation.Data.EpRoleHeroData")
local FmtFairyEntity = require("Game.Formation.Entity.FmtFairyEntity")
local CS_GameObject = CS.UnityEngine.GameObject
local CS_Physics = CS.PhysicsUtility
local CS_InputUtility = CS.InputUtility
local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
local FmtGroundCollider = "FmtGroundCollider"
local FmtWallCollider = "FmtWallCollider"
local FmtPlatformPreName = "BasePlatform"
local DragPosOffset = Vector3.New(0, 0.3, -0.3)
FormationSceneCtrl.BrotatoPlatFormPosConfig = {
  BasePlatformPos = Vector3.New(0.58, 0.09999985, 0.535),
  UIPlatformPos = Vector3.New(133, 115.39, 0)
}

local function IsPlatformUnlock(fmtIndex, enterFmtData)
  local banPlatform = false
  local isBench = fmtIndex > enterFmtData:GetFormationMaxStageNum()
  local unlcok = true
  if isBench then
    if enterFmtData:IsFmtInBattleDeploy() then
      unlcok = false
    else
      unlcok = FormationUtil.CheckFmtBenchUnlock(fmtIndex)
    end
  end
  if enterFmtData:IsFmtCtrlFiexd() and not enterFmtData:HasFmtFixedHeroIndex(fmtIndex) then
    banPlatform = true
  end
  if enterFmtData:IsFmtPlatformBan(fmtIndex) then
    banPlatform = true
  end
  return unlcok and not banPlatform
end

function FormationSceneCtrl:ctor()
  self.__OnClickPlatform = BindCallback(self, self.OnClickPlatform)
  self.__OnBeginDrag = BindCallback(self, self.OnBeginDrag)
  self.__OnDrag = BindCallback(self, self.OnDrag)
  self.__OnEndDrag = BindCallback(self, self.OnEndDrag)
end

function FormationSceneCtrl:InitFmtSceneCtrl(go, enterFmtData)
  self.gameObject = go
  self.enterFmtData = enterFmtData
  self.transform = go.transform
  self.bind = {}
  UIUtil.LuaUIBindingTable(self.transform, self.bind)
  self.__loadHeroCoFuncList = {}
  local screenWidth = CS.UnityEngine.Screen.width
  self.__screenWidthRange = Vector2.New(self.bind.screenWidthOffset, screenWidth - self.bind.screenWidthOffset)
  local halfScreenHeight = CS.UnityEngine.Screen.height / 2
  self.__screenHeightRange = Vector2.New(halfScreenHeight * self.bind.screenHeightOffset.x, halfScreenHeight * self.bind.screenHeightOffset.y)
  local isInBrotatoDeploy = self.enterFmtData:IsFmtInBrotatoDeploy()
  self.ui3dFmt = UIN3DFormation.New(self.fmtCtrl, self.enterFmtData)
  if isInBrotatoDeploy then
    self.ui3dFmt:SetPlatFormPosByBrotato(1, self.BrotatoPlatFormPosConfig.UIPlatformPos)
  end
  self.ui3dFmt:Init(self.bind.uI_3DFormation)
  self.ui3dFmt:Init3DFormation()
  self.bind.platformSelectEffect:SetActive(false)
  self.platformEntityDic = {}
  self.platformEntityGoDic = {}
  local fmtIndex = 0
  for idx, go in ipairs(self.bind.platform) do
    if not self.enterFmtData:IsFormationIndexEnable(idx) then
      go:SetActive(false)
    else
      local banPlatform = false
      fmtIndex = fmtIndex + 1
      local isBench = fmtIndex > self.enterFmtData:GetFormationMaxStageNum()
      local isUnlock = IsPlatformUnlock(fmtIndex, self.enterFmtData)
      local entity = FmtPlatformEntity.New()
      entity:InitFmtPlatEntity(go, fmtIndex, self, self.__OnClickPlatform, isBench, isUnlock)
      entity:SetFmtPlatformDragEvent(self.__OnBeginDrag, self.__OnDrag, self.__OnEndDrag)
      self.platformEntityDic[fmtIndex] = entity
      self.platformEntityGoDic[go] = entity
      if self.__platformPosY == nil then
        self.__platformPosY = go.transform.position.y
        self.__platformPosZ = go.transform.position.z
      end
    end
  end
  if isInBrotatoDeploy then
    local entity = self.platformEntityDic[1]
    if entity ~= nil then
      entity.transform.localPosition = self.BrotatoPlatFormPosConfig.BasePlatformPos
    end
  end
  local isFairyUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_fairy)
  self.bind.fairyPlatform:SetActive(isFairyUnlock and self.enterFmtData:GetFmtIsShowFairy())
  self.heroEntityIdDic = {}
end

function FormationSceneCtrl:Get3DUIFormation()
  return self.ui3dFmt
end

function FormationSceneCtrl:GetFmtPlatEntityByIndex(index)
  if self.platformEntityDic == nil then
    return nil
  end
  return self.platformEntityDic[index]
end

function FormationSceneCtrl:RefreshFmtScene(forceAnim)
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  local newHeroEntityIdDic = {}
  for index, heroId in pairs(formationData:GetFormationHeroDic()) do
    local heroEntity = self.heroEntityIdDic[heroId]
    if heroEntity ~= nil then
      local heroData = formationData:GetFormationHeroData(index)
      if heroData == heroEntity.heroData then
        heroEntity:UpdateFmtHeroEntityHeadInfo()
        newHeroEntityIdDic[heroId] = heroEntity
        self.heroEntityIdDic[heroId] = nil
      end
    end
  end
  for k, heroEntity in pairs(self.heroEntityIdDic) do
    heroEntity:OnDelete()
  end
  self.heroEntityIdDic = newHeroEntityIdDic
  self.__loadHeroCo = nil
  self.heroEntityDic = {}
  for index, heroId in pairs(formationData:GetFormationHeroDic()) do
    local heroData = formationData:GetFormationHeroData(index)
    if heroData ~= nil then
      local platformEntity = self.platformEntityDic[index]
      platformEntity:ShowFmtPlatform(true)
      local heroEntity = self:__CreateHeroEntity(heroData, platformEntity.transform.position, forceAnim)
      self.heroEntityDic[index] = heroEntity
    end
  end
  self:RefreshFairyEntity()
  self.ui3dFmt:Refresh3DFmt()
end

function FormationSceneCtrl:RefreshFmtPlatformIsBanned()
  local bannedPlatformChanged = false
  for fmtIndex, entity in pairs(self.platformEntityDic) do
    local isUnlock = IsPlatformUnlock(fmtIndex, self.enterFmtData)
    if entity.unlock ~= isUnlock then
      entity.unlock = isUnlock
      bannedPlatformChanged = true
    end
  end
  if bannedPlatformChanged then
    for fmtIndex, platin in pairs(self.ui3dFmt:GetPlotformItemDic()) do
      local isUnlock = IsPlatformUnlock(fmtIndex, self.enterFmtData)
      platin.isBan = not isUnlock
    end
  end
end

function FormationSceneCtrl:ClearFmtInEditorModel()
  if not self.fmtCtrl:IsFmtCtrlInEditState() then
    return
  end
  for idx, heroEntity in pairs(self.heroEntityDic) do
    if not heroEntity.heroData.isFixedFmtHero then
      heroEntity:OnDelete()
      self.heroEntityIdDic[heroEntity.heroData.dataId] = nil
      self.heroEntityDic[idx] = nil
    end
  end
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  formationData:CleanFormation()
  self.ui3dFmt:Refresh3DFmt(formationData)
end

function FormationSceneCtrl:__CreateHeroEntity(heroData, position, forceAnim)
  local heroEntity = self.heroEntityIdDic[heroData.dataId]
  local coFunc
  if heroEntity == nil then
    local go = CS_GameObject(tostring(heroData.dataId))
    go.transform:SetParent(self.bind.characters)
    heroEntity = FmtHeroEntity.New(self.fmtCtrl, self.enterFmtData)
    coFunc = heroEntity:InitFmtHeroEntity(go, heroData, self.bind.camera)
    self.heroEntityIdDic[heroData.dataId] = heroEntity
  elseif forceAnim then
    heroEntity.gameObject:SetActive(false)
    
    function coFunc()
      if not IsNull(heroEntity.gameObject) then
        heroEntity.gameObject:SetActive(true)
        return heroEntity
      end
    end
  end
  heroEntity:SetFmtHeroEntityPos(position)
  if self.__loadHeroCoFuncList == nil then
    self.__loadHeroCoFuncList = {}
  end
  table.insert(self.__loadHeroCoFuncList, coFunc)
  if self.__loadHeroCo == nil then
    local function loadHeroListFunc()
      coroutine.yield(nil)
      
      while #self.__loadHeroCoFuncList > 0 do
        local coFunc = table.remove(self.__loadHeroCoFuncList, 1)
        local loadHeroEntity = coFunc()
        coroutine.yield(nil)
        if loadHeroEntity ~= nil then
          self:PlayExclusiveWeaponEffect(loadHeroEntity.heroData, loadHeroEntity.heroGo)
        end
      end
      self.__loadHeroCo = nil
    end
    
    self.__loadHeroCo = GR.StartCoroutine(util.cs_generator(loadHeroListFunc))
  end
  return heroEntity
end

function FormationSceneCtrl:PlayExclusiveWeaponEffect(heroData, heroObj)
  ExclusiveWeaponEffectUtil:PlayEWEffectByHeroData(heroData, heroObj, ExclusiveWeaponEffectUtil.EEwEffectType.Formation, LayerMask.Formation)
end

function FormationSceneCtrl:GetHeroEntity(fmtIndex)
  return self.heroEntityDic[fmtIndex]
end

function FormationSceneCtrl:GetFmtPlatformEntityByGo(gameObject)
  return self.platformEntityGoDic[gameObject]
end

function FormationSceneCtrl:SwapFmtPlatformHero(fromFmtIndex, toFmtIndex)
  local heroDic = self.heroEntityDic
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  local newFmtData = formationData.data
  heroDic[fromFmtIndex], heroDic[toFmtIndex] = heroDic[toFmtIndex], heroDic[fromFmtIndex]
  formationData:Exchange2Hero(fromFmtIndex, toFmtIndex)
  self.fmtCtrl:ModifyFormation(formationData)
  self.fmtCtrl:OnCurrentFmtChanged()
  self.ui3dFmt:RefreshFmtPlatformUI(fromFmtIndex)
  self.ui3dFmt:RefreshFmtPlatformUI(toFmtIndex)
  self.ui3dFmt:RefreshFmtHeroQuickLvUpByFmtIndex(fromFmtIndex)
  self.ui3dFmt:RefreshFmtHeroQuickLvUpByFmtIndex(toFmtIndex)
end

function FormationSceneCtrl:GuideDisableClickPlat(active)
  self.__inFmtGuide = active
end

function FormationSceneCtrl:OnClickPlatform(fmtIndex)
  if self.__inFmtGuide then
    return
  end
  if self.__dragPlatform ~= nil then
    return
  end
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  local heroData
  local heroEntity = self.heroEntityDic[fmtIndex]
  if heroEntity ~= nil then
    heroData = heroEntity:GetFmtHeroEntityData()
  end
  if formationData.isVirtualFormation then
    self.fmtCtrl:ShowQuickFormation(heroData)
  elseif heroData ~= nil then
    if heroData.isFriendSupport or IsInstanceOfClass(heroData, FixedFmtHeroData) or IsInstanceOfClass(heroData, EpRoleHeroData) then
      UIManager:ShowWindowAsync(UIWindowTypeID.SupportHeroState, function(win)
        if win == nil then
          return
        end
        win:InitSupportHeroState(heroData)
      end)
      return
    end
    local heroDataList = {}
    for i = 1, ConfigData.game_config.max_formation_hero do
      local heroEntity = self.heroEntityDic[i]
      if heroEntity ~= nil and heroEntity:GetFmtHeroEntityData() ~= nil then
        local heroData = heroEntity:GetFmtHeroEntityData()
        if not heroData.isFriendSupport and not heroData.isFixedFmtHero and not heroData.isOfficialSupport then
          table.insert(heroDataList, heroData)
        end
      end
    end
    self.fmtCtrl:ShowHeroState(heroData, heroDataList)
  elseif not self.fmtCtrl:IsFmtCtrlInEditState() then
    self.fmtCtrl:FmtCtrlEnterEditSate()
  end
end

function FormationSceneCtrl:OnSkinChange(heroId, skinId)
  if self.heroEntityIdDic == nil then
    return
  end
  local heroEntity = self.heroEntityIdDic[heroId]
  if heroEntity == nil then
    return
  end
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  if formationData.isVirtualFormation then
    heroEntity.heroData:UpdateSkin(skinId)
  end
  if heroEntity.modelPath == PathConsts:GetCharacterModelPathEx(heroEntity.heroData:GetResModelName()) then
    return
  end
  local coFunc = heroEntity:LoadModel()
  if self.__loadHeroCoFuncList == nil then
    self.__loadHeroCoFuncList = {}
  end
  table.insert(self.__loadHeroCoFuncList, coFunc)
  if self.__loadHeroCo == nil then
    local function loadHeroListFunc()
      while #self.__loadHeroCoFuncList > 0 do
        local coFunc = table.remove(self.__loadHeroCoFuncList, 1)
        
        coFunc()
        coroutine.yield(nil)
      end
      self.__loadHeroCo = nil
    end
    
    self.__loadHeroCo = GR.StartCoroutine(util.cs_generator(loadHeroListFunc))
  end
end

function FormationSceneCtrl:OnBeginDrag(platformItem, eventData)
  if GuideManager.inGuide then
    return
  end
  if self.enterFmtData:GetIsEpInifinity() then
    return
  end
  if self.__dragPlatform ~= nil then
    return
  end
  if not platformItem:IsFmtPlatformUnlock() then
    return
  end
  local heroEntity = self:GetHeroEntity(platformItem:GetFmtIndex())
  if heroEntity == nil then
    return
  end
  if heroEntity.heroData.isFixedFmtHero then
    return
  end
  self.__dragHero = heroEntity
  self.__dragHero:FmtHeroOnDrag(true)
  platformItem:EnableFmtPlatformRaycast(false)
  self.__dragPlatform = platformItem
  AudioManager:PlayAudioById(1018)
  CS_AnimationEffectController_Ins:KillRoleEffect(self.__dragHero.heroGo)
  CS_AnimationEffectController_Ins:RecycleRoleEffect(self.__dragHero.heroGo)
end

function FormationSceneCtrl:OnDrag(platformItem, eventData)
  if self.__dragPlatform == nil or self.__dragPlatform ~= platformItem then
    return
  end
  local targetPlatIsFixedHero = false
  local newPos = self:__GetGroundPoint()
  newPos = newPos + DragPosOffset
  self.__dragHero:SetFmtHeroEntityPos(newPos)
  local targetPlatform = self:__GetTargetPlatform(newPos)
  if targetPlatform == nil then
    if self.__swappedHero ~= nil then
      self.__swappedHero:DragHeroEndTweenHeroDetailItem(self.__swappedPlatform.transform.position)
      self.__swappedHero = nil
      self.__swappedPlatform = nil
    end
  elseif targetPlatform ~= platformItem and targetPlatform ~= self.__swappedPlatform then
    if self.__swappedHero ~= nil then
      self.__swappedHero:DragHeroEndTweenHeroDetailItem(self.__swappedPlatform.transform.position)
      self.__swappedHero = nil
      self.__swappedPlatform = nil
    end
    if targetPlatform:IsFmtPlatformUnlock() then
      local targetFmtIndex = targetPlatform:GetFmtIndex()
      local heroEntity = self:GetHeroEntity(targetPlatform:GetFmtIndex())
      targetPlatIsFixedHero = self:_PlatformIsFixedHero(targetPlatform)
      if heroEntity ~= nil and not targetPlatIsFixedHero then
        heroEntity:DragHeroEndTweenHeroDetailItem(platformItem.transform.position)
        self.__swappedPlatform = targetPlatform
        self.__swappedHero = heroEntity
      end
    end
  end
  if self:PullFormationDrag(eventData.position) then
    self:RecoverHeroPutPlatform()
  else
    local lightPlat = targetPlatform ~= nil and targetPlatform:IsFmtPlatformUnlock() and not targetPlatIsFixedHero and targetPlatform or platformItem
    if lightPlat ~= nil then
      self.bind.platformSelectEffect:SetActive(true)
      self.bind.platformSelectEffect.transform.localPosition = lightPlat.gameObject.transform.localPosition
    else
      self.bind.platformSelectEffect:SetActive(false)
    end
    self._lastSeekHeroPlat = lightPlat
  end
end

function FormationSceneCtrl:OnEndDrag(platformItem, eventData)
  self:RecoverHeroPutPlatform()
  if self.__dragPlatform == nil or self.__dragPlatform ~= platformItem then
    return
  end
  local targetPlatform = self:__GetTargetPlatform(self.__dragHero.transform.position)
  local targetPlatIsFixedHero = self:_PlatformIsFixedHero(targetPlatform)
  if self:PullFormationEnd(eventData.position, self.__dragHero) then
  elseif not (targetPlatform ~= nil and targetPlatform:IsFmtPlatformUnlock()) or targetPlatIsFixedHero then
    self.__dragHero:DragHeroEndTweenHeroDetailItem(platformItem.transform.position)
  else
    if targetPlatform ~= platformItem then
      local targetFmtIndex = targetPlatform:GetFmtIndex()
      local heroEntity = self:GetHeroEntity(targetPlatform:GetFmtIndex())
      if heroEntity ~= nil then
        if heroEntity.heroData.isFixedFmtHero then
          goto lbl_71
        end
        heroEntity:DragHeroEndTweenHeroDetailItem(platformItem.transform.position)
      end
      self.__dragHero:DragHeroEndTweenHeroDetailItem(targetPlatform.transform.position)
      self:SwapFmtPlatformHero(platformItem:GetFmtIndex(), targetFmtIndex)
      self.ui3dFmt:RefreshRefresh3DFmtFightPower()
    else
    end
  end
  ::lbl_71::
  local needExEffect = true
  if needExEffect then
    self:PlayExclusiveWeaponEffect(self.__dragHero.heroData, self.__dragHero.heroGo)
  end
  self.__dragHero:FmtHeroOnDrag(false)
  self.__dragHero = nil
  self.__swappedPlatform = nil
  self.__swappedHero = nil
  self.__dragPlatform = nil
  platformItem:EnableFmtPlatformRaycast(true)
  AudioManager:PlayAudioById(1019)
end

function FormationSceneCtrl:__GetGroundPoint()
  local mousePos = CS_InputUtility.MousePosition
  mousePos.x = math.clamp(mousePos.x, self.__screenWidthRange.x, self.__screenWidthRange.y)
  mousePos.y = math.clamp(mousePos.y, self.__screenHeightRange.x, self.__screenHeightRange.y)
  self:__RaycastGround(mousePos, self.fmtCtrl:IsFmtCtrlInEditState())
  if self.fmtCtrl:IsFmtCtrlInEditState() and self.__lastGroundPos.y < self.__platformPosY then
    local ratio = (self.__lastGroundPos.x - self.bind.camera.transform.position.x) / (self.__lastGroundPos.y - self.bind.camera.transform.position.y)
    self.__lastGroundPos.y = self.__platformPosY
    self.__lastGroundPos.x = ratio * (self.__lastGroundPos.y - self.bind.camera.transform.position.y) + self.bind.camera.transform.position.x
  else
    self.__lastGroundPos.y = self.__platformPosY
  end
  if self.__lastGroundPos.z > self.__platformPosZ then
    self.__lastGroundPos.z = self.__platformPosZ
  end
  return self.__lastGroundPos
end

function FormationSceneCtrl:__RaycastGround(mousePos, isUseWallCollider)
  local fixZ
  local hits = CS_Physics.Raycast(self.bind.camera, 1 << LayerMask.Raycast, true, mousePos)
  for i = 0, hits.Length - 1 do
    local hitCollider = hits[i].collider
    if not IsNull(hitCollider) then
      if hitCollider.name == FmtGroundCollider then
        if not isUseWallCollider then
          self.__lastGroundPos = hits[i].point
          break
        else
          fixZ = hits[i].point.z
        end
      end
      if hitCollider.name == FmtWallCollider and isUseWallCollider then
        self.__lastGroundPos = hits[i].point
      end
    end
  end
  if fixZ ~= nil then
    self.__lastGroundPos.z = fixZ
  end
end

function FormationSceneCtrl:__GetTargetPlatform(originPos)
  local targetGo
  originPos.y = originPos.y + 5
  local hits = CS_Physics.Raycast(originPos, Vector3.down, 1 << LayerMask.Formation)
  for i = 0, hits.Length - 1 do
    local hitCollider = hits[i].collider
    if not IsNull(hitCollider) then
      targetGo = hitCollider.gameObject
      break
    end
  end
  local targetPlatform
  if not IsNull(targetGo) then
    targetPlatform = self:GetFmtPlatformEntityByGo(targetGo)
  end
  return targetPlatform
end

function FormationSceneCtrl:_PlatformIsFixedHero(targetPlatform)
  local heroEntity = targetPlatform ~= nil and self:GetHeroEntity(targetPlatform:GetFmtIndex()) or nil
  local targetPlatIsFixedHero = heroEntity ~= nil and heroEntity.heroData.isFixedFmtHero
  return targetPlatIsFixedHero
end

function FormationSceneCtrl:SeekHeroPutPlatform()
  local newPos = self:__GetGroundPoint()
  newPos = newPos + DragPosOffset
  local targetPlatform = self:__GetTargetPlatform(newPos)
  local dragCardHeroData = self.fmtCtrl:GetOnDragCardHeroData()
  for fmtIndex, _ in ipairs(self.bind.platform) do
    if self.heroEntityDic[fmtIndex] ~= nil and self.heroEntityDic[fmtIndex]:GetFmtHeroEntityData().dataId == dragCardHeroData.dataId and self.platformEntityDic[fmtIndex]:IsFmtPlatformUnlock() then
      targetPlatform = self.platformEntityDic[fmtIndex]
      break
    end
  end
  if self:_PlatformIsFixedHero(targetPlatform) then
    targetPlatform = nil
  end
  if targetPlatform == nil or not targetPlatform:IsFmtPlatformUnlock() then
    targetPlatform = nil
    for fmtIndex, _ in ipairs(self.bind.platform) do
      if self.heroEntityDic[fmtIndex] == nil and self.platformEntityDic[fmtIndex] ~= nil and self.platformEntityDic[fmtIndex]:IsFmtPlatformUnlock() then
        targetPlatform = self.platformEntityDic[fmtIndex]
        break
      end
    end
  end
  if targetPlatform ~= nil then
    self.bind.platformSelectEffect:SetActive(true)
    self.bind.platformSelectEffect.transform.localPosition = targetPlatform.gameObject.transform.localPosition
  else
    self.bind.platformSelectEffect:SetActive(false)
  end
  self._lastSeekHeroPlat = targetPlatform
end

function FormationSceneCtrl:GetFmtLastSeekHeroPlat()
  return self._lastSeekHeroPlat
end

function FormationSceneCtrl:RecoverHeroPutPlatform()
  self.bind.platformSelectEffect:SetActive(false)
  self._lastSeekHeroPlat = nil
end

function FormationSceneCtrl:ConfirmHeroPutPlatform(heroData)
  local targetPlatform = self._lastSeekHeroPlat
  self:RecoverHeroPutPlatform()
  if targetPlatform == nil then
    return false
  end
  local index
  for k, v in pairs(self.platformEntityDic) do
    if v == targetPlatform then
      index = k
      break
    end
  end
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  for formatindex, heroId in pairs(formationData:GetFormationHeroDic()) do
    if heroId == heroData.dataId and formatindex ~= index then
      index = formatindex
      targetPlatform = self.platformEntityDic[index]
      break
    end
  end
  if index == nil then
    return false
  end
  local heroEntity = self.heroEntityDic[index]
  local beReplaceHeroData = heroEntity ~= nil and heroEntity:GetFmtHeroEntityData() or nil
  if heroData.isFriendSupport then
    local dailyUseLastHero = false
    if self.enterFmtData:IsFmtInBattleDeploy() then
      dailyUseLastHero = self.enterFmtData:GetFmtDungeonDyncData():HasDgDyncLastAstHero()
    end
    formationData:SetSupportHeroData(heroData, index, dailyUseLastHero)
  elseif heroData.isOfficialSupport then
    formationData:SetOfficialSupportHeroData(heroData, index)
  else
    formationData:SetHero2Formation(index, heroData.dataId)
  end
  if beReplaceHeroData ~= nil then
    self.heroEntityIdDic[beReplaceHeroData.dataId] = nil
    heroEntity:OnDelete()
  end
  targetPlatform:ShowFmtPlatform(true)
  heroEntity = self:__CreateHeroEntity(heroData, targetPlatform.transform.position, true)
  self.heroEntityDic[index] = heroEntity
  self.heroEntityIdDic[heroData.dataId] = heroEntity
  self.ui3dFmt:Refresh3DFmt(formationData)
  return true, beReplaceHeroData
end

function FormationSceneCtrl:RegisterPullFormationDragAct(onDragAct, pullFormatonDealAct)
  self.__OnpullFormationDrag = onDragAct
  self.__OnpullFormatonDeal = pullFormatonDealAct
end

function FormationSceneCtrl:RemovePullFormationDragAct()
  self.__OnpullFormationDrag = nil
  self.__OnpullFormatonDeal = nil
end

function FormationSceneCtrl:PullFormationDrag(touchPos)
  if self.__OnpullFormationDrag ~= nil then
    return self.__OnpullFormationDrag(touchPos)
  end
  return false
end

function FormationSceneCtrl:PullFormationEnd(touchPos, heroEntity)
  if heroEntity == nil then
    return false
  end
  if self.__OnpullFormatonDeal == nil or self.__OnpullFormationDrag == nil then
    return false
  end
  local isPull = self.__OnpullFormationDrag(touchPos)
  if isPull then
    local index
    for k, v in pairs(self.heroEntityDic) do
      if v == heroEntity then
        index = k
        break
      end
    end
    if index ~= nil then
      local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
      local heroData = heroEntity:GetFmtHeroEntityData()
      formationData:SetHero2Formation(index, nil)
      self.heroEntityDic[index] = nil
      self.heroEntityIdDic[heroData.dataId] = nil
      self.ui3dFmt:Refresh3DFmt(formationData)
      heroEntity:OnDelete()
      self.__OnpullFormatonDeal(heroEntity:GetFmtHeroEntityData())
      return true
    end
  end
  self.__OnpullFormatonDeal(nil)
  return false
end

function FormationSceneCtrl:SetFormationCameraActive(active)
  self.bind.formationCam:SetActive(active)
end

function FormationSceneCtrl:PlayTimeLine(endAction, updateAction)
  if self._tlCoroutine ~= nil then
    return
  end
  self._tlCoroutine = TimelineUtil.Play(self.bind.timeLine, function()
    TimelineUtil.StopTlCo(self._tlCoroutine)
    self._tlCoroutine = nil
    if endAction ~= nil then
      endAction()
    end
  end, nil, nil, nil, updateAction)
end

function FormationSceneCtrl:RewindTimeLine(endAction, updateAction)
  if self._tlCoroutine ~= nil then
    return
  end
  self._tlCoroutine = TimelineUtil.Rewind(self.bind.timeLine, function()
    TimelineUtil.StopTlCo(self._tlCoroutine)
    self._tlCoroutine = nil
    if endAction ~= nil then
      endAction()
    end
  end, nil, nil, nil, updateAction)
end

function FormationSceneCtrl:RefreshFmtPlatUIAll()
  local fmtRoleCount = self.enterFmtData:GetFormationRoleMax()
  for fmtIndex = 1, fmtRoleCount do
    self.ui3dFmt:RefreshFmtPlatformUI(fmtIndex)
  end
  self.ui3dFmt:RefreshRefresh3DFmtFightPower()
  self.ui3dFmt:ShowFmtHeroQuickLvUp()
end

function FormationSceneCtrl:OnUpdateHero(heroUpdateDic)
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  for index, heroId in pairs(formationData:GetFormationHeroDic()) do
    if heroUpdateDic[heroId] ~= nil then
      self.ui3dFmt:RefreshFmtPlatformUI(index)
      local heroEntity = self.heroEntityIdDic[heroId]
      heroEntity:UpdateFmtHeroEntityHeadInfo()
    end
  end
  self.ui3dFmt:RefreshRefresh3DFmtFightPower()
end

function FormationSceneCtrl:ShowHeroQuickLvUpEffect(fmtIdx)
  local platformItem = self:GetFmtPlatEntityByIndex(fmtIdx)
  if platformItem == nil then
    return
  end
  local effectCommon
  if self.effectQuickLvUpInUseDic == nil or self.effectQuickLvUpInUseDic[fmtIdx] == nil then
    effectCommon = self:_GetQuickLvUpEffect(fmtIdx)
  else
    effectCommon = self.effectQuickLvUpInUseDic[fmtIdx]
    effectCommon:Stop()
  end
  effectCommon:Play(platformItem.transform.position)
end

function FormationSceneCtrl:_GetQuickLvUpEffect(fmtIdx)
  self.effectQuickLvUpPool = self.effectQuickLvUpPool or {}
  self.effectQuickLvUpInUseDic = self.effectQuickLvUpInUseDic or {}
  local effectCommon
  if #self.effectQuickLvUpPool > 0 then
    effectCommon = table.remove(self.effectQuickLvUpPool)
  else
    effectCommon = self.bind.fXP_QuickLevelUp_sj:Instantiate()
    self._ReturnFmtEffectFunc = BindCallback(self, self._ReturnQuickLvUpEffect)
    effectCommon:InitEffectCommon(self._ReturnFmtEffectFunc, tostring(fmtIdx))
  end
  self.effectQuickLvUpInUseDic[fmtIdx] = effectCommon
  return effectCommon
end

function FormationSceneCtrl:_ReturnQuickLvUpEffect(effectCommon)
  table.insert(self.effectQuickLvUpPool, effectCommon)
  local fmtIdx = tonumber(effectCommon:GetEffectName())
  self.effectQuickLvUpInUseDic[fmtIdx] = nil
end

function FormationSceneCtrl:RefreshSupportHeroInfo(fmtIndex)
  self.ui3dFmt:RefreshFmtPlatformUI(fmtIndex)
  local heroEntity = self:GetHeroEntity(fmtIndex)
  heroEntity:UpdateFmtHeroEntityHeadInfo()
end

function FormationSceneCtrl:RefreshQuickLevelUpByIndex(fmtIndex)
  self.ui3dFmt:RefreshFmtHeroQuickLvUpByFmtIndex(fmtIndex)
end

function FormationSceneCtrl:RefreshAllQuickLevel()
  self.ui3dFmt:ShowFmtHeroQuickLvUp()
end

function FormationSceneCtrl:SetWarningTipState(active)
  self.ui3dFmt:SetWarningTipState(active)
end

function FormationSceneCtrl:RefreshFairyEntity()
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  local fairyData = formationData:GetFmtFairyData()
  if self.__loadFairyCo ~= nil then
    GR.StopCoroutine(self.__loadFairyCo)
    self.__loadFairyCo = nil
  end
  if self.fairyEntity ~= nil then
    self.fairyEntity:OnDelete()
    self.fairyEntity = nil
  end
  if fairyData ~= nil then
    if self.fairyEntity == nil then
      self.fairyEntity = FmtFairyEntity.New(self.fmtCtrl)
    end
    if self.__loadFairyCo == nil then
      local function loadHeroListFunc()
        while self.__loadHeroCoFuncList ~= nil and #self.__loadHeroCoFuncList > 0 do
          coroutine.yield(nil)
        end
        local loadFunc = self.fairyEntity:InitFmtFairyEntity(fairyData, self.bind.fairyBindPos)
        if loadFunc ~= nil then
          loadFunc()
        end
        self.__loadFairyCo = nil
      end
      
      self.__loadFairyCo = GR.StartCoroutine(util.cs_generator(loadHeroListFunc))
    end
  end
  self.ui3dFmt:RefreshFmtPlatformUI4Fairy()
end

function FormationSceneCtrl:OnDelete()
  if self.__loadHeroCo ~= nil then
    GR.StopCoroutine(self.__loadHeroCo)
  end
  if self.__loadFairyCo ~= nil then
    GR.StopCoroutine(self.__loadFairyCo)
  end
  if self.heroEntityIdDic ~= nil then
    for k, heroEntity in pairs(self.heroEntityIdDic) do
      heroEntity:OnDelete()
    end
  end
  self.heroEntityIdDic = nil
  if self.platformEntityDic ~= nil then
    for k, entity in pairs(self.platformEntityDic) do
      entity:OnDelete()
    end
    self.platformEntityDic = nil
  end
  if self._tlCoroutine ~= nil then
    TimelineUtil.StopTlCo(self._tlCoroutine)
    self._tlCoroutine = nil
  end
  DestroyUnityObject(self.gameObject)
end

return FormationSceneCtrl
