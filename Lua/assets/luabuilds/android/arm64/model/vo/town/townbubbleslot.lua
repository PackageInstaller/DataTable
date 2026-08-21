local var_0_0 = class("TownBubbleSlot")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.pos = arg_1_1
	arg_1_0.shipId = arg_1_2 or 0
	arg_1_0.startTime = arg_1_3 or 0
	arg_1_0.interval = pg.gameset.activity_town_bubble.description[1][1]
	arg_1_0.maxCnt = pg.gameset.activity_town_bubble.description[2][1]
	arg_1_0.passCnt = 0

	return
end

function var_0_0.OnUpdateTime(arg_2_0, arg_2_1)
	if arg_2_0.startTime == 0 or arg_2_0.passCnt >= arg_2_0.maxCnt then
		return
	end

	arg_2_0.passCnt = math.min(math.floor((arg_2_1 - arg_2_0.startTime) / arg_2_0.interval), arg_2_0.maxCnt)

	return
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
		arg_7_0.startTime = pg.TimeMgr.GetInstance():GetServerTime()
	end

	return
end

return var_0_0
