local var_0_0 = g.core.const.ConstMgr.EchoLabConst
local var_0_1 = g.core.model.User.echoLabData
local EchoLabMainLayer = class("EchoLabMainLayer", require("app.fairyGUI.echoLab.UI_EchoLabMainLayer"), function()
	return fgui.GComponent:create({
		resName = "EchoLabMainLayer",
		pkgPath = "ui/echoLab/echoLab",
		isFullScreen = true,
		pkgName = "echoLab"
	}, ...)
end)

function EchoLabMainLayer:ctor()
	self._isFirstEnter = true
	self._isClickGetAward = false

	self:_initMainLayerUI()
	self:_initRegisterListen()
end

function EchoLabMainLayer:_initRegisterListen()
	self.m_entranceBtn1:addClickListener(handler(self, self._onClickEntranceBtn))
	self.m_entranceBtn2:addClickListener(handler(self, self._onClickEntranceBtn))
	self.m_entranceBtn3:addClickListener(handler(self, self._onClickEntranceBtn))
	self.m_outPutComp1:addClickListener(handler(self, self._onClickOutPutComp))
	self.m_outPutComp2:addClickListener(handler(self, self._onClickOutPutComp))
end

function EchoLabMainLayer:_initMainLayerUI()
	self.m_topBarComp:setResInfoById(249)
	self:addBg("bg/echoLab/bg_echo_main2.jpg", nil, nil, 1)
	self.m_enterTransition:play()

	self._isFirstEnter = false
end

function EchoLabMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PALACE_GETINFO, handler(self, self._updateMainView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PALACE_GETHANGUPAWARD, handler(self, self._onS2CGetHangupAward), self)
	g.core.network.GameNetProxy:send_C2S_Palace_GetInfo({})
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ECHO_LAB)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_ECHOENTER)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_PEAK_ARENA_LAYER)
end

function EchoLabMainLayer:_updateMainView()
	local var_6_0, var_6_1 = var_0_1:getCollectData():getAllHangUpInfo()

	for iter_6_0 = 1, var_0_0.HANG_UP_COUNT do
		self["m_outPutComp" .. iter_6_0]:setVisible(false)

		if var_6_0[iter_6_0] and var_6_1[iter_6_0] then
			local var_6_2 = tonumber(math.floor(var_6_1[iter_6_0].ratio * 100))

			if var_6_2 >= 1 then
				self["m_outPutComp" .. iter_6_0]:updateOutPutIcon(var_6_0[iter_6_0], var_6_2)
				self["m_outPutComp" .. iter_6_0]:setVisible(true)

				self._isClickGetAward = false
			end
		end
	end

	for iter_6_1 = 1, var_0_0.ENTRANCE_NUM do
		self["m_entranceBtn" .. iter_6_1]:updateBtnState(iter_6_1)
	end

	self:_playMainLayerEnterEff()
end

function EchoLabMainLayer:_onClickEntranceBtn(arg_7_1)
	local var_7_0 = arg_7_1:getSender():getName()
	local var_7_1 = tonumber(string.sub(var_7_0, #var_7_0))

	if var_7_1 == var_0_0.COLLECT then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ECHO_LAB_COLLECT)
	elseif var_7_1 == var_0_0.DATATREE then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ECHOLAB_TREE_LAYER)
	elseif var_7_1 == var_0_0.TERMINAL then
		local var_7_2, var_7_3 = var_0_1:isUnlockEchoLabTerminal()

		if var_0_1:isUnlockEchoLabTerminal() then
			g.core.module.ModuleManager:pushModule(g.view.entrance.ECHOLAB_TERMINAL)
		else
			g.core.module.ModuleManager:tip(var_7_3)
		end
	end
end

function EchoLabMainLayer:_onClickOutPutComp()
	for iter_8_0 = 1, var_0_0.HANG_UP_COUNT do
		self["m_outPutComp" .. iter_8_0]:playGetAwardEff()
	end

	self:newScheduleOnce(function()
		if not self._isClickGetAward then
			g.core.network.GameNetProxy:send_C2S_Palace_GetHangupAward({
				build_type = 0
			})

			self._isClickGetAward = true
		end
	end, 0.3)
end

function EchoLabMainLayer:_onS2CGetHangupAward(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		award = {
			awards = arg_10_4.awards
		}
	})
	self:_updateMainView()
end

function EchoLabMainLayer:_playMainLayerEnterEff()
	if not self._isFirstEnter then
		self.m_enterTransition:play()
	end

	for iter_11_0 = 1, var_0_0.ENTRANCE_NUM do
		self["m_entranceBtn" .. iter_11_0]:playEnterTransition(iter_11_0)
	end

	self.m_bgComp:updateBgEffect()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

return EchoLabMainLayer
