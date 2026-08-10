local var_0_0 = singletonClass("TugGameMgr")

function var_0_0.ModelPathGetter(arg_1_0, arg_1_1)
	return arg_1_1.model
end

function var_0_0.SpawnPosGetter(arg_2_0, arg_2_1)
	return arg_2_1.spawnAt
end

function var_0_0.GetUnitCfg(arg_3_0, arg_3_1)
	return BackHomeHeroSkinCfg[arg_3_1]
end

local var_0_1 = "minigame_snowball"

function var_0_0.Ctor(arg_4_0)
	local var_4_0 = EntityManager.CreatePlayer.New(arg_4_0.ModelPathGetter, arg_4_0.SpawnPosGetter)

	arg_4_0.playerManager = EntityManager.New(var_4_0)

	function arg_4_0.playerManager.OnRemove(arg_5_0, arg_5_1)
		manager.notify:Invoke(DORM_CHARACTER_DISPOSE, arg_5_1)
	end

	arg_4_0.managers = {
		arg_4_0.playerManager
	}
	arg_4_0.listener = EventListener.New()
end

function var_0_0.Init(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.listener:RemoveAll()
	arg_7_0.playerManager:Clear(true)
end

local var_0_2 = -1

function var_0_0.SetPlayer(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetPlayerEID()

	if var_8_0 then
		var_0_0.ClearVfxOnEntity(var_8_0)
		arg_8_0.playerManager:Remove(var_0_2)
	end

	arg_8_0.player = arg_8_1

	if arg_8_1 == nil then
		return
	end

	local var_8_1 = GetUnitCfg(arg_8_1)
	local var_8_2 = arg_8_0.playerManager:Create(var_0_2, {
		complex = true,
		model = "CharDorm/" .. var_8_1.model,
		spawnAt = arg_8_0.playerSpawnPos
	}, {
		type = "player",
		cfgID = var_8_1.id
	})
	local var_8_3 = UnityEngine.Camera.main

	Dorm.DormEntityManager.PlayerControlEntity(var_8_2, var_8_3 and var_8_3.transform.forward or Vector3(0, 0, -1))

	local var_8_4 = Dorm.DormEntityManager.QueryPosition(var_8_2)

	Dorm.LuaBridge.MiniGameBridge.PlayEffect(var_8_4, Quaternion.Euler(0, 0, 0), Vector3(0.1, 0.1, 0.1), "Effect/tongyong/fx_appear_UI", 1)
end

function var_0_0.GetPlayerEID(arg_9_0)
	return arg_9_0.playerManager:GetEntityID(var_0_2)
end

function var_0_0.GetPlayerCfgID(arg_10_0)
	return arg_10_0.player
end

function var_0_0.ClearVfxOnEntity(arg_11_0)
	Dorm.DormEntityManager.ClearAllEffect(arg_11_0, var_0_1)
end

return var_0_0
