local var_0_0 = {}

require("controller.activitymodules.activity_constants_manager")

local activity_img_data = require("data.activity_img_data")
local activity_conf_data = require("data.activity_conf_data")
local activity_entrance_data = require("data.activity_entrance_data")
local network = require("network.network")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local account_manager = require("controller.account_manager")

var_0_0.activities = {}

function var_0_0:initCurrentActivities(arg_3_1)
	network:rpc("get_current_activities", nil, function(arg_4_0)
		if not arg_4_0.list then
			return
		end

		for iter_4_0, iter_4_1 in ipairs(arg_4_0.list) do
			self:insertActivity(iter_4_1)
			self:check_once_alert(iter_4_1)
		end

		if arg_3_1 then
			arg_3_1()
		end
	end)
	self:checkNewActivityList()
end

function var_0_0:check_once_alert(arg_5_1)
	self:update_alert(arg_5_1.id, "once")
end

function var_0_0:updateActivity(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 == "START" then
		self:insertActivity(arg_6_3 or {
			id = arg_6_1,
			status = ACTIVITY_ACTIVING
		})
		self.activities[arg_6_1]:updateOnOpen()
	elseif arg_6_2 == "FINISH" then
		if not self.activities[arg_6_1] then
			return
		end

		if self.activities[arg_6_1]:canCloseDirectly() then
			self.activities[arg_6_1]:setStatus(ACTIVITY_CLOSED)
			self.activities[arg_6_1]:updateOnClose()
		else
			self.activities[arg_6_1]:setStatus(ACTIVITY_ENDED)
		end
	end

	self:updateActivityEntranceList()
	self:fireEvent(var_0_0.activityEventId.ACTIVITY_STATE_CHANGED)
end

function var_0_0:getCurrentActivites()
	return self.activities
end

function var_0_0:getActivityObj(arg_8_1)
	return self.activities[arg_8_1]
end

function var_0_0.removeAllActivityObj(arg_9_0)
	arg_9_0.activities = {}
	arg_9_0.entranceList = {}
end

function var_0_0:insertActivity(arg_10_1)
	self.activities[arg_10_1.id] = require("controller.activitymodules.activityobjmodules.activityobj").new(arg_10_1.id, arg_10_1.status, arg_10_1.modules, arg_10_1.module_stat)

	if arg_10_1.starttime then
		self.activities[arg_10_1.id].starttime = arg_10_1.starttime
	end

	if arg_10_1.finishtime then
		self.activities[arg_10_1.id].finishtime = arg_10_1.finishtime
	end

	self:initActivityModules(arg_10_1.id, self.activities[arg_10_1.id])
end

function var_0_0:getMainlayerList()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(self.activities) do
		if iter_11_1:isCanShow() then
			var_11_0[iter_11_0] = self.activities[iter_11_0]
		end
	end

	return var_11_0
end

function var_0_0:getActivityEntranceList()
	return self.entranceList
end

function var_0_0:getActivityEntranceListByType(arg_13_1)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(self.entranceList) do
		if iter_13_1.init_type == arg_13_1 then
			table.insert(var_13_0, iter_13_1)
		end
	end

	return var_13_0
end

function var_0_0.getActivityEntranceListFromServer(arg_14_0, arg_14_1)
	network:rpc("get_activity_entrance_list", {
		channelid = require("controller.account_manager"):getChannel()
	}, function(arg_15_0)
		if arg_14_1 then
			arg_14_1(arg_15_0.fullinfo, arg_15_0)
		end
	end)
end

function var_0_0:updateActivityEntranceList()
	self.entranceList = {}

	local function var_16_0(arg_17_0)
		return
	end

	local function var_16_1(arg_18_0)
		activity_entrance_data = {}

		for iter_18_0, iter_18_1 in pairs(arg_18_0) do
			local var_18_0 = json.decode(iter_18_1)

			activity_entrance_data[var_18_0.id] = var_18_0
			self.entranceList[var_18_0.id] = var_18_0
		end

		for iter_18_2, iter_18_3 in pairs(self.entranceList) do
			if activity_entrance_data[iter_18_2].configId and not self.activities[activity_entrance_data[iter_18_2].configId] then
				self.entranceList[iter_18_2] = nil
			end
		end
	end

	self:getActivityEntranceListFromServer(function(arg_20_0, arg_20_1)
		if arg_20_0 then
			var_16_1(arg_20_1.entrancelist)
		else
			var_16_0(arg_20_1.list)
		end

		self:fireEvent(self.activityEventId.ACTIVITY_ENTRANCE_LIST_UPDATE)
	end)
end

function var_0_0.insertBrthActivity(arg_21_0)
	return
end

function var_0_0.createActivitySignLayer(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = var_0_0:getActivityListData()[arg_22_1].list
	local var_22_1

	if not next(var_22_0) then
		do return end

		var_22_1 = {
			jumpbackID = 1200
		}
	end

	var_22_1.id = var_22_0[arg_22_2].id
	var_22_1.activityID = arg_22_1
	var_22_1.activity_type = var_22_0[arg_22_2].activity_type
	var_22_1.systemid = var_22_0[arg_22_2].systemid
	var_22_1.callback = nil
	var_22_1.initParam = arg_22_3

	require("view.Layer.ActivityManageLayer")
	ActivityManageLayer:create(var_22_1)
end

function var_0_0.getActivityListData(arg_23_0)
	local var_23_0 = {}

	local function var_23_1(arg_24_0, arg_24_1)
		while activity_conf_data[arg_24_0][arg_24_1 .. 1] do
			while activity_img_data[arg_24_0] and activity_img_data[arg_24_0]["id" .. 1] do
				if activity_img_data[arg_24_0]["id" .. 1] == activity_conf_data[arg_24_0][arg_24_1 .. 1] then
					var_23_0[arg_24_0].list[1] = {
						id = activity_conf_data[arg_24_0][arg_24_1 .. 1],
						activity_type = arg_24_1 .. 1
					}
					var_23_0[arg_24_0].list[1].img = activity_img_data[arg_24_0]["img" .. 1] or nil
					var_23_0[arg_24_0].list[1].systemid = activity_img_data[arg_24_0]["systemid" .. 1] or nil

					break
				end
			end
		end
	end

	for iter_23_0, iter_23_1 in pairs(activity_conf_data) do
		var_23_0[iter_23_0] = {
			finishtime = 0,
			starttime = 0,
			list = {}
		}
		var_23_0[iter_23_0].starttime = activity_conf_data[iter_23_0].starttime
		var_23_0[iter_23_0].finishtime = activity_conf_data[iter_23_0].finishtime

		if activity_conf_data[iter_23_0].proceed and activity_conf_data[iter_23_0].proceed ~= 0 then
			var_23_1(iter_23_0, "proceed_id")
		end

		if activity_conf_data[iter_23_0].task and activity_conf_data[iter_23_0].task ~= 0 then
			var_23_1(iter_23_0, "task_id")
		end

		if activity_conf_data[iter_23_0].sign and activity_conf_data[iter_23_0].sign ~= 0 then
			var_23_1(iter_23_0, "sign_id")
		end

		if activity_conf_data[iter_23_0].levelmode and activity_conf_data[iter_23_0].levelmode ~= 0 then
			var_23_1(iter_23_0, "levelmode_id")
		end

		if activity_conf_data[iter_23_0].shoptype and activity_conf_data[iter_23_0].shoptype ~= 0 then
			var_23_1(iter_23_0, "shoptype_id")
		end

		if activity_conf_data[iter_23_0].markettype and activity_conf_data[iter_23_0].markettype ~= 0 then
			var_23_1(iter_23_0, "markettype_id")
		end

		if activity_conf_data[iter_23_0].twisttype and activity_conf_data[iter_23_0].twisttype ~= 0 then
			var_23_1(iter_23_0, "twisttype_id")
		end

		if activity_conf_data[iter_23_0].twsittype and activity_conf_data[iter_23_0].twsittype ~= 0 then
			var_23_1(iter_23_0, "twsittype_id")
		end

		if activity_conf_data[iter_23_0].exploretype and activity_conf_data[iter_23_0].exploretype ~= 0 then
			var_23_1(iter_23_0, "exploretype_id")
		end
	end

	return var_23_0
end

function var_0_0:getExplorefile(arg_25_1)
	return self.activities[arg_25_1]:getExplorefile()
end

function var_0_0.initActivityModules(arg_26_0, arg_26_1)
	return
end

local var_0_9 = {
	{
		id = 115,
		pv = "video/awl.mp4"
	},
	{
		name = "pikabirth",
		finishtime = "2020-06-21 00:00:00",
		pv = "video/pikabirth.mp4",
		starttime = "2020-06-20 00:00:00"
	},
	{
		name = "xiaimubirth",
		finishtime = "2020-06-27 00:00:00",
		pv = "video/xiaimubirth.mp4",
		starttime = "2020-06-25 00:00:00"
	},
	{
		name = "luokena",
		finishtime = "2020-07-10 23:59:59",
		pv = "video/luokena.mp4",
		starttime = "2020-06-22 00:00:00"
	},
	{
		name = "overdrive2",
		finishtime = "2020-07-05 00:00:00",
		pv = "video/overdrive2.mp4",
		starttime = "2020-06-20 00:00:00"
	},
	{
		name = "tifabirth",
		finishtime = "2020-07-14 00:00:00",
		pv = "video/tifabirth.mp4",
		starttime = "2020-07-11 00:00:00"
	},
	{
		name = "yidisibirth",
		finishtime = "2020-07-21 00:00:00",
		pv = "video/yidisibirth.mp4",
		starttime = "2020-07-19 00:00:00"
	},
	{
		name = "yidisibirth",
		finishtime = "2020-07-22 00:00:00",
		pv = "video/yidisibirth.mp4",
		starttime = "2020-07-19 00:00:00"
	},
	{
		name = "overdriveve3",
		finishtime = "2020-07-27 00:00:00",
		pv = "video/overdriveve3.mp4",
		starttime = "2020-07-17 00:00:00"
	},
	{
		name = "xialuotebirth",
		finishtime = "2020-08-03 00:00:00",
		pv = "video/xialuotebirth.mp4",
		starttime = "2020-07-31 00:00:00"
	}
}

local function var_0_10()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs((require("data.pv_conf_data"))) do
		if not iter_27_1.unlocklevel or playermodel.grade > iter_27_1.unlocklevel then
			table.insert(var_27_0, {
				starttime = iter_27_1.starttime,
				finishtime = iter_27_1.finishtime,
				name = iter_27_1.id,
				pv = iter_27_1.pv,
				order = iter_27_1.order
			})
		end
	end

	table.sort(var_27_0, function(arg_28_0, arg_28_1)
		return arg_28_0.order > arg_28_1.order
	end)

	for iter_27_2, iter_27_3 in ipairs(var_27_0) do
		table.insert(var_0_9, iter_27_3)
	end
end

function var_0_0:haveActivityPV()
	var_0_10()

	if DeviceManager.platform == "windows" then
		return false
	end

	local var_29_0 = os.time()

	for iter_29_0, iter_29_1 in ipairs(var_0_9) do
		if iter_29_1.id then
			local var_29_1 = self:getActivityObj(iter_29_1.id)

			if var_29_1 and var_29_1:getStatus() == ACTIVITY_ACTIVING then
				if not cc.FileUtils:getInstance():isFileExist(iter_29_1.pv) then
					if cc.FileUtils:getInstance():isFileExist("res/localvideo/" .. iter_29_1.pv) then
						if not cc.UserDefault:getInstance():getBoolForKey("pv" .. iter_29_1.id, false) then
							return true
						end

						goto label_29_0
					end
				end

				local var_29_2, var_29_3, var_29_4, var_29_5, var_29_6, var_29_7 = iter_29_1.starttime:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
				local var_29_8 = os.time({
					year = var_29_2,
					month = var_29_3,
					day = var_29_4,
					hour = var_29_5,
					min = var_29_6,
					sec = var_29_7
				})
				local var_29_9, var_29_10, var_29_11, var_29_12, var_29_13, var_29_14 = iter_29_1.finishtime:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")

				if var_29_8 <= var_29_0 and var_29_0 <= os.time({
					year = var_29_9,
					month = var_29_10,
					day = var_29_11,
					hour = var_29_12,
					min = var_29_13,
					sec = var_29_14
				}) then
					if not cc.FileUtils:getInstance():isFileExist(iter_29_1.pv) then
						if cc.FileUtils:getInstance():isFileExist("res/localvideo/" .. iter_29_1.pv) then
							if not cc.UserDefault:getInstance():getBoolForKey("pv" .. iter_29_1.name, false) then
								return true
							end
						end
					end
				end
			end
		end

		::label_29_0::
	end

	return false
end

function var_0_0:playActivityPV()
	if DeviceManager.platform == "windows" then
		return
	end

	local var_30_0
	local var_30_1 = os.time()

	for iter_30_0, iter_30_1 in ipairs(var_0_9) do
		if iter_30_1.id then
			local var_30_2 = self:getActivityObj(iter_30_1.id)

			if var_30_2 and var_30_2:getStatus() == ACTIVITY_ACTIVING then
				if not cc.FileUtils:getInstance():isFileExist(iter_30_1.pv) then
					if cc.FileUtils:getInstance():isFileExist("res/localvideo/" .. iter_30_1.pv) then
						if not cc.UserDefault:getInstance():getBoolForKey("pv" .. iter_30_1.id, false) then
							var_30_0 = iter_30_1

							break
						end

						goto label_30_0
					end
				end

				local var_30_3, var_30_4, var_30_5, var_30_6, var_30_7, var_30_8 = iter_30_1.starttime:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
				local var_30_9 = os.time({
					year = var_30_3,
					month = var_30_4,
					day = var_30_5,
					hour = var_30_6,
					min = var_30_7,
					sec = var_30_8
				})
				local var_30_10, var_30_11, var_30_12, var_30_13, var_30_14, var_30_15 = iter_30_1.finishtime:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")

				if var_30_9 <= var_30_1 and var_30_1 <= os.time({
					year = var_30_10,
					month = var_30_11,
					day = var_30_12,
					hour = var_30_13,
					min = var_30_14,
					sec = var_30_15
				}) then
					if not cc.FileUtils:getInstance():isFileExist(iter_30_1.pv) then
						if cc.FileUtils:getInstance():isFileExist("res/localvideo/" .. iter_30_1.pv) then
							if not cc.UserDefault:getInstance():getBoolForKey("pv" .. iter_30_1.name, false) then
								var_30_0 = iter_30_1

								break
							end
						end
					end
				end
			end
		end

		::label_30_0::
	end

	if not var_30_0 then
		return
	end

	require("view.Layer.VideoPlayerLayer")

	local audio_manager = require("controller.audio_manager")
	local var_30_17 = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), 640, 1136)

	var_30_17:setAnchorPoint(cc.p(0, 0))
	var_30_17:setPosition(cc.p(0, 0))
	global_basic_scene:addChild(var_30_17, ZORDER_TALKLAYER - 1)

	local var_30_18 = audio_manager.music_volume
	local var_30_19 = audio_manager.effect_volume

	audio_manager.music_volume = 0
	audio_manager.effect_volume = 0

	audio_manager:setMusicVolume()

	local var_30_20 = VideoPlayerLayer:create(var_30_0.pv)

	global_basic_scene:addChild(var_30_20, ZORDER_TALKLAYER)

	if var_30_0.id then
		cc.UserDefault:getInstance():setBoolForKey("pv" .. var_30_0.id, true)
	else
		cc.UserDefault:getInstance():setBoolForKey("pv" .. var_30_0.name, true)
	end

	if var_30_20.addSkipButtonWithParameter then
		var_30_20:addSkipButtonWithParameter("1", "1", "0", "0", "3", "mainScenebg/new_skip.png")
	end

	local var_30_21 = false

	local function var_30_22()
		if var_30_21 then
			return
		end

		var_30_21 = true

		var_30_20:runAction(cc.RemoveSelf:create())
		var_30_17:runAction(cc.RemoveSelf:create())

		audio_manager.music_volume = var_30_18
		audio_manager.effect_volume = var_30_19

		audio_manager:setMusicVolume()
	end

	var_30_20:registerEventHandler(3, var_30_22)
	var_30_20:registerEventHandler(2, var_30_22)
	var_30_20:play()
