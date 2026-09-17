local total_skill_data = require("data.total_skill_data")
local skill_data = require("data.skill_data")
local FightUIElementsManager = require("fight.FightUIElementsManager")
local horcrux_manager = require("controller.horcrux_manager")
local l2utils = require("controller.l2utils")
local var_0_6 = {}
local var_0_7 = {
	__index = {
		init = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
			arg_1_0._id = arg_1_1
			arg_1_0._skills = arg_1_3
			arg_1_0._entityid = arg_1_2
			arg_1_0._playing = false
		end,
		isSame = function(self, arg_2_1)
			return self._entityid == arg_2_1
		end,
		showOnBattleField = function(self, arg_3_1)
			local var_3_0, var_3_1 = arg_3_1:match("([^@]+)@(.+)")

			self._pool = var_3_0
			self._index = tonumber(var_3_1)

			if self._index > 3 then
				return
			end

			do return end

			if not self._id then
				FightUIElementsManager.getHorcruxSP(var_3_0, var_3_1):setVisible(false)
			else
				local var_3_2 = horcrux_manager:getHorcruxHeadImage(self._id)
				local var_3_3 = FightUIElementsManager.getHorcruxSP(var_3_0, var_3_1)

				var_3_3:setVisible(true)
				l2utils:recoverShader(var_3_3:getChildByName("role"))
				var_3_3:getChildByName("role"):setTexture(ROLE_HEAD_IMAGE_PATH .. var_3_2 .. ".png")

				local var_3_4 = self._skills or {}

				for iter_3_0 = 1, 2 do
					local var_3_5 = var_3_4[iter_3_0]

					if var_3_4[iter_3_0] and total_skill_data[var_3_5] and total_skill_data[var_3_5].icon then
						var_3_3:getChildByName("skill" .. iter_3_0):loadTexture("skill_new/skill/" .. total_skill_data[var_3_5].icon .. ".png", config._DEBUG and 0 or 1)
						var_3_3:getChildByName("skill" .. iter_3_0):setVisible(true)
					else
						var_3_3:getChildByName("skill" .. iter_3_0):setVisible(false)
					end
				end
			end
		end,
		playTriggerEffect = function(self)
			if self._playing then
				return
			end

			if not self._index then
				return
			end

			if self._index > 3 then
				return
			end

			do return end

			self._playing = true

			SmallFightLayer.getInstance():showHorcruxSkillEffect(self._pool, self._index, nil, nil, function()
				self._playing = false
			end)
		end,
		onPlayerDied = function(self)
			if not self._id then
				return
			end

			if not self._pool then
				return
			end

			if not self._index then
				return
			end

			if self._index > 3 then
				return
			end

			local var_6_0 = FightUIElementsManager.getHorcruxSP(self._pool, self._index)

			if not var_6_0 then
				return
			end

			l2utils:shaderHorcruxNode(var_6_0:getChildByName("role"))
		end
	}
}

function var_0_6.new(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = setmetatable({}, var_0_7)

	var_7_0:init(arg_7_0, arg_7_1, arg_7_2)

	return var_7_0
end

return var_0_6
