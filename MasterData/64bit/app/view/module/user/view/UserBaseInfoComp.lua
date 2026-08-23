local MultilingualMgr = require("app.core.lang.MultilingualMgr")
local var_0_1 = g.core.platform.PlatformProxy
local var_0_2 = g.core.model.User.UserTitleData
local NativeCallUtils = require("app.core.platform.NativeCallUtils")
local UserBaseInfoComp = class("UserBaseInfoComp", require("app.fairyGUI.user.UI_UserBaseInfoComp"))

function UserBaseInfoComp:ctor()
	self._isFirstEnter = true
	self._menuInfos = {}

	self.m_serverIdText:disableAutoChange()
	self.m_versionText:disableAutoChange()
	self.m_menuList:setIniter()
	self.m_menuList:setItemRenderer(handler(self, self._onMenuItemRenderer))
	self.m_menuList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onMenuItemClick))
	self.m_copyServerIdBtn:addClickListener(handler(self, self._onCopyServerIdClick))
	self.m_copyRoleIdBtn:addClickListener(handler(self, self._onCopyRoleIdClick))
	self.m_copyCodeBtn:addClickListener(handler(self, self._onCopyCodeClick))
	self.m_roleIdText:disableAutoChange()
	self.m_codeText:disableAutoChange()

	self._serverId = nil
	self._roleId = nil
	self._redComps = {}
end

function UserBaseInfoComp:onLoad()
	self._menuInfos = var_0_2:getMenuData()

	self:_updateAllRed()
end

function UserBaseInfoComp:playHide()
	self:setVisible(false)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.TWITTER_BTN)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.DISCORD_BTN)
end

function UserBaseInfoComp:_onCopyServerIdClick()
	if self._serverId then
		g.core.platform.PlatformProxy:copyToClipboard(self._serverId)
		g.core.module.ModuleManager:tip(g.core.lang:get(2060))
	end
end

function UserBaseInfoComp:_onCopyRoleIdClick()
	if self._roleId then
		g.core.platform.PlatformProxy:copyToClipboard(self._roleId)
		g.core.module.ModuleManager:tip(g.core.lang:get(2060))
	end
end

function UserBaseInfoComp:_onCopyCodeClick()
	if self._roleId then
		g.core.platform.PlatformProxy:copyToClipboard(self._serverId .. ";" .. self._roleId)
		g.core.module.ModuleManager:tip(g.core.lang:get(2060))
	end
end

