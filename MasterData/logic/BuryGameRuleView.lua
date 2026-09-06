-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/BuryGameRuleView.lua

module("logic.extensions.burygame.view.BuryGameRuleView", package.seeall)

local BuryGameRuleView = class("BuryGameRuleView", ViewComponent)

function BuryGameRuleView:unbindEvents()
	BuryGameRuleView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function BuryGameRuleView:bindEvents()
	BuryGameRuleView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function BuryGameRuleView:onExit()
	BuryGameRuleView.super.onExit(self)
end

function BuryGameRuleView:buildUI()
	BuryGameRuleView.super.buildUI(self)

	self._closeButton = self:getBtn("btnSureAccept")
	self._txtDesc = self:getTxt("txtDesc")
end

function BuryGameRuleView:onEnter()
	BuryGameRuleView.super.onEnter(self)

	local param = self:getOpenParam()

	if param then
		self._handler = param[1]
		self._handlerObj = param[2]
	end

	local ruleCfg = RulesConfig.instance:getRuleCo("burygamegate2")
	local rightScorePer = checknumber(BuryGameConfig.instance:getConstantValue("t2"))
	local wrongScorePer = checknumber(BuryGameConfig.instance:getConstantValue("t3"))

	self._txtDesc.text = string.format(ruleCfg.rules, rightScorePer, wrongScorePer)
end

function BuryGameRuleView:_onClickClose()
	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.SuppressGameToStartGame)
	GameUtil.callBack(self._handler, self._handlerObj)
end

return BuryGameRuleView
