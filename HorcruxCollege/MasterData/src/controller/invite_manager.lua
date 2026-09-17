local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local activity_manager = require("controller.activity_manager")
local network = require("network.network")
local activity_yaoqing_task_index_data = require("data.activity_yaoqing_task_index_data")
local activity_shouyao_task_index_data = require("data.activity_shouyao_task_index_data")
local activity_yaoqing_task_data = require("data.activity_yaoqing_task_data")
local activity_shouyao_task_data = require("data.activity_shouyao_task_data")
local task_data = require("data.task_data")
local drop_manager = require("controller.drop_manager")
local share_manager = require("controller.share_manager")
local account_manager = require("controller.account_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_yaoqing_share_data = require("data.activity_yaoqing_share_data")
local analysis_bridge = require("controller.analysis_bridge")
local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local var_0_17
local var_0_18 = {
	INVITE = 1,
	BEINVITED = 2
}
local var_0_19 = {
	PAY = 2,
	GROWING = 1
}
local var_0_20 = {
	GO = 2,
	GET = 1,
	FINISHED = 3
}
local InviteManager = class("InviteManager")

setmetatable(InviteManager, {
	__index = require("controller.task_manager_ext")
})

local var_0_22 = {
	INVITE = 2,
	BEINVITED = 1,
	CALL = 3,
	UNKNOWN = 0
}

InviteManager.INVITE_TASK_TYPE = var_0_22

local var_0_23 = {
	COMPLETE = 2,
	PROGRESS = 1,
	FINISHED = 3
}

InviteManager.INVITE_TASK_STATUS = var_0_23

local var_0_24 = {
	[var_0_23.COMPLETE] = 0,
	[var_0_23.PROGRESS] = 1,
	[var_0_23.FINISHED] = 2
}

function InviteManager:create()
	return (InviteManager.new())
end

function InviteManager:ctor()
	self:init()
end

function InviteManager:init()
	self:initProperties()
	self:initData()
	self:registerEvents()
	self:initHooks()
end

function InviteManager:initInfo(arg_4_1)
	self:requestInviteInfo(function(arg_5_0)
		self:initInviteInfo(arg_5_0)
		self:requestInvitePlayerTaskInfo(TASK_TYPE_INVITE, function(arg_6_0)
			self:requestInvitePlayerTaskInfo(TASK_TYPE_BEINVITED, function(arg_7_0)
				self:requestInviteTaskInfo(function(arg_8_0)
					self.taskinfo[TASK_TYPE_INVITE] = arg_6_0.invite
					self.taskinfo[TASK_TYPE_BEINVITED] = arg_7_0.beinvited

					self:initInviteTaskInfo(arg_8_0.taskinfo)
					self:initInvitePlayerTaskInfo(TASK_TYPE_INVITE, arg_6_0.invite)
					self:initInvitePlayerTaskInfo(TASK_TYPE_BEINVITED, arg_7_0.beinvited)

					if type(arg_4_1) == "function" then
						arg_4_1()
					end
				end)
			end)
		end)
	end)
end

function InviteManager:getNeedDataFromTabelByType(arg_9_1, arg_9_2)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		if arg_9_2 == iter_9_1.display_type then
			table.insert(var_9_0, iter_9_1)
		end
	end

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		return arg_10_0.order < arg_10_1.order
	end)

	return var_9_0
end

function InviteManager:initProperties()
	self.inviteInfo = {
		inviteNums = 0,
		invite = {
			taskInfo = {
				isShowReddot = false
			}
		},
		beinvited = {
			taskInfo = {
				isShowReddot = false
			}
		}
	}
	self.taskinfo = {}

	local var_11_0 = {}
	local var_11_1 = {}

	for iter_11_0 = 1, 36 do
		local var_11_2 = self:getNeedDataFromTabelByType(activity_yaoqing_task_data, iter_11_0)

		if #var_11_2 > 0 then
			table.insert(var_11_0, var_11_2)
		else
			break
		end
	end

	for iter_11_1 = 1, 36 do
		local var_11_3 = self:getNeedDataFromTabelByType(activity_shouyao_task_data, iter_11_1)

		if #var_11_3 > 0 then
			table.insert(var_11_1, var_11_3)
		else
			break
		end
	end

	self.tableInfo = {
		invite = var_11_0,
		beinvited = var_11_1
	}
