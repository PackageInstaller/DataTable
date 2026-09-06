-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/anheimm/AnheimmpassruleView.lua

module("logic.extensions.timelimitedchallenge.view.anheimm.AnheimmpassruleView", package.seeall)

local AnheimmpassruleView = class("AnheimmpassruleView", ViewComponent)

function AnheimmpassruleView:ctor()
	AnheimmpassruleView.super.ctor(self)
end

function AnheimmpassruleView:buildUI()
	AnheimmpassruleView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._ruleDesc1 = self:getTxt("rule/rule1/txtDesc")
	self._ruleDesc2 = self:getTxt("rule/rule2/txtDesc")
end

function AnheimmpassruleView:bindEvents()
	AnheimmpassruleView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function AnheimmpassruleView:unbindEvents()
	AnheimmpassruleView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function AnheimmpassruleView:destroyUI()
	AnheimmpassruleView.super.destroyUI(self)
end

function AnheimmpassruleView:onEnter()
	AnheimmpassruleView.super.onEnter(self)

	local ruleId = AnheimmModel.instance:getCurRuleId()
	local ruleCfg = AnheimmConfig.instance:getRuleCfgById(ruleId)

	self._ruleDesc1.text = ruleCfg.buffDes

	local str = "普通通关：击败敌阵\n完美通关：击败敌阵且"

	self._ruleDesc2.text = str .. ruleCfg.perfectDes
end

function AnheimmpassruleView:onEnterFinished()
	AnheimmpassruleView.super.onEnterFinished(self)
end

function AnheimmpassruleView:onExit()
	AnheimmpassruleView.super.onExit(self)
end

function AnheimmpassruleView:onExitFinished()
	AnheimmpassruleView.super.onExitFinished(self)
end

return AnheimmpassruleView
