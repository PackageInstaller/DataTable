local var_0_0 = {}

var_0_0.URL = "ui://kgq5r794b1a0ibmh"

function var_0_0:__ctor()
	self.m_readyController = self:getController("ready")
	self.m_oneKeyBattleController = self:getController("oneKeyBattle")
	self.m_playerBgComp1 = self:getChild("playerBgComp1")
	self.m_playerBgComp2 = self:getChild("playerBgComp2")
	self.m_player1 = self:getChild("player1")
	self.m_player2 = self:getChild("player2")
	self.m_checkOpenBtn = self:getChild("checkOpenBtn")
	self.m_dragDesc = self:getChild("dragDesc")
	self.m_campaignName = self:getChild("campaignName")
	self.m_timeAdd = self:getChild("timeAdd")
	self.m_teamAdd = self:getChild("teamAdd")
	self.m_infoTouchComp = self:getChild("infoTouchComp")
	self.m_oneKeyInviteBtn = self:getChild("oneKeyInviteBtn")
	self.m_lineUpBtn = self:getChild("lineUpBtn")
	self.m_oneKeyBattleBtn = self:getChild("oneKeyBattleBtn")
	self.m_starBattleBtn = self:getChild("starBattleBtn")
	self.m_chatBtn = self:getChild("chatBtn")
	self.m_leaveTimeTip = self:getChild("leaveTimeTip")
	self.m_topBar = self:getChild("topBar")
	self.m_leftCountComp = self:getChild("leftCountComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
