-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bricksxgame/view/BricksxgameresultView.lua

module("logic.extensions.bricksxgame.view.BricksxgameresultView", package.seeall)

local BricksxgameresultView = class("BricksxgameresultView", ViewComponent)

function BricksxgameresultView:ctor()
	BricksxgameresultView.super.ctor(self)
end

function BricksxgameresultView:unbindEvents()
	BricksxgameresultView.super.unbindEvents(self)
end

function BricksxgameresultView:bindEvents()
	BricksxgameresultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._sendSave, self)
	GameUtil.addClickHandler(self._btnCancel, self._sendCancel, self)
end

function BricksxgameresultView:buildUI()
	BricksxgameresultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._txtTotal = self:getTxt("txtTotal")
	self._txtExt = self:getTxt("txtExt")
	self._txtCountList = {}
	self._txtNumList = {}

	for i = 1, 3 do
		local txtCount = self:getTxt("txtCount_" .. i)

		table.insert(self._txtCountList, txtCount)

		local txt = self:getTxt("txtNum_" .. i)

		table.insert(self._txtNumList, txt)
	end
end

function BricksxgameresultView:onExit()
	BricksxgameresultView.super.onExit(self)
end

function BricksxgameresultView:onEnter()
	BricksxgameresultView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = BricksxgameController.instance:getDeafultActId()
	end

	local params = self:getOpenParam() or {}

	self._score = checknumber(params[2])
	self._list = params[3] or {}

	local totalExt = 0

	for i, v in ipairs(self._list) do
		local id = v.id
		local count = v.count
		local cfg = BricksxgameConfig.instance:getBlockById(id) or {}
		local ext = checknumber(cfg.extScore) * count

		self._txtCountList[i].text = count
		self._txtNumList[i].text = ext
		totalExt = totalExt + ext
	end

	self._txtExt.text = totalExt
	self._txtTotal.text = self._score

	self.addGEvent(self, GlobalNotify.BRICKSXGAME_END_GAME, self.close, self)
end

function BricksxgameresultView:_sendSave()
	BricksxgameController.instance:sendEndGame(self._activityId, true, self._score)
end

function BricksxgameresultView:_sendCancel()
	BricksxgameController.instance:sendEndGame(self._activityId, false, self._score)
end

return BricksxgameresultView
