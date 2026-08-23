local var_0_0 = {}

var_0_0.URL = "ui://2r646maydco1z"

function var_0_0:__ctor()
	self.m_titleTypeController = self:getController("titleType")
	self.m_titleList = self:getChild("titleList")
	self.m_infoTouch = self:getChild("infoTouch")
	self.m_curCollectNum = self:getChild("curCollectNum")
	self.m_totalNum = self:getChild("totalNum")
	self.m_attrBtn = self:getChild("attrBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.TitleTypeCtrl = {
	全部 = 0,
	活动产出 = 3,
	功能产出 = 2,
	VIP等级 = 1
}

return var_0_0
