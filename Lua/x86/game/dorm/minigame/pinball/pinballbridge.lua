return {
	Enter = function(arg_1_0, arg_1_1, arg_1_2)
		function arg_1_0.callback_()
			local var_2_0 = GameObject.Find("HomeBackGroundRoot").transform
			local var_2_1 = PinballTools.GetCurrentSceneBgPrefabPath(PinballData:GetLastEnterStageCategory())

			if var_2_1 then
				if var_2_0.childCount > 0 then
					GameObject.DestroyImmediate(var_2_0:GetChild(0).gameObject)
				end

				GameObject.Instantiate(Asset.Load(var_2_1), var_2_0).name = "PinballHomeBg"

				local var_2_2 = GameObject.Find("HomeBackParticlePos").transform
				local var_2_3 = GameObject.Find("HomeBackGroundRoot/PinballHomeBg/root/particle").transform

				var_2_3.localPosition = Vector3.New(var_2_2.position.x, var_2_2.position.y, var_2_2.position.z)
				var_2_3.localScale = Vector3.New(var_2_2.localScale.x, var_2_2.localScale.y, var_2_2.localScale.z)
			end

			SetActive(var_2_0.gameObject, true)
			JumpTools.OpenPageByJump("/hellPinballHomeView", arg_1_2)

			arg_1_0.hasSceneLoaded = true

			manager.ui:SetMainCamera("pinballHome")
			arg_1_0:CameraAdaptive()

			local var_2_4 = GameObject.Find("BackGroundRoot/PinballBg")

			if var_2_4 then
				var_2_4.gameObject:SetActive(false)
			end
		end

		local var_1_0 = SceneManager.GetSceneByName("PinballGame")

		if not var_1_0 or not var_1_0.isLoaded then
			arg_1_0.operation_ = Asset.LoadLevelAsync("Levels/PinballGame", true)
			arg_1_0.timer_ = FrameTimer.New(handler(arg_1_0, arg_1_0.Process), 1, -1)

			arg_1_0.timer_:Start()
			manager.windowBar:SetWhereTag("minigame")
		elseif arg_1_0.callback_ then
			arg_1_0.callback_()
		end

		manager.gc:Collect()
	end,
	UnLoadScene = function(arg_3_0)
		if arg_3_0.operation_ then
			return
		end

		local var_3_0 = SceneManager.GetSceneByName("PinballGame")

		if var_3_0 and var_3_0.isLoaded == true then
			whereami = "home"
			arg_3_0.exoperation_ = SceneManager.UnloadSceneAsync("PinballGame")

			if arg_3_0.extimer_ then
				arg_3_0.extimer_:Stop()

				arg_3_0.extimer_ = nil
			end

			arg_3_0.extimer_ = FrameTimer.New(handler(arg_3_0, arg_3_0.exProcess), 1, -1)

			arg_3_0.extimer_:Start()
		end
	end,
	exProcess = function(arg_4_0)
		if not arg_4_0.exoperation_ or arg_4_0.exoperation_.isDone then
			Asset.Unload("Levels/PinballGame")

			local var_4_0 = SceneManager.GetSceneByName("X100")

			if not var_4_0 or not var_4_0.isLoaded then
				Asset.LoadLevelAsync("Levels/X100", true)
			end

			manager.gc:Collect()

			arg_4_0.hasSceneLoaded = false

			if arg_4_0.extimer_ then
				arg_4_0.extimer_:Stop()

				arg_4_0.extimer_ = nil
			end
		end
	end,
	EnterPlay = function(arg_5_0)
		function arg_5_0.callback_()
			if Pinball.PinballGameManager.Instance then
				Pinball.PinballGameManager.Instance.GMDoubleSpeed = getData("PinballGame", "doubleSpeed") or false
			end

			OpenPageUntilLoaded("/pinballTurnBasedGame")
			manager.ui:SetMainCamera("pinball")

			local var_6_0 = PinballTools.GetCurrentSceneBgPrefabPath(PinballAction.PlayingStageID, true)
			local var_6_1 = GameObject.Find("BackGroundRoot").transform

			var_6_1.gameObject:SetActive(true)

			if var_6_0 then
				if var_6_1.childCount > 0 then
					GameObject.DestroyImmediate(var_6_1:GetChild(0).gameObject)
				end

				GameObject.Instantiate(Asset.Load(var_6_0), var_6_1).name = "PinballBg"

				local var_6_2 = GameObject.Find("BackGroundRoot/PinballHomeBg/root/pre")
				local var_6_3 = GameObject.Find("BackGroundRoot/PinballHomeBg/root/next")

				if var_6_2 and var_6_3 then
					var_6_2:GetComponent("SpriteRenderer").sprite = var_6_3:GetComponent("SpriteRenderer").sprite
				end

				local var_6_4 = GameObject.Find("BackGroundParticlePos").transform
				local var_6_5 = GameObject.Find("BackGroundRoot/PinballBg/root/particle").transform

				var_6_5.localPosition = Vector3.New(var_6_4.position.x, var_6_4.position.y, var_6_4.position.z)
				var_6_5.localScale = Vector3.New(var_6_4.localScale.x, var_6_4.localScale.y, var_6_4.localScale.z)

				local var_6_6 = GameObject.Find("HomeBackGroundRoot/PinballHomeBg")

				if var_6_6 then
					var_6_6.gameObject:SetActive(false)
				end
			end

			arg_5_0:CameraAdaptive()
		end

		local var_5_0 = SceneManager.GetSceneByName("PinballGame")

		if not var_5_0 or not var_5_0.isLoaded then
			arg_5_0.operation_ = Asset.LoadLevelAsync("Levels/PinballGame", true)
			arg_5_0.timer_ = FrameTimer.New(handler(arg_5_0, arg_5_0.Process), 1, -1)

			arg_5_0.timer_:Start()
			manager.windowBar:SetWhereTag("minigame")
		elseif arg_5_0.callback_ then
			arg_5_0.callback_()
		end

		manager.gc:Collect()
	end,
	Process = function(arg_7_0)
		local var_7_0 = SceneManager.GetSceneByName("PinballGame")

		if var_7_0 and var_7_0.isLoaded then
			if arg_7_0.callback_ then
				arg_7_0.callback_()
			end

			arg_7_0.timer_:Stop()

			arg_7_0.timer_ = nil
		end
	end,
	CameraAdaptive = function(arg_8_0)
		local var_8_0 = UnityEngine.Camera.main
		local var_8_1 = _G.SCREEN_WIDTH
		local var_8_2 = _G.SCREEN_HEIGHT
		local var_8_3 = Screen.width / Screen.height

		if var_8_3 < 1.7 then
			var_8_0.fieldOfView = 1.7 / var_8_3 * CameraCfg.pinball.fieldOfView
		else
			var_8_0.fieldOfView = CameraCfg.pinball.fieldOfView
		end
	end,
	GameSettlement = function(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7, arg_9_8, arg_9_9, arg_9_10, arg_9_11)
		if PinballStageCfg[PinballAction.PlayingStageID] and PinballStageCfg[PinballAction.PlayingStageID].barrier_type ~= 2 and Pinball.PinballGameManager.Instance then
			saveData("PinballGame", "doubleSpeed", Pinball.PinballGameManager.Instance.GMDoubleSpeed)
		end

		JumpTools.OpenPageByJump("pinballSettlement", {
			result = arg_9_6,
			remainHp = arg_9_1,
			allRound = arg_9_0,
			remainEHp = arg_9_2,
			BH = arg_9_3,
			EH = arg_9_4,
			SC = arg_9_5,
			challengeScore = arg_9_11,
			callback = function()
				PinballAction.SendMessageDataToSDK(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7, arg_9_8, arg_9_9, arg_9_10, arg_9_11)
			end
		})
	end,
	GameInterrupt = function(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7, arg_11_8, arg_11_9, arg_11_10, arg_11_11)
		if PinballStageCfg[PinballAction.PlayingStageID] and PinballStageCfg[PinballAction.PlayingStageID].barrier_type ~= 2 and Pinball.PinballGameManager.Instance then
			saveData("PinballGame", "doubleSpeed", Pinball.PinballGameManager.Instance.GMDoubleSpeed)
		end

		PinballAction.SendMessageDataToSDK(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7, arg_11_8, arg_11_9, arg_11_10, arg_11_11)
	end,
	UpgradeStageParamsFromCfg = function(arg_12_0)
		local var_12_0 = PinballWaveCfg[arg_12_0.stageId]
		local var_12_1

		if PinballAction.PlayingStageID == PinballData:GetChallengeStageID() then
			var_12_1 = PinballWaveCfg[PinballAction.ChallengeWaveList[table.indexof(PinballAction.ChallengeBoardList, arg_12_0.stageId)]]
		end

		if not var_12_0 then
			if PinballAction.PlayingStageID == PinballData:GetChallengeStageID() then
				var_12_0 = PinballWaveCfg[PinballAction.ChallengeWaveList[table.indexof(PinballAction.ChallengeBoardList, arg_12_0.stageId)]]
			end

			if not var_12_0 then
				Debug.LogError("弹珠玩法存在未配置的波次ID" .. arg_12_0.stageId)

				return
			end
		end

		arg_12_0.debateStageDamageTrigger = var_12_0.debate_start
		arg_12_0.overflowDamageTransFac = var_12_0.damage_overflows
		arg_12_0.baseSpareTimes = var_12_0.split_time
		arg_12_0.debateRoundLimit = var_12_0.debate_wellen_time
		arg_12_0.debateFinishCount = var_12_0.debate_quantity
		arg_12_0.debateDescription = GetI18NText(var_12_0.debate_desc)
		arg_12_0.debateSuccessDesc = GetI18NText(var_12_0.debate_success_desc)
		arg_12_0.baseHighValueWordValue = var_12_0.text_fraction
		arg_12_0.baseremainHp = var_12_0.brick_hp
		arg_12_0.baseExplosionLength = var_12_0.explosion_scope
		arg_12_0.baseExitPortalCD = var_12_0.portal_cd
		arg_12_0.supplementTriggerNumber = var_12_0.Item_replenishment_time
		arg_12_0.supplementMaxNumber = var_12_0.Item_replenishment_max
		arg_12_0.bubbleIDList = var_12_0.chat_id

		local var_12_2

		if PinballAction.PlayingStageID == PinballData:GetChallengeStageID() and var_12_1 and type(var_12_1.challenge_debate_wellen_id) == "table" and #var_12_1.challenge_debate_wellen_id > 0 then
			var_12_2 = var_12_1.challenge_debate_wellen_id[math.random(1, #var_12_1.challenge_debate_wellen_id)]
			arg_12_0.debateStageDamageTrigger = var_12_1.debate_start
		else
			arg_12_0.isBossStage = PinballData:IsBossWave(arg_12_0.stageId)
			var_12_2 = var_12_0.debate_wellen_id
		end

		if var_12_2 and var_12_2 ~= 0 then
			arg_12_0.debateStageData = Asset.Load("PinballGame/StageData/PinBallGameStage_" .. var_12_2)
			arg_12_0.hasDebateStage = true
		end
	end,
	CheckBubbleTigger = function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = false
		local var_13_1
		local var_13_2 = PinballWaveCfg[arg_13_0]

		if not var_13_2 then
			if PinballAction.PlayingStageID == PinballData:GetChallengeStageID() then
				var_13_2 = PinballWaveCfg[PinballAction.ChallengeWaveList[table.indexof(PinballAction.ChallengeBoardList, arg_13_0)]]
			end

			if not var_13_2 then
				Debug.LogError("弹珠玩法存在未配置的波次ID" .. arg_13_0)

				return
			end
		end

		Debug.Log("waveID:" .. arg_13_0)

		local var_13_3 = var_13_2.chat_id

		for iter_13_0, iter_13_1 in ipairs(var_13_3) do
			local var_13_4 = PinballBubbleCfg[iter_13_1]

			if var_13_4 and var_13_4.chat_type == arg_13_1 then
				var_13_0 = var_13_4.chat_type == 1 and arg_13_2 + 1 == var_13_4.params[1] and true or true

				if var_13_0 then
					var_13_1 = var_13_4
				end
			end
		end

		if var_13_0 then
			return tostring(GetI18NText(var_13_1.word[1]) or "") .. ";" .. tostring(GetI18NText(var_13_1.word[2]) or "") .. ";" .. tostring(GetI18NText(var_13_1.word[3]) or "")
		end

		return ""
	end,
	PlayTimelineWithCallBack = function(arg_14_0, arg_14_1)
		local var_14_0 = GameObject.Find("playerHomePos/1194ui_pinball/timeline/" .. arg_14_0).gameObject

		if var_14_0 then
			local var_14_1 = var_14_0:GetComponent("PlayableDirector")
			local var_14_2 = var_14_1.playableAsset

			if var_14_1 and var_14_2 then
				TimelineTools.PlayTimelineWithCallback(var_14_1, var_14_2, arg_14_1)
			end
		end
	end,
	PlayBgPushAnimator = function(arg_15_0, arg_15_1)
		local var_15_0 = GameObject.Find("HomeBackGroundRoot/PinballHomeBg/root")

		if var_15_0 and var_15_0.gameObject then
			local var_15_1 = var_15_0.gameObject:GetComponent("Animator")

			if var_15_1 then
				if arg_15_1 then
					var_15_1:Play("Hel_Main_bg_qiehuanFinalChange", 0, 0)
					var_15_1:Update(0)
				elseif arg_15_0 then
					var_15_1:Play("Hel_Main_bg_qiehuanChange", 0, 0)
				else
					local var_15_2 = GameObject.Find("HomeBackGroundRoot/PinballHomeBg/root/pre")
					local var_15_3 = GameObject.Find("HomeBackGroundRoot/PinballHomeBg/root/next")

					if var_15_2 and var_15_3 then
						var_15_2:GetComponent("SpriteRenderer").sprite = var_15_3:GetComponent("SpriteRenderer").sprite
					end

					local var_15_4 = GameObject.Find("HomeBackGroundRoot/PinballHomeBg/root/particle/next_particle_out")
					local var_15_5 = GameObject.Find("HomeBackGroundRoot/PinballHomeBg/root/particle/pre_particle_out").transform

					var_15_1:Play("Hel_Main_bg_qiehuanChange", 0, 0)

					if var_15_4 and var_15_5 then
						local var_15_6 = GameObject.Instantiate(var_15_4, var_15_5.parent.transform)

						var_15_6.name = "pre_particle_out"

						var_15_6:SetActive(false)
						var_15_6:SetActive(true)

						var_15_6.transform.localPosition = Vector3.New(var_15_5.localPosition.x, var_15_5.localPosition.y, var_15_5.localPosition.z)
						var_15_6.transform.localScale = Vector3.New(var_15_5.localScale.x, var_15_5.localScale.y, var_15_5.localScale.z)

						GameObject.DestroyImmediate(var_15_5.gameObject)
					end
				end
			end
		end
	end,
	PlayBgChangeAniWithTarget = function(arg_16_0, arg_16_1)
		local var_16_0 = GameObject.Find("HomeBackGroundRoot").transform
		local var_16_1 = PinballTools.GetCurrentSceneBgPrefabPath(arg_16_0)

		if var_16_1 and arg_16_1 then
			local var_16_2
			local var_16_3
			local var_16_4
			local var_16_5 = PinballData:HasPassAllStage()
			local var_16_6 = "pre"
			local var_16_7 = "next"

			if var_16_0.childCount > 0 then
				var_16_2 = var_16_0:GetChild(0)
				oldNext = var_16_2:Find("root/" .. var_16_7):GetComponent("SpriteRenderer")
				var_16_4 = var_16_2:Find("root/particle/next_particle_out")
			end

			local var_16_8 = GameObject.Instantiate(Asset.Load(var_16_1), var_16_0)

			var_16_8.name = "PinballHomeBg"

			local var_16_9 = var_16_8.transform:Find("root/pre"):GetComponent("SpriteRenderer")
			local var_16_10 = var_16_8.transform:Find("root/particle/pre_particle_out")

			var_16_9.sprite = oldNext.sprite

			var_16_4:SetParent(var_16_10.parent.transform)

			var_16_4.name = "pre_particle_out"

			var_16_4.gameObject:SetActive(true)

			var_16_4.localPosition = Vector3.New(var_16_10.localPosition.x, var_16_10.localPosition.y, var_16_10.localPosition.z)
			var_16_4.localScale = Vector3.New(var_16_10.localScale.x, var_16_10.localScale.y, var_16_10.localScale.z)

			GameObject.DestroyImmediate(var_16_10.gameObject)

			local var_16_11 = GameObject.Find("HomeBackParticlePos").transform
			local var_16_12 = var_16_8.transform:Find("root/particle")

			var_16_12.localPosition = Vector3.New(var_16_11.position.x, var_16_11.position.y, var_16_11.position.z)
			var_16_12.localScale = Vector3.New(var_16_11.localScale.x, var_16_11.localScale.y, var_16_11.localScale.z)

			GameObject.DestroyImmediate(var_16_2.gameObject)
		end
	end,
	SetDefaultHomeBg = function()
		local var_17_0 = GameObject.Find("HomeBackGroundRoot/PinballHomeBg/root")

		if var_17_0 and var_17_0.gameObject then
			local var_17_1 = var_17_0.gameObject:GetComponent("Animator")

			if var_17_1 then
				var_17_1:Play("Hel_Main_bg_qiehuanStop", 0, 0)
			end
		end
	end,
	SetEndDefaultHomeBg = function()
		local var_18_0 = GameObject.Find("HomeBackGroundRoot/PinballHomeBg/root")

		if var_18_0 and var_18_0.gameObject then
			local var_18_1 = var_18_0.gameObject:GetComponent("Animator")

			if var_18_1 then
				var_18_1:Play("Hel_Main_bg_qiehuanStart", 0, 0)
			end
		end
	end,
	SetDefaultBg = function()
		local var_19_0 = GameObject.Find("BackGroundRoot/PinballBg/root")

		if var_19_0 and var_19_0.gameObject then
			local var_19_1 = var_19_0.gameObject:GetComponent("Animator")

			if var_19_1 then
				local var_19_2 = PinballData:HasPassAllStage()

				var_19_1:Play("Hel_Main_bg_qiehuanChangeStop", 0, 0)
			end
		end
	end,
	SetPlayerAniState = function(arg_20_0)
		local var_20_0 = GameObject.Find("playerHomePos/1194ui_pinball")

		if var_20_0 and var_20_0.gameObject then
			local var_20_1 = var_20_0.gameObject:GetComponent("Animator")

			if var_20_1 then
				var_20_1:Play(arg_20_0, 0, 0)
			end
		end
	end,
	ShowBackGroundMask = function(arg_21_0)
		local var_21_0 = GameObject.Find("bgMask").transform

		if var_21_0 then
			if arg_21_0 then
				var_21_0:GetComponent("SpriteRenderer").enabled = true
			else
				var_21_0:GetComponent("SpriteRenderer").enabled = false
			end
		end
	end,
	GetOverFlowDamageScore = function()
		local var_22_0 = GameSetting.pinball_game_overflow_damage_to_score.value

		if var_22_0 then
			return var_22_0
		end

		return {}
	end
}
