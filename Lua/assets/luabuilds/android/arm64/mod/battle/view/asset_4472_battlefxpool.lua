ys = ys or {}

local var_0_0 = ys
local var_0_1 = pg.effect_offset
local var_0_2 = singletonClass("BattleFXPool")

ys.Battle.BattleFXPool = var_0_2
var_0_2.__name = "BattleFXPool"

function var_0_2.Ctor(arg_1_0)
	return
end

function var_0_2:Init()
	self._fxContainer = GameObject("fxContainer")
	self._fxContainerTf = self._fxContainer.transform

	local var_2_0 = GameObject()

	var_2_0.transform:SetParent(self._fxContainerTf, false)

	var_2_0.name = "characterFXAttachPoint"
	self._charAttachPointPool = pg.Pool.New(self._fxContainerTf, var_2_0, 10, 20, false, true):InitSize()

	return
end

function var_0_2:Clear()
	self._charAttachPointPool:Dispose()

	self._charAttachPointPool = nil

	Object.Destroy(self._fxContainer)

	self._fxContainer = nil
	self._fxContainerTf = nil

	return
end

function var_0_2:GetFX(arg_4_1, arg_4_2)
	local var_4_0 = var_0_0.Battle.BattleResourceManager.GetInstance():InstFX(arg_4_1, true)

	LuaHelper.SetGOParentTF(var_4_0, arg_4_2 or self._fxContainerTf, false)

	return var_4_0, var_0_1[arg_4_1] ~= nil and Vector3(var_0_1[arg_4_1].offset[1], var_0_1[arg_4_1].offset[2], var_0_1[arg_4_1].offset[3]) or Vector3.zero
end

function var_0_2:GetCharacterFX(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if arg_5_2 == nil then
		return self:GetFX(arg_5_1)
	end

	local var_5_0 = var_0_0.Battle.BattleResourceManager.GetInstance():InstFX(arg_5_1, true)
	local var_5_2
	local var_5_3 = var_0_1[arg_5_1]

	if var_0_1[arg_5_1] ~= nil then
		var_5_2 = Vector3(var_5_3.offset[1], var_5_3.offset[2], var_5_3.offset[3] + 0.02)

		if var_5_3.container_index == -1 then
			LuaHelper.SetGOParentGO(var_5_0, arg_5_2:GetGO(), true)
		else
			var_5_2 = var_5_2 + arg_5_2:GetFXOffsets(var_5_3.container_index)

			LuaHelper.SetGOParentGO(var_5_0, arg_5_2:GetAttachPoint(), true)
		end

		if var_5_3.mirror and var_5_0.transform.parent.transform.lossyScale.x < 0 then
			var_5_0.transform.localScale = Vector3(-1 * var_5_0.transform.localScale.x, var_5_0.transform.localScale.y, var_5_0.transform.localScale.z)
		end
	else
		var_5_2 = Vector3(0, 0, 0.02)

		LuaHelper.SetGOParentGO(var_5_0, arg_5_2:GetGO(), true)
	end

	local var_5_4 = arg_5_2:GetSpecificFXScale()

	if var_5_4[arg_5_1] then
		var_5_0.transform.localScale = Vector3(var_5_0.transform.localScale.x * var_5_4[arg_5_1], var_5_0.transform.localScale.y * var_5_4[arg_5_1], var_5_0.transform.localScale.z * var_5_4[arg_5_1])
	end

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_5_0, var_5_2, arg_5_3, arg_5_4, arg_5_5)

	return var_5_0
end

function var_0_2:PopCharacterAttachPoint()
	return self._charAttachPointPool:GetObject()
end

function var_0_2:PushCharacterAttachPoint(arg_7_1)
	self._charAttachPointPool:Recycle(arg_7_1)

	return
end

return
