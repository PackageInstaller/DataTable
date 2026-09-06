-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapterTwoStageResultView.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapterTwoStageResultView", package.seeall)

local BoccaccioChapterTwoStageResultView = class("BoccaccioChapterTwoStageResultView", ViewComponent)

function BoccaccioChapterTwoStageResultView:buildUI()
	BoccaccioChapterTwoStageResultView.super.buildUI(self)

	self._txtName = self:getTxt("txtName")
	self._tagEmpty = self:getGo("tagEmpty")
	self._btnSure = self:getGo("btnSure")

	local scrView = self:getGo("wordCol/scrView")
	local scrCell = self:getGo("wordCol/scrCell")

	self._wordScrollerList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updateWordCell, self), GameUtil.handler(self._clearWordCell, self))

	self._wordScrollerList:setCenterMode(true)
end

function BoccaccioChapterTwoStageResultView:bindEvents()
	BoccaccioChapterTwoStageResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function BoccaccioChapterTwoStageResultView:unbindEvents()
	BoccaccioChapterTwoStageResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function BoccaccioChapterTwoStageResultView:onEnter()
	BoccaccioChapterTwoStageResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local msg = params[1]

	self._activityId = checknumber(msg.activityId)
	self._stageId = checknumber(msg.stageId)
	self._storyId = checknumber(msg.storyId)
	self._isWin = msg.isWin
	self._gainWord = {}

	for i, wordId in ipairs(msg.gainWord) do
		local data = BoccaccioChapterConfig.instance:getChapter2WordData(self._activityId, wordId)

		if data then
			table.insert(self._gainWord, data)
		elseif wordId > 0 then
			printError(string.format("薄伽丘：后端下发不存在的字词id， storyId:%s, stageId：%s, wordId: %s", self._storyId, self._stageId, wordId))
		end
	end

	self:_onUpdateUI()
end

function BoccaccioChapterTwoStageResultView:onExit()
	BoccaccioChapterTwoStageResultView.super.onExit(self)
	self._wordScrollerList:dispose()
end

function BoccaccioChapterTwoStageResultView:_onUpdateUI()
	self._wordScrollerList:reloadData(self._gainWord)
	GameUtil.SetActive(self._tagEmpty, #self._gainWord == 0)
end

function BoccaccioChapterTwoStageResultView:_updateWordCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtContent = goutil.findChildTextComponent(mainGo, "txtContent")

	txtContent.text = data and data.content
end

function BoccaccioChapterTwoStageResultView:_clearWordCell(cell)
	return
end

function BoccaccioChapterTwoStageResultView:_onClickBtnSure()
	self:close()
	BattleController.instance:endBattle()
end

return BoccaccioChapterTwoStageResultView