function UserBaseInfoComp:updateComp()
	self._menuInfos = var_0_2:getMenuData()

	local var_7_0 = g.core.platform.ServerListProxy:getSelectedServer()

	self.m_serverText:setText(var_7_0.name)
	self.m_serverIdText:setText((g.core.lang:get(101905) .. g.core.lang:get(101906, {
		serverId = var_7_0.id
	}) .. g.core.lang:get(101907)) .. g.core.model.User.homeData:getServerGitInfo())

	local var_7_1 = MultilingualMgr:getUseLang()
	local var_7_3 = " l." .. tostring((MultilingualMgr:getLangVersion(var_7_1))) .. "_" .. tostring((var_7_1 == config.DEFAULT_LANG or nil) and config.LANG_VERSION_NO)
	local var_7_4, var_7_5 = var_0_1:getVersion()

	self.m_versionText:setText("v." .. var_7_4 .. " b." .. var_7_5 .. " s." .. g.core.utils.Tools.getSilentObbVersion() .. var_7_3 .. " o." .. g.core.platform.PlatformProxy:getOpId())

	local var_7_6 = g.core.model.User:packUser()

	self.m_userIdTxt:setText(var_7_6.show_id)
	self.m_roleIdText:setText(var_7_6.id)

	self._serverId = var_7_0.id
	self._roleId = var_7_6.id

	self.m_codeText:setText(self._serverId .. ";" .. self._roleId)
	self.m_menuList:setNumItems(#self._menuInfos)
	self:_updateAllRed()
end

function UserBaseInfoComp:_updateAllRed()
	for iter_8_0, iter_8_1 in pairs(self._redComps) do
		iter_8_1:updateRed()
	end
end

function UserBaseInfoComp:_onMenuItemRenderer(arg_9_1, arg_9_2)
	arg_9_2:updateComp(self._menuInfos[arg_9_1 + 1])
end

function UserBaseInfoComp:_onMenuItemClick(arg_10_1)
	local var_10_0 = self._menuInfos[arg_10_1:getDataValue() + 1].funcRef

	if var_10_0 and self[var_10_0] then
		self[var_10_0](self)
	end
end

function UserBaseInfoComp:_onShowAgreement()
	if config.SHOW_USER_PROXY then
		var_0_1:openPrivPolicy()
	end
end

function UserBaseInfoComp:_onShowAccountAuthPop()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.user.view.UserSettingBindPhonePop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function UserBaseInfoComp:_onShowGameCodePop()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.user.view.UserSettingCodePop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function UserBaseInfoComp:_onShowIUSprite()
	require("app.view.module.user.view.CustommerServiceComp").new()
end

function UserBaseInfoComp:_onShowQuestionPage()
	local var_15_0 = g.core.model.User.questionnaireData:getShowQuestionnaire()

	if #var_15_0 == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(1123))

		return
	end

	local var_15_1 = var_15_0[1]

	var_0_1:openPaperUrl(config.PUBLISH_REGION == 1 and "uask-v3.youzu.com/route" or config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.TW and "uask-v3.ccfun.com/route" or "uask-v3.gtarcade.com/route", var_15_0[1].qid)
	g.core.model.User.questionnaireData:setQuesRedData(var_15_1.id)
	self:_updateAllRed()
end

function UserBaseInfoComp:_onShowTwitterPage()
	local var_16_0

	if g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] then
		var_16_0 = g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].SOCIAL_URL or "https://echocalypse.com/facebooksea"

		if g.core.platform.PlatformProxy:isChannelOfEn() then
			var_16_0 = "https://www.facebook.com/EchocalypseTSC"
		end
	end

	var_0_1:openURL(var_16_0)
end

function UserBaseInfoComp:_onShoDiscordPage()
	local var_17_0

	if g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] then
		var_17_0 = g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].DISCORD_URL or "https://discord.gg/FwYyEMhAD8"

		if g.core.platform.PlatformProxy:isChannelOfEn() then
			var_17_0 = "https://discord.gg/V6sbeEctTR"
		end
	end

	var_0_1:openURL(var_17_0)
end

function UserBaseInfoComp:_onSwitchAccount()
	var_0_1:logout()
end

function UserBaseInfoComp:_onShowUser()
	if var_0_1:hasCustomerService() then
		var_0_1:openCustomerService()
	end
end

function UserBaseInfoComp:_onExitGameAccount()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(1257),
		desc = g.core.lang:get(101909),
		confirmText = g.core.lang:get(1153),
		cancelText = g.core.lang:get(1147),
		onConfirm = handler(self, function()
			g.core.platform.PlatformProxy:openLogoutAccountCenter()
		end)
	}))
end

function UserBaseInfoComp:_onBindAccount()
	if not g.core.platform.PlatformProxy:checkNewFunctionByVersion1_1_0(true) then
		return
	end

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.TW then
		g.core.platform.PlatformProxy:showAuthennticationView()
	else
		g.core.module.ModuleManager:pushPopup(require("app.view.module.user.view.UserBindAccountPop").new())
	end
end

function UserBaseInfoComp:_onShowPermissionPop()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.user.view.UserPermissionPop").new())
end

function UserBaseInfoComp:_onShowThirdTip()
	if config.SUPERSDK_ENABLED then
		g.core.platform.PlatformProxy:openThridTip()
	end
end

function UserBaseInfoComp:_onShowCollectInfoTip()
	if config.SUPERSDK_ENABLED then
		g.core.platform.PlatformProxy:openOpenPersonalPrivacy()
	end
end

