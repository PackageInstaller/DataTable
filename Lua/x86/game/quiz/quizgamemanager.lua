local var_0_0 = singletonClass("QuizGameManager")
local var_0_1 = import("game.quiz.QuizFunction")
local var_0_2 = UnityEngine.Input
local var_0_3 = UnityEngine.Time
local var_0_4 = P08.Quiz.QuizPlayerInfo
local var_0_5 = P08.Quiz.PlayerManager.Instance

function var_0_0.Init(arg_1_0)
	arg_1_0.questionResultDic = {}
	arg_1_0.gestureCd = var_0_1:Cfg_GetGestureCd()
	arg_1_0.gestureTs = 0
	arg_1_0.emojiCd = var_0_1:Cfg_GetEmojiCd()
	arg_1_0.emojiTs = 0
	arg_1_0.pos_divide = 100
	arg_1_0.syncPosInterval = var_0_1:GetSyncPosInterval()
	arg_1_0.syncPosTimer = 0
	arg_1_0.localPlayerId = USER_ID

	arg_1_0:RegsiterModelChange()
	arg_1_0:RegisterGestureChanged()
end

function var_0_0.StartGame(arg_2_0, arg_2_1, arg_2_2)
	var_0_1:OnGameStart(arg_2_1)
	arg_2_0:AddPlayers(arg_2_2)

	arg_2_0._timer = FrameTimer.New(handler(arg_2_0, arg_2_0.Update), 1, -1)

	arg_2_0._timer:Start()
end

function var_0_0.InitSticker(arg_3_0, arg_3_1)
	P08.Quiz.QuizLuaBridge.InitJoystick(arg_3_1)
end

function var_0_0.Destroy(arg_4_0)
	if arg_4_0._timer then
		arg_4_0._timer:Stop()

		arg_4_0._timer = nil
	end

	arg_4_0:UnregisterModelChange()
	arg_4_0:UnregisterGestureChanged()
end

function var_0_0.Update(arg_5_0)
	arg_5_0:SyncLocalPlayerPosInterval()
end

function var_0_0.AddPlayers(arg_6_0, arg_6_1)
	local var_6_0 = var_0_1:Cfg_GetDefaultModelId()

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		if iter_6_1.role_id ~= 0 then
			var_6_0 = iter_6_1.role_id
		end

		arg_6_0:LoadPlayer(iter_6_1.uid, var_6_0, iter_6_1.nickname)
	end

	var_0_1:AddPlayers(arg_6_1)
	arg_6_0:RandomInitPos(arg_6_1)
end