end

function var_0_0.buy_shop_timelimit(arg_32_0, arg_32_1, arg_32_2)
	network:rpc("buy_shop_timelimit", {
		id = arg_32_1
	}, function(arg_33_0)
		if arg_33_0.result == 1 then
			if arg_33_0.consumes then
				for iter_33_0, iter_33_1 in pairs(arg_33_0.consumes) do
					item_manager:deleteItem(iter_33_1.entityid, iter_33_1.num)
				end
			end

			global_gain(arg_33_0)
			global_update_gold_stone_diamond(nil, nil, arg_32_0.diamond)
		end

		if arg_32_2 then
			arg_32_2(arg_33_0, arg_32_2)
		end
	end)
end

function var_0_0:setShopTimeLimitHaveBought(arg_34_1)
	self.shopTimeLimitHaveBought = self.shopTimeLimitHaveBought or {}
	self.shopTimeLimitHaveBought[playermodel.playerid .. "_" .. arg_34_1] = 1
end

function var_0_0:getShopTimeLimitHaveBought(arg_35_1)
	if self.shopTimeLimitHaveBought and self.shopTimeLimitHaveBought[playermodel.playerid .. "_" .. arg_35_1] then
		return self.shopTimeLimitHaveBought[playermodel.playerid .. "_" .. arg_35_1]
	end
