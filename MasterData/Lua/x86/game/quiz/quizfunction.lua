local var_0_0 = P08.Quiz.PlayerManager.Instance
local var_0_1 = {}
local var_0_2 = 0
local var_0_3 = {}
local var_0_4 = 0
local var_0_5 = 0
local var_0_6 = 0
local var_0_8 = 1
local var_0_9 = os.time()
local var_0_10 = {}

function var_0_1.Cfg_GetGestureCd(arg_1_0)
	return GameSetting.action_time.value[1]
end

function var_0_1.Cfg_GetEmojiCd(arg_2_0)
	return GameSetting.talk_time.value[1]
end

function var_0_1.Cfg_GetMaxQuestionCount(arg_3_0)
	local var_3_0 = ActivityQuizCfg[ActivityQuizCfg.get_id_list_by_activity_id[ActivityQuizTools.GetCurActivityID()][1]]

	return var_3_0.quiz_zone[table.length(var_3_0.quiz_zone)][1]
end

function var_0_1:Cfg_GetSeqOfScoreBonus()
	return self:Cfg_GetMaxQuestionCount() - 3
end

function var_0_1.Cfg_GetScore(arg_5_0, arg_5_1)
	return ActivityQuizTableCfg[arg_5_1].point
end

function var_0_1.Cfg_GetScoreMulti(arg_6_0)
	return 1
end

function var_0_1.Cfg_GetDefaultModelId(arg_7_0)
	return ActivityQuizCfg[ActivityQuizCfg.get_id_list_by_activity_id[ActivityQuizTools.GetCurActivityID()][1]].character_list[1]
end

function var_0_1.Cfg_GetPigModelId(arg_8_0)
	return ActivityQuizCfg[ActivityQuizCfg.get_id_list_by_activity_id[ActivityQuizTools.GetCurActivityID()][1]].punish_character
end

function var_0_1.Cfg_GetMaxModelScale(arg_9_0)
	return GameSetting.max_percent.value[1]
end

function var_0_1.Cfg_GetModelScaleMulti(arg_10_0)
	return GameSetting.add_percent.value[1]
end

function var_0_1.PlayEmoji(arg_11_0, arg_11_1, arg_11_2)
	manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_PLAY_STICKER, arg_11_1, arg_11_2)
end

function var_0_1.ShowScoreBonusEffect(arg_12_0)
	return
end

function var_0_1:OnGameStart(arg_13_1)
	self:InitData()

	var_0_2 = 1
	var_0_4 = arg_13_1.timestamp
end

function var_0_1.AddPlayers(arg_14_0, arg_14_1)
	local var_14_0 = ActivityQuizCfg[ActivityQuizCfg.get_id_list_by_activity_id[ActivityQuizTools.GetCurActivityID()][1]]

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		if not var_0_3[iter_14_1.uid] then
			var_0_3[iter_14_1.uid] = {}

			table.insert(var_0_3.all, iter_14_1.uid)
		end

		var_0_3[iter_14_1.uid] = {
			score = 0,
			id = iter_14_1.uid,
			nick = iter_14_1.nickname
		}

		if iter_14_1.uid == USER_ID then
			curHeroID_ = iter_14_1.role_id == 0 and 1084 or var_14_0.character_list[1]
		end
	end
end

function var_0_1.OnShowPrologue(arg_15_0, arg_15_1)
	var_0_2 = 2
	var_0_4 = arg_15_1.timestamp

	manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_START_PROLOGUE)
end

function var_0_1.ShowQuestion(arg_16_0, arg_16_1)
	var_0_2 = 3
	var_0_4 = arg_16_1.timestamp
	var_0_5 = arg_16_1.seq
	var_0_6 = arg_16_1.question
	seed_ = arg_16_1.send

	manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_QUESTION_REFRESH)
end

