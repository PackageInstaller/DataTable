local var_0_0 = class("ActivityNewbieSignItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "conName")

	arg_1_0:AddListeners()

	arg_1_0.refreshHandler_ = handler(arg_1_0, arg_1_0.ZeroTimeRefresh)

	manager.notify:RegistListener(ZERO_REFRESH, arg_1_0.refreshHandler_)
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.button_, nil, function()
		arg_2_0:OnSign()
	end)
end

function var_0_0.OnSign(arg_4_0)
	if manager.time:GetTodayFreshTime() > ActivityNewbieData:GetSignTimestamp() then
		local var_4_0 = table.keyof(ActivityNewbieTools.GetSignCfg(), arg_4_0.id_)

		if ActivityNewbieData:GetSignDay() + 1 == var_4_0 then
			ActivityNewbieAction.NewbieSignIn(function(arg_5_0)
				if isSuccess(arg_5_0.result) then
					ActivityNewbieData:SignIn()
					getReward2(arg_5_0.reward_list)
					arg_4_0.controller_:SetSelectedState("2")
				else
					ShowTips(arg_5_0.result)
				end
			end)
		end
	end
end

function var_0_0.ZeroTimeRefresh(arg_6_0)
	arg_6_0:RefreshUI(arg_6_0.id_)
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1)
	if arg_7_0.id_ ~= arg_7_1 then
		local var_7_0 = SignCfg[arg_7_1].reward

		arg_7_0.itemData_ = clone(ItemTemplateData)
		arg_7_0.itemData_.id = var_7_0[1]
		arg_7_0.itemData_.number = var_7_0[2]

		function arg_7_0.itemData_.clickFun(arg_8_0)
			local var_8_0 = table.keyof(ActivityNewbieTools.GetSignCfg(), arg_7_1)

			if manager.time:GetTodayFreshTime() > ActivityNewbieData:GetSignTimestamp() and ActivityNewbieData:GetSignDay() + 1 == var_8_0 then
				arg_7_0:OnSign()
			else
				ShowPopItem(POP_SOURCE_ITEM, {
					arg_8_0.id,
					arg_8_0.number
				})
			end
		end

		arg_7_0.id_ = arg_7_1
	end

	if not arg_7_0.rewardGo_ then
		arg_7_0.rewardGo_ = CommonItemView.New(arg_7_0.itemGo_)
	end

	arg_7_0.rewardGo_:SetData(arg_7_0.itemData_)

	local var_7_1 = table.keyof(ActivityNewbieTools.GetSignCfg(), arg_7_1)

	arg_7_0.textDay_.text = var_7_1

	if var_7_1 <= ActivityNewbieData:GetSignDay() then
		arg_7_0.controller_:SetSelectedState("2")
	else
		arg_7_0.controller_:SetSelectedState("0")
	end

	if manager.time:GetTodayFreshTime() > ActivityNewbieData:GetSignTimestamp() and ActivityNewbieData:GetSignDay() + 1 == var_7_1 then
		arg_7_0.controller_:SetSelectedState("1")
	end
end

function var_0_0.Dispose(arg_9_0)
	manager.notify:RemoveListener(ZERO_REFRESH, arg_9_0.refreshHandler_)

	arg_9_0.refreshHandler_ = nil

	if arg_9_0.rewardGo_ then
		arg_9_0.rewardGo_:Dispose()

		arg_9_0.rewardGo_ = nil
	end

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
