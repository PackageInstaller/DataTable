local SpringFestival2024Scene = class("SpringFestival2024Scene", import("view.activity.BackHills.TemplateMV.BackHillTemplate"))

function SpringFestival2024Scene:getUIName()
	if PLATFORM_CODE == PLATFORM_CHT then
		return "SpringFestival2024TWUI"
	else
		return "SpringFestival2024UI"
	end

	return
end

SpringFestival2024Scene.edge2area = {
	default = "_SDPlace"
}
SpringFestival2024Scene.EffectPoolCnt = 3
SpringFestival2024Scene.Id2EffectName = {
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
SpringFestival2024Scene.FireworkRange = Vector2(300, 300)
SpringFestival2024Scene.EffectPosLimit = {
	limitX = {
		-700,
		700
	},
	limitY = {
		250,
		500
	}
}
SpringFestival2024Scene.EffectInterval = 1
SpringFestival2024Scene.DelayPop = 2.5
SpringFestival2024Scene.SFX_LIST = {
	"event:/ui/firework1",
	"event:/ui/firework2",
	"event:/ui/firework3",
	"event:/ui/firework4"
}

function SpringFestival2024Scene:init()
	SpringFestival2024Scene.super.init(self)

	self.top = self._tf:Find("top")
	self._map = self._tf:Find("map")

	for iter_2_0 = 0, self._map.childCount - 1 do
		local var_2_0 = self._map:GetChild(iter_2_0)

		self["map_" .. go(var_2_0).name] = var_2_0
	end

	self._upper = self._tf:Find("upper")

	for iter_2_1 = 0, self._upper.childCount - 1 do
		local var_2_1 = self._upper:GetChild(iter_2_1)

		self["upper_" .. go(var_2_1).name] = var_2_1
	end

	self.tipTfs = _.map(_.range(self._upper.childCount), function(arg_3_0)
		local var_3_0 = self._upper:GetChild(arg_3_0 - 1)

		return {
			name = var_3_0.name,
			trans = var_3_0:Find("Tip")
		}
	end)
	self._SDPlace = self._tf:Find("SDPlace")
	self.containers = {
		self._SDPlace
	}
	self._shipTpl = self._map:Find("ship")
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.SpringFestival2024Graph"))
	self.fireworksTF = self._tf:Find("play_fireworks")

	return
end

function SpringFestival2024Scene:didEnter()
	onButton(self, self._tf:Find("top/Back"), function()
		self:emit(SpringFestival2024Scene.ON_BACK)

		return
	end)
	onButton(self, self._tf:Find("top/Home"), function()
		self:emit(SpringFestival2024Scene.ON_HOME)

		return
	end)
	onButton(self, self._tf:Find("top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_chunjie2024.tip
		})

		return
	end)
	onButton(self, self._tf:Find("top/firework_btn"), function()
		self:OpenFireworkLayer()

		return
	end)
	self:BindItemSkinShop()
	self:BindItemBuildShip()

	local var_4_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_SPRING_FESTIVAL_2024)

	self:InitStudents(var_4_0 and var_4_0.id, 4, 4)

	if PLATFORM_CODE == PLATFORM_CHT then
		self:InitFacilityCross(self._map, self._upper, "feicaiyingxinchuntw", function()
			self:emit(SpringFestival2024Mediator.GO_SCENE, SCENE.ACTIVITY, {
				id = ActivityConst.FIREWORK_PT_2024_ID
			})

			return
		end)
		self:InitFacilityCross(self._map, self._upper, "aomeiyingchun", function()
			self:emit(SpringFestival2024Mediator.GO_SCENE, SCENE.ACTIVITY, {
				id = ActivityConst.ACTIVITY_COUPLET
			})

			return
		end)
		self:InitFacilityCross(self._map, self._upper, "huazhongshijie", function()
			local var_11_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_HUAZHONGSHIJIE)
			local var_11_1

			if not var_11_0 or var_11_0:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				do return end

				var_11_1 = {}
			end

			var_11_1.id = var_11_0:getConfig("config_client").linkActID

			self:emit(SpringFestival2024Mediator.GO_SCENE, SCENE.ACTIVITY, var_11_1)

			return
		end)
	else
		self:InitFacilityCross(self._map, self._upper, "feicaiyingxinchun", function()
			self:emit(SpringFestival2024Mediator.GO_SCENE, SCENE.ACTIVITY, {
				id = ActivityConst.FIREWORK_PT_2024_ID
			})

			return
		end)
		self:InitFacilityCross(self._map, self._upper, "meiyiyannian", function()
			self:emit(SpringFestival2024Mediator.GO_SCENE, SCENE.ACTIVITY, {
				id = ActivityConst.TAIYUAN_ALERT_TASK
			})

			return
		end)
		self:InitFacilityCross(self._map, self._upper, "xinchunmaoxianwang", function()
			self:emit(SpringFestival2024Mediator.GO_SCENE, SCENE.ACTIVITY, {
				id = ActivityConst.FEIYUEN_LOGIN
			})

			return
		end)
	end

	self:InitFacilityCross(self._map, self._upper, "fushundamaoxian", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 37)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "jiujiudajiulou", function()
		self:emit(SpringFestival2024Mediator.GO_SUBLAYER, Context.New({
			mediator = RedPacketMediator,
			viewComponent = RedPacketLayer,
			onRemoved = function()
				self:PlayBGM()

				return
			end
		}))

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "huituriji", function()
		self:emit(SpringFestival2024Mediator.GO_SCENE, SCENE.COLORING)

		return
	end)
	self:UpdateView()

	self.firePools = {}

	if self.contextData.openFireworkLayer then
		self.contextData.openFireworkLayer = nil

		self:OpenFireworkLayer()
	else
		self:PlayFireworks()
	end

	if self.contextData.isOpenRedPacket then
		self.contextData.isOpenRedPacket = nil

		self:emit(SpringFestival2024Mediator.GO_SUBLAYER, Context.New({
			mediator = RedPacketMediator,
			viewComponent = RedPacketLayer,
			onRemoved = function()
				self:PlayBGM()

				return
			end
		}))
	end

	return
