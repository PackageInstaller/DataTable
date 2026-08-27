local UINHomeLeft = class("UINHomeLeft", UIBaseNode)
local base = UIBaseNode
local UINHomeBanner = require("Game.Home.Banner.UINHomeBanner")
local HomeBannerManager = require("Game.Home.Banner.HomeBannerManager")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local UINHomeGeneralBtn = require("Game.Home.UI.UINHomeGeneralBtn")
local ChatSystemEnum = require("Game.ChatSystem.ChatSystemEnum")
local TaskEnum = require("Game.Task.TaskEnum")
local CS_Ease = CS.DG.Tweening.Ease
local CS_ClientConsts = CS.ClientConsts
local CS_MessageCommon = CS.MessageCommon
local CS_Time = CS.UnityEngine.Time

function UINHomeLeft:OnInit()
  self.live2dViewReturnBtnHideTime = 0
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.resloader = CS.ResLoader.Create()
  UIUtil.AddButtonListenerWithArg(self.ui.btn_HideUI, self, self.SwitchHeroViewMode, true)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_ShowMain, self, self.SwitchHeroViewMode, false)
  UIUtil.AddButtonListener(self.ui.btn_live2dViewMask, self, self.ShowBtnForShowMainUI)
  UIUtil.AddButtonListener(self.ui.btn_SelectBoardHero, self, self.OnClickChangeAdjutantBtn)
  UIUtil.AddButtonListener(self.ui.btn_Task, self, self.OnClickTask)
  UIUtil.AddButtonListener(self.ui.btn_QuickTaskGet, self, self.OnQuickTaskGetBtn)
  UIUtil.AddButtonListener(self.ui.btn_HomeSide, self, self.OnClickHomeSide)
  UIUtil.AddButtonListener(self.ui.btn_Chat, self, self.OnClickHomeChat)
  UIUtil.AddButtonListener(self.ui.btn_Friend, self, self.OnClickFriend)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_Novice, self, self.OnClickActivity, ActivityFrameEnum.eActivityEnterType.Novice)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_Limited, self, self.OnClickActivity, ActivityFrameEnum.eActivityEnterType.LimitTime)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_SpEvent, self, self.OnClickActivity, ActivityFrameEnum.eActivityEnterType.Comeback)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_LukcyBag, self, self.OnClickActivity, ActivityFrameEnum.eActivityEnterType.KeyExertion)
  self._OnKeyExertionTokenItemChangeFunc = BindCallback(self, self.__RefreshKeyExertion)
  MsgCenter:AddListener(eMsgEventId.ActivityKeyExertionTokenNumChange, self._OnKeyExertionTokenItemChangeFunc)
  self.__onTaskCommitComplete = BindCallback(self, self.OnTaskCommitComplete)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__onTaskCommitComplete)
  self.__onTaskPeroidCommit = BindCallback(self, self.OnTaskPeroidCommit)
  MsgCenter:AddListener(eMsgEventId.PeroidCommitComplete, self.__onTaskPeroidCommit)
  self.__RefreshActivityShow = BindCallback(self, self.RefreshActivityShow)
  MsgCenter:AddListener(eMsgEventId.ActivityShowChange, self.__RefreshActivityShow)
  self.__RefreshHomeChatBtnShow = BindCallback(self, self.RefreshHomeChatBtnShow)
  MsgCenter:AddListener(eMsgEventId.OnNewChatMsgCome, self.__RefreshHomeChatBtnShow)
  MsgCenter:AddListener(eMsgEventId.OnChatBoardNewMsgNumChange, self.__RefreshHomeChatBtnShow)
  MsgCenter:AddListener(eMsgEventId.OnChatSystemBanChange, self.__RefreshHomeChatBtnShow)
  self.ui.voiceScrollRect.gameObject:SetActive(false)
  self.ui.ani_VoiceIcon:SetActive(false)
  self:RefreshBannerWidget()
end

