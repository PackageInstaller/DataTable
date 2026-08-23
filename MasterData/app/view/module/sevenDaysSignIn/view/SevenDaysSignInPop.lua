local var_0_0 = g.core.model.User.sevenDaysSignInData
local SevenDaysSignInConst = require("app.view.module.sevenDaysSignIn.const.SevenDaysSignInConst")
local SevenDaysSignInPop = class("SevenDaysSignInPop", require("app.fairyGUI.sevenDaysSignIn.UI_SevenDaysSignInPop"), function()
	return fgui.GComponent:create({
		resName = "SevenDaysSignInPop",
		pkgPath = "ui/sevenDaysSignIn/sevenDaysSignIn",
		isFullScreen = true,
		pkgName = "sevenDaysSignIn"
	}, ...)
end)

function SevenDaysSignInPop:ctor(arg_2_1)
	var_0_0:setAutoNextEnable(false)

	if arg_2_1 and arg_2_1.endcall then
		self._closeCallBack = arg_2_1.endcall
	end

	self._timer = nil
	self._phase = 1

	self:_initView()
end

function SevenDaysSignInPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_LOGIN_REWARD_INFO, self._onRcvLoginRewardInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_LOGIN_REWARD_AWARD, self._onRcvLoginRewardAward, self)
	self.m_clickBtn:setTouchable(false)

	if var_0_0:isNeedUpdateInfo() then
		g.core.network.GameNetProxy:send_C2S_LoginReward_Info({})
	else
		self:_onRcvLoginRewardInfo()
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SEVEN_DAYS_SIGN_IN_POP)
	var_0_0:enterSevenDayView()
end

function SevenDaysSignInPop:receiveCompEvent(arg_4_1, arg_4_2)
	if arg_4_1 == "COMP_EVENT_GET_AWARD" then
		self.m_awardList:setTouchable(false)
		self.m_clickBtn:setTouchable(false)
		g.core.network.GameNetProxy:send_C2S_LoginReward_Award({
			id = arg_4_2
		})

		return true
	end
end

function SevenDaysSignInPop:onUnload()
	self:_cancelTimer()
	require("app.view.module.home.common.HomeModuleAutoPopup"):checkNextSevenPop()
end

function SevenDaysSignInPop:homeLayerAutoPopup()
	if self._closeCallBack then
		self._closeCallBack()

		self._closeCallBack = nil
	end
end

function SevenDaysSignInPop:_onRcvLoginRewardInfo()
	self._phase = var_0_0:getPhase()

	self:_updateView()
	self:_playEnterAni()
	self:_autoGetAwards()
end

function SevenDaysSignInPop:_onRcvLoginRewardAward(arg_8_1, arg_8_2, arg_8_3)
	self:_updateView()

	local var_8_0 = g.core.config.login_reward_info.get(arg_8_3.id)

	self.m_awardList:getChildAt(var_0_0:dayToPhaseDay(var_8_0.day) - 1):playReceiveAni(function(arg_9_0)
		if arg_9_0.type == "complete" then
			self:_showAwardPopView(var_8_0)
		end
	end)
end

function SevenDaysSignInPop:_showAwardPopView(arg_10_1)
	self.m_awardList:setTouchable(true)
	self.m_clickBtn:setTouchable(true)
	g.core.module.ModuleManager:awardSummary({
		{
			type = arg_10_1.reward_type,
			value = arg_10_1.reward_value,
			size = arg_10_1.reward_size
		}
	})
end

function SevenDaysSignInPop:_onItemRenderer(arg_11_1, arg_11_2)
	arg_11_2:updateCell((var_0_0:phaseDayToDay(self._phase, arg_11_1 + 1)))
end

function SevenDaysSignInPop:_onClickClose(arg_12_1)
	if not self.m_clickBtn:isTouchable() then
		return
	end

	self.m_clickBtn:setTouchable(false)
	self:dispatchCompEvent("PopView_Close")
	self.m_backTransition:play(function()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SEVEN_DAYS_SIGN_IN_PUSH)
end

function SevenDaysSignInPop:_initView()
	self.m_awardList:setIniter(self)
	self.m_awardList:doFairyBatching(true)
	self.m_awardList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_clickBtn:addClickListener(handler(self, self._onClickClose))
	self:showAtCenter()
end

function SevenDaysSignInPop:_updateView()
	if self._phase == 1 then
		self.m_signInBgComp_1:updateComp(self._phase)
		self.m_phaseController:setSelectedIndex(0)
	else
		self.m_signInBgComp_2:updateComp(self._phase)
		self.m_phaseController:setSelectedIndex(1)
	end

	if g.core.utils.Rule.isHideSignActivityKnightImg() then
		self.m_signInBgComp_1:setVisible(false)
		self.m_signInBgComp_2:setVisible(false)
		self.m_phaseController:setSelectedIndex(0)
	end

	self.m_awardList:setNumItems(SevenDaysSignInConst.TOTAL_SIGN_IN_DAYS)
	self:_checkNeedTurnToNextSeven()
end

function SevenDaysSignInPop:_cancelTimer()
	if self._timer then
		g.core.common.Scheduler:cancelSchedule(self._timer)

		self._timer = nil
	end
end

function SevenDaysSignInPop:_playEnterAni()
	self.m_enterTransition:play(handler(self, function()
		self.m_clickBtn:setTouchable(true)
	end))
end

function SevenDaysSignInPop:_autoGetAwards()
	for iter_19_0, iter_19_1 in ipairs((var_0_0:getCanRcvAwardDayArrWithPhase(self._phase))) do
		g.core.network.GameNetProxy:send_C2S_LoginReward_Award({
			id = var_0_0:getInfoWithDay(iter_19_1).id
		})
	end
end

function SevenDaysSignInPop:_checkNeedTurnToNextSeven()
	if self._phase == 1 then
		local var_20_0 = true

		for iter_20_0 = 1, SevenDaysSignInConst.TOTAL_SIGN_IN_DAYS do
			if var_0_0:getState(iter_20_0) ~= 2 then
				var_20_0 = false

				break
			end
		end

		if var_20_0 then
			var_0_0:setAutoNextEnable(true)
		end
	end
end

return SevenDaysSignInPop
