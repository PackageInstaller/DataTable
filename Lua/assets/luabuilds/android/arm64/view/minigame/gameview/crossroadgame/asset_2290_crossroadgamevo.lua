local CrossRoadGameVo = class("CrossRoadGameVo")

function CrossRoadGameVo:Ctor(arg_1_1)
	self._gameId = arg_1_1
	self._hubId = pg.mini_game[arg_1_1].hub_id
	self._mgData = getProxy(MiniGameProxy):GetMiniGameData(self._gameId)
	self._mgHubData = getProxy(MiniGameProxy):GetHubByHubId(self._hubId)

	self:Prepare()

	return
end

function CrossRoadGameVo:GetGameId()
	return self._gameId
end

function CrossRoadGameVo:SetEditor(arg_3_1)
	self._editorFlag = arg_3_1

	return
end

function CrossRoadGameVo:GetEditor(arg_4_1)
	return self._editorFlag
end

function CrossRoadGameVo:GetGameRound()
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

function CrossRoadGameVo:GetGameTimes()
	if self._mgHubData then
		return self._mgHubData.count or 0
	end

	return 0
end

function CrossRoadGameVo:GetGameUseTimes()
	if self._mgHubData then
		return self._mgHubData.usedtime or 0
	end

	return 0
end

function CrossRoadGameVo:GetUltimate()
	if self._mgHubData then
		return self._mgHubData.ultimate
	end

	return nil
end

function CrossRoadGameVo:GetTotalTimes()
	return self._totalTimes
end

function CrossRoadGameVo:GetHubId()
	return self._mgHubData.id
end

function CrossRoadGameVo:Prepare()
	self._gameTime = CrossRoadGameConst.GAME_TIME
	self._gameTimeInteger = math.floor(self._gameTime)
	self._gameStepTime = 0
	self._deltaTime = 0
	self._scoreNum = 0
	self._settlementFlag = false
	self._joyStickData = nil
	self._life = CrossRoadGameConst.LIFE_COUNT
	self._roleWentCnt = 0

	return
end

function CrossRoadGameVo:Step(arg_12_1)
	self._gameTime = self._gameTime - arg_12_1
	self._gameTimeInteger = math.floor(self._gameTime)
	self._gameStepTime = self._gameStepTime + arg_12_1
	self._gameStepTimeInteger = math.floor(self._gameStepTime)
	self._deltaTime = arg_12_1

	return
end

function CrossRoadGameVo:AddScore(arg_13_1)
	self._scoreNum = self._scoreNum + arg_13_1

	return
end

function CrossRoadGameVo:GetScore()
	return self._scoreNum
end

function CrossRoadGameVo:SetSettlement(arg_15_1)
	self._settlementFlag = arg_15_1

	return
end

function CrossRoadGameVo:IsSettlement()
	return self._settlementFlag
end

function CrossRoadGameVo:GetTime()
	return self._gameTime
end

function CrossRoadGameVo:GetTimeInteger()
	return self._gameTimeInteger
end

function CrossRoadGameVo:GetStepTimeInteger()
	return self._gameStepTimeInteger
end

function CrossRoadGameVo:GetDrop()
	return self._drop
end

function CrossRoadGameVo:GetConfig(arg_21_1)
	return self._mgData:getConfig(arg_21_1)
end

function CrossRoadGameVo:GetDeltaTime()
	return self._deltaTime
end

function CrossRoadGameVo:GetLife()
	return self._life
end

function CrossRoadGameVo:changeLife(arg_24_1)
	self._life = self._life + arg_24_1

	return
end

function CrossRoadGameVo:GetRoleCnt()
	return self._roleWentCnt
end

function CrossRoadGameVo:AddRoleCnt()
	self._roleWentCnt = self._roleWentCnt + 1

	return
end

function CrossRoadGameVo:SetJoyStickData(arg_27_1)
	self._joyStickData = arg_27_1

	return
end

function CrossRoadGameVo:GetJoyStickData()
	return self._joyStickData
end

function CrossRoadGameVo:Clear()
	self._drop = {}
	self._totalTimes = 0
	self._mgData = nil
	self._mgHubData = nil

	return
end

return CrossRoadGameVo
