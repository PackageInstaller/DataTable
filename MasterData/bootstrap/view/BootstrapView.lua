module("bootstrap.view.BootstrapView", package.seeall)

local var_0_0 = class("BootstrapView")

function var_0_0.ctor(arg_1_0)
	arg_1_0._go = nil
end

function var_0_0.buildUI(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0._btnRepair = Astral.ButtonAdapter.Get(arg_2_1.transform:Find("btnList/btnRepair").gameObject)
end

function var_0_0.destroyUI(arg_3_0)
	arg_3_0:unbindEvents()
end

function var_0_0.onEnter(arg_4_0)
	arg_4_0:bindEvents()
end

function var_0_0.bindEvents(arg_5_0)
	arg_5_0._btnRepair:AddClickListener(arg_5_0._onClickRepair, arg_5_0)
end

function var_0_0.unbindEvents(arg_6_0)
	arg_6_0._btnRepair:RemoveClickListener()
end

function var_0_0._onClickRepair(arg_7_0)
	BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.getTipsTextByKey("confirm"), BootstrapLanguage.getTipsTextByKey("cancel"))
	BootstrapMsgBoxView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a35"))
	BootstrapMsgBoxView.show(true, BootstrapMsgBoxView.KEY_QUIT)
end

var_0_0.instance = var_0_0.New()

return var_0_0
