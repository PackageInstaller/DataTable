local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9693n"

function var_0_0:__ctor()
	self.m_isLogEmptyController = self:getController("isLogEmpty")
	self.m_is_maxController = self:getController("is_max")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_Comp_cityView = self:getChild("Comp_cityView")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_bloodProg = self:getChild("bloodProg")
	self.m_bloodTxt = self:getChild("bloodTxt")
	self.m_buildTip = self:getChild("buildTip")
	self.m_compLevel1 = self:getChild("compLevel1")
	self.m_compLevel2 = self:getChild("compLevel2")
	self.m_Comp_progExp = self:getChild("Comp_progExp")
	self.m_expTxt = self:getChild("expTxt")
	self.m_curTroopNum = self:getChild("curTroopNum")
	self.m_arrow = self:getChild("arrow")
	self.m_nextTroopNum = self:getChild("nextTroopNum")
	self.m_logList = self:getChild("logList")
	self.m_changeNumComp = self:getChild("changeNumComp")
	self.m_ownComp = self:getChild("ownComp")
	self.m_buildBtn = self:getChild("buildBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsLogEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_maxCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
