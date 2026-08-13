class = var_0_10000

local var_0_0 = "WorldEntrance"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	config = "table",
	marks = "table",
	transportDic = "table",
	world = "table",
	id = "number",
	becomeSairen = "boolean",
	active = "boolean"
}
var_0_1.Listeners = {}
var_0_1.EventUpdateMapIndex = "WorldEntrance.EventUpdateMapIndex"
var_0_1.EventUpdateDisplayMarks = "WorldEntrance.EventUpdateDisplayMarks"

function var_0_1.DebugPrint(arg_1_0)
	string = var_1_10001

	return var_1_10001.format("入口 [id: %s] [原始地图: %s] [所属区域: %s] [所属海域: %s]", arg_1_0.id, arg_1_0:GetBaseMapId(), arg_1_0.config.regions, arg_1_0.config.world)
end

function var_0_1.Setup(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1
	assert = var_1_10003
	pg = var_1_10005

	var_1_10003(var_1_10005.world_chapter_colormask[arg_2_1], "world_chapter_colormask.csv without this id:" .. arg_2_0.id)

	pg = var_1_10003
	arg_2_0.config = var_1_10003.world_chapter_colormask[arg_2_1]
	arg_2_0.transportDic = {}
	ipairs = var_3

	for iter_2_0, iter_2_1 in var_3(arg_2_0.config.map_transfer) do
		arg_2_0.transportDic[iter_2_1] = true
	end

	arg_2_0.marks = {
		task_main = 0,
		task_following_main = 0,
		task_following_boss = 0,
		task_following = 0,
		task_collecktion = 0,
		task = 0,
		treasure = 0,
		sairen = 0,
		treasure_sairen = 0,
		step = 0
	}

	return
end

function var_0_1.IsOpen(arg_3_0)
	local var_3_0 = arg_3_0:GetBaseMap()

	return var_1.IsMapOpen(var_3_0)
end

function var_0_1.GetBaseMapId(arg_4_0)
	return arg_4_0.config.chapter
end

function var_0_1.GetBaseMap(arg_5_0)
	nowWorld = var_1_10001

	local var_5_0 = var_1_10001()

	return var_1.GetMap(var_5_0, arg_5_0:GetBaseMapId())
end

function var_0_1.GetColormaskUniqueID(arg_6_0)
	return arg_6_0.config.color_id
end

function var_0_1.GetAreaId(arg_7_0)
	return arg_7_0.config.regions
end

function var_0_1.IsPressing(arg_8_0)
	return arg_8_0:GetBaseMap().isPressing
end

function var_0_1.HasPort(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.GetPortId(var_9_0)

	if 0 < var_9_1 then
		local var_9_4

		if arg_9_1 then
			pg = var_3

			local var_9_2 = var_3.world_port_data[var_9_1].port_camp

			nowWorld = var_9_0

			local var_9_3 = var_9_0()

			if var_9_2 ~= var_4.GetRealm(var_9_3) then
				var_9_4 = false

				goto label_9_0
			end
		end

		var_9_4 = true

		::label_9_0::

		return var_9_4
	end
end

function var_0_1.GetPortId(arg_10_0)
	return arg_10_0.config.port_map_icon
end

function var_0_1.UpdateActive(arg_11_0, arg_11_1)
	if arg_11_0.active ~= arg_11_1 then
		arg_11_0.active = arg_11_1

		if arg_11_1 then
			nowWorld = var_2

			local var_11_0 = var_2()
			local var_11_1 = var_2.GetAtlas(var_11_0)

			var_2.SetActiveEntrance(var_11_1, arg_11_0)
		end
	end

	return
end

function var_0_1.UpdateDisplayMarks(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.marks[arg_12_1] == 0 and arg_12_2 or arg_12_0.marks[arg_12_1] == 1 and not arg_12_2

	arg_12_0.marks[arg_12_1] = arg_12_0.marks[arg_12_1] + (arg_12_2 and 1 or -1)

	if var_12_0 then
		arg_12_0:DispatchEvent(var_0_1.EventUpdateDisplayMarks, arg_12_1, arg_12_0.marks[arg_12_1] > 0)
	end

	return
end

function var_0_1.GetDisplayMarks(arg_13_0)
	return arg_13_0.marks
end

function var_0_1.GetSairenMapId(arg_14_0)
	return arg_14_0.config.sairen_chapter[1]
end

function var_0_1.UpdateSairenMark(arg_15_0, arg_15_1)
	tobool = var_1_10002

	local var_15_0 = var_1_10002(arg_15_0.becomeSairen)

	tobool = var_1_10003

	if var_15_0 ~= var_1_10003(arg_15_1) then
		arg_15_0.becomeSairen = arg_15_1
	end

	return
end

function var_0_1.GetAchievementAwards(arg_16_0)
	_ = var_1_10001

	return var_1_10001.map(arg_16_0.config.target_drop_show, function(arg_17_0)
		return {
			star = arg_17_0[1],
			drop = {
				type = arg_17_0[2][1],
				id = arg_17_0[2][2],
				count = arg_17_0[2][3]
			}
		}
	end)
end

return var_0_1
