local HomeController = class("HomeController", ControllerBase)
local base = ControllerBase
local HomeEnum = require("Game.Home.HomeEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local UIBannerData = require("Game.CommonUI.Container.Model.ContainerData")
local NoticeData = require("Game.Notice.NoticeData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local JumpManager = require("Game.Jump.JumpManager")
local util = require("XLua.Common.xlua_util")
local HomeMainBg = require("Game.Home.HomeMainBg")
local ShopEnum = require("Game.Shop.ShopEnum")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local EPeriodicCardType = require("Game.DailySignIn.DailySignInEnum").EPeriodicCardType
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local cs_Input = CS.UnityEngine.Input
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local cs_CameraController = CS.OasisCameraController
local CS_CmCoreState = CS.Cinemachine.CinemachineCore.Stage
local CS_GMController = CS.GMController.Instance
local CS_ClientConsts = CS.ClientConsts
local CS_GSceneMgr = CS.GSceneManager.Instance

function HomeController:OnInit()
  self.oasisController = nil
  self:_ChangeHomeState(HomeEnum.eHomeState.None)
  self.homeCurrAdjutantLoaded = nil
  self.redDotFuncDic = {}
  self.sideNoticeList = {}
  self.m_timeSecond = 0
  self.m_timeSecond2 = 0
  self.needUpdateProduction = false
  self.updateProductionEvent = nil
  self.isNewFull = {}
  self.needUpdateConstruct = false
  self.updateConstructEvent = false
  self.isOasisHasCOB = false
  self.isSectorHasCOB = false
  self.isRewindingBack2HomeTimeLine = false
  self.__isLogin = true
  self.__live2DOver = true
  self.__OnUpdate = BindCallback(self, self.OnUpdate)
  UpdateManager:AddUpdate(self.__OnUpdate)
  self.__OnUpdatePlayerName = BindCallback(self, self.OnUpdatePlayerName)
  MsgCenter:AddListener(eMsgEventId.UserNameChanged, self.__OnUpdatePlayerName)
  self.__OnUpdateTask = BindCallback(self, self.OnUpdateTask)
  MsgCenter:AddListener(eMsgEventId.TaskSyncFinish, self.__OnUpdateTask)
  self.__UIOasisShow = BindCallback(self, self.ShowOasisUI)
  MsgCenter:AddListener(eMsgEventId.UIOasisShow, self.__UIOasisShow)
  self.__onUpdateUncompletedEp = BindCallback(self, self.OnUpdateUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp, self.__onUpdateUncompletedEp)
  self.__OnUpdateStamina = BindCallback(self, self.OnUpdateStamina)
  MsgCenter:AddListener(eMsgEventId.StaminaUpdate, self.__OnUpdateStamina)
  self.__OnUpdateHeroCollectRate = BindCallback(self, self.OnUpdateHeroCollectRate)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__OnUpdateHeroCollectRate)
  self.__OnUpdateARG = BindCallback(self, self.OnUpdateARG)
  MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.__OnUpdateARG)
  self.__OnUpdateItem = BindCallback(self, self.OnUpdateItem)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnUpdateItem)
  self.__OnActivityShowChange = BindCallback(self, self.OnActivityShowChange)
  MsgCenter:AddListener(eMsgEventId.ActivityShowChange, self.__OnActivityShowChange)
  self.__OnPlayerLevelChange = BindCallback(self, self.OnPlayerLevelChange)
  MsgCenter:AddListener(eMsgEventId.UpdatePlayerLevel, self.__OnPlayerLevelChange)
  self.__OnReciveDormFightInvited = BindCallback(self, self.OnReciveDormFightInvited)
  MsgCenter:AddListener(eMsgEventId.OnReciveDormFightInvited, self.__OnReciveDormFightInvited)
  self.AutoShowCommandList = {}
  self.__onGesture = BindCallback(self, self.OnGesture)
  self.__tryRunNextAutoShow = BindCallback(self, self.__TryRunNextAutoShow)
  self.__startShowHomeCoFunc = BindCallback(self, self.__StartShowHomeCo)
  self.lastVoiceId = 0
end

function HomeController:OnInitHomeUI()
  self:PauseHomeOnHookTimer(false)
  CS_LeanTouch.OnGesture("+", self.__onGesture)
  local isEnd = PlayerDataCenter.sectorStage:IsStageComplete(ConfigData.game_config.warfarEndEpl)
  if not isEnd and not self.__CheckInWarfarStage then
    self.__CheckInWarfarStage = BindCallback(self, self.CheckAndSetWarfarStage)
    MsgCenter:AddListener(eMsgEventId.PreCondition, self.__CheckInWarfarStage)
  end
end

function HomeController:OnEnterHome()
  self.oasisController = ControllerManager:GetController(ControllerTypeId.OasisController, true)
  if self._mainBg == nil then
    self._mainBg = HomeMainBg.New()
    self._editorBg = HomeMainBg.New()
  end
  local mainCamera = UIManager:GetMainCamera()
  local bind = mainCamera:FindComponent(eUnityComponentID.LuaBinding)
  self._editorBg:MainBgSetBind(bind)
  self._editorBg:SetHomeMainEnable(false)
  self._mainBg:MainBgSetBind(bind)
  self._mainBg:SetHomeMainEnable(true)
  self._cm0 = bind:GetBind("toSectorVHomeCam")
  self._cm1 = bind:GetBind("toOasiaVHomeCam")
end

function HomeController:OnShowHomeUI(isFromOasis)
  self:PauseHomeOnHookTimer(false)
  local homeOldState = self.homeState
  if self.homeState == HomeEnum.eHomeState.Covered then
    self.__wait4Guide = true
    self:_ChangeHomeState(HomeEnum.eHomeState.Normal)
    TimerManager:AddLateCommand(function()
      if JumpManager:IsHaveBack2Home() then
        JumpManager:TryCallBack2HomeMsgFunc(UIUtil.backStack:Empty())
        return
      end
      if JumpManager.isJumping then
        return
      end
      GuideManager:TryTriggerGuide(eGuideCondition.InHome)
      self.__wait4Guide = false
      self:__StartShowHomeCo()
    end)
    self:OnUpdate(true)
    MsgCenter:Broadcast(eMsgEventId.OnOpenHomeUI)
    return
  end
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  if self.homeState ~= HomeEnum.eHomeState.Normal then
    self.__wait4Guide = true
    self:_ChangeHomeState(HomeEnum.eHomeState.Normal)
    TimerManager:AddLateCommand(function()
      if JumpManager:IsHaveBack2Home() then
        if not self.isRewindingBack2HomeTimeLine then
          JumpManager:TryCallBack2HomeMsgFunc(UIUtil.backStack:Empty())
        end
        return
      end
      if JumpManager.isJumping then
        return
      end
      GuideManager:TryTriggerGuide(eGuideCondition.InHome)
      self.__wait4Guide = false
      if not DeepLinkManager:StartDeepLink(self.__startShowHomeCoFunc) then
        self:__StartShowHomeCo()
      end
    end)
    self:OnUpdate(true)
  end
  if self.__isLogin and not self:IsPlayLoginAnimationOnAutoShowOver() then
    self:PlayLoginHeroGreeting()
  end
  MsgCenter:Broadcast(eMsgEventId.OnOpenHomeUI)
end

function HomeController:OnCoverHomeUI()
  self:_ChangeHomeState(HomeEnum.eHomeState.Covered)
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    self:PauseHomeOnHookTimer(true)
  end
end

function HomeController:OnHideHomeUI()
  self:_ChangeHomeState(HomeEnum.eHomeState.Hided)
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    self:PauseHomeOnHookTimer(true)
  end
end

function HomeController:OnDeleteHomeUI()
  ControllerManager:DeleteController(ControllerTypeId.OasisController)
  self:RemoveAllRedDotEvent()
  self:_ChangeHomeState(HomeEnum.eHomeState.None)
  self:PauseHomeOnHookTimer(true)
  CS_LeanTouch.OnGesture("-", self.__onGesture)
  if self.__CheckInWarfarStage ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__CheckInWarfarStage)
    self.__CheckInWarfarStage = nil
  end
  if self._cm0 ~= nil then
    self._cm0 = nil
    self._cm1 = nil
  end
