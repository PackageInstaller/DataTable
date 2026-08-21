local var_0_0 = require("game.GameContext")
local var_0_1 = {}
local var_0_2 = DormCharacterInteractBehaviour
local var_0_3 = Dorm.DormEntityManager

local function var_0_4(arg_1_0)
	local var_1_0 = DormHeroTools:GetCurSkinID(arg_1_0)

	return BackHomeHeroSkinCfg[var_1_0].model
end

local function var_0_5(arg_2_0)
	return "CharDorm/dance/" .. var_0_4(arg_2_0)
end

local function var_0_6(arg_3_0)
	if arg_3_0 == nil then
		return nil
	end

	local var_3_0 = "dance.pos." .. arg_3_0

	return nullable(Dorm.storage:PickData(var_3_0), "transform")
end

local function var_0_7(arg_4_0)
	return "CharDorm/dance/" .. (arg_4_0.skinOverride or var_0_4(arg_4_0.heroID))
end

local function var_0_8(arg_5_0)
	return var_0_6(nullable(arg_5_0, "spawnAt"))
end

function var_0_1.RestartBGM(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.music = arg_6_1 or arg_6_0.music

	manager.audio:StopBGM()

	local var_6_0 = IdolStageMusicCfg[arg_6_0.music]

	if var_6_0 then
		manager.audio:GetBgmPlayer().startTime = arg_6_2 or 0

		manager.audio:PlayBGM(var_6_0.cue_sheet, var_6_0.cue_name, var_6_0.awb_name)
		manager.notify:Invoke("IDOL_DANCE_CHANGE_MUSIC", arg_6_0.music)
	end
end

function var_0_1.Enter(arg_7_0, arg_7_1, arg_7_2)
	BackHomeDataManager:GotoBackHomeCricketStage(BackHomeCricketConst.ROOM_TYPE.TRAIN)

	arg_7_0.previewTasks = {}

	manager.windowBar:SetWhereTag("danceGame")
	manager.ui:SetMainCamera("dance")
	manager.audio:StopAll()

	local var_7_0 = EntityManager.CreateModel.New(var_0_7, var_0_8)

	arg_7_0.entityManager = EntityManager.New(var_7_0)

	local var_7_1 = nullable(arg_7_2, "scene") or IdolStageSceneCfg.all[1]

	arg_7_0.music = nullable(arg_7_2, "music") or IdolStageMusicCfg.all[1]

	arg_7_0:SetScene(var_7_1)

	local var_7_2, var_7_3 = IdolTraineeData:GetCurAttackHeroInfo()

	arg_7_0:SetCharacter(var_7_3)

	if arg_7_2.loadInfo then
		gameContext:UpdateUrlHistory("/dormChooseRoomView", {
			params = {}
		})
		gameContext:UpdateUrlHistory("/dormVisitView", {
			params = {
				back = "back"
			}
		})
		JumpTools.OpenPageByJump("/idolDanceEdit", {
			loadSceneFromSaveData = true,
			music = arg_7_0.music,
			load = arg_7_2.loadInfo
		})
	else
		gameContext:Go("/idolDanceDIY", {
			heroID = var_7_3
		})
	end
end

function var_0_1.Exit(arg_8_0)
	arg_8_0:StopAllPreviewTasks()
	arg_8_0:SetScene(nil)
	DanceGameController.RemoveAddedCueSheets()
end

function var_0_1.SetScene(arg_9_0, arg_9_1)
	if arg_9_0.scene == arg_9_1 then
		return
	end

	local var_9_0
	local var_9_1

	var_9_1, arg_9_0.scene = arg_9_0.scene, arg_9_1

	local var_9_2 = IdolStageSceneCfg[arg_9_1]

	if var_9_2 then
		if DanceGameController.LoadSceneObjAsync("IdolTrainee/DanceEditStage/" .. var_9_2.diy_scene_prefab, function()
			arg_9_0.sceneLoaded = DanceGameController.loadScene

			DormUtils.ClearSceneItemInfo()
			DormLuaBridge.RecordInfoFromDormTag()
			DormUtils.MapSceneItemTagInfo()

			if arg_9_0.charaEID then
				var_0_1.UpdateCharaEntityPos(arg_9_0.charaEID, 1)
			end

			manager.notify:Invoke("IDOL_DANCE_DIY_CHANGE_SCENE", arg_9_1, var_9_1)
		end) and arg_9_0.sceneLoaded and arg_9_0.sceneLoaded:IsValid() then
			SceneManager.UnloadSceneAsync(arg_9_0.sceneLoaded)
		end
	else
		manager.notify:Invoke("IDOL_DANCE_DIY_CHANGE_SCENE", arg_9_1, var_9_1)
	end
end

function var_0_1.SetCharacter(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = 1
	local var_11_1 = DormHeroTools:GetCurSkinID(arg_11_1)

	arg_11_2 = arg_11_2 or {
		complex = true,
		heroID = arg_11_1,
		pos = var_11_0,
		spawnAt = tostring(var_11_0)
	}
	arg_11_3 = arg_11_3 or {
		cfgID = arg_11_1,
		heroID = arg_11_1,
		skinID = var_11_1,
		pos = var_11_0
	}
	arg_11_0.charaEID = arg_11_0.entityManager:Update(1, arg_11_2, arg_11_3)
end

function var_0_1.UpdateCharaEntityPos(arg_12_0, arg_12_1)
	local var_12_0 = var_0_6(arg_12_1)

	if var_12_0 then
		Dorm.DormEntityManager.PutEntityAt(arg_12_0, var_12_0)
	end
end

local function var_0_9(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:Now()
	local var_13_1 = (arg_13_1.startTime or 0) + var_13_0
	local var_13_2

	if arg_13_1.endTime then
		var_13_2 = var_13_0 + arg_13_1.endTime
	end

	return var_13_1, var_13_2
end

local function var_0_10(arg_14_0, arg_14_1)
	local var_14_0 = DormCharacterActionManager.frameTaskRunner
	local var_14_1, var_14_2 = var_0_9(var_14_0, arg_14_1)
	local var_14_3

	if var_14_2 then
		var_14_3 = var_14_2 - var_14_1
	end

	local var_14_4 = var_14_0:NewTask()

	var_14_4:WaitUntil(function()
		return var_14_0:Now() >= var_14_1
	end):Then(function(arg_16_0)
		if arg_14_1.onStart then
			arg_14_1:onStart()
		end

		var_0_3.StopAllCmd(arg_14_0)

		local var_16_0 = arg_14_1.action
		local var_16_1, var_16_2 = DanceGame.MakeCtxForAction(arg_14_0, arg_14_0, var_16_0)

		if var_16_2 then
			if var_14_3 == nil then
				var_14_3 = var_16_2.duration
				var_14_2 = var_14_1 + var_14_3
			else
				var_16_2 = DanceGame.GetSeqAlignedToRoundDuration(var_16_2, var_14_3)
			end

			var_16_1.curActionTask = var_0_2.MakeInteractTask(var_16_2, var_16_1)

			DormUtils.SetEntityInteractContext(arg_14_0, var_16_1)
			var_0_3.SendInteractToEntityCMD(arg_14_0, arg_14_0, true)
		end
	end):WaitUntil(function()
		if var_14_3 > 0 and arg_14_1.onUpdate then
			local var_17_0 = (var_14_0:Now() - var_14_1) / var_14_3

			arg_14_1:onUpdate(var_17_0, var_14_1, var_14_2)
		end

		return var_14_2 == nil or var_14_0:Now() >= var_14_2
	end)
	var_14_4:Start(true)
	var_14_4:SetOnAbort(function()
		DanceGameController.SetEntityAnimeSpeed(arg_14_0, 1)

		if arg_14_1.onAbort then
			arg_14_1:onAbort()
		end
	end)
	var_14_4:SetOnComplete(function()
		DanceGameController.SetEntityAnimeSpeed(arg_14_0, 1)

		if arg_14_1.onComplete then
			arg_14_1:onComplete()
		end
	end)

	return var_14_4
end

function var_0_1.AddPreviewTask(arg_20_0, arg_20_1)
	table.insert(arg_20_0.previewTasks, arg_20_1)
end

function var_0_1.StopAllPreviewTasks(arg_21_0)
	arg_21_0.previewPriority = nil

	local var_21_0 = arg_21_0.charaEID

	Dorm.DormEntityManager.StopAllCmd(var_21_0)

	for iter_21_0, iter_21_1 in pairs(arg_21_0.previewTasks) do
		iter_21_1:Abort()
	end

	arg_21_0.previewTasks = {}
end

function var_0_1.PreviewSingleAction(arg_22_0, arg_22_1)
	arg_22_0:StopAllPreviewTasks()

	arg_22_0.previewPriority = 1

	local var_22_0 = arg_22_0.charaEID

	arg_22_0:AddPreviewTask(var_0_10(var_22_0, arg_22_1))
end

function var_0_1.PreviewSequenceAction(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	arg_23_2 = arg_23_2 or 0

	arg_23_0:RestartBGM(arg_23_0.music, arg_23_2 * 1000)
	arg_23_0:StopAllPreviewTasks()

	arg_23_0.previewPriority = 2

	local var_23_0 = arg_23_0.charaEID

	for iter_23_0, iter_23_1 in pairs(arg_23_1) do
		arg_23_0:AddPreviewTask(var_0_10(var_23_0, iter_23_1))
	end

	local var_23_1 = DormCharacterActionManager.taskRunner:NewTask()

	var_23_1:WaitTask(unpack(arg_23_0.previewTasks)):SetOnComplete(function()
		manager.audio:StopBGM()

		if arg_23_3 then
			arg_23_3()
		end
	end):SetOnAbort(function()
		manager.audio:StopBGM()

		if arg_23_4 then
			arg_23_4()
		end
	end)
	var_23_1:Start(true)
	arg_23_0:AddPreviewTask(var_23_1)
end

function var_0_1.PreviewSequenceActionLooped(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0:PreviewSequenceAction(arg_26_1, 0, function()
		arg_26_0:PreviewSequenceActionLooped(arg_26_1, arg_26_2)
	end, arg_26_2)
end

function var_0_1.GetCurPreviewPriority(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.previewTasks) do
		if not iter_28_1:IsAborted() and not iter_28_1:IsFinished() and not iter_28_1:IsCancelled() then
			return arg_28_0.previewPriority
		end
	end

	return 0
end

function var_0_1.EnterDIY(arg_29_0)
	IdolTraineeAction.GetMySharedDanceDIYStatistics(function()
		return
	end)

	local var_29_0 = DormMinigame.LaterBack()

	if nullable(var_29_0, "backTo", "minigameClass") == var_0_1 then
		JumpTools.OpenPageByJump("/idolDanceEdit", {
			loadSceneFromSaveData = true,
			music = var_0_1.music,
			load = arg_29_0
		})
	else
		var_29_0.loadInfo = arg_29_0
		var_29_0.scene = nullable(arg_29_0, "data", "scene")

		DormMinigame.Launch("WT_DIY", var_0_1, var_29_0)
	end
end

return var_0_1
