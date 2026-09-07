local CoreActivityBackHillTemplate = class("CoreActivityBackHillTemplate", import("view.activity.CorePage.CoreActivityPage"))

function CoreActivityBackHillTemplate:OnInit()
	self.loader = AutoLoader.New()

	return
end

function CoreActivityBackHillTemplate:InitFacility(arg_2_1, arg_2_2)
	onButton(self, arg_2_1, arg_2_2)
	onButton(self, arg_2_1:Find("button"), arg_2_2)

	return
end

function CoreActivityBackHillTemplate:InitFacilityCross(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	onButton(self, arg_3_1:Find(arg_3_3), arg_3_4, SFX_PANEL)
	onButton(self, arg_3_2:Find(arg_3_3), arg_3_4, SFX_PANEL)

	return
end

function CoreActivityBackHillTemplate:getStudents(arg_4_1, arg_4_2)
	local var_4_0 = {}
	local var_4_1 = getProxy(ActivityProxy):getActivityById(self)

	if not var_4_1 then
		return var_4_0
	end

	local var_4_2 = var_4_1:getConfig("config_client")

	var_4_2 = var_4_2 and var_4_2.ships

	if var_4_2 then
		local var_4_3 = Clone(var_4_2)
		local var_4_4 = math.random(arg_4_1, arg_4_2)

		while var_4_4 > 0 and #var_4_3 > 0 do
			local var_4_5 = math.random(1, #var_4_3)

			table.insert(var_4_0, var_4_3[var_4_5])

			var_4_3[var_4_5] = var_4_3[#var_4_3]
			var_4_4 = var_4_4 - 1
		end
	end

	return var_4_0
end

function CoreActivityBackHillTemplate:InitStudents(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = CoreActivityBackHillTemplate.getStudents(arg_5_1, arg_5_2, arg_5_3)
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in pairs(self.graphPath.points) do
		if not iter_5_1.outRandom then
			table.insert(var_5_1, iter_5_1)
		end
	end

	self.academyStudents = {}

	local var_5_2 = {}

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		if not self.academyStudents[iter_5_2] then
			local var_5_3 = cloneTplTo(self._shipTpl, self._map)

			var_5_3.gameObject.name = iter_5_2

			local var_5_4 = self.ChooseRandomPos(var_5_1, #var_5_1)
			local var_5_6 = SummerFeastNavigationAgent.New(var_5_3.gameObject)

			var_5_6:attach()
			var_5_6:setPathFinder(self.graphPath)
			var_5_6:SetPositionTable(var_5_2)
			var_5_6:setCurrentIndex(var_5_4 and var_5_4.id)
			var_5_6:SetOnTransEdge(function(arg_6_0, arg_6_1, arg_6_2)
				arg_6_2 = math.max(arg_6_1, arg_6_2)
				arg_6_1 = math.min(arg_6_1, arg_6_2)

				arg_6_0._tf:SetParent(self[self.edge2area[arg_6_1 .. "_" .. arg_6_2] or self.edge2area.default])

				return
			end)
			var_5_6:updateStudent(iter_5_3)

			self.academyStudents[iter_5_2] = var_5_6
		end
	end

	if #var_5_0 > 0 then
		self.sortTimer = Timer.New(function()
			self:sortStudents()

			return
		end, 0.2, -1)

		self.sortTimer:Start()
		self.sortTimer.func()
	end

	return
end

function CoreActivityBackHillTemplate:ChooseRandomPos(arg_8_1)
	local var_8_0 = math.random(1, arg_8_1)

	if not var_8_0 then
		return nil
	end

	pg.Tool.Swap(self, var_8_0, arg_8_1)

	return self[arg_8_1]
end

function CoreActivityBackHillTemplate:sortStudents()
	for iter_9_0, iter_9_1 in pairs(self.containers) do
		if iter_9_1.childCount > 1 then
			local var_9_0 = {}

			for iter_9_2 = 1, iter_9_1.childCount do
				table.insert(var_9_0, {
					tf = iter_9_1:GetChild(iter_9_2 - 1),
					index = iter_9_2
				})
			end

			table.sort(var_9_0, function(arg_10_0, arg_10_1)
				local var_10_0 = arg_10_0.tf.anchoredPosition.y - arg_10_1.tf.anchoredPosition.y

				if math.abs(arg_10_0.tf.anchoredPosition.y - arg_10_1.tf.anchoredPosition.y) < 1 then
					return arg_10_0.index < arg_10_1.index
				else
					return var_10_0 > 0
				end

				return
			end)

			for iter_9_3, iter_9_4 in ipairs(var_9_0) do
				iter_9_4.tf:SetSiblingIndex(iter_9_3 - 1)
			end
		end
	end

	return
end

function CoreActivityBackHillTemplate:clearStudents()
	if self.sortTimer then
		self.sortTimer:Stop()

		self.sortTimer = nil
	end

	if self.academyStudents then
		for iter_11_0, iter_11_1 in pairs(self.academyStudents) do
			iter_11_1:detach()
			Destroy(iter_11_1._go)
		end

		table.clear(self.academyStudents)
	end

	return
end

function CoreActivityBackHillTemplate:AutoFitScreen()
	local var_12_0 = 1.7777777777777777 <= Screen.width / Screen.height and math.clamp(1080 * (Screen.width / Screen.height) / self._map.rect.width, 1, 2) or math.clamp(0 / (Screen.width / Screen.height) / self._map.rect.height, 1, 2)

	setLocalScale(self._map, {
		x = var_12_0,
		y = var_12_0,
		z = var_12_0
	})
	setLocalScale(self._upper, {
		x = var_12_0,
		y = var_12_0,
		z = var_12_0
	})

	return
end

function CoreActivityBackHillTemplate:IsMiniActNeedTip()
	local var_13_0 = getProxy(ActivityProxy):getActivityById(self)

	assert(var_13_0)

	return Activity.IsActivityReady(var_13_0)
end

function CoreActivityBackHillTemplate:UpdateActivity(arg_14_1)
	return
end

function CoreActivityBackHillTemplate:BindItemActivityShop()
	self:InitFacilityCross(self._map, self._upper, "bujishangdian", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)

	return
end

function CoreActivityBackHillTemplate:BindItemSkinShop()
	self:InitFacilityCross(self._map, self._upper, "huanzhuangshangdian", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SKINSHOP)

		return
	end)

	return
end

function CoreActivityBackHillTemplate:BindItemBuildShip()
	self:InitFacilityCross(self._map, self._upper, "xianshijianzao", function()
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

		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = var_20_0
		})

		return
	end)

	return
end

function CoreActivityBackHillTemplate:BindItemBattle()
	self:InitFacilityCross(self._map, self._upper, "tebiezuozhan", function()
		local var_22_0 = getProxy(ChapterProxy)
		local var_22_1, var_22_2 = var_22_0:getLastMapForActivity()

		if var_22_1 then
			if not var_22_0:getMapById(var_22_1):isUnlock() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				goto label_22_0
			end
		end

		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.LEVEL, {
			chapterId = var_22_2,
			mapIdx = var_22_1
		})

		::label_22_0::

		return
	end)

	return
end

function CoreActivityBackHillTemplate:UpdateBuildingTip(arg_23_1, arg_23_2)
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

function CoreActivityBackHillTemplate:UpdateView()
	return
end

return CoreActivityBackHillTemplate
