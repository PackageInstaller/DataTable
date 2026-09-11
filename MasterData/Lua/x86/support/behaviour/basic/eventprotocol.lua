local EventProtocol = class("EventProtocol", (import("..BehaviourBase")))

function EventProtocol:Ctor()
	EventProtocol.super.Ctor(self, "EventProtocol")

	self.listeners_ = {}
	self.nextListenerHandleIndex_ = 0
end

function EventProtocol:AddEventListener(arg_2_1, arg_2_2, arg_2_3)
	if self.listeners_[arg_2_1] == nil then
		self.listeners_[arg_2_1] = {}
	end

	self.listeners_[arg_2_1][arg_2_2] = {
		arg_2_2,
		arg_2_3
	}

	return arg_2_2
end

function EventProtocol:AddEventListenerShare(arg_3_1, arg_3_2, arg_3_3)
	if self.listeners_[arg_3_1] == nil then
		self.listeners_[arg_3_1] = {}
	end

	self.nextListenerHandleIndex_ = self.nextListenerHandleIndex_ + 1

	local var_3_0 = tostring(self.nextListenerHandleIndex_)

	self.listeners_[arg_3_1][var_3_0] = {
		arg_3_2,
		arg_3_3
	}

	return var_3_0
end

function EventProtocol:DispatchEvent(arg_4_1)
	local var_4_0 = arg_4_1.name or arg_4_1.GetName and arg_4_1:GetName()

	if self.listeners_[var_4_0] == nil then
		return
	end

	arg_4_1.emitter = self.target_

	for iter_4_0, iter_4_1 in pairs(self.listeners_[var_4_0]) do
		iter_4_1[1](arg_4_1)
	end

	return self.target_
end

function EventProtocol:RemoveEventListener(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(self.listeners_) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1) do
			if iter_5_2 == arg_5_1 then
				iter_5_1[iter_5_2] = nil

				return self.target_
			end
		end
	end

	return self.target_
end

function EventProtocol:RemoveEventListenersByTag(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(self.listeners_) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			if iter_6_3[2] == arg_6_1 then
				iter_6_1[iter_6_2] = nil
			end
		end
	end

	return self.target_
end

function EventProtocol:RemoveEventListenersByEventAndTag(arg_7_1, arg_7_2)
	if not self.listeners_[arg_7_1] then
		return self.target_
	end

	for iter_7_0, iter_7_1 in pairs(self.listeners_[arg_7_1]) do
		if iter_7_1[2] == arg_7_2 then
			self.listeners_[arg_7_1][iter_7_0] = nil
		end
	end

	return self.target_
end

function EventProtocol:RemoveEventListenersByEvent(arg_8_1)
	self.listeners_[arg_8_1] = nil

	return self.target_
end

function EventProtocol:RemoveAllEventListeners()
	self.listeners_ = {}

	return self.target_
end

function EventProtocol:HasEventListener(arg_10_1)
	for iter_10_0, iter_10_1 in pairs(self.listeners_[arg_10_1]) do
		return true
	end

	return false
end

function EventProtocol:DumpAllEventListeners()
	printInfo("---- EventProtocol:dumpAllEventListeners() ----")

	for iter_11_0, iter_11_1 in pairs(self.listeners_) do
		printInfo("-- event: %s", iter_11_0)

		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			printInfo("--     listener: %s, handle: %s", tostring(iter_11_3[1]), tostring(iter_11_2))
		end
	end

	return self.target_
end

function EventProtocol:OnBind_()
	self:ExportMethods_({
		"AddEventListener",
		"AddEventListenerShare",
		"DispatchEvent",
		"RemoveEventListener",
		"RemoveEventListenersByTag",
		"RemoveEventListenersByEvent",
		"RemoveEventListenersByEventAndTag",
		"RemoveAllEventListeners",
		"HasEventListener",
		"DumpAllEventListeners"
	})

	return self.target_
end

function EventProtocol:OnUnbind_()
	return
end

return EventProtocol
