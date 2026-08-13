ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent
local var_0_3 = var_0.Battle.BattleCardPuzzleEvent
local var_0_4 = var_0.Battle.BattleFormulas
local var_0_5 = var_0.Battle.BattleConst
local var_0_6 = var_0.Battle.BattleConfig
local var_0_7 = var_0.Battle.BattleCardPuzzleConfig
local var_0_8 = var_0.Battle.BattleAttr
local var_0_9 = var_0.Battle.BattleDataFunction
local var_0_10 = var_0.Battle.BattleAttr

class = var_0_10011

local var_0_11 = var_0_10011("BattleFleetCardPuzzleMoveDeck")

var_0.Battle.BattleFleetCardPuzzleMoveDeck = var_0_11
var_0_11.__name = "BattleFleetCardPuzzleMoveDeck"

function var_0_11.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._cardPuzzleComponent = arg_1_1
	arg_1_0._indexID = arg_1_2

	arg_1_0:init()

	return
end

function var_0_11.CustomConfig(arg_2_0, arg_2_1)
	arg_2_0._generateRate = var_0_9.GetPuzzleDungeonTemplate(arg_2_1).move_recovery

	return
end

function var_0_11.GetIndexID(arg_3_0)
	return arg_3_0._indexID
end

function var_0_11.Dispose(arg_4_0)
	return
end

function var_0_11.GetCardList(arg_5_0)
	return arg_5_0._moveCardList
end

function var_0_11.Update(arg_6_0, arg_6_1)
	arg_6_0:update(arg_6_1)

	return
end

function var_0_11.init(arg_7_0)
	arg_7_0._moveCardList = {}

	var_0.EventDispatcher.AttachEventDispatcher(arg_7_0)
	var_0.Battle.BattleFleetCardPuzzleCardManageComponent.AttachCardManager(arg_7_0)

	local var_7_0 = arg_7_0._cardPuzzleComponent

	arg_7_0._attrManager = var_1.GetAttrManager(var_7_0)
	arg_7_0._generateRate = var_0_7.moveCardGenerateSpeedPerSecond
	arg_7_0._maxMoveCard = var_0_7.BASE_MAX_MOVE
	arg_7_0._generating = 0

	arg_7_0:updateTimeStamp()

	return
end

function var_0_11.updateTimeStamp(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.TimeMgr.GetInstance()

	arg_8_0._lastUpdateTimeStamp = var_1.GetCombatTime(var_8_0)

	return
end

function var_0_11.update(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetLength()
	local var_9_1 = arg_9_0._maxMoveCard
	local var_9_2 = arg_9_0._attrManager

	if var_9_0 < var_9_1 + var_4.GetCurrent(var_9_2, "MoveExtra") then
		arg_9_0._generating = (arg_9_1 - arg_9_0._lastUpdateTimeStamp) * arg_9_0._generateRate + arg_9_0._generating
	end

	arg_9_0:updateTimeStamp()

	return
end

function var_0_11.GetGeneratePorcess(arg_10_0)
	return arg_10_0._generating
end

function var_0_11.TryPlayTopMoveCard(arg_11_0)
	if arg_11_0:GetLength() > 0 then
		return arg_11_0:GetCardList()[var_1]
	end

	return
end

function var_0_11.RestartGenrate(arg_12_0)
	arg_12_0._generating = 0

	return
end

return
