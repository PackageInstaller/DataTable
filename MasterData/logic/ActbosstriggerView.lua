-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/ActbosstriggerView.lua

module("logic.extensions.aceteam.view.ActbosstriggerView", package.seeall)

local ActbosstriggerView = class("ActbosstriggerView", ViewComponent)

function ActbosstriggerView:ctor()
	ActbosstriggerView.super.ctor(self)
end

function ActbosstriggerView:unbindEvents()
	ActbosstriggerView.super.unbindEvents(self)
	self._viewBoxGo:RemoveClickListener()
end

function ActbosstriggerView:bindEvents()
	ActbosstriggerView.super.bindEvents(self)
	self._viewBoxGo:AddClickListener(self._onClickviewBoxGo, self)
end

function ActbosstriggerView:buildUI()
	ActbosstriggerView.super.buildUI(self)

	self._viewBoxGo = self:getBtn("viewBoxGo")
end

function ActbosstriggerView:onExit()
	ActbosstriggerView.super.onExit(self)

	local bossId = AceTeamModel.instance:getCurrBossId()

	if bossId > 0 and AceTeamConfig.instance:getMonsterCfg(bossId) then
		UIStateManager.instance:push(ViewName.AceteambossView)
	end
end

function ActbosstriggerView:onEnter()
	ActbosstriggerView.super.onEnter(self)
end

function ActbosstriggerView:_onClickviewBoxGo()
	self:close()
end

return ActbosstriggerView
