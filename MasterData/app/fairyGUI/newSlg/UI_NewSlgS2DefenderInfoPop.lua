local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb96943"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_bg = self:getChild("bg")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_allianceName = self:getChild("allianceName")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_defenderComp = self:getChild("defenderComp")
	self.m_Txt_authority = self:getChild("Txt_authority")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
