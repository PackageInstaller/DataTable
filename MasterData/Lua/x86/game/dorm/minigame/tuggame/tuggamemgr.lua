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

function var_0_0:Ctor()
	self.playerManager = EntityManager.New((EntityManager.CreatePlayer.New(self.ModelPathGetter, self.SpawnPosGetter)))

	function self.playerManager.OnRemove(arg_5_0, arg_5_1)
		manager.notify:Invoke(DORM_CHARACTER_DISPOSE, arg_5_1)
	end

	self.managers = {
		self.playerManager
	}
	self.listener = EventListener.New()
end

function var_0_0.Init(arg_6_0)
	return
end

function var_0_0:Dispose()
	self.listener:RemoveAll()
	self.playerManager:Clear(true)
end

local var_0_2 = -1

function var_0_0:SetPlayer(arg_8_1)
	local var_8_0 = self:GetPlayerEID()

	if var_8_0 then
		var_0_0.ClearVfxOnEntity(var_8_0)
		self.playerManager:Remove(var_0_2)
	end

	self.player = arg_8_1

	if arg_8_1 == nil then
		return
	end

	local var_8_1 = GetUnitCfg(arg_8_1)
	local var_8_2 = self.playerManager:Create(var_0_2, {
		complex = true,
		model = "CharDorm/" .. var_8_1.model,
		spawnAt = self.playerSpawnPos
	}, {
		type = "player",
		cfgID = var_8_1.id
	})

	Dorm.DormEntityManager:PlayerControlEntity((UnityEngine.Camera.main or nil) and (UnityEngine.Camera.main.transform.forward or Vector3(0, 0, -1)))
	Dorm.LuaBridge.MiniGameBridge.PlayEffect(Dorm.DormEntityManager.QueryPosition(var_8_2), Quaternion.Euler(0, 0, 0), Vector3(0.1, 0.1, 0.1), "Effect/tongyong/fx_appear_UI", 1)
end

function var_0_0:GetPlayerEID()
	return self.playerManager:GetEntityID(var_0_2)
end

function var_0_0:GetPlayerCfgID()
	return self.player
end

function var_0_0.ClearVfxOnEntity(arg_11_0)
	Dorm.DormEntityManager.ClearAllEffect(arg_11_0, var_0_1)
end

return var_0_0
