return {
	Play115201001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115201001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115201002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.RO0205 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "RO0205")
				var_4_0.name = "RO0205"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.RO0205 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.RO0205

				arg_1_1.bgs_.RO0205.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "RO0205" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_15", "se_story_15_blast03", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.475 < arg_1_1.time_ and arg_1_1.time_ <= 0.475 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_4_15 = manager.ui.mainCamera.transform

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_15.localPosition
			end

			local var_4_16 = 1

			if 1 <= arg_1_1.time_ and arg_1_1.time_ < 1 + var_4_16 then
				local var_4_17, var_4_18 = math.modf((arg_1_1.time_ - 1) / 0.066)

				var_4_15.localPosition = Vector3.New(var_4_18 * 0.13, var_4_18 * 0.13, var_4_18 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 1 + var_4_16 and arg_1_1.time_ < 1 + var_4_16 + arg_4_0 then
				var_4_15.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_19 = arg_1_1.bgs_.RO0205.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosRO0205 = var_4_19.localPosition
			end

			local var_4_20 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_20 then
				var_4_19.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosRO0205, Vector3.New(-1, 1, 6), (arg_1_1.time_ - 0) / var_4_20)
			end

			if arg_1_1.time_ >= 0 + var_4_20 and arg_1_1.time_ < 0 + var_4_20 + arg_4_0 then
				var_4_19.localPosition = Vector3.New(-1, 1, 6)
			end

			local var_4_21 = arg_1_1.bgs_.RO0205.transform

			if 0.0166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.0166666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPosRO0205 = var_4_21.localPosition
			end

			local var_4_22 = 3.5

			if 0.0166666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 0.0166666666666667 + var_4_22 then
				var_4_21.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosRO0205, Vector3.New(-1, 0.5, 6), (arg_1_1.time_ - 0.0166666666666667) / var_4_22)
			end

			if arg_1_1.time_ >= 0.0166666666666667 + var_4_22 and arg_1_1.time_ < 0.0166666666666667 + var_4_22 + arg_4_0 then
				var_4_21.localPosition = Vector3.New(-1, 0.5, 6)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 2
			local var_4_24 = 0.475

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(115201001).content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 19 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 19)

				if (19 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 19)) > 0 and var_4_24 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28
					var_4_23 = var_4_23 + 0.3

					if var_4_28 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_29 = var_4_23 + 0.3
			local var_4_30 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_29) / var_4_30

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "RO0205",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "RO0205",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play115201002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115201002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play115201003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.075

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(115201002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 43 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 43)

				if (43 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 43)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play115201003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115201003
		arg_13_1.duration_ = 8.87

		local var_13_0 = {
			ja = 8.866,
			ko = 5.4,
			zh = 8.666,
			en = 6.833
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play115201004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.475

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(115201003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 19 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 19)

				if (19 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 19)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201003", "story_v_out_115201.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201003", "story_v_out_115201.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_115201", "115201003", "story_v_out_115201.awb")

						arg_13_1:RecordAudio("115201003", var_16_6)
						arg_13_1:RecordAudio("115201003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_115201", "115201003", "story_v_out_115201.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_115201", "115201003", "story_v_out_115201.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play115201004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115201004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play115201005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.375

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(115201004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 15 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 15)

				if (15 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 15)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play115201005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 115201005
		arg_21_1.duration_ = 10.1

		local var_21_0 = {
			ja = 10.1,
			ko = 6.333,
			zh = 8.133,
			en = 5.966
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play115201006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.45

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(115201005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 18 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 18)

				if (18 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 18)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201005", "story_v_out_115201.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201005", "story_v_out_115201.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_115201", "115201005", "story_v_out_115201.awb")

						arg_21_1:RecordAudio("115201005", var_24_6)
						arg_21_1:RecordAudio("115201005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_115201", "115201005", "story_v_out_115201.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_115201", "115201005", "story_v_out_115201.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play115201006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 115201006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play115201007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.65

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(115201006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 26)

				if (26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 26)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play115201007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 115201007
		arg_29_1.duration_ = 10.5

		local var_29_0 = {
			ja = 8.8,
			ko = 8.2,
			zh = 10.5,
			en = 7.666
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play115201008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.bgs_.G02j == nil then
				local var_32_0 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "G02j")
				var_32_0.name = "G02j"
				var_32_0.transform.parent = arg_29_1.stage_.transform
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_.G02j = var_32_0
			end

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= 2 + arg_32_0 then
				local var_32_1 = arg_29_1.bgs_.G02j

				arg_29_1.bgs_.G02j.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_2 = var_32_1:GetComponent("SpriteRenderer")

				if var_32_2 and var_32_2.sprite then
					local var_32_3 = 2 * (var_32_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_1.transform.localScale = Vector3.New(var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "G02j" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_4 = 0

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_5 = 2

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_5 then
				local var_32_6 = Color.New(0, 0, 0)

				var_32_6.a = Mathf.Lerp(0, 1, (arg_29_1.time_ - var_32_4) / var_32_5)
				arg_29_1.mask_.color = var_32_6
			end

			if arg_29_1.time_ >= var_32_4 + var_32_5 and arg_29_1.time_ < var_32_4 + var_32_5 + arg_32_0 then
				local var_32_7 = Color.New(0, 0, 0)

				var_32_7.a = 1
				arg_29_1.mask_.color = var_32_7
			end

			local var_32_8 = 2

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_9 = 2

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_9 then
				local var_32_10 = Color.New(0, 0, 0)

				var_32_10.a = Mathf.Lerp(1, 0, (arg_29_1.time_ - var_32_8) / var_32_9)
				arg_29_1.mask_.color = var_32_10
			end

			if arg_29_1.time_ >= var_32_8 + var_32_9 and arg_29_1.time_ < var_32_8 + var_32_9 + arg_32_0 then
				local var_32_11 = Color.New(0, 0, 0)

				arg_29_1.mask_.enabled = false
				var_32_11.a = 0
				arg_29_1.mask_.color = var_32_11
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_12 = 4
			local var_32_13 = 0.25

			if 4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_14 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_14:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_15 = arg_29_1:GetWordFromCfg(115201007)
				local var_32_16 = arg_29_1:FormatText(var_32_15.content)

				arg_29_1.text_.text = var_32_16

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_18 = 10 <= 0 and var_32_13 or var_32_13 * (utf8.len(var_32_16) / 10)

				if (10 <= 0 and var_32_13 or var_32_13 * (utf8.len(var_32_16) / 10)) > 0 and var_32_13 < var_32_18 then
					arg_29_1.talkMaxDuration = var_32_18
					var_32_12 = var_32_12 + 0.3

					if var_32_18 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_12
					end
				end

				arg_29_1.text_.text = var_32_16
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201007", "story_v_out_115201.awb") ~= 0 then
					local var_32_19 = manager.audio:GetVoiceLength("story_v_out_115201", "115201007", "story_v_out_115201.awb") / 1000

					if var_32_19 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_12
					end

					if var_32_15.prefab_name ~= "" and arg_29_1.actors_[var_32_15.prefab_name] ~= nil then
						local var_32_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_15.prefab_name].transform, "story_v_out_115201", "115201007", "story_v_out_115201.awb")

						arg_29_1:RecordAudio("115201007", var_32_20)
						arg_29_1:RecordAudio("115201007", var_32_20)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_115201", "115201007", "story_v_out_115201.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_115201", "115201007", "story_v_out_115201.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_21 = var_32_12 + 0.3
			local var_32_22 = math.max(var_32_13, arg_29_1.talkMaxDuration)

			if var_32_12 + 0.3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_21 + var_32_22 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_21) / var_32_22

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_21 + var_32_22 and arg_29_1.time_ < var_32_21 + var_32_22 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play115201008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 115201008
		arg_35_1.duration_ = 5

		local var_35_0 = {
			ja = 5,
			ko = 3,
			zh = 2.566,
			en = 3.633
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play115201009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if arg_35_1.actors_["1024ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1024ui_story"))) then
				local var_38_0 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_35_1.stage_.transform)

				var_38_0.name = "1024ui_story"
				var_38_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_["1024ui_story"] = var_38_0

				local var_38_1 = var_38_0:GetComponentInChildren(typeof(CharacterEffect))

				var_38_1.enabled = true

				local var_38_2 = GameObjectTools.GetOrAddComponent(var_38_0, typeof(DynamicBoneHelper))

				if var_38_2 then
					var_38_2:EnableDynamicBone(false)
				end

				arg_35_1:ShowWeapon(var_38_1.transform, false)

				arg_35_1.var_["1024ui_story" .. "Animator"] = var_38_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_35_1.var_["1024ui_story" .. "Animator"].applyRootMotion = true
				arg_35_1.var_["1024ui_story" .. "LipSync"] = var_38_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_38_3 = arg_35_1.actors_["1024ui_story"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1024ui_story = var_38_3.localPosition
			end

			local var_38_4 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				var_38_3.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_35_1.time_ - 0) / var_38_4)
				var_38_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_3.position).x, (manager.ui.mainCamera.transform.position - var_38_3.position).y, (manager.ui.mainCamera.transform.position - var_38_3.position).z)
				var_38_3.localEulerAngles.z = 0
				var_38_3.localEulerAngles.x = 0
				var_38_3.localEulerAngles = var_38_3.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				var_38_3.localPosition = Vector3.New(0, -1, -6.05)
				var_38_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_3.position).x, (manager.ui.mainCamera.transform.position - var_38_3.position).y, (manager.ui.mainCamera.transform.position - var_38_3.position).z)
				var_38_3.localEulerAngles.z = 0
				var_38_3.localEulerAngles.x = 0
				var_38_3.localEulerAngles = var_38_3.localEulerAngles
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_1")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_38_5 = arg_35_1.actors_["1024ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_5) and arg_35_1.var_.characterEffect1024ui_story == nil then
				arg_35_1.var_.characterEffect1024ui_story = var_38_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_6 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_6 and not isNil(var_38_5) then
				if arg_35_1.var_.characterEffect1024ui_story and not isNil(var_38_5) then
					arg_35_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_6 and arg_35_1.time_ < 0 + var_38_6 + arg_38_0 and not isNil(var_38_5) and arg_35_1.var_.characterEffect1024ui_story then
				arg_35_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_38_8 = 0
			local var_38_9 = 0.4

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_8 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_10 = arg_35_1:GetWordFromCfg(115201008)
				local var_38_11 = arg_35_1:FormatText(var_38_10.content)

				arg_35_1.text_.text = var_38_11

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_13 = 16 <= 0 and var_38_9 or var_38_9 * (utf8.len(var_38_11) / 16)

				if (16 <= 0 and var_38_9 or var_38_9 * (utf8.len(var_38_11) / 16)) > 0 and var_38_9 < var_38_13 then
					arg_35_1.talkMaxDuration = var_38_13

					if var_38_13 + var_38_8 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_8
					end
				end

				arg_35_1.text_.text = var_38_11
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201008", "story_v_out_115201.awb") ~= 0 then
					local var_38_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201008", "story_v_out_115201.awb") / 1000

					if var_38_14 + var_38_8 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_14 + var_38_8
					end

					if var_38_10.prefab_name ~= "" and arg_35_1.actors_[var_38_10.prefab_name] ~= nil then
						local var_38_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_10.prefab_name].transform, "story_v_out_115201", "115201008", "story_v_out_115201.awb")

						arg_35_1:RecordAudio("115201008", var_38_15)
						arg_35_1:RecordAudio("115201008", var_38_15)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_115201", "115201008", "story_v_out_115201.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_115201", "115201008", "story_v_out_115201.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_16 = math.max(var_38_9, arg_35_1.talkMaxDuration)

			if var_38_8 <= arg_35_1.time_ and arg_35_1.time_ < var_38_8 + var_38_16 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_8) / var_38_16

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_8 + var_38_16 and arg_35_1.time_ < var_38_8 + var_38_16 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play115201009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 115201009
		arg_39_1.duration_ = 10.8

		local var_39_0 = {
			ja = 8.333,
			ko = 6.133,
			zh = 10.8,
			en = 6.766
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play115201010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1024ui_story"]) and arg_39_1.var_.characterEffect1024ui_story == nil then
				arg_39_1.var_.characterEffect1024ui_story = arg_39_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1024ui_story"]) then
				if arg_39_1.var_.characterEffect1024ui_story and not isNil(arg_39_1.actors_["1024ui_story"]) then
					arg_39_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1024ui_story"]) and arg_39_1.var_.characterEffect1024ui_story then
				arg_39_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 0.55

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:GetWordFromCfg(115201009)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_6 = 22 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_4) / 22)

				if (22 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_4) / 22)) > 0 and var_42_2 < var_42_6 then
					arg_39_1.talkMaxDuration = var_42_6

					if var_42_6 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_6 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201009", "story_v_out_115201.awb") ~= 0 then
					local var_42_7 = manager.audio:GetVoiceLength("story_v_out_115201", "115201009", "story_v_out_115201.awb") / 1000

					if var_42_7 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_1
					end

					if var_42_3.prefab_name ~= "" and arg_39_1.actors_[var_42_3.prefab_name] ~= nil then
						local var_42_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_3.prefab_name].transform, "story_v_out_115201", "115201009", "story_v_out_115201.awb")

						arg_39_1:RecordAudio("115201009", var_42_8)
						arg_39_1:RecordAudio("115201009", var_42_8)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_115201", "115201009", "story_v_out_115201.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_115201", "115201009", "story_v_out_115201.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_9 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_9 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_9

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_9 and arg_39_1.time_ < var_42_1 + var_42_9 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play115201010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 115201010
		arg_43_1.duration_ = 3.03

		local var_43_0 = {
			ja = 2.866,
			ko = 2.4,
			zh = 3.033,
			en = 2.7
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play115201011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1024ui_story = arg_43_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1024ui_story"].transform.position).z)
				arg_43_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1024ui_story"].transform.localEulerAngles = arg_43_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1024ui_story"].transform.position).z)
				arg_43_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1024ui_story"].transform.localEulerAngles = arg_43_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_46_1 = 0
			local var_46_2 = 0.225

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[261].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_3 = arg_43_1:GetWordFromCfg(115201010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_6 = 9 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_4) / 9)

				if (9 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_4) / 9)) > 0 and var_46_2 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201010", "story_v_out_115201.awb") ~= 0 then
					local var_46_7 = manager.audio:GetVoiceLength("story_v_out_115201", "115201010", "story_v_out_115201.awb") / 1000

					if var_46_7 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_1
					end

					if var_46_3.prefab_name ~= "" and arg_43_1.actors_[var_46_3.prefab_name] ~= nil then
						local var_46_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_3.prefab_name].transform, "story_v_out_115201", "115201010", "story_v_out_115201.awb")

						arg_43_1:RecordAudio("115201010", var_46_8)
						arg_43_1:RecordAudio("115201010", var_46_8)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_115201", "115201010", "story_v_out_115201.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_115201", "115201010", "story_v_out_115201.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_9 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_9 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_9

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_9 and arg_43_1.time_ < var_46_1 + var_46_9 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play115201011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 115201011
		arg_47_1.duration_ = 2.6

		local var_47_0 = {
			ja = 2.6,
			ko = 2,
			zh = 1.866,
			en = 2.3
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play115201012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.15

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[262].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_1 = arg_47_1:GetWordFromCfg(115201011)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 6 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 6)

				if (6 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 6)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201011", "story_v_out_115201.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201011", "story_v_out_115201.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_115201", "115201011", "story_v_out_115201.awb")

						arg_47_1:RecordAudio("115201011", var_50_6)
						arg_47_1:RecordAudio("115201011", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_115201", "115201011", "story_v_out_115201.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_115201", "115201011", "story_v_out_115201.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play115201012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 115201012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play115201013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.9

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(115201012).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 36 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 36)

				if (36 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 36)) > 0 and var_54_0 < var_54_3 then
					arg_51_1.talkMaxDuration = var_54_3

					if var_54_3 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_3 + 0
					end
				end

				arg_51_1.text_.text = var_54_1
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_4 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_4

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play115201013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 115201013
		arg_55_1.duration_ = 7.3

		local var_55_0 = {
			ja = 7.3,
			ko = 6.266,
			zh = 5.933,
			en = 6.966
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play115201014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.675

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[261].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:GetWordFromCfg(115201013)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 27 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 27)

				if (27 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 27)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201013", "story_v_out_115201.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201013", "story_v_out_115201.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_115201", "115201013", "story_v_out_115201.awb")

						arg_55_1:RecordAudio("115201013", var_58_6)
						arg_55_1:RecordAudio("115201013", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_115201", "115201013", "story_v_out_115201.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_115201", "115201013", "story_v_out_115201.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play115201014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 115201014
		arg_59_1.duration_ = 4.6

		local var_59_0 = {
			ja = 4.6,
			ko = 4.233,
			zh = 3.333,
			en = 3.7
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play115201015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.45

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[262].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_1 = arg_59_1:GetWordFromCfg(115201014)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 18 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 18)

				if (18 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 18)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201014", "story_v_out_115201.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201014", "story_v_out_115201.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_115201", "115201014", "story_v_out_115201.awb")

						arg_59_1:RecordAudio("115201014", var_62_6)
						arg_59_1:RecordAudio("115201014", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_115201", "115201014", "story_v_out_115201.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_115201", "115201014", "story_v_out_115201.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play115201015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 115201015
		arg_63_1.duration_ = 6.43

		local var_63_0 = {
			ja = 6.433,
			ko = 5.433,
			zh = 4.966,
			en = 6.266
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play115201016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.675

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[262].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:GetWordFromCfg(115201015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 27 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 27)

				if (27 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 27)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201015", "story_v_out_115201.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201015", "story_v_out_115201.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_115201", "115201015", "story_v_out_115201.awb")

						arg_63_1:RecordAudio("115201015", var_66_6)
						arg_63_1:RecordAudio("115201015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_115201", "115201015", "story_v_out_115201.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_115201", "115201015", "story_v_out_115201.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play115201016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 115201016
		arg_67_1.duration_ = 4.37

		local var_67_0 = {
			ja = 3.9,
			ko = 3.666,
			zh = 3.7,
			en = 4.366
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play115201017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_70_0 = 0.6

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				local var_70_1, var_70_2 = math.modf((arg_67_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_70_2 * 0.13, var_70_2 * 0.13, var_70_2 * 0.13) + arg_67_1.var_.shakeOldPos
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				manager.ui.mainCamera.transform.localPosition = arg_67_1.var_.shakeOldPos
			end

			local var_70_3 = 0

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_3 + arg_70_0 then
				arg_67_1.allBtn_.enabled = false
			end

			if arg_67_1.time_ >= var_70_3 + 0.6 and arg_67_1.time_ < var_70_3 + 0.6 + arg_70_0 then
				arg_67_1.allBtn_.enabled = true
			end

			local var_70_4 = 0
			local var_70_5 = 0.35

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1016")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_6 = arg_67_1:GetWordFromCfg(115201016)
				local var_70_7 = arg_67_1:FormatText(var_70_6.content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 14 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 14)

				if (14 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 14)) > 0 and var_70_5 < var_70_9 then
					arg_67_1.talkMaxDuration = var_70_9

					if var_70_9 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201016", "story_v_out_115201.awb") ~= 0 then
					local var_70_10 = manager.audio:GetVoiceLength("story_v_out_115201", "115201016", "story_v_out_115201.awb") / 1000

					if var_70_10 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_4
					end

					if var_70_6.prefab_name ~= "" and arg_67_1.actors_[var_70_6.prefab_name] ~= nil then
						local var_70_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_6.prefab_name].transform, "story_v_out_115201", "115201016", "story_v_out_115201.awb")

						arg_67_1:RecordAudio("115201016", var_70_11)
						arg_67_1:RecordAudio("115201016", var_70_11)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_115201", "115201016", "story_v_out_115201.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_115201", "115201016", "story_v_out_115201.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_12 = math.max(var_70_5, arg_67_1.talkMaxDuration)

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_12 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_4) / var_70_12

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_4 + var_70_12 and arg_67_1.time_ < var_70_4 + var_70_12 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play115201017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 115201017
		arg_71_1.duration_ = 5.73

		local var_71_0 = {
			ja = 5.733,
			ko = 3.9,
			zh = 3,
			en = 3.7
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play115201018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.2

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_1 = arg_71_1:GetWordFromCfg(115201017)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 8 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 8)

				if (8 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 8)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201017", "story_v_out_115201.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201017", "story_v_out_115201.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_115201", "115201017", "story_v_out_115201.awb")

						arg_71_1:RecordAudio("115201017", var_74_6)
						arg_71_1:RecordAudio("115201017", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_115201", "115201017", "story_v_out_115201.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_115201", "115201017", "story_v_out_115201.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play115201018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 115201018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play115201019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.65

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(115201018).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 26 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 26)

				if (26 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 26)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play115201019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 115201019
		arg_79_1.duration_ = 2.9

		local var_79_0 = {
			ja = 2.633,
			ko = 2.9,
			zh = 2.1,
			en = 2.8
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play115201020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if arg_79_1.actors_["1052ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1052ui_story"))) then
				local var_82_0 = Object.Instantiate(Asset.Load("Char/" .. "1052ui_story"), arg_79_1.stage_.transform)

				var_82_0.name = "1052ui_story"
				var_82_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.actors_["1052ui_story"] = var_82_0

				local var_82_1 = var_82_0:GetComponentInChildren(typeof(CharacterEffect))

				var_82_1.enabled = true

				local var_82_2 = GameObjectTools.GetOrAddComponent(var_82_0, typeof(DynamicBoneHelper))

				if var_82_2 then
					var_82_2:EnableDynamicBone(false)
				end

				arg_79_1:ShowWeapon(var_82_1.transform, false)

				arg_79_1.var_["1052ui_story" .. "Animator"] = var_82_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_79_1.var_["1052ui_story" .. "Animator"].applyRootMotion = true
				arg_79_1.var_["1052ui_story" .. "LipSync"] = var_82_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_82_3 = arg_79_1.actors_["1052ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1052ui_story = var_82_3.localPosition
			end

			local var_82_4 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				var_82_3.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1052ui_story, Vector3.New(0, -1.05, -6.2), (arg_79_1.time_ - 0) / var_82_4)
				var_82_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_3.position).x, (manager.ui.mainCamera.transform.position - var_82_3.position).y, (manager.ui.mainCamera.transform.position - var_82_3.position).z)
				var_82_3.localEulerAngles.z = 0
				var_82_3.localEulerAngles.x = 0
				var_82_3.localEulerAngles = var_82_3.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				var_82_3.localPosition = Vector3.New(0, -1.05, -6.2)
				var_82_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_3.position).x, (manager.ui.mainCamera.transform.position - var_82_3.position).y, (manager.ui.mainCamera.transform.position - var_82_3.position).z)
				var_82_3.localEulerAngles.z = 0
				var_82_3.localEulerAngles.x = 0
				var_82_3.localEulerAngles = var_82_3.localEulerAngles
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_82_5 = arg_79_1.actors_["1052ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_5) and arg_79_1.var_.characterEffect1052ui_story == nil then
				arg_79_1.var_.characterEffect1052ui_story = var_82_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_6 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_6 and not isNil(var_82_5) then
				if arg_79_1.var_.characterEffect1052ui_story and not isNil(var_82_5) then
					arg_79_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_6 and arg_79_1.time_ < 0 + var_82_6 + arg_82_0 and not isNil(var_82_5) and arg_79_1.var_.characterEffect1052ui_story then
				arg_79_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_82_8 = 0
			local var_82_9 = 0.25

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_10 = arg_79_1:GetWordFromCfg(115201019)
				local var_82_11 = arg_79_1:FormatText(var_82_10.content)

				arg_79_1.text_.text = var_82_11

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_13 = 10 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 10)

				if (10 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 10)) > 0 and var_82_9 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_8
					end
				end

				arg_79_1.text_.text = var_82_11
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201019", "story_v_out_115201.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201019", "story_v_out_115201.awb") / 1000

					if var_82_14 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_8
					end

					if var_82_10.prefab_name ~= "" and arg_79_1.actors_[var_82_10.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_10.prefab_name].transform, "story_v_out_115201", "115201019", "story_v_out_115201.awb")

						arg_79_1:RecordAudio("115201019", var_82_15)
						arg_79_1:RecordAudio("115201019", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_115201", "115201019", "story_v_out_115201.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_115201", "115201019", "story_v_out_115201.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_9, arg_79_1.talkMaxDuration)

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_8) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_8 + var_82_16 and arg_79_1.time_ < var_82_8 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play115201020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 115201020
		arg_83_1.duration_ = 5.13

		local var_83_0 = {
			ja = 5.133,
			ko = 4.7,
			zh = 4.233,
			en = 4.066
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play115201021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1052ui_story"]) and arg_83_1.var_.characterEffect1052ui_story == nil then
				arg_83_1.var_.characterEffect1052ui_story = arg_83_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1052ui_story"]) then
				if arg_83_1.var_.characterEffect1052ui_story and not isNil(arg_83_1.actors_["1052ui_story"]) then
					arg_83_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1052ui_story"]) and arg_83_1.var_.characterEffect1052ui_story then
				arg_83_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 0.425

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[262].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(115201020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 17 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 17)

				if (17 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 17)) > 0 and var_86_2 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201020", "story_v_out_115201.awb") ~= 0 then
					local var_86_7 = manager.audio:GetVoiceLength("story_v_out_115201", "115201020", "story_v_out_115201.awb") / 1000

					if var_86_7 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_1
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_115201", "115201020", "story_v_out_115201.awb")

						arg_83_1:RecordAudio("115201020", var_86_8)
						arg_83_1:RecordAudio("115201020", var_86_8)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_115201", "115201020", "story_v_out_115201.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_115201", "115201020", "story_v_out_115201.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_9 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_9 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_9

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_9 and arg_83_1.time_ < var_86_1 + var_86_9 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play115201021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 115201021
		arg_87_1.duration_ = 4.9

		local var_87_0 = {
			ja = 4.9,
			ko = 4.733,
			zh = 3.733,
			en = 4.466
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play115201022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.4

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[291].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_1 = arg_87_1:GetWordFromCfg(115201021)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 15 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 15)

				if (15 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 15)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201021", "story_v_out_115201.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201021", "story_v_out_115201.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_115201", "115201021", "story_v_out_115201.awb")

						arg_87_1:RecordAudio("115201021", var_90_6)
						arg_87_1:RecordAudio("115201021", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_115201", "115201021", "story_v_out_115201.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_115201", "115201021", "story_v_out_115201.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play115201022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 115201022
		arg_91_1.duration_ = 6.6

		local var_91_0 = {
			ja = 6.6,
			ko = 4.033,
			zh = 3.233,
			en = 5.666
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play115201023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_94_0 = arg_91_1.actors_["1052ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1052ui_story == nil then
				arg_91_1.var_.characterEffect1052ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_1 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 and not isNil(var_94_0) then
				if arg_91_1.var_.characterEffect1052ui_story and not isNil(var_94_0) then
					arg_91_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1052ui_story then
				arg_91_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action2_1")
			end

			local var_94_3 = arg_91_1.actors_["1052ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1052ui_story = var_94_3.localPosition

				arg_91_1:ShowWeapon(arg_91_1.var_["1052ui_story" .. "Animator"].transform, true)
			end

			local var_94_4 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				var_94_3.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1052ui_story, Vector3.New(0, -1.05, -6.2), (arg_91_1.time_ - 0) / var_94_4)
				var_94_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_3.position).x, (manager.ui.mainCamera.transform.position - var_94_3.position).y, (manager.ui.mainCamera.transform.position - var_94_3.position).z)
				var_94_3.localEulerAngles.z = 0
				var_94_3.localEulerAngles.x = 0
				var_94_3.localEulerAngles = var_94_3.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				var_94_3.localPosition = Vector3.New(0, -1.05, -6.2)
				var_94_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_3.position).x, (manager.ui.mainCamera.transform.position - var_94_3.position).y, (manager.ui.mainCamera.transform.position - var_94_3.position).z)
				var_94_3.localEulerAngles.z = 0
				var_94_3.localEulerAngles.x = 0
				var_94_3.localEulerAngles = var_94_3.localEulerAngles
			end

			local var_94_5 = 0
			local var_94_6 = 0.35

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_7 = arg_91_1:GetWordFromCfg(115201022)
				local var_94_8 = arg_91_1:FormatText(var_94_7.content)

				arg_91_1.text_.text = var_94_8

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_10 = 14 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_8) / 14)

				if (14 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_8) / 14)) > 0 and var_94_6 < var_94_10 then
					arg_91_1.talkMaxDuration = var_94_10

					if var_94_10 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_5
					end
				end

				arg_91_1.text_.text = var_94_8
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201022", "story_v_out_115201.awb") ~= 0 then
					local var_94_11 = manager.audio:GetVoiceLength("story_v_out_115201", "115201022", "story_v_out_115201.awb") / 1000

					if var_94_11 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_11 + var_94_5
					end

					if var_94_7.prefab_name ~= "" and arg_91_1.actors_[var_94_7.prefab_name] ~= nil then
						local var_94_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_7.prefab_name].transform, "story_v_out_115201", "115201022", "story_v_out_115201.awb")

						arg_91_1:RecordAudio("115201022", var_94_12)
						arg_91_1:RecordAudio("115201022", var_94_12)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_115201", "115201022", "story_v_out_115201.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_115201", "115201022", "story_v_out_115201.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_13 = math.max(var_94_6, arg_91_1.talkMaxDuration)

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_13 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_5) / var_94_13

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_5 + var_94_13 and arg_91_1.time_ < var_94_5 + var_94_13 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play115201023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 115201023
		arg_95_1.duration_ = 7.9

		local var_95_0 = {
			ja = 5.566,
			ko = 3.633,
			zh = 3.266,
			en = 7.9
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play115201024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1052ui_story"]) and arg_95_1.var_.characterEffect1052ui_story == nil then
				arg_95_1.var_.characterEffect1052ui_story = arg_95_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1052ui_story"]) then
				if arg_95_1.var_.characterEffect1052ui_story and not isNil(arg_95_1.actors_["1052ui_story"]) then
					arg_95_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_0)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1052ui_story"]) and arg_95_1.var_.characterEffect1052ui_story then
				arg_95_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_98_1 = arg_95_1.actors_["1052ui_story"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1052ui_story = var_98_1.localPosition
			end

			local var_98_2 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 then
				var_98_1.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1052ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 0) / var_98_2)
				var_98_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_1.position).x, (manager.ui.mainCamera.transform.position - var_98_1.position).y, (manager.ui.mainCamera.transform.position - var_98_1.position).z)
				var_98_1.localEulerAngles.z = 0
				var_98_1.localEulerAngles.x = 0
				var_98_1.localEulerAngles = var_98_1.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 then
				var_98_1.localPosition = Vector3.New(0, 100, 0)
				var_98_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_1.position).x, (manager.ui.mainCamera.transform.position - var_98_1.position).y, (manager.ui.mainCamera.transform.position - var_98_1.position).z)
				var_98_1.localEulerAngles.z = 0
				var_98_1.localEulerAngles.x = 0
				var_98_1.localEulerAngles = var_98_1.localEulerAngles
			end

			local var_98_3 = 0
			local var_98_4 = 0.375

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[292].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_5 = arg_95_1:GetWordFromCfg(115201023)
				local var_98_6 = arg_95_1:FormatText(var_98_5.content)

				arg_95_1.text_.text = var_98_6

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_8 = 15 <= 0 and var_98_4 or var_98_4 * (utf8.len(var_98_6) / 15)

				if (15 <= 0 and var_98_4 or var_98_4 * (utf8.len(var_98_6) / 15)) > 0 and var_98_4 < var_98_8 then
					arg_95_1.talkMaxDuration = var_98_8

					if var_98_8 + var_98_3 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_3
					end
				end

				arg_95_1.text_.text = var_98_6
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201023", "story_v_out_115201.awb") ~= 0 then
					local var_98_9 = manager.audio:GetVoiceLength("story_v_out_115201", "115201023", "story_v_out_115201.awb") / 1000

					if var_98_9 + var_98_3 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_3
					end

					if var_98_5.prefab_name ~= "" and arg_95_1.actors_[var_98_5.prefab_name] ~= nil then
						local var_98_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_5.prefab_name].transform, "story_v_out_115201", "115201023", "story_v_out_115201.awb")

						arg_95_1:RecordAudio("115201023", var_98_10)
						arg_95_1:RecordAudio("115201023", var_98_10)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_115201", "115201023", "story_v_out_115201.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_115201", "115201023", "story_v_out_115201.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_11 = math.max(var_98_4, arg_95_1.talkMaxDuration)

			if var_98_3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_3 + var_98_11 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_3) / var_98_11

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_3 + var_98_11 and arg_95_1.time_ < var_98_3 + var_98_11 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play115201024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 115201024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play115201025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0.666666666666667 < arg_99_1.time_ and arg_99_1.time_ <= 0.666666666666667 + arg_102_0 then
				arg_99_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_102_0 = 1

			if 0.666666666666667 <= arg_99_1.time_ and arg_99_1.time_ < 0.666666666666667 + var_102_0 then
				local var_102_1, var_102_2 = math.modf((arg_99_1.time_ - 0.666666666666667) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_102_2 * 0.13, var_102_2 * 0.13, var_102_2 * 0.13) + arg_99_1.var_.shakeOldPos
			end

			if arg_99_1.time_ >= 0.666666666666667 + var_102_0 and arg_99_1.time_ < 0.666666666666667 + var_102_0 + arg_102_0 then
				manager.ui.mainCamera.transform.localPosition = arg_99_1.var_.shakeOldPos
			end

			if 0.666666666666667 < arg_99_1.time_ and arg_99_1.time_ <= 0.666666666666667 + arg_102_0 then
				arg_99_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun02", "")
			end

			local var_102_4 = 0

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.allBtn_.enabled = false
			end

			if arg_99_1.time_ >= var_102_4 + 1.66666666666667 and arg_99_1.time_ < var_102_4 + 1.66666666666667 + arg_102_0 then
				arg_99_1.allBtn_.enabled = true
			end

			local var_102_5 = 0
			local var_102_6 = 1.5

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_7 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(115201024).content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 60 <= 0 and var_102_6 or var_102_6 * (utf8.len(var_102_7) / 60)

				if (60 <= 0 and var_102_6 or var_102_6 * (utf8.len(var_102_7) / 60)) > 0 and var_102_6 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_5 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_5
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_6, arg_99_1.talkMaxDuration)

			if var_102_5 <= arg_99_1.time_ and arg_99_1.time_ < var_102_5 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_5) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_5 + var_102_10 and arg_99_1.time_ < var_102_5 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play115201025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 115201025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play115201026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0.675 < arg_103_1.time_ and arg_103_1.time_ <= 0.675 + arg_106_0 then
				arg_103_1:AudioAction("play", "effect", "se_story_15", "se_story_15_repel", "")
			end

			local var_106_1 = 0
			local var_106_2 = 1.675

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(115201025).content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 67 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 67)

				if (67 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 67)) > 0 and var_106_2 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_1 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_1
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_6 = math.max(var_106_2, arg_103_1.talkMaxDuration)

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_6 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_1) / var_106_6

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_1 + var_106_6 and arg_103_1.time_ < var_106_1 + var_106_6 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play115201026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 115201026
		arg_107_1.duration_ = 4.77

		local var_107_0 = {
			ja = 4.766,
			ko = 4.466,
			zh = 3.033,
			en = 4.3
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play115201027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if arg_107_1.actors_["4010ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4010ui_story"))) then
				local var_110_0 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_107_1.stage_.transform)

				var_110_0.name = "4010ui_story"
				var_110_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_107_1.actors_["4010ui_story"] = var_110_0

				local var_110_1 = var_110_0:GetComponentInChildren(typeof(CharacterEffect))

				var_110_1.enabled = true

				local var_110_2 = GameObjectTools.GetOrAddComponent(var_110_0, typeof(DynamicBoneHelper))

				if var_110_2 then
					var_110_2:EnableDynamicBone(false)
				end

				arg_107_1:ShowWeapon(var_110_1.transform, false)

				arg_107_1.var_["4010ui_story" .. "Animator"] = var_110_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_107_1.var_["4010ui_story" .. "Animator"].applyRootMotion = true
				arg_107_1.var_["4010ui_story" .. "LipSync"] = var_110_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_110_3 = arg_107_1.actors_["4010ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos4010ui_story = var_110_3.localPosition
			end

			local var_110_4 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				var_110_3.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_107_1.time_ - 0) / var_110_4)
				var_110_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_3.position).x, (manager.ui.mainCamera.transform.position - var_110_3.position).y, (manager.ui.mainCamera.transform.position - var_110_3.position).z)
				var_110_3.localEulerAngles.z = 0
				var_110_3.localEulerAngles.x = 0
				var_110_3.localEulerAngles = var_110_3.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				var_110_3.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				var_110_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_3.position).x, (manager.ui.mainCamera.transform.position - var_110_3.position).y, (manager.ui.mainCamera.transform.position - var_110_3.position).z)
				var_110_3.localEulerAngles.z = 0
				var_110_3.localEulerAngles.x = 0
				var_110_3.localEulerAngles = var_110_3.localEulerAngles
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_110_5 = arg_107_1.actors_["4010ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_5) and arg_107_1.var_.characterEffect4010ui_story == nil then
				arg_107_1.var_.characterEffect4010ui_story = var_110_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_6 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_6 and not isNil(var_110_5) then
				if arg_107_1.var_.characterEffect4010ui_story and not isNil(var_110_5) then
					arg_107_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_6 and arg_107_1.time_ < 0 + var_110_6 + arg_110_0 and not isNil(var_110_5) and arg_107_1.var_.characterEffect4010ui_story then
				arg_107_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_110_8 = 0
			local var_110_9 = 0.325

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(115201026)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_13 = 13 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 13)

				if (13 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 13)) > 0 and var_110_9 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_8
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201026", "story_v_out_115201.awb") ~= 0 then
					local var_110_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201026", "story_v_out_115201.awb") / 1000

					if var_110_14 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_8
					end

					if var_110_10.prefab_name ~= "" and arg_107_1.actors_[var_110_10.prefab_name] ~= nil then
						local var_110_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_10.prefab_name].transform, "story_v_out_115201", "115201026", "story_v_out_115201.awb")

						arg_107_1:RecordAudio("115201026", var_110_15)
						arg_107_1:RecordAudio("115201026", var_110_15)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_115201", "115201026", "story_v_out_115201.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_115201", "115201026", "story_v_out_115201.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_16 = math.max(var_110_9, arg_107_1.talkMaxDuration)

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_16 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_8) / var_110_16

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_8 + var_110_16 and arg_107_1.time_ < var_110_8 + var_110_16 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play115201027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 115201027
		arg_111_1.duration_ = 5.97

		local var_111_0 = {
			ja = 4.333,
			ko = 4.666,
			zh = 5.966,
			en = 4.3
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play115201028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1052ui_story = arg_111_1.actors_["1052ui_story"].transform.localPosition

				arg_111_1:ShowWeapon(arg_111_1.var_["1052ui_story" .. "Animator"].transform, false)
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1052ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1052ui_story"].transform.position).z)
				arg_111_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1052ui_story"].transform.localEulerAngles = arg_111_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.2)
				arg_111_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1052ui_story"].transform.position).z)
				arg_111_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1052ui_story"].transform.localEulerAngles = arg_111_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_114_1 = arg_111_1.actors_["1052ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect1052ui_story == nil then
				arg_111_1.var_.characterEffect1052ui_story = var_114_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 and not isNil(var_114_1) then
				if arg_111_1.var_.characterEffect1052ui_story and not isNil(var_114_1) then
					arg_111_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect1052ui_story then
				arg_111_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_114_4 = arg_111_1.actors_["4010ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_4) and arg_111_1.var_.characterEffect4010ui_story == nil then
				arg_111_1.var_.characterEffect4010ui_story = var_114_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_5 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_5 and not isNil(var_114_4) then
				if arg_111_1.var_.characterEffect4010ui_story and not isNil(var_114_4) then
					arg_111_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_111_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_5)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_5 and arg_111_1.time_ < 0 + var_114_5 + arg_114_0 and not isNil(var_114_4) and arg_111_1.var_.characterEffect4010ui_story then
				arg_111_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_111_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_114_6 = 0
			local var_114_7 = 0.375

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_8 = arg_111_1:GetWordFromCfg(115201027)
				local var_114_9 = arg_111_1:FormatText(var_114_8.content)

				arg_111_1.text_.text = var_114_9

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 15 <= 0 and var_114_7 or var_114_7 * (utf8.len(var_114_9) / 15)

				if (15 <= 0 and var_114_7 or var_114_7 * (utf8.len(var_114_9) / 15)) > 0 and var_114_7 < var_114_11 then
					arg_111_1.talkMaxDuration = var_114_11

					if var_114_11 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_9
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201027", "story_v_out_115201.awb") ~= 0 then
					local var_114_12 = manager.audio:GetVoiceLength("story_v_out_115201", "115201027", "story_v_out_115201.awb") / 1000

					if var_114_12 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_12 + var_114_6
					end

					if var_114_8.prefab_name ~= "" and arg_111_1.actors_[var_114_8.prefab_name] ~= nil then
						local var_114_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_8.prefab_name].transform, "story_v_out_115201", "115201027", "story_v_out_115201.awb")

						arg_111_1:RecordAudio("115201027", var_114_13)
						arg_111_1:RecordAudio("115201027", var_114_13)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_115201", "115201027", "story_v_out_115201.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_115201", "115201027", "story_v_out_115201.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_14 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_14 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_14

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_14 and arg_111_1.time_ < var_114_6 + var_114_14 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play115201028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 115201028
		arg_115_1.duration_ = 8.43

		local var_115_0 = {
			ja = 7.3,
			ko = 7.066,
			zh = 6.466,
			en = 8.433
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play115201029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_118_0 = arg_115_1.actors_["4010ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect4010ui_story == nil then
				arg_115_1.var_.characterEffect4010ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_1 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 and not isNil(var_118_0) then
				if arg_115_1.var_.characterEffect4010ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect4010ui_story then
				arg_115_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_118_3 = arg_115_1.actors_["1052ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_3) and arg_115_1.var_.characterEffect1052ui_story == nil then
				arg_115_1.var_.characterEffect1052ui_story = var_118_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_4 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 and not isNil(var_118_3) then
				if arg_115_1.var_.characterEffect1052ui_story and not isNil(var_118_3) then
					arg_115_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_4)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 and not isNil(var_118_3) and arg_115_1.var_.characterEffect1052ui_story then
				arg_115_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_118_5 = 0
			local var_118_6 = 0.775

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_7 = arg_115_1:GetWordFromCfg(115201028)
				local var_118_8 = arg_115_1:FormatText(var_118_7.content)

				arg_115_1.text_.text = var_118_8

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_10 = 31 <= 0 and var_118_6 or var_118_6 * (utf8.len(var_118_8) / 31)

				if (31 <= 0 and var_118_6 or var_118_6 * (utf8.len(var_118_8) / 31)) > 0 and var_118_6 < var_118_10 then
					arg_115_1.talkMaxDuration = var_118_10

					if var_118_10 + var_118_5 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_5
					end
				end

				arg_115_1.text_.text = var_118_8
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201028", "story_v_out_115201.awb") ~= 0 then
					local var_118_11 = manager.audio:GetVoiceLength("story_v_out_115201", "115201028", "story_v_out_115201.awb") / 1000

					if var_118_11 + var_118_5 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_11 + var_118_5
					end

					if var_118_7.prefab_name ~= "" and arg_115_1.actors_[var_118_7.prefab_name] ~= nil then
						local var_118_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_7.prefab_name].transform, "story_v_out_115201", "115201028", "story_v_out_115201.awb")

						arg_115_1:RecordAudio("115201028", var_118_12)
						arg_115_1:RecordAudio("115201028", var_118_12)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_115201", "115201028", "story_v_out_115201.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_115201", "115201028", "story_v_out_115201.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_13 = math.max(var_118_6, arg_115_1.talkMaxDuration)

			if var_118_5 <= arg_115_1.time_ and arg_115_1.time_ < var_118_5 + var_118_13 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_5) / var_118_13

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_5 + var_118_13 and arg_115_1.time_ < var_118_5 + var_118_13 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play115201029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 115201029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play115201030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["4010ui_story"]) and arg_119_1.var_.characterEffect4010ui_story == nil then
				arg_119_1.var_.characterEffect4010ui_story = arg_119_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["4010ui_story"]) then
				if arg_119_1.var_.characterEffect4010ui_story and not isNil(arg_119_1.actors_["4010ui_story"]) then
					arg_119_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_119_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["4010ui_story"]) and arg_119_1.var_.characterEffect4010ui_story then
				arg_119_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_119_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_122_1 = 0
			local var_122_2 = 0.95

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_3 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(115201029).content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 38 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 38)

				if (38 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 38)) > 0 and var_122_2 < var_122_5 then
					arg_119_1.talkMaxDuration = var_122_5

					if var_122_5 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + var_122_1
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_6 = math.max(var_122_2, arg_119_1.talkMaxDuration)

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_6 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_1) / var_122_6

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_1 + var_122_6 and arg_119_1.time_ < var_122_1 + var_122_6 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play115201030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 115201030
		arg_123_1.duration_ = 5.53

		local var_123_0 = {
			ja = 5.533,
			ko = 3.5,
			zh = 3.266,
			en = 5.366
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play115201031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_126_0 = arg_123_1.actors_["1052ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1052ui_story == nil then
				arg_123_1.var_.characterEffect1052ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_1 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 and not isNil(var_126_0) then
				if arg_123_1.var_.characterEffect1052ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1052ui_story then
				arg_123_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_126_3 = 0
			local var_126_4 = 0.325

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_3 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_5 = arg_123_1:GetWordFromCfg(115201030)
				local var_126_6 = arg_123_1:FormatText(var_126_5.content)

				arg_123_1.text_.text = var_126_6

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_8 = 13 <= 0 and var_126_4 or var_126_4 * (utf8.len(var_126_6) / 13)

				if (13 <= 0 and var_126_4 or var_126_4 * (utf8.len(var_126_6) / 13)) > 0 and var_126_4 < var_126_8 then
					arg_123_1.talkMaxDuration = var_126_8

					if var_126_8 + var_126_3 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_3
					end
				end

				arg_123_1.text_.text = var_126_6
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201030", "story_v_out_115201.awb") ~= 0 then
					local var_126_9 = manager.audio:GetVoiceLength("story_v_out_115201", "115201030", "story_v_out_115201.awb") / 1000

					if var_126_9 + var_126_3 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_3
					end

					if var_126_5.prefab_name ~= "" and arg_123_1.actors_[var_126_5.prefab_name] ~= nil then
						local var_126_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_5.prefab_name].transform, "story_v_out_115201", "115201030", "story_v_out_115201.awb")

						arg_123_1:RecordAudio("115201030", var_126_10)
						arg_123_1:RecordAudio("115201030", var_126_10)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_115201", "115201030", "story_v_out_115201.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_115201", "115201030", "story_v_out_115201.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_11 = math.max(var_126_4, arg_123_1.talkMaxDuration)

			if var_126_3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_3 + var_126_11 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_3) / var_126_11

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_3 + var_126_11 and arg_123_1.time_ < var_126_3 + var_126_11 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play115201031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 115201031
		arg_127_1.duration_ = 12.6

		local var_127_0 = {
			ja = 12.6,
			ko = 8.733,
			zh = 6.733,
			en = 8.6
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play115201032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_130_0 = arg_127_1.actors_["4010ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect4010ui_story == nil then
				arg_127_1.var_.characterEffect4010ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_1 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_1 and not isNil(var_130_0) then
				if arg_127_1.var_.characterEffect4010ui_story and not isNil(var_130_0) then
					arg_127_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_1 and arg_127_1.time_ < 0 + var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect4010ui_story then
				arg_127_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_130_3 = arg_127_1.actors_["1052ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_3) and arg_127_1.var_.characterEffect1052ui_story == nil then
				arg_127_1.var_.characterEffect1052ui_story = var_130_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_4 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 and not isNil(var_130_3) then
				if arg_127_1.var_.characterEffect1052ui_story and not isNil(var_130_3) then
					arg_127_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_4)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 and not isNil(var_130_3) and arg_127_1.var_.characterEffect1052ui_story then
				arg_127_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_130_5 = 0
			local var_130_6 = 0.7

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_7 = arg_127_1:GetWordFromCfg(115201031)
				local var_130_8 = arg_127_1:FormatText(var_130_7.content)

				arg_127_1.text_.text = var_130_8

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 28 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 28)

				if (28 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 28)) > 0 and var_130_6 < var_130_10 then
					arg_127_1.talkMaxDuration = var_130_10

					if var_130_10 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_5
					end
				end

				arg_127_1.text_.text = var_130_8
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201031", "story_v_out_115201.awb") ~= 0 then
					local var_130_11 = manager.audio:GetVoiceLength("story_v_out_115201", "115201031", "story_v_out_115201.awb") / 1000

					if var_130_11 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_5
					end

					if var_130_7.prefab_name ~= "" and arg_127_1.actors_[var_130_7.prefab_name] ~= nil then
						local var_130_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_7.prefab_name].transform, "story_v_out_115201", "115201031", "story_v_out_115201.awb")

						arg_127_1:RecordAudio("115201031", var_130_12)
						arg_127_1:RecordAudio("115201031", var_130_12)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_115201", "115201031", "story_v_out_115201.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_115201", "115201031", "story_v_out_115201.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_13 = math.max(var_130_6, arg_127_1.talkMaxDuration)

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_13 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_5) / var_130_13

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_5 + var_130_13 and arg_127_1.time_ < var_130_5 + var_130_13 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play115201032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 115201032
		arg_131_1.duration_ = 20.63

		local var_131_0 = {
			ja = 11.833,
			ko = 15.1,
			zh = 14.833,
			en = 20.633
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play115201033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1052ui_story = arg_131_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1052ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1052ui_story"].transform.position).z)
				arg_131_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1052ui_story"].transform.localEulerAngles = arg_131_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1052ui_story"].transform.position).z)
				arg_131_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1052ui_story"].transform.localEulerAngles = arg_131_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["4010ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos4010ui_story = var_134_1.localPosition
			end

			local var_134_2 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 then
				var_134_1.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_2)
				var_134_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_1.position).x, (manager.ui.mainCamera.transform.position - var_134_1.position).y, (manager.ui.mainCamera.transform.position - var_134_1.position).z)
				var_134_1.localEulerAngles.z = 0
				var_134_1.localEulerAngles.x = 0
				var_134_1.localEulerAngles = var_134_1.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 then
				var_134_1.localPosition = Vector3.New(0, 100, 0)
				var_134_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_1.position).x, (manager.ui.mainCamera.transform.position - var_134_1.position).y, (manager.ui.mainCamera.transform.position - var_134_1.position).z)
				var_134_1.localEulerAngles.z = 0
				var_134_1.localEulerAngles.x = 0
				var_134_1.localEulerAngles = var_134_1.localEulerAngles
			end

			local var_134_3 = arg_131_1.actors_["1024ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1024ui_story = var_134_3.localPosition

				arg_131_1:ShowWeapon(arg_131_1.var_["1024ui_story" .. "Animator"].transform, true)
			end

			local var_134_4 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				var_134_3.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_131_1.time_ - 0) / var_134_4)
				var_134_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_3.position).x, (manager.ui.mainCamera.transform.position - var_134_3.position).y, (manager.ui.mainCamera.transform.position - var_134_3.position).z)
				var_134_3.localEulerAngles.z = 0
				var_134_3.localEulerAngles.x = 0
				var_134_3.localEulerAngles = var_134_3.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				var_134_3.localPosition = Vector3.New(0, -1, -6.05)
				var_134_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_3.position).x, (manager.ui.mainCamera.transform.position - var_134_3.position).y, (manager.ui.mainCamera.transform.position - var_134_3.position).z)
				var_134_3.localEulerAngles.z = 0
				var_134_3.localEulerAngles.x = 0
				var_134_3.localEulerAngles = var_134_3.localEulerAngles
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action7_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_134_5 = arg_131_1.actors_["1024ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.characterEffect1024ui_story == nil then
				arg_131_1.var_.characterEffect1024ui_story = var_134_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_6 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_6 and not isNil(var_134_5) then
				if arg_131_1.var_.characterEffect1024ui_story and not isNil(var_134_5) then
					arg_131_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_6 and arg_131_1.time_ < 0 + var_134_6 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.characterEffect1024ui_story then
				arg_131_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_134_8 = 0
			local var_134_9 = 1.75

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_10 = arg_131_1:GetWordFromCfg(115201032)
				local var_134_11 = arg_131_1:FormatText(var_134_10.content)

				arg_131_1.text_.text = var_134_11

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_13 = 70 <= 0 and var_134_9 or var_134_9 * (utf8.len(var_134_11) / 70)

				if (70 <= 0 and var_134_9 or var_134_9 * (utf8.len(var_134_11) / 70)) > 0 and var_134_9 < var_134_13 then
					arg_131_1.talkMaxDuration = var_134_13

					if var_134_13 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_13 + var_134_8
					end
				end

				arg_131_1.text_.text = var_134_11
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201032", "story_v_out_115201.awb") ~= 0 then
					local var_134_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201032", "story_v_out_115201.awb") / 1000

					if var_134_14 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_8
					end

					if var_134_10.prefab_name ~= "" and arg_131_1.actors_[var_134_10.prefab_name] ~= nil then
						local var_134_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_10.prefab_name].transform, "story_v_out_115201", "115201032", "story_v_out_115201.awb")

						arg_131_1:RecordAudio("115201032", var_134_15)
						arg_131_1:RecordAudio("115201032", var_134_15)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_115201", "115201032", "story_v_out_115201.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_115201", "115201032", "story_v_out_115201.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_16 = math.max(var_134_9, arg_131_1.talkMaxDuration)

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_16 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_8) / var_134_16

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_8 + var_134_16 and arg_131_1.time_ < var_134_8 + var_134_16 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play115201033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 115201033
		arg_135_1.duration_ = 5.73

		local var_135_0 = {
			ja = 5.733,
			ko = 5.433,
			zh = 5.2,
			en = 4.066
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play115201034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if arg_135_1.actors_["1035ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1035ui_story"))) then
				local var_138_0 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_135_1.stage_.transform)

				var_138_0.name = "1035ui_story"
				var_138_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.actors_["1035ui_story"] = var_138_0

				local var_138_1 = var_138_0:GetComponentInChildren(typeof(CharacterEffect))

				var_138_1.enabled = true

				local var_138_2 = GameObjectTools.GetOrAddComponent(var_138_0, typeof(DynamicBoneHelper))

				if var_138_2 then
					var_138_2:EnableDynamicBone(false)
				end

				arg_135_1:ShowWeapon(var_138_1.transform, false)

				arg_135_1.var_["1035ui_story" .. "Animator"] = var_138_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_135_1.var_["1035ui_story" .. "Animator"].applyRootMotion = true
				arg_135_1.var_["1035ui_story" .. "LipSync"] = var_138_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_138_3 = arg_135_1.actors_["1035ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1035ui_story = var_138_3.localPosition
			end

			local var_138_4 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				var_138_3.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_135_1.time_ - 0) / var_138_4)
				var_138_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_3.position).x, (manager.ui.mainCamera.transform.position - var_138_3.position).y, (manager.ui.mainCamera.transform.position - var_138_3.position).z)
				var_138_3.localEulerAngles.z = 0
				var_138_3.localEulerAngles.x = 0
				var_138_3.localEulerAngles = var_138_3.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				var_138_3.localPosition = Vector3.New(0, -1.05, -5.6)
				var_138_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_3.position).x, (manager.ui.mainCamera.transform.position - var_138_3.position).y, (manager.ui.mainCamera.transform.position - var_138_3.position).z)
				var_138_3.localEulerAngles.z = 0
				var_138_3.localEulerAngles.x = 0
				var_138_3.localEulerAngles = var_138_3.localEulerAngles
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action6_1")
			end

			local var_138_5 = arg_135_1.actors_["1035ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.characterEffect1035ui_story == nil then
				arg_135_1.var_.characterEffect1035ui_story = var_138_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_6 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_6 and not isNil(var_138_5) then
				if arg_135_1.var_.characterEffect1035ui_story and not isNil(var_138_5) then
					arg_135_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_6 and arg_135_1.time_ < 0 + var_138_6 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.characterEffect1035ui_story then
				arg_135_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_138_8 = arg_135_1.actors_["1024ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1024ui_story = var_138_8.localPosition

				arg_135_1:ShowWeapon(arg_135_1.var_["1024ui_story" .. "Animator"].transform, true)
			end

			local var_138_9 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_9 then
				var_138_8.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_9)
				var_138_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_8.position).x, (manager.ui.mainCamera.transform.position - var_138_8.position).y, (manager.ui.mainCamera.transform.position - var_138_8.position).z)
				var_138_8.localEulerAngles.z = 0
				var_138_8.localEulerAngles.x = 0
				var_138_8.localEulerAngles = var_138_8.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_9 and arg_135_1.time_ < 0 + var_138_9 + arg_138_0 then
				var_138_8.localPosition = Vector3.New(0, 100, 0)
				var_138_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_8.position).x, (manager.ui.mainCamera.transform.position - var_138_8.position).y, (manager.ui.mainCamera.transform.position - var_138_8.position).z)
				var_138_8.localEulerAngles.z = 0
				var_138_8.localEulerAngles.x = 0
				var_138_8.localEulerAngles = var_138_8.localEulerAngles
			end

			local var_138_10 = 0
			local var_138_11 = 0.525

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_12 = arg_135_1:GetWordFromCfg(115201033)
				local var_138_13 = arg_135_1:FormatText(var_138_12.content)

				arg_135_1.text_.text = var_138_13

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_15 = 21 <= 0 and var_138_11 or var_138_11 * (utf8.len(var_138_13) / 21)

				if (21 <= 0 and var_138_11 or var_138_11 * (utf8.len(var_138_13) / 21)) > 0 and var_138_11 < var_138_15 then
					arg_135_1.talkMaxDuration = var_138_15

					if var_138_15 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_15 + var_138_10
					end
				end

				arg_135_1.text_.text = var_138_13
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201033", "story_v_out_115201.awb") ~= 0 then
					local var_138_16 = manager.audio:GetVoiceLength("story_v_out_115201", "115201033", "story_v_out_115201.awb") / 1000

					if var_138_16 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_10
					end

					if var_138_12.prefab_name ~= "" and arg_135_1.actors_[var_138_12.prefab_name] ~= nil then
						local var_138_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_12.prefab_name].transform, "story_v_out_115201", "115201033", "story_v_out_115201.awb")

						arg_135_1:RecordAudio("115201033", var_138_17)
						arg_135_1:RecordAudio("115201033", var_138_17)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_115201", "115201033", "story_v_out_115201.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_115201", "115201033", "story_v_out_115201.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_18 = math.max(var_138_11, arg_135_1.talkMaxDuration)

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_18 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_10) / var_138_18

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_10 + var_138_18 and arg_135_1.time_ < var_138_10 + var_138_18 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play115201034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 115201034
		arg_139_1.duration_ = 6.5

		local var_139_0 = {
			ja = 6.5,
			ko = 5.7,
			zh = 5.1,
			en = 6.266
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play115201035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1035ui_story = arg_139_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1035ui_story"].transform.position).z)
				arg_139_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1035ui_story"].transform.localEulerAngles = arg_139_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1035ui_story"].transform.position).z)
				arg_139_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1035ui_story"].transform.localEulerAngles = arg_139_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_142_1 = 0
			local var_142_2 = 0.575

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(115201034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_6 = 23 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_4) / 23)

				if (23 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_4) / 23)) > 0 and var_142_2 < var_142_6 then
					arg_139_1.talkMaxDuration = var_142_6

					if var_142_6 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201034", "story_v_out_115201.awb") ~= 0 then
					local var_142_7 = manager.audio:GetVoiceLength("story_v_out_115201", "115201034", "story_v_out_115201.awb") / 1000

					if var_142_7 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_1
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_115201", "115201034", "story_v_out_115201.awb")

						arg_139_1:RecordAudio("115201034", var_142_8)
						arg_139_1:RecordAudio("115201034", var_142_8)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_115201", "115201034", "story_v_out_115201.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_115201", "115201034", "story_v_out_115201.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_9 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_9 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_9

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_9 and arg_139_1.time_ < var_142_1 + var_142_9 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play115201035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 115201035
		arg_143_1.duration_ = 16.3

		local var_143_0 = {
			ja = 15.8,
			ko = 14.8,
			zh = 13.2,
			en = 16.3
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play115201036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos4010ui_story = arg_143_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["4010ui_story"].transform.position).z)
				arg_143_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["4010ui_story"].transform.localEulerAngles = arg_143_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_143_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["4010ui_story"].transform.position).z)
				arg_143_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["4010ui_story"].transform.localEulerAngles = arg_143_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_146_1 = arg_143_1.actors_["4010ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect4010ui_story == nil then
				arg_143_1.var_.characterEffect4010ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect4010ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect4010ui_story then
				arg_143_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_146_4 = 0
			local var_146_5 = 1.175

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(115201035)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 47 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 47)

				if (47 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 47)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201035", "story_v_out_115201.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_out_115201", "115201035", "story_v_out_115201.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_out_115201", "115201035", "story_v_out_115201.awb")

						arg_143_1:RecordAudio("115201035", var_146_11)
						arg_143_1:RecordAudio("115201035", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_115201", "115201035", "story_v_out_115201.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_115201", "115201035", "story_v_out_115201.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play115201036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 115201036
		arg_147_1.duration_ = 6.07

		local var_147_0 = {
			ja = 6.066,
			ko = 4.033,
			zh = 3.6,
			en = 3.6
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play115201037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_1")
			end

			local var_150_0 = 0
			local var_150_1 = 0.4

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:GetWordFromCfg(115201036)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 17 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_3) / 17)

				if (17 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_3) / 17)) > 0 and var_150_1 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201036", "story_v_out_115201.awb") ~= 0 then
					local var_150_6 = manager.audio:GetVoiceLength("story_v_out_115201", "115201036", "story_v_out_115201.awb") / 1000

					if var_150_6 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_0
					end

					if var_150_2.prefab_name ~= "" and arg_147_1.actors_[var_150_2.prefab_name] ~= nil then
						local var_150_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_2.prefab_name].transform, "story_v_out_115201", "115201036", "story_v_out_115201.awb")

						arg_147_1:RecordAudio("115201036", var_150_7)
						arg_147_1:RecordAudio("115201036", var_150_7)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_115201", "115201036", "story_v_out_115201.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_115201", "115201036", "story_v_out_115201.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_8 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_8 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_8

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_8 and arg_147_1.time_ < var_150_0 + var_150_8 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play115201037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 115201037
		arg_151_1.duration_ = 2.1

		local var_151_0 = {
			ja = 1.633,
			ko = 1.266,
			zh = 1.6,
			en = 2.1
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play115201038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["4010ui_story"]) and arg_151_1.var_.characterEffect4010ui_story == nil then
				arg_151_1.var_.characterEffect4010ui_story = arg_151_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["4010ui_story"]) then
				if arg_151_1.var_.characterEffect4010ui_story and not isNil(arg_151_1.actors_["4010ui_story"]) then
					arg_151_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_151_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["4010ui_story"]) and arg_151_1.var_.characterEffect4010ui_story then
				arg_151_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_151_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_154_1 = 0
			local var_154_2 = 0.05

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1016")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:GetWordFromCfg(115201037)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_6 = 2 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_4) / 2)

				if (2 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_4) / 2)) > 0 and var_154_2 < var_154_6 then
					arg_151_1.talkMaxDuration = var_154_6

					if var_154_6 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_1
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201037", "story_v_out_115201.awb") ~= 0 then
					local var_154_7 = manager.audio:GetVoiceLength("story_v_out_115201", "115201037", "story_v_out_115201.awb") / 1000

					if var_154_7 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_1
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_115201", "115201037", "story_v_out_115201.awb")

						arg_151_1:RecordAudio("115201037", var_154_8)
						arg_151_1:RecordAudio("115201037", var_154_8)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_115201", "115201037", "story_v_out_115201.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_115201", "115201037", "story_v_out_115201.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_9 = math.max(var_154_2, arg_151_1.talkMaxDuration)

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_9 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_1) / var_154_9

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_1 + var_154_9 and arg_151_1.time_ < var_154_1 + var_154_9 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play115201038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 115201038
		arg_155_1.duration_ = 10.2

		local var_155_0 = {
			ja = 9,
			ko = 6.5,
			zh = 6.433,
			en = 10.2
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play115201039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_2")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_158_0 = arg_155_1.actors_["4010ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect4010ui_story == nil then
				arg_155_1.var_.characterEffect4010ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_1 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 and not isNil(var_158_0) then
				if arg_155_1.var_.characterEffect4010ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect4010ui_story then
				arg_155_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_158_3 = 0
			local var_158_4 = 0.8

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_3 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_5 = arg_155_1:GetWordFromCfg(115201038)
				local var_158_6 = arg_155_1:FormatText(var_158_5.content)

				arg_155_1.text_.text = var_158_6

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_8 = 32 <= 0 and var_158_4 or var_158_4 * (utf8.len(var_158_6) / 32)

				if (32 <= 0 and var_158_4 or var_158_4 * (utf8.len(var_158_6) / 32)) > 0 and var_158_4 < var_158_8 then
					arg_155_1.talkMaxDuration = var_158_8

					if var_158_8 + var_158_3 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_3
					end
				end

				arg_155_1.text_.text = var_158_6
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201038", "story_v_out_115201.awb") ~= 0 then
					local var_158_9 = manager.audio:GetVoiceLength("story_v_out_115201", "115201038", "story_v_out_115201.awb") / 1000

					if var_158_9 + var_158_3 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_3
					end

					if var_158_5.prefab_name ~= "" and arg_155_1.actors_[var_158_5.prefab_name] ~= nil then
						local var_158_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_5.prefab_name].transform, "story_v_out_115201", "115201038", "story_v_out_115201.awb")

						arg_155_1:RecordAudio("115201038", var_158_10)
						arg_155_1:RecordAudio("115201038", var_158_10)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_115201", "115201038", "story_v_out_115201.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_115201", "115201038", "story_v_out_115201.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_11 = math.max(var_158_4, arg_155_1.talkMaxDuration)

			if var_158_3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_3 + var_158_11 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_3) / var_158_11

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_3 + var_158_11 and arg_155_1.time_ < var_158_3 + var_158_11 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play115201039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 115201039
		arg_159_1.duration_ = 8.67

		local var_159_0 = {
			ja = 6.1,
			ko = 8.666,
			zh = 5.833,
			en = 7.4
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play115201040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_162_0 = 0
			local var_162_1 = 0.8

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_2 = arg_159_1:GetWordFromCfg(115201039)
				local var_162_3 = arg_159_1:FormatText(var_162_2.content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 32 <= 0 and var_162_1 or var_162_1 * (utf8.len(var_162_3) / 32)

				if (32 <= 0 and var_162_1 or var_162_1 * (utf8.len(var_162_3) / 32)) > 0 and var_162_1 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201039", "story_v_out_115201.awb") ~= 0 then
					local var_162_6 = manager.audio:GetVoiceLength("story_v_out_115201", "115201039", "story_v_out_115201.awb") / 1000

					if var_162_6 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_0
					end

					if var_162_2.prefab_name ~= "" and arg_159_1.actors_[var_162_2.prefab_name] ~= nil then
						local var_162_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_2.prefab_name].transform, "story_v_out_115201", "115201039", "story_v_out_115201.awb")

						arg_159_1:RecordAudio("115201039", var_162_7)
						arg_159_1:RecordAudio("115201039", var_162_7)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_115201", "115201039", "story_v_out_115201.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_115201", "115201039", "story_v_out_115201.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_8 and arg_159_1.time_ < var_162_0 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play115201040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 115201040
		arg_163_1.duration_ = 6.13

		local var_163_0 = {
			ja = 2.9,
			ko = 6.133,
			zh = 5.133,
			en = 5.8
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play115201041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos4010ui_story = arg_163_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["4010ui_story"].transform.position).z)
				arg_163_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["4010ui_story"].transform.localEulerAngles = arg_163_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["4010ui_story"].transform.position).z)
				arg_163_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["4010ui_story"].transform.localEulerAngles = arg_163_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_166_1 = 0
			local var_166_2 = 0.625

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[261].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:GetWordFromCfg(115201040)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_6 = 25 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_4) / 25)

				if (25 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_4) / 25)) > 0 and var_166_2 < var_166_6 then
					arg_163_1.talkMaxDuration = var_166_6

					if var_166_6 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201040", "story_v_out_115201.awb") ~= 0 then
					local var_166_7 = manager.audio:GetVoiceLength("story_v_out_115201", "115201040", "story_v_out_115201.awb") / 1000

					if var_166_7 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_1
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_115201", "115201040", "story_v_out_115201.awb")

						arg_163_1:RecordAudio("115201040", var_166_8)
						arg_163_1:RecordAudio("115201040", var_166_8)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_115201", "115201040", "story_v_out_115201.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_115201", "115201040", "story_v_out_115201.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_9 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_9 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_9

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_9 and arg_163_1.time_ < var_166_1 + var_166_9 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play115201041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 115201041
		arg_167_1.duration_ = 4.7

		local var_167_0 = {
			ja = 4.7,
			ko = 3.3,
			zh = 3.766,
			en = 4.166
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play115201042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.35

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[262].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:GetWordFromCfg(115201041)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 14 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 14)

				if (14 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 14)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201041", "story_v_out_115201.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201041", "story_v_out_115201.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_115201", "115201041", "story_v_out_115201.awb")

						arg_167_1:RecordAudio("115201041", var_170_6)
						arg_167_1:RecordAudio("115201041", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_115201", "115201041", "story_v_out_115201.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_115201", "115201041", "story_v_out_115201.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play115201042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 115201042
		arg_171_1.duration_ = 7.9

		local var_171_0 = {
			ja = 4.9,
			ko = 6.433,
			zh = 5.1,
			en = 7.9
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play115201043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1035ui_story = arg_171_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1035ui_story"].transform.position).z)
				arg_171_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1035ui_story"].transform.localEulerAngles = arg_171_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, -1.05, -5.6)
				arg_171_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1035ui_story"].transform.position).z)
				arg_171_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1035ui_story"].transform.localEulerAngles = arg_171_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action6_1")
			end

			local var_174_1 = arg_171_1.actors_["1035ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1035ui_story == nil then
				arg_171_1.var_.characterEffect1035ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect1035ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1035ui_story then
				arg_171_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_174_4 = 0
			local var_174_5 = 0.575

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:GetWordFromCfg(115201042)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 23 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 23)

				if (23 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 23)) > 0 and var_174_5 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201042", "story_v_out_115201.awb") ~= 0 then
					local var_174_10 = manager.audio:GetVoiceLength("story_v_out_115201", "115201042", "story_v_out_115201.awb") / 1000

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end

					if var_174_6.prefab_name ~= "" and arg_171_1.actors_[var_174_6.prefab_name] ~= nil then
						local var_174_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_6.prefab_name].transform, "story_v_out_115201", "115201042", "story_v_out_115201.awb")

						arg_171_1:RecordAudio("115201042", var_174_11)
						arg_171_1:RecordAudio("115201042", var_174_11)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_115201", "115201042", "story_v_out_115201.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_115201", "115201042", "story_v_out_115201.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_12 = math.max(var_174_5, arg_171_1.talkMaxDuration)

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_12 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_4) / var_174_12

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_4 + var_174_12 and arg_171_1.time_ < var_174_4 + var_174_12 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play115201043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 115201043
		arg_175_1.duration_ = 1.6

		local var_175_0 = {
			ja = 1.6,
			ko = 1.2,
			zh = 1.433,
			en = 1.4
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play115201044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1035ui_story = arg_175_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1035ui_story"].transform.position).z)
				arg_175_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1035ui_story"].transform.localEulerAngles = arg_175_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1035ui_story"].transform.position).z)
				arg_175_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1035ui_story"].transform.localEulerAngles = arg_175_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_178_1 = 0
			local var_178_2 = 0.125

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(115201043)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_6 = 5 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_4) / 5)

				if (5 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_4) / 5)) > 0 and var_178_2 < var_178_6 then
					arg_175_1.talkMaxDuration = var_178_6

					if var_178_6 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_6 + var_178_1
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201043", "story_v_out_115201.awb") ~= 0 then
					local var_178_7 = manager.audio:GetVoiceLength("story_v_out_115201", "115201043", "story_v_out_115201.awb") / 1000

					if var_178_7 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_1
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_115201", "115201043", "story_v_out_115201.awb")

						arg_175_1:RecordAudio("115201043", var_178_8)
						arg_175_1:RecordAudio("115201043", var_178_8)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_115201", "115201043", "story_v_out_115201.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_115201", "115201043", "story_v_out_115201.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_9 = math.max(var_178_2, arg_175_1.talkMaxDuration)

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_9 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_1) / var_178_9

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_1 + var_178_9 and arg_175_1.time_ < var_178_1 + var_178_9 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play115201044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 115201044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play115201045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.85

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(115201044).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 34 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 34)

				if (34 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 34)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play115201045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 115201045
		arg_183_1.duration_ = 15.33

		local var_183_0 = {
			ja = 15.333,
			ko = 9.433,
			zh = 7.566,
			en = 8.366
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play115201046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_0 = 2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				local var_186_1 = Color.New(0, 0, 0)

				var_186_1.a = Mathf.Lerp(0, 1, (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.mask_.color = var_186_1
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				local var_186_2 = Color.New(0, 0, 0)

				var_186_2.a = 1
				arg_183_1.mask_.color = var_186_2
			end

			local var_186_3 = 2

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_4 = 2

			if var_186_3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_3 + var_186_4 then
				local var_186_5 = Color.New(0, 0, 0)

				var_186_5.a = Mathf.Lerp(1, 0, (arg_183_1.time_ - var_186_3) / var_186_4)
				arg_183_1.mask_.color = var_186_5
			end

			if arg_183_1.time_ >= var_186_3 + var_186_4 and arg_183_1.time_ < var_186_3 + var_186_4 + arg_186_0 then
				local var_186_6 = Color.New(0, 0, 0)

				arg_183_1.mask_.enabled = false
				var_186_6.a = 0
				arg_183_1.mask_.color = var_186_6
			end

			local var_186_7 = "RO0206"

			if arg_183_1.bgs_.RO0206 == nil then
				local var_186_8 = Object.Instantiate(arg_183_1.paintGo_)

				var_186_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_186_7)
				var_186_8.name = var_186_7
				var_186_8.transform.parent = arg_183_1.stage_.transform
				var_186_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.bgs_[var_186_7] = var_186_8
			end

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= 2 + arg_186_0 then
				local var_186_9 = arg_183_1.bgs_.RO0206

				arg_183_1.bgs_.RO0206.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_186_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_10 = var_186_9:GetComponent("SpriteRenderer")

				if var_186_10 and var_186_10.sprite then
					local var_186_11 = 2 * (var_186_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_186_9.transform.localScale = Vector3.New(var_186_11 / var_186_10.sprite.bounds.size.y < var_186_11 * manager.ui.mainCameraCom_.aspect / var_186_10.sprite.bounds.size.x and var_186_11 * manager.ui.mainCameraCom_.aspect / var_186_10.sprite.bounds.size.x or var_186_11 / var_186_10.sprite.bounds.size.y, var_186_11 / var_186_10.sprite.bounds.size.y < var_186_11 * manager.ui.mainCameraCom_.aspect / var_186_10.sprite.bounds.size.x and var_186_11 * manager.ui.mainCameraCom_.aspect / var_186_10.sprite.bounds.size.x or var_186_11 / var_186_10.sprite.bounds.size.y, 0)
				end

				for iter_186_0, iter_186_1 in pairs(arg_183_1.bgs_) do
					if iter_186_0 ~= "RO0206" then
						iter_186_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_12 = arg_183_1.bgs_.RO0206.transform

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= 2 + arg_186_0 then
				arg_183_1.var_.moveOldPosRO0206 = var_186_12.localPosition
			end

			local var_186_13 = 0.001

			if 2 <= arg_183_1.time_ and arg_183_1.time_ < 2 + var_186_13 then
				var_186_12.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPosRO0206, Vector3.New(3, 1.65, 4.9), (arg_183_1.time_ - 2) / var_186_13)
			end

			if arg_183_1.time_ >= 2 + var_186_13 and arg_183_1.time_ < 2 + var_186_13 + arg_186_0 then
				var_186_12.localPosition = Vector3.New(3, 1.65, 4.9)
			end

			local var_186_14 = arg_183_1.bgs_.RO0206.transform

			if 2.01666666666667 < arg_183_1.time_ and arg_183_1.time_ <= 2.01666666666667 + arg_186_0 then
				arg_183_1.var_.moveOldPosRO0206 = var_186_14.localPosition
			end

			local var_186_15 = 5

			if 2.01666666666667 <= arg_183_1.time_ and arg_183_1.time_ < 2.01666666666667 + var_186_15 then
				var_186_14.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPosRO0206, Vector3.New(2.5, 1.65, 4.9), (arg_183_1.time_ - 2.01666666666667) / var_186_15)
			end

			if arg_183_1.time_ >= 2.01666666666667 + var_186_15 and arg_183_1.time_ < 2.01666666666667 + var_186_15 + arg_186_0 then
				var_186_14.localPosition = Vector3.New(2.5, 1.65, 4.9)
			end

			local var_186_16 = 4

			if 4 < arg_183_1.time_ and arg_183_1.time_ <= var_186_16 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			if arg_183_1.time_ >= var_186_16 + 3.01666666666667 and arg_183_1.time_ < var_186_16 + 3.01666666666667 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_17 = 4
			local var_186_18 = 0.425

			if 4 < arg_183_1.time_ and arg_183_1.time_ <= var_186_17 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_19 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_19:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_20 = arg_183_1:GetWordFromCfg(115201045)
				local var_186_21 = arg_183_1:FormatText(var_186_20.content)

				arg_183_1.text_.text = var_186_21

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_23 = 17 <= 0 and var_186_18 or var_186_18 * (utf8.len(var_186_21) / 17)

				if (17 <= 0 and var_186_18 or var_186_18 * (utf8.len(var_186_21) / 17)) > 0 and var_186_18 < var_186_23 then
					arg_183_1.talkMaxDuration = var_186_23
					var_186_17 = var_186_17 + 0.3

					if var_186_23 + var_186_17 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_17
					end
				end

				arg_183_1.text_.text = var_186_21
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201045", "story_v_out_115201.awb") ~= 0 then
					local var_186_24 = manager.audio:GetVoiceLength("story_v_out_115201", "115201045", "story_v_out_115201.awb") / 1000

					if var_186_24 + var_186_17 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_24 + var_186_17
					end

					if var_186_20.prefab_name ~= "" and arg_183_1.actors_[var_186_20.prefab_name] ~= nil then
						local var_186_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_20.prefab_name].transform, "story_v_out_115201", "115201045", "story_v_out_115201.awb")

						arg_183_1:RecordAudio("115201045", var_186_25)
						arg_183_1:RecordAudio("115201045", var_186_25)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_115201", "115201045", "story_v_out_115201.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_115201", "115201045", "story_v_out_115201.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_26 = var_186_17 + 0.3
			local var_186_27 = math.max(var_186_18, arg_183_1.talkMaxDuration)

			if var_186_17 + 0.3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_26 + var_186_27 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_26) / var_186_27

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_26 + var_186_27 and arg_183_1.time_ < var_186_26 + var_186_27 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "RO0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "RO0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play115201046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 115201046
		arg_189_1.duration_ = 1.47

		local var_189_0 = {
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 1.466,
			en = 1.233
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play115201047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.1

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(115201046)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 4 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 4)

				if (4 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 4)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201046", "story_v_out_115201.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201046", "story_v_out_115201.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_115201", "115201046", "story_v_out_115201.awb")

						arg_189_1:RecordAudio("115201046", var_192_6)
						arg_189_1:RecordAudio("115201046", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_115201", "115201046", "story_v_out_115201.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_115201", "115201046", "story_v_out_115201.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play115201047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 115201047
		arg_193_1.duration_ = 11.37

		local var_193_0 = {
			ja = 11.366,
			ko = 8.3,
			zh = 9.233,
			en = 7.433
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play115201048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 1.025

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:GetWordFromCfg(115201047)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 41 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 41)

				if (41 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 41)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201047", "story_v_out_115201.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201047", "story_v_out_115201.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_115201", "115201047", "story_v_out_115201.awb")

						arg_193_1:RecordAudio("115201047", var_196_6)
						arg_193_1:RecordAudio("115201047", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_115201", "115201047", "story_v_out_115201.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_115201", "115201047", "story_v_out_115201.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play115201048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 115201048
		arg_197_1.duration_ = 2.8

		local var_197_0 = {
			ja = 2.8,
			ko = 2.466,
			zh = 2.6,
			en = 1.2
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play115201049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.3

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(115201048)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 12 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 12)

				if (12 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 12)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201048", "story_v_out_115201.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201048", "story_v_out_115201.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_115201", "115201048", "story_v_out_115201.awb")

						arg_197_1:RecordAudio("115201048", var_200_6)
						arg_197_1:RecordAudio("115201048", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_115201", "115201048", "story_v_out_115201.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_115201", "115201048", "story_v_out_115201.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play115201049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 115201049
		arg_201_1.duration_ = 1.5

		local var_201_0 = {
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 1.5,
			en = 1.033
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play115201050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.075

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:GetWordFromCfg(115201049)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 3 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 3)

				if (3 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 3)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201049", "story_v_out_115201.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201049", "story_v_out_115201.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_115201", "115201049", "story_v_out_115201.awb")

						arg_201_1:RecordAudio("115201049", var_204_6)
						arg_201_1:RecordAudio("115201049", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_115201", "115201049", "story_v_out_115201.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_115201", "115201049", "story_v_out_115201.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play115201050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 115201050
		arg_205_1.duration_ = 5.67

		local var_205_0 = {
			ja = 5.4,
			ko = 3.866,
			zh = 5.666,
			en = 3.133
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play115201051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.7

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(115201050)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 28 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 28)

				if (28 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 28)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201050", "story_v_out_115201.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201050", "story_v_out_115201.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_115201", "115201050", "story_v_out_115201.awb")

						arg_205_1:RecordAudio("115201050", var_208_6)
						arg_205_1:RecordAudio("115201050", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_115201", "115201050", "story_v_out_115201.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_115201", "115201050", "story_v_out_115201.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play115201051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 115201051
		arg_209_1.duration_ = 15.07

		local var_209_0 = {
			ja = 10.666,
			ko = 12.033,
			zh = 15.066,
			en = 13.466
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play115201052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 1.6

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:GetWordFromCfg(115201051)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 64 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 64)

				if (64 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 64)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201051", "story_v_out_115201.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201051", "story_v_out_115201.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_out_115201", "115201051", "story_v_out_115201.awb")

						arg_209_1:RecordAudio("115201051", var_212_6)
						arg_209_1:RecordAudio("115201051", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_115201", "115201051", "story_v_out_115201.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_115201", "115201051", "story_v_out_115201.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play115201052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 115201052
		arg_213_1.duration_ = 13.73

		local var_213_0 = {
			ja = 13.733,
			ko = 11.2,
			zh = 10.533,
			en = 11.3
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play115201053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 1.1

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:GetWordFromCfg(115201052)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 43 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 43)

				if (43 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 43)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201052", "story_v_out_115201.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201052", "story_v_out_115201.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_115201", "115201052", "story_v_out_115201.awb")

						arg_213_1:RecordAudio("115201052", var_216_6)
						arg_213_1:RecordAudio("115201052", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_115201", "115201052", "story_v_out_115201.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_115201", "115201052", "story_v_out_115201.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play115201053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 115201053
		arg_217_1.duration_ = 11.63

		local var_217_0 = {
			ja = 11.633,
			ko = 3.533,
			zh = 4.933,
			en = 4.733
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play115201054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.575

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(115201053)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 23 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 23)

				if (23 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 23)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201053", "story_v_out_115201.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201053", "story_v_out_115201.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_115201", "115201053", "story_v_out_115201.awb")

						arg_217_1:RecordAudio("115201053", var_220_6)
						arg_217_1:RecordAudio("115201053", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_115201", "115201053", "story_v_out_115201.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_115201", "115201053", "story_v_out_115201.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play115201054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 115201054
		arg_221_1.duration_ = 13.7

		local var_221_0 = {
			ja = 13.7,
			ko = 7.433,
			zh = 7.266,
			en = 7.8
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play115201055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.85

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:GetWordFromCfg(115201054)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 34 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 34)

				if (34 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 34)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201054", "story_v_out_115201.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201054", "story_v_out_115201.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_115201", "115201054", "story_v_out_115201.awb")

						arg_221_1:RecordAudio("115201054", var_224_6)
						arg_221_1:RecordAudio("115201054", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_115201", "115201054", "story_v_out_115201.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_115201", "115201054", "story_v_out_115201.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play115201055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 115201055
		arg_225_1.duration_ = 4.1

		local var_225_0 = {
			ja = 4.1,
			ko = 1.833,
			zh = 1.3,
			en = 1.533
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play115201056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.1

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4010")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_1 = arg_225_1:GetWordFromCfg(115201055)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 4 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 4)

				if (4 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 4)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201055", "story_v_out_115201.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201055", "story_v_out_115201.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_115201", "115201055", "story_v_out_115201.awb")

						arg_225_1:RecordAudio("115201055", var_228_6)
						arg_225_1:RecordAudio("115201055", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_115201", "115201055", "story_v_out_115201.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_115201", "115201055", "story_v_out_115201.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play115201056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 115201056
		arg_229_1.duration_ = 1.73

		local var_229_0 = {
			ja = 1,
			ko = 0.999999999999,
			zh = 1.4,
			en = 1.733
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play115201057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.05

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:GetWordFromCfg(115201056)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 2 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 2)

				if (2 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 2)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201056", "story_v_out_115201.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201056", "story_v_out_115201.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_115201", "115201056", "story_v_out_115201.awb")

						arg_229_1:RecordAudio("115201056", var_232_6)
						arg_229_1:RecordAudio("115201056", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_115201", "115201056", "story_v_out_115201.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_115201", "115201056", "story_v_out_115201.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play115201057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 115201057
		arg_233_1.duration_ = 7

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play115201058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				local var_236_0 = arg_233_1.bgs_.RO0206:GetComponent("SpriteRenderer")

				if var_236_0 then
					arg_233_1.var_.alphaOldValueRO0206 = var_236_0.color.a
					arg_233_1.var_.alphaMatValueRO0206 = var_236_0
				end

				arg_233_1.var_.alphaOldValueRO0206 = 1
			end

			local var_236_1 = 2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_1 then
				if arg_233_1.var_.alphaMatValueRO0206 then
					arg_233_1.var_.alphaMatValueRO0206.color.a = Mathf.Lerp(arg_233_1.var_.alphaOldValueRO0206, 0, (arg_233_1.time_ - 0) / var_236_1)
					arg_233_1.var_.alphaMatValueRO0206.color = arg_233_1.var_.alphaMatValueRO0206.color
				end
			end

			if arg_233_1.time_ >= 0 + var_236_1 and arg_233_1.time_ < 0 + var_236_1 + arg_236_0 and arg_233_1.var_.alphaMatValueRO0206 then
				arg_233_1.var_.alphaMatValueRO0206.color.a = 0
				arg_233_1.var_.alphaMatValueRO0206.color = arg_233_1.var_.alphaMatValueRO0206.color
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_2 = 2
			local var_236_3 = 1.2

			if 2 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_4 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_4:setOnUpdate(LuaHelper.FloatAction(function(arg_237_0)
					arg_233_1.dialogCg_.alpha = arg_237_0
				end))
				var_236_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_5 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(115201057).content)

				arg_233_1.text_.text = var_236_5

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_7 = 48 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 48)

				if (48 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 48)) > 0 and var_236_3 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7
					var_236_2 = var_236_2 + 0.3

					if var_236_7 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_2
					end
				end

				arg_233_1.text_.text = var_236_5
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_8 = var_236_2 + 0.3
			local var_236_9 = math.max(var_236_3, arg_233_1.talkMaxDuration)

			if var_236_2 + 0.3 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_9 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_8) / var_236_9

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_8 + var_236_9 and arg_233_1.time_ < var_236_8 + var_236_9 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play115201058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 115201058
		arg_239_1.duration_ = 6.1

		local var_239_0 = {
			ja = 5.8,
			ko = 6.1,
			zh = 5.4,
			en = 4.6
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play115201059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				local var_242_0 = arg_239_1.bgs_.RO0206:GetComponent("SpriteRenderer")

				if var_242_0 then
					arg_239_1.var_.alphaOldValueRO0206 = var_242_0.color.a
					arg_239_1.var_.alphaMatValueRO0206 = var_242_0
				end

				arg_239_1.var_.alphaOldValueRO0206 = 0
			end

			local var_242_1 = 2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_1 then
				if arg_239_1.var_.alphaMatValueRO0206 then
					arg_239_1.var_.alphaMatValueRO0206.color.a = Mathf.Lerp(arg_239_1.var_.alphaOldValueRO0206, 1, (arg_239_1.time_ - 0) / var_242_1)
					arg_239_1.var_.alphaMatValueRO0206.color = arg_239_1.var_.alphaMatValueRO0206.color
				end
			end

			if arg_239_1.time_ >= 0 + var_242_1 and arg_239_1.time_ < 0 + var_242_1 + arg_242_0 and arg_239_1.var_.alphaMatValueRO0206 then
				arg_239_1.var_.alphaMatValueRO0206.color.a = 1
				arg_239_1.var_.alphaMatValueRO0206.color = arg_239_1.var_.alphaMatValueRO0206.color
			end

			local var_242_2 = 2
			local var_242_3 = 0.225

			if 2 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_4 = arg_239_1:GetWordFromCfg(115201058)
				local var_242_5 = arg_239_1:FormatText(var_242_4.content)

				arg_239_1.text_.text = var_242_5

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_7 = 9 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_5) / 9)

				if (9 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_5) / 9)) > 0 and var_242_3 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_2
					end
				end

				arg_239_1.text_.text = var_242_5
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201058", "story_v_out_115201.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201058", "story_v_out_115201.awb") / 1000

					if var_242_8 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_2
					end

					if var_242_4.prefab_name ~= "" and arg_239_1.actors_[var_242_4.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_4.prefab_name].transform, "story_v_out_115201", "115201058", "story_v_out_115201.awb")

						arg_239_1:RecordAudio("115201058", var_242_9)
						arg_239_1:RecordAudio("115201058", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_115201", "115201058", "story_v_out_115201.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_115201", "115201058", "story_v_out_115201.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_3, arg_239_1.talkMaxDuration)

			if var_242_2 <= arg_239_1.time_ and arg_239_1.time_ < var_242_2 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_2) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_2 + var_242_10 and arg_239_1.time_ < var_242_2 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play115201059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 115201059
		arg_243_1.duration_ = 3.87

		local var_243_0 = {
			ja = 1.4,
			ko = 2.9,
			zh = 3.866,
			en = 2.8
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play115201060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.2

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:GetWordFromCfg(115201059)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 8 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 8)

				if (8 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 8)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201059", "story_v_out_115201.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201059", "story_v_out_115201.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_out_115201", "115201059", "story_v_out_115201.awb")

						arg_243_1:RecordAudio("115201059", var_246_6)
						arg_243_1:RecordAudio("115201059", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_115201", "115201059", "story_v_out_115201.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_115201", "115201059", "story_v_out_115201.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play115201060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 115201060
		arg_247_1.duration_ = 18.37

		local var_247_0 = {
			ja = 13.933,
			ko = 18.366,
			zh = 15.566,
			en = 15.5
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play115201061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.35

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:GetWordFromCfg(115201060)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 54 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 54)

				if (54 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 54)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201060", "story_v_out_115201.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201060", "story_v_out_115201.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_115201", "115201060", "story_v_out_115201.awb")

						arg_247_1:RecordAudio("115201060", var_250_6)
						arg_247_1:RecordAudio("115201060", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_115201", "115201060", "story_v_out_115201.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_115201", "115201060", "story_v_out_115201.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play115201061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 115201061
		arg_251_1.duration_ = 2.4

		local var_251_0 = {
			ja = 1.133,
			ko = 2.333,
			zh = 2.4,
			en = 2.266
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play115201062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.2

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:GetWordFromCfg(115201061)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 8 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 8)

				if (8 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 8)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201061", "story_v_out_115201.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201061", "story_v_out_115201.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_115201", "115201061", "story_v_out_115201.awb")

						arg_251_1:RecordAudio("115201061", var_254_6)
						arg_251_1:RecordAudio("115201061", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_115201", "115201061", "story_v_out_115201.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_115201", "115201061", "story_v_out_115201.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play115201062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 115201062
		arg_255_1.duration_ = 13.17

		local var_255_0 = {
			ja = 13.166,
			ko = 11.466,
			zh = 10,
			en = 11.833
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play115201063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.925

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_1 = arg_255_1:GetWordFromCfg(115201062)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 37 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 37)

				if (37 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 37)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201062", "story_v_out_115201.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201062", "story_v_out_115201.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_115201", "115201062", "story_v_out_115201.awb")

						arg_255_1:RecordAudio("115201062", var_258_6)
						arg_255_1:RecordAudio("115201062", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_115201", "115201062", "story_v_out_115201.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_115201", "115201062", "story_v_out_115201.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play115201063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 115201063
		arg_259_1.duration_ = 14.3

		local var_259_0 = {
			ja = 14.3,
			ko = 10.8,
			zh = 11.3,
			en = 10.866
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play115201064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 1.1

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:GetWordFromCfg(115201063)
				local var_262_2 = arg_259_1:FormatText(var_262_1.content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 44 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 44)

				if (44 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 44)) > 0 and var_262_0 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201063", "story_v_out_115201.awb") ~= 0 then
					local var_262_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201063", "story_v_out_115201.awb") / 1000

					if var_262_5 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + 0
					end

					if var_262_1.prefab_name ~= "" and arg_259_1.actors_[var_262_1.prefab_name] ~= nil then
						local var_262_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_1.prefab_name].transform, "story_v_out_115201", "115201063", "story_v_out_115201.awb")

						arg_259_1:RecordAudio("115201063", var_262_6)
						arg_259_1:RecordAudio("115201063", var_262_6)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_115201", "115201063", "story_v_out_115201.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_115201", "115201063", "story_v_out_115201.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play115201064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 115201064
		arg_263_1.duration_ = 5.07

		local var_263_0 = {
			ja = 5,
			ko = 4,
			zh = 3.833,
			en = 5.066
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play115201065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.3

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:GetWordFromCfg(115201064)
				local var_266_2 = arg_263_1:FormatText(var_266_1.content)

				arg_263_1.text_.text = var_266_2

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 13 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 13)

				if (13 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 13)) > 0 and var_266_0 < var_266_4 then
					arg_263_1.talkMaxDuration = var_266_4

					if var_266_4 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_4 + 0
					end
				end

				arg_263_1.text_.text = var_266_2
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201064", "story_v_out_115201.awb") ~= 0 then
					local var_266_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201064", "story_v_out_115201.awb") / 1000

					if var_266_5 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + 0
					end

					if var_266_1.prefab_name ~= "" and arg_263_1.actors_[var_266_1.prefab_name] ~= nil then
						local var_266_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_1.prefab_name].transform, "story_v_out_115201", "115201064", "story_v_out_115201.awb")

						arg_263_1:RecordAudio("115201064", var_266_6)
						arg_263_1:RecordAudio("115201064", var_266_6)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_115201", "115201064", "story_v_out_115201.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_115201", "115201064", "story_v_out_115201.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_7 and arg_263_1.time_ < 0 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play115201065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 115201065
		arg_267_1.duration_ = 1.5

		local var_267_0 = {
			ja = 1.233,
			ko = 0.999999999999,
			zh = 1.5,
			en = 1.5
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play115201066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.05

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_1 = arg_267_1:GetWordFromCfg(115201065)
				local var_270_2 = arg_267_1:FormatText(var_270_1.content)

				arg_267_1.text_.text = var_270_2

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 2 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 2)

				if (2 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 2)) > 0 and var_270_0 < var_270_4 then
					arg_267_1.talkMaxDuration = var_270_4

					if var_270_4 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_4 + 0
					end
				end

				arg_267_1.text_.text = var_270_2
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201065", "story_v_out_115201.awb") ~= 0 then
					local var_270_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201065", "story_v_out_115201.awb") / 1000

					if var_270_5 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + 0
					end

					if var_270_1.prefab_name ~= "" and arg_267_1.actors_[var_270_1.prefab_name] ~= nil then
						local var_270_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_1.prefab_name].transform, "story_v_out_115201", "115201065", "story_v_out_115201.awb")

						arg_267_1:RecordAudio("115201065", var_270_6)
						arg_267_1:RecordAudio("115201065", var_270_6)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_115201", "115201065", "story_v_out_115201.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_115201", "115201065", "story_v_out_115201.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_7 and arg_267_1.time_ < 0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play115201066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 115201066
		arg_271_1.duration_ = 4.6

		local var_271_0 = {
			ja = 4.6,
			ko = 2.433,
			zh = 3.066,
			en = 2.233
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play115201067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.2

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_1 = arg_271_1:GetWordFromCfg(115201066)
				local var_274_2 = arg_271_1:FormatText(var_274_1.content)

				arg_271_1.text_.text = var_274_2

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 8 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 8)

				if (8 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 8)) > 0 and var_274_0 < var_274_4 then
					arg_271_1.talkMaxDuration = var_274_4

					if var_274_4 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_4 + 0
					end
				end

				arg_271_1.text_.text = var_274_2
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201066", "story_v_out_115201.awb") ~= 0 then
					local var_274_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201066", "story_v_out_115201.awb") / 1000

					if var_274_5 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + 0
					end

					if var_274_1.prefab_name ~= "" and arg_271_1.actors_[var_274_1.prefab_name] ~= nil then
						local var_274_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_1.prefab_name].transform, "story_v_out_115201", "115201066", "story_v_out_115201.awb")

						arg_271_1:RecordAudio("115201066", var_274_6)
						arg_271_1:RecordAudio("115201066", var_274_6)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_115201", "115201066", "story_v_out_115201.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_115201", "115201066", "story_v_out_115201.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_7 and arg_271_1.time_ < 0 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play115201067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 115201067
		arg_275_1.duration_ = 9

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play115201068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_0 = 2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				local var_278_1 = Color.New(0, 0, 0)

				var_278_1.a = Mathf.Lerp(0, 1, (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.mask_.color = var_278_1
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				local var_278_2 = Color.New(0, 0, 0)

				var_278_2.a = 1
				arg_275_1.mask_.color = var_278_2
			end

			local var_278_3 = 2

			if 2 < arg_275_1.time_ and arg_275_1.time_ <= var_278_3 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_4 = 2

			if var_278_3 <= arg_275_1.time_ and arg_275_1.time_ < var_278_3 + var_278_4 then
				local var_278_5 = Color.New(0, 0, 0)

				var_278_5.a = Mathf.Lerp(1, 0, (arg_275_1.time_ - var_278_3) / var_278_4)
				arg_275_1.mask_.color = var_278_5
			end

			if arg_275_1.time_ >= var_278_3 + var_278_4 and arg_275_1.time_ < var_278_3 + var_278_4 + arg_278_0 then
				local var_278_6 = Color.New(0, 0, 0)

				arg_275_1.mask_.enabled = false
				var_278_6.a = 0
				arg_275_1.mask_.color = var_278_6
			end

			local var_278_7 = arg_275_1.bgs_.RO0206.transform

			if 2 < arg_275_1.time_ and arg_275_1.time_ <= 2 + arg_278_0 then
				arg_275_1.var_.moveOldPosRO0206 = var_278_7.localPosition
			end

			local var_278_8 = 0.001

			if 2 <= arg_275_1.time_ and arg_275_1.time_ < 2 + var_278_8 then
				var_278_7.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPosRO0206, Vector3.New(0, 1, 9.5), (arg_275_1.time_ - 2) / var_278_8)
			end

			if arg_275_1.time_ >= 2 + var_278_8 and arg_275_1.time_ < 2 + var_278_8 + arg_278_0 then
				var_278_7.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_278_9 = arg_275_1.bgs_.RO0206.transform

			if 2.01666666666667 < arg_275_1.time_ and arg_275_1.time_ <= 2.01666666666667 + arg_278_0 then
				arg_275_1.var_.moveOldPosRO0206 = var_278_9.localPosition
			end

			local var_278_10 = 2.5

			if 2.01666666666667 <= arg_275_1.time_ and arg_275_1.time_ < 2.01666666666667 + var_278_10 then
				var_278_9.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPosRO0206, Vector3.New(0, 1, 10), (arg_275_1.time_ - 2.01666666666667) / var_278_10)
			end

			if arg_275_1.time_ >= 2.01666666666667 + var_278_10 and arg_275_1.time_ < 2.01666666666667 + var_278_10 + arg_278_0 then
				var_278_9.localPosition = Vector3.New(0, 1, 10)
			end

			local var_278_11 = 4

			if 4 < arg_275_1.time_ and arg_275_1.time_ <= var_278_11 + arg_278_0 then
				arg_275_1.allBtn_.enabled = false
			end

			if arg_275_1.time_ >= var_278_11 + 0.516666666666667 and arg_275_1.time_ < var_278_11 + 0.516666666666667 + arg_278_0 then
				arg_275_1.allBtn_.enabled = true
			end

			if arg_275_1.frameCnt_ <= 1 then
				arg_275_1.dialog_:SetActive(false)
			end

			local var_278_12 = 4
			local var_278_13 = 0.35

			if 4 < arg_275_1.time_ and arg_275_1.time_ <= var_278_12 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0

				arg_275_1.dialog_:SetActive(true)

				arg_275_1.dialogCg_.alpha = 0

				local var_278_14 = LeanTween.value(arg_275_1.dialog_, 0, 1, 0.3)

				var_278_14:setOnUpdate(LuaHelper.FloatAction(function(arg_279_0)
					arg_275_1.dialogCg_.alpha = arg_279_0
				end))
				var_278_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_275_1.dialog_)
					var_278_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_275_1.duration_ = arg_275_1.duration_ + 0.3

				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_15 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(115201067).content)

				arg_275_1.text_.text = var_278_15

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_17 = 14 <= 0 and var_278_13 or var_278_13 * (utf8.len(var_278_15) / 14)

				if (14 <= 0 and var_278_13 or var_278_13 * (utf8.len(var_278_15) / 14)) > 0 and var_278_13 < var_278_17 then
					arg_275_1.talkMaxDuration = var_278_17
					var_278_12 = var_278_12 + 0.3

					if var_278_17 + var_278_12 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_17 + var_278_12
					end
				end

				arg_275_1.text_.text = var_278_15
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_18 = var_278_12 + 0.3
			local var_278_19 = math.max(var_278_13, arg_275_1.talkMaxDuration)

			if var_278_12 + 0.3 <= arg_275_1.time_ and arg_275_1.time_ < var_278_18 + var_278_19 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_18) / var_278_19

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_18 + var_278_19 and arg_275_1.time_ < var_278_18 + var_278_19 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "RO0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "RO0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play115201068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 115201068
		arg_281_1.duration_ = 4.53

		local var_281_0 = {
			ja = 4.533,
			ko = 1.533,
			zh = 1.366,
			en = 1.466
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play115201069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.1

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:GetWordFromCfg(115201068)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 4 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 4)

				if (4 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 4)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201068", "story_v_out_115201.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201068", "story_v_out_115201.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_115201", "115201068", "story_v_out_115201.awb")

						arg_281_1:RecordAudio("115201068", var_284_6)
						arg_281_1:RecordAudio("115201068", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_115201", "115201068", "story_v_out_115201.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_115201", "115201068", "story_v_out_115201.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play115201069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 115201069
		arg_285_1.duration_ = 1.63

		local var_285_0 = {
			ja = 1.5,
			ko = 1.633,
			zh = 1.366,
			en = 1.433
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play115201070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.1

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[261].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_1 = arg_285_1:GetWordFromCfg(115201069)
				local var_288_2 = arg_285_1:FormatText(var_288_1.content)

				arg_285_1.text_.text = var_288_2

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 4 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 4)

				if (4 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 4)) > 0 and var_288_0 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end

				arg_285_1.text_.text = var_288_2
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201069", "story_v_out_115201.awb") ~= 0 then
					local var_288_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201069", "story_v_out_115201.awb") / 1000

					if var_288_5 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + 0
					end

					if var_288_1.prefab_name ~= "" and arg_285_1.actors_[var_288_1.prefab_name] ~= nil then
						local var_288_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_1.prefab_name].transform, "story_v_out_115201", "115201069", "story_v_out_115201.awb")

						arg_285_1:RecordAudio("115201069", var_288_6)
						arg_285_1:RecordAudio("115201069", var_288_6)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_115201", "115201069", "story_v_out_115201.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_115201", "115201069", "story_v_out_115201.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play115201070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 115201070
		arg_289_1.duration_ = 2.7

		local var_289_0 = {
			ja = 1.8,
			ko = 1.033,
			zh = 1.766,
			en = 2.7
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play115201071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.1

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:GetWordFromCfg(115201070)
				local var_292_2 = arg_289_1:FormatText(var_292_1.content)

				arg_289_1.text_.text = var_292_2

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 4 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 4)

				if (4 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 4)) > 0 and var_292_0 < var_292_4 then
					arg_289_1.talkMaxDuration = var_292_4

					if var_292_4 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_4 + 0
					end
				end

				arg_289_1.text_.text = var_292_2
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201070", "story_v_out_115201.awb") ~= 0 then
					local var_292_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201070", "story_v_out_115201.awb") / 1000

					if var_292_5 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + 0
					end

					if var_292_1.prefab_name ~= "" and arg_289_1.actors_[var_292_1.prefab_name] ~= nil then
						local var_292_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_1.prefab_name].transform, "story_v_out_115201", "115201070", "story_v_out_115201.awb")

						arg_289_1:RecordAudio("115201070", var_292_6)
						arg_289_1:RecordAudio("115201070", var_292_6)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_115201", "115201070", "story_v_out_115201.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_115201", "115201070", "story_v_out_115201.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_7 and arg_289_1.time_ < 0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play115201071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 115201071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play115201072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0.4

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(115201071).content)

				arg_293_1.text_.text = var_296_1

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_3 = 16 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 16)

				if (16 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 16)) > 0 and var_296_0 < var_296_3 then
					arg_293_1.talkMaxDuration = var_296_3

					if var_296_3 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_3 + 0
					end
				end

				arg_293_1.text_.text = var_296_1
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_4 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_4

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play115201072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 115201072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play115201073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 1.2

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(115201072).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 48 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 48)

				if (48 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 48)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play115201073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 115201073
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play115201074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.8

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(115201073).content)

				arg_301_1.text_.text = var_304_1

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_3 = 32 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 32)

				if (32 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 32)) > 0 and var_304_0 < var_304_3 then
					arg_301_1.talkMaxDuration = var_304_3

					if var_304_3 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_3 + 0
					end
				end

				arg_301_1.text_.text = var_304_1
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_4 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_4

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play115201074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 115201074
		arg_305_1.duration_ = 9.27

		local var_305_0 = {
			ja = 7.4,
			ko = 7.566,
			zh = 6.866,
			en = 9.266
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play115201075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.675

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:GetWordFromCfg(115201074)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 27 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 27)

				if (27 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 27)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201074", "story_v_out_115201.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201074", "story_v_out_115201.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_out_115201", "115201074", "story_v_out_115201.awb")

						arg_305_1:RecordAudio("115201074", var_308_6)
						arg_305_1:RecordAudio("115201074", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_115201", "115201074", "story_v_out_115201.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_115201", "115201074", "story_v_out_115201.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play115201075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 115201075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play115201076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 1.025

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(115201075).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 41 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 41)

				if (41 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 41)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play115201076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 115201076
		arg_313_1.duration_ = 9

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play115201077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if arg_313_1.bgs_.G03_1 == nil then
				local var_316_0 = Object.Instantiate(arg_313_1.paintGo_)

				var_316_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "G03_1")
				var_316_0.name = "G03_1"
				var_316_0.transform.parent = arg_313_1.stage_.transform
				var_316_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_313_1.bgs_.G03_1 = var_316_0
			end

			if 2 < arg_313_1.time_ and arg_313_1.time_ <= 2 + arg_316_0 then
				local var_316_1 = arg_313_1.bgs_.G03_1

				arg_313_1.bgs_.G03_1.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_316_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_316_2 = var_316_1:GetComponent("SpriteRenderer")

				if var_316_2 and var_316_2.sprite then
					local var_316_3 = 2 * (var_316_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_316_1.transform.localScale = Vector3.New(var_316_3 / var_316_2.sprite.bounds.size.y < var_316_3 * manager.ui.mainCameraCom_.aspect / var_316_2.sprite.bounds.size.x and var_316_3 * manager.ui.mainCameraCom_.aspect / var_316_2.sprite.bounds.size.x or var_316_3 / var_316_2.sprite.bounds.size.y, var_316_3 / var_316_2.sprite.bounds.size.y < var_316_3 * manager.ui.mainCameraCom_.aspect / var_316_2.sprite.bounds.size.x and var_316_3 * manager.ui.mainCameraCom_.aspect / var_316_2.sprite.bounds.size.x or var_316_3 / var_316_2.sprite.bounds.size.y, 0)
				end

				for iter_316_0, iter_316_1 in pairs(arg_313_1.bgs_) do
					if iter_316_0 ~= "G03_1" then
						iter_316_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_316_4 = 0

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.mask_.enabled = true
				arg_313_1.mask_.raycastTarget = true

				arg_313_1:SetGaussion(false)
			end

			local var_316_5 = 2

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_5 then
				local var_316_6 = Color.New(0, 0, 0)

				var_316_6.a = Mathf.Lerp(0, 1, (arg_313_1.time_ - var_316_4) / var_316_5)
				arg_313_1.mask_.color = var_316_6
			end

			if arg_313_1.time_ >= var_316_4 + var_316_5 and arg_313_1.time_ < var_316_4 + var_316_5 + arg_316_0 then
				local var_316_7 = Color.New(0, 0, 0)

				var_316_7.a = 1
				arg_313_1.mask_.color = var_316_7
			end

			local var_316_8 = 2

			if 2 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 then
				arg_313_1.mask_.enabled = true
				arg_313_1.mask_.raycastTarget = true

				arg_313_1:SetGaussion(false)
			end

			local var_316_9 = 2

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_9 then
				local var_316_10 = Color.New(0, 0, 0)

				var_316_10.a = Mathf.Lerp(1, 0, (arg_313_1.time_ - var_316_8) / var_316_9)
				arg_313_1.mask_.color = var_316_10
			end

			if arg_313_1.time_ >= var_316_8 + var_316_9 and arg_313_1.time_ < var_316_8 + var_316_9 + arg_316_0 then
				local var_316_11 = Color.New(0, 0, 0)

				arg_313_1.mask_.enabled = false
				var_316_11.a = 0
				arg_313_1.mask_.color = var_316_11
			end

			if arg_313_1.frameCnt_ <= 1 then
				arg_313_1.dialog_:SetActive(false)
			end

			local var_316_12 = 4
			local var_316_13 = 0.7

			if 4 < arg_313_1.time_ and arg_313_1.time_ <= var_316_12 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0

				arg_313_1.dialog_:SetActive(true)

				arg_313_1.dialogCg_.alpha = 0

				local var_316_14 = LeanTween.value(arg_313_1.dialog_, 0, 1, 0.3)

				var_316_14:setOnUpdate(LuaHelper.FloatAction(function(arg_317_0)
					arg_313_1.dialogCg_.alpha = arg_317_0
				end))
				var_316_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_313_1.dialog_)
					var_316_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_313_1.duration_ = arg_313_1.duration_ + 0.3

				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_15 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(115201076).content)

				arg_313_1.text_.text = var_316_15

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_17 = 28 <= 0 and var_316_13 or var_316_13 * (utf8.len(var_316_15) / 28)

				if (28 <= 0 and var_316_13 or var_316_13 * (utf8.len(var_316_15) / 28)) > 0 and var_316_13 < var_316_17 then
					arg_313_1.talkMaxDuration = var_316_17
					var_316_12 = var_316_12 + 0.3

					if var_316_17 + var_316_12 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_17 + var_316_12
					end
				end

				arg_313_1.text_.text = var_316_15
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_18 = var_316_12 + 0.3
			local var_316_19 = math.max(var_316_13, arg_313_1.talkMaxDuration)

			if var_316_12 + 0.3 <= arg_313_1.time_ and arg_313_1.time_ < var_316_18 + var_316_19 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_18) / var_316_19

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_18 + var_316_19 and arg_313_1.time_ < var_316_18 + var_316_19 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play115201077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 115201077
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play115201078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0.625

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_1 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(115201077).content)

				arg_319_1.text_.text = var_322_1

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_3 = 25 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 25)

				if (25 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 25)) > 0 and var_322_0 < var_322_3 then
					arg_319_1.talkMaxDuration = var_322_3

					if var_322_3 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_3 + 0
					end
				end

				arg_319_1.text_.text = var_322_1
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_4 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_4

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play115201078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 115201078
		arg_323_1.duration_ = 13.8

		local var_323_0 = {
			ja = 13.8,
			ko = 4.933,
			zh = 5.333,
			en = 7.266
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play115201079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if arg_323_1.actors_["1017ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1017ui_story"))) then
				local var_326_0 = Object.Instantiate(Asset.Load("Char/" .. "1017ui_story"), arg_323_1.stage_.transform)

				var_326_0.name = "1017ui_story"
				var_326_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_323_1.actors_["1017ui_story"] = var_326_0

				local var_326_1 = var_326_0:GetComponentInChildren(typeof(CharacterEffect))

				var_326_1.enabled = true

				local var_326_2 = GameObjectTools.GetOrAddComponent(var_326_0, typeof(DynamicBoneHelper))

				if var_326_2 then
					var_326_2:EnableDynamicBone(false)
				end

				arg_323_1:ShowWeapon(var_326_1.transform, false)

				arg_323_1.var_["1017ui_story" .. "Animator"] = var_326_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_323_1.var_["1017ui_story" .. "Animator"].applyRootMotion = true
				arg_323_1.var_["1017ui_story" .. "LipSync"] = var_326_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_326_3 = arg_323_1.actors_["1017ui_story"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1017ui_story = var_326_3.localPosition
			end

			local var_326_4 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 then
				var_326_3.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1017ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_323_1.time_ - 0) / var_326_4)
				var_326_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_3.position).x, (manager.ui.mainCamera.transform.position - var_326_3.position).y, (manager.ui.mainCamera.transform.position - var_326_3.position).z)
				var_326_3.localEulerAngles.z = 0
				var_326_3.localEulerAngles.x = 0
				var_326_3.localEulerAngles = var_326_3.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 then
				var_326_3.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				var_326_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_3.position).x, (manager.ui.mainCamera.transform.position - var_326_3.position).y, (manager.ui.mainCamera.transform.position - var_326_3.position).z)
				var_326_3.localEulerAngles.z = 0
				var_326_3.localEulerAngles.x = 0
				var_326_3.localEulerAngles = var_326_3.localEulerAngles
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action6_1")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_326_5 = arg_323_1.actors_["1017ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_5) and arg_323_1.var_.characterEffect1017ui_story == nil then
				arg_323_1.var_.characterEffect1017ui_story = var_326_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_6 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_6 and not isNil(var_326_5) then
				if arg_323_1.var_.characterEffect1017ui_story and not isNil(var_326_5) then
					arg_323_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_6 and arg_323_1.time_ < 0 + var_326_6 + arg_326_0 and not isNil(var_326_5) and arg_323_1.var_.characterEffect1017ui_story then
				arg_323_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_326_8 = 0
			local var_326_9 = 0.675

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_8 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_10 = arg_323_1:GetWordFromCfg(115201078)
				local var_326_11 = arg_323_1:FormatText(var_326_10.content)

				arg_323_1.text_.text = var_326_11

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_13 = 27 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 27)

				if (27 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 27)) > 0 and var_326_9 < var_326_13 then
					arg_323_1.talkMaxDuration = var_326_13

					if var_326_13 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_8
					end
				end

				arg_323_1.text_.text = var_326_11
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201078", "story_v_out_115201.awb") ~= 0 then
					local var_326_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201078", "story_v_out_115201.awb") / 1000

					if var_326_14 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_14 + var_326_8
					end

					if var_326_10.prefab_name ~= "" and arg_323_1.actors_[var_326_10.prefab_name] ~= nil then
						local var_326_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_10.prefab_name].transform, "story_v_out_115201", "115201078", "story_v_out_115201.awb")

						arg_323_1:RecordAudio("115201078", var_326_15)
						arg_323_1:RecordAudio("115201078", var_326_15)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_115201", "115201078", "story_v_out_115201.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_115201", "115201078", "story_v_out_115201.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_16 = math.max(var_326_9, arg_323_1.talkMaxDuration)

			if var_326_8 <= arg_323_1.time_ and arg_323_1.time_ < var_326_8 + var_326_16 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_8) / var_326_16

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_8 + var_326_16 and arg_323_1.time_ < var_326_8 + var_326_16 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play115201079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 115201079
		arg_327_1.duration_ = 7.33

		local var_327_0 = {
			ja = 7.3,
			ko = 6.266,
			zh = 5.966,
			en = 7.333
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play115201080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_330_0 = 0
			local var_330_1 = 0.725

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_2 = arg_327_1:GetWordFromCfg(115201079)
				local var_330_3 = arg_327_1:FormatText(var_330_2.content)

				arg_327_1.text_.text = var_330_3

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 29 <= 0 and var_330_1 or var_330_1 * (utf8.len(var_330_3) / 29)

				if (29 <= 0 and var_330_1 or var_330_1 * (utf8.len(var_330_3) / 29)) > 0 and var_330_1 < var_330_5 then
					arg_327_1.talkMaxDuration = var_330_5

					if var_330_5 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + var_330_0
					end
				end

				arg_327_1.text_.text = var_330_3
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201079", "story_v_out_115201.awb") ~= 0 then
					local var_330_6 = manager.audio:GetVoiceLength("story_v_out_115201", "115201079", "story_v_out_115201.awb") / 1000

					if var_330_6 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_6 + var_330_0
					end

					if var_330_2.prefab_name ~= "" and arg_327_1.actors_[var_330_2.prefab_name] ~= nil then
						local var_330_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_2.prefab_name].transform, "story_v_out_115201", "115201079", "story_v_out_115201.awb")

						arg_327_1:RecordAudio("115201079", var_330_7)
						arg_327_1:RecordAudio("115201079", var_330_7)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_115201", "115201079", "story_v_out_115201.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_115201", "115201079", "story_v_out_115201.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_8 = math.max(var_330_1, arg_327_1.talkMaxDuration)

			if var_330_0 <= arg_327_1.time_ and arg_327_1.time_ < var_330_0 + var_330_8 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_0) / var_330_8

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_0 + var_330_8 and arg_327_1.time_ < var_330_0 + var_330_8 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play115201080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 115201080
		arg_331_1.duration_ = 7.47

		local var_331_0 = {
			ja = 6.166,
			ko = 5.933,
			zh = 5.933,
			en = 7.466
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play115201081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1052ui_story = arg_331_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_334_0 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 then
				arg_331_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1052ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_331_1.time_ - 0) / var_334_0)
				arg_331_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1052ui_story"].transform.position).z)
				arg_331_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1052ui_story"].transform.localEulerAngles = arg_331_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 then
				arg_331_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.2)
				arg_331_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1052ui_story"].transform.position).z)
				arg_331_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1052ui_story"].transform.localEulerAngles = arg_331_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_334_1 = arg_331_1.actors_["1052ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1052ui_story == nil then
				arg_331_1.var_.characterEffect1052ui_story = var_334_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_2 and not isNil(var_334_1) then
				if arg_331_1.var_.characterEffect1052ui_story and not isNil(var_334_1) then
					arg_331_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_2 and arg_331_1.time_ < 0 + var_334_2 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1052ui_story then
				arg_331_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_334_4 = arg_331_1.actors_["1017ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_4) and arg_331_1.var_.characterEffect1017ui_story == nil then
				arg_331_1.var_.characterEffect1017ui_story = var_334_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_5 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_5 and not isNil(var_334_4) then
				if arg_331_1.var_.characterEffect1017ui_story and not isNil(var_334_4) then
					arg_331_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_331_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 0) / var_334_5)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_5 and arg_331_1.time_ < 0 + var_334_5 + arg_334_0 and not isNil(var_334_4) and arg_331_1.var_.characterEffect1017ui_story then
				arg_331_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_331_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_334_6 = 0
			local var_334_7 = 0.65

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_6 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_8 = arg_331_1:GetWordFromCfg(115201080)
				local var_334_9 = arg_331_1:FormatText(var_334_8.content)

				arg_331_1.text_.text = var_334_9

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_11 = 27 <= 0 and var_334_7 or var_334_7 * (utf8.len(var_334_9) / 27)

				if (27 <= 0 and var_334_7 or var_334_7 * (utf8.len(var_334_9) / 27)) > 0 and var_334_7 < var_334_11 then
					arg_331_1.talkMaxDuration = var_334_11

					if var_334_11 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_11 + var_334_6
					end
				end

				arg_331_1.text_.text = var_334_9
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201080", "story_v_out_115201.awb") ~= 0 then
					local var_334_12 = manager.audio:GetVoiceLength("story_v_out_115201", "115201080", "story_v_out_115201.awb") / 1000

					if var_334_12 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_12 + var_334_6
					end

					if var_334_8.prefab_name ~= "" and arg_331_1.actors_[var_334_8.prefab_name] ~= nil then
						local var_334_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_8.prefab_name].transform, "story_v_out_115201", "115201080", "story_v_out_115201.awb")

						arg_331_1:RecordAudio("115201080", var_334_13)
						arg_331_1:RecordAudio("115201080", var_334_13)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_115201", "115201080", "story_v_out_115201.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_115201", "115201080", "story_v_out_115201.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_14 = math.max(var_334_7, arg_331_1.talkMaxDuration)

			if var_334_6 <= arg_331_1.time_ and arg_331_1.time_ < var_334_6 + var_334_14 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_6) / var_334_14

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_6 + var_334_14 and arg_331_1.time_ < var_334_6 + var_334_14 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play115201081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 115201081
		arg_335_1.duration_ = 2

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play115201082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action6_2")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_338_0 = arg_335_1.actors_["1017ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.characterEffect1017ui_story == nil then
				arg_335_1.var_.characterEffect1017ui_story = var_338_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_1 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_1 and not isNil(var_338_0) then
				if arg_335_1.var_.characterEffect1017ui_story and not isNil(var_338_0) then
					arg_335_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_1 and arg_335_1.time_ < 0 + var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.characterEffect1017ui_story then
				arg_335_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_338_3 = arg_335_1.actors_["1052ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_3) and arg_335_1.var_.characterEffect1052ui_story == nil then
				arg_335_1.var_.characterEffect1052ui_story = var_338_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_4 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 and not isNil(var_338_3) then
				if arg_335_1.var_.characterEffect1052ui_story and not isNil(var_338_3) then
					arg_335_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_4)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 and not isNil(var_338_3) and arg_335_1.var_.characterEffect1052ui_story then
				arg_335_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_338_5 = 0
			local var_338_6 = 0.15

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_5 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_7 = arg_335_1:GetWordFromCfg(115201081)
				local var_338_8 = arg_335_1:FormatText(var_338_7.content)

				arg_335_1.text_.text = var_338_8

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_10 = 6 <= 0 and var_338_6 or var_338_6 * (utf8.len(var_338_8) / 6)

				if (6 <= 0 and var_338_6 or var_338_6 * (utf8.len(var_338_8) / 6)) > 0 and var_338_6 < var_338_10 then
					arg_335_1.talkMaxDuration = var_338_10

					if var_338_10 + var_338_5 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_10 + var_338_5
					end
				end

				arg_335_1.text_.text = var_338_8
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201081", "story_v_out_115201.awb") ~= 0 then
					local var_338_11 = manager.audio:GetVoiceLength("story_v_out_115201", "115201081", "story_v_out_115201.awb") / 1000

					if var_338_11 + var_338_5 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_11 + var_338_5
					end

					if var_338_7.prefab_name ~= "" and arg_335_1.actors_[var_338_7.prefab_name] ~= nil then
						local var_338_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_7.prefab_name].transform, "story_v_out_115201", "115201081", "story_v_out_115201.awb")

						arg_335_1:RecordAudio("115201081", var_338_12)
						arg_335_1:RecordAudio("115201081", var_338_12)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_115201", "115201081", "story_v_out_115201.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_115201", "115201081", "story_v_out_115201.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_13 = math.max(var_338_6, arg_335_1.talkMaxDuration)

			if var_338_5 <= arg_335_1.time_ and arg_335_1.time_ < var_338_5 + var_338_13 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_5) / var_338_13

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_5 + var_338_13 and arg_335_1.time_ < var_338_5 + var_338_13 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play115201082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 115201082
		arg_339_1.duration_ = 4.03

		local var_339_0 = {
			ja = 2.566,
			ko = 4.033,
			zh = 2.433,
			en = 2.6
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play115201083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action7_1")
			end

			local var_342_0 = arg_339_1.actors_["1052ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1052ui_story == nil then
				arg_339_1.var_.characterEffect1052ui_story = var_342_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_1 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_1 and not isNil(var_342_0) then
				if arg_339_1.var_.characterEffect1052ui_story and not isNil(var_342_0) then
					arg_339_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_1 and arg_339_1.time_ < 0 + var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1052ui_story then
				arg_339_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_342_3 = arg_339_1.actors_["1017ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_3) and arg_339_1.var_.characterEffect1017ui_story == nil then
				arg_339_1.var_.characterEffect1017ui_story = var_342_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_4 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_4 and not isNil(var_342_3) then
				if arg_339_1.var_.characterEffect1017ui_story and not isNil(var_342_3) then
					arg_339_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_4)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_4 and arg_339_1.time_ < 0 + var_342_4 + arg_342_0 and not isNil(var_342_3) and arg_339_1.var_.characterEffect1017ui_story then
				arg_339_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_342_5 = 0
			local var_342_6 = 0.225

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_5 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_7 = arg_339_1:GetWordFromCfg(115201082)
				local var_342_8 = arg_339_1:FormatText(var_342_7.content)

				arg_339_1.text_.text = var_342_8

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_10 = 9 <= 0 and var_342_6 or var_342_6 * (utf8.len(var_342_8) / 9)

				if (9 <= 0 and var_342_6 or var_342_6 * (utf8.len(var_342_8) / 9)) > 0 and var_342_6 < var_342_10 then
					arg_339_1.talkMaxDuration = var_342_10

					if var_342_10 + var_342_5 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_5
					end
				end

				arg_339_1.text_.text = var_342_8
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201082", "story_v_out_115201.awb") ~= 0 then
					local var_342_11 = manager.audio:GetVoiceLength("story_v_out_115201", "115201082", "story_v_out_115201.awb") / 1000

					if var_342_11 + var_342_5 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_11 + var_342_5
					end

					if var_342_7.prefab_name ~= "" and arg_339_1.actors_[var_342_7.prefab_name] ~= nil then
						local var_342_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_7.prefab_name].transform, "story_v_out_115201", "115201082", "story_v_out_115201.awb")

						arg_339_1:RecordAudio("115201082", var_342_12)
						arg_339_1:RecordAudio("115201082", var_342_12)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_115201", "115201082", "story_v_out_115201.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_115201", "115201082", "story_v_out_115201.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_13 = math.max(var_342_6, arg_339_1.talkMaxDuration)

			if var_342_5 <= arg_339_1.time_ and arg_339_1.time_ < var_342_5 + var_342_13 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_5) / var_342_13

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_5 + var_342_13 and arg_339_1.time_ < var_342_5 + var_342_13 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play115201083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 115201083
		arg_343_1.duration_ = 7.73

		local var_343_0 = {
			ja = 7.733,
			ko = 4.2,
			zh = 3.366,
			en = 4.9
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play115201084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos1017ui_story = arg_343_1.actors_["1017ui_story"].transform.localPosition
			end

			local var_346_0 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 then
				arg_343_1.actors_["1017ui_story"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1017ui_story, Vector3.New(0, 100, 0), (arg_343_1.time_ - 0) / var_346_0)
				arg_343_1.actors_["1017ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1017ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1017ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1017ui_story"].transform.position).z)
				arg_343_1.actors_["1017ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1017ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1017ui_story"].transform.localEulerAngles = arg_343_1.actors_["1017ui_story"].transform.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 then
				arg_343_1.actors_["1017ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_343_1.actors_["1017ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1017ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1017ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1017ui_story"].transform.position).z)
				arg_343_1.actors_["1017ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1017ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1017ui_story"].transform.localEulerAngles = arg_343_1.actors_["1017ui_story"].transform.localEulerAngles
			end

			local var_346_1 = arg_343_1.actors_["1024ui_story"].transform

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos1024ui_story = var_346_1.localPosition

				arg_343_1:ShowWeapon(arg_343_1.var_["1024ui_story" .. "Animator"].transform, false)
			end

			local var_346_2 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_2 then
				var_346_1.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1024ui_story, Vector3.New(-0.7, -1, -6.05), (arg_343_1.time_ - 0) / var_346_2)
				var_346_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_1.position).x, (manager.ui.mainCamera.transform.position - var_346_1.position).y, (manager.ui.mainCamera.transform.position - var_346_1.position).z)
				var_346_1.localEulerAngles.z = 0
				var_346_1.localEulerAngles.x = 0
				var_346_1.localEulerAngles = var_346_1.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_2 and arg_343_1.time_ < 0 + var_346_2 + arg_346_0 then
				var_346_1.localPosition = Vector3.New(-0.7, -1, -6.05)
				var_346_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_1.position).x, (manager.ui.mainCamera.transform.position - var_346_1.position).y, (manager.ui.mainCamera.transform.position - var_346_1.position).z)
				var_346_1.localEulerAngles.z = 0
				var_346_1.localEulerAngles.x = 0
				var_346_1.localEulerAngles = var_346_1.localEulerAngles
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_1")
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_346_3 = arg_343_1.actors_["1024ui_story"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_3) and arg_343_1.var_.characterEffect1024ui_story == nil then
				arg_343_1.var_.characterEffect1024ui_story = var_346_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_4 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 and not isNil(var_346_3) then
				if arg_343_1.var_.characterEffect1024ui_story and not isNil(var_346_3) then
					arg_343_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 and not isNil(var_346_3) and arg_343_1.var_.characterEffect1024ui_story then
				arg_343_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_346_6 = arg_343_1.actors_["1052ui_story"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_6) and arg_343_1.var_.characterEffect1052ui_story == nil then
				arg_343_1.var_.characterEffect1052ui_story = var_346_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_7 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_7 and not isNil(var_346_6) then
				if arg_343_1.var_.characterEffect1052ui_story and not isNil(var_346_6) then
					arg_343_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_7)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_7 and arg_343_1.time_ < 0 + var_346_7 + arg_346_0 and not isNil(var_346_6) and arg_343_1.var_.characterEffect1052ui_story then
				arg_343_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_346_8 = 0
			local var_346_9 = 0.45

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_8 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_10 = arg_343_1:GetWordFromCfg(115201083)
				local var_346_11 = arg_343_1:FormatText(var_346_10.content)

				arg_343_1.text_.text = var_346_11

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_13 = 18 <= 0 and var_346_9 or var_346_9 * (utf8.len(var_346_11) / 18)

				if (18 <= 0 and var_346_9 or var_346_9 * (utf8.len(var_346_11) / 18)) > 0 and var_346_9 < var_346_13 then
					arg_343_1.talkMaxDuration = var_346_13

					if var_346_13 + var_346_8 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_13 + var_346_8
					end
				end

				arg_343_1.text_.text = var_346_11
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201083", "story_v_out_115201.awb") ~= 0 then
					local var_346_14 = manager.audio:GetVoiceLength("story_v_out_115201", "115201083", "story_v_out_115201.awb") / 1000

					if var_346_14 + var_346_8 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_14 + var_346_8
					end

					if var_346_10.prefab_name ~= "" and arg_343_1.actors_[var_346_10.prefab_name] ~= nil then
						local var_346_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_10.prefab_name].transform, "story_v_out_115201", "115201083", "story_v_out_115201.awb")

						arg_343_1:RecordAudio("115201083", var_346_15)
						arg_343_1:RecordAudio("115201083", var_346_15)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_115201", "115201083", "story_v_out_115201.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_115201", "115201083", "story_v_out_115201.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_16 = math.max(var_346_9, arg_343_1.talkMaxDuration)

			if var_346_8 <= arg_343_1.time_ and arg_343_1.time_ < var_346_8 + var_346_16 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_8) / var_346_16

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_8 + var_346_16 and arg_343_1.time_ < var_346_8 + var_346_16 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play115201084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 115201084
		arg_347_1.duration_ = 5.07

		local var_347_0 = {
			ja = 4.733,
			ko = 4.6,
			zh = 2.933,
			en = 5.066
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play115201085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["1024ui_story"]) and arg_347_1.var_.characterEffect1024ui_story == nil then
				arg_347_1.var_.characterEffect1024ui_story = arg_347_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["1024ui_story"]) then
				if arg_347_1.var_.characterEffect1024ui_story and not isNil(arg_347_1.actors_["1024ui_story"]) then
					arg_347_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_0)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["1024ui_story"]) and arg_347_1.var_.characterEffect1024ui_story then
				arg_347_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_2")
			end

			local var_350_1 = 0
			local var_350_2 = 0.4

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_3 = arg_347_1:GetWordFromCfg(115201084)
				local var_350_4 = arg_347_1:FormatText(var_350_3.content)

				arg_347_1.text_.text = var_350_4

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_6 = 16 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_4) / 16)

				if (16 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_4) / 16)) > 0 and var_350_2 < var_350_6 then
					arg_347_1.talkMaxDuration = var_350_6

					if var_350_6 + var_350_1 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_6 + var_350_1
					end
				end

				arg_347_1.text_.text = var_350_4
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201084", "story_v_out_115201.awb") ~= 0 then
					local var_350_7 = manager.audio:GetVoiceLength("story_v_out_115201", "115201084", "story_v_out_115201.awb") / 1000

					if var_350_7 + var_350_1 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_1
					end

					if var_350_3.prefab_name ~= "" and arg_347_1.actors_[var_350_3.prefab_name] ~= nil then
						local var_350_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_3.prefab_name].transform, "story_v_out_115201", "115201084", "story_v_out_115201.awb")

						arg_347_1:RecordAudio("115201084", var_350_8)
						arg_347_1:RecordAudio("115201084", var_350_8)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_115201", "115201084", "story_v_out_115201.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_115201", "115201084", "story_v_out_115201.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_9 = math.max(var_350_2, arg_347_1.talkMaxDuration)

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_9 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_1) / var_350_9

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_1 + var_350_9 and arg_347_1.time_ < var_350_1 + var_350_9 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play115201085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 115201085
		arg_351_1.duration_ = 8.53

		local var_351_0 = {
			ja = 8.533,
			ko = 5.2,
			zh = 6.333,
			en = 3.933
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play115201086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_354_0 = arg_351_1.actors_["1052ui_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1052ui_story == nil then
				arg_351_1.var_.characterEffect1052ui_story = var_354_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_1 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_1 and not isNil(var_354_0) then
				if arg_351_1.var_.characterEffect1052ui_story and not isNil(var_354_0) then
					arg_351_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_1 and arg_351_1.time_ < 0 + var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1052ui_story then
				arg_351_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_354_3 = 0
			local var_354_4 = 0.525

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_3 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_5 = arg_351_1:GetWordFromCfg(115201085)
				local var_354_6 = arg_351_1:FormatText(var_354_5.content)

				arg_351_1.text_.text = var_354_6

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_8 = 21 <= 0 and var_354_4 or var_354_4 * (utf8.len(var_354_6) / 21)

				if (21 <= 0 and var_354_4 or var_354_4 * (utf8.len(var_354_6) / 21)) > 0 and var_354_4 < var_354_8 then
					arg_351_1.talkMaxDuration = var_354_8

					if var_354_8 + var_354_3 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_8 + var_354_3
					end
				end

				arg_351_1.text_.text = var_354_6
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201085", "story_v_out_115201.awb") ~= 0 then
					local var_354_9 = manager.audio:GetVoiceLength("story_v_out_115201", "115201085", "story_v_out_115201.awb") / 1000

					if var_354_9 + var_354_3 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_9 + var_354_3
					end

					if var_354_5.prefab_name ~= "" and arg_351_1.actors_[var_354_5.prefab_name] ~= nil then
						local var_354_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_5.prefab_name].transform, "story_v_out_115201", "115201085", "story_v_out_115201.awb")

						arg_351_1:RecordAudio("115201085", var_354_10)
						arg_351_1:RecordAudio("115201085", var_354_10)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_115201", "115201085", "story_v_out_115201.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_115201", "115201085", "story_v_out_115201.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_11 = math.max(var_354_4, arg_351_1.talkMaxDuration)

			if var_354_3 <= arg_351_1.time_ and arg_351_1.time_ < var_354_3 + var_354_11 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_3) / var_354_11

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_3 + var_354_11 and arg_351_1.time_ < var_354_3 + var_354_11 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play115201086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 115201086
		arg_355_1.duration_ = 10.33

		local var_355_0 = {
			ja = 10.333,
			ko = 8.033,
			zh = 8.233,
			en = 8.766
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play115201087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_358_0 = 0
			local var_358_1 = 0.8

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_2 = arg_355_1:GetWordFromCfg(115201086)
				local var_358_3 = arg_355_1:FormatText(var_358_2.content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 32 <= 0 and var_358_1 or var_358_1 * (utf8.len(var_358_3) / 32)

				if (32 <= 0 and var_358_1 or var_358_1 * (utf8.len(var_358_3) / 32)) > 0 and var_358_1 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_0
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201086", "story_v_out_115201.awb") ~= 0 then
					local var_358_6 = manager.audio:GetVoiceLength("story_v_out_115201", "115201086", "story_v_out_115201.awb") / 1000

					if var_358_6 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_6 + var_358_0
					end

					if var_358_2.prefab_name ~= "" and arg_355_1.actors_[var_358_2.prefab_name] ~= nil then
						local var_358_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_2.prefab_name].transform, "story_v_out_115201", "115201086", "story_v_out_115201.awb")

						arg_355_1:RecordAudio("115201086", var_358_7)
						arg_355_1:RecordAudio("115201086", var_358_7)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_115201", "115201086", "story_v_out_115201.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_115201", "115201086", "story_v_out_115201.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_8 = math.max(var_358_1, arg_355_1.talkMaxDuration)

			if var_358_0 <= arg_355_1.time_ and arg_355_1.time_ < var_358_0 + var_358_8 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_0) / var_358_8

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_0 + var_358_8 and arg_355_1.time_ < var_358_0 + var_358_8 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play115201087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 115201087
		arg_359_1.duration_ = 3.73

		local var_359_0 = {
			ja = 3.733,
			ko = 2.7,
			zh = 2.833,
			en = 2.833
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play115201088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["1024ui_story"]) and arg_359_1.var_.characterEffect1024ui_story == nil then
				arg_359_1.var_.characterEffect1024ui_story = arg_359_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_0 = 0.2

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["1024ui_story"]) then
				if arg_359_1.var_.characterEffect1024ui_story and not isNil(arg_359_1.actors_["1024ui_story"]) then
					arg_359_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["1024ui_story"]) and arg_359_1.var_.characterEffect1024ui_story then
				arg_359_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_362_2 = arg_359_1.actors_["1052ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_2) and arg_359_1.var_.characterEffect1052ui_story == nil then
				arg_359_1.var_.characterEffect1052ui_story = var_362_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_3 = 0.2

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_3 and not isNil(var_362_2) then
				if arg_359_1.var_.characterEffect1052ui_story and not isNil(var_362_2) then
					arg_359_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_3)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_3 and arg_359_1.time_ < 0 + var_362_3 + arg_362_0 and not isNil(var_362_2) and arg_359_1.var_.characterEffect1052ui_story then
				arg_359_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_362_4 = 0
			local var_362_5 = 0.325

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_6 = arg_359_1:GetWordFromCfg(115201087)
				local var_362_7 = arg_359_1:FormatText(var_362_6.content)

				arg_359_1.text_.text = var_362_7

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_9 = 13 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 13)

				if (13 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 13)) > 0 and var_362_5 < var_362_9 then
					arg_359_1.talkMaxDuration = var_362_9

					if var_362_9 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_9 + var_362_4
					end
				end

				arg_359_1.text_.text = var_362_7
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201087", "story_v_out_115201.awb") ~= 0 then
					local var_362_10 = manager.audio:GetVoiceLength("story_v_out_115201", "115201087", "story_v_out_115201.awb") / 1000

					if var_362_10 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_10 + var_362_4
					end

					if var_362_6.prefab_name ~= "" and arg_359_1.actors_[var_362_6.prefab_name] ~= nil then
						local var_362_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_6.prefab_name].transform, "story_v_out_115201", "115201087", "story_v_out_115201.awb")

						arg_359_1:RecordAudio("115201087", var_362_11)
						arg_359_1:RecordAudio("115201087", var_362_11)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_115201", "115201087", "story_v_out_115201.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_115201", "115201087", "story_v_out_115201.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_12 = math.max(var_362_5, arg_359_1.talkMaxDuration)

			if var_362_4 <= arg_359_1.time_ and arg_359_1.time_ < var_362_4 + var_362_12 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_4) / var_362_12

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_4 + var_362_12 and arg_359_1.time_ < var_362_4 + var_362_12 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play115201088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 115201088
		arg_363_1.duration_ = 4.7

		local var_363_0 = {
			ja = 2.8,
			ko = 3.533,
			zh = 4.7,
			en = 2.6
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play115201089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_366_0 = arg_363_1.actors_["1052ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1052ui_story == nil then
				arg_363_1.var_.characterEffect1052ui_story = var_366_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_1 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_1 and not isNil(var_366_0) then
				if arg_363_1.var_.characterEffect1052ui_story and not isNil(var_366_0) then
					arg_363_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_1 and arg_363_1.time_ < 0 + var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1052ui_story then
				arg_363_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_366_3 = 0
			local var_366_4 = 0.275

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_3 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_5 = arg_363_1:GetWordFromCfg(115201088)
				local var_366_6 = arg_363_1:FormatText(var_366_5.content)

				arg_363_1.text_.text = var_366_6

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_8 = 11 <= 0 and var_366_4 or var_366_4 * (utf8.len(var_366_6) / 11)

				if (11 <= 0 and var_366_4 or var_366_4 * (utf8.len(var_366_6) / 11)) > 0 and var_366_4 < var_366_8 then
					arg_363_1.talkMaxDuration = var_366_8

					if var_366_8 + var_366_3 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_3
					end
				end

				arg_363_1.text_.text = var_366_6
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201088", "story_v_out_115201.awb") ~= 0 then
					local var_366_9 = manager.audio:GetVoiceLength("story_v_out_115201", "115201088", "story_v_out_115201.awb") / 1000

					if var_366_9 + var_366_3 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_9 + var_366_3
					end

					if var_366_5.prefab_name ~= "" and arg_363_1.actors_[var_366_5.prefab_name] ~= nil then
						local var_366_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_5.prefab_name].transform, "story_v_out_115201", "115201088", "story_v_out_115201.awb")

						arg_363_1:RecordAudio("115201088", var_366_10)
						arg_363_1:RecordAudio("115201088", var_366_10)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_115201", "115201088", "story_v_out_115201.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_115201", "115201088", "story_v_out_115201.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_11 = math.max(var_366_4, arg_363_1.talkMaxDuration)

			if var_366_3 <= arg_363_1.time_ and arg_363_1.time_ < var_366_3 + var_366_11 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_3) / var_366_11

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_3 + var_366_11 and arg_363_1.time_ < var_366_3 + var_366_11 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play115201089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 115201089
		arg_367_1.duration_ = 3.87

		local var_367_0 = {
			ja = 3.866,
			ko = 3.566,
			zh = 2.633,
			en = 2.066
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play115201090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["1052ui_story"]) and arg_367_1.var_.characterEffect1052ui_story == nil then
				arg_367_1.var_.characterEffect1052ui_story = arg_367_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_0 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["1052ui_story"]) then
				if arg_367_1.var_.characterEffect1052ui_story and not isNil(arg_367_1.actors_["1052ui_story"]) then
					arg_367_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_367_1.time_ - 0) / var_370_0)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["1052ui_story"]) and arg_367_1.var_.characterEffect1052ui_story then
				arg_367_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_370_1 = 0
			local var_370_2 = 0.275

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:GetWordFromCfg(115201089)
				local var_370_4 = arg_367_1:FormatText(var_370_3.content)

				arg_367_1.text_.text = var_370_4

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_6 = 11 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_4) / 11)

				if (11 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_4) / 11)) > 0 and var_370_2 < var_370_6 then
					arg_367_1.talkMaxDuration = var_370_6

					if var_370_6 + var_370_1 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_6 + var_370_1
					end
				end

				arg_367_1.text_.text = var_370_4
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201089", "story_v_out_115201.awb") ~= 0 then
					local var_370_7 = manager.audio:GetVoiceLength("story_v_out_115201", "115201089", "story_v_out_115201.awb") / 1000

					if var_370_7 + var_370_1 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_1
					end

					if var_370_3.prefab_name ~= "" and arg_367_1.actors_[var_370_3.prefab_name] ~= nil then
						local var_370_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_3.prefab_name].transform, "story_v_out_115201", "115201089", "story_v_out_115201.awb")

						arg_367_1:RecordAudio("115201089", var_370_8)
						arg_367_1:RecordAudio("115201089", var_370_8)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_115201", "115201089", "story_v_out_115201.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_115201", "115201089", "story_v_out_115201.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_9 = math.max(var_370_2, arg_367_1.talkMaxDuration)

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_9 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_1) / var_370_9

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_1 + var_370_9 and arg_367_1.time_ < var_370_1 + var_370_9 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play115201090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 115201090
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play115201091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1052ui_story = arg_371_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_374_0 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 then
				arg_371_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1052ui_story, Vector3.New(0, 100, 0), (arg_371_1.time_ - 0) / var_374_0)
				arg_371_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1052ui_story"].transform.position).z)
				arg_371_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1052ui_story"].transform.localEulerAngles = arg_371_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 then
				arg_371_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_371_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1052ui_story"].transform.position).z)
				arg_371_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1052ui_story"].transform.localEulerAngles = arg_371_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			local var_374_1 = arg_371_1.actors_["1024ui_story"].transform

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1024ui_story = var_374_1.localPosition
			end

			local var_374_2 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_2 then
				var_374_1.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_371_1.time_ - 0) / var_374_2)
				var_374_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_374_1.position).x, (manager.ui.mainCamera.transform.position - var_374_1.position).y, (manager.ui.mainCamera.transform.position - var_374_1.position).z)
				var_374_1.localEulerAngles.z = 0
				var_374_1.localEulerAngles.x = 0
				var_374_1.localEulerAngles = var_374_1.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_2 and arg_371_1.time_ < 0 + var_374_2 + arg_374_0 then
				var_374_1.localPosition = Vector3.New(0, 100, 0)
				var_374_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_374_1.position).x, (manager.ui.mainCamera.transform.position - var_374_1.position).y, (manager.ui.mainCamera.transform.position - var_374_1.position).z)
				var_374_1.localEulerAngles.z = 0
				var_374_1.localEulerAngles.x = 0
				var_374_1.localEulerAngles = var_374_1.localEulerAngles
			end

			local var_374_3 = 0
			local var_374_4 = 0.6

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_3 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_5 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(115201090).content)

				arg_371_1.text_.text = var_374_5

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_7 = 24 <= 0 and var_374_4 or var_374_4 * (utf8.len(var_374_5) / 24)

				if (24 <= 0 and var_374_4 or var_374_4 * (utf8.len(var_374_5) / 24)) > 0 and var_374_4 < var_374_7 then
					arg_371_1.talkMaxDuration = var_374_7

					if var_374_7 + var_374_3 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_7 + var_374_3
					end
				end

				arg_371_1.text_.text = var_374_5
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_8 = math.max(var_374_4, arg_371_1.talkMaxDuration)

			if var_374_3 <= arg_371_1.time_ and arg_371_1.time_ < var_374_3 + var_374_8 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_3) / var_374_8

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_3 + var_374_8 and arg_371_1.time_ < var_374_3 + var_374_8 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play115201091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 115201091
		arg_375_1.duration_ = 4.7

		local var_375_0 = {
			ja = 4.7,
			ko = 2.8,
			zh = 3.8,
			en = 2.433
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play115201092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1052ui_story = arg_375_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1052ui_story, Vector3.New(0, -1.05, -6.2), (arg_375_1.time_ - 0) / var_378_0)
				arg_375_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1052ui_story"].transform.position).z)
				arg_375_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1052ui_story"].transform.localEulerAngles = arg_375_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_375_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1052ui_story"].transform.position).z)
				arg_375_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1052ui_story"].transform.localEulerAngles = arg_375_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_378_1 = arg_375_1.actors_["1052ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1052ui_story == nil then
				arg_375_1.var_.characterEffect1052ui_story = var_378_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.2

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_2 and not isNil(var_378_1) then
				if arg_375_1.var_.characterEffect1052ui_story and not isNil(var_378_1) then
					arg_375_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_2 and arg_375_1.time_ < 0 + var_378_2 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1052ui_story then
				arg_375_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_378_4 = 0
			local var_378_5 = 0.275

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_6 = arg_375_1:GetWordFromCfg(115201091)
				local var_378_7 = arg_375_1:FormatText(var_378_6.content)

				arg_375_1.text_.text = var_378_7

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_9 = 11 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 11)

				if (11 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 11)) > 0 and var_378_5 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_4
					end
				end

				arg_375_1.text_.text = var_378_7
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201091", "story_v_out_115201.awb") ~= 0 then
					local var_378_10 = manager.audio:GetVoiceLength("story_v_out_115201", "115201091", "story_v_out_115201.awb") / 1000

					if var_378_10 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_4
					end

					if var_378_6.prefab_name ~= "" and arg_375_1.actors_[var_378_6.prefab_name] ~= nil then
						local var_378_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_6.prefab_name].transform, "story_v_out_115201", "115201091", "story_v_out_115201.awb")

						arg_375_1:RecordAudio("115201091", var_378_11)
						arg_375_1:RecordAudio("115201091", var_378_11)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_115201", "115201091", "story_v_out_115201.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_115201", "115201091", "story_v_out_115201.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_12 = math.max(var_378_5, arg_375_1.talkMaxDuration)

			if var_378_4 <= arg_375_1.time_ and arg_375_1.time_ < var_378_4 + var_378_12 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_4) / var_378_12

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_4 + var_378_12 and arg_375_1.time_ < var_378_4 + var_378_12 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play115201092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 115201092
		arg_379_1.duration_ = 6.4

		local var_379_0 = {
			ja = 4.4,
			ko = 5.166,
			zh = 5.033,
			en = 6.4
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play115201093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["1052ui_story"]) and arg_379_1.var_.characterEffect1052ui_story == nil then
				arg_379_1.var_.characterEffect1052ui_story = arg_379_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.2

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["1052ui_story"]) then
				if arg_379_1.var_.characterEffect1052ui_story and not isNil(arg_379_1.actors_["1052ui_story"]) then
					arg_379_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_0)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["1052ui_story"]) and arg_379_1.var_.characterEffect1052ui_story then
				arg_379_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_382_1 = 0
			local var_382_2 = 0.575

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[261].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_3 = arg_379_1:GetWordFromCfg(115201092)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_6 = 23 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_4) / 23)

				if (23 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_4) / 23)) > 0 and var_382_2 < var_382_6 then
					arg_379_1.talkMaxDuration = var_382_6

					if var_382_6 + var_382_1 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_6 + var_382_1
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201092", "story_v_out_115201.awb") ~= 0 then
					local var_382_7 = manager.audio:GetVoiceLength("story_v_out_115201", "115201092", "story_v_out_115201.awb") / 1000

					if var_382_7 + var_382_1 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_1
					end

					if var_382_3.prefab_name ~= "" and arg_379_1.actors_[var_382_3.prefab_name] ~= nil then
						local var_382_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_3.prefab_name].transform, "story_v_out_115201", "115201092", "story_v_out_115201.awb")

						arg_379_1:RecordAudio("115201092", var_382_8)
						arg_379_1:RecordAudio("115201092", var_382_8)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_115201", "115201092", "story_v_out_115201.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_115201", "115201092", "story_v_out_115201.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_9 = math.max(var_382_2, arg_379_1.talkMaxDuration)

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_9 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_1) / var_382_9

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_1 + var_382_9 and arg_379_1.time_ < var_382_1 + var_382_9 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play115201093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 115201093
		arg_383_1.duration_ = 3.2

		local var_383_0 = {
			ja = 2.4,
			ko = 1.999999999999,
			zh = 3.2,
			en = 2.033
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play115201094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["1052ui_story"]) and arg_383_1.var_.characterEffect1052ui_story == nil then
				arg_383_1.var_.characterEffect1052ui_story = arg_383_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.2

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["1052ui_story"]) then
				if arg_383_1.var_.characterEffect1052ui_story and not isNil(arg_383_1.actors_["1052ui_story"]) then
					arg_383_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["1052ui_story"]) and arg_383_1.var_.characterEffect1052ui_story then
				arg_383_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_386_2 = 0
			local var_386_3 = 0.125

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_2 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_4 = arg_383_1:GetWordFromCfg(115201093)
				local var_386_5 = arg_383_1:FormatText(var_386_4.content)

				arg_383_1.text_.text = var_386_5

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_7 = 5 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_5) / 5)

				if (5 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_5) / 5)) > 0 and var_386_3 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_2
					end
				end

				arg_383_1.text_.text = var_386_5
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201093", "story_v_out_115201.awb") ~= 0 then
					local var_386_8 = manager.audio:GetVoiceLength("story_v_out_115201", "115201093", "story_v_out_115201.awb") / 1000

					if var_386_8 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_8 + var_386_2
					end

					if var_386_4.prefab_name ~= "" and arg_383_1.actors_[var_386_4.prefab_name] ~= nil then
						local var_386_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_4.prefab_name].transform, "story_v_out_115201", "115201093", "story_v_out_115201.awb")

						arg_383_1:RecordAudio("115201093", var_386_9)
						arg_383_1:RecordAudio("115201093", var_386_9)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_115201", "115201093", "story_v_out_115201.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_115201", "115201093", "story_v_out_115201.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_10 = math.max(var_386_3, arg_383_1.talkMaxDuration)

			if var_386_2 <= arg_383_1.time_ and arg_383_1.time_ < var_386_2 + var_386_10 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_2) / var_386_10

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_2 + var_386_10 and arg_383_1.time_ < var_386_2 + var_386_10 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play115201094 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 115201094
		arg_387_1.duration_ = 2.53

		local var_387_0 = {
			ja = 2.3,
			ko = 2.533,
			zh = 1.866,
			en = 1.7
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play115201095(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["1052ui_story"]) and arg_387_1.var_.characterEffect1052ui_story == nil then
				arg_387_1.var_.characterEffect1052ui_story = arg_387_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_0 = 0.2

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["1052ui_story"]) then
				if arg_387_1.var_.characterEffect1052ui_story and not isNil(arg_387_1.actors_["1052ui_story"]) then
					arg_387_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_387_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_387_1.time_ - 0) / var_390_0)
				end
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["1052ui_story"]) and arg_387_1.var_.characterEffect1052ui_story then
				arg_387_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_387_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_390_1 = 0
			local var_390_2 = 0.225

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[261].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_3 = arg_387_1:GetWordFromCfg(115201094)
				local var_390_4 = arg_387_1:FormatText(var_390_3.content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_6 = 9 <= 0 and var_390_2 or var_390_2 * (utf8.len(var_390_4) / 9)

				if (9 <= 0 and var_390_2 or var_390_2 * (utf8.len(var_390_4) / 9)) > 0 and var_390_2 < var_390_6 then
					arg_387_1.talkMaxDuration = var_390_6

					if var_390_6 + var_390_1 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_6 + var_390_1
					end
				end

				arg_387_1.text_.text = var_390_4
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201094", "story_v_out_115201.awb") ~= 0 then
					local var_390_7 = manager.audio:GetVoiceLength("story_v_out_115201", "115201094", "story_v_out_115201.awb") / 1000

					if var_390_7 + var_390_1 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_1
					end

					if var_390_3.prefab_name ~= "" and arg_387_1.actors_[var_390_3.prefab_name] ~= nil then
						local var_390_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_3.prefab_name].transform, "story_v_out_115201", "115201094", "story_v_out_115201.awb")

						arg_387_1:RecordAudio("115201094", var_390_8)
						arg_387_1:RecordAudio("115201094", var_390_8)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_115201", "115201094", "story_v_out_115201.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_115201", "115201094", "story_v_out_115201.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_9 = math.max(var_390_2, arg_387_1.talkMaxDuration)

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_9 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_1) / var_390_9

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_1 + var_390_9 and arg_387_1.time_ < var_390_1 + var_390_9 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play115201095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 115201095
		arg_391_1.duration_ = 6.4

		local var_391_0 = {
			ja = 6.4,
			ko = 5.266,
			zh = 5.9,
			en = 5.933
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play115201096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_394_0 = arg_391_1.actors_["1052ui_story"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.characterEffect1052ui_story == nil then
				arg_391_1.var_.characterEffect1052ui_story = var_394_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_1 = 0.2

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_1 and not isNil(var_394_0) then
				if arg_391_1.var_.characterEffect1052ui_story and not isNil(var_394_0) then
					arg_391_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= 0 + var_394_1 and arg_391_1.time_ < 0 + var_394_1 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.characterEffect1052ui_story then
				arg_391_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_1")
			end

			local var_394_3 = 0
			local var_394_4 = 0.55

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_3 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_5 = arg_391_1:GetWordFromCfg(115201095)
				local var_394_6 = arg_391_1:FormatText(var_394_5.content)

				arg_391_1.text_.text = var_394_6

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_8 = 22 <= 0 and var_394_4 or var_394_4 * (utf8.len(var_394_6) / 22)

				if (22 <= 0 and var_394_4 or var_394_4 * (utf8.len(var_394_6) / 22)) > 0 and var_394_4 < var_394_8 then
					arg_391_1.talkMaxDuration = var_394_8

					if var_394_8 + var_394_3 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_3
					end
				end

				arg_391_1.text_.text = var_394_6
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201095", "story_v_out_115201.awb") ~= 0 then
					local var_394_9 = manager.audio:GetVoiceLength("story_v_out_115201", "115201095", "story_v_out_115201.awb") / 1000

					if var_394_9 + var_394_3 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_9 + var_394_3
					end

					if var_394_5.prefab_name ~= "" and arg_391_1.actors_[var_394_5.prefab_name] ~= nil then
						local var_394_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_5.prefab_name].transform, "story_v_out_115201", "115201095", "story_v_out_115201.awb")

						arg_391_1:RecordAudio("115201095", var_394_10)
						arg_391_1:RecordAudio("115201095", var_394_10)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_115201", "115201095", "story_v_out_115201.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_115201", "115201095", "story_v_out_115201.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_11 = math.max(var_394_4, arg_391_1.talkMaxDuration)

			if var_394_3 <= arg_391_1.time_ and arg_391_1.time_ < var_394_3 + var_394_11 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_3) / var_394_11

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_3 + var_394_11 and arg_391_1.time_ < var_394_3 + var_394_11 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play115201096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 115201096
		arg_395_1.duration_ = 3.63

		local var_395_0 = {
			ja = 3.333,
			ko = 3.2,
			zh = 3.633,
			en = 3.566
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play115201097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["1052ui_story"]) and arg_395_1.var_.characterEffect1052ui_story == nil then
				arg_395_1.var_.characterEffect1052ui_story = arg_395_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_0 = 0.2

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["1052ui_story"]) then
				if arg_395_1.var_.characterEffect1052ui_story and not isNil(arg_395_1.actors_["1052ui_story"]) then
					arg_395_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_395_1.time_ - 0) / var_398_0)
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["1052ui_story"]) and arg_395_1.var_.characterEffect1052ui_story then
				arg_395_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_398_1 = 0
			local var_398_2 = 0.225

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[261].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_3 = arg_395_1:GetWordFromCfg(115201096)
				local var_398_4 = arg_395_1:FormatText(var_398_3.content)

				arg_395_1.text_.text = var_398_4

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_6 = 9 <= 0 and var_398_2 or var_398_2 * (utf8.len(var_398_4) / 9)

				if (9 <= 0 and var_398_2 or var_398_2 * (utf8.len(var_398_4) / 9)) > 0 and var_398_2 < var_398_6 then
					arg_395_1.talkMaxDuration = var_398_6

					if var_398_6 + var_398_1 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_6 + var_398_1
					end
				end

				arg_395_1.text_.text = var_398_4
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201096", "story_v_out_115201.awb") ~= 0 then
					local var_398_7 = manager.audio:GetVoiceLength("story_v_out_115201", "115201096", "story_v_out_115201.awb") / 1000

					if var_398_7 + var_398_1 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_1
					end

					if var_398_3.prefab_name ~= "" and arg_395_1.actors_[var_398_3.prefab_name] ~= nil then
						local var_398_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_3.prefab_name].transform, "story_v_out_115201", "115201096", "story_v_out_115201.awb")

						arg_395_1:RecordAudio("115201096", var_398_8)
						arg_395_1:RecordAudio("115201096", var_398_8)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_115201", "115201096", "story_v_out_115201.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_115201", "115201096", "story_v_out_115201.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_9 = math.max(var_398_2, arg_395_1.talkMaxDuration)

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_9 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_1) / var_398_9

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_1 + var_398_9 and arg_395_1.time_ < var_398_1 + var_398_9 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play115201097 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 115201097
		arg_399_1.duration_ = 8.5

		local var_399_0 = {
			ja = 5.866,
			ko = 8.3,
			zh = 7.033,
			en = 8.5
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play115201098(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0.8

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[262].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_1 = arg_399_1:GetWordFromCfg(115201097)
				local var_402_2 = arg_399_1:FormatText(var_402_1.content)

				arg_399_1.text_.text = var_402_2

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_4 = 31 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_2) / 31)

				if (31 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_2) / 31)) > 0 and var_402_0 < var_402_4 then
					arg_399_1.talkMaxDuration = var_402_4

					if var_402_4 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_4 + 0
					end
				end

				arg_399_1.text_.text = var_402_2
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201097", "story_v_out_115201.awb") ~= 0 then
					local var_402_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201097", "story_v_out_115201.awb") / 1000

					if var_402_5 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + 0
					end

					if var_402_1.prefab_name ~= "" and arg_399_1.actors_[var_402_1.prefab_name] ~= nil then
						local var_402_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_1.prefab_name].transform, "story_v_out_115201", "115201097", "story_v_out_115201.awb")

						arg_399_1:RecordAudio("115201097", var_402_6)
						arg_399_1:RecordAudio("115201097", var_402_6)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_115201", "115201097", "story_v_out_115201.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_115201", "115201097", "story_v_out_115201.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_7 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_7 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_7

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_7 and arg_399_1.time_ < 0 + var_402_7 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play115201098 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 115201098
		arg_403_1.duration_ = 14.9

		local var_403_0 = {
			ja = 12.666,
			ko = 8.366,
			zh = 8.8,
			en = 14.9
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play115201099(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 1.225

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[291].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_1 = arg_403_1:GetWordFromCfg(115201098)
				local var_406_2 = arg_403_1:FormatText(var_406_1.content)

				arg_403_1.text_.text = var_406_2

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_4 = 49 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_2) / 49)

				if (49 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_2) / 49)) > 0 and var_406_0 < var_406_4 then
					arg_403_1.talkMaxDuration = var_406_4

					if var_406_4 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_4 + 0
					end
				end

				arg_403_1.text_.text = var_406_2
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201098", "story_v_out_115201.awb") ~= 0 then
					local var_406_5 = manager.audio:GetVoiceLength("story_v_out_115201", "115201098", "story_v_out_115201.awb") / 1000

					if var_406_5 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_5 + 0
					end

					if var_406_1.prefab_name ~= "" and arg_403_1.actors_[var_406_1.prefab_name] ~= nil then
						local var_406_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_1.prefab_name].transform, "story_v_out_115201", "115201098", "story_v_out_115201.awb")

						arg_403_1:RecordAudio("115201098", var_406_6)
						arg_403_1:RecordAudio("115201098", var_406_6)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_115201", "115201098", "story_v_out_115201.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_115201", "115201098", "story_v_out_115201.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_7 = math.max(var_406_0, arg_403_1.talkMaxDuration)

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_7 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - 0) / var_406_7

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= 0 + var_406_7 and arg_403_1.time_ < 0 + var_406_7 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play115201099 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 115201099
		arg_407_1.duration_ = 10.13

		local var_407_0 = {
			ja = 8.233,
			ko = 5.633,
			zh = 5.2,
			en = 10.133
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play115201100(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_410_0 = arg_407_1.actors_["1052ui_story"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1052ui_story == nil then
				arg_407_1.var_.characterEffect1052ui_story = var_410_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_1 = 0.2

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_1 and not isNil(var_410_0) then
				if arg_407_1.var_.characterEffect1052ui_story and not isNil(var_410_0) then
					arg_407_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= 0 + var_410_1 and arg_407_1.time_ < 0 + var_410_1 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1052ui_story then
				arg_407_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_2")
			end

			local var_410_3 = 0
			local var_410_4 = 0.4

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_3 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_5 = arg_407_1:GetWordFromCfg(115201099)
				local var_410_6 = arg_407_1:FormatText(var_410_5.content)

				arg_407_1.text_.text = var_410_6

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_8 = 16 <= 0 and var_410_4 or var_410_4 * (utf8.len(var_410_6) / 16)

				if (16 <= 0 and var_410_4 or var_410_4 * (utf8.len(var_410_6) / 16)) > 0 and var_410_4 < var_410_8 then
					arg_407_1.talkMaxDuration = var_410_8

					if var_410_8 + var_410_3 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_8 + var_410_3
					end
				end

				arg_407_1.text_.text = var_410_6
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201099", "story_v_out_115201.awb") ~= 0 then
					local var_410_9 = manager.audio:GetVoiceLength("story_v_out_115201", "115201099", "story_v_out_115201.awb") / 1000

					if var_410_9 + var_410_3 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_9 + var_410_3
					end

					if var_410_5.prefab_name ~= "" and arg_407_1.actors_[var_410_5.prefab_name] ~= nil then
						local var_410_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_5.prefab_name].transform, "story_v_out_115201", "115201099", "story_v_out_115201.awb")

						arg_407_1:RecordAudio("115201099", var_410_10)
						arg_407_1:RecordAudio("115201099", var_410_10)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_115201", "115201099", "story_v_out_115201.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_115201", "115201099", "story_v_out_115201.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_11 = math.max(var_410_4, arg_407_1.talkMaxDuration)

			if var_410_3 <= arg_407_1.time_ and arg_407_1.time_ < var_410_3 + var_410_11 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_3) / var_410_11

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_3 + var_410_11 and arg_407_1.time_ < var_410_3 + var_410_11 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play115201100 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 115201100
		arg_411_1.duration_ = 12.7

		local var_411_0 = {
			ja = 12.633,
			ko = 10.433,
			zh = 9.6,
			en = 12.7
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play115201101(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_414_0 = 0
			local var_414_1 = 1.2

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_2 = arg_411_1:GetWordFromCfg(115201100)
				local var_414_3 = arg_411_1:FormatText(var_414_2.content)

				arg_411_1.text_.text = var_414_3

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 48 <= 0 and var_414_1 or var_414_1 * (utf8.len(var_414_3) / 48)

				if (48 <= 0 and var_414_1 or var_414_1 * (utf8.len(var_414_3) / 48)) > 0 and var_414_1 < var_414_5 then
					arg_411_1.talkMaxDuration = var_414_5

					if var_414_5 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + var_414_0
					end
				end

				arg_411_1.text_.text = var_414_3
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201100", "story_v_out_115201.awb") ~= 0 then
					local var_414_6 = manager.audio:GetVoiceLength("story_v_out_115201", "115201100", "story_v_out_115201.awb") / 1000

					if var_414_6 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_6 + var_414_0
					end

					if var_414_2.prefab_name ~= "" and arg_411_1.actors_[var_414_2.prefab_name] ~= nil then
						local var_414_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_2.prefab_name].transform, "story_v_out_115201", "115201100", "story_v_out_115201.awb")

						arg_411_1:RecordAudio("115201100", var_414_7)
						arg_411_1:RecordAudio("115201100", var_414_7)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_115201", "115201100", "story_v_out_115201.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_115201", "115201100", "story_v_out_115201.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_8 = math.max(var_414_1, arg_411_1.talkMaxDuration)

			if var_414_0 <= arg_411_1.time_ and arg_411_1.time_ < var_414_0 + var_414_8 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_0) / var_414_8

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_0 + var_414_8 and arg_411_1.time_ < var_414_0 + var_414_8 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play115201101 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 115201101
		arg_415_1.duration_ = 4.97

		local var_415_0 = {
			ja = 4.5,
			ko = 4.966,
			zh = 4.2,
			en = 3.366
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play115201102(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_418_0 = 0
			local var_418_1 = 0.4

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_2 = arg_415_1:GetWordFromCfg(115201101)
				local var_418_3 = arg_415_1:FormatText(var_418_2.content)

				arg_415_1.text_.text = var_418_3

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_5 = 16 <= 0 and var_418_1 or var_418_1 * (utf8.len(var_418_3) / 16)

				if (16 <= 0 and var_418_1 or var_418_1 * (utf8.len(var_418_3) / 16)) > 0 and var_418_1 < var_418_5 then
					arg_415_1.talkMaxDuration = var_418_5

					if var_418_5 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_5 + var_418_0
					end
				end

				arg_415_1.text_.text = var_418_3
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201101", "story_v_out_115201.awb") ~= 0 then
					local var_418_6 = manager.audio:GetVoiceLength("story_v_out_115201", "115201101", "story_v_out_115201.awb") / 1000

					if var_418_6 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_6 + var_418_0
					end

					if var_418_2.prefab_name ~= "" and arg_415_1.actors_[var_418_2.prefab_name] ~= nil then
						local var_418_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_2.prefab_name].transform, "story_v_out_115201", "115201101", "story_v_out_115201.awb")

						arg_415_1:RecordAudio("115201101", var_418_7)
						arg_415_1:RecordAudio("115201101", var_418_7)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_115201", "115201101", "story_v_out_115201.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_115201", "115201101", "story_v_out_115201.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_8 = math.max(var_418_1, arg_415_1.talkMaxDuration)

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_8 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_0) / var_418_8

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_0 + var_418_8 and arg_415_1.time_ < var_418_0 + var_418_8 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play115201102 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 115201102
		arg_419_1.duration_ = 11

		local var_419_0 = {
			ja = 11,
			ko = 6.266,
			zh = 5.533,
			en = 7.766
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play115201103(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos1052ui_story = arg_419_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_422_0 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 then
				arg_419_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1052ui_story, Vector3.New(0, 100, 0), (arg_419_1.time_ - 0) / var_422_0)
				arg_419_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1052ui_story"].transform.position).z)
				arg_419_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1052ui_story"].transform.localEulerAngles = arg_419_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 then
				arg_419_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_419_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1052ui_story"].transform.position).z)
				arg_419_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1052ui_story"].transform.localEulerAngles = arg_419_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			local var_422_1 = arg_419_1.actors_["1024ui_story"].transform

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos1024ui_story = var_422_1.localPosition
			end

			local var_422_2 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_2 then
				var_422_1.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_419_1.time_ - 0) / var_422_2)
				var_422_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_422_1.position).x, (manager.ui.mainCamera.transform.position - var_422_1.position).y, (manager.ui.mainCamera.transform.position - var_422_1.position).z)
				var_422_1.localEulerAngles.z = 0
				var_422_1.localEulerAngles.x = 0
				var_422_1.localEulerAngles = var_422_1.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_2 and arg_419_1.time_ < 0 + var_422_2 + arg_422_0 then
				var_422_1.localPosition = Vector3.New(0, -1, -6.05)
				var_422_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_422_1.position).x, (manager.ui.mainCamera.transform.position - var_422_1.position).y, (manager.ui.mainCamera.transform.position - var_422_1.position).z)
				var_422_1.localEulerAngles.z = 0
				var_422_1.localEulerAngles.x = 0
				var_422_1.localEulerAngles = var_422_1.localEulerAngles
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_1")
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_422_3 = arg_419_1.actors_["1024ui_story"]

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(var_422_3) and arg_419_1.var_.characterEffect1024ui_story == nil then
				arg_419_1.var_.characterEffect1024ui_story = var_422_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_4 = 0.2

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_4 and not isNil(var_422_3) then
				if arg_419_1.var_.characterEffect1024ui_story and not isNil(var_422_3) then
					arg_419_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= 0 + var_422_4 and arg_419_1.time_ < 0 + var_422_4 + arg_422_0 and not isNil(var_422_3) and arg_419_1.var_.characterEffect1024ui_story then
				arg_419_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_422_6 = 0
			local var_422_7 = 0.825

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_6 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_8 = arg_419_1:GetWordFromCfg(115201102)
				local var_422_9 = arg_419_1:FormatText(var_422_8.content)

				arg_419_1.text_.text = var_422_9

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_11 = 33 <= 0 and var_422_7 or var_422_7 * (utf8.len(var_422_9) / 33)

				if (33 <= 0 and var_422_7 or var_422_7 * (utf8.len(var_422_9) / 33)) > 0 and var_422_7 < var_422_11 then
					arg_419_1.talkMaxDuration = var_422_11

					if var_422_11 + var_422_6 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_11 + var_422_6
					end
				end

				arg_419_1.text_.text = var_422_9
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201102", "story_v_out_115201.awb") ~= 0 then
					local var_422_12 = manager.audio:GetVoiceLength("story_v_out_115201", "115201102", "story_v_out_115201.awb") / 1000

					if var_422_12 + var_422_6 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_12 + var_422_6
					end

					if var_422_8.prefab_name ~= "" and arg_419_1.actors_[var_422_8.prefab_name] ~= nil then
						local var_422_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_8.prefab_name].transform, "story_v_out_115201", "115201102", "story_v_out_115201.awb")

						arg_419_1:RecordAudio("115201102", var_422_13)
						arg_419_1:RecordAudio("115201102", var_422_13)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_115201", "115201102", "story_v_out_115201.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_115201", "115201102", "story_v_out_115201.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_14 = math.max(var_422_7, arg_419_1.talkMaxDuration)

			if var_422_6 <= arg_419_1.time_ and arg_419_1.time_ < var_422_6 + var_422_14 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_6) / var_422_14

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_6 + var_422_14 and arg_419_1.time_ < var_422_6 + var_422_14 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play115201103 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 115201103
		arg_423_1.duration_ = 6.67

		local var_423_0 = {
			ja = 6.666,
			ko = 5.6,
			zh = 4.033,
			en = 4.2
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play115201104(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["1024ui_story"]) and arg_423_1.var_.characterEffect1024ui_story == nil then
				arg_423_1.var_.characterEffect1024ui_story = arg_423_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["1024ui_story"]) then
				if arg_423_1.var_.characterEffect1024ui_story and not isNil(arg_423_1.actors_["1024ui_story"]) then
					arg_423_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_0)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["1024ui_story"]) and arg_423_1.var_.characterEffect1024ui_story then
				arg_423_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_426_1 = 0
			local var_426_2 = 0.525

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[261].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_3 = arg_423_1:GetWordFromCfg(115201103)
				local var_426_4 = arg_423_1:FormatText(var_426_3.content)

				arg_423_1.text_.text = var_426_4

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_6 = 21 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_4) / 21)

				if (21 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_4) / 21)) > 0 and var_426_2 < var_426_6 then
					arg_423_1.talkMaxDuration = var_426_6

					if var_426_6 + var_426_1 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_6 + var_426_1
					end
				end

				arg_423_1.text_.text = var_426_4
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201103", "story_v_out_115201.awb") ~= 0 then
					local var_426_7 = manager.audio:GetVoiceLength("story_v_out_115201", "115201103", "story_v_out_115201.awb") / 1000

					if var_426_7 + var_426_1 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_1
					end

					if var_426_3.prefab_name ~= "" and arg_423_1.actors_[var_426_3.prefab_name] ~= nil then
						local var_426_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_3.prefab_name].transform, "story_v_out_115201", "115201103", "story_v_out_115201.awb")

						arg_423_1:RecordAudio("115201103", var_426_8)
						arg_423_1:RecordAudio("115201103", var_426_8)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_115201", "115201103", "story_v_out_115201.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_115201", "115201103", "story_v_out_115201.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_9 = math.max(var_426_2, arg_423_1.talkMaxDuration)

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_9 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_1) / var_426_9

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_1 + var_426_9 and arg_423_1.time_ < var_426_1 + var_426_9 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play115201104 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 115201104
		arg_427_1.duration_ = 5.27

		local var_427_0 = {
			ja = 5.266,
			ko = 4.533,
			zh = 4.033,
			en = 3.133
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play115201105(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_430_0 = arg_427_1.actors_["1024ui_story"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect1024ui_story == nil then
				arg_427_1.var_.characterEffect1024ui_story = var_430_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_1 = 0.2

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_1 and not isNil(var_430_0) then
				if arg_427_1.var_.characterEffect1024ui_story and not isNil(var_430_0) then
					arg_427_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_1 and arg_427_1.time_ < 0 + var_430_1 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect1024ui_story then
				arg_427_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_2")
			end

			local var_430_3 = 0
			local var_430_4 = 0.475

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_3 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_5 = arg_427_1:GetWordFromCfg(115201104)
				local var_430_6 = arg_427_1:FormatText(var_430_5.content)

				arg_427_1.text_.text = var_430_6

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_8 = 19 <= 0 and var_430_4 or var_430_4 * (utf8.len(var_430_6) / 19)

				if (19 <= 0 and var_430_4 or var_430_4 * (utf8.len(var_430_6) / 19)) > 0 and var_430_4 < var_430_8 then
					arg_427_1.talkMaxDuration = var_430_8

					if var_430_8 + var_430_3 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_8 + var_430_3
					end
				end

				arg_427_1.text_.text = var_430_6
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201104", "story_v_out_115201.awb") ~= 0 then
					local var_430_9 = manager.audio:GetVoiceLength("story_v_out_115201", "115201104", "story_v_out_115201.awb") / 1000

					if var_430_9 + var_430_3 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_9 + var_430_3
					end

					if var_430_5.prefab_name ~= "" and arg_427_1.actors_[var_430_5.prefab_name] ~= nil then
						local var_430_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_5.prefab_name].transform, "story_v_out_115201", "115201104", "story_v_out_115201.awb")

						arg_427_1:RecordAudio("115201104", var_430_10)
						arg_427_1:RecordAudio("115201104", var_430_10)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_115201", "115201104", "story_v_out_115201.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_115201", "115201104", "story_v_out_115201.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_11 = math.max(var_430_4, arg_427_1.talkMaxDuration)

			if var_430_3 <= arg_427_1.time_ and arg_427_1.time_ < var_430_3 + var_430_11 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_3) / var_430_11

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_3 + var_430_11 and arg_427_1.time_ < var_430_3 + var_430_11 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play115201105 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 115201105
		arg_431_1.duration_ = 9.6

		local var_431_0 = {
			ja = 8.033,
			ko = 8.466,
			zh = 9.6,
			en = 6.833
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play115201106(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.var_.moveOldPos1024ui_story = arg_431_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_434_0 = 0.001

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 then
				arg_431_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_431_1.time_ - 0) / var_434_0)
				arg_431_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_431_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1024ui_story"].transform.position).z)
				arg_431_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_431_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_431_1.actors_["1024ui_story"].transform.localEulerAngles = arg_431_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 then
				arg_431_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_431_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_431_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1024ui_story"].transform.position).z)
				arg_431_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_431_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_431_1.actors_["1024ui_story"].transform.localEulerAngles = arg_431_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_434_1 = arg_431_1.actors_["1017ui_story"].transform

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.var_.moveOldPos1017ui_story = var_434_1.localPosition
			end

			local var_434_2 = 0.001

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_2 then
				var_434_1.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1017ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_431_1.time_ - 0) / var_434_2)
				var_434_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_434_1.position).x, (manager.ui.mainCamera.transform.position - var_434_1.position).y, (manager.ui.mainCamera.transform.position - var_434_1.position).z)
				var_434_1.localEulerAngles.z = 0
				var_434_1.localEulerAngles.x = 0
				var_434_1.localEulerAngles = var_434_1.localEulerAngles
			end

			if arg_431_1.time_ >= 0 + var_434_2 and arg_431_1.time_ < 0 + var_434_2 + arg_434_0 then
				var_434_1.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				var_434_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_434_1.position).x, (manager.ui.mainCamera.transform.position - var_434_1.position).y, (manager.ui.mainCamera.transform.position - var_434_1.position).z)
				var_434_1.localEulerAngles.z = 0
				var_434_1.localEulerAngles.x = 0
				var_434_1.localEulerAngles = var_434_1.localEulerAngles
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action6_1")
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_434_3 = arg_431_1.actors_["1017ui_story"]

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(var_434_3) and arg_431_1.var_.characterEffect1017ui_story == nil then
				arg_431_1.var_.characterEffect1017ui_story = var_434_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_4 = 0.2

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 and not isNil(var_434_3) then
				if arg_431_1.var_.characterEffect1017ui_story and not isNil(var_434_3) then
					arg_431_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 and not isNil(var_434_3) and arg_431_1.var_.characterEffect1017ui_story then
				arg_431_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_434_6 = 0
			local var_434_7 = 1.05

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_6 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_8 = arg_431_1:GetWordFromCfg(115201105)
				local var_434_9 = arg_431_1:FormatText(var_434_8.content)

				arg_431_1.text_.text = var_434_9

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_11 = 42 <= 0 and var_434_7 or var_434_7 * (utf8.len(var_434_9) / 42)

				if (42 <= 0 and var_434_7 or var_434_7 * (utf8.len(var_434_9) / 42)) > 0 and var_434_7 < var_434_11 then
					arg_431_1.talkMaxDuration = var_434_11

					if var_434_11 + var_434_6 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_11 + var_434_6
					end
				end

				arg_431_1.text_.text = var_434_9
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201105", "story_v_out_115201.awb") ~= 0 then
					local var_434_12 = manager.audio:GetVoiceLength("story_v_out_115201", "115201105", "story_v_out_115201.awb") / 1000

					if var_434_12 + var_434_6 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_12 + var_434_6
					end

					if var_434_8.prefab_name ~= "" and arg_431_1.actors_[var_434_8.prefab_name] ~= nil then
						local var_434_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_8.prefab_name].transform, "story_v_out_115201", "115201105", "story_v_out_115201.awb")

						arg_431_1:RecordAudio("115201105", var_434_13)
						arg_431_1:RecordAudio("115201105", var_434_13)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_115201", "115201105", "story_v_out_115201.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_115201", "115201105", "story_v_out_115201.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_14 = math.max(var_434_7, arg_431_1.talkMaxDuration)

			if var_434_6 <= arg_431_1.time_ and arg_431_1.time_ < var_434_6 + var_434_14 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_6) / var_434_14

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_6 + var_434_14 and arg_431_1.time_ < var_434_6 + var_434_14 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play115201106 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 115201106
		arg_435_1.duration_ = 4.87

		local var_435_0 = {
			ja = 4.866,
			ko = 2.7,
			zh = 4.133,
			en = 4.3
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
			arg_435_1.auto_ = false
		end

		function arg_435_1.playNext_(arg_437_0)
			arg_435_1.onStoryFinished_()
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["1017ui_story"]) and arg_435_1.var_.characterEffect1017ui_story == nil then
				arg_435_1.var_.characterEffect1017ui_story = arg_435_1.actors_["1017ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_0 = 0.2

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["1017ui_story"]) then
				if arg_435_1.var_.characterEffect1017ui_story and not isNil(arg_435_1.actors_["1017ui_story"]) then
					arg_435_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_435_1.time_ - 0) / var_438_0)
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["1017ui_story"]) and arg_435_1.var_.characterEffect1017ui_story then
				arg_435_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_438_1 = arg_435_1.actors_["1052ui_story"].transform

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos1052ui_story = var_438_1.localPosition
			end

			local var_438_2 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_2 then
				var_438_1.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1052ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_435_1.time_ - 0) / var_438_2)
				var_438_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_438_1.position).x, (manager.ui.mainCamera.transform.position - var_438_1.position).y, (manager.ui.mainCamera.transform.position - var_438_1.position).z)
				var_438_1.localEulerAngles.z = 0
				var_438_1.localEulerAngles.x = 0
				var_438_1.localEulerAngles = var_438_1.localEulerAngles
			end

			if arg_435_1.time_ >= 0 + var_438_2 and arg_435_1.time_ < 0 + var_438_2 + arg_438_0 then
				var_438_1.localPosition = Vector3.New(0.7, -1.05, -6.2)
				var_438_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_438_1.position).x, (manager.ui.mainCamera.transform.position - var_438_1.position).y, (manager.ui.mainCamera.transform.position - var_438_1.position).z)
				var_438_1.localEulerAngles.z = 0
				var_438_1.localEulerAngles.x = 0
				var_438_1.localEulerAngles = var_438_1.localEulerAngles
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_1")
			end

			local var_438_3 = arg_435_1.actors_["1052ui_story"]

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(var_438_3) and arg_435_1.var_.characterEffect1052ui_story == nil then
				arg_435_1.var_.characterEffect1052ui_story = var_438_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_4 = 0.2

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_4 and not isNil(var_438_3) then
				if arg_435_1.var_.characterEffect1052ui_story and not isNil(var_438_3) then
					arg_435_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= 0 + var_438_4 and arg_435_1.time_ < 0 + var_438_4 + arg_438_0 and not isNil(var_438_3) and arg_435_1.var_.characterEffect1052ui_story then
				arg_435_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_438_6 = 0
			local var_438_7 = 0.25

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_6 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_8 = arg_435_1:GetWordFromCfg(115201106)
				local var_438_9 = arg_435_1:FormatText(var_438_8.content)

				arg_435_1.text_.text = var_438_9

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_11 = 10 <= 0 and var_438_7 or var_438_7 * (utf8.len(var_438_9) / 10)

				if (10 <= 0 and var_438_7 or var_438_7 * (utf8.len(var_438_9) / 10)) > 0 and var_438_7 < var_438_11 then
					arg_435_1.talkMaxDuration = var_438_11

					if var_438_11 + var_438_6 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_11 + var_438_6
					end
				end

				arg_435_1.text_.text = var_438_9
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115201", "115201106", "story_v_out_115201.awb") ~= 0 then
					local var_438_12 = manager.audio:GetVoiceLength("story_v_out_115201", "115201106", "story_v_out_115201.awb") / 1000

					if var_438_12 + var_438_6 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_12 + var_438_6
					end

					if var_438_8.prefab_name ~= "" and arg_435_1.actors_[var_438_8.prefab_name] ~= nil then
						local var_438_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_8.prefab_name].transform, "story_v_out_115201", "115201106", "story_v_out_115201.awb")

						arg_435_1:RecordAudio("115201106", var_438_13)
						arg_435_1:RecordAudio("115201106", var_438_13)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_115201", "115201106", "story_v_out_115201.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_115201", "115201106", "story_v_out_115201.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_14 = math.max(var_438_7, arg_435_1.talkMaxDuration)

			if var_438_6 <= arg_435_1.time_ and arg_435_1.time_ < var_438_6 + var_438_14 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_6) / var_438_14

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_6 + var_438_14 and arg_435_1.time_ < var_438_6 + var_438_14 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/RO0205",
		"TextureConfig/Background/G02j",
		"TextureConfig/Background/RO0206",
		"TextureConfig/Background/G03_1"
	},
	voices = {
		"story_v_out_115201.awb"
	}
}
