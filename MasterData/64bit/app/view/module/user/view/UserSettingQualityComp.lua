local LangDownMgr = require("app.view.module.multilingual.control.LangDownMgr")
local MultilingualMgr = require("app.core.lang.MultilingualMgr")
local UpgradeOut = require("upgrade.UpgradeOut")
local LangConst = require("app.view.module.multilingual.model.LangConst")
local UserSettingQualityComp = class("UserSettingQualityComp", require("app.fairyGUI.user.UI_UserSettingQualityComp"))

function UserSettingQualityComp:ctor()
	self:_reset()
	self:_addListeners()

	local var_1_0 = MultilingualMgr:getUseLang()
end

function UserSettingQualityComp:_resetOther()
	self._syncInfo = false
	self._qualityIdx = -1
	self._languageInfos = {}
	self._usingLanguageItem = nil
end

function UserSettingQualityComp:_resetUI()
	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.TW or g.core.platform.PlatformProxy:isChannelOfChina() then
		self.m_hideLangController:setSelectedIndex(1)
		self.m_languageGroup:setVisible(false)
	else
		self.m_hideLangController:setSelectedIndex(0)
		self.m_loadingtext:setVisible(true)
	end

	self.m_languageList:setNumItems(0)
end

function UserSettingQualityComp:_reset()
	self:_resetUI()
	self:_resetOther()
end

function UserSettingQualityComp:_addListeners()
	self.m_languageList:setVirtual()
	self.m_languageList:setItemRenderer(handler(self, self._renderListItem))
	self.m_languageList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onItemSelected))
	self.m_btnLow:addClickListener(handler(self, self._onQualityBtnClicked))
	self.m_btnMid:addClickListener(handler(self, self._onQualityBtnClicked))
	self.m_btnHigh:addClickListener(handler(self, self._onQualityBtnClicked))
	self.m_btnFPSLow:addClickListener(handler(self, self._onFPSBtnClicked))
	self.m_btnFPSHigh:addClickListener(handler(self, self._onFPSBtnClicked))
	self.m_btnFirstSkipCG:addClickListener(handler(self, self._onSkipCGBtnClicked))
	self.m_btnSkipCG:addClickListener(handler(self, self._onSkipCGBtnClicked))
	self.m_btnCG:addClickListener(handler(self, self._onSkipCGBtnClicked))
	self.m_btnFirstSkipTween:addClickListener(handler(self, self._onSkipTweenBtnClicked))
	self.m_btnSkipTween:addClickListener(handler(self, self._onSkipTweenBtnClicked))
	self.m_btnTween:addClickListener(handler(self, self._onSkipTweenBtnClicked))
	self.m_inviteSwitchBtn:addClickListener(handler(self, self._onInviteBioTeamBtnClicked))
	self.m_viewSwitchBtn:addClickListener(handler(self, self._onViewPlayerBtnClicked))
	self.m_btnFirstSkipSpShow:addClickListener(handler(self, self._onSkipSpShowBtnClicked))
	self.m_btnSkipSpShow:addClickListener(handler(self, self._onSkipSpShowBtnClicked))
	self.m_btnSpShow:addClickListener(handler(self, self._onSkipSpShowBtnClicked))
	self.m_btnFirstSkipSuccubaShow:addClickListener(handler(self, self._onSkipSuccubaShowBtnClicked))
	self.m_btnSkipSuccubaShow:addClickListener(handler(self, self._onSkipSuccubaShowBtnClicked))
	self.m_btnSuccubaShow:addClickListener(handler(self, self._onSkipSuccubaShowBtnClicked))
	self.m_btnFirstSkipSpSkill:addClickListener(handler(self, self._onSkipSpSkillBtnClicked))
	self.m_btnSkipSpSkill:addClickListener(handler(self, self._onSkipSpSkillBtnClicked))
	self.m_btnSpSkill:addClickListener(handler(self, self._onSkipSpSkillBtnClicked))
end

function UserSettingQualityComp:_addCustomListeners()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MULTI_LANG_PROCESS, self._onUIMsgLangItemChange, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SET_USER_CONFIG, self._switchUseLang, self)
end