function UINHomeLeft:InitHomeLeftNode(homeUI)
  self.homeUI = homeUI
  self.homeController = homeUI.homeController
  self:RegistTaskRedDot()
  self:RegistSideRedDot()
  self:RegistActivityRedDot()
  self:RefreshAdjBtn()
end

function UINHomeLeft:OnHomeShow()
  self:RefreshTaskBtn()
  self:RefreshActivityShow()
  self:RefreshHomeChatBtnShow()
  self:RefreshFriendBtn()
  self:RefreshAdjBtn()
end

function UINHomeLeft:OnUpdate()
  local deltaTime = CS_Time.deltaTime
  self:UpdateHeroViewReturnBtn(deltaTime)
  self:UpdateCVDialog(deltaTime)
  if not bool then
    PlayerClickCollectManager:BtnClickNumCollect(1009)
  end
end

function UINHomeLeft:SwitchHeroViewMode(IsSwitchToHeroView)
  if self.__OnUpdate ~= nil then
    UpdateManager:RemoveUpdate(self.__OnUpdate)
  else
    self.__OnUpdate = BindCallback(self, self.OnUpdate)
  end
  if IsSwitchToHeroView then
    UpdateManager:AddUpdate(self.__OnUpdate)
    if self.homeUI.__isUnfold then
      self.homeUI:SwitchUnfold()
    end
    self.readySwitchToHeroView = true
  else
    UpdateManager:RemoveUpdate(self.__OnUpdate)
    self:RealSetActiveHeroView(false)
  end
  self:SwitchDialog(IsSwitchToHeroView)
  self.ui.btn_live2dViewMask.gameObject:SetActive(IsSwitchToHeroView)
  self.ui.BlockMask:SetActive(true)
  self.ui.btn_ShowMain.gameObject:SetActive(false)
end

function UINHomeLeft:IsHeroViewMode()
  if IsNull(self.ui.btn_live2dViewMask) then
    return false
  end
  return self.ui.btn_live2dViewMask.gameObject.activeInHierarchy
end

function UINHomeLeft:RealSetActiveHeroView(IsSwitchToHeroView)
  self.homeUI:SetHomeShowMainUI(not IsSwitchToHeroView)
  self.homeUI.homeAdjutant.heroCubismInteration:SetUIPenetration(IsSwitchToHeroView)
  if IsSwitchToHeroView then
    self.live2dViewReturnBtnHideTime = self.ui.live2dViewReturnBtnHideTimeLimit
    self.ui.btn_ShowMain.gameObject:SetActive(true)
    self.ui.cg_ShowMain.alpha = 1
    self.ui.BlockMask:SetActive(false)
  end
end

function UINHomeLeft:SwitchDialog(IsSwitchToHeroView)
  local isHideDialog = PlayerDataCenter.allAdjCustomData:IsHideText()
  if isHideDialog then
    return
  end
  if IsSwitchToHeroView then
    if not self:IsShowCVDialog() then
      self.ui.cg_Dialog.alpha = 0
    end
    self.ui.tex_Dialog.transform.parent:SetParent(self.transform.parent)
    self.ui.btn_HomeSide.gameObject:SetActive(false)
  else
    self.ui.cg_Dialog.alpha = 1
    self.ui.tex_Dialog.transform.parent:SetParent(self.transform)
    self.ui.btn_HomeSide.gameObject:SetActive(true)
    if not self:IsShowCVDialog() then
      self.ui.tex_Dialog.gameObject:SetActive(true)
    end
  end
end

function UINHomeLeft:ShowBtnForShowMainUI()
  if not self.ui.btn_ShowMain.gameObject.activeInHierarchy then
    self.ui.btn_ShowMain.gameObject:SetActive(true)
    self.ui.cg_ShowMain.alpha = 0
  end
  self.live2dViewReturnBtnHideTime = self.ui.live2dViewReturnBtnHideTimeLimit
end

