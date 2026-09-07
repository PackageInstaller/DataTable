pg = pg or {}

local var_0_0 = pg
local PoolUtil = require("Mgr/Pool/PoolUtil")
local Pool = class("Pool")

pg.Pool = Pool

function Pool:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	assert(arg_1_2, "template or transform should exist")

	self.template = arg_1_2
	self.keepParent = arg_1_5
	self.parentTF = arg_1_1
	self.templateActive = arg_1_2.activeSelf
	self.parentActive = arg_1_1.gameObject.activeSelf
	self.keepActive = arg_1_6
	self.min = arg_1_3
	self.list = ys.LinkList.New()
	self.map = {}
	self.usedEnd = nil
	self.resizeTime = arg_1_4

	return
end

function Pool:InitSize(arg_2_1)
	arg_2_1 = arg_2_1 or self.min

	local var_2_0 = {}

	for iter_2_0 = 1, arg_2_1 do
		var_2_0[iter_2_0] = self:GetObject()
	end

	for iter_2_1 = 1, arg_2_1 do
		self:Recycle(var_2_0[iter_2_1])
	end

	return self
end

function Pool:SetInitFuncs(arg_3_1)
	self.initFunc = arg_3_1

	return
end

function Pool:SetRecycleFuncs(arg_4_1)
	self.recycleFunc = arg_4_1

	return
end

function Pool:IsEmpty()
	return self.usedEnd == self.list.Tail
end

function Pool:GetRootTF()
	return self.parentTF
end

function Pool:GetObject()
	local var_7_0
	local var_7_1 = self.usedEnd

	if not self:IsEmpty() then
		var_7_1 = var_7_1 == nil and self.list.Head or self.usedEnd.Next

		while var_7_1 do
			var_7_0 = var_7_1.Data

			if var_7_1.Data and not IsNil(var_7_0) and var_7_0.transform and not IsNil(var_7_0.transform) then
				self.usedEnd = var_7_1
				self.map[var_7_0] = var_7_1

				LuaHelper.ResetTF(var_7_0.transform)

				if not self.keepActive and self.parentActive then
					var_7_0:SetActive(true)
				end

				break
			end

			self.map[var_7_0] = nil
			var_7_1 = var_7_1.Next, self.list:Remove(var_7_1)
		end
	else
		var_7_0 = Object.Instantiate(self.template)

		if not self.templateActive then
			var_7_0:SetActive(true)
		end

		if self.keepParent then
			var_7_0.transform:SetParent(self.parentTF, false)
		end

		if self.initFunc then
			self.initFunc(var_7_0)
		end

		local var_7_2 = self.list:AddLast(var_7_0)

		self.usedEnd = var_7_2
		self.map[var_7_0] = var_7_2
	end

	return var_7_0
end

function Pool:ResetParent(arg_8_1)
	self.parentTF = arg_8_1

	for iter_8_0 in self.list:Iterator() do
		iter_8_0.Data.transform:SetParent(self.parentTF, false)
	end

	return
end

function Pool:Recycle(arg_9_1)
	if self.map[arg_9_1] == nil then
		return
	end

	self.map[arg_9_1] = nil

	if not self.keepActive and self.parentActive then
		arg_9_1:SetActive(false)
	end

	if not self.keepParent then
		LuaHelper.SetGOParentTF(arg_9_1, self.parentTF, false)
	end

	if self.recycleFunc then
		self.recycleFunc(arg_9_1)
	end

	if self.usedEnd == self.map[arg_9_1] then
		self.usedEnd = self.map[arg_9_1].Before
	end

	self.list:Remove(self.map[arg_9_1])
	self.list:AddNodeLast(self.map[arg_9_1])

	self.map[arg_9_1].liveTime = var_0_0.TimeMgr.GetInstance():GetCombatTime() + self.resizeTime

	return
end

function Pool:AllRecycle()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(self.map) do
		table.insert(var_10_0, iter_10_0)
	end

	for iter_10_2, iter_10_3 in ipairs(var_10_0) do
		self:Recycle(iter_10_3)
	end

	return
end

function Pool:Resize()
	if self.list.Count <= self.min then
		return
	end

	local var_11_0 = self.usedEnd and self.usedEnd.Next or self.list.Head
	local var_11_1 = var_0_0.TimeMgr.GetInstance():GetCombatTime()
	local var_11_2 = 0

	while var_11_0 do
		if var_11_1 < var_11_0.liveTime then
			break
		end

		PoolUtil.Destroy(var_11_0.Data)

		var_11_0 = var_11_0.Next, self.list:Remove(var_11_0)
		var_11_2 = var_11_2 + 1

		if var_11_2 >= 6 or self.list.Count <= self.min then
			break
		end
	end

	return
end

function Pool:Dispose()
	for iter_12_0 in self.list:Iterator() do
		PoolUtil.Destroy(iter_12_0.Data)
	end

	self.list = nil
	self.map = nil
	self.last = nil
	self.template = nil
	self.parentTF = nil

	return
end

return
