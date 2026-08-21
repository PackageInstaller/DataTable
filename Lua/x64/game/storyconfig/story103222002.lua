return {
	Play322202001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322202001
		arg_1_1.duration_ = 5.73

		local var_1_0 = {
			zh = 5.233,
			ja = 5.733
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
				arg_1_0:Play322202002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 3

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.15

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "MS2205"

			if arg_1_1.bgs_[var_4_2] == nil then
				local var_4_3 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_2)
				var_4_3.name = var_4_2
				var_4_3.transform.parent = arg_1_1.stage_.transform
				var_4_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_2] = var_4_3
			end

			local var_4_4 = 0

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				local var_4_5 = manager.ui.mainCamera.transform.localPosition
				local var_4_6 = Vector3.New(0, 0, 10) + Vector3.New(var_4_5.x, var_4_5.y, 0)
				local var_4_7 = arg_1_1.bgs_.MS2205

				var_4_7.transform.localPosition = var_4_6
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = (var_4_7.transform.localPosition - var_4_5).z
					local var_4_10 = manager.ui.mainCameraCom_
					local var_4_11 = 2 * var_4_9 * Mathf.Tan(var_4_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_12 = var_4_11 * var_4_10.aspect
					local var_4_13 = var_4_8.sprite.bounds.size.x
					local var_4_14 = var_4_8.sprite.bounds.size.y
					local var_4_15 = var_4_12 / var_4_13
					local var_4_16 = var_4_11 / var_4_14
					local var_4_17 = var_4_16 < var_4_15 and var_4_15 or var_4_16

					var_4_7.transform.localScale = Vector3.New(var_4_17, var_4_17, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "MS2205" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 3

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

			local var_4_24 = arg_1_1.bgs_.MS2205.transform
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.var_.moveOldPosMS2205 = var_4_24.localPosition
			end

			local var_4_26 = 3

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				local var_4_27 = (arg_1_1.time_ - var_4_25) / var_4_26
				local var_4_28 = Vector3.New(0, 1, 10)

				var_4_24.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosMS2205, var_4_28, var_4_27)
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				var_4_24.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_29 = 0
			local var_4_30 = 0.3

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				local var_4_31 = "play"
				local var_4_32 = "music"

				arg_1_1:AudioAction(var_4_31, var_4_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_33 = ""
				local var_4_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_34 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_34 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_34

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_34
						arg_1_1.bgmTxt2_.text = var_4_34
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

			local var_4_35 = 0.4
			local var_4_36 = 1

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				local var_4_37 = "play"
				local var_4_38 = "music"

				arg_1_1:AudioAction(var_4_37, var_4_38, "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source.awb")

				local var_4_39 = ""
				local var_4_40 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source")

				if var_4_40 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_40 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_40

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_40
						arg_1_1.bgmTxt2_.text = var_4_40
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

			local var_4_41 = 0.41
			local var_4_42 = 1

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_43 = "play"
				local var_4_44 = "music"

				arg_1_1:AudioAction(var_4_43, var_4_44, "bgm_activity_4_5_story_source", "init_story", "bgm_activity_4_5_story_source.awb")

				local var_4_45 = ""
				local var_4_46 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "init_story")

				if var_4_46 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_46 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_46

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_46
						arg_1_1.bgmTxt2_.text = var_4_46
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_47 = 3
			local var_4_48 = 0.15

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_49 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_49:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_50 = arg_1_1:FormatText(StoryNameCfg[67].name)

				arg_1_1.leftNameTxt_.text = var_4_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_51 = arg_1_1:GetWordFromCfg(322202001)
				local var_4_52 = arg_1_1:FormatText(var_4_51.content)

				arg_1_1.text_.text = var_4_52

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_53 = 6
				local var_4_54 = utf8.len(var_4_52)
				local var_4_55 = var_4_53 <= 0 and var_4_48 or var_4_48 * (var_4_54 / var_4_53)

				if var_4_55 > 0 and var_4_48 < var_4_55 then
					arg_1_1.talkMaxDuration = var_4_55
					var_4_47 = var_4_47 + 0.3

					if var_4_55 + var_4_47 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_55 + var_4_47
					end
				end

				arg_1_1.text_.text = var_4_52
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202001", "story_v_out_322202.awb") ~= 0 then
					local var_4_56 = manager.audio:GetVoiceLength("story_v_out_322202", "322202001", "story_v_out_322202.awb") / 1000

					if var_4_56 + var_4_47 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_56 + var_4_47
					end

					if var_4_51.prefab_name ~= "" and arg_1_1.actors_[var_4_51.prefab_name] ~= nil then
						local var_4_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_51.prefab_name].transform, "story_v_out_322202", "322202001", "story_v_out_322202.awb")

						arg_1_1:RecordAudio("322202001", var_4_57)
						arg_1_1:RecordAudio("322202001", var_4_57)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322202", "322202001", "story_v_out_322202.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322202", "322202001", "story_v_out_322202.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_58 = var_4_47 + 0.3
			local var_4_59 = math.max(var_4_48, arg_1_1.talkMaxDuration)

			if var_4_58 <= arg_1_1.time_ and arg_1_1.time_ < var_4_58 + var_4_59 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_58) / var_4_59

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_58 + var_4_59 and arg_1_1.time_ < var_4_58 + var_4_59 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2205",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 8),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play322202002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 322202002
		arg_10_1.duration_ = 1.43

		local var_10_0 = {
			zh = 1.2,
			ja = 1.433
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play322202003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0
			local var_13_1 = 0.075

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_2 = arg_10_1:FormatText(StoryNameCfg[1156].name)

				arg_10_1.leftNameTxt_.text = var_13_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_3 = arg_10_1:GetWordFromCfg(322202002)
				local var_13_4 = arg_10_1:FormatText(var_13_3.content)

				arg_10_1.text_.text = var_13_4

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_5 = 3
				local var_13_6 = utf8.len(var_13_4)
				local var_13_7 = var_13_5 <= 0 and var_13_1 or var_13_1 * (var_13_6 / var_13_5)

				if var_13_7 > 0 and var_13_1 < var_13_7 then
					arg_10_1.talkMaxDuration = var_13_7

					if var_13_7 + var_13_0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_7 + var_13_0
					end
				end

				arg_10_1.text_.text = var_13_4
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202002", "story_v_out_322202.awb") ~= 0 then
					local var_13_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202002", "story_v_out_322202.awb") / 1000

					if var_13_8 + var_13_0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_8 + var_13_0
					end

					if var_13_3.prefab_name ~= "" and arg_10_1.actors_[var_13_3.prefab_name] ~= nil then
						local var_13_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_3.prefab_name].transform, "story_v_out_322202", "322202002", "story_v_out_322202.awb")

						arg_10_1:RecordAudio("322202002", var_13_9)
						arg_10_1:RecordAudio("322202002", var_13_9)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_322202", "322202002", "story_v_out_322202.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_322202", "322202002", "story_v_out_322202.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_10 = math.max(var_13_1, arg_10_1.talkMaxDuration)

			if var_13_0 <= arg_10_1.time_ and arg_10_1.time_ < var_13_0 + var_13_10 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_0) / var_13_10

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_0 + var_13_10 and arg_10_1.time_ < var_13_0 + var_13_10 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play322202003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 322202003
		arg_14_1.duration_ = 3.47

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play322202004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = "STblack"

			if arg_14_1.bgs_[var_17_0] == nil then
				local var_17_1 = Object.Instantiate(arg_14_1.paintGo_)

				var_17_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_17_0)
				var_17_1.name = var_17_0
				var_17_1.transform.parent = arg_14_1.stage_.transform
				var_17_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_14_1.bgs_[var_17_0] = var_17_1
			end

			local var_17_2 = 1

			if var_17_2 < arg_14_1.time_ and arg_14_1.time_ <= var_17_2 + arg_17_0 then
				local var_17_3 = manager.ui.mainCamera.transform.localPosition
				local var_17_4 = Vector3.New(0, 0, 10) + Vector3.New(var_17_3.x, var_17_3.y, 0)
				local var_17_5 = arg_14_1.bgs_.STblack

				var_17_5.transform.localPosition = var_17_4
				var_17_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_17_6 = var_17_5:GetComponent("SpriteRenderer")

				if var_17_6 and var_17_6.sprite then
					local var_17_7 = (var_17_5.transform.localPosition - var_17_3).z
					local var_17_8 = manager.ui.mainCameraCom_
					local var_17_9 = 2 * var_17_7 * Mathf.Tan(var_17_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_17_10 = var_17_9 * var_17_8.aspect
					local var_17_11 = var_17_6.sprite.bounds.size.x
					local var_17_12 = var_17_6.sprite.bounds.size.y
					local var_17_13 = var_17_10 / var_17_11
					local var_17_14 = var_17_9 / var_17_12
					local var_17_15 = var_17_14 < var_17_13 and var_17_13 or var_17_14

					var_17_5.transform.localScale = Vector3.New(var_17_15, var_17_15, 0)
				end

				for iter_17_0, iter_17_1 in pairs(arg_14_1.bgs_) do
					if iter_17_0 ~= "STblack" then
						iter_17_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_17_16 = 0

			if var_17_16 < arg_14_1.time_ and arg_14_1.time_ <= var_17_16 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_17 = 1

			if var_17_16 <= arg_14_1.time_ and arg_14_1.time_ < var_17_16 + var_17_17 then
				local var_17_18 = (arg_14_1.time_ - var_17_16) / var_17_17
				local var_17_19 = Color.New(0, 0, 0)

				var_17_19.a = Mathf.Lerp(0, 1, var_17_18)
				arg_14_1.mask_.color = var_17_19
			end

			if arg_14_1.time_ >= var_17_16 + var_17_17 and arg_14_1.time_ < var_17_16 + var_17_17 + arg_17_0 then
				local var_17_20 = Color.New(0, 0, 0)

				var_17_20.a = 1
				arg_14_1.mask_.color = var_17_20
			end

			local var_17_21 = 1

			if var_17_21 < arg_14_1.time_ and arg_14_1.time_ <= var_17_21 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_22 = 1

			if var_17_21 <= arg_14_1.time_ and arg_14_1.time_ < var_17_21 + var_17_22 then
				local var_17_23 = (arg_14_1.time_ - var_17_21) / var_17_22
				local var_17_24 = Color.New(0, 0, 0)

				var_17_24.a = Mathf.Lerp(1, 0, var_17_23)
				arg_14_1.mask_.color = var_17_24
			end

			if arg_14_1.time_ >= var_17_21 + var_17_22 and arg_14_1.time_ < var_17_21 + var_17_22 + arg_17_0 then
				local var_17_25 = Color.New(0, 0, 0)
				local var_17_26 = 0

				arg_14_1.mask_.enabled = false
				var_17_25.a = var_17_26
				arg_14_1.mask_.color = var_17_25
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 102,
				charCount = 0,
				enableLayoutChange = true,
				duration = 0.866666666666667,
				groupID = "20033",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 1,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322202003,
				charCount = 24,
				enableLayoutChange = true,
				duration = 1.6,
				groupID = "2003",
				startTime = 1.86666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 1,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play322202004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 322202004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play322202005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 1.625

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_2 = arg_18_1:GetWordFromCfg(322202004)
				local var_21_3 = arg_18_1:FormatText(var_21_2.content)

				arg_18_1.text_.text = var_21_3

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 65
				local var_21_5 = utf8.len(var_21_3)
				local var_21_6 = var_21_4 <= 0 and var_21_1 or var_21_1 * (var_21_5 / var_21_4)

				if var_21_6 > 0 and var_21_1 < var_21_6 then
					arg_18_1.talkMaxDuration = var_21_6

					if var_21_6 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_6 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_3
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_7 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_7 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_7

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_7 and arg_18_1.time_ < var_21_0 + var_21_7 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				groupID = "2003",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322202004,
				charCount = 65,
				enableLayoutChange = true,
				duration = 2.06666666666667,
				groupID = "2004",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 451,
					leftPadding = 382,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1.1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 1,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play322202005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 322202005
		arg_22_1.duration_ = 10.47

		local var_22_0 = {
			zh = 8.266,
			ja = 10.466
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play322202006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 1

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				local var_25_1 = manager.ui.mainCamera.transform.localPosition
				local var_25_2 = Vector3.New(0, 0, 10) + Vector3.New(var_25_1.x, var_25_1.y, 0)
				local var_25_3 = arg_22_1.bgs_.MS2205

				var_25_3.transform.localPosition = var_25_2
				var_25_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_25_4 = var_25_3:GetComponent("SpriteRenderer")

				if var_25_4 and var_25_4.sprite then
					local var_25_5 = (var_25_3.transform.localPosition - var_25_1).z
					local var_25_6 = manager.ui.mainCameraCom_
					local var_25_7 = 2 * var_25_5 * Mathf.Tan(var_25_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_25_8 = var_25_7 * var_25_6.aspect
					local var_25_9 = var_25_4.sprite.bounds.size.x
					local var_25_10 = var_25_4.sprite.bounds.size.y
					local var_25_11 = var_25_8 / var_25_9
					local var_25_12 = var_25_7 / var_25_10
					local var_25_13 = var_25_12 < var_25_11 and var_25_11 or var_25_12

					var_25_3.transform.localScale = Vector3.New(var_25_13, var_25_13, 0)
				end

				for iter_25_0, iter_25_1 in pairs(arg_22_1.bgs_) do
					if iter_25_0 ~= "MS2205" then
						iter_25_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_25_14 = 0

			if var_25_14 < arg_22_1.time_ and arg_22_1.time_ <= var_25_14 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_15 = 1

			if var_25_14 <= arg_22_1.time_ and arg_22_1.time_ < var_25_14 + var_25_15 then
				local var_25_16 = (arg_22_1.time_ - var_25_14) / var_25_15
				local var_25_17 = Color.New(0, 0, 0)

				var_25_17.a = Mathf.Lerp(0, 1, var_25_16)
				arg_22_1.mask_.color = var_25_17
			end

			if arg_22_1.time_ >= var_25_14 + var_25_15 and arg_22_1.time_ < var_25_14 + var_25_15 + arg_25_0 then
				local var_25_18 = Color.New(0, 0, 0)

				var_25_18.a = 1
				arg_22_1.mask_.color = var_25_18
			end

			local var_25_19 = 1

			if var_25_19 < arg_22_1.time_ and arg_22_1.time_ <= var_25_19 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_20 = 1

			if var_25_19 <= arg_22_1.time_ and arg_22_1.time_ < var_25_19 + var_25_20 then
				local var_25_21 = (arg_22_1.time_ - var_25_19) / var_25_20
				local var_25_22 = Color.New(0, 0, 0)

				var_25_22.a = Mathf.Lerp(1, 0, var_25_21)
				arg_22_1.mask_.color = var_25_22
			end

			if arg_22_1.time_ >= var_25_19 + var_25_20 and arg_22_1.time_ < var_25_19 + var_25_20 + arg_25_0 then
				local var_25_23 = Color.New(0, 0, 0)
				local var_25_24 = 0

				arg_22_1.mask_.enabled = false
				var_25_23.a = var_25_24
				arg_22_1.mask_.color = var_25_23
			end

			if arg_22_1.frameCnt_ <= 1 then
				arg_22_1.dialog_:SetActive(false)
			end

			local var_25_25 = 2
			local var_25_26 = 0.65

			if var_25_25 < arg_22_1.time_ and arg_22_1.time_ <= var_25_25 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				arg_22_1.dialog_:SetActive(true)

				arg_22_1.dialogCg_.alpha = 0

				local var_25_27 = LeanTween.value(arg_22_1.dialog_, 0, 1, 0.3)

				var_25_27:setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
					arg_22_1.dialogCg_.alpha = arg_26_0
				end))
				var_25_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_22_1.dialog_)
					var_25_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_22_1.duration_ = arg_22_1.duration_ + 0.3

				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_28 = arg_22_1:FormatText(StoryNameCfg[67].name)

				arg_22_1.leftNameTxt_.text = var_25_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_29 = arg_22_1:GetWordFromCfg(322202005)
				local var_25_30 = arg_22_1:FormatText(var_25_29.content)

				arg_22_1.text_.text = var_25_30

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_31 = 26
				local var_25_32 = utf8.len(var_25_30)
				local var_25_33 = var_25_31 <= 0 and var_25_26 or var_25_26 * (var_25_32 / var_25_31)

				if var_25_33 > 0 and var_25_26 < var_25_33 then
					arg_22_1.talkMaxDuration = var_25_33
					var_25_25 = var_25_25 + 0.3

					if var_25_33 + var_25_25 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_33 + var_25_25
					end
				end

				arg_22_1.text_.text = var_25_30
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202005", "story_v_out_322202.awb") ~= 0 then
					local var_25_34 = manager.audio:GetVoiceLength("story_v_out_322202", "322202005", "story_v_out_322202.awb") / 1000

					if var_25_34 + var_25_25 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_34 + var_25_25
					end

					if var_25_29.prefab_name ~= "" and arg_22_1.actors_[var_25_29.prefab_name] ~= nil then
						local var_25_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_29.prefab_name].transform, "story_v_out_322202", "322202005", "story_v_out_322202.awb")

						arg_22_1:RecordAudio("322202005", var_25_35)
						arg_22_1:RecordAudio("322202005", var_25_35)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_322202", "322202005", "story_v_out_322202.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_322202", "322202005", "story_v_out_322202.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_36 = var_25_25 + 0.3
			local var_25_37 = math.max(var_25_26, arg_22_1.talkMaxDuration)

			if var_25_36 <= arg_22_1.time_ and arg_22_1.time_ < var_25_36 + var_25_37 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_36) / var_25_37

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_36 + var_25_37 and arg_22_1.time_ < var_25_36 + var_25_37 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				groupID = "2004",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play322202006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 322202006
		arg_28_1.duration_ = 10.7

		local var_28_0 = {
			zh = 8.5,
			ja = 10.7
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play322202007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 1.15

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[1156].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_3 = arg_28_1:GetWordFromCfg(322202006)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 46
				local var_31_6 = utf8.len(var_31_4)
				local var_31_7 = var_31_5 <= 0 and var_31_1 or var_31_1 * (var_31_6 / var_31_5)

				if var_31_7 > 0 and var_31_1 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202006", "story_v_out_322202.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202006", "story_v_out_322202.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_322202", "322202006", "story_v_out_322202.awb")

						arg_28_1:RecordAudio("322202006", var_31_9)
						arg_28_1:RecordAudio("322202006", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_322202", "322202006", "story_v_out_322202.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_322202", "322202006", "story_v_out_322202.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_10 and arg_28_1.time_ < var_31_0 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play322202007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 322202007
		arg_32_1.duration_ = 7.37

		local var_32_0 = {
			zh = 5.933,
			ja = 7.366
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play322202008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.675

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[67].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:GetWordFromCfg(322202007)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 27
				local var_35_6 = utf8.len(var_35_4)
				local var_35_7 = var_35_5 <= 0 and var_35_1 or var_35_1 * (var_35_6 / var_35_5)

				if var_35_7 > 0 and var_35_1 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202007", "story_v_out_322202.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202007", "story_v_out_322202.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_322202", "322202007", "story_v_out_322202.awb")

						arg_32_1:RecordAudio("322202007", var_35_9)
						arg_32_1:RecordAudio("322202007", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_322202", "322202007", "story_v_out_322202.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_322202", "322202007", "story_v_out_322202.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_10 and arg_32_1.time_ < var_35_0 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play322202008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 322202008
		arg_36_1.duration_ = 8.6

		local var_36_0 = {
			zh = 5.9,
			ja = 8.6
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play322202009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.55

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[67].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:GetWordFromCfg(322202008)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 22
				local var_39_6 = utf8.len(var_39_4)
				local var_39_7 = var_39_5 <= 0 and var_39_1 or var_39_1 * (var_39_6 / var_39_5)

				if var_39_7 > 0 and var_39_1 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202008", "story_v_out_322202.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202008", "story_v_out_322202.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_322202", "322202008", "story_v_out_322202.awb")

						arg_36_1:RecordAudio("322202008", var_39_9)
						arg_36_1:RecordAudio("322202008", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_322202", "322202008", "story_v_out_322202.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_322202", "322202008", "story_v_out_322202.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_10 and arg_36_1.time_ < var_39_0 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play322202009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 322202009
		arg_40_1.duration_ = 4.83

		local var_40_0 = {
			zh = 3.9,
			ja = 4.833
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play322202010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.425

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[1156].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(322202009)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 17
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202009", "story_v_out_322202.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202009", "story_v_out_322202.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_322202", "322202009", "story_v_out_322202.awb")

						arg_40_1:RecordAudio("322202009", var_43_9)
						arg_40_1:RecordAudio("322202009", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_322202", "322202009", "story_v_out_322202.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_322202", "322202009", "story_v_out_322202.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play322202010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 322202010
		arg_44_1.duration_ = 1.2

		local var_44_0 = {
			zh = 1.2,
			ja = 1.133
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play322202011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = manager.ui.mainCamera.transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.shakeOldPos = var_47_0.localPosition
			end

			local var_47_2 = 0.333333333333333

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / 0.066
				local var_47_4, var_47_5 = math.modf(var_47_3)

				var_47_0.localPosition = Vector3.New(var_47_5 * 0.13, var_47_5 * 0.13, var_47_5 * 0.13) + arg_44_1.var_.shakeOldPos
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = arg_44_1.var_.shakeOldPos
			end

			local var_47_6 = 0
			local var_47_7 = 0.1

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_8 = arg_44_1:FormatText(StoryNameCfg[67].name)

				arg_44_1.leftNameTxt_.text = var_47_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_9 = arg_44_1:GetWordFromCfg(322202010)
				local var_47_10 = arg_44_1:FormatText(var_47_9.content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 4
				local var_47_12 = utf8.len(var_47_10)
				local var_47_13 = var_47_11 <= 0 and var_47_7 or var_47_7 * (var_47_12 / var_47_11)

				if var_47_13 > 0 and var_47_7 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_10
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202010", "story_v_out_322202.awb") ~= 0 then
					local var_47_14 = manager.audio:GetVoiceLength("story_v_out_322202", "322202010", "story_v_out_322202.awb") / 1000

					if var_47_14 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_6
					end

					if var_47_9.prefab_name ~= "" and arg_44_1.actors_[var_47_9.prefab_name] ~= nil then
						local var_47_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_9.prefab_name].transform, "story_v_out_322202", "322202010", "story_v_out_322202.awb")

						arg_44_1:RecordAudio("322202010", var_47_15)
						arg_44_1:RecordAudio("322202010", var_47_15)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_322202", "322202010", "story_v_out_322202.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_322202", "322202010", "story_v_out_322202.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_16 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_16 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_16

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_16 and arg_44_1.time_ < var_47_6 + var_47_16 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play322202011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 322202011
		arg_48_1.duration_ = 7.63

		local var_48_0 = {
			zh = 7.633,
			ja = 7.266
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play322202012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.875

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[1156].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:GetWordFromCfg(322202011)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 35
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202011", "story_v_out_322202.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202011", "story_v_out_322202.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_322202", "322202011", "story_v_out_322202.awb")

						arg_48_1:RecordAudio("322202011", var_51_9)
						arg_48_1:RecordAudio("322202011", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_322202", "322202011", "story_v_out_322202.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_322202", "322202011", "story_v_out_322202.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play322202012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 322202012
		arg_52_1.duration_ = 6.97

		local var_52_0 = {
			zh = 6.166,
			ja = 6.966
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play322202013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.675

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[1156].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_3 = arg_52_1:GetWordFromCfg(322202012)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 27
				local var_55_6 = utf8.len(var_55_4)
				local var_55_7 = var_55_5 <= 0 and var_55_1 or var_55_1 * (var_55_6 / var_55_5)

				if var_55_7 > 0 and var_55_1 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202012", "story_v_out_322202.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202012", "story_v_out_322202.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_322202", "322202012", "story_v_out_322202.awb")

						arg_52_1:RecordAudio("322202012", var_55_9)
						arg_52_1:RecordAudio("322202012", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_322202", "322202012", "story_v_out_322202.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_322202", "322202012", "story_v_out_322202.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_10 and arg_52_1.time_ < var_55_0 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play322202013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 322202013
		arg_56_1.duration_ = 8.9

		local var_56_0 = {
			zh = 6.033,
			ja = 8.9
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play322202014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.625

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[67].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_3 = arg_56_1:GetWordFromCfg(322202013)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 25
				local var_59_6 = utf8.len(var_59_4)
				local var_59_7 = var_59_5 <= 0 and var_59_1 or var_59_1 * (var_59_6 / var_59_5)

				if var_59_7 > 0 and var_59_1 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202013", "story_v_out_322202.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202013", "story_v_out_322202.awb") / 1000

					if var_59_8 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_0
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_322202", "322202013", "story_v_out_322202.awb")

						arg_56_1:RecordAudio("322202013", var_59_9)
						arg_56_1:RecordAudio("322202013", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_322202", "322202013", "story_v_out_322202.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_322202", "322202013", "story_v_out_322202.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_10 and arg_56_1.time_ < var_59_0 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play322202014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 322202014
		arg_60_1.duration_ = 5.6

		local var_60_0 = {
			zh = 4.2,
			ja = 5.6
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play322202015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.5

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[67].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_3 = arg_60_1:GetWordFromCfg(322202014)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 20
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202014", "story_v_out_322202.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202014", "story_v_out_322202.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_322202", "322202014", "story_v_out_322202.awb")

						arg_60_1:RecordAudio("322202014", var_63_9)
						arg_60_1:RecordAudio("322202014", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_322202", "322202014", "story_v_out_322202.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_322202", "322202014", "story_v_out_322202.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_10 and arg_60_1.time_ < var_63_0 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play322202015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 322202015
		arg_64_1.duration_ = 3.43

		local var_64_0 = {
			zh = 2.633,
			ja = 3.433
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play322202016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.225

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_2 = arg_64_1:FormatText(StoryNameCfg[1156].name)

				arg_64_1.leftNameTxt_.text = var_67_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_3 = arg_64_1:GetWordFromCfg(322202015)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 9
				local var_67_6 = utf8.len(var_67_4)
				local var_67_7 = var_67_5 <= 0 and var_67_1 or var_67_1 * (var_67_6 / var_67_5)

				if var_67_7 > 0 and var_67_1 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202015", "story_v_out_322202.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202015", "story_v_out_322202.awb") / 1000

					if var_67_8 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_0
					end

					if var_67_3.prefab_name ~= "" and arg_64_1.actors_[var_67_3.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_3.prefab_name].transform, "story_v_out_322202", "322202015", "story_v_out_322202.awb")

						arg_64_1:RecordAudio("322202015", var_67_9)
						arg_64_1:RecordAudio("322202015", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_322202", "322202015", "story_v_out_322202.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_322202", "322202015", "story_v_out_322202.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_10 and arg_64_1.time_ < var_67_0 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play322202016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 322202016
		arg_68_1.duration_ = 7

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play322202017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.bgs_.MS2205.transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPosMS2205 = var_71_0.localPosition
			end

			local var_71_2 = 2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(-0.4, 0, 4.8)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPosMS2205, var_71_4, var_71_3)
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(-0.4, 0, 4.8)
			end

			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1.allBtn_.enabled = false
			end

			local var_71_6 = 1.46666666666667

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 then
				arg_68_1.allBtn_.enabled = true
			end

			if arg_68_1.frameCnt_ <= 1 then
				arg_68_1.dialog_:SetActive(false)
			end

			local var_71_7 = 2
			local var_71_8 = 0.85

			if var_71_7 < arg_68_1.time_ and arg_68_1.time_ <= var_71_7 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0

				arg_68_1.dialog_:SetActive(true)

				arg_68_1.dialogCg_.alpha = 0

				local var_71_9 = LeanTween.value(arg_68_1.dialog_, 0, 1, 0.3)

				var_71_9:setOnUpdate(LuaHelper.FloatAction(function(arg_72_0)
					arg_68_1.dialogCg_.alpha = arg_72_0
				end))
				var_71_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_68_1.dialog_)
					var_71_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_68_1.duration_ = arg_68_1.duration_ + 0.3

				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_10 = arg_68_1:GetWordFromCfg(322202016)
				local var_71_11 = arg_68_1:FormatText(var_71_10.content)

				arg_68_1.text_.text = var_71_11

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_12 = 34
				local var_71_13 = utf8.len(var_71_11)
				local var_71_14 = var_71_12 <= 0 and var_71_8 or var_71_8 * (var_71_13 / var_71_12)

				if var_71_14 > 0 and var_71_8 < var_71_14 then
					arg_68_1.talkMaxDuration = var_71_14
					var_71_7 = var_71_7 + 0.3

					if var_71_14 + var_71_7 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_7
					end
				end

				arg_68_1.text_.text = var_71_11
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_15 = var_71_7 + 0.3
			local var_71_16 = math.max(var_71_8, arg_68_1.talkMaxDuration)

			if var_71_15 <= arg_68_1.time_ and arg_68_1.time_ < var_71_15 + var_71_16 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_15) / var_71_16

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_15 + var_71_16 and arg_68_1.time_ < var_71_15 + var_71_16 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2205",
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
					startPos = Vector3.New(-0.2, 0.2, 5),
					endPos = Vector3.New(-0.4, 0, 4.8),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play322202017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 322202017
		arg_74_1.duration_ = 6.37

		local var_74_0 = {
			zh = 5.533,
			ja = 6.366
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play322202018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.6

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[67].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:GetWordFromCfg(322202017)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 24
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202017", "story_v_out_322202.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202017", "story_v_out_322202.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_322202", "322202017", "story_v_out_322202.awb")

						arg_74_1:RecordAudio("322202017", var_77_9)
						arg_74_1:RecordAudio("322202017", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_322202", "322202017", "story_v_out_322202.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_322202", "322202017", "story_v_out_322202.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play322202018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 322202018
		arg_78_1.duration_ = 10.03

		local var_78_0 = {
			zh = 7.666,
			ja = 10.033
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play322202019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.95

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[67].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_3 = arg_78_1:GetWordFromCfg(322202018)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 38
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202018", "story_v_out_322202.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202018", "story_v_out_322202.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_322202", "322202018", "story_v_out_322202.awb")

						arg_78_1:RecordAudio("322202018", var_81_9)
						arg_78_1:RecordAudio("322202018", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_322202", "322202018", "story_v_out_322202.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_322202", "322202018", "story_v_out_322202.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_10 and arg_78_1.time_ < var_81_0 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play322202019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 322202019
		arg_82_1.duration_ = 4.37

		local var_82_0 = {
			zh = 3.366,
			ja = 4.366
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play322202020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.375

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[1156].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:GetWordFromCfg(322202019)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 15
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202019", "story_v_out_322202.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202019", "story_v_out_322202.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_322202", "322202019", "story_v_out_322202.awb")

						arg_82_1:RecordAudio("322202019", var_85_9)
						arg_82_1:RecordAudio("322202019", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_322202", "322202019", "story_v_out_322202.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_322202", "322202019", "story_v_out_322202.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_10 and arg_82_1.time_ < var_85_0 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play322202020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 322202020
		arg_86_1.duration_ = 5.63

		local var_86_0 = {
			zh = 4.866,
			ja = 5.633
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play322202021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 0.525

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_2 = arg_86_1:FormatText(StoryNameCfg[67].name)

				arg_86_1.leftNameTxt_.text = var_89_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_3 = arg_86_1:GetWordFromCfg(322202020)
				local var_89_4 = arg_86_1:FormatText(var_89_3.content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 21
				local var_89_6 = utf8.len(var_89_4)
				local var_89_7 = var_89_5 <= 0 and var_89_1 or var_89_1 * (var_89_6 / var_89_5)

				if var_89_7 > 0 and var_89_1 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_4
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202020", "story_v_out_322202.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202020", "story_v_out_322202.awb") / 1000

					if var_89_8 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_0
					end

					if var_89_3.prefab_name ~= "" and arg_86_1.actors_[var_89_3.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_3.prefab_name].transform, "story_v_out_322202", "322202020", "story_v_out_322202.awb")

						arg_86_1:RecordAudio("322202020", var_89_9)
						arg_86_1:RecordAudio("322202020", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_322202", "322202020", "story_v_out_322202.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_322202", "322202020", "story_v_out_322202.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_10 and arg_86_1.time_ < var_89_0 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play322202021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 322202021
		arg_90_1.duration_ = 13.83

		local var_90_0 = {
			zh = 6.366,
			ja = 13.833
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play322202022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.725

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[67].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_3 = arg_90_1:GetWordFromCfg(322202021)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 29
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202021", "story_v_out_322202.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202021", "story_v_out_322202.awb") / 1000

					if var_93_8 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_0
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_322202", "322202021", "story_v_out_322202.awb")

						arg_90_1:RecordAudio("322202021", var_93_9)
						arg_90_1:RecordAudio("322202021", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_322202", "322202021", "story_v_out_322202.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_322202", "322202021", "story_v_out_322202.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_10 and arg_90_1.time_ < var_93_0 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play322202022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 322202022
		arg_94_1.duration_ = 1.17

		local var_94_0 = {
			zh = 1.166,
			ja = 1.033
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play322202023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.1

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[1156].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_3 = arg_94_1:GetWordFromCfg(322202022)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 4
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202022", "story_v_out_322202.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202022", "story_v_out_322202.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_322202", "322202022", "story_v_out_322202.awb")

						arg_94_1:RecordAudio("322202022", var_97_9)
						arg_94_1:RecordAudio("322202022", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_322202", "322202022", "story_v_out_322202.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_322202", "322202022", "story_v_out_322202.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_10 and arg_94_1.time_ < var_97_0 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play322202023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 322202023
		arg_98_1.duration_ = 12.4

		local var_98_0 = {
			zh = 8.533,
			ja = 12.4
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play322202024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.825

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[67].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_3 = arg_98_1:GetWordFromCfg(322202023)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 33
				local var_101_6 = utf8.len(var_101_4)
				local var_101_7 = var_101_5 <= 0 and var_101_1 or var_101_1 * (var_101_6 / var_101_5)

				if var_101_7 > 0 and var_101_1 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202023", "story_v_out_322202.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202023", "story_v_out_322202.awb") / 1000

					if var_101_8 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_0
					end

					if var_101_3.prefab_name ~= "" and arg_98_1.actors_[var_101_3.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_3.prefab_name].transform, "story_v_out_322202", "322202023", "story_v_out_322202.awb")

						arg_98_1:RecordAudio("322202023", var_101_9)
						arg_98_1:RecordAudio("322202023", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_322202", "322202023", "story_v_out_322202.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_322202", "322202023", "story_v_out_322202.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_10 and arg_98_1.time_ < var_101_0 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play322202024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 322202024
		arg_102_1.duration_ = 8.37

		local var_102_0 = {
			zh = 8.366,
			ja = 8.3
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play322202025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.825

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_2 = arg_102_1:FormatText(StoryNameCfg[1156].name)

				arg_102_1.leftNameTxt_.text = var_105_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_3 = arg_102_1:GetWordFromCfg(322202024)
				local var_105_4 = arg_102_1:FormatText(var_105_3.content)

				arg_102_1.text_.text = var_105_4

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 33
				local var_105_6 = utf8.len(var_105_4)
				local var_105_7 = var_105_5 <= 0 and var_105_1 or var_105_1 * (var_105_6 / var_105_5)

				if var_105_7 > 0 and var_105_1 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_4
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202024", "story_v_out_322202.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202024", "story_v_out_322202.awb") / 1000

					if var_105_8 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_0
					end

					if var_105_3.prefab_name ~= "" and arg_102_1.actors_[var_105_3.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_3.prefab_name].transform, "story_v_out_322202", "322202024", "story_v_out_322202.awb")

						arg_102_1:RecordAudio("322202024", var_105_9)
						arg_102_1:RecordAudio("322202024", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_322202", "322202024", "story_v_out_322202.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_322202", "322202024", "story_v_out_322202.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_10 and arg_102_1.time_ < var_105_0 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play322202025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 322202025
		arg_106_1.duration_ = 6.1

		local var_106_0 = {
			zh = 3.5,
			ja = 6.1
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play322202026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.4

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[1156].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_3 = arg_106_1:GetWordFromCfg(322202025)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 16
				local var_109_6 = utf8.len(var_109_4)
				local var_109_7 = var_109_5 <= 0 and var_109_1 or var_109_1 * (var_109_6 / var_109_5)

				if var_109_7 > 0 and var_109_1 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202025", "story_v_out_322202.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202025", "story_v_out_322202.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_322202", "322202025", "story_v_out_322202.awb")

						arg_106_1:RecordAudio("322202025", var_109_9)
						arg_106_1:RecordAudio("322202025", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_322202", "322202025", "story_v_out_322202.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_322202", "322202025", "story_v_out_322202.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_10 and arg_106_1.time_ < var_109_0 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play322202026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 322202026
		arg_110_1.duration_ = 6

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play322202027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.bgs_.MS2205.transform
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.var_.moveOldPosMS2205 = var_113_0.localPosition
			end

			local var_113_2 = 1

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2
				local var_113_4 = Vector3.New(-0.4, -0.2, 4.8)

				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPosMS2205, var_113_4, var_113_3)
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(-0.4, -0.2, 4.8)
			end

			local var_113_5 = 0

			if var_113_5 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			local var_113_6 = 1

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_7 = 1
			local var_113_8 = 0.925

			if var_113_7 < arg_110_1.time_ and arg_110_1.time_ <= var_113_7 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_9 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_9:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_10 = arg_110_1:GetWordFromCfg(322202026)
				local var_113_11 = arg_110_1:FormatText(var_113_10.content)

				arg_110_1.text_.text = var_113_11

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_12 = 37
				local var_113_13 = utf8.len(var_113_11)
				local var_113_14 = var_113_12 <= 0 and var_113_8 or var_113_8 * (var_113_13 / var_113_12)

				if var_113_14 > 0 and var_113_8 < var_113_14 then
					arg_110_1.talkMaxDuration = var_113_14
					var_113_7 = var_113_7 + 0.3

					if var_113_14 + var_113_7 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_14 + var_113_7
					end
				end

				arg_110_1.text_.text = var_113_11
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_15 = var_113_7 + 0.3
			local var_113_16 = math.max(var_113_8, arg_110_1.talkMaxDuration)

			if var_113_15 <= arg_110_1.time_ and arg_110_1.time_ < var_113_15 + var_113_16 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_15) / var_113_16

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_15 + var_113_16 and arg_110_1.time_ < var_113_15 + var_113_16 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2205",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-0.4, 0, 4.8),
					endPos = Vector3.New(-0.4, -0.2, 4.8),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play322202027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 322202027
		arg_116_1.duration_ = 8.47

		local var_116_0 = {
			zh = 6.5,
			ja = 8.466
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play322202028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.725

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[67].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:GetWordFromCfg(322202027)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 29
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202027", "story_v_out_322202.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202027", "story_v_out_322202.awb") / 1000

					if var_119_8 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_0
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_322202", "322202027", "story_v_out_322202.awb")

						arg_116_1:RecordAudio("322202027", var_119_9)
						arg_116_1:RecordAudio("322202027", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_322202", "322202027", "story_v_out_322202.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_322202", "322202027", "story_v_out_322202.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_10 and arg_116_1.time_ < var_119_0 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play322202028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 322202028
		arg_120_1.duration_ = 4.7

		local var_120_0 = {
			zh = 3.433,
			ja = 4.7
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play322202029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.375

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[1156].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_3 = arg_120_1:GetWordFromCfg(322202028)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 15
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202028", "story_v_out_322202.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202028", "story_v_out_322202.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_322202", "322202028", "story_v_out_322202.awb")

						arg_120_1:RecordAudio("322202028", var_123_9)
						arg_120_1:RecordAudio("322202028", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_322202", "322202028", "story_v_out_322202.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_322202", "322202028", "story_v_out_322202.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_10 and arg_120_1.time_ < var_123_0 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play322202029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 322202029
		arg_124_1.duration_ = 6.8

		local var_124_0 = {
			zh = 6.5,
			ja = 6.8
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play322202030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.75

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[1156].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:GetWordFromCfg(322202029)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 30
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202029", "story_v_out_322202.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202029", "story_v_out_322202.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_322202", "322202029", "story_v_out_322202.awb")

						arg_124_1:RecordAudio("322202029", var_127_9)
						arg_124_1:RecordAudio("322202029", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_322202", "322202029", "story_v_out_322202.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_322202", "322202029", "story_v_out_322202.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_10 and arg_124_1.time_ < var_127_0 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play322202030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 322202030
		arg_128_1.duration_ = 4.53

		local var_128_0 = {
			zh = 2.766,
			ja = 4.533
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play322202031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.275

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[67].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_3 = arg_128_1:GetWordFromCfg(322202030)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 11
				local var_131_6 = utf8.len(var_131_4)
				local var_131_7 = var_131_5 <= 0 and var_131_1 or var_131_1 * (var_131_6 / var_131_5)

				if var_131_7 > 0 and var_131_1 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202030", "story_v_out_322202.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202030", "story_v_out_322202.awb") / 1000

					if var_131_8 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_0
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_out_322202", "322202030", "story_v_out_322202.awb")

						arg_128_1:RecordAudio("322202030", var_131_9)
						arg_128_1:RecordAudio("322202030", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_322202", "322202030", "story_v_out_322202.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_322202", "322202030", "story_v_out_322202.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_10 and arg_128_1.time_ < var_131_0 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play322202031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 322202031
		arg_132_1.duration_ = 20.3

		local var_132_0 = {
			zh = 14.233,
			ja = 20.3
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play322202032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.bgs_.MS2205.transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPosMS2205 = var_135_0.localPosition
			end

			local var_135_2 = 2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2
				local var_135_4 = Vector3.New(-0.4, 0, 5.5)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPosMS2205, var_135_4, var_135_3)
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(-0.4, 0, 5.5)
			end

			local var_135_5 = 0

			if var_135_5 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1.allBtn_.enabled = false
			end

			local var_135_6 = 2.1

			if arg_132_1.time_ >= var_135_5 + var_135_6 and arg_132_1.time_ < var_135_5 + var_135_6 + arg_135_0 then
				arg_132_1.allBtn_.enabled = true
			end

			if arg_132_1.frameCnt_ <= 1 then
				arg_132_1.dialog_:SetActive(false)
			end

			local var_135_7 = 2
			local var_135_8 = 1.4

			if var_135_7 < arg_132_1.time_ and arg_132_1.time_ <= var_135_7 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0

				arg_132_1.dialog_:SetActive(true)

				arg_132_1.dialogCg_.alpha = 0

				local var_135_9 = LeanTween.value(arg_132_1.dialog_, 0, 1, 0.3)

				var_135_9:setOnUpdate(LuaHelper.FloatAction(function(arg_136_0)
					arg_132_1.dialogCg_.alpha = arg_136_0
				end))
				var_135_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_132_1.dialog_)
					var_135_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_132_1.duration_ = arg_132_1.duration_ + 0.3

				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_10 = arg_132_1:FormatText(StoryNameCfg[1156].name)

				arg_132_1.leftNameTxt_.text = var_135_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_11 = arg_132_1:GetWordFromCfg(322202031)
				local var_135_12 = arg_132_1:FormatText(var_135_11.content)

				arg_132_1.text_.text = var_135_12

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_13 = 56
				local var_135_14 = utf8.len(var_135_12)
				local var_135_15 = var_135_13 <= 0 and var_135_8 or var_135_8 * (var_135_14 / var_135_13)

				if var_135_15 > 0 and var_135_8 < var_135_15 then
					arg_132_1.talkMaxDuration = var_135_15
					var_135_7 = var_135_7 + 0.3

					if var_135_15 + var_135_7 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_15 + var_135_7
					end
				end

				arg_132_1.text_.text = var_135_12
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202031", "story_v_out_322202.awb") ~= 0 then
					local var_135_16 = manager.audio:GetVoiceLength("story_v_out_322202", "322202031", "story_v_out_322202.awb") / 1000

					if var_135_16 + var_135_7 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_16 + var_135_7
					end

					if var_135_11.prefab_name ~= "" and arg_132_1.actors_[var_135_11.prefab_name] ~= nil then
						local var_135_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_11.prefab_name].transform, "story_v_out_322202", "322202031", "story_v_out_322202.awb")

						arg_132_1:RecordAudio("322202031", var_135_17)
						arg_132_1:RecordAudio("322202031", var_135_17)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_322202", "322202031", "story_v_out_322202.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_322202", "322202031", "story_v_out_322202.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_18 = var_135_7 + 0.3
			local var_135_19 = math.max(var_135_8, arg_132_1.talkMaxDuration)

			if var_135_18 <= arg_132_1.time_ and arg_132_1.time_ < var_135_18 + var_135_19 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_18) / var_135_19

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_18 + var_135_19 and arg_132_1.time_ < var_135_18 + var_135_19 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2205",
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
					startPos = Vector3.New(-0.4, 0, 5),
					endPos = Vector3.New(-0.4, 0, 5.5),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play322202032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 322202032
		arg_138_1.duration_ = 8.87

		local var_138_0 = {
			zh = 8.866,
			ja = 8.6
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play322202033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 1

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_2 = arg_138_1:FormatText(StoryNameCfg[1156].name)

				arg_138_1.leftNameTxt_.text = var_141_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_3 = arg_138_1:GetWordFromCfg(322202032)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 40
				local var_141_6 = utf8.len(var_141_4)
				local var_141_7 = var_141_5 <= 0 and var_141_1 or var_141_1 * (var_141_6 / var_141_5)

				if var_141_7 > 0 and var_141_1 < var_141_7 then
					arg_138_1.talkMaxDuration = var_141_7

					if var_141_7 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202032", "story_v_out_322202.awb") ~= 0 then
					local var_141_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202032", "story_v_out_322202.awb") / 1000

					if var_141_8 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_0
					end

					if var_141_3.prefab_name ~= "" and arg_138_1.actors_[var_141_3.prefab_name] ~= nil then
						local var_141_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_3.prefab_name].transform, "story_v_out_322202", "322202032", "story_v_out_322202.awb")

						arg_138_1:RecordAudio("322202032", var_141_9)
						arg_138_1:RecordAudio("322202032", var_141_9)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_322202", "322202032", "story_v_out_322202.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_322202", "322202032", "story_v_out_322202.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_10 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_10 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_10

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_10 and arg_138_1.time_ < var_141_0 + var_141_10 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play322202033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 322202033
		arg_142_1.duration_ = 5

		local var_142_0 = {
			zh = 3.633,
			ja = 5
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play322202034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.35

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[1156].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_3 = arg_142_1:GetWordFromCfg(322202033)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 14
				local var_145_6 = utf8.len(var_145_4)
				local var_145_7 = var_145_5 <= 0 and var_145_1 or var_145_1 * (var_145_6 / var_145_5)

				if var_145_7 > 0 and var_145_1 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_4
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202033", "story_v_out_322202.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202033", "story_v_out_322202.awb") / 1000

					if var_145_8 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_0
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_out_322202", "322202033", "story_v_out_322202.awb")

						arg_142_1:RecordAudio("322202033", var_145_9)
						arg_142_1:RecordAudio("322202033", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_322202", "322202033", "story_v_out_322202.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_322202", "322202033", "story_v_out_322202.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_10 and arg_142_1.time_ < var_145_0 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play322202034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 322202034
		arg_146_1.duration_ = 4.93

		local var_146_0 = {
			zh = 3.1,
			ja = 4.933
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play322202035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.325

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_2 = arg_146_1:FormatText(StoryNameCfg[67].name)

				arg_146_1.leftNameTxt_.text = var_149_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_3 = arg_146_1:GetWordFromCfg(322202034)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 13
				local var_149_6 = utf8.len(var_149_4)
				local var_149_7 = var_149_5 <= 0 and var_149_1 or var_149_1 * (var_149_6 / var_149_5)

				if var_149_7 > 0 and var_149_1 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_4
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202034", "story_v_out_322202.awb") ~= 0 then
					local var_149_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202034", "story_v_out_322202.awb") / 1000

					if var_149_8 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_0
					end

					if var_149_3.prefab_name ~= "" and arg_146_1.actors_[var_149_3.prefab_name] ~= nil then
						local var_149_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_3.prefab_name].transform, "story_v_out_322202", "322202034", "story_v_out_322202.awb")

						arg_146_1:RecordAudio("322202034", var_149_9)
						arg_146_1:RecordAudio("322202034", var_149_9)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_322202", "322202034", "story_v_out_322202.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_322202", "322202034", "story_v_out_322202.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_10 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_10 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_10

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_10 and arg_146_1.time_ < var_149_0 + var_149_10 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play322202035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 322202035
		arg_150_1.duration_ = 12.5

		local var_150_0 = {
			zh = 8.466,
			ja = 12.5
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play322202036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.9

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_2 = arg_150_1:FormatText(StoryNameCfg[1156].name)

				arg_150_1.leftNameTxt_.text = var_153_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_3 = arg_150_1:GetWordFromCfg(322202035)
				local var_153_4 = arg_150_1:FormatText(var_153_3.content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 36
				local var_153_6 = utf8.len(var_153_4)
				local var_153_7 = var_153_5 <= 0 and var_153_1 or var_153_1 * (var_153_6 / var_153_5)

				if var_153_7 > 0 and var_153_1 < var_153_7 then
					arg_150_1.talkMaxDuration = var_153_7

					if var_153_7 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_7 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_4
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202035", "story_v_out_322202.awb") ~= 0 then
					local var_153_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202035", "story_v_out_322202.awb") / 1000

					if var_153_8 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_8 + var_153_0
					end

					if var_153_3.prefab_name ~= "" and arg_150_1.actors_[var_153_3.prefab_name] ~= nil then
						local var_153_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_3.prefab_name].transform, "story_v_out_322202", "322202035", "story_v_out_322202.awb")

						arg_150_1:RecordAudio("322202035", var_153_9)
						arg_150_1:RecordAudio("322202035", var_153_9)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_322202", "322202035", "story_v_out_322202.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_322202", "322202035", "story_v_out_322202.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_10 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_10 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_10

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_10 and arg_150_1.time_ < var_153_0 + var_153_10 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play322202036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 322202036
		arg_154_1.duration_ = 2.97

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play322202037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.bgs_.MS2205.transform
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.moveOldPosMS2205 = var_157_0.localPosition
			end

			local var_157_2 = 2.05

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2
				local var_157_4 = Vector3.New(-0.4, -0.2, 5)

				var_157_0.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPosMS2205, var_157_4, var_157_3)
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 then
				var_157_0.localPosition = Vector3.New(-0.4, -0.2, 5)
			end

			local var_157_5 = 0

			if var_157_5 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 then
				arg_154_1.allBtn_.enabled = false
			end

			local var_157_6 = 2.05

			if arg_154_1.time_ >= var_157_5 + var_157_6 and arg_154_1.time_ < var_157_5 + var_157_6 + arg_157_0 then
				arg_154_1.allBtn_.enabled = true
			end

			if arg_154_1.frameCnt_ <= 1 then
				arg_154_1.dialog_:SetActive(false)
			end

			local var_157_7 = 2
			local var_157_8 = 0.05

			if var_157_7 < arg_154_1.time_ and arg_154_1.time_ <= var_157_7 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0

				arg_154_1.dialog_:SetActive(true)

				arg_154_1.dialogCg_.alpha = 0

				local var_157_9 = LeanTween.value(arg_154_1.dialog_, 0, 1, 0.3)

				var_157_9:setOnUpdate(LuaHelper.FloatAction(function(arg_158_0)
					arg_154_1.dialogCg_.alpha = arg_158_0
				end))
				var_157_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_154_1.dialog_)
					var_157_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_154_1.duration_ = arg_154_1.duration_ + 0.3

				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_10 = arg_154_1:FormatText(StoryNameCfg[67].name)

				arg_154_1.leftNameTxt_.text = var_157_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_11 = arg_154_1:GetWordFromCfg(322202036)
				local var_157_12 = arg_154_1:FormatText(var_157_11.content)

				arg_154_1.text_.text = var_157_12

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_13 = 2
				local var_157_14 = utf8.len(var_157_12)
				local var_157_15 = var_157_13 <= 0 and var_157_8 or var_157_8 * (var_157_14 / var_157_13)

				if var_157_15 > 0 and var_157_8 < var_157_15 then
					arg_154_1.talkMaxDuration = var_157_15
					var_157_7 = var_157_7 + 0.3

					if var_157_15 + var_157_7 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_15 + var_157_7
					end
				end

				arg_154_1.text_.text = var_157_12
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202036", "story_v_out_322202.awb") ~= 0 then
					local var_157_16 = manager.audio:GetVoiceLength("story_v_out_322202", "322202036", "story_v_out_322202.awb") / 1000

					if var_157_16 + var_157_7 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_16 + var_157_7
					end

					if var_157_11.prefab_name ~= "" and arg_154_1.actors_[var_157_11.prefab_name] ~= nil then
						local var_157_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_11.prefab_name].transform, "story_v_out_322202", "322202036", "story_v_out_322202.awb")

						arg_154_1:RecordAudio("322202036", var_157_17)
						arg_154_1:RecordAudio("322202036", var_157_17)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_322202", "322202036", "story_v_out_322202.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_322202", "322202036", "story_v_out_322202.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_18 = var_157_7 + 0.3
			local var_157_19 = math.max(var_157_8, arg_154_1.talkMaxDuration)

			if var_157_18 <= arg_154_1.time_ and arg_154_1.time_ < var_157_18 + var_157_19 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_18) / var_157_19

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_18 + var_157_19 and arg_154_1.time_ < var_157_18 + var_157_19 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2205",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.05,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-0.4, 0, 5.5),
					endPos = Vector3.New(-0.4, -0.2, 5),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play322202037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 322202037
		arg_160_1.duration_ = 10.5

		local var_160_0 = {
			zh = 8.133,
			ja = 10.5
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play322202038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 0.85

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_2 = arg_160_1:FormatText(StoryNameCfg[1156].name)

				arg_160_1.leftNameTxt_.text = var_163_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_3 = arg_160_1:GetWordFromCfg(322202037)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 34
				local var_163_6 = utf8.len(var_163_4)
				local var_163_7 = var_163_5 <= 0 and var_163_1 or var_163_1 * (var_163_6 / var_163_5)

				if var_163_7 > 0 and var_163_1 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202037", "story_v_out_322202.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202037", "story_v_out_322202.awb") / 1000

					if var_163_8 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_0
					end

					if var_163_3.prefab_name ~= "" and arg_160_1.actors_[var_163_3.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_3.prefab_name].transform, "story_v_out_322202", "322202037", "story_v_out_322202.awb")

						arg_160_1:RecordAudio("322202037", var_163_9)
						arg_160_1:RecordAudio("322202037", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_322202", "322202037", "story_v_out_322202.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_322202", "322202037", "story_v_out_322202.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_10 and arg_160_1.time_ < var_163_0 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play322202038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 322202038
		arg_164_1.duration_ = 7.93

		local var_164_0 = {
			zh = 7.766,
			ja = 7.933
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
			arg_164_1.auto_ = false
		end

		function arg_164_1.playNext_(arg_166_0)
			arg_164_1.onStoryFinished_()
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 0.85

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_2 = arg_164_1:FormatText(StoryNameCfg[1156].name)

				arg_164_1.leftNameTxt_.text = var_167_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_3 = arg_164_1:GetWordFromCfg(322202038)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 34
				local var_167_6 = utf8.len(var_167_4)
				local var_167_7 = var_167_5 <= 0 and var_167_1 or var_167_1 * (var_167_6 / var_167_5)

				if var_167_7 > 0 and var_167_1 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322202", "322202038", "story_v_out_322202.awb") ~= 0 then
					local var_167_8 = manager.audio:GetVoiceLength("story_v_out_322202", "322202038", "story_v_out_322202.awb") / 1000

					if var_167_8 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_0
					end

					if var_167_3.prefab_name ~= "" and arg_164_1.actors_[var_167_3.prefab_name] ~= nil then
						local var_167_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_3.prefab_name].transform, "story_v_out_322202", "322202038", "story_v_out_322202.awb")

						arg_164_1:RecordAudio("322202038", var_167_9)
						arg_164_1:RecordAudio("322202038", var_167_9)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_322202", "322202038", "story_v_out_322202.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_322202", "322202038", "story_v_out_322202.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_10 and arg_164_1.time_ < var_167_0 + var_167_10 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/MS2205",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_322202.awb"
	}
}
