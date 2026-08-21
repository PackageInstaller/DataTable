local var_0_0 = class("NewYearFestival2022Scene", import("..TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "NewyearFestival2022UI"
end

var_0_0.edge2area = {
	default = "_middle"
}
var_0_0.Buildings = {
	[18] = "ironbloodmaid",
	[17] = "royalmaid"
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

	arg_2_0._middle = arg_2_0._tf:Find("middle")
	arg_2_0._shipTpl = arg_2_0._map:Find("ship")
	arg_2_0._upper = arg_2_0._tf:Find("upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_2 = arg_2_0._upper:GetChild(iter_2_1)
		local var_2_3 = "upper_" .. go(var_2_2).name

		arg_2_0[var_2_3] = var_2_2
	end

	arg_2_0.containers = {
		arg_2_0.map_middle
	}
	arg_2_0.usableTxt = arg_2_0.top:Find("usable_count/text"):GetComponent(typeof(Text))
	arg_2_0.materialTxt = arg_2_0.top:Find("material/text"):GetComponent(typeof(Text))
	arg_2_0.btnPlayFirework = arg_2_0.top:Find("playFirework")
	arg_2_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.NewyearFestival2022Graph"))

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("top/back"), function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/home"), function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_xinnian2022_feast.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.btnPlayFirework, function()
		local var_7_0 = getProxy(MiniGameProxy):GetMiniGameData(36):GetRuntimeData("elements")

		if not var_7_0 or #var_7_0 < 4 or var_7_0[4] ~= SummerFeastScene.GetCurrentDay() then
			return
		end

		arg_3_0:PlayFirework(var_7_0)
		setActive(arg_3_0.btnPlayFirework, false)

		return
	end)
	arg_3_0:InitStudents(ActivityConst.MINIGAME_CURLING, 3, 3)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "qiyuanwu", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 34)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "bingqiu", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 33)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "yanhua", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 36)

		return
	end)

	for iter_3_0, iter_3_1 in pairs(arg_3_0.Buildings) do
		arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, iter_3_1, function()
			arg_3_0:emit(BackHillMediatorTemplate.GO_SUBLAYER, Context.New({
				mediator = BuildingUpgradeMediator,
				viewComponent = BuildingCafeUpgradeLayer,
				data = {
					buildingID = iter_3_0
				}
			}))

			return
		end)
	end

	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:RegisterDataResponse()
	arg_3_0:UpdateView()

	return
end

