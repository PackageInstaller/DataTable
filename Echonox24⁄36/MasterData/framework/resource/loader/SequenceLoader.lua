module("framework.resource.rescache.SequenceLoaderMgr", package.seeall)

local var_0_0 = class("ResFinishCall", MultiResLoader)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._recordCallback = nil
end

function var_0_0.setRecordCallback(arg_2_0, arg_2_1)
	arg_2_0._recordCallback = arg_2_1
end

function var_0_0.getRecordCallback(arg_3_0)
	return arg_3_0._recordCallback
end

function var_0_0.getCallbackObj(arg_4_0)
	return arg_4_0._callbackObj
end

function var_0_0.clear(arg_5_0)
	var_0_0.super.clear(arg_5_0)

	arg_5_0._recordCallback = nil
end

local var_0_1 = class("SequenceLoader")

function var_0_1.ctor(arg_6_0)
	arg_6_0._loaderPool = nil
	arg_6_0._list = nil
end

function var_0_1.init(arg_7_0, arg_7_1)
	arg_7_0._loaderPool = ObjectPool.New(arg_7_1 or 10, var_0_0.New, var_0_0.clear, var_0_0.clear)
	arg_7_0._list = list.new()
end

function var_0_1.getLoaderList(arg_8_0)
	return arg_8_0._list
end

function var_0_1.getResLoader(arg_9_0)
	return arg_9_0._loaderPool:fetchObject()
end

function var_0_1.returnResLoader(arg_10_0, arg_10_1)
	arg_10_0._list:erase(arg_10_1)
	arg_10_0._loaderPool:returnObject(arg_10_1)

	local var_10_0 = SequenceLoader.instance:getLoaderList():head()

	if var_10_0 and var_10_0:isLoadAll() then
		var_0_1.finishCallback(nil, var_10_0)
	end
end

function var_0_1.addResPath(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = clone(arg_11_2)
	local var_11_1 = clone(arg_11_3)
	local var_11_2 = clone(arg_11_4)

	arg_11_1:addResPath(var_11_0, var_11_1, var_11_2)
end

function var_0_1.setResPaths(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = clone(arg_12_2)
	local var_12_1 = clone(arg_12_3)
	local var_12_2 = clone(arg_12_4)

	arg_12_1:setResPaths(var_12_0, var_12_1, var_12_2)
end

function var_0_1.load(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if not arg_13_0._list:find(arg_13_1) then
		arg_13_0._list:push(arg_13_1)
	end

	arg_13_1:setRecordCallback(arg_13_2)
	arg_13_1:load(var_0_1.finishCallback, arg_13_3, arg_13_4)
end

function var_0_1.finishCallback(arg_14_0, arg_14_1)
	arg_14_1 = arg_14_1 or arg_14_0

	local var_14_0 = SequenceLoader.instance:getLoaderList()
	local var_14_1 = var_14_0:head()
	local var_14_2
	local var_14_3

	while var_14_1 and var_14_1:isLoadAll() and arg_14_1 == var_14_1 do
		var_14_1 = var_14_0:shift()

		local var_14_4 = var_14_1:getRecordCallback()

		if var_14_4 then
			local var_14_5 = var_14_1:getCallbackObj()

			if var_14_5 then
				var_14_4(var_14_5, var_14_1)
			else
				var_14_4(var_14_1)
			end
		end

		var_14_1 = var_14_0:head()
		arg_14_1 = var_14_1
	end
end

function var_0_1.clear(arg_15_0)
	if arg_15_0._loaderPool then
		arg_15_0._loaderPool:clear()

		arg_15_0._loaderPool = nil
	end

	if arg_15_0._list then
		arg_15_0._list:clear()

		arg_15_0._list = nil
	end
end

var_0_1.instance = var_0_1.New()

return var_0_1
