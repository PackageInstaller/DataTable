local var_0_0 = g.core.config.equipment_info
local var_0_1 = g.core.const.ConstMgr.QUALITY_TYPE
local EquipMagicalSuitStageComp = class("EquipMagicalSuitStageComp", require("app.fairyGUI.equipAndTreasure.UI_EquipMagicalSuitStageComp"))

function EquipMagicalSuitStageComp:ctor()
	return
end

function EquipMagicalSuitStageComp:updateView(arg_2_1)
	self:setQuality(var_0_0.match(function(arg_3_0)
		return arg_3_0.suit_id == arg_2_1.suit_id
	end)[1].quality)

	if self.m_suitTypeController:getSelectedIndex() == 0 then
		self.m_title:setText(g.core.lang:get(201660, {
			name = arg_2_1.talent_name_1,
			level = arg_2_1.suit_stage
		}))
	else
		local var_2_0 = {}

		var_2_0.name = arg_2_1.talent_name_2
		var_2_0.level = arg_2_1.suit_stage

		self.m_title:setText(g.core.lang:get(201660, var_2_0))
	end
end

function EquipMagicalSuitStageComp:setTitle(arg_4_1)
	self.m_title:setTitle(arg_4_1)
end

function EquipMagicalSuitStageComp:setActiveState(arg_5_1)
	self.m_isGrayController:setSelectedIndex(arg_5_1 and 0 or 1)

	if self.m_suitQualityController:getSelectedIndex() == 0 then
		self.m_icon:setGrayed(not arg_5_1)
	elseif self.m_suitQualityController:getSelectedIndex() == 1 then
		self.m_iconMR:setGrayed(not arg_5_1)
	end
end

function EquipMagicalSuitStageComp:setActiveProgress(arg_6_1)
	local var_6_0 = self.m_suitTypeController:getSelectedIndex() == 0 and 2 or 4

	self.m_progTxt:setText(table.concat({
		"[",
		math.min(arg_6_1, var_6_0),
		"/",
		var_6_0,
		"]"
	}))
end

function EquipMagicalSuitStageComp:setQuality(arg_7_1)
	if arg_7_1 == var_0_1.UR then
		self.m_suitQualityController:setSelectedIndex(0)
	elseif arg_7_1 == var_0_1.MR then
		self.m_suitQualityController:setSelectedIndex(1)
	end
end

return EquipMagicalSuitStageComp
