local BackHillTemplate = class("BackHillTemplate", import("view.base.BaseUI"))

function BackHillTemplate:getUIName()
	return self.UIName
end

function BackHillTemplate:init()
	self.loader = AutoLoader.New()

	return
end

function BackHillTemplate:willExit()
	self.loader:Clear()

	return
end

function BackHillTemplate:InitFacility(arg_4_1, arg_4_2)
	onButton(self, arg_4_1, arg_4_2)
	onButton(self, arg_4_1:Find("button"), arg_4_2)

	return
end

function BackHillTemplate:InitFacilityCross(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	onButton(self, arg_5_1:Find(arg_5_3), arg_5_4, SFX_PANEL)
	onButton(self, arg_5_2:Find(arg_5_3), arg_5_4, SFX_PANEL)

	return
end

function BackHillTemplate:getStudents(arg_6_1, arg_6_2)
	local var_6_0 = {}
	local var_6_1 = getProxy(ActivityProxy):getActivityById(self)

	if not var_6_1 then
		return var_6_0
	end

	local var_6_2 = var_6_1:getConfig("config_client")

	var_6_2 = var_6_2 and var_6_2.ships

	if var_6_2 then
		local var_6_3 = Clone(var_6_2)
		local var_6_4 = math.random(arg_6_1, arg_6_2)

		while var_6_4 > 0 and #var_6_3 > 0 do
			local var_6_5 = math.random(1, #var_6_3)

			table.insert(var_6_0, var_6_3[var_6_5])

			var_6_3[var_6_5] = var_6_3[#var_6_3]
			var_6_4 = var_6_4 - 1
		end
	end

	return var_6_0
end

function BackHillTemplate:InitStudents(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = BackHillTemplate.getStudents(arg_7_1, arg_7_2, arg_7_3)
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in pairs(self.graphPath.points) do
		if not iter_7_1.outRandom then
			table.insert(var_7_1, iter_7_1)
		end
	end

	self.academyStudents = {}

	local var_7_2 = {}

	for iter_7_2, iter_7_3 in pairs(var_7_0) do
		if not self.academyStudents[iter_7_2] then
			local var_7_3 = cloneTplTo(self._shipTpl, self._map)

			var_7_3.gameObject.name = iter_7_2

			local var_7_4 = self.ChooseRandomPos(var_7_1, #var_7_1)
			local var_7_6 = SummerFeastNavigationAgent.New(var_7_3.gameObject, true)

			var_7_6:attach()
			var_7_6:setPathFinder(self.graphPath)
			var_7_6:SetPositionTable(var_7_2)
			var_7_6:setCurrentIndex(var_7_4 and var_7_4.id)
			var_7_6:SetOnTransEdge(function(arg_8_0, arg_8_1, arg_8_2)
				arg_8_2 = math.max(arg_8_1, arg_8_2)
				arg_8_1 = math.min(arg_8_1, arg_8_2)

				arg_8_0._tf:SetParent(self[self.edge2area[arg_8_1 .. "_" .. arg_8_2] or self.edge2area.default])

				return
			end)
			var_7_6:updateStudent(iter_7_3)

			self.academyStudents[iter_7_2] = var_7_6
		end
	end

	if #var_7_0 > 0 then
		self.sortTimer = Timer.New(function()
			self:sortStudents()

			return
		end, 0.2, -1)

		self.sortTimer:Start()
		self.sortTimer.func()
	end

	return
end

function BackHillTemplate:ChooseRandomPos(arg_10_1)
	local var_10_0 = math.random(1, arg_10_1)

	if not var_10_0 then
		return nil
	end

	pg.Tool.Swap(self, var_10_0, arg_10_1)

	return self[arg_10_1]
end

function BackHillTemplate:sortStudents()
	for iter_11_0, iter_11_1 in pairs(self.containers) do
		if iter_11_1.childCount > 1 then
			local var_11_0 = {}

			for iter_11_2 = 1, iter_11_1.childCount do
				table.insert(var_11_0, {
					tf = iter_11_1:GetChild(iter_11_2 - 1),
					index = iter_11_2
				})
			end

			table.sort(var_11_0, function(arg_12_0, arg_12_1)
				local var_12_0 = arg_12_0.tf.anchoredPosition.y - arg_12_1.tf.anchoredPosition.y

				if math.abs(arg_12_0.tf.anchoredPosition.y - arg_12_1.tf.anchoredPosition.y) < 1 then
					return arg_12_0.index < arg_12_1.index
				else
					return var_12_0 > 0
				end

				return
			end)

			for iter_11_3, iter_11_4 in ipairs(var_11_0) do
				iter_11_4.tf:SetSiblingIndex(iter_11_3 - 1)
			end
		end
	end

	return
end

function BackHillTemplate:clearStudents()
	if self.sortTimer then
		self.sortTimer:Stop()

		self.sortTimer = nil
	end

	if self.academyStudents then
		for iter_13_0, iter_13_1 in pairs(self.academyStudents) do
			iter_13_1:detach()
			Destroy(iter_13_1._go)
		end

		table.clear(self.academyStudents)
	end

	return
end

function BackHillTemplate:AutoFitScreen()
	local var_14_0 = 1.7777777777777777 <= Screen.width / Screen.height and math.clamp(1080 * (Screen.width / Screen.height) / self._map.rect.width, 1, 2) or math.clamp(0 / (Screen.width / Screen.height) / self._map.rect.height, 1, 2)

	setLocalScale(self._map, {
		x = var_14_0,
		y = var_14_0,
		z = var_14_0
	})
	setLocalScale(self._upper, {
		x = var_14_0,
		y = var_14_0,
		z = var_14_0
	})

	return
end

function BackHillTemplate:IsMiniActNeedTip()
	local var_15_0 = getProxy(ActivityProxy):getActivityById(self)

	assert(var_15_0)

	return Activity.IsActivityReady(var_15_0)
end

function BackHillTemplate:UpdateActivity(arg_16_1)
	return
end

function BackHillTemplate:BindItemActivityShop()
	self:InitFacilityCross(self._map, self._upper, "bujishangdian", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)

	return
end

function BackHillTemplate:BindItemSkinShop()
	self:InitFacilityCross(self._map, self._upper, "huanzhuangshangdian", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SKINSHOP)

		return
	end)

	return
end

function BackHillTemplate:BindItemBuildShip()
	self:InitFacilityCross(self._map, self._upper, "xianshijianzao", function()
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

		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = var_22_0
		})

		return
	end)

	return
end

function BackHillTemplate:BindItemBattle()
	self:InitFacilityCross(self._map, self._upper, "tebiezuozhan", function()
		local var_24_0 = getProxy(ChapterProxy)
		local var_24_1, var_24_2 = var_24_0:getLastMapForActivity()

		if var_24_1 then
			if not var_24_0:getMapById(var_24_1):isUnlock() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				goto label_24_0
			end
		end

		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.LEVEL, {
			chapterId = var_24_2,
			mapIdx = var_24_1
		})

		::label_24_0::

		return
	end)

	return
end

function BackHillTemplate:UpdateBuildingTip(arg_25_1, arg_25_2)
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

function BackHillTemplate:UpdateView()
	return
end

return BackHillTemplate
