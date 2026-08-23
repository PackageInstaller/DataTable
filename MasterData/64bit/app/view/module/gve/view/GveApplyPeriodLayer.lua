local var_0_0 = g.core.lang
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.network.GameNetProxy
local var_0_4 = g.core.const.ConstMgr
local var_0_5 = g.core.const.ConstMgr.GveConst
local var_0_6 = g.core.common.ServerTime
local var_0_7 = g.core.config.gve_regis_info
local var_0_8 = g.core.model.User.guildData
local var_0_9 = g.core.model.User.gveDataMgr
local var_0_10 = g.core.const.ConstMgr.GuideConst
local GveApplyPeriodLayer = class("GveApplyPeriodLayer", require("app.fairyGUI.gve.UI_GveApplyPeriodLayer"), function()
	return fgui.GComponent:create({
		pkgName = "gve",
		isFullScreen = true,
		pkgPath = "ui/gve/gve",
		resName = "GveApplyPeriodLayer"
	}, ...)
end)

function GveApplyPeriodLayer:ctor()
	self._regisId = 1
	self._signupStartTime = 0
	self._regisLen = var_0_7.getLength()

	self:addBg("bg/gve/bg_pshc_1.jpg", false, nil, 1)
	self:_initRegisterUI()
	self.m_enterTransition:play()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(var_0_4.FUNCTION_TYPE.GVE)
end

function GveApplyPeriodLayer:_initRegisterUI()
	self.m_preBtn:addClickListener(handler(self, self._onClickPrevBtn))
	self.m_nextBtn:addClickListener(handler(self, self._onClickNextlBtn))
end

function GveApplyPeriodLayer:onLoad()
	var_0_2:addEventListener(var_0_1.EVENT_NET_S2C_G_VE_GETINFO, handler(self, self._onS2cGetInfo), self)
	var_0_3:send_C2S_GVE_GetInfo({})

	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_STORY_PLAYED) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
			id = 1766
		})
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_STORY_PLAYED)
	end

	g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_SIGN_UP_STAGE_IN)
	g.core.model.User.guideData:setSaveServerData(21)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
		tickType = 6,
		enum = var_0_10.ENUM_TICK.GVE_IS_IN_SIGN_UP_STAGE
	})

	self._scheduleHandler = self:newSchedule(handler(self, self._onScheduleCD), 1)

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_NOTICESTATE, handler(self, self._onS2CNoticeAllianceState), self)
end

function GveApplyPeriodLayer:_onScheduleCD()
	self._signupEndTime = var_0_9:getGveSignUpEndTime()

	self.m_timeTxt:setText(var_0_0:get(309002, {
		time = var_0_6:getLeftDHMFormat(self._signupEndTime)
	}))

	if not self:_onS2CNoticeAllianceState() then
		return
	end

	if var_0_6:getLeftSeconds(self._signupEndTime) < 0 then
		if self._scheduleHandler then
			self:cancelSchedule(self._scheduleHandler)

			self._scheduleHandler = nil
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_ENTER_PLAY_TRANSITION, false, {
			forceCallFunc = true,
			isSpine = true,
			callback = function()
				g.core.module.ModuleManager:replaceModule(g.view.entrance.GVE_GAME_STAGE)
			end
		})
	end
end

function GveApplyPeriodLayer:_onS2CNoticeAllianceState()
	if not g.core.model.User.allianceData:isInAlliance() then
		g.core.module.ModuleManager:tip(g.core.lang:get(309198))
		self:newScheduleOnce(function()
			g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
		end, 0)

		return false
	end

	return true
end

function GveApplyPeriodLayer:_updatePreViewComp()
	self._signupEndTime = var_0_9:getGveSignUpEndTime()

	self.m_timeTxt:setText(var_0_0:get(309002, {
		time = var_0_6:getLeftDHMFormat(self._signupEndTime)
	}))
	self.m_previewComp:updatePreview(self._regisId)
	self.m_preBtn:setVisible(self._regisId > 1)
	self.m_nextBtn:setVisible(self._regisId < self._regisLen)
end

function GveApplyPeriodLayer:_updateSignUpState()
	if not var_0_9:getGveIsSignUp() then
		local var_10_0 = var_0_8:getMyRightId()

		if var_0_8:hasGuild() and (var_10_0 == 1 or var_10_0 == 2) then
			if not var_0_9:isCanSignUp() then
				self.m_applyBtn:setCtrlState("state", {
					index = var_0_5.GVE_SIGN_STATE.SIGNUP_END
				})
			else
				self.m_applyBtn:setCtrlState("state", {
					index = var_0_5.GVE_SIGN_STATE.NOSIGN_UP
				})
			end
		else
			self.m_applyBtn:setCtrlState("state", {
				index = var_0_5.GVE_SIGN_STATE.ONLY_LEADER
			})
		end
	else
		self.m_applyBtn:setCtrlState("state", {
			index = var_0_5.GVE_SIGN_STATE.SIGNUP
		})
	end
end

function GveApplyPeriodLayer:_onClickPrevBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_PSXY_To_Switch)

	if self._regisId <= 1 then
		return
	end

	self._regisId = self._regisId - 1

	self:_updatePreViewComp()
	self.m_switchTransition:play()
end

function GveApplyPeriodLayer:_onClickNextlBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_PSXY_To_Switch)

	if self._regisId >= self._regisLen then
		return
	end

	self._regisId = self._regisId + 1

	self:_updatePreViewComp()
	self.m_switchTransition:play()
end

function GveApplyPeriodLayer:_onClickSignupBtn()
	g.core.network.GameNetProxy:send_C2S_GVE_SignUp({})
end

function GveApplyPeriodLayer:_onS2cGetInfo()
	self:_updateSignUpState()
	self:_updatePreViewComp()
end

function GveApplyPeriodLayer:_onS2cGveSignUp()
	self:_updateSignUpState()
end

return GveApplyPeriodLayer
