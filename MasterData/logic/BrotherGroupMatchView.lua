-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/view/BrotherGroupMatchView.lua

module("logic.extensions.brothergroup.view.BrotherGroupMatchView", package.seeall)

local BrotherGroupMatchView = class("BrotherGroupMatchView", ViewComponent)

function BrotherGroupMatchView:buildUI()
	BrotherGroupMatchView.super.buildUI(self)

	self._matching = self:getGo("matching")
	self._txtTime = goutil.findChildTextComponent(self._matching, "txtTime")
	self._btnCancel = goutil.findChild(self._matching, "btnCancel")
	self._success = self:getGo("success")
end

function BrotherGroupMatchView:bindEvents()
	BrotherGroupMatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self.onClickCancel, self)
end

function BrotherGroupMatchView:unbindEvents()
	BrotherGroupMatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
end

function BrotherGroupMatchView:onEnter()
	BrotherGroupMatchView.super.onEnter(self)

	self._isMatchSuc = false
	self._timer = 0

	self:onTimer()
	settimer(1, self.onTimer, self)
	goutil.setActive(self._matching, true)
	goutil.setActive(self._success, false)

	if BrotherGroupModel.instance:isExitTeam() then
		BrotherGroupController.instance:teamMatching()
	else
		BrotherGroupController.instance:personMatching()
	end

	GlobalDispatcher:addListener(GlobalNotify.BrotherGroupMatchFail, self.onFail, self)
	GlobalDispatcher:addListener(GlobalNotify.BrotherGroupMatchSuc, self.onSuc, self)
end

function BrotherGroupMatchView:onExit()
	BrotherGroupMatchView.super.onExit(self)
	removetimer(self.onTimer, self)
	GlobalDispatcher:removeListener(GlobalNotify.BrotherGroupMatchFail, self.onFail, self)
	GlobalDispatcher:removeListener(GlobalNotify.BrotherGroupMatchSuc, self.onSuc, self)
end

function BrotherGroupMatchView:onSuc()
	goutil.setActive(self._matching, false)
	goutil.setActive(self._success, true)

	self._isMatchSuc = true
	self._timer = 0
end

function BrotherGroupMatchView:onFail()
	removetimer(self.onTimer, self)
	FloatWordMgr.instance:show(lang("暂无合适的队伍，请稍候再试"))
	self:close()
end

function BrotherGroupMatchView:onTimer()
	self._timer = self._timer + 1

	if self._isMatchSuc and self._timer > 3 then
		self:close()
	end

	self._txtTime.text = GameUtil.FormatTimeSymbol(self._timer)
end

function BrotherGroupMatchView:onClickCancel()
	BrotherGroupController.instance:cancelMatching()
	self:close()
end

return BrotherGroupMatchView
