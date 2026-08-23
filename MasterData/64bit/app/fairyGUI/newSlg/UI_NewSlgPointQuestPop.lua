local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9vqq65y"

function var_0_0:__ctor()
	self.m_groupPic = self:getChild("groupPic")
	self.m_descTxt = self:getChild("descTxt")
	self.m_taskDescTxt = self:getChild("taskDescTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
