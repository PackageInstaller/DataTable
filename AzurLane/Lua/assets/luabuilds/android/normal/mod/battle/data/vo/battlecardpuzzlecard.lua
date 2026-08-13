ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent
local var_0_3 = var_0.Battle.BattleCardPuzzleEvent
local var_0_4 = var_0.Battle.BattleFormulas
local var_0_5 = var_0.Battle.BattleCardPuzzleFormulas
local var_0_6 = var_0.Battle.BattleConst
local var_0_7 = var_0.Battle.BattleConfig
local var_0_8 = var_0.Battle.BattleAttr
local var_0_9 = var_0.Battle.BattleDataFunction
local var_0_10 = var_0.Battle.BattleAttr

class = var_0_10011

local var_0_11 = var_0_10011("BattleCardPuzzleCard")

var_0.Battle.BattleCardPuzzleCard = var_0_11
var_0_11.__name = "BattleCardPuzzleCard"

function var_0_11.GetCardEffectConfig(arg_1_0)
	local var_1_0 = "card_" .. arg_1_0

	pg = var_2

	return var_2.cardCfg[var_1_0]
end

function var_0_11.Ctor(arg_2_0, arg_2_1)
	arg_2_0._client = arg_2_1

	arg_2_0:init()

	return
end

function var_0_11.init(arg_3_0)
	arg_3_0._timeStampList = {}

	return
end

function var_0_11.SetCardTemplate(arg_4_0, arg_4_1)
	arg_4_0._cardID = arg_4_1
	arg_4_0._cardTemp = var_0_9.GetPuzzleCardDataTemplate(arg_4_0._cardID)

	local var_4_0 = var_0_11.GetCardEffectConfig(arg_4_0._cardTemp.effect[1])

	arg_4_0._iconID = arg_4_0._cardTemp.icon
	arg_4_0._cost = arg_4_0._cardTemp.cost
	arg_4_0._returnCost = var_4_0.shuffle_cost
	arg_4_0._labelList = arg_4_0._cardTemp.label
	arg_4_0._effectList = var_4_0.effect_list
	arg_4_0._shuffleEffectList = var_4_0.shuffle_effect_list

	arg_4_0:initCardEffectList()

	arg_4_0._extraCost = var_4_0.extra_cost
	arg_4_0._castCondition = var_4_0.cast_condition
	arg_4_0._boostCondition = var_4_0.boost_hint

	return
end

function var_0_11.GetCardTemplate(arg_5_0)
	return arg_5_0._cardTemp
end

function var_0_11.GetCardID(arg_6_0)
	return arg_6_0._cardID
end

function var_0_11.GetRarity(arg_7_0)
	return arg_7_0._cardTemp.rarity
end

function var_0_11.GetCardType(arg_8_0)
	return arg_8_0._cardTemp.card_type
end

function var_0_11.GetCardCD(arg_9_0)
	return arg_9_0._cardTemp.cooldown
end

function var_0_11.GetLabels(arg_10_0)
	return arg_10_0._labelList
end

function var_0_11.GetCurrentPile(arg_11_0)
	return arg_11_0._currentPile
end

function var_0_11.SetCurrentPile(arg_12_0, arg_12_1)
	arg_12_0._currentPile = arg_12_1

	return
end

function var_0_11.GetFromPile(arg_13_0)
	return arg_13_0._fromPile
end

function var_0_11.SetFromPile(arg_14_0, arg_14_1)
	arg_14_0._fromPile = arg_14_1

	return
end

function var_0_11.LabelContain(arg_15_0, arg_15_1)
	ipairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_1) do
		table = var_1_10007

		if var_1_10007.contains(arg_15_0._labelList, iter_15_1) then
			return true
		end
	end

	return false
end

function var_0_11.GetCastCondition(arg_16_0)
	if not arg_16_0._castCondition then
		return nil
	else
		local var_16_0 = var_0_5.parseCompare
		local var_16_1 = arg_16_0._castCondition
		local var_16_2 = arg_16_0._client

		return var_16_0(var_16_1, var_3.GetAttrManager(var_16_2))
	end

	return
