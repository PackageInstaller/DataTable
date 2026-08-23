local var_0_0 = g.core.model.User.signActivityData
local var_0_1 = g.core.const.ConstMgr.SignActivityConst
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = g.core.config.activity_login_group_info
local CrownBlueCustomActivityPop = class("CrownBlueCustomActivityPop", require("app.fairyGUI.signActivity.UI_CrownBlueCustomActivityPop"), function()
	return fgui.GComponent:create({
		resName = "CrownBlueCustomActivityPop",
		pkgName = "signActivity",
		pkgPath = "ui/signActivity/signActivity"
	})
end)

function CrownBlueCustomActivityPop:ctor(arg_2_1)
	if arg_2_1 and arg_2_1.endcall then
		self._closeCallBack = arg_2_1.endcall
	end

	self._groupId = 0
	self._functionId = var_0_2.CROWNBLUE_SIGN_ACTIVITY

	self:showAtCenter()
	self:setSize(display.width, display.height)
	self.m_roleLoader:setURL("pic/signActivity/bg_3signly_juese1.png")
	self.m_closeBtn:addClickListener(handler(self, self._onClickClose))
	g.core.network.GameNetProxy:send_C2S_GmActivityLogin_GetInfo({})
	self.m_enterTransition:play(handler(self, self._checkAutoSignAward))
end

function CrownBlueCustomActivityPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GM_ACTIVITY_LOGIN_GETAWARD, self._onS2CGMActivityLoginGetAward, self)
	self:_updateMainView()
	self:newSchedule(handler(self, self._updateTimeText), 600)
end

function CrownBlueCustomActivityPop:_updateMainView()
	local var_4_0 = var_0_3.get(var_0_1.SIGN_ACT_INDEX[self._functionId])

	if var_4_0 then
		self._groupId = var_4_0.group

		for iter_4_0 = 1, var_0_0:getSignActivityDayCount(self._groupId) do
			self["m_dayIcon" .. iter_4_0]:updateDayIcon(var_0_0:getSingleDayRewardInfo(self._groupId, iter_4_0), var_0_1.SIGN_ACT_INDEX[self._functionId])
		end
	end

	self:_updateTimeText()
end

function CrownBlueCustomActivityPop:_updateTimeText()
	local var_5_0 = var_0_0:getSignSvrDataBySubId(var_0_1.SIGN_ACT_INDEX[self._functionId])

	if var_5_0 then
		local var_5_1, var_5_2, var_5_3, var_5_4 = g.core.common.ServerTime:getLeftTimeParts(var_5_0.limit_end_time)

		if var_5_3 > 0 or var_5_4 > 0 then
			var_5_2 = var_5_2 + 1
		end

		self.m_timeTxt:setText(g.core.lang:get(402504, {
			day = var_5_1,
			hour = var_5_2
		}))
	end
end

function CrownBlueCustomActivityPop:_checkAutoSignAward()
	if var_0_0:isCanGetSignAward(self._functionId) then
		local var_6_0 = var_0_0:getSignSvrDataBySubId(var_0_1.SIGN_ACT_INDEX[self._functionId])

		if var_6_0 then
			g.core.network.GameNetProxy:send_C2S_GmActivityLogin_GetAward({
				id = var_6_0.id,
				day = var_0_0:getCanAwardDayIdx(var_0_1.SIGN_ACT_INDEX[self._functionId])
			})
		end
	end
end

function CrownBlueCustomActivityPop:_onS2CGMActivityLoginGetAward(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = var_0_0:getSignSvrDataBySubId(var_0_1.SIGN_ACT_INDEX[self._functionId])

	if not var_7_0 or arg_7_3.id ~= var_7_0.id then
		return
	end

	if arg_7_3.day and arg_7_3.awards then
		if not self["m_dayIcon" .. arg_7_3.day] then
			return
		end

		self["m_dayIcon" .. arg_7_3.day]:playSignedEffect(handler(self, function()
			if arg_7_3.awards then
				g.core.module.ModuleManager:awardSummary(arg_7_3.awards, true)
				g.core.network.GameNetProxy:send_C2S_GmActivityLogin_GetInfo({})
			end
		end))
	end
end

function CrownBlueCustomActivityPop:_onClickClose()
	self.m_backTransition:play(handler(self, self._onClose))
end

function CrownBlueCustomActivityPop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	self:homeLayerAutoPopup()
end

function CrownBlueCustomActivityPop:homeLayerAutoPopup()
	if self._closeCallBack then
		self._closeCallBack()

		self._closeCallBack = nil
	end
end

return CrownBlueCustomActivityPop
