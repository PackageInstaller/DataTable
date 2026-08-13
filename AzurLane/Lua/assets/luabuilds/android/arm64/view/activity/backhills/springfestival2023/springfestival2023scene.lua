class = var_0_10000

local var_0_0 = "SpringFestival2023Scene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.BackHillTemplate"))

var_0_1.Id2EffectName = {
	[70114] = "yanhua_xiaojiajia",
	[70113] = "yanhua_xinxin",
	[70112] = "yanhua_jiezhi",
	[70111] = "yanhua_huangji",
	[70110] = "yanhua_chuanmao",
	[70109] = "yanhua_tutu",
	[70108] = "yanhua_mofang",
	[70107] = "yanhua_maomao",
	[70106] = "yanhua_02",
	[70105] = "yanhua_01",
	[70118] = "yanhua_denglong",
	[70117] = "yanhua_hongbao",
	[70116] = "yanhua_Azurlane",
	[70115] = "yanhua_2023"
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
var_0_1.EffectInterval = 1
var_0_1.DelayPop = 2.5
var_0_1.SFX_LIST = {
	"event:/ui/firework1",
	"event:/ui/firework2",
	"event:/ui/firework3",
	"event:/ui/firework4"
}

function var_0_1.getUIName(arg_1_0)
	return "SpringFestival2023UI"
end

var_0_1.edge2area = {
	default = "map_middle"
}

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "top")

	local var_2_1 = arg_2_0._tf

	arg_2_0._map = var_1.Find(var_2_1, "map")

	for iter_2_0 = 0, arg_2_0._map.childCount - 1 do
		local var_2_2 = arg_2_0._map
		local var_2_3 = var_5.GetChild(var_2_2, iter_2_0)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_2_3).name
		arg_2_0["map_" .. var_1_10006] = var_2_3
	end

	local var_2_4 = arg_2_0._map

	arg_2_0._shipTpl = var_1.Find(var_2_4, "ship")

	local var_2_5 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_5, "upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_6 = arg_2_0._upper
		local var_2_7 = var_5.GetChild(var_2_6, iter_2_1)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_2_7).name
		arg_2_0["upper_" .. var_1_10006] = var_2_7
	end

	_ = var_1

	local var_2_8 = var_1.map

	_ = var_3
	arg_2_0.tipTfs = var_2_8(var_3.range(arg_2_0._upper.childCount), function(arg_3_0)
		local var_3_0 = arg_2_0._upper
		local var_3_1 = var_1.GetChild(var_3_0, arg_3_0 - 1)

		return {
			name = var_3_1.name,
			trans = var_3_1:Find("tip")
		}
	end)

	local var_2_9 = arg_2_0._tf

	arg_2_0.fireworksTF = var_1.Find(var_2_9, "play_fireworks")
	arg_2_0.containers = {
		arg_2_0.map_front,
		arg_2_0.map_middle
	}
	GraphPath = var_1

	local var_2_10 = var_1.New

	import = var_2_9
	arg_2_0.graphPath = var_2_10(var_2_9("GameCfg.BackHillGraphs.SpringFestival2023Graph"))
	AutoLoader = var_1
	arg_2_0.loader = var_1.New()

	return
end

