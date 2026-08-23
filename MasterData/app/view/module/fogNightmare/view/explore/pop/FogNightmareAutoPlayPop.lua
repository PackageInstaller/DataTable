local FogNightmareAutoPlayPop = class("FogNightmareAutoPlayPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareAutoPlayPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareAutoPlayPop",
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = true,
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightmareAutoPlayPop:ctor(arg_2_1)
	self._schedulerId = nil

	self.m_stopBtn:addClickListener(handler(self, self._onClickStopBtn))
	self.m_maskClick:addClickListener(handler(self, self._onClickMask))

	self._playLogic = arg_2_1
	self._isBattle = false

	g.core.model.User.fogNightmareData:getAutoPlay():setWaiterParam({
		showFunc = handler(self, self._onWaiterShow),
		hideFunc = handler(self, self._onWaiterHide)
	})
end

function FogNightmareAutoPlayPop:_onWaiterShow(arg_3_1)
	self:setVisible(false)
end

function FogNightmareAutoPlayPop:_onWaiterHide(arg_4_1)
	self:setVisible(true)
end

function FogNightmareAutoPlayPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_NEXTFLOOR, handler(self, self._onUpdateFloor), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_FOG_NIGHTMARE_AUTO_PLAY_STOP, handler(self, self._onReceiveCloseAutoPlay), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, self._onBattleStart, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_CHALLENGEBEGIN, self._onBattleStart, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_LOGIN_REPEAT, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_G2C_OFFLINE_NEW, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_LOGIN_OFFINE, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_CONNECT_FAIL, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_CONNECT_BROKEN, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_DISCONNECTED, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_TIMEOUT, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_EXPIRED, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_SERVER_BROKEN, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANTI_ADDICTION_NOTIFY, self._onAntiNotify, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_FOG_NIGHTMARE_AUTO_KEEPSAKE_SHOW, handler(self, self._onWaiterShow), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_FOG_NIGHTMARE_AUTO_KEEPSAKE_HIDE, handler(self, self._onWaiterHide), self)
	self:_onUpdateFloor()
	self:_playEffAnim()

	if not self._schedulerId then
		self._schedulerId = self:newSchedule(handler(self, self._autoPlay), g.core.model.User.fogNightmareData:getAutoPlay():getAutoInterval())

		self:_autoPlay()
	end
end

function FogNightmareAutoPlayPop:_loopEffect(arg_6_1)
	if arg_6_1.type == "complete" and self._spine and not tolua.isnull(self._spine) then
		self._spine:setAnimation(0, "play2", true)
	end
end

function FogNightmareAutoPlayPop:_playEffAnim()
	self.m_enterTransition:play()
	self.m_effPopTitle:addEffectSpine({
		anim = "play",
		name = "eff_ui_FogNightmare_popTitle",
		isLoop = false
	})
	self.m_effPopbg:addEffectSpine({
		anim = "play",
		name = "eff_ui_FogNightmare_popbg",
		isLoop = false
	})

	self._spine = self.m_effComTitle:addEffectSpine({
		anim = "play",
		name = "eff_ui_FogNightmare_comTitle",
		isLoop = false,
		eventHandler = handler(self, self._loopEffect)
	})
end

function FogNightmareAutoPlayPop:_autoPlay()
	if g.core.module.ModuleManager:getCurModule().display:getName() == "BattleScene" then
		self._isBattle = false
	end

	if not self:_checkAndRemoveOtherView() then
		self._playLogic()
	end
end

function FogNightmareAutoPlayPop:_stopTimer()
	if self._schedulerId then
		self:cancelSchedule(self._schedulerId)
	end

	self._schedulerId = nil
end

function FogNightmareAutoPlayPop:_checkAndRemoveOtherView()
	local var_10_0 = g.core.module.ModuleManager:getModuleByDisplayName("BaseFeedBackPop")

	if var_10_0 then
		var_10_0.display:onCancelCallback()
	end

	return var_10_0
end

function FogNightmareAutoPlayPop:_onUpdateFloor()
	self.m_floorText:setText((g.core.lang:get(500251, {
		floor = g.core.model.User.fogNightmareData:getTowerData():getCurrentFloorNum()
	})))
end

function FogNightmareAutoPlayPop:_onClickStopBtn()
	g.core.model.User.fogNightmareData:getAutoPlay():stopAutoPlay("")
end

function FogNightmareAutoPlayPop:_onClickMask()
	g.core.module.ModuleManager:tip(g.core.lang:get(500252))
end

function FogNightmareAutoPlayPop:_onNetBroken()
	g.core.model.User.fogNightmareData:getAutoPlay():stopAutoPlay(g.core.lang:get(500259))
end

function FogNightmareAutoPlayPop:_onAntiNotify(arg_15_1, arg_15_2, arg_15_3)
	if arg_15_3.is_fcm == 1 and arg_15_3.fcm_status == 4 then
		g.core.model.User.fogNightmareData:getAutoPlay():stopAutoPlay(g.core.lang:get(500258))
	end
end

function FogNightmareAutoPlayPop:_onBattleStart()
	self._isBattle = self._isBattle or true
end

function FogNightmareAutoPlayPop:_onReceiveCloseAutoPlay(arg_17_1, arg_17_2, arg_17_3)
	self:_stopTimer()

	arg_17_3 = arg_17_3 or self._msg

	local var_17_0 = g.core.module.ModuleManager:getCurModule()

	if (var_17_0 and var_17_0.display and var_17_0.display:getName() == "BattleResultLayer" or nil) and true then
		self._msg = arg_17_3

		self:newScheduleOnce(handler(self, self._onReceiveCloseAutoPlay), 1.5)

		self._isBattle = false

		self:setVisible(false)

		return
	end

	self:removeFromParent()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareAutoPlayEndPop").new(arg_17_3), {
		blackOpacity = 0.7,
		ignoreTouch = false,
		touchDisappear = false
	})
end

return FogNightmareAutoPlayPop
