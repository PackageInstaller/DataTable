class = var_0_10000

local var_0_0 = "LevelSecondMapBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_second_map"
end

function var_0_1.GetActivity(arg_2_0)
	if arg_2_0.config and arg_2_0.config.time and arg_2_0.config.time[1] == "default" then
		local var_2_0 = arg_2_0.config.time[2]

		getProxy = var_1_10002
		ActivityProxy = var_1_10004

		local var_2_1 = var_1_10002(var_1_10004)

		if var_2.getActivityById(var_2_1, var_2_0) then
			local var_2_2 = var_2

			if not var_2.isEnd(var_2_2) then
				getProxy = var_3
				ActivityProxy = var_2_2

				local var_2_3 = var_3(var_2_2)

				if var_2_0 ~= var_3.getEnterReadyActivity(var_2_3)[1] then
					return var_2
				end
			end
		end
	end

	return nil
end

function var_0_1.GetActivityID(arg_3_0)
	return arg_3_0:GetActivity() and var_1.id
end

function var_0_1.OnInit(arg_4_0)
	setActive = var_1_10001

	var_1_10001(arg_4_0.tipTr.gameObject, arg_4_0:IsShowTip())

	return
end

function var_0_1.IsShowTip(arg_5_0)
	local var_5_0 = arg_5_0:GetActivityID()

	ActivityConst = var_1_10002

	if var_5_0 == var_1_10002.OTHER_WORLD_TERMINAL_BATTLE_ID then
		OtherworldMapScene = var_2

		return var_2.IsShowTip()
	end

	getProxy = var_2
	ChapterProxy = var_1_10004

	local var_5_1 = var_2(var_1_10004)
	local var_5_2

	if var_2.IsActivitySPChapterActive(var_5_1, var_5_0) then
		SettingsProxy = var_5_2
		var_5_2 = var_5_2.IsShowActivityMapSPTip()
	end

	return var_5_2
end

function var_0_1.CustomOnClick(arg_6_0)
	if arg_6_0:GetActivity() then
		switch = var_1_10002

		local var_6_0 = var_1
		local var_6_1 = var_1.getConfig(var_6_0, "type")
		local var_6_2 = {}

		ActivityConst = var_6_0
		var_6_2[var_6_0.ACTIVITY_TYPE_ZPROJECT] = function()
			local var_7_0 = arg_6_0
			local var_7_1 = var_0.emit

			LevelMediator2 = var_2_10003

			var_7_1(var_7_0, var_2_10003.ON_ACTIVITY_MAP, var_0.id)

			return
		end
		ActivityConst = var_6
		var_6_2[var_6.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2] = function()
			local var_8_0 = arg_6_0
			local var_8_1 = var_0.emit

			LevelMediator2 = var_2_10003

			var_8_1(var_8_0, var_2_10003.ON_OPEN_ACT_BOSS_BATTLE)

			return
		end
		ActivityConst = var_6
		var_6_2[var_6.ACTIVITY_TYPE_BOSSRUSH] = function()
			local var_9_0 = arg_6_0
			local var_9_1 = var_0.emit

			LevelMediator2 = var_2_10003

			var_9_1(var_9_0, var_2_10003.ON_BOSSRUSH_MAP)

			return
		end
		ActivityConst = var_6
		var_6_2[var_6.ACTIVITY_TYPE_BOSSSINGLE] = function()
			local var_10_0 = arg_6_0
			local var_10_1 = var_0.emit

			LevelMediator2 = var_2_10003

			local var_10_2 = var_2_10003.ON_BOSSSINGLE_MAP
			local var_10_3 = {}

			OtherworldMapScene = var_2_10005
			var_10_3.mode = var_2_10005.MODE_BATTLE

			var_10_1(var_10_0, var_10_2, var_10_3)

			return
		end
		ActivityConst = var_6
		var_6_2[var_6.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE] = function()
			local var_11_0 = arg_6_0
			local var_11_1 = var_0.emit

			LevelMediator2 = var_2_10003

			var_11_1(var_11_0, var_2_10003.ON_CLUE_MAP)

			return
		end

		var_1_10002(var_6_1, var_6_2)
	end

	return
end

function var_0_1.ResPath(arg_12_0)
	return "LinkButton_mellow"
end

return var_0_1
