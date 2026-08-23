local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiqt2weu"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_bg = self:getChild("bg")
	self.m_tittle = self:getChild("tittle")
	self.m_zhezhao = self:getChild("zhezhao")
	self.m_selectBg = self:getChild("selectBg")
	self.m_costIcon = self:getChild("costIcon")
	self.m_costNumText = self:getChild("costNumText")
end

return var_0_0
