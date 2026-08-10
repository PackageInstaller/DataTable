local var_0_0 = class("SkinDiscountGiftMainSignItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateController_ = arg_1_0.controllerEx_:GetController("state")
	arg_1_0.commonItem_ = CommonItemView.New(arg_1_0.commonItem_)
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.commonItem_:Dispose()

	arg_2_0.commonItem_ = nil
	arg_2_0.itemData_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.activityID_ = arg_4_1

	local var_4_0 = SkinDiscountGiftTools.GetSignState(arg_4_1, arg_4_2)

	if var_4_0 == ActivityConst.SIGN_STATE.GETTED then
		arg_4_0.stateController_:SetSelectedState("state2")
	elseif var_4_0 == ActivityConst.SIGN_STATE.CAN_GET then
		arg_4_0.stateController_:SetSelectedState("state1")
	else
		arg_4_0.stateController_:SetSelectedState("state0")
	end

	local var_4_1 = SignCfg[arg_4_3].reward

	if not arg_4_0.itemData_ then
		arg_4_0.itemData_ = clone(ItemTemplateData)

		function arg_4_0.itemData_.clickFun(arg_5_0)
			local var_5_0 = SkinDiscountGiftTools.GetSignState(arg_4_1, arg_4_2)

			if var_5_0 == ActivityConst.SIGN_STATE.GETTED then
				ShowPopItem(POP_ITEM, {
					arg_5_0.id,
					arg_5_0.number
				})
			elseif var_5_0 == ActivityConst.SIGN_STATE.CAN_GET then
				if not ActivityData:GetActivityIsOpen(arg_4_1) then
					ShopTips("TIME_OVER")

					return
				end

				SignAction.QuerySevenDaySign(arg_4_1)
			else
				ShowPopItem(POP_ITEM, {
					arg_5_0.id,
					arg_5_0.number
				})
			end
		end
	end

	arg_4_0.itemData_.id = var_4_1[1]
	arg_4_0.itemData_.number = var_4_1[2]
	arg_4_0.itemData_.completedFlag = var_4_0 == ActivityConst.SIGN_STATE.GETTED

	arg_4_0.commonItem_:SetData(arg_4_0.itemData_)

	arg_4_0.dayText_.text = string.format(GetI18NText(GetTips("SIGN_DAY")), arg_4_2)
end

return var_0_0
