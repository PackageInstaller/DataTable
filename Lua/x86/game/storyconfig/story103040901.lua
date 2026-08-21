return {
	Play304091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304091001
		arg_1_1.duration_ = 6.7

		local var_1_0 = {
			zh = 6.7,
			ja = 4.499999999999
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
				arg_1_0:Play304091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B06"

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
				local var_4_5 = arg_1_1.bgs_.B06

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
					if iter_4_0 ~= "B06" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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

			local var_4_24 = arg_1_1.actors_["2025ui_story"]
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 and not isNil(var_4_24) and arg_1_1.var_.characterEffect2025ui_story == nil then
				arg_1_1.var_.characterEffect2025ui_story = var_4_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_26 = 0.200000002980232

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 and not isNil(var_4_24) then
				local var_4_27 = (arg_1_1.time_ - var_4_25) / var_4_26

				if arg_1_1.var_.characterEffect2025ui_story and not isNil(var_4_24) then
					arg_1_1.var_.characterEffect2025ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 and not isNil(var_4_24) and arg_1_1.var_.characterEffect2025ui_story then
				arg_1_1.var_.characterEffect2025ui_story.fillFlat = false
			end

			local var_4_28 = manager.ui.mainCamera.transform
			local var_4_29 = 1

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				local var_4_30 = arg_1_1.var_.effectQWE
				local var_4_31
				local var_4_32 = var_4_28

				if not var_4_30 then
					var_4_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_4_32)
					var_4_30.name = "QWE"
					arg_1_1.var_.effectQWE = var_4_30
				else
					var_4_30.transform:SetParent(var_4_32)
				end

				var_4_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_30.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_33 = 1.7777777777777777
				local var_4_34 = Screen.width / Screen.height
				local var_4_35 = var_4_34 / var_4_33
				local var_4_36 = Mathf.Max(var_4_33 / var_4_34, 1)

				var_4_30.transform.localScale = Vector3.New(var_4_30.transform.localScale.x * var_4_35, var_4_30.transform.localScale.y * var_4_36, var_4_30.transform.localScale.z)
			end

			local var_4_37 = manager.ui.mainCamera.transform
			local var_4_38 = 2.75

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				local var_4_39 = arg_1_1.var_.effectQWE

				if var_4_39 then
					Object.Destroy(var_4_39)

					arg_1_1.var_.effectQWE = nil
				end
			end

			local var_4_40 = 0.2
			local var_4_41 = 1

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				local var_4_42 = "play"
				local var_4_43 = "effect"

				arg_1_1:AudioAction(var_4_42, var_4_43, "se_story_148", "se_story_148_amb_drone", "")
			end

			local var_4_44 = 1
			local var_4_45 = 1

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "music"

				arg_1_1:AudioAction(var_4_46, var_4_47, "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous.awb")

				local var_4_48 = ""
				local var_4_49 = manager.audio:GetAudioName("bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous")

				if var_4_49 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_49 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_49

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_49
						arg_1_1.bgmTxt2_.text = var_4_49
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

			local var_4_50 = 0
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "effect"

				arg_1_1:AudioAction(var_4_52, var_4_53, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_54 = 1.7
			local var_4_55 = 0.425

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_56 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_56:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[1557].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2025")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_58 = arg_1_1:GetWordFromCfg(304091001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 17
				local var_4_61 = utf8.len(var_4_59)
				local var_4_62 = var_4_60 <= 0 and var_4_55 or var_4_55 * (var_4_61 / var_4_60)

				if var_4_62 > 0 and var_4_55 < var_4_62 then
					arg_1_1.talkMaxDuration = var_4_62
					var_4_54 = var_4_54 + 0.3

					if var_4_62 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_54
					end
				end

				arg_1_1.text_.text = var_4_59
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091001", "story_v_out_304091.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_out_304091", "304091001", "story_v_out_304091.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_out_304091", "304091001", "story_v_out_304091.awb")

						arg_1_1:RecordAudio("304091001", var_4_64)
						arg_1_1:RecordAudio("304091001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304091", "304091001", "story_v_out_304091.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304091", "304091001", "story_v_out_304091.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_65 = var_4_54 + 0.3
			local var_4_66 = math.max(var_4_55, arg_1_1.talkMaxDuration)

			if var_4_65 <= arg_1_1.time_ and arg_1_1.time_ < var_4_65 + var_4_66 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_65) / var_4_66

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_65 + var_4_66 and arg_1_1.time_ < var_4_65 + var_4_66 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play304091002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304091002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play304091003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["2025ui_story"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect2025ui_story == nil then
				arg_8_1.var_.characterEffect2025ui_story = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.200000002980232

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect2025ui_story and not isNil(var_11_0) then
					local var_11_4 = Mathf.Lerp(0, 0.5, var_11_3)

					arg_8_1.var_.characterEffect2025ui_story.fillFlat = true
					arg_8_1.var_.characterEffect2025ui_story.fillRatio = var_11_4
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect2025ui_story then
				local var_11_5 = 0.5

				arg_8_1.var_.characterEffect2025ui_story.fillFlat = true
				arg_8_1.var_.characterEffect2025ui_story.fillRatio = var_11_5
			end

			local var_11_6 = 0
			local var_11_7 = 1.6

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_8 = arg_8_1:GetWordFromCfg(304091002)
				local var_11_9 = arg_8_1:FormatText(var_11_8.content)

				arg_8_1.text_.text = var_11_9

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_10 = 64
				local var_11_11 = utf8.len(var_11_9)
				local var_11_12 = var_11_10 <= 0 and var_11_7 or var_11_7 * (var_11_11 / var_11_10)

				if var_11_12 > 0 and var_11_7 < var_11_12 then
					arg_8_1.talkMaxDuration = var_11_12

					if var_11_12 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_12 + var_11_6
					end
				end

				arg_8_1.text_.text = var_11_9
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_13 = math.max(var_11_7, arg_8_1.talkMaxDuration)

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_13 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_6) / var_11_13

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_6 + var_11_13 and arg_8_1.time_ < var_11_6 + var_11_13 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play304091003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304091003
		arg_12_1.duration_ = 4.37

		local var_12_0 = {
			zh = 4.366,
			ja = 4.2
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play304091004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["3010ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect3010ui_story == nil then
				arg_12_1.var_.characterEffect3010ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect3010ui_story and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect3010ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect3010ui_story then
				arg_12_1.var_.characterEffect3010ui_story.fillFlat = false
			end

			local var_15_4 = 0
			local var_15_5 = 0.525

			if var_15_4 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_6 = arg_12_1:FormatText(StoryNameCfg[40].name)

				arg_12_1.leftNameTxt_.text = var_15_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3010")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_7 = arg_12_1:GetWordFromCfg(304091003)
				local var_15_8 = arg_12_1:FormatText(var_15_7.content)

				arg_12_1.text_.text = var_15_8

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_9 = 21
				local var_15_10 = utf8.len(var_15_8)
				local var_15_11 = var_15_9 <= 0 and var_15_5 or var_15_5 * (var_15_10 / var_15_9)

				if var_15_11 > 0 and var_15_5 < var_15_11 then
					arg_12_1.talkMaxDuration = var_15_11

					if var_15_11 + var_15_4 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_11 + var_15_4
					end
				end

				arg_12_1.text_.text = var_15_8
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091003", "story_v_out_304091.awb") ~= 0 then
					local var_15_12 = manager.audio:GetVoiceLength("story_v_out_304091", "304091003", "story_v_out_304091.awb") / 1000

					if var_15_12 + var_15_4 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_12 + var_15_4
					end

					if var_15_7.prefab_name ~= "" and arg_12_1.actors_[var_15_7.prefab_name] ~= nil then
						local var_15_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_7.prefab_name].transform, "story_v_out_304091", "304091003", "story_v_out_304091.awb")

						arg_12_1:RecordAudio("304091003", var_15_13)
						arg_12_1:RecordAudio("304091003", var_15_13)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_304091", "304091003", "story_v_out_304091.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_304091", "304091003", "story_v_out_304091.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_5, arg_12_1.talkMaxDuration)

			if var_15_4 <= arg_12_1.time_ and arg_12_1.time_ < var_15_4 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_4) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_4 + var_15_14 and arg_12_1.time_ < var_15_4 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play304091004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304091004
		arg_16_1.duration_ = 3.67

		local var_16_0 = {
			zh = 3.666,
			ja = 3.533
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play304091005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "3008ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["3008ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos3008ui_story = var_19_5.localPosition
			end

			local var_19_7 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7
				local var_19_9 = Vector3.New(0, -1.51, -4.3)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos3008ui_story, var_19_9, var_19_8)

				local var_19_10 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_10.x, var_19_10.y, var_19_10.z)

				local var_19_11 = var_19_5.localEulerAngles

				var_19_11.z = 0
				var_19_11.x = 0
				var_19_5.localEulerAngles = var_19_11
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_19_12 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_12.x, var_19_12.y, var_19_12.z)

				local var_19_13 = var_19_5.localEulerAngles

				var_19_13.z = 0
				var_19_13.x = 0
				var_19_5.localEulerAngles = var_19_13
			end

			local var_19_14 = arg_16_1.actors_["3008ui_story"]
			local var_19_15 = 0

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect3008ui_story == nil then
				arg_16_1.var_.characterEffect3008ui_story = var_19_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_16 = 0.200000002980232

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_16 and not isNil(var_19_14) then
				local var_19_17 = (arg_16_1.time_ - var_19_15) / var_19_16

				if arg_16_1.var_.characterEffect3008ui_story and not isNil(var_19_14) then
					arg_16_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_15 + var_19_16 and arg_16_1.time_ < var_19_15 + var_19_16 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect3008ui_story then
				arg_16_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_19_18 = arg_16_1.actors_["3010ui_story"]
			local var_19_19 = 0

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 and not isNil(var_19_18) and arg_16_1.var_.characterEffect3010ui_story == nil then
				arg_16_1.var_.characterEffect3010ui_story = var_19_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_20 = 0.200000002980232

			if var_19_19 <= arg_16_1.time_ and arg_16_1.time_ < var_19_19 + var_19_20 and not isNil(var_19_18) then
				local var_19_21 = (arg_16_1.time_ - var_19_19) / var_19_20

				if arg_16_1.var_.characterEffect3010ui_story and not isNil(var_19_18) then
					local var_19_22 = Mathf.Lerp(0, 0.5, var_19_21)

					arg_16_1.var_.characterEffect3010ui_story.fillFlat = true
					arg_16_1.var_.characterEffect3010ui_story.fillRatio = var_19_22
				end
			end

			if arg_16_1.time_ >= var_19_19 + var_19_20 and arg_16_1.time_ < var_19_19 + var_19_20 + arg_19_0 and not isNil(var_19_18) and arg_16_1.var_.characterEffect3010ui_story then
				local var_19_23 = 0.5

				arg_16_1.var_.characterEffect3010ui_story.fillFlat = true
				arg_16_1.var_.characterEffect3010ui_story.fillRatio = var_19_23
			end

			local var_19_24 = 0

			if var_19_24 < arg_16_1.time_ and arg_16_1.time_ <= var_19_24 + arg_19_0 then
				arg_16_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action6_1")
			end

			local var_19_25 = 0

			if var_19_25 < arg_16_1.time_ and arg_16_1.time_ <= var_19_25 + arg_19_0 then
				arg_16_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_26 = 0
			local var_19_27 = 0.425

			if var_19_26 < arg_16_1.time_ and arg_16_1.time_ <= var_19_26 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_28 = arg_16_1:FormatText(StoryNameCfg[20].name)

				arg_16_1.leftNameTxt_.text = var_19_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_29 = arg_16_1:GetWordFromCfg(304091004)
				local var_19_30 = arg_16_1:FormatText(var_19_29.content)

				arg_16_1.text_.text = var_19_30

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_31 = 17
				local var_19_32 = utf8.len(var_19_30)
				local var_19_33 = var_19_31 <= 0 and var_19_27 or var_19_27 * (var_19_32 / var_19_31)

				if var_19_33 > 0 and var_19_27 < var_19_33 then
					arg_16_1.talkMaxDuration = var_19_33

					if var_19_33 + var_19_26 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_33 + var_19_26
					end
				end

				arg_16_1.text_.text = var_19_30
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091004", "story_v_out_304091.awb") ~= 0 then
					local var_19_34 = manager.audio:GetVoiceLength("story_v_out_304091", "304091004", "story_v_out_304091.awb") / 1000

					if var_19_34 + var_19_26 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_34 + var_19_26
					end

					if var_19_29.prefab_name ~= "" and arg_16_1.actors_[var_19_29.prefab_name] ~= nil then
						local var_19_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_29.prefab_name].transform, "story_v_out_304091", "304091004", "story_v_out_304091.awb")

						arg_16_1:RecordAudio("304091004", var_19_35)
						arg_16_1:RecordAudio("304091004", var_19_35)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_304091", "304091004", "story_v_out_304091.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_304091", "304091004", "story_v_out_304091.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_36 = math.max(var_19_27, arg_16_1.talkMaxDuration)

			if var_19_26 <= arg_16_1.time_ and arg_16_1.time_ < var_19_26 + var_19_36 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_26) / var_19_36

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_26 + var_19_36 and arg_16_1.time_ < var_19_26 + var_19_36 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play304091005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304091005
		arg_20_1.duration_ = 4.13

		local var_20_0 = {
			zh = 4.133,
			ja = 2.833
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play304091006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "1011ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_20_1.stage_.transform)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

					var_23_3.enabled = true

					local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

					if var_23_4 then
						var_23_4:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_3.transform, false)

					arg_20_1.var_[var_23_0 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_0 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_0 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_5 = arg_20_1.actors_["1011ui_story"]
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1011ui_story == nil then
				arg_20_1.var_.characterEffect1011ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_7 = 0.200000002980232

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 and not isNil(var_23_5) then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7

				if arg_20_1.var_.characterEffect1011ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1011ui_story then
				arg_20_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_23_9 = arg_20_1.actors_["3008ui_story"]
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect3008ui_story == nil then
				arg_20_1.var_.characterEffect3008ui_story = var_23_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.200000002980232

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_11 and not isNil(var_23_9) then
				local var_23_12 = (arg_20_1.time_ - var_23_10) / var_23_11

				if arg_20_1.var_.characterEffect3008ui_story and not isNil(var_23_9) then
					local var_23_13 = Mathf.Lerp(0, 0.5, var_23_12)

					arg_20_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_20_1.var_.characterEffect3008ui_story.fillRatio = var_23_13
				end
			end

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect3008ui_story then
				local var_23_14 = 0.5

				arg_20_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_20_1.var_.characterEffect3008ui_story.fillRatio = var_23_14
			end

			local var_23_15 = 0
			local var_23_16 = 0.4

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_17 = arg_20_1:FormatText(StoryNameCfg[37].name)

				arg_20_1.leftNameTxt_.text = var_23_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_18 = arg_20_1:GetWordFromCfg(304091005)
				local var_23_19 = arg_20_1:FormatText(var_23_18.content)

				arg_20_1.text_.text = var_23_19

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_20 = 16
				local var_23_21 = utf8.len(var_23_19)
				local var_23_22 = var_23_20 <= 0 and var_23_16 or var_23_16 * (var_23_21 / var_23_20)

				if var_23_22 > 0 and var_23_16 < var_23_22 then
					arg_20_1.talkMaxDuration = var_23_22

					if var_23_22 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_22 + var_23_15
					end
				end

				arg_20_1.text_.text = var_23_19
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091005", "story_v_out_304091.awb") ~= 0 then
					local var_23_23 = manager.audio:GetVoiceLength("story_v_out_304091", "304091005", "story_v_out_304091.awb") / 1000

					if var_23_23 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_23 + var_23_15
					end

					if var_23_18.prefab_name ~= "" and arg_20_1.actors_[var_23_18.prefab_name] ~= nil then
						local var_23_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_18.prefab_name].transform, "story_v_out_304091", "304091005", "story_v_out_304091.awb")

						arg_20_1:RecordAudio("304091005", var_23_24)
						arg_20_1:RecordAudio("304091005", var_23_24)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_304091", "304091005", "story_v_out_304091.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_304091", "304091005", "story_v_out_304091.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_25 = math.max(var_23_16, arg_20_1.talkMaxDuration)

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_25 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_15) / var_23_25

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_15 + var_23_25 and arg_20_1.time_ < var_23_15 + var_23_25 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play304091006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 304091006
		arg_24_1.duration_ = 3.7

		local var_24_0 = {
			zh = 2,
			ja = 3.7
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play304091007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["3010ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect3010ui_story == nil then
				arg_24_1.var_.characterEffect3010ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect3010ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect3010ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect3010ui_story then
				arg_24_1.var_.characterEffect3010ui_story.fillFlat = false
			end

			local var_27_4 = arg_24_1.actors_["1011ui_story"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1011ui_story == nil then
				arg_24_1.var_.characterEffect1011ui_story = var_27_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.200000002980232

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.characterEffect1011ui_story and not isNil(var_27_4) then
					local var_27_8 = Mathf.Lerp(0, 0.5, var_27_7)

					arg_24_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1011ui_story.fillRatio = var_27_8
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1011ui_story then
				local var_27_9 = 0.5

				arg_24_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1011ui_story.fillRatio = var_27_9
			end

			local var_27_10 = 0
			local var_27_11 = 0.2

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_12 = arg_24_1:FormatText(StoryNameCfg[40].name)

				arg_24_1.leftNameTxt_.text = var_27_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3010")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_13 = arg_24_1:GetWordFromCfg(304091006)
				local var_27_14 = arg_24_1:FormatText(var_27_13.content)

				arg_24_1.text_.text = var_27_14

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_15 = 8
				local var_27_16 = utf8.len(var_27_14)
				local var_27_17 = var_27_15 <= 0 and var_27_11 or var_27_11 * (var_27_16 / var_27_15)

				if var_27_17 > 0 and var_27_11 < var_27_17 then
					arg_24_1.talkMaxDuration = var_27_17

					if var_27_17 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_17 + var_27_10
					end
				end

				arg_24_1.text_.text = var_27_14
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091006", "story_v_out_304091.awb") ~= 0 then
					local var_27_18 = manager.audio:GetVoiceLength("story_v_out_304091", "304091006", "story_v_out_304091.awb") / 1000

					if var_27_18 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_18 + var_27_10
					end

					if var_27_13.prefab_name ~= "" and arg_24_1.actors_[var_27_13.prefab_name] ~= nil then
						local var_27_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_13.prefab_name].transform, "story_v_out_304091", "304091006", "story_v_out_304091.awb")

						arg_24_1:RecordAudio("304091006", var_27_19)
						arg_24_1:RecordAudio("304091006", var_27_19)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_304091", "304091006", "story_v_out_304091.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_304091", "304091006", "story_v_out_304091.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_20 = math.max(var_27_11, arg_24_1.talkMaxDuration)

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_20 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_10) / var_27_20

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_10 + var_27_20 and arg_24_1.time_ < var_27_10 + var_27_20 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play304091007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 304091007
		arg_28_1.duration_ = 8.17

		local var_28_0 = {
			zh = 6,
			ja = 8.166
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
				arg_28_0:Play304091008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.7

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[40].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3010")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(304091007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091007", "story_v_out_304091.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_304091", "304091007", "story_v_out_304091.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_304091", "304091007", "story_v_out_304091.awb")

						arg_28_1:RecordAudio("304091007", var_31_9)
						arg_28_1:RecordAudio("304091007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_304091", "304091007", "story_v_out_304091.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_304091", "304091007", "story_v_out_304091.awb")
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
	Play304091008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 304091008
		arg_32_1.duration_ = 3.53

		local var_32_0 = {
			zh = 3.533,
			ja = 3.5
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
				arg_32_0:Play304091009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["3008ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3008ui_story == nil then
				arg_32_1.var_.characterEffect3008ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect3008ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3008ui_story then
				arg_32_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["3010ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect3010ui_story == nil then
				arg_32_1.var_.characterEffect3010ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect3010ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect3010ui_story.fillFlat = true
					arg_32_1.var_.characterEffect3010ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect3010ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect3010ui_story.fillFlat = true
				arg_32_1.var_.characterEffect3010ui_story.fillRatio = var_35_9
			end

			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008actionlink/3008action465")
			end

			local var_35_11 = 0

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_35_12 = 0
			local var_35_13 = 0.475

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_14 = arg_32_1:FormatText(StoryNameCfg[20].name)

				arg_32_1.leftNameTxt_.text = var_35_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_15 = arg_32_1:GetWordFromCfg(304091008)
				local var_35_16 = arg_32_1:FormatText(var_35_15.content)

				arg_32_1.text_.text = var_35_16

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 19
				local var_35_18 = utf8.len(var_35_16)
				local var_35_19 = var_35_17 <= 0 and var_35_13 or var_35_13 * (var_35_18 / var_35_17)

				if var_35_19 > 0 and var_35_13 < var_35_19 then
					arg_32_1.talkMaxDuration = var_35_19

					if var_35_19 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_19 + var_35_12
					end
				end

				arg_32_1.text_.text = var_35_16
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091008", "story_v_out_304091.awb") ~= 0 then
					local var_35_20 = manager.audio:GetVoiceLength("story_v_out_304091", "304091008", "story_v_out_304091.awb") / 1000

					if var_35_20 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_20 + var_35_12
					end

					if var_35_15.prefab_name ~= "" and arg_32_1.actors_[var_35_15.prefab_name] ~= nil then
						local var_35_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_15.prefab_name].transform, "story_v_out_304091", "304091008", "story_v_out_304091.awb")

						arg_32_1:RecordAudio("304091008", var_35_21)
						arg_32_1:RecordAudio("304091008", var_35_21)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_304091", "304091008", "story_v_out_304091.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_304091", "304091008", "story_v_out_304091.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_22 = math.max(var_35_13, arg_32_1.talkMaxDuration)

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_22 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_12) / var_35_22

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_12 + var_35_22 and arg_32_1.time_ < var_35_12 + var_35_22 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play304091009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 304091009
		arg_36_1.duration_ = 12.3

		local var_36_0 = {
			zh = 8.433,
			ja = 12.3
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
				arg_36_0:Play304091010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["3010ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect3010ui_story == nil then
				arg_36_1.var_.characterEffect3010ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect3010ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect3010ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect3010ui_story then
				arg_36_1.var_.characterEffect3010ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["3008ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect3008ui_story == nil then
				arg_36_1.var_.characterEffect3008ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect3008ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_36_1.var_.characterEffect3008ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect3008ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_36_1.var_.characterEffect3008ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0
			local var_39_11 = 0.9

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_12 = arg_36_1:FormatText(StoryNameCfg[40].name)

				arg_36_1.leftNameTxt_.text = var_39_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3010")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_13 = arg_36_1:GetWordFromCfg(304091009)
				local var_39_14 = arg_36_1:FormatText(var_39_13.content)

				arg_36_1.text_.text = var_39_14

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_15 = 36
				local var_39_16 = utf8.len(var_39_14)
				local var_39_17 = var_39_15 <= 0 and var_39_11 or var_39_11 * (var_39_16 / var_39_15)

				if var_39_17 > 0 and var_39_11 < var_39_17 then
					arg_36_1.talkMaxDuration = var_39_17

					if var_39_17 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_17 + var_39_10
					end
				end

				arg_36_1.text_.text = var_39_14
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091009", "story_v_out_304091.awb") ~= 0 then
					local var_39_18 = manager.audio:GetVoiceLength("story_v_out_304091", "304091009", "story_v_out_304091.awb") / 1000

					if var_39_18 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_10
					end

					if var_39_13.prefab_name ~= "" and arg_36_1.actors_[var_39_13.prefab_name] ~= nil then
						local var_39_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_13.prefab_name].transform, "story_v_out_304091", "304091009", "story_v_out_304091.awb")

						arg_36_1:RecordAudio("304091009", var_39_19)
						arg_36_1:RecordAudio("304091009", var_39_19)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_304091", "304091009", "story_v_out_304091.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_304091", "304091009", "story_v_out_304091.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_20 = math.max(var_39_11, arg_36_1.talkMaxDuration)

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_20 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_10) / var_39_20

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_10 + var_39_20 and arg_36_1.time_ < var_39_10 + var_39_20 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play304091010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 304091010
		arg_40_1.duration_ = 2.93

		local var_40_0 = {
			zh = 2.933,
			ja = 2.333
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
				arg_40_0:Play304091011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = "1019ui_story"

			if arg_40_1.actors_[var_43_0] == nil then
				local var_43_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_43_1) then
					local var_43_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_40_1.stage_.transform)

					var_43_2.name = var_43_0
					var_43_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_40_1.actors_[var_43_0] = var_43_2

					local var_43_3 = var_43_2:GetComponentInChildren(typeof(CharacterEffect))

					var_43_3.enabled = true

					local var_43_4 = GameObjectTools.GetOrAddComponent(var_43_2, typeof(DynamicBoneHelper))

					if var_43_4 then
						var_43_4:EnableDynamicBone(false)
					end

					arg_40_1:ShowWeapon(var_43_3.transform, false)

					arg_40_1.var_[var_43_0 .. "Animator"] = var_43_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_40_1.var_[var_43_0 .. "Animator"].applyRootMotion = true
					arg_40_1.var_[var_43_0 .. "LipSync"] = var_43_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_43_5 = arg_40_1.actors_["1019ui_story"].transform
			local var_43_6 = 0

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.var_.moveOldPos1019ui_story = var_43_5.localPosition
			end

			local var_43_7 = 0.001

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_7 then
				local var_43_8 = (arg_40_1.time_ - var_43_6) / var_43_7
				local var_43_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_43_5.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1019ui_story, var_43_9, var_43_8)

				local var_43_10 = manager.ui.mainCamera.transform.position - var_43_5.position

				var_43_5.forward = Vector3.New(var_43_10.x, var_43_10.y, var_43_10.z)

				local var_43_11 = var_43_5.localEulerAngles

				var_43_11.z = 0
				var_43_11.x = 0
				var_43_5.localEulerAngles = var_43_11
			end

			if arg_40_1.time_ >= var_43_6 + var_43_7 and arg_40_1.time_ < var_43_6 + var_43_7 + arg_43_0 then
				var_43_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_43_12 = manager.ui.mainCamera.transform.position - var_43_5.position

				var_43_5.forward = Vector3.New(var_43_12.x, var_43_12.y, var_43_12.z)

				local var_43_13 = var_43_5.localEulerAngles

				var_43_13.z = 0
				var_43_13.x = 0
				var_43_5.localEulerAngles = var_43_13
			end

			local var_43_14 = arg_40_1.actors_["3008ui_story"].transform
			local var_43_15 = 0

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.var_.moveOldPos3008ui_story = var_43_14.localPosition
			end

			local var_43_16 = 0.001

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_16 then
				local var_43_17 = (arg_40_1.time_ - var_43_15) / var_43_16
				local var_43_18 = Vector3.New(0, 100, 0)

				var_43_14.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos3008ui_story, var_43_18, var_43_17)

				local var_43_19 = manager.ui.mainCamera.transform.position - var_43_14.position

				var_43_14.forward = Vector3.New(var_43_19.x, var_43_19.y, var_43_19.z)

				local var_43_20 = var_43_14.localEulerAngles

				var_43_20.z = 0
				var_43_20.x = 0
				var_43_14.localEulerAngles = var_43_20
			end

			if arg_40_1.time_ >= var_43_15 + var_43_16 and arg_40_1.time_ < var_43_15 + var_43_16 + arg_43_0 then
				var_43_14.localPosition = Vector3.New(0, 100, 0)

				local var_43_21 = manager.ui.mainCamera.transform.position - var_43_14.position

				var_43_14.forward = Vector3.New(var_43_21.x, var_43_21.y, var_43_21.z)

				local var_43_22 = var_43_14.localEulerAngles

				var_43_22.z = 0
				var_43_22.x = 0
				var_43_14.localEulerAngles = var_43_22
			end

			local var_43_23 = arg_40_1.actors_["1019ui_story"]
			local var_43_24 = 0

			if var_43_24 < arg_40_1.time_ and arg_40_1.time_ <= var_43_24 + arg_43_0 and not isNil(var_43_23) and arg_40_1.var_.characterEffect1019ui_story == nil then
				arg_40_1.var_.characterEffect1019ui_story = var_43_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_25 = 0.200000002980232

			if var_43_24 <= arg_40_1.time_ and arg_40_1.time_ < var_43_24 + var_43_25 and not isNil(var_43_23) then
				local var_43_26 = (arg_40_1.time_ - var_43_24) / var_43_25

				if arg_40_1.var_.characterEffect1019ui_story and not isNil(var_43_23) then
					arg_40_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_24 + var_43_25 and arg_40_1.time_ < var_43_24 + var_43_25 + arg_43_0 and not isNil(var_43_23) and arg_40_1.var_.characterEffect1019ui_story then
				arg_40_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_43_27 = arg_40_1.actors_["3010ui_story"]
			local var_43_28 = 0

			if var_43_28 < arg_40_1.time_ and arg_40_1.time_ <= var_43_28 + arg_43_0 and not isNil(var_43_27) and arg_40_1.var_.characterEffect3010ui_story == nil then
				arg_40_1.var_.characterEffect3010ui_story = var_43_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_29 = 0.200000002980232

			if var_43_28 <= arg_40_1.time_ and arg_40_1.time_ < var_43_28 + var_43_29 and not isNil(var_43_27) then
				local var_43_30 = (arg_40_1.time_ - var_43_28) / var_43_29

				if arg_40_1.var_.characterEffect3010ui_story and not isNil(var_43_27) then
					local var_43_31 = Mathf.Lerp(0, 0.5, var_43_30)

					arg_40_1.var_.characterEffect3010ui_story.fillFlat = true
					arg_40_1.var_.characterEffect3010ui_story.fillRatio = var_43_31
				end
			end

			if arg_40_1.time_ >= var_43_28 + var_43_29 and arg_40_1.time_ < var_43_28 + var_43_29 + arg_43_0 and not isNil(var_43_27) and arg_40_1.var_.characterEffect3010ui_story then
				local var_43_32 = 0.5

				arg_40_1.var_.characterEffect3010ui_story.fillFlat = true
				arg_40_1.var_.characterEffect3010ui_story.fillRatio = var_43_32
			end

			local var_43_33 = 0

			if var_43_33 < arg_40_1.time_ and arg_40_1.time_ <= var_43_33 + arg_43_0 then
				arg_40_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_43_34 = 0

			if var_43_34 < arg_40_1.time_ and arg_40_1.time_ <= var_43_34 + arg_43_0 then
				arg_40_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_35 = 0
			local var_43_36 = 0.35

			if var_43_35 < arg_40_1.time_ and arg_40_1.time_ <= var_43_35 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_37 = arg_40_1:FormatText(StoryNameCfg[13].name)

				arg_40_1.leftNameTxt_.text = var_43_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_38 = arg_40_1:GetWordFromCfg(304091010)
				local var_43_39 = arg_40_1:FormatText(var_43_38.content)

				arg_40_1.text_.text = var_43_39

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_40 = 14
				local var_43_41 = utf8.len(var_43_39)
				local var_43_42 = var_43_40 <= 0 and var_43_36 or var_43_36 * (var_43_41 / var_43_40)

				if var_43_42 > 0 and var_43_36 < var_43_42 then
					arg_40_1.talkMaxDuration = var_43_42

					if var_43_42 + var_43_35 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_42 + var_43_35
					end
				end

				arg_40_1.text_.text = var_43_39
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091010", "story_v_out_304091.awb") ~= 0 then
					local var_43_43 = manager.audio:GetVoiceLength("story_v_out_304091", "304091010", "story_v_out_304091.awb") / 1000

					if var_43_43 + var_43_35 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_43 + var_43_35
					end

					if var_43_38.prefab_name ~= "" and arg_40_1.actors_[var_43_38.prefab_name] ~= nil then
						local var_43_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_38.prefab_name].transform, "story_v_out_304091", "304091010", "story_v_out_304091.awb")

						arg_40_1:RecordAudio("304091010", var_43_44)
						arg_40_1:RecordAudio("304091010", var_43_44)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_304091", "304091010", "story_v_out_304091.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_304091", "304091010", "story_v_out_304091.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_45 = math.max(var_43_36, arg_40_1.talkMaxDuration)

			if var_43_35 <= arg_40_1.time_ and arg_40_1.time_ < var_43_35 + var_43_45 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_35) / var_43_45

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_35 + var_43_45 and arg_40_1.time_ < var_43_35 + var_43_45 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play304091011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 304091011
		arg_44_1.duration_ = 7.73

		local var_44_0 = {
			zh = 5.333,
			ja = 7.733
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
				arg_44_0:Play304091012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "10002ui_story"

			if arg_44_1.actors_[var_47_0] == nil then
				local var_47_1 = Asset.Load("Char/" .. "10002ui_story")

				if not isNil(var_47_1) then
					local var_47_2 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_44_1.stage_.transform)

					var_47_2.name = var_47_0
					var_47_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_44_1.actors_[var_47_0] = var_47_2

					local var_47_3 = var_47_2:GetComponentInChildren(typeof(CharacterEffect))

					var_47_3.enabled = true

					local var_47_4 = GameObjectTools.GetOrAddComponent(var_47_2, typeof(DynamicBoneHelper))

					if var_47_4 then
						var_47_4:EnableDynamicBone(false)
					end

					arg_44_1:ShowWeapon(var_47_3.transform, false)

					arg_44_1.var_[var_47_0 .. "Animator"] = var_47_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_44_1.var_[var_47_0 .. "Animator"].applyRootMotion = true
					arg_44_1.var_[var_47_0 .. "LipSync"] = var_47_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_47_5 = arg_44_1.actors_["10002ui_story"].transform
			local var_47_6 = 0

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.var_.moveOldPos10002ui_story = var_47_5.localPosition
			end

			local var_47_7 = 0.001

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_7 then
				local var_47_8 = (arg_44_1.time_ - var_47_6) / var_47_7
				local var_47_9 = Vector3.New(-0.7, -1.2, -5.8)

				var_47_5.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10002ui_story, var_47_9, var_47_8)

				local var_47_10 = manager.ui.mainCamera.transform.position - var_47_5.position

				var_47_5.forward = Vector3.New(var_47_10.x, var_47_10.y, var_47_10.z)

				local var_47_11 = var_47_5.localEulerAngles

				var_47_11.z = 0
				var_47_11.x = 0
				var_47_5.localEulerAngles = var_47_11
			end

			if arg_44_1.time_ >= var_47_6 + var_47_7 and arg_44_1.time_ < var_47_6 + var_47_7 + arg_47_0 then
				var_47_5.localPosition = Vector3.New(-0.7, -1.2, -5.8)

				local var_47_12 = manager.ui.mainCamera.transform.position - var_47_5.position

				var_47_5.forward = Vector3.New(var_47_12.x, var_47_12.y, var_47_12.z)

				local var_47_13 = var_47_5.localEulerAngles

				var_47_13.z = 0
				var_47_13.x = 0
				var_47_5.localEulerAngles = var_47_13
			end

			local var_47_14 = arg_44_1.actors_["1019ui_story"].transform
			local var_47_15 = 0

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.var_.moveOldPos1019ui_story = var_47_14.localPosition
			end

			local var_47_16 = 0.001

			if var_47_15 <= arg_44_1.time_ and arg_44_1.time_ < var_47_15 + var_47_16 then
				local var_47_17 = (arg_44_1.time_ - var_47_15) / var_47_16
				local var_47_18 = Vector3.New(0.7, -1.08, -5.9)

				var_47_14.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1019ui_story, var_47_18, var_47_17)

				local var_47_19 = manager.ui.mainCamera.transform.position - var_47_14.position

				var_47_14.forward = Vector3.New(var_47_19.x, var_47_19.y, var_47_19.z)

				local var_47_20 = var_47_14.localEulerAngles

				var_47_20.z = 0
				var_47_20.x = 0
				var_47_14.localEulerAngles = var_47_20
			end

			if arg_44_1.time_ >= var_47_15 + var_47_16 and arg_44_1.time_ < var_47_15 + var_47_16 + arg_47_0 then
				var_47_14.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_47_21 = manager.ui.mainCamera.transform.position - var_47_14.position

				var_47_14.forward = Vector3.New(var_47_21.x, var_47_21.y, var_47_21.z)

				local var_47_22 = var_47_14.localEulerAngles

				var_47_22.z = 0
				var_47_22.x = 0
				var_47_14.localEulerAngles = var_47_22
			end

			local var_47_23 = arg_44_1.actors_["10002ui_story"]
			local var_47_24 = 0

			if var_47_24 < arg_44_1.time_ and arg_44_1.time_ <= var_47_24 + arg_47_0 and not isNil(var_47_23) and arg_44_1.var_.characterEffect10002ui_story == nil then
				arg_44_1.var_.characterEffect10002ui_story = var_47_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_25 = 0.200000002980232

			if var_47_24 <= arg_44_1.time_ and arg_44_1.time_ < var_47_24 + var_47_25 and not isNil(var_47_23) then
				local var_47_26 = (arg_44_1.time_ - var_47_24) / var_47_25

				if arg_44_1.var_.characterEffect10002ui_story and not isNil(var_47_23) then
					arg_44_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_24 + var_47_25 and arg_44_1.time_ < var_47_24 + var_47_25 + arg_47_0 and not isNil(var_47_23) and arg_44_1.var_.characterEffect10002ui_story then
				arg_44_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_47_27 = arg_44_1.actors_["1019ui_story"]
			local var_47_28 = 0

			if var_47_28 < arg_44_1.time_ and arg_44_1.time_ <= var_47_28 + arg_47_0 and not isNil(var_47_27) and arg_44_1.var_.characterEffect1019ui_story == nil then
				arg_44_1.var_.characterEffect1019ui_story = var_47_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_29 = 0.200000002980232

			if var_47_28 <= arg_44_1.time_ and arg_44_1.time_ < var_47_28 + var_47_29 and not isNil(var_47_27) then
				local var_47_30 = (arg_44_1.time_ - var_47_28) / var_47_29

				if arg_44_1.var_.characterEffect1019ui_story and not isNil(var_47_27) then
					local var_47_31 = Mathf.Lerp(0, 0.5, var_47_30)

					arg_44_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1019ui_story.fillRatio = var_47_31
				end
			end

			if arg_44_1.time_ >= var_47_28 + var_47_29 and arg_44_1.time_ < var_47_28 + var_47_29 + arg_47_0 and not isNil(var_47_27) and arg_44_1.var_.characterEffect1019ui_story then
				local var_47_32 = 0.5

				arg_44_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1019ui_story.fillRatio = var_47_32
			end

			local var_47_33 = 0

			if var_47_33 < arg_44_1.time_ and arg_44_1.time_ <= var_47_33 + arg_47_0 then
				arg_44_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			local var_47_34 = 0

			if var_47_34 < arg_44_1.time_ and arg_44_1.time_ <= var_47_34 + arg_47_0 then
				arg_44_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_47_35 = 0
			local var_47_36 = 0.675

			if var_47_35 < arg_44_1.time_ and arg_44_1.time_ <= var_47_35 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_37 = arg_44_1:FormatText(StoryNameCfg[39].name)

				arg_44_1.leftNameTxt_.text = var_47_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_38 = arg_44_1:GetWordFromCfg(304091011)
				local var_47_39 = arg_44_1:FormatText(var_47_38.content)

				arg_44_1.text_.text = var_47_39

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_40 = 27
				local var_47_41 = utf8.len(var_47_39)
				local var_47_42 = var_47_40 <= 0 and var_47_36 or var_47_36 * (var_47_41 / var_47_40)

				if var_47_42 > 0 and var_47_36 < var_47_42 then
					arg_44_1.talkMaxDuration = var_47_42

					if var_47_42 + var_47_35 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_42 + var_47_35
					end
				end

				arg_44_1.text_.text = var_47_39
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091011", "story_v_out_304091.awb") ~= 0 then
					local var_47_43 = manager.audio:GetVoiceLength("story_v_out_304091", "304091011", "story_v_out_304091.awb") / 1000

					if var_47_43 + var_47_35 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_43 + var_47_35
					end

					if var_47_38.prefab_name ~= "" and arg_44_1.actors_[var_47_38.prefab_name] ~= nil then
						local var_47_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_38.prefab_name].transform, "story_v_out_304091", "304091011", "story_v_out_304091.awb")

						arg_44_1:RecordAudio("304091011", var_47_44)
						arg_44_1:RecordAudio("304091011", var_47_44)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_304091", "304091011", "story_v_out_304091.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_304091", "304091011", "story_v_out_304091.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_45 = math.max(var_47_36, arg_44_1.talkMaxDuration)

			if var_47_35 <= arg_44_1.time_ and arg_44_1.time_ < var_47_35 + var_47_45 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_35) / var_47_45

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_35 + var_47_45 and arg_44_1.time_ < var_47_35 + var_47_45 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play304091012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 304091012
		arg_48_1.duration_ = 8.57

		local var_48_0 = {
			zh = 4.533,
			ja = 8.566
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
				arg_48_0:Play304091013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1019ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1019ui_story == nil then
				arg_48_1.var_.characterEffect1019ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1019ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1019ui_story then
				arg_48_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["10002ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect10002ui_story == nil then
				arg_48_1.var_.characterEffect10002ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.200000002980232

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect10002ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10002ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect10002ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10002ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0
			local var_51_11 = 0.55

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_12 = arg_48_1:FormatText(StoryNameCfg[13].name)

				arg_48_1.leftNameTxt_.text = var_51_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_13 = arg_48_1:GetWordFromCfg(304091012)
				local var_51_14 = arg_48_1:FormatText(var_51_13.content)

				arg_48_1.text_.text = var_51_14

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_15 = 22
				local var_51_16 = utf8.len(var_51_14)
				local var_51_17 = var_51_15 <= 0 and var_51_11 or var_51_11 * (var_51_16 / var_51_15)

				if var_51_17 > 0 and var_51_11 < var_51_17 then
					arg_48_1.talkMaxDuration = var_51_17

					if var_51_17 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_17 + var_51_10
					end
				end

				arg_48_1.text_.text = var_51_14
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091012", "story_v_out_304091.awb") ~= 0 then
					local var_51_18 = manager.audio:GetVoiceLength("story_v_out_304091", "304091012", "story_v_out_304091.awb") / 1000

					if var_51_18 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_10
					end

					if var_51_13.prefab_name ~= "" and arg_48_1.actors_[var_51_13.prefab_name] ~= nil then
						local var_51_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_13.prefab_name].transform, "story_v_out_304091", "304091012", "story_v_out_304091.awb")

						arg_48_1:RecordAudio("304091012", var_51_19)
						arg_48_1:RecordAudio("304091012", var_51_19)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_304091", "304091012", "story_v_out_304091.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_304091", "304091012", "story_v_out_304091.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_20 = math.max(var_51_11, arg_48_1.talkMaxDuration)

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_20 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_10) / var_51_20

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_10 + var_51_20 and arg_48_1.time_ < var_51_10 + var_51_20 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play304091013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 304091013
		arg_52_1.duration_ = 7.5

		local var_52_0 = {
			zh = 5.6,
			ja = 7.5
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
				arg_52_0:Play304091014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_55_2 = 0
			local var_55_3 = 0.675

			if var_55_2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_4 = arg_52_1:FormatText(StoryNameCfg[13].name)

				arg_52_1.leftNameTxt_.text = var_55_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_5 = arg_52_1:GetWordFromCfg(304091013)
				local var_55_6 = arg_52_1:FormatText(var_55_5.content)

				arg_52_1.text_.text = var_55_6

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_7 = 27
				local var_55_8 = utf8.len(var_55_6)
				local var_55_9 = var_55_7 <= 0 and var_55_3 or var_55_3 * (var_55_8 / var_55_7)

				if var_55_9 > 0 and var_55_3 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_2
					end
				end

				arg_52_1.text_.text = var_55_6
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091013", "story_v_out_304091.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_304091", "304091013", "story_v_out_304091.awb") / 1000

					if var_55_10 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_2
					end

					if var_55_5.prefab_name ~= "" and arg_52_1.actors_[var_55_5.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_5.prefab_name].transform, "story_v_out_304091", "304091013", "story_v_out_304091.awb")

						arg_52_1:RecordAudio("304091013", var_55_11)
						arg_52_1:RecordAudio("304091013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_304091", "304091013", "story_v_out_304091.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_304091", "304091013", "story_v_out_304091.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_3, arg_52_1.talkMaxDuration)

			if var_55_2 <= arg_52_1.time_ and arg_52_1.time_ < var_55_2 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_2) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_2 + var_55_12 and arg_52_1.time_ < var_55_2 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play304091014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 304091014
		arg_56_1.duration_ = 11.73

		local var_56_0 = {
			zh = 7.733,
			ja = 11.733
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
				arg_56_0:Play304091015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["3008ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect3008ui_story == nil then
				arg_56_1.var_.characterEffect3008ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect3008ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect3008ui_story then
				arg_56_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["1019ui_story"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1019ui_story == nil then
				arg_56_1.var_.characterEffect1019ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.200000002980232

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect1019ui_story and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1019ui_story.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1019ui_story then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1019ui_story.fillRatio = var_59_9
			end

			local var_59_10 = arg_56_1.actors_["10002ui_story"].transform
			local var_59_11 = 0

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1.var_.moveOldPos10002ui_story = var_59_10.localPosition
			end

			local var_59_12 = 0.001

			if var_59_11 <= arg_56_1.time_ and arg_56_1.time_ < var_59_11 + var_59_12 then
				local var_59_13 = (arg_56_1.time_ - var_59_11) / var_59_12
				local var_59_14 = Vector3.New(0, 100, 0)

				var_59_10.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10002ui_story, var_59_14, var_59_13)

				local var_59_15 = manager.ui.mainCamera.transform.position - var_59_10.position

				var_59_10.forward = Vector3.New(var_59_15.x, var_59_15.y, var_59_15.z)

				local var_59_16 = var_59_10.localEulerAngles

				var_59_16.z = 0
				var_59_16.x = 0
				var_59_10.localEulerAngles = var_59_16
			end

			if arg_56_1.time_ >= var_59_11 + var_59_12 and arg_56_1.time_ < var_59_11 + var_59_12 + arg_59_0 then
				var_59_10.localPosition = Vector3.New(0, 100, 0)

				local var_59_17 = manager.ui.mainCamera.transform.position - var_59_10.position

				var_59_10.forward = Vector3.New(var_59_17.x, var_59_17.y, var_59_17.z)

				local var_59_18 = var_59_10.localEulerAngles

				var_59_18.z = 0
				var_59_18.x = 0
				var_59_10.localEulerAngles = var_59_18
			end

			local var_59_19 = arg_56_1.actors_["1019ui_story"].transform
			local var_59_20 = 0

			if var_59_20 < arg_56_1.time_ and arg_56_1.time_ <= var_59_20 + arg_59_0 then
				arg_56_1.var_.moveOldPos1019ui_story = var_59_19.localPosition
			end

			local var_59_21 = 0.001

			if var_59_20 <= arg_56_1.time_ and arg_56_1.time_ < var_59_20 + var_59_21 then
				local var_59_22 = (arg_56_1.time_ - var_59_20) / var_59_21
				local var_59_23 = Vector3.New(0, 100, 0)

				var_59_19.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1019ui_story, var_59_23, var_59_22)

				local var_59_24 = manager.ui.mainCamera.transform.position - var_59_19.position

				var_59_19.forward = Vector3.New(var_59_24.x, var_59_24.y, var_59_24.z)

				local var_59_25 = var_59_19.localEulerAngles

				var_59_25.z = 0
				var_59_25.x = 0
				var_59_19.localEulerAngles = var_59_25
			end

			if arg_56_1.time_ >= var_59_20 + var_59_21 and arg_56_1.time_ < var_59_20 + var_59_21 + arg_59_0 then
				var_59_19.localPosition = Vector3.New(0, 100, 0)

				local var_59_26 = manager.ui.mainCamera.transform.position - var_59_19.position

				var_59_19.forward = Vector3.New(var_59_26.x, var_59_26.y, var_59_26.z)

				local var_59_27 = var_59_19.localEulerAngles

				var_59_27.z = 0
				var_59_27.x = 0
				var_59_19.localEulerAngles = var_59_27
			end

			local var_59_28 = arg_56_1.actors_["3008ui_story"].transform
			local var_59_29 = 0

			if var_59_29 < arg_56_1.time_ and arg_56_1.time_ <= var_59_29 + arg_59_0 then
				arg_56_1.var_.moveOldPos3008ui_story = var_59_28.localPosition
			end

			local var_59_30 = 0.001

			if var_59_29 <= arg_56_1.time_ and arg_56_1.time_ < var_59_29 + var_59_30 then
				local var_59_31 = (arg_56_1.time_ - var_59_29) / var_59_30
				local var_59_32 = Vector3.New(0, -1.51, -4.3)

				var_59_28.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos3008ui_story, var_59_32, var_59_31)

				local var_59_33 = manager.ui.mainCamera.transform.position - var_59_28.position

				var_59_28.forward = Vector3.New(var_59_33.x, var_59_33.y, var_59_33.z)

				local var_59_34 = var_59_28.localEulerAngles

				var_59_34.z = 0
				var_59_34.x = 0
				var_59_28.localEulerAngles = var_59_34
			end

			if arg_56_1.time_ >= var_59_29 + var_59_30 and arg_56_1.time_ < var_59_29 + var_59_30 + arg_59_0 then
				var_59_28.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_59_35 = manager.ui.mainCamera.transform.position - var_59_28.position

				var_59_28.forward = Vector3.New(var_59_35.x, var_59_35.y, var_59_35.z)

				local var_59_36 = var_59_28.localEulerAngles

				var_59_36.z = 0
				var_59_36.x = 0
				var_59_28.localEulerAngles = var_59_36
			end

			local var_59_37 = 0

			if var_59_37 < arg_56_1.time_ and arg_56_1.time_ <= var_59_37 + arg_59_0 then
				arg_56_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action5_2")
			end

			local var_59_38 = 0
			local var_59_39 = 0.875

			if var_59_38 < arg_56_1.time_ and arg_56_1.time_ <= var_59_38 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_40 = arg_56_1:FormatText(StoryNameCfg[20].name)

				arg_56_1.leftNameTxt_.text = var_59_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_41 = arg_56_1:GetWordFromCfg(304091014)
				local var_59_42 = arg_56_1:FormatText(var_59_41.content)

				arg_56_1.text_.text = var_59_42

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_43 = 35
				local var_59_44 = utf8.len(var_59_42)
				local var_59_45 = var_59_43 <= 0 and var_59_39 or var_59_39 * (var_59_44 / var_59_43)

				if var_59_45 > 0 and var_59_39 < var_59_45 then
					arg_56_1.talkMaxDuration = var_59_45

					if var_59_45 + var_59_38 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_45 + var_59_38
					end
				end

				arg_56_1.text_.text = var_59_42
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091014", "story_v_out_304091.awb") ~= 0 then
					local var_59_46 = manager.audio:GetVoiceLength("story_v_out_304091", "304091014", "story_v_out_304091.awb") / 1000

					if var_59_46 + var_59_38 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_46 + var_59_38
					end

					if var_59_41.prefab_name ~= "" and arg_56_1.actors_[var_59_41.prefab_name] ~= nil then
						local var_59_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_41.prefab_name].transform, "story_v_out_304091", "304091014", "story_v_out_304091.awb")

						arg_56_1:RecordAudio("304091014", var_59_47)
						arg_56_1:RecordAudio("304091014", var_59_47)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_304091", "304091014", "story_v_out_304091.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_304091", "304091014", "story_v_out_304091.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_48 = math.max(var_59_39, arg_56_1.talkMaxDuration)

			if var_59_38 <= arg_56_1.time_ and arg_56_1.time_ < var_59_38 + var_59_48 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_38) / var_59_48

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_38 + var_59_48 and arg_56_1.time_ < var_59_38 + var_59_48 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play304091015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 304091015
		arg_60_1.duration_ = 5.5

		local var_60_0 = {
			zh = 4.6,
			ja = 5.5
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
				arg_60_0:Play304091016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.6

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[20].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_3 = arg_60_1:GetWordFromCfg(304091015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091015", "story_v_out_304091.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_304091", "304091015", "story_v_out_304091.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_304091", "304091015", "story_v_out_304091.awb")

						arg_60_1:RecordAudio("304091015", var_63_9)
						arg_60_1:RecordAudio("304091015", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_304091", "304091015", "story_v_out_304091.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_304091", "304091015", "story_v_out_304091.awb")
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
	Play304091016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 304091016
		arg_64_1.duration_ = 6.9

		local var_64_0 = {
			zh = 6.9,
			ja = 5.033
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
				arg_64_0:Play304091017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10002ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos10002ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10002ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, 100, 0)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["1019ui_story"].transform
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.var_.moveOldPos1019ui_story = var_67_9.localPosition
			end

			local var_67_11 = 0.001

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_11 then
				local var_67_12 = (arg_64_1.time_ - var_67_10) / var_67_11
				local var_67_13 = Vector3.New(0, 100, 0)

				var_67_9.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1019ui_story, var_67_13, var_67_12)

				local var_67_14 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_14.x, var_67_14.y, var_67_14.z)

				local var_67_15 = var_67_9.localEulerAngles

				var_67_15.z = 0
				var_67_15.x = 0
				var_67_9.localEulerAngles = var_67_15
			end

			if arg_64_1.time_ >= var_67_10 + var_67_11 and arg_64_1.time_ < var_67_10 + var_67_11 + arg_67_0 then
				var_67_9.localPosition = Vector3.New(0, 100, 0)

				local var_67_16 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_16.x, var_67_16.y, var_67_16.z)

				local var_67_17 = var_67_9.localEulerAngles

				var_67_17.z = 0
				var_67_17.x = 0
				var_67_9.localEulerAngles = var_67_17
			end

			local var_67_18 = arg_64_1.actors_["3010ui_story"]
			local var_67_19 = 0

			if var_67_19 < arg_64_1.time_ and arg_64_1.time_ <= var_67_19 + arg_67_0 and not isNil(var_67_18) and arg_64_1.var_.characterEffect3010ui_story == nil then
				arg_64_1.var_.characterEffect3010ui_story = var_67_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_20 = 0.200000002980232

			if var_67_19 <= arg_64_1.time_ and arg_64_1.time_ < var_67_19 + var_67_20 and not isNil(var_67_18) then
				local var_67_21 = (arg_64_1.time_ - var_67_19) / var_67_20

				if arg_64_1.var_.characterEffect3010ui_story and not isNil(var_67_18) then
					arg_64_1.var_.characterEffect3010ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_19 + var_67_20 and arg_64_1.time_ < var_67_19 + var_67_20 + arg_67_0 and not isNil(var_67_18) and arg_64_1.var_.characterEffect3010ui_story then
				arg_64_1.var_.characterEffect3010ui_story.fillFlat = false
			end

			local var_67_22 = arg_64_1.actors_["3008ui_story"]
			local var_67_23 = 0

			if var_67_23 < arg_64_1.time_ and arg_64_1.time_ <= var_67_23 + arg_67_0 and not isNil(var_67_22) and arg_64_1.var_.characterEffect3008ui_story == nil then
				arg_64_1.var_.characterEffect3008ui_story = var_67_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_24 = 0.200000002980232

			if var_67_23 <= arg_64_1.time_ and arg_64_1.time_ < var_67_23 + var_67_24 and not isNil(var_67_22) then
				local var_67_25 = (arg_64_1.time_ - var_67_23) / var_67_24

				if arg_64_1.var_.characterEffect3008ui_story and not isNil(var_67_22) then
					local var_67_26 = Mathf.Lerp(0, 0.5, var_67_25)

					arg_64_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_64_1.var_.characterEffect3008ui_story.fillRatio = var_67_26
				end
			end

			if arg_64_1.time_ >= var_67_23 + var_67_24 and arg_64_1.time_ < var_67_23 + var_67_24 + arg_67_0 and not isNil(var_67_22) and arg_64_1.var_.characterEffect3008ui_story then
				local var_67_27 = 0.5

				arg_64_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_64_1.var_.characterEffect3008ui_story.fillRatio = var_67_27
			end

			local var_67_28 = 0
			local var_67_29 = 0.75

			if var_67_28 < arg_64_1.time_ and arg_64_1.time_ <= var_67_28 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_30 = arg_64_1:FormatText(StoryNameCfg[40].name)

				arg_64_1.leftNameTxt_.text = var_67_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3010")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_31 = arg_64_1:GetWordFromCfg(304091016)
				local var_67_32 = arg_64_1:FormatText(var_67_31.content)

				arg_64_1.text_.text = var_67_32

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_33 = 30
				local var_67_34 = utf8.len(var_67_32)
				local var_67_35 = var_67_33 <= 0 and var_67_29 or var_67_29 * (var_67_34 / var_67_33)

				if var_67_35 > 0 and var_67_29 < var_67_35 then
					arg_64_1.talkMaxDuration = var_67_35

					if var_67_35 + var_67_28 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_35 + var_67_28
					end
				end

				arg_64_1.text_.text = var_67_32
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091016", "story_v_out_304091.awb") ~= 0 then
					local var_67_36 = manager.audio:GetVoiceLength("story_v_out_304091", "304091016", "story_v_out_304091.awb") / 1000

					if var_67_36 + var_67_28 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_36 + var_67_28
					end

					if var_67_31.prefab_name ~= "" and arg_64_1.actors_[var_67_31.prefab_name] ~= nil then
						local var_67_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_31.prefab_name].transform, "story_v_out_304091", "304091016", "story_v_out_304091.awb")

						arg_64_1:RecordAudio("304091016", var_67_37)
						arg_64_1:RecordAudio("304091016", var_67_37)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_304091", "304091016", "story_v_out_304091.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_304091", "304091016", "story_v_out_304091.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_38 = math.max(var_67_29, arg_64_1.talkMaxDuration)

			if var_67_28 <= arg_64_1.time_ and arg_64_1.time_ < var_67_28 + var_67_38 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_28) / var_67_38

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_28 + var_67_38 and arg_64_1.time_ < var_67_28 + var_67_38 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play304091017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 304091017
		arg_68_1.duration_ = 5.47

		local var_68_0 = {
			zh = 4.133,
			ja = 5.466
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play304091018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["3008ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos3008ui_story = var_71_0.localPosition
			end

			local var_71_2 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(0, -1.51, -4.3)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos3008ui_story, var_71_4, var_71_3)

				local var_71_5 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_5.x, var_71_5.y, var_71_5.z)

				local var_71_6 = var_71_0.localEulerAngles

				var_71_6.z = 0
				var_71_6.x = 0
				var_71_0.localEulerAngles = var_71_6
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_71_7 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_7.x, var_71_7.y, var_71_7.z)

				local var_71_8 = var_71_0.localEulerAngles

				var_71_8.z = 0
				var_71_8.x = 0
				var_71_0.localEulerAngles = var_71_8
			end

			local var_71_9 = arg_68_1.actors_["3008ui_story"]
			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect3008ui_story == nil then
				arg_68_1.var_.characterEffect3008ui_story = var_71_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_11 = 0.200000002980232

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_11 and not isNil(var_71_9) then
				local var_71_12 = (arg_68_1.time_ - var_71_10) / var_71_11

				if arg_68_1.var_.characterEffect3008ui_story and not isNil(var_71_9) then
					arg_68_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_10 + var_71_11 and arg_68_1.time_ < var_71_10 + var_71_11 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect3008ui_story then
				arg_68_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_71_13 = arg_68_1.actors_["3010ui_story"]
			local var_71_14 = 0

			if var_71_14 < arg_68_1.time_ and arg_68_1.time_ <= var_71_14 + arg_71_0 and not isNil(var_71_13) and arg_68_1.var_.characterEffect3010ui_story == nil then
				arg_68_1.var_.characterEffect3010ui_story = var_71_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_15 = 0.200000002980232

			if var_71_14 <= arg_68_1.time_ and arg_68_1.time_ < var_71_14 + var_71_15 and not isNil(var_71_13) then
				local var_71_16 = (arg_68_1.time_ - var_71_14) / var_71_15

				if arg_68_1.var_.characterEffect3010ui_story and not isNil(var_71_13) then
					local var_71_17 = Mathf.Lerp(0, 0.5, var_71_16)

					arg_68_1.var_.characterEffect3010ui_story.fillFlat = true
					arg_68_1.var_.characterEffect3010ui_story.fillRatio = var_71_17
				end
			end

			if arg_68_1.time_ >= var_71_14 + var_71_15 and arg_68_1.time_ < var_71_14 + var_71_15 + arg_71_0 and not isNil(var_71_13) and arg_68_1.var_.characterEffect3010ui_story then
				local var_71_18 = 0.5

				arg_68_1.var_.characterEffect3010ui_story.fillFlat = true
				arg_68_1.var_.characterEffect3010ui_story.fillRatio = var_71_18
			end

			local var_71_19 = 0

			if var_71_19 < arg_68_1.time_ and arg_68_1.time_ <= var_71_19 + arg_71_0 then
				arg_68_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			local var_71_20 = 0

			if var_71_20 < arg_68_1.time_ and arg_68_1.time_ <= var_71_20 + arg_71_0 then
				arg_68_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_71_21 = 0
			local var_71_22 = 0.6

			if var_71_21 < arg_68_1.time_ and arg_68_1.time_ <= var_71_21 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_23 = arg_68_1:FormatText(StoryNameCfg[20].name)

				arg_68_1.leftNameTxt_.text = var_71_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_24 = arg_68_1:GetWordFromCfg(304091017)
				local var_71_25 = arg_68_1:FormatText(var_71_24.content)

				arg_68_1.text_.text = var_71_25

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_26 = 24
				local var_71_27 = utf8.len(var_71_25)
				local var_71_28 = var_71_26 <= 0 and var_71_22 or var_71_22 * (var_71_27 / var_71_26)

				if var_71_28 > 0 and var_71_22 < var_71_28 then
					arg_68_1.talkMaxDuration = var_71_28

					if var_71_28 + var_71_21 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_28 + var_71_21
					end
				end

				arg_68_1.text_.text = var_71_25
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091017", "story_v_out_304091.awb") ~= 0 then
					local var_71_29 = manager.audio:GetVoiceLength("story_v_out_304091", "304091017", "story_v_out_304091.awb") / 1000

					if var_71_29 + var_71_21 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_29 + var_71_21
					end

					if var_71_24.prefab_name ~= "" and arg_68_1.actors_[var_71_24.prefab_name] ~= nil then
						local var_71_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_24.prefab_name].transform, "story_v_out_304091", "304091017", "story_v_out_304091.awb")

						arg_68_1:RecordAudio("304091017", var_71_30)
						arg_68_1:RecordAudio("304091017", var_71_30)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_304091", "304091017", "story_v_out_304091.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_304091", "304091017", "story_v_out_304091.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_31 = math.max(var_71_22, arg_68_1.talkMaxDuration)

			if var_71_21 <= arg_68_1.time_ and arg_68_1.time_ < var_71_21 + var_71_31 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_21) / var_71_31

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_21 + var_71_31 and arg_68_1.time_ < var_71_21 + var_71_31 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play304091018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 304091018
		arg_72_1.duration_ = 3.6

		local var_72_0 = {
			zh = 2.7,
			ja = 3.6
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
			arg_72_1.auto_ = false
		end

		function arg_72_1.playNext_(arg_74_0)
			arg_72_1.onStoryFinished_()
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.35

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[20].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:GetWordFromCfg(304091018)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 14
				local var_75_6 = utf8.len(var_75_4)
				local var_75_7 = var_75_5 <= 0 and var_75_1 or var_75_1 * (var_75_6 / var_75_5)

				if var_75_7 > 0 and var_75_1 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304091", "304091018", "story_v_out_304091.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_304091", "304091018", "story_v_out_304091.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_304091", "304091018", "story_v_out_304091.awb")

						arg_72_1:RecordAudio("304091018", var_75_9)
						arg_72_1:RecordAudio("304091018", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_304091", "304091018", "story_v_out_304091.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_304091", "304091018", "story_v_out_304091.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_10 and arg_72_1.time_ < var_75_0 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B06"
	},
	voices = {
		"story_v_out_304091.awb"
	}
}
