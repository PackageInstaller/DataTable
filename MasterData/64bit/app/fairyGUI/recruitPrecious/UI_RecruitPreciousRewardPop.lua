local var_0_0 = {}

var_0_0.URL = "ui://hw835jy1u50ci"

function var_0_0:__ctor()
	self.m_isTenController = self:getController("isTen")
	self.m_showTypeController = self:getController("showType")
	self.m_rewardItem1 = self:getChild("rewardItem1")
	self.m_rewardItem2 = self:getChild("rewardItem2")
	self.m_rewardItem3 = self:getChild("rewardItem3")
	self.m_rewardItem4 = self:getChild("rewardItem4")
	self.m_rewardItem5 = self:getChild("rewardItem5")
	self.m_rewardItem6 = self:getChild("rewardItem6")
	self.m_rewardItem7 = self:getChild("rewardItem7")
	self.m_rewardItem8 = self:getChild("rewardItem8")
	self.m_rewardItem9 = self:getChild("rewardItem9")
	self.m_rewardItem10 = self:getChild("rewardItem10")
	self.m_rewardItem = self:getChild("rewardItem")
	self.m_tipText = self:getChild("tipText")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_continueBtn = self:getChild("continueBtn")
	self.m_costIcon = self:getChild("costIcon")
	self.m_costNumText = self:getChild("costNumText")
	self.m_mapSpineComp = self:getChild("mapSpineComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
