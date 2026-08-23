local var_0_0 = {}

var_0_0.URL = "ui://9n9qtghbo2vt4u"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_sizeController = self:getController("size")
	self.m_isShowTimeController = self:getController("isShowTime")
	self.m_bossHolder = self:getChild("bossHolder")
	self.m_bossLoader = self:getChild("bossLoader")
	self.m_bossHeadIcon = self:getChild("bossHeadIcon")
	self.m_TimeTxt = self:getChild("TimeTxt")
end

return var_0_0
