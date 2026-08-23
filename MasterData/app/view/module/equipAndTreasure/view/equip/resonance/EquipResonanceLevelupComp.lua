local EquipResonanceLevelupComp = class("EquipResonanceLevelupComp", require("app.fairyGUI.equipAndTreasure.UI_EquipResonanceLevelupComp"))

function EquipResonanceLevelupComp:ctor()
	return
end

function EquipResonanceLevelupComp:updateLevelupComp(arg_2_1)
	if arg_2_1.fromLevel then
		self.m_fromLevelComp:setResonanceLevel(arg_2_1.fromLevel)
	end

	if arg_2_1.toLevel and not arg_2_1.hideNext then
		self.m_toLevelComp:setResonanceLevel(arg_2_1.toLevel)
	end

	self.m_hideNextController:setSelectedIndex(arg_2_1.hideNext and 1 or 0)
end

function EquipResonanceLevelupComp:onLoad()
	return
end

function EquipResonanceLevelupComp:onUnload()
	return
end

return EquipResonanceLevelupComp
