local BattleMark = class("BattleMark", function()
	return cc.Node:create()
end)
local var_0_1 = loadCfg("core.config.cfg.skill_mark_info")
local SpineBase = require("app.view.common.SpineBase")

function BattleMark:ctor(arg_2_1, arg_2_2, arg_2_3)
	self._level = 0
	self._actor = arg_2_2
	self._id = arg_2_1
	self._effects = {}
	self._groupEffects = {}
	self._markCfg = var_0_1.get(arg_2_1)
	self._type = self._markCfg.mark_type
	self._battleLayer = arg_2_3
end

function BattleMark:getMarkCfg()
	return self._markCfg
end

function BattleMark:addLevel(arg_4_1)
	if self._type == 1 or self._type == 2 then
		local var_4_0 = self._level

		self._level = math.max(self._level + arg_4_1, 0)
		self._level = math.min(self._level, self._markCfg.max_num)

		if self._level ~= var_4_0 then
			self:clearEffects()

			if self._level > 0 then
				if self._markCfg.effect_high ~= "0" then
					local var_4_1 = SpineBase.new({
						resId = "",
						isLoop = true,
						path = g.core.common.Path:getEffSpine(self._markCfg.effect_high),
						anim = "play_" .. self._level
					})

					self._actor._nodeMark:addChild(var_4_1)

					self._effects[#self._effects + 1] = var_4_1
				end

				if self._markCfg.effect_low ~= "0" then
					local var_4_2 = SpineBase.new({
						resId = "",
						isLoop = true,
						path = g.core.common.Path:getEffSpine(self._markCfg.effect_low),
						anim = "play_" .. self._level
					})

					self._actor._nodeMarkDown:addChild(var_4_2)

					self._effects[#self._effects + 1] = var_4_2
				end
			else
				self._effects = {}
			end
		end
	end
end

function BattleMark:clearEffects()
	for iter_5_0, iter_5_1 in ipairs(self._effects) do
		iter_5_1:removeFromParent(true)
	end

	self._effects = {}
end

return BattleMark
