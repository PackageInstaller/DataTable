local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnjgwtl"

function var_0_0:__ctor()
	self.m_autoChooseController = self:getController("autoChoose")
	self.m_popPanel = self:getChild("popPanel")
	self.m_rewardList = self:getChild("rewardList")
	self.m_chooseNumComp = self:getChild("chooseNumComp")
	self.m_costIcon = self:getChild("costIcon")
	self.m_itemNum = self:getChild("itemNum")
	self.m_beginBtn = self:getChild("beginBtn")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.AutoChooseCtrl = {
	不选中 = 0,
	选中 = 1
}

return var_0_0
