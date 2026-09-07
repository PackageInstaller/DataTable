local LaunchBallPlayerControl = class("LaunchBallPlayerControl")
local var_0_1 = {
	{
		id = 1,
		name = "Hatsuduki",
		tpl = "Hatsuduki",
		skill = {
			1,
			2,
			3,
			4
		}
	},
	{
		id = 2,
		name = "Shinano",
		tpl = "Shinano",
		skill = {
			1,
			5,
			6
		}
	},
	{
		id = 3,
		name = "Yura",
		tpl = "Yura",
		skill = {
			1,
			7,
			8
		}
	},
	{
		id = 4,
		name = "Shimakaze",
		tpl = "Shimakaze",
		skill = {
			1,
			9,
			10
		}
	}
}
local var_0_5 = "skill type fire"
local var_0_6 = "skill type press"
local var_0_7 = "skill type passive"

LaunchBallPlayerControl.buff_amulet_back_time = 0.4
LaunchBallPlayerControl.buff_panic_fire_speed = 1
LaunchBallPlayerControl.buff_panic_enemy_rate = 5
LaunchBallPlayerControl.buff_sleep_butterfly_time = 2
LaunchBallPlayerControl.slash_split_time = 0.5
LaunchBallPlayerControl.stop_enemy_time = 10
LaunchBallPlayerControl.buff_amulet_back = 1
LaunchBallPlayerControl.buff_panic = 2
LaunchBallPlayerControl.buff_neglect = 3
LaunchBallPlayerControl.buff_sleep = 4
LaunchBallPlayerControl.buff_time_max = 5
LaunchBallPlayerControl.buff_time_slash = 6
LaunchBallPlayerControl.script_remove_all_enemys = "remove all enemys"
LaunchBallPlayerControl.script_stop_enemy = "script_stop_enemy"
LaunchBallPlayerControl.script_slash = "script_slash"
LaunchBallPlayerControl.player_skill = {
	{
		cd_time = 0.5,
		play_time = 0.25,
		name = "atk",
		weight = 1,
		type = "skill type fire",
		color = {
			1,
			2,
			3,
			4,
			5,
			6,
			7
		}
	},
	{
		cd_time = 20,
		play_time = 0.7,
		name = "player1skillA",
		skill_direct = false,
		weight = 2,
		type = "skill type press",
		buff = {
			{
				time = 10,
				type = LaunchBallPlayerControl.buff_amulet_back
			}
		}
	},
	{
		cd_time = 0,
		play_time = 0,
		name = "panic",
		weight = 0,
		type = "skill type passive",
		buff = {
			{
				time = 999999,
				type = LaunchBallPlayerControl.buff_panic
			}
		}
	},
	{
		cd_time = 0,
		play_time = 1,
		name = "neglect",
		weight = 0,
		type = "skill type passive",
		buff = {
			{
				time = 999999,
				type = LaunchBallPlayerControl.buff_neglect,
				active_rule = {
					weight = 10,
					play_time = 3.5,
					time = 10
				}
			}
		}
	},
	{
		cd_time = 0,
		play_time = 1,
		name = "sleep",
		weight = 0,
		type = "skill type passive",
		buff = {
			{
				time = 999999,
				type = LaunchBallPlayerControl.buff_sleep,
				active_rule = {
					weight = 10,
					play_time = 3,
					time = 10
				}
			}
		}
	},
	{
		cd_time = 60,
		play_time = 1.3,
		name = "player2SkillA",
		skill_direct = false,
		weight = 2,
		type = "skill type press",
		script = LaunchBallPlayerControl.script_remove_all_enemys,
		buff = {}
	},
	{
		cd_time = 22,
		play_time = 1.3,
		name = "player3SkillA",
		skill_direct = false,
		weight = 2,
		type = "skill type press",
		script = LaunchBallPlayerControl.script_stop_enemy,
		buff = {}
	},
	{
		cd_time = 0,
		play_time = 0,
		name = "player3Time",
		weight = 0,
		type = "skill type passive",
		buff = {
			{
				time = 999999,
				type = LaunchBallPlayerControl.buff_time_max
			}
		}
	},
	{
		name = "player4SkillA",
		skill_direct = true,
		script_time = 0.5,
		cd_time = 20,
		play_time = 1,
		weight = 2,
		type = "skill type press",
		script = LaunchBallPlayerControl.script_slash,
		effect = {
			time = 0.7,
			name = "Slash",
			distance = 200,
			direct = true,
			remove_time = 0.5,
			anim = "Slash"
		}
	},
	{
		cd_time = 0,
		play_time = 0,
		name = "player4SlashTime",
		weight = 0,
		type = "skill type passive",
		buff = {
			{
				time = 999999,
				type = LaunchBallPlayerControl.buff_time_slash
			}
		}
	}
}

