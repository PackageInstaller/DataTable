local var_0_0 = class("MusicFestivalScene2", import("..TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "MusicFestivalUI2"
end

var_0_0.edge2area = {
	default = "_middle"
}

function var_0_0.init(arg_2_0)
	arg_2_0.top = arg_2_0._tf:Find("top")
	arg_2_0._map = arg_2_0._tf:Find("map")

	for iter_2_0 = 0, arg_2_0._map.childCount - 1 do
		local var_2_0 = arg_2_0._map:GetChild(iter_2_0)
		local var_2_1 = "map_" .. go(var_2_0).name

		arg_2_0[var_2_1] = var_2_0
	end

	arg_2_0._stageShip = arg_2_0._map:Find("stageship")
	arg_2_0._shipTpl = arg_2_0._map:Find("ship")
	arg_2_0._upper = arg_2_0._tf:Find("upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_2 = arg_2_0._upper:GetChild(iter_2_1)
		local var_2_3 = "upper_" .. go(var_2_2).name

		arg_2_0[var_2_3] = var_2_2
	end

	arg_2_0.modelTip = arg_2_0.upper_model:Find("tip")

	setActive(arg_2_0.modelTip, false)

	arg_2_0._middle = arg_2_0._map:Find("middle")
	arg_2_0.containers = {
		arg_2_0._middle
	}
	arg_2_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.MusicFestivalGraph2"))

	local var_2_4 = arg_2_0._tf:GetComponentInParent(typeof(UnityEngine.Canvas))

	arg_2_0._map:GetComponent(typeof(UnityEngine.Canvas)).sortingOrder = (var_2_4 and var_2_4.sortingOrder) - 2
	arg_2_0.loader = AutoLoader.New()

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("top/return_btn"), function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end)
	onButton(arg_3_0, arg_3_0._tf:Find("top/return_main_btn"), function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end)
	onButton(arg_3_0, arg_3_0._tf:Find("top/help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.music_main.tip
		})

		return
	end)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MUSIC_FESTIVAL_ID_2)

	arg_3_0:InitStudents(var_3_0 and var_3_0.id, 3, 4)
	onButton(arg_3_0, arg_3_0.upper_model, function()
		arg_3_0:emit(MusicFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = var_3_0.id
		})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "jichangwutai", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 16)

		return
	end)

	local var_3_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PT_BUFF)

	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "leijipt", function()
		arg_3_0:emit(MusicFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = var_3_1.id
		})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "bujishangdian", function()
		arg_3_0:emit(MusicFestivalMediator.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "huangzhuangshangdian", function()
		arg_3_0:emit(MusicFestivalMediator.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "xianshijianzao", function()
		arg_3_0:emit(MusicFestivalMediator.GO_SCENE, SCENE.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "jinianzhang", function()
		arg_3_0:emit(MusicFestivalMediator.GO_SUBLAYER, (Context.New({
			mediator = IdolMedalCollectionMediator,
			viewComponent = IdolMedalCollectionView2
		})))

		return
	end)
	arg_3_0:BindItemBattle()
	arg_3_0:updateStageShip()
	arg_3_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_14_0)
	local var_14_0 = getProxy(ActivityProxy)
	local var_14_2 = getProxy(MiniGameProxy):GetHubByHubId(var_14_0:getActivityById(ActivityConst.MUSIC_FESTIVAL_ID_2):getConfig("config_id"))

	setActive(arg_14_0.upper_jichangwutai:Find("tip"), var_14_2.count > 0)
	setActive(arg_14_0.modelTip, var_14_2.usedtime >= var_14_2:getConfig("reward_need") and var_14_2.ultimate == 0)
	setActive(arg_14_0.upper_leijipt:Find("tip"), (var_14_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_PT_BUFF):readyToAchieve()))
	setActive(arg_14_0.upper_jinianzhang:Find("tip"), (var_0_0.MedalTip()))

	return
end

function var_0_0.getStageShip(arg_15_0)
	local var_15_0 = getProxy(ActivityProxy)
	local var_15_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.MUSIC_FESTIVAL_ID_2)

	if not var_15_1 then
		return
	end

	local var_15_2 = var_15_1:getConfig("config_client")
	local var_15_3 = var_15_2 and var_15_2.stage_on_ship

	if var_15_2 and var_15_2.stage_on_ship then
		return var_15_3[math.random(1, #var_15_3)], var_15_3.action[1]
	end

	return
end

function var_0_0.updateStageShip(arg_16_0)
	local var_16_0, var_16_1 = arg_16_0:getStageShip()

	if not var_16_0 then
		return
	end

	arg_16_0.loader:GetSpine(var_16_0, function(arg_17_0)
		arg_17_0:SetLocalScale(Vector3(0.63, 0.63, 1))
		arg_17_0:SetLocalPosition(Vector3.zero)
		arg_17_0:SetParent(arg_16_0._stageShip)
		arg_17_0:SetSiblingIndex(1)
		setActive(arg_16_0._stageShip, true)
		arg_17_0:SetAction(var_16_1, 0)

		return
	end, arg_16_0._stageShip)

	return
end

function var_0_0.getStudents(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = getProxy(ActivityProxy):getActivityById(arg_18_0)

	if not var_18_0 then
		return {}
	end

	local var_18_1 = var_18_0:getConfig("config_client")

	var_18_1 = var_18_1 and var_18_1.stage_off_ship

	if var_18_1 then
		local var_18_2 = Clone(var_18_1)
		local var_18_3 = math.random(arg_18_1, arg_18_2)

		while var_18_3 > 0 and #var_18_2 > 0 do
			local var_18_4 = math.random(1, #var_18_2)

			table.insert({}, var_18_2[var_18_4])

			var_18_2[var_18_4] = var_18_2[#var_18_2]
			var_18_3 = var_18_3 - 1
		end
	end

	return {}
end

function var_0_0.MedalTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)))
end

function var_0_0.IsShowMainTip(arg_20_0)
	local var_20_0 = getProxy(ActivityProxy)

	assert((getProxy(ActivityProxy):getActivityById(ActivityConst.MUSIC_FESTIVAL_ID_2)))

	return (function()
		local var_21_0 = var_20_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_PT_BUFF)

		return var_21_0 and not var_21_0:isEnd() and var_21_0:readyToAchieve()
	end)() or var_0_0.MedalTip() or (function()
		local var_22_0 = getProxy(MiniGameProxy):GetHubByHubId(var_0:getConfig("config_id"))

		return var_22_0.usedtime >= var_22_0:getConfig("reward_need") and var_22_0.ultimate == 0
	end)() or (function()
		local var_23_0 = getProxy(MiniGameProxy):GetHubByHubId(var_0:getConfig("config_id")).count

		return var_23_0 > 0
	end)()
end

function var_0_0.willExit(arg_24_0)
	arg_24_0:clearStudents()
	var_0_0.super.willExit(arg_24_0)

	return
end

return var_0_0
