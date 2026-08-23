local var_0_0 = {}

var_0_0.URL = "ui://irs65rtsjvy4m4k"

function var_0_0:__ctor()
	self.m_isPlaceController = self:getController("isPlace")
	self.m_isShowBubbleController = self:getController("isShowBubble")
	self.m_roleHolderComp = self:getChild("roleHolderComp")
	self.m_bathEff = self:getChild("bathEff")
	self.m_actionCircleBar = self:getChild("actionCircleBar")
	self.m_effDadComp = self:getChild("effDadComp")
	self.m_bubImg = self:getChild("bubImg")
	self.m_bathBubBtn = self:getChild("bathBubBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
