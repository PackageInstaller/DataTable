local var_0_0 = class("MainActTraingCampBtnMellowAdapt", import(".MainDifferentStyleSpActBtnAdapt"))

function var_0_0.GetContainer(arg_1_0)
	return arg_1_0.root:Find("left/list")
end

function var_0_0.OnRegister(arg_2_0)
	arg_2_0.redDotUI = arg_2_0._tf:Find("tip")

	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(arg_2_0.redDotUI, {
		"COMMANDER_MANUAL"
	}, function(arg_3_0)
		local var_3_0, var_3_1 = TechnologyConst.isTecActOn()
		local var_3_2 = getProxy(CommanderManualProxy):ShouldShowTaskOrGuideTip()

		var_3_2 = var_3_2 or var_3_1

		setActive(arg_3_0, var_3_2)

		return
	end)
	arg_2_0._tf:SetAsFirstSibling()

	return
end

function var_0_0.OnClear(arg_4_0)
	if arg_4_0.redDotUI then
		pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(arg_4_0.redDotUI)

		arg_4_0.redDotUI = nil
	end

	return
end

return var_0_0
