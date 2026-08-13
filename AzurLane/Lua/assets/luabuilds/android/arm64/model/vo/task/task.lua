class = var_0_10000

local var_0_0 = "Task"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

var_0_1.TYPE_SCENARIO = 1
var_0_1.TYPE_BRANCH = 2
var_0_1.TYPE_ROUTINE = 3
var_0_1.TYPE_WEEKLY = 4
var_0_1.TYPE_HIDDEN = 5
var_0_1.TYPE_ACTIVITY = 6
var_0_1.TYPE_ACTIVITY_ROUTINE = 36
var_0_1.TYPE_ACTIVITY_BRANCH = 26
var_0_1.TYPE_GUILD_WEEKLY = 12
var_0_1.TYPE_NEW_WEEKLY = 13
var_0_1.TYPE_REFLUX = 15
var_0_1.TYPE_ACTIVITY_REPEAT = 16
var_0_1.TYPE_ACTIVITY_WEEKLY = 46
var_0_1.TYPE_COMMANDER_MANUAL = 17
var_0_1.TYPE_REPEATABLE = 20

local var_0_2 = {
	"scenario",
	"branch",
	"routine",
	"weekly"
}

var_0_1.TASK_PROGRESS_UPDATE = 0
var_0_1.TASK_PROGRESS_APPEND = 1

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.id

	local var_1_0

	if not arg_1_1.progress then
		var_1_0 = 0
	end

	arg_1_0.progress = var_1_0
	arg_1_0.acceptTime = arg_1_1.accept_time

	local var_1_1

	if not arg_1_1.submit_time then
		var_1_1 = 0
	end

	arg_1_0.submitTime = var_1_1
	arg_1_0._actId = nil
	arg_1_0._autoSubmit = false

	return
end

function var_0_1.isClientTrigger(arg_2_0)
	return arg_2_0:getConfig("sub_type") > 2000 and arg_2_0:getConfig("sub_type") < 3000
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.task_data_template
end

function var_0_1.isGuildTask(arg_4_0)
	return arg_4_0:getConfig("type") == var_0_1.TYPE_GUILD_WEEKLY
end

function var_0_1.IsRoutineType(arg_5_0)
	return arg_5_0:getConfig("type") == var_0_1.TYPE_ROUTINE
end

function var_0_1.IsActRoutineType(arg_6_0)
	return arg_6_0:getConfig("type") == var_0_1.TYPE_ACTIVITY_ROUTINE
end

function var_0_1.IsActType(arg_7_0)
	return arg_7_0:getConfig("type") == var_0_1.TYPE_ACTIVITY
end

function var_0_1.IsWeeklyType(arg_8_0)
	return arg_8_0:getConfig("type") == var_0_1.TYPE_WEEKLY or arg_8_0:getConfig("type") == var_0_1.TYPE_NEW_WEEKLY
end

function var_0_1.IsBackYardInterActionType(arg_9_0)
	return arg_9_0:getConfig("sub_type") == 2010
end

function var_0_1.IsFlagShipInterActionType(arg_10_0)
	return arg_10_0:getConfig("sub_type") == 2011
end

function var_0_1.IsGuildAddLivnessType(arg_11_0)
	return arg_11_0:getConfig("type") == var_0_1.TYPE_ROUTINE or var_1 == var_0_1.TYPE_WEEKLY or var_1 == var_0_1.TYPE_GUILD_WEEKLY or var_1 == var_0_1.TYPE_NEW_WEEKLY
end

function var_0_1.IsCommanderManualType(arg_12_0)
	return arg_12_0:getConfig("type") == var_0_1.TYPE_COMMANDER_MANUAL
end

