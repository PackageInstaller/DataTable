local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jdif969m3"

function var_0_0:__ctor()
	self.m_bgTypeController = self:getController("bgType")
	self.m_useController = self:getController("use")
	self.m_canChoseController = self:getController("canChose")
	self.m_iconBg = self:getChild("iconBg")
	self.m_nameText = self:getChild("nameText")
	self.m_desTxt = self:getChild("desTxt")
	self.m_touchMask = self:getChild("touchMask")
	self.m_useBtn = self:getChild("useBtn")
	self.m_mask = self:getChild("mask")
	self.m_usingGroup = self:getChild("usingGroup")
	self.m_effNode = self:getChild("effNode")
end

var_0_0.BgTypeCtrl = {
	three = 2,
	two = 1,
	one = 0
}
var_0_0.UseCtrl = {
	use = 1,
	normal = 0
}
var_0_0.CanChoseCtrl = {
	can = 1,
	forbid = 0
}

return var_0_0
