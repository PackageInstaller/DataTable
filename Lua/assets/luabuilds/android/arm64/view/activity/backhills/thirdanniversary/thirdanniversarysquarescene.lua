local var_0_0 = class("ThirdAnniversarySquareScene", import("..TemplateMV.BackHillTemplate"))

var_0_0.UIName = "ThirdAnniversarySquareUI"
var_0_0.HUB_ID = 9
var_0_0.edge2area = {
	default = "_middle",
	["3_4"] = "_bottom",
	["4_5"] = "_bottom",
	["7_7"] = "_front"
}
var_0_0.Buildings = {
	"nvpukafeiting",
	"xiaolongbaodian",
	"zhajihanbaodian",
	"heguozidian"
}

function var_0_0.init(arg_1_0)
	arg_1_0.loader = AutoLoader.New()
	arg_1_0.top = arg_1_0._tf:Find("top")
	arg_1_0._map = arg_1_0._tf:Find("map")

	for iter_1_0 = 0, arg_1_0._map.childCount - 1 do
		local var_1_0 = arg_1_0._map:GetChild(iter_1_0)
		local var_1_1 = "map_" .. go(var_1_0).name

		arg_1_0[var_1_1] = var_1_0
	end

	arg_1_0._upper = arg_1_0._tf:Find("upper")

	for iter_1_1 = 0, arg_1_0._upper.childCount - 1 do
		local var_1_2 = arg_1_0._upper:GetChild(iter_1_1)
		local var_1_3 = "upper_" .. go(var_1_2).name

		arg_1_0[var_1_3] = var_1_2
	end

	arg_1_0._front = arg_1_0._map:Find("top")
	arg_1_0._middle = arg_1_0._map:Find("middle")
	arg_1_0._bottom = arg_1_0._map:Find("bottom")
	arg_1_0.containers = {
		arg_1_0._front,
		arg_1_0._middle,
		arg_1_0._bottom
	}
	arg_1_0._shipTpl = arg_1_0._map:Find("ship")
	arg_1_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.ThirdAnniversarySquareGraph"))
	arg_1_0.usableTxt = arg_1_0.top:Find("usable_count/text"):GetComponent(typeof(Text))
	arg_1_0.materialTxt = arg_1_0.top:Find("material/text"):GetComponent(typeof(Text))

	arg_1_0:RegisterDataResponse()

	return
end

function var_0_0.RegisterDataResponse(arg_2_0)
	arg_2_0.Respones = ResponsableTree.CreateShell({})

	arg_2_0.Respones:SetRawData("view", arg_2_0)

	for iter_2_0, iter_2_1 in ipairs({
		"xiaolongbaodian",
		"heguozidian",
		"nvpukafeiting",
		"zhajihanbaodian"
	}) do
		arg_2_0.Respones:AddRawListener({
			"view",
			iter_2_1
		}, function(arg_3_0, arg_3_1)
			if not arg_3_1 then
				return
			end

			arg_3_0.loader:GetSpriteQuiet("ui/thirdanniversarysquareui_atlas", iter_2_1 .. arg_3_1, arg_3_0["map_" .. iter_2_1])

			if not arg_3_0["upper_" .. iter_2_1] or IsNil(arg_3_0["upper_" .. iter_2_1]:Find("level")) then
				return
			end

			setText(arg_3_0["upper_" .. iter_2_1]:Find("level"), "LV." .. arg_3_1)

			return
		end)
	end

	for iter_2_2, iter_2_3 in ipairs({
		"xiaolongbaodian",
		"heguozidian",
		"nvpukafeiting",
		"zhajihanbaodian",
		"gangqvchenlieshi",
		"huanzhuangshandian",
		"shujvhuigu",
		"xianshijianzao"
	}) do
		arg_2_0.Respones:AddRawListener({
			"view",
			iter_2_3 .. "Tip"
		}, function(arg_4_0, arg_4_1)
			if not arg_4_0["upper_" .. iter_2_3] or IsNil(arg_4_0["upper_" .. iter_2_3]:Find("tip")) then
				return
			end

			setActive(arg_4_0["upper_" .. iter_2_3]:Find("tip"), arg_4_1)

			return
		end)
	end

	arg_2_0.Respones.hubData = {}

	arg_2_0.Respones:AddRawListener({
		"view",
		"hubData"
	}, function(arg_5_0, arg_5_1)
		arg_5_0.usableTxt.text = "X" .. arg_5_1.count

		return
	end, {
		strict = true
	})
	arg_2_0.Respones:AddRawListener({
		"view",
		"materialCount"
	}, function(arg_6_0, arg_6_1)
		arg_6_0.materialTxt.text = arg_6_1

		return
	end)

	return
