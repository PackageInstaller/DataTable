class = var_0_10000

local var_0_0 = "NewYearFestival2023Scene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.BackHillTemplate"))

var_0_1.edge2area = {
	default = "map_middle",
	["4_4"] = "map_bottom"
}

function var_0_1.getUIName(arg_1_0)
	return "NewYearFestival2023UI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "Top")

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
	arg_2_0.containers = {
		arg_2_0.map_middle
	}
	GraphPath = var_1

	local var_2_5 = var_1.New

	import = var_2_4
	arg_2_0.graphPath = var_2_5(var_2_4("GameCfg.BackHillGraphs.NewyearFestival2023Graph"))

	local var_2_6 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_6, "upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_7 = arg_2_0._upper
		local var_2_8 = var_5.GetChild(var_2_7, iter_2_1)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_2_8).name
		arg_2_0["upper_" .. var_1_10006] = var_2_8
	end

	_ = var_1

	local var_2_9 = var_1.map

	_ = var_3
	arg_2_0.tipTfs = var_2_9(var_3.range(arg_2_0._upper.childCount), function(arg_3_0)
		local var_3_0 = arg_2_0._upper
		local var_3_1 = var_1.GetChild(var_3_0, arg_3_0 - 1)

		return {
			name = var_3_1.name,
			trans = var_3_1:Find("Tip")
		}
	end)
	pg = var_1

	local var_2_10 = var_1.ViewUtils.SetSortingOrder
	local var_2_11 = arg_2_0._map

	var_2_10(var_3.GetChild(var_2_11, arg_2_0._map.childCount - 1), 1)

	AutoLoader = var_2_10
	arg_2_0.loader = var_2_10.New()

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.top

	var_1_10001(var_4_0, var_4.Find(var_4_1, "Back"), function()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_BACK)

		return
	end)

	onButton = var_1_10001

	local var_4_2 = arg_4_0
	local var_4_3 = arg_4_0.top

	var_1_10001(var_4_2, var_4.Find(var_4_3, "Home"), function()
		local var_6_0 = arg_4_0

		var_0.emit(var_6_0, var_0_1.ON_HOME)

		return
	end)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.top

	var_1_10001(var_4_4, var_4.Find(var_4_5, "Help"), function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		pg = var_2_10004
		var_7_2.helps = var_2_10004.gametip.resorts_help.tip

		var_7_1(var_7_0, var_7_2)

		return
	end)
	arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "hotspring", function()
		local var_8_0 = arg_4_0
		local var_8_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10003

		local var_8_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_8_1(var_8_0, var_8_2, var_2_10004.HOTSPRING)

		return
	end)
	arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "duihuanwu", function()
		Context = var_2_10000

		local var_9_0 = var_2_10000.New()

		SCENE = var_2_10001

		local var_9_1 = var_2_10001.SetSceneInfo
		local var_9_2 = var_9_0

		SCENE = var_2_10004

		var_9_1(var_9_2, var_2_10004.HOTSPRING_SHOP)

		local var_9_3 = arg_4_0
		local var_9_4 = var_1.emit

		BackHillMediatorTemplate = var_4

		var_9_4(var_9_3, var_4.GO_SUBLAYER, var_9_0)

		return
	end)
	arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "firework", function()
		pg = var_2_10000

		local var_10_0 = var_2_10000.m02
		local var_10_1 = var_0.sendNotification

		GAME = var_2_10003

		var_10_1(var_10_0, var_2_10003.GO_MINI_GAME, 44)

		return
	end)
	arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "shrine", function()
		pg = var_2_10000

		local var_11_0 = var_2_10000.m02
		local var_11_1 = var_0.sendNotification

		GAME = var_2_10003

		var_11_1(var_11_0, var_2_10003.GO_MINI_GAME, 45)

		return
	end)
	arg_4_0:InitFacilityCross(arg_4_0._map, arg_4_0._upper, "fudai", function()
		local var_12_0 = arg_4_0
		local var_12_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10003

		local var_12_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_12_1(var_12_0, var_12_2, var_2_10004.HOTSPRING_REDPACKET)

		return
	end)
	arg_4_0:BindItemBuildShip()
	arg_4_0:BindItemSkinShop()

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.InitStudents

	ActivityConst = var_4

	var_4_7(var_4_6, var_4.MINIGAME_FIREWORK_VS_SAIREN, 3, 4)
	arg_4_0:UpdateView()

	return
end

function var_0_1.UpdateActivity(arg_13_0, arg_13_1)
	arg_13_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_14_0)
	_ = var_1_10001

	var_1_10001.each(arg_14_0.tipTfs, function(arg_15_0)
		switch = var_2_10001

		local var_15_0 = var_2_10001(arg_15_0.name, {
			fudai = function()
				BeachPacketLayer = var_3_10000

				return var_3_10000.isShowRedPoint()
			end,
			hotspring = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_17_0 = var_3_10000(var_3_10002)
				local var_17_1 = var_0.getActivityByType

				ActivityConst = var_3_10003

				local var_17_2 = var_17_1(var_17_0, var_3_10003.ACTIVITY_TYPE_HOTSPRING)

				Activity = var_3_10001

				return var_3_10001.IsActivityReady(var_17_2)
			end,
			shrine = function()
				Shrine2023View = var_3_10000

				return var_3_10000.IsNeedShowTipWithoutActivityFinalReward()
			end,
			duihuanwu = function()
				AmusementParkShopPage = var_3_10000

				return var_3_10000.GetActivityShopTip()
			end,
			firework = function()
				BackHillTemplate = var_3_10000

				local var_20_0 = var_3_10000.IsMiniActNeedTip

				ActivityConst = var_3_10002

				return var_20_0(var_3_10002.MINIGAME_FIREWORK_VS_SAIREN)
			end
		}, function()
			return false
		end)

		setActive = var_2_10002

		local var_15_1 = arg_15_0.trans

		tobool = var_5

		var_2_10002(var_15_1, var_5(var_15_0))

		return
	end)

	return
end

function var_0_1.IsShowMainTip(arg_22_0)
	local var_22_0 = {
		fudai = function()
			BeachPacketLayer = var_2_10000

			return var_2_10000.isShowRedPoint()
		end,
		hotspring = function()
			getProxy = var_2_10000
			ActivityProxy = var_2_10002

			local var_24_0 = var_2_10000(var_2_10002)
			local var_24_1 = var_0.getActivityByType

			ActivityConst = var_2_10003

			local var_24_2 = var_24_1(var_24_0, var_2_10003.ACTIVITY_TYPE_HOTSPRING)

			Activity = var_2_10001

			return var_2_10001.IsActivityReady(var_24_2)
		end,
		shrine = function()
			Shrine2023View = var_2_10000

			return var_2_10000.IsNeedShowTipWithoutActivityFinalReward()
		end,
		duihuanwu = function()
			AmusementParkShopPage = var_2_10000

			return var_2_10000.GetActivityShopTip()
		end,
		firework = function()
			BackHillTemplate = var_2_10000

			local var_27_0 = var_2_10000.IsMiniActNeedTip

			ActivityConst = var_2_10002

			return var_27_0(var_2_10002.MINIGAME_FIREWORK_VS_SAIREN)
		end
	}

	_ = var_2

	local var_22_1 = var_2.any

	_ = var_1_10004

	return var_22_1(var_1_10004.values(var_22_0), function(arg_28_0)
		return arg_28_0()
	end)
end

function var_0_1.willExit(arg_29_0)
	arg_29_0:clearStudents()
	var_0_1.super.willExit(arg_29_0)

	return
end

return var_0_1