end

function var_0_0.isNewVersionActivity(arg_36_0, arg_36_1)
	if not arg_36_1 then
		return false
	end

	return tonumber(activity_conf_data[arg_36_1].version) == 2
end

function var_0_0:getActivityTaskList(arg_37_1, ...)
	local var_37_0 = self:getActivityObj(arg_37_1)

	if not var_37_0 then
		return
	end

	var_37_0:getActivityTaskList(...)
end

function var_0_0:getTaskReward(arg_38_1, ...)
	local var_38_0 = self:getActivityObj(arg_38_1)

	if not var_38_0 then
		return
	end

	var_38_0:getTaskReward(...)
end

function var_0_0:buyWakeFundVip(arg_39_1, ...)
	local var_39_0 = self:getActivityObj(arg_39_1)

	if not var_39_0 then
		return
	end

	var_39_0:buyWakeFundVip(...)
end

function var_0_0:getActivityProceed(arg_40_1, ...)
	local var_40_0 = self:getActivityObj(arg_40_1)

	if not var_40_0 then
		return
	end

	var_40_0:getActivityProceed(...)
end

function var_0_0:getActivityProceedAward(arg_41_1, ...)
	local var_41_0 = self:getActivityObj(arg_41_1)

	if not var_41_0 then
		return
	end

	var_41_0:getActivityProceedAward(...)
