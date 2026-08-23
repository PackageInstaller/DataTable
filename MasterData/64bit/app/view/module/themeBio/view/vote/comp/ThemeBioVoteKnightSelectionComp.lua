local ThemeBioVoteKnightSelectionComp = class("ThemeBioVoteKnightSelectionComp", require("app.fairyGUI.themeBio.UI_ThemeBioVoteKnightSelectionComp"))
local var_0_1 = g.core.model.User.themeData
local var_0_2 = g.core.config.knight_base_info

function ThemeBioVoteKnightSelectionComp:ctor()
	self.m_touch:addClickListener(handler(self, self._onClickSelf))
end

function ThemeBioVoteKnightSelectionComp:update(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	self.m_nameComp:setVisible(false)

	self._themeValue = arg_2_1.themeValue

	if not self._themeValue then
		return
	end

	local var_2_0 = var_0_1:getThemeData(self._themeValue)

	self._themeBioData = var_2_0 and var_2_0:getThemeBioData()
end

function ThemeBioVoteKnightSelectionComp:onLoad()
	return
end

function ThemeBioVoteKnightSelectionComp:onUnload()
	return
end

function ThemeBioVoteKnightSelectionComp:updateKnightSelection(arg_5_1)
	arg_5_1 = arg_5_1 or {}
	self._params = arg_5_1
	self._optionInfo = arg_5_1.optionInfo
	self._voteInfo = arg_5_1.voteInfo
	self._chapterId = arg_5_1.chapterId
	self._compIndex = arg_5_1.compIndex
	self._isUnlockedEnding = arg_5_1.isUnlockedEnding

	local var_5_0 = 0
	local var_5_1 = 0

	if arg_5_1.isSelected then
		var_5_1 = 1
		var_5_0 = 1
	end

	if self._isUnlockedEnding then
		var_5_0 = 2

		self:setGrayed(true)
	else
		self:setGrayed(false)
	end

	self.m_nameComp:updateNameComp({
		name = (var_0_2.hasData(self._optionInfo.optionNo) or nil) and var_0_2.get(self._optionInfo.optionNo).name,
		subTitle = var_5_0,
		state = (arg_5_1.nameState or nil) and arg_5_1.nameState
	})

	if arg_5_1.iconPath then
		self:setIcon(arg_5_1.iconPath)
	end

	if arg_5_1.iconSelectedPath and not self._isUnlockedEnding then
		self.m_iconSelected:setURL(arg_5_1.iconSelectedPath)
	else
		self.m_iconSelected:setURL("")
	end
end

function ThemeBioVoteKnightSelectionComp:_onClickSelf()
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

return ThemeBioVoteKnightSelectionComp
