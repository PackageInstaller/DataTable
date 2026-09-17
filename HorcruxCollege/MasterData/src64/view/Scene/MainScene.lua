MainScene = class("MainScene", function()
	return cc.Scene:create()
end)

require("data.constants")
require("fight.fightcharacter.FightCharacter")

RoleDefault = require("controller.RoleDefault")
FightManager = require("controller.fight_manager"):create()
TextureManager = require("controller.texture_manager")
GuideListener = require("view.Layer.Guide.GuideListener")
AlertManager = require("controller.alert_manager")
SpineCacheManager = require("controller.spinecache_manager")
ZORDER_MAIN = 0
ZORDER_TALKLAYER = 5
ZORDER_RESULTLAYER = 9
ZORDER_TOUCHEFFECT = 9999
ZORDER_CHEST = 9998
ZORDER_BARRAGE = 9999

local account_manager = require("controller.account_manager")
local audio_manager = require("controller.audio_manager")
local dropcache_manager = require("controller.dropcache_manager")
local explore_manager = require("controller.explore_manager")
local parse_server = require("controller.parse_server")
local system_update_manager = require("controller.system_update_manager")
local autopop_manager = require("controller.autopop_manager")
local time_check_manager = require("controller.time_check_manager")
local tips_manager = require("controller.tips_manager")
local activity_manager = require("controller.activity_manager")
local community_system_manager = require("controller.community_system_manager")
local var_0_11 = require("controller.monopoly.monopoly_manager"):getInstance()
local role_false_level_manager = require("controller.role_false_level_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local network = require("network.network")
local net_dispatcher = require("network.net_dispatcher")

require("view.Armature.L2Skeleton")
require("controller.global_func")
require("controller.helper")
require("view.Layer.SmallFightLayer")
require("view.Layer.TouchEffectLayer")
require("view.Layer.Guide.GuideLayer")
require("view.Layer.SwitchManage.SwitchManageLayer")
require("view.Layer.BarrageLayer")
require("view.Layer.FightResultLayer")
require("view.Layer.ChestLayer")
require("view.Layer.GetRoleAnimationLayer")
require("view.Layer.TopcostLayer")
require("view.Layer.ListButtonLayer")
require("view.Layer.FightLayer")

global_basic_scene = nil
global_fight_speedup = 0

local var_0_17
local var_0_18 = cc.Label.createWithTTF

function cc.Label.createWithTTF(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	assert(arg_2_1, debug.traceback())

	return var_0_18(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
end

function MainScene.createScene(arg_3_0, arg_3_1)
	local var_3_0 = MainScene.new()

	global_basic_scene = var_3_0

	var_3_0:init(arg_3_1)

	return var_3_0
end

function MainScene:init(arg_4_1)
	self:createBG()

	self._haveshowantiaddict = false

	self:addChild(TouchEffectLayer:create(), ZORDER_TOUCHEFFECT)
	self:addChild(SwitchManageLayer:create("FightLayer"), ZORDER_MAIN)
	self:initNetDispatcher()
	self:initRechargeCheck()
	self:initKeyEvent()
	self:initEventListener()
	self:createStatusBarCover()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "enter" then
			self:onTransationEnterScene(arg_4_1)
		elseif arg_5_0 == "exit" then
			global_basic_scene = nil

			tips_manager:unScheduler()
			time_check_manager:cleanUpdatePool()
			AlertManager:clean_all_alert()
			activity_manager:cleanAllActivityAlert()
			activity_manager:removeAllActivityObj()
			var_0_11:reEnterGame()
			role_false_level_manager:restartGameClear()

			if var_0_17 then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_17)

				var_0_17 = nil
			end
		end
	end)
end

function MainScene:createBG()
	local var_6_0 = ccui.Layout:create()

	var_6_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_6_0:setPosition(cc.p(0, 0))
	var_6_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_6_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_6_0:setBackGroundColorOpacity(255)
	self:addChild(var_6_0, -1)
end

function MainScene:createStatusBarCover()
	if not GameDisplay.hasNotchInScreen() then
		return
	end

	local var_7_0 = ccui.Layout:create()

	var_7_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.statusbar_height + 10))
	var_7_0:setPosition(cc.p(0, GameDisplay.height))
	var_7_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_7_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_7_0:setBackGroundColorOpacity(255)
	var_7_0:setTouchEnabled(true)
	self:addChild(var_7_0, 20000)
