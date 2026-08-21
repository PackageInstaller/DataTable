local var_0_0 = class("IlluWorldIViewItem", ReduxView)

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

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "conName")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.index_ = arg_4_1
	arg_4_0.info_ = arg_4_2
	arg_4_0.isFirst_ = arg_4_0.info_.isFirst
	arg_4_0.id_ = arg_4_0.info_.id
	arg_4_0.nameText_.text = GetI18NText(CollectWordCfg[arg_4_0.id_].name)

	arg_4_0:ShowSelect2(arg_4_2.select)

	arg_4_0.isRead_ = IllustratedData:GetInfoIsView(CollectConst.WORLDVIEW, arg_4_0.id_)

	if arg_4_0.isFirst_ then
		manager.redPoint:SetRedPointIndependent(arg_4_0.transform_, false)

		if arg_4_0.isRead_ == 0 then
			IllustratedAction.ViewIllustration(arg_4_0.id_, CollectConst.WORLDVIEW)
		end

		arg_4_0.info_.isFirst = false
	else
		manager.redPoint:SetRedPointIndependent(arg_4_0.transform_, arg_4_0.isRead_ == 0, nil)
	end
end

function var_0_0.ShowSelect(arg_5_0, arg_5_1)
	arg_5_0.info_.select = arg_5_1

	if arg_5_1 then
		arg_5_0.controller_:SetSelectedState("sel")

		if arg_5_0.isRead_ == 0 then
			IllustratedAction.ViewIllustration(arg_5_0.id_, CollectConst.WORLDVIEW)
		end

		manager.redPoint:SetRedPointIndependent(arg_5_0.transform_, false)
	else
		arg_5_0.controller_:SetSelectedState("notSel")
	end
end

function var_0_0.ShowSelect2(arg_6_0, arg_6_1)
	arg_6_0.info_.select = arg_6_1

	if arg_6_1 then
		arg_6_0.controller_:SetSelectedState("sel")
	else
		arg_6_0.controller_:SetSelectedState("notSel")
	end
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.itemBtn_, nil, function()
		if arg_7_0.func_ then
			arg_7_0.func_(arg_7_0.index_)
		end
	end)
end

function var_0_0.RegisterBtnListener(arg_9_0, arg_9_1)
	arg_9_0.func_ = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
