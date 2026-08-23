local ThemeAnubisBioVoteKnightDetailComp = class("ThemeAnubisBioVoteKnightDetailComp", require("app.fairyGUI.themeBio.UI_ThemeAnubisBioVoteKnightDetailComp"))

function ThemeAnubisBioVoteKnightDetailComp:ctor()
	self._info = nil

	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirmBtn))
end

function ThemeAnubisBioVoteKnightDetailComp:updateDetailComp(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	if arg_2_1.voteInfo then
		self._voteInfo = arg_2_1.voteInfo
	end

	if arg_2_1.optionVote then
		self._optionVote = arg_2_1.optionVote
	end

	if arg_2_1.chapterId then
		self._chapterId = arg_2_1.chapterId
	end

	if arg_2_1.optionTxt then
		self.m_descTxt:setText(arg_2_1.optionTxt)
	end

	if arg_2_1.showVotePercent and arg_2_1.votePercent then
		self.m_showTipController:setSelectedIndex(1)
		self.m_tipTxt:setText(g.core.lang:get(409150, {
			percent = arg_2_1.votePercent
		}))
	else
		self.m_showTipController:setSelectedIndex(0)
	end

	self.m_knightComp:updateKnightSelection(arg_2_1)
	self:_playEnterTransition()
end

function ThemeAnubisBioVoteKnightDetailComp:_playEnterTransition()
	self.m_enterTransition:play()
end

function ThemeAnubisBioVoteKnightDetailComp:_onClickConfirmBtn()
	if self._voteInfo then
		self:dispatchCompEvent("ThemeBioVoteKnight_onClickConfirmBtn", {
			voteId = self._voteInfo.id,
			optionVote = self._optionVote,
			chapterId = self._chapterId
		})
	end
end

function ThemeAnubisBioVoteKnightDetailComp:playBackTransition(arg_5_1)
	self.m_backTransition:play(function()
		arg_5_1()
	end)
end

return ThemeAnubisBioVoteKnightDetailComp
