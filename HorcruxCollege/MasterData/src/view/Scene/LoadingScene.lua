LoadingScene = class("LoadingScene", function()
	return cc.Scene:create()
end)

local playermodel = require("model.playermodel")
local parse_server = require("controller.parse_server")
local level_manager = require("controller.level_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local recharge_manager = require("controller.recharge_manager")
local account_manager = require("controller.account_manager")
local RoleDefault = require("controller.RoleDefault")
local tips_manager = require("controller.tips_manager")
local network = require("network.network")
local net_requesting = require("network.net_requesting")
local net_dispatcher = require("network.net_dispatcher")

require("data.language_constants")

local var_0_15 = 1
local var_0_18 = 1
local var_0_19 = 2
local var_0_20 = 3
local var_0_21 = 4
local var_0_22 = 5
local var_0_23 = 6

function LoadingScene.createScene(arg_2_0, arg_2_1)
	local var_2_0 = LoadingScene.new()

	var_2_0:setName("LoadingScene")
	var_2_0:init(arg_2_1)

	return var_2_0
end

function LoadingScene:init(arg_3_1)
	self.offlinemsg = {
		exp = 0,
		gold = 0,
		time = 0,
		sp = 0
	}

	self:initNetDispatcher()
	self:initEventListener()
	require("controller.filedownloader.download_manager"):stopDownloadScheduler()
	self:startLoadingInMobile(arg_3_1)
end

function LoadingScene.initNetDispatcher(arg_4_0)
	local alert_manager = require("controller.alert_manager")
	local autopop_manager = require("controller.autopop_manager")

	net_dispatcher:registerListener(function(arg_5_0)
		alert_manager:register_alert(ALERT_TOP_PLOT)

		local task_data = require("data.task_data")

		for iter_5_0, iter_5_1 in ipairs(arg_5_0.tasks) do
			tips_manager:pushBackTipsEvent(json.encode({
				taskid = iter_5_1,
				tipsid = E_TIPS_ACHIEVEMENT
			}))
		end
	end, "new_complete_tasks")
end

function LoadingScene:startLoadingInWin32(arg_6_1)
	self.rootlayer = cc.Layer:create()

	self.rootlayer:setPosition(cc.p(GameDisplay.fix_x, GameDisplay.fix_y))
	self:addChild(self.rootlayer)

	self.showstate = var_0_15
	self.loadstate = var_0_18
	self.bg = cc.Node:create()

	self.bg:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self.rootlayer:addChild(self.bg)

	local spinecache_manager = require("controller.spinecache_manager")
	local var_6_1 = "spine/ui/loadingbg.json"
	local var_6_2 = "spine/ui/loadingbg.atlas"
	local var_6_3 = spinecache_manager:addSpineData("spine/ui/loadingbg.json", "spine/ui/loadingbg.atlas")

	var_6_3:retain()

	local var_6_4 = sp.SkeletonAnimation:create(var_6_3:getData())

	var_6_4:setName("ani")
	self.bg:addChild(var_6_4, 2)
	var_6_4:setAnimation(0, "1", false)
	var_6_4:registerSpineEventHandler(function(arg_7_0)
		if arg_7_0.animation == "1" then
			var_6_4:addAnimation(0, "2", true)
			audio_manager:playbackgroundMusic("sound/loading_part2")
		end
	end, 3)
	var_6_4:registerSpineEventHandler(function(arg_8_0)
		if arg_8_0.eventData.name == "1" then
			self.loadstate = var_0_22
		end
	end, 5)
	self.bg:registerScriptHandler(function(arg_9_0)
		if arg_9_0 == "exit" then
			var_6_3:release()
			spinecache_manager:removeSpineDataForKey(var_6_1, var_6_2)
		end
	end)

	self.netcount = 11
	self.complete_net = 0
	self.offlinecaled = false

	self:loadingInWin32(arg_6_1)
end

function LoadingScene.loadingInWin32(arg_10_0, arg_10_1)
	arg_10_0.loadScheduler = nil
	arg_10_0.co_loadspine = nil
	arg_10_0.loadScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_11_0)
		if arg_10_0.loadstate == var_0_18 then
			local function var_11_0()
				playermodel:init(arg_10_1, function()
					arg_10_0.complete_net = arg_10_0.complete_net + 1
				end)
			end

			recharge_manager:init(function()
				playermodel:initSystemAlert(var_11_0)
			end)

			arg_10_0.loadstate = var_0_19
		elseif arg_10_0.loadstate == var_0_19 then
			if arg_10_0.complete_net < arg_10_0.netcount then
				return
			end

			if playermodel.gameInitGuides[2] then
				arg_10_0:calOfflineAwards()
			else
				arg_10_0.offlinecaled = true
			end

			arg_10_0.loadstate = var_0_20
		elseif arg_10_0.loadstate == var_0_20 then
			if arg_10_0.offlinecaled then
				arg_10_0.co_loadspine = arg_10_0:startPreLoadFightSpine()
				arg_10_0.loadstate = var_0_21
			end
		elseif arg_10_0.loadstate == var_0_21 then
			if arg_10_0.co_loadspine then
				if not coroutine.resume(arg_10_0.co_loadspine) then
					arg_10_0.co_loadspine = nil
				end
			else
				arg_10_0.loadstate = var_0_23

				arg_10_0.bg:getChildByName("ani"):addAnimation(0, "3", false)
				audio_manager:playbackgroundMusic("sound/loading_part3", false)
			end
		elseif arg_10_0.loadstate == var_0_22 then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(arg_10_0.loadScheduler)
			require("view.Scene.MainScene")
			cc.Director:getInstance():replaceScene(cc.TransitionFade:create(0.5, MainScene:createScene(arg_10_0.offlinemsg), cc.c3b(0, 0, 0)))
		end
	end, 0.1, false)
