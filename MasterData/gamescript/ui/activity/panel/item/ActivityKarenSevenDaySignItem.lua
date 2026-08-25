local ActivityKarenSevenDaySignItem, Super = System.NewComponent("ActivityKarenSevenDaySignItem")

function ActivityKarenSevenDaySignItem:ctor(gameObject, viewData)
  Super.ctor(self)
  self.ui = UI_Event_Item_SignDayResource(gameObject)
  self.taskData = viewData.taskData
  self.idx = viewData.idx
  self.activityTid = viewData.activityTid
end

function ActivityKarenSevenDaySignItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self._OnClick))
  binder:BindButtonClick(self.ui.Btn_Item1, System.fn(self, self._OnClickItem1))
  binder:BindButtonClick(self.ui.Btn_Item2, System.fn(self, self._OnClickItem2))
  self:_RefreshState()
  self:_RefreshBaseInfo()
end

function ActivityKarenSevenDaySignItem:_RefreshState()
  local state = self.taskData.state
  self.ui.Group_Got:SetActive(state == CommonDefine.TaskState.Done)
  self.ui.Text_Nor:SetActive(state ~= CommonDefine.TaskState.Done)
  self.ui.Group_CanReceive:SetActive(self:_CheckCanReceive())
  self.ui.Btn_Click:SetActive(self:_CheckCanReceive())
  self.ui.Com_RedDot:SetActive(self:_CheckCanReceive())
end

function ActivityKarenSevenDaySignItem:_RefreshBaseInfo()
  local taskCfg = TaskCfgUtils.GetCfg(self.taskData.tid)
  if taskCfg.CompleteAward then
    self:_RefreshRewardItem(taskCfg.CompleteAward[1], taskCfg.CompleteAward[2], self.ui.Icon_Item, self.ui.Text_Name, self.ui.Text_Number)
    self:_RefreshRewardItem(taskCfg.CompleteAward[3], taskCfg.CompleteAward[4], self.ui.Icon_Item2, self.ui.Text_Name2, self.ui.Text_Number2)
  end
  self.binder:SetText(self.ui.Text_Nor, LT.Textf("ActivityRewardday", self.idx))
  self.binder:SetText(self.ui.Text_Day, LT.Text(string.format("%02d", self.idx)))
end

function ActivityKarenSevenDaySignItem:_RefreshRewardItem(rewardTid, rewardNum, iconNode, txtNameNode, txtNumNode)
  if not rewardTid or not rewardNum then
    iconNode:SetActive(false)
    txtNameNode:SetActive(false)
    txtNumNode:SetActive(false)
    return
  end
  iconNode:SetActive(true)
  txtNameNode:SetActive(true)
  self.binder:SetImage(iconNode, ItemDataUtils.GetItemIcon(rewardTid))
  self.binder:SetText(txtNameNode, LT.Text(ItemDataUtils.GetItemName(rewardTid)))
  local subType = ItemCfgUtils.GetCfgField("SubType", rewardTid)
  if subType == CommonDefine.ItemSubType.PlayerAvatar then
    txtNumNode:SetActive(false)
  else
    txtNumNode:SetActive(true)
    self.binder:SetText(txtNumNode, LT.Text("x" .. rewardNum))
  end
end

function ActivityKarenSevenDaySignItem:_OnClick()
  if not self:_CheckCanReceive() then
    return
  end
  ActivityDataUtils.ReqGainAward(self.activityTid, self.taskData.tid, nil, function()
    self.taskData.state = CommonDefine.TaskState.Done
    self:_RefreshState()
  end)
end

function ActivityKarenSevenDaySignItem:_OnClickItem1()
  local taskCfg = TaskCfgUtils.GetCfg(self.taskData.tid)
  local itemTid = taskCfg.CompleteAward[1]
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Icon_Item, nil, itemTid)
end

function ActivityKarenSevenDaySignItem:_OnClickItem2()
  local taskCfg = TaskCfgUtils.GetCfg(self.taskData.tid)
  local itemTid = taskCfg.CompleteAward[3]
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Icon_Item2, nil, itemTid)
end

function ActivityKarenSevenDaySignItem:_CheckCanReceive()
  return self.taskData.state == CommonDefine.TaskState.Receive
end

return ActivityKarenSevenDaySignItem
