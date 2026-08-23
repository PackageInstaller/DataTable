local LangDownMgr = require("app.view.module.multilingual.control.LangDownMgr")
local MultilingualMgr = require("app.core.lang.MultilingualMgr")
local UpgradeOut = require("upgrade.UpgradeOut")
local LangConst = require("app.view.module.multilingual.model.LangConst")
local LoginLanguagePop = class("LoginLanguagePop", require("app.fairyGUI.login.UI_LoginLanguagePop"), function()
	return fgui.GComponent:create({
		resName = "LoginLanguagePop",
		pkgPath = "ui/login/login",
		pkgName = "login"
	})
end)

function LoginLanguagePop:ctor(arg_2_1)
	self:showAtCenter()

	local var_2_0 = MultilingualMgr:getUseLang()

	self:initLoginLanguage()
end

function LoginLanguagePop:onLoad()
	self:_initRegisterMSG()

	if device.isWindowsDebug() then
		local var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs((MultilingualMgr:getMultiLangs())) do
			var_3_0[iter_3_1] = {}
		end

		LangDownMgr:parseAllLangInfo(var_3_0)
		self:_initLangList()
	elseif LangDownMgr:getAllLangUnit() == nil then
		self:_fetchLangTotalInfo()
	else
		self:_initLangList()
	end
end

function LoginLanguagePop:onUnload()
	g.core.network.GameHttpProxy:removeHttpResponse(self)
end

function LoginLanguagePop:receiveCompEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "UI_REBEL_" then
		-- block empty
	end
end

function LoginLanguagePop:initLoginLanguage()
	self:_initLoginLanguageData()
	self:_initLoginLanguageUI()
end

function LoginLanguagePop:_initLoginLanguageData()
	return
end

function LoginLanguagePop:_initLoginLanguageUI()
	self.m_languageList:setIniter()
	self.m_languageList:setItemRenderer(handler(self, self._renderListItem))
	self.m_languageList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onItemSelected))
	self.m_loadingtext:setVisible(true)
	self.m_languageList:setNumItems(0)
end

function LoginLanguagePop:_initRegisterMSG()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MULTI_LANG_PROCESS, self._onUIMsgLangItemChange, self)
end

function LoginLanguagePop:_initLangList()
	local var_10_0 = 0
	local var_10_1 = LangDownMgr:getAllLangUnit()

	if var_10_1 ~= nil then
		var_10_0 = #var_10_1
	end

	self.m_languageList:setNumItems(var_10_0)
	self.m_loadingtext:setVisible(var_10_0 == 0)
end

function LoginLanguagePop:_renderListItem(arg_11_1, arg_11_2)
	local var_11_0 = LangDownMgr:getAllLangUnit()

	if var_11_0 ~= nil then
		arg_11_2:updateLangInfo(var_11_0[arg_11_1 + 1])
	end
end

function LoginLanguagePop:_onItemSelected(arg_12_1)
	local var_12_0 = arg_12_1:getDataValue() + 1
	local var_12_1 = LangDownMgr:getAllLangUnit()[var_12_0]
	local var_12_2 = var_12_1:getUsingCtrl()

	if var_12_2 == LangConst.EN_USE_CTRL.NONE or var_12_2 == LangConst.EN_USE_CTRL.GOON then
		self:_checkDownLang(var_12_0)
	elseif var_12_2 == LangConst.EN_USE_CTRL.UNUSE then
		local var_12_3 = var_12_1.langName
		local var_12_4 = self

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(100039),
			desc = g.core.lang:get(101554),
			onConfirm = function()
				var_12_4:_switchUseLang(var_12_3)
			end
		}))
	elseif var_12_2 == LangConst.EN_USE_CTRL.STOP then
		self:_prepareStopDown()
	elseif var_12_2 == LangConst.EN_USE_CTRL.USEED then
		-- block empty
	end
end

function LoginLanguagePop:_onUIMsgLangItemChange(arg_14_1, arg_14_2)
	local var_14_0 = self.m_languageList:getChildAt(arg_14_2 - 1)

	if var_14_0 ~= nil then
		var_14_0:updateLangInfo(LangDownMgr:getAllLangUnit()[arg_14_2])
	end
end

function LoginLanguagePop:_fetchLangTotalInfo()
	local var_15_0 = config.LANGMULTI_URL_TEST

	if config.PATCH_URL_ENABLED then
		var_15_0 = device.isIOS() and UpgradeOut.MLANG_TOTAL_URL_I or UpgradeOut.MLANG_TOTAL_URL_A
	end

	if not var_15_0 then
		if not g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] or not g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].MLANG_TOTAL_URL then
			::label_15_0::

			var_15_0 = UpgradeOut.MLANG_TOTAL_JP
		end
	end

	g.core.network.GameHttpProxy:sendHttpRequest(var_15_0 .. "?t=" .. os.time(), "GET", {
		success = handler(self, self._handleFetchLangTotalOK),
		fail = handler(self, self._handleFetchLangTotalErr),
		cancel = handler(self, self._handleFetchLangTotalErr)
	}, self)
end

function LoginLanguagePop:_handleFetchLangTotalOK(arg_16_1)
	local var_16_0 = json.decode(arg_16_1)

	if var_16_0 ~= nil then
		LangDownMgr:parseAllLangInfo(var_16_0)
	end

	self:_initLangList()
end

function LoginLanguagePop:_handleFetchLangTotalErr(arg_17_1, arg_17_2)
	self:_fetchLangTotalInfo()
end

function LoginLanguagePop:_checkDownLang(arg_18_1)
	local var_18_0

	if LangDownMgr:isDownloading() then
		var_18_0 = g.core.lang:get(101504)
	elseif not g.core.platform.PlatformProxy:isWIFIState() and not config.PCSDK_ENABLED then
		var_18_0 = g.core.lang:get(101505)
	end

	if var_18_0 == nil then
		LangDownMgr:switchToDownLang(arg_18_1)
	else
		local var_18_1 = require("app.view.base.component.BaseAssistPopComp").new

		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
			text = var_18_0,
			text_ok = g.core.lang:get(101506),
			text_cancel = g.core.lang:get(101507),
			handler_ok = function()
				LangDownMgr:switchToDownLang(arg_18_1)
			end,
			handler_cancel = function()
				return
			end
		}), {
			ignoreTouch = true
		})
	end
end

function LoginLanguagePop:_switchUseLang(arg_21_1)
	if arg_21_1 == nil or arg_21_1 == MultilingualMgr:getUseLang() then
		return
	end

	MultilingualMgr:setUseLang(arg_21_1)
	device.restartGame()
end

function LoginLanguagePop:_prepareStopDown()
	LangDownMgr:switchToDownLang()
end

return LoginLanguagePop
