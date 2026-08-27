local base = require("Game.Fairy.SubSystemCtrl.FairyCtrlBase")
local FairyHallCtrl = class("FairyHallCtrl", base)
local HallFairyEntity = require("Game.Fairy.Entity.HallFairyEntity")
local eFairyEnum = require("Game.Fairy.eFairyEnum")
local util = require("XLua.Common.xlua_util")
local CS_ResLoader = CS.ResLoader
local CS_GameObject = CS.UnityEngine.GameObject
local cs_DormAStarUtils = CS.DormAStarUtils
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_LeanGesture = CS.Lean.Touch.LeanGesture
local CS_RenderManager = CS.RenderManager
local CS_CmCoreState = CS.Cinemachine.CinemachineCore.Stage
local CS_Ease = CS.DG.Tweening.Ease
local CS_PostProcessVolume = CS.UnityEngine.Rendering.PostProcessing.PostProcessVolume
local CS_DualKawaseBlur = CS.XPostProcessing.DualKawaseBlur
local CS_DOTween = CS.DG.Tweening.DOTween
local CS_Physics = CS.PhysicsUtility
local __delayPlayLevelUpName = "PlayLevelUpAnimation"

function FairyHallCtrl:ctor(fairyCtrl)
  base.ctor(self, fairyCtrl)
  self.fairyPrefabList = nil
  self.fairyEntityDic = nil
end

local __coroutineType = {
  RefreshHallFairyEntity = 1,
  UpdateShowFairyModel = 2,
  ResetHallFairy = 3
}

function FairyHallCtrl:InitFairyHallCtrl()
  self.bind = {}
  self.__coroutineTable = {}
  self.isShowSingleState = false
  local ObjectBinderRoot = CS_GameObject.Find("ObjectBinder")
  UIUtil.LuaUIBindingTable(ObjectBinderRoot, self.bind)
  self:GenAstarPathMap()
  self._vcamNormalBody = self.bind.va_normal:GetCinemachineComponent(CS_CmCoreState.Body)
  self._vcamForceComposer = self.bind.va_force:GetCinemachineComponent(CS_CmCoreState.Aim)
  self.bind.va_force.Follow = self.bind.showFairyPos
  local postVolume = self.bind.cameraVrain.gameObject:GetComponent(typeof(CS_PostProcessVolume))
  if not IsNull(postVolume) then
    local isExist, kaswaseBlur = postVolume:GetProfile():TryGetSettings(typeof(CS_DualKawaseBlur))
    if isExist and not IsNull(kaswaseBlur) then
      self.kaswaseBlur = kaswaseBlur
    end
  end
  self.__loadFairyPrefabAsync = BindCallback(self, self.LoadFairyPrefabAsync)
  self.onFingerTap = BindCallback(self, self.__onFingerTap)
  self._OnGestureFunc = BindCallback(self, self._OnGesture)
  CS_LeanTouch.OnGesture("+", self._OnGestureFunc)
  self.__onUpdate = BindCallback(self, self.OnUpdate)
  UpdateManager:AddUpdate(self.__onUpdate)
  self.__onFairyUpdate = BindCallback(self, self.ResetHallFairy)
  MsgCenter:AddListener(eMsgEventId.UpdateFairy, self.__onFairyUpdate)
  self._UpdateShowFairyModel = BindCallback(self, self.UpdateShowFairyModel)
  MsgCenter:AddListener(eMsgEventId.OnShowFairyChange, self._UpdateShowFairyModel)
  self.__PlayShowFairyLevelUpAnimation = BindCallback(self, self.PlayShowFairyLevelUpAnimation)
  MsgCenter:AddListener(eMsgEventId.OnShowFairyLevelUp, self.__PlayShowFairyLevelUpAnimation)
  self.__PlayFairyNormalLevelUpEffect = BindCallback(self, self.PlayFairyNormalLevelUpEffect)
  MsgCenter:AddListener(eMsgEventId.OnShowFairyNormalLevelUp, self.__PlayFairyNormalLevelUpEffect)
  self.__OnChangeFairyCultivateState = BindCallback(self, self.OnChangeFairyCultivateState)
  MsgCenter:AddListener(eMsgEventId.OnChangeFairyCultivateState, self.__OnChangeFairyCultivateState)