end

function HomeController:_ChangeHomeState(state)
  self.homeState = state
  if state == HomeEnum.eHomeState.normal then
    self:SetIsBlockAddAutoShowGuide(false)
  end
  self:PauseHomeL2dVoice(state ~= HomeEnum.eHomeState.Normal)
  cs_Input.multiTouchEnabled = state ~= HomeEnum.eHomeState.Normal
  JumpManager.couldUseItemJump = state == HomeEnum.eHomeState.Normal
  CS.RenderManager.Instance:SetShaderLODGlobal(self:IsNormalState() and 400 or 600)
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    if self:IsNormalState() then
      homeUI:OnScreenSizeChanged()
    else
      homeUI.canvas.worldCamera = nil
    end
  end
end

function HomeController:IsNormalState()
  return self.homeState == HomeEnum.eHomeState.Normal
end

function HomeController:OnAutoShowOver()
  self.isRunningAutoShow = false
  table.removeall(self.AutoShowCommandList)
  if self.__startOpenHomeAutoShow and self.__isLogin then
    if self:IsPlayLoginAnimationOnAutoShowOver() then
      self:PlayLoginHeroGreeting()
    end
    self.__startOpenHomeAutoShow = nil
    self.__isLogin = false
  end
  NoticeManager:ContinueShowNotice("homePop")
  NoticeManager:ForceContinueShowNotice()
end

function HomeController:_TryAutoEnterActivity()
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  for k, actFrameId in ipairs(ConfigData.activity_general.autoEnterActIdList) do
    local activityFrameInfo = actFrameCtrl:GetActivityFrameData(actFrameId)
    if activityFrameInfo ~= nil and not activityFrameInfo:GetIsActivityFinished() and not PlayerDataCenter.gameSettingData:IsActEntered(actFrameId) then
      local argList = {actFrameId}
      local couldJump = JumpManager:Jump2DynActivityValidate(argList, true)
      if couldJump then
        do
          local function autoJumpFunc()
            while CS_GSceneMgr.isLoading do
              coroutine.yield()
            end
            JumpManager:Jump(JumpManager.eJumpTarget.DynActivity, nil, function()
              self.__waitingAutoEnterActivity = nil
            end, argList)
            self._autoJumpActCo = nil
          end
          
          self._autoJumpActCo = GR.StartCoroutine(util.cs_generator(autoJumpFunc))
          self.__waitingAutoEnterActivity = true
          return true
        end
      end
    end
  end
end

function HomeController:__TryRunNextAutoShow(isEnter, notRunNext)
  if notRunNext then
    self.isRunningAutoShow = false
    return
  end
  if isEnter then
    self.isRunningAutoShow = true
    if #self.AutoShowCommandList > 0 then
      NoticeManager:PuaseShowNotice("homePop")
    end
  end
  if self.homeState ~= HomeEnum.eHomeState.Normal or JumpManager.isJumping or self.__waitingAutoEnterActivity then
    self.isRunningAutoShow = false
    return
  end
  if #self.AutoShowCommandList <= 0 then
    self:OnAutoShowOver()
    return
  end
  local command = table.remove(self.AutoShowCommandList, 1)
  if command == HomeEnum.eAutoShwoCommand.Pay then
    ControllerManager:GetController(ControllerTypeId.Pay, true):TryShowPayResult(self.__tryRunNextAutoShow)
    return
  end
  if not CS_ClientConsts.IsAudit and self:_TryAutoEnterActivity() then
    self:OnAutoShowOver()
    return
  end
  if CS_ClientConsts.IsAudit or isEditorMode and CS_GMController.EnableSkipLoginPopWindows then
    self:__TryRunNextAutoShow()
    return
  end
  if command == HomeEnum.eAutoShwoCommand.GameNotice and self:TryShowGameNotice() then
    return
  end
  if command == HomeEnum.eAutoShwoCommand.NoviceSign then
    local signIdList = PlayerDataCenter.eventNoviceSignData:GetSortSignDataIdList()
    for k, signId in ipairs(signIdList) do
      if self:TryShowEventNoviceSign(signId) then
        return
      end
    end
  end
  if command == HomeEnum.eAutoShwoCommand.Singin and self:TryCollectSinginReward() then
    return
  end
  if command == HomeEnum.eAutoShwoCommand.ActivitySignInMiniGame and self:__TryShowActivitySiginMiniGame() then
    return
  end
  if command == HomeEnum.eAutoShwoCommand.SectorActivity then
    for k, activityEntranceCfg in pairs(ConfigData.activity_entrance) do
      if self:TryShowSectorActivity(activityEntranceCfg) then
        return
      end
    end
  end
  if command == HomeEnum.eAutoShwoCommand.FlipCard then
    for k, activityFlipCardCfg in pairs(ConfigData.activity_flipcards_main) do
      if self:TryShowFlipCardPop(activityFlipCardCfg) then
        return
      end
    end
  end
  if command == HomeEnum.eAutoShwoCommand.Singin and self:TryCollectSinginReward() then
    return
  end
  if command == HomeEnum.eAutoShwoCommand.LoginPupup and self:_TryShowLoginPupup() then
    return
  end
  if command == HomeEnum.eAutoShwoCommand.ChipGift then
    local giftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
    local giftId = giftCtrl:GetHomePopGiftOne(true)
    if giftId ~= nil and self:TryOpenPayGift(giftId) then
      return
    end
  end
  if command == HomeEnum.eAutoShwoCommand.EventAngelaGift and self:_TryShowAngelaGiftPopup() then
    return
  end
  if command == HomeEnum.eAutoShwoCommand.EventLadderGift and self:_TryShowLadderGiftPopup() then
    return
  end
  if command == HomeEnum.eAutoShwoCommand.SaveMoney and self:_TryShowSaveMoneyPopup() then
    return
  end
  if command == HomeEnum.eAutoShwoCommand.Comeback and self:__TryComebackPopup() then
    return
  end
  if command == HomeEnum.eAutoShwoCommand.DormFightBeInvited then
    local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
    if dormFightCtrl:IsExistLegalInvited() then
      UIManager:ShowWindowAsync(UIWindowTypeID.DormFightBeInvited, function(window)
        if window ~= nil then
          window:InitDormFightBeInvited(dormFightCtrl)
        end
      end)
    end
  end
  if command == HomeEnum.eAutoShwoCommand.MonthCard and self:TryShowMonthCard() then
    return
  end
  self:__TryRunNextAutoShow()
end

