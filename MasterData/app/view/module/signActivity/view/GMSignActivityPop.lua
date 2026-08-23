local var_0_0 = g.core.model.User.signActivityData
local var_0_1 = g.core.const.ConstMgr.SignActivityConst
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = g.core.config.activity_login_group_info
local var_0_4 = g.core.common.Path
local DrawKnight = require("app.view.common.DrawKnight")
local SignCustomActivityPop = class("SignCustomActivityPop", require("app.fairyGUI.signActivity.UI_GMSignActivityPop"), function()
	return fgui.GComponent:create({
		resName = "GMSignActivityPop",
		pkgPath = "ui/signActivity/signActivity",
		pkgName = "signActivity"
	})
end)

function SignCustomActivityPop:ctor(arg_2_1)
	if arg_2_1 and arg_2_1.endcall then
		self._closeCallBack = arg_2_1.endcall
	end

	self._groupId = 0
	self._functionId = var_0_2.GM_SIGN_ACTIVITY
	self._subId = var_0_1.SIGN_ACT_INDEX[self._functionId]

	local var_2_0 = var_0_3.get(self._subId)

	if var_2_0 then
		self._groupId = var_2_0.group
	end

	self._colorType = nil

	self:showAtCenter()
	self:setSize(display.width, display.height)
	self.m_touchArea:setSize(display.width, display.height)
	self.m_touchArea:addClickListener(handler(self, self._onClickClose))
	g.core.network.GameNetProxy:send_C2S_GmActivityLogin_GetInfo({})
	self.m_enterTransition:play(handler(self, self._checkAutoSignAward))
end

function SignCustomActivityPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GM_ACTIVITY_LOGIN_GETAWARD, self._onS2CGMActivityLoginGetAward, self)
	self:_updateGMUI()
	self:_updateMainView()
	self:newSchedule(handler(self, self._updateTimeText), 600)
end

function SignCustomActivityPop:_updateMainView()
	local var_4_0 = var_0_0:getSignSvrDataBySubId(self._subId)

	if var_4_0.award_group then
		for iter_4_0 = 1, var_0_0:getSignActivityDayCount(self._groupId) do
			self["m_dayIcon" .. iter_4_0]:updateDayIcon(var_0_0:getSingleDayRewardInfo(var_4_0.award_group, iter_4_0), self._subId)
		end

		self.m_descTxt:setText(var_0_3.get(self._subId).des)
	end

	self:_updateTimeText()
	self.m_effComp:removeAllEffect()
	self.m_effComp:addEffectSpine({
		isLoop = true,
		name = "eff_ui_signActivity_lizi"
	})
end

function SignCustomActivityPop:_updateGMUI()
	local var_5_0 = var_0_0:getSignSvrDataBySubId(self._subId)

	if var_5_0 then
		self.m_nameLoader:setURL("ui://text_new/" .. var_0_0:getLoginNameInfoByNameId(var_5_0.name_id).res)

		self._colorType = self._colorType or tonumber(var_0_0:getLoginResInfoById(var_5_0.res_id).res_id)

		self:_setUIByColorType()
		self.m_lookBtn:initButton({
			type = var_5_0.show_type,
			value = var_5_0.show_value
		})
		self.m_bigRewardLoader:setURL(var_0_4:getGMSignBigRewardRes(var_0_0:getLoginResInfoById(tonumber(var_5_0.show_back)).res_id))
	end
end

function SignCustomActivityPop:_setUIByColorType()
	local var_6_0 = var_0_4:getGMSignPopRes(self._colorType)

	self.m_rewardBg:setURL(var_6_0 .. var_0_1.SIGN_RESOURCE_NAME.REWARD_BG)
	self.m_descBg:setURL(var_6_0 .. var_0_1.SIGN_RESOURCE_NAME.DESC_BG)
	self.m_clock:setURL(var_6_0 .. var_0_1.SIGN_RESOURCE_NAME.CLOCK)
	self.m_lineLoader:setURL(var_6_0 .. var_0_1.SIGN_RESOURCE_NAME.LINE)
	self.m_atmosLoader:setURL(var_6_0 .. var_0_1.SIGN_RESOURCE_NAME.ATMOS)
	self.m_zsNumberLoader:setURL(var_6_0 .. var_0_1.SIGN_RESOURCE_NAME.SEVEN)

	for iter_6_0 = 1, 6 do
		if self["m_zsWordLoader" .. iter_6_0] then
			self["m_zsWordLoader" .. iter_6_0]:setURL(var_6_0 .. "pic_new7_zs_word" .. iter_6_0 .. ".png")
		end
	end

	for iter_6_1 = 1, var_0_0:getSignActivityDayCount(self._groupId) - 1 do
		self["m_dayIcon" .. iter_6_1]:updateDayNumber(var_6_0 .. "num_new7_" .. iter_6_1 .. ".png")
	end
end

function SignCustomActivityPop:_updateTimeText()
	local var_7_0 = var_0_0:getSignSvrDataBySubId(self._subId)

	if var_7_0 then
		local var_7_1, var_7_2, var_7_3, var_7_4 = g.core.common.ServerTime:getLeftTimeParts(var_7_0.limit_end_time)

		if var_7_3 > 0 or var_7_4 > 0 then
			var_7_2 = var_7_2 + 1
		end

		self.m_timeTxt:setText(g.core.lang:get(402504, {
			day = var_7_1,
			hour = var_7_2
		}))
	end
end

function SignCustomActivityPop:_checkAutoSignAward()
	if var_0_0:isCanGetSignAward(self._functionId) then
		local var_8_0 = var_0_0:getSignSvrDataBySubId(self._subId)

		if var_8_0 then
			g.core.network.GameNetProxy:send_C2S_GmActivityLogin_GetAward({
				id = var_8_0.id,
				day = var_0_0:getCanAwardDayIdx(self._subId)
			})
		end
	end
end

function SignCustomActivityPop:_onS2CGMActivityLoginGetAward(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = var_0_0:getSignSvrDataBySubId(self._subId)

	if not var_9_0 or arg_9_3.id ~= var_9_0.id then
		return
	end

	if arg_9_3.day and arg_9_3.awards then
		if not self["m_dayIcon" .. arg_9_3.day] then
			return
		end

		self["m_dayIcon" .. arg_9_3.day]:playSignedEffect(handler(self, function()
			if arg_9_3.awards then
				g.core.module.ModuleManager:awardSummary(arg_9_3.awards, true)
				g.core.network.GameNetProxy:send_C2S_GmActivityLogin_GetInfo({})
			end
		end))
	end
end

function SignCustomActivityPop:_onClickClose()
	self.m_backTransition:play(handler(self, self._onClose))
end

function SignCustomActivityPop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	self:homeLayerAutoPopup()
end

function SignCustomActivityPop:homeLayerAutoPopup()
	if self._closeCallBack then
		self._closeCallBack()

		self._closeCallBack = nil
	end
end

return SignCustomActivityPop
