local MainViewCtrl = class("MainViewCtrl", BaseCtrl)
local PlayerBoardData = PlayerData.Board
local PlayerVoiceData = PlayerData.Voice
local AvgData = PlayerData.Avg
local AvgManager = require("GameCore.Module.AvgManager")
local LocalData = require("GameCore.Data.LocalData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local TimerManager = require("GameCore.Timer.TimerManager")
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
local ConfigData = require("GameCore.Data.ConfigData")
local JumpUtil = require("Game.Common.Utils.JumpUtil")
local Event = require("GameCore.Event.Event")
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local ResType = GameResourceLoader.ResType
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local LimitWidth = 323
local SDKManager = CS.SDKManager.Instance
MainViewCtrl._mapNodeConfig = {
  btnActor = {
    sComponentName = "Button",
    callback = "OnBtnClick_Actor"
  },
  eventActorDrag = {
    sNodeName = "btnActor",
    sComponentName = "UIDrag",
    callback = "OnDragStart_Actor"
  },
  btnSkipCGAnim = {
    sComponentName = "Button",
    callback = "OnBtnClick_SkipCGAnim"
  },
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  goBubbleRoot = {
    sNodeName = "----bubble----"
  },
  aniMainView = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  HideRoot = {},
  cgRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  },
  imgPlot = {
    sNodeName = "----imgPlot----",
    sComponentName = "Image"
  },
  txtName = {sComponentName = "TMP_Text"},
  imgEnergyIcon = {sComponentName = "Image"},
  txtEnergyCount = {sComponentName = "TMP_Text"},
  btnAddEnergy = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AddEnergy"
  },
  goCoin = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateCoinCtrl"
  },
  imgBtn1 = {},
  btnAdd1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AddRes1"
  },
  imgBtn2 = {},
  btnAdd2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AddRes2"
  },
  imgExp = {sComponentName = "Image"},
  txtRank = {sComponentName = "TMP_Text"},
  txtRankEn = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_RANK"
  },
  btnActivityPrepare = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ActivityPrepare"
  },
  btnWorldClass = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Friend"
  },
  btnActivity = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Activity"
  },
  txtActivity = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Activity"
  },
  btnBattlePass = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_BattlePass"
  },
  txtBattlePass = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_BattlePass"
  },
  BattlePassReminderTime = {
    sNodeName = "rtBPEventReminderTime"
  },
  tmpBattlePassReminderTime = {
    sNodeName = "tmpBPEventReminderTime",
    sComponentName = "TMP_Text"
  },
  btnMall = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Mall"
  },
  txtMall = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Mall"
  },
  btnEventReminder = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_EventReminder"
  },
  txtEventReminder = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_EventReminder"
  },
  rtEventReminderTime = {},
  tmpEventReminderTime = {sComponentName = "TMP_Text"},
  btnReengagement = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reengagement"
  },
  txtReengagement = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Reengagement"
  },
  redDotReengagement = {},
  LockReengagement = {sComponentName = "Image"},
  tmpReengagementTime = {sComponentName = "TMP_Text"},
  rtReengagementTime = {},
  btnNotice = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Notice"
  },
  btnSwitchActor2D = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SwitchActor2D"
  },
  btnHideAllUI = {
    sComponentName = "UIButton",
    nCount = 2,
    callback = "OnBtnClick_HideAllUI"
  },
  btnBoardChange = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_BoardChange"
  },
  btnBoardNext = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_BoardNext"
  },
  goActivityBanner = {},
  goActBannerList = {
    sComponentName = "RectTransform"
  },
  btnActBanner = {
    sNodeName = "goActBannerList",
    sComponentName = "UIButton",
    callback = "OnBtnClick_btnActBanner"
  },
  eventActBannerDrag = {
    sNodeName = "goActBannerList",
    sComponentName = "UIDrag",
    callback = "OnDrag_ActBanner"
  },
  activityBannerItem = {
    nCount = 3,
    sComponentName = "RectTransform"
  },
  imgActBanner = {nCount = 3, sComponentName = "Image"},
  goBannerDot = {
    sComponentName = "RectTransform"
  },
  imgPointBg = {},
  txt_ShowUI = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_ShowUI"
  },
  btnMail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Mail"
  },
  btnFriend = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Friend"
  },
  btnDepot = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Depot"
  },
  goEnergyTip = {},
  tmpEnergy = {sComponentName = "TMP_Text"},
  imgTime = {nCount = 3},
  btnMenu = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Menu"
  },
  btnPhone = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Phone"
  },
  txtPhone = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Phone"
  },
  btnTask = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Task"
  },
  txtTask = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Task"
  },
  btnQuestNewbie = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_QuestNewbie"
  },
  txtQuestNewbie = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_QuestNewbie"
  },
  btnDispatch = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Dispatch"
  },
  txtDispatch = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Dispatch"
  },
  btnShop = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Shop"
  },
  txtShop = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Shop"
  },
  btnActivityFast = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ActivityFast"
  },
  imgActivityFastBg = {nCount = 3, sComponentName = "Image"},
  goActivityFastRedDot = {nCount = 3},
  goActivityFastRedDotNew = {nCount = 3},
  btnDorm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Dorm"
  },
  txtDorm = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_MainViewBtnName"
  },
  txtDormBeta = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_MainViewBtnNameBeta"
  },
  btnGuideMission = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GuideMission"
  },
  imgTopBtnListBg = {
    sComponentName = "RectTransform"
  },
  point3 = {},
  btnRecruit = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Recruit"
  },
  txtRecruit = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Recruit"
  },
  btnRole = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Role"
  },
  txtRole = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Role"
  },
  btnDisc = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Disc"
  },
  txtDisc = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Disc"
  },
  btnMap = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Map"
  },
  txtGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Go"
  },
  btnMainline = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Mainline"
  },
  txtMainline = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Mainline"
  },
  goStarTowerHint = {},
  tmpStarTowerHint = {sComponentName = "TMP_Text"},
  btnStarTowerHint = {
    sNodeName = "goStarTowerHint",
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoToStarTower"
  },
  hintHorLayout = {
    sNodeName = "imgContentBg",
    sComponentName = "HorizontalLayoutGroup"
  },
  layoutElement = {
    sNodeName = "imgContentBg",
    sComponentName = "LayoutElement"
  },
  btnActivitySubEntrance = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ActivitySubEntrance"
  },
  redDotActivity = {},
  redDotActivityNew = {},
  redDotActivityEntrance = {},
  redDotActivityEntranceNew = {},
  redDotBattlePass = {},
  redDotNotice = {},
  redDotMall = {},
  redDotMallNew = {},
  redDotMenu = {},
  redDotTask = {},
  redDotQuestNewbie = {},
  redDotPhoneUnComplete = {},
  redDotPhoneNew = {},
  redDotDispatch = {},
  redDotMail = {},
  redDotFriend = {},
  redDotDepot = {},
  redDotRole = {},
  redDotDisc = {},
  redDotShop = {},
  redDotMap = {},
  redDotMainline = {},
  redDotDorm = {},
  redDotGuideMission = {},
  redDotRecruit = {},
  goRedDotActivity = {},
  goRedDotActivityEntrance = {},
  goRedDotTask = {},
  goRedDotQuestNewbie = {},
  goRedDotPhone = {},
  goRedDotDispatch = {},
  activityRedDot_ = {nCount = 3},
  activityRedDotNew_ = {nCount = 3},
  LockQuestNewbie = {},
  LockTask = {},
  LockRecruit = {},
  LockDisc = {},
  LockShop = {},
  LockRole = {},
  LockPhone = {},
  LockDispatch = {},
  LockActivity = {},
  LockBattlePass = {},
  LockDorm = {}
}
MainViewCtrl._mapEventConfig = {
  [EventId.AfterEnterMain] = "OnEvent_AfterEnterMainMenuModuleScene",
  [EventId.CoinResChange] = "OnEvent_RefreshRes",
  [EventId.UpdateWorldClass] = "RefreshWorldClass",
  [EventId.UpdateEnergy] = "RefreshEnergy",
  [EventId.IsNewDay] = "OnEvent_NewDay",
  [EventId.ShowBubbleVoiceText] = "OnEvent_ShowBubbleVoiceText",
  [EventId.ActivityDataChange] = "OnEvent_ActivityDataChange",
  MainViewCheckOpenPanel = "OnEvent_MainViewCheckOpenPanel",
  UnlockMainViewInput = "OnEvent_UnlockMainViewInput",
  [EventId.TransAnimOutClear] = "OnEvent_TransAnimOutClear",
  AfterCloseNPCReceive = "OnEvent_AfterCloseNPCReceive",
  RefreshActivityGroupRedDot = "OnEvent_RefreshActivityGroupRedDot",
  Mall_Refresh_Reddot = "RefreshRedDot",
  Mall_UpdateMallPackageRedDot = "RefreshRedDot"
}
MainViewCtrl._mapRedDotConfig = {
  [RedDotDefine.Activity_Entrance] = {
    sNodeName = "redDotActivity",
    param = 0
  },
  [RedDotDefine.Activity_Entrance_New] = {
    sNodeName = "redDotActivityNew",
    param = 0
  },
  [RedDotDefine.BattlePass] = {
    sNodeName = "redDotBattlePass"
  },
  [RedDotDefine.Notice] = {
    sNodeName = "redDotNotice"
  },
  [RedDotDefine.Menu] = {sNodeName = "redDotMenu"},
  [RedDotDefine.Task] = {sNodeName = "redDotTask"},
  [RedDotDefine.TaskNewbie] = {
    sNodeName = "redDotQuestNewbie"
  },
  [RedDotDefine.Phone_UnComplete] = {
    sNodeName = "redDotPhoneUnComplete"
  },
  [RedDotDefine.Phone] = {
    sNodeName = "redDotPhoneNew"
  },
  [RedDotDefine.Dispatch] = {
    sNodeName = "redDotDispatch"
  },
  [RedDotDefine.Mail] = {sNodeName = "redDotMail"},
  [RedDotDefine.Friend] = {
    sNodeName = "redDotFriend"
  },
  [RedDotDefine.Depot] = {
    sNodeName = "redDotDepot"
  },
  [RedDotDefine.Role] = {sNodeName = "redDotRole"},
  [RedDotDefine.Disc] = {sNodeName = "redDotDisc"},
  [RedDotDefine.Shop] = {sNodeName = "redDotShop"},
  [RedDotDefine.Map] = {sNodeName = "redDotMap"},
  [RedDotDefine.Map_MainLine] = {
    sNodeName = "redDotMainline"
  },
  [RedDotDefine.GuideMission] = {
    sNodeName = "redDotGuideMission"
  },
  [RedDotDefine.Gacha_MainView] = {
    sNodeName = "redDotRecruit"
  },
  [RedDotDefine.Dorm] = {sNodeName = "redDotDorm"}
}
local view_state = {
  init = 0,
  show_login = 1,
  fullScene_login = 2,
  show_normal = 3,
  fullScene_normal = 4,
  fullScene = 5,
  exitFullScene = 6
}
local view_state_anim = {
  [view_state.show_login] = "tLogin",
  [view_state.fullScene_login] = "tOut",
  [view_state.show_normal] = "tIn",
  [view_state.fullScene_normal] = "tOut",
  [view_state.fullScene] = "tOut",
  [view_state.exitFullScene] = "tExitFull"
}