function UINHomeLeft:UpdateHeroViewReturnBtn(deltaTime)
  if self.ui == nil or IsNull(self.ui.btn_ShowMain) or IsNull(self.ui.cg_ShowMain) then
    return
  end
  if not self.ui.btn_live2dViewMask.gameObject.activeInHierarchy then
    return
  end
  if not self.homeUI:IsHomeRightRealyCompleteFold() then
    return
  elseif self.readySwitchToHeroView then
    self:RealSetActiveHeroView(true)
    self.readySwitchToHeroView = false
  end
  local alphaHideSpeed = self.ui.alphaHideSpeed
  local alphaShowSpeed = self.ui.alphaShowSpeed
  if self.live2dViewReturnBtnHideTime > 0 then
    self.live2dViewReturnBtnHideTime = self.live2dViewReturnBtnHideTime - deltaTime
  end
  local originAlpha = self.ui.cg_ShowMain.alpha
  local alpha = originAlpha
  if self.live2dViewReturnBtnHideTime < 0 then
    if 0 < alpha then
      alpha = alpha - deltaTime * alphaHideSpeed
    end
  elseif alpha < 1 then
    alpha = alpha + deltaTime * alphaShowSpeed
  end
  alpha = math.clamp(alpha, 0, 1)
  if (0 < alpha or alpha <= 1) and alpha ~= originAlpha then
    self.ui.cg_ShowMain.alpha = alpha
  end
  if alpha <= 0 then
    self.ui.btn_ShowMain.gameObject:SetActive(false)
  end
end

function UINHomeLeft:UpdateCVDialog(deltaTime)
  if not self:IsHeroViewMode() then
    return
  end
  local isHideDialog = PlayerDataCenter.allAdjCustomData:IsHideText()
  if isHideDialog then
    return
  end
  local alphaHideSpeed = self.ui.alphaHideSpeed
  local alphaShowSpeed = self.ui.alphaShowSpeed
  if self.live2dViewReturnBtnHideTime > 0 then
    self.live2dViewReturnBtnHideTime = self.live2dViewReturnBtnHideTime - deltaTime
  end
  local originAlpha = self.ui.cg_Dialog.alpha
  local alpha = originAlpha
  if self:IsShowCVDialog() then
    if alpha < 1 then
      alpha = alpha + deltaTime * alphaShowSpeed
    end
  elseif 0 < alpha then
    alpha = alpha - deltaTime * alphaHideSpeed
  end
  alpha = math.clamp(alpha, 0, 1)
  if (0 <= alpha or alpha <= 1) and alpha ~= originAlpha then
    self.ui.cg_Dialog.alpha = alpha
  end
end

function UINHomeLeft:ShowHeroVoiceText(show, text, notShowWave, voiceDuration)
  self.ui.voiceScrollRect:DOKill()
  if self._heroVoiceTextTimerId ~= nil then
    TimerManager:StopTimer(self._heroVoiceTextTimerId)
    self._heroVoiceTextTimerId = nil
  end
  if show then
    self.ui.tex_Voice.text = text
    self.ui.voiceScrollRect.verticalNormalizedPosition = 1
    self._heroVoiceTextTimerId = TimerManager:StartTimer(1, function()
      self._heroVoiceTextTimerId = nil
      if voiceDuration <= 0 or self.ui.tex_Voice.transform.rect.height <= self.ui.voiceScrollRect.transform.rect.height then
        return
      end
      local duration = voiceDuration * 0.8
      local delay = voiceDuration * 0.1
      self.ui.voiceScrollRect:DOVerticalNormalizedPos(0, duration):SetLink(self.ui.voiceScrollRect.gameObject):SetDelay(delay):SetEase(CS_Ease.Linear)
    end, nil, true, true, true)
  end
  self.ui.ani_VoiceIcon:SetActive(show and not notShowWave)
  self.ui.voiceScrollRect.gameObject:SetActive(show)
  local isHeroViewMode = self:IsHeroViewMode()
  self.ui.tex_Dialog.gameObject:SetActive(not show and not isHeroViewMode)
