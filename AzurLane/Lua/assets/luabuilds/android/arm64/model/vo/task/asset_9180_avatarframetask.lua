class = var_0_10000

local var_0_0 = "AvatarFrameTask"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".Task"))

var_0_1.type_task_level = "task_level"
var_0_1.type_task_ship = "task_ship"
var_0_1.fillter_task_type = {
	var_0_1.type_task_level,
	var_0_1.type_task_ship
}

local var_0_2 = var_0_1.fillter_task_type
local var_0_3 = "avatar_task_level"
local var_0_4 = {
	"avatar_upgrad_1",
	"avatar_upgrad_2",
	"avatar_upgrad_3"
}
local var_0_5 = "avatar_task_ship_1"
local var_0_6 = "avatar_task_ship_2"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._actId = arg_1_1
	arg_1_0.configId = arg_1_2
	arg_1_0.id = arg_1_3.id

	local var_1_0

	if not arg_1_3.progress then
		var_1_0 = 0
	end

	arg_1_0.progress = var_1_0

	local var_1_1

	if not arg_1_3.accept_time then
		var_1_1 = 0
	end

	arg_1_0.acceptTime = var_1_1

	local var_1_2

	if not arg_1_3.submit_time then
		var_1_2 = 0
	end

	arg_1_0.submitTime = var_1_2

	return
end

