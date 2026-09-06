-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/view/AresMomChallengeView.lua

module("logic.extensions.aresmom.view.AresMomChallengeView", package.seeall)

local AresMomChallengeView = class("AresMomChallengeView", ViewComponent)

function AresMomChallengeView:buildUI()
	AresMomChallengeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._challengeList = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("challengeList/cell_" .. i)
		cell.btnEnter = goutil.findChild(cell.go, "btnEnter")
		cell.btnGame = goutil.findChild(cell.go, "btnGame")
		cell.txtTime = goutil.findChildTextComponent(cell.go, "txtCount")
		cell.redpoint = goutil.findChild(cell.btnEnter, "redPoint")
		cell.redpointGame = goutil.findChild(cell.btnGame, "redPoint")
		self._challengeList[i] = cell
	end
end

function AresMomChallengeView:bindEvents()
	AresMomChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)

	for i = 1, 3 do
		GameUtil.addClickHandler(self._challengeList[i].btnEnter, GameUtil.handler(self._onClickEnter, self, i))
		GameUtil.addClickHandler(self._challengeList[i].btnGame, GameUtil.handler(self._onClickGame, self, i))
	end
end

function AresMomChallengeView:unbindEvents()
	AresMomChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for i = 1, 3 do
		GameUtil.rmClickHandler(self._challengeList[i].btnEnter)
		GameUtil.rmClickHandler(self._challengeList[i].btnGame)
	end
end

function AresMomChallengeView:onEnter()
	AresMomChallengeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._challengeId = checknumber(params[1])

	local isInTime = AresMomController.instance:isInTime(self._challengeId)

	if not isInTime then
		local text = "挑战未开启"

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	local redId = AresMomConfig.instance:getAmClientCommonValue(self._challengeId, "ARES_GAME_DAILY_RED")

	for i = 1, 3 do
		local info = AresMomModel.instance:getChallengeInfo(i)

		if info then
			if not info.gameTimes then
				local time = 0

				self._challengeList[i].txtTime.text = langPara("次数：%s", time)

				RedPointController.instance:regRedPoint(self._challengeList[i].redpointGame, redId)
				goutil.setActive(self._challengeList[i].redpoint, AresMomModel.instance:getIsAbleToGetPrize(i))
			end
		end
	end

	local actCfg = AresMomConfig.instance:getActCfgById(self._challengeId)
	local storyId = AresMomConfig.instance:getAmClientCommonValue(self._challengeId, "ARES_FIRST_STORY_ID", true)

	if storyId > 0 then
		local userDataKey = ViewName.AresMomChallengeView .. self._challengeId
		local userData = GameUtil.getUserData(userDataKey)

		if checkint(userData) <= 0 then
			GameUtil.saveUserData(userDataKey, 1)
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end
	end
end

function AresMomChallengeView:onExit()
	AresMomChallengeView.super.onExit(self)

	for i = 1, 3 do
		RedPointController.instance:unregRedPoint(self._challengeList[i].redpointGame)
	end
end

function AresMomChallengeView:_onClickTip()
	ViewMgr.instance:open(ViewName.RulesView, "aresmomchallengerule")
end

function AresMomChallengeView:_onClickEnter(type)
	local viewName = AresMomConfig.instance:getAmClientCommonValue(self._challengeId, "ARES_VIEW_NAME_TYPE")

	if not string.nilorempty(viewName) then
		UIStateManager.instance:push(viewName, self._challengeId, type)
	end
end

function AresMomChallengeView:_onClickGame(type)
	local viewName = AresMomConfig.instance:getAmClientCommonValue(self._challengeId, "ARES_VIEW_NAME_GAME")

	if not string.nilorempty(viewName) then
		UIStateManager.instance:push(viewName, self._challengeId, type)
	end
end

function AresMomChallengeView:_onClickClose()
	local viewName = AresMomConfig.instance:getAmClientCommonValue(self._challengeId, "ARES_VIEW_NAME_MAIN")

	if not string.nilorempty(viewName) then
		UIStateManager.instance:push(viewName, type)
	end

	self:close()
end

return AresMomChallengeView
