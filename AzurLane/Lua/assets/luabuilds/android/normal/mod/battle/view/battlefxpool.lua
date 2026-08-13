ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
pg = var_0_10001

local var_0_1 = var_0_10001.effect_offset

singletonClass = var_0_10002

local var_0_2 = var_0_10002("BattleFXPool")

var_0.Battle.BattleFXPool = var_0_2
var_0_2.__name = "BattleFXPool"

function var_0_2.Ctor(arg_1_0)
	return
end

function var_0_2.Init(arg_2_0)
	GameObject = var_1_10001
	arg_2_0._fxContainer = var_1_10001("fxContainer")
	arg_2_0._fxContainerTf = arg_2_0._fxContainer.transform
	GameObject = var_1

	local var_2_0 = var_1().transform

	var_2.SetParent(var_2_0, arg_2_0._fxContainerTf, false)

	var_1.name = "characterFXAttachPoint"
	pg = var_2

	local var_2_1 = var_2.Pool.New(arg_2_0._fxContainerTf, var_1, 10, 20, false, true)

	arg_2_0._charAttachPointPool = var_2.InitSize(var_2_1)

	return
end

function var_0_2.Clear(arg_3_0)
	local var_3_0 = arg_3_0._charAttachPointPool

	var_1.Dispose(var_3_0)

	arg_3_0._charAttachPointPool = nil
	Object = var_1

	var_1.Destroy(arg_3_0._fxContainer)

	arg_3_0._fxContainer = nil
	arg_3_0._fxContainerTf = nil

	return
end

function var_0_2.GetFX(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0.Battle.BattleResourceManager.GetInstance()
	local var_4_1 = var_3.InstFX(var_4_0, arg_4_1, true)

	LuaHelper = var_4_0

	var_4_0.SetGOParentTF(var_4_1, arg_4_2 or arg_4_0._fxContainerTf, false)

	local var_4_2
	local var_4_3

	if var_0_1[arg_4_1] ~= nil then
		var_4_3 = var_5.offset
		Vector3 = var_7
		var_4_2 = var_7(var_4_3[1], var_4_3[2], var_4_3[3])
	else
		Vector3 = var_4_3
		var_4_2 = var_4_3.zero
	end

	return var_4_1, var_4_2
end

function var_0_2.GetCharacterFX(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if arg_5_2 == nil then
		return arg_5_0:GetFX(arg_5_1)
	end

	local var_5_0 = var_0.Battle.BattleResourceManager.GetInstance()
	local var_5_1 = var_6.InstFX(var_5_0, arg_5_1, true)
	local var_5_2
	local var_5_3

	if var_0_1[arg_5_1] ~= nil then
		local var_5_4 = var_9.container_index

		var_1_10010 = var_9.offset
		Vector3 = var_1_10011
		var_5_3 = var_1_10011(var_1_10010[1], var_1_10010[2], var_1_10010[3] + 0.02)

		if var_5_4 == -1 then
			LuaHelper = var_11

			local var_5_5 = var_11.SetGOParentGO
			local var_5_6 = var_5_1

			var_1_10014 = arg_5_2

			var_5_5(var_5_6, arg_5_2.GetGO(var_1_10014), true)
		else
			local var_5_7 = arg_5_2

			var_5_3 = var_5_3 + arg_5_2.GetFXOffsets(var_5_7, var_5_4)
			LuaHelper = var_5_7

			var_5_7.SetGOParentGO(var_5_1, arg_5_2:GetAttachPoint(), true)
		end

		if var_9.mirror and var_5_1.transform.parent.transform.lossyScale.x < 0 then
			local var_5_8 = var_5_1.transform.localScale
			local var_5_9 = var_5_1.transform

			Vector3 = var_1_10014
			var_5_9.localScale = var_1_10014(-1 * var_5_8.x, var_5_8.y, var_5_8.z)
		end
	else
		Vector3 = var_1_10010
		var_5_3 = var_1_10010(0, 0, 0.02)
		LuaHelper = var_10

		var_10.SetGOParentGO(var_5_1, arg_5_2:GetGO(), true)
	end

	local var_5_10

	if arg_5_2:GetSpecificFXScale()[arg_5_1] then
		var_5_10 = var_10[arg_5_1]

		local var_5_11 = var_5_1.transform.localScale
		local var_5_12 = var_5_1.transform

		Vector3 = var_1_10014
		var_5_12.localScale = var_1_10014(var_5_11.x * var_5_10, var_5_11.y * var_5_10, var_5_11.z * var_5_10)
	end

	pg = var_5_10

	local var_5_13 = var_5_10.EffectMgr.GetInstance()

	var_11.PlayBattleEffect(var_5_13, var_5_1, var_5_3, arg_5_3, arg_5_4, arg_5_5)

	return var_5_1
end

function var_0_2.PopCharacterAttachPoint(arg_6_0)
	local var_6_0 = arg_6_0._charAttachPointPool

	return var_1.GetObject(var_6_0)
end

function var_0_2.PushCharacterAttachPoint(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._charAttachPointPool

	var_2.Recycle(var_7_0, arg_7_1)

	return
end

return
