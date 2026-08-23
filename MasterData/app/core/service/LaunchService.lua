local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_2 = g.core.common.ModuleUnlock
local var_0_3 = g.core.network.GameNetProxy
local LaunchService = class("LaunchService")

function LaunchService:ctor()
	self._isLaunching = true
	self._hasCreateRole = false
	self._patchSchedule = nil
	self._appEnterBgTime = 0
	self._isLoginFinish = false
	self._isExitGame = false

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_LAUNCH, self._onGameLaunch, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CREATE_ROLE, self._onCreateRole, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_LOGIN_FINISH, self._onGameLoginFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_RESUME_FINISH, self._onGameLoginResume, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_LOGOUT, self._onGameLogout, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_LOGOUT_ACCOUNT, self._onGameLogoutAccount, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_RESTART, self._onGameRestart, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EVENT, self._onModuleEvent, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_LOGIN_ACCOUNT_START, self._onGameLoginAccountStart, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_DISCONNECTED, self._onNetDisconnected, self)

	if config.PCSDK_ENABLED then
		self:_addGlViewClosedEvent()
	end
end

function LaunchService:_onCreateRole()
	self._hasCreateRole = true
end

function LaunchService:reset()
	self:resetSchedule()

	self._isLaunching = true
	self._hasCreateRole = false
end

function LaunchService:clearPackageManager()
	self._packageManager:reset()
	g.core.model.User:clear()
	g.core.const.ConstMgr:clear()
	g.core.service.ServiceManager:clearService()
	g.core.event.EventManager:clearEvent()
	g.core.layer.LayerManager:getRoot():removeChildren()
	require("app.core.fairygui.UITransitionMgr"):clearSharedComp()
	self._packageManager:clearPackage()
end

function LaunchService:_onGameLaunch(arg_5_1, arg_5_2)
	self._packageManager = arg_5_2

	local function var_5_0()
		local var_6_0 = ""
		local var_6_1 = cc.FileUtils:getInstance()

		if var_6_1.getObbFilePath then
			var_6_0 = var_6_1:getObbFilePath()
		end

		return var_6_0 ~= "" and var_6_1:isFileExist(var_6_0)
	end

	if config.IS_MICRO_PKG then
		if (g.core.common.Storage:load("micro_config.json", false) or {})[require("upgrade.UpgradeConst").MICRO_SYNCED_VER] == config.GAME_VERSION_NO then
			g.core.module.ModuleManager:pushModule(g.view.entrance.LOGIN)
		elseif var_5_0() then
			g.core.module.ModuleManager:pushModule(g.view.entrance.UNZIP_OBB)
		elseif config.PCSDK_ENABLED then
			g.core.platform.PlatformProxy:init()
		else
			g.core.module.ModuleManager:pushModule(g.view.entrance.LOGIN)
		end
	elseif var_5_0() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.UNZIP_OBB)
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.LOGIN)
	end
end

function LaunchService:_checkFirstGuideFinish()
	if config.START_NEW_GUIDE and not g.core.model.User.outpostData:isCanOutOutpost() then
		return false
	end

	local var_7_0 = g.core.model.User:getGuideId()
	local var_7_1 = json.decodeFileIfExists("guide/newbee_guide.json")

	if var_7_1 and #var_7_1 > 0 then
		for iter_7_0, iter_7_1 in pairs(var_7_1) do
			if iter_7_1.resetId ~= 99999 and var_7_0 == iter_7_1.stepId then
				return false
			end
		end
	end

	return true
end