function var_0_1.IsActEnd(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.activity_event_avatarframe[arg_2_0.configId].link_event

	getProxy = var_2
	ActivityProxy = var_1_10004

	local var_2_1 = var_2(var_1_10004)

	return not var_2.getActivityById(var_2_1, var_2_0) or var_2:isEnd()
end

function var_0_1.updateProgress(arg_3_0, arg_3_1)
	arg_3_0.progress = arg_3_1 or 0

	return
end

function var_0_1.isFinish(arg_4_0)
	return arg_4_0:getProgress() >= arg_4_0:getConfig("target_num")
end

function var_0_1.getProgress(arg_5_0)
	return arg_5_0.progress or 0
end

function var_0_1.isReceive(arg_6_0)
	return false
end

function var_0_1.getTaskStatus(arg_7_0)
	if arg_7_0.progress >= arg_7_0:getConfig("target_num") then
		return 1
	end

	return 0
end

function var_0_1.onAdded(arg_8_0)
	return
end

function var_0_1.setTaskFinish(arg_9_0)
	arg_9_0.submitTime = 1

	arg_9_0:updateProgress(arg_9_0:getConfig("target_num"))

	return
end

function var_0_1.updateProgress(arg_10_0, arg_10_1)
	arg_10_0.progress = arg_10_1

	return
end

function var_0_1.isSelectable(arg_11_0)
	return false
end

function var_0_1.judgeOverflow(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	return false, false
end

function var_0_1.IsUrTask(arg_13_0)
	return false
end

function var_0_1.GetRealType(arg_14_0)
	return 6
end

function var_0_1.IsOverflowShipExpItem(arg_15_0)
	return false
end

function var_0_1.ShowOnTaskScene(arg_16_0)
	return true
end

function var_0_1.getConfig(arg_17_0, arg_17_1)
	if not arg_17_0.configData then
		pg = var_2

		if not var_2.activity_event_avatarframe[arg_17_0.configId] then
			print = var_3

			var_3("avatart id = " .. arg_17_0.configId .. " is not found")

			return
		end

		if not arg_17_0:getTypeData(var_2, arg_17_0.id) then
			return
		end

		Clone = var_1_10004
		var_1_10004(var_2.award_display)[1][3] = var_3.award_num
		arg_17_0.configData = {
			sub_type = 0,
			level = 1,
			item_id = var_2.pt_id,
			desc = var_3.desc,
			target_num = var_3.target_num,
			award_num = var_3.award_num,
			scene = var_3.scene,
			award_display = var_4
		}
	end

	return arg_17_0.configData[arg_17_1]
end

function var_0_1.getTypeData(arg_18_0, arg_18_1, arg_18_2)
	for iter_18_0 = 1, #var_0_2 do
		local var_18_0 = arg_18_1[var_0_2[iter_18_0]]

		ipairs = var_1_10009

		for iter_18_1, iter_18_2 in var_1_10009(var_18_0) do
			if iter_18_2[1] == arg_18_2 then
				arg_18_0.avatarType = var_7

				return arg_18_0:createData(var_7, iter_18_2)
			end
		end
	end

	return
end

function var_0_1.isAvatarTask(arg_19_0)
	return true
end

function var_0_1.getActId(arg_20_0)
	return arg_20_0._actId
end

function var_0_1.createData(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0
	local var_21_1

	if arg_21_1 == var_0_1.type_task_level then
		unpack = var_21_1

		local var_21_2, var_21_3, var_21_4, var_21_5

		var_21_1, var_21_2, var_21_3, var_21_4, var_1_10008, var_21_5 = var_21_1(arg_21_2)

		local var_21_6 = ""

		if var_21_3 > 0 and var_21_3 <= #var_0_4 then
			pg = var_11
			var_21_6 = var_11.gametip[var_0_4[var_21_3]].tip
		end

		local var_21_7 = var_21_2 * 10 + 1

		pg = var_1_10012

		local var_21_8 = var_1_10012.ship_data_statistics[var_21_7].name
		local var_21_9
		local var_21_10

		ipairs = var_1_10015

		for iter_21_0, iter_21_1 in var_1_10015(var_21_4) do
			assert = var_1_10020
			pg = var_1_10022
			var_1_10022 = var_1_10022.chapter_template[iter_21_1] ~= nil

			var_1_10020(var_1_10022, "找不到chapterid = " .. iter_21_1)

			if not var_21_10 then
				var_1_10020 = {
					"ACTIVITY_MAP"
				}

				local var_21_11 = {}

				pg = var_1_10022
				var_21_11[1] = var_1_10022.chapter_template[iter_21_1].act_id
				var_1_10020[2] = var_21_11
				var_21_10 = var_1_10020
			end

			if not var_21_9 then
				pg = var_1_10020
				var_21_9 = var_1_10020.chapter_template[iter_21_1].chapter_name
			else
				var_1_10020 = var_21_9

				local var_21_12 = ","

				pg = var_1_10022
				var_21_9 = var_1_10020 .. var_21_12 .. var_1_10022.chapter_template[iter_21_1].chapter_name
			end
		end

		local var_21_13 = {
			target_num = var_1_10008,
			award_num = var_21_5,
			scene = var_21_10
		}

		i18n = var_16
		var_21_13.desc = var_16("avatar_task_level", var_21_6, var_21_8, var_21_9, var_1_10008)
		var_21_0 = var_21_13
	elseif arg_21_1 == var_0_1.type_task_ship then
		unpack = var_21_1

		local var_21_14, var_21_15, var_21_16

		var_21_1, var_21_14, var_21_15, var_21_16 = var_21_1(arg_21_2)
		ShipGroup = var_1_10008

		local var_21_17 = var_1_10008.getDefaultShipNameByGroupID(var_21_14)

		if var_21_15 == 1 then
			local var_21_18 = {
				award_num = var_21_16
			}

			i18n = var_10
			var_21_18.desc = var_10(var_0_5, var_21_17)
			var_21_0 = var_21_18
		elseif var_21_15 == 2 then
			local var_21_19 = {
				award_num = var_21_16
			}

			i18n = var_10
			var_21_19.desc = var_10(var_0_6, var_21_17)
			var_21_19.scene = {
				"DOCKYARD",
				{
					mode = "overview"
				}
			}
			var_21_0 = var_21_19
		end
	end

	setmetatable = var_21_1

	return var_21_1(var_21_0, {
		__index = {
			award_num = 1,
			target_num = 1,
			desc = ""
		}
	})
end

return var_0_1
