local UINActivityStarUpPreItem = class("UINActivityStarUpPreItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINActivityStarUpPreItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.rewardItem:SetActive(false)
  self.rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem)
end

function UINActivityStarUpPreItem:InitItem(activityInfo, stageId)
  local stageState
  if activityInfo:IsFinish() or stageId < activityInfo.curStageId then
    stageState = 0
  elseif stageId > activityInfo.curStageId then
    stageState = 1
  else
    stageState = 2
  end
  self.ui.img_stageItem:SetIndex(stageState)
  self.ui.tex_State:SetIndex(stageState)
  self.ui.tex_Stage:SetIndex(stageState, LanguageUtil.GetLocaleText(activityInfo.cfg.phase[stageId].name))
  self.rewardPool:HideAll()
  local taskCfg = activityInfo:GetTasks(stageId, true).stcData
  for i, v in ipairs(taskCfg.rewardIds) do
    local item = self.rewardPool:GetOne(true)
    local itemCfg = ConfigData.item[v]
    local num = taskCfg.rewardNums[i]
    item:InitItemWithCount(itemCfg, num, nil, stageState == 0)
  end
end

return UINActivityStarUpPreItem
