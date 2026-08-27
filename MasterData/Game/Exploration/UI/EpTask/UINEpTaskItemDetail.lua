local UINEpTaskItemDetail = class("UINEpTaskItemDetail", UIBaseNode)
local base = UIBaseNode

function UINEpTaskItemDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Get, self, self.OnClickGetBtn)
end

function UINEpTaskItemDetail:InitTaskItem(taskData, callback, stateId)
  self.callback = callback
  self.taskData = taskData
  self:RefreshTaskUI(stateId)
end

function UINEpTaskItemDetail:RefreshTaskUI(stateId)
  self.ui.btn_text:SetIndex(stateId or 0)
  self.ui.tex_taskName.text = LanguageUtil.GetLocaleText(self.taskData:GetTaskName())
  self.ui.tex_Content.text = LanguageUtil.GetLocaleText(self.taskData:GetTaskFirstStepIntro())
  if self.taskData.stcData.rewardIds == nil or #self.taskData.stcData.rewardIds == 0 then
    self.ui.reward:SetActive(false)
  else
    self.ui.reward:SetActive(true)
    local rewardId = self.taskData.stcData.rewardIds[1]
    local rewardCount = self.taskData.stcData.rewardNums[1]
    self.ui.tex_Reward.text = "x" .. tostring(rewardCount)
    local itemCfg = ConfigData.item[rewardId]
    self.ui.img_Reward.sprite = CRH:GetSpriteByItemConfig(itemCfg)
  end
  local quality = self.taskData:GetQuality()
  local color = ItemQualityColor[quality]
  if color == nil then
    color = ItemQualityColor[eItemQualityType.Orange]
  end
  self.ui.img_Quality.color = color
  self.ui.img_Col.color = color
end

function UINEpTaskItemDetail:OnClickGetBtn()
  if self.callback ~= nil then
    self.callback(self.taskData.id)
  end
end

return UINEpTaskItemDetail
