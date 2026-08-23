local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiqt2we14"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isEnouchController = self:getController("isEnouch")
	self.m_isHotController = self:getController("isHot")
	self.m_bg = self:getChild("bg")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_numText = self:getChild("numText")
	self.m_nameText = self:getChild("nameText")
	self.m_limitDescText = self:getChild("limitDescText")
	self.m_limitNumText = self:getChild("limitNumText")
	self.m_limitGroup = self:getChild("limitGroup")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_costIcon = self:getChild("costIcon")
	self.m_costNumText = self:getChild("costNumText")
	self.m_costGroup = self:getChild("costGroup")
	self.m_soldText = self:getChild("soldText")
	self.m_lockText = self:getChild("lockText")
	self.m_zhezhao = self:getChild("zhezhao")
end

return var_0_0