local var_0_8 = 270
local var_0_9 = {
	{
		anim_name = "E",
		range = {
			0,
			45
		},
		direct = {
			1,
			0
		}
	},
	{
		anim_name = "N",
		range = {
			45,
			135
		},
		direct = {
			0,
			1
		}
	},
	{
		anim_name = "W",
		range = {
			135,
			225
		},
		direct = {
			-1,
			0
		}
	},
	{
		anim_name = "S",
		range = {
			225,
			315
		},
		direct = {
			0,
			-1
		}
	},
	{
		anim_name = "E",
		range = {
			315,
			360
		},
		direct = {
			1,
			0
		}
	}
}
local var_0_10 = "Idle"
local var_0_11 = "Buff"
local var_0_12 = "Panic"
local var_0_13 = "Attack"
local var_0_14 = "Skill_A"
local var_0_16 = {
	{
		anim_name = "01_Yellow"
	},
	{
		anim_name = "02_Green"
	},
	{
		anim_name = "03_White"
	},
	{
		anim_name = "04_Red"
	},
	{
		anim_name = "05_Blue"
	},
	{
		anim_name = "06_Black"
	},
	{
		anim_name = "07_Purple"
	}
}

local function var_0_17(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		ctor = function(self)
			self.playerTf = arg_1_0
			self.animator = GetComponent(findTF(self.playerTf, "ad/anim"), typeof(Animator))
			self.data = arg_1_1
			self.eventCall = arg_1_2
			self.panicFlag = false
			self.directRange = Clone(var_0_9)
			self.colors = Clone(var_0_16)
			self.skills = {}

			for iter_2_0 = 1, #arg_1_1.skill do
				table.insert(self.skills, {
					data = LaunchBallPlayerControl.player_skill[arg_1_1.skill[iter_2_0]],
					time = LaunchBallPlayerControl.player_skill[arg_1_1.skill[iter_2_0]].cd_time
				})
			end

			self.changeListener = GetOrAddComponent(findTF(self.playerTf, "ad/change"), typeof(EventTriggerListener))

			self.changeListener:AddPointDownFunc(function(arg_3_0, arg_3_1)
				self.eventCall(LaunchBallGameScene.CHANGE_AMULET)
				self:changePlayerStopTime(0)

				return
			end)

			return
		end,
		getId = function(self)
			return self.data.id
		end,
		start = function(self)
			self.useSkillTime = nil
			self.buffs = {}
			self.angle = var_0_8

			self:changePlaying(false)

			self.panicFlag = false
			self.idleAnimName = self:getIdleName()

			self:playAnim(self.idleAnimName)

			LaunchBallGameVo.pressSkill = self:getSkillByType(var_0_6)
			LaunchBallGameVo.buffs = self.buffs

			for iter_5_0 = 1, #self.skills do
				self.skills[iter_5_0].time = self.skills[iter_5_0].data.cd_time

				if self.skills[iter_5_0].data.type == var_0_7 then
					for iter_5_1 = 1, #self.skills[iter_5_0].data.buff do
						table.insert(self.buffs, {
							data = self.skills[iter_5_0].data.buff[iter_5_1],
							time = self.skills[iter_5_0].data.buff[iter_5_1].time
						})
					end
				end
			end

			self:changePlayerStopTime(0)

			return
		end,
		step = function(self)
			if self.playTime and self.playTime > 0 then
				self.playTime = self.playTime - LaunchBallGameVo.deltaTime

				if self.playTime <= 0 then
					self:changePlaying(false)
				end
			end

			if self.randomFireTime and self.randomFireTime > 0 then
				self.randomFireTime = self.randomFireTime - LaunchBallGameVo.deltaTime

				if self.randomFireTime <= 0 then
					self.randomFireTime = nil

					self.eventCall(LaunchBallGameScene.RANDOM_FIRE, {
						num = 3,
						data = {
							[LaunchBallGameConst.amulet_buff_back] = true
						}
					})
				end
			end

			if self.sleepTimeTrigger and self.sleepTimeTrigger > 0 then
				self.sleepTimeTrigger = self.sleepTimeTrigger - LaunchBallGameVo.deltaTime

				if self.sleepTimeTrigger <= 0 then
					self.sleepTimeTrigger = nil

					self.eventCall(LaunchBallGameScene.SLEEP_TIME_TRIGGER)
				end
			end

			if not self.isPlaying then
				local var_6_0 = self:getIdleName()

				if self.idleAnimName ~= var_6_0 then
					self:playAnim(var_6_0)

					self.idleAnimName = var_6_0
				end
			end

			for iter_6_0 = 1, #self.skills do
				if self.skills[iter_6_0].time > 0 then
					self.skills[iter_6_0].time = self.skills[iter_6_0].time - LaunchBallGameVo.deltaTime

					if self.skills[iter_6_0].time <= 0 then
						self.skills[iter_6_0].time = 0
					end
				end
			end

			for iter_6_1 = #self.buffs, 1, -1 do
				if self.buffs[iter_6_1].time > 0 then
					self.buffs[iter_6_1].time = self.buffs[iter_6_1].time - LaunchBallGameVo.deltaTime

					if self.buffs[iter_6_1].time <= 0 then
						table.remove(self.buffs, iter_6_1)
					end
				end
			end

			for iter_6_2 = #self.buffs, 1, -1 do
				if self.buffs[iter_6_2].data.type == LaunchBallPlayerControl.buff_panic then
					local var_6_1 = false

					if LaunchBallGameVo.enemyToEndRate then
						for iter_6_3 = 1, #LaunchBallGameVo.enemyToEndRate do
							if not var_6_1 and LaunchBallGameVo.enemyToEndRate[iter_6_3] > LaunchBallPlayerControl.buff_panic_enemy_rate then
								var_6_1 = true
							end
						end
					end

					self.buffs[iter_6_2].active = var_6_1

					if self.buffs[iter_6_2].active then
						local var_6_2 = self:getSkillByType(var_0_5)

						if var_6_2.time > 0 then
							var_6_2.time = var_6_2.time - LaunchBallGameVo.deltaTime * LaunchBallPlayerControl.buff_panic_fire_speed
						end
					end
				elseif self.buffs[iter_6_2].data.type == LaunchBallPlayerControl.buff_neglect then
					self:updateBuffStopTime(self.buffs[iter_6_2])
				elseif self.buffs[iter_6_2].data.type == LaunchBallPlayerControl.buff_sleep then
					self:updateBuffStopTime(self.buffs[iter_6_2])
				else
					self.buffs[iter_6_2].active = true
				end
			end

			self:changePlayerStopTime(self.playerStopTime + LaunchBallGameVo.deltaTime)

			return
		end,
		setPlayTime = function(arg_7_0, arg_7_1)
			if arg_7_1 and arg_7_1 > 0 then
				print("set play time " .. arg_7_1)

				arg_7_0.isPlaying = true
			else
				print("clear play time" .. arg_7_1)

				arg_7_0.isPlaying = false
			end

			arg_7_0.playTime = arg_7_1

			return
		end,
		updateBuffStopTime = function(self, arg_8_1)
			if not arg_8_1.active and self.playerStopTime > arg_8_1.data.active_rule.time then
				arg_8_1.active = true

				LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_use_pass_skill, 1)
				self:setPlayTime(arg_8_1.data.active_rule.play_time)

				self.weight = arg_8_1.data.active_rule.weight

				if arg_8_1.data.type == LaunchBallPlayerControl.buff_neglect then
					self.randomFireTime = 1.5

					if self:getBuff(LaunchBallPlayerControl.buff_panic).active then
						self:playAnim("Skill_B_Panic_Start")
					else
						self:playAnim("Skill_B_Start")
					end
				elseif arg_8_1.data.type == LaunchBallPlayerControl.buff_sleep then
					self:playAnim("Trans_Sleep_" .. self:getDirectName(self.angle))
				end
			end

			if arg_8_1.active and arg_8_1.data.type == LaunchBallPlayerControl.buff_sleep and not self.sleepTimeTrigger then
				self.sleepTimeTrigger = LaunchBallPlayerControl.buff_sleep_butterfly_time
			end

			if arg_8_1.active and self.playerStopTime < arg_8_1.data.active_rule.time then
				arg_8_1.active = false
			end

			return
		end,
		split = function(self, arg_9_1)
			if arg_9_1.split and self:getBuff(LaunchBallPlayerControl.buff_time_slash) then
				local var_9_0 = self:getSkillByType(var_0_6)

				if var_9_0 and var_9_0.time > 0 then
					var_9_0.time = var_9_0.time - LaunchBallPlayerControl.slash_split_time
				end
			end

			return
		end,
		changePlaying = function(self, arg_10_1, arg_10_2)
			if arg_10_1 then
				self:setPlayTime(arg_10_2.data.play_time)

				self.weight = arg_10_2.data.weight
			else
				self:setPlayTime(0)

				self.weight = 0
			end

			if self.eventCall then
				self.eventCall(LaunchBallGameScene.PLAYING_CHANGE, arg_10_1)
			end

			return
		end,
		fire = function(self)
			local var_11_0 = self:getSkillByType(var_0_5)

			if self:checkSkillAble(var_11_0) then
				self:changePlayerStopTime(0)

				if not LaunchBallGameVo.amulet then
					print("当前没有可以发射的符咒")

					return
				end

				self:appearSkill(var_11_0)
			end

			return
		end,
		getSkillByType = function(self, arg_12_1)
			for iter_12_0 = 1, #self.skills do
				if self.skills[iter_12_0].data.type == arg_12_1 then
					return self.skills[iter_12_0]
				end
			end

			return nil
		end,
		checkSkillAble = function(self, arg_13_1)
			if arg_13_1.time > 0 then
				print("还在cd中 cd = " .. arg_13_1.time)

				return false
			end

			if self.isPlaying and arg_13_1.data.weight <= self.weight then
				print("权重不够无法覆盖当前的技能")

				return false
			end

			return true
		end,
		appearSkill = function(self, arg_14_1)
			self:changePlayerStopTime(0)
			self:changePlaying(true, arg_14_1)

			arg_14_1.time = arg_14_1.data.cd_time

			if arg_14_1.data.type == var_0_5 then
				self:playAnim((self:getSkillAnimName(arg_14_1, LaunchBallGameVo.amulet.color)))
				self.eventCall(LaunchBallGameScene.FIRE_AMULET)
			elseif arg_14_1.data.type == var_0_6 then
				print("使用了主动技能")
				self:playAnim((self:getSkillAnimName(arg_14_1)))

				self.idleAnimName = nil

				if self.useSkillTime then
					LaunchBallGameVo.UpdateGameResultData(LaunchBallGameVo.reuslt_double_skill_time, LaunchBallGameVo.gameStepTime - self.useSkillTime)
				else
					self.useSkillTime = LaunchBallGameVo.gameStepTime
				end

				pg.CriMgr.GetInstance():PlaySoundEffect_V3(LaunchBallGameVo.SFX_PRESS_SKILL)
				LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_use_skill, 1)
			end

			local var_14_0 = arg_14_1.data.buff

			if arg_14_1.data.buff then
				for iter_14_0 = 1, #var_14_0 do
					table.insert(self.buffs, {
						data = var_14_0[iter_14_0],
						time = var_14_0[iter_14_0].time
					})
				end
			end

			if arg_14_1.data.script then
				if arg_14_1.data.script == LaunchBallPlayerControl.script_remove_all_enemys then
					self.eventCall(LaunchBallGameScene.SPLIT_ALL_ENEMYS, {
						time = 1.3,
						effect = true
					})
				elseif arg_14_1.data.script == LaunchBallPlayerControl.script_stop_enemy then
					self.eventCall(LaunchBallGameScene.STOP_ENEMY_TIME, {
						time = LaunchBallPlayerControl.stop_enemy_time
					})
				elseif arg_14_1.data.script == LaunchBallPlayerControl.script_slash then
					self.eventCall(LaunchBallGameScene.SLASH_ENEMY, {
						time = arg_14_1.data.script_time,
						direct = self:getDirectName(self.angle)
					})
					self.eventCall(LaunchBallGameScene.PLAYER_EFFECT, arg_14_1.data.effect)
				end
			end

			return
		end,
		getSkillAnimName = function(self, arg_15_1, arg_15_2)
			local var_15_0 = ""
			local var_15_2
			local var_15_4

			if arg_15_1.data.type == var_0_5 then
				local var_15_5 = self:getBuff(LaunchBallPlayerControl.buff_panic)

				if var_15_5 and var_15_5.active then
					var_15_2 = var_0_12
				end

				local var_15_6 = self:getDirectName(self.angle)

				if arg_15_2 then
					var_15_4 = self:getColorName(arg_15_2)
				end

				var_15_0 = var_15_2 and var_0_13 .. "_" .. var_15_2 .. "_" .. var_15_6 .. "_" .. var_15_4 or var_0_13 .. "_" .. var_15_6 .. "_" .. var_15_4
			elseif arg_15_1.data.type == var_0_6 then
				var_15_0 = var_0_14

				if arg_15_1.data.skill_direct then
					var_15_0 = var_15_0 .. "_" .. self:getDirectName(self.angle)
				end
			end

			return var_15_0
		end,
		getBuff = function(self, arg_16_1)
			for iter_16_0 = 1, #self.buffs do
				if self.buffs[iter_16_0].data.type == arg_16_1 then
					return self.buffs[iter_16_0]
				end
			end

			return nil
		end,
		getColorName = function(self, arg_17_1)
			return self.colors[arg_17_1].anim_name
		end,
		useSkill = function(self)
			local var_18_0 = self:getSkillByType(var_0_6)

			if not var_18_0 then
				return
			end

			if self:checkSkillAble(var_18_0) then
				self:appearSkill(var_18_0)
			end

			return
		end,
		clear = function(arg_19_0)
			return
		end,
		setAngle = function(self, arg_20_1)
			self:changePlayerStopTime(0)

			self.angle = (LaunchBallGameVo.joyStickData.angle + 360) % 360

			return
		end,
		changePlayerStopTime = function(self, arg_21_1)
			if self:getBuff(LaunchBallPlayerControl.buff_neglect) then
				if self:getBuff(LaunchBallPlayerControl.buff_neglect).active and self.playTime > 0 then
					return
				end
			elseif self:getBuff(LaunchBallPlayerControl.buff_sleep) and self:getBuff(LaunchBallPlayerControl.buff_sleep).active and self.playTime > 0 then
				return
			end

			self.playerStopTime = arg_21_1

			return
		end,
		playAnim = function(self, arg_22_1)
			print("play anim is " .. arg_22_1)
			self.animator:Play(arg_22_1)

			return
		end,
		getIdleName = function(self)
			local var_23_0 = var_0_10
			local var_23_2
			local var_23_3
			local var_23_4 = self:getDirectName(self.angle)
			local var_23_5 = self:getBuff(LaunchBallPlayerControl.buff_amulet_back)
			local var_23_6 = self:getBuff(LaunchBallPlayerControl.buff_panic)

			if var_23_5 and var_23_5.active then
				var_23_3 = var_0_11
			end

			if var_23_6 and var_23_6.active then
				var_23_2 = var_0_12
			end

			if var_23_3 then
				var_23_0 = var_23_0 .. "_" .. var_23_3
			elseif var_23_2 then
				var_23_0 = var_23_0 .. "_" .. var_23_2
			end

			if var_23_4 then
				var_23_0 = var_23_0 .. "_" .. var_23_4
			end

			return var_23_0
		end,
		getDirectName = function(self, arg_24_1)
			local var_24_0

			for iter_24_0 = 1, #self.directRange do
				if arg_24_1 >= self.directRange[iter_24_0].range[1] and arg_24_1 < self.directRange[iter_24_0].range[2] then
					var_24_0 = self.directRange[iter_24_0].anim_name
				end
			end

			return var_24_0, nil
		end,
		setContent = function(self, arg_25_1, arg_25_2)
			setParent(self.playerTf, arg_25_1)
			setActive(self.playerTf, true)

			self.playerTf.anchoredPosition = arg_25_2 and arg_25_2 or Vector2(0, 0)

			return
		end,
		dispose = function(self)
			if self.changeListener then
				ClearEventTrigger(self.changeListener)
			end

			if self.playerTf then
				Destroy(self.playerTf)

				self.playerTf = nil
			end

			return
		end
	}

	var_1_0:ctor()

	return var_1_0
