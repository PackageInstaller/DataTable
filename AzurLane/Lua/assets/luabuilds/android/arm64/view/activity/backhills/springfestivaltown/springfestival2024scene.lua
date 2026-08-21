local var_0_0 = class("SpringFestival2024Scene", import("view.activity.BackHills.TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	if PLATFORM_CODE == PLATFORM_CHT then
		return "SpringFestival2024TWUI"
	else
		return "SpringFestival2024UI"
	end

	return
end

var_0_0.edge2area = {
	default = "_SDPlace"
}
var_0_0.EffectPoolCnt = 3
var_0_0.Id2EffectName = {
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
var_0_0.EffectInterval = 1
var_0_0.DelayPop = 2.5
var_0_0.SFX_LIST = {
	"event:/ui/firework1",
	"event:/ui/firework2",
	"event:/ui/firework3",
	"event:/ui/firework4"
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

	arg_2_0.tipTfs = _.map(_.range(arg_2_0._upper.childCount), function(arg_3_0)
		local var_3_0 = arg_2_0._upper:GetChild(arg_3_0 - 1)

		return {
			name = var_3_0.name,
			trans = var_3_0:Find("Tip")
		}
	end)
	arg_2_0._SDPlace = arg_2_0._tf:Find("SDPlace")
	arg_2_0.containers = {
		arg_2_0._SDPlace
	}
	arg_2_0._shipTpl = arg_2_0._map:Find("ship")
	arg_2_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.SpringFestival2024Graph"))
	arg_2_0.fireworksTF = arg_2_0._tf:Find("play_fireworks")

	return
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf:Find("top/Back"), function()
		arg_4_0:emit(var_0_0.ON_BACK)

		return
	end)
	onButton(arg_4_0, arg_4_0._tf:Find("top/Home"), function()
		arg_4_0:emit(var_0_0.ON_HOME)

		return
	end)
	onButton(arg_4_0, arg_4_0._tf:Find("top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_chunjie2024.tip
		})

		return
	end)
	onButton(arg_4_0, arg_4_0._tf:Find("top/firework_btn"), function()
		arg_4_0:OpenFireworkLayer()

		return
	end)
	arg_4_0:BindItemSkinShop()
	arg_4_0:BindItemBuildShip()

	local var_4_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_SPRING_FESTIVAL_2024)

	arg_4_0:InitStudents(var_4_0 and var_4_0.id, 4, 4)

	if PLATFORM_CODE == PLATFORM_CHT then
		arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "feicaiyingxinchuntw", function()
			arg_4_0:emit(SpringFestival2024Mediator.GO_SCENE, SCENE.ACTIVITY, {
				id = ActivityConst.FIREWORK_PT_2024_ID
			})

			return
		end)
		arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "aomeiyingchun", function()
			arg_4_0:emit(SpringFestival2024Mediator.GO_SCENE, SCENE.ACTIVITY, {
				id = ActivityConst.ACTIVITY_COUPLET
			})

			return
		end)
		arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "huazhongshijie", function()
			local var_11_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_HUAZHONGSHIJIE)

			if not var_11_0 or var_11_0:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			;({}).id = var_11_0:getConfig("config_client").linkActID

			arg_4_0:emit(SpringFestival2024Mediator.GO_SCENE, SCENE.ACTIVITY, {})

			return
		end)
	else
		arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "feicaiyingxinchun", function()
			arg_4_0:emit(SpringFestival2024Mediator.GO_SCENE, SCENE.ACTIVITY, {
				id = ActivityConst.FIREWORK_PT_2024_ID
			})

			return
		end)
		arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "meiyiyannian", function()
			arg_4_0:emit(SpringFestival2024Mediator.GO_SCENE, SCENE.ACTIVITY, {
				id = ActivityConst.TAIYUAN_ALERT_TASK
			})

			return
		end)
		arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "xinchunmaoxianwang", function()
			arg_4_0:emit(SpringFestival2024Mediator.GO_SCENE, SCENE.ACTIVITY, {
				id = ActivityConst.FEIYUEN_LOGIN
			})

			return
		end)
	end

	arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "fushundamaoxian", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 37)

		return
	end)
	arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "jiujiudajiulou", function()
		arg_4_0:emit(SpringFestival2024Mediator.GO_SUBLAYER, Context.New({
			mediator = RedPacketMediator,
			viewComponent = RedPacketLayer,
			onRemoved = function()
				arg_4_0:PlayBGM()

				return
			end
		}))

		return
	end)
	arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "huituriji", function()
		arg_4_0:emit(SpringFestival2024Mediator.GO_SCENE, SCENE.COLORING)

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

		arg_4_0:emit(SpringFestival2024Mediator.GO_SUBLAYER, Context.New({
			mediator = RedPacketMediator,
			viewComponent = RedPacketLayer,
			onRemoved = function()
				arg_4_0:PlayBGM()

				return
			end
		}))
	end

	return
