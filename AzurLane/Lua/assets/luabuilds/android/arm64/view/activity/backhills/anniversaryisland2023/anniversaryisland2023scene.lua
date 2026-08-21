local var_0_0 = class("AnniversaryIsland2023Scene", import("view.activity.BackHills.TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "AnniversaryIsland2023UI"
end

var_0_0.edge2area = {
	default = "_SDPlace"
}
var_0_0.Buildings = {
	[24] = "craft",
	[25] = "adventure",
	[26] = "dining",
	[23] = "living"
}

function var_0_0.Ctor(arg_2_0)
	var_0_0.super.Ctor(arg_2_0)

	arg_2_0.loader = AutoLoader.New()

	return
end

function var_0_0.preload(arg_3_0, arg_3_1)
	arg_3_0.loader:LoadBundle("ui/" .. arg_3_0:getUIName() .. "_level" .. arg_3_0:CalculateSceneLevel(), arg_3_1)

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0.top = arg_4_0._tf:Find("top")
	arg_4_0._bg = arg_4_0._tf:Find("BG")
	arg_4_0._map = arg_4_0._tf:Find("map")

	for iter_4_0 = 0, arg_4_0._map.childCount - 1 do
		local var_4_0 = arg_4_0._map:GetChild(iter_4_0)
		local var_4_1 = "map_" .. go(var_4_0).name

		arg_4_0[var_4_1] = var_4_0
	end

	arg_4_0._upper = arg_4_0._tf:Find("upper")

	for iter_4_1 = 0, arg_4_0._upper.childCount - 1 do
		local var_4_2 = arg_4_0._upper:GetChild(iter_4_1)
		local var_4_3 = "upper_" .. go(var_4_2).name

		arg_4_0[var_4_3] = var_4_2
	end

	arg_4_0._SDPlace = arg_4_0._tf:Find("SDPlace")
	arg_4_0.containers = {
		arg_4_0._SDPlace
	}
	arg_4_0._shipTpl = arg_4_0._map:Find("ship")
	arg_4_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.AnniversaryIsland2023Graph"))

	return
end

function var_0_0.didEnter(arg_5_0)
	onButton(arg_5_0, arg_5_0._tf:Find("top/Back"), function()
		arg_5_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_5_0, arg_5_0._tf:Find("top/Home"), function()
		arg_5_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0._tf:Find("top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.haidaojudian_help.tip
		})

		return
	end, SFX_PANEL)

	local var_5_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)

	arg_5_0:InitStudents(var_5_0 and var_5_0.id, 3, 4)

	for iter_5_0, iter_5_1 in pairs(arg_5_0.Buildings) do
		arg_5_0:InitFacilityCross(arg_5_0._map, arg_5_0._upper, iter_5_1, function()
			arg_5_0:emit(BackHillMediatorTemplate.GO_SUBLAYER, Context.New({
				mediator = AnniversaryIslandBuildingUpgrade2023WindowMediator,
				viewComponent = AnniversaryIslandBuildingUpgrade2023Window,
				data = {
					buildingID = iter_5_0
				}
			}))

			return
		end)
		eachChild(arg_5_0._map:Find(iter_5_1), function(arg_10_0)
			GetComponent(arg_10_0, typeof(Image)).alphaHitTestMinimumThreshold = 0.5

			setActive(arg_10_0, false)

			return
		end)
	end

	eachChild(arg_5_0._map:Find("xianshijianzao"), function(arg_11_0)
		GetComponent(arg_11_0, typeof(Image)).alphaHitTestMinimumThreshold = 0.5

		return
	end)
	eachChild(arg_5_0._map:Find("huanzhuangshangdian"), function(arg_12_0)
		GetComponent(arg_12_0, typeof(Image)).alphaHitTestMinimumThreshold = 0.5

		return
	end)
	eachChild(arg_5_0._map:Find("taskboard"), function(arg_13_0)
		GetComponent(arg_13_0, typeof(Image)).alphaHitTestMinimumThreshold = 0.5

		return
	end)

	GetComponent(arg_5_0._map:Find("bigmap"), typeof(Image)).alphaHitTestMinimumThreshold = 0.5

	arg_5_0:InitFacilityCross(arg_5_0._map, arg_5_0._upper, "craft", function()
		arg_5_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ANNIVERSARY_ISLAND_WORKBENCH)

		return
	end)
	arg_5_0:InitFacilityCross(arg_5_0._map, arg_5_0._upper, "taskboard", function()
		local var_15_0 = Context.New()

		SCENE.SetSceneInfo(var_15_0, SCENE.ISLAND_TASK)
		arg_5_0:emit(BackHillMediatorTemplate.GO_SUBLAYER, var_15_0)

		return
	end)
	arg_5_0:InitFacilityCross(arg_5_0._map, arg_5_0._upper, "bigmap", function()
		arg_5_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ANNIVERSARY_ISLAND_SEA, {
			checkMain = true
		})

		return
	end)
	arg_5_0:InitFacilityCross(arg_5_0._map, arg_5_0._upper, "giftmake", function()
		arg_5_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SCULPTURE)

		return
	end)
	arg_5_0:BindItemSkinShop()
	arg_5_0:BindItemBuildShip()
	arg_5_0:RegisterDataResponse()
	arg_5_0:UpdateView()

	return
