local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiqt2we0"

function var_0_0:__ctor()
	self.m_bgEffLoader = self:getChild("bgEffLoader")
	self.m_fireDownEffLoader = self:getChild("fireDownEffLoader")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_fireUpEffLoader = self:getChild("fireUpEffLoader")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_timeLoader = self:getChild("timeLoader")
	self.m_timeText = self:getChild("timeText")
	self.m_timeGroup = self:getChild("timeGroup")
	self.m_awardComp1 = self:getChild("awardComp1")
	self.m_awardComp2 = self:getChild("awardComp2")
	self.m_awardGroup = self:getChild("awardGroup")
	self.m_floorBtn = self:getChild("floorBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_jigsawBtn = self:getChild("jigsawBtn")
	self.m_giftBtn = self:getChild("giftBtn")
	self.m_btnGroup = self:getChild("btnGroup")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_taskTxt = self:getChild("taskTxt")
	self.m_taskRedPoint = self:getChild("taskRedPoint")
	self.m_taskGroup = self:getChild("taskGroup")
	self.m_itemBtn = self:getChild("itemBtn")
	self.m_itemEffLoader = self:getChild("itemEffLoader")
	self.m_itemNameText = self:getChild("itemNameText")
	self.m_itemNumText = self:getChild("itemNumText")
	self.m_itemRedPoint = self:getChild("itemRedPoint")
	self.m_itemGroup = self:getChild("itemGroup")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