function HomeController:__StartShowHomeCo()
  self.__startOpenHomeAutoShow = true
  self.AutoShowCommandList = {}
  if GuideManager.inGuide then
    return
  end
  if ControllerManager:GetController(ControllerTypeId.Pay, true):GetCouldSHowPayResult() then
    table.insert(self.AutoShowCommandList, HomeEnum.eAutoShwoCommand.Pay)
  end
  if self:ValidCouldOpenGameNotice() then
    table.insert(self.AutoShowCommandList, HomeEnum.eAutoShwoCommand.GameNotice)
  end
  local singMiniGameFlag = self:ValidCouldActivitySignInMiniGame()
  if singMiniGameFlag then
    table.insert(self.AutoShowCommandList, HomeEnum.eAutoShwoCommand.ActivitySignInMiniGame)
  end
  for activityId, data in pairs(PlayerDataCenter.eventNoviceSignData.dataDic) do
    if self:ValidCouldOpenNoviceSign(activityId) then
      table.insert(self.AutoShowCommandList, HomeEnum.eAutoShwoCommand.NoviceSign)
    end
  end
  if self:ValidCouldOpenSinginReward() then
    table.insert(self.AutoShowCommandList, HomeEnum.eAutoShwoCommand.Singin)
  end
  for k, v in pairs(ConfigData.activity_entrance) do
    if self:ValidCouldOpenSectorActivity(v) then
      table.insert(self.AutoShowCommandList, HomeEnum.eAutoShwoCommand.SectorActivity)
    end
  end
  for k, v in pairs(ConfigData.activity_flipcards_main) do
    if self:ValidCouldOpenFlipCard(v) then
      table.insert(self.AutoShowCommandList, HomeEnum.eAutoShwoCommand.FlipCard)
    end
  end
  for k, v in pairs(ConfigData.login_popup_client_ctrl) do
    if self:ValidCouldOpenLoginPupup(v) then
      table.insert(self.AutoShowCommandList, HomeEnum.eAutoShwoCommand.LoginPupup)
    end
  end
  for k, v in pairs(ConfigData.shop) do
    if self:ValidShopCouldOpenLoginPupup(v) then
      table.insert(self.AutoShowCommandList, HomeEnum.eAutoShwoCommand.LoginPupup)
    end
  end
  for k, v in pairs(ConfigData.month_card) do
    if self:ValidCouldMonthCardPop(v) then
      table.insert(self.AutoShowCommandList, HomeEnum.eAutoShwoCommand.MonthCard)
    end
  end
  for k, v in pairs(ConfigData.activity_angela_main) do
    if self:ValidCouldOpenActivityAngelaGiftPopup(v) then
      table.insert(self.AutoShowCommandList, HomeEnum.eAutoShwoCommand.EventAngelaGift)
    end
  end
  if ConfigData.activity_laddergift then
    for k, v in pairs(ConfigData.activity_laddergift) do
      if self:ValidCouldOpenActivityLadderGiftPopup(v) then
        table.insert(self.AutoShowCommandList, HomeEnum.eAutoShwoCommand.EventLadderGift)
      end
    end
  end
  for k, v in pairs(ConfigData.activity_saveMoney_main) do
    if self:ValidCouldOpenSaveMoneyPopup(v) then
      table.insert(self.AutoShowCommandList, HomeEnum.eAutoShwoCommand.SaveMoney)
    end
  end
  local giftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  local giftPopDic = giftCtrl:GetHomePopGiftDic()
  for giftId, _ in pairs(giftPopDic) do
    if self:ValidCouldOpenPayGift(giftId) then
      table.insert(self.AutoShowCommandList, HomeEnum.eAutoShwoCommand.ChipGift)
    end
  end
  local comebackFlag = self:ValidCouldComebackPopup()
  if comebackFlag then
    table.insert(self.AutoShowCommandList, HomeEnum.eAutoShwoCommand.Comeback)
  end
  if CommonUtil.IsOpenDormFightInvited() then
    local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
    if dormFightCtrl:IsExistLegalInvited() then
      table.insert(self.AutoShowCommandList, HomeEnum.eAutoShwoCommand.DormFightBeInvited)
    end
  end
  if not self.isRunningAutoShow then
    self:__TryRunNextAutoShow(true)
  end
end

function HomeController:AddAutoShowGuide(autoShowType, isNolyAddGuide)
  table.insert(self.AutoShowCommandList, autoShowType)
  if isNolyAddGuide then
    return
  end
  self:TryRunAutoShow()
end

function HomeController:SetIsBlockAddAutoShowGuide(isBlock)
  self.isBlockAddAutoShowGuide = isBlock
end

function HomeController:TryRunAutoShow()
  if not JumpManager.isJumping and not self.__wait4Guide and not self.isRunningAutoShow and self.homeState == HomeEnum.eHomeState.Normal and not self.isBlockAddAutoShowGuide and UIUtil.backStack:Peek() == nil then
    self:__TryRunNextAutoShow(true)
  end
end

function HomeController:ValidCouldOpenSinginReward()
  if GuideManager.inGuide or not self:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SignIn) then
    return false
  end
  local mailController = ControllerManager:GetController(ControllerTypeId.Mail, false)
  if mailController == nil then
    return false
  end
  local notPickedSinginMailUIDList = mailController:GetSignInRewardMailUIDs(self.__isNotFirstGetSignInReward, true)
  if #notPickedSinginMailUIDList <= 0 then
    return false
  end
  return true
end

function HomeController:TryCollectSinginReward()
  if not self:ValidCouldOpenSinginReward() then
    return false
  end
  local mailController = ControllerManager:GetController(ControllerTypeId.Mail, false)
  local notPickedSinginMailUIDList = mailController:GetSignInRewardMailUIDs(self.__isNotFirstGetSignInReward)
  self.__isNotFirstGetSignInReward = true
  UIManager:ShowWindowAsync(UIWindowTypeID.EventSignin, function(window)
    window:SetCloseCallback(self.__tryRunNextAutoShow)
    window:InitEventSignin(nil, notPickedSinginMailUIDList)
  end)
  return true
end

function HomeController:ValidCouldOpenNoviceSign(id)
  if GuideManager.inGuide then
    return
  end
  local data = PlayerDataCenter.eventNoviceSignData.dataDic[id]
  if data == nil then
    return
  end
  if not data:IsCanPop() then
    return
  end
  return true
end

function HomeController:TryShowEventNoviceSign(id)
  if not self:ValidCouldOpenNoviceSign(id) then
    return false
  end
  local data = PlayerDataCenter.eventNoviceSignData.dataDic[id]
  data:SetPoped()
  if data:IsFestivalSign() then
    UIManager:ShowWindowAsync(UIWindowTypeID.EventFestivalSignIn, function(window)
      window:SetCloseCallback(self.__tryRunNextAutoShow)
      window:InitEventFestivalSignIn(id, true)
    end)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.EventNoviceSign, function(window)
      window:SetCloseCallback(self.__tryRunNextAutoShow)
      window:InitNoviceSign(id, true)
    end)
  end
  return true
end

function HomeController:ValidCouldOpenGameNotice()
  if GuideManager.inGuide then
    return false
  end
  if CS.ClientConsts.IsAudit then
    return false
  end
  local ctrl = ControllerManager:GetController(ControllerTypeId.GameNotice)
  local canPush = ctrl:CanAutoPushGameNotice()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Notice)
  return canPush and isUnlock
end

function HomeController:TryShowGameNotice()
  if not self:ValidCouldOpenGameNotice() then
    return false
  end
  UIManager:CreateWindowAsync(UIWindowTypeID.GameNotice, function(win)
    if win == nil then
      return
    end
    win:SetCloseCallback(self.__tryRunNextAutoShow)
    win:InitUIGameNotice(false)
  end)
  return true
end

function HomeController:ValidCouldOpenSectorActivity(activityEntranceCfg, isRecord)
  if GuideManager.inGuide then
    return false
  end
  local popId = ActivityFrameUtil.GetActivityRealPopId(activityEntranceCfg)
  if popId <= 0 then
    return false
  end
  local activityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actInfo = activityCtrl:GetActivityFrameData(activityEntranceCfg.activityId)
  if actInfo == nil or not actInfo:CanPreviewNoExchange() then
    return false
  end
  if actInfo:IsActivityReadOnLogin() then
    return false
  end
  if isRecord then
    actInfo:SetActivityAsReadOnLogin()
  end
  return true
end

function HomeController:TryShowSectorActivity(activityEntranceCfg)
  if not self:ValidCouldOpenSectorActivity(activityEntranceCfg, true) then
    return false
  end
  local popupId = ActivityFrameUtil.GetActivityRealPopId(activityEntranceCfg)
  if self:_LoginPupupIsNeverPopToday(popupId) then
    return false
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonActivityLogin, function(win)
    if win == nil then
      return
    end
    local popId = ActivityFrameUtil.GetActivityRealPopId(activityEntranceCfg)
    local loginPupupCfg = ConfigData.login_popup_ui[popId]
    win:SetCloseCallback(self.__tryRunNextAutoShow)
    win:InitActivityLoginUI(loginPupupCfg)
  end)
  return true
end

