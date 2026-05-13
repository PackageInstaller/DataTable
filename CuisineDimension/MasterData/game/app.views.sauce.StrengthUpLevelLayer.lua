local BreakCsv = require("csvdata.sauce_break")
local uiData = {
  csbFile = "ui/kitchen/StrengthUpLevelLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {popAction = "popAction", node = "node"}
}
local StrengthUpLevelLayer = class("StrengthUpLevelLayer", UIBase)

function StrengthUpLevelLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function StrengthUpLevelLayer:init(params)
end

function StrengthUpLevelLayer:showData(params)
  local attrsN = {
    "breaklv",
    "damageup",
    "shieldup"
  }
  local attrsNDesc = {
    "突破等级:",
    "造成的全伤害提高:",
    "受到的全伤害降低:"
  }
  local attrsE = {
    "extradamageup",
    "extrashieldup",
    "speciallv",
    "blocklv",
    "damage1",
    "shield1",
    "damage2",
    "shield2",
    "damage3",
    "shield3"
  }
  local attrsEDesc = {
    "造成的全伤害增加:%0.1f%%",
    "受到的全伤害降低:%0.1f%%",
    "料理技等级+%d",
    "固有技等级+%d",
    "对魔法属性敌人造成的伤害提高%0.1f%%",
    "受到魔法属性敌人的伤害降低%0.1f%%",
    "对物理属性敌人造成的伤害提高%0.1f%%",
    "受到物理属性敌人的伤害降低%0.1f%%",
    "对异能属性敌人造成的伤害提高%0.1f%%",
    "受到异能属性敌人的伤害降低%0.1f%%"
  }
  local sauce = game.role.sauces[params.id]
  local old = BreakCsv[sauce.type][params.old]
  local new = BreakCsv[sauce.type][sauce.breakL]
  if params.old < globalCsv.specialSauceBreak and sauce.breakL >= globalCsv.specialSauceBreak then
    local counterType = {
      [1] = "damage",
      [2] = "shield"
    }
    for _, one in pairs(sauce.csvData.counter:toArray()) do
      local temp = one:toArray("=", true)
      new[counterType[temp[2]] .. temp[1]] = (new[counterType[temp[2]] .. temp[1]] or 0) + temp[3]
    end
  end
  local extra = {}
  for idx, attr in ipairs(attrsE) do
    if (new[attr] or 0) > (old[attr] or 0) then
      extra[idx] = attr
    end
  end
  local list = ccui.ListView:create()
  list:size(cc.size(500, 142))
  list:setInnerContainerSize(cc.size(500, 142))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0, 0):pos(-127, -115):addTo(self.node)
  for idx, attr in ipairs(attrsN) do
    if (old[attr] or 0) < (new[attr] or 0) then
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(cc.size(500, 26)):addTo(list)
      display.newTTFLabel({
        text = attrsNDesc[idx],
        size = 18,
        color = UIHelper.hex2rgb("#713802")
      }):anch(0, 0.5):pos(80, 13):addTo(viewNode)
      display.newTTFLabel({
        text = (old[attr] or 0) .. (idx == 1 and "" or "%"),
        size = 18,
        color = UIHelper.hex2rgb("#713802")
      }):anch(0, 0.5):pos(254, 13):addTo(viewNode)
      for index = 1, 4 do
        display.newSprite("ui/kitchen/quality/arrow.png"):pos(330 + (index - 1) * 6, 13):addTo(viewNode)
      end
      display.newTTFLabel({
        text = (new[attr] or 0) .. (idx == 1 and "" or "%"),
        size = 18,
        color = UIHelper.hex2rgb("#3a9721")
      }):anch(0, 0.5):pos(400, 13):addTo(viewNode)
    end
  end
  if next(extra) then
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(500, 10)):addTo(list)
    local index = 1
    for idx, attr in pairs(extra) do
      viewNode = ccui.Widget:create()
      viewNode:setContentSize(cc.size(500, 26)):addTo(list)
      if index == 1 then
        display.newTTFLabel({
          text = "特殊节点加成:",
          size = 18,
          color = UIHelper.hex2rgb("#713802")
        }):anch(0, 0.5):pos(80, 13):addTo(viewNode)
      end
      display.newTTFLabel({
        text = string.format(attrsEDesc[idx], new[attr]),
        size = 18,
        color = UIHelper.hex2rgb("#3a9721")
      }):anch(0, 0.5):pos(200, 13):addTo(viewNode)
      index = index + 1
    end
  end
end

return StrengthUpLevelLayer
