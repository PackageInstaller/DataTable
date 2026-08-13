class = var_0_10000

local var_0_0 = "MainActMapBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_map"
end

function var_0_1.GetActivity(arg_2_0)
	if arg_2_0.config and arg_2_0.config.time and arg_2_0.config.time[1] == "default" then
		local var_2_0 = arg_2_0.config.time[2]

		getProxy = var_1_10002
		ActivityProxy = var_1_10003

		local var_2_1 = var_1_10002(var_1_10003)

		if var_2.getActivityById(var_2_1, var_2_0) and not var_2:isEnd() then
			return var_2
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
	local var_5_1 = arg_5_0:GetActivity()
	local var_5_2 = var_2.getConfig(var_5_1, "type")

	ActivityConst = var_5_1

	if var_5_0 == var_5_1.OTHER_WORLD_TERMINAL_BATTLE_ID then
		OtherworldMapScene = var_4

		do return var_4.IsShowTip() end

		goto label_5_0
	end

	ActivityConst = var_4

	if var_5_2 ~= var_4.ACTIVITY_TYPE_BOSSRUSH then
		ActivityConst = var_4

		do
			local var_5_3

			if var_5_2 == var_4.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB then
				return false
			else
				ActivityConst = var_4

				if var_5_2 == var_4.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
					getProxy = var_4
					ActivityProxy = var_5_3
					var_5_3 = var_4(var_5_3)

					if not var_4.getActivityById(var_5_3, var_2:GetBindPtActID()) then
						return false
					end

					ActivityBossPtData = var_5_3

					local var_5_4 = var_5_3.New(var_4)

					return var_5_3.CanGetAward(var_5_4)
				else
					ActivityConst = var_4

					if var_5_2 == var_4.ACTIVITY_TYPE_TOWN2 then
						return false
					end
				end
			end
		end

		::label_5_0::

		getProxy = var_4
		ChapterProxy = var_5_3

		local var_5_5 = var_4(var_5_3)
		local var_5_6

		if var_4.IsActivitySPChapterActive(var_5_5, var_5_0) then
			SettingsProxy = var_5_6
			var_5_6 = var_5_6.IsShowActivityMapSPTip()
		end

		return var_5_6
	end
end

function var_0_1.CustomOnClick(arg_6_0)
	if arg_6_0:GetActivity() then
		local var_6_0 = var_1
		local var_6_1 = var_1.getConfig(var_6_0, "type")

		ActivityConst = var_6_0

		local var_6_3

		if var_6_1 == var_6_0.ACTIVITY_TYPE_BOSSRUSH then
			pg = var_6_3

			local var_6_2 = var_6_3.m02

			var_6_3 = var_6_3.sendNotification
			GAME = var_1_10005
			var_1_10005 = var_1_10005.GO_SCENE
			SCENE = var_1_10006

			var_6_3(var_6_2, var_1_10005, var_1_10006.BOSSRUSH_MAIN)
		else
			ActivityConst = var_6_3

			if var_6_1 == var_6_3.ACTIVITY_TYPE_ZPROJECT then
				local var_6_4 = arg_6_0
				local var_6_5 = arg_6_0.emit

				NewMainMediator = var_1_10005

				var_6_5(var_6_4, var_1_10005.SKIP_ACTIVITY_MAP, var_1.id)
			end
		end
	end

	return
end

return var_0_1
