local UINLogicPreviewRowBase = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewRowBase")
local UINWeeklyChallengeScoreIntroRowItem = class("UINWeeklyChallengeScoreIntroRowItem", UINLogicPreviewRowBase)
local base = UINLogicPreviewRowBase

function UINWeeklyChallengeScoreIntroRowItem:InitWeeklyRewardRow(scoreMin, scoreMax, cfg, showIndexs)
  self.attrPool:HideAll()
  local scoreStr
  if scoreMin ~= nil and scoreMax ~= nil then
    scoreStr = tostring(scoreMin) .. "~" .. tostring(scoreMax)
  elseif scoreMax == nil then
    scoreStr = ">" .. tostring(scoreMin)
  elseif scoreMin == nil then
    scoreStr = "<" .. tostring(scoreMax)
  end
  local item = self.attrPool:GetOne(true)
  item:InitAttrItem(scoreStr)
  for _, type_id in ipairs(showIndexs) do
    item = self.attrPool:GetOne(true)
    item:InitAttrItem(tostring(cfg[type_id].reward))
  end
end

return UINWeeklyChallengeScoreIntroRowItem
