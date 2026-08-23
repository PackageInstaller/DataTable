local var_0_1 = g.core.const.ConstMgr.EquipConst
local var_0_2 = g.core.config.equipment_suit_stage_info
local var_0_3 = g.core.config.talent_skill_info
local EquipMagicalSuitStageUpComp = class("EquipMagicalSuitStageUpComp", require("app.fairyGUI.equipAndTreasure.UI_EquipMagicalSuitStageUpComp"))

function EquipMagicalSuitStageUpComp:ctor()
	return
end

function EquipMagicalSuitStageUpComp:update(arg_2_1)
	local var_2_0 = ""
	local var_2_1 = g.core.config.equipment_suit_info.get(arg_2_1.suitId)

	if arg_2_1.suitType == var_0_1.EQUIP_SUIT_TYPE.TWO then
		self.m_hasSkillController:setSelectedIndex(0)

		var_2_0 = "two_suit_talent_"

		self.m_activeStage:setText(g.core.lang:get(201664, {
			name = var_2_1.name,
			stage = arg_2_1.stage
		}))
	else
		self.m_hasSkillController:setSelectedIndex(1)

		var_2_0 = "four_suit_talent_"

		self.m_activeStage:setText(g.core.lang:get(201665, {
			name = var_2_1.name,
			stage = arg_2_1.stage
		}))
		self.m_skillTitle:setText((arg_2_1.stage > 1 or nil) and (g.core.lang:get(201666) or g.core.lang:get(201667)))
	end

	local var_2_2 = arg_2_1.cfg
	local var_2_3 = {}

	while var_0_2.hasKey(var_2_0 .. 1) do
		if var_2_2[var_2_0 .. 1] > 0 then
			local var_2_4 = var_0_3.get(var_2_2[var_2_0 .. 1])

			while var_0_3.hasKey("affect_type_" .. 1) do
				if var_2_4["affect_type_" .. 1] > 0 and var_2_4["affect_value_" .. 1] > 0 then
					var_2_3[var_2_4["affect_type_" .. 1]] = var_2_3[var_2_4["affect_type_" .. 1]] or 0
					var_2_3[var_2_4["affect_type_" .. 1]] = var_2_3[var_2_4["affect_type_" .. 1]] + var_2_4["affect_value_" .. 1]
				end
			end
		end
	end

	local var_2_7 = {}

	for iter_2_0, iter_2_1 in pairs(var_2_3) do
		table.insert(var_2_7, {
			type = iter_2_0,
			value = iter_2_1
		})
	end

	for iter_2_2 = 1, 4 do
		self["m_attr" .. iter_2_2]:updateAttr(var_2_7[iter_2_2])
	end

	if arg_2_1.suitType == var_0_1.EQUIP_SUIT_TYPE.FOUR then
		self:_updateSkill(var_2_2.four_suit_passive)
	end
end

function EquipMagicalSuitStageUpComp:_updateSkill(arg_3_1)
	local var_3_0 = g.core.config.skill_info.get(g.core.config.passive_skill_info.get(arg_3_1).passive_skill_value)

	self.m_skillIcon:updateIcon({
		skillId = var_3_0.id
	})
	self.m_skillDesc:updateSkillDesc({
		enableRich = true,
		name = var_3_0.curtain_name,
		desc = var_3_0.description
	})
end

function EquipMagicalSuitStageUpComp:playAnimate()
	self.m_enterTransition:play()
end

return EquipMagicalSuitStageUpComp