function LaunchService:_onGameLoginFinish()
	if self._isLaunching then
		self:_sendRequiredMessage()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = var_0_0.SuperSdkConst.LOGIN_SUCCESS
		})

		if not self._hasCreateRole then
			local var_8_0 = self:_checkFirstGuideFinish()

			if not var_8_0 then
				g.core.sound.SoundManager:loadGuideBanks()
			else
				g.core.sound.SoundManager:unloadFirstPlayBank()
			end

			if GUIDE_CLOSE or config.UPGRADE_SILENT_ENABLED and var_8_0 then
				require("upgrade.UpgradeSilent").showUpgradeTip(function()
					require("app.view.module.loading.view.LoadingLayer").show()
				end)
			else
				require("app.view.module.loading.view.LoadingLayer").show()
			end
		else
			g.core.sound.SoundManager:loadGuideBanks()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GAME_LOGIN_LOADING, true)
		end

		g.core.platform.PlatformProxy:addLocalVitFullSchedule({
			num = g.core.model.User.resourceData:getVit()
		})

		if config.SHOW_VOICE_CHAT_FUNCTION then
			g.core.platform.PlatformProxy:initIM()

			local var_8_1 = g.core.platform.ServerListProxy:getSelectedServer().sid

			g.core.platform.PlatformProxy:imJoinRoom(var_8_1)

			if g.core.model.User.guildData:hasGuild() then
				g.core.platform.PlatformProxy:imJoinRoom(g.core.model.User.guildData:getGuildId())
			end

			local var_8_2 = g.core.model.User.bioData:getTeamInfo()

			if var_8_2 and var_8_2.id ~= 0 then
				g.core.platform.PlatformProxy:imJoinRoom(tostring(var_8_1) .. tostring(var_8_2.id))
			end
		end
	else
		self:_sendOptionalMessage()
	end

	self._isLaunching = false

	self:_addAppEnterEvents()
	g.core.platform.PlatformProxy:sendAdvLogin()
	g.core.platform.PlatformProxy:accountInfoJson()
	g.core.platform.PlatformProxy:getPrivateSpaceInfo()
end

function LaunchService:_onGameLoginResume()
	self:_sendOptionalMessage()
	self:_addAppEnterEvents()
end

function LaunchService:_onNetDisconnected()
	self:resetSchedule()
end

function LaunchService:_onGameLoginAccountStart()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.login.view.LoginAccountPop").new())
end

function LaunchService:_onGameLogout()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CLEAR_BATTLE_RESOURCE)
	g.core.module.ModuleManager:clearModuleStackAndPush(g.view.entrance.LOGIN, 1)
	require("app.core.common.Provider"):clearCache()
	self._packageManager:reset()
	self:_removeAppEnterEvents()
end

function LaunchService:_onGameRestart()
	g.core.module.ModuleManager:clearModuleStack()
	require("app.core.common.Provider"):clearCache()
	self._packageManager:reset()
	self:_removeAppEnterEvents()
	device.restartGame()
end

function LaunchService:_onGameLogoutAccount()
	if g.core.module.ModuleManager:getCurModule().module ~= g.view.entrance.LOGIN then
		g.core.module.ModuleManager:clearModuleStackAndPush(g.view.entrance.LOGIN, 2)
		require("app.core.common.Provider"):clearCache()
		self._packageManager:reset()
	end

	self:_removeAppEnterEvents()
end

function LaunchService:_onModuleEvent(arg_16_1, arg_16_2, arg_16_3)
	if arg_16_2 == "login_account" then
		g.core.platform.PlatformProxy:onLogin(arg_16_3)
	end
end

function LaunchService:_scheduleRequestPatch(arg_17_1)
	if device.isWindowsDebug() then
		return
	end

	if not self._patchSchedule then
		if arg_17_1 then
			self:_requestPatch()
		end

		local var_17_0 = var_0_3

		self._patchSchedule = g.core.common.Scheduler:newServerTimeSchedule(function()
			if var_17_0:isConnected() then
				self:_requestPatch()
			else
				self:resetSchedule()
			end
		end, 900, 60)
	end
end

function LaunchService:resetSchedule()
	if self._patchSchedule then
		g.core.common.Scheduler:cancelSchedule(self._patchSchedule)

		self._patchSchedule = nil
	end
end

function LaunchService:_requestPatch()
	g.core.platform.PlatformProxy:requestPlatformConfig()
end

