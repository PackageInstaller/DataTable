local var_0_0 = {}

var_0_0.URL = "ui://h35b870bgm4fl"

function var_0_0:__ctor()
	self.m_sortController = self:getController("sort")
	self.m_isShowStateController = self:getController("isShowState")
	self.m_sortBtn1 = self:getChild("sortBtn1")
	self.m_sortBtn2 = self:getChild("sortBtn2")
	self.m_sortBtn3 = self:getChild("sortBtn3")
	self.m_sortBtn4 = self:getChild("sortBtn4")
	self.m_memberList = self:getChild("memberList")
	self.m_placeHolderComp = self:getChild("placeHolderComp")
	self.m_appointComp = self:getChild("appointComp")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