function MainViewCtrl:RefreshShow()
  self:RefreshPlayerInfo()
  self:RefreshWorldClass()
  self:RefreshResources()
  self:RefreshEnergy()
  self:RefreshActor2D()
  self:RefreshNewbieQuestState()
  self:RefreshLeftActivityList()
  self:RefreshActivitySubEntrance()
  PlayerData.Activity:RefreshActivityRedDot()
  PlayerData.Dispatch:CheckReddot()
  PlayerData.Achievement:CheckReddot()
  self:SetBanner()
  
  local function RefreshFastBtn()
    self:RefreshActivityFastEntrance()
    self:RefreshLeftActivityList()
  end
  
  PlayerData.Activity:SendActivityDetailMsg(RefreshFastBtn)
  self:RefreshEventReminder()
  self:RefreshReengagement()
  self:RefreshRedDot()
  self:RefreshBattleReminderTime()
end

function MainViewCtrl:RefreshRedDot()
  local bMall = RedDotManager.GetValid(RedDotDefine.Mall)
  if bMall then
    self._mapNode.redDotMall:SetActive(true)
  else
    self._mapNode.redDotMall:SetActive(false)
  end
  local bMallNew = RedDotManager.GetValid(RedDotDefine.Mall_New)
  if bMallNew then
    self._mapNode.redDotMallNew:SetActive(bMallNew and not bMall)
  else
    self._mapNode.redDotMallNew:SetActive(false)
  end
end

function MainViewCtrl:RefreshPlayerInfo()
  local sName = PlayerData.Base:GetPlayerNickName()
  NovaAPI.SetTMPText(self._mapNode.txtName, sName)
end

function MainViewCtrl:RefreshWorldClass()
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local nCurExp = PlayerData.Base:GetWorldExp()
  local mapCfg = ConfigTable.GetData("WorldClass", nWorldClass + 1, true)
  local nFullExp = 0
  if mapCfg then
    nFullExp = mapCfg.Exp
  end
  NovaAPI.SetTMPText(self._mapNode.txtRank, nWorldClass)
  NovaAPI.SetImageFillAmount(self._mapNode.imgExp, nFullExp == 0 and 1 or nCurExp / nFullExp)
  local nMaxEnergy = ConfigTable.GetConfigNumber("EnergyMaxLimit")
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  NovaAPI.SetTMPText(self._mapNode.txtEnergyCount, nCurEnergy .. "/" .. nMaxEnergy)
  self:RefreshFuncLock()
  self:RefreshBtnBattlePass()
  self:SetBanner()
  PlayerData.Daily.CheckDailyCheckIn()
end

function MainViewCtrl:RefreshResources()
  for nCoinId, index in pairs(self.tbRes) do
    if nCoinId == AllEnum.CoinItemId.FREESTONE then
      self._mapNode.goCoin[index]:SetCoin(nCoinId, PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.FREESTONE) + PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.STONE), true, 999999)
    else
      self._mapNode.goCoin[index]:SetCoin(nCoinId, PlayerData.Coin:GetCoinCount(nCoinId), true, 999999)
    end
  end
end

function MainViewCtrl:RefreshEnergy()
  local nMaxEnergy = ConfigTable.GetConfigNumber("EnergyMaxLimit")
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  NovaAPI.SetTMPText(self._mapNode.txtEnergyCount, nCurEnergy .. "/" .. nMaxEnergy)
  self:SetSprite_Coin(self._mapNode.imgEnergyIcon, AllEnum.CoinItemId.Energy)
  self:RefreshItemExpire()
end

function MainViewCtrl:RefreshItemExpire()
  local nMinExpire = PlayerData.Item:GetAllItemMinExpire()
  self._mapNode.goEnergyTip.gameObject:SetActive(false)
  if nMinExpire <= 0 then
    return
  end
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  local nRemainTime = nMinExpire - nCurTime
  if nRemainTime < 604800 and 0 < nRemainTime then
    local sTipStr = ""
    self._mapNode.goEnergyTip.gameObject:SetActive(true)
    if 86400 <= nRemainTime then
      sTipStr = math.floor(nRemainTime / 86400) .. ConfigTable.GetUIText("Depot_Item_LeftTime_Day")
    elseif 3600 <= nRemainTime then
      sTipStr = math.floor(nRemainTime / 3600) .. ConfigTable.GetUIText("Depot_Item_LeftTime_Hour")
    else
      local nMin = math.max(math.floor(nRemainTime / 60), 1)
      sTipStr = nMin .. ConfigTable.GetUIText("Depot_LeftTime_Min")
    end
    self._mapNode.imgTime[1]:SetActive(86400 <= nRemainTime)
    self._mapNode.imgTime[2]:SetActive(nRemainTime < 86400 and 3600 <= nRemainTime)
    self._mapNode.imgTime[3]:SetActive(nRemainTime < 3600)
    NovaAPI.SetTMPText(self._mapNode.tmpEnergy, sTipStr)
  end
end

function MainViewCtrl:RefreshEventReminder()
  local nMinRemainTime = PlayerData.EventReminder:GetMinRemainTime()
  if nMinRemainTime == nil then
    self._mapNode.rtEventReminderTime.gameObject:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.tmpEventReminderTime, "")
    return
  end
  if 0 < nMinRemainTime then
    self._mapNode.rtEventReminderTime.gameObject:SetActive(true)
    if 86400 <= nMinRemainTime then
      sTipStr = math.floor(nMinRemainTime / 86400) .. ConfigTable.GetUIText("Depot_Item_LeftTime_Day")
    elseif 3600 <= nMinRemainTime then
      sTipStr = math.floor(nMinRemainTime / 3600) .. ConfigTable.GetUIText("Depot_Item_LeftTime_Hour")
    else
      local nMin = math.max(math.floor(nMinRemainTime / 60), 1)
      sTipStr = nMin .. ConfigTable.GetUIText("Depot_LeftTime_Min")
    end
    NovaAPI.SetTMPText(self._mapNode.tmpEventReminderTime, sTipStr)
  else
    self._mapNode.rtEventReminderTime.gameObject:SetActive(false)
  end
end

function MainViewCtrl:RefreshReengagement()
  local nMinRemainTime = PlayerData.Reengagement:GetReengagementRemainTime()
  if nMinRemainTime == nil then
    self._mapNode.rtReengagementTime.gameObject:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.tmpReengagementTime, "")
    return
  end
  if 0 < nMinRemainTime then
    self._mapNode.rtReengagementTime.gameObject:SetActive(true)
    if 86400 <= nMinRemainTime then
      sTipStr = math.floor(nMinRemainTime / 86400) .. ConfigTable.GetUIText("Depot_Item_LeftTime_Day")
    elseif 3600 <= nMinRemainTime then
      sTipStr = math.floor(nMinRemainTime / 3600) .. ConfigTable.GetUIText("Depot_Item_LeftTime_Hour")
    else
      local nMin = math.max(math.floor(nMinRemainTime / 60), 1)
      sTipStr = nMin .. ConfigTable.GetUIText("Depot_LeftTime_Min")
    end
    NovaAPI.SetTMPText(self._mapNode.tmpReengagementTime, sTipStr)
  else
    self._mapNode.rtReengagementTime.gameObject:SetActive(false)
  end
end

function MainViewCtrl:RefreshBtnBattlePass()
  if not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.BattlePass) then
    return
  end
  local nRemainTime = PlayerData.BattlePass:GetRemainTime()
  self:RefreshBtnBattleReminder(nRemainTime)
end

function MainViewCtrl:RefreshBtnBattleReminder(nRemainTime)
  if nRemainTime == nil or nRemainTime == 0 then
    self._mapNode.BattlePassReminderTime.gameObject:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.tmpBattlePassReminderTime, "")
    return
  end
  if nRemainTime <= 259200 then
    self._mapNode.BattlePassReminderTime:SetActive(true)
    if 86400 <= nRemainTime then
      sTipStr = math.floor(nRemainTime / 86400) .. ConfigTable.GetUIText("Depot_Item_LeftTime_Day")
    elseif 3600 <= nRemainTime then
      sTipStr = math.floor(nRemainTime / 3600) .. ConfigTable.GetUIText("Depot_LeftTime_Hour2")
    else
      local nRem = math.max(math.floor(nRemainTime / 60), 1)
      sTipStr = nRem .. ConfigTable.GetUIText("Depot_LeftTime_Min2")
    end
    NovaAPI.SetTMPText(self._mapNode.tmpBattlePassReminderTime, sTipStr)
  else
    self._mapNode.BattlePassReminderTime:SetActive(false)
  end
end

function MainViewCtrl:RefreshBattleReminderTime()
  if self.battleRemainTimer ~= nil then
    self.battleRemainTimer:Cancel()
    self.battleRemainTimer = nil
  end
  if not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.BattlePass) then
    return
  end
  if PlayerData.BattlePass:GetRemainTime() < 86400 then
    self.battleRemainTimer = self:AddTimer(0, 1, "RefreshBtnBattlePass", true, true, false)
  end
end

function MainViewCtrl:RefreshActor2D()
  BubbleVoiceManager.StopBubbleAnim()
  PlayerVoiceData:StopCharVoice()
  self._mapNode.rawImgActor2D.gameObject:SetActive(false)
  self._mapNode.imgPlot.gameObject:SetActive(false)
  local curBoardData = PlayerBoardData:GetCurBoardData()
  if nil == curBoardData then
    curBoardData = PlayerBoardData:GetTempBoardData()
  end
  local nCGAnimTime = 0
  if nil ~= curBoardData then
    if curBoardData:GetType() == GameEnum.handbookType.SKIN then
      self._mapNode.rawImgActor2D.gameObject:SetActive(true)
      local charId = curBoardData:GetCharId()
      local skinId = curBoardData:GetSkinId()
      local bSuc, nType, nAnimLen = Actor2DManager.SetActor2D(self:GetPanelId(), self._mapNode.rawImgActor2D, charId, skinId)
      local nTargetType = PlayerData.Board:GetBoardPanelL2DType()
      local bChange = false
      if nTargetType ~= 0 and nTargetType ~= nType and (nTargetType == AllEnum.Actor2DType.FullScreen and curBoardData:CheckFavorCG() or nTargetType == AllEnum.Actor2DType.Normal) then
        bChange = true
      end
      if bChange then
        bSuc, nType, nAnimLen = Actor2DManager.SwitchActor2DType()
      end
      local nBoardPanelId = PlayerBoardData:GetBoardPanelSelectId()
      if nil ~= nBoardPanelId and 0 ~= nBoardPanelId and nType == AllEnum.Actor2DType.Normal and nBoardPanelId == curBoardData:GetId() then
        Actor2DManager.PlayActor2DAnim("Actor2D_left_middle")
      end
      self.nActorShowType = nType
      nCGAnimTime = nAnimLen or 0
    elseif curBoardData:GetType() == GameEnum.handbookType.OUTFIT then
      self.nActorShowType = 0
      self._mapNode.rawImgActor2D.gameObject:SetActive(true)
      local nDiscId = curBoardData:GetDiscId()
      local bUseL2D = PlayerData.Disc:CheckDiscL2D(nDiscId)
      Actor2DManager.SetDisc2D(nDiscId, self._mapNode.rawImgActor2D, bUseL2D)
    elseif curBoardData:GetType() == GameEnum.handbookType.PLOT or curBoardData:GetType() == GameEnum.handbookType.StorySet or curBoardData:GetType() == GameEnum.handbookType.StoryReview then
      local nCgId = curBoardData:GetId()
      if curBoardData:CheckPlotL2d() then
        self._mapNode.rawImgActor2D.gameObject:SetActive(true)
        Actor2DManager.SetCg2D(nCgId, self._mapNode.rawImgActor2D, true)
      else
        self._mapNode.imgPlot.gameObject:SetActive(true)
        local plotCfgData = curBoardData:GetPlotCfgData()
        if nil ~= plotCfgData then
          local tbResource = PlayerData.Handbook:GetPlotResourcePath(nCgId)
          local sFullPath = Settings.AB_ROOT_PATH .. tbResource.FullScreenImg .. ".png"
          local img = GameResourceLoader.LoadAsset(ResType.Any, sFullPath, typeof(Sprite))
          self._mapNode.imgPlot.sprite = img
          NovaAPI.SetImageNativeSize(self._mapNode.imgPlot)
        end
      end
    end
  end
  self:ChangeActorFinish(nCGAnimTime)
  PlayerBoardData:SetBoardPanelSelectId(0)
