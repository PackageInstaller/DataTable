local EquipSuitDetailPanel = class("EquipSuitDetailPanel", require("app.fairyGUI.equipAndTreasure.UI_EquipSuitDetailPanel"))

function EquipSuitDetailPanel:ctor()
	self.m_skillList:setIniter()
	self.m_skillList:setItemRenderer(handler(self, self._onItemRender))
	self.m_skillList:doFairyBatching(false)

	self._skillData = {}
end

function EquipSuitDetailPanel:updatePanel(arg_2_1)
	self._params = arg_2_1
	self._suitId = arg_2_1.suitId
	self._data = arg_2_1.data
	self._knightPos = arg_2_1.knightPos
	self._isOther = arg_2_1.isOther
	self._suitInfo = g.core.config.equipment_suit_info.get(self._suitId)

	self:_initAttrInfoComp()
	self:_updateEquipSuitPassiveInfo()
end

function EquipSuitDetailPanel:_initAttrInfoComp()
	for iter_3_0 = 1, 3 do
		local var_3_0 = "two"

		if iter_3_0 == 2 then
			var_3_0 = "three"
		elseif iter_3_0 == 3 then
			var_3_0 = "four"
		end

		local var_3_1 = {}

		for iter_3_1 = 1, 2 do
			if self._suitInfo[var_3_0 .. "_suit_type_" .. iter_3_1] > 0 then
				local var_3_2, var_3_3 = g.core.lang:getAttr(self._suitInfo[var_3_0 .. "_suit_type_" .. iter_3_1], self._suitInfo[var_3_0 .. "_suit_value_" .. iter_3_1])

				table.insert(var_3_1, {
					attrName = var_3_2,
					attrValue = var_3_3
				})
			end
		end

		if next(var_3_1) then
			self["m_activeComp" .. iter_3_0]:updateAttr(var_3_1, iter_3_0 + 1)
		end
	end

	if self._knightPos and self._knightPos > 0 then
		local var_3_4 = not self._isOther and g.core.model.User.formationData:getEquipSuitByKnightPos(self._knightPos) or g.core.model.User.playerInfoData:getEquipSuitByKnightPos(self._knightPos)
		local var_3_5 = var_3_4[self._suitId]

		for iter_3_2 = 1, (var_3_4[self._suitId] and var_3_5 >= 2 or nil) and var_3_5 - 1 do
			self["m_activeComp" .. iter_3_2]:setCtrlState("isActive", {
				index = 1
			})
		end
	end
end

function EquipSuitDetailPanel:_updateEquipSuitPassiveInfo()
	local var_4_0 = false
	local var_4_1 = {}

	for iter_4_0, iter_4_1, iter_4_2 in self._suitInfo.gmatch({
		"passive_skill_%d+"
	}, true) do
		if iter_4_2[1] > 0 then
			var_4_1[#var_4_1 + 1] = {
				skillId = iter_4_2[1],
				targetSuitNum = iter_4_1 + 1
			}
			var_4_0 = true
		end
	end

	self.m_hasPassiveSkillController:setSelectedIndex(var_4_0 and 1 or 0)

	if var_4_0 then
		local var_4_2 = g.core.config.passive_skill_info
		local var_4_3 = {}
		local var_4_5 = (not self._isOther and g.core.model.User.formationData:getEquipSuitByKnightPos(self._knightPos) or g.core.model.User.playerInfoData:getEquipSuitByKnightPos(self._knightPos))[self._suitId]

		for iter_4_3 = 1, #var_4_1 do
			var_4_3[#var_4_3 + 1] = {
				skillInfo = var_4_2.get(var_4_1[iter_4_3].skillId),
				curSuitNum = var_4_5,
				targetSuitNum = var_4_1[iter_4_3].targetSuitNum
			}
		end

		self._skillData = var_4_3

		self.m_skillList:setNumItems(#var_4_3)
		self.m_skillList:resizeToFit(#var_4_3)
	end
end

function EquipSuitDetailPanel:_onItemRender(arg_5_1, arg_5_2)
	if self._skillData[arg_5_1 + 1] then
		arg_5_2:update(self._skillData[arg_5_1 + 1])
	end
end

return EquipSuitDetailPanel
