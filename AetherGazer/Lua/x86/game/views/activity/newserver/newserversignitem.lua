local var_0_0 = class("NewServerSignItem", ReduxView)

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

	arg_3_0.stateController_ = arg_3_0.controllerEx_:GetController("state")
	arg_3_0.commonItem_ = CommonItemView.New(arg_3_0.commonItemGo_)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.button_, nil, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.index_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index_ = arg_6_1
	arg_6_0.descText_.text = string.format(GetTips("NEW_SERVER_SIGN_DAY"), arg_6_1)

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
	local var_8_0 = NewServerData:IsSignReward(arg_8_0.index_)
	local var_8_1 = NewServerData:GetSignIndex()

	if var_8_0 then
		arg_8_0.stateController_:SetSelectedIndex(2)
	elseif var_8_1 >= arg_8_0.index_ then
		arg_8_0.stateController_:SetSelectedIndex(1)
	else
		arg_8_0.stateController_:SetSelectedIndex(0)
	end
end

function var_0_0.RegistCallBack(arg_9_0, arg_9_1)
	arg_9_0.callback_ = arg_9_1
end

function var_0_0.OnSign(arg_10_0)
	local var_10_0 = arg_10_0.commonItem_:GetData()
	local var_10_1 = NewServerData:IsSignReward(arg_10_0.index_)
	local var_10_2 = NewServerData:GetSignIndex()

	if not var_10_1 and var_10_2 >= arg_10_0.index_ then
		var_10_0.highLight = true
	else
		var_10_0.highLight = false
	end

	arg_10_0.commonItem_:SetData(var_10_0)
	arg_10_0:Refresh()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.commonItem_:Dispose()

	arg_11_0.commonItem_ = nil

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
