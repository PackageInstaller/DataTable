local WU, DB, REF = require("Common/WindowUtil")(this)
local TPU = require("Common/TopPvpUtil")
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local m_displacementX = 0

function SetData(seg, mode, conditionText)
  WU.SetActive(REF.LabelCurGrade, fif(mode == 0, true, false))
  local spriteLeftName = "level_bg_me"
  if mode == 1 then
    spriteLeftName = "level_bg_up"
  elseif mode == 2 then
    spriteLeftName = "level_bg_keep"
  elseif mode == 3 then
    spriteLeftName = "level_bg_down"
  end
  REF.SpriteLeft.UISprite.spriteName = spriteLeftName
  REF.SpriteClass.UISprite.spriteName = "icon_" .. seg.segRank
  REF.SpriteRank.UISprite.spriteName = "illusion_level_" .. seg.segRank
  REF.SpriteRankLevel.UISprite.spriteName = "level_" .. seg.subSegRank
  REF.LabelCondition.UIHtmlLabel.text = conditionText
  local rewards = REF.Rewards
  local activeCount = #seg.weekRewards
  local isDynamicSet = activeCount < #rewards
  if isDynamicSet then
    local oldPos = rewards.transform.localPosition
    local newX = oldPos.x - m_displacementX
    local startX = rewards[0].root.transform.localPosition.x
    local endX = rewards[#rewards - 1].root.transform.localPosition.x
    m_displacementX = (endX - startX) / 2 / activeCount
    rewards.transform.localPosition = CS.UnityEngine.Vector3(newX + m_displacementX, oldPos.y, oldPos.z)
  end
  WU.TraverseChildren(rewards, function(go, index)
    local ref = _ENV["$"](go)
    local trueIndex = index + 1
    local reward = seg.weekRewards[trueIndex]
    WU.SetActive(ref["$"], reward ~= nil)
    if reward ~= nil then
      ref["$$SetData"](reward.type, reward.id, reward.count)
    end
  end)
end
