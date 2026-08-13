class = var_0_10000

local var_0_0 = "USCastle2023Scene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillTemplate"))

var_0_1.EffectName = {
	"yanhua_01",
	"yanhua_02",
	"yanhua_maomao",
	"yanhua_mofang",
	"yanhua_chuanmao",
	"yanhua_huangji",
	"yanhua_xinxin",
	"yanhua_Azurlane"
}
Vector2 = var_1
var_0_1.FireworkRange = var_1(300, 300)
var_0_1.EffectPosLimit = {
	limitX = {
		-700,
		700
	},
	limitY = {
		250,
		500
	}
}
var_0_1.EffectInterval = 1.5
var_0_1.EffectRecycleTime = 3
var_0_1.SFX_LIST = {
	"event:/ui/firework1",
	"event:/ui/firework2",
	"event:/ui/firework3",
	"event:/ui/firework4"
}

function var_0_1.getUIName(arg_1_0)
	return "USCastle2023UI"
end

var_0_1.edge2area = {
	default = "_SDPlace"
}

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "top")

	local var_2_1 = arg_2_0._tf

	arg_2_0._bg = var_1.Find(var_2_1, "BG")

	local var_2_2 = arg_2_0._tf

	arg_2_0._map = var_1.Find(var_2_2, "map")

	for iter_2_0 = 0, arg_2_0._map.childCount - 1 do
		local var_2_3 = arg_2_0._map
		local var_2_4 = var_5.GetChild(var_2_3, iter_2_0)

		go = var_2_3

		local var_2_5 = var_2_3(var_2_4).name

		arg_2_0["map_" .. var_2_5] = var_2_4
	end

	local var_2_6 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_6, "upper")
	arg_2_0.upper_yanhuiyaoyue = nil
	arg_2_0.upper_xintiaochengbao = nil

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_7 = arg_2_0._upper
		local var_2_8 = var_5.GetChild(var_2_7, iter_2_1)

		go = var_2_7

		local var_2_9 = var_2_7(var_2_8).name

		arg_2_0["upper_" .. var_2_9] = var_2_8
	end

	local var_2_10 = arg_2_0._tf

	arg_2_0._SDPlace = var_1.Find(var_2_10, "SDPlace")
	arg_2_0.containers = {
		arg_2_0._SDPlace
	}

	local var_2_11 = arg_2_0._map

	arg_2_0._shipTpl = var_1.Find(var_2_11, "ship")
	GraphPath = var_1

	local var_2_12 = var_1.New

	import = var_2_11
	arg_2_0.graphPath = var_2_12(var_2_11("GameCfg.BackHillGraphs.USCastle2023Graph"))

	local var_2_13 = arg_2_0._tf

	arg_2_0.fireworksTF = var_1.Find(var_2_13, "play_fireworks")
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

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "top/Back")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.onBackPressed(var_4_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_3.Find(var_3_5, "top/Home")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.quickExitFunc(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0._tf
	local var_3_10 = var_3.Find(var_3_9, "top/Help")

	local function var_3_11()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip.uscastle2023_help.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_8, var_3_10, var_3_11, var_5)

	getProxy = var_1_10001
	ActivityProxy = var_3_8

	local var_3_12 = var_1_10001(var_3_8)
	local var_3_13 = var_1.getActivityById

	ActivityConst = var_3_10

	local var_3_14 = var_3_13(var_3_12, var_3_10.MINIGAME_XINTIAOCHENGBAO)

	arg_3_0:InitStudents(var_3_14 and var_3_14.id, 2, 3)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "yanhuiyaoyue", function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_7_0 = var_2_10000(var_2_10001)
		local var_7_1 = var_0.getActivityByType

		ActivityConst = var_2_10002

		if var_7_1(var_7_0, var_2_10002.ACTIVITY_TYPE_FEAST) and not var_0:isEnd() then
			local var_7_2 = arg_3_0

			var_7_0 = var_7_0.emit
			BackHillMediatorTemplate = var_2_10003
			var_2_10003 = var_2_10003.GO_SCENE
			SCENE = var_2_10004

			var_7_0(var_7_2, var_2_10003, var_2_10004.FEAST)
		else
			pg = var_7_0

			local var_7_3 = var_7_0.TipsMgr.GetInstance()
			local var_7_4 = var_1.ShowTips

			i18n = var_2_10003

			var_7_4(var_7_3, var_2_10003("common_activity_notStartOrEnd"))
		end

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "xintiaochengbao", function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10002

		var_8_1(var_8_0, var_2_10002.GO_MINI_GAME, 56)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "shujvhuigu", function()
		local var_9_0 = arg_3_0
		local var_9_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10002

		local var_9_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_9_1(var_9_0, var_9_2, var_2_10003.SUMMARY)

		return
	end)
	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:UpdateView()
	arg_3_0:PlayFireworks()

	return
