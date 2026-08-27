local base = UIBaseNode
local UINMltsSheetLeftStageItem = class("UINMltsSheetLeftStageItem", base)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local MilestoneUtil = require("Game.MileStone.MilestoneUtil")

function UINMltsSheetLeftStageItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived, false)
end

function UINMltsSheetLeftStageItem:InitMltsSheetLeftStageItem(moduleId, stageId, isPicked)
  self.ui.obj_Clear:SetActive(isPicked)
  local rewardCfg = ConfigData.milestones_module_reward[moduleId] and ConfigData.milestones_module_reward[moduleId][stageId]
  if rewardCfg == nil then
    error(string.format("Cant get milestones_module_reward cfg, moduleId:%s, stageId:%s", moduleId, stageId))
    return
  end
  self.ui.Tex_Stage.text = tostring(MilestoneUtil.GetSPSStageId2EngChar(stageId))
  self.ui.Tex_Point.text = tostring(rewardCfg.score)
  self.itemPool:HideAll()
  for itemId, itemNum in pairs(rewardCfg.reward) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("cant get item cfg, itemId:" .. tostring(itemId))
      return
    end
    local item = self.itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemNum, nil, isPicked)
  end
end

function UINMltsSheetLeftStageItem:OnDelete()
  base.OnDelete(self)
end

return UINMltsSheetLeftStageItem
