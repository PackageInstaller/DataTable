local var_0_0 = g.core.const.ConstMgr.ExplorationConst
local ExplorationBuffSelectPop = class("ExplorationBuffSelectPop", require("app.fairyGUI.exploration.UI_ExplorationBuffSelectPop"), function()
	return fgui.GComponent:create({
		resName = "ExplorationBuffSelectPop",
		pkgName = "exploration"
	})
end)

function ExplorationBuffSelectPop:ctor(arg_2_1)
	self:showAtCenter()

	self._uniqueId = arg_2_1:getEventUniqueID()
	self._buffIdList = arg_2_1:getEventBuffList()

	self:_initBtn()
	self:updateView()
end

function ExplorationBuffSelectPop:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_EVENTPROCESS, self._onRecvSelectBuff, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_EXPLORATION_EVENTPROCESS_FAILED, self._onRecvEventFailed, self)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_CARD_MENU_OPEN)
end

function ExplorationBuffSelectPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EXPLORATION_FORMATION_FIGHT_VALUE_CHECK, false)
end

function ExplorationBuffSelectPop:_initBtn()
	for iter_5_0 = 1, 3 do
		self["m_cardComp" .. iter_5_0].powerIndex = iter_5_0

		self["m_cardComp" .. iter_5_0]:addClickListener(handler(self, self.onSelectCardClick))
	end
end

function ExplorationBuffSelectPop:updateView()
	for iter_6_0 = 1, 3 do
		self["m_cardComp" .. iter_6_0]:updateCardInfo(self._buffIdList[iter_6_0])
	end
end

function ExplorationBuffSelectPop:onSelectCardClick(arg_7_1)
	local var_7_0 = arg_7_1:getSender().powerIndex

	if self._buffIdList[var_7_0] then
		g.core.model.User.explorationData:saveTempEventBuffId(self._buffIdList[var_7_0])
		g.core.network.GameNetProxy:send_C2S_Exploration_EventProcess({
			unique_id = self._uniqueId,
			params = {
				var_7_0 - 1
			}
		})
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_SELECT_EXPLORE_GAIN)
	end
end

function ExplorationBuffSelectPop:_onRecvSelectBuff(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_3 and arg_8_3.event and arg_8_3.event.tp and arg_8_3.event.tp == var_0_0.EVENT_TYPE.TYPE_BUFF then
		g.core.module.ModuleManager:tip(g.core.lang:get(420667))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function ExplorationBuffSelectPop:_onRecvEventFailed(arg_9_1, arg_9_2, arg_9_3)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return ExplorationBuffSelectPop
