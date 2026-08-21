local var_0_0 = class("BackHillFifthAnniversaryScene", import("..TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "BackHillFifthAnniversaryUI"
end

var_0_0.edge2area = {
	default = "_sdPlace",
	["6_7"] = "_sdPlace2"
}

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)

	arg_2_0.top = arg_2_0._tf:Find("top")
	arg_2_0._bg = arg_2_0._tf:Find("BG")
	arg_2_0._map = arg_2_0._tf:Find("map")

	for iter_2_0 = 0, arg_2_0._map.childCount - 1 do
		local var_2_0 = arg_2_0._map:GetChild(iter_2_0)
		local var_2_1 = "map_" .. go(var_2_0).name

		arg_2_0[var_2_1] = var_2_0
	end

	arg_2_0._shipTpl = arg_2_0._tf:Find("ship")
	arg_2_0._sdPlace = arg_2_0._tf:Find("map/SDPlace")
	arg_2_0._sdPlace2 = arg_2_0._tf:Find("map/SDPlace2")
	arg_2_0._upper = arg_2_0._tf:Find("upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_2 = arg_2_0._upper:GetChild(iter_2_1)
		local var_2_3 = "upper_" .. go(var_2_2).name

		arg_2_0[var_2_3] = var_2_2
	end

	arg_2_0.containers = {
		arg_2_0._sdPlace,
		arg_2_0._sdPlace2
	}
	arg_2_0.usableTxt = arg_2_0.top:Find("UsableCount/Text"):GetComponent(typeof(Text))
	arg_2_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.BackHillFifthAnniversaryGraph"))

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Back"), function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Home"), function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Invitation"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.FIFTH_ANNIVERSARY_INVITATION
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/UsableCount"), function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 40)

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.JIUJIU_DUOMAOMAO_ID)

	arg_3_0:InitStudents(var_3_0 and var_3_0.id, 3, 4)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "youxidian", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 40)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "kafeiting", function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.ACTIVITY_MAID_DAY
		})

		return
	end)
	setActive(arg_3_0.map_longpaifangBanner, PLATFORM_CODE == PLATFORM_CH)

	if PLATFORM_CODE == PLATFORM_CH then
		onButton(arg_3_0, arg_3_0.map_longpaifang, function()
			arg_3_0:emit(NewYearFestivalMediator.GO_SCENE, SCENE.SUMMARY)

			return
		end, SFX_PANEL)
		onButton(arg_3_0, arg_3_0.map_longpaifangBanner, function()
			arg_3_0:emit(NewYearFestivalMediator.GO_SCENE, SCENE.SUMMARY)

			return
		end, SFX_PANEL)
	end

	arg_3_0:BindItemSkinShop()
	onButton(arg_3_0, arg_3_0.map_xianshijianzao, function()
		local var_11_0
		local var_11_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDSHIP_1)
		local var_11_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILD)

		if var_11_1 and not var_11_1:isEnd() then
			var_11_0 = BuildShipScene.PROJECTS.ACTIVITY
		elseif var_11_2 and not var_11_2:isEnd() then
			var_11_0 = ({
				BuildShipScene.PROJECTS.SPECIAL,
				BuildShipScene.PROJECTS.LIGHT,
				BuildShipScene.PROJECTS.HEAVY
			})[var_11_2:getConfig("config_client").id]
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = var_11_0
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.map_xianshijianzaoBanner, function()
		local var_11_0
		local var_11_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDSHIP_1)
		local var_11_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILD)

		if var_11_1 and not var_11_1:isEnd() then
			var_11_0 = BuildShipScene.PROJECTS.ACTIVITY
		elseif var_11_2 and not var_11_2:isEnd() then
			var_11_0 = ({
				BuildShipScene.PROJECTS.SPECIAL,
				BuildShipScene.PROJECTS.LIGHT,
				BuildShipScene.PROJECTS.HEAVY
			})[var_11_2:getConfig("config_client").id]
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = var_11_0
		})

		return
	end, SFX_PANEL)
	arg_3_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_12_0)
	setActive(arg_12_0.upper_youxidian:Find("Tip"), (function()
		return BackHillTemplate.IsMiniActNeedTip(ActivityConst.JIUJIU_DUOMAOMAO_ID)
	end)())

	local var_12_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.JIUJIU_DUOMAOMAO_ID)
	local var_12_1 = var_12_0 and getProxy(MiniGameProxy):GetHubByHubId(var_12_0:getConfig("config_id"))

	if var_12_1 then
		local var_12_2 = var_12_1.count or 0

		arg_12_0.usableTxt.text = "X" .. var_12_2

		setActive(arg_12_0.upper_kafeiting:Find("Tip"), (function()
			return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_MAID_DAY)))
		end)())
		setActive(arg_12_0.map_longpaifangBanner:Find("Tip"), (function()
			if PLATFORM_CODE ~= PLATFORM_CH then
				return
			end

			local var_15_0 = getProxy(ActivityProxy)

			return Activity.IsActivityReady((var_15_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_SUMMARY)))
		end)())

		return
	end
end

function var_0_0.IsShowMainTip(arg_16_0)
	return (function()
		return BackHillTemplate.IsMiniActNeedTip(ActivityConst.JIUJIU_DUOMAOMAO_ID)
	end)() or (function()
		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_MAID_DAY)))
	end)() or (function()
		if PLATFORM_CODE ~= PLATFORM_CH then
			return
		end

		local var_19_0 = getProxy(ActivityProxy)

		return Activity.IsActivityReady((var_19_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_SUMMARY)))
	end)()
end

function var_0_0.willExit(arg_20_0)
	arg_20_0:clearStudents()
	var_0_0.super.willExit(arg_20_0)

	return
end

return var_0_0
