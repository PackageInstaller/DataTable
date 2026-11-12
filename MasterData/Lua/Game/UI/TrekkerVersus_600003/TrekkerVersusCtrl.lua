local TrekkerVersusCtrl = class("TrekkerVersusCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local ClientManager = CS.ClientManager.Instance
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
local LocalData = require("GameCore.Data.LocalData")
TrekkerVersusCtrl._mapNodeConfig = {
  TopBarPanel = {
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  TMPTitleChallenge = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_ChallengeTitle"
  },
  TMPStartChallenge = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_ChallengeBtn"
  },
  imgBgLevelSelect = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  trActor2D_L2D_FavourUp = {
    sNodeName = "----Actor2D_FavourUp----",
    sComponentName = "RawImage"
  },
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  trActor2D_PNG_FavourUp = {
    sNodeName = "----Actor2D_PNG_FavourUp----",
    sComponentName = "Transform"
  },
  TMPNpcName = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_NPC2"
  },
  TMPSubTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_NPC1"
  },
  TMPSubName = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_NPC3"
  },
  TMPNpcTime = {sComponentName = "TMP_Text"},
  TMPNpcDate = {sComponentName = "TMP_Text"},
  TMPActivityTime = {sComponentName = "TMP_Text"},
  goBubbleRoot = {
    sNodeName = "----fixed_bubble----"
  },
  btnNpc = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Npc"
  },
  btnChallenge = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Challenge"
  },
  btnFinishMask = {},
  TMPFinish = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_End"
  },
  imgTimeBg = {
    sNodeName = "imgTimeBgActivity"
  },
  btnRankRewardChallenge = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardChallenge"
  },
  btnDiffPreview = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Difficulty"
  },
  txtBtnRankRewardChallenge = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_QusetBtn"
  },
  goDuelResultBlur = {},
  animDuelResultBlur = {
    sNodeName = "goDuelResultBlur",
    sComponentName = "Animator"
  },
  txtPityLose = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_PityLose"
  },
  imgHeadHeatDuelResultStreamer = {nCount = 2, sComponentName = "Image"},
  txtNameHeatDuelResultStreamer = {nCount = 2, sComponentName = "TMP_Text"},
  txtHeatHeatDuelResultStreamer = {nCount = 2, sComponentName = "TMP_Text"},
  Emoji = {},
  goStreamerFavourUp = {},
  animStreamerFavourUp = {
    sNodeName = "goStreamerFavourUp",
    sComponentName = "Animator"
  },
  btnCloseFavourUp = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseFavourUp"
  },
  btnDuelResult = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DuelResult"
  },
  txtFanLevelUp = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_FanLevelUp"
  },
  imgStreamerInfo = {},
  imgTabOn = {nCount = 2},
  imgTabOff = {nCount = 2},
  txtTabOn1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_HeatDuel"
  },
  txtTabOff1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_HeatDuel"
  },
  txtTabOn2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_FanGift"
  },
  txtTabOff2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_FanGift"
  },
  btnStreamerInfoTab = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_StreamerInfoTab"
  },
  rtHeatDuel = {},
  imgHeadStreamerOne = {sComponentName = "Image"},
  imgHeadStreamerTwo = {sComponentName = "Image"},
  txtNameStreamerOne = {sComponentName = "TMP_Text"},
  txtNameStreamerTwo = {sComponentName = "TMP_Text"},
  txtHeatStreamerOne = {sComponentName = "TMP_Text"},
  txtHeatStreamerTwo = {sComponentName = "TMP_Text"},
  txtCurDuelLeftTime = {sComponentName = "TMP_Text"},
  txtDuelRewardTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_DuelRewardTip"
  },
  btnDuelRewardTip = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DuelHistory"
  },
  goRedDotDuelRewardTip = {},
  goHeatDuelOnGoing = {},
  goHeatDuelEnd = {},
  imgStreamer = {nCount = 3},
  imgHeadStreamer = {nCount = 3, sComponentName = "Image"},
  txtNameStreamer = {nCount = 3, sComponentName = "TMP_Text"},
  txtHeatStreamer = {nCount = 3, sComponentName = "TMP_Text"},
  txtHeatDuelEndTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_HeatDuelEndTip"
  },
  rtFanGift = {},
  txtNameFanBanner = {sComponentName = "TMP_Text"},
  imgHeadFanBanner = {sComponentName = "Image"},
  goFanBannerHonorTitle = {
    sCtrlName = "Game.UI.FriendEx.HonorTitleCtrl"
  },
  goFanInfoHonorTitle = {
    sCtrlName = "Game.UI.FriendEx.HonorTitleCtrl"
  },
  txtContributeTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_ContributeTitle"
  },
  txtFillerNum = {sComponentName = "TMP_Text"},
  goRedDotBtnGiftRewardDetail = {},
  btnRewardDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GiftReward"
  },
  txtRewardDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_Reward_Btn"
  },
  btnSendGift = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SendGift"
  },
  txtSendGift = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_SendGift"
  },
  imgBarFiller = {sComponentName = "Image"},
  imgBarFillerPreview = {sComponentName = "Image"},
  goMat = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateMatGridCtrl"
  },
  btnAddGift = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Add"
  },
  btnReduce = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reduce"
  },
  btnAutoFill = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AutoFill"
  },
  txtAutoFill = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_AutoFill"
  },
  imgDuelRecord = {},
  goHasDuelRecord = {},
  goNoDuelRecord = {},
  txtNoRecordTipBig = {
    sComponentName = "TMP_Text",
    sLanguageId = "STRanking_PlayerInfo_Empty"
  },
  txtNoRecordTipSmall = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_NoRecordTipSmall"
  },
  txtHighestRecord = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_RecordTitle"
  },
  txtHighestRecordNum = {sComponentName = "TMP_Text"},
  txtTimeAccumulated = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_TimeAccumulated"
  },
  txtTimeAccumulatedNum = {sComponentName = "TMP_Text"},
  goHasTimeReward = {},
  btnReceiveTimeReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ReceiveTimeReward"
  },
  goNoTimeReward = {},
  txtNoTimeReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_NoTimeReward"
  },
  goIdleRewardOnGoing = {},
  goIdleRewardEnd = {},
  txtIdleRewardEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_End"
  },
  btnTimeReward = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_TimeReward"
  },
  txtReceiveTimeReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Achievement_Btn_Receive"
  },
  goTimeReward = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnRecord = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Difficulty"
  },
  goRedDotBtnRecord = {},
  btnGoToGift = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoToGift"
  },
  txtBtnGoToGift = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_GoToGift"
  },
  rt_ChallengeInfo = {
    sCtrlName = "Game.UI.TrekkerVersus_600003.TravelerDuelChallengeInfoCtrl"
  },
  rt_TravelerDuelSelect = {},
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  goEnemyInfo = {
    sCtrlName = "Game.UI.MainlineEx.MainlineMonsterInfoCtrl"
  },
  imgHeatIndicator = {},
  animHeatIndicator = {
    sNodeName = "imgHeatIndicator",
    sComponentName = "Animator"
  },
  txtHeatIndicatorNum = {sComponentName = "TMP_Text"},
  txtHeatIndicatorTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_HeatQuestTitle"
  },
  txtHeatIndicatorUp = {sComponentName = "TMP_Text"},
  btnHeatReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_HeatReward"
  },
  txtBtnHeatReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_HeatReward"
  },
  goRewardPanel = {
    sCtrlName = "Game.UI.TrekkerVersus_600003.TrekkerVersusQuestCtrl"
  },
  goDifficultyPreview = {
    sCtrlName = "Game.UI.TrekkerVersus_600003.TrekkerVersusDifficultyCtrl"
  },
  Left_Firework = {},
  Right_Firework = {},
  Middle_Firework = {},
  Flower_Single = {},
  Flower_Firework = {},
  Left_FF = {},
  Right_FF = {},
  Flower_FF = {},
  Rocket_Single = {},
  Rocket_Firework = {},
  Left_RF = {},
  Right_RF = {},
  Middle_RF = {},
  Rocket_Flower = {},
  All = {},
  Left_AF = {},
  Right_AF = {},
  Planet_01_AF = {},
  Planet_02_AF = {},
  Planet_03_AF = {},
  Planet_04_AF = {},
  animGiftEff = {sNodeName = "goGift", sComponentName = "Animator"},
  goGiftEffBlur = {},
  btnJumpGiftEff = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseSendGiftEffect"
  },
  Emoji_Rival = {},
  animEmoji_Rival = {
    sNodeName = "Emoji_Rival",
    sComponentName = "Animator"
  },
  animEmoji_Npc = {sNodeName = "Emoji_Npc", sComponentName = "Animator"},
  goRedDotBtnHeatReward = {},
  goRedDotRankRewardChallenge = {},
  goRedDotBtnIdleReward = {}
}
TrekkerVersusCtrl._mapEventConfig = {
  TrekkerVersusTimeRefresh = "OnEvent_TrekkerVersusTimeRefresh",
  TrekkerVersusNPCTitleRefresh = "OnEvent_NPCTitleRefresh",
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.ShowBubbleVoiceText] = "OnEvent_ShowBubbleVoiceText",
  TrekkerVersusAffixJump = "OnEvent_TrekkerVersusAffixJump",
  TrekkerVersusSelectAffix = "OnEvent_TrekkerVersusSelectAffix",
  TrekkerVersusIdleRewardRefresh = "OnEvent_TrekkerVersusIdleRewardRefresh",
  TrekkerVersusHeatQuestJump = "OnEvent_TrekkerVersusHeatQuestJump",
  TrekkerVersusFanGiftShowRefresh = "OnEvent_TrekkerVersusFanGiftShowRefresh",
  UpdateTrekkerVersusHotValue = "OnEvent_UpdateTrekkerVersusHotValue",
  ForceOpenDuelResult = "OnEvent_ForceOpenDuelResult",
  TrekkerVersusQuestRefresh = "RefreshFanGift",
  TrekkerVersusHeatQuestRefresh = "RefreshFanGift",
  TrekkerVersusDuelQuestRefresh = "RefreshFanGift"
}
TrekkerVersusCtrl._mapRedDotConfig = {}