function HomeController:ValidCouldOpenFlipCard(activityFlipCardCfg, isRecord)
  if GuideManager.inGuide then
    return false
  end
  if activityFlipCardCfg.popup_id == nil or activityFlipCardCfg.popup_id <= 0 then
    return false
  end
  local final_rewardId = activityFlipCardCfg.final_skin
  if final_rewardId ~= nil then
    local rewards = ConfigData.activity_flipcards_award[final_rewardId].reward
    for skinId, _ in pairs(rewards) do
      if PlayerDataCenter.skinData:IsHaveSkin(skinId) then
        return false
      end
    end
  end
  local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard)
  if flipCardCtrl == nil then
    return false
  end
  local actInfo = flipCardCtrl:GetFlipCardDataByActId(activityFlipCardCfg.activity_id)
  if actInfo == nil then
    return false
  end
  if actInfo:IsActivityReadOnLogin() then
    return false
  end
  if isRecord then
    actInfo:SetActivityAsReadOnLogin()
  end
  return true
end

function HomeController:TryShowFlipCardPop(activityFlipCardCfg)
  if not self:ValidCouldOpenFlipCard(activityFlipCardCfg, true) then
    return false
  end
  if self:_LoginPupupIsNeverPopToday(activityFlipCardCfg.popup_id) then
    return false
  end
  local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard)
  if flipCardCtrl == nil then
    return false
  end
  local actInfo = flipCardCtrl:GetFlipCardDataByActId(activityFlipCardCfg.activity_id)
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonActivityLogin, function(win)
    if win == nil then
      return
    end
    local loginPupupCfg = ConfigData.login_popup_ui[activityFlipCardCfg.popup_id]
    win:SetJumpFunc(function()
      JumpManager:Jump(JumpManager.eJumpTarget.DynActivity, nil, nil, {
        actInfo:GetActFrameId()
      })
    end)
    win:SetCloseCallback(self.__tryRunNextAutoShow)
    win:InitActivityLoginUI(loginPupupCfg)
  end)
  return true
end

function HomeController:ValidCouldMonthCardPop(monthCardCfg)
  if GuideManager.inGuide then
    return false
  end
  if monthCardCfg.popup_id == 0 then
    return false
  end
  if not self:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store) then
    return false
  end
  if not PlayerDataCenter.dailySignInData:GetIsMonthCardUnlock(monthCardCfg.id) or PlayerDataCenter.dailySignInData:GetMonthCardData(EPeriodicCardType.WeekCard):GetIsHaveMonthCard() then
    return false
  end
  return true
end

function HomeController:TryShowMonthCard()
  self._monthCardPopShowDic = self._monthCardPopShowDic or {}
  local monthCardCfg
  for id, cfg in pairs(ConfigData.month_card) do
    if self:ValidCouldMonthCardPop(cfg) and self._monthCardPopShowDic[id] == nil then
      monthCardCfg = cfg
      self._monthCardPopShowDic[id] = true
      break
    end
  end
  if monthCardCfg == nil then
    return false
  end
  if self:_LoginPupupIsNeverPopToday(monthCardCfg.popup_id) then
    return false
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonActivityLogin, function(win)
    if win == nil then
      return
    end
    local loginPupupCfg = ConfigData.login_popup_ui[monthCardCfg.popup_id]
    win:SetCloseCallback(self.__tryRunNextAutoShow)
    win:SetJumpFunc(function()
      JumpManager:Jump(JumpManager.eJumpTarget.DynShop, function(callback)
        if callback ~= nil then
          callback()
        end
      end, nil, {
        ShopEnum.ShopId.MonthCardId
      })
    end)
    win:InitActivityLoginUI(loginPupupCfg)
  end)
  return true
end

function HomeController:_LoginPupupIsNeverPopToday(popup_id)
  local systemSaveData = PersistentManager:GetDataModel(PersistentConfig.ePackage.SystemData)
  local loginPupupCfg = ConfigData.login_popup_ui[popup_id]
  if systemSaveData:GetActEntranceReadOneValue() then
    local userSaveData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    local lastTime = userSaveData:GetActEntranceLastShow(loginPupupCfg.id)
    local showTime = math.floor(PlayerDataCenter.timestamp)
    if not TimeUtil:CompareIsCorssDay(lastTime, showTime) then
      return true
    end
  end
  return false
end

function HomeController:ValidShopCouldOpenLoginPupup(shopCfg)
  if GuideManager.inGuide then
    return false
  end
  self._activetyPreviewShowDic = self._activetyPreviewShowDic or {}
  if shopCfg.popup_id == nil or shopCfg.popup_id == 0 then
    return false
  end
  if not CheckCondition.CheckLua(shopCfg.pre_condition, shopCfg.pre_para1, shopCfg.pre_para2) then
    return false
  else
    local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
    if payGiftCtrl:CheckPageIdIsGiftShop(shopCfg.id) and 0 >= #payGiftCtrl:GetShowPayGiftByPageId(shopCfg.id) then
      return false
    end
  end
  if self._activetyPreviewShowDic[shopCfg.id] then
    return false
  end
  if self:_LoginPupupIsNeverPopToday(shopCfg.popup_id) then
    return false
  end
  return true
end

function HomeController:ValidCouldOpenLoginPupup(loginPopupClientCtrlCfg)
  if GuideManager.inGuide then
    return false
  end
  self._activetyPreviewShowDic = self._activetyPreviewShowDic or {}
  local curTs = PlayerDataCenter.timestamp
  if curTs < loginPopupClientCtrlCfg.start_time or curTs > loginPopupClientCtrlCfg.end_time then
    return false
  end
  if self._activetyPreviewShowDic[loginPopupClientCtrlCfg.id] then
    return false
  end
  if self:_LoginPupupIsNeverPopToday(loginPopupClientCtrlCfg.popup_id) then
    return false
  end
  return true
end

function HomeController:ValidCouldOpenActivityLadderGiftPopup(activityLadderCfg)
  if GuideManager.inGuide then
    return false
  end
  local ladderGiftController = ControllerManager:GetController(ControllerTypeId.EventLadderGift)
  if ladderGiftController == nil then
    return false
  end
  local data = ladderGiftController:GetLadderGiftDataByActId(activityLadderCfg.id)
  if data == nil or data:GetIsLadderGiftDataOver() then
    return false
  end
  self._activetyPreviewShowDic = self._activetyPreviewShowDic or {}
  if self._activetyPreviewShowDic[data:GetActFrameId()] then
    return false
  end
  return data:GetLadderGiftDataCanPop()
end

function HomeController:_TryShowLadderGiftPopup()
  local ladderGiftController = ControllerManager:GetController(ControllerTypeId.EventLadderGift)
  if ladderGiftController == nil then
    return false
  end
  local data = ladderGiftController:GetTheLatestLadderGiftData()
  if data == nil or data:GetIsLadderGiftDataOver() then
    return false
  end
  self._activetyPreviewShowDic = self._activetyPreviewShowDic or {}
  self._activetyPreviewShowDic[data:GetActFrameId()] = true
  UIManager:ShowWindowAsync(UIWindowTypeID.EventLadderGift, function(win)
    if win == nil then
      return
    end
    win:SetCloseCallback(self.__tryRunNextAutoShow)
    win:InitEventLadderGift(data:GetActId(), true)
  end)
  return true
end

function HomeController:ValidCouldOpenActivityAngelaGiftPopup(activityAngelaCfg)
  if GuideManager.inGuide then
    return false
  end
  local angelaGiftController = ControllerManager:GetController(ControllerTypeId.EventAngelaGift)
  if angelaGiftController == nil then
    return false
  end
  local data = angelaGiftController:GetAngelaGiftDataByActId(activityAngelaCfg.id)
  if data == nil or data:GetIsAngelaGiftDataOver() then
    return false
  end
  self._activetyPreviewShowDic = self._activetyPreviewShowDic or {}
  if self._activetyPreviewShowDic[data:GetActFrameId()] then
    return false
  end
  return data:GetAngelaGiftDataCanPop()
end

function HomeController:_TryShowAngelaGiftPopup()
  local angelaGiftController = ControllerManager:GetController(ControllerTypeId.EventAngelaGift)
  if angelaGiftController == nil then
    return false
  end
  local data = angelaGiftController:GetTheLatestAngelaGiftData()
  if data == nil or data:GetIsAngelaGiftDataOver() then
    return false
  end
  self._activetyPreviewShowDic = self._activetyPreviewShowDic or {}
  self._activetyPreviewShowDic[data:GetActFrameId()] = true
  UIManager:ShowWindowAsync(UIWindowTypeID.EventAngelaGift, function(win)
    if win == nil then
      return
    end
    win:SetCloseCallback(self.__tryRunNextAutoShow)
    win:InitEventAngelaGiftMain(data:GetActId(), true)
  end)
  return true
