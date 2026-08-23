local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local HomeModuleBtnCfg = require("app.view.module.home.const.HomeModuleBtnCfg")
local HomeSettingComp = class("HomeSettingComp", require("app.fairyGUI.home.UI_HomeSettingComp"))

function HomeSettingComp:ctor()
	self:_initBtn()
end

function HomeSettingComp:_initBtn()
	local var_2_0 = {
		[var_0_0.GUIDE_TASK] = self.m_guideBtn,
		[var_0_0.ACTIVITY_SIGNIN] = self.m_signInBtn,
		[var_0_0.ANNOUNCE] = self.m_announceBtn,
		[var_0_0.REBORN] = self.m_rebornBtn,
		[var_0_0.FRIEND] = self.m_friendBtn,
		[var_0_0.MAIL] = self.m_mailBtn,
		[var_0_0.DAILY_REPORT] = self.m_dailyReportBtn,
		[var_0_0.BIRTHDAY_CARD] = self.m_birthdayCardBtn,
		[var_0_0.TAP_TAP] = self.m_taptapBtn,
		[var_0_0.SUMMON_OLD_PLAYER] = self.m_summonPlayerBtn,
		[var_0_0.PACKAGE_DOWNLOAD] = self.m_downloadBtn,
		[var_0_0.VIP_LINK] = self.m_vipLinkBtn
	}

	for iter_2_0, iter_2_1 in pairs(HomeModuleBtnCfg.SETTING_BTN_CFG) do
		if var_2_0[iter_2_0] then
			fgui.UIPackage.bindUIComponent(var_2_0[iter_2_0], "app.view.module.home.view.comp.HomeModuleBtn", self)
			var_2_0[iter_2_0]:updateBtnCfg(iter_2_1)
		end
	end

	self.m_effVipLink:removeAllEffect()
	self.m_effVipLink:addEffectSpine({
		isLoop = true,
		name = "eff_ui_VipLink_homeicon"
	})
end

function HomeSettingComp:onLoad()
	local var_3_0 = g.core.event

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SIGN_IN_SIGN, self._onSignAwardRec, self)
	var_3_0.EventManager:addEventListener(var_3_0.enum.EVENT_VIP_LINK_OPEN, self._onVipLinkRec, self)
	var_3_0.EventManager:addEventListener(var_3_0.enum.EVENT_NET_S2C_SIGN_IN_AWARD, self._onSignAwardRec, self)
	var_3_0.EventManager:addEventListener(var_3_0.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	var_3_0.EventManager:addEventListener(var_3_0.enum.EVENT_PACKAGE_LIST_DOWNLOAD_START, self._checkDownloadBtnVisible, self)
	var_3_0.EventManager:dispatchEvent(var_3_0.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_signRedPoint
	})
	var_3_0.EventManager:dispatchEvent(var_3_0.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_rebornRedPoint
	})
	var_3_0.EventManager:dispatchEvent(var_3_0.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_friendRedPoint
	})
	var_3_0.EventManager:dispatchEvent(var_3_0.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_mailRedPoint
	})
	var_3_0.EventManager:dispatchEvent(var_3_0.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_guideRedPoint
	})
	var_3_0.EventManager:dispatchEvent(var_3_0.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_birthdayCardRedPoint
	})
	var_3_0.EventManager:dispatchEvent(var_3_0.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_vipLinkRedPoint
	})

	if not g.core.common.ModuleUnlock:isModuleShow(var_0_0.GUIDE_TASK) or g.core.utils.Rule.isHideFuncGuide() then
		self.m_guideBtn:setVisible(false)
		self.m_guideRedPoint:setVisible(false)
		self.m_guideBtnGroup:setVisible(false)
	else
		self.m_guideBtn:setVisible(true)
		self.m_guideRedPoint:setVisible(true)
		self.m_guideBtnGroup:setVisible(true)
	end

	if g.core.common.ModuleUnlock:isModuleShow(var_0_0.DAILY_REPORT) and g.core.model.User.dailyReportData:isShowOpen() then
		self.m_dailyReportBtn:setVisible(true)
	else
		self.m_dailyReportBtn:setVisible(false)
	end

	if g.core.platform.PlatformProxy:getCurChannel().name == require("app.core.platform.const.ChannelConst").ChannelNames.TAPTAP then
		self.m_taptapBtn:setVisible(true)
	else
		self.m_taptapBtn:setVisible(false)
	end

	self.m_birthdayCardBtnGroup:setVisible((g.core.common.ModuleUnlock:isModuleShow(var_0_0.BIRTHDAY_CARD)))
	self.m_summonPlayerBtn:setVisible(g.core.model.User.summonOldPlayerData:isShowDoor())
	self.m_vipLinkGroup:setVisible(g.core.model.User.vipLinkData:isShouldOpen())
	self:newScheduleOnce(handler(self, self.checkSpeWeakGuide), 1)
	var_3_0.EventManager:dispatchEvent(var_3_0.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_birthdayCardRedPoint
	})
	self:_checkDownloadBtnVisible()
end

function HomeSettingComp:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function HomeSettingComp:_checkDownloadBtnVisible()
	self.m_downloadBtn:setVisible(g.core.model.User.splitDownloadData:isShowDownloadListPop())
end

function HomeSettingComp:_onSignAwardRec()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_signRedPoint
	})
end

function HomeSettingComp:_onVipLinkRec()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_vipLinkRedPoint
	})
end

function HomeSettingComp:_onCrossDayUpdate()
	self.m_birthdayCardBtnGroup:setVisible((g.core.common.ModuleUnlock:isModuleShow(var_0_0.BIRTHDAY_CARD)))
	self.m_summonPlayerBtn:setVisible(g.core.model.User.summonOldPlayerData:isShowDoor())
end

function HomeSettingComp:checkSpeWeakGuide()
	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.CROSS_FRIEND_1) and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CROSS_FRIEND) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "CROSS_FRIEND_STEP_1",
			targetBtn = self.m_friendBtn
		})
	end
end

return HomeSettingComp
