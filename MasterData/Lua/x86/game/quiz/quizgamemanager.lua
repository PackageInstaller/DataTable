local var_0_0 = singletonClass("QuizGameManager")
local QuizFunction = import("game.quiz.QuizFunction")
local var_0_3 = UnityEngine.Time
local var_0_4 = P08.Quiz.QuizPlayerInfo
local var_0_5 = P08.Quiz.PlayerManager.Instance

function var_0_0:Init()
	self.questionResultDic = {}
	self.gestureCd = QuizFunction:Cfg_GetGestureCd()
	self.gestureTs = 0
	self.emojiCd = QuizFunction:Cfg_GetEmojiCd()
	self.emojiTs = 0
	self.pos_divide = 100
	self.syncPosInterval = QuizFunction:GetSyncPosInterval()
	self.syncPosTimer = 0
	self.localPlayerId = USER_ID

	self:RegsiterModelChange()
	self:RegisterGestureChanged()
end

function var_0_0:StartGame(arg_2_1, arg_2_2)
	QuizFunction:OnGameStart(arg_2_1)
	self:AddPlayers(arg_2_2)

	self._timer = FrameTimer.New(handler(self, self.Update), 1, -1)

	self._timer:Start()
end

function var_0_0.InitSticker(arg_3_0, arg_3_1)
	P08.Quiz.QuizLuaBridge.InitJoystick(arg_3_1)
end

function var_0_0:Destroy()
	if self._timer then
		self._timer:Stop()

		self._timer = nil
	end

	self:UnregisterModelChange()
	self:UnregisterGestureChanged()
end

function var_0_0:Update()
	self:SyncLocalPlayerPosInterval()
end

function var_0_0:AddPlayers(arg_6_1)
	local var_6_0 = QuizFunction:Cfg_GetDefaultModelId()

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		self:LoadPlayer(iter_6_1.uid, (iter_6_1.role_id ~= 0 or nil) and iter_6_1.role_id, iter_6_1.nickname)
	end

	QuizFunction:AddPlayers(arg_6_1)
	self:RandomInitPos(arg_6_1)
end

