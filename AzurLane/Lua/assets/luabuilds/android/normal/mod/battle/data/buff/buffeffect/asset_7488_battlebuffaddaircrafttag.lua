ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffAddAircraftTag = var_0_10002("BattleBuffAddAircraftTag", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffAddAircraftTag.__name = "BattleBuffAddAircraftTag"

local var_0_2 = var_0.Battle.BattleBuffAddAircraftTag

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._labelTag = arg_2_0._tempData.arg_list.tag_list

	return
end

function var_0_2.onAircraftCreate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_0

	if not arg_3_0.equipIndexRequire(var_3_0, arg_3_3.equipIndex) then
		return
	end

	local var_3_1 = arg_3_3.aircraft

	ipairs = var_3_0

	for iter_3_0, iter_3_1 in var_3_0(arg_3_0._labelTag) do
		string = var_1_10010

		if var_1_10010.find(iter_3_1, "^[NT]_%d+$") then
			pg = var_1_10010

			local var_3_2 = var_1_10010.TipsMgr.GetInstance()

			var_1_10010.ShowTips(var_3_2, ">>BattleBuffAddAircraftTag<<不允许使用'N_'或'T_'标签")
		else
			var_3_1:AddLabelTag(iter_3_1)
		end
	end

	return
end

return
