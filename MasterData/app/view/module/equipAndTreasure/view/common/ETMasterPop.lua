local var_0_0 = g.core.const.ConstMgr.EquipConst
local var_0_1 = g.core.config.enhance_master_info
local var_0_2 = g.core.model.User.equipmentData
local var_0_3 = g.core.model.User.treasureData
local ETMasterPop = class("ETMasterPop", require("app.fairyGUI.equipAndTreasure.UI_ETMasterPop"), function()
	return fgui.GComponent:create({
		resName = "ETMasterPop",
		pkgPath = "ui/equipAndTreasure/equipAndTreasure",
		pkgName = "equipAndTreasure"
	})
end)

function ETMasterPop:ctor(arg_2_1, arg_2_2, arg_2_3)
	self._id = 0
	self._type = 0
	self._curTab = 0
	self._knightIndex = arg_2_1
	self._equipData = {}
	self._treasureData = {}
	self._isSwearEquip = arg_2_2
	self._isSwearTreasure = arg_2_3
	self._isFullLevel = false

	self:getView():center(true)
	self.m_strengthBtn:addClickListener(handler(self, self._onTouchStrength))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabChanged))
end

function ETMasterPop:onLoad()
	self:_initView()
end

function ETMasterPop:_initView()
	if not self._isSwearEquip then
		self._curTab = 2

		self.m_tabController:setSelectedIndex(2)
	end

	self._curTab = self.m_tabController:getSelectedIndex()
	self._type = self.m_tabController:getSelectedIndex() + 1

	self.m_showResonanceController:setSelectedIndex(self:_needShowResonance() and 1 or 0)
	self:_updateView()
end

function ETMasterPop:_needShowResonance()
	return (g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_RESONANCE))
end

function ETMasterPop:_updateView()
	self._id = 0

	if self._type == 3 or self._type == 4 then
		self:_updateTreasureView()
	elseif self._type == 5 then
		self:_updateResonanceView()
	else
		self:_updateEquipView()
	end

	self:_updateButton()
end

function ETMasterPop:_updateTreasureView()
	if self._isSwearTreasure then
		self._treasureData = {}

		local var_7_0 = self:_setStrengthenData((self:_getMinLv()))

		for iter_7_0 = 1, 2 do
			local var_7_1 = var_0_3:getTreasureDataByPos(self._knightIndex * 2 + iter_7_0)

			self["m_item" .. iter_7_0]:updateView(self._type, iter_7_0, var_7_1, var_7_0.value, self._isFullLevel)
			table.insert(self._treasureData, var_7_1)
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(201520))
	end
end

function ETMasterPop:_updateEquipView()
	if self._isSwearEquip then
		self._equipData = {}

		local var_8_0 = self:_setStrengthenData((self:_getMinLv()))

		for iter_8_0 = 1, 4 do
			local var_8_1 = var_0_2:getEquipDataByPos(self._knightIndex * 4 + iter_8_0):getServerData()

			self["m_item" .. iter_8_0]:updateView(self._type, iter_8_0, var_8_1, var_8_0.value, self._isFullLevel)
			table.insert(self._equipData, var_8_1)
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(201519))
	end
end

function ETMasterPop:_onTabChanged()
	local var_9_0 = self.m_tabController:getSelectedIndex()

	if not self._isSwearEquip and (var_9_0 < 2 or var_9_0 == 4) then
		g.core.module.ModuleManager:tip(g.core.lang:get(201519))

		if self._curTab ~= var_9_0 then
			self.m_tabController:setSelectedIndex(self._curTab)
		end

		return
	end

	if not self._isSwearTreasure and (var_9_0 == 2 or var_9_0 == 3) then
		g.core.module.ModuleManager:tip(g.core.lang:get(201520))

		if self._curTab ~= var_9_0 then
			self.m_tabController:setSelectedIndex(self._curTab)
		end

		return
	end

	self._isFullLevel = false
	self._curTab = var_9_0
	self._type = var_9_0 + 1

	self:_updateView()
end

function ETMasterPop:_getMinLv()
	local var_10_0 = {}

	if self._type < 3 then
		for iter_10_0 = 1, 4 do
			if var_0_2:isWornEquip(self._knightIndex * 4 + iter_10_0) then
				local var_10_1 = var_0_2:getEquipDataByPos(self._knightIndex * 4 + iter_10_0):getServerData()

				if self._type == 1 then
					table.insert(var_10_0, var_10_1.level)
				else
					table.insert(var_10_0, var_10_1.refining_level)
				end
			end
		end
	elseif self._type < 5 then
		for iter_10_1 = 1, 2 do
			if var_0_3:isHaveTreasurePos(self._knightIndex * 2 + iter_10_1) then
				local var_10_2 = var_0_3:getTreasureDataByPos(self._knightIndex * 2 + iter_10_1)

				if self._type == 3 then
					table.insert(var_10_0, var_10_2.level)
				else
					table.insert(var_10_0, var_10_2.refining_level)
				end
			end
		end
	elseif self._type == 5 then
		for iter_10_2 = 1, 4 do
			if var_0_2:isWornEquip(self._knightIndex * 4 + iter_10_2) then
				table.insert(var_10_0, var_0_2:getEquipDataByPos(self._knightIndex * 4 + iter_10_2):getServerData().resonance_level)
			end
		end
	end

	table.sort(var_10_0)

	return var_10_0[1]
end

