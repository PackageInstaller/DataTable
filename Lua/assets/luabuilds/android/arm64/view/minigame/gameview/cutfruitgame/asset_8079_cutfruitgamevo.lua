local CutFruitGameVo = class("CutFruitGameVo")

function CutFruitGameVo:Ctor(arg_1_1)
	self._gameId = arg_1_1
	self._hubId = pg.mini_game[self._gameId].hub_id
	self._drop = pg.mini_game[self._gameId].simple_config_data.drop_ids
	self._totalTimes = pg.mini_game_hub[self._hubId].reward_need
	self._mgData = getProxy(MiniGameProxy):GetMiniGameData(self._gameId)
	self._mgHubData = getProxy(MiniGameProxy):GetHubByHubId(self._hubId)

	return
end

function CutFruitGameVo:GetGameId()
	return self._gameId
end

function CutFruitGameVo:SetEditor(arg_3_1)
	self._editorFlag = arg_3_1

	return
end

function CutFruitGameVo:GetEditor(arg_4_1)
	return self._editorFlag
end

function CutFruitGameVo:GetGameRound()
	if self._editorFlag then
		return CutFruitGameConst.editor_chapter
	end

	if self.selectRound ~= nil then
		return self.selectRound
	end

	local var_5_0 = self:GetGameUseTimes()
	local var_5_1 = self:GetGameTimes()

	if var_5_1 and var_5_1 > 0 then
		return var_5_0 + 1
	end

	if var_5_0 and var_5_0 > 0 then
		return var_5_0
	end

	return 1
end

function CutFruitGameVo:GetGameTimes()
	if self._mgHubData then
		return self._mgHubData.count or 0
	end

	return 0
end

function CutFruitGameVo:GetGameUseTimes()
	if self._mgHubData then
		return self._mgHubData.usedtime or 0
	end

	return 0
end

function CutFruitGameVo:GetUltimate()
	if self._mgHubData then
		return self._mgHubData.ultimate
	end

	return nil
end

function CutFruitGameVo:GetTotalTimes()
	return self._totalTimes
end

function CutFruitGameVo:GetHubId()
	return self._mgHubData.id
end

function CutFruitGameVo:Prepare()
	self._gameTime = CutFruitGameConst.game_time
	self._gameTimeInteger = math.floor(self._gameTime)
	self._gameStepTime = 0
	self._deltaTime = 0
	self._scoreNum = 0
	self._settlementFlag = false
	self._joyStickData = nil
	self._success = false
	self._stopTimeStep = false

	return
end

function CutFruitGameVo:Step(arg_12_1)
	self._deltaTime = arg_12_1

	if self._stopTimeStep then
		return
	end

	self._gameTime = self._gameTime - arg_12_1
	self._gameTimeInteger = math.floor(self._gameTime)
	self._gameStepTime = self._gameStepTime + arg_12_1
	self._gameStepTimeInteger = math.floor(self._gameStepTime)

	return
end

function CutFruitGameVo:AddScore(arg_13_1)
	self._scoreNum = self._scoreNum + arg_13_1

	return
end

function CutFruitGameVo:GetScore()
	return self._scoreNum
end

function CutFruitGameVo:SetSettlement(arg_15_1)
	self._settlementFlag = arg_15_1

	return
end

function CutFruitGameVo:IsSettlement()
	return self._settlementFlag
end

function CutFruitGameVo:GetTime()
	return self._gameTime
end

function CutFruitGameVo:GetTimeInteger()
	return self._gameTimeInteger
end

function CutFruitGameVo:GetStepTimeInteger()
	return self._gameStepTimeInteger
end

function CutFruitGameVo:GetDrop()
	return self._drop
end

function CutFruitGameVo:GetConfig(arg_21_1)
	return self._mgData:getConfig(arg_21_1)
end

function CutFruitGameVo:GetDeltaTime()
	return self._deltaTime
end

function CutFruitGameVo:SetSuccess(arg_23_1)
	self._success = arg_23_1

	return
end

function CutFruitGameVo:GetSuccess()
	return self._success
end

function CutFruitGameVo:StopTimeStep(arg_25_1)
	self._stopTimeStep = arg_25_1

	return
end

function CutFruitGameVo:SetJoyStickData(arg_26_1)
	self._joyStickData = arg_26_1

	return
end

function CutFruitGameVo:GetJoyStickData()
	return self._joyStickData
end

function CutFruitGameVo:Clear()
	self._drop = {}
	self._totalTimes = 0
	self._mgData = nil
	self._mgHubData = nil

	return
end

return CutFruitGameVo
