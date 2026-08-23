local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepd85e5ibhy"

function var_0_0:__ctor()
	self.m_hasRedPacketController = self:getController("hasRedPacket")
	self.m_chatBtn = self:getChild("chatBtn")
	self.m_channelText = self:getChild("channelText")
	self.m_chatText = self:getChild("chatText")
	self.m_effectNode = self:getChild("effectNode")
end

var_0_0.HasRedPacketCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