end

function InviteManager:initInviteInfo(arg_12_1)
	if arg_12_1 == nil or arg_12_1.result ~= 1 then
		return
	end

	self.inviteInfo.myselfUid = playermodel.playerid
	self.inviteInfo.myBindUid = arg_12_1.binduid
	self.inviteInfo.inviteNums = arg_12_1.invitenum
	self.inviteInfo.isOldPlayer = arg_12_1.isoldplayer == 1
end

function InviteManager:initInviteTaskInfo(arg_13_1)
	if arg_13_1 == nil then
		return
	end

	self:generate_task_params(arg_13_1)
end

local var_0_25 = {
	1,
	2,
	4,
	8,
	16,
	32,
	64,
	128,
	256,
	512,
	1024,
	2048,
	4096,
	8192,
	16384,
	32768,
	65536,
	131072,
	262144,
	524288,
	1048576,
	2097152,
	4194304,
	8388608,
	16777216,
	33554432,
	67108864,
	134217728,
	268435456,
	536870912,
	1073741824,
	2147483648
}

function InviteManager:is_task_finished(arg_14_1, arg_14_2)
	local var_14_0 = math.ceil(arg_14_2 / 16)
	local var_14_1

	if not arg_14_1[var_14_0] then
		do return false end

		var_14_1 = arg_14_1[var_14_0]
	end

	return bit.band(var_14_1, var_0_25[((arg_14_2 - 1) % 16 + 1) * 2]) ~= 0
end

function InviteManager:can_task_triggered(arg_15_1)
	local var_15_0 = task_data[arg_15_1]

	if not self:check_pre_task(task_data[arg_15_1].pre) then
		return false
	end

	if var_15_0.trigger_type == 0 then
		return true
	elseif var_15_0.classtype then
		return playermodel.level > var_15_0.trigger_condition and var_15_0.classtype == playermodel.class
	else
		return playermodel.level > var_15_0.trigger_condition
	end
end

function InviteManager:check_pre_task(arg_16_1)
	if not arg_16_1 then
		return true
	end

	for iter_16_0, iter_16_1 in pairs((string.split(arg_16_1, ","))) do
		local var_16_0 = task_data[tonumber(iter_16_1)]

		if not self:is_task_finished(self.taskinfo[var_16_0.task_type], var_16_0.index) then
			return false
		end
	end

	return true
end

function InviteManager:cal_task_stat(arg_17_1)
	local var_17_0, var_17_1, var_17_2 = self:check_condition(task_data[arg_17_1].needs_type, task_data[arg_17_1].needs_target, task_data[arg_17_1].needs_num)

	return {
		taskid = arg_17_1,
		percent = var_17_0,
		finished = var_17_2,
		need = var_17_1,
		order = task_data[arg_17_1].order
	}
end

local function var_0_26(arg_18_0, arg_18_1)
	local var_18_0

	for iter_18_0, iter_18_1 in pairs(arg_18_0) do
		if iter_18_1.taskid == arg_18_1 then
			var_18_0 = iter_18_1

			break
		end
	end

	return var_18_0
end

