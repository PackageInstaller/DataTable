local UIAnimationController = CS.Z1Client.UIAnimationController
local Image = CS.UnityEngine.UI.Image
local AvgAction = CommonDefine.AvgAction
local TimeUtil = CS.Framework.TimeUtil
local Type_UIGrabPassRawImage = typeof(CS.UIGrabPassRawImage)
local CsTexture2D = typeof(CS.UnityEngine.Texture2D)
local T_RawImage = typeof(CS.UnityEngine.UI.RawImage)
local AvgDialogPanelNew, Super = System.NewClass("AvgDialogPanelNew", UIBasePanel)
AvgDialogPanelNew.uiResCls = UI_Story_Panel_MainResource

function AvgDialogPanelNew:ctor(storyId, chatId)
  Super.ctor(self)
  self.isPlaying = true
  self.storyId = storyId
  self.chatIndex = chatId
  self.playSpeed = Vue.ref(1)
  self.isFastMode = Vue.ref(false)
  self.isAuto = Vue.ref(false)
  self.isManualHideDialog = Vue.ref(false)
  self.isShowOption = Vue.ref(false)
  self.needClickActions = {}
  self.cachedTimeScale = TimeUtil.GetTimeScale()
  self.inDelayInit = Vue.ref(false)
  self.isForceHideDialog = Vue.ref(false)
end

function AvgDialogPanelNew:Init()
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.dialogAnimController = self.ui.Group_Dialog:GetComponent(typeof(UIAnimationController))
  self.avgModel = self.binder:createModel(AvgDialogModel, self.storyId, self.chatIndex)
  self:InitComps()
  self:InitActions()
  self:RefeshUIQueue()
end

function AvgDialogPanelNew:InitComps()
  self.bgComp = AvgDialogBgComp(self.ui, self.binder, self.avgModel)
  self.roleComp = AvgDialogRoleComp(self.ui, self.binder, self.avgModel)
  self.roleComp:Awake()
  self:InitTextComp()
  self.avgVideoComp = AvgVideoComp(self.ui, self.binder, self.avgModel, self)
  self.avgVideoComp:Awake()
  self.funcBtnComp = AvgFuncBtnComp(self, self.binder, self.avgModel)
  self.optionComp = AvgOptionComp(self, self.binder, self.avgModel)
  for _, comp in pairs({
    self.bgComp,
    self.roleComp,
    self.textComp,
    self.avgVideoComp,
    self.funcBtnComp,
    self.optionComp
  }) do
    self.binder:onDestroy(function()
      if comp.OnUnbind then
        comp:OnUnbind()
      end
    end)
  end
end

function AvgDialogPanelNew:InitActions()
  self.avgActions = {}
  for actionKey, actionName in pairs(AvgAction) do
    if not string.startswith(actionKey, "_") then
      local clsName = CommonDefine.AvgActionCls[actionName]
      local actionCls = require("GameScript.UI.AvgStoryNew.Action." .. clsName)
      self.avgActions[actionName] = actionCls(self.binder, self, self.avgModel)
    end
  end
end

function AvgDialogPanelNew:OnBind(binder)
  self.binder = binder
  binder:LoadAllLangFont(self.ui.Text_Name)
  binder:LoadAllLangFont(self.ui.Text_Caption)
  binder:LoadAllLangFont(self.ui.Text_Content)
  binder:LoadAllLangFont(self.ui.Text_Caption2)
  self:Init()
  binder:BindTimer(0.1, 0, nil, function()
    self.inDelayInit.value = true
  end)
  self:BindDialogUI(binder, self.avgModel)
  self:BindDialogEvent(binder, self.avgModel)
  binder:BindTimer(0.1, 0, nil, System.bind(self.avgModel.ClearFirstEnter, self))
  binder:BindToRaw(function(childBinder, index, _)
    self:OnActionChange(childBinder, index)
  end, function()
    return self.avgModel.actionIndex
  end, true)
  binder:BindToRaw(function(_, newDialogInfo, oldDialogInfo)
    self:OnBeforeNextChat(newDialogInfo, oldDialogInfo)
  end, function()
    do return self.avgModel.GetDialogInfo end
    return self.avgModel.GetDialogInfo, self.avgModel
  end, true)
  binder:BindToRaw(function(childBinder, value, old)
    if true == old and not value then
      childBinder:BindTimer(0.05, 0, nil, function()
        self:ResetPanelAnim()
      end)
      AudioManager.Instance:PostSoundEvent("Stop_All_Avg_Sound")
      for i, list in ipairs({
        self.avgModel.musicAudioList,
        self.avgModel.ambientAudioList
      }) do
        for _, v in ipairs(list) do
          self:PlaySoundEvent(v)
        end
      end
    end
  end, function()
    return self.avgModel.isLockedToJump
  end, true)
  self:InitUIBothSidesUI()
  self:CheckPermanentOnClose()
  binder:BindEvent(EventMgr.Instance.ReconnectSuccess, System.fn(self, self.OnReconnect))
