local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oso3jdf"

function var_0_0:__ctor()
	self.m_hasUpValueController = self:getController("hasUpValue")
	self.m_hasGuildController = self:getController("hasGuild")
	self.m_fogEffHolder = self:getChild("fogEffHolder")
	self.m_waterEffHolder = self:getChild("waterEffHolder")
	self.m_rewardEffHolder = self:getChild("rewardEffHolder")
	self.m_maskBgDadComp = self:getChild("maskBgDadComp")
	self.m_clickGetRewardComp = self:getChild("clickGetRewardComp")
	self.m_rewardBtn = self:getChild("rewardBtn")
	self.m_rewardIcon1 = self:getChild("rewardIcon1")
	self.m_rewardIcon2 = self:getChild("rewardIcon2")
	self.m_tipsBtn = self:getChild("tipsBtn")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_tipsTxt = self:getChild("tipsTxt")
	self.m_tips = self:getChild("tips")
	self.m_idleItem1 = self:getChild("idleItem1")
	self.m_idleItem2 = self:getChild("idleItem2")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_guildTipText = self:getChild("guildTipText")
	self.m_buffTipsBtn = self:getChild("buffTipsBtn")
	self.m_buffText = self:getChild("buffText")
	self.m_tipsTipTxt = self:getChild("tipsTipTxt")
	self.m_buffTips = self:getChild("buffTips")
	self.m_guildBuffBtn = self:getChild("guildBuffBtn")
	self.m_guildBuffTextList = self:getChild("guildBuffTextList")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HasUpValueCtrl = {
	none = 0,
	has = 1
}
var_0_0.HasGuildCtrl = {
	none = 0,
	has = 1
}

return var_0_0
