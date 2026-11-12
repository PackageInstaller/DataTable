local BaseCtrl = require("GameCore.UI.BaseCtrl")
local ExChangeCtrl = class("ExChangeCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local MAX_EXCHANGE_COUNT = 999999
ExChangeCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Exchange_Title"
  },
  btnsnapshot = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  aniDetail = {
    sNodeName = "---Detail---",
    sComponentName = "Animator"
  },
  imgItem1 = {sNodeName = "imgItem1", sComponentName = "Image"},
  imgItem2 = {sNodeName = "imgItem2", sComponentName = "Image"},
  btnClose = {
    sNodeName = "btnClose",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnBuy = {
    sNodeName = "btnBuy",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Buy"
  },
  txtBtnExchange = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Exchange_Btn"
  },
  txtConsunNum = {
    sNodeName = "txtConsumNum",
    sComponentName = "TMP_Text"
  },
  rectConsunNum = {
    sNodeName = "txtConsumNum",
    sComponentName = "RectTransform"
  },
  imgimgConsumItem = {
    sNodeName = "imgConsumItem",
    sComponentName = "Image"
  },
  got_fullscreen_blur_blue = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "GameObject"
  },
  ctlTopBarPanel = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  gobtnBuyGray = {sNodeName = "btnBuyGray", sComponentName = "GameObject"},
  btnBuyGray = {
    sNodeName = "btnBuyGray",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Buy"
  },
  txtItemName1 = {
    sNodeName = "txtItemName1",
    sComponentName = "TMP_Text"
  },
  txtItemName2 = {
    sNodeName = "txtItemName2",
    sComponentName = "TMP_Text"
  },
  rectTransgoConsumCount = {
    sNodeName = "goConsumCount",
    sComponentName = "RectTransform"
  },
  imgMask = {sNodeName = "Mask", sComponentName = "Image"},
  txtStock = {
    sComponentName = "TMP_Text",
    sLanguageId = "Exchange_Count"
  },
  txtConsum = {
    sComponentName = "TMP_Text",
    sLanguageId = "Exchange_Consume"
  },
  goQuantitySelector = {
    sNodeName = "tc_quantity_selector",
    sCtrlName = "Game.UI.TemplateEx.TemplateQuantitySelectorCtrl"
  }
}
ExChangeCtrl._mapEventConfig = {}

function ExChangeCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" and 0 < #tbParam then
    local data = tbParam[1]
    if data.id1 ~= nil then
      self.exchangeId1 = data.id1
    else
      self.exchangeId1 = AllEnum.CoinItemId.STONE
    end
    if data.id2 ~= nil then
      self.exchangeId2 = data.id2
    else
      self.exchangeId2 = AllEnum.CoinItemId.Jade
    end
    if data.exchangeCount ~= nil then
      self.curExChangeCount = data.exchangeCount
    else
      self.curExChangeCount = 1
    end
    if data.rate ~= nil then
      self.exchangeRate = data.rate
    else
      self.exchangeRate = 1
    end
    if data.alpha ~= nil then
      self.maskAlpha = data.alpha
    else
      self.maskAlpha = 0.35
    end
  else
    self.exchangeId1 = AllEnum.CoinItemId.STONE
    self.exchangeId2 = AllEnum.CoinItemId.Jade
    self.exchangeRate = 1
    self.maskAlpha = 0.35
    self.curExChangeCount = 1
  end
  self.bExChanging = false
end

function ExChangeCtrl:OnEnable()
  self:RefreshPanel()
  self._mapNode.aniDetail:Play("t_window_04_t_in")
  self._mapNode.got_fullscreen_blur_blue:SetActive(true)
end

