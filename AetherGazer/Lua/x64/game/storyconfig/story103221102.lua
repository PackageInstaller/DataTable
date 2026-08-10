return {
	Play322112001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322112001
		arg_1_1.duration_ = 3.33

		local var_1_0 = {
			zh = 3.333,
			ja = 3.066
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322112002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "MS2206"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.MS2206

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "MS2206" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = 0.2
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_145", "se_story_145_amb_stone_l19f", "")
			end

			local var_4_28 = 0
			local var_4_29 = 0.3

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			local var_4_34 = 0.500666666666667
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "music"

				arg_1_1:AudioAction(var_4_36, var_4_37, "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled.awb")

				local var_4_38 = ""
				local var_4_39 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

				if var_4_39 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_39 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_39

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_39
						arg_1_1.bgmTxt2_.text = var_4_39
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

			local var_4_40 = arg_1_1.bgs_.MS2206.transform
			local var_4_41 = 0

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1.var_.moveOldPosMS2206 = var_4_40.localPosition
			end

			local var_4_42 = 2

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42
				local var_4_44 = Vector3.New(0, 3, 0)

				var_4_40.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosMS2206, var_4_44, var_4_43)
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				var_4_40.localPosition = Vector3.New(0, 3, 0)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_45 = 2
			local var_4_46 = 0.125

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_47 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_47:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_48 = arg_1_1:FormatText(StoryNameCfg[668].name)

				arg_1_1.leftNameTxt_.text = var_4_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_49 = arg_1_1:GetWordFromCfg(322112001)
				local var_4_50 = arg_1_1:FormatText(var_4_49.content)

				arg_1_1.text_.text = var_4_50

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_51 = 5
				local var_4_52 = utf8.len(var_4_50)
				local var_4_53 = var_4_51 <= 0 and var_4_46 or var_4_46 * (var_4_52 / var_4_51)

				if var_4_53 > 0 and var_4_46 < var_4_53 then
					arg_1_1.talkMaxDuration = var_4_53
					var_4_45 = var_4_45 + 0.3

					if var_4_53 + var_4_45 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_53 + var_4_45
					end
				end

				arg_1_1.text_.text = var_4_50
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112001", "story_v_out_322112.awb") ~= 0 then
					local var_4_54 = manager.audio:GetVoiceLength("story_v_out_322112", "322112001", "story_v_out_322112.awb") / 1000

					if var_4_54 + var_4_45 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_54 + var_4_45
					end

					if var_4_49.prefab_name ~= "" and arg_1_1.actors_[var_4_49.prefab_name] ~= nil then
						local var_4_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_49.prefab_name].transform, "story_v_out_322112", "322112001", "story_v_out_322112.awb")

						arg_1_1:RecordAudio("322112001", var_4_55)
						arg_1_1:RecordAudio("322112001", var_4_55)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322112", "322112001", "story_v_out_322112.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322112", "322112001", "story_v_out_322112.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_56 = var_4_45 + 0.3
			local var_4_57 = math.max(var_4_46, arg_1_1.talkMaxDuration)

			if var_4_56 <= arg_1_1.time_ and arg_1_1.time_ < var_4_56 + var_4_57 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_56) / var_4_57

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_56 + var_4_57 and arg_1_1.time_ < var_4_56 + var_4_57 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2206",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 2.5, 0),
					endPos = Vector3.New(0, 3, 0),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play322112002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322112002
		arg_9_1.duration_ = 9.6

		local var_9_0 = {
			zh = 9,
			ja = 9.6
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322112003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.9

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[263].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(322112002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 36
				local var_12_6 = utf8.len(var_12_4)
				local var_12_7 = var_12_5 <= 0 and var_12_1 or var_12_1 * (var_12_6 / var_12_5)

				if var_12_7 > 0 and var_12_1 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112002", "story_v_out_322112.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112002", "story_v_out_322112.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_322112", "322112002", "story_v_out_322112.awb")

						arg_9_1:RecordAudio("322112002", var_12_9)
						arg_9_1:RecordAudio("322112002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_322112", "322112002", "story_v_out_322112.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_322112", "322112002", "story_v_out_322112.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_10 and arg_9_1.time_ < var_12_0 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play322112003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322112003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play322112004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1
			local var_16_1 = 1

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				local var_16_2 = "play"
				local var_16_3 = "effect"

				arg_13_1:AudioAction(var_16_2, var_16_3, "se_story_145", "se_story_145_summon_laser2", "")
			end

			local var_16_4 = manager.ui.mainCamera.transform
			local var_16_5 = 1

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.var_.shakeOldPos = var_16_4.localPosition
			end

			local var_16_6 = 0.266666666666667

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_6 then
				local var_16_7 = (arg_13_1.time_ - var_16_5) / 0.066
				local var_16_8, var_16_9 = math.modf(var_16_7)

				var_16_4.localPosition = Vector3.New(var_16_9 * 0.13, var_16_9 * 0.13, var_16_9 * 0.13) + arg_13_1.var_.shakeOldPos
			end

			if arg_13_1.time_ >= var_16_5 + var_16_6 and arg_13_1.time_ < var_16_5 + var_16_6 + arg_16_0 then
				var_16_4.localPosition = arg_13_1.var_.shakeOldPos
			end

			local var_16_10 = 0
			local var_16_11 = 1.775

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_12 = arg_13_1:GetWordFromCfg(322112003)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_14 = 71
				local var_16_15 = utf8.len(var_16_13)
				local var_16_16 = var_16_14 <= 0 and var_16_11 or var_16_11 * (var_16_15 / var_16_14)

				if var_16_16 > 0 and var_16_11 < var_16_16 then
					arg_13_1.talkMaxDuration = var_16_16

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_17 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_17 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_10) / var_16_17

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_10 + var_16_17 and arg_13_1.time_ < var_16_10 + var_16_17 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play322112004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322112004
		arg_17_1.duration_ = 5.33

		local var_17_0 = {
			zh = 3.7,
			ja = 5.333
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play322112005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.5

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[668].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(322112004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 20
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112004", "story_v_out_322112.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112004", "story_v_out_322112.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_322112", "322112004", "story_v_out_322112.awb")

						arg_17_1:RecordAudio("322112004", var_20_9)
						arg_17_1:RecordAudio("322112004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_322112", "322112004", "story_v_out_322112.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_322112", "322112004", "story_v_out_322112.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play322112005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322112005
		arg_21_1.duration_ = 4.93

		local var_21_0 = {
			zh = 2.933,
			ja = 4.933
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
				arg_21_0:Play322112006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.4

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[668].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(322112005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 16
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112005", "story_v_out_322112.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112005", "story_v_out_322112.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_322112", "322112005", "story_v_out_322112.awb")

						arg_21_1:RecordAudio("322112005", var_24_9)
						arg_21_1:RecordAudio("322112005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_322112", "322112005", "story_v_out_322112.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_322112", "322112005", "story_v_out_322112.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_10 and arg_21_1.time_ < var_24_0 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play322112006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322112006
		arg_25_1.duration_ = 7.03

		local var_25_0 = {
			zh = 4.5,
			ja = 7.033
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play322112007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.4

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[263].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(322112006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 16
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112006", "story_v_out_322112.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112006", "story_v_out_322112.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_322112", "322112006", "story_v_out_322112.awb")

						arg_25_1:RecordAudio("322112006", var_28_9)
						arg_25_1:RecordAudio("322112006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322112", "322112006", "story_v_out_322112.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322112", "322112006", "story_v_out_322112.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play322112007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322112007
		arg_29_1.duration_ = 2.27

		local var_29_0 = {
			zh = 1.266,
			ja = 2.266
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
				arg_29_0:Play322112008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.075

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[668].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(322112007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 3
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112007", "story_v_out_322112.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112007", "story_v_out_322112.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_322112", "322112007", "story_v_out_322112.awb")

						arg_29_1:RecordAudio("322112007", var_32_9)
						arg_29_1:RecordAudio("322112007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322112", "322112007", "story_v_out_322112.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322112", "322112007", "story_v_out_322112.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play322112008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322112008
		arg_33_1.duration_ = 5.77

		local var_33_0 = {
			zh = 2.233,
			ja = 5.766
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play322112009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.25

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[263].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(322112008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 10
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112008", "story_v_out_322112.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112008", "story_v_out_322112.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_322112", "322112008", "story_v_out_322112.awb")

						arg_33_1:RecordAudio("322112008", var_36_9)
						arg_33_1:RecordAudio("322112008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_322112", "322112008", "story_v_out_322112.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_322112", "322112008", "story_v_out_322112.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_10 and arg_33_1.time_ < var_36_0 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play322112009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322112009
		arg_37_1.duration_ = 9.5

		local var_37_0 = {
			zh = 7.1,
			ja = 9.5
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play322112010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.725

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[263].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(322112009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 29
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112009", "story_v_out_322112.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112009", "story_v_out_322112.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_322112", "322112009", "story_v_out_322112.awb")

						arg_37_1:RecordAudio("322112009", var_40_9)
						arg_37_1:RecordAudio("322112009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322112", "322112009", "story_v_out_322112.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322112", "322112009", "story_v_out_322112.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play322112010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322112010
		arg_41_1.duration_ = 7.7

		local var_41_0 = {
			zh = 4.466,
			ja = 7.7
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play322112011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.425

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[1030].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_41_1.callingController_:SetSelectedState("calling")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(322112010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 17
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112010", "story_v_out_322112.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112010", "story_v_out_322112.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_322112", "322112010", "story_v_out_322112.awb")

						arg_41_1:RecordAudio("322112010", var_44_9)
						arg_41_1:RecordAudio("322112010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322112", "322112010", "story_v_out_322112.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322112", "322112010", "story_v_out_322112.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play322112011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322112011
		arg_45_1.duration_ = 2.77

		local var_45_0 = {
			zh = 1.6,
			ja = 2.766
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play322112012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.2

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[1167].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_45_1.callingController_:SetSelectedState("calling")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(322112011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 8
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112011", "story_v_out_322112.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112011", "story_v_out_322112.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_322112", "322112011", "story_v_out_322112.awb")

						arg_45_1:RecordAudio("322112011", var_48_9)
						arg_45_1:RecordAudio("322112011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_322112", "322112011", "story_v_out_322112.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_322112", "322112011", "story_v_out_322112.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play322112012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322112012
		arg_49_1.duration_ = 10.6

		local var_49_0 = {
			zh = 5.666,
			ja = 10.6
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play322112013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.675

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[263].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(322112012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 27
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112012", "story_v_out_322112.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112012", "story_v_out_322112.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_322112", "322112012", "story_v_out_322112.awb")

						arg_49_1:RecordAudio("322112012", var_52_9)
						arg_49_1:RecordAudio("322112012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322112", "322112012", "story_v_out_322112.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322112", "322112012", "story_v_out_322112.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play322112013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322112013
		arg_53_1.duration_ = 5.83

		local var_53_0 = {
			zh = 5.833,
			ja = 5.8
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play322112014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.5

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[263].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(322112013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 20
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112013", "story_v_out_322112.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112013", "story_v_out_322112.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_322112", "322112013", "story_v_out_322112.awb")

						arg_53_1:RecordAudio("322112013", var_56_9)
						arg_53_1:RecordAudio("322112013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_322112", "322112013", "story_v_out_322112.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_322112", "322112013", "story_v_out_322112.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play322112014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322112014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play322112015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.375

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(322112014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 55
				local var_60_5 = utf8.len(var_60_3)
				local var_60_6 = var_60_4 <= 0 and var_60_1 or var_60_1 * (var_60_5 / var_60_4)

				if var_60_6 > 0 and var_60_1 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_7 and arg_57_1.time_ < var_60_0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play322112015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322112015
		arg_61_1.duration_ = 3.12

		local var_61_0 = {
			zh = 1.083,
			ja = 3.116
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play322112016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.allBtn_.enabled = false
			end

			local var_64_1 = 0.233333333333333

			if arg_61_1.time_ >= var_64_0 + var_64_1 and arg_61_1.time_ < var_64_0 + var_64_1 + arg_64_0 then
				arg_61_1.allBtn_.enabled = true
			end

			local var_64_2 = arg_61_1.bgs_.MS2206.transform
			local var_64_3 = 0

			if var_64_3 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.var_.moveOldPosMS2206 = var_64_2.localPosition
			end

			local var_64_4 = 0.366666666666667

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_4 then
				local var_64_5 = (arg_61_1.time_ - var_64_3) / var_64_4
				local var_64_6 = Vector3.New(0, 1, 10)

				var_64_2.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPosMS2206, var_64_6, var_64_5)
			end

			if arg_61_1.time_ >= var_64_3 + var_64_4 and arg_61_1.time_ < var_64_3 + var_64_4 + arg_64_0 then
				var_64_2.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_7 = 0.05
			local var_64_8 = 0.05

			if var_64_7 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_9 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_9:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_10 = arg_61_1:FormatText(StoryNameCfg[263].name)

				arg_61_1.leftNameTxt_.text = var_64_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_11 = arg_61_1:GetWordFromCfg(322112015)
				local var_64_12 = arg_61_1:FormatText(var_64_11.content)

				arg_61_1.text_.text = var_64_12

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 2
				local var_64_14 = utf8.len(var_64_12)
				local var_64_15 = var_64_13 <= 0 and var_64_8 or var_64_8 * (var_64_14 / var_64_13)

				if var_64_15 > 0 and var_64_8 < var_64_15 then
					arg_61_1.talkMaxDuration = var_64_15
					var_64_7 = var_64_7 + 0.3

					if var_64_15 + var_64_7 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_15 + var_64_7
					end
				end

				arg_61_1.text_.text = var_64_12
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112015", "story_v_out_322112.awb") ~= 0 then
					local var_64_16 = manager.audio:GetVoiceLength("story_v_out_322112", "322112015", "story_v_out_322112.awb") / 1000

					if var_64_16 + var_64_7 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_16 + var_64_7
					end

					if var_64_11.prefab_name ~= "" and arg_61_1.actors_[var_64_11.prefab_name] ~= nil then
						local var_64_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_11.prefab_name].transform, "story_v_out_322112", "322112015", "story_v_out_322112.awb")

						arg_61_1:RecordAudio("322112015", var_64_17)
						arg_61_1:RecordAudio("322112015", var_64_17)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_322112", "322112015", "story_v_out_322112.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_322112", "322112015", "story_v_out_322112.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_18 = var_64_7 + 0.3
			local var_64_19 = math.max(var_64_8, arg_61_1.talkMaxDuration)

			if var_64_18 <= arg_61_1.time_ and arg_61_1.time_ < var_64_18 + var_64_19 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_18) / var_64_19

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_18 + var_64_19 and arg_61_1.time_ < var_64_18 + var_64_19 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2206",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.366666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 3, 0),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play322112016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 322112016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play322112017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.925

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_2 = arg_67_1:GetWordFromCfg(322112016)
				local var_70_3 = arg_67_1:FormatText(var_70_2.content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 37
				local var_70_5 = utf8.len(var_70_3)
				local var_70_6 = var_70_4 <= 0 and var_70_1 or var_70_1 * (var_70_5 / var_70_4)

				if var_70_6 > 0 and var_70_1 < var_70_6 then
					arg_67_1.talkMaxDuration = var_70_6

					if var_70_6 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_7 and arg_67_1.time_ < var_70_0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play322112017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 322112017
		arg_71_1.duration_ = 9

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play322112018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = "ST2102a"

			if arg_71_1.bgs_[var_74_0] == nil then
				local var_74_1 = Object.Instantiate(arg_71_1.paintGo_)

				var_74_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_74_0)
				var_74_1.name = var_74_0
				var_74_1.transform.parent = arg_71_1.stage_.transform
				var_74_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.bgs_[var_74_0] = var_74_1
			end

			local var_74_2 = 2

			if var_74_2 < arg_71_1.time_ and arg_71_1.time_ <= var_74_2 + arg_74_0 then
				local var_74_3 = manager.ui.mainCamera.transform.localPosition
				local var_74_4 = Vector3.New(0, 0, 10) + Vector3.New(var_74_3.x, var_74_3.y, 0)
				local var_74_5 = arg_71_1.bgs_.ST2102a

				var_74_5.transform.localPosition = var_74_4
				var_74_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_6 = var_74_5:GetComponent("SpriteRenderer")

				if var_74_6 and var_74_6.sprite then
					local var_74_7 = (var_74_5.transform.localPosition - var_74_3).z
					local var_74_8 = manager.ui.mainCameraCom_
					local var_74_9 = 2 * var_74_7 * Mathf.Tan(var_74_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_74_10 = var_74_9 * var_74_8.aspect
					local var_74_11 = var_74_6.sprite.bounds.size.x
					local var_74_12 = var_74_6.sprite.bounds.size.y
					local var_74_13 = var_74_10 / var_74_11
					local var_74_14 = var_74_9 / var_74_12
					local var_74_15 = var_74_14 < var_74_13 and var_74_13 or var_74_14

					var_74_5.transform.localScale = Vector3.New(var_74_15, var_74_15, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "ST2102a" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_16 = 4

			if var_74_16 < arg_71_1.time_ and arg_71_1.time_ <= var_74_16 + arg_74_0 then
				arg_71_1.allBtn_.enabled = false
			end

			local var_74_17 = 0.3

			if arg_71_1.time_ >= var_74_16 + var_74_17 and arg_71_1.time_ < var_74_16 + var_74_17 + arg_74_0 then
				arg_71_1.allBtn_.enabled = true
			end

			local var_74_18 = 0

			if var_74_18 < arg_71_1.time_ and arg_71_1.time_ <= var_74_18 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_19 = 2

			if var_74_18 <= arg_71_1.time_ and arg_71_1.time_ < var_74_18 + var_74_19 then
				local var_74_20 = (arg_71_1.time_ - var_74_18) / var_74_19
				local var_74_21 = Color.New(0, 0, 0)

				var_74_21.a = Mathf.Lerp(0, 1, var_74_20)
				arg_71_1.mask_.color = var_74_21
			end

			if arg_71_1.time_ >= var_74_18 + var_74_19 and arg_71_1.time_ < var_74_18 + var_74_19 + arg_74_0 then
				local var_74_22 = Color.New(0, 0, 0)

				var_74_22.a = 1
				arg_71_1.mask_.color = var_74_22
			end

			local var_74_23 = 2

			if var_74_23 < arg_71_1.time_ and arg_71_1.time_ <= var_74_23 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_24 = 2

			if var_74_23 <= arg_71_1.time_ and arg_71_1.time_ < var_74_23 + var_74_24 then
				local var_74_25 = (arg_71_1.time_ - var_74_23) / var_74_24
				local var_74_26 = Color.New(0, 0, 0)

				var_74_26.a = Mathf.Lerp(1, 0, var_74_25)
				arg_71_1.mask_.color = var_74_26
			end

			if arg_71_1.time_ >= var_74_23 + var_74_24 and arg_71_1.time_ < var_74_23 + var_74_24 + arg_74_0 then
				local var_74_27 = Color.New(0, 0, 0)
				local var_74_28 = 0

				arg_71_1.mask_.enabled = false
				var_74_27.a = var_74_28
				arg_71_1.mask_.color = var_74_27
			end

			local var_74_29 = 0.166666666666667
			local var_74_30 = 1

			if var_74_29 < arg_71_1.time_ and arg_71_1.time_ <= var_74_29 + arg_74_0 then
				local var_74_31 = "stop"
				local var_74_32 = "effect"

				arg_71_1:AudioAction(var_74_31, var_74_32, "se_story_145", "se_story_145_amb_stone_l19f", "")
			end

			local var_74_33 = 1.53333333333333
			local var_74_34 = 1

			if var_74_33 < arg_71_1.time_ and arg_71_1.time_ <= var_74_33 + arg_74_0 then
				local var_74_35 = "play"
				local var_74_36 = "effect"

				arg_71_1:AudioAction(var_74_35, var_74_36, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_74_37 = 1.53333333333333
			local var_74_38 = 1

			if var_74_37 < arg_71_1.time_ and arg_71_1.time_ <= var_74_37 + arg_74_0 then
				local var_74_39 = "play"
				local var_74_40 = "effect"

				arg_71_1:AudioAction(var_74_39, var_74_40, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_74_41 = 0
			local var_74_42 = 0.3

			if var_74_41 < arg_71_1.time_ and arg_71_1.time_ <= var_74_41 + arg_74_0 then
				local var_74_43 = "play"
				local var_74_44 = "music"

				arg_71_1:AudioAction(var_74_43, var_74_44, "ui_battle", "ui_battle_stopbgm", "")

				local var_74_45 = ""
				local var_74_46 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_74_46 ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_46 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_46

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_46
						arg_71_1.bgmTxt2_.text = var_74_46
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_74_47 = 0.500666666666667
			local var_74_48 = 1

			if var_74_47 < arg_71_1.time_ and arg_71_1.time_ <= var_74_47 + arg_74_0 then
				local var_74_49 = "play"
				local var_74_50 = "music"

				arg_71_1:AudioAction(var_74_49, var_74_50, "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard.awb")

				local var_74_51 = ""
				local var_74_52 = manager.audio:GetAudioName("bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard")

				if var_74_52 ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_52 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_52

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_52
						arg_71_1.bgmTxt2_.text = var_74_52
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_53 = 4
			local var_74_54 = 1.025

			if var_74_53 < arg_71_1.time_ and arg_71_1.time_ <= var_74_53 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_55 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_55:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_71_1.dialogCg_.alpha = arg_77_0
				end))
				var_74_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_56 = arg_71_1:GetWordFromCfg(322112017)
				local var_74_57 = arg_71_1:FormatText(var_74_56.content)

				arg_71_1.text_.text = var_74_57

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_58 = 41
				local var_74_59 = utf8.len(var_74_57)
				local var_74_60 = var_74_58 <= 0 and var_74_54 or var_74_54 * (var_74_59 / var_74_58)

				if var_74_60 > 0 and var_74_54 < var_74_60 then
					arg_71_1.talkMaxDuration = var_74_60
					var_74_53 = var_74_53 + 0.3

					if var_74_60 + var_74_53 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_60 + var_74_53
					end
				end

				arg_71_1.text_.text = var_74_57
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_61 = var_74_53 + 0.3
			local var_74_62 = math.max(var_74_54, arg_71_1.talkMaxDuration)

			if var_74_61 <= arg_71_1.time_ and arg_71_1.time_ < var_74_61 + var_74_62 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_61) / var_74_62

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_61 + var_74_62 and arg_71_1.time_ < var_74_61 + var_74_62 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play322112018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 322112018
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play322112019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.5
			local var_82_1 = 1

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				local var_82_2 = "play"
				local var_82_3 = "effect"

				arg_79_1:AudioAction(var_82_2, var_82_3, "se_story_121_04", "se_story_121_04_walk", "")
			end

			local var_82_4 = 0
			local var_82_5 = 1.15

			if var_82_4 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(322112018)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_8 = 46
				local var_82_9 = utf8.len(var_82_7)
				local var_82_10 = var_82_8 <= 0 and var_82_5 or var_82_5 * (var_82_9 / var_82_8)

				if var_82_10 > 0 and var_82_5 < var_82_10 then
					arg_79_1.talkMaxDuration = var_82_10

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_11 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_11 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_11

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_11 and arg_79_1.time_ < var_82_4 + var_82_11 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play322112019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 322112019
		arg_83_1.duration_ = 5.63

		local var_83_0 = {
			zh = 3.4,
			ja = 5.633
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
				arg_83_0:Play322112020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.4

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[487].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(322112019)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 16
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112019", "story_v_out_322112.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112019", "story_v_out_322112.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_322112", "322112019", "story_v_out_322112.awb")

						arg_83_1:RecordAudio("322112019", var_86_9)
						arg_83_1:RecordAudio("322112019", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_322112", "322112019", "story_v_out_322112.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_322112", "322112019", "story_v_out_322112.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_10 and arg_83_1.time_ < var_86_0 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play322112020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 322112020
		arg_87_1.duration_ = 10.73

		local var_87_0 = {
			zh = 7.433,
			ja = 10.733
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
				arg_87_0:Play322112021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = "10049ui_story"

			if arg_87_1.actors_[var_90_0] == nil then
				local var_90_1 = Asset.Load("Char/" .. "10049ui_story")

				if not isNil(var_90_1) then
					local var_90_2 = Object.Instantiate(Asset.Load("Char/" .. "10049ui_story"), arg_87_1.stage_.transform)

					var_90_2.name = var_90_0
					var_90_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_87_1.actors_[var_90_0] = var_90_2

					local var_90_3 = var_90_2:GetComponentInChildren(typeof(CharacterEffect))

					var_90_3.enabled = true

					local var_90_4 = GameObjectTools.GetOrAddComponent(var_90_2, typeof(DynamicBoneHelper))

					if var_90_4 then
						var_90_4:EnableDynamicBone(false)
					end

					arg_87_1:ShowWeapon(var_90_3.transform, false)

					arg_87_1.var_[var_90_0 .. "Animator"] = var_90_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_87_1.var_[var_90_0 .. "Animator"].applyRootMotion = true
					arg_87_1.var_[var_90_0 .. "LipSync"] = var_90_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_90_5 = arg_87_1.actors_["10049ui_story"].transform
			local var_90_6 = 0

			if var_90_6 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.var_.moveOldPos10049ui_story = var_90_5.localPosition

				local var_90_7 = GameObjectTools.GetOrAddComponent(var_90_5.gameObject, typeof(DynamicBoneHelper))

				if var_90_7 then
					var_90_7:EnableDynamicBone(false)
				end
			end

			local var_90_8 = 0.001

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_8 then
				local var_90_9 = (arg_87_1.time_ - var_90_6) / var_90_8
				local var_90_10 = Vector3.New(0, -1.13, -6)

				var_90_5.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10049ui_story, var_90_10, var_90_9)

				local var_90_11 = manager.ui.mainCamera.transform.position - var_90_5.position

				var_90_5.forward = Vector3.New(var_90_11.x, var_90_11.y, var_90_11.z)

				local var_90_12 = var_90_5.localEulerAngles

				var_90_12.z = 0
				var_90_12.x = 0
				var_90_5.localEulerAngles = var_90_12
			end

			if arg_87_1.time_ >= var_90_6 + var_90_8 and arg_87_1.time_ < var_90_6 + var_90_8 + arg_90_0 then
				var_90_5.localPosition = Vector3.New(0, -1.13, -6)

				local var_90_13 = manager.ui.mainCamera.transform.position - var_90_5.position

				var_90_5.forward = Vector3.New(var_90_13.x, var_90_13.y, var_90_13.z)

				local var_90_14 = var_90_5.localEulerAngles

				var_90_14.z = 0
				var_90_14.x = 0
				var_90_5.localEulerAngles = var_90_14

				local var_90_15 = GameObjectTools.GetOrAddComponent(var_90_5.gameObject, typeof(DynamicBoneHelper))

				if var_90_15 then
					var_90_15:EnableDynamicBone(true)
				end
			end

			local var_90_16 = arg_87_1.actors_["10049ui_story"]
			local var_90_17 = 0

			if var_90_17 < arg_87_1.time_ and arg_87_1.time_ <= var_90_17 + arg_90_0 and not isNil(var_90_16) and arg_87_1.var_.characterEffect10049ui_story == nil then
				arg_87_1.var_.characterEffect10049ui_story = var_90_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_18 = 0.200000002980232

			if var_90_17 <= arg_87_1.time_ and arg_87_1.time_ < var_90_17 + var_90_18 and not isNil(var_90_16) then
				local var_90_19 = (arg_87_1.time_ - var_90_17) / var_90_18

				if arg_87_1.var_.characterEffect10049ui_story and not isNil(var_90_16) then
					arg_87_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_17 + var_90_18 and arg_87_1.time_ < var_90_17 + var_90_18 + arg_90_0 and not isNil(var_90_16) and arg_87_1.var_.characterEffect10049ui_story then
				arg_87_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			local var_90_20 = 0

			if var_90_20 < arg_87_1.time_ and arg_87_1.time_ <= var_90_20 + arg_90_0 then
				arg_87_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action1_1")
			end

			local var_90_21 = 0

			if var_90_21 < arg_87_1.time_ and arg_87_1.time_ <= var_90_21 + arg_90_0 then
				arg_87_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_90_22 = 0

			if var_90_22 < arg_87_1.time_ and arg_87_1.time_ <= var_90_22 + arg_90_0 then
				local var_90_23 = arg_87_1.actors_["10049ui_story"]

				if not isNil(var_90_23) then
					local var_90_24 = GameObjectTools.GetOrAddComponent(var_90_23, typeof(DynamicBoneHelper))

					if var_90_24 then
						var_90_24:EnableDynamicBone(true)
					end
				end
			end

			local var_90_25 = 0
			local var_90_26 = 0.7

			if var_90_25 < arg_87_1.time_ and arg_87_1.time_ <= var_90_25 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_27 = arg_87_1:FormatText(StoryNameCfg[468].name)

				arg_87_1.leftNameTxt_.text = var_90_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_28 = arg_87_1:GetWordFromCfg(322112020)
				local var_90_29 = arg_87_1:FormatText(var_90_28.content)

				arg_87_1.text_.text = var_90_29

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_30 = 28
				local var_90_31 = utf8.len(var_90_29)
				local var_90_32 = var_90_30 <= 0 and var_90_26 or var_90_26 * (var_90_31 / var_90_30)

				if var_90_32 > 0 and var_90_26 < var_90_32 then
					arg_87_1.talkMaxDuration = var_90_32

					if var_90_32 + var_90_25 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_32 + var_90_25
					end
				end

				arg_87_1.text_.text = var_90_29
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112020", "story_v_out_322112.awb") ~= 0 then
					local var_90_33 = manager.audio:GetVoiceLength("story_v_out_322112", "322112020", "story_v_out_322112.awb") / 1000

					if var_90_33 + var_90_25 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_33 + var_90_25
					end

					if var_90_28.prefab_name ~= "" and arg_87_1.actors_[var_90_28.prefab_name] ~= nil then
						local var_90_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_28.prefab_name].transform, "story_v_out_322112", "322112020", "story_v_out_322112.awb")

						arg_87_1:RecordAudio("322112020", var_90_34)
						arg_87_1:RecordAudio("322112020", var_90_34)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_322112", "322112020", "story_v_out_322112.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_322112", "322112020", "story_v_out_322112.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_35 = math.max(var_90_26, arg_87_1.talkMaxDuration)

			if var_90_25 <= arg_87_1.time_ and arg_87_1.time_ < var_90_25 + var_90_35 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_25) / var_90_35

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_25 + var_90_35 and arg_87_1.time_ < var_90_25 + var_90_35 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play322112021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 322112021
		arg_91_1.duration_ = 6.4

		local var_91_0 = {
			zh = 5.666,
			ja = 6.4
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
				arg_91_0:Play322112022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10049ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect10049ui_story == nil then
				arg_91_1.var_.characterEffect10049ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect10049ui_story and not isNil(var_94_0) then
					local var_94_4 = Mathf.Lerp(0, 0.5, var_94_3)

					arg_91_1.var_.characterEffect10049ui_story.fillFlat = true
					arg_91_1.var_.characterEffect10049ui_story.fillRatio = var_94_4
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect10049ui_story then
				local var_94_5 = 0.5

				arg_91_1.var_.characterEffect10049ui_story.fillFlat = true
				arg_91_1.var_.characterEffect10049ui_story.fillRatio = var_94_5
			end

			local var_94_6 = 0
			local var_94_7 = 0.7

			if var_94_6 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_8 = arg_91_1:FormatText(StoryNameCfg[487].name)

				arg_91_1.leftNameTxt_.text = var_94_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_9 = arg_91_1:GetWordFromCfg(322112021)
				local var_94_10 = arg_91_1:FormatText(var_94_9.content)

				arg_91_1.text_.text = var_94_10

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_11 = 28
				local var_94_12 = utf8.len(var_94_10)
				local var_94_13 = var_94_11 <= 0 and var_94_7 or var_94_7 * (var_94_12 / var_94_11)

				if var_94_13 > 0 and var_94_7 < var_94_13 then
					arg_91_1.talkMaxDuration = var_94_13

					if var_94_13 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_13 + var_94_6
					end
				end

				arg_91_1.text_.text = var_94_10
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112021", "story_v_out_322112.awb") ~= 0 then
					local var_94_14 = manager.audio:GetVoiceLength("story_v_out_322112", "322112021", "story_v_out_322112.awb") / 1000

					if var_94_14 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_14 + var_94_6
					end

					if var_94_9.prefab_name ~= "" and arg_91_1.actors_[var_94_9.prefab_name] ~= nil then
						local var_94_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_9.prefab_name].transform, "story_v_out_322112", "322112021", "story_v_out_322112.awb")

						arg_91_1:RecordAudio("322112021", var_94_15)
						arg_91_1:RecordAudio("322112021", var_94_15)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_322112", "322112021", "story_v_out_322112.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_322112", "322112021", "story_v_out_322112.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_16 = math.max(var_94_7, arg_91_1.talkMaxDuration)

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_16 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_6) / var_94_16

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_6 + var_94_16 and arg_91_1.time_ < var_94_6 + var_94_16 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play322112022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 322112022
		arg_95_1.duration_ = 4.4

		local var_95_0 = {
			zh = 2.266,
			ja = 4.4
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
				arg_95_0:Play322112023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10049ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos10049ui_story = var_98_0.localPosition

				local var_98_2 = GameObjectTools.GetOrAddComponent(var_98_0.gameObject, typeof(DynamicBoneHelper))

				if var_98_2 then
					var_98_2:EnableDynamicBone(false)
				end
			end

			local var_98_3 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_3 then
				local var_98_4 = (arg_95_1.time_ - var_98_1) / var_98_3
				local var_98_5 = Vector3.New(0, -1.13, -6)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10049ui_story, var_98_5, var_98_4)

				local var_98_6 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_6.x, var_98_6.y, var_98_6.z)

				local var_98_7 = var_98_0.localEulerAngles

				var_98_7.z = 0
				var_98_7.x = 0
				var_98_0.localEulerAngles = var_98_7
			end

			if arg_95_1.time_ >= var_98_1 + var_98_3 and arg_95_1.time_ < var_98_1 + var_98_3 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, -1.13, -6)

				local var_98_8 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_8.x, var_98_8.y, var_98_8.z)

				local var_98_9 = var_98_0.localEulerAngles

				var_98_9.z = 0
				var_98_9.x = 0
				var_98_0.localEulerAngles = var_98_9

				local var_98_10 = GameObjectTools.GetOrAddComponent(var_98_0.gameObject, typeof(DynamicBoneHelper))

				if var_98_10 then
					var_98_10:EnableDynamicBone(true)
				end
			end

			local var_98_11 = arg_95_1.actors_["10049ui_story"]
			local var_98_12 = 0

			if var_98_12 < arg_95_1.time_ and arg_95_1.time_ <= var_98_12 + arg_98_0 and not isNil(var_98_11) and arg_95_1.var_.characterEffect10049ui_story == nil then
				arg_95_1.var_.characterEffect10049ui_story = var_98_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_13 = 0.200000002980232

			if var_98_12 <= arg_95_1.time_ and arg_95_1.time_ < var_98_12 + var_98_13 and not isNil(var_98_11) then
				local var_98_14 = (arg_95_1.time_ - var_98_12) / var_98_13

				if arg_95_1.var_.characterEffect10049ui_story and not isNil(var_98_11) then
					arg_95_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_12 + var_98_13 and arg_95_1.time_ < var_98_12 + var_98_13 + arg_98_0 and not isNil(var_98_11) and arg_95_1.var_.characterEffect10049ui_story then
				arg_95_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			local var_98_15 = 0

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				arg_95_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action1_1")
			end

			local var_98_16 = 0

			if var_98_16 < arg_95_1.time_ and arg_95_1.time_ <= var_98_16 + arg_98_0 then
				arg_95_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_98_17 = 0

			if var_98_17 < arg_95_1.time_ and arg_95_1.time_ <= var_98_17 + arg_98_0 then
				local var_98_18 = arg_95_1.actors_["10049ui_story"]

				if not isNil(var_98_18) then
					local var_98_19 = GameObjectTools.GetOrAddComponent(var_98_18, typeof(DynamicBoneHelper))

					if var_98_19 then
						var_98_19:EnableDynamicBone(true)
					end
				end
			end

			local var_98_20 = 0
			local var_98_21 = 0.2

			if var_98_20 < arg_95_1.time_ and arg_95_1.time_ <= var_98_20 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_22 = arg_95_1:FormatText(StoryNameCfg[468].name)

				arg_95_1.leftNameTxt_.text = var_98_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_23 = arg_95_1:GetWordFromCfg(322112022)
				local var_98_24 = arg_95_1:FormatText(var_98_23.content)

				arg_95_1.text_.text = var_98_24

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_25 = 8
				local var_98_26 = utf8.len(var_98_24)
				local var_98_27 = var_98_25 <= 0 and var_98_21 or var_98_21 * (var_98_26 / var_98_25)

				if var_98_27 > 0 and var_98_21 < var_98_27 then
					arg_95_1.talkMaxDuration = var_98_27

					if var_98_27 + var_98_20 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_27 + var_98_20
					end
				end

				arg_95_1.text_.text = var_98_24
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112022", "story_v_out_322112.awb") ~= 0 then
					local var_98_28 = manager.audio:GetVoiceLength("story_v_out_322112", "322112022", "story_v_out_322112.awb") / 1000

					if var_98_28 + var_98_20 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_28 + var_98_20
					end

					if var_98_23.prefab_name ~= "" and arg_95_1.actors_[var_98_23.prefab_name] ~= nil then
						local var_98_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_23.prefab_name].transform, "story_v_out_322112", "322112022", "story_v_out_322112.awb")

						arg_95_1:RecordAudio("322112022", var_98_29)
						arg_95_1:RecordAudio("322112022", var_98_29)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_322112", "322112022", "story_v_out_322112.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_322112", "322112022", "story_v_out_322112.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_30 = math.max(var_98_21, arg_95_1.talkMaxDuration)

			if var_98_20 <= arg_95_1.time_ and arg_95_1.time_ < var_98_20 + var_98_30 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_20) / var_98_30

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_20 + var_98_30 and arg_95_1.time_ < var_98_20 + var_98_30 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play322112023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 322112023
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play322112024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["10049ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos10049ui_story = var_102_0.localPosition

				local var_102_2 = GameObjectTools.GetOrAddComponent(var_102_0.gameObject, typeof(DynamicBoneHelper))

				if var_102_2 then
					var_102_2:EnableDynamicBone(false)
				end
			end

			local var_102_3 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_3 then
				local var_102_4 = (arg_99_1.time_ - var_102_1) / var_102_3
				local var_102_5 = Vector3.New(0, 100, 0)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10049ui_story, var_102_5, var_102_4)

				local var_102_6 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_6.x, var_102_6.y, var_102_6.z)

				local var_102_7 = var_102_0.localEulerAngles

				var_102_7.z = 0
				var_102_7.x = 0
				var_102_0.localEulerAngles = var_102_7
			end

			if arg_99_1.time_ >= var_102_1 + var_102_3 and arg_99_1.time_ < var_102_1 + var_102_3 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, 100, 0)

				local var_102_8 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_8.x, var_102_8.y, var_102_8.z)

				local var_102_9 = var_102_0.localEulerAngles

				var_102_9.z = 0
				var_102_9.x = 0
				var_102_0.localEulerAngles = var_102_9

				local var_102_10 = GameObjectTools.GetOrAddComponent(var_102_0.gameObject, typeof(DynamicBoneHelper))

				if var_102_10 then
					var_102_10:EnableDynamicBone(true)
				end
			end

			local var_102_11 = 0
			local var_102_12 = 0.725

			if var_102_11 < arg_99_1.time_ and arg_99_1.time_ <= var_102_11 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_13 = arg_99_1:GetWordFromCfg(322112023)
				local var_102_14 = arg_99_1:FormatText(var_102_13.content)

				arg_99_1.text_.text = var_102_14

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_15 = 29
				local var_102_16 = utf8.len(var_102_14)
				local var_102_17 = var_102_15 <= 0 and var_102_12 or var_102_12 * (var_102_16 / var_102_15)

				if var_102_17 > 0 and var_102_12 < var_102_17 then
					arg_99_1.talkMaxDuration = var_102_17

					if var_102_17 + var_102_11 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_17 + var_102_11
					end
				end

				arg_99_1.text_.text = var_102_14
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_18 = math.max(var_102_12, arg_99_1.talkMaxDuration)

			if var_102_11 <= arg_99_1.time_ and arg_99_1.time_ < var_102_11 + var_102_18 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_11) / var_102_18

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_11 + var_102_18 and arg_99_1.time_ < var_102_11 + var_102_18 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play322112024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 322112024
		arg_103_1.duration_ = 7.5

		local var_103_0 = {
			zh = 5.8,
			ja = 7.5
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play322112025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.75

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[487].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_3 = arg_103_1:GetWordFromCfg(322112024)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 30
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112024", "story_v_out_322112.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112024", "story_v_out_322112.awb") / 1000

					if var_106_8 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_0
					end

					if var_106_3.prefab_name ~= "" and arg_103_1.actors_[var_106_3.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_3.prefab_name].transform, "story_v_out_322112", "322112024", "story_v_out_322112.awb")

						arg_103_1:RecordAudio("322112024", var_106_9)
						arg_103_1:RecordAudio("322112024", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_322112", "322112024", "story_v_out_322112.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_322112", "322112024", "story_v_out_322112.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_10 and arg_103_1.time_ < var_106_0 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play322112025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 322112025
		arg_107_1.duration_ = 7.37

		local var_107_0 = {
			zh = 7.366,
			ja = 6.966
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
				arg_107_0:Play322112026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10049ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos10049ui_story = var_110_0.localPosition

				local var_110_2 = GameObjectTools.GetOrAddComponent(var_110_0.gameObject, typeof(DynamicBoneHelper))

				if var_110_2 then
					var_110_2:EnableDynamicBone(false)
				end
			end

			local var_110_3 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_3 then
				local var_110_4 = (arg_107_1.time_ - var_110_1) / var_110_3
				local var_110_5 = Vector3.New(0, -1.13, -6)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10049ui_story, var_110_5, var_110_4)

				local var_110_6 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_6.x, var_110_6.y, var_110_6.z)

				local var_110_7 = var_110_0.localEulerAngles

				var_110_7.z = 0
				var_110_7.x = 0
				var_110_0.localEulerAngles = var_110_7
			end

			if arg_107_1.time_ >= var_110_1 + var_110_3 and arg_107_1.time_ < var_110_1 + var_110_3 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0, -1.13, -6)

				local var_110_8 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_8.x, var_110_8.y, var_110_8.z)

				local var_110_9 = var_110_0.localEulerAngles

				var_110_9.z = 0
				var_110_9.x = 0
				var_110_0.localEulerAngles = var_110_9

				local var_110_10 = GameObjectTools.GetOrAddComponent(var_110_0.gameObject, typeof(DynamicBoneHelper))

				if var_110_10 then
					var_110_10:EnableDynamicBone(true)
				end
			end

			local var_110_11 = arg_107_1.actors_["10049ui_story"]
			local var_110_12 = 0

			if var_110_12 < arg_107_1.time_ and arg_107_1.time_ <= var_110_12 + arg_110_0 and not isNil(var_110_11) and arg_107_1.var_.characterEffect10049ui_story == nil then
				arg_107_1.var_.characterEffect10049ui_story = var_110_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_13 = 0.200000002980232

			if var_110_12 <= arg_107_1.time_ and arg_107_1.time_ < var_110_12 + var_110_13 and not isNil(var_110_11) then
				local var_110_14 = (arg_107_1.time_ - var_110_12) / var_110_13

				if arg_107_1.var_.characterEffect10049ui_story and not isNil(var_110_11) then
					arg_107_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_12 + var_110_13 and arg_107_1.time_ < var_110_12 + var_110_13 + arg_110_0 and not isNil(var_110_11) and arg_107_1.var_.characterEffect10049ui_story then
				arg_107_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			local var_110_15 = 0

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action3_1")
			end

			local var_110_16 = 0

			if var_110_16 < arg_107_1.time_ and arg_107_1.time_ <= var_110_16 + arg_110_0 then
				arg_107_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_110_17 = 0

			if var_110_17 < arg_107_1.time_ and arg_107_1.time_ <= var_110_17 + arg_110_0 then
				local var_110_18 = arg_107_1.actors_["10049ui_story"]

				if not isNil(var_110_18) then
					local var_110_19 = GameObjectTools.GetOrAddComponent(var_110_18, typeof(DynamicBoneHelper))

					if var_110_19 then
						var_110_19:EnableDynamicBone(true)
					end
				end
			end

			local var_110_20 = 0
			local var_110_21 = 0.775

			if var_110_20 < arg_107_1.time_ and arg_107_1.time_ <= var_110_20 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_22 = arg_107_1:FormatText(StoryNameCfg[468].name)

				arg_107_1.leftNameTxt_.text = var_110_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_23 = arg_107_1:GetWordFromCfg(322112025)
				local var_110_24 = arg_107_1:FormatText(var_110_23.content)

				arg_107_1.text_.text = var_110_24

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_25 = 31
				local var_110_26 = utf8.len(var_110_24)
				local var_110_27 = var_110_25 <= 0 and var_110_21 or var_110_21 * (var_110_26 / var_110_25)

				if var_110_27 > 0 and var_110_21 < var_110_27 then
					arg_107_1.talkMaxDuration = var_110_27

					if var_110_27 + var_110_20 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_27 + var_110_20
					end
				end

				arg_107_1.text_.text = var_110_24
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112025", "story_v_out_322112.awb") ~= 0 then
					local var_110_28 = manager.audio:GetVoiceLength("story_v_out_322112", "322112025", "story_v_out_322112.awb") / 1000

					if var_110_28 + var_110_20 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_28 + var_110_20
					end

					if var_110_23.prefab_name ~= "" and arg_107_1.actors_[var_110_23.prefab_name] ~= nil then
						local var_110_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_23.prefab_name].transform, "story_v_out_322112", "322112025", "story_v_out_322112.awb")

						arg_107_1:RecordAudio("322112025", var_110_29)
						arg_107_1:RecordAudio("322112025", var_110_29)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_322112", "322112025", "story_v_out_322112.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_322112", "322112025", "story_v_out_322112.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_30 = math.max(var_110_21, arg_107_1.talkMaxDuration)

			if var_110_20 <= arg_107_1.time_ and arg_107_1.time_ < var_110_20 + var_110_30 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_20) / var_110_30

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_20 + var_110_30 and arg_107_1.time_ < var_110_20 + var_110_30 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play322112026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 322112026
		arg_111_1.duration_ = 10.97

		local var_111_0 = {
			zh = 8.033,
			ja = 10.966
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
				arg_111_0:Play322112027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.85

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[468].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:GetWordFromCfg(322112026)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 34
				local var_114_6 = utf8.len(var_114_4)
				local var_114_7 = var_114_5 <= 0 and var_114_1 or var_114_1 * (var_114_6 / var_114_5)

				if var_114_7 > 0 and var_114_1 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112026", "story_v_out_322112.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112026", "story_v_out_322112.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_322112", "322112026", "story_v_out_322112.awb")

						arg_111_1:RecordAudio("322112026", var_114_9)
						arg_111_1:RecordAudio("322112026", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_322112", "322112026", "story_v_out_322112.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_322112", "322112026", "story_v_out_322112.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_10 and arg_111_1.time_ < var_114_0 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play322112027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 322112027
		arg_115_1.duration_ = 7.2

		local var_115_0 = {
			zh = 7.2,
			ja = 6.666
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
				arg_115_0:Play322112028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.6

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[468].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:GetWordFromCfg(322112027)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 24
				local var_118_6 = utf8.len(var_118_4)
				local var_118_7 = var_118_5 <= 0 and var_118_1 or var_118_1 * (var_118_6 / var_118_5)

				if var_118_7 > 0 and var_118_1 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112027", "story_v_out_322112.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112027", "story_v_out_322112.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_322112", "322112027", "story_v_out_322112.awb")

						arg_115_1:RecordAudio("322112027", var_118_9)
						arg_115_1:RecordAudio("322112027", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_322112", "322112027", "story_v_out_322112.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_322112", "322112027", "story_v_out_322112.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_10 and arg_115_1.time_ < var_118_0 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play322112028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 322112028
		arg_119_1.duration_ = 11.6

		local var_119_0 = {
			zh = 10.2,
			ja = 11.6
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play322112029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 0.975

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_2 = arg_119_1:FormatText(StoryNameCfg[468].name)

				arg_119_1.leftNameTxt_.text = var_122_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_3 = arg_119_1:GetWordFromCfg(322112028)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 39
				local var_122_6 = utf8.len(var_122_4)
				local var_122_7 = var_122_5 <= 0 and var_122_1 or var_122_1 * (var_122_6 / var_122_5)

				if var_122_7 > 0 and var_122_1 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112028", "story_v_out_322112.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112028", "story_v_out_322112.awb") / 1000

					if var_122_8 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_0
					end

					if var_122_3.prefab_name ~= "" and arg_119_1.actors_[var_122_3.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_3.prefab_name].transform, "story_v_out_322112", "322112028", "story_v_out_322112.awb")

						arg_119_1:RecordAudio("322112028", var_122_9)
						arg_119_1:RecordAudio("322112028", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_322112", "322112028", "story_v_out_322112.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_322112", "322112028", "story_v_out_322112.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_10 and arg_119_1.time_ < var_122_0 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play322112029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 322112029
		arg_123_1.duration_ = 5.7

		local var_123_0 = {
			zh = 5.7,
			ja = 5.466
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
				arg_123_0:Play322112030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action3_2")
			end

			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_126_2 = 0

			if var_126_2 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				local var_126_3 = arg_123_1.actors_["10049ui_story"]

				if not isNil(var_126_3) then
					local var_126_4 = GameObjectTools.GetOrAddComponent(var_126_3, typeof(DynamicBoneHelper))

					if var_126_4 then
						var_126_4:EnableDynamicBone(true)
					end
				end
			end

			local var_126_5 = 0
			local var_126_6 = 0.5

			if var_126_5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_7 = arg_123_1:FormatText(StoryNameCfg[468].name)

				arg_123_1.leftNameTxt_.text = var_126_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_8 = arg_123_1:GetWordFromCfg(322112029)
				local var_126_9 = arg_123_1:FormatText(var_126_8.content)

				arg_123_1.text_.text = var_126_9

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_10 = 20
				local var_126_11 = utf8.len(var_126_9)
				local var_126_12 = var_126_10 <= 0 and var_126_6 or var_126_6 * (var_126_11 / var_126_10)

				if var_126_12 > 0 and var_126_6 < var_126_12 then
					arg_123_1.talkMaxDuration = var_126_12

					if var_126_12 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_12 + var_126_5
					end
				end

				arg_123_1.text_.text = var_126_9
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112029", "story_v_out_322112.awb") ~= 0 then
					local var_126_13 = manager.audio:GetVoiceLength("story_v_out_322112", "322112029", "story_v_out_322112.awb") / 1000

					if var_126_13 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_5
					end

					if var_126_8.prefab_name ~= "" and arg_123_1.actors_[var_126_8.prefab_name] ~= nil then
						local var_126_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_8.prefab_name].transform, "story_v_out_322112", "322112029", "story_v_out_322112.awb")

						arg_123_1:RecordAudio("322112029", var_126_14)
						arg_123_1:RecordAudio("322112029", var_126_14)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_322112", "322112029", "story_v_out_322112.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_322112", "322112029", "story_v_out_322112.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_15 = math.max(var_126_6, arg_123_1.talkMaxDuration)

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_15 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_5) / var_126_15

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_5 + var_126_15 and arg_123_1.time_ < var_126_5 + var_126_15 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play322112030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 322112030
		arg_127_1.duration_ = 9

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play322112031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = "L14f"

			if arg_127_1.bgs_[var_130_0] == nil then
				local var_130_1 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_130_0)
				var_130_1.name = var_130_0
				var_130_1.transform.parent = arg_127_1.stage_.transform
				var_130_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_[var_130_0] = var_130_1
			end

			local var_130_2 = 1.999999999999

			if var_130_2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				local var_130_3 = manager.ui.mainCamera.transform.localPosition
				local var_130_4 = Vector3.New(0, 0, 10) + Vector3.New(var_130_3.x, var_130_3.y, 0)
				local var_130_5 = arg_127_1.bgs_.L14f

				var_130_5.transform.localPosition = var_130_4
				var_130_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_6 = var_130_5:GetComponent("SpriteRenderer")

				if var_130_6 and var_130_6.sprite then
					local var_130_7 = (var_130_5.transform.localPosition - var_130_3).z
					local var_130_8 = manager.ui.mainCameraCom_
					local var_130_9 = 2 * var_130_7 * Mathf.Tan(var_130_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_130_10 = var_130_9 * var_130_8.aspect
					local var_130_11 = var_130_6.sprite.bounds.size.x
					local var_130_12 = var_130_6.sprite.bounds.size.y
					local var_130_13 = var_130_10 / var_130_11
					local var_130_14 = var_130_9 / var_130_12
					local var_130_15 = var_130_14 < var_130_13 and var_130_13 or var_130_14

					var_130_5.transform.localScale = Vector3.New(var_130_15, var_130_15, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "L14f" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_16 = 4

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.allBtn_.enabled = false
			end

			local var_130_17 = 0.3

			if arg_127_1.time_ >= var_130_16 + var_130_17 and arg_127_1.time_ < var_130_16 + var_130_17 + arg_130_0 then
				arg_127_1.allBtn_.enabled = true
			end

			local var_130_18 = 0

			if var_130_18 < arg_127_1.time_ and arg_127_1.time_ <= var_130_18 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_19 = 2

			if var_130_18 <= arg_127_1.time_ and arg_127_1.time_ < var_130_18 + var_130_19 then
				local var_130_20 = (arg_127_1.time_ - var_130_18) / var_130_19
				local var_130_21 = Color.New(0, 0, 0)

				var_130_21.a = Mathf.Lerp(0, 1, var_130_20)
				arg_127_1.mask_.color = var_130_21
			end

			if arg_127_1.time_ >= var_130_18 + var_130_19 and arg_127_1.time_ < var_130_18 + var_130_19 + arg_130_0 then
				local var_130_22 = Color.New(0, 0, 0)

				var_130_22.a = 1
				arg_127_1.mask_.color = var_130_22
			end

			local var_130_23 = 2

			if var_130_23 < arg_127_1.time_ and arg_127_1.time_ <= var_130_23 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_24 = 2

			if var_130_23 <= arg_127_1.time_ and arg_127_1.time_ < var_130_23 + var_130_24 then
				local var_130_25 = (arg_127_1.time_ - var_130_23) / var_130_24
				local var_130_26 = Color.New(0, 0, 0)

				var_130_26.a = Mathf.Lerp(1, 0, var_130_25)
				arg_127_1.mask_.color = var_130_26
			end

			if arg_127_1.time_ >= var_130_23 + var_130_24 and arg_127_1.time_ < var_130_23 + var_130_24 + arg_130_0 then
				local var_130_27 = Color.New(0, 0, 0)
				local var_130_28 = 0

				arg_127_1.mask_.enabled = false
				var_130_27.a = var_130_28
				arg_127_1.mask_.color = var_130_27
			end

			local var_130_29 = arg_127_1.actors_["10049ui_story"].transform
			local var_130_30 = 1.999999999999

			if var_130_30 < arg_127_1.time_ and arg_127_1.time_ <= var_130_30 + arg_130_0 then
				arg_127_1.var_.moveOldPos10049ui_story = var_130_29.localPosition

				local var_130_31 = GameObjectTools.GetOrAddComponent(var_130_29.gameObject, typeof(DynamicBoneHelper))

				if var_130_31 then
					var_130_31:EnableDynamicBone(false)
				end
			end

			local var_130_32 = 0.001

			if var_130_30 <= arg_127_1.time_ and arg_127_1.time_ < var_130_30 + var_130_32 then
				local var_130_33 = (arg_127_1.time_ - var_130_30) / var_130_32
				local var_130_34 = Vector3.New(0, 100, 0)

				var_130_29.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10049ui_story, var_130_34, var_130_33)

				local var_130_35 = manager.ui.mainCamera.transform.position - var_130_29.position

				var_130_29.forward = Vector3.New(var_130_35.x, var_130_35.y, var_130_35.z)

				local var_130_36 = var_130_29.localEulerAngles

				var_130_36.z = 0
				var_130_36.x = 0
				var_130_29.localEulerAngles = var_130_36
			end

			if arg_127_1.time_ >= var_130_30 + var_130_32 and arg_127_1.time_ < var_130_30 + var_130_32 + arg_130_0 then
				var_130_29.localPosition = Vector3.New(0, 100, 0)

				local var_130_37 = manager.ui.mainCamera.transform.position - var_130_29.position

				var_130_29.forward = Vector3.New(var_130_37.x, var_130_37.y, var_130_37.z)

				local var_130_38 = var_130_29.localEulerAngles

				var_130_38.z = 0
				var_130_38.x = 0
				var_130_29.localEulerAngles = var_130_38

				local var_130_39 = GameObjectTools.GetOrAddComponent(var_130_29.gameObject, typeof(DynamicBoneHelper))

				if var_130_39 then
					var_130_39:EnableDynamicBone(true)
				end
			end

			local var_130_40 = arg_127_1.actors_["10049ui_story"]
			local var_130_41 = 1.999999999999

			if var_130_41 < arg_127_1.time_ and arg_127_1.time_ <= var_130_41 + arg_130_0 and not isNil(var_130_40) and arg_127_1.var_.characterEffect10049ui_story == nil then
				arg_127_1.var_.characterEffect10049ui_story = var_130_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_42 = 0.200000002980232

			if var_130_41 <= arg_127_1.time_ and arg_127_1.time_ < var_130_41 + var_130_42 and not isNil(var_130_40) then
				local var_130_43 = (arg_127_1.time_ - var_130_41) / var_130_42

				if arg_127_1.var_.characterEffect10049ui_story and not isNil(var_130_40) then
					local var_130_44 = Mathf.Lerp(0, 0.5, var_130_43)

					arg_127_1.var_.characterEffect10049ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10049ui_story.fillRatio = var_130_44
				end
			end

			if arg_127_1.time_ >= var_130_41 + var_130_42 and arg_127_1.time_ < var_130_41 + var_130_42 + arg_130_0 and not isNil(var_130_40) and arg_127_1.var_.characterEffect10049ui_story then
				local var_130_45 = 0.5

				arg_127_1.var_.characterEffect10049ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10049ui_story.fillRatio = var_130_45
			end

			local var_130_46 = 1.6
			local var_130_47 = 1

			if var_130_46 < arg_127_1.time_ and arg_127_1.time_ <= var_130_46 + arg_130_0 then
				local var_130_48 = "play"
				local var_130_49 = "effect"

				arg_127_1:AudioAction(var_130_48, var_130_49, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_130_50 = 0.1
			local var_130_51 = 1

			if var_130_50 < arg_127_1.time_ and arg_127_1.time_ <= var_130_50 + arg_130_0 then
				local var_130_52 = "stop"
				local var_130_53 = "effect"

				arg_127_1:AudioAction(var_130_52, var_130_53, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_130_54 = 0.1
			local var_130_55 = 1

			if var_130_54 < arg_127_1.time_ and arg_127_1.time_ <= var_130_54 + arg_130_0 then
				local var_130_56 = "stop"
				local var_130_57 = "effect"

				arg_127_1:AudioAction(var_130_56, var_130_57, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_130_58 = 0.1
			local var_130_59 = 0.3

			if var_130_58 < arg_127_1.time_ and arg_127_1.time_ <= var_130_58 + arg_130_0 then
				local var_130_60 = "play"
				local var_130_61 = "music"

				arg_127_1:AudioAction(var_130_60, var_130_61, "ui_battle", "ui_battle_stopbgm", "")

				local var_130_62 = ""
				local var_130_63 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_130_63 ~= "" then
					if arg_127_1.bgmTxt_.text ~= var_130_63 and arg_127_1.bgmTxt_.text ~= "" then
						if arg_127_1.bgmTxt2_.text ~= "" then
							arg_127_1.bgmTxt_.text = arg_127_1.bgmTxt2_.text
						end

						arg_127_1.bgmTxt2_.text = var_130_63

						arg_127_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_127_1.bgmTxt_.text = var_130_63
						arg_127_1.bgmTxt2_.text = var_130_63
					end

					if arg_127_1.bgmTimer then
						arg_127_1.bgmTimer:Stop()

						arg_127_1.bgmTimer = nil
					end

					if arg_127_1.settingData.show_music_name == 1 then
						arg_127_1.musicController:SetSelectedState("show")
						arg_127_1.musicAnimator_:Play("open", 0, 0)

						if arg_127_1.settingData.music_time ~= 0 then
							arg_127_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_127_1.settingData.music_time), function()
								if arg_127_1 == nil or isNil(arg_127_1.bgmTxt_) then
									return
								end

								arg_127_1.musicController:SetSelectedState("hide")
								arg_127_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_130_64 = 1.6
			local var_130_65 = 1

			if var_130_64 < arg_127_1.time_ and arg_127_1.time_ <= var_130_64 + arg_130_0 then
				local var_130_66 = "play"
				local var_130_67 = "music"

				arg_127_1:AudioAction(var_130_66, var_130_67, "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

				local var_130_68 = ""
				local var_130_69 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

				if var_130_69 ~= "" then
					if arg_127_1.bgmTxt_.text ~= var_130_69 and arg_127_1.bgmTxt_.text ~= "" then
						if arg_127_1.bgmTxt2_.text ~= "" then
							arg_127_1.bgmTxt_.text = arg_127_1.bgmTxt2_.text
						end

						arg_127_1.bgmTxt2_.text = var_130_69

						arg_127_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_127_1.bgmTxt_.text = var_130_69
						arg_127_1.bgmTxt2_.text = var_130_69
					end

					if arg_127_1.bgmTimer then
						arg_127_1.bgmTimer:Stop()

						arg_127_1.bgmTimer = nil
					end

					if arg_127_1.settingData.show_music_name == 1 then
						arg_127_1.musicController:SetSelectedState("show")
						arg_127_1.musicAnimator_:Play("open", 0, 0)

						if arg_127_1.settingData.music_time ~= 0 then
							arg_127_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_127_1.settingData.music_time), function()
								if arg_127_1 == nil or isNil(arg_127_1.bgmTxt_) then
									return
								end

								arg_127_1.musicController:SetSelectedState("hide")
								arg_127_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_70 = 3.999999999999
			local var_130_71 = 1.3

			if var_130_70 < arg_127_1.time_ and arg_127_1.time_ <= var_130_70 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_72 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_72:setOnUpdate(LuaHelper.FloatAction(function(arg_133_0)
					arg_127_1.dialogCg_.alpha = arg_133_0
				end))
				var_130_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_73 = arg_127_1:GetWordFromCfg(322112030)
				local var_130_74 = arg_127_1:FormatText(var_130_73.content)

				arg_127_1.text_.text = var_130_74

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_75 = 52
				local var_130_76 = utf8.len(var_130_74)
				local var_130_77 = var_130_75 <= 0 and var_130_71 or var_130_71 * (var_130_76 / var_130_75)

				if var_130_77 > 0 and var_130_71 < var_130_77 then
					arg_127_1.talkMaxDuration = var_130_77
					var_130_70 = var_130_70 + 0.3

					if var_130_77 + var_130_70 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_77 + var_130_70
					end
				end

				arg_127_1.text_.text = var_130_74
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_78 = var_130_70 + 0.3
			local var_130_79 = math.max(var_130_71, arg_127_1.talkMaxDuration)

			if var_130_78 <= arg_127_1.time_ and arg_127_1.time_ < var_130_78 + var_130_79 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_78) / var_130_79

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_78 + var_130_79 and arg_127_1.time_ < var_130_78 + var_130_79 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play322112031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 322112031
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play322112032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.475

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[7].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(322112031)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 19
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_8 and arg_135_1.time_ < var_138_0 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play322112032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 322112032
		arg_139_1.duration_ = 6.73

		local var_139_0 = {
			zh = 6.033,
			ja = 6.733
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
				arg_139_0:Play322112033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = "1284ui_story"

			if arg_139_1.actors_[var_142_0] == nil then
				local var_142_1 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_142_1) then
					local var_142_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_139_1.stage_.transform)

					var_142_2.name = var_142_0
					var_142_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_139_1.actors_[var_142_0] = var_142_2

					local var_142_3 = var_142_2:GetComponentInChildren(typeof(CharacterEffect))

					var_142_3.enabled = true

					local var_142_4 = GameObjectTools.GetOrAddComponent(var_142_2, typeof(DynamicBoneHelper))

					if var_142_4 then
						var_142_4:EnableDynamicBone(false)
					end

					arg_139_1:ShowWeapon(var_142_3.transform, false)

					arg_139_1.var_[var_142_0 .. "Animator"] = var_142_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_139_1.var_[var_142_0 .. "Animator"].applyRootMotion = true
					arg_139_1.var_[var_142_0 .. "LipSync"] = var_142_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_142_5 = arg_139_1.actors_["1284ui_story"].transform
			local var_142_6 = 0

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.var_.moveOldPos1284ui_story = var_142_5.localPosition
			end

			local var_142_7 = 0.001

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_7 then
				local var_142_8 = (arg_139_1.time_ - var_142_6) / var_142_7
				local var_142_9 = Vector3.New(0, -0.985, -6.22)

				var_142_5.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1284ui_story, var_142_9, var_142_8)

				local var_142_10 = manager.ui.mainCamera.transform.position - var_142_5.position

				var_142_5.forward = Vector3.New(var_142_10.x, var_142_10.y, var_142_10.z)

				local var_142_11 = var_142_5.localEulerAngles

				var_142_11.z = 0
				var_142_11.x = 0
				var_142_5.localEulerAngles = var_142_11
			end

			if arg_139_1.time_ >= var_142_6 + var_142_7 and arg_139_1.time_ < var_142_6 + var_142_7 + arg_142_0 then
				var_142_5.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_142_12 = manager.ui.mainCamera.transform.position - var_142_5.position

				var_142_5.forward = Vector3.New(var_142_12.x, var_142_12.y, var_142_12.z)

				local var_142_13 = var_142_5.localEulerAngles

				var_142_13.z = 0
				var_142_13.x = 0
				var_142_5.localEulerAngles = var_142_13
			end

			local var_142_14 = arg_139_1.actors_["1284ui_story"]
			local var_142_15 = 0

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 and not isNil(var_142_14) and arg_139_1.var_.characterEffect1284ui_story == nil then
				arg_139_1.var_.characterEffect1284ui_story = var_142_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_16 = 0.200000002980232

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_16 and not isNil(var_142_14) then
				local var_142_17 = (arg_139_1.time_ - var_142_15) / var_142_16

				if arg_139_1.var_.characterEffect1284ui_story and not isNil(var_142_14) then
					arg_139_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_15 + var_142_16 and arg_139_1.time_ < var_142_15 + var_142_16 + arg_142_0 and not isNil(var_142_14) and arg_139_1.var_.characterEffect1284ui_story then
				arg_139_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_142_18 = 0

			if var_142_18 < arg_139_1.time_ and arg_139_1.time_ <= var_142_18 + arg_142_0 then
				arg_139_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_142_19 = 0

			if var_142_19 < arg_139_1.time_ and arg_139_1.time_ <= var_142_19 + arg_142_0 then
				arg_139_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_142_20 = 0
			local var_142_21 = 0.65

			if var_142_20 < arg_139_1.time_ and arg_139_1.time_ <= var_142_20 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_22 = arg_139_1:FormatText(StoryNameCfg[6].name)

				arg_139_1.leftNameTxt_.text = var_142_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_23 = arg_139_1:GetWordFromCfg(322112032)
				local var_142_24 = arg_139_1:FormatText(var_142_23.content)

				arg_139_1.text_.text = var_142_24

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_25 = 26
				local var_142_26 = utf8.len(var_142_24)
				local var_142_27 = var_142_25 <= 0 and var_142_21 or var_142_21 * (var_142_26 / var_142_25)

				if var_142_27 > 0 and var_142_21 < var_142_27 then
					arg_139_1.talkMaxDuration = var_142_27

					if var_142_27 + var_142_20 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_27 + var_142_20
					end
				end

				arg_139_1.text_.text = var_142_24
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112032", "story_v_out_322112.awb") ~= 0 then
					local var_142_28 = manager.audio:GetVoiceLength("story_v_out_322112", "322112032", "story_v_out_322112.awb") / 1000

					if var_142_28 + var_142_20 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_28 + var_142_20
					end

					if var_142_23.prefab_name ~= "" and arg_139_1.actors_[var_142_23.prefab_name] ~= nil then
						local var_142_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_23.prefab_name].transform, "story_v_out_322112", "322112032", "story_v_out_322112.awb")

						arg_139_1:RecordAudio("322112032", var_142_29)
						arg_139_1:RecordAudio("322112032", var_142_29)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_322112", "322112032", "story_v_out_322112.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_322112", "322112032", "story_v_out_322112.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_30 = math.max(var_142_21, arg_139_1.talkMaxDuration)

			if var_142_20 <= arg_139_1.time_ and arg_139_1.time_ < var_142_20 + var_142_30 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_20) / var_142_30

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_20 + var_142_30 and arg_139_1.time_ < var_142_20 + var_142_30 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play322112033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 322112033
		arg_143_1.duration_ = 7.13

		local var_143_0 = {
			zh = 6.3,
			ja = 7.133
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
				arg_143_0:Play322112034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_146_2 = 0
			local var_146_3 = 0.525

			if var_146_2 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_4 = arg_143_1:FormatText(StoryNameCfg[6].name)

				arg_143_1.leftNameTxt_.text = var_146_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_5 = arg_143_1:GetWordFromCfg(322112033)
				local var_146_6 = arg_143_1:FormatText(var_146_5.content)

				arg_143_1.text_.text = var_146_6

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 21
				local var_146_8 = utf8.len(var_146_6)
				local var_146_9 = var_146_7 <= 0 and var_146_3 or var_146_3 * (var_146_8 / var_146_7)

				if var_146_9 > 0 and var_146_3 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_6
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112033", "story_v_out_322112.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_out_322112", "322112033", "story_v_out_322112.awb") / 1000

					if var_146_10 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_2
					end

					if var_146_5.prefab_name ~= "" and arg_143_1.actors_[var_146_5.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_5.prefab_name].transform, "story_v_out_322112", "322112033", "story_v_out_322112.awb")

						arg_143_1:RecordAudio("322112033", var_146_11)
						arg_143_1:RecordAudio("322112033", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_322112", "322112033", "story_v_out_322112.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_322112", "322112033", "story_v_out_322112.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_3, arg_143_1.talkMaxDuration)

			if var_146_2 <= arg_143_1.time_ and arg_143_1.time_ < var_146_2 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_2) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_2 + var_146_12 and arg_143_1.time_ < var_146_2 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play322112034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 322112034
		arg_147_1.duration_ = 1

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"

			SetActive(arg_147_1.choicesGo_, true)

			for iter_148_0, iter_148_1 in ipairs(arg_147_1.choices_) do
				local var_148_0 = iter_148_0 <= 2

				SetActive(iter_148_1.go, var_148_0)
			end

			arg_147_1.choices_[1].txt.text = arg_147_1:FormatText(StoryChoiceCfg[1412].name)
			arg_147_1.choices_[2].txt.text = arg_147_1:FormatText(StoryChoiceCfg[1413].name)
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play322112035(arg_147_1)
			end

			if arg_149_0 == 2 then
				arg_147_0:Play322112037(arg_147_1)
			end

			arg_147_1:RecordChoiceLog(322112034, 1412, 1413)
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1284ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1284ui_story == nil then
				arg_147_1.var_.characterEffect1284ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect1284ui_story and not isNil(var_150_0) then
					local var_150_4 = Mathf.Lerp(0, 0.5, var_150_3)

					arg_147_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1284ui_story.fillRatio = var_150_4
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1284ui_story then
				local var_150_5 = 0.5

				arg_147_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1284ui_story.fillRatio = var_150_5
			end

			local var_150_6 = 0

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			local var_150_7 = 0.6

			if arg_147_1.time_ >= var_150_6 + var_150_7 and arg_147_1.time_ < var_150_6 + var_150_7 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play322112035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 322112035
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play322112036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.525

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[7].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:GetWordFromCfg(322112035)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 21
				local var_154_6 = utf8.len(var_154_4)
				local var_154_7 = var_154_5 <= 0 and var_154_1 or var_154_1 * (var_154_6 / var_154_5)

				if var_154_7 > 0 and var_154_1 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_8 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_8 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_8

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_8 and arg_151_1.time_ < var_154_0 + var_154_8 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play322112036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 322112036
		arg_155_1.duration_ = 3.6

		local var_155_0 = {
			zh = 2.333,
			ja = 3.6
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
				arg_155_0:Play322112039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1284ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1284ui_story == nil then
				arg_155_1.var_.characterEffect1284ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect1284ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1284ui_story then
				arg_155_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_158_4 = 0

			if var_158_4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284actionlink/1284action423")
			end

			local var_158_5 = 0

			if var_158_5 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_158_6 = 0
			local var_158_7 = 0.2

			if var_158_6 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_8 = arg_155_1:FormatText(StoryNameCfg[6].name)

				arg_155_1.leftNameTxt_.text = var_158_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_9 = arg_155_1:GetWordFromCfg(322112036)
				local var_158_10 = arg_155_1:FormatText(var_158_9.content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 8
				local var_158_12 = utf8.len(var_158_10)
				local var_158_13 = var_158_11 <= 0 and var_158_7 or var_158_7 * (var_158_12 / var_158_11)

				if var_158_13 > 0 and var_158_7 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_10
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112036", "story_v_out_322112.awb") ~= 0 then
					local var_158_14 = manager.audio:GetVoiceLength("story_v_out_322112", "322112036", "story_v_out_322112.awb") / 1000

					if var_158_14 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_14 + var_158_6
					end

					if var_158_9.prefab_name ~= "" and arg_155_1.actors_[var_158_9.prefab_name] ~= nil then
						local var_158_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_9.prefab_name].transform, "story_v_out_322112", "322112036", "story_v_out_322112.awb")

						arg_155_1:RecordAudio("322112036", var_158_15)
						arg_155_1:RecordAudio("322112036", var_158_15)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_322112", "322112036", "story_v_out_322112.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_322112", "322112036", "story_v_out_322112.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_16 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_16 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_16

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_16 and arg_155_1.time_ < var_158_6 + var_158_16 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play322112039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 322112039
		arg_159_1.duration_ = 2.83

		local var_159_0 = {
			zh = 2.766,
			ja = 2.833
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
				arg_159_0:Play322112040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_2")
			end

			local var_162_1 = arg_159_1.actors_["1284ui_story"]
			local var_162_2 = 0

			if var_162_2 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1284ui_story == nil then
				arg_159_1.var_.characterEffect1284ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_3 = 0.200000002980232

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_3 and not isNil(var_162_1) then
				local var_162_4 = (arg_159_1.time_ - var_162_2) / var_162_3

				if arg_159_1.var_.characterEffect1284ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_2 + var_162_3 and arg_159_1.time_ < var_162_2 + var_162_3 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1284ui_story then
				arg_159_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_162_5 = 0
			local var_162_6 = 0.325

			if var_162_5 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_7 = arg_159_1:FormatText(StoryNameCfg[6].name)

				arg_159_1.leftNameTxt_.text = var_162_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_8 = arg_159_1:GetWordFromCfg(322112039)
				local var_162_9 = arg_159_1:FormatText(var_162_8.content)

				arg_159_1.text_.text = var_162_9

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_10 = 13
				local var_162_11 = utf8.len(var_162_9)
				local var_162_12 = var_162_10 <= 0 and var_162_6 or var_162_6 * (var_162_11 / var_162_10)

				if var_162_12 > 0 and var_162_6 < var_162_12 then
					arg_159_1.talkMaxDuration = var_162_12

					if var_162_12 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_5
					end
				end

				arg_159_1.text_.text = var_162_9
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112039", "story_v_out_322112.awb") ~= 0 then
					local var_162_13 = manager.audio:GetVoiceLength("story_v_out_322112", "322112039", "story_v_out_322112.awb") / 1000

					if var_162_13 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_5
					end

					if var_162_8.prefab_name ~= "" and arg_159_1.actors_[var_162_8.prefab_name] ~= nil then
						local var_162_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_8.prefab_name].transform, "story_v_out_322112", "322112039", "story_v_out_322112.awb")

						arg_159_1:RecordAudio("322112039", var_162_14)
						arg_159_1:RecordAudio("322112039", var_162_14)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_322112", "322112039", "story_v_out_322112.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_322112", "322112039", "story_v_out_322112.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_15 = math.max(var_162_6, arg_159_1.talkMaxDuration)

			if var_162_5 <= arg_159_1.time_ and arg_159_1.time_ < var_162_5 + var_162_15 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_5) / var_162_15

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_5 + var_162_15 and arg_159_1.time_ < var_162_5 + var_162_15 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play322112040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 322112040
		arg_163_1.duration_ = 3

		local var_163_0 = {
			zh = 1.999999999999,
			ja = 3
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
				arg_163_0:Play322112041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = "1211ui_story"

			if arg_163_1.actors_[var_166_0] == nil then
				local var_166_1 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_166_1) then
					local var_166_2 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_163_1.stage_.transform)

					var_166_2.name = var_166_0
					var_166_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_163_1.actors_[var_166_0] = var_166_2

					local var_166_3 = var_166_2:GetComponentInChildren(typeof(CharacterEffect))

					var_166_3.enabled = true

					local var_166_4 = GameObjectTools.GetOrAddComponent(var_166_2, typeof(DynamicBoneHelper))

					if var_166_4 then
						var_166_4:EnableDynamicBone(false)
					end

					arg_163_1:ShowWeapon(var_166_3.transform, false)

					arg_163_1.var_[var_166_0 .. "Animator"] = var_166_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_163_1.var_[var_166_0 .. "Animator"].applyRootMotion = true
					arg_163_1.var_[var_166_0 .. "LipSync"] = var_166_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_166_5 = arg_163_1.actors_["1211ui_story"].transform
			local var_166_6 = 0

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.var_.moveOldPos1211ui_story = var_166_5.localPosition
			end

			local var_166_7 = 0.001

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_7 then
				local var_166_8 = (arg_163_1.time_ - var_166_6) / var_166_7
				local var_166_9 = Vector3.New(0.7, -0.67, -6.07)

				var_166_5.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1211ui_story, var_166_9, var_166_8)

				local var_166_10 = manager.ui.mainCamera.transform.position - var_166_5.position

				var_166_5.forward = Vector3.New(var_166_10.x, var_166_10.y, var_166_10.z)

				local var_166_11 = var_166_5.localEulerAngles

				var_166_11.z = 0
				var_166_11.x = 0
				var_166_5.localEulerAngles = var_166_11
			end

			if arg_163_1.time_ >= var_166_6 + var_166_7 and arg_163_1.time_ < var_166_6 + var_166_7 + arg_166_0 then
				var_166_5.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_166_12 = manager.ui.mainCamera.transform.position - var_166_5.position

				var_166_5.forward = Vector3.New(var_166_12.x, var_166_12.y, var_166_12.z)

				local var_166_13 = var_166_5.localEulerAngles

				var_166_13.z = 0
				var_166_13.x = 0
				var_166_5.localEulerAngles = var_166_13
			end

			local var_166_14 = arg_163_1.actors_["1284ui_story"].transform
			local var_166_15 = 0

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.var_.moveOldPos1284ui_story = var_166_14.localPosition
			end

			local var_166_16 = 0.001

			if var_166_15 <= arg_163_1.time_ and arg_163_1.time_ < var_166_15 + var_166_16 then
				local var_166_17 = (arg_163_1.time_ - var_166_15) / var_166_16
				local var_166_18 = Vector3.New(-0.7, -0.985, -6.22)

				var_166_14.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1284ui_story, var_166_18, var_166_17)

				local var_166_19 = manager.ui.mainCamera.transform.position - var_166_14.position

				var_166_14.forward = Vector3.New(var_166_19.x, var_166_19.y, var_166_19.z)

				local var_166_20 = var_166_14.localEulerAngles

				var_166_20.z = 0
				var_166_20.x = 0
				var_166_14.localEulerAngles = var_166_20
			end

			if arg_163_1.time_ >= var_166_15 + var_166_16 and arg_163_1.time_ < var_166_15 + var_166_16 + arg_166_0 then
				var_166_14.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_166_21 = manager.ui.mainCamera.transform.position - var_166_14.position

				var_166_14.forward = Vector3.New(var_166_21.x, var_166_21.y, var_166_21.z)

				local var_166_22 = var_166_14.localEulerAngles

				var_166_22.z = 0
				var_166_22.x = 0
				var_166_14.localEulerAngles = var_166_22
			end

			local var_166_23 = arg_163_1.actors_["1211ui_story"]
			local var_166_24 = 0

			if var_166_24 < arg_163_1.time_ and arg_163_1.time_ <= var_166_24 + arg_166_0 and not isNil(var_166_23) and arg_163_1.var_.characterEffect1211ui_story == nil then
				arg_163_1.var_.characterEffect1211ui_story = var_166_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_25 = 0.200000002980232

			if var_166_24 <= arg_163_1.time_ and arg_163_1.time_ < var_166_24 + var_166_25 and not isNil(var_166_23) then
				local var_166_26 = (arg_163_1.time_ - var_166_24) / var_166_25

				if arg_163_1.var_.characterEffect1211ui_story and not isNil(var_166_23) then
					arg_163_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_24 + var_166_25 and arg_163_1.time_ < var_166_24 + var_166_25 + arg_166_0 and not isNil(var_166_23) and arg_163_1.var_.characterEffect1211ui_story then
				arg_163_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_166_27 = arg_163_1.actors_["1284ui_story"]
			local var_166_28 = 0

			if var_166_28 < arg_163_1.time_ and arg_163_1.time_ <= var_166_28 + arg_166_0 and not isNil(var_166_27) and arg_163_1.var_.characterEffect1284ui_story == nil then
				arg_163_1.var_.characterEffect1284ui_story = var_166_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_29 = 0.200000002980232

			if var_166_28 <= arg_163_1.time_ and arg_163_1.time_ < var_166_28 + var_166_29 and not isNil(var_166_27) then
				local var_166_30 = (arg_163_1.time_ - var_166_28) / var_166_29

				if arg_163_1.var_.characterEffect1284ui_story and not isNil(var_166_27) then
					local var_166_31 = Mathf.Lerp(0, 0.5, var_166_30)

					arg_163_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1284ui_story.fillRatio = var_166_31
				end
			end

			if arg_163_1.time_ >= var_166_28 + var_166_29 and arg_163_1.time_ < var_166_28 + var_166_29 + arg_166_0 and not isNil(var_166_27) and arg_163_1.var_.characterEffect1284ui_story then
				local var_166_32 = 0.5

				arg_163_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1284ui_story.fillRatio = var_166_32
			end

			local var_166_33 = 0

			if var_166_33 < arg_163_1.time_ and arg_163_1.time_ <= var_166_33 + arg_166_0 then
				arg_163_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_166_34 = 0

			if var_166_34 < arg_163_1.time_ and arg_163_1.time_ <= var_166_34 + arg_166_0 then
				arg_163_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_166_35 = 0
			local var_166_36 = 0.2

			if var_166_35 < arg_163_1.time_ and arg_163_1.time_ <= var_166_35 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_37 = arg_163_1:FormatText(StoryNameCfg[37].name)

				arg_163_1.leftNameTxt_.text = var_166_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_38 = arg_163_1:GetWordFromCfg(322112040)
				local var_166_39 = arg_163_1:FormatText(var_166_38.content)

				arg_163_1.text_.text = var_166_39

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_40 = 8
				local var_166_41 = utf8.len(var_166_39)
				local var_166_42 = var_166_40 <= 0 and var_166_36 or var_166_36 * (var_166_41 / var_166_40)

				if var_166_42 > 0 and var_166_36 < var_166_42 then
					arg_163_1.talkMaxDuration = var_166_42

					if var_166_42 + var_166_35 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_42 + var_166_35
					end
				end

				arg_163_1.text_.text = var_166_39
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112040", "story_v_out_322112.awb") ~= 0 then
					local var_166_43 = manager.audio:GetVoiceLength("story_v_out_322112", "322112040", "story_v_out_322112.awb") / 1000

					if var_166_43 + var_166_35 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_43 + var_166_35
					end

					if var_166_38.prefab_name ~= "" and arg_163_1.actors_[var_166_38.prefab_name] ~= nil then
						local var_166_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_38.prefab_name].transform, "story_v_out_322112", "322112040", "story_v_out_322112.awb")

						arg_163_1:RecordAudio("322112040", var_166_44)
						arg_163_1:RecordAudio("322112040", var_166_44)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_322112", "322112040", "story_v_out_322112.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_322112", "322112040", "story_v_out_322112.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_45 = math.max(var_166_36, arg_163_1.talkMaxDuration)

			if var_166_35 <= arg_163_1.time_ and arg_163_1.time_ < var_166_35 + var_166_45 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_35) / var_166_45

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_35 + var_166_45 and arg_163_1.time_ < var_166_35 + var_166_45 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play322112041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 322112041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play322112042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1284ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos1284ui_story = var_170_0.localPosition
			end

			local var_170_2 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2
				local var_170_4 = Vector3.New(0, 100, 0)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1284ui_story, var_170_4, var_170_3)

				local var_170_5 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_5.x, var_170_5.y, var_170_5.z)

				local var_170_6 = var_170_0.localEulerAngles

				var_170_6.z = 0
				var_170_6.x = 0
				var_170_0.localEulerAngles = var_170_6
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(0, 100, 0)

				local var_170_7 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_7.x, var_170_7.y, var_170_7.z)

				local var_170_8 = var_170_0.localEulerAngles

				var_170_8.z = 0
				var_170_8.x = 0
				var_170_0.localEulerAngles = var_170_8
			end

			local var_170_9 = arg_167_1.actors_["1211ui_story"].transform
			local var_170_10 = 0

			if var_170_10 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 then
				arg_167_1.var_.moveOldPos1211ui_story = var_170_9.localPosition
			end

			local var_170_11 = 0.001

			if var_170_10 <= arg_167_1.time_ and arg_167_1.time_ < var_170_10 + var_170_11 then
				local var_170_12 = (arg_167_1.time_ - var_170_10) / var_170_11
				local var_170_13 = Vector3.New(0, 100, 0)

				var_170_9.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1211ui_story, var_170_13, var_170_12)

				local var_170_14 = manager.ui.mainCamera.transform.position - var_170_9.position

				var_170_9.forward = Vector3.New(var_170_14.x, var_170_14.y, var_170_14.z)

				local var_170_15 = var_170_9.localEulerAngles

				var_170_15.z = 0
				var_170_15.x = 0
				var_170_9.localEulerAngles = var_170_15
			end

			if arg_167_1.time_ >= var_170_10 + var_170_11 and arg_167_1.time_ < var_170_10 + var_170_11 + arg_170_0 then
				var_170_9.localPosition = Vector3.New(0, 100, 0)

				local var_170_16 = manager.ui.mainCamera.transform.position - var_170_9.position

				var_170_9.forward = Vector3.New(var_170_16.x, var_170_16.y, var_170_16.z)

				local var_170_17 = var_170_9.localEulerAngles

				var_170_17.z = 0
				var_170_17.x = 0
				var_170_9.localEulerAngles = var_170_17
			end

			local var_170_18 = arg_167_1.actors_["1211ui_story"]
			local var_170_19 = 0

			if var_170_19 < arg_167_1.time_ and arg_167_1.time_ <= var_170_19 + arg_170_0 and not isNil(var_170_18) and arg_167_1.var_.characterEffect1211ui_story == nil then
				arg_167_1.var_.characterEffect1211ui_story = var_170_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_20 = 0.200000002980232

			if var_170_19 <= arg_167_1.time_ and arg_167_1.time_ < var_170_19 + var_170_20 and not isNil(var_170_18) then
				local var_170_21 = (arg_167_1.time_ - var_170_19) / var_170_20

				if arg_167_1.var_.characterEffect1211ui_story and not isNil(var_170_18) then
					local var_170_22 = Mathf.Lerp(0, 0.5, var_170_21)

					arg_167_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1211ui_story.fillRatio = var_170_22
				end
			end

			if arg_167_1.time_ >= var_170_19 + var_170_20 and arg_167_1.time_ < var_170_19 + var_170_20 + arg_170_0 and not isNil(var_170_18) and arg_167_1.var_.characterEffect1211ui_story then
				local var_170_23 = 0.5

				arg_167_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1211ui_story.fillRatio = var_170_23
			end

			local var_170_24 = 0
			local var_170_25 = 1.1

			if var_170_24 < arg_167_1.time_ and arg_167_1.time_ <= var_170_24 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_26 = arg_167_1:GetWordFromCfg(322112041)
				local var_170_27 = arg_167_1:FormatText(var_170_26.content)

				arg_167_1.text_.text = var_170_27

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_28 = 44
				local var_170_29 = utf8.len(var_170_27)
				local var_170_30 = var_170_28 <= 0 and var_170_25 or var_170_25 * (var_170_29 / var_170_28)

				if var_170_30 > 0 and var_170_25 < var_170_30 then
					arg_167_1.talkMaxDuration = var_170_30

					if var_170_30 + var_170_24 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_30 + var_170_24
					end
				end

				arg_167_1.text_.text = var_170_27
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_31 = math.max(var_170_25, arg_167_1.talkMaxDuration)

			if var_170_24 <= arg_167_1.time_ and arg_167_1.time_ < var_170_24 + var_170_31 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_24) / var_170_31

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_24 + var_170_31 and arg_167_1.time_ < var_170_24 + var_170_31 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play322112042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 322112042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play322112043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 1.85

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_2 = arg_171_1:GetWordFromCfg(322112042)
				local var_174_3 = arg_171_1:FormatText(var_174_2.content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 74
				local var_174_5 = utf8.len(var_174_3)
				local var_174_6 = var_174_4 <= 0 and var_174_1 or var_174_1 * (var_174_5 / var_174_4)

				if var_174_6 > 0 and var_174_1 < var_174_6 then
					arg_171_1.talkMaxDuration = var_174_6

					if var_174_6 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_6 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_7 and arg_171_1.time_ < var_174_0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play322112043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 322112043
		arg_175_1.duration_ = 2.27

		local var_175_0 = {
			zh = 1.999999999999,
			ja = 2.266
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
				arg_175_0:Play322112044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = "10104ui_story"

			if arg_175_1.actors_[var_178_0] == nil then
				local var_178_1 = Asset.Load("Char/" .. "10104ui_story")

				if not isNil(var_178_1) then
					local var_178_2 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_175_1.stage_.transform)

					var_178_2.name = var_178_0
					var_178_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_175_1.actors_[var_178_0] = var_178_2

					local var_178_3 = var_178_2:GetComponentInChildren(typeof(CharacterEffect))

					var_178_3.enabled = true

					local var_178_4 = GameObjectTools.GetOrAddComponent(var_178_2, typeof(DynamicBoneHelper))

					if var_178_4 then
						var_178_4:EnableDynamicBone(false)
					end

					arg_175_1:ShowWeapon(var_178_3.transform, false)

					arg_175_1.var_[var_178_0 .. "Animator"] = var_178_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_175_1.var_[var_178_0 .. "Animator"].applyRootMotion = true
					arg_175_1.var_[var_178_0 .. "LipSync"] = var_178_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_178_5 = arg_175_1.actors_["10104ui_story"].transform
			local var_178_6 = 0

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.var_.moveOldPos10104ui_story = var_178_5.localPosition
			end

			local var_178_7 = 0.001

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_7 then
				local var_178_8 = (arg_175_1.time_ - var_178_6) / var_178_7
				local var_178_9 = Vector3.New(0.02, -1.12, -5.99)

				var_178_5.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10104ui_story, var_178_9, var_178_8)

				local var_178_10 = manager.ui.mainCamera.transform.position - var_178_5.position

				var_178_5.forward = Vector3.New(var_178_10.x, var_178_10.y, var_178_10.z)

				local var_178_11 = var_178_5.localEulerAngles

				var_178_11.z = 0
				var_178_11.x = 0
				var_178_5.localEulerAngles = var_178_11
			end

			if arg_175_1.time_ >= var_178_6 + var_178_7 and arg_175_1.time_ < var_178_6 + var_178_7 + arg_178_0 then
				var_178_5.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_178_12 = manager.ui.mainCamera.transform.position - var_178_5.position

				var_178_5.forward = Vector3.New(var_178_12.x, var_178_12.y, var_178_12.z)

				local var_178_13 = var_178_5.localEulerAngles

				var_178_13.z = 0
				var_178_13.x = 0
				var_178_5.localEulerAngles = var_178_13
			end

			local var_178_14 = arg_175_1.actors_["10104ui_story"]
			local var_178_15 = 0

			if var_178_15 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 and not isNil(var_178_14) and arg_175_1.var_.characterEffect10104ui_story == nil then
				arg_175_1.var_.characterEffect10104ui_story = var_178_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_16 = 0.200000002980232

			if var_178_15 <= arg_175_1.time_ and arg_175_1.time_ < var_178_15 + var_178_16 and not isNil(var_178_14) then
				local var_178_17 = (arg_175_1.time_ - var_178_15) / var_178_16

				if arg_175_1.var_.characterEffect10104ui_story and not isNil(var_178_14) then
					arg_175_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_15 + var_178_16 and arg_175_1.time_ < var_178_15 + var_178_16 + arg_178_0 and not isNil(var_178_14) and arg_175_1.var_.characterEffect10104ui_story then
				arg_175_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_178_18 = 0

			if var_178_18 < arg_175_1.time_ and arg_175_1.time_ <= var_178_18 + arg_178_0 then
				arg_175_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_178_19 = 0

			if var_178_19 < arg_175_1.time_ and arg_175_1.time_ <= var_178_19 + arg_178_0 then
				arg_175_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_178_20 = 0
			local var_178_21 = 0.2

			if var_178_20 < arg_175_1.time_ and arg_175_1.time_ <= var_178_20 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_22 = arg_175_1:FormatText(StoryNameCfg[1030].name)

				arg_175_1.leftNameTxt_.text = var_178_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_23 = arg_175_1:GetWordFromCfg(322112043)
				local var_178_24 = arg_175_1:FormatText(var_178_23.content)

				arg_175_1.text_.text = var_178_24

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_25 = 8
				local var_178_26 = utf8.len(var_178_24)
				local var_178_27 = var_178_25 <= 0 and var_178_21 or var_178_21 * (var_178_26 / var_178_25)

				if var_178_27 > 0 and var_178_21 < var_178_27 then
					arg_175_1.talkMaxDuration = var_178_27

					if var_178_27 + var_178_20 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_27 + var_178_20
					end
				end

				arg_175_1.text_.text = var_178_24
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112043", "story_v_out_322112.awb") ~= 0 then
					local var_178_28 = manager.audio:GetVoiceLength("story_v_out_322112", "322112043", "story_v_out_322112.awb") / 1000

					if var_178_28 + var_178_20 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_28 + var_178_20
					end

					if var_178_23.prefab_name ~= "" and arg_175_1.actors_[var_178_23.prefab_name] ~= nil then
						local var_178_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_23.prefab_name].transform, "story_v_out_322112", "322112043", "story_v_out_322112.awb")

						arg_175_1:RecordAudio("322112043", var_178_29)
						arg_175_1:RecordAudio("322112043", var_178_29)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_322112", "322112043", "story_v_out_322112.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_322112", "322112043", "story_v_out_322112.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_30 = math.max(var_178_21, arg_175_1.talkMaxDuration)

			if var_178_20 <= arg_175_1.time_ and arg_175_1.time_ < var_178_20 + var_178_30 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_20) / var_178_30

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_20 + var_178_30 and arg_175_1.time_ < var_178_20 + var_178_30 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play322112044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 322112044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play322112045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10104ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect10104ui_story == nil then
				arg_179_1.var_.characterEffect10104ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect10104ui_story and not isNil(var_182_0) then
					local var_182_4 = Mathf.Lerp(0, 0.5, var_182_3)

					arg_179_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10104ui_story.fillRatio = var_182_4
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect10104ui_story then
				local var_182_5 = 0.5

				arg_179_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10104ui_story.fillRatio = var_182_5
			end

			local var_182_6 = 0
			local var_182_7 = 0.325

			if var_182_6 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_8 = arg_179_1:FormatText(StoryNameCfg[7].name)

				arg_179_1.leftNameTxt_.text = var_182_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_9 = arg_179_1:GetWordFromCfg(322112044)
				local var_182_10 = arg_179_1:FormatText(var_182_9.content)

				arg_179_1.text_.text = var_182_10

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_11 = 13
				local var_182_12 = utf8.len(var_182_10)
				local var_182_13 = var_182_11 <= 0 and var_182_7 or var_182_7 * (var_182_12 / var_182_11)

				if var_182_13 > 0 and var_182_7 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_10
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_14 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_14 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_14

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_14 and arg_179_1.time_ < var_182_6 + var_182_14 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play322112045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 322112045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play322112046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10104ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos10104ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(0, 100, 0)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10104ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, 100, 0)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = 0
			local var_186_10 = 1.1

			if var_186_9 < arg_183_1.time_ and arg_183_1.time_ <= var_186_9 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_11 = arg_183_1:GetWordFromCfg(322112045)
				local var_186_12 = arg_183_1:FormatText(var_186_11.content)

				arg_183_1.text_.text = var_186_12

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_13 = 44
				local var_186_14 = utf8.len(var_186_12)
				local var_186_15 = var_186_13 <= 0 and var_186_10 or var_186_10 * (var_186_14 / var_186_13)

				if var_186_15 > 0 and var_186_10 < var_186_15 then
					arg_183_1.talkMaxDuration = var_186_15

					if var_186_15 + var_186_9 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_15 + var_186_9
					end
				end

				arg_183_1.text_.text = var_186_12
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_16 = math.max(var_186_10, arg_183_1.talkMaxDuration)

			if var_186_9 <= arg_183_1.time_ and arg_183_1.time_ < var_186_9 + var_186_16 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_9) / var_186_16

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_9 + var_186_16 and arg_183_1.time_ < var_186_9 + var_186_16 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play322112046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 322112046
		arg_187_1.duration_ = 15

		local var_187_0 = {
			zh = 9.733,
			ja = 15
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play322112047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10104ui_story"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos10104ui_story = var_190_0.localPosition
			end

			local var_190_2 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2
				local var_190_4 = Vector3.New(0.02, -1.12, -5.99)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10104ui_story, var_190_4, var_190_3)

				local var_190_5 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_5.x, var_190_5.y, var_190_5.z)

				local var_190_6 = var_190_0.localEulerAngles

				var_190_6.z = 0
				var_190_6.x = 0
				var_190_0.localEulerAngles = var_190_6
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_190_7 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_7.x, var_190_7.y, var_190_7.z)

				local var_190_8 = var_190_0.localEulerAngles

				var_190_8.z = 0
				var_190_8.x = 0
				var_190_0.localEulerAngles = var_190_8
			end

			local var_190_9 = arg_187_1.actors_["10104ui_story"]
			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect10104ui_story == nil then
				arg_187_1.var_.characterEffect10104ui_story = var_190_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_11 = 0.200000002980232

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_11 and not isNil(var_190_9) then
				local var_190_12 = (arg_187_1.time_ - var_190_10) / var_190_11

				if arg_187_1.var_.characterEffect10104ui_story and not isNil(var_190_9) then
					arg_187_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_10 + var_190_11 and arg_187_1.time_ < var_190_10 + var_190_11 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect10104ui_story then
				arg_187_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_190_13 = 0

			if var_190_13 < arg_187_1.time_ and arg_187_1.time_ <= var_190_13 + arg_190_0 then
				arg_187_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_190_14 = 0

			if var_190_14 < arg_187_1.time_ and arg_187_1.time_ <= var_190_14 + arg_190_0 then
				arg_187_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_190_15 = 0
			local var_190_16 = 1.2

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_17 = arg_187_1:FormatText(StoryNameCfg[1030].name)

				arg_187_1.leftNameTxt_.text = var_190_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_18 = arg_187_1:GetWordFromCfg(322112046)
				local var_190_19 = arg_187_1:FormatText(var_190_18.content)

				arg_187_1.text_.text = var_190_19

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_20 = 48
				local var_190_21 = utf8.len(var_190_19)
				local var_190_22 = var_190_20 <= 0 and var_190_16 or var_190_16 * (var_190_21 / var_190_20)

				if var_190_22 > 0 and var_190_16 < var_190_22 then
					arg_187_1.talkMaxDuration = var_190_22

					if var_190_22 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_22 + var_190_15
					end
				end

				arg_187_1.text_.text = var_190_19
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112046", "story_v_out_322112.awb") ~= 0 then
					local var_190_23 = manager.audio:GetVoiceLength("story_v_out_322112", "322112046", "story_v_out_322112.awb") / 1000

					if var_190_23 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_23 + var_190_15
					end

					if var_190_18.prefab_name ~= "" and arg_187_1.actors_[var_190_18.prefab_name] ~= nil then
						local var_190_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_18.prefab_name].transform, "story_v_out_322112", "322112046", "story_v_out_322112.awb")

						arg_187_1:RecordAudio("322112046", var_190_24)
						arg_187_1:RecordAudio("322112046", var_190_24)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_322112", "322112046", "story_v_out_322112.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_322112", "322112046", "story_v_out_322112.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_25 = math.max(var_190_16, arg_187_1.talkMaxDuration)

			if var_190_15 <= arg_187_1.time_ and arg_187_1.time_ < var_190_15 + var_190_25 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_15) / var_190_25

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_15 + var_190_25 and arg_187_1.time_ < var_190_15 + var_190_25 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play322112047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 322112047
		arg_191_1.duration_ = 6.8

		local var_191_0 = {
			zh = 5.5,
			ja = 6.8
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play322112048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10104ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos10104ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(0.02, -1.12, -5.99)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10104ui_story, var_194_4, var_194_3)

				local var_194_5 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_5.x, var_194_5.y, var_194_5.z)

				local var_194_6 = var_194_0.localEulerAngles

				var_194_6.z = 0
				var_194_6.x = 0
				var_194_0.localEulerAngles = var_194_6
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_194_7 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_7.x, var_194_7.y, var_194_7.z)

				local var_194_8 = var_194_0.localEulerAngles

				var_194_8.z = 0
				var_194_8.x = 0
				var_194_0.localEulerAngles = var_194_8
			end

			local var_194_9 = 0

			if var_194_9 < arg_191_1.time_ and arg_191_1.time_ <= var_194_9 + arg_194_0 then
				arg_191_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 then
				arg_191_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_194_11 = 0
			local var_194_12 = 0.65

			if var_194_11 < arg_191_1.time_ and arg_191_1.time_ <= var_194_11 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_13 = arg_191_1:FormatText(StoryNameCfg[1030].name)

				arg_191_1.leftNameTxt_.text = var_194_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_14 = arg_191_1:GetWordFromCfg(322112047)
				local var_194_15 = arg_191_1:FormatText(var_194_14.content)

				arg_191_1.text_.text = var_194_15

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_16 = 26
				local var_194_17 = utf8.len(var_194_15)
				local var_194_18 = var_194_16 <= 0 and var_194_12 or var_194_12 * (var_194_17 / var_194_16)

				if var_194_18 > 0 and var_194_12 < var_194_18 then
					arg_191_1.talkMaxDuration = var_194_18

					if var_194_18 + var_194_11 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_18 + var_194_11
					end
				end

				arg_191_1.text_.text = var_194_15
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112047", "story_v_out_322112.awb") ~= 0 then
					local var_194_19 = manager.audio:GetVoiceLength("story_v_out_322112", "322112047", "story_v_out_322112.awb") / 1000

					if var_194_19 + var_194_11 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_19 + var_194_11
					end

					if var_194_14.prefab_name ~= "" and arg_191_1.actors_[var_194_14.prefab_name] ~= nil then
						local var_194_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_14.prefab_name].transform, "story_v_out_322112", "322112047", "story_v_out_322112.awb")

						arg_191_1:RecordAudio("322112047", var_194_20)
						arg_191_1:RecordAudio("322112047", var_194_20)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_322112", "322112047", "story_v_out_322112.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_322112", "322112047", "story_v_out_322112.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_21 = math.max(var_194_12, arg_191_1.talkMaxDuration)

			if var_194_11 <= arg_191_1.time_ and arg_191_1.time_ < var_194_11 + var_194_21 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_11) / var_194_21

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_11 + var_194_21 and arg_191_1.time_ < var_194_11 + var_194_21 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play322112048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 322112048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play322112049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10104ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect10104ui_story == nil then
				arg_195_1.var_.characterEffect10104ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect10104ui_story and not isNil(var_198_0) then
					local var_198_4 = Mathf.Lerp(0, 0.5, var_198_3)

					arg_195_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10104ui_story.fillRatio = var_198_4
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect10104ui_story then
				local var_198_5 = 0.5

				arg_195_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10104ui_story.fillRatio = var_198_5
			end

			local var_198_6 = 0
			local var_198_7 = 0.275

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_8 = arg_195_1:FormatText(StoryNameCfg[7].name)

				arg_195_1.leftNameTxt_.text = var_198_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_9 = arg_195_1:GetWordFromCfg(322112048)
				local var_198_10 = arg_195_1:FormatText(var_198_9.content)

				arg_195_1.text_.text = var_198_10

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 11
				local var_198_12 = utf8.len(var_198_10)
				local var_198_13 = var_198_11 <= 0 and var_198_7 or var_198_7 * (var_198_12 / var_198_11)

				if var_198_13 > 0 and var_198_7 < var_198_13 then
					arg_195_1.talkMaxDuration = var_198_13

					if var_198_13 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_13 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_10
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_14 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_14

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_14 and arg_195_1.time_ < var_198_6 + var_198_14 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play322112049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 322112049
		arg_199_1.duration_ = 3.4

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play322112050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10104ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos10104ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(0.02, -1.12, -5.99)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10104ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = arg_199_1.actors_["10104ui_story"]
			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect10104ui_story == nil then
				arg_199_1.var_.characterEffect10104ui_story = var_202_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_11 = 0.200000002980232

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_11 and not isNil(var_202_9) then
				local var_202_12 = (arg_199_1.time_ - var_202_10) / var_202_11

				if arg_199_1.var_.characterEffect10104ui_story and not isNil(var_202_9) then
					arg_199_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_10 + var_202_11 and arg_199_1.time_ < var_202_10 + var_202_11 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect10104ui_story then
				arg_199_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_202_13 = 0

			if var_202_13 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				arg_199_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_2")
			end

			local var_202_14 = 0

			if var_202_14 < arg_199_1.time_ and arg_199_1.time_ <= var_202_14 + arg_202_0 then
				arg_199_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_202_15 = 0
			local var_202_16 = 0.325

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_17 = arg_199_1:FormatText(StoryNameCfg[1030].name)

				arg_199_1.leftNameTxt_.text = var_202_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_18 = arg_199_1:GetWordFromCfg(322112049)
				local var_202_19 = arg_199_1:FormatText(var_202_18.content)

				arg_199_1.text_.text = var_202_19

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_20 = 13
				local var_202_21 = utf8.len(var_202_19)
				local var_202_22 = var_202_20 <= 0 and var_202_16 or var_202_16 * (var_202_21 / var_202_20)

				if var_202_22 > 0 and var_202_16 < var_202_22 then
					arg_199_1.talkMaxDuration = var_202_22

					if var_202_22 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_22 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_19
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112049", "story_v_out_322112.awb") ~= 0 then
					local var_202_23 = manager.audio:GetVoiceLength("story_v_out_322112", "322112049", "story_v_out_322112.awb") / 1000

					if var_202_23 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_23 + var_202_15
					end

					if var_202_18.prefab_name ~= "" and arg_199_1.actors_[var_202_18.prefab_name] ~= nil then
						local var_202_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_18.prefab_name].transform, "story_v_out_322112", "322112049", "story_v_out_322112.awb")

						arg_199_1:RecordAudio("322112049", var_202_24)
						arg_199_1:RecordAudio("322112049", var_202_24)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_322112", "322112049", "story_v_out_322112.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_322112", "322112049", "story_v_out_322112.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_25 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_25 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_25

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_25 and arg_199_1.time_ < var_202_15 + var_202_25 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play322112050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 322112050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play322112051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10104ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos10104ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(0, 100, 0)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10104ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, 100, 0)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["10104ui_story"]
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect10104ui_story == nil then
				arg_203_1.var_.characterEffect10104ui_story = var_206_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_11 = 0.200000002980232

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 and not isNil(var_206_9) then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11

				if arg_203_1.var_.characterEffect10104ui_story and not isNil(var_206_9) then
					local var_206_13 = Mathf.Lerp(0, 0.5, var_206_12)

					arg_203_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10104ui_story.fillRatio = var_206_13
				end
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect10104ui_story then
				local var_206_14 = 0.5

				arg_203_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10104ui_story.fillRatio = var_206_14
			end

			local var_206_15 = 0.499999999999
			local var_206_16 = 1

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				local var_206_17 = "play"
				local var_206_18 = "effect"

				arg_203_1:AudioAction(var_206_17, var_206_18, "se_story_121_04", "se_story_121_04_walk02", "")
			end

			local var_206_19 = 0
			local var_206_20 = 1.2

			if var_206_19 < arg_203_1.time_ and arg_203_1.time_ <= var_206_19 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_21 = arg_203_1:GetWordFromCfg(322112050)
				local var_206_22 = arg_203_1:FormatText(var_206_21.content)

				arg_203_1.text_.text = var_206_22

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_23 = 48
				local var_206_24 = utf8.len(var_206_22)
				local var_206_25 = var_206_23 <= 0 and var_206_20 or var_206_20 * (var_206_24 / var_206_23)

				if var_206_25 > 0 and var_206_20 < var_206_25 then
					arg_203_1.talkMaxDuration = var_206_25

					if var_206_25 + var_206_19 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_25 + var_206_19
					end
				end

				arg_203_1.text_.text = var_206_22
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_26 = math.max(var_206_20, arg_203_1.talkMaxDuration)

			if var_206_19 <= arg_203_1.time_ and arg_203_1.time_ < var_206_19 + var_206_26 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_19) / var_206_26

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_19 + var_206_26 and arg_203_1.time_ < var_206_19 + var_206_26 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play322112051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 322112051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play322112052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 1.025

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:GetWordFromCfg(322112051)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 41
				local var_210_5 = utf8.len(var_210_3)
				local var_210_6 = var_210_4 <= 0 and var_210_1 or var_210_1 * (var_210_5 / var_210_4)

				if var_210_6 > 0 and var_210_1 < var_210_6 then
					arg_207_1.talkMaxDuration = var_210_6

					if var_210_6 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_7 and arg_207_1.time_ < var_210_0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play322112052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 322112052
		arg_211_1.duration_ = 6.67

		local var_211_0 = {
			zh = 4.633,
			ja = 6.666
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play322112053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10104ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos10104ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0.02, -1.12, -5.99)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10104ui_story, var_214_4, var_214_3)

				local var_214_5 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_5.x, var_214_5.y, var_214_5.z)

				local var_214_6 = var_214_0.localEulerAngles

				var_214_6.z = 0
				var_214_6.x = 0
				var_214_0.localEulerAngles = var_214_6
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_214_7 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_7.x, var_214_7.y, var_214_7.z)

				local var_214_8 = var_214_0.localEulerAngles

				var_214_8.z = 0
				var_214_8.x = 0
				var_214_0.localEulerAngles = var_214_8
			end

			local var_214_9 = arg_211_1.actors_["10104ui_story"]
			local var_214_10 = 0

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect10104ui_story == nil then
				arg_211_1.var_.characterEffect10104ui_story = var_214_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_11 = 0.200000002980232

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_11 and not isNil(var_214_9) then
				local var_214_12 = (arg_211_1.time_ - var_214_10) / var_214_11

				if arg_211_1.var_.characterEffect10104ui_story and not isNil(var_214_9) then
					arg_211_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_10 + var_214_11 and arg_211_1.time_ < var_214_10 + var_214_11 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect10104ui_story then
				arg_211_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_214_13 = 0

			if var_214_13 < arg_211_1.time_ and arg_211_1.time_ <= var_214_13 + arg_214_0 then
				arg_211_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_214_14 = 0

			if var_214_14 < arg_211_1.time_ and arg_211_1.time_ <= var_214_14 + arg_214_0 then
				arg_211_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_214_15 = 0
			local var_214_16 = 0.575

			if var_214_15 < arg_211_1.time_ and arg_211_1.time_ <= var_214_15 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_17 = arg_211_1:FormatText(StoryNameCfg[1030].name)

				arg_211_1.leftNameTxt_.text = var_214_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_18 = arg_211_1:GetWordFromCfg(322112052)
				local var_214_19 = arg_211_1:FormatText(var_214_18.content)

				arg_211_1.text_.text = var_214_19

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_20 = 23
				local var_214_21 = utf8.len(var_214_19)
				local var_214_22 = var_214_20 <= 0 and var_214_16 or var_214_16 * (var_214_21 / var_214_20)

				if var_214_22 > 0 and var_214_16 < var_214_22 then
					arg_211_1.talkMaxDuration = var_214_22

					if var_214_22 + var_214_15 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_22 + var_214_15
					end
				end

				arg_211_1.text_.text = var_214_19
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112052", "story_v_out_322112.awb") ~= 0 then
					local var_214_23 = manager.audio:GetVoiceLength("story_v_out_322112", "322112052", "story_v_out_322112.awb") / 1000

					if var_214_23 + var_214_15 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_23 + var_214_15
					end

					if var_214_18.prefab_name ~= "" and arg_211_1.actors_[var_214_18.prefab_name] ~= nil then
						local var_214_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_18.prefab_name].transform, "story_v_out_322112", "322112052", "story_v_out_322112.awb")

						arg_211_1:RecordAudio("322112052", var_214_24)
						arg_211_1:RecordAudio("322112052", var_214_24)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_322112", "322112052", "story_v_out_322112.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_322112", "322112052", "story_v_out_322112.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_25 = math.max(var_214_16, arg_211_1.talkMaxDuration)

			if var_214_15 <= arg_211_1.time_ and arg_211_1.time_ < var_214_15 + var_214_25 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_15) / var_214_25

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_15 + var_214_25 and arg_211_1.time_ < var_214_15 + var_214_25 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play322112053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 322112053
		arg_215_1.duration_ = 11.07

		local var_215_0 = {
			zh = 8,
			ja = 11.066
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play322112054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_218_1 = 0
			local var_218_2 = 0.95

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_3 = arg_215_1:FormatText(StoryNameCfg[1030].name)

				arg_215_1.leftNameTxt_.text = var_218_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_4 = arg_215_1:GetWordFromCfg(322112053)
				local var_218_5 = arg_215_1:FormatText(var_218_4.content)

				arg_215_1.text_.text = var_218_5

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_6 = 38
				local var_218_7 = utf8.len(var_218_5)
				local var_218_8 = var_218_6 <= 0 and var_218_2 or var_218_2 * (var_218_7 / var_218_6)

				if var_218_8 > 0 and var_218_2 < var_218_8 then
					arg_215_1.talkMaxDuration = var_218_8

					if var_218_8 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_1
					end
				end

				arg_215_1.text_.text = var_218_5
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112053", "story_v_out_322112.awb") ~= 0 then
					local var_218_9 = manager.audio:GetVoiceLength("story_v_out_322112", "322112053", "story_v_out_322112.awb") / 1000

					if var_218_9 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_1
					end

					if var_218_4.prefab_name ~= "" and arg_215_1.actors_[var_218_4.prefab_name] ~= nil then
						local var_218_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_4.prefab_name].transform, "story_v_out_322112", "322112053", "story_v_out_322112.awb")

						arg_215_1:RecordAudio("322112053", var_218_10)
						arg_215_1:RecordAudio("322112053", var_218_10)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_322112", "322112053", "story_v_out_322112.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_322112", "322112053", "story_v_out_322112.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_11 = math.max(var_218_2, arg_215_1.talkMaxDuration)

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_11 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_1) / var_218_11

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_1 + var_218_11 and arg_215_1.time_ < var_218_1 + var_218_11 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play322112054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 322112054
		arg_219_1.duration_ = 14.93

		local var_219_0 = {
			zh = 9.233,
			ja = 14.933
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play322112055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 1.125

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[1030].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_3 = arg_219_1:GetWordFromCfg(322112054)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 45
				local var_222_6 = utf8.len(var_222_4)
				local var_222_7 = var_222_5 <= 0 and var_222_1 or var_222_1 * (var_222_6 / var_222_5)

				if var_222_7 > 0 and var_222_1 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112054", "story_v_out_322112.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112054", "story_v_out_322112.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_322112", "322112054", "story_v_out_322112.awb")

						arg_219_1:RecordAudio("322112054", var_222_9)
						arg_219_1:RecordAudio("322112054", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_322112", "322112054", "story_v_out_322112.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_322112", "322112054", "story_v_out_322112.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_10 and arg_219_1.time_ < var_222_0 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play322112055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 322112055
		arg_223_1.duration_ = 4.4

		local var_223_0 = {
			zh = 2.566,
			ja = 4.4
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play322112056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action5_1")
			end

			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_226_2 = 0
			local var_226_3 = 0.275

			if var_226_2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_4 = arg_223_1:FormatText(StoryNameCfg[1030].name)

				arg_223_1.leftNameTxt_.text = var_226_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_5 = arg_223_1:GetWordFromCfg(322112055)
				local var_226_6 = arg_223_1:FormatText(var_226_5.content)

				arg_223_1.text_.text = var_226_6

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_7 = 11
				local var_226_8 = utf8.len(var_226_6)
				local var_226_9 = var_226_7 <= 0 and var_226_3 or var_226_3 * (var_226_8 / var_226_7)

				if var_226_9 > 0 and var_226_3 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_2
					end
				end

				arg_223_1.text_.text = var_226_6
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112055", "story_v_out_322112.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_out_322112", "322112055", "story_v_out_322112.awb") / 1000

					if var_226_10 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_2
					end

					if var_226_5.prefab_name ~= "" and arg_223_1.actors_[var_226_5.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_5.prefab_name].transform, "story_v_out_322112", "322112055", "story_v_out_322112.awb")

						arg_223_1:RecordAudio("322112055", var_226_11)
						arg_223_1:RecordAudio("322112055", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_322112", "322112055", "story_v_out_322112.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_322112", "322112055", "story_v_out_322112.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_12 = math.max(var_226_3, arg_223_1.talkMaxDuration)

			if var_226_2 <= arg_223_1.time_ and arg_223_1.time_ < var_226_2 + var_226_12 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_2) / var_226_12

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_2 + var_226_12 and arg_223_1.time_ < var_226_2 + var_226_12 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play322112056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 322112056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play322112057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["10104ui_story"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect10104ui_story == nil then
				arg_227_1.var_.characterEffect10104ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.characterEffect10104ui_story and not isNil(var_230_0) then
					local var_230_4 = Mathf.Lerp(0, 0.5, var_230_3)

					arg_227_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_227_1.var_.characterEffect10104ui_story.fillRatio = var_230_4
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect10104ui_story then
				local var_230_5 = 0.5

				arg_227_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_227_1.var_.characterEffect10104ui_story.fillRatio = var_230_5
			end

			local var_230_6 = 0
			local var_230_7 = 0.7

			if var_230_6 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_8 = arg_227_1:FormatText(StoryNameCfg[7].name)

				arg_227_1.leftNameTxt_.text = var_230_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_9 = arg_227_1:GetWordFromCfg(322112056)
				local var_230_10 = arg_227_1:FormatText(var_230_9.content)

				arg_227_1.text_.text = var_230_10

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_11 = 28
				local var_230_12 = utf8.len(var_230_10)
				local var_230_13 = var_230_11 <= 0 and var_230_7 or var_230_7 * (var_230_12 / var_230_11)

				if var_230_13 > 0 and var_230_7 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13

					if var_230_13 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_6
					end
				end

				arg_227_1.text_.text = var_230_10
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_14 = math.max(var_230_7, arg_227_1.talkMaxDuration)

			if var_230_6 <= arg_227_1.time_ and arg_227_1.time_ < var_230_6 + var_230_14 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_6) / var_230_14

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_6 + var_230_14 and arg_227_1.time_ < var_230_6 + var_230_14 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play322112057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 322112057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play322112058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10104ui_story"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos10104ui_story = var_234_0.localPosition
			end

			local var_234_2 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2
				local var_234_4 = Vector3.New(0, 100, 0)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10104ui_story, var_234_4, var_234_3)

				local var_234_5 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_5.x, var_234_5.y, var_234_5.z)

				local var_234_6 = var_234_0.localEulerAngles

				var_234_6.z = 0
				var_234_6.x = 0
				var_234_0.localEulerAngles = var_234_6
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0, 100, 0)

				local var_234_7 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_7.x, var_234_7.y, var_234_7.z)

				local var_234_8 = var_234_0.localEulerAngles

				var_234_8.z = 0
				var_234_8.x = 0
				var_234_0.localEulerAngles = var_234_8
			end

			local var_234_9 = 0
			local var_234_10 = 1.3

			if var_234_9 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_11 = arg_231_1:GetWordFromCfg(322112057)
				local var_234_12 = arg_231_1:FormatText(var_234_11.content)

				arg_231_1.text_.text = var_234_12

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_13 = 52
				local var_234_14 = utf8.len(var_234_12)
				local var_234_15 = var_234_13 <= 0 and var_234_10 or var_234_10 * (var_234_14 / var_234_13)

				if var_234_15 > 0 and var_234_10 < var_234_15 then
					arg_231_1.talkMaxDuration = var_234_15

					if var_234_15 + var_234_9 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_15 + var_234_9
					end
				end

				arg_231_1.text_.text = var_234_12
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_16 = math.max(var_234_10, arg_231_1.talkMaxDuration)

			if var_234_9 <= arg_231_1.time_ and arg_231_1.time_ < var_234_9 + var_234_16 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_9) / var_234_16

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_9 + var_234_16 and arg_231_1.time_ < var_234_9 + var_234_16 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play322112058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 322112058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play322112059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 0.9

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_2 = arg_235_1:FormatText(StoryNameCfg[7].name)

				arg_235_1.leftNameTxt_.text = var_238_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:GetWordFromCfg(322112058)
				local var_238_4 = arg_235_1:FormatText(var_238_3.content)

				arg_235_1.text_.text = var_238_4

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 36
				local var_238_6 = utf8.len(var_238_4)
				local var_238_7 = var_238_5 <= 0 and var_238_1 or var_238_1 * (var_238_6 / var_238_5)

				if var_238_7 > 0 and var_238_1 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_4
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_8 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_8 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_8

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_8 and arg_235_1.time_ < var_238_0 + var_238_8 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play322112059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 322112059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play322112060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 1.525

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[7].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:GetWordFromCfg(322112059)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 61
				local var_242_6 = utf8.len(var_242_4)
				local var_242_7 = var_242_5 <= 0 and var_242_1 or var_242_1 * (var_242_6 / var_242_5)

				if var_242_7 > 0 and var_242_1 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_8 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_8 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_8

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_8 and arg_239_1.time_ < var_242_0 + var_242_8 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play322112060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 322112060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play322112061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 0.6

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_2 = arg_243_1:FormatText(StoryNameCfg[7].name)

				arg_243_1.leftNameTxt_.text = var_246_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:GetWordFromCfg(322112060)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 24
				local var_246_6 = utf8.len(var_246_4)
				local var_246_7 = var_246_5 <= 0 and var_246_1 or var_246_1 * (var_246_6 / var_246_5)

				if var_246_7 > 0 and var_246_1 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_8 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_8 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_8

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_8 and arg_243_1.time_ < var_246_0 + var_246_8 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play322112061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 322112061
		arg_247_1.duration_ = 4.9

		local var_247_0 = {
			zh = 1.999999999999,
			ja = 4.9
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
				arg_247_0:Play322112062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10104ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos10104ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(0.02, -1.12, -5.99)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10104ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = arg_247_1.actors_["10104ui_story"]
			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect10104ui_story == nil then
				arg_247_1.var_.characterEffect10104ui_story = var_250_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_11 = 0.200000002980232

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_11 and not isNil(var_250_9) then
				local var_250_12 = (arg_247_1.time_ - var_250_10) / var_250_11

				if arg_247_1.var_.characterEffect10104ui_story and not isNil(var_250_9) then
					arg_247_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_10 + var_250_11 and arg_247_1.time_ < var_250_10 + var_250_11 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect10104ui_story then
				arg_247_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_250_13 = 0

			if var_250_13 < arg_247_1.time_ and arg_247_1.time_ <= var_250_13 + arg_250_0 then
				arg_247_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_250_14 = 0

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				arg_247_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_250_15 = 0
			local var_250_16 = 0.3

			if var_250_15 < arg_247_1.time_ and arg_247_1.time_ <= var_250_15 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_17 = arg_247_1:FormatText(StoryNameCfg[1030].name)

				arg_247_1.leftNameTxt_.text = var_250_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_18 = arg_247_1:GetWordFromCfg(322112061)
				local var_250_19 = arg_247_1:FormatText(var_250_18.content)

				arg_247_1.text_.text = var_250_19

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_20 = 12
				local var_250_21 = utf8.len(var_250_19)
				local var_250_22 = var_250_20 <= 0 and var_250_16 or var_250_16 * (var_250_21 / var_250_20)

				if var_250_22 > 0 and var_250_16 < var_250_22 then
					arg_247_1.talkMaxDuration = var_250_22

					if var_250_22 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_22 + var_250_15
					end
				end

				arg_247_1.text_.text = var_250_19
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112061", "story_v_out_322112.awb") ~= 0 then
					local var_250_23 = manager.audio:GetVoiceLength("story_v_out_322112", "322112061", "story_v_out_322112.awb") / 1000

					if var_250_23 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_23 + var_250_15
					end

					if var_250_18.prefab_name ~= "" and arg_247_1.actors_[var_250_18.prefab_name] ~= nil then
						local var_250_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_18.prefab_name].transform, "story_v_out_322112", "322112061", "story_v_out_322112.awb")

						arg_247_1:RecordAudio("322112061", var_250_24)
						arg_247_1:RecordAudio("322112061", var_250_24)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_322112", "322112061", "story_v_out_322112.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_322112", "322112061", "story_v_out_322112.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_25 = math.max(var_250_16, arg_247_1.talkMaxDuration)

			if var_250_15 <= arg_247_1.time_ and arg_247_1.time_ < var_250_15 + var_250_25 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_15) / var_250_25

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_15 + var_250_25 and arg_247_1.time_ < var_250_15 + var_250_25 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play322112062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 322112062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play322112063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10104ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos10104ui_story = var_254_0.localPosition
			end

			local var_254_2 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2
				local var_254_4 = Vector3.New(0, 100, 0)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10104ui_story, var_254_4, var_254_3)

				local var_254_5 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_5.x, var_254_5.y, var_254_5.z)

				local var_254_6 = var_254_0.localEulerAngles

				var_254_6.z = 0
				var_254_6.x = 0
				var_254_0.localEulerAngles = var_254_6
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(0, 100, 0)

				local var_254_7 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_7.x, var_254_7.y, var_254_7.z)

				local var_254_8 = var_254_0.localEulerAngles

				var_254_8.z = 0
				var_254_8.x = 0
				var_254_0.localEulerAngles = var_254_8
			end

			local var_254_9 = arg_251_1.actors_["10104ui_story"]
			local var_254_10 = 0

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect10104ui_story == nil then
				arg_251_1.var_.characterEffect10104ui_story = var_254_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_11 = 0.200000002980232

			if var_254_10 <= arg_251_1.time_ and arg_251_1.time_ < var_254_10 + var_254_11 and not isNil(var_254_9) then
				local var_254_12 = (arg_251_1.time_ - var_254_10) / var_254_11

				if arg_251_1.var_.characterEffect10104ui_story and not isNil(var_254_9) then
					local var_254_13 = Mathf.Lerp(0, 0.5, var_254_12)

					arg_251_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_251_1.var_.characterEffect10104ui_story.fillRatio = var_254_13
				end
			end

			if arg_251_1.time_ >= var_254_10 + var_254_11 and arg_251_1.time_ < var_254_10 + var_254_11 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect10104ui_story then
				local var_254_14 = 0.5

				arg_251_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_251_1.var_.characterEffect10104ui_story.fillRatio = var_254_14
			end

			local var_254_15 = 0.666666666666667
			local var_254_16 = 1

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 then
				local var_254_17 = "play"
				local var_254_18 = "effect"

				arg_251_1:AudioAction(var_254_17, var_254_18, "se_story_1310", "se_story_1310_clap", "")
			end

			local var_254_19 = 0
			local var_254_20 = 1.05

			if var_254_19 < arg_251_1.time_ and arg_251_1.time_ <= var_254_19 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_21 = arg_251_1:GetWordFromCfg(322112062)
				local var_254_22 = arg_251_1:FormatText(var_254_21.content)

				arg_251_1.text_.text = var_254_22

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_23 = 42
				local var_254_24 = utf8.len(var_254_22)
				local var_254_25 = var_254_23 <= 0 and var_254_20 or var_254_20 * (var_254_24 / var_254_23)

				if var_254_25 > 0 and var_254_20 < var_254_25 then
					arg_251_1.talkMaxDuration = var_254_25

					if var_254_25 + var_254_19 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_25 + var_254_19
					end
				end

				arg_251_1.text_.text = var_254_22
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_26 = math.max(var_254_20, arg_251_1.talkMaxDuration)

			if var_254_19 <= arg_251_1.time_ and arg_251_1.time_ < var_254_19 + var_254_26 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_19) / var_254_26

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_19 + var_254_26 and arg_251_1.time_ < var_254_19 + var_254_26 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play322112063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 322112063
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play322112064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 2
			local var_258_1 = 0.3

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				local var_258_2 = "play"
				local var_258_3 = "music"

				arg_255_1:AudioAction(var_258_2, var_258_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_258_4 = ""
				local var_258_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_258_5 ~= "" then
					if arg_255_1.bgmTxt_.text ~= var_258_5 and arg_255_1.bgmTxt_.text ~= "" then
						if arg_255_1.bgmTxt2_.text ~= "" then
							arg_255_1.bgmTxt_.text = arg_255_1.bgmTxt2_.text
						end

						arg_255_1.bgmTxt2_.text = var_258_5

						arg_255_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_255_1.bgmTxt_.text = var_258_5
						arg_255_1.bgmTxt2_.text = var_258_5
					end

					if arg_255_1.bgmTimer then
						arg_255_1.bgmTimer:Stop()

						arg_255_1.bgmTimer = nil
					end

					if arg_255_1.settingData.show_music_name == 1 then
						arg_255_1.musicController:SetSelectedState("show")
						arg_255_1.musicAnimator_:Play("open", 0, 0)

						if arg_255_1.settingData.music_time ~= 0 then
							arg_255_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_255_1.settingData.music_time), function()
								if arg_255_1 == nil or isNil(arg_255_1.bgmTxt_) then
									return
								end

								arg_255_1.musicController:SetSelectedState("hide")
								arg_255_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_258_6 = 0
			local var_258_7 = 1.325

			if var_258_6 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_8 = arg_255_1:GetWordFromCfg(322112063)
				local var_258_9 = arg_255_1:FormatText(var_258_8.content)

				arg_255_1.text_.text = var_258_9

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_10 = 53
				local var_258_11 = utf8.len(var_258_9)
				local var_258_12 = var_258_10 <= 0 and var_258_7 or var_258_7 * (var_258_11 / var_258_10)

				if var_258_12 > 0 and var_258_7 < var_258_12 then
					arg_255_1.talkMaxDuration = var_258_12

					if var_258_12 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_12 + var_258_6
					end
				end

				arg_255_1.text_.text = var_258_9
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_13 = math.max(var_258_7, arg_255_1.talkMaxDuration)

			if var_258_6 <= arg_255_1.time_ and arg_255_1.time_ < var_258_6 + var_258_13 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_6) / var_258_13

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_6 + var_258_13 and arg_255_1.time_ < var_258_6 + var_258_13 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play322112064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 322112064
		arg_260_1.duration_ = 13.2

		local var_260_0 = {
			zh = 12.633,
			ja = 13.2
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play322112065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 2

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				local var_263_1 = manager.ui.mainCamera.transform.localPosition
				local var_263_2 = Vector3.New(0, 0, 10) + Vector3.New(var_263_1.x, var_263_1.y, 0)
				local var_263_3 = arg_260_1.bgs_.ST2102a

				var_263_3.transform.localPosition = var_263_2
				var_263_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_263_4 = var_263_3:GetComponent("SpriteRenderer")

				if var_263_4 and var_263_4.sprite then
					local var_263_5 = (var_263_3.transform.localPosition - var_263_1).z
					local var_263_6 = manager.ui.mainCameraCom_
					local var_263_7 = 2 * var_263_5 * Mathf.Tan(var_263_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_263_8 = var_263_7 * var_263_6.aspect
					local var_263_9 = var_263_4.sprite.bounds.size.x
					local var_263_10 = var_263_4.sprite.bounds.size.y
					local var_263_11 = var_263_8 / var_263_9
					local var_263_12 = var_263_7 / var_263_10
					local var_263_13 = var_263_12 < var_263_11 and var_263_11 or var_263_12

					var_263_3.transform.localScale = Vector3.New(var_263_13, var_263_13, 0)
				end

				for iter_263_0, iter_263_1 in pairs(arg_260_1.bgs_) do
					if iter_263_0 ~= "ST2102a" then
						iter_263_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_263_14 = 4

			if var_263_14 < arg_260_1.time_ and arg_260_1.time_ <= var_263_14 + arg_263_0 then
				arg_260_1.allBtn_.enabled = false
			end

			local var_263_15 = 0.3

			if arg_260_1.time_ >= var_263_14 + var_263_15 and arg_260_1.time_ < var_263_14 + var_263_15 + arg_263_0 then
				arg_260_1.allBtn_.enabled = true
			end

			local var_263_16 = 0

			if var_263_16 < arg_260_1.time_ and arg_260_1.time_ <= var_263_16 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_17 = 2

			if var_263_16 <= arg_260_1.time_ and arg_260_1.time_ < var_263_16 + var_263_17 then
				local var_263_18 = (arg_260_1.time_ - var_263_16) / var_263_17
				local var_263_19 = Color.New(0, 0, 0)

				var_263_19.a = Mathf.Lerp(0, 1, var_263_18)
				arg_260_1.mask_.color = var_263_19
			end

			if arg_260_1.time_ >= var_263_16 + var_263_17 and arg_260_1.time_ < var_263_16 + var_263_17 + arg_263_0 then
				local var_263_20 = Color.New(0, 0, 0)

				var_263_20.a = 1
				arg_260_1.mask_.color = var_263_20
			end

			local var_263_21 = 2

			if var_263_21 < arg_260_1.time_ and arg_260_1.time_ <= var_263_21 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_22 = 2

			if var_263_21 <= arg_260_1.time_ and arg_260_1.time_ < var_263_21 + var_263_22 then
				local var_263_23 = (arg_260_1.time_ - var_263_21) / var_263_22
				local var_263_24 = Color.New(0, 0, 0)

				var_263_24.a = Mathf.Lerp(1, 0, var_263_23)
				arg_260_1.mask_.color = var_263_24
			end

			if arg_260_1.time_ >= var_263_21 + var_263_22 and arg_260_1.time_ < var_263_21 + var_263_22 + arg_263_0 then
				local var_263_25 = Color.New(0, 0, 0)
				local var_263_26 = 0

				arg_260_1.mask_.enabled = false
				var_263_25.a = var_263_26
				arg_260_1.mask_.color = var_263_25
			end

			local var_263_27 = 0.166666666666667
			local var_263_28 = 1

			if var_263_27 < arg_260_1.time_ and arg_260_1.time_ <= var_263_27 + arg_263_0 then
				local var_263_29 = "stop"
				local var_263_30 = "effect"

				arg_260_1:AudioAction(var_263_29, var_263_30, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_263_31 = 1.46666666666667
			local var_263_32 = 1

			if var_263_31 < arg_260_1.time_ and arg_260_1.time_ <= var_263_31 + arg_263_0 then
				local var_263_33 = "play"
				local var_263_34 = "effect"

				arg_260_1:AudioAction(var_263_33, var_263_34, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_263_35 = 1.46666666666667
			local var_263_36 = 1

			if var_263_35 < arg_260_1.time_ and arg_260_1.time_ <= var_263_35 + arg_263_0 then
				local var_263_37 = "play"
				local var_263_38 = "effect"

				arg_260_1:AudioAction(var_263_37, var_263_38, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_263_39 = 0
			local var_263_40 = 0.3

			if var_263_39 < arg_260_1.time_ and arg_260_1.time_ <= var_263_39 + arg_263_0 then
				local var_263_41 = "play"
				local var_263_42 = "music"

				arg_260_1:AudioAction(var_263_41, var_263_42, "ui_battle", "ui_battle_stopbgm", "")

				local var_263_43 = ""
				local var_263_44 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_263_44 ~= "" then
					if arg_260_1.bgmTxt_.text ~= var_263_44 and arg_260_1.bgmTxt_.text ~= "" then
						if arg_260_1.bgmTxt2_.text ~= "" then
							arg_260_1.bgmTxt_.text = arg_260_1.bgmTxt2_.text
						end

						arg_260_1.bgmTxt2_.text = var_263_44

						arg_260_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_260_1.bgmTxt_.text = var_263_44
						arg_260_1.bgmTxt2_.text = var_263_44
					end

					if arg_260_1.bgmTimer then
						arg_260_1.bgmTimer:Stop()

						arg_260_1.bgmTimer = nil
					end

					if arg_260_1.settingData.show_music_name == 1 then
						arg_260_1.musicController:SetSelectedState("show")
						arg_260_1.musicAnimator_:Play("open", 0, 0)

						if arg_260_1.settingData.music_time ~= 0 then
							arg_260_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_260_1.settingData.music_time), function()
								if arg_260_1 == nil or isNil(arg_260_1.bgmTxt_) then
									return
								end

								arg_260_1.musicController:SetSelectedState("hide")
								arg_260_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_263_45 = 1.46666666666667
			local var_263_46 = 1

			if var_263_45 < arg_260_1.time_ and arg_260_1.time_ <= var_263_45 + arg_263_0 then
				local var_263_47 = "play"
				local var_263_48 = "music"

				arg_260_1:AudioAction(var_263_47, var_263_48, "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard.awb")

				local var_263_49 = ""
				local var_263_50 = manager.audio:GetAudioName("bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard")

				if var_263_50 ~= "" then
					if arg_260_1.bgmTxt_.text ~= var_263_50 and arg_260_1.bgmTxt_.text ~= "" then
						if arg_260_1.bgmTxt2_.text ~= "" then
							arg_260_1.bgmTxt_.text = arg_260_1.bgmTxt2_.text
						end

						arg_260_1.bgmTxt2_.text = var_263_50

						arg_260_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_260_1.bgmTxt_.text = var_263_50
						arg_260_1.bgmTxt2_.text = var_263_50
					end

					if arg_260_1.bgmTimer then
						arg_260_1.bgmTimer:Stop()

						arg_260_1.bgmTimer = nil
					end

					if arg_260_1.settingData.show_music_name == 1 then
						arg_260_1.musicController:SetSelectedState("show")
						arg_260_1.musicAnimator_:Play("open", 0, 0)

						if arg_260_1.settingData.music_time ~= 0 then
							arg_260_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_260_1.settingData.music_time), function()
								if arg_260_1 == nil or isNil(arg_260_1.bgmTxt_) then
									return
								end

								arg_260_1.musicController:SetSelectedState("hide")
								arg_260_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_260_1.frameCnt_ <= 1 then
				arg_260_1.dialog_:SetActive(false)
			end

			local var_263_51 = 4
			local var_263_52 = 1.15

			if var_263_51 < arg_260_1.time_ and arg_260_1.time_ <= var_263_51 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				arg_260_1.dialog_:SetActive(true)

				arg_260_1.dialogCg_.alpha = 0

				local var_263_53 = LeanTween.value(arg_260_1.dialog_, 0, 1, 0.3)

				var_263_53:setOnUpdate(LuaHelper.FloatAction(function(arg_266_0)
					arg_260_1.dialogCg_.alpha = arg_266_0
				end))
				var_263_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_260_1.dialog_)
					var_263_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_260_1.duration_ = arg_260_1.duration_ + 0.3

				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_54 = arg_260_1:FormatText(StoryNameCfg[487].name)

				arg_260_1.leftNameTxt_.text = var_263_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_55 = arg_260_1:GetWordFromCfg(322112064)
				local var_263_56 = arg_260_1:FormatText(var_263_55.content)

				arg_260_1.text_.text = var_263_56

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_57 = 46
				local var_263_58 = utf8.len(var_263_56)
				local var_263_59 = var_263_57 <= 0 and var_263_52 or var_263_52 * (var_263_58 / var_263_57)

				if var_263_59 > 0 and var_263_52 < var_263_59 then
					arg_260_1.talkMaxDuration = var_263_59
					var_263_51 = var_263_51 + 0.3

					if var_263_59 + var_263_51 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_59 + var_263_51
					end
				end

				arg_260_1.text_.text = var_263_56
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112064", "story_v_out_322112.awb") ~= 0 then
					local var_263_60 = manager.audio:GetVoiceLength("story_v_out_322112", "322112064", "story_v_out_322112.awb") / 1000

					if var_263_60 + var_263_51 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_60 + var_263_51
					end

					if var_263_55.prefab_name ~= "" and arg_260_1.actors_[var_263_55.prefab_name] ~= nil then
						local var_263_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_55.prefab_name].transform, "story_v_out_322112", "322112064", "story_v_out_322112.awb")

						arg_260_1:RecordAudio("322112064", var_263_61)
						arg_260_1:RecordAudio("322112064", var_263_61)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_322112", "322112064", "story_v_out_322112.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_322112", "322112064", "story_v_out_322112.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_62 = var_263_51 + 0.3
			local var_263_63 = math.max(var_263_52, arg_260_1.talkMaxDuration)

			if var_263_62 <= arg_260_1.time_ and arg_260_1.time_ < var_263_62 + var_263_63 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_62) / var_263_63

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_62 + var_263_63 and arg_260_1.time_ < var_263_62 + var_263_63 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play322112065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 322112065
		arg_268_1.duration_ = 8.27

		local var_268_0 = {
			zh = 6.9,
			ja = 8.266
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play322112066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0
			local var_271_1 = 0.85

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_2 = arg_268_1:FormatText(StoryNameCfg[487].name)

				arg_268_1.leftNameTxt_.text = var_271_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_3 = arg_268_1:GetWordFromCfg(322112065)
				local var_271_4 = arg_268_1:FormatText(var_271_3.content)

				arg_268_1.text_.text = var_271_4

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 34
				local var_271_6 = utf8.len(var_271_4)
				local var_271_7 = var_271_5 <= 0 and var_271_1 or var_271_1 * (var_271_6 / var_271_5)

				if var_271_7 > 0 and var_271_1 < var_271_7 then
					arg_268_1.talkMaxDuration = var_271_7

					if var_271_7 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_0
					end
				end

				arg_268_1.text_.text = var_271_4
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112065", "story_v_out_322112.awb") ~= 0 then
					local var_271_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112065", "story_v_out_322112.awb") / 1000

					if var_271_8 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_8 + var_271_0
					end

					if var_271_3.prefab_name ~= "" and arg_268_1.actors_[var_271_3.prefab_name] ~= nil then
						local var_271_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_3.prefab_name].transform, "story_v_out_322112", "322112065", "story_v_out_322112.awb")

						arg_268_1:RecordAudio("322112065", var_271_9)
						arg_268_1:RecordAudio("322112065", var_271_9)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_322112", "322112065", "story_v_out_322112.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_322112", "322112065", "story_v_out_322112.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_10 = math.max(var_271_1, arg_268_1.talkMaxDuration)

			if var_271_0 <= arg_268_1.time_ and arg_268_1.time_ < var_271_0 + var_271_10 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_0) / var_271_10

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_0 + var_271_10 and arg_268_1.time_ < var_271_0 + var_271_10 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play322112066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 322112066
		arg_272_1.duration_ = 5.4

		local var_272_0 = {
			zh = 5.4,
			ja = 4.133
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play322112067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["10049ui_story"].transform
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1.var_.moveOldPos10049ui_story = var_275_0.localPosition

				local var_275_2 = GameObjectTools.GetOrAddComponent(var_275_0.gameObject, typeof(DynamicBoneHelper))

				if var_275_2 then
					var_275_2:EnableDynamicBone(false)
				end
			end

			local var_275_3 = 0.001

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_3 then
				local var_275_4 = (arg_272_1.time_ - var_275_1) / var_275_3
				local var_275_5 = Vector3.New(0, -1.13, -6)

				var_275_0.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos10049ui_story, var_275_5, var_275_4)

				local var_275_6 = manager.ui.mainCamera.transform.position - var_275_0.position

				var_275_0.forward = Vector3.New(var_275_6.x, var_275_6.y, var_275_6.z)

				local var_275_7 = var_275_0.localEulerAngles

				var_275_7.z = 0
				var_275_7.x = 0
				var_275_0.localEulerAngles = var_275_7
			end

			if arg_272_1.time_ >= var_275_1 + var_275_3 and arg_272_1.time_ < var_275_1 + var_275_3 + arg_275_0 then
				var_275_0.localPosition = Vector3.New(0, -1.13, -6)

				local var_275_8 = manager.ui.mainCamera.transform.position - var_275_0.position

				var_275_0.forward = Vector3.New(var_275_8.x, var_275_8.y, var_275_8.z)

				local var_275_9 = var_275_0.localEulerAngles

				var_275_9.z = 0
				var_275_9.x = 0
				var_275_0.localEulerAngles = var_275_9

				local var_275_10 = GameObjectTools.GetOrAddComponent(var_275_0.gameObject, typeof(DynamicBoneHelper))

				if var_275_10 then
					var_275_10:EnableDynamicBone(true)
				end
			end

			local var_275_11 = arg_272_1.actors_["10049ui_story"]
			local var_275_12 = 0

			if var_275_12 < arg_272_1.time_ and arg_272_1.time_ <= var_275_12 + arg_275_0 and not isNil(var_275_11) and arg_272_1.var_.characterEffect10049ui_story == nil then
				arg_272_1.var_.characterEffect10049ui_story = var_275_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_13 = 0.200000002980232

			if var_275_12 <= arg_272_1.time_ and arg_272_1.time_ < var_275_12 + var_275_13 and not isNil(var_275_11) then
				local var_275_14 = (arg_272_1.time_ - var_275_12) / var_275_13

				if arg_272_1.var_.characterEffect10049ui_story and not isNil(var_275_11) then
					arg_272_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= var_275_12 + var_275_13 and arg_272_1.time_ < var_275_12 + var_275_13 + arg_275_0 and not isNil(var_275_11) and arg_272_1.var_.characterEffect10049ui_story then
				arg_272_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			local var_275_15 = 0

			if var_275_15 < arg_272_1.time_ and arg_272_1.time_ <= var_275_15 + arg_275_0 then
				arg_272_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action1_1")
			end

			local var_275_16 = 0

			if var_275_16 < arg_272_1.time_ and arg_272_1.time_ <= var_275_16 + arg_275_0 then
				arg_272_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_275_17 = 0

			if var_275_17 < arg_272_1.time_ and arg_272_1.time_ <= var_275_17 + arg_275_0 then
				local var_275_18 = arg_272_1.actors_["10049ui_story"]

				if not isNil(var_275_18) then
					local var_275_19 = GameObjectTools.GetOrAddComponent(var_275_18, typeof(DynamicBoneHelper))

					if var_275_19 then
						var_275_19:EnableDynamicBone(true)
					end
				end
			end

			local var_275_20 = 0
			local var_275_21 = 0.525

			if var_275_20 < arg_272_1.time_ and arg_272_1.time_ <= var_275_20 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_22 = arg_272_1:FormatText(StoryNameCfg[468].name)

				arg_272_1.leftNameTxt_.text = var_275_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_23 = arg_272_1:GetWordFromCfg(322112066)
				local var_275_24 = arg_272_1:FormatText(var_275_23.content)

				arg_272_1.text_.text = var_275_24

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_25 = 21
				local var_275_26 = utf8.len(var_275_24)
				local var_275_27 = var_275_25 <= 0 and var_275_21 or var_275_21 * (var_275_26 / var_275_25)

				if var_275_27 > 0 and var_275_21 < var_275_27 then
					arg_272_1.talkMaxDuration = var_275_27

					if var_275_27 + var_275_20 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_27 + var_275_20
					end
				end

				arg_272_1.text_.text = var_275_24
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112066", "story_v_out_322112.awb") ~= 0 then
					local var_275_28 = manager.audio:GetVoiceLength("story_v_out_322112", "322112066", "story_v_out_322112.awb") / 1000

					if var_275_28 + var_275_20 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_28 + var_275_20
					end

					if var_275_23.prefab_name ~= "" and arg_272_1.actors_[var_275_23.prefab_name] ~= nil then
						local var_275_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_23.prefab_name].transform, "story_v_out_322112", "322112066", "story_v_out_322112.awb")

						arg_272_1:RecordAudio("322112066", var_275_29)
						arg_272_1:RecordAudio("322112066", var_275_29)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_322112", "322112066", "story_v_out_322112.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_322112", "322112066", "story_v_out_322112.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_30 = math.max(var_275_21, arg_272_1.talkMaxDuration)

			if var_275_20 <= arg_272_1.time_ and arg_272_1.time_ < var_275_20 + var_275_30 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_20) / var_275_30

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_20 + var_275_30 and arg_272_1.time_ < var_275_20 + var_275_30 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play322112067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 322112067
		arg_276_1.duration_ = 6.7

		local var_276_0 = {
			zh = 6.4,
			ja = 6.7
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play322112068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0
			local var_279_1 = 0.5

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_2 = arg_276_1:FormatText(StoryNameCfg[468].name)

				arg_276_1.leftNameTxt_.text = var_279_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_3 = arg_276_1:GetWordFromCfg(322112067)
				local var_279_4 = arg_276_1:FormatText(var_279_3.content)

				arg_276_1.text_.text = var_279_4

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 20
				local var_279_6 = utf8.len(var_279_4)
				local var_279_7 = var_279_5 <= 0 and var_279_1 or var_279_1 * (var_279_6 / var_279_5)

				if var_279_7 > 0 and var_279_1 < var_279_7 then
					arg_276_1.talkMaxDuration = var_279_7

					if var_279_7 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_7 + var_279_0
					end
				end

				arg_276_1.text_.text = var_279_4
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112067", "story_v_out_322112.awb") ~= 0 then
					local var_279_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112067", "story_v_out_322112.awb") / 1000

					if var_279_8 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_8 + var_279_0
					end

					if var_279_3.prefab_name ~= "" and arg_276_1.actors_[var_279_3.prefab_name] ~= nil then
						local var_279_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_3.prefab_name].transform, "story_v_out_322112", "322112067", "story_v_out_322112.awb")

						arg_276_1:RecordAudio("322112067", var_279_9)
						arg_276_1:RecordAudio("322112067", var_279_9)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_322112", "322112067", "story_v_out_322112.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_322112", "322112067", "story_v_out_322112.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_10 = math.max(var_279_1, arg_276_1.talkMaxDuration)

			if var_279_0 <= arg_276_1.time_ and arg_276_1.time_ < var_279_0 + var_279_10 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_0) / var_279_10

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_0 + var_279_10 and arg_276_1.time_ < var_279_0 + var_279_10 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play322112068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 322112068
		arg_280_1.duration_ = 2.23

		local var_280_0 = {
			zh = 1.566,
			ja = 2.233
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play322112069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["10049ui_story"]
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect10049ui_story == nil then
				arg_280_1.var_.characterEffect10049ui_story = var_283_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 and not isNil(var_283_0) then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2

				if arg_280_1.var_.characterEffect10049ui_story and not isNil(var_283_0) then
					local var_283_4 = Mathf.Lerp(0, 0.5, var_283_3)

					arg_280_1.var_.characterEffect10049ui_story.fillFlat = true
					arg_280_1.var_.characterEffect10049ui_story.fillRatio = var_283_4
				end
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect10049ui_story then
				local var_283_5 = 0.5

				arg_280_1.var_.characterEffect10049ui_story.fillFlat = true
				arg_280_1.var_.characterEffect10049ui_story.fillRatio = var_283_5
			end

			local var_283_6 = 0
			local var_283_7 = 0.15

			if var_283_6 < arg_280_1.time_ and arg_280_1.time_ <= var_283_6 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_8 = arg_280_1:FormatText(StoryNameCfg[487].name)

				arg_280_1.leftNameTxt_.text = var_283_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_9 = arg_280_1:GetWordFromCfg(322112068)
				local var_283_10 = arg_280_1:FormatText(var_283_9.content)

				arg_280_1.text_.text = var_283_10

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_11 = 6
				local var_283_12 = utf8.len(var_283_10)
				local var_283_13 = var_283_11 <= 0 and var_283_7 or var_283_7 * (var_283_12 / var_283_11)

				if var_283_13 > 0 and var_283_7 < var_283_13 then
					arg_280_1.talkMaxDuration = var_283_13

					if var_283_13 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_13 + var_283_6
					end
				end

				arg_280_1.text_.text = var_283_10
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112068", "story_v_out_322112.awb") ~= 0 then
					local var_283_14 = manager.audio:GetVoiceLength("story_v_out_322112", "322112068", "story_v_out_322112.awb") / 1000

					if var_283_14 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_14 + var_283_6
					end

					if var_283_9.prefab_name ~= "" and arg_280_1.actors_[var_283_9.prefab_name] ~= nil then
						local var_283_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_9.prefab_name].transform, "story_v_out_322112", "322112068", "story_v_out_322112.awb")

						arg_280_1:RecordAudio("322112068", var_283_15)
						arg_280_1:RecordAudio("322112068", var_283_15)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_322112", "322112068", "story_v_out_322112.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_322112", "322112068", "story_v_out_322112.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_16 = math.max(var_283_7, arg_280_1.talkMaxDuration)

			if var_283_6 <= arg_280_1.time_ and arg_280_1.time_ < var_283_6 + var_283_16 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_6) / var_283_16

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_6 + var_283_16 and arg_280_1.time_ < var_283_6 + var_283_16 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play322112069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 322112069
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play322112070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["10049ui_story"].transform
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.var_.moveOldPos10049ui_story = var_287_0.localPosition

				local var_287_2 = GameObjectTools.GetOrAddComponent(var_287_0.gameObject, typeof(DynamicBoneHelper))

				if var_287_2 then
					var_287_2:EnableDynamicBone(false)
				end
			end

			local var_287_3 = 0.001

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_3 then
				local var_287_4 = (arg_284_1.time_ - var_287_1) / var_287_3
				local var_287_5 = Vector3.New(0, 100, 0)

				var_287_0.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos10049ui_story, var_287_5, var_287_4)

				local var_287_6 = manager.ui.mainCamera.transform.position - var_287_0.position

				var_287_0.forward = Vector3.New(var_287_6.x, var_287_6.y, var_287_6.z)

				local var_287_7 = var_287_0.localEulerAngles

				var_287_7.z = 0
				var_287_7.x = 0
				var_287_0.localEulerAngles = var_287_7
			end

			if arg_284_1.time_ >= var_287_1 + var_287_3 and arg_284_1.time_ < var_287_1 + var_287_3 + arg_287_0 then
				var_287_0.localPosition = Vector3.New(0, 100, 0)

				local var_287_8 = manager.ui.mainCamera.transform.position - var_287_0.position

				var_287_0.forward = Vector3.New(var_287_8.x, var_287_8.y, var_287_8.z)

				local var_287_9 = var_287_0.localEulerAngles

				var_287_9.z = 0
				var_287_9.x = 0
				var_287_0.localEulerAngles = var_287_9

				local var_287_10 = GameObjectTools.GetOrAddComponent(var_287_0.gameObject, typeof(DynamicBoneHelper))

				if var_287_10 then
					var_287_10:EnableDynamicBone(true)
				end
			end

			local var_287_11 = 0
			local var_287_12 = 1.275

			if var_287_11 < arg_284_1.time_ and arg_284_1.time_ <= var_287_11 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_13 = arg_284_1:GetWordFromCfg(322112069)
				local var_287_14 = arg_284_1:FormatText(var_287_13.content)

				arg_284_1.text_.text = var_287_14

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_15 = 51
				local var_287_16 = utf8.len(var_287_14)
				local var_287_17 = var_287_15 <= 0 and var_287_12 or var_287_12 * (var_287_16 / var_287_15)

				if var_287_17 > 0 and var_287_12 < var_287_17 then
					arg_284_1.talkMaxDuration = var_287_17

					if var_287_17 + var_287_11 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_17 + var_287_11
					end
				end

				arg_284_1.text_.text = var_287_14
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_18 = math.max(var_287_12, arg_284_1.talkMaxDuration)

			if var_287_11 <= arg_284_1.time_ and arg_284_1.time_ < var_287_11 + var_287_18 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_11) / var_287_18

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_11 + var_287_18 and arg_284_1.time_ < var_287_11 + var_287_18 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play322112070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 322112070
		arg_288_1.duration_ = 2.6

		local var_288_0 = {
			zh = 2.066,
			ja = 2.6
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play322112071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0
			local var_291_1 = 0.3

			if var_291_0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_2 = arg_288_1:FormatText(StoryNameCfg[487].name)

				arg_288_1.leftNameTxt_.text = var_291_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_3 = arg_288_1:GetWordFromCfg(322112070)
				local var_291_4 = arg_288_1:FormatText(var_291_3.content)

				arg_288_1.text_.text = var_291_4

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_5 = 12
				local var_291_6 = utf8.len(var_291_4)
				local var_291_7 = var_291_5 <= 0 and var_291_1 or var_291_1 * (var_291_6 / var_291_5)

				if var_291_7 > 0 and var_291_1 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_0
					end
				end

				arg_288_1.text_.text = var_291_4
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112070", "story_v_out_322112.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112070", "story_v_out_322112.awb") / 1000

					if var_291_8 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_0
					end

					if var_291_3.prefab_name ~= "" and arg_288_1.actors_[var_291_3.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_3.prefab_name].transform, "story_v_out_322112", "322112070", "story_v_out_322112.awb")

						arg_288_1:RecordAudio("322112070", var_291_9)
						arg_288_1:RecordAudio("322112070", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_322112", "322112070", "story_v_out_322112.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_322112", "322112070", "story_v_out_322112.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_1, arg_288_1.talkMaxDuration)

			if var_291_0 <= arg_288_1.time_ and arg_288_1.time_ < var_291_0 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_0) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_0 + var_291_10 and arg_288_1.time_ < var_291_0 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play322112071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 322112071
		arg_292_1.duration_ = 8.5

		local var_292_0 = {
			zh = 7.7,
			ja = 8.5
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play322112072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["10049ui_story"].transform
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.var_.moveOldPos10049ui_story = var_295_0.localPosition

				local var_295_2 = GameObjectTools.GetOrAddComponent(var_295_0.gameObject, typeof(DynamicBoneHelper))

				if var_295_2 then
					var_295_2:EnableDynamicBone(false)
				end
			end

			local var_295_3 = 0.001

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_3 then
				local var_295_4 = (arg_292_1.time_ - var_295_1) / var_295_3
				local var_295_5 = Vector3.New(0, -1.13, -6)

				var_295_0.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10049ui_story, var_295_5, var_295_4)

				local var_295_6 = manager.ui.mainCamera.transform.position - var_295_0.position

				var_295_0.forward = Vector3.New(var_295_6.x, var_295_6.y, var_295_6.z)

				local var_295_7 = var_295_0.localEulerAngles

				var_295_7.z = 0
				var_295_7.x = 0
				var_295_0.localEulerAngles = var_295_7
			end

			if arg_292_1.time_ >= var_295_1 + var_295_3 and arg_292_1.time_ < var_295_1 + var_295_3 + arg_295_0 then
				var_295_0.localPosition = Vector3.New(0, -1.13, -6)

				local var_295_8 = manager.ui.mainCamera.transform.position - var_295_0.position

				var_295_0.forward = Vector3.New(var_295_8.x, var_295_8.y, var_295_8.z)

				local var_295_9 = var_295_0.localEulerAngles

				var_295_9.z = 0
				var_295_9.x = 0
				var_295_0.localEulerAngles = var_295_9

				local var_295_10 = GameObjectTools.GetOrAddComponent(var_295_0.gameObject, typeof(DynamicBoneHelper))

				if var_295_10 then
					var_295_10:EnableDynamicBone(true)
				end
			end

			local var_295_11 = arg_292_1.actors_["10049ui_story"]
			local var_295_12 = 0

			if var_295_12 < arg_292_1.time_ and arg_292_1.time_ <= var_295_12 + arg_295_0 and not isNil(var_295_11) and arg_292_1.var_.characterEffect10049ui_story == nil then
				arg_292_1.var_.characterEffect10049ui_story = var_295_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_13 = 0.200000002980232

			if var_295_12 <= arg_292_1.time_ and arg_292_1.time_ < var_295_12 + var_295_13 and not isNil(var_295_11) then
				local var_295_14 = (arg_292_1.time_ - var_295_12) / var_295_13

				if arg_292_1.var_.characterEffect10049ui_story and not isNil(var_295_11) then
					arg_292_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= var_295_12 + var_295_13 and arg_292_1.time_ < var_295_12 + var_295_13 + arg_295_0 and not isNil(var_295_11) and arg_292_1.var_.characterEffect10049ui_story then
				arg_292_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			local var_295_15 = 0

			if var_295_15 < arg_292_1.time_ and arg_292_1.time_ <= var_295_15 + arg_295_0 then
				arg_292_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action1_1")
			end

			local var_295_16 = 0

			if var_295_16 < arg_292_1.time_ and arg_292_1.time_ <= var_295_16 + arg_295_0 then
				arg_292_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_295_17 = 0

			if var_295_17 < arg_292_1.time_ and arg_292_1.time_ <= var_295_17 + arg_295_0 then
				local var_295_18 = arg_292_1.actors_["10049ui_story"]

				if not isNil(var_295_18) then
					local var_295_19 = GameObjectTools.GetOrAddComponent(var_295_18, typeof(DynamicBoneHelper))

					if var_295_19 then
						var_295_19:EnableDynamicBone(true)
					end
				end
			end

			local var_295_20 = 0
			local var_295_21 = 0.775

			if var_295_20 < arg_292_1.time_ and arg_292_1.time_ <= var_295_20 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_22 = arg_292_1:FormatText(StoryNameCfg[468].name)

				arg_292_1.leftNameTxt_.text = var_295_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_23 = arg_292_1:GetWordFromCfg(322112071)
				local var_295_24 = arg_292_1:FormatText(var_295_23.content)

				arg_292_1.text_.text = var_295_24

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_25 = 31
				local var_295_26 = utf8.len(var_295_24)
				local var_295_27 = var_295_25 <= 0 and var_295_21 or var_295_21 * (var_295_26 / var_295_25)

				if var_295_27 > 0 and var_295_21 < var_295_27 then
					arg_292_1.talkMaxDuration = var_295_27

					if var_295_27 + var_295_20 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_27 + var_295_20
					end
				end

				arg_292_1.text_.text = var_295_24
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112071", "story_v_out_322112.awb") ~= 0 then
					local var_295_28 = manager.audio:GetVoiceLength("story_v_out_322112", "322112071", "story_v_out_322112.awb") / 1000

					if var_295_28 + var_295_20 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_28 + var_295_20
					end

					if var_295_23.prefab_name ~= "" and arg_292_1.actors_[var_295_23.prefab_name] ~= nil then
						local var_295_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_23.prefab_name].transform, "story_v_out_322112", "322112071", "story_v_out_322112.awb")

						arg_292_1:RecordAudio("322112071", var_295_29)
						arg_292_1:RecordAudio("322112071", var_295_29)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_322112", "322112071", "story_v_out_322112.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_322112", "322112071", "story_v_out_322112.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_30 = math.max(var_295_21, arg_292_1.talkMaxDuration)

			if var_295_20 <= arg_292_1.time_ and arg_292_1.time_ < var_295_20 + var_295_30 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_20) / var_295_30

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_20 + var_295_30 and arg_292_1.time_ < var_295_20 + var_295_30 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play322112072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 322112072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play322112073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["10049ui_story"].transform
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.var_.moveOldPos10049ui_story = var_299_0.localPosition

				local var_299_2 = GameObjectTools.GetOrAddComponent(var_299_0.gameObject, typeof(DynamicBoneHelper))

				if var_299_2 then
					var_299_2:EnableDynamicBone(false)
				end
			end

			local var_299_3 = 0.001

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_3 then
				local var_299_4 = (arg_296_1.time_ - var_299_1) / var_299_3
				local var_299_5 = Vector3.New(0, 100, 0)

				var_299_0.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10049ui_story, var_299_5, var_299_4)

				local var_299_6 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_6.x, var_299_6.y, var_299_6.z)

				local var_299_7 = var_299_0.localEulerAngles

				var_299_7.z = 0
				var_299_7.x = 0
				var_299_0.localEulerAngles = var_299_7
			end

			if arg_296_1.time_ >= var_299_1 + var_299_3 and arg_296_1.time_ < var_299_1 + var_299_3 + arg_299_0 then
				var_299_0.localPosition = Vector3.New(0, 100, 0)

				local var_299_8 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_8.x, var_299_8.y, var_299_8.z)

				local var_299_9 = var_299_0.localEulerAngles

				var_299_9.z = 0
				var_299_9.x = 0
				var_299_0.localEulerAngles = var_299_9

				local var_299_10 = GameObjectTools.GetOrAddComponent(var_299_0.gameObject, typeof(DynamicBoneHelper))

				if var_299_10 then
					var_299_10:EnableDynamicBone(true)
				end
			end

			local var_299_11 = 0
			local var_299_12 = 1.05

			if var_299_11 < arg_296_1.time_ and arg_296_1.time_ <= var_299_11 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_13 = arg_296_1:GetWordFromCfg(322112072)
				local var_299_14 = arg_296_1:FormatText(var_299_13.content)

				arg_296_1.text_.text = var_299_14

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_15 = 42
				local var_299_16 = utf8.len(var_299_14)
				local var_299_17 = var_299_15 <= 0 and var_299_12 or var_299_12 * (var_299_16 / var_299_15)

				if var_299_17 > 0 and var_299_12 < var_299_17 then
					arg_296_1.talkMaxDuration = var_299_17

					if var_299_17 + var_299_11 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_17 + var_299_11
					end
				end

				arg_296_1.text_.text = var_299_14
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_18 = math.max(var_299_12, arg_296_1.talkMaxDuration)

			if var_299_11 <= arg_296_1.time_ and arg_296_1.time_ < var_299_11 + var_299_18 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_11) / var_299_18

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_11 + var_299_18 and arg_296_1.time_ < var_299_11 + var_299_18 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play322112073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 322112073
		arg_300_1.duration_ = 8.77

		local var_300_0 = {
			zh = 8.166,
			ja = 8.766
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play322112074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["10049ui_story"].transform
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.var_.moveOldPos10049ui_story = var_303_0.localPosition

				local var_303_2 = GameObjectTools.GetOrAddComponent(var_303_0.gameObject, typeof(DynamicBoneHelper))

				if var_303_2 then
					var_303_2:EnableDynamicBone(false)
				end
			end

			local var_303_3 = 0.001

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_3 then
				local var_303_4 = (arg_300_1.time_ - var_303_1) / var_303_3
				local var_303_5 = Vector3.New(0, -1.13, -6)

				var_303_0.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10049ui_story, var_303_5, var_303_4)

				local var_303_6 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_6.x, var_303_6.y, var_303_6.z)

				local var_303_7 = var_303_0.localEulerAngles

				var_303_7.z = 0
				var_303_7.x = 0
				var_303_0.localEulerAngles = var_303_7
			end

			if arg_300_1.time_ >= var_303_1 + var_303_3 and arg_300_1.time_ < var_303_1 + var_303_3 + arg_303_0 then
				var_303_0.localPosition = Vector3.New(0, -1.13, -6)

				local var_303_8 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_8.x, var_303_8.y, var_303_8.z)

				local var_303_9 = var_303_0.localEulerAngles

				var_303_9.z = 0
				var_303_9.x = 0
				var_303_0.localEulerAngles = var_303_9

				local var_303_10 = GameObjectTools.GetOrAddComponent(var_303_0.gameObject, typeof(DynamicBoneHelper))

				if var_303_10 then
					var_303_10:EnableDynamicBone(true)
				end
			end

			local var_303_11 = arg_300_1.actors_["10049ui_story"]
			local var_303_12 = 0

			if var_303_12 < arg_300_1.time_ and arg_300_1.time_ <= var_303_12 + arg_303_0 and not isNil(var_303_11) and arg_300_1.var_.characterEffect10049ui_story == nil then
				arg_300_1.var_.characterEffect10049ui_story = var_303_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_13 = 0.200000002980232

			if var_303_12 <= arg_300_1.time_ and arg_300_1.time_ < var_303_12 + var_303_13 and not isNil(var_303_11) then
				local var_303_14 = (arg_300_1.time_ - var_303_12) / var_303_13

				if arg_300_1.var_.characterEffect10049ui_story and not isNil(var_303_11) then
					arg_300_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= var_303_12 + var_303_13 and arg_300_1.time_ < var_303_12 + var_303_13 + arg_303_0 and not isNil(var_303_11) and arg_300_1.var_.characterEffect10049ui_story then
				arg_300_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			local var_303_15 = 0

			if var_303_15 < arg_300_1.time_ and arg_300_1.time_ <= var_303_15 + arg_303_0 then
				arg_300_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action3_1")
			end

			local var_303_16 = 0

			if var_303_16 < arg_300_1.time_ and arg_300_1.time_ <= var_303_16 + arg_303_0 then
				arg_300_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_303_17 = 0

			if var_303_17 < arg_300_1.time_ and arg_300_1.time_ <= var_303_17 + arg_303_0 then
				local var_303_18 = arg_300_1.actors_["10049ui_story"]

				if not isNil(var_303_18) then
					local var_303_19 = GameObjectTools.GetOrAddComponent(var_303_18, typeof(DynamicBoneHelper))

					if var_303_19 then
						var_303_19:EnableDynamicBone(true)
					end
				end
			end

			local var_303_20 = 0
			local var_303_21 = 0.675

			if var_303_20 < arg_300_1.time_ and arg_300_1.time_ <= var_303_20 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_22 = arg_300_1:FormatText(StoryNameCfg[468].name)

				arg_300_1.leftNameTxt_.text = var_303_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_23 = arg_300_1:GetWordFromCfg(322112073)
				local var_303_24 = arg_300_1:FormatText(var_303_23.content)

				arg_300_1.text_.text = var_303_24

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_25 = 28
				local var_303_26 = utf8.len(var_303_24)
				local var_303_27 = var_303_25 <= 0 and var_303_21 or var_303_21 * (var_303_26 / var_303_25)

				if var_303_27 > 0 and var_303_21 < var_303_27 then
					arg_300_1.talkMaxDuration = var_303_27

					if var_303_27 + var_303_20 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_27 + var_303_20
					end
				end

				arg_300_1.text_.text = var_303_24
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112073", "story_v_out_322112.awb") ~= 0 then
					local var_303_28 = manager.audio:GetVoiceLength("story_v_out_322112", "322112073", "story_v_out_322112.awb") / 1000

					if var_303_28 + var_303_20 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_28 + var_303_20
					end

					if var_303_23.prefab_name ~= "" and arg_300_1.actors_[var_303_23.prefab_name] ~= nil then
						local var_303_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_23.prefab_name].transform, "story_v_out_322112", "322112073", "story_v_out_322112.awb")

						arg_300_1:RecordAudio("322112073", var_303_29)
						arg_300_1:RecordAudio("322112073", var_303_29)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_322112", "322112073", "story_v_out_322112.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_322112", "322112073", "story_v_out_322112.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_30 = math.max(var_303_21, arg_300_1.talkMaxDuration)

			if var_303_20 <= arg_300_1.time_ and arg_300_1.time_ < var_303_20 + var_303_30 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_20) / var_303_30

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_20 + var_303_30 and arg_300_1.time_ < var_303_20 + var_303_30 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play322112074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 322112074
		arg_304_1.duration_ = 11.1

		local var_304_0 = {
			zh = 11.1,
			ja = 9.5
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play322112075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 0.85

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_2 = arg_304_1:FormatText(StoryNameCfg[468].name)

				arg_304_1.leftNameTxt_.text = var_307_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_3 = arg_304_1:GetWordFromCfg(322112074)
				local var_307_4 = arg_304_1:FormatText(var_307_3.content)

				arg_304_1.text_.text = var_307_4

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 34
				local var_307_6 = utf8.len(var_307_4)
				local var_307_7 = var_307_5 <= 0 and var_307_1 or var_307_1 * (var_307_6 / var_307_5)

				if var_307_7 > 0 and var_307_1 < var_307_7 then
					arg_304_1.talkMaxDuration = var_307_7

					if var_307_7 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_7 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_4
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112074", "story_v_out_322112.awb") ~= 0 then
					local var_307_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112074", "story_v_out_322112.awb") / 1000

					if var_307_8 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_8 + var_307_0
					end

					if var_307_3.prefab_name ~= "" and arg_304_1.actors_[var_307_3.prefab_name] ~= nil then
						local var_307_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_3.prefab_name].transform, "story_v_out_322112", "322112074", "story_v_out_322112.awb")

						arg_304_1:RecordAudio("322112074", var_307_9)
						arg_304_1:RecordAudio("322112074", var_307_9)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_322112", "322112074", "story_v_out_322112.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_322112", "322112074", "story_v_out_322112.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_10 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_10 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_10

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_10 and arg_304_1.time_ < var_307_0 + var_307_10 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play322112075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 322112075
		arg_308_1.duration_ = 14.53

		local var_308_0 = {
			zh = 14.533,
			ja = 12.933
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play322112076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				arg_308_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action3_2")
			end

			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_311_2 = 0

			if var_311_2 < arg_308_1.time_ and arg_308_1.time_ <= var_311_2 + arg_311_0 then
				local var_311_3 = arg_308_1.actors_["10049ui_story"]

				if not isNil(var_311_3) then
					local var_311_4 = GameObjectTools.GetOrAddComponent(var_311_3, typeof(DynamicBoneHelper))

					if var_311_4 then
						var_311_4:EnableDynamicBone(true)
					end
				end
			end

			local var_311_5 = 0
			local var_311_6 = 1.2

			if var_311_5 < arg_308_1.time_ and arg_308_1.time_ <= var_311_5 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_7 = arg_308_1:FormatText(StoryNameCfg[468].name)

				arg_308_1.leftNameTxt_.text = var_311_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_8 = arg_308_1:GetWordFromCfg(322112075)
				local var_311_9 = arg_308_1:FormatText(var_311_8.content)

				arg_308_1.text_.text = var_311_9

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_10 = 48
				local var_311_11 = utf8.len(var_311_9)
				local var_311_12 = var_311_10 <= 0 and var_311_6 or var_311_6 * (var_311_11 / var_311_10)

				if var_311_12 > 0 and var_311_6 < var_311_12 then
					arg_308_1.talkMaxDuration = var_311_12

					if var_311_12 + var_311_5 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_12 + var_311_5
					end
				end

				arg_308_1.text_.text = var_311_9
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112075", "story_v_out_322112.awb") ~= 0 then
					local var_311_13 = manager.audio:GetVoiceLength("story_v_out_322112", "322112075", "story_v_out_322112.awb") / 1000

					if var_311_13 + var_311_5 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_13 + var_311_5
					end

					if var_311_8.prefab_name ~= "" and arg_308_1.actors_[var_311_8.prefab_name] ~= nil then
						local var_311_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_8.prefab_name].transform, "story_v_out_322112", "322112075", "story_v_out_322112.awb")

						arg_308_1:RecordAudio("322112075", var_311_14)
						arg_308_1:RecordAudio("322112075", var_311_14)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_322112", "322112075", "story_v_out_322112.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_322112", "322112075", "story_v_out_322112.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_15 = math.max(var_311_6, arg_308_1.talkMaxDuration)

			if var_311_5 <= arg_308_1.time_ and arg_308_1.time_ < var_311_5 + var_311_15 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_5) / var_311_15

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_5 + var_311_15 and arg_308_1.time_ < var_311_5 + var_311_15 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play322112076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 322112076
		arg_312_1.duration_ = 9.27

		local var_312_0 = {
			zh = 5.666,
			ja = 9.266
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play322112077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["10049ui_story"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.characterEffect10049ui_story == nil then
				arg_312_1.var_.characterEffect10049ui_story = var_315_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_2 = 0.200000002980232

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.characterEffect10049ui_story and not isNil(var_315_0) then
					local var_315_4 = Mathf.Lerp(0, 0.5, var_315_3)

					arg_312_1.var_.characterEffect10049ui_story.fillFlat = true
					arg_312_1.var_.characterEffect10049ui_story.fillRatio = var_315_4
				end
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.characterEffect10049ui_story then
				local var_315_5 = 0.5

				arg_312_1.var_.characterEffect10049ui_story.fillFlat = true
				arg_312_1.var_.characterEffect10049ui_story.fillRatio = var_315_5
			end

			local var_315_6 = 0
			local var_315_7 = 0.725

			if var_315_6 < arg_312_1.time_ and arg_312_1.time_ <= var_315_6 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_8 = arg_312_1:FormatText(StoryNameCfg[487].name)

				arg_312_1.leftNameTxt_.text = var_315_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_9 = arg_312_1:GetWordFromCfg(322112076)
				local var_315_10 = arg_312_1:FormatText(var_315_9.content)

				arg_312_1.text_.text = var_315_10

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_11 = 29
				local var_315_12 = utf8.len(var_315_10)
				local var_315_13 = var_315_11 <= 0 and var_315_7 or var_315_7 * (var_315_12 / var_315_11)

				if var_315_13 > 0 and var_315_7 < var_315_13 then
					arg_312_1.talkMaxDuration = var_315_13

					if var_315_13 + var_315_6 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_13 + var_315_6
					end
				end

				arg_312_1.text_.text = var_315_10
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112076", "story_v_out_322112.awb") ~= 0 then
					local var_315_14 = manager.audio:GetVoiceLength("story_v_out_322112", "322112076", "story_v_out_322112.awb") / 1000

					if var_315_14 + var_315_6 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_14 + var_315_6
					end

					if var_315_9.prefab_name ~= "" and arg_312_1.actors_[var_315_9.prefab_name] ~= nil then
						local var_315_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_9.prefab_name].transform, "story_v_out_322112", "322112076", "story_v_out_322112.awb")

						arg_312_1:RecordAudio("322112076", var_315_15)
						arg_312_1:RecordAudio("322112076", var_315_15)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_322112", "322112076", "story_v_out_322112.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_322112", "322112076", "story_v_out_322112.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_16 = math.max(var_315_7, arg_312_1.talkMaxDuration)

			if var_315_6 <= arg_312_1.time_ and arg_312_1.time_ < var_315_6 + var_315_16 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_6) / var_315_16

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_6 + var_315_16 and arg_312_1.time_ < var_315_6 + var_315_16 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play322112077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 322112077
		arg_316_1.duration_ = 10.93

		local var_316_0 = {
			zh = 8.9,
			ja = 10.933
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play322112078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["10049ui_story"].transform
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.var_.moveOldPos10049ui_story = var_319_0.localPosition

				local var_319_2 = GameObjectTools.GetOrAddComponent(var_319_0.gameObject, typeof(DynamicBoneHelper))

				if var_319_2 then
					var_319_2:EnableDynamicBone(false)
				end
			end

			local var_319_3 = 0.001

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_3 then
				local var_319_4 = (arg_316_1.time_ - var_319_1) / var_319_3
				local var_319_5 = Vector3.New(0, -1.13, -6)

				var_319_0.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10049ui_story, var_319_5, var_319_4)

				local var_319_6 = manager.ui.mainCamera.transform.position - var_319_0.position

				var_319_0.forward = Vector3.New(var_319_6.x, var_319_6.y, var_319_6.z)

				local var_319_7 = var_319_0.localEulerAngles

				var_319_7.z = 0
				var_319_7.x = 0
				var_319_0.localEulerAngles = var_319_7
			end

			if arg_316_1.time_ >= var_319_1 + var_319_3 and arg_316_1.time_ < var_319_1 + var_319_3 + arg_319_0 then
				var_319_0.localPosition = Vector3.New(0, -1.13, -6)

				local var_319_8 = manager.ui.mainCamera.transform.position - var_319_0.position

				var_319_0.forward = Vector3.New(var_319_8.x, var_319_8.y, var_319_8.z)

				local var_319_9 = var_319_0.localEulerAngles

				var_319_9.z = 0
				var_319_9.x = 0
				var_319_0.localEulerAngles = var_319_9

				local var_319_10 = GameObjectTools.GetOrAddComponent(var_319_0.gameObject, typeof(DynamicBoneHelper))

				if var_319_10 then
					var_319_10:EnableDynamicBone(true)
				end
			end

			local var_319_11 = arg_316_1.actors_["10049ui_story"]
			local var_319_12 = 0

			if var_319_12 < arg_316_1.time_ and arg_316_1.time_ <= var_319_12 + arg_319_0 and not isNil(var_319_11) and arg_316_1.var_.characterEffect10049ui_story == nil then
				arg_316_1.var_.characterEffect10049ui_story = var_319_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_13 = 0.200000002980232

			if var_319_12 <= arg_316_1.time_ and arg_316_1.time_ < var_319_12 + var_319_13 and not isNil(var_319_11) then
				local var_319_14 = (arg_316_1.time_ - var_319_12) / var_319_13

				if arg_316_1.var_.characterEffect10049ui_story and not isNil(var_319_11) then
					arg_316_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= var_319_12 + var_319_13 and arg_316_1.time_ < var_319_12 + var_319_13 + arg_319_0 and not isNil(var_319_11) and arg_316_1.var_.characterEffect10049ui_story then
				arg_316_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			local var_319_15 = 0

			if var_319_15 < arg_316_1.time_ and arg_316_1.time_ <= var_319_15 + arg_319_0 then
				arg_316_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action9_1")
			end

			local var_319_16 = 0

			if var_319_16 < arg_316_1.time_ and arg_316_1.time_ <= var_319_16 + arg_319_0 then
				arg_316_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_319_17 = 0

			if var_319_17 < arg_316_1.time_ and arg_316_1.time_ <= var_319_17 + arg_319_0 then
				local var_319_18 = arg_316_1.actors_["10049ui_story"]

				if not isNil(var_319_18) then
					local var_319_19 = GameObjectTools.GetOrAddComponent(var_319_18, typeof(DynamicBoneHelper))

					if var_319_19 then
						var_319_19:EnableDynamicBone(true)
					end
				end
			end

			local var_319_20 = 0
			local var_319_21 = 0.775

			if var_319_20 < arg_316_1.time_ and arg_316_1.time_ <= var_319_20 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_22 = arg_316_1:FormatText(StoryNameCfg[468].name)

				arg_316_1.leftNameTxt_.text = var_319_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_23 = arg_316_1:GetWordFromCfg(322112077)
				local var_319_24 = arg_316_1:FormatText(var_319_23.content)

				arg_316_1.text_.text = var_319_24

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_25 = 31
				local var_319_26 = utf8.len(var_319_24)
				local var_319_27 = var_319_25 <= 0 and var_319_21 or var_319_21 * (var_319_26 / var_319_25)

				if var_319_27 > 0 and var_319_21 < var_319_27 then
					arg_316_1.talkMaxDuration = var_319_27

					if var_319_27 + var_319_20 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_27 + var_319_20
					end
				end

				arg_316_1.text_.text = var_319_24
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112077", "story_v_out_322112.awb") ~= 0 then
					local var_319_28 = manager.audio:GetVoiceLength("story_v_out_322112", "322112077", "story_v_out_322112.awb") / 1000

					if var_319_28 + var_319_20 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_28 + var_319_20
					end

					if var_319_23.prefab_name ~= "" and arg_316_1.actors_[var_319_23.prefab_name] ~= nil then
						local var_319_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_23.prefab_name].transform, "story_v_out_322112", "322112077", "story_v_out_322112.awb")

						arg_316_1:RecordAudio("322112077", var_319_29)
						arg_316_1:RecordAudio("322112077", var_319_29)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_322112", "322112077", "story_v_out_322112.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_322112", "322112077", "story_v_out_322112.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_30 = math.max(var_319_21, arg_316_1.talkMaxDuration)

			if var_319_20 <= arg_316_1.time_ and arg_316_1.time_ < var_319_20 + var_319_30 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_20) / var_319_30

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_20 + var_319_30 and arg_316_1.time_ < var_319_20 + var_319_30 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play322112078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 322112078
		arg_320_1.duration_ = 15.4

		local var_320_0 = {
			zh = 9.2,
			ja = 15.4
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play322112079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 0.925

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_2 = arg_320_1:FormatText(StoryNameCfg[468].name)

				arg_320_1.leftNameTxt_.text = var_323_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_3 = arg_320_1:GetWordFromCfg(322112078)
				local var_323_4 = arg_320_1:FormatText(var_323_3.content)

				arg_320_1.text_.text = var_323_4

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_5 = 37
				local var_323_6 = utf8.len(var_323_4)
				local var_323_7 = var_323_5 <= 0 and var_323_1 or var_323_1 * (var_323_6 / var_323_5)

				if var_323_7 > 0 and var_323_1 < var_323_7 then
					arg_320_1.talkMaxDuration = var_323_7

					if var_323_7 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_4
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112078", "story_v_out_322112.awb") ~= 0 then
					local var_323_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112078", "story_v_out_322112.awb") / 1000

					if var_323_8 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_8 + var_323_0
					end

					if var_323_3.prefab_name ~= "" and arg_320_1.actors_[var_323_3.prefab_name] ~= nil then
						local var_323_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_3.prefab_name].transform, "story_v_out_322112", "322112078", "story_v_out_322112.awb")

						arg_320_1:RecordAudio("322112078", var_323_9)
						arg_320_1:RecordAudio("322112078", var_323_9)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_322112", "322112078", "story_v_out_322112.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_322112", "322112078", "story_v_out_322112.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_10 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_10 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_10

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_10 and arg_320_1.time_ < var_323_0 + var_323_10 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play322112079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 322112079
		arg_324_1.duration_ = 7.7

		local var_324_0 = {
			zh = 5.7,
			ja = 7.7
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play322112080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["10049ui_story"]
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect10049ui_story == nil then
				arg_324_1.var_.characterEffect10049ui_story = var_327_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.200000002980232

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 and not isNil(var_327_0) then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2

				if arg_324_1.var_.characterEffect10049ui_story and not isNil(var_327_0) then
					local var_327_4 = Mathf.Lerp(0, 0.5, var_327_3)

					arg_324_1.var_.characterEffect10049ui_story.fillFlat = true
					arg_324_1.var_.characterEffect10049ui_story.fillRatio = var_327_4
				end
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect10049ui_story then
				local var_327_5 = 0.5

				arg_324_1.var_.characterEffect10049ui_story.fillFlat = true
				arg_324_1.var_.characterEffect10049ui_story.fillRatio = var_327_5
			end

			local var_327_6 = 0
			local var_327_7 = 0.675

			if var_327_6 < arg_324_1.time_ and arg_324_1.time_ <= var_327_6 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_8 = arg_324_1:FormatText(StoryNameCfg[487].name)

				arg_324_1.leftNameTxt_.text = var_327_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_9 = arg_324_1:GetWordFromCfg(322112079)
				local var_327_10 = arg_324_1:FormatText(var_327_9.content)

				arg_324_1.text_.text = var_327_10

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_11 = 27
				local var_327_12 = utf8.len(var_327_10)
				local var_327_13 = var_327_11 <= 0 and var_327_7 or var_327_7 * (var_327_12 / var_327_11)

				if var_327_13 > 0 and var_327_7 < var_327_13 then
					arg_324_1.talkMaxDuration = var_327_13

					if var_327_13 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_13 + var_327_6
					end
				end

				arg_324_1.text_.text = var_327_10
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112079", "story_v_out_322112.awb") ~= 0 then
					local var_327_14 = manager.audio:GetVoiceLength("story_v_out_322112", "322112079", "story_v_out_322112.awb") / 1000

					if var_327_14 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_14 + var_327_6
					end

					if var_327_9.prefab_name ~= "" and arg_324_1.actors_[var_327_9.prefab_name] ~= nil then
						local var_327_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_9.prefab_name].transform, "story_v_out_322112", "322112079", "story_v_out_322112.awb")

						arg_324_1:RecordAudio("322112079", var_327_15)
						arg_324_1:RecordAudio("322112079", var_327_15)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_322112", "322112079", "story_v_out_322112.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_322112", "322112079", "story_v_out_322112.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_16 = math.max(var_327_7, arg_324_1.talkMaxDuration)

			if var_327_6 <= arg_324_1.time_ and arg_324_1.time_ < var_327_6 + var_327_16 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_6) / var_327_16

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_6 + var_327_16 and arg_324_1.time_ < var_327_6 + var_327_16 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play322112080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 322112080
		arg_328_1.duration_ = 4.7

		local var_328_0 = {
			zh = 3.2,
			ja = 4.7
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play322112081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0
			local var_331_1 = 0.45

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_2 = arg_328_1:FormatText(StoryNameCfg[487].name)

				arg_328_1.leftNameTxt_.text = var_331_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_3 = arg_328_1:GetWordFromCfg(322112080)
				local var_331_4 = arg_328_1:FormatText(var_331_3.content)

				arg_328_1.text_.text = var_331_4

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 18
				local var_331_6 = utf8.len(var_331_4)
				local var_331_7 = var_331_5 <= 0 and var_331_1 or var_331_1 * (var_331_6 / var_331_5)

				if var_331_7 > 0 and var_331_1 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_0
					end
				end

				arg_328_1.text_.text = var_331_4
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112080", "story_v_out_322112.awb") ~= 0 then
					local var_331_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112080", "story_v_out_322112.awb") / 1000

					if var_331_8 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_0
					end

					if var_331_3.prefab_name ~= "" and arg_328_1.actors_[var_331_3.prefab_name] ~= nil then
						local var_331_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_3.prefab_name].transform, "story_v_out_322112", "322112080", "story_v_out_322112.awb")

						arg_328_1:RecordAudio("322112080", var_331_9)
						arg_328_1:RecordAudio("322112080", var_331_9)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_322112", "322112080", "story_v_out_322112.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_322112", "322112080", "story_v_out_322112.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_10 = math.max(var_331_1, arg_328_1.talkMaxDuration)

			if var_331_0 <= arg_328_1.time_ and arg_328_1.time_ < var_331_0 + var_331_10 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_0) / var_331_10

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_0 + var_331_10 and arg_328_1.time_ < var_331_0 + var_331_10 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play322112081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 322112081
		arg_332_1.duration_ = 2.97

		local var_332_0 = {
			zh = 2.3,
			ja = 2.966
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play322112082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["10049ui_story"].transform
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.var_.moveOldPos10049ui_story = var_335_0.localPosition

				local var_335_2 = GameObjectTools.GetOrAddComponent(var_335_0.gameObject, typeof(DynamicBoneHelper))

				if var_335_2 then
					var_335_2:EnableDynamicBone(false)
				end
			end

			local var_335_3 = 0.001

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_3 then
				local var_335_4 = (arg_332_1.time_ - var_335_1) / var_335_3
				local var_335_5 = Vector3.New(0, -1.13, -6)

				var_335_0.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10049ui_story, var_335_5, var_335_4)

				local var_335_6 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_6.x, var_335_6.y, var_335_6.z)

				local var_335_7 = var_335_0.localEulerAngles

				var_335_7.z = 0
				var_335_7.x = 0
				var_335_0.localEulerAngles = var_335_7
			end

			if arg_332_1.time_ >= var_335_1 + var_335_3 and arg_332_1.time_ < var_335_1 + var_335_3 + arg_335_0 then
				var_335_0.localPosition = Vector3.New(0, -1.13, -6)

				local var_335_8 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_8.x, var_335_8.y, var_335_8.z)

				local var_335_9 = var_335_0.localEulerAngles

				var_335_9.z = 0
				var_335_9.x = 0
				var_335_0.localEulerAngles = var_335_9

				local var_335_10 = GameObjectTools.GetOrAddComponent(var_335_0.gameObject, typeof(DynamicBoneHelper))

				if var_335_10 then
					var_335_10:EnableDynamicBone(true)
				end
			end

			local var_335_11 = arg_332_1.actors_["10049ui_story"]
			local var_335_12 = 0

			if var_335_12 < arg_332_1.time_ and arg_332_1.time_ <= var_335_12 + arg_335_0 and not isNil(var_335_11) and arg_332_1.var_.characterEffect10049ui_story == nil then
				arg_332_1.var_.characterEffect10049ui_story = var_335_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_13 = 0.200000002980232

			if var_335_12 <= arg_332_1.time_ and arg_332_1.time_ < var_335_12 + var_335_13 and not isNil(var_335_11) then
				local var_335_14 = (arg_332_1.time_ - var_335_12) / var_335_13

				if arg_332_1.var_.characterEffect10049ui_story and not isNil(var_335_11) then
					arg_332_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= var_335_12 + var_335_13 and arg_332_1.time_ < var_335_12 + var_335_13 + arg_335_0 and not isNil(var_335_11) and arg_332_1.var_.characterEffect10049ui_story then
				arg_332_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			local var_335_15 = 0

			if var_335_15 < arg_332_1.time_ and arg_332_1.time_ <= var_335_15 + arg_335_0 then
				arg_332_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action9_2")
			end

			local var_335_16 = 0

			if var_335_16 < arg_332_1.time_ and arg_332_1.time_ <= var_335_16 + arg_335_0 then
				arg_332_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_335_17 = 0

			if var_335_17 < arg_332_1.time_ and arg_332_1.time_ <= var_335_17 + arg_335_0 then
				local var_335_18 = arg_332_1.actors_["10049ui_story"]

				if not isNil(var_335_18) then
					local var_335_19 = GameObjectTools.GetOrAddComponent(var_335_18, typeof(DynamicBoneHelper))

					if var_335_19 then
						var_335_19:EnableDynamicBone(true)
					end
				end
			end

			local var_335_20 = 0
			local var_335_21 = 0.125

			if var_335_20 < arg_332_1.time_ and arg_332_1.time_ <= var_335_20 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_22 = arg_332_1:FormatText(StoryNameCfg[468].name)

				arg_332_1.leftNameTxt_.text = var_335_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_23 = arg_332_1:GetWordFromCfg(322112081)
				local var_335_24 = arg_332_1:FormatText(var_335_23.content)

				arg_332_1.text_.text = var_335_24

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_25 = 5
				local var_335_26 = utf8.len(var_335_24)
				local var_335_27 = var_335_25 <= 0 and var_335_21 or var_335_21 * (var_335_26 / var_335_25)

				if var_335_27 > 0 and var_335_21 < var_335_27 then
					arg_332_1.talkMaxDuration = var_335_27

					if var_335_27 + var_335_20 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_27 + var_335_20
					end
				end

				arg_332_1.text_.text = var_335_24
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112081", "story_v_out_322112.awb") ~= 0 then
					local var_335_28 = manager.audio:GetVoiceLength("story_v_out_322112", "322112081", "story_v_out_322112.awb") / 1000

					if var_335_28 + var_335_20 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_28 + var_335_20
					end

					if var_335_23.prefab_name ~= "" and arg_332_1.actors_[var_335_23.prefab_name] ~= nil then
						local var_335_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_23.prefab_name].transform, "story_v_out_322112", "322112081", "story_v_out_322112.awb")

						arg_332_1:RecordAudio("322112081", var_335_29)
						arg_332_1:RecordAudio("322112081", var_335_29)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_322112", "322112081", "story_v_out_322112.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_322112", "322112081", "story_v_out_322112.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_30 = math.max(var_335_21, arg_332_1.talkMaxDuration)

			if var_335_20 <= arg_332_1.time_ and arg_332_1.time_ < var_335_20 + var_335_30 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_20) / var_335_30

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_20 + var_335_30 and arg_332_1.time_ < var_335_20 + var_335_30 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play322112082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 322112082
		arg_336_1.duration_ = 13.53

		local var_336_0 = {
			zh = 10.3660000029802,
			ja = 13.5330000029802
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play322112083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 1.999999999999

			if var_339_0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				local var_339_1 = manager.ui.mainCamera.transform.localPosition
				local var_339_2 = Vector3.New(0, 0, 10) + Vector3.New(var_339_1.x, var_339_1.y, 0)
				local var_339_3 = arg_336_1.bgs_.L14f

				var_339_3.transform.localPosition = var_339_2
				var_339_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_339_4 = var_339_3:GetComponent("SpriteRenderer")

				if var_339_4 and var_339_4.sprite then
					local var_339_5 = (var_339_3.transform.localPosition - var_339_1).z
					local var_339_6 = manager.ui.mainCameraCom_
					local var_339_7 = 2 * var_339_5 * Mathf.Tan(var_339_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_339_8 = var_339_7 * var_339_6.aspect
					local var_339_9 = var_339_4.sprite.bounds.size.x
					local var_339_10 = var_339_4.sprite.bounds.size.y
					local var_339_11 = var_339_8 / var_339_9
					local var_339_12 = var_339_7 / var_339_10
					local var_339_13 = var_339_12 < var_339_11 and var_339_11 or var_339_12

					var_339_3.transform.localScale = Vector3.New(var_339_13, var_339_13, 0)
				end

				for iter_339_0, iter_339_1 in pairs(arg_336_1.bgs_) do
					if iter_339_0 ~= "L14f" then
						iter_339_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_339_14 = 4.00000000298023

			if var_339_14 < arg_336_1.time_ and arg_336_1.time_ <= var_339_14 + arg_339_0 then
				arg_336_1.allBtn_.enabled = false
			end

			local var_339_15 = 0.3

			if arg_336_1.time_ >= var_339_14 + var_339_15 and arg_336_1.time_ < var_339_14 + var_339_15 + arg_339_0 then
				arg_336_1.allBtn_.enabled = true
			end

			local var_339_16 = 0

			if var_339_16 < arg_336_1.time_ and arg_336_1.time_ <= var_339_16 + arg_339_0 then
				arg_336_1.mask_.enabled = true
				arg_336_1.mask_.raycastTarget = true

				arg_336_1:SetGaussion(false)
			end

			local var_339_17 = 2

			if var_339_16 <= arg_336_1.time_ and arg_336_1.time_ < var_339_16 + var_339_17 then
				local var_339_18 = (arg_336_1.time_ - var_339_16) / var_339_17
				local var_339_19 = Color.New(0, 0, 0)

				var_339_19.a = Mathf.Lerp(0, 1, var_339_18)
				arg_336_1.mask_.color = var_339_19
			end

			if arg_336_1.time_ >= var_339_16 + var_339_17 and arg_336_1.time_ < var_339_16 + var_339_17 + arg_339_0 then
				local var_339_20 = Color.New(0, 0, 0)

				var_339_20.a = 1
				arg_336_1.mask_.color = var_339_20
			end

			local var_339_21 = 2

			if var_339_21 < arg_336_1.time_ and arg_336_1.time_ <= var_339_21 + arg_339_0 then
				arg_336_1.mask_.enabled = true
				arg_336_1.mask_.raycastTarget = true

				arg_336_1:SetGaussion(false)
			end

			local var_339_22 = 2

			if var_339_21 <= arg_336_1.time_ and arg_336_1.time_ < var_339_21 + var_339_22 then
				local var_339_23 = (arg_336_1.time_ - var_339_21) / var_339_22
				local var_339_24 = Color.New(0, 0, 0)

				var_339_24.a = Mathf.Lerp(1, 0, var_339_23)
				arg_336_1.mask_.color = var_339_24
			end

			if arg_336_1.time_ >= var_339_21 + var_339_22 and arg_336_1.time_ < var_339_21 + var_339_22 + arg_339_0 then
				local var_339_25 = Color.New(0, 0, 0)
				local var_339_26 = 0

				arg_336_1.mask_.enabled = false
				var_339_25.a = var_339_26
				arg_336_1.mask_.color = var_339_25
			end

			local var_339_27 = arg_336_1.actors_["10049ui_story"].transform
			local var_339_28 = 1.96599999815226

			if var_339_28 < arg_336_1.time_ and arg_336_1.time_ <= var_339_28 + arg_339_0 then
				arg_336_1.var_.moveOldPos10049ui_story = var_339_27.localPosition

				local var_339_29 = GameObjectTools.GetOrAddComponent(var_339_27.gameObject, typeof(DynamicBoneHelper))

				if var_339_29 then
					var_339_29:EnableDynamicBone(false)
				end
			end

			local var_339_30 = 0.001

			if var_339_28 <= arg_336_1.time_ and arg_336_1.time_ < var_339_28 + var_339_30 then
				local var_339_31 = (arg_336_1.time_ - var_339_28) / var_339_30
				local var_339_32 = Vector3.New(0, 100, 0)

				var_339_27.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos10049ui_story, var_339_32, var_339_31)

				local var_339_33 = manager.ui.mainCamera.transform.position - var_339_27.position

				var_339_27.forward = Vector3.New(var_339_33.x, var_339_33.y, var_339_33.z)

				local var_339_34 = var_339_27.localEulerAngles

				var_339_34.z = 0
				var_339_34.x = 0
				var_339_27.localEulerAngles = var_339_34
			end

			if arg_336_1.time_ >= var_339_28 + var_339_30 and arg_336_1.time_ < var_339_28 + var_339_30 + arg_339_0 then
				var_339_27.localPosition = Vector3.New(0, 100, 0)

				local var_339_35 = manager.ui.mainCamera.transform.position - var_339_27.position

				var_339_27.forward = Vector3.New(var_339_35.x, var_339_35.y, var_339_35.z)

				local var_339_36 = var_339_27.localEulerAngles

				var_339_36.z = 0
				var_339_36.x = 0
				var_339_27.localEulerAngles = var_339_36

				local var_339_37 = GameObjectTools.GetOrAddComponent(var_339_27.gameObject, typeof(DynamicBoneHelper))

				if var_339_37 then
					var_339_37:EnableDynamicBone(true)
				end
			end

			local var_339_38 = arg_336_1.actors_["10104ui_story"].transform
			local var_339_39 = 3.8

			if var_339_39 < arg_336_1.time_ and arg_336_1.time_ <= var_339_39 + arg_339_0 then
				arg_336_1.var_.moveOldPos10104ui_story = var_339_38.localPosition
			end

			local var_339_40 = 0.001

			if var_339_39 <= arg_336_1.time_ and arg_336_1.time_ < var_339_39 + var_339_40 then
				local var_339_41 = (arg_336_1.time_ - var_339_39) / var_339_40
				local var_339_42 = Vector3.New(0.02, -1.12, -5.99)

				var_339_38.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos10104ui_story, var_339_42, var_339_41)

				local var_339_43 = manager.ui.mainCamera.transform.position - var_339_38.position

				var_339_38.forward = Vector3.New(var_339_43.x, var_339_43.y, var_339_43.z)

				local var_339_44 = var_339_38.localEulerAngles

				var_339_44.z = 0
				var_339_44.x = 0
				var_339_38.localEulerAngles = var_339_44
			end

			if arg_336_1.time_ >= var_339_39 + var_339_40 and arg_336_1.time_ < var_339_39 + var_339_40 + arg_339_0 then
				var_339_38.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_339_45 = manager.ui.mainCamera.transform.position - var_339_38.position

				var_339_38.forward = Vector3.New(var_339_45.x, var_339_45.y, var_339_45.z)

				local var_339_46 = var_339_38.localEulerAngles

				var_339_46.z = 0
				var_339_46.x = 0
				var_339_38.localEulerAngles = var_339_46
			end

			local var_339_47 = arg_336_1.actors_["10104ui_story"]
			local var_339_48 = 3.8

			if var_339_48 < arg_336_1.time_ and arg_336_1.time_ <= var_339_48 + arg_339_0 and not isNil(var_339_47) and arg_336_1.var_.characterEffect10104ui_story == nil then
				arg_336_1.var_.characterEffect10104ui_story = var_339_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_49 = 0.200000002980232

			if var_339_48 <= arg_336_1.time_ and arg_336_1.time_ < var_339_48 + var_339_49 and not isNil(var_339_47) then
				local var_339_50 = (arg_336_1.time_ - var_339_48) / var_339_49

				if arg_336_1.var_.characterEffect10104ui_story and not isNil(var_339_47) then
					arg_336_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= var_339_48 + var_339_49 and arg_336_1.time_ < var_339_48 + var_339_49 + arg_339_0 and not isNil(var_339_47) and arg_336_1.var_.characterEffect10104ui_story then
				arg_336_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_339_51 = 3.8

			if var_339_51 < arg_336_1.time_ and arg_336_1.time_ <= var_339_51 + arg_339_0 then
				arg_336_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_339_52 = 3.8

			if var_339_52 < arg_336_1.time_ and arg_336_1.time_ <= var_339_52 + arg_339_0 then
				arg_336_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_339_53 = 0.2
			local var_339_54 = 1

			if var_339_53 < arg_336_1.time_ and arg_336_1.time_ <= var_339_53 + arg_339_0 then
				local var_339_55 = "stop"
				local var_339_56 = "effect"

				arg_336_1:AudioAction(var_339_55, var_339_56, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_339_57 = 0.2
			local var_339_58 = 1

			if var_339_57 < arg_336_1.time_ and arg_336_1.time_ <= var_339_57 + arg_339_0 then
				local var_339_59 = "stop"
				local var_339_60 = "effect"

				arg_336_1:AudioAction(var_339_59, var_339_60, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_339_61 = 1.5
			local var_339_62 = 1

			if var_339_61 < arg_336_1.time_ and arg_336_1.time_ <= var_339_61 + arg_339_0 then
				local var_339_63 = "play"
				local var_339_64 = "effect"

				arg_336_1:AudioAction(var_339_63, var_339_64, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_339_65 = 0
			local var_339_66 = 0.3

			if var_339_65 < arg_336_1.time_ and arg_336_1.time_ <= var_339_65 + arg_339_0 then
				local var_339_67 = "play"
				local var_339_68 = "music"

				arg_336_1:AudioAction(var_339_67, var_339_68, "ui_battle", "ui_battle_stopbgm", "")

				local var_339_69 = ""
				local var_339_70 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_339_70 ~= "" then
					if arg_336_1.bgmTxt_.text ~= var_339_70 and arg_336_1.bgmTxt_.text ~= "" then
						if arg_336_1.bgmTxt2_.text ~= "" then
							arg_336_1.bgmTxt_.text = arg_336_1.bgmTxt2_.text
						end

						arg_336_1.bgmTxt2_.text = var_339_70

						arg_336_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_336_1.bgmTxt_.text = var_339_70
						arg_336_1.bgmTxt2_.text = var_339_70
					end

					if arg_336_1.bgmTimer then
						arg_336_1.bgmTimer:Stop()

						arg_336_1.bgmTimer = nil
					end

					if arg_336_1.settingData.show_music_name == 1 then
						arg_336_1.musicController:SetSelectedState("show")
						arg_336_1.musicAnimator_:Play("open", 0, 0)

						if arg_336_1.settingData.music_time ~= 0 then
							arg_336_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_336_1.settingData.music_time), function()
								if arg_336_1 == nil or isNil(arg_336_1.bgmTxt_) then
									return
								end

								arg_336_1.musicController:SetSelectedState("hide")
								arg_336_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_339_71 = 0.5
			local var_339_72 = 1

			if var_339_71 < arg_336_1.time_ and arg_336_1.time_ <= var_339_71 + arg_339_0 then
				local var_339_73 = "play"
				local var_339_74 = "music"

				arg_336_1:AudioAction(var_339_73, var_339_74, "bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference.awb")

				local var_339_75 = ""
				local var_339_76 = manager.audio:GetAudioName("bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference")

				if var_339_76 ~= "" then
					if arg_336_1.bgmTxt_.text ~= var_339_76 and arg_336_1.bgmTxt_.text ~= "" then
						if arg_336_1.bgmTxt2_.text ~= "" then
							arg_336_1.bgmTxt_.text = arg_336_1.bgmTxt2_.text
						end

						arg_336_1.bgmTxt2_.text = var_339_76

						arg_336_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_336_1.bgmTxt_.text = var_339_76
						arg_336_1.bgmTxt2_.text = var_339_76
					end

					if arg_336_1.bgmTimer then
						arg_336_1.bgmTimer:Stop()

						arg_336_1.bgmTimer = nil
					end

					if arg_336_1.settingData.show_music_name == 1 then
						arg_336_1.musicController:SetSelectedState("show")
						arg_336_1.musicAnimator_:Play("open", 0, 0)

						if arg_336_1.settingData.music_time ~= 0 then
							arg_336_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_336_1.settingData.music_time), function()
								if arg_336_1 == nil or isNil(arg_336_1.bgmTxt_) then
									return
								end

								arg_336_1.musicController:SetSelectedState("hide")
								arg_336_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_336_1.frameCnt_ <= 1 then
				arg_336_1.dialog_:SetActive(false)
			end

			local var_339_77 = 4.00000000298023
			local var_339_78 = 0.95

			if var_339_77 < arg_336_1.time_ and arg_336_1.time_ <= var_339_77 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0

				arg_336_1.dialog_:SetActive(true)

				arg_336_1.dialogCg_.alpha = 0

				local var_339_79 = LeanTween.value(arg_336_1.dialog_, 0, 1, 0.3)

				var_339_79:setOnUpdate(LuaHelper.FloatAction(function(arg_342_0)
					arg_336_1.dialogCg_.alpha = arg_342_0
				end))
				var_339_79:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_336_1.dialog_)
					var_339_79:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_336_1.duration_ = arg_336_1.duration_ + 0.3

				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_80 = arg_336_1:FormatText(StoryNameCfg[1030].name)

				arg_336_1.leftNameTxt_.text = var_339_80

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_81 = arg_336_1:GetWordFromCfg(322112082)
				local var_339_82 = arg_336_1:FormatText(var_339_81.content)

				arg_336_1.text_.text = var_339_82

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_83 = 38
				local var_339_84 = utf8.len(var_339_82)
				local var_339_85 = var_339_83 <= 0 and var_339_78 or var_339_78 * (var_339_84 / var_339_83)

				if var_339_85 > 0 and var_339_78 < var_339_85 then
					arg_336_1.talkMaxDuration = var_339_85
					var_339_77 = var_339_77 + 0.3

					if var_339_85 + var_339_77 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_85 + var_339_77
					end
				end

				arg_336_1.text_.text = var_339_82
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112082", "story_v_out_322112.awb") ~= 0 then
					local var_339_86 = manager.audio:GetVoiceLength("story_v_out_322112", "322112082", "story_v_out_322112.awb") / 1000

					if var_339_86 + var_339_77 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_86 + var_339_77
					end

					if var_339_81.prefab_name ~= "" and arg_336_1.actors_[var_339_81.prefab_name] ~= nil then
						local var_339_87 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_81.prefab_name].transform, "story_v_out_322112", "322112082", "story_v_out_322112.awb")

						arg_336_1:RecordAudio("322112082", var_339_87)
						arg_336_1:RecordAudio("322112082", var_339_87)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_322112", "322112082", "story_v_out_322112.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_322112", "322112082", "story_v_out_322112.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_88 = var_339_77 + 0.3
			local var_339_89 = math.max(var_339_78, arg_336_1.talkMaxDuration)

			if var_339_88 <= arg_336_1.time_ and arg_336_1.time_ < var_339_88 + var_339_89 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_88) / var_339_89

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_88 + var_339_89 and arg_336_1.time_ < var_339_88 + var_339_89 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play322112083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 322112083
		arg_344_1.duration_ = 5.13

		local var_344_0 = {
			zh = 3.533,
			ja = 5.133
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play322112084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["10104ui_story"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect10104ui_story == nil then
				arg_344_1.var_.characterEffect10104ui_story = var_347_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.200000002980232

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.characterEffect10104ui_story and not isNil(var_347_0) then
					local var_347_4 = Mathf.Lerp(0, 0.5, var_347_3)

					arg_344_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_344_1.var_.characterEffect10104ui_story.fillRatio = var_347_4
				end
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect10104ui_story then
				local var_347_5 = 0.5

				arg_344_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_344_1.var_.characterEffect10104ui_story.fillRatio = var_347_5
			end

			local var_347_6 = 0
			local var_347_7 = 0.5

			if var_347_6 < arg_344_1.time_ and arg_344_1.time_ <= var_347_6 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_8 = arg_344_1:FormatText(StoryNameCfg[487].name)

				arg_344_1.leftNameTxt_.text = var_347_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_344_1.callingController_:SetSelectedState("calling")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_9 = arg_344_1:GetWordFromCfg(322112083)
				local var_347_10 = arg_344_1:FormatText(var_347_9.content)

				arg_344_1.text_.text = var_347_10

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_11 = 20
				local var_347_12 = utf8.len(var_347_10)
				local var_347_13 = var_347_11 <= 0 and var_347_7 or var_347_7 * (var_347_12 / var_347_11)

				if var_347_13 > 0 and var_347_7 < var_347_13 then
					arg_344_1.talkMaxDuration = var_347_13

					if var_347_13 + var_347_6 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_13 + var_347_6
					end
				end

				arg_344_1.text_.text = var_347_10
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112083", "story_v_out_322112.awb") ~= 0 then
					local var_347_14 = manager.audio:GetVoiceLength("story_v_out_322112", "322112083", "story_v_out_322112.awb") / 1000

					if var_347_14 + var_347_6 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_14 + var_347_6
					end

					if var_347_9.prefab_name ~= "" and arg_344_1.actors_[var_347_9.prefab_name] ~= nil then
						local var_347_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_9.prefab_name].transform, "story_v_out_322112", "322112083", "story_v_out_322112.awb")

						arg_344_1:RecordAudio("322112083", var_347_15)
						arg_344_1:RecordAudio("322112083", var_347_15)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_322112", "322112083", "story_v_out_322112.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_322112", "322112083", "story_v_out_322112.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_16 = math.max(var_347_7, arg_344_1.talkMaxDuration)

			if var_347_6 <= arg_344_1.time_ and arg_344_1.time_ < var_347_6 + var_347_16 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_6) / var_347_16

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_6 + var_347_16 and arg_344_1.time_ < var_347_6 + var_347_16 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play322112084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 322112084
		arg_348_1.duration_ = 8.9

		local var_348_0 = {
			zh = 8,
			ja = 8.9
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play322112085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 1.175

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_2 = arg_348_1:FormatText(StoryNameCfg[487].name)

				arg_348_1.leftNameTxt_.text = var_351_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_348_1.callingController_:SetSelectedState("calling")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_3 = arg_348_1:GetWordFromCfg(322112084)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 47
				local var_351_6 = utf8.len(var_351_4)
				local var_351_7 = var_351_5 <= 0 and var_351_1 or var_351_1 * (var_351_6 / var_351_5)

				if var_351_7 > 0 and var_351_1 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112084", "story_v_out_322112.awb") ~= 0 then
					local var_351_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112084", "story_v_out_322112.awb") / 1000

					if var_351_8 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_8 + var_351_0
					end

					if var_351_3.prefab_name ~= "" and arg_348_1.actors_[var_351_3.prefab_name] ~= nil then
						local var_351_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_3.prefab_name].transform, "story_v_out_322112", "322112084", "story_v_out_322112.awb")

						arg_348_1:RecordAudio("322112084", var_351_9)
						arg_348_1:RecordAudio("322112084", var_351_9)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_322112", "322112084", "story_v_out_322112.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_322112", "322112084", "story_v_out_322112.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_10 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_10 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_10

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_10 and arg_348_1.time_ < var_351_0 + var_351_10 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play322112085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 322112085
		arg_352_1.duration_ = 10.5

		local var_352_0 = {
			zh = 8.566,
			ja = 10.5
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play322112086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0
			local var_355_1 = 0.925

			if var_355_0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_2 = arg_352_1:FormatText(StoryNameCfg[487].name)

				arg_352_1.leftNameTxt_.text = var_355_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_352_1.callingController_:SetSelectedState("calling")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_3 = arg_352_1:GetWordFromCfg(322112085)
				local var_355_4 = arg_352_1:FormatText(var_355_3.content)

				arg_352_1.text_.text = var_355_4

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 37
				local var_355_6 = utf8.len(var_355_4)
				local var_355_7 = var_355_5 <= 0 and var_355_1 or var_355_1 * (var_355_6 / var_355_5)

				if var_355_7 > 0 and var_355_1 < var_355_7 then
					arg_352_1.talkMaxDuration = var_355_7

					if var_355_7 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_0
					end
				end

				arg_352_1.text_.text = var_355_4
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112085", "story_v_out_322112.awb") ~= 0 then
					local var_355_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112085", "story_v_out_322112.awb") / 1000

					if var_355_8 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_8 + var_355_0
					end

					if var_355_3.prefab_name ~= "" and arg_352_1.actors_[var_355_3.prefab_name] ~= nil then
						local var_355_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_3.prefab_name].transform, "story_v_out_322112", "322112085", "story_v_out_322112.awb")

						arg_352_1:RecordAudio("322112085", var_355_9)
						arg_352_1:RecordAudio("322112085", var_355_9)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_322112", "322112085", "story_v_out_322112.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_322112", "322112085", "story_v_out_322112.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_10 = math.max(var_355_1, arg_352_1.talkMaxDuration)

			if var_355_0 <= arg_352_1.time_ and arg_352_1.time_ < var_355_0 + var_355_10 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_0) / var_355_10

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_0 + var_355_10 and arg_352_1.time_ < var_355_0 + var_355_10 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play322112086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 322112086
		arg_356_1.duration_ = 2

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play322112087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["10104ui_story"].transform
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.var_.moveOldPos10104ui_story = var_359_0.localPosition
			end

			local var_359_2 = 0.001

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2
				local var_359_4 = Vector3.New(0.02, -1.12, -5.99)

				var_359_0.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos10104ui_story, var_359_4, var_359_3)

				local var_359_5 = manager.ui.mainCamera.transform.position - var_359_0.position

				var_359_0.forward = Vector3.New(var_359_5.x, var_359_5.y, var_359_5.z)

				local var_359_6 = var_359_0.localEulerAngles

				var_359_6.z = 0
				var_359_6.x = 0
				var_359_0.localEulerAngles = var_359_6
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 then
				var_359_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_359_7 = manager.ui.mainCamera.transform.position - var_359_0.position

				var_359_0.forward = Vector3.New(var_359_7.x, var_359_7.y, var_359_7.z)

				local var_359_8 = var_359_0.localEulerAngles

				var_359_8.z = 0
				var_359_8.x = 0
				var_359_0.localEulerAngles = var_359_8
			end

			local var_359_9 = arg_356_1.actors_["10104ui_story"]
			local var_359_10 = 0

			if var_359_10 < arg_356_1.time_ and arg_356_1.time_ <= var_359_10 + arg_359_0 and not isNil(var_359_9) and arg_356_1.var_.characterEffect10104ui_story == nil then
				arg_356_1.var_.characterEffect10104ui_story = var_359_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_11 = 0.200000002980232

			if var_359_10 <= arg_356_1.time_ and arg_356_1.time_ < var_359_10 + var_359_11 and not isNil(var_359_9) then
				local var_359_12 = (arg_356_1.time_ - var_359_10) / var_359_11

				if arg_356_1.var_.characterEffect10104ui_story and not isNil(var_359_9) then
					arg_356_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= var_359_10 + var_359_11 and arg_356_1.time_ < var_359_10 + var_359_11 + arg_359_0 and not isNil(var_359_9) and arg_356_1.var_.characterEffect10104ui_story then
				arg_356_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_359_13 = 0

			if var_359_13 < arg_356_1.time_ and arg_356_1.time_ <= var_359_13 + arg_359_0 then
				arg_356_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_359_14 = 0

			if var_359_14 < arg_356_1.time_ and arg_356_1.time_ <= var_359_14 + arg_359_0 then
				arg_356_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_359_15 = 0
			local var_359_16 = 0.1

			if var_359_15 < arg_356_1.time_ and arg_356_1.time_ <= var_359_15 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_17 = arg_356_1:FormatText(StoryNameCfg[1030].name)

				arg_356_1.leftNameTxt_.text = var_359_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_18 = arg_356_1:GetWordFromCfg(322112086)
				local var_359_19 = arg_356_1:FormatText(var_359_18.content)

				arg_356_1.text_.text = var_359_19

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_20 = 4
				local var_359_21 = utf8.len(var_359_19)
				local var_359_22 = var_359_20 <= 0 and var_359_16 or var_359_16 * (var_359_21 / var_359_20)

				if var_359_22 > 0 and var_359_16 < var_359_22 then
					arg_356_1.talkMaxDuration = var_359_22

					if var_359_22 + var_359_15 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_22 + var_359_15
					end
				end

				arg_356_1.text_.text = var_359_19
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112086", "story_v_out_322112.awb") ~= 0 then
					local var_359_23 = manager.audio:GetVoiceLength("story_v_out_322112", "322112086", "story_v_out_322112.awb") / 1000

					if var_359_23 + var_359_15 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_23 + var_359_15
					end

					if var_359_18.prefab_name ~= "" and arg_356_1.actors_[var_359_18.prefab_name] ~= nil then
						local var_359_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_18.prefab_name].transform, "story_v_out_322112", "322112086", "story_v_out_322112.awb")

						arg_356_1:RecordAudio("322112086", var_359_24)
						arg_356_1:RecordAudio("322112086", var_359_24)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_322112", "322112086", "story_v_out_322112.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_322112", "322112086", "story_v_out_322112.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_25 = math.max(var_359_16, arg_356_1.talkMaxDuration)

			if var_359_15 <= arg_356_1.time_ and arg_356_1.time_ < var_359_15 + var_359_25 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_15) / var_359_25

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_15 + var_359_25 and arg_356_1.time_ < var_359_15 + var_359_25 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play322112087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 322112087
		arg_360_1.duration_ = 2.17

		local var_360_0 = {
			zh = 2.166,
			ja = 1.9
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play322112088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["10104ui_story"]
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect10104ui_story == nil then
				arg_360_1.var_.characterEffect10104ui_story = var_363_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 and not isNil(var_363_0) then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2

				if arg_360_1.var_.characterEffect10104ui_story and not isNil(var_363_0) then
					local var_363_4 = Mathf.Lerp(0, 0.5, var_363_3)

					arg_360_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_360_1.var_.characterEffect10104ui_story.fillRatio = var_363_4
				end
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect10104ui_story then
				local var_363_5 = 0.5

				arg_360_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_360_1.var_.characterEffect10104ui_story.fillRatio = var_363_5
			end

			local var_363_6 = 0
			local var_363_7 = 0.25

			if var_363_6 < arg_360_1.time_ and arg_360_1.time_ <= var_363_6 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_8 = arg_360_1:FormatText(StoryNameCfg[487].name)

				arg_360_1.leftNameTxt_.text = var_363_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_360_1.callingController_:SetSelectedState("calling")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_9 = arg_360_1:GetWordFromCfg(322112087)
				local var_363_10 = arg_360_1:FormatText(var_363_9.content)

				arg_360_1.text_.text = var_363_10

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_11 = 10
				local var_363_12 = utf8.len(var_363_10)
				local var_363_13 = var_363_11 <= 0 and var_363_7 or var_363_7 * (var_363_12 / var_363_11)

				if var_363_13 > 0 and var_363_7 < var_363_13 then
					arg_360_1.talkMaxDuration = var_363_13

					if var_363_13 + var_363_6 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_13 + var_363_6
					end
				end

				arg_360_1.text_.text = var_363_10
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112087", "story_v_out_322112.awb") ~= 0 then
					local var_363_14 = manager.audio:GetVoiceLength("story_v_out_322112", "322112087", "story_v_out_322112.awb") / 1000

					if var_363_14 + var_363_6 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_14 + var_363_6
					end

					if var_363_9.prefab_name ~= "" and arg_360_1.actors_[var_363_9.prefab_name] ~= nil then
						local var_363_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_9.prefab_name].transform, "story_v_out_322112", "322112087", "story_v_out_322112.awb")

						arg_360_1:RecordAudio("322112087", var_363_15)
						arg_360_1:RecordAudio("322112087", var_363_15)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_322112", "322112087", "story_v_out_322112.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_322112", "322112087", "story_v_out_322112.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_16 = math.max(var_363_7, arg_360_1.talkMaxDuration)

			if var_363_6 <= arg_360_1.time_ and arg_360_1.time_ < var_363_6 + var_363_16 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_6) / var_363_16

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_6 + var_363_16 and arg_360_1.time_ < var_363_6 + var_363_16 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play322112088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 322112088
		arg_364_1.duration_ = 4.87

		local var_364_0 = {
			zh = 4.566,
			ja = 4.866
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play322112089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 0.6

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_2 = arg_364_1:FormatText(StoryNameCfg[487].name)

				arg_364_1.leftNameTxt_.text = var_367_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_364_1.callingController_:SetSelectedState("calling")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_3 = arg_364_1:GetWordFromCfg(322112088)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 24
				local var_367_6 = utf8.len(var_367_4)
				local var_367_7 = var_367_5 <= 0 and var_367_1 or var_367_1 * (var_367_6 / var_367_5)

				if var_367_7 > 0 and var_367_1 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112088", "story_v_out_322112.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112088", "story_v_out_322112.awb") / 1000

					if var_367_8 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_0
					end

					if var_367_3.prefab_name ~= "" and arg_364_1.actors_[var_367_3.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_3.prefab_name].transform, "story_v_out_322112", "322112088", "story_v_out_322112.awb")

						arg_364_1:RecordAudio("322112088", var_367_9)
						arg_364_1:RecordAudio("322112088", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_322112", "322112088", "story_v_out_322112.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_322112", "322112088", "story_v_out_322112.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_10 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_10 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_10

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_10 and arg_364_1.time_ < var_367_0 + var_367_10 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play322112089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 322112089
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play322112090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["10104ui_story"].transform
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 then
				arg_368_1.var_.moveOldPos10104ui_story = var_371_0.localPosition
			end

			local var_371_2 = 0.001

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2
				local var_371_4 = Vector3.New(0, 100, 0)

				var_371_0.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos10104ui_story, var_371_4, var_371_3)

				local var_371_5 = manager.ui.mainCamera.transform.position - var_371_0.position

				var_371_0.forward = Vector3.New(var_371_5.x, var_371_5.y, var_371_5.z)

				local var_371_6 = var_371_0.localEulerAngles

				var_371_6.z = 0
				var_371_6.x = 0
				var_371_0.localEulerAngles = var_371_6
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 then
				var_371_0.localPosition = Vector3.New(0, 100, 0)

				local var_371_7 = manager.ui.mainCamera.transform.position - var_371_0.position

				var_371_0.forward = Vector3.New(var_371_7.x, var_371_7.y, var_371_7.z)

				local var_371_8 = var_371_0.localEulerAngles

				var_371_8.z = 0
				var_371_8.x = 0
				var_371_0.localEulerAngles = var_371_8
			end

			local var_371_9 = 0
			local var_371_10 = 1.325

			if var_371_9 < arg_368_1.time_ and arg_368_1.time_ <= var_371_9 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_11 = arg_368_1:GetWordFromCfg(322112089)
				local var_371_12 = arg_368_1:FormatText(var_371_11.content)

				arg_368_1.text_.text = var_371_12

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_13 = 53
				local var_371_14 = utf8.len(var_371_12)
				local var_371_15 = var_371_13 <= 0 and var_371_10 or var_371_10 * (var_371_14 / var_371_13)

				if var_371_15 > 0 and var_371_10 < var_371_15 then
					arg_368_1.talkMaxDuration = var_371_15

					if var_371_15 + var_371_9 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_15 + var_371_9
					end
				end

				arg_368_1.text_.text = var_371_12
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_16 = math.max(var_371_10, arg_368_1.talkMaxDuration)

			if var_371_9 <= arg_368_1.time_ and arg_368_1.time_ < var_371_9 + var_371_16 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_9) / var_371_16

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_9 + var_371_16 and arg_368_1.time_ < var_371_9 + var_371_16 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play322112090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 322112090
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play322112091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0
			local var_375_1 = 1.9

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_2 = arg_372_1:GetWordFromCfg(322112090)
				local var_375_3 = arg_372_1:FormatText(var_375_2.content)

				arg_372_1.text_.text = var_375_3

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_4 = 76
				local var_375_5 = utf8.len(var_375_3)
				local var_375_6 = var_375_4 <= 0 and var_375_1 or var_375_1 * (var_375_5 / var_375_4)

				if var_375_6 > 0 and var_375_1 < var_375_6 then
					arg_372_1.talkMaxDuration = var_375_6

					if var_375_6 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_6 + var_375_0
					end
				end

				arg_372_1.text_.text = var_375_3
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_7 = math.max(var_375_1, arg_372_1.talkMaxDuration)

			if var_375_0 <= arg_372_1.time_ and arg_372_1.time_ < var_375_0 + var_375_7 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_0) / var_375_7

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_0 + var_375_7 and arg_372_1.time_ < var_375_0 + var_375_7 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play322112091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 322112091
		arg_376_1.duration_ = 6.03

		local var_376_0 = {
			zh = 6.033,
			ja = 4.933
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play322112092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["10104ui_story"].transform
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.var_.moveOldPos10104ui_story = var_379_0.localPosition
			end

			local var_379_2 = 0.001

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2
				local var_379_4 = Vector3.New(0.02, -1.12, -5.99)

				var_379_0.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos10104ui_story, var_379_4, var_379_3)

				local var_379_5 = manager.ui.mainCamera.transform.position - var_379_0.position

				var_379_0.forward = Vector3.New(var_379_5.x, var_379_5.y, var_379_5.z)

				local var_379_6 = var_379_0.localEulerAngles

				var_379_6.z = 0
				var_379_6.x = 0
				var_379_0.localEulerAngles = var_379_6
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 then
				var_379_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_379_7 = manager.ui.mainCamera.transform.position - var_379_0.position

				var_379_0.forward = Vector3.New(var_379_7.x, var_379_7.y, var_379_7.z)

				local var_379_8 = var_379_0.localEulerAngles

				var_379_8.z = 0
				var_379_8.x = 0
				var_379_0.localEulerAngles = var_379_8
			end

			local var_379_9 = arg_376_1.actors_["10104ui_story"]
			local var_379_10 = 0

			if var_379_10 < arg_376_1.time_ and arg_376_1.time_ <= var_379_10 + arg_379_0 and not isNil(var_379_9) and arg_376_1.var_.characterEffect10104ui_story == nil then
				arg_376_1.var_.characterEffect10104ui_story = var_379_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_11 = 0.200000002980232

			if var_379_10 <= arg_376_1.time_ and arg_376_1.time_ < var_379_10 + var_379_11 and not isNil(var_379_9) then
				local var_379_12 = (arg_376_1.time_ - var_379_10) / var_379_11

				if arg_376_1.var_.characterEffect10104ui_story and not isNil(var_379_9) then
					arg_376_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= var_379_10 + var_379_11 and arg_376_1.time_ < var_379_10 + var_379_11 + arg_379_0 and not isNil(var_379_9) and arg_376_1.var_.characterEffect10104ui_story then
				arg_376_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_379_13 = 0

			if var_379_13 < arg_376_1.time_ and arg_376_1.time_ <= var_379_13 + arg_379_0 then
				arg_376_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action4_1")
			end

			local var_379_14 = 0

			if var_379_14 < arg_376_1.time_ and arg_376_1.time_ <= var_379_14 + arg_379_0 then
				arg_376_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_379_15 = 0
			local var_379_16 = 0.575

			if var_379_15 < arg_376_1.time_ and arg_376_1.time_ <= var_379_15 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_17 = arg_376_1:FormatText(StoryNameCfg[1030].name)

				arg_376_1.leftNameTxt_.text = var_379_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_18 = arg_376_1:GetWordFromCfg(322112091)
				local var_379_19 = arg_376_1:FormatText(var_379_18.content)

				arg_376_1.text_.text = var_379_19

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_20 = 23
				local var_379_21 = utf8.len(var_379_19)
				local var_379_22 = var_379_20 <= 0 and var_379_16 or var_379_16 * (var_379_21 / var_379_20)

				if var_379_22 > 0 and var_379_16 < var_379_22 then
					arg_376_1.talkMaxDuration = var_379_22

					if var_379_22 + var_379_15 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_22 + var_379_15
					end
				end

				arg_376_1.text_.text = var_379_19
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112091", "story_v_out_322112.awb") ~= 0 then
					local var_379_23 = manager.audio:GetVoiceLength("story_v_out_322112", "322112091", "story_v_out_322112.awb") / 1000

					if var_379_23 + var_379_15 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_23 + var_379_15
					end

					if var_379_18.prefab_name ~= "" and arg_376_1.actors_[var_379_18.prefab_name] ~= nil then
						local var_379_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_18.prefab_name].transform, "story_v_out_322112", "322112091", "story_v_out_322112.awb")

						arg_376_1:RecordAudio("322112091", var_379_24)
						arg_376_1:RecordAudio("322112091", var_379_24)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_322112", "322112091", "story_v_out_322112.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_322112", "322112091", "story_v_out_322112.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_25 = math.max(var_379_16, arg_376_1.talkMaxDuration)

			if var_379_15 <= arg_376_1.time_ and arg_376_1.time_ < var_379_15 + var_379_25 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_15) / var_379_25

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_15 + var_379_25 and arg_376_1.time_ < var_379_15 + var_379_25 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play322112092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 322112092
		arg_380_1.duration_ = 2.07

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play322112093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["10104ui_story"]
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect10104ui_story == nil then
				arg_380_1.var_.characterEffect10104ui_story = var_383_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_2 = 0.200000002980232

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 and not isNil(var_383_0) then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2

				if arg_380_1.var_.characterEffect10104ui_story and not isNil(var_383_0) then
					local var_383_4 = Mathf.Lerp(0, 0.5, var_383_3)

					arg_380_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_380_1.var_.characterEffect10104ui_story.fillRatio = var_383_4
				end
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect10104ui_story then
				local var_383_5 = 0.5

				arg_380_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_380_1.var_.characterEffect10104ui_story.fillRatio = var_383_5
			end

			local var_383_6 = 0
			local var_383_7 = 0.225

			if var_383_6 < arg_380_1.time_ and arg_380_1.time_ <= var_383_6 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_8 = arg_380_1:FormatText(StoryNameCfg[487].name)

				arg_380_1.leftNameTxt_.text = var_383_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_380_1.callingController_:SetSelectedState("calling")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_9 = arg_380_1:GetWordFromCfg(322112092)
				local var_383_10 = arg_380_1:FormatText(var_383_9.content)

				arg_380_1.text_.text = var_383_10

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_11 = 9
				local var_383_12 = utf8.len(var_383_10)
				local var_383_13 = var_383_11 <= 0 and var_383_7 or var_383_7 * (var_383_12 / var_383_11)

				if var_383_13 > 0 and var_383_7 < var_383_13 then
					arg_380_1.talkMaxDuration = var_383_13

					if var_383_13 + var_383_6 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_13 + var_383_6
					end
				end

				arg_380_1.text_.text = var_383_10
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112092", "story_v_out_322112.awb") ~= 0 then
					local var_383_14 = manager.audio:GetVoiceLength("story_v_out_322112", "322112092", "story_v_out_322112.awb") / 1000

					if var_383_14 + var_383_6 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_14 + var_383_6
					end

					if var_383_9.prefab_name ~= "" and arg_380_1.actors_[var_383_9.prefab_name] ~= nil then
						local var_383_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_9.prefab_name].transform, "story_v_out_322112", "322112092", "story_v_out_322112.awb")

						arg_380_1:RecordAudio("322112092", var_383_15)
						arg_380_1:RecordAudio("322112092", var_383_15)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_322112", "322112092", "story_v_out_322112.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_322112", "322112092", "story_v_out_322112.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_16 = math.max(var_383_7, arg_380_1.talkMaxDuration)

			if var_383_6 <= arg_380_1.time_ and arg_380_1.time_ < var_383_6 + var_383_16 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_6) / var_383_16

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_6 + var_383_16 and arg_380_1.time_ < var_383_6 + var_383_16 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play322112093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 322112093
		arg_384_1.duration_ = 2.33

		local var_384_0 = {
			zh = 1.533,
			ja = 2.333
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play322112094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0
			local var_387_1 = 0.15

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_2 = arg_384_1:FormatText(StoryNameCfg[1365].name)

				arg_384_1.leftNameTxt_.text = var_387_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_3 = arg_384_1:GetWordFromCfg(322112093)
				local var_387_4 = arg_384_1:FormatText(var_387_3.content)

				arg_384_1.text_.text = var_387_4

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 6
				local var_387_6 = utf8.len(var_387_4)
				local var_387_7 = var_387_5 <= 0 and var_387_1 or var_387_1 * (var_387_6 / var_387_5)

				if var_387_7 > 0 and var_387_1 < var_387_7 then
					arg_384_1.talkMaxDuration = var_387_7

					if var_387_7 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_0
					end
				end

				arg_384_1.text_.text = var_387_4
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112093", "story_v_out_322112.awb") ~= 0 then
					local var_387_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112093", "story_v_out_322112.awb") / 1000

					if var_387_8 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_8 + var_387_0
					end

					if var_387_3.prefab_name ~= "" and arg_384_1.actors_[var_387_3.prefab_name] ~= nil then
						local var_387_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_3.prefab_name].transform, "story_v_out_322112", "322112093", "story_v_out_322112.awb")

						arg_384_1:RecordAudio("322112093", var_387_9)
						arg_384_1:RecordAudio("322112093", var_387_9)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_322112", "322112093", "story_v_out_322112.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_322112", "322112093", "story_v_out_322112.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_10 = math.max(var_387_1, arg_384_1.talkMaxDuration)

			if var_387_0 <= arg_384_1.time_ and arg_384_1.time_ < var_387_0 + var_387_10 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_0) / var_387_10

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_0 + var_387_10 and arg_384_1.time_ < var_387_0 + var_387_10 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play322112094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 322112094
		arg_388_1.duration_ = 4.03

		local var_388_0 = {
			zh = 2.4,
			ja = 4.033
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play322112095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["10104ui_story"].transform
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.var_.moveOldPos10104ui_story = var_391_0.localPosition
			end

			local var_391_2 = 0.001

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2
				local var_391_4 = Vector3.New(0.02, -1.12, -5.99)

				var_391_0.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos10104ui_story, var_391_4, var_391_3)

				local var_391_5 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_5.x, var_391_5.y, var_391_5.z)

				local var_391_6 = var_391_0.localEulerAngles

				var_391_6.z = 0
				var_391_6.x = 0
				var_391_0.localEulerAngles = var_391_6
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 then
				var_391_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_391_7 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_7.x, var_391_7.y, var_391_7.z)

				local var_391_8 = var_391_0.localEulerAngles

				var_391_8.z = 0
				var_391_8.x = 0
				var_391_0.localEulerAngles = var_391_8
			end

			local var_391_9 = arg_388_1.actors_["10104ui_story"]
			local var_391_10 = 0

			if var_391_10 < arg_388_1.time_ and arg_388_1.time_ <= var_391_10 + arg_391_0 and not isNil(var_391_9) and arg_388_1.var_.characterEffect10104ui_story == nil then
				arg_388_1.var_.characterEffect10104ui_story = var_391_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_11 = 0.200000002980232

			if var_391_10 <= arg_388_1.time_ and arg_388_1.time_ < var_391_10 + var_391_11 and not isNil(var_391_9) then
				local var_391_12 = (arg_388_1.time_ - var_391_10) / var_391_11

				if arg_388_1.var_.characterEffect10104ui_story and not isNil(var_391_9) then
					arg_388_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= var_391_10 + var_391_11 and arg_388_1.time_ < var_391_10 + var_391_11 + arg_391_0 and not isNil(var_391_9) and arg_388_1.var_.characterEffect10104ui_story then
				arg_388_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_391_13 = 0

			if var_391_13 < arg_388_1.time_ and arg_388_1.time_ <= var_391_13 + arg_391_0 then
				arg_388_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action4_2")
			end

			local var_391_14 = 0

			if var_391_14 < arg_388_1.time_ and arg_388_1.time_ <= var_391_14 + arg_391_0 then
				arg_388_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_391_15 = 0
			local var_391_16 = 0.25

			if var_391_15 < arg_388_1.time_ and arg_388_1.time_ <= var_391_15 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_17 = arg_388_1:FormatText(StoryNameCfg[1030].name)

				arg_388_1.leftNameTxt_.text = var_391_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_18 = arg_388_1:GetWordFromCfg(322112094)
				local var_391_19 = arg_388_1:FormatText(var_391_18.content)

				arg_388_1.text_.text = var_391_19

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_20 = 10
				local var_391_21 = utf8.len(var_391_19)
				local var_391_22 = var_391_20 <= 0 and var_391_16 or var_391_16 * (var_391_21 / var_391_20)

				if var_391_22 > 0 and var_391_16 < var_391_22 then
					arg_388_1.talkMaxDuration = var_391_22

					if var_391_22 + var_391_15 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_22 + var_391_15
					end
				end

				arg_388_1.text_.text = var_391_19
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112094", "story_v_out_322112.awb") ~= 0 then
					local var_391_23 = manager.audio:GetVoiceLength("story_v_out_322112", "322112094", "story_v_out_322112.awb") / 1000

					if var_391_23 + var_391_15 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_23 + var_391_15
					end

					if var_391_18.prefab_name ~= "" and arg_388_1.actors_[var_391_18.prefab_name] ~= nil then
						local var_391_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_18.prefab_name].transform, "story_v_out_322112", "322112094", "story_v_out_322112.awb")

						arg_388_1:RecordAudio("322112094", var_391_24)
						arg_388_1:RecordAudio("322112094", var_391_24)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_322112", "322112094", "story_v_out_322112.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_322112", "322112094", "story_v_out_322112.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_25 = math.max(var_391_16, arg_388_1.talkMaxDuration)

			if var_391_15 <= arg_388_1.time_ and arg_388_1.time_ < var_391_15 + var_391_25 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_15) / var_391_25

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_15 + var_391_25 and arg_388_1.time_ < var_391_15 + var_391_25 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play322112095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 322112095
		arg_392_1.duration_ = 1.77

		local var_392_0 = {
			zh = 1.266,
			ja = 1.766
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play322112096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["10104ui_story"]
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect10104ui_story == nil then
				arg_392_1.var_.characterEffect10104ui_story = var_395_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_2 = 0.200000002980232

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 and not isNil(var_395_0) then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2

				if arg_392_1.var_.characterEffect10104ui_story and not isNil(var_395_0) then
					local var_395_4 = Mathf.Lerp(0, 0.5, var_395_3)

					arg_392_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_392_1.var_.characterEffect10104ui_story.fillRatio = var_395_4
				end
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect10104ui_story then
				local var_395_5 = 0.5

				arg_392_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_392_1.var_.characterEffect10104ui_story.fillRatio = var_395_5
			end

			local var_395_6 = 0
			local var_395_7 = 0.1

			if var_395_6 < arg_392_1.time_ and arg_392_1.time_ <= var_395_6 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_8 = arg_392_1:FormatText(StoryNameCfg[1365].name)

				arg_392_1.leftNameTxt_.text = var_395_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_9 = arg_392_1:GetWordFromCfg(322112095)
				local var_395_10 = arg_392_1:FormatText(var_395_9.content)

				arg_392_1.text_.text = var_395_10

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_11 = 4
				local var_395_12 = utf8.len(var_395_10)
				local var_395_13 = var_395_11 <= 0 and var_395_7 or var_395_7 * (var_395_12 / var_395_11)

				if var_395_13 > 0 and var_395_7 < var_395_13 then
					arg_392_1.talkMaxDuration = var_395_13

					if var_395_13 + var_395_6 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_13 + var_395_6
					end
				end

				arg_392_1.text_.text = var_395_10
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112095", "story_v_out_322112.awb") ~= 0 then
					local var_395_14 = manager.audio:GetVoiceLength("story_v_out_322112", "322112095", "story_v_out_322112.awb") / 1000

					if var_395_14 + var_395_6 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_14 + var_395_6
					end

					if var_395_9.prefab_name ~= "" and arg_392_1.actors_[var_395_9.prefab_name] ~= nil then
						local var_395_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_9.prefab_name].transform, "story_v_out_322112", "322112095", "story_v_out_322112.awb")

						arg_392_1:RecordAudio("322112095", var_395_15)
						arg_392_1:RecordAudio("322112095", var_395_15)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_322112", "322112095", "story_v_out_322112.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_322112", "322112095", "story_v_out_322112.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_16 = math.max(var_395_7, arg_392_1.talkMaxDuration)

			if var_395_6 <= arg_392_1.time_ and arg_392_1.time_ < var_395_6 + var_395_16 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_6) / var_395_16

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_6 + var_395_16 and arg_392_1.time_ < var_395_6 + var_395_16 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play322112096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 322112096
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play322112097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["10104ui_story"].transform
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.var_.moveOldPos10104ui_story = var_399_0.localPosition
			end

			local var_399_2 = 0.001

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2
				local var_399_4 = Vector3.New(0, 100, 0)

				var_399_0.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos10104ui_story, var_399_4, var_399_3)

				local var_399_5 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_5.x, var_399_5.y, var_399_5.z)

				local var_399_6 = var_399_0.localEulerAngles

				var_399_6.z = 0
				var_399_6.x = 0
				var_399_0.localEulerAngles = var_399_6
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 then
				var_399_0.localPosition = Vector3.New(0, 100, 0)

				local var_399_7 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_7.x, var_399_7.y, var_399_7.z)

				local var_399_8 = var_399_0.localEulerAngles

				var_399_8.z = 0
				var_399_8.x = 0
				var_399_0.localEulerAngles = var_399_8
			end

			local var_399_9 = 0
			local var_399_10 = 0.3

			if var_399_9 < arg_396_1.time_ and arg_396_1.time_ <= var_399_9 + arg_399_0 then
				local var_399_11 = "play"
				local var_399_12 = "music"

				arg_396_1:AudioAction(var_399_11, var_399_12, "ui_battle", "ui_battle_stopbgm", "")

				local var_399_13 = ""
				local var_399_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_399_14 ~= "" then
					if arg_396_1.bgmTxt_.text ~= var_399_14 and arg_396_1.bgmTxt_.text ~= "" then
						if arg_396_1.bgmTxt2_.text ~= "" then
							arg_396_1.bgmTxt_.text = arg_396_1.bgmTxt2_.text
						end

						arg_396_1.bgmTxt2_.text = var_399_14

						arg_396_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_396_1.bgmTxt_.text = var_399_14
						arg_396_1.bgmTxt2_.text = var_399_14
					end

					if arg_396_1.bgmTimer then
						arg_396_1.bgmTimer:Stop()

						arg_396_1.bgmTimer = nil
					end

					if arg_396_1.settingData.show_music_name == 1 then
						arg_396_1.musicController:SetSelectedState("show")
						arg_396_1.musicAnimator_:Play("open", 0, 0)

						if arg_396_1.settingData.music_time ~= 0 then
							arg_396_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_396_1.settingData.music_time), function()
								if arg_396_1 == nil or isNil(arg_396_1.bgmTxt_) then
									return
								end

								arg_396_1.musicController:SetSelectedState("hide")
								arg_396_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_399_15 = 0
			local var_399_16 = 1.675

			if var_399_15 < arg_396_1.time_ and arg_396_1.time_ <= var_399_15 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, false)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_17 = arg_396_1:GetWordFromCfg(322112096)
				local var_399_18 = arg_396_1:FormatText(var_399_17.content)

				arg_396_1.text_.text = var_399_18

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_19 = 67
				local var_399_20 = utf8.len(var_399_18)
				local var_399_21 = var_399_19 <= 0 and var_399_16 or var_399_16 * (var_399_20 / var_399_19)

				if var_399_21 > 0 and var_399_16 < var_399_21 then
					arg_396_1.talkMaxDuration = var_399_21

					if var_399_21 + var_399_15 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_21 + var_399_15
					end
				end

				arg_396_1.text_.text = var_399_18
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_22 = math.max(var_399_16, arg_396_1.talkMaxDuration)

			if var_399_15 <= arg_396_1.time_ and arg_396_1.time_ < var_399_15 + var_399_22 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_15) / var_399_22

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_15 + var_399_22 and arg_396_1.time_ < var_399_15 + var_399_22 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play322112097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 322112097
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play322112098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 1.05

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_2 = arg_401_1:GetWordFromCfg(322112097)
				local var_404_3 = arg_401_1:FormatText(var_404_2.content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 42
				local var_404_5 = utf8.len(var_404_3)
				local var_404_6 = var_404_4 <= 0 and var_404_1 or var_404_1 * (var_404_5 / var_404_4)

				if var_404_6 > 0 and var_404_1 < var_404_6 then
					arg_401_1.talkMaxDuration = var_404_6

					if var_404_6 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_6 + var_404_0
					end
				end

				arg_401_1.text_.text = var_404_3
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_1, arg_401_1.talkMaxDuration)

			if var_404_0 <= arg_401_1.time_ and arg_401_1.time_ < var_404_0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_0 + var_404_7 and arg_401_1.time_ < var_404_0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play322112098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 322112098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play322112099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0
			local var_408_1 = 0.975

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_2 = arg_405_1:GetWordFromCfg(322112098)
				local var_408_3 = arg_405_1:FormatText(var_408_2.content)

				arg_405_1.text_.text = var_408_3

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_4 = 39
				local var_408_5 = utf8.len(var_408_3)
				local var_408_6 = var_408_4 <= 0 and var_408_1 or var_408_1 * (var_408_5 / var_408_4)

				if var_408_6 > 0 and var_408_1 < var_408_6 then
					arg_405_1.talkMaxDuration = var_408_6

					if var_408_6 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_6 + var_408_0
					end
				end

				arg_405_1.text_.text = var_408_3
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_7 = math.max(var_408_1, arg_405_1.talkMaxDuration)

			if var_408_0 <= arg_405_1.time_ and arg_405_1.time_ < var_408_0 + var_408_7 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_0) / var_408_7

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_0 + var_408_7 and arg_405_1.time_ < var_408_0 + var_408_7 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play322112099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 322112099
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play322112100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = manager.ui.mainCamera.transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				local var_412_2 = arg_409_1.var_.effect1022
				local var_412_3
				local var_412_4 = var_412_0

				if not var_412_2 then
					var_412_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dataflow"), var_412_4)
					var_412_2.name = "1022"
					arg_409_1.var_.effect1022 = var_412_2
				else
					var_412_2.transform:SetParent(var_412_4)
				end

				var_412_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_412_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_412_5 = 0.1
			local var_412_6 = 1

			if var_412_5 < arg_409_1.time_ and arg_409_1.time_ <= var_412_5 + arg_412_0 then
				local var_412_7 = "play"
				local var_412_8 = "effect"

				arg_409_1:AudioAction(var_412_7, var_412_8, "se_story_129", "se_story_129_information_magic", "")
			end

			local var_412_9 = 0
			local var_412_10 = 1.825

			if var_412_9 < arg_409_1.time_ and arg_409_1.time_ <= var_412_9 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_11 = arg_409_1:GetWordFromCfg(322112099)
				local var_412_12 = arg_409_1:FormatText(var_412_11.content)

				arg_409_1.text_.text = var_412_12

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_13 = 73
				local var_412_14 = utf8.len(var_412_12)
				local var_412_15 = var_412_13 <= 0 and var_412_10 or var_412_10 * (var_412_14 / var_412_13)

				if var_412_15 > 0 and var_412_10 < var_412_15 then
					arg_409_1.talkMaxDuration = var_412_15

					if var_412_15 + var_412_9 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_15 + var_412_9
					end
				end

				arg_409_1.text_.text = var_412_12
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_16 = math.max(var_412_10, arg_409_1.talkMaxDuration)

			if var_412_9 <= arg_409_1.time_ and arg_409_1.time_ < var_412_9 + var_412_16 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_9) / var_412_16

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_9 + var_412_16 and arg_409_1.time_ < var_412_9 + var_412_16 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play322112100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 322112100
		arg_413_1.duration_ = 4

		local var_413_0 = {
			zh = 4,
			ja = 2.9
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play322112101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["10104ui_story"].transform
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.var_.moveOldPos10104ui_story = var_416_0.localPosition
			end

			local var_416_2 = 0.001

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2
				local var_416_4 = Vector3.New(0.02, -1.12, -5.99)

				var_416_0.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos10104ui_story, var_416_4, var_416_3)

				local var_416_5 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_5.x, var_416_5.y, var_416_5.z)

				local var_416_6 = var_416_0.localEulerAngles

				var_416_6.z = 0
				var_416_6.x = 0
				var_416_0.localEulerAngles = var_416_6
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 then
				var_416_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_416_7 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_7.x, var_416_7.y, var_416_7.z)

				local var_416_8 = var_416_0.localEulerAngles

				var_416_8.z = 0
				var_416_8.x = 0
				var_416_0.localEulerAngles = var_416_8
			end

			local var_416_9 = arg_413_1.actors_["10104ui_story"]
			local var_416_10 = 0

			if var_416_10 < arg_413_1.time_ and arg_413_1.time_ <= var_416_10 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect10104ui_story == nil then
				arg_413_1.var_.characterEffect10104ui_story = var_416_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_11 = 0.200000002980232

			if var_416_10 <= arg_413_1.time_ and arg_413_1.time_ < var_416_10 + var_416_11 and not isNil(var_416_9) then
				local var_416_12 = (arg_413_1.time_ - var_416_10) / var_416_11

				if arg_413_1.var_.characterEffect10104ui_story and not isNil(var_416_9) then
					arg_413_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= var_416_10 + var_416_11 and arg_413_1.time_ < var_416_10 + var_416_11 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect10104ui_story then
				arg_413_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_416_13 = 0

			if var_416_13 < arg_413_1.time_ and arg_413_1.time_ <= var_416_13 + arg_416_0 then
				arg_413_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_416_14 = 0

			if var_416_14 < arg_413_1.time_ and arg_413_1.time_ <= var_416_14 + arg_416_0 then
				arg_413_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_416_15 = 0
			local var_416_16 = 0.425

			if var_416_15 < arg_413_1.time_ and arg_413_1.time_ <= var_416_15 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_17 = arg_413_1:FormatText(StoryNameCfg[1030].name)

				arg_413_1.leftNameTxt_.text = var_416_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_18 = arg_413_1:GetWordFromCfg(322112100)
				local var_416_19 = arg_413_1:FormatText(var_416_18.content)

				arg_413_1.text_.text = var_416_19

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_20 = 17
				local var_416_21 = utf8.len(var_416_19)
				local var_416_22 = var_416_20 <= 0 and var_416_16 or var_416_16 * (var_416_21 / var_416_20)

				if var_416_22 > 0 and var_416_16 < var_416_22 then
					arg_413_1.talkMaxDuration = var_416_22

					if var_416_22 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_22 + var_416_15
					end
				end

				arg_413_1.text_.text = var_416_19
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112100", "story_v_out_322112.awb") ~= 0 then
					local var_416_23 = manager.audio:GetVoiceLength("story_v_out_322112", "322112100", "story_v_out_322112.awb") / 1000

					if var_416_23 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_23 + var_416_15
					end

					if var_416_18.prefab_name ~= "" and arg_413_1.actors_[var_416_18.prefab_name] ~= nil then
						local var_416_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_18.prefab_name].transform, "story_v_out_322112", "322112100", "story_v_out_322112.awb")

						arg_413_1:RecordAudio("322112100", var_416_24)
						arg_413_1:RecordAudio("322112100", var_416_24)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_322112", "322112100", "story_v_out_322112.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_322112", "322112100", "story_v_out_322112.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_25 = math.max(var_416_16, arg_413_1.talkMaxDuration)

			if var_416_15 <= arg_413_1.time_ and arg_413_1.time_ < var_416_15 + var_416_25 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_15) / var_416_25

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_15 + var_416_25 and arg_413_1.time_ < var_416_15 + var_416_25 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play322112101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 322112101
		arg_417_1.duration_ = 2.23

		local var_417_0 = {
			zh = 1.866,
			ja = 2.233
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play322112102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["10104ui_story"]
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect10104ui_story == nil then
				arg_417_1.var_.characterEffect10104ui_story = var_420_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 and not isNil(var_420_0) then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2

				if arg_417_1.var_.characterEffect10104ui_story and not isNil(var_420_0) then
					local var_420_4 = Mathf.Lerp(0, 0.5, var_420_3)

					arg_417_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_417_1.var_.characterEffect10104ui_story.fillRatio = var_420_4
				end
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect10104ui_story then
				local var_420_5 = 0.5

				arg_417_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_417_1.var_.characterEffect10104ui_story.fillRatio = var_420_5
			end

			local var_420_6 = 0
			local var_420_7 = 0.2

			if var_420_6 < arg_417_1.time_ and arg_417_1.time_ <= var_420_6 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_8 = arg_417_1:FormatText(StoryNameCfg[487].name)

				arg_417_1.leftNameTxt_.text = var_420_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_417_1.callingController_:SetSelectedState("calling")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_9 = arg_417_1:GetWordFromCfg(322112101)
				local var_420_10 = arg_417_1:FormatText(var_420_9.content)

				arg_417_1.text_.text = var_420_10

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_11 = 8
				local var_420_12 = utf8.len(var_420_10)
				local var_420_13 = var_420_11 <= 0 and var_420_7 or var_420_7 * (var_420_12 / var_420_11)

				if var_420_13 > 0 and var_420_7 < var_420_13 then
					arg_417_1.talkMaxDuration = var_420_13

					if var_420_13 + var_420_6 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_13 + var_420_6
					end
				end

				arg_417_1.text_.text = var_420_10
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112101", "story_v_out_322112.awb") ~= 0 then
					local var_420_14 = manager.audio:GetVoiceLength("story_v_out_322112", "322112101", "story_v_out_322112.awb") / 1000

					if var_420_14 + var_420_6 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_14 + var_420_6
					end

					if var_420_9.prefab_name ~= "" and arg_417_1.actors_[var_420_9.prefab_name] ~= nil then
						local var_420_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_9.prefab_name].transform, "story_v_out_322112", "322112101", "story_v_out_322112.awb")

						arg_417_1:RecordAudio("322112101", var_420_15)
						arg_417_1:RecordAudio("322112101", var_420_15)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_322112", "322112101", "story_v_out_322112.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_322112", "322112101", "story_v_out_322112.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_16 = math.max(var_420_7, arg_417_1.talkMaxDuration)

			if var_420_6 <= arg_417_1.time_ and arg_417_1.time_ < var_420_6 + var_420_16 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_6) / var_420_16

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_6 + var_420_16 and arg_417_1.time_ < var_420_6 + var_420_16 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play322112102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 322112102
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play322112103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["10104ui_story"].transform
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.var_.moveOldPos10104ui_story = var_424_0.localPosition
			end

			local var_424_2 = 0.001

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2
				local var_424_4 = Vector3.New(0, 100, 0)

				var_424_0.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos10104ui_story, var_424_4, var_424_3)

				local var_424_5 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_5.x, var_424_5.y, var_424_5.z)

				local var_424_6 = var_424_0.localEulerAngles

				var_424_6.z = 0
				var_424_6.x = 0
				var_424_0.localEulerAngles = var_424_6
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 then
				var_424_0.localPosition = Vector3.New(0, 100, 0)

				local var_424_7 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_7.x, var_424_7.y, var_424_7.z)

				local var_424_8 = var_424_0.localEulerAngles

				var_424_8.z = 0
				var_424_8.x = 0
				var_424_0.localEulerAngles = var_424_8
			end

			local var_424_9 = 0
			local var_424_10 = 1.1

			if var_424_9 < arg_421_1.time_ and arg_421_1.time_ <= var_424_9 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_11 = arg_421_1:GetWordFromCfg(322112102)
				local var_424_12 = arg_421_1:FormatText(var_424_11.content)

				arg_421_1.text_.text = var_424_12

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_13 = 44
				local var_424_14 = utf8.len(var_424_12)
				local var_424_15 = var_424_13 <= 0 and var_424_10 or var_424_10 * (var_424_14 / var_424_13)

				if var_424_15 > 0 and var_424_10 < var_424_15 then
					arg_421_1.talkMaxDuration = var_424_15

					if var_424_15 + var_424_9 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_15 + var_424_9
					end
				end

				arg_421_1.text_.text = var_424_12
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_16 = math.max(var_424_10, arg_421_1.talkMaxDuration)

			if var_424_9 <= arg_421_1.time_ and arg_421_1.time_ < var_424_9 + var_424_16 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_9) / var_424_16

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_9 + var_424_16 and arg_421_1.time_ < var_424_9 + var_424_16 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play322112103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 322112103
		arg_425_1.duration_ = 4.03

		local var_425_0 = {
			zh = 3.533,
			ja = 4.033
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play322112104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["10104ui_story"].transform
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.var_.moveOldPos10104ui_story = var_428_0.localPosition
			end

			local var_428_2 = 0.001

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2
				local var_428_4 = Vector3.New(0.02, -1.12, -5.99)

				var_428_0.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos10104ui_story, var_428_4, var_428_3)

				local var_428_5 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_5.x, var_428_5.y, var_428_5.z)

				local var_428_6 = var_428_0.localEulerAngles

				var_428_6.z = 0
				var_428_6.x = 0
				var_428_0.localEulerAngles = var_428_6
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 then
				var_428_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_428_7 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_7.x, var_428_7.y, var_428_7.z)

				local var_428_8 = var_428_0.localEulerAngles

				var_428_8.z = 0
				var_428_8.x = 0
				var_428_0.localEulerAngles = var_428_8
			end

			local var_428_9 = arg_425_1.actors_["10104ui_story"]
			local var_428_10 = 0

			if var_428_10 < arg_425_1.time_ and arg_425_1.time_ <= var_428_10 + arg_428_0 and not isNil(var_428_9) and arg_425_1.var_.characterEffect10104ui_story == nil then
				arg_425_1.var_.characterEffect10104ui_story = var_428_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_11 = 0.200000002980232

			if var_428_10 <= arg_425_1.time_ and arg_425_1.time_ < var_428_10 + var_428_11 and not isNil(var_428_9) then
				local var_428_12 = (arg_425_1.time_ - var_428_10) / var_428_11

				if arg_425_1.var_.characterEffect10104ui_story and not isNil(var_428_9) then
					arg_425_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= var_428_10 + var_428_11 and arg_425_1.time_ < var_428_10 + var_428_11 + arg_428_0 and not isNil(var_428_9) and arg_425_1.var_.characterEffect10104ui_story then
				arg_425_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_428_13 = 0

			if var_428_13 < arg_425_1.time_ and arg_425_1.time_ <= var_428_13 + arg_428_0 then
				arg_425_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_428_14 = 0

			if var_428_14 < arg_425_1.time_ and arg_425_1.time_ <= var_428_14 + arg_428_0 then
				arg_425_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_428_15 = 0
			local var_428_16 = 0.225

			if var_428_15 < arg_425_1.time_ and arg_425_1.time_ <= var_428_15 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_17 = arg_425_1:FormatText(StoryNameCfg[1030].name)

				arg_425_1.leftNameTxt_.text = var_428_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_18 = arg_425_1:GetWordFromCfg(322112103)
				local var_428_19 = arg_425_1:FormatText(var_428_18.content)

				arg_425_1.text_.text = var_428_19

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_20 = 9
				local var_428_21 = utf8.len(var_428_19)
				local var_428_22 = var_428_20 <= 0 and var_428_16 or var_428_16 * (var_428_21 / var_428_20)

				if var_428_22 > 0 and var_428_16 < var_428_22 then
					arg_425_1.talkMaxDuration = var_428_22

					if var_428_22 + var_428_15 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_22 + var_428_15
					end
				end

				arg_425_1.text_.text = var_428_19
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112103", "story_v_out_322112.awb") ~= 0 then
					local var_428_23 = manager.audio:GetVoiceLength("story_v_out_322112", "322112103", "story_v_out_322112.awb") / 1000

					if var_428_23 + var_428_15 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_23 + var_428_15
					end

					if var_428_18.prefab_name ~= "" and arg_425_1.actors_[var_428_18.prefab_name] ~= nil then
						local var_428_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_18.prefab_name].transform, "story_v_out_322112", "322112103", "story_v_out_322112.awb")

						arg_425_1:RecordAudio("322112103", var_428_24)
						arg_425_1:RecordAudio("322112103", var_428_24)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_322112", "322112103", "story_v_out_322112.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_322112", "322112103", "story_v_out_322112.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_25 = math.max(var_428_16, arg_425_1.talkMaxDuration)

			if var_428_15 <= arg_425_1.time_ and arg_425_1.time_ < var_428_15 + var_428_25 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_15) / var_428_25

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_15 + var_428_25 and arg_425_1.time_ < var_428_15 + var_428_25 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play322112104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 322112104
		arg_429_1.duration_ = 82.47

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
			arg_429_1.auto_ = false
		end

		function arg_429_1.playNext_(arg_431_0)
			arg_429_1.onStoryFinished_()
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 1

			if var_432_0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_0 + arg_432_0 then
				SetActive(arg_429_1.dialog_, false)
				SetActive(arg_429_1.allBtn_.gameObject, false)
				arg_429_1.hideBtnsController_:SetSelectedIndex(1)
				arg_429_1:StopAllVoice()

				arg_429_1.marker = "1032211stop1"

				manager.video:Play("SofdecAsset/story/story_1032211.usm", function(arg_433_0)
					arg_429_1:Skip(arg_433_0)
					manager.video:Dispose()
				end, nil, nil, function(arg_434_0)
					if arg_434_0 then
						arg_429_1.state_ = "pause"
					else
						arg_429_1.state_ = "playing"
					end
				end, 1032211)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_432_1 = 67.8

			if var_432_0 <= arg_429_1.time_ and arg_429_1.time_ < var_432_0 + var_432_1 then
				-- block empty
			end

			if arg_429_1.time_ >= var_432_0 + var_432_1 and arg_429_1.time_ < var_432_0 + var_432_1 + arg_432_0 then
				arg_429_1.marker = ""
			end

			local var_432_2 = 0

			if var_432_2 < arg_429_1.time_ and arg_429_1.time_ <= var_432_2 + arg_432_0 then
				arg_429_1.mask_.enabled = true
				arg_429_1.mask_.raycastTarget = true

				arg_429_1:SetGaussion(false)
			end

			local var_432_3 = 1

			if var_432_2 <= arg_429_1.time_ and arg_429_1.time_ < var_432_2 + var_432_3 then
				local var_432_4 = (arg_429_1.time_ - var_432_2) / var_432_3
				local var_432_5 = Color.New(0, 0, 0)

				var_432_5.a = Mathf.Lerp(0, 1, var_432_4)
				arg_429_1.mask_.color = var_432_5
			end

			if arg_429_1.time_ >= var_432_2 + var_432_3 and arg_429_1.time_ < var_432_2 + var_432_3 + arg_432_0 then
				local var_432_6 = Color.New(0, 0, 0)

				var_432_6.a = 1
				arg_429_1.mask_.color = var_432_6
			end

			local var_432_7 = 1

			if var_432_7 < arg_429_1.time_ and arg_429_1.time_ <= var_432_7 + arg_432_0 then
				arg_429_1.mask_.enabled = true
				arg_429_1.mask_.raycastTarget = true

				arg_429_1:SetGaussion(false)
			end

			local var_432_8 = 0.5

			if var_432_7 <= arg_429_1.time_ and arg_429_1.time_ < var_432_7 + var_432_8 then
				local var_432_9 = (arg_429_1.time_ - var_432_7) / var_432_8
				local var_432_10 = Color.New(0, 0, 0)

				var_432_10.a = Mathf.Lerp(1, 0, var_432_9)
				arg_429_1.mask_.color = var_432_10
			end

			if arg_429_1.time_ >= var_432_7 + var_432_8 and arg_429_1.time_ < var_432_7 + var_432_8 + arg_432_0 then
				local var_432_11 = Color.New(0, 0, 0)
				local var_432_12 = 0

				arg_429_1.mask_.enabled = false
				var_432_11.a = var_432_12
				arg_429_1.mask_.color = var_432_11
			end

			local var_432_13 = arg_429_1.actors_["10104ui_story"].transform
			local var_432_14 = 0.965999998152256

			if var_432_14 < arg_429_1.time_ and arg_429_1.time_ <= var_432_14 + arg_432_0 then
				arg_429_1.var_.moveOldPos10104ui_story = var_432_13.localPosition
			end

			local var_432_15 = 0.001

			if var_432_14 <= arg_429_1.time_ and arg_429_1.time_ < var_432_14 + var_432_15 then
				local var_432_16 = (arg_429_1.time_ - var_432_14) / var_432_15
				local var_432_17 = Vector3.New(0, 100, 0)

				var_432_13.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos10104ui_story, var_432_17, var_432_16)

				local var_432_18 = manager.ui.mainCamera.transform.position - var_432_13.position

				var_432_13.forward = Vector3.New(var_432_18.x, var_432_18.y, var_432_18.z)

				local var_432_19 = var_432_13.localEulerAngles

				var_432_19.z = 0
				var_432_19.x = 0
				var_432_13.localEulerAngles = var_432_19
			end

			if arg_429_1.time_ >= var_432_14 + var_432_15 and arg_429_1.time_ < var_432_14 + var_432_15 + arg_432_0 then
				var_432_13.localPosition = Vector3.New(0, 100, 0)

				local var_432_20 = manager.ui.mainCamera.transform.position - var_432_13.position

				var_432_13.forward = Vector3.New(var_432_20.x, var_432_20.y, var_432_20.z)

				local var_432_21 = var_432_13.localEulerAngles

				var_432_21.z = 0
				var_432_21.x = 0
				var_432_13.localEulerAngles = var_432_21
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play322112037 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 322112037
		arg_435_1.duration_ = 2

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play322112038(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1284ui_story"].transform
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.var_.moveOldPos1284ui_story = var_438_0.localPosition
			end

			local var_438_2 = 0.001

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2
				local var_438_4 = Vector3.New(0, -0.985, -6.22)

				var_438_0.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1284ui_story, var_438_4, var_438_3)

				local var_438_5 = manager.ui.mainCamera.transform.position - var_438_0.position

				var_438_0.forward = Vector3.New(var_438_5.x, var_438_5.y, var_438_5.z)

				local var_438_6 = var_438_0.localEulerAngles

				var_438_6.z = 0
				var_438_6.x = 0
				var_438_0.localEulerAngles = var_438_6
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 then
				var_438_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_438_7 = manager.ui.mainCamera.transform.position - var_438_0.position

				var_438_0.forward = Vector3.New(var_438_7.x, var_438_7.y, var_438_7.z)

				local var_438_8 = var_438_0.localEulerAngles

				var_438_8.z = 0
				var_438_8.x = 0
				var_438_0.localEulerAngles = var_438_8
			end

			local var_438_9 = arg_435_1.actors_["1284ui_story"]
			local var_438_10 = 0

			if var_438_10 < arg_435_1.time_ and arg_435_1.time_ <= var_438_10 + arg_438_0 and not isNil(var_438_9) and arg_435_1.var_.characterEffect1284ui_story == nil then
				arg_435_1.var_.characterEffect1284ui_story = var_438_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_11 = 0.200000002980232

			if var_438_10 <= arg_435_1.time_ and arg_435_1.time_ < var_438_10 + var_438_11 and not isNil(var_438_9) then
				local var_438_12 = (arg_435_1.time_ - var_438_10) / var_438_11

				if arg_435_1.var_.characterEffect1284ui_story and not isNil(var_438_9) then
					arg_435_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= var_438_10 + var_438_11 and arg_435_1.time_ < var_438_10 + var_438_11 + arg_438_0 and not isNil(var_438_9) and arg_435_1.var_.characterEffect1284ui_story then
				arg_435_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_438_13 = "1284ui_story"

			if arg_435_1.actors_[var_438_13] == nil then
				local var_438_14 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_438_14) then
					local var_438_15 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_435_1.stage_.transform)

					var_438_15.name = var_438_13
					var_438_15.transform.localPosition = Vector3.New(0, 100, 0)
					arg_435_1.actors_[var_438_13] = var_438_15

					local var_438_16 = var_438_15:GetComponentInChildren(typeof(CharacterEffect))

					var_438_16.enabled = true

					local var_438_17 = GameObjectTools.GetOrAddComponent(var_438_15, typeof(DynamicBoneHelper))

					if var_438_17 then
						var_438_17:EnableDynamicBone(false)
					end

					arg_435_1:ShowWeapon(var_438_16.transform, false)

					arg_435_1.var_[var_438_13 .. "Animator"] = var_438_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_435_1.var_[var_438_13 .. "Animator"].applyRootMotion = true
					arg_435_1.var_[var_438_13 .. "LipSync"] = var_438_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_438_18 = 0

			if var_438_18 < arg_435_1.time_ and arg_435_1.time_ <= var_438_18 + arg_438_0 then
				arg_435_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_2")
			end

			local var_438_19 = "1284ui_story"

			if arg_435_1.actors_[var_438_19] == nil then
				local var_438_20 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_438_20) then
					local var_438_21 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_435_1.stage_.transform)

					var_438_21.name = var_438_19
					var_438_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_435_1.actors_[var_438_19] = var_438_21

					local var_438_22 = var_438_21:GetComponentInChildren(typeof(CharacterEffect))

					var_438_22.enabled = true

					local var_438_23 = GameObjectTools.GetOrAddComponent(var_438_21, typeof(DynamicBoneHelper))

					if var_438_23 then
						var_438_23:EnableDynamicBone(false)
					end

					arg_435_1:ShowWeapon(var_438_22.transform, false)

					arg_435_1.var_[var_438_19 .. "Animator"] = var_438_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_435_1.var_[var_438_19 .. "Animator"].applyRootMotion = true
					arg_435_1.var_[var_438_19 .. "LipSync"] = var_438_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_438_24 = 0

			if var_438_24 < arg_435_1.time_ and arg_435_1.time_ <= var_438_24 + arg_438_0 then
				arg_435_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_438_25 = 0
			local var_438_26 = 0.1

			if var_438_25 < arg_435_1.time_ and arg_435_1.time_ <= var_438_25 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_27 = arg_435_1:FormatText(StoryNameCfg[6].name)

				arg_435_1.leftNameTxt_.text = var_438_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_28 = arg_435_1:GetWordFromCfg(322112037)
				local var_438_29 = arg_435_1:FormatText(var_438_28.content)

				arg_435_1.text_.text = var_438_29

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_30 = 4
				local var_438_31 = utf8.len(var_438_29)
				local var_438_32 = var_438_30 <= 0 and var_438_26 or var_438_26 * (var_438_31 / var_438_30)

				if var_438_32 > 0 and var_438_26 < var_438_32 then
					arg_435_1.talkMaxDuration = var_438_32

					if var_438_32 + var_438_25 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_32 + var_438_25
					end
				end

				arg_435_1.text_.text = var_438_29
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112037", "story_v_out_322112.awb") ~= 0 then
					local var_438_33 = manager.audio:GetVoiceLength("story_v_out_322112", "322112037", "story_v_out_322112.awb") / 1000

					if var_438_33 + var_438_25 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_33 + var_438_25
					end

					if var_438_28.prefab_name ~= "" and arg_435_1.actors_[var_438_28.prefab_name] ~= nil then
						local var_438_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_28.prefab_name].transform, "story_v_out_322112", "322112037", "story_v_out_322112.awb")

						arg_435_1:RecordAudio("322112037", var_438_34)
						arg_435_1:RecordAudio("322112037", var_438_34)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_322112", "322112037", "story_v_out_322112.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_322112", "322112037", "story_v_out_322112.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_35 = math.max(var_438_26, arg_435_1.talkMaxDuration)

			if var_438_25 <= arg_435_1.time_ and arg_435_1.time_ < var_438_25 + var_438_35 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_25) / var_438_35

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_25 + var_438_35 and arg_435_1.time_ < var_438_25 + var_438_35 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play322112038 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 322112038
		arg_439_1.duration_ = 3.4

		local var_439_0 = {
			zh = 3.4,
			ja = 3.133
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play322112039(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = arg_439_1.actors_["1284ui_story"].transform
			local var_442_1 = 0

			if var_442_1 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 then
				arg_439_1.var_.moveOldPos1284ui_story = var_442_0.localPosition
			end

			local var_442_2 = 0.001

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_2 then
				local var_442_3 = (arg_439_1.time_ - var_442_1) / var_442_2
				local var_442_4 = Vector3.New(0, -0.985, -6.22)

				var_442_0.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos1284ui_story, var_442_4, var_442_3)

				local var_442_5 = manager.ui.mainCamera.transform.position - var_442_0.position

				var_442_0.forward = Vector3.New(var_442_5.x, var_442_5.y, var_442_5.z)

				local var_442_6 = var_442_0.localEulerAngles

				var_442_6.z = 0
				var_442_6.x = 0
				var_442_0.localEulerAngles = var_442_6
			end

			if arg_439_1.time_ >= var_442_1 + var_442_2 and arg_439_1.time_ < var_442_1 + var_442_2 + arg_442_0 then
				var_442_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_442_7 = manager.ui.mainCamera.transform.position - var_442_0.position

				var_442_0.forward = Vector3.New(var_442_7.x, var_442_7.y, var_442_7.z)

				local var_442_8 = var_442_0.localEulerAngles

				var_442_8.z = 0
				var_442_8.x = 0
				var_442_0.localEulerAngles = var_442_8
			end

			local var_442_9 = arg_439_1.actors_["1284ui_story"]
			local var_442_10 = 0

			if var_442_10 < arg_439_1.time_ and arg_439_1.time_ <= var_442_10 + arg_442_0 and not isNil(var_442_9) and arg_439_1.var_.characterEffect1284ui_story == nil then
				arg_439_1.var_.characterEffect1284ui_story = var_442_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_11 = 0.200000002980232

			if var_442_10 <= arg_439_1.time_ and arg_439_1.time_ < var_442_10 + var_442_11 and not isNil(var_442_9) then
				local var_442_12 = (arg_439_1.time_ - var_442_10) / var_442_11

				if arg_439_1.var_.characterEffect1284ui_story and not isNil(var_442_9) then
					arg_439_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= var_442_10 + var_442_11 and arg_439_1.time_ < var_442_10 + var_442_11 + arg_442_0 and not isNil(var_442_9) and arg_439_1.var_.characterEffect1284ui_story then
				arg_439_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_442_13 = 0

			if var_442_13 < arg_439_1.time_ and arg_439_1.time_ <= var_442_13 + arg_442_0 then
				arg_439_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			local var_442_14 = 0

			if var_442_14 < arg_439_1.time_ and arg_439_1.time_ <= var_442_14 + arg_442_0 then
				arg_439_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_442_15 = 0
			local var_442_16 = 0.3

			if var_442_15 < arg_439_1.time_ and arg_439_1.time_ <= var_442_15 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_17 = arg_439_1:FormatText(StoryNameCfg[6].name)

				arg_439_1.leftNameTxt_.text = var_442_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_18 = arg_439_1:GetWordFromCfg(322112038)
				local var_442_19 = arg_439_1:FormatText(var_442_18.content)

				arg_439_1.text_.text = var_442_19

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_20 = 12
				local var_442_21 = utf8.len(var_442_19)
				local var_442_22 = var_442_20 <= 0 and var_442_16 or var_442_16 * (var_442_21 / var_442_20)

				if var_442_22 > 0 and var_442_16 < var_442_22 then
					arg_439_1.talkMaxDuration = var_442_22

					if var_442_22 + var_442_15 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_22 + var_442_15
					end
				end

				arg_439_1.text_.text = var_442_19
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112038", "story_v_out_322112.awb") ~= 0 then
					local var_442_23 = manager.audio:GetVoiceLength("story_v_out_322112", "322112038", "story_v_out_322112.awb") / 1000

					if var_442_23 + var_442_15 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_23 + var_442_15
					end

					if var_442_18.prefab_name ~= "" and arg_439_1.actors_[var_442_18.prefab_name] ~= nil then
						local var_442_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_18.prefab_name].transform, "story_v_out_322112", "322112038", "story_v_out_322112.awb")

						arg_439_1:RecordAudio("322112038", var_442_24)
						arg_439_1:RecordAudio("322112038", var_442_24)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_322112", "322112038", "story_v_out_322112.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_322112", "322112038", "story_v_out_322112.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_25 = math.max(var_442_16, arg_439_1.talkMaxDuration)

			if var_442_15 <= arg_439_1.time_ and arg_439_1.time_ < var_442_15 + var_442_25 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_15) / var_442_25

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_15 + var_442_25 and arg_439_1.time_ < var_442_15 + var_442_25 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_439_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/MS2206",
		"TextureConfig/Background/ST2102a",
		"TextureConfig/Background/L14f",
		"SofdecAsset/story/story_1032211.usm"
	},
	voices = {
		"story_v_out_322112.awb"
	},
	skipMarkers = {
		322112104
	}
}
