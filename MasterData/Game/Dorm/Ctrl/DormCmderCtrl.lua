local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormCmderCtrl = class("DormCtrlBase", DormCtrlBase)
local DormInteractActionData = require("Game.Dorm.Data.DormInteractActionData")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local DormAIStateConfig = require("Game.Dorm.Character.AI.DormAIStateConfig")
local CheckFntDistance = 0.3
local CheckTalkDistance = 1
local cs_UnityUtility = CS.UnityUtility
local DormCmderEntity = require("Game.Dorm.Character.Entity.DormCmderEntity")
local InteractPool = CommonPool.New(function()
  return DormInteractActionData.New()
end, function(p)
  p:ResetData()
  return true
end)

function DormCmderCtrl:ctor(dormCtrl)
  self.__checkFrame = 0
  self.__checkpaused = false
  self.__interactState = DormEnum.CharInteractState.None
  self.__checkCmderInteract = BindCallback(self, self.CheckCmderInteract)
  self.__startFntInteractAction = BindCallback(self, self.StartFntInteractAction)
  self.__startTalkInteractAction = BindCallback(self, self.StartTalkInteractAction)
  self.__startGreetInteractAction = BindCallback(self, self.StartGreetInteractAction)
  self.__startDoorInteractAction = BindCallback(self, self.StartDoorInteractAction)
  self.__onRoomCharacterOpChanged = BindCallback(self, self.OnRoomCharacterOpChanged)
  MsgCenter:AddListener(eMsgEventId.OnDormCharacterOpChanged, self.__onRoomCharacterOpChanged)
end

function DormCmderCtrl:OnEnterDormScene()
  local cmderObject = self.dormCtrl.comRes.cmderPrefab:Instantiate()
  self:_InitHeadFx(cmderObject)
  self.cmderEntity = DormCmderEntity.New()
  self.cmderEntity:InitDormCmderEntity(cmderObject)
  self.cmderEntity:HideDormCmder()
  self.__interactActionList = {}
  self.__highLightFntDic = {}
  UIManager:ShowWindowAsync(UIWindowTypeID.DormInput, function(inputWindow)
    self.__inputWindow = inputWindow
    self.__inputWindow:InitDormInput(BindCallback(self, self.OnDormJoystickMove), BindCallback(self, self.OnDormJoystickUp))
    if not self.__cmderActive then
      self.__inputWindow:Hide()
    end
  end)
  UIManager:ShowWindowAsync(UIWindowTypeID.DormInteract, function(interactWindow)
    self.__interactWindow = interactWindow
    if not self.__cmderActive then
      self.__interactWindow:Hide()
    end
  end)
end

function DormCmderCtrl:_InitHeadFx(cmderObject)
  local cmderHeadFxGo = self.dormCtrl.comRes.cmderHeadFxPrefab:Instantiate(cmderObject.transform)
  local posConstraint = cmderHeadFxGo:GetComponent(typeof(CS.UnityEngine.Animations.PositionConstraint))
  if posConstraint ~= nil then
    local constraintSource = posConstraint:GetSource(0)
    local headPath = DormUtil.GetDormCmderResName() .. "/root/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 Head"
    local headTran = cmderObject.transform:Find(headPath)
    if IsNull(headTran) then
      warn("Commander head point is null : " .. tostring(headPath))
    end
    constraintSource.sourceTransform = headTran
    posConstraint:SetSource(0, constraintSource)
  end
end

function DormCmderCtrl:OnEnterDormHouse()
end

function DormCmderCtrl:OnEnterDormHouseEditMode()
  self:__SwitchDormCmderState(false)
end

function DormCmderCtrl:OnExitDormEditMode()
  self:__SwitchDormCmderState(true)
end

function DormCmderCtrl:OnEnterDormRoomEnd(roomEntity)
  self.__cmderInRoom = roomEntity
  local wallId, worldPos, startPos = roomEntity:GetRoomDoorPos()
  self.cmderEntity:CmderAddToRoom(self.__cmderInRoom, worldPos)
  self.cmderEntity:ShowDormCmder()
  self.cmderEntity:SetStarAIPathActive(false)
  self.cmderEntity:SetMoveAniSpeed(1)
  self.cmderEntity.transform.rotation = DormUtil.GetDormWallRot(wallId)
  self.cmderEntity:DoMoveUnityPos(startPos, function()
    self.cmderEntity:SetMoveAniSpeed(0)
    self:__SwitchDormCmderState(true)
    self.__interactState = DormEnum.CharInteractState.None
  end)