function UserSettingQualityComp:onLoad()
	self:_onSynchronizeAndSetUI()
	self:_addCustomListeners()

	if device.isWindowsDebug() then
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs((MultilingualMgr:getMultiLangs())) do
			var_7_0[iter_7_1] = {}
		end

		LangDownMgr:parseAllLangInfo(var_7_0)
		self:_initLangList()
	elseif LangDownMgr:getAllLangUnit() == nil then
		self:_fetchLangTotalInfo()
	else
		self:_initLangList()
	end

	self.m_enterTransition:play()
end

function UserSettingQualityComp:onUnload()
	g.core.network.GameHttpProxy:removeHttpResponse(self)
end

function UserSettingQualityComp:onShow()
	self:setVisible(true)
end

function UserSettingQualityComp:onHide()
	self:setVisible(false)
end

function UserSettingQualityComp:playBackAction()
	self.m_backTransition:play()
end

function UserSettingQualityComp:_onSynchronizeAndSetUI()
	if self._syncInfo then
		return
	end

	local var_12_0 = g.core.common.Setting:getQualityConfig()

	self._qualityIdx = var_12_0

	if var_12_0 == 0 then
		self:_onQualityBtnSelected(self.m_btnLow)
	elseif var_12_0 == 1 then
		self:_onQualityBtnSelected(self.m_btnMid)
	elseif var_12_0 == 2 then
		self:_onQualityBtnSelected(self.m_btnHigh)
	end

	local var_12_1 = g.core.common.Setting:getValue(g.core.common.Setting.FUNC_FPS) or 0

	self._fpsIdx = var_12_1

	if var_12_1 == 0 then
		self:_onFPSBtnSelected(self.m_btnFPSLow, true)
	elseif var_12_1 == 1 then
		self:_onFPSBtnSelected(self.m_btnFPSHigh, true)
	end

	local var_12_2 = g.core.common.Setting:getValue(g.core.common.Setting.SKIP_CG) or 0

	self._skipCGIdx = var_12_2

	if var_12_2 == 0 then
		self:_onSkipCGBtnSelected(self.m_btnFirstSkipCG)
	elseif var_12_2 == 1 then
		self:_onSkipCGBtnSelected(self.m_btnSkipCG)
	elseif var_12_2 == 2 then
		self:_onSkipCGBtnSelected(self.m_btnCG)
	end

	local var_12_3 = g.core.common.Setting:getValue(g.core.common.Setting.SKIP_TWEEN) or 0

	self._skipTweenIdx = var_12_3

	if var_12_3 == 0 then
		self:_onSkipTweenBtnSelected(self.m_btnFirstSkipTween)
	elseif var_12_3 == 1 then
		self:_onSkipTweenBtnSelected(self.m_btnSkipTween)
	elseif var_12_3 == 2 then
		self:_onSkipTweenBtnSelected(self.m_btnTween)
	end

	local var_12_4 = g.core.model.User.UserTitleData:getSpecialShowActionIsHide()

	if var_12_4 == 0 then
		self:_onSkipSpShowBtnSelected(self.m_btnFirstSkipSpShow)
	elseif var_12_4 == 1 then
		self:_onSkipSpShowBtnSelected(self.m_btnSkipSpShow)
	elseif var_12_4 == 2 then
		self:_onSkipSpShowBtnSelected(self.m_btnSpShow)
	end

	self.m_inviteGroup:setVisible(g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SKIP_SP_ACTION) and true or false)

	local var_12_5 = g.core.model.User.UserTitleData:getSpecialSkillIsHide()

	if var_12_5 == 0 then
		self:_onSkipSpSkillBtnSelected(self.m_btnFirstSkipSpSkill)
	elseif var_12_5 == 1 then
		self:_onSkipSpSkillBtnSelected(self.m_btnSkipSpSkill)
	elseif var_12_5 == 2 then
		self:_onSkipSpSkillBtnSelected(self.m_btnSpSkill)
	end

	self.m_spShowGroup:setVisible(g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SKIP_SP_SKILL) and true or false)

	local var_12_6 = g.core.model.User.UserTitleData:getSuccubaSkillIsHide()

	if var_12_6 == 0 then
		self:_onSkipSuccubaShowBtnSelected(self.m_btnFirstSkipSuccubaShow)
	elseif var_12_6 == 1 then
		self:_onSkipSuccubaShowBtnSelected(self.m_btnSkipSuccubaShow)
	elseif var_12_6 == 2 then
		self:_onSkipSuccubaShowBtnSelected(self.m_btnSuccubaShow)
	end

	self.m_succubaShowGroup:setVisible(g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SKIP_SUCCUBA_ACTION) and true or false)

	if g.core.common.Setting:getValue(g.core.common.Setting.JUMP_CG) then
		local var_12_7 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.JUMP_CG)
	end

	if g.core.common.Setting:getValue(g.core.common.Setting.JUMP_SKILL_ENTRANCE) then
		local var_12_8 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.JUMP_SKILL_ENTRANCE)
	end

	self._syncInfo = true

	local var_12_9 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BIO_TEAM)

	self.m_supperSkillGroup:setVisible(var_12_9 and true or false)

	if var_12_9 then
		if g.core.common.Setting:getValue(g.core.common.Setting.ACCEPT_BIO_TEAM_INVITE) ~= false then
			self.m_inviteSwitchBtn:setSelected(true)
		else
			self.m_inviteSwitchBtn:setSelected(false)
		end
	end

	self:updateViewPlayerBtnStatus()
