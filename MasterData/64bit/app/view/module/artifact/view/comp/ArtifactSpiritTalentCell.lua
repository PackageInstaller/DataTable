local ArtifactSpiritTalentCell = class("ArtifactSpiritTalentCell", require("app.fairyGUI.artifact.UI_ArtifactSpiritTalentCell"))

function ArtifactSpiritTalentCell:updateSpiritTalentDesc(arg_1_1, arg_1_2, arg_1_3)
	self:_setTalent((arg_1_1 or nil) and (arg_1_1.skills or {}), arg_1_2.skills, arg_1_3:getSpiritStage() >= arg_1_2.stage, arg_1_2.stage, arg_1_3)
	self:refreshSize()
end

function ArtifactSpiritTalentCell:getTalentAttrChanged(arg_2_1, arg_2_2)
	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_2) do
		local var_2_2 = g.core.config.talent_skill_info.get(iter_2_1)

		for iter_2_2 = 1, 3 do
			if var_2_2["affect_type_" .. iter_2_2] > 0 then
				var_2_1[var_2_2["affect_type_" .. iter_2_2]] = var_2_1[var_2_2["affect_type_" .. iter_2_2]] or 0
				var_2_1[var_2_2["affect_type_" .. iter_2_2]] = var_2_1[var_2_2["affect_type_" .. iter_2_2]] + var_2_2["affect_value_" .. iter_2_2]
			end
		end
	end

	for iter_2_3, iter_2_4 in ipairs(arg_2_1) do
		local var_2_3 = g.core.config.talent_skill_info.get(iter_2_4)

		for iter_2_5 = 1, 3 do
			if var_2_3["affect_type_" .. iter_2_5] > 0 and var_2_1[var_2_3["affect_type_" .. iter_2_5]] then
				var_2_1[var_2_3["affect_type_" .. iter_2_5]] = var_2_1[var_2_3["affect_type_" .. iter_2_5]] - var_2_3["affect_value_" .. iter_2_5]
			end
		end
	end

	for iter_2_6, iter_2_7 in pairs(var_2_1) do
		table.insert(var_2_0, {
			type = iter_2_6,
			value = iter_2_7
		})
	end

	return var_2_0
end

function ArtifactSpiritTalentCell:_setTalent(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	self.m_descText:setText("")

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		table.insert(var_3_0, (g.core.config.talent_skill_info.get(iter_3_1)))
	end

	self.m_nameTitle:setText(g.core.lang:get(205560, {
		num = arg_3_4
	}))
	self.m_talentNameText:setText((g.core.lang:get(205548, {
		name = arg_3_5:getSpiritStageCfg(arg_3_4).talent_name
	})))
	self.m_levelChangeTxt:setText("")

	if arg_3_4 > 0 then
		self.m_hasLevelChangeController:setSelectedIndex(1)
		self.m_levelChangeTxt:setText(g.core.lang:get(205545, {
			num = arg_3_5:getSpiritStageCfg(arg_3_4).level_max
		}))
	else
		self.m_hasLevelChangeController:setSelectedIndex(0)
	end

	local var_3_1 = ""

	for iter_3_2, iter_3_3 in ipairs((self:getTalentAttrChanged(arg_3_1, arg_3_2))) do
		if iter_3_3.value > 0 then
			if var_3_1 ~= "" then
				var_3_1 = var_3_1 .. "，"
			end

			local var_3_2, var_3_3 = g.core.lang:getAttr(iter_3_3.type, iter_3_3.value, false)

			var_3_1 = var_3_1 .. var_3_2 .. var_3_3
		end
	end

	self.m_isActiveController:setSelectedIndex(arg_3_3 and 1 or 0)

	self._isActive = arg_3_3

	self.m_talentUnLockTxt:setVisible(not arg_3_3)
	self.m_talentUnLockTxt:setText(g.core.lang:get(205547, {
		level = arg_3_4
	}))
	self.m_descText:setText(var_3_1)
end

function ArtifactSpiritTalentCell:refreshSize()
	local var_4_0 = 90

	var_4_0 = self.m_descText:getText() ~= "" and self.m_descText:getPosition().y + self.m_descText:getHeight() + 4 or self.m_talentNameText:getPosition().y + self.m_talentNameText:getHeight() + 4
	var_4_0 = var_4_0 > 90 and var_4_0 or 90

	self:setHeight(var_4_0)
end

return ArtifactSpiritTalentCell