function var_0_1.OnQuestionResult(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	var_0_2 = 4
	var_0_4 = arg_17_3.timestamp

	for iter_17_0, iter_17_1 in pairs(arg_17_2) do
		var_0_3[iter_17_0].score = iter_17_1.score
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_1) do
		if iter_17_3.uid == USER_ID then
			var_0_8 = iter_17_3.history[#iter_17_3.history].is_right
			curChoose_ = iter_17_3.history[#iter_17_3.history].choose
		end
	end

	manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_ANSWER_REFRESH)
end

function var_0_1.OnEndGame(arg_18_0, arg_18_1)
	var_0_2 = 5

	manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_FINISH_GAME)
end

function var_0_1:ShowModels(arg_19_1, arg_19_2)
	GameObject.Find("vfx_scene").gameObject:SetActive(false)

	local var_19_0 = GameObject.Find("GameEndObjs").transform:Find("VCam_GameEnd")

	if not isNil(var_19_0) then
		var_19_0.gameObject:SetActive(true)
		manager.ui.mainCamera:GetComponent("CinemachineBrain"):ManualUpdate()
	end

	local var_19_1 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		table.insert(var_19_1, (var_0_0:FindByPlayerId(iter_19_1)))
	end

	local var_19_2 = self:Cfg_GetPigModelId()

	for iter_19_2, iter_19_3 in ipairs(var_19_1) do
		local var_19_3 = GameObject.Find("GameEndObjs/pos" .. iter_19_2)

		if not isNil(var_19_3) then
			local var_19_5 = Asset.Instantiate("CharDorm/quiz/" .. ((iter_19_3.curRoleId == var_19_2 or nil) and iter_19_3.lastRoleId) .. "_tpose")

			var_19_5.transform:SetPositionAndRotation(var_19_3.transform.position, var_19_3.transform.rotation)
			var_19_5:GetComponent(typeof(Animator)):CrossFade(Animator.StringToHash("pose"), 0.1)
			self:CreateResultNameUI(var_19_3.transform.position + Vector3.up * 1.2, iter_19_3.nickName, arg_19_2[iter_19_2], iter_19_3.isLocalPlayer)
		end
	end

	for iter_19_4 = 0, var_0_0.PlayerList.Count - 1 do
		var_0_0.PlayerList[iter_19_4]:DestroyPlayerRoot()
	end
end

function var_0_1.OnModelChanged(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_CHANGE_HERO)
end

function var_0_1.OnPlayerRemoved(arg_21_0, arg_21_1)
	local var_21_0 = table.indexof(var_0_3.all, arg_21_1)

	if var_21_0 then
		table.remove(var_0_3.all, var_21_0)

		var_0_3[arg_21_1] = nil
	end

	manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_QUIT_PLAYER)
end