function TrekkerVersusCtrl:Awake()
  self.npcTimer = nil
  self.battleRefreshTimer = nil
  self.tbRecordAffixGrid = {}
  local tbParam = self:GetPanelParam()
  self.tbAllAffix = {}
  local tbAffixCfgData = ConfigTable.GetData("TravelerDuelChallengeControl", tbParam[1])
  if tbAffixCfgData == nil then
    printError("Activity Data Missing：" .. tbParam[1])
    return
  end
  local tbRawData = decodeJson(tbAffixCfgData.AffixGroupIds)
  local mapAffixes = {}
  if tbRawData ~= nil then
    local function forEachAffix(mapData)
      if table.indexof(tbRawData, mapData.GroupId) > 0 and mapData.GroupId ~= 0 then
        if mapAffixes[mapData.GroupId] == nil then
          mapAffixes[mapData.GroupId] = {}
        end
        table.insert(mapAffixes[mapData.GroupId], mapData.Id)
      end
    end
    
    ForEachTableLine(DataTable.TravelerDuelChallengeAffix, forEachAffix)
  end
  
  local function Sort(a, b)
    local mapCfgDataA = ConfigTable.GetData("TravelerDuelChallengeAffix", a)
    local mapCfgDataB = ConfigTable.GetData("TravelerDuelChallengeAffix", b)
    if mapCfgDataA == nil or mapCfgDataB == nil then
      return mapCfgDataA ~= nil
    end
    if mapCfgDataA.Difficulty ~= mapCfgDataB.Difficulty then
      return mapCfgDataA.Difficulty < mapCfgDataB.Difficulty
    end
    return a < b
  end
  
  for _, tbAffixes in pairs(mapAffixes) do
    table.sort(tbAffixes, Sort)
  end
  for _, nGroupId in pairs(tbRawData) do
    if nGroupId == 0 then
      table.insert(self.tbAllAffix, {0, 0})
    elseif mapAffixes[nGroupId] ~= nil then
      for _, value in pairs(mapAffixes[nGroupId]) do
        table.insert(self.tbAllAffix, {value, nGroupId})
      end
    end
  end
  self.tbFanLevelData = {}
  ForEachTableLine(DataTable.TravelerDuelFansLevel, function(mapData)
    if mapData.GroupId == tbParam[1] then
      table.insert(self.tbFanLevelData, mapData)
    end
  end)
end

function TrekkerVersusCtrl:OnEnable()
  math.randomseed(os.time())
  math.random()
  math.random()
  math.random()
  self.animTimer = nil
  self._mapNode.goRewardPanel.gameObject:SetActive(false)
  self._mapNode.goDuelResultBlur.gameObject:SetActive(false)
  self._mapNode.animGiftEff.gameObject:SetActive(false)
  local tbParam = self:GetPanelParam()
  self.mapAffixGrid = {}
  self._nActId = tbParam[1]
  self._ActData = PlayerData.Activity:GetActivityDataById(self._nActId)
  self:RegisterRedDot()
  if self._ActData == nil then
    printError("活动数据不存在：" .. self._nActId)
    return
  end
  self.mapActivityData = self._ActData:GetActivityData()
  local mapActivityData = ConfigTable.GetData("TravelerDuelChallengeControl", self._nActId)
  self.sSelfName = ConfigTable.GetUIText(AllEnum.TrekkerVersusDuelSelfInfo.NameKey) or ""
  self.nRivalCount = self._ActData:GetRivalCount()
  self.bOpenSteamerDuel = false
  self.bOpenBattle = false
  if mapActivityData ~= nil then
    self.bOpenBattle = self:IsOpenBattle(mapActivityData.OpenTime, mapActivityData.EndTime)
    self.bOpenSteamerDuel = self:IsOpenStreamerDuel(mapActivityData.OpenTime)
  end
  self:RefreshOpenBattle()
  local curTime = ClientManager.serverTimeStamp
  local month = os.date("%m", curTime)
  local day = os.date("%d", curTime)
  local hour = os.date("%H", curTime)
  local min = os.date("%M", curTime)
  NovaAPI.SetTMPText(self._mapNode.TMPNpcDate, string.format("%s/%s", month, day))
  NovaAPI.SetTMPText(self._mapNode.TMPNpcTime, string.format("%s:%s", hour, min))
  if nil == self.npcTimer then
    self.npcTimer = self:AddTimer(0, 60, function()
      EventManager.Hit("TrekkerVersusNPCTitleRefresh")
    end, true, true, true)
  end
  local bUseL2D = LocalSettingData.mapData.UseLive2D
  self._mapNode.imgBgLevelSelect.transform.localScale = bUseL2D == true and Vector3.one or Vector3.zero
  self._mapNode.trActor2D_PNG.localScale = bUseL2D == true and Vector3.zero or Vector3.one
  if bUseL2D == true then
    Actor2DManager.SetBoardNPC2D(self:GetPanelId(), self._mapNode.imgBgLevelSelect, 917202)
  else
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.trActor2D_PNG, self:GetPanelId(), 917202)
  end
  local mapHeatValue = self._ActData:GetCurHeatValue()
  NovaAPI.SetTMPText(self._mapNode.txtHeatIndicatorNum, mapHeatValue.nSelfHotValue)
end

function TrekkerVersusCtrl:FadeIn()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    if self._panel.curState == nil then
      self._panel.curState = 1
    end
    if self._panel.curState == 1 then
      self:RequestMainViewInfo(function()
        self._mapNode.animRoot:Play("TrekkerVersuslLevelSelect_in")
        self:CheckDailyDuelResult()
        self:NpcVoice()
        PlayerData.Voice:StartBoardFreeTimer(917202)
      end)
    else
      self:OnBtnClick_Challenge(nil)
    end
  end
  
  self._mapNode.imgHeatIndicator.gameObject:SetActive(false)
  self._mapNode.imgStreamerInfo.gameObject:SetActive(false)
  self._mapNode.imgDuelRecord.gameObject:SetActive(false)
  self._coroutine = cs_coroutine.start(wait)
end

function TrekkerVersusCtrl:OnDisable()
  if self.timerIdleReward ~= nil then
    self.timerIdleReward:Cancel()
    self.timerIdleReward = nil
  end
  if self.timerRefreshIdleReward ~= nil then
    self.timerRefreshIdleReward:Cancel()
    self.timerRefreshIdleReward = nil
  end
  if self.npcTimer ~= nil then
    self.npcTimer:Cancel()
    self.npcTimer = nil
  end
  if self.battleRefreshTimer ~= nil then
    self.battleRefreshTimer:Cancel()
    self.battleRefreshTimer = nil
  end
  if self._coroutineGift ~= nil then
    cs_coroutine.stop(self._coroutineGift)
    self._coroutineGift = nil
  end
  if self._coroutine ~= nil then
    cs_coroutine.stop(self._coroutine)
    self._coroutine = nil
  end
  self:RemoveAllGrids()
  Actor2DManager.UnsetBoardNPC2D()
  PlayerData.Voice:StopCharVoice()
  PlayerData.Voice:ClearTimer()
  BubbleVoiceManager.StopBubbleAnim()
