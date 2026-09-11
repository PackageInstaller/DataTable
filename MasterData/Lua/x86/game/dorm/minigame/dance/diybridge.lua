local GameContext = require("game.GameContext")
local var_0_1 = {}
local var_0_2 = DormCharacterInteractBehaviour
local var_0_3 = Dorm.DormEntityManager

local function var_0_4(arg_1_0)
	return BackHomeHeroSkinCfg[DormHeroTools:GetCurSkinID(arg_1_0)].model
end

local function var_0_6(arg_3_0)
	if arg_3_0 == nil then
		return nil
	end

	return nullable(Dorm.storage:PickData("dance.pos." .. arg_3_0), "transform")
end

local function var_0_7(arg_4_0)
	return "CharDorm/dance/" .. (arg_4_0.skinOverride or var_0_4(arg_4_0.heroID))
end

local function var_0_8(arg_5_0)
	return var_0_6(nullable(arg_5_0, "spawnAt"))
end

function var_0_1:RestartBGM(arg_6_1, arg_6_2)
	self.music = arg_6_1 or self.music

	manager.audio:StopBGM()

	if IdolStageMusicCfg[self.music] then
		manager.audio:GetBgmPlayer().startTime = arg_6_2 or 0

		manager.audio:PlayBGM(IdolStageMusicCfg[self.music].cue_sheet, IdolStageMusicCfg[self.music].cue_name, IdolStageMusicCfg[self.music].awb_name)
		manager.notify:Invoke("IDOL_DANCE_CHANGE_MUSIC", self.music)
	end
end

function var_0_1:Enter(arg_7_1, arg_7_2)
	BackHomeDataManager:GotoBackHomeCricketStage(BackHomeCricketConst.ROOM_TYPE.TRAIN)

	self.previewTasks = {}

	manager.windowBar:SetWhereTag("danceGame")
	manager.ui:SetMainCamera("dance")
	manager.audio:StopAll()

	self.entityManager = EntityManager.New((EntityManager.CreateModel.New(var_0_7, var_0_8)))

	local var_7_0 = nullable(arg_7_2, "scene") or IdolStageSceneCfg.all[1]

	self.music = nullable(arg_7_2, "music") or IdolStageMusicCfg.all[1]

	self:SetScene(var_7_0)

	local var_7_1, var_7_2 = IdolTraineeData:GetCurAttackHeroInfo()

	self:SetCharacter(var_7_2)

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
			music = self.music,
			load = arg_7_2.loadInfo
		})
	else
		gameContext:Go("/idolDanceDIY", {
			heroID = var_7_2
		})
	end
end

function var_0_1:Exit()
	self:StopAllPreviewTasks()
	self:SetScene(nil)
	DanceGameController.RemoveAddedCueSheets()
end

function var_0_1:SetScene(arg_9_1)
	if self.scene == arg_9_1 then
		return
	end

	local var_9_1

	var_9_1, self.scene = self.scene, arg_9_1

	if IdolStageSceneCfg[arg_9_1] then
		if DanceGameController.LoadSceneObjAsync("IdolTrainee/DanceEditStage/" .. IdolStageSceneCfg[arg_9_1].diy_scene_prefab, function()
			self.sceneLoaded = DanceGameController.loadScene

			DormUtils.ClearSceneItemInfo()
			DormLuaBridge.RecordInfoFromDormTag()
			DormUtils.MapSceneItemTagInfo()

			if self.charaEID then
				var_0_1.UpdateCharaEntityPos(self.charaEID, 1)
			end

			manager.notify:Invoke("IDOL_DANCE_DIY_CHANGE_SCENE", arg_9_1, var_9_1)
		end) and self.sceneLoaded and self.sceneLoaded:IsValid() then
			SceneManager.UnloadSceneAsync(self.sceneLoaded)
		end
	else
		manager.notify:Invoke("IDOL_DANCE_DIY_CHANGE_SCENE", arg_9_1, var_9_1)
	end
end

function var_0_1:SetCharacter(arg_11_1, arg_11_2, arg_11_3)
	arg_11_2 = arg_11_2 or {
		complex = true,
		heroID = arg_11_1,
		pos = 1,
		spawnAt = tostring(1)
	}
	arg_11_3 = arg_11_3 or {
		cfgID = arg_11_1,
		heroID = arg_11_1,
		skinID = DormHeroTools:GetCurSkinID(arg_11_1),
		pos = 1
	}
	self.charaEID = self.entityManager:Update(1, arg_11_2, arg_11_3)