end

function LaunchBallPlayerControl:Ctor(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	self._topContent = arg_27_1
	self._content = arg_27_2
	self._tpl = arg_27_3
	self._eventCall = arg_27_4

	return
end

function LaunchBallPlayerControl:setPlayerData(arg_28_1)
	if self.player and self.player:getId() ~= arg_28_1.id then
		self.player:dispose()

		self.player = nil
		self.player = self:createPlayer(arg_28_1)
	else
		self.player = self.player or self:createPlayer(arg_28_1)
	end

	return
end

function LaunchBallPlayerControl:createPlayer(arg_29_1)
	local var_29_0 = var_0_17(tf(instantiate(findTF(self._tpl, arg_29_1.tpl))), arg_29_1, self._eventCall)

	var_29_0:setContent(self._content)

	return var_29_0
end

function LaunchBallPlayerControl:start()
	self.playerId = LaunchBallGameVo.selectPlayer

	self:setPlayerData(var_0_1[self.playerId])
	self.player:start()

	self.effects = {}

	return
end

function LaunchBallPlayerControl:step()
	if LaunchBallGameVo.joyStickData and LaunchBallGameVo.joyStickData.active and LaunchBallGameVo.joyStickData.angle then
		self.player:setAngle(LaunchBallGameVo.joyStickData.angle)
	end

	if self.effects and #self.effects > 0 then
		for iter_31_0 = #self.effects, 1, -1 do
			if self.effects[iter_31_0].time and self.effects[iter_31_0].time > 0 then
				self.effects[iter_31_0].time = self.effects[iter_31_0].time - LaunchBallGameVo.deltaTime

				if self.effects[iter_31_0].time < 0 then
					self.effects[iter_31_0].time = nil

					setActive(self.effects[iter_31_0].tf, false)
					setActive(self.effects[iter_31_0].tf, true)
					self.effects[iter_31_0].anim:Play(self.effects[iter_31_0].animName)
				end
			elseif self.effects[iter_31_0].removeTime and self.effects[iter_31_0].removeTime > 0 then
				self.effects[iter_31_0].removeTime = self.effects[iter_31_0].removeTime - LaunchBallGameVo.deltaTime

				if self.effects[iter_31_0].removeTime < 0 then
					self.effects[iter_31_0].removeTime = nil

					setActive(self.effects[iter_31_0].tf, false)
					table.remove(self.effects, iter_31_0)
				end
			end
		end
	end

	self.player:step()

	return
end

function LaunchBallPlayerControl:eventCall(arg_32_1, arg_32_2)
	if arg_32_1 == LaunchBallGameScene.CHANGE_AMULET then
		-- block empty
	elseif arg_32_1 == LaunchBallGameScene.PLAYER_EFFECT then
		if arg_32_2 then
			local var_32_1 = findTF(self._topContent, "effect/" .. arg_32_2.name)
			local var_32_2 = arg_32_2.anim
			local var_32_3 = Vector2(0, 0)

			if arg_32_2.direct then
				local var_32_4, var_32_5 = self.player:getDirectName(self.player.angle)

				var_32_2 = var_32_2 .. "_" .. var_32_4
				var_32_1.anchoredPosition = Vector2(var_32_5[1] * arg_32_2.distance, var_32_5[2] * arg_32_2.distance)
			end

			table.insert(self.effects, {
				tf = var_32_1,
				anim = GetComponent(findTF(var_32_1, "ad/anim"), typeof(Animator)),
				time = arg_32_2.time,
				removeTime = arg_32_2.remove_time,
				animName = var_32_2
			})
		end
	elseif arg_32_1 == LaunchBallGameScene.SPILT_ENEMY_SCORE then
		self.player:split(arg_32_2)
	end

	return
end

function LaunchBallPlayerControl:press(arg_33_1)
	if arg_33_1 == KeyCode.J and self.player then
		self.player:fire()
	end

	return
end

function LaunchBallPlayerControl:joystickActive(arg_34_1)
	if not arg_34_1 and self.player then
		self.player:fire()
	end

	return
end

function LaunchBallPlayerControl:useSkill()
	if self.player then
		self.player:useSkill()
	end

	return
end

function LaunchBallPlayerControl:clear()
	self.player:clear()

	return
end

return LaunchBallPlayerControl
