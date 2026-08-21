local var_0_0 = class("MoonCakeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selecteController_ = ControllerUtil.GetController(arg_2_0.transform_, "select")
	arg_2_0.typeController_ = ControllerUtil.GetController(arg_2_0.transform_, "type")
	arg_2_0.enoughController_ = ControllerUtil.GetController(arg_2_0.transform_, "enough")
	arg_2_0.unlockController_ = ControllerUtil.GetController(arg_2_0.transform_, "unlock")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.clickHandler_ then
			arg_3_0.clickHandler_(arg_3_0.ID_, arg_3_0)
		end
	end)
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.clickHandler_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.itemID_ = arg_6_1
	arg_6_0.ID_ = arg_6_2

	if arg_6_3 ~= true then
		arg_6_0:RefreshUI()
	end

	arg_6_0:SetActive(true)
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshNum()
	arg_7_0:RefreshName()
	arg_7_0:RefreshIcon()
end

function var_0_0.RefreshNum(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or ItemTools.getItemNum(arg_8_0.itemID_)
	arg_8_0.numText_.text = arg_8_1
end

function var_0_0.RefreshName(arg_9_0)
	arg_9_0.nameText_.text = ItemTools.getItemName(arg_9_0.itemID_)
end

function var_0_0.RefreshIcon(arg_10_0)
	arg_10_0.icon_.sprite = ItemTools.getItemSprite(arg_10_0.itemID_)
end

function var_0_0.SetUnlock(arg_11_0, arg_11_1)
	arg_11_0.unlockController_:SetSelectedState(arg_11_1 == true and "on" or "off")
end

function var_0_0.SetSelect(arg_12_0, arg_12_1)
	arg_12_0.selecteController_:SetSelectedState(arg_12_0.ID_ == arg_12_1 and "on" or "off")
end

function var_0_0.SetEnough(arg_13_0, arg_13_1)
	arg_13_0.enoughController_:SetSelectedState(arg_13_1 == true and "on" or "off")
end

function var_0_0.SetMakeTimes(arg_14_0, arg_14_1)
	arg_14_0.makeTimesText_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_MOONCAKE_MAKING_PREVIEW"), arg_14_1)
end

function var_0_0.SetType(arg_15_0, arg_15_1)
	arg_15_0.type_ = arg_15_1

	arg_15_0.typeController_:SetSelectedIndex(arg_15_0.type_)
end

function var_0_0.SetClickHandler(arg_16_0, arg_16_1)
	arg_16_0.clickHandler_ = arg_16_1
end

function var_0_0.SetActive(arg_17_0, arg_17_1)
	SetActive(arg_17_0.gameObject_, arg_17_1)
end

return var_0_0