end

function DormCmderCtrl:OnExitDormRoomStart(roomEntity)
  self.__cmderInRoom = nil
  self:__SwitchDormCmderState(false)
  self.cmderEntity.transform:SetParent(nil)
end

function DormCmderCtrl:OnEnterDormRoomEditMode(roomEntity)
  self:__SwitchDormCmderState(false, true)
end

function DormCmderCtrl:OnExitDormRoomEditMode(roomEntity, success)
  if success then
    self.cmderEntity:DormForceStopMove()
    self.cmderEntity:ShowResumeCmder()
    self.cmderEntity:HideDormCmder()
    self:OnEnterDormRoomEnd(roomEntity)
    return
  else
    self:__SwitchDormCmderState(true, true)
  end
end

function DormCmderCtrl:GetCurRoomCharCtrl()
  if self.__cmderInRoom == nil then
    return nil
  end
  return self.dormCtrl.characterCtrl:GetRoomCharacterCtrl(self.__cmderInRoom)
end

function DormCmderCtrl:IsCmderInteractStateNone()
  return self.__interactState == DormEnum.CharInteractState.None
end

function DormCmderCtrl:__SwitchDormCmderState(active, isEditMode)
  self.__cmderActive = active
  if active then
    if isEditMode then
      self.cmderEntity:ShowResumeCmder()
    else
      self.cmderEntity:ShowDormCmder()
      if ConfigData.buildinConfig.DormStopCollideFeature then
        self.cmderEntity:GetCharAStarComp():SetNavMeshCutOnMoveStop(true)
      end
      self.cmderEntity:GetCharAStarComp():SetNavMeshCutEnabled(true)
      self.cmderEntity:SetStarAIPathActive(false)
    end
    self.__inputWindow:Show()
    self.__interactWindow:Show()
    self.cmderEntity:StartCmderCheckMove(ConfigData.buildinConfig.MinDistanceCheck, self.__checkCmderInteract)
    TimerManager:StopTimer(self.__checkTimerId)
    self.__checkTimerId = TimerManager:StartTimer(ConfigData.buildinConfig.DormInteractCheck, self.__checkCmderInteract, nil, false, false)
    self:CheckCmderInteract()
    self.__checkpaused = false
  else
    if isEditMode then
      self.cmderEntity:HidePauseCmder()
    else
      self.cmderEntity:HideDormCmder()
      self.cmderEntity:StopCmderCheckMove()
      self.cmderEntity:SetStarAIPathActive(false)
      self.cmderEntity:DormForceStopMove()
      self.__interactState = DormEnum.CharInteractState.None
    end
    self.__inputWindow:Hide()
    self.__interactWindow:Hide()
    TimerManager:StopTimer(self.__checkTimerId)
    self:RemoveAllHightLightFnt()
  end
end

function DormCmderCtrl:OnRoomCharacterOpChanged(start)
  self.__checkpaused = start
  if start then
    self.__interactWindow:Hide()
    self:RemoveAllHightLightFnt()
  else
    self.__interactWindow:Show()
    self:CheckCmderInteract()
  end
end

function DormCmderCtrl:RemoveAllHightLightFnt()
  for fntEntity, _ in pairs(self.__highLightFntDic) do
    DormUtil.RemovePointFntHighlight(fntEntity.gameObject)
  end
  self.__highLightFntDic = {}
end

function DormCmderCtrl:OnDormJoystickMove(moveData)
  if self.__interactState == DormEnum.CharInteractState.Fnt then
    self.__interactState = DormEnum.CharInteractState.WaitExit
    self.cmderEntity:AIStartExitWait(function(success)
      if not success then
        self.__interactState = DormEnum.CharInteractState.Fnt
        return
      end
      if self.__interactState == DormEnum.CharInteractState.WaitExit then
        self.__interactState = DormEnum.CharInteractState.None
      end
    end, true)
    return
  end
  if self.__interactState == DormEnum.CharInteractState.None then
    self.cmderEntity:SetStarAIPathActive(true)
    self.cmderEntity:GetCharAStarComp():SetNavMeshCutEnabled(false)
    self.cmderEntity:CmderStartMove(moveData)
  end