end

function TrekkerVersusCtrl:OnDestroy()
end

function TrekkerVersusCtrl:OnRelease()
end

function TrekkerVersusCtrl:RegisterRedDot()
  local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self._nActId)
  if bInActGroup then
    RedDotManager.RegisterNode(RedDotDefine.TrekkerVersusQuest_1, {
      nActGroupId,
      self._nActId
    }, self._mapNode.goRedDotBtnHeatReward)
    RedDotManager.RegisterNode(RedDotDefine.TrekkerVersusIdleReward, {
      nActGroupId,
      self._nActId
    }, self._mapNode.goRedDotBtnIdleReward)
    RedDotManager.RegisterNode(RedDotDefine.TrekkerVersusBattleQuest, {
      nActGroupId,
      self._nActId
    }, self._mapNode.goRedDotRankRewardChallenge)
    RedDotManager.RegisterNode(RedDotDefine.TrekkerVersusDuelQuest, {
      nActGroupId,
      self._nActId
    }, self._mapNode.goRedDotDuelRewardTip)
    RedDotManager.RegisterNode(RedDotDefine.TrekkerVersusGiftQuest, {
      nActGroupId,
      self._nActId
    }, self._mapNode.goRedDotBtnGiftRewardDetail)
  end
end

function TrekkerVersusCtrl:RequestMainViewInfo(callback)
  self._ActData:RequestIdleRefresh(self._nActId, function()
    self:RefreshIdleReward()
    self:RefreshHeatValue()
    self:OnBtnClick_StreamerInfoTab(nil, 1)
    self._mapNode.imgHeatIndicator.gameObject:SetActive(true)
    self._mapNode.imgStreamerInfo.gameObject:SetActive(true)
    self._mapNode.imgDuelRecord.gameObject:SetActive(true)
    EventManager.Hit(EventId.SetTransition)
    if self.timerRefreshIdleReward ~= nil then
      self.timerRefreshIdleReward:Cancel()
      self.timerRefreshIdleReward = nil
    end
    self.timerRefreshIdleReward = self:AddTimer(0, 60, function()
      self._ActData:RequestIdleRefresh(self._nActId, function(msgData)
        self:RefreshIdleReward()
        self:RefreshHeatValue()
        self:RefreshStreamerInfo()
      end)
    end, true, true, true)
    if callback ~= nil then
      callback()
    end
  end)
end

function TrekkerVersusCtrl:CheckDailyDuelResult()
  self.nDayNum = self._ActData:GetCurDayNum()
  self.bFirstInToday = self:CheckFirstEnterToday()
  if not self.bFirstInToday or self.nDayNum == 1 or not self.bOpenBattle then
    return
  end
  local tbDuelHistory = self._ActData:GetDuelHistory()
  if tbDuelHistory == nil or #tbDuelHistory == 0 then
    return
  end
  PlayerData.Voice:StopCharVoice()
  EventManager.Hit(EventId.TemporaryBlockInput, 0.6)
  self:AddTimer(1, 0.6, function()
    self:PlayDuelResultAnim()
  end, true, true, true)
end

function TrekkerVersusCtrl:IsOpenBattle(sStartTime, sEndTime)
  if string.len(sStartTime) == 0 or string.len(sEndTime) == 0 then
    return true
  end
  local nowTime = CS.ClientManager.Instance.serverTimeStamp
  local nStartTime = String2Time(sStartTime)
  local nEndTime = String2Time(sEndTime)
  return nowTime > nStartTime and nowTime < nEndTime
end

function TrekkerVersusCtrl:IsOpenStreamerDuel(sStartTime)
  if string.len(sStartTime) == 0 then
    return true
  end
  local nowTime = CS.ClientManager.Instance.serverTimeStamp
  local nStartTime = String2Time(sStartTime)
  local nEndTime = CS.ClientManager.Instance:GetNextRefreshTime(nStartTime) + 86400 * (self.nRivalCount - 1)
  return nowTime > nStartTime and nowTime < nEndTime
end

function TrekkerVersusCtrl:RefreshOpenBattle()
  self:OnEvent_TrekkerVersusTimeRefresh()
  local mapActivityData = ConfigTable.GetData("TravelerDuelChallengeControl", self._nActId)
  local bOpen = false
  if mapActivityData ~= nil then
    bOpen = self:IsOpenBattle(mapActivityData.OpenTime, mapActivityData.EndTime)
  end
  if bOpen then
    local function RefreshCallback()
      EventManager.Hit("TrekkerVersusTimeRefresh")
    end
    
    if nil ~= self.battleRefreshTimer then
      self.battleRefreshTimer:Cancel()
      self.battleRefreshTimer = nil
    end
    self.battleRefreshTimer = self:AddTimer(0, 60, RefreshCallback, true, true, true)
  end
end

function TrekkerVersusCtrl:OnRecordAffixGridRefresh(goGrid, gridIndex)
  if self.mapAffixGrid[goGrid] == nil then
    self.mapAffixGrid[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.TrekkerVersus_600003.TravelerDuelChallengeAffixGrid")
  end
  local nIdx = gridIndex + 1
  local nAffixId = self.mapActivityData.tbRecordAffix[nIdx]
  local bLine = false
  self.mapAffixGrid[goGrid]:Refresh(nAffixId, false, false, bLine, self._ActData)
end

function TrekkerVersusCtrl:RemoveAllGrids()
  if self.mapAffixGrid ~= nil then
    for go, mapCtrl in pairs(self.mapAffixGrid) do
      self:UnbindCtrlByNode(mapCtrl)
      mapCtrl = nil
    end
  end
  self.mapAffixGrid = {}
end

function TrekkerVersusCtrl:RefreshTimeout(remainTime)
  local sTimeStr = ""
  if remainTime <= 60 then
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Depot_LeftTime_LessThenMin"))
  elseif remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Disc_MusicTimeMin"), min)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  return sTimeStr
end

function TrekkerVersusCtrl:RefreshStreamerInfo()
  local mapDuelData = self._ActData:GetCurStreamerDuelData()
  if mapDuelData == nil then
    self._mapNode.imgStreamerInfo.gameObject:SetActive(false)
    return
  end
  self._mapNode.imgStreamerInfo.gameObject:SetActive(true)
  self._mapNode.goHeatDuelOnGoing:SetActive(self.bOpenSteamerDuel)
  self._mapNode.goHeatDuelEnd:SetActive(not self.bOpenSteamerDuel)
  local mapHeatData = self._ActData:GetCurHeatValue()
  local tbDuelHistory = self._ActData:GetDuelHistory()
  if self.bOpenSteamerDuel == false then
    if tbDuelHistory == nil or #tbDuelHistory == 0 then
      for i = 1, #self._mapNode.txtNameStreamer do
        self._mapNode.imgStreamer[i].gameObject:SetActive(false)
      end
      return
    end
    self._mapNode.txtNameStreamer[1]:SetText(self.sSelfName or "")
    local sHeatTxt = ConfigTable.GetUIText("TD_HeatQuestTab") or ""
    NovaAPI.SetTMPText(self._mapNode.txtHeatStreamer[1], sHeatTxt .. "<space=9>" .. mapHeatData.nSelfHotValue)
    for i = 2, #self._mapNode.txtNameStreamer do
      local mapDuelHistoryData = tbDuelHistory[i - 1]
      if mapDuelHistoryData == nil then
        self._mapNode.imgStreamer[i].gameObject:SetActive(false)
      else
        local mapDuelRivalData = ConfigTable.GetData("TravelerDuelTarget", mapDuelHistoryData.TargetId)
        if mapDuelRivalData ~= nil then
          self._mapNode.txtNameStreamer[i]:SetText(mapDuelRivalData.RivalName or "")
          NovaAPI.SetTMPText(self._mapNode.txtHeatStreamer[i], sHeatTxt .. "<space=9>" .. (mapDuelHistoryData.RivalHotValue or 0))
          self:SetPngSprite(self._mapNode.imgHeadStreamer[i], mapDuelRivalData.RivalIcon)
        end
      end
    end
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtNameStreamerOne, self.sSelfName)
  local sHeatTxt = ConfigTable.GetUIText("TD_HeatQuestTab") or ""
  NovaAPI.SetTMPText(self._mapNode.txtHeatStreamerOne, sHeatTxt .. "<space=9>" .. (mapHeatData.nSelfHotValue or 0))
  NovaAPI.SetTMPText(self._mapNode.txtNameStreamerTwo, mapDuelData.RivalName or "")
  self:SetPngSprite(self._mapNode.imgHeadStreamerTwo, mapDuelData.RivalIcon)
  NovaAPI.SetTMPText(self._mapNode.txtHeatStreamerTwo, sHeatTxt .. "<space=9>" .. (mapHeatData.nRivalHotValue or 0))
  local nCurTime = ClientManager.serverTimeStamp
  local nNextRefreshTime = CS.ClientManager.Instance:GetNextRefreshTime(nCurTime)
  local sRemainTime = self:RefreshTimeout(nNextRefreshTime - nCurTime)
  local sText = ConfigTable.GetUIText("Depot_LeftTime") or ""
  NovaAPI.SetTMPText(self._mapNode.txtCurDuelLeftTime, sText .. "<space=9>:<space=9>" .. sRemainTime)
