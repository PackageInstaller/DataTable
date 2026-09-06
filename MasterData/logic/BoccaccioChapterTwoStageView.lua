-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapterTwoStageView.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapterTwoStageView", package.seeall)

local BoccaccioChapterTwoStageView = class("BoccaccioChapterTwoStageView", ViewComponent)

function BoccaccioChapterTwoStageView:buildUI()
	BoccaccioChapterTwoStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")

	local stageScrView = self:getGo("stageScrView")
	local stageScrCell = self:getGo("stageScrCell")

	self._stageScrollerList = ScrollerList.create(stageScrView, stageScrCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._wordScrollerListDic = {}
end

function BoccaccioChapterTwoStageView:bindEvents()
	BoccaccioChapterTwoStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function BoccaccioChapterTwoStageView:unbindEvents()
	BoccaccioChapterTwoStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function BoccaccioChapterTwoStageView:onEnter()
	BoccaccioChapterTwoStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._storyId = checknumber(params[2])
	self._chapterId = BoccaccioChapterEnum.ChapterId_2
	self._subMo = BoccaccioChapterController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapterInfoRes, self._onUpdate, self)

	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	local skinId = 17027
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[3] then
		local x, y, scale = checknumber(modelCfg[1]), checknumber(modelCfg[2]), 1

		self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._con, modelCfg[3], nil, true, x, y)

		self:_onUpdate()
	end
end

function BoccaccioChapterTwoStageView:onExit()
	BoccaccioChapterTwoStageView.super.onExit(self)
	self._stageScrollerList:dispose()

	self._loader = RoleObjectPool.instance:removeRole(self._loader)
end

function BoccaccioChapterTwoStageView:_onUpdate()
	local stageDatas = BoccaccioChapterConfig.instance:getChapter2StageDatasInStory(self._activityId, self._storyId) or {}

	self._stageScrollerList:reloadData(stageDatas)
end

function BoccaccioChapterTwoStageView:_updateStageCell(view, cell, data, tag)
	local stageId = data.stageId
	local index = cell.data
	local mainGo = cell.gameObject
	local btnStage = goutil.findChild(mainGo, "btnStage")
	local txtName = goutil.findChildTextComponent(mainGo, "stage/txtName")
	local wordScrView = goutil.findChild(mainGo, "wordScrView")
	local wordScrCell = goutil.findChild(mainGo, "wordScrCell")

	txtName.text = string.format("第%s关", index)

	local wordInfoList = {}

	for posId, wordId in ipairs(data.positionWord or {}) do
		if wordId > 0 then
			table.insert(wordInfoList, {
				stageId = stageId,
				posId = posId,
				wordId = wordId
			})
		end
	end

	if not self._wordScrollerListDic[mainGo] then
		local scrollerList = ScrollerList.create(wordScrView, wordScrCell, GameUtil.handler(self._updateWordCell, self), GameUtil.handler(self._clearWordCell, self))

		self._wordScrollerListDic[mainGo] = self._wordScrollerListDic[mainGo]

		self._wordScrollerListDic[mainGo]:reloadData(wordInfoList)
		self._wordScrollerListDic[mainGo]:dragNotifyParent()
		GameUtil.addClickHandler(btnStage, function()
			BoccaccioChapterController.instance:enterBattleC2(self._activityId, stageId)
		end)
	end
end

function BoccaccioChapterTwoStageView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local wordScrView = goutil.findChild(mainGo, "wordScrView")
	local btnStage = goutil.findChild(mainGo, "btnStage")

	GameUtil.rmClickHandler(btnStage)

	local scrollerList = self._wordScrollerListDic[mainGo]

	if scrollerList then
		scrollerList:dispose()

		self._wordScrollerListDic[mainGo] = nil
	end
end

function BoccaccioChapterTwoStageView:_updateWordCell(view, cell, info, tag)
	local stageId = info.stageId
	local posId = info.posId
	local wordId = info.wordId
	local data = BoccaccioChapterConfig.instance:getChapter2WordData(self._activityId, wordId)
	local isHasGainWord = self._subMo:isHasGainWordPositionInStage(stageId, posId)
	local mainGo = cell.gameObject
	local txtContent = goutil.findChildTextComponent(mainGo, "txtContent")
	local tagCollected = goutil.findChild(mainGo, "tagCollected")

	txtContent.text = data.content

	GameUtil.SetActive(tagCollected, isHasGainWord)
end

function BoccaccioChapterTwoStageView:_clearWordCell(cell)
	return
end

function BoccaccioChapterTwoStageView:_onClickBtnTip()
	BoccaccioChapterController.instance:openChapterRule(self._activityId, self._chapterId)
end

return BoccaccioChapterTwoStageView
