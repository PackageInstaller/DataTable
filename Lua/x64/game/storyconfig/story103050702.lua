return {
	Play305072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 305072001
		arg_1_1.duration_ = 11.2

		local var_1_0 = {
			zh = 8.16633333333333,
			ja = 11.1993333333333
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
				arg_1_0:Play305072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B12"

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
				local var_4_5 = arg_1_1.bgs_.B12

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
					if iter_4_0 ~= "B12" then
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

			local var_4_24 = 0.2
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_4_28 = 1
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_v0_battleground", "bgm_story_v0_battleground", "bgm_story_v0_battleground.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_v0_battleground", "bgm_story_v0_battleground")

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

			local var_4_34 = 0
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 1.23333333333333
			local var_4_39 = 0.65

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_41 = arg_1_1:FormatText(StoryNameCfg[49].name)

				arg_1_1.leftNameTxt_.text = var_4_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_42 = arg_1_1:GetWordFromCfg(305072001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 26
				local var_4_45 = utf8.len(var_4_43)
				local var_4_46 = var_4_44 <= 0 and var_4_39 or var_4_39 * (var_4_45 / var_4_44)

				if var_4_46 > 0 and var_4_39 < var_4_46 then
					arg_1_1.talkMaxDuration = var_4_46
					var_4_38 = var_4_38 + 0.3

					if var_4_46 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_46 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_43
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072001", "story_v_out_305072.awb") ~= 0 then
					local var_4_47 = manager.audio:GetVoiceLength("story_v_out_305072", "305072001", "story_v_out_305072.awb") / 1000

					if var_4_47 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_38
					end

					if var_4_42.prefab_name ~= "" and arg_1_1.actors_[var_4_42.prefab_name] ~= nil then
						local var_4_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_42.prefab_name].transform, "story_v_out_305072", "305072001", "story_v_out_305072.awb")

						arg_1_1:RecordAudio("305072001", var_4_48)
						arg_1_1:RecordAudio("305072001", var_4_48)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_305072", "305072001", "story_v_out_305072.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_305072", "305072001", "story_v_out_305072.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_49 = var_4_38 + 0.3
			local var_4_50 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_49 <= arg_1_1.time_ and arg_1_1.time_ < var_4_49 + var_4_50 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_49) / var_4_50

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_49 + var_4_50 and arg_1_1.time_ < var_4_49 + var_4_50 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play305072002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 305072002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play305072003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.125

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[7].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:GetWordFromCfg(305072002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 5
				local var_11_6 = utf8.len(var_11_4)
				local var_11_7 = var_11_5 <= 0 and var_11_1 or var_11_1 * (var_11_6 / var_11_5)

				if var_11_7 > 0 and var_11_1 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_8 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_8 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_8

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_8 and arg_8_1.time_ < var_11_0 + var_11_8 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play305072003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 305072003
		arg_12_1.duration_ = 6.37

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play305072004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = manager.ui.mainCamera.transform
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				local var_15_2 = arg_12_1.var_.effect烦烦烦
				local var_15_3
				local var_15_4 = var_15_0

				if not var_15_2 then
					var_15_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in"), var_15_4)
					var_15_2.name = "烦烦烦"
					arg_12_1.var_.effect烦烦烦 = var_15_2
				else
					var_15_2.transform:SetParent(var_15_4)
				end

				var_15_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_15_5 = 1.7777777777777777
				local var_15_6 = Screen.width / Screen.height
				local var_15_7 = var_15_6 / var_15_5
				local var_15_8 = Mathf.Max(var_15_5 / var_15_6, 1)

				var_15_2.transform.localScale = Vector3.New(var_15_2.transform.localScale.x * var_15_7, var_15_2.transform.localScale.y * var_15_8, var_15_2.transform.localScale.z)
			end

			local var_15_9 = 0

			if var_15_9 < arg_12_1.time_ and arg_12_1.time_ <= var_15_9 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			local var_15_10 = 2

			if arg_12_1.time_ >= var_15_9 + var_15_10 and arg_12_1.time_ < var_15_9 + var_15_10 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_11 = 1.36666666666667
			local var_15_12 = 1.2

			if var_15_11 < arg_12_1.time_ and arg_12_1.time_ <= var_15_11 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_13 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_13:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_14 = arg_12_1:GetWordFromCfg(305072003)
				local var_15_15 = arg_12_1:FormatText(var_15_14.content)

				arg_12_1.text_.text = var_15_15

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_16 = 48
				local var_15_17 = utf8.len(var_15_15)
				local var_15_18 = var_15_16 <= 0 and var_15_12 or var_15_12 * (var_15_17 / var_15_16)

				if var_15_18 > 0 and var_15_12 < var_15_18 then
					arg_12_1.talkMaxDuration = var_15_18
					var_15_11 = var_15_11 + 0.3

					if var_15_18 + var_15_11 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_18 + var_15_11
					end
				end

				arg_12_1.text_.text = var_15_15
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_19 = var_15_11 + 0.3
			local var_15_20 = math.max(var_15_12, arg_12_1.talkMaxDuration)

			if var_15_19 <= arg_12_1.time_ and arg_12_1.time_ < var_15_19 + var_15_20 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_19) / var_15_20

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_19 + var_15_20 and arg_12_1.time_ < var_15_19 + var_15_20 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 2,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.56666666666667,
				amplitudeGain = 0.4,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play305072004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 305072004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play305072005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0.2
			local var_21_1 = 1

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				local var_21_2 = "play"
				local var_21_3 = "effect"

				arg_18_1:AudioAction(var_21_2, var_21_3, "se_story_152", "se_story_152_metal", "")
			end

			local var_21_4 = 0
			local var_21_5 = 1.275

			if var_21_4 < arg_18_1.time_ and arg_18_1.time_ <= var_21_4 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_6 = arg_18_1:GetWordFromCfg(305072004)
				local var_21_7 = arg_18_1:FormatText(var_21_6.content)

				arg_18_1.text_.text = var_21_7

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_8 = 51
				local var_21_9 = utf8.len(var_21_7)
				local var_21_10 = var_21_8 <= 0 and var_21_5 or var_21_5 * (var_21_9 / var_21_8)

				if var_21_10 > 0 and var_21_5 < var_21_10 then
					arg_18_1.talkMaxDuration = var_21_10

					if var_21_10 + var_21_4 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_10 + var_21_4
					end
				end

				arg_18_1.text_.text = var_21_7
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_11 = math.max(var_21_5, arg_18_1.talkMaxDuration)

			if var_21_4 <= arg_18_1.time_ and arg_18_1.time_ < var_21_4 + var_21_11 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_4) / var_21_11

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_4 + var_21_11 and arg_18_1.time_ < var_21_4 + var_21_11 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play305072005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 305072005
		arg_22_1.duration_ = 13.53

		local var_22_0 = {
			zh = 10.433,
			ja = 13.533
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
				arg_22_0:Play305072006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0
			local var_25_1 = 0.7

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_2 = arg_22_1:FormatText(StoryNameCfg[49].name)

				arg_22_1.leftNameTxt_.text = var_25_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_3 = arg_22_1:GetWordFromCfg(305072005)
				local var_25_4 = arg_22_1:FormatText(var_25_3.content)

				arg_22_1.text_.text = var_25_4

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_5 = 28
				local var_25_6 = utf8.len(var_25_4)
				local var_25_7 = var_25_5 <= 0 and var_25_1 or var_25_1 * (var_25_6 / var_25_5)

				if var_25_7 > 0 and var_25_1 < var_25_7 then
					arg_22_1.talkMaxDuration = var_25_7

					if var_25_7 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_0
					end
				end

				arg_22_1.text_.text = var_25_4
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072005", "story_v_out_305072.awb") ~= 0 then
					local var_25_8 = manager.audio:GetVoiceLength("story_v_out_305072", "305072005", "story_v_out_305072.awb") / 1000

					if var_25_8 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_8 + var_25_0
					end

					if var_25_3.prefab_name ~= "" and arg_22_1.actors_[var_25_3.prefab_name] ~= nil then
						local var_25_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_3.prefab_name].transform, "story_v_out_305072", "305072005", "story_v_out_305072.awb")

						arg_22_1:RecordAudio("305072005", var_25_9)
						arg_22_1:RecordAudio("305072005", var_25_9)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_305072", "305072005", "story_v_out_305072.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_305072", "305072005", "story_v_out_305072.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_10 = math.max(var_25_1, arg_22_1.talkMaxDuration)

			if var_25_0 <= arg_22_1.time_ and arg_22_1.time_ < var_25_0 + var_25_10 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_0) / var_25_10

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_0 + var_25_10 and arg_22_1.time_ < var_25_0 + var_25_10 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play305072006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 305072006
		arg_26_1.duration_ = 7.7

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play305072007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = "S0505"

			if arg_26_1.bgs_[var_29_0] == nil then
				local var_29_1 = Object.Instantiate(arg_26_1.paintGo_)

				var_29_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_29_0)
				var_29_1.name = var_29_0
				var_29_1.transform.parent = arg_26_1.stage_.transform
				var_29_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_26_1.bgs_[var_29_0] = var_29_1
			end

			local var_29_2 = 0.7

			if var_29_2 < arg_26_1.time_ and arg_26_1.time_ <= var_29_2 + arg_29_0 then
				local var_29_3 = manager.ui.mainCamera.transform.localPosition
				local var_29_4 = Vector3.New(0, 0, 10) + Vector3.New(var_29_3.x, var_29_3.y, 0)
				local var_29_5 = arg_26_1.bgs_.S0505

				var_29_5.transform.localPosition = var_29_4
				var_29_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_29_6 = var_29_5:GetComponent("SpriteRenderer")

				if var_29_6 and var_29_6.sprite then
					local var_29_7 = (var_29_5.transform.localPosition - var_29_3).z
					local var_29_8 = manager.ui.mainCameraCom_
					local var_29_9 = 2 * var_29_7 * Mathf.Tan(var_29_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_29_10 = var_29_9 * var_29_8.aspect
					local var_29_11 = var_29_6.sprite.bounds.size.x
					local var_29_12 = var_29_6.sprite.bounds.size.y
					local var_29_13 = var_29_10 / var_29_11
					local var_29_14 = var_29_9 / var_29_12
					local var_29_15 = var_29_14 < var_29_13 and var_29_13 or var_29_14

					var_29_5.transform.localScale = Vector3.New(var_29_15, var_29_15, 0)
				end

				for iter_29_0, iter_29_1 in pairs(arg_26_1.bgs_) do
					if iter_29_0 ~= "S0505" then
						iter_29_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_29_16 = 0

			if var_29_16 < arg_26_1.time_ and arg_26_1.time_ <= var_29_16 + arg_29_0 then
				arg_26_1.allBtn_.enabled = false
			end

			local var_29_17 = 0.3

			if arg_26_1.time_ >= var_29_16 + var_29_17 and arg_26_1.time_ < var_29_16 + var_29_17 + arg_29_0 then
				arg_26_1.allBtn_.enabled = true
			end

			local var_29_18 = 0

			if var_29_18 < arg_26_1.time_ and arg_26_1.time_ <= var_29_18 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_19 = 0.7

			if var_29_18 <= arg_26_1.time_ and arg_26_1.time_ < var_29_18 + var_29_19 then
				local var_29_20 = (arg_26_1.time_ - var_29_18) / var_29_19
				local var_29_21 = Color.New(0, 0, 0)

				var_29_21.a = Mathf.Lerp(0, 1, var_29_20)
				arg_26_1.mask_.color = var_29_21
			end

			if arg_26_1.time_ >= var_29_18 + var_29_19 and arg_26_1.time_ < var_29_18 + var_29_19 + arg_29_0 then
				local var_29_22 = Color.New(0, 0, 0)

				var_29_22.a = 1
				arg_26_1.mask_.color = var_29_22
			end

			local var_29_23 = 0.7

			if var_29_23 < arg_26_1.time_ and arg_26_1.time_ <= var_29_23 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_24 = 1.56666666666667

			if var_29_23 <= arg_26_1.time_ and arg_26_1.time_ < var_29_23 + var_29_24 then
				local var_29_25 = (arg_26_1.time_ - var_29_23) / var_29_24
				local var_29_26 = Color.New(0, 0, 0)

				var_29_26.a = Mathf.Lerp(1, 0, var_29_25)
				arg_26_1.mask_.color = var_29_26
			end

			if arg_26_1.time_ >= var_29_23 + var_29_24 and arg_26_1.time_ < var_29_23 + var_29_24 + arg_29_0 then
				local var_29_27 = Color.New(0, 0, 0)
				local var_29_28 = 0

				arg_26_1.mask_.enabled = false
				var_29_27.a = var_29_28
				arg_26_1.mask_.color = var_29_27
			end

			local var_29_29 = manager.ui.mainCamera.transform
			local var_29_30 = 0.766666666666667

			if var_29_30 < arg_26_1.time_ and arg_26_1.time_ <= var_29_30 + arg_29_0 then
				local var_29_31 = arg_26_1.var_.effect热热
				local var_29_32
				local var_29_33 = var_29_29

				if not var_29_31 then
					var_29_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning_1"), var_29_33)
					var_29_31.name = "热热"
					arg_26_1.var_.effect热热 = var_29_31
				else
					var_29_31.transform:SetParent(var_29_33)
				end

				var_29_31.transform.localPosition = Vector3.New(0, 0, -0.01)
				var_29_31.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_29_34 = 1.7777777777777777
				local var_29_35 = Screen.width / Screen.height
				local var_29_36 = var_29_35 / var_29_34
				local var_29_37 = Mathf.Max(var_29_34 / var_29_35, 1)

				var_29_31.transform.localScale = Vector3.New(var_29_31.transform.localScale.x * var_29_36, var_29_31.transform.localScale.y * var_29_37, var_29_31.transform.localScale.z)
			end

			local var_29_38 = arg_26_1.bgs_.S0505.transform
			local var_29_39 = 0.7

			if var_29_39 < arg_26_1.time_ and arg_26_1.time_ <= var_29_39 + arg_29_0 then
				arg_26_1.var_.moveOldPosS0505 = var_29_38.localPosition
			end

			local var_29_40 = 1.76666666666667

			if var_29_39 <= arg_26_1.time_ and arg_26_1.time_ < var_29_39 + var_29_40 then
				local var_29_41 = (arg_26_1.time_ - var_29_39) / var_29_40
				local var_29_42 = Vector3.New(0, 1, 9.59)

				var_29_38.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPosS0505, var_29_42, var_29_41)
			end

			if arg_26_1.time_ >= var_29_39 + var_29_40 and arg_26_1.time_ < var_29_39 + var_29_40 + arg_29_0 then
				var_29_38.localPosition = Vector3.New(0, 1, 9.59)
			end

			local var_29_43 = manager.ui.mainCamera.transform
			local var_29_44 = 0.7

			if var_29_44 < arg_26_1.time_ and arg_26_1.time_ <= var_29_44 + arg_29_0 then
				local var_29_45 = arg_26_1.var_.effect烦烦烦

				if var_29_45 then
					Object.Destroy(var_29_45)

					arg_26_1.var_.effect烦烦烦 = nil
				end
			end

			local var_29_46 = 0.6
			local var_29_47 = 1

			if var_29_46 < arg_26_1.time_ and arg_26_1.time_ <= var_29_46 + arg_29_0 then
				local var_29_48 = "play"
				local var_29_49 = "effect"

				arg_26_1:AudioAction(var_29_48, var_29_49, "se_story_143", "se_story_143_organic02", "")
			end

			if arg_26_1.frameCnt_ <= 1 then
				arg_26_1.dialog_:SetActive(false)
			end

			local var_29_50 = 2.7
			local var_29_51 = 0.75

			if var_29_50 < arg_26_1.time_ and arg_26_1.time_ <= var_29_50 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				arg_26_1.dialog_:SetActive(true)

				arg_26_1.dialogCg_.alpha = 0

				local var_29_52 = LeanTween.value(arg_26_1.dialog_, 0, 1, 0.3)

				var_29_52:setOnUpdate(LuaHelper.FloatAction(function(arg_30_0)
					arg_26_1.dialogCg_.alpha = arg_30_0
				end))
				var_29_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_26_1.dialog_)
					var_29_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_26_1.duration_ = arg_26_1.duration_ + 0.3

				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_53 = arg_26_1:GetWordFromCfg(305072006)
				local var_29_54 = arg_26_1:FormatText(var_29_53.content)

				arg_26_1.text_.text = var_29_54

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_55 = 30
				local var_29_56 = utf8.len(var_29_54)
				local var_29_57 = var_29_55 <= 0 and var_29_51 or var_29_51 * (var_29_56 / var_29_55)

				if var_29_57 > 0 and var_29_51 < var_29_57 then
					arg_26_1.talkMaxDuration = var_29_57
					var_29_50 = var_29_50 + 0.3

					if var_29_57 + var_29_50 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_57 + var_29_50
					end
				end

				arg_26_1.text_.text = var_29_54
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_58 = var_29_50 + 0.3
			local var_29_59 = math.max(var_29_51, arg_26_1.talkMaxDuration)

			if var_29_58 <= arg_26_1.time_ and arg_26_1.time_ < var_29_58 + var_29_59 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_58) / var_29_59

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_58 + var_29_59 and arg_26_1.time_ < var_29_58 + var_29_59 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "S0505",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.76666666666667,
				startTime = 0.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1.75, 5.23),
					endPos = Vector3.New(0, 1, 9.59),
					easeType = LeanTweenType.easeInOutQuart
				}
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play305072007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 305072007
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play305072008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 1.225

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_2 = arg_32_1:GetWordFromCfg(305072007)
				local var_35_3 = arg_32_1:FormatText(var_35_2.content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 49
				local var_35_5 = utf8.len(var_35_3)
				local var_35_6 = var_35_4 <= 0 and var_35_1 or var_35_1 * (var_35_5 / var_35_4)

				if var_35_6 > 0 and var_35_1 < var_35_6 then
					arg_32_1.talkMaxDuration = var_35_6

					if var_35_6 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_7 and arg_32_1.time_ < var_35_0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play305072008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 305072008
		arg_36_1.duration_ = 1.33

		local var_36_0 = {
			zh = 1.3,
			ja = 1.333
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
				arg_36_0:Play305072009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = "1084ui_story"

			if arg_36_1.actors_[var_39_0] == nil then
				local var_39_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_39_1) then
					local var_39_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_36_1.stage_.transform)

					var_39_2.name = var_39_0
					var_39_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_36_1.actors_[var_39_0] = var_39_2

					local var_39_3 = var_39_2:GetComponentInChildren(typeof(CharacterEffect))

					var_39_3.enabled = true

					local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_2, typeof(DynamicBoneHelper))

					if var_39_4 then
						var_39_4:EnableDynamicBone(false)
					end

					arg_36_1:ShowWeapon(var_39_3.transform, false)

					arg_36_1.var_[var_39_0 .. "Animator"] = var_39_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_36_1.var_[var_39_0 .. "Animator"].applyRootMotion = true
					arg_36_1.var_[var_39_0 .. "LipSync"] = var_39_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_39_5 = arg_36_1.actors_["1084ui_story"]
			local var_39_6 = 0

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_7 = 0.200000002980232

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_7 and not isNil(var_39_5) then
				local var_39_8 = (arg_36_1.time_ - var_39_6) / var_39_7

				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_5) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_6 + var_39_7 and arg_36_1.time_ < var_39_6 + var_39_7 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_39_9 = 0
			local var_39_10 = 0.1

			if var_39_9 < arg_36_1.time_ and arg_36_1.time_ <= var_39_9 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_11 = arg_36_1:FormatText(StoryNameCfg[6].name)

				arg_36_1.leftNameTxt_.text = var_39_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_12 = arg_36_1:GetWordFromCfg(305072008)
				local var_39_13 = arg_36_1:FormatText(var_39_12.content)

				arg_36_1.text_.text = var_39_13

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_14 = 4
				local var_39_15 = utf8.len(var_39_13)
				local var_39_16 = var_39_14 <= 0 and var_39_10 or var_39_10 * (var_39_15 / var_39_14)

				if var_39_16 > 0 and var_39_10 < var_39_16 then
					arg_36_1.talkMaxDuration = var_39_16

					if var_39_16 + var_39_9 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_16 + var_39_9
					end
				end

				arg_36_1.text_.text = var_39_13
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072008", "story_v_out_305072.awb") ~= 0 then
					local var_39_17 = manager.audio:GetVoiceLength("story_v_out_305072", "305072008", "story_v_out_305072.awb") / 1000

					if var_39_17 + var_39_9 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_17 + var_39_9
					end

					if var_39_12.prefab_name ~= "" and arg_36_1.actors_[var_39_12.prefab_name] ~= nil then
						local var_39_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_12.prefab_name].transform, "story_v_out_305072", "305072008", "story_v_out_305072.awb")

						arg_36_1:RecordAudio("305072008", var_39_18)
						arg_36_1:RecordAudio("305072008", var_39_18)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_305072", "305072008", "story_v_out_305072.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_305072", "305072008", "story_v_out_305072.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_19 = math.max(var_39_10, arg_36_1.talkMaxDuration)

			if var_39_9 <= arg_36_1.time_ and arg_36_1.time_ < var_39_9 + var_39_19 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_9) / var_39_19

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_9 + var_39_19 and arg_36_1.time_ < var_39_9 + var_39_19 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play305072009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 305072009
		arg_40_1.duration_ = 6.53

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play305072010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1084ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1084ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1084ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1084ui_story.fillRatio = var_43_5
			end

			local var_43_6 = manager.ui.mainCamera.transform
			local var_43_7 = 0

			if var_43_7 < arg_40_1.time_ and arg_40_1.time_ <= var_43_7 + arg_43_0 then
				local var_43_8 = arg_40_1.var_.effectsssfsssf
				local var_43_9
				local var_43_10 = var_43_6

				if not var_43_8 then
					var_43_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boguang"), var_43_10)
					var_43_8.name = "sssf"
					arg_40_1.var_.effectsssfsssf = var_43_8
				else
					var_43_8.transform:SetParent(var_43_10)
				end

				var_43_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_43_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_43_11 = 1.7777777777777777
				local var_43_12 = Screen.width / Screen.height
				local var_43_13 = var_43_12 / var_43_11
				local var_43_14 = Mathf.Max(var_43_11 / var_43_12, 1)

				var_43_8.transform.localScale = Vector3.New(var_43_8.transform.localScale.x * var_43_13, var_43_8.transform.localScale.y * var_43_14, var_43_8.transform.localScale.z)
			end

			local var_43_15 = manager.ui.mainCamera.transform
			local var_43_16 = 1.28333333333333

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				local var_43_17 = arg_40_1.var_.effectsssfsssf

				if var_43_17 then
					Object.Destroy(var_43_17)

					arg_40_1.var_.effectsssfsssf = nil
				end
			end

			local var_43_18 = manager.ui.mainCamera.transform
			local var_43_19 = 0

			if var_43_19 < arg_40_1.time_ and arg_40_1.time_ <= var_43_19 + arg_43_0 then
				local var_43_20 = arg_40_1.var_.effect13233
				local var_43_21
				local var_43_22 = var_43_18

				if not var_43_20 then
					var_43_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang05"), var_43_22)
					var_43_20.name = "13233"
					arg_40_1.var_.effect13233 = var_43_20
				else
					var_43_20.transform:SetParent(var_43_22)
				end

				var_43_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_43_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_43_23 = manager.ui.mainCamera.transform
			local var_43_24 = 2.5

			if var_43_24 < arg_40_1.time_ and arg_40_1.time_ <= var_43_24 + arg_43_0 then
				local var_43_25 = arg_40_1.var_.effect13233

				if var_43_25 then
					Object.Destroy(var_43_25)

					arg_40_1.var_.effect13233 = nil
				end
			end

			local var_43_26 = 0

			if var_43_26 < arg_40_1.time_ and arg_40_1.time_ <= var_43_26 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			local var_43_27 = 3.275

			if arg_40_1.time_ >= var_43_26 + var_43_27 and arg_40_1.time_ < var_43_26 + var_43_27 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end

			local var_43_28 = 0.723045398015529

			if var_43_28 < arg_40_1.time_ and arg_40_1.time_ <= var_43_28 + arg_43_0 then
				arg_40_1.mask_.enabled = true
				arg_40_1.mask_.raycastTarget = true

				arg_40_1:SetGaussion(false)
			end

			local var_43_29 = 0.443621268651138

			if var_43_28 <= arg_40_1.time_ and arg_40_1.time_ < var_43_28 + var_43_29 then
				local var_43_30 = (arg_40_1.time_ - var_43_28) / var_43_29
				local var_43_31 = Color.New(1, 1, 1)

				var_43_31.a = Mathf.Lerp(1, 0, var_43_30)
				arg_40_1.mask_.color = var_43_31
			end

			if arg_40_1.time_ >= var_43_28 + var_43_29 and arg_40_1.time_ < var_43_28 + var_43_29 + arg_43_0 then
				local var_43_32 = Color.New(1, 1, 1)
				local var_43_33 = 0

				arg_40_1.mask_.enabled = false
				var_43_32.a = var_43_33
				arg_40_1.mask_.color = var_43_32
			end

			if arg_40_1.frameCnt_ <= 1 then
				arg_40_1.dialog_:SetActive(false)
			end

			local var_43_34 = 1.53333333333333
			local var_43_35 = 1.275

			if var_43_34 < arg_40_1.time_ and arg_40_1.time_ <= var_43_34 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				arg_40_1.dialog_:SetActive(true)

				arg_40_1.dialogCg_.alpha = 0

				local var_43_36 = LeanTween.value(arg_40_1.dialog_, 0, 1, 0.3)

				var_43_36:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_40_1.dialogCg_.alpha = arg_44_0
				end))
				var_43_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_40_1.dialog_)
					var_43_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_40_1.duration_ = arg_40_1.duration_ + 0.3

				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_37 = arg_40_1:GetWordFromCfg(305072009)
				local var_43_38 = arg_40_1:FormatText(var_43_37.content)

				arg_40_1.text_.text = var_43_38

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_39 = 51
				local var_43_40 = utf8.len(var_43_38)
				local var_43_41 = var_43_39 <= 0 and var_43_35 or var_43_35 * (var_43_40 / var_43_39)

				if var_43_41 > 0 and var_43_35 < var_43_41 then
					arg_40_1.talkMaxDuration = var_43_41
					var_43_34 = var_43_34 + 0.3

					if var_43_41 + var_43_34 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_41 + var_43_34
					end
				end

				arg_40_1.text_.text = var_43_38
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_42 = var_43_34 + 0.3
			local var_43_43 = math.max(var_43_35, arg_40_1.talkMaxDuration)

			if var_43_42 <= arg_40_1.time_ and arg_40_1.time_ < var_43_42 + var_43_43 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_42) / var_43_43

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_42 + var_43_43 and arg_40_1.time_ < var_43_42 + var_43_43 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 2,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D Wobble",
				duration = 1.76666666368643,
				amplitudeGain = 0.1,
				startTime = 0.733333336313565,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play305072010 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 305072010
		arg_46_1.duration_ = 5.91

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play305072011(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = manager.ui.mainCamera.transform
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				local var_49_2 = arg_46_1.var_.effect刚刚
				local var_49_3
				local var_49_4 = var_49_0

				if not var_49_2 then
					var_49_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_explosion"), var_49_4)
					var_49_2.name = "刚刚"
					arg_46_1.var_.effect刚刚 = var_49_2
				else
					var_49_2.transform:SetParent(var_49_4)
				end

				var_49_2.transform.localPosition = Vector3.New(-0.75, 0.1, -3.27)
				var_49_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_49_5 = 1.7777777777777777
				local var_49_6 = Screen.width / Screen.height
				local var_49_7 = var_49_6 / var_49_5
				local var_49_8 = Mathf.Max(var_49_5 / var_49_6, 1)

				var_49_2.transform.localScale = Vector3.New(var_49_2.transform.localScale.x * var_49_7, var_49_2.transform.localScale.y * var_49_8, var_49_2.transform.localScale.z)
			end

			local var_49_9 = manager.ui.mainCamera.transform
			local var_49_10 = 1.9

			if var_49_10 < arg_46_1.time_ and arg_46_1.time_ <= var_49_10 + arg_49_0 then
				local var_49_11 = arg_46_1.var_.effect刚刚

				if var_49_11 then
					Object.Destroy(var_49_11)

					arg_46_1.var_.effect刚刚 = nil
				end
			end

			local var_49_12 = manager.ui.mainCamera.transform
			local var_49_13 = 0.3

			if var_49_13 < arg_46_1.time_ and arg_46_1.time_ <= var_49_13 + arg_49_0 then
				local var_49_14 = arg_46_1.var_.effect刚刚1
				local var_49_15
				local var_49_16 = var_49_12

				if not var_49_14 then
					var_49_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_explosion"), var_49_16)
					var_49_14.name = "刚刚1"
					arg_46_1.var_.effect刚刚1 = var_49_14
				else
					var_49_14.transform:SetParent(var_49_16)
				end

				var_49_14.transform.localPosition = Vector3.New(0.99, -1.39, -2.62)
				var_49_14.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_49_17 = 1.7777777777777777
				local var_49_18 = Screen.width / Screen.height
				local var_49_19 = var_49_18 / var_49_17
				local var_49_20 = Mathf.Max(var_49_17 / var_49_18, 1)

				var_49_14.transform.localScale = Vector3.New(var_49_14.transform.localScale.x * var_49_19, var_49_14.transform.localScale.y * var_49_20, var_49_14.transform.localScale.z)
			end

			local var_49_21 = manager.ui.mainCamera.transform
			local var_49_22 = 2.4

			if var_49_22 < arg_46_1.time_ and arg_46_1.time_ <= var_49_22 + arg_49_0 then
				local var_49_23 = arg_46_1.var_.effect刚刚1

				if var_49_23 then
					Object.Destroy(var_49_23)

					arg_46_1.var_.effect刚刚1 = nil
				end
			end

			local var_49_24 = 0

			if var_49_24 < arg_46_1.time_ and arg_46_1.time_ <= var_49_24 + arg_49_0 then
				arg_46_1.allBtn_.enabled = false
			end

			local var_49_25 = 1.46666666666667

			if arg_46_1.time_ >= var_49_24 + var_49_25 and arg_46_1.time_ < var_49_24 + var_49_25 + arg_49_0 then
				arg_46_1.allBtn_.enabled = true
			end

			local var_49_26 = 0.2
			local var_49_27 = 1

			if var_49_26 < arg_46_1.time_ and arg_46_1.time_ <= var_49_26 + arg_49_0 then
				local var_49_28 = "play"
				local var_49_29 = "effect"

				arg_46_1:AudioAction(var_49_28, var_49_29, "se_story_152", "se_story_152_attack", "")
			end

			if arg_46_1.frameCnt_ <= 1 then
				arg_46_1.dialog_:SetActive(false)
			end

			local var_49_30 = 0.912192109506577
			local var_49_31 = 1.6

			if var_49_30 < arg_46_1.time_ and arg_46_1.time_ <= var_49_30 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				arg_46_1.dialog_:SetActive(true)

				arg_46_1.dialogCg_.alpha = 0

				local var_49_32 = LeanTween.value(arg_46_1.dialog_, 0, 1, 0.3)

				var_49_32:setOnUpdate(LuaHelper.FloatAction(function(arg_50_0)
					arg_46_1.dialogCg_.alpha = arg_50_0
				end))
				var_49_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_46_1.dialog_)
					var_49_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_46_1.duration_ = arg_46_1.duration_ + 0.3

				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_33 = arg_46_1:GetWordFromCfg(305072010)
				local var_49_34 = arg_46_1:FormatText(var_49_33.content)

				arg_46_1.text_.text = var_49_34

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_35 = 64
				local var_49_36 = utf8.len(var_49_34)
				local var_49_37 = var_49_35 <= 0 and var_49_31 or var_49_31 * (var_49_36 / var_49_35)

				if var_49_37 > 0 and var_49_31 < var_49_37 then
					arg_46_1.talkMaxDuration = var_49_37
					var_49_30 = var_49_30 + 0.3

					if var_49_37 + var_49_30 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_37 + var_49_30
					end
				end

				arg_46_1.text_.text = var_49_34
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_38 = var_49_30 + 0.3
			local var_49_39 = math.max(var_49_31, arg_46_1.talkMaxDuration)

			if var_49_38 <= arg_46_1.time_ and arg_46_1.time_ < var_49_38 + var_49_39 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_38) / var_49_39

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_38 + var_49_39 and arg_46_1.time_ < var_49_38 + var_49_39 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play305072011 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 305072011
		arg_52_1.duration_ = 21.07

		local var_52_0 = {
			zh = 10.133,
			ja = 21.066
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
				arg_52_0:Play305072012(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.9

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[49].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_3 = arg_52_1:GetWordFromCfg(305072011)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072011", "story_v_out_305072.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_305072", "305072011", "story_v_out_305072.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_305072", "305072011", "story_v_out_305072.awb")

						arg_52_1:RecordAudio("305072011", var_55_9)
						arg_52_1:RecordAudio("305072011", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_305072", "305072011", "story_v_out_305072.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_305072", "305072011", "story_v_out_305072.awb")
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
	Play305072012 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 305072012
		arg_56_1.duration_ = 6.2

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play305072013(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = manager.ui.mainCamera.transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				local var_59_2 = arg_56_1.var_.effect烦烦烦
				local var_59_3
				local var_59_4 = var_59_0

				if not var_59_2 then
					var_59_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error03_keep"), var_59_4)
					var_59_2.name = "烦烦烦"
					arg_56_1.var_.effect烦烦烦 = var_59_2
				else
					var_59_2.transform:SetParent(var_59_4)
				end

				var_59_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_59_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_59_5 = 1.7777777777777777
				local var_59_6 = Screen.width / Screen.height
				local var_59_7 = var_59_6 / var_59_5
				local var_59_8 = Mathf.Max(var_59_5 / var_59_6, 1)

				var_59_2.transform.localScale = Vector3.New(var_59_2.transform.localScale.x * var_59_7, var_59_2.transform.localScale.y * var_59_8, var_59_2.transform.localScale.z)
			end

			local var_59_9 = 0

			if var_59_9 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 then
				arg_56_1.allBtn_.enabled = false
			end

			local var_59_10 = 1.46666666666667

			if arg_56_1.time_ >= var_59_9 + var_59_10 and arg_56_1.time_ < var_59_9 + var_59_10 + arg_59_0 then
				arg_56_1.allBtn_.enabled = true
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_11 = 1.2
			local var_59_12 = 1.4

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_13 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_13:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_14 = arg_56_1:GetWordFromCfg(305072012)
				local var_59_15 = arg_56_1:FormatText(var_59_14.content)

				arg_56_1.text_.text = var_59_15

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_16 = 56
				local var_59_17 = utf8.len(var_59_15)
				local var_59_18 = var_59_16 <= 0 and var_59_12 or var_59_12 * (var_59_17 / var_59_16)

				if var_59_18 > 0 and var_59_12 < var_59_18 then
					arg_56_1.talkMaxDuration = var_59_18
					var_59_11 = var_59_11 + 0.3

					if var_59_18 + var_59_11 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_11
					end
				end

				arg_56_1.text_.text = var_59_15
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_19 = var_59_11 + 0.3
			local var_59_20 = math.max(var_59_12, arg_56_1.talkMaxDuration)

			if var_59_19 <= arg_56_1.time_ and arg_56_1.time_ < var_59_19 + var_59_20 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_19) / var_59_20

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_19 + var_59_20 and arg_56_1.time_ < var_59_19 + var_59_20 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play305072013 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 305072013
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play305072014(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 1.525

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_2 = arg_62_1:GetWordFromCfg(305072013)
				local var_65_3 = arg_62_1:FormatText(var_65_2.content)

				arg_62_1.text_.text = var_65_3

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 61
				local var_65_5 = utf8.len(var_65_3)
				local var_65_6 = var_65_4 <= 0 and var_65_1 or var_65_1 * (var_65_5 / var_65_4)

				if var_65_6 > 0 and var_65_1 < var_65_6 then
					arg_62_1.talkMaxDuration = var_65_6

					if var_65_6 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_6 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_3
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_7 and arg_62_1.time_ < var_65_0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play305072014 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 305072014
		arg_66_1.duration_ = 2.97

		local var_66_0 = {
			zh = 2.233,
			ja = 2.966
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play305072015(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = "1019ui_story"

			if arg_66_1.actors_[var_69_0] == nil then
				local var_69_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_69_1) then
					local var_69_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_66_1.stage_.transform)

					var_69_2.name = var_69_0
					var_69_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_66_1.actors_[var_69_0] = var_69_2

					local var_69_3 = var_69_2:GetComponentInChildren(typeof(CharacterEffect))

					var_69_3.enabled = true

					local var_69_4 = GameObjectTools.GetOrAddComponent(var_69_2, typeof(DynamicBoneHelper))

					if var_69_4 then
						var_69_4:EnableDynamicBone(false)
					end

					arg_66_1:ShowWeapon(var_69_3.transform, false)

					arg_66_1.var_[var_69_0 .. "Animator"] = var_69_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_66_1.var_[var_69_0 .. "Animator"].applyRootMotion = true
					arg_66_1.var_[var_69_0 .. "LipSync"] = var_69_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_69_5 = arg_66_1.actors_["1019ui_story"]
			local var_69_6 = 0

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 and not isNil(var_69_5) and arg_66_1.var_.characterEffect1019ui_story == nil then
				arg_66_1.var_.characterEffect1019ui_story = var_69_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_7 = 0.200000002980232

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_7 and not isNil(var_69_5) then
				local var_69_8 = (arg_66_1.time_ - var_69_6) / var_69_7

				if arg_66_1.var_.characterEffect1019ui_story and not isNil(var_69_5) then
					arg_66_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_6 + var_69_7 and arg_66_1.time_ < var_69_6 + var_69_7 + arg_69_0 and not isNil(var_69_5) and arg_66_1.var_.characterEffect1019ui_story then
				arg_66_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_69_9 = 0
			local var_69_10 = 0.275

			if var_69_9 < arg_66_1.time_ and arg_66_1.time_ <= var_69_9 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_11 = arg_66_1:FormatText(StoryNameCfg[13].name)

				arg_66_1.leftNameTxt_.text = var_69_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_12 = arg_66_1:GetWordFromCfg(305072014)
				local var_69_13 = arg_66_1:FormatText(var_69_12.content)

				arg_66_1.text_.text = var_69_13

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_14 = 11
				local var_69_15 = utf8.len(var_69_13)
				local var_69_16 = var_69_14 <= 0 and var_69_10 or var_69_10 * (var_69_15 / var_69_14)

				if var_69_16 > 0 and var_69_10 < var_69_16 then
					arg_66_1.talkMaxDuration = var_69_16

					if var_69_16 + var_69_9 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_16 + var_69_9
					end
				end

				arg_66_1.text_.text = var_69_13
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072014", "story_v_out_305072.awb") ~= 0 then
					local var_69_17 = manager.audio:GetVoiceLength("story_v_out_305072", "305072014", "story_v_out_305072.awb") / 1000

					if var_69_17 + var_69_9 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_17 + var_69_9
					end

					if var_69_12.prefab_name ~= "" and arg_66_1.actors_[var_69_12.prefab_name] ~= nil then
						local var_69_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_12.prefab_name].transform, "story_v_out_305072", "305072014", "story_v_out_305072.awb")

						arg_66_1:RecordAudio("305072014", var_69_18)
						arg_66_1:RecordAudio("305072014", var_69_18)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_305072", "305072014", "story_v_out_305072.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_305072", "305072014", "story_v_out_305072.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_19 = math.max(var_69_10, arg_66_1.talkMaxDuration)

			if var_69_9 <= arg_66_1.time_ and arg_66_1.time_ < var_69_9 + var_69_19 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_9) / var_69_19

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_9 + var_69_19 and arg_66_1.time_ < var_69_9 + var_69_19 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play305072015 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 305072015
		arg_70_1.duration_ = 3.1

		local var_70_0 = {
			zh = 3.1,
			ja = 1.699999999999
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play305072016(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1084ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1084ui_story == nil then
				arg_70_1.var_.characterEffect1084ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect1084ui_story and not isNil(var_73_0) then
					arg_70_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1084ui_story then
				arg_70_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_73_4 = arg_70_1.actors_["1019ui_story"]
			local var_73_5 = 0

			if var_73_5 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect1019ui_story == nil then
				arg_70_1.var_.characterEffect1019ui_story = var_73_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_6 = 0.200000002980232

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_6 and not isNil(var_73_4) then
				local var_73_7 = (arg_70_1.time_ - var_73_5) / var_73_6

				if arg_70_1.var_.characterEffect1019ui_story and not isNil(var_73_4) then
					local var_73_8 = Mathf.Lerp(0, 0.5, var_73_7)

					arg_70_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1019ui_story.fillRatio = var_73_8
				end
			end

			if arg_70_1.time_ >= var_73_5 + var_73_6 and arg_70_1.time_ < var_73_5 + var_73_6 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect1019ui_story then
				local var_73_9 = 0.5

				arg_70_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1019ui_story.fillRatio = var_73_9
			end

			local var_73_10 = 0.2
			local var_73_11 = 1

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				local var_73_12 = "play"
				local var_73_13 = "effect"

				arg_70_1:AudioAction(var_73_12, var_73_13, "se_story_5", "se_story_5_lastcharge", "")
			end

			local var_73_14 = 0.7
			local var_73_15 = 1

			if var_73_14 < arg_70_1.time_ and arg_70_1.time_ <= var_73_14 + arg_73_0 then
				local var_73_16 = "play"
				local var_73_17 = "effect"

				arg_70_1:AudioAction(var_73_16, var_73_17, "se_story_5", "se_story_5_lastcharge_loop", "")
			end

			local var_73_18 = 0
			local var_73_19 = 0.325

			if var_73_18 < arg_70_1.time_ and arg_70_1.time_ <= var_73_18 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_20 = arg_70_1:FormatText(StoryNameCfg[6].name)

				arg_70_1.leftNameTxt_.text = var_73_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_21 = arg_70_1:GetWordFromCfg(305072015)
				local var_73_22 = arg_70_1:FormatText(var_73_21.content)

				arg_70_1.text_.text = var_73_22

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_23 = 13
				local var_73_24 = utf8.len(var_73_22)
				local var_73_25 = var_73_23 <= 0 and var_73_19 or var_73_19 * (var_73_24 / var_73_23)

				if var_73_25 > 0 and var_73_19 < var_73_25 then
					arg_70_1.talkMaxDuration = var_73_25

					if var_73_25 + var_73_18 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_25 + var_73_18
					end
				end

				arg_70_1.text_.text = var_73_22
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072015", "story_v_out_305072.awb") ~= 0 then
					local var_73_26 = manager.audio:GetVoiceLength("story_v_out_305072", "305072015", "story_v_out_305072.awb") / 1000

					if var_73_26 + var_73_18 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_26 + var_73_18
					end

					if var_73_21.prefab_name ~= "" and arg_70_1.actors_[var_73_21.prefab_name] ~= nil then
						local var_73_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_21.prefab_name].transform, "story_v_out_305072", "305072015", "story_v_out_305072.awb")

						arg_70_1:RecordAudio("305072015", var_73_27)
						arg_70_1:RecordAudio("305072015", var_73_27)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_305072", "305072015", "story_v_out_305072.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_305072", "305072015", "story_v_out_305072.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_28 = math.max(var_73_19, arg_70_1.talkMaxDuration)

			if var_73_18 <= arg_70_1.time_ and arg_70_1.time_ < var_73_18 + var_73_28 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_18) / var_73_28

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_18 + var_73_28 and arg_70_1.time_ < var_73_18 + var_73_28 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play305072016 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 305072016
		arg_74_1.duration_ = 4.7

		local var_74_0 = {
			zh = 4.7,
			ja = 1.333
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
				arg_74_0:Play305072017(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.55

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[6].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:GetWordFromCfg(305072016)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072016", "story_v_out_305072.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_305072", "305072016", "story_v_out_305072.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_305072", "305072016", "story_v_out_305072.awb")

						arg_74_1:RecordAudio("305072016", var_77_9)
						arg_74_1:RecordAudio("305072016", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_305072", "305072016", "story_v_out_305072.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_305072", "305072016", "story_v_out_305072.awb")
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
	Play305072017 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 305072017
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play305072018(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1084ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1084ui_story == nil then
				arg_78_1.var_.characterEffect1084ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1084ui_story and not isNil(var_81_0) then
					local var_81_4 = Mathf.Lerp(0, 0.5, var_81_3)

					arg_78_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1084ui_story.fillRatio = var_81_4
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1084ui_story then
				local var_81_5 = 0.5

				arg_78_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1084ui_story.fillRatio = var_81_5
			end

			local var_81_6 = 0.2
			local var_81_7 = 1

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				local var_81_8 = "stop"
				local var_81_9 = "effect"

				arg_78_1:AudioAction(var_81_8, var_81_9, "se_story_5", "se_story_5_lastcharge_loop", "")
			end

			local var_81_10 = 0.2
			local var_81_11 = 1

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				local var_81_12 = "play"
				local var_81_13 = "effect"

				arg_78_1:AudioAction(var_81_12, var_81_13, "se_story_5", "se_story_5_laststrike", "")
			end

			local var_81_14 = 0
			local var_81_15 = 0.775

			if var_81_14 < arg_78_1.time_ and arg_78_1.time_ <= var_81_14 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_16 = arg_78_1:GetWordFromCfg(305072017)
				local var_81_17 = arg_78_1:FormatText(var_81_16.content)

				arg_78_1.text_.text = var_81_17

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_18 = 31
				local var_81_19 = utf8.len(var_81_17)
				local var_81_20 = var_81_18 <= 0 and var_81_15 or var_81_15 * (var_81_19 / var_81_18)

				if var_81_20 > 0 and var_81_15 < var_81_20 then
					arg_78_1.talkMaxDuration = var_81_20

					if var_81_20 + var_81_14 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_20 + var_81_14
					end
				end

				arg_78_1.text_.text = var_81_17
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_21 = math.max(var_81_15, arg_78_1.talkMaxDuration)

			if var_81_14 <= arg_78_1.time_ and arg_78_1.time_ < var_81_14 + var_81_21 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_14) / var_81_21

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_14 + var_81_21 and arg_78_1.time_ < var_81_14 + var_81_21 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play305072018 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 305072018
		arg_82_1.duration_ = 10.3

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play305072019(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = manager.ui.mainCamera.transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				local var_85_2 = arg_82_1.var_.effect恶趣味
				local var_85_3
				local var_85_4 = var_85_0

				if not var_85_2 then
					var_85_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang07"), var_85_4)
					var_85_2.name = "恶趣味"
					arg_82_1.var_.effect恶趣味 = var_85_2
				else
					var_85_2.transform:SetParent(var_85_4)
				end

				var_85_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_85_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_85_5 = 1.7777777777777777
				local var_85_6 = Screen.width / Screen.height
				local var_85_7 = var_85_6 / var_85_5
				local var_85_8 = Mathf.Max(var_85_5 / var_85_6, 1)

				var_85_2.transform.localScale = Vector3.New(var_85_2.transform.localScale.x * var_85_7, var_85_2.transform.localScale.y * var_85_8, var_85_2.transform.localScale.z)
			end

			local var_85_9 = manager.ui.mainCamera.transform
			local var_85_10 = 3.1

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 then
				local var_85_11 = arg_82_1.var_.effect恶趣味

				if var_85_11 then
					Object.Destroy(var_85_11)

					arg_82_1.var_.effect恶趣味 = nil
				end
			end

			local var_85_12 = 1.63931569838896

			if var_85_12 < arg_82_1.time_ and arg_82_1.time_ <= var_85_12 + arg_85_0 then
				arg_82_1.mask_.enabled = true
				arg_82_1.mask_.raycastTarget = true

				arg_82_1:SetGaussion(false)
			end

			local var_85_13 = 0.460218196641653

			if var_85_12 <= arg_82_1.time_ and arg_82_1.time_ < var_85_12 + var_85_13 then
				local var_85_14 = (arg_82_1.time_ - var_85_12) / var_85_13
				local var_85_15 = Color.New(1, 1, 1)

				var_85_15.a = Mathf.Lerp(1, 0, var_85_14)
				arg_82_1.mask_.color = var_85_15
			end

			if arg_82_1.time_ >= var_85_12 + var_85_13 and arg_82_1.time_ < var_85_12 + var_85_13 + arg_85_0 then
				local var_85_16 = Color.New(1, 1, 1)
				local var_85_17 = 0

				arg_82_1.mask_.enabled = false
				var_85_16.a = var_85_17
				arg_82_1.mask_.color = var_85_16
			end

			local var_85_18 = 2.09953389503062

			if var_85_18 < arg_82_1.time_ and arg_82_1.time_ <= var_85_18 + arg_85_0 then
				arg_82_1.mask_.enabled = true
				arg_82_1.mask_.raycastTarget = true

				arg_82_1:SetGaussion(false)
			end

			local var_85_19 = 0.460218196641653

			if var_85_18 <= arg_82_1.time_ and arg_82_1.time_ < var_85_18 + var_85_19 then
				local var_85_20 = (arg_82_1.time_ - var_85_18) / var_85_19
				local var_85_21 = Color.New(1, 1, 1)

				var_85_21.a = Mathf.Lerp(1, 0, var_85_20)
				arg_82_1.mask_.color = var_85_21
			end

			if arg_82_1.time_ >= var_85_18 + var_85_19 and arg_82_1.time_ < var_85_18 + var_85_19 + arg_85_0 then
				local var_85_22 = Color.New(1, 1, 1)
				local var_85_23 = 0

				arg_82_1.mask_.enabled = false
				var_85_22.a = var_85_23
				arg_82_1.mask_.color = var_85_22
			end

			local var_85_24 = manager.ui.mainCamera.transform
			local var_85_25 = 2

			if var_85_25 < arg_82_1.time_ and arg_82_1.time_ <= var_85_25 + arg_85_0 then
				local var_85_26 = arg_82_1.var_.effect烦烦烦

				if var_85_26 then
					Object.Destroy(var_85_26)

					arg_82_1.var_.effect烦烦烦 = nil
				end
			end

			local var_85_27 = manager.ui.mainCamera.transform
			local var_85_28 = 2.55975209167227

			if var_85_28 < arg_82_1.time_ and arg_82_1.time_ <= var_85_28 + arg_85_0 then
				local var_85_29 = arg_82_1.var_.effect112336
				local var_85_30
				local var_85_31 = var_85_27

				if not var_85_29 then
					var_85_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redtwister_out"), var_85_31)
					var_85_29.name = "112336"
					arg_82_1.var_.effect112336 = var_85_29
				else
					var_85_29.transform:SetParent(var_85_31)
				end

				var_85_29.transform.localPosition = Vector3.New(0, 0, 0)
				var_85_29.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_85_32 = manager.ui.mainCamera.transform
			local var_85_33 = 5.2

			if var_85_33 < arg_82_1.time_ and arg_82_1.time_ <= var_85_33 + arg_85_0 then
				local var_85_34 = arg_82_1.var_.effect112336

				if var_85_34 then
					Object.Destroy(var_85_34)

					arg_82_1.var_.effect112336 = nil
				end
			end

			local var_85_35 = manager.ui.mainCamera.transform
			local var_85_36 = 2.8

			if var_85_36 < arg_82_1.time_ and arg_82_1.time_ <= var_85_36 + arg_85_0 then
				local var_85_37 = arg_82_1.var_.effect不不不
				local var_85_38
				local var_85_39 = var_85_35

				if not var_85_37 then
					var_85_37 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), var_85_39)
					var_85_37.name = "不不不"
					arg_82_1.var_.effect不不不 = var_85_37
				else
					var_85_37.transform:SetParent(var_85_39)
				end

				var_85_37.transform.localPosition = Vector3.New(0, 0.1, -1.73)
				var_85_37.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_85_40 = 1.7777777777777777
				local var_85_41 = Screen.width / Screen.height
				local var_85_42 = var_85_41 / var_85_40
				local var_85_43 = Mathf.Max(var_85_40 / var_85_41, 1)

				var_85_37.transform.localScale = Vector3.New(var_85_37.transform.localScale.x * var_85_42, var_85_37.transform.localScale.y * var_85_43, var_85_37.transform.localScale.z)
			end

			local var_85_44 = manager.ui.mainCamera.transform
			local var_85_45 = 5.35096293420841

			if var_85_45 < arg_82_1.time_ and arg_82_1.time_ <= var_85_45 + arg_85_0 then
				local var_85_46 = arg_82_1.var_.effect不不不

				if var_85_46 then
					Object.Destroy(var_85_46)

					arg_82_1.var_.effect不不不 = nil
				end
			end

			local var_85_47 = manager.ui.mainCamera.transform
			local var_85_48 = 2.8

			if var_85_48 < arg_82_1.time_ and arg_82_1.time_ <= var_85_48 + arg_85_0 then
				local var_85_49 = arg_82_1.var_.effect热热

				if var_85_49 then
					Object.Destroy(var_85_49)

					arg_82_1.var_.effect热热 = nil
				end
			end

			local var_85_50 = 0

			if var_85_50 < arg_82_1.time_ and arg_82_1.time_ <= var_85_50 + arg_85_0 then
				arg_82_1.allBtn_.enabled = false
			end

			local var_85_51 = 5.46666666666667

			if arg_82_1.time_ >= var_85_50 + var_85_51 and arg_82_1.time_ < var_85_50 + var_85_51 + arg_85_0 then
				arg_82_1.allBtn_.enabled = true
			end

			local var_85_52 = arg_82_1.bgs_.S0505.transform
			local var_85_53 = 3.3402479053475

			if var_85_53 < arg_82_1.time_ and arg_82_1.time_ <= var_85_53 + arg_85_0 then
				arg_82_1.var_.moveOldPosS0505 = var_85_52.localPosition
			end

			local var_85_54 = 1.5597520946525

			if var_85_53 <= arg_82_1.time_ and arg_82_1.time_ < var_85_53 + var_85_54 then
				local var_85_55 = (arg_82_1.time_ - var_85_53) / var_85_54
				local var_85_56 = Vector3.New(0, 0.1, 4.11)

				var_85_52.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPosS0505, var_85_56, var_85_55)
			end

			if arg_82_1.time_ >= var_85_53 + var_85_54 and arg_82_1.time_ < var_85_53 + var_85_54 + arg_85_0 then
				var_85_52.localPosition = Vector3.New(0, 0.1, 4.11)
			end

			local var_85_57 = 0
			local var_85_58 = 1

			if var_85_57 < arg_82_1.time_ and arg_82_1.time_ <= var_85_57 + arg_85_0 then
				local var_85_59 = "play"
				local var_85_60 = "effect"

				arg_82_1:AudioAction(var_85_59, var_85_60, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_85_61 = 0
			local var_85_62 = 1

			if var_85_61 < arg_82_1.time_ and arg_82_1.time_ <= var_85_61 + arg_85_0 then
				local var_85_63 = "play"
				local var_85_64 = "effect"

				arg_82_1:AudioAction(var_85_63, var_85_64, "se_story_121_04", "se_story_121_04_explosion", "")
			end

			if arg_82_1.frameCnt_ <= 1 then
				arg_82_1.dialog_:SetActive(false)
			end

			local var_85_65 = 5.3
			local var_85_66 = 1.7

			if var_85_65 < arg_82_1.time_ and arg_82_1.time_ <= var_85_65 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				arg_82_1.dialog_:SetActive(true)

				arg_82_1.dialogCg_.alpha = 0

				local var_85_67 = LeanTween.value(arg_82_1.dialog_, 0, 1, 0.3)

				var_85_67:setOnUpdate(LuaHelper.FloatAction(function(arg_86_0)
					arg_82_1.dialogCg_.alpha = arg_86_0
				end))
				var_85_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_82_1.dialog_)
					var_85_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_82_1.duration_ = arg_82_1.duration_ + 0.3

				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_68 = arg_82_1:GetWordFromCfg(305072018)
				local var_85_69 = arg_82_1:FormatText(var_85_68.content)

				arg_82_1.text_.text = var_85_69

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_70 = 68
				local var_85_71 = utf8.len(var_85_69)
				local var_85_72 = var_85_70 <= 0 and var_85_66 or var_85_66 * (var_85_71 / var_85_70)

				if var_85_72 > 0 and var_85_66 < var_85_72 then
					arg_82_1.talkMaxDuration = var_85_72
					var_85_65 = var_85_65 + 0.3

					if var_85_72 + var_85_65 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_72 + var_85_65
					end
				end

				arg_82_1.text_.text = var_85_69
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_73 = var_85_65 + 0.3
			local var_85_74 = math.max(var_85_66, arg_82_1.talkMaxDuration)

			if var_85_73 <= arg_82_1.time_ and arg_82_1.time_ < var_85_73 + var_85_74 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_73) / var_85_74

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_73 + var_85_74 and arg_82_1.time_ < var_85_73 + var_85_74 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0505",
				frequency = 10,
				className = "StoryShakeNode",
				duration = 1.69684893920397,
				startTime = 1.00244506166006,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.BACKGROUND,
				offset = Vector3.New(0.05, 0.05, 0.1)
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "S0505",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.5597520946525,
				startTime = 3.3402479053475,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.59),
					endPos = Vector3.New(0, 0.1, 4.11),
					easeType = LeanTweenType.easeInOutQuart
				}
			},
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 2,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.3402479053475,
				amplitudeGain = 1,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play305072019 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 305072019
		arg_88_1.duration_ = 10.8

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play305072020(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 2.36666666666667

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				local var_91_1 = manager.ui.mainCamera.transform.localPosition
				local var_91_2 = Vector3.New(0, 0, 10) + Vector3.New(var_91_1.x, var_91_1.y, 0)
				local var_91_3 = arg_88_1.bgs_.B12

				var_91_3.transform.localPosition = var_91_2
				var_91_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_4 = var_91_3:GetComponent("SpriteRenderer")

				if var_91_4 and var_91_4.sprite then
					local var_91_5 = (var_91_3.transform.localPosition - var_91_1).z
					local var_91_6 = manager.ui.mainCameraCom_
					local var_91_7 = 2 * var_91_5 * Mathf.Tan(var_91_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_91_8 = var_91_7 * var_91_6.aspect
					local var_91_9 = var_91_4.sprite.bounds.size.x
					local var_91_10 = var_91_4.sprite.bounds.size.y
					local var_91_11 = var_91_8 / var_91_9
					local var_91_12 = var_91_7 / var_91_10
					local var_91_13 = var_91_12 < var_91_11 and var_91_11 or var_91_12

					var_91_3.transform.localScale = Vector3.New(var_91_13, var_91_13, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "B12" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_91_14 = 0

			if var_91_14 < arg_88_1.time_ and arg_88_1.time_ <= var_91_14 + arg_91_0 then
				arg_88_1.allBtn_.enabled = false
			end

			local var_91_15 = 0.3

			if arg_88_1.time_ >= var_91_14 + var_91_15 and arg_88_1.time_ < var_91_14 + var_91_15 + arg_91_0 then
				arg_88_1.allBtn_.enabled = true
			end

			local var_91_16 = 0

			if var_91_16 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_17 = 2.36666666666667

			if var_91_16 <= arg_88_1.time_ and arg_88_1.time_ < var_91_16 + var_91_17 then
				local var_91_18 = (arg_88_1.time_ - var_91_16) / var_91_17
				local var_91_19 = Color.New(0.9433962, 0.9433962, 0.9433962)

				var_91_19.a = Mathf.Lerp(0, 1, var_91_18)
				arg_88_1.mask_.color = var_91_19
			end

			if arg_88_1.time_ >= var_91_16 + var_91_17 and arg_88_1.time_ < var_91_16 + var_91_17 + arg_91_0 then
				local var_91_20 = Color.New(0.9433962, 0.9433962, 0.9433962)

				var_91_20.a = 1
				arg_88_1.mask_.color = var_91_20
			end

			local var_91_21 = 2.36666666666667

			if var_91_21 < arg_88_1.time_ and arg_88_1.time_ <= var_91_21 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_22 = 2.53333333333333

			if var_91_21 <= arg_88_1.time_ and arg_88_1.time_ < var_91_21 + var_91_22 then
				local var_91_23 = (arg_88_1.time_ - var_91_21) / var_91_22
				local var_91_24 = Color.New(0.9433962, 0.9433962, 0.9433962)

				var_91_24.a = Mathf.Lerp(1, 0, var_91_23)
				arg_88_1.mask_.color = var_91_24
			end

			if arg_88_1.time_ >= var_91_21 + var_91_22 and arg_88_1.time_ < var_91_21 + var_91_22 + arg_91_0 then
				local var_91_25 = Color.New(0.9433962, 0.9433962, 0.9433962)
				local var_91_26 = 0

				arg_88_1.mask_.enabled = false
				var_91_25.a = var_91_26
				arg_88_1.mask_.color = var_91_25
			end

			local var_91_27 = 4.6

			if var_91_27 < arg_88_1.time_ and arg_88_1.time_ <= var_91_27 + arg_91_0 then
				arg_88_1.allBtn_.enabled = false
			end

			local var_91_28 = 1.96666666666667

			if arg_88_1.time_ >= var_91_27 + var_91_28 and arg_88_1.time_ < var_91_27 + var_91_28 + arg_91_0 then
				arg_88_1.allBtn_.enabled = true
			end

			local var_91_29 = 1
			local var_91_30 = 1

			if var_91_29 < arg_88_1.time_ and arg_88_1.time_ <= var_91_29 + arg_91_0 then
				local var_91_31 = "play"
				local var_91_32 = "music"

				arg_88_1:AudioAction(var_91_31, var_91_32, "bgm_activity_5_2_story_source", "bgm_activity_5_2_story_source", "bgm_activity_5_2_story_source.awb")

				local var_91_33 = ""
				local var_91_34 = manager.audio:GetAudioName("bgm_activity_5_2_story_source", "bgm_activity_5_2_story_source")

				if var_91_34 ~= "" then
					if arg_88_1.bgmTxt_.text ~= var_91_34 and arg_88_1.bgmTxt_.text ~= "" then
						if arg_88_1.bgmTxt2_.text ~= "" then
							arg_88_1.bgmTxt_.text = arg_88_1.bgmTxt2_.text
						end

						arg_88_1.bgmTxt2_.text = var_91_34

						arg_88_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_88_1.bgmTxt_.text = var_91_34
						arg_88_1.bgmTxt2_.text = var_91_34
					end

					if arg_88_1.bgmTimer then
						arg_88_1.bgmTimer:Stop()

						arg_88_1.bgmTimer = nil
					end

					if arg_88_1.settingData.show_music_name == 1 then
						arg_88_1.musicController:SetSelectedState("show")
						arg_88_1.musicAnimator_:Play("open", 0, 0)

						if arg_88_1.settingData.music_time ~= 0 then
							arg_88_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_88_1.settingData.music_time), function()
								if arg_88_1 == nil or isNil(arg_88_1.bgmTxt_) then
									return
								end

								arg_88_1.musicController:SetSelectedState("hide")
								arg_88_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_35 = 5.8
			local var_91_36 = 1.4

			if var_91_35 < arg_88_1.time_ and arg_88_1.time_ <= var_91_35 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_37 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_37:setOnUpdate(LuaHelper.FloatAction(function(arg_93_0)
					arg_88_1.dialogCg_.alpha = arg_93_0
				end))
				var_91_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_38 = arg_88_1:GetWordFromCfg(305072019)
				local var_91_39 = arg_88_1:FormatText(var_91_38.content)

				arg_88_1.text_.text = var_91_39

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_40 = 56
				local var_91_41 = utf8.len(var_91_39)
				local var_91_42 = var_91_40 <= 0 and var_91_36 or var_91_36 * (var_91_41 / var_91_40)

				if var_91_42 > 0 and var_91_36 < var_91_42 then
					arg_88_1.talkMaxDuration = var_91_42
					var_91_35 = var_91_35 + 0.3

					if var_91_42 + var_91_35 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_42 + var_91_35
					end
				end

				arg_88_1.text_.text = var_91_39
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_43 = var_91_35 + 0.3
			local var_91_44 = math.max(var_91_36, arg_88_1.talkMaxDuration)

			if var_91_43 <= arg_88_1.time_ and arg_88_1.time_ < var_91_43 + var_91_44 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_43) / var_91_44

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_43 + var_91_44 and arg_88_1.time_ < var_91_43 + var_91_44 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play305072020 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 305072020
		arg_95_1.duration_ = 4.6

		local var_95_0 = {
			zh = 4.6,
			ja = 1.999999999999
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
				arg_95_0:Play305072021(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1084ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1084ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(-0.7, -0.97, -6)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1084ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = arg_95_1.actors_["1084ui_story"]
			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1084ui_story == nil then
				arg_95_1.var_.characterEffect1084ui_story = var_98_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_11 = 0.200000002980232

			if var_98_10 <= arg_95_1.time_ and arg_95_1.time_ < var_98_10 + var_98_11 and not isNil(var_98_9) then
				local var_98_12 = (arg_95_1.time_ - var_98_10) / var_98_11

				if arg_95_1.var_.characterEffect1084ui_story and not isNil(var_98_9) then
					arg_95_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_10 + var_98_11 and arg_95_1.time_ < var_98_10 + var_98_11 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1084ui_story then
				arg_95_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_98_13 = 0

			if var_98_13 < arg_95_1.time_ and arg_95_1.time_ <= var_98_13 + arg_98_0 then
				arg_95_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_98_14 = 0

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_98_15 = 0
			local var_98_16 = 0.225

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_17 = arg_95_1:FormatText(StoryNameCfg[6].name)

				arg_95_1.leftNameTxt_.text = var_98_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_18 = arg_95_1:GetWordFromCfg(305072020)
				local var_98_19 = arg_95_1:FormatText(var_98_18.content)

				arg_95_1.text_.text = var_98_19

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_20 = 9
				local var_98_21 = utf8.len(var_98_19)
				local var_98_22 = var_98_20 <= 0 and var_98_16 or var_98_16 * (var_98_21 / var_98_20)

				if var_98_22 > 0 and var_98_16 < var_98_22 then
					arg_95_1.talkMaxDuration = var_98_22

					if var_98_22 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_22 + var_98_15
					end
				end

				arg_95_1.text_.text = var_98_19
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072020", "story_v_out_305072.awb") ~= 0 then
					local var_98_23 = manager.audio:GetVoiceLength("story_v_out_305072", "305072020", "story_v_out_305072.awb") / 1000

					if var_98_23 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_23 + var_98_15
					end

					if var_98_18.prefab_name ~= "" and arg_95_1.actors_[var_98_18.prefab_name] ~= nil then
						local var_98_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_18.prefab_name].transform, "story_v_out_305072", "305072020", "story_v_out_305072.awb")

						arg_95_1:RecordAudio("305072020", var_98_24)
						arg_95_1:RecordAudio("305072020", var_98_24)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_305072", "305072020", "story_v_out_305072.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_305072", "305072020", "story_v_out_305072.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_25 = math.max(var_98_16, arg_95_1.talkMaxDuration)

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_25 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_15) / var_98_25

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_15 + var_98_25 and arg_95_1.time_ < var_98_15 + var_98_25 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play305072021 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 305072021
		arg_99_1.duration_ = 4.53

		local var_99_0 = {
			zh = 2.666,
			ja = 4.533
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play305072022(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1019ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos1019ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0.7, -1.08, -5.9)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1019ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = arg_99_1.actors_["1019ui_story"]
			local var_102_10 = 0

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect1019ui_story == nil then
				arg_99_1.var_.characterEffect1019ui_story = var_102_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_11 = 0.200000002980232

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_11 and not isNil(var_102_9) then
				local var_102_12 = (arg_99_1.time_ - var_102_10) / var_102_11

				if arg_99_1.var_.characterEffect1019ui_story and not isNil(var_102_9) then
					arg_99_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_10 + var_102_11 and arg_99_1.time_ < var_102_10 + var_102_11 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect1019ui_story then
				arg_99_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_102_13 = arg_99_1.actors_["1084ui_story"]
			local var_102_14 = 0

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 and not isNil(var_102_13) and arg_99_1.var_.characterEffect1084ui_story == nil then
				arg_99_1.var_.characterEffect1084ui_story = var_102_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_15 = 0.200000002980232

			if var_102_14 <= arg_99_1.time_ and arg_99_1.time_ < var_102_14 + var_102_15 and not isNil(var_102_13) then
				local var_102_16 = (arg_99_1.time_ - var_102_14) / var_102_15

				if arg_99_1.var_.characterEffect1084ui_story and not isNil(var_102_13) then
					local var_102_17 = Mathf.Lerp(0, 0.5, var_102_16)

					arg_99_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1084ui_story.fillRatio = var_102_17
				end
			end

			if arg_99_1.time_ >= var_102_14 + var_102_15 and arg_99_1.time_ < var_102_14 + var_102_15 + arg_102_0 and not isNil(var_102_13) and arg_99_1.var_.characterEffect1084ui_story then
				local var_102_18 = 0.5

				arg_99_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1084ui_story.fillRatio = var_102_18
			end

			local var_102_19 = 0

			if var_102_19 < arg_99_1.time_ and arg_99_1.time_ <= var_102_19 + arg_102_0 then
				arg_99_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_102_20 = 0

			if var_102_20 < arg_99_1.time_ and arg_99_1.time_ <= var_102_20 + arg_102_0 then
				arg_99_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_102_21 = 0
			local var_102_22 = 0.25

			if var_102_21 < arg_99_1.time_ and arg_99_1.time_ <= var_102_21 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_23 = arg_99_1:FormatText(StoryNameCfg[13].name)

				arg_99_1.leftNameTxt_.text = var_102_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_24 = arg_99_1:GetWordFromCfg(305072021)
				local var_102_25 = arg_99_1:FormatText(var_102_24.content)

				arg_99_1.text_.text = var_102_25

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_26 = 10
				local var_102_27 = utf8.len(var_102_25)
				local var_102_28 = var_102_26 <= 0 and var_102_22 or var_102_22 * (var_102_27 / var_102_26)

				if var_102_28 > 0 and var_102_22 < var_102_28 then
					arg_99_1.talkMaxDuration = var_102_28

					if var_102_28 + var_102_21 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_28 + var_102_21
					end
				end

				arg_99_1.text_.text = var_102_25
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072021", "story_v_out_305072.awb") ~= 0 then
					local var_102_29 = manager.audio:GetVoiceLength("story_v_out_305072", "305072021", "story_v_out_305072.awb") / 1000

					if var_102_29 + var_102_21 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_29 + var_102_21
					end

					if var_102_24.prefab_name ~= "" and arg_99_1.actors_[var_102_24.prefab_name] ~= nil then
						local var_102_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_24.prefab_name].transform, "story_v_out_305072", "305072021", "story_v_out_305072.awb")

						arg_99_1:RecordAudio("305072021", var_102_30)
						arg_99_1:RecordAudio("305072021", var_102_30)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_305072", "305072021", "story_v_out_305072.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_305072", "305072021", "story_v_out_305072.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_31 = math.max(var_102_22, arg_99_1.talkMaxDuration)

			if var_102_21 <= arg_99_1.time_ and arg_99_1.time_ < var_102_21 + var_102_31 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_21) / var_102_31

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_21 + var_102_31 and arg_99_1.time_ < var_102_21 + var_102_31 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play305072022 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 305072022
		arg_103_1.duration_ = 6.53

		local var_103_0 = {
			zh = 6.533,
			ja = 1.999999999999
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
				arg_103_0:Play305072023(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1084ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1084ui_story == nil then
				arg_103_1.var_.characterEffect1084ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect1084ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1084ui_story then
				arg_103_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_106_4 = arg_103_1.actors_["1019ui_story"]
			local var_106_5 = 0

			if var_106_5 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 and not isNil(var_106_4) and arg_103_1.var_.characterEffect1019ui_story == nil then
				arg_103_1.var_.characterEffect1019ui_story = var_106_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_6 = 0.200000002980232

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_6 and not isNil(var_106_4) then
				local var_106_7 = (arg_103_1.time_ - var_106_5) / var_106_6

				if arg_103_1.var_.characterEffect1019ui_story and not isNil(var_106_4) then
					local var_106_8 = Mathf.Lerp(0, 0.5, var_106_7)

					arg_103_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1019ui_story.fillRatio = var_106_8
				end
			end

			if arg_103_1.time_ >= var_106_5 + var_106_6 and arg_103_1.time_ < var_106_5 + var_106_6 + arg_106_0 and not isNil(var_106_4) and arg_103_1.var_.characterEffect1019ui_story then
				local var_106_9 = 0.5

				arg_103_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1019ui_story.fillRatio = var_106_9
			end

			local var_106_10 = 0

			if var_106_10 < arg_103_1.time_ and arg_103_1.time_ <= var_106_10 + arg_106_0 then
				arg_103_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_106_11 = 0
			local var_106_12 = 0.7

			if var_106_11 < arg_103_1.time_ and arg_103_1.time_ <= var_106_11 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_13 = arg_103_1:FormatText(StoryNameCfg[6].name)

				arg_103_1.leftNameTxt_.text = var_106_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_14 = arg_103_1:GetWordFromCfg(305072022)
				local var_106_15 = arg_103_1:FormatText(var_106_14.content)

				arg_103_1.text_.text = var_106_15

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_16 = 28
				local var_106_17 = utf8.len(var_106_15)
				local var_106_18 = var_106_16 <= 0 and var_106_12 or var_106_12 * (var_106_17 / var_106_16)

				if var_106_18 > 0 and var_106_12 < var_106_18 then
					arg_103_1.talkMaxDuration = var_106_18

					if var_106_18 + var_106_11 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_18 + var_106_11
					end
				end

				arg_103_1.text_.text = var_106_15
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072022", "story_v_out_305072.awb") ~= 0 then
					local var_106_19 = manager.audio:GetVoiceLength("story_v_out_305072", "305072022", "story_v_out_305072.awb") / 1000

					if var_106_19 + var_106_11 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_19 + var_106_11
					end

					if var_106_14.prefab_name ~= "" and arg_103_1.actors_[var_106_14.prefab_name] ~= nil then
						local var_106_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_14.prefab_name].transform, "story_v_out_305072", "305072022", "story_v_out_305072.awb")

						arg_103_1:RecordAudio("305072022", var_106_20)
						arg_103_1:RecordAudio("305072022", var_106_20)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_305072", "305072022", "story_v_out_305072.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_305072", "305072022", "story_v_out_305072.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_21 = math.max(var_106_12, arg_103_1.talkMaxDuration)

			if var_106_11 <= arg_103_1.time_ and arg_103_1.time_ < var_106_11 + var_106_21 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_11) / var_106_21

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_11 + var_106_21 and arg_103_1.time_ < var_106_11 + var_106_21 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play305072023 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 305072023
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play305072024(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1084ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1084ui_story == nil then
				arg_107_1.var_.characterEffect1084ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect1084ui_story and not isNil(var_110_0) then
					local var_110_4 = Mathf.Lerp(0, 0.5, var_110_3)

					arg_107_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1084ui_story.fillRatio = var_110_4
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1084ui_story then
				local var_110_5 = 0.5

				arg_107_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1084ui_story.fillRatio = var_110_5
			end

			local var_110_6 = 0
			local var_110_7 = 0.575

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_8 = arg_107_1:FormatText(StoryNameCfg[7].name)

				arg_107_1.leftNameTxt_.text = var_110_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_9 = arg_107_1:GetWordFromCfg(305072023)
				local var_110_10 = arg_107_1:FormatText(var_110_9.content)

				arg_107_1.text_.text = var_110_10

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 23
				local var_110_12 = utf8.len(var_110_10)
				local var_110_13 = var_110_11 <= 0 and var_110_7 or var_110_7 * (var_110_12 / var_110_11)

				if var_110_13 > 0 and var_110_7 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_6
					end
				end

				arg_107_1.text_.text = var_110_10
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_14 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_14 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_14

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_14 and arg_107_1.time_ < var_110_6 + var_110_14 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play305072024 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 305072024
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play305072025(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1084ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos1084ui_story = var_114_0.localPosition
			end

			local var_114_2 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2
				local var_114_4 = Vector3.New(0, 100, 0)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1084ui_story, var_114_4, var_114_3)

				local var_114_5 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_5.x, var_114_5.y, var_114_5.z)

				local var_114_6 = var_114_0.localEulerAngles

				var_114_6.z = 0
				var_114_6.x = 0
				var_114_0.localEulerAngles = var_114_6
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(0, 100, 0)

				local var_114_7 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_7.x, var_114_7.y, var_114_7.z)

				local var_114_8 = var_114_0.localEulerAngles

				var_114_8.z = 0
				var_114_8.x = 0
				var_114_0.localEulerAngles = var_114_8
			end

			local var_114_9 = arg_111_1.actors_["1019ui_story"].transform
			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				arg_111_1.var_.moveOldPos1019ui_story = var_114_9.localPosition
			end

			local var_114_11 = 0.001

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_11 then
				local var_114_12 = (arg_111_1.time_ - var_114_10) / var_114_11
				local var_114_13 = Vector3.New(0, 100, 0)

				var_114_9.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1019ui_story, var_114_13, var_114_12)

				local var_114_14 = manager.ui.mainCamera.transform.position - var_114_9.position

				var_114_9.forward = Vector3.New(var_114_14.x, var_114_14.y, var_114_14.z)

				local var_114_15 = var_114_9.localEulerAngles

				var_114_15.z = 0
				var_114_15.x = 0
				var_114_9.localEulerAngles = var_114_15
			end

			if arg_111_1.time_ >= var_114_10 + var_114_11 and arg_111_1.time_ < var_114_10 + var_114_11 + arg_114_0 then
				var_114_9.localPosition = Vector3.New(0, 100, 0)

				local var_114_16 = manager.ui.mainCamera.transform.position - var_114_9.position

				var_114_9.forward = Vector3.New(var_114_16.x, var_114_16.y, var_114_16.z)

				local var_114_17 = var_114_9.localEulerAngles

				var_114_17.z = 0
				var_114_17.x = 0
				var_114_9.localEulerAngles = var_114_17
			end

			local var_114_18 = 0
			local var_114_19 = 1.175

			if var_114_18 < arg_111_1.time_ and arg_111_1.time_ <= var_114_18 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_20 = arg_111_1:GetWordFromCfg(305072024)
				local var_114_21 = arg_111_1:FormatText(var_114_20.content)

				arg_111_1.text_.text = var_114_21

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_22 = 47
				local var_114_23 = utf8.len(var_114_21)
				local var_114_24 = var_114_22 <= 0 and var_114_19 or var_114_19 * (var_114_23 / var_114_22)

				if var_114_24 > 0 and var_114_19 < var_114_24 then
					arg_111_1.talkMaxDuration = var_114_24

					if var_114_24 + var_114_18 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_24 + var_114_18
					end
				end

				arg_111_1.text_.text = var_114_21
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_25 = math.max(var_114_19, arg_111_1.talkMaxDuration)

			if var_114_18 <= arg_111_1.time_ and arg_111_1.time_ < var_114_18 + var_114_25 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_18) / var_114_25

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_18 + var_114_25 and arg_111_1.time_ < var_114_18 + var_114_25 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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

		arg_111_1:InitPlayNodeList()
	end,
	Play305072025 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 305072025
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play305072026(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.625

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[7].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_3 = arg_115_1:GetWordFromCfg(305072025)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 25
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
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_8 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_8 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_8

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_8 and arg_115_1.time_ < var_118_0 + var_118_8 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play305072026 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 305072026
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play305072027(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 0.5

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_2 = arg_119_1:FormatText(StoryNameCfg[7].name)

				arg_119_1.leftNameTxt_.text = var_122_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_3 = arg_119_1:GetWordFromCfg(305072026)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 20
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
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_8 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_8 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_8

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_8 and arg_119_1.time_ < var_122_0 + var_122_8 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play305072027 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 305072027
		arg_123_1.duration_ = 8.57

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play305072028(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = "S0507"

			if arg_123_1.bgs_[var_126_0] == nil then
				local var_126_1 = Object.Instantiate(arg_123_1.paintGo_)

				var_126_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_126_0)
				var_126_1.name = var_126_0
				var_126_1.transform.parent = arg_123_1.stage_.transform
				var_126_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.bgs_[var_126_0] = var_126_1
			end

			local var_126_2 = 2

			if var_126_2 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				local var_126_3 = manager.ui.mainCamera.transform.localPosition
				local var_126_4 = Vector3.New(0, 0, 10) + Vector3.New(var_126_3.x, var_126_3.y, 0)
				local var_126_5 = arg_123_1.bgs_.S0507

				var_126_5.transform.localPosition = var_126_4
				var_126_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_126_6 = var_126_5:GetComponent("SpriteRenderer")

				if var_126_6 and var_126_6.sprite then
					local var_126_7 = (var_126_5.transform.localPosition - var_126_3).z
					local var_126_8 = manager.ui.mainCameraCom_
					local var_126_9 = 2 * var_126_7 * Mathf.Tan(var_126_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_126_10 = var_126_9 * var_126_8.aspect
					local var_126_11 = var_126_6.sprite.bounds.size.x
					local var_126_12 = var_126_6.sprite.bounds.size.y
					local var_126_13 = var_126_10 / var_126_11
					local var_126_14 = var_126_9 / var_126_12
					local var_126_15 = var_126_14 < var_126_13 and var_126_13 or var_126_14

					var_126_5.transform.localScale = Vector3.New(var_126_15, var_126_15, 0)
				end

				for iter_126_0, iter_126_1 in pairs(arg_123_1.bgs_) do
					if iter_126_0 ~= "S0507" then
						iter_126_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_126_16 = 0

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				arg_123_1.allBtn_.enabled = false
			end

			local var_126_17 = 0.3

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 then
				arg_123_1.allBtn_.enabled = true
			end

			local var_126_18 = 0

			if var_126_18 < arg_123_1.time_ and arg_123_1.time_ <= var_126_18 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_19 = 2

			if var_126_18 <= arg_123_1.time_ and arg_123_1.time_ < var_126_18 + var_126_19 then
				local var_126_20 = (arg_123_1.time_ - var_126_18) / var_126_19
				local var_126_21 = Color.New(0, 0, 0)

				var_126_21.a = Mathf.Lerp(0, 1, var_126_20)
				arg_123_1.mask_.color = var_126_21
			end

			if arg_123_1.time_ >= var_126_18 + var_126_19 and arg_123_1.time_ < var_126_18 + var_126_19 + arg_126_0 then
				local var_126_22 = Color.New(0, 0, 0)

				var_126_22.a = 1
				arg_123_1.mask_.color = var_126_22
			end

			local var_126_23 = 2

			if var_126_23 < arg_123_1.time_ and arg_123_1.time_ <= var_126_23 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_24 = 2

			if var_126_23 <= arg_123_1.time_ and arg_123_1.time_ < var_126_23 + var_126_24 then
				local var_126_25 = (arg_123_1.time_ - var_126_23) / var_126_24
				local var_126_26 = Color.New(0, 0, 0)

				var_126_26.a = Mathf.Lerp(1, 0, var_126_25)
				arg_123_1.mask_.color = var_126_26
			end

			if arg_123_1.time_ >= var_126_23 + var_126_24 and arg_123_1.time_ < var_126_23 + var_126_24 + arg_126_0 then
				local var_126_27 = Color.New(0, 0, 0)
				local var_126_28 = 0

				arg_123_1.mask_.enabled = false
				var_126_27.a = var_126_28
				arg_123_1.mask_.color = var_126_27
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_29 = 3.56666666666667
			local var_126_30 = 1

			if var_126_29 < arg_123_1.time_ and arg_123_1.time_ <= var_126_29 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_31 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_31:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_32 = arg_123_1:GetWordFromCfg(305072027)
				local var_126_33 = arg_123_1:FormatText(var_126_32.content)

				arg_123_1.text_.text = var_126_33

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_34 = 40
				local var_126_35 = utf8.len(var_126_33)
				local var_126_36 = var_126_34 <= 0 and var_126_30 or var_126_30 * (var_126_35 / var_126_34)

				if var_126_36 > 0 and var_126_30 < var_126_36 then
					arg_123_1.talkMaxDuration = var_126_36
					var_126_29 = var_126_29 + 0.3

					if var_126_36 + var_126_29 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_36 + var_126_29
					end
				end

				arg_123_1.text_.text = var_126_33
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_37 = var_126_29 + 0.3
			local var_126_38 = math.max(var_126_30, arg_123_1.talkMaxDuration)

			if var_126_37 <= arg_123_1.time_ and arg_123_1.time_ < var_126_37 + var_126_38 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_37) / var_126_38

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_37 + var_126_38 and arg_123_1.time_ < var_126_37 + var_126_38 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play305072028 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 305072028
		arg_129_1.duration_ = 5.4

		local var_129_0 = {
			zh = 3.566,
			ja = 5.4
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play305072029(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = "1013ui_story"

			if arg_129_1.actors_[var_132_0] == nil then
				local var_132_1 = Asset.Load("Char/" .. "1013ui_story")

				if not isNil(var_132_1) then
					local var_132_2 = Object.Instantiate(Asset.Load("Char/" .. "1013ui_story"), arg_129_1.stage_.transform)

					var_132_2.name = var_132_0
					var_132_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_129_1.actors_[var_132_0] = var_132_2

					local var_132_3 = var_132_2:GetComponentInChildren(typeof(CharacterEffect))

					var_132_3.enabled = true

					local var_132_4 = GameObjectTools.GetOrAddComponent(var_132_2, typeof(DynamicBoneHelper))

					if var_132_4 then
						var_132_4:EnableDynamicBone(false)
					end

					arg_129_1:ShowWeapon(var_132_3.transform, false)

					arg_129_1.var_[var_132_0 .. "Animator"] = var_132_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_129_1.var_[var_132_0 .. "Animator"].applyRootMotion = true
					arg_129_1.var_[var_132_0 .. "LipSync"] = var_132_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_132_5 = arg_129_1.actors_["1013ui_story"]
			local var_132_6 = 0

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect1013ui_story == nil then
				arg_129_1.var_.characterEffect1013ui_story = var_132_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_7 = 0.200000002980232

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_7 and not isNil(var_132_5) then
				local var_132_8 = (arg_129_1.time_ - var_132_6) / var_132_7

				if arg_129_1.var_.characterEffect1013ui_story and not isNil(var_132_5) then
					arg_129_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_6 + var_132_7 and arg_129_1.time_ < var_132_6 + var_132_7 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect1013ui_story then
				arg_129_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_132_9 = 0
			local var_132_10 = 0.475

			if var_132_9 < arg_129_1.time_ and arg_129_1.time_ <= var_132_9 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_11 = arg_129_1:FormatText(StoryNameCfg[35].name)

				arg_129_1.leftNameTxt_.text = var_132_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_12 = arg_129_1:GetWordFromCfg(305072028)
				local var_132_13 = arg_129_1:FormatText(var_132_12.content)

				arg_129_1.text_.text = var_132_13

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_14 = 19
				local var_132_15 = utf8.len(var_132_13)
				local var_132_16 = var_132_14 <= 0 and var_132_10 or var_132_10 * (var_132_15 / var_132_14)

				if var_132_16 > 0 and var_132_10 < var_132_16 then
					arg_129_1.talkMaxDuration = var_132_16

					if var_132_16 + var_132_9 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_16 + var_132_9
					end
				end

				arg_129_1.text_.text = var_132_13
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072028", "story_v_out_305072.awb") ~= 0 then
					local var_132_17 = manager.audio:GetVoiceLength("story_v_out_305072", "305072028", "story_v_out_305072.awb") / 1000

					if var_132_17 + var_132_9 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_17 + var_132_9
					end

					if var_132_12.prefab_name ~= "" and arg_129_1.actors_[var_132_12.prefab_name] ~= nil then
						local var_132_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_12.prefab_name].transform, "story_v_out_305072", "305072028", "story_v_out_305072.awb")

						arg_129_1:RecordAudio("305072028", var_132_18)
						arg_129_1:RecordAudio("305072028", var_132_18)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_305072", "305072028", "story_v_out_305072.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_305072", "305072028", "story_v_out_305072.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_19 = math.max(var_132_10, arg_129_1.talkMaxDuration)

			if var_132_9 <= arg_129_1.time_ and arg_129_1.time_ < var_132_9 + var_132_19 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_9) / var_132_19

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_9 + var_132_19 and arg_129_1.time_ < var_132_9 + var_132_19 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play305072029 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 305072029
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play305072030(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1013ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1013ui_story == nil then
				arg_133_1.var_.characterEffect1013ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1013ui_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1013ui_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1013ui_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1013ui_story.fillRatio = var_136_5
			end

			local var_136_6 = 0
			local var_136_7 = 1.5

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_8 = arg_133_1:GetWordFromCfg(305072029)
				local var_136_9 = arg_133_1:FormatText(var_136_8.content)

				arg_133_1.text_.text = var_136_9

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_10 = 60
				local var_136_11 = utf8.len(var_136_9)
				local var_136_12 = var_136_10 <= 0 and var_136_7 or var_136_7 * (var_136_11 / var_136_10)

				if var_136_12 > 0 and var_136_7 < var_136_12 then
					arg_133_1.talkMaxDuration = var_136_12

					if var_136_12 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_9
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_13 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_13 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_13

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_13 and arg_133_1.time_ < var_136_6 + var_136_13 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play305072030 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 305072030
		arg_137_1.duration_ = 6.9

		local var_137_0 = {
			zh = 3.366,
			ja = 6.9
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play305072031(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = "10002ui_story"

			if arg_137_1.actors_[var_140_0] == nil then
				local var_140_1 = Asset.Load("Char/" .. "10002ui_story")

				if not isNil(var_140_1) then
					local var_140_2 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_137_1.stage_.transform)

					var_140_2.name = var_140_0
					var_140_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_137_1.actors_[var_140_0] = var_140_2

					local var_140_3 = var_140_2:GetComponentInChildren(typeof(CharacterEffect))

					var_140_3.enabled = true

					local var_140_4 = GameObjectTools.GetOrAddComponent(var_140_2, typeof(DynamicBoneHelper))

					if var_140_4 then
						var_140_4:EnableDynamicBone(false)
					end

					arg_137_1:ShowWeapon(var_140_3.transform, false)

					arg_137_1.var_[var_140_0 .. "Animator"] = var_140_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_137_1.var_[var_140_0 .. "Animator"].applyRootMotion = true
					arg_137_1.var_[var_140_0 .. "LipSync"] = var_140_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_140_5 = arg_137_1.actors_["10002ui_story"]
			local var_140_6 = 0

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.characterEffect10002ui_story == nil then
				arg_137_1.var_.characterEffect10002ui_story = var_140_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_7 = 0.200000002980232

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_7 and not isNil(var_140_5) then
				local var_140_8 = (arg_137_1.time_ - var_140_6) / var_140_7

				if arg_137_1.var_.characterEffect10002ui_story and not isNil(var_140_5) then
					arg_137_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_6 + var_140_7 and arg_137_1.time_ < var_140_6 + var_140_7 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.characterEffect10002ui_story then
				arg_137_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_140_9 = 0
			local var_140_10 = 0.4

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_11 = arg_137_1:FormatText(StoryNameCfg[39].name)

				arg_137_1.leftNameTxt_.text = var_140_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_12 = arg_137_1:GetWordFromCfg(305072030)
				local var_140_13 = arg_137_1:FormatText(var_140_12.content)

				arg_137_1.text_.text = var_140_13

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_14 = 16
				local var_140_15 = utf8.len(var_140_13)
				local var_140_16 = var_140_14 <= 0 and var_140_10 or var_140_10 * (var_140_15 / var_140_14)

				if var_140_16 > 0 and var_140_10 < var_140_16 then
					arg_137_1.talkMaxDuration = var_140_16

					if var_140_16 + var_140_9 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_16 + var_140_9
					end
				end

				arg_137_1.text_.text = var_140_13
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072030", "story_v_out_305072.awb") ~= 0 then
					local var_140_17 = manager.audio:GetVoiceLength("story_v_out_305072", "305072030", "story_v_out_305072.awb") / 1000

					if var_140_17 + var_140_9 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_17 + var_140_9
					end

					if var_140_12.prefab_name ~= "" and arg_137_1.actors_[var_140_12.prefab_name] ~= nil then
						local var_140_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_12.prefab_name].transform, "story_v_out_305072", "305072030", "story_v_out_305072.awb")

						arg_137_1:RecordAudio("305072030", var_140_18)
						arg_137_1:RecordAudio("305072030", var_140_18)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_305072", "305072030", "story_v_out_305072.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_305072", "305072030", "story_v_out_305072.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_19 = math.max(var_140_10, arg_137_1.talkMaxDuration)

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_19 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_9) / var_140_19

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_9 + var_140_19 and arg_137_1.time_ < var_140_9 + var_140_19 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play305072031 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 305072031
		arg_141_1.duration_ = 8.2

		local var_141_0 = {
			zh = 5.7,
			ja = 8.2
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play305072032(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.725

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[39].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(305072031)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 29
				local var_144_6 = utf8.len(var_144_4)
				local var_144_7 = var_144_5 <= 0 and var_144_1 or var_144_1 * (var_144_6 / var_144_5)

				if var_144_7 > 0 and var_144_1 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072031", "story_v_out_305072.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_305072", "305072031", "story_v_out_305072.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_305072", "305072031", "story_v_out_305072.awb")

						arg_141_1:RecordAudio("305072031", var_144_9)
						arg_141_1:RecordAudio("305072031", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_305072", "305072031", "story_v_out_305072.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_305072", "305072031", "story_v_out_305072.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_10 and arg_141_1.time_ < var_144_0 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play305072032 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 305072032
		arg_145_1.duration_ = 7.57

		local var_145_0 = {
			zh = 4.8,
			ja = 7.566
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play305072033(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1013ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1013ui_story == nil then
				arg_145_1.var_.characterEffect1013ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect1013ui_story and not isNil(var_148_0) then
					arg_145_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1013ui_story then
				arg_145_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_148_4 = arg_145_1.actors_["10002ui_story"]
			local var_148_5 = 0

			if var_148_5 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect10002ui_story == nil then
				arg_145_1.var_.characterEffect10002ui_story = var_148_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_6 = 0.200000002980232

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_6 and not isNil(var_148_4) then
				local var_148_7 = (arg_145_1.time_ - var_148_5) / var_148_6

				if arg_145_1.var_.characterEffect10002ui_story and not isNil(var_148_4) then
					local var_148_8 = Mathf.Lerp(0, 0.5, var_148_7)

					arg_145_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10002ui_story.fillRatio = var_148_8
				end
			end

			if arg_145_1.time_ >= var_148_5 + var_148_6 and arg_145_1.time_ < var_148_5 + var_148_6 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect10002ui_story then
				local var_148_9 = 0.5

				arg_145_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10002ui_story.fillRatio = var_148_9
			end

			local var_148_10 = 0
			local var_148_11 = 0.6

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_12 = arg_145_1:FormatText(StoryNameCfg[35].name)

				arg_145_1.leftNameTxt_.text = var_148_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_13 = arg_145_1:GetWordFromCfg(305072032)
				local var_148_14 = arg_145_1:FormatText(var_148_13.content)

				arg_145_1.text_.text = var_148_14

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_15 = 24
				local var_148_16 = utf8.len(var_148_14)
				local var_148_17 = var_148_15 <= 0 and var_148_11 or var_148_11 * (var_148_16 / var_148_15)

				if var_148_17 > 0 and var_148_11 < var_148_17 then
					arg_145_1.talkMaxDuration = var_148_17

					if var_148_17 + var_148_10 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_17 + var_148_10
					end
				end

				arg_145_1.text_.text = var_148_14
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072032", "story_v_out_305072.awb") ~= 0 then
					local var_148_18 = manager.audio:GetVoiceLength("story_v_out_305072", "305072032", "story_v_out_305072.awb") / 1000

					if var_148_18 + var_148_10 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_18 + var_148_10
					end

					if var_148_13.prefab_name ~= "" and arg_145_1.actors_[var_148_13.prefab_name] ~= nil then
						local var_148_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_13.prefab_name].transform, "story_v_out_305072", "305072032", "story_v_out_305072.awb")

						arg_145_1:RecordAudio("305072032", var_148_19)
						arg_145_1:RecordAudio("305072032", var_148_19)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_305072", "305072032", "story_v_out_305072.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_305072", "305072032", "story_v_out_305072.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_20 = math.max(var_148_11, arg_145_1.talkMaxDuration)

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_20 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_10) / var_148_20

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_10 + var_148_20 and arg_145_1.time_ < var_148_10 + var_148_20 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play305072033 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 305072033
		arg_149_1.duration_ = 8.2

		local var_149_0 = {
			zh = 6.966,
			ja = 8.2
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play305072034(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10002ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect10002ui_story == nil then
				arg_149_1.var_.characterEffect10002ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect10002ui_story and not isNil(var_152_0) then
					arg_149_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect10002ui_story then
				arg_149_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_152_4 = arg_149_1.actors_["1013ui_story"]
			local var_152_5 = 0

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1013ui_story == nil then
				arg_149_1.var_.characterEffect1013ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_6 = 0.200000002980232

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_6 and not isNil(var_152_4) then
				local var_152_7 = (arg_149_1.time_ - var_152_5) / var_152_6

				if arg_149_1.var_.characterEffect1013ui_story and not isNil(var_152_4) then
					local var_152_8 = Mathf.Lerp(0, 0.5, var_152_7)

					arg_149_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1013ui_story.fillRatio = var_152_8
				end
			end

			if arg_149_1.time_ >= var_152_5 + var_152_6 and arg_149_1.time_ < var_152_5 + var_152_6 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1013ui_story then
				local var_152_9 = 0.5

				arg_149_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1013ui_story.fillRatio = var_152_9
			end

			local var_152_10 = 0
			local var_152_11 = 0.95

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_12 = arg_149_1:FormatText(StoryNameCfg[39].name)

				arg_149_1.leftNameTxt_.text = var_152_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_13 = arg_149_1:GetWordFromCfg(305072033)
				local var_152_14 = arg_149_1:FormatText(var_152_13.content)

				arg_149_1.text_.text = var_152_14

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_15 = 38
				local var_152_16 = utf8.len(var_152_14)
				local var_152_17 = var_152_15 <= 0 and var_152_11 or var_152_11 * (var_152_16 / var_152_15)

				if var_152_17 > 0 and var_152_11 < var_152_17 then
					arg_149_1.talkMaxDuration = var_152_17

					if var_152_17 + var_152_10 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_17 + var_152_10
					end
				end

				arg_149_1.text_.text = var_152_14
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072033", "story_v_out_305072.awb") ~= 0 then
					local var_152_18 = manager.audio:GetVoiceLength("story_v_out_305072", "305072033", "story_v_out_305072.awb") / 1000

					if var_152_18 + var_152_10 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_18 + var_152_10
					end

					if var_152_13.prefab_name ~= "" and arg_149_1.actors_[var_152_13.prefab_name] ~= nil then
						local var_152_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_13.prefab_name].transform, "story_v_out_305072", "305072033", "story_v_out_305072.awb")

						arg_149_1:RecordAudio("305072033", var_152_19)
						arg_149_1:RecordAudio("305072033", var_152_19)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_305072", "305072033", "story_v_out_305072.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_305072", "305072033", "story_v_out_305072.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_20 = math.max(var_152_11, arg_149_1.talkMaxDuration)

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_20 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_10) / var_152_20

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_10 + var_152_20 and arg_149_1.time_ < var_152_10 + var_152_20 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play305072034 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 305072034
		arg_153_1.duration_ = 7.03

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play305072035(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10002ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect10002ui_story == nil then
				arg_153_1.var_.characterEffect10002ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect10002ui_story and not isNil(var_156_0) then
					local var_156_4 = Mathf.Lerp(0, 0.5, var_156_3)

					arg_153_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10002ui_story.fillRatio = var_156_4
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect10002ui_story then
				local var_156_5 = 0.5

				arg_153_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10002ui_story.fillRatio = var_156_5
			end

			local var_156_6 = arg_153_1.bgs_.S0507.transform
			local var_156_7 = 0

			if var_156_7 < arg_153_1.time_ and arg_153_1.time_ <= var_156_7 + arg_156_0 then
				arg_153_1.var_.moveOldPosS0507 = var_156_6.localPosition
			end

			local var_156_8 = 1.8

			if var_156_7 <= arg_153_1.time_ and arg_153_1.time_ < var_156_7 + var_156_8 then
				local var_156_9 = (arg_153_1.time_ - var_156_7) / var_156_8
				local var_156_10 = Vector3.New(0, 0.56, 7)

				var_156_6.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPosS0507, var_156_10, var_156_9)
			end

			if arg_153_1.time_ >= var_156_7 + var_156_8 and arg_153_1.time_ < var_156_7 + var_156_8 + arg_156_0 then
				var_156_6.localPosition = Vector3.New(0, 0.56, 7)
			end

			local var_156_11 = manager.ui.mainCamera.transform
			local var_156_12 = 0.6

			if var_156_12 < arg_153_1.time_ and arg_153_1.time_ <= var_156_12 + arg_156_0 then
				local var_156_13 = arg_153_1.var_.effect忍忍忍人
				local var_156_14
				local var_156_15 = var_156_11

				if not var_156_13 then
					var_156_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_datablock_white"), var_156_15)
					var_156_13.name = "忍忍忍人"
					arg_153_1.var_.effect忍忍忍人 = var_156_13
				else
					var_156_13.transform:SetParent(var_156_15)
				end

				var_156_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_156_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_156_16 = manager.ui.mainCamera.transform
			local var_156_17 = 4.73572979485616

			if var_156_17 < arg_153_1.time_ and arg_153_1.time_ <= var_156_17 + arg_156_0 then
				local var_156_18 = arg_153_1.var_.effect忍忍忍人

				if var_156_18 then
					Object.Destroy(var_156_18)

					arg_153_1.var_.effect忍忍忍人 = nil
				end
			end

			local var_156_19 = 0

			if var_156_19 < arg_153_1.time_ and arg_153_1.time_ <= var_156_19 + arg_156_0 then
				arg_153_1.allBtn_.enabled = false
			end

			local var_156_20 = 2.03333333333333

			if arg_153_1.time_ >= var_156_19 + var_156_20 and arg_153_1.time_ < var_156_19 + var_156_20 + arg_156_0 then
				arg_153_1.allBtn_.enabled = true
			end

			if arg_153_1.frameCnt_ <= 1 then
				arg_153_1.dialog_:SetActive(false)
			end

			local var_156_21 = 2.03333333333333
			local var_156_22 = 1.425

			if var_156_21 < arg_153_1.time_ and arg_153_1.time_ <= var_156_21 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				arg_153_1.dialog_:SetActive(true)

				arg_153_1.dialogCg_.alpha = 0

				local var_156_23 = LeanTween.value(arg_153_1.dialog_, 0, 1, 0.3)

				var_156_23:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_153_1.dialogCg_.alpha = arg_157_0
				end))
				var_156_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_153_1.dialog_)
					var_156_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_153_1.duration_ = arg_153_1.duration_ + 0.3

				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_24 = arg_153_1:GetWordFromCfg(305072034)
				local var_156_25 = arg_153_1:FormatText(var_156_24.content)

				arg_153_1.text_.text = var_156_25

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_26 = 57
				local var_156_27 = utf8.len(var_156_25)
				local var_156_28 = var_156_26 <= 0 and var_156_22 or var_156_22 * (var_156_27 / var_156_26)

				if var_156_28 > 0 and var_156_22 < var_156_28 then
					arg_153_1.talkMaxDuration = var_156_28
					var_156_21 = var_156_21 + 0.3

					if var_156_28 + var_156_21 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_28 + var_156_21
					end
				end

				arg_153_1.text_.text = var_156_25
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_29 = var_156_21 + 0.3
			local var_156_30 = math.max(var_156_22, arg_153_1.talkMaxDuration)

			if var_156_29 <= arg_153_1.time_ and arg_153_1.time_ < var_156_29 + var_156_30 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_29) / var_156_30

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_29 + var_156_30 and arg_153_1.time_ < var_156_29 + var_156_30 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "S0507",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.8,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 0.56, 7),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play305072035 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 305072035
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play305072036(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 1.25

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_2 = arg_159_1:GetWordFromCfg(305072035)
				local var_162_3 = arg_159_1:FormatText(var_162_2.content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 50
				local var_162_5 = utf8.len(var_162_3)
				local var_162_6 = var_162_4 <= 0 and var_162_1 or var_162_1 * (var_162_5 / var_162_4)

				if var_162_6 > 0 and var_162_1 < var_162_6 then
					arg_159_1.talkMaxDuration = var_162_6

					if var_162_6 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_7 and arg_159_1.time_ < var_162_0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play305072036 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 305072036
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play305072037(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.85

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_2 = arg_163_1:GetWordFromCfg(305072036)
				local var_166_3 = arg_163_1:FormatText(var_166_2.content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 34
				local var_166_5 = utf8.len(var_166_3)
				local var_166_6 = var_166_4 <= 0 and var_166_1 or var_166_1 * (var_166_5 / var_166_4)

				if var_166_6 > 0 and var_166_1 < var_166_6 then
					arg_163_1.talkMaxDuration = var_166_6

					if var_166_6 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_7 and arg_163_1.time_ < var_166_0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play305072037 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 305072037
		arg_167_1.duration_ = 5.87

		local var_167_0 = {
			zh = 5.866,
			ja = 4.4
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
				arg_167_0:Play305072038(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10002ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10002ui_story == nil then
				arg_167_1.var_.characterEffect10002ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect10002ui_story and not isNil(var_170_0) then
					arg_167_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10002ui_story then
				arg_167_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_170_4 = 0
			local var_170_5 = 0.375

			if var_170_4 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_6 = arg_167_1:FormatText(StoryNameCfg[39].name)

				arg_167_1.leftNameTxt_.text = var_170_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_7 = arg_167_1:GetWordFromCfg(305072037)
				local var_170_8 = arg_167_1:FormatText(var_170_7.content)

				arg_167_1.text_.text = var_170_8

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 15
				local var_170_10 = utf8.len(var_170_8)
				local var_170_11 = var_170_9 <= 0 and var_170_5 or var_170_5 * (var_170_10 / var_170_9)

				if var_170_11 > 0 and var_170_5 < var_170_11 then
					arg_167_1.talkMaxDuration = var_170_11

					if var_170_11 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_8
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072037", "story_v_out_305072.awb") ~= 0 then
					local var_170_12 = manager.audio:GetVoiceLength("story_v_out_305072", "305072037", "story_v_out_305072.awb") / 1000

					if var_170_12 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_12 + var_170_4
					end

					if var_170_7.prefab_name ~= "" and arg_167_1.actors_[var_170_7.prefab_name] ~= nil then
						local var_170_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_7.prefab_name].transform, "story_v_out_305072", "305072037", "story_v_out_305072.awb")

						arg_167_1:RecordAudio("305072037", var_170_13)
						arg_167_1:RecordAudio("305072037", var_170_13)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_305072", "305072037", "story_v_out_305072.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_305072", "305072037", "story_v_out_305072.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_14 and arg_167_1.time_ < var_170_4 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play305072038 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 305072038
		arg_171_1.duration_ = 4.43

		local var_171_0 = {
			zh = 3.5,
			ja = 4.433
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
				arg_171_0:Play305072039(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1013ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1013ui_story == nil then
				arg_171_1.var_.characterEffect1013ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect1013ui_story and not isNil(var_174_0) then
					arg_171_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1013ui_story then
				arg_171_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_174_4 = arg_171_1.actors_["10002ui_story"]
			local var_174_5 = 0

			if var_174_5 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect10002ui_story == nil then
				arg_171_1.var_.characterEffect10002ui_story = var_174_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_6 = 0.200000002980232

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_6 and not isNil(var_174_4) then
				local var_174_7 = (arg_171_1.time_ - var_174_5) / var_174_6

				if arg_171_1.var_.characterEffect10002ui_story and not isNil(var_174_4) then
					local var_174_8 = Mathf.Lerp(0, 0.5, var_174_7)

					arg_171_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10002ui_story.fillRatio = var_174_8
				end
			end

			if arg_171_1.time_ >= var_174_5 + var_174_6 and arg_171_1.time_ < var_174_5 + var_174_6 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect10002ui_story then
				local var_174_9 = 0.5

				arg_171_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10002ui_story.fillRatio = var_174_9
			end

			local var_174_10 = 0
			local var_174_11 = 0.325

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_12 = arg_171_1:FormatText(StoryNameCfg[35].name)

				arg_171_1.leftNameTxt_.text = var_174_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_13 = arg_171_1:GetWordFromCfg(305072038)
				local var_174_14 = arg_171_1:FormatText(var_174_13.content)

				arg_171_1.text_.text = var_174_14

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_15 = 13
				local var_174_16 = utf8.len(var_174_14)
				local var_174_17 = var_174_15 <= 0 and var_174_11 or var_174_11 * (var_174_16 / var_174_15)

				if var_174_17 > 0 and var_174_11 < var_174_17 then
					arg_171_1.talkMaxDuration = var_174_17

					if var_174_17 + var_174_10 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_17 + var_174_10
					end
				end

				arg_171_1.text_.text = var_174_14
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072038", "story_v_out_305072.awb") ~= 0 then
					local var_174_18 = manager.audio:GetVoiceLength("story_v_out_305072", "305072038", "story_v_out_305072.awb") / 1000

					if var_174_18 + var_174_10 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_18 + var_174_10
					end

					if var_174_13.prefab_name ~= "" and arg_171_1.actors_[var_174_13.prefab_name] ~= nil then
						local var_174_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_13.prefab_name].transform, "story_v_out_305072", "305072038", "story_v_out_305072.awb")

						arg_171_1:RecordAudio("305072038", var_174_19)
						arg_171_1:RecordAudio("305072038", var_174_19)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_305072", "305072038", "story_v_out_305072.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_305072", "305072038", "story_v_out_305072.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_20 = math.max(var_174_11, arg_171_1.talkMaxDuration)

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_20 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_10) / var_174_20

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_10 + var_174_20 and arg_171_1.time_ < var_174_10 + var_174_20 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play305072039 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 305072039
		arg_175_1.duration_ = 9.9

		local var_175_0 = {
			zh = 9.4,
			ja = 9.9
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
				arg_175_0:Play305072040(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10002ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect10002ui_story == nil then
				arg_175_1.var_.characterEffect10002ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect10002ui_story and not isNil(var_178_0) then
					arg_175_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect10002ui_story then
				arg_175_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_178_4 = arg_175_1.actors_["1013ui_story"]
			local var_178_5 = 0

			if var_178_5 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.characterEffect1013ui_story == nil then
				arg_175_1.var_.characterEffect1013ui_story = var_178_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_6 = 0.200000002980232

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_6 and not isNil(var_178_4) then
				local var_178_7 = (arg_175_1.time_ - var_178_5) / var_178_6

				if arg_175_1.var_.characterEffect1013ui_story and not isNil(var_178_4) then
					local var_178_8 = Mathf.Lerp(0, 0.5, var_178_7)

					arg_175_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1013ui_story.fillRatio = var_178_8
				end
			end

			if arg_175_1.time_ >= var_178_5 + var_178_6 and arg_175_1.time_ < var_178_5 + var_178_6 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.characterEffect1013ui_story then
				local var_178_9 = 0.5

				arg_175_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1013ui_story.fillRatio = var_178_9
			end

			local var_178_10 = 0
			local var_178_11 = 0.625

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_12 = arg_175_1:FormatText(StoryNameCfg[39].name)

				arg_175_1.leftNameTxt_.text = var_178_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_13 = arg_175_1:GetWordFromCfg(305072039)
				local var_178_14 = arg_175_1:FormatText(var_178_13.content)

				arg_175_1.text_.text = var_178_14

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_15 = 25
				local var_178_16 = utf8.len(var_178_14)
				local var_178_17 = var_178_15 <= 0 and var_178_11 or var_178_11 * (var_178_16 / var_178_15)

				if var_178_17 > 0 and var_178_11 < var_178_17 then
					arg_175_1.talkMaxDuration = var_178_17

					if var_178_17 + var_178_10 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_17 + var_178_10
					end
				end

				arg_175_1.text_.text = var_178_14
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072039", "story_v_out_305072.awb") ~= 0 then
					local var_178_18 = manager.audio:GetVoiceLength("story_v_out_305072", "305072039", "story_v_out_305072.awb") / 1000

					if var_178_18 + var_178_10 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_18 + var_178_10
					end

					if var_178_13.prefab_name ~= "" and arg_175_1.actors_[var_178_13.prefab_name] ~= nil then
						local var_178_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_13.prefab_name].transform, "story_v_out_305072", "305072039", "story_v_out_305072.awb")

						arg_175_1:RecordAudio("305072039", var_178_19)
						arg_175_1:RecordAudio("305072039", var_178_19)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_305072", "305072039", "story_v_out_305072.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_305072", "305072039", "story_v_out_305072.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_20 = math.max(var_178_11, arg_175_1.talkMaxDuration)

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_20 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_10) / var_178_20

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_10 + var_178_20 and arg_175_1.time_ < var_178_10 + var_178_20 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play305072040 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 305072040
		arg_179_1.duration_ = 18.67

		local var_179_0 = {
			zh = 11.666,
			ja = 18.666
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play305072041(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 1.05

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[39].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:GetWordFromCfg(305072040)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 42
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072040", "story_v_out_305072.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_305072", "305072040", "story_v_out_305072.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_305072", "305072040", "story_v_out_305072.awb")

						arg_179_1:RecordAudio("305072040", var_182_9)
						arg_179_1:RecordAudio("305072040", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_305072", "305072040", "story_v_out_305072.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_305072", "305072040", "story_v_out_305072.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_10 and arg_179_1.time_ < var_182_0 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play305072041 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 305072041
		arg_183_1.duration_ = 12.5

		local var_183_0 = {
			zh = 10.333,
			ja = 12.5
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
				arg_183_0:Play305072042(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.875

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[39].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:GetWordFromCfg(305072041)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 35
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072041", "story_v_out_305072.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_305072", "305072041", "story_v_out_305072.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_305072", "305072041", "story_v_out_305072.awb")

						arg_183_1:RecordAudio("305072041", var_186_9)
						arg_183_1:RecordAudio("305072041", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_305072", "305072041", "story_v_out_305072.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_305072", "305072041", "story_v_out_305072.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_10 and arg_183_1.time_ < var_186_0 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play305072042 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 305072042
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play305072043(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10002ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect10002ui_story == nil then
				arg_187_1.var_.characterEffect10002ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect10002ui_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10002ui_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect10002ui_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10002ui_story.fillRatio = var_190_5
			end

			local var_190_6 = 0
			local var_190_7 = 0.55

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_8 = arg_187_1:GetWordFromCfg(305072042)
				local var_190_9 = arg_187_1:FormatText(var_190_8.content)

				arg_187_1.text_.text = var_190_9

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_10 = 22
				local var_190_11 = utf8.len(var_190_9)
				local var_190_12 = var_190_10 <= 0 and var_190_7 or var_190_7 * (var_190_11 / var_190_10)

				if var_190_12 > 0 and var_190_7 < var_190_12 then
					arg_187_1.talkMaxDuration = var_190_12

					if var_190_12 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_12 + var_190_6
					end
				end

				arg_187_1.text_.text = var_190_9
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_13 = math.max(var_190_7, arg_187_1.talkMaxDuration)

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_13 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_6) / var_190_13

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_6 + var_190_13 and arg_187_1.time_ < var_190_6 + var_190_13 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play305072043 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 305072043
		arg_191_1.duration_ = 5.97

		local var_191_0 = {
			zh = 4.3,
			ja = 5.966
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
				arg_191_0:Play305072044(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10002ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect10002ui_story == nil then
				arg_191_1.var_.characterEffect10002ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect10002ui_story and not isNil(var_194_0) then
					arg_191_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect10002ui_story then
				arg_191_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_194_4 = 0
			local var_194_5 = 0.425

			if var_194_4 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_6 = arg_191_1:FormatText(StoryNameCfg[39].name)

				arg_191_1.leftNameTxt_.text = var_194_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_7 = arg_191_1:GetWordFromCfg(305072043)
				local var_194_8 = arg_191_1:FormatText(var_194_7.content)

				arg_191_1.text_.text = var_194_8

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 17
				local var_194_10 = utf8.len(var_194_8)
				local var_194_11 = var_194_9 <= 0 and var_194_5 or var_194_5 * (var_194_10 / var_194_9)

				if var_194_11 > 0 and var_194_5 < var_194_11 then
					arg_191_1.talkMaxDuration = var_194_11

					if var_194_11 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_8
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072043", "story_v_out_305072.awb") ~= 0 then
					local var_194_12 = manager.audio:GetVoiceLength("story_v_out_305072", "305072043", "story_v_out_305072.awb") / 1000

					if var_194_12 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_12 + var_194_4
					end

					if var_194_7.prefab_name ~= "" and arg_191_1.actors_[var_194_7.prefab_name] ~= nil then
						local var_194_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_7.prefab_name].transform, "story_v_out_305072", "305072043", "story_v_out_305072.awb")

						arg_191_1:RecordAudio("305072043", var_194_13)
						arg_191_1:RecordAudio("305072043", var_194_13)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_305072", "305072043", "story_v_out_305072.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_305072", "305072043", "story_v_out_305072.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_14 = math.max(var_194_5, arg_191_1.talkMaxDuration)

			if var_194_4 <= arg_191_1.time_ and arg_191_1.time_ < var_194_4 + var_194_14 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_4) / var_194_14

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_4 + var_194_14 and arg_191_1.time_ < var_194_4 + var_194_14 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play305072044 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 305072044
		arg_195_1.duration_ = 5.77

		local var_195_0 = {
			zh = 3.366,
			ja = 5.766
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play305072045(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1013ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1013ui_story == nil then
				arg_195_1.var_.characterEffect1013ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect1013ui_story and not isNil(var_198_0) then
					arg_195_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1013ui_story then
				arg_195_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_198_4 = arg_195_1.actors_["10002ui_story"]
			local var_198_5 = 0

			if var_198_5 < arg_195_1.time_ and arg_195_1.time_ <= var_198_5 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect10002ui_story == nil then
				arg_195_1.var_.characterEffect10002ui_story = var_198_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_6 = 0.200000002980232

			if var_198_5 <= arg_195_1.time_ and arg_195_1.time_ < var_198_5 + var_198_6 and not isNil(var_198_4) then
				local var_198_7 = (arg_195_1.time_ - var_198_5) / var_198_6

				if arg_195_1.var_.characterEffect10002ui_story and not isNil(var_198_4) then
					local var_198_8 = Mathf.Lerp(0, 0.5, var_198_7)

					arg_195_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10002ui_story.fillRatio = var_198_8
				end
			end

			if arg_195_1.time_ >= var_198_5 + var_198_6 and arg_195_1.time_ < var_198_5 + var_198_6 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect10002ui_story then
				local var_198_9 = 0.5

				arg_195_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10002ui_story.fillRatio = var_198_9
			end

			local var_198_10 = 0
			local var_198_11 = 0.375

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_12 = arg_195_1:FormatText(StoryNameCfg[35].name)

				arg_195_1.leftNameTxt_.text = var_198_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_13 = arg_195_1:GetWordFromCfg(305072044)
				local var_198_14 = arg_195_1:FormatText(var_198_13.content)

				arg_195_1.text_.text = var_198_14

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_15 = 15
				local var_198_16 = utf8.len(var_198_14)
				local var_198_17 = var_198_15 <= 0 and var_198_11 or var_198_11 * (var_198_16 / var_198_15)

				if var_198_17 > 0 and var_198_11 < var_198_17 then
					arg_195_1.talkMaxDuration = var_198_17

					if var_198_17 + var_198_10 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_17 + var_198_10
					end
				end

				arg_195_1.text_.text = var_198_14
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072044", "story_v_out_305072.awb") ~= 0 then
					local var_198_18 = manager.audio:GetVoiceLength("story_v_out_305072", "305072044", "story_v_out_305072.awb") / 1000

					if var_198_18 + var_198_10 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_18 + var_198_10
					end

					if var_198_13.prefab_name ~= "" and arg_195_1.actors_[var_198_13.prefab_name] ~= nil then
						local var_198_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_13.prefab_name].transform, "story_v_out_305072", "305072044", "story_v_out_305072.awb")

						arg_195_1:RecordAudio("305072044", var_198_19)
						arg_195_1:RecordAudio("305072044", var_198_19)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_305072", "305072044", "story_v_out_305072.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_305072", "305072044", "story_v_out_305072.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_20 = math.max(var_198_11, arg_195_1.talkMaxDuration)

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_20 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_10) / var_198_20

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_10 + var_198_20 and arg_195_1.time_ < var_198_10 + var_198_20 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play305072045 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 305072045
		arg_199_1.duration_ = 11.1

		local var_199_0 = {
			zh = 11.1,
			ja = 9
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play305072046(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10002ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect10002ui_story == nil then
				arg_199_1.var_.characterEffect10002ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect10002ui_story and not isNil(var_202_0) then
					arg_199_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect10002ui_story then
				arg_199_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_202_4 = arg_199_1.actors_["1013ui_story"]
			local var_202_5 = 0

			if var_202_5 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 and not isNil(var_202_4) and arg_199_1.var_.characterEffect1013ui_story == nil then
				arg_199_1.var_.characterEffect1013ui_story = var_202_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_6 = 0.200000002980232

			if var_202_5 <= arg_199_1.time_ and arg_199_1.time_ < var_202_5 + var_202_6 and not isNil(var_202_4) then
				local var_202_7 = (arg_199_1.time_ - var_202_5) / var_202_6

				if arg_199_1.var_.characterEffect1013ui_story and not isNil(var_202_4) then
					local var_202_8 = Mathf.Lerp(0, 0.5, var_202_7)

					arg_199_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1013ui_story.fillRatio = var_202_8
				end
			end

			if arg_199_1.time_ >= var_202_5 + var_202_6 and arg_199_1.time_ < var_202_5 + var_202_6 + arg_202_0 and not isNil(var_202_4) and arg_199_1.var_.characterEffect1013ui_story then
				local var_202_9 = 0.5

				arg_199_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1013ui_story.fillRatio = var_202_9
			end

			local var_202_10 = 0
			local var_202_11 = 0.725

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_12 = arg_199_1:FormatText(StoryNameCfg[39].name)

				arg_199_1.leftNameTxt_.text = var_202_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_13 = arg_199_1:GetWordFromCfg(305072045)
				local var_202_14 = arg_199_1:FormatText(var_202_13.content)

				arg_199_1.text_.text = var_202_14

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_15 = 29
				local var_202_16 = utf8.len(var_202_14)
				local var_202_17 = var_202_15 <= 0 and var_202_11 or var_202_11 * (var_202_16 / var_202_15)

				if var_202_17 > 0 and var_202_11 < var_202_17 then
					arg_199_1.talkMaxDuration = var_202_17

					if var_202_17 + var_202_10 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_17 + var_202_10
					end
				end

				arg_199_1.text_.text = var_202_14
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072045", "story_v_out_305072.awb") ~= 0 then
					local var_202_18 = manager.audio:GetVoiceLength("story_v_out_305072", "305072045", "story_v_out_305072.awb") / 1000

					if var_202_18 + var_202_10 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_18 + var_202_10
					end

					if var_202_13.prefab_name ~= "" and arg_199_1.actors_[var_202_13.prefab_name] ~= nil then
						local var_202_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_13.prefab_name].transform, "story_v_out_305072", "305072045", "story_v_out_305072.awb")

						arg_199_1:RecordAudio("305072045", var_202_19)
						arg_199_1:RecordAudio("305072045", var_202_19)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_305072", "305072045", "story_v_out_305072.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_305072", "305072045", "story_v_out_305072.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_20 = math.max(var_202_11, arg_199_1.talkMaxDuration)

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_20 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_10) / var_202_20

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_10 + var_202_20 and arg_199_1.time_ < var_202_10 + var_202_20 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play305072046 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 305072046
		arg_203_1.duration_ = 7.63

		local var_203_0 = {
			zh = 7.633,
			ja = 5.366
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play305072047(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.425

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[39].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:GetWordFromCfg(305072046)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 17
				local var_206_6 = utf8.len(var_206_4)
				local var_206_7 = var_206_5 <= 0 and var_206_1 or var_206_1 * (var_206_6 / var_206_5)

				if var_206_7 > 0 and var_206_1 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072046", "story_v_out_305072.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_305072", "305072046", "story_v_out_305072.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_305072", "305072046", "story_v_out_305072.awb")

						arg_203_1:RecordAudio("305072046", var_206_9)
						arg_203_1:RecordAudio("305072046", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_305072", "305072046", "story_v_out_305072.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_305072", "305072046", "story_v_out_305072.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_10 and arg_203_1.time_ < var_206_0 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play305072047 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 305072047
		arg_207_1.duration_ = 8.23

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play305072048(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = "B06b"

			if arg_207_1.bgs_[var_210_0] == nil then
				local var_210_1 = Object.Instantiate(arg_207_1.paintGo_)

				var_210_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_210_0)
				var_210_1.name = var_210_0
				var_210_1.transform.parent = arg_207_1.stage_.transform
				var_210_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.bgs_[var_210_0] = var_210_1
			end

			local var_210_2 = 1.999999999999

			if var_210_2 < arg_207_1.time_ and arg_207_1.time_ <= var_210_2 + arg_210_0 then
				local var_210_3 = manager.ui.mainCamera.transform.localPosition
				local var_210_4 = Vector3.New(0, 0, 10) + Vector3.New(var_210_3.x, var_210_3.y, 0)
				local var_210_5 = arg_207_1.bgs_.B06b

				var_210_5.transform.localPosition = var_210_4
				var_210_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_6 = var_210_5:GetComponent("SpriteRenderer")

				if var_210_6 and var_210_6.sprite then
					local var_210_7 = (var_210_5.transform.localPosition - var_210_3).z
					local var_210_8 = manager.ui.mainCameraCom_
					local var_210_9 = 2 * var_210_7 * Mathf.Tan(var_210_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_210_10 = var_210_9 * var_210_8.aspect
					local var_210_11 = var_210_6.sprite.bounds.size.x
					local var_210_12 = var_210_6.sprite.bounds.size.y
					local var_210_13 = var_210_10 / var_210_11
					local var_210_14 = var_210_9 / var_210_12
					local var_210_15 = var_210_14 < var_210_13 and var_210_13 or var_210_14

					var_210_5.transform.localScale = Vector3.New(var_210_15, var_210_15, 0)
				end

				for iter_210_0, iter_210_1 in pairs(arg_207_1.bgs_) do
					if iter_210_0 ~= "B06b" then
						iter_210_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_210_16 = 0

			if var_210_16 < arg_207_1.time_ and arg_207_1.time_ <= var_210_16 + arg_210_0 then
				arg_207_1.allBtn_.enabled = false
			end

			local var_210_17 = 0.3

			if arg_207_1.time_ >= var_210_16 + var_210_17 and arg_207_1.time_ < var_210_16 + var_210_17 + arg_210_0 then
				arg_207_1.allBtn_.enabled = true
			end

			local var_210_18 = 0

			if var_210_18 < arg_207_1.time_ and arg_207_1.time_ <= var_210_18 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_19 = 2

			if var_210_18 <= arg_207_1.time_ and arg_207_1.time_ < var_210_18 + var_210_19 then
				local var_210_20 = (arg_207_1.time_ - var_210_18) / var_210_19
				local var_210_21 = Color.New(0, 0, 0)

				var_210_21.a = Mathf.Lerp(0, 1, var_210_20)
				arg_207_1.mask_.color = var_210_21
			end

			if arg_207_1.time_ >= var_210_18 + var_210_19 and arg_207_1.time_ < var_210_18 + var_210_19 + arg_210_0 then
				local var_210_22 = Color.New(0, 0, 0)

				var_210_22.a = 1
				arg_207_1.mask_.color = var_210_22
			end

			local var_210_23 = 2

			if var_210_23 < arg_207_1.time_ and arg_207_1.time_ <= var_210_23 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_24 = 2

			if var_210_23 <= arg_207_1.time_ and arg_207_1.time_ < var_210_23 + var_210_24 then
				local var_210_25 = (arg_207_1.time_ - var_210_23) / var_210_24
				local var_210_26 = Color.New(0, 0, 0)

				var_210_26.a = Mathf.Lerp(1, 0, var_210_25)
				arg_207_1.mask_.color = var_210_26
			end

			if arg_207_1.time_ >= var_210_23 + var_210_24 and arg_207_1.time_ < var_210_23 + var_210_24 + arg_210_0 then
				local var_210_27 = Color.New(0, 0, 0)
				local var_210_28 = 0

				arg_207_1.mask_.enabled = false
				var_210_27.a = var_210_28
				arg_207_1.mask_.color = var_210_27
			end

			local var_210_29 = arg_207_1.actors_["10002ui_story"]
			local var_210_30 = 0

			if var_210_30 < arg_207_1.time_ and arg_207_1.time_ <= var_210_30 + arg_210_0 and not isNil(var_210_29) and arg_207_1.var_.characterEffect10002ui_story == nil then
				arg_207_1.var_.characterEffect10002ui_story = var_210_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_31 = 0.200000002980232

			if var_210_30 <= arg_207_1.time_ and arg_207_1.time_ < var_210_30 + var_210_31 and not isNil(var_210_29) then
				local var_210_32 = (arg_207_1.time_ - var_210_30) / var_210_31

				if arg_207_1.var_.characterEffect10002ui_story and not isNil(var_210_29) then
					local var_210_33 = Mathf.Lerp(0, 0.5, var_210_32)

					arg_207_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10002ui_story.fillRatio = var_210_33
				end
			end

			if arg_207_1.time_ >= var_210_30 + var_210_31 and arg_207_1.time_ < var_210_30 + var_210_31 + arg_210_0 and not isNil(var_210_29) and arg_207_1.var_.characterEffect10002ui_story then
				local var_210_34 = 0.5

				arg_207_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10002ui_story.fillRatio = var_210_34
			end

			local var_210_35 = 1.2
			local var_210_36 = 1

			if var_210_35 < arg_207_1.time_ and arg_207_1.time_ <= var_210_35 + arg_210_0 then
				local var_210_37 = "play"
				local var_210_38 = "effect"

				arg_207_1:AudioAction(var_210_37, var_210_38, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_210_39 = 0.2
			local var_210_40 = 1

			if var_210_39 < arg_207_1.time_ and arg_207_1.time_ <= var_210_39 + arg_210_0 then
				local var_210_41 = "stop"
				local var_210_42 = "effect"

				arg_207_1:AudioAction(var_210_41, var_210_42, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if arg_207_1.frameCnt_ <= 1 then
				arg_207_1.dialog_:SetActive(false)
			end

			local var_210_43 = 3.23333333333333
			local var_210_44 = 1.55

			if var_210_43 < arg_207_1.time_ and arg_207_1.time_ <= var_210_43 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0

				arg_207_1.dialog_:SetActive(true)

				arg_207_1.dialogCg_.alpha = 0

				local var_210_45 = LeanTween.value(arg_207_1.dialog_, 0, 1, 0.3)

				var_210_45:setOnUpdate(LuaHelper.FloatAction(function(arg_211_0)
					arg_207_1.dialogCg_.alpha = arg_211_0
				end))
				var_210_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_207_1.dialog_)
					var_210_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_207_1.duration_ = arg_207_1.duration_ + 0.3

				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_46 = arg_207_1:GetWordFromCfg(305072047)
				local var_210_47 = arg_207_1:FormatText(var_210_46.content)

				arg_207_1.text_.text = var_210_47

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_48 = 62
				local var_210_49 = utf8.len(var_210_47)
				local var_210_50 = var_210_48 <= 0 and var_210_44 or var_210_44 * (var_210_49 / var_210_48)

				if var_210_50 > 0 and var_210_44 < var_210_50 then
					arg_207_1.talkMaxDuration = var_210_50
					var_210_43 = var_210_43 + 0.3

					if var_210_50 + var_210_43 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_50 + var_210_43
					end
				end

				arg_207_1.text_.text = var_210_47
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_51 = var_210_43 + 0.3
			local var_210_52 = math.max(var_210_44, arg_207_1.talkMaxDuration)

			if var_210_51 <= arg_207_1.time_ and arg_207_1.time_ < var_210_51 + var_210_52 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_51) / var_210_52

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_51 + var_210_52 and arg_207_1.time_ < var_210_51 + var_210_52 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play305072048 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 305072048
		arg_213_1.duration_ = 3.93

		local var_213_0 = {
			zh = 1.999999999999,
			ja = 3.933
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
				arg_213_0:Play305072049(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1019ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos1019ui_story = var_216_0.localPosition
			end

			local var_216_2 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2
				local var_216_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1019ui_story, var_216_4, var_216_3)

				local var_216_5 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_5.x, var_216_5.y, var_216_5.z)

				local var_216_6 = var_216_0.localEulerAngles

				var_216_6.z = 0
				var_216_6.x = 0
				var_216_0.localEulerAngles = var_216_6
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_216_7 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_7.x, var_216_7.y, var_216_7.z)

				local var_216_8 = var_216_0.localEulerAngles

				var_216_8.z = 0
				var_216_8.x = 0
				var_216_0.localEulerAngles = var_216_8
			end

			local var_216_9 = arg_213_1.actors_["1019ui_story"]
			local var_216_10 = 0

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect1019ui_story == nil then
				arg_213_1.var_.characterEffect1019ui_story = var_216_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_11 = 0.200000002980232

			if var_216_10 <= arg_213_1.time_ and arg_213_1.time_ < var_216_10 + var_216_11 and not isNil(var_216_9) then
				local var_216_12 = (arg_213_1.time_ - var_216_10) / var_216_11

				if arg_213_1.var_.characterEffect1019ui_story and not isNil(var_216_9) then
					arg_213_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_10 + var_216_11 and arg_213_1.time_ < var_216_10 + var_216_11 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect1019ui_story then
				arg_213_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_216_13 = 0

			if var_216_13 < arg_213_1.time_ and arg_213_1.time_ <= var_216_13 + arg_216_0 then
				arg_213_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_216_14 = 0

			if var_216_14 < arg_213_1.time_ and arg_213_1.time_ <= var_216_14 + arg_216_0 then
				arg_213_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_216_15 = 0
			local var_216_16 = 0.175

			if var_216_15 < arg_213_1.time_ and arg_213_1.time_ <= var_216_15 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_17 = arg_213_1:FormatText(StoryNameCfg[13].name)

				arg_213_1.leftNameTxt_.text = var_216_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_18 = arg_213_1:GetWordFromCfg(305072048)
				local var_216_19 = arg_213_1:FormatText(var_216_18.content)

				arg_213_1.text_.text = var_216_19

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_20 = 7
				local var_216_21 = utf8.len(var_216_19)
				local var_216_22 = var_216_20 <= 0 and var_216_16 or var_216_16 * (var_216_21 / var_216_20)

				if var_216_22 > 0 and var_216_16 < var_216_22 then
					arg_213_1.talkMaxDuration = var_216_22

					if var_216_22 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_22 + var_216_15
					end
				end

				arg_213_1.text_.text = var_216_19
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072048", "story_v_out_305072.awb") ~= 0 then
					local var_216_23 = manager.audio:GetVoiceLength("story_v_out_305072", "305072048", "story_v_out_305072.awb") / 1000

					if var_216_23 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_23 + var_216_15
					end

					if var_216_18.prefab_name ~= "" and arg_213_1.actors_[var_216_18.prefab_name] ~= nil then
						local var_216_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_18.prefab_name].transform, "story_v_out_305072", "305072048", "story_v_out_305072.awb")

						arg_213_1:RecordAudio("305072048", var_216_24)
						arg_213_1:RecordAudio("305072048", var_216_24)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_305072", "305072048", "story_v_out_305072.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_305072", "305072048", "story_v_out_305072.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_25 = math.max(var_216_16, arg_213_1.talkMaxDuration)

			if var_216_15 <= arg_213_1.time_ and arg_213_1.time_ < var_216_15 + var_216_25 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_15) / var_216_25

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_15 + var_216_25 and arg_213_1.time_ < var_216_15 + var_216_25 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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

		arg_213_1:InitPlayNodeList()
	end,
	Play305072049 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 305072049
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play305072050(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1019ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1019ui_story == nil then
				arg_217_1.var_.characterEffect1019ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1019ui_story and not isNil(var_220_0) then
					local var_220_4 = Mathf.Lerp(0, 0.5, var_220_3)

					arg_217_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1019ui_story.fillRatio = var_220_4
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1019ui_story then
				local var_220_5 = 0.5

				arg_217_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1019ui_story.fillRatio = var_220_5
			end

			local var_220_6 = 0
			local var_220_7 = 0.45

			if var_220_6 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_8 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_9 = arg_217_1:GetWordFromCfg(305072049)
				local var_220_10 = arg_217_1:FormatText(var_220_9.content)

				arg_217_1.text_.text = var_220_10

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 18
				local var_220_12 = utf8.len(var_220_10)
				local var_220_13 = var_220_11 <= 0 and var_220_7 or var_220_7 * (var_220_12 / var_220_11)

				if var_220_13 > 0 and var_220_7 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_10
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_14 and arg_217_1.time_ < var_220_6 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play305072050 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 305072050
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play305072051(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1019ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1019ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0, 100, 0)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1019ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, 100, 0)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = 1
			local var_224_10 = 1

			if var_224_9 < arg_221_1.time_ and arg_221_1.time_ <= var_224_9 + arg_224_0 then
				local var_224_11 = "play"
				local var_224_12 = "effect"

				arg_221_1:AudioAction(var_224_11, var_224_12, "se_story_140", "se_story_140_door_push", "")
			end

			local var_224_13 = 0
			local var_224_14 = 1.25

			if var_224_13 < arg_221_1.time_ and arg_221_1.time_ <= var_224_13 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_15 = arg_221_1:GetWordFromCfg(305072050)
				local var_224_16 = arg_221_1:FormatText(var_224_15.content)

				arg_221_1.text_.text = var_224_16

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_17 = 50
				local var_224_18 = utf8.len(var_224_16)
				local var_224_19 = var_224_17 <= 0 and var_224_14 or var_224_14 * (var_224_18 / var_224_17)

				if var_224_19 > 0 and var_224_14 < var_224_19 then
					arg_221_1.talkMaxDuration = var_224_19

					if var_224_19 + var_224_13 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_19 + var_224_13
					end
				end

				arg_221_1.text_.text = var_224_16
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_20 = math.max(var_224_14, arg_221_1.talkMaxDuration)

			if var_224_13 <= arg_221_1.time_ and arg_221_1.time_ < var_224_13 + var_224_20 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_13) / var_224_20

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_13 + var_224_20 and arg_221_1.time_ < var_224_13 + var_224_20 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play305072051 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 305072051
		arg_225_1.duration_ = 3.57

		local var_225_0 = {
			zh = 3.066,
			ja = 3.566
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
				arg_225_0:Play305072052(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = "10001_tpose"

			if arg_225_1.actors_[var_228_0] == nil then
				local var_228_1 = Asset.Load("Char/" .. "10001_tpose")

				if not isNil(var_228_1) then
					local var_228_2 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_225_1.stage_.transform)

					var_228_2.name = var_228_0
					var_228_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_225_1.actors_[var_228_0] = var_228_2

					local var_228_3 = var_228_2:GetComponentInChildren(typeof(CharacterEffect))

					var_228_3.enabled = true

					local var_228_4 = GameObjectTools.GetOrAddComponent(var_228_2, typeof(DynamicBoneHelper))

					if var_228_4 then
						var_228_4:EnableDynamicBone(false)
					end

					arg_225_1:ShowWeapon(var_228_3.transform, false)

					arg_225_1.var_[var_228_0 .. "Animator"] = var_228_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_225_1.var_[var_228_0 .. "Animator"].applyRootMotion = true
					arg_225_1.var_[var_228_0 .. "LipSync"] = var_228_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_228_5 = arg_225_1.actors_["10001_tpose"].transform
			local var_228_6 = 0

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.var_.moveOldPos10001_tpose = var_228_5.localPosition

				local var_228_7 = GameObjectTools.GetOrAddComponent(var_228_5.gameObject, typeof(DynamicBoneHelper))

				if var_228_7 then
					var_228_7:EnableDynamicBone(false)
				end
			end

			local var_228_8 = 0.001

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_8 then
				local var_228_9 = (arg_225_1.time_ - var_228_6) / var_228_8
				local var_228_10 = Vector3.New(-0.7, -1.23, -5.8)

				var_228_5.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10001_tpose, var_228_10, var_228_9)

				local var_228_11 = manager.ui.mainCamera.transform.position - var_228_5.position

				var_228_5.forward = Vector3.New(var_228_11.x, var_228_11.y, var_228_11.z)

				local var_228_12 = var_228_5.localEulerAngles

				var_228_12.z = 0
				var_228_12.x = 0
				var_228_5.localEulerAngles = var_228_12
			end

			if arg_225_1.time_ >= var_228_6 + var_228_8 and arg_225_1.time_ < var_228_6 + var_228_8 + arg_228_0 then
				var_228_5.localPosition = Vector3.New(-0.7, -1.23, -5.8)

				local var_228_13 = manager.ui.mainCamera.transform.position - var_228_5.position

				var_228_5.forward = Vector3.New(var_228_13.x, var_228_13.y, var_228_13.z)

				local var_228_14 = var_228_5.localEulerAngles

				var_228_14.z = 0
				var_228_14.x = 0
				var_228_5.localEulerAngles = var_228_14

				local var_228_15 = GameObjectTools.GetOrAddComponent(var_228_5.gameObject, typeof(DynamicBoneHelper))

				if var_228_15 then
					var_228_15:EnableDynamicBone(true)
				end
			end

			local var_228_16 = arg_225_1.actors_["10001_tpose"]
			local var_228_17 = 0

			if var_228_17 < arg_225_1.time_ and arg_225_1.time_ <= var_228_17 + arg_228_0 and not isNil(var_228_16) and arg_225_1.var_.characterEffect10001_tpose == nil then
				arg_225_1.var_.characterEffect10001_tpose = var_228_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_18 = 0.200000002980232

			if var_228_17 <= arg_225_1.time_ and arg_225_1.time_ < var_228_17 + var_228_18 and not isNil(var_228_16) then
				local var_228_19 = (arg_225_1.time_ - var_228_17) / var_228_18

				if arg_225_1.var_.characterEffect10001_tpose and not isNil(var_228_16) then
					arg_225_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_17 + var_228_18 and arg_225_1.time_ < var_228_17 + var_228_18 + arg_228_0 and not isNil(var_228_16) and arg_225_1.var_.characterEffect10001_tpose then
				arg_225_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_228_20 = 0

			if var_228_20 < arg_225_1.time_ and arg_225_1.time_ <= var_228_20 + arg_228_0 then
				arg_225_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action3_1")
			end

			local var_228_21 = 0

			if var_228_21 < arg_225_1.time_ and arg_225_1.time_ <= var_228_21 + arg_228_0 then
				arg_225_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_228_22 = 0
			local var_228_23 = 0.225

			if var_228_22 < arg_225_1.time_ and arg_225_1.time_ <= var_228_22 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_24 = arg_225_1:FormatText(StoryNameCfg[24].name)

				arg_225_1.leftNameTxt_.text = var_228_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_25 = arg_225_1:GetWordFromCfg(305072051)
				local var_228_26 = arg_225_1:FormatText(var_228_25.content)

				arg_225_1.text_.text = var_228_26

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_27 = 9
				local var_228_28 = utf8.len(var_228_26)
				local var_228_29 = var_228_27 <= 0 and var_228_23 or var_228_23 * (var_228_28 / var_228_27)

				if var_228_29 > 0 and var_228_23 < var_228_29 then
					arg_225_1.talkMaxDuration = var_228_29

					if var_228_29 + var_228_22 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_29 + var_228_22
					end
				end

				arg_225_1.text_.text = var_228_26
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072051", "story_v_out_305072.awb") ~= 0 then
					local var_228_30 = manager.audio:GetVoiceLength("story_v_out_305072", "305072051", "story_v_out_305072.awb") / 1000

					if var_228_30 + var_228_22 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_30 + var_228_22
					end

					if var_228_25.prefab_name ~= "" and arg_225_1.actors_[var_228_25.prefab_name] ~= nil then
						local var_228_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_25.prefab_name].transform, "story_v_out_305072", "305072051", "story_v_out_305072.awb")

						arg_225_1:RecordAudio("305072051", var_228_31)
						arg_225_1:RecordAudio("305072051", var_228_31)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_305072", "305072051", "story_v_out_305072.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_305072", "305072051", "story_v_out_305072.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_32 = math.max(var_228_23, arg_225_1.talkMaxDuration)

			if var_228_22 <= arg_225_1.time_ and arg_225_1.time_ < var_228_22 + var_228_32 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_22) / var_228_32

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_22 + var_228_32 and arg_225_1.time_ < var_228_22 + var_228_32 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play305072052 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 305072052
		arg_229_1.duration_ = 4.23

		local var_229_0 = {
			zh = 4.233,
			ja = 3.3
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
				arg_229_0:Play305072053(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = "1148ui_story"

			if arg_229_1.actors_[var_232_0] == nil then
				local var_232_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_232_1) then
					local var_232_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_229_1.stage_.transform)

					var_232_2.name = var_232_0
					var_232_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_229_1.actors_[var_232_0] = var_232_2

					local var_232_3 = var_232_2:GetComponentInChildren(typeof(CharacterEffect))

					var_232_3.enabled = true

					local var_232_4 = GameObjectTools.GetOrAddComponent(var_232_2, typeof(DynamicBoneHelper))

					if var_232_4 then
						var_232_4:EnableDynamicBone(false)
					end

					arg_229_1:ShowWeapon(var_232_3.transform, false)

					arg_229_1.var_[var_232_0 .. "Animator"] = var_232_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_229_1.var_[var_232_0 .. "Animator"].applyRootMotion = true
					arg_229_1.var_[var_232_0 .. "LipSync"] = var_232_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_232_5 = arg_229_1.actors_["1148ui_story"].transform
			local var_232_6 = 0

			if var_232_6 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.var_.moveOldPos1148ui_story = var_232_5.localPosition
			end

			local var_232_7 = 0.001

			if var_232_6 <= arg_229_1.time_ and arg_229_1.time_ < var_232_6 + var_232_7 then
				local var_232_8 = (arg_229_1.time_ - var_232_6) / var_232_7
				local var_232_9 = Vector3.New(0.7, -0.8, -6.2)

				var_232_5.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1148ui_story, var_232_9, var_232_8)

				local var_232_10 = manager.ui.mainCamera.transform.position - var_232_5.position

				var_232_5.forward = Vector3.New(var_232_10.x, var_232_10.y, var_232_10.z)

				local var_232_11 = var_232_5.localEulerAngles

				var_232_11.z = 0
				var_232_11.x = 0
				var_232_5.localEulerAngles = var_232_11
			end

			if arg_229_1.time_ >= var_232_6 + var_232_7 and arg_229_1.time_ < var_232_6 + var_232_7 + arg_232_0 then
				var_232_5.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_232_12 = manager.ui.mainCamera.transform.position - var_232_5.position

				var_232_5.forward = Vector3.New(var_232_12.x, var_232_12.y, var_232_12.z)

				local var_232_13 = var_232_5.localEulerAngles

				var_232_13.z = 0
				var_232_13.x = 0
				var_232_5.localEulerAngles = var_232_13
			end

			local var_232_14 = arg_229_1.actors_["1148ui_story"]
			local var_232_15 = 0

			if var_232_15 < arg_229_1.time_ and arg_229_1.time_ <= var_232_15 + arg_232_0 and not isNil(var_232_14) and arg_229_1.var_.characterEffect1148ui_story == nil then
				arg_229_1.var_.characterEffect1148ui_story = var_232_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_16 = 0.200000002980232

			if var_232_15 <= arg_229_1.time_ and arg_229_1.time_ < var_232_15 + var_232_16 and not isNil(var_232_14) then
				local var_232_17 = (arg_229_1.time_ - var_232_15) / var_232_16

				if arg_229_1.var_.characterEffect1148ui_story and not isNil(var_232_14) then
					arg_229_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_15 + var_232_16 and arg_229_1.time_ < var_232_15 + var_232_16 + arg_232_0 and not isNil(var_232_14) and arg_229_1.var_.characterEffect1148ui_story then
				arg_229_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_232_18 = arg_229_1.actors_["10001_tpose"]
			local var_232_19 = 0

			if var_232_19 < arg_229_1.time_ and arg_229_1.time_ <= var_232_19 + arg_232_0 and not isNil(var_232_18) and arg_229_1.var_.characterEffect10001_tpose == nil then
				arg_229_1.var_.characterEffect10001_tpose = var_232_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_20 = 0.200000002980232

			if var_232_19 <= arg_229_1.time_ and arg_229_1.time_ < var_232_19 + var_232_20 and not isNil(var_232_18) then
				local var_232_21 = (arg_229_1.time_ - var_232_19) / var_232_20

				if arg_229_1.var_.characterEffect10001_tpose and not isNil(var_232_18) then
					local var_232_22 = Mathf.Lerp(0, 0.5, var_232_21)

					arg_229_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_229_1.var_.characterEffect10001_tpose.fillRatio = var_232_22
				end
			end

			if arg_229_1.time_ >= var_232_19 + var_232_20 and arg_229_1.time_ < var_232_19 + var_232_20 + arg_232_0 and not isNil(var_232_18) and arg_229_1.var_.characterEffect10001_tpose then
				local var_232_23 = 0.5

				arg_229_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_229_1.var_.characterEffect10001_tpose.fillRatio = var_232_23
			end

			local var_232_24 = 0

			if var_232_24 < arg_229_1.time_ and arg_229_1.time_ <= var_232_24 + arg_232_0 then
				arg_229_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			local var_232_25 = 0

			if var_232_25 < arg_229_1.time_ and arg_229_1.time_ <= var_232_25 + arg_232_0 then
				arg_229_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_232_26 = 0
			local var_232_27 = 0.35

			if var_232_26 < arg_229_1.time_ and arg_229_1.time_ <= var_232_26 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_28 = arg_229_1:FormatText(StoryNameCfg[8].name)

				arg_229_1.leftNameTxt_.text = var_232_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_29 = arg_229_1:GetWordFromCfg(305072052)
				local var_232_30 = arg_229_1:FormatText(var_232_29.content)

				arg_229_1.text_.text = var_232_30

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_31 = 14
				local var_232_32 = utf8.len(var_232_30)
				local var_232_33 = var_232_31 <= 0 and var_232_27 or var_232_27 * (var_232_32 / var_232_31)

				if var_232_33 > 0 and var_232_27 < var_232_33 then
					arg_229_1.talkMaxDuration = var_232_33

					if var_232_33 + var_232_26 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_33 + var_232_26
					end
				end

				arg_229_1.text_.text = var_232_30
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072052", "story_v_out_305072.awb") ~= 0 then
					local var_232_34 = manager.audio:GetVoiceLength("story_v_out_305072", "305072052", "story_v_out_305072.awb") / 1000

					if var_232_34 + var_232_26 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_34 + var_232_26
					end

					if var_232_29.prefab_name ~= "" and arg_229_1.actors_[var_232_29.prefab_name] ~= nil then
						local var_232_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_29.prefab_name].transform, "story_v_out_305072", "305072052", "story_v_out_305072.awb")

						arg_229_1:RecordAudio("305072052", var_232_35)
						arg_229_1:RecordAudio("305072052", var_232_35)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_305072", "305072052", "story_v_out_305072.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_305072", "305072052", "story_v_out_305072.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_36 = math.max(var_232_27, arg_229_1.talkMaxDuration)

			if var_232_26 <= arg_229_1.time_ and arg_229_1.time_ < var_232_26 + var_232_36 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_26) / var_232_36

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_26 + var_232_36 and arg_229_1.time_ < var_232_26 + var_232_36 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play305072053 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 305072053
		arg_233_1.duration_ = 9.37

		local var_233_0 = {
			zh = 5.966,
			ja = 9.366
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play305072054(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10001_tpose"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect10001_tpose == nil then
				arg_233_1.var_.characterEffect10001_tpose = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect10001_tpose and not isNil(var_236_0) then
					arg_233_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect10001_tpose then
				arg_233_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_236_4 = arg_233_1.actors_["1148ui_story"]
			local var_236_5 = 0

			if var_236_5 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 and not isNil(var_236_4) and arg_233_1.var_.characterEffect1148ui_story == nil then
				arg_233_1.var_.characterEffect1148ui_story = var_236_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_6 = 0.200000002980232

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_6 and not isNil(var_236_4) then
				local var_236_7 = (arg_233_1.time_ - var_236_5) / var_236_6

				if arg_233_1.var_.characterEffect1148ui_story and not isNil(var_236_4) then
					local var_236_8 = Mathf.Lerp(0, 0.5, var_236_7)

					arg_233_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1148ui_story.fillRatio = var_236_8
				end
			end

			if arg_233_1.time_ >= var_236_5 + var_236_6 and arg_233_1.time_ < var_236_5 + var_236_6 + arg_236_0 and not isNil(var_236_4) and arg_233_1.var_.characterEffect1148ui_story then
				local var_236_9 = 0.5

				arg_233_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1148ui_story.fillRatio = var_236_9
			end

			local var_236_10 = 0
			local var_236_11 = 0.575

			if var_236_10 < arg_233_1.time_ and arg_233_1.time_ <= var_236_10 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_12 = arg_233_1:FormatText(StoryNameCfg[24].name)

				arg_233_1.leftNameTxt_.text = var_236_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_13 = arg_233_1:GetWordFromCfg(305072053)
				local var_236_14 = arg_233_1:FormatText(var_236_13.content)

				arg_233_1.text_.text = var_236_14

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_15 = 23
				local var_236_16 = utf8.len(var_236_14)
				local var_236_17 = var_236_15 <= 0 and var_236_11 or var_236_11 * (var_236_16 / var_236_15)

				if var_236_17 > 0 and var_236_11 < var_236_17 then
					arg_233_1.talkMaxDuration = var_236_17

					if var_236_17 + var_236_10 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_17 + var_236_10
					end
				end

				arg_233_1.text_.text = var_236_14
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072053", "story_v_out_305072.awb") ~= 0 then
					local var_236_18 = manager.audio:GetVoiceLength("story_v_out_305072", "305072053", "story_v_out_305072.awb") / 1000

					if var_236_18 + var_236_10 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_18 + var_236_10
					end

					if var_236_13.prefab_name ~= "" and arg_233_1.actors_[var_236_13.prefab_name] ~= nil then
						local var_236_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_13.prefab_name].transform, "story_v_out_305072", "305072053", "story_v_out_305072.awb")

						arg_233_1:RecordAudio("305072053", var_236_19)
						arg_233_1:RecordAudio("305072053", var_236_19)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_305072", "305072053", "story_v_out_305072.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_305072", "305072053", "story_v_out_305072.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_20 = math.max(var_236_11, arg_233_1.talkMaxDuration)

			if var_236_10 <= arg_233_1.time_ and arg_233_1.time_ < var_236_10 + var_236_20 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_10) / var_236_20

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_10 + var_236_20 and arg_233_1.time_ < var_236_10 + var_236_20 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play305072054 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 305072054
		arg_237_1.duration_ = 16.47

		local var_237_0 = {
			zh = 12,
			ja = 16.466
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play305072055(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action434")
			end

			local var_240_1 = 0
			local var_240_2 = 1.3

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_3 = arg_237_1:FormatText(StoryNameCfg[24].name)

				arg_237_1.leftNameTxt_.text = var_240_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_4 = arg_237_1:GetWordFromCfg(305072054)
				local var_240_5 = arg_237_1:FormatText(var_240_4.content)

				arg_237_1.text_.text = var_240_5

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_6 = 52
				local var_240_7 = utf8.len(var_240_5)
				local var_240_8 = var_240_6 <= 0 and var_240_2 or var_240_2 * (var_240_7 / var_240_6)

				if var_240_8 > 0 and var_240_2 < var_240_8 then
					arg_237_1.talkMaxDuration = var_240_8

					if var_240_8 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_5
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072054", "story_v_out_305072.awb") ~= 0 then
					local var_240_9 = manager.audio:GetVoiceLength("story_v_out_305072", "305072054", "story_v_out_305072.awb") / 1000

					if var_240_9 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_1
					end

					if var_240_4.prefab_name ~= "" and arg_237_1.actors_[var_240_4.prefab_name] ~= nil then
						local var_240_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_4.prefab_name].transform, "story_v_out_305072", "305072054", "story_v_out_305072.awb")

						arg_237_1:RecordAudio("305072054", var_240_10)
						arg_237_1:RecordAudio("305072054", var_240_10)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_305072", "305072054", "story_v_out_305072.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_305072", "305072054", "story_v_out_305072.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_11 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_11 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_11

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_11 and arg_237_1.time_ < var_240_1 + var_240_11 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play305072055 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 305072055
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play305072056(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1148ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1148ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0, 100, 0)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1148ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, 100, 0)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = arg_241_1.actors_["10001_tpose"].transform
			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 then
				arg_241_1.var_.moveOldPos10001_tpose = var_244_9.localPosition

				local var_244_11 = GameObjectTools.GetOrAddComponent(var_244_9.gameObject, typeof(DynamicBoneHelper))

				if var_244_11 then
					var_244_11:EnableDynamicBone(false)
				end
			end

			local var_244_12 = 0.001

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_12 then
				local var_244_13 = (arg_241_1.time_ - var_244_10) / var_244_12
				local var_244_14 = Vector3.New(0, 100, 0)

				var_244_9.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10001_tpose, var_244_14, var_244_13)

				local var_244_15 = manager.ui.mainCamera.transform.position - var_244_9.position

				var_244_9.forward = Vector3.New(var_244_15.x, var_244_15.y, var_244_15.z)

				local var_244_16 = var_244_9.localEulerAngles

				var_244_16.z = 0
				var_244_16.x = 0
				var_244_9.localEulerAngles = var_244_16
			end

			if arg_241_1.time_ >= var_244_10 + var_244_12 and arg_241_1.time_ < var_244_10 + var_244_12 + arg_244_0 then
				var_244_9.localPosition = Vector3.New(0, 100, 0)

				local var_244_17 = manager.ui.mainCamera.transform.position - var_244_9.position

				var_244_9.forward = Vector3.New(var_244_17.x, var_244_17.y, var_244_17.z)

				local var_244_18 = var_244_9.localEulerAngles

				var_244_18.z = 0
				var_244_18.x = 0
				var_244_9.localEulerAngles = var_244_18

				local var_244_19 = GameObjectTools.GetOrAddComponent(var_244_9.gameObject, typeof(DynamicBoneHelper))

				if var_244_19 then
					var_244_19:EnableDynamicBone(true)
				end
			end

			local var_244_20 = arg_241_1.actors_["10001_tpose"]
			local var_244_21 = 0

			if var_244_21 < arg_241_1.time_ and arg_241_1.time_ <= var_244_21 + arg_244_0 and not isNil(var_244_20) and arg_241_1.var_.characterEffect10001_tpose == nil then
				arg_241_1.var_.characterEffect10001_tpose = var_244_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_22 = 0.200000002980232

			if var_244_21 <= arg_241_1.time_ and arg_241_1.time_ < var_244_21 + var_244_22 and not isNil(var_244_20) then
				local var_244_23 = (arg_241_1.time_ - var_244_21) / var_244_22

				if arg_241_1.var_.characterEffect10001_tpose and not isNil(var_244_20) then
					local var_244_24 = Mathf.Lerp(0, 0.5, var_244_23)

					arg_241_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_241_1.var_.characterEffect10001_tpose.fillRatio = var_244_24
				end
			end

			if arg_241_1.time_ >= var_244_21 + var_244_22 and arg_241_1.time_ < var_244_21 + var_244_22 + arg_244_0 and not isNil(var_244_20) and arg_241_1.var_.characterEffect10001_tpose then
				local var_244_25 = 0.5

				arg_241_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_241_1.var_.characterEffect10001_tpose.fillRatio = var_244_25
			end

			local var_244_26 = 0
			local var_244_27 = 1.8

			if var_244_26 < arg_241_1.time_ and arg_241_1.time_ <= var_244_26 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_28 = arg_241_1:GetWordFromCfg(305072055)
				local var_244_29 = arg_241_1:FormatText(var_244_28.content)

				arg_241_1.text_.text = var_244_29

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_30 = 72
				local var_244_31 = utf8.len(var_244_29)
				local var_244_32 = var_244_30 <= 0 and var_244_27 or var_244_27 * (var_244_31 / var_244_30)

				if var_244_32 > 0 and var_244_27 < var_244_32 then
					arg_241_1.talkMaxDuration = var_244_32

					if var_244_32 + var_244_26 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_32 + var_244_26
					end
				end

				arg_241_1.text_.text = var_244_29
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_33 = math.max(var_244_27, arg_241_1.talkMaxDuration)

			if var_244_26 <= arg_241_1.time_ and arg_241_1.time_ < var_244_26 + var_244_33 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_26) / var_244_33

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_26 + var_244_33 and arg_241_1.time_ < var_244_26 + var_244_33 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 2,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 0.799999997019768,
				amplitudeGain = 0.3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play305072056 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 305072056
		arg_245_1.duration_ = 6.52

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play305072057(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = manager.ui.mainCamera.transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				local var_248_2 = arg_245_1.var_.effectsssfsssf1
				local var_248_3
				local var_248_4 = var_248_0

				if not var_248_2 then
					var_248_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boguang"), var_248_4)
					var_248_2.name = "sssf1"
					arg_245_1.var_.effectsssfsssf1 = var_248_2
				else
					var_248_2.transform:SetParent(var_248_4)
				end

				var_248_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_248_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_248_5 = 1.7777777777777777
				local var_248_6 = Screen.width / Screen.height
				local var_248_7 = var_248_6 / var_248_5
				local var_248_8 = Mathf.Max(var_248_5 / var_248_6, 1)

				var_248_2.transform.localScale = Vector3.New(var_248_2.transform.localScale.x * var_248_7, var_248_2.transform.localScale.y * var_248_8, var_248_2.transform.localScale.z)
			end

			local var_248_9 = manager.ui.mainCamera.transform
			local var_248_10 = 1.28333333333333

			if var_248_10 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 then
				local var_248_11 = arg_245_1.var_.effectsssfsssf1

				if var_248_11 then
					Object.Destroy(var_248_11)

					arg_245_1.var_.effectsssfsssf1 = nil
				end
			end

			local var_248_12 = manager.ui.mainCamera.transform
			local var_248_13 = 0.466666666666667

			if var_248_13 < arg_245_1.time_ and arg_245_1.time_ <= var_248_13 + arg_248_0 then
				local var_248_14 = arg_245_1.var_.effect2131
				local var_248_15
				local var_248_16 = var_248_12

				if not var_248_14 then
					var_248_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_248_16)
					var_248_14.name = "2131"
					arg_245_1.var_.effect2131 = var_248_14
				else
					var_248_14.transform:SetParent(var_248_16)
				end

				var_248_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_248_14.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_248_17 = 1.7777777777777777
				local var_248_18 = Screen.width / Screen.height
				local var_248_19 = var_248_18 / var_248_17
				local var_248_20 = Mathf.Max(var_248_17 / var_248_18, 1)

				var_248_14.transform.localScale = Vector3.New(var_248_14.transform.localScale.x * var_248_19, var_248_14.transform.localScale.y * var_248_20, var_248_14.transform.localScale.z)
			end

			local var_248_21 = manager.ui.mainCamera.transform
			local var_248_22 = 1.9

			if var_248_22 < arg_245_1.time_ and arg_245_1.time_ <= var_248_22 + arg_248_0 then
				local var_248_23 = arg_245_1.var_.effect2131

				if var_248_23 then
					Object.Destroy(var_248_23)

					arg_245_1.var_.effect2131 = nil
				end
			end

			local var_248_24 = manager.ui.mainCamera.transform
			local var_248_25 = 0.166666666666667

			if var_248_25 < arg_245_1.time_ and arg_245_1.time_ <= var_248_25 + arg_248_0 then
				local var_248_26 = arg_245_1.var_.effect烦烦烦33
				local var_248_27
				local var_248_28 = var_248_24

				if not var_248_26 then
					var_248_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang04"), var_248_28)
					var_248_26.name = "烦烦烦33"
					arg_245_1.var_.effect烦烦烦33 = var_248_26
				else
					var_248_26.transform:SetParent(var_248_28)
				end

				var_248_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_248_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_248_29 = manager.ui.mainCamera.transform
			local var_248_30 = 1.9

			if var_248_30 < arg_245_1.time_ and arg_245_1.time_ <= var_248_30 + arg_248_0 then
				local var_248_31 = arg_245_1.var_.effect烦烦烦33

				if var_248_31 then
					Object.Destroy(var_248_31)

					arg_245_1.var_.effect烦烦烦33 = nil
				end
			end

			local var_248_32 = 0

			if var_248_32 < arg_245_1.time_ and arg_245_1.time_ <= var_248_32 + arg_248_0 then
				arg_245_1.allBtn_.enabled = false
			end

			local var_248_33 = 1.7

			if arg_245_1.time_ >= var_248_32 + var_248_33 and arg_245_1.time_ < var_248_32 + var_248_33 + arg_248_0 then
				arg_245_1.allBtn_.enabled = true
			end

			local var_248_34 = 0
			local var_248_35 = 1

			if var_248_34 < arg_245_1.time_ and arg_245_1.time_ <= var_248_34 + arg_248_0 then
				local var_248_36 = "play"
				local var_248_37 = "effect"

				arg_245_1:AudioAction(var_248_36, var_248_37, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_38 = 1.52402014564723
			local var_248_39 = 1.25

			if var_248_38 < arg_245_1.time_ and arg_245_1.time_ <= var_248_38 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_40 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_40:setOnUpdate(LuaHelper.FloatAction(function(arg_249_0)
					arg_245_1.dialogCg_.alpha = arg_249_0
				end))
				var_248_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_41 = arg_245_1:GetWordFromCfg(305072056)
				local var_248_42 = arg_245_1:FormatText(var_248_41.content)

				arg_245_1.text_.text = var_248_42

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_43 = 50
				local var_248_44 = utf8.len(var_248_42)
				local var_248_45 = var_248_43 <= 0 and var_248_39 or var_248_39 * (var_248_44 / var_248_43)

				if var_248_45 > 0 and var_248_39 < var_248_45 then
					arg_245_1.talkMaxDuration = var_248_45
					var_248_38 = var_248_38 + 0.3

					if var_248_45 + var_248_38 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_45 + var_248_38
					end
				end

				arg_245_1.text_.text = var_248_42
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_46 = var_248_38 + 0.3
			local var_248_47 = math.max(var_248_39, arg_245_1.talkMaxDuration)

			if var_248_46 <= arg_245_1.time_ and arg_245_1.time_ < var_248_46 + var_248_47 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_46) / var_248_47

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_46 + var_248_47 and arg_245_1.time_ < var_248_46 + var_248_47 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play305072057 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 305072057
		arg_251_1.duration_ = 2

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play305072058(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10001_tpose"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos10001_tpose = var_254_0.localPosition

				local var_254_2 = GameObjectTools.GetOrAddComponent(var_254_0.gameObject, typeof(DynamicBoneHelper))

				if var_254_2 then
					var_254_2:EnableDynamicBone(false)
				end
			end

			local var_254_3 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_3 then
				local var_254_4 = (arg_251_1.time_ - var_254_1) / var_254_3
				local var_254_5 = Vector3.New(0, 100, 0)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10001_tpose, var_254_5, var_254_4)

				local var_254_6 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_6.x, var_254_6.y, var_254_6.z)

				local var_254_7 = var_254_0.localEulerAngles

				var_254_7.z = 0
				var_254_7.x = 0
				var_254_0.localEulerAngles = var_254_7
			end

			if arg_251_1.time_ >= var_254_1 + var_254_3 and arg_251_1.time_ < var_254_1 + var_254_3 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(0, 100, 0)

				local var_254_8 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_8.x, var_254_8.y, var_254_8.z)

				local var_254_9 = var_254_0.localEulerAngles

				var_254_9.z = 0
				var_254_9.x = 0
				var_254_0.localEulerAngles = var_254_9

				local var_254_10 = GameObjectTools.GetOrAddComponent(var_254_0.gameObject, typeof(DynamicBoneHelper))

				if var_254_10 then
					var_254_10:EnableDynamicBone(true)
				end
			end

			local var_254_11 = arg_251_1.actors_["10001_tpose"]
			local var_254_12 = 0

			if var_254_12 < arg_251_1.time_ and arg_251_1.time_ <= var_254_12 + arg_254_0 and not isNil(var_254_11) and arg_251_1.var_.characterEffect10001_tpose == nil then
				arg_251_1.var_.characterEffect10001_tpose = var_254_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_13 = 0.200000002980232

			if var_254_12 <= arg_251_1.time_ and arg_251_1.time_ < var_254_12 + var_254_13 and not isNil(var_254_11) then
				local var_254_14 = (arg_251_1.time_ - var_254_12) / var_254_13

				if arg_251_1.var_.characterEffect10001_tpose and not isNil(var_254_11) then
					arg_251_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_12 + var_254_13 and arg_251_1.time_ < var_254_12 + var_254_13 + arg_254_0 and not isNil(var_254_11) and arg_251_1.var_.characterEffect10001_tpose then
				arg_251_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_254_15 = 0

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 then
				arg_251_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action1_1")
			end

			local var_254_16 = 0

			if var_254_16 < arg_251_1.time_ and arg_251_1.time_ <= var_254_16 + arg_254_0 then
				arg_251_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_254_17 = 0.333333333333333
			local var_254_18 = 1

			if var_254_17 < arg_251_1.time_ and arg_251_1.time_ <= var_254_17 + arg_254_0 then
				local var_254_19 = "play"
				local var_254_20 = "music"

				arg_251_1:AudioAction(var_254_19, var_254_20, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_254_21 = ""
				local var_254_22 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_254_22 ~= "" then
					if arg_251_1.bgmTxt_.text ~= var_254_22 and arg_251_1.bgmTxt_.text ~= "" then
						if arg_251_1.bgmTxt2_.text ~= "" then
							arg_251_1.bgmTxt_.text = arg_251_1.bgmTxt2_.text
						end

						arg_251_1.bgmTxt2_.text = var_254_22

						arg_251_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_251_1.bgmTxt_.text = var_254_22
						arg_251_1.bgmTxt2_.text = var_254_22
					end

					if arg_251_1.bgmTimer then
						arg_251_1.bgmTimer:Stop()

						arg_251_1.bgmTimer = nil
					end

					if arg_251_1.settingData.show_music_name == 1 then
						arg_251_1.musicController:SetSelectedState("show")
						arg_251_1.musicAnimator_:Play("open", 0, 0)

						if arg_251_1.settingData.music_time ~= 0 then
							arg_251_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_251_1.settingData.music_time), function()
								if arg_251_1 == nil or isNil(arg_251_1.bgmTxt_) then
									return
								end

								arg_251_1.musicController:SetSelectedState("hide")
								arg_251_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_254_23 = 0
			local var_254_24 = 0.075

			if var_254_23 < arg_251_1.time_ and arg_251_1.time_ <= var_254_23 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_25 = arg_251_1:FormatText(StoryNameCfg[1560].name)

				arg_251_1.leftNameTxt_.text = var_254_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_26 = arg_251_1:GetWordFromCfg(305072057)
				local var_254_27 = arg_251_1:FormatText(var_254_26.content)

				arg_251_1.text_.text = var_254_27

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_28 = 3
				local var_254_29 = utf8.len(var_254_27)
				local var_254_30 = var_254_28 <= 0 and var_254_24 or var_254_24 * (var_254_29 / var_254_28)

				if var_254_30 > 0 and var_254_24 < var_254_30 then
					arg_251_1.talkMaxDuration = var_254_30

					if var_254_30 + var_254_23 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_30 + var_254_23
					end
				end

				arg_251_1.text_.text = var_254_27
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072057", "story_v_out_305072.awb") ~= 0 then
					local var_254_31 = manager.audio:GetVoiceLength("story_v_out_305072", "305072057", "story_v_out_305072.awb") / 1000

					if var_254_31 + var_254_23 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_31 + var_254_23
					end

					if var_254_26.prefab_name ~= "" and arg_251_1.actors_[var_254_26.prefab_name] ~= nil then
						local var_254_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_26.prefab_name].transform, "story_v_out_305072", "305072057", "story_v_out_305072.awb")

						arg_251_1:RecordAudio("305072057", var_254_32)
						arg_251_1:RecordAudio("305072057", var_254_32)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_305072", "305072057", "story_v_out_305072.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_305072", "305072057", "story_v_out_305072.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_33 = math.max(var_254_24, arg_251_1.talkMaxDuration)

			if var_254_23 <= arg_251_1.time_ and arg_251_1.time_ < var_254_23 + var_254_33 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_23) / var_254_33

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_23 + var_254_33 and arg_251_1.time_ < var_254_23 + var_254_33 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
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
	Play305072058 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 305072058
		arg_256_1.duration_ = 9.9

		local var_256_0 = {
			zh = 9.9,
			ja = 1.999999999999
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play305072059(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["1084ui_story"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1084ui_story == nil then
				arg_256_1.var_.characterEffect1084ui_story = var_259_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.characterEffect1084ui_story and not isNil(var_259_0) then
					arg_256_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1084ui_story then
				arg_256_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_259_4 = arg_256_1.actors_["1084ui_story"].transform
			local var_259_5 = 0

			if var_259_5 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 then
				arg_256_1.var_.moveOldPos1084ui_story = var_259_4.localPosition
			end

			local var_259_6 = 0.001

			if var_259_5 <= arg_256_1.time_ and arg_256_1.time_ < var_259_5 + var_259_6 then
				local var_259_7 = (arg_256_1.time_ - var_259_5) / var_259_6
				local var_259_8 = Vector3.New(0, -0.97, -6)

				var_259_4.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1084ui_story, var_259_8, var_259_7)

				local var_259_9 = manager.ui.mainCamera.transform.position - var_259_4.position

				var_259_4.forward = Vector3.New(var_259_9.x, var_259_9.y, var_259_9.z)

				local var_259_10 = var_259_4.localEulerAngles

				var_259_10.z = 0
				var_259_10.x = 0
				var_259_4.localEulerAngles = var_259_10
			end

			if arg_256_1.time_ >= var_259_5 + var_259_6 and arg_256_1.time_ < var_259_5 + var_259_6 + arg_259_0 then
				var_259_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_259_11 = manager.ui.mainCamera.transform.position - var_259_4.position

				var_259_4.forward = Vector3.New(var_259_11.x, var_259_11.y, var_259_11.z)

				local var_259_12 = var_259_4.localEulerAngles

				var_259_12.z = 0
				var_259_12.x = 0
				var_259_4.localEulerAngles = var_259_12
			end

			local var_259_13 = 0

			if var_259_13 < arg_256_1.time_ and arg_256_1.time_ <= var_259_13 + arg_259_0 then
				arg_256_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_259_14 = 0

			if var_259_14 < arg_256_1.time_ and arg_256_1.time_ <= var_259_14 + arg_259_0 then
				arg_256_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_259_15 = 0
			local var_259_16 = 0.925

			if var_259_15 < arg_256_1.time_ and arg_256_1.time_ <= var_259_15 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_17 = arg_256_1:FormatText(StoryNameCfg[6].name)

				arg_256_1.leftNameTxt_.text = var_259_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_18 = arg_256_1:GetWordFromCfg(305072058)
				local var_259_19 = arg_256_1:FormatText(var_259_18.content)

				arg_256_1.text_.text = var_259_19

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_20 = 37
				local var_259_21 = utf8.len(var_259_19)
				local var_259_22 = var_259_20 <= 0 and var_259_16 or var_259_16 * (var_259_21 / var_259_20)

				if var_259_22 > 0 and var_259_16 < var_259_22 then
					arg_256_1.talkMaxDuration = var_259_22

					if var_259_22 + var_259_15 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_22 + var_259_15
					end
				end

				arg_256_1.text_.text = var_259_19
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072058", "story_v_out_305072.awb") ~= 0 then
					local var_259_23 = manager.audio:GetVoiceLength("story_v_out_305072", "305072058", "story_v_out_305072.awb") / 1000

					if var_259_23 + var_259_15 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_23 + var_259_15
					end

					if var_259_18.prefab_name ~= "" and arg_256_1.actors_[var_259_18.prefab_name] ~= nil then
						local var_259_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_18.prefab_name].transform, "story_v_out_305072", "305072058", "story_v_out_305072.awb")

						arg_256_1:RecordAudio("305072058", var_259_24)
						arg_256_1:RecordAudio("305072058", var_259_24)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_305072", "305072058", "story_v_out_305072.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_305072", "305072058", "story_v_out_305072.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_25 = math.max(var_259_16, arg_256_1.talkMaxDuration)

			if var_259_15 <= arg_256_1.time_ and arg_256_1.time_ < var_259_15 + var_259_25 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_15) / var_259_25

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_15 + var_259_25 and arg_256_1.time_ < var_259_15 + var_259_25 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play305072059 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 305072059
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play305072060(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["1084ui_story"]
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect1084ui_story == nil then
				arg_260_1.var_.characterEffect1084ui_story = var_263_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.200000002980232

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 and not isNil(var_263_0) then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2

				if arg_260_1.var_.characterEffect1084ui_story and not isNil(var_263_0) then
					local var_263_4 = Mathf.Lerp(0, 0.5, var_263_3)

					arg_260_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1084ui_story.fillRatio = var_263_4
				end
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect1084ui_story then
				local var_263_5 = 0.5

				arg_260_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1084ui_story.fillRatio = var_263_5
			end

			local var_263_6 = 0
			local var_263_7 = 0.675

			if var_263_6 < arg_260_1.time_ and arg_260_1.time_ <= var_263_6 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_8 = arg_260_1:FormatText(StoryNameCfg[7].name)

				arg_260_1.leftNameTxt_.text = var_263_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_9 = arg_260_1:GetWordFromCfg(305072059)
				local var_263_10 = arg_260_1:FormatText(var_263_9.content)

				arg_260_1.text_.text = var_263_10

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_11 = 27
				local var_263_12 = utf8.len(var_263_10)
				local var_263_13 = var_263_11 <= 0 and var_263_7 or var_263_7 * (var_263_12 / var_263_11)

				if var_263_13 > 0 and var_263_7 < var_263_13 then
					arg_260_1.talkMaxDuration = var_263_13

					if var_263_13 + var_263_6 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_13 + var_263_6
					end
				end

				arg_260_1.text_.text = var_263_10
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_14 = math.max(var_263_7, arg_260_1.talkMaxDuration)

			if var_263_6 <= arg_260_1.time_ and arg_260_1.time_ < var_263_6 + var_263_14 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_6) / var_263_14

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_6 + var_263_14 and arg_260_1.time_ < var_263_6 + var_263_14 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play305072060 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 305072060
		arg_264_1.duration_ = 5.4

		local var_264_0 = {
			zh = 4.266,
			ja = 5.4
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play305072061(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["10001_tpose"]
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect10001_tpose == nil then
				arg_264_1.var_.characterEffect10001_tpose = var_267_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.200000002980232

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 and not isNil(var_267_0) then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2

				if arg_264_1.var_.characterEffect10001_tpose and not isNil(var_267_0) then
					arg_264_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect10001_tpose then
				arg_264_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_267_4 = 0
			local var_267_5 = 0.275

			if var_267_4 < arg_264_1.time_ and arg_264_1.time_ <= var_267_4 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_6 = arg_264_1:FormatText(StoryNameCfg[1560].name)

				arg_264_1.leftNameTxt_.text = var_267_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_7 = arg_264_1:GetWordFromCfg(305072060)
				local var_267_8 = arg_264_1:FormatText(var_267_7.content)

				arg_264_1.text_.text = var_267_8

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_9 = 11
				local var_267_10 = utf8.len(var_267_8)
				local var_267_11 = var_267_9 <= 0 and var_267_5 or var_267_5 * (var_267_10 / var_267_9)

				if var_267_11 > 0 and var_267_5 < var_267_11 then
					arg_264_1.talkMaxDuration = var_267_11

					if var_267_11 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_11 + var_267_4
					end
				end

				arg_264_1.text_.text = var_267_8
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072060", "story_v_out_305072.awb") ~= 0 then
					local var_267_12 = manager.audio:GetVoiceLength("story_v_out_305072", "305072060", "story_v_out_305072.awb") / 1000

					if var_267_12 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_12 + var_267_4
					end

					if var_267_7.prefab_name ~= "" and arg_264_1.actors_[var_267_7.prefab_name] ~= nil then
						local var_267_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_7.prefab_name].transform, "story_v_out_305072", "305072060", "story_v_out_305072.awb")

						arg_264_1:RecordAudio("305072060", var_267_13)
						arg_264_1:RecordAudio("305072060", var_267_13)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_305072", "305072060", "story_v_out_305072.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_305072", "305072060", "story_v_out_305072.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_14 = math.max(var_267_5, arg_264_1.talkMaxDuration)

			if var_267_4 <= arg_264_1.time_ and arg_264_1.time_ < var_267_4 + var_267_14 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_4) / var_267_14

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_4 + var_267_14 and arg_264_1.time_ < var_267_4 + var_267_14 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play305072061 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 305072061
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play305072062(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["10001_tpose"]
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.characterEffect10001_tpose == nil then
				arg_268_1.var_.characterEffect10001_tpose = var_271_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_2 = 0.200000002980232

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 and not isNil(var_271_0) then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2

				if arg_268_1.var_.characterEffect10001_tpose and not isNil(var_271_0) then
					local var_271_4 = Mathf.Lerp(0, 0.5, var_271_3)

					arg_268_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_268_1.var_.characterEffect10001_tpose.fillRatio = var_271_4
				end
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.characterEffect10001_tpose then
				local var_271_5 = 0.5

				arg_268_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_268_1.var_.characterEffect10001_tpose.fillRatio = var_271_5
			end

			local var_271_6 = arg_268_1.actors_["1084ui_story"].transform
			local var_271_7 = 0

			if var_271_7 < arg_268_1.time_ and arg_268_1.time_ <= var_271_7 + arg_271_0 then
				arg_268_1.var_.moveOldPos1084ui_story = var_271_6.localPosition
			end

			local var_271_8 = 0.001

			if var_271_7 <= arg_268_1.time_ and arg_268_1.time_ < var_271_7 + var_271_8 then
				local var_271_9 = (arg_268_1.time_ - var_271_7) / var_271_8
				local var_271_10 = Vector3.New(0, 100, 0)

				var_271_6.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1084ui_story, var_271_10, var_271_9)

				local var_271_11 = manager.ui.mainCamera.transform.position - var_271_6.position

				var_271_6.forward = Vector3.New(var_271_11.x, var_271_11.y, var_271_11.z)

				local var_271_12 = var_271_6.localEulerAngles

				var_271_12.z = 0
				var_271_12.x = 0
				var_271_6.localEulerAngles = var_271_12
			end

			if arg_268_1.time_ >= var_271_7 + var_271_8 and arg_268_1.time_ < var_271_7 + var_271_8 + arg_271_0 then
				var_271_6.localPosition = Vector3.New(0, 100, 0)

				local var_271_13 = manager.ui.mainCamera.transform.position - var_271_6.position

				var_271_6.forward = Vector3.New(var_271_13.x, var_271_13.y, var_271_13.z)

				local var_271_14 = var_271_6.localEulerAngles

				var_271_14.z = 0
				var_271_14.x = 0
				var_271_6.localEulerAngles = var_271_14
			end

			local var_271_15 = 0
			local var_271_16 = 1.15

			if var_271_15 < arg_268_1.time_ and arg_268_1.time_ <= var_271_15 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_17 = arg_268_1:FormatText(StoryNameCfg[7].name)

				arg_268_1.leftNameTxt_.text = var_271_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_18 = arg_268_1:GetWordFromCfg(305072061)
				local var_271_19 = arg_268_1:FormatText(var_271_18.content)

				arg_268_1.text_.text = var_271_19

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_20 = 46
				local var_271_21 = utf8.len(var_271_19)
				local var_271_22 = var_271_20 <= 0 and var_271_16 or var_271_16 * (var_271_21 / var_271_20)

				if var_271_22 > 0 and var_271_16 < var_271_22 then
					arg_268_1.talkMaxDuration = var_271_22

					if var_271_22 + var_271_15 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_22 + var_271_15
					end
				end

				arg_268_1.text_.text = var_271_19
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_23 = math.max(var_271_16, arg_268_1.talkMaxDuration)

			if var_271_15 <= arg_268_1.time_ and arg_268_1.time_ < var_271_15 + var_271_23 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_15) / var_271_23

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_15 + var_271_23 and arg_268_1.time_ < var_271_15 + var_271_23 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play305072062 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 305072062
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play305072063(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0
			local var_275_1 = 1.375

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_2 = arg_272_1:FormatText(StoryNameCfg[7].name)

				arg_272_1.leftNameTxt_.text = var_275_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_3 = arg_272_1:GetWordFromCfg(305072062)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 55
				local var_275_6 = utf8.len(var_275_4)
				local var_275_7 = var_275_5 <= 0 and var_275_1 or var_275_1 * (var_275_6 / var_275_5)

				if var_275_7 > 0 and var_275_1 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_8 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_8 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_8

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_8 and arg_272_1.time_ < var_275_0 + var_275_8 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play305072063 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 305072063
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play305072064(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0
			local var_279_1 = 1.125

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_2 = arg_276_1:FormatText(StoryNameCfg[7].name)

				arg_276_1.leftNameTxt_.text = var_279_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_3 = arg_276_1:GetWordFromCfg(305072063)
				local var_279_4 = arg_276_1:FormatText(var_279_3.content)

				arg_276_1.text_.text = var_279_4

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 45
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
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_8 = math.max(var_279_1, arg_276_1.talkMaxDuration)

			if var_279_0 <= arg_276_1.time_ and arg_276_1.time_ < var_279_0 + var_279_8 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_0) / var_279_8

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_0 + var_279_8 and arg_276_1.time_ < var_279_0 + var_279_8 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play305072064 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 305072064
		arg_280_1.duration_ = 10.67

		local var_280_0 = {
			zh = 8.166,
			ja = 10.666
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
				arg_280_0:Play305072065(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0
			local var_283_1 = 0.6

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_2 = arg_280_1:FormatText(StoryNameCfg[1560].name)

				arg_280_1.leftNameTxt_.text = var_283_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_3 = arg_280_1:GetWordFromCfg(305072064)
				local var_283_4 = arg_280_1:FormatText(var_283_3.content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_5 = 24
				local var_283_6 = utf8.len(var_283_4)
				local var_283_7 = var_283_5 <= 0 and var_283_1 or var_283_1 * (var_283_6 / var_283_5)

				if var_283_7 > 0 and var_283_1 < var_283_7 then
					arg_280_1.talkMaxDuration = var_283_7

					if var_283_7 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_0
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072064", "story_v_out_305072.awb") ~= 0 then
					local var_283_8 = manager.audio:GetVoiceLength("story_v_out_305072", "305072064", "story_v_out_305072.awb") / 1000

					if var_283_8 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_8 + var_283_0
					end

					if var_283_3.prefab_name ~= "" and arg_280_1.actors_[var_283_3.prefab_name] ~= nil then
						local var_283_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_3.prefab_name].transform, "story_v_out_305072", "305072064", "story_v_out_305072.awb")

						arg_280_1:RecordAudio("305072064", var_283_9)
						arg_280_1:RecordAudio("305072064", var_283_9)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_305072", "305072064", "story_v_out_305072.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_305072", "305072064", "story_v_out_305072.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_10 = math.max(var_283_1, arg_280_1.talkMaxDuration)

			if var_283_0 <= arg_280_1.time_ and arg_280_1.time_ < var_283_0 + var_283_10 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_0) / var_283_10

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_0 + var_283_10 and arg_280_1.time_ < var_283_0 + var_283_10 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play305072065 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 305072065
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play305072066(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["10001_tpose"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect10001_tpose == nil then
				arg_284_1.var_.characterEffect10001_tpose = var_287_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.characterEffect10001_tpose and not isNil(var_287_0) then
					local var_287_4 = Mathf.Lerp(0, 0.5, var_287_3)

					arg_284_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_284_1.var_.characterEffect10001_tpose.fillRatio = var_287_4
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect10001_tpose then
				local var_287_5 = 0.5

				arg_284_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_284_1.var_.characterEffect10001_tpose.fillRatio = var_287_5
			end

			local var_287_6 = 0
			local var_287_7 = 0.3

			if var_287_6 < arg_284_1.time_ and arg_284_1.time_ <= var_287_6 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_8 = arg_284_1:FormatText(StoryNameCfg[7].name)

				arg_284_1.leftNameTxt_.text = var_287_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_9 = arg_284_1:GetWordFromCfg(305072065)
				local var_287_10 = arg_284_1:FormatText(var_287_9.content)

				arg_284_1.text_.text = var_287_10

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_11 = 12
				local var_287_12 = utf8.len(var_287_10)
				local var_287_13 = var_287_11 <= 0 and var_287_7 or var_287_7 * (var_287_12 / var_287_11)

				if var_287_13 > 0 and var_287_7 < var_287_13 then
					arg_284_1.talkMaxDuration = var_287_13

					if var_287_13 + var_287_6 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_13 + var_287_6
					end
				end

				arg_284_1.text_.text = var_287_10
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_14 = math.max(var_287_7, arg_284_1.talkMaxDuration)

			if var_287_6 <= arg_284_1.time_ and arg_284_1.time_ < var_287_6 + var_287_14 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_6) / var_287_14

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_6 + var_287_14 and arg_284_1.time_ < var_287_6 + var_287_14 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play305072066 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 305072066
		arg_288_1.duration_ = 9.2

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play305072067(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = "10045ui_story"

			if arg_288_1.actors_[var_291_0] == nil then
				local var_291_1 = Asset.Load("Char/" .. "10045ui_story")

				if not isNil(var_291_1) then
					local var_291_2 = Object.Instantiate(Asset.Load("Char/" .. "10045ui_story"), arg_288_1.stage_.transform)

					var_291_2.name = var_291_0
					var_291_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_288_1.actors_[var_291_0] = var_291_2

					local var_291_3 = var_291_2:GetComponentInChildren(typeof(CharacterEffect))

					var_291_3.enabled = true

					local var_291_4 = GameObjectTools.GetOrAddComponent(var_291_2, typeof(DynamicBoneHelper))

					if var_291_4 then
						var_291_4:EnableDynamicBone(false)
					end

					arg_288_1:ShowWeapon(var_291_3.transform, false)

					arg_288_1.var_[var_291_0 .. "Animator"] = var_291_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_288_1.var_[var_291_0 .. "Animator"].applyRootMotion = true
					arg_288_1.var_[var_291_0 .. "LipSync"] = var_291_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_291_5 = arg_288_1.actors_["10045ui_story"].transform
			local var_291_6 = 0.833333333333333

			if var_291_6 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				arg_288_1.var_.moveOldPos10045ui_story = var_291_5.localPosition
			end

			local var_291_7 = 0.001

			if var_291_6 <= arg_288_1.time_ and arg_288_1.time_ < var_291_6 + var_291_7 then
				local var_291_8 = (arg_288_1.time_ - var_291_6) / var_291_7
				local var_291_9 = Vector3.New(0, -1.18, -6.05)

				var_291_5.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10045ui_story, var_291_9, var_291_8)

				local var_291_10 = manager.ui.mainCamera.transform.position - var_291_5.position

				var_291_5.forward = Vector3.New(var_291_10.x, var_291_10.y, var_291_10.z)

				local var_291_11 = var_291_5.localEulerAngles

				var_291_11.z = 0
				var_291_11.x = 0
				var_291_5.localEulerAngles = var_291_11
			end

			if arg_288_1.time_ >= var_291_6 + var_291_7 and arg_288_1.time_ < var_291_6 + var_291_7 + arg_291_0 then
				var_291_5.localPosition = Vector3.New(0, -1.18, -6.05)

				local var_291_12 = manager.ui.mainCamera.transform.position - var_291_5.position

				var_291_5.forward = Vector3.New(var_291_12.x, var_291_12.y, var_291_12.z)

				local var_291_13 = var_291_5.localEulerAngles

				var_291_13.z = 0
				var_291_13.x = 0
				var_291_5.localEulerAngles = var_291_13
			end

			local var_291_14 = arg_288_1.actors_["10001_tpose"].transform
			local var_291_15 = 0.833333333333333

			if var_291_15 < arg_288_1.time_ and arg_288_1.time_ <= var_291_15 + arg_291_0 then
				arg_288_1.var_.moveOldPos10001_tpose = var_291_14.localPosition

				local var_291_16 = GameObjectTools.GetOrAddComponent(var_291_14.gameObject, typeof(DynamicBoneHelper))

				if var_291_16 then
					var_291_16:EnableDynamicBone(false)
				end
			end

			local var_291_17 = 0.001

			if var_291_15 <= arg_288_1.time_ and arg_288_1.time_ < var_291_15 + var_291_17 then
				local var_291_18 = (arg_288_1.time_ - var_291_15) / var_291_17
				local var_291_19 = Vector3.New(0, 100, 0)

				var_291_14.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10001_tpose, var_291_19, var_291_18)

				local var_291_20 = manager.ui.mainCamera.transform.position - var_291_14.position

				var_291_14.forward = Vector3.New(var_291_20.x, var_291_20.y, var_291_20.z)

				local var_291_21 = var_291_14.localEulerAngles

				var_291_21.z = 0
				var_291_21.x = 0
				var_291_14.localEulerAngles = var_291_21
			end

			if arg_288_1.time_ >= var_291_15 + var_291_17 and arg_288_1.time_ < var_291_15 + var_291_17 + arg_291_0 then
				var_291_14.localPosition = Vector3.New(0, 100, 0)

				local var_291_22 = manager.ui.mainCamera.transform.position - var_291_14.position

				var_291_14.forward = Vector3.New(var_291_22.x, var_291_22.y, var_291_22.z)

				local var_291_23 = var_291_14.localEulerAngles

				var_291_23.z = 0
				var_291_23.x = 0
				var_291_14.localEulerAngles = var_291_23

				local var_291_24 = GameObjectTools.GetOrAddComponent(var_291_14.gameObject, typeof(DynamicBoneHelper))

				if var_291_24 then
					var_291_24:EnableDynamicBone(true)
				end
			end

			local var_291_25 = arg_288_1.actors_["10045ui_story"]
			local var_291_26 = 0.833333333333333

			if var_291_26 < arg_288_1.time_ and arg_288_1.time_ <= var_291_26 + arg_291_0 and not isNil(var_291_25) and arg_288_1.var_.characterEffect10045ui_story == nil then
				arg_288_1.var_.characterEffect10045ui_story = var_291_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_27 = 0.200000002980232

			if var_291_26 <= arg_288_1.time_ and arg_288_1.time_ < var_291_26 + var_291_27 and not isNil(var_291_25) then
				local var_291_28 = (arg_288_1.time_ - var_291_26) / var_291_27

				if arg_288_1.var_.characterEffect10045ui_story and not isNil(var_291_25) then
					arg_288_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= var_291_26 + var_291_27 and arg_288_1.time_ < var_291_26 + var_291_27 + arg_291_0 and not isNil(var_291_25) and arg_288_1.var_.characterEffect10045ui_story then
				arg_288_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_291_29 = 0.833333333333333

			if var_291_29 < arg_288_1.time_ and arg_288_1.time_ <= var_291_29 + arg_291_0 then
				arg_288_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action2_1")
			end

			local var_291_30 = 0.833333333333333

			if var_291_30 < arg_288_1.time_ and arg_288_1.time_ <= var_291_30 + arg_291_0 then
				arg_288_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_291_31 = manager.ui.mainCamera.transform
			local var_291_32 = 0.833333333333333

			if var_291_32 < arg_288_1.time_ and arg_288_1.time_ <= var_291_32 + arg_291_0 then
				local var_291_33 = arg_288_1.var_.effect字体
				local var_291_34
				local var_291_35 = var_291_31

				if not var_291_33 then
					var_291_33 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_erro2_big"), var_291_35)
					var_291_33.name = "字体"
					arg_288_1.var_.effect字体 = var_291_33
				else
					var_291_33.transform:SetParent(var_291_35)
				end

				var_291_33.transform.localPosition = Vector3.New(0, 0, 0)
				var_291_33.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_291_36 = 1.7777777777777777
				local var_291_37 = Screen.width / Screen.height
				local var_291_38 = var_291_37 / var_291_36
				local var_291_39 = Mathf.Max(var_291_36 / var_291_37, 1)

				var_291_33.transform.localScale = Vector3.New(var_291_33.transform.localScale.x * var_291_38, var_291_33.transform.localScale.y * var_291_39, var_291_33.transform.localScale.z)
			end

			local var_291_40 = manager.ui.mainCamera.transform
			local var_291_41 = 2.8056731352893

			if var_291_41 < arg_288_1.time_ and arg_288_1.time_ <= var_291_41 + arg_291_0 then
				local var_291_42 = arg_288_1.var_.effect字体

				if var_291_42 then
					Object.Destroy(var_291_42)

					arg_288_1.var_.effect字体 = nil
				end
			end

			local var_291_43 = manager.ui.mainCamera.transform
			local var_291_44 = 1.23898159852251

			if var_291_44 < arg_288_1.time_ and arg_288_1.time_ <= var_291_44 + arg_291_0 then
				local var_291_45 = arg_288_1.var_.effect不不不啊啊
				local var_291_46
				local var_291_47 = var_291_43

				if not var_291_45 then
					var_291_45 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_moviemask"), var_291_47)
					var_291_45.name = "不不不啊啊"
					arg_288_1.var_.effect不不不啊啊 = var_291_45
				else
					var_291_45.transform:SetParent(var_291_47)
				end

				var_291_45.transform.localPosition = Vector3.New(0, 0, 0)
				var_291_45.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_291_48 = 1.7777777777777777
				local var_291_49 = Screen.width / Screen.height
				local var_291_50 = var_291_49 / var_291_48
				local var_291_51 = Mathf.Max(var_291_48 / var_291_49, 1)

				var_291_45.transform.localScale = Vector3.New(var_291_45.transform.localScale.x * var_291_50, var_291_45.transform.localScale.y * var_291_51, var_291_45.transform.localScale.z)
			end

			local var_291_52 = manager.ui.mainCamera.transform
			local var_291_53 = 2.96666666666667

			if var_291_53 < arg_288_1.time_ and arg_288_1.time_ <= var_291_53 + arg_291_0 then
				local var_291_54 = arg_288_1.var_.effect办法
				local var_291_55
				local var_291_56 = var_291_52

				if not var_291_54 then
					var_291_54 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_out"), var_291_56)
					var_291_54.name = "办法"
					arg_288_1.var_.effect办法 = var_291_54
				else
					var_291_54.transform:SetParent(var_291_56)
				end

				var_291_54.transform.localPosition = Vector3.New(0, 0, 0)
				var_291_54.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_291_57 = 1.7777777777777777
				local var_291_58 = Screen.width / Screen.height
				local var_291_59 = var_291_58 / var_291_57
				local var_291_60 = Mathf.Max(var_291_57 / var_291_58, 1)

				var_291_54.transform.localScale = Vector3.New(var_291_54.transform.localScale.x * var_291_59, var_291_54.transform.localScale.y * var_291_60, var_291_54.transform.localScale.z)
			end

			local var_291_61 = manager.ui.mainCamera.transform
			local var_291_62 = 6.36666666666666

			if var_291_62 < arg_288_1.time_ and arg_288_1.time_ <= var_291_62 + arg_291_0 then
				local var_291_63 = arg_288_1.var_.effect办法

				if var_291_63 then
					Object.Destroy(var_291_63)

					arg_288_1.var_.effect办法 = nil
				end
			end

			local var_291_64 = 0

			if var_291_64 < arg_288_1.time_ and arg_288_1.time_ <= var_291_64 + arg_291_0 then
				arg_288_1.mask_.enabled = true
				arg_288_1.mask_.raycastTarget = true

				arg_288_1:SetGaussion(false)
			end

			local var_291_65 = 0.876965401228517

			if var_291_64 <= arg_288_1.time_ and arg_288_1.time_ < var_291_64 + var_291_65 then
				local var_291_66 = (arg_288_1.time_ - var_291_64) / var_291_65
				local var_291_67 = Color.New(0, 0, 0)

				var_291_67.a = Mathf.Lerp(1, 0, var_291_66)
				arg_288_1.mask_.color = var_291_67
			end

			if arg_288_1.time_ >= var_291_64 + var_291_65 and arg_288_1.time_ < var_291_64 + var_291_65 + arg_291_0 then
				local var_291_68 = Color.New(0, 0, 0)
				local var_291_69 = 0

				arg_288_1.mask_.enabled = false
				var_291_68.a = var_291_69
				arg_288_1.mask_.color = var_291_68
			end

			local var_291_70 = manager.ui.mainCamera.transform
			local var_291_71 = 0

			if var_291_71 < arg_288_1.time_ and arg_288_1.time_ <= var_291_71 + arg_291_0 then
				local var_291_72 = arg_288_1.var_.effect办法1
				local var_291_73
				local var_291_74 = var_291_70

				if not var_291_72 then
					var_291_72 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), var_291_74)
					var_291_72.name = "办法1"
					arg_288_1.var_.effect办法1 = var_291_72
				else
					var_291_72.transform:SetParent(var_291_74)
				end

				var_291_72.transform.localPosition = Vector3.New(0, 0, 0)
				var_291_72.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_291_75 = 1.7777777777777777
				local var_291_76 = Screen.width / Screen.height
				local var_291_77 = var_291_76 / var_291_75
				local var_291_78 = Mathf.Max(var_291_75 / var_291_76, 1)

				var_291_72.transform.localScale = Vector3.New(var_291_72.transform.localScale.x * var_291_77, var_291_72.transform.localScale.y * var_291_78, var_291_72.transform.localScale.z)
			end

			local var_291_79 = manager.ui.mainCamera.transform
			local var_291_80 = 3.52590169562027

			if var_291_80 < arg_288_1.time_ and arg_288_1.time_ <= var_291_80 + arg_291_0 then
				local var_291_81 = arg_288_1.var_.effect办法1

				if var_291_81 then
					Object.Destroy(var_291_81)

					arg_288_1.var_.effect办法1 = nil
				end
			end

			local var_291_82 = manager.ui.mainCamera.transform
			local var_291_83 = 1.86666666666667

			if var_291_83 < arg_288_1.time_ and arg_288_1.time_ <= var_291_83 + arg_291_0 then
				local var_291_84 = arg_288_1.var_.effect字体1
				local var_291_85
				local var_291_86 = var_291_82

				if not var_291_84 then
					var_291_84 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_erro2_big"), var_291_86)
					var_291_84.name = "字体1"
					arg_288_1.var_.effect字体1 = var_291_84
				else
					var_291_84.transform:SetParent(var_291_86)
				end

				var_291_84.transform.localPosition = Vector3.New(0, -3.85, 0)
				var_291_84.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_291_87 = 1.7777777777777777
				local var_291_88 = Screen.width / Screen.height
				local var_291_89 = var_291_88 / var_291_87
				local var_291_90 = Mathf.Max(var_291_87 / var_291_88, 1)

				var_291_84.transform.localScale = Vector3.New(var_291_84.transform.localScale.x * var_291_89, var_291_84.transform.localScale.y * var_291_90, var_291_84.transform.localScale.z)
			end

			local var_291_91 = manager.ui.mainCamera.transform
			local var_291_92 = 3.83900646862263

			if var_291_92 < arg_288_1.time_ and arg_288_1.time_ <= var_291_92 + arg_291_0 then
				local var_291_93 = arg_288_1.var_.effect字体1

				if var_291_93 then
					Object.Destroy(var_291_93)

					arg_288_1.var_.effect字体1 = nil
				end
			end

			if arg_288_1.frameCnt_ <= 1 then
				arg_288_1.dialog_:SetActive(false)
			end

			local var_291_94 = 3.52590169562027
			local var_291_95 = 0.275

			if var_291_94 < arg_288_1.time_ and arg_288_1.time_ <= var_291_94 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0

				arg_288_1.dialog_:SetActive(true)

				arg_288_1.dialogCg_.alpha = 0

				local var_291_96 = LeanTween.value(arg_288_1.dialog_, 0, 1, 0.3)

				var_291_96:setOnUpdate(LuaHelper.FloatAction(function(arg_292_0)
					arg_288_1.dialogCg_.alpha = arg_292_0
				end))
				var_291_96:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_288_1.dialog_)
					var_291_96:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_288_1.duration_ = arg_288_1.duration_ + 0.3

				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_97 = arg_288_1:FormatText(StoryNameCfg[45].name)

				arg_288_1.leftNameTxt_.text = var_291_97

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_98 = arg_288_1:GetWordFromCfg(305072066)
				local var_291_99 = arg_288_1:FormatText(var_291_98.content)

				arg_288_1.text_.text = var_291_99

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_100 = 11
				local var_291_101 = utf8.len(var_291_99)
				local var_291_102 = var_291_100 <= 0 and var_291_95 or var_291_95 * (var_291_101 / var_291_100)

				if var_291_102 > 0 and var_291_95 < var_291_102 then
					arg_288_1.talkMaxDuration = var_291_102
					var_291_94 = var_291_94 + 0.3

					if var_291_102 + var_291_94 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_102 + var_291_94
					end
				end

				arg_288_1.text_.text = var_291_99
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072066", "story_v_out_305072.awb") ~= 0 then
					local var_291_103 = manager.audio:GetVoiceLength("story_v_out_305072", "305072066", "story_v_out_305072.awb") / 1000

					if var_291_103 + var_291_94 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_103 + var_291_94
					end

					if var_291_98.prefab_name ~= "" and arg_288_1.actors_[var_291_98.prefab_name] ~= nil then
						local var_291_104 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_98.prefab_name].transform, "story_v_out_305072", "305072066", "story_v_out_305072.awb")

						arg_288_1:RecordAudio("305072066", var_291_104)
						arg_288_1:RecordAudio("305072066", var_291_104)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_305072", "305072066", "story_v_out_305072.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_305072", "305072066", "story_v_out_305072.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_105 = var_291_94 + 0.3
			local var_291_106 = math.max(var_291_95, arg_288_1.talkMaxDuration)

			if var_291_105 <= arg_288_1.time_ and arg_288_1.time_ < var_291_105 + var_291_106 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_105) / var_291_106

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_105 + var_291_106 and arg_288_1.time_ < var_291_105 + var_291_106 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.833333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.833333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play305072067 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 305072067
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play305072068(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["10045ui_story"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect10045ui_story == nil then
				arg_294_1.var_.characterEffect10045ui_story = var_297_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.200000002980232

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.characterEffect10045ui_story and not isNil(var_297_0) then
					local var_297_4 = Mathf.Lerp(0, 0.5, var_297_3)

					arg_294_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_294_1.var_.characterEffect10045ui_story.fillRatio = var_297_4
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect10045ui_story then
				local var_297_5 = 0.5

				arg_294_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_294_1.var_.characterEffect10045ui_story.fillRatio = var_297_5
			end

			local var_297_6 = 0
			local var_297_7 = 1.25

			if var_297_6 < arg_294_1.time_ and arg_294_1.time_ <= var_297_6 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_8 = arg_294_1:GetWordFromCfg(305072067)
				local var_297_9 = arg_294_1:FormatText(var_297_8.content)

				arg_294_1.text_.text = var_297_9

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_10 = 50
				local var_297_11 = utf8.len(var_297_9)
				local var_297_12 = var_297_10 <= 0 and var_297_7 or var_297_7 * (var_297_11 / var_297_10)

				if var_297_12 > 0 and var_297_7 < var_297_12 then
					arg_294_1.talkMaxDuration = var_297_12

					if var_297_12 + var_297_6 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_12 + var_297_6
					end
				end

				arg_294_1.text_.text = var_297_9
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_13 = math.max(var_297_7, arg_294_1.talkMaxDuration)

			if var_297_6 <= arg_294_1.time_ and arg_294_1.time_ < var_297_6 + var_297_13 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_6) / var_297_13

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_6 + var_297_13 and arg_294_1.time_ < var_297_6 + var_297_13 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play305072068 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 305072068
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play305072069(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				local var_301_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_301_2 then
					var_301_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_301_2.radialBlurScale = 0
					var_301_2.radialBlurGradient = 1
					var_301_2.radialBlurIntensity = 1

					if var_301_0 then
						var_301_2.radialBlurTarget = var_301_0.transform
					end
				end
			end

			local var_301_3 = 1.22493380075321

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_3 then
				local var_301_4 = (arg_298_1.time_ - var_301_1) / var_301_3
				local var_301_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_301_5 then
					var_301_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_301_5.radialBlurScale = Mathf.Lerp(0, 1, var_301_4)
					var_301_5.radialBlurGradient = Mathf.Lerp(1, 1, var_301_4)
					var_301_5.radialBlurIntensity = Mathf.Lerp(1, 1, var_301_4)
				end
			end

			if arg_298_1.time_ >= var_301_1 + var_301_3 and arg_298_1.time_ < var_301_1 + var_301_3 + arg_301_0 then
				local var_301_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_301_6 then
					var_301_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_301_6.radialBlurScale = 1
					var_301_6.radialBlurGradient = 1
					var_301_6.radialBlurIntensity = 1
				end
			end

			local var_301_7 = 0

			if var_301_7 < arg_298_1.time_ and arg_298_1.time_ <= var_301_7 + arg_301_0 then
				arg_298_1.allBtn_.enabled = false
			end

			local var_301_8 = 1.525

			if arg_298_1.time_ >= var_301_7 + var_301_8 and arg_298_1.time_ < var_301_7 + var_301_8 + arg_301_0 then
				arg_298_1.allBtn_.enabled = true
			end

			local var_301_9 = 0
			local var_301_10 = 1.525

			if var_301_9 < arg_298_1.time_ and arg_298_1.time_ <= var_301_9 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_11 = arg_298_1:GetWordFromCfg(305072068)
				local var_301_12 = arg_298_1:FormatText(var_301_11.content)

				arg_298_1.text_.text = var_301_12

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_13 = 61
				local var_301_14 = utf8.len(var_301_12)
				local var_301_15 = var_301_13 <= 0 and var_301_10 or var_301_10 * (var_301_14 / var_301_13)

				if var_301_15 > 0 and var_301_10 < var_301_15 then
					arg_298_1.talkMaxDuration = var_301_15

					if var_301_15 + var_301_9 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_15 + var_301_9
					end
				end

				arg_298_1.text_.text = var_301_12
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_16 = math.max(var_301_10, arg_298_1.talkMaxDuration)

			if var_301_9 <= arg_298_1.time_ and arg_298_1.time_ < var_301_9 + var_301_16 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_9) / var_301_16

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_9 + var_301_16 and arg_298_1.time_ < var_301_9 + var_301_16 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play305072069 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 305072069
		arg_302_1.duration_ = 9.7

		local var_302_0 = {
			zh = 5.766,
			ja = 9.7
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play305072070(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["10045ui_story"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect10045ui_story == nil then
				arg_302_1.var_.characterEffect10045ui_story = var_305_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.characterEffect10045ui_story and not isNil(var_305_0) then
					arg_302_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect10045ui_story then
				arg_302_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_305_4 = 0

			if var_305_4 < arg_302_1.time_ and arg_302_1.time_ <= var_305_4 + arg_305_0 then
				arg_302_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action2_2")
			end

			local var_305_5 = 0

			if var_305_5 < arg_302_1.time_ and arg_302_1.time_ <= var_305_5 + arg_305_0 then
				arg_302_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_305_6 = 0
			local var_305_7 = 0.475

			if var_305_6 < arg_302_1.time_ and arg_302_1.time_ <= var_305_6 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_8 = arg_302_1:FormatText(StoryNameCfg[45].name)

				arg_302_1.leftNameTxt_.text = var_305_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_9 = arg_302_1:GetWordFromCfg(305072069)
				local var_305_10 = arg_302_1:FormatText(var_305_9.content)

				arg_302_1.text_.text = var_305_10

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_11 = 19
				local var_305_12 = utf8.len(var_305_10)
				local var_305_13 = var_305_11 <= 0 and var_305_7 or var_305_7 * (var_305_12 / var_305_11)

				if var_305_13 > 0 and var_305_7 < var_305_13 then
					arg_302_1.talkMaxDuration = var_305_13

					if var_305_13 + var_305_6 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_13 + var_305_6
					end
				end

				arg_302_1.text_.text = var_305_10
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072069", "story_v_out_305072.awb") ~= 0 then
					local var_305_14 = manager.audio:GetVoiceLength("story_v_out_305072", "305072069", "story_v_out_305072.awb") / 1000

					if var_305_14 + var_305_6 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_14 + var_305_6
					end

					if var_305_9.prefab_name ~= "" and arg_302_1.actors_[var_305_9.prefab_name] ~= nil then
						local var_305_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_9.prefab_name].transform, "story_v_out_305072", "305072069", "story_v_out_305072.awb")

						arg_302_1:RecordAudio("305072069", var_305_15)
						arg_302_1:RecordAudio("305072069", var_305_15)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_305072", "305072069", "story_v_out_305072.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_305072", "305072069", "story_v_out_305072.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_16 = math.max(var_305_7, arg_302_1.talkMaxDuration)

			if var_305_6 <= arg_302_1.time_ and arg_302_1.time_ < var_305_6 + var_305_16 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_6) / var_305_16

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_6 + var_305_16 and arg_302_1.time_ < var_305_6 + var_305_16 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play305072070 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 305072070
		arg_306_1.duration_ = 7.57

		local var_306_0 = {
			zh = 7.566,
			ja = 4.9
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play305072071(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 0.675

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_2 = arg_306_1:FormatText(StoryNameCfg[45].name)

				arg_306_1.leftNameTxt_.text = var_309_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_3 = arg_306_1:GetWordFromCfg(305072070)
				local var_309_4 = arg_306_1:FormatText(var_309_3.content)

				arg_306_1.text_.text = var_309_4

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 27
				local var_309_6 = utf8.len(var_309_4)
				local var_309_7 = var_309_5 <= 0 and var_309_1 or var_309_1 * (var_309_6 / var_309_5)

				if var_309_7 > 0 and var_309_1 < var_309_7 then
					arg_306_1.talkMaxDuration = var_309_7

					if var_309_7 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_7 + var_309_0
					end
				end

				arg_306_1.text_.text = var_309_4
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072070", "story_v_out_305072.awb") ~= 0 then
					local var_309_8 = manager.audio:GetVoiceLength("story_v_out_305072", "305072070", "story_v_out_305072.awb") / 1000

					if var_309_8 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_8 + var_309_0
					end

					if var_309_3.prefab_name ~= "" and arg_306_1.actors_[var_309_3.prefab_name] ~= nil then
						local var_309_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_3.prefab_name].transform, "story_v_out_305072", "305072070", "story_v_out_305072.awb")

						arg_306_1:RecordAudio("305072070", var_309_9)
						arg_306_1:RecordAudio("305072070", var_309_9)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_305072", "305072070", "story_v_out_305072.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_305072", "305072070", "story_v_out_305072.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_10 = math.max(var_309_1, arg_306_1.talkMaxDuration)

			if var_309_0 <= arg_306_1.time_ and arg_306_1.time_ < var_309_0 + var_309_10 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_0) / var_309_10

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_0 + var_309_10 and arg_306_1.time_ < var_309_0 + var_309_10 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play305072071 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 305072071
		arg_310_1.duration_ = 8.3

		local var_310_0 = {
			zh = 7.833,
			ja = 8.3
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play305072072(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_313_1 = arg_310_1.actors_["10045ui_story"].transform
			local var_313_2 = 0

			if var_313_2 < arg_310_1.time_ and arg_310_1.time_ <= var_313_2 + arg_313_0 then
				arg_310_1.var_.moveOldPos10045ui_story = var_313_1.localPosition
			end

			local var_313_3 = 0.001

			if var_313_2 <= arg_310_1.time_ and arg_310_1.time_ < var_313_2 + var_313_3 then
				local var_313_4 = (arg_310_1.time_ - var_313_2) / var_313_3
				local var_313_5 = Vector3.New(0, 100, 0)

				var_313_1.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos10045ui_story, var_313_5, var_313_4)

				local var_313_6 = manager.ui.mainCamera.transform.position - var_313_1.position

				var_313_1.forward = Vector3.New(var_313_6.x, var_313_6.y, var_313_6.z)

				local var_313_7 = var_313_1.localEulerAngles

				var_313_7.z = 0
				var_313_7.x = 0
				var_313_1.localEulerAngles = var_313_7
			end

			if arg_310_1.time_ >= var_313_2 + var_313_3 and arg_310_1.time_ < var_313_2 + var_313_3 + arg_313_0 then
				var_313_1.localPosition = Vector3.New(0, 100, 0)

				local var_313_8 = manager.ui.mainCamera.transform.position - var_313_1.position

				var_313_1.forward = Vector3.New(var_313_8.x, var_313_8.y, var_313_8.z)

				local var_313_9 = var_313_1.localEulerAngles

				var_313_9.z = 0
				var_313_9.x = 0
				var_313_1.localEulerAngles = var_313_9
			end

			local var_313_10 = 0
			local var_313_11 = 0.525

			if var_313_10 < arg_310_1.time_ and arg_310_1.time_ <= var_313_10 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_12 = arg_310_1:FormatText(StoryNameCfg[45].name)

				arg_310_1.leftNameTxt_.text = var_313_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_13 = arg_310_1:GetWordFromCfg(305072071)
				local var_313_14 = arg_310_1:FormatText(var_313_13.content)

				arg_310_1.text_.text = var_313_14

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_15 = 21
				local var_313_16 = utf8.len(var_313_14)
				local var_313_17 = var_313_15 <= 0 and var_313_11 or var_313_11 * (var_313_16 / var_313_15)

				if var_313_17 > 0 and var_313_11 < var_313_17 then
					arg_310_1.talkMaxDuration = var_313_17

					if var_313_17 + var_313_10 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_17 + var_313_10
					end
				end

				arg_310_1.text_.text = var_313_14
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072071", "story_v_out_305072.awb") ~= 0 then
					local var_313_18 = manager.audio:GetVoiceLength("story_v_out_305072", "305072071", "story_v_out_305072.awb") / 1000

					if var_313_18 + var_313_10 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_18 + var_313_10
					end

					if var_313_13.prefab_name ~= "" and arg_310_1.actors_[var_313_13.prefab_name] ~= nil then
						local var_313_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_13.prefab_name].transform, "story_v_out_305072", "305072071", "story_v_out_305072.awb")

						arg_310_1:RecordAudio("305072071", var_313_19)
						arg_310_1:RecordAudio("305072071", var_313_19)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_305072", "305072071", "story_v_out_305072.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_305072", "305072071", "story_v_out_305072.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_20 = math.max(var_313_11, arg_310_1.talkMaxDuration)

			if var_313_10 <= arg_310_1.time_ and arg_310_1.time_ < var_313_10 + var_313_20 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_10) / var_313_20

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_10 + var_313_20 and arg_310_1.time_ < var_313_10 + var_313_20 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play305072072 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 305072072
		arg_314_1.duration_ = 8.93

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play305072073(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["10045ui_story"].transform
			local var_317_1 = 2.16666666666667

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 then
				arg_314_1.var_.moveOldPos10045ui_story = var_317_0.localPosition
			end

			local var_317_2 = 0.133333333333333

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2
				local var_317_4 = Vector3.New(0, 100, 0)

				var_317_0.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos10045ui_story, var_317_4, var_317_3)

				local var_317_5 = manager.ui.mainCamera.transform.position - var_317_0.position

				var_317_0.forward = Vector3.New(var_317_5.x, var_317_5.y, var_317_5.z)

				local var_317_6 = var_317_0.localEulerAngles

				var_317_6.z = 0
				var_317_6.x = 0
				var_317_0.localEulerAngles = var_317_6
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 then
				var_317_0.localPosition = Vector3.New(0, 100, 0)

				local var_317_7 = manager.ui.mainCamera.transform.position - var_317_0.position

				var_317_0.forward = Vector3.New(var_317_7.x, var_317_7.y, var_317_7.z)

				local var_317_8 = var_317_0.localEulerAngles

				var_317_8.z = 0
				var_317_8.x = 0
				var_317_0.localEulerAngles = var_317_8
			end

			local var_317_9 = arg_314_1.actors_["10045ui_story"]
			local var_317_10 = 0

			if var_317_10 < arg_314_1.time_ and arg_314_1.time_ <= var_317_10 + arg_317_0 and not isNil(var_317_9) and arg_314_1.var_.characterEffect10045ui_story == nil then
				arg_314_1.var_.characterEffect10045ui_story = var_317_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_11 = 0.200000002980232

			if var_317_10 <= arg_314_1.time_ and arg_314_1.time_ < var_317_10 + var_317_11 and not isNil(var_317_9) then
				local var_317_12 = (arg_314_1.time_ - var_317_10) / var_317_11

				if arg_314_1.var_.characterEffect10045ui_story and not isNil(var_317_9) then
					local var_317_13 = Mathf.Lerp(0, 0.5, var_317_12)

					arg_314_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_314_1.var_.characterEffect10045ui_story.fillRatio = var_317_13
				end
			end

			if arg_314_1.time_ >= var_317_10 + var_317_11 and arg_314_1.time_ < var_317_10 + var_317_11 + arg_317_0 and not isNil(var_317_9) and arg_314_1.var_.characterEffect10045ui_story then
				local var_317_14 = 0.5

				arg_314_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_314_1.var_.characterEffect10045ui_story.fillRatio = var_317_14
			end

			local var_317_15 = manager.ui.mainCamera.transform
			local var_317_16 = 0

			if var_317_16 < arg_314_1.time_ and arg_314_1.time_ <= var_317_16 + arg_317_0 then
				local var_317_17 = arg_314_1.var_.effect333问问
				local var_317_18
				local var_317_19 = var_317_15

				if not var_317_17 then
					var_317_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapblink"), var_317_19)
					var_317_17.name = "333问问"
					arg_314_1.var_.effect333问问 = var_317_17
				else
					var_317_17.transform:SetParent(var_317_19)
				end

				var_317_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_317_17.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_317_20 = 1.7777777777777777
				local var_317_21 = Screen.width / Screen.height
				local var_317_22 = var_317_21 / var_317_20
				local var_317_23 = Mathf.Max(var_317_20 / var_317_21, 1)

				var_317_17.transform.localScale = Vector3.New(var_317_17.transform.localScale.x * var_317_22, var_317_17.transform.localScale.y * var_317_23, var_317_17.transform.localScale.z)
			end

			local var_317_24 = manager.ui.mainCamera.transform
			local var_317_25 = 3.5

			if var_317_25 < arg_314_1.time_ and arg_314_1.time_ <= var_317_25 + arg_317_0 then
				local var_317_26 = arg_314_1.var_.effect333问问

				if var_317_26 then
					Object.Destroy(var_317_26)

					arg_314_1.var_.effect333问问 = nil
				end
			end

			local var_317_27 = 0

			if var_317_27 < arg_314_1.time_ and arg_314_1.time_ <= var_317_27 + arg_317_0 then
				arg_314_1.allBtn_.enabled = false
			end

			local var_317_28 = 4.43948500556871

			if arg_314_1.time_ >= var_317_27 + var_317_28 and arg_314_1.time_ < var_317_27 + var_317_28 + arg_317_0 then
				arg_314_1.allBtn_.enabled = true
			end

			local var_317_29 = 1.94921720679849

			if var_317_29 < arg_314_1.time_ and arg_314_1.time_ <= var_317_29 + arg_317_0 then
				arg_314_1.mask_.enabled = true
				arg_314_1.mask_.raycastTarget = true

				arg_314_1:SetGaussion(false)
			end

			local var_317_30 = 1.150783

			if var_317_29 <= arg_314_1.time_ and arg_314_1.time_ < var_317_29 + var_317_30 then
				local var_317_31 = (arg_314_1.time_ - var_317_29) / var_317_30
				local var_317_32 = Color.New(1, 1, 1)

				var_317_32.a = Mathf.Lerp(1, 0, var_317_31)
				arg_314_1.mask_.color = var_317_32
			end

			if arg_314_1.time_ >= var_317_29 + var_317_30 and arg_314_1.time_ < var_317_29 + var_317_30 + arg_317_0 then
				local var_317_33 = Color.New(1, 1, 1)
				local var_317_34 = 0

				arg_314_1.mask_.enabled = false
				var_317_33.a = var_317_34
				arg_314_1.mask_.color = var_317_33
			end

			local var_317_35
			local var_317_36 = 0

			if var_317_36 < arg_314_1.time_ and arg_314_1.time_ <= var_317_36 + arg_317_0 then
				local var_317_37 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_317_37 then
					var_317_37.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_317_37.radialBlurScale = 0.986
					var_317_37.radialBlurGradient = 1
					var_317_37.radialBlurIntensity = 1

					if var_317_35 then
						var_317_37.radialBlurTarget = var_317_35.transform
					end
				end
			end

			local var_317_38 = 2.4

			if var_317_36 <= arg_314_1.time_ and arg_314_1.time_ < var_317_36 + var_317_38 then
				local var_317_39 = (arg_314_1.time_ - var_317_36) / var_317_38
				local var_317_40 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_317_40 then
					var_317_40.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_317_40.radialBlurScale = Mathf.Lerp(0.986, 0.986, var_317_39)
					var_317_40.radialBlurGradient = Mathf.Lerp(1, 1, var_317_39)
					var_317_40.radialBlurIntensity = Mathf.Lerp(1, 1, var_317_39)
				end
			end

			if arg_314_1.time_ >= var_317_36 + var_317_38 and arg_314_1.time_ < var_317_36 + var_317_38 + arg_317_0 then
				local var_317_41 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_317_41 then
					var_317_41.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_317_41.radialBlurScale = 0.986
					var_317_41.radialBlurGradient = 1
					var_317_41.radialBlurIntensity = 1
				end
			end

			local var_317_42
			local var_317_43 = 2.4

			if var_317_43 < arg_314_1.time_ and arg_314_1.time_ <= var_317_43 + arg_317_0 then
				local var_317_44 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_317_44 then
					var_317_44.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_317_44.radialBlurScale = 0.986
					var_317_44.radialBlurGradient = 1
					var_317_44.radialBlurIntensity = 1

					if var_317_42 then
						var_317_44.radialBlurTarget = var_317_42.transform
					end
				end
			end

			local var_317_45 = 0.3

			if var_317_43 <= arg_314_1.time_ and arg_314_1.time_ < var_317_43 + var_317_45 then
				local var_317_46 = (arg_314_1.time_ - var_317_43) / var_317_45
				local var_317_47 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_317_47 then
					var_317_47.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_317_47.radialBlurScale = Mathf.Lerp(0.986, 0, var_317_46)
					var_317_47.radialBlurGradient = Mathf.Lerp(1, 1, var_317_46)
					var_317_47.radialBlurIntensity = Mathf.Lerp(1, 1, var_317_46)
				end
			end

			if arg_314_1.time_ >= var_317_43 + var_317_45 and arg_314_1.time_ < var_317_43 + var_317_45 + arg_317_0 then
				local var_317_48 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_317_48 then
					var_317_48.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_317_48.radialBlurScale = 0
					var_317_48.radialBlurGradient = 1
					var_317_48.radialBlurIntensity = 1
				end
			end

			local var_317_49 = manager.ui.mainCamera.transform
			local var_317_50 = 2.3

			if var_317_50 < arg_314_1.time_ and arg_314_1.time_ <= var_317_50 + arg_317_0 then
				local var_317_51 = arg_314_1.var_.effect不不不啊啊

				if var_317_51 then
					Object.Destroy(var_317_51)

					arg_314_1.var_.effect不不不啊啊 = nil
				end
			end

			if arg_314_1.frameCnt_ <= 1 then
				arg_314_1.dialog_:SetActive(false)
			end

			local var_317_52 = 3.93333333333333
			local var_317_53 = 0.775

			if var_317_52 < arg_314_1.time_ and arg_314_1.time_ <= var_317_52 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0

				arg_314_1.dialog_:SetActive(true)

				arg_314_1.dialogCg_.alpha = 0

				local var_317_54 = LeanTween.value(arg_314_1.dialog_, 0, 1, 0.3)

				var_317_54:setOnUpdate(LuaHelper.FloatAction(function(arg_318_0)
					arg_314_1.dialogCg_.alpha = arg_318_0
				end))
				var_317_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_314_1.dialog_)
					var_317_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_314_1.duration_ = arg_314_1.duration_ + 0.3

				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_55 = arg_314_1:GetWordFromCfg(305072072)
				local var_317_56 = arg_314_1:FormatText(var_317_55.content)

				arg_314_1.text_.text = var_317_56

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_57 = 31
				local var_317_58 = utf8.len(var_317_56)
				local var_317_59 = var_317_57 <= 0 and var_317_53 or var_317_53 * (var_317_58 / var_317_57)

				if var_317_59 > 0 and var_317_53 < var_317_59 then
					arg_314_1.talkMaxDuration = var_317_59
					var_317_52 = var_317_52 + 0.3

					if var_317_59 + var_317_52 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_59 + var_317_52
					end
				end

				arg_314_1.text_.text = var_317_56
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_60 = var_317_52 + 0.3
			local var_317_61 = math.max(var_317_53, arg_314_1.talkMaxDuration)

			if var_317_60 <= arg_314_1.time_ and arg_314_1.time_ < var_317_60 + var_317_61 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_60) / var_317_61

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_60 + var_317_61 and arg_314_1.time_ < var_317_60 + var_317_61 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.133333333333333,
				className = "StoryMoveNode",
				startTime = 2.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play305072073 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 305072073
		arg_320_1.duration_ = 4.77

		local var_320_0 = {
			zh = 4.6,
			ja = 4.766
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
				arg_320_0:Play305072074(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["1148ui_story"].transform
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.var_.moveOldPos1148ui_story = var_323_0.localPosition
			end

			local var_323_2 = 0.001

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2
				local var_323_4 = Vector3.New(0, -0.8, -6.2)

				var_323_0.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1148ui_story, var_323_4, var_323_3)

				local var_323_5 = manager.ui.mainCamera.transform.position - var_323_0.position

				var_323_0.forward = Vector3.New(var_323_5.x, var_323_5.y, var_323_5.z)

				local var_323_6 = var_323_0.localEulerAngles

				var_323_6.z = 0
				var_323_6.x = 0
				var_323_0.localEulerAngles = var_323_6
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 then
				var_323_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_323_7 = manager.ui.mainCamera.transform.position - var_323_0.position

				var_323_0.forward = Vector3.New(var_323_7.x, var_323_7.y, var_323_7.z)

				local var_323_8 = var_323_0.localEulerAngles

				var_323_8.z = 0
				var_323_8.x = 0
				var_323_0.localEulerAngles = var_323_8
			end

			local var_323_9 = arg_320_1.actors_["1148ui_story"]
			local var_323_10 = 0

			if var_323_10 < arg_320_1.time_ and arg_320_1.time_ <= var_323_10 + arg_323_0 and not isNil(var_323_9) and arg_320_1.var_.characterEffect1148ui_story == nil then
				arg_320_1.var_.characterEffect1148ui_story = var_323_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_11 = 0.200000002980232

			if var_323_10 <= arg_320_1.time_ and arg_320_1.time_ < var_323_10 + var_323_11 and not isNil(var_323_9) then
				local var_323_12 = (arg_320_1.time_ - var_323_10) / var_323_11

				if arg_320_1.var_.characterEffect1148ui_story and not isNil(var_323_9) then
					arg_320_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= var_323_10 + var_323_11 and arg_320_1.time_ < var_323_10 + var_323_11 + arg_323_0 and not isNil(var_323_9) and arg_320_1.var_.characterEffect1148ui_story then
				arg_320_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_323_13 = 0

			if var_323_13 < arg_320_1.time_ and arg_320_1.time_ <= var_323_13 + arg_323_0 then
				arg_320_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action495")
			end

			local var_323_14 = 0

			if var_323_14 < arg_320_1.time_ and arg_320_1.time_ <= var_323_14 + arg_323_0 then
				arg_320_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_323_15 = 0
			local var_323_16 = 0.525

			if var_323_15 < arg_320_1.time_ and arg_320_1.time_ <= var_323_15 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_17 = arg_320_1:FormatText(StoryNameCfg[8].name)

				arg_320_1.leftNameTxt_.text = var_323_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_18 = arg_320_1:GetWordFromCfg(305072073)
				local var_323_19 = arg_320_1:FormatText(var_323_18.content)

				arg_320_1.text_.text = var_323_19

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_20 = 21
				local var_323_21 = utf8.len(var_323_19)
				local var_323_22 = var_323_20 <= 0 and var_323_16 or var_323_16 * (var_323_21 / var_323_20)

				if var_323_22 > 0 and var_323_16 < var_323_22 then
					arg_320_1.talkMaxDuration = var_323_22

					if var_323_22 + var_323_15 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_22 + var_323_15
					end
				end

				arg_320_1.text_.text = var_323_19
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072073", "story_v_out_305072.awb") ~= 0 then
					local var_323_23 = manager.audio:GetVoiceLength("story_v_out_305072", "305072073", "story_v_out_305072.awb") / 1000

					if var_323_23 + var_323_15 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_23 + var_323_15
					end

					if var_323_18.prefab_name ~= "" and arg_320_1.actors_[var_323_18.prefab_name] ~= nil then
						local var_323_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_18.prefab_name].transform, "story_v_out_305072", "305072073", "story_v_out_305072.awb")

						arg_320_1:RecordAudio("305072073", var_323_24)
						arg_320_1:RecordAudio("305072073", var_323_24)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_305072", "305072073", "story_v_out_305072.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_305072", "305072073", "story_v_out_305072.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_25 = math.max(var_323_16, arg_320_1.talkMaxDuration)

			if var_323_15 <= arg_320_1.time_ and arg_320_1.time_ < var_323_15 + var_323_25 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_15) / var_323_25

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_15 + var_323_25 and arg_320_1.time_ < var_323_15 + var_323_25 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play305072074 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 305072074
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play305072075(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["1148ui_story"]
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1148ui_story == nil then
				arg_324_1.var_.characterEffect1148ui_story = var_327_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.200000002980232

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 and not isNil(var_327_0) then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2

				if arg_324_1.var_.characterEffect1148ui_story and not isNil(var_327_0) then
					local var_327_4 = Mathf.Lerp(0, 0.5, var_327_3)

					arg_324_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1148ui_story.fillRatio = var_327_4
				end
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1148ui_story then
				local var_327_5 = 0.5

				arg_324_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1148ui_story.fillRatio = var_327_5
			end

			local var_327_6 = 0
			local var_327_7 = 0.575

			if var_327_6 < arg_324_1.time_ and arg_324_1.time_ <= var_327_6 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_8 = arg_324_1:FormatText(StoryNameCfg[7].name)

				arg_324_1.leftNameTxt_.text = var_327_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_9 = arg_324_1:GetWordFromCfg(305072074)
				local var_327_10 = arg_324_1:FormatText(var_327_9.content)

				arg_324_1.text_.text = var_327_10

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_11 = 23
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
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_14 = math.max(var_327_7, arg_324_1.talkMaxDuration)

			if var_327_6 <= arg_324_1.time_ and arg_324_1.time_ < var_327_6 + var_327_14 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_6) / var_327_14

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_6 + var_327_14 and arg_324_1.time_ < var_327_6 + var_327_14 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play305072075 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 305072075
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
			arg_328_1.auto_ = false
		end

		function arg_328_1.playNext_(arg_330_0)
			arg_328_1.onStoryFinished_()
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0
			local var_331_1 = 0.625

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_2 = arg_328_1:FormatText(StoryNameCfg[7].name)

				arg_328_1.leftNameTxt_.text = var_331_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_3 = arg_328_1:GetWordFromCfg(305072075)
				local var_331_4 = arg_328_1:FormatText(var_331_3.content)

				arg_328_1.text_.text = var_331_4

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 25
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
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_8 = math.max(var_331_1, arg_328_1.talkMaxDuration)

			if var_331_0 <= arg_328_1.time_ and arg_328_1.time_ < var_331_0 + var_331_8 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_0) / var_331_8

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_0 + var_331_8 and arg_328_1.time_ < var_331_0 + var_331_8 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B12",
		"TextureConfig/Background/S0505",
		"TextureConfig/Background/S0507",
		"TextureConfig/Background/B06b"
	},
	voices = {
		"story_v_out_305072.awb"
	}
}