end

function FairyHallCtrl:PlayEnterTimeLine()
  if self.bind then
    self.enterTimeLineCo = TimelineUtil.Play(self.bind.enterTimeLine)
  end
end

function FairyHallCtrl:GetFairyCtrl()
  return self.fairyCtrl
end

function FairyHallCtrl:GenShowFairyTypeTable()
  return self:GetFairyCtrl():GetHallFairyDataTable()
end

function FairyHallCtrl:OnUpdate()
  if self.fairyEntityDic == nil then
    return
  end
  if self.isShowSingleState then
    return
  end
  for fairyUid, fairyEntity in pairs(self.fairyEntityDic) do
    fairyEntity:OnUpdate()
  end
end

function FairyHallCtrl:PreLoadFairyPrefab(showFairyTypeTable)
  self.showFairyTypeTable = showFairyTypeTable
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.resloader = CS_ResLoader.Create()
  local greettingEmojiWait = self.resloader:LoadABAssetAsyncAwait("Res/Effect/Prefabs/OasisLittleMen/FXP_LittleMan_Emoji.prefab")
  coroutine.yield(greettingEmojiWait)
  self.fairyEmojiFxPrefab = greettingEmojiWait.Result
  self.fairyPrefabList = {}
  for fairyUid, fairyData in pairs(showFairyTypeTable) do
    local fairyPrefabPath = fairyData:GetFairyPrefabResStr()
    self:LoadFairyPrefabAsync(fairyPrefabPath)
  end
end

function FairyHallCtrl:GenAstarPathMap()
  local graph = CS.AstarPath.active.data.recastGraph
  graph:SnapForceBoundsToScene()
  graph:Scan()
end

function FairyHallCtrl:RefreshHallFairyEntity()
  self:DestoryAllHallFairyEntity()
  self.__coroutineTable[__coroutineType.RefreshHallFairyEntity] = GR.StartCoroutine(util.cs_generator(function()
    for fairyUid, fairyData in pairs(self.showFairyTypeTable) do
      self:AddFairyEntityToHall(fairyData)
    end
  end))
end

function FairyHallCtrl:CreateFairyEntity(fairyData, pos)
  local hallFairyEntity = HallFairyEntity.New(fairyData, pos, self)
  local fairyPrefabPath = fairyData:GetFairyPrefabResStr()
  if self.fairyPrefabList[fairyPrefabPath] == nil then
    self:LoadFairyPrefabAsync(fairyPrefabPath)
  end
  hallFairyEntity:LoadFairy(self.bind.hallFairyEntityHolder, self.fairyPrefabList[fairyPrefabPath], self.fairyEmojiFxPrefab, self.resloader, nil)
  hallFairyEntity:SetCurrentPrefabPath(fairyPrefabPath)
  return hallFairyEntity
end

function FairyHallCtrl:LoadFairyPrefabAsync(fairyPrefabPath)
  local cmderPrefabWait = self.resloader:LoadABAssetAsyncAwait(fairyPrefabPath)
  coroutine.yield(cmderPrefabWait)
  self.fairyPrefabList[fairyPrefabPath] = cmderPrefabWait.Result
end

function FairyHallCtrl:AddFairyEntityToHall(fairyData)
  local ok, pos = cs_DormAStarUtils.RandomOnePoint(Vector3.zero, 10000)
  if not ok then
    return
  end
  local hallFairyEntity = self:CreateFairyEntity(fairyData, pos)
  if self.fairyEntityDic == nil then
    self.fairyEntityDic = {}
  end
  self.fairyEntityDic[fairyData:GetFairyUID()] = hallFairyEntity
  return hallFairyEntity
end

