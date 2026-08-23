local BattleCommon = require("app.view.battle.common.BattleCommon")
local BattleConst = require("app.view.battle.const.BattleConst")
local BattlePauseLayer = class("BattlePauseLayer", require("app.fairyGUI.battle.UI_BattlePauseLayer"), function()
	return fgui.GComponent:create({
		resName = "BattlePauseLayer",
		pkgName = "battle",
		isFullScreen = true,
		pkgPath = "ui/battle/battle"
	})
end)

function BattlePauseLayer:ctor(arg_2_1)
	self._battleLayer = arg_2_1

	g.core.layer.LayerManager:getFloatLayer():setFloatCompVisible("battleAssistantIcon", true)
	self:_initBtn()
end

function BattlePauseLayer:onLoad()
	return
end

function BattlePauseLayer:onUnload()
	return
end

function BattlePauseLayer:_initBtn()
	self.m_quitBtn:addClickListener(handler(self, self._onClickQuit))
	self.m_goonBtn:addClickListener(handler(self, self._onClickGoon))
	self.m_settingBtn:addClickListener(handler(self, self._onClickSetting))

	if not BattleCommon:isCanOpeExitBattle() or g.core.guide.GuideProxy:isGuideRunning() then
		self.m_quitBtn:setVisible(false)
		self.m_showController:setSelectedIndex(1)
	else
		self.m_quitBtn:setVisible(true)
		self.m_showController:setSelectedIndex(0)
	end

	if g.core.guide.GuideProxy:isGuideRunning() then
		self.m_settingBtn:setVisible(false)
		g.core.layer.LayerManager:getFloatLayer():setFloatCompVisible("battleAssistantIcon", false)
	elseif g.core.model.User.activityLifeTimeCardData:isSubscription() then
		g.core.layer.LayerManager:getFloatLayer():setFloatCompVisible("battleAssistantIcon", true)
	end
end

function BattlePauseLayer:_onClickQuit()
	self._battleLayer:forceSkip()
	self._battleLayer:checkExtraTxt()
	self._battleLayer:removePauseLayer()
	g.core.battle.BattleProxy:battleFinish()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FAKE_PVP_BATTLE_RESULT, true, {
		skip = true
	})
	g.core.battle.BattleProxy:setForceExit(true)
end

function BattlePauseLayer:_onClickGoon()
	self._battleLayer:setPause(false)
	self._battleLayer:checkExtraTxt()
	self._battleLayer:removePauseLayer()
end

function BattlePauseLayer:_onClickSetting()
	local var_8_0 = require("app.view.battle.fgui.BattleSettingPop").new()

	g.core.layer.LayerManager:getFloatLayer():setFloatCompVisible("battleAssistantIcon", false)
	g.core.module.ModuleManager:pushPopup(var_8_0, {
		touchDisappear = true
	})

	self._settingLayer = var_8_0
end

function BattlePauseLayer:onUnload()
	local var_9_0 = g.core.module.ModuleManager:getCurModule()

	if var_9_0.name == "BATTLE_SPEED2" then
		var_9_0.display:removeSelf()
	end

	if self._settingLayer and not tolua.isnull(self._settingLayer) then
		self._settingLayer:removeSelf()
	end

	g.core.layer.LayerManager:getFloatLayer():setFloatCompVisible("battleAssistantIcon", false)
end

return BattlePauseLayer
