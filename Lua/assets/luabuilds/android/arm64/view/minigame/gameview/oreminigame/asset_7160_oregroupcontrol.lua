local OreGroupControl = class("OreGroupControl")

function OreGroupControl:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.binder = arg_1_1
	self._tf = arg_1_2
	self.collisionMgr = arg_1_3
	self.tpls = findTF(self._tf, "tpl")
	self.oresTF = findTF(self._tf, "ores")
	self.oreList = {}
	self.poolTF = findTF(self._tf, "pool")

	self:AddListener()

	return
end

function OreGroupControl:AddListener()
	self.binder:bind(OreGameConfig.EVENT_ORE_NEW, function(arg_3_0, arg_3_1)
		self:NewOre(arg_3_1.index, arg_3_1.pos)

		return
	end)
	self.binder:bind(OreGameConfig.EVENT_ORE_DESTROY, function(arg_4_0, arg_4_1)
		self.oreList[arg_4_1.index] = nil

		self:ReturnOre(findTF(self.oresTF, arg_4_1.index), arg_4_1.id)

		return
	end)

	return
end

function OreGroupControl:NewOre(arg_5_1, arg_5_2)
	if not findTF(self.oresTF, arg_5_1) then
		local var_5_0, var_5_1 = self:GetNewOreConfig()
		local var_5_2 = self:GetOre(var_5_0)

		var_5_2:SetParent(self.oresTF, false)

		var_5_2.name = arg_5_1

		SetActive(var_5_2, true)

		self.oreList[arg_5_1] = Ore.New(self.binder, var_5_2, self.collisionMgr, var_5_0, arg_5_2)

		self.binder:emit(OreGameConfig.EVENT_ORE_EF_MINED, {
			index = arg_5_1
		})
	end

	return
end

function OreGroupControl:Reset()
	for iter_6_0, iter_6_1 in pairs(self.oreList) do
		iter_6_1:Dispose()
	end

	self.oreList = {}

	removeAllChildren(self.oresTF)

	self.weightTable = OreGameConfig.ORE_REFRESH_WEIGHT[math.random(#OreGameConfig.ORE_REFRESH_WEIGHT)]
	self.count = 0
	self.pools = {}

	removeAllChildren(self.poolTF)

	return
end

function OreGroupControl:GetNewOreConfig()
	if self.count == OreGameConfig.DIAMOND_CONFIH.count then
		local var_7_0 = OreGameConfig.DIAMOND_CONFIH.probability[1] > math.random() and 7 or 8

		self.count = 0

		return var_7_0, OreGameConfig.ORE_CONFIG[var_7_0]
	end

	local var_7_1 = OreGameHelper.GetOreIDWithWeight(self.weightTable)

	self.count = OreGameConfig.ORE_CONFIG[var_7_1].type == 4 and 0 or self.count + 1

	return var_7_1, OreGameConfig.ORE_CONFIG[var_7_1]
end

function OreGroupControl:OnTimer(arg_8_1)
	for iter_8_0, iter_8_1 in pairs(self.oreList) do
		iter_8_1:OnTimer(arg_8_1)
	end

	return
end

function OreGroupControl:GetOre(arg_9_1)
	if self.pools[arg_9_1] and #self.pools[arg_9_1] > 0 then
		return table.remove(self.pools[arg_9_1])
	end

	return (tf(Instantiate(findTF(self.tpls, "tpl_" .. arg_9_1))))
end

function OreGroupControl:ReturnOre(arg_10_1, arg_10_2)
	self.pools[arg_10_2] = self.pools[arg_10_2] or {}

	arg_10_1:SetParent(tf(self.poolTF), false)
	setActive(arg_10_1, false)
	table.insert(self.pools[arg_10_2], tf(arg_10_1))

	return
end

return OreGroupControl
