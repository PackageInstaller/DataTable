local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnmpkagibwf"

function var_0_0:__ctor()
	self.m_btnNumberController = self:getController("btnNumber")
	self.m_popPanel = self:getChild("popPanel")
	self.m_descText = self:getChild("descText")
	self.m_placeHolderComp = self:getChild("placeHolderComp")
	self.m_worldBtn = self:getChild("worldBtn")
	self.m_guildBtn = self:getChild("guildBtn")
	self.m_content = self:getChild("content")
end

var_0_0.BtnNumberCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
