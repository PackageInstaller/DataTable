local var_0_0 = g.core.model.User.richmanData
local var_0_1 = g.core.config.richman_game_info
local var_0_2 = g.core.config.richman_event_info
local RichmanConst = require("app.view.module.richman.const.RichmanConst")
local RichmanTickGamePop = class("RichmanTickGamePop", require("app.fairyGUI.richman.UI_RichmanTickGamePop"), function()
	return fgui.GComponent:create({
		resName = "RichmanTickGamePop",
		pkgPath = "ui/richman/richman",
		pkgName = "richman"
	}, ...)
end)

function RichmanTickGamePop:ctor(arg_2_1)
	self:showAtCenter()

	self._eventData = arg_2_1

	self:updateEventView()
	self.m_startBtn:addClickListener(handler(self, self._onStartGameClick))
	self.m_closeBtn:setClickCallBack(handler(self, self._onClosePop))

	if self._eventData.tp == RichmanConst.EVENT_TYPE.GAME_TURNCARD then
		self.m_selectTagController:setSelectedIndex(1)
	elseif self._eventData.tp == RichmanConst.EVENT_TYPE.GAME_TURNTABLE then
		self.m_selectTagController:setSelectedIndex(0)
	elseif self._eventData.tp == RichmanConst.EVENT_TYPE.GAME_REDPACKET then
		self.m_selectTagController:setSelectedIndex(2)
	end
end

function RichmanTickGamePop:onLoad()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_GameMachine)
	self.m_enterTransition:play()
	self.m_eff:addEffectSpine({
		remove = true,
		name = "eff_ui_richman_pop",
		isLoop = false
	})
	self:newSchedule(handler(self, self.updateTimeRun), 1)
	self:updateTimeRun()
end

function RichmanTickGamePop:updateTimeRun()
	if self._eventData then
		local var_4_0 = self._eventData.finishTime or self._cfg.time + self._eventData.create_time

		if var_4_0 <= g.core.common.ServerTime:getTime() then
			g.core.module.ModuleManager:tip(g.core.lang:get(426021))

			local var_4_1 = var_0_0:getEventByTypeList({
				[self._eventData.tp] = true
			})

			if next(var_4_1[self._eventData.tp]) then
				self._eventData = var_4_1[self._eventData.tp][1]

				self.m_lastTimeTxt:setText("-")
			else
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end
		else
			self.m_lastTimeTxt:setText(g.core.lang:get(426020, {
				time = g.core.common.ServerTime:getLeftSecondsString(var_4_0)
			}))
		end
	end
end

function RichmanTickGamePop:updateEventView()
	local var_5_1 = var_0_2.get(self._eventData.base_id or self._eventData.id)
	local var_5_2 = var_0_1.get(var_5_1.event_value1)

	self._cfg = var_5_1

	self.m_eventNameTxt:setText(var_5_2.event_name)
	self.m_eventNameTxt2:setText(var_5_2.event_name)
end

function RichmanTickGamePop:_onStartGameClick()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._eventData then
		local var_6_0 = {}

		var_6_0.id = self._eventData.base_id or self._eventData.id
		var_6_0.unique_id = self._eventData.unique_id
		var_6_0.params = self._eventData.params
		var_6_0.tp = self._eventData.tp

		if self._eventData.tp == RichmanConst.EVENT_TYPE.GAME_TURNCARD then
			g.core.module.ModuleManager:pushModule(g.view.entrance.RICHMAN_TURN_CARD, var_6_0)
		elseif self._eventData.tp == RichmanConst.EVENT_TYPE.GAME_TURNTABLE then
			g.core.module.ModuleManager:pushModule(g.view.entrance.RICHMAN_TURN_GAME, var_6_0)
		elseif self._eventData.tp == RichmanConst.EVENT_TYPE.GAME_REDPACKET then
			g.core.module.ModuleManager:pushModule(g.view.entrance.RICHMAN_RED_PACKET_RAIN, var_6_0)
		end
	end
end

function RichmanTickGamePop:_onClosePop()
	self.m_backTransition:play(handler(self, self._onRemoveSelf))
end

function RichmanTickGamePop:_onRemoveSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return RichmanTickGamePop
