local FishingGame = class("FishingGame")
local var_0_1, var_0_2, var_0_3 = unpack(nullable(GameDisplayCfg.activity_kagutsuchi_fish_qte_anime, "value") or {
	"fishing_start",
	"fishing_bite",
	"fishing_finish"
})
local var_0_5 = "fishing"
local var_0_6 = 1
local var_0_7 = 2
local var_0_8 = 3
local var_0_9 = 4
local var_0_10 = Dorm.DormEntityManager

local function var_0_11(arg_1_0)
	return arg_1_0.model
end

local function var_0_12(arg_2_0)
	return Dorm.storage:GetData("fishing.pos." .. arg_2_0.spawnAt, 1).transform
end

function FishingGame:Ctor()
	self.entityManager = EntityManager.New((EntityManager.CreateModel.New(var_0_11, var_0_12)))
	self.listener = EventListener.New()
end

function FishingGame:Init()
	self.character = self.entityManager:Create(var_0_6, {
		model = "CharDorm/activity/fishing/9158_tpose",
		complex = true,
		spawnAt = "player"
	})

	FishingGame.ResetAnime(self.character)
	self.listener:Register(KAGUTSUCHI_FISHING_EVENT_GAME_START, handler(self, self.PlayStartAnimeAndWaitQte))
	self.listener:Register(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, handler(self, self.PlayEndAnimeAndWait))
end

function FishingGame:ResetAnime()
	var_0_10.StopAllCmd(self)
end

function FishingGame:PlayStartAnimeAndWaitQte()
	self.listener:Remove(ON_DORM_CHARACTER_WAIT_CMD)
	self.listener:Remove(KAGUTSUCHI_FISHING_EVENT_QTE_START)
	FishingGame.ResetAnime(self.character)

	if self.pole == nil then
		self.pole = self.entityManager:Create(var_0_7, {
			spawnAt = "player",
			pooled = true,
			model = "CharDorm/prop/diaoyugan",
			complex = true
		})
	end

	FishingGame.ResetAnime(self.pole)
	var_0_10.AttachToEntityCMD(self.pole, self.character, "gua_L_hand_bone")

	if self.float == nil then
		self.float = self.entityManager:Create(var_0_8, {
			spawnAt = "player",
			pooled = true,
			model = "CharDorm/prop/fupiao",
			complex = true
		})
	end

	FishingGame.ResetAnime(self.float)

	if self.fish == nil then
		self.fish = self.entityManager:Create(var_0_9, {
			spawnAt = "fish",
			pooled = false,
			model = "CharDorm/prop/fish",
			complex = true
		})
	end

	FishingGame.ResetAnime(self.fish)
	var_0_10.SendDoActionCMD(self.fish, "fishing_born", true)
	var_0_10.SendDoActionCMD(self.character, var_0_1, true)
	var_0_10.SendDoActionCMD(self.pole, var_0_1, true)
	var_0_10.SendDoActionCMD(self.float, var_0_1, true)
	var_0_10.ChangeEntityAnimeScheme(self.character, var_0_5)
	self.listener:Register(KAGUTSUCHI_FISHING_EVENT_QTE_START, function()
		self.listener:Remove(KAGUTSUCHI_FISHING_EVENT_QTE_START)
		self:PlayQteAnimeAndWaitFinish()
	end)
end

function FishingGame:PlayQteAnimeAndWaitFinish()
	self.fishBite = true

	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_loop", "")
	FishingGame.ResetAnime(self.character)
	FishingGame.ResetAnime(self.pole)
	FishingGame.ResetAnime(self.float)
	FishingGame.ResetAnime(self.fish)
	var_0_10.SendDoActionCMD(self.character, var_0_2, nil, true, false)
	var_0_10.SendDoActionCMD(self.pole, var_0_2, nil, true, false)
	var_0_10.SendDoActionCMD(self.float, var_0_2, nil, true, false)
	var_0_10.SendDoActionCMD(self.fish, var_0_2, nil, true, false)
end

function FishingGame:PlayEndAnimeAndWait(arg_9_1, arg_9_2)
	FishingGame.ResetAnime(self.character)
	FishingGame.ResetAnime(self.pole)
	FishingGame.ResetAnime(self.float)
	FishingGame.ResetAnime(self.fish)
	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_end" .. (arg_9_2 and "01" or "02"), "")
	var_0_10.RestoreEntityAnimeScheme(self.character)
	var_0_10.SendDoActionCMD(self.character, var_0_3, false)
	var_0_10.SendDoActionCMD(self.pole, var_0_3, false)
	var_0_10.SendDoActionCMD(self.float, var_0_3, false)

	if self.fishBite then
		var_0_10.SendDoActionCMD(self.fish, var_0_3, false)
	else
		self.entityManager:Remove(var_0_9)

		self.fish = nil
	end

	self.fishBite = false

	self.listener:Register(ON_DORM_CHARACTER_WAIT_CMD, function(arg_10_0)
		if arg_10_0 ~= self.character then
			return
		end

		self.listener:Remove(ON_DORM_CHARACTER_WAIT_CMD)
		self.entityManager:Remove(var_0_7)
		self.entityManager:Remove(var_0_8)

		self.pole = nil
		self.float = nil

		if self.fish then
			self.entityManager:Remove(var_0_9)

			self.fish = nil
		end
	end)
end

function FishingGame:Dispose()
	self.character = nil
	self.pole = nil
	self.float = nil
	self.fish = nil

	self.entityManager:Clear()
	self.listener:RemoveAll()
end

return FishingGame