end

function var_0_1.UpdateCharaEntityPos(arg_12_0, arg_12_1)
	local var_12_0 = var_0_6(arg_12_1)

	if var_12_0 then
		Dorm.DormEntityManager.PutEntityAt(arg_12_0, var_12_0)
	end
end

local function var_0_9(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:Now()

	return (arg_13_1.startTime or 0) + var_13_0, (arg_13_1.endTime or nil) and var_13_0 + arg_13_1.endTime
end

local function var_0_10(arg_14_0, arg_14_1)
	local var_14_0 = DormCharacterActionManager.frameTaskRunner
	local var_14_1, var_14_2 = var_0_9(DormCharacterActionManager.frameTaskRunner, arg_14_1)
	local var_14_3

	if var_14_2 then
		var_14_3 = var_14_2 - var_14_1
	end

	local var_14_4 = DormCharacterActionManager.frameTaskRunner:NewTask()

	var_14_4:WaitUntil(function()
		return var_14_0:Now() >= var_14_1
	end):Then(function(arg_16_0)
		if arg_14_1.onStart then
			arg_14_1:onStart()
		end

		var_0_3.StopAllCmd(arg_14_0)

		local var_16_0, var_16_1 = DanceGame.MakeCtxForAction(arg_14_0, arg_14_0, arg_14_1.action)

		if var_16_1 then
			if var_14_3 == nil then
				var_14_3 = var_16_1.duration
				var_14_2 = var_14_1 + var_14_3
			else
				var_16_1 = DanceGame.GetSeqAlignedToRoundDuration(var_16_1, var_14_3)
			end

			var_16_0.curActionTask = var_0_2.MakeInteractTask(var_16_1, var_16_0)

			DormUtils.SetEntityInteractContext(arg_14_0, var_16_0)
			var_0_3.SendInteractToEntityCMD(arg_14_0, arg_14_0, true)
		end
	end):WaitUntil(function()
		if var_14_3 > 0 and arg_14_1.onUpdate then
			arg_14_1:onUpdate((var_14_0:Now() - var_14_1) / var_14_3, var_14_1, var_14_2)
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

function var_0_1:AddPreviewTask(arg_20_1)
	table.insert(self.previewTasks, arg_20_1)
end

function var_0_1:StopAllPreviewTasks()
	self.previewPriority = nil

	Dorm.DormEntityManager.StopAllCmd(self.charaEID)

	for iter_21_0, iter_21_1 in pairs(self.previewTasks) do
		iter_21_1:Abort()
	end

	self.previewTasks = {}
end

function var_0_1:PreviewSingleAction(arg_22_1)
	self:StopAllPreviewTasks()

	self.previewPriority = 1

	self:AddPreviewTask(var_0_10(self.charaEID, arg_22_1))
end

function var_0_1:PreviewSequenceAction(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	arg_23_2 = arg_23_2 or 0

	self:RestartBGM(self.music, arg_23_2 * 1000)
	self:StopAllPreviewTasks()

	self.previewPriority = 2

	for iter_23_0, iter_23_1 in pairs(arg_23_1) do
		self:AddPreviewTask(var_0_10(self.charaEID, iter_23_1))
	end

	local var_23_0 = DormCharacterActionManager.taskRunner:NewTask()

	var_23_0:WaitTask(unpack(self.previewTasks)):SetOnComplete(function()
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
	var_23_0:Start(true)
	self:AddPreviewTask(var_23_0)
end

function var_0_1:PreviewSequenceActionLooped(arg_26_1, arg_26_2)
	self:PreviewSequenceAction(arg_26_1, 0, function()
		self:PreviewSequenceActionLooped(arg_26_1, arg_26_2)
	end, arg_26_2)
end

function var_0_1:GetCurPreviewPriority()
	for iter_28_0, iter_28_1 in pairs(self.previewTasks) do
		if not iter_28_1:IsAborted() and not iter_28_1:IsFinished() and not iter_28_1:IsCancelled() then
			return self.previewPriority
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
