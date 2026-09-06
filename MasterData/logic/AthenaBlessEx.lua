-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/athenabless/view/AthenaBlessEx.lua

module("logic.extensions.athenabless.view.AthenaBlessEx", package.seeall)

local AthenaBlessEx = class("AthenaBlessEx")

function AthenaBlessEx:buildUI(go)
	self._athenaBlessGo = go
	self._btnClick = Framework.ButtonAdapter.GetFrom(go, "btnClick")
end

function AthenaBlessEx:bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function AthenaBlessEx:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function AthenaBlessEx:onEnter()
	if not goutil.isNil(self._athenaBlessGo) then
		local isInTime = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.AthenaBless)

		goutil.setActive(self._athenaBlessGo, isInTime)
	end
end

function AthenaBlessEx:_onClick()
	local title = lang("tip")
	local text = AthenaBlessConfig.instance:getConstValue("athena_desc2")
	local btnText = lang("tip_know")

	TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)
end

return AthenaBlessEx
