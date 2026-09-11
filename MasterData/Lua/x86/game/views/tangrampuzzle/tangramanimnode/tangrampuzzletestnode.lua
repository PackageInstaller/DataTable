local TangramPuuzleTestNode = class("TangramPuuzleTestNode")

function TangramPuuzleTestNode:OnCtor()
	self.checkConditionFunc_ = nil
	self.checkSuccessFunc_ = nil
	self.checkFailFunc_ = nil
	self.runFunc_ = nil
	self.afterRunFunc_ = nil
	self.nextNode_ = nil
end

function TangramPuuzleTestNode:CheckCondition()
	if self.checkConditionFunc_ then
		local var_2_0 = self.checkConditionFunc_()

		if var_2_0 == true then
			if self.checkSuccessFunc_ then
				self.checkSuccessFunc_()
			end
		elseif self.checkFailFunc_ then
			self.checkFailFunc_()
		end

		return var_2_0
	else
		return true
	end
end

function TangramPuuzleTestNode:Run()
	if self.runFunc_ then
		self.runFunc_()
	end
end

function TangramPuuzleTestNode:Dispose()
	self.checkConditionFunc_ = nil
	self.checkSuccessFunc_ = nil
	self.checkFailFunc_ = nil
	self.runFunc_ = nil
	self.afterRunFunc_ = nil
	self.nextNode_ = nil
end

return TangramPuuzleTestNode