end

function MainViewCtrl:ChangeActorFinish(nTime)
  if self.timerCGL2D ~= nil then
    self.timerCGL2D:Cancel()
    self.timerCGL2D = nil
  end
  if self.timerCheck ~= nil then
    self.timerCheck:Cancel()
    self.timerCheck = nil
  end
  self._nEntranceWait = (self._nEntranceWait or 0) + 1
  if 0 < nTime then
    if self.nViewState == view_state.init then
      self:ChangeViewState(view_state.fullScene_login, true)
    else
      self:ChangeViewState(view_state.fullScene_normal, true)
    end
    self.timerCGL2D = self:AddTimer(1, nTime, "OnTimer_CGL2D", true, true)
  else
    if self.nViewState == view_state.init or self.nViewState == view_state.fullScene_login then
      self:ChangeViewState(view_state.show_login, true)
    elseif self.nViewState == view_state.fullScene_normal then
      self:ChangeViewState(view_state.show_normal, true)
    end
    self:_WaitEntranceThenCheck(true)
  end
  if nTime == 0 then
    if self.nViewState == view_state.init or self.nViewState == view_state.show_login then
      if not self.bNeedCheckState then
        BubbleVoiceManager.StopBubbleAnim()
        PlayerVoiceData:StopCharVoice()
        self:PlayMainViewOpenVoice()
      end
    else
      BubbleVoiceManager.StopBubbleAnim()
      PlayerVoiceData:StopCharVoice()
      self:PlayMainViewOpenVoice()
    end
  end
  self._mapNode.btnSkipCGAnim.gameObject:SetActive(0 < nTime)
end

function MainViewCtrl:PlayMainViewOpenVoice()
  self.bInTransition = PanelManager.CheckInTransition()
  if self.bInTransition then
    self.bDelayOpenVoice = true
  else
    PlayerVoiceData:PlayMainViewOpenVoice()
  end
end

function MainViewCtrl:_EnsureBannerDotPool(nCount)
  for i = 1, nCount do
    if self.tbBannerDots[i] == nil then
      local goClone = instantiate(self._mapNode.imgPointBg, self._mapNode.goBannerDot)
      self.tbBannerDots[i] = goClone
    end
  end
end

function MainViewCtrl:SetBanner()
  self.bannerRefreshTimer = nil
  self.tbBannerList = {}
  self:AddActivityBanner()
  self:AddOtherBanner()
  self:AddGachaBanner()
  if nil == self.tbBannerList or nil == next(self.tbBannerList) then
    self._mapNode.goActivityBanner.gameObject:SetActive(false)
  else
    self._mapNode.goActivityBanner:SetActive(true)
    self:_EnsureBannerDotPool(#self.tbBannerList)
    for _, v in ipairs(self.tbBannerDots) do
      v.gameObject:SetActive(false)
    end
    for k, v in ipairs(self.tbBannerList) do
      if nil ~= self.tbBannerDots[k] then
        self.tbBannerDots[k]:SetActive(true)
        self.tbBannerDots[k].transform:Find("imgPoint").gameObject:SetActive(false)
      end
    end
    self.nActBannerIdx = 1
    self.nLastActBannerIdx = 1
    self:RefreshActivityBanner()
  end
  self:StartActBannerTimer()
  self._mapNode.eventActBannerDrag.enabled = #self.tbBannerList > 1
end

function MainViewCtrl:AddActivityBanner()
  local tb_activityBanner = PlayerData.Activity:GetActivityBannerList()
  for _, value in ipairs(tb_activityBanner) do
    table.insert(self.tbBannerList, {
      nId = value:GetActId(),
      nType = GameEnum.bannerType.Activity,
      actData = value,
      nFuncType = GameEnum.OpenFuncType.Activity
    })
  end
end

function MainViewCtrl:AddOtherBanner()
  local nNextOpenTime = 0
  local nNextCloseTime = 0
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  
  local function forEachMap(mapLineData)
    if mapLineData.BannerType == GameEnum.bannerType.OpenFunc then
      local funcNum = tonumber(mapLineData.Param1)
      if funcNum == nil then
        return
      end
      local bUnlock = PlayerData.Base:CheckFunctionUnlock(funcNum, false)
      if bUnlock then
        local jumpToNum = tonumber(mapLineData.Param2)
        if jumpToNum == nil then
          return
        end
        table.insert(self.tbBannerList, {
          nId = mapLineData.Id,
          nType = GameEnum.bannerType.OpenFunc,
          sBanner = mapLineData.bannerName,
          nJumpTo = jumpToNum,
          nFuncType = funcNum
        })
      end
    elseif mapLineData.BannerType == GameEnum.bannerType.Community then
      local clientPublishRegion = CS.ClientConfig.ClientPublishRegion
      local channelName = CS.ClientConfig.ClientPublishChannelName
      if SDKManager:IsSDKInit() and clientPublishRegion == CS.ClientPublishRegion.CN and (channelName == "Official" or channelName == "TEST_1" or channelName == "Taptap") then
        table.insert(self.tbBannerList, {
          nId = mapLineData.Id,
          nType = GameEnum.bannerType.Community,
          sBanner = mapLineData.bannerName
        })
      end
    elseif mapLineData.BannerType == GameEnum.bannerType.Payment then
      if not NovaAPI.IsReviewServerEnv() then
        local clientPublishRegion = CS.ClientConfig.ClientPublishRegion
        local channelName = CS.ClientConfig.ClientPublishChannelName
        if SDKManager:IsSDKInit() and clientPublishRegion == CS.ClientPublishRegion.CN and (channelName == "Official" or channelName == "TEST_1" or channelName == "Taptap" or channelName == "TEST_2") then
          table.insert(self.tbBannerList, {
            nId = mapLineData.Id,
            nType = GameEnum.bannerType.Payment,
            sBanner = mapLineData.bannerName
          })
        end
      end
    elseif mapLineData.BannerType == GameEnum.bannerType.Mall or mapLineData.BannerType == GameEnum.bannerType.MallSkin then
      local nOpenTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapLineData.Param1)
      local nCloseTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapLineData.Param2)
      if nOpenTime <= nCurTime and nCloseTime >= nCurTime then
        table.insert(self.tbBannerList, {
          nId = mapLineData.Id,
          nType = mapLineData.BannerType,
          sBanner = mapLineData.bannerName,
          sParam = mapLineData.Param3
        })
        if nCloseTime < nNextCloseTime or nNextCloseTime == 0 then
          nNextCloseTime = nCloseTime
        end
      elseif nOpenTime > nCurTime and (nOpenTime < nNextOpenTime or nNextOpenTime == 0) then
        nNextOpenTime = nOpenTime
      end
    elseif mapLineData.BannerType == GameEnum.bannerType.TimeLimit_Func then
      local nOpenTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapLineData.Param1)
      local nCloseTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapLineData.Param2)
      local nJumpToId = tonumber(mapLineData.Param3)
      local nFuncType = tonumber(mapLineData.Param4)
      if nFuncType == nil or nJumpToId == nil then
        return
      end
      local bUnlock = PlayerData.Base:CheckFunctionUnlock(nFuncType, false)
      if bUnlock and nOpenTime <= nCurTime and nCloseTime >= nCurTime then
        table.insert(self.tbBannerList, {
          nId = mapLineData.Id,
          nType = GameEnum.bannerType.TimeLimit_Func,
          sBanner = mapLineData.bannerName,
          nJumpTo = nJumpToId,
          nFuncType = nFuncType
        })
        if nCloseTime < nNextCloseTime or nNextCloseTime == 0 then
          nNextCloseTime = nCloseTime
        end
      elseif nOpenTime > nCurTime and (nOpenTime < nNextOpenTime or nNextOpenTime == 0) then
        nNextOpenTime = nOpenTime
      end
    elseif mapLineData.BannerType == GameEnum.bannerType.JumpToUrl then
      if NovaAPI.IsReviewServerEnv() and mapLineData.Param6 == "1" then
        return
      end
      local sUrl = mapLineData.Param3
      if sUrl == nil or sUrl == "" then
        return
      end
      local sPlatform = mapLineData.Param4
      local sOption = mapLineData.Param5
      local curPlatform = CS.ClientManager.Instance.Platform
      local bUseOpenUrl = mapLineData.Param7 == "1"
      if mapLineData.Param1 == "" then
        if sPlatform == "" then
          table.insert(self.tbBannerList, {
            nId = mapLineData.Id,
            nType = GameEnum.bannerType.JumpToUrl,
            sBanner = mapLineData.bannerName,
            sUrl = sUrl,
            bInside = true,
            bUseOpenUrl = bUseOpenUrl
          })
        else
          local tbPlatformList = string.split(sPlatform, ",")
          local tbOptionList = string.split(sOption, ",")
          local nIndex = table.indexof(tbPlatformList, curPlatform)
          if nIndex ~= nil and 0 < nIndex then
            local sOptionType = tbOptionList[nIndex]
            local bInside = sOptionType == "0"
            table.insert(self.tbBannerList, {
              nId = mapLineData.Id,
              nType = GameEnum.bannerType.JumpToUrl,
              sBanner = mapLineData.bannerName,
              sUrl = sUrl,
              bInside = bInside,
              bUseOpenUrl = bUseOpenUrl
            })
          end
        end
      else
        local nOpenTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapLineData.Param1)
        local nCloseTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapLineData.Param2)
        if nOpenTime <= nCurTime and nCloseTime >= nCurTime then
          if sPlatform == "" then
            table.insert(self.tbBannerList, {
              nId = mapLineData.Id,
              nType = GameEnum.bannerType.JumpToUrl,
              sBanner = mapLineData.bannerName,
              sUrl = sUrl,
              bInside = true,
              bUseOpenUrl = bUseOpenUrl
            })
          else
            local tbPlatformList = string.split(sPlatform, ",")
            local tbOptionList = string.split(sOption, ",")
            local nIndex = table.indexof(tbPlatformList, curPlatform)
            if nIndex ~= nil and 0 < nIndex then
              local sOptionType = tbOptionList[nIndex]
              local bInside = sOptionType == "0"
              table.insert(self.tbBannerList, {
                nId = mapLineData.Id,
                nType = GameEnum.bannerType.JumpToUrl,
                sBanner = mapLineData.bannerName,
                sUrl = sUrl,
                bInside = bInside,
                bUseOpenUrl = bUseOpenUrl
              })
            end
          end
          if nCloseTime < nNextCloseTime or nNextCloseTime == 0 then
            nNextCloseTime = nCloseTime
          end
        elseif nOpenTime > nCurTime and (nOpenTime < nNextOpenTime or nNextOpenTime == 0) then
          nNextOpenTime = nOpenTime
        end
      end
    elseif mapLineData.BannerType == GameEnum.bannerType.SeaPayment and not NovaAPI.IsReviewServerEnv() then
      local sUrl = mapLineData.Param3
      if sUrl == nil or sUrl == "" then
        return
      end
      local nOpenTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapLineData.Param1)
      local nCloseTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapLineData.Param2)
      if nOpenTime <= nCurTime and nCloseTime >= nCurTime then
        local sPlatform = mapLineData.Param4
        local sOption = mapLineData.Param5
        local curPlatform = CS.ClientManager.Instance.Platform
        local tbPlatformList = string.split(sPlatform, ",")
        local tbOptionList = string.split(sOption, ",")
        local nIndex = table.indexof(tbPlatformList, curPlatform)
        local sPid = mapLineData.Param6
        if nIndex ~= nil and 0 < nIndex then
          local sOptionType = tbOptionList[nIndex]
          local bInside = sOptionType == "0"
          if SDKManager:IsSDKInit() then
            table.insert(self.tbBannerList, {
              nId = mapLineData.Id,
              nType = GameEnum.bannerType.SeaPayment,
              sBanner = mapLineData.bannerName,
              sUrl = sUrl,
              bInside = bInside,
              sPid = sPid
            })
          end
        end
      end
    end
  end
  
  ForEachTableLine(DataTable.Banner, forEachMap)
  local nRefreshTime = math.min(math.max(nNextOpenTime, 0), math.max(nNextCloseTime, 0))
  if 0 < nRefreshTime and nCurTime < nRefreshTime then
    self.bannerRefreshTimer = self:AddTimer(1, nRefreshTime - nCurTime, "SetBanner", true, true, true)
  end
