local var_0_0 = {}
local var_0_1 = import(".BehaviourFactory")

function var_0_0.IsBehaviourAvailable(arg_1_0, arg_1_1)
	return var_0_1.IsBehaviourAvailable(arg_1_1)
end

function var_0_0.HasBehaviour(arg_2_0, arg_2_1)
	return arg_2_0.__behaviours[arg_2_1] ~= nil
end

function var_0_0.AddBehaviour(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.__behaviours[arg_3_1] or var_0_1.CreateBehaviour(arg_3_1)

	var_3_0:AddRef_(arg_3_0)

	return var_3_0
end

function var_0_0.RemoveBehaviour(arg_4_0, arg_4_1)
	arg_4_0.__behaviours[arg_4_1]:SubRef_()
end

function var_0_0.GetBehaviour(arg_5_0, arg_5_1)
	return arg_5_0.__behaviours[arg_5_1]
end

function var_0_0.BroadcastMessage2Behaviours(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.__behaviours) do
		iter_6_1:HandleMessage_(arg_6_1)
	end
end

function var_0_0.ResetAllBehaviours(arg_7_0)
	if not arg_7_0.__behaviours then
		return
	end

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0.__behaviours) do
		var_7_0[#var_7_0 + 1] = iter_7_1
	end

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		return arg_8_0:GetPriority() > arg_8_1:GetPriority()
	end)

	for iter_7_2, iter_7_3 in ipairs(var_7_0) do
		iter_7_3:Reset(arg_7_0)
	end
end

function var_0_0.BindMethod(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = arg_9_0[arg_9_2]

	if not var_9_0 then
		arg_9_0[arg_9_2] = function(arg_10_0, ...)
			return arg_9_3(arg_9_1, ...)
		end

		return
	end

	if not arg_9_0.bindingMethods_ then
		arg_9_0.bindingMethods_ = {}
	end

	if not arg_9_0.bindingMethods_[arg_9_2] then
		arg_9_0.bindingMethods_[arg_9_2] = {}
	end

	local var_9_1 = {
		arg_9_1,
		var_9_0
	}
	local var_9_2

	if arg_9_4 then
		function var_9_2(...)
			local var_11_0 = {
				...
			}

			table.remove(var_11_0, 1)
			arg_9_3(arg_9_1, unpack(var_11_0))

			return var_9_1[2](...)
		end
	else
		function var_9_2(...)
			var_9_1[2](...)

			local var_12_0 = {
				...
			}

			table.remove(var_12_0, 1)

			return arg_9_3(arg_9_1, unpack(var_12_0))
		end
	end

	arg_9_0[arg_9_2] = var_9_2
	var_9_1[3] = var_9_2

	table.insert(arg_9_0.bindingMethods_[arg_9_2], var_9_1)
end

function var_0_0.UnbindMethod(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0.bindingMethods_ or not arg_13_0.bindingMethods_[arg_13_2] then
		arg_13_0[arg_13_2] = nil

		return
	end

	local var_13_0 = arg_13_0.bindingMethods_[arg_13_2]
	local var_13_1 = #var_13_0

	for iter_13_0 = var_13_1, 1, -1 do
		local var_13_2 = var_13_0[iter_13_0]

		if var_13_2[1] == arg_13_1 then
			if iter_13_0 < var_13_1 then
				var_13_0[iter_13_0 + 1][2] = var_13_2[2]
			elseif var_13_1 > 1 then
				arg_13_0[arg_13_2] = var_13_0[iter_13_0 - 1][3]
			elseif var_13_1 == 1 then
				arg_13_0[arg_13_2] = var_13_2[2]
				arg_13_0.bindingMethods_[arg_13_2] = nil
			end

			table.remove(var_13_0, iter_13_0)

			break
		end
	end
end

function var_0_0.RemoveBehaviour_(arg_14_0, arg_14_1)
	arg_14_0.__behaviours[arg_14_1] = nil
end

function var_0_0.AddBehaviour_(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.__behaviours[arg_15_1] = arg_15_2
end

function var_0_0.Extend(arg_16_0)
	if arg_16_0.__behaviours ~= nil then
		return arg_16_0
	end

	arg_16_0.__behaviours = {}
	arg_16_0.HasBehaviour = var_0_0.HasBehaviour
	arg_16_0.AddBehaviour = var_0_0.AddBehaviour
	arg_16_0.AddBehaviour_ = var_0_0.AddBehaviour_
	arg_16_0.RemoveBehaviour = var_0_0.RemoveBehaviour
	arg_16_0.RemoveBehaviour_ = var_0_0.RemoveBehaviour_
	arg_16_0.BindMethod = var_0_0.BindMethod
	arg_16_0.UnbindMethod = var_0_0.UnbindMethod
	arg_16_0.GetBehaviour = var_0_0.GetBehaviour
	arg_16_0.BroadcastMessage2Behaviours = var_0_0.BroadcastMessage2Behaviours
	arg_16_0.ResetAllBehaviours = var_0_0.ResetAllBehaviours
	arg_16_0.IsBehaviourAvailable = var_0_0.IsBehaviourAvailable

	return arg_16_0
end

return var_0_0
