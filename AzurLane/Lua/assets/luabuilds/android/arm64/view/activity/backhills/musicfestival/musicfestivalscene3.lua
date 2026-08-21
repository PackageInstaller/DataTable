local var_0_0 = class("MusicFestivalScene3", import("..TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "MusicFestivalUI3"
end

var_0_0.edge2area = {
	default = "_SDPlace"
}

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)

	arg_2_0.top = arg_2_0._tf:Find("top")
	arg_2_0._map = arg_2_0._tf:Find("map")

	for iter_2_0 = 0, arg_2_0._map.childCount - 1 do
		local var_2_0 = arg_2_0._map:GetChild(iter_2_0)
		local var_2_1 = "map_" .. go(var_2_0).name

		arg_2_0[var_2_1] = var_2_0
	end

	arg_2_0._upper = arg_2_0._tf:Find("upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_2 = arg_2_0._upper:GetChild(iter_2_1)
		local var_2_3 = "upper_" .. go(var_2_2).name

		arg_2_0[var_2_3] = var_2_2
	end

	arg_2_0._SDPlace = arg_2_0._upper:Find("SDPlace")
	arg_2_0.containers = {
		arg_2_0._SDPlace
	}
	arg_2_0._shipTpl = arg_2_0._map:Find("ship")
	arg_2_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.MusicFestivalGraph3"))

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
	onButton(arg_3_0, arg_3_0._tf:Find("top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.idol3rd_houshan.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MUSIC_FESTIVAL_ID_3)

	arg_3_0:InitStudents(var_3_0 and var_3_0.id, 3, 4)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "xiaoyouxi", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 16)

		return
	end)

	local var_3_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.MUSIC_FESTIVAL_PT_ID_3)

	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "huodongye", function()
		arg_3_0:emit(MusicFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = var_3_1.id
		})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "dalaozhang", function()
		arg_3_0:emit(MusicFestivalMediator.GO_SCENE, SCENE.IDOL_MEDAL_COLLECTION_SCENE3)

		return
	end)
	arg_3_0:BindItemActivityShop()
	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:BindItemBattle()
	arg_3_0:UpdateView()

	return
end

function var_0_0.MiniGameTip()
	return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MUSIC_FESTIVAL_ID_3)
end

function var_0_0.MedalTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)))
end

function var_0_0.ActivityTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.MUSIC_FESTIVAL_PT_ID_3)))
end

function var_0_0.UpdateView(arg_13_0)
	setActive(arg_13_0.upper_xiaoyouxi:Find("Tip"), var_0_0.MiniGameTip())
	setActive(arg_13_0.upper_dalaozhang:Find("Tip"), var_0_0.MedalTip())
	setActive(arg_13_0.upper_huodongye:Find("Tip"), var_0_0.ActivityTip())

	return
end

function var_0_0.IsShowMainTip(arg_14_0)
	if arg_14_0 and not arg_14_0:isEnd() then
		return var_0_0.MiniGameTip() or var_0_0.MedalTip() or var_0_0.ActivityTip()
	end

	return
end

function var_0_0.willExit(arg_15_0)
	arg_15_0:clearStudents()
	var_0_0.super.willExit(arg_15_0)

	return
end

return var_0_0
