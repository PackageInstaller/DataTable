local ArtifactStrengthenDescItemCell = class("ArtifactStrengthenDescItemCell", require("app.fairyGUI.artifact.UI_ArtifactStrengthenDescItemCell"))

function ArtifactStrengthenDescItemCell:ctor()
	return
end

function ArtifactStrengthenDescItemCell:updateDesc(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1.isUnLock
	local var_2_2 = arg_2_3

	if arg_2_2 then
		self.m_levelTxt:setText("[" .. arg_2_1.talentInfo.name .. "]")
		self.m_descTxt:setText(arg_2_1.talentInfo.desc .. " " .. "(" .. g.core.lang:get(205507, {
			level = arg_2_1.info.level
		}) .. ")")
	else
		local var_2_3 = "Lv." .. arg_2_1.level + 1 .. " "

		if arg_2_4 then
			local var_2_4 = arg_2_1.stage or arg_2_1.level

			if not var_2_1 and not var_2_2 then
				var_2_3 = var_2_3 .. g.core.lang:get(arg_2_4 and 205562 or 205508, {
					level = var_2_4
				})
			end
		end

		self.m_levelTxt:setText(var_2_3)
		self.m_descTxt:setText((var_2_1 or var_2_2 or nil) and (var_2_0.desc or g.core.utils.String.paintDescGreyColorful(var_2_0.desc)))
	end

	self.m_activeController:setSelectedIndex((var_2_1 or var_2_2) and 1 or 0)
end

function ArtifactStrengthenDescItemCell:getTalentAttrChanged(arg_3_1, arg_3_2)
	local var_3_0 = {}
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		local var_3_2 = g.core.config.talent_skill_info.get(iter_3_1)

		for iter_3_2 = 1, 3 do
			if var_3_2["affect_type_" .. iter_3_2] > 0 then
				var_3_1[var_3_2["affect_type_" .. iter_3_2]] = var_3_1[var_3_2["affect_type_" .. iter_3_2]] or 0
				var_3_1[var_3_2["affect_type_" .. iter_3_2]] = var_3_1[var_3_2["affect_type_" .. iter_3_2]] + var_3_2["affect_value_" .. iter_3_2]
			end
		end
	end

	for iter_3_3, iter_3_4 in ipairs(arg_3_1) do
		local var_3_3 = g.core.config.talent_skill_info.get(iter_3_4)

		for iter_3_5 = 1, 3 do
			if var_3_3["affect_type_" .. iter_3_5] > 0 and var_3_1[var_3_3["affect_type_" .. iter_3_5]] then
				var_3_1[var_3_3["affect_type_" .. iter_3_5]] = var_3_1[var_3_3["affect_type_" .. iter_3_5]] - var_3_3["affect_value_" .. iter_3_5]
			end
		end
	end

	for iter_3_6, iter_3_7 in pairs(var_3_1) do
		table.insert(var_3_0, {
			type = iter_3_6,
			value = iter_3_7
		})
	end

	return var_3_0
end

function ArtifactStrengthenDescItemCell:updateBreakUpTalentDesc(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0, var_4_1, var_4_2

	if arg_4_1 then
		var_4_0 = arg_4_1.skills

		if not arg_4_1.skills then
			var_4_0 = {}
			var_4_1 = arg_4_3:getStar() >= arg_4_2.star
			var_4_2 = arg_4_2.star
		end
	end

	self:updateWithTalent(arg_4_3, var_4_0, arg_4_2.skills, var_4_1, var_4_2)
end

function ArtifactStrengthenDescItemCell:updateSpiritTalentDesc(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0, var_5_1, var_5_2

	if arg_5_1 then
		var_5_0 = arg_5_1.skills

		if not arg_5_1.skills then
			var_5_0 = {}
			var_5_1 = arg_5_3:getSpiritStage() >= arg_5_2.stage
			var_5_2 = arg_5_2.stage
		end
	end

	self:updateWithTalent(arg_5_3, var_5_0, arg_5_2.skills, var_5_1, var_5_2, true)
end

function ArtifactStrengthenDescItemCell:updateWithTalent(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_3) do
		table.insert(var_6_0, (g.core.config.talent_skill_info.get(iter_6_1)))
	end

	local var_6_1 = ""

	for iter_6_2, iter_6_3 in ipairs((self:getTalentAttrChanged(arg_6_2, arg_6_3))) do
		if iter_6_3.value > 0 then
			if var_6_1 ~= "" then
				var_6_1 = var_6_1 .. "，"
			end

			local var_6_2, var_6_3 = g.core.lang:getAttr(iter_6_3.type, iter_6_3.value, false)

			var_6_1 = var_6_1 .. var_6_2 .. var_6_3
		end
	end

	self.m_levelTxt:setText("[" .. (arg_6_6 and arg_6_1:getSpiritStageCfg(arg_6_5).talent_name or arg_6_1:getStarCfg(arg_6_5).talent_name) .. "]")

	if not arg_6_4 then
		var_6_1 = arg_6_6 and var_6_1 .. " " .. g.core.lang:get(205562, {
			level = arg_6_5
		}) or var_6_1 .. " " .. "(" .. g.core.lang:get(205559, {
			level = arg_6_5
		}) .. ")"
	end

	self.m_descTxt:setText(var_6_1)
	self.m_activeController:setSelectedIndex(arg_6_4 and 1 or 0)
end

return ArtifactStrengthenDescItemCell
