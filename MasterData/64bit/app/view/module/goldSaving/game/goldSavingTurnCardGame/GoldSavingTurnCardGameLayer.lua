local var_0_0 = g.core.model.User.goldSavingData
local GoldSavingTurnCardGameLayer = class("GoldSavingTurnCardGameLayer", require("app.fairyGUI.goldSaving.UI_GoldSavingTurnCardGameLayer"), function()
	return fgui.GComponent:create({
		pkgName = "goldSaving",
		isFullScreen = true,
		pkgPath = "ui/goldSaving/goldSaving",
		resName = "GoldSavingTurnCardGameLayer"
	}, ...)
end)

function GoldSavingTurnCardGameLayer:ctor(arg_2_1)
	self._gameId = arg_2_1.cfg.id
	self._curAward = nil
	self._tipHandler = nil
	self._curActId = arg_2_1.actId

	self:_initData()
	self:_initView()
	self:addListen(self.m_rightComp)
	self.m_topBarComp:setTitle(arg_2_1.cfg.event_name)
	self.m_topBarComp:setResInfoById(308)
	self.m_topBarComp:setTopIconGroupVisible(false)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_CardWindow)
end

function GoldSavingTurnCardGameLayer:_initData()
	self._rewardDict = var_0_0:getRewardDict()
	self._cardStatus = {
		{
			0,
			0,
			0
		},
		{
			0,
			0,
			0
		},
		{
			0,
			0,
			0
		}
	}
end

function GoldSavingTurnCardGameLayer:_initView()
	self:addBg("bg/goldSaving/bg_sj_game1.jpg")

	for iter_4_0 = 1, 3 do
		self["m_leftCell" .. iter_4_0]:updateLeftCell(self._rewardDict[iter_4_0], iter_4_0)
	end
end

function GoldSavingTurnCardGameLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_GAMEOVER, handler(self, self._onS2CGoldSavingGameOver), self)
	self.m_enterTransition:play()

	self._tipHandler = self:newScheduleOnce(handler(self, self._tipFunc), 2)
end

function GoldSavingTurnCardGameLayer:_tipFunc()
	if self.m_handHolder then
		local var_6_0 = fgui.UIPackage:createObject("guide", "GuideTouchComp")

		self.m_handHolder:addChild(var_6_0)
		var_6_0:updateView(nil, {
			centerPos = self.m_handHolder:getPosition(),
			centerPos1 = self.m_handHolder:getPosition()
		}, false, false)

		if self._tipHandler then
			self:cancelSchedule(self._tipHandler)

			self._tipHandler = nil
		end
	end
end

function GoldSavingTurnCardGameLayer:_onS2CGoldSavingGameOver(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4 and arg_7_4.awards then
		self._curAward = arg_7_4.awards
	end
end

function GoldSavingTurnCardGameLayer:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "turn_card" then
		self.m_handHolder:removeChildren()

		if self._tipHandler then
			self:cancelSchedule(self._tipHandler)

			self._tipHandler = nil
		end

		local var_8_0 = arg_8_2.index

		if var_0_0:isLastCard(arg_8_2.index) then
			self:setTouchable(false)
			self:newScheduleOnce(handler(self, function(arg_9_0)
				local var_9_0 = var_0_0:getRewardId()

				g.core.network.GameNetProxy:send_C2S_GoldSaving_GameOver({
					game_id = arg_9_0._gameId
				})
				arg_9_0["m_leftCell" .. var_9_0]:playFinishAnim(var_9_0, handler(arg_9_0, arg_9_0._onFinishAnim))
				arg_9_0:_checkActId()
			end), 2)
		end

		local var_8_1 = var_0_0:getCardTypeByIndex(var_8_0)
		local var_8_2 = self:_getNextIconIndexByType(var_8_1)

		self._cardStatus[var_8_1][var_8_2] = 1

		self:newScheduleOnce(function()
			self["m_leftCell" .. var_8_1]:updateCellStatus(var_8_2 - 1, var_8_1)
		end, 1)
	end
end

function GoldSavingTurnCardGameLayer:_onFinishAnim()
	if self._curAward then
		self._curAward = nil

		g.core.module.ModuleManager:awardSummary(clone(self._curAward), nil, nil, g.core.lang:get(300001), handler(self, self._onClose))
	end
end

function GoldSavingTurnCardGameLayer:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function GoldSavingTurnCardGameLayer:_getNextIconIndexByType(arg_13_1)
	for iter_13_0 = 1, 3 do
		if self._cardStatus[arg_13_1][iter_13_0] == 0 then
			return iter_13_0
		end
	end
end

function GoldSavingTurnCardGameLayer:_checkActId()
	if self._curActId ~= nil and g.core.model.User.goldSavingData:getCurActId() ~= self._curActId then
		g.core.module.ModuleManager:tip(g.core.lang:get(307029))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

return GoldSavingTurnCardGameLayer
