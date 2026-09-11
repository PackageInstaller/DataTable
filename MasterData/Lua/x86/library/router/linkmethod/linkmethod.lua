local LinkMethod = class("LinkMethod")

function LinkMethod:Ctor()
	self.methodList_ = {}
	self.peek_ = 100
end

function LinkMethod:AddMethod(arg_2_1)
	table.insert(self.methodList_, arg_2_1)
end

function LinkMethod:AddMethodList(arg_3_1)
	self.methodList_ = arg_3_1
end

function LinkMethod:StartNext()
	self.peek_ = 1

	self:DoNext()
end

function LinkMethod:DoNext()
	if self.methodList_[self.peek_] then
		self.peek_ = self.peek_ + 1

		self.methodList_[self.peek_]()
	end
end

function LinkMethod:IsFree()
	return self.peek_ > #self.methodList_
end

function LinkMethod:Stop()
	self.peek_ = #self.methodList_ + 1
end

return LinkMethod
