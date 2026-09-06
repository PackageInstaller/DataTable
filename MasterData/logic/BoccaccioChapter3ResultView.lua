-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapter3ResultView.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapter3ResultView", package.seeall)

local BoccaccioChapter3ResultView = class("BoccaccioChapter3ResultView", ViewComponent)

function BoccaccioChapter3ResultView:ctor()
	BoccaccioChapter3ResultView.super.ctor(self)
end

function BoccaccioChapter3ResultView:unbindEvents()
	BoccaccioChapter3ResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSureFirst)
	GameUtil.rmClickHandler(self._btnSureNotFirst)
	GameUtil.rmClickHandler(self._btnCancel)
end

function BoccaccioChapter3ResultView:bindEvents()
	BoccaccioChapter3ResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSureFirst, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnSureNotFirst, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function BoccaccioChapter3ResultView:buildUI()
	BoccaccioChapter3ResultView.super.buildUI(self)

	self._first = self:getGo("first")
	self._btnSureFirst = self:getGo("first/btnSure")
	self._notFirst = self:getGo("notFirst")
	self._btnCancel = self:getGo("notFirst/btnCancel")
	self._btnSureNotFirst = self:getGo("notFirst/btnSure")

	local goTabLast = self:getGo("notFirst/last/tableview")
	local goCellLast = self:getGo("notFirst/last/tableview/tablecell")

	self._tableViewLast = ScrollerList.create(goTabLast, goCellLast, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyLast = self:getGo("notFirst/last/empty")
	self._emptyCurNF = self:getGo("notFirst/cur/empty")

	local goTabCurNF = self:getGo("notFirst/cur/tableview")
	local goCellCurNF = self:getGo("notFirst/cur/tableview/tablecell")

	self._tableViewCurNF = ScrollerList.create(goTabCurNF, goCellCurNF, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local goTabCurF = self:getGo("first/cur/tableview")
	local goCellCurF = self:getGo("first/cur/tableview/tablecell")

	self._tableViewCurF = ScrollerList.create(goTabCurF, goCellCurF, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyCurF = self:getGo("first/cur/empty")
end

function BoccaccioChapter3ResultView:onExit()
	BoccaccioChapter3ResultView.super.onExit(self)
	self._tableViewLast:dispose()
	self._tableViewCurNF:dispose()
	self._tableViewCurF:dispose()
end

function BoccaccioChapter3ResultView:onEnter()
	BoccaccioChapter3ResultView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapter3SaveClgRes, self._handleConfirm, self)

	local resultInfo
	local params = self:getOpenParam()

	if params ~= nil then
		resultInfo = params[1]
	end

	self._activityId = 580001
	self._stageId = 1
	self._consumeRaceId = {}

	if resultInfo == nil then
		self:_onClickCancel()

		return
	end

	self._activityId = resultInfo.activityId or 580001
	self._stageId = resultInfo.stageId or 1
	self._consumeCharacterIds = {}

	if not resultInfo.consumeCharacterId then
		local checkPetIds = {}

		for _, characterId in ipairs(checkPetIds) do
			if BagPetsController.instance:hasPet(characterId) then
				table.insert(self._consumeCharacterIds, characterId)
			end
		end

		local lastConsumeCharacterIds = {}
		local chapter3Info = BoccaccioChapterController.instance:getChapterInfo(self._activityId, BoccaccioChapterEnum.ChapterId_3)

		if chapter3Info ~= nil then
			if not chapter3Info.stageInfo then
				do
					local stageInfos = {}

					for _, stageInfo in ipairs(stageInfos) do
						if stageInfo.stageId == self._stageId then
							if not stageInfo.hasConsumeCharacterId then
								for _, characterId in ipairs(stageInfo.hasConsumeCharacterId) do
									if BagPetsController.instance:hasPet(characterId) then
										table.insert(lastConsumeCharacterIds, characterId)
									end
								end

								break
							end
						end
					end
				end

				local isFirst = (chapter3Info.maxPassStageId or 0) < self._stageId

				goutil.setActive(self._first, isFirst)
				goutil.setActive(self._notFirst, not isFirst)
				goutil.setActive(self._emptyCurF, #self._consumeCharacterIds <= 0)
				goutil.setActive(self._emptyCurNF, #self._consumeCharacterIds <= 0)
				goutil.setActive(self._emptyLast, #lastConsumeCharacterIds <= 0)
				self._tableViewCurF:reloadData(self._consumeCharacterIds)
				self._tableViewCurF:setCenterMode(true)
				self._tableViewCurNF:reloadData(self._consumeCharacterIds)
				self._tableViewCurNF:setCenterMode(true)
				self._tableViewLast:reloadData(lastConsumeCharacterIds)
				self._tableViewLast:setCenterMode(true)
			end
		end
	end
end

function BoccaccioChapter3ResultView:_onClickSure()
	BoccaccioChapterController.instance:sendPM_BoccaccioChapter3SaveClgReq(self._activityId, true)
end

function BoccaccioChapter3ResultView:_onClickCancel()
	BoccaccioChapterController.instance:sendPM_BoccaccioChapter3SaveClgReq(self._activityId, false)
end

function BoccaccioChapter3ResultView:_handleConfirm()
	self:close()
	BattleController.instance:endBattle()
end

function BoccaccioChapter3ResultView:_updateCell(view, cell, data, tag)
	local petMo = BagPetsController.instance:getPet(data)
	local proxy = MaterialMgr.setCellByMo(petMo, cell.gameObject)
end

function BoccaccioChapter3ResultView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return BoccaccioChapter3ResultView
