ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleDrops")

var_0.Battle.BattleDrops = var_0_1
var_0_1.__name = "BattleDrops"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0.EventDispatcher.AttachEventDispatcher(arg_1_0)

	arg_1_0._dropList = arg_1_1
	arg_1_0._resourceCount = 0
	arg_1_0._itemCount = 0

	return
end

function var_0_1.CreateDrops(arg_2_0, arg_2_1)
	local var_2_0 = {}

	if arg_2_0._dropList[arg_2_1] ~= nil and #var_3 > 0 then
		var_2_0 = var_3[#var_3]
		var_3[#var_3] = nil
	end

	if var_2_0.resourceCount ~= nil then
		arg_2_0._resourceCount = arg_2_0._resourceCount + var_2_0.resourceCount
	end

	if var_2_0.itemCount ~= nil then
		arg_2_0._itemCount = arg_2_0._itemCount + var_2_0.itemCount
	end

	return var_2_0
end

function var_0_1.GetDropped(arg_3_0)
	return arg_3_0._resourceCount, arg_3_0._itemCount
end

function var_0_1.Dispose(arg_4_0)
	var_0.EventDispatcher.DetachEventDispatcher(arg_4_0)

	return
end

return
