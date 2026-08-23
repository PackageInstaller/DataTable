local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnnrr5gic31"

function var_0_0:__ctor()
	self.m_isEnterController = self:getController("isEnter")
	self.m_bgTipText = self:getChild("bgTipText")
	self.m_artifactGroupBg = self:getChild("artifactGroupBg")
	self.m_shadowLoader = self:getChild("shadowLoader")
	self.m_bgRightLoader = self:getChild("bgRightLoader")
	self.m_lineVer = self:getChild("lineVer")
	self.m_lineHor = self:getChild("lineHor")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_knightMask = self:getChild("knightMask")
	self.m_artifactIcon = self:getChild("artifactIcon")
	self.m_groupGLoader = self:getChild("groupGLoader")
	self.m_groupText = self:getChild("groupText")
	self.m_qualityGLoader = self:getChild("qualityGLoader")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_newSignIcon = self:getChild("newSignIcon")
	self.m_nameGroup = self:getChild("nameGroup")
	self.m_fragIcon = self:getChild("fragIcon")
	self.m_autoFragmentTxt = self:getChild("autoFragmentTxt")
	self.m_fragGroup = self:getChild("fragGroup")
	self.m_bgRightLoader1 = self:getChild("bgRightLoader1")
	self.m_bgRightLoader2 = self:getChild("bgRightLoader2")
	self.m_bgRightLoader3 = self:getChild("bgRightLoader3")
	self.m_groupText1 = self:getChild("groupText1")
	self.m_groupText2 = self:getChild("groupText2")
	self.m_add = self:getChild("add")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_outTransition = self:getTransition("out")
	self.m_inTransition = self:getTransition("in")
end

var_0_0.IsEnterCtrl = {
	enter = 1,
	exit = 0
}

return var_0_0
