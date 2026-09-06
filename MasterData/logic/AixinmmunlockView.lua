-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmm/view/AixinmmunlockView.lua

module("logic.extensions.aixinmm.view.AixinmmunlockView", package.seeall)

local AixinmmunlockView = class("AixinmmunlockView", ViewComponent)

function AixinmmunlockView:ctor()
	AixinmmunlockView.super.ctor(self)
end

function AixinmmunlockView:buildUI()
	AixinmmunlockView.super.buildUI(self)

	self._btnGo = self:getBtn("btnGo")
end

function AixinmmunlockView:bindEvents()
	AixinmmunlockView.super.bindEvents(self)
	self._btnGo:AddClickListener(self._onClickbtnGo, self)
end

function AixinmmunlockView:unbindEvents()
	AixinmmunlockView.super.unbindEvents(self)
	self._btnGo:RemoveClickListener()
end

function AixinmmunlockView:destroyUI()
	AixinmmunlockView.super.destroyUI(self)
end

function AixinmmunlockView:onEnter()
	AixinmmunlockView.super.onEnter(self)
end

function AixinmmunlockView:onEnterFinished()
	AixinmmunlockView.super.onEnterFinished(self)
end

function AixinmmunlockView:onExit()
	AixinmmunlockView.super.onExit(self)
end

function AixinmmunlockView:onExitFinished()
	AixinmmunlockView.super.onExitFinished(self)
end

function AixinmmunlockView:_onClickbtnGo()
	local cid = AixinmmConfig.instance:getChallengeId()
	local exchangeCfg = TimeLimitedConfig.instance:getCfgById(cid)
	local evolveMo = EvolveMo.New()

	evolveMo:setParamById(AixinmmConfig.instance:getEvolvePetRaceId(), exchangeCfg.raceId)
	UIStateManager.instance:push(ViewName.Evolve, evolveMo)
	self:close()
end

return AixinmmunlockView