end

local nMaxFillWidth = 252
local nMaxFillWidthPreview = 253

function TrekkerVersusCtrl:RefreshFanGift()
  NovaAPI.SetTMPText(self._mapNode.txtNameFanBanner, PlayerData.Base:GetPlayerNickName())
  local nHeadId = PlayerData.Base:GetPlayerHeadId()
  local mapCfg = ConfigTable.GetData("PlayerHead", nHeadId)
  if mapCfg ~= nil then
    local sIcon = mapCfg.Icon
    if string.find(sIcon, "_XXL") ~= nil then
      sIcon = string.sub(sIcon, 1, -5) .. AllEnum.CharHeadIconSurfix.SS
    end
    self:SetPngSprite(self._mapNode.imgHeadFanBanner, sIcon)
  end
  local mapActivityData = ConfigTable.GetData("TravelerDuelChallengeControl", self._nActId)
  local nHonorTitleId = mapActivityData.HonorId
  local nFanLevel = self._ActData:GetCurFanData().nFanLevel or 1
  local nFanExp = self._ActData:GetCurFanData().nFanExp or 0
  local nNextLevelExp = self.tbFanLevelData[1].NeedExp or 1
  if nFanLevel < #self.tbFanLevelData then
    nNextLevelExp = self.tbFanLevelData[nFanLevel + 1].NeedExp - self.tbFanLevelData[nFanLevel].NeedExp
  end
  self._mapNode.goFanInfoHonorTitle:SetHonotTitle(nHonorTitleId, true, nFanLevel)
  NovaAPI.SetTMPText(self._mapNode.txtFillerNum, nFanExp .. "/" .. nNextLevelExp)
  local nFillWidth = nFanExp / nNextLevelExp * nMaxFillWidth
  if nFillWidth < 30 and 0 < nFillWidth then
    nFillWidth = 30
  elseif nFillWidth <= 0 then
    nFillWidth = 0
  elseif nFillWidth > nMaxFillWidth then
    nFillWidth = nMaxFillWidth
  end
  self._mapNode.imgBarFillerPreview.gameObject:SetActive(false)
  self._mapNode.imgBarFiller.gameObject:SetActive(true)
  self._mapNode.imgBarFiller.rectTransform.sizeDelta = Vector2(nFillWidth, self._mapNode.imgBarFiller.rectTransform.sizeDelta.y)
  self._mapNode.imgBarFiller.rectTransform:GetChild(0).gameObject:SetActive(0 < nFillWidth)
  if nFanLevel == #self.tbFanLevelData then
    NovaAPI.SetTMPText(self._mapNode.txtFillerNum, ConfigTable.GetUIText("Equipment_MaxLevel") or "")
    self._mapNode.imgBarFiller.rectTransform.sizeDelta = Vector2(nMaxFillWidth, self._mapNode.imgBarFiller.rectTransform.sizeDelta.y)
  end
  self.tbFanGiftItem = {}
  self.tbSelectedFanGift = {}
  
  local function foreachHotValueItem(mapData)
    table.insert(self.tbSelectedFanGift, {
      nId = mapData.Id,
      nCount = 0
    })
    table.insert(self.tbFanGiftItem, {
      nId = mapData.Id,
      nCount = PlayerData.Item:GetItemCountByID(mapData.Id)
    })
  end
  
  ForEachTableLine(DataTable.TravelerDuelHotValueItem, foreachHotValueItem)
  for i = 1, 3 do
    local nFanGiftItemId = self.tbFanGiftItem[i].nId
    self._mapNode.goMat[i]:RerfeshGrid({nId = nFanGiftItemId})
  end
end

function TrekkerVersusCtrl:RefreshMat()
  for i = 1, 3 do
    self._mapNode.goMat[i]:SetGridCount(self.tbSelectedFanGift[i].nCount or 0)
  end
end

function TrekkerVersusCtrl:RefreshHeatValue()
  local mapHeatValue = self._ActData:GetCurHeatValue()
  NovaAPI.SetTMPText(self._mapNode.txtHeatIndicatorNum, mapHeatValue.nSelfHotValue)
end

function TrekkerVersusCtrl:RefreshIdleReward()
  self._mapNode.goIdleRewardEnd:SetActive(not self.bOpenBattle)
  self._mapNode.goIdleRewardOnGoing:SetActive(self.bOpenBattle)
  local nCurRecord = self._ActData:GetRecordLevel() or 0
  local bFirstBattlePlayed = self._ActData:CheckBattlePlayed()
  self._mapNode.goHasDuelRecord:SetActive(bFirstBattlePlayed)
  self._mapNode.goNoDuelRecord:SetActive(not bFirstBattlePlayed)
  if not bFirstBattlePlayed then
    return
  end
  self.nLocalRecord = LocalData.GetPlayerLocalData("TrekkerVersus_600003_RecordLevel") or 0
  if nCurRecord > self.nLocalRecord then
    self.nLocalRecord = nCurRecord
    LocalData.SetPlayerLocalData("TrekkerVersus_600003_RecordLevel", nCurRecord)
    self._mapNode.goRedDotBtnRecord:SetActive(true)
  else
    self._mapNode.goRedDotBtnRecord:SetActive(false)
  end
  NovaAPI.SetTMPText(self._mapNode.txtHighestRecordNum, nCurRecord)
  local nTimeIdleReward = self._ActData:GetIdleRewardStartTime() or 0
  self.nElapsedTime = CS.ClientManager.Instance.serverTimeStamp - nTimeIdleReward
  local sTimeStr = self:RefreshTimeout(self.nElapsedTime)
  local nMaxIdleRewardTime = ConfigTable.GetConfigNumber("TrekkerVersusIdleRewardMaxTime")
  if self.nElapsedTime >= nMaxIdleRewardTime * 3600 then
    sTimeStr = orderedFormat(ConfigTable.GetUIText("TrekkerVersus_MaxIdleRewardReached"), nMaxIdleRewardTime)
  end
  NovaAPI.SetTMPText(self._mapNode.txtTimeAccumulatedNum, sTimeStr)
  self.tbIdleReward = self._ActData:GetIdleReward()
  if self.tbIdleReward == nil or #self.tbIdleReward == 0 then
    self._mapNode.goNoTimeReward:SetActive(true)
    self._mapNode.goHasTimeReward:SetActive(false)
    return
  end
  self._mapNode.goIdleRewardEnd:SetActive(false)
  self._mapNode.goIdleRewardOnGoing:SetActive(true)
  self._mapNode.goNoTimeReward:SetActive(false)
  self._mapNode.goHasTimeReward:SetActive(true)
  self.tbFanGiftItemShow = {}
  local nItemGridIndex = 3
  for i = 1, 3 do
    local mapItemData = self.tbIdleReward[i]
    if mapItemData ~= nil and 0 < mapItemData.Qty then
      self._mapNode.btnTimeReward[nItemGridIndex].gameObject:SetActive(true)
      self._mapNode.goTimeReward[nItemGridIndex]:SetItem(mapItemData.Tid, nil, mapItemData.Qty or 0)
      table.insert(self.tbFanGiftItemShow, mapItemData.Tid)
    else
      self._mapNode.btnTimeReward[nItemGridIndex].gameObject:SetActive(false)
      table.insert(self.tbFanGiftItemShow, 0)
    end
    nItemGridIndex = nItemGridIndex - 1
  end