function var_0_0:RemovePlayers(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		self:RemovePlayer(iter_7_1)
		self:RemoveQuestionResult(iter_7_1)
	end
end

function var_0_0.OnShowPrologue(arg_8_0, arg_8_1)
	QuizFunction:OnShowPrologue(arg_8_1)
end

function var_0_0.OnShowQuestion(arg_9_0, arg_9_1)
	QuizFunction:ShowQuestion(arg_9_1)
end

function var_0_0:OnQuestionResult(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1.player_list) do
		if iter_10_1.history[arg_10_1.seq] == nil then
			Debug.LogError("===> OnQuestionResult error: questionSeq=" .. arg_10_1.seq .. "  player.history.length=" .. #iter_10_1.history)

			return
		end

		if self.questionResultDic[iter_10_1.uid] == nil then
			self.questionResultDic[iter_10_1.uid] = {
				score = 0,
				correctCounter = 0,
				seq = 0,
				errorCounter = 0
			}
		end

		local var_10_2 = self.questionResultDic[iter_10_1.uid]

		var_10_2.seq = arg_10_1.seq

		local var_10_3 = QuizFunction:Cfg_GetSeqOfScoreBonus()

		if arg_10_1.seq == var_10_3 then
			QuizFunction:ShowScoreBonusEffect()
		end

		if iter_10_1.history[arg_10_1.seq].is_right == 1 then
			local var_10_4 = QuizFunction:Cfg_GetScore(arg_10_1.question)

			if var_10_3 <= arg_10_1.seq then
				var_10_4 = var_10_4 * QuizFunction:Cfg_GetScoreMulti()
			end

			var_10_2.score = var_10_2.score + var_10_4 + ((var_10_2.correctCounter > 0 or nil) and (GameSetting.combo_reward.value[var_10_2.correctCounter] or GameSetting.combo_reward.value[#GameSetting.combo_reward.value]))
			var_10_2.correctCounter = var_10_2.correctCounter + 1

			if var_10_2.errorCounter ~= 0 then
				var_10_2.errorCounter = 0

				self:RestoreLastModel(iter_10_1.uid)
				self:ScalePlayerModel(iter_10_1.uid, 1)
			end

			QuizFunction:CreateVfx_AnswerRight(iter_10_1.uid)
		else
			var_10_2.correctCounter = 0
			var_10_2.errorCounter = var_10_2.errorCounter + 1

			self:ChangePlayerModel(iter_10_1.uid, QuizFunction:Cfg_GetPigModelId())
			self:ScalePlayerModel(iter_10_1.uid, (math.min(QuizFunction:Cfg_GetMaxModelScale(), 1 + (var_10_2.errorCounter - 1) * QuizFunction:Cfg_GetModelScaleMulti())))
			QuizFunction:CreateVfx_AnswerError(iter_10_1.uid)
		end
	end

	QuizFunction:OnQuestionResult(arg_10_1.player_list, self.questionResultDic, arg_10_1)
end

function var_0_0.OnGameEnd(arg_11_0, arg_11_1)
	arg_11_0.syncPosInterval = 99999

	QuizFunction:OnEndGame(arg_11_1)
end

function var_0_0:SyncRemoteRole(arg_12_1, arg_12_2)
	self:ChangePlayerModel(arg_12_1, arg_12_2)
end

function var_0_0:SyncLocalPlayerPosInterval()
	if self.syncPosTimer <= 0 then
		self.syncPosTimer = self.syncPosInterval

		self:SyncLocalPlayerPos()
	else
		self.syncPosTimer = self.syncPosTimer - var_0_3.deltaTime
	end
end

function var_0_0:SyncLocalPlayerPos()
	if isNil(var_0_5.LocalPlayer) then
		Debug.LogError("[Quiz] PlayerManager.LocalPlayer is nil")

		return
	end

	local var_14_0 = var_0_5.LocalPlayer:GetLocalPlayerPos()
	local var_14_1 = var_0_5.LocalPlayer:GetChoose()
	local var_14_2

	if QuizFunction:GetState() == 3 then
		QuizFunction:SetCurChoose(var_14_1)

		var_14_2 = QuizFunction:GetAnsList()[var_14_1] or 1
	end

	ActivityQuizAction.PushPosition(math.floor(var_14_0.x * self.pos_divide), math.floor(var_14_0.y * self.pos_divide), var_14_2)
end

function var_0_0:SyncRemotePlayerPosList(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		var_0_5:SetRemotePlayerPos(iter_15_1.uid, iter_15_1.pos.x / self.pos_divide, iter_15_1.pos.z / self.pos_divide)
	end
end

function var_0_0:SyncRemotePlayerPos(arg_16_1, arg_16_2)
	var_0_5:SetRemotePlayerPos(arg_16_1, arg_16_2.x / self.pos_divide, arg_16_2.z / self.pos_divide)
end

function var_0_0.RandomInitPos(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		DRandom.ResetSeed(iter_17_1.seed)
		var_0_5:FindByPlayerId(iter_17_1.uid):SetPlayerPosForce(Vector2.New(DRandom.Random(100) / 100 * 10 - 10 * 0.5, DRandom.Random(100) / 100 * 6 - 6 * 0.5), Quaternion.identity)
	end
end

function var_0_0:PlayLocalGesture(arg_18_1)
	local var_18_0 = manager.time:GetServerTime()

	if var_18_0 < self.gestureTs then
		return
	end

	self.gestureTs = var_18_0 + self.gestureCd

	local var_18_1 = UnityEngine.Animator.StringToHash(arg_18_1)

	var_0_5.LocalPlayer:PlayLocalGesture(var_18_1)
	manager.net:Push(77110, {
		gesture_id = var_18_1
	})
end

function var_0_0.SyncRemoteGesture(arg_19_0, arg_19_1, arg_19_2)
	var_0_5:FindByPlayerId(arg_19_1):SyncRemoteGesture(arg_19_2, 0.05)
end

function var_0_0:PlayLocalEmoji(arg_20_1)
	local var_20_0 = manager.time:GetServerTime()

	if var_20_0 < self.emojiTs then
		return
	end

	self.emojiTs = var_20_0 + self.emojiCd

	QuizFunction:PlayEmoji(self.localPlayerId, arg_20_1)
	manager.net:Push(77112, {
		emoji_id = arg_20_1
	})
end

function var_0_0.SyncRemoteEmoji(arg_21_0, arg_21_1, arg_21_2)
	QuizFunction:PlayEmoji(arg_21_1, arg_21_2)
end

function var_0_0:GetRemainGestureCd()
	return math.max(0, self.gestureTs - manager.time:GetServerTime())
end

function var_0_0:GetRemainEmojiCd()
	return math.max(0, self.emojiTs - manager.time:GetServerTime())
end

function var_0_0:LoadPlayer(arg_24_1, arg_24_2, arg_24_3)
	if self.localPlayerId == arg_24_1 then
		self:LoadPlayerInternal(arg_24_1, arg_24_2, arg_24_3, true)
	else
		self:LoadPlayerInternal(arg_24_1, arg_24_2, arg_24_3, false)
	end
end

function var_0_0.LoadPlayerInternal(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = var_0_4()

	var_25_0.playerUid = arg_25_1
	var_25_0.roleId = arg_25_2
	var_25_0.nickName = arg_25_3

	if arg_25_4 == true then
		var_0_5:AddLocalPlayer(var_25_0)
		QuizFunction:CreateQNickName(arg_25_1, arg_25_3, true)
		QuizFunction:CreatePlayerShadow(arg_25_1)
	else
		var_0_5:AddRemotePlayer(var_25_0)
		QuizFunction:CreateQNickName(arg_25_1, arg_25_3, false)
	end
end

function var_0_0.RemovePlayer(arg_26_0, arg_26_1)
	var_0_5:RemovePlayerById(arg_26_1)
	QuizFunction:OnPlayerRemoved(arg_26_1)
end

function var_0_0:RemoveQuestionResult(arg_27_1)
	for iter_27_0, iter_27_1 in pairs(self.questionResultDic) do
		if iter_27_0 == arg_27_1 then
			self.questionResultDic[iter_27_0] = nil
		end
	end
end

function var_0_0:ChangeLocalPlayerModel(arg_28_1)
	self:ChangePlayerModel(self.localPlayerId, arg_28_1)
	manager.net:Push(77106, {
		role_id = arg_28_1
	})
end

function var_0_0:ChangePlayerModel(arg_29_1, arg_29_2)
	var_0_5:ChangeModel(arg_29_1, arg_29_2)

	if self.localPlayerId == arg_29_1 then
		QuizFunction:SetCurHeroID(arg_29_2)
	end
end

function var_0_0.ScalePlayerModel(arg_30_0, arg_30_1, arg_30_2)
	var_0_5:ScaleModel(arg_30_1, arg_30_2)
end

function var_0_0.RestoreLastModel(arg_31_0, arg_31_1)
	var_0_5:RestoreLastModel(arg_31_1)
end

function var_0_0:RegsiterModelChange()
	P08.Quiz.QuizLuaBridge.OnQuizPlayerModelChanged = isNil(P08.Quiz.QuizLuaBridge.OnQuizPlayerModelChanged) and handler(self, self.OnModelChanged) or P08.Quiz.QuizLuaBridge.OnQuizPlayerModelChanged + handler(self, self.OnModelChanged)
end

function var_0_0.UnregisterModelChange(arg_33_0)
	P08.Quiz.QuizLuaBridge.OnQuizPlayerModelChanged = nil
end

function var_0_0.OnModelChanged(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	QuizFunction:OnModelChanged(tostring(arg_34_1), arg_34_2, arg_34_3)
end

function var_0_0:RegisterGestureChanged()
	P08.Quiz.QuizLuaBridge.OnQuizPlayerGestureChanged = isNil(P08.Quiz.QuizLuaBridge.OnQuizPlayerGestureChanged) and handler(self, self.OnGestureChanged) or P08.Quiz.QuizLuaBridge.OnQuizPlayerGestureChanged + handler(self, self.OnGestureChanged)
end

function var_0_0.UnregisterGestureChanged(arg_36_0)
	P08.Quiz.QuizLuaBridge.OnQuizPlayerGestureChanged = nil
end

function var_0_0:OnGestureChanged(arg_37_1, arg_37_2)
	if tostring(arg_37_1) ~= self.localPlayerId then
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
