local var_0_0 = class("MatrixShopItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.qualityController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "quality")
	arg_3_0.starController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "star")
	arg_3_0.canvasGroup_ = arg_3_0.nonullGo_:GetComponent(typeof(CanvasGroup))
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, nil, "OnClick")
end

function var_0_0.OnClick(arg_5_0)
	if arg_5_0.clickFunc then
		arg_5_0.clickFunc(arg_5_0.terminalId_)
	end
end

function var_0_0.RegistCallBack(arg_6_0, arg_6_1)
	arg_6_0.clickFunc = arg_6_1
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.terminalId_ = arg_7_1
	arg_7_0.matrixItem_ = MatrixItemCfg[arg_7_1]
	arg_7_0.terminalCfg_ = MatrixTerminalCfg[arg_7_1]

	arg_7_0:UpdateView()
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.nameText_.text = string.format("%s x%d", GetI18NText(arg_8_0.terminalCfg_.name), 1)

	arg_8_0.icon_:SetNativeSize()
end

function var_0_0.OnEnter(arg_9_0)
	return
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.GetItemInfo(arg_11_0)
	return arg_11_0.data_
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.clickFunc = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