end

function MainScene.initNewPlayerGuide(arg_8_0)
	if not playermodel.gameInitGuides[1] and not config.open_guidefight then
		playermodel:setPlayerGuide(-1, function()
			playermodel.gameInitGuides[1] = true
		end)
	end
end

function MainScene.initChestlayer(arg_10_0)
	local var_10_0 = 600 + math.random() * 60

	local function var_10_1(arg_11_0)
		if playermodel.level >= 0 then
			local var_11_0 = ChestLayer:create()

			var_11_0:setName("chest")
			arg_10_0:addChild(var_11_0, ZORDER_CHEST)

			var_10_0 = 600 + math.random() * 60

			if var_0_17 then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_17)
			end

			var_0_17 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_10_1, var_10_0, false)
		end
	end

	var_0_17 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_10_1, var_10_0, false)
end

function MainScene.initNetDispatcher(arg_12_0)
	net_dispatcher:registerListener(function(arg_13_0)
		for iter_13_0, iter_13_1 in pairs(arg_13_0.system) do
			if iter_13_1 == E_TIPS_TAG then
				tips_manager:pushBackTipsEvent(arg_13_0.systeminfo[iter_13_0])
			else
				AlertManager:register_alert(iter_13_1)
			end
		end
	end, "alert_client")
	net_dispatcher:registerListener(function(arg_14_0)
		FightManager.collectAllGolds()

		if arg_14_0.gold then
			playermodel.gold = checkint(arg_14_0.gold)

			global_update_gold_stone_diamond(1)
		end

		if arg_14_0.items then
			dropcache_manager:updateItemCache(arg_14_0.items, arg_14_0.dropcachetime)
		end

		if arg_14_0.exp and arg_14_0.grade then
			require("controller.grade_manager"):update_player_exp(arg_14_0.exp, arg_14_0.grade, arg_14_0.totalexp)
		end

		if arg_14_0.strengthpoint then
			playermodel.strengthpoint = arg_14_0.strengthpoint

			GlobalUpdateSp()
			AlertManager:check_servant_strenghth(true)
		end
	end, "sync_player_hangup")
	net_dispatcher:registerListener(function(arg_15_0)
		if arg_15_0.items then
			local item_manager = require("controller.item_manager")

			for iter_15_0, iter_15_1 in pairs(arg_15_0.items) do
				item_manager:setItemByServerItem(iter_15_1)
			end
		end
	end, "sync_player_item")
	net_dispatcher:registerListener(function(arg_16_0)
		if arg_16_0.items then
			local item_manager = require("controller.item_manager")
			local var_16_1, var_16_2, var_16_3, var_16_4, var_16_5, var_16_6, var_16_7, var_16_8 = global_get({
				items = arg_16_0.items
			})

			for iter_16_0, iter_16_1 in pairs(var_16_5) do
				require("controller.tips_manager"):pushBackTipsEventWithClient({
					tipsid = E_TIPS_NIANSHOU,
					itemid = iter_16_1.entityid,
					num = iter_16_1.dropNum
				})
			end
		end
	end, "sync_nianshou_item")
	net_dispatcher:registerListener(function(arg_17_0)
		activity_manager:updateActivity(arg_17_0.id, arg_17_0.msg, arg_17_0.activityinfo)
		playermodel:loadPlayerLevelModeFromServer()
	end, "subscribe_activity_msg")
	net_dispatcher:registerListener(function(arg_18_0)
		system_update_manager:update("quickfight")
		system_update_manager:update("dailytask")
		system_update_manager:update("midas")
		system_update_manager:update("dailytwist")
		system_update_manager:update("dailyexpedition")
		system_update_manager:update("dailywarorder")
		system_update_manager:update("weeklytask")
	end, "daily_update")
	net_dispatcher:registerListener(function(arg_19_0)
		activity_manager:fireEvent(activity_manager.activityEventId.WEEK_TASK_NEED_UPDATE)
	end, "weekly_update")
	net_dispatcher:registerListener(function(arg_20_0)
		network:rpc("get_reset_levelmode", nil, function(arg_21_0)
			if not arg_21_0.mode then
				return
			end

			print("refreshhhhh")
			playermodel:updateLevelMode(arg_21_0.mode)
			AlertManager:update_level_alert(arg_21_0.mode)
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("update_tablecell")))
		end)
	end, "monthly_update")
	net_dispatcher:registerListener(function(arg_22_0)
		require("controller.activity_manager"):updateActivityAlert(arg_22_0.alerttype, arg_22_0.activities)
	end, "activity_alert")
	net_dispatcher:registerListener(function(arg_23_0)
		if arg_23_0.plotinfo then
			require("controller.plot_manager"):trigger_plot_by_server(arg_23_0.plotinfo)
		end

		if arg_23_0.events then
			local event_manager = require("controller.event_manager")

			plotManager:trigger_event_by_server(arg_23_0.events)
		end
	end, "timing_trigger_plot")
	net_dispatcher:registerListener(function(arg_24_0)
		local activity_manager = require("controller.activity_manager")

		RoleDefault:getInstance():setBoolForKey("NewFriendApplyHave", true)
		activity_manager:fireEvent(activity_manager.activityEventId.FRIEND_NEW_APPLY_NOTICE)
	end, "friend_new_application")
	net_dispatcher:registerListener(function(arg_25_0)
		local activity_manager = require("controller.activity_manager")

		RoleDefault:getInstance():setBoolForKey("NewFriendGiftHave", true)
		activity_manager:fireEvent(activity_manager.activityEventId.FRIEND_NEW_Gift_NOTICE, arg_25_0)
	end, "friend_new_gift")
	net_dispatcher:registerListener(function(arg_26_0)
		local activity_manager = require("controller.activity_manager")

		activity_manager:fireEvent(activity_manager.activityEventId.COMMUNITY_CHANGE_POSITION, arg_26_0)
	end, "family_title_change_notice")
	net_dispatcher:registerListener(function(arg_27_0)
		local activity_manager = require("controller.activity_manager")

		community_system_manager:resetAllStatus()
		community_system_manager:get_family_data()
		community_system_manager:updateCommunityChatData(2)
		activity_manager:fireEvent(activity_manager.activityEventId.COMMUNITY_KICK_NOTICE, arg_27_0)
	end, "family_kick_notice")
	net_dispatcher:registerListener(function(arg_28_0)
		local activity_manager = require("controller.activity_manager")

		community_system_manager:get_family_data()
		activity_manager:fireEvent(activity_manager.activityEventId.COMMUNITY_JOIN_COMMNITY, arg_28_0)
	end, "family_enter_notice")
	net_dispatcher:registerListener(function(arg_29_0)
		local activity_manager = require("controller.activity_manager")

		community_system_manager:updateCommunityChatData(arg_29_0.list)
		activity_manager:fireEvent(activity_manager.activityEventId.UPATATE_COMMITY_CHATE_DATA, arg_29_0)
	end, "family_chat_notice")
	net_dispatcher:registerListener(function(arg_30_0)
		local activity_manager = require("controller.activity_manager")

		activity_manager:fireEvent(activity_manager.activityEventId.UPATATE_CHATE_DATA, arg_30_0)
		activity_manager:fireEvent(activity_manager.activityEventId.HAVE_PRIVATE_CHATE_DATA, {
			info = {
				private_new = true
			}
		})
	end, "chat_new_private_message")
	net_dispatcher:registerListener(function(arg_31_0)
		dropcache_manager:syncDropCacheTime(arg_31_0.dropcachetime)
	end, "sync_dropcache_time")
	net_dispatcher:registerListener(function(arg_32_0)
		if arg_32_0.client_not_pop then
			global_get(arg_32_0)
		else
			global_gain(arg_32_0)
		end
	end, "notice_add_item")
	net_dispatcher:registerListener(function(arg_33_0)
		local item_manager = require("controller.item_manager")

		for iter_33_0, iter_33_1 in pairs(arg_33_0.consumes) do
			item_manager:deleteItem(iter_33_1.entityid, iter_33_1.num)
		end

		playermodel.diamond = playermodel.diamond - arg_33_0.diamond
		playermodel.gold = playermodel.gold - arg_33_0.gold

		global_update_gold_stone_diamond(nil, nil, arg_33_0.diamond)
	end, "notice_delete_item")

	if config.packagechannel == "palmpi" then
		net_dispatcher:registerListener(function(arg_34_0)
			print("-----------------【服务器错误】-------------------")
			print(dump(arg_34_0))
			print("--------------------------------------------------")
		end, "service_error")
	end

	net_dispatcher:registerListener(function(arg_35_0)
		local activity_manager = require("controller.activity_manager")

		if arg_35_0.tp then
			require("controller.community_system_manager"):updateRecordRedStatus(arg_35_0.tp)
		end

		activity_manager:fireEvent(activity_manager.activityEventId.COMMUNITY_WISH_NEW_AWARD, arg_35_0)
	end, "family_wish_notice")
	net_dispatcher:registerListener(function(arg_36_0)
		local playermodel = require("model.playermodel")

		playermodel.dropcacheweight.limit = arg_36_0.cachelimit
		playermodel.bagweight = (function(arg_37_0)
			local var_37_0 = {}

			while arg_37_0[1 * 2] do
				var_37_0[1] = {
					weight = tonumber(arg_37_0[1 * 2 - 1]),
					limit = tonumber(arg_37_0[1 * 2])
				}
			end

			return var_37_0
		end)(arg_36_0.bagweight)
	end, "sync_bagweight")
	net_dispatcher:registerListener(function(arg_38_0)
		local playermodel = require("model.playermodel")

		playermodel.horcruxDevour[arg_38_0.id] = {}

		for iter_38_0 = 1, HORCRUX_DEVOUR_MAX do
			playermodel.horcruxDevour[arg_38_0.id][iter_38_0] = arg_38_0.horcruxs[iter_38_0] and arg_38_0.horcruxs[iter_38_0] or {}
		end

		sendNotification("HorcruxDevourChenge", arg_38_0)
	end, "sync_servant_horcrux")
