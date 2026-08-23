local var_0_0 = {}

var_0_0.URL = "ui://2r646mayhbtp17"

function var_0_0:__ctor()
	self.m_isWearController = self:getController("isWear")
	self.m_isOwnController = self:getController("isOwn")
	self.m_getText = self:getChild("getText")
	self.m_descText = self:getChild("descText")
	self.m_titleIcon = self:getChild("titleIcon")
	self.m_attrsList = self:getChild("attrsList")
	self.m_nameText = self:getChild("nameText")
	self.m_ownTimeText = self:getChild("ownTimeText")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsWearCtrl = {
	是 = 1,
	否 = 0
}
var_0_0.IsOwnCtrl = {
	是 = 1,
	否 = 0
}

return var_0_0