function var_0_0.RemovePlayers(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		arg_7_0:RemovePlayer(iter_7_1)
		arg_7_0:RemoveQuestionResult(iter_7_1)
	end
end

function var_0_0.OnShowPrologue(arg_8_0, arg_8_1)
	var_0_1:OnShowPrologue(arg_8_1)
end

function var_0_0.OnShowQuestion(arg_9_0, arg_9_1)
	var_0_1:ShowQuestion(arg_9_1)
end

function var_0_0.OnQuestionResult(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.player_list
	local var_10_1 = arg_10_1.seq
	local var_10_2 = arg_10_1.question
	local var_10_3 = arg_10_1.answer

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_4 = iter_10_1.uid
		local var_10_5 = iter_10_1.pos.choose
		local var_10_6 = iter_10_1.history[var_10_1]

		if var_10_6 == nil then
			Debug.LogError("===> OnQuestionResult error: questionSeq=" .. var_10_1 .. "  player.history.length=" .. #iter_10_1.history)

			return
		end

		if arg_10_0.questionResultDic[var_10_4] == nil then
			arg_10_0.questionResultDic[var_10_4] = {
				score = 0,
				correctCounter = 0,
				seq = 0,
				errorCounter = 0
			}
		end

		local var_10_7 = arg_10_0.questionResultDic[var_10_4]

		var_10_7.seq = var_10_1

		local var_10_8 = var_0_1:Cfg_GetSeqOfScoreBonus()

		if var_10_1 == var_10_8 then
			var_0_1:ShowScoreBonusEffect()
		end

		if var_10_6.is_right == 1 then
			local var_10_9 = var_0_1:Cfg_GetScore(var_10_2)

			if var_10_8 <= var_10_1 then
				var_10_9 = var_10_9 * var_0_1:Cfg_GetScoreMulti()
			end

			local var_10_10 = 0

			if var_10_7.correctCounter > 0 then
				local var_10_11 = GameSetting.combo_reward.value

				var_10_10 = var_10_11[var_10_7.correctCounter] or var_10_11[#var_10_11]
			end

			var_10_7.score = var_10_7.score + var_10_9 + var_10_10
			var_10_7.correctCounter = var_10_7.correctCounter + 1

			if var_10_7.errorCounter ~= 0 then
				var_10_7.errorCounter = 0

				arg_10_0:RestoreLastModel(var_10_4)
				arg_10_0:ScalePlayerModel(var_10_4, 1)
			end

			var_0_1:CreateVfx_AnswerRight(var_10_4)
		else
			var_10_7.correctCounter = 0
			var_10_7.errorCounter = var_10_7.errorCounter + 1

			arg_10_0:ChangePlayerModel(var_10_4, var_0_1:Cfg_GetPigModelId())

			local var_10_12 = math.min(var_0_1:Cfg_GetMaxModelScale(), 1 + (var_10_7.errorCounter - 1) * var_0_1:Cfg_GetModelScaleMulti())

			arg_10_0:ScalePlayerModel(var_10_4, var_10_12)
			var_0_1:CreateVfx_AnswerError(var_10_4)
		end
	end

	var_0_1:OnQuestionResult(var_10_0, arg_10_0.questionResultDic, arg_10_1)
end

function var_0_0.OnGameEnd(arg_11_0, arg_11_1)
	arg_11_0.syncPosInterval = 99999

	var_0_1:OnEndGame(arg_11_1)
end

function var_0_0.SyncRemoteRole(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:ChangePlayerModel(arg_12_1, arg_12_2)
end

function var_0_0.SyncLocalPlayerPosInterval(arg_13_0)
	if arg_13_0.syncPosTimer <= 0 then
		arg_13_0.syncPosTimer = arg_13_0.syncPosInterval

		arg_13_0:SyncLocalPlayerPos()
	else
		arg_13_0.syncPosTimer = arg_13_0.syncPosTimer - var_0_3.deltaTime
	end
end

function var_0_0.SyncLocalPlayerPos(arg_14_0)
	if isNil(var_0_5.LocalPlayer) then
		Debug.LogError("[Quiz] PlayerManager.LocalPlayer is nil")

		return
	end

	local var_14_0 = var_0_5.LocalPlayer:GetLocalPlayerPos()
	local var_14_1 = var_0_5.LocalPlayer:GetChoose()

	if var_0_1:GetState() == 3 then
		var_0_1:SetCurChoose(var_14_1)
	end

	local var_14_2 = math.floor(var_14_0.x * arg_14_0.pos_divide)
	local var_14_3 = math.floor(var_14_0.y * arg_14_0.pos_divide)
	local var_14_4 = var_0_1:GetAnsList()[var_14_1] or 1

	ActivityQuizAction.PushPosition(var_14_2, var_14_3, var_14_4)
end

function var_0_0.SyncRemotePlayerPosList(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_0 = iter_15_1.uid
		local var_15_1 = iter_15_1.pos
		local var_15_2 = var_15_1.x / arg_15_0.pos_divide
		local var_15_3 = var_15_1.z / arg_15_0.pos_divide

		var_0_5:SetRemotePlayerPos(var_15_0, var_15_2, var_15_3)
	end
end

function var_0_0.SyncRemotePlayerPos(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2.x / arg_16_0.pos_divide
	local var_16_1 = arg_16_2.z / arg_16_0.pos_divide

	var_0_5:SetRemotePlayerPos(arg_16_1, var_16_0, var_16_1)
end

function var_0_0.RandomInitPos(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		local var_17_0 = iter_17_1.uid
		local var_17_1 = iter_17_1.seed

		DRandom.ResetSeed(var_17_1)

		local var_17_2 = DRandom.Random(100) / 100
		local var_17_3 = DRandom.Random(100) / 100
		local var_17_4 = 10
		local var_17_5 = 6
		local var_17_6 = var_17_2 * var_17_4 - var_17_4 * 0.5
		local var_17_7 = var_17_3 * var_17_5 - var_17_5 * 0.5

		var_0_5:FindByPlayerId(var_17_0):SetPlayerPosForce(Vector2.New(var_17_6, var_17_7), Quaternion.identity)
	end
end

function var_0_0.PlayLocalGesture(arg_18_0, arg_18_1)
	local var_18_0 = manager.time:GetServerTime()

	if var_18_0 < arg_18_0.gestureTs then
		return
	end

	arg_18_0.gestureTs = var_18_0 + arg_18_0.gestureCd

	local var_18_1 = UnityEngine.Animator.StringToHash(arg_18_1)

	var_0_5.LocalPlayer:PlayLocalGesture(var_18_1)
	manager.net:Push(77110, {
		gesture_id = var_18_1
	})
end

function var_0_0.SyncRemoteGesture(arg_19_0, arg_19_1, arg_19_2)
	var_0_5:FindByPlayerId(arg_19_1):SyncRemoteGesture(arg_19_2, 0.05)
end

function var_0_0.PlayLocalEmoji(arg_20_0, arg_20_1)
	local var_20_0 = manager.time:GetServerTime()

	if var_20_0 < arg_20_0.emojiTs then
		return
	end

	arg_20_0.emojiTs = var_20_0 + arg_20_0.emojiCd

	var_0_1:PlayEmoji(arg_20_0.localPlayerId, arg_20_1)
	manager.net:Push(77112, {
		emoji_id = arg_20_1
	})
end

function var_0_0.SyncRemoteEmoji(arg_21_0, arg_21_1, arg_21_2)
	var_0_1:PlayEmoji(arg_21_1, arg_21_2)
end

function var_0_0.GetRemainGestureCd(arg_22_0)
	local var_22_0 = manager.time:GetServerTime()

	return math.max(0, arg_22_0.gestureTs - var_22_0)
end

function var_0_0.GetRemainEmojiCd(arg_23_0)
	local var_23_0 = manager.time:GetServerTime()

	return math.max(0, arg_23_0.emojiTs - var_23_0)
end

function var_0_0.LoadPlayer(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_0.localPlayerId == arg_24_1 then
		arg_24_0:LoadPlayerInternal(arg_24_1, arg_24_2, arg_24_3, true)
	else
		arg_24_0:LoadPlayerInternal(arg_24_1, arg_24_2, arg_24_3, false)
	end
end

function var_0_0.LoadPlayerInternal(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = var_0_4()

	var_25_0.playerUid = arg_25_1
	var_25_0.roleId = arg_25_2
	var_25_0.nickName = arg_25_3

	if arg_25_4 == true then
		var_0_5:AddLocalPlayer(var_25_0)
		var_0_1:CreateQNickName(arg_25_1, arg_25_3, true)
		var_0_1:CreatePlayerShadow(arg_25_1)
	else
		var_0_5:AddRemotePlayer(var_25_0)
		var_0_1:CreateQNickName(arg_25_1, arg_25_3, false)
	end
end

function var_0_0.RemovePlayer(arg_26_0, arg_26_1)
	var_0_5:RemovePlayerById(arg_26_1)
	var_0_1:OnPlayerRemoved(arg_26_1)
end

function var_0_0.RemoveQuestionResult(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.questionResultDic) do
		if iter_27_0 == arg_27_1 then
			arg_27_0.questionResultDic[iter_27_0] = nil
		end
	end
end

function var_0_0.ChangeLocalPlayerModel(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.localPlayerId

	arg_28_0:ChangePlayerModel(var_28_0, arg_28_1)
	manager.net:Push(77106, {
		role_id = arg_28_1
	})
end

function var_0_0.ChangePlayerModel(arg_29_0, arg_29_1, arg_29_2)
	var_0_5:ChangeModel(arg_29_1, arg_29_2)

	if arg_29_0.localPlayerId == arg_29_1 then
		var_0_1:SetCurHeroID(arg_29_2)
	end
end

function var_0_0.ScalePlayerModel(arg_30_0, arg_30_1, arg_30_2)
	var_0_5:ScaleModel(arg_30_1, arg_30_2)
end

function var_0_0.RestoreLastModel(arg_31_0, arg_31_1)
	var_0_5:RestoreLastModel(arg_31_1)
end

function var_0_0.RegsiterModelChange(arg_32_0)
	local var_32_0 = P08.Quiz.QuizLuaBridge

	if isNil(var_32_0.OnQuizPlayerModelChanged) then
		var_32_0.OnQuizPlayerModelChanged = handler(arg_32_0, arg_32_0.OnModelChanged)
	else
		var_32_0.OnQuizPlayerModelChanged = var_32_0.OnQuizPlayerModelChanged + handler(arg_32_0, arg_32_0.OnModelChanged)
	end
end

function var_0_0.UnregisterModelChange(arg_33_0)
	P08.Quiz.QuizLuaBridge.OnQuizPlayerModelChanged = nil
end

function var_0_0.OnModelChanged(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = tostring(arg_34_1)

	var_0_1:OnModelChanged(var_34_0, arg_34_2, arg_34_3)
end

function var_0_0.RegisterGestureChanged(arg_35_0)
	local var_35_0 = P08.Quiz.QuizLuaBridge

	if isNil(var_35_0.OnQuizPlayerGestureChanged) then
		var_35_0.OnQuizPlayerGestureChanged = handler(arg_35_0, arg_35_0.OnGestureChanged)
	else
		var_35_0.OnQuizPlayerGestureChanged = var_35_0.OnQuizPlayerGestureChanged + handler(arg_35_0, arg_35_0.OnGestureChanged)
	end
end

function var_0_0.UnregisterGestureChanged(arg_36_0)
	P08.Quiz.QuizLuaBridge.OnQuizPlayerGestureChanged = nil
end

function var_0_0.OnGestureChanged(arg_37_0, arg_37_1, arg_37_2)
	if tostring(arg_37_1) ~= arg_37_0.localPlayerId then
		return
	end

	if arg_37_2 == -1 then
		manager.net:Push(77110, {
			gesture_id = -1
		})
	end
end

function var_0_0.IsMultiPlayer(arg_38_0)
	return var_0_5.PlayerList.Count > 1
end

return var_0_0
