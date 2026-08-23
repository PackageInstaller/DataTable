local var_0_0 = {}

var_0_0.URL = "ui://nhmdbbcvw7z3gic5b"

function var_0_0:__ctor()
	self.m_closePnl = self:getChild("closePnl")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_bottomLine = self:getChild("bottomLine")
	self.m_imgLoader = self:getChild("imgLoader")
	self.m_title = self:getChild("title")
	self.m_nameComp = self:getChild("nameComp")
	self.m_oldStageTxt = self:getChild("oldStageTxt")
	self.m_stageTxt = self:getChild("stageTxt")
	self.m_attrList = self:getChild("attrList")
	self.m_skillUpdateDescTxt = self:getChild("skillUpdateDescTxt")
	self.m_descTxt1 = self:getChild("descTxt1")
	self.m_skillNameTxt = self:getChild("skillNameTxt")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_skill1 = self:getChild("skill1")
	self.m_lvUpEffHolder = self:getChild("lvUpEffHolder")
	self.m_normalState = self:getChild("normalState")
	self.m_enter_1Transition = self:getTransition("enter_1")
	self.m_back_1Transition = self:getTransition("back_1")
	self.m_back_0Transition = self:getTransition("back_0")
	self.m_enter_0Transition = self:getTransition("enter_0")
end

return var_0_0
