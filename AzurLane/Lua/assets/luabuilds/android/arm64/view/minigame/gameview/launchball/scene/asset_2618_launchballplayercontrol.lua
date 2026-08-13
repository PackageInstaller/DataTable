class = var_0_10000

local var_0_0 = var_0_10000("LaunchBallPlayerControl")
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
local var_0_2 = 1
local var_0_3 = "skill trigger"
local var_0_4 = "skill passive"
local var_0_5 = "skill type fire"
local var_0_6 = "skill type press"
local var_0_7 = "skill type passive"

var_0_0.buff_amulet_back_time = 0.4
var_0_0.buff_panic_fire_speed = 1
var_0_0.buff_panic_enemy_rate = 5
var_0_0.buff_sleep_butterfly_time = 2
var_0_0.slash_split_time = 0.5
var_0_0.stop_enemy_time = 10
var_0_0.buff_amulet_back = 1
var_0_0.buff_panic = 2
var_0_0.buff_neglect = 3
var_0_0.buff_sleep = 4
var_0_0.buff_time_max = 5
var_0_0.buff_time_slash = 6
var_0_0.script_remove_all_enemys = "remove all enemys"
var_0_0.script_stop_enemy = "script_stop_enemy"
var_0_0.script_slash = "script_slash"
var_0_0.player_skill = {
	{
		cd_time = 0.5,
		play_time = 0.25,
		name = "atk",
		weight = 1,
		type = var_0_5,
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
		type = var_0_6,
		buff = {
			{
				time = 10,
				type = var_0_0.buff_amulet_back
			}
		}
	},
	{
		cd_time = 0,
		play_time = 0,
		name = "panic",
		weight = 0,
		type = var_0_7,
		buff = {
			{
				time = 999999,
				type = var_0_0.buff_panic
			}
		}
	},
	{
		cd_time = 0,
		play_time = 1,
		name = "neglect",
		weight = 0,
		type = var_0_7,
		buff = {
			{
				time = 999999,
				type = var_0_0.buff_neglect,
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
		type = var_0_7,
		buff = {
			{
				time = 999999,
				type = var_0_0.buff_sleep,
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
		type = var_0_6,
		script = var_0_0.script_remove_all_enemys,
		buff = {}
	},
	{
		cd_time = 22,
		play_time = 1.3,
		name = "player3SkillA",
		skill_direct = false,
		weight = 2,
		type = var_0_6,
		script = var_0_0.script_stop_enemy,
		buff = {}
	},
	{
		cd_time = 0,
		play_time = 0,
		name = "player3Time",
		weight = 0,
		type = var_0_7,
		buff = {
			{
				time = 999999,
				type = var_0_0.buff_time_max
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
		type = var_0_6,
		script = var_0_0.script_slash,
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
		type = var_0_7,
		buff = {
			{
				time = 999999,
				type = var_0_0.buff_time_slash
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
local var_0_15 = "Skill_B"
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
		ctor = function(arg_2_0)
			arg_2_0.playerTf = arg_1_0
			GetComponent = var_1
			findTF = var_2_10003

			local var_2_0 = var_2_10003(arg_2_0.playerTf, "ad/anim")

			typeof = var_2_10004
			Animator = var_6
			arg_2_0.animator = var_1(var_2_0, var_2_10004(var_6))
			arg_2_0.data = arg_1_1
			arg_2_0.eventCall = arg_1_2
			arg_2_0.panicFlag = false
			Clone = var_1
			arg_2_0.directRange = var_1(var_0_9)
			Clone = var_1
			arg_2_0.colors = var_1(var_0_16)
			arg_2_0.skills = {}

			for iter_2_0 = 1, #arg_1_1.skill do
				local var_2_1 = var_0_0.player_skill[arg_1_1.skill[iter_2_0]]

				table = var_6

				var_6.insert(arg_2_0.skills, {
					data = var_2_1,
					time = var_2_1.cd_time
				})
			end

			findTF = var_1

			local var_2_2

			var_2_2, GetOrAddComponent = var_1(arg_2_0.playerTf, "ad/change"), var_2
			typeof = var_2_1
			EventTriggerListener = var_2_10007
			arg_2_0.changeListener = var_2(var_2_2, var_2_1(var_2_10007))

			local var_2_3 = arg_2_0.changeListener

			var_2.AddPointDownFunc(var_2_3, function(arg_3_0, arg_3_1)
				local var_3_0 = arg_2_0.eventCall

				LaunchBallGameScene = var_3_10004

				var_3_0(var_3_10004.CHANGE_AMULET)

				local var_3_1 = arg_2_0

				var_2.changePlayerStopTime(var_3_1, 0)

				return
			end)

			return
		end,
		getId = function(arg_4_0)
			return arg_4_0.data.id
		end,
		start = function(arg_5_0)
			arg_5_0.useSkillTime = nil
			arg_5_0.buffs = {}
			arg_5_0.angle = var_0_8

			arg_5_0:changePlaying(false)

			arg_5_0.panicFlag = false
			arg_5_0.idleAnimName = arg_5_0:getIdleName()

			arg_5_0:playAnim(arg_5_0.idleAnimName)

			LaunchBallGameVo = var_1
			var_1.pressSkill = arg_5_0:getSkillByType(var_0_6)
			LaunchBallGameVo = var_1
			var_1.buffs = arg_5_0.buffs

			for iter_5_0 = 1, #arg_5_0.skills do
				arg_5_0.skills[iter_5_0].time = arg_5_0.skills[iter_5_0].data.cd_time

				if arg_5_0.skills[iter_5_0].data.type == var_0_7 then
					local var_5_0 = arg_5_0.skills[iter_5_0].data.buff

					for iter_5_1 = 1, #var_5_0 do
						table = var_2_10010

						var_2_10010.insert(arg_5_0.buffs, {
							data = var_5_0[iter_5_1],
							time = var_5_0[iter_5_1].time
						})
					end
				end
			end

			arg_5_0:changePlayerStopTime(0)

			return
		end,
		step = function(arg_6_0)
			if arg_6_0.playTime then
				local var_6_0 = arg_6_0.playTime

				if 0 < var_6_0 then
					local var_6_1 = arg_6_0.playTime

					LaunchBallGameVo = var_2
					arg_6_0.playTime = var_6_1 - var_2.deltaTime

					if arg_6_0.playTime <= 0 then
						var_2_10003 = arg_6_0

						arg_6_0.changePlaying(var_2_10003, false)
					end
				end
			end

			if arg_6_0.randomFireTime then
				local var_6_2 = arg_6_0.randomFireTime

				if 0 < var_6_2 then
					local var_6_3 = arg_6_0.randomFireTime

					LaunchBallGameVo = var_2
					arg_6_0.randomFireTime = var_6_3 - var_2.deltaTime

					if arg_6_0.randomFireTime <= 0 then
						arg_6_0.randomFireTime = nil

						local var_6_4 = arg_6_0.eventCall

						LaunchBallGameScene = var_2_10003
						var_2_10003 = var_2_10003.RANDOM_FIRE

						local var_6_5 = {
							num = 3
						}

						var_2_10005 = {}
						LaunchBallGameConst = var_2_10006
						var_2_10005[var_2_10006.amulet_buff_back] = true
						var_6_5.data = var_2_10005

						var_6_4(var_2_10003, var_6_5)
					end
				end
			end

			if arg_6_0.sleepTimeTrigger then
				local var_6_6 = arg_6_0.sleepTimeTrigger

				if 0 < var_6_6 then
					local var_6_7 = arg_6_0.sleepTimeTrigger

					LaunchBallGameVo = var_2
					arg_6_0.sleepTimeTrigger = var_6_7 - var_2.deltaTime

					if arg_6_0.sleepTimeTrigger <= 0 then
						arg_6_0.sleepTimeTrigger = nil

						local var_6_8 = arg_6_0.eventCall

						LaunchBallGameScene = var_2_10003

						var_6_8(var_2_10003.SLEEP_TIME_TRIGGER)
					end
				end
			end

			if not arg_6_0.isPlaying then
				local var_6_9 = arg_6_0:getIdleName()

				if arg_6_0.idleAnimName ~= var_6_9 then
					arg_6_0:playAnim(var_6_9)

					arg_6_0.idleAnimName = var_6_9
				end
			end

			for iter_6_0 = 1, #arg_6_0.skills do
				if arg_6_0.skills[iter_6_0].time > 0 then
					var_2_10005 = arg_6_0.skills[iter_6_0]

					local var_6_10 = arg_6_0.skills[iter_6_0].time

					LaunchBallGameVo = var_2_10007
					var_2_10005.time = var_6_10 - var_2_10007.deltaTime

					if arg_6_0.skills[iter_6_0].time <= 0 then
						var_2_10005 = arg_6_0.skills[iter_6_0]
						var_2_10005.time = 0
					end
				end
			end

			for iter_6_1 = #arg_6_0.buffs, 1, -1 do
				local var_6_11 = arg_6_0.buffs[iter_6_1].time

				if 0 < var_6_11 then
					local var_6_12 = var_2_10005.time

					LaunchBallGameVo = var_7
					var_2_10005.time = var_6_12 - var_7.deltaTime

					if var_2_10005.time <= 0 then
						table = var_6

						var_6.remove(arg_6_0.buffs, iter_6_1)
					end
				end
			end

			for iter_6_2 = #arg_6_0.buffs, 1, -1 do
				if arg_6_0.buffs[iter_6_2].data.type == var_0_0.buff_panic then
					local var_6_13 = false

					LaunchBallGameVo = var_7

					if var_7.enemyToEndRate then
						local var_6_14 = 1

						LaunchBallGameVo = var_2_10008

						for iter_6_3 = var_6_14, #var_2_10008.enemyToEndRate do
							if not var_6_13 then
								LaunchBallGameVo = var_2_10011

								if var_2_10011.enemyToEndRate[iter_6_3] > var_0_0.buff_panic_enemy_rate then
									var_6_13 = true
								end
							end
						end
					end

					var_2_10005.active = var_6_13

					if var_2_10005.active then
						var_2_10008 = arg_6_0:getSkillByType(var_0_5).time

						if 0 < var_2_10008 then
							var_2_10008 = var_7.time
							LaunchBallGameVo = var_9
							var_7.time = var_2_10008 - var_9.deltaTime * var_0_0.buff_panic_fire_speed
						end
					end
				elseif var_2_10005.data.type == var_0_0.buff_neglect then
					var_2_10008 = arg_6_0

					arg_6_0.updateBuffStopTime(var_2_10008, var_2_10005)
				elseif var_2_10005.data.type == var_0_0.buff_sleep then
					var_2_10008 = arg_6_0

					arg_6_0.updateBuffStopTime(var_2_10008, var_2_10005)
				else
					var_2_10005.active = true
				end
			end

			local var_6_15 = arg_6_0
			local var_6_16 = arg_6_0.changePlayerStopTime
			local var_6_17 = arg_6_0.playerStopTime

			LaunchBallGameVo = var_2_10005

			var_6_16(var_6_15, var_6_17 + var_2_10005.deltaTime)

			return
		end,
		setPlayTime = function(arg_7_0, arg_7_1)
			if arg_7_1 and 0 < arg_7_1 then
				print = var_2_10002

				var_2_10002("set play time " .. arg_7_1)

				arg_7_0.isPlaying = true
			else
				print = var_2_10002

				var_2_10002("clear play time" .. arg_7_1)

				arg_7_0.isPlaying = false
			end

			arg_7_0.playTime = arg_7_1

			return
		end,
		updateBuffStopTime = function(arg_8_0, arg_8_1)
			if not arg_8_1.active and arg_8_0.playerStopTime > arg_8_1.data.active_rule.time then
				arg_8_1.active = true
				LaunchBallGameVo = var_2

				local var_8_0 = var_2.AddGameResultData

				LaunchBallGameVo = var_2_10004

				var_8_0(var_2_10004.result_use_pass_skill, 1)
				arg_8_0:setPlayTime(arg_8_1.data.active_rule.play_time)

				arg_8_0.weight = arg_8_1.data.active_rule.weight

				if arg_8_1.data.type == var_0_0.buff_neglect then
					arg_8_0.randomFireTime = 1.5

					if arg_8_0:getBuff(var_0_0.buff_panic).active then
						arg_8_0:playAnim("Skill_B_Panic_Start")
					else
						arg_8_0:playAnim("Skill_B_Start")
					end
				elseif arg_8_1.data.type == var_0_0.buff_sleep then
					local var_8_1 = "Trans_Sleep_" .. arg_8_0:getDirectName(arg_8_0.angle)

					arg_8_0:playAnim(var_8_1)
				end
			end

			if arg_8_1.active and arg_8_1.data.type == var_0_0.buff_sleep and not arg_8_0.sleepTimeTrigger then
				arg_8_0.sleepTimeTrigger = var_0_0.buff_sleep_butterfly_time
			end

			if arg_8_1.active and arg_8_0.playerStopTime < arg_8_1.data.active_rule.time then
				arg_8_1.active = false
			end

			return
		end,
		split = function(arg_9_0, arg_9_1)
			if arg_9_1.split and arg_9_0:getBuff(var_0_0.buff_time_slash) and arg_9_0:getSkillByType(var_0_6) and var_3.time > 0 then
				var_3.time = var_3.time - var_0_0.slash_split_time
			end

			return
		end,
		changePlaying = function(arg_10_0, arg_10_1, arg_10_2)
			if arg_10_1 then
				var_2_10005 = arg_10_0

				arg_10_0.setPlayTime(var_2_10005, arg_10_2.data.play_time)

				arg_10_0.weight = arg_10_2.data.weight
			else
				var_2_10005 = arg_10_0

				arg_10_0.setPlayTime(var_2_10005, 0)

				arg_10_0.weight = 0
			end

			if arg_10_0.eventCall then
				local var_10_0 = arg_10_0.eventCall

				LaunchBallGameScene = var_2_10005

				var_10_0(var_2_10005.PLAYING_CHANGE, arg_10_1)
			end

			return
		end,
		fire = function(arg_11_0)
			local var_11_0 = arg_11_0:getSkillByType(var_0_5)

			if arg_11_0:checkSkillAble(var_11_0) then
				arg_11_0:changePlayerStopTime(0)

				LaunchBallGameVo = var_3

				if not var_3.amulet then
					print = var_3

					var_3("当前没有可以发射的符咒")

					return
				end

				arg_11_0:appearSkill(var_11_0)
			end

			return
		end,
		getSkillByType = function(arg_12_0, arg_12_1)
			for iter_12_0 = 1, #arg_12_0.skills do
				if arg_12_0.skills[iter_12_0].data.type == arg_12_1 then
					return var_6
				end
			end

			return nil
		end,
		checkSkillAble = function(arg_13_0, arg_13_1)
			if arg_13_1.time > 0 then
				print = var_2

				var_2("还在cd中 cd = " .. arg_13_1.time)

				return false
			end

			if arg_13_0.isPlaying and arg_13_1.data.weight <= arg_13_0.weight then
				print = var_2

				var_2("权重不够无法覆盖当前的技能")

				return false
			end

			return true
		end,
		appearSkill = function(arg_14_0, arg_14_1)
			arg_14_0:changePlayerStopTime(0)
			arg_14_0:changePlaying(true, arg_14_1)

			arg_14_1.time = arg_14_1.data.cd_time

			local var_14_1

			if arg_14_1.data.type == var_0_5 then
				LaunchBallGameVo = var_2

				local var_14_0 = var_2.amulet.color

				var_14_1 = arg_14_0

				local var_14_2 = arg_14_0.getSkillAnimName(var_14_1, arg_14_1, var_14_0)
				local var_14_3 = arg_14_0

				arg_14_0.playAnim(var_14_3, var_14_2)

				local var_14_4 = arg_14_0.eventCall

				LaunchBallGameScene = var_14_3

				var_14_4(var_14_3.FIRE_AMULET)
			elseif arg_14_1.data.type == var_0_6 then
				print = var_2

				var_2("使用了主动技能")

				local var_14_5 = arg_14_0:getSkillAnimName(arg_14_1)

				var_14_1 = arg_14_0

				arg_14_0.playAnim(var_14_1, var_14_5)

				arg_14_0.idleAnimName = nil

				local var_14_6

				if arg_14_0.useSkillTime then
					LaunchBallGameVo = var_14_6
					var_14_6 = var_14_6.gameStepTime - arg_14_0.useSkillTime
					LaunchBallGameVo = var_4

					local var_14_7 = var_4.UpdateGameResultData

					LaunchBallGameVo = var_6

					var_14_7(var_6.reuslt_double_skill_time, var_14_6)
				else
					LaunchBallGameVo = var_14_6
					arg_14_0.useSkillTime = var_14_6.gameStepTime
				end

				pg = var_14_6
				var_14_1 = var_14_6.CriMgr.GetInstance()

				local var_14_8 = var_3.PlaySoundEffect_V3

				LaunchBallGameVo = var_6

				var_14_8(var_14_1, var_6.SFX_PRESS_SKILL)

				LaunchBallGameVo = var_14_8

				local var_14_9 = var_14_8.AddGameResultData

				LaunchBallGameVo = var_14_1

				var_14_9(var_14_1.result_use_skill, 1)
			end

			if arg_14_1.data.buff then
				for iter_14_0 = 1, #var_2 do
					local var_14_10 = var_2[iter_14_0].time

					table = var_2_10009

					var_2_10009.insert(arg_14_0.buffs, {
						data = var_7,
						time = var_14_10
					})
				end
			end

			if arg_14_1.data.script then
				if arg_14_1.data.script == var_0_0.script_remove_all_enemys then
					local var_14_11 = arg_14_0.eventCall

					LaunchBallGameScene = var_14_1

					var_14_11(var_14_1.SPLIT_ALL_ENEMYS, {
						time = 1.3,
						effect = true
					})
				elseif arg_14_1.data.script == var_0_0.script_stop_enemy then
					local var_14_12 = arg_14_0.eventCall

					LaunchBallGameScene = var_14_1

					var_14_12(var_14_1.STOP_ENEMY_TIME, {
						time = var_0_0.stop_enemy_time
					})
				elseif arg_14_1.data.script == var_0_0.script_slash then
					local var_14_13 = arg_14_0.eventCall

					LaunchBallGameScene = var_14_1

					var_14_13(var_14_1.SLASH_ENEMY, {
						time = arg_14_1.data.script_time,
						direct = arg_14_0:getDirectName(arg_14_0.angle)
					})

					local var_14_14 = arg_14_0.eventCall

					LaunchBallGameScene = var_5

					var_14_14(var_5.PLAYER_EFFECT, arg_14_1.data.effect)
				end
			end

			return
		end,
		getSkillAnimName = function(arg_15_0, arg_15_1, arg_15_2)
			local var_15_0 = ""
			local var_15_1
			local var_15_2
			local var_15_3
			local var_15_4

			if arg_15_1.data.type == var_0_5 then
				local var_15_5 = var_0_13

				if arg_15_0:getBuff(var_0_0.buff_panic) and var_9.active then
					var_15_2 = var_0_12
				end

				local var_15_6 = arg_15_0:getDirectName(arg_15_0.angle)

				if arg_15_2 then
					var_15_4 = arg_15_0:getColorName(arg_15_2)
				end

				if var_15_2 then
					var_15_0 = var_15_5 .. "_" .. var_15_2 .. "_" .. var_15_6 .. "_" .. var_15_4
				else
					var_15_0 = var_15_5 .. "_" .. var_15_6 .. "_" .. var_15_4
				end
			elseif var_8.type == var_0_6 then
				var_15_0 = var_0_14

				if var_8.skill_direct then
					local var_15_7 = arg_15_0:getDirectName(arg_15_0.angle)

					var_15_0 = var_15_0 .. "_" .. var_15_7
				end
			end

			return var_15_0
		end,
		getBuff = function(arg_16_0, arg_16_1)
			for iter_16_0 = 1, #arg_16_0.buffs do
				if arg_16_0.buffs[iter_16_0].data.type == arg_16_1 then
					return arg_16_0.buffs[iter_16_0]
				end
			end

			return nil
		end,
		getColorName = function(arg_17_0, arg_17_1)
			return arg_17_0.colors[arg_17_1].anim_name
		end,
		useSkill = function(arg_18_0)
			if not arg_18_0:getSkillByType(var_0_6) then
				return
			end

			if arg_18_0:checkSkillAble(var_1) then
				arg_18_0:appearSkill(var_1)
			end

			return
		end,
		clear = function(arg_19_0)
			return
		end,
		setAngle = function(arg_20_0, arg_20_1)
			arg_20_0:changePlayerStopTime(0)

			LaunchBallGameVo = var_2
			arg_20_0.angle = (var_2.joyStickData.angle + 360) % 360

			return
		end,
		changePlayerStopTime = function(arg_21_0, arg_21_1)
			if arg_21_0:getBuff(var_0_0.buff_neglect) then
				if arg_21_0:getBuff(var_0_0.buff_neglect).active and arg_21_0.playTime > 0 then
					return
				end
			elseif arg_21_0:getBuff(var_0_0.buff_sleep) and arg_21_0:getBuff(var_0_0.buff_sleep).active and arg_21_0.playTime > 0 then
				return
			end

			arg_21_0.playerStopTime = arg_21_1

			return
		end,
		playAnim = function(arg_22_0, arg_22_1)
			print = var_2_10002

			var_2_10002("play anim is " .. arg_22_1)

			local var_22_0 = arg_22_0.animator

			var_2.Play(var_22_0, arg_22_1)

			return
		end,
		getIdleName = function(arg_23_0)
			local var_23_0 = var_0_10
			local var_23_1
			local var_23_2
			local var_23_3
			local var_23_4 = arg_23_0:getDirectName(arg_23_0.angle)
			local var_23_5 = arg_23_0:getBuff(var_0_0.buff_amulet_back)
			local var_23_6 = arg_23_0:getBuff(var_0_0.buff_panic)

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
		getDirectName = function(arg_24_0, arg_24_1)
			local var_24_0
			local var_24_1

			for iter_24_0 = 1, #arg_24_0.directRange do
				if arg_24_1 >= arg_24_0.directRange[iter_24_0].range[1] and arg_24_1 < var_8[2] then
					var_24_0 = arg_24_0.directRange[iter_24_0].anim_name
					var_24_1 = arg_24_0.directRange[iter_24_0].direct
				end
			end

			return var_24_0, var_24_1
		end,
		setContent = function(arg_25_0, arg_25_1, arg_25_2)
			setParent = var_2_10003

			var_2_10003(arg_25_0.playerTf, arg_25_1)

			setActive = var_2_10003

			var_2_10003(arg_25_0.playerTf, true)

			if arg_25_2 then
				arg_25_0.playerTf.anchoredPosition = arg_25_2
			else
				local var_25_0 = arg_25_0.playerTf

				Vector2 = var_2_10004
				var_25_0.anchoredPosition = var_2_10004(0, 0)
			end

			return
		end,
		dispose = function(arg_26_0)
			if arg_26_0.changeListener then
				ClearEventTrigger = var_1

				var_1(arg_26_0.changeListener)
			end

			if arg_26_0.playerTf then
				Destroy = var_1

				var_1(arg_26_0.playerTf)

				arg_26_0.playerTf = nil
			end

			return
		end
	}

	var_3.ctor(var_1_0)

	return var_3
end

function var_0_0.Ctor(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	arg_27_0._topContent = arg_27_1
	arg_27_0._content = arg_27_2
	arg_27_0._tpl = arg_27_3
	arg_27_0._eventCall = arg_27_4

	return
end

function var_0_0.setPlayerData(arg_28_0, arg_28_1)
	if arg_28_0.player then
		local var_28_0 = arg_28_0.player

		if var_2.getId(var_28_0) ~= arg_28_1.id then
			local var_28_1 = arg_28_0.player

			var_2.dispose(var_28_1)

			arg_28_0.player = nil
			arg_28_0.player = arg_28_0:createPlayer(arg_28_1)

			goto label_28_0
		end
	end

	if not arg_28_0.player then
		arg_28_0.player = arg_28_0:createPlayer(arg_28_1)
	end

	::label_28_0::

	return
end

function var_0_0.createPlayer(arg_29_0, arg_29_1)
	tf = var_1_10002
	instantiate = var_1_10004
	findTF = var_1_10006

	local var_29_0 = var_1_10002(var_1_10004(var_1_10006(arg_29_0._tpl, arg_29_1.tpl)))
	local var_29_1 = var_0_17(var_29_0, arg_29_1, arg_29_0._eventCall)

	var_3.setContent(var_29_1, arg_29_0._content)

	return var_3
end

function var_0_0.start(arg_30_0)
	LaunchBallGameVo = var_1_10001
	arg_30_0.playerId = var_1_10001.selectPlayer

	arg_30_0:setPlayerData(var_0_1[arg_30_0.playerId])

	local var_30_0 = arg_30_0.player

	var_1.start(var_30_0)

	arg_30_0.effects = {}

	return
end

function var_0_0.step(arg_31_0)
	LaunchBallGameVo = var_1_10001

	if var_1_10001.joyStickData then
		LaunchBallGameVo = var_1

		if var_1.joyStickData.active then
			LaunchBallGameVo = var_1

			if var_1.joyStickData.angle then
				local var_31_0 = arg_31_0.player
				local var_31_1 = var_1.setAngle

				LaunchBallGameVo = var_1_10004

				var_31_1(var_31_0, var_1_10004.joyStickData.angle)
			end
		end
	end

	if arg_31_0.effects and #arg_31_0.effects > 0 then
		for iter_31_0 = #arg_31_0.effects, 1, -1 do
			local var_31_2 = arg_31_0.effects[iter_31_0].tf
			local var_31_3 = arg_31_0.effects[iter_31_0].anim
			local var_31_4 = arg_31_0.effects[iter_31_0].animName
			local var_31_5 = arg_31_0.effects[iter_31_0].removeTime

			if arg_31_0.effects[iter_31_0].time and arg_31_0.effects[iter_31_0].time > 0 then
				local var_31_6 = arg_31_0.effects[iter_31_0]
				local var_31_7 = arg_31_0.effects[iter_31_0].time

				LaunchBallGameVo = var_1_10011
				var_31_6.time = var_31_7 - var_1_10011.deltaTime

				if arg_31_0.effects[iter_31_0].time < 0 then
					local var_31_8 = arg_31_0.effects[iter_31_0]

					var_31_8.time = nil
					setActive = var_31_8

					var_31_8(var_31_2, false)

					setActive = var_31_8

					var_31_8(var_31_2, true)

					var_1_10011 = var_31_3

					var_31_3.Play(var_1_10011, var_31_4)
				end
			elseif arg_31_0.effects[iter_31_0].removeTime and arg_31_0.effects[iter_31_0].removeTime > 0 then
				local var_31_9 = arg_31_0.effects[iter_31_0]
				local var_31_10 = arg_31_0.effects[iter_31_0].removeTime

				LaunchBallGameVo = var_1_10011
				var_31_9.removeTime = var_31_10 - var_1_10011.deltaTime

				if arg_31_0.effects[iter_31_0].removeTime < 0 then
					local var_31_11 = arg_31_0.effects[iter_31_0]

					var_31_11.removeTime = nil
					setActive = var_31_11

					var_31_11(var_31_2, false)

					table = var_31_11

					var_31_11.remove(arg_31_0.effects, iter_31_0)
				end
			end
		end
	end

	local var_31_12 = arg_31_0.player

	var_1.step(var_31_12)

	return
end

function var_0_0.eventCall(arg_32_0, arg_32_1, arg_32_2)
	LaunchBallGameScene = var_1_10003

	if arg_32_1 == var_1_10003.CHANGE_AMULET then
		-- block empty
	else
		LaunchBallGameScene = var_3

		if arg_32_1 == var_3.PLAYER_EFFECT then
			if arg_32_2 then
				local var_32_0
				local var_32_1 = var_3.name

				findTF = var_1_10006

				local var_32_2 = var_1_10006(arg_32_0._topContent, "effect/" .. var_32_1)

				GetComponent = var_1_10007
				findTF = var_9

				local var_32_3 = var_9(var_32_2, "ad/anim")

				typeof = var_10
				Animator = var_12

				local var_32_4 = var_1_10007(var_32_3, var_10(var_12))
				local var_32_5 = var_3.anim
				local var_32_6 = var_3.distance

				Vector2 = var_10

				local var_32_7 = var_10(0, 0)
				local var_32_9

				if var_3.direct then
					local var_32_8 = arg_32_0.player
					local var_32_10

					var_32_9, var_32_10 = var_32_9.getDirectName(var_32_8, arg_32_0.player.angle)
					var_32_5 = var_32_5 .. "_" .. var_32_9
					Vector2 = var_13
					var_32_2.anchoredPosition = var_13(var_32_10[1] * var_32_6, var_32_10[2] * var_32_6)
				end

				table = var_32_9

				var_32_9.insert(arg_32_0.effects, {
					tf = var_32_2,
					anim = var_32_4,
					time = var_3.time,
					removeTime = var_3.remove_time,
					animName = var_32_5
				})
			end
		else
			LaunchBallGameScene = var_3

			if arg_32_1 == var_3.SPILT_ENEMY_SCORE then
				local var_32_11 = arg_32_0.player

				var_3.split(var_32_11, arg_32_2)
			end
		end
	end

	return
end

function var_0_0.press(arg_33_0, arg_33_1)
	KeyCode = var_1_10002

	if arg_33_1 == var_1_10002.J and arg_33_0.player then
		local var_33_0 = arg_33_0.player

		var_2.fire(var_33_0)
	end

	return
end

function var_0_0.joystickActive(arg_34_0, arg_34_1)
	if not arg_34_1 and arg_34_0.player then
		local var_34_0 = arg_34_0.player

		var_2.fire(var_34_0)
	end

	return
end

function var_0_0.useSkill(arg_35_0)
	if arg_35_0.player then
		local var_35_0 = arg_35_0.player

		var_1.useSkill(var_35_0)
	end

	return
end

function var_0_0.clear(arg_36_0)
	local var_36_0 = arg_36_0.player

	var_1.clear(var_36_0)

	return
end

return var_0_0
