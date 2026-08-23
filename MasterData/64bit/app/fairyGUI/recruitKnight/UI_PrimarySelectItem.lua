local var_0_0 = {}

var_0_0.URL = "ui://c64rm38ywczd1h"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_sizePic = self:getChild("sizePic")
	self.m_mask = self:getChild("mask")
	self.m_indexTextFront = self:getChild("indexTextFront")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_iconBtn = self:getChild("iconBtn")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_reviceBtn = self:getChild("reviceBtn")
	self.m_indexTextBack = self:getChild("indexTextBack")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_downTransition = self:getTransition("down")
	self.m_upTransition = self:getTransition("up")
end

var_0_0.StateCtrl = {
	locked = 3,
	recived = 2,
	selected = 1,
	recruit = 0
}

return var_0_0
