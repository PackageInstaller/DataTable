local base = UIBaseNode
local UINMlstShetTaskListItem = class("UINMlstShetTaskListItem", base)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINMlstShetTaskListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Receive, self, self._OnClickCompleteTask)
  self._rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived, false)
end

function UINMlstShetTaskListItem:InitMlstShetTaskListItem(taskData, scoreItemId, pickRewardFunc)
  self._pickRewardFunc = pickRewardFunc
  self._taskData = taskData
  self.ui.canvas_taskItem.alpha = 1
  self.ui.obj_Receive:SetActive(false)
  self.ui.tex_Title.text = taskData:GetTaskName()
  local schedule, aim = taskData:GetTaskProcess()
  self.ui.tex_Progress:SetIndex(0, tostring(schedule), tostring(aim))
  self.ui.tex_Des.text = taskData:GetTaskFirstStepIntro()
  local isPickedReward = taskData:IsPickedTaskReward()
  if isPickedReward then
    self.ui.obj_State:SetActive(true)
    self.ui.tex_StateEn:SetIndex(1)
    self.ui.tex_State:SetIndex(1)
    self.ui.canvas_taskItem.alpha = 0.5
  elseif taskData:CheckComplete() then
    self.ui.obj_State:SetActive(false)
    self.ui.obj_Receive:SetActive(true)
  else
    self.ui.obj_State:SetActive(true)
    self.ui.tex_StateEn:SetIndex(0)
    self.ui.tex_State:SetIndex(0)
  end
  local rewardIds, rewardNums = taskData:GetTaskCfgRewards()
  local score = 0
  self._rewardPool:HideAll()
  for k, itemId in ipairs(rewardIds) do
    local itemNum = rewardNums[k]
    if itemId == scoreItemId then
      score = itemNum
    else
      local rewardItem = self._rewardPool:GetOne()
      local itemCfg = ConfigData.item[itemId]
      rewardItem:InitItemWithCount(itemCfg, itemNum, nil, isPickedReward)
      rewardItem:SetNotNeedAnyJump(true)
    end
  end
  self.ui.tex_Point:SetIndex(0, tostring(score))
end

function UINMlstShetTaskListItem:_OnClickCompleteTask()
  if self._pickRewardFunc ~= nil then
    self._pickRewardFunc(self._taskData)
  end
end

function UINMlstShetTaskListItem:OnDelete()
  self._rewardPool:DeleteAll()
  base.OnDelete(self)
end

return UINMlstShetTaskListItem
