local var_0_0 = class("AkibaStreetScene", import("..TemplateMV.BackHillTemplate"))

var_0_0.UIName = "AkibaStreetUI"
var_0_0.edge2area = {
	["4_5"] = "_bottom",
	default = "_middle",
	["5_6"] = "_bottom"
}
var_0_0.Buildings = {
	nil,
	nil,
	nil,
	nil,
	"shudian",
	"youxidian",
	"moxingdian",
	"kafeiting"
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
	arg_1_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.AkibaGraph"))
	arg_1_0.usableTxt = arg_1_0.top:Find("usable_count/text"):GetComponent(typeof(Text))
	arg_1_0.materialTxt = arg_1_0.top:Find("material/text"):GetComponent(typeof(Text))

	arg_1_0:RegisterDataResponse()

	if PLATFORM_CODE ~= PLATFORM_JP then
		setActive(arg_1_0._upper:Find("shujvhuigu"), false)

		GetOrAddComponent(arg_1_0._map:Find("shujvhuigu"), typeof(Button)).enabled = false
	end

	return
end

function var_0_0.RegisterDataResponse(arg_2_0)
	arg_2_0.Respones = ResponsableTree.CreateShell({})

	arg_2_0.Respones:SetRawData("view", arg_2_0)

	for iter_2_0, iter_2_1 in ipairs({
		"shudian",
		"youxidian",
		"moxingdian",
		"kafeiting"
	}) do
		arg_2_0.Respones:AddRawListener({
			"view",
			iter_2_1
		}, function(arg_3_0, arg_3_1)
			if not arg_3_1 then
				return
			end

			arg_3_0.loader:GetSpriteQuiet("ui/AkibaStreetUI_atlas", iter_2_1 .. arg_3_1, arg_3_0["map_" .. iter_2_1])

			if not arg_3_0["upper_" .. iter_2_1] or IsNil(arg_3_0["upper_" .. iter_2_1]:Find("level")) then
				return
			end

			setText(arg_3_0["upper_" .. iter_2_1]:Find("level"), "LV." .. arg_3_1)

			return
		end)
	end

	for iter_2_2, iter_2_3 in ipairs({
		"shudian",
		"youxidian",
		"moxingdian",
		"kafeiting",
		"jiejiting",
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
		local var_9_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CLIENT_DISPLAY)

		if var_9_0 and not var_9_0:isEnd() then
			arg_7_0:emit(ThirdAnniversarySquareMediator.GO_SCENE, SCENE.ACTIVITY, {
				id = var_9_0.id
			})
		end

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

	arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, "jiejiting", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 14)

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
	arg_7_0.loader:GetPrefab("ui/zhuanzhu_caidai", "zhuanzhu_caidai", function(arg_17_0)
		setParent(arg_17_0, arg_7_0._map)
		pg.ViewUtils.SetSortingOrder(tf(arg_17_0), GameObject.Find("UICamera/Canvas"):GetComponent(typeof(Canvas)).sortingOrder + 1)

		return
	end)
	pg.UIMgr.GetInstance():OverlayPanel(arg_7_0.top, false)

	return
end

function var_0_0.UpdateActivity(arg_18_0, arg_18_1)
	arg_18_0.activity = arg_18_1
	arg_18_0.Respones.shudian = arg_18_1.data1KeyValueList[2][5] or 1
	arg_18_0.Respones.youxidian = arg_18_1.data1KeyValueList[2][6] or 1
	arg_18_0.Respones.moxingdian = arg_18_1.data1KeyValueList[2][7] or 1
	arg_18_0.Respones.kafeiting = arg_18_1.data1KeyValueList[2][8] or 1
	arg_18_0.Respones.materialCount = arg_18_1.data1KeyValueList[1][next(arg_18_1.data1KeyValueList[1])] or 0

	arg_18_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_19_0)
	arg_19_0.Respones.shudianTip = arg_19_0:UpdateBuildingTip(arg_19_0.activity, 5)
	arg_19_0.Respones.youxidianTip = arg_19_0:UpdateBuildingTip(arg_19_0.activity, 6)
	arg_19_0.Respones.moxingdianTip = arg_19_0:UpdateBuildingTip(arg_19_0.activity, 7)
	arg_19_0.Respones.kafeitingTip = arg_19_0:UpdateBuildingTip(arg_19_0.activity, 8)
	arg_19_0.Respones.shujvhuiguTip = false

	local var_19_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)
	local var_19_1 = getProxy(MiniGameProxy):GetHubByHubId(var_19_0:getConfig("config_id"))

	arg_19_0.Respones.jiejitingTip = var_19_1.count > 0

	arg_19_0:UpdateHubData(var_19_1)

	if not arg_19_0.InitStudentBegin then
		arg_19_0:InitStudents(var_19_0.id, 3, 4)

		arg_19_0.InitStudentBegin = true
	end

	return
end

function var_0_0.UpdateHubData(arg_20_0, arg_20_1)
	arg_20_0.Respones.hubData.count = arg_20_1.count
	arg_20_0.Respones.hubData.usedtime = arg_20_1.usedtime
	arg_20_0.Respones.hubData.id = arg_20_1.id

	arg_20_0.Respones:PropertyChange("hubData")

	return
end

function var_0_0.willExit(arg_21_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_21_0.top, arg_21_0._tf)
	arg_21_0:clearStudents()

	arg_21_0.Respones = nil

	var_0_0.super.willExit(arg_21_0)

	return
end

return var_0_0
