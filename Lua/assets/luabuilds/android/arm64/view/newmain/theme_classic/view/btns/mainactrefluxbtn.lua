local var_0_0 = class("MainActRefluxBtn", import(".MainBaseSpcailActBtn"))

function var_0_0.GetContainer(arg_1_0)
	return arg_1_0.root.parent:Find("link_top/layout")
end

function var_0_0.InShowTime(arg_2_0)
	return getProxy(RefluxProxy):isActive()
end

function var_0_0.GetUIName(arg_3_0)
	return "MainUIReturnBtn"
end

function var_0_0.OnClick(arg_4_0)
	arg_4_0.event:emit(NewMainMediator.GO_SCENE, SCENE.REFLUX)

	return
end

function var_0_0.OnRegister(arg_5_0)
	arg_5_0.redDotUI = arg_5_0._tf:Find("tip")

	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(arg_5_0.redDotUI, {
		"ACT_RETURN"
	}, function(arg_6_0)
		local var_6_0 = RefluxTaskView.isAnyTaskCanGetAward() or RefluxPTView.isAnyPTCanGetAward() or RefluxShopView.isShowRedPot()

		setActive(arg_6_0, var_6_0)

		return
	end)

	return
end

function var_0_0.OnClear(arg_7_0)
	if arg_7_0.redDotUI then
		pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(arg_7_0.redDotUI)

		arg_7_0.redDotUI = nil
	end

	return
end

return var_0_0
