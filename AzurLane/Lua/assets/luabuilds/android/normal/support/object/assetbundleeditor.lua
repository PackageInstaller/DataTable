pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
class = var_0_10001
var_0.AssetBundleEditor = var_0_10001("AssetBundle", var_0.AssetBundle)

function var_1.Load(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	assert = var_1_10004

	var_1_10004(not arg_1_0.ab)

	arg_1_0.abs = {}

	if arg_1_1 then
		onNextTick = var_4

		var_4(function()
			existCall = var_2_10000

			var_2_10000(arg_1_3, arg_1_0)

			return
		end)
	else
		existCall = var_4

		var_4(arg_1_3, arg_1_0)

		return arg_1_0
	end

	return
end

function var_1.LoadAssetSync(arg_3_0, arg_3_1, ...)
	arg_3_1 = arg_3_0:ChangeAssetName(arg_3_1)
	ResourceMgr = var_2

	local var_3_0 = var_2.Inst

	return var_2.getAssetSync(var_3_0, arg_3_0.path, arg_3_1, ...)
end

function var_1.LoadAssetAsync(arg_4_0, arg_4_1, arg_4_2, arg_4_3, ...)
	arg_4_1 = arg_4_0:ChangeAssetName(arg_4_1)
	ResourceMgr = var_4

	local var_4_0 = var_4.Inst
	local var_4_1 = var_4.getAssetAsync
	local var_4_2 = arg_4_0.path
	local var_4_3 = arg_4_1
	local var_4_4 = arg_4_2

	UnityEngine = var_1_10009

	return var_4_1(var_4_0, var_4_2, var_4_3, var_4_4, var_1_10009.Events.UnityAction_UnityEngine_Object(arg_4_3), ...)
end

function var_1.GetAllAssetNames(arg_5_0)
	table = var_1_10001

	local var_5_0 = var_1_10001.CArrayToArray

	ReflectionHelp = var_1_10002

	local var_5_1 = var_1_10002.RefCallMethod

	typeof = var_1_10003
	ResourceMgr = var_1_10004

	local var_5_2 = var_1_10003(var_1_10004)
	local var_5_3 = "GetAssetBundleAllAssetNames"

	ResourceMgr = var_1_10005

	local var_5_4 = var_1_10005.Inst
	local var_5_5 = {}

	typeof = var_1_10007
	var_5_5[1] = var_1_10007("System.String")

	return var_5_0(var_5_1(var_5_2, var_5_3, var_5_4, var_5_5, {
		arg_5_0.path
	}))
end

return
