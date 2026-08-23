local ThemeAnubisBioVoteResultComp = class("ThemeAnubisBioVoteResultComp", require("app.fairyGUI.themeBio.UI_ThemeAnubisBioVoteResultComp"))

function ThemeAnubisBioVoteResultComp:ctor()
	self.m_reviewBtn:addClickListener(handler(self, self._onClickReviewBtn))
end

function ThemeAnubisBioVoteResultComp:onLoad()
	return
end

function ThemeAnubisBioVoteResultComp:onUnload()
	self.m_backTransition:play()
end

function ThemeAnubisBioVoteResultComp:playEnterEffect()
	self.m_enterTransition:play()
	self.m_effEnter:addEffectSpine({
		anim = "play",
		name = "eff_ui_themeBioVote_result",
		remove = true,
		isLoop = false
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Waltz_Truth)
end

function ThemeAnubisBioVoteResultComp:playSwitchEffect()
	self.m_switchTransition:play()
end

function ThemeAnubisBioVoteResultComp:updateResultComp(arg_6_1)
	arg_6_1 = arg_6_1 or {}
	self._voteInfo = arg_6_1.voteInfo
	self._optionInfo = arg_6_1.showOptionInfo

	if arg_6_1.voteInfo and arg_6_1.showOptionInfo then
		self.m_knightLoader:setURL(arg_6_1.iconPath)
		self.m_descTxt:getChild("title"):enableOutline(1, cc.c3b(50, 50, 50))
		self.m_descTxt:setText(arg_6_1.showOptionInfo.optionEnding)
		self.m_nameComp:updateNameComp({
			name = (g.core.config.knight_base_info.hasData(self._optionInfo.optionNo) or nil) and g.core.config.knight_base_info.get(self._optionInfo.optionNo).name
		})
	end
end

function ThemeAnubisBioVoteResultComp:_onClickReviewBtn()
	self:dispatchCompEvent("ThemeBioVoteResult_clickReviewBtn", {
		voteInfo = self._voteInfo,
		optionInfo = self._optionInfo
	})
end

return ThemeAnubisBioVoteResultComp