end

function var_0_0:collectActivityItems(arg_42_1, ...)
	local var_42_0 = self:getActivityObj(arg_42_1)

	if not var_42_0 then
		return
	end

	var_42_0:collectActivityItems(...)
end

function var_0_0:getActivityCollectStatus(arg_43_1, ...)
	local var_43_0 = self:getActivityObj(arg_43_1)

	if not var_43_0 then
		return
	end

	var_43_0:getActivityCollectStatus(...)
end

function var_0_0:get_collection_status(arg_44_1, ...)
	local var_44_0 = self:getActivityObj(arg_44_1)

	if not var_44_0 then
		return
	end

	var_44_0:get_collection_status(...)
end

function var_0_0:get_collection_reward(arg_45_1, ...)
	local var_45_0 = self:getActivityObj(arg_45_1)

	if not var_45_0 then
		return
	end

	var_45_0:get_collection_reward(...)
end

function var_0_0:is_module_stat_finished(arg_46_1, ...)
	local var_46_0 = self:getActivityObj(arg_46_1)

	if not var_46_0 then
		return true
	end

	return var_46_0:is_module_stat_finished(...)
end

function var_0_0:update_module_stat(arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = self:getActivityObj(arg_47_1)

	local function var_47_1(arg_48_0)
		local var_48_0 = cc.EventCustom:new("UPDATE_AC_MODULE_STAT")

		var_48_0.activityid = arg_47_1
		var_48_0.module = arg_47_2
		var_48_0.stat = arg_48_0

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_48_0)
	end

	local var_47_2 = {
		wake_fund = function(arg_49_0)
			local task_data = require("data.task_data")
			local var_49_1 = true

			for iter_49_0, iter_49_1 in pairs(arg_49_0) do
				if iter_49_1.status == 0 then
					var_49_1 = false

					break
				end

				if (iter_49_1.status == 1 or iter_49_1.status == 2) and task_data[iter_49_1.taskid].extra_drop and iter_49_1.extra_award == 0 or task_data[iter_49_1.taskid].free_extra_drop and iter_49_1.free_extra_award == 0 then
					var_49_1 = false

					break
				end
			end

			var_47_0:update_module_stat(arg_47_2, var_49_1)
			var_47_1()
		end
	}

	if type(arg_47_3) == "boolean" then
		var_47_0:update_module_stat(arg_47_2, arg_47_3)
		var_47_1()
	elseif var_47_2[arg_47_2] then
		var_47_2[arg_47_2](arg_47_3)
	end
