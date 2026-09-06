-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AiQiAttackForceHeroExitView.lua

module("logic.extensions.aoqiattackforce.view.AiQiAttackForceHeroExitView", package.seeall)

local AiQiAttackForceHeroExitView = class("AiQiAttackForceHeroExitView", ViewComponent)

function AiQiAttackForceHeroExitView:ctor()
	AiQiAttackForceHeroExitView.super.ctor(self)
end

function AiQiAttackForceHeroExitView:unbindEvents()
	AiQiAttackForceHeroExitView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AiQiAttackForceHeroExitView:bindEvents()
	AiQiAttackForceHeroExitView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function AiQiAttackForceHeroExitView:buildUI()
	AiQiAttackForceHeroExitView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtDesc = self:getTxt("txtDesc")
end

function AiQiAttackForceHeroExitView:onExit()
	AiQiAttackForceHeroExitView.super.onExit(self)
end

function AiQiAttackForceHeroExitView:onEnter()
	AiQiAttackForceHeroExitView.super.onEnter(self)

	local params = self:getOpenParam()

	self._txtDesc.text = params[1]
	self._handler = params[2]
end

function AiQiAttackForceHeroExitView:_onClickSure()
	if self._handler then
		self._handler()
		self:close()
	end
end

return AiQiAttackForceHeroExitView