end

function AvgDialogPanelNew:_GetNeedClickActions()
  return self.needClickActions
end

function AvgDialogPanelNew:_SetNeedClickActions(actionId, targetData)
  self.needClickActions[actionId] = targetData
end

function AvgDialogPanelNew:_ClearNeedClickActions()
  self.needClickActions = {}
end

function AvgDialogPanelNew:OnReconnect()
  print("avg on reconnect")
  self._isConnected = true
  AudioManager.Instance:PostSoundEvent("Stop_All_Avg_Sound")
  self:ReplayMusic()
end

function AvgDialogPanelNew:ReplayMusic()
  AudioManager.Instance:PostSoundEvent("Set_State_A_AVG")
  for i, list in ipairs({
    self.avgModel.musicAudioList
  }) do
    for _, v in ipairs(list) do
      self:PlaySoundEvent(v)
    end
  end
end

function AvgDialogPanelNew:CheckPermanentOnClose()
  local battleTid = BattleManager.Instance.battleTid
  local victoryStoryId = BattleManager.Instance:GetVictoryStoryId()
  local beginBattleStoryId = BattleManager.Instance:GetBeginBattleStoryId()
  if battleTid and beginBattleStoryId == self.avgModel.storyId then
    SceneMgr.Instance:SetPermanentUI(self.url)
    return
  end
  if battleTid and victoryStoryId == self.avgModel.storyId then
    SceneMgr.Instance:SetPermanentUI(self.url)
    return
  end
  if battleTid then
    local curStageComp = WorldStageManager.Instance:GetCurStageComp()
    if curStageComp then
      local endStageStoryId = curStageComp:GetEndStoryId()
      if endStageStoryId and endStageStoryId == self.avgModel.storyId then
        SceneMgr.Instance:SetPermanentUI(self.url)
        return
      end
    end
  end
end

function AvgDialogPanelNew:OnUnbind()
  TimeUtil.SetTimeScale(1)
  UIManager.Instance:CloseByUrl(Urls.AvgDialogHistoryPanel)
  UIManager.Instance:CloseByUrl(Urls.VideoCaptionPanel)
  if not self.avgModel.isSetGameName then
    AudioManager.Instance:PostSoundEvent("Stop_All_Avg_Sound")
  end
  ResLoadMgr.UnloadAssetByTarget(self)
  PopupQueManager.Instance:CancelBusy()
end

function AvgDialogPanelNew:InitTextComp()
  local textComp = AvgDialogTextComp(self.ui, self.binder, self.avgModel)
  textComp:SetFastModeAndPlaySpeed(self.isFastMode, self.playSpeed, self.isAuto)
  self.textComp = textComp
end

function AvgDialogPanelNew:ResetPanelAnim()
  self.ui.UI_jianbian_yty_vx_01:SetActive(false)
  self.ui.UI_jianbian_zl_vx_01:SetActive(false)
  self.ui.TransitionImg:SetActive(false)
end

function AvgDialogPanelNew:ShowGroupDialog()
  self.ui.Group_Dialog:SetActive(true)
end

function AvgDialogPanelNew:HideGroupDialog()
  self.ui.Group_Dialog:SetActive(false)
end

function AvgDialogPanelNew:GetIsRealPlay(storyId)
  if self.avgModel.storyId ~= storyId then
    return
  end
  if 1 == self.avgModel.chatIndex and self.avgModel.video then
    do return self.avgVideoComp.IsVideoPrepared, self.avgVideoComp end
    return self.avgVideoComp.IsVideoPrepared, self.avgVideoComp, self.avgModel.video
  end
  return true
end

function AvgDialogPanelNew:GetIsShowGroupDialog()
  local isShow = true
  if not self.inDelayInit.value then
    isShow = false
  end
  if self.isForceHideDialog.value then
    isShow = false
  end
  if self.avgModel:IsEnd() then
    local preActive = self.ui.Group_Dialog.activeSelf
    return preActive
  end
  if self.avgModel:IsCaption() then
    isShow = false
  end
  local dialogInfo = self.avgModel:GetDialogInfo()
  if 0 == dialogInfo.DialogAnim then
    isShow = false
  end
  if self.avgModel.video then
    isShow = false
  end
  return isShow
