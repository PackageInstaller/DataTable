local MainViewSideCtrl = class("MainViewSideCtrl", BaseCtrl)
local SDKManager = CS.SDKManager.Instance
local BtnType = {
  Community = 9,
  Exchange = 10,
  ToolBox = 11,
  QuestNewbie = 12
}
local BtnList = {
  [1] = BtnType.Community,
  [2] = BtnType.Exchange,
  [3] = BtnType.ToolBox,
  [4] = BtnType.QuestNewbie
}
local BtnPos = Vector2(117, -52.5)
MainViewSideCtrl._mapNodeConfig = {
  btnBg = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtMenu = {sComponentName = "TMP_Text", sLanguageId = "Menu_Title"},
  btnAchievement = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Achievement"
  },
  btnCraft = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Craft"
  },
  btnFriend = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Friend"
  },
  btnSettings = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Settings"
  },
  txtAchievement = {
    sComponentName = "TMP_Text",
    sLanguageId = "Menu_Achievement"
  },
  txtCraft = {sComponentName = "TMP_Text", sLanguageId = "Menu_Craft"},
  txtFriend = {
    sComponentName = "TMP_Text",
    sLanguageId = "Menu_Friend"
  },
  txtSettings = {
    sComponentName = "TMP_Text",
    sLanguageId = "Menu_Settings"
  },
  btnList2 = {
    sNodeName = "ButtonList2",
    sComponentName = "RectTransform"
  },
  btnDictionary = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Dictionary"
  },
  btnCheckIn = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CheckIn"
  },
  btnExchange = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Exchange"
  },
  btnNews = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_News"
  },
  btnService = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Service"
  },
  btnMerchandise = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Merchandise"
  },
  btnCommunity = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Community"
  },
  btnSwitch = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Switch"
  },
  btnToolBox = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ToolBox"
  },
  btnQuestNewbie = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_QuestNewbie"
  },
  txtDictionary = {
    sComponentName = "TMP_Text",
    sLanguageId = "Menu_Dictionary"
  },
  txtCheckIn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Menu_CheckIn"
  },
  txtExchange = {
    sComponentName = "TMP_Text",
    sLanguageId = "Menu_Exchange"
  },
  txtNews = {sComponentName = "TMP_Text", sLanguageId = "Menu_News"},
  txtService = {
    sComponentName = "TMP_Text",
    sLanguageId = "Menu_Service"
  },
  txtMerchandise = {
    sComponentName = "TMP_Text",
    sLanguageId = "Menu_Merchandise"
  },
  txtCommunity = {
    sComponentName = "TMP_Text",
    sLanguageId = "Menu_Community"
  },
  txtSwitch = {
    sComponentName = "TMP_Text",
    sLanguageId = "Menu_Switch"
  },
  txtToolBox = {
    sComponentName = "TMP_Text",
    sLanguageId = "Menu_ToolBox"
  },
  txtQuestNewbie = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_QuestNewbie"
  },
  redDotFriend = {},
  redDotDictionary = {},
  redDotAchievement = {},
  goLockCraft = {},
  goLockCheckIn = {}
}
MainViewSideCtrl._mapEventConfig = {
  SDKNotAvailable = "OnEvent_SDKNotAvailable"
}
MainViewSideCtrl._mapRedDotConfig = {
  [RedDotDefine.Dictionary] = {
    sNodeName = "redDotDictionary"
  },
  [RedDotDefine.Friend] = {
    sNodeName = "redDotFriend"
  },
  [RedDotDefine.Achievement] = {
    sNodeName = "redDotAchievement"
  }
}

function MainViewSideCtrl:PlayInAni()
  self.ani:Play("mainviewside_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
end

function MainViewSideCtrl:PlayOutAni()
  self.ani:Play("mainviewside_out")
  local nAnimLength = NovaAPI.GetAnimClipLength(self.ani, {
    "mainviewside_out"
  })
  self:AddTimer(1, nAnimLength, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.MainViewSide)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLength)
end

function MainViewSideCtrl:InitCommunity()
  local bEnable = self:CheckBtnEnable(BtnType.Community)
  self._mapNode.btnCommunity.gameObject:SetActive(bEnable)
end

function MainViewSideCtrl:CheckCommunityEnable()
  local bEnable = false
  local clientPublishRegion = CS.ClientConfig.ClientPublishRegion
  local channelName = CS.ClientConfig.ClientPublishChannelName
  if clientPublishRegion == CS.ClientPublishRegion.CN and (channelName == "Official" or channelName == "TEST_1" or channelName == "Taptap") then
    bEnable = true
  end
  return bEnable