end

function var_0_0:get_finishtime(arg_50_1)
	return self:getActivityObj(arg_50_1):get_finishtime()
end

function var_0_0.get_activity_session(arg_51_0, arg_51_1)
	network:rpc("get_activity_session", nil, function(arg_52_0)
		if arg_52_0.result == 1 then
			local var_52_0 = string.format("https://h-college.737.com/act/vote/m/page_inner.html?session=%s&server_id=%s", arg_52_0.session, "s" .. require("controller.account_manager"):getServerID())

			if DeviceManager.platform == "windows" then
				DeviceManager.openURL(var_52_0)
			elseif arg_51_1 then
				arg_51_1(var_52_0)
			end
		end
	end)
end

function var_0_0.get_activity_memory_session(arg_53_0, arg_53_1, arg_53_2)
	local function var_53_0(arg_54_0)
		return cc.Crypto:MD5(string.format("session=%ssid=%s", arg_54_0.session, "s" .. account_manager:getServerID()) .. "EbUHvyzLZG0gNjO6ttkuEqzFYFb9nJCo", false, false)
	end

	network:rpc("get_activity_session", nil, function(arg_56_0)
		if arg_56_0.result == 1 then
			global_basic_scene:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
				local var_57_0 = WEBSTR[arg_53_1].url:match("?(.+)$")
				local var_57_1 = WEBSTR[arg_53_1].url

				if DeviceManager.platform == "windows" or WEBSTR[arg_53_1].type == WEB_TYPE_BROWSER then
					var_57_1 = DeviceManager.platform == "ios" and WEBSTR[arg_53_1].short_url or var_57_1

					if WEBSTR[arg_53_1].channelid then
						for iter_57_0, iter_57_1 in pairs(WEBSTR[arg_53_1].channelid) do
							var_57_1 = iter_57_1 == DeviceManager:getChannelID() and WEBSTR[arg_53_1].channelurl[iter_57_0] or var_57_1
						end
					end

					DeviceManager.openURL(var_57_1)
				elseif arg_53_2 then
					arg_53_2(var_57_1)
				end
			end)))
		end
	end)
