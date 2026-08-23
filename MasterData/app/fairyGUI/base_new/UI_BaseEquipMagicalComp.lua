local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepnyyl1emigin"

function var_0_0:__ctor()
	self.m_equipTypeController = self:getController("equipType")
	self.m_stage1 = self:getChild("stage1")
	self.m_stage2 = self:getChild("stage2")
	self.m_stage3 = self:getChild("stage3")
	self.m_stage4 = self:getChild("stage4")
	self.m_stage5 = self:getChild("stage5")
	self.m_stage6 = self:getChild("stage6")
	self.m_stage7 = self:getChild("stage7")
	self.m_stage8 = self:getChild("stage8")
	self.m_stage9 = self:getChild("stage9")
	self.m_stage10 = self:getChild("stage10")
end

var_0_0.EquipTypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