function InviteManager:initInvitePlayerTaskInfo(arg_19_1, arg_19_2)
	local var_19_0
	local var_19_1
	local var_19_2

	if arg_19_1 == TASK_TYPE_INVITE then
		var_19_0 = self.tableInfo.invite
		var_19_1 = self.inviteInfo.invite.taskInfo
		var_19_2 = activity_yaoqing_task_index_data
	else
		var_19_0 = self.tableInfo.beinvited
		var_19_1 = self.inviteInfo.beinvited.taskInfo
		var_19_2 = activity_shouyao_task_index_data
	end

	local var_19_3 = false

	for iter_19_0 = 1, #var_19_0 do
		local var_19_4 = {
			isShowRedDot = false,
			list = {},
			curTaskStatus = var_0_20.GO,
			index = iter_19_0
		}
		local var_19_5 = 1

		for iter_19_1, iter_19_2 in pairs(var_19_0[iter_19_0]) do
			local var_19_6 = {
				name = "第一个邀请的成长任务",
				percent = 0,
				totalProcess = 10,
				index = 1,
				curProcess = 10,
				jump = 0,
				type = var_0_19.GROWING,
				id = iter_19_2.id,
				taskStatus = var_0_20.GO,
				reward = {}
			}

			if self:is_task_finished(self.taskinfo[arg_19_1], var_0_26(var_19_2, iter_19_2.id).id) then
				var_19_6.taskStatus = var_0_20.FINISHED
				var_19_5 = iter_19_1

				local var_19_7 = self:cal_task_stat(var_19_6.id)

				var_19_6.totalProcess = var_19_7.need
				var_19_6.curProcess = var_19_7.need
				var_19_6.percent = 100
			else
				local var_19_8 = self:cal_task_stat(var_19_6.id)

				var_19_6.taskStatus = var_19_8.percent >= 100 and var_0_20.GET or var_0_20.GO
				var_19_6.totalProcess = var_19_8.need
				var_19_6.curProcess = var_19_8.finished
				var_19_6.percent = var_19_8.percent
			end

			local var_19_9 = task_data[var_19_6.id]

			if task_data[var_19_6.id] then
				var_19_6.name = var_19_9.task_des
				var_19_6.jump = var_19_9.jump
				var_19_6.drop = var_19_9.drop
			end

			local var_19_10 = drop_manager:getDropMsg(var_19_6.drop)

			table.sort(var_19_10.equips, function(arg_20_0, arg_20_1)
				return arg_20_0._index < arg_20_1._index
			end)

			local var_19_11 = {}

			if var_19_10.diamond > 0 then
				table.insert(var_19_11, {
					itemid = "diamond",
					num = var_19_10.diamond,
					name = L_DIAMOND
				})
			end

			if var_19_10.gold > 0 then
				table.insert(var_19_11, {
					itemid = "gold",
					num = var_19_10.gold,
					name = L_GOLD
				})
			end

			local var_19_12 = {}

			for iter_19_3, iter_19_4 in pairs(var_19_10.equips) do
				table.insert(var_19_12, {
					itemid = iter_19_4.dropid,
					num = iter_19_4.dropNum,
					name = item_data[iter_19_4.dropid].name
				})
			end

			for iter_19_5, iter_19_6 in pairs(var_19_12) do
				table.insert(var_19_11, iter_19_6)
			end

			var_19_6.reward = var_19_11

			table.insert(var_19_4.list, var_19_6)
		end

		if var_19_5 < #var_19_0[iter_19_0] and var_19_4.list[var_19_5].taskStatus == var_0_20.FINISHED then
			var_19_5 = var_19_5 + 1
		end

		var_19_4.curTaskIndex = var_19_5

		if var_19_4.list[var_19_5].taskStatus == var_0_20.GET then
			var_19_4.isShowRedDot = true
			var_19_3 = true
			var_19_4.curTaskStatus = var_0_20.GET
		else
			var_19_4.curTaskStatus = var_19_4.list[var_19_5].taskStatus
		end

		var_19_1[iter_19_0] = var_19_4
	end

	if arg_19_1 == TASK_TYPE_BEINVITED and var_19_3 == false and not self:isHaveBindUid() and not self:isOldPlayer() then
		var_19_3 = true
	end

	var_19_1.isShowReddot = var_19_3

	table.sort(var_19_1, function(arg_21_0, arg_21_1)
		if arg_21_0.curTaskStatus == arg_21_1.curTaskStatus then
			return arg_21_0.index < arg_21_1.index
		else
			return arg_21_0.curTaskStatus < arg_21_1.curTaskStatus
		end
	end)
