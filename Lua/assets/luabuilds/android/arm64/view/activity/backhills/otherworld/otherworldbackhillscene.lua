local var_0_0 = class("OtherworldBackHillScene", import("..TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "OtherworldBackHillUI"
end

var_0_0.edge2area = {
	default = "_SDPlace"
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

	arg_2_0._upper = arg_2_0._tf:Find("upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_2 = arg_2_0._upper:GetChild(iter_2_1)
		local var_2_3 = "upper_" .. go(var_2_2).name

		arg_2_0[var_2_3] = var_2_2
	end

	arg_2_0._SDPlace = arg_2_0._tf:Find("SDPlace")
	arg_2_0.containers = {
		arg_2_0._SDPlace
	}
	arg_2_0._shipTpl = arg_2_0._map:Find("ship")
	arg_2_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.OtherworldBackHillSceneGraph"))
	arg_2_0.ptIconTF = arg_2_0._tf:Find("top/Res/icon")
	arg_2_0.ptValueTF = arg_2_0._tf:Find("top/Res/Text")

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:SetNativeSizes()
	onButton(arg_3_0, arg_3_0._tf:Find("top/Back"), function()
		arg_3_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Home"), function()
		arg_3_0:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.otherworld_backhill_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Terminal"), function()
		arg_3_0:emit(OtherworldBackHilllMediator.GO_SUBLAYER, Context.New({
			mediator = OtherworldTerminalMediator,
			viewComponent = OtherworldTerminalLayer
		}))

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/OtherWorld"), function()
		pg.SceneAnimMgr.GetInstance():OtherWorldCoverGoScene(SCENE.OTHERWORLD_MAP, {
			mode = OtherworldMapScene.MODE_BATTLE
		})

		return
	end, SFX_CANCEL)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "maoxianzgonghui", function()
		local var_9_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.OTHER_WORLD_TASK_ID)

		if not var_9_0 or var_9_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_3_0:emit(OtherworldBackHilllMediator.GO_SUBLAYER, Context.New({
			mediator = OtherWorldTaskMediator,
			viewComponent = OtherWorldTaskLayer
		}))

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "jiujiushendian", function()
		arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.OTHER_WORLD_TEMPLE_SCENE)

		return
	end)
	arg_3_0:BindItemSkinShop()
	arg_3_0:UpdateView()

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.OTHER_WORLD_TERMINAL_LOTTERY_ID)

	if not var_3_0 then
		return
	end

	arg_3_0.resId = pg.activity_random_award_template[var_3_0:getConfig("config_data")[1]].resource_type

	GetImageSpriteFromAtlasAsync(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = arg_3_0.resId
	}):getIcon(), "", arg_3_0.ptIconTF)
	arg_3_0:UpdateRes()

	return
end

function var_0_0.SetNativeSizes(arg_11_0)
	eachChild(arg_11_0._upper, function(arg_12_0)
		local var_12_0 = arg_12_0:Find("Image")
		local var_12_1 = var_12_0 and var_12_0:GetComponent(typeof(Image))

		if var_12_1 then
			var_12_1:SetNativeSize()
		end

		return
	end)

	return
end

function var_0_0.GongHuiTip()
	return getProxy(ActivityTaskProxy):getActTaskTip(ActivityConst.OTHER_WORLD_TASK_ID)
end

function var_0_0.ShenDianTip()
	return ActivityItemPool.GetTempleRedTip(ActivityConst.OTHER_WORLD_TERMINAL_LOTTERY_ID)
end

function var_0_0.TerminalTip()
	return TerminalAdventurePage.IsTip()
end

function var_0_0.UpdateRes(arg_16_0)
	setText(arg_16_0.ptValueTF, getProxy(PlayerProxy):getData():getResource(arg_16_0.resId))

	return
end

function var_0_0.UpdateView(arg_17_0)
	setActive(arg_17_0.upper_maoxianzgonghui:Find("Tip"), var_0_0.GongHuiTip())
	setActive(arg_17_0.upper_jiujiushendian:Find("Tip"), var_0_0.ShenDianTip())
	setActive(arg_17_0._tf:Find("top/Terminal/Tip"), var_0_0.TerminalTip())

	return
end

function var_0_0.UpdateActivity(arg_18_0)
	arg_18_0:UpdateView()

	return
end

function var_0_0.willExit(arg_19_0)
	arg_19_0:clearStudents()
	var_0_0.super.willExit(arg_19_0)

	return
end

function var_0_0.IsShowMainTip(arg_20_0)
	if arg_20_0 and not arg_20_0:isEnd() then
		return var_0_0.GongHuiTip() or var_0_0.ShenDianTip()
	end

	return
end

function var_0_0.IsShowTip()
	return var_0_0.GongHuiTip() or var_0_0.ShenDianTip()
end

return var_0_0