end

function UserSettingQualityComp:_onQualityBtnClicked(arg_13_1)
	self:_onQualityBtnSelected((arg_13_1:getSender()))
end

function UserSettingQualityComp:_onFPSBtnClicked(arg_14_1)
	self:_onFPSBtnSelected((arg_14_1:getSender()))
end

function UserSettingQualityComp:_onFPSBtnSelected(arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1:getName()
	local var_15_1 = 0

	if var_15_0 == "btnFPSLow" then
		if self._lastFPSyBtn then
			self._lastFPSyBtn:setSelected(false)
		end

		var_15_1 = 0

		cc.Director:getInstance():setAnimationInterval(0.03333333333333333)
		arg_15_1:setSelected(true)

		self._lastFPSyBtn = arg_15_1

		if self._fpsIdx ~= var_15_1 and self._syncInfo then
			g.core.common.Setting:set(g.core.common.Setting.FUNC_FPS, var_15_1)
			g.core.module.ModuleManager:tip(g.core.lang:get(410100))

			self._fpsIdx = var_15_1
		end
	elseif var_15_0 == "btnFPSHigh" then
		if not arg_15_2 and g.core.utils.Sdk.isLowGradeDevice() then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(111026),
				desc = g.core.lang:get(410101),
				onCancel = handler(self, function()
					arg_15_1:setSelected(false)
				end),
				onConfirm = handler(self, function(arg_17_0)
					if arg_17_0._lastFPSyBtn then
						arg_17_0._lastFPSyBtn:setSelected(false)
					end

					var_15_1 = 1

					cc.Director:getInstance():setAnimationInterval(0.016666666666666666)
					arg_15_1:setSelected(true)

					arg_17_0._lastFPSyBtn = arg_15_1

					if arg_17_0._fpsIdx ~= var_15_1 and arg_17_0._syncInfo then
						g.core.common.Setting:set(g.core.common.Setting.FUNC_FPS, var_15_1)
						g.core.module.ModuleManager:tip(g.core.lang:get(410100))

						arg_17_0._fpsIdx = var_15_1
					end
				end)
			}))
		else
			if self._lastFPSyBtn then
				self._lastFPSyBtn:setSelected(false)
			end

			var_15_1 = 1

			cc.Director:getInstance():setAnimationInterval(0.016666666666666666)
			arg_15_1:setSelected(true)

			self._lastFPSyBtn = arg_15_1

			if self._fpsIdx ~= var_15_1 and self._syncInfo then
				g.core.common.Setting:set(g.core.common.Setting.FUNC_FPS, var_15_1)
				g.core.module.ModuleManager:tip(g.core.lang:get(410100))

				self._fpsIdx = var_15_1
			end
		end
	end
end

