local var_0_0 = {}

var_0_0.URL = "ui://c3jvi0x1ump22o"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_cornerController = self:getController("corner")
	self.m_isFragController = self:getController("isFrag")
	self.m_LUStateController = self:getController("LUState")
	self.m_isUnBuyController = self:getController("isUnBuy")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_item = self:getChild("item")
	self.m_effectIcon = self:getChild("effectIcon")
	self.m_tipBg = self:getChild("tipBg")
	self.m_tips = self:getChild("tips")
	self.m_num = self:getChild("num")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_cornerTxt = self:getChild("cornerTxt")
	self.m_oneCostComp = self:getChild("oneCostComp")
	self.m_twoCostComp = self:getChild("twoCostComp")
	self.m_touchBg = self:getChild("touchBg")
end

return var_0_0
