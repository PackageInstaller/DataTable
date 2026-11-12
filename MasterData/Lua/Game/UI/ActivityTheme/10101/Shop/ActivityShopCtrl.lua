local ActivityShopCtrl = class("ActivityShopCtrl", BaseCtrl)
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
local PlayerVoiceData = PlayerData.Voice
ActivityShopCtrl._mapNodeConfig = {
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
  Goods = {
    sNodeName = "---Goods---",
    sCtrlName = "Game.UI.ActivityTheme.10101.Shop.ActivityShopGoodsCtrl"
  },
  goBubbleRoot = {
    sNodeName = "----fixed_bubble----"
  }
}
ActivityShopCtrl._mapEventConfig = {
  ActivityShopTimeRefresh = "OnEvent_TimeRefresh",
  [EventId.ShowBubbleVoiceText] = "OnEvent_ShowBubbleVoiceText",
  ActivityShopBuyVoice = "PlayBuyVoice",
  [EventId.UIBackConfirm] = "OnEvent_UIBack",
  [EventId.UIHomeConfirm] = "OnEvent_Home"
}

function ActivityShopCtrl:CheckShopData()
  EventManager.Hit("ActivityShopCloseDetail")
  self._panel.actShopData:RefreshActivityShopData()
  self:RefreshData()
  if self.nShopCount == 0 or not self.nSelectShop then
    return
  end
  self:RefreshTog()
  self:SetTimer()
  self:SwitchTog()
  self:RefreshNPC2D()
end

function ActivityShopCtrl:RefreshData()
  self.tbShops = self._panel.actShopData:GetShopList()
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
  if self.tbShops[self.nCurTog] then
    self.nSelectShop = self.tbShops[self.nCurTog].nId
  end
end

function ActivityShopCtrl:RefreshTog()
  if self.nShopCount > 1 then
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

function ActivityShopCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  if not self.ctrlTog[nInstanceID] then
    self.ctrlTog[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateToggleCtrl")
  end
  local mapCfg = ConfigTable.GetData("ActivityShop", self.tbShops[nIndex].nId)
  if mapCfg then
    self.ctrlTog[nInstanceID]:SetText(mapCfg.Name)
  end
  self.ctrlTog[nInstanceID]:SetDefault(nIndex == self.nCurTog)
end

function ActivityShopCtrl:OnGridBtnClick(goGrid, gridIndex)
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

function ActivityShopCtrl:SetTimer()
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  local nTime = self._panel.actShopData:GetShopAutoUpdateTime()
  if 0 < nTime then
    self.timer = self:AddTimer(1, nTime, function()
      self:CheckShopData()
      if self.nShopCount == 0 then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_End_Notice"))
        EventManager.Hit(EventId.CloseMessageBox)
        EventManager.Hit(EventId.CloesCurPanel)
      else
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Shop_ShopRefresh"))
      end
    end, true, true, false)
  end
end

function ActivityShopCtrl:SwitchTog()
  local mapShop = self.tbShops[self.nCurTog]
  local mapCfg = ConfigTable.GetData("ActivityShop", mapShop.nId)
  if not mapCfg then
    return
  end
  self._mapNode.TopBar:CreateCoin({
    mapCfg.CurrencyItemId
  })
  self._mapNode.Goods:Open(mapShop.nId, mapShop.nNextRefreshTime)
end

function ActivityShopCtrl:RefreshNPC2D()
  local bUseL2D = LocalSettingData.mapData.UseLive2D
  self._mapNode.rawImgActor2D.transform.localScale = bUseL2D == true and Vector3.one or Vector3.zero
  self._mapNode.trActor2D_PNG.localScale = bUseL2D == true and Vector3.zero or Vector3.one
  if bUseL2D == true then
    Actor2DManager.SetBoardNPC2D(PanelId.SwimShop, self._mapNode.rawImgActor2D, self.nNpcId)
  else
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.trActor2D_PNG, PanelId.SwimShop, self.nNpcId)
  end
end

function ActivityShopCtrl:PlayEnterVoice()
  local bFirst = self._panel.actShopData:GetShopFirstIn()
  local sTimeVoice = PlayerData.Voice:GetNPCGreetTimeVoiceKey()
  if bFirst then
    PlayerData.Voice:PlayCharVoice(sTimeVoice, self.nNpcId)
  else
    local nIndex = math.random(1, 2)
    local sVoice = nIndex == 1 and sTimeVoice or "greet_npc"
    PlayerData.Voice:PlayCharVoice(sVoice, self.nNpcId)
  end
end

function ActivityShopCtrl:PlayBuyVoice(bLimit)
  local sVoice = ""
  if bLimit then
    sVoice = "limited"
  else
    sVoice = "thank_npc"
  end
  PlayerData.Voice:PlayCharVoice(sVoice, self.nNpcId)
end

function ActivityShopCtrl:PlaySwitchTogVoice()
  PlayerData.Voice:PlayCharVoice("Tab", self.nNpcId)
end

function ActivityShopCtrl:RefreshNPCId()
  local mapCfg = ConfigTable.GetData("ActivityShopControl", self._panel.nActId)
  if not mapCfg then
    return
  end
  local tbNpc = mapCfg.Npc
  local nRandomIndex = math.random(1, #tbNpc)
  self.nNpcId = tbNpc[nRandomIndex]
end

function ActivityShopCtrl:FadeIn(bPlayFadeIn)
  self._mapNode.aniRoot:Play("ShopPanel_in")
end

function ActivityShopCtrl:Awake()
  self.nCurTog = nil
end

function ActivityShopCtrl:OnEnable()
  self:RefreshNPCId()
  PlayerVoiceData:StartBoardFreeTimer(self.nNpcId)
  self:PlayEnterVoice()
  self:CheckShopData()
end

function ActivityShopCtrl:OnDisable()
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

function ActivityShopCtrl:OnDestroy()
end

function ActivityShopCtrl:OnBtnClick_Actor2D()
  PlayerVoiceData:PlayBoardNPCClickVoice(self.nNpcId)
end

function ActivityShopCtrl:OnEvent_TimeRefresh()
  self:CheckShopData()
end

function ActivityShopCtrl:OnEvent_ShowBubbleVoiceText(nNpcId, nId)
  if nNpcId ~= self.nNpcId then
    return
  end
  local mapVoDirectoryData = ConfigTable.GetData("VoDirectory", nId)
  if mapVoDirectoryData == nil then
    printError("VoDirectory未找到数据id:" .. nId)
    return
  end
  BubbleVoiceManager.PlayFixedBubbleAnim(self._mapNode.goBubbleRoot, mapVoDirectoryData.voResource)
end

function ActivityShopCtrl:OnEvent_UIBack(nPanelId)
  if PanelId.DiscSample ~= nPanelId or PanelId.CharBgTrialPanel ~= nPanelId then
    PlayerVoiceData:StartBoardFreeTimer(self.nNpcId)
    CS.WwiseAudioManager.Instance:SetState("menuTransition", "open")
  end
end

function ActivityShopCtrl:OnEvent_Home(nPanelId)
  if PanelId.DiscSample ~= nPanelId or PanelId.CharBgTrialPanel ~= nPanelId then
    PlayerVoiceData:StartBoardFreeTimer(self.nNpcId)
  end
end

return ActivityShopCtrl
