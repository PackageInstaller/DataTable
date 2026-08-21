local var_0_0 = class("AutoChessRankTrophyItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.trophy = AutoChessSettleTrophyItemView.New(arg_2_0.trophyObj_)
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.trophy:Dispose()

	arg_3_0.trophy = nil
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	return
end

return var_0_0
