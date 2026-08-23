local var_0_0 = g.core.model.User.knightTissueData
local var_0_1 = g.core.config.knight_tissue_level_info
local KnightTissueLevelUpComp = class("KnightTissueLevelUpComp", require("app.fairyGUI.knightTissue.UI_KnightTissueLevelUpComp"))

function KnightTissueLevelUpComp:update(arg_1_1)
	if arg_1_1 and arg_1_1.id then
		local var_1_0 = arg_1_1.id
		local var_1_1 = var_0_0:getKnightTissueLevel(arg_1_1.id)
		local var_1_2 = var_0_0:getTissueAttrCountById(arg_1_1.id, var_1_1)
		local var_1_3 = arg_1_1.oldLv

		if arg_1_1.oldLv < 0 then
			-- block empty
		else
			self.m_lastLevelText:setText(var_1_3)
			self.m_levelText:setText(var_1_1)
		end

		self.m_activateStateController:setSelectedIndex(var_1_3 < 0 and 1 or 0)
		self.m_attrCountController:setSelectedIndex((var_1_2 > 0 or nil) and (var_1_2 - 1 or 0))

		local var_1_4 = var_0_1.get(var_1_0, var_1_1)

		if var_1_3 >= 0 then
			local var_1_5 = var_0_1.get(var_1_0, var_1_3)

			for iter_1_0 = 1, var_1_2 do
				self["m_attr" .. iter_1_0]:updateAttr({
					type = var_1_4["attr_type_" .. iter_1_0],
					value = var_1_5["attr_value_" .. iter_1_0],
					value2 = var_1_4["attr_value_" .. iter_1_0],
					name = g.core.lang:get(111918, {
						name = g.core.config.attribute_info.get(var_1_4["attr_type_" .. iter_1_0]).name
					})
				})
			end
		else
			for iter_1_1 = 1, var_1_2 do
				self["m_attr" .. iter_1_1]:updateAttr({
					value = 0,
					type = var_1_4["attr_type_" .. iter_1_1],
					value2 = var_1_4["attr_value_" .. iter_1_1],
					name = g.core.lang:get(111918, {
						name = g.core.config.attribute_info.get(var_1_4["attr_type_" .. iter_1_1]).name
					})
				})
			end
		end

		local var_1_6 = false

		for iter_1_2 = var_1_1, var_1_3, -1 do
			if var_0_0:isLevelUpHavePassiveActiveShow(var_1_0, iter_1_2) and var_1_4.skill_id > 0 and var_1_4.skill_target > 0 then
				var_1_6 = true

				self.m_noPassiveController:setSelectedIndex(1)

				local var_1_7 = g.core.model.User.knightsData:getKnight({
					advance_id = var_1_4.skill_target
				})

				if var_1_7 then
					local var_1_8, var_1_9 = g.core.utils.String.formatPassiveSkillDesc(var_1_4.skill_id)

					self.m_nameActiveTxt:setText(g.core.lang:get(111909, {
						playName = var_1_7:getName()
					}))
					self.m_skillNameTxt:setText(g.core.config.passive_skill_info.get(var_1_4.skill_id).name)
					self.m_descText:getChild("title"):enableRich()
					self.m_descText:setTitle(var_1_8)
				end

				break
			end
		end

		if not var_1_6 then
			self.m_noPassiveController:setSelectedIndex(0)
		end
	end
end

return KnightTissueLevelUpComp
