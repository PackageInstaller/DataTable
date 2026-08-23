local ValentinesDayVoteKnightCell2 = class("ValentinesDayVoteKnightCell2", require("app.fairyGUI.valentinesDayVote.UI_ValentinesDayVoteKnightCell2"))
local var_0_1 = g.core.common.Path

function ValentinesDayVoteKnightCell2:ctor()
	self:addClickListener(handler(self, self._onClickSelf))
end

function ValentinesDayVoteKnightCell2:update(arg_2_1, arg_2_2)
	self._data = arg_2_1

	self.m_nameTxt:setText(arg_2_1.knight:getBaseInfo().name)
	self.m_scoreTxt:setText(arg_2_1.score)
	self.m_knightLoader:setURL(var_0_1:getKnightIconById(g.core.config.knight_base_info.get(arg_2_1.id).painted_id))
end

function ValentinesDayVoteKnightCell2:onLoad()
	return
end

function ValentinesDayVoteKnightCell2:onUnload()
	return
end

function ValentinesDayVoteKnightCell2:_onClickSelf()
	self:dispatchCompEvent("knightCell_click", {
		data = self._data
	})
end

return ValentinesDayVoteKnightCell2