function LaunchService:_sendOptionalMessage()
	if var_0_2:isModuleUnlock(var_0_1.MAIL) then
		var_0_3:send_C2S_Mail_Info({
			mail_type = 1
		}, true)
		var_0_3:send_C2S_Mail_Info({
			mail_type = 2
		}, true)
		var_0_3:send_C2S_Mail_Info({
			mail_type = 3
		}, true)
		g.core.model.User.mailData:notifyMailRefresh(true)
	else
		g.core.model.User.mailData:notifyMailRefresh(false)
	end

	if var_0_2:isModuleUnlock(var_0_1.MINE) then
		local var_21_0 = g.core.module.ModuleManager:getCurModule()

		if var_21_0 and var_21_0.module == g.view.entrance.MINE then
			-- block empty
		end
	end

	var_0_3:send_C2S_Recharge_GetRecharge({})
	self:_scheduleRequestPatch(true)
end

function LaunchService:_sendRequiredMessage()
	var_0_3:send_C2S_FlushRedPoint({})
	var_0_3:send_C2S_BlockedActivity_GetList({})
	var_0_3:send_C2S_UniteToken_GetAttribute({})
	var_0_3:send_C2S_FrameInfo({})
	g.core.model.User.rechargeData:requestRealProductsInfo()
	var_0_3:send_C2S_Shop_GetShopInfo({})
	var_0_3:send_C2S_GetCommonPlayNum({})
	var_0_3:send_C2S_NewYearWish_GetInfo({})

	if var_0_2:isModuleUnlock(var_0_1.COMMANDER_WORLD) then
		var_0_3:send_C2S_OrderWorld_Info({})
	end

	if var_0_2:isModuleUnlock(var_0_1.MAIL) then
		var_0_3:send_C2S_Mail_Info({
			mail_type = 1
		}, true)
		var_0_3:send_C2S_Mail_Info({
			mail_type = 2
		}, true)
		var_0_3:send_C2S_Mail_Info({
			mail_type = 3
		}, true)
		g.core.model.User.mailData:notifyMailRefresh(true)
		g.core.model.User.flushInfoData:setMailSendTime((g.core.common.ServerTime:getTime()))
	else
		g.core.model.User.mailData:notifyMailRefresh(false)
	end

	if var_0_2:isModuleUnlock(var_0_1.FRIEND) then
		var_0_3:send_C2S_Friend_Info({})
		var_0_3:send_C2S_Friend_FriendList({})
		var_0_3:send_C2S_Friend_BlackList({})
		var_0_3:send_C2S_Friend_RequestList({})
	end

	if var_0_2:isModuleUnlock(var_0_1.KINGDOM_FATE) then
		var_0_3:send_C2S_Scroll_Info({})
	end

	if var_0_2:isModuleUnlock(var_0_1.HOME_LAND_TRAIN) then
		var_0_3:send_C2S_HomeLandTrain_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.HOME_LAND_FURNITURE) then
		var_0_3:send_C2S_FurnitureRoom_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.DAILY_DUNGEON) then
		var_0_3:send_C2S_DailyDungeon_Info({})
	end

	g.core.model.User.dailyDungeonData:loadJsonCache()

	if var_0_2:isModuleUnlock(var_0_1.KNIGHT_HAND_BOOK) then
		var_0_3:send_C2S_KnightBook_Info({})
	end

	if var_0_2:isModuleUnlock(var_0_1.PET_HANDBOOK) then
		var_0_3:send_C2S_Pet_HandbookInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.PET_UR_GROUP) then
		g.core.network.GameNetProxy:send_C2S_Handbook_Info({
			id = g.core.network.proto.UR_PET_HB
		})
	end

	var_0_3:send_C2S_Announce_Info({})

	if var_0_2:isModuleUnlock(var_0_1.DAILY_TASK) then
		var_0_3:send_C2S_DailyTask_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.ACTIVITY_SIGNIN) then
		var_0_3:send_C2S_SignIn_Info({})
	end

	if var_0_2:isModuleUnlock(var_0_1.ACTIVITY_STAMINA) then
		var_0_3:send_C2S_GetStamina_Info({})
	end

	if var_0_2:isModuleUnlock(var_0_1.SHOPFLUSH_LIMITTIME) then
		var_0_3:send_C2S_FlushShop_Info({
			shop_id = 2
		}, true)
	end

	var_0_3:send_C2S_CustomActivity_GetInfo({})
	var_0_3:send_C2S_Questionnaire_GetInfo({})

	if var_0_2:isModuleUnlock(var_0_1.SEVEN_DAYS_ACTIVITY) then
		var_0_3:send_C2S_NewSevendays_Info({
			type = g.core.model.User.sevenDaysData:getActValueByFunId(var_0_1.SEVEN_DAYS_ACTIVITY)
		})
	end

	if var_0_2:isModuleUnlock(var_0_1.SEVEN_DAYS_ACTIVITY_2) then
		if g.core.model.User.sevenDaysData:isShow7DaysActivity(var_0_1.SEVEN_DAYS_ACTIVITY_2) then
			var_0_3:send_C2S_NewSevendays_Info({
				type = g.core.model.User.sevenDaysData:getActValueByFunId(var_0_1.SEVEN_DAYS_ACTIVITY_2)
			})
		end
	end

	if var_0_2:isModuleUnlock(var_0_1.BIND_PHONE_ACTIVITY) then
		var_0_3:send_C2S_Phone_Info({})
	end

	if var_0_2:isModuleUnlock(var_0_1.LEVEL_UP_AWARD) then
		var_0_3:send_C2S_LevelUp_Info({})
	end

	var_0_3:send_C2S_Recharge_GetGMTotalRechargeInfo({})

	if var_0_2:isModuleUnlock(var_0_1.SEVEN_DAYS_SIGN_IN) then
		var_0_3:send_C2S_LoginReward_Info({})
	end

	if var_0_2:isModuleUnlock(var_0_1.PUSH_GIFT) then
		var_0_3:send_C2S_PushGift_Info({})
		var_0_3:send_C2S_PushGift_GetGmActInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.GUIDE_TASK) then
		var_0_3:send_C2S_GuideTask_Info({})
	end

	var_0_3:send_C2S_Recharge_GetRecharge({})

	if var_0_2:isModuleUnlock(var_0_1.AUCTION_COMPANY) then
		var_0_3:send_C2S_Auction_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.GUILD_BOSS) and g.core.model.User.guildBossData:isProcess() and g.core.model.User.guildData:hasGuild() then
		var_0_3:send_C2S_GuildBoss_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.GUILDFIGHT_PLAYERLEVEL) and g.core.model.User.guildData:hasGuild() and g.core.model.User.GuildFightData:isInOpenTime() then
		var_0_3:send_C2S_GuildBattle_GetInfo({
			is_match = false
		})
	end

	if g.core.model.User.guildData:hasGuild() then
		g.core.network.GameNetProxy:send_C2S_Guild_RedPacket_Info({})
	end

	if var_0_2:isModuleUnlock(var_0_1.SHARE) then
		var_0_3:send_C2S_WeChat_Share_Get({})
	end

	if var_0_2:isModuleUnlock(var_0_1.ARTIFACT_HANDBOOK) then
		var_0_3:send_C2S_Handbook_Info({
			id = g.core.network.proto.UR_ARTIFACT_HB
		})
		var_0_3:send_C2S_Handbook_Info({
			id = g.core.network.proto.ARTIFACT_HB
		})
	end

	g.core.network.GameNetProxy:send_C2S_Flush({
		account_bind = true
	})

	if var_0_2:isModuleUnlock(var_0_1.OPEN_SCREEN_AD) then
		var_0_3:send_C2S_AbvertPage_GetInfo({})
	end

	var_0_3:send_C2S_Activity_Common_GetInfoServer({})
	var_0_3:send_C2S_ThemePV_GetInfo({})
	var_0_3:send_C2S_NewRecruit_Info({})
	var_0_3:send_C2S_CrossActivity_GetInfo({})
	var_0_3:send_C2S_PeakArena_GetActivityInfo({})
	var_0_3:send_C2S_PassCard_Info({})

	if var_0_2:isModuleUnlock(var_0_1.ONLINE_GIFT) and g.core.model.User.onlineGiftData:isOnlineActivityOpen() then
		var_0_3:send_C2S_OnlineGift_GetInfo({})
	end

	g.core.model.User.userAvatarFrameData:updateDataByConfig()

	if var_0_2:isModuleUnlock(var_0_1.DAILY_PROFILE) then
		g.core.network.GameNetProxy:send_C2S_StoryCompletion_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.MAIN_SCENE_SKIN) then
		g.core.network.GameNetProxy:send_C2S_BgBook_GetInfo({})
	end

	var_0_3:send_C2S_Interaction_InfoAll({})

	if var_0_2:isModuleUnlock(var_0_1.CHAT) then
		g.core.network.GameNetProxy:send_C2S_TalkShow_Get({})
	end

	if var_0_2:isModuleUnlock(var_0_1.SIGN_CUSTOM_ACTIVITY) then
		var_0_3:send_C2S_GmActivityLogin_GetInfo({})
	end

	var_0_3:send_C2S_GetUserConfig({})

	if var_0_2:isModuleUnlock(var_0_1.GOLD_SAVING) then
		var_0_3:send_C2S_GoldSaving_Flush({})
	end

	g.core.network.GameNetProxy:send_C2S_H5Activity_GetInfo({})

	if var_0_2:isModuleUnlock(var_0_1.USER_BACK) then
		g.core.network.GameNetProxy:send_C2S_UserBack_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.ECHO_LAB) then
		g.core.network.GameNetProxy:send_C2S_Palace_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.HANDBOOK_COMPETITION) then
		g.core.network.GameNetProxy:send_C2S_HandbookCompetition_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.GENE) then
		var_0_3:send_C2S_Gene_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.ACTIVITY_RECYCLE_BIN) then
		var_0_3:send_C2S_Retrieve_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.WORLD_RED_PACKET) then
		g.core.network.GameNetProxy:send_C2S_WorldRedPacket_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.CROSS_SERVER_ARENA) then
		local var_22_0 = g.core.model.User.crossServerArenaData:getSeasonStatus()

		if var_22_0 == var_0_0.CrossServerArenaConst.CTRL_ON_SEASON or var_22_0 == var_0_0.CrossServerArenaConst.CTRL_OFF_SEASON then
			var_0_3:send_C2S_GetModuleTaskInfo({
				module_id = var_0_0.TaskConst.MODULE_ID.CROSS_SERVER_ARENA
			})
		end
	end

	g.core.network.GameNetProxy:send_C2S_Recharge_GetGMFirstRechargeInfo({})
	g.core.network.GameNetProxy:send_C2S_Harmonious_Infos({})
	g.core.network.GameNetProxy:send_C2S_HarmoniousMystery_Infos({})

	if var_0_2:isModuleUnlock(var_0_1.KNIGHT_SOUL) then
		g.core.network.GameNetProxy:send_C2S_KSoul_Info({})
	end

	if var_0_2:isModuleUnlock(var_0_1.LOTTERY) then
		g.core.network.GameNetProxy:send_C2S_Lottery_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.WEEKLY_COMPETITION) then
		g.core.network.GameNetProxy:send_C2S_WeeklyCompetition_Info({})
	end

	if var_0_2:isModuleUnlock(var_0_1.WEDDING_VOW) then
		var_0_3:send_C2S_WeddingVow_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.MYSTERY) then
		var_0_3:send_C2S_Mystery_Info({})
	end

	if var_0_2:isModuleUnlock(var_0_1.ALLIANCE) then
		if var_0_2:isModuleUnlock(var_0_1.NEW_SLG) and g.core.model.User.newSlgData:getSName() == "S2" then
			var_0_3:send_C2S_GuildAlliance_GetInfo({})
		end

		g.core.network.GameNetProxy:send_C2S_Area_MergeInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.NEW_SLG) then
		var_0_3:send_C2S_Tips_Flush({})
	end

	if var_0_2:isModuleUnlock(var_0_1.ACTIVITY_RETRO) and g.core.model.User.retroData:isActOpen() then
		var_0_3:send_C2S_Retro_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.ABVERT_PAGE_AWARD) then
		var_0_3:send_C2S_AbvertPageAward_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.SHOP_CAR) then
		var_0_3:send_C2S_ShopCar_GetInfo({})
	end

	if var_0_2:isModuleUnlock(var_0_1.SERVER_PASS_ACTIVITY) then
		var_0_3:send_C2S_ServerPass_Info({})
	end

	if var_0_2:isModuleUnlock(var_0_1.VIP_LINK) then
		var_0_3:send_C2S_VipLink_GetInfo({})
	end

	self:_scheduleRequestPatch(false)

	self._isLoginFinish = true
