local var_0_0 = string
local var_0_2 = assert
local FightMessage = require("fight.FightMessage")
local xp_effect_manager = require("fight.xp.xp_effect_manager")
local audio_manager = require("controller.audio_manager")
local var_0_6 = {
	init = function(self, arg_1_1)
		self.ref.character = arg_1_1
		self.cfg = require(arg_1_1.model.spinecfg)
	end,
	resetCfg = function(self)
		self.cfg = require(self.ref.character.model.spinecfg)
	end,
	doSequence = function(self, arg_3_1, arg_3_2)
		for iter_3_0 = 1, #arg_3_1 do
			if not self.ref.character:skillexecute(arg_3_2, arg_3_1[iter_3_0].method, arg_3_1[iter_3_0].param, arg_3_1[iter_3_0].operator) then
				return false
			end
		end

		return true
	end,
	doSelector = function(self, arg_4_1, arg_4_2)
		for iter_4_0 = 1, #arg_4_1 do
			if self:doSequence(arg_4_1[iter_4_0], arg_4_2) then
				return true
			end
		end

		return false
	end,
	run_cross_exetbl = function(self, arg_5_1, arg_5_2)
		local var_5_0 = self.ref.character

		self.ref.character._crossing = {}
		self.ref.character._crossing.msg = arg_5_2
		self.ref.character._crossing.fixbound = arg_5_1.exe_crash_bound

		function self.ref.character._crossing.proc(arg_6_0)
			if arg_5_1.exe_tbl then
				for iter_6_0, iter_6_1 in ipairs(arg_5_1.exe_tbl) do
					var_5_0:pushInAttackHandler(0, iter_6_1, {
						run_node = var_5_0,
						assigned_target = arg_6_0,
						msg = arg_5_2
					})
				end
			end
		end
	end,
	run_crash_exetbl = function(self, arg_7_1, arg_7_2)
		local var_7_0 = self.ref.character

		self.ref.character._crashing = {}
		self.ref.character._crashing.crashtype = arg_7_1.exe_crash_type
		self.ref.character._crashing.msg = arg_7_2
		self.ref.character._crashing.fixbound = arg_7_1.exe_crash_bound

		function self.ref.character._crashing.proc(arg_8_0)
			if arg_7_1.exe_tbl then
				for iter_8_0, iter_8_1 in ipairs(arg_7_1.exe_tbl) do
					var_7_0:pushInAttackHandler(0, iter_8_1, {
						run_node = var_7_0,
						assigned_target = arg_8_0,
						msg = arg_7_2
					})
				end
			end
		end
	end,
	run_normal_exetbl = function(self, arg_9_1, arg_9_2)
		if arg_9_1.exe_tbl then
			for iter_9_0, iter_9_1 in ipairs(arg_9_1.exe_tbl) do
				if iter_9_1.bullet then
					self.ref.character:pushInBulletHandler(iter_9_1.frame / (30 * arg_9_2.skillspeedscale), iter_9_1, {
						bulletinfo = self.cfg.extra[iter_9_1.bullet],
						msg = arg_9_2
					})
				else
					self.ref.character:pushInAttackHandler(iter_9_1.frame / (30 * arg_9_2.skillspeedscale), iter_9_1, {
						run_node = self.ref.character,
						assigned_target = self.ref.character.target,
						msg = arg_9_2
					})
				end
			end
		end
	end,
	run_skill_exetbl = function(self, arg_10_1, arg_10_2)
		if arg_10_1.exe_type == "cross" then
			self:run_cross_exetbl(arg_10_1, arg_10_2)
		elseif arg_10_1.exe_type == "crash" then
			self:run_crash_exetbl(arg_10_1, arg_10_2)
		else
			self:run_normal_exetbl(arg_10_1, arg_10_2)
		end
	end,
	play_skill_sound = function(self, arg_11_1)
		if not arg_11_1.sound then
			return
		end

		local var_11_0 = arg_11_1.sound

		self.ref.character:pushInDelayCallFuncs(arg_11_1.sound.frame / 30, function()
			audio_manager:playFightEffect(var_11_0.file, var_11_0.volume, FightManager.getBossSpeedUp())
		end)
	end,
	run_skill_start_action = function(self, arg_13_1, arg_13_2)
		if not arg_13_1.action_on_start then
			return
		end

		local var_13_0 = arg_13_1.action_on_start

		if arg_13_1.action_on_start[1].action then
			for iter_13_0, iter_13_1 in ipairs(var_13_0) do
				self.ref.character:pushInSkillStartHandler((iter_13_1.startframe or 0) / (30 * arg_13_2.skillspeedscale), iter_13_1.action, arg_13_2)
			end
		else
			self:doSequence(var_13_0, arg_13_2)
		end
	end,
	run_xp_effect = function(self, arg_14_1)
		if not arg_14_1 then
			return
		end

		xp_effect_manager.runXP(self.ref.character, self.cfg.xpeffect[arg_14_1])
	end,
	run_xp_effect = function(self, arg_15_1)
		if not arg_15_1 then
			return
		end

		if type(arg_15_1) == "string" then
			xp_effect_manager.runXP(self.ref.character, self.cfg.xpeffect[arg_15_1])
		elseif type(arg_15_1) == "table" then
			local var_15_0 = self.ref.character
			local var_15_1 = self.cfg.xpeffect[arg_15_1.conf]
			local var_15_2 = (arg_15_1.startframe or 0) / 30

			if (arg_15_1.startframe or 0) / 30 == 0 then
				xp_effect_manager.runXP(self.ref.character, self.cfg.xpeffect[arg_15_1.conf])
			else
				self.ref.character:pushInDelayCallFuncs(var_15_2, function()
					xp_effect_manager.runXP(var_15_0, var_15_1)
				end)
			end
		end
	end,
	insert_xp_effect = function(arg_17_0, arg_17_1)
		return
	end,
	clean_xp_effect = function(self)
		local var_18_0 = xp_effect_manager.getXPIndex()

		if var_18_0 and var_18_0 == self.ref.character.index then
			xp_effect_manager.removeXP()
		end
	end,
	runAttack = function(self, arg_19_1, arg_19_2)
		if self.cfg[arg_19_1].animation then
			return self:doAttack(arg_19_1, arg_19_2)
		else
			return self:doSelector(self.cfg[arg_19_1], arg_19_2)
		end
	end,
	runSkill = function(self, arg_20_1, arg_20_2, arg_20_3)
		if arg_20_1 == "xp" then
			self.ref.character:joinCD(arg_20_1)
		end

		local var_20_0 = arg_20_3 or self.ref.character:getSkillCfgName(arg_20_1)

		var_0_2(self.cfg[var_20_0], var_0_0.format("cfg name %s of %s is nil", var_20_0, self.ref.character:getAttribute("modelid")))

		return self:doSelector(self.cfg[var_20_0], arg_20_2)
	end,
	execute = function(self, arg_21_1, arg_21_2, arg_21_3)
		if var_0_0.find(arg_21_1, "^attack") then
			self:runAttack(arg_21_1, arg_21_2, arg_21_3)
		else
			self:runSkill(arg_21_1, arg_21_2, arg_21_3)
		end
	end,
	doAttack = function(self, arg_22_1, arg_22_2, arg_22_3)
		local var_22_0 = self.ref.character:getAttribute("attackspeed")

		if self.ref.character.statuspool:getStatus("attackspeedlocked") and not self.ref.character.statuspool:getStatus("attackspeedlockedlimit") then
			var_22_0 = self.ref.character.model:getAttribute("cur_locked_attackspeed")
		end

		if self.ref.character:getAttribute("maxattackspeedlimit") > 0 then
			var_22_0 = math.min(var_22_0, self.ref.character:getAttribute("maxattackspeedlimit"))
		end

		if self.ref.character:getAttribute("minattackspeedlimit") > 0 then
			var_22_0 = math.max(var_22_0, self.ref.character:getAttribute("minattackspeedlimit"))
		end

		local var_22_1 = math.max(0.4, var_22_0 * (1 + self.ref.character:getAttribute("extra_attackspeed")) * (1 + global_fight_speedup))
		local var_22_2 = initAttackSpeedScale(var_22_1, self.cfg[arg_22_1].totalframe, global_fight_speedup)

		self.ref.character:setWaitAttackTimer(1 / var_22_1)

		arg_22_2.skillspeedscale = var_22_2

		local var_22_3 = (self.cfg[arg_22_1].startframe or 0) / 30

		self.ref.character.skeleton:setTimeScale(var_22_2 * global_battlefield_timescale * FightManager.getBossSpeedUp())
		self.ref.character:play(self.cfg[arg_22_1].animation, false, var_22_3)

		self.ref.character._playing = "attack"

		self:run_skill_start_action(self.cfg[arg_22_1], arg_22_2)
		self:run_skill_exetbl(self.cfg[arg_22_1], arg_22_2)
		self.ref.character:pushInSkillCompleteHandler(self.cfg[arg_22_1].totalframe / (30 * var_22_2), self.cfg[arg_22_1].action_on_complete, arg_22_2)
	end,
	runDoubleAttack = function(self, arg_23_1)
		if self.cfg.attack.animation then
			return self:doDoubleAttack("attack", arg_23_1)
		else
			arg_23_1.isdoubleattack = true

			return self:doSelector(self.cfg.attack, arg_23_1)
		end
	end,
	doDoubleAttack = function(self, arg_24_1, arg_24_2)
		if not self.cfg[arg_24_1] then
			return
		end

		if not self.cfg[arg_24_1].exe_tbl then
			return
		end

		local var_24_0 = self.ref.character

		arg_24_2.doubleattack = true
		arg_24_2.isdoubleattack = false

		if self.cfg[arg_24_1].exe_tbl[1].bullet then
			var_24_0:pushInBulletHandler(0, self.cfg[arg_24_1].exe_tbl[1], {
				bulletinfo = self.cfg.extra[self.cfg[arg_24_1].exe_tbl[1].bullet],
				msg = arg_24_2
			})
		else
			local var_24_1 = var_24_0:getAttribute("attackspeed")

			if var_24_0.statuspool:getStatus("attackspeedlocked") and not var_24_0.statuspool:getStatus("attackspeedlockedlimit") then
				var_24_1 = var_24_0:getAttribute("cur_locked_attackspeed")
			end

			if var_24_0:getAttribute("maxattackspeedlimit") > 0 then
				var_24_1 = math.min(var_24_1, var_24_0:getAttribute("maxattackspeedlimit"))
			end

			if var_24_0:getAttribute("minattackspeedlimit") > 0 then
				var_24_1 = math.max(var_24_1, var_24_0:getAttribute("minattackspeedlimit"))
			end

			local var_24_2 = math.max(0.4, var_24_1 * (1 + var_24_0:getAttribute("extra_attackspeed")) * (1 + global_fight_speedup))
			local var_24_3 = initAttackSpeedScale(var_24_2, self.cfg[arg_24_1].totalframe, global_fight_speedup)

			if not var_24_0._usingXP then
				var_24_0:setWaitAttackTimer(1 / var_24_2)

				var_24_0._playing = "attack"

				var_24_0.skeleton:setTimeScale(var_24_3 * global_battlefield_timescale * FightManager.getBossSpeedUp())
				var_24_0:play(self.cfg[arg_24_1].animation, false, (self.cfg[arg_24_1].startframe or 0) / 30)
			end

			var_24_0:pushInAttackHandler(self.cfg[arg_24_1].exe_tbl[1].frame / (30 * var_24_3), self.cfg[arg_24_1].exe_tbl[1], {
				run_node = var_24_0,
				assigned_target = var_24_0.target,
				msg = arg_24_2
			})
		end
	end,
	doSkill = function(self, arg_25_1, arg_25_2)
		var_0_2(self.cfg[arg_25_1], var_0_0.format("cfg name %s of %s is nil", arg_25_1, self.ref.character:getAttribute("modelid")))

		if (self.cfg[arg_25_1].anitype or "release") == "continued" then
			return self:doContinued(arg_25_1, arg_25_2)
		else
			return self:doReleased(arg_25_1, arg_25_2)
		end
	end,
	doContinued = function(arg_26_0, arg_26_1, arg_26_2)
		return
	end,
	doReleased = function(self, arg_27_1, arg_27_2)
		local var_27_0 = self.cfg[arg_27_1]
		local var_27_1 = self.ref.character
		local var_27_2 = 1

		if self.cfg[arg_27_1].skillattackframe then
			var_27_2 = var_27_0.totalframe <= var_27_0.skillattackframe and 1 or var_27_0.totalframe / var_27_0.skillattackframe

			var_27_1:setWaitAttackTimer(var_27_0.skillattackframe / 30)
		end

		arg_27_2.skillspeedscale = var_27_2

		local var_27_3 = (var_27_0.startframe or 0) / 30

		arg_27_2.skillsection = arg_27_2.skillsection + 1

		var_27_1:setTurnbackLimit(var_27_0.turnbacklimit or false)

		if var_27_0.animation then
			var_27_1.skeleton:setTimeScale(var_27_2 * global_battlefield_timescale * FightManager.getBossSpeedUp())
			var_27_1:play(var_27_0.animation, false, var_27_3)

			if var_27_0.changeattachment then
				local var_27_4, var_27_5 = var_27_1:getTarget()

				if var_27_5 and not var_27_4[1] then
					-- block empty
				end

				var_27_1:setSlotTexture(var_27_0.changeattachment.slot, var_27_0.changeattachment.attachment, CUTE_ROLE_IMAGE_PATH .. var_27_4:getAttribute("cuteQ") .. ".png")
			end
		end

		var_27_1._playing = arg_27_2.skilltype

		if FightManager.getFightType() ~= FIGHTTYPE_AIATTACK and arg_27_2.skilltype == "xp" then
			if arg_27_2.skillsection == 1 then
				self:run_xp_effect(var_27_0.xpeffect)
			else
				self:insert_xp_effect(var_27_0.xpeffect)
			end
		end

		self:run_skill_start_action(var_27_0, arg_27_2)
		self:run_skill_exetbl(var_27_0, arg_27_2)
		self:play_skill_sound(var_27_0)
		var_27_1:pushInSkillCompleteHandler(var_27_0.totalframe / (30 * var_27_2), var_27_0.action_on_complete, arg_27_2)
	end
}
local var_0_7 = {
	__index = var_0_6
}

function var_0_6.new(arg_28_0)
	local var_28_0 = setmetatable({}, var_0_7)

	var_28_0.ref = setmetatable({}, {
		__mode = "kv"
	})

	var_28_0:init(arg_28_0)

	return var_28_0
end

return var_0_6