end

local function ActiveRandomChild(trNode)
  local nChildCount = trNode.childCount - 1
  for i = 0, nChildCount do
    trNode:GetChild(i).gameObject:SetActive(false)
  end
  trNode:GetChild(math.random(0, nChildCount)).gameObject:SetActive(true)
end

local tbRivalEmoji = {
  [3] = "Sweaty",
  [4] = "Vexation",
  [1] = "Angry",
  [2] = "Question"
}

function TrekkerVersusCtrl:RefreshDuelResult()
  math.randomseed(os.time())
  math.random()
  math.random()
  math.random()
  local tbDuelHistory = self._ActData:GetDuelHistory()
  if tbDuelHistory ~= nil and 0 < #tbDuelHistory then
    local tbLastDuel = tbDuelHistory[1]
    local sText = (ConfigTable.GetUIText("TD_HeatQuestTab") or "") .. ":"
    NovaAPI.SetTMPText(self._mapNode.txtHeatHeatDuelResultStreamer[1], sText .. "<space=9>" .. tbLastDuel.SelfHotValue)
    NovaAPI.SetTMPText(self._mapNode.txtHeatHeatDuelResultStreamer[2], sText .. "<space=9>" .. tbLastDuel.RivalHotValue)
    local nTargetId = tbLastDuel.TargetId
    local mapRivalData = ConfigTable.GetData("TravelerDuelTarget", nTargetId)
    local sSelfName = ConfigTable.GetUIText(AllEnum.TrekkerVersusDuelSelfInfo.NameKey) or ""
    NovaAPI.SetTMPText(self._mapNode.txtNameHeatDuelResultStreamer[1], sSelfName or "")
    if mapRivalData ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtNameHeatDuelResultStreamer[2], mapRivalData.RivalName or "")
      self:SetPngSprite(self._mapNode.imgHeadHeatDuelResultStreamer[2], mapRivalData.RivalIcon or "")
    end
  end
  local sEmojiNPCAnimPrefix = "TrekkerVersuslLevelSelect_Emoji_Npc_0"
  local sEmojiNPCAnim = sEmojiNPCAnimPrefix .. math.random(1, 3)
  local nFirstEmojiAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animEmoji_Npc, {sEmojiNPCAnim})
  self._mapNode.animEmoji_Npc:Play(sEmojiNPCAnim, 0, 0)
  self:AddTimer(1, nFirstEmojiAnimTime, function()
    self._mapNode.animEmoji_Npc:Play(sEmojiNPCAnimPrefix .. 4, 0, 0)
  end, true, true, true)
  local nChildCount = self._mapNode.Emoji_Rival.transform.childCount
  for i = 0, nChildCount - 1 do
    self._mapNode.Emoji_Rival.transform:GetChild(i).gameObject:SetActive(false)
  end
  local nRandom = math.random(0, nChildCount - 1)
  self._mapNode.Emoji_Rival.transform:GetChild(nRandom).gameObject:SetActive(true)
  local sRivalEmojiAnim = "TrekkerVersuslLevelSelect_Emoji_" .. tbRivalEmoji[nRandom + 1]
  self._mapNode.animEmoji_Rival:Play(sRivalEmojiAnim, 0, 0)
end

function TrekkerVersusCtrl:CheckFirstEnterToday()
  local sKey = "TrekkerVersusEnterTime" .. PlayerData.Base:GetPlayerId()
  local sTime = LocalData.GetPlayerLocalData(sKey)
  local nSavedTime = tonumber(sTime) or 0
  local nNow = ClientManager.serverTimeStamp
  local nNextRefresh = ClientManager:GetNextRefreshTime(nSavedTime)
  if nNow >= nNextRefresh then
    LocalData.SetPlayerLocalData(sKey, tostring(nNow))
    local sKey1 = "TrekkerVersusLastDuelResultShowed" .. PlayerData.Base:GetPlayerId() .. self._nActId
    local bShowed = LocalData.GetPlayerLocalData(sKey1) == "1"
    if self.bOpenSteamerDuel == false and not bShowed then
      LocalData.SetPlayerLocalData(sKey1, "1")
    elseif bShowed then
      return false
    end
    return true
  end
  return false
end

function TrekkerVersusCtrl:PlayDuelResultAnim()
  self._mapNode.btnDuelResult.gameObject:SetActive(false)
  self._mapNode.goDuelResultBlur:SetActive(true)
  self:RefreshDuelResult()
  local sAnimName = "TrekkerVersuslLevelSelect_Duel_0" .. math.random(1, 2)
  self._mapNode.animDuelResultBlur:Play(sAnimName, 0, 0)
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animDuelResultBlur, {sAnimName})
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
  self:AddTimer(1, nAnimTime, function()
    self._mapNode.btnDuelResult.gameObject:SetActive(true)
  end, true, true, true)
  self.bFirstInToday = false
end

function TrekkerVersusCtrl:PlaySendGiftEffect(tbUsedFanGift)
  local nAnimName = ""
  self._mapNode.Left_Firework:SetActive(false)
  self._mapNode.Right_Firework:SetActive(false)
  self._mapNode.Middle_Firework:SetActive(false)
  self._mapNode.Left_FF:SetActive(false)
  self._mapNode.Right_FF:SetActive(false)
  self._mapNode.Flower_FF:SetActive(false)
  self._mapNode.Flower_Single:SetActive(false)
  self._mapNode.Rocket_Single:SetActive(false)
  self._mapNode.Rocket_Firework:SetActive(false)
  self._mapNode.Left_RF:SetActive(false)
  self._mapNode.Right_RF:SetActive(false)
  self._mapNode.Middle_RF:SetActive(false)
  self._mapNode.Rocket_Flower:SetActive(false)
  self._mapNode.All:SetActive(false)
  self._mapNode.Left_AF:SetActive(false)
  self._mapNode.Right_AF:SetActive(false)
  self._mapNode.Planet_01_AF:SetActive(false)
  self._mapNode.Planet_02_AF:SetActive(false)
  self._mapNode.Planet_03_AF:SetActive(false)
  self._mapNode.Planet_04_AF:SetActive(false)
  self._mapNode.animGiftEff.gameObject:SetActive(true)
  self._mapNode.goGiftEffBlur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if tbUsedFanGift[2] and not tbUsedFanGift[1] and not tbUsedFanGift[3] then
      self._mapNode.Flower_Single:SetActive(true)
      nAnimName = "TrekkerVersuslLevelSelect_Gift_Flower"
    elseif tbUsedFanGift[1] and not tbUsedFanGift[2] and not tbUsedFanGift[3] then
      self._mapNode.Left_Firework:SetActive(true)
      ActiveRandomChild(self._mapNode.Left_Firework.transform)
      self._mapNode.Middle_Firework:SetActive(true)
      ActiveRandomChild(self._mapNode.Middle_Firework.transform)
      self._mapNode.Right_Firework:SetActive(true)
      ActiveRandomChild(self._mapNode.Right_Firework.transform)
      nAnimName = "TrekkerVersuslLevelSelect_Gift_Firework_0" .. math.random(1, 3)
    elseif tbUsedFanGift[3] and not tbUsedFanGift[1] and not tbUsedFanGift[2] then
      self._mapNode.Rocket_Single:SetActive(true)
      nAnimName = "TrekkerVersuslLevelSelect_Gift_Rocket"
    elseif tbUsedFanGift[1] and tbUsedFanGift[2] and not tbUsedFanGift[3] then
      self._mapNode.Flower_Firework:SetActive(true)
      self._mapNode.Flower_FF:SetActive(true)
      self._mapNode.Left_FF:SetActive(true)
      ActiveRandomChild(self._mapNode.Left_FF.transform)
      self._mapNode.Right_FF:SetActive(true)
      ActiveRandomChild(self._mapNode.Right_FF.transform)
      nAnimName = "TrekkerVersuslLevelSelect_Gift_Flower_Firework_0" .. math.random(1, 2)
    elseif not tbUsedFanGift[2] and tbUsedFanGift[1] and tbUsedFanGift[3] then
      self._mapNode.Rocket_Firework:SetActive(true)
      self._mapNode.Left_RF:SetActive(true)
      ActiveRandomChild(self._mapNode.Left_RF.transform)
      self._mapNode.Middle_RF:SetActive(true)
      ActiveRandomChild(self._mapNode.Middle_RF.transform)
      self._mapNode.Right_RF:SetActive(true)
      ActiveRandomChild(self._mapNode.Right_RF.transform)
      nAnimName = "TrekkerVersuslLevelSelect_Gift_Rocket_FireWork_0" .. math.random(1, 2)
    elseif tbUsedFanGift[2] and tbUsedFanGift[3] and not tbUsedFanGift[1] then
      self._mapNode.Rocket_Flower:SetActive(true)
      nAnimName = "TrekkerVersuslLevelSelect_Gift_Rocket_Flower"
    elseif tbUsedFanGift[1] and tbUsedFanGift[2] and tbUsedFanGift[3] then
      self._mapNode.All:SetActive(true)
      self._mapNode.Left_AF:SetActive(true)
      ActiveRandomChild(self._mapNode.Left_AF.transform)
      self._mapNode.Right_AF:SetActive(true)
      ActiveRandomChild(self._mapNode.Right_AF.transform)
      self._mapNode.Planet_01_AF:SetActive(true)
      ActiveRandomChild(self._mapNode.Planet_01_AF.transform)
      self._mapNode.Planet_02_AF:SetActive(true)
      ActiveRandomChild(self._mapNode.Planet_02_AF.transform)
      self._mapNode.Planet_03_AF:SetActive(true)
      ActiveRandomChild(self._mapNode.Planet_03_AF.transform)
      self._mapNode.Planet_04_AF:SetActive(true)
      ActiveRandomChild(self._mapNode.Planet_04_AF.transform)
      nAnimName = "TrekkerVersuslLevelSelect_Gift_All_01"
    end
    local sAnimTime = 1.2
    if nAnimName ~= "" then
      self._mapNode.animGiftEff:Play(nAnimName, 0, 0)
      sAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animGiftEff, {nAnimName})
    end
    if self.timerGiftEff ~= nil then
      self.timerGiftEff:Cancel()
      self.timerGiftEff = nil
    end
    self.timerGiftEff = self:AddTimer(1, sAnimTime, function()
      self:OnBtnClick_CloseSendGiftEffect()
    end, true, true, true)
  end
  
  self._coroutineGift = cs_coroutine.start(wait)