function ETMasterPop:_setStrengthenData(arg_11_1)
	local var_11_0 = var_0_1.getLength()
	local var_11_1 = {}

	for iter_11_0 = 1, var_11_0 do
		local var_11_2 = var_0_1.indexOf(iter_11_0)

		if var_11_2.type == self._type and arg_11_1 < var_11_2.value then
			local var_11_3 = tonumber(string.sub(var_11_2.id, -3))

			var_11_1 = var_11_2.toObject()

			if var_11_3 > 1 then
				self._id = var_0_1.indexOf(iter_11_0 - 1).id
			end

			self:_updateAttrView(var_11_3, var_11_2)

			break
		end
	end

	if not next(var_11_1) then
		for iter_11_1 = 1, var_11_0 do
			local var_11_4 = var_0_1.indexOf(iter_11_1)

			if var_11_4.type == self._type and var_11_4.value == arg_11_1 then
				self._isFullLevel = true

				local var_11_5 = tonumber(string.sub(var_11_4.id, -3))

				var_11_1 = var_11_4

				if var_11_5 > 1 then
					self._id = var_0_1.indexOf(iter_11_1).id
				end

				self:_updateAttrView(var_11_5, var_11_4)

				break
			end
		end
	end

	return var_11_1
end

function ETMasterPop:_updateAttrView(arg_12_1, arg_12_2, arg_12_3)
	if self._isFullLevel then
		self.m_levelController:setSelectedIndex(1)
		self.m_curLevelComp:updateView({
			name = g.core.lang:get(var_12_0),
			level = arg_12_1
		})
	else
		self.m_levelController:setSelectedIndex(0)
		self.m_curLevelComp:updateView({
			name = g.core.lang:get(var_12_0),
			level = arg_12_1 - 1
		})
	end

	self.m_tipTxt:setText(g.core.lang:get(201612, {
		description = arg_12_2.description,
		master_name = arg_12_2.master_name
	}))
	self.m_nextLevelComp:updateView({
		name = g.core.lang:get(var_12_0),
		level = arg_12_1
	})

	local var_12_2 = {}
	local var_12_3 = {}

	for iter_12_0 = 1, var_0_0.EQUIP_FIELDNUM do
		if arg_12_2["affect_value_" .. iter_12_0] > 0 and arg_12_2["affect_type_" .. iter_12_0] > 0 then
			table.insert(var_12_3, {
				type = arg_12_2["affect_type_" .. iter_12_0],
				value = arg_12_2["affect_value_" .. iter_12_0]
			})
		end

		if self._id > 0 then
			local var_12_4 = var_0_1.get(self._id)

			if var_12_4["affect_type_" .. iter_12_0] > 0 and var_12_4["affect_value_" .. iter_12_0] > 0 then
				table.insert(var_12_2, {
					type = var_12_4["affect_type_" .. iter_12_0],
					value = var_12_4["affect_value_" .. iter_12_0]
				})
			end
		else
			table.insert(var_12_2, {
				value = 0,
				type = arg_12_2["affect_type_" .. iter_12_0]
			})
		end
	end

	for iter_12_1 = 1, var_0_0.EQUIP_FIELDNUM do
		self["m_curLevelAttr" .. iter_12_1]:setVisible(iter_12_1 <= #var_12_2)
		self["m_nextLevelAttr" .. iter_12_1]:setVisible(iter_12_1 <= #var_12_3)

		if iter_12_1 <= #var_12_2 then
			self["m_curLevelAttr" .. iter_12_1]:updateAttr(var_12_2[iter_12_1])
		end

		if iter_12_1 <= #var_12_3 then
			self["m_nextLevelAttr" .. iter_12_1]:updateAttr(var_12_3[iter_12_1])
		end
	end
end

function ETMasterPop:_onTouchStrength()
	if self._type >= 3 and self._type <= 4 then
		if self._type == 3 then
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_STRENGTH) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.TREASURE_DEVELOP, {
					isRefine = false,
					id = self._treasureData[1].base_id,
					sid = self._treasureData[1].id
				})
			end
		elseif self._type == 4 and g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_REFINE) then
			g.core.module.ModuleManager:pushModule(g.view.entrance.TREASURE_DEVELOP, {
				isRefine = true,
				id = self._treasureData[1].base_id,
				sid = self._treasureData[1].id
			})
		end
	else
		local var_13_0 = self._equipData[1].id

		if self._type == 1 then
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_STRENGTH) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.EQUIP_DEVELOP, 1, var_13_0)
			end
		elseif self._type == 2 then
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_REFINE) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.EQUIP_DEVELOP, 2, var_13_0)
			end
		elseif self._type == 5 and g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_RESONANCE) then
			g.core.module.ModuleManager:pushModule(g.view.entrance.EQUIP_DEVELOP, 4, var_13_0)
		end
	end
end

function ETMasterPop:_updateButton()
	if self._type == 1 or self._type == 3 then
		self.m_strengthBtn:setText(g.core.lang:get(202006))
	elseif self._type == 2 or self._type == 4 then
		self.m_strengthBtn:setText(g.core.lang:get(202007))
	elseif self._type == 5 then
		self.m_strengthBtn:setText(g.core.lang:get(201601))
	end
end

function ETMasterPop:_updateResonanceView()
	if self._isSwearEquip then
		self._equipData = {}

		local var_15_0 = self:_setStrengthenData((self:_getMinLv()))

		for iter_15_0 = 1, 4 do
			local var_15_1 = var_0_2:getEquipDataByPos(self._knightIndex * 4 + iter_15_0):getServerData()

			self["m_item" .. iter_15_0]:updateView(self._type, iter_15_0, var_15_1, var_15_0.value, self._isFullLevel)
			table.insert(self._equipData, var_15_1)
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(201519))
	end
end

return ETMasterPop
