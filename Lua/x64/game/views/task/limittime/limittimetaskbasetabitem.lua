local var_0_0 = class("LimitTimeTaskBaseTabItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.selectController_ = arg_2_0.mainControllerEx_:GetController("select")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.selectBtn_, nil, function()
		arg_4_0:OnSelectBtnClick()
	end)
end

function var_0_0.OnSelectBtnClick(arg_6_0)
	arg_6_0.onClick_(arg_6_0.index_)
end

function var_0_0.SetSelectedState(arg_7_0, arg_7_1)
	local var_7_0 = false

	if arg_7_0.index_ == arg_7_1 then
		var_7_0 = true
	end

	arg_7_0.selectController_:SetSelectedState(var_7_0 and "select" or "upselect")
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.index_ = arg_8_1
	arg_8_0.subActivityID_ = arg_8_2
	arg_8_0.onClick_ = arg_8_3

	arg_8_0:UpdateView()
end

function var_0_0.SetTabRedPointKey(arg_9_0, arg_9_1)
	arg_9_0.redPointKey_ = arg_9_1

	local var_9_0 = arg_9_0.redPointKey_ .. arg_9_0.subActivityID_

	manager.redPoint:bindUIandKey(arg_9_0.transform_, var_9_0)
end

function var_0_0.UpdateView(arg_10_0)
	local var_10_0 = LimitTimeTaskCfg[arg_10_0.subActivityID_]

	if not var_10_0 then
		return
	end

	arg_10_0.upsText_.text = var_10_0.name
	arg_10_0.sText_.text = var_10_0.name

	local var_10_1 = var_10_0.icon

	arg_10_0.upsImg_.sprite = getSpriteWithoutAtlas(var_10_1)
	arg_10_0.sImg_.sprite = getSpriteWithoutAtlas(var_10_1)
end

function var_0_0.Show(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

function var_0_0.OnExit(arg_12_0)
	manager.redPoint:unbindUIandKey(arg_12_0.transform_)
end

function var_0_0.GetActivityID(arg_13_0)
	return arg_13_0.subActivityID_
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()
	Object.Destroy(arg_14_0.gameObject_)
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
