local BaseShareBtnComp = class("BaseShareBtnComp", require("app.fairyGUI.base_new.UI_BaseShareBtnComp"))

function BaseShareBtnComp:ctor()
	if self:_checkBtnForceHide() then
		self:setVisible(false)

		return
	end

	local var_1_0, var_1_1, var_1_2 = g.core.model.User.ShareData:getShareReward(1)

	self.m_resComp:updateByTVS({
		type = var_1_0,
		value = var_1_1,
		size = var_1_2
	})
	self.m_resComp1:updateByTVS({
		type = var_1_0,
		value = var_1_1,
		size = var_1_2
	})

	self._callBack = nil

	self.m_rewardGroup:setVisible(not config.PCSDK_ENABLED)
	self.m_rewardGroup1:setVisible(not config.PCSDK_ENABLED)
	self.m_shareBtn:addClickListener(handler(self, function()
		if self._callBack then
			self._callBack()
		end
	end))
	self:_updateState()
end

function BaseShareBtnComp:_checkBtnForceHide()
	local var_3_0 = g.core.platform.ServerListProxy:isTesting()

	if string.find(g.core.platform.PlatformProxy:getAndroidPackageName(), "^com%.yoozoo%.jgame%.adcn.*") then
		var_3_0 = true
	end

	if var_3_0 then
		-- block empty
	elseif g.core.platform.PlatformProxy:isChannelOfChina() then
		local ChannelConst = require("app.core.platform.const.ChannelConst")
		local var_3_2 = g.core.platform.PlatformProxy:getCurChannel()

		var_3_0 = not (var_3_2.sdkChanel and var_3_2.sdkChanel == ChannelConst.ChannelNames.YOOZOO and var_3_2.name ~= ChannelConst.ChannelNames.TAPTAP)
	elseif g.core.platform.PlatformProxy:isChannelOfEn() then
		var_3_0 = ({
			["2942"] = true,
			["2757"] = true,
			["2941"] = true,
			["3223"] = true
		})[tostring((g.core.platform.PlatformProxy:getOpId()))]
	end

	return var_3_0
end

function BaseShareBtnComp:setAutoFadeOut(arg_4_1)
	self._autoFade = arg_4_1

	if self._autoFade then
		self:newScheduleOnce(handler(self, self._playFadeOutAction), 3)
	end
end

function BaseShareBtnComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WE_CHAT_SHARE, handler(self, self._onRcvShareSuccess), self)

	if self._autoFade then
		self:newScheduleOnce(handler(self, self._playFadeOutAction), 3)
	end
end

function BaseShareBtnComp:setShowAwardState(arg_6_1)
	self._showState = arg_6_1

	self.m_show_awardController:setSelectedIndex(self._showState)
end

function BaseShareBtnComp:_updateState()
	local var_7_0 = g.core.model.User.ShareData:isShowShare()

	self:setVisible(var_7_0)

	if self._showState ~= nil then
		self.m_show_awardController:setSelectedIndex(self._showState)

		return
	end

	self.m_show_awardController:setSelectedIndex(0)

	if var_7_0 then
		self.m_show_awardController:setSelectedIndex(g.core.model.User.ShareData:getRewardIsReset(1) and 1 or 0)
	end
end

function BaseShareBtnComp:setVisibleEx(arg_8_1)
	if self:_checkBtnForceHide() then
		self:setVisible(false)

		return
	end

	self:setVisible(arg_8_1 and g.core.model.User.ShareData:isShowShare())
end

function BaseShareBtnComp:setCallback(arg_9_1)
	self._callBack = arg_9_1
end

function BaseShareBtnComp:_onRcvShareSuccess(arg_10_1, arg_10_2, arg_10_3)
	self:_updateState()
end

function BaseShareBtnComp:_playFadeOutAction()
	self.m_fadeOutTransition:play()
end

return BaseShareBtnComp