end

function var_0_1.FeastTip()
	getProxy = var_1_10000
	FeastProxy = var_1_10001

	local var_10_0 = var_1_10000(var_1_10001)

	return var_0.ShouldTip(var_10_0)
end

function var_0_1.XinTiaoChengBaoTip()
	BackHillTemplate = var_1_10000

	local var_11_0 = var_1_10000.IsMiniActNeedTip

	ActivityConst = var_1_10001

	return var_11_0(var_1_10001.MINIGAME_XINTIAOCHENGBAO)
end

function var_0_1.UpdateView(arg_12_0)
	setActive = var_1_10001

	local var_12_0 = arg_12_0.upper_yanhuiyaoyue

	var_1_10001(var_2.Find(var_12_0, "Tip"), var_0_1.FeastTip())

	setActive = var_1_10001

	local var_12_1 = arg_12_0.upper_xintiaochengbao

	var_1_10001(var_2.Find(var_12_1, "Tip"), var_0_1.XinTiaoChengBaoTip())

	return
end

function var_0_1.willExit(arg_13_0)
	arg_13_0:clearStudents()
	arg_13_0:StopPlayFireworks()
	var_0_1.super.willExit(arg_13_0)

	return
end

function var_0_1.IsShowMainTip(arg_14_0)
	if arg_14_0 and not arg_14_0:isEnd() then
		local var_14_0

		if not var_0_1.XinTiaoChengBaoTip() then
			var_14_0 = var_0_1.FeastTip()
		end

		return var_14_0
	end

	return
end

function var_0_1.PlayFireworks(arg_15_0)
	arg_15_0:StopPlayFireworks()
	arg_15_0:PlayerOneFirework()

	Timer = var_1
	arg_15_0.fireworksTimer = var_1.New(function()
		local var_16_0 = arg_15_0

		var_0.PlayerOneFirework(var_16_0)

		return
	end, var_0_1.EffectInterval, -1)

	local var_15_0 = arg_15_0.fireworksTimer

	var_1.Start(var_15_0)

	return
end

