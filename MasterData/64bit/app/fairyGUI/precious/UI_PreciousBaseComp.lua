local var_0_0 = {}

var_0_0.URL = "ui://671qywx2gn4yn"

function var_0_0:__ctor()
	self.m_hideStageController = self:getController("hideStage")
	self.m_isOwnController = self:getController("isOwn")
	self.m_isSelectController = self:getController("isSelect")
	self.m_selectBg = self:getChild("selectBg")
	self.m_icon = self:getChild("icon")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_starComp = self:getChild("starComp")
	self.m_stageTxt = self:getChild("stageTxt")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
