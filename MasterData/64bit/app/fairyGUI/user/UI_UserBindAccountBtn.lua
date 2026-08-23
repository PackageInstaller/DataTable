local var_0_0 = {}

var_0_0.URL = "ui://2r646maytj702j"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_channelController = self:getController("channel")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ChannelCtrl = {
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page6 = 6
}

return var_0_0
