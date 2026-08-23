local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oj8cxfg"

function var_0_0:__ctor()
	self.m_statusController = self:getController("status")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_btn_detail = self:getChild("btn_detail")
	self.m_txt_title = self:getChild("txt_title")
	self.m_txt_level = self:getChild("txt_level")
	self.m_txt_desc = self:getChild("txt_desc")
	self.m_upBtn = self:getChild("upBtn")
	self.m_itemCost = self:getChild("itemCost")
	self.m_maxLevelStatus = self:getChild("maxLevelStatus")
	self.m_txtLock = self:getChild("txtLock")
end

var_0_0.StatusCtrl = {
	已满级 = 1,
	可升级 = 0,
	周buff触发天赋 = 3,
	未解锁 = 2
}

return var_0_0
