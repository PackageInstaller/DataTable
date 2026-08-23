local ThemeAnubisBioVoteKnightSelectionComp = class("ThemeAnubisBioVoteKnightSelectionComp", require("app.fairyGUI.themeBio.UI_ThemeAnubisBioVoteKnightSelectionComp"))
local var_0_1 = g.core.model.User.themeData
local var_0_2 = g.core.config.knight_base_info

function ThemeAnubisBioVoteKnightSelectionComp:ctor()
	self.m_touch:addClickListener(handler(self, self._onClickSelf))
end

function ThemeAnubisBioVoteKnightSelectionComp:update(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	self.m_nameComp:setVisible(false)

	self._themeValue = arg_2_1.themeValue

	if not self._themeValue then
		return
	end

	local var_2_0 = var_0_1:getThemeData(self._themeValue)

	self._themeBioData = var_2_0 and var_2_0:getThemeBioData()
end

function ThemeAnubisBioVoteKnightSelectionComp:updateKnightSelection(arg_3_1)
	arg_3_1 = arg_3_1 or {}
	self._params = arg_3_1
	self._optionInfo = arg_3_1.optionInfo
	self._voteInfo = arg_3_1.voteInfo
	self._chapterId = arg_3_1.chapterId
	self._compIndex = arg_3_1.compIndex
	self._isUnlockedEnding = arg_3_1.isUnlockedEnding

	local var_3_0 = 0
	local var_3_1 = 0

	if arg_3_1.isSelected then
		var_3_1 = 1
		var_3_0 = 1
	end

	self.m_nameComp:updateNameComp({
		name = (var_0_2.hasData(self._optionInfo.optionNo) or nil) and var_0_2.get(self._optionInfo.optionNo).name,
		subTitle = var_3_0,
		state = var_3_1
	})
	self.m_picComp:updateKnightComp({
		optionNo = arg_3_1.optionInfo.optionNo,
		state = var_3_1,
		hasVoted = arg_3_1.hasVoted,
		isUnlockedEnding = self._isUnlockedEnding
	})
end

function ThemeAnubisBioVoteKnightSelectionComp:_onClickSelf()
	if self._isUnlockedEnding then
		self:setSelected(false)
	end

	self:dispatchCompEvent("ThemeBioVote_clickKnight", {
		compIndex = self._compIndex,
		voteInfo = self._voteInfo,
		optionVote = self._optionInfo.optionVote,
		optionTxt = self._optionInfo.optionTxt,
		chapterId = self._chapterId,
		isUnlockedEnding = self._isUnlockedEnding
	})
end

return ThemeAnubisBioVoteKnightSelectionComp
