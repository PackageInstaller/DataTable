local ShopCtrl = class("ShopCtrl", BaseCtrl)
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
local PlayerVoiceData = PlayerData.Voice
ShopCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  aniRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  btnActor2D = {
    sComponentName = "Button",
    callback = "OnBtnClick_Actor2D"
  },
  svTog = {
    sComponentName = "LoopScrollView"
  },
  trSvTog = {sNodeName = "svTog", sComponentName = "Transform"},
  goRefresh = {},
  txtRefreshCn = {sComponentName = "TMP_Text"},
  txtRefreshTime = {sComponentName = "TMP_Text"},
  Goods = {
    sNodeName = "---Goods---",
    sCtrlName = "Game.UI.ShopEx.ShopGoodsCtrl"
  },
  btnDailyGift = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DailyGift"
  },
  txtGiftOff = {sComponentName = "TMP_Text"},
  txtDailyGift = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_DailyGift"
  },
  goGiftOn = {},
  goGiftOff = {},
  reddotGift = {},
  goBubbleRoot = {
    sNodeName = "----fixed_bubble----"
  }
}
ShopCtrl._mapEventConfig = {
  ShopTimeRefresh = "OnEvent_TimeRefresh",
  [EventId.IsNewDay] = "RefreshDailyGift",
  [EventId.NewFuncUnlockWorldClass] = "OnEvent_NewFuncUnlockWorldClass",
  [EventId.ShowBubbleVoiceText] = "OnEvent_ShowBubbleVoiceText",
  ShopBuyVoice = "PlayBuyVoice",
  [EventId.UIBackConfirm] = "OnEvent_UIBack",
  [EventId.UIHomeConfirm] = "OnEvent_Home"
}
ShopCtrl._mapRedDotConfig = {
  [RedDotDefine.Shop_Daily] = {sNodeName = "reddotGift"}
}
local npcId = 9131

function ShopCtrl:CheckShopData()
  EventManager.Hit("ShopCloseDetail")
  PlayerData.Shop:CheckShopData(function()
    self:RefreshData()
    self:RefreshTog()
    self:SetTimer()
    self:SwitchTog()
  end)
  self:RefreshNPC2D()
end

function ShopCtrl:RefreshData()
  self.tbShops = PlayerData.Shop:GetShopList()
  self.nShopCount = #self.tbShops
  self.ctrlTog = {}
  if self.nCurTog == nil then
    self.nCurTog = 1
    if self._panel.nDefaultId then
      for k, v in ipairs(self.tbShops) do
        if v.nId == self._panel.nDefaultId then
          self.nCurTog = k
          break
        end
      end
    end
  end
  if not self.tbShops[self.nCurTog] or self.nSelectShop and self.tbShops[self.nCurTog].nId ~= self.nSelectShop then
    self.nCurTog = 1
  end
  self.nSelectShop = self.tbShops[self.nCurTog].nId
end

function ShopCtrl:RefreshTog()
  if self.nShopCount > 0 then
    self._mapNode.svTog.gameObject:SetActive(true)
    for nInstanceID, objCtrl in pairs(self.ctrlTog) do
      self:UnbindCtrlByNode(objCtrl)
      self.ctrlTog[nInstanceID] = nil
    end
    self._mapNode.svTog:Init(self.nShopCount, self, self.OnGridRefresh, self.OnGridBtnClick)
  else
    self._mapNode.svTog.gameObject:SetActive(false)
  end
end

function ShopCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  if not self.ctrlTog[nInstanceID] then
    self.ctrlTog[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateToggleCtrl")
  end
  self.ctrlTog[nInstanceID]:SetText(self.tbShops[nIndex].sName)
  self.ctrlTog[nInstanceID]:SetDefault(nIndex == self.nCurTog)
end

function ShopCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  if nIndex == self.nCurTog then
    return
  end
  self.ctrlTog[nInstanceID]:SetTrigger(true)
  if self.nCurTog then
    local goSelect = self._mapNode.trSvTog:Find("Viewport/Content/" .. self.nCurTog - 1)
    if goSelect then
      self.ctrlTog[goSelect.gameObject:GetInstanceID()]:SetTrigger(false)
    end
  end
  self.nCurTog = nIndex
  self.nSelectShop = self.tbShops[self.nCurTog].nId
  self:SwitchTog()
  self._mapNode.aniRoot:Play("ShopPanel_in")
  self:PlaySwitchTogVoice()
end

function ShopCtrl:SetTimer()
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  local nTime = PlayerData.Shop:GetShopAutoUpdateTime()
  if 0 < nTime then
    self.timer = self:AddTimer(1, nTime, function()
      self:CheckShopData()
      EventManager.Hit(EventId.CloseMessageBox)
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Shop_ShopRefresh"))
    end, true, true, false)
  end
end

function ShopCtrl:SwitchTog()
  local mapShop = self.tbShops[self.nCurTog]
  self._mapNode.TopBar:CreateCoin(mapShop.tbShopCoin)
  self._mapNode.Goods:Open(mapShop.nId, mapShop.nNextRefreshTime)
  self.nRemainTime = mapShop.nNextRefreshTime == 0 and 0 or mapShop.nNextRefreshTime - CS.ClientManager.Instance.serverTimeStamp
  if self.timerCountDown == nil then
    self.timerCountDown = self:AddTimer(0, 1, "RefreshTime", false, true, false)
  end
  if self.nRemainTime > 0 then
    self._mapNode.goRefresh:SetActive(true)
    self:RefreshTime()
    self.timerCountDown:Pause(false)
  else
    self._mapNode.goRefresh:SetActive(false)
    self.timerCountDown:Pause(true)
  end
end

function ShopCtrl:RefreshTime()
  self.nRemainTime = self.nRemainTime - 1
  if self.nRemainTime > 0 then
    local mapShop = self.tbShops[self.nCurTog]
    NovaAPI.SetTMPText(self._mapNode.txtRefreshCn, mapShop.nNextRefreshTime == mapShop.nCloseTime and ConfigTable.GetUIText("Shop_NextClose") or ConfigTable.GetUIText("Shop_NextRefresh"))
    local sTime = ""
    if self.nRemainTime <= 60 then
      local sec = math.floor(self.nRemainTime)
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_NextRefresh_Sec"), sec)
    elseif self.nRemainTime > 60 and self.nRemainTime <= 3600 then
      local min = math.floor(self.nRemainTime / 60)
      local sec = math.floor(self.nRemainTime - min * 60)
      if sec == 0 then
        min = min - 1
        sec = 60
      end
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_NextRefresh_Min"), min, sec)
    elseif self.nRemainTime > 3600 and self.nRemainTime <= 86400 then
      local hour = math.floor(self.nRemainTime / 3600)
      local min = math.floor((self.nRemainTime - hour * 3600) / 60)
      if min == 0 then
        hour = hour - 1
        min = 60
      end
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_NextRefresh_Hour"), hour, min)
    elseif self.nRemainTime > 86400 then
      local day = math.floor(self.nRemainTime / 86400)
      local hour = math.floor((self.nRemainTime - day * 86400) / 3600)
      if hour == 0 then
        day = day - 1
        hour = 24
      end
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_NextRefresh_Day"), day, hour)
    end
    NovaAPI.SetTMPText(self._mapNode.txtRefreshTime, sTime)
  else
    self.timerCountDown:Pause(true)
  end
end

function ShopCtrl:RefreshNPC2D()
  local bUseL2D = LocalSettingData.mapData.UseLive2D
  self._mapNode.rawImgActor2D.transform.localScale = bUseL2D == true and Vector3.one or Vector3.zero
  self._mapNode.trActor2D_PNG.localScale = bUseL2D == true and Vector3.zero or Vector3.one
  if bUseL2D == true then
    Actor2DManager.SetBoardNPC2D(self:GetPanelId(), self._mapNode.rawImgActor2D, npcId)
  else
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.trActor2D_PNG, self:GetPanelId(), npcId)
  end
end

function ShopCtrl:RefreshDailyGift()
  local bUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.DailyReward)
  NovaAPI.SetTMPText(self._mapNode.txtGiftOff, bUnlock and ConfigTable.GetUIText("Shop_Received") or ConfigTable.GetUIText("Shop_DailyGift_Locked"))
  if bUnlock then
    local bActive = PlayerData.Shop:GetDailyShopReward()
    self._mapNode.goGiftOff:SetActive(not bActive)
    self._mapNode.goGiftOn:SetActive(bActive)
  else
    self._mapNode.goGiftOff:SetActive(true)
    self._mapNode.goGiftOn:SetActive(false)
  end
