local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9693t"

function var_0_0:__ctor()
	self.m_result_stateController = self:getController("result_state")
	self.m_isLessFourLvController = self:getController("isLessFourLv")
	self.m_hasElemController = self:getController("hasElem")
	self.m_elemTypeController = self:getController("elemType")
	self.m_cityPic = self:getChild("cityPic")
	self.m_elemIcon = self:getChild("elemIcon")
	self.m_elemTipTypeIcon = self:getChild("elemTipTypeIcon")
	self.m_Txt_level = self:getChild("Txt_level")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_checkUserBtn = self:getChild("checkUserBtn")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_checkBtn = self:getChild("checkBtn")
end

var_0_0.Result_stateCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page4 = 4
}
var_0_0.IsLessFourLvCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.HasElemCtrl = {
	normal = 0,
	has = 1
}
var_0_0.ElemTypeCtrl = {
	down = 2,
	up = 1
}

return var_0_0
