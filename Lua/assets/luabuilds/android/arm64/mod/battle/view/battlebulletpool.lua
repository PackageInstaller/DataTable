ys = ys or {}

local var_0_0 = singletonClass("BattleBulletPool")

ys.Battle.BattleBulletPool = var_0_0
var_0_0.__name = "BattleBulletPool"

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0._bulletResCache = {}

	return
end

function var_0_0.InstantiateBullet(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._bulletResCache[arg_3_1] ~= nil then
		arg_3_2(arg_3_0._bulletResCache[arg_3_1])
	else
		ResourceMgr.Inst:getAssetAsync("Item/" .. arg_3_1, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_4_0)
			assert(arg_4_0, "子弹资源加载失败：" .. arg_3_1)
			arg_3_2(arg_4_0)

			arg_3_0._bulletResCache[arg_3_1] = arg_4_0

			return
		end), true, true)
	end

	return
end

function var_0_0.Clear(arg_5_0)
	arg_5_0._bulletResCache = nil

	return
end

return
