local var_0_0 = class("MusicBeatGameVo")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameId = arg_1_1
	arg_1_0.hubId = pg.mini_game[arg_1_0.gameId].hub_id
	arg_1_0.drop = pg.mini_game[arg_1_0.gameId].simple_config_data.drop_ids
	arg_1_0.totalTimes = pg.mini_game_hub[arg_1_0.hubId].reward_need
	arg_1_0.mgData = getProxy(MiniGameProxy):GetMiniGameData(arg_1_0.gameId)
	arg_1_0.mgHubData = getProxy(MiniGameProxy):GetHubByHubId(arg_1_0.hubId)
	arg_1_0.tplItemPool = {}

	return
end

function var_0_0.getGameTimes(arg_2_0)
	if arg_2_0.mgHubData then
		return arg_2_0.mgHubData.count or 0
	end

	return 0
end

function var_0_0.getGameUseTimes(arg_3_0)
	if arg_3_0.mgHubData then
		return arg_3_0.mgHubData.usedtime or 0
	end

	return 0
end

function var_0_0.GetGameRound(arg_4_0)
	if arg_4_0.selectRound ~= nil then
		return arg_4_0.selectRound
	end

	local var_4_0 = arg_4_0:getGameUseTimes()
	local var_4_1 = arg_4_0:getGameTimes()

	if var_4_1 and var_4_1 > 0 then
		return var_4_0 + 1
	end

	if var_4_0 and var_4_0 > 0 then
		return var_4_0
	end

	return 1
end

function var_0_0.prepare(arg_5_0)
	arg_5_0.gameTime = MusicBeatGameConst.game_time
	arg_5_0.gameStepTime = 0
	arg_5_0.deltaTime = 0
	arg_5_0.scoreNum = 0
	arg_5_0.startSettlement = false

	arg_5_0:setBgmPlay(false)
	arg_5_0:setCriInfo(nil)
	arg_5_0:setMapData(MusicBeatGameConst.map_data[1])

	return
end

function var_0_0.setMapData(arg_6_0, arg_6_1)
	arg_6_0._mapData = arg_6_1
	arg_6_0._nodeData = arg_6_0:getMusicNode(arg_6_0._mapData.node_lua)

	return
end

function var_0_0.getMapData(arg_7_0)
	return Clone(arg_7_0._mapData)
end

function var_0_0.getNodeData(arg_8_0)
	return Clone(arg_8_0._nodeData)
end

function var_0_0.getMusicNode(arg_9_0, arg_9_1)
	return require("view/miniGame/gameView/musicbeatgame/beat/" .. arg_9_1)
end

function var_0_0.setCriInfo(arg_10_0, arg_10_1)
	arg_10_0._criInfo = arg_10_1

	return
end

function var_0_0.getCriInfo(arg_11_0)
	return arg_11_0._criInfo
end

function var_0_0.getCriInfoTime(arg_12_0)
	if arg_12_0._criInfo then
		return arg_12_0._criInfo:GetTime()
	end

	return -1
end

function var_0_0.setBgmPlay(arg_13_0, arg_13_1)
	arg_13_0._bgmPlayFlag = arg_13_1

	return
end

function var_0_0.isBgmPlaying(arg_14_0)
	return arg_14_0._bgmPlayFlag
end

function var_0_0.setGameTpl(arg_15_0, arg_15_1)
	arg_15_0.tpl = arg_15_1

	return
end

function var_0_0.getTplItemFromPool(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_1 or arg_16_1 == "" then
		return nil
	end

	if not arg_16_2 then
		return nil
	end

	if arg_16_0.tplItemPool[arg_16_1] == nil then
		arg_16_0.tplItemPool[arg_16_1] = {}
	end

	if #arg_16_0.tplItemPool[arg_16_1] == 0 then
		local var_16_0 = tf(instantiate(findTF(arg_16_0.tpl, arg_16_1)))

		setParent(var_16_0, arg_16_2)

		return var_16_0, true
	else
		return table.remove(arg_16_0.tplItemPool[arg_16_1], #arg_16_0.tplItemPool[arg_16_1]), false
	end

	return nil, nil
end

function var_0_0.returnTplItem(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_2 or not arg_17_1 then
		return
	end

	setActive(arg_17_2, false)
	table.insert(arg_17_0.tplItemPool[arg_17_1], arg_17_2)

	return
end

function var_0_0.clear(arg_18_0)
	arg_18_0.tpl = nil
	arg_18_0.tplItemPool = nil

	return
end

return var_0_0
