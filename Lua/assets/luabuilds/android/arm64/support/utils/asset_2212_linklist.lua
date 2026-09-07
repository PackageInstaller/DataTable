ys = ys or {}
ys.LinkList = class("LinkList")
ys.LinkList.Head = nil
ys.LinkList.Tail = nil
ys.LinkList.Count = 0

function ys.LinkList.Ctor(arg_1_0)
	return
end

function ys.LinkList.Clear(arg_2_0)
	arg_2_0.Head = nil
	arg_2_0.Tail = nil
	arg_2_0.Count = 0

	return
end

function ys.LinkList.NewNode(arg_3_0, arg_3_1)
	return {
		Data = arg_3_1
	}
end

function ys.LinkList:IsEmpty()
	return self.Count == 0
end

function ys.LinkList:AddBefore(arg_5_1, arg_5_2)
	if arg_5_1 == nil then
		return nil
	end

	local var_5_0 = self:NewNode(arg_5_2)

	if arg_5_1.Before ~= nil then
		arg_5_1.Before.Next = var_5_0
	end

	var_5_0.Before = arg_5_1.Before
	var_5_0.Next = arg_5_1
	arg_5_1.Before = var_5_0

	if self.Head == arg_5_1 then
		self.Head = var_5_0
	end

	self.Count = self.Count + 1

	return var_5_0
end

function ys.LinkList:AddAfter(arg_6_1, arg_6_2)
	if arg_6_1 == nil then
		return nil
	end

	local var_6_0 = self:NewNode(arg_6_2)

	if arg_6_1.Next ~= nil then
		arg_6_1.Next.Before = var_6_0
	end

	var_6_0.Next = arg_6_1.Next
	arg_6_1.Next = var_6_0
	var_6_0.Before = arg_6_1

	if self.Tail == arg_6_1 then
		self.Tail = var_6_0
	end

	self.Count = self.Count + 1

	return var_6_0
end

function ys.LinkList:AddFirst(arg_7_1)
	return self:AddNodeFirst((self:NewNode(arg_7_1)))
end

function ys.LinkList:AddNodeFirst(arg_8_1)
	if self.Head ~= nil then
		self.Head.Before = arg_8_1
	end

	arg_8_1.Next = self.Head
	arg_8_1.Before = nil
	self.Head = arg_8_1

	if self.Tail == nil then
		self.Tail = arg_8_1
	end

	self.Count = self.Count + 1

	return arg_8_1
end

function ys.LinkList:AddLast(arg_9_1)
	return self:AddNodeLast((self:NewNode(arg_9_1)))
end

function ys.LinkList:AddNodeLast(arg_10_1)
	if self.Tail ~= nil then
		self.Tail.Next = arg_10_1
	end

	arg_10_1.Before = self.Tail
	arg_10_1.Next = nil
	self.Tail = arg_10_1

	if self.Head == nil then
		self.Head = arg_10_1
	end

	self.Count = self.Count + 1

	return arg_10_1
end

function ys.LinkList:CopyTo(arg_11_1, arg_11_2)
	if arg_11_1 == nil then
		return
	end

	if arg_11_2 == nil then
		arg_11_2 = 1
	end

	local var_11_0 = self.Head

	for iter_11_0 = 1, self.Count do
		table.insert(arg_11_1, arg_11_2, var_11_0.Data)

		var_11_0 = var_11_0.Next
		arg_11_2 = arg_11_2 + 1
	end

	return
end

function ys.LinkList:Find(arg_12_1)
	for iter_12_0 = 1, self.Count do
		if self.Head.Data == arg_12_1 then
			return self.Head
		end
	end

	return nil
end

function ys.LinkList:FindLast(arg_13_1)
	for iter_13_0 = 1, self.Count do
		if self.Tail.Data == arg_13_1 then
			return self.Tail
		end
	end

	return nil
end

function ys.LinkList:RemoveFirst()
	self:Remove(self.Head)

	return
end

function ys.LinkList:RemoveLast()
	self:Remove(self.Tail)

	return
end

function ys.LinkList:Remove(arg_16_1)
	if arg_16_1 == nil then
		return
	end

	if self.Head == arg_16_1 then
		self.Head = arg_16_1.Next
	end

	if self.Tail == arg_16_1 then
		self.Tail = arg_16_1.Before
	end

	if arg_16_1.Next ~= nil then
		arg_16_1.Next.Before = arg_16_1.Before
	end

	if arg_16_1.Before ~= nil then
		arg_16_1.Before.Next = arg_16_1.Next
	end

	self.Count = self.Count - 1

	return
end

function ys.LinkList:RemoveData(arg_17_1)
	local var_17_0 = self:Find(arg_17_1)

	self:Remove(var_17_0)

	return var_17_0
end

local function var_0_0(arg_18_0, arg_18_1)
	if arg_18_1 == nil then
		return arg_18_0.Head
	else
		return arg_18_1.Next
	end

	return
end

function ys.LinkList.Iterator(arg_19_0)
	return var_0_0, arg_19_0
end

function ys.LinkList:Show()
	print("-------- list ++ begin --------")

	for iter_20_0 in self:Iterator() do
		print(iter_20_0.Data)
	end

	print("-------- list -- end ----------")

	return
end

return