function UserSettingQualityComp:_onQualityBtnSelected(arg_18_1)
	local var_18_0 = arg_18_1:getName()

	if self._lastQualityBtn then
		self._lastQualityBtn:setSelected(false)
	end

	local var_18_1 = 0

	if var_18_0 == "btnLow" then
		var_18_1 = 0
	elseif var_18_0 == "btnMid" then
		var_18_1 = 1
	elseif var_18_0 == "btnHigh" then
		var_18_1 = 2
	end

	arg_18_1:setSelected(true)

	self._lastQualityBtn = arg_18_1

	if self._qualityIdx ~= var_18_1 and self._syncInfo then
		g.core.common.Setting:setQualityLevel(var_18_1)
		g.core.module.ModuleManager:tip(g.core.lang:get(1192))
		g.core.utils.Sdk.changeDevicePerformance()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHANGE_DEVICE_PERFORMANCE, false, var_18_1)

		self._qualityIdx = var_18_1
	end
end

function UserSettingQualityComp:_onSkipCGBtnClicked(arg_19_1)
	local var_19_0 = arg_19_1:getSender()

	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.JUMP_CG) then
		local var_19_1 = var_19_0:getName()
		local var_19_2 = 0

		if var_19_1 == "btnFirstSkipCG" then
			var_19_2 = 0
		elseif var_19_1 == "btnSkipCG" then
			var_19_2 = 1
		elseif var_19_1 == "btnCG" then
			var_19_2 = 2
		end

		if self._skipCGIdx ~= var_19_2 then
			var_19_0:setSelected(false)
		end

		return
	end

	self:_onSkipCGBtnSelected(var_19_0)
end

function UserSettingQualityComp:_onSkipCGBtnSelected(arg_20_1)
	local var_20_0 = arg_20_1:getName()

	if self._lastCGBtn then
		self._lastCGBtn:setSelected(false)
	end

	local var_20_1 = 0

	if var_20_0 == "btnFirstSkipCG" then
		var_20_1 = 0
	elseif var_20_0 == "btnSkipCG" then
		var_20_1 = 1
	elseif var_20_0 == "btnCG" then
		var_20_1 = 2
	end

	arg_20_1:setSelected(true)

	self._lastCGBtn = arg_20_1

	if self._skipCGIdx ~= var_20_1 and self._syncInfo then
		g.core.common.Setting:set(g.core.common.Setting.SKIP_CG, var_20_1)
		g.core.module.ModuleManager:tip(g.core.lang:get(100529))

		self._skipCGIdx = var_20_1
	end
end

function UserSettingQualityComp:_onSkipTweenBtnClicked(arg_21_1)
	local var_21_0 = arg_21_1:getSender()

	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.JUMP_SKILL_ENTRANCE) then
		local var_21_1 = var_21_0:getName()
		local var_21_2 = 0

		if var_21_1 == "btnFirstSkipTween" then
			var_21_2 = 0
		elseif var_21_1 == "btnSkipTween" then
			var_21_2 = 1
		elseif var_21_1 == "btnTween" then
			var_21_2 = 2
		end

		if self._skipTweenIdx ~= var_21_2 then
			var_21_0:setSelected(false)
		end

		return
	end

	self:_onSkipTweenBtnSelected(var_21_0)
end

function UserSettingQualityComp:_onSkipTweenBtnSelected(arg_22_1)
	local var_22_0 = arg_22_1:getName()

	if self._lastTweenBtn then
		self._lastTweenBtn:setSelected(false)
	end

	local var_22_1 = 0

	if var_22_0 == "btnFirstSkipTween" then
		var_22_1 = 0
	elseif var_22_0 == "btnSkipTween" then
		var_22_1 = 1
	elseif var_22_0 == "btnTween" then
		var_22_1 = 2
	end

	arg_22_1:setSelected(true)

	self._lastTweenBtn = arg_22_1

	if self._skipTweenIdx ~= var_22_1 and self._syncInfo then
		g.core.common.Setting:set(g.core.common.Setting.SKIP_TWEEN, var_22_1)
		g.core.module.ModuleManager:tip(g.core.lang:get(100529))

		self._skipTweenIdx = var_22_1
	end
