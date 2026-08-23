local var_0_0 = {}

var_0_0.URL = "ui://z48x0zjhofaj17"

function var_0_0:__ctor()
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_titleBg = self:getChild("titleBg")
	self.m_gradeLoader = self:getChild("gradeLoader")
	self.m_title = self:getChild("title")
	self.m_descTxt = self:getChild("descTxt")
	self.m_infoBg = self:getChild("infoBg")
	self.m_firstTips = self:getChild("firstTips")
	self.m_gradeTips = self:getChild("gradeTips")
	self.m_firstAwardList = self:getChild("firstAwardList")
	self.m_gradeList = self:getChild("gradeList")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