end

function LoadingScene:startLoadingInMobile(arg_15_1)
	self.rootlayer = ccui.Layout:create()

	self.rootlayer:setContentSize(cc.size(SCREEN_WIDTH, SCREEN_HEIGHT))
	self:addChild(self.rootlayer)

	self.showstate = var_0_15
	self.loadstate = var_0_18
	self.bg = cc.Node:create()

	self.bg:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self.rootlayer:addChild(self.bg)

	local spinecache_manager = require("controller.spinecache_manager")
	local var_15_1 = "spine/ui/loadingbg.json"
	local var_15_2 = "spine/ui/loadingbg.atlas"
	local var_15_3 = spinecache_manager:addSpineData("spine/ui/loadingbg.json", "spine/ui/loadingbg.atlas")

	var_15_3:retain()

	local var_15_4 = sp.SkeletonAnimation:create(var_15_3:getData())

	var_15_4:setName("ani")
	self.bg:addChild(var_15_4, 2)
	var_15_4:setAnimation(0, "1", false)
	var_15_4:registerSpineEventHandler(function(arg_16_0)
		if arg_16_0.animation == "1" then
			var_15_4:addAnimation(0, "2", true)
			audio_manager:playbackgroundMusic("sound/loading_part2")
		end
	end, 3)
	var_15_4:registerSpineEventHandler(function(arg_17_0)
		if arg_17_0.eventData.name == "1" then
			self.loadstate = var_0_22
		end
	end, 5)
	self.bg:registerScriptHandler(function(arg_18_0)
		if arg_18_0 == "exit" then
			var_15_3:release()
			spinecache_manager:removeSpineDataForKey(var_15_1, var_15_2)
		end
	end)

	self.netcount = 11
	self.complete_net = 0
	self.offlinecaled = false

	self:loadingInMobile(arg_15_1)
end

function LoadingScene.loadingInMobile(arg_19_0, arg_19_1)
	arg_19_0.loadScheduler = nil
	arg_19_0.co_loadspine = nil
	arg_19_0.loadScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_20_0)
		if arg_19_0.loadstate == var_0_18 then
			local function var_20_0()
				playermodel:init(arg_19_1, function()
					arg_19_0.complete_net = arg_19_0.complete_net + 1
				end)
			end

			recharge_manager:init(function()
				playermodel:initSystemAlert(var_20_0)
			end)

			arg_19_0.loadstate = var_0_19
		elseif arg_19_0.loadstate == var_0_19 then
			if arg_19_0.complete_net < arg_19_0.netcount then
				return
			end

			arg_19_0:setPushAlias()
			arg_19_0:initAnalytic()
			AnalyticManager.setUserLevel(playermodel.grade)

			if config.packagechannel == "feiyu" then
				account_manager:onEnterGame()
			end

			if playermodel.gameInitGuides[2] then
				arg_19_0:calOfflineAwards()
			else
				arg_19_0.offlinecaled = true
			end

			arg_19_0.loadstate = var_0_20
		elseif arg_19_0.loadstate == var_0_20 then
			if arg_19_0.offlinecaled then
				arg_19_0.co_loadspine = arg_19_0:startPreLoadFightSpine()
				arg_19_0.loadstate = var_0_21
			end
		elseif arg_19_0.loadstate == var_0_21 then
			if arg_19_0.co_loadspine then
				if not coroutine.resume(arg_19_0.co_loadspine) then
					arg_19_0.co_loadspine = nil
				end
			else
				arg_19_0.loadstate = var_0_23

				arg_19_0.bg:getChildByName("ani"):addAnimation(0, "3", false)
				audio_manager:playbackgroundMusic("sound/loading_part3", false)
			end
		elseif arg_19_0.loadstate == var_0_22 then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(arg_19_0.loadScheduler)
			require("view.Scene.MainScene")
			cc.Director:getInstance():replaceScene(cc.TransitionFade:create(0.5, MainScene:createScene(arg_19_0.offlinemsg), cc.c3b(0, 0, 0)))
		end
	end, 0.1, false)
