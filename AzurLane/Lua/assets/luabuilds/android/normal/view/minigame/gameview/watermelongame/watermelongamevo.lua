class = var_0_10000

local var_0_0 = var_0_10000("WatermelonGameVo")
local var_0_1 = 1.4

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameId = arg_1_1
	pg = var_1_10002
	arg_1_0.hubId = var_1_10002.mini_game[arg_1_0.gameId].hub_id
	pg = var_2
	arg_1_0.drop = var_2.mini_game[arg_1_0.gameId].simple_config_data.drop_ids
	pg = var_2
	arg_1_0.totalTimes = var_2.mini_game_hub[arg_1_0.hubId].reward_need
	getProxy = var_2
	MiniGameProxy = var_3

	local var_1_0 = var_2(var_3)

	arg_1_0.mgData = var_2.GetMiniGameData(var_1_0, arg_1_0.gameId)
	getProxy = var_2
	MiniGameProxy = var_1_0

	local var_1_1 = var_2(var_1_0)

	arg_1_0.mgHubData = var_2.GetHubByHubId(var_1_1, arg_1_0.hubId)
	arg_1_0.tplItemPool = {}

	return
end

function var_0_0.getGameTimes(arg_2_0)
	if arg_2_0.mgHubData then
		local var_2_0

		if not arg_2_0.mgHubData.count then
			var_2_0 = 0
		end

		return var_2_0
	end

	return 0
end

function var_0_0.getGameUseTimes(arg_3_0)
	if arg_3_0.mgHubData then
		local var_3_0

		if not arg_3_0.mgHubData.usedtime then
			var_3_0 = 0
		end

		return var_3_0
	end

	return 0
end

function var_0_0.GetGameRound(arg_4_0)
	if arg_4_0.selectRound ~= nil then
		return arg_4_0.selectRound
	end

	local var_4_0 = arg_4_0:getGameUseTimes()

	if arg_4_0:GetGameTimes() and var_2 > 0 then
		return var_4_0 + 1
	end

	if var_4_0 and var_4_0 > 0 then
		return var_4_0
	end

	return 1
end

function var_0_0.prepare(arg_5_0)
	WatermelonGameConst = var_1_10001
	arg_5_0.gameTime = var_1_10001.game_time
	arg_5_0.gameStepTime = 0
	arg_5_0.deltaTime = 0
	arg_5_0.scoreNum = 0
	arg_5_0.startSettlement = false
	arg_5_0._joyStickData = nil
	arg_5_0.createBallCd = var_0_1

	return
end

function var_0_0.setJoyStickData(arg_6_0, arg_6_1)
	arg_6_0._joyStickData = arg_6_1

	return
end

function var_0_0.getJoyStickData(arg_7_0)
	return arg_7_0._joyStickData
end

function var_0_0.setGameTpl(arg_8_0, arg_8_1)
	arg_8_0.tpl = arg_8_1

	return
end

function var_0_0.getTplItemFromPool(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_1 or arg_9_1 == "" then
		return nil
	end

	if not arg_9_2 then
		return nil
	end

	if arg_9_0.tplItemPool[arg_9_1] == nil then
		arg_9_0.tplItemPool[arg_9_1] = {}
	end

	local var_9_0

	if #arg_9_0.tplItemPool[arg_9_1] == 0 then
		tf = var_9_0
		instantiate = var_1_10004
		findTF = var_1_10005
		var_9_0 = var_9_0(var_1_10004(var_1_10005(arg_9_0.tpl, arg_9_1)))
		setParent = var_4

		var_4(var_9_0, arg_9_2)

		return var_9_0, true
	else
		table = var_9_0

		return var_9_0.remove(arg_9_0.tplItemPool[arg_9_1], #arg_9_0.tplItemPool[arg_9_1]), false
	end

	return nil, nil
end

function var_0_0.returnTplItem(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_2 or not arg_10_1 then
		return
	end

	setActive = var_1_10003

	var_1_10003(arg_10_2, false)

	table = var_1_10003

	var_1_10003.insert(arg_10_0.tplItemPool[arg_10_1], arg_10_2)

	return
end

function var_0_0.clear(arg_11_0)
	arg_11_0.tpl = nil
	arg_11_0.tplItemPool = nil

	return
end

return var_0_0
