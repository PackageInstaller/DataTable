local var_0_0 = class("DrawServantNormalPool", DrawBasePool)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Asset.Load("Widget/System/Pool/TreasurePool")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.poolId = arg_1_2
	arg_1_0.showId = arg_1_3
	arg_1_0.detailBtnList_ = {}
	arg_1_0.btnNameList_ = {}

	arg_1_0:Init()
end

function var_0_0.AddUIListener(arg_2_0)
	return
end

function var_0_0.SetActive(arg_3_0, arg_3_1)
	var_0_0.super.SetActive(arg_3_0, arg_3_1)
end

return var_0_0