end

function var_0_11.GetBaseCost(arg_17_0)
	return arg_17_0._cost
end

function var_0_11.GetExtraCost(arg_18_0)
	if not arg_18_0._extraCost then
		return 0
	else
		local var_18_0 = var_0_5.parseFormula
		local var_18_1 = arg_18_0._extraCost
		local var_18_2 = arg_18_0._client

		return var_18_0(var_18_1, var_3.GetAttrManager(var_18_2))
	end

	return
end

function var_0_11.GetTotalCost(arg_19_0)
	math = var_1_10001

	return var_1_10001.max(arg_19_0:GetBaseCost() + arg_19_0:GetExtraCost(), 0)
end

function var_0_11.GetReturnCost(arg_20_0)
	return arg_20_0._returnCost
end

function var_0_11.IsBoost(arg_21_0)
	if not arg_21_0._boostCondition then
		return false
	else
		local var_21_0 = var_0_5.parseCompare
		local var_21_1 = arg_21_0._boostCondition
		local var_21_2 = arg_21_0._client

		return var_21_0(var_21_1, var_3.GetAttrManager(var_21_2))
	end

	return
end

function var_0_11.GetIconID(arg_22_0)
	return arg_22_0._iconID
end

function var_0_11.GetMoveAfterCast(arg_23_0)
	return arg_23_0._moveAfterCaster
end

function var_0_11.SetBaseEnergyFillDuration(arg_24_0, arg_24_1)
	pg = var_1_10002

	local var_24_0 = var_1_10002.TimeMgr.GetInstance()
	local var_24_1 = arg_24_1 + var_2.GetCombatTime(var_24_0)

	arg_24_0._timeStampList.energy = {
		duration = arg_24_1,
		timeStamp = var_24_1
	}

	return
end

function var_0_11.SetOverHeatDuration(arg_25_0, arg_25_1)
	pg = var_1_10002

	local var_25_0 = var_1_10002.TimeMgr.GetInstance()
	local var_25_1 = arg_25_1 + var_2.GetCombatTime(var_25_0)
	local var_25_2 = timeStamp
	local var_25_3 = arg_25_0._timeStampList
	local var_25_4 = {
		duration = arg_25_1
	}

	timeStamp = var_1_10004
	var_25_4.timeStamp = var_1_10004
	var_25_3.overheat = var_25_4

	return
end

function var_0_11.GetCastRemainRate(arg_26_0)
	local var_26_0 = 0
	local var_26_1 = 0

	pairs = var_1_10003

	for iter_26_0, iter_26_1 in var_1_10003(arg_26_0._timeStampList) do
		if var_26_1 < iter_26_1.timeStamp then
			var_26_0 = iter_26_1.duration
			var_26_1 = iter_26_1.timeStamp
		end
	end

	if var_26_0 ~= 0 then
		pg = var_3

		local var_26_2 = var_3.TimeMgr.GetInstance()

		return (var_26_1 - var_3.GetCombatTime(var_26_2)) / var_26_0
	else
		return 0
	end

	return
end

function var_0_11.Precast(arg_27_0, arg_27_1)
	arg_27_0._castCallback = arg_27_1

	if arg_27_0._holdForInputMark then
		local var_27_0 = arg_27_0._client

		var_2.HoldForInput(var_27_0, arg_27_0)
	else
		arg_27_0:Cast()
	end

	return
end

function var_0_11.Cast(arg_28_0)
	arg_28_0:checkAndStartQueue(arg_28_0._queueList)

	if arg_28_0._castCallback then
		arg_28_0._castCallback()
	end

	return
end

function var_0_11.Retrun(arg_29_0, arg_29_1)
	arg_29_0:checkAndStartQueue(arg_29_0._returnQueueList)
	arg_29_1()

	return
end

function var_0_11.Active(arg_30_0)
	arg_30_0:checkAndStartQueue(arg_30_0._queueList)

	return
