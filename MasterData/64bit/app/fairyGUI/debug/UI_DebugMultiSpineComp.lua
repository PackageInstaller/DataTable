local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7yeu6pl5ibli"

function var_0_0:__ctor()
	self.m_spineList = self:getChild("spineList")
	self.m_spineHolder = self:getChild("spineHolder")
	self.m_backHolder = self:getChild("backHolder")
	self.m_clearBtn = self:getChild("clearBtn")
	self.m_spineInput = self:getChild("spineInput")
	self.m_skinName = self:getChild("skinName")
	self.m_isUseSlot = self:getChild("isUseSlot")
	self.m_generateBtn = self:getChild("generateBtn")
end

return var_0_0
