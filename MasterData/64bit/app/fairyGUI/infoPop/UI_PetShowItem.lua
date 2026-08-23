local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnvzejgic32"

function var_0_0:__ctor()
	self.m_isEnterController = self:getController("isEnter")
	self.m_shadowLoader = self:getChild("shadowLoader")
	self.m_colorLoader1 = self:getChild("colorLoader1")
	self.m_colorLoader2 = self:getChild("colorLoader2")
	self.m_colorLoader3 = self:getChild("colorLoader3")
	self.m_colorLoader4 = self:getChild("colorLoader4")
	self.m_colorLoader5 = self:getChild("colorLoader5")
	self.m_boxLoader1 = self:getChild("boxLoader1")
	self.m_boxLoader2 = self:getChild("boxLoader2")
	self.m_lineVer = self:getChild("lineVer")
	self.m_lineHor = self:getChild("lineHor")
	self.m_bgTipText = self:getChild("bgTipText")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_petMask = self:getChild("petMask")
	self.m_petIcon = self:getChild("petIcon")
	self.m_groupGLoader = self:getChild("groupGLoader")
	self.m_pointTipLoader = self:getChild("pointTipLoader")
	self.m_groupText = self:getChild("groupText")
	self.m_qualityGLoader = self:getChild("qualityGLoader")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_newSignIcon = self:getChild("newSignIcon")
	self.m_nameGroup = self:getChild("nameGroup")
	self.m_fragIcon = self:getChild("fragIcon")
	self.m_autoFragmentTxt = self:getChild("autoFragmentTxt")
	self.m_fragGroup = self:getChild("fragGroup")
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