end

function MainViewCtrl:AddGachaBanner()
  local tbOpenedPool = PlayerData.Gacha:GetOpenedPool()
  
  local function comp(a, b)
    local mapGachaA = ConfigTable.GetData("Gacha", a)
    local mapGachaB = ConfigTable.GetData("Gacha", b)
    return mapGachaA.Sort < mapGachaB.Sort
  end
  
  table.sort(tbOpenedPool, comp)
  for _, nPoolId in ipairs(tbOpenedPool) do
    local mapPoolCfgData = ConfigTable.GetData("Gacha", nPoolId)
    if mapPoolCfgData ~= nil and mapPoolCfgData.BannerRes ~= nil and mapPoolCfgData.BannerRes ~= "" then
      table.insert(self.tbBannerList, {
        nId = nPoolId,
        nType = GameEnum.bannerType.Gacha,
        sBanner = mapPoolCfgData.BannerRes,
        nJumpTo = nPoolId,
        nFuncType = GameEnum.OpenFuncType.Gacha
      })
    end
  end
end

function MainViewCtrl:RefreshActivityBanner()
  local lastIndex = self.nActBannerIdx - 1 <= 0 and #self.tbBannerList or self.nActBannerIdx - 1
  local nextIndex = self.nActBannerIdx + 1 > #self.tbBannerList and 1 or self.nActBannerIdx + 1
  local tbCurBannerList = {}
  table.insert(tbCurBannerList, self.tbBannerList[lastIndex])
  table.insert(tbCurBannerList, self.tbBannerList[self.nActBannerIdx])
  table.insert(tbCurBannerList, self.tbBannerList[nextIndex])
  for k, v in ipairs(self._mapNode.imgActBanner) do
    local bannerData = tbCurBannerList[k]
    if bannerData ~= nil then
      if bannerData.nType == GameEnum.bannerType.Activity then
        if nil ~= bannerData.actData then
          self:SetPngSprite(v, "Icon/Banner/" .. bannerData.actData:GetBannerPng())
        end
      else
        self:SetPngSprite(v, "Icon/Banner/" .. bannerData.sBanner)
      end
    end
  end
  if self.tbBannerDots ~= nil then
    if self.tbBannerDots[self.nLastActBannerIdx] ~= nil then
      self.tbBannerDots[self.nLastActBannerIdx].transform:Find("imgPoint").gameObject:SetActive(false)
    end
    self.nLastActBannerIdx = self.nActBannerIdx
    if self.tbBannerDots[self.nActBannerIdx] ~= nil then
      self.tbBannerDots[self.nActBannerIdx].transform:Find("imgPoint").gameObject:SetActive(true)
    end
  end
end

function MainViewCtrl:StartActBannerTimer()
  if nil == self.actBannerTimer and #self.tbBannerList > 1 then
    self.actBannerTimer = self:AddTimer(0, self.nBannerInterval, "PlayActBannerAnim", true, true, false)
  end
end

function MainViewCtrl:ResetActBannerTimer()
  if nil ~= self.actBannerTimer then
    self.actBannerTimer:Cancel(false)
  end
  self.actBannerTimer = nil
end

function MainViewCtrl:PlayActBannerAnim()
  local function onCompleteCb()
    self:BannerTweenerEnd()
  end
  
  for k, v in ipairs(self._mapNode.activityBannerItem) do
    if k == #self._mapNode.activityBannerItem then
      v:DOAnchorPosX(self.tbBannerInitPos[k].x - self.nBannerWidth, 0.5):SetUpdate(true):OnComplete(onCompleteCb)
    else
      v:DOAnchorPosX(self.tbBannerInitPos[k].x - self.nBannerWidth, 0.5):SetUpdate(true)
    end
  end
end

function MainViewCtrl:BannerTweenerEnd()
  for k, v in ipairs(self._mapNode.activityBannerItem) do
    v.anchoredPosition = self.tbBannerInitPos[k]
  end
  self.nActBannerIdx = self.nActBannerIdx + 1
  if self.nActBannerIdx > #self.tbBannerList then
    self.nActBannerIdx = 1
  end
  self:RefreshActivityBanner()
end

function MainViewCtrl:InitData()
  self.tbRes = {
    [AllEnum.CoinItemId.Jade] = 1,
    [AllEnum.CoinItemId.FREESTONE] = 2
  }
  self.bannerList = {}
end

function MainViewCtrl:EnqueueLoginSequenceOnce()
  if self._bLoginSeqArmed then
    return
  end
  self._bLoginSeqArmed = true
  local bPendingBuild = PlayerData.State:HasPendingStarTowerBuild()
  if bPendingBuild then
    PopUpManager.PopUpEnQueue(GameEnum.PopUpSeqType.StarTowerBuildSave, true, true)
  end
  PopUpManager.PopUpEnQueue(GameEnum.PopUpSeqType.MainViewGuide, true, true)
end

function MainViewCtrl:CheckOpenPanel()
  local bInPopUp = PopUpManager.CheckInPopUpQueue()
  if bInPopUp then
    return
  end
  self:EnqueueLoginSequenceOnce()
  self.timerCheck = nil
  self.bNeedCheckState = nil
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgRoot, false)
  
  local function callbackFunc()
    EventManager.Hit("OnEvent_MainViewCanOperate")
    NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgRoot, true)
    if self.nViewState == view_state.show_login then
      PlayerVoiceData:PlayMainViewOpenVoice()
      self:ChangeViewState(view_state.show_normal)
    end
    PlayerData.SideBanner:TryOpenSideBanner()
  end
  
  PopUpManager.StartShowPopUp(callbackFunc)
end

function MainViewCtrl:LoadCharacterIndex()
  local localData = LocalData.GetPlayerLocalData("MainMenuUICharIndex")
  self.nCurCharIdx = tonumber(localData) or 1
end

function MainViewCtrl:SaveCharacterIndex()
  LocalData.SetPlayerLocalData("MainMenuUICharIndex", self.nCurCharIdx)
end

function MainViewCtrl:ResetTimer()
  if self.actBannerTimer ~= nil then
    self.actBannerTimer:Cancel(false)
    self.actBannerTimer = nil
  end
  if self.actBannerRefreshTimer ~= nil then
    self.actBannerRefreshTimer:Cancel(false)
    self.actBannerRefreshTimer = nil
  end
  if self.bannerRefreshTimer ~= nil then
    self.bannerRefreshTimer:Cancel(false)
    self.bannerRefreshTimer = nil
  end
  if self.battleRemainTimer ~= nil then
    self.battleRemainTimer:Cancel(false)
    self.battleRemainTimer = nil
  end
end

function MainViewCtrl:PlayViewAnim(sTriggerName)
  if nil ~= self.sLastTriggerAnim then
    self._mapNode.aniMainView:ResetTrigger(self.sLastTriggerAnim)
  end
  self._mapNode.aniMainView:SetTrigger(sTriggerName)
  self.sLastTriggerAnim = sTriggerName
end

function MainViewCtrl:_WaitEntranceThenCheck(bBlockInput)
  self._nEntranceWait = (self._nEntranceWait or 0) + 1
  local nToken = self._nEntranceWait
  
  local function wait()
    for _ = 1, 2 do
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      if nToken ~= self._nEntranceWait then
        return
      end
      if self._mapNode == nil or self._mapNode.aniMainView == nil then
        return
      end
    end
    if nToken ~= self._nEntranceWait or self._mapNode == nil or self._mapNode.aniMainView == nil then
      return
    end
    local nTime = self._mapNode.aniMainView:GetCurrentAnimatorStateInfo(0).length
    if bBlockInput then
      EventManager.Hit(EventId.TemporaryBlockInput, nTime)
    end
    self.timerCheck = self:AddTimer(1, nTime, "OnTimer_AnimCheck", true, true)
  end
  
  cs_coroutine.start(wait)
end

function MainViewCtrl:ChangeViewState(nState, bPlayAnim)
  if bPlayAnim then
    local nLastAnimName = view_state_anim[self.nViewState]
    local nAnimName = view_state_anim[nState]
    local bShouldPlayAnim = true
    if nLastAnimName == nAnimName or nLastAnimName == "tLogin" and nAnimName == "tIn" then
      bShouldPlayAnim = false
    end
    if bShouldPlayAnim then
      EventManager.Hit(EventId.TemporaryBlockInput, 0.7)
      self:PlayViewAnim(view_state_anim[nState])
    end
  end
  self.nViewState = nState
end

function MainViewCtrl:PlayTransition(nType, callback, nParam)
  self.bInTransition = true
  EventManager.Hit(EventId.SetTransition, nType, callback, nParam)
end

