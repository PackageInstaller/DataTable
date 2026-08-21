module("frameworkext.unit.UnitBase", package.seeall)

local var_0_0 = class("UnitBase")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1.gameObject
	arg_1_0.go.tag = arg_1_0:getTag()
	arg_1_0.go.layer = arg_1_0:getLayer()
	arg_1_0.id = 0
	arg_1_0._innerChannelId = IDRecycleGenerater.getInnerChannelUid()
	arg_1_0._channelId = -1
	arg_1_0._compList = {}
end

function var_0_0.Awake(arg_2_0)
	arg_2_0:_initComponents()

	local var_2_0 = #arg_2_0._compList

	for iter_2_0 = 1, var_2_0 do
		arg_2_0._compList[iter_2_0]:onInit()
	end
end

function var_0_0.getInnerChannelId(arg_3_0)
	return arg_3_0._innerChannelId
end

function var_0_0.getChannelId(arg_4_0)
	return arg_4_0._channelId
end

function var_0_0._addComponent(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2.New(arg_5_0)

	arg_5_0[arg_5_1] = var_5_0

	table.insert(arg_5_0._compList, var_5_0)
end

function var_0_0.OnDestroy(arg_6_0)
	local var_6_0 = #arg_6_0._compList

	for iter_6_0 = 1, var_6_0 do
		arg_6_0._compList[iter_6_0]:onDestroy()
	end

	IDRecycleGenerater.recycleInnerChannelUid(arg_6_0:getInnerChannelId())
end

function var_0_0.getTag(arg_7_0)
	return UnitTag.Untagged
end

function var_0_0.getLayer(arg_8_0)
	return 0
end

function var_0_0._initComponents(arg_9_0)
	return
end

function var_0_0._executeCompFunc(arg_10_0, arg_10_1, ...)
	local var_10_0 = #arg_10_0._compList
	local var_10_1

	for iter_10_0 = 1, var_10_0 do
		local var_10_2 = arg_10_0._compList[iter_10_0]

		if var_10_2[arg_10_1] then
			var_10_2[arg_10_1](var_10_2, ...)
		end
	end
end

function var_0_0.addInnerEventListener(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	UnitInnerBroadcastDispatcher:addEventListener(UIDUtil.getUidWithSum(arg_11_0:getInnerChannelId(), arg_11_1), arg_11_2, arg_11_3, arg_11_4)
end

function var_0_0.removeInnerEventListener(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	UnitInnerBroadcastDispatcher:removeEventListener(UIDUtil.getUidWithSum(arg_12_0:getInnerChannelId(), arg_12_1), arg_12_2, arg_12_3, arg_12_4)
end

function var_0_0.dispatchInnerEvent(arg_13_0, arg_13_1, ...)
	UnitInnerBroadcastDispatcher:dispatchEvent(UIDUtil.getUidWithSum(arg_13_0:getInnerChannelId(), arg_13_1), arg_13_1, ...)
end

return var_0_0
