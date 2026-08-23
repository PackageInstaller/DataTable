local var_0_0 = {}

var_0_0.URL = "ui://n47h6oagknq93t"

function var_0_0:__ctor()
	self.m_hasAdditionController = self:getController("hasAddition")
	self.m_rankList = self:getChild("rankList")
	self.m_guildNameTxt = self:getChild("guildNameTxt")
	self.m_additionTxt = self:getChild("additionTxt")
	self.m_gloryBtn = self:getChild("gloryBtn")
	self.m_topBarComp = self:getChild("topBarComp")
end

var_0_0.HasAdditionCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