end

function InviteManager:updateCurTaskStatus(arg_22_1)
	local var_22_0 = self:getCurTaskInfo(arg_22_1)
	local var_22_1 = false

	for iter_22_0 = 1, #var_22_0 do
		local var_22_2 = var_22_0[iter_22_0].list[var_22_0[iter_22_0].curTaskIndex]

		if var_22_2.percent >= 100 then
			var_22_2.taskStatus = var_0_20.GET
			var_22_0[iter_22_0].isShowReddot = true
			var_22_0[iter_22_0].curTaskStatus = var_0_20.GET
			var_22_1 = true
		else
			var_22_2.taskStatus = var_0_20.GO
			var_22_0[iter_22_0].curTaskStatus = var_0_20.GO
		end
	end

	var_22_0.isShowReddot = var_22_1
end

function InviteManager:getCurTaskInfo(arg_23_1, arg_23_2)
	local var_23_0 = self.inviteInfo.invite

	var_23_0 = arg_23_1 == var_0_18.INVITE and self.inviteInfo.invite or self.inviteInfo.beinvited

	if arg_23_2 == nil then
		return var_23_0.taskInfo
	else
		return var_23_0.taskInfo[arg_23_2].list[var_23_0.taskInfo[arg_23_2].curTaskIndex]
	end
end

function InviteManager:getReward(arg_24_1, arg_24_2)
	local var_24_0 = self.inviteInfo.invite

	if arg_24_1.type == var_0_18.INVITE then
		var_24_0 = self.inviteInfo.invite
	end

	local var_24_1

	do
		var_24_0 = self.inviteInfo.beinvited
		var_24_1 = {}
	end

	var_24_1.taskid = var_24_0.taskInfo[arg_24_1.index].list[var_24_0.taskInfo[arg_24_1.index].curTaskIndex].id

	network:rpc("get_task_reward", var_24_1, function(arg_25_0)
		if arg_25_0.result == 1 then
			global_gain(arg_25_0)
			self:initInfo(function()
				if type(arg_24_2) == "function" then
					arg_24_2()
				end
			end)
		else
			if type(arg_24_2) == "function" then
				arg_24_2()
			end

			print("get invite task reward fail")
		end
	end)
end

function InviteManager:isOldPlayer()
	return self.inviteInfo.isOldPlayer
end

function InviteManager:getTipsString()
	return activity_yaoqing_share_data[1].proceed_id1
end

function InviteManager:getCurBindUid()
	return self.inviteInfo.myBindUid
end

function InviteManager:isHaveBindUid()
	return self.inviteInfo.myBindUid ~= nil
end

function InviteManager:getMySelfUid()
	return playermodel.playerid
end

function InviteManager:getInviteNums()
	return self.inviteInfo.inviteNums
end

function InviteManager:updateBtnInviteRedDotStatus()
	self:init()
	self:initInfo(function()
		activity_manager:fireEvent(activity_manager.activityEventId.INVITE_IS_MAIN_REDDOT, not not (self:getCurTaskInfo(var_0_18.INVITE).isShowReddot or self:getCurTaskInfo(var_0_18.BEINVITED).isShowReddot and not self.inviteInfo.isOldPlayer))
	end)
end

function InviteManager:setIsShowMainReddot(arg_35_1)
	var_0_17 = arg_35_1
end

function InviteManager:requestInviteInfo(arg_36_1)
	network:rpc("get_invite_info", {}, function(arg_37_0)
		if type(arg_36_1) == "function" then
			arg_36_1(arg_37_0)
		end
	end)
end

function InviteManager:requestInviteTaskInfo(arg_38_1)
	network:rpc("get_task_info_by_type", {
		tasktype = {
			TASK_TYPE_INVITE,
			TASK_TYPE_BEINVITED
		}
	}, function(arg_39_0)
		if type(arg_38_1) == "function" then
			arg_38_1(arg_39_0)
		end
	end)
end