end

function LoadingScene.calOfflineAwards(arg_24_0)
	parse_server:passOfflineFight(function(arg_25_0)
		arg_24_0.offlinemsg = arg_25_0
		arg_24_0.offlinecaled = true
	end)
end

function LoadingScene:startPreLoadFightSpine()
	return self:preloadNormalFightSpine()
end

function LoadingScene.preloadGuideFightSpine(arg_27_0)
	local spinecache_manager = require("controller.spinecache_manager")
	local servant_data = require("data.servant_data")
	local model_data = require("data.model_data")
	local var_27_3 = require("view.Layer.NewGuide.GuideFightConfig"):getGuidePlayer()

	return coroutine.create(function()
		return
	end)
end

function LoadingScene.preloadNormalFightSpine(arg_29_0)
	local spinecache_manager = require("controller.spinecache_manager")
	local level_manager = require("controller.level_manager")
	local servant_data = require("data.servant_data")
	local model_data = require("data.model_data")
	local npc_fightconfig_data = require("data.npc_fightconfig_data")

	return coroutine.create(function()
		return
	end)
end

function LoadingScene:initEventListener()
	self:registerCustomEvent("LOGOUT", function(arg_32_0)
		self:logout(arg_32_0.logouttype)
	end)
	self:registerCustomEvent("APPENTERFOREGROUND", function(arg_33_0)
		self:onEnterForeground()
	end)
	self:registerCustomEvent("APPENTERBACKGROUND", function(arg_34_0)
		self:onEnterBackground()
	end)
end

function LoadingScene:registerCustomEvent(arg_35_1, arg_35_2)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create(arg_35_1, arg_35_2), self)
end

function LoadingScene.onEnterForeground(arg_36_0)
	network:checkconnection(function(arg_37_0)
		print("check connection in LoadingScene result: ", arg_37_0)

		if arg_37_0 then
			return
		end

		network:unnetschedule()
		network:disable_connect_check()
		network:missconnection()
	end)
end

function LoadingScene.onEnterBackground(arg_38_0)
	return
end

function LoadingScene:logout(arg_39_1)
	arg_39_1 = arg_39_1 or 4

	if self.loadScheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.loadScheduler)
	end

	require("controller.account_manager"):updatePlayerInfoOnLogOut()
	network:closeOnLogout()
	net_dispatcher:unregisterAllListeners()
	playermodel:resetPlayer()
	require("controller.plot_manager"):resetPlotData()

	if type(arg_39_1) == "number" then
		self:logoutByServer(arg_39_1)
	else
		self:logoutManual(arg_39_1)
	end
end

local var_0_24 = {
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

function LoadingScene:logoutByServer(arg_40_1)
	local var_40_0 = var_0_24[arg_40_1][1]
	local var_40_1 = var_0_24[arg_40_1][2]
	local var_40_2 = arg_40_1 == 3 and function()
		cc.Director:getInstance():endToLua()
	end or arg_40_1 == 5 and function()
		global_restart_game()
	end or function()
		require("view.Scene.LogoutScene")
		cc.Director:getInstance():replaceScene(LogoutScene:createScene(arg_40_1))
	end

	require("view.Layer.DialogLayer")
	self:addChild(DialogLayer:create(var_40_0, var_40_1, 500, 250, var_40_2), 10001)
end

function LoadingScene.logoutManual(arg_44_0, arg_44_1)
	require("view.Scene.LogoutScene")
	cc.Director:getInstance():replaceScene(LogoutScene:createScene(arg_44_1))
end

function PUSH_ALIAS_CALLBACK(...)
	print("###################################")
	print("test set push alias callback...")
	print(dump({
		...
	}))
	print("####################################")
end

function LoadingScene.setPushAlias(arg_46_0)
	return
end

function LoadingScene.initAnalytic(arg_47_0)
	return
end
