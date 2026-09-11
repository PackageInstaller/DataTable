local AutoChessBattleBlackboard = class("AutoChessBattleBlackboard")

function AutoChessBattleBlackboard:Ctor()
	self:Reset()
end

function AutoChessBattleBlackboard:Reset()
	self.gameType = AutoChessConst.GAME_TYPE.PVE
	self.isOverBattle = false
	self.isFightOver = false
	self.deathWhispeAnimPlayedDic = {}
end

function AutoChessBattleBlackboard:Dispose()
	self:Reset()
end

function AutoChessBattleBlackboard:GetGameType()
	return self.gameType
end

function AutoChessBattleBlackboard:GetGameStatus()
	return AutoChessData:GetGameStatus(self.gameType)
end

function AutoChessBattleBlackboard:Init(arg_6_1)
	self.gameType = arg_6_1
end

function AutoChessBattleBlackboard:GetBattleData()
	return AutoChessData:GetBattleData(self.gameType)
end

function AutoChessBattleBlackboard:GetPrepareData()
	return AutoChessData:GetPrepareData(self.gameType)
end

function AutoChessBattleBlackboard:SetIsFightOver()
	self.isFightOver = true
end

function AutoChessBattleBlackboard:GetIsFightOver()
	return self.isFightOver
end

return AutoChessBattleBlackboard