function InviteManager:requestInvitePlayerTaskInfo(arg_40_1, arg_40_2)
	network:rpc("get_player_task", {
		task_type = arg_40_1
	}, function(arg_41_0)
		if type(arg_40_2) == "function" then
			arg_40_2(arg_41_0)
		end
	end)
end

function InviteManager:bindUid(arg_42_1, arg_42_2)
	if arg_42_1 == nil then
		global_ShowBlockWords("先输入其他玩家邀请码才可以绑定哦~")
	elseif arg_42_1 == self.inviteInfo.myselfUid then
		global_ShowBlockWords("不能绑定自己的邀请码哦~")
	else
		network:rpc("invite_binduid", {
			binduid = arg_42_1
		}, function(arg_43_0)
			if arg_43_0.result == 1 then
				self.inviteInfo.myBindUid = arg_42_1

				self:requestInvitePlayerTaskInfo(TASK_TYPE_BEINVITED, function(arg_44_0)
					self.taskinfo[TASK_TYPE_BEINVITED] = arg_44_0.beinvited

					self:initInvitePlayerTaskInfo(TASK_TYPE_BEINVITED, arg_44_0.beinvited)

					if type(arg_42_2) == "function" then
						arg_42_2()
					end
				end)
			elseif arg_43_0.result == 2 then
				global_ShowBlockWords("已经绑定邀请码")
			elseif arg_43_0.result == 3 then
				global_ShowBlockWords("该玩家绑定数已达上限，请绑定其他玩家吧~")
			elseif arg_43_0.result == 4 then
				global_ShowBlockWords("邀请码有误，请重新输入！")
			end
		end)
	end
end

function InviteManager:jumpToGo(arg_45_1, arg_45_2)
	local var_45_1 = (arg_45_1.type == var_0_18.INVITE and self.inviteInfo.invite or self.inviteInfo.beinvited).taskInfo[arg_45_1.index].list[(arg_45_1.type == var_0_18.INVITE and self.inviteInfo.invite or self.inviteInfo.beinvited).taskInfo[arg_45_1.index].curTaskIndex].jump

	if (arg_45_1.type == var_0_18.INVITE and self.inviteInfo.invite or self.inviteInfo.beinvited).taskInfo[arg_45_1.index].list[(arg_45_1.type == var_0_18.INVITE and self.inviteInfo.invite or self.inviteInfo.beinvited).taskInfo[arg_45_1.index].curTaskIndex].jump == 101 then
		self:share()
	elseif var_45_1 == 130 then
		LayerManager:pushInLayer("SignLayerNew")
	elseif var_45_1 == 111 then
		require("controller.sign_manager"):createMidasLayer()
	else
		require("controller.goto_system_manager")

		local var_45_2 = {
			jump_to_system = var_45_1
		}

		if system_jump_config[SYSTEMID[var_45_1]] then
			var_45_2.config = system_jump_config[SYSTEMID[var_45_1]].config or nil
		end

		if var_45_2.config then
			if var_45_2.config.exitCallbackType == "function" then
				var_45_2.config.exitCallback = createExitCallback({
					jump_to_system = 400,
					config = {
						taskType = arg_45_1.type
					}
				})
			end

			if var_45_2.config.exitCallbackType == "string" then
				var_45_2.config = "TaskLayer"
			end
		end

		goto_complete_system(var_45_2)
	end

	if type(arg_45_2) then
		arg_45_2()
	end
end

function InviteManager:share()
	if share_manager:can_share() then
		local var_46_0 = activity_yaoqing_share_data[account_manager:getChannel()] or activity_yaoqing_share_data[1]

		share_manager:registerShareHandler(function(arg_47_0)
			if arg_47_0 == 0 then
				self:onShareSuccess()
				analysis_bridge.click_invite_share()
			end
		end)
		share_manager:doShare(var_46_0.tittle, nil, string.gsub(var_46_0.content, "+", self:getMySelfUid(), 1), var_46_0.url)
	else
		self:onShareSuccess()
	end
end

