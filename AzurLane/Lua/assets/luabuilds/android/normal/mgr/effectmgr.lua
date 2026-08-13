pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.EffectMgr = var_0_10001("EffectMgr")

function var_1.Ctor(arg_1_0)
	ys = var_1_10001

	local var_1_0 = var_1_10001.Battle.BattleResourceManager.GetInstance()

	setmetatable = var_1_10002
	arg_1_0.effectCbMap = var_1_10002({}, {
		__mode = "k"
	})

	function arg_1_0.commonEffectEvent(arg_2_0)
		if arg_2_0 ~= nil then
			IsNil = var_2_10001

			if var_2_10001(arg_2_0) then
				return
			end

			if arg_1_0.effectCbMap[arg_2_0] == nil then
				return
			end

			arg_1_0.effectCbMap[arg_2_0] = nil

			if var_1[2] ~= nil then
				var_2(arg_2_0)
			end

			if var_1[1] then
				local var_2_0 = var_1_0

				var_3.DestroyOb(var_2_0, arg_2_0)
			else
				arg_2_0:SetActive(false)
			end

			return
		end
	end

	return
end

function var_1.ClearBattleEffectMap(arg_3_0)
	setmetatable = var_1_10001
	arg_3_0.effectCbMap = var_1_10001({}, {
		__mode = "k"
	})

	return
end

function var_1.CommonEffectEvent(arg_4_0, arg_4_1)
	LuaHelper = var_1_10002

	var_1_10002.SetParticleEndEvent(arg_4_1, arg_4_0.commonEffectEvent)

	return
end

function var_1.PlayBattleEffect(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	arg_5_1.transform.localPosition = arg_5_2

	arg_5_1:SetActive(true)

	if arg_5_5 then
		LuaHelper = var_6

		local var_5_0 = var_6.SetParticleSpeed
		local var_5_1 = arg_5_1

		Time = var_8

		var_5_0(var_5_1, 1 / var_8.timeScale)
	end

	arg_5_0.effectCbMap[arg_5_1] = {
		arg_5_3,
		arg_5_4
	}

	return
end

function var_1.BattleUIEffect(arg_6_0, arg_6_1, arg_6_2)
	assert = var_1_10003
	string = var_1_10004

	var_1_10003(var_1_10004.sub(arg_6_1, -2, -1) == "UI", "UI效果不是以UI结尾，请检查")

	LoadAndInstantiateAsync = var_1_10003

	var_1_10003("UI", arg_6_1, function(arg_7_0)
		ys = var_2_10001

		local var_7_0 = var_2_10001.Battle.BattleState.GetInstance()

		if var_1.GetState(var_7_0) ~= var_1.BATTLE_STATE_FIGHT then
			Destroy = var_2

			var_2(arg_7_0)

			return
		end

		local var_7_1 = var_0.UIMgr.GetInstance().UIMain

		LuaHelper = var_3

		var_3.SetGOParentGO(arg_7_0, var_7_1, false)

		SetActive = var_3

		var_3(arg_7_0, true)
		arg_6_2(arg_7_0)

		return
	end)

	return
end

function var_1.EndEffect(arg_8_0, arg_8_1)
	if arg_8_0._effectMap[arg_8_1] ~= nil then
		local var_8_0 = var_2
		local var_8_1 = var_2.GetComponent

		typeof = var_1_10005
		ParticleSystem = var_1_10006

		local var_8_2 = var_8_1(var_8_0, var_1_10005(var_1_10006))

		var_3.Stop(var_8_2)
	end

	return
end

return
