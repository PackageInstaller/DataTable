local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = {
	RECRUIT = {
		clickFunc = function()
			g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT)
		end
	},
	LINEUP = {
		lockFunc = function()
			return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.KNIGHT_LINE_UP_1)
		end,
		clickFunc = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.KNIGHT_LINE_UP_1, nil, true) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.LINE_UP)
			end
		end
	},
	GUILD = {
		lockFunc = function()
			return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.GUILD)
		end,
		clickFunc = function()
			if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.ALLIANCE) then
				g.core.module.ModuleManager:pushPopup(require("app.view.module.home.view.HomeSmallEmbryoPop1").new({
					expandType = 3
				}), {
					touchDisappear = true,
					withoutAni = true
				})
				g.core.module.ModuleManager:hideBlurModuleList()
				g.core.common.Scheduler:newScheduleOnce(function()
					g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
					g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
				end, 0.1)
			elseif g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.GUILD) then
				local var_5_0 = g.core.model.User:getGuildId()

				if not var_5_0 or var_5_0 == 0 then
					g.core.module.ModuleManager:pushModule(g.view.entrance.GUILD_JOIN)
				else
					g.core.module.ModuleManager:pushModule(g.view.entrance.GUILD_MAIN)
				end
			end
		end,
		getBtnName = function()
			if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.ALLIANCE) then
				return g.core.lang:get(100512)
			else
				return g.core.lang:get(100507)
			end
		end,
		getIconName = function()
			if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.ALLIANCE) then
				return "ui://home/icon_zjm_zuzhi1"
			else
				return "ui://home/icon_zjm_gonghui1"
			end
		end
	},
	CAMPAIGN = {
		lockFunc = function()
			return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.PVP_MAIN)
		end,
		clickFunc = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.PVP_MAIN) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.CAMPAIGN)
			end
		end
	},
	BIO = {
		lockFunc = function()
			return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.BIO_MAIN)
		end,
		clickFunc = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.BIO_MAIN, nil, true) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.BIO_MAIN)
			end
		end
	},
	DUNGEON = {
		clickFunc = function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_ENTER_PLAY_TRANSITION, false, {
				toRight = false,
				callback = function()
					g.core.module.ModuleManager:pushModule(g.view.entrance.DUNGEON)
				end
			})
		end
	},
	HOMELAND = {
		lockFunc = function()
			return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.HOME_LAND_MAIN) or g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.OUTPOST)
		end,
		clickFunc = function()
			if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.HOME_LAND_MAIN) and g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.OUTPOST) then
				g.core.module.ModuleManager:pushPopup(require("app.view.module.home.view.HomeSmallEmbryoPop1").new({
					expandType = 4,
					dir = cc.p(50, 0)
				}), {
					touchDisappear = true,
					withoutAni = true
				})
				g.core.module.ModuleManager:hideBlurModuleList()
				g.core.common.Scheduler:newScheduleOnce(function()
					g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
					g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
				end, 0.1)
			elseif g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.HOME_LAND_MAIN) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.HOME_LAND)
			elseif g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.OUTPOST) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.OUT_POST_STAGE)
			end
		end,
		getBtnName = function()
			if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.HOME_LAND_MAIN) and g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.OUTPOST) then
				return g.core.lang:get(432663)
			elseif g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.OUTPOST) then
				return g.core.lang:get(432662)
			else
				return g.core.lang:get(432664)
			end
		end,
		getIconName = function()
			if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.HOME_LAND_MAIN) and g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.OUTPOST) then
				return "ui://home/icon_zjm_jidijianshe"
			elseif g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.OUTPOST) then
				return "ui://home/icon_zjm_huixiangshaozhan"
			else
				return "ui://home/icon_zjm_shenghuoqu1"
			end
		end,
		checkSpecialRedRes = function()
			if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.OUTPOST) and g.core.model.User.outpostData:isHasVit() then
				return true, "ui://text_new/txt_zjm_wendingdu"
			end
		end
	},
	CHARGE = {
		clickFunc = function()
			g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE)
		end
	},
	SHOP = {
		lockFunc = function()
			return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.PLAY_SHOP)
		end,
		clickFunc = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.PLAY_SHOP, nil, true) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP)
			end
		end
	},
	KNIGHT_BAG = {
		lockFunc = function()
			return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.KNIGHT_BAG)
		end,
		clickFunc = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.KNIGHT_BAG, nil, true) then
				if g.core.guide.GuideProxy:isGuideRunning() then
					return
				elseif g.core.utils.Tools.checkSilentFull() ~= 0 then
					require("upgrade.UpgradeSilent").showUpgradeTip()

					return
				end

				g.core.module.ModuleManager:pushModule(g.view.entrance.KNIGHT)
			end
		end
	},
	BAG = {
		clickFunc = function()
			g.core.module.ModuleManager:pushModule(g.view.entrance.MAIN_BAG)
		end,
		checkSpecialRedRes = function()
			if g.core.model.User.equipmentData:countEquipmentNum() >= g.core.model.User.equipmentData:getBagLimit() or g.core.model.User.treasureData:countTreasureNum() >= g.core.model.User.treasureData:getBagLimit() then
				return true, "ui://home/pic_yimanbiaoshidi", "已满"
			end
		end
	},
	UNITE_TOKEN = {
		lockFunc = function()
			return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.UNITE_TOKEN)
		end,
		clickFunc = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.UNITE_TOKEN, nil, true) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.UNITE_TOKEN)
			end
		end
	},
	PEI_ZI = {
		lockFunc = function()
			return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.PEI_ZI)
		end,
		clickFunc = function(arg_31_0)
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.PEI_ZI, nil, true) then
				g.core.module.ModuleManager:pushPopup(require("app.view.module.home.view.HomeSmallEmbryoPop").new({
					expandType = 1
				}), {
					touchDisappear = true,
					withoutAni = true
				})
				g.core.module.ModuleManager:hideBlurModuleList()
			end
		end
	},
	CULTIVATION = {
		lockFunc = function()
			return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.CULTIVATION)
		end,
		clickFunc = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.CULTIVATION, nil, true) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.CULTIVATION)
			end
		end
	},
	SETTING = {
		clickFunc = function()
			g.core.module.ModuleManager:pushModule(g.view.entrance.SETTING)
		end
	},
	ANNOUNCE = {
		clickFunc = function()
			if not device.isWindowsDebug() then
				g.core.module.ModuleManager:pushPopup(require("app.view.module.announcement.view.AnnoMainPop").new(), device.isWindows() and {
					withoutAni = true
				} or nil)
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(100536))
			end
		end
	},
	SIGNIN = {
		clickFunc = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.ACTIVITY_SIGNIN) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.SIGNIN_ACTIVITY)
			end
		end
	},
	MAIL = {
		clickFunc = function()
			g.core.module.ModuleManager:pushModule(g.view.entrance.MAIL)
		end
	},
	FRIEND = {
		clickFunc = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.FRIEND) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.FRIEND)
			end
		end
	},
	REBORN = {
		clickFunc = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.REBORN) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.REBORN)
			end
		end
	},
	GUIDE_TASK = {
		clickFunc = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.GUIDE_TASK) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.GUIDE_TASK)
			end
		end
	},
	DAILY_REPORT = {
		clickFunc = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.DAILY_REPORT) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.DAILY_REPORT)
			end
		end
	},
	BIRTHDAY_CARD = {
		clickFunc = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.BIRTHDAY_CARD) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.BIRTHDAY_CARD)
			end
		end,
		showFunc = function()
			local var_43_0 = g.core.model.User.userFestivalData

			if g.core.model.User.userFestivalData:hasReceived() then
				return var_43_0:getReceiveElapsedDay() < 3
			else
				local var_43_1 = var_43_0:getBirthdayElapsedDay()

				return var_43_1 and var_43_1 < 30
			end
		end
	},
	TAP_TAP = {
		clickFunc = function()
			g.core.platform.PlatformProxy:openURL("https://tap.cn/kLqZhp1y?channel=rep-rep_bopo0j5vmb6_h5url360")
		end,
		showFunc = function()
			if g.core.platform.PlatformProxy:getCurChannel().name == require("app.core.platform.const.ChannelConst").ChannelNames.TAPTAP then
				return true
			end

			return false
		end
	},
	SUMMON_OLD_PLAYER = {
		clickFunc = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.SUMMON_OLD_PLAYER) then
				g.core.module.ModuleManager:pushPopup(require("app.view.module.summonOldPlayer.view.SummonOldPlayerPop").new(), {
					touchDisappear = true
				})
			end
		end,
		showFunc = function()
			return g.core.model.User.summonOldPlayerData:isShowDoor()
		end
	},
	PACKAGE_DOWNLOAD = {
		clickFunc = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.PACKAGE_DOWNLOAD) then
				g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.DownloadingListPop").new(), {
					touchDisappear = true
				})
			end
		end,
		showFunc = function()
			return g.core.model.User.splitDownloadData:isShowDownloadListPop()
		end
	},
	VIP_LINK = {
		clickFunc = function()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.VIP_LINK) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.VIP_LINK_POP)
			end
		end,
		showFunc = function()
			return g.core.model.User.vipLinkData:isShouldOpen()
		end
	}
}

