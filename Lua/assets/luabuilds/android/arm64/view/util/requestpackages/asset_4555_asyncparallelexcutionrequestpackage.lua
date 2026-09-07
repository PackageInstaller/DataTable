local AsyncParallelExcutionRequestPackage = class("AsyncParallelExcutionRequestPackage", import(".RequestPackage"))

function AsyncParallelExcutionRequestPackage:__call()
	if self.stopped then
		return
	end

	if not self.funcs or #self.funcs == 0 then
		return
	end

	local var_1_0 = #self.funcs

	local function var_1_1()
		if self.stopped then
			return
		end

		var_1_0 = var_1_0 - 1

		if var_1_0 == 0 and self.final then
			self.final()
		end

		return
	end

	if #self.funcs > 0 then
		for iter_1_0, iter_1_1 in ipairs(self.funcs) do
			iter_1_1(var_1_1)
		end
	elseif self.final then
		self.final()
	end

	return
end

function AsyncParallelExcutionRequestPackage:Ctor(arg_3_1, arg_3_2)
	self.funcs = arg_3_1
	self.final = arg_3_2

	return
end

return AsyncParallelExcutionRequestPackage
