local var_0_0 = class("MoonFillingItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selecteController_ = ControllerUtil.GetController(arg_2_0.transform_, "select")
	arg_2_0.typeController_ = ControllerUtil.GetController(arg_2_0.transform_, "type")
	arg_2_0.makeTimesController_ = ControllerUtil.GetController(arg_2_0.transform_, "makeTimes")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.clickHandler_ then
			arg_3_0.clickHandler_(arg_3_0.ID_)
		end
	end)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.ID_ = arg_6_1

	arg_6_0:RefrehsUI()
end

function var_0_0.RefrehsUI(arg_7_0)
	local var_7_0 = MoonCakeFillingCfg[arg_7_0.ID_].patties

	arg_7_0.icon_.sprite = ItemTools.getItemSprite(var_7_0)
	arg_7_0.nameText_.text = ItemTools.getItemName(var_7_0)
end

function var_0_0.SetType(arg_8_0, arg_8_1)
	arg_8_0.type_ = arg_8_1

	arg_8_0.typeController_:SetSelectedIndex(arg_8_0.type_)

	if arg_8_0.type_ == MoonCakeConst.FILLING_ITEM_TYPE.FILLING_MAKE then
		arg_8_0.maxTimes_ = MoonCakeTools.GetFillingMultiTimes(arg_8_0.ID_)

		if arg_8_0.maxTimes_ > 0 then
			arg_8_0.timesText_.text = string.format(GetTips("%d", arg_8_0.maxTimes_))
		else
			arg_8_0.timesText_.text = GetTips("NOT_ENOUGH")
		end

		arg_8_0.makeTimesController_:SetSelectedState(arg_8_0.maxTimes_ and "true" or "false")
	end
end

function var_0_0.SetSelect(arg_9_0, arg_9_1)
	arg_9_0.selecteController_:SetSelectedState(arg_9_0.ID_ == arg_9_1 and "true" or "false")
end

function var_0_0.SetClickHandler(arg_10_0, arg_10_1)
	arg_10_0.clickHandler_ = arg_10_1
end

return var_0_0
