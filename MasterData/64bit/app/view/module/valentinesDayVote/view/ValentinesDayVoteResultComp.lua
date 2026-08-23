local ValentinesDayVoteResultComp = class("ValentinesDayVoteResultComp", require("app.fairyGUI.valentinesDayVote.UI_ValentinesDayVoteResultComp"))
local var_0_1 = g.core.model.User.valentinesDayVoteData

function ValentinesDayVoteResultComp:ctor()
	self.m_rankList:setVirtual(self)
	self.m_rankList:setItemRenderer(handler(self, self._onItemRenderer))

	self._knightsData = var_0_1:getAllKnightsData()
end

function ValentinesDayVoteResultComp:updateView(arg_2_1)
	self.m_rankList:setNumItems(#self._knightsData)
end

function ValentinesDayVoteResultComp:onLoad()
	self:updateView()
end

function ValentinesDayVoteResultComp:onUnload()
	return
end

function ValentinesDayVoteResultComp:_onItemRenderer(arg_5_1, arg_5_2)
	if self._knightsData[arg_5_1 + 1] then
		arg_5_2:update(self._knightsData[arg_5_1 + 1])
	end
end

return ValentinesDayVoteResultComp
