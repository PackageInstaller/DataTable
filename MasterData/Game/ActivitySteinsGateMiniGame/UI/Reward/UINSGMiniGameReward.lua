local UINSGMiniGameReward = class("UINSGMiniGameReward", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UINSGMiniGameReward:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_canPick, self, self.OnClickCanPick)
  self.baseItem = UINBaseItem.New()
  self.baseItem:Init(self.ui.obj_BaseItem)
end

function UINSGMiniGameReward:InitSGMiniGameReward(actData)
  self.actData = actData
  local rewardId = actData:GetRewardItemId()
  local itemCfg = ConfigData.item[rewardId]
  self.baseItem:InitBaseItem(itemCfg)
  local taskData = actData:GetRewardTaskData()
  local isPicked = taskData:IsPickedTaskReward()
  local isComplete = taskData:CheckComplete()
  self.ui.btn_canPick.gameObject:SetActive(isComplete and not isPicked)
  self.ui.obj_picked:SetActive(isPicked)
  self.ui.tex_Des.text = taskData:GetTaskFirstStepIntro()
end

function UINSGMiniGameReward:OnClickCanPick()
  self.actData:FinishMashUpTask()
end

function UINSGMiniGameReward:OnDelete()
end

return UINSGMiniGameReward