end

function var_0_0:getActivitySign(arg_58_1, ...)
	local var_58_0 = self:getActivityObj(arg_58_1)

	if not var_58_0 then
		return
	end

	var_58_0:getActivitySign(...)
end

function var_0_0:activitySign(arg_59_1, ...)
	local var_59_0 = self:getActivityObj(arg_59_1)

	if not var_59_0 then
		return
	end

	var_59_0:activitySign(...)
end

function var_0_0:get_activity_shopitem(arg_60_1, ...)
	local var_60_0 = self:getActivityObj(arg_60_1)

	if not var_60_0 then
		return
	end

	var_60_0:get_activity_shopitem(...)
end

function var_0_0:rechargeForShopItem(arg_61_1, arg_61_2)
	local var_61_0 = self:getActivityObj(arg_61_1)

	if not var_61_0 then
		return
	end

	var_61_0:rechargeForShopItem(arg_61_2)
end

function var_0_0:buyActivityItem(arg_62_1, arg_62_2)
	local var_62_0 = self:getActivityObj(arg_62_1)

	if not var_62_0 then
		return
	end

	var_62_0:buyActivityItem(arg_62_2)
end

function var_0_0:get_activity_explore(arg_63_1, ...)
	local var_63_0 = self:getActivityObj(arg_63_1)

	if not var_63_0 then
		return
	end

	var_63_0:get_activity_explore(...)
