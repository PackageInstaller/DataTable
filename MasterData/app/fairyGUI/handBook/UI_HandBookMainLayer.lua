local var_0_0 = {}

var_0_0.URL = "ui://zwlhk6nx7diss"

function var_0_0:__ctor()
	self.m_selectStateController = self:getController("selectState")
	self.m_oneKeyController = self:getController("oneKey")
	self.m_bookList = self:getChild("bookList")
	self.m_selectBtn = self:getChild("selectBtn")
	self.m_processComp = self:getChild("processComp")
	self.m_oneKeyBtn = self:getChild("oneKeyBtn")
	self.m_touchLayer = self:getChild("touchLayer")
	self.m_groupList = self:getChild("groupList")
	self.m_runnerComp = self:getChild("runnerComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_selectComp = self:getChild("selectComp")
	self.m_pnlEnterTransition = self:getTransition("pnlEnter")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
