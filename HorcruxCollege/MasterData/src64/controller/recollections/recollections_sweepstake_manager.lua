local RecollectionsSweepstakeManager = class("RecollectionsSweepstakeManager", (require("controller.base_manager")))

RecollectionsSweepstakeManager.MULTITON_MSG = "RecollectionsSweepstakeManager instancealready constructed!"

local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local var_0_3 = 260

function RecollectionsSweepstakeManager:ctor()
	RecollectionsSweepstakeManager.super.ctor(self)

	self._data = {}
end

function RecollectionsSweepstakeManager:requestInfo(arg_2_1)
	return
end

function RecollectionsSweepstakeManager:shareSuccess(arg_3_1)
	global_ShowBlockWords("分享成功")
	require("network.network"):rpc("activity_memory_join", {
		action = "share",
		activityid = var_0_3
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			AnalyticManager.recollections_share()

			if arg_4_0.diamond and arg_4_0.diamond > 0 then
				require("controller.recollections.recollections_manager"):getInstance():setDataShare(true)
				global_gain(arg_4_0)
			end

			if self.layer then
				self.layer:shareSuccess()
			end

			if arg_3_1 then
				arg_3_1(arg_4_0)
			end
		end
	end)
end

function RecollectionsSweepstakeManager:readTrigger(arg_5_1)
	require("network.network"):rpc("activity_memory_join", {
		action = "read",
		activityid = var_0_3,
		page = arg_5_1
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			AnalyticManager.recollections_read({
				index = arg_5_1
			})
		end
	end)
end

function RecollectionsSweepstakeManager:saveTrigger()
	require("network.network"):rpc("activity_memory_join", {
		action = "save",
		activityid = var_0_3
	}, function(arg_8_0)
		if arg_8_0.result == 1 then
			AnalyticManager.recollections_save()
		end
	end)
end

function RecollectionsSweepstakeManager:handlerInfo(arg_9_1)
	return
end

function RecollectionsSweepstakeManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function RecollectionsSweepstakeManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

local function var_0_5(arg_13_0, arg_13_1)
	if arg_13_1 ~= false then
		arg_13_1 = true
	end

	local var_13_0 = "<div fontsize=22 fontcolor=#b8c4e5 fontname='fonts/name.ttf'>" .. arg_13_0

	if arg_13_1 then
		var_13_0 = var_13_0 .. "</div>"
	end

	return var_13_0
end

function RecollectionsSweepstakeManager:getTitleStrinfo()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs((require("data.activity_" .. var_0_3 .. ".activity_memory_title"))) do
		var_15_0[iter_15_1.order] = iter_15_1
	end

	local var_15_1 = {
		title = var_15_0[#var_15_0].title,
		body = var_15_0[#var_15_0].desc
	}
	local recollections_manager = require("controller.recollections.recollections_manager")
	local var_15_3 = recollections_manager:getInstance():getData()

	if var_15_3.data.avg_favor_level >= var_15_0[1].param1 then
		var_15_1 = {
			title = var_15_0[1].title,
			body = var_15_0[1].desc
		}

		return var_15_1
	end

	if var_15_3.data.marry_total_count > var_15_0[2].param1 then
		var_15_1 = {
			title = var_15_0[2].title,
			body = var_15_0[2].desc
		}

		return var_15_1
	end

	if var_15_3.data.first_marry_time > 0 then
		if math.floor((require("controller.time_check_manager"):getCurTime() - var_15_3.data.first_marry_time) / 86400) >= var_15_0[3].param1 then
			var_15_1 = {
				title = var_15_0[3].title,
				body = var_15_0[3].desc
			}

			return var_15_1
		end
	end

	if recollections_manager.data.inroom_count > var_15_0[4].param1 then
		var_15_1 = {
			title = var_15_0[4].title,
			body = var_15_0[4].desc
		}

		return var_15_1
	end

	if var_15_3.data.avg_favor_level >= var_15_0[5].param1 then
		var_15_1 = {
			title = var_15_0[5].title,
			body = var_15_0[5].desc
		}

		return var_15_1
	end

	return var_15_1
end

function RecollectionsSweepstakeManager:getRedemptionCode()
	return require("controller.recollections.recollections_manager"):getInstance():getData().code or ""
end

function RecollectionsSweepstakeManager:getDetailsStr()
	return "1、每个傲娇账户仅可获取1个兑奖码，凭借兑奖码可以参与活动；\n2、活动将在2022.2.28日进行开奖。开奖结果将会在社区进行公布；\n3、中奖班长将会在游戏内邮箱中收到中奖邮件，点击邮件内的问卷链接进行中奖信息登记。登记规范请可问卷中查看；\n4、活动奖品为“甜心憨憨”伊迪斯Q版手办，将开奖10名班长；"
end

function RecollectionsSweepstakeManager:getShareStr()
	local var_18_0 = var_0_5("")

	return self:getShareStr1() .. self:getShareStr2()
end

function RecollectionsSweepstakeManager:getShareStr1()
	return require("controller.recollections.recollections_manager"):getInstance():getEnterTips1()
end

function RecollectionsSweepstakeManager:getShareStr2()
	return require("controller.recollections.recollections_manager"):getInstance():getEnterTips2()
end

function RecollectionsSweepstakeManager:isShare()
	return require("controller.recollections.recollections_manager"):getInstance():getData().share or false
end

function RecollectionsSweepstakeManager:isRegister()
	return true
end

return RecollectionsSweepstakeManager