function var_0_1.isLock(arg_13_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_13_0 = var_1_10001(var_1_10003)

	return var_1.getRawData(var_13_0).level < arg_13_0:getConfig("level")
end

function var_0_1.isFinish(arg_14_0)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.getProgress(var_14_0)
	local var_14_2 = arg_14_0:getConfig("sub_type")

	TASK_SUB_TYPE_REPEATABLE = var_14_0

	if var_14_2 == var_14_0 then
		return var_14_1 >= 1
	end

	return var_14_1 >= arg_14_0:getConfig("target_num")
end

function var_0_1.getProgress(arg_15_0)
	switch = var_1_10001

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.getConfig(var_15_0, "sub_type")
	local var_15_2 = {}

	TASK_SUB_TYPE_GIVE_ITEM = var_15_0
	var_15_2[var_15_0] = function()
		tonumber = var_2_10000

		local var_16_0 = arg_15_0
		local var_16_1 = var_2_10000(var_2.getConfig(var_16_0, "target_id"))

		getProxy = var_2_10001
		BagProxy = var_2_10003

		local var_16_2 = var_2_10001(var_2_10003)
		local var_16_3 = var_1.getItemCountById

		tonumber = var_16_0

		return var_16_3(var_16_2, var_16_0(var_16_1))
	end
	TASK_SUB_TYPE_PT = var_15_0
	var_15_2[var_15_0] = function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_17_0 = var_2_10000(var_2_10002)
		local var_17_1 = var_0.getActivityById

		tonumber = var_2_10003

		local var_17_2 = arg_15_0
		local var_17_3

		if not var_17_1(var_17_0, var_2_10003(var_5.getConfig(var_17_2, "target_id_2"))) or not var_0.data1 then
			var_17_3 = 0
		end

		return var_17_3
	end
	TASK_SUB_TYPE_PLAYER_RES = var_15_0
	var_15_2[var_15_0] = function()
		tonumber = var_2_10000

		local var_18_0 = arg_15_0
		local var_18_1 = var_2_10000(var_2.getConfig(var_18_0, "target_id"))

		getProxy = var_2_10001
		PlayerProxy = var_2_10003

		local var_18_2 = var_2_10001(var_2_10003)
		local var_18_3 = var_1.getData(var_18_2)

		return var_1.getResById(var_18_3, var_18_1)
	end
	TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM = var_15_0
	var_15_2[var_15_0] = function()
		tonumber = var_2_10000

		local var_19_0 = arg_15_0
		local var_19_1 = var_2_10000(var_2.getConfig(var_19_0, "target_id"))

		getProxy = var_2_10001
		ActivityProxy = var_2_10003

		local var_19_2 = var_2_10001(var_2_10003)

		return var_1.getVirtualItemNumber(var_19_2, var_19_1)
	end
	TASK_SUB_TYPE_BOSS_PT = var_15_0
	var_15_2[var_15_0] = function()
		tonumber = var_2_10000

		local var_20_0 = arg_15_0
		local var_20_1 = var_2_10000(var_2.getConfig(var_20_0, "target_id"))

		getProxy = var_2_10001
		PlayerProxy = var_2_10003

		local var_20_2 = var_2_10001(var_2_10003)
		local var_20_3 = var_1.getData(var_20_2)

		return var_1.getResById(var_20_3, var_20_1)
	end
	TASK_SUB_STROY = var_15_0
	var_15_2[var_15_0] = function()
		local var_21_0 = arg_15_0
		local var_21_1 = var_0.getConfig(var_21_0, "target_id")
		local var_21_2 = 0

		_ = var_21_0

		var_21_0.each(var_21_1, function(arg_22_0)
			pg = var_3_10001

			local var_22_0 = var_3_10001.NewStoryMgr.GetInstance()

			if var_1.GetPlayedFlag(var_22_0, arg_22_0) then
				var_21_2 = var_21_2 + 1
			end

			return
		end)

		return var_21_2
	end
	TASK_SUB_TYPE_TECHNOLOGY_POINT = var_15_0
	var_15_2[var_15_0] = function()
		math = var_2_10000

		local var_23_0 = var_2_10000.min

		getProxy = var_2_10002
		TechnologyNationProxy = var_2_10004

		local var_23_1 = var_2_10002(var_2_10004)
		local var_23_2 = var_2.getNationPoint

		tonumber = var_2_10005

		local var_23_3 = arg_15_0
		local var_23_4 = var_23_2(var_23_1, var_2_10005(var_7.getConfig(var_23_3, "target_id")))
		local var_23_5 = arg_15_0

		return var_23_0(var_23_4, var_3.getConfig(var_23_5, "target_num"))
	end
	TASK_SUB_TYPE_VITEM = var_15_0
	var_15_2[var_15_0] = function()
		tonumber = var_2_10000

		local var_24_0 = arg_15_0
		local var_24_1 = var_2_10000(var_2.getConfig(var_24_0, "target_id"))

		tonumber = var_2_10001

		local var_24_2 = arg_15_0
		local var_24_3 = var_2_10001(var_3.getConfig(var_24_2, "target_id_2"))

		pg = var_2

		local var_24_4 = var_2.activity_drop_type[var_24_1].activity_id

		getProxy = var_3
		ActivityProxy = var_24_2

		local var_24_5 = var_3(var_24_2)

		if var_3.getActivityById(var_24_5, var_24_4) then
			return var_3:getVitemNumber(var_24_3)
		end

		return
	end
	TASK_SUB_TYPE_VITEMS = var_15_0
	var_15_2[var_15_0] = function()
		tonumber = var_2_10000

		local var_25_0 = arg_15_0
		local var_25_1 = var_2_10000(var_2.getConfig(var_25_0, "target_id"))

		underscore = var_2_10001

		local var_25_2 = var_2_10001.all
		local var_25_3 = arg_15_0

		if var_25_2(var_3.getConfig(var_25_3, "target_id_2"), function(arg_26_0)
			Drop = var_3_10001

			local var_26_0 = var_3_10001.New({
				type = var_25_1,
				id = arg_26_0[1],
				count = arg_26_0[2]
			})

			return var_1.getOwnedCount(var_26_0) >= var_1.count
		end) then
			return 1
		end

		return
	end
	TASK_SUB_TYPE_JOIN_GUILD = var_15_0
	var_15_2[var_15_0] = function()
		getProxy = var_2_10000
		GuildProxy = var_2_10002

		local var_27_0 = var_2_10000(var_2_10002)

		return var_0.getData(var_27_0) and 1 or 0
	end
	TASK_SUB_TYPE_COLLAB_BOSS_RUSH_DEFEAT = var_15_0
	var_15_2[var_15_0] = function()
		tonumber = var_2_10000

		local var_28_0 = arg_15_0
		local var_28_1 = var_2_10000(var_2.getConfig(var_28_0, "target_id"))

		getProxy = var_2_10001
		ActivityProxy = var_2_10003

		local var_28_2 = var_2_10001(var_2_10003)
		local var_28_3 = var_1.getActivityByType

		ActivityConst = var_28_0

		if not var_28_3(var_28_2, var_28_0.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB) then
			return 0
		end

		local var_28_4 = var_1:GetCollabSeriesDataList()

		pairs = var_28_2

		for iter_28_0, iter_28_1 in var_28_2(var_28_4) do
			if iter_28_1:GetCollabBossID() == var_28_1 then
				return iter_28_1:GetBossTimeStamp() ~= 0 and 1 or 0
			end
		end

		return 0
	end
	TASK_SUB_TYPE_REPEATABLE = var_15_0
	var_15_2[var_15_0] = function()
		return arg_15_0.progress >= 1 and 1 or 0
	end

	local var_15_3

	if not var_1_10001(var_15_1, var_15_2, function()
		return arg_15_0.progress
	end) then
		var_15_3 = 0
	end

	return var_15_3
end

function var_0_1.getTargetNumber(arg_31_0)
	return arg_31_0:getConfig("target_num")
end

function var_0_1.isReceive(arg_32_0)
	return arg_32_0.submitTime > 0
end

function var_0_1.isCircle(arg_33_0)
	if arg_33_0:isActivityTask() then
		if arg_33_0:getConfig("type") == 16 and arg_33_0:getConfig("sub_type") == 1006 then
			return true
		elseif arg_33_0:getConfig("type") == 16 and arg_33_0:getConfig("sub_type") == 20 then
			return true
		elseif arg_33_0:getConfig("type") == 16 and arg_33_0:getConfig("sub_type") == 1007 then
			return true
		elseif arg_33_0:getConfig("type") == 16 and arg_33_0:getConfig("sub_type") == 122 then
			return true
		end
	end

	return false
end

function var_0_1.isDaily(arg_34_0)
	return arg_34_0:getConfig("sub_type") == 31 or arg_34_0:getConfig("sub_type") == 28
end

function var_0_1.getTaskStatus(arg_35_0)
	if arg_35_0:isLock() then
		return -1
	end

	if arg_35_0:isReceive() then
		return 2
	end

	if arg_35_0:isFinish() then
		return 1
	end

	return 0
end

function var_0_1.onAdded(arg_36_0)
	local function var_36_0()
		local var_37_0 = arg_36_0

		if var_0.getConfig(var_37_0, "sub_type") == 29 then
			getProxy = var_0
			SkirmishProxy = var_37_0

			local var_37_1 = var_0(var_37_0)
			local var_37_2 = var_0.getRawData(var_37_1)

			_ = var_2_10001

			if var_2_10001.any(var_37_2, function(arg_38_0)
				return arg_38_0:getConfig("task_id") == arg_36_0.id
			end) then
				return
			end

			pg = var_1

			local var_37_3 = var_1.m02
			local var_37_4 = var_1.sendNotification

			GAME = var_4

			var_37_4(var_37_3, var_4.TASK_GO, {
				taskVO = arg_36_0
			})
		else
			local var_37_5 = arg_36_0
			local var_37_6 = var_0.getConfig(var_37_5, "added_tip")

			if 0 < var_37_6 then
				local var_37_7

				getProxy = var_1
				ContextProxy = var_3

				local var_37_8 = var_1(var_3)
				local var_37_9 = var_1.getCurrentContext(var_37_8).mediator.__cname

				TaskMediator = var_37_8

				if var_37_9 ~= var_37_8.__cname then
					function var_37_7()
						pg = var_3_10000

						local var_39_0 = var_3_10000.m02
						local var_39_1 = var_0.sendNotification

						GAME = var_3_10003

						local var_39_2 = var_3_10003.GO_SCENE

						SCENE = var_3_10004

						local var_39_3 = var_3_10004.TASK
						local var_39_4 = {}
						local var_39_5 = var_0_2
						local var_39_6 = arg_36_0

						var_39_4.page = var_39_5[var_7.GetRealType(var_39_6)]

						var_39_1(var_39_0, var_39_2, var_39_3, var_39_4)

						return
					end
				end

				pg = var_37_9

				local var_37_10 = var_37_9.MsgboxMgr.GetInstance()
				local var_37_11 = var_3.ShowMsgBox
				local var_37_12 = {
					noText = "text_iknow",
					yesText = "text_forward"
				}

				i18n = var_2_10007

				local var_37_13 = "tip_add_task"
				local var_37_14 = arg_36_0

				var_37_12.content = var_2_10007(var_37_13, var_10.getConfig(var_37_14, "name"))
				var_37_12.onYes = var_37_7

				var_37_11(var_37_10, var_37_12)
			end
		end

		local var_37_15 = arg_36_0

		if var_0.IsCommanderManualType(var_37_15) then
			getProxy = var_0
			CommanderManualProxy = var_37_15

			local var_37_16 = var_0(var_37_15)

			var_0.AddPageTaskDone(var_37_16, arg_36_0)
		end

		return
	end

	local function var_36_1()
		getProxy = var_2_10000
		ContextProxy = var_2_10002

		local var_40_0 = var_2_10000(var_2_10002)
		local var_40_1 = var_0.getCurrentContext(var_40_0)

		table = var_2_10001

		if not var_2_10001.contains({
			"LevelScene",
			"BattleScene",
			"EventListScene",
			"MilitaryExerciseScene",
			"DailyLevelScene"
		}, var_40_1.viewComponent.__cname) then
			return true
		end

		return false
	end

	if arg_36_0:getConfig("story_id") and var_3 ~= "" and var_36_1() then
		pg = var_4

		local var_36_2 = var_4.NewStoryMgr.GetInstance()

		var_4.Play(var_36_2, var_3, var_36_0, true, true)
	else
		var_36_0()
	end

	return
end

function var_0_1.updateProgress(arg_41_0, arg_41_1)
	arg_41_0.progress = arg_41_1

	return
end

function var_0_1.isSelectable(arg_42_0)
	if arg_42_0:getConfig("award_choice") ~= nil then
		type = var_1_10002

		local var_42_0

		if var_1_10002(var_1) ~= "table" or not (#var_1 > 0) then
			var_42_0 = false
		else
			var_42_0 = true
		end

		return var_42_0
	end
end

function var_0_1.judgeOverflow(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = arg_43_0:getTaskStatus() == 1
	local var_43_1 = arg_43_0:ShowOnTaskScene()

	return var_0_1.StaticJudgeOverflow(arg_43_1, arg_43_2, arg_43_3, var_43_0, var_43_1, arg_43_0:getConfig("award_display"))
end

function var_0_1.StaticJudgeOverflow(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5)
	if arg_44_3 and arg_44_4 then
		getProxy = var_1_10006
		PlayerProxy = var_1_10008

		local var_44_0 = var_1_10006(var_1_10008)
		local var_44_1 = var_6.getData(var_44_0)

		pg = var_1_10007

		local var_44_2 = var_1_10007.gameset.urpt_chapter_max.description[1]
		local var_44_3 = arg_44_0 or var_44_1.gold
		local var_44_4 = arg_44_1 or var_44_1.oil

		if not arg_44_2 then
			::label_44_0::

			LOCK_UR_SHIP = var_1_10010

			if not var_1_10010 then
				getProxy = var_1_10010
				BagProxy = var_1_10012
				var_1_10012 = var_1_10010(var_1_10012)

				if not var_1_10010.GetLimitCntById(var_1_10012, var_44_2) then
					var_1_10010 = 0
				end

				pg = var_1_10011

				local var_44_5 = var_1_10011.gameset.max_gold.key_value

				pg = var_1_10012

				local var_44_6 = var_1_10012.gameset.max_oil.key_value

				LOCK_UR_SHIP = var_1_10013

				if not var_1_10013 then
					pg = var_1_10013

					local var_44_7

					if not var_1_10013.gameset.urpt_chapter_max.description[2] then
						var_44_7 = 0
					end

					local var_44_8 = false
					local var_44_9 = false
					local var_44_10 = false
					local var_44_11 = false
					local var_44_12 = false
					local var_44_13 = {}
					local var_44_14 = arg_44_5

					ipairs = var_1_10021

					for iter_44_0, iter_44_1 in var_1_10021(var_44_14) do
						unpack = var_1_10026

						local var_44_15, var_44_16

						var_1_10026, var_44_15, var_44_16 = var_1_10026(iter_44_1)
						DROP_TYPE_RESOURCE = var_1_10029

						if var_1_10026 == var_1_10029 then
							PlayerConst = var_1_10029

							if var_44_15 == var_1_10029.ResGold then
								var_1_10029 = var_44_3 + var_44_16 - var_44_5

								if 0 < var_1_10029 then
									var_44_8 = true
									var_1_10030 = {}
									DROP_TYPE_RESOURCE = var_1_10031
									var_1_10030.type = var_1_10031
									PlayerConst = var_1_10031
									var_1_10030.id = var_1_10031.ResGold
									setColorStr = var_1_10031

									local var_44_17 = var_1_10029

									COLOR_RED = var_1_10034
									var_1_10030.count = var_1_10031(var_44_17, var_1_10034)
									table = var_1_10031

									var_1_10031.insert(var_44_13, var_1_10030)
								end
							else
								PlayerConst = var_1_10029

								if var_44_15 == var_1_10029.ResOil then
									var_1_10029 = var_44_4 + var_44_16 - var_44_6

									if 0 < var_1_10029 then
										var_44_9 = true
										var_1_10030 = {}
										DROP_TYPE_RESOURCE = var_1_10031
										var_1_10030.type = var_1_10031
										PlayerConst = var_1_10031
										var_1_10030.id = var_1_10031.ResOil
										setColorStr = var_1_10031

										local var_44_18 = var_1_10029

										COLOR_RED = var_1_10034
										var_1_10030.count = var_1_10031(var_44_18, var_1_10034)
										table = var_1_10031

										var_1_10031.insert(var_44_13, var_1_10030)
									end
								end
							end
						else
							LOCK_UR_SHIP = var_1_10029

							if not var_1_10029 then
								DROP_TYPE_VITEM = var_1_10029

								if var_1_10026 == var_1_10029 then
									Item = var_1_10029

									if var_1_10029.getConfigData(var_44_15).virtual_type == 20 then
										var_1_10030 = var_1_10010 + var_44_16 - var_44_7

										if 0 < var_1_10030 then
											var_44_10 = true
											var_1_10031 = {}
											DROP_TYPE_VITEM = var_1_10032
											var_1_10031.type = var_1_10032
											var_1_10031.id = var_44_2
											setColorStr = var_1_10032
											var_1_10034 = var_1_10030
											COLOR_RED = var_1_10035
											var_1_10031.count = var_1_10032(var_1_10034, var_1_10035)
											table = var_1_10032

											var_1_10032.insert(var_44_13, var_1_10031)
										end
									end

									goto label_44_1
								end
							end

							DROP_TYPE_ITEM = var_1_10029

							if var_1_10026 == var_1_10029 then
								Item = var_1_10029
								var_1_10029 = var_1_10029.getConfigData(var_44_15).type
								Item = var_1_10030

								if var_1_10029 == var_1_10030.EXP_BOOK_TYPE then
									getProxy = var_1_10029
									BagProxy = var_1_10031
									var_1_10031 = var_1_10029(var_1_10031)
									var_1_10029 = var_1_10029.getItemCountById(var_1_10031, var_44_15) + var_44_16
									Item = var_1_10030

									if var_1_10030.getConfigData(var_44_15).max_num < var_1_10029 then
										var_44_11 = true
										var_1_10031 = {}
										DROP_TYPE_ITEM = var_1_10032
										var_1_10031.type = var_1_10032
										var_1_10031.id = var_44_15
										setColorStr = var_1_10032
										math = var_1_10034
										var_1_10034 = var_1_10034.min(var_44_16, var_1_10029 - var_1_10030)
										COLOR_RED = var_1_10035
										var_1_10031.count = var_1_10032(var_1_10034, var_1_10035)
										table = var_1_10032

										var_1_10032.insert(var_44_13, var_1_10031)
									end
								end
							end
						end

						::label_44_1::
					end

					do return var_44_8 or var_44_9 or var_44_10 or var_44_11, var_44_13 end
					return
				end
			end
		end
	end
end

function var_0_1.IsUrTask(arg_45_0)
	LOCK_UR_SHIP = var_1_10001

	if not var_1_10001 then
		pg = var_1_10001

		local var_45_0 = var_1_10001.gameset.urpt_chapter_max.description[1]

		_ = var_1_10003

		do return var_1_10003.any(arg_45_0:getConfig("award_display"), function(arg_46_0)
			local var_46_0 = arg_46_0[1]

			DROP_TYPE_ITEM = var_2_10002

			return var_46_0 == var_2_10002 and arg_46_0[2] == var_45_0
		end) end
		return
	end

	return false
end

function var_0_1.GetRealType(arg_47_0)
	local var_47_0

	if arg_47_0:getConfig("priority_type") == 0 then
		var_47_0 = arg_47_0:getConfig("type")
	end

	return var_47_0
end

function var_0_1.IsOverflowShipExpItem(arg_48_0)
	local function var_48_0(arg_49_0, arg_49_1)
		getProxy = var_2_10002
		BagProxy = var_2_10004

		local var_49_0 = var_2_10002(var_2_10004)
		local var_49_1 = var_2.getItemCountById(var_49_0, arg_49_0) + arg_49_1

		Item = var_2_10003

		return var_49_1 > var_2_10003.getConfigData(arg_49_0).max_num
	end

	local var_48_1 = arg_48_0:getConfig("award_display")

	ipairs = var_1_10003

	for iter_48_0, iter_48_1 in var_1_10003(var_48_1) do
		local var_48_2 = iter_48_1[1]
		local var_48_3 = iter_48_1[2]
		local var_48_4 = iter_48_1[3]

		DROP_TYPE_ITEM = var_1_10011

		if var_48_2 == var_1_10011 then
			Item = var_1_10011
			var_1_10011 = var_1_10011.getConfigData(var_48_3).type
			Item = var_1_10012

			if var_1_10011 == var_1_10012.EXP_BOOK_TYPE and var_48_0(var_48_3, var_48_4) then
				return true
			end
		end
	end

	return false
end

function var_0_1.ShowOnTaskScene(arg_50_0)
	local var_50_0 = arg_50_0:getConfig("visibility") == 1

	if arg_50_0.id == 17268 then
		var_50_0 = false
		getProxy = var_2
		ActivityProxy = var_4

		local var_50_1 = var_2(var_4)
		local var_50_2 = var_2.getActivityById

		ActivityConst = var_1_10005

		if var_50_2(var_50_1, var_1_10005.BUILDING_NEWYEAR_2022) and not var_2:isEnd() then
			local var_50_3

			if not var_2.data1KeyValueList[2][17] then
				var_50_3 = 1
			end

			local var_50_4

			if not var_2.data1KeyValueList[2][18] then
				var_50_4 = 1
			end

			var_50_0 = var_50_3 >= 4 and var_50_4 >= 4
		end
	end

	return var_50_0
end

function var_0_1.setTaskFinish(arg_51_0)
	arg_51_0.submitTime = 1

	arg_51_0:updateProgress(arg_51_0:getConfig("target_num"))

	return
end

function var_0_1.isAvatarTask(arg_52_0)
	return false
end

function var_0_1.getActId(arg_53_0)
	return arg_53_0._actId
end

function var_0_1.setActId(arg_54_0, arg_54_1)
	arg_54_0._actId = arg_54_1

	return
end

function var_0_1.isActivityTask(arg_55_0)
	local var_55_0

	if arg_55_0._actId then
		var_55_0 = arg_55_0._actId > 0
	end

	return var_55_0
end

function var_0_1.setAutoSubmit(arg_56_0, arg_56_1)
	arg_56_0._autoSubmit = arg_56_1

	return
end

function var_0_1.getAutoSubmit(arg_57_0)
	return arg_57_0._autoSubmit
end

function var_0_1.getGiveDrops(arg_58_0)
	local var_58_0 = {}
	local var_58_1 = arg_58_0:getConfig("sub_type")

	TASK_SUB_TYPE_VITEMS = var_1_10003

	if var_58_1 == var_1_10003 then
		tonumber = var_58_1

		local var_58_2 = var_58_1(arg_58_0:getConfig("target_id"))

		ipairs = var_1_10003

		for iter_58_0, iter_58_1 in var_1_10003(arg_58_0:getConfig("target_id_2")) do
			table = var_58_3

			local var_58_3 = var_58_3.insert
			local var_58_4 = var_58_0

			Drop = var_1_10011

			var_58_3(var_58_4, var_1_10011.New({
				type = var_58_2,
				id = iter_58_1[1],
				count = iter_58_1[2]
			}))
		end
	end

	return var_58_0
end

function var_0_1.OwnSpAward(arg_59_0)
	local function var_59_0(arg_60_0)
		getProxy = var_2_10001
		DormProxy = var_2_10003

		local var_60_0 = var_2_10001(var_2_10003)
		local var_60_1 = var_1.getData(var_60_0)

		return var_1.GetOwnFurnitureCount(var_60_1, arg_60_0) > 0
	end

	local function var_59_1(arg_61_0)
		getProxy = var_2_10001
		CollectionProxy = var_2_10003

		local var_61_0 = var_2_10001(var_2_10003)
		local var_61_1

		if var_1.GetTrophyById(var_61_0, arg_61_0) and not var_1:canClaimed() then
			var_61_1 = var_1:isClaimed()
		end

		return var_61_1
	end

	local function var_59_2(arg_62_0)
		getProxy = var_2_10001
		PlayerProxy = var_2_10003

		local var_62_0 = var_2_10001(var_2_10003)
		local var_62_1 = var_1.getRawData(var_62_0)
		local var_62_2 = var_1.getActivityMedalGroup(var_62_1)

		pairs = var_62_0

		for iter_62_0, iter_62_1 in var_62_0(var_62_2) do
			if iter_62_1:OwnMedel(arg_62_0) then
				return true
			end
		end

		return false
	end

	local var_59_3 = ({
		type = arg_59_0[1],
		id = arg_59_0[2],
		count = arg_59_0[3]
	}).type

	DROP_TYPE_FURNITURE = var_1_10006

	if var_59_3 == var_1_10006 then
		return var_59_0(var_4.id)
	else
		local var_59_4 = var_4.type

		DROP_TYPE_VITEM = var_1_10006

		if var_59_4 == var_1_10006 then
			pg = var_59_4

			local var_59_5 = var_59_4.item_virtual_data_statistics[var_4.id].album_config

			type = var_6

			if var_6(var_59_5) == "table" then
				local var_59_6 = var_59_5[1]
				local var_59_7 = var_59_5[2]

				if var_59_6 == 1 then
					return var_59_1(var_59_7)
				elseif var_59_6 == 2 then
					return var_59_2(var_59_7)
				end
			end
		end
	end

	return false
end

return var_0_1
