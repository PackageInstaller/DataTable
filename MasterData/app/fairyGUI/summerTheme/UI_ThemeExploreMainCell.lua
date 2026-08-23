local var_0_0 = {}

var_0_0.URL = "ui://99hn3059lz1jkk31p"

function var_0_0:__ctor()
	self.m_lockController = self:getController("lock")
	self.m_isOpenController = self:getController("isOpen")
	self.m_typeController = self:getController("type")
	self.m_infoComp = self:getChild("infoComp")
	self.m_picLoader = self:getChild("picLoader")
	self.m_progressTxt = self:getChild("progressTxt")
	self.m_progress = self:getChild("progress")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_unlockEffHolder = self:getChild("unlockEffHolder")
	self.m_lockDesc = self:getChild("lockDesc")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_openTransition = self:getTransition("open")
	self.m_closeTransition = self:getTransition("close")
end

var_0_0.LockCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsOpenCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.TypeCtrl = {
	page2 = 3,
	page1 = 1,
	page4 = 15,
	page0 = 0,
	page3 = 5
}

return var_0_0