end

function DormCmderCtrl:OnDormJoystickUp()
  if self.__interactState == DormEnum.CharInteractState.None then
    self.cmderEntity:SetStarAIPathActive(false)
    self.cmderEntity:GetCharAStarComp():SetNavMeshCutEnabled(true)
  end
  self.cmderEntity:CmderEndMove()
end

function DormCmderCtrl:CheckCmderInteract()
  if self.__checkpaused then
    return
  end
  if self.__interactState ~= DormEnum.CharInteractState.None then
    return
  end
  if self.__checkFrame == Time.frameCount then
    return
  end
  self.__checkFrame = Time.frameCount
  local roomCharaCtrl = self:GetCurRoomCharCtrl()
  if roomCharaCtrl == nil then
    return
  end
  for i = #self.__interactActionList, 1, -1 do
    local interactAction = self.__interactActionList[i]
    InteractPool:PoolPut(interactAction)
    self.__interactActionList[i] = nil
  end
  if not self.dormCtrl:IsSelfDorm() then
    self.__interactWindow:HideInteractList()
    return
  end
  local interPointList = roomCharaCtrl:GetInterPointEntityList()
  local fntEntityDic = {}
  for _, interPoint in pairs(interPointList) do
    local interPointData = interPoint:GetInterPointData()
    if not (interPointData:GetInterAnimType() > 0) and cs_UnityUtility.IsCloseDistance(self.cmderEntity.transform, interPoint:GetPointStartPos(), CheckFntDistance) then
      local interactAction = InteractPool:PoolGet()
      interactAction:InitFntAction(interPoint, self.__startFntInteractAction)
      table.insert(self.__interactActionList, interactAction)
      if not interPointData:IsPointFntAniStateReady() then
        interactAction:SetInteractActionEnable(false)
      end
      fntEntityDic[interPoint:GetPointFromFntEntity()] = true
    end
  end
  for fntEntity, _ in pairs(fntEntityDic) do
    if self.__highLightFntDic[fntEntity] then
      self.__highLightFntDic[fntEntity] = nil
    else
      DormUtil.AddHighLightTarget(fntEntity.gameObject)
    end
  end
  for fntEntity, _ in pairs(self.__highLightFntDic) do
    DormUtil.RemovePointFntHighlight(fntEntity.gameObject)
  end
  self.__highLightFntDic = fntEntityDic
  if 1 < self.dormCtrl.houseCtrl.curHouse:GetRoomCount() then
    local wallId, worldPos, startPos = self.__cmderInRoom:GetRoomDoorPos()
    if cs_UnityUtility.IsCloseDistance(self.cmderEntity.transform, startPos, CheckFntDistance) then
      local interactAction = InteractPool:PoolGet()
      interactAction:InitDoorAction(self.__startDoorInteractAction)
      table.insert(self.__interactActionList, interactAction)
    end
  end
  local charDic = roomCharaCtrl:GetRoomCharacterDic()
  for heroId, charEntity in pairs(charDic) do
    if charEntity.gameObject ~= nil and charEntity:IsDormCharacterReady() then
      local hasTalk = true
      local talkList = charEntity:GetUnlockDormTalkList()
      if talkList == nil or #talkList == 0 then
        hasTalk = false
      end
      local hasGreet = charEntity:GetDormGreetConfig() ~= nil
      if (hasGreet or hasTalk) and cs_UnityUtility.IsCloseDistance(self.cmderEntity.transform, charEntity.gameObject.transform, CheckTalkDistance) and cs_UnityUtility.CheckTargetDirForMe(self.cmderEntity.transform, charEntity.transform, ConfigData.buildinConfig.DormInteractAngle) and charEntity.aiCtrl:EnableExitCurrentState() then
        if hasTalk then
          local interactAction = InteractPool:PoolGet()
          interactAction:InitTalkAction(charEntity, self.__startTalkInteractAction)
          table.insert(self.__interactActionList, interactAction)
        end
        if hasGreet then
          local interactAction = InteractPool:PoolGet()
          interactAction:InitGreetAction(charEntity, self.__startGreetInteractAction)
          table.insert(self.__interactActionList, interactAction)
        end
      end
    end
  end
  self.__interactWindow:UpdateInteractList(self.__interactActionList)
