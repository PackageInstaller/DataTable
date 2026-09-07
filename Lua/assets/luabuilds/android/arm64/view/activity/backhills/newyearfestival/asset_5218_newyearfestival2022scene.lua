local NewYearFestival2022Scene = class("NewYearFestival2022Scene", import("..TemplateMV.BackHillTemplate"))

function NewYearFestival2022Scene:getUIName()
	return "NewyearFestival2022UI"
end

NewYearFestival2022Scene.edge2area = {
	default = "_middle"
}
NewYearFestival2022Scene.Buildings = {
	[18] = "ironbloodmaid",
	[17] = "royalmaid"
}

function NewYearFestival2022Scene:init()
	NewYearFestival2022Scene.super.init(self)

	self.top = self._tf:Find("top")
	self._map = self._tf:Find("map")

	for iter_2_0 = 0, self._map.childCount - 1 do
		local var_2_0 = self._map:GetChild(iter_2_0)

		self["map_" .. go(var_2_0).name] = var_2_0
	end

	self._middle = self._tf:Find("middle")
	self._shipTpl = self._map:Find("ship")
	self._upper = self._tf:Find("upper")

	for iter_2_1 = 0, self._upper.childCount - 1 do
		local var_2_1 = self._upper:GetChild(iter_2_1)

		self["upper_" .. go(var_2_1).name] = var_2_1
	end

	self.containers = {
		self.map_middle
	}
	self.usableTxt = self.top:Find("usable_count/text"):GetComponent(typeof(Text))
	self.materialTxt = self.top:Find("material/text"):GetComponent(typeof(Text))
	self.btnPlayFirework = self.top:Find("playFirework")
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.NewyearFestival2022Graph"))

	return
end

function NewYearFestival2022Scene:didEnter()
	onButton(self, self._tf:Find("top/back"), function()
		self:emit(NewYearFestival2022Scene.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("top/home"), function()
		self:emit(NewYearFestival2022Scene.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_xinnian2022_feast.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.btnPlayFirework, function()
		local var_7_0 = getProxy(MiniGameProxy):GetMiniGameData(36):GetRuntimeData("elements")

		if not var_7_0 or #var_7_0 < 4 or var_7_0[4] ~= SummerFeastScene.GetCurrentDay() then
			return
		end

		self:PlayFirework(var_7_0)
		setActive(self.btnPlayFirework, false)

		return
	end)
	self:InitStudents(ActivityConst.MINIGAME_CURLING, 3, 3)
	self:InitFacilityCross(self._map, self._upper, "qiyuanwu", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 34)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "bingqiu", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 33)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "yanhua", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 36)

		return
	end)

	for iter_3_0, iter_3_1 in pairs(self.Buildings) do
		self:InitFacilityCross(self._map, self._upper, iter_3_1, function()
			self:emit(BackHillMediatorTemplate.GO_SUBLAYER, Context.New({
				mediator = BuildingUpgradeMediator,
				viewComponent = BuildingCafeUpgradeLayer,
				data = {
					buildingID = iter_3_0
				}
			}))

			return
		end)
	end

	self:BindItemSkinShop()
	self:BindItemBuildShip()
	self:RegisterDataResponse()
	self:UpdateView()

	return
end