end

function AvgDialogPanelNew:OnActionChange(childBinder, actionIndex)
  if self.isEnding then
    return
  end
  local avgModel = self.avgModel
  if 1 == actionIndex then
    self:_ClearNeedClickActions()
  end
  if actionIndex > 1 and not self.avgModel:IsCaption() then
    self:ShowGroupDialog()
  end
  local actionIdList = avgModel:GetActionIdList()
  if not actionIdList then
    return
  end
  local actionData = avgModel:GetActionData()
  if table.next(actionData) then
    local waitList = {}
    for actionId, _ in pairs(actionData) do
      table.insert(waitList, actionId)
    end
    avgModel:SetWaitActionIdList(waitList)
    for _, actionId in ipairs(actionIdList) do
      local actionIdData = actionData[actionId]
      if not actionIdData then
        avgModel:FinishAction(actionId)
      else
        local action = self.avgActions[actionId]
        if avgModel:IsNeedClickActionId(actionId) then
          self:_SetNeedClickActions(actionId, {actionKeyData = actionIdData})
        else
          xpcall(function()
            action:DoAction(childBinder, actionIdData, function()
              avgModel:FinishAction(actionId)
            end)
          end, function(err)
            avgModel:FinishAction(actionId)
            local stack_trace = debug.traceback(err, 2)
            Logger.ReportApusInfo("AvgActionError {detail}", stack_trace)
          end)
        end
      end
    end
  else
    avgModel:NextActionIndex()
  end
end

function AvgDialogPanelNew:CheckDoClickActions()
  local needClickActions = self:_GetNeedClickActions()
  if table.next(needClickActions) then
    for actionKey, actionData in pairs(needClickActions) do
      local action = self.avgActions[actionKey]
      action:DoAction(self.binder, actionData.actionKeyData, function()
        self.avgModel:FinishAction(actionKey)
      end)
    end
    self:_ClearNeedClickActions()
    return true
  end
end

function AvgDialogPanelNew:OnBeforeNextChat(_, preDialogInfo)
  if preDialogInfo then
    UIManager.Instance:CloseByUrl(Urls.VideoCaptionPanel)
    self:PlayAudioManagerEvent(preDialogInfo.AudioManageEvent, CommonDefine.AvgAudioTime.End)
  end
end

function AvgDialogPanelNew:BindDialogEvent(binder, avgModel)
  binder:onDestroy(function()
    TimerManager.Instance:StopTimer(self.textPrintTimer)
  end)
  binder:BindToRaw(function(_, isEnd, _)
    if isEnd then
      EventMgr.Instance.OnStoryTail:Dispatch(avgModel.storyId)
    end
  end, function()
    do return self.avgModel.IsEnd end
    return self.avgModel.IsEnd, self.avgModel
  end)
  binder:BindEvent(EventMgr.Instance.SkipDialog, function()
    avgModel:SetClose()
    self.avgModel:JfStoryCommitEvent(CommonDefine.SdkJfStoryActionType.Jump)
  end)
  binder:BindToRaw(function(_, isEnd, _)
    if not isEnd then
      return
    end
    local isPlayingReview = StoryReviewModel.Instance:IsReviewingStory() and StoryReviewModel.Instance:ExistsStory()
    if not isPlayingReview and avgModel.isSetGameName then
      self:Close()
      return
    end
    self.isEnding = true
    if not isPlayingReview and avgModel:IsNoBgDialog() then
      self:Close()
      return
    end
    if self.avgModel.isSkipFadeOut then
      self:Close()
      return
    end
    local blackImg = self.ui.UI_jianbian_yty_vx_01:GetComponent(typeof(Image))
    if self.ui.UI_jianbian_yty_vx_01.activeSelf then
      self.uiAnimController:StopPlayableGraph()
    else
      self.ui.UI_jianbian_yty_vx_01:SetActive(true)
      local color = blackImg.color
      color.a = 0
      blackImg.color = color
    end
    AudioManager.Instance:PostSoundEvent("Stop_Avg_Mus")
    local fadeTime = CommonDefine.AvgConst.EndFadeTime
    if isPlayingReview then
      fadeTime = CommonDefine.AvgConst.ReviewEndFadeTime
    end
    blackImg:DOFade(1, fadeTime):OnComplete(function()
      self:Close()
    end)
  end, function()
    do return avgModel.IsEnd end
    return avgModel.IsEnd, avgModel
  end)
end

