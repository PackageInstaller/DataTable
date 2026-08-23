local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkxd0cm"

function var_0_0:__ctor()
	self.m_showWorkTipController = self:getController("showWorkTip")
	self.m_mapComp = self:getChild("mapComp")
	self.m_openCardBtn = self:getChild("openCardBtn")
	self.m_meteorBtn = self:getChild("meteorBtn")
	self.m_dartBtn = self:getChild("dartBtn")
	self.m_knightBtn = self:getChild("knightBtn")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_logBtn = self:getChild("logBtn")
	self.m_buffAttrBtn = self:getChild("buffAttrBtn")
	self.m_formationBtn = self:getChild("formationBtn")
	self.m_bagBtn = self:getChild("bagBtn")
	self.m_chatBtn = self:getChild("chatBtn")
	self.m_roomBtn = self:getChild("roomBtn")
	self.m_activePointComp = self:getChild("activePointComp")
	self.m_teamComp = self:getChild("teamComp")
	self.m_tipPosComp = self:getChild("tipPosComp")
	self.m_limitBtn = self:getChild("limitBtn")
	self.m_killNumTxt = self:getChild("killNumTxt")
	self.m_workComp = self:getChild("workComp")
	self.m_roomTitle = self:getChild("roomTitle")
	self.m_serverComp = self:getChild("serverComp")
	self.m_tipTouchComp = self:getChild("tipTouchComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ShowWorkTipCtrl = {
	hide = 0,
	show = 1
}

return var_0_0
