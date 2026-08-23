local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074wurd2w"

function var_0_0:__ctor()
	self.m_isOwnerController = self:getController("isOwner")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_fightGroup = self:getChild("fightGroup")
end

var_0_0.IsOwnerCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
