local EquipResonanceLevelComp = class("EquipResonanceLevelComp", require("app.fairyGUI.equipAndTreasure.UI_EquipResonanceLevelComp"))

function EquipResonanceLevelComp:ctor()
	return
end

function EquipResonanceLevelComp:update(arg_2_1)
	return
end

function EquipResonanceLevelComp:setLevel(arg_3_1)
	if arg_3_1 >= 0 and arg_3_1 < self.m_levelController:getPageCount() then
		self.m_levelController:setSelectedIndex(arg_3_1)
	end
end

function EquipResonanceLevelComp:onLoad()
	return
end

function EquipResonanceLevelComp:onUnload()
	return
end

return EquipResonanceLevelComp
