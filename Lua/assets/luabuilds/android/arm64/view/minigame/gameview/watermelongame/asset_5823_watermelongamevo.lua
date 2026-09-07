local WatermelonGameVo = class("WatermelonGameVo")
local var_0_1 = 1.4

function WatermelonGameVo:Ctor(arg_1_1)
	self.gameId = arg_1_1
	self.hubId = pg.mini_game[self.gameId].hub_id
	self.drop = pg.mini_game[self.gameId].simple_config_data.drop_ids
	self.totalTimes = pg.mini_game_hub[self.hubId].reward_need
	self.mgData = getProxy(MiniGameProxy):GetMiniGameData(self.gameId)
	self.mgHubData = getProxy(MiniGameProxy):GetHubByHubId(self.hubId)
	self.tplItemPool = {}

	return
end

function WatermelonGameVo:getGameTimes()
	if self.mgHubData then
		return self.mgHubData.count or 0
	end

	return 0
end

function WatermelonGameVo:getGameUseTimes()
	if self.mgHubData then
		return self.mgHubData.usedtime or 0
	end

	return 0
end

function WatermelonGameVo:GetGameRound()
	if self.selectRound ~= nil then
		return self.selectRound
	end

	local var_4_0 = self:getGameUseTimes()
	local var_4_1 = self:GetGameTimes()

	if var_4_1 and var_4_1 > 0 then
		return var_4_0 + 1
	end

	if var_4_0 and var_4_0 > 0 then
		return var_4_0
	end

	return 1
end

function WatermelonGameVo:prepare()
	self.gameTime = WatermelonGameConst.game_time
	self.gameStepTime = 0
	self.deltaTime = 0
	self.scoreNum = 0
	self.startSettlement = false
	self._joyStickData = nil
	self.createBallCd = var_0_1

	return
end

function WatermelonGameVo:setJoyStickData(arg_6_1)
	self._joyStickData = arg_6_1

	return
end

function WatermelonGameVo:getJoyStickData()
	return self._joyStickData
end

function WatermelonGameVo:setGameTpl(arg_8_1)
	self.tpl = arg_8_1

	return
end

function WatermelonGameVo:getTplItemFromPool(arg_9_1, arg_9_2)
	if not arg_9_1 or arg_9_1 == "" then
		return nil
	end

	if not arg_9_2 then
		return nil
	end

	if self.tplItemPool[arg_9_1] == nil then
		self.tplItemPool[arg_9_1] = {}
	end

	if #self.tplItemPool[arg_9_1] == 0 then
		local var_9_0 = tf(instantiate(findTF(self.tpl, arg_9_1)))

		setParent(var_9_0, arg_9_2)

		return var_9_0, true
	else
		return table.remove(self.tplItemPool[arg_9_1], #self.tplItemPool[arg_9_1]), false
	end

	return nil, nil
end

function WatermelonGameVo:returnTplItem(arg_10_1, arg_10_2)
	if not arg_10_2 or not arg_10_1 then
		return
	end

	setActive(arg_10_2, false)
	table.insert(self.tplItemPool[arg_10_1], arg_10_2)

	return
end

function WatermelonGameVo:clear()
	self.tpl = nil
	self.tplItemPool = nil

	return
end

return WatermelonGameVo
