module("framework.pathfinding.astar.MapData", package.seeall)

local var_0_0 = class("MapData")

function var_0_0.ctor(arg_1_0)
	arg_1_0._mapDatas = {}
end

function var_0_0.clear(arg_2_0)
	table.clear(arg_2_0._mapDatas)
end

function var_0_0.setWalkable(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._mapDatas[arg_3_1] = arg_3_0._mapDatas[arg_3_1] or {}
	arg_3_0._mapDatas[arg_3_1][arg_3_2] = true
end

function var_0_0.setUnWalkable(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._mapDatas[arg_4_1] = arg_4_0._mapDatas[arg_4_1] or {}
	arg_4_0._mapDatas[arg_4_1][arg_4_2] = false
end

function var_0_0.setCanWalkable(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._mapDatas[arg_5_1] = arg_5_0._mapDatas[arg_5_1] or {}
	arg_5_0._mapDatas[arg_5_1][arg_5_2] = arg_5_3
end

function var_0_0.isWalkable(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._mapDatas[arg_6_1] and arg_6_0._mapDatas[arg_6_1][arg_6_2] then
		return true
	end

	return false
end

return var_0_0
