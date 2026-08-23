local var_0_0 = g.core.event.enum
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.platform.PlatformProxy
local var_0_3 = g.core.model.User.annoData
local var_0_4 = g.core.module.ModuleManager
local var_0_5 = {}

function var_0_5.setExtLogic(arg_1_0)
	if not var_0_5._isEnable() then
		return
	end

	arg_1_0._serverGroup = {}
	arg_1_0._serverOpGameId = nil
	arg_1_0._reqServerCnt = 0
	arg_1_0._waitReqOpGameIds = {}

	local var_1_0 = {
		setExtLogic = true,
		_isEnable = true
	}

	for iter_1_0, iter_1_1 in pairs(var_0_5) do
		if type(iter_1_1) == "function" and not var_1_0[iter_1_0] then
			arg_1_0[iter_1_0] = iter_1_1
		end
	end
end

function var_0_5:onLoad(arg_2_1, arg_2_2)
	self.m_noticeBtn:setVisible(false)
	g.core.layer.LayerManager:getFloatLayer():resetAllFloatComp()
	self:_addBgCriSprite()

	self._reLoginType = arg_2_2 or 0

	if config.UPGRADE_ENABLED then
		self._upgradeLayer = var_0_4:pushModule(g.view.entrance.UPGRADE)

		self._upgradeLayer:setVisible(false)
	end

	g.core.event.EventManager:addEventListener("ON_G_TRACKBACK_CALL", self._onErrorMsgCall, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_CREATE_ROLE, self._onCreateRole, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_GAME_LOGIN_ACCOUNT_FINISH, self._onLoginAccountFinish, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_GAME_LOGOUT_ACCOUNT, self._onLogoutAccount, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_SUPERSDK_INIT_SUCCESS, self._onSuperSDKInitSuccess, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_SUPERSDK_INIT_FAIL, self._onSuperSDKInitFail, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_SDK_GET_SERVER_LIST, self._onGetServerList, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_SDK_GET_SERVER_LIST_FAIL, self._onGetServerListFail, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_SDK_GET_MY_SERVER_LIST, self._onGetMyServerList, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_LOCAL_CHOOSE_SERVER, self._onLocalChooseServer, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_NEW_VERISON, self._onNewVersion, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_GAME_LOGIN_FINISH, self._onLoginFinish, self)

	if var_0_2:init() then
		self:_fixCopyRightTxt()
	end

	if self._reLoginType == 0 and (not config.HIDE_HEALTH_NOTICE or config.PCSDK_ENABLED) then
		self._preloadFinish = false

		self:_playAntiIndulge((not device.isAndroid() or nil) and config.PCSDK_ENABLED and self._reLoginType == 0)
		self:_preloadEffect()

		self._loginProcessHandler = self:newSchedule(handler(self, self._onLoginProcess))
	else
		self:_addEffectBg()
		self:_onUpgradeEvent()
	end

	local var_2_0 = g.core.common.Storage:load("auto_connect.json", false) or {}
	local var_2_1 = var_2_0.ip or ""

	if var_2_1 == "" then
		-- block empty
	elseif var_2_0.auto then
		local var_2_2 = string.split(var_2_1, ":")

		g.core.service.ServiceManager:getServiceByName("DebuggerService"):start(var_2_2[1], var_2_2[2])

		var_2_0.auto = false

		g.core.common.Storage:save("auto_connect.json", var_2_0, false)
	end

	var_0_2:getClientPhoneIpInfo()

	if not device.isIOS() then
		self:_checkServerList()
	end

	g.core.sound.SoundManager:playMusic(var_0_1.SoundConst.BGM.MUSIC_LOGIN)
end

function var_0_5.updateLastLoginServer(arg_3_0)
	local var_3_0 = g.core.platform.ServerListProxy
	local var_3_1 = var_0_2:getRegionGroupInfo()
	local var_3_2 = var_3_1 and #var_3_1 > 0 and var_3_0:getLastLoginServerByMuiltGroup() or var_3_0:getLastLoginServer()

	if var_3_2 then
		arg_3_0._selectedServer = var_3_2

		var_3_0:setCurServer(var_3_2)
	end
end

function var_0_5:_onLoginAccountFinish(arg_4_1, arg_4_2)
	self._loginAccount = arg_4_2

	self:_updateLoginInfo()

	if device.isWindowsDebug() then
		self.m_noticeBtn:setVisible(true)
	elseif var_0_3:isShowAnnouncement() then
		self:_onOpenAnnoMainPop()
	end

	self:_checkServerList()
end

function var_0_5:_onLogoutAccount()
	self._loginAccount = nil
	self._getServerList = false

	if self._updateLoginInfo then
		self:_updateLoginInfo()
	end
end

