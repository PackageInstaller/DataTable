class = var_0_10000

local var_0_0 = "SpringFestival2024Scene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.BackHills.TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CHT = var_1_10002

	if var_1_10001 == var_1_10002 then
		return "SpringFestival2024TWUI"
	else
		return "SpringFestival2024UI"
	end

	return
end

var_0_1.edge2area = {
	default = "_SDPlace"
}
var_0_1.EffectPoolCnt = 3
var_0_1.Id2EffectName = {
	[70177] = "yanhua_hongbao",
	[70176] = "yanhua_Azurlane",
	[70175] = "yanhua_2024",
	[70174] = "yanhua_xiaojiajia",
	[70173] = "yanhua_xinxin",
	[70172] = "yanhua_jiezhi",
	[70171] = "yanhua_huangji",
	[70170] = "yanhua_chuanmao",
	[70169] = "yanhua_long",
	[70168] = "yanhua_mofang",
	[70167] = "yanhua_maomao",
	[70166] = "yanhua_02",
	[70165] = "yanhua_01",
	[70178] = "yanhua_denglong"
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

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

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

	local var_2_4 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_4, "upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_5 = arg_2_0._upper
		local var_2_6 = var_5.GetChild(var_2_5, iter_2_1)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_2_6).name
		arg_2_0["upper_" .. var_1_10006] = var_2_6
	end

	_ = var_1

	local var_2_7 = var_1.map

	_ = var_3
	arg_2_0.tipTfs = var_2_7(var_3.range(arg_2_0._upper.childCount), function(arg_3_0)
		local var_3_0 = arg_2_0._upper
		local var_3_1 = var_1.GetChild(var_3_0, arg_3_0 - 1)

		return {
			name = var_3_1.name,
			trans = var_3_1:Find("Tip")
		}
	end)

	local var_2_8 = arg_2_0._tf

	arg_2_0._SDPlace = var_1.Find(var_2_8, "SDPlace")
	arg_2_0.containers = {
		arg_2_0._SDPlace
	}

	local var_2_9 = arg_2_0._map

	arg_2_0._shipTpl = var_1.Find(var_2_9, "ship")
	GraphPath = var_1

	local var_2_10 = var_1.New

	import = var_2_9
	arg_2_0.graphPath = var_2_10(var_2_9("GameCfg.BackHillGraphs.SpringFestival2024Graph"))

	local var_2_11 = arg_2_0._tf

	arg_2_0.fireworksTF = var_1.Find(var_2_11, "play_fireworks")

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf

	var_1_10001(var_4_0, var_4.Find(var_4_1, "top/Back"), function()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_BACK)

		return
	end)

	onButton = var_1_10001

	local var_4_2 = arg_4_0
	local var_4_3 = arg_4_0._tf

	var_1_10001(var_4_2, var_4.Find(var_4_3, "top/Home"), function()
		local var_6_0 = arg_4_0

		var_0.emit(var_6_0, var_0_1.ON_HOME)

		return
	end)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0._tf

	var_1_10001(var_4_4, var_4.Find(var_4_5, "top/Help"), function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		pg = var_2_10004
		var_7_2.helps = var_2_10004.gametip.help_chunjie2024.tip

		var_7_1(var_7_0, var_7_2)

		return
	end)

	onButton = var_1_10001

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0._tf

	var_1_10001(var_4_6, var_4.Find(var_4_7, "top/firework_btn"), function()
		local var_8_0 = arg_4_0

		var_0.OpenFireworkLayer(var_8_0)

		return
	end)
	arg_4_0:BindItemSkinShop()

	local var_4_8 = arg_4_0

	arg_4_0.BindItemBuildShip(var_4_8)

	getProxy = var_1
	ActivityProxy = var_4_8

	local var_4_9 = var_1(var_4_8)
	local var_4_10 = var_1.getActivityById

	ActivityConst = var_4

	local var_4_11 = var_4_10(var_4_9, var_4.MINIGAME_SPRING_FESTIVAL_2024)

	arg_4_0:InitStudents(var_4_11 and var_4_11.id, 4, 4)

	PLATFORM_CODE = var_2
	PLATFORM_CHT = var_4_9

	if var_2 == var_4_9 then
		arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "feicaiyingxinchuntw", function()
			local var_9_0 = arg_4_0
			local var_9_1 = var_0.emit

			SpringFestival2024Mediator = var_2_10003

			local var_9_2 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			local var_9_3 = var_2_10004.ACTIVITY
			local var_9_4 = {}

			ActivityConst = var_2_10006
			var_9_4.id = var_2_10006.FIREWORK_PT_2024_ID

			var_9_1(var_9_0, var_9_2, var_9_3, var_9_4)

			return
		end)
		arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "aomeiyingchun", function()
			local var_10_0 = arg_4_0
			local var_10_1 = var_0.emit

			SpringFestival2024Mediator = var_2_10003

			local var_10_2 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			local var_10_3 = var_2_10004.ACTIVITY
			local var_10_4 = {}

			ActivityConst = var_2_10006
			var_10_4.id = var_2_10006.ACTIVITY_COUPLET

			var_10_1(var_10_0, var_10_2, var_10_3, var_10_4)

			return
		end)
		arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "huazhongshijie", function()
			getProxy = var_2_10000
			ActivityProxy = var_2_10002

			local var_11_0 = var_2_10000(var_2_10002)
			local var_11_1 = var_0.getActivityById

			ActivityConst = var_2_10003

			if not var_11_1(var_11_0, var_2_10003.ACTIVITY_HUAZHONGSHIJIE) or var_0:isEnd() then
				pg = var_2_10001

				local var_11_2 = var_2_10001.TipsMgr.GetInstance()
				local var_11_3 = var_1.ShowTips

				i18n = var_2_10004

				var_11_3(var_11_2, var_2_10004("common_activity_end"))

				return
			end

			local var_11_4 = var_0:getConfig("config_client").linkActID
			local var_11_5 = arg_4_0
			local var_11_6 = var_2.emit

			SpringFestival2024Mediator = var_2_10005

			local var_11_7 = var_2_10005.GO_SCENE

			SCENE = var_2_10006

			var_11_6(var_11_5, var_11_7, var_2_10006.ACTIVITY, {
				id = var_11_4
			})

			return
		end)
	else
		arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "feicaiyingxinchun", function()
			local var_12_0 = arg_4_0
			local var_12_1 = var_0.emit

			SpringFestival2024Mediator = var_2_10003

			local var_12_2 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			local var_12_3 = var_2_10004.ACTIVITY
			local var_12_4 = {}

			ActivityConst = var_2_10006
			var_12_4.id = var_2_10006.FIREWORK_PT_2024_ID

			var_12_1(var_12_0, var_12_2, var_12_3, var_12_4)

			return
		end)
		arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "meiyiyannian", function()
			local var_13_0 = arg_4_0
			local var_13_1 = var_0.emit

			SpringFestival2024Mediator = var_2_10003

			local var_13_2 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			local var_13_3 = var_2_10004.ACTIVITY
			local var_13_4 = {}

			ActivityConst = var_2_10006
			var_13_4.id = var_2_10006.TAIYUAN_ALERT_TASK

			var_13_1(var_13_0, var_13_2, var_13_3, var_13_4)

			return
		end)
		arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "xinchunmaoxianwang", function()
			local var_14_0 = arg_4_0
			local var_14_1 = var_0.emit

			SpringFestival2024Mediator = var_2_10003

			local var_14_2 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			local var_14_3 = var_2_10004.ACTIVITY
			local var_14_4 = {}

			ActivityConst = var_2_10006
			var_14_4.id = var_2_10006.FEIYUEN_LOGIN

			var_14_1(var_14_0, var_14_2, var_14_3, var_14_4)

			return
		end)
	end

	arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "fushundamaoxian", function()
		pg = var_2_10000

		local var_15_0 = var_2_10000.m02
		local var_15_1 = var_0.sendNotification

		GAME = var_2_10003

		var_15_1(var_15_0, var_2_10003.GO_MINI_GAME, 37)

		return
	end)
	arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "jiujiudajiulou", function()
		local var_16_0 = arg_4_0
		local var_16_1 = var_0.emit

		SpringFestival2024Mediator = var_2_10003

		local var_16_2 = var_2_10003.GO_SUBLAYER

		Context = var_2_10004

		local var_16_3 = var_2_10004.New
		local var_16_4 = {}

		RedPacketMediator = var_2_10007
		var_16_4.mediator = var_2_10007
		RedPacketLayer = var_2_10007
		var_16_4.viewComponent = var_2_10007

		function var_16_4.onRemoved()
			local var_17_0 = arg_4_0

			var_0.PlayBGM(var_17_0)

			return
		end

		var_16_1(var_16_0, var_16_2, var_16_3(var_16_4))

		return
	end)
	arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "huituriji", function()
		local var_18_0 = arg_4_0
		local var_18_1 = var_0.emit

		SpringFestival2024Mediator = var_2_10003

		local var_18_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_18_1(var_18_0, var_18_2, var_2_10004.COLORING)

		return
	end)
	arg_4_0:UpdateView()

	arg_4_0.firePools = {}

	if arg_4_0.contextData.openFireworkLayer then
		arg_4_0.contextData.openFireworkLayer = nil

		arg_4_0:OpenFireworkLayer()
	else
		arg_4_0:PlayFireworks()
	end

	if arg_4_0.contextData.isOpenRedPacket then
		arg_4_0.contextData.isOpenRedPacket = nil

		local var_4_12 = arg_4_0
		local var_4_13 = arg_4_0.emit

		SpringFestival2024Mediator = var_5

		local var_4_14 = var_5.GO_SUBLAYER

		Context = var_6

		local var_4_15 = var_6.New
		local var_4_16 = {}

		RedPacketMediator = var_1_10009
		var_4_16.mediator = var_1_10009
		RedPacketLayer = var_1_10009
		var_4_16.viewComponent = var_1_10009

		function var_4_16.onRemoved()
			local var_19_0 = arg_4_0

			var_0.PlayBGM(var_19_0)

			return
		end

		var_4_13(var_4_12, var_4_14, var_4_15(var_4_16))
	end

	return
