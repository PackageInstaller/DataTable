local SuccubaPopTalentComp = class("SuccubaPopTalentComp", require("app.fairyGUI.succuba.UI_SuccubaPopTalentComp"))

function SuccubaPopTalentComp:ctor()
	return
end

function SuccubaPopTalentComp:updateShow(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_1:getStar()
	local var_2_1, var_2_2 = arg_2_1:getStarMainSkillList()
	local var_2_3 = {}

	for iter_2_0 = 1, #var_2_1 do
		local var_2_4 = var_2_1[iter_2_0]
		local var_2_5 = g.core.config.skill_info.get(var_2_1[iter_2_0].skillId)
		local var_2_6 = var_2_0 >= var_2_1[iter_2_0].star and 0 or 1
		local var_2_7 = g.core.lang:get(431024, {
			name = var_2_5.curtain_name,
			lv = var_2_5.level
		})
		local var_2_8 = g.core.utils.String.formatSkillDesc(var_2_1[iter_2_0].skillId)

		if (var_2_0 >= var_2_1[iter_2_0].star and 0 or 1) == 1 then
			var_2_8 = var_2_8 .. g.core.lang:get(431011, {
				star = var_2_4.star
			})
		end

		table.insert(var_2_3, {
			state = var_2_6,
			title = var_2_7,
			desc = var_2_8
		})
	end

	self.m_starUpDescComp:updateComp(var_2_3)

	local var_2_9 = arg_2_1:getLevel()
	local var_2_10 = arg_2_1:getLvTalentSkillList()
	local var_2_11 = {}

	for iter_2_1 = 1, #var_2_10 do
		local var_2_12 = var_2_10[iter_2_1]
		local var_2_13 = g.core.config.talent_skill_info.get(var_2_10[iter_2_1].skillId)
		local var_2_14 = var_2_9 >= var_2_10[iter_2_1].lv and 0 or 1
		local var_2_15 = g.core.lang:get(430702, {
			name = var_2_13.name
		})
		local var_2_16 = ""

		var_2_16 = (var_2_9 >= var_2_10[iter_2_1].lv and 0 or 1) == 1 and var_2_13.description .. g.core.lang:get(431010, {
			level = var_2_12.lv
		}) or var_2_13.description

		table.insert(var_2_11, {
			state = var_2_14,
			title = var_2_15,
			desc = var_2_16
		})
	end

	self.m_lvUpTalentComp:updateComp(var_2_11)

	local var_2_17 = arg_2_1:getStar()
	local var_2_18 = arg_2_1:getStarTalentSkillList()
	local var_2_19 = {}

	for iter_2_2 = 1, #var_2_18 do
		local var_2_20 = var_2_18[iter_2_2]
		local var_2_21 = g.core.config.talent_skill_info.get(var_2_18[iter_2_2].skillId)
		local var_2_22 = var_2_17 >= var_2_18[iter_2_2].star and 0 or 1
		local var_2_23 = g.core.lang:get(430702, {
			name = var_2_21.name
		})
		local var_2_24 = ""

		var_2_24 = (var_2_17 >= var_2_18[iter_2_2].star and 0 or 1) == 1 and var_2_21.description .. g.core.lang:get(431011, {
			star = var_2_20.star
		}) or var_2_21.description

		table.insert(var_2_19, {
			state = var_2_22,
			title = var_2_23,
			desc = var_2_24
		})
	end

	self.m_starUpTalentComp:updateComp(var_2_19)
end

return SuccubaPopTalentComp