end

function var_0_0.UpdateActivity(arg_18_0, arg_18_1)
	arg_18_0:UpdateView()

	return
end

function var_0_0.RegisterDataResponse(arg_19_0)
	arg_19_0.Respones = ResponsableTree.CreateShell({})

	arg_19_0.Respones:SetRawData("view", arg_19_0)

	local var_19_0 = _.values(arg_19_0.Buildings)

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		arg_19_0.Respones:AddRawListener({
			"view",
			iter_19_1
		}, function(arg_20_0, arg_20_1)
			if not arg_20_1 then
				return
			end

			setActive(arg_20_0["map_" .. iter_19_1]:Find(tostring(arg_20_1)), true)

			if arg_20_1 - 1 > 0 then
				setActive(arg_20_0["map_" .. iter_19_1]:Find(tostring(arg_20_1 - 1)), false)
			end

			local var_20_0 = arg_20_0["map_" .. iter_19_1]:Find(tostring(arg_20_1))

			arg_20_0.loader:GetSpriteQuiet("ui/" .. arg_19_0:getUIName() .. "_atlas", iter_19_1 .. "_" .. arg_20_1, var_20_0, true)

			GetComponent(arg_20_0["map_" .. iter_19_1], typeof(Button)).targetGraphic = GetComponent(var_20_0, typeof(Image))

			if not arg_20_0["upper_" .. iter_19_1] or IsNil(arg_20_0["upper_" .. iter_19_1]:Find("Level")) then
				return
			end

			arg_20_0.loader:GetSpriteQuiet("ui/" .. arg_19_0:getUIName() .. "_atlas", tostring(arg_20_1), arg_20_0["upper_" .. iter_19_1]:Find("Level"), true)

			return
		end)
	end

	arg_19_0.Respones:AddRawListener(_.values(arg_19_0.Buildings), function(...)
		local var_21_0 = 0
		local var_21_1 = {
			...
		}

		for iter_21_0 = 1, table.getCount(arg_19_0.Buildings) do
			local var_21_2 = var_21_1[iter_21_0] or 1

			var_21_0 = var_21_0 + var_21_2
		end

		arg_19_0.Respones.sceneLevel = math.floor(var_21_0 / 4)

		return
	end)
	arg_19_0.Respones:AddRawListener({
		"sceneLevel",
		"view"
	}, function(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
		local var_22_0 = arg_22_1[1]
		local var_22_1 = arg_22_1[2]

		;(function(arg_23_0)
			setActive(var_22_1["map_" .. arg_23_0]:Find(tostring(var_22_0)), true)

			local var_23_0

			if arg_22_2[1] then
				setActive(var_22_1["map_" .. arg_23_0]:Find(tostring(arg_22_2[1])), false)

				var_23_0 = var_22_1["map_" .. arg_23_0]:Find(tostring(var_22_0))
			end

			var_22_1.loader:GetSpriteQuiet("ui/" .. arg_19_0:getUIName() .. "_level" .. var_22_0, ({
				xianshijianzao = "buildship",
				huanzhuangshangdian = "skinshop",
				taskboard = "taskboard"
			})[arg_23_0], var_23_0, true)

			GetComponent(var_22_1["map_" .. arg_23_0], typeof(Button)).targetGraphic = GetComponent(var_23_0, typeof(Image))

			return
		end)("xianshijianzao")
		;(function(arg_23_0)
			setActive(var_22_1["map_" .. arg_23_0]:Find(tostring(var_22_0)), true)

			local var_23_0

			if arg_22_2[1] then
				setActive(var_22_1["map_" .. arg_23_0]:Find(tostring(arg_22_2[1])), false)

				var_23_0 = var_22_1["map_" .. arg_23_0]:Find(tostring(var_22_0))
			end

			var_22_1.loader:GetSpriteQuiet("ui/" .. arg_19_0:getUIName() .. "_level" .. var_22_0, ({
				xianshijianzao = "buildship",
				huanzhuangshangdian = "skinshop",
				taskboard = "taskboard"
			})[arg_23_0], var_23_0, true)

			GetComponent(var_22_1["map_" .. arg_23_0], typeof(Button)).targetGraphic = GetComponent(var_23_0, typeof(Image))

			return
		end)("huanzhuangshangdian")
		;(function(arg_23_0)
			setActive(var_22_1["map_" .. arg_23_0]:Find(tostring(var_22_0)), true)

			local var_23_0

			if arg_22_2[1] then
				setActive(var_22_1["map_" .. arg_23_0]:Find(tostring(arg_22_2[1])), false)

				var_23_0 = var_22_1["map_" .. arg_23_0]:Find(tostring(var_22_0))
			end

			var_22_1.loader:GetSpriteQuiet("ui/" .. arg_19_0:getUIName() .. "_level" .. var_22_0, ({
				xianshijianzao = "buildship",
				huanzhuangshangdian = "skinshop",
				taskboard = "taskboard"
			})[arg_23_0], var_23_0, true)

			GetComponent(var_22_1["map_" .. arg_23_0], typeof(Button)).targetGraphic = GetComponent(var_23_0, typeof(Image))

			return
		end)("taskboard")
		arg_22_1[2].loader:GetSpriteQuiet("ui/" .. arg_19_0:getUIName() .. "_atlas", "title_" .. arg_22_1[1], arg_22_1[2]._tf:Find("top/Title/Number"), true)
		arg_22_1[2].loader:GetSpriteQuiet("ui/" .. arg_19_0:getUIName() .. "_level" .. arg_22_1[1], "bg", arg_22_1[2]._tf:Find("map"))

		return
	end, {
		useOldRef = true
	})
	table.insertto({
		"taskboard",
		"bigmap",
		"giftmake"
	}, var_19_0)

	for iter_19_2, iter_19_3 in ipairs({
		"taskboard",
		"bigmap",
		"giftmake"
	}) do
		arg_19_0.Respones:AddRawListener({
			"view",
			iter_19_3 .. "Tip"
		}, function(arg_24_0, arg_24_1)
			if not arg_24_0["upper_" .. iter_19_3] or IsNil(arg_24_0["upper_" .. iter_19_3]:Find("Tip")) then
				return
			end

			setActive(arg_24_0["upper_" .. iter_19_3]:Find("Tip"), arg_24_1)

			return
		end)
	end

	arg_19_0.Respones.hubData = {}

	arg_19_0.Respones:AddRawListener({
		"view",
		"hubData"
	}, function(arg_25_0, arg_25_1)
		arg_25_0.gameCountTxt.text = "X " .. arg_25_1.count

		return
	end, {
		strict = true
	})
	arg_19_0.Respones:AddRawListener({
		"view",
		"materialCount"
	}, function(arg_26_0, arg_26_1)
		arg_26_0.materialTxt.text = arg_26_1

		return
	end)

	return
end

function var_0_0.PlayStory()
	local var_27_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)
	local var_27_1 = var_27_0:GetTotalBuildingLevel()

	table.SerialIpairsAsync({
		false,
		var_27_0:getConfig("config_client").lv2Story,
		var_27_0:getConfig("config_client").lv3Story,
		var_27_0:getConfig("config_client").lv4Story
	}, function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 <= var_27_1 and arg_28_1 then
			pg.NewStoryMgr.GetInstance():Play(arg_28_1, arg_28_2)
		else
			arg_28_2()
		end

		return
	end)

	return
