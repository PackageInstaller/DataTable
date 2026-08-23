local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9693o"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_selTabController = self:getController("selTab")
	self.m_gradeController = self:getController("grade")
	self.m_decayController = self:getController("decay")
	self.m_Group_occupy = self:getChild("Group_occupy")
	self.m_tabGroup = self:getChild("tabGroup")
	self.m_Group_reward = self:getChild("Group_reward")
	self.m_btnGather = self:getChild("btnGather")
	self.m_Txt_cityDesc = self:getChild("Txt_cityDesc")
	self.m_buildLv = self:getChild("buildLv")
	self.m_btnBuild = self:getChild("btnBuild")
	self.m_Comp_troopNum = self:getChild("Comp_troopNum")
	self.m_troopNumTxt = self:getChild("troopNumTxt")
	self.m_Btn_checkDefenderInfo = self:getChild("Btn_checkDefenderInfo")
	self.m_infoGroup = self:getChild("infoGroup")
	self.m_inputTxt = self:getChild("inputTxt")
	self.m_deleteBtn = self:getChild("deleteBtn")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_touchComp = self:getChild("touchComp")
	self.m_promptTxt = self:getChild("promptTxt")
	self.m_editBtn = self:getChild("editBtn")
	self.m_noticeGroup = self:getChild("noticeGroup")
	self.m_decayTxt = self:getChild("decayTxt")
	self.m_loaderBtn = self:getChild("loaderBtn")
end

var_0_0.StateCtrl = {
	page7 = 7,
	page6 = 6,
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page10 = 10,
	page9 = 9,
	page8 = 8
}
var_0_0.SelTabCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.GradeCtrl = {
	page7 = 7,
	page6 = 6,
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page9 = 9,
	page8 = 8
}
var_0_0.DecayCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
