local activity_manager = require("controller.activity_manager")
local activity_conf_data = require("data.activity_conf_data")
local playermodel = require("model.playermodel")
local network = require("network.network")
local item_manager = require("controller.item_manager")
local activity_springfirecracker_conf = require("data.activity_springfirecracker_conf")

function ACTIVITY_OBJ_NEW:springfirecracker_get_game_data(arg_1_1)
	network:rpc("activity_springfirecracker_get_game_data", {
		activityid = self._id
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FIRECRACKER_DATA_UPDATE, arg_2_0)
		elseif arg_2_0.result == 2 then
			global_ShowBlockWords("本次活动未开放该玩法哦")
		else
			global_ShowBlockWords("illegal error!!!")
		end

		if arg_1_1 then
			arg_1_1(arg_2_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:springfirecracker_start_game(arg_3_1)
	if not item_manager:haveItem(activity_springfirecracker_conf[self._id].key_item) then
		global_ShowBlockWords("道具不足!!!")

		return
	end

	network:rpc("activity_springfirecracker_start_game", {
		activityid = self._id
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			if arg_4_0.consumes then
				for iter_4_0, iter_4_1 in pairs(arg_4_0.consumes) do
					item_manager:deleteItem(iter_4_1.entityid, iter_4_1.num)
				end
			end
		elseif arg_4_0.result == 2 then
			global_ShowBlockWords("本次活动未开放该玩法哦")
		elseif arg_4_0.result == 3 then
			global_ShowBlockWords("道具不足!!!")
		else
			global_ShowBlockWords("illegal error!!!")
		end

		if arg_3_1 then
			arg_3_1(arg_4_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:springfirecracker_level_up(arg_5_1, arg_5_2)
	network:rpc("activity_springfirecracker_level_up", {
		activityid = self._id,
		strengthen = arg_5_1.strengthen
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			if arg_6_0.consumes then
				for iter_6_0, iter_6_1 in pairs(arg_6_0.consumes) do
					item_manager:deleteItem(iter_6_1.entityid, iter_6_1.num)
				end
			end

			global_ShowBlockWords("强化成功！")
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FIRECRACKER_DATA_UPDATE, arg_6_0)
		elseif arg_6_0.result == 2 then
			global_ShowBlockWords("强化出错了！")
		elseif arg_6_0.result == 3 then
			global_ShowBlockWords("已经达到最大等级了")
		elseif arg_6_0.result == 4 then
			global_ShowBlockWords("活动获取错误！！！")
		elseif arg_6_0.result == 5 then
			global_ShowBlockWords("道具不足!!!")
		else
			global_ShowBlockWords("illegal error!!!")
		end

		if arg_5_2 then
			arg_5_2(arg_6_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:springfirecracker_game_end(arg_7_1, arg_7_2)
	network:rpc("activity_springfirecracker_game_end", {
		activityid = self._id,
		score = arg_7_1.score
	}, function(arg_8_0)
		if arg_8_0.result == 1 then
			if arg_8_0.items then
				global_gain(arg_8_0)
			end
		elseif arg_8_0.result == 2 then
			global_ShowBlockWords("得分上传失败！！！")
		elseif arg_8_0.result == 3 then
			global_ShowBlockWords("活动获取错误！！！")
		else
			global_ShowBlockWords("illegal error!!!")
		end

		if arg_7_2 then
			arg_7_2(arg_8_0)
		end
	end)
end