function InviteManager:showWebActivity(arg_48_1)
	arg_48_1 = arg_48_1 or 2270002

	activity_manager:get_activity_memory_session(arg_48_1, function(arg_49_0)
		if ishasWeb then
			return
		end

		ishasWeb = true

		local var_49_0 = ccui.Layout:create()

		var_49_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
		var_49_0:setTouchEnabled(true)
		var_49_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_49_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_49_0:setBackGroundColorOpacity(150)
		global_basic_scene:addChild(var_49_0, 999)

		local var_49_1 = cc.Sprite:create("mainScenebg/noticebg.jpg")

		var_49_1:setAnchorPoint(cc.p(0.5, 1))
		var_49_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.height))
		var_49_0:addChild(var_49_1)
		var_49_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
			local var_50_0 = ccexp.WebView:create()

			var_50_0:setVisible(true)
			var_50_0:setScalesPageToFit(true)
			var_50_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height - 50))
			var_50_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 25))
			var_50_0:loadURL(arg_49_0)
			var_50_0:setOnDidFinishLoading(function(arg_51_0, arg_51_1)
				return
			end)
			var_49_0:addChild(var_50_0, 10)

			local var_50_1 = ccui.Button:create("equipment/closebtn.png", nil, "equipment/closebtn.png")

			var_50_1:setScale(0.5)
			var_50_1:setPosition(cc.p(GameDisplay.width - 40, GameDisplay.height - 25))
			var_49_0:addChild(var_50_1, 100)
			var_50_1:addTouchEventListener(function(arg_52_0, arg_52_1)
				if arg_52_1 ~= ccui.TouchEventType.ended then
					return
				end

				ishasWeb = false

				var_49_0:runAction(cc.RemoveSelf:create())
			end)
		end)))
	end)
end

function InviteManager:onShareSuccess()
	print("分享成功")
end

function InviteManager:isCanShowShare()
	return share_manager:can_share()
end

local var_0_27

function InviteManager:setCurPanelType(arg_55_1)
	var_0_27 = arg_55_1
end

function InviteManager:getCurPanelType()
	return var_0_27
end

local var_0_28

function InviteManager:setCurInputBindUid(arg_57_1)
	var_0_28 = arg_57_1
end

function InviteManager:getCurInputBindUid()
	return var_0_28
end

function InviteManager:getLeftTimeStr()
	local var_59_1 = global_get_time_by_date(activity_yaoqing_share_data[1].end_time) - time_check_manager:getCurTime()

	return (var_59_1 > 0 or nil) and Utility:formatTimeStr(var_59_1)
end

function InviteManager:initData()
	self.inviteInfos = {}
	self.tasks = {
		[var_0_22.INVITE] = {},
		[var_0_22.BEINVITED] = {},
		[var_0_22.CALL] = {}
	}
end

function InviteManager:registerEvents()
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_INVITE_INFO, handler(self, self.handleGetInviteInfo), 99)
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_INVITE_TASK_INFO, handler(self, self.handleGetInviteTaskInfo), 99)
end

function InviteManager:initHooks()
	EventManager:requestGetInviteInfo()

	for iter_62_0, iter_62_1 in pairs(var_0_22) do
		if iter_62_1 ~= var_0_22.UNKNOWN then
			EventManager:requestGetInviteTaskInfo(iter_62_1)
		end
	end
end

function InviteManager:handleGetInviteInfo(arg_63_1)
	if not arg_63_1 then
		return
	end

	if arg_63_1.result == 1 then
		local var_63_0 = {}

		var_63_0.inviteNum = arg_63_1.invitenum or 0
		var_63_0.isOldPlayer = arg_63_1.isoldplayer == 1
		var_63_0.bindUID = arg_63_1.binduid or 0
		var_63_0.invitePlayers = arg_63_1.inviteplayer or {}
		self.inviteInfos = var_63_0
	end
end