function var_0_1.didEnter(arg_4_0)
	local var_4_0

	if arg_4_0.contextData.openFireworkLayer then
		var_4_0 = arg_4_0.contextData
		var_4_0.openFireworkLayer = nil

		arg_4_0:OpenFireworkLayer()
	end

	onButton = var_4_0

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0._tf

	var_4_0(var_4_1, var_4.Find(var_4_2, "top/return_btn"), function()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_BACK)

		return
	end)

	onButton = var_4_0

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0._tf

	var_4_0(var_4_3, var_4.Find(var_4_4, "top/return_main_btn"), function()
		local var_6_0 = arg_4_0

		var_0.emit(var_6_0, var_0_1.ON_HOME)

		return
	end)

	onButton = var_4_0

	local var_4_5 = arg_4_0
	local var_4_6 = arg_4_0._tf

	var_4_0(var_4_5, var_4.Find(var_4_6, "top/help_btn"), function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		pg = var_2_10004
		var_7_2.helps = var_2_10004.gametip.help_chunjie2023.tip

		var_7_1(var_7_0, var_7_2)

		return
	end)

	onButton = var_4_0

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0._tf

	var_4_0(var_4_7, var_4.Find(var_4_8, "top/firework_btn"), function()
		local var_8_0 = arg_4_0

		var_0.OpenFireworkLayer(var_8_0)

		return
	end)

	onButton = var_4_0

	var_4_0(arg_4_0, arg_4_0.fireworksTF, function()
		local var_9_0 = arg_4_0

		var_0.StopPlayFireworks(var_9_0)

		return
	end)
	arg_4_0:BindItemSkinShop()

	local var_4_9 = arg_4_0

	arg_4_0.BindItemBuildShip(var_4_9)

	getProxy = var_1
	ActivityProxy = var_4_9

	local var_4_10 = var_1(var_4_9)
	local var_4_11 = var_1.getActivityById

	ActivityConst = var_4

	local var_4_12 = var_4_11(var_4_10, var_4.MINIGAME_SPRING_FESTIVAL_2023)

	arg_4_0:InitStudents(var_4_12 and var_4_12.id, 2, 3)

	local var_4_13 = arg_4_0

	arg_4_0.InitFacilityCross(var_4_13, arg_4_0._map, arg_4_0._upper, "xiaoyouxi", function()
		pg = var_2_10000

		local var_10_0 = var_2_10000.m02
		local var_10_1 = var_0.sendNotification

		GAME = var_2_10003

		var_10_1(var_10_0, var_2_10003.GO_MINI_GAME, 48)

		return
	end)

	getProxy = var_2
	ActivityProxy = var_4_13

	local var_4_14 = var_2(var_4_13)
	local var_4_15 = var_2.getActivityById

	ActivityConst = var_5

	local var_4_16 = var_4_15(var_4_14, var_5.FIREWORK_PT_ID)
	local var_4_17 = arg_4_0

	arg_4_0.InitFacilityCross(var_4_17, arg_4_0._map, arg_4_0._upper, "yanhua", function()
		local var_11_0 = arg_4_0
		local var_11_1 = var_0.emit

		SpringFestival2023Mediator = var_2_10003

		local var_11_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_11_3 = var_2_10004.ACTIVITY
		local var_11_4 = {}
		local var_11_5

		if var_4_16 then
			var_11_5 = var_4_16.id
		end

		var_11_4.id = var_11_5

		var_11_1(var_11_0, var_11_2, var_11_3, var_11_4)

		return
	end)

	getProxy = var_3
	ActivityProxy = var_4_17

	local var_4_18 = var_3(var_4_17)
	local var_4_19 = var_3.getActivityById

	ActivityConst = var_6

	local var_4_20 = var_4_19(var_4_18, var_6.ACTIVITY_COUPLET)

	arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "duilian", function()
		local var_12_0 = arg_4_0
		local var_12_1 = var_0.emit

		SpringFestival2023Mediator = var_2_10003

		local var_12_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_12_3 = var_2_10004.ACTIVITY
		local var_12_4 = {}
		local var_12_5

		if var_4_20 then
			var_12_5 = var_4_20.id
		end

		var_12_4.id = var_12_5

		var_12_1(var_12_0, var_12_2, var_12_3, var_12_4)

		return
	end)
	arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "jiulou", function()
		local var_13_0 = arg_4_0
		local var_13_1 = var_0.emit

		NewYearFestivalMediator = var_2_10003

		local var_13_2 = var_2_10003.GO_SUBLAYER

		Context = var_2_10004

		local var_13_3 = var_2_10004.New
		local var_13_4 = {}

		RedPacketMediator = var_2_10007
		var_13_4.mediator = var_2_10007
		RedPacketLayer = var_2_10007
		var_13_4.viewComponent = var_2_10007

		function var_13_4.onRemoved()
			local var_14_0 = arg_4_0

			var_0.PlayBGM(var_14_0)

			return
		end

		var_13_1(var_13_0, var_13_2, var_13_3(var_13_4))

		return
	end)
	arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "huituriji", function()
		local var_15_0 = arg_4_0
		local var_15_1 = var_0.emit

		SpringFestival2023Mediator = var_2_10003

		local var_15_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_15_1(var_15_0, var_15_2, var_2_10004.COLORING)

		return
	end)
	arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "huazhongshijie", function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_16_0 = var_2_10000(var_2_10002)
		local var_16_1 = var_0.getActivityByType

		ActivityConst = var_2_10003

		if not var_16_1(var_16_0, var_2_10003.ACTIVITY_TYPE_WORLDINPICTURE) or var_0:isEnd() then
			pg = var_2_10001

			local var_16_2 = var_2_10001.TipsMgr.GetInstance()
			local var_16_3 = var_1.ShowTips

			i18n = var_2_10004

			var_16_3(var_16_2, var_2_10004("common_activity_end"))

			return
		end

		local var_16_4 = var_0:getConfig("config_client").linkActID

		pg = var_16_0

		local var_16_5 = var_16_0.m02
		local var_16_6 = var_2.sendNotification

		GAME = var_2_10005

		local var_16_7 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_16_6(var_16_5, var_16_7, var_2_10006.ACTIVITY, {
			id = var_16_4
		})

		return
	end)
	arg_4_0:UpdateView()
	arg_4_0:AutoFitScreen()

	return