end

function MainScene:initRechargeCheck()
	self:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		require("controller.recharge_manager"):checkalert()
	end)))
end

function MainScene.initKeyEvent(arg_41_0)
	KeyCodeManager:initWithScene(arg_41_0)
end

local function var_0_19(arg_42_0)
	if arg_42_0 >= 86400 then
		return string.format(L_TIME_FORMAT_DAYHOURMIN, math.floor(arg_42_0 / 86400), math.floor(arg_42_0 % 86400 / 3600), math.floor(arg_42_0 % 3600 / 60))
	elseif arg_42_0 >= 3600 then
		return string.format(L_TIME_FORMAT_HOURMINSEC, math.floor(arg_42_0 / 3600), math.floor(arg_42_0 % 3600 / 60), arg_42_0 % 60)
	else
		return string.format(L_TIME_FORMAT_MINSEC, math.floor(arg_42_0 / 60), math.floor(arg_42_0 % 60))
	end
end

local function var_0_20(arg_43_0)
	local var_43_0 = 86400

	if playermodel.ycard_last_afk_vaild then
		var_43_0 = var_43_0 + require("data.recharge_data")[365].offline_time_add * 3600
	end

	if var_43_0 <= arg_43_0 then
		return var_43_0 / 3600
	else
		return false
	end