end

function HomeController:ValidCouldOpenSaveMoneyPopup(saveMoneyCfg)
  if GuideManager.inGuide then
    return false
  end
  local saveMoneyController = ControllerManager:GetController(ControllerTypeId.ActivitySaveMoney)
  if saveMoneyController == nil then
    return false
  end
  local data = saveMoneyController:GetSaveMoneyDataByActId(saveMoneyCfg.id)
  if data == nil or not data:IsSaveMoneyCanPop() then
    return false
  end
  self._activetyPreviewShowDic = self._activetyPreviewShowDic or {}
  if self._activetyPreviewShowDic[data:GetActFrameId()] then
    return false
  end
  return true
end

function HomeController:_TryShowSaveMoneyPopup()
  local saveMoneyController = ControllerManager:GetController(ControllerTypeId.ActivitySaveMoney)
  if saveMoneyController == nil then
    return false
  end
  local data = saveMoneyController:GetTheLatestSaveMoneyData()
  if data == nil or not data:IsSaveMoneyCanPop() then
    return false
  end
  self._activetyPreviewShowDic = self._activetyPreviewShowDic or {}
  self._activetyPreviewShowDic[data:GetActFrameId()] = true
  UIManager:ShowWindowAsync(UIWindowTypeID.SaveMoney, function(win)
    if win == nil then
      return
    end
    win:SetCloseCallback(self.__tryRunNextAutoShow)
    win:InitSaveMoneyMain(data:GetActId(), true)
  end)
  return true
end

function HomeController:_TryShowLoginPupup()
  self._activetyPreviewShowDic = self._activetyPreviewShowDic or {}
  local curTs = PlayerDataCenter.timestamp
  for k, popCfg in pairs(ConfigData.login_popup_client_ctrl) do
    if self:ValidCouldOpenLoginPupup(popCfg) then
      self._activetyPreviewShowDic[k] = true
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonActivityLogin, function(win)
        if win == nil then
          return
        end
        local loginPupupCfg = ConfigData.login_popup_ui[popCfg.popup_id]
        win:SetCloseCallback(self.__tryRunNextAutoShow)
        win:InitActivityLoginUI(loginPupupCfg)
      end)
      return true
    end
  end
  for k, shopCfg in pairs(ConfigData.shop) do
    if self:ValidShopCouldOpenLoginPupup(shopCfg) then
      self._activetyPreviewShowDic[k] = true
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonActivityLogin, function(win)
        if win == nil then
          return
        end
        local loginPupupCfg = ConfigData.login_popup_ui[shopCfg.popup_id]
        win:SetCloseCallback(self.__tryRunNextAutoShow)
        win:SetJumpFunc(function()
          JumpManager:DirectShowShop(nil, nil, shopCfg.id)
        end)
        win:SetTimeId(true, shopCfg.id)
        win:InitActivityLoginUI(loginPupupCfg)
      end)
      return true
    end
  end
  return false
end

function HomeController:ValidCouldOpenPayGift(id)
  local giftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  local giftInfo = giftCtrl:GetPayGiftDataById(id)
  if giftInfo == nil then
    return false
  end
  return giftCtrl:CheckPayGiftCanPop(giftInfo)
end

function HomeController:TryOpenPayGift(id)
  if not self:ValidCouldOpenPayGift(id) then
    return false
  end
  local giftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  local giftInfo = giftCtrl:GetPayGiftDataById(id)
  if giftInfo.groupCfg.popup_id ~= 0 and self:_LoginPupupIsNeverPopToday(giftInfo.groupCfg.popup_id) then
    return false
  end
  if giftInfo:IsSelfSelectHeroGift() or giftInfo:IsSelfSelectChipGift() then
    giftCtrl:ShowHeroGiftWin(giftInfo, self.__tryRunNextAutoShow)
  else
    giftCtrl:ShowPayGiftWin(giftInfo, self.__tryRunNextAutoShow)
  end
  return true
end

function HomeController:ValidCouldComebackPopup()
  local comebackCtrl = ControllerManager:GetController(ControllerTypeId.ActivityComeback)
  if comebackCtrl == nil then
    return false
  end
  local comebackData = comebackCtrl:GetTheLatestComebackData()
  if comebackData == nil then
    return false
  end
  if not comebackData:IsActivityOpen() then
    return false
  end
  local avgID = comebackData:GetComebackAvgId()
  if avgID ~= 0 then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
    if avgPlayCtrl:IsAvgPlayed(avgID) then
      return false
    end
  else
    local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    local isPopPlayed = userDataCache:GetComebackPopLooked(comebackData:GetActId())
    return not isPopPlayed, comebackData, avgID
  end
  return true, comebackData, avgID
end

function HomeController:__TryComebackPopup()
  local flag, comebackData, avgID = self:ValidCouldComebackPopup()
  if not flag then
    return false
  end
  
  local function closeFunc()
    if avgID ~= 0 then
      local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
      avgCtrl:StartAvg(nil, avgID, function()
        UIManager:ShowWindowAsync(comebackData:GetComebackWindowId(), function(window)
          if window ~= nil then
            local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
            if homeUI ~= nil then
              homeUI:OpenOtherWin()
            end
            window:SetFromWhichUI(eBaseWinFromWhere.home)
            window:InitActivityCombackMain(comebackData:GetActId())
          end
        end)
      end)
    else
      UIManager:ShowWindowAsync(comebackData:GetComebackWindowId(), function(window)
        if window ~= nil then
          local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
          if homeUI ~= nil then
            homeUI:OpenOtherWin()
          end
          window:SetFromWhichUI(eBaseWinFromWhere.home)
          window:InitActivityCombackMain(comebackData:GetActId())
        end
      end)
    end
    self:OnAutoShowOver()
  end
  
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonActivityLogin, function(win)
    if win == nil then
      return
    end
    local comebackCfg = comebackData:GetComebackCfg()
    local loginPupupCfg = ConfigData.login_popup_ui[comebackCfg.login_popup]
    win:SetCloseCallback(closeFunc)
    win:InitActivityLoginUI(loginPupupCfg)
    win:SetIgnoreExtraPopupUI()
    local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    userDataCache:SetComebackPopLooked(comebackData:GetActId())
  end)
  return true
end

function HomeController:ValidCouldActivitySignInMiniGame()
  local signInMiniGameCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySignInMiniGame)
  if signInMiniGameCtrl == nil then
    return false
  end
  if signInMiniGameCtrl:IsOpen() ~= true then
    return false
  end
  if signInMiniGameCtrl:IsCanSignToDay() ~= true then
    return false
  end
  if signInMiniGameCtrl:GetLoginIsFirstOpen() == true then
    return false
  end
  local isplayed = signInMiniGameCtrl:GetIsPlayedCartoon()
  local avgId = signInMiniGameCtrl:GetSignInMiniGameFirstAvg()
  local actId = signInMiniGameCtrl:GetActId()
  return true, actId, isplayed, avgId
end

function HomeController:__TryShowActivitySiginMiniGame()
  local flag, actId, isplayed, avgId = self:ValidCouldActivitySignInMiniGame()
  if not flag then
    return false
  end
  local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  if isplayed == false and avgId ~= 0 then
    avgCtrl:StartAvg(nil, avgId, function()
      local signInMiniGameCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySignInMiniGame)
      signInMiniGameCtrl:CS_ACTIVITY_SignMiniGame_PlayCartoon()
      signInMiniGameCtrl:SetLoginIsFirstOpen()
      UIManager:ShowWindowAsync(UIWindowTypeID.SignInMiniGame, function(win)
        if win == nil then
          return
        end
        win:InitSignInMiniGame(actId, true)
        win:SetCloseCallback(self.__tryRunNextAutoShow)
      end)
    end)
  else
    local signInMiniGameCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySignInMiniGame)
    signInMiniGameCtrl:SetLoginIsFirstOpen()
    UIManager:ShowWindowAsync(UIWindowTypeID.SignInMiniGame, function(win)
      if win == nil then
        return
      end
      win:InitSignInMiniGame(actId, true)
      win:SetCloseCallback(self.__tryRunNextAutoShow)
    end)
  end
  return true