end

function var_0_0.UpdateView(arg_29_0)
	AnniversaryIsland2023Scene.PlayStory()

	local var_29_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)

	for iter_29_0, iter_29_1 in pairs(arg_29_0.Buildings) do
		arg_29_0.Respones[iter_29_1] = var_29_0.data1KeyValueList[2][iter_29_0] or 1
		arg_29_0.Respones[iter_29_1 .. "Tip"] = arg_29_0:UpdateBuildingTip(var_29_0, iter_29_0)
	end

	local var_29_1 = arg_29_0.Respones.craftTip

	if not arg_29_0.Respones.craftTip then
		var_29_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORKBENCH):HasAvaliableFormula()
		var_29_1 = var_29_1 and getProxy(SettingsProxy):IsTipWorkbenchDaily()
	end

	arg_29_0.Respones.craftTip = var_29_1
	arg_29_0.Respones.bigmapTip = tobool((function()
		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND)))
	end)())
	arg_29_0.Respones.taskboardTip = tobool((function()
		return getProxy(ActivityTaskProxy):getActTaskTip(ActivityConst.ISLAND_TASK_ID)
	end)())
	arg_29_0.Respones.giftmakeTip = tobool((function()
		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SCULPTURE)))
	end)())

	return
end

function var_0_0.CalculateSceneLevel(arg_33_0)
	return getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2):GetTotalBuildingLevel()