end

function DormCmderCtrl:__OnStartInteractAction()
  self.__interactWindow:HideInteractList()
  self:RemoveAllHightLightFnt()
end

function DormCmderCtrl:__SetOtherWindowActive(active)
  UIUtil.SetIsBlockTopStatusEsc(not active)
  if active then
    UIManager:ShowWindowOnly(UIWindowTypeID.TopStatus)
    UIManager:ShowWindowOnly(UIWindowTypeID.DormRoom)
    self.__inputWindow:Show()
  else
    UIManager:HideWindow(UIWindowTypeID.TopStatus)
    UIManager:HideWindow(UIWindowTypeID.DormRoom)
    self.__inputWindow:Hide()
  end
end

function DormCmderCtrl:StartFntInteractAction(interactAction)
  if self.__interactState ~= DormEnum.CharInteractState.None then
    return
  end
  local interPointEntity = interactAction.interPointEntity
  if interPointEntity == nil then
    return
  end
  local interPointData = interPointEntity:GetInterPointData()
  if not interPointData:IsPointFntAniStateReady() then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(interPointData:GetFntPointInteractTips())
    return
  end
  local charEntity = interPointData:GetBindCharacter()
  if charEntity ~= nil then
    charEntity:QuickExitAIState()
  end
  self:__OnStartInteractAction()
  self.__interactState = DormEnum.CharInteractState.Fnt
  self.cmderEntity.aiCtrl:StartFntInterPointState(interPointEntity:GetInterPointData())
end

