local MusicBeatGameVo = class("MusicBeatGameVo")

function MusicBeatGameVo:Ctor(arg_1_1)
	self.gameId = arg_1_1
	self.hubId = pg.mini_game[self.gameId].hub_id
	self.drop = pg.mini_game[self.gameId].simple_config_data.drop_ids
	self.totalTimes = pg.mini_game_hub[self.hubId].reward_need
	self.mgData = getProxy(MiniGameProxy):GetMiniGameData(self.gameId)
	self.mgHubData = getProxy(MiniGameProxy):GetHubByHubId(self.hubId)
	self.tplItemPool = {}

	return
end

function MusicBeatGameVo:getGameTimes()
	if self.mgHubData then
		return self.mgHubData.count or 0
	end

	return 0
end

function MusicBeatGameVo:getGameUseTimes()
	if self.mgHubData then
		return self.mgHubData.usedtime or 0
	end

	return 0
end

function MusicBeatGameVo:GetGameRound()
	if self.selectRound ~= nil then
		return self.selectRound
	end

	local var_4_0 = self:getGameUseTimes()
	local var_4_1 = self:getGameTimes()

	if var_4_1 and var_4_1 > 0 then
		return var_4_0 + 1
	end

	if var_4_0 and var_4_0 > 0 then
		return var_4_0
	end

	return 1
end

function MusicBeatGameVo:prepare()
	self.gameTime = MusicBeatGameConst.game_time
	self.gameStepTime = 0
	self.deltaTime = 0
	self.scoreNum = 0
	self.startSettlement = false

	self:setBgmPlay(false)
	self:setCriInfo(nil)
	self:setMapData(MusicBeatGameConst.map_data[1])

	return
end

function MusicBeatGameVo:setMapData(arg_6_1)
	self._mapData = arg_6_1
	self._nodeData = self:getMusicNode(self._mapData.node_lua)

	return
end

function MusicBeatGameVo:getMapData()
	return Clone(self._mapData)
end

function MusicBeatGameVo:getNodeData()
	return Clone(self._nodeData)
end

function MusicBeatGameVo:getMusicNode(arg_9_1)
	return require("view/miniGame/gameView/musicbeatgame/beat/" .. arg_9_1)
end

function MusicBeatGameVo:setCriInfo(arg_10_1)
	self._criInfo = arg_10_1

	return
end

function MusicBeatGameVo:getCriInfo()
	return self._criInfo
end

function MusicBeatGameVo:getCriInfoTime()
	if self._criInfo then
		return self._criInfo:GetTime()
	end

	return -1
end

function MusicBeatGameVo:setBgmPlay(arg_13_1)
	self._bgmPlayFlag = arg_13_1

	return
end

function MusicBeatGameVo:isBgmPlaying()
	return self._bgmPlayFlag
end

function MusicBeatGameVo:setGameTpl(arg_15_1)
	self.tpl = arg_15_1

	return
end

function MusicBeatGameVo:getTplItemFromPool(arg_16_1, arg_16_2)
	if not arg_16_1 or arg_16_1 == "" then
		return nil
	end

	if not arg_16_2 then
		return nil
	end

	if self.tplItemPool[arg_16_1] == nil then
		self.tplItemPool[arg_16_1] = {}
	end

	if #self.tplItemPool[arg_16_1] == 0 then
		local var_16_0 = tf(instantiate(findTF(self.tpl, arg_16_1)))

		setParent(var_16_0, arg_16_2)

		return var_16_0, true
	else
		return table.remove(self.tplItemPool[arg_16_1], #self.tplItemPool[arg_16_1]), false
	end

	return nil, nil
end

function MusicBeatGameVo:returnTplItem(arg_17_1, arg_17_2)
	if not arg_17_2 or not arg_17_1 then
		return
	end

	setActive(arg_17_2, false)
	table.insert(self.tplItemPool[arg_17_1], arg_17_2)

	return
end

function MusicBeatGameVo:clear()
	self.tpl = nil
	self.tplItemPool = nil

	return
end

return MusicBeatGameVo
