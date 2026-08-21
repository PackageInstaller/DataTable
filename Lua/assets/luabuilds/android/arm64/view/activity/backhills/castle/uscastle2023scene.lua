local var_0_0 = class("USCastle2023Scene", import("..TemplateMV.BackHillTemplate"))

var_0_0.EffectName = {
	"yanhua_01",
	"yanhua_02",
	"yanhua_maomao",
	"yanhua_mofang",
	"yanhua_chuanmao",
	"yanhua_huangji",
	"yanhua_xinxin",
	"yanhua_Azurlane"
}
var_0_0.FireworkRange = Vector2(300, 300)
var_0_0.EffectPosLimit = {
	limitX = {
		-700,
		700
	},
	limitY = {
		250,
		500
	}
}
var_0_0.EffectInterval = 1.5
var_0_0.EffectRecycleTime = 3
var_0_0.SFX_LIST = {
	"event:/ui/firework1",
	"event:/ui/firework2",
	"event:/ui/firework3",
	"event:/ui/firework4"
}

function var_0_0.getUIName(arg_1_0)
	return "USCastle2023UI"
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
	arg_2_0.upper_yanhuiyaoyue = nil
	arg_2_0.upper_xintiaochengbao = nil

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
	arg_2_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.USCastle2023Graph"))
	arg_2_0.fireworksTF = arg_2_0._tf:Find("play_fireworks")
	arg_2_0.fireworksList = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8
	}

	return
end

function var_0_0.didEnter(arg_3_0)
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
			helps = pg.gametip.uscastle2023_help.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_XINTIAOCHENGBAO)

	arg_3_0:InitStudents(var_3_0 and var_3_0.id, 2, 3)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "yanhuiyaoyue", function()
		local var_7_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST)

		if var_7_0 and not var_7_0:isEnd() then
			arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.FEAST)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_notStartOrEnd"))
		end

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "xintiaochengbao", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 56)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "shujvhuigu", function()
		arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SUMMARY)

		return
	end)
	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:UpdateView()
	arg_3_0:PlayFireworks()

	return
end

function var_0_0.FeastTip()
	return getProxy(FeastProxy):ShouldTip()
end

function var_0_0.XinTiaoChengBaoTip()
	return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_XINTIAOCHENGBAO)
end

function var_0_0.UpdateView(arg_12_0)
	setActive(arg_12_0.upper_yanhuiyaoyue:Find("Tip"), var_0_0.FeastTip())
	setActive(arg_12_0.upper_xintiaochengbao:Find("Tip"), var_0_0.XinTiaoChengBaoTip())

	return
end

function var_0_0.willExit(arg_13_0)
	arg_13_0:clearStudents()
	arg_13_0:StopPlayFireworks()
	var_0_0.super.willExit(arg_13_0)

	return
end

function var_0_0.IsShowMainTip(arg_14_0)
	if arg_14_0 and not arg_14_0:isEnd() then
		return var_0_0.XinTiaoChengBaoTip() or var_0_0.FeastTip()
	end

	return
end

function var_0_0.PlayFireworks(arg_15_0)
	arg_15_0:StopPlayFireworks()
	arg_15_0:PlayerOneFirework()

	arg_15_0.fireworksTimer = Timer.New(function()
		arg_15_0:PlayerOneFirework()

		return
	end, var_0_0.EffectInterval, -1)

	arg_15_0.fireworksTimer:Start()

	return
end

function var_0_0.PlayerOneFirework(arg_17_0)
	local var_17_0 = arg_17_0.fireworksList[math.random(#arg_17_0.fireworksList)]

	table.removebyvalue(arg_17_0.fireworksList, var_17_0)

	local var_17_1 = var_0_0.EffectName[var_17_0]
	local var_17_2 = arg_17_0.fireworksTF:Find(var_0_0.EffectName[var_17_0])
	local var_17_3 = math.random(#var_0_0.SFX_LIST)

	if var_17_2 then
		setLocalPosition(var_17_2, arg_17_0:GetFireworkPos())
		setActive(var_17_2, true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_0.SFX_LIST[math.random(#var_0_0.SFX_LIST)])
		Timer.New(function()
			if arg_17_0.fireworksList then
				setActive(var_17_2, false)
				table.insert(arg_17_0.fireworksList, var_17_0)
			end

			return
		end, var_0_0.EffectRecycleTime, 1):Start()
	else
		arg_17_0.loader:GetPrefab("ui/" .. var_0_0.EffectName[var_17_0], "", function(arg_19_0)
			pg.ViewUtils.SetSortingOrder(arg_19_0, 1)

			arg_19_0.name = var_17_1

			setParent(arg_19_0, arg_17_0.fireworksTF)
			setLocalPosition(arg_19_0, arg_17_0:GetFireworkPos())
			setActive(arg_19_0, true)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_0.SFX_LIST[var_17_3])
			Timer.New(function()
				if arg_17_0.fireworksList then
					setActive(arg_19_0, false)
					table.insert(arg_17_0.fireworksList, var_17_0)
				end

				return
			end, var_0_0.EffectRecycleTime, 1):Start()

			return
		end)
	end

	return
end

function var_0_0.GetFireworkPos(arg_21_0)
	local var_21_0 = Vector2(0, 0)

	if arg_21_0.lastPos then
		local var_21_1 = Vector2(arg_21_0.lastPos.x, arg_21_0.lastPos.y)
		local var_21_2 = math.abs(var_21_1.x - arg_21_0.lastPos.x)
		local var_21_3 = math.abs(var_21_1.y - arg_21_0.lastPos.y)

		while var_21_2 < var_0_0.FireworkRange.x / 2 and var_21_3 < var_0_0.FireworkRange.y or var_21_3 < var_0_0.FireworkRange.y / 2 and var_21_2 < var_0_0.FireworkRange.x do
			var_21_1.x = math.random(var_0_0.EffectPosLimit.limitX[1], var_0_0.EffectPosLimit.limitX[2])
			var_21_1.y = math.random(var_0_0.EffectPosLimit.limitY[1], var_0_0.EffectPosLimit.limitY[2])
			var_21_2 = math.abs(var_21_1.x - arg_21_0.lastPos.x)
			var_21_3 = math.abs(var_21_1.y - arg_21_0.lastPos.y)
		end

		var_21_0 = var_21_1
	else
		var_21_0.x = math.random(var_0_0.EffectPosLimit.limitX[1], var_0_0.EffectPosLimit.limitX[2])
		var_21_0.y = math.random(var_0_0.EffectPosLimit.limitY[1], var_0_0.EffectPosLimit.limitY[2])
	end

	arg_21_0.lastPos = var_21_0

	return var_21_0
end

function var_0_0.StopPlayFireworks(arg_22_0)
	if arg_22_0.fireworksTimer then
		arg_22_0.fireworksTimer:Stop()

		arg_22_0.fireworksTimer = nil
	end

	return
end

return var_0_0
