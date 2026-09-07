ys = ys or {}

local var_0_0 = ys
local var_0_5 = ys.Battle.BattleCardPuzzleFormulas
local var_0_9 = ys.Battle.BattleDataFunction
local BattleCardPuzzleCard = class("BattleCardPuzzleCard")

ys.Battle.BattleCardPuzzleCard = BattleCardPuzzleCard
BattleCardPuzzleCard.__name = "BattleCardPuzzleCard"

function BattleCardPuzzleCard:GetCardEffectConfig()
	return pg.cardCfg["card_" .. self]
end

function BattleCardPuzzleCard:Ctor(arg_2_1)
	self._client = arg_2_1

	self:init()

	return
end

function BattleCardPuzzleCard:init()
	self._timeStampList = {}

	return
end

function BattleCardPuzzleCard:SetCardTemplate(arg_4_1)
	self._cardID = arg_4_1
	self._cardTemp = var_0_9.GetPuzzleCardDataTemplate(self._cardID)

	local var_4_0 = BattleCardPuzzleCard.GetCardEffectConfig(self._cardTemp.effect[1])

	self._iconID = self._cardTemp.icon
	self._cost = self._cardTemp.cost
	self._returnCost = var_4_0.shuffle_cost
	self._labelList = self._cardTemp.label
	self._effectList = var_4_0.effect_list
	self._shuffleEffectList = var_4_0.shuffle_effect_list

	self:initCardEffectList()

	self._extraCost = var_4_0.extra_cost
	self._castCondition = var_4_0.cast_condition
	self._boostCondition = var_4_0.boost_hint

	return
end

function BattleCardPuzzleCard:GetCardTemplate()
	return self._cardTemp
end

function BattleCardPuzzleCard:GetCardID()
	return self._cardID
end

function BattleCardPuzzleCard:GetRarity()
	return self._cardTemp.rarity
end

function BattleCardPuzzleCard:GetCardType()
	return self._cardTemp.card_type
end

function BattleCardPuzzleCard:GetCardCD()
	return self._cardTemp.cooldown
end

function BattleCardPuzzleCard:GetLabels()
	return self._labelList
end

function BattleCardPuzzleCard:GetCurrentPile()
	return self._currentPile
end

function BattleCardPuzzleCard:SetCurrentPile(arg_12_1)
	self._currentPile = arg_12_1

	return
end

function BattleCardPuzzleCard:GetFromPile()
	return self._fromPile
end

function BattleCardPuzzleCard:SetFromPile(arg_14_1)
	self._fromPile = arg_14_1

	return
end

