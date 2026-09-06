-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapterHomeView.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapterHomeView", package.seeall)

local BoccaccioChapterHomeView = class("BoccaccioChapterHomeView", ViewComponent)

function BoccaccioChapterHomeView:buildUI()
	BoccaccioChapterHomeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._chapterCells = {}

	local chapter = self:getGo("chapter")

	for chapterId = 1, chapter.transform.childCount do
		local mainGo = chapter.transform:GetChild(chapterId - 1).gameObject
		local cell = {}

		cell.mainGo = mainGo
		cell.btn = goutil.findChild(mainGo, "btn")
		cell.redPoint = goutil.findChild(mainGo, "btn/redPoint")
		cell.tagLock = goutil.findChild(mainGo, "btn/tagLock")
		cell.txtName = goutil.findChildTextComponent(mainGo, "btn/txtName")
		cell.timeTips = goutil.findChild(mainGo, "timeTips")
		cell.txtTimeTips = goutil.findChildTextComponent(mainGo, "timeTips/txt")
		self._chapterCells[chapterId] = cell
	end
end

function BoccaccioChapterHomeView:bindEvents()
	BoccaccioChapterHomeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))

	for chapterId, cell in pairs(self._chapterCells) do
		GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickChapter, self, chapterId))
	end
end

function BoccaccioChapterHomeView:unbindEvents()
	BoccaccioChapterHomeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)

	for chapterId, cell in pairs(self._chapterCells) do
		GameUtil.rmClickHandler(cell.btn)
	end
end

function BoccaccioChapterHomeView:onEnter()
	BoccaccioChapterHomeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = BoccaccioChapterController.instance:getActivityId()
	end

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._subMo = BoccaccioChapterController.instance:getSubMo(self._activityId)
	self._actData = BoccaccioChapterConfig.instance:getActivityData(self._activityId)

	BoccaccioChapterController.instance:sendPM_BoccaccioChapterInfoReq(self._activityId)
	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapterInfoRes, self._handleGetInfo, self)

	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	local skinId = 17027
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[3] then
		local x, y, scale = checknumber(modelCfg[1]), checknumber(modelCfg[2]), 1

		self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._con, modelCfg[3], nil, true, x, y)

		self:_onUpdate()
	end
end

function BoccaccioChapterHomeView:onExit()
	BoccaccioChapterHomeView.super.onExit(self)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	self:_onClear()
end

function BoccaccioChapterHomeView:_handleGetInfo()
	self:_onUpdate()
	BoccaccioChapterController.instance:unlockPlot(self._activityId, BoccaccioChapterEnum.PolotUnlockType.FirstEnter, self._viewPresentor.viewName)
end

function BoccaccioChapterHomeView:_onUpdate()
	for chapterId, cell in pairs(self._chapterCells) do
		local isUnlock = self._subMo:isUnlockChapter(chapterId)
		local data = BoccaccioChapterConfig.instance:getChapterData(self._activityId, chapterId)
		local startTime = data.openTime and GameUtil.string2time(data.openTime) or 0

		cell.txtTimeTips.text = GameUtil.getFormatTimeByStamp(startTime)
		cell.txtName.text = data.name

		GameUtil.SetActive(cell.tagLock, not isUnlock)
		GameUtil.SetActive(cell.timeTips, not isUnlock)

		local firstRedId = BoccaccioChapterController.instance:getChapterFirstRedId(self._activityId, chapterId)
		local progressRedId = BoccaccioChapterController.instance:getProgressRedId(self._activityId, chapterId)

		RedPointController.instance:regRedPoint(cell.redPoint, firstRedId, progressRedId)
	end
end

function BoccaccioChapterHomeView:_onClear()
	for chapterId, cell in pairs(self._chapterCells) do
		RedPointController.instance:unregRedPoint(cell.redPoint)
	end
end

function BoccaccioChapterHomeView:_onClickChapter(chapterId)
	if not self._subMo:isUnlockChapter(chapterId) then
		FloatWordMgr.instance:show("不在开放时间内")

		return
	end

	BoccaccioChapterController.instance:setChapterFirstRedPointTrigger(self._activityId, chapterId)
	BoccaccioChapterController.instance:pushBoccaccioChapterView(self._activityId, chapterId)
end

function BoccaccioChapterHomeView:_onClickBtnJump(key)
	local jumpToStr = self._actData[key]

	GotoMgr.gotoByString(jumpToStr)
end

function BoccaccioChapterHomeView:_onClickBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

return BoccaccioChapterHomeView
