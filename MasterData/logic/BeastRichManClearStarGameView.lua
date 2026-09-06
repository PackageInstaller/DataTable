-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManClearStarGameView.lua

module("logic.extensions.beastrichman.view.BeastRichManClearStarGameView", package.seeall)

local BeastRichManClearStarGameView = class("BeastRichManClearStarGameView", ClearStarGameView)

function BeastRichManClearStarGameView:onEnter()
	self.addGEvent(self, GlobalNotify.ClearStarGameSelectStar, self._onClickStar, self)
	self.addGEvent(self, GlobalNotify.ClearStarGameStartGame, self._handleStartGame, self)
	self.addGEvent(self, GlobalNotify.ClearStarGameEndGame, self._handleEndGame, self)
	self.addGEvent(self, GlobalNotify.BeastRichManHandleGridRes, self.close, self)
	goutil.setActive(self._changePlane, false)
	goutil.setActive(self._goTips1, false)
	goutil.setActive(self._goTips2, false)
	goutil.setActive(self._goStarCell, false)

	self._normalExit = false

	local params = self:getOpenParam()

	self._richManActivityId = checknumber(params[1])
	self._activityId = 479003
	self._zoneId = checknumber(params[2])
	self._gridId = checknumber(params[3])
	self._isPractise = false
	self._starMaxTypeId = 0

	self:_initCfg()
	self:_initGame()
	self:_enterGame()

	local userDataKey = string.format("%s_first_open_", ViewName.ClearStarGameView, self._activityId)

	if checknumber(GameUtil.getUserData(userDataKey)) <= 0 then
		GameUtil.saveUserData(userDataKey, 1)
		self:_onClickTips()
	end
end

function BeastRichManClearStarGameView:onExit()
	BeastRichManClearStarGameView.super.onExit(self)

	for i, star in ipairs(self._curStarList) do
		star:reset()
	end

	if not self._isPractise and not self._normalExit then
		self:_sendEndGame(false)
	end

	self:_clearAllEff()
end

function BeastRichManClearStarGameView:_sendEndGame(isSaveData)
	self._isRuning = false

	local totalScore = 0

	for i, score in pairs(self._starScoreMap) do
		totalScore = totalScore + score
	end

	UIStateManager.instance:push(ViewName.BeastRichManClearStarGameResultView, self._richManActivityId, self._zoneId, self._gridId, totalScore)
end

function BeastRichManClearStarGameView:_endGame()
	local totalScore = 0

	for i, score in pairs(self._starScoreMap) do
		totalScore = totalScore + score
	end

	UIStateManager.instance:push(ViewName.BeastRichManClearStarGameResultView, self._richManActivityId, self._zoneId, self._gridId, totalScore)
end

function BeastRichManClearStarGameView:_enterGame()
	self:_playGame()
end

return BeastRichManClearStarGameView