end

function HomeController:OnUpdate(isForce)
  if self.m_timeSecond2 == nil then
    self.m_timeSecond2 = 0
  else
    self.m_timeSecond2 = self.m_timeSecond2 + Time.deltaTime
  end
  local isMin = false
  if self.m_timeSecond2 > 60 then
    self.m_timeSecond2 = 0
    isMin = true
  end
  if isMin then
    PlayerDataCenter.friendDataCenter:RefreshFriendApplyReddotNum()
  end
  if isForce or isMin then
    self:UpdateCouldOperateBuilding()
    self:UpdateOasisGenResourceFull()
    self:UpdateIsFactoryLineOver()
  end
end

function HomeController:SetNeedUpdateProduction(bool, updateEvent)
  self.needUpdateProduction = true
  self.updateProductionEvent = updateEvent
end

local function m_AddBuildRes(allResDic, resData, countMax)
  local allResData = allResDic[resData.id]
  if allResData == nil then
    allResData = {
      id = resData.id,
      name = resData.name,
      count = resData.count,
      speed = resData.speed,
      effSpeed = resData.effSpeed,
      progress = resData.progress,
      countMax = countMax
    }
    allResDic[resData.id] = allResData
  else
    allResData.effSpeed = allResData.effSpeed + resData.effSpeed
    allResData.speed = allResData.speed + resData.speed
    allResData.count = allResData.count + resData.count
    allResData.countMax = allResData.countMax + countMax
  end
end

function HomeController:SetNeedUpdateConstruct(bool, updateEvent)
  self.needUpdateConstruct = bool
  self.updateConstructEvent = updateEvent
end

function HomeController:OnUpdateBuildingConstruct()
  if not self.needUpdateConstruct then
    return
  end
  local constructingBuildingLists = {
    [BuildingBelong.Oasis] = {},
    [BuildingBelong.Sector] = {}
  }
  for _, builtData in ipairs(PlayerDataCenter.AllBuildingData.builtSort) do
    builtData:GetProcess(PlayerDataCenter.timestamp)
    if builtData.state == proto_object_BuildingState.BuildingStateCreate or builtData.state == proto_object_BuildingState.BuildingStateUpgrade then
      table.insert(constructingBuildingLists[builtData.belong], builtData)
    end
  end
  if self.updateConstructEvent ~= nil then
    self.updateConstructEvent(constructingBuildingLists)
  end
end

function HomeController:UpdateCouldOperateBuilding()
  local curHasSectorCOB, curHasOasisCOB
  local isSectorBuildingUnlock = self:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding)
  for id, data in pairs(PlayerDataCenter.AllBuildingData.unbuilt) do
    if data:IsSectorBuilding() then
      if not curHasSectorCOB and isSectorBuildingUnlock and data:CanBuild() then
        curHasSectorCOB = true
      end
    elseif not curHasOasisCOB and data:CanBuild() then
      curHasOasisCOB = true
    end
  end
  for id, data in pairs(PlayerDataCenter.AllBuildingData.built) do
    if data.dynData:IsSectorBuilding() then
      if not curHasSectorCOB and isSectorBuildingUnlock and data:CanUpgrade() then
        curHasSectorCOB = true
      end
    elseif not curHasOasisCOB and data:CanUpgrade() then
      curHasOasisCOB = true
    end
  end
  if not self.isOasisHasCOB and curHasOasisCOB then
    self.isOasisHasCOB = curHasOasisCOB
    NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.HasOasisBuildingOperate, {
      jumpType = JumpManager.eJumpTarget.Oasis,
      argList = nil
    }, nil, nil))
  elseif self.isOasisHasCOB and not curHasOasisCOB then
    NoticeManager:DeleteNoticeByType(NoticeManager.eNoticeType.HasOasisBuildingOperate)
    self.isOasisHasCOB = curHasOasisCOB
  end
  if not self.isSectorHasCOB and curHasSectorCOB then
    self.isSectorHasCOB = curHasSectorCOB
    NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.HasSectorBuildingOperate, {
      jumpType = JumpManager.eJumpTarget.Sector,
      argList = {true}
    }, nil, nil))
  elseif self.isSectorHasCOB and not curHasSectorCOB then
    NoticeManager:DeleteNoticeByType(NoticeManager.eNoticeType.HasSectorBuildingOperate)
    self.isSectorHasCOB = curHasSectorCOB
  end
end

function HomeController:UpdateOasisGenResourceFull()
  for _, buildingData in pairs(PlayerDataCenter.AllBuildingData.oasisBuilt) do
    local datas = buildingData:GetResDatas()
    if datas ~= nil then
      for resId, data in pairs(datas) do
        if data.count >= data.countMax then
          if not self.isOasisHasFullResource then
            self.isOasisHasFullResource = true
            NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.ResourceGenerateOverflow, {
              jumpType = JumpManager.eJumpTarget.Oasis,
              argList = nil
            }, nil, nil))
          end
          return
        end
      end
    end
  end
  if self.isOasisHasFullResource then
    self.isOasisHasFullResource = false
    NoticeManager:DeleteNoticeByType(NoticeManager.eNoticeType.ResourceGenerateOverflow)
  end
end

function HomeController:UpdateIsFactoryLineOver()
  local isFactoryUnlock = self:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory)
  if isFactoryUnlock then
    local factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
    if factoryController == nil or factoryController.factoryMainUI ~= nil then
      return
    end
    factoryController:RefreshFactoryRedDot()
  end
end

function HomeController:OnUpdatePlayerName()
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI.homeUpNdoe:RefershUserInfo()
  end
end

function HomeController:OnUpdateTask()
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI.homeLeftNode:RefreshTaskBtn()
  end
end

function HomeController:ShowOasisUI()
  if self.isInEnterOasis then
    self.oasisController:EnterOasis()
  end
end

function HomeController:IsEnterOasis(isEnter)
  self.isInEnterOasis = isEnter
end

function HomeController:ResetOasisCamera()
  cs_CameraController.Instance:ResetOasisView()
end

function HomeController:OnUpdateUncompletedEp()
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI.homeRightNode:RefreshContinueEp()
  end
end

function HomeController:OnUpdateStamina()
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI.homeRightNode:RefreshStamina()
  end
end

function HomeController:OnUpdateFactoryEnergy()
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI.homeRightNode:RefreshFactoryEnergy()
  end
end

function HomeController:OnUpdateLotteryCost(fromeAuto)
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI.homeRightNode:RefreshLotteryCost(fromeAuto)
  end
end

function HomeController:OnUpdateHeroCollectRate()
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI.homeRightNode:RefreshCollectRate()
  end
end

function HomeController:OnUpdateOasisBuilding()
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI.homeRightNode:RefreshBuiltRate()
  end
  self:OnUpdateFactoryEnergy()
end

function HomeController:OnupdateFairyCostItemNum()
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI.homeRightNode:RefreshFairyBtn()
  end
end

function HomeController:OnUpdateARG(changedItemNumDic)
  self:OnUpdateLotteryCost(true)
end

function HomeController:OnUpdateItem(itemUpdate)
  self:OnUpdateLotteryCost()
  self:OnupdateFairyCostItemNum()
  if itemUpdate[ConfigData.game_config.factoryEnergyItemId] ~= nil then
    self:OnUpdateFactoryEnergy()
  end
end

function HomeController:OnActivityShowChange()
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI.homeLeftNode:RefreshActivityShow()
  end
end

function HomeController:OnPlayerLevelChange()
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI.homeUpNdoe:RefershUserInfo()
  end
end

