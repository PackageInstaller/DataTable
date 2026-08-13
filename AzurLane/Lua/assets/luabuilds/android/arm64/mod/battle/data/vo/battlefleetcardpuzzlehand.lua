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
local var_0_11 = var_0.Battle.BattleFleetCardPuzzleCardManageComponent

class = var_0_10012

local var_0_12 = var_0_10012("BattleFleetCardPuzzleHand")

var_0.Battle.BattleFleetCardPuzzleHand = var_0_12
var_0_12.__name = "BattleFleetCardPuzzleHand"

function var_0_12.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._cardPuzzleComponent = arg_1_1
	arg_1_0._indexID = arg_1_2

	arg_1_0:init()

	return
end

function var_0_12.GetIndexID(arg_2_0)
	return arg_2_0._indexID
end

function var_0_12.EnterCoolDownByType(arg_3_0, arg_3_1, arg_3_2)
	if 0 < arg_3_2 then
		pg = var_3

		local var_3_0 = var_3.TimeMgr.GetInstance()
		local var_3_1 = var_3.GetCombatTime(var_3_0)

		arg_3_0._typeCDTimeStampList[arg_3_1] = var_3_1 + arg_3_2

		local var_3_2 = {
			total = true,
			value = arg_3_1,
			type = var_0_11.SEARCH_BY_TYPE
		}
		local var_3_3 = arg_3_0:Search(var_3_2)

		ipairs = var_1_10006

		for iter_3_0, iter_3_1 in var_1_10006(var_3_3) do
			iter_3_1:SetOverHeatDuration(arg_3_2)
		end
	end

	return
end

function var_0_12.Add(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.GetCardType(var_4_0)

	if arg_4_0._typeCDTimeStampList[var_4_1] ~= -1 then
		pg = var_4_0

		local var_4_2 = var_4_0.TimeMgr.GetInstance()
		local var_4_3 = var_3 - var_4.GetCombatTime(var_4_2)

		arg_4_1:SetOverHeatDuration(var_4_3)
	end

	return
end

function var_0_12.Update(arg_5_0, arg_5_1)
	pairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0._typeCDTimeStampList) do
		if iter_5_1 < arg_5_1 then
			arg_5_0._typeCDTimeStampList[iter_5_0] = -1
		end
	end

	return
end

function var_0_12.Dispose(arg_6_0)
	return
end

function var_0_12.GetCardList(arg_7_0)
	return arg_7_0._handCardList
end

function var_0_12.IsFull(arg_8_0)
	local var_8_0 = arg_8_0:GetLength()
	local var_8_1 = var_0_7.BASE_MAX_HAND
	local var_8_2 = arg_8_0._attrManager

	return var_8_0 >= var_8_1 + var_3.GetCurrent(var_8_2, "HandExtra")
end

function var_0_12.init(arg_9_0)
	arg_9_0._handCardList = {}

	var_0.EventDispatcher.AttachEventDispatcher(arg_9_0)
	var_0.Battle.BattleFleetCardPuzzleCardManageComponent.AttachCardManager(arg_9_0)

	local var_9_0 = arg_9_0._cardPuzzleComponent

	arg_9_0._attrManager = var_1.GetAttrManager(var_9_0)
	arg_9_0._typeCDTimeStampList = {}
	pairs = var_1
	CardPuzzleCard = var_9_0

	for iter_9_0, iter_9_1 in var_1(var_9_0.CARD_TYPE) do
		arg_9_0._typeCDTimeStampList[iter_9_1] = -1
	end

	return
end

return
