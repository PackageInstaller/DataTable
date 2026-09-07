pg = pg or {}

local LuaObPool = class("LuaObPool")

pg.LuaObPool = LuaObPool

function LuaObPool:Ctor(arg_1_1, arg_1_2, arg_1_3)
	assert(arg_1_1.Init, "template should have func Init")
	assert(arg_1_1.Recycle, "template should have func Recycle")
	assert(arg_1_1.Dispose, "template should have func Dispose")

	self.baseClass = arg_1_1
	self.info = arg_1_2
	self.list = {}
	self.ob2index = {}

	for iter_1_0 = 1, arg_1_3 do
		self.list[iter_1_0] = arg_1_1.New(self, arg_1_2)
	end

	self.usedEnd = 0

	return
end

function LuaObPool:GetObject()
	if self.usedEnd >= #self.list then
		self.list[#self.list + 1] = self.baseClass.New(self, self.info)
	end

	self.ob2index[self.list[self.usedEnd + 1]] = self.usedEnd + 1
	self.usedEnd = self.usedEnd + 1

	self.list[self.usedEnd + 1]:Init()

	return self.list[self.usedEnd + 1]
end

function LuaObPool:Recycle(arg_3_1)
	local var_3_0 = self.ob2index[arg_3_1]
	local var_3_1 = self.usedEnd
	local var_3_2 = self.list

	arg_3_1:Recycle()

	if self.usedEnd ~= self.ob2index[arg_3_1] then
		self.ob2index[self.list[self.usedEnd]] = self.ob2index[arg_3_1]
		var_3_2[var_3_1], var_3_2[var_3_0] = arg_3_1, self.list[self.usedEnd]
	end

	self.ob2index[arg_3_1] = nil
	self.usedEnd = self.usedEnd - 1

	return
end

function LuaObPool:UpdateInfo(arg_4_1, arg_4_2)
	self.info[arg_4_1] = arg_4_2

	return
end

function LuaObPool:Dispose()
	for iter_5_0, iter_5_1 in ipairs(self.list) do
		iter_5_1:Dispose()
	end

	self.ob2index = nil

	return
end

return
