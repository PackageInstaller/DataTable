ys = ys or {}

local var_0_9 = class("BattleFleetCardPuzzleFleetBuffManager")

ys.Battle.BattleFleetCardPuzzleFleetBuffManager = var_0_9
var_0_9.__name = "BattleFleetCardPuzzleFleetBuffManager"

function var_0_9.Ctor(arg_1_0, arg_1_1)
	arg_1_0._client = arg_1_1

	arg_1_0:init()

	return
end

function var_0_9.Trigger(arg_2_0, arg_2_1, arg_2_2)
	for iter_2_0, iter_2_1 in pairs(arg_2_0._buffList) do
		if iter_2_1:IsResponTo(arg_2_1) then
			table.insert({}, iter_2_1)
		end
	end

	for iter_2_2, iter_2_3 in ipairs({}) do
		iter_2_3:onTrigger(arg_2_1, arg_2_2)
	end

	return
end

function var_0_9.Update(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0._buffList) do
		iter_3_1:Update(arg_3_1)
	end

	return
end

function var_0_9.AttachCardPuzzleBuff(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetID()
	local var_4_1 = arg_4_0:GetCardPuzzleBuff(var_4_0)

	if var_4_1 then
		var_4_1:Stack()
	else
		arg_4_0._buffList[var_4_0] = arg_4_1

		arg_4_1:Attach(arg_4_0._client)
	end

	return
end

function var_0_9.GetCardPuzzleBuff(arg_5_0, arg_5_1)
	return arg_5_0._buffList[arg_5_1]
end

function var_0_9.GetCardPuzzleBuffList(arg_6_0)
	return arg_6_0._buffList
end

function var_0_9.init(arg_7_0)
	arg_7_0._buffList = {}

	return
end

return