function FairyHallCtrl:UpdateShowFairyModel(fairyData)
  if self.__coroutineTable[__coroutineType.UpdateShowFairyModel] ~= nil then
    GR.StopCoroutine(self.__coroutineTable[__coroutineType.UpdateShowFairyModel])
  end
  self.__isLoaded = true
  self.__coroutineTable[__coroutineType.UpdateShowFairyModel] = GR.StartCoroutine(util.cs_generator(function()
    local oldFairyEntity = self.showFairyEntity
    local newFairyEntity
    if fairyData ~= nil then
      if self.fairyEntityDic[fairyData:GetFairyUID()] ~= nil and self.fairyEntityDic[fairyData:GetFairyUID()]:GetCurrentPrefabPath() == fairyData:GetFairyPrefabResStr() then
        newFairyEntity = self.fairyEntityDic[fairyData:GetFairyUID()]
      else
        if oldFairyEntity ~= nil and oldFairyEntity:GetCurrentPrefabPath() == fairyData:GetFairyPrefabResStr() then
          newFairyEntity = oldFairyEntity
          newFairyEntity:ReSetAnimation()
        end
        newFairyEntity = self:CreateFairyEntity(fairyData, self.bind.showFairyPos.position)
      end
    end
    if oldFairyEntity ~= newFairyEntity then
      if oldFairyEntity ~= nil then
        if self.fairyEntityDic[oldFairyEntity.fairyData:GetFairyUID()] == nil then
          oldFairyEntity:Destoty()
        else
          oldFairyEntity:HidePauseFairy()
        end
      end
      self.showFairyEntity = newFairyEntity
      if self.showFairyEntity ~= nil then
        self.showFairyEntity:EnterShowTime(self.bind.showFairyPos.position, self.bind.va_force)
        self.showFairyEntity:PlayEnterAnimation()
      end
    end
    self.__isLoaded = false
    if self.__delayPlayAnimation == __delayPlayLevelUpName then
      if self.showFairyEntity ~= nil then
        self.showFairyEntity:PlayLevelUpAnimation()
      end
      self.__delayPlayAnimation = nil
    end
  end))
end

function FairyHallCtrl:PlayFairyNormalLevelUpEffect()
  if self.bind and self.bind.fXP_QuickLevelUp_sj.activeSelf == false then
    self.bind.fXP_QuickLevelUp_sj:SetActive(true)
  end
end

function FairyHallCtrl:PlayShowFairyLevelUpAnimation()
  if self.__isLoaded == true then
    self.__delayPlayAnimation = __delayPlayLevelUpName
  elseif self.showFairyEntity ~= nil then
    self.showFairyEntity:PlayLevelUpAnimation()
  end
end

function FairyHallCtrl:OnChangeFairyCultivateState(cultivateState)
  if eFairyEnum.FairyCultivateState.check == cultivateState then
    self._vcamForceComposer.m_TrackedObjectOffset = Vector3.Temp(0, 0.4, -1)
    self:DoBlur(true)
  elseif eFairyEnum.FairyCultivateState.upgradeStar == cultivateState then
    self._vcamForceComposer.m_TrackedObjectOffset = Vector3.Temp(-1, 0.4, -1)
    self:DoBlur(false)
  elseif eFairyEnum.FairyCultivateState.recovery == cultivateState then
    self._vcamForceComposer.m_TrackedObjectOffset = Vector3.Temp(1, 0.4, -1)
    self:DoBlur(false)
  end
end

function FairyHallCtrl:DoBlur(isReverse)
  if IsNull(self.kaswaseBlur) then
    return
  end
  if isReverse and self.kaswaseBlur.enabled.value == false then
    return
  end
  self.kaswaseBlur.enabled:Override(true)
  local startValue = isReverse and 4 or 0
  local endValue = isReverse and 0 or 4
  self.kaswaseBlur.BlurRadius.value = startValue
  local ease = isReverse and CS_Ease.OutQuint or CS_Ease.InQuint
  self.tweener = CS_DOTween.To(function()
    return startValue
  end, function(x)
    self.kaswaseBlur.BlurRadius.value = x
  end, endValue, 0.5)
  self.tweener:SetEase(ease).onComplete = function()
    self.kaswaseBlur.BlurRadius.value = endValue
    if isReverse then
      self.kaswaseBlur.enabled:Override(false)
    end
  end
  self.tweener:SetAutoKill(true)
  self.tweener:SetRecyclable()
end

