local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcxfgb70"

function var_0_0:__ctor()
	self.m_showBottom = self:getChild("showBottom")
	self.m_bubbleRoot = self:getChild("bubbleRoot")
	self.m_showKnight = self:getChild("showKnight")
	self.m_leftBtn = self:getChild("leftBtn")
	self.m_rightBtn = self:getChild("rightBtn")
	self.m_userIcon = self:getChild("userIcon")
	self.m_userName = self:getChild("userName")
	self.m_fightValue = self:getChild("fightValue")
	self.m_serverName = self:getChild("serverName")
	self.m_guildName = self:getChild("guildName")
	self.m_showTitle = self:getChild("showTitle")
	self.m_showDesc = self:getChild("showDesc")
	self.m_likeBtn = self:getChild("likeBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
	self.m_left_InTransition = self:getTransition("left_In")
	self.m_right_InTransition = self:getTransition("right_In")
end

return var_0_0