end

local function var_0_21(arg_44_0)
	local var_44_0, var_44_1 = arg_44_0:match("(%d+)-(%d+)")

	return tonumber(var_44_0), tonumber(var_44_1)
end

function MainScene:onTransationEnterScene(arg_45_1)
	if playermodel.gameInitGuides[2] then
		local activity_manager = require("controller.activity_manager")

		if activity_manager:haveActivityPV() then
			activity_manager:playActivityPV()
		end
	end

	local var_45_1 = self:getChildByName("SwitchManageLayer")

	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		var_45_1:addFirstLayer()
	end), cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		require("controller.filedownloader.download_manager"):startDownloadScheduler()
	end), cc.DelayTime:create(1), cc.CallFunc:create(function()
		autopop_manager:resumeAchievementPop()

		if not playermodel.gameInitGuides[2] then
			return
		end

		local OfflineEarningsLayer = require("view.Layer.OfflineEarningsLayer")
		local level_manager = require("controller.level_manager")
		local var_48_2 = var_0_21(playermodel.curLevel)

		LayerManager:pushInLayer("OfflineEarningsLayer", {
			time = var_0_19(arg_45_1.time),
			isOuttime = var_0_20(arg_45_1.time),
			levelinfo = level_manager:getModeName(playermodel.curMode) .. level_manager:getChapterName(playermodel.curMode, var_48_2),
			gold = arg_45_1.gold,
			sp = arg_45_1.sp
		})
		AnalyticManager.entergamesuccess({
			city = playermodel.curMode .. "-" .. var_48_2,
			grade = playermodel.grade,
			class = playermodel.class
		})
	end)))
