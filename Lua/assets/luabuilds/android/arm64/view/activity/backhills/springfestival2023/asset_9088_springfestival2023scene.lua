local SpringFestival2023Scene = class("SpringFestival2023Scene", import("..TemplateMV.BackHillTemplate"))

SpringFestival2023Scene.Id2EffectName = {
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
SpringFestival2023Scene.FireworkRange = Vector2(300, 300)
SpringFestival2023Scene.EffectPosLimit = {
	limitX = {
		-700,
		700
	},
	limitY = {
		250,
		500
	}
}
SpringFestival2023Scene.EffectInterval = 1
SpringFestival2023Scene.DelayPop = 2.5
SpringFestival2023Scene.SFX_LIST = {
	"event:/ui/firework1",
	"event:/ui/firework2",
	"event:/ui/firework3",
	"event:/ui/firework4"
}

function SpringFestival2023Scene:getUIName()
	return "SpringFestival2023UI"
end

SpringFestival2023Scene.edge2area = {
	default = "map_middle"
}

function SpringFestival2023Scene:init()
	self.top = self._tf:Find("top")
	self._map = self._tf:Find("map")

	for iter_2_0 = 0, self._map.childCount - 1 do
		local var_2_0 = self._map:GetChild(iter_2_0)

		self["map_" .. go(var_2_0).name] = var_2_0
	end

	self._shipTpl = self._map:Find("ship")
	self._upper = self._tf:Find("upper")

	for iter_2_1 = 0, self._upper.childCount - 1 do
		local var_2_1 = self._upper:GetChild(iter_2_1)

		self["upper_" .. go(var_2_1).name] = var_2_1
	end

	self.tipTfs = _.map(_.range(self._upper.childCount), function(arg_3_0)
		local var_3_0 = self._upper:GetChild(arg_3_0 - 1)

		return {
			name = var_3_0.name,
			trans = var_3_0:Find("tip")
		}
	end)
	self.fireworksTF = self._tf:Find("play_fireworks")
	self.containers = {
		self.map_front,
		self.map_middle
	}
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.SpringFestival2023Graph"))
	self.loader = AutoLoader.New()

	return
end

function SpringFestival2023Scene:didEnter()
	if self.contextData.openFireworkLayer then
		self.contextData.openFireworkLayer = nil

		self:OpenFireworkLayer()
	end

	onButton(self, self._tf:Find("top/return_btn"), function()
		self:emit(SpringFestival2023Scene.ON_BACK)

		return
	end)
	onButton(self, self._tf:Find("top/return_main_btn"), function()
		self:emit(SpringFestival2023Scene.ON_HOME)

		return
	end)
	onButton(self, self._tf:Find("top/help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_chunjie2023.tip
		})

		return
	end)
	onButton(self, self._tf:Find("top/firework_btn"), function()
		self:OpenFireworkLayer()

		return
	end)
	onButton(self, self.fireworksTF, function()
		self:StopPlayFireworks()

		return
	end)
	self:BindItemSkinShop()
	self:BindItemBuildShip()

	local var_4_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_SPRING_FESTIVAL_2023)

	self:InitStudents(var_4_0 and var_4_0.id, 2, 3)
	self:InitFacilityCross(self._map, self._upper, "xiaoyouxi", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 48)

		return
	end)

	local var_4_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.FIREWORK_PT_ID)

	self:InitFacilityCross(self._map, self._upper, "yanhua", function()
		local var_11_0 = {}

		var_11_0.id = var_4_1 and var_4_1.id

		self:emit(SpringFestival2023Mediator.GO_SCENE, SCENE.ACTIVITY, var_11_0)

		return
	end)

	local var_4_2 = getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_COUPLET)

	self:InitFacilityCross(self._map, self._upper, "duilian", function()
		local var_12_0 = {}

		var_12_0.id = var_4_2 and var_4_2.id

		self:emit(SpringFestival2023Mediator.GO_SCENE, SCENE.ACTIVITY, var_12_0)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "jiulou", function()
		self:emit(NewYearFestivalMediator.GO_SUBLAYER, Context.New({
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
		self:emit(SpringFestival2023Mediator.GO_SCENE, SCENE.COLORING)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "huazhongshijie", function()
		local var_16_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORLDINPICTURE)
		local var_16_1

		if not var_16_0 or var_16_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			do return end

			var_16_1 = {}
		end

		var_16_1.id = var_16_0:getConfig("config_client").linkActID

		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, var_16_1)

		return
	end)
	self:UpdateView()
	self:AutoFitScreen()

	return
end

function SpringFestival2023Scene:OpenFireworkLayer()
	self:emit(SpringFestival2023Mediator.GO_SUBLAYER, Context.New({
		mediator = FireworkPanelMediator,
		viewComponent = FireworkPanelLayer
	}))

	return
end

function SpringFestival2023Scene:PlayFireworks(arg_18_1)
	if not arg_18_1 or #arg_18_1 == 0 then
		return
	end

	setActive(self._upper, false)
	setActive(self.top, false)
	eachChild(self.fireworksTF, function(arg_19_0)
		setActive(arg_19_0, false)

		return
	end)
	setActive(self.fireworksTF, true)
	self:StopFireworksTimer()

	self.fireworks = arg_18_1
	self.index = 1

	self:PlayerOneFirework()

	if #arg_18_1 > 1 then
		self.fireworksTimer = Timer.New(function()
			self:PlayerOneFirework()

			return
		end, SpringFestival2023Scene.EffectInterval, #arg_18_1 - 1)

		self.fireworksTimer:Start()
	end

	return
end

function SpringFestival2023Scene:PlayerOneFirework()
	if self.index == #self.fireworks then
		self:managedTween(LeanTween.delayedCall, function()
			self:StopPlayFireworks()

			return
		end, SpringFestival2023Scene.DelayPop, nil)
	end

	local var_21_0 = self.fireworks[self.index]
	local var_21_1 = self.fireworksTF:Find(tostring(self.fireworks[self.index]))
	local var_21_2 = math.random(#SpringFestival2023Scene.SFX_LIST)

	if var_21_1 then
		setLocalPosition(var_21_1, self:GetFireworkPos())
		setActive(var_21_1, true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SpringFestival2023Scene.SFX_LIST[var_21_2])
	else
		self.loader:GetPrefab("ui/" .. SpringFestival2023Scene.Id2EffectName[var_21_0], "", function(arg_23_0)
			pg.ViewUtils.SetSortingOrder(arg_23_0, 1)

			arg_23_0.name = var_21_0

			setParent(arg_23_0, self.fireworksTF)
			setLocalPosition(arg_23_0, self:GetFireworkPos())
			setActive(arg_23_0, true)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SpringFestival2023Scene.SFX_LIST[var_21_2])

			return
		end)
	end

	self.index = self.index + 1

	return
end

function SpringFestival2023Scene:GetFireworkPos()
	local var_24_0 = Vector2(0, 0)

	if self.lastPos then
		local var_24_1 = Vector2(self.lastPos.x, self.lastPos.y)
		local var_24_2 = math.abs(var_24_1.x - self.lastPos.x)
		local var_24_3 = math.abs(var_24_1.y - self.lastPos.y)

		while var_24_2 < SpringFestival2023Scene.FireworkRange.x / 2 and var_24_3 < SpringFestival2023Scene.FireworkRange.y or var_24_3 < SpringFestival2023Scene.FireworkRange.y / 2 and var_24_2 < SpringFestival2023Scene.FireworkRange.x do
			var_24_1.x = math.random(SpringFestival2023Scene.EffectPosLimit.limitX[1], SpringFestival2023Scene.EffectPosLimit.limitX[2])
			var_24_1.y = math.random(SpringFestival2023Scene.EffectPosLimit.limitY[1], SpringFestival2023Scene.EffectPosLimit.limitY[2])
			var_24_2 = math.abs(var_24_1.x - self.lastPos.x)
			var_24_3 = math.abs(var_24_1.y - self.lastPos.y)
		end

		var_24_0 = var_24_1
	else
		var_24_0.x = math.random(SpringFestival2023Scene.EffectPosLimit.limitX[1], SpringFestival2023Scene.EffectPosLimit.limitX[2])
		var_24_0.y = math.random(SpringFestival2023Scene.EffectPosLimit.limitY[1], SpringFestival2023Scene.EffectPosLimit.limitY[2])
	end

	self.lastPos = var_24_0

	return var_24_0
end

function SpringFestival2023Scene:StopFireworksTimer()
	if self.fireworksTimer then
		self.fireworksTimer:Stop()

		self.fireworksTimer = nil
	end

	return
end

function SpringFestival2023Scene:StopPlayFireworks()
	self:StopFireworksTimer()

	self.fireworks = nil
	self.index = nil

	setActive(self._upper, true)
	setActive(self.top, true)
	setActive(self.fireworksTF, false)
	self:OpenFireworkLayer()

	return
end

function SpringFestival2023Scene:UpdateView()
	_.each(self.tipTfs, function(arg_28_0)
		if arg_28_0.trans then
			setActive(arg_28_0.trans, tobool(SpringFestival2023Scene.CheckTip(arg_28_0.name)))
		end

		return
	end)

	return
end

function SpringFestival2023Scene:willExit()
	self:clearStudents()
	self:StopFireworksTimer()
	self:cleanManagedTween()
	self.loader:Clear()

	return
end

function SpringFestival2023Scene:CheckTip()
	local var_30_0 = getProxy(ActivityProxy)

	return switch(self, {
		xiaoyouxi = function()
			return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_SPRING_FESTIVAL_2023)
		end,
		huituriji = function()
			return getProxy(ColoringProxy):CheckTodayTip()
		end,
		huazhongshijie = function()
			return Activity.IsActivityReady((var_30_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_WORLDINPICTURE)))
		end,
		jiulou = function()
			return RedPacketLayer.isShowRedPoint()
		end,
		yanhua = function()
			return Activity.IsActivityReady((var_30_0:getActivityById(ActivityConst.FIREWORK_PT_ID)))
		end,
		duilian = function()
			return Activity.IsActivityReady((var_30_0:getActivityById(ActivityConst.ACTIVITY_COUPLET)))
		end
	}, function()
		return false
	end)
end

function SpringFestival2023Scene:IsShowMainTip()
	return _.any({
		"xiaoyouxi",
		"huituriji",
		"huazhongshijie",
		"jiulou",
		"yanhua",
		"duilian"
	}, function(arg_39_0)
		return tobool(SpringFestival2023Scene.CheckTip(arg_39_0))
	end)
end

return SpringFestival2023Scene
