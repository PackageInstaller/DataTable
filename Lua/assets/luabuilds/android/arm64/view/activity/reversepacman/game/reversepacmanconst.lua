local ReversePacmanConst = class("ReversePacmanConst")

ReversePacmanConst.TIME_INTERVAL = 0.016666666666666666
ReversePacmanConst.GRID_SIZE = {
	x = 35,
	y = 35
}
ReversePacmanConst.GRID_SIZE_2 = {
	x = 22,
	y = 22
}
ReversePacmanConst.GRID = {
	ROAD = "road",
	BLOCK = "block",
	DEPLOY = "deploy",
	SPAWN = "spawn"
}
ReversePacmanConst.TAG = {
	CORNER = "corner",
	CORRIDOR = "corridor",
	JUNCTION = "junction",
	DEAD_END = "deadEnd",
	ISOLATED = "isolated"
}
ReversePacmanConst.DIR = {
	RIGHT = 2,
	UP = 1,
	LEFT = 4,
	DOWN = 3
}
ReversePacmanConst.DIR_VECTORS = {
	[ReversePacmanConst.DIR.UP] = {
		x = 0,
		y = -1
	},
	[ReversePacmanConst.DIR.RIGHT] = {
		x = 1,
		y = 0
	},
	[ReversePacmanConst.DIR.DOWN] = {
		x = 0,
		y = 1
	},
	[ReversePacmanConst.DIR.LEFT] = {
		x = -1,
		y = 0
	}
}
ReversePacmanConst.ROLE = {
	SHIP = "ship",
	MONSTER = "monster"
}
ReversePacmanConst.BUFF = {
	GIANT = 3,
	BLOCK = 2,
	SPEED = 1
}
ReversePacmanConst.BUFF_EDU = 4
ReversePacmanConst.STATE = {
	SETTLEMENT = "settlement",
	EXIT = "exit",
	INIT = "init",
	PREPARE = "prepare",
	CAPTURE = "capture",
	RUNNING = "running"
}
ReversePacmanConst.EVENT = {
	CAST = "cast",
	GRAPH_CHANGED = "graphChanged",
	PICK = "pick",
	SHIP_PERFORMANCE = "shipPerformance",
	CAPTURE = "capture"
}
ReversePacmanConst.SHIP_PERFORMANCE_TYPE = {
	FAR = 3,
	NEAR = 1,
	CAPTURE = 2
}
ReversePacmanConst.SHIP_PERFORMANCE_RANGE = {
	[ReversePacmanConst.SHIP_PERFORMANCE_TYPE.NEAR] = ReversePacmanConst.GRID_SIZE.x * 3,
	[ReversePacmanConst.SHIP_PERFORMANCE_TYPE.FAR] = ReversePacmanConst.GRID_SIZE.x * 8
}
ReversePacmanConst.SHIP_PERFORMANCE_COOLDOWN = 3
ReversePacmanConst.SHIP_PERFORMANCE_GLOBAL_COOLDOWN = 2
ReversePacmanConst.GAMEPLAY_TIME_SCALE = {
	FAST_TRIGGER_REMAIN_TIME = 30,
	NORMAL = 1,
	FAST = 2
}

function ReversePacmanConst:GetGameplayTimeScale()
	if self ~= nil and self < ReversePacmanConst.GAMEPLAY_TIME_SCALE.FAST_TRIGGER_REMAIN_TIME then
		return ReversePacmanConst.GAMEPLAY_TIME_SCALE.FAST
	end

	return ReversePacmanConst.GAMEPLAY_TIME_SCALE.NORMAL
end

ReversePacmanConst.TAG_SPEED_FACTOR = {
	[ReversePacmanConst.TAG.ISOLATED] = 1,
	[ReversePacmanConst.TAG.DEAD_END] = 1,
	[ReversePacmanConst.TAG.CORRIDOR] = 1.1,
	[ReversePacmanConst.TAG.CORNER] = 0.9,
	[ReversePacmanConst.TAG.JUNCTION] = 0.8
}
ReversePacmanConst.ROLE_RADIUS = {
	[ReversePacmanConst.ROLE.SHIP] = 25,
	[ReversePacmanConst.ROLE.MONSTER] = 30
}
ReversePacmanConst.GRADE = {
	A = "A",
	C = "C",
	S = "S",
	B = "B"
}
ReversePacmanConst.RESULT_TYPE = {
	SUCCESS = 1,
	FAIL = 2
}
ReversePacmanConst.MONSTER_TRAP_MIN_COMPONENT_NODES = 12
ReversePacmanConst.MONSTER_TRAP_COMPONENT_RATIO = 0.1

function ReversePacmanConst:GetGrade(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1 > 0 and calcFloor(self / arg_2_1 * 100) or 0
	local var_2_1 = arg_2_2[2] or 50
	local var_2_2 = arg_2_2[3] or 30

	if (arg_2_2[1] or 80) <= var_2_0 then
		return ReversePacmanConst.GRADE.S
	end

	if var_2_1 <= var_2_0 then
		return ReversePacmanConst.GRADE.A
	end

	if var_2_2 <= var_2_0 then
		return ReversePacmanConst.GRADE.B
	end

	return ReversePacmanConst.GRADE.C
end

return ReversePacmanConst
