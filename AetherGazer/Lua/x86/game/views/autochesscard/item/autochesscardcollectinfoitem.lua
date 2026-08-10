local var_0_0 = class("AutoChessCardCollectInfoItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.mode_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_3_0)
	local var_3_0 = #AutoChessCardCfg.get_id_list_by_type_is_card_pool[arg_3_0.mode_][1]
	local var_3_1 = AutoChessCardData:GetCardNumByType(arg_3_0.mode_)
	local var_3_2 = math.floor(var_3_1 * 100 / var_3_0)

	arg_3_0.progressImg_.fillAmount = var_3_2 / 100
	arg_3_0.txtRatio_.text = string.format("%s%%", var_3_2)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
