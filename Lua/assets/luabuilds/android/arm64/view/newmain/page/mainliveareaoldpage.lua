local var_0_0 = class("MainLiveAreaOldPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "MainLiveAreaOldUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0._academyBtn = arg_2_0._tf:Find("school_btn")
	arg_2_0._haremBtn = arg_2_0._tf:Find("backyard_btn")
	arg_2_0._commanderBtn = arg_2_0._tf:Find("commander_btn")

	local var_2_0 = pg.EasyRedDotMgr.GetInstance()

	arg_2_0._haremTip = arg_2_0._haremBtn:Find("tip")
	arg_2_0._academyTip = arg_2_0._academyBtn:Find("tip")
	arg_2_0._commanderTip = arg_2_0._commanderBtn:Find("tip")

	var_2_0:RegisterRedDot(arg_2_0._haremTip, {
		"COURTYARD"
	}, function(arg_3_0)
		setActive(arg_3_0, getProxy(DormProxy):IsShowRedDot())

		return
	end)
	var_2_0:RegisterRedDot(arg_2_0._academyTip, {
		"SCHOOL"
	}, function(arg_4_0)
		setActive(arg_4_0, getProxy(NavalAcademyProxy):IsShowTip())

		return
	end)
	var_2_0:RegisterRedDot(arg_2_0._commanderTip, {
		"COMMANDER"
	}, function(arg_5_0)
		if getProxy(PlayerProxy):getRawData().level < 40 then
			setActive(arg_5_0, false)

			return
		end

		local var_5_0 = getProxy(CommanderProxy):IsFinishAllBox()

		if not LOCK_CATTERY then
			local var_5_1

			if not var_5_0 then
				::label_5_0::

				var_5_1 = getProxy(CommanderProxy):AnyCatteryExistOP()
				var_5_1 = var_5_1 or getProxy(CommanderProxy):AnyCatteryCanUse()
			end

			setActive(arg_5_0, var_5_1)
		else
			setActive(arg_5_0, var_5_0)
		end

		return
	end)

	return
end

function var_0_0.OnInit(arg_6_0)
	onButton(arg_6_0, arg_6_0._commanderBtn, function()
		arg_6_0:emit(NewMainMediator.GO_SCENE, SCENE.COMMANDERCAT, {
			fromMain = true,
			fleetType = CommanderCatScene.FLEET_TYPE_COMMON
		})
		arg_6_0:Hide()

		return
	end, SFX_MAIN)
	onButton(arg_6_0, arg_6_0._haremBtn, function()
		arg_6_0:emit(NewMainMediator.GO_SCENE, SCENE.COURTYARD)
		arg_6_0:Hide()

		return
	end, SFX_MAIN)
	onButton(arg_6_0, arg_6_0._academyBtn, function()
		arg_6_0:emit(NewMainMediator.GO_SCENE, SCENE.NAVALACADEMYSCENE)
		arg_6_0:Hide()

		return
	end, SFX_MAIN)
	onButton(arg_6_0, arg_6_0._tf, function()
		arg_6_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_11_0)
	var_0_0.super.Show(arg_11_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_11_0._tf, {
		staticBlur = true
	})

	local var_11_0 = getProxy(PlayerProxy):getRawData()

	arg_11_0._commanderBtn:GetComponent(typeof(Image)).color = not pg.SystemOpenMgr.GetInstance():isOpenSystem(var_11_0.level, "CommanderCatMediator") and Color(0.3, 0.3, 0.3, 1) or Color(1, 1, 1, 1)

	local var_11_1 = pg.SystemOpenMgr.GetInstance()

	arg_11_0._haremBtn:GetComponent(typeof(Image)).color = not var_11_1:isOpenSystem(var_11_0.level, "CourtYardMediator") and Color(0.3, 0.3, 0.3, 1) or Color(1, 1, 1, 1)

	return
end

function var_0_0.Hide(arg_12_0)
	if arg_12_0:isShowing() then
		var_0_0.super.Hide(arg_12_0)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_12_0._tf, arg_12_0._parentTf)
	end

	return
end

function var_0_0.OnDestroy(arg_13_0)
	local var_13_0 = pg.EasyRedDotMgr.GetInstance()

	var_13_0:UnRegisterRedDot(arg_13_0._haremTip)
	var_13_0:UnRegisterRedDot(arg_13_0._academyTip)
	var_13_0:UnRegisterRedDot(arg_13_0._commanderTip)
	arg_13_0:Hide()

	return
end

return var_0_0
