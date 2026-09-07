local PacGameVo = class("PacGameVo")

function PacGameVo:Ctor(arg_1_1)
	self._gameId = arg_1_1
	self._hubId = pg.mini_game[self._gameId].hub_id
	self._drop = pg.mini_game[self._gameId].simple_config_data.drop_ids
	self._totalTimes = pg.mini_game_hub[self._hubId].reward_need
	self._mgData = getProxy(MiniGameProxy):GetMiniGameData(self._gameId)
	self._mgHubData = getProxy(MiniGameProxy):GetHubByHubId(self._hubId)

	return
end

function PacGameVo:GetGameId()
	return self._gameId
end

function PacGameVo:SetEditor(arg_3_1)
	self._editorFlag = arg_3_1

	return
end

function PacGameVo:GetEditor(arg_4_1)
	return self._editorFlag
end

function PacGameVo:GetGameRound()
	if self._editorFlag then
		return PacGameConst.editor_chapter
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

function PacGameVo:GetGameTimes()
	if self._mgHubData then
		return self._mgHubData.count or 0
	end

	return 0
end

function PacGameVo:GetGameUseTimes()
	if self._mgHubData then
		return self._mgHubData.usedtime or 0
	end

	return 0
end

function PacGameVo:GetUltimate()
	if self._mgHubData then
		return self._mgHubData.ultimate
	end

	return nil
end

function PacGameVo:GetTotalTimes()
	return self._totalTimes
end

function PacGameVo:GetHubId()
	return self._mgHubData.id
end

function PacGameVo:Prepare()
	self._gameTime = PacGameConst.game_time
	self._gameTimeInteger = math.floor(self._gameTime)
	self._gameStepTime = 0
	self._deltaTime = 0
	self._scoreNum = 0
	self._settlementFlag = false
	self._joyStickData = nil

	return
end

function PacGameVo:Step(arg_12_1)
	self._gameTime = self._gameTime - arg_12_1
	self._gameTimeInteger = math.floor(self._gameTime)
	self._gameStepTime = self._gameStepTime + arg_12_1
	self._gameStepTimeInteger = math.floor(self._gameStepTime)
	self._deltaTime = arg_12_1

	return
end

function PacGameVo:AddScore(arg_13_1)
	self._scoreNum = self._scoreNum + arg_13_1

	return
end

function PacGameVo:GetScore()
	return self._scoreNum
end

function PacGameVo:SetSettlement(arg_15_1)
	self._settlementFlag = arg_15_1

	return
end

function PacGameVo:IsSettlement()
	return self._settlementFlag
end

function PacGameVo:GetTime()
	return self._gameTime
end

function PacGameVo:GetTimeInteger()
	return self._gameTimeInteger
end

function PacGameVo:GetStepTimeInteger()
	return self._gameStepTimeInteger
end

function PacGameVo:GetDrop()
	return self._drop
end

function PacGameVo:GetConfig(arg_21_1)
	return self._mgData:getConfig(arg_21_1)
end

function PacGameVo:GetDeltaTime()
	return self._deltaTime
end

function PacGameVo:SetJoyStickData(arg_23_1)
	self._joyStickData = arg_23_1

	return
end

function PacGameVo:GetJoyStickData()
	return self._joyStickData
end

function PacGameVo:Clear()
	self._drop = {}
	self._totalTimes = 0
	self._mgData = nil
	self._mgHubData = nil

	return
end

return PacGameVo
