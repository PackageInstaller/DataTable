ys = ys or {}

local var_0_0 = ys
local var_0_7 = ys.Battle.BattleCardPuzzleConfig
local var_0_11 = ys.Battle.BattleFleetCardPuzzleCardManageComponent
local BattleFleetCardPuzzleHand = class("BattleFleetCardPuzzleHand")

ys.Battle.BattleFleetCardPuzzleHand = BattleFleetCardPuzzleHand
BattleFleetCardPuzzleHand.__name = "BattleFleetCardPuzzleHand"

function BattleFleetCardPuzzleHand:Ctor(arg_1_1, arg_1_2)
	self._cardPuzzleComponent = arg_1_1
	self._indexID = arg_1_2

	self:init()

	return
end

function BattleFleetCardPuzzleHand:GetIndexID()
	return self._indexID
end

function BattleFleetCardPuzzleHand:EnterCoolDownByType(arg_3_1, arg_3_2)
	if arg_3_2 > 0 then
		self._typeCDTimeStampList[arg_3_1] = pg.TimeMgr.GetInstance():GetCombatTime() + arg_3_2

		for iter_3_0, iter_3_1 in ipairs((self:Search({
			total = true,
			value = arg_3_1,
			type = var_0_11.SEARCH_BY_TYPE
		}))) do
			iter_3_1:SetOverHeatDuration(arg_3_2)
		end
	end

	return
end

function BattleFleetCardPuzzleHand:Add(arg_4_1)
	local var_4_0 = self._typeCDTimeStampList[arg_4_1:GetCardType()]

	if var_4_0 ~= -1 then
		arg_4_1:SetOverHeatDuration(var_4_0 - pg.TimeMgr.GetInstance():GetCombatTime())
	end

	return
end

function BattleFleetCardPuzzleHand:Update(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(self._typeCDTimeStampList) do
		if iter_5_1 < arg_5_1 then
			self._typeCDTimeStampList[iter_5_0] = -1
		end
	end

	return
end

function BattleFleetCardPuzzleHand:Dispose()
	return
end

function BattleFleetCardPuzzleHand:GetCardList()
	return self._handCardList
end

function BattleFleetCardPuzzleHand:IsFull()
	return self:GetLength() >= var_0_7.BASE_MAX_HAND + self._attrManager:GetCurrent("HandExtra")
end

function BattleFleetCardPuzzleHand:init()
	self._handCardList = {}

	var_0_0.EventDispatcher.AttachEventDispatcher(self)
	var_0_0.Battle.BattleFleetCardPuzzleCardManageComponent.AttachCardManager(self)

	self._attrManager = self._cardPuzzleComponent:GetAttrManager()
	self._typeCDTimeStampList = {}

	for iter_9_0, iter_9_1 in pairs(CardPuzzleCard.CARD_TYPE) do
		self._typeCDTimeStampList[iter_9_1] = -1
	end

	return
end

return
