local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepp1v6iboy"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_iconStateController = self:getController("iconState")
	self.m_title1 = self:getChild("title1")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.TypeCtrl = {
	黑底红标 = 0,
	白底黑标 = 1
}
var_0_0.IconStateCtrl = {
	无icon = 1,
	有icon = 0
}

return var_0_0
