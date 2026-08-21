module("bootstrap.flow.nodes.BootstrapResPreLoad", package.seeall)

local var_0_0 = class("BootstrapResPreLoad", BoostrapFlowLauncherNode)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._bootstrapPrefab = {}
	arg_1_0._loadUIFinishFunc = nil
	arg_1_0._loadUIFinishFuncObj = nil
end

function var_0_0.onStart(arg_2_0)
	print("BootstrapFlow", "资源预加载")
	arg_2_0:_initAABPadPath()
	arg_2_0:loadUI()
end

function var_0_0._initAABPadPath(arg_3_0)
	printWarn("BootstrapFlow=>isAabPackage", BootstrapHelper.getBoolMetaData("isAabPackage"))

	if not BootstrapHelper.getBoolMetaData("isAabPackage") then
		return
	end

	local var_3_0 = {
		"aFastFollow1",
		"aFastFollow2"
	}

	for iter_3_0 = 1, #var_3_0 do
		local var_3_1 = BootstrapHelper.getPadPath(var_3_0[iter_3_0])

		if var_3_1 and var_3_1 ~= "" then
			rescache:AddAabPackPath(var_3_1)
		end
	end
end

function var_0_0.loadUI(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._loadUIFinishFunc = arg_4_1
	arg_4_0._loadUIFinishFuncObj = arg_4_2

	getres(BootstrapConst.BOOTSTRAP_LOADING_PATH, arg_4_0._loadBootstrapUIFinish, arg_4_0, 0, false)
	getres(BootstrapConst.BOOTSTRAP_MSG_BOX_PATH, arg_4_0._loadBootstrapUIFinish, arg_4_0, 0, false)
end

function var_0_0._loadBootstrapUIFinish(arg_5_0, arg_5_1)
	if arg_5_1 and arg_5_1.IsSuccess then
		arg_5_1:Retain()

		arg_5_0._bootstrapPrefab[arg_5_1.ResPath] = arg_5_1

		arg_5_0:_allUIPrefabFinish()
	else
		printError(arg_5_1.ResPath, " , load error")
	end
end

function var_0_0._allUIPrefabFinish(arg_6_0)
	forcePrint("========_allUIPrefabFinish=========")

	if arg_6_0._bootstrapPrefab[BootstrapConst.BOOTSTRAP_LOADING_PATH] and arg_6_0._bootstrapPrefab[BootstrapConst.BOOTSTRAP_MSG_BOX_PATH] then
		if arg_6_0._loadUIFinishFunc then
			arg_6_0._loadUIFinishFunc(arg_6_0._loadUIFinishFuncObj)
		end

		arg_6_0:getContext():setData("MsgBoxPrefabInstance", arg_6_0:getMsgBoxPrefabInstance())
		arg_6_0:getContext():setData("LoadingPrefabInstance", arg_6_0:getLoadingPrefabInstance())
		arg_6_0:onEnd(BootstrapFlowConst.BTStatus.SUCCESS)
	end
end

function var_0_0.getPrefabInstance(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._bootstrapPrefab[arg_7_1]

	return var_7_0 and UnityEngine.GameObject.Instantiate(var_7_0:GetMainAsset())
end

function var_0_0.getLoadingPrefabInstance(arg_8_0)
	return arg_8_0:getPrefabInstance(BootstrapConst.BOOTSTRAP_LOADING_PATH)
end

function var_0_0.getMsgBoxPrefabInstance(arg_9_0)
	return arg_9_0:getPrefabInstance(BootstrapConst.BOOTSTRAP_MSG_BOX_PATH)
end

function var_0_0.onReset(arg_10_0)
	var_0_0.super.onReset(arg_10_0)

	arg_10_0._loadUIFinishFunc = nil
	arg_10_0._loadUIFinishFuncObj = nil
end

function var_0_0.onDestroy(arg_11_0)
	var_0_0.super.onDestroy(arg_11_0)

	for iter_11_0, iter_11_1 in pairs(arg_11_0._bootstrapPrefab) do
		iter_11_1:Release()

		arg_11_0._bootstrapPrefab[iter_11_0] = nil
	end
end

return var_0_0