function FairyHallCtrl:GetRandomOtherFairyEntity(startFairyEntity)
  if self.fairyEntityDic == nil then
    return nil
  end
  for fairyUid, fairyEntity in pairs(self.fairyEntityDic) do
    if fairyEntity ~= startFairyEntity and fairyEntity:GetGreettingFairyEntity() == nil then
      return fairyEntity
    end
  end
  return nil
end

function FairyHallCtrl:__onFingerTap()
  if not self.isShowSingleState and not self.showFairyEntity then
    return
  end
  local mainCamera = UIManager:GetMainCamera()
  if IsNull(mainCamera) then
    return
  end
  local hits = CS_Physics.Raycast(mainCamera, 1 << LayerMask.Character)
  for i = 0, hits.Length - 1 do
    local hitCollider = hits[i].collider
    if not IsNull(hitCollider) then
      self:PlayNormalAnimation()
    end
  end
end

function FairyHallCtrl:PlayNormalAnimation()
  if self.showFairyEntity then
    self.showFairyEntity:PlayIdleAnimation()
  end
end

function FairyHallCtrl:OnEnterShowFairyMode(fairyData)
  self:HidePauseAllFairy()
  self.bind.va_force.gameObject:SetActive(true)
  self.isShowSingleState = true
  CS_LeanTouch.OnFingerTap("+", self.onFingerTap)
end

function FairyHallCtrl:OnExitShowFairyMode()
  if self.fairyEntityDic == nil then
    return
  end
  if self.showFairyEntity ~= nil then
    if self.fairyEntityDic[self.showFairyEntity.fairyData:GetFairyUID()] ~= self.showFairyEntity then
      self.showFairyEntity:Destoty()
    else
      self.showFairyEntity:ExitShowTime()
    end
    self.showFairyEntity = nil
  end
  self:ShowResumeAllFairy()
  self.bind.va_force.gameObject:SetActive(false)
  self.isShowSingleState = false
  self:ResetHallFairy()
  if not IsNull(self.tweener) then
    self.tweener:Kill(true)
    self.tweener = nil
  end
  CS_LeanTouch.OnFingerTap("-", self.onFingerTap)
end

function FairyHallCtrl:HidePauseAllFairy()
  for k, v in pairs(self.fairyEntityDic) do
    v:HidePauseFairy()
  end
end

function FairyHallCtrl:ShowResumeAllFairy()
  for k, v in pairs(self.fairyEntityDic) do
    v:ShowResumeFairy()
  end
end

function FairyHallCtrl:DestoryAllHallFairyEntity()
  if self.fairyEntityDic ~= nil then
    for fairyUid, fairyEntity in pairs(self.fairyEntityDic) do
      if fairyEntity ~= nil then
        fairyEntity:Destoty()
      end
    end
  end
end

function FairyHallCtrl:ResetHallFairy()
  if self.isShowSingleState == true then
    return
  end
  local newShowFairyTypeTable = self:GenShowFairyTypeTable()
  local oldFairyEntityDic = self.fairyEntityDic
  self.fairyEntityDic = {}
  self.__coroutineTable[__coroutineType.ResetHallFairy] = GR.StartCoroutine(util.cs_generator(function()
    for fairyType, fairyData in pairs(newShowFairyTypeTable) do
      local fairyUid = fairyData:GetFairyUID()
      if oldFairyEntityDic ~= nil and oldFairyEntityDic[fairyUid] ~= nil and oldFairyEntityDic[fairyUid]:GetCurrentPrefabPath() == fairyData:GetFairyPrefabResStr() then
        self.fairyEntityDic[fairyUid] = oldFairyEntityDic[fairyUid]
        oldFairyEntityDic[fairyUid] = nil
      else
        self:AddFairyEntityToHall(fairyData)
      end
    end
    if oldFairyEntityDic ~= nil then
      for fairyUid, fairyEntity in pairs(oldFairyEntityDic) do
        if fairyEntity ~= nil then
          fairyEntity:Destoty()
        end
      end
    end
  end))
end

function FairyHallCtrl:_OnGesture(fingerList)
  if fingerList.Count == 0 or GuideManager.inGuide or fingerList[0].StartedOverGui or self.isShowSingleState then
    return
  end
  self:ActLbCamOnGesture(fingerList)