end

function var_0_11.SetInputPoint(arg_31_0, arg_31_1)
	Clone = var_1_10002
	arg_31_0._inputPoint = var_1_10002(arg_31_1)

	return
end

function var_0_11.GetInputPoint(arg_32_0)
	return arg_32_0._inputPoint
end

function var_0_11.GetClient(arg_33_0)
	return arg_33_0._client
end

function var_0_11.QueueFinish(arg_34_0, arg_34_1)
	if arg_34_1:GetBranch() then
		local var_34_0 = {}

		pairs = var_1_10004

		for iter_34_0, iter_34_1 in var_1_10004(var_2) do
			local var_34_1 = var_0_5.parseCompare
			local var_34_2 = iter_34_1
			local var_34_3 = arg_34_0._client

			if var_34_1(var_34_2, var_11.GetAttrManager(var_34_3)) then
				var_34_0[iter_34_0] = true
			end
		end

		local var_34_4

		if arg_34_1:GetQueueType() == var_0.Battle.BattleCardPuzzleCardEffectQueue.QUEUE_TYPE_RETURN then
			local var_34_5 = arg_34_0._returnBranchQueueList
		else
			local var_34_6 = arg_34_0._branchQueueList
		end

		pairs = var_5

		for iter_34_2, iter_34_3 in var_5(var_34_0) do
			local var_34_7 = arg_34_0._branchQueueList[iter_34_2]

			var_10.Start(var_34_7)
		end
	end

	return
end

function var_0_11.initCardEffectList(arg_35_0)
	arg_35_0._holdForInputMark = false
	arg_35_0._moveAfterCaster = var_0.Battle.BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_DISCARD

	local var_35_0 = {}

	arg_35_0._branchQueueList = {}
	arg_35_0._queueList = var_35_0
	ipairs = var_35_0

	for iter_35_0, iter_35_1 in var_35_0(arg_35_0._effectList) do
		local var_35_1 = var_0.Battle.BattleCardPuzzleCardEffectQueue.New(arg_35_0)

		var_6.ConfigData(var_35_1, iter_35_1)
		var_6:SetQueueType(var_0.Battle.BattleCardPuzzleCardEffectQueue.QUEUE_TYPE_NORMAL)

		table = var_7

		var_7.insert(arg_35_0._queueList, var_6)

		if var_6:GetHoldForInputMark() then
			arg_35_0._holdForInputMark = true
		end
	end

	pairs = var_1

	for iter_35_2, iter_35_3 in var_1(arg_35_0._effectList) do
		local var_35_2 = var_0.Battle.BattleCardPuzzleCardEffectQueue.New(arg_35_0)

		var_6.ConfigData(var_35_2, iter_35_3)
		var_6:SetQueueType(var_0.Battle.BattleCardPuzzleCardEffectQueue.QUEUE_TYPE_NORMAL)

		arg_35_0._branchQueueList[iter_35_2] = var_6
	end

	if arg_35_0._returnCost then
		local var_35_3 = {}

		arg_35_0._returnBranchQueueList = {}
		arg_35_0._returnQueueList = var_35_3
		ipairs = var_35_3

		for iter_35_4, iter_35_5 in var_35_3(arg_35_0._shuffleEffectList) do
			local var_35_4 = var_0.Battle.BattleCardPuzzleCardEffectQueue.New(arg_35_0)

			var_6.ConfigData(var_35_4, iter_35_5)
			var_6:SetQueueType(var_0.Battle.BattleCardPuzzleCardEffectQueue.QUEUE_TYPE_RETURN)

			table = var_7

			var_7.insert(arg_35_0._returnQueueList, var_6)
		end

		pairs = var_1

		for iter_35_6, iter_35_7 in var_1(arg_35_0._shuffleEffectList) do
			local var_35_5 = var_0.Battle.BattleCardPuzzleCardEffectQueue.New(arg_35_0)

			var_6.ConfigData(var_35_5, iter_35_7)
			var_6:SetQueueType(var_0.Battle.BattleCardPuzzleCardEffectQueue.QUEUE_TYPE_RETURN)

			arg_35_0._returnBranchQueueList[iter_35_6] = var_6
		end
	end

	return