end

function UINHomeLeft:IsShowCVDialog()
  if IsNull(self.ui.voiceScrollRect) then
    return false
  end
  return self.ui.voiceScrollRect.gameObject.activeInHierarchy
end

function UINHomeLeft:RefreshActivityShow()
  local activityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  self.ui.btn_Novice.gameObject:SetActive(activityCtrl:IsHaveShowByEnterType(ActivityFrameEnum.eActivityEnterType.Novice))
  self.ui.btn_Limited.gameObject:SetActive(activityCtrl:IsHaveShowByEnterType(ActivityFrameEnum.eActivityEnterType.LimitTime))
  if not CS_ClientConsts.IsAudit then
    self.ui.btn_SpEvent.gameObject:SetActive(activityCtrl:IsHaveShowByEnterType(ActivityFrameEnum.eActivityEnterType.Comeback))
  else
    self.ui.btn_SpEvent.gameObject:SetActive(false)
  end
  self.ui.btn_LukcyBag.gameObject:SetActive(activityCtrl:IsHaveShowByEnterType(ActivityFrameEnum.eActivityEnterType.KeyExertion))
  self:__RefreshComebackEntryText()
  self:__RefreshComebackTime()
  self:__RefreshKeyExertion()
end

function UINHomeLeft:OnClickActivity(enterType, activityId)
  if ControllerManager:GetController(ControllerTypeId.HomeController).isRunningAutoShow then
    return
  end
  if enterType == ActivityFrameEnum.eActivityEnterType.Comeback then
    local comebackController = ControllerManager:GetController(ControllerTypeId.ActivityComeback, true)
    local comebackData = comebackController:GetTheLatestComebackData()
    UIManager:ShowWindowAsync(comebackData:GetComebackWindowId(), function(window)
      if window ~= nil then
        self.homeUI:OpenOtherWin()
        window:SetFromWhichUI(eBaseWinFromWhere.home)
        window:InitActivityCombackMain(activityId)
      end
    end)
    return
  end
  if enterType == ActivityFrameEnum.eActivityEnterType.KeyExertion then
    local keyExertionController = ControllerManager:GetController(ControllerTypeId.ActivityKeyExertion, true)
    local keyExertionData = keyExertionController:GetTheLatestKeyExertionData()
    if keyExertionData == nil then
      return
    end
    keyExertionController:OpenKeyExertion(keyExertionData:GetActId(), function(window)
      if window ~= nil then
        self.homeUI:OpenOtherCoverWin()
        window:SetFromWhichUI(eBaseWinFromWhere.homeCorver)
      end
    end)
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivityFrameMain, function(window)
    if window ~= nil then
      self.homeUI:OpenOtherWin()
      window:SetFromWhichUI(eBaseWinFromWhere.home)
      window:InitFrameMain(enterType, activityId)
    end
  end)
end

function UINHomeLeft:OnClickHomeSide()
  if self.sideWin == nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.HomeSide, function(win)
      if win ~= nil then
        self.sideWin = win
        self.sideWin:InitSide(self.homeUI)
        self.sideWin:OpenSide()
      end
    end)
  else
    self.sideWin:OpenSide()
  end
end

function UINHomeLeft:OnClickTask(taskTypeID)
  local taskController = ControllerManager:GetController(ControllerTypeId.Task, false)
  if taskController == nil then
    error("get taskController error")
    return
  end
  taskController:ShowTaskUI(taskTypeID, eBaseWinFromWhere.home, function(win)
    win:SetFromWhichUI(eBaseWinFromWhere.home)
    self.homeUI:OpenOtherWin()
  end)
end

function UINHomeLeft:RefreshAdjBtn()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_MainPreset_ui)
  self.ui.btn_SelectBoardHero.gameObject:SetActive(isUnlock)
end

