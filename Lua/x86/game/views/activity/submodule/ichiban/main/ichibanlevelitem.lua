local var_0_0 = class("IchiBanLevelItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.levelController_ = arg_1_0.uiControllerEx_:GetController("color")
	arg_1_0.isFirstPosController_ = arg_1_0.uiControllerEx_:GetController("isFirstPos")
	arg_1_0.isGotController_ = arg_1_0.uiControllerEx_:GetController("isGot")
	arg_1_0.commonItem_ = CommonItemView.New(arg_1_0.uiItem_, true)
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.commonItem_:Dispose()

	arg_2_0.commonItem_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.cfg_ = arg_4_2

	local var_4_0 = arg_4_2.level

	arg_4_0.levelController_:SetSelectedState(tostring(var_4_0))
	arg_4_0.isFirstPosController_:SetSelectedState(arg_4_1 % 4 == 1 and "true" or "false")

	local var_4_1 = IchiBanTools.GetLevelPosReward(arg_4_2.id, arg_4_1)

	if var_4_1 == nil then
		arg_4_0.isGotController_:SetSelectedState("false")

		arg_4_0.itemData_ = nil

		arg_4_0.uiAnimator_:Play("New State")
	else
		arg_4_0.isGotController_:SetSelectedState("true")

		if not arg_4_0.itemData_ then
			arg_4_0.itemData_ = clone(ItemTemplateData)

			function arg_4_0.itemData_.clickFun(arg_5_0)
				ShowPopItem(POP_ITEM, {
					arg_5_0.id,
					arg_5_0.number
				})
			end
		end

		arg_4_0.itemData_.id = var_4_1[1]
		arg_4_0.itemData_.number = var_4_1[2]

		if IchiBanTools.NeedPlayItemAnimator(arg_4_2, arg_4_1) then
			arg_4_0.uiAnimator_:Play("ticketItem_get", 0, 0)
			arg_4_0.uiAnimator_:Update(0)
		else
			arg_4_0.uiAnimator_:Play("ticketItem_get", 0, 1)
		end
	end

	arg_4_0.commonItem_:SetData(arg_4_0.itemData_)
end

return var_0_0
