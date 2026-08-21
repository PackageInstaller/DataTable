local var_0_0 = class("BackHillTemplate", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return arg_1_0.UIName
end

function var_0_0.init(arg_2_0)
	arg_2_0.loader = AutoLoader.New()

	return
end

function var_0_0.willExit(arg_3_0)
	arg_3_0.loader:Clear()

	return
end

function var_0_0.InitFacility(arg_4_0, arg_4_1, arg_4_2)
	onButton(arg_4_0, arg_4_1, arg_4_2)
	onButton(arg_4_0, arg_4_1:Find("button"), arg_4_2)

	return
end

function var_0_0.InitFacilityCross(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	onButton(arg_5_0, arg_5_1:Find(arg_5_3), arg_5_4, SFX_PANEL)
	onButton(arg_5_0, arg_5_2:Find(arg_5_3), arg_5_4, SFX_PANEL)

	return
end

function var_0_0.getStudents(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = getProxy(ActivityProxy):getActivityById(arg_6_0)

	if not var_6_0 then
		return {}
	end

	local var_6_1 = var_6_0:getConfig("config_client")

	var_6_1 = var_6_1 and var_6_1.ships

	if var_6_1 then
		local var_6_2 = Clone(var_6_1)
		local var_6_3 = math.random(arg_6_1, arg_6_2)

		while var_6_3 > 0 and #var_6_2 > 0 do
			local var_6_4 = math.random(1, #var_6_2)

			table.insert({}, var_6_2[var_6_4])

			var_6_2[var_6_4] = var_6_2[#var_6_2]
			var_6_3 = var_6_3 - 1
		end
	end

	return {}
end

function var_0_0.InitStudents(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = var_0_0.getStudents(arg_7_1, arg_7_2, arg_7_3)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.graphPath.points) do
		if not iter_7_1.outRandom then
			table.insert({}, iter_7_1)
		end
	end

	arg_7_0.academyStudents = {}

	for iter_7_2, iter_7_3 in pairs(var_7_0) do
		local var_7_3

		if not arg_7_0.academyStudents[iter_7_2] then
			local var_7_1 = cloneTplTo(arg_7_0._shipTpl, arg_7_0._map)

			var_7_1.gameObject.name = iter_7_2

			local var_7_2 = arg_7_0.ChooseRandomPos({}, #{})

			var_7_3 = (#{} - 2) % #{} + 1

			local var_7_4 = SummerFeastNavigationAgent.New(var_7_1.gameObject, true)

			var_7_4:attach()
			var_7_4:setPathFinder(arg_7_0.graphPath)
			var_7_4:SetPositionTable({})
			var_7_4:setCurrentIndex(var_7_2 and var_7_2.id)
			var_7_4:SetOnTransEdge(function(arg_8_0, arg_8_1, arg_8_2)
				arg_8_2 = math.max(arg_8_1, arg_8_2)
				arg_8_1 = math.min(arg_8_1, arg_8_2)

				local var_8_0 = arg_7_0.edge2area[arg_8_1 .. "_" .. arg_8_2] or arg_7_0.edge2area.default

				arg_8_0._tf:SetParent(arg_7_0[var_8_0])

				return
			end)
			var_7_4:updateStudent(iter_7_3)

			arg_7_0.academyStudents[iter_7_2] = var_7_4
		end
	end

	if #var_7_0 > 0 then
		arg_7_0.sortTimer = Timer.New(function()
			arg_7_0:sortStudents()

			return
		end, 0.2, -1)

		arg_7_0.sortTimer:Start()
		arg_7_0.sortTimer.func()
	end

	return
end

function var_0_0.ChooseRandomPos(arg_10_0, arg_10_1)
	local var_10_0 = math.random(1, arg_10_1)

	if not var_10_0 then
		return nil
	end

	pg.Tool.Swap(arg_10_0, var_10_0, arg_10_1)

	return arg_10_0[arg_10_1]
end

function var_0_0.sortStudents(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.containers) do
		if iter_11_1.childCount > 1 then
			for iter_11_2 = 1, iter_11_1.childCount do
				table.insert({}, {
					tf = iter_11_1:GetChild(iter_11_2 - 1),
					index = iter_11_2
				})
			end

			table.sort({}, function(arg_12_0, arg_12_1)
				local var_12_0 = arg_12_0.tf.anchoredPosition.y - arg_12_1.tf.anchoredPosition.y

				if math.abs(arg_12_0.tf.anchoredPosition.y - arg_12_1.tf.anchoredPosition.y) < 1 then
					return arg_12_0.index < arg_12_1.index
				else
					return var_12_0 > 0
				end

				return
			end)

			for iter_11_3, iter_11_4 in ipairs({}) do
				iter_11_4.tf:SetSiblingIndex(iter_11_3 - 1)
			end
		end
	end

	return
end

function var_0_0.clearStudents(arg_13_0)
	if arg_13_0.sortTimer then
		arg_13_0.sortTimer:Stop()

		arg_13_0.sortTimer = nil
	end

	if arg_13_0.academyStudents then
		for iter_13_0, iter_13_1 in pairs(arg_13_0.academyStudents) do
			iter_13_1:detach()
			Destroy(iter_13_1._go)
		end

		table.clear(arg_13_0.academyStudents)
	end

	return
end

function var_0_0.AutoFitScreen(arg_14_0)
	local var_14_0 = 1.7777777777777777 <= Screen.width / Screen.height and math.clamp(1080 * (Screen.width / Screen.height) / arg_14_0._map.rect.width, 1, 2) or math.clamp(0 / (Screen.width / Screen.height) / arg_14_0._map.rect.height, 1, 2)

	setLocalScale(arg_14_0._map, {
		x = var_14_0,
		y = var_14_0,
		z = var_14_0
	})
	setLocalScale(arg_14_0._upper, {
		x = var_14_0,
		y = var_14_0,
		z = var_14_0
	})

	return
end

function var_0_0.IsMiniActNeedTip(arg_15_0)
	local var_15_0 = getProxy(ActivityProxy):getActivityById(arg_15_0)

	assert(var_15_0)

	return Activity.IsActivityReady(var_15_0)
end

function var_0_0.UpdateActivity(arg_16_0, arg_16_1)
	return
end

function var_0_0.BindItemActivityShop(arg_17_0)
	arg_17_0:InitFacilityCross(arg_17_0._map, arg_17_0._upper, "bujishangdian", function()
		arg_17_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)

	return
end

function var_0_0.BindItemSkinShop(arg_19_0)
	arg_19_0:InitFacilityCross(arg_19_0._map, arg_19_0._upper, "huanzhuangshangdian", function()
		arg_19_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SKINSHOP)

		return
	end)

	return
end

function var_0_0.BindItemBuildShip(arg_21_0)
	arg_21_0:InitFacilityCross(arg_21_0._map, arg_21_0._upper, "xianshijianzao", function()
		local var_22_0
		local var_22_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDSHIP_1)
		local var_22_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILD)

		if var_22_1 and not var_22_1:isEnd() then
			var_22_0 = BuildShipScene.PROJECTS.ACTIVITY
		elseif var_22_2 and not var_22_2:isEnd() then
			var_22_0 = ({
				BuildShipScene.PROJECTS.SPECIAL,
				BuildShipScene.PROJECTS.LIGHT,
				BuildShipScene.PROJECTS.HEAVY
			})[var_22_2:getConfig("config_client").id]
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_21_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = var_22_0
		})

		return
	end)

	return
end

function var_0_0.BindItemBattle(arg_23_0)
	arg_23_0:InitFacilityCross(arg_23_0._map, arg_23_0._upper, "tebiezuozhan", function()
		local var_24_0 = getProxy(ChapterProxy)
		local var_24_1, var_24_2 = var_24_0:getLastMapForActivity()

		if var_24_1 then
			if not var_24_0:getMapById(var_24_1):isUnlock() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
			else
				arg_23_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.LEVEL, {
					chapterId = var_24_2,
					mapIdx = var_24_1
				})
			end

			return
		end
	end)

	return
end

function var_0_0.UpdateBuildingTip(arg_25_0, arg_25_1, arg_25_2)
	if not arg_25_1 then
		return false
	end

	local var_25_0 = arg_25_1:GetBuildingLevel(arg_25_2)

	if not pg.activity_event_building[arg_25_2] or var_25_0 >= #pg.activity_event_building[arg_25_2].buff then
		return false
	end

	return _.all(pg.activity_event_building[arg_25_2].material[var_25_0], function(arg_26_0)
		local var_26_0 = arg_26_0[2]
		local var_26_1 = arg_26_0[3]
		local var_26_2 = 0

		if arg_26_0[1] == DROP_TYPE_VITEM then
			assert(AcessWithinNull(Item.getConfigData(var_26_0), "link_id") == arg_25_1.id)

			var_26_2 = arg_25_1:GetMaterialCount(var_26_0)
		elseif arg_26_0[1] > DROP_TYPE_USE_ACTIVITY_DROP then
			local var_26_3 = AcessWithinNull(pg.activity_drop_type[arg_26_0[1]], "activity_id")

			assert(var_26_3)

			bagAct = getProxy(ActivityProxy):getActivityById(var_26_3)
			var_26_2 = bagAct:getVitemNumber(var_26_0)
		end

		return var_26_1 <= var_26_2
	end)
end

function var_0_0.UpdateView(arg_27_0)
	return
end

return var_0_0