function UINHomeLeft:OnClickChangeAdjutantBtn()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_MainPreset_ui) then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.AdjPreset, function(window)
    if window == nil then
      return
    end
    self.homeUI.homeAdjutant:RecordCurCubismHeroId()
    window:InitAdjPreset(function()
      if self.homeUI.homeAdjutant:IsChangeCubismHero() and not GuideManager.inGuide then
        self.homeController:PlayLoginHeroGreeting()
      end
      self.homeUI.homeAdjutant:ClearCurCubismHeroRecord()
    end)
    window:SetFromWhichUI(eBaseWinFromWhere.home)
  end)
  PlayerClickCollectManager:BtnClickNumCollect(1010)
end

function UINHomeLeft:RefreshHomeChatBtnShow()
  local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  local isForceBlocked = userChatCtrl:GetIsChatSystemForceBlocked()
  local isUnlock, unlockDes = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_newchat)
  if not userChatCtrl:GetIsChatSystemCanShow() then
    self.ui.btn_Chat.gameObject:SetActive(false)
  end
  self.ui.obj_chatLock:SetActive(not isUnlock or isForceBlocked)
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  self.ui.redDot_chat:SetActive(false)
  for _, chatRecentMsg in ipairs(userChatData:GetChatRecents()) do
    local chatBoard = userChatData:GetChatBoard(chatRecentMsg.chatTpe, chatRecentMsg.chatId)
    if chatBoard:GetNewChatNum() > 0 then
      self.ui.redDot_chat:SetActive(true)
      break
    end
  end
end

function UINHomeLeft:OnClickHomeChat()
  local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  if not userChatCtrl:GetIsChatSystemUnlock() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ChatSystem, function(win)
    if win == nil then
      return
    end
    local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
    local startOpenPageId, startOpenChatBoard
    local chatRecentMsgs = userChatData:GetChatRecents()
    for _, chatRecentMsg in ipairs(chatRecentMsgs) do
      local chatBoard = userChatData:GetChatBoard(chatRecentMsg.chatTpe, chatRecentMsg.chatId)
      if chatBoard:GetNewChatNum() > 0 then
        startOpenPageId = ChatSystemEnum.EChatChannel.Recent
        startOpenChatBoard = chatBoard
        break
      end
    end
    win:InitChatSystem(startOpenPageId, startOpenChatBoard)
  end)
end

function UINHomeLeft:RefreshFriendBtn()
  if CS_ClientConsts.IsAudit then
    self.ui.btn_Friend.gameObject:SetActive(false)
    return
  end
  if self.friendBtn == nil then
    self.friendBtn = UINHomeGeneralBtn.New()
    self.friendBtn:Init(self.ui.btn_Friend.gameObject)
    self.homeController:AddRedDotEvent(self.friendBtn:GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.UserFriend)
  end
  local isUnlock, unlockDes = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Friend)
  self.friendBtn:RefeshUnlockInfo(isUnlock, unlockDes)
  if self.friendBtn ~= nil then
    local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local frameDataTable = actFrameCtrl:GetShowByActType(ActivityFrameEnum.eActivityType.DormFight)
    if frameDataTable == nil then
      self.friendBtn.ui.obj_Tag:SetActive(false)
      return
    end
    for actId, isOpen in pairs(frameDataTable) do
      if isOpen == false then
        self.friendBtn.ui.obj_Tag:SetActive(false)
        return
      end
    end
  end
end

function UINHomeLeft:OnClickFriend()
  if not self.friendBtn.isUnlock then
    self.friendBtn:ShowUnlockDes()
    return
  end
  if not PlayerDataCenter.friendDataCenter:IsFriendDataCenterInited() then
    return
  end
  local friendNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
  friendNetCtrl:CS_FRIEND_RefreshFriend()
  UIManager:ShowWindowAsync(UIWindowTypeID.UserFreined, function(win)
    if win ~= nil then
      self.homeUI:OpenOtherWin()
      win:SetFromWhichUI(eBaseWinFromWhere.home)
      win:InitUserFriend()
    end
  end)
