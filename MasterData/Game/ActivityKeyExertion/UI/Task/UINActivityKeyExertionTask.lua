local UINActivityKeyExertionTask = class("UINActivityKeyExertionTask", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local CS_DOTweenAnimation = CS.DG.Tweening.DOTweenAnimation
local cs_Ease = CS.DG.Tweening.Ease

function UINActivityKeyExertionTask:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Receive, self, self.OnClickConfirm)
end

function UINActivityKeyExertionTask:InitActivityKeyExertionTask(keyExertionData, rewardFunc)
  self._data = keyExertionData
  self._taskId = keyExertionData:GetKeyExertionCurrentTaskId()
  self._taskData = PlayerDataCenter.allTaskData:GetTaskDataById(self._taskId, true)
  self._rewardFunc = rewardFunc
  self.ui.tex_Tip.text = LanguageUtil.GetLocaleText(self._taskData.stcData.task_intro)
  local firstRewardIds, _ = self._taskData:GetTaskCfgRewards()
  local firstRewardCfg = ConfigData.item[firstRewardIds[1]]
  local itemName = LanguageUtil.GetLocaleText(firstRewardCfg.name)
  self.ui.img_Reward.sprite = CRH:GetSpriteByItemId(firstRewardCfg.id)
  self.ui.tex_Name.text = itemName
  local mainColor = self._data:GetKeyExertionMainColor()
  self.ui.img_Fill.color = mainColor
  self.ui.img_Receive.color = mainColor
  self:RefreshKeyExertionTask()
end

function UINActivityKeyExertionTask:GetActivityKeyExertionId()
  return self._taskId
end

function UINActivityKeyExertionTask:RefreshKeyExertionTask()
  local schedule, aim = self._taskData:GetTaskProcess()
  self.ui.slider.value = schedule / aim
  self.ui.tex_Count.text = tostring(schedule) .. "/" .. tostring(aim)
  if not self._taskData.isPicked then
    local isComplete = self._taskData:CheckComplete()
    self.ui.btn_Receive.gameObject:SetActive(isComplete)
    self.ui.current:SetActive(not isComplete)
    self.ui.received:SetActive(false)
  else
    self.ui.btn_Receive.gameObject:SetActive(false)
    self.ui.current:SetActive(false)
    self.ui.received:SetActive(true)
  end
end

function UINActivityKeyExertionTask:RefreshKeyExertionTaskPicked()
  self._taskData = PlayerDataCenter.allTaskData:GetTaskDataById(self._taskId, true)
  self:RefreshKeyExertionTask()
end

function UINActivityKeyExertionTask:OnClickConfirm()
  if self._taskData:CheckComplete() and self._rewardFunc ~= nil then
    self._rewardFunc(self._taskData, self)
  end
end

return UINActivityKeyExertionTask