function BattleCardPuzzleCard:LabelContain(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		if table.contains(self._labelList, iter_15_1) then
			return true
		end
	end

	return false
end

function BattleCardPuzzleCard:GetCastCondition()
	if not self._castCondition then
		return nil
	else
		return var_0_5.parseCompare(self._castCondition, self._client:GetAttrManager())
	end

	return
end

function BattleCardPuzzleCard:GetBaseCost()
	return self._cost
end

function BattleCardPuzzleCard:GetExtraCost()
	if not self._extraCost then
		return 0
	else
		return var_0_5.parseFormula(self._extraCost, self._client:GetAttrManager())
	end

	return
end

function BattleCardPuzzleCard:GetTotalCost()
	return math.max(self:GetBaseCost() + self:GetExtraCost(), 0)
end

function BattleCardPuzzleCard:GetReturnCost()
	return self._returnCost
end

function BattleCardPuzzleCard:IsBoost()
	if not self._boostCondition then
		return false
	else
		return var_0_5.parseCompare(self._boostCondition, self._client:GetAttrManager())
	end

	return
end

function BattleCardPuzzleCard:GetIconID()
	return self._iconID
end

function BattleCardPuzzleCard:GetMoveAfterCast()
	return self._moveAfterCaster
end

function BattleCardPuzzleCard:SetBaseEnergyFillDuration(arg_24_1)
	local var_24_0 = {
		duration = arg_24_1
	}

	var_24_0.timeStamp = arg_24_1 + pg.TimeMgr.GetInstance():GetCombatTime()
	self._timeStampList.energy = var_24_0

	return
end

function BattleCardPuzzleCard:SetOverHeatDuration(arg_25_1)
	timeStamp = arg_25_1 + pg.TimeMgr.GetInstance():GetCombatTime()
	self._timeStampList.overheat = {
		duration = arg_25_1,
		timeStamp = timeStamp
	}

	return
end

function BattleCardPuzzleCard:GetCastRemainRate()
	local var_26_0 = 0
	local var_26_1 = 0

	for iter_26_0, iter_26_1 in pairs(self._timeStampList) do
		if var_26_1 < iter_26_1.timeStamp then
			var_26_0 = iter_26_1.duration
			var_26_1 = iter_26_1.timeStamp
		end
	end

	if var_26_0 ~= 0 then
		return (var_26_1 - pg.TimeMgr.GetInstance():GetCombatTime()) / var_26_0
	else
		return 0
	end

	return
end

function BattleCardPuzzleCard:Precast(arg_27_1)
	self._castCallback = arg_27_1

	if self._holdForInputMark then
		self._client:HoldForInput(self)
	else
		self:Cast()
	end

	return
end

function BattleCardPuzzleCard:Cast()
	self:checkAndStartQueue(self._queueList)

	if self._castCallback then
		self._castCallback()
	end

	return
end

function BattleCardPuzzleCard:Retrun(arg_29_1)
	self:checkAndStartQueue(self._returnQueueList)
	arg_29_1()

	return
end

function BattleCardPuzzleCard:Active()
	self:checkAndStartQueue(self._queueList)

	return
end

function BattleCardPuzzleCard:SetInputPoint(arg_31_1)
	self._inputPoint = Clone(arg_31_1)

	return
end

function BattleCardPuzzleCard:GetInputPoint()
	return self._inputPoint
end

function BattleCardPuzzleCard:GetClient()
	return self._client
end

function BattleCardPuzzleCard:QueueFinish(arg_34_1)
	local var_34_0 = arg_34_1:GetBranch()

	if var_34_0 then
		local var_34_1 = {}

		for iter_34_0, iter_34_1 in pairs(var_34_0) do
			if var_0_5.parseCompare(iter_34_1, self._client:GetAttrManager()) then
				var_34_1[iter_34_0] = true
			end
		end

		local var_34_3 = arg_34_1:GetQueueType() == var_0_0.Battle.BattleCardPuzzleCardEffectQueue.QUEUE_TYPE_RETURN and self._returnBranchQueueList or self._branchQueueList

		for iter_34_2, iter_34_3 in pairs(var_34_1) do
			self._branchQueueList[iter_34_2]:Start()
		end
	end

	return
end

function BattleCardPuzzleCard:initCardEffectList()
	self._holdForInputMark = false
	self._moveAfterCaster = var_0_0.Battle.BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_DISCARD
	self._queueList, self._branchQueueList = {}, {}

	for iter_35_0, iter_35_1 in ipairs(self._effectList) do
		local var_35_0 = var_0_0.Battle.BattleCardPuzzleCardEffectQueue.New(self)

		var_35_0:ConfigData(iter_35_1)
		var_35_0:SetQueueType(var_0_0.Battle.BattleCardPuzzleCardEffectQueue.QUEUE_TYPE_NORMAL)
		table.insert(self._queueList, var_35_0)

		if var_35_0:GetHoldForInputMark() then
			self._holdForInputMark = true
		end
	end

	for iter_35_2, iter_35_3 in pairs(self._effectList) do
		local var_35_1 = var_0_0.Battle.BattleCardPuzzleCardEffectQueue.New(self)

		var_35_1:ConfigData(iter_35_3)
		var_35_1:SetQueueType(var_0_0.Battle.BattleCardPuzzleCardEffectQueue.QUEUE_TYPE_NORMAL)

		self._branchQueueList[iter_35_2] = var_35_1
	end

	if self._returnCost then
		self._returnQueueList, self._returnBranchQueueList = {}, {}

		for iter_35_4, iter_35_5 in ipairs(self._shuffleEffectList) do
			local var_35_2 = var_0_0.Battle.BattleCardPuzzleCardEffectQueue.New(self)

			var_35_2:ConfigData(iter_35_5)
			var_35_2:SetQueueType(var_0_0.Battle.BattleCardPuzzleCardEffectQueue.QUEUE_TYPE_RETURN)
			table.insert(self._returnQueueList, var_35_2)
		end

		for iter_35_6, iter_35_7 in pairs(self._shuffleEffectList) do
			local var_35_3 = var_0_0.Battle.BattleCardPuzzleCardEffectQueue.New(self)

			var_35_3:ConfigData(iter_35_7)
			var_35_3:SetQueueType(var_0_0.Battle.BattleCardPuzzleCardEffectQueue.QUEUE_TYPE_RETURN)

			self._returnBranchQueueList[iter_35_6] = var_35_3
		end
	end

	return
end

function BattleCardPuzzleCard:checkAndStartQueue(arg_36_1)
	local var_36_0 = {}

	for iter_36_0, iter_36_1 in ipairs(arg_36_1) do
		local var_36_1 = iter_36_1:GetCondition()

		if var_36_1 and not var_0_5.parseCompare(var_36_1, self._client:GetAttrManager()) then
			var_36_0[iter_36_0] = false
		else
			self._moveAfterCaster = iter_36_1:GetMoveAfterCast()
			var_36_0[iter_36_0] = true
		end
	end

	for iter_36_2, iter_36_3 in pairs(var_36_0) do
		if iter_36_3 == true then
			arg_36_1[iter_36_2]:Start()
		end
	end

	return
end

function BattleCardPuzzleCard:GetCardEffectTargetFilterList()
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in ipairs(self._effectList) do
		if not iter_37_1.condition or var_0_5.parseCompare(iter_37_1.condition, self._client:GetAttrManager()) then
			self:checkQueueTarget(iter_37_1, var_37_0)
		end
	end

	return var_37_0
end

BattleCardPuzzleCard.AIM_FX_EFFECT = {
	"BattleCardPuzzleSkillFire"
}

function BattleCardPuzzleCard:checkQueueTarget(arg_38_1, arg_38_2)
	for iter_38_0, iter_38_1 in ipairs(arg_38_1) do
		if table.contains(BattleCardPuzzleCard.AIM_FX_EFFECT, iter_38_1.type) and iter_38_1.target_choise then
			local var_38_0 = arg_38_2[iter_38_1.caster] or {}

			table.insert(var_38_0, iter_38_1.target_choise)

			arg_38_2[iter_38_1.caster] = var_38_0
		end
	end

	if arg_38_1.branch then
		for iter_38_2, iter_38_3 in pairs(arg_38_1.branch) do
			if var_0_5.parseCompare(iter_38_3, self._client:GetAttrManager()) then
				self:checkQueueTarget(self._effectList[iter_38_2])
			end
		end
	end

	return
end

function BattleCardPuzzleCard:GetIconPath()
	return CardPuzzleCard.GetCardIconPath(self:GetCardTemplate().icon)
end

function BattleCardPuzzleCard:GetType()
	return self:GetCardType()
end

function BattleCardPuzzleCard:GetName()
	return self:GetCardTemplate().name
end

function BattleCardPuzzleCard:GetDesc()
	return self:GetCardTemplate().discript
end

function BattleCardPuzzleCard:GetCost()
	return self:GetTotalCost()
end

function BattleCardPuzzleCard:GetKeywords()
	return CardPuzzleCard.GetCardKeyWord(self:GetCardTemplate().label)
end

function BattleCardPuzzleCard:getConfig(arg_45_1)
	return self._cardTemp[arg_45_1]
end

return