function NewYearFestival2022Scene:RegisterDataResponse()
	self.Respones = ResponsableTree.CreateShell({})

	self.Respones:SetRawData("view", self)

	local var_12_0 = _.values(self.Buildings)

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		self.Respones:AddRawListener({
			"view",
			iter_12_1
		}, function(arg_13_0, arg_13_1)
			if not arg_13_1 then
				return
			end

			arg_13_0.loader:GetSpriteQuiet("ui/NewyearFestival2022UI_atlas", iter_12_1 .. arg_13_1, arg_13_0["map_" .. iter_12_1], true)

			if not arg_13_0["upper_" .. iter_12_1] or IsNil(arg_13_0["upper_" .. iter_12_1]:Find("level")) then
				return
			end

			setText(arg_13_0["upper_" .. iter_12_1]:Find("level"), arg_13_1)

			return
		end)
	end

	local var_12_1 = {
		"bingqiu",
		"qiyuanwu",
		"yanhua"
	}

	table.insertto(var_12_1, var_12_0)

	for iter_12_2, iter_12_3 in ipairs(var_12_1) do
		self.Respones:AddRawListener({
			"view",
			iter_12_3 .. "Tip"
		}, function(arg_14_0, arg_14_1)
			if not arg_14_0["upper_" .. iter_12_3] or IsNil(arg_14_0["upper_" .. iter_12_3]:Find("tip")) then
				return
			end

			setActive(arg_14_0["upper_" .. iter_12_3]:Find("tip"), arg_14_1)

			return
		end)
	end

	self.Respones:AddRawListener({
		"view",
		"shrineCount"
	}, function(arg_15_0, arg_15_1)
		arg_15_0.usableTxt.text = arg_15_1

		return
	end)
	self.Respones:AddRawListener({
		"view",
		"materialCount"
	}, function(arg_16_0, arg_16_1)
		arg_16_0.materialTxt.text = arg_16_1

		return
	end)

	return
end

function NewYearFestival2022Scene:UpdateView()
	local var_17_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF)

	for iter_17_0, iter_17_1 in pairs(self.Buildings) do
		self.Respones[iter_17_1] = var_17_0.data1KeyValueList[2][iter_17_0] or 1
		self.Respones[iter_17_1 .. "Tip"] = self:UpdateBuildingTip(var_17_0, iter_17_0)
	end

	;(function()
		local var_18_0 = var_17_0.data1KeyValueList[2][17] or 1
		local var_18_1 = var_17_0.data1KeyValueList[2][18] or 1
		local var_18_2 = pg.activity_event_building[17]
		local var_18_3 = var_17_0.data1KeyValueList[1][pg.activity_event_building[17].material[1][1][2]] or 0

		self.Respones.royalmaidTip = var_18_0 < #var_18_2.buff and var_18_3 >= var_18_2.material[var_18_0][1][3] and var_18_0 <= var_18_1
		self.Respones.ironbloodmaidTip = var_18_1 < #var_18_2.buff and var_18_3 >= var_18_2.material[var_18_1][1][3] and var_18_1 <= var_18_0

		return
	end)()

	self.Respones.materialCount = var_17_0.data1KeyValueList[1][next(var_17_0.data1KeyValueList[1])] or 0

	local var_17_1 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_5)

	self.Respones.shrineCount = var_17_1 and var_17_1:GetRuntimeData("count") or 0
	self.Respones.bingqiuTip = NewYearFestival2022Scene.IsMiniActNeedTip(ActivityConst.MINIGAME_CURLING)
	self.Respones.yanhuaTip = NewYearFestival2022Scene.IsMiniActNeedTip(ActivityConst.MINIGAME_FIREWORK_2022)
	self.Respones.qiyuanwuTip = Shrine2022View.IsNeedShowTipWithoutActivityFinalReward()

	local var_17_2 = getProxy(MiniGameProxy):GetMiniGameData(36):GetRuntimeData("elements")

	setActive(self.btnPlayFirework, var_17_2 and #var_17_2 >= 4 and var_17_2[4] == SummerFeastScene.GetCurrentDay() and not tobool(self.loader:GetRequestPackage("Firework")))
	self:TryPlayStory()

	return
end

function NewYearFestival2022Scene:TryPlayStory()
	local var_19_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF)
	local var_19_1 = var_19_0.data1KeyValueList[2][17] or 1
	local var_19_2 = var_19_0.data1KeyValueList[2][18]

	if not var_19_0.data1KeyValueList[2][18] then
		var_19_2 = 1

		local var_19_3 = pg.NewStoryMgr.GetInstance()
	end

	table.Foreach(var_19_0:getConfig("config_client").story, function(arg_20_0, arg_20_1)
		local var_20_0 = false
		local var_20_1 = math.floor((arg_20_0 - 1) / 3) + 2

		if arg_20_0 % 3 == 1 then
			var_20_1 = var_20_1 - 1
			var_20_0 = var_20_1 <= var_19_1 and var_20_1 <= var_19_2
		elseif arg_20_0 % 3 == 2 then
			var_20_0 = var_20_1 <= var_19_2
		elseif arg_20_0 % 3 == 0 then
			var_20_0 = var_20_1 <= var_19_1
		end

		if var_20_0 then
			var_19_3:Play(arg_20_1[1])
		end

		return
	end)

	return
