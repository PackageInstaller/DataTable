-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManPlayerMgr.lua

module("logic.extensions.beastrichman.view.BeastRichManPlayerMgr", package.seeall)

local BeastRichManPlayerMgr = class("BeastRichManPlayerMgr")

function BeastRichManPlayerMgr:ctor()
	self._speed = 1
	self._duration = 3
	self._pathMoveSequence = nil
	self._gridId = 1
end

function BeastRichManPlayerMgr:initParam(activityId, zoneId, go, goTouming, posX, posY, gameview, tableview)
	self._activityId = activityId
	self._zoneId = zoneId
	self._playerGo = go
	self._playerGoTouming = goTouming

	if self._hLPlayerMgr == nil then
		self._hLPlayerMgr = HLPlayerMgr.New()
	end

	if self._hLPlayerMgr2 == nil then
		self._hLPlayerMgr2 = BRMPlayerMgr.New()
	end

	local mapScrollerRect = tableview:GetComponent(ComponentType.ScrollRect)
	local x, y = BeastRichManMapMgr.instance:calMapSize(activityId, zoneId)
	local mapScrollerSize = {
		x = x,
		y = y
	}

	self._hLPlayerMgr:onEnter(gameview, mapScrollerRect, mapScrollerSize, self._playerGo)
	self._hLPlayerMgr2:onEnter(gameview, mapScrollerRect, mapScrollerSize, self._playerGoTouming)
	self:_initUI(posX, posY)
end

function BeastRichManPlayerMgr:_initUI(posX, posY)
	GameUtil.setLocalPos(self._playerGo, posX, posY, 0)
	GameUtil.setLocalPos(self._playerGoTouming, posX, posY, 0)
end

function BeastRichManPlayerMgr:setPlayerPos(gridId)
	local posX, posY = self:_calcPos(gridId)

	GameUtil.setLocalPos(self._playerGo, posX, posY, 0)
	GameUtil.setLocalPos(self._playerGoTouming, posX, posY, 0)
end

function BeastRichManPlayerMgr:_calcPos(gridId)
	local posX, posY = BeastRichManMapMgr.instance:getPathCellPos(gridId)
	local offsetPosX, offsetPosY = BeastRichManMapMgr.instance:getOffsetXY()

	posX = posX + offsetPosX
	posY = posY + offsetPosY

	return posX, posY
end

function BeastRichManPlayerMgr:setPlayerCurGridId(gridId)
	self._gridId = gridId
end

function BeastRichManPlayerMgr:getPlayerCurGridId()
	return self._gridId
end

function BeastRichManPlayerMgr:move(gridList, finishCallBack, hasStorm, diceValue)
	local gridPosList = {}

	for i, gridId in ipairs(gridList) do
		local posX, posY = self:_calcPos(gridId)
		local newPos = Vector3.New(posX, posY, 0)

		table.insert(gridPosList, newPos)
	end

	if hasStorm then
		self:_playerStormMove(gridList, hasStorm, diceValue, finishCallBack)
	else
		self._hLPlayerMgr:playPathMove(self._playerGo, gridPosList, 0.3, nil, finishCallBack)
		self._hLPlayerMgr2:playPathMove(self._playerGoTouming, gridPosList, 0.3)
	end
end

function BeastRichManPlayerMgr:focusOnPlayer()
	self._hLPlayerMgr:focusOnPlayer(self._playerGo)
end

function BeastRichManPlayerMgr:_playerStormMove(gridList, hasStorm, diceValue, finishCallBack)
	local gridPosList = {}

	for i = 1, diceValue do
		local gridId = gridList[i]
		local posX, posY = self:_calcPos(gridId)
		local newPos = Vector3.New(posX, posY, 0)

		table.insert(gridPosList, newPos)
	end

	local function afterStormCallBack()
		local function okFunc()
			local afterStormGridList = {}

			for i = diceValue, #gridList do
				local gridId = gridList[i]
				local posX, posY = self:_calcPos(gridId)
				local newPos = Vector3.New(posX, posY, 0)

				table.insert(afterStormGridList, newPos)
			end

			self._hLPlayerMgr:playPathMove(self._playerGo, afterStormGridList, 0.3, nil, finishCallBack)
			self._hLPlayerMgr2:playPathMove(self._playerGoTouming, afterStormGridList, 0.3)
		end

		local firstGridId = checknumber(gridList[1])
		local finalGridId = checknumber(gridList[#gridList])
		local shouldCatchGrid = gridList[diceValue + 1]
		local nextGrid = gridList[diceValue + 2]
		local isGoForward = -1

		if nextGrid then
			isGoForward = math.abs(nextGrid - shouldCatchGrid) > 10 and (nextGrid - shouldCatchGrid > 0 and -1 or 1) or nextGrid - shouldCatchGrid > 0 and 1 or -1
		end

		local diffNum = (#gridList - diceValue) * isGoForward

		FloatWordMgr.instance:show(string.format("您踩到了龙卷风格子上，移动了[%s]个格子", diffNum))
		okFunc()
		GlobalDispatcher:dispatch(GlobalNotify.BeastRichManOpenClickMask, false)
	end

	self._hLPlayerMgr:playPathMove(self._playerGo, gridPosList, 0.3, nil, afterStormCallBack)
	self._hLPlayerMgr2:playPathMove(self._playerGoTouming, gridPosList, 0.3)
end

function BeastRichManPlayerMgr:_killPathMoveSequence()
	if self._pathMoveSequence then
		self._pathMoveSequence:Kill(true)

		self._pathMoveSequence = nil
	end

	if self._pathTouMingMoveSequence then
		self._pathTouMingMoveSequence:Kill(true)

		self._pathTouMingMoveSequence = nil
	end
end

BeastRichManPlayerMgr.instance = BeastRichManPlayerMgr.New()

return BeastRichManPlayerMgr
