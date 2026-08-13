class = var_0_10000

local var_0_0 = "CoreActivityBackHillTemplate"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	AutoLoader = var_1_10001
	arg_1_0.loader = var_1_10001.New()

	return
end

function var_0_1.InitFacility(arg_2_0, arg_2_1, arg_2_2)
	onButton = var_1_10003

	var_1_10003(arg_2_0, arg_2_1, arg_2_2)

	onButton = var_1_10003

	var_1_10003(arg_2_0, arg_2_1:Find("button"), arg_2_2)

	return
end

function var_0_1.InitFacilityCross(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	onButton = var_1_10005

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_1
	local var_3_2 = arg_3_1.Find(var_3_1, arg_3_3)
	local var_3_3 = arg_3_4

	SFX_PANEL = var_3_1

	var_1_10005(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10005

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_2
	local var_3_6 = arg_3_2.Find(var_3_5, arg_3_3)
	local var_3_7 = arg_3_4

	SFX_PANEL = var_3_5

	var_1_10005(var_3_4, var_3_6, var_3_7, var_3_5)

	return
end

function var_0_1.getStudents(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {}

	getProxy = var_1_10004
	ActivityProxy = var_1_10006

	local var_4_1 = var_1_10004(var_1_10006)

	if not var_4.getActivityById(var_4_1, arg_4_0) then
		return var_4_0
	end

	local var_4_2

	if var_5:getConfig("config_client") then
		var_4_2 = var_4_2.ships
	end

	if var_4_2 then
		Clone = var_4_1

		local var_4_3 = var_4_1(var_4_2)

		math = var_7

		local var_4_4 = var_7.random(arg_4_1, arg_4_2)
		local var_4_5 = #var_4_3

		while var_4_4 > 0 and 0 < var_4_5 do
			math = var_4_6

			local var_4_6 = var_4_6.random(1, var_4_5)

			table = var_10

			var_10.insert(var_4_0, var_4_3[var_4_6])

			var_4_3[var_4_6] = var_4_3[var_4_5]
			var_4_5 = var_4_5 - 1
			var_4_4 = var_4_4 - 1
		end
	end

	return var_4_0
end

function var_0_1.InitStudents(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = var_0_1.getStudents(arg_5_1, arg_5_2, arg_5_3)
	local var_5_1 = {}

	pairs = var_6

	for iter_5_0, iter_5_1 in var_6(arg_5_0.graphPath.points) do
		if not iter_5_1.outRandom then
			table = var_11

			var_11.insert(var_5_1, iter_5_1)
		end
	end

	local var_5_2 = #var_5_1

	arg_5_0.academyStudents = {}

	local var_5_3 = {}

	pairs = var_8

	for iter_5_2, iter_5_3 in var_8(var_5_0) do
		if not arg_5_0.academyStudents[iter_5_2] then
			cloneTplTo = var_13
			var_13(arg_5_0._shipTpl, arg_5_0._map).gameObject.name = iter_5_2

			local var_5_4 = arg_5_0.ChooseRandomPos(var_5_1, var_5_2)

			var_5_2 = (var_5_2 - 2) % #var_5_1 + 1
			SummerFeastNavigationAgent = var_15

			local var_5_5 = var_15.New(var_13.gameObject)

			var_15.attach(var_5_5)
			var_15:setPathFinder(arg_5_0.graphPath)
			var_15:SetPositionTable(var_5_3)
			var_15:setCurrentIndex(var_5_4 and var_5_4.id)
			var_15:SetOnTransEdge(function(arg_6_0, arg_6_1, arg_6_2)
				math = var_2_10003

				local var_6_0 = var_2_10003.min(arg_6_1, arg_6_2)

				math = var_2_10004
				arg_6_2 = var_2_10004.max(arg_6_1, arg_6_2)
				arg_6_1 = var_6_0

				local var_6_1 = arg_5_0
				local var_6_2

				if not arg_5_0.edge2area[arg_6_1 .. "_" .. arg_6_2] then
					var_6_2 = arg_5_0.edge2area.default
				end

				local var_6_3 = var_6_1[var_6_2]
				local var_6_4 = arg_6_0._tf

				var_4.SetParent(var_6_4, var_6_3)

				return
			end)
			var_15:updateStudent(iter_5_3)

			arg_5_0.academyStudents[iter_5_2] = var_15
		end
	end

	if #var_5_0 > 0 then
		Timer = var_8
		arg_5_0.sortTimer = var_8.New(function()
			local var_7_0 = arg_5_0

			var_0.sortStudents(var_7_0)

			return
		end, 0.2, -1)

		local var_5_6 = arg_5_0.sortTimer

		var_8.Start(var_5_6)
		arg_5_0.sortTimer.func()
	end

	return
end

function var_0_1.ChooseRandomPos(arg_8_0, arg_8_1)
	math = var_1_10002

	if not var_1_10002.random(1, arg_8_1) then
		return nil
	end

	pg = var_1_10003

	var_1_10003.Tool.Swap(arg_8_0, var_2, arg_8_1)

	return arg_8_0[arg_8_1]
end

function var_0_1.sortStudents(arg_9_0)
	local var_9_0 = arg_9_0.containers

	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(var_9_0) do
		if iter_9_1.childCount > 1 then
			local var_9_1 = {}

			for iter_9_2 = 1, iter_9_1.childCount do
				local var_9_2 = iter_9_1:GetChild(iter_9_2 - 1)

				table = var_1_10013

				var_1_10013.insert(var_9_1, {
					tf = var_9_2,
					index = iter_9_2
				})
			end

			table = var_8

			var_8.sort(var_9_1, function(arg_10_0, arg_10_1)
				local var_10_0 = arg_10_0.tf.anchoredPosition.y - arg_10_1.tf.anchoredPosition.y

				math = var_3

				if var_3.abs(var_10_0) < 1 then
					return arg_10_0.index < arg_10_1.index
				else
					return var_10_0 > 0
				end

				return
			end)

			ipairs = var_8

			for iter_9_3, iter_9_4 in var_8(var_9_1) do
				local var_9_3 = iter_9_4.tf

				var_1_10013.SetSiblingIndex(var_9_3, iter_9_3 - 1)
			end
		end
	end

	return
end

function var_0_1.clearStudents(arg_11_0)
	if arg_11_0.sortTimer then
		local var_11_0 = arg_11_0.sortTimer

		var_1.Stop(var_11_0)

		arg_11_0.sortTimer = nil
	end

	if arg_11_0.academyStudents then
		pairs = var_1

		for iter_11_0, iter_11_1 in var_1(arg_11_0.academyStudents) do
			iter_11_1:detach()

			Destroy = var_6

			var_6(iter_11_1._go)
		end

		table = var_1

		var_1.clear(arg_11_0.academyStudents)
	end

	return
end

function var_0_1.AutoFitScreen(arg_12_0)
	Screen = var_1_10001

	local var_12_0 = var_1_10001.width

	Screen = var_1_10002

	local var_12_1 = var_12_0 / var_1_10002.height
	local var_12_2 = 1.7777777777777777
	local var_12_3 = arg_12_0._map.rect.width
	local var_12_4 = arg_12_0._map.rect.height
	local var_12_5

	if var_12_2 <= var_12_1 then
		var_1_10006 = 1080 * var_12_1
		math = var_1_10007
		var_12_5 = var_1_10007.clamp(var_1_10006 / var_12_3, 1, 2)
	else
		var_1_10006 = 0 / var_12_1
		math = var_1_10007
		var_12_5 = var_1_10007.clamp(var_1_10006 / var_12_4, 1, 2)
	end

	setLocalScale = var_1_10006

	var_1_10006(arg_12_0._map, {
		x = var_12_5,
		y = var_12_5,
		z = var_12_5
	})

	setLocalScale = var_1_10006

	var_1_10006(arg_12_0._upper, {
		x = var_12_5,
		y = var_12_5,
		z = var_12_5
	})

	return
end

function var_0_1.IsMiniActNeedTip(arg_13_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_13_0 = var_1_10001(var_1_10003)
	local var_13_1 = var_1.getActivityById(var_13_0, arg_13_0)

	assert = var_1_10002

	var_1_10002(var_13_1)

	Activity = var_1_10002

	return var_1_10002.IsActivityReady(var_13_1)
end

function var_0_1.UpdateActivity(arg_14_0, arg_14_1)
	return
end

function var_0_1.BindItemActivityShop(arg_15_0)
	arg_15_0:InitFacilityCross(arg_15_0._map, arg_15_0._upper, "bujishangdian", function()
		local var_16_0 = arg_15_0
		local var_16_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10003

		local var_16_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_16_3 = var_2_10004.SHOP
		local var_16_4 = {}

		NewShopsScene = var_2_10006
		var_16_4.warp = var_2_10006.TYPE_ACTIVITY

		var_16_1(var_16_0, var_16_2, var_16_3, var_16_4)

		return
	end)

	return
end

function var_0_1.BindItemSkinShop(arg_17_0)
	arg_17_0:InitFacilityCross(arg_17_0._map, arg_17_0._upper, "huanzhuangshangdian", function()
		local var_18_0 = arg_17_0
		local var_18_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10003

		local var_18_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_18_1(var_18_0, var_18_2, var_2_10004.SKINSHOP)

		return
	end)

	return
end

function var_0_1.BindItemBuildShip(arg_19_0)
	arg_19_0:InitFacilityCross(arg_19_0._map, arg_19_0._upper, "xianshijianzao", function()
		local var_20_0

		getProxy = var_2_10001
		ActivityProxy = var_2_10003

		local var_20_1 = var_2_10001(var_2_10003)
		local var_20_2 = var_1.getActivityByType

		ActivityConst = var_2_10004

		local var_20_3 = var_20_2(var_20_1, var_2_10004.ACTIVITY_TYPE_BUILDSHIP_1)

		getProxy = var_2_10002
		ActivityProxy = var_4

		local var_20_4 = var_2_10002(var_4)
		local var_20_5 = var_2.getActivityByType

		ActivityConst = var_2_10005

		local var_20_6 = var_20_5(var_20_4, var_2_10005.ACTIVITY_TYPE_BUILD)

		if var_20_3 and not var_20_3:isEnd() then
			BuildShipScene = var_20_1
			var_20_0 = var_20_1.PROJECTS.ACTIVITY
		elseif var_20_6 and not var_20_6:isEnd() then
			var_20_1 = {}
			BuildShipScene = var_20_4
			var_20_1[1] = var_20_4.PROJECTS.SPECIAL
			BuildShipScene = var_4
			var_20_1[2] = var_4.PROJECTS.LIGHT
			BuildShipScene = var_4
			var_20_1[3] = var_4.PROJECTS.HEAVY
			var_2_10006 = var_20_6
			var_20_0 = var_20_1[var_20_6.getConfig(var_2_10006, "config_client").id]
		else
			pg = var_20_1

			local var_20_7 = var_20_1.TipsMgr.GetInstance()
			local var_20_8 = var_3.ShowTips

			i18n = var_2_10006

			var_20_8(var_20_7, var_2_10006("common_activity_end"))

			return
		end

		local var_20_9 = arg_19_0
		local var_20_10 = var_3.emit

		BackHillMediatorTemplate = var_2_10006

		local var_20_11 = var_2_10006.GO_SCENE

		SCENE = var_2_10007

		local var_20_12 = var_2_10007.GETBOAT
		local var_20_13 = {}

		BuildShipScene = var_2_10009
		var_20_13.page = var_2_10009.PAGE_BUILD
		var_20_13.projectName = var_20_0

		var_20_10(var_20_9, var_20_11, var_20_12, var_20_13)

		return
	end)

	return
end

function var_0_1.BindItemBattle(arg_21_0)
	arg_21_0:InitFacilityCross(arg_21_0._map, arg_21_0._upper, "tebiezuozhan", function()
		getProxy = var_2_10000
		ChapterProxy = var_2_10002

		local var_22_0 = var_2_10000(var_2_10002)
		local var_22_1, var_22_2 = var_0.getLastMapForActivity(var_22_0)

		if var_22_1 then
			local var_22_3 = var_0:getMapById(var_22_1)

			if not var_22_0.isUnlock(var_22_3) then
				pg = var_22_0

				local var_22_4 = var_22_0.TipsMgr.GetInstance()
				local var_22_5 = var_3.ShowTips

				i18n = var_2_10006

				var_22_5(var_22_4, var_2_10006("common_activity_end"))
			else
				local var_22_6 = arg_21_0
				local var_22_7 = var_3.emit

				BackHillMediatorTemplate = var_2_10006

				local var_22_8 = var_2_10006.GO_SCENE

				SCENE = var_2_10007

				var_22_7(var_22_6, var_22_8, var_2_10007.LEVEL, {
					chapterId = var_22_2,
					mapIdx = var_22_1
				})
			end

			return
		end
	end)

	return
end

function var_0_1.UpdateBuildingTip(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_1 then
		return false
	end

	local var_23_0 = arg_23_1:GetBuildingLevel(arg_23_2)

	pg = var_1_10004

	if not var_1_10004.activity_event_building[arg_23_2] or var_23_0 >= #var_4.buff then
		return false
	end

	local var_23_1 = var_4.material[var_23_0]

	_ = var_6

	return var_6.all(var_23_1, function(arg_24_0)
		local var_24_0 = arg_24_0[1]
		local var_24_1 = arg_24_0[2]
		local var_24_2 = arg_24_0[3]
		local var_24_3 = 0

		DROP_TYPE_VITEM = var_2_10005

		if var_24_0 == var_2_10005 then
			AcessWithinNull = var_2_10005
			Item = var_2_10007
			var_2_10005 = var_2_10005(var_2_10007.getConfigData(var_24_1), "link_id")
			assert = var_2_10006

			var_2_10006(var_2_10005 == arg_23_1.id)

			local var_24_4 = arg_23_1

			var_24_3 = var_2_10006.GetMaterialCount(var_24_4, var_24_1)
		else
			DROP_TYPE_USE_ACTIVITY_DROP = var_2_10005

			if var_2_10005 < var_24_0 then
				AcessWithinNull = var_2_10005
				pg = var_2_10007

				local var_24_5 = var_2_10005(var_2_10007.activity_drop_type[var_24_0], "activity_id")

				assert = var_2_10006

				var_2_10006(var_24_5)

				getProxy = var_2_10006
				ActivityProxy = var_8

				local var_24_6 = var_2_10006(var_8)
				local var_24_7 = var_6.getActivityById(var_24_6, var_24_5)

				bagAct = bagAct
				var_24_3 = var_6:getVitemNumber(var_24_1)
			end
		end

		return var_24_2 <= var_24_3
	end)
end

function var_0_1.UpdateView(arg_25_0)
	return
end

return var_0_1