end

function UINHomeLeft:RefreshBannerWidget()
  self.ui.obj_advTv:SetActive(false)
  self:AdjutantBtn2Banner(false)
  HomeBannerManager:RefreshBannerDataList(function(bannerDataList)
    if IsNull(self.gameObject) then
      return
    end
    if bannerDataList ~= nil and 0 < #bannerDataList then
      if self.bannerUI == nil then
        self.bannerUI = UINHomeBanner.New()
        self.bannerUI:Init(self.ui.obj_advTv)
      end
      self.bannerUI:Show()
      self.bannerUI:InitialHomeBanner(bannerDataList)
      self:AdjutantBtn2Banner(true)
    else
      self.ui.obj_advTv:SetActive(false)
      self:AdjutantBtn2Banner(false)
    end
  end)
end

function UINHomeLeft:AdjutantBtn2Banner(hasBanner)
  if self.hasBanner == hasBanner then
    return
  end
  self.hasBanner = hasBanner
  local MoveX = Vector3.zero
  if hasBanner then
    MoveX = Vector3.New(514.475, 0, 0)
  else
    MoveX = Vector3.New(-514.475, 0, 0)
  end
  local hidePos = self.ui.btn_HideUI.transform.localPosition
  self.ui.btn_HideUI.transform.localPosition = MoveX + hidePos
  local boardHeroPos = self.ui.btn_SelectBoardHero.transform.localPosition
  self.ui.btn_SelectBoardHero.transform.localPosition = MoveX + boardHeroPos
end

function UINHomeLeft:RegistTaskRedDot()
  self.homeController:AddRedDotEvent(function(num)
    self.ui.task_obj_RedDot:SetActive(0 < num)
  end, RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
end

function UINHomeLeft:RegistSideRedDot()
  self.homeController:AddRedDotEvent(function(num)
    self.ui.side_obj_RedDot.gameObject:SetActive(0 < num)
    if num < 10 then
      self.ui.tex_sideRedDotNum.gameObject:SetActive(true)
      self.ui.tex_sideRedDotNum.text = tostring(num)
      self.ui.side_obj_RedDot:SetIndex(0)
    else
      self.ui.tex_sideRedDotNum.gameObject:SetActive(false)
      self.ui.side_obj_RedDot:SetIndex(1)
    end
    if 0 < num then
      self.ui.tex_Dialog:SetIndex(2)
    else
      self.ui.tex_Dialog:SetIndex(1)
    end
  end, RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide)
end

function UINHomeLeft:RegistActivityRedDot()
  self.homeController:AddRedDotEvent(function(num)
    self.ui.redDot_activity_novice:SetActive(0 < num)
  end, RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityInHome, RedDotStaticTypeId.ActivityFrameNovice)
  self.homeController:AddRedDotEvent(function(num)
    self.ui.redDot_activity_limitTime:SetActive(0 < num)
  end, RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityInHome, RedDotStaticTypeId.ActivityFrameLimitTime)
  self.homeController:AddRedDotEvent(function(num)
    self.ui.redDot_comeback:SetActive(0 < num)
  end, RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityInHome, RedDotStaticTypeId.ActivityComeback)
  self.homeController:AddRedDotEvent(function(num)
    self.ui.redDot_luckyBag:SetActive(0 < num)
  end, RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityInHome, RedDotStaticTypeId.ActivityKeyExertion)
end

function UINHomeLeft:OnQuickTaskGetBtn()
  if self.__quickTaskData == nil then
    return
  end
  local taskController = ControllerManager:GetController(ControllerTypeId.Task)
  if taskController ~= nil then
    local taskIds = {
      TaskEnum.eTaskType.MainTask,
      TaskEnum.eTaskType.DailyTask,
      TaskEnum.eTaskType.WeeklyTask,
      TaskEnum.eTaskType.LargeActivityTask,
      TaskEnum.eTaskType.HeroActivityTask
    }
    local ids, perodicDic = taskController:GetAllRewards(taskIds)
    if table.count(ids) >= 1 then
      taskController:SendOneKeyPick(ids)
    end
    if table.count(perodicDic) > 0 then
      for type, dic in pairs(perodicDic) do
        taskController:SendCommitTaskPeriodArray(dic, type)
      end
    end
    return
  end
  if self.__quickIsPeroid then
    ControllerManager:GetController(ControllerTypeId.Task, true):SendCommitTaskPeriod(self.__quickTaskData.stcData.id, self.__quickTaskData.stcData.type)
  else
    local isTaskCompelete = self.__quickTaskData:CheckComplete()
    if not isTaskCompelete then
      return
    end
    ControllerManager:GetController(ControllerTypeId.Task, true):SendCommitQuestReward(self.__quickTaskData)
  end
end

function UINHomeLeft:RefreshTaskBtn()
  local isUnlock = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi)
  self.ui.btn_Task.gameObject:SetActive(isUnlock)
  if not isUnlock then
    return
  end
  local taskData, isTaskCompelete, isPeroid = PlayerDataCenter.allTaskData:GetTaskData4Home()
  self.__quickTaskData = taskData
  self.__quickIsPeroid = isPeroid
  if taskData == nil then
    self.ui.tex_TaskInfo:SetIndex(1)
    self.ui.btn_QuickTaskGet.gameObject:SetActive(false)
    return
  end
  self.ui.btn_QuickTaskGet.gameObject:SetActive(isTaskCompelete)
  if self.__quickIsPeroid then
    local infoContent = ""
    local strbase = LanguageUtil.GetLocaleText(ConfigData:GetTipTag(TipTag.questsTag, self.__quickTaskData.stcData.type))
    if not string.IsNullOrEmpty(strbase) then
      infoContent = string.format(strbase, self.__quickTaskData.stcData.id)
    else
      warn("task type is not a period,type:" .. tostring(self.__quickTaskData.stcData.type) .. " local_text_id:" .. tostring(ConfigData.game_config.taskPeroidInfo[self.__quickTaskData.stcData.type]))
    end
    self.ui.tex_TaskInfo:SetIndex(0, infoContent)
  elseif taskData.schedule <= taskData.aim then
    self.ui.tex_TaskInfo:SetIndex(0, taskData:GetTaskFirstStepIntro())
    return
  end
