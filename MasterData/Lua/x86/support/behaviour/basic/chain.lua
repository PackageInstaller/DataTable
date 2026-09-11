local Chain = class("Chain", (import("..BehaviourBase")))

function Chain:Ctor(arg_1_1, arg_1_2)
	Chain.super.Ctor(self, "ChainBehaviour")

	self.father_ = arg_1_1
	self.children_ = {}
	self.active_ = true
	self.handleChainEventCallbackName_ = arg_1_2 or "HandleChainEvent"
end

function Chain:AddChainChild(arg_2_1)
	table.insert(self.children_, arg_2_1)
end

function Chain:RemoveChainChild(arg_3_1)
	local var_3_0 = table.removebyvalue(self.children_, arg_3_1)
end

function Chain:SetChainFather(arg_4_1)
	self.father_ = arg_4_1
end

function Chain:DispatchEventInChain(arg_5_1)
	arg_5_1.stop_ = false

	function arg_5_1.stop(arg_6_0)
		arg_6_0.stop_ = true
	end

	self:DoDispatchEventInChain(arg_5_1, {})
end

function Chain:DoDispatchEventInChain(arg_7_1, arg_7_2)
	if table.indexof(arg_7_2, self.target_) ~= false then
		return
	end

	table.insert(arg_7_2, self.target_)

	if self.active_ then
		self.target_[self.handleChainEventCallbackName_](self.target_, arg_7_1)

		if arg_7_1.stop_ then
			return
		end
	end

	for iter_7_0, iter_7_1 in pairs(self.children_) do
		if table.indexof(arg_7_2, iter_7_1) == false then
			iter_7_1:DoDispatchEventInChain(arg_7_1, arg_7_2)

			if arg_7_1.stop_ then
				return
			end
		end
	end

	if self.father_ and table.indexof(arg_7_2, self.father_) == false then
		self.father_:DoDispatchEventInChain(arg_7_1, arg_7_2)

		if arg_7_1.stop_ then
			return
		end
	end
end

function Chain:SetHandleChainActive(arg_8_1)
	self.active_ = arg_8_1
end

function Chain:OnBind_()
	self:ExportMethods_({
		"SetHandleChainActive",
		"AddChainChild",
		"RemoveChainChild",
		"SetChainFather",
		"DispatchEventInChain",
		"DoDispatchEventInChain"
	})

	if self.father_ then
		self.father_:AddChainChild(self.target_)
	end

	self.target_:BindMethod(self, "Dispose", self.Dispose)

	return self.target_
end

function Chain:OnUnbind_()
	self:Dispose()
	self.target_:UnbindMethod(self, "Dispose")
end

function Chain:Dispose()
	for iter_11_0, iter_11_1 in pairs(self.children_) do
		iter_11_1:SetChainFather(self.father_)
		self.father_:AddChainChild(iter_11_1)
	end

	self.father_:RemoveChainChild(self.target_)

	self.father_ = nil
	self.children_ = nil
end

return Chain