end

function var_0_0:getExploreFinishTime(arg_64_1, ...)
	local var_64_0 = self:getActivityObj(arg_64_1)

	if not var_64_0 then
		return
	end

	var_64_0:getExploreFinishTime(...)
end

function var_0_0:activity_buy_explore_times(arg_65_1, ...)
	local var_65_0 = self:getActivityObj(arg_65_1)

	if not var_65_0 then
		return
	end

	var_65_0:activity_buy_explore_times(...)
end

function var_0_0:get_subsystem_time(arg_66_1, ...)
	local var_66_0 = self:getActivityObj(arg_66_1)

	if not var_66_0 then
		return
	end

	return var_66_0:get_subsystem_time(...)
end

function var_0_0:getSystemTime(arg_67_1)
	local var_67_0 = self:getActivityObj(arg_67_1)

	if not var_67_0 then
		return
	end

	return var_67_0.subsystemtime
end

function var_0_0:getSystemTimeTbl(arg_68_1)
	local var_68_0 = self:getActivityObj(arg_68_1)

	if not var_68_0 then
		return {}
	end

	local var_68_1 = {}

	for iter_68_0, iter_68_1 in pairs(var_68_0.subsystemtime) do
		var_68_1[iter_68_1.id] = iter_68_1
	end

	return var_68_1
end

function var_0_0:get_activity_question_list(arg_69_1, arg_69_2)
	local var_69_0 = self:getActivityObj(arg_69_1)

	if not var_69_0 then
		return
	end

	return var_69_0:get_activity_question_list(arg_69_2)
end

function var_0_0:activity_answer_question(arg_70_1, arg_70_2, arg_70_3)
	local var_70_0 = self:getActivityObj(arg_70_1)

	if not var_70_0 then
		return true
	end

	return var_70_0:activity_answer_question(arg_70_2, arg_70_3)
end

function var_0_0:get_module_starttime(arg_71_1, ...)
	local var_71_0 = self:getActivityObj(arg_71_1)

	if not var_71_0 then
		return
	end

	return var_71_0:get_module_starttime(...)
end