end

function var_0_1.UpdateActivity(arg_20_0, arg_20_1)
	arg_20_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_21_0)
	_ = var_1_10001

	var_1_10001.each(arg_21_0.tipTfs, function(arg_22_0)
		if arg_22_0.trans then
			setActive = var_1

			local var_22_0 = arg_22_0.trans

			tobool = var_2_10004

			var_1(var_22_0, var_2_10004(var_0_1.CheckTip(arg_22_0.name)))
		end

		return
	end)

	return
end

function var_0_1.OpenFireworkLayer(arg_23_0)
	local var_23_0 = arg_23_0
	local var_23_1 = arg_23_0.emit

	SpringFestival2024Mediator = var_1_10004

	local var_23_2 = var_1_10004.GO_SUBLAYER

	Context = var_1_10005

	local var_23_3 = var_1_10005.New
	local var_23_4 = {}

	FireworkPanel2024Mediator = var_1_10008
	var_23_4.mediator = var_1_10008
	FireworkPanel2024Layer = var_1_10008
	var_23_4.viewComponent = var_1_10008
	var_23_4.data = {
		onExit = function()
			local var_24_0 = arg_23_0

			var_0.PlayFireworks(var_24_0)

			return
		end
	}

	var_23_1(var_23_0, var_23_2, var_23_3(var_23_4))

	return