end

function UserSettingQualityComp:_onCGBtnClicked()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.JUMP_CG) then
		self.m_cgSwitchBtn:setSelected(false)

		return
	end

	if not self.m_cgSwitchBtn:isSelected() then
		g.core.common.Setting:set(g.core.common.Setting.JUMP_CG, false)
	else
		g.core.common.Setting:set(g.core.common.Setting.JUMP_CG, true)
	end
end

function UserSettingQualityComp:_onSkillEntranceBtnClicked()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.JUMP_SKILL_ENTRANCE) then
		self.m_entranceSwitchBtn:setSelected(false)

		return
	end

	if not self.m_entranceSwitchBtn:isSelected() then
		g.core.common.Setting:set(g.core.common.Setting.JUMP_SKILL_ENTRANCE, false)
	else
		g.core.common.Setting:set(g.core.common.Setting.JUMP_SKILL_ENTRANCE, true)
	end
end

function UserSettingQualityComp:_initLangList()
	local var_25_0 = 0
	local var_25_1 = LangDownMgr:getAllLangUnit()

	if var_25_1 ~= nil then
		var_25_0 = #var_25_1
	end

	self.m_languageList:setNumItems(var_25_0)
	self.m_languageList:resizeToFit(var_25_0)

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.TW then
		self.m_loadingtext:setVisible(false)
	else
		self.m_loadingtext:setVisible(var_25_0 == 0)
	end
end

function UserSettingQualityComp:_renderListItem(arg_26_1, arg_26_2)
	local var_26_0 = LangDownMgr:getAllLangUnit()

	if var_26_0 ~= nil then
		arg_26_2:updateLangInfo(var_26_0[arg_26_1 + 1])
	end
end

function UserSettingQualityComp:_onItemSelected(arg_27_1)
	local var_27_0 = arg_27_1:getDataValue() + 1
	local var_27_1 = LangDownMgr:getAllLangUnit()[var_27_0]
	local var_27_2 = var_27_1:getUsingCtrl()

	if var_27_2 == LangConst.EN_USE_CTRL.NONE or var_27_2 == LangConst.EN_USE_CTRL.GOON then
		self:_checkDownLang(var_27_0)
	elseif var_27_2 == LangConst.EN_USE_CTRL.UNUSE then
		local var_27_3 = var_27_1.langName

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(100039),
			desc = g.core.lang:get(101554),
			onConfirm = function()
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CUSTOM_LOGOUT)
				g.core.network.GameNetProxy:send_C2S_SetUserConfig({
					tp = 2,
					config = {
						chat = {},
						language = MultilingualMgr:getLangIdByDesc(var_27_3)
					}
				})
			end
		}))
	elseif var_27_2 == LangConst.EN_USE_CTRL.STOP then
		self:_prepareStopDown()
	elseif var_27_2 == LangConst.EN_USE_CTRL.USEED then
		-- block empty
	end
end

function UserSettingQualityComp:_onUIMsgLangItemChange(arg_29_1, arg_29_2)
	local var_29_0 = self.m_languageList:getChildAt(arg_29_2 - 1)

	if var_29_0 ~= nil then
		var_29_0:updateLangInfo(LangDownMgr:getAllLangUnit()[arg_29_2])
	end
end

function UserSettingQualityComp:_fetchLangTotalInfo()
	local var_30_0 = config.LANGMULTI_URL_TEST

	if config.PATCH_URL_ENABLED then
		var_30_0 = device.isIOS() and UpgradeOut.MLANG_TOTAL_URL_I or UpgradeOut.MLANG_TOTAL_URL_A
	end

	if not var_30_0 then
		if not g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] or not g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].MLANG_TOTAL_URL then
			::label_30_0::

			var_30_0 = UpgradeOut.MLANG_TOTAL_JP
		end
	end

	g.core.network.GameHttpProxy:sendHttpRequest(var_30_0 .. "?t=" .. os.time(), "GET", {
		success = handler(self, self._handleFetchLangTotalOK),
		fail = handler(self, self._handleFetchLangTotalErr),
		cancel = handler(self, self._handleFetchLangTotalErr)
	}, self)
