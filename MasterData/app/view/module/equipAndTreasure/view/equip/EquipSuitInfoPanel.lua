local EquipSuitInfoPanel = class("EquipSuitInfoPanel", require("app.fairyGUI.equipAndTreasure.UI_EquipSuitInfoPanel"))

function EquipSuitInfoPanel:ctor()
	self.m_suitAttrList:setVirtual(self)
	self.m_suitAttrList:setItemRenderer(handler(self, self._onItemRenderer))

	self._suitData = {}

	self.m_skillList:setIniter()
	self.m_skillList:setItemRenderer(handler(self, self._onSkillItemRender))
	self.m_skillList:doFairyBatching(false)

	self._skillData = {}
end

function EquipSuitInfoPanel:updatePanel(arg_2_1)
	self._params = arg_2_1
	self._knight = arg_2_1.knight
	self._knightIndex = arg_2_1.index

	self:_initAttrInfoComp()
	self:_updateEquipSuitPassiveInfo()
end

function EquipSuitInfoPanel:_initAttrInfoComp()
	self._suitData = {}

	for iter_3_0 = 1, 4 do
		local var_3_0 = g.core.model.User.equipmentData:getEquipBySid((g.core.model.User.equipmentData:getEquipIdByPos((self._knightIndex - 1) * 4 + iter_3_0)))

		if var_3_0 then
			local var_3_1 = var_3_0:getServerData()
			local var_3_2 = var_3_0:getCfg()

			if var_3_2.suit_id > 0 then
				for iter_3_1, iter_3_2 in pairs(self._suitData) do
					local var_3_3

					if iter_3_2.suitId == var_3_2.suit_id then
						var_3_3 = true

						break
					end
				end

				if not false then
					table.insert(self._suitData, {
						suitId = var_3_2.suit_id,
						data = var_3_1,
						knightPos = self._knight:getInfo().position
					})
				end
			end
		end
	end

	table.sort(self._suitData, function(arg_4_0, arg_4_1)
		return arg_4_0.suitId > arg_4_1.suitId
	end)
	self.m_suitAttrList:setNumItems(#self._suitData)
end

function EquipSuitInfoPanel:_onItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateSuitAttriBute(self._suitData[arg_5_1 + 1])
end

function EquipSuitInfoPanel:_updateEquipSuitPassiveInfo()
	local var_6_0 = false
	local var_6_1 = {}

	for iter_6_0 = 1, #self._suitData do
		local var_6_2 = g.core.model.User.formationData:getEquipSuitByKnightPos(self._suitData[iter_6_0].knightPos)[self._suitData[iter_6_0].suitId]

		for iter_6_1, iter_6_2, iter_6_3 in g.core.config.equipment_suit_info.get(self._suitData[iter_6_0].suitId).gmatch({
			"passive_skill_%d+"
		}, true) do
			if iter_6_3[1] > 0 then
				var_6_1[#var_6_1 + 1] = {
					skillId = iter_6_3[1],
					curSuitNum = var_6_2,
					targetSuitNum = iter_6_2 + 1
				}
				var_6_0 = true
			end
		end
	end

	self.m_hasPassiveSkillController:setSelectedIndex(var_6_0 and 1 or 0)

	if var_6_0 then
		local var_6_3 = {}

		for iter_6_4 = 1, #var_6_1 do
			var_6_3[#var_6_3 + 1] = {
				skillInfo = g.core.config.passive_skill_info.get(var_6_1[iter_6_4].skillId),
				curSuitNum = var_6_1[iter_6_4].curSuitNum,
				targetSuitNum = var_6_1[iter_6_4].targetSuitNum
			}
		end

		self._skillData = var_6_3

		self.m_skillList:setNumItems(#var_6_3)
		self.m_skillList:resizeToFit(#var_6_3)
	end
end

function EquipSuitInfoPanel:_onSkillItemRender(arg_7_1, arg_7_2)
	if self._skillData[arg_7_1 + 1] then
		arg_7_2:update(self._skillData[arg_7_1 + 1])
	end
end

return EquipSuitInfoPanel
