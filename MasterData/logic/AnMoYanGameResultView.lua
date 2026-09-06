-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anmoyangame/view/AnMoYanGameResultView.lua

module("logic.extensions.anmoyangame.view.AnMoYanGameResultView", package.seeall)

local AnMoYanGameResultView = class("AnMoYanGameResultView", ViewComponent)

function AnMoYanGameResultView:buildUI()
	AnMoYanGameResultView.super.buildUI(self)

	self._btnClose = Framework.UIClickTrigger.Get(self:getGo("btnClose"))
	self._txtItemNum = self:getTxt("txtItemNum")
	self._txtItemNumTips = self:getTxt("txtItemNumTips")
end

function AnMoYanGameResultView:bindEvents()
	AnMoYanGameResultView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function AnMoYanGameResultView:unbindEvents()
	AnMoYanGameResultView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function AnMoYanGameResultView:onEnter()
	AnMoYanGameResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._score = checknumber(params[1])
	self._title = params[2]
	self._gameViewName = params[3]
	self._mainViewName = params[4]
	self._txtItemNum.text = self._score
	self._txtItemNumTips.text = self._title or "本局积分"
end

function AnMoYanGameResultView:_onClickClose()
	self:close()

	if self._gameViewName and self._mainViewName then
		if UIStateManager.instance:isInStack(self._gameViewName) then
			UIStateManager.instance:pop()
		else
			UIStateManager.instance:push(self._mainViewName)
		end
	end
end

return AnMoYanGameResultView
