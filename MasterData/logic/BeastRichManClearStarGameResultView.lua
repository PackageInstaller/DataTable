-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManClearStarGameResultView.lua

module("logic.extensions.beastrichman.view.BeastRichManClearStarGameResultView", package.seeall)

local BeastRichManClearStarGameResultView = class("BeastRichManClearStarGameResultView", ViewComponent)

function BeastRichManClearStarGameResultView:ctor()
	BeastRichManClearStarGameResultView.super.ctor(self)
end

function BeastRichManClearStarGameResultView:unbindEvents()
	BeastRichManClearStarGameResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function BeastRichManClearStarGameResultView:bindEvents()
	BeastRichManClearStarGameResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, GameUtil.handler(self._onClickEnd, self, true))
end

function BeastRichManClearStarGameResultView:buildUI()
	BeastRichManClearStarGameResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtScore = self:getTxt("txtScore")
end

function BeastRichManClearStarGameResultView:onExit()
	BeastRichManClearStarGameResultView.super.onExit(self)
end

function BeastRichManClearStarGameResultView:onEnter()
	BeastRichManClearStarGameResultView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastRichManHandleGridRes, self._onHandleGridRes, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 479003
	end

	self._zoneId = checknumber(params[2])
	self._gridId = checknumber(params[3])
	self._totalScore = checknumber(params[4])
	self._txtScore.text = BeastRichmanController.instance:getPrizeScore(self._activityId, self._zoneId, self._gridId, self._totalScore)
end

function BeastRichManClearStarGameResultView:_onClickEnd()
	local tb = {
		onekey = false,
		annual = false,
		score = self._totalScore
	}
	local param = GameUtil.jsonToString(tb)

	BeastRichmanController.instance:sendPM_BeastRichManHandleGridReq(self._activityId, self._zoneId, self._gridId, param)
end

function BeastRichManClearStarGameResultView:_onHandleGridRes()
	BeastRichmanController.instance:tryPopCurScore(self._activityId)
	self:close()
end

return BeastRichManClearStarGameResultView
