local var_0_0 = {}

var_0_0.URL = "ui://2r646mayj4s02u"

function var_0_0:__ctor()
	self.m_isWearController = self:getController("isWear")
	self.m_isOwnController = self:getController("isOwn")
	self.m_isOtherUserController = self:getController("isOtherUser")
	self.m_isLimitTimeController = self:getController("isLimitTime")
	self.m_titleIcon = self:getChild("titleIcon")
	self.m_effHolder = self:getChild("effHolder")
	self.m_descText = self:getChild("descText")
	self.m_getText = self:getChild("getText")
	self.m_nameText = self:getChild("nameText")
	self.m_attrTxt = self:getChild("attrTxt")
	self.m_attrGroup = self:getChild("attrGroup")
	self.m_ownTimeText = self:getChild("ownTimeText")
	self.m_limitTimeTxt = self:getChild("limitTimeTxt")
	self.m_expireTimeTxt = self:getChild("expireTimeTxt")
end

var_0_0.IsWearCtrl = {
	是 = 1,
	否 = 0
}
var_0_0.IsOwnCtrl = {
	是 = 1,
	否 = 0
}
var_0_0.IsOtherUserCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsLimitTimeCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
