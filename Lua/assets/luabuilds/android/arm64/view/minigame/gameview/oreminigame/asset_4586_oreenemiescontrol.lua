local OreEnemiesControl = class("OreEnemiesControl")

function OreEnemiesControl:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.binder = arg_1_1
	self.collisionMgr = arg_1_3
	self._tf = arg_1_2
	self.poolTF = findTF(self._tf, "pool")

	self:Init()

	return
end

function OreEnemiesControl:AddListener()
	self.binder:bind(OreGameConfig.EVENT_ENEMY_DESTROY, function(arg_3_0, arg_3_1)
		self.enemyList[arg_3_1.roadID][arg_3_1.index] = nil

		self:ReturnEnemy(findTF(self.roadTFs[arg_3_1.roadID], arg_3_1.index), arg_3_1.id)

		return
	end)

	return
end

function OreEnemiesControl:Init()
	self:AddListener()

	self.roadTFs = {
		findTF(self._tf, "road_1"),
		findTF(self._tf, "road_2"),
		(findTF(self._tf, "road_3"))
	}
	self.tpls = findTF(self._tf, "tpls")
	self.enemyList = {}

	self:Reset()

	return
end

function OreEnemiesControl:InitCreatList()
	local function var_5_0(arg_6_0, arg_6_1)
		if not self.createList[arg_6_0] then
			self.createList[arg_6_0] = {
				arg_6_1
			}
		else
			table.insert(self.createList[arg_6_0], arg_6_1)
		end

		return
	end

	local function var_5_1(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = OreGameConfig.CREATE_CONFIG[arg_7_2].num
		local var_7_1 = Clone(OreGameConfig.CREATE_CONFIG[arg_7_2].enemy)

		assert(OreGameConfig.CREATE_CONFIG[arg_7_2].num <= #var_7_1, "create cfg illegal. ID: " .. arg_7_2)

		local var_7_2 = arg_7_0

		for iter_7_0 = 1, var_7_0 do
			local var_7_3 = math.random(1, #var_7_1)

			table.remove(var_7_1, var_7_3)
			var_5_0(arg_7_0, {
				roadID = arg_7_1,
				enemyID = var_7_1[var_7_3]
			})

			var_7_2 = arg_7_0 + 1
		end

		return
	end

	self.roadDir = OreGameConfig.ROAD_DIRECTION[math.random(#OreGameConfig.ROAD_DIRECTION)]

	for iter_5_0, iter_5_1 in ipairs(self.roadTFs) do
		if OreGameConfig.ROAD_CONFIG_TYPE[iter_5_0] == 1 then
			for iter_5_2, iter_5_3 in ipairs(OreGameConfig["CREATE_ENEMY_ROAD_" .. iter_5_0]) do
				var_5_1(iter_5_3.time, iter_5_0, iter_5_3.create)
			end
		elseif OreGameConfig.ROAD_CONFIG_TYPE[iter_5_0] == 2 then
			for iter_5_4, iter_5_5 in ipairs(OreGameConfig["CREATE_ENEMY_ROAD_" .. iter_5_0]) do
				while iter_5_5.time < iter_5_5.stop do
					var_5_1(iter_5_5.time, iter_5_0, iter_5_5.create)

					local var_5_2 = iter_5_5.time + math.random(iter_5_5.step[1], iter_5_5.step[2])
				end
			end
		end
	end

	return
end

function OreEnemiesControl:CreateEnemy(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		self.indexTags[iter_8_1.roadID] = self.indexTags[iter_8_1.roadID] + 1

		local var_8_0 = self:GetEnemy(iter_8_1.enemyID)

		var_8_0:SetParent(tf(self.roadTFs[iter_8_1.roadID]), false)

		var_8_0.name = self.indexTags[iter_8_1.roadID] + 1

		SetActive(var_8_0, true)

		self.enemyList[iter_8_1.roadID] = self.enemyList[iter_8_1.roadID] or {}
		self.enemyList[iter_8_1.roadID][self.indexTags[iter_8_1.roadID] + 1] = OreEnemy.New(self.binder, var_8_0, self.collisionMgr, iter_8_1.enemyID, iter_8_1.roadID, self.roadDir[iter_8_1.roadID])
	end

	return
end

function OreEnemiesControl:Reset()
	self.time = 0
	self.createList = {}

	for iter_9_0, iter_9_1 in pairs(self.enemyList) do
		for iter_9_2, iter_9_3 in pairs(iter_9_1) do
			iter_9_3:Dispose()
		end
	end

	self.enemyList = {}
	self.indexTags = {
		0,
		0,
		0
	}

	for iter_9_4, iter_9_5 in pairs(self.roadTFs) do
		removeAllChildren(iter_9_5)
	end

	self:InitCreatList()

	self.pools = {}

	removeAllChildren(self.poolTF)

	return
end

function OreEnemiesControl:OnTimer(arg_10_1)
	self.time = self.time + arg_10_1

	for iter_10_0, iter_10_1 in pairs(self.createList) do
		if iter_10_0 <= self.time then
			self:CreateEnemy(iter_10_1)

			self.createList[iter_10_0] = nil
		end
	end

	for iter_10_2, iter_10_3 in pairs(self.enemyList) do
		for iter_10_4, iter_10_5 in pairs(iter_10_3) do
			iter_10_5:OnTimer(arg_10_1)
		end
	end

	return
end

function OreEnemiesControl:GetEnemy(arg_11_1)
	if self.pools[arg_11_1] and #self.pools[arg_11_1] > 0 then
		return table.remove(self.pools[arg_11_1])
	end

	return (tf(Instantiate(findTF(self.tpls, arg_11_1))))
end

function OreEnemiesControl:ReturnEnemy(arg_12_1, arg_12_2)
	self.pools[arg_12_2] = self.pools[arg_12_2] or {}

	arg_12_1:SetParent(tf(self.poolTF), false)
	setActive(arg_12_1, false)
	table.insert(self.pools[arg_12_2], tf(arg_12_1))

	return
end

return OreEnemiesControl
