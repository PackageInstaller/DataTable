local var_0_0 = class("BilliardGameIlluItemView", ReduxView)

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

	arg_3_0.statusController_ = arg_3_0.exController_:GetController("status")
	arg_3_0.selectController_ = arg_3_0.exController_:GetController("select")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.index_ = arg_4_1
	arg_4_0.active_ = arg_4_2.active
	arg_4_0.id_ = arg_4_2.id
	arg_4_0.select_ = arg_4_2.select
	arg_4_0.viewState_ = arg_4_2.viewState

	local var_4_0 = string.format("%s_%s", RedPointConst.SUMMER_PUB_ILLUSTRATION, arg_4_2.id)

	manager.redPoint:bindUIandKey(arg_4_0.transform_:GetChild(0).gameObject.transform, var_4_0)

	if arg_4_0.active_ then
		arg_4_0.titleIcon_.sprite = pureGetSpriteWithoutAtlas(BilliardIllustrationsCfg[arg_4_0.id_].little_icon)
		arg_4_0.nameText_.text = GetI18NText(BilliardIllustrationsCfg[arg_4_0.id_].name)

		arg_4_0.statusController_:SetSelectedIndex(1)
	else
		arg_4_0.nameText_.text = GetI18NText("???")

		arg_4_0.statusController_:SetSelectedIndex(0)
	end

	if arg_4_0.select_ then
		arg_4_0.selectController_:SetSelectedState("select")
	else
		arg_4_0.selectController_:SetSelectedState("unselect")
	end

	if arg_4_0.viewState_ == 1 then
		manager.redPoint:setTip(var_4_0, 1)
	else
		manager.redPoint:setTip(var_4_0, 0)
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.itemBtn_, nil, function()
		if arg_5_0.func_ then
			arg_5_0.func_(arg_5_0.index_)
		end
	end)
end

function var_0_0.RegisterBtnListener(arg_7_0, arg_7_1)
	arg_7_0.func_ = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.ShowSelect(arg_9_0, arg_9_1)
	arg_9_0.select_ = arg_9_1

	if arg_9_0.select_ then
		local var_9_0 = string.format("%s_%s", RedPointConst.SUMMER_PUB_ILLUSTRATION, arg_9_0.id_)

		arg_9_0.selectController_:SetSelectedState("select")

		arg_9_0.viewState_ = 2

		manager.redPoint:setTip(var_9_0, 0)
	else
		arg_9_0.selectController_:SetSelectedState("unselect")
	end
end

return var_0_0