end

function UserSettingQualityComp:_handleFetchLangTotalOK(arg_31_1)
	local var_31_0 = json.decode(arg_31_1)

	if var_31_0 ~= nil then
		LangDownMgr:parseAllLangInfo(var_31_0)
	end

	self:_initLangList()
end

function UserSettingQualityComp:_handleFetchLangTotalErr(arg_32_1, arg_32_2)
	self:_fetchLangTotalInfo()
end

function UserSettingQualityComp:_checkDownLang(arg_33_1)
	local var_33_0

	if LangDownMgr:isDownloading() then
		var_33_0 = g.core.lang:get(101504)
	elseif not g.core.platform.PlatformProxy:isWIFIState() and not config.PCSDK_ENABLED then
		var_33_0 = g.core.lang:get(101505)
	end

	if var_33_0 == nil then
		LangDownMgr:switchToDownLang(arg_33_1)
	else
		local var_33_1 = require("app.view.base.component.BaseAssistPopComp").new

		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
			text = var_33_0,
			text_ok = g.core.lang:get(101506),
			text_cancel = g.core.lang:get(101507),
			handler_ok = function()
				LangDownMgr:switchToDownLang(arg_33_1)
			end,
			handler_cancel = function()
				return
			end
		}), {
			ignoreTouch = true
		})
	end
end

function UserSettingQualityComp:_switchUseLang(arg_36_1, arg_36_2, arg_36_3)
	self:updateViewPlayerBtnStatus()

	local var_36_0 = arg_36_3.config and arg_36_3.config.language

	if var_36_0 == nil then
		return
	end

	local var_36_1 = MultilingualMgr:getLangDescById(var_36_0)

	if var_36_1 == nil or var_36_1 == MultilingualMgr:getUseLang() then
		return
	end

	MultilingualMgr:setUseLang(var_36_1)
	self.m_languageList:refreshVirtualList()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GAME_RESTART)
end

function UserSettingQualityComp:_prepareStopDown()
	LangDownMgr:switchToDownLang()
end

function UserSettingQualityComp:_onInviteBioTeamBtnClicked()
	if not self.m_inviteSwitchBtn:isSelected() then
		g.core.common.Setting:set(g.core.common.Setting.ACCEPT_BIO_TEAM_INVITE, false)
	else
		g.core.common.Setting:set(g.core.common.Setting.ACCEPT_BIO_TEAM_INVITE, true)
	end
end

function UserSettingQualityComp:updateViewPlayerBtnStatus()
	self.m_viewSwitchBtn:setSelected((g.core.common.Setting:getViewPlayerOpen()))
end

function UserSettingQualityComp:_onViewPlayerBtnClicked()
	if not self.m_viewSwitchBtn:isSelected() then
		g.core.network.GameNetProxy:send_C2S_SetUserConfig({
			tp = 3,
			config = {
				detail_view_notify = 1
			}
		})
	else
		g.core.network.GameNetProxy:send_C2S_SetUserConfig({
			tp = 3,
			config = {
				detail_view_notify = 0
			}
		})
	end
end

function UserSettingQualityComp:_onSkipSpShowBtnClicked(arg_41_1)
	local var_41_0 = arg_41_1:getSender()

	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.SKIP_SP_ACTION) then
		local var_41_1 = var_41_0:getName()
		local var_41_2 = 0

		if var_41_1 == "btnFirstSkipSpShow" then
			var_41_2 = 0
		elseif var_41_1 == "btnSkipSpShow" then
			var_41_2 = 1
		elseif var_41_1 == "btnSpShow" then
			var_41_2 = 2
		end

		if self._skipSpShowIdx ~= var_41_2 then
			var_41_0:setSelected(false)
		end

		return
	end

	self:_onSkipSpShowBtnSelected(var_41_0)
end

