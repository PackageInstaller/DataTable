local var_0_0 = g.core.config.exploration_game_info
local var_0_1 = g.core.const.ConstMgr.ExplorationConst
local ExplorationTickGamePop = class("ExplorationTickGamePop", require("app.fairyGUI.exploration.UI_ExplorationTickGamePop"), function()
	return fgui.GComponent:create({
		resName = "ExplorationTickGamePop",
		pkgPath = "ui/exploration/exploration",
		pkgName = "exploration"
	}, ...)
end)

function ExplorationTickGamePop:ctor(arg_2_1)
	self:showAtCenter()

	self._eventData = arg_2_1

	self:updateEventView()
	self.m_startBtn:addClickListener(handler(self, self._onStartGameClick))
	self.m_closeBtn:addClickListener(handler(self, self._onClosePop))

	if self._eventData.tp == var_0_1.EVENT_TYPE.GAME_FLOP then
		self.m_selectTagController:setSelectedIndex(1)
	elseif self._eventData.tp == var_0_1.EVENT_TYPE.GAME_TURNTABLE then
		self.m_selectTagController:setSelectedIndex(0)
	elseif self._eventData.tp == var_0_1.EVENT_TYPE.GAME_WALLET then
		self.m_selectTagController:setSelectedIndex(2)
	end
end

function ExplorationTickGamePop:onLoad()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Tree_Draw_Click)
	self.m_enterTransition:play()

	if self._eventData.tp == var_0_1.EVENT_TYPE.GAME_FLOP then
		self.m_enterEffect:addEffectSpine({
			anim = "play2",
			name = "eff_ui_explorationTree_enter",
			remove = true,
			isLoop = false
		})
	elseif self._eventData.tp == var_0_1.EVENT_TYPE.GAME_TURNTABLE then
		self.m_enterEffect:addEffectSpine({
			anim = "play1",
			name = "eff_ui_explorationTree_enter",
			remove = true,
			isLoop = false
		})
	elseif self._eventData.tp == var_0_1.EVENT_TYPE.GAME_WALLET then
		self.m_enterEffect:addEffectSpine({
			anim = "play3",
			name = "eff_ui_explorationTree_enter",
			remove = true,
			isLoop = false
		})
	end
end

function ExplorationTickGamePop:updateEventView()
	local var_4_0 = var_0_0.get(self._eventData.id)

	self.m_eventNameTxt:setText(var_4_0.event_name)
	self.m_eventNameTxt2:setText(var_4_0.event_name)
end

function ExplorationTickGamePop:_onStartGameClick()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._eventData then
		if self._eventData.tp == var_0_1.EVENT_TYPE.GAME_FLOP then
			g.core.module.ModuleManager:pushModule(g.view.entrance.EXPLORATION_TURNCARD, self._eventData)
		elseif self._eventData.tp == var_0_1.EVENT_TYPE.GAME_TURNTABLE then
			g.core.module.ModuleManager:pushModule(g.view.entrance.EXPLORATION_WISHTREE, self._eventData)
		elseif self._eventData.tp == var_0_1.EVENT_TYPE.GAME_WALLET then
			g.core.module.ModuleManager:pushModule(g.view.entrance.EXPLORATION_REDPACKAGE, self._eventData)
		end
	end
end

function ExplorationTickGamePop:_onClosePop()
	self.m_backTransition:play(handler(self, self._onRemoveSelf))
end

function ExplorationTickGamePop:_onRemoveSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return ExplorationTickGamePop
