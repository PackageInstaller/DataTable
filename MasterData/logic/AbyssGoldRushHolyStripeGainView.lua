-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushHolyStripeGainView.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushHolyStripeGainView", package.seeall)

local AbyssGoldRushHolyStripeGainView = class("AbyssGoldRushHolyStripeGainView", ViewComponent)

function AbyssGoldRushHolyStripeGainView:ctor()
	AbyssGoldRushHolyStripeGainView.super.ctor(self)
end

function AbyssGoldRushHolyStripeGainView:unbindEvents()
	AbyssGoldRushHolyStripeGainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function AbyssGoldRushHolyStripeGainView:bindEvents()
	AbyssGoldRushHolyStripeGainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function AbyssGoldRushHolyStripeGainView:buildUI()
	AbyssGoldRushHolyStripeGainView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnSure = self:getGo("btnSure")
end

function AbyssGoldRushHolyStripeGainView:onExit()
	AbyssGoldRushHolyStripeGainView.super.onExit(self)
end

function AbyssGoldRushHolyStripeGainView:onEnter()
	AbyssGoldRushHolyStripeGainView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local openParams = self:getOpenParam()

	self._isJumpToExit = openParams[2] or false
	self._selectMap = {}

	self:_refreshView()
end

function AbyssGoldRushHolyStripeGainView:_refreshView()
	local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()

	self._tableList:reloadData(gameInfo.baseInfo.dropHolyStripeIds)
end

function AbyssGoldRushHolyStripeGainView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "raycast")
	local icon = goutil.findChild(go, "itcmCon")
	local tagSelect = goutil.findChild(go, "tagSelect")

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickCell(data)
	end)
	GameUtil.SetActive(tagSelect, self._selectMap[data] == true)
end

function AbyssGoldRushHolyStripeGainView:_clearCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "raycast")

	GameUtil.rmClickHandler(btn)
end

function AbyssGoldRushHolyStripeGainView:_onClickSure()
	local list = {}

	for i, v in ipairs(self._selectMap) do
		table.insert(list, v)
	end

	if self._isJumpToExit == true then
		UIStateManager.instance:push(ViewName.AbyssGoldRushExitView, self._activityId, list)
		UIStateManager.instance:popByName(ViewName.AbyssGoldRushRoundEndView)
		self:close()
	else
		AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushFinishGameReq(self._activityId, true, list)
		self:close()
	end
end

function AbyssGoldRushHolyStripeGainView:_onClickCell(id)
	if self._selectMap[id] then
		self._selectMap[id] = nil
	else
		self._selectMap[id] = true
	end

	self:_refreshView()
end

return AbyssGoldRushHolyStripeGainView