end

function var_0_1.OpenFireworkLayer(arg_17_0)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.emit

	SpringFestival2023Mediator = var_1_10004

	local var_17_2 = var_1_10004.GO_SUBLAYER

	Context = var_1_10005

	local var_17_3 = var_1_10005.New
	local var_17_4 = {}

	FireworkPanelMediator = var_1_10008
	var_17_4.mediator = var_1_10008
	FireworkPanelLayer = var_1_10008
	var_17_4.viewComponent = var_1_10008

	var_17_1(var_17_0, var_17_2, var_17_3(var_17_4))

	return
end

function var_0_1.PlayFireworks(arg_18_0, arg_18_1)
	if not arg_18_1 or #arg_18_1 == 0 then
		return
	end

	setActive = var_1_10002

	var_1_10002(arg_18_0._upper, false)

	setActive = var_1_10002

	var_1_10002(arg_18_0.top, false)

	eachChild = var_1_10002

	var_1_10002(arg_18_0.fireworksTF, function(arg_19_0)
		setActive = var_2_10001

		var_2_10001(arg_19_0, false)

		return
	end)

	setActive = var_1_10002

	var_1_10002(arg_18_0.fireworksTF, true)
	arg_18_0:StopFireworksTimer()

	arg_18_0.fireworks = arg_18_1
	arg_18_0.index = 1

	arg_18_0:PlayerOneFirework()

	if #arg_18_1 > 1 then
		Timer = var_2
		arg_18_0.fireworksTimer = var_2.New(function()
			local var_20_0 = arg_18_0

			var_0.PlayerOneFirework(var_20_0)

			return
		end, var_0_1.EffectInterval, #arg_18_1 - 1)

		local var_18_0 = arg_18_0.fireworksTimer

		var_2.Start(var_18_0)
	end

	return
end

function var_0_1.PlayerOneFirework(arg_21_0)
	if arg_21_0.index == #arg_21_0.fireworks then
		var_1_10003 = arg_21_0

		local var_21_0 = arg_21_0.managedTween

		LeanTween = var_1_10004

		var_21_0(var_1_10003, var_1_10004.delayedCall, function()
			local var_22_0 = arg_21_0

			var_0.StopPlayFireworks(var_22_0)

			return
		end, var_0_1.DelayPop, nil)
	end

	local var_21_1 = arg_21_0.fireworks[arg_21_0.index]
	local var_21_2 = arg_21_0.fireworksTF
	local var_21_3 = var_2.Find

	tostring = var_1_10005

	local var_21_4 = var_21_3(var_21_2, var_1_10005(var_21_1))

	math = var_1_10003

	local var_21_5 = var_1_10003.random(#var_0_1.SFX_LIST)

	if var_21_4 then
		setLocalPosition = var_21_2

		var_21_2(var_21_4, arg_21_0:GetFireworkPos())

		setActive = var_21_2

		var_21_2(var_21_4, true)

		pg = var_21_2

		local var_21_6 = var_21_2.CriMgr.GetInstance()

		var_4.PlaySoundEffect_V3(var_21_6, var_0_1.SFX_LIST[var_21_5])
	else
		local var_21_7 = arg_21_0.loader

		var_4.GetPrefab(var_21_7, "ui/" .. var_0_1.Id2EffectName[var_21_1], "", function(arg_23_0)
			pg = var_2_10001

			var_2_10001.ViewUtils.SetSortingOrder(arg_23_0, 1)

			arg_23_0.name = var_21_1
			setParent = var_1

			var_1(arg_23_0, arg_21_0.fireworksTF)

			setLocalPosition = var_1

			local var_23_0 = arg_23_0
			local var_23_1 = arg_21_0

			var_1(var_23_0, var_4.GetFireworkPos(var_23_1))

			setActive = var_1

			var_1(arg_23_0, true)

			pg = var_1

			local var_23_2 = var_1.CriMgr.GetInstance()

			var_1.PlaySoundEffect_V3(var_23_2, var_0_1.SFX_LIST[var_21_5])

			return
		end)
	end

	arg_21_0.index = arg_21_0.index + 1

	return
end

function var_0_1.GetFireworkPos(arg_24_0)
	Vector2 = var_1_10001

	local var_24_0 = var_1_10001(0, 0)
	local var_24_1

	if arg_24_0.lastPos then
		Vector2 = var_24_1
		var_24_1 = var_24_1(arg_24_0.lastPos.x, arg_24_0.lastPos.y)
		math = var_3

		local var_24_2 = var_3.abs(var_24_1.x - arg_24_0.lastPos.x)

		math = var_4

		local var_24_3 = var_4.abs(var_24_1.y - arg_24_0.lastPos.y)

		while var_24_2 < var_0_1.FireworkRange.x / 2 and var_24_3 < var_0_1.FireworkRange.y or var_24_3 < var_0_1.FireworkRange.y / 2 and var_24_2 < var_0_1.FireworkRange.x do
			math = var_5
			var_24_1.x = var_5.random(var_0_1.EffectPosLimit.limitX[1], var_0_1.EffectPosLimit.limitX[2])
			math = var_5
			var_24_1.y = var_5.random(var_0_1.EffectPosLimit.limitY[1], var_0_1.EffectPosLimit.limitY[2])
			math = var_5
			var_24_2 = var_5.abs(var_24_1.x - arg_24_0.lastPos.x)
			math = var_5
			var_24_3 = var_5.abs(var_24_1.y - arg_24_0.lastPos.y)
		end

		var_24_0 = var_24_1
	else
		math = var_24_1
		var_24_0.x = var_24_1.random(var_0_1.EffectPosLimit.limitX[1], var_0_1.EffectPosLimit.limitX[2])
		math = var_2
		var_24_0.y = var_2.random(var_0_1.EffectPosLimit.limitY[1], var_0_1.EffectPosLimit.limitY[2])
	end

	arg_24_0.lastPos = var_24_0

	return var_24_0
end

function var_0_1.StopFireworksTimer(arg_25_0)
	if arg_25_0.fireworksTimer then
		local var_25_0 = arg_25_0.fireworksTimer

		var_1.Stop(var_25_0)

		arg_25_0.fireworksTimer = nil
	end

	return
end

function var_0_1.StopPlayFireworks(arg_26_0)
	arg_26_0:StopFireworksTimer()

	arg_26_0.fireworks = nil
	arg_26_0.index = nil
	setActive = var_1

	var_1(arg_26_0._upper, true)

	setActive = var_1

	var_1(arg_26_0.top, true)

	setActive = var_1

	var_1(arg_26_0.fireworksTF, false)
	arg_26_0:OpenFireworkLayer()

	return
end

function var_0_1.UpdateView(arg_27_0)
	_ = var_1_10001

	var_1_10001.each(arg_27_0.tipTfs, function(arg_28_0)
		if arg_28_0.trans then
			setActive = var_1

			local var_28_0 = arg_28_0.trans

			tobool = var_2_10004

			var_1(var_28_0, var_2_10004(var_0_1.CheckTip(arg_28_0.name)))
		end

		return
	end)

	return
end

function var_0_1.willExit(arg_29_0)
	arg_29_0:clearStudents()
	arg_29_0:StopFireworksTimer()
	arg_29_0:cleanManagedTween()

	local var_29_0 = arg_29_0.loader

	var_1.Clear(var_29_0)

	return
end

function var_0_1.CheckTip(arg_30_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_30_0 = var_1_10001(var_1_10003)

	switch = var_1_10002

	return var_1_10002(arg_30_0, {
		xiaoyouxi = function()
			BackHillTemplate = var_2_10000

			local var_31_0 = var_2_10000.IsMiniActNeedTip

			ActivityConst = var_2_10002

			return var_31_0(var_2_10002.MINIGAME_SPRING_FESTIVAL_2023)
		end,
		huituriji = function()
			getProxy = var_2_10000
			ColoringProxy = var_2_10002

			local var_32_0 = var_2_10000(var_2_10002)

			return var_0.CheckTodayTip(var_32_0)
		end,
		huazhongshijie = function()
			local var_33_0 = var_30_0
			local var_33_1 = var_0.getActivityByType

			ActivityConst = var_2_10003

			local var_33_2 = var_33_1(var_33_0, var_2_10003.ACTIVITY_TYPE_WORLDINPICTURE)

			Activity = var_2_10001

			return var_2_10001.IsActivityReady(var_33_2)
		end,
		jiulou = function()
			RedPacketLayer = var_2_10000

			return var_2_10000.isShowRedPoint()
		end,
		yanhua = function()
			local var_35_0 = var_30_0
			local var_35_1 = var_0.getActivityById

			ActivityConst = var_2_10003

			local var_35_2 = var_35_1(var_35_0, var_2_10003.FIREWORK_PT_ID)

			Activity = var_2_10001

			return var_2_10001.IsActivityReady(var_35_2)
		end,
		duilian = function()
			local var_36_0 = var_30_0
			local var_36_1 = var_0.getActivityById

			ActivityConst = var_2_10003

			local var_36_2 = var_36_1(var_36_0, var_2_10003.ACTIVITY_COUPLET)

			Activity = var_2_10001

			return var_2_10001.IsActivityReady(var_36_2)
		end
	}, function()
		return false
	end)
end

function var_0_1.IsShowMainTip(arg_38_0)
	local var_38_0 = {
		"xiaoyouxi",
		"huituriji",
		"huazhongshijie",
		"jiulou",
		"yanhua",
		"duilian"
	}

	_ = var_1_10002

	return var_1_10002.any(var_38_0, function(arg_39_0)
		tobool = var_2_10001

		return var_2_10001(var_0_1.CheckTip(arg_39_0))
	end)
end

return var_0_1
