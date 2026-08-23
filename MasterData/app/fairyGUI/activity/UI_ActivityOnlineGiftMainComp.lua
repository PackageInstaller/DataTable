local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wb0gx4"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_boxIconController = self:getController("boxIcon")
	self.m_title = self:getChild("title")
	self.m_descText = self:getChild("descText")
	self.m_activityTimeTxt = self:getChild("activityTimeTxt")
	self.m_helpBtn = self:getChild("helpBtn")
	self.m_leftTimeTxt = self:getChild("leftTimeTxt")
	self.m_leftTimeComp = self:getChild("leftTimeComp")
	self.m_boxIcon_2 = self:getChild("boxIcon")
	self.m_effCaseCrack = self:getChild("effCaseCrack")
	self.m_effCaseLine = self:getChild("effCaseLine")
	self.m_effCasePick = self:getChild("effCasePick")
	self.m_rewardList = self:getChild("rewardList")
	self.m_activeSpineNode = self:getChild("activeSpineNode")
	self.m_touchImage = self:getChild("touchImage")
	self.m_effRing = self:getChild("effRing")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	全部领取 = 2,
	破解中 = 0,
	已破解 = 1
}
var_0_0.BoxIconCtrl = {
	中宝箱 = 1,
	大宝箱 = 2,
	空 = 3,
	小宝箱 = 0
}

return var_0_0
