local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivm4fkfrge"

function var_0_0:__ctor()
	self.m_showTreasureController = self:getController("showTreasure")
	self.m_equip1QualityBg = self:getChild("equip1QualityBg")
	self.m_equip2QualityBg = self:getChild("equip2QualityBg")
	self.m_equip3QualityBg = self:getChild("equip3QualityBg")
	self.m_equip4QualityBg = self:getChild("equip4QualityBg")
	self.m_equip1 = self:getChild("equip1")
	self.m_equip2 = self:getChild("equip2")
	self.m_equip3 = self:getChild("equip3")
	self.m_equip4 = self:getChild("equip4")
	self.m_equipRedComp = self:getChild("equipRedComp")
	self.m_treasure1Quality = self:getChild("treasure1Quality")
	self.m_treasureDecorate1 = self:getChild("treasureDecorate1")
	self.m_treasureEffectDown1 = self:getChild("treasureEffectDown1")
	self.m_treasure1 = self:getChild("treasure1")
	self.m_treasureEffect1 = self:getChild("treasureEffect1")
	self.m_treasure1Level = self:getChild("treasure1Level")
	self.m_treasure2Quality = self:getChild("treasure2Quality")
	self.m_treasureDecorate2 = self:getChild("treasureDecorate2")
	self.m_treasureEffectDown2 = self:getChild("treasureEffectDown2")
	self.m_treasure2 = self:getChild("treasure2")
	self.m_treasureEffect2 = self:getChild("treasureEffect2")
	self.m_treasure2Level = self:getChild("treasure2Level")
	self.m_treasure1red = self:getChild("treasure1red")
	self.m_equipTouch1 = self:getChild("equipTouch1")
	self.m_equipTouch3 = self:getChild("equipTouch3")
	self.m_equipTouch4 = self:getChild("equipTouch4")
	self.m_equipTouch2 = self:getChild("equipTouch2")
	self.m_treasureTouch1 = self:getChild("treasureTouch1")
	self.m_treasureTouch2 = self:getChild("treasureTouch2")
	self.m_maskTouch1 = self:getChild("maskTouch1")
	self.m_maskTouch2 = self:getChild("maskTouch2")
	self.m_maskTouch3 = self:getChild("maskTouch3")
	self.m_maskTouch4 = self:getChild("maskTouch4")
	self.m_enter_0Transition = self:getTransition("enter_0")
	self.m_enter_1Transition = self:getTransition("enter_1")
end

var_0_0.ShowTreasureCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
