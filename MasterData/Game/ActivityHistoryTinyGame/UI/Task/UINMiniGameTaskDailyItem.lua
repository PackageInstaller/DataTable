local UINMiniGameTaskDailyItem = class("UINMiniGameTaskDailyItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local TaskEnum = require("Game.Task.TaskEnum")

function UINMiniGameTaskDailyItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Receive, self, self.OnClickReview)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.OnClickRefresh)
  self._rewardPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
  self.ui.uINBaseItemWithCount:SetActive(false)
  self._normalColor = self.ui.bottom.color
end

function UINMiniGameTaskDailyItem:InitMiniGameTaskDailyItem(actTinyData, taskData, isDaily, callback, refreshcallback)
  self._actTinyData = actTinyData
  self._taskData = taskData
  self._callback = callback
  self._refreshcallback = refreshcallback
  self._isDaily = isDaily
  self.ui.tex_Details.text = taskData:GetTaskFirstStepIntro()
  local rewardIds, rewardNums = taskData:GetTaskCfgRewards()
  self._rewardPool:HideAll()
  for i, id in ipairs(rewardIds) do
    local count = rewardNums[i]
    local itemCfg = ConfigData.item[id]
    local item = self._rewardPool:GetOne()
    item:InitItemWithCount(itemCfg, count)
  end
  self:RefreshMiniGameTaskDailyItem()
end

function UINMiniGameTaskDailyItem:RefreshMiniGameTaskDailyItem()
  local schedule, aim = self._taskData:GetTaskProcess()
  self.ui.tex_Progress:SetIndex(0, tostring(schedule), tostring(aim))
  self.ui.slider.value = schedule / aim
  local isFinish = self._taskData.state == TaskEnum.eTaskState.Picked
  if isFinish then
    self.ui.img_Background.color = self.ui.color_hasReview
    self.ui.btn_Refresh.gameObject:SetActive(false)
    self.ui.btn_Receive.gameObject:SetActive(false)
    self.ui.finished:SetActive(true)
    self.ui.taskItem.alpha = 0.7
    self.ui.mission.color = Color.white
    self.ui.tex_Progress.text.color = Color.white
    self.ui.tex_Details.color = Color.white
    self.ui.fill.color = Color.white
    return
  end
  self.ui.taskItem.alpha = 1
  local isCanjump = self._taskData.stcData.jump_id ~= nil and 0 < self._taskData.stcData.jump_id
  local isComplete = self._taskData:CheckComplete()
  self.ui.btn_Refresh.gameObject:SetActive(self._isDaily)
  self.ui.finished:SetActive(false)
  self.ui.btn_Receive.gameObject:SetActive(isComplete or isCanjump)
  self.ui.receive:SetIndex(isComplete and 0 or 1)
  if isComplete then
    self.ui.bottom.color = self._normalColor
    self.ui.receive.text.color = Color.white
    self.ui.img_Background.color = Color.white
    self.ui.mission.color = self.ui.color_block_text
    self.ui.tex_Progress.text.color = self.ui.color_block_text
    self.ui.tex_Details.color = self.ui.color_block_text
    self.ui.fill.color = self._normalColor
  else
    self.ui.bottom.color = Color.white
    self.ui.receive.text.color = self.ui.color_block_text
    self.ui.img_Background.color = self.ui.color_hasReview
    self.ui.mission.color = Color.white
    self.ui.tex_Progress.text.color = Color.white
    self.ui.tex_Details.color = Color.white
    self.ui.fill.color = Color.white
  end
end

function UINMiniGameTaskDailyItem:OnClickReview()
  if self._callback ~= nil then
    self._callback(self._taskData)
  end
end

function UINMiniGameTaskDailyItem:OnClickRefresh()
  if self._refreshcallback ~= nil then
    self._refreshcallback(self._taskData)
  end
end

return UINMiniGameTaskDailyItem
