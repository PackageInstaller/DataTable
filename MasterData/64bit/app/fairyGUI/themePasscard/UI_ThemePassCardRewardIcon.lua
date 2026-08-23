local var_0_0 = {}

var_0_0.URL = "ui://tpt7g5qxpadug"

function var_0_0:__ctor()
	self.m_getController = self:getController("get")
	self.m_itemBgLoader = self:getChild("itemBgLoader")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_numTxt = self:getChild("numTxt")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_getLoader = self:getChild("getLoader")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.GetCtrl = {
	normal = 1,
	get = 0
}

return var_0_0
