local ETOtherGroupComp = class("ETOtherGroupComp", require("app.fairyGUI.equipAndTreasure.UI_ETOtherGroupComp"))

function ETOtherGroupComp:ctor()
	self._knightIndex = 1

	self.m_enterTransition:play()
	self.m_equipSuitBtn:addClickListener(handler(self, self._onClickSuitButton))
end

function ETOtherGroupComp:updateView(arg_2_1)
	self._knight = arg_2_1.knight
	self._knightIndex = arg_2_1.knightIndex or 1
	self._selectPositionData = arg_2_1.selectPositionData

	self:updateEquip()

	if g.core.common.ModuleUnlock:getModuleUnlockLevel(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_LINEUP) <= g.core.model.User.playerInfoData:getPlayerSnapShot().level then
		self.m_hideTreasureController:setSelectedIndex(0)
		self:updateTreasure()
	else
		self.m_hideTreasureController:setSelectedIndex(1)
	end

	self:_checkTickWeakGuide()
end

function ETOtherGroupComp:updateEquip()
	for iter_3_0 = 1, 4 do
		local var_3_1 = g.core.model.User.playerInfoData:getEquipmentByPos((self._knightIndex - 1) * 4 + iter_3_0)
		local var_3_2 = {
			isWear = checkbool(var_3_1),
			pos = (self._knightIndex - 1) * 4 + iter_3_0,
			knight = self._knight,
			type = g.core.common.Goods.TYPE_EQUIP,
			knightIndex = self._knightIndex,
			selectPositionData = self._selectPositionData
		}

		if var_3_1 then
			var_3_2.serverData = var_3_1:getServerData()
		end

		self["m_equipComp" .. iter_3_0]:updateView(var_3_2)
	end

	self.m_equipSuitBtn:updateSuitSimpleIcon({
		isOther = true,
		index = self._knightIndex,
		knight = self._knight
	})
end

function ETOtherGroupComp:updateTreasure()
	for iter_4_0 = 1, 2 do
		local var_4_0 = g.core.model.User.playerInfoData:getTreasureByPos((self._knightIndex - 1) * 2 + iter_4_0)

		self["m_treasureComp" .. iter_4_0]:updateView({
			pos = (self._knightIndex - 1) * 2 + iter_4_0,
			isWear = checkbool(var_4_0),
			type = g.core.common.Goods.TYPE_TREASURE,
			knightIndex = self._knightIndex,
			knight = self._knight,
			serverData = var_4_0,
			selectPositionData = self._selectPositionData
		})
	end
end

function ETOtherGroupComp:_onClickSuitButton()
	g.core.sound.SoundManager:playSound("UI_Click_Small")

	if g.core.model.User.equipmentData:isHaveEquipSuitByKnightIndex(self._knightIndex) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.EQUIP_SUIT_INFO, {
			index = self._knightIndex,
			knight = self._knight
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(201546))
	end
end

function ETOtherGroupComp:getCurEquipDataBySelected()
	local var_6_0 = g.core.model.User.equipmentData:getEquipList(self._selectPositionData.positionType)
	local var_6_1 = {}

	if g.core.model.User.equipmentData:getIsHideWearEquip() then
		if self._qualityType then
			for iter_6_0 = 1, #var_6_0.noWearIndex do
				if var_6_0.noWearIndex[iter_6_0]:getCfg().quality == self._qualityType then
					table.insert(var_6_1, var_6_0.noWearIndex[iter_6_0])
				end
			end
		else
			var_6_1 = var_6_0.noWearIndex
		end
	else
		var_6_1 = {}

		local var_6_2 = {}

		if self._qualityType then
			for iter_6_1 = 1, #var_6_0.allIndex do
				if var_6_0.allIndex[iter_6_1]:getCfg().quality == self._qualityType then
					table.insert(var_6_2, var_6_0.allIndex[iter_6_1])
				end
			end
		else
			var_6_2 = var_6_0.allIndex
		end

		for iter_6_2 = 1, #var_6_2 do
			if var_6_2[iter_6_2]:getPosition() > 0 then
				if not var_6_2[iter_6_2]:isInitEquipment() then
					table.insert(var_6_1, var_6_2[iter_6_2])
				end
			else
				table.insert(var_6_1, var_6_2[iter_6_2])
			end
		end
	end

	return var_6_1
end

function ETOtherGroupComp:_checkTickWeakGuide()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)

	local var_7_0, var_7_1 = g.core.model.User.equipmentData:isKnightHasEquip(self._knightIndex)

	if var_7_0 then
		if self._selectPositionData then
			if #self:getCurEquipDataBySelected() == 0 then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
					key = "EQUIP_STEP_2",
					targetBtn = self["m_equipComp" .. var_7_1]
				})
			end
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "EQUIP_STEP_2",
				targetBtn = self["m_equipComp" .. var_7_1]
			})
		end
	end
end

function ETOtherGroupComp:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return ETOtherGroupComp
