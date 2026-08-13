class = var_0_10000

local var_0_0 = "NewEducateTrackCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

var_0_1.TYPE_NEW_EDUCATE_ENTER = 10001
var_0_1.TYPE_NEW_EDUCATE_ENDING = 10002
var_0_1.TYPE_NEW_EDUCATE_PLAN = 10003
var_0_1.TYPE_NEW_EDUCATE_SITE = 10004
var_0_1.TYPE_NEW_EDUCATE_TALENT = 10005
var_0_1.TYPE_NEW_EDUCATE_POLARIOD = 10006
var_0_1.TYPE_NEW_EDUCATE_MEMORY = 10007
var_0_1.TYPE_NEW_EDUCATE_ROUND_END = 10008

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.body

	print = var_1_10003

	local var_1_1 = "TRACK NEW_EDUCATE\n"

	table = var_1_10006

	var_1_10003(var_1_1, var_1_10006.CastToString(var_1_0))

	pg = var_1_10003

	local var_1_2 = var_1_10003.ConnectionMgr.GetInstance()

	if var_3.getConnection(var_1_2) then
		pg = var_3
		var_1_2 = var_3.ConnectionMgr.GetInstance()

		if not var_3.isConnected(var_1_2) then
			return
		end

		if var_1_0.args then
			_ = var_3

			local var_1_3 = var_3.map

			_ = var_1_2

			local var_1_4

			if not var_1_3(var_1_2.range(var_1_0.args.Count), function(arg_2_0)
				local var_2_0

				if not var_1_0.args[arg_2_0] then
					var_2_0 = 0
				end

				return var_2_0
			end) then
				var_1_4 = {}
			end

			if var_1_0.strs then
				_ = var_4

				local var_1_5 = var_4.map

				_ = var_6

				local var_1_6

				if not var_1_5(var_6.range(var_1_0.strs.Count), function(arg_3_0)
					local var_3_0

					if not var_1_0.strs[arg_3_0] then
						var_3_0 = ""
					end

					return var_3_0
				end) then
					var_1_6 = {}
				end

				pg = var_1_2

				local var_1_7 = var_1_2.GameTrackerMgr.GetInstance()
				local var_1_8 = var_5.Record

				GameTrackerBuilder = var_8

				var_1_8(var_1_7, var_8.BuildNewEducate({
					track_typ = var_1_0.trackType,
					int_args = var_1_4,
					str_args = var_1_6
				}))

				return
			end
		end
	end
end

function var_0_1.BuildDataEnter(arg_4_0, arg_4_1, arg_4_2)
	return {
		trackType = var_0_1.TYPE_NEW_EDUCATE_ENTER,
		args = {
			arg_4_0,
			arg_4_1,
			arg_4_2 or 0,
			Count = 3
		}
	}
end

function var_0_1.BuildDataEnding(arg_5_0, arg_5_1, arg_5_2)
	return {
		trackType = var_0_1.TYPE_NEW_EDUCATE_ENDING,
		args = {
			arg_5_0,
			arg_5_1,
			arg_5_2,
			Count = 3
		}
	}
end

function var_0_1.BuildDataPlan(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	return {
		trackType = var_0_1.TYPE_NEW_EDUCATE_PLAN,
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

function var_0_1.BuildDataSite(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return {
		trackType = var_0_1.TYPE_NEW_EDUCATE_SITE,
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

function var_0_1.BuildDataTalent(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	return {
		trackType = var_0_1.TYPE_NEW_EDUCATE_TALENT,
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

function var_0_1.BuildDataPolariod(arg_9_0, arg_9_1, arg_9_2)
	return {
		trackType = var_0_1.TYPE_NEW_EDUCATE_POLARIOD,
		args = {
			arg_9_0,
			arg_9_1,
			arg_9_2,
			Count = 3
		}
	}
end

function var_0_1.BuildDataMemory(arg_10_0, arg_10_1, arg_10_2)
	return {
		trackType = var_0_1.TYPE_NEW_EDUCATE_MEMORY,
		args = {
			arg_10_0,
			arg_10_1,
			arg_10_2,
			Count = 3
		}
	}
end

function var_0_1.BuildDataRoundEnd(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7, arg_11_8)
	return {
		trackType = var_0_1.TYPE_NEW_EDUCATE_ROUND_END,
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

return var_0_1