function var_0_1.PlayerOneFirework(arg_17_0)
	local var_17_0 = arg_17_0.fireworksList

	math = var_1_10002

	local var_17_1 = var_17_0[var_1_10002.random(#arg_17_0.fireworksList)]

	table = var_2

	var_2.removebyvalue(arg_17_0.fireworksList, var_17_1)

	local var_17_2 = var_0_1.EffectName[var_17_1]
	local var_17_3 = arg_17_0.fireworksTF
	local var_17_4 = var_3.Find(var_17_3, var_17_2)

	math = var_17_3

	local var_17_5 = var_17_3.random(#var_0_1.SFX_LIST)

	if var_17_4 then
		setLocalPosition = var_5

		var_5(var_17_4, arg_17_0:GetFireworkPos())

		setActive = var_5

		var_5(var_17_4, true)

		pg = var_5

		local var_17_6 = var_5.CriMgr.GetInstance()

		var_5.PlaySoundEffect_V3(var_17_6, var_0_1.SFX_LIST[var_17_5])

		Timer = var_5

		local var_17_7 = var_5.New(function()
			if arg_17_0.fireworksList then
				setActive = var_0

				var_0(var_17_4, false)

				table = var_0

				var_0.insert(arg_17_0.fireworksList, var_17_1)
			end

			return
		end, var_0_1.EffectRecycleTime, 1)

		var_5.Start(var_17_7)
	else
		local var_17_8 = arg_17_0.loader

		var_5.GetPrefab(var_17_8, "ui/" .. var_17_2, "", function(arg_19_0)
			pg = var_2_10001

			var_2_10001.ViewUtils.SetSortingOrder(arg_19_0, 1)

			arg_19_0.name = var_17_2
			setParent = var_1

			var_1(arg_19_0, arg_17_0.fireworksTF)

			setLocalPosition = var_1

			local var_19_0 = arg_19_0
			local var_19_1 = arg_17_0

			var_1(var_19_0, var_3.GetFireworkPos(var_19_1))

			setActive = var_1

			var_1(arg_19_0, true)

			pg = var_1

			local var_19_2 = var_1.CriMgr.GetInstance()

			var_1.PlaySoundEffect_V3(var_19_2, var_0_1.SFX_LIST[var_17_5])

			Timer = var_1

			local var_19_3 = var_1.New(function()
				if arg_17_0.fireworksList then
					setActive = var_0

					var_0(arg_19_0, false)

					table = var_0

					var_0.insert(arg_17_0.fireworksList, var_17_1)
				end

				return
			end, var_0_1.EffectRecycleTime, 1)

			var_1.Start(var_19_3)

			return
		end)
	end

	return
end

function var_0_1.GetFireworkPos(arg_21_0)
	Vector2 = var_1_10001

	local var_21_0 = var_1_10001(0, 0)
	local var_21_1

	if arg_21_0.lastPos then
		Vector2 = var_21_1
		var_21_1 = var_21_1(arg_21_0.lastPos.x, arg_21_0.lastPos.y)
		math = var_3

		local var_21_2 = var_3.abs(var_21_1.x - arg_21_0.lastPos.x)

		math = var_4

		local var_21_3 = var_4.abs(var_21_1.y - arg_21_0.lastPos.y)

		while var_21_2 < var_0_1.FireworkRange.x / 2 and var_21_3 < var_0_1.FireworkRange.y or var_21_3 < var_0_1.FireworkRange.y / 2 and var_21_2 < var_0_1.FireworkRange.x do
			math = var_5
			var_21_1.x = var_5.random(var_0_1.EffectPosLimit.limitX[1], var_0_1.EffectPosLimit.limitX[2])
			math = var_5
			var_21_1.y = var_5.random(var_0_1.EffectPosLimit.limitY[1], var_0_1.EffectPosLimit.limitY[2])
			math = var_5
			var_21_2 = var_5.abs(var_21_1.x - arg_21_0.lastPos.x)
			math = var_5
			var_21_3 = var_5.abs(var_21_1.y - arg_21_0.lastPos.y)
		end

		var_21_0 = var_21_1
	else
		math = var_21_1
		var_21_0.x = var_21_1.random(var_0_1.EffectPosLimit.limitX[1], var_0_1.EffectPosLimit.limitX[2])
		math = var_2
		var_21_0.y = var_2.random(var_0_1.EffectPosLimit.limitY[1], var_0_1.EffectPosLimit.limitY[2])
	end

	arg_21_0.lastPos = var_21_0

	return var_21_0
end

function var_0_1.StopPlayFireworks(arg_22_0)
	if arg_22_0.fireworksTimer then
		local var_22_0 = arg_22_0.fireworksTimer

		var_1.Stop(var_22_0)

		arg_22_0.fireworksTimer = nil
	end

	return
end

return var_0_1
