local var_0_0 = class("AutoChessURFactoryItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.GetItem(arg_3_0, arg_3_1)
	local var_3_0 = AutoChessCardCfg[arg_3_1]

	if var_3_0 == nil or var_3_0.type ~= AutoChessCardConst.CARD_TYPE.UR then
		return nil
	end

	local var_3_1 = table.indexof(AutoChessCardCfg.get_id_list_by_type_is_card_pool[AutoChessCardConst.CARD_TYPE.UR][1], arg_3_1)

	return arg_3_0["item" .. var_3_1 .. "_"]
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
