local var_0_0 = class("WorldEntrance", import("...BaseEntity"))

var_0_0.Fields = {
	config = "table",
	marks = "table",
	transportDic = "table",
	world = "table",
	id = "number",
	becomeSairen = "boolean",
	active = "boolean"
}
var_0_0.Listeners = {}
var_0_0.EventUpdateMapIndex = "WorldEntrance.EventUpdateMapIndex"
var_0_0.EventUpdateDisplayMarks = "WorldEntrance.EventUpdateDisplayMarks"

function var_0_0.DebugPrint(arg_1_0)
	return string.format("入口 [id: %s] [原始地图: %s] [所属区域: %s] [所属海域: %s]", arg_1_0.id, arg_1_0:GetBaseMapId(), arg_1_0.config.regions, arg_1_0.config.world)
end

function var_0_0.Setup(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1

	assert(pg.world_chapter_colormask[arg_2_1], "world_chapter_colormask.csv without this id:" .. arg_2_0.id)

	arg_2_0.config = pg.world_chapter_colormask[arg_2_1]
	arg_2_0.transportDic = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.config.map_transfer) do
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

function var_0_0.IsOpen(arg_3_0)
	return arg_3_0:GetBaseMap():IsMapOpen()
end

function var_0_0.GetBaseMapId(arg_4_0)
	return arg_4_0.config.chapter
end

function var_0_0.GetBaseMap(arg_5_0)
	return nowWorld():GetMap(arg_5_0:GetBaseMapId())
end

function var_0_0.GetColormaskUniqueID(arg_6_0)
	return arg_6_0.config.color_id
end

function var_0_0.GetAreaId(arg_7_0)
	return arg_7_0.config.regions
end

function var_0_0.IsPressing(arg_8_0)
	return arg_8_0:GetBaseMap().isPressing
end

function var_0_0.HasPort(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetPortId()

	if var_9_0 > 0 then
		local var_9_1

		if arg_9_1 then
			if pg.world_port_data[var_9_0].port_camp ~= nowWorld():GetRealm() then
				var_9_1 = false

				goto label_9_0
			end
		end

		::label_9_0::

		return true
	end
end

function var_0_0.GetPortId(arg_10_0)
	return arg_10_0.config.port_map_icon
end

function var_0_0.UpdateActive(arg_11_0, arg_11_1)
	if arg_11_0.active ~= arg_11_1 then
		arg_11_0.active = arg_11_1

		if arg_11_1 then
			nowWorld():GetAtlas():SetActiveEntrance(arg_11_0)
		end
	end

	return
end

function var_0_0.UpdateDisplayMarks(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.marks[arg_12_1] == 0 and arg_12_2 or arg_12_0.marks[arg_12_1] == 1 and not arg_12_2

	arg_12_0.marks[arg_12_1] = arg_12_0.marks[arg_12_1] + (arg_12_2 and 1 or -1)

	if var_12_0 then
		arg_12_0:DispatchEvent(var_0_0.EventUpdateDisplayMarks, arg_12_1, arg_12_0.marks[arg_12_1] > 0)
	end

	return
end

function var_0_0.GetDisplayMarks(arg_13_0)
	return arg_13_0.marks
end

function var_0_0.GetSairenMapId(arg_14_0)
	return arg_14_0.config.sairen_chapter[1]
end

function var_0_0.UpdateSairenMark(arg_15_0, arg_15_1)
	if tobool(arg_15_0.becomeSairen) ~= tobool(arg_15_1) then
		arg_15_0.becomeSairen = arg_15_1
	end

	return
end

function var_0_0.GetAchievementAwards(arg_16_0)
	return _.map(arg_16_0.config.target_drop_show, function(arg_17_0)
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

return var_0_0