function var_0_0.RegisterDataResponse(arg_12_0)
	arg_12_0.Respones = ResponsableTree.CreateShell({})

	arg_12_0.Respones:SetRawData("view", arg_12_0)

	local var_12_0 = _.values(arg_12_0.Buildings)

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		arg_12_0.Respones:AddRawListener({
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

	table.insertto({
		"bingqiu",
		"qiyuanwu",
		"yanhua"
	}, var_12_0)

	for iter_12_2, iter_12_3 in ipairs({
		"bingqiu",
		"qiyuanwu",
		"yanhua"
	}) do
		arg_12_0.Respones:AddRawListener({
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

	arg_12_0.Respones:AddRawListener({
		"view",
		"shrineCount"
	}, function(arg_15_0, arg_15_1)
		arg_15_0.usableTxt.text = arg_15_1

		return
	end)
	arg_12_0.Respones:AddRawListener({
		"view",
		"materialCount"
	}, function(arg_16_0, arg_16_1)
		arg_16_0.materialTxt.text = arg_16_1

		return
	end)

	return
end

function var_0_0.UpdateView(arg_17_0)
	local var_17_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF)

	for iter_17_0, iter_17_1 in pairs(arg_17_0.Buildings) do
		arg_17_0.Respones[iter_17_1] = var_17_0.data1KeyValueList[2][iter_17_0] or 1
		arg_17_0.Respones[iter_17_1 .. "Tip"] = arg_17_0:UpdateBuildingTip(var_17_0, iter_17_0)
	end

	;(function()
		local var_18_0 = var_17_0.data1KeyValueList[2][17] or 1
		local var_18_1 = var_17_0.data1KeyValueList[2][18] or 1
		local var_18_2 = pg.activity_event_building[17]
		local var_18_3 = var_17_0.data1KeyValueList[1][pg.activity_event_building[17].material[1][1][2]] or 0
		local var_18_4 = #var_18_2.buff

		arg_17_0.Respones.royalmaidTip = var_18_0 < #var_18_2.buff and var_18_3 >= var_18_2.material[var_18_0][1][3] and var_18_0 <= var_18_1
		arg_17_0.Respones.ironbloodmaidTip = var_18_1 < var_18_4 and var_18_3 >= var_18_2.material[var_18_1][1][3] and var_18_1 <= var_18_0

		return
	end)()

	arg_17_0.Respones.materialCount = var_17_0.data1KeyValueList[1][next(var_17_0.data1KeyValueList[1])] or 0

	local var_17_1 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_5)

	arg_17_0.Respones.shrineCount = var_17_1 and var_17_1:GetRuntimeData("count") or 0
	arg_17_0.Respones.bingqiuTip = var_0_0.IsMiniActNeedTip(ActivityConst.MINIGAME_CURLING)
	arg_17_0.Respones.yanhuaTip = var_0_0.IsMiniActNeedTip(ActivityConst.MINIGAME_FIREWORK_2022)
	arg_17_0.Respones.qiyuanwuTip = Shrine2022View.IsNeedShowTipWithoutActivityFinalReward()

	local var_17_2 = getProxy(MiniGameProxy):GetMiniGameData(36):GetRuntimeData("elements")

	setActive(arg_17_0.btnPlayFirework, var_17_2 and #var_17_2 >= 4 and var_17_2[4] == SummerFeastScene.GetCurrentDay() and not tobool(arg_17_0.loader:GetRequestPackage("Firework")))
	arg_17_0:TryPlayStory()

	return
end

function var_0_0.TryPlayStory(arg_19_0)
	local var_19_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF)
	local var_19_1

	if not var_19_0.data1KeyValueList[2][17] then
		var_19_1 = 1
	end

	local var_19_2, var_19_3

	if not var_19_0.data1KeyValueList[2][18] then
		var_19_2 = 1
		var_19_3 = pg.NewStoryMgr.GetInstance()
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

function var_0_0.willExit(arg_21_0)
	arg_21_0:clearStudents()
	arg_21_0:ClearEffectFirework()
	var_0_0.super.willExit(arg_21_0)

	return
end

function var_0_0.PlayFirework(arg_22_0, arg_22_1)
	arg_22_1 = arg_22_1 or {
		0,
		0,
		0
	}

	local var_22_0 = UnityEngine.ParticleSystem.MinMaxGradient.New

	arg_22_0.loader:GetPrefab("ui/firework", "", function(arg_23_0)
		tf(arg_23_0):Find("Fire"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[1]].color))
		tf(arg_23_0):Find("Fire/par_small"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[2]].color))
		tf(arg_23_0):Find("Fire/par_small/par_big"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[3]].color))

		setParent(arg_23_0, arg_22_0._map)

		arg_23_0.transform.localPosition = Vector2(663, 50)
		arg_23_0.transform.localScale = Vector3(0.7, 0.7, 0.7)

		pg.ViewUtils.SetSortingOrder(arg_23_0, -1)
		arg_22_0:PlaySE()

		return
	end, "Firework")

	arg_22_0.fireworkTimer = Timer.New(function()
		arg_22_0.loader:GetPrefab("ui/firework", "", function(arg_25_0)
			tf(arg_25_0):Find("Fire"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[1]].color))
			tf(arg_25_0):Find("Fire/par_small"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[2]].color))
			tf(arg_25_0):Find("Fire/par_small/par_big"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[3]].color))

			setParent(arg_25_0, arg_22_0._map)

			arg_25_0.transform.localPosition = Vector2(123, 110)
			arg_25_0.transform.localScale = Vector3(1.2, 1.2, 1.2)

			return
		end, "Firework2")

		return
	end, 2)

	arg_22_0.fireworkTimer:Start()

	arg_22_0.fireworkTimer2 = Timer.New(function()
		arg_22_0.loader:GetPrefab("ui/firework", "", function(arg_27_0)
			tf(arg_27_0):Find("Fire"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[1]].color))
			tf(arg_27_0):Find("Fire/par_small"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[2]].color))
			tf(arg_27_0):Find("Fire/par_small/par_big"):GetComponent("ParticleSystem").main.startColor = var_22_0(SummerFeastScene.TransformColor(SummerFeastScene.Elements[arg_22_1[3]].color))

			setParent(arg_27_0, arg_22_0._map)

			arg_27_0.transform.localPosition = Vector2(-465, -90)

			return
		end, "Firework3")

		return
	end, 3)

	arg_22_0.fireworkTimer2:Start()

	return
end

function var_0_0.ClearEffectFirework(arg_28_0)
	arg_28_0:StopSE()
	arg_28_0.loader:ClearRequest("Firework")
	arg_28_0.loader:ClearRequest("Firework2")
	arg_28_0.loader:ClearRequest("Firework3")

	if arg_28_0.fireworkTimer then
		arg_28_0.fireworkTimer:Stop()

		arg_28_0.fireworkTimer = nil
	end

	if arg_28_0.fireworkTimer2 then
		arg_28_0.fireworkTimer2:Stop()

		arg_28_0.fireworkTimer2 = nil
	end

	return
end

function var_0_0.PlaySE(arg_29_0)
	if arg_29_0.SETimer then
		return
	end

	arg_29_0.SECount = 10
	arg_29_0.SETimer = Timer.New(function()
		arg_29_0.SECount = arg_29_0.SECount - 1

		if arg_29_0.SECount <= 0 then
			arg_29_0.SECount = math.random(5, 20)

			pg.CriMgr.GetInstance():PlaySE_V3("battle-firework")
		end

		return
	end, 0.1, -1)

	arg_29_0.SETimer:Start()

	return
end

function var_0_0.StopSE(arg_31_0)
	if arg_31_0.SETimer then
		pg.CriMgr.GetInstance():StopSEBattle_V3()
		arg_31_0.SETimer:Stop()

		arg_31_0.SETimer = nil
	end

	return
end

return var_0_0
