class = var_0_10000

local var_0_0 = var_0_10000("PacGameRoleController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._sceneMask = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._runningData = arg_1_3
	findTF = var_1_10004
	arg_1_0._content = var_1_10004(arg_1_0._sceneMask, "sceneContainer/scene/content/map")

	return
end

function var_0_0.SetParent(arg_2_0)
	return
end

function var_0_0.SetPosition(arg_3_0)
	return
end

function var_0_0.SetScale(arg_4_0)
	return
end

function var_0_0.Prepare(arg_5_0)
	local var_5_0 = arg_5_0._runningData
	local var_5_1 = var_1.GetConfig(var_5_0, "player")
	local var_5_2 = arg_5_0._runningData
	local var_5_3 = var_2.GetConfig(var_5_2, "enemy")

	arg_5_0._player = arg_5_0:createRole(var_5_1, false)
	arg_5_0._enemys = arg_5_0:createRoles(var_5_3, true)

	local var_5_4 = arg_5_0._player

	var_3.SetPlayer(var_5_4, true)

	local var_5_5 = arg_5_0._runningData

	var_3.SetPlayer(var_5_5, arg_5_0._player)

	local var_5_6 = arg_5_0._runningData

	var_3.SetEnemys(var_5_6, arg_5_0._enemys)

	local var_5_7 = arg_5_0._runningData
	local var_5_8 = var_3.GetMapConfig(var_5_7, "player_start")
	local var_5_9 = arg_5_0._runningData
	local var_5_10 = var_4.GetMapConfig(var_5_9, "enemy_start")

	arg_5_0:setRolePosWithIndex(arg_5_0._player, var_5_8, true)
	arg_5_0:setRolesPosWithIndex(arg_5_0._enemys, var_5_10, true)

	return
end

function var_0_0.Start(arg_6_0)
	return
end

function var_0_0.Step(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._player

	var_2.Step(var_7_0, arg_7_1)

	ipairs = var_2

	for iter_7_0, iter_7_1 in var_2(arg_7_0._enemys) do
		iter_7_1:Step(arg_7_1)
	end

	arg_7_0:updatePlayerDirect()

	return
end

function var_0_0.Clear(arg_8_0)
	if arg_8_0._player then
		local var_8_0 = arg_8_0._player

		var_1.Dispose(var_8_0)

		arg_8_0._player = nil
	end

	if arg_8_0._enemys then
		ipairs = var_1

		for iter_8_0, iter_8_1 in var_1(arg_8_0._enemys) do
			iter_8_1:Dispose()
		end

		arg_8_0._enemys = {}
	end

	local var_8_1 = arg_8_0._runningData

	var_1.SetPlayer(var_8_1, nil)

	local var_8_2 = arg_8_0._runningData

	var_1.SetEnemys(var_8_2, {})

	return
end

function var_0_0.Stop(arg_9_0)
	return
end

function var_0_0.Resume(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	return
end

function var_0_0.updatePlayerDirect(arg_12_0)
	local var_12_0 = arg_12_0._runningData
	local var_12_1 = var_1.GetJoyData(var_12_0).x
	local var_12_2 = var_1.y

	math = var_1_10004

	local var_12_3 = var_1_10004.abs(var_12_1)

	math = var_5

	local var_12_4

	if var_12_3 - var_5.abs(var_12_2) >= 0.3 then
		var_12_2 = 0
	else
		math = var_12_4
		var_12_4 = var_12_4.abs(var_12_1)
		math = var_5

		if var_12_4 - var_5.abs(var_12_2) <= -0.3 then
			var_12_1 = 0
		end
	end

	math = var_12_4

	local var_12_5 = var_12_4.sign(var_12_1)

	math = var_5

	local var_12_6 = var_5.sign(var_12_2)
	local var_12_7 = arg_12_0._player

	var_6.SetDirect(var_12_7, {
		var_12_5,
		var_12_6
	})

	return
end

function var_0_0.setRolePosWithIndex(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0._runningData
	local var_13_1 = var_4.GetPosByIndex(var_13_0, arg_13_2)

	arg_13_1:SetPosition(var_13_1)
	arg_13_1:SetActive(arg_13_3)
	arg_13_1:SetGridIndex(arg_13_2)
	arg_13_1:SetStartIndex(arg_13_2)

	return
end

function var_0_0.setRolesPosWithIndex(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	for iter_14_0 = 1, #arg_14_1 do
		arg_14_0:setRolePosWithIndex(arg_14_1[iter_14_0], arg_14_2[iter_14_0], arg_14_3)
	end

	return
end

function var_0_0.createRole(arg_15_0, arg_15_1)
	PacGameConst = var_1_10002

	local var_15_0 = var_1_10002.role_data[arg_15_1].prefab
	local var_15_1 = arg_15_0._runningData
	local var_15_2 = var_4.GetTplItemFromPool(var_15_1, var_15_0, arg_15_0._content)

	PacGameRole = var_15_1

	return (var_15_1.New(var_15_2, var_2))
end

function var_0_0.createRoles(arg_16_0, arg_16_1)
	local var_16_0 = {}

	for iter_16_0 = 1, #arg_16_1 do
		local var_16_1 = arg_16_0
		local var_16_2 = arg_16_0.createRole(var_16_1, arg_16_1[iter_16_0])

		table = var_16_1

		var_16_1.insert(var_16_0, var_16_2)
	end

	return var_16_0
end

return var_0_0