function UserBaseInfoComp:_onShowPhoneBindPop()
	if config.SUPERSDK_ENABLED then
		if g.core.platform.PlatformProxy:getCurChannel().name == require("app.core.platform.const.ChannelConst").ChannelNames.YOOZOO then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.user.view.UserSettingBindPhonePop").new())
		else
			g.core.platform.PlatformProxy:openPhoneBindPop()
		end
	end
end

function UserBaseInfoComp:_onOpenBilibili()
	g.core.platform.PlatformProxy:openURL("https://space.bilibili.com/1257166314/dynamic")
end

function UserBaseInfoComp:_onOpenTap()
	g.core.platform.PlatformProxy:openURL("https://tap.cn/kLqZhp1y?channel=rep-rep_bopo0j5vmb6_h5url360")
end

function UserBaseInfoComp:_onLogoffTip()
	g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
		singleButton = true,
		title = g.core.lang:get(105530),
		desc = g.core.lang:get(102412)
	})))
end

function UserBaseInfoComp:getLinkParams()
	local md5 = require("cocos.framework.extends.md5")
	local var_30_1 = g.core.platform.ServerListProxy:getSelectedServer()
	local var_30_2 = {
		game_id = g.core.platform.PlatformProxy:getGameId(),
		account = g.core.platform.PlatformProxy:getAccount(),
		op_id = g.core.platform.PlatformProxy:getOpId(),
		opgame_id = g.core.platform.PlatformProxy:getOpGameId(),
		server_id = var_30_1.id,
		server_name = var_30_1.name,
		role_id = g.core.model.User:getId(),
		role_name = g.core.model.User:getName(),
		sign_time = os.time()
	}
	local var_30_3 = {}

	for iter_30_0, iter_30_1 in pairs(var_30_2) do
		var_30_3[#var_30_3 + 1] = iter_30_0
	end

	table.sort(var_30_3)

	local var_30_4 = ""
	local var_30_5 = ""

	for iter_30_2 = 1, #var_30_3 do
		local var_30_6 = var_30_3[iter_30_2]

		if iter_30_2 < #var_30_3 then
			local var_30_7 = var_30_2[var_30_6]

			if var_30_6 == "server_name" or var_30_6 == "role_name" then
				var_30_7 = string.urlencode(var_30_7)
			end

			var_30_5 = var_30_5 .. var_30_6 .. "=" .. var_30_7 .. "&"
			var_30_4 = var_30_4 .. var_30_6 .. "=" .. var_30_2[var_30_6] .. "&"
		else
			local var_30_8 = var_30_2[var_30_6]

			if var_30_6 == "server_name" or var_30_6 == "role_name" then
				var_30_8 = string.urlencode(var_30_8)
			end

			var_30_5 = var_30_5 .. var_30_6 .. "=" .. var_30_8
			var_30_4 = var_30_4 .. var_30_6 .. "=" .. var_30_2[var_30_6]
		end
	end

	local var_30_9 = md5.new()

	var_30_9:update(var_30_4 .. "95235e2f39dfa132b26388f53d1f99ab")

	return var_30_5 .. "&" .. "sign=" .. md5.tohex(var_30_9:finish())
end

function UserBaseInfoComp:_onOpenWXPage()
	var_0_1:openSystemBrowser("https://a.greentool.net/?k=U3cknl" .. "&biz_name=" .. g.core.platform.PlatformProxy:getGameId() .. "&userid=" .. g.core.platform.PlatformProxy:getSdkAccount())
	var_0_2:setWXPageOpen(true)
	self:_updateAllRed()
end

function UserBaseInfoComp:_onOpenHYPage()
	g.core.platform.PlatformProxy:checkHYExchange()
end

function UserBaseInfoComp:_onClickUnBind()
	g.core.platform.PlatformProxy:isShowUnbind(function(arg_34_0)
		if arg_34_0 then
			g.core.platform.PlatformProxy:doUnbind()
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(202064))
		end
	end)
end

return UserBaseInfoComp
