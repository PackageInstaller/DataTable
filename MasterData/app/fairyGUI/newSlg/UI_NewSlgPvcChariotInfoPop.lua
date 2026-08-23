local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9z25j3h"

function var_0_0:__ctor()
	self.m_gather_stateController = self:getController("gather_state")
	self.m_is_emptyController = self:getController("is_empty")
	self.m_isMulAlliController = self:getController("isMulAlli")
	self.m_hasElemController = self:getController("hasElem")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_List_team = self:getChild("List_team")
	self.m_Btn_gather = self:getChild("Btn_gather")
	self.m_Txt_authority = self:getChild("Txt_authority")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_allianceNameTxt = self:getChild("allianceNameTxt")
	self.m_elemIcon = self:getChild("elemIcon")
	self.m_elemTipTypeIcon = self:getChild("elemTipTypeIcon")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.Gather_stateCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}
var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsMulAlliCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasElemCtrl = {
	has = 1,
	normal = 0
}

return var_0_0
