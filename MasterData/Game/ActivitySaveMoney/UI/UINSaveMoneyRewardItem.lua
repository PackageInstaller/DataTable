local UINSaveMoneyRewardItem = class("UINSaveMoneyRewardItem", UIBaseNode)
local base = UIBaseNode
local ActivitySaveMoneyEnum = require("Game.ActivitySaveMoney.Enum.ActivitySaveMoneyEnum")
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local __InitRightNodeFuncs = {
  [ActivitySaveMoneyEnum.SaveMoneyStageState.lock] = function(self)
    self.ui.btn_Recive.gameObject:SetActive(false)
    self.ui.textItem_Recieve:SetIndex(3)
  end,
  [ActivitySaveMoneyEnum.SaveMoneyStageState.canGet] = function(self)
    self.ui.btn_Recive.gameObject:SetActive(true)
    self.ui.imgItem_Recive:SetIndex(0)
    self.ui.btn_Recive.interactable = true
    self.ui.textItem_Recieve:SetIndex(2)
  end,
  [ActivitySaveMoneyEnum.SaveMoneyStageState.gotten] = function(self)
    self.baseItemWithRecevied:SetPickedUIActive(true)
    self.ui.btn_Recive.gameObject:SetActive(true)
    self.ui.imgItem_Recive:SetIndex(1)
    self.ui.btn_Recive.interactable = false
    self.ui.textItem_Recieve:SetIndex(1)
  end,
  [ActivitySaveMoneyEnum.SaveMoneyStageState.expire] = function(self)
    self.baseItemWithRecevied:SetExpiredUIActive(true)
    self.ui.btn_Recive.gameObject:SetActive(true)
    self.ui.imgItem_Recive:SetIndex(1)
    self.ui.btn_Recive.interactable = false
    self.ui.textItem_Recieve:SetIndex(0)
  end
}

function UINSaveMoneyRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Recive, self, self.OnClickSaveMoneyReward)
end

function UINSaveMoneyRewardItem:InitSaveMoneyRewardItem(rewardCfg)
  self._rewardCfg = rewardCfg
  local saveMoneyController = ControllerManager:GetController(ControllerTypeId.ActivitySaveMoney)
  if saveMoneyController == nil then
    return
  end
  self._data = saveMoneyController:GetSaveMoneyDataByActId(self._rewardCfg.id)
  self.ui.tex_Stage.text = string.format("%02d", self._rewardCfg.stage)
  local startTime, endTime = self._data:GetSaveMoneyStageStartEndTime(self._rewardCfg.save_level, self._rewardCfg.stage)
  self.ui.tex_StartTime.text = startTime
  self.ui.tex_EndTime.text = endTime
  local state = self._data:GetSaveMoneyStageState(self._rewardCfg.stage)
  self.baseItemWithRecevied = UINBaseItemWithReceived.New()
  self.baseItemWithRecevied:Init(self.ui.uINBaseItemWithReceived)
  local itemCfg = ConfigData.item[self._rewardCfg.receive_rewards_ids[1]]
  local count = self._rewardCfg.receive_rewards_nums[1]
  self.baseItemWithRecevied:InitItemWithCount(itemCfg, count)
  self.state = state
  if __InitRightNodeFuncs[state] ~= nil then
    __InitRightNodeFuncs[state](self)
  end
  self:SetRewardItemTimeRemain()
end

function UINSaveMoneyRewardItem:SetRewardItemTimeRemain()
  if self.state == ActivitySaveMoneyEnum.SaveMoneyStageState.lock then
    self.baseItemWithRecevied.baseItem:SetCountDownTime(self._data:GetSaveMoneyCountDownTimeReward(self._rewardCfg.save_level, self._rewardCfg.stage, true))
  else
    self.baseItemWithRecevied.baseItem:SetCountDownTimeShow(false)
  end
end

function UINSaveMoneyRewardItem:OnClickSaveMoneyReward()
  if self._data == nil or self._data:GetSaveMoneyStageState(self._rewardCfg.stage) ~= ActivitySaveMoneyEnum.SaveMoneyStageState.canGet then
    return
  end
  local saveMoneyController = ControllerManager:GetController(ControllerTypeId.ActivitySaveMoney)
  if saveMoneyController == nil then
    return
  end
  saveMoneyController:ReqGetSaveMoneyReward(self._rewardCfg.id, self._rewardCfg.stage)
end

return UINSaveMoneyRewardItem
