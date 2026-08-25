local MAX_CONSUME_NUM = 3
local AlchemyCompositeConfirmView, Super = NewClass("AlchemyCompositeConfirmView", BaseView)
AlchemyCompositeConfirmView.uiResCls = UI_Alchemy_Popup_Compound_Tips_OptimizeResource

function AlchemyCompositeConfirmView:ctor(confirmCb)
  Super.ctor(self)
  self.confirmCb = confirmCb
  self.model = AlchemyCompositeExtModel.Instance
  self.curSelectTid = self.model.curSelectTid
  self.currencyTid = self.model.curCompositeCurrencyTid
  self.composeData = self.model:GetCompositeDataByTid(self.curSelectTid)
end

function AlchemyCompositeConfirmView:RegisterNotifications()
end

function AlchemyCompositeConfirmView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.OnCancleClick))
end

function AlchemyCompositeConfirmView:OnEnterView()
  Super.OnEnterView(self)
  local currencyCfg = DT.Item[self.currencyTid] or {}
  self:_OnInitTargetItemComp()
  self:_OnInitCostItemComp()
  self:_OnInitPopTipsComp()
  self.ui.Text_Pay:SetActive(self.currencyTid and 0 ~= self.model.curCompositeCurrencyCostNum)
  self:SetText(self.ui.Text_Need, LT.Text("ItemNeed"))
  self:SetText(self.ui.Text_Pay, self:_GetTextPay())
  self:SetImage(self.ui.Image_Money, currencyCfg.Icon)
end

function AlchemyCompositeConfirmView:_OnInitCostItemComp()
  for i = 1, MAX_CONSUME_NUM do
    local go = self.ui["Group_Item_Old" .. i]
    local alchemyItemData = self.model.curConsumeList[i]
    if not alchemyItemData or DT.Item[alchemyItemData.tid].Type == CommonDefine.ItemType.TopBarItem then
      go:SetActive(false)
    else
      local function clickCb()
        ItemDataUtils.ShowItemDetailTips(self.binder, go, nil, alchemyItemData.tid)
      end
      
      local viewData = {
        tid = alchemyItemData.tid,
        num = alchemyItemData.num,
        clickCb = clickCb,
        alchemyItemType = AlchemyDefine.AlchemyItemType.SecondConfirmItem
      }
      self:AddViewComponentOnce(go, CompAlchemyBaseItem, viewData)
    end
  end
end

function AlchemyCompositeConfirmView:_OnInitTargetItemComp()
  local viewData = {
    tid = self.curSelectTid,
    num = self.composeData.itemNum * self.model.curCompositeNum,
    clickCb = function()
      ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Group_Item_New1, nil, self.curSelectTid)
    end,
    alchemyItemType = AlchemyDefine.AlchemyItemType.SecondConfirmItem
  }
  self:AddViewComponentOnce(self.ui.Group_Item_New1, CompAlchemyBaseItem, viewData)
end

function AlchemyCompositeConfirmView:_OnInitPopTipsComp()
  local tipsTid = 20065
  local tipsConfig = DT.TipsType[tipsTid]
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnConfirmClick),
    text = tipsConfig.RightBtnDesc,
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.OnCancleClick),
    text = tipsConfig.LeftBtnDesc
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.M,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    maskClickFunc = self.cancelCb,
    textTitleCN = LT.Text(tipsConfig.Title)
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_Confirm_M, CompPublicPopupConfirmTips, commonPopupConfirmTipsData)
  local desc = tipsConfig.Desc
  local getString = ItemNumUtils.GetStr(self.curSelectTid, self.composeData.itemNum * self.model.curCompositeNum)
  local costString = ""
  for i = 1, MAX_CONSUME_NUM do
    local alchemyItemData = self.model.curConsumeList[i]
    if alchemyItemData and DT.Item[alchemyItemData.tid].Type ~= CommonDefine.ItemType.TopBarItem then
      costString = string.format("%s%s ,", costString, ItemNumUtils.GetStr(alchemyItemData.tid, alchemyItemData.num))
    end
  end
  costString = string.sub(costString, 1, -2)
  local stringLen = #string.format(desc, costString, getString)
  self.ui.Image_Line2:SetActive(stringLen >= 82)
  costString = LT.Text(costString)
  getString = LT.Text(getString)
  self:SetText(self.ui.Text_Tips, LT.Textf(desc, costString, getString))
end

function AlchemyCompositeConfirmView:_GetTextPay()
  if not self.currencyTid then
    return ""
  end
  local haveNum = ItemDataUtils.GetItemNum(self.currencyTid)
  local costNum = self.model.curCompositeCurrencyCostNum
  do return string.format, "%s/%s", haveNum end
  return string.format, "%s/%s", haveNum, costNum
end

function AlchemyCompositeConfirmView:OnConfirmClick()
  if self.confirmCb then
    self.confirmCb()
  end
  self:Close()
end

function AlchemyCompositeConfirmView:OnCancleClick()
  self:Close()
end

function AlchemyCompositeConfirmView:OnExitView()
  Super.OnExitView(self)
end

return AlchemyCompositeConfirmView
