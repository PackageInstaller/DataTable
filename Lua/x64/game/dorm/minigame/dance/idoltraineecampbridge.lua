local var_0_0 = {}

local function var_0_1(arg_1_0)
	local var_1_0 = DormHeroTools:GetCurSkinID(arg_1_0)

	return BackHomeHeroSkinCfg[var_1_0].model
end

local function var_0_2(arg_2_0)
	return "CharDorm/idolCamp/" .. var_0_1(arg_2_0)
end

local function var_0_3(arg_3_0)
	return "CharDorm/idolCamp/" .. (arg_3_0.skinOverride or var_0_1(arg_3_0.heroID))
end

local function var_0_4(arg_4_0)
	if arg_4_0.spawnAt == nil then
		return nil
	end

	local var_4_0 = "idol.camp.pos." .. arg_4_0.spawnAt

	return nullable(Dorm.storage:PickData(var_4_0), "transform")
end

function var_0_0.Enter(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.listener = EventListener.New()

	arg_5_0.listener:Register(ON_FINISH_STORY, var_0_0.OnFinishStory)
	arg_5_0.listener:Register(IDOL_TRAINEE_TRAIN_HERO_PROPERTY_CALLBACK, var_0_0.OnTrainingStart)
	arg_5_0.listener:Register(DORM_REGENERATE_HERO, var_0_0.RefreshCharacterAtPos)

	var_0_0.cinemachineBrain = manager.ui.mainCamera:GetComponent("CinemachineBrain")
	var_0_0.cinemachineBrain.enabled = true
	var_0_0.cinemachineBrain.m_DefaultBlend = DanceGameController.cut
	var_0_0.cinemachineBrain.m_CustomBlends = Asset.Load("IdolTrainee/Camp/VCamBlendSetting")
	var_0_0.camera = {}

	local var_5_0 = nullable(Dorm.storage:PickData("idol.camp.camera"), "gameObject")

	for iter_5_0 = 1, var_5_0.transform.childCount do
		local var_5_1 = var_5_0.transform:GetChild(iter_5_0 - 1)

		var_0_0.camera[var_5_1.gameObject.name] = var_5_1.gameObject
	end

	local var_5_2 = EntityManager.CreateModel.New(var_0_3, var_0_4)

	var_0_0.entityManager = EntityManager.New(var_5_2)

	function var_0_0.entityManager.OnCreate(arg_6_0, arg_6_1)
		DanceGameController.InitCampEntity(arg_6_1)
	end

	function var_0_0.entityManager.OnRemove(arg_7_0, arg_7_1)
		local var_7_0 = table.keyof(var_0_0.charaAtPos, arg_7_1)

		if var_7_0 then
			var_0_0.charaAtPos[var_7_0] = nil
		end
	end

	var_0_0.trainerEntityManager = EntityManager.New(var_5_2)
	var_0_0.competitionEntityManager = EntityManager.New(var_5_2)
	var_0_0.walls = {}

	for iter_5_1, iter_5_2 in Dorm.storage:ForeachData("idol.camp.wall", pairs) do
		table.insert(var_0_0.walls, iter_5_2.transform:GetComponent("Collider"))
	end

	var_0_0.charaAtPos = {}

	var_0_0.RefreshCharacterAtPos(true)
	var_0_0.GenerateAttackHero()
	manager.windowBar:SetWhereTag("danceGame")
	gameContext:Go(arg_5_2)

	local var_5_3 = IdolTraineeData:AcquireLastJumpContext()

	if var_5_3 and var_5_3.trainView then
		JumpTools.OpenPageByJump("/idolTraineeTrain", {
			backToDormInfo = var_5_3.backToDormInfo
		})
	end
end

function var_0_0.RefreshCharacterAtPos(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(var_0_0.charaAtPos) do
		var_8_0[iter_8_0] = iter_8_1
	end

	local var_8_1 = IdolTraineeData:GetHeroPosList()

	for iter_8_2, iter_8_3 in pairs(var_8_1) do
		if arg_8_0 or var_0_0.GetCharacterHeroID(var_0_0.charaAtPos[iter_8_2]) ~= iter_8_3 then
			local var_8_2 = var_0_0.GenCharacter(iter_8_3, iter_8_2)

			var_0_0.SetPosOfCharacter(var_8_2, iter_8_2)
		end

		var_8_0[iter_8_2] = nil
	end

	for iter_8_4, iter_8_5 in pairs(var_8_0) do
		var_0_0.RemoveEntity(iter_8_5)
	end
end

function var_0_0.GenerateAttackHero(arg_9_0)
	if not arg_9_0 then
		local var_9_0, var_9_1 = IdolTraineeData:GetCurAttackHeroInfo()

		arg_9_0 = var_9_1
	end

	var_0_0.SetTrainingCharacter(arg_9_0)
end

function var_0_0.Exit(arg_10_0)
	var_0_0.entityManager:Clear()
	var_0_0.trainerEntityManager:Clear()
	var_0_0.competitionEntityManager:Clear()

	var_0_0.entityManager = nil
	var_0_0.trainerEntityManager = nil
	var_0_0.competitionEntityManager = nil
	var_0_0.cinemachineBrain = nil
	var_0_0.camera = nil
	var_0_0.walls = nil
	var_0_0.charaAtPos = nil

	arg_10_0.listener:RemoveAll()

	arg_10_0.listener = nil
end

local function var_0_5(arg_11_0, arg_11_1)
	arg_11_0.pos = arg_11_1

	if arg_11_1 then
		arg_11_0.spawnAt = tostring(arg_11_1)
	end
end

function var_0_0.UpdateCharacterPosInfo(arg_12_0, arg_12_1)
	local var_12_0 = DormUtils.GetEntityData(arg_12_0)

	var_0_5(var_12_0, arg_12_1)
end

function var_0_0.GenCharacter(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if var_0_0.entityManager then
		local var_13_0 = DormData:GetHeroArchiveID(arg_13_0)

		arg_13_2 = arg_13_2 or {
			complex = true,
			heroID = arg_13_0,
			archiveID = var_13_0
		}

		var_0_5(arg_13_2, arg_13_1)

		return var_0_0.entityManager:Update(var_13_0, arg_13_2, arg_13_3)
	end
end

function var_0_0.RemoveEntity(arg_14_0)
	local var_14_0 = var_0_0.entityManager

	if var_14_0 then
		local var_14_1 = var_14_0:Find(arg_14_0)

		if var_14_1 then
			var_14_0:Remove(var_14_1)
		end
	end
end

local var_0_6 = {
	"pos1",
	"pos2",
	"pos3",
	"pos4",
	"pos5"
}

function var_0_0.GetCharacterHeroID(arg_15_0)
	return nullable(DormUtils.GetEntityData(arg_15_0), "heroID")
end

function var_0_0.GetCharacterArchiveID(arg_16_0)
	return nullable(DormUtils.GetEntityData(arg_16_0), "archiveID")
end

local function var_0_7(arg_17_0)
	local var_17_0 = DormRoomTools:GetDormIDViaArchive(arg_17_0.archives_id)
	local var_17_1

	if CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_17_0.archives_id) then
		return DormEnum.DormHeroState.InCanteenEntrust
	end

	if arg_17_0.jobType then
		return DormEnum.DormHeroState.InCanteenJob
	end

	local var_17_2 = DormConst.PUBLIC_DORM_ID

	if var_17_2 then
		local var_17_3 = DormData:GetDormSceneData(var_17_2)

		for iter_17_0, iter_17_1 in ipairs(var_17_3.archiveIDList) do
			if iter_17_1 == arg_17_0.archives_id then
				return DormEnum.DormHeroState.InPublicDorm
			end
		end

		if var_17_0 then
			return DormEnum.DormHeroState.InPrivateDorm
		end

		return DormEnum.DormHeroState.OutDorm
	end
end

local function var_0_8(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 == nil then
		arg_18_0.tempState = var_0_7(arg_18_0)

		if not arg_18_2 then
			arg_18_0:GoToDance(nil)
		end
	elseif arg_18_2 then
		arg_18_0.tempState = DormEnum.DormHeroState.InIdolTraineeCamp
	else
		arg_18_0:GoToDance(arg_18_1)
	end
end

function var_0_0.RemoveEntityTemp(arg_19_0)
	if arg_19_0 then
		local var_19_0 = var_0_0.GetCharacterHeroID(arg_19_0)
		local var_19_1 = DormData:GetHeroTemplateInfo(var_19_0)

		var_0_8(var_19_1, nil, true)
	end

	var_0_0.RemoveEntity(arg_19_0)
end

function var_0_0.SetHeroAnimScheme(arg_20_0, arg_20_1)
	Dorm.DormEntityManager.ChangeEntityAnimeScheme(arg_20_0, var_0_6[arg_20_1])
end

function var_0_0.SetPosOfCharacter(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = var_0_0.charaAtPos[arg_21_1]

	if var_21_0 then
		local var_21_1 = var_0_0.GetCharacterHeroID(var_21_0)
		local var_21_2 = DormData:GetHeroTemplateInfo(var_21_1)

		var_0_0.entityManager:Remove(var_0_0.GetCharacterArchiveID(var_21_0))
		var_0_8(var_21_2, nil, arg_21_2)
	end

	var_0_0.charaAtPos[arg_21_1] = arg_21_0

	if arg_21_0 and Dorm.DormEntityManager.IsValidEntityID(arg_21_0) then
		var_0_0.SetHeroAnimScheme(arg_21_0, arg_21_1)
		Dorm.DormEntityManager.SetNextIdleNoCrossFade(arg_21_0, true)
		Dorm.DormEntityManager.StopAllCmd(arg_21_0)
		var_0_0.UpdateCharacterPosInfo(arg_21_0, arg_21_1)
	end

	local var_21_3 = var_0_0.GetCharacterHeroID(arg_21_0)

	var_0_0.SetPosOfHero(var_21_3, arg_21_1, arg_21_2)
end

function var_0_0.SetPosOfHero(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = DormData:GetHeroTemplateInfo(arg_22_0)

	var_0_8(var_22_0, arg_22_1, arg_22_2)

	return var_22_0
end

function var_0_0.SetHeroStateNil(arg_23_0)
	local var_23_0 = DormData:GetHeroTemplateInfo(arg_23_0)

	var_0_8(var_23_0, nil, false)
end

function var_0_0.RemoveHero(arg_24_0)
	DormData:GetHeroTemplateInfo(arg_24_0):GoToDance(nil)
	manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
end

function var_0_0.GetPosByCharacter(arg_25_0)
	return nullable(DormUtils.GetEntityData(arg_25_0), "pos")
end

function var_0_0.SetTrainingCharacter(arg_26_0)
	if var_0_0.trainerEntityManager then
		local var_26_0 = DormData:GetHeroArchiveID(arg_26_0)

		return var_0_0.trainerEntityManager:Update(1, {
			complex = true,
			spawnAt = "training",
			heroID = arg_26_0,
			archiveID = var_26_0
		})
	end
end

function var_0_0.RemoveTrainingCharacter()
	if var_0_0.trainerEntityManager then
		var_0_0.trainerEntityManager:Clear()
	end
end

function var_0_0.SetCompetitionCharacter(arg_28_0, arg_28_1)
	if var_0_0.competitionEntityManager then
		local var_28_0 = DormData:GetHeroArchiveID(arg_28_0)

		return var_0_0.competitionEntityManager:Update(arg_28_1, {
			complex = true,
			heroID = arg_28_0,
			archiveID = var_28_0,
			pos = arg_28_1,
			spawnAt = "competition" .. arg_28_1
		})
	end
end

function var_0_0.RemoveCompetitionCharacter()
	if var_0_0.competitionEntityManager then
		var_0_0.competitionEntityManager:Clear()
	end
end

function var_0_0.SetVCamActive(arg_30_0, arg_30_1)
	local var_30_0 = var_0_0.camera[arg_30_0]

	SetActive(var_30_0, arg_30_1)
end

function var_0_0.OnFinishStory()
	Dorm.LuaBridge.MiniGameBridge.StopStory(true)

	if var_0_0.OnFinishStoryCallback then
		var_0_0.OnFinishStoryCallback()

		var_0_0.OnFinishStoryCallback = nil
	end
end

IdolTrainingActionCfg = {
	[108502] = {
		type01 = {
			"IdolTrainee/Training/type0101_908502"
		}
	}
}

local function var_0_9(arg_32_0, arg_32_1)
	local var_32_0 = string.format("type%02d", arg_32_1)
	local var_32_1 = DormHeroTools:GetCurSkinID(arg_32_0)
	local var_32_2 = nullable(IdolTrainingActionCfg, var_32_1, var_32_0)

	if var_32_2 == nil or #var_32_2 < 1 then
		var_32_2 = nullable(GameDisplayCfg, "dorm_idol_train_prefab_" .. var_32_0, "value")
	end

	return var_32_2[math.random(#var_32_2)]
end

function var_0_0.OnTrainingStart(arg_33_0, arg_33_1)
	if (getData("IdolTrainee", "skip_show") or 0) == 1 then
		return
	end

	local var_33_0 = var_0_9(arg_33_0, arg_33_1)

	Dorm.LuaBridge.MiniGameBridge.PlayStory(var_33_0, {
		arg_33_0
	}, {
		var_0_2(arg_33_0)
	}, false)
end

return var_0_0