end

function FairyHallCtrl:ActLbCamOnGesture(fingerList)
  local screenDelta = CS_LeanGesture.GetScreenDelta(fingerList) * CS_RenderManager.Instance.ScreenScaleRatio
  if screenDelta.x ~= 0 or screenDelta.y ~= 0 then
    local deltaX = screenDelta.x * self.bind.camMoveSpeed.x
    local deltaY = screenDelta.y * self.bind.camMoveSpeed.y
    local pos = self.bind.cameraTarget.position
    pos = pos + Vector3.Temp(deltaX, 0, deltaY)
    pos.x = Mathf.Clamp(pos.x, self.bind.camMoveRangeX.x, self.bind.camMoveRangeX.y)
    pos.z = Mathf.Clamp(pos.z, self.bind.camMoveRangeZ.x, self.bind.camMoveRangeZ.y)
    self.bind.cameraTarget.position = pos
  end
  local delta = 1 - CS_LeanGesture.GetPinchScale(fingerList)
  if delta ~= 0 then
    self._distance = self._vcamNormalBody.m_CameraDistance + delta * self.bind.camScaleSpeed
    self._distance = math.clamp(self._distance, self.bind.camDistanceRange.x, self.bind.camDistanceRange.y)
    self._vcamNormalBody.m_CameraDistance = self._distance
  end
end

function FairyHallCtrl:SetCameraTarget(gameObject)
  if IsNull(self.bind.cameraVrain) then
    return
  end
  local currentVirtualCamera = self.bind.cameraVrain.ActiveVirtualCamera
  currentVirtualCamera.Follow = gameObject
end

function FairyHallCtrl:Delete()
  if self.enterTimeLineCo ~= nil then
    TimelineUtil.StopTlCo(self.enterTimeLineCo)
    self.enterTimeLineCo = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if not IsNull(self.tweener) then
    self.tweener:Kill()
    self.tweener = nil
  end
  if self.__onFairyUpdate ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.UpdateFairy, self.__onFairyUpdate)
    self.__onFairyUpdate = nil
  end
  if self._UpdateShowFairyModel ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.OnShowFairyChange, self._UpdateShowFairyModel)
    self._UpdateShowFairyModel = nil
  end
  if self.__PlayShowFairyLevelUpAnimation ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.OnShowFairyLevelUp, self.__PlayShowFairyLevelUpAnimation)
    self.__PlayShowFairyLevelUpAnimation = nil
  end
  if self.__OnChangeFairyCultivateState ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.OnChangeFairyCultivateState, self.__OnChangeFairyCultivateState)
    self.__OnChangeFairyCultivateState = nil
  end
  if self.__PlayFairyNormalLevelUpEffect then
    MsgCenter:RemoveListener(eMsgEventId.OnShowFairyNormalLevelUp, self.__PlayFairyNormalLevelUpEffect)
    self.__PlayFairyNormalLevelUpEffect = nil
  end
  self:DestoryAllHallFairyEntity()
  if self.showFairyEntity ~= nil then
    self.showFairyEntity:Destoty()
    self.showFairyEntity = nil
  end
  self.bind = nil
  self.fairyEntityDic = nil
  self.fairyPrefabList = nil
  self.fairyEmojiFxPrefab = nil
  self._vcamNormalBody = nil
  self._vcamForceComposer = nil
  self.kaswaseBlur = nil
  if self.onFingerTap then
    CS_LeanTouch.OnFingerTap("-", self.onFingerTap)
    self.onFingerTap = nil
  end
  if self._OnGestureFunc ~= nil then
    CS_LeanTouch.OnGesture("-", self._OnGestureFunc)
  end
  if self.__onUpdate ~= nil then
    UpdateManager:RemoveUpdate(self.__onUpdate)
  end
  if self.__coroutineTable ~= nil then
    for index, coroutine in pairs(self.__coroutineTable) do
      GR.StopCoroutine(coroutine)
      self.__coroutineTable[index] = nil
    end
    self.__coroutineTable = nil
  end
  base.Delete(self)
end

return FairyHallCtrl
