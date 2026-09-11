local var_0_0 = {}
local BehaviourFactory = import(".BehaviourFactory")

function var_0_0.IsBehaviourAvailable(arg_1_0, arg_1_1)
	return BehaviourFactory.IsBehaviourAvailable(arg_1_1)
end

function var_0_0:HasBehaviour(arg_2_1)
	return self.__behaviours[arg_2_1] ~= nil
end

function var_0_0:AddBehaviour(arg_3_1)
	local var_3_0 = self.__behaviours[arg_3_1] or BehaviourFactory.CreateBehaviour(arg_3_1)

	var_3_0:AddRef_(self)

	return var_3_0
end

function var_0_0:RemoveBehaviour(arg_4_1)
	self.__behaviours[arg_4_1]:SubRef_()
end

function var_0_0:GetBehaviour(arg_5_1)
	return self.__behaviours[arg_5_1]
end

function var_0_0:BroadcastMessage2Behaviours(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(self.__behaviours) do
		iter_6_1:HandleMessage_(arg_6_1)
	end
end

function var_0_0:ResetAllBehaviours()
	if not self.__behaviours then
		return
	end

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(self.__behaviours) do
		var_7_0[#var_7_0 + 1] = iter_7_1
	end

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		return arg_8_0:GetPriority() > arg_8_1:GetPriority()
	end)

	for iter_7_2, iter_7_3 in ipairs(var_7_0) do
		iter_7_3:Reset(self)
	end
end

function var_0_0:BindMethod(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if not self[arg_9_2] then
		self[arg_9_2] = function(arg_10_0, ...)
			return arg_9_3(arg_9_1, ...)
		end

		return
	end

	self.bindingMethods_ = self.bindingMethods_ or {}
	self.bindingMethods_[arg_9_2] = self.bindingMethods_[arg_9_2] or {}

	local var_9_0 = {
		arg_9_1,
		self[arg_9_2]
	}
	local var_9_1 = arg_9_4 and function(...)
		local var_11_0 = {
			...
		}

		table.remove(var_11_0, 1)
		arg_9_3(arg_9_1, unpack(var_11_0))

		return var_9_0[2](...)
	end or function(...)
		var_9_0[2](...)

		local var_12_0 = {
			...
		}

		table.remove(var_12_0, 1)

		return arg_9_3(arg_9_1, unpack(var_12_0))
	end

	self[arg_9_2] = var_9_1
	var_9_0[3] = var_9_1

	table.insert(self.bindingMethods_[arg_9_2], var_9_0)
end

function var_0_0:UnbindMethod(arg_13_1, arg_13_2)
	if not self.bindingMethods_ or not self.bindingMethods_[arg_13_2] then
		self[arg_13_2] = nil

		return
	end

	local var_13_0 = self.bindingMethods_[arg_13_2]

	for iter_13_0 = #self.bindingMethods_[arg_13_2], 1, -1 do
		if var_13_0[iter_13_0][1] == arg_13_1 then
			if iter_13_0 < #self.bindingMethods_[arg_13_2] then
				var_13_0[iter_13_0 + 1][2] = var_13_0[iter_13_0][2]
			elseif #self.bindingMethods_[arg_13_2] > 1 then
				self[arg_13_2] = var_13_0[iter_13_0 - 1][3]
			elseif #self.bindingMethods_[arg_13_2] == 1 then
				self[arg_13_2] = var_13_0[iter_13_0][2]
				self.bindingMethods_[arg_13_2] = nil
			end

			table.remove(var_13_0, iter_13_0)

			break
		end
	end
end

function var_0_0:RemoveBehaviour_(arg_14_1)
	self.__behaviours[arg_14_1] = nil
end

function var_0_0:AddBehaviour_(arg_15_1, arg_15_2)
	self.__behaviours[arg_15_1] = arg_15_2
end

function var_0_0:Extend()
	if self.__behaviours ~= nil then
		return self
	end

	self.__behaviours = {}
	self.HasBehaviour = var_0_0.HasBehaviour
	self.AddBehaviour = var_0_0.AddBehaviour
	self.AddBehaviour_ = var_0_0.AddBehaviour_
	self.RemoveBehaviour = var_0_0.RemoveBehaviour
	self.RemoveBehaviour_ = var_0_0.RemoveBehaviour_
	self.BindMethod = var_0_0.BindMethod
	self.UnbindMethod = var_0_0.UnbindMethod
	self.GetBehaviour = var_0_0.GetBehaviour
	self.BroadcastMessage2Behaviours = var_0_0.BroadcastMessage2Behaviours
	self.ResetAllBehaviours = var_0_0.ResetAllBehaviours
	self.IsBehaviourAvailable = var_0_0.IsBehaviourAvailable

	return self
end

return var_0_0
