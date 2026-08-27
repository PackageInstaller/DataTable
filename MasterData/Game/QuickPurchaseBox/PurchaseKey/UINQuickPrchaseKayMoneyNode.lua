local UINQuickPrchaseKayMoneyNode = class("UINQuickPrchaseKayMoneyNode", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINQuickPrchaseKayMoneyNode:OnInit()
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Shop, false)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.item = UINBaseItemWithCount.New()
  self.item:Init(self.ui.uINBaseItemWithCount)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfirem)
  self._refreshFunc = BindCallback(self, self.RefreshShopGoodInfo)
  MsgCenter:AddListener(eMsgEventId.MonthCardRefresh, self._refreshFunc)
end

function UINQuickPrchaseKayMoneyNode:SetNodeData(parent, goodData)
  self.parent = parent
  self.goodData = goodData
end

function UINQuickPrchaseKayMoneyNode:InitQPKNode(maxNeededKeyNum, closeCallback)
  self.maxNeededKeyNum = maxNeededKeyNum
  self.closeCallback = closeCallback
  self:RefreshShopGoodInfo()
end

function UINQuickPrchaseKayMoneyNode:RefreshShopGoodInfo()
  self.goodData:RefreshDataWithSeverMsg()
  if self.goodData.isSoldOut then
    self.ui.btn_Confirm.gameObject:SetActive(false)
    self.ui.btn_CantBuy:SetActive(true)
    self.ui.tex_CouldAddNumber.gameObject:SetActive(false)
  else
    self.ui.btn_Confirm.gameObject:SetActive(true)
    self.ui.btn_CantBuy:SetActive(false)
    self.ui.tex_CouldAddNumber.gameObject:SetActive(true)
  end
  if self.goodData.isLimit then
    self.ui.obj_limit:SetActive(true)
    self.ui.tex_LimitCount:SetIndex(0, tostring(self.goodData.totallimitTime - self.goodData.purchases), tostring(self.goodData.totallimitTime))
  else
    self.ui.obj_limit:SetActive(false)
  end
  self.ui.tex_Price.text = tostring(self.goodData.newCurrencyNum)
  self.ui.tex_CouldAddNumber:SetIndex(0, tostring(self.goodData.newCurrencyNum), tostring(self.goodData.itemNum))
  self.ui.tex_ItemDec.text = LanguageUtil.GetLocaleText(self.goodData.itemCfg.describe)
  self.item:InitItemWithCount(self.goodData.itemCfg, self.goodData.itemNum)
end

function UINQuickPrchaseKayMoneyNode:_OnClickConfirem()
  if self.parent.isSlideOuting then
    return
  end
  local tatalBuyNum = 1 * self.goodData.itemNum
  
  local function buyFunc()
    self.ctrl:ReqBuyGoods(self.goodData.shopId, self.goodData.shelfId, 1, function()
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window == nil then
          return
        end
        local CommonRewardData = require("Game.CommonUI.CommonRewardData")
        local CRData = CommonRewardData.CreateCRDataUseList({
          self.goodData.itemId
        }, {tatalBuyNum})
        window:AddAndTryShowReward(CRData)
        local needClose = true
        if self.maxNeededKeyNum ~= nil and self.maxNeededKeyNum > PlayerDataCenter.stamina:GetCurrentStamina() then
          self:RefreshShopGoodInfo()
          needClose = false
        end
        if needClose and self.closeCallback ~= nil then
          self.closeCallback()
        end
      end)
    end)
  end
  
  if self.goodData.currencyId == ConstGlobalItem.PaidSubItem then
    local totalNeedMoney = 1 * self.goodData.newCurrencyNum
    local ownMoney = PlayerDataCenter:GetItemCount(self.goodData.currencyId)
    if totalNeedMoney > ownMoney then
      local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
      
      local function beforeJumpCallback(callBack)
        self.parent:SlideOut(nil, true)
        if callBack ~= nil then
          callBack()
        end
      end
      
      local directShowShop = shopWin == nil
      local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
      payCtrl:TryConvertPayItem(self.goodData.currencyId, totalNeedMoney - ownMoney, beforeJumpCallback, nil, buyFunc, directShowShop)
      return
    end
  end
  buyFunc()
end

function UINQuickPrchaseKayMoneyNode:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.MonthCardRefresh, self._refreshFunc)
  base.OnDelete(self)
end

return UINQuickPrchaseKayMoneyNode
