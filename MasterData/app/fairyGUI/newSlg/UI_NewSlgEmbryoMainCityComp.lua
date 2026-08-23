local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9b6x468r8"

function var_0_0:__ctor()
	self.m_showEmbryoController = self:getController("showEmbryo")
	self.m_buildPic = self:getChild("buildPic")
	self.m_embryoPic = self:getChild("embryoPic")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_authority = self:getChild("authority")
	self.m_previewBtn = self:getChild("previewBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ShowEmbryoCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
