local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oj8511emigb1"

function var_0_0:__ctor()
	self.m_ownSealStateController = self:getController("ownSealState")
	self.m_sealQualityIcon = self:getChild("sealQualityIcon")
	self.m_sealIcon = self:getChild("sealIcon")
end

var_0_0.OwnSealStateCtrl = {
	noneSeal = 0,
	ownSeal = 1
}

return var_0_0