function ExChangeCtrl:RefreshPanel()
  NovaAPI.SetTMPText(self._mapNode.txtConsunNum, self.curExChangeCount)
  NovaAPI.SetTMPText(self._mapNode.txtItemName1, ConfigTable.GetData_Item(self.exchangeId1).Title .. " ×1")
  NovaAPI.SetTMPText(self._mapNode.txtItemName2, ConfigTable.GetData_Item(self.exchangeId2).Title .. " ×1")
  self:SetPngSprite(self._mapNode.imgItem1, ConfigTable.GetData_Item(self.exchangeId1).Icon)
  self:SetPngSprite(self._mapNode.imgItem2, ConfigTable.GetData_Item(self.exchangeId2).Icon)
  self:SetPngSprite(self._mapNode.imgimgConsumItem, ConfigTable.GetData_Item(self.exchangeId1).Icon2)
  local owenCount = self:GetOwenItemCount()
  local maxCount = owenCount
  if owenCount > MAX_EXCHANGE_COUNT then
    maxCount = MAX_EXCHANGE_COUNT
  elseif owenCount == 0 then
    maxCount = 1
  end
  
  local function callback(nCount)
    self.curExChangeCount = nCount
    self:RefreshConsumCount()
  end
  
  self._mapNode.goQuantitySelector:Init(callback, self.curExChangeCount, maxCount)
  self:RefreshConsumCount()
  local color = NovaAPI.GetImageColor(self._mapNode.imgMask)
  color.a = self.maskAlpha
  NovaAPI.SetImageColor(self._mapNode.imgMask, color)
end

function ExChangeCtrl:RefreshConsumCount()
  self._mapNode.gobtnBuyGray:SetActive(false)
  self._mapNode.btnBuy.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtConsunNum, self.curExChangeCount)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rectConsunNum)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rectTransgoConsumCount)
end

function ExChangeCtrl:OnClosePanel()
  EventManager.Hit(EventId.ClosePanel, PanelId.ExChangePanel)
end

function ExChangeCtrl:GetOwenItemCount()
  local count = PlayerData.Item:GetItemCountByID(self.exchangeId1)
  if self.exchangeId1 == AllEnum.CoinItemId.STONE then
    count = count + PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.FREESTONE)
  end
  return count
end

function ExChangeCtrl:OnBtnClick_Buy()
  local owenCount = self:GetOwenItemCount()
  if owenCount <= 0 or owenCount < self.curExChangeCount then
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = orderedFormat(ConfigTable.GetUIText("Recruit_Charge") or "", ConfigTable.GetData_Item(AllEnum.CoinItemId.STONE).Id),
      callbackConfirm = function()
        self:OnClosePanel()
        local nState = ConfigTable.GetConfigNumber("IsShowComBtn")
        if nState == 1 then
          EventManager.Hit(EventId.OpenPanel, PanelId.Mall, AllEnum.MallToggle.Gem)
        else
          local sContent = ConfigTable.GetUIText("Function_NotAvailable")
          EventManager.Hit(EventId.OpenMessageBox, sContent)
        end
      end,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
    EventManager.Hit("TopRes", true, self._mapNode.ctlTopBarPanel.gameObject:GetInstanceID(), {
      AllEnum.CoinItemId.Jade,
      AllEnum.CoinItemId.STONE
    })
    return
  end
  
  local function exchangeSuccessCallBack(mapData)
    self.bExChanging = false
    self:OnClosePanel()
  end
  
  local function confirmCallback()
    if self.bExChanging == true then
      return
    end
    self.bExChanging = true
    PlayerData.Coin:SendGemConvertReqReq(self.curExChangeCount, exchangeSuccessCallBack)
  end
  
  local sTips = orderedFormat(ConfigTable.GetUIText("Shop_BuyComfirm"), self.curExChangeCount, ConfigTable.GetData_Item(self.exchangeId1).Title, ConfigTable.GetData_Item(self.exchangeId2).Title)
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sTips,
    callbackConfirm = confirmCallback,
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function ExChangeCtrl:OnBtnClick_Close()
  self._mapNode.aniDetail:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "OnClosePanel", true, true, true)
end

return ExChangeCtrl
