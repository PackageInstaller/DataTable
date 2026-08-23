local var_0_0 = {}

var_0_0.URL = "ui://gntkqnnjkvbj3"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_isHavePassiveController = self:getController("isHavePassive")
	self.m_isMaxLevelController = self:getController("isMaxLevel")
	self.m_openOneKeyController = self:getController("openOneKey")
	self.m_popPanel = self:getChild("popPanel")
	self.m_memberList = self:getChild("memberList")
	self.m_tissueLoader = self:getChild("tissueLoader")
	self.m_detailsArea = self:getChild("detailsArea")
	self.m_baseAttrBtn = self:getChild("baseAttrBtn")
	self.m_passiveAttrBtn = self:getChild("passiveAttrBtn")
	self.m_touchGraph = self:getChild("touchGraph")
	self.m_condProgress = self:getChild("condProgress")
	self.m_curValueTxt = self:getChild("curValueTxt")
	self.m_maxValueTxt = self:getChild("maxValueTxt")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_condGroup = self:getChild("condGroup")
	self.m_tissueLevelTxt = self:getChild("tissueLevelTxt")
	self.m_content = self:getChild("content")
	self.m_oneKeyBtn = self:getChild("oneKeyBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_showOneKeyTransition = self:getTransition("showOneKey")
end

var_0_0.IsActiveCtrl = {
	未激活 = 0,
	已激活 = 1
}
var_0_0.IsHavePassiveCtrl = {
	无被动 = 0,
	有被动 = 1
}
var_0_0.IsMaxLevelCtrl = {
	page0 = 0,
	满级 = 1
}
var_0_0.OpenOneKeyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
