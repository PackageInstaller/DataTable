-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManIdiomChainResultView.lua

module("logic.extensions.beastrichman.view.BeastRichManIdiomChainResultView", package.seeall)

local BeastRichManIdiomChainResultView = class("BeastRichManIdiomChainResultView", ViewComponent)

function BeastRichManIdiomChainResultView:buildUI()
	BeastRichManIdiomChainResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtGameTime = self:getTxt("gameTime/txt")
	self._txtScore = self:getTxt("score/txt")
end

function BeastRichManIdiomChainResultView:bindEvents()
	BeastRichManIdiomChainResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
end

function BeastRichManIdiomChainResultView:unbindEvents()
	BeastRichManIdiomChainResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function BeastRichManIdiomChainResultView:onEnter()
	self.addGEvent(self, GlobalNotify.BeastRichManHandleGridRes, self._onHandleGridRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._zoneId = checknumber(params[2])
	self._gridId = checknumber(params[3])
	self._score = checknumber(params[4])

	self:_onUpdate()
end

function BeastRichManIdiomChainResultView:onExit()
	BeastRichManIdiomChainResultView.super.onExit(self)
	GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
end

function BeastRichManIdiomChainResultView:_onUpdate()
	self._txtScore.text = BeastRichmanController.instance:getPrizeScore(self._activityId, self._zoneId, self._gridId, self._score)
end

function BeastRichManIdiomChainResultView:_onClickBtnClose()
	local tb = {
		onekey = false,
		annual = false,
		score = self._score
	}
	local param = GameUtil.jsonToString(tb)

	BeastRichmanController.instance:sendPM_BeastRichManHandleGridReq(self._activityId, self._zoneId, self._gridId, param)
end

function BeastRichManIdiomChainResultView:_onHandleGridRes()
	BeastRichmanController.instance:tryPopCurScore(self._activityId)
	self:close()
end

return BeastRichManIdiomChainResultView
