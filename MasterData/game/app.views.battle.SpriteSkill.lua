local skillDataSet = require("csvdata.skill")
local bulletDataSet = require("csvdata.bullet")
local SpriteSkill = class("SpriteSkill")

function SpriteSkill:ctor(params)
  self.skill = params.skill
end

function SpriteSkill:onShow()
end

function SpriteSkill:onOtherEffect(target, params)
  local targetXPos = target.displayNode:getPositionX()
  local targetYPos = BATTLE_Y_POS
  local effectFuncs = {
    ["1"] = function(target, value)
      local actions = {}
      actions[#actions + 1] = cc.MoveTo:create(params.time, cc.p(target.xPos, targetYPos))
      actions[#actions + 1] = cc.CallFunc:create(function()
        target.skillEffectMove = false
      end)
      return actions
    end,
    ["2"] = function(target, value)
      local actions = {}
      actions[#actions + 1] = cc.MoveTo:create(params.time, cc.p(target.xPos, targetYPos))
      actions[#actions + 1] = cc.CallFunc:create(function()
        target.skillEffectMove = false
      end)
      return actions
    end,
    ["3"] = function(target, value)
      local actions = {}
      actions[#actions + 1] = cc.EaseOut:create(cc.MoveTo:create(0.5, cc.p(targetXPos, targetYPos + value)), 0.1)
      actions[#actions + 1] = cc.MoveTo:create(0.5, cc.p(targetXPos, targetYPos))
      actions[#actions + 1] = cc.CallFunc:create(function()
        target.skillEffectMove = false
      end)
      return actions
    end,
    ["4"] = function(target, value)
      local actions = {}
      actions[#actions + 1] = cc.EaseExponentialIn:create(cc.MoveTo:create(params.time, cc.p(target.xPos, value + targetYPos)))
      actions[#actions + 1] = cc.MoveTo:create(0.2, cc.p(target.xPos, targetYPos))
      actions[#actions + 1] = cc.CallFunc:create(function()
        target.skillEffectMove = false
      end)
      return actions
    end
  }
  local action = transition.sequence(effectFuncs[params.type](target, params.effectValue))
  action:setTag(SKILL_OTHER_ACTION_TAG)
  target.displayNode:runAction(action)
end

function SpriteSkill:onDispose()
  for _, bullet in ipairs(self.bullets) do
    bullet:dispose()
  end
  self.bullets = {}
  for _, totem in ipairs(self.totems) do
    totem:dispose()
  end
  self.totems = {}
end

return SpriteSkill