end

function UINHomeLeft:OnTaskCommitComplete(taskStcData)
  if self.__quickIsPeroid then
    return
  end
  if self.__quickTaskData == nil or taskStcData == nil then
    return
  end
  if self.__quickTaskData.id == taskStcData.id then
    self:RefreshTaskBtn()
  end
end

function UINHomeLeft:OnTaskPeroidCommit(peroidData)
  if not self.__quickIsPeroid then
    return
  end
  if self.__quickTaskData == peroidData then
    self:RefreshTaskBtn()
  end
end

function UINHomeLeft:__RefreshKeyExertion(tokenId)
  local keyExertionCtrl = ControllerManager:GetController(ControllerTypeId.ActivityKeyExertion)
  if keyExertionCtrl == nil then
    return
  end
  local keyExertionData = keyExertionCtrl:GetTheLatestKeyExertionData()
  if keyExertionData == nil then
    return
  end
  local destroyTm = keyExertionData:GetActivityDestroyTime()
  if destroyTm <= PlayerDataCenter.timestamp then
    return
  end
  local currentTokenId = keyExertionData:GetKeyExertionTokenId()
  if tokenId ~= nil and tokenId ~= currentTokenId then
    return
  end
  self.ui.img_LukcyBag.texture = self.resloader:LoadABAsset(PathConsts:GetActivityKeyExertionPath(keyExertionData:GetKeyExertionMainCfg().enter_picture))
  self.ui.img_Icon.sprite = CRH:GetSpriteByItemId(currentTokenId)
  self.ui.tex_Count:SetIndex(0, tostring(keyExertionData:GetKeyExertionPackageFragmentNum()), tostring(keyExertionData:GetKeyExertionPackageFragmentMaxNum()))
  self.ui.tex_Name.text = keyExertionData.actInfo.name