function AvgDialogPanelNew:BindDialogUI(binder, avgModel)
  self.ui.UI_Story_Popup_Role:SetActive(false)
  self.ui.Text_Content:SetActive(false)
  self.ui.Group_Name:SetActive(false)
  self.ui.AvgHeadIcon:SetActive(false)
  self.ui.Image_Dialog_Bg:SetActive(false)
  self:HideGroupDialog()
  local DialogType = CommonDefine.AvgDialogType
  binder:BindToVisible(self.ui.Group_Btn_Jump, function()
    return DataCenter.playerData.isClickGmAvg
  end)
  binder:BindToVisible(self.ui.Image_Auto_Icon, function()
    return not self.isAuto.value
  end)
  binder:BindToVisible(self.ui.AvgDialogBg, function()
    return avgModel.bgId ~= nil
  end)
  binder:BindToVisible(self.ui.Image_Dialog_Bg, function()
    if avgModel:IsEnd() then
      local curVisible = self.ui.Image_Dialog_Bg.activeSelf
      return curVisible
    end
    local isShow = true
    local isCaption = avgModel:IsCaption()
    local isAvgNovel = avgModel:IsAvgNovel()
    local isRadioDrama = avgModel:IsRadioDrama()
    local isShowDiag = self:GetIsShowGroupDialog()
    if isCaption or isAvgNovel or isRadioDrama or not isShowDiag then
      isShow = false
    end
    if self.isManualHideDialog.value then
      isShow = false
    end
    return isShow
  end)
  binder:BindToVisible(self.ui.UI_Story_Popup_Role, function()
    return not avgModel:IsCaption()
  end)
  binder:BindToVisible(self.ui.Group_Caption, function()
    do return avgModel.IsDialogType, avgModel end
    return avgModel.IsDialogType, avgModel, DialogType.CaptionDialog
  end)
  binder:BindToVisible(self.ui.Group_Caption2, function()
    return avgModel:IsDialogType(DialogType.CaptionDialogWhite) and self.inDelayInit.value
  end)
  binder:BindToVisible(self.ui.Text_Content, function()
    return not avgModel:IsCaption()
  end)
  binder:BindToRaw(function(_, isShow)
    if avgModel:IsEnd() then
      local curVisible = self.ui.Image_Dialog_Bg.activeSelf
      self.ui.Image_Dialog_Bg:SetActive(curVisible)
    end
    self.ui.UI_Story_Popup_Role:SetActive(isShow)
    if not isShow then
      self.textComp:ClearDialogText()
    end
  end, function()
    do return self.GetIsShowGroupDialog end
    return self.GetIsShowGroupDialog, self
  end, true)
  binder:BindToRaw(function(_, newChatIndex)
    if 1 == newChatIndex and self.avgModel.video then
      self.ui.Image_Mask:SetActive(false)
    end
  end, function()
    return self.avgModel.chatIndex
  end)
  binder:BindToRaw(function(_, isShow)
    EventMgr.Instance.BattleBottomUI:Dispatch(isShow)
  end, function()
    local info = self.avgModel:GetDialogInfo()
    local hasTimeLine = info.TimelineParam ~= nil
    local isTransparent = avgModel.bgId == CommonDefine.TransparentBG
    local isNil = nil == avgModel.bgId
    local isShow = not hasTimeLine and not isTransparent and not isNil
    return isShow
  end)
  binder:BindToRaw(function(_, isShow)
    self.ui.Image_Mask:SetActive(isShow)
  end, function()
    local info = self.avgModel:GetDialogInfo()
    local hasTimeLine = info.TimelineParam ~= nil
    local isTransparent = avgModel.bgId == CommonDefine.TransparentBG
    return not isTransparent and not hasTimeLine
  end)
  binder:SetText(self.ui.Text_Content, "")
  self:_HandleReivewStoryBg()
end

function AvgDialogPanelNew:_HandleReivewStoryBg()
  local grabPassRawImage = self.ui.Image_Mask:GetComponent(Type_UIGrabPassRawImage)
  if not grabPassRawImage then
    return
  end
  if StoryReviewModel.Instance:IsStoryReviewingById(self.storyId) then
    grabPassRawImage.enabled = false
    local rawImage = self.ui.Image_Mask:GetComponent(T_RawImage)
    rawImage.texture = ResLoadMgr.LoadAsset(CommonRes.CommonBlackTex, self, CsTexture2D)
    rawImage.enabled = true
  else
    grabPassRawImage.enabled = true
  end
end

