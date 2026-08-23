local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9l84a1s"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_headLoader = self:getChild("headLoader")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_valueTxt = self:getChild("valueTxt")
	self.m_Txt_index = self:getChild("Txt_index")
	self.m_Comp_star = self:getChild("Comp_star")
	self.m_elementLoader = self:getChild("elementLoader")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
