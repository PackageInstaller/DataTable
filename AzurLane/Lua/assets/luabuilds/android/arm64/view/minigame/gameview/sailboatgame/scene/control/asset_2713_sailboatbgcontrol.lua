class = var_0_10000

local var_0_0 = var_0_10000("SailBoatBgControl")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	SailBoatGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._followTarget = nil
	arg_1_0._backGrounds = {}
	arg_1_0._bgs = {}
	arg_1_0._bgPool = {}
	Vector2 = var_3
	arg_1_0._bgMoveSpeed = var_3(0, 0)
	Vector2 = var_3
	arg_1_0._bgMoveAmount = var_3(0, 0)

	return
end

function var_0_0.start(arg_2_0)
	for iter_2_0 = #arg_2_0._bgs, 1, -1 do
		table = var_1_10005

		local var_2_0 = var_1_10005.remove(arg_2_0._bgs, iter_2_0)

		var_1_10005.clear(var_2_0)

		table = var_6

		var_6.insert(arg_2_0._bgPool, var_1_10005)
	end

	Vector2 = var_1
	arg_2_0._bgMoveAmount = var_1(0, 0)

	arg_2_0:initBgRound()

	for iter_2_1 = 1, #arg_2_0._bgs do
		local var_2_1 = arg_2_0._bgs[iter_2_1]

		var_5.start(var_2_1)
	end

	arg_2_0._bgMoveSpeed.x = var_0_1.moveAmount.x
	arg_2_0._bgMoveSpeed.y = var_0_1.moveAmount.y

	var_0_1.SetGameBgs(arg_2_0._bgs)

	return
end

function var_0_0.step(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1.GetSceneSpeed()

	arg_3_0._bgMoveAmount.x = arg_3_0._bgMoveAmount.x + var_3_0.x
	arg_3_0._bgMoveAmount.y = arg_3_0._bgMoveAmount.y + var_3_0.y

	for iter_3_0 = 1, #arg_3_0._bgs do
		local var_3_1 = arg_3_0._bgs[iter_3_0]

		var_7.setMoveAmount(var_3_1, arg_3_0._bgMoveAmount)

		local var_3_2 = arg_3_0._bgs[iter_3_0]

		var_7.step(var_3_2)
	end

	return
end

function var_0_0.setTarget(arg_4_0, arg_4_1)
	arg_4_0._followTarget = arg_4_1

	return
end

function var_0_0.setBackGround(arg_5_0, arg_5_1)
	return
end

function var_0_0.clear(arg_6_0)
	return
end

function var_0_0.getBgRoundData(arg_7_0, arg_7_1)
	local var_7_0 = 1

	SailBoatGameConst = var_1_10003

	for iter_7_0 = var_7_0, #var_1_10003.game_bg_round do
		SailBoatGameConst = var_1_10006

		if var_1_10006.game_bg_round[iter_7_0].round == arg_7_1 then
			Clone = var_7

			return var_7(var_1_10006)
		end
	end

	return nil
end

function var_0_0.initBgRound(arg_8_0)
	if not var_0_1.GetRoundData() then
		return
	end

	for iter_8_0 = 1, #var_1.bg_rule do
		SailBoatGameConst = var_1_10006
		var_1_10006 = var_1_10006.bg_rule[var_1.bg_rule[iter_8_0]]

		local var_8_0 = arg_8_0:createAndInitBg(var_1_10006)

		table = var_1_10008

		var_1_10008.insert(arg_8_0._bgs, var_8_0)
	end

	return
end

function var_0_0.createAndInitBg(arg_9_0, arg_9_1)
	local var_9_0

	if arg_9_0._bgPool and #arg_9_0._bgPool > 0 then
		table = var_3
		var_9_0 = var_3.remove(arg_9_0._bgPool, 1)
	end

	if not var_9_0 then
		SailBoatBg = var_3
		var_9_0 = var_3.New(arg_9_0._tf, arg_9_0._event)
	end

	var_9_0:setRuleData(arg_9_1)

	return var_9_0
end

function var_0_0.useTestBgMove(arg_10_0)
	return
end

function var_0_0.dispose(arg_11_0)
	return
end

return var_0_0
