local var_0_0 = class("NewEducateTrackCommand", pm.SimpleCommand)

var_0_0.TYPE_NEW_EDUCATE_ENTER = 10001
var_0_0.TYPE_NEW_EDUCATE_ENDING = 10002
var_0_0.TYPE_NEW_EDUCATE_PLAN = 10003
var_0_0.TYPE_NEW_EDUCATE_SITE = 10004
var_0_0.TYPE_NEW_EDUCATE_TALENT = 10005
var_0_0.TYPE_NEW_EDUCATE_POLARIOD = 10006
var_0_0.TYPE_NEW_EDUCATE_MEMORY = 10007
var_0_0.TYPE_NEW_EDUCATE_ROUND_END = 10008

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.body

	print("TRACK NEW_EDUCATE\n", table.CastToString(arg_1_1.body))

	if pg.ConnectionMgr.GetInstance():getConnection() then
		if not pg.ConnectionMgr.GetInstance():isConnected() then
			return
		end

		local var_1_1 = arg_1_1.body.args and _.map(_.range(arg_1_1.body.args.Count), function(arg_2_0)
			return var_1_0.args[arg_2_0] or 0
		end) or {}
		local var_1_2 = arg_1_1.body.strs and _.map(_.range(arg_1_1.body.strs.Count), function(arg_3_0)
			return var_1_0.strs[arg_3_0] or ""
		end) or {}

		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildNewEducate({
			track_typ = arg_1_1.body.trackType,
			int_args = var_1_1,
			str_args = var_1_2
		}))

		return
	end
end

function var_0_0.BuildDataEnter(arg_4_0, arg_4_1, arg_4_2)
	return {
		trackType = var_0_0.TYPE_NEW_EDUCATE_ENTER,
		args = {
			arg_4_0,
			arg_4_1,
			arg_4_2 or 0,
			Count = 3
		}
	}
end

function var_0_0.BuildDataEnding(arg_5_0, arg_5_1, arg_5_2)
	return {
		trackType = var_0_0.TYPE_NEW_EDUCATE_ENDING,
		args = {
			arg_5_0,
			arg_5_1,
			arg_5_2,
			Count = 3
		}
	}
end

function var_0_0.BuildDataPlan(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	return {
		trackType = var_0_0.TYPE_NEW_EDUCATE_PLAN,
		args = {
			arg_6_0,
			arg_6_1,
			arg_6_2,
			Count = 3
		},
		strs = {
			arg_6_3,
			arg_6_4,
			Count = 2
		}
	}
end

function var_0_0.BuildDataSite(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return {
		trackType = var_0_0.TYPE_NEW_EDUCATE_SITE,
		args = {
			arg_7_0,
			arg_7_1,
			arg_7_2,
			arg_7_3,
			arg_7_4,
			Count = 5
		}
	}
end

function var_0_0.BuildDataTalent(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	return {
		trackType = var_0_0.TYPE_NEW_EDUCATE_TALENT,
		args = {
			arg_8_0,
			arg_8_1,
			arg_8_2,
			arg_8_3,
			arg_8_4 or 0,
			Count = 5
		},
		strs = {
			arg_8_5,
			Count = 1
		}
	}
end

function var_0_0.BuildDataPolariod(arg_9_0, arg_9_1, arg_9_2)
	return {
		trackType = var_0_0.TYPE_NEW_EDUCATE_POLARIOD,
		args = {
			arg_9_0,
			arg_9_1,
			arg_9_2,
			Count = 3
		}
	}
end

function var_0_0.BuildDataMemory(arg_10_0, arg_10_1, arg_10_2)
	return {
		trackType = var_0_0.TYPE_NEW_EDUCATE_MEMORY,
		args = {
			arg_10_0,
			arg_10_1,
			arg_10_2,
			Count = 3
		}
	}
end

function var_0_0.BuildDataRoundEnd(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7, arg_11_8)
	return {
		trackType = var_0_0.TYPE_NEW_EDUCATE_ROUND_END,
		args = {
			arg_11_0,
			arg_11_1,
			arg_11_2,
			arg_11_3,
			arg_11_4,
			arg_11_5,
			arg_11_6,
			Count = 7
		},
		strs = {
			arg_11_7,
			arg_11_8,
			Count = 2
		}
	}
end

return var_0_0