end

function var_0_1.PlayFireworks(arg_25_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_25_0 = var_1_10001(var_1_10003)
	local var_25_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_25_2 = var_25_1(var_25_0, var_1_10004.ACTIVITY_TYPE_FIREWORK)

	assert = var_1_10002

	var_1_10002(var_25_2 and not var_25_2:isEnd(), "烟花活动(type92)已结束")

	getProxy = var_1_10002
	PlayerProxy = var_4

	local var_25_3 = var_1_10002(var_4)
	local var_25_4 = var_2.getData(var_25_3).id

	pg = var_25_0

	local var_25_5 = var_25_0.activity_template[var_25_2.id].config_data[3]

	arg_25_0.fireworks = {}

	for iter_25_0 = 1, #var_25_5 do
		PlayerPrefs = var_1_10008

		if var_1_10008.GetInt("fireworks_" .. var_25_2.id .. "_" .. var_25_4 .. "_pos_" .. iter_25_0) ~= 0 then
			table = var_1_10009

			var_1_10009.insert(arg_25_0.fireworks, var_1_10008)
		end
	end

	if #arg_25_0.fireworks == 0 then
		return
	end

	eachChild = var_4

	var_4(arg_25_0.fireworksTF, function(arg_26_0)
		setActive = var_2_10001

		var_2_10001(arg_26_0, false)

		return
	end)

	setActive = var_4

	var_4(arg_25_0.fireworksTF, true)
	arg_25_0:StopFireworksTimer()

	arg_25_0.index = 1
	Timer = var_4
	arg_25_0.fireworksTimer = var_4.New(function()
		local var_27_0 = arg_25_0

		var_0.PlayerOneFirework(var_27_0)

		return
	end, var_0_1.EffectInterval, #arg_25_0.fireworks)

	local var_25_6 = arg_25_0.fireworksTimer

	var_4.Start(var_25_6)

	return
end

function var_0_1.PlayerOneFirework(arg_28_0)
	if arg_28_0.index == #arg_28_0.fireworks then
		local var_28_0 = arg_28_0
		local var_28_1 = arg_28_0.managedTween

		LeanTween = var_1_10004

		var_28_1(var_28_0, var_1_10004.delayedCall, function()
			local var_29_0 = arg_28_0

			var_0.StopPlayFireworks(var_29_0)

			local var_29_1 = arg_28_0

			var_0.PlayFireworks(var_29_1)

			return
		end, var_0_1.DelayPop, nil)
	end

	local var_28_2 = arg_28_0.fireworks[arg_28_0.index]

	math = var_2

	local var_28_3 = var_2.random(#var_0_1.SFX_LIST)

	if arg_28_0.firePools[var_28_2] and #arg_28_0.firePools[var_28_2] >= var_0_1.EffectPoolCnt then
		local var_28_4 = arg_28_0.firePools[var_28_2][var_0_1.EffectPoolCnt]

		setLocalPosition = var_4

		var_4(var_28_4, arg_28_0:GetFireworkPos())

		setActive = var_4

		var_4(var_28_4, false)

		setActive = var_4

		var_4(var_28_4, true)

		pg = var_4

		local var_28_5 = var_4.CriMgr.GetInstance()

		var_4.PlaySoundEffect_V3(var_28_5, var_0_1.SFX_LIST[var_28_3])

		table = var_4

		var_4.removebyvalue(arg_28_0.firePools[var_28_2], var_28_4)

		table = var_4

		var_4.insert(arg_28_0.firePools[var_28_2], var_28_4)
	else
		local var_28_6 = arg_28_0.loader

		var_3.GetPrefab(var_28_6, "ui/" .. var_0_1.Id2EffectName[var_28_2], "", function(arg_30_0)
			pg = var_2_10001

			var_2_10001.ViewUtils.SetSortingOrder(arg_30_0, 1)

			setParent = var_1

			var_1(arg_30_0, arg_28_0.fireworksTF)

			setLocalPosition = var_1

			local var_30_0 = arg_30_0
			local var_30_1 = arg_28_0

			var_1(var_30_0, var_4.GetFireworkPos(var_30_1))

			setActive = var_1

			var_1(arg_30_0, true)

			pg = var_1

			local var_30_2 = var_1.CriMgr.GetInstance()

			var_1.PlaySoundEffect_V3(var_30_2, var_0_1.SFX_LIST[var_28_3])

			local var_30_3

			if not arg_28_0.firePools[var_28_2] then
				var_30_3 = arg_28_0.firePools
				var_30_3[var_28_2] = {}
			end

			table = var_30_3

			var_30_3.insert(arg_28_0.firePools[var_28_2], arg_30_0)

			return
		end)
	end

	arg_28_0.index = arg_28_0.index + 1

	return
end

function var_0_1.GetFireworkPos(arg_31_0)
	Vector2 = var_1_10001

	local var_31_0 = var_1_10001(0, 0)
	local var_31_1

	if arg_31_0.lastPos then
		Vector2 = var_31_1
		var_31_1 = var_31_1(arg_31_0.lastPos.x, arg_31_0.lastPos.y)
		math = var_3

		local var_31_2 = var_3.abs(var_31_1.x - arg_31_0.lastPos.x)

		math = var_4

		local var_31_3 = var_4.abs(var_31_1.y - arg_31_0.lastPos.y)

		while var_31_2 < var_0_1.FireworkRange.x / 2 and var_31_3 < var_0_1.FireworkRange.y or var_31_3 < var_0_1.FireworkRange.y / 2 and var_31_2 < var_0_1.FireworkRange.x do
			math = var_5
			var_31_1.x = var_5.random(var_0_1.EffectPosLimit.limitX[1], var_0_1.EffectPosLimit.limitX[2])
			math = var_5
			var_31_1.y = var_5.random(var_0_1.EffectPosLimit.limitY[1], var_0_1.EffectPosLimit.limitY[2])
			math = var_5
			var_31_2 = var_5.abs(var_31_1.x - arg_31_0.lastPos.x)
			math = var_5
			var_31_3 = var_5.abs(var_31_1.y - arg_31_0.lastPos.y)
		end

		var_31_0 = var_31_1
	else
		math = var_31_1
		var_31_0.x = var_31_1.random(var_0_1.EffectPosLimit.limitX[1], var_0_1.EffectPosLimit.limitX[2])
		math = var_2
		var_31_0.y = var_2.random(var_0_1.EffectPosLimit.limitY[1], var_0_1.EffectPosLimit.limitY[2])
	end

	arg_31_0.lastPos = var_31_0

	return var_31_0
end

function var_0_1.StopFireworksTimer(arg_32_0)
	if arg_32_0.fireworksTimer then
		local var_32_0 = arg_32_0.fireworksTimer

		var_1.Stop(var_32_0)

		arg_32_0.fireworksTimer = nil
	end

	return
end

function var_0_1.StopPlayFireworks(arg_33_0)
	arg_33_0:StopFireworksTimer()

	arg_33_0.fireworks = nil
	arg_33_0.index = nil
	setActive = var_1

	var_1(arg_33_0.fireworksTF, false)

	return
end

function var_0_1.willExit(arg_34_0)
	arg_34_0:StopPlayFireworks()
	arg_34_0:clearStudents()
	var_0_1.super.willExit(arg_34_0)

	return
end

function var_0_1.CheckTip(arg_35_0)
	switch = var_1_10001

	return var_1_10001(arg_35_0, {
		fushundamaoxian = function()
			BackHillTemplate = var_2_10000

			local var_36_0 = var_2_10000.IsMiniActNeedTip

			ActivityConst = var_2_10002

			return var_36_0(var_2_10002.MINIGAME_SPRING_FESTIVAL_2024)
		end,
		huituriji = function()
			getProxy = var_2_10000
			ColoringProxy = var_2_10002

			local var_37_0 = var_2_10000(var_2_10002)

			return var_0.CheckTodayTip(var_37_0)
		end,
		jiujiudajiulou = function()
			RedPacketLayer = var_2_10000

			return var_2_10000.isShowRedPoint()
		end,
		xinchunmaoxianwang = function()
			getProxy = var_2_10000
			ActivityProxy = var_2_10002

			local var_39_0 = var_2_10000(var_2_10002)
			local var_39_1 = var_0.getActivityById

			ActivityConst = var_2_10003

			local var_39_2 = var_39_1(var_39_0, var_2_10003.FEIYUEN_LOGIN)

			Activity = var_2_10001

			return var_2_10001.IsActivityReady(var_39_2)
		end,
		meiyiyannian = function()
			getProxy = var_2_10000
			ActivityProxy = var_2_10002

			local var_40_0 = var_2_10000(var_2_10002)
			local var_40_1 = var_0.getActivityById

			ActivityConst = var_2_10003

			local var_40_2 = var_40_1(var_40_0, var_2_10003.TAIYUAN_ALERT_TASK)

			Activity = var_2_10001

			return var_2_10001.IsActivityReady(var_40_2)
		end,
		feicaiyingxinchun = function()
			getProxy = var_2_10000
			ActivityProxy = var_2_10002

			local var_41_0 = var_2_10000(var_2_10002)
			local var_41_1 = var_0.getActivityById

			ActivityConst = var_2_10003

			local var_41_2 = var_41_1(var_41_0, var_2_10003.FIREWORK_PT_2024_ID)

			Activity = var_2_10001

			return var_2_10001.IsActivityReady(var_41_2)
		end,
		feicaiyingxinchuntw = function()
			getProxy = var_2_10000
			ActivityProxy = var_2_10002

			local var_42_0 = var_2_10000(var_2_10002)
			local var_42_1 = var_0.getActivityById

			ActivityConst = var_2_10003

			local var_42_2 = var_42_1(var_42_0, var_2_10003.FIREWORK_PT_2024_ID)

			Activity = var_2_10001

			return var_2_10001.IsActivityReady(var_42_2)
		end,
		aomeiyingchun = function()
			getProxy = var_2_10000
			ActivityProxy = var_2_10002

			local var_43_0 = var_2_10000(var_2_10002)
			local var_43_1 = var_0.getActivityById

			ActivityConst = var_2_10003

			local var_43_2 = var_43_1(var_43_0, var_2_10003.ACTIVITY_COUPLET)

			Activity = var_2_10001

			return var_2_10001.IsActivityReady(var_43_2)
		end,
		huazhongshijie = function()
			getProxy = var_2_10000
			ActivityProxy = var_2_10002

			local var_44_0 = var_2_10000(var_2_10002)
			local var_44_1 = var_0.getActivityById

			ActivityConst = var_2_10003

			local var_44_2 = var_44_1(var_44_0, var_2_10003.ACTIVITY_HUAZHONGSHIJIE)

			Activity = var_2_10001

			return var_2_10001.IsActivityReady(var_44_2)
		end
	}, function()
		return false
	end)
end

function var_0_1.IsShowMainTip(arg_46_0)
	local var_46_0 = {
		"fushundamaoxian",
		"huituriji",
		"jiujiudajiulou",
		"xinchunmaoxianwang",
		"meiyiyannian",
		"feicaiyingxinchun"
	}

	PLATFORM_CODE = var_1_10002
	PLATFORM_CHT = var_1_10003

	if var_1_10002 == var_1_10003 then
		var_46_0 = {
			"fushundamaoxian",
			"huituriji",
			"jiujiudajiulou",
			"aomeiyingchun",
			"huazhongshijie",
			"feicaiyingxinchuntw"
		}
	end

	_ = var_1_10002

	return var_1_10002.any(var_46_0, function(arg_47_0)
		tobool = var_2_10001

		return var_2_10001(var_0_1.CheckTip(arg_47_0))
	end)
end

return var_0_1
