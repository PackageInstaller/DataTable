local var_0_0 = class("SimBusinessSellGoodSmallItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:BindBg()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super:Dispose(arg_2_0)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil
end

function var_0_0.BindBg(arg_3_0)
	arg_3_0.bg = {}

	for iter_3_0 = 0, arg_3_0.bgRoot_.childCount - 1 do
		local var_3_0 = arg_3_0.bgRoot_:GetChild(iter_3_0)

		arg_3_0.bg[var_3_0.gameObject.name] = var_3_0.gameObject
	end
end

local function var_0_1(arg_4_0, arg_4_1)
	if arg_4_1 == SimBusinessConst.ShowItmeType.shelf then
		return tostring(arg_4_0 + 1)
	end

	return tostring(arg_4_0)
end

function var_0_0.RefreshView(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.id = arg_5_1

	local var_5_0
	local var_5_1
	local var_5_2 = var_0_1(arg_5_1, arg_5_2)

	if arg_5_2 == SimBusinessConst.ShowItmeType.good then
		var_5_1 = GetTips(SimBusinessConst.GoodTypeDesc[arg_5_1])
	elseif arg_5_2 == SimBusinessConst.ShowItmeType.shelf then
		local var_5_3 = SimBusinessConst.OrientationType[arg_5_1]

		var_5_1 = GetTips(var_5_3)
	elseif arg_5_2 == SimBusinessConst.ShowItmeType.effect then
		var_5_2, var_5_1 = "", ""
	end

	arg_5_0.name_.text = var_5_1

	for iter_5_0, iter_5_1 in pairs(arg_5_0.bg) do
		SetActive(iter_5_1, iter_5_0 == var_5_2)
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
