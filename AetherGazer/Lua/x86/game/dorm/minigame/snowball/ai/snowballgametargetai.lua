local var_0_0 = singletonClass("SnowballGameTargetAI")
local var_0_1 = {
	stop = 0,
	l = -1,
	r = 1
}

function var_0_0.Ctor(arg_1_0)
	pauseNonHumanoid = false
	pause = false
end

local function var_0_2(arg_2_0)
	return SnowballGameUnitCfg[arg_2_0].stop_time
end

local function var_0_3(arg_3_0)
	return SnowballGameUnitCfg[arg_3_0].move_time
end

local var_0_4 = Dorm.DormEntityManager.QueryPosition
local var_0_5 = Dorm.DormEntityManager.QuerySpeed

function var_0_0.AddEntityToRow(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:Remove(arg_4_1)

	local var_4_0 = DormUtils.GetEntityData(arg_4_1)
	local var_4_1 = var_4_0.cfgID
	local var_4_2 = var_4_0.isHumanoidTarget

	table.insert(arg_4_0.row[arg_4_2], {
		move = false,
		eid = arg_4_1,
		dir = var_0_1.stop,
		isHumanoidTarget = var_4_2,
		unitType = var_4_1,
		timer = var_0_2(var_4_1)
	})
	table.sort(arg_4_0.row[arg_4_2], function(arg_5_0, arg_5_1)
		local var_5_0 = var_0_4(arg_5_0.eid)
		local var_5_1 = var_0_4(arg_5_1.eid)

		return var_5_0.x < var_5_1.x
	end)
end

function var_0_0.Remove(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.row) do
		for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
			if iter_6_3.eid == arg_6_1 then
				table.remove(iter_6_1, iter_6_2)

				break
			end
		end
	end
end

local function var_0_6(arg_7_0)
	return Dorm.storage:PickData(string.format("snowball.row%d.lbound", arg_7_0)).transform, Dorm.storage:PickData(string.format("snowball.row%d.rbound", arg_7_0)).transform
end

local function var_0_7(arg_8_0)
	return arg_8_0 < 0
end

local function var_0_8(arg_9_0)
	return arg_9_0 > 0
end

local function var_0_9(arg_10_0, arg_10_1)
	local var_10_0 = Vector3(arg_10_0.x, 0, arg_10_0.z)
	local var_10_1 = Vector3(arg_10_1.x, 0, arg_10_1.z)

	return Vector3.Distance(var_10_0, var_10_1) <= 1
end

local function var_0_10(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_2.dir
	local var_11_1 = arg_11_3.dir
	local var_11_2 = var_0_4(arg_11_0)
	local var_11_3 = var_0_4(arg_11_1)
	local var_11_4 = arg_11_2.move and var_11_0 * var_0_5(arg_11_0) or 0
	local var_11_5 = arg_11_3.move and var_11_1 * var_0_5(arg_11_1) or 0

	if var_11_2.x > var_11_3.x then
		var_11_2, var_11_3 = var_11_3, var_11_2
		var_11_4, var_11_5 = var_11_5, var_11_4
	end

	return var_0_9(var_11_2, var_11_3) and var_11_5 < var_11_4
end

local function var_0_11(arg_12_0, arg_12_1, arg_12_2)
	if var_0_7(arg_12_0) then
		if arg_12_2 then
			return var_0_1.r
		else
			return var_0_1.stop
		end
	elseif var_0_8(arg_12_0) then
		if arg_12_1 then
			return var_0_1.l
		else
			return var_0_1.stop
		end
	end

	return arg_12_0
end

local function var_0_12(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = true
	local var_13_1 = true
	local var_13_2 = arg_13_1.eid
	local var_13_3 = var_0_4(var_13_2)
	local var_13_4 = arg_13_1.dir

	if arg_13_1.dir == var_0_1.stop then
		arg_13_1.dir = math.random() < 0.5 and var_0_1.l or var_0_1.r
	end

	if var_0_9(var_13_3, arg_13_3.position) then
		var_13_0 = false
		arg_13_1.dir = var_0_1.r
	elseif var_0_9(var_13_3, arg_13_4.position) then
		var_13_1 = false
		arg_13_1.dir = var_0_1.l
	end

	local var_13_5 = arg_13_2[arg_13_0 - 1]
	local var_13_6 = arg_13_2[arg_13_0 + 1]
	local var_13_7 = false

	if var_13_5 and var_0_7(arg_13_1.dir) and var_0_10(var_13_2, var_13_5.eid, arg_13_1, var_13_5) then
		var_13_0 = false
		var_13_7 = true
	end

	if var_13_6 and var_0_8(arg_13_1.dir) and var_0_10(var_13_2, var_13_6.eid, arg_13_1, var_13_6) then
		var_13_1 = false
		var_13_7 = true
	end

	if var_13_7 then
		arg_13_1.dir = var_0_11(arg_13_1.dir, var_13_0, var_13_1)
	end

	arg_13_1.dirChanged = var_13_4 ~= arg_13_1.dir
end

local function var_0_13(arg_14_0)
	if var_0_7(arg_14_0) then
		return "snowball_target_move_L"
	elseif var_0_8(arg_14_0) then
		return "snowball_target_move_R"
	end
end

local function var_0_14(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.eid
	local var_15_1 = Vector2(arg_15_0.dir, 0)

	Dorm.LuaBridge.MiniGameBridge.SetMoveControllerInput(var_15_0, var_15_1)

	if arg_15_0.dirChanged and arg_15_0.dir ~= var_0_1.stop then
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(var_15_0, var_0_13(arg_15_0.dir))
		Dorm.DormEntityManager.TryTriggerResetAnimeDuringMove(var_15_0)
	end
end

local function var_0_15(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.eid

	arg_16_0.timer = arg_16_0.timer - arg_16_1

	local var_16_1 = arg_16_0.move

	if arg_16_0.timer <= 0 then
		arg_16_0.timer = var_16_1 and var_0_2(arg_16_0.unitType) or var_0_3(arg_16_0.unitType)
		arg_16_0.move = not var_16_1
	end
end

function var_0_0.ShouldStop(arg_17_0, arg_17_1)
	return arg_17_0.pause or not arg_17_1.move or arg_17_0.pauseNonHumanoid and not arg_17_1.isHumanoidTarget
end

function var_0_0.Update(arg_18_0)
	local var_18_0 = DormCharacterActionManager.GetInstance():FrameTaskDeltaTime()

	for iter_18_0, iter_18_1 in pairs(arg_18_0.row) do
		local var_18_1, var_18_2 = var_0_6(iter_18_0)

		for iter_18_2, iter_18_3 in ipairs(iter_18_1) do
			local var_18_3 = iter_18_3.eid

			var_0_15(iter_18_3, var_18_0)

			if arg_18_0:ShouldStop(iter_18_3) then
				iter_18_3.dir = var_0_1.stop
			else
				var_0_12(iter_18_2, iter_18_3, iter_18_1, var_18_1, var_18_2)
			end
		end

		for iter_18_4, iter_18_5 in pairs(iter_18_1) do
			var_0_14(iter_18_5, var_18_0)
		end
	end
end

function var_0_0.Clear(arg_19_0)
	arg_19_0.row = {
		{},
		{},
		{}
	}
end

function var_0_0.Init(arg_20_0)
	arg_20_0:Clear()
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0.row = nil
end

return var_0_0
