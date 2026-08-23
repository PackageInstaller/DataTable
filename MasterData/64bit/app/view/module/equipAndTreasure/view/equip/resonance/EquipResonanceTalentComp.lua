local EquipResonanceTalentComp = class("EquipResonanceTalentComp", require("app.fairyGUI.equipAndTreasure.UI_EquipResonanceTalentComp"))

function EquipResonanceTalentComp:ctor()
	self.m_isDevlopController:setSelectedIndex(1)
end

function EquipResonanceTalentComp:update(arg_2_1)
	if arg_2_1.talentName then
		self.m_skillComp:setTitle(arg_2_1.talentName)
	end
end

function EquipResonanceTalentComp:onLoad()
	return
end

function EquipResonanceTalentComp:onUnload()
	return
end

return EquipResonanceTalentComp