function MainViewCtrl:RefreshFuncLock()
  self._mapNode.LockQuestNewbie:SetActive(not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.QuestNewbie))
  self._mapNode.LockTask:SetActive(not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Quest))
  self._mapNode.LockRecruit:SetActive(not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Gacha))
  self._mapNode.LockDisc:SetActive(false)
  self._mapNode.LockShop:SetActive(false)
  self._mapNode.LockRole:SetActive(not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Char))
  self._mapNode.LockPhone:SetActive(not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Phone))
  self._mapNode.LockDispatch:SetActive(not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Agent))
  self._mapNode.LockActivity:SetActive(not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Activity))
  self._mapNode.LockBattlePass:SetActive(not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.BattlePass))
  self._mapNode.LockDorm:SetActive(not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Dorm))
  self._mapNode.txtDorm[2].gameObject:SetActive(not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Dorm))
  self._mapNode.BattlePassReminderTime:SetActive(PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.BattlePass))
  self._mapNode.btnEventReminder.gameObject:SetActive(PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.EventReminder))
  self._mapNode.goRedDotActivity:SetActive(PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Activity))
  self._mapNode.goRedDotActivityEntrance:SetActive(PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Activity))
  self._mapNode.goRedDotPhone:SetActive(PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Phone))
  self._mapNode.goRedDotTask:SetActive(PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Quest))
  self._mapNode.goRedDotQuestNewbie:SetActive(PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.QuestNewbie))
  self._mapNode.goRedDotDispatch:SetActive(PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Agent))
  local bGuideMissionUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.GuideMission)
  self._mapNode.btnGuideMission.gameObject:SetActive(bGuideMissionUnlock)
  self._mapNode.point3:SetActive(bGuideMissionUnlock)
  self._mapNode.imgTopBtnListBg.sizeDelta = Vector2(bGuideMissionUnlock and 535.68 or 416, self._mapNode.imgTopBtnListBg.sizeDelta.y)
  local bReengagementOpen = PlayerData.Reengagement:GetActIsOpen()
  self._mapNode.btnReengagement.gameObject:SetActive(bReengagementOpen)
  if bReengagementOpen then
    RedDotManager.RegisterNode(RedDotDefine.Activity_Reengagement, PlayerData.Reengagement:GetActId(), self._mapNode.redDotReengagement)
  else
    self._mapNode.redDotReengagement.gameObject:SetActive(false)
  end
end

function MainViewCtrl:SetHintLayout(bEnabled)
  self._mapNode.hintHorLayout.enabled = bEnabled
  self._mapNode.layoutElement.enabled = not bEnabled
end

function MainViewCtrl:RefreshLeftActivityList()
  local tbBtn = self._mapNode and self._mapNode.btnActivityPrepare
  if tbBtn == nil or tbBtn[1] == nil then
    return
  end
  local tbActGroupList = PlayerData.Activity:GetMainviewShowActivityGroup()
  if self.tbActivityPrepareShowList ~= nil then
    for index, actData in ipairs(self.tbActivityPrepareShowList) do
      if actData.countDownTimer ~= nil then
        actData.countDownTimer:Cancel()
      end
      if actData.countDownEnterTimer ~= nil then
        actData.countDownEnterTimer:Cancel()
      end
      if actData.bRegisterNode then
        RedDotManager.UnRegisterNode(RedDotDefine.Activity_Group, {
          actData.actGroupData:GetActGroupId()
        }, self._mapNode.activityRedDot_[index])
        RedDotManager.UnRegisterNode(RedDotDefine.Activity_GroupNew, {
          actData.actGroupData:GetActGroupId()
        }, self._mapNode.activityRedDotNew_[index])
      end
    end
  end
  self.tbActivityPrepareShowList = {}
  for i = 1, 3 do
    local btnTrans = self._mapNode.btnActivityPrepare[i]
    btnTrans.gameObject:SetActive(tbActGroupList[i] ~= nil)
    if tbActGroupList[i] ~= nil then
      do
        local showData = {}
        local actGroupData = tbActGroupList[i]
        showData.actGroupData = actGroupData
        local actGroupCfg = actGroupData:GetActGroupCfgData()
        local bOpened = actGroupData:CheckActivityGroupOpen()
        local isUnlock, txtLock = actGroupData:IsUnlock()
        local remainTime = actGroupData:GetActGroupRemainTime()
        local bShowCountDown = 0 < remainTime and remainTime <= 259200
        local OpenRoot = btnTrans.transform:Find("AnimRoot/Open")
        local EndRoot = btnTrans.transform:Find("AnimRoot/End")
        local txtEnd = EndRoot:Find("imgEnd/txtEnd"):GetComponent("TMP_Text")
        local txtEndExchange = EndRoot:Find("imgEndExchange/txtEndExchange"):GetComponent("TMP_Text")
        local imgActivityTime = btnTrans.transform:Find("AnimRoot/Open/imgActivityTime")
        local imgOpenBg = OpenRoot:Find("imgBg"):GetComponent("Image")
        local imgOpenBgMask = OpenRoot:Find("imgBgMask"):GetComponent("Image")
        self:SetPngSprite(imgOpenBg, actGroupCfg.EnterRes)
        self:SetPngSprite(imgOpenBgMask, actGroupCfg.EnterRes)
        if bOpened then
          local txtActRemainTime = OpenRoot:Find("imgActivityTime/txtActivityTime"):GetComponent("TMP_Text")
          if bShowCountDown then
            do
              local strTime = self:RefreshTimeout(remainTime)
              NovaAPI.SetTMPText(txtActRemainTime, strTime)
              showData.countDownTimer = self:AddTimer(0, 1, function()
                if 0 < remainTime then
                  local strTime = self:RefreshTimeout(remainTime)
                  NovaAPI.SetTMPText(txtActRemainTime, strTime)
                  remainTime = remainTime - 1
                else
                  showData.countDownTimer:Cancel()
                  EndRoot.gameObject:SetActive(true)
                  imgActivityTime.gameObject:SetActive(false)
                end
              end, true, true, true)
            end
          end
        end
        local endEnterTime = actGroupData:GetActGroupEnterEndTime()
        local curTime = CS.ClientManager.Instance.serverTimeStamp
        endEnterTime = endEnterTime - curTime
        local strEndTime = self:RefreshExchangeTimeout(endEnterTime)
        NovaAPI.SetTMPText(txtEnd, strEndTime)
        showData.countDownEnterTimer = self:AddTimer(0, 1, function()
          if 0 < endEnterTime then
            local strTime = self:RefreshExchangeTimeout(endEnterTime)
            NovaAPI.SetTMPText(txtEnd, strTime)
            endEnterTime = endEnterTime - 1
          else
            showData.countDownEnterTimer:Cancel()
            btnTrans.gameObject:SetActive(false)
          end
        end, true, true, true)
        EndRoot.gameObject:SetActive(not bOpened)
        imgActivityTime.gameObject:SetActive(bOpened and bShowCountDown)
        imgOpenBgMask.gameObject:SetActive(not isUnlock)
        NovaAPI.SetTMPText(txtEndExchange, ConfigTable.GetUIText("Activity_End_Exchange"))
        local scaleSize = Vector3.one * 0.84
        btnTrans.transform.localScale = bOpened and scaleSize or scaleSize * 0.85
        if isUnlock then
          showData.bRegisterNode = true
          local HasRedDot = RedDotManager.GetValid(RedDotDefine.Activity_Group, {
            actGroupData:GetActGroupId()
          })
          local HasNew = RedDotManager.GetValid(RedDotDefine.Activity_GroupNew, {
            actGroupData:GetActGroupId()
          })
          self._mapNode.activityRedDot_[i].gameObject:SetActive(HasRedDot)
          self._mapNode.activityRedDotNew_[i].gameObject:SetActive(HasNew and not HasRedDot)
          local scaleSize = Vector3.one * 1.19
          self._mapNode.activityRedDot_[i].transform.localScale = bOpened and scaleSize or scaleSize * 1 / 0.85
          self._mapNode.activityRedDotNew_[i].transform.localScale = bOpened and scaleSize or scaleSize * 1 / 0.85
        end
        table.insert(self.tbActivityPrepareShowList, showData)
      end
    end
  end
end

function MainViewCtrl:RefreshActivityFastEntrance()
  for k, v in ipairs(self._mapNode.btnActivityFast) do
    if self.tbActivityFast ~= nil and self.tbActivityFast[k] ~= nil and self.tbActivityFast[k]:GetActType() == GameEnum.activityType.JointDrill and self._mapNode.goActivityFastRedDot[k] ~= nil then
      RedDotManager.UnRegisterNode(RedDotDefine.JointDrillDailyEnter, self.tbActivityFast[k]:GetActId(), self._mapNode.goActivityFastRedDot[k].gameObject)
    end
    v.gameObject:SetActive(false)
    if self._mapNode.goActivityFastRedDot[k] ~= nil then
      self._mapNode.goActivityFastRedDot[k].gameObject:SetActive(false)
    end
    if self._mapNode.goActivityFastRedDotNew[k] ~= nil then
      self._mapNode.goActivityFastRedDotNew[k].gameObject:SetActive(false)
    end
  end
  self.tbActivityFast = {}
  local tbActList = PlayerData.Activity:GetActivityList()
  for nId, v in pairs(tbActList) do
    if v:CheckActShow() then
      local nActType = v:GetActType()
      local actCfg = v:GetActCfgData()
      local bShow = actCfg ~= nil and actCfg.EnterRes ~= nil and actCfg.EnterRes ~= ""
      if nActType == GameEnum.activityType.JointDrill then
        local nChallengeStartTime = v:GetChallengeStartTime()
        local nChallengeEndTime = v:GetChallengeEndTime()
        local nCurTime = CS.ClientManager.Instance.serverTimeStamp
        bShow = bShow and nChallengeStartTime <= nCurTime and nChallengeEndTime > nCurTime
      elseif nActType == GameEnum.activityType.TrekkerVersus then
        local nChallengeStartTime = v:GetChallengeStartTime()
        local nChallengeEndTime = v:GetChallengeEndTime()
        local nCurTime = CS.ClientManager.Instance.serverTimeStamp
        bShow = bShow and nChallengeStartTime <= nCurTime and nChallengeEndTime > nCurTime
      elseif nActType == GameEnum.activityType.Breakout and actCfg.MidGroupId ~= 0 then
        bShow = bShow and PlayerData.Activity:GetActivityGroupDataById(actCfg.MidGroupId) ~= nil
      end
      if bShow then
        table.insert(self.tbActivityFast, v)
      end
    end
  end
  table.sort(self.tbActivityFast, function(a, b)
    if a.nOpenTime == b.nOpenTime then
      return a:GetActSortId() > b:GetActSortId()
    end
    return a.nOpenTime > b.nOpenTime
  end)
  for k, v in ipairs(self.tbActivityFast) do
    if self._mapNode.btnActivityFast[k] ~= nil then
      self._mapNode.btnActivityFast[k].gameObject:SetActive(true)
      local actCfg = v:GetActCfgData()
      self:SetPngSprite(self._mapNode.imgActivityFastBg[k], actCfg.EnterRes)
      local nActType = v:GetActType()
      if nActType == GameEnum.activityType.TrekkerVersus then
        local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(v:GetActId())
        RedDotManager.RegisterNode(RedDotDefine.TrekkerVersus, {
          nActGroupId,
          v:GetActId()
        }, self._mapNode.goActivityFastRedDot[k], nil, nil, true)
      elseif nActType == GameEnum.activityType.JointDrill then
        v:RefreshDailyEnterRedDot()
        RedDotManager.RegisterNode(RedDotDefine.JointDrillDailyEnter, v:GetActId(), self._mapNode.goActivityFastRedDot[k], nil, nil, true)
      elseif nActType == GameEnum.activityType.Breakout then
        RedDotManager.RegisterNode(RedDotDefine.Activity_Group, actCfg.MidGroupId, self._mapNode.goActivityFastRedDot[k], nil, nil, true)
      end
      if nActType == GameEnum.activityType.Breakout then
        RedDotManager.RegisterNode(RedDotDefine.Activity_GroupNew, actCfg.MidGroupId, self._mapNode.goActivityFastRedDotNew[k], nil, nil, true)
      end
      if nActType == GameEnum.activityType.Soldier then
      end
    end
  end
end

