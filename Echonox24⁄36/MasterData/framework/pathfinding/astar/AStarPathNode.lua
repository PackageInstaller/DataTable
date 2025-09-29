module("framework.pathfinding.astar.AStarPathNode", package.seeall)

local var_0_0 = class("AStarPathNode")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gridX = arg_1_1 or 0
	arg_1_0.gridY = arg_1_2 or 0
	arg_1_0.g = 0
	arg_1_0.f = 0
	arg_1_0.parent = nil
end

function var_0_0.reset(arg_2_0)
	arg_2_0.gridX = 0
	arg_2_0.gridY = 0
	arg_2_0.g = 0
	arg_2_0.f = 0
	arg_2_0.parent = nil
end

return var_0_0
