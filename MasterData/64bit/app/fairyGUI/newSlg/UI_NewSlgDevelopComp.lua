local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9fdwl68et"

function var_0_0:__ctor()
	self.m_isCommandSelController = self:getController("isCommandSel")
	self.m_isSupplySelController = self:getController("isSupplySel")
	self.m_isS2Controller = self:getController("isS2")
	self.m_supplySel = self:getChild("supplySel")
	self.m_imgSupply = self:getChild("imgSupply")
	self.m_supplyBtn = self:getChild("supplyBtn")
	self.m_imgBarrack1 = self:getChild("imgBarrack1")
	self.m_imgBarrack2 = self:getChild("imgBarrack2")
	self.m_imgBarrack3 = self:getChild("imgBarrack3")
	self.m_imgCommand = self:getChild("imgCommand")
	self.m_commandSel = self:getChild("commandSel")
	self.m_commandBtn = self:getChild("commandBtn")
	self.m_barrackBtn1 = self:getChild("barrackBtn1")
	self.m_barrackBtn2 = self:getChild("barrackBtn2")
	self.m_barrackBtn3 = self:getChild("barrackBtn3")
	self.m_getComp = self:getChild("getComp")
	self.m_touchComp = self:getChild("touchComp")
	self.m_upgradeBtn = self:getChild("upgradeBtn")
	self.m_embryoBtn = self:getChild("embryoBtn")
	self.m_supplyUpBtn = self:getChild("supplyUpBtn")
	self.m_supplyGetBtn = self:getChild("supplyGetBtn")
	self.m_comSelTransition = self:getTransition("comSel")
	self.m_supSelTransition = self:getTransition("supSel")
end

var_0_0.IsCommandSelCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsSupplySelCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsS2Ctrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
