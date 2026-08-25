local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local ONEPAGEMAXSHOWNUM = 6
local BpExchangeLevelView, Super = NewClass("BpExchangeLevelView", BaseView)
BpExchangeLevelView.uiResCls = UI_Passport_Exchange_NewResource

function BpExchangeLevelView:ctor()
  Super.ctor(self)
  self.model = BpExchangeLevelModel.Instance
  self.model:OnInit()
end

function BpExchangeLevelView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnBpExchangeLevelChangeBuyNum, self._RefreshView, self)
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self._OnBagItemDataChanged, self)
end

function BpExchangeLevelView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click_Add, System.fn(self, self.OnClickAdd))
  self:AddButtonClickListener(self.ui.Btn_Click_Sub, System.fn(self, self.OnClickSub))
  self:AddInputValueChangeListener(self.ui.InputField_Account, System.fn(self, self._OnListInputValueChange))
  self:_InitRewardListView()
end

function BpExchangeLevelView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshView()
  self:AddViewComponent(self.ui.Group_Coin, UICompCommonCurrencyGroupItem, {
    CommonDefine.CurrencyType.SeniorMoney
  }, true)
  self:_OnInitConfirmTipsComp()
  self:SetImage(self.ui.Image_Cost_Currency, ItemDataUtils.GetIcon(self.model.costItemTid))
end

function BpExchangeLevelView:_RefreshView()
  self.model:OnReset()
  self:SetText(self.ui.Text_Prompt, self:_GetPromptText())
  self:SetText(self.ui.Text_Cost_Num, self:_GetCostNumText())
  self:SetInputText(self.ui.InputField_Account, self.model.curBuyNum)
  local isOverOnePage = #self.model.showRewardList > ONEPAGEMAXSHOWNUM
  self:SetActive(self.ui.ScrollView_Reward, isOverOnePage)
  self:SetActive(self.ui.ScrollView_Reward_Middle, not isOverOnePage)
  self:SetActive(self.ui.Group_Buy, true)
  if isOverOnePage then
    self.rewardListView:ReloadData()
  else
    self:_RefreshRewardList()
  end
end

function BpExchangeLevelView:_RefreshRewardList()
  for i = 1, ONEPAGEMAXSHOWNUM do
    local rewardData = self.model.showRewardList[i]
    local itemObj = self.ui["Reward_" .. i]
    self:SetActive(itemObj, rewardData)
    if rewardData then
      local viewData = {
        itemTid = rewardData.tid,
        itemCount = rewardData.num
      }
      self:AddViewComponentOnce(itemObj, CompPublicIconItemType2, viewData)
    end
  end
end

function BpExchangeLevelView:_OnInitConfirmTipsComp()
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnClickConfirm),
    text = LT.Text("Shop_Buy_Btn"),
    stateFunc = function()
      local costNum = self.model.curCostCurrencyNum
      local haveNum = ItemDataUtils.GetItemNum(self.model.costItemTid)
      return costNum > haveNum and CommonDefine.BtnType.Unclickable or CommonDefine.BtnType.High
    end
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.OnClickCancel)
  }
  local viewData = {
    sizeType = CommonDefine.ConfirmTipsType.M,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_Confirm_M, CompPublicPopupConfirmTips, viewData)
end

function BpExchangeLevelView:_InitRewardListView()
  local cellRT = self.ui.Reward:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.rewardListView = self:CreateTableview(self.ui.ScrollView_Reward, function()
    if not self.model.showRewardList then
      return 0
    end
    return #self.model.showRewardList
  end, function(view, index)
    do return self._RewardTabCellAtIndex, self, view end
    return self._RewardTabCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
end

function BpExchangeLevelView:_RewardTabCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.Reward)
  local rewardData = self.model.showRewardList[index]
  local viewData = {
    itemTid = rewardData.tid,
    itemCount = rewardData.num
  }
  self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, viewData)
  return cell
end

function BpExchangeLevelView:_OnListInputValueChange()
  local newVal = tonumber(self:GetInputText(self.ui.InputField_Account)) or 0
  self.model:UpdateBuyNum(newVal)
  self:SetInputText(self.ui.InputField_Account, self.model.curBuyNum)
end

function BpExchangeLevelView:OnClickConfirm()
  local tipsCfg = DT.TipsType[20082]
  Alert.Show(20082, nil, function()
    local own = ItemDataUtils.GetItemNum(self.model.costItemTid)
    local cost = self.model.curCostCurrencyNum
    if own < cost then
      DiamondShopDataUtils.RechargeTips(cost - own)
      return
    end
    BattlePassDataUtils.BuyBpLevel(self.model.curBuyNum, function()
      BpModel.Instance:SetShowLevel(BattlePassDataUtils.GetLevel() + self.model.curBuyNum)
      BattlePassDataUtils.OpenLevelUpTips(BpModel.Instance.showLevel)
      self:Close()
    end)
  end, tipsCfg.Title, LT.Textf(tipsCfg.Desc, self.model.curCostCurrencyNum, self.model.curBuyNum))
  local costData = {
    tid = self.model.costItemTid,
    num = self.model.curCostCurrencyNum
  }
  Alert.ShowCoin({
    self.model.costItemTid
  }, true, costData)
end

function BpExchangeLevelView:_GetPromptText()
  do return string.format, (LT.Text("BPBuyLevelTxt")) end
  return string.format, LT.Text("BPBuyLevelTxt"), self.model.curBuyNum + BattlePassDataUtils.GetLevel(), (BattlePassDataUtils.GetLevel())
end

function BpExchangeLevelView:_GetCostNumText()
  local costNum = self.model.curCostCurrencyNum
  local haveNum = ItemDataUtils.GetItemNum(self.model.costItemTid)
  local rst = LT.Text(string.format("%s/%s", haveNum, costNum))
  if costNum > haveNum then
    rst = LT.Text(string.format("<color=#FA3A50>%s</color>/%s", haveNum, costNum))
  end
  return rst
end

function BpExchangeLevelView:OnClickAdd()
  self.model:UpdateBuyNum(self.model.curBuyNum + self.model.changeNumPerClick)
end

function BpExchangeLevelView:OnClickSub()
  self.model:UpdateBuyNum(self.model.curBuyNum - self.model.changeNumPerClick)
end

function BpExchangeLevelView:OnClickCancel()
  self:Close()
end

function BpExchangeLevelView:OnEnterViewFinished()
end

function BpExchangeLevelView:OnExitView()
  Super.OnExitView(self)
end

function BpExchangeLevelView:_OnBagItemDataChanged(uid, tid)
  if self.model and self.model.costItemTid == tid then
    self:_RefreshView()
  end
end

return BpExchangeLevelView
