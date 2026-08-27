local base = UIBaseNode
local UINCardSetMERewardTaskItemNode = class("UINCardSetMERewardTaskItemNode", base)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local color_orange = Color.New(1.0, 0.4196078431372549, 0.06274509803921569)
local color_gray = Color.New(0.5058823529411764, 0.5058823529411764, 0.5058823529411764)
local color_des_normal = Color.New(1, 1, 1, 0.9019607843137255)
local color_des_picked = Color.New(1, 1, 1, 0.3607843137254902)

function UINCardSetMERewardTaskItemNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Get, self, self.__OnClick)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem, false)
  self._emptyItemPool = UIItemPool.New(UIBaseNode, self.ui.emptyItem, false)
end

function UINCardSetMERewardTaskItemNode:RefreshCSMERTaskItem(taskData, callback)
  self._taskData = taskData
  self._callback = callback
  self.ui.tex_TaskDes.text = self._taskData:GetTaskFirstStepIntro()
  self._itemPool:HideAll()
  local isPicked = self._taskData:IsPickedTaskReward()
  local itemids, itemnums = self._taskData:GetTaskCfgRewards()
  for i, itemId in ipairs(itemids) do
    local itemNum = itemnums[i]
    local itemCfg = ConfigData.item[itemId]
    local item = self._itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemNum, nil, isPicked)
  end
  self._emptyItemPool:HideAll()
  for i = #itemids + 1, 3 do
    self._emptyItemPool:GetOne()
  end
  self:__RefreshProcess()
end

function UINCardSetMERewardTaskItemNode:__RefreshProcess()
  local schedule, aim = self._taskData:GetTaskProcess()
  self.ui.processSlider.value = schedule / aim
  local isPicked = self._taskData:IsPickedTaskReward()
  self.ui.btn_Received.gameObject:SetActive(isPicked)
  local isComplete = self._taskData:CheckComplete()
  self.ui.btn_Get.gameObject:SetActive(isComplete)
  self.ui.btn_UnClear.gameObject:SetActive(not isPicked and not isComplete)
  self.ui.notPickBg:SetActive(not isPicked)
  self.ui.pickedBg:SetActive(isPicked)
  if isPicked then
    self.ui.tex_MissionDeco.color = color_gray
    self.ui.tex_TaskDes.color = color_des_picked
    self.ui.img_Fill.color = color_gray
    for _, emptyItem in ipairs(self._emptyItemPool.listItem) do
      emptyItem.transform:GetComponent(typeof(CS.UiImageItemInfo)):SetIndex(1)
    end
    self.ui.tex_Progress:SetIndex(1, tostring(schedule), tostring(aim))
  else
    self.ui.tex_MissionDeco.color = color_orange
    self.ui.tex_TaskDes.color = color_des_normal
    self.ui.img_Fill.color = color_orange
    for _, emptyItem in ipairs(self._emptyItemPool.listItem) do
      emptyItem.transform:GetComponent(typeof(CS.UiImageItemInfo)):SetIndex(0)
    end
    self.ui.tex_Progress:SetIndex(0, tostring(schedule), tostring(aim))
  end
end

function UINCardSetMERewardTaskItemNode:__OnClick()
  if self._callback ~= nil then
    self._callback(self._taskData)
  end
end

return UINCardSetMERewardTaskItemNode