end

function var_0_11.checkAndStartQueue(arg_36_0, arg_36_1)
	local var_36_0 = {}

	ipairs = var_1_10003

	for iter_36_0, iter_36_1 in var_1_10003(arg_36_1) do
		if iter_36_1:GetCondition() then
			local var_36_1 = var_0_5.parseCompare
			local var_36_2 = var_8
			local var_36_3 = arg_36_0._client

			if not var_36_1(var_36_2, var_11.GetAttrManager(var_36_3)) then
				var_36_0[iter_36_0] = false

				goto label_36_0
			end
		end

		arg_36_0._moveAfterCaster = iter_36_1:GetMoveAfterCast()
		var_36_0[iter_36_0] = true

		::label_36_0::
	end

	pairs = var_3

	for iter_36_2, iter_36_3 in var_3(var_36_0) do
		if iter_36_3 == true then
			local var_36_4 = arg_36_1[iter_36_2]

			var_8.Start(var_36_4)
		end
	end

	return
end

function var_0_11.GetCardEffectTargetFilterList(arg_37_0)
	local var_37_0 = {}

	ipairs = var_1_10002

	for iter_37_0, iter_37_1 in var_1_10002(arg_37_0._effectList) do
		if iter_37_1.condition then
			local var_37_1 = var_0_5.parseCompare
			local var_37_2 = iter_37_1.condition
			local var_37_3 = arg_37_0._client

			if var_37_1(var_37_2, var_9.GetAttrManager(var_37_3)) then
				arg_37_0:checkQueueTarget(iter_37_1, var_37_0)
			end
		end
	end

	return var_37_0
end

var_0_11.AIM_FX_EFFECT = {
	"BattleCardPuzzleSkillFire"
}

function var_0_11.checkQueueTarget(arg_38_0, arg_38_1, arg_38_2)
	ipairs = var_1_10003

	for iter_38_0, iter_38_1 in var_1_10003(arg_38_1) do
		table = var_1_10008

		if var_1_10008.contains(var_0_11.AIM_FX_EFFECT, iter_38_1.type) and iter_38_1.target_choise then
			if not arg_38_2[iter_38_1.caster] then
				var_1_10008 = {}
			end

			table = var_9

			var_9.insert(var_1_10008, iter_38_1.target_choise)

			arg_38_2[iter_38_1.caster] = var_1_10008
		end
	end

	if arg_38_1.branch then
		pairs = var_3

		for iter_38_2, iter_38_3 in var_3(arg_38_1.branch) do
			local var_38_0 = var_0_5.parseCompare
			local var_38_1 = iter_38_3
			local var_38_2 = arg_38_0._client

			if var_38_0(var_38_1, var_10.GetAttrManager(var_38_2)) then
				arg_38_0:checkQueueTarget(arg_38_0._effectList[iter_38_2])
			end
		end
	end

	return
end

function var_0_11.GetIconPath(arg_39_0)
	CardPuzzleCard = var_1_10001

	return var_1_10001.GetCardIconPath(arg_39_0:GetCardTemplate().icon)
end

function var_0_11.GetType(arg_40_0)
	return arg_40_0:GetCardType()
end

function var_0_11.GetName(arg_41_0)
	return arg_41_0:GetCardTemplate().name
end

function var_0_11.GetDesc(arg_42_0)
	return arg_42_0:GetCardTemplate().discript
end

function var_0_11.GetCost(arg_43_0)
	return arg_43_0:GetTotalCost()
end

function var_0_11.GetKeywords(arg_44_0)
	CardPuzzleCard = var_1_10001

	return var_1_10001.GetCardKeyWord(arg_44_0:GetCardTemplate().label)
end

function var_0_11.getConfig(arg_45_0, arg_45_1)
	return arg_45_0._cardTemp[arg_45_1]
end

return
