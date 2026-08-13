class = var_0_10000

local var_0_0 = "BackHillTemplate"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return arg_1_0.UIName
end

function var_0_1.init(arg_2_0)
	AutoLoader = var_1_10001
	arg_2_0.loader = var_1_10001.New()

	return
end

function var_0_1.willExit(arg_3_0)
	local var_3_0 = arg_3_0.loader

	var_1.Clear(var_3_0)

	return
end

function var_0_1.InitFacility(arg_4_0, arg_4_1, arg_4_2)
	onButton = var_1_10003

	var_1_10003(arg_4_0, arg_4_1, arg_4_2)

	onButton = var_1_10003

	var_1_10003(arg_4_0, arg_4_1:Find("button"), arg_4_2)

	return
end

function var_0_1.InitFacilityCross(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	onButton = var_1_10005

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.Find(var_5_1, arg_5_3)
	local var_5_3 = arg_5_4

	SFX_PANEL = var_5_1

	var_1_10005(var_5_0, var_5_2, var_5_3, var_5_1)

	onButton = var_1_10005

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_2
	local var_5_6 = arg_5_2.Find(var_5_5, arg_5_3)
	local var_5_7 = arg_5_4

	SFX_PANEL = var_5_5

	var_1_10005(var_5_4, var_5_6, var_5_7, var_5_5)

	return
end

function var_0_1.getStudents(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}

	getProxy = var_1_10004
	ActivityProxy = var_1_10006

	local var_6_1 = var_1_10004(var_1_10006)

	if not var_4.getActivityById(var_6_1, arg_6_0) then
		return var_6_0
	end

	local var_6_2

	if var_5:getConfig("config_client") then
		var_6_2 = var_6_2.ships
	end

	if var_6_2 then
		Clone = var_6_1

		local var_6_3 = var_6_1(var_6_2)

		math = var_7

		local var_6_4 = var_7.random(arg_6_1, arg_6_2)
		local var_6_5 = #var_6_3

		while var_6_4 > 0 and 0 < var_6_5 do
			math = var_6_6

			local var_6_6 = var_6_6.random(1, var_6_5)

			table = var_10

			var_10.insert(var_6_0, var_6_3[var_6_6])

			var_6_3[var_6_6] = var_6_3[var_6_5]
			var_6_5 = var_6_5 - 1
			var_6_4 = var_6_4 - 1
		end
	end

	return var_6_0
end

function var_0_1.InitStudents(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = var_0_1.getStudents(arg_7_1, arg_7_2, arg_7_3)
	local var_7_1 = {}

	pairs = var_6

	for iter_7_0, iter_7_1 in var_6(arg_7_0.graphPath.points) do
		if not iter_7_1.outRandom then
			table = var_11

			var_11.insert(var_7_1, iter_7_1)
		end
	end

	local var_7_2 = #var_7_1

	arg_7_0.academyStudents = {}

	local var_7_3 = {}

	pairs = var_8

	for iter_7_2, iter_7_3 in var_8(var_7_0) do
		if not arg_7_0.academyStudents[iter_7_2] then
			cloneTplTo = var_13
			var_13(arg_7_0._shipTpl, arg_7_0._map).gameObject.name = iter_7_2

			local var_7_4 = arg_7_0.ChooseRandomPos(var_7_1, var_7_2)

			var_7_2 = (var_7_2 - 2) % #var_7_1 + 1
			SummerFeastNavigationAgent = var_15

			local var_7_5 = var_15.New(var_13.gameObject, true)

			var_15.attach(var_7_5)
			var_15:setPathFinder(arg_7_0.graphPath)
			var_15:SetPositionTable(var_7_3)
			var_15:setCurrentIndex(var_7_4 and var_7_4.id)
			var_15:SetOnTransEdge(function(arg_8_0, arg_8_1, arg_8_2)
				math = var_2_10003

				local var_8_0 = var_2_10003.min(arg_8_1, arg_8_2)

				math = var_2_10004
				arg_8_2 = var_2_10004.max(arg_8_1, arg_8_2)
				arg_8_1 = var_8_0

				local var_8_1 = arg_7_0
				local var_8_2

				if not arg_7_0.edge2area[arg_8_1 .. "_" .. arg_8_2] then
					var_8_2 = arg_7_0.edge2area.default
				end

				local var_8_3 = var_8_1[var_8_2]
				local var_8_4 = arg_8_0._tf

				var_4.SetParent(var_8_4, var_8_3)

				return
			end)
			var_15:updateStudent(iter_7_3)

			arg_7_0.academyStudents[iter_7_2] = var_15
		end
	end

	if #var_7_0 > 0 then
		Timer = var_8
		arg_7_0.sortTimer = var_8.New(function()
			local var_9_0 = arg_7_0

			var_0.sortStudents(var_9_0)

			return
		end, 0.2, -1)

		local var_7_6 = arg_7_0.sortTimer

		var_8.Start(var_7_6)
		arg_7_0.sortTimer.func()
	end

	return
end

function var_0_1.ChooseRandomPos(arg_10_0, arg_10_1)
	math = var_1_10002

	if not var_1_10002.random(1, arg_10_1) then
		return nil
	end

	pg = var_1_10003

	var_1_10003.Tool.Swap(arg_10_0, var_2, arg_10_1)

	return arg_10_0[arg_10_1]
end

function var_0_1.sortStudents(arg_11_0)
	local var_11_0 = arg_11_0.containers

	pairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(var_11_0) do
		if iter_11_1.childCount > 1 then
			local var_11_1 = {}

			for iter_11_2 = 1, iter_11_1.childCount do
				local var_11_2 = iter_11_1:GetChild(iter_11_2 - 1)

				table = var_1_10013

				var_1_10013.insert(var_11_1, {
					tf = var_11_2,
					index = iter_11_2
				})
			end

			table = var_8

			var_8.sort(var_11_1, function(arg_12_0, arg_12_1)
				local var_12_0 = arg_12_0.tf.anchoredPosition.y - arg_12_1.tf.anchoredPosition.y

				math = var_3

				if var_3.abs(var_12_0) < 1 then
					return arg_12_0.index < arg_12_1.index
				else
					return var_12_0 > 0
				end

				return
			end)

			ipairs = var_8

			for iter_11_3, iter_11_4 in var_8(var_11_1) do
				local var_11_3 = iter_11_4.tf

				var_1_10013.SetSiblingIndex(var_11_3, iter_11_3 - 1)
			end
		end
	end

	return
end

function var_0_1.clearStudents(arg_13_0)
	if arg_13_0.sortTimer then
		local var_13_0 = arg_13_0.sortTimer

		var_1.Stop(var_13_0)

		arg_13_0.sortTimer = nil
	end

	if arg_13_0.academyStudents then
		pairs = var_1

		for iter_13_0, iter_13_1 in var_1(arg_13_0.academyStudents) do
			iter_13_1:detach()

			Destroy = var_6

			var_6(iter_13_1._go)
		end

		table = var_1

		var_1.clear(arg_13_0.academyStudents)
	end

	return
end

function var_0_1.AutoFitScreen(arg_14_0)
	Screen = var_1_10001

	local var_14_0 = var_1_10001.width

	Screen = var_1_10002

	local var_14_1 = var_14_0 / var_1_10002.height
	local var_14_2 = 1.7777777777777777
	local var_14_3 = arg_14_0._map.rect.width
	local var_14_4 = arg_14_0._map.rect.height
	local var_14_5

	if var_14_2 <= var_14_1 then
		var_1_10006 = 1080 * var_14_1
		math = var_1_10007
		var_14_5 = var_1_10007.clamp(var_1_10006 / var_14_3, 1, 2)
	else
		var_1_10006 = 0 / var_14_1
		math = var_1_10007
		var_14_5 = var_1_10007.clamp(var_1_10006 / var_14_4, 1, 2)
	end

	setLocalScale = var_1_10006

	var_1_10006(arg_14_0._map, {
		x = var_14_5,
		y = var_14_5,
		z = var_14_5
	})

	setLocalScale = var_1_10006

	var_1_10006(arg_14_0._upper, {
		x = var_14_5,
		y = var_14_5,
		z = var_14_5
	})

	return
end

function var_0_1.IsMiniActNeedTip(arg_15_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_15_0 = var_1_10001(var_1_10003)
	local var_15_1 = var_1.getActivityById(var_15_0, arg_15_0)

	assert = var_1_10002

	var_1_10002(var_15_1)

	Activity = var_1_10002

	return var_1_10002.IsActivityReady(var_15_1)
end

function var_0_1.UpdateActivity(arg_16_0, arg_16_1)
	return
end

function var_0_1.BindItemActivityShop(arg_17_0)
	arg_17_0:InitFacilityCross(arg_17_0._map, arg_17_0._upper, "bujishangdian", function()
		local var_18_0 = arg_17_0
		local var_18_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10003

		local var_18_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_18_3 = var_2_10004.SHOP
		local var_18_4 = {}

		NewShopsScene = var_2_10006
		var_18_4.warp = var_2_10006.TYPE_ACTIVITY

		var_18_1(var_18_0, var_18_2, var_18_3, var_18_4)

		return
	end)

	return
end

function var_0_1.BindItemSkinShop(arg_19_0)
	arg_19_0:InitFacilityCross(arg_19_0._map, arg_19_0._upper, "huanzhuangshangdian", function()
		local var_20_0 = arg_19_0
		local var_20_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10003

		local var_20_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_20_1(var_20_0, var_20_2, var_2_10004.SKINSHOP)

		return
	end)

	return
end

function var_0_1.BindItemBuildShip(arg_21_0)
	arg_21_0:InitFacilityCross(arg_21_0._map, arg_21_0._upper, "xianshijianzao", function()
		local var_22_0

		getProxy = var_2_10001
		ActivityProxy = var_2_10003

		local var_22_1 = var_2_10001(var_2_10003)
		local var_22_2 = var_1.getActivityByType

		ActivityConst = var_2_10004

		local var_22_3 = var_22_2(var_22_1, var_2_10004.ACTIVITY_TYPE_BUILDSHIP_1)

		getProxy = var_2_10002
		ActivityProxy = var_4

		local var_22_4 = var_2_10002(var_4)
		local var_22_5 = var_2.getActivityByType

		ActivityConst = var_2_10005

		local var_22_6 = var_22_5(var_22_4, var_2_10005.ACTIVITY_TYPE_BUILD)

		if var_22_3 and not var_22_3:isEnd() then
			BuildShipScene = var_22_1
			var_22_0 = var_22_1.PROJECTS.ACTIVITY
		elseif var_22_6 and not var_22_6:isEnd() then
			var_22_1 = {}
			BuildShipScene = var_22_4
			var_22_1[1] = var_22_4.PROJECTS.SPECIAL
			BuildShipScene = var_4
			var_22_1[2] = var_4.PROJECTS.LIGHT
			BuildShipScene = var_4
			var_22_1[3] = var_4.PROJECTS.HEAVY
			var_2_10006 = var_22_6
			var_22_0 = var_22_1[var_22_6.getConfig(var_2_10006, "config_client").id]
		else
			pg = var_22_1

			local var_22_7 = var_22_1.TipsMgr.GetInstance()
			local var_22_8 = var_3.ShowTips

			i18n = var_2_10006

			var_22_8(var_22_7, var_2_10006("common_activity_end"))

			return
		end

		local var_22_9 = arg_21_0
		local var_22_10 = var_3.emit

		BackHillMediatorTemplate = var_2_10006

		local var_22_11 = var_2_10006.GO_SCENE

		SCENE = var_2_10007

		local var_22_12 = var_2_10007.GETBOAT
		local var_22_13 = {}

		BuildShipScene = var_2_10009
		var_22_13.page = var_2_10009.PAGE_BUILD
		var_22_13.projectName = var_22_0

		var_22_10(var_22_9, var_22_11, var_22_12, var_22_13)

		return
	end)

	return
end

function var_0_1.BindItemBattle(arg_23_0)
	arg_23_0:InitFacilityCross(arg_23_0._map, arg_23_0._upper, "tebiezuozhan", function()
		getProxy = var_2_10000
		ChapterProxy = var_2_10002

		local var_24_0 = var_2_10000(var_2_10002)
		local var_24_1, var_24_2 = var_0.getLastMapForActivity(var_24_0)

		if var_24_1 then
			local var_24_3 = var_0:getMapById(var_24_1)

			if not var_24_0.isUnlock(var_24_3) then
				pg = var_24_0

				local var_24_4 = var_24_0.TipsMgr.GetInstance()
				local var_24_5 = var_3.ShowTips

				i18n = var_2_10006

				var_24_5(var_24_4, var_2_10006("common_activity_end"))
			else
				local var_24_6 = arg_23_0
				local var_24_7 = var_3.emit

				BackHillMediatorTemplate = var_2_10006

				local var_24_8 = var_2_10006.GO_SCENE

				SCENE = var_2_10007

				var_24_7(var_24_6, var_24_8, var_2_10007.LEVEL, {
					chapterId = var_24_2,
					mapIdx = var_24_1
				})
			end

			return
		end
	end)

	return
end

function var_0_1.UpdateBuildingTip(arg_25_0, arg_25_1, arg_25_2)
	if not arg_25_1 then
		return false
	end

	local var_25_0 = arg_25_1:GetBuildingLevel(arg_25_2)

	pg = var_1_10004

	if not var_1_10004.activity_event_building[arg_25_2] or var_25_0 >= #var_4.buff then
		return false
	end

	local var_25_1 = var_4.material[var_25_0]

	_ = var_6

	return var_6.all(var_25_1, function(arg_26_0)
		local var_26_0 = arg_26_0[1]
		local var_26_1 = arg_26_0[2]
		local var_26_2 = arg_26_0[3]
		local var_26_3 = 0

		DROP_TYPE_VITEM = var_2_10005

		if var_26_0 == var_2_10005 then
			AcessWithinNull = var_2_10005
			Item = var_2_10007
			var_2_10005 = var_2_10005(var_2_10007.getConfigData(var_26_1), "link_id")
			assert = var_2_10006

			var_2_10006(var_2_10005 == arg_25_1.id)

			local var_26_4 = arg_25_1

			var_26_3 = var_2_10006.GetMaterialCount(var_26_4, var_26_1)
		else
			DROP_TYPE_USE_ACTIVITY_DROP = var_2_10005

			if var_2_10005 < var_26_0 then
				AcessWithinNull = var_2_10005
				pg = var_2_10007

				local var_26_5 = var_2_10005(var_2_10007.activity_drop_type[var_26_0], "activity_id")

				assert = var_2_10006

				var_2_10006(var_26_5)

				getProxy = var_2_10006
				ActivityProxy = var_8

				local var_26_6 = var_2_10006(var_8)
				local var_26_7 = var_6.getActivityById(var_26_6, var_26_5)

				bagAct = bagAct
				var_26_3 = var_6:getVitemNumber(var_26_1)
			end
		end

		return var_26_2 <= var_26_3
	end)
end

function var_0_1.UpdateView(arg_27_0)
	return
end

return var_0_1
