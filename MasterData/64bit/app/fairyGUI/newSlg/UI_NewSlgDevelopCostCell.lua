local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o9j768p3"

function var_0_0:__ctor()
	self.m_isEnoughController = self:getController("isEnough")
	self.m_icon = self:getChild("icon")
	self.m_costTxt = self:getChild("costTxt")
end

var_0_0.IsEnoughCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
