-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/view/AresMomGameRuleView.lua

module("logic.extensions.aresmom.view.AresMomGameRuleView", package.seeall)

local AresMomGameRuleView = class("AresMomGameRuleView", ViewComponent)

function AresMomGameRuleView:buildUI()
	AresMomGameRuleView.super.buildUI(self)

	self._btnSure = self:getGo("sureBtn")
	self._btnRight = self:getGo("btnRight")
	self._btnLeft = self:getGo("btnLeft")
	self._imgRule = self:getGo("imgRule")
end

function AresMomGameRuleView:bindEvents()
	AresMomGameRuleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
	GameUtil.addClickHandler(self._btnRight, self._onTurnRight, self)
	GameUtil.addClickHandler(self._btnLeft, self._onTurnLeft, self)
end

function AresMomGameRuleView:unbindEvents()
	AresMomGameRuleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnRight)
	GameUtil.rmClickHandler(self._btnLeft)
end

function AresMomGameRuleView:onEnter()
	AresMomGameRuleView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._challengeId = checknumber(params[1])
	self._folderPath = params[2]
	self._pathStr = params[3]
	self._challengeId = 51

	if self._challengeId <= 0 then
		self:close()

		return
	end

	local pathsStr = self._pathStr

	self._pathList = string.split(pathsStr, "#")
	self._pageCount = #self._pathList

	if self._pageCount <= 0 then
		self:close()

		return
	end

	self._curShowId = 1

	self:_onTurn()
end

function AresMomGameRuleView:onExit()
	AresMomGameRuleView.super.onExit(self)
	uGuiUtil.clearImage(self._imgRule)
end

function AresMomGameRuleView:_onTurnLeft()
	local pageId = self._curShowId - 1

	if pageId >= 1 then
		self._curShowId = pageId

		self:_onTurn()
	end
end

function AresMomGameRuleView:_onTurnRight()
	local pageId = self._curShowId + 1

	if pageId <= self._pageCount then
		self._curShowId = pageId

		self:_onTurn()
	end
end

function AresMomGameRuleView:_onTurn()
	GameUtil.SetActive(self._btnRight, self._curShowId < self._pageCount)
	GameUtil.SetActive(self._btnLeft, self._curShowId > 1)

	local path = self._pathList[self._curShowId]
	local bgGo = self._imgRule

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/bigbg/%s/%s.png", self._folderPath, path)

		local function func()
			if isSetNativeSize then
				-- block empty
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		uGuiUtil.clearImage(bgGo)
	end
end

return AresMomGameRuleView
