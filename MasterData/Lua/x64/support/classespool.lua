local ClassesPool = class("ClassesPool")

function ClassesPool:Ctor()
	self.classPool_ = {}
	self.usingIndex_ = {}
end

function ClassesPool:GetOrCreateClass(arg_2_1, ...)
	if not self.classPool_[arg_2_1.__cname] or not self.usingIndex_[arg_2_1.__cname] then
		self.classPool_[arg_2_1.__cname] = {}
		self.usingIndex_[arg_2_1.__cname] = {}
	end

	local var_2_0 = #self.classPool_[arg_2_1.__cname]

	for iter_2_0 = 1, #self.classPool_[arg_2_1.__cname] do
		if not self.usingIndex_[arg_2_1.__cname][iter_2_0] then
			self.usingIndex_[arg_2_1.__cname][iter_2_0] = true

			self.classPool_[arg_2_1.__cname][iter_2_0]:Ctor(...)

			return self.classPool_[arg_2_1.__cname][iter_2_0]
		end
	end

	self.classPool_[arg_2_1.__cname][var_2_0 + 1] = arg_2_1.New(...)
	self.classPool_[arg_2_1.__cname][var_2_0 + 1].__recycle = var_2_0 + 1
	self.usingIndex_[arg_2_1.__cname][var_2_0 + 1] = true

	return self.classPool_[arg_2_1.__cname][var_2_0 + 1]
end

function ClassesPool:ReturnClass(arg_3_1)
	if not self.classPool_[arg_3_1.class.__cname] or not self.usingIndex_[arg_3_1.class.__cname] then
		return
	end

	if arg_3_1.__recycle and arg_3_1.class.__cname then
		self.usingIndex_[arg_3_1.class.__cname][arg_3_1.__recycle] = false
	end
end

function ClassesPool:DisposeOnePool(arg_4_1)
	if self.classPool_[arg_4_1.__cname] then
		for iter_4_0, iter_4_1 in pairs(self.classPool_[arg_4_1.__cname]) do
			iter_4_1:Dispose()
		end

		self.classPool_[arg_4_1.__cname] = {}
		self.usingIndex_[arg_4_1.__cname] = {}
	end
end

function ClassesPool:Dispose()
	if self.classPool_ then
		for iter_5_0, iter_5_1 in pairs(self.classPool_) do
			for iter_5_2, iter_5_3 in pairs(iter_5_1) do
				iter_5_3:Dispose()
			end
		end
	end

	self.classPool_ = {}
	self.usingIndex_ = {}
end

return ClassesPool
