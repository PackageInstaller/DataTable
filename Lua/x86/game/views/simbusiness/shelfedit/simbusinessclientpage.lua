local var_0_0 = class("SimBusinessClientPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.itemLable = SimBusinessSellGoodSmallItem.New(arg_3_0.lableGo)
	arg_3_0.clientItem = SimBusinessGuestInfoItem.New(arg_3_0.clientGo)
end

function var_0_0.RefreshView(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.id = arg_4_1
	arg_4_0.cfg = SimBusinessGuestCfg[arg_4_1]

	if arg_4_0.cfg then
		arg_4_0.name.text = arg_4_0.cfg.name

		arg_4_0.itemLable:RefreshView(arg_4_0.cfg.love_type, SimBusinessConst.ShowItmeType.good)
		arg_4_0.clientItem:RefreshData({
			id = arg_4_1
		}, nil, false, false)

		if arg_4_2 then
			arg_4_0.needNum.text = arg_4_2
		end

		arg_4_0.skillTex.text = arg_4_0.cfg.skill_desc
	end
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.clientItem:Dispose()
	arg_6_0.itemLable:Dispose()
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
