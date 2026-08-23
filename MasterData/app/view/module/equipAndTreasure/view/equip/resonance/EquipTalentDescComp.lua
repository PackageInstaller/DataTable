local EquipTalentDescComp = class("EquipTalentDescComp", require("app.fairyGUI.equipAndTreasure.UI_EquipTalentDescComp"))

function EquipTalentDescComp:ctor()
	self._maxDescWidth = self.m_descText:getWidth()
end

function EquipTalentDescComp:updateComp(arg_2_1)
	self.m_nameComp:setTitle(arg_2_1.name)
	self.m_descText:setText(arg_2_1.desc)
	self.m_descText:setWidth(self._maxDescWidth)
	self.m_descText:setText(arg_2_1.desc, true, true)
	self.m_descText:setWidth(math.ceil(self.m_descText:getTextSize().width))
end

return EquipTalentDescComp
