local PacGameRoleController = class("PacGameRoleController")

function PacGameRoleController:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._sceneMask = arg_1_1
	self._event = arg_1_2
	self._runningData = arg_1_3
	self._content = findTF(self._sceneMask, "sceneContainer/scene/content/map")

	return
end

function PacGameRoleController:SetParent()
	return
end

function PacGameRoleController:SetPosition()
	return
end

function PacGameRoleController:SetScale()
	return
end

function PacGameRoleController:Prepare()
	self._player = self:createRole(self._runningData:GetConfig("player"), false)
	self._enemys = self:createRoles(self._runningData:GetConfig("enemy"), true)

	self._player:SetPlayer(true)
	self._runningData:SetPlayer(self._player)
	self._runningData:SetEnemys(self._enemys)
	self:setRolePosWithIndex(self._player, self._runningData:GetMapConfig("player_start"), true)
	self:setRolesPosWithIndex(self._enemys, self._runningData:GetMapConfig("enemy_start"), true)

	return
end

function PacGameRoleController:Start()
	return
end

function PacGameRoleController:Step(arg_7_1)
	self._player:Step(arg_7_1)

	for iter_7_0, iter_7_1 in ipairs(self._enemys) do
		iter_7_1:Step(arg_7_1)
	end

	self:updatePlayerDirect()

	return
end

function PacGameRoleController:Clear()
	if self._player then
		self._player:Dispose()

		self._player = nil
	end

	if self._enemys then
		for iter_8_0, iter_8_1 in ipairs(self._enemys) do
			iter_8_1:Dispose()
		end

		self._enemys = {}
	end

	self._runningData:SetPlayer(nil)
	self._runningData:SetEnemys({})

	return
end

function PacGameRoleController:Stop()
	return
end

function PacGameRoleController:Resume()
	return
end

function PacGameRoleController:Dispose()
	return
end

function PacGameRoleController:updatePlayerDirect()
	local var_12_0 = self._runningData:GetJoyData()
	local var_12_1 = var_12_0.x
	local var_12_2 = var_12_0.y

	if math.abs(var_12_0.x) - math.abs(var_12_0.y) >= 0.3 then
		var_12_2 = 0
	else
		local var_12_3

		if math.abs(var_12_1) - math.abs(var_12_2) <= -0.3 then
			var_12_1 = 0
			var_12_3 = {}
		end
	end

	var_12_3[1] = math.sign(var_12_1)
	var_12_3[2] = math.sign(var_12_2)

	self._player:SetDirect(var_12_3)

	return
end

function PacGameRoleController:setRolePosWithIndex(arg_13_1, arg_13_2, arg_13_3)
	arg_13_1:SetPosition((self._runningData:GetPosByIndex(arg_13_2)))
	arg_13_1:SetActive(arg_13_3)
	arg_13_1:SetGridIndex(arg_13_2)
	arg_13_1:SetStartIndex(arg_13_2)

	return
end

function PacGameRoleController:setRolesPosWithIndex(arg_14_1, arg_14_2, arg_14_3)
	for iter_14_0 = 1, #arg_14_1 do
		self:setRolePosWithIndex(arg_14_1[iter_14_0], arg_14_2[iter_14_0], arg_14_3)
	end

	return
end

function PacGameRoleController:createRole(arg_15_1)
	return (PacGameRole.New(self._runningData:GetTplItemFromPool(PacGameConst.role_data[arg_15_1].prefab, self._content), PacGameConst.role_data[arg_15_1]))
end

function PacGameRoleController:createRoles(arg_16_1)
	local var_16_0 = {}

	for iter_16_0 = 1, #arg_16_1 do
		table.insert(var_16_0, (self:createRole(arg_16_1[iter_16_0])))
	end

	return var_16_0
end

return PacGameRoleController
