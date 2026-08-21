local var_0_0 = class("SevenDaySkinItem_3_0", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.rareController_ = arg_2_0.controllerExCollection_:GetController("quality")
	arg_2_0.starController_ = arg_2_0.controllerExCollection_:GetController("star")
	arg_2_0.pointController_ = arg_2_0.controllerExCollection_:GetController("point")
	arg_2_0.highLightController_ = arg_2_0.controllerExCollection_:GetController("award")
	arg_2_0.completedController_ = arg_2_0.controllerExCollection_:GetController("completed")
	arg_2_0.grayController_ = arg_2_0.controllerExCollection_:GetController("gray")
	arg_2_0.repController_ = arg_2_0.controllerExCollection_:GetController("replenishment")
end

function var_0_0.RefreshView(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.item = arg_3_1
	arg_3_0.isResign = arg_3_3

	local var_3_0 = arg_3_1[1]
	local var_3_1 = arg_3_1[2]

	arg_3_0.rewardState = arg_3_2

	local var_3_2 = ItemCfg[var_3_0].display_rare

	arg_3_0.bottomAmountText_.text = var_3_1

	arg_3_0.rareController_:SetSelectedIndex(var_3_2)
	arg_3_0.starController_:SetSelectedIndex(var_3_2)

	arg_3_0.iconImage_.sprite = ItemTools.getItemSprite(var_3_0)

	if arg_3_2 == 0 then
		if arg_3_3 then
			arg_3_0.highLightController_:SetSelectedIndex(0)
			arg_3_0.completedController_:SetSelectedIndex(0)
			arg_3_0.grayController_:SetSelectedIndex(0)
			arg_3_0.pointController_:SetSelectedIndex(1)
			arg_3_0.repController_:SetSelectedIndex(0)
		else
			arg_3_0.highLightController_:SetSelectedIndex(0)
			arg_3_0.completedController_:SetSelectedIndex(0)
			arg_3_0.grayController_:SetSelectedIndex(0)
			arg_3_0.pointController_:SetSelectedIndex(2)
			arg_3_0.repController_:SetSelectedIndex(1)
		end
	elseif arg_3_2 == 1 then
		arg_3_0.highLightController_:SetSelectedIndex(1)
		arg_3_0.completedController_:SetSelectedIndex(0)
		arg_3_0.grayController_:SetSelectedIndex(0)
		arg_3_0.pointController_:SetSelectedIndex(1)
		arg_3_0.repController_:SetSelectedIndex(1)
	elseif arg_3_2 == 2 then
		arg_3_0.highLightController_:SetSelectedIndex(0)
		arg_3_0.completedController_:SetSelectedIndex(1)
		arg_3_0.grayController_:SetSelectedIndex(1)
		arg_3_0.pointController_:SetSelectedIndex(0)
		arg_3_0.repController_:SetSelectedIndex(1)
	end
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.clickBtn_, nil, handler(arg_4_0, arg_4_0.OnItemClick))
end

function var_0_0.RegisterListener(arg_5_0, arg_5_1)
	arg_5_0.clickHandler_ = arg_5_1
end

function var_0_0.OnItemClick(arg_6_0)
	if arg_6_0.clickHandler_ and arg_6_0.rewardState == 1 then
		arg_6_0.clickHandler_()
	elseif arg_6_0.clickHandler_ and arg_6_0.isResign and arg_6_0.rewardState == 0 then
		arg_6_0.clickHandler_()
	else
		ShowPopItem(POP_ITEM, arg_6_0.item)
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