end

function MainScene:enterSceneWithGuide()
	local var_49_0 = self:getChildByName("SwitchManageLayer")

	var_49_0:addLayerForElements("TopcostLayer")
	var_49_0:addLayerForElements("ListButton")
	var_49_0:addFirstLayer()
	autopop_manager:resumeAchievementPop()
end

function MainScene:addFallGoldEffect()
	local var_50_0 = cc.ParticleSystemQuad:create("effect/particle/fallgold.plist")

	var_50_0:setAutoRemoveOnFinish(true)
	var_50_0:setPosition(cc.p(320, 568))
	self:addChild(var_50_0, 999)
end

function MainScene.onEnterForeground(arg_51_0, arg_51_1)
	network:checkconnection(function(arg_52_0)
		print("check connection result: ", arg_52_0)

		if arg_52_0 then
			time_check_manager:reset()

			return
		end

		network:unnetschedule()
		network:disable_connect_check()
		network:missconnection()
	end)
end

function MainScene.onEnterBackground(arg_53_0)
	return
end

function MainScene:logout(arg_54_1)
	arg_54_1 = arg_54_1 or 4

	account_manager:updatePlayerInfoOnLogOut()
	network:closeOnLogout()
	net_dispatcher:unregisterAllListeners()
	FightManager.releaseAllCharacter()
	playermodel:resetPlayer()
	PlotManager:resetPlotData()

	if type(arg_54_1) == "number" then
		self:logoutByServer(arg_54_1)
	else
		self:logoutManual(arg_54_1)
	end

	require("controller.servant_rank_manager").destroyInstance()
end

local var_0_22 = {
	{
		L_LOGOUT_MSG[1].Title,
		L_LOGOUT_MSG[1].Info
	},
	{
		L_LOGOUT_MSG[2].Title,
		L_LOGOUT_MSG[2].Info
	},
	{
		L_LOGOUT_MSG[3].Title,
		L_LOGOUT_MSG[3].Info
	},
	{
		L_LOGOUT_MSG[4].Title,
		L_LOGOUT_MSG[4].Info
	},
	{
		L_LOGOUT_MSG[5].Title,
		L_LOGOUT_MSG[5].Info
	},
	{
		L_LOGOUT_MSG[6].Title,
		L_LOGOUT_MSG[6].Info
	}
}

function MainScene:logoutByServer(arg_55_1)
	local var_55_0 = var_0_22[arg_55_1][1]
	local var_55_1 = var_0_22[arg_55_1][2]
	local var_55_2 = arg_55_1 == 3 and function()
		cc.Director:getInstance():endToLua()
	end or arg_55_1 == 5 and function()
		global_restart_game()
	end or function()
		global_restart_game()
	end

	require("view.Layer.DialogLayer")
	self:addChild(DialogLayer:create(var_55_0, var_55_1, 500, 250, var_55_2), 10001)
end

function MainScene.logoutManual(arg_59_0, arg_59_1)
	require("view.Scene.LoginScene")
	cc.Director:getInstance():replaceScene(LoginScene:createScene(arg_59_1))
end

function MainScene:initEventListener()
	self:registerCustomEvent("LOGOUT", function(arg_61_0)
		self:logout(arg_61_0.logouttype)
	end)
	self:registerCustomEvent("APPENTERFOREGROUND", function(arg_62_0)
		self:onEnterForeground()
	end)
	self:registerCustomEvent("APPENTERBACKGROUND", function(arg_63_0)
		self:onEnterBackground()
	end)
	self:registerCustomEvent("syncFightPower", function(arg_64_0)
		GlobalUpdateContractAttr()
	end)
end

function MainScene:registerCustomEvent(arg_65_1, arg_65_2)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create(arg_65_1, arg_65_2), self)
end