end

function LaunchService:isLoginFinish()
	return self._isLoginFinish
end

function LaunchService:_addGlViewClosedEvent()
	self:_removePcCloseEvent()
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithFixedPriority(cc.EventListenerCustom:create("GLVIEW_WINDOW_CLOSED", function()
		if not self._isExitGame then
			if g.core.battle.BattleProxy:isPaused() then
				return
			end

			local var_25_0 = g.core.layer.LayerManager

			if not g.core.layer.LayerManager:getLoadingLayer():isVisible() then
				if var_25_0:getModuleLoadingLayer():numChildren() == 0 then
					if var_25_0:getTopLayer():numChildren() ~= 0 then
						return
					end

					if g.core.module.ModuleManager._pushWaiting then
						return
					end

					if g.core.model.User.storyData:isInStory() then
						return
					end
				end
			end

			local var_25_1 = g.core.module.ModuleManager:getCurModule()

			if var_25_1 then
				local var_25_2 = var_25_1.module or nil

				if var_25_2 == g.view.entrance.CREATE or var_25_2 == g.view.entrance.CREATE_MOVIE then
					return
				end
			end

			local var_25_3 = {
				isExitGame = true,
				title = g.core.lang:get(1257),
				desc = g.core.lang:get(1258),
				onCancel = function()
					self._isExitGame = false

					g.core.battle.BattleProxy:resume()
				end,
				onConfirm = function()
					if g.core.platform.PlatformProxy.requestQuit then
						g.core.platform.PlatformProxy:requestQuit("game quit")
					end

					cc.Director:getInstance():endToLua()
				end
			}

			g.core.battle.BattleProxy:pause()
			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new(var_25_3), {
				system = true
			})

			self._isExitGame = true
		else
			self._isExitGame = false
		end
	end), 1)
