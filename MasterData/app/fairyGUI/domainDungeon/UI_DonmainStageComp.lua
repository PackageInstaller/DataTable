local var_0_0 = {}

var_0_0.URL = "ui://z48x0zjhofajj"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isSelectController = self:getController("isSelect")
	self.m_stageLoader = self:getChild("stageLoader")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_selectLoader = self:getChild("selectLoader")
	self.m_loopEff = self:getChild("loopEff")
	self.m_gradeLoader = self:getChild("gradeLoader")
	self.m_stageTxt = self:getChild("stageTxt")
	self.m_gradeEff = self:getChild("gradeEff")
	self.m_unlockEff = self:getChild("unlockEff")
end

return var_0_0