end

function MainViewSideCtrl:InitExchangeCode()
  local bEnable = self:CheckBtnEnable(BtnType.Exchange)
  local newParent = self:GetBtnNewParent(BtnType.Exchange)
  if newParent ~= nil then
    local exChangeTra = self._mapNode.btnExchange.transform
    if exChangeTra.parent.gameObject.name ~= newParent.gameObject.name then
      exChangeTra:SetParent(newParent)
      exChangeTra.anchoredPosition = BtnPos
    end
  end
  self._mapNode.btnExchange.gameObject:SetActive(bEnable)
end

function MainViewSideCtrl:CheckCodeEnable()
  if NovaAPI.IsReviewServerEnv() then
    return false
  end
  local bEnable = false
  local sEnableStr = ConfigTable.GetConfigValue("EnableExchange")
  if sEnableStr == "" or sEnableStr == nil then
    return bEnable
  end
  local tbPublishChannerl = string.split(sEnableStr, ",")
  local fullChannnel = CS.ClientConfig.FullClientPublishChannelName
  local sClient = string.sub(fullChannnel, 4)
  for _, channel in ipairs(tbPublishChannerl) do
    if string.match(sClient, channel) ~= nil then
      bEnable = true
      break
    end
  end
  return bEnable
end

function MainViewSideCtrl:InitToolBox()
  local bEnable = self:CheckBtnEnable(BtnType.ToolBox)
  local newParent = self:GetBtnNewParent(BtnType.ToolBox)
  if newParent ~= nil then
    local toolBoxTra = self._mapNode.btnToolBox.transform
    if toolBoxTra.parent.gameObject.name ~= newParent.gameObject.name then
      toolBoxTra:SetParent(newParent)
      toolBoxTra.anchoredPosition = BtnPos
    end
  end
  self._mapNode.btnToolBox.gameObject:SetActive(bEnable)
end

function MainViewSideCtrl:CheckToolBoxEnable()
  if NovaAPI.IsReviewServerEnv() then
    return false
  end
  return true
end

function MainViewSideCtrl:InitQuestNewbie()
  local bEnable = self:CheckBtnEnable(BtnType.QuestNewbie)
  local newParent = self:GetBtnNewParent(BtnType.QuestNewbie)
  if newParent ~= nil then
    local questNewbieTra = self._mapNode.btnQuestNewbie.transform
    if questNewbieTra.parent.gameObject.name ~= newParent.gameObject.name then
      questNewbieTra:SetParent(newParent)
      questNewbieTra.anchoredPosition = BtnPos
    end
  end
  self._mapNode.btnQuestNewbie.gameObject:SetActive(bEnable)
end

function MainViewSideCtrl:CheckQuestNewbieEnable()
  local nTotalCount, nReceivedCount = PlayerData.TutorialData:GetProgress()
  local bTutorialComplete = nTotalCount <= nReceivedCount
  local bTeamFormationComplete = PlayerData.Quest:CheckTeamFormationAllCompleted()
  return bTeamFormationComplete and bTutorialComplete
end

function MainViewSideCtrl:CheckBtnEnable(nBtnType)
  local bEnable = false
  if nBtnType == BtnType.Community then
    bEnable = self:CheckCommunityEnable()
  elseif nBtnType == BtnType.Exchange then
    bEnable = self:CheckCodeEnable()
  elseif nBtnType == BtnType.ToolBox then
    bEnable = self:CheckToolBoxEnable()
  elseif nBtnType == BtnType.QuestNewbie then
    bEnable = self:CheckQuestNewbieEnable()
  end
  return bEnable
end

function MainViewSideCtrl:GetBtnNewParent(nBtnType)
  local newParent
  local nMoveValue = 0
  for index, btnType in ipairs(BtnList) do
    if nBtnType <= btnType then
      break
    end
    local bEnable = self:CheckBtnEnable(btnType)
    if not bEnable then
      nMoveValue = nMoveValue + 1
    end
  end
  local move2ParentName = tostring(nBtnType - nMoveValue)
  newParent = self._mapNode.btnList2:Find(move2ParentName)
  return newParent
end

function MainViewSideCtrl:FadeIn()
  if self._panel._nFadeInType == 1 then
    self:PlayInAni()
  end
end

function MainViewSideCtrl:FadeOut()
  self._panel._nFadeInType = 2
  if not self.nTransType then
    return 0
  elseif self.nTransType == 5 then
    return 0.26
  end
end

function MainViewSideCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
  self:InitCommunity()
  self:InitExchangeCode()
  self:InitToolBox()
  self:InitQuestNewbie()
end

function MainViewSideCtrl:OnEnable()
  PanelManager.SetMainViewSkipAnimIn(true)
  self.nTransType = nil
  self._mapNode.goLockCraft:SetActive(not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Crafting))
  self._mapNode.goLockCheckIn:SetActive(not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.SignIn))
end

function MainViewSideCtrl:OnDisable()
end

function MainViewSideCtrl:OnDestroy()
end

function MainViewSideCtrl:OnBtnClick_Close()
  self:PlayOutAni()
end

function MainViewSideCtrl:OnBtnClick_Achievement()
  self.nTransType = 5
  PanelManager.SetMainViewSkipAnimIn(false)
  
  local function func()
    EventManager.Hit(EventId.OpenPanel, PanelId.Achievement)
  end
  
  EventManager.Hit(EventId.SetTransition, 5, func)
end

function MainViewSideCtrl:OnBtnClick_Craft()
  local function callback()
    self.nTransType = 5
    
    PanelManager.SetMainViewSkipAnimIn(false)
    
    local function func()
      EventManager.Hit(EventId.OpenPanel, PanelId.Crafting)
    end
    
    EventManager.Hit(EventId.SetTransition, 5, func)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.Crafting, callback)
end

function MainViewSideCtrl:OnBtnClick_Friend()
  self.nTransType = 5
  PanelManager.SetMainViewSkipAnimIn(false)
  
  local function func()
    EventManager.Hit(EventId.OpenPanel, PanelId.Friend)
  end
  
  EventManager.Hit(EventId.SetTransition, 5, func)
end

function MainViewSideCtrl:OnBtnClick_Settings()
  EventManager.Hit(EventId.OpenPanel, PanelId.Settings)
end

function MainViewSideCtrl:OnBtnClick_Dictionary()
  self.nTransType = 5
  PanelManager.SetMainViewSkipAnimIn(false)
  
  local function func()
    EventManager.Hit(EventId.OpenPanel, PanelId.Dictionary)
  end
  
  EventManager.Hit(EventId.SetTransition, 5, func)
end

function MainViewSideCtrl:OnBtnClick_CheckIn()
  local function callback()
    EventManager.Hit(EventId.OpenPanel, PanelId.DailyCheckIn, {})
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.SignIn, callback)
end

function MainViewSideCtrl:OnBtnClick_Exchange()
  EventManager.Hit(EventId.OpenPanel, PanelId.ExchangeCodePanel)
end

function MainViewSideCtrl:OnBtnClick_News()
  local function callback(...)
    if PlayerData.AnnouncementData:HasAnnouncement() then
      EventManager.Hit(EventId.OpenPanel, PanelId.AnnouncementPanel, true)
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  end
  
  PlayerData.AnnouncementData:SendAllDataQuest(callback)
end

function MainViewSideCtrl:OnBtnClick_Service()
  if SDKManager:IsSDKInit() then
    local channelName = CS.ClientConfig.ClientPublishChannelName
    if channelName == "Bilibili" then
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Alert,
        sContent = ConfigTable.GetUIText("Service_Bilibili_Tips")
      })
    else
      SDKManager.SDK:ShowCS(tostring(PlayerData.Base._nPlayerId), PlayerData.Base._sPlayerNickName)
    end
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
  end
end

function MainViewSideCtrl:OnBtnClick_Merchandise()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
end

function MainViewSideCtrl:OnBtnClick_Community()
  if SDKManager:IsSDKInit() and (NovaAPI.GetClientChannel() == "CN" or NovaAPI.GetClientChannel() == "CN_TEST_1") then
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
end

function MainViewSideCtrl:OnBtnClick_Switch()
  EventManager.Hit(EventId.OpenPanel, PanelId.ChangeGender)
end

function MainViewSideCtrl:OnEvent_SDKNotAvailable()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
end

function MainViewSideCtrl:OnBtnClick_ToolBox()
  if SDKManager:IsSDKInit() then
    local hasUrl, url = UTILS.GetToolBoxUrl()
    if hasUrl then
      SDKManager:ShowWebView(false, "", url, 1, 0, true)
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
  end
end

function MainViewSideCtrl:OnBtnClick_QuestNewbie()
  local function callback()
    local function func()
      EventManager.Hit(EventId.OpenPanel, PanelId.QuestNewbie)
    end
    
    EventManager.Hit(EventId.SetTransition, 5, func)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.QuestNewbie, callback)
end

return MainViewSideCtrl
