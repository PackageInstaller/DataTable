local var_0_0 = {}
local playermodel = require("model.playermodel")
local network = require("network.network")
local grade_exp_data = require("data.grade_exp_data")
local core_manager = require("controller.core_manager")

function var_0_0.update_player_strengthpoint(arg_2_0, arg_2_1)
	return
end

function var_0_0.player_upgrade(arg_3_0, arg_3_1)
	assert(arg_3_1 ~= nil, "grade can not be a nil")

	playermodel.grade = arg_3_1

	GlobalUpdateGrade()

	if global_classup_level_label then
		global_classup_level_label:setString("LV:" .. playermodel.grade - (playermodel.class - 1) * 100)
	end

	GuideListener.triggerGuide(TRIGGER_LEVELUP)
	AnalyticManager.setUserLevel(playermodel.grade)

	if DeviceManager.getPackageChannel() == "FY" then
		require("controller.account_manager"):onPlayerUpdate()
	end

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("updateMainLineTaskUI"))
end

function var_0_0:update_player_exp(arg_4_1, arg_4_2, arg_4_3)
	playermodel.exp = checkint(arg_4_1)
	playermodel.totalexp = arg_4_3 and checkint(arg_4_3) or nil

	if playermodel.grade ~= arg_4_2 then
		self:player_upgrade(arg_4_2)
	end

	GlobalUpdateExp()
end

function var_0_0.player_update_class(arg_5_0, arg_5_1)
	network:rpc("player_update_class", nil, function(arg_6_0)
		if arg_6_0.result == 1 then
			playermodel.class = arg_6_0.class

			arg_5_0:update_player_exp(arg_6_0.exp, arg_6_0.grade, arg_6_0.totalexp)
			GlobalUpdateGrade()

			if global_classup_level_label then
				global_classup_level_label:setString("LV:" .. playermodel.grade - (playermodel.class - 1) * 100)
			end

			global_gain(arg_6_0)
			AnalyticManager.player_update_class({
				class = playermodel.class,
				city = require("controller.level_manager"):getCurFightCity(),
				role_num = playermodel:getHavedServantNum(),
				finish_task_num = require("controller.task_manager"):getTaskFinishLen(3)
			})

			if arg_5_1 then
				arg_5_1(arg_6_0)
			end
		elseif arg_6_0.result == 2 then
			if arg_5_1 then
				arg_5_1(arg_6_0)
			end
		elseif arg_6_0.result == 3 then
			global_riseWord(arg_6_0.errmsg)

			return
		end
	end)
end

function var_0_0.show_update_classes(arg_7_0, arg_7_1)
	network:rpc("get_class_info", nil, function(arg_8_0)
		if arg_8_0.result == 1 then
			l2Log("get class info success")

			if arg_7_1 then
				arg_7_1(arg_8_0.result, arg_8_0.update_conditions, arg_8_0.drop)
			end
		elseif arg_8_0.result == 2 then
			l2Log("max class")

			if arg_7_1 then
				arg_7_1(arg_8_0.result)
			end
		else
			l2Log("get classs info fail")
		end
	end)
end

return var_0_0
