ys = ys or {}

local var_0_6 = ys.Battle.BattleCardPuzzleConfig
local var_0_10 = ys.Battle.BattleFleetCardPuzzleCardManageComponent
local var_0_11 = class("BattleFleetCardPuzzleHand")

ys.Battle.BattleFleetCardPuzzleHand = var_0_11
var_0_11.__name = "BattleFleetCardPuzzleHand"

function var_0_11.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._cardPuzzleComponent = arg_1_1
	arg_1_0._indexID = arg_1_2

	arg_1_0:init()

	return
end

function var_0_11.GetIndexID(arg_2_0)
	return arg_2_0._indexID
end

function var_0_11.EnterCoolDownByType(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 > 0 then
		arg_3_0._typeCDTimeStampList[arg_3_1] = pg.TimeMgr.GetInstance():GetCombatTime() + arg_3_2

		for iter_3_0, iter_3_1 in ipairs((arg_3_0:Search({
			total = true,
			value = arg_3_1,
			type = var_0_10.SEARCH_BY_TYPE
		}))) do
			iter_3_1:SetOverHeatDuration(arg_3_2)
		end
	end

	return
end

function var_0_11.Add(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._typeCDTimeStampList[arg_4_1:GetCardType()]

	if var_4_0 ~= -1 then
		arg_4_1:SetOverHeatDuration(var_4_0 - pg.TimeMgr.GetInstance():GetCombatTime())
	end

	return
end

function var_0_11.Update(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._typeCDTimeStampList) do
		if iter_5_1 < arg_5_1 then
			arg_5_0._typeCDTimeStampList[iter_5_0] = -1
		end
	end

	return
end

function var_0_11.Dispose(arg_6_0)
	return
end

function var_0_11.GetCardList(arg_7_0)
	return arg_7_0._handCardList
end

function var_0_11.IsFull(arg_8_0)
	return arg_8_0:GetLength() >= var_0_6.BASE_MAX_HAND + arg_8_0._attrManager:GetCurrent("HandExtra")
end

function var_0_11.init(arg_9_0)
	arg_9_0._handCardList = {}

	var_0.EventDispatcher.AttachEventDispatcher(arg_9_0)
	var_0.Battle.BattleFleetCardPuzzleCardManageComponent.AttachCardManager(arg_9_0)

	arg_9_0._attrManager = arg_9_0._cardPuzzleComponent:GetAttrManager()
	arg_9_0._typeCDTimeStampList = {}

	for iter_9_0, iter_9_1 in pairs(CardPuzzleCard.CARD_TYPE) do
		arg_9_0._typeCDTimeStampList[iter_9_1] = -1
	end

	return
end

return