function AvgDialogPanelNew:PlayDialogAudio(dialogInfo)
  if not dialogInfo then
    return
  end
  self:PlayAudioManagerEvent(dialogInfo.AudioManageEvent, CommonDefine.AvgAudioTime.Start)
  self:PlayAudioList(dialogInfo.ShortAudioEffect)
  self:PlayAudioList(dialogInfo.Audio)
  self:PlayAudioList(dialogInfo.AudioTalk)
  self:PlayAudioList(dialogInfo.AudioAmbient)
  if StoryReviewModel.Instance:IsReviewingStory() and StoryReviewModel.Instance:IsStoryReviewingById(self.storyId) then
    FrameWaiter.OnNextFrame(function()
      AudioManager.Instance:PostSoundEvent("Set_State_A_AVG")
    end)
  end
end

function AvgDialogPanelNew:PlayAudioList(audioList)
  if not audioList then
    return
  end
  for i = 1, #audioList do
    local audioEvent = audioList[i]
    local checkIsDelay = audioList[i + 1]
    if not tonumber(audioEvent) then
      if tonumber(checkIsDelay) then
        self:PlaySoundEvent(audioEvent, tonumber(checkIsDelay))
      else
        self:PlaySoundEvent(audioEvent)
      end
    end
  end
end

function AvgDialogPanelNew:PlaySoundEvent(audioEvent, delay)
  local male_audio = "_Me_Male_"
  local female_audio = "_Me_Female_"
  if PlayerDataUtils.IsMale() then
    audioEvent = string.replace(audioEvent, female_audio, male_audio, true)
  else
    audioEvent = string.replace(audioEvent, male_audio, female_audio, true)
  end
  if tonumber(delay) then
    delay = delay / self.funcBtnComp:GetTimeScale()
  end
  AudioManager.Instance:PostSoundEvent(audioEvent, nil, tonumber(delay))
  if string.startswith(audioEvent, "VOC_AVG_") then
    local dura = AudioManager.Instance:GetEventLength(audioEvent)
    if dura then
      local voiceEndTime = os.time() + dura + (tonumber(delay) or 0) / 1000
      self._voiceEndTime = math.max(self._voiceEndTime or 0, voiceEndTime)
    end
  end
end

function AvgDialogPanelNew:GetVoiceEndTs()
  return self._voiceEndTime or 0
end

function AvgDialogPanelNew:PlayAudioManagerEvent(events, playTime)
  if not events then
    return
  end
  local copy = table.clone(events)
  local cfgPlayTime = tonumber(events[#events])
  if nil ~= cfgPlayTime then
    table.remove(copy, #copy)
  end
  cfgPlayTime = cfgPlayTime or CommonDefine.AvgAudioTime.Start
  if cfgPlayTime == playTime then
    self:PlayAudioList(copy)
  end
end

function AvgDialogPanelNew:ShowSkipBtnInVideo()
end

function AvgDialogPanelNew:Close()
  self.isPlaying = false
  self.avgModel:CloseDispatchEvent()
  if SceneMgr.Instance:IsPermanentUI(self.url) then
    return
  end
  Super.Close(self)
end

function AvgDialogPanelNew:ShakeDialog()
  self.uiAnimController:PlayState("UI_Story_Panel_Group_Dialog_doudong_vx")
end

function AvgDialogPanelNew:PushBackCommand()
  UIBackCommandStack.Push({
    uiPanel = self,
    Execute = function()
      EventMgr.Instance.OnStoryTail:Dispatch(self.storyId)
      self:Close()
    end
  })
end

function AvgDialogPanelNew:RefeshUIQueue()
  if SceneMgr.Instance:IsInTown() then
    local curScene = SceneMgr.Instance:GetCurScene()
    if curScene and curScene.Clear then
      curScene:Clear()
    end
    UIManager.Instance:ClearSceneOpenUIQueue(CommonDefine.SceneType.Town)
    if UIManager.Instance.GetWindow(Urls.PopAchievementTips) then
      UIManager.Instance.CloseByUrl(Urls.PopAchievementTips)
    end
  end
end

function AvgDialogPanelNew:InitUIBothSidesUI(_)
  local leftUIGroup = {
    [self.ui.DialogMenuPanelLeft] = 0
  }
  local rightUIGroup = {
    [self.ui.DialogMenuPanel] = 0
  }
  leftUIGroup, rightUIGroup = UIManager.Instance:InitBothSidesUIOriPos(leftUIGroup, rightUIGroup)
  UIManager.Instance:UIBothSidesAdaptation(leftUIGroup, rightUIGroup, CommonDefine.BothSideUILimitDeltaLen.AvgDialogPanelNew)
end

return AvgDialogPanelNew