end

function var_0_0.UpdateBuildingTip(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = var_0_0.super.UpdateBuildingTip(arg_34_0, arg_34_1, arg_34_2)

	if var_34_0 then
		local var_34_1 = arg_34_1.data1KeyValueList[2][arg_34_2] or 1

		var_34_0 = var_34_0 and var_34_1 <= arg_34_1:GetTotalBuildingLevel()
	end

	return var_34_0
end

function var_0_0.willExit(arg_35_0)
	arg_35_0:clearStudents()
	var_0_0.super.willExit(arg_35_0)

	return
end

function var_0_0.IsShowMainTip(arg_36_0)
	if arg_36_0 and not arg_36_0:isEnd() then
		return (function()
			return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND)))
		end)() or (function()
			local var_38_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)

			for iter_38_0, iter_38_1 in ipairs(var_38_0:GetBuildingIds()) do
				if AnniversaryIsland2023Scene.UpdateBuildingTip(nil, var_38_0, iter_38_1) then
					return true
				end
			end

			if getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORKBENCH):HasAvaliableFormula() then
				if getProxy(SettingsProxy):IsTipWorkbenchDaily() then
					return true
				end
			end

			return
		end)() or (function()
			return getProxy(ActivityTaskProxy):getActTaskTip(ActivityConst.ISLAND_TASK_ID)
		end)() or (function()
			return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SCULPTURE)))
		end)()
	end

	return
end

return var_0_0