end

function NewYearFestival2022Scene:willExit()
	self:clearStudents()
	self:ClearEffectFirework()
	NewYearFestival2022Scene.super.willExit(self)

	return
end

function NewYearFestival2022Scene:PlayFirework(arg_22_1)
	arg_22_1 = arg_22_1 or {
		0,
		0,
		0
	}

	local var_22_0 = UnityEngine.ParticleSystem.MinMaxGradient.New

	self.loader:GetPrefab("ui/firework", "", function(arg_23_0)
		tf(arg_23_0):Find("Fire"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[1]].color))
		tf(arg_23_0):Find("Fire/par_small"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[2]].color))
		tf(arg_23_0):Find("Fire/par_small/par_big"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[3]].color))

		setParent(arg_23_0, self._map)

		arg_23_0.transform.localPosition = Vector2(663, 50)
		arg_23_0.transform.localScale = Vector3(0.7, 0.7, 0.7)

		pg.ViewUtils.SetSortingOrder(arg_23_0, -1)
		self:PlaySE()

		return
	end, "Firework")

	self.fireworkTimer = Timer.New(function()
		self.loader:GetPrefab("ui/firework", "", function(arg_25_0)
			tf(arg_25_0):Find("Fire"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[1]].color))
			tf(arg_25_0):Find("Fire/par_small"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[2]].color))
			tf(arg_25_0):Find("Fire/par_small/par_big"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[3]].color))

			setParent(arg_25_0, self._map)

			arg_25_0.transform.localPosition = Vector2(123, 110)
			arg_25_0.transform.localScale = Vector3(1.2, 1.2, 1.2)

			return
		end, "Firework2")

		return
	end, 2)

	self.fireworkTimer:Start()

	self.fireworkTimer2 = Timer.New(function()
		self.loader:GetPrefab("ui/firework", "", function(arg_27_0)
			tf(arg_27_0):Find("Fire"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[1]].color))
			tf(arg_27_0):Find("Fire/par_small"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[2]].color))
			tf(arg_27_0):Find("Fire/par_small/par_big"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[3]].color))

			setParent(arg_27_0, self._map)

			arg_27_0.transform.localPosition = Vector2(-465, -90)

			return
		end, "Firework3")

		return
	end, 3)

	self.fireworkTimer2:Start()

	return
end

function NewYearFestival2022Scene:ClearEffectFirework()
	self:StopSE()
	self.loader:ClearRequest("Firework")
	self.loader:ClearRequest("Firework2")
	self.loader:ClearRequest("Firework3")

	if self.fireworkTimer then
		self.fireworkTimer:Stop()

		self.fireworkTimer = nil
	end

	if self.fireworkTimer2 then
		self.fireworkTimer2:Stop()

		self.fireworkTimer2 = nil
	end

	return
end

function NewYearFestival2022Scene:PlaySE()
	if self.SETimer then
		return
	end

	self.SECount = 10
	self.SETimer = Timer.New(function()
		self.SECount = self.SECount - 1

		if self.SECount <= 0 then
			self.SECount = math.random(5, 20)

			pg.CriMgr.GetInstance():PlaySE_V3("battle-firework")
		end

		return
	end, 0.1, -1)

	self.SETimer:Start()

	return
end

function NewYearFestival2022Scene:StopSE()
	if self.SETimer then
		pg.CriMgr.GetInstance():StopSEBattle_V3()
		self.SETimer:Stop()

		self.SETimer = nil
	end

	return
end

return NewYearFestival2022Scene