end

function LaunchService:isExitGame()
	return self._isExitGame
end

function LaunchService:_removePcCloseEvent()
	cc.Director:getInstance():getEventDispatcher():removeCustomEventListeners("GLVIEW_WINDOW_CLOSED")
end

function LaunchService:_addAppEnterEvents()
	self:_removeAppEnterEvents()

	local var_30_0 = cc.Director:getInstance():getEventDispatcher()

	var_30_0:addEventListenerWithFixedPriority(cc.EventListenerCustom:create("APP_ENTER_BACKGROUND_EVENT", function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.APP_ENTER_BACKGROUND_EVENT)
		g.core.platform.PlatformProxy:addLocalVitFullSchedule({
			num = g.core.model.User.resourceData:getVit()
		})
	end), 1)
	var_30_0:addEventListenerWithFixedPriority(cc.EventListenerCustom:create("APP_ENTER_FOREGROUND_EVENT", function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.APP_ENTER_FOREGROUND_EVENT)
	end), 1)
	var_30_0:addEventListenerWithFixedPriority(cc.EventListenerCustom:create("APP_SAVE_IMAGE_FINISH", function()
		g.core.common.Scheduler:newScheduleOnce(function()
			if require("app.core.platform.NativeCallUtils").call("getSaveImageResult", nil, "boolean") then
				g.core.module.ModuleManager:tip(g.core.lang:get(308504))
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(308505))
			end
		end, 0)
	end), 1)
end

function LaunchService:_removeAppEnterEvents()
	local var_35_0 = cc.Director:getInstance():getEventDispatcher()

	var_35_0:removeCustomEventListeners("APP_ENTER_BACKGROUND_EVENT")
	var_35_0:removeCustomEventListeners("APP_ENTER_FOREGROUND_EVENT")
	var_35_0:removeCustomEventListeners("APP_SAVE_IMAGE_FINISH")
end

return LaunchService