end

function TrekkerVersusCtrl:PlayFavourUpAnim()
  self.bPlayFavourUpAnim = false
  self._mapNode.btnCloseFavourUp.gameObject:SetActive(false)
  local mapActivityData = ConfigTable.GetData("TravelerDuelChallengeControl", self._nActId)
  local nHonorTitleId = mapActivityData.HonorId
  self._mapNode.goFanBannerHonorTitle:SetHonotTitle(nHonorTitleId, true, self._ActData:GetCurFanData().nFanLevel)
  self._mapNode.goStreamerFavourUp:SetActive(true)
  self._mapNode.trActor2D_PNG_FavourUp.localScale = Vector3.one
  Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.trActor2D_PNG_FavourUp, 217, 917204)
  CS.WwiseAudioManager.Instance:PlaySound("ui_duel_levelup")
  EventManager.Hit(EventId.TemporaryBlockInput, 1.33)
  self:AddTimer(1, 1.33, function()
    self._mapNode.btnCloseFavourUp.gameObject:SetActive(true)
    if self.nAddHotValue > 0 then
      self:RefreshAddHeatValue(self.nAddHotValue)
    end
  end, true, true, true)
end

function TrekkerVersusCtrl:RefreshAddHeatValue(nAddHotValue)
  if not self.bOpenBattle then
    return
  end
  self._mapNode.txtHeatIndicatorUp.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtHeatIndicatorUp, "+" .. nAddHotValue)
  self._mapNode.animHeatIndicator:Play("TrekkerVersuslLevelSelect_Heatlndicator_up", 0, 0)
  self.nAddHotValue = 0
end

function TrekkerVersusCtrl:OnEvent_ForceOpenDuelResult()
  self:PlayDuelResultAnim()
end

function TrekkerVersusCtrl:OnEvent_TrekkerVersusTimeRefresh()
  local mapActivityData = ConfigTable.GetData("TravelerDuelChallengeControl", self._nActId)
  local bOpen = false
  if mapActivityData ~= nil then
    bOpen = self:IsOpenBattle(mapActivityData.OpenTime, mapActivityData.EndTime)
  end
  if bOpen then
    self._mapNode.imgTimeBg:SetActive(true)
    local nEndTime = ClientManager:ISO8601StrToTimeStamp(mapActivityData.EndTime)
    local curTime = CS.ClientManager.Instance.serverTimeStamp
    local remainTime = nEndTime - curTime
    NovaAPI.SetTMPText(self._mapNode.TMPActivityTime, self:RefreshTimeout(remainTime))
    self._mapNode.btnFinishMask:SetActive(false)
    self._mapNode.btnChallenge.interactable = true
  else
    self._mapNode.imgTimeBg:SetActive(false)
    self._mapNode.btnFinishMask:SetActive(true)
    self._mapNode.btnChallenge.interactable = false
    if self._panel.curState ~= 1 then
      self:OnEvent_Back(self._panel._nPanelId)
    end
  end
end

function TrekkerVersusCtrl:OnEvent_NPCTitleRefresh()
  local curTime = ClientManager.serverTimeStamp
  local month = os.date("%m", curTime)
  local day = os.date("%d", curTime)
  local hour = os.date("%H", curTime)
  local min = os.date("%M", curTime)
  NovaAPI.SetTMPText(self._mapNode.TMPNpcDate, string.format("%s/%s", month, day))
  NovaAPI.SetTMPText(self._mapNode.TMPNpcTime, string.format("%s:%s", hour, min))
end

function TrekkerVersusCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self.bJumpto then
    EventManager.Hit(EventId.CloesCurPanel)
    return
  end
  if self._panel.curState == 1 then
    EventManager.Hit(EventId.CloesCurPanel)
  else
    if self.animTimer ~= nil then
      self.animTimer:Cancel()
      self.animTimer = nil
    end
    self._mapNode.rt_ChallengeInfo:CacheAffixes()
    self._mapNode.animRoot:Play("ChallengeInfo_out")
    self._mapNode.imgHeatIndicator.gameObject:SetActive(false)
    self._mapNode.imgStreamerInfo.gameObject:SetActive(false)
    self._mapNode.imgDuelRecord.gameObject:SetActive(false)
    
    local function wait()
      EventManager.Hit(EventId.SetTransition)
      self._mapNode.rt_ChallengeInfo.gameObject:SetActive(false)
      if self.timerRefreshIdleReward ~= nil then
        self.timerRefreshIdleReward:Cancel()
        self.timerRefreshIdleReward = nil
      end
      self:CheckDailyDuelResult()
      self.timerRefreshIdleReward = self:AddTimer(0, 60, function()
        self._ActData:RequestIdleRefresh(self._nActId, function(msgData)
          self:RefreshIdleReward()
          self:RefreshHeatValue()
          self:RefreshStreamerInfo()
        end)
      end, true, true, true)
    end
    
    self._ActData:RequestIdleRefresh(self._nActId, function()
      self:RefreshIdleReward()
      self:RefreshHeatValue()
      self:RefreshStreamerInfo()
      self:RefreshFanGift()
      local nPrevTab = self.nStreamerInfoTabIndex
      self.nStreamerInfoTabIndex = nil
      if nPrevTab == nil then
        nPrevTab = 1
      end
      self:OnBtnClick_StreamerInfoTab(nil, nPrevTab)
      self._mapNode.imgHeatIndicator.gameObject:SetActive(true)
      self._mapNode.imgStreamerInfo.gameObject:SetActive(true)
      self._mapNode.imgDuelRecord.gameObject:SetActive(true)
      self._mapNode.rt_TravelerDuelSelect:SetActive(true)
      self._panel.curState = 1
      self.animTimer = self:AddTimer(1, 0.6, wait, true, true, true)
    end)
  end
end

function TrekkerVersusCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self._panel.curState ~= 1 then
    self._mapNode.rt_ChallengeInfo:CacheAffixes()
  end
  PanelManager.Home()
end

function TrekkerVersusCtrl:OnEvent_ShowBubbleVoiceText(nCharId, nId)
  local mapVoDirectoryData = ConfigTable.GetData("VoDirectory", nId)
  if mapVoDirectoryData == nil then
    printError("VoDirectory未找到数据id:" .. nId)
    return
  end
  if nil ~= mapVoDirectoryData then
    BubbleVoiceManager.PlayFixedBubbleAnim(self._mapNode.goBubbleRoot, mapVoDirectoryData.voResource)
  end