function MainViewCtrl:RefreshActivitySubEntrance()
  self.nActivitySubEntranceId = 0
  local expireTimer = self.activitySubEntranceExpireTimer
  if expireTimer ~= nil then
    expireTimer:Cancel(false)
    self.activitySubEntranceExpireTimer = nil
  end
  local btnTrans = self._mapNode.btnActivitySubEntrance
  local nEntranceId = PlayerData.Activity:GetActivitySubEntranceId()
  local mapEntranceCfg
  if 0 < nEntranceId then
    mapEntranceCfg = ConfigTable.GetData("ActivityEntrance", nEntranceId)
    if mapEntranceCfg == nil then
      printError(string.format("ActivityEntrance表里找不到入口id：%d", nEntranceId))
    end
  end
  if mapEntranceCfg == nil then
    btnTrans.gameObject:SetActive(false)
    self:RefreshActivitySubEntranceRes(nil)
    return
  end
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  
  local function toTimeStamp(sTime, nDefault)
    if sTime == nil or sTime == "" then
      return nDefault
    end
    return CS.ClientManager.Instance:ISO8601StrToTimeStamp(sTime)
  end
  
  local nStartTime = toTimeStamp(mapEntranceCfg.StartTime, nCurTime)
  local nEndTime = toTimeStamp(mapEntranceCfg.EndTime, 0)
  if nCurTime < nStartTime or 0 < nEndTime and nCurTime >= nEndTime then
    btnTrans.gameObject:SetActive(false)
    self:RefreshActivitySubEntranceRes(nil)
    return
  end
  self.nActivitySubEntranceId = nEntranceId
  btnTrans.gameObject:SetActive(true)
  RedDotManager.RegisterNode(RedDotDefine.Activity_Entrance, nEntranceId, self._mapNode.redDotActivityEntrance, nil, nil, true)
  RedDotManager.RegisterNode(RedDotDefine.Activity_Entrance_New, nEntranceId, self._mapNode.redDotActivityEntranceNew, nil, nil, true)
  self:RefreshActivitySubEntranceRes(mapEntranceCfg.EnterRes)
  if 0 < nEndTime then
    self.activitySubEntranceExpireTimer = self:AddTimer(1, nEndTime - nCurTime + 1, function()
      self.activitySubEntranceExpireTimer = nil
      self.nActivitySubEntranceId = 0
      btnTrans.gameObject:SetActive(false)
      self:RefreshActivitySubEntranceRes(nil)
    end, true, true, false)
  end
end

function MainViewCtrl:RefreshActivitySubEntranceRes(sEnterRes)
  local sPrefabPath
  if sEnterRes ~= nil and sEnterRes ~= "" then
    sPrefabPath = string.format("UI_Activity/%s.prefab", sEnterRes)
  end
  if self.sActivitySubEntranceResPath == sPrefabPath and not IsNull(self.goActivitySubEntranceRes) then
    return
  end
  if self.sActivitySubEntranceResPath ~= nil then
    self:DestroyPrefabInstance(self.sActivitySubEntranceResPath)
    self.sActivitySubEntranceResPath = nil
    self.goActivitySubEntranceRes = nil
  end
  if sPrefabPath == nil then
    return
  end
  local trOpenBg = self._mapNode.btnActivitySubEntrance.transform:Find("AnimRoot/Open/imgBg")
  if trOpenBg == nil then
    printError("btnActivitySubEntrance 下找不到 AnimRoot/Open/imgBg 节点")
    return
  end
  local goIns = self:CreatePrefabInstance(sPrefabPath, trOpenBg)
  if IsNull(goIns) then
    printError(string.format("活动入口预制体加载失败：%s", sPrefabPath))
    return
  end
  self.sActivitySubEntranceResPath = sPrefabPath
  self.goActivitySubEntranceRes = goIns
end

function MainViewCtrl:RefreshTimeout(remainTime)
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
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

function MainViewCtrl:RefreshExchangeTimeout(remainTime)
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_OnlyMin") or "", min)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_OnlyHour") or "", hour)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_OnlyDay") or "", day)
  end
  return ConfigTable.GetUIText("Activity_End_Exchange") .. " " .. sTimeStr
end

function MainViewCtrl:FadeIn(bPlayFadeIn)
  if self.nViewState ~= view_state.init then
    self:RefreshShow()
  end
end

function MainViewCtrl:OnEvent_AfterEnterMainMenuModuleScene()
  if self.nViewState == view_state.init then
    self:RefreshShow()
  end
end

function MainViewCtrl:FadeOut()
  if self.bSkipOut then
    self.bSkipOut = false
    self:ChangeViewState(view_state.show_normal, false)
    return
  end
  self:ChangeViewState(view_state.fullScene, true)
  return 0.26
end

function MainViewCtrl:Awake()
  self.sLastTriggerAnim = nil
  if self.nViewState == nil then
    self:ChangeViewState(view_state.init)
  end
  if PanelManager.GetMainViewSkipAnimIn() ~= true then
    self._mapNode.aniMainView:Play("mainview_t_out", 0, 1)
  end
  self.bNewDay = false
  self.resourcesList = nil
  self.bannerList = nil
  self.tbCharId = nil
  self.nCurCharIdx = nil
  self.nActorShowType = nil
  self.bNeedCheckState = true
  self._bLoginSeqArmed = false
  self.nDragStartPosX = nil
  self.nDragThreshold = PlayerBoardData:GetBoardDragThreshold()
  self.nCurBubbleIndex = 0
  self.tbBubbleList = {}
  self.tbBannerInitPos = {}
  for _, v in ipairs(self._mapNode.activityBannerItem) do
    self.nBannerWidth = v.sizeDelta.x
    table.insert(self.tbBannerInitPos, v.anchoredPosition)
  end
  self:GetAtlasSprite("06_btn", "btn_agent_tab_1")
  self:InitData()
end

function MainViewCtrl:OnEnable()
  self.tbBannerDots = {}
  self._mapNode.imgPointBg.gameObject:SetActive(false)
  self.bInTransition = false
  self._bLoginSeqArmed = false
  EventManager.Add("OnEscCallback", self, self.OnEvent_OnEscCallback)
  if PanelManager.GetMainViewSkipAnimIn() == false then
    self:ChangeViewState(view_state.fullScene)
  end
  if self.nViewState == view_state.fullScene then
    self:ChangeViewState(view_state.show_normal, true)
  end
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgRoot, false)
  self.tbCharId = PlayerData.Char:GetCharIdList()
  self:LoadCharacterIndex()
  PlayerVoiceData:StartBoardFreeTimer()
  self:RefreshFuncLock()
  local mapStarTowerState = PlayerData.State:GetStarTowerState()
  local scrollerCS = self._mapNode.tmpStarTowerHint.gameObject:GetComponent("TextScroll")
  if mapStarTowerState.Id ~= 0 then
    local mapStarTowerCfgData = ConfigTable.GetData("StarTower", mapStarTowerState.Id)
    if mapStarTowerCfgData ~= nil then
      self._mapNode.goStarTowerHint:SetActive(true)
      self:SetHintLayout(true)
      local s = orderedFormat(ConfigTable.GetUIText("StarTowerLevel_Hint") or "", mapStarTowerCfgData.Name, mapStarTowerCfgData.Difficulty, mapStarTowerState.Floor)
      NovaAPI.SetTMPText(self._mapNode.tmpStarTowerHint, s)
      local rectTra = self._mapNode.tmpStarTowerHint.gameObject:GetComponent("RectTransform")
      LayoutRebuilder.ForceRebuildLayoutImmediate(rectTra)
      local width = rectTra.sizeDelta.x
      if width >= LimitWidth then
        rectTra.anchoredPosition = Vector2(18, rectTra.anchoredPosition.y)
        self:SetHintLayout(false)
        scrollerCS:StartScroll(self._mapNode.tmpStarTowerHint)
      else
        self:SetHintLayout(true)
        scrollerCS:StopScroll()
      end
    else
      scrollerCS:StopScroll()
      self._mapNode.goStarTowerHint:SetActive(false)
    end
  else
    scrollerCS:StopScroll()
    self._mapNode.goStarTowerHint:SetActive(false)
  end
  self._mapNode.eventActBannerDrag:SetStrictDrag(true)
  self.nBannerInterval = ConfigTable.GetConfigNumber("Activity_Banner_Interval_Time")
  for k, v in ipairs(self._mapNode.activityBannerItem) do
    v.anchoredPosition = self.tbBannerInitPos[k]
  end
  local bHasBattlePass = PlayerData.BattlePass:GetHasBattlePass()
  self._mapNode.btnBattlePass.gameObject:SetActive(bHasBattlePass)
  PlayerData.PotentialPreselection:SendGetPreselectionList()
  PlayerData.SoldierData:SetCurSelectSeasonId(1)
  PlayerData.SoldierData:RequestSoldierSeasonInfo()
  PlayerData.SoldierData:SendSoldierTechDetailReq()
end

function MainViewCtrl:OnDisable()
  EventManager.Remove("OnEscCallback", self, self.OnEvent_OnEscCallback)
  self.tbCharId = nil
  self.nCurCharIdx = nil
  self:ResetTimer()
  Actor2DManager.UnsetActor2D()
  Actor2DManager.UnSetDisc2D()
  Actor2DManager.UnSetCg2D()
  PlayerVoiceData:ClearTimer()
  PlayerVoiceData:StopCharVoice()
  BubbleVoiceManager.StopBubbleAnim(true)
  for _, v in ipairs(self.tbBannerDots) do
    destroy(v.gameObject)
  end
  self.tbBannerDots = {}
end

function MainViewCtrl:OnDestroy()
end

function MainViewCtrl:OnBtnClick_Actor(btn)
  if self.nViewState == view_state.fullScene then
    self:ChangeViewState(view_state.exitFullScene, true)
  end
  PlayerVoiceData:PlayBoardClickVoice()
end

function MainViewCtrl:OnBtnClick_SkipCGAnim(btn)
  Actor2DManager.SkipCGAnim()
  self:ChangeActorFinish(0)
end

function MainViewCtrl:OnBtnClick_AddRes1(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.ExChangePanel)
end

function MainViewCtrl:OnBtnClick_AddRes2(btn)
  local function func()
    EventManager.Hit(EventId.OpenPanel, PanelId.Mall, AllEnum.MallToggle.Gem)
  end
  
  self:PlayTransition(5, func)
end

function MainViewCtrl:OnBtnClick_ActivityPrepare(btn, index)
  local actGroupData = self.tbActivityPrepareShowList[index]
  if actGroupData == nil then
    return
  end
  actGroupData = actGroupData.actGroupData
  local isUnlock, txtUnlock = actGroupData:IsUnlock()
  if not isUnlock then
    EventManager.Hit(EventId.OpenMessageBox, txtUnlock)
    return
  end
  local cfg = actGroupData:GetActGroupCfgData()
  if cfg ~= nil then
    PlayerData.Activity:SendActivityDetailMsg()
    if cfg.TransitionId ~= nil and cfg.TransitionId > 0 then
      local function callback()
        EventManager.Hit(EventId.OpenPanel, cfg.PanelId, cfg.Id, true)
      end
      
      self:PlayTransition(cfg.TransitionId, callback)
    else
      EventManager.Hit(EventId.OpenPanel, cfg.PanelId, cfg.Id, true)
    end
  end
end