end

function ShopCtrl:PlayEnterVoice()
  local bFirst = PlayerData.Shop:GetShopFirstIn()
  local sTimeVoice = PlayerData.Voice:GetNPCGreetTimeVoiceKey()
  if bFirst then
    PlayerData.Voice:PlayCharVoice(sTimeVoice, npcId, nil, true)
  else
    local nIndex = math.random(1, 2)
    local sVoice = nIndex == 1 and sTimeVoice or "greet_npc"
    PlayerData.Voice:PlayCharVoice(sVoice, npcId, nil, true)
  end
end

function ShopCtrl:PlayBuyVoice(bSale, bLimit)
  local sVoice = ""
  if bSale then
    sVoice = "onsale"
  elseif bLimit then
    sVoice = "limited"
  else
    sVoice = "thank_npc"
  end
  PlayerData.Voice:PlayCharVoice(sVoice, npcId, nil, true)
end

function ShopCtrl:PlaySwitchTogVoice()
  PlayerData.Voice:PlayCharVoice("Tab", npcId, nil, true)
end

function ShopCtrl:PlayDailyGiftVoice()
  PlayerData.Voice:PlayCharVoice("thanksp", npcId, nil, true)
end

function ShopCtrl:FadeIn(bPlayFadeIn)
  EventManager.Hit(EventId.SetTransition)
  self._mapNode.aniRoot:Play("ShopPanel_in")
end

function ShopCtrl:Awake()
  self.nCurTog = nil
end

function ShopCtrl:OnEnable()
  PlayerVoiceData:StartBoardFreeTimer(npcId)
  self:PlayEnterVoice()
  self:RefreshDailyGift()
  self:CheckShopData()
end

function ShopCtrl:OnDisable()
  if self.ctrlTog then
    for nInstanceId, objCtrl in pairs(self.ctrlTog) do
      self:UnbindCtrlByNode(objCtrl)
      self.ctrlTog[nInstanceId] = nil
    end
    self.ctrlTog = {}
  end
  Actor2DManager.UnsetBoardNPC2D()
  BubbleVoiceManager.StopBubbleAnim()
  PlayerVoiceData:ClearTimer()
  PlayerVoiceData:StopCharVoice()
end

function ShopCtrl:OnDestroy()
end

function ShopCtrl:OnBtnClick_Actor2D()
  PlayerVoiceData:PlayBoardNPCClickVoice(npcId)
end

function ShopCtrl:OnBtnClick_DailyGift()
  local function checkcallback()
    local bActive = PlayerData.Shop:GetDailyShopReward()
    
    if not bActive then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Shop_DailyGift_Received"))
      return
    end
    
    local function callback()
      self:RefreshDailyGift()
      self:PlayDailyGiftVoice()
    end
    
    PlayerData.Shop:SendDailyShopRewardReceiveReq(callback)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.DailyReward, checkcallback, "ui_systerm_locked")
end

function ShopCtrl:OnEvent_TimeRefresh()
  self:CheckShopData()
end

function ShopCtrl:OnEvent_NewFuncUnlockWorldClass(nId)
  if nId == GameEnum.OpenFuncType.DailyReward then
    self:RefreshDailyGift()
  end
end

function ShopCtrl:OnEvent_ShowBubbleVoiceText(nNpcId, nId)
  if nNpcId ~= npcId then
    return
  end
  local mapVoDirectoryData = ConfigTable.GetData("VoDirectory", nId)
  if mapVoDirectoryData == nil then
    printError("VoDirectory未找到数据id:" .. nId)
    return
  end
  BubbleVoiceManager.PlayFixedBubbleAnim(self._mapNode.goBubbleRoot, mapVoDirectoryData.voResource)
end

function ShopCtrl:OnEvent_UIBack(nPanelId)
  if PanelId.DiscSample ~= nPanelId or PanelId.CharBgTrialPanel ~= nPanelId then
    PlayerVoiceData:StartBoardFreeTimer(npcId)
  end
end

function ShopCtrl:OnEvent_Home(nPanelId)
  if PanelId.DiscSample ~= nPanelId or PanelId.CharBgTrialPanel ~= nPanelId then
    PlayerVoiceData:StartBoardFreeTimer(npcId)
  end
end

return ShopCtrl
