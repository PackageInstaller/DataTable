local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5ktqr7ey"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isShowTypeTextController = self:getController("isShowTypeText")
	self.m_levelShowTypeController = self:getController("levelShowType")
	self.m_isShowNameController = self:getController("isShowName")
	self.m_hideBgController = self:getController("hideBg")
	self.m_decorateFrame = self:getChild("decorateFrame")
	self.m_bgEffectComp = self:getChild("bgEffectComp")
	self.m_rootBg = self:getChild("rootBg")
	self.m_iconBg = self:getChild("iconBg")
	self.m_skillTypeLeftBg = self:getChild("skillTypeLeftBg")
	self.m_skillTypeText = self:getChild("skillTypeText")
	self.m_typeGroup = self:getChild("typeGroup")
	self.m_nameText = self:getChild("nameText")
	self.m_levelBg = self:getChild("levelBg")
	self.m_levelText = self:getChild("levelText")
	self.m_levelGroup = self:getChild("levelGroup")
	self.m_imgEmpty = self:getChild("imgEmpty")
	self.m_starComp = self:getChild("starComp")
end

return var_0_0
