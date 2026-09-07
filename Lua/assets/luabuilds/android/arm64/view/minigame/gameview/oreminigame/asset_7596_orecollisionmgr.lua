local OreCollisionMgr = class("OreCollisionMgr")

function OreCollisionMgr:Ctor(arg_1_1)
	self.binder = arg_1_1
	self.oreMap = {}
	self.enemyMap = {}

	return
end

function OreCollisionMgr:SetAkashiObject(arg_2_1)
	self.akashiControl = arg_2_1

	return
end

function OreCollisionMgr:AddOreObject(arg_3_1, arg_3_2)
	self.oreMap[arg_3_1] = arg_3_2

	return
end

function OreCollisionMgr:RemoveOreObject(arg_4_1, arg_4_2)
	self.oreMap[arg_4_1] = nil

	return
end

function OreCollisionMgr:AddEnemyObject(arg_5_1, arg_5_2, arg_5_3)
	self.enemyMap[arg_5_1] = self.enemyMap[arg_5_1] or {}
	self.enemyMap[arg_5_1][arg_5_2] = arg_5_3

	return
end

function OreCollisionMgr:RemoveEnemyObject(arg_6_1, arg_6_2, arg_6_3)
	self.enemyMap[arg_6_1][arg_6_2] = nil

	return
end

function OreCollisionMgr:Reset()
	self.oreMap = {}
	self.enemyMap = {}
	self.oreTarget = ""

	return
end

local function var_0_1(arg_8_0, arg_8_1)
	local var_8_0 = {
		x = math.abs(arg_8_1.pos.x - arg_8_0.pos.x),
		y = math.abs(arg_8_1.pos.y - arg_8_0.pos.y)
	}

	if math.abs(arg_8_0.aabb[2][1] - arg_8_0.aabb[1][1]) / 2 + math.abs(arg_8_1.aabb[2][1] - arg_8_1.aabb[1][1]) / 2 > var_8_0.x and math.abs(arg_8_0.aabb[2][2] - arg_8_0.aabb[1][2]) / 2 + math.abs(arg_8_1.aabb[2][2] - arg_8_1.aabb[1][2]) / 2 > var_8_0.y then
		return true
	end

	return false
end

local function var_0_2(arg_9_0, arg_9_1, arg_9_2)
	switch(arg_9_0, {
		W = function()
			return arg_9_2.x < arg_9_1.x
		end,
		N = function()
			return arg_9_2.y > arg_9_1.y
		end,
		E = function()
			return arg_9_2.x > arg_9_1.x
		end,
		S = function()
			return arg_9_2.y < arg_9_1.y
		end
	})

	return false
end

function OreCollisionMgr:GetCarryOreTarget()
	local var_14_0
	local var_14_1
	local var_14_2 = self.akashiControl:GetAnimDirLabel()
	local var_14_3 = self.akashiControl:GetCollisionInfo().pos

	for iter_14_0, iter_14_1 in pairs(self.oreMap) do
		local var_14_4 = iter_14_1:GetCollisionInfo().pos

		if var_0_2(var_14_2, var_14_3, var_14_4) then
			local var_14_5 = Vector2.Distance(var_14_3, var_14_4)

			if var_14_5 <= OreGameConfig.CARRY_LOOKAT_RADIUS then
				if var_14_1 then
					if var_14_5 <= var_14_1 then
						var_14_1 = var_14_5
						var_14_0 = iter_14_0
					end
				end
			end
		end
	end

	if var_14_0 and var_14_1 then
		return var_14_0
	end

	for iter_14_2, iter_14_3 in pairs(self.oreMap) do
		local var_14_6 = Vector2.Distance(var_14_3, iter_14_3:GetCollisionInfo().pos)

		if var_14_6 <= OreGameConfig.CARRY_RADIUS then
			if var_14_1 then
				if var_14_6 <= var_14_1 then
					var_14_1 = var_14_6
					var_14_0 = iter_14_2
				end
			end
		end
	end

	return var_14_0 or ""
end

function OreCollisionMgr:UpdateOreStatus()
	local var_15_0 = self:GetCarryOreTarget()

	if self.oreTarget ~= var_15_0 then
		self.oreTarget = var_15_0

		self.binder:emit(OreGameConfig.EVENT_UPDATE_ORE_TARGET, {
			index = self.oreTarget
		})
	end

	return
end

function OreCollisionMgr:UpdateAkashiCollision()
	if self.akashiControl:IsInvincible() then
		return
	end

	local var_16_0 = self.akashiControl:GetCollisionInfo()

	for iter_16_0, iter_16_1 in pairs(self.enemyMap) do
		for iter_16_2, iter_16_3 in pairs(iter_16_1) do
			if var_0_1(var_16_0, (iter_16_3:GetCollisionInfo())) then
				self.binder:emit(OreGameConfig.EVENT_AKASHI_COLLISION, {
					a = self.akashiControl,
					b = iter_16_3
				})

				return
			end
		end
	end

	return
end

function OreCollisionMgr:UpdateEnemyCollision()
	for iter_17_0, iter_17_1 in pairs(self.enemyMap) do
		local var_17_0 = {}

		for iter_17_2, iter_17_3 in pairs(iter_17_1) do
			var_17_0[iter_17_2] = var_17_0[iter_17_2] or {}

			local var_17_1 = iter_17_3:GetCollisionInfo()

			for iter_17_4, iter_17_5 in pairs(iter_17_1) do
				var_17_0[iter_17_4] = var_17_0[iter_17_4] or {}

				if iter_17_4 ~= iter_17_2 and not var_17_0[iter_17_2][iter_17_4] and not var_17_0[iter_17_4][iter_17_2] then
					if var_0_1(var_17_1, (iter_17_5:GetCollisionInfo())) then
						self.binder:emit(OreGameConfig.EVENT_ENEMY_COLLISION, {
							a = iter_17_3,
							b = iter_17_5
						})
					end

					var_17_0[iter_17_2][iter_17_4] = true
					var_17_0[iter_17_4][iter_17_2] = true
				end
			end
		end
	end

	return
end

function OreCollisionMgr:OnTimer(arg_18_1)
	self:UpdateOreStatus()
	self:UpdateAkashiCollision()
	self:UpdateEnemyCollision()

	return
end

return OreCollisionMgr
