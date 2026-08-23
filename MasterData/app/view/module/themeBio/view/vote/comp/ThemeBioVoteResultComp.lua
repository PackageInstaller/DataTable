local ThemeBioVoteResultComp = class("ThemeBioVoteResultComp", require("app.fairyGUI.themeBio.UI_ThemeBioVoteResultComp"))

function ThemeBioVoteResultComp:ctor()
	self.m_reviewBtn:addClickListener(handler(self, self._onClickReviewBtn))
end

function ThemeBioVoteResultComp:onLoad()
	return
end

function ThemeBioVoteResultComp:onUnload()
	self.m_backTransition:play()
end

function ThemeBioVoteResultComp:playEnterEffect()
	self.m_enterTransition:play()
	self.m_effEnter:addEffectSpine({
		anim = "play",
		name = "eff_ui_themeBioVote_result",
		remove = true,
		isLoop = false
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Waltz_Truth)
end

function ThemeBioVoteResultComp:playSwitchEffect()
	self.m_switchTransition:play()
end

function ThemeBioVoteResultComp:updateResultComp(arg_6_1)
	arg_6_1 = arg_6_1 or {}

	local var_6_0 = arg_6_1.voteInfo

	self._voteInfo = arg_6_1.voteInfo
	self._optionInfo = arg_6_1.showOptionInfo

	if var_6_0 and arg_6_1.showOptionInfo then
		self.m_resultKnight:updateKnightSelection({
			nameState = 2,
			voteInfo = var_6_0,
			optionInfo = arg_6_1.showOptionInfo,
			iconPath = arg_6_1.iconPath
		})
		self.m_descTxt:setText(arg_6_1.showOptionInfo.optionEnding)
	end
end

function ThemeBioVoteResultComp:_onClickReviewBtn()
	self:dispatchCompEvent("ThemeBioVoteResult_clickReviewBtn", {
		voteInfo = self._voteInfo,
		optionInfo = self._optionInfo
	})
end

return ThemeBioVoteResultComp