function HomeController:OnReciveDormFightInvited(dormFightCtrl, userInfoData)
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if not (homeUI ~= nil and homeUI.active) or self.isInEnterOasis or not homeUI.homeController:IsNormalState() then
    local extraData = {}
    extraData.userInfoData = userInfoData
    local invitedCountDownSecend = ConfigData.dorm_fight_config.invitingTimeSecends
    NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.DormFightBeInvited, nil, {invitedCountDownSecend}, extraData))
  else
    if not CommonUtil.IsOpenDormFightInvited() then
      return
    end
    local BeInvitedWindow = UIManager:GetWindow(UIWindowTypeID.DormFightBeInvited)
    if BeInvitedWindow ~= nil then
      BeInvitedWindow:Refresh()
    else
      UIManager:ShowWindowAsync(UIWindowTypeID.DormFightBeInvited, function(window)
        if window ~= nil then
          window:InitDormFightBeInvited(dormFightCtrl)
        end
      end)
    end
  end
end

function HomeController:IsFuncUnlock(funcId)
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(funcId)
  if not isUnlock then
    local unlockDes = FunctionUnlockMgr:GetFuncUnlockDecription(funcId)
    return isUnlock, unlockDes
  else
    return isUnlock, nil
  end
end

function HomeController:AddRedDotEvent(redDotCallback, ...)
  local ok, node = RedDotController:GetRedDotNode(...)
  redDotCallback(node:GetRedDotCount())
  
  local function redDotFunc(node)
    redDotCallback(node:GetRedDotCount())
  end
  
  self.redDotFuncDic[redDotFunc] = node
  RedDotController:AddListener(node.nodePath, redDotFunc)
end

function HomeController:AddBlueDotEvent(blueDotCallback, ...)
  local ok, node = RedDotController:GetRedDotNode(...)
  blueDotCallback(node:GetBlueDotCount())
  
  local function blueDotFunc(node)
    blueDotCallback(node:GetBlueDotCount())
  end
  
  self.redDotFuncDic[blueDotFunc] = node
  RedDotController:AddListener(node.nodePath, blueDotFunc)
end

function HomeController:RemoveAllRedDotEvent()
  for redDotFunc, node in pairs(self.redDotFuncDic) do
    RedDotController:RemoveListener(node.nodePath, redDotFunc)
  end
  self.redDotFuncDic = {}
end

function HomeController:GetAdjutant()
  if PlayerDataCenter.showGirlId == nil or PlayerDataCenter.showGirlId == 0 then
    local firtBoardHeroID = ConfigData.game_config.firtBoardHeroID
    if PlayerDataCenter.heroDic[firtBoardHeroID] == nil then
      error("default board hero data is nil id " .. firtBoardHeroID)
    else
      return PlayerDataCenter.heroDic[firtBoardHeroID]
    end
  else
    return PlayerDataCenter.heroDic[PlayerDataCenter.showGirlId]
  end
end

function HomeController:GetAdjutantHeroId()
  local heroData = self:GetAdjutant()
  if heroData == nil then
    return nil
  end
  return heroData.dataId
end

function HomeController:ResetHomeVoice()
  self.__aniPlayEnd = true
  TimerManager:StopTimer(self.__animTimerId)
  if self.__fakeVoiceTimer ~= nil then
    TimerManager:StopTimer(self.__fakeVoiceTimer)
    self.__fakeVoiceTimer = nil
  end
end

function HomeController:PlayLoginHeroGreeting()
  if self.dontPlayCvNextReturnHome then
    self:NextReturnHomeDontPlayCv(false)
    return
  end
  if self.isRunningAutoShow then
    return
  end
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  if window ~= nil and window.homeAdjutant ~= nil then
    window.homeAdjutant:PlayAdjutantLoginGreeting()
  end
end

function HomeController:TryPlayVoReturnHome()
  if self.dontPlayCvNextReturnHome then
    self:NextReturnHomeDontPlayCv(false)
    return false
  end
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  if window == nil or window.homeAdjutant == nil or window.homeAdjutant.heroCubismInteration == nil then
    return false
  end
  window.homeAdjutant:PlayAdjutantHeroEnterHomeAnimation()
  return true
end

function HomeController:PlayHomeVoice(heroId, skinId, voiceId, cvOverBackFun, animLength, OpenMouseListen)
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  local isHeroHasVoice = cvCtr:HasCv(heroId)
  if self._lastHomeVoicePlayback ~= nil then
    AudioManager:StopAudioByBack(self._lastHomeVoicePlayback)
    self._lastHomeVoicePlayback = nil
  end
  self.lastVoiceId = voiceId
  local lastCvInfo = PlayerDataCenter.cacheSaveData:GetLastHeroInterationCVInfo()
  lastCvInfo.lastVoiceHeroId = heroId
  lastCvInfo.lastVoiceTIme = Time.time
  PlayerDataCenter.cacheSaveData:SetLastHeroInterationCVInfo(lastCvInfo)
  if not isHeroHasVoice then
    if cvOverBackFun ~= nil then
      cvOverBackFun(false)
    end
    if self.__fakeVoiceTimer ~= nil then
      TimerManager:StopTimer(self.__fakeVoiceTimer)
      self.__fakeVoiceTimer = nil
    end
    local fakeTime = animLength ~= nil and animLength or 3
    local window = UIManager:GetWindow(UIWindowTypeID.Home)
    if window ~= nil then
      local text = cvCtr:GetCvText(heroId, voiceId, skinId)
      window.homeLeftNode:ShowHeroVoiceText(true, text, true, fakeTime)
    end
    self.__fakeVoiceTimer = TimerManager:StartTimer(fakeTime, function()
      self:TryResetShowHeroVoice()
      if cvOverBackFun ~= nil then
        cvOverBackFun(true)
      end
    end, self, true)
    return
  end
  OpenMouseListen = OpenMouseListen and self:JudgeMouseOpen()
  if cvOverBackFun ~= nil then
    cvOverBackFun(not OpenMouseListen)
  end
  if animLength ~= nil then
    self.__aniPlayEnd = false
    TimerManager:StopTimer(self.__animTimerId)
    self.__animTimerId = TimerManager:StartTimer(animLength, function()
      self.__aniPlayEnd = true
      self:TryResetShowHeroVoice()
    end)
  end
  self._lastHomeVoicePlayback = cvCtr:PlayCv(heroId, voiceId, function()
    self._lastHomeVoicePlayback = nil
    self:TryResetShowHeroVoice()
    if cvOverBackFun ~= nil then
      cvOverBackFun(true)
    end
  end, OpenMouseListen, skinId)
  local audioLength = cvCtr:GetVoiceLength(heroId, voiceId, skinId)
  local voiceTextDuration = audioLength / 1000
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  if window ~= nil then
    local text = cvCtr:GetCvText(heroId, voiceId, skinId)
    window.homeLeftNode:ShowHeroVoiceText(true, text, false, voiceTextDuration)
  end
end

function HomeController:TryResetShowHeroVoice()
  if self._lastHomeVoicePlayback == nil and self.__aniPlayEnd then
    local window = UIManager:GetWindow(UIWindowTypeID.Home)
    if window ~= nil then
      window.homeLeftNode:ShowHeroVoiceText(false)
    end
  end
end

function HomeController:ResetShowHeroVoiceImme()
  if self._lastHomeVoicePlayback == nil and self.__aniPlayEnd then
    return
  end
  if self._lastHomeVoicePlayback ~= nil then
    AudioManager:StopAudioByBack(self._lastHomeVoicePlayback)
    self._lastHomeVoicePlayback = nil
  end
  if not self.__aniPlayEnd then
    self.__aniPlayEnd = true
    TimerManager:StopTimer(self.__animTimerId)
    self.__animTimerId = nil
  end
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  if window ~= nil then
    window.homeLeftNode:ShowHeroVoiceText(false)
    if window.homeAdjutant ~= nil and window.homeAdjutant.heroCubismInteration ~= nil then
      window.homeAdjutant.heroCubismInteration:RestartBodyAnimation()
    end
  end
end

function HomeController:JudgeMouseOpen()
  if not self.homeCurrAdjutantLoaded then
    return false
  end
  local adjPreset = PlayerDataCenter.allAdjCustomData:GetUsingCustomPreset()
  local mainAdjHero = adjPreset:GetAdjPresetElemMain()
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  return skinCtrl:CheckMouseOpen(mainAdjHero.dataId, mainAdjHero.skinId)
end

