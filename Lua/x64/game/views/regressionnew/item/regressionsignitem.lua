local var_0_0 = class("RegressionSignItem", ReduxView)

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

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.commonItem_ = CommonItemView.New(arg_3_0.m_item)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_button, nil, function()
		if not RegressionDataNew:IsRegressionOpen() then
			ShowTips("TIME_OVER")

			return
		end

		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.index)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index = arg_6_1
	arg_6_0.m_dayLab.text = arg_6_1

	local var_6_0 = SignCfg[arg_6_2]

	if var_6_0 then
		if not arg_6_0.itemData_ then
			arg_6_0.itemData_ = clone(ItemTemplateData)

			function arg_6_0.itemData_.clickFun(arg_7_0)
				ShowPopItem(POP_ITEM, {
					arg_7_0.id,
					arg_7_0.number
				})
			end
		end

		arg_6_0.itemData_.id = var_6_0.reward[1]
		arg_6_0.itemData_.number = var_6_0.reward[2]

		arg_6_0.commonItem_:SetData(arg_6_0.itemData_)
	end

	arg_6_0:Refresh()
end

function var_0_0.Refresh(arg_8_0)
	local var_8_0 = RegressionDataNew:IsSignReward(arg_8_0.index)
	local var_8_1 = RegressionDataNew:GetSignIndex()

	if var_8_0 then
		arg_8_0.stateController:SetSelectedIndex(2)
	elseif var_8_1 >= arg_8_0.index then
		arg_8_0.stateController:SetSelectedIndex(1)
	else
		arg_8_0.stateController:SetSelectedIndex(0)
	end
end

function var_0_0.RegistCallBack(arg_9_0, arg_9_1)
	arg_9_0.callback_ = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.commonItem_:Dispose()

	arg_10_0.commonItem_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
