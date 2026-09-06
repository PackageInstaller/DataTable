-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/BuryCountDownView.lua

module("logic.extensions.burygame.view.BuryCountDownView", package.seeall)

local BuryCountDownView = class("BuryCountDownView", MiyaCountdownView)

function BuryCountDownView:onEnter()
	BuryCountDownView.super.onEnter(self)

	local param = self:getOpenParam()

	self._closeCall, self._closeObj = param[3], param[4]
end

function BuryCountDownView:onExit()
	BuryCountDownView.super.onExit(self)
	GameUtil.callBack(self._closeCall, self._closeObj)
end

return BuryCountDownView