function UserSettingQualityComp:_onSkipSuccubaShowBtnClicked(arg_42_1)
	local var_42_0 = arg_42_1:getSender()

	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.SKIP_SUCCUBA_ACTION) then
		local var_42_1 = var_42_0:getName()
		local var_42_2 = 0

		if var_42_1 == "btnFirstSkipSuccubaShow" then
			var_42_2 = 0
		elseif var_42_1 == "btnSkipSuccubaShow" then
			var_42_2 = 1
		elseif var_42_1 == "btnSuccubaShow" then
			var_42_2 = 2
		end

		if self._skipSuccubaShowIdx ~= var_42_2 then
			var_42_0:setSelected(false)
		end

		return
	end

	self:_onSkipSuccubaShowBtnSelected(var_42_0)
end

function UserSettingQualityComp:_onSkipSuccubaShowBtnSelected(arg_43_1)
	local var_43_0 = arg_43_1:getName()

	if self._lastSuccubaShowBtn then
		self._lastSuccubaShowBtn:setSelected(false)
	end

	local var_43_1 = 0

	if var_43_0 == "btnFirstSkipSuccubaShow" then
		var_43_1 = 0
	elseif var_43_0 == "btnSkipSuccubaShow" then
		var_43_1 = 1
	elseif var_43_0 == "btnSuccubaShow" then
		var_43_1 = 2
	end

	arg_43_1:setSelected(true)

	self._lastSuccubaShowBtn = arg_43_1

	if self._skipSuccubaShowIdx ~= var_43_1 and self._syncInfo then
		g.core.model.User.UserTitleData:setSuccubaShowActionIsHide(var_43_1)
		g.core.module.ModuleManager:tip(g.core.lang:get(100529))

		self._skipSuccubaShowIdx = var_43_1
	end
end

function UserSettingQualityComp:_onSkipSpShowBtnSelected(arg_44_1)
	local var_44_0 = arg_44_1:getName()

	if self._lastSpShowBtn then
		self._lastSpShowBtn:setSelected(false)
	end

	local var_44_1 = 0

	if var_44_0 == "btnFirstSkipSpShow" then
		var_44_1 = 0
	elseif var_44_0 == "btnSkipSpShow" then
		var_44_1 = 1
	elseif var_44_0 == "btnSpShow" then
		var_44_1 = 2
	end

	arg_44_1:setSelected(true)

	self._lastSpShowBtn = arg_44_1

	if self._skipSpShowIdx ~= var_44_1 and self._syncInfo then
		g.core.model.User.UserTitleData:setSpecialShowActionIsHide(var_44_1)
		g.core.module.ModuleManager:tip(g.core.lang:get(100529))

		self._skipSpShowIdx = var_44_1
	end
end

function UserSettingQualityComp:_onSkipSpSkillBtnClicked(arg_45_1)
	local var_45_0 = arg_45_1:getSender()

	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.SKIP_SP_ACTION) then
		local var_45_1 = var_45_0:getName()
		local var_45_2 = 0

		if var_45_1 == "btnFirstSkipSpSkill" then
			var_45_2 = 0
		elseif var_45_1 == "btnSkipSpSkill" then
			var_45_2 = 1
		elseif var_45_1 == "btnSpSkill" then
			var_45_2 = 2
		end

		if self._skipSpSkillIdx ~= var_45_2 then
			var_45_0:setSelected(false)
		end

		return
	end

	self:_onSkipSpSkillBtnSelected(var_45_0)
end

function UserSettingQualityComp:_onSkipSpSkillBtnSelected(arg_46_1)
	local var_46_0 = arg_46_1:getName()

	if self._lastSpSkillBtn then
		self._lastSpSkillBtn:setSelected(false)
	end

	local var_46_1 = 0

	if var_46_0 == "btnFirstSkipSpSkill" then
		var_46_1 = 0
	elseif var_46_0 == "btnSkipSpSkill" then
		var_46_1 = 1
	elseif var_46_0 == "btnSpSkill" then
		var_46_1 = 2
	end

	arg_46_1:setSelected(true)

	self._lastSpSkillBtn = arg_46_1

	if self._skipSpSkillIdx ~= var_46_1 and self._syncInfo then
		g.core.model.User.UserTitleData:setSpecialSkillIsHide(var_46_1)
		g.core.module.ModuleManager:tip(g.core.lang:get(100529))

		self._skipSpSkillIdx = var_46_1
	end
end

return UserSettingQualityComp
