local var_0_0 = class("CoreActivityBackHillTemplate", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.loader = AutoLoader.New()

	return
end

function var_0_0.InitFacility(arg_2_0, arg_2_1, arg_2_2)
	onButton(arg_2_0, arg_2_1, arg_2_2)
	onButton(arg_2_0, arg_2_1:Find("button"), arg_2_2)

	return
end

function var_0_0.InitFacilityCross(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	onButton(arg_3_0, arg_3_1:Find(arg_3_3), arg_3_4, SFX_PANEL)
	onButton(arg_3_0, arg_3_2:Find(arg_3_3), arg_3_4, SFX_PANEL)

	return
end

function var_0_0.getStudents(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = getProxy(ActivityProxy):getActivityById(arg_4_0)

	if not var_4_0 then
		return {}
	end

	local var_4_1 = var_4_0:getConfig("config_client")

	var_4_1 = var_4_1 and var_4_1.ships

	if var_4_1 then
		local var_4_2 = Clone(var_4_1)
		local var_4_3 = math.random(arg_4_1, arg_4_2)

		while var_4_3 > 0 and #var_4_2 > 0 do
			local var_4_4 = math.random(1, #var_4_2)

			table.insert({}, var_4_2[var_4_4])

			var_4_2[var_4_4] = var_4_2[#var_4_2]
			var_4_3 = var_4_3 - 1
		end
	end

	return {}
end

function var_0_0.InitStudents(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = var_0_0.getStudents(arg_5_1, arg_5_2, arg_5_3)

	for iter_5_0, iter_5_1 in pairs(arg_5_0.graphPath.points) do
		if not iter_5_1.outRandom then
			table.insert({}, iter_5_1)
		end
	end

	arg_5_0.academyStudents = {}

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		local var_5_3

		if not arg_5_0.academyStudents[iter_5_2] then
			local var_5_1 = cloneTplTo(arg_5_0._shipTpl, arg_5_0._map)

			var_5_1.gameObject.name = iter_5_2

			local var_5_2 = arg_5_0.ChooseRandomPos({}, #{})

			var_5_3 = (#{} - 2) % #{} + 1

			local var_5_4 = SummerFeastNavigationAgent.New(var_5_1.gameObject)

			var_5_4:attach()
			var_5_4:setPathFinder(arg_5_0.graphPath)
			var_5_4:SetPositionTable({})
			var_5_4:setCurrentIndex(var_5_2 and var_5_2.id)
			var_5_4:SetOnTransEdge(function(arg_6_0, arg_6_1, arg_6_2)
				arg_6_2 = math.max(arg_6_1, arg_6_2)
				arg_6_1 = math.min(arg_6_1, arg_6_2)

				local var_6_0 = arg_5_0.edge2area[arg_6_1 .. "_" .. arg_6_2] or arg_5_0.edge2area.default

				arg_6_0._tf:SetParent(arg_5_0[var_6_0])

				return
			end)
			var_5_4:updateStudent(iter_5_3)

			arg_5_0.academyStudents[iter_5_2] = var_5_4
		end
	end

	if #var_5_0 > 0 then
		arg_5_0.sortTimer = Timer.New(function()
			arg_5_0:sortStudents()

			return
		end, 0.2, -1)

		arg_5_0.sortTimer:Start()
		arg_5_0.sortTimer.func()
	end

	return
end

function var_0_0.ChooseRandomPos(arg_8_0, arg_8_1)
	local var_8_0 = math.random(1, arg_8_1)

	if not var_8_0 then
		return nil
	end

	pg.Tool.Swap(arg_8_0, var_8_0, arg_8_1)

	return arg_8_0[arg_8_1]
end

function var_0_0.sortStudents(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.containers) do
		if iter_9_1.childCount > 1 then
			for iter_9_2 = 1, iter_9_1.childCount do
				table.insert({}, {
					tf = iter_9_1:GetChild(iter_9_2 - 1),
					index = iter_9_2
				})
			end

			table.sort({}, function(arg_10_0, arg_10_1)
				local var_10_0 = arg_10_0.tf.anchoredPosition.y - arg_10_1.tf.anchoredPosition.y

				if math.abs(arg_10_0.tf.anchoredPosition.y - arg_10_1.tf.anchoredPosition.y) < 1 then
					return arg_10_0.index < arg_10_1.index
				else
					return var_10_0 > 0
				end

				return
			end)

			for iter_9_3, iter_9_4 in ipairs({}) do
				iter_9_4.tf:SetSiblingIndex(iter_9_3 - 1)
			end
		end
	end

	return
end

function var_0_0.clearStudents(arg_11_0)
	if arg_11_0.sortTimer then
		arg_11_0.sortTimer:Stop()

		arg_11_0.sortTimer = nil
	end

	if arg_11_0.academyStudents then
		for iter_11_0, iter_11_1 in pairs(arg_11_0.academyStudents) do
			iter_11_1:detach()
			Destroy(iter_11_1._go)
		end

		table.clear(arg_11_0.academyStudents)
	end

	return
end

function var_0_0.AutoFitScreen(arg_12_0)
	local var_12_0 = 1.7777777777777777 <= Screen.width / Screen.height and math.clamp(1080 * (Screen.width / Screen.height) / arg_12_0._map.rect.width, 1, 2) or math.clamp(0 / (Screen.width / Screen.height) / arg_12_0._map.rect.height, 1, 2)

	setLocalScale(arg_12_0._map, {
		x = var_12_0,
		y = var_12_0,
		z = var_12_0
	})
	setLocalScale(arg_12_0._upper, {
		x = var_12_0,
		y = var_12_0,
		z = var_12_0
	})

	return
end

function var_0_0.IsMiniActNeedTip(arg_13_0)
	local var_13_0 = getProxy(ActivityProxy):getActivityById(arg_13_0)

	assert(var_13_0)

	return Activity.IsActivityReady(var_13_0)
end

function var_0_0.UpdateActivity(arg_14_0, arg_14_1)
	return
end

function var_0_0.BindItemActivityShop(arg_15_0)
	arg_15_0:InitFacilityCross(arg_15_0._map, arg_15_0._upper, "bujishangdian", function()
		arg_15_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)

	return
end

function var_0_0.BindItemSkinShop(arg_17_0)
	arg_17_0:InitFacilityCross(arg_17_0._map, arg_17_0._upper, "huanzhuangshangdian", function()
		arg_17_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SKINSHOP)

		return
	end)

	return
end

function var_0_0.BindItemBuildShip(arg_19_0)
	arg_19_0:InitFacilityCross(arg_19_0._map, arg_19_0._upper, "xianshijianzao", function()
		local var_20_0
		local var_20_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDSHIP_1)
		local var_20_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILD)

		if var_20_1 and not var_20_1:isEnd() then
			var_20_0 = BuildShipScene.PROJECTS.ACTIVITY
		elseif var_20_2 and not var_20_2:isEnd() then
			var_20_0 = ({
				BuildShipScene.PROJECTS.SPECIAL,
				BuildShipScene.PROJECTS.LIGHT,
				BuildShipScene.PROJECTS.HEAVY
			})[var_20_2:getConfig("config_client").id]
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_19_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = var_20_0
		})

		return
	end)

	return
end

function var_0_0.BindItemBattle(arg_21_0)
	arg_21_0:InitFacilityCross(arg_21_0._map, arg_21_0._upper, "tebiezuozhan", function()
		local var_22_0 = getProxy(ChapterProxy)
		local var_22_1, var_22_2 = var_22_0:getLastMapForActivity()

		if var_22_1 then
			if not var_22_0:getMapById(var_22_1):isUnlock() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
			else
				arg_21_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.LEVEL, {
					chapterId = var_22_2,
					mapIdx = var_22_1
				})
			end

			return
		end
	end)

	return
end

function var_0_0.UpdateBuildingTip(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_1 then
		return false
	end

	local var_23_0 = arg_23_1:GetBuildingLevel(arg_23_2)

	if not pg.activity_event_building[arg_23_2] or var_23_0 >= #pg.activity_event_building[arg_23_2].buff then
		return false
	end

	return _.all(pg.activity_event_building[arg_23_2].material[var_23_0], function(arg_24_0)
		local var_24_0 = arg_24_0[2]
		local var_24_1 = arg_24_0[3]
		local var_24_2 = 0

		if arg_24_0[1] == DROP_TYPE_VITEM then
			assert(AcessWithinNull(Item.getConfigData(var_24_0), "link_id") == arg_23_1.id)

			var_24_2 = arg_23_1:GetMaterialCount(var_24_0)
		elseif arg_24_0[1] > DROP_TYPE_USE_ACTIVITY_DROP then
			local var_24_3 = AcessWithinNull(pg.activity_drop_type[arg_24_0[1]], "activity_id")

			assert(var_24_3)

			bagAct = getProxy(ActivityProxy):getActivityById(var_24_3)
			var_24_2 = bagAct:getVitemNumber(var_24_0)
		end

		return var_24_1 <= var_24_2
	end)
end

function var_0_0.UpdateView(arg_25_0)
	return
end

return var_0_0