var_0_1.ENTRANCE_BTN_CFG = {
	[g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_MAIN] = var_0_1.HOMELAND,
	[g.core.const.ConstMgr.FUNCTION_TYPE.GUILD] = var_0_1.GUILD,
	[g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_LINE_UP_1] = var_0_1.LINEUP,
	[g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_BAG] = var_0_1.KNIGHT_BAG,
	[g.core.const.ConstMgr.FUNCTION_TYPE.UNITE_TOKEN] = var_0_1.UNITE_TOKEN,
	[g.core.const.ConstMgr.FUNCTION_TYPE.BAG] = var_0_1.BAG,
	[g.core.const.ConstMgr.FUNCTION_TYPE.PVP_MAIN] = var_0_1.CAMPAIGN,
	[g.core.const.ConstMgr.FUNCTION_TYPE.DUNGEON_SWEEPING_1] = var_0_1.DUNGEON,
	[g.core.const.ConstMgr.FUNCTION_TYPE.PEI_ZI] = var_0_1.PEI_ZI
}
var_0_1.SETTING_BTN_CFG = {
	[g.core.const.ConstMgr.FUNCTION_TYPE.GUIDE_TASK] = var_0_1.GUIDE_TASK,
	[g.core.const.ConstMgr.FUNCTION_TYPE.ACTIVITY_SIGNIN] = var_0_1.SIGNIN,
	[g.core.const.ConstMgr.FUNCTION_TYPE.ANNOUNCE] = var_0_1.ANNOUNCE,
	[g.core.const.ConstMgr.FUNCTION_TYPE.REBORN] = var_0_1.REBORN,
	[g.core.const.ConstMgr.FUNCTION_TYPE.FRIEND] = var_0_1.FRIEND,
	[g.core.const.ConstMgr.FUNCTION_TYPE.MAIL] = var_0_1.MAIL,
	[g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_REPORT] = var_0_1.DAILY_REPORT,
	[g.core.const.ConstMgr.FUNCTION_TYPE.BIRTHDAY_CARD] = var_0_1.BIRTHDAY_CARD,
	[g.core.const.ConstMgr.FUNCTION_TYPE.TAP_TAP] = var_0_1.TAP_TAP,
	[g.core.const.ConstMgr.FUNCTION_TYPE.SUMMON_OLD_PLAYER] = var_0_1.SUMMON_OLD_PLAYER,
	[g.core.const.ConstMgr.FUNCTION_TYPE.PACKAGE_DOWNLOAD] = var_0_1.PACKAGE_DOWNLOAD,
	[g.core.const.ConstMgr.FUNCTION_TYPE.VIP_LINK] = var_0_1.VIP_LINK
}
var_0_1.ENTRANCE_DETAIL_BTN_CFG = {
	[g.core.const.ConstMgr.FUNCTION_TYPE.SHOP] = var_0_1.SHOP,
	[g.core.const.ConstMgr.FUNCTION_TYPE.RECHARGE] = var_0_1.CHARGE,
	[g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_BAG] = var_0_1.KNIGHT_BAG,
	[g.core.const.ConstMgr.FUNCTION_TYPE.UNITE_TOKEN] = var_0_1.UNITE_TOKEN,
	[g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_LINE_UP_1] = var_0_1.LINEUP,
	[g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_GENERIAL] = var_0_1.RECRUIT,
	[g.core.const.ConstMgr.FUNCTION_TYPE.DUNGEON_SWEEPING_1] = var_0_1.DUNGEON,
	[g.core.const.ConstMgr.FUNCTION_TYPE.PVP_MAIN] = var_0_1.CAMPAIGN
}
var_0_1.BAG_BTN_CFG = {
	[g.core.const.ConstMgr.FUNCTION_TYPE.GUILD] = var_0_1.GUILD,
	[g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_MAIN] = var_0_1.HOMELAND,
	[g.core.const.ConstMgr.FUNCTION_TYPE.BAG] = var_0_1.BAG
}

return var_0_1
