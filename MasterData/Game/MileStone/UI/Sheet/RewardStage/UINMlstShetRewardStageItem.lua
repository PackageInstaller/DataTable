local base = UIBaseNode
local UINMlstShetRewardStageItem = class("UINMlstShetRewardStageItem", base)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINMlstShetRewardStageItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived, false)
end

function UINMlstShetRewardStageItem:InitMlstShetRewardStageItem(stageId, bandData)
  local isStageComplete = bandData:IsMlstBandStageComplete(stageId)
  self.ui.tex_Order.text = string.format("%02d", stageId)
  self.ui.tex_Order.color = isStageComplete and self.ui.color_state[1] or self.ui.color_state[2]
  local scoreList = bandData:GetMlstBandScoreList()
  self.ui.tex_Point.text = tostring(scoreList[stageId])
  self.ui.obj_Dot.color = isStageComplete and self.ui.color_state[1] or self.ui.color_state[2]
  local isLast = stageId >= #scoreList
  self.ui.obj_Line.gameObject:SetActive(not isLast)
  if not isLast then
    local nextStageComplete = bandData:IsMlstBandStageComplete(stageId + 1)
    self.ui.obj_Line.color = nextStageComplete and self.ui.color_state[1] or self.ui.color_state[2]
  end
  local rewardIds, rewardNums = bandData:GetMlstBandReawrd(stageId)
  self._rewardPool:HideAll()
  for k, itemId in ipairs(rewardIds) do
    local itemNum = rewardNums[k]
    local itemCfg = ConfigData.item[itemId]
    local rewardItem = self._rewardPool:GetOne()
    rewardItem:InitItemWithCount(itemCfg, itemNum, nil, isStageComplete)
    rewardItem:SetNotNeedAnyJump(true)
  end
end

function UINMlstShetRewardStageItem:OnDelete()
  base.OnDelete(self)
end

return UINMlstShetRewardStageItem