function MainViewCtrl:OnBtnClick_ActivityFast(btn, nIndex)
  if self.tbActivityFast[nIndex] == nil then
    return
  end
  local actDataIns = self.tbActivityFast[nIndex]
  local nActType = actDataIns:GetActType()
  if not actDataIns:CheckActivityOpen() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Invalid_Tip_3"))
    self:RefreshActivityFastEntrance()
    return
  end
  local actCfg = actDataIns:GetActCfgData()
  if actCfg.MidGroupId ~= 0 then
    local groupCfg = ConfigTable.GetData("ActivityGroup", actCfg.MidGroupId)
    if groupCfg ~= nil then
      if groupCfg.TransitionId ~= nil and 0 < groupCfg.TransitionId then
        local function callback()
          EventManager.Hit(EventId.OpenPanel, groupCfg.PanelId, groupCfg.Id)
        end
        
        self:PlayTransition(groupCfg.TransitionId, callback)
      else
        EventManager.Hit(EventId.OpenPanel, groupCfg.PanelId, groupCfg.Id)
      end
    end
  else
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    if nActType == GameEnum.activityType.JointDrill then
      local bPlayCond = actDataIns:CheckActJumpCond(true)
      if not bPlayCond then
        return
      end
      local nActId = actDataIns:GetActId()
      EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(nActId, "LevelSelect"), nActId)
    elseif nActType == GameEnum.activityType.TrekkerVersus then
      local nChallengeEndTime = actDataIns:GetChallengeEndTime()
      if nCurTime > nChallengeEndTime then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Invalid_Tip_3"))
        self:RefreshActivityFastEntrance()
        return
      end
      
      local function func()
        EventManager.Hit(EventId.OpenPanel, PanelId.TrekkerVersus, actDataIns:GetActId())
      end
      
      EventManager.Hit(EventId.SetTransition, 30, func)
    elseif nActType == GameEnum.activityType.TowerDefense then
      EventManager.Hit(EventId.OpenPanel, PanelId.TowerDefenseSelectPanel, actDataIns:GetActId())
    elseif nActType == GameEnum.activityType.Soldier then
      EventManager.Hit(EventId.OpenPanel, PanelId.SoldierMainViewPanel)
    else
      local function callback()
        PlayerData.Activity:OpenActivityPanel(actDataIns:GetActId())
      end
      
      PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.Activity, callback)
    end
  end
end

function MainViewCtrl:OnBtnClick_Phone()
  local function openCallback()
    local function callback()
      self.bSkipOut = true
    end
    
    PlayerData.Phone:OpenPhonePanel(callback)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.Phone, openCallback)
end

function MainViewCtrl:OnBtnClick_WorldClass(btn)
  local function func()
    EventManager.Hit(EventId.OpenPanel, PanelId.Quest, AllEnum.QuestPanelTab.WorldClass)
  end
  
  self:PlayTransition(5, func)
end

function MainViewCtrl:OnBtnClick_SwitchActor2D(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.ChooseHomePageRolePanel, self.nActorShowType)
end

function MainViewCtrl:OnBtnClick_HideAllUI(btn)
  if self.nViewState == view_state.show_normal or self.nViewState == view_state.show_login then
    self:ChangeViewState(view_state.fullScene, true)
  elseif self.nViewState == view_state.exitFullScene then
    self:ChangeViewState(view_state.show_normal, true)
  end
end

function MainViewCtrl:OnBtnClick_BoardChange()
  local curBoardData = PlayerBoardData:GetCurBoardData()
  if nil ~= curBoardData then
    if curBoardData:GetType() == GameEnum.handbookType.OUTFIT then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Board_No_CG"))
    elseif curBoardData:GetType() == GameEnum.handbookType.SKIN then
      if not curBoardData:CheckFavorCG() then
        local skinData = PlayerData.CharSkin:GetSkinDataBySkinId(curBoardData:GetSkinId())
        if nil ~= skinData then
          local nUnlockPlot = skinData:GetUnlockPlot()
          local mapPlot = ConfigTable.GetData("Plot", nUnlockPlot)
          if mapPlot ~= nil then
            local str = ConfigTable.GetUIText("Board_None_CG")
            EventManager.Hit(EventId.OpenMessageBox, str)
          end
        end
      else
        local bSuc, nType, nTime = Actor2DManager.SwitchActor2DType()
        self.nActorShowType = nType
        self:ChangeActorFinish(nTime)
        BubbleVoiceManager.StopBubbleAnim()
        PlayerVoiceData:StopCharVoice()
      end
    elseif curBoardData:GetType() == GameEnum.handbookType.PLOT or curBoardData:GetType() == GameEnum.handbookType.StorySet or curBoardData:GetType() == GameEnum.handbookType.StoryReview then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Board_No_CG"))
    end
  end
end

function MainViewCtrl:OnBtnClick_BoardNext()
  local bChange = PlayerBoardData:ChangeNextBoard()
  if bChange then
    self:ChangeViewState(view_state.show_normal)
    self:RefreshActor2D()
  end
end

function MainViewCtrl:OnBtnClick_btnActBanner()
  local bannerData = self.tbBannerList[self.nActBannerIdx]
  if bannerData.nType == GameEnum.bannerType.Activity then
    local function openCallback()
      if nil ~= bannerData.actData then
        PlayerData.Activity:OpenActivityPanel(bannerData.actData:GetActId())
      end
    end
    
    PlayerData.Base:CheckFunctionBtn(bannerData.nFuncType, openCallback)
  elseif bannerData.nType == GameEnum.bannerType.OpenFunc or bannerData.nType == GameEnum.bannerType.TimeLimit_Func then
    local function openCallback()
      JumpUtil.JumpTo(bannerData.nJumpTo)
    end
    
    PlayerData.Base:CheckFunctionBtn(bannerData.nFuncType, openCallback)
  elseif bannerData.nType == GameEnum.bannerType.Gacha then
    local function openCallback()
      local function getInfoCallback()
        local function func()
          EventManager.Hit(EventId.OpenPanel, PanelId.GachaSpin, bannerData.nJumpTo)
        end
        
        EventManager.Hit(EventId.SetTransition, 6, func, AllEnum.MainViewCorner.Recruit)
      end
      
      PlayerData.Gacha:GetGachaInfomation(getInfoCallback)
    end
    
    PlayerData.Base:CheckFunctionBtn(bannerData.nFuncType, openCallback)
  elseif bannerData.nType == GameEnum.bannerType.Community then
    local clientPublishRegion = CS.ClientConfig.ClientPublishRegion
    local channelName = CS.ClientConfig.ClientPublishChannelName
    if SDKManager:IsSDKInit() and clientPublishRegion == CS.ClientPublishRegion.CN and (channelName == "Official" or channelName == "TEST_1" or channelName == "Taptap") then
      local hasUrl, url = UTILS.GetBBSUrl()
      if hasUrl then
        local bbsTitle = ConfigTable.GetUIText("BBSTitle")
        SDKManager:ShowBBS(false, bbsTitle, url, "CN-BBS", false, 2)
      else
        printLog(NovaAPI.GetClientChannel() .. "——平台取不到地址")
      end
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  elseif bannerData.nType == GameEnum.bannerType.Payment then
    local clientPublishRegion = CS.ClientConfig.ClientPublishRegion
    local channelName = CS.ClientConfig.ClientPublishChannelName
    if SDKManager:IsSDKInit() and clientPublishRegion == CS.ClientPublishRegion.CN and (channelName == "Official" or channelName == "TEST_1" or channelName == "Taptap" or channelName == "TEST_2") then
      SDKManager:ShowWebView(false, "", "https://payment.yostar.cn/", 1, 1, false, "CN-PAYMENT")
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  elseif bannerData.nType == GameEnum.bannerType.Mall then
    local nJumpId = tonumber(bannerData.sParam)
    JumpUtil.JumpTo(nJumpId)
  elseif bannerData.nType == GameEnum.bannerType.MallSkin then
    local sMallPackageId = bannerData.sParam
    local mapCfg = ConfigTable.GetData("MallPackage", sMallPackageId)
    if mapCfg == nil then
      return
    end
    
    local function callback(tbList, nTime)
      local bInMall = false
      for _, v in ipairs(tbList) do
        if v.sId == sMallPackageId then
          bInMall = true
          break
        end
      end
      if not bInMall then
        return
      end
      local tbMallList = {}
      table.insert(tbMallList, {sId = sMallPackageId})
      
      local function func()
        EventManager.Hit(EventId.OpenPanel, PanelId.MallSkinPreview, tbMallList)
      end
      
      EventManager.Hit(EventId.SetTransition, 5, func)
    end
    
    PlayerData.Mall:SendMallPackageListReq(callback)
  elseif bannerData.nType == GameEnum.bannerType.JumpToUrl then
    local sUrl = bannerData.sUrl
    local bInside = bannerData.bInside
    local bUseOpenUrl = bannerData.bUseOpenUrl
    if bUseOpenUrl then
      NovaAPI.OpenURL(sUrl)
    elseif SDKManager:IsSDKInit() then
      if bInside then
        SDKManager:ShowWebView(false, "", sUrl, 1, 0, true)
      else
        SDKManager:ShowWebView(false, "", sUrl, 1, 1, true)
      end
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  elseif bannerData.nType == GameEnum.bannerType.SeaPayment then
    local sUrl = bannerData.sUrl
    local bInside = bannerData.bInside
    local sPid = bannerData.sPid
    if SDKManager:IsSDKInit() then
      if bInside then
        SDKManager:ShowWebView(false, "", sUrl, 1, 0, false, sPid)
      else
        SDKManager:ShowWebView(false, "", sUrl, 1, 1, false, sPid)
      end
    end
  end
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  table.insert(tab, {
    "banner_type",
    tostring(bannerData.nType)
  })
  table.insert(tab, {
    "banner_id",
    tostring(bannerData.nId)
  })
  NovaAPI.UserEventUpload("scrolling_banner_click", tab)
end

function MainViewCtrl:OnDrag_ActBanner(mDrag)
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.nBannerDragPosX = 0
    self:ResetActBannerTimer()
  elseif mDrag.DragEventType == AllEnum.UIDragType.Drag then
    self.nBannerDragPosX = self.nBannerDragPosX + mDrag.EventData.delta.x
    for k, v in ipairs(self._mapNode.activityBannerItem) do
      v.anchoredPosition = Vector2(self.tbBannerInitPos[k].x + self.nBannerDragPosX, self.tbBannerInitPos[k].y)
    end
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    local nPos = 0
    if self.nBannerDragPosX > 0 then
      nPos = self.nBannerWidth
      self.nActBannerIdx = 0 >= self.nActBannerIdx - 1 and #self.tbBannerList or self.nActBannerIdx - 1
    elseif self.nBannerDragPosX < 0 then
      nPos = -self.nBannerWidth
      self.nActBannerIdx = self.nActBannerIdx + 1 > #self.tbBannerList and 1 or self.nActBannerIdx + 1
    end
    local tweener
    for k, v in ipairs(self._mapNode.activityBannerItem) do
      tweener = v:DOAnchorPosX(self.tbBannerInitPos[k].x + nPos, 0.5):SetUpdate(true)
    end
    
    local function _cb()
      for k, v in ipairs(self._mapNode.activityBannerItem) do
        v.anchoredPosition = self.tbBannerInitPos[k]
      end
      self:RefreshActivityBanner()
      self:StartActBannerTimer()
    end
    
    tweener.onComplete = dotween_callback_handler(self, _cb)
    self.nBannerDragPosX = 0
  end
end

function MainViewCtrl:OnBtnClick_Menu(btn)
  self.bSkipOut = true
  EventManager.Hit(EventId.OpenPanel, PanelId.MainViewSide)
end

