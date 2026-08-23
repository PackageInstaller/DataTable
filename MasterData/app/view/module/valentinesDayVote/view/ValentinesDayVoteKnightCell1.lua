local ValentinesDayVoteKnightCell1 = class("ValentinesDayVoteKnightCell1", require("app.fairyGUI.valentinesDayVote.UI_ValentinesDayVoteKnightCell1"))
local var_0_1 = g.core.common.Path

function ValentinesDayVoteKnightCell1:ctor()
	self:addClickListener(handler(self, self._onClickSelf))
end

function ValentinesDayVoteKnightCell1:update(arg_2_1, arg_2_2)
	self._data = arg_2_1

	self.m_rankController:setSelectedIndex(arg_2_2)

	local var_2_0 = arg_2_1.knight:getBaseInfo()

	self.m_nameTxt1:setText(var_2_0.name)
	self.m_nameTxt2:setText(var_2_0.name)
	self.m_scoreTxt1:setText(arg_2_1.score)
	self.m_scoreTxt2:setText(arg_2_1.score)
	self.m_knightLoader:setIcon(var_0_1:getMiddleKnightPicById(g.core.config.knight_base_info.get(arg_2_1.id).painted_id))
end

function ValentinesDayVoteKnightCell1:onLoad()
	return
end

function ValentinesDayVoteKnightCell1:onUnload()
	return
end

function ValentinesDayVoteKnightCell1:_onClickSelf()
	self:dispatchCompEvent("knightCell_click", {
		data = self._data
	})
end

return ValentinesDayVoteKnightCell1
