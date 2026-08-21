local var_0_0 = class("SummerRaceIllustratedItemView", ReduxView)

local function var_0_1(arg_1_0)
	local var_1_0 = tostring(arg_1_0 and arg_1_0.iconPath or "")

	return var_1_0 ~= "" and var_1_0 or nil
end

function var_0_0.OnCtor(arg_2_0, arg_2_1)
	arg_2_0.gameObject_ = arg_2_1
	arg_2_0.transform_ = arg_2_1.transform

	arg_2_0:Init()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:BindRuntime_()
	arg_3_0:AddUIListener()
end

function var_0_0.BindRuntime_(arg_4_0)
	arg_4_0.selectController_ = arg_4_0.controllerEx_:GetController("select")
	arg_4_0.lockController_ = arg_4_0.controllerEx_:GetController("lock")

	if arg_4_0.nameText_ == nil then
		arg_4_0.viewType_ = "body"
	else
		arg_4_0.viewType_ = "option"
		arg_4_0.typeController_ = arg_4_0.controllerEx_:GetController("type")
		arg_4_0.costController_ = arg_4_0.controllerEx_:GetController("cost")
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.clickBtn_, nil, function()
		if arg_5_0.clickHandler_ ~= nil and arg_5_0.itemData_ ~= nil then
			arg_5_0.clickHandler_(arg_5_0.index_, arg_5_0.itemData_, "select")
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.itemData_ = arg_7_1
	arg_7_0.index_ = arg_7_2
	arg_7_0.clickHandler_ = arg_7_3

	arg_7_0:RefreshView()
end

function var_0_0.RefreshView(arg_8_0)
	if arg_8_0.itemData_ == nil then
		SetActive(arg_8_0.gameObject_, false)

		return
	end

	SetActive(arg_8_0.gameObject_, true)

	arg_8_0.icon_.spriteSync = var_0_1(arg_8_0.itemData_)

	if arg_8_0.viewType_ == "body" then
		arg_8_0.lockController_:SetSelectedState(arg_8_0.itemData_.isUnlocked and "hide" or "show")
		arg_8_0.selectController_:SetSelectedState(arg_8_0.itemData_.isSelected and "show" or "hide")

		return
	end

	if arg_8_0.nameText_ ~= nil then
		arg_8_0.nameText_.text = tostring(arg_8_0.itemData_.itemName or "")
	end

	if arg_8_0.costText_ ~= nil then
		arg_8_0.costText_.text = tostring(arg_8_0.itemData_.cost or "")
	end

	arg_8_0.typeController_:SetSelectedState(arg_8_0.itemData_.typeText == SummerRaceConst.FILTER.EQUIP and "parts" or "weapon")
	arg_8_0.costController_:SetSelectedState(tostring(arg_8_0.itemData_.costState or "white"))
	arg_8_0.selectController_:SetSelectedState(arg_8_0.itemData_.isSelected and "show" or "hide")
	arg_8_0.lockController_:SetSelectedState(arg_8_0.itemData_.isUnlocked and "false" or "true")
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.itemData_ = nil
	arg_9_0.clickHandler_ = nil

	arg_9_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
