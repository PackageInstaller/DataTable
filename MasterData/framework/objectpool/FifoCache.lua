module("framework.objectpool.FifoCache", package.seeall)

local var_0_0 = class("FifoCache")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._capacity = arg_1_1
	arg_1_0._objectList = {}
	arg_1_0._objectDict = {}
	arg_1_0._valueKeyDict = {}
end

function var_0_0.getCount(arg_2_0)
	return #arg_2_0._objectList
end

function var_0_0.hasObject(arg_3_0, arg_3_1)
	return arg_3_0._objectDict[arg_3_1] ~= nil
end

function var_0_0.fetchObject(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._objectDict[arg_4_1]

	if var_4_0 then
		arg_4_0._objectDict[arg_4_1] = nil

		table.removebyvalue(arg_4_0._objectList, var_4_0)

		arg_4_0._valueKeyDict[var_4_0] = nil
	end

	return var_4_0
end

function var_0_0.fetchAll(arg_5_0)
	local var_5_0 = arg_5_0._objectList

	arg_5_0._objectList = {}
	arg_5_0._objectDict = {}
	arg_5_0._valueKeyDict = {}

	return var_5_0
end

function var_0_0.putObject(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0

	if not arg_6_0._objectDict[arg_6_1] then
		arg_6_0._objectDict[arg_6_1] = arg_6_2
		arg_6_0._valueKeyDict[arg_6_2] = arg_6_1

		table.insert(arg_6_0._objectList, arg_6_2)

		if #arg_6_0._objectList > arg_6_0._capacity then
			var_6_0 = arg_6_0._objectList[1]

			local var_6_1 = arg_6_0._valueKeyDict[var_6_0]

			arg_6_0._valueKeyDict[var_6_0] = nil
			arg_6_0._objectDict[var_6_1] = nil

			table.remove(arg_6_0._objectList, 1)
		end
	end

	return var_6_0
end

return var_0_0
