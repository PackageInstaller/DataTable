local var_0_0 = class("SummerCookMenuFoodItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddUIListeners()

	arg_1_0.lockController_ = arg_1_0.transCon_:GetController("unlock")
	arg_1_0.doneController_ = arg_1_0.transCon_:GetController("done")
	arg_1_0.selectController_ = arg_1_0.transCon_:GetController("select")
end

function var_0_0.AddUIListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btnClick_, nil, function()
		if arg_2_0.isUnLock_ then
			arg_2_0.isSelected_ = not arg_2_0.isSelected_

			arg_2_0.selectController_:SetSelectedState(tostring(arg_2_0.isSelected_))

			if arg_2_0.onClick then
				arg_2_0.onClick(arg_2_0.itemId_, arg_2_0.isSelected_, arg_2_0.transform_)
			end
		else
			ShowTips(GetTips("COOKING_GAME_MATERIAL_NOT_ENOUGH"))
		end
	end)
end

function var_0_0.RefreshSelect(arg_4_0, arg_4_1)
	if not arg_4_0.isUnLock_ then
		return
	end

	arg_4_0.isSelected_ = arg_4_1

	arg_4_0.selectController_:SetSelectedState(tostring(arg_4_0.isSelected_))
end

function var_0_0.RefreshDoneContronl(arg_5_0, arg_5_1)
	arg_5_0.doneController_:SetSelectedState(tostring(arg_5_1))
end

function var_0_0.RefreshUnlockContronl(arg_6_0, arg_6_1)
	arg_6_0.isUnLock_ = arg_6_1

	arg_6_0.lockController_:SetSelectedState(tostring(arg_6_1))
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.isSelected_ = false

	arg_7_0.selectController_:SetSelectedState(tostring(arg_7_0.isSelected_))

	arg_7_0.itemId_ = arg_7_1
	arg_7_0.foodIcon_.sprite = ItemTools.getItemSprite(arg_7_1)
end

function var_0_0.SetLock(arg_8_0, arg_8_1)
	arg_8_0.isUnLock_ = arg_8_1

	arg_8_0.lockController_:SetSelectedState(tostring(arg_8_0.isUnLock_))

	if not (getData("summerCookMenuView", "hasShowUnlock" .. arg_8_0.itemId_) or false) and arg_8_0.isUnLock_ then
		arg_8_0.ani_:Play("UI_fooditem_cx", 0, 0)
		arg_8_0.ani_:Update(0)
		saveData("summerCookMenuView", "hasShowUnlock" .. arg_8_0.itemId_, true)
	else
		arg_8_0.ani_:Play("UI_fooditemNormal", 0, 0)
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.RegisterClick(arg_10_0, arg_10_1)
	arg_10_0.onClick = arg_10_1
end

return var_0_0