function InviteManager:handleGetInviteTaskInfo(arg_64_1)
	if not arg_64_1 then
		return
	end

	if arg_64_1.result == 1 then
		self.tasks[arg_64_1.type] = arg_64_1.list or {}

		table.sort(self.tasks[arg_64_1.type], function(arg_65_0, arg_65_1)
			if arg_65_0.status == arg_65_1.status then
				return task_data[arg_65_0.taskid].order < task_data[arg_65_1.taskid].order
			else
				return var_0_24[arg_65_0.status] < var_0_24[arg_65_1.status]
			end
		end)

		if self:getLimitTimeInviteTaskLeftTime() > 0 then
			self:requestLimitTimeInviteTaskInfo(function(arg_66_0)
				table.sort(arg_66_0, function(arg_67_0, arg_67_1)
					if arg_67_0.status == arg_67_1.status then
						return task_data[arg_67_0.taskid].order < task_data[arg_67_1.taskid].order
					else
						return var_0_24[arg_67_0.status] < var_0_24[arg_67_1.status]
					end
				end)

				for iter_66_0, iter_66_1 in pairs(arg_66_0) do
					table.insert(self.tasks[var_0_22.INVITE], iter_66_0, iter_66_1)
				end

				activity_manager:fireEvent(activity_manager.activityEventId.INVITE_IS_MAIN_REDDOT, self:canRewardTask())
			end)
		else
			activity_manager:fireEvent(activity_manager.activityEventId.INVITE_IS_MAIN_REDDOT, self:canRewardTask())
		end
	end
end

function InviteManager:canRewardTask(arg_68_1)
	local function var_68_3(arg_69_0)
		local var_69_0 = false

		for iter_69_0, iter_69_1 in ipairs(arg_69_0) do
			if iter_69_1.status == var_0_23.COMPLETE then
				var_69_0 = true

				break
			end
		end

		return var_69_0
	end

	if not arg_68_1 then
		for iter_68_0, iter_68_1 in ipairs(self.tasks) do
			if var_68_3(iter_68_1) then
				return true
			end
		end

		return false
	else
		return var_68_3(self.tasks[arg_68_1])
	end
end

function InviteManager:getBindUID()
	return self.inviteInfos.bindUID
end

function InviteManager:isOldPlayer()
	return self.inviteInfos.isOldPlayer
end

function InviteManager:getInvitePlayers()
	return self.inviteInfos.invitePlayers or {}
end

function InviteManager:getInviteInfos()
	return self.inviteInfos
end

function InviteManager:getInviteNum()
	return self.inviteInfos.inviteNum or 0
end

function InviteManager:isTaskFinished(arg_75_1)
	for iter_75_0, iter_75_1 in ipairs(self.tasks[arg_75_1]) do
		if iter_75_1.status == var_0_23.PROGRESS or iter_75_1.status == var_0_23.COMPLETE then
			return false
		end
	end

	return true
end

function InviteManager:release()
	EventManager:unsubscribe(self)
end

function InviteManager:requestLimitTimeInviteTaskInfo(arg_77_1)
	require("controller.activity_manager"):getActivityTaskList(LIMITTIME_INVITE_ACTIVITYID, nil, function(arg_78_0, arg_78_1)
		for iter_78_0, iter_78_1 in pairs(arg_78_1.list) do
			iter_78_1.status = iter_78_1.status >= 1 and var_0_23.FINISHED or iter_78_1.percent >= 100 and var_0_23.COMPLETE or var_0_23.PROGRESS
			iter_78_1.islimittime = true
		end

		if type(arg_77_1) == "function" then
			arg_77_1(arg_78_1.list)
		end
	end, false)
end

function InviteManager:getLimitTimeReward(arg_79_1, arg_79_2)
	require("controller.activity_manager"):getTaskReward(LIMITTIME_INVITE_ACTIVITYID, arg_79_1.taskid, function(arg_80_0, arg_80_1)
		if type(arg_79_2) == "function" then
			arg_79_2(arg_80_1)
		end
	end)
end

function InviteManager:getLimitTimeInviteTaskLeftTime()
	return global_get_time_by_date(LIMITTIME_INVITE_ENDTIME) - time_check_manager:getCurTime()
end

return InviteManager