end

function UINHomeLeft:__RefreshComebackEntryText()
  local comebackCtrl = ControllerManager:GetController(ControllerTypeId.ActivityComeback)
  if comebackCtrl == nil then
    return
  end
  local comebackData = comebackCtrl:GetTheLatestComebackData()
  if comebackData == nil then
    return
  end
  local destroyTm = comebackData:GetActivityDestroyTime()
  if destroyTm <= PlayerDataCenter.timestamp then
    return
  end
  self.ui.tex_comebackText.text = comebackData:GetComebackEntryText()
end

function UINHomeLeft:__RefreshComebackTime()
  if self._comebackTimerId ~= nil then
    TimerManager:StopTimer(self._comebackTimerId)
    self._comebackTimerId = nil
  end
  local comebackCtrl = ControllerManager:GetController(ControllerTypeId.ActivityComeback)
  if comebackCtrl == nil then
    return
  end
  local comebackData = comebackCtrl:GetTheLatestComebackData()
  if comebackData == nil then
    return
  end
  local destroyTm = comebackData:GetActivityDestroyTime()
  if destroyTm <= PlayerDataCenter.timestamp then
    return
  end
  
  local function Local_TimeFunc()
    local diffTime = destroyTm - PlayerDataCenter.timestamp
    if diffTime <= 0 then
      if self._comebackTimerId ~= nil then
        TimerManager:StopTimer(self._comebackTimerId)
        self._comebackTimerId = nil
      end
      self.ui.tex_Comeback_Time:SetIndex(2, "0")
      return
    end
    if diffTime < 3600 then
      self.ui.tex_Comeback_Time:SetIndex(2, tostring(math.floor(diffTime / 60)))
    elseif diffTime < 86400 then
      self.ui.tex_Comeback_Time:SetIndex(1, tostring(math.floor(diffTime / 3600)))
    else
      self.ui.tex_Comeback_Time:SetIndex(0, tostring(math.floor(diffTime / 86400)))
    end
  end
  
  self._comebackTimerId = TimerManager:StartTimer(1, Local_TimeFunc, nil, false)
  Local_TimeFunc()
end

function UINHomeLeft:OnDelete()
  if self.sideWin ~= nil then
    self.sideWin:Delete()
    self.sideWin = nil
  end
  if self.bannerUI ~= nil then
    self.bannerUI:Delete()
    self.bannerUI = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self._heroVoiceTextTimerId ~= nil then
    TimerManager:StopTimer(self._heroVoiceTextTimerId)
    self._heroVoiceTextTimerId = nil
  end
  if self._comebackTimerId ~= nil then
    TimerManager:StopTimer(self._comebackTimerId)
    self._comebackTimerId = nil
  end
  if self.__OnUpdate ~= nil then
    UpdateManager:RemoveUpdate(self.__OnUpdate)
    self.__OnUpdate = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__onTaskCommitComplete)
  MsgCenter:RemoveListener(eMsgEventId.PeroidCommitComplete, self.__onTaskPeroidCommit)
  MsgCenter:RemoveListener(eMsgEventId.ActivityShowChange, self.__RefreshActivityShow)
  MsgCenter:RemoveListener(eMsgEventId.ActivityKeyExertionTokenNumChange, self._OnKeyExertionTokenItemChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.OnNewChatMsgCome, self.__RefreshHomeChatBtnShow)
  MsgCenter:RemoveListener(eMsgEventId.OnChatBoardNewMsgNumChange, self.__RefreshHomeChatBtnShow)
  MsgCenter:RemoveListener(eMsgEventId.OnChatSystemBanChange, self.__RefreshHomeChatBtnShow)
  base.OnDelete(self)
end

return UINHomeLeft