end

function TrekkerVersusCtrl:OnEvent_TrekkerVersusAffixJump(tbJumpAffixes)
  local function waitQuestAnim()
    local mapActivityData = ConfigTable.GetData("TravelerDuelChallengeControl", self._nActId)
    
    local bOpen = false
    if mapActivityData ~= nil then
      bOpen = self:IsOpenBattle(mapActivityData.OpenTime, mapActivityData.EndTime)
    end
    if not bOpen then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_End"))
      return
    end
    if self._panel.curState ~= 2 then
      self:OnBtnClick_Challenge()
    end
    self._mapNode.rt_ChallengeInfo:AddJumptoAffixes(tbJumpAffixes)
  end
  
  self:AddTimer(1, 0.3, waitQuestAnim, true, true, true)
end

function TrekkerVersusCtrl:OnEvent_TrekkerVersusSelectAffix(nCurHard)
  local nHardIdx = math.ceil(nCurHard / 15)
  if 5 < nHardIdx then
    nHardIdx = 5
  end
  local sType = "TrekkerVersus_difficulty" .. tostring(nHardIdx)
  self:PlayNpcVoice(sType)
end

function TrekkerVersusCtrl:OnEvent_TrekkerVersusIdleRewardRefresh()
  self:RefreshIdleReward()
end

function TrekkerVersusCtrl:OnEvent_TrekkerVersusHeatQuestJump()
  self._mapNode.goRewardPanel:ClosePanel()
  self:OnBtnClick_StreamerInfoTab(nil, 2)
end

function TrekkerVersusCtrl:OnEvent_TrekkerVersusFanGiftShowRefresh()
  self:RefreshFanGift()
end

function TrekkerVersusCtrl:OnEvent_UpdateTrekkerVersusHotValue(nSelfHotValue, nRivalHotValue)
  local sHeatTxt = ConfigTable.GetUIText("TD_HeatQuestTab") or ""
  NovaAPI.SetTMPText(self._mapNode.txtHeatStreamerOne, sHeatTxt .. "<space=9>" .. (nSelfHotValue or 0))
  NovaAPI.SetTMPText(self._mapNode.txtHeatStreamerTwo, sHeatTxt .. "<space=9>" .. (nRivalHotValue or 0))
  NovaAPI.SetTMPText(self._mapNode.txtHeatStreamer[1], sHeatTxt .. "<space=9>" .. (nSelfHotValue or 0))
  NovaAPI.SetTMPText(self._mapNode.txtHeatIndicatorNum, nSelfHotValue)
end

function TrekkerVersusCtrl:OnBtnClick_CloseSendGiftEffect()
  if self.timerGiftEff ~= nil then
    self.timerGiftEff:Cancel()
    self.timerGiftEff = nil
  end
  self._mapNode.animGiftEff.gameObject:SetActive(false)
  if self.bPlayFavourUpAnim then
    self:PlayFavourUpAnim()
  elseif self.nAddHotValue > 0 then
    self:RefreshAddHeatValue(self.nAddHotValue)
  end
  CS.WwiseAudioManager.Instance:PostEvent("ui_duel_present_stop")
end

function TrekkerVersusCtrl:OnBtnClick_Challenge(btn)
  if self.animTimer ~= nil then
    self.animTimer:Cancel()
    self.animTimer = nil
  end
  local tbActCfgData = ConfigTable.GetData("TravelerDuelChallengeControl", self._nActId)
  if tbActCfgData ~= nil then
    self._mapNode.rt_ChallengeInfo:Refresh(tbActCfgData.BossLevelId, self.tbAllAffix, self._ActData)
  end
  self._mapNode.animRoot:Play("ChallengeInfo_in")
  self._mapNode.rt_ChallengeInfo.gameObject:SetActive(true)
  self._panel.curState = 2
end

function TrekkerVersusCtrl:OnBtnClick_Difficulty(btn)
  local nCurRecord = self._ActData:GetRecordLevel() or 0
  self.nLocalRecord = nCurRecord
  LocalData.SetPlayerLocalData("TrekkerVersus_600003_RecordLevel", nCurRecord)
  self._mapNode.goRedDotBtnRecord:SetActive(false)
  self._mapNode.goDifficultyPreview:OpenPanel(self._ActData)
end

function TrekkerVersusCtrl:OnBtnClick_HeatReward(btn)
  self._mapNode.goRewardPanel:OpenPanel(self._ActData, 1, self.bOpenSteamerDuel, self._nActId)
end

function TrekkerVersusCtrl:OnBtnClick_RewardChallenge(btn)
  self._mapNode.goRewardPanel:OpenPanel(self._ActData, 4, self.bOpenSteamerDuel, self._nActId)
end

function TrekkerVersusCtrl:OnBtnClick_GiftReward(btn)
  self._mapNode.goRewardPanel:OpenPanel(self._ActData, 3, self.bOpenSteamerDuel, self._nActId)
end

function TrekkerVersusCtrl:OnBtnClick_DuelHistory(btn)
  self._mapNode.goRewardPanel:OpenPanel(self._ActData, 2, self.bOpenSteamerDuel, self._nActId)
end

function TrekkerVersusCtrl:BlockNpc(nTime)
  self.bBlockNpc = true
  
  local function unBlockJump()
    self.bBlockNpc = false
  end
  
  self:AddTimer(1, nTime, unBlockJump, true, true, nil, nil)
end

function TrekkerVersusCtrl:OnBtnClick_Npc()
  if self.bBlockNpc == true then
    return
  end
  PlayerData.Voice:PlayBoardNPCClickVoice(917202)
end

function TrekkerVersusCtrl:OnBtnClick_StreamerInfoTab(btn, index)
  if self.nStreamerInfoTabIndex == index then
    return
  end
  self.nStreamerInfoTabIndex = index
  self._mapNode.imgTabOn[1]:SetActive(index == 1)
  self._mapNode.imgTabOn[2]:SetActive(index == 2)
  self._mapNode.imgTabOff[1]:SetActive(index ~= 1)
  self._mapNode.imgTabOff[2]:SetActive(index ~= 2)
  self._mapNode.rtHeatDuel:SetActive(index == 1)
  if index == 1 then
    self:RefreshStreamerInfo()
  end
  self._mapNode.rtFanGift:SetActive(index == 2)
  if index == 2 then
    self:RefreshFanGift()
  end
end

function TrekkerVersusCtrl:OnBtnClick_GoToGift(btn, index)
  self:OnBtnClick_StreamerInfoTab(btn, 2)
end

function TrekkerVersusCtrl:OnBtnClick_Add(btn, nIndex)
  local nHas = PlayerData.Item:GetItemCountByID(self.tbFanGiftItem[nIndex].nId)
  local nCurCount = self.tbSelectedFanGift[nIndex].nCount or 0
  local nHasRemain = nHas - nCurCount
  if nHasRemain <= 0 or nHas <= 0 then
    if btn.Operate_Type == 0 then
      UTILS.ClickItemGridWithTips(self.tbFanGiftItem[nIndex].nId, btn.transform, true, true, false)
    end
    return
  end
  local nAdd = 0
  if btn.Operate_Type == 0 then
    nAdd = 1
  elseif btn.Operate_Type == 3 then
    if btn.CurrentGear == 0 then
      self._nAddRemain = nHasRemain
    end
    local nGear, _ = math.modf(btn.CurrentGear / 3)
    nAdd = 2 ^ nGear
    local nRemain = self._nAddRemain - nAdd
    if nRemain < 0 then
      nAdd = self._nAddRemain
      self._nAddRemain = 0
    else
      self._nAddRemain = nRemain
    end
  end
  self.tbSelectedFanGift[nIndex].nCount = math.min(math.floor(nCurCount + nAdd), nHas)
  self:RefreshMat()
  self:RefreshFanExpPreview()
end

function TrekkerVersusCtrl:OnBtnClick_Reduce(btn, nIndex)
  local nCurCount = self.tbSelectedFanGift[nIndex].nCount or 0
  if btn.Operate_Type == 0 then
    nCurCount = nCurCount - 1
  elseif btn.Operate_Type == 3 then
    nCurCount = math.floor(nCurCount - 2 ^ btn.CurrentGear)
  end
  self.tbSelectedFanGift[nIndex].nCount = math.max(nCurCount, 0)
  self:RefreshMat()
  self:RefreshFanExpPreview()
