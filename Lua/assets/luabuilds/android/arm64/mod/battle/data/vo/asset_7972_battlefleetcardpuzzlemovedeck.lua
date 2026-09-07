ys = ys or {}

local var_0_0 = ys
local var_0_7 = ys.Battle.BattleCardPuzzleConfig
local var_0_9 = ys.Battle.BattleDataFunction
local BattleFleetCardPuzzleMoveDeck = class("BattleFleetCardPuzzleMoveDeck")

ys.Battle.BattleFleetCardPuzzleMoveDeck = BattleFleetCardPuzzleMoveDeck
BattleFleetCardPuzzleMoveDeck.__name = "BattleFleetCardPuzzleMoveDeck"

function BattleFleetCardPuzzleMoveDeck:Ctor(arg_1_1, arg_1_2)
	self._cardPuzzleComponent = arg_1_1
	self._indexID = arg_1_2

	self:init()

	return
end

function BattleFleetCardPuzzleMoveDeck:CustomConfig(arg_2_1)
	self._generateRate = var_0_9.GetPuzzleDungeonTemplate(arg_2_1).move_recovery

	return
end

function BattleFleetCardPuzzleMoveDeck:GetIndexID()
	return self._indexID
end

function BattleFleetCardPuzzleMoveDeck:Dispose()
	return
end

function BattleFleetCardPuzzleMoveDeck:GetCardList()
	return self._moveCardList
end

function BattleFleetCardPuzzleMoveDeck:Update(arg_6_1)
	self:update(arg_6_1)

	return
end

function BattleFleetCardPuzzleMoveDeck:init()
	self._moveCardList = {}

	var_0_0.EventDispatcher.AttachEventDispatcher(self)
	var_0_0.Battle.BattleFleetCardPuzzleCardManageComponent.AttachCardManager(self)

	self._attrManager = self._cardPuzzleComponent:GetAttrManager()
	self._generateRate = var_0_7.moveCardGenerateSpeedPerSecond
	self._maxMoveCard = var_0_7.BASE_MAX_MOVE
	self._generating = 0

	self:updateTimeStamp()

	return
end

function BattleFleetCardPuzzleMoveDeck:updateTimeStamp()
	self._lastUpdateTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function BattleFleetCardPuzzleMoveDeck:update(arg_9_1)
	if self:GetLength() < self._maxMoveCard + self._attrManager:GetCurrent("MoveExtra") then
		self._generating = (arg_9_1 - self._lastUpdateTimeStamp) * self._generateRate + self._generating
	end

	self:updateTimeStamp()

	return
end

function BattleFleetCardPuzzleMoveDeck:GetGeneratePorcess()
	return self._generating
end

function BattleFleetCardPuzzleMoveDeck:TryPlayTopMoveCard()
	local var_11_0 = self:GetLength()

	if var_11_0 > 0 then
		return self:GetCardList()[var_11_0]
	end

	return
end

function BattleFleetCardPuzzleMoveDeck:RestartGenrate()
	self._generating = 0

	return
end

return