function HomeController:NextReturnHomeDontPlayCv(isFrom)
  self.dontPlayCvNextReturnHome = isFrom
end

function HomeController:PauseHomeOnHookTimer(pause)
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  if window ~= nil then
    window.homeAdjutant:OpenAdjutantWait(not pause)
  end
end

function HomeController:PauseHomeL2dVoice(pause)
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  if window ~= nil and window.homeAdjutant ~= nil and window.homeAdjutant.heroCubismInteration ~= nil then
    window.homeAdjutant.heroCubismInteration:SetCoundPlaySound(not pause)
  end
end

function HomeController:StopHomeOnHookTimer()
  CS_LeanTouch.OnGesture("-", self.__onGesture)
end

function HomeController:OnGesture(fingerList)
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  if window == nil or window.homeAdjutant == nil or window.homeAdjutant.heroCubismInteration == nil then
    return false
  end
  window.homeAdjutant.heroCubismInteration:ResetInterationWaitTime()
end

function HomeController:ChangeSceneMainBg(isDay)
  if self._mainBg ~= nil then
    self._mainBg:SetHomeMainState(isDay)
    self._editorBg:SetHomeMainState(isDay)
  end
end

function HomeController:ResetHomeMainBg()
  local mainCamera = UIManager:GetMainCamera()
  local bind = mainCamera:FindComponent(eUnityComponentID.LuaBinding)
  self._editorBg:MainBgSetBind(bind)
  self._editorBg:SetHomeMainEnable(false)
  self._mainBg:MainBgSetBind(bind)
  self._mainBg:SetHomeMainEnable(true)
end

function HomeController:HideWarfarEffect()
  self:__RecoverCMCamera()
  self._mainBg:SetHomeMainEnable(false)
end

function HomeController:ShowWarfarEffect()
  self:__RecoverCMCamera()
  self._mainBg:SetHomeMainEnable(true)
end

function HomeController:CheckAndSetWarfarStage(conditionId)
  if conditionId ~= nil and conditionId ~= CheckerTypeId.CompleteStage then
    return
  end
  local isEnd = PlayerDataCenter.sectorStage:IsStageComplete(ConfigData.game_config.warfarEndEpl)
  if isEnd and self.__CheckInWarfarStage ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__CheckInWarfarStage)
    self.__CheckInWarfarStage = nil
  end
  self:RefreshHomeMainBg()
end

function HomeController:RefreshHomeMainBg()
  local adjInfo = PlayerDataCenter.allAdjCustomData:GetUsingCustomPreset()
  if adjInfo == nil then
    return
  end
  local bgId = adjInfo:GetAdjPresetBgId()
  if bgId == nil then
    return
  end
  local bgCfg = ConfigData.background[bgId]
  if bgCfg == nil then
    return
  end
  local isEnd = PlayerDataCenter.sectorStage:IsStageComplete(ConfigData.game_config.warfarEndEpl)
  local isInDuring = not isEnd and PlayerDataCenter.sectorStage:IsStageComplete(ConfigData.game_config.warfarStartEpl)
  if isInDuring then
    bgCfg = ConfigData.background[ConfigData.buildinConfig.WarfarBgId]
  end
  self:__RecoverCMCamera()
  self._editorBg:SetHomeMainEnable(false)
  self._mainBg:UpdateBgId(bgCfg)
  self._mainBg:SetHomeMainEnable(true)
end

function HomeController:SetHomeMainEditorBg(bgCfg)
  self:__RecoverCMCamera()
  self._editorBg:UpdateBgId(bgCfg)
  self._mainBg:SetHomeMainEnable(false)
  self._editorBg:SetHomeMainEnable(true)
end

function HomeController:ResetHomeMainBg()
  self:__RecoverCMCamera()
  self._editorBg:SetHomeMainEnable(false)
  self._mainBg:SetHomeMainEnable(true)
end

function HomeController:ClearRecordMainBg()
  self:ResetHomeMainBg()
  self._editorBg:ClearMainBgRes()
end

function HomeController:PreLoadMainBg(callback)
  if self._mainBg == nil then
    self._mainBg = HomeMainBg.New()
    self._editorBg = HomeMainBg.New()
    self._mainBg:SetLoadedSuccessFunc(function()
      self._mainBg:SetLoadedSuccessFunc(nil)
      callback()
    end)
    self:RefreshHomeMainBg()
  end
end

function HomeController:UnloadMainBg()
  if self._mainBg ~= nil then
    self._mainBg:Delete()
    self._editorBg:Delete()
    self._mainBg = nil
    self._editorBg = nil
  end
end

function HomeController:__RecoverCMCamera()
  if IsNull(self._cm0) then
    return
  end
  local noise = self._cm0:GetCinemachineComponent(CS_CmCoreState.Noise)
  noise.m_AmplitudeGain = 0
  noise = self._cm1:GetCinemachineComponent(CS_CmCoreState.Noise)
  noise.m_AmplitudeGain = 0
end

function HomeController:GetLastCVId()
  return self.lastVoiceId
end

function HomeController:IsPlayLoginAnimationOnAutoShowOver()
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  if window ~= nil and window.homeAdjutant ~= nil then
    local IsPlayOnAutoShowOver = window.homeAdjutant:IsPlayLoginAnimationOnAutoShowOver()
    return IsPlayOnAutoShowOver
  end
end

function HomeController:SetLoginReadyFinished(flag)
  self._loginReadyFinished = flag
end

function HomeController:StopHomeVoice()
  if self._lastHomeVoicePlayback ~= nil then
    AudioManager:StopAudioByBack(self._lastHomeVoicePlayback)
    self._lastHomeVoicePlayback = nil
  end
  self:TryResetShowHeroVoice()
end

function HomeController:StopHomeSound()
  local oasisCtrl = ControllerManager:GetController(ControllerTypeId.OasisController)
  if oasisCtrl ~= nil and oasisCtrl.weatherCtrl ~= nil then
    oasisCtrl.weatherCtrl:StopWeatherEffect()
  end
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  if window ~= nil and window.homeAdjutant ~= nil and window.homeAdjutant.heroCubismInteration ~= nil then
    window.homeAdjutant.heroCubismInteration:StopCubismInterationAuido()
    window.homeAdjutant.heroCubismInteration:SetCoundPlaySound(false)
  end
  self:StopHomeVoice()
end

function HomeController:OnDelete()
  if self._autoJumpActCo ~= nil then
    GR.StopCoroutine(self._autoJumpActCo)
    self._autoJumpActCo = nil
  end
  UpdateManager:RemoveUpdate(self.__OnUpdate)
  MsgCenter:RemoveListener(eMsgEventId.UserNameChanged, self.__OnUpdatePlayerName)
  MsgCenter:RemoveListener(eMsgEventId.TaskSyncFinish, self.__OnUpdateTask)
  MsgCenter:RemoveListener(eMsgEventId.UIOasisShow, self.__UIOasisShow)
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onUpdateUncompletedEp)
  MsgCenter:RemoveListener(eMsgEventId.StaminaUpdate, self.__OnUpdateStamina)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__OnUpdateHeroCollectRate)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnUpdateItem)
  MsgCenter:RemoveListener(eMsgEventId.ActivityShowChange, self.__OnActivityShowChange)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel, self.__OnPlayerLevelChange)
  MsgCenter:RemoveListener(eMsgEventId.OnReciveDormFightInvited, self.__OnReciveDormFightInvited)
  if self.__CheckInWarfarStage ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__CheckInWarfarStage)
    self.__CheckInWarfarStage = nil
  end
  self.oasisController = nil
  TimerManager:StopTimer(self.__animTimerId)
  if self.__fakeVoiceTimer ~= nil then
    TimerManager:StopTimer(self.__fakeVoiceTimer)
    self.__fakeVoiceTimer = nil
  end
  self:RemoveAllRedDotEvent()
  if self._mainBg ~= nil then
    self._mainBg:Delete()
    self._editorBg:Delete()
    self._mainBg = nil
    self._editorBg = nil
  end
  self._cm0 = nil
  self._cm1 = nil
  base.OnDelete(self)
end

return HomeController
