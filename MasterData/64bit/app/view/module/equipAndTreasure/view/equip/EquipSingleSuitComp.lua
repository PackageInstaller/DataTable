local EquipSingleSuitComp = class("EquipSingleSuitComp", require("app.fairyGUI.equipAndTreasure.UI_EquipSingleSuitComp"))

function EquipSingleSuitComp:ctor()
	self._attrList = {}

	self.m_suitAttrList:setIniter()
	self.m_suitAttrList:setItemRenderer(handler(self, self._onListRender))
	self.m_skillList:setIniter()
	self.m_skillList:setItemRenderer(handler(self, self._onItemRender))
	self.m_skillList:doFairyBatching(false)

	self._skillData = {}
end

function EquipSingleSuitComp:_onListRender(arg_2_1, arg_2_2)
	arg_2_2:updateCell(self._attrList[arg_2_1 + 1])
end

function EquipSingleSuitComp:updateView(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = g.core.config.equipment_suit_info.get(arg_3_1.suit_id)

	self._suitInfo = var_3_0
	self._knightPos = arg_3_3
	self._suitId = arg_3_1.suit_id

	for iter_3_0 = 1, 4 do
		local var_3_1 = self["m_suit" .. iter_3_0]

		if self["m_suit" .. iter_3_0].updateIcon then
			var_3_1:updateIcon({
				type = g.core.common.Goods.TYPE_EQUIP,
				value = var_3_0["equipment_id_" .. iter_3_0]
			})
		end

		if arg_3_2 and arg_3_2.position > 0 and arg_3_3 and arg_3_3 > 0 then
			if not arg_3_4 and g.core.model.User.equipmentData:isEquipWearedSuitByBaseId(var_3_0["equipment_id_" .. iter_3_0], arg_3_3) or g.core.model.User.playerInfoData:isEquipWearedSuitByBaseId(var_3_0["equipment_id_" .. iter_3_0], arg_3_3) then
				var_3_1:setGrayed(false)
			else
				var_3_1:setGrayed(true)
			end
		end
	end

	self:updateAttr(var_3_0, arg_3_3, arg_3_1.suit_id, arg_3_4)
	self:_updateEquipSuitPassiveInfo(arg_3_4)
	self:_updateSize()
end

function EquipSingleSuitComp:_updateSize()
	self:setHeight(158 + (self.m_hasPassiveSkillController:getSelectedIndex() == 1 and self.m_skillList:getHeight() or 0) + self.m_suitAttrList:getHeight())
end

function EquipSingleSuitComp:updateAttr(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = {}
	local var_5_1 = 0

	if arg_5_2 and arg_5_2 > 0 then
		local var_5_2 = not arg_5_4 and g.core.model.User.formationData:getEquipSuitByKnightPos(arg_5_2) or g.core.model.User.playerInfoData:getEquipSuitByKnightPos(arg_5_2)
		local var_5_3 = var_5_2[arg_5_3]

		if var_5_2[arg_5_3] and var_5_3 >= 2 then
			var_5_1 = var_5_3 - 1
		end
	end

	for iter_5_0 = 1, 3 do
		local var_5_4 = "two"

		if iter_5_0 == 2 then
			var_5_4 = "three"
		elseif iter_5_0 == 3 then
			var_5_4 = "four"
		end

		for iter_5_1 = 1, 2 do
			if arg_5_1[var_5_4 .. "_suit_type_" .. iter_5_1] > 0 and arg_5_1[var_5_4 .. "_suit_value_" .. iter_5_1] > 0 then
				local var_5_5, var_5_6 = g.core.lang:getAttr(arg_5_1[var_5_4 .. "_suit_type_" .. iter_5_1], arg_5_1[var_5_4 .. "_suit_value_" .. iter_5_1])

				table.insert(var_5_0, {
					attrName = var_5_5,
					attrValue = var_5_6,
					isTitle = iter_5_1 == 1,
					isActive = iter_5_0 <= var_5_1,
					suitNum = iter_5_0 + 1
				})
			end
		end
	end

	self._attrList = var_5_0

	self.m_suitAttrList:setNumItems(table.nums(var_5_0))
	self.m_suitAttrList:resizeToFit(table.nums(var_5_0))

	if #var_5_0 == 0 then
		self.m_suitAttrList:setVisible(false)
	end
end

function EquipSingleSuitComp:_updateEquipSuitPassiveInfo(arg_6_1)
	local var_6_0 = false
	local var_6_1 = {}

	for iter_6_0, iter_6_1, iter_6_2 in self._suitInfo.gmatch({
		"passive_skill_%d+"
	}, true) do
		if iter_6_2[1] > 0 then
			var_6_1[#var_6_1 + 1] = {
				skillId = iter_6_2[1],
				targetSuitNum = iter_6_1 + 1
			}
			var_6_0 = true
		end
	end

	self.m_hasPassiveSkillController:setSelectedIndex(var_6_0 and 1 or 0)

	if var_6_0 then
		local var_6_2 = g.core.config.passive_skill_info
		local var_6_3 = {}
		local var_6_5 = (not arg_6_1 and g.core.model.User.formationData:getEquipSuitByKnightPos(self._knightPos) or g.core.model.User.playerInfoData:getEquipSuitByKnightPos(self._knightPos))[self._suitId]

		for iter_6_3 = 1, #var_6_1 do
			var_6_3[#var_6_3 + 1] = {
				skillInfo = var_6_2.get(var_6_1[iter_6_3].skillId),
				curSuitNum = var_6_5,
				targetSuitNum = var_6_1[iter_6_3].targetSuitNum
			}
		end

		self._skillData = var_6_3

		self.m_skillList:setNumItems(#var_6_3)
		self.m_skillList:resizeToFit(#var_6_3)
	end
end

function EquipSingleSuitComp:_onItemRender(arg_7_1, arg_7_2)
	if self._skillData[arg_7_1 + 1] then
		arg_7_2:update(self._skillData[arg_7_1 + 1])
	end
end

return EquipSingleSuitComp
