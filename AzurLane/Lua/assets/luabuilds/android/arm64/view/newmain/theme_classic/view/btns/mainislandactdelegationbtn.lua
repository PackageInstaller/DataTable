local var_0_0 = class("MainIslandActDelegationBtn", import(".MainBaseSpcailActBtn"))

function var_0_0.GetContainer(arg_1_0)
	return arg_1_0.root.parent:Find("eventPanel")
end

function var_0_0.InShowTime(arg_2_0)
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND)

	return var_2_0 and not var_2_0:isEnd()
end

function var_0_0.GetUIName(arg_3_0)
	return "MainIslandActDelegationBtn"
end

function var_0_0.OnClick(arg_4_0)
	arg_4_0.event:emit(NewMainMediator.GO_SCENE, SCENE.ANNIVERSARY_ISLAND_SEA, {
		checkMain = true
	})

	return
end

function var_0_0.OnInit(arg_5_0)
	return
end

function var_0_0.OnRegister(arg_6_0)
	arg_6_0.redDotUI = arg_6_0._tf:Find("tip")

	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(arg_6_0.redDotUI, {
		"ISLAND"
	}, function(arg_7_0)
		setActive(arg_7_0, Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND))))

		return
	end)

	return
end

function var_0_0.OnClear(arg_8_0)
	if arg_8_0.redDotUI then
		pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(arg_8_0.redDotUI)

		arg_8_0.redDotUI = nil
	end

	return
end

return var_0_0
