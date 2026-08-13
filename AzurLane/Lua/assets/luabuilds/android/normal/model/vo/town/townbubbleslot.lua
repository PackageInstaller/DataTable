class = var_0_10000

local var_0_0 = var_0_10000("TownBubbleSlot")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.pos = arg_1_1
	arg_1_0.shipId = arg_1_2 or 0
	arg_1_0.startTime = arg_1_3 or 0
	pg = var_4
	arg_1_0.interval = var_4.gameset.activity_town_bubble.description[1][1]
	pg = var_4
	arg_1_0.maxCnt = var_4.gameset.activity_town_bubble.description[2][1]
	arg_1_0.passCnt = 0

	return
end

function var_0_0.OnUpdateTime(arg_2_0, arg_2_1)
	if arg_2_0.startTime ~= 0 then
		local var_2_0 = arg_2_0.passCnt

		if arg_2_0.maxCnt <= var_2_0 then
			return
		end

		math = var_2_0

		local var_2_1 = var_2_0.min

		math = var_1_10003
		arg_2_0.passCnt = var_2_1(var_1_10003.floor((arg_2_1 - arg_2_0.startTime) / arg_2_0.interval), arg_2_0.maxCnt)

		return
	end
end

function var_0_0.GetPassCnt(arg_3_0)
	return arg_3_0.passCnt
end

function var_0_0.ResetStartTime(arg_4_0, arg_4_1)
	arg_4_0.startTime = arg_4_1
	arg_4_0.passCnt = 0

	return
end

function var_0_0.GetShipId(arg_5_0)
	return arg_5_0.shipId
end

function var_0_0.IsNewEmpty(arg_6_0)
	return arg_6_0.startTime == 0
end

function var_0_0.ChangeShip(arg_7_0, arg_7_1)
	arg_7_0.shipId = arg_7_1

	if arg_7_0.startTime == 0 then
		pg = var_2

		local var_7_0 = var_2.TimeMgr.GetInstance()

		arg_7_0.startTime = var_2.GetServerTime(var_7_0)
	end

	return
end

return var_0_0