function DormCmderCtrl:StartTalkInteractAction(interactAction)
  if self.__interactState ~= DormEnum.CharInteractState.None then
    return
  end
  local talkCharEntity = interactAction.talkCharEntity
  if talkCharEntity == nil or talkCharEntity.gameObject == nil then
    warn("talk character is nil,or gameObject is nil")
    return
  end
  if not talkCharEntity:IsDormCharacterReady() or not talkCharEntity.aiCtrl:EnableExitCurrentState() then
    return
  end
  local talkList = talkCharEntity:GetUnlockDormTalkList()
  if #talkList == 0 then
    return
  end
  self:__OnStartInteractAction()
  self:__SetOtherWindowActive(false)
  self.__interactState = DormEnum.CharInteractState.Talk
  self.cmderEntity:StartSmoothLookAtTarget(talkCharEntity.transform)
  talkCharEntity.aiCtrl:AIStartExitWait(function(success)
    if not success then
      self:__SetOtherWindowActive(true)
      self.__interactState = DormEnum.CharInteractState.None
      return
    end
    talkCharEntity:StartSmoothLookAtTarget(self.cmderEntity.transform)
    local talkAvgName = talkList[math.random(#talkList)]
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
    avgCtrl:ShowAvg(talkAvgName, function()
      self:__SetOtherWindowActive(true)
      talkCharEntity.aiCtrl:RandNewAction()
      self.__interactState = DormEnum.CharInteractState.None
      local talkCfg = ConfigData.dorm_hero_talk[talkCharEntity.heroData.dataId]
      if talkCfg == nil then
        return
      end
      for talkIndex, talkName in pairs(talkCfg.talk_list) do
        if talkName == talkAvgName then
          local heroId = talkCharEntity.heroData.dataId
          self.dormCtrl.allDormData:AddDormHeroTalked(heroId, talkIndex)
          local sendKey = self.dormCtrl.allDormData:GetDormHeroTalkKey(heroId)
          self.dormCtrl.dormNetwork:CS_DORM_SaveHeroTalk(heroId, sendKey)
          talkCharEntity:GenUnlockDormTalkList()
          break
        end
      end
    end, true)
  end, true)
end

function DormCmderCtrl:StartGreetInteractAction(interactAction)
  if self.__interactState ~= DormEnum.CharInteractState.None then
    return
  end
  local talkCharEntity = interactAction.talkCharEntity
  if talkCharEntity == nil or talkCharEntity.gameObject == nil then
    warn("talk character is nil,or gameObject is nil")
    return
  end
  if not talkCharEntity:IsDormCharacterReady() or not talkCharEntity.aiCtrl:EnableExitCurrentState() then
    return
  end
  local greetCfg = talkCharEntity:GetDormGreetConfig()
  if greetCfg == nil then
    warn("talk character greet cfg is null")
    return
  end
  self:__OnStartInteractAction()
  self:__SetOtherWindowActive(false)
  self.__interactState = DormEnum.CharInteractState.Greet
  self.cmderEntity:StartSmoothLookAtTarget(talkCharEntity.transform)
  talkCharEntity.aiCtrl:AIStartExitWait(function(success)
    if not success then
      self:__SetOtherWindowActive(true)
      self.__interactState = DormEnum.CharInteractState.None
      return
    end
    talkCharEntity:StartSmoothLookAtTarget(self.cmderEntity.transform)
    if self.__greetEffect == nil then
      self.__greetEffect = self.dormCtrl.comRes.greetRolePrefab:Instantiate()
    end
    self.__greetEffect.transform:SetParent(talkCharEntity.transform)
    self.__greetEffect.transform.localPosition = Vector3.zero
    self.__greetEffect:SetActive(true)
    self.__interactTimer = TimerManager:StartTimer(0.5, function()
      self.__interactTimer = nil
      self.__greetEffect.transform:SetParent(nil)
      self.__greetEffect:SetActive(false)
      local voiceId = ConfigData:GetVoicePointRandom(eVoicePointType.HellowDrom, nil, talkCharEntity.heroData.dataId)
      if voiceId ~= nil then
        local cvCtrl = ControllerManager:GetController(ControllerTypeId.Cv, true)
        cvCtrl:PlayCv(talkCharEntity.heroData.dataId, voiceId)
      end
      talkCharEntity:AnimatorCrossFade(greetCfg.hero_action)
      self.cmderEntity:AnimatorCrossFade(DormUtil.GetDormCmderConfig().greet_action)
      local greetingAnimTimeLength = talkCharEntity:GetAnimLength(greetCfg.hero_action)
      local delayTime = 0
      if 0 < greetingAnimTimeLength then
        delayTime = greetingAnimTimeLength + greetCfg.loop_time
      else
        delayTime = 2.5
      end
      self.__interactTimer = TimerManager:StartTimer(delayTime, function()
        self.__interactTimer = nil
        self:__SetOtherWindowActive(true)
        self.__interactState = DormEnum.CharInteractState.None
        talkCharEntity:AnimatorStand()
        self.cmderEntity:AnimatorStand()
        talkCharEntity.aiCtrl:RandNewAction()
      end, nil, true)
    end, nil, true)
  end, true)
end

function DormCmderCtrl:StartDoorInteractAction(interactAction)
  if self.__interactState ~= DormEnum.CharInteractState.None then
    return
  end
  self:__OnStartInteractAction()
  self:__SetOtherWindowActive(false)
  self.__interactState = DormEnum.CharInteractState.LeaveDoor
  self.cmderEntity:SetStarAIPathActive(false)
  self.cmderEntity.aiCtrl:StartVisitOtherRoom(function()
    UIManager:ShowWindowAsync(UIWindowTypeID.SceneChangesMask, function(win)
      win:InitSceneChangesMask(function()
        self.cmderEntity:SetStarAIPathActive(true)
        self.dormCtrl.houseCtrl:RandEnterNextDormRoom()
      end, function()
        self.dormCtrl.roomCtrl:ShowDormRoomUI()
        self:__SetOtherWindowActive(true)
      end)
    end)
  end)
end

function DormCmderCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnDormCharacterOpChanged, self.__onRoomCharacterOpChanged)
  self:RemoveAllHightLightFnt()
  TimerManager:StopTimer(self.__checkTimerId)
  TimerManager:StopTimer(self.__interactTimer)
  if self.cmderEntity ~= nil then
    self.cmderEntity:OnDelete()
    self.cmderEntity = nil
  end
end

return DormCmderCtrl