end

function var_0_0.UpdateActivity(arg_20_0, arg_20_1)
	arg_20_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_21_0)
	_.each(arg_21_0.tipTfs, function(arg_22_0)
		if arg_22_0.trans then
			setActive(arg_22_0.trans, tobool(var_0_0.CheckTip(arg_22_0.name)))
		end

		return
	end)

	return
end

function var_0_0.OpenFireworkLayer(arg_23_0)
	arg_23_0:emit(SpringFestival2024Mediator.GO_SUBLAYER, Context.New({
		mediator = FireworkPanel2024Mediator,
		viewComponent = FireworkPanel2024Layer,
		data = {
			onExit = function()
				arg_23_0:PlayFireworks()

				return
			end
		}
	}))

	return
end

function var_0_0.PlayFireworks(arg_25_0)
	local var_25_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FIREWORK)

	assert(var_25_0 and not var_25_0:isEnd(), "烟花活动(type92)已结束")

	local var_25_1 = getProxy(PlayerProxy):getData().id

	arg_25_0.fireworks = {}

	for iter_25_0 = 1, #pg.activity_template[var_25_0.id].config_data[3] do
		local var_25_2 = PlayerPrefs.GetInt("fireworks_" .. var_25_0.id .. "_" .. var_25_1 .. "_pos_" .. iter_25_0)

		if var_25_2 ~= 0 then
			table.insert(arg_25_0.fireworks, var_25_2)
		end
	end

	if #arg_25_0.fireworks == 0 then
		return
	end

	eachChild(arg_25_0.fireworksTF, function(arg_26_0)
		setActive(arg_26_0, false)

		return
	end)
	setActive(arg_25_0.fireworksTF, true)
	arg_25_0:StopFireworksTimer()

	arg_25_0.index = 1
	arg_25_0.fireworksTimer = Timer.New(function()
		arg_25_0:PlayerOneFirework()

		return
	end, var_0_0.EffectInterval, #arg_25_0.fireworks)

	arg_25_0.fireworksTimer:Start()

	return
end

function var_0_0.PlayerOneFirework(arg_28_0)
	if arg_28_0.index == #arg_28_0.fireworks then
		arg_28_0:managedTween(LeanTween.delayedCall, function()
			arg_28_0:StopPlayFireworks()
			arg_28_0:PlayFireworks()

			return
		end, var_0_0.DelayPop, nil)
	end

	local var_28_0 = arg_28_0.fireworks[arg_28_0.index]
	local var_28_1 = math.random(#var_0_0.SFX_LIST)

	if arg_28_0.firePools[arg_28_0.fireworks[arg_28_0.index]] and #arg_28_0.firePools[var_28_0] >= var_0_0.EffectPoolCnt then
		setLocalPosition(arg_28_0.firePools[var_28_0][var_0_0.EffectPoolCnt], arg_28_0:GetFireworkPos())
		setActive(arg_28_0.firePools[var_28_0][var_0_0.EffectPoolCnt], false)
		setActive(arg_28_0.firePools[var_28_0][var_0_0.EffectPoolCnt], true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_0.SFX_LIST[math.random(#var_0_0.SFX_LIST)])
		table.removebyvalue(arg_28_0.firePools[var_28_0], arg_28_0.firePools[var_28_0][var_0_0.EffectPoolCnt])
		table.insert(arg_28_0.firePools[var_28_0], arg_28_0.firePools[var_28_0][var_0_0.EffectPoolCnt])
	else
		arg_28_0.loader:GetPrefab("ui/" .. var_0_0.Id2EffectName[var_28_0], "", function(arg_30_0)
			pg.ViewUtils.SetSortingOrder(arg_30_0, 1)
			setParent(arg_30_0, arg_28_0.fireworksTF)
			setLocalPosition(arg_30_0, arg_28_0:GetFireworkPos())
			setActive(arg_30_0, true)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_0.SFX_LIST[var_28_1])

			arg_28_0.firePools[var_28_0] = arg_28_0.firePools[var_28_0] or {}

			table.insert(arg_28_0.firePools[var_28_0], arg_30_0)

			return
		end)
	end

	arg_28_0.index = arg_28_0.index + 1

	return
end

function var_0_0.GetFireworkPos(arg_31_0)
	local var_31_0 = Vector2(0, 0)

	if arg_31_0.lastPos then
		local var_31_1 = Vector2(arg_31_0.lastPos.x, arg_31_0.lastPos.y)
		local var_31_2 = math.abs(var_31_1.x - arg_31_0.lastPos.x)
		local var_31_3 = math.abs(var_31_1.y - arg_31_0.lastPos.y)

		while var_31_2 < var_0_0.FireworkRange.x / 2 and var_31_3 < var_0_0.FireworkRange.y or var_31_3 < var_0_0.FireworkRange.y / 2 and var_31_2 < var_0_0.FireworkRange.x do
			var_31_1.x = math.random(var_0_0.EffectPosLimit.limitX[1], var_0_0.EffectPosLimit.limitX[2])
			var_31_1.y = math.random(var_0_0.EffectPosLimit.limitY[1], var_0_0.EffectPosLimit.limitY[2])
			var_31_2 = math.abs(var_31_1.x - arg_31_0.lastPos.x)
			var_31_3 = math.abs(var_31_1.y - arg_31_0.lastPos.y)
		end

		var_31_0 = var_31_1
	else
		var_31_0.x = math.random(var_0_0.EffectPosLimit.limitX[1], var_0_0.EffectPosLimit.limitX[2])
		var_31_0.y = math.random(var_0_0.EffectPosLimit.limitY[1], var_0_0.EffectPosLimit.limitY[2])
	end

	arg_31_0.lastPos = var_31_0

	return var_31_0
end

function var_0_0.StopFireworksTimer(arg_32_0)
	if arg_32_0.fireworksTimer then
		arg_32_0.fireworksTimer:Stop()

		arg_32_0.fireworksTimer = nil
	end

	return
end

function var_0_0.StopPlayFireworks(arg_33_0)
	arg_33_0:StopFireworksTimer()

	arg_33_0.fireworks = nil
	arg_33_0.index = nil

	setActive(arg_33_0.fireworksTF, false)

	return
end

function var_0_0.willExit(arg_34_0)
	arg_34_0:StopPlayFireworks()
	arg_34_0:clearStudents()
	var_0_0.super.willExit(arg_34_0)

	return
end

function var_0_0.CheckTip(arg_35_0)
	return switch(arg_35_0, {
		fushundamaoxian = function()
			return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_SPRING_FESTIVAL_2024)
		end,
		huituriji = function()
			return getProxy(ColoringProxy):CheckTodayTip()
		end,
		jiujiudajiulou = function()
			return RedPacketLayer.isShowRedPoint()
		end,
		xinchunmaoxianwang = function()
			return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.FEIYUEN_LOGIN)))
		end,
		meiyiyannian = function()
			return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.TAIYUAN_ALERT_TASK)))
		end,
		feicaiyingxinchun = function()
			return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.FIREWORK_PT_2024_ID)))
		end,
		feicaiyingxinchuntw = function()
			return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.FIREWORK_PT_2024_ID)))
		end,
		aomeiyingchun = function()
			return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_COUPLET)))
		end,
		huazhongshijie = function()
			return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_HUAZHONGSHIJIE)))
		end
	}, function()
		return false
	end)
end

function var_0_0.IsShowMainTip(arg_46_0)
	local var_46_0 = {
		"fushundamaoxian",
		"huituriji",
		"jiujiudajiulou",
		"xinchunmaoxianwang",
		"meiyiyannian",
		"feicaiyingxinchun"
	}

	if PLATFORM_CODE == PLATFORM_CHT then
		var_46_0 = {
			"fushundamaoxian",
			"huituriji",
			"jiujiudajiulou",
			"aomeiyingchun",
			"huazhongshijie",
			"feicaiyingxinchuntw"
		}
	end

	return _.any(var_46_0, function(arg_47_0)
		return tobool(var_0_0.CheckTip(arg_47_0))
	end)
end

return var_0_0
