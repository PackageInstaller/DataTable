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
local var_0_7 = var_0.Battle.BattleAttr
local var_0_8 = var_0.Battle.BattleDataFunction
local var_0_9 = var_0.Battle.BattleAttr

class = var_0_10010

local var_0_10 = var_0_10010("BattleFleetCardPuzzleFleetBuffManager")

var_0.Battle.BattleFleetCardPuzzleFleetBuffManager = var_0_10
var_0_10.__name = "BattleFleetCardPuzzleFleetBuffManager"

function var_0_10.Ctor(arg_1_0, arg_1_1)
	arg_1_0._client = arg_1_1

	arg_1_0:init()

	return
end

function var_0_10.Trigger(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = {}

	pairs = var_1_10004

	for iter_2_0, iter_2_1 in var_1_10004(arg_2_0._buffList) do
		if iter_2_1:IsResponTo(arg_2_1) then
			table = var_9

			var_9.insert(var_2_0, iter_2_1)
		end
	end

	ipairs = var_4

	for iter_2_2, iter_2_3 in var_4(var_2_0) do
		iter_2_3:onTrigger(arg_2_1, arg_2_2)
	end

	return
end

function var_0_10.Update(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._buffList

	pairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(var_3_0) do
		iter_3_1:Update(arg_3_1)
	end

	return
end

function var_0_10.AttachCardPuzzleBuff(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetID()

	if arg_4_0:GetCardPuzzleBuff(var_4_0) then
		var_3:Stack()
	else
		arg_4_0._buffList[var_4_0] = arg_4_1

		arg_4_1:Attach(arg_4_0._client)
	end

	return
end

function var_0_10.GetCardPuzzleBuff(arg_5_0, arg_5_1)
	return arg_5_0._buffList[arg_5_1]
end

function var_0_10.GetCardPuzzleBuffList(arg_6_0)
	return arg_6_0._buffList
end

function var_0_10.init(arg_7_0)
	arg_7_0._buffList = {}

	return
end

return
