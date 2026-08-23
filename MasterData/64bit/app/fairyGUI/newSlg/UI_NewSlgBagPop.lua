local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9whxt68rx"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isExpireController = self:getController("isExpire")
	self.m_popPanel = self:getChild("popPanel")
	self.m_itemList = self:getChild("itemList")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_nameBgLoader = self:getChild("nameBgLoader")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_title = self:getChild("title")
	self.m_haveTxt = self:getChild("haveTxt")
	self.m_descComp = self:getChild("descComp")
	self.m_useBtn = self:getChild("useBtn")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_limitTimeIcon = self:getChild("limitTimeIcon")
	self.m_content = self:getChild("content")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsExpireCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