end

function var_0_0.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0._tf:Find("top/return_btn"), function()
		arg_7_0:emit(var_0_0.ON_BACK)

		return
	end)
	onButton(arg_7_0, arg_7_0.top:Find("daka_count"), function()
		arg_7_0:emit(ThirdAnniversarySquareMediator.ON_OPEN_TOWERCLIMBING_SIGNED)

		return
	end)
	onButton(arg_7_0, arg_7_0._tf:Find("top/return_main_btn"), function()
		arg_7_0:emit(var_0_0.ON_HOME)

		return
	end)
	onButton(arg_7_0, arg_7_0._tf:Find("top/help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.qingdianguangchang_help.tip
		})

		return
	end)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.Buildings) do
		arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, iter_7_1, function()
			arg_7_0:emit(BackHillMediatorTemplate.GO_SUBLAYER, Context.New({
				mediator = BuildingUpgradeMediator,
				viewComponent = BuildingUpgradeLayer,
				data = {
					buildingID = iter_7_0
				}
			}))

			return
		end)
	end

	arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, "gangqvchenlieshi", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 13)

		return
	end)
	arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, "shujvhuigu", function()
		arg_7_0:emit(ThirdAnniversarySquareMediator.GO_SCENE, SCENE.SUMMARY)

		return
	end)
	arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, "xianshijianzao", function()
		arg_7_0:emit(ThirdAnniversarySquareMediator.GO_SCENE, SCENE.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, "huanzhuangshandian", function()
		arg_7_0:emit(ThirdAnniversarySquareMediator.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	pg.UIMgr.GetInstance():OverlayPanel(arg_7_0.top)

	return
end

function var_0_0.UpdateActivity(arg_17_0, arg_17_1)
	arg_17_0.activity = arg_17_1
	arg_17_0.Respones.nvpukafeiting = arg_17_1.data1KeyValueList[2][1] or 1
	arg_17_0.Respones.xiaolongbaodian = arg_17_1.data1KeyValueList[2][2] or 1
	arg_17_0.Respones.zhajihanbaodian = arg_17_1.data1KeyValueList[2][3] or 1
	arg_17_0.Respones.heguozidian = arg_17_1.data1KeyValueList[2][4] or 1
	arg_17_0.Respones.materialCount = arg_17_1.data1KeyValueList[1][next(arg_17_1.data1KeyValueList[1])] or 0

	arg_17_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_18_0)
	arg_18_0.Respones.nvpukafeitingTip = arg_18_0:UpdateBuildingTip(arg_18_0.activity, 1)
	arg_18_0.Respones.xiaolongbaodianTip = arg_18_0:UpdateBuildingTip(arg_18_0.activity, 2)
	arg_18_0.Respones.zhajihanbaodianTip = arg_18_0:UpdateBuildingTip(arg_18_0.activity, 3)
	arg_18_0.Respones.heguozidianTip = arg_18_0:UpdateBuildingTip(arg_18_0.activity, 4)
	arg_18_0.Respones.shujvhuiguTip = false

	local var_18_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)
	local var_18_1 = getProxy(MiniGameProxy):GetHubByHubId(var_18_0:getConfig("config_id"))

	arg_18_0.Respones.gangqvchenlieshiTip = var_18_1.count > 0

	arg_18_0:UpdateHubData(var_18_1)

	if not arg_18_0.InitStudentBegin then
		arg_18_0:InitStudents(var_18_0.id, 2, 3)

		arg_18_0.InitStudentBegin = true
	end

	return
end

function var_0_0.UpdateHubData(arg_19_0, arg_19_1)
	arg_19_0.Respones.hubData.count = arg_19_1.count
	arg_19_0.Respones.hubData.usedtime = arg_19_1.usedtime
	arg_19_0.Respones.hubData.id = arg_19_1.id

	arg_19_0.Respones:PropertyChange("hubData")

	return
end

function var_0_0.willExit(arg_20_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_20_0.top, arg_20_0._tf)
	arg_20_0:clearStudents()

	arg_20_0.Respones = nil

	var_0_0.super.willExit(arg_20_0)

	return
end

return var_0_0