function MainViewCtrl:OnBtnClick_Task(btn)
  local function callback()
    local function func()
      EventManager.Hit(EventId.OpenPanel, PanelId.Quest)
    end
    
    self:PlayTransition(5, func)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.Quest, callback)
end

function MainViewCtrl:OnBtnClick_Dorm(btn)
  local function openCallback()
    PlayerData.PlayerDormData:EnterDorm()
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.Dorm, openCallback)
end

function MainViewCtrl:OnBtnClick_GuideMission(btn)
  local function callback()
    local function func()
      EventManager.Hit(EventId.OpenPanel, PanelId.GuideMission)
    end
    
    self:PlayTransition(5, func)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.GuideMission, callback)
end

function MainViewCtrl:OnBtnClick_QuestNewbie(btn)
  local function callback()
    local function func()
      EventManager.Hit(EventId.OpenPanel, PanelId.QuestNewbie)
    end
    
    self:PlayTransition(5, func)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.QuestNewbie, callback)
end

function MainViewCtrl:OnBtnClick_Mail(btn)
  local function callback()
    PlayerData.Mail:GetAllMail(nil, true)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.Mail, callback)
end

function MainViewCtrl:OnBtnClick_Notice(btn)
end

function MainViewCtrl:OnBtnClick_Friend(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.Friend)
end

function MainViewCtrl:OnBtnClick_BattlePass(btn)
  local function callback()
    local function GetDataCallback(mapData)
      if mapData.nSeasonId == 0 then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Mainview_BattlePassExpireHint"))
        
        self._mapNode.btnBattlePass.gameObject:SetActive(false)
      else
        local function func()
          EventManager.Hit(EventId.OpenPanel, PanelId.BattlePass)
        end
        
        self:PlayTransition(5, func)
      end
    end
    
    PlayerData.BattlePass:GetBattlePassInfo(GetDataCallback)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.BattlePass, callback)
end

function MainViewCtrl:OnBtnClick_Activity()
  local function callback()
    PlayerData.Activity:OpenActivityPanel()
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.Activity, callback)
end

function MainViewCtrl:OnBtnClick_ActivitySubEntrance()
  local nEntranceId = self.nActivitySubEntranceId or 0
  if nEntranceId <= 0 then
    return
  end
  
  local function callback()
    PlayerData.Activity:OpenActivityPanel(nil, nEntranceId)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.Activity, callback)
end

function MainViewCtrl:OnBtnClick_Depot(btn)
  local function func()
    EventManager.Hit(EventId.OpenPanel, PanelId.DepotPanel)
  end
  
  self:PlayTransition(5, func)
end

function MainViewCtrl:OnBtnClick_Mall(btn)
  local function func()
    EventManager.Hit(EventId.OpenPanel, PanelId.Mall)
  end
  
  self:PlayTransition(5, func)
end

function MainViewCtrl:OnBtnClick_EventReminder(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.EventReminderPanel)
end

function MainViewCtrl:OnBtnClick_Reengagement(btn)
  if not PlayerData.Reengagement:GetActIsOpen() then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.ReengagementPanel)
end

function MainViewCtrl:OnBtnClick_Shop(btn)
  local function func()
    EventManager.Hit(EventId.OpenPanel, PanelId.ShopPanel)
  end
  
  self:PlayTransition(5, func)
end

function MainViewCtrl:OnBtnClick_Role(btn)
  local function callback()
    PlayerData.Char:TempClearCharInfoData()
    
    local function func()
      EventManager.Hit(EventId.OpenPanel, PanelId.CharList)
    end
    
    self:PlayTransition(6, func, AllEnum.MainViewCorner.Role)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.Char, callback)
end

function MainViewCtrl:OnBtnClick_Disc(btn)
  local function func()
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscList)
  end
  
  self:PlayTransition(6, func, AllEnum.MainViewCorner.Disc)
end

function MainViewCtrl:OnBtnClick_Recruit(btn)
  local function callback()
    local function getInfoCallback()
      local function func()
        EventManager.Hit(EventId.OpenPanel, PanelId.GachaSpin)
      end
      
      self:PlayTransition(6, func, AllEnum.MainViewCorner.Recruit)
    end
    
    PlayerData.Gacha:GetGachaInfomation(getInfoCallback)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.Gacha, callback)
end

function MainViewCtrl:OnBtnClick_Map(btn)
  EventManager.Hit(EventId.TemporaryBlockInput, 1)
  self:AddTimer(1, 0.3, function()
    local function func()
      EventManager.Hit(EventId.OpenPanel, PanelId.LevelMenu)
    end
    
    self:PlayTransition(14, func)
  end, true, true)
end

function MainViewCtrl:OnBtnClick_Mainline()
  local function callback()
    EventManager.Hit(EventId.OpenPanel, PanelId.StoryEntrance)
  end
  
  self:PlayTransition(6, callback, AllEnum.MainViewCorner.Mainline)
end

function MainViewCtrl:OnBtnClick_AddEnergy(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.EnergyBuy)
end

function MainViewCtrl:OnBtnClick_Left(btn)
  self.nCurCharIdx = self.nCurCharIdx - 1
  if self.nCurCharIdx < 1 then
    self.nCurCharIdx = #self.tbCharId
  end
  self:RefreshActor2D()
  self:SaveCharacterIndex()
end

function MainViewCtrl:OnBtnClick_Right(btn)
  self.nCurCharIdx = self.nCurCharIdx + 1
  if self.nCurCharIdx > #self.tbCharId then
    self.nCurCharIdx = 1
  end
  self:RefreshActor2D()
  self:SaveCharacterIndex()
end

function MainViewCtrl:OnBtnClick_Dispatch()
  local function callback()
    local function func()
      EventManager.Hit(EventId.OpenPanel, PanelId.DispatchPanel)
    end
    
    self:PlayTransition(10, func)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.Agent, callback)
end

function MainViewCtrl:OnBtnClick_GoToStarTower()
  local function AffinityCallback()
    local function callback()
      PlayerData.State:CheckStarTowerState()
    end
    
    PlayerData.StarTower:SendTowerGrowthDetailReq(callback)
  end
  
  PlayerData.StarTower:GetAffinity(AffinityCallback)
end

function MainViewCtrl:OnBtnClick_GotoMainlineStory()
  EventManager.Hit(EventId.OpenPanel, PanelId.MainlineEx, self.nRecentChapterId, PanelId.MainView)
end

function MainViewCtrl:OnDragStart_Actor(mDrag)
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.nDragStartPosX = mDrag.EventData.position.x
    self._mapNode.btnActor.interactable = false
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    local dragEndPosX = mDrag.EventData.position.x
    local bChange
    if dragEndPosX - self.nDragStartPosX > self.nDragThreshold then
      bChange = PlayerBoardData:ChangeLastBoard()
    elseif dragEndPosX - self.nDragStartPosX < -self.nDragThreshold then
      bChange = PlayerBoardData:ChangeNextBoard()
    end
    if bChange then
      self:RefreshActor2D()
    end
    self._mapNode.btnActor.interactable = true
  end
end

function MainViewCtrl:OnEvent_RefreshRes(nId)
  if nId == AllEnum.CoinItemId.Energy then
    self:RefreshEnergy()
  else
    local index = self.tbRes[nId]
    if index ~= nil then
      if nId == AllEnum.CoinItemId.FREESTONE or nId == AllEnum.CoinItemId.STONE then
        self._mapNode.goCoin[index]:SetCoin(nil, PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.FREESTONE) + PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.STONE), true, 999999)
      else
        self._mapNode.goCoin[index]:SetCoin(nil, PlayerData.Coin:GetCoinCount(nId), true, 999999)
      end
    end
    self:RefreshItemExpire()
  end
end

function MainViewCtrl:OnEvent_NewDay()
  if PanelManager.GetCurPanelId() == PanelId.MainView then
    if self.timerCheck == nil and self.timerCGL2D == nil and not self.bInTransition then
      self:CheckOpenPanel()
      self:RefreshShow()
      local bHasBattlePass = PlayerData.BattlePass:GetHasBattlePass()
      self._mapNode.btnBattlePass.gameObject:SetActive(bHasBattlePass)
    else
      self.bNewDay = true
    end
  end
end

function MainViewCtrl:OnEvent_UnlockMainViewInput()
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgRoot, true)
end

function MainViewCtrl:OnTimer_CGL2D(timer)
  if self.timerCheck ~= nil then
    self.timerCheck:Cancel()
    self.timerCheck = nil
  end
  local nState = self.nViewState == view_state.fullScene_login and view_state.show_login or view_state.show_normal
  self:ChangeViewState(nState, true)
  self:_WaitEntranceThenCheck(false)
  self.timerCGL2D = nil
end

function MainViewCtrl:OnTimer_AnimCheck()
  self.timerCheck = nil
  self:CheckOpenPanel()
  if self.bNewDay then
    self.bNewDay = false
    self:RefreshShow()
  end
  EventManager.Hit("Show_MainView_UI")
end

function MainViewCtrl:OnEvent_ShowBubbleVoiceText(nCharId, nId)
  local mapVoDirectoryData = ConfigTable.GetData("VoDirectory", nId)
  if mapVoDirectoryData == nil then
    printError("VoDirectory未找到数据id:" .. nId)
    return
  end
  local curBoardData = PlayerBoardData:GetCurBoardData()
  if nil ~= curBoardData and curBoardData:GetType() == GameEnum.handbookType.SKIN and curBoardData:GetCharId() == nCharId then
    local skinId = curBoardData:GetSkinId()
    local bIsCG = self.nActorShowType == AllEnum.Actor2DType.FullScreen
    BubbleVoiceManager.PlayBubbleAnim(self._mapNode.goBubbleRoot, mapVoDirectoryData.voResource, skinId, bIsCG)
  end
end

function MainViewCtrl:OnEvent_ActivityDataChange()
  self:SetBanner()
end

function MainViewCtrl:OnEvent_MainViewCheckOpenPanel()
  if PanelManager.GetCurPanelId() == PanelId.MainView and self.timerCheck == nil and self.timerCGL2D == nil and not self.bInTransition then
    self:CheckOpenPanel()
  end
end

function MainViewCtrl:OnEvent_OnEscCallback()
  if AvgManager.CheckInAvg() then
    return
  end
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Login_QuitTips"),
    callbackConfirm = function()
      local UIGameSystemSetup = CS.UIGameSystemSetup
      UIGameSystemSetup.Instance:KillApplication()
    end
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function MainViewCtrl:OnEvent_TransAnimOutClear()
  self.bInTransition = false
  if self.bDelayOpenVoice == true then
    PlayerVoiceData:PlayMainViewOpenVoice()
    self.bDelayOpenVoice = false
  end
end

function MainViewCtrl:OnEvent_AfterCloseNPCReceive()
  self:RefreshActor2D()
  BubbleVoiceManager.StopBubbleAnim()
  PlayerVoiceData:StopCharVoice()
end

function MainViewCtrl:RefreshNewbieQuestState()
  local nTotalCount, nReceivedCount = PlayerData.TutorialData:GetProgress()
  local bTutorialComplete = nTotalCount <= nReceivedCount
  local bTeamFormationComplete = PlayerData.Quest:CheckTeamFormationAllCompleted()
  self._mapNode.btnQuestNewbie.gameObject:SetActive(not bTeamFormationComplete or not bTutorialComplete)
end

function MainViewCtrl:OnEvent_RefreshActivityGroupRedDot()
  self:RefreshLeftActivityList()
end

return MainViewCtrl
