local var_0_0 = class("FishingGame")
local var_0_1, var_0_2, var_0_3 = unpack(nullable(GameDisplayCfg.activity_kagutsuchi_fish_qte_anime, "value") or {
	"fishing_start",
	"fishing_bite",
	"fishing_finish"
})
local var_0_4 = "fishingMinigame"
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
	local var_2_0 = "fishing.pos." .. arg_2_0.spawnAt

	return Dorm.storage:GetData(var_2_0, 1).transform
end

function var_0_0.Ctor(arg_3_0)
	local var_3_0 = EntityManager.CreateModel.New(var_0_11, var_0_12)

	arg_3_0.entityManager = EntityManager.New(var_3_0)
	arg_3_0.listener = EventListener.New()
end

function var_0_0.Init(arg_4_0)
	arg_4_0.character = arg_4_0.entityManager:Create(var_0_6, {
		model = "CharDorm/activity/fishing/9158_tpose",
		complex = true,
		spawnAt = "player"
	})

	var_0_0.ResetAnime(arg_4_0.character)
	arg_4_0.listener:Register(KAGUTSUCHI_FISHING_EVENT_GAME_START, handler(arg_4_0, arg_4_0.PlayStartAnimeAndWaitQte))
	arg_4_0.listener:Register(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, handler(arg_4_0, arg_4_0.PlayEndAnimeAndWait))
end

function var_0_0.ResetAnime(arg_5_0)
	var_0_10.StopAllCmd(arg_5_0)
end

function var_0_0.PlayStartAnimeAndWaitQte(arg_6_0)
	arg_6_0.listener:Remove(ON_DORM_CHARACTER_WAIT_CMD)
	arg_6_0.listener:Remove(KAGUTSUCHI_FISHING_EVENT_QTE_START)
	var_0_0.ResetAnime(arg_6_0.character)

	if arg_6_0.pole == nil then
		arg_6_0.pole = arg_6_0.entityManager:Create(var_0_7, {
			spawnAt = "player",
			pooled = true,
			model = "CharDorm/prop/diaoyugan",
			complex = true
		})
	end

	var_0_0.ResetAnime(arg_6_0.pole)
	var_0_10.AttachToEntityCMD(arg_6_0.pole, arg_6_0.character, "gua_L_hand_bone")

	if arg_6_0.float == nil then
		arg_6_0.float = arg_6_0.entityManager:Create(var_0_8, {
			spawnAt = "player",
			pooled = true,
			model = "CharDorm/prop/fupiao",
			complex = true
		})
	end

	var_0_0.ResetAnime(arg_6_0.float)

	if arg_6_0.fish == nil then
		arg_6_0.fish = arg_6_0.entityManager:Create(var_0_9, {
			spawnAt = "fish",
			pooled = false,
			model = "CharDorm/prop/fish",
			complex = true
		})
	end

	var_0_0.ResetAnime(arg_6_0.fish)
	var_0_10.SendDoActionCMD(arg_6_0.fish, "fishing_born", true)
	var_0_10.SendDoActionCMD(arg_6_0.character, var_0_1, true)
	var_0_10.SendDoActionCMD(arg_6_0.pole, var_0_1, true)
	var_0_10.SendDoActionCMD(arg_6_0.float, var_0_1, true)
	var_0_10.ChangeEntityAnimeScheme(arg_6_0.character, var_0_5)
	arg_6_0.listener:Register(KAGUTSUCHI_FISHING_EVENT_QTE_START, function()
		arg_6_0.listener:Remove(KAGUTSUCHI_FISHING_EVENT_QTE_START)
		arg_6_0:PlayQteAnimeAndWaitFinish()
	end)
end

function var_0_0.PlayQteAnimeAndWaitFinish(arg_8_0)
	arg_8_0.fishBite = true

	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_loop", "")
	var_0_0.ResetAnime(arg_8_0.character)
	var_0_0.ResetAnime(arg_8_0.pole)
	var_0_0.ResetAnime(arg_8_0.float)
	var_0_0.ResetAnime(arg_8_0.fish)
	var_0_10.SendDoActionCMD(arg_8_0.character, var_0_2, nil, true, false)
	var_0_10.SendDoActionCMD(arg_8_0.pole, var_0_2, nil, true, false)
	var_0_10.SendDoActionCMD(arg_8_0.float, var_0_2, nil, true, false)
	var_0_10.SendDoActionCMD(arg_8_0.fish, var_0_2, nil, true, false)
end

function var_0_0.PlayEndAnimeAndWait(arg_9_0, arg_9_1, arg_9_2)
	var_0_0.ResetAnime(arg_9_0.character)
	var_0_0.ResetAnime(arg_9_0.pole)
	var_0_0.ResetAnime(arg_9_0.float)
	var_0_0.ResetAnime(arg_9_0.fish)

	local var_9_0 = "minigame_activity_2_6_1158_fish_end" .. (arg_9_2 and "01" or "02")

	manager.audio:PlayEffect("minigame_activity_2_6_1158", var_9_0, "")
	var_0_10.RestoreEntityAnimeScheme(arg_9_0.character)
	var_0_10.SendDoActionCMD(arg_9_0.character, var_0_3, false)
	var_0_10.SendDoActionCMD(arg_9_0.pole, var_0_3, false)
	var_0_10.SendDoActionCMD(arg_9_0.float, var_0_3, false)

	if arg_9_0.fishBite then
		var_0_10.SendDoActionCMD(arg_9_0.fish, var_0_3, false)
	else
		arg_9_0.entityManager:Remove(var_0_9)

		arg_9_0.fish = nil
	end

	arg_9_0.fishBite = false

	arg_9_0.listener:Register(ON_DORM_CHARACTER_WAIT_CMD, function(arg_10_0)
		if arg_10_0 ~= arg_9_0.character then
			return
		end

		arg_9_0.listener:Remove(ON_DORM_CHARACTER_WAIT_CMD)
		arg_9_0.entityManager:Remove(var_0_7)
		arg_9_0.entityManager:Remove(var_0_8)

		arg_9_0.pole = nil
		arg_9_0.float = nil

		if arg_9_0.fish then
			arg_9_0.entityManager:Remove(var_0_9)

			arg_9_0.fish = nil
		end
	end)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.character = nil
	arg_11_0.pole = nil
	arg_11_0.float = nil
	arg_11_0.fish = nil

	arg_11_0.entityManager:Clear()
	arg_11_0.listener:RemoveAll()
end

return var_0_0
