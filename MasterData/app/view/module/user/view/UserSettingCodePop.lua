local UserSettingCodePop = class("UserSettingCodePop", require("app.fairyGUI.user.UI_UserSettingCodePop"), function()
	return fgui.GComponent:create({
		resName = "UserSettingCodePop",
		pkgPath = "ui/user/user",
		pkgName = "user"
	})
end)

function UserSettingCodePop:ctor()
	self:getView():center(true)
	self:_addUIListener()
	self:_reset()

	if not g.core.model.User.homeData:isInitHarmoniousMystery() then
		g.core.network.GameNetProxy:send_C2S_HarmoniousMystery_Infos({})
	end
end

function UserSettingCodePop:_addUIListener()
	self.m_btnExchange:addClickListener(handler(self, self._onSendCode))
end

function UserSettingCodePop:_resetUI()
	self._enterTrans = self:getView():getTransition("enter")
	self._backTrans = self:getView():getTransition("back")

	self.m_bgPanel:getChild("closeBtn"):setCloseAnimAndCallBack(self._backTrans, nil, handler(self, self._customPopOutTrans))
	self.m_codeInput:setPrompt(g.core.lang:get(101547))
end

function UserSettingCodePop:_reset()
	self:_resetUI()
end

function UserSettingCodePop:_addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GIFT_CODE, handler(self, self._onRecvCodeRewards), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_GIFTCODE, handler(self, self._onRecvCodeRewards), self)
end

function UserSettingCodePop:onLoad()
	self:_addCustomListener()
	self.m_content:setVisible(false)
	g.core.common.Scheduler:newScheduleOnce(handler(self, function()
		self._enterTrans:play()
		self.m_content:setVisible(true)
	end), 0.2)
end

function UserSettingCodePop:_onSendCode()
	local var_9_0 = self.m_codeInput:getText()

	if var_9_0 == "" then
		g.core.module.ModuleManager:tip(g.core.lang:get(1191))

		return
	end

	if config.KEY_WORD_OPEN_DEBUG and not config.SHOW_DEBUG_BTN then
		self._code = self._code or 0

		if var_9_0 == "lanyike_vs_xiaoyy" then
			self._code = 1

			return
		elseif var_9_0 == "daqi_vs_wutt" and self._code == 1 then
			self._code = 2

			return
		elseif var_9_0 == "chongxu_vs_ha" and self._code == 2 or var_9_0 == "xhdczdhmster10010" then
			g.core.layer.LayerManager:addDebugBtn()

			return
		elseif var_9_0 == "show_fps_jgame" then
			cc.Director:getInstance():setDisplayStats(true)

			return
		else
			self._code = 0
		end
	end

	if #var_9_0 >= 14 and #var_9_0 <= 18 then
		if g.core.model.User.homeData:isTopSwitch() and g.core.model.User.homeData:isCodeCorrect(var_9_0) or true then
			local var_9_2 = g.core.config.net_msg_error.fetch(501)

			g.core.module.ModuleManager:tip(var_9_2 and var_9_2.error_msg)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
				event_id = g.core.const.ConstMgr.SuperSdkConst.USE_FHX_HIGH_QUALITY_CODE
			})
		end

		return
	end

	self.m_codeInput:setText("")
	g.core.network.GameNetProxy:send_C2S_New_GiftCode({
		code = var_9_0
	})
end

function UserSettingCodePop:_closeByAnim()
	self:uniqueStyleOutTrans(handler(self, self._close))
end

function UserSettingCodePop:_close()
	g.core.module.ModuleManager:popComponent()
end

function UserSettingCodePop:_customPopOutTrans()
	self:uniqueStyleOutTrans(function()
		g.core.module.ModuleManager:popComponent()
	end)
end

function UserSettingCodePop:uniqueStyleOutTrans(arg_14_1)
	self._backTrans:play(arg_14_1)
end

function UserSettingCodePop:_onRecvCodeRewards()
	g.core.module.ModuleManager:tip(g.core.lang:get(1099))
	self:_closeByAnim()
end

return UserSettingCodePop