function var_0_0:get_module_finishtime(arg_72_1, ...)
	local var_72_0 = self:getActivityObj(arg_72_1)

	if not var_72_0 then
		return
	end

	return var_72_0:get_module_finishtime(...)
end

function var_0_0:get_module_resettime(arg_73_1, ...)
	local var_73_0 = self:getActivityObj(arg_73_1)

	if not var_73_0 then
		return
	end

	return var_73_0:get_module_resettime(...)
end

function var_0_0:getActivityExploreConfData(arg_74_1, ...)
	local var_74_0 = self:getActivityObj(arg_74_1)

	if not var_74_0 then
		return
	end

	return var_74_0:getActivityExploreConfData(...)
end

function var_0_0:isHasExploreMapLayer(arg_75_1)
	local var_75_0 = self:getActivityObj(arg_75_1)

	if not var_75_0 then
		return
	end

	return var_75_0:isHasExploreMapLayer()
end

function var_0_0:getCurExploreId(arg_76_1)
	local var_76_0 = self:getActivityObj(arg_76_1)

	if not var_76_0 then
		return
	end

	return var_76_0:getCurExploreId()
end

function var_0_0:get_activity_timesign(arg_77_1, ...)
	local var_77_0 = self:getActivityObj(arg_77_1)

	if not var_77_0 then
		return
	end

	return var_77_0:get_activity_timesign(...)
end

function var_0_0:do_timesign(arg_78_1, ...)
	local var_78_0 = self:getActivityObj(arg_78_1)

	if not var_78_0 then
		return
	end

	return var_78_0:do_timesign(...)
end

function var_0_0:isShowNoviceSummary(...)
	local time_check_manager

	if (playermodel.create_time < os.time(parse_time("2020-9-19 00:00:00")) and os.time(parse_time("2020-9-19 00:00:00")) + 1209600 or playermodel.create_time + 1209600) < require("controller.time_check_manager"):getCurTime() then
		do return false end

		time_check_manager = require("controller.time_check_manager")

		local activity_return_manager = require("controller.activity_return_manager")
	end

	if not self:is_module_stat_finished(2, "task_novice") then
		return (playermodel.create_time < os.time(parse_time("2020-9-19 00:00:00")) and os.time(parse_time("2020-9-19 00:00:00")) + 1209600 or playermodel.create_time + 1209600) > time_check_manager:getCurTime()
	end
end

function var_0_0:getFightCollectionItemId(arg_80_1)
	local var_80_0 = self:getActivityObj(arg_80_1)

	if not var_80_0 then
		return
	end

	return var_80_0:getFightCollectionItemId()
end

function var_0_0:getCollectionItem(arg_81_1, arg_81_2)
	local var_81_0 = self:getActivityObj(arg_81_1)

	if not var_81_0 then
		return
	end

	return var_81_0:getCollectionItem(arg_81_2)
end

function var_0_0.get_activity_exchange_data(arg_82_0, arg_82_1)
	network:rpc("get_activity_exchange_data", {
		activityid = arg_82_1
	}, function(arg_83_0)
		if arg_83_0.result == 1 then
			arg_82_0:fireEvent(arg_82_0.activityEventId.EXCHANGE_INFO_UPDATE, arg_83_0)
		end
	end)
end

function var_0_0.activity_exchange_reward(arg_84_0, arg_84_1, arg_84_2)
	network:rpc("activity_exchange_reward", {
		activityid = arg_84_1,
		exchange = arg_84_2
	}, function(arg_85_0)
		if arg_85_0.result == 1 then
			global_gain(arg_85_0)

			if arg_85_0.costItems then
				for iter_85_0, iter_85_1 in pairs(arg_84_2) do
					item_manager:deleteItem(iter_85_1.entityid, iter_85_1.itemnum)
				end
			end

			arg_84_0:fireEvent(arg_84_0.activityEventId.EXCHANGE_INFO_UPDATE, arg_85_0)
		end
	end)
end

return var_0_0
