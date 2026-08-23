local BaseEquipResonanceLevelComp = class("BaseEquipResonanceLevelComp", require("app.fairyGUI.base_new.UI_BaseEquipResonanceLevelComp"))

function BaseEquipResonanceLevelComp:ctor()
	return
end

function BaseEquipResonanceLevelComp:update(arg_2_1)
	return
end

function BaseEquipResonanceLevelComp:onLoad()
	return
end

function BaseEquipResonanceLevelComp:onUnload()
	return
end

function BaseEquipResonanceLevelComp:setResonanceLevel(arg_5_1)
	if arg_5_1 then
		self.m_levelController:setSelectedIndex(arg_5_1)
	end
end

return BaseEquipResonanceLevelComp
