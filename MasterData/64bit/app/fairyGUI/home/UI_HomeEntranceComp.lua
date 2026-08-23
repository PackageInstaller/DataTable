local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgd85e5ibhx"

function var_0_0:__ctor()
	self.m_homeLandBtn = self:getChild("homeLandBtn")
	self.m_guildBtn = self:getChild("guildBtn")
	self.m_lineUpBtn = self:getChild("lineUpBtn")
	self.m_knightBagBtn = self:getChild("knightBagBtn")
	self.m_uniteTokenBtn = self:getChild("uniteTokenBtn")
	self.m_petBagBtn = self:getChild("petBagBtn")
	self.m_bagBtn = self:getChild("bagBtn")
	self.m_dungeonBtn = self:getChild("dungeonBtn")
	self.m_campaignBtn = self:getChild("campaignBtn")
	self.m_homelandRedPointComp = self:getChild("homelandRedPointComp")
	self.m_h5ActivityList = self:getChild("h5ActivityList")
	self.m_auctionBtn = self:getChild("auctionBtn")
	self.m_newBioBubbleComp = self:getChild("newBioBubbleComp")
	self.m_inTransition = self:getTransition("in")
	self.m_outTransition = self:getTransition("out")
end

return var_0_0
