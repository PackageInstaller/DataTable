local var_0_0 = singletonClass("PushSnowballGameMgr")

local function var_0_1(arg_1_0)
	return arg_1_0.model
end

local function var_0_2(arg_2_0)
	return arg_2_0.spawnAt
end

local function var_0_3(arg_3_0)
	return BackHomeHeroSkinCfg[arg_3_0]
end

local var_0_4 = "minigame_snowball"

function var_0_0:Ctor()
	self.playerManager = EntityManager.New((EntityManager.CreatePlayer.New(var_0_1, var_0_2)))

	function self.playerManager.OnRemove(arg_5_0, arg_5_1)
		manager.notify:Invoke(DORM_CHARACTER_DISPOSE, arg_5_1)
	end

	self.managers = {
		self.playerManager
	}
	self.listener = EventListener.New()
end

function var_0_0:Init()
	self.listener:Register(DORM_CLICK_ENTITY, handler(self, self.OnClickEntity))
end

function var_0_0:Dispose()
	self.listener:RemoveAll()
	self.playerManager:Clear(true)
end

local var_0_5 = -1

function var_0_0:SetPlayer(arg_8_1)
	local var_8_0 = self:GetPlayerEID()

	if var_8_0 then
		var_0_0.ClearVfxOnEntity(var_8_0)
		self.playerManager:Remove(var_0_5)
	end

	self.player = arg_8_1

	if arg_8_1 == nil then
		return
	end

	local var_8_1 = var_0_3(arg_8_1)
	local var_8_2 = self.playerManager:Create(var_0_5, {
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
	return self.playerManager:GetEntityID(var_0_5)
end

function var_0_0:GetPlayerCfgID()
	return self.player
end

function var_0_0.ClearVfxOnEntity(arg_11_0)
	Dorm.DormEntityManager.ClearAllEffect(arg_11_0, var_0_4)
end

return var_0_0