function var_0_1.CreateQNickName(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = var_0_0:FindByPlayerId(arg_22_1):CreateNickName(ActivityQuizTools.GetActivityRoleNamePrefab((ActivityQuizTools.GetCurActivityID())), arg_22_2)

	var_22_0.transform:SetSiblingIndex(0)

	if not isNil(var_22_0) then
		local var_22_1 = ControllerUtil.GetController(var_22_0.transform, "name")

		if arg_22_3 then
			var_22_1:SetSelectedState("me", true)
		else
			var_22_1:SetSelectedState("other", true)
		end
	end
end

function var_0_1:CreateResultNameUI(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = Asset.Instantiate(ActivityQuizTools.GetActivityRoleRankedNamePrefab((ActivityQuizTools.GetCurActivityID())))

	var_23_0.transform:SetParent(manager.ui.canvas.transform, false)

	var_23_0.transform:Find("nametext"):GetComponent(typeof(Text)).text = arg_23_2

	var_23_0.transform:SetSiblingIndex(0)

	var_23_0.transform.localPosition = self:ConvertWorldToUIPos(arg_23_1)
	var_23_0.transform.localScale = Vector3.one

	local var_23_1 = ControllerUtil.GetController(var_23_0.transform, "name")

	if arg_23_4 then
		var_23_1:SetSelectedState("me", true)
	else
		var_23_1:SetSelectedState("other", true)
	end

	ControllerUtil.GetController(var_23_0.transform, "rank"):SetSelectedState(arg_23_3, true)
end

function var_0_1.ConvertWorldToUIPos(arg_24_0, arg_24_1)
	local var_24_0, var_24_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(manager.ui.canvas.transform, UnityEngine.Camera.main:WorldToScreenPoint(arg_24_1), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, nil)

	if var_24_1 == nil then
		print("未找到对应的视口坐标")
	end

	return var_24_1
end

function var_0_1.CreatePlayerShadow(arg_25_0, arg_25_1)
	local var_25_0 = Asset.Instantiate("Effect/Battle/HeroIndicatorBase")

	var_25_0.transform:SetParent(var_0_0:FindByPlayerId(arg_25_1):GetPlayerModelGo().transform.parent)

	var_25_0.transform.localPosition = Vector3.up * 0.05
	var_25_0.transform.localScale = Vector3.one * 0.6
end

function var_0_1.GetSyncPosInterval(arg_26_0)
	return 0.125
end

function var_0_1.InitData(arg_27_0)
	var_0_2 = 0
	var_0_3 = {}
	var_0_3.all = {}
	var_0_4 = 0
	curHeroID_ = 0
	curChoose_ = 0
	var_0_5 = 0
	var_0_6 = 0
	seed_ = 0
	var_0_8 = 1
end

function var_0_1.GetCurStateEndTime(arg_28_0)
	return var_0_4
end

function var_0_1.GetPlayerList(arg_29_0)
	return var_0_3.all
end

function var_0_1.GetRankData(arg_30_0, arg_30_1)
	return var_0_3[arg_30_1]
end

function var_0_1.GetCurQuizID(arg_31_0)
	return var_0_6
end

function var_0_1.GetCurQuizIndex(arg_32_0)
	return var_0_5
end

function var_0_1.GetCurResult(arg_33_0)
	return var_0_8
end

function var_0_1.GetState(arg_34_0)
	return var_0_2
end

function var_0_1.GetCurChoose(arg_35_0)
	return curChoose_
end

function var_0_1.SetCurChoose(arg_36_0, arg_36_1)
	curChoose_ = arg_36_1

	manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_CHOOSE_CHANGE, arg_36_1)
end

function var_0_1.SetCurHeroID(arg_37_0, arg_37_1)
	curHeroID_ = arg_37_1
end

function var_0_1.GetCurHeroID(arg_38_0)
	return curHeroID_
end

function var_0_1.GetPlyerModel(arg_39_0, arg_39_1)
	return var_0_0:FindByPlayerId(arg_39_1)
end

function var_0_1.ResetRandSeed(arg_40_0, arg_40_1)
	var_0_9 = arg_40_1

	DRandom.ResetSeed(arg_40_1)
end

function var_0_1.SetRandList(arg_41_0, arg_41_1)
	var_0_10 = {}

	for iter_41_0 = 1, arg_41_1 do
		table.insert(var_0_10, iter_41_0)
	end

	for iter_41_1 = arg_41_1, 2, -1 do
		table.insert(var_0_10, (table.remove(var_0_10, DRandom.Random(iter_41_1) + 1)))
	end
end

function var_0_1.GetAnsList(arg_42_0)
	return var_0_10
end

function var_0_1.GetRandSeed(arg_43_0)
	return seed_
end

function var_0_1:CreateVfx_AnswerRight(arg_44_1)
	self:CreateVfx(arg_44_1, "Dorm/Effect/houzhai/fx_chunjie_yanhua", 1)
end

function var_0_1:CreateVfx_AnswerError(arg_45_1)
	self:CreateVfx(arg_45_1, "Dorm/Effect/houzhai/fx_chunjie_smk", 1)
end

function var_0_1.CreateVfx(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = Asset.Instantiate(arg_46_2)

	var_46_0.transform:SetParent(var_0_0:FindByPlayerId(arg_46_1):GetPlayerModelGo().transform)

	var_46_0.transform.localPosition = Vector3.zero
	var_46_0.transform.localScale = Vector3.one

	PooledAsset.DestroyOrReturn(var_46_0, arg_46_3)
end

return var_0_1
