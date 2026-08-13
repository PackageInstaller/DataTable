ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
singletonClass = var_0_10001

local var_0_1 = var_0_10001("BattleBulletPool")

var_0.Battle.BattleBulletPool = var_0_1
var_0_1.__name = "BattleBulletPool"

function var_0_1.Ctor(arg_1_0)
	return
end

function var_0_1.Init(arg_2_0)
	arg_2_0._bulletResCache = {}

	return
end

function var_0_1.InstantiateBullet(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._bulletResCache[arg_3_1] ~= nil then
		arg_3_2(arg_3_0._bulletResCache[arg_3_1])
	else
		ResourceMgr = var_3

		local var_3_0 = var_3.Inst
		local var_3_1 = var_3.getAssetAsync
		local var_3_2 = "Item/" .. arg_3_1
		local var_3_3 = ""

		UnityEngine = var_1_10007

		var_3_1(var_3_0, var_3_2, var_3_3, var_1_10007.Events.UnityAction_UnityEngine_Object(function(arg_4_0)
			assert = var_2_10001

			var_2_10001(arg_4_0, "子弹资源加载失败：" .. arg_3_1)
			arg_3_2(arg_4_0)

			arg_3_0._bulletResCache[arg_3_1] = arg_4_0

			return
		end), true, true)
	end

	return
end

function var_0_1.Clear(arg_5_0)
	arg_5_0._bulletResCache = nil

	return
end

return
