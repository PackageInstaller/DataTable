local var_0_0 = class("PacGameRoleController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._sceneMask = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._runningData = arg_1_3
	arg_1_0._content = findTF(arg_1_0._sceneMask, "sceneContainer/scene/content/map")

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
	arg_5_0._player = arg_5_0:createRole(arg_5_0._runningData:GetConfig("player"), false)
	arg_5_0._enemys = arg_5_0:createRoles(arg_5_0._runningData:GetConfig("enemy"), true)

	arg_5_0._player:SetPlayer(true)
	arg_5_0._runningData:SetPlayer(arg_5_0._player)
	arg_5_0._runningData:SetEnemys(arg_5_0._enemys)
	arg_5_0:setRolePosWithIndex(arg_5_0._player, arg_5_0._runningData:GetMapConfig("player_start"), true)
	arg_5_0:setRolesPosWithIndex(arg_5_0._enemys, arg_5_0._runningData:GetMapConfig("enemy_start"), true)

	return
end

function var_0_0.Start(arg_6_0)
	return
end

function var_0_0.Step(arg_7_0, arg_7_1)
	arg_7_0._player:Step(arg_7_1)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._enemys) do
		iter_7_1:Step(arg_7_1)
	end

	arg_7_0:updatePlayerDirect()

	return
end

function var_0_0.Clear(arg_8_0)
	if arg_8_0._player then
		arg_8_0._player:Dispose()

		arg_8_0._player = nil
	end

	if arg_8_0._enemys then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0._enemys) do
			iter_8_1:Dispose()
		end

		arg_8_0._enemys = {}
	end

	arg_8_0._runningData:SetPlayer(nil)
	arg_8_0._runningData:SetEnemys({})

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
	local var_12_0 = arg_12_0._runningData:GetJoyData()
	local var_12_1 = var_12_0.x
	local var_12_2 = var_12_0.y

	if math.abs(var_12_0.x) - math.abs(var_12_0.y) >= 0.3 then
		var_12_2 = 0
	elseif math.abs(var_12_1) - math.abs(var_12_2) <= -0.3 then
		var_12_1 = 0
	end

	;({})[1] = math.sign(var_12_1)
	;({})[2] = math.sign(var_12_2)

	arg_12_0._player:SetDirect({})

	return
end

function var_0_0.setRolePosWithIndex(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_1:SetPosition((arg_13_0._runningData:GetPosByIndex(arg_13_2)))
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
	return (PacGameRole.New(arg_15_0._runningData:GetTplItemFromPool(PacGameConst.role_data[arg_15_1].prefab, arg_15_0._content), PacGameConst.role_data[arg_15_1]))
end

function var_0_0.createRoles(arg_16_0, arg_16_1)
	for iter_16_0 = 1, #arg_16_1 do
		table.insert({}, (arg_16_0:createRole(arg_16_1[iter_16_0])))
	end

	return {}
end

return var_0_0
