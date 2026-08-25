local ActivitySpringSevenDaySignItem, Super = System.NewComponent("ActivitySpringSevenDaySignItem")

function ActivitySpringSevenDaySignItem:ctor(gameObject, viewData)
  Super.ctor(self)
  self.ui = UI_Event_Item_SignDayResource(gameObject)
  self.awardList = viewData.awardList
  self.awardState = viewData.awardState
  self.idx = viewData.idx
  self.activityTid = viewData.activityTid
  self.dontShowName = viewData.dontShowName
end

function ActivitySpringSevenDaySignItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self._OnClick))
  binder:BindButtonClick(self.ui.Btn_Item1, System.fn(self, self._OnClickItem1))
  binder:BindButtonClick(self.ui.Btn_Item2, System.fn(self, self._OnClickItem2))
  self:_RefreshState()
  self:_RefreshBaseInfo()
end

function ActivitySpringSevenDaySignItem:_RefreshState()
  local state = self.awardState
  local canReceive = self:_CheckCanReceive()
  self.ui.Group_Got:SetActive(state == CommonDefine.TaskState.Done)
  self.ui.Text_Nor:SetActive(state ~= CommonDefine.TaskState.Done and not canReceive and not self.dontShowName)
  self.ui.Group_CanReceive:SetActive(canReceive)
  self.ui.Btn_Click:SetActive(canReceive)
  self.ui.Com_RedDot:SetActive(canReceive)
end

function ActivitySpringSevenDaySignItem:_RefreshBaseInfo()
  if self.awardList then
    self:_RefreshRewardItem(self.awardList[1], self.awardList[2], self.ui.Icon_Item, self.ui.Text_Name, self.ui.Text_Number)
    self:_RefreshRewardItem(self.awardList[3], self.awardList[4], self.ui.Icon_Item2, self.ui.Text_Name2, self.ui.Text_Number2)
  end
  self.binder:SetText(self.ui.Text_Nor, LT.Textf("ActivityRewardday", self.idx))
  self.binder:SetText(self.ui.Text_Day, LT.Text(string.format("%02d", self.idx)))
end

function ActivitySpringSevenDaySignItem:_RefreshRewardItem(rewardTid, rewardNum, iconNode, txtNameNode, txtNumNode)
  if not rewardTid or not rewardNum then
    iconNode:SetActive(false)
    txtNameNode:SetActive(false)
    txtNumNode:SetActive(false)
    return
  end
  iconNode:SetActive(true)
  self.binder:SetImage(iconNode, ItemDataUtils.GetItemIcon(rewardTid))
  txtNameNode:SetActive(not self.dontShowName)
  if not self.dontShowName then
    self.binder:SetText(txtNameNode, LT.Text(ItemDataUtils.GetItemName(rewardTid)))
  end
  local subType = ItemCfgUtils.GetCfgField("SubType", rewardTid)
  if subType == CommonDefine.ItemSubType.PlayerAvatar then
    txtNumNode:SetActive(false)
  else
    txtNumNode:SetActive(true)
    self.binder:SetText(txtNumNode, LT.Text("x" .. rewardNum))
  end
end

function ActivitySpringSevenDaySignItem:_OnClick()
  ActivityDataUtils.ReqGainAward(self.activityTid, self.idx, {}, function()
    self.awardState = CommonDefine.TaskState.Done
    self:_RefreshState()
  end)
end

function ActivitySpringSevenDaySignItem:_OnClickItem1()
  local itemTid = self.awardList[1]
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Icon_Item, nil, itemTid)
end

function ActivitySpringSevenDaySignItem:_OnClickItem2()
  local itemTid = self.awardList[3]
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Icon_Item2, nil, itemTid)
end

function ActivitySpringSevenDaySignItem:_CheckCanReceive()
  return self.awardState == CommonDefine.TaskState.Receive
end

return ActivitySpringSevenDaySignItem
