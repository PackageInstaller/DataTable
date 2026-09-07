local WSPool = class("WSPool", import("...BaseEntity"))

WSPool.Fields = {
	tplDic = "table",
	pooltf = "userdata",
	pools = "table"
}

function WSPool:Setup(arg_1_1)
	self.pools = {}
	self.pooltf = GameObject.Find("__Pool__").transform
	self.tplDic = {}

	eachChild(tf(arg_1_1), function(arg_2_0, arg_2_1)
		self.tplDic[arg_2_0.name] = arg_2_0

		return
	end)
	setActive(arg_1_1, false)

	return
end

function WSPool:Dispose()
	for iter_3_0, iter_3_1 in pairs(self.pools) do
		_.each(iter_3_1, function(arg_4_0)
			Destroy(arg_4_0)

			return
		end)
	end

	for iter_3_2, iter_3_3 in pairs(self.tplDic) do
		self.tplDic[iter_3_2] = nil
	end

	self.tplDic = nil

	self:Clear()

	return
end

function WSPool:Get(arg_5_1)
	local var_5_0 = self.pools[arg_5_1]

	if not self.pools[arg_5_1] then
		var_5_0 = {}
		self.pools[arg_5_1] = var_5_0
	end

	local var_5_1 = #var_5_0 > 0 and table.remove(var_5_0, #var_5_0) or Instantiate(self.tplDic[arg_5_1])

	setActive(var_5_1, true)
	tf(var_5_1):SetParent(self.pooltf, false)

	return var_5_1
end

function WSPool:Return(arg_6_1, arg_6_2)
	setActive(arg_6_2, false)
	arg_6_2.transform:SetParent(self.pooltf, false)
	table.insert(self.pools[arg_6_1], arg_6_2)

	return
end

return WSPool
