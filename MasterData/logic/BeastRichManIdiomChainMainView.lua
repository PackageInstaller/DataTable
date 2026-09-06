-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManIdiomChainMainView.lua

module("logic.extensions.beastrichman.view.BeastRichManIdiomChainMainView", package.seeall)

local BeastRichManIdiomChainMainView = class("BeastRichManIdiomChainMainView", IdiomChainMainView)

function BeastRichManIdiomChainMainView:onEnter()
	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._zoneId = checknumber(params[2])
	self._gridId = checknumber(params[3])
	self._gamePlanId = 2
	self._gameData = IdiomChainConfig.instance:getGameData(self._gamePlanId)
	self._gameActId = 543002
	self._wordDataList = IdiomChainConfig.instance:getWordDataList()
	self._charDic = {}
	self._charCompare = {}

	local checkMap = {}

	for _, data in ipairs(self._wordDataList) do
		local content = data.content
		local charList = StringUtil.utf8split(content)

		if checkMap[content] then
			printError(string.format("出现重复的词语 wordId:%s, content:%s", data.wordId, content))
		end

		checkMap[content] = true

		for idx = 1, #charList do
			local char = charList[idx]
			local charId = self:_getCharId(data.wordId, idx)

			self._charDic[charId] = char
			self._charCompare[charId] = {
				charIdx = idx,
				wordId = data.wordId
			}
		end
	end

	self.addGEvent(self, GlobalNotify.BeastRichManHandleGridRes, self.close, self)
	self._stateMachine:startTimer()
	self._stateMachine:gotoState(MmUtil.State_Preparing)
end

function BeastRichManIdiomChainMainView:_endGame(isSuccess)
	if self:_getCurState() ~= MmUtil.State_Runing then
		return
	end

	self._stateMachine:gotoState(MmUtil.State_Ended)

	if isSuccess then
		self:_doGameEndCallBack(MmUtil.GameResult_GameOverOfSuccess)
	else
		self:_doGameEndCallBack(MmUtil.GameResult_GameOverOfFail)
	end
end

function BeastRichManIdiomChainMainView:_doGameEndCallBack(gameEndRes)
	local total = 0

	if gameEndRes == MmUtil.GameResult_GameOverOfSuccess then
		local gameTime = self:getGameTime()
		local scoreData = IdiomChainConfig.instance:getScoreDataBySec(self._gameActId, 1, gameTime)

		total = scoreData.score
	end

	UIStateManager.instance:push(ViewName.BeastRichManIdiomChainResultView, self._activityId, self._zoneId, self._gridId, total)
end

return BeastRichManIdiomChainMainView
