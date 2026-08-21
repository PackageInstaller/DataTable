pg = pg or {}

local var_0_0 = pg
local var_0_1 = singletonClass("EffectMgr")

pg.EffectMgr = var_0_1

function var_0_1.Ctor(arg_1_0)
	local var_1_0 = ys.Battle.BattleResourceManager.GetInstance()

	arg_1_0.effectCbMap = setmetatable({}, {
		__mode = "k"
	})

	function arg_1_0.commonEffectEvent(arg_2_0)
		if arg_2_0 == nil or IsNil(arg_2_0) then
			return
		end

		local var_2_0 = arg_1_0.effectCbMap[arg_2_0]

		if arg_1_0.effectCbMap[arg_2_0] == nil then
			return
		end

		arg_1_0.effectCbMap[arg_2_0] = nil

		if var_2_0[2] ~= nil then
			var_2_0[2](arg_2_0)
		end

		if var_2_0[1] then
			var_1_0:DestroyOb(arg_2_0)
		else
			arg_2_0:SetActive(false)
		end

		return
	end

	return
end

function var_0_1.ClearBattleEffectMap(arg_3_0)
	arg_3_0.effectCbMap = setmetatable({}, {
		__mode = "k"
	})

	return
end

function var_0_1.CommonEffectEvent(arg_4_0, arg_4_1)
	LuaHelper.SetParticleEndEvent(arg_4_1, arg_4_0.commonEffectEvent)

	return
end

function var_0_1.PlayBattleEffect(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	arg_5_1.transform.localPosition = arg_5_2

	arg_5_1:SetActive(true)

	if arg_5_5 then
		LuaHelper.SetParticleSpeed(arg_5_1, 1 / Time.timeScale)
	end

	arg_5_0.effectCbMap[arg_5_1] = {
		arg_5_3,
		arg_5_4
	}

	return
end

function var_0_1.BattleUIEffect(arg_6_0, arg_6_1, arg_6_2)
	assert(string.sub(arg_6_1, -2, -1) == "UI", "UI效果不是以UI结尾，请检查")
	LoadAndInstantiateAsync("UI", arg_6_1, function(arg_7_0)
		local var_7_0 = ys.Battle.BattleState.GetInstance()

		if var_7_0:GetState() ~= var_7_0.BATTLE_STATE_FIGHT then
			Destroy(arg_7_0)

			return
		end

		LuaHelper.SetGOParentGO(arg_7_0, var_0_0.UIMgr.GetInstance().UIMain, false)
		SetActive(arg_7_0, true)
		arg_6_2(arg_7_0)

		return
	end)

	return
end

function var_0_1.EndEffect(arg_8_0, arg_8_1)
	if arg_8_0._effectMap[arg_8_1] ~= nil then
		arg_8_0._effectMap[arg_8_1]:GetComponent(typeof(ParticleSystem)):Stop()
	end

	return
end

return
