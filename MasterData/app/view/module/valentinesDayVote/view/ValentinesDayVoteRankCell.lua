local ValentinesDayVoteRankCell = class("ValentinesDayVoteRankCell", require("app.fairyGUI.valentinesDayVote.UI_ValentinesDayVoteRankCell"))

function ValentinesDayVoteRankCell:ctor()
	return
end

function ValentinesDayVoteRankCell:update(arg_2_1)
	local var_2_0 = arg_2_1.score

	if arg_2_1.rank == 1 then
		self.m_typeController:setSelectedIndex(2)
	elseif arg_2_1.rank == 2 or arg_2_1.rank == 3 then
		self.m_typeController:setSelectedIndex(1)
	else
		self.m_typeController:setSelectedIndex(0)
	end

	self.m_rankTxt:setText(arg_2_1.rank)
	self.m_nameTxt:setText(arg_2_1.knight:getBaseInfo().name)
	self.m_scoreTxt:setText(var_2_0)
end

function ValentinesDayVoteRankCell:onLoad()
	return
end

function ValentinesDayVoteRankCell:onUnload()
	return
end

return ValentinesDayVoteRankCell