end

function TrekkerVersusCtrl:OnBtnClick_AutoFill(btn)
  for i = 1, 3 do
    local nHas = PlayerData.Item:GetItemCountByID(self.tbFanGiftItem[i].nId)
    self.tbSelectedFanGift[i].nCount = nHas or 0
  end
  self:RefreshMat()
  self:RefreshFanExpPreview()
end

function TrekkerVersusCtrl:RefreshFanExpPreview()
  local nCurFanLevel = self._ActData:GetCurFanData().nFanLevel
  if nCurFanLevel >= #self.tbFanLevelData then
    return
  end
  local nExpToAdd = 0
  for k, v in pairs(self.tbSelectedFanGift) do
    local mapExpItemData = ConfigTable.GetData("TravelerDuelHotValueItem", v.nId)
    local nExpForThisItem = mapExpItemData ~= nil and mapExpItemData.AddExp or 1
    nExpToAdd = nExpToAdd + math.floor(v.nCount * nExpForThisItem)
  end
  local nCurTotalExp = self._ActData:GetCurFanData().nFanExp + self.tbFanLevelData[nCurFanLevel].NeedExp
  local nTotalExpPreview = nCurTotalExp + nExpToAdd
  local nDisplayExpPreview = nTotalExpPreview
  local nNewMaxExp = 0
  local nNewNextLevel = 0
  for i = 1, #self.tbFanLevelData do
    local mapData = self.tbFanLevelData[i]
    if nNewMaxExp == 0 and nTotalExpPreview < mapData.NeedExp then
      local nPrevExp = 1 < i and self.tbFanLevelData[i - 1].NeedExp or 0
      nNewMaxExp = mapData.NeedExp - nPrevExp
      nNewNextLevel = mapData.Level
      if 1 < i then
        nDisplayExpPreview = nDisplayExpPreview - self.tbFanLevelData[i - 1].NeedExp
      end
    end
  end
  local bMaxLevel = nNewMaxExp == 0
  if bMaxLevel then
    nNewNextLevel = #self.tbFanLevelData + 1
    nTotalExpPreview = 1000
    nNewMaxExp = 1000
  end
  local mapActivityData = ConfigTable.GetData("TravelerDuelChallengeControl", self._nActId)
  local nHonorTitleId = mapActivityData.HonorId
  if nNewNextLevel > nCurFanLevel + 1 then
    self._mapNode.goFanInfoHonorTitle:SetHonotTitle(nHonorTitleId, true, nNewNextLevel - 1)
  else
    self._mapNode.goFanInfoHonorTitle:SetHonotTitle(nHonorTitleId, true, nCurFanLevel)
  end
  self._mapNode.imgBarFiller.gameObject:SetActive(nNewNextLevel == nCurFanLevel + 1)
  self._mapNode.imgBarFillerPreview.gameObject:SetActive(nTotalExpPreview > self._ActData:GetCurFanData().nFanExp)
  local nHeight = self._mapNode.imgBarFillerPreview.rectTransform.sizeDelta.y
  local nPreviewWidth = nDisplayExpPreview / nNewMaxExp * nMaxFillWidthPreview
  if nPreviewWidth > nMaxFillWidthPreview then
    nPreviewWidth = nMaxFillWidthPreview
  elseif nPreviewWidth < 20 and 0 < nPreviewWidth then
    nPreviewWidth = 20
  elseif nPreviewWidth <= 0 then
    nPreviewWidth = 0
  end
  self._mapNode.imgBarFillerPreview.rectTransform.sizeDelta = Vector2(nPreviewWidth, nHeight)
  self._mapNode.imgBarFillerPreview.rectTransform:GetChild(0).gameObject:SetActive(0 < nPreviewWidth)
  if not bMaxLevel then
    NovaAPI.SetTMPText(self._mapNode.txtFillerNum, nDisplayExpPreview .. "/" .. nNewMaxExp)
  else
    NovaAPI.SetTMPText(self._mapNode.txtFillerNum, ConfigTable.GetUIText("Equipment_MaxLevel") or "")
  end
end

function TrekkerVersusCtrl:OnBtnClick_SendGift(btn)
  local tbSendData = {}
  local tbUsedFanGift = {
    [1] = false,
    [2] = false,
    [3] = false
  }
  local nMaxItemId = 1
  self.nAddHotValue = 0
  for k, v in pairs(self.tbSelectedFanGift) do
    local nThisItem = math.floor(v.nId % 10)
    if 0 < v.nCount then
      table.insert(tbSendData, {
        Tid = v.nId,
        Qty = v.nCount
      })
      tbUsedFanGift[nThisItem] = true
      local mapGiftData = ConfigTable.GetData("TravelerDuelHotValueItem", v.nId)
      local nFactor = mapGiftData ~= nil and mapGiftData.AddHotValue or 1
      self.nAddHotValue = self.nAddHotValue + v.nCount * nFactor
      if nMaxItemId < nThisItem then
        nMaxItemId = nThisItem
      end
    end
  end
  if #tbSendData == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Gift_Send_Not_Select"))
    return
  end
  
  local function reqCallback(msgData, nPrevFanLevel, nPrevFanExp)
    for k, v in pairs(self.tbSelectedFanGift) do
      v.nCount = 0
    end
    local sType = "TrekkerVersus_"
    local sSuffix = ""
    if nMaxItemId == 3 then
      sSuffix = "largeG"
    elseif nMaxItemId == 2 then
      sSuffix = "normalG"
    elseif nMaxItemId == 1 then
      sSuffix = "smallG"
    end
    self:PlayNpcVoice(sType .. sSuffix)
    if nPrevFanLevel < self._ActData:GetCurFanData().nFanLevel then
      self.bPlayFavourUpAnim = true
      self.nPrevFanLevel = nPrevFanLevel
    end
    self:PlaySendGiftEffect(tbUsedFanGift)
    self:RefreshFanGift()
  end
  
  self._ActData:RequestSendStreamerGift(self._nActId, tbSendData, self.nAddHotValue, reqCallback)
end

function TrekkerVersusCtrl:OnBtnClick_ReceiveTimeReward(btn)
  local function cb(msgData)
    self:RefreshIdleReward()
    
    self:RefreshFanGift()
    self:RefreshStreamerInfo()
    self:RefreshHeatValue()
  end
  
  self._ActData:RequestIdleRewardReceive(self._nActId, cb)
end

function TrekkerVersusCtrl:OnBtnClick_TimeReward(btn, idx)
  if idx == 3 then
    idx = 1
  elseif idx == 1 then
    idx = 3
  end
  local nItemId = self.tbFanGiftItemShow[idx]
  if nItemId == 0 then
    return
  end
  UTILS.ClickItemGridWithTips(nItemId, btn.transform, true, true, false)
end

function TrekkerVersusCtrl:OnBtnClick_DuelResult(btn)
  self._mapNode.goDuelResultBlur:SetActive(false)
  self:PlayNpcVoice("TrekkerVersus_defeat")
end

function TrekkerVersusCtrl:OnBtnClick_CloseFavourUp(btn)
  self._mapNode.goStreamerFavourUp:SetActive(false)
end

function TrekkerVersusCtrl:PlayNpcVoice(sType)
  local sVoiceRes = PlayerData.Voice:PlayCharVoice(sType, 917202, nil, true)
end

function TrekkerVersusCtrl:NpcVoice()
  local timeNow = CS.ClientManager.Instance.serverTimeStamp
  local nHour = tonumber(os.date("%H", timeNow))
  local sType = "greet_npc"
  local nLastResult, nLastHard = self._ActData:CheckBattleSuccess()
  if nLastResult == 1 then
    local nHardIdx = math.ceil(nLastHard / 20)
    if 5 < nHardIdx then
      nHardIdx = 5
    end
    sType = "TrekkerVersus_clear" .. tostring(nHardIdx)
  else
    local bFirstIn = self._ActData:GetFirstIn()
    if bFirstIn then
      sType = PlayerData.Voice:GetNPCGreetTimeVoiceKey()
    else
      local nIndex = math.random(1, 2)
      sType = nIndex == 1 and PlayerData.Voice:GetNPCGreetTimeVoiceKey() or "greet_npc"
    end
  end
  self:PlayNpcVoice(sType)
end

return TrekkerVersusCtrl