end

function SpringFestival2024Scene:UpdateActivity(arg_20_1)
	self:UpdateView()

	return
end

function SpringFestival2024Scene:UpdateView()
	_.each(self.tipTfs, function(arg_22_0)
		if arg_22_0.trans then
			setActive(arg_22_0.trans, tobool(SpringFestival2024Scene.CheckTip(arg_22_0.name)))
		end

		return
	end)

	return
end

function SpringFestival2024Scene:OpenFireworkLayer()
	self:emit(SpringFestival2024Mediator.GO_SUBLAYER, Context.New({
		mediator = FireworkPanel2024Mediator,
		viewComponent = FireworkPanel2024Layer,
		data = {
			onExit = function()
				self:PlayFireworks()

				return
			end
		}
	}))

	return
end

function SpringFestival2024Scene:PlayFireworks()
	local var_25_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FIREWORK)

	assert(var_25_0 and not var_25_0:isEnd(), "烟花活动(type92)已结束")

	local var_25_1 = getProxy(PlayerProxy):getData().id

	self.fireworks = {}

	for iter_25_0 = 1, #pg.activity_template[var_25_0.id].config_data[3] do
		local var_25_2 = PlayerPrefs.GetInt("fireworks_" .. var_25_0.id .. "_" .. var_25_1 .. "_pos_" .. iter_25_0)

		if var_25_2 ~= 0 then
			table.insert(self.fireworks, var_25_2)
		end
	end

	if #self.fireworks == 0 then
		return
	end

	eachChild(self.fireworksTF, function(arg_26_0)
		setActive(arg_26_0, false)

		return
	end)
	setActive(self.fireworksTF, true)
	self:StopFireworksTimer()

	self.index = 1
	self.fireworksTimer = Timer.New(function()
		self:PlayerOneFirework()

		return
	end, SpringFestival2024Scene.EffectInterval, #self.fireworks)

	self.fireworksTimer:Start()

	return
end

function SpringFestival2024Scene:PlayerOneFirework()
	if self.index == #self.fireworks then
		self:managedTween(LeanTween.delayedCall, function()
			self:StopPlayFireworks()
			self:PlayFireworks()

			return
		end, SpringFestival2024Scene.DelayPop, nil)
	end

	local var_28_0 = self.fireworks[self.index]
	local var_28_1 = math.random(#SpringFestival2024Scene.SFX_LIST)

	if self.firePools[self.fireworks[self.index]] and #self.firePools[var_28_0] >= SpringFestival2024Scene.EffectPoolCnt then
		setLocalPosition(self.firePools[var_28_0][SpringFestival2024Scene.EffectPoolCnt], self:GetFireworkPos())
		setActive(self.firePools[var_28_0][SpringFestival2024Scene.EffectPoolCnt], false)
		setActive(self.firePools[var_28_0][SpringFestival2024Scene.EffectPoolCnt], true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SpringFestival2024Scene.SFX_LIST[var_28_1])
		table.removebyvalue(self.firePools[var_28_0], self.firePools[var_28_0][SpringFestival2024Scene.EffectPoolCnt])
		table.insert(self.firePools[var_28_0], self.firePools[var_28_0][SpringFestival2024Scene.EffectPoolCnt])
	else
		self.loader:GetPrefab("ui/" .. SpringFestival2024Scene.Id2EffectName[var_28_0], "", function(arg_30_0)
			pg.ViewUtils.SetSortingOrder(arg_30_0, 1)
			setParent(arg_30_0, self.fireworksTF)
			setLocalPosition(arg_30_0, self:GetFireworkPos())
			setActive(arg_30_0, true)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SpringFestival2024Scene.SFX_LIST[var_28_1])

			self.firePools[var_28_0] = self.firePools[var_28_0] or {}

			table.insert(self.firePools[var_28_0], arg_30_0)

			return
		end)
	end

	self.index = self.index + 1

	return
end

function SpringFestival2024Scene:GetFireworkPos()
	local var_31_0 = Vector2(0, 0)

	if self.lastPos then
		local var_31_1 = Vector2(self.lastPos.x, self.lastPos.y)
		local var_31_2 = math.abs(var_31_1.x - self.lastPos.x)
		local var_31_3 = math.abs(var_31_1.y - self.lastPos.y)

		while var_31_2 < SpringFestival2024Scene.FireworkRange.x / 2 and var_31_3 < SpringFestival2024Scene.FireworkRange.y or var_31_3 < SpringFestival2024Scene.FireworkRange.y / 2 and var_31_2 < SpringFestival2024Scene.FireworkRange.x do
			var_31_1.x = math.random(SpringFestival2024Scene.EffectPosLimit.limitX[1], SpringFestival2024Scene.EffectPosLimit.limitX[2])
			var_31_1.y = math.random(SpringFestival2024Scene.EffectPosLimit.limitY[1], SpringFestival2024Scene.EffectPosLimit.limitY[2])
			var_31_2 = math.abs(var_31_1.x - self.lastPos.x)
			var_31_3 = math.abs(var_31_1.y - self.lastPos.y)
		end

		var_31_0 = var_31_1
	else
		var_31_0.x = math.random(SpringFestival2024Scene.EffectPosLimit.limitX[1], SpringFestival2024Scene.EffectPosLimit.limitX[2])
		var_31_0.y = math.random(SpringFestival2024Scene.EffectPosLimit.limitY[1], SpringFestival2024Scene.EffectPosLimit.limitY[2])
	end

	self.lastPos = var_31_0

	return var_31_0
end

function SpringFestival2024Scene:StopFireworksTimer()
	if self.fireworksTimer then
		self.fireworksTimer:Stop()

		self.fireworksTimer = nil
	end

	return
end

function SpringFestival2024Scene:StopPlayFireworks()
	self:StopFireworksTimer()

	self.fireworks = nil
	self.index = nil

	setActive(self.fireworksTF, false)

	return
end

function SpringFestival2024Scene:willExit()
	self:StopPlayFireworks()
	self:clearStudents()
	SpringFestival2024Scene.super.willExit(self)

	return
end

function SpringFestival2024Scene:CheckTip()
	return switch(self, {
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

function SpringFestival2024Scene:IsShowMainTip()
	return _.any((PLATFORM_CODE == PLATFORM_CHT or nil) and {
		"fushundamaoxian",
		"huituriji",
		"jiujiudajiulou",
		"aomeiyingchun",
		"huazhongshijie",
		"feicaiyingxinchuntw"
	}, function(arg_47_0)
		return tobool(SpringFestival2024Scene.CheckTip(arg_47_0))
	end)
end

return SpringFestival2024Scene
