local var_0_0 = require("game.config.SkinCfg")
local var_0_1 = singletonClass("DormCharacterManager")

function var_0_1.GetModelFunc(arg_1_0, arg_1_1)
	arg_1_0 = arg_1_0 or BackHomeHeroSkinCfg
	arg_1_1 = arg_1_1 or "CharDorm/"

	return function(arg_2_0)
		local var_2_0

		if arg_2_0.skinOverride then
			var_2_0 = arg_2_0.skinOverride
		else
			var_2_0 = nullable(arg_1_0, nullable(arg_2_0, "skinID"), "model")
		end

		return arg_1_1 .. var_2_0
	end
end

local var_0_2 = var_0_1.GetModelFunc(BackHomeHeroSkinCfg)
local var_0_3 = 1.25
local var_0_4 = DormEnum.CharacterType.DormNormalHero

function var_0_1.Ctor(arg_3_0)
	arg_3_0.listener = EventListener.New()

	local var_3_0 = EntityManager.CreatePlayer.New(var_0_2)
	local var_3_1 = EntityManager.New(var_3_0)

	function var_3_1.OnCreate(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = nullable(BackHomeHeroSkinCfg, nullable(arg_4_2, "skinID"), "default_mouth") or 0

		Dorm.DormEntityManager.SetDefaultMouth(arg_4_1, var_4_0)

		if not arg_4_2.skipFade then
			Dorm.DormEntityManager.StartFadeInCMD(arg_4_1, var_0_3, function()
				DormUtils.ShowCharaSpecialVfx(arg_4_1, Dorm.charaVfxActiveType)
			end)
		else
			DormUtils.ShowCharaSpecialVfx(arg_4_1, Dorm.charaVfxActiveType)
		end

		arg_3_0:RecordEntityInfo(arg_4_1, arg_4_2)
		arg_3_0.dormHeroAI:AddCharacterAI(arg_4_1)
	end

	function var_3_1.OnRemove(arg_6_0, arg_6_1)
		arg_3_0.dormHeroAI:RemoveCharacterAI(arg_6_1)
		arg_3_0:RemoveEntityInfo(arg_6_1)
		manager.notify:Invoke(DORM_CHARACTER_DISPOSE, arg_6_1, var_0_4)
	end

	arg_3_0.entityManager = var_3_1

	arg_3_0:InitVisitEntityManager(var_3_0)
end

function var_0_1.InitVisitEntityManager(arg_7_0, arg_7_1)
	local var_7_0 = EntityManager.New(arg_7_1)

	function var_7_0.OnCreate(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = nullable(BackHomeHeroSkinCfg, nullable(arg_8_2, "skinID"), "default_mouth") or 0

		Dorm.DormEntityManager.SetDefaultMouth(arg_8_1, var_8_0)

		if not arg_8_2.skipFade then
			Dorm.DormEntityManager.StartFadeInCMD(arg_8_1, var_0_3, function()
				DormUtils.ShowCharaSpecialVfx(arg_8_1, Dorm.charaVfxActiveType)
			end)
		else
			DormUtils.ShowCharaSpecialVfx(arg_8_1, Dorm.charaVfxActiveType)
		end

		arg_7_0:RecordEntityInfo(arg_8_1, arg_8_2)
		arg_7_0.dormHeroAI:AddCharacterAI(arg_8_1)
	end

	function var_7_0.OnRemove(arg_10_0, arg_10_1)
		arg_7_0.dormHeroAI:RemoveCharacterAI(arg_10_1)
		arg_7_0:RemoveEntityInfo(arg_10_1)
		manager.notify:Invoke(DORM_CHARACTER_DISPOSE, arg_10_1, var_0_4)
	end

	arg_7_0.visitEntityManager = var_7_0
end

function var_0_1.RecordEntityInfo(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = Dorm.storage
	local var_11_1 = DormEnum.Namespace.EntityType

	var_11_0:RecordData(var_11_1, arg_11_1, var_0_4)
end

function var_0_1.RemoveEntityInfo(arg_12_0, arg_12_1)
	local var_12_0 = Dorm.storage
	local var_12_1 = DormEnum.Namespace.EntityType

	var_12_0:RecordData(var_12_1, arg_12_1, nil)
	arg_12_0:OnCharaGrabReleased(arg_12_1)
end

function var_0_1.Init(arg_13_0)
	arg_13_0:RegisterEvent()

	arg_13_0.dormHeroAI = DormHeroAI.GetInstance()

	arg_13_0.dormHeroAI:Init()
	arg_13_0.entityManager:Clear()
	arg_13_0.entityManager:MapToDormStorageData(DormUtils.EIdNamespace(var_0_4), DormUtils.IdxNamespace(var_0_4))
	arg_13_0.visitEntityManager:Clear()
end

function var_0_1.Reset(arg_14_0)
	arg_14_0:RemoveEvent()
	arg_14_0.dormHeroAI:Dispose()
	arg_14_0:Clear()
end

function var_0_1.RegisterEvent(arg_15_0)
	arg_15_0.listener:Register(ON_DORM_CHARACTER_GRAB_STARTED, handler(arg_15_0, arg_15_0.OnCharaGrabStart))
	arg_15_0.listener:Register(ON_DORM_CHARACTER_GRAB_RELEASED, handler(arg_15_0, arg_15_0.OnCharaGrabReleased))
	arg_15_0.listener:Register(DORM_REGENERATE_HERO, handler(arg_15_0, arg_15_0.OnDormRegenerateHero))
end

function var_0_1.RemoveEvent(arg_16_0)
	arg_16_0.listener:RemoveAll()
end

function var_0_1.OnBeginStory(arg_17_0, arg_17_1)
	if DormEnum.HasFlag(arg_17_1, DormEnum.BeginStoryFlag.HideCharacter) then
		arg_17_0:Clear()
	end
end

function var_0_1.OnFinishStory(arg_18_0, arg_18_1)
	if DormEnum.HasFlag(arg_18_1, DormEnum.BeginStoryFlag.HideCharacter) then
		DormHeroTools:GenerateHeroWhenEnterScene()
	end
end

function var_0_1.GetGenCharaInfoBySkinID(arg_19_0, arg_19_1)
	local var_19_0 = var_0_0[arg_19_0].hero

	return {
		complex = true,
		archiveID = DormData:GetHeroArchiveID(var_19_0),
		skinID = arg_19_0,
		skinOverride = arg_19_1
	}
end

function var_0_1.LocalSaveCharaSkinVariant(arg_20_0, arg_20_1)
	return saveData("Dorm", string.format("skinVariant_%d", arg_20_0), arg_20_1)
end

function var_0_1.GetLocalSavedCharaSkinVariant(arg_21_0)
	return getData("Dorm", string.format("skinVariant_%d", arg_21_0))
end

function var_0_1.GetSkinOverride(arg_22_0, arg_22_1)
	local var_22_0 = nullable(BackHomeHeroSkinVariantCfg, arg_22_0)

	return nullable(var_22_0, "asset_list", arg_22_1)
end

function var_0_1.Generate(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	arg_23_3 = arg_23_3 or {}
	arg_23_4 = arg_23_4 or {}

	local var_23_0 = arg_23_4.skinVariant or var_0_1.GetLocalSavedCharaSkinVariant(arg_23_1)

	arg_23_3.skinID, arg_23_3.skipFade = arg_23_3.skinID or arg_23_1, arg_23_2

	if var_23_0 then
		arg_23_3.skinOverride = var_0_1.GetSkinOverride(arg_23_1, var_23_0)

		if arg_23_3.skinOverride == nil then
			var_23_0 = nil
		end
	end

	arg_23_4.cfgID, arg_23_4.heroID = arg_23_3.skinID, nullable(BackHomeHeroSkinCfg, arg_23_3.skinID, "hero_id")
	arg_23_4.skinVariant = var_23_0

	local var_23_1, var_23_2 = arg_23_0.entityManager:Update(arg_23_1, arg_23_3, arg_23_4)

	Dorm.DormEntityManager.SetEntitySpeed(var_23_1, 0.5)

	return var_23_1, var_23_2
end

function var_0_1.GenerateVisit(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = {}

	var_24_0.skinID, var_24_0.skipFade = arg_24_1, arg_24_2

	local var_24_1, var_24_2 = arg_24_0.visitEntityManager:Update(arg_24_1, var_24_0, {
		cfgID = arg_24_1,
		heroID = nullable(BackHomeHeroSkinCfg, arg_24_1, "hero_id")
	})

	Dorm.DormEntityManager.SetEntitySpeed(var_24_1, 0.5)
	DormHeroTools:ShowVisitTalk()

	return var_24_1, var_24_2
end

function var_0_1.RemoveVisit(arg_25_0, arg_25_1)
	return arg_25_0.visitEntityManager:Remove(arg_25_1)
end

function var_0_1.CheckIsVisitHero(arg_26_0, arg_26_1)
	return arg_26_0.visitEntityManager and arg_26_0.visitEntityManager:Find(arg_26_1) ~= nil
end

function var_0_1.GetVisitEntityID(arg_27_0, arg_27_1)
	return arg_27_0.visitEntityManager:GetEntityID(arg_27_1)
end

function var_0_1.Remove(arg_28_0, arg_28_1)
	return arg_28_0.entityManager:Remove(arg_28_1)
end

function var_0_1.GetEntityID(arg_29_0, arg_29_1)
	return arg_29_0.entityManager:GetEntityID(arg_29_1)
end

function var_0_1.Clear(arg_30_0)
	arg_30_0.entityManager:Clear()
	arg_30_0.visitEntityManager:Clear()
end

function var_0_1.FindAndRemove(arg_31_0)
	local var_31_0 = var_0_1.GetInstance()

	EntityManager.FindAndRemoveEntity({
		var_31_0.entityManager
	}, arg_31_0)
end

var_0_1.curGrabbingInfoNamespace = "dorm.curGrabbing"

function var_0_1.OnCharaGrabStart(arg_32_0, arg_32_1)
	local var_32_0 = var_0_1.curGrabbingInfoNamespace
	local var_32_1 = Dorm.storage:GetData(var_32_0, "eid")

	Dorm.storage:RecordData(var_32_0, "eid", arg_32_1)
	manager.notify:Invoke(DORM_CUR_GRABBING_CHARACTER_CHANGE, var_32_1, arg_32_1)
end

function var_0_1.OnCharaGrabReleased(arg_33_0, arg_33_1)
	local var_33_0 = var_0_1.curGrabbingInfoNamespace

	if Dorm.storage:GetData(var_33_0, "eid") == arg_33_1 then
		Dorm.storage:RecordData(var_33_0, "eid", nil)
		manager.notify:Invoke(DORM_CUR_GRABBING_CHARACTER_CHANGE, arg_33_1, nil)
	end
end

function var_0_1.GetCharacterNum(arg_34_0)
	return arg_34_0.entityManager.managedEntityNum
end

function var_0_1.OnDormRegenerateHero(arg_35_0)
	DormHeroTools:ReGenerateDormHeroEntity()
end

return var_0_1