function var_0_5:_onUpgradeEvent(arg_6_1)
	if arg_6_1 == nil then
		arg_6_1 = true
	end

	if self._upgradeLayer then
		self._upgradeLayer:setVisible(true)
		g.core.event.EventManager:dispatchEvent(var_0_0.EVENT_SUPERSDK_STATS, false, {
			event_id = var_0_1.SuperSdkConst.SHOW_UPGRADE_LAYER
		})
		self._upgradeLayer:start(function(arg_7_0)
			self._upgradeLayer:removeFromParent()

			self._upgradeLayer = nil

			if arg_7_0 then
				self:removeFromParent()

				return
			elseif not device.isWindowsDebug() then
				self:_reqWebList()

				if self._reLoginType == 0 then
					if not self._getServerList then
						self:_checkServerList()
					elseif not var_0_2:isLogined() then
						var_0_2:login()
						var_0_2:getClientPhoneIpInfo()
					end
				end
			end

			if device.platform == "ios" then
				local UpgradeSilent = require("upgrade.UpgradeSilent")

				if UpgradeSilent.isNeedUpgrade() then
					g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
						type = 1,
						title = g.core.lang:get(100003),
						text = g.core.lang:get(100059),
						text_cancel = g.core.lang:get(100006),
						handler_cancel = function()
							fgui.UIPackage:addPackage("ui/upgrade/upgrade")

							local var_8_0 = fgui.UIPackage:createObject("upgrade", "SilentIosProg")

							g.core.layer.LayerManager:setIosDownObj(var_8_0)
							UpgradeSilent.start(handler(var_8_0, var_8_0.updateFuncCallBack))
							self:onCheckSilentOpeFinish()
						end
					}), {
						ignoreTouch = true
					})
				else
					self:onCheckSilentOpeFinish()
					g.core.common.PackageRes:doRequestPackageInfo()
				end
			else
				require("upgrade.UpgradeSilent").start()
				self:onCheckSilentOpeFinish()
			end
		end)
	elseif not device.isWindowsDebug() then
		self:_reqWebList()

		if not config.DEBUG_VERSION and not self._getServerList then
			self:_checkServerList()
		elseif self._reLoginType == 0 and arg_6_1 then
			-- block empty
		end

		var_0_2:openLoginPage()

		if not config.UPGRADE_ENABLED then
			self.m_globalLoginComp:setTouchable(true)
		end
	else
		self._getServerList = true

		if not self._pvPlayStorage.played then
			self.m_bgComp:removeAllCriSprite()
			var_0_4:pushPopup(require("app.view.module.login.view.PvPlayLayer").new({
				pvName = "pv2new_1920x1080_92300",
				localName = "pv_first_play",
				zimuName = "pv2zimu_1920x1080x1_92300",
				bgPVSound = g.core.const.ConstMgr.SoundConst.Sound.BG_PV_FIRST
			}))
		end
	end
end

function var_0_5:onCheckSilentOpeFinish()
	self:_showUpgradeStatus(false)
	var_0_2:openLoginPage()

	if not self._pvPlayStorage.played then
		self.m_bgComp:removeAllCriSprite()
		var_0_4:pushPopup(require("app.view.module.login.view.PvPlayLayer").new({
			pvName = "pv2new_1920x1080_92300",
			localName = "pv_first_play",
			zimuName = "pv2zimu_1920x1080x1_92300",
			bgPVSound = g.core.const.ConstMgr.SoundConst.Sound.BG_PV_FIRST
		}))
	end
end

function var_0_5:_onGetMyServerList()
	self:updateLastLoginServer()
	self:_updateLoginInfo()

	if self._reqServerCnt < 1 then
		self:updateLastLoginServer()
	end
end

function var_0_5:_onGetServerList()
	self._reqServerCnt = self._reqServerCnt - 1
	self._getServerList = true

	if self._reqServerCnt < 1 then
		self:updateLastLoginServer()
	end

	self:updateLastLoginServer()
	self:_updateLoginInfo()
	self.m_descInitTxt:setVisible(false)

	self._firstReqSerList = false

	if not var_0_2:isLogined() then
		var_0_2:login()
	end

	var_0_2:openLoginPage()

	local var_11_0 = table.remove(self._waitReqOpGameIds, 1)

	if var_11_0 then
		g.core.platform.ServerListProxy:requestServerByOpGameId(var_11_0)
	end
end

function var_0_5:_checkServerList()
	if self._sdkInited == 1 and not self._getServerList then
		self._reqServerCnt = 1
		self._waitReqOpGameIds = {}

		self.m_descInitTxt:setVisible(true)
		self.m_descInitTxt:setText(g.core.lang:get(100033))

		local var_12_0 = var_0_2:getRegionGroupInfo() or {}

		self._reqServerCnt = self._reqServerCnt + #var_12_0

		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			self._waitReqOpGameIds[#self._waitReqOpGameIds + 1] = iter_12_1.opGameId
		end

		var_0_2:reqServerList()
	end
end

function var_0_5._isEnable()
	return config.PUBLISH_REGION == var_0_1.PlatformConst.REGION.EN
end

return var_0_5
