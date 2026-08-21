return {
	Play322031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322031001
		arg_1_1.duration_ = 5.8

		local var_1_0 = {
			zh = 5.066,
			ja = 5.8
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
				arg_1_0:Play322031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L01h"

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
				local var_4_5 = arg_1_1.bgs_.L01h

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
					if iter_4_0 ~= "L01h" then
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

			local var_4_24 = 0
			local var_4_25 = 0.3

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0.500666666666667
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_0_story_quake_daily", "bgm_activity_4_0_story_quake_daily", "bgm_activity_4_0_story_quake_daily.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_daily", "bgm_activity_4_0_story_quake_daily")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 0.3
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 2
			local var_4_41 = 0.325

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_43 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_44 = arg_1_1:GetWordFromCfg(322031001)
				local var_4_45 = arg_1_1:FormatText(var_4_44.content)

				arg_1_1.text_.text = var_4_45

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_46 = 13
				local var_4_47 = utf8.len(var_4_45)
				local var_4_48 = var_4_46 <= 0 and var_4_41 or var_4_41 * (var_4_47 / var_4_46)

				if var_4_48 > 0 and var_4_41 < var_4_48 then
					arg_1_1.talkMaxDuration = var_4_48
					var_4_40 = var_4_40 + 0.3

					if var_4_48 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_48 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_45
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031001", "story_v_out_322031.awb") ~= 0 then
					local var_4_49 = manager.audio:GetVoiceLength("story_v_out_322031", "322031001", "story_v_out_322031.awb") / 1000

					if var_4_49 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_49 + var_4_40
					end

					if var_4_44.prefab_name ~= "" and arg_1_1.actors_[var_4_44.prefab_name] ~= nil then
						local var_4_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_44.prefab_name].transform, "story_v_out_322031", "322031001", "story_v_out_322031.awb")

						arg_1_1:RecordAudio("322031001", var_4_50)
						arg_1_1:RecordAudio("322031001", var_4_50)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322031", "322031001", "story_v_out_322031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322031", "322031001", "story_v_out_322031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_51 = var_4_40 + 0.3
			local var_4_52 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_51 <= arg_1_1.time_ and arg_1_1.time_ < var_4_51 + var_4_52 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_51) / var_4_52

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_51 + var_4_52 and arg_1_1.time_ < var_4_51 + var_4_52 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play322031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322031002
		arg_9_1.duration_ = 5.97

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.1
			local var_12_1 = 1

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				local var_12_2 = "play"
				local var_12_3 = "effect"

				arg_9_1:AudioAction(var_12_2, var_12_3, "se_story_1311", "se_story_1311_car02", "")
			end

			local var_12_4 = manager.ui.mainCamera.transform
			local var_12_5 = 0.466666666666667

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				local var_12_6 = arg_9_1.var_.effect1002
				local var_12_7
				local var_12_8 = var_12_4

				if not var_12_6 then
					var_12_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), var_12_8)
					var_12_6.name = "1002"
					arg_9_1.var_.effect1002 = var_12_6
				else
					var_12_6.transform:SetParent(var_12_8)
				end

				var_12_6.transform.localPosition = Vector3.New(0, 0, -4.48)
				var_12_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_12_9 = manager.ui.mainCamera.transform
			local var_12_10 = 0.566666666666667

			if var_12_10 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.var_.shakeOldPos = var_12_9.localPosition
			end

			local var_12_11 = 0.4

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_11 then
				local var_12_12 = (arg_9_1.time_ - var_12_10) / 0.066
				local var_12_13, var_12_14 = math.modf(var_12_12)

				var_12_9.localPosition = Vector3.New(var_12_14 * 0.13, var_12_14 * 0.13, var_12_14 * 0.13) + arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.time_ >= var_12_10 + var_12_11 and arg_9_1.time_ < var_12_10 + var_12_11 + arg_12_0 then
				var_12_9.localPosition = arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_15 = 0.966666666666667
			local var_12_16 = 0.8

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_17 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_17:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_18 = arg_9_1:GetWordFromCfg(322031002)
				local var_12_19 = arg_9_1:FormatText(var_12_18.content)

				arg_9_1.text_.text = var_12_19

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_20 = 32
				local var_12_21 = utf8.len(var_12_19)
				local var_12_22 = var_12_20 <= 0 and var_12_16 or var_12_16 * (var_12_21 / var_12_20)

				if var_12_22 > 0 and var_12_16 < var_12_22 then
					arg_9_1.talkMaxDuration = var_12_22
					var_12_15 = var_12_15 + 0.3

					if var_12_22 + var_12_15 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_22 + var_12_15
					end
				end

				arg_9_1.text_.text = var_12_19
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_23 = var_12_15 + 0.3
			local var_12_24 = math.max(var_12_16, arg_9_1.talkMaxDuration)

			if var_12_23 <= arg_9_1.time_ and arg_9_1.time_ < var_12_23 + var_12_24 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_23) / var_12_24

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_23 + var_12_24 and arg_9_1.time_ < var_12_23 + var_12_24 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play322031003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 322031003
		arg_15_1.duration_ = 5.33

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play322031004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = manager.ui.mainCamera.transform
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				local var_18_2 = arg_15_1.var_.effect1002

				if var_18_2 then
					Object.Destroy(var_18_2)

					arg_15_1.var_.effect1002 = nil
				end
			end

			local var_18_3 = 0

			if var_18_3 < arg_15_1.time_ and arg_15_1.time_ <= var_18_3 + arg_18_0 then
				arg_15_1.mask_.enabled = true
				arg_15_1.mask_.raycastTarget = false

				arg_15_1:SetGaussion(false)
			end

			local var_18_4 = 0.333333333333333

			if var_18_3 <= arg_15_1.time_ and arg_15_1.time_ < var_18_3 + var_18_4 then
				local var_18_5 = (arg_15_1.time_ - var_18_3) / var_18_4
				local var_18_6 = Color.New(0, 0, 0)

				var_18_6.a = Mathf.Lerp(1, 0, var_18_5)
				arg_15_1.mask_.color = var_18_6
			end

			if arg_15_1.time_ >= var_18_3 + var_18_4 and arg_15_1.time_ < var_18_3 + var_18_4 + arg_18_0 then
				local var_18_7 = Color.New(0, 0, 0)
				local var_18_8 = 0

				arg_15_1.mask_.enabled = false
				var_18_7.a = var_18_8
				arg_15_1.mask_.color = var_18_7
			end

			if arg_15_1.frameCnt_ <= 1 then
				arg_15_1.dialog_:SetActive(false)
			end

			local var_18_9 = 0.333333333333333
			local var_18_10 = 1.2

			if var_18_9 < arg_15_1.time_ and arg_15_1.time_ <= var_18_9 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0

				arg_15_1.dialog_:SetActive(true)

				arg_15_1.dialogCg_.alpha = 0

				local var_18_11 = LeanTween.value(arg_15_1.dialog_, 0, 1, 0.3)

				var_18_11:setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
					arg_15_1.dialogCg_.alpha = arg_19_0
				end))
				var_18_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_15_1.dialog_)
					var_18_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_15_1.duration_ = arg_15_1.duration_ + 0.3

				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_12 = arg_15_1:GetWordFromCfg(322031003)
				local var_18_13 = arg_15_1:FormatText(var_18_12.content)

				arg_15_1.text_.text = var_18_13

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_14 = 48
				local var_18_15 = utf8.len(var_18_13)
				local var_18_16 = var_18_14 <= 0 and var_18_10 or var_18_10 * (var_18_15 / var_18_14)

				if var_18_16 > 0 and var_18_10 < var_18_16 then
					arg_15_1.talkMaxDuration = var_18_16
					var_18_9 = var_18_9 + 0.3

					if var_18_16 + var_18_9 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_16 + var_18_9
					end
				end

				arg_15_1.text_.text = var_18_13
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_17 = var_18_9 + 0.3
			local var_18_18 = math.max(var_18_10, arg_15_1.talkMaxDuration)

			if var_18_17 <= arg_15_1.time_ and arg_15_1.time_ < var_18_17 + var_18_18 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_17) / var_18_18

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_17 + var_18_18 and arg_15_1.time_ < var_18_17 + var_18_18 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play322031004 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322031004
		arg_21_1.duration_ = 10.6

		local var_21_0 = {
			zh = 8.566,
			ja = 10.6
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
				arg_21_0:Play322031005(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.075

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[605].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(322031004)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031004", "story_v_out_322031.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_322031", "322031004", "story_v_out_322031.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_322031", "322031004", "story_v_out_322031.awb")

						arg_21_1:RecordAudio("322031004", var_24_9)
						arg_21_1:RecordAudio("322031004", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_322031", "322031004", "story_v_out_322031.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_322031", "322031004", "story_v_out_322031.awb")
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
	Play322031005 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322031005
		arg_25_1.duration_ = 3.53

		local var_25_0 = {
			zh = 2.466,
			ja = 3.533
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
				arg_25_0:Play322031006(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "1284ui_story"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_25_1.stage_.transform)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentInChildren(typeof(CharacterEffect))

					var_28_3.enabled = true

					local var_28_4 = GameObjectTools.GetOrAddComponent(var_28_2, typeof(DynamicBoneHelper))

					if var_28_4 then
						var_28_4:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_3.transform, false)

					arg_25_1.var_[var_28_0 .. "Animator"] = var_28_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_0 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_0 .. "LipSync"] = var_28_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_5 = arg_25_1.actors_["1284ui_story"].transform
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.var_.moveOldPos1284ui_story = var_28_5.localPosition

				local var_28_7 = "1284ui_story"

				arg_25_1:ShowWeapon(arg_25_1.var_[var_28_7 .. "Animator"].transform, false)
			end

			local var_28_8 = 0.001

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_8 then
				local var_28_9 = (arg_25_1.time_ - var_28_6) / var_28_8
				local var_28_10 = Vector3.New(0, -0.985, -6.22)

				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1284ui_story, var_28_10, var_28_9)

				local var_28_11 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_11.x, var_28_11.y, var_28_11.z)

				local var_28_12 = var_28_5.localEulerAngles

				var_28_12.z = 0
				var_28_12.x = 0
				var_28_5.localEulerAngles = var_28_12
			end

			if arg_25_1.time_ >= var_28_6 + var_28_8 and arg_25_1.time_ < var_28_6 + var_28_8 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_28_13 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_13.x, var_28_13.y, var_28_13.z)

				local var_28_14 = var_28_5.localEulerAngles

				var_28_14.z = 0
				var_28_14.x = 0
				var_28_5.localEulerAngles = var_28_14
			end

			local var_28_15 = arg_25_1.actors_["1284ui_story"]
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.characterEffect1284ui_story == nil then
				arg_25_1.var_.characterEffect1284ui_story = var_28_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_17 = 0.200000002980232

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 and not isNil(var_28_15) then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17

				if arg_25_1.var_.characterEffect1284ui_story and not isNil(var_28_15) then
					arg_25_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.characterEffect1284ui_story then
				arg_25_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_28_19 = 0

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 then
				arg_25_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			local var_28_20 = 0

			if var_28_20 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 then
				arg_25_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_28_21 = 0
			local var_28_22 = 0.25

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_23 = arg_25_1:FormatText(StoryNameCfg[6].name)

				arg_25_1.leftNameTxt_.text = var_28_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_24 = arg_25_1:GetWordFromCfg(322031005)
				local var_28_25 = arg_25_1:FormatText(var_28_24.content)

				arg_25_1.text_.text = var_28_25

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_26 = 10
				local var_28_27 = utf8.len(var_28_25)
				local var_28_28 = var_28_26 <= 0 and var_28_22 or var_28_22 * (var_28_27 / var_28_26)

				if var_28_28 > 0 and var_28_22 < var_28_28 then
					arg_25_1.talkMaxDuration = var_28_28

					if var_28_28 + var_28_21 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_21
					end
				end

				arg_25_1.text_.text = var_28_25
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031005", "story_v_out_322031.awb") ~= 0 then
					local var_28_29 = manager.audio:GetVoiceLength("story_v_out_322031", "322031005", "story_v_out_322031.awb") / 1000

					if var_28_29 + var_28_21 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_29 + var_28_21
					end

					if var_28_24.prefab_name ~= "" and arg_25_1.actors_[var_28_24.prefab_name] ~= nil then
						local var_28_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_24.prefab_name].transform, "story_v_out_322031", "322031005", "story_v_out_322031.awb")

						arg_25_1:RecordAudio("322031005", var_28_30)
						arg_25_1:RecordAudio("322031005", var_28_30)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322031", "322031005", "story_v_out_322031.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322031", "322031005", "story_v_out_322031.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_31 = math.max(var_28_22, arg_25_1.talkMaxDuration)

			if var_28_21 <= arg_25_1.time_ and arg_25_1.time_ < var_28_21 + var_28_31 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_21) / var_28_31

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_21 + var_28_31 and arg_25_1.time_ < var_28_21 + var_28_31 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play322031006 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322031006
		arg_29_1.duration_ = 12.4

		local var_29_0 = {
			zh = 9.266,
			ja = 12.4
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
				arg_29_0:Play322031007(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1284ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1284ui_story == nil then
				arg_29_1.var_.characterEffect1284ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1284ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1284ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1284ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1284ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0
			local var_32_7 = 1.175

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[605].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_9 = arg_29_1:GetWordFromCfg(322031006)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 47
				local var_32_12 = utf8.len(var_32_10)
				local var_32_13 = var_32_11 <= 0 and var_32_7 or var_32_7 * (var_32_12 / var_32_11)

				if var_32_13 > 0 and var_32_7 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031006", "story_v_out_322031.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_322031", "322031006", "story_v_out_322031.awb") / 1000

					if var_32_14 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_6
					end

					if var_32_9.prefab_name ~= "" and arg_29_1.actors_[var_32_9.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_9.prefab_name].transform, "story_v_out_322031", "322031006", "story_v_out_322031.awb")

						arg_29_1:RecordAudio("322031006", var_32_15)
						arg_29_1:RecordAudio("322031006", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322031", "322031006", "story_v_out_322031.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322031", "322031006", "story_v_out_322031.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_16 and arg_29_1.time_ < var_32_6 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play322031007 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322031007
		arg_33_1.duration_ = 6.13

		local var_33_0 = {
			zh = 4.333,
			ja = 6.133
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
				arg_33_0:Play322031008(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.55

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[605].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(322031007)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031007", "story_v_out_322031.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_322031", "322031007", "story_v_out_322031.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_322031", "322031007", "story_v_out_322031.awb")

						arg_33_1:RecordAudio("322031007", var_36_9)
						arg_33_1:RecordAudio("322031007", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_322031", "322031007", "story_v_out_322031.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_322031", "322031007", "story_v_out_322031.awb")
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
	Play322031008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322031008
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play322031009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.2

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(322031008)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 8
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
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_8 and arg_37_1.time_ < var_40_0 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play322031009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322031009
		arg_41_1.duration_ = 12.27

		local var_41_0 = {
			zh = 7.933,
			ja = 12.266
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
				arg_41_0:Play322031010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.95

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[605].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(322031009)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031009", "story_v_out_322031.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_322031", "322031009", "story_v_out_322031.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_322031", "322031009", "story_v_out_322031.awb")

						arg_41_1:RecordAudio("322031009", var_44_9)
						arg_41_1:RecordAudio("322031009", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322031", "322031009", "story_v_out_322031.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322031", "322031009", "story_v_out_322031.awb")
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
	Play322031010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322031010
		arg_45_1.duration_ = 7.03

		local var_45_0 = {
			zh = 6.733,
			ja = 7.033
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
				arg_45_0:Play322031011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.75

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[605].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(322031010)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031010", "story_v_out_322031.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_322031", "322031010", "story_v_out_322031.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_322031", "322031010", "story_v_out_322031.awb")

						arg_45_1:RecordAudio("322031010", var_48_9)
						arg_45_1:RecordAudio("322031010", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_322031", "322031010", "story_v_out_322031.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_322031", "322031010", "story_v_out_322031.awb")
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
	Play322031011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322031011
		arg_49_1.duration_ = 10.33

		local var_49_0 = {
			zh = 6.333,
			ja = 10.333
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
				arg_49_0:Play322031012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1284ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1284ui_story == nil then
				arg_49_1.var_.characterEffect1284ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1284ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1284ui_story then
				arg_49_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_52_4 = 0

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_2")
			end

			local var_52_5 = 0
			local var_52_6 = 0.85

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_7 = arg_49_1:FormatText(StoryNameCfg[6].name)

				arg_49_1.leftNameTxt_.text = var_52_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(322031011)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 34
				local var_52_11 = utf8.len(var_52_9)
				local var_52_12 = var_52_10 <= 0 and var_52_6 or var_52_6 * (var_52_11 / var_52_10)

				if var_52_12 > 0 and var_52_6 < var_52_12 then
					arg_49_1.talkMaxDuration = var_52_12

					if var_52_12 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031011", "story_v_out_322031.awb") ~= 0 then
					local var_52_13 = manager.audio:GetVoiceLength("story_v_out_322031", "322031011", "story_v_out_322031.awb") / 1000

					if var_52_13 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_5
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_322031", "322031011", "story_v_out_322031.awb")

						arg_49_1:RecordAudio("322031011", var_52_14)
						arg_49_1:RecordAudio("322031011", var_52_14)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322031", "322031011", "story_v_out_322031.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322031", "322031011", "story_v_out_322031.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_15 = math.max(var_52_6, arg_49_1.talkMaxDuration)

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_15 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_5) / var_52_15

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_5 + var_52_15 and arg_49_1.time_ < var_52_5 + var_52_15 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play322031012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322031012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play322031013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1284ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1284ui_story == nil then
				arg_53_1.var_.characterEffect1284ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1284ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1284ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1284ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1284ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 0.725

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_9 = arg_53_1:GetWordFromCfg(322031012)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 29
				local var_56_12 = utf8.len(var_56_10)
				local var_56_13 = var_56_11 <= 0 and var_56_7 or var_56_7 * (var_56_12 / var_56_11)

				if var_56_13 > 0 and var_56_7 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_10
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play322031013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322031013
		arg_57_1.duration_ = 1.83

		local var_57_0 = {
			zh = 1,
			ja = 1.833
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play322031014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.05

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[605].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(322031013)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 2
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031013", "story_v_out_322031.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_322031", "322031013", "story_v_out_322031.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_322031", "322031013", "story_v_out_322031.awb")

						arg_57_1:RecordAudio("322031013", var_60_9)
						arg_57_1:RecordAudio("322031013", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_322031", "322031013", "story_v_out_322031.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_322031", "322031013", "story_v_out_322031.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play322031014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322031014
		arg_61_1.duration_ = 1.17

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play322031015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1284ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1284ui_story == nil then
				arg_61_1.var_.characterEffect1284ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1284ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1284ui_story then
				arg_61_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_64_4 = 0
			local var_64_5 = 0.2

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_6 = arg_61_1:FormatText(StoryNameCfg[6].name)

				arg_61_1.leftNameTxt_.text = var_64_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_7 = arg_61_1:GetWordFromCfg(322031014)
				local var_64_8 = arg_61_1:FormatText(var_64_7.content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 2
				local var_64_10 = utf8.len(var_64_8)
				local var_64_11 = var_64_9 <= 0 and var_64_5 or var_64_5 * (var_64_10 / var_64_9)

				if var_64_11 > 0 and var_64_5 < var_64_11 then
					arg_61_1.talkMaxDuration = var_64_11

					if var_64_11 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031014", "story_v_out_322031.awb") ~= 0 then
					local var_64_12 = manager.audio:GetVoiceLength("story_v_out_322031", "322031014", "story_v_out_322031.awb") / 1000

					if var_64_12 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_4
					end

					if var_64_7.prefab_name ~= "" and arg_61_1.actors_[var_64_7.prefab_name] ~= nil then
						local var_64_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_7.prefab_name].transform, "story_v_out_322031", "322031014", "story_v_out_322031.awb")

						arg_61_1:RecordAudio("322031014", var_64_13)
						arg_61_1:RecordAudio("322031014", var_64_13)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_322031", "322031014", "story_v_out_322031.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_322031", "322031014", "story_v_out_322031.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_14 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_14 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_14

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_14 and arg_61_1.time_ < var_64_4 + var_64_14 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play322031015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 322031015
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play322031016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1284ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1284ui_story == nil then
				arg_65_1.var_.characterEffect1284ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1284ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1284ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1284ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1284ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 0.2

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_8 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_9 = arg_65_1:GetWordFromCfg(322031015)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 8
				local var_68_12 = utf8.len(var_68_10)
				local var_68_13 = var_68_11 <= 0 and var_68_7 or var_68_7 * (var_68_12 / var_68_11)

				if var_68_13 > 0 and var_68_7 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_10
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_14 and arg_65_1.time_ < var_68_6 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play322031016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 322031016
		arg_69_1.duration_ = 5.37

		local var_69_0 = {
			zh = 4.133,
			ja = 5.366
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play322031017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1284ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1284ui_story == nil then
				arg_69_1.var_.characterEffect1284ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1284ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1284ui_story then
				arg_69_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_72_4 = 0

			if var_72_4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			local var_72_5 = 0
			local var_72_6 = 0.475

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_7 = arg_69_1:FormatText(StoryNameCfg[6].name)

				arg_69_1.leftNameTxt_.text = var_72_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(322031016)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 19
				local var_72_11 = utf8.len(var_72_9)
				local var_72_12 = var_72_10 <= 0 and var_72_6 or var_72_6 * (var_72_11 / var_72_10)

				if var_72_12 > 0 and var_72_6 < var_72_12 then
					arg_69_1.talkMaxDuration = var_72_12

					if var_72_12 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_5
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031016", "story_v_out_322031.awb") ~= 0 then
					local var_72_13 = manager.audio:GetVoiceLength("story_v_out_322031", "322031016", "story_v_out_322031.awb") / 1000

					if var_72_13 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_5
					end

					if var_72_8.prefab_name ~= "" and arg_69_1.actors_[var_72_8.prefab_name] ~= nil then
						local var_72_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_8.prefab_name].transform, "story_v_out_322031", "322031016", "story_v_out_322031.awb")

						arg_69_1:RecordAudio("322031016", var_72_14)
						arg_69_1:RecordAudio("322031016", var_72_14)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_322031", "322031016", "story_v_out_322031.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_322031", "322031016", "story_v_out_322031.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_15 = math.max(var_72_6, arg_69_1.talkMaxDuration)

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_15 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_5) / var_72_15

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_5 + var_72_15 and arg_69_1.time_ < var_72_5 + var_72_15 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play322031017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 322031017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play322031018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1284ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1284ui_story == nil then
				arg_73_1.var_.characterEffect1284ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1284ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1284ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1284ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1284ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.525

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_9 = arg_73_1:GetWordFromCfg(322031017)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 21
				local var_76_12 = utf8.len(var_76_10)
				local var_76_13 = var_76_11 <= 0 and var_76_7 or var_76_7 * (var_76_12 / var_76_11)

				if var_76_13 > 0 and var_76_7 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_14 and arg_73_1.time_ < var_76_6 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play322031018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 322031018
		arg_77_1.duration_ = 2.57

		local var_77_0 = {
			zh = 2.566,
			ja = 1.999999999999
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play322031019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1284ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1284ui_story == nil then
				arg_77_1.var_.characterEffect1284ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1284ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1284ui_story then
				arg_77_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_80_4 = 0

			if var_80_4 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_2")
			end

			local var_80_5 = 0
			local var_80_6 = 0.225

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_7 = arg_77_1:FormatText(StoryNameCfg[6].name)

				arg_77_1.leftNameTxt_.text = var_80_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(322031018)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 9
				local var_80_11 = utf8.len(var_80_9)
				local var_80_12 = var_80_10 <= 0 and var_80_6 or var_80_6 * (var_80_11 / var_80_10)

				if var_80_12 > 0 and var_80_6 < var_80_12 then
					arg_77_1.talkMaxDuration = var_80_12

					if var_80_12 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031018", "story_v_out_322031.awb") ~= 0 then
					local var_80_13 = manager.audio:GetVoiceLength("story_v_out_322031", "322031018", "story_v_out_322031.awb") / 1000

					if var_80_13 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_5
					end

					if var_80_8.prefab_name ~= "" and arg_77_1.actors_[var_80_8.prefab_name] ~= nil then
						local var_80_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_8.prefab_name].transform, "story_v_out_322031", "322031018", "story_v_out_322031.awb")

						arg_77_1:RecordAudio("322031018", var_80_14)
						arg_77_1:RecordAudio("322031018", var_80_14)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_322031", "322031018", "story_v_out_322031.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_322031", "322031018", "story_v_out_322031.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_15 = math.max(var_80_6, arg_77_1.talkMaxDuration)

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_15 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_5) / var_80_15

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_5 + var_80_15 and arg_77_1.time_ < var_80_5 + var_80_15 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play322031019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 322031019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play322031020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1284ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1284ui_story == nil then
				arg_81_1.var_.characterEffect1284ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1284ui_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1284ui_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1284ui_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1284ui_story.fillRatio = var_84_5
			end

			local var_84_6 = 0
			local var_84_7 = 0.575

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_8 = arg_81_1:FormatText(StoryNameCfg[7].name)

				arg_81_1.leftNameTxt_.text = var_84_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_9 = arg_81_1:GetWordFromCfg(322031019)
				local var_84_10 = arg_81_1:FormatText(var_84_9.content)

				arg_81_1.text_.text = var_84_10

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 23
				local var_84_12 = utf8.len(var_84_10)
				local var_84_13 = var_84_11 <= 0 and var_84_7 or var_84_7 * (var_84_12 / var_84_11)

				if var_84_13 > 0 and var_84_7 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_10
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_14 and arg_81_1.time_ < var_84_6 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play322031020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 322031020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play322031021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.925

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[7].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(322031020)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 37
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_1 or var_88_1 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_1 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_8 and arg_85_1.time_ < var_88_0 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play322031021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 322031021
		arg_89_1.duration_ = 8.57

		local var_89_0 = {
			zh = 5.166,
			ja = 8.566
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play322031022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1284ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1284ui_story == nil then
				arg_89_1.var_.characterEffect1284ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1284ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1284ui_story then
				arg_89_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_92_4 = 0
			local var_92_5 = 0.55

			if var_92_4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_6 = arg_89_1:FormatText(StoryNameCfg[6].name)

				arg_89_1.leftNameTxt_.text = var_92_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_7 = arg_89_1:GetWordFromCfg(322031021)
				local var_92_8 = arg_89_1:FormatText(var_92_7.content)

				arg_89_1.text_.text = var_92_8

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 22
				local var_92_10 = utf8.len(var_92_8)
				local var_92_11 = var_92_9 <= 0 and var_92_5 or var_92_5 * (var_92_10 / var_92_9)

				if var_92_11 > 0 and var_92_5 < var_92_11 then
					arg_89_1.talkMaxDuration = var_92_11

					if var_92_11 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_8
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031021", "story_v_out_322031.awb") ~= 0 then
					local var_92_12 = manager.audio:GetVoiceLength("story_v_out_322031", "322031021", "story_v_out_322031.awb") / 1000

					if var_92_12 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_4
					end

					if var_92_7.prefab_name ~= "" and arg_89_1.actors_[var_92_7.prefab_name] ~= nil then
						local var_92_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_7.prefab_name].transform, "story_v_out_322031", "322031021", "story_v_out_322031.awb")

						arg_89_1:RecordAudio("322031021", var_92_13)
						arg_89_1:RecordAudio("322031021", var_92_13)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_322031", "322031021", "story_v_out_322031.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_322031", "322031021", "story_v_out_322031.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_14 and arg_89_1.time_ < var_92_4 + var_92_14 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play322031022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 322031022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play322031023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1284ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1284ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, 100, 0)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1284ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, 100, 0)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = 1
			local var_96_10 = 1

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 then
				local var_96_11 = "play"
				local var_96_12 = "effect"

				arg_93_1:AudioAction(var_96_11, var_96_12, "se_story_140", "se_story_140_car_brake", "")
			end

			local var_96_13 = manager.ui.mainCamera.transform
			local var_96_14 = 1

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				local var_96_15 = arg_93_1.var_.effect1022
				local var_96_16
				local var_96_17 = var_96_13

				if not var_96_15 then
					var_96_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), var_96_17)
					var_96_15.name = "1022"
					arg_93_1.var_.effect1022 = var_96_15
				else
					var_96_15.transform:SetParent(var_96_17)
				end

				var_96_15.transform.localPosition = Vector3.New(0, 0, -4.48)
				var_96_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_96_18 = manager.ui.mainCamera.transform
			local var_96_19 = 2.33333333333333

			if var_96_19 < arg_93_1.time_ and arg_93_1.time_ <= var_96_19 + arg_96_0 then
				local var_96_20 = arg_93_1.var_.effect1022

				if var_96_20 then
					Object.Destroy(var_96_20)

					arg_93_1.var_.effect1022 = nil
				end
			end

			local var_96_21 = manager.ui.mainCamera.transform
			local var_96_22 = 1

			if var_96_22 < arg_93_1.time_ and arg_93_1.time_ <= var_96_22 + arg_96_0 then
				arg_93_1.var_.shakeOldPos = var_96_21.localPosition
			end

			local var_96_23 = 0.333333333333333

			if var_96_22 <= arg_93_1.time_ and arg_93_1.time_ < var_96_22 + var_96_23 then
				local var_96_24 = (arg_93_1.time_ - var_96_22) / 0.066
				local var_96_25, var_96_26 = math.modf(var_96_24)

				var_96_21.localPosition = Vector3.New(var_96_26 * 0.13, var_96_26 * 0.13, var_96_26 * 0.13) + arg_93_1.var_.shakeOldPos
			end

			if arg_93_1.time_ >= var_96_22 + var_96_23 and arg_93_1.time_ < var_96_22 + var_96_23 + arg_96_0 then
				var_96_21.localPosition = arg_93_1.var_.shakeOldPos
			end

			local var_96_27 = 0
			local var_96_28 = 1.45

			if var_96_27 < arg_93_1.time_ and arg_93_1.time_ <= var_96_27 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_29 = arg_93_1:GetWordFromCfg(322031022)
				local var_96_30 = arg_93_1:FormatText(var_96_29.content)

				arg_93_1.text_.text = var_96_30

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_31 = 58
				local var_96_32 = utf8.len(var_96_30)
				local var_96_33 = var_96_31 <= 0 and var_96_28 or var_96_28 * (var_96_32 / var_96_31)

				if var_96_33 > 0 and var_96_28 < var_96_33 then
					arg_93_1.talkMaxDuration = var_96_33

					if var_96_33 + var_96_27 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_33 + var_96_27
					end
				end

				arg_93_1.text_.text = var_96_30
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_34 = math.max(var_96_28, arg_93_1.talkMaxDuration)

			if var_96_27 <= arg_93_1.time_ and arg_93_1.time_ < var_96_27 + var_96_34 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_27) / var_96_34

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_27 + var_96_34 and arg_93_1.time_ < var_96_27 + var_96_34 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play322031023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322031023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play322031024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = manager.ui.mainCamera.transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				local var_100_2 = arg_97_1.var_.effect1022

				if var_100_2 then
					Object.Destroy(var_100_2)

					arg_97_1.var_.effect1022 = nil
				end
			end

			local var_100_3 = 0
			local var_100_4 = 0.175

			if var_100_3 < arg_97_1.time_ and arg_97_1.time_ <= var_100_3 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_5 = arg_97_1:FormatText(StoryNameCfg[7].name)

				arg_97_1.leftNameTxt_.text = var_100_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_6 = arg_97_1:GetWordFromCfg(322031023)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_8 = 7
				local var_100_9 = utf8.len(var_100_7)
				local var_100_10 = var_100_8 <= 0 and var_100_4 or var_100_4 * (var_100_9 / var_100_8)

				if var_100_10 > 0 and var_100_4 < var_100_10 then
					arg_97_1.talkMaxDuration = var_100_10

					if var_100_10 + var_100_3 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_3
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_11 = math.max(var_100_4, arg_97_1.talkMaxDuration)

			if var_100_3 <= arg_97_1.time_ and arg_97_1.time_ < var_100_3 + var_100_11 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_3) / var_100_11

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_3 + var_100_11 and arg_97_1.time_ < var_100_3 + var_100_11 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play322031024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322031024
		arg_101_1.duration_ = 4.23

		local var_101_0 = {
			zh = 3.3,
			ja = 4.233
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play322031025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1284ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1284ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0, -0.985, -6.22)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1284ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1284ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1284ui_story == nil then
				arg_101_1.var_.characterEffect1284ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect1284ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1284ui_story then
				arg_101_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action8_1")
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_104_15 = 0
			local var_104_16 = 0.4

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_17 = arg_101_1:FormatText(StoryNameCfg[6].name)

				arg_101_1.leftNameTxt_.text = var_104_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_18 = arg_101_1:GetWordFromCfg(322031024)
				local var_104_19 = arg_101_1:FormatText(var_104_18.content)

				arg_101_1.text_.text = var_104_19

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_20 = 16
				local var_104_21 = utf8.len(var_104_19)
				local var_104_22 = var_104_20 <= 0 and var_104_16 or var_104_16 * (var_104_21 / var_104_20)

				if var_104_22 > 0 and var_104_16 < var_104_22 then
					arg_101_1.talkMaxDuration = var_104_22

					if var_104_22 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_22 + var_104_15
					end
				end

				arg_101_1.text_.text = var_104_19
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031024", "story_v_out_322031.awb") ~= 0 then
					local var_104_23 = manager.audio:GetVoiceLength("story_v_out_322031", "322031024", "story_v_out_322031.awb") / 1000

					if var_104_23 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_15
					end

					if var_104_18.prefab_name ~= "" and arg_101_1.actors_[var_104_18.prefab_name] ~= nil then
						local var_104_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_18.prefab_name].transform, "story_v_out_322031", "322031024", "story_v_out_322031.awb")

						arg_101_1:RecordAudio("322031024", var_104_24)
						arg_101_1:RecordAudio("322031024", var_104_24)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_322031", "322031024", "story_v_out_322031.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_322031", "322031024", "story_v_out_322031.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_25 = math.max(var_104_16, arg_101_1.talkMaxDuration)

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_25 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_15) / var_104_25

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_15 + var_104_25 and arg_101_1.time_ < var_104_15 + var_104_25 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play322031025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 322031025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play322031026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1284ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1284ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0, 100, 0)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1284ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, 100, 0)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = 0
			local var_108_10 = 1.175

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_11 = arg_105_1:GetWordFromCfg(322031025)
				local var_108_12 = arg_105_1:FormatText(var_108_11.content)

				arg_105_1.text_.text = var_108_12

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 47
				local var_108_14 = utf8.len(var_108_12)
				local var_108_15 = var_108_13 <= 0 and var_108_10 or var_108_10 * (var_108_14 / var_108_13)

				if var_108_15 > 0 and var_108_10 < var_108_15 then
					arg_105_1.talkMaxDuration = var_108_15

					if var_108_15 + var_108_9 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_15 + var_108_9
					end
				end

				arg_105_1.text_.text = var_108_12
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_10, arg_105_1.talkMaxDuration)

			if var_108_9 <= arg_105_1.time_ and arg_105_1.time_ < var_108_9 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_9) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_9 + var_108_16 and arg_105_1.time_ < var_108_9 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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

		arg_105_1:InitPlayNodeList()
	end,
	Play322031026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 322031026
		arg_109_1.duration_ = 9

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play322031027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = "ST0511a"

			if arg_109_1.bgs_[var_112_0] == nil then
				local var_112_1 = Object.Instantiate(arg_109_1.paintGo_)

				var_112_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_112_0)
				var_112_1.name = var_112_0
				var_112_1.transform.parent = arg_109_1.stage_.transform
				var_112_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.bgs_[var_112_0] = var_112_1
			end

			local var_112_2 = 2

			if var_112_2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				local var_112_3 = manager.ui.mainCamera.transform.localPosition
				local var_112_4 = Vector3.New(0, 0, 10) + Vector3.New(var_112_3.x, var_112_3.y, 0)
				local var_112_5 = arg_109_1.bgs_.ST0511a

				var_112_5.transform.localPosition = var_112_4
				var_112_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_6 = var_112_5:GetComponent("SpriteRenderer")

				if var_112_6 and var_112_6.sprite then
					local var_112_7 = (var_112_5.transform.localPosition - var_112_3).z
					local var_112_8 = manager.ui.mainCameraCom_
					local var_112_9 = 2 * var_112_7 * Mathf.Tan(var_112_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_112_10 = var_112_9 * var_112_8.aspect
					local var_112_11 = var_112_6.sprite.bounds.size.x
					local var_112_12 = var_112_6.sprite.bounds.size.y
					local var_112_13 = var_112_10 / var_112_11
					local var_112_14 = var_112_9 / var_112_12
					local var_112_15 = var_112_14 < var_112_13 and var_112_13 or var_112_14

					var_112_5.transform.localScale = Vector3.New(var_112_15, var_112_15, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "ST0511a" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_16 = 3.999999999999

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 then
				arg_109_1.allBtn_.enabled = false
			end

			local var_112_17 = 0.3

			if arg_109_1.time_ >= var_112_16 + var_112_17 and arg_109_1.time_ < var_112_16 + var_112_17 + arg_112_0 then
				arg_109_1.allBtn_.enabled = true
			end

			local var_112_18 = 0

			if var_112_18 < arg_109_1.time_ and arg_109_1.time_ <= var_112_18 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_19 = 2

			if var_112_18 <= arg_109_1.time_ and arg_109_1.time_ < var_112_18 + var_112_19 then
				local var_112_20 = (arg_109_1.time_ - var_112_18) / var_112_19
				local var_112_21 = Color.New(0, 0, 0)

				var_112_21.a = Mathf.Lerp(0, 1, var_112_20)
				arg_109_1.mask_.color = var_112_21
			end

			if arg_109_1.time_ >= var_112_18 + var_112_19 and arg_109_1.time_ < var_112_18 + var_112_19 + arg_112_0 then
				local var_112_22 = Color.New(0, 0, 0)

				var_112_22.a = 1
				arg_109_1.mask_.color = var_112_22
			end

			local var_112_23 = 2

			if var_112_23 < arg_109_1.time_ and arg_109_1.time_ <= var_112_23 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_24 = 2

			if var_112_23 <= arg_109_1.time_ and arg_109_1.time_ < var_112_23 + var_112_24 then
				local var_112_25 = (arg_109_1.time_ - var_112_23) / var_112_24
				local var_112_26 = Color.New(0, 0, 0)

				var_112_26.a = Mathf.Lerp(1, 0, var_112_25)
				arg_109_1.mask_.color = var_112_26
			end

			if arg_109_1.time_ >= var_112_23 + var_112_24 and arg_109_1.time_ < var_112_23 + var_112_24 + arg_112_0 then
				local var_112_27 = Color.New(0, 0, 0)
				local var_112_28 = 0

				arg_109_1.mask_.enabled = false
				var_112_27.a = var_112_28
				arg_109_1.mask_.color = var_112_27
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_29 = 3.999999999999
			local var_112_30 = 0.975

			if var_112_29 < arg_109_1.time_ and arg_109_1.time_ <= var_112_29 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_31 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_31:setOnUpdate(LuaHelper.FloatAction(function(arg_113_0)
					arg_109_1.dialogCg_.alpha = arg_113_0
				end))
				var_112_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_32 = arg_109_1:GetWordFromCfg(322031026)
				local var_112_33 = arg_109_1:FormatText(var_112_32.content)

				arg_109_1.text_.text = var_112_33

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_34 = 39
				local var_112_35 = utf8.len(var_112_33)
				local var_112_36 = var_112_34 <= 0 and var_112_30 or var_112_30 * (var_112_35 / var_112_34)

				if var_112_36 > 0 and var_112_30 < var_112_36 then
					arg_109_1.talkMaxDuration = var_112_36
					var_112_29 = var_112_29 + 0.3

					if var_112_36 + var_112_29 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_36 + var_112_29
					end
				end

				arg_109_1.text_.text = var_112_33
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_37 = var_112_29 + 0.3
			local var_112_38 = math.max(var_112_30, arg_109_1.talkMaxDuration)

			if var_112_37 <= arg_109_1.time_ and arg_109_1.time_ < var_112_37 + var_112_38 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_37) / var_112_38

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_37 + var_112_38 and arg_109_1.time_ < var_112_37 + var_112_38 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play322031027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 322031027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play322031028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.2

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

				local var_118_3 = arg_115_1:GetWordFromCfg(322031027)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 8
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
	Play322031028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 322031028
		arg_119_1.duration_ = 2.07

		local var_119_0 = {
			zh = 1.999999999999,
			ja = 2.066
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
				arg_119_0:Play322031029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = "1156ui_story"

			if arg_119_1.actors_[var_122_0] == nil then
				local var_122_1 = Asset.Load("Char/" .. "1156ui_story")

				if not isNil(var_122_1) then
					local var_122_2 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_119_1.stage_.transform)

					var_122_2.name = var_122_0
					var_122_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_119_1.actors_[var_122_0] = var_122_2

					local var_122_3 = var_122_2:GetComponentInChildren(typeof(CharacterEffect))

					var_122_3.enabled = true

					local var_122_4 = GameObjectTools.GetOrAddComponent(var_122_2, typeof(DynamicBoneHelper))

					if var_122_4 then
						var_122_4:EnableDynamicBone(false)
					end

					arg_119_1:ShowWeapon(var_122_3.transform, false)

					arg_119_1.var_[var_122_0 .. "Animator"] = var_122_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_119_1.var_[var_122_0 .. "Animator"].applyRootMotion = true
					arg_119_1.var_[var_122_0 .. "LipSync"] = var_122_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_122_5 = arg_119_1.actors_["1156ui_story"].transform
			local var_122_6 = 0

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.var_.moveOldPos1156ui_story = var_122_5.localPosition
			end

			local var_122_7 = 0.001

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_7 then
				local var_122_8 = (arg_119_1.time_ - var_122_6) / var_122_7
				local var_122_9 = Vector3.New(-0.9, -1.1, -6.18)

				var_122_5.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1156ui_story, var_122_9, var_122_8)

				local var_122_10 = manager.ui.mainCamera.transform.position - var_122_5.position

				var_122_5.forward = Vector3.New(var_122_10.x, var_122_10.y, var_122_10.z)

				local var_122_11 = var_122_5.localEulerAngles

				var_122_11.z = 0
				var_122_11.x = 0
				var_122_5.localEulerAngles = var_122_11
			end

			if arg_119_1.time_ >= var_122_6 + var_122_7 and arg_119_1.time_ < var_122_6 + var_122_7 + arg_122_0 then
				var_122_5.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_122_12 = manager.ui.mainCamera.transform.position - var_122_5.position

				var_122_5.forward = Vector3.New(var_122_12.x, var_122_12.y, var_122_12.z)

				local var_122_13 = var_122_5.localEulerAngles

				var_122_13.z = 0
				var_122_13.x = 0
				var_122_5.localEulerAngles = var_122_13
			end

			local var_122_14 = arg_119_1.actors_["1156ui_story"]
			local var_122_15 = 0

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 and not isNil(var_122_14) and arg_119_1.var_.characterEffect1156ui_story == nil then
				arg_119_1.var_.characterEffect1156ui_story = var_122_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_16 = 0.200000002980232

			if var_122_15 <= arg_119_1.time_ and arg_119_1.time_ < var_122_15 + var_122_16 and not isNil(var_122_14) then
				local var_122_17 = (arg_119_1.time_ - var_122_15) / var_122_16

				if arg_119_1.var_.characterEffect1156ui_story and not isNil(var_122_14) then
					arg_119_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_15 + var_122_16 and arg_119_1.time_ < var_122_15 + var_122_16 + arg_122_0 and not isNil(var_122_14) and arg_119_1.var_.characterEffect1156ui_story then
				arg_119_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_122_18 = 0

			if var_122_18 < arg_119_1.time_ and arg_119_1.time_ <= var_122_18 + arg_122_0 then
				arg_119_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_122_19 = 0

			if var_122_19 < arg_119_1.time_ and arg_119_1.time_ <= var_122_19 + arg_122_0 then
				arg_119_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_122_20 = 0
			local var_122_21 = 0.175

			if var_122_20 < arg_119_1.time_ and arg_119_1.time_ <= var_122_20 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_22 = arg_119_1:FormatText(StoryNameCfg[605].name)

				arg_119_1.leftNameTxt_.text = var_122_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_23 = arg_119_1:GetWordFromCfg(322031028)
				local var_122_24 = arg_119_1:FormatText(var_122_23.content)

				arg_119_1.text_.text = var_122_24

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_25 = 7
				local var_122_26 = utf8.len(var_122_24)
				local var_122_27 = var_122_25 <= 0 and var_122_21 or var_122_21 * (var_122_26 / var_122_25)

				if var_122_27 > 0 and var_122_21 < var_122_27 then
					arg_119_1.talkMaxDuration = var_122_27

					if var_122_27 + var_122_20 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_27 + var_122_20
					end
				end

				arg_119_1.text_.text = var_122_24
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031028", "story_v_out_322031.awb") ~= 0 then
					local var_122_28 = manager.audio:GetVoiceLength("story_v_out_322031", "322031028", "story_v_out_322031.awb") / 1000

					if var_122_28 + var_122_20 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_28 + var_122_20
					end

					if var_122_23.prefab_name ~= "" and arg_119_1.actors_[var_122_23.prefab_name] ~= nil then
						local var_122_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_23.prefab_name].transform, "story_v_out_322031", "322031028", "story_v_out_322031.awb")

						arg_119_1:RecordAudio("322031028", var_122_29)
						arg_119_1:RecordAudio("322031028", var_122_29)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_322031", "322031028", "story_v_out_322031.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_322031", "322031028", "story_v_out_322031.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_30 = math.max(var_122_21, arg_119_1.talkMaxDuration)

			if var_122_20 <= arg_119_1.time_ and arg_119_1.time_ < var_122_20 + var_122_30 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_20) / var_122_30

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_20 + var_122_30 and arg_119_1.time_ < var_122_20 + var_122_30 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play322031029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 322031029
		arg_123_1.duration_ = 9.2

		local var_123_0 = {
			zh = 5.4,
			ja = 9.2
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
				arg_123_0:Play322031030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1284ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1284ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(0.7, -0.985, -6.22)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1284ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["1284ui_story"]
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1284ui_story == nil then
				arg_123_1.var_.characterEffect1284ui_story = var_126_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 and not isNil(var_126_9) then
				local var_126_12 = (arg_123_1.time_ - var_126_10) / var_126_11

				if arg_123_1.var_.characterEffect1284ui_story and not isNil(var_126_9) then
					arg_123_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1284ui_story then
				arg_123_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_126_13 = arg_123_1.actors_["1156ui_story"]
			local var_126_14 = 0

			if var_126_14 < arg_123_1.time_ and arg_123_1.time_ <= var_126_14 + arg_126_0 and not isNil(var_126_13) and arg_123_1.var_.characterEffect1156ui_story == nil then
				arg_123_1.var_.characterEffect1156ui_story = var_126_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_15 = 0.200000002980232

			if var_126_14 <= arg_123_1.time_ and arg_123_1.time_ < var_126_14 + var_126_15 and not isNil(var_126_13) then
				local var_126_16 = (arg_123_1.time_ - var_126_14) / var_126_15

				if arg_123_1.var_.characterEffect1156ui_story and not isNil(var_126_13) then
					local var_126_17 = Mathf.Lerp(0, 0.5, var_126_16)

					arg_123_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1156ui_story.fillRatio = var_126_17
				end
			end

			if arg_123_1.time_ >= var_126_14 + var_126_15 and arg_123_1.time_ < var_126_14 + var_126_15 + arg_126_0 and not isNil(var_126_13) and arg_123_1.var_.characterEffect1156ui_story then
				local var_126_18 = 0.5

				arg_123_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1156ui_story.fillRatio = var_126_18
			end

			local var_126_19 = 0

			if var_126_19 < arg_123_1.time_ and arg_123_1.time_ <= var_126_19 + arg_126_0 then
				arg_123_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_126_20 = 0

			if var_126_20 < arg_123_1.time_ and arg_123_1.time_ <= var_126_20 + arg_126_0 then
				arg_123_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_126_21 = 0
			local var_126_22 = 0.65

			if var_126_21 < arg_123_1.time_ and arg_123_1.time_ <= var_126_21 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_23 = arg_123_1:FormatText(StoryNameCfg[6].name)

				arg_123_1.leftNameTxt_.text = var_126_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_24 = arg_123_1:GetWordFromCfg(322031029)
				local var_126_25 = arg_123_1:FormatText(var_126_24.content)

				arg_123_1.text_.text = var_126_25

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_26 = 26
				local var_126_27 = utf8.len(var_126_25)
				local var_126_28 = var_126_26 <= 0 and var_126_22 or var_126_22 * (var_126_27 / var_126_26)

				if var_126_28 > 0 and var_126_22 < var_126_28 then
					arg_123_1.talkMaxDuration = var_126_28

					if var_126_28 + var_126_21 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_28 + var_126_21
					end
				end

				arg_123_1.text_.text = var_126_25
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031029", "story_v_out_322031.awb") ~= 0 then
					local var_126_29 = manager.audio:GetVoiceLength("story_v_out_322031", "322031029", "story_v_out_322031.awb") / 1000

					if var_126_29 + var_126_21 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_29 + var_126_21
					end

					if var_126_24.prefab_name ~= "" and arg_123_1.actors_[var_126_24.prefab_name] ~= nil then
						local var_126_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_24.prefab_name].transform, "story_v_out_322031", "322031029", "story_v_out_322031.awb")

						arg_123_1:RecordAudio("322031029", var_126_30)
						arg_123_1:RecordAudio("322031029", var_126_30)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_322031", "322031029", "story_v_out_322031.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_322031", "322031029", "story_v_out_322031.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_31 = math.max(var_126_22, arg_123_1.talkMaxDuration)

			if var_126_21 <= arg_123_1.time_ and arg_123_1.time_ < var_126_21 + var_126_31 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_21) / var_126_31

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_21 + var_126_31 and arg_123_1.time_ < var_126_21 + var_126_31 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play322031030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 322031030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play322031031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1284ui_story"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos1284ui_story = var_130_0.localPosition
			end

			local var_130_2 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2
				local var_130_4 = Vector3.New(0, 100, 0)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1284ui_story, var_130_4, var_130_3)

				local var_130_5 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_5.x, var_130_5.y, var_130_5.z)

				local var_130_6 = var_130_0.localEulerAngles

				var_130_6.z = 0
				var_130_6.x = 0
				var_130_0.localEulerAngles = var_130_6
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0, 100, 0)

				local var_130_7 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_7.x, var_130_7.y, var_130_7.z)

				local var_130_8 = var_130_0.localEulerAngles

				var_130_8.z = 0
				var_130_8.x = 0
				var_130_0.localEulerAngles = var_130_8
			end

			local var_130_9 = arg_127_1.actors_["1156ui_story"].transform
			local var_130_10 = 0

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 then
				arg_127_1.var_.moveOldPos1156ui_story = var_130_9.localPosition
			end

			local var_130_11 = 0.001

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_11 then
				local var_130_12 = (arg_127_1.time_ - var_130_10) / var_130_11
				local var_130_13 = Vector3.New(0, 100, 0)

				var_130_9.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1156ui_story, var_130_13, var_130_12)

				local var_130_14 = manager.ui.mainCamera.transform.position - var_130_9.position

				var_130_9.forward = Vector3.New(var_130_14.x, var_130_14.y, var_130_14.z)

				local var_130_15 = var_130_9.localEulerAngles

				var_130_15.z = 0
				var_130_15.x = 0
				var_130_9.localEulerAngles = var_130_15
			end

			if arg_127_1.time_ >= var_130_10 + var_130_11 and arg_127_1.time_ < var_130_10 + var_130_11 + arg_130_0 then
				var_130_9.localPosition = Vector3.New(0, 100, 0)

				local var_130_16 = manager.ui.mainCamera.transform.position - var_130_9.position

				var_130_9.forward = Vector3.New(var_130_16.x, var_130_16.y, var_130_16.z)

				local var_130_17 = var_130_9.localEulerAngles

				var_130_17.z = 0
				var_130_17.x = 0
				var_130_9.localEulerAngles = var_130_17
			end

			local var_130_18 = 0.104003701359034
			local var_130_19 = 1

			if var_130_18 < arg_127_1.time_ and arg_127_1.time_ <= var_130_18 + arg_130_0 then
				local var_130_20 = "play"
				local var_130_21 = "effect"

				arg_127_1:AudioAction(var_130_20, var_130_21, "se_story_140", "se_story_140_data01", "")
			end

			local var_130_22 = 0
			local var_130_23 = 1.375

			if var_130_22 < arg_127_1.time_ and arg_127_1.time_ <= var_130_22 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_24 = arg_127_1:GetWordFromCfg(322031030)
				local var_130_25 = arg_127_1:FormatText(var_130_24.content)

				arg_127_1.text_.text = var_130_25

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_26 = 55
				local var_130_27 = utf8.len(var_130_25)
				local var_130_28 = var_130_26 <= 0 and var_130_23 or var_130_23 * (var_130_27 / var_130_26)

				if var_130_28 > 0 and var_130_23 < var_130_28 then
					arg_127_1.talkMaxDuration = var_130_28

					if var_130_28 + var_130_22 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_28 + var_130_22
					end
				end

				arg_127_1.text_.text = var_130_25
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_29 = math.max(var_130_23, arg_127_1.talkMaxDuration)

			if var_130_22 <= arg_127_1.time_ and arg_127_1.time_ < var_130_22 + var_130_29 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_22) / var_130_29

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_22 + var_130_29 and arg_127_1.time_ < var_130_22 + var_130_29 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play322031031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 322031031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play322031032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.45

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(322031031)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 18
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play322031032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 322031032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play322031033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.2
			local var_138_1 = 1

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				local var_138_2 = "play"
				local var_138_3 = "effect"

				arg_135_1:AudioAction(var_138_2, var_138_3, "se_story_139", "se_story_139_thunderskill", "")
			end

			local var_138_4 = manager.ui.mainCamera.transform
			local var_138_5 = 0.2

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				local var_138_6 = arg_135_1.var_.effect1032
				local var_138_7
				local var_138_8 = var_138_4

				if not var_138_6 then
					var_138_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_138_8)
					var_138_6.name = "1032"
					arg_135_1.var_.effect1032 = var_138_6
				else
					var_138_6.transform:SetParent(var_138_8)
				end

				var_138_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_138_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_138_9 = manager.ui.mainCamera.transform
			local var_138_10 = 1.33333333333333

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				local var_138_11 = arg_135_1.var_.effect1032

				if var_138_11 then
					Object.Destroy(var_138_11)

					arg_135_1.var_.effect1032 = nil
				end
			end

			local var_138_12 = 0
			local var_138_13 = 1.325

			if var_138_12 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_14 = arg_135_1:GetWordFromCfg(322031032)
				local var_138_15 = arg_135_1:FormatText(var_138_14.content)

				arg_135_1.text_.text = var_138_15

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_16 = 53
				local var_138_17 = utf8.len(var_138_15)
				local var_138_18 = var_138_16 <= 0 and var_138_13 or var_138_13 * (var_138_17 / var_138_16)

				if var_138_18 > 0 and var_138_13 < var_138_18 then
					arg_135_1.talkMaxDuration = var_138_18

					if var_138_18 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_18 + var_138_12
					end
				end

				arg_135_1.text_.text = var_138_15
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_19 = math.max(var_138_13, arg_135_1.talkMaxDuration)

			if var_138_12 <= arg_135_1.time_ and arg_135_1.time_ < var_138_12 + var_138_19 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_12) / var_138_19

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_12 + var_138_19 and arg_135_1.time_ < var_138_12 + var_138_19 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play322031033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 322031033
		arg_139_1.duration_ = 1.87

		local var_139_0 = {
			zh = 1.866,
			ja = 1.366
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
				arg_139_0:Play322031034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = manager.ui.mainCamera.transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.shakeOldPos = var_142_0.localPosition
			end

			local var_142_2 = 0.333333333333333

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / 0.066
				local var_142_4, var_142_5 = math.modf(var_142_3)

				var_142_0.localPosition = Vector3.New(var_142_5 * 0.13, var_142_5 * 0.13, var_142_5 * 0.13) + arg_139_1.var_.shakeOldPos
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = arg_139_1.var_.shakeOldPos
			end

			local var_142_6 = 0
			local var_142_7 = 0.15

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_8 = arg_139_1:FormatText(StoryNameCfg[605].name)

				arg_139_1.leftNameTxt_.text = var_142_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_9 = arg_139_1:GetWordFromCfg(322031033)
				local var_142_10 = arg_139_1:FormatText(var_142_9.content)

				arg_139_1.text_.text = var_142_10

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 6
				local var_142_12 = utf8.len(var_142_10)
				local var_142_13 = var_142_11 <= 0 and var_142_7 or var_142_7 * (var_142_12 / var_142_11)

				if var_142_13 > 0 and var_142_7 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_10
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031033", "story_v_out_322031.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_322031", "322031033", "story_v_out_322031.awb") / 1000

					if var_142_14 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_6
					end

					if var_142_9.prefab_name ~= "" and arg_139_1.actors_[var_142_9.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_9.prefab_name].transform, "story_v_out_322031", "322031033", "story_v_out_322031.awb")

						arg_139_1:RecordAudio("322031033", var_142_15)
						arg_139_1:RecordAudio("322031033", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_322031", "322031033", "story_v_out_322031.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_322031", "322031033", "story_v_out_322031.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_16 and arg_139_1.time_ < var_142_6 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play322031034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 322031034
		arg_143_1.duration_ = 6.1

		local var_143_0 = {
			zh = 4.9,
			ja = 6.1
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
				arg_143_0:Play322031035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.35

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[1021].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10100")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(322031034)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 14
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031034", "story_v_out_322031.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_322031", "322031034", "story_v_out_322031.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_322031", "322031034", "story_v_out_322031.awb")

						arg_143_1:RecordAudio("322031034", var_146_9)
						arg_143_1:RecordAudio("322031034", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_322031", "322031034", "story_v_out_322031.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_322031", "322031034", "story_v_out_322031.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_10 and arg_143_1.time_ < var_146_0 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play322031035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 322031035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play322031036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 1.775

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:GetWordFromCfg(322031035)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 71
				local var_150_5 = utf8.len(var_150_3)
				local var_150_6 = var_150_4 <= 0 and var_150_1 or var_150_1 * (var_150_5 / var_150_4)

				if var_150_6 > 0 and var_150_1 < var_150_6 then
					arg_147_1.talkMaxDuration = var_150_6

					if var_150_6 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_7 and arg_147_1.time_ < var_150_0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play322031036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 322031036
		arg_151_1.duration_ = 3.2

		local var_151_0 = {
			zh = 2.666,
			ja = 3.2
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
				arg_151_0:Play322031037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1284ui_story"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos1284ui_story = var_154_0.localPosition
			end

			local var_154_2 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(0, -0.985, -6.22)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1284ui_story, var_154_4, var_154_3)

				local var_154_5 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_5.x, var_154_5.y, var_154_5.z)

				local var_154_6 = var_154_0.localEulerAngles

				var_154_6.z = 0
				var_154_6.x = 0
				var_154_0.localEulerAngles = var_154_6
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_154_7 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_7.x, var_154_7.y, var_154_7.z)

				local var_154_8 = var_154_0.localEulerAngles

				var_154_8.z = 0
				var_154_8.x = 0
				var_154_0.localEulerAngles = var_154_8
			end

			local var_154_9 = arg_151_1.actors_["1284ui_story"]
			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect1284ui_story == nil then
				arg_151_1.var_.characterEffect1284ui_story = var_154_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_11 = 0.200000002980232

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_11 and not isNil(var_154_9) then
				local var_154_12 = (arg_151_1.time_ - var_154_10) / var_154_11

				if arg_151_1.var_.characterEffect1284ui_story and not isNil(var_154_9) then
					arg_151_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_10 + var_154_11 and arg_151_1.time_ < var_154_10 + var_154_11 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect1284ui_story then
				arg_151_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_154_13 = 0

			if var_154_13 < arg_151_1.time_ and arg_151_1.time_ <= var_154_13 + arg_154_0 then
				arg_151_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action8_1")
			end

			local var_154_14 = 0

			if var_154_14 < arg_151_1.time_ and arg_151_1.time_ <= var_154_14 + arg_154_0 then
				arg_151_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_154_15 = manager.ui.mainCamera.transform
			local var_154_16 = 0

			if var_154_16 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 then
				local var_154_17 = arg_151_1.var_.effect1035

				if var_154_17 then
					Object.Destroy(var_154_17)

					arg_151_1.var_.effect1035 = nil
				end
			end

			local var_154_18 = manager.ui.mainCamera.transform
			local var_154_19 = 0

			if var_154_19 < arg_151_1.time_ and arg_151_1.time_ <= var_154_19 + arg_154_0 then
				local var_154_20 = arg_151_1.var_.effect10351

				if var_154_20 then
					Object.Destroy(var_154_20)

					arg_151_1.var_.effect10351 = nil
				end
			end

			local var_154_21 = 0
			local var_154_22 = 0.4

			if var_154_21 < arg_151_1.time_ and arg_151_1.time_ <= var_154_21 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_23 = arg_151_1:FormatText(StoryNameCfg[6].name)

				arg_151_1.leftNameTxt_.text = var_154_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_24 = arg_151_1:GetWordFromCfg(322031036)
				local var_154_25 = arg_151_1:FormatText(var_154_24.content)

				arg_151_1.text_.text = var_154_25

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_26 = 16
				local var_154_27 = utf8.len(var_154_25)
				local var_154_28 = var_154_26 <= 0 and var_154_22 or var_154_22 * (var_154_27 / var_154_26)

				if var_154_28 > 0 and var_154_22 < var_154_28 then
					arg_151_1.talkMaxDuration = var_154_28

					if var_154_28 + var_154_21 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_28 + var_154_21
					end
				end

				arg_151_1.text_.text = var_154_25
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031036", "story_v_out_322031.awb") ~= 0 then
					local var_154_29 = manager.audio:GetVoiceLength("story_v_out_322031", "322031036", "story_v_out_322031.awb") / 1000

					if var_154_29 + var_154_21 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_29 + var_154_21
					end

					if var_154_24.prefab_name ~= "" and arg_151_1.actors_[var_154_24.prefab_name] ~= nil then
						local var_154_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_24.prefab_name].transform, "story_v_out_322031", "322031036", "story_v_out_322031.awb")

						arg_151_1:RecordAudio("322031036", var_154_30)
						arg_151_1:RecordAudio("322031036", var_154_30)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_322031", "322031036", "story_v_out_322031.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_322031", "322031036", "story_v_out_322031.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_31 = math.max(var_154_22, arg_151_1.talkMaxDuration)

			if var_154_21 <= arg_151_1.time_ and arg_151_1.time_ < var_154_21 + var_154_31 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_21) / var_154_31

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_21 + var_154_31 and arg_151_1.time_ < var_154_21 + var_154_31 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
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

		arg_151_1:InitPlayNodeList()
	end,
	Play322031037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 322031037
		arg_155_1.duration_ = 6.93

		local var_155_0 = {
			zh = 6.766,
			ja = 6.933
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
				arg_155_0:Play322031038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1284ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos1284ui_story = var_158_0.localPosition
			end

			local var_158_2 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(0, 100, 0)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1284ui_story, var_158_4, var_158_3)

				local var_158_5 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_5.x, var_158_5.y, var_158_5.z)

				local var_158_6 = var_158_0.localEulerAngles

				var_158_6.z = 0
				var_158_6.x = 0
				var_158_0.localEulerAngles = var_158_6
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, 100, 0)

				local var_158_7 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_7.x, var_158_7.y, var_158_7.z)

				local var_158_8 = var_158_0.localEulerAngles

				var_158_8.z = 0
				var_158_8.x = 0
				var_158_0.localEulerAngles = var_158_8
			end

			local var_158_9 = 0
			local var_158_10 = 0.325

			if var_158_9 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_11 = arg_155_1:FormatText(StoryNameCfg[1021].name)

				arg_155_1.leftNameTxt_.text = var_158_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10100")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_12 = arg_155_1:GetWordFromCfg(322031037)
				local var_158_13 = arg_155_1:FormatText(var_158_12.content)

				arg_155_1.text_.text = var_158_13

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_14 = 13
				local var_158_15 = utf8.len(var_158_13)
				local var_158_16 = var_158_14 <= 0 and var_158_10 or var_158_10 * (var_158_15 / var_158_14)

				if var_158_16 > 0 and var_158_10 < var_158_16 then
					arg_155_1.talkMaxDuration = var_158_16

					if var_158_16 + var_158_9 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_16 + var_158_9
					end
				end

				arg_155_1.text_.text = var_158_13
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031037", "story_v_out_322031.awb") ~= 0 then
					local var_158_17 = manager.audio:GetVoiceLength("story_v_out_322031", "322031037", "story_v_out_322031.awb") / 1000

					if var_158_17 + var_158_9 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_17 + var_158_9
					end

					if var_158_12.prefab_name ~= "" and arg_155_1.actors_[var_158_12.prefab_name] ~= nil then
						local var_158_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_12.prefab_name].transform, "story_v_out_322031", "322031037", "story_v_out_322031.awb")

						arg_155_1:RecordAudio("322031037", var_158_18)
						arg_155_1:RecordAudio("322031037", var_158_18)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_322031", "322031037", "story_v_out_322031.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_322031", "322031037", "story_v_out_322031.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_19 = math.max(var_158_10, arg_155_1.talkMaxDuration)

			if var_158_9 <= arg_155_1.time_ and arg_155_1.time_ < var_158_9 + var_158_19 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_9) / var_158_19

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_9 + var_158_19 and arg_155_1.time_ < var_158_9 + var_158_19 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play322031038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 322031038
		arg_159_1.duration_ = 7.5

		local var_159_0 = {
			zh = 5.9,
			ja = 7.5
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
				arg_159_0:Play322031039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1156ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos1156ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(0, -1.1, -6.18)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1156ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = arg_159_1.actors_["1284ui_story"].transform
			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 then
				arg_159_1.var_.moveOldPos1284ui_story = var_162_9.localPosition
			end

			local var_162_11 = 0.001

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_11 then
				local var_162_12 = (arg_159_1.time_ - var_162_10) / var_162_11
				local var_162_13 = Vector3.New(0, 100, 0)

				var_162_9.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1284ui_story, var_162_13, var_162_12)

				local var_162_14 = manager.ui.mainCamera.transform.position - var_162_9.position

				var_162_9.forward = Vector3.New(var_162_14.x, var_162_14.y, var_162_14.z)

				local var_162_15 = var_162_9.localEulerAngles

				var_162_15.z = 0
				var_162_15.x = 0
				var_162_9.localEulerAngles = var_162_15
			end

			if arg_159_1.time_ >= var_162_10 + var_162_11 and arg_159_1.time_ < var_162_10 + var_162_11 + arg_162_0 then
				var_162_9.localPosition = Vector3.New(0, 100, 0)

				local var_162_16 = manager.ui.mainCamera.transform.position - var_162_9.position

				var_162_9.forward = Vector3.New(var_162_16.x, var_162_16.y, var_162_16.z)

				local var_162_17 = var_162_9.localEulerAngles

				var_162_17.z = 0
				var_162_17.x = 0
				var_162_9.localEulerAngles = var_162_17
			end

			local var_162_18 = arg_159_1.actors_["1156ui_story"]
			local var_162_19 = 0

			if var_162_19 < arg_159_1.time_ and arg_159_1.time_ <= var_162_19 + arg_162_0 and not isNil(var_162_18) and arg_159_1.var_.characterEffect1156ui_story == nil then
				arg_159_1.var_.characterEffect1156ui_story = var_162_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_20 = 0.200000002980232

			if var_162_19 <= arg_159_1.time_ and arg_159_1.time_ < var_162_19 + var_162_20 and not isNil(var_162_18) then
				local var_162_21 = (arg_159_1.time_ - var_162_19) / var_162_20

				if arg_159_1.var_.characterEffect1156ui_story and not isNil(var_162_18) then
					arg_159_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_19 + var_162_20 and arg_159_1.time_ < var_162_19 + var_162_20 + arg_162_0 and not isNil(var_162_18) and arg_159_1.var_.characterEffect1156ui_story then
				arg_159_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_162_22 = "10100ui_story"

			if arg_159_1.actors_[var_162_22] == nil then
				local var_162_23 = Asset.Load("Char/" .. "10100ui_story")

				if not isNil(var_162_23) then
					local var_162_24 = Object.Instantiate(Asset.Load("Char/" .. "10100ui_story"), arg_159_1.stage_.transform)

					var_162_24.name = var_162_22
					var_162_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_159_1.actors_[var_162_22] = var_162_24

					local var_162_25 = var_162_24:GetComponentInChildren(typeof(CharacterEffect))

					var_162_25.enabled = true

					local var_162_26 = GameObjectTools.GetOrAddComponent(var_162_24, typeof(DynamicBoneHelper))

					if var_162_26 then
						var_162_26:EnableDynamicBone(false)
					end

					arg_159_1:ShowWeapon(var_162_25.transform, false)

					arg_159_1.var_[var_162_22 .. "Animator"] = var_162_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_159_1.var_[var_162_22 .. "Animator"].applyRootMotion = true
					arg_159_1.var_[var_162_22 .. "LipSync"] = var_162_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_162_27 = arg_159_1.actors_["10100ui_story"]
			local var_162_28 = 0

			if var_162_28 < arg_159_1.time_ and arg_159_1.time_ <= var_162_28 + arg_162_0 and not isNil(var_162_27) and arg_159_1.var_.characterEffect10100ui_story == nil then
				arg_159_1.var_.characterEffect10100ui_story = var_162_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_29 = 0.200000002980232

			if var_162_28 <= arg_159_1.time_ and arg_159_1.time_ < var_162_28 + var_162_29 and not isNil(var_162_27) then
				local var_162_30 = (arg_159_1.time_ - var_162_28) / var_162_29

				if arg_159_1.var_.characterEffect10100ui_story and not isNil(var_162_27) then
					local var_162_31 = Mathf.Lerp(0, 0.5, var_162_30)

					arg_159_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10100ui_story.fillRatio = var_162_31
				end
			end

			if arg_159_1.time_ >= var_162_28 + var_162_29 and arg_159_1.time_ < var_162_28 + var_162_29 + arg_162_0 and not isNil(var_162_27) and arg_159_1.var_.characterEffect10100ui_story then
				local var_162_32 = 0.5

				arg_159_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10100ui_story.fillRatio = var_162_32
			end

			local var_162_33 = 0

			if var_162_33 < arg_159_1.time_ and arg_159_1.time_ <= var_162_33 + arg_162_0 then
				arg_159_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_162_34 = 0

			if var_162_34 < arg_159_1.time_ and arg_159_1.time_ <= var_162_34 + arg_162_0 then
				arg_159_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_162_35 = 0
			local var_162_36 = 0.775

			if var_162_35 < arg_159_1.time_ and arg_159_1.time_ <= var_162_35 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_37 = arg_159_1:FormatText(StoryNameCfg[605].name)

				arg_159_1.leftNameTxt_.text = var_162_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_38 = arg_159_1:GetWordFromCfg(322031038)
				local var_162_39 = arg_159_1:FormatText(var_162_38.content)

				arg_159_1.text_.text = var_162_39

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_40 = 31
				local var_162_41 = utf8.len(var_162_39)
				local var_162_42 = var_162_40 <= 0 and var_162_36 or var_162_36 * (var_162_41 / var_162_40)

				if var_162_42 > 0 and var_162_36 < var_162_42 then
					arg_159_1.talkMaxDuration = var_162_42

					if var_162_42 + var_162_35 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_42 + var_162_35
					end
				end

				arg_159_1.text_.text = var_162_39
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031038", "story_v_out_322031.awb") ~= 0 then
					local var_162_43 = manager.audio:GetVoiceLength("story_v_out_322031", "322031038", "story_v_out_322031.awb") / 1000

					if var_162_43 + var_162_35 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_43 + var_162_35
					end

					if var_162_38.prefab_name ~= "" and arg_159_1.actors_[var_162_38.prefab_name] ~= nil then
						local var_162_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_38.prefab_name].transform, "story_v_out_322031", "322031038", "story_v_out_322031.awb")

						arg_159_1:RecordAudio("322031038", var_162_44)
						arg_159_1:RecordAudio("322031038", var_162_44)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_322031", "322031038", "story_v_out_322031.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_322031", "322031038", "story_v_out_322031.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_45 = math.max(var_162_36, arg_159_1.talkMaxDuration)

			if var_162_35 <= arg_159_1.time_ and arg_159_1.time_ < var_162_35 + var_162_45 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_35) / var_162_45

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_35 + var_162_45 and arg_159_1.time_ < var_162_35 + var_162_45 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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

		arg_159_1:InitPlayNodeList()
	end,
	Play322031039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 322031039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play322031040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1156ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1156ui_story == nil then
				arg_163_1.var_.characterEffect1156ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1156ui_story and not isNil(var_166_0) then
					local var_166_4 = Mathf.Lerp(0, 0.5, var_166_3)

					arg_163_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1156ui_story.fillRatio = var_166_4
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1156ui_story then
				local var_166_5 = 0.5

				arg_163_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1156ui_story.fillRatio = var_166_5
			end

			local var_166_6 = 0
			local var_166_7 = 0.125

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_8 = arg_163_1:FormatText(StoryNameCfg[7].name)

				arg_163_1.leftNameTxt_.text = var_166_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_9 = arg_163_1:GetWordFromCfg(322031039)
				local var_166_10 = arg_163_1:FormatText(var_166_9.content)

				arg_163_1.text_.text = var_166_10

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 5
				local var_166_12 = utf8.len(var_166_10)
				local var_166_13 = var_166_11 <= 0 and var_166_7 or var_166_7 * (var_166_12 / var_166_11)

				if var_166_13 > 0 and var_166_7 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_10
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_14 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_14 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_14

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_14 and arg_163_1.time_ < var_166_6 + var_166_14 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play322031040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 322031040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play322031041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1156ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos1156ui_story = var_170_0.localPosition
			end

			local var_170_2 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2
				local var_170_4 = Vector3.New(0, 100, 0)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1156ui_story, var_170_4, var_170_3)

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

			local var_170_9 = arg_167_1.actors_["10100ui_story"].transform
			local var_170_10 = 0

			if var_170_10 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 then
				arg_167_1.var_.moveOldPos10100ui_story = var_170_9.localPosition
			end

			local var_170_11 = 0.001

			if var_170_10 <= arg_167_1.time_ and arg_167_1.time_ < var_170_10 + var_170_11 then
				local var_170_12 = (arg_167_1.time_ - var_170_10) / var_170_11
				local var_170_13 = Vector3.New(0, 100, 0)

				var_170_9.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10100ui_story, var_170_13, var_170_12)

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

			local var_170_18 = 0
			local var_170_19 = 1.425

			if var_170_18 < arg_167_1.time_ and arg_167_1.time_ <= var_170_18 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_20 = arg_167_1:GetWordFromCfg(322031040)
				local var_170_21 = arg_167_1:FormatText(var_170_20.content)

				arg_167_1.text_.text = var_170_21

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_22 = 57
				local var_170_23 = utf8.len(var_170_21)
				local var_170_24 = var_170_22 <= 0 and var_170_19 or var_170_19 * (var_170_23 / var_170_22)

				if var_170_24 > 0 and var_170_19 < var_170_24 then
					arg_167_1.talkMaxDuration = var_170_24

					if var_170_24 + var_170_18 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_24 + var_170_18
					end
				end

				arg_167_1.text_.text = var_170_21
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_25 = math.max(var_170_19, arg_167_1.talkMaxDuration)

			if var_170_18 <= arg_167_1.time_ and arg_167_1.time_ < var_170_18 + var_170_25 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_18) / var_170_25

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_18 + var_170_25 and arg_167_1.time_ < var_170_18 + var_170_25 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play322031041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 322031041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play322031042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.133333333333333
			local var_174_1 = 1

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				local var_174_2 = "play"
				local var_174_3 = "effect"

				arg_171_1:AudioAction(var_174_2, var_174_3, "se_story_140", "se_story_140_foley_hug", "")
			end

			local var_174_4 = manager.ui.mainCamera.transform
			local var_174_5 = 0.133333333333333

			if var_174_5 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.var_.shakeOldPos = var_174_4.localPosition
			end

			local var_174_6 = 0.333333333333333

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_6 then
				local var_174_7 = (arg_171_1.time_ - var_174_5) / 0.132
				local var_174_8, var_174_9 = math.modf(var_174_7)

				var_174_4.localPosition = Vector3.New(var_174_9 * 0.13, var_174_9 * 0.13, var_174_9 * 0.13) + arg_171_1.var_.shakeOldPos
			end

			if arg_171_1.time_ >= var_174_5 + var_174_6 and arg_171_1.time_ < var_174_5 + var_174_6 + arg_174_0 then
				var_174_4.localPosition = arg_171_1.var_.shakeOldPos
			end

			local var_174_10 = 0
			local var_174_11 = 1.375

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_12 = arg_171_1:GetWordFromCfg(322031041)
				local var_174_13 = arg_171_1:FormatText(var_174_12.content)

				arg_171_1.text_.text = var_174_13

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_14 = 55
				local var_174_15 = utf8.len(var_174_13)
				local var_174_16 = var_174_14 <= 0 and var_174_11 or var_174_11 * (var_174_15 / var_174_14)

				if var_174_16 > 0 and var_174_11 < var_174_16 then
					arg_171_1.talkMaxDuration = var_174_16

					if var_174_16 + var_174_10 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_16 + var_174_10
					end
				end

				arg_171_1.text_.text = var_174_13
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_17 = math.max(var_174_11, arg_171_1.talkMaxDuration)

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_17 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_10) / var_174_17

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_10 + var_174_17 and arg_171_1.time_ < var_174_10 + var_174_17 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play322031042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 322031042
		arg_175_1.duration_ = 2

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play322031043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1284ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1284ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(0, -0.985, -6.22)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1284ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["1284ui_story"]
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect1284ui_story == nil then
				arg_175_1.var_.characterEffect1284ui_story = var_178_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_11 = 0.200000002980232

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_11 and not isNil(var_178_9) then
				local var_178_12 = (arg_175_1.time_ - var_178_10) / var_178_11

				if arg_175_1.var_.characterEffect1284ui_story and not isNil(var_178_9) then
					arg_175_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_10 + var_178_11 and arg_175_1.time_ < var_178_10 + var_178_11 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect1284ui_story then
				arg_175_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_178_13 = 0

			if var_178_13 < arg_175_1.time_ and arg_175_1.time_ <= var_178_13 + arg_178_0 then
				arg_175_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			local var_178_14 = 0

			if var_178_14 < arg_175_1.time_ and arg_175_1.time_ <= var_178_14 + arg_178_0 then
				arg_175_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_178_15 = 0
			local var_178_16 = 0.1

			if var_178_15 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_17 = arg_175_1:FormatText(StoryNameCfg[6].name)

				arg_175_1.leftNameTxt_.text = var_178_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_18 = arg_175_1:GetWordFromCfg(322031042)
				local var_178_19 = arg_175_1:FormatText(var_178_18.content)

				arg_175_1.text_.text = var_178_19

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_20 = 4
				local var_178_21 = utf8.len(var_178_19)
				local var_178_22 = var_178_20 <= 0 and var_178_16 or var_178_16 * (var_178_21 / var_178_20)

				if var_178_22 > 0 and var_178_16 < var_178_22 then
					arg_175_1.talkMaxDuration = var_178_22

					if var_178_22 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_22 + var_178_15
					end
				end

				arg_175_1.text_.text = var_178_19
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031042", "story_v_out_322031.awb") ~= 0 then
					local var_178_23 = manager.audio:GetVoiceLength("story_v_out_322031", "322031042", "story_v_out_322031.awb") / 1000

					if var_178_23 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_23 + var_178_15
					end

					if var_178_18.prefab_name ~= "" and arg_175_1.actors_[var_178_18.prefab_name] ~= nil then
						local var_178_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_18.prefab_name].transform, "story_v_out_322031", "322031042", "story_v_out_322031.awb")

						arg_175_1:RecordAudio("322031042", var_178_24)
						arg_175_1:RecordAudio("322031042", var_178_24)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_322031", "322031042", "story_v_out_322031.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_322031", "322031042", "story_v_out_322031.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_25 = math.max(var_178_16, arg_175_1.talkMaxDuration)

			if var_178_15 <= arg_175_1.time_ and arg_175_1.time_ < var_178_15 + var_178_25 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_15) / var_178_25

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_15 + var_178_25 and arg_175_1.time_ < var_178_15 + var_178_25 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play322031043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 322031043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play322031044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1284ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1284ui_story == nil then
				arg_179_1.var_.characterEffect1284ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect1284ui_story and not isNil(var_182_0) then
					local var_182_4 = Mathf.Lerp(0, 0.5, var_182_3)

					arg_179_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1284ui_story.fillRatio = var_182_4
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1284ui_story then
				local var_182_5 = 0.5

				arg_179_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1284ui_story.fillRatio = var_182_5
			end

			local var_182_6 = 0
			local var_182_7 = 0.05

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

				local var_182_9 = arg_179_1:GetWordFromCfg(322031043)
				local var_182_10 = arg_179_1:FormatText(var_182_9.content)

				arg_179_1.text_.text = var_182_10

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_11 = 2
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
	Play322031044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 322031044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play322031045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1284ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos1284ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(0, 100, 0)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1284ui_story, var_186_4, var_186_3)

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

				local var_186_11 = arg_183_1:GetWordFromCfg(322031044)
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
				actorName = "1284ui_story",
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
	Play322031045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 322031045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play322031046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.7

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_2 = arg_187_1:GetWordFromCfg(322031045)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 28
				local var_190_5 = utf8.len(var_190_3)
				local var_190_6 = var_190_4 <= 0 and var_190_1 or var_190_1 * (var_190_5 / var_190_4)

				if var_190_6 > 0 and var_190_1 < var_190_6 then
					arg_187_1.talkMaxDuration = var_190_6

					if var_190_6 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_7 and arg_187_1.time_ < var_190_0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play322031046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 322031046
		arg_191_1.duration_ = 8.47

		local var_191_0 = {
			zh = 8.474999999999,
			ja = 6.407999999999
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
				arg_191_0:Play322031047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 2.00000000298023

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				local var_194_1 = manager.ui.mainCamera.transform.localPosition
				local var_194_2 = Vector3.New(0, 0, 10) + Vector3.New(var_194_1.x, var_194_1.y, 0)
				local var_194_3 = arg_191_1.bgs_.ST0511a

				var_194_3.transform.localPosition = var_194_2
				var_194_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_194_4 = var_194_3:GetComponent("SpriteRenderer")

				if var_194_4 and var_194_4.sprite then
					local var_194_5 = (var_194_3.transform.localPosition - var_194_1).z
					local var_194_6 = manager.ui.mainCameraCom_
					local var_194_7 = 2 * var_194_5 * Mathf.Tan(var_194_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_194_8 = var_194_7 * var_194_6.aspect
					local var_194_9 = var_194_4.sprite.bounds.size.x
					local var_194_10 = var_194_4.sprite.bounds.size.y
					local var_194_11 = var_194_8 / var_194_9
					local var_194_12 = var_194_7 / var_194_10
					local var_194_13 = var_194_12 < var_194_11 and var_194_11 or var_194_12

					var_194_3.transform.localScale = Vector3.New(var_194_13, var_194_13, 0)
				end

				for iter_194_0, iter_194_1 in pairs(arg_191_1.bgs_) do
					if iter_194_0 ~= "ST0511a" then
						iter_194_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_194_14 = 3.999999999999

			if var_194_14 < arg_191_1.time_ and arg_191_1.time_ <= var_194_14 + arg_194_0 then
				arg_191_1.allBtn_.enabled = false
			end

			local var_194_15 = 0.3

			if arg_191_1.time_ >= var_194_14 + var_194_15 and arg_191_1.time_ < var_194_14 + var_194_15 + arg_194_0 then
				arg_191_1.allBtn_.enabled = true
			end

			local var_194_16 = 0

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_17 = 2

			if var_194_16 <= arg_191_1.time_ and arg_191_1.time_ < var_194_16 + var_194_17 then
				local var_194_18 = (arg_191_1.time_ - var_194_16) / var_194_17
				local var_194_19 = Color.New(0, 0, 0)

				var_194_19.a = Mathf.Lerp(0, 1, var_194_18)
				arg_191_1.mask_.color = var_194_19
			end

			if arg_191_1.time_ >= var_194_16 + var_194_17 and arg_191_1.time_ < var_194_16 + var_194_17 + arg_194_0 then
				local var_194_20 = Color.New(0, 0, 0)

				var_194_20.a = 1
				arg_191_1.mask_.color = var_194_20
			end

			local var_194_21 = 2

			if var_194_21 < arg_191_1.time_ and arg_191_1.time_ <= var_194_21 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_22 = 2

			if var_194_21 <= arg_191_1.time_ and arg_191_1.time_ < var_194_21 + var_194_22 then
				local var_194_23 = (arg_191_1.time_ - var_194_21) / var_194_22
				local var_194_24 = Color.New(0, 0, 0)

				var_194_24.a = Mathf.Lerp(1, 0, var_194_23)
				arg_191_1.mask_.color = var_194_24
			end

			if arg_191_1.time_ >= var_194_21 + var_194_22 and arg_191_1.time_ < var_194_21 + var_194_22 + arg_194_0 then
				local var_194_25 = Color.New(0, 0, 0)
				local var_194_26 = 0

				arg_191_1.mask_.enabled = false
				var_194_25.a = var_194_26
				arg_191_1.mask_.color = var_194_25
			end

			local var_194_27 = arg_191_1.actors_["10100ui_story"].transform
			local var_194_28 = 3.8

			if var_194_28 < arg_191_1.time_ and arg_191_1.time_ <= var_194_28 + arg_194_0 then
				arg_191_1.var_.moveOldPos10100ui_story = var_194_27.localPosition
			end

			local var_194_29 = 0.001

			if var_194_28 <= arg_191_1.time_ and arg_191_1.time_ < var_194_28 + var_194_29 then
				local var_194_30 = (arg_191_1.time_ - var_194_28) / var_194_29
				local var_194_31 = Vector3.New(0, -1.16, -6.25)

				var_194_27.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10100ui_story, var_194_31, var_194_30)

				local var_194_32 = manager.ui.mainCamera.transform.position - var_194_27.position

				var_194_27.forward = Vector3.New(var_194_32.x, var_194_32.y, var_194_32.z)

				local var_194_33 = var_194_27.localEulerAngles

				var_194_33.z = 0
				var_194_33.x = 0
				var_194_27.localEulerAngles = var_194_33
			end

			if arg_191_1.time_ >= var_194_28 + var_194_29 and arg_191_1.time_ < var_194_28 + var_194_29 + arg_194_0 then
				var_194_27.localPosition = Vector3.New(0, -1.16, -6.25)

				local var_194_34 = manager.ui.mainCamera.transform.position - var_194_27.position

				var_194_27.forward = Vector3.New(var_194_34.x, var_194_34.y, var_194_34.z)

				local var_194_35 = var_194_27.localEulerAngles

				var_194_35.z = 0
				var_194_35.x = 0
				var_194_27.localEulerAngles = var_194_35
			end

			local var_194_36 = arg_191_1.actors_["10100ui_story"]
			local var_194_37 = 3.8

			if var_194_37 < arg_191_1.time_ and arg_191_1.time_ <= var_194_37 + arg_194_0 and not isNil(var_194_36) and arg_191_1.var_.characterEffect10100ui_story == nil then
				arg_191_1.var_.characterEffect10100ui_story = var_194_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_38 = 0.200000002980232

			if var_194_37 <= arg_191_1.time_ and arg_191_1.time_ < var_194_37 + var_194_38 and not isNil(var_194_36) then
				local var_194_39 = (arg_191_1.time_ - var_194_37) / var_194_38

				if arg_191_1.var_.characterEffect10100ui_story and not isNil(var_194_36) then
					arg_191_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_37 + var_194_38 and arg_191_1.time_ < var_194_37 + var_194_38 + arg_194_0 and not isNil(var_194_36) and arg_191_1.var_.characterEffect10100ui_story then
				arg_191_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_194_40 = 3.8

			if var_194_40 < arg_191_1.time_ and arg_191_1.time_ <= var_194_40 + arg_194_0 then
				arg_191_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action6_1")
			end

			local var_194_41 = 3.8

			if var_194_41 < arg_191_1.time_ and arg_191_1.time_ <= var_194_41 + arg_194_0 then
				arg_191_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_194_42 = manager.ui.mainCamera.transform
			local var_194_43 = 2.00000000298023

			if var_194_43 < arg_191_1.time_ and arg_191_1.time_ <= var_194_43 + arg_194_0 then
				local var_194_44 = arg_191_1.var_.effect1046
				local var_194_45
				local var_194_46 = var_194_42

				if not var_194_44 then
					var_194_44 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_monitor"), var_194_46)
					var_194_44.name = "1046"
					arg_191_1.var_.effect1046 = var_194_44
				else
					var_194_44.transform:SetParent(var_194_46)
				end

				var_194_44.transform.localPosition = Vector3.New(0, 0, -3)
				var_194_44.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_194_47 = manager.ui.mainCameraCom_
				local var_194_48 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_194_47.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_194_49 = var_194_44.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_194_50 = 15
				local var_194_51 = 2 * var_194_50 * Mathf.Tan(var_194_47.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_194_47.aspect
				local var_194_52 = 1
				local var_194_53 = 1.7777777777777777

				if var_194_53 < var_194_47.aspect then
					var_194_52 = var_194_51 / (2 * var_194_50 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_194_53)
				end

				for iter_194_2, iter_194_3 in ipairs(var_194_49) do
					local var_194_54 = iter_194_3.transform.localScale

					iter_194_3.transform.localScale = Vector3.New(var_194_54.x / var_194_48 * var_194_52, var_194_54.y / var_194_48, var_194_54.z)
				end
			end

			local var_194_55 = manager.ui.mainCamera.transform
			local var_194_56 = 2.00000000298023

			if var_194_56 < arg_191_1.time_ and arg_191_1.time_ <= var_194_56 + arg_194_0 then
				local var_194_57 = arg_191_1.var_.effect10461
				local var_194_58
				local var_194_59 = var_194_55

				if not var_194_57 then
					var_194_57 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), var_194_59)
					var_194_57.name = "10461"
					arg_191_1.var_.effect10461 = var_194_57
				else
					var_194_57.transform:SetParent(var_194_59)
				end

				var_194_57.transform.localPosition = Vector3.New(0, 0, -6)
				var_194_57.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_194_60 = manager.ui.mainCameraCom_
				local var_194_61 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_194_60.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_194_62 = var_194_57.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_194_63 = 15
				local var_194_64 = 2 * var_194_63 * Mathf.Tan(var_194_60.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_194_60.aspect
				local var_194_65 = 1
				local var_194_66 = 1.7777777777777777

				if var_194_66 < var_194_60.aspect then
					var_194_65 = var_194_64 / (2 * var_194_63 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_194_66)
				end

				for iter_194_4, iter_194_5 in ipairs(var_194_62) do
					local var_194_67 = iter_194_5.transform.localScale

					iter_194_5.transform.localScale = Vector3.New(var_194_67.x / var_194_61 * var_194_65, var_194_67.y / var_194_61, var_194_67.z)
				end
			end

			local var_194_68 = 2

			arg_191_1.isInRecall_ = false

			if var_194_68 < arg_191_1.time_ and arg_191_1.time_ <= var_194_68 + arg_194_0 then
				arg_191_1.screenFilterGo_:SetActive(true)

				arg_191_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_blue.asset")

				for iter_194_6, iter_194_7 in pairs(arg_191_1.actors_) do
					local var_194_69 = iter_194_7:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_194_8, iter_194_9 in ipairs(var_194_69) do
						if iter_194_9.color.r > 0.51 then
							iter_194_9.color = Color.New(1, 1, 1)
						else
							iter_194_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_194_70 = 0.0166666666666667

			if var_194_68 <= arg_191_1.time_ and arg_191_1.time_ < var_194_68 + var_194_70 then
				local var_194_71 = (arg_191_1.time_ - var_194_68) / var_194_70

				arg_191_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_194_71)
			end

			if arg_191_1.time_ >= var_194_68 + var_194_70 and arg_191_1.time_ < var_194_68 + var_194_70 + arg_194_0 then
				arg_191_1.screenFilterEffect_.weight = 1
			end

			if arg_191_1.frameCnt_ <= 1 then
				arg_191_1.dialog_:SetActive(false)
			end

			local var_194_72 = 3.974999999999
			local var_194_73 = 0.325

			if var_194_72 < arg_191_1.time_ and arg_191_1.time_ <= var_194_72 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				arg_191_1.dialog_:SetActive(true)

				arg_191_1.dialogCg_.alpha = 0

				local var_194_74 = LeanTween.value(arg_191_1.dialog_, 0, 1, 0.3)

				var_194_74:setOnUpdate(LuaHelper.FloatAction(function(arg_195_0)
					arg_191_1.dialogCg_.alpha = arg_195_0
				end))
				var_194_74:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_191_1.dialog_)
					var_194_74:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_191_1.duration_ = arg_191_1.duration_ + 0.3

				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_75 = arg_191_1:FormatText(StoryNameCfg[1021].name)

				arg_191_1.leftNameTxt_.text = var_194_75

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_76 = arg_191_1:GetWordFromCfg(322031046)
				local var_194_77 = arg_191_1:FormatText(var_194_76.content)

				arg_191_1.text_.text = var_194_77

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_78 = 13
				local var_194_79 = utf8.len(var_194_77)
				local var_194_80 = var_194_78 <= 0 and var_194_73 or var_194_73 * (var_194_79 / var_194_78)

				if var_194_80 > 0 and var_194_73 < var_194_80 then
					arg_191_1.talkMaxDuration = var_194_80
					var_194_72 = var_194_72 + 0.3

					if var_194_80 + var_194_72 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_80 + var_194_72
					end
				end

				arg_191_1.text_.text = var_194_77
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031046", "story_v_out_322031.awb") ~= 0 then
					local var_194_81 = manager.audio:GetVoiceLength("story_v_out_322031", "322031046", "story_v_out_322031.awb") / 1000

					if var_194_81 + var_194_72 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_81 + var_194_72
					end

					if var_194_76.prefab_name ~= "" and arg_191_1.actors_[var_194_76.prefab_name] ~= nil then
						local var_194_82 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_76.prefab_name].transform, "story_v_out_322031", "322031046", "story_v_out_322031.awb")

						arg_191_1:RecordAudio("322031046", var_194_82)
						arg_191_1:RecordAudio("322031046", var_194_82)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_322031", "322031046", "story_v_out_322031.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_322031", "322031046", "story_v_out_322031.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_83 = var_194_72 + 0.3
			local var_194_84 = math.max(var_194_73, arg_191_1.talkMaxDuration)

			if var_194_83 <= arg_191_1.time_ and arg_191_1.time_ < var_194_83 + var_194_84 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_83) / var_194_84

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_83 + var_194_84 and arg_191_1.time_ < var_194_83 + var_194_84 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play322031047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 322031047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play322031048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10100ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos10100ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0, 100, 0)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10100ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, 100, 0)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["10100ui_story"]
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect10100ui_story == nil then
				arg_197_1.var_.characterEffect10100ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 and not isNil(var_200_9) then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11

				if arg_197_1.var_.characterEffect10100ui_story and not isNil(var_200_9) then
					local var_200_13 = Mathf.Lerp(0, 0.5, var_200_12)

					arg_197_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_197_1.var_.characterEffect10100ui_story.fillRatio = var_200_13
				end
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect10100ui_story then
				local var_200_14 = 0.5

				arg_197_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_197_1.var_.characterEffect10100ui_story.fillRatio = var_200_14
			end

			local var_200_15 = 0.1
			local var_200_16 = 1

			if var_200_15 < arg_197_1.time_ and arg_197_1.time_ <= var_200_15 + arg_200_0 then
				local var_200_17 = "play"
				local var_200_18 = "effect"

				arg_197_1:AudioAction(var_200_17, var_200_18, "se_story_1310", "se_story_1310_footstep01", "")
			end

			local var_200_19 = 0
			local var_200_20 = 0.8

			if var_200_19 < arg_197_1.time_ and arg_197_1.time_ <= var_200_19 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_21 = arg_197_1:GetWordFromCfg(322031047)
				local var_200_22 = arg_197_1:FormatText(var_200_21.content)

				arg_197_1.text_.text = var_200_22

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_23 = 32
				local var_200_24 = utf8.len(var_200_22)
				local var_200_25 = var_200_23 <= 0 and var_200_20 or var_200_20 * (var_200_24 / var_200_23)

				if var_200_25 > 0 and var_200_20 < var_200_25 then
					arg_197_1.talkMaxDuration = var_200_25

					if var_200_25 + var_200_19 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_25 + var_200_19
					end
				end

				arg_197_1.text_.text = var_200_22
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_26 = math.max(var_200_20, arg_197_1.talkMaxDuration)

			if var_200_19 <= arg_197_1.time_ and arg_197_1.time_ < var_200_19 + var_200_26 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_19) / var_200_26

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_19 + var_200_26 and arg_197_1.time_ < var_200_19 + var_200_26 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play322031048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 322031048
		arg_201_1.duration_ = 2

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play322031049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = "10150ui_story"

			if arg_201_1.actors_[var_204_0] == nil then
				local var_204_1 = Asset.Load("Char/" .. "10150ui_story")

				if not isNil(var_204_1) then
					local var_204_2 = Object.Instantiate(Asset.Load("Char/" .. "10150ui_story"), arg_201_1.stage_.transform)

					var_204_2.name = var_204_0
					var_204_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_201_1.actors_[var_204_0] = var_204_2

					local var_204_3 = var_204_2:GetComponentInChildren(typeof(CharacterEffect))

					var_204_3.enabled = true

					local var_204_4 = GameObjectTools.GetOrAddComponent(var_204_2, typeof(DynamicBoneHelper))

					if var_204_4 then
						var_204_4:EnableDynamicBone(false)
					end

					arg_201_1:ShowWeapon(var_204_3.transform, false)

					arg_201_1.var_[var_204_0 .. "Animator"] = var_204_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_201_1.var_[var_204_0 .. "Animator"].applyRootMotion = true
					arg_201_1.var_[var_204_0 .. "LipSync"] = var_204_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_204_5 = arg_201_1.actors_["10150ui_story"].transform
			local var_204_6 = 0

			if var_204_6 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.var_.moveOldPos10150ui_story = var_204_5.localPosition

				local var_204_7 = GameObjectTools.GetOrAddComponent(var_204_5.gameObject, typeof(DynamicBoneHelper))

				if var_204_7 then
					var_204_7:EnableDynamicBone(false)
				end
			end

			local var_204_8 = 0.001

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_8 then
				local var_204_9 = (arg_201_1.time_ - var_204_6) / var_204_8
				local var_204_10 = Vector3.New(-0.9, -1.73, -5.5)

				var_204_5.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10150ui_story, var_204_10, var_204_9)

				local var_204_11 = manager.ui.mainCamera.transform.position - var_204_5.position

				var_204_5.forward = Vector3.New(var_204_11.x, var_204_11.y, var_204_11.z)

				local var_204_12 = var_204_5.localEulerAngles

				var_204_12.z = 0
				var_204_12.x = 0
				var_204_5.localEulerAngles = var_204_12
			end

			if arg_201_1.time_ >= var_204_6 + var_204_8 and arg_201_1.time_ < var_204_6 + var_204_8 + arg_204_0 then
				var_204_5.localPosition = Vector3.New(-0.9, -1.73, -5.5)

				local var_204_13 = manager.ui.mainCamera.transform.position - var_204_5.position

				var_204_5.forward = Vector3.New(var_204_13.x, var_204_13.y, var_204_13.z)

				local var_204_14 = var_204_5.localEulerAngles

				var_204_14.z = 0
				var_204_14.x = 0
				var_204_5.localEulerAngles = var_204_14

				local var_204_15 = GameObjectTools.GetOrAddComponent(var_204_5.gameObject, typeof(DynamicBoneHelper))

				if var_204_15 then
					var_204_15:EnableDynamicBone(true)
				end
			end

			local var_204_16 = arg_201_1.actors_["10150ui_story"]
			local var_204_17 = 0

			if var_204_17 < arg_201_1.time_ and arg_201_1.time_ <= var_204_17 + arg_204_0 and not isNil(var_204_16) and arg_201_1.var_.characterEffect10150ui_story == nil then
				arg_201_1.var_.characterEffect10150ui_story = var_204_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_18 = 0.200000002980232

			if var_204_17 <= arg_201_1.time_ and arg_201_1.time_ < var_204_17 + var_204_18 and not isNil(var_204_16) then
				local var_204_19 = (arg_201_1.time_ - var_204_17) / var_204_18

				if arg_201_1.var_.characterEffect10150ui_story and not isNil(var_204_16) then
					arg_201_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_17 + var_204_18 and arg_201_1.time_ < var_204_17 + var_204_18 + arg_204_0 and not isNil(var_204_16) and arg_201_1.var_.characterEffect10150ui_story then
				arg_201_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_204_20 = 0

			if var_204_20 < arg_201_1.time_ and arg_201_1.time_ <= var_204_20 + arg_204_0 then
				arg_201_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			local var_204_21 = "1081ui_story"

			if arg_201_1.actors_[var_204_21] == nil then
				local var_204_22 = Asset.Load("Char/" .. "1081ui_story")

				if not isNil(var_204_22) then
					local var_204_23 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_201_1.stage_.transform)

					var_204_23.name = var_204_21
					var_204_23.transform.localPosition = Vector3.New(0, 100, 0)
					arg_201_1.actors_[var_204_21] = var_204_23

					local var_204_24 = var_204_23:GetComponentInChildren(typeof(CharacterEffect))

					var_204_24.enabled = true

					local var_204_25 = GameObjectTools.GetOrAddComponent(var_204_23, typeof(DynamicBoneHelper))

					if var_204_25 then
						var_204_25:EnableDynamicBone(false)
					end

					arg_201_1:ShowWeapon(var_204_24.transform, false)

					arg_201_1.var_[var_204_21 .. "Animator"] = var_204_24.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_201_1.var_[var_204_21 .. "Animator"].applyRootMotion = true
					arg_201_1.var_[var_204_21 .. "LipSync"] = var_204_24.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_204_26 = 0

			if var_204_26 < arg_201_1.time_ and arg_201_1.time_ <= var_204_26 + arg_204_0 then
				arg_201_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_204_27 = 0
			local var_204_28 = 0.075

			if var_204_27 < arg_201_1.time_ and arg_201_1.time_ <= var_204_27 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_29 = arg_201_1:FormatText(StoryNameCfg[1361].name)

				arg_201_1.leftNameTxt_.text = var_204_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_30 = arg_201_1:GetWordFromCfg(322031048)
				local var_204_31 = arg_201_1:FormatText(var_204_30.content)

				arg_201_1.text_.text = var_204_31

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_32 = 3
				local var_204_33 = utf8.len(var_204_31)
				local var_204_34 = var_204_32 <= 0 and var_204_28 or var_204_28 * (var_204_33 / var_204_32)

				if var_204_34 > 0 and var_204_28 < var_204_34 then
					arg_201_1.talkMaxDuration = var_204_34

					if var_204_34 + var_204_27 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_34 + var_204_27
					end
				end

				arg_201_1.text_.text = var_204_31
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031048", "story_v_out_322031.awb") ~= 0 then
					local var_204_35 = manager.audio:GetVoiceLength("story_v_out_322031", "322031048", "story_v_out_322031.awb") / 1000

					if var_204_35 + var_204_27 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_35 + var_204_27
					end

					if var_204_30.prefab_name ~= "" and arg_201_1.actors_[var_204_30.prefab_name] ~= nil then
						local var_204_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_30.prefab_name].transform, "story_v_out_322031", "322031048", "story_v_out_322031.awb")

						arg_201_1:RecordAudio("322031048", var_204_36)
						arg_201_1:RecordAudio("322031048", var_204_36)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_322031", "322031048", "story_v_out_322031.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_322031", "322031048", "story_v_out_322031.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_37 = math.max(var_204_28, arg_201_1.talkMaxDuration)

			if var_204_27 <= arg_201_1.time_ and arg_201_1.time_ < var_204_27 + var_204_37 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_27) / var_204_37

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_27 + var_204_37 and arg_201_1.time_ < var_204_27 + var_204_37 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play322031049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 322031049
		arg_205_1.duration_ = 4.2

		local var_205_0 = {
			zh = 3.066,
			ja = 4.2
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
				arg_205_0:Play322031050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10100ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos10100ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(0.7, -1.16, -6.25)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10100ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0.7, -1.16, -6.25)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = arg_205_1.actors_["10100ui_story"]
			local var_208_10 = 0

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect10100ui_story == nil then
				arg_205_1.var_.characterEffect10100ui_story = var_208_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_11 = 0.200000002980232

			if var_208_10 <= arg_205_1.time_ and arg_205_1.time_ < var_208_10 + var_208_11 and not isNil(var_208_9) then
				local var_208_12 = (arg_205_1.time_ - var_208_10) / var_208_11

				if arg_205_1.var_.characterEffect10100ui_story and not isNil(var_208_9) then
					arg_205_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_10 + var_208_11 and arg_205_1.time_ < var_208_10 + var_208_11 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect10100ui_story then
				arg_205_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_208_13 = arg_205_1.actors_["10150ui_story"]
			local var_208_14 = 0

			if var_208_14 < arg_205_1.time_ and arg_205_1.time_ <= var_208_14 + arg_208_0 and not isNil(var_208_13) and arg_205_1.var_.characterEffect10150ui_story == nil then
				arg_205_1.var_.characterEffect10150ui_story = var_208_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_15 = 0.200000002980232

			if var_208_14 <= arg_205_1.time_ and arg_205_1.time_ < var_208_14 + var_208_15 and not isNil(var_208_13) then
				local var_208_16 = (arg_205_1.time_ - var_208_14) / var_208_15

				if arg_205_1.var_.characterEffect10150ui_story and not isNil(var_208_13) then
					local var_208_17 = Mathf.Lerp(0, 0.5, var_208_16)

					arg_205_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_205_1.var_.characterEffect10150ui_story.fillRatio = var_208_17
				end
			end

			if arg_205_1.time_ >= var_208_14 + var_208_15 and arg_205_1.time_ < var_208_14 + var_208_15 + arg_208_0 and not isNil(var_208_13) and arg_205_1.var_.characterEffect10150ui_story then
				local var_208_18 = 0.5

				arg_205_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_205_1.var_.characterEffect10150ui_story.fillRatio = var_208_18
			end

			local var_208_19 = 0

			if var_208_19 < arg_205_1.time_ and arg_205_1.time_ <= var_208_19 + arg_208_0 then
				arg_205_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action6_2")
			end

			local var_208_20 = 0

			if var_208_20 < arg_205_1.time_ and arg_205_1.time_ <= var_208_20 + arg_208_0 then
				arg_205_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_208_21 = 0
			local var_208_22 = 0.225

			if var_208_21 < arg_205_1.time_ and arg_205_1.time_ <= var_208_21 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_23 = arg_205_1:FormatText(StoryNameCfg[1021].name)

				arg_205_1.leftNameTxt_.text = var_208_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_24 = arg_205_1:GetWordFromCfg(322031049)
				local var_208_25 = arg_205_1:FormatText(var_208_24.content)

				arg_205_1.text_.text = var_208_25

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_26 = 9
				local var_208_27 = utf8.len(var_208_25)
				local var_208_28 = var_208_26 <= 0 and var_208_22 or var_208_22 * (var_208_27 / var_208_26)

				if var_208_28 > 0 and var_208_22 < var_208_28 then
					arg_205_1.talkMaxDuration = var_208_28

					if var_208_28 + var_208_21 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_28 + var_208_21
					end
				end

				arg_205_1.text_.text = var_208_25
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031049", "story_v_out_322031.awb") ~= 0 then
					local var_208_29 = manager.audio:GetVoiceLength("story_v_out_322031", "322031049", "story_v_out_322031.awb") / 1000

					if var_208_29 + var_208_21 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_29 + var_208_21
					end

					if var_208_24.prefab_name ~= "" and arg_205_1.actors_[var_208_24.prefab_name] ~= nil then
						local var_208_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_24.prefab_name].transform, "story_v_out_322031", "322031049", "story_v_out_322031.awb")

						arg_205_1:RecordAudio("322031049", var_208_30)
						arg_205_1:RecordAudio("322031049", var_208_30)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_322031", "322031049", "story_v_out_322031.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_322031", "322031049", "story_v_out_322031.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_31 = math.max(var_208_22, arg_205_1.talkMaxDuration)

			if var_208_21 <= arg_205_1.time_ and arg_205_1.time_ < var_208_21 + var_208_31 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_21) / var_208_31

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_21 + var_208_31 and arg_205_1.time_ < var_208_21 + var_208_31 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play322031050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 322031050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play322031051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10100ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos10100ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(0, 100, 0)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10100ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, 100, 0)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = arg_209_1.actors_["10150ui_story"].transform
			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 then
				arg_209_1.var_.moveOldPos10150ui_story = var_212_9.localPosition

				local var_212_11 = GameObjectTools.GetOrAddComponent(var_212_9.gameObject, typeof(DynamicBoneHelper))

				if var_212_11 then
					var_212_11:EnableDynamicBone(false)
				end
			end

			local var_212_12 = 0.001

			if var_212_10 <= arg_209_1.time_ and arg_209_1.time_ < var_212_10 + var_212_12 then
				local var_212_13 = (arg_209_1.time_ - var_212_10) / var_212_12
				local var_212_14 = Vector3.New(0, 100, 0)

				var_212_9.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10150ui_story, var_212_14, var_212_13)

				local var_212_15 = manager.ui.mainCamera.transform.position - var_212_9.position

				var_212_9.forward = Vector3.New(var_212_15.x, var_212_15.y, var_212_15.z)

				local var_212_16 = var_212_9.localEulerAngles

				var_212_16.z = 0
				var_212_16.x = 0
				var_212_9.localEulerAngles = var_212_16
			end

			if arg_209_1.time_ >= var_212_10 + var_212_12 and arg_209_1.time_ < var_212_10 + var_212_12 + arg_212_0 then
				var_212_9.localPosition = Vector3.New(0, 100, 0)

				local var_212_17 = manager.ui.mainCamera.transform.position - var_212_9.position

				var_212_9.forward = Vector3.New(var_212_17.x, var_212_17.y, var_212_17.z)

				local var_212_18 = var_212_9.localEulerAngles

				var_212_18.z = 0
				var_212_18.x = 0
				var_212_9.localEulerAngles = var_212_18

				local var_212_19 = GameObjectTools.GetOrAddComponent(var_212_9.gameObject, typeof(DynamicBoneHelper))

				if var_212_19 then
					var_212_19:EnableDynamicBone(true)
				end
			end

			local var_212_20 = 0
			local var_212_21 = 1.325

			if var_212_20 < arg_209_1.time_ and arg_209_1.time_ <= var_212_20 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_22 = arg_209_1:GetWordFromCfg(322031050)
				local var_212_23 = arg_209_1:FormatText(var_212_22.content)

				arg_209_1.text_.text = var_212_23

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_24 = 53
				local var_212_25 = utf8.len(var_212_23)
				local var_212_26 = var_212_24 <= 0 and var_212_21 or var_212_21 * (var_212_25 / var_212_24)

				if var_212_26 > 0 and var_212_21 < var_212_26 then
					arg_209_1.talkMaxDuration = var_212_26

					if var_212_26 + var_212_20 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_26 + var_212_20
					end
				end

				arg_209_1.text_.text = var_212_23
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_27 = math.max(var_212_21, arg_209_1.talkMaxDuration)

			if var_212_20 <= arg_209_1.time_ and arg_209_1.time_ < var_212_20 + var_212_27 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_20) / var_212_27

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_20 + var_212_27 and arg_209_1.time_ < var_212_20 + var_212_27 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play322031051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 322031051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play322031052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.1
			local var_216_1 = 1

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				local var_216_2 = "play"
				local var_216_3 = "effect"

				arg_213_1:AudioAction(var_216_2, var_216_3, "se_story_side_1084", "se_story_1084_electric", "")
			end

			local var_216_4 = 0
			local var_216_5 = 0.775

			if var_216_4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(322031051)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_8 = 31
				local var_216_9 = utf8.len(var_216_7)
				local var_216_10 = var_216_8 <= 0 and var_216_5 or var_216_5 * (var_216_9 / var_216_8)

				if var_216_10 > 0 and var_216_5 < var_216_10 then
					arg_213_1.talkMaxDuration = var_216_10

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_11 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_11 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_11

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_11 and arg_213_1.time_ < var_216_4 + var_216_11 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play322031052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 322031052
		arg_217_1.duration_ = 2

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play322031053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10100ui_story"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos10100ui_story = var_220_0.localPosition
			end

			local var_220_2 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2
				local var_220_4 = Vector3.New(0, -1.16, -6.25)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10100ui_story, var_220_4, var_220_3)

				local var_220_5 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_5.x, var_220_5.y, var_220_5.z)

				local var_220_6 = var_220_0.localEulerAngles

				var_220_6.z = 0
				var_220_6.x = 0
				var_220_0.localEulerAngles = var_220_6
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(0, -1.16, -6.25)

				local var_220_7 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_7.x, var_220_7.y, var_220_7.z)

				local var_220_8 = var_220_0.localEulerAngles

				var_220_8.z = 0
				var_220_8.x = 0
				var_220_0.localEulerAngles = var_220_8
			end

			local var_220_9 = arg_217_1.actors_["10100ui_story"]
			local var_220_10 = 0

			if var_220_10 < arg_217_1.time_ and arg_217_1.time_ <= var_220_10 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect10100ui_story == nil then
				arg_217_1.var_.characterEffect10100ui_story = var_220_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_11 = 0.200000002980232

			if var_220_10 <= arg_217_1.time_ and arg_217_1.time_ < var_220_10 + var_220_11 and not isNil(var_220_9) then
				local var_220_12 = (arg_217_1.time_ - var_220_10) / var_220_11

				if arg_217_1.var_.characterEffect10100ui_story and not isNil(var_220_9) then
					arg_217_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_10 + var_220_11 and arg_217_1.time_ < var_220_10 + var_220_11 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect10100ui_story then
				arg_217_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_220_13 = 0

			if var_220_13 < arg_217_1.time_ and arg_217_1.time_ <= var_220_13 + arg_220_0 then
				arg_217_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_220_14 = 0

			if var_220_14 < arg_217_1.time_ and arg_217_1.time_ <= var_220_14 + arg_220_0 then
				arg_217_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_220_15 = 0
			local var_220_16 = 0.075

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_17 = arg_217_1:FormatText(StoryNameCfg[1021].name)

				arg_217_1.leftNameTxt_.text = var_220_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_18 = arg_217_1:GetWordFromCfg(322031052)
				local var_220_19 = arg_217_1:FormatText(var_220_18.content)

				arg_217_1.text_.text = var_220_19

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_20 = 3
				local var_220_21 = utf8.len(var_220_19)
				local var_220_22 = var_220_20 <= 0 and var_220_16 or var_220_16 * (var_220_21 / var_220_20)

				if var_220_22 > 0 and var_220_16 < var_220_22 then
					arg_217_1.talkMaxDuration = var_220_22

					if var_220_22 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_22 + var_220_15
					end
				end

				arg_217_1.text_.text = var_220_19
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031052", "story_v_out_322031.awb") ~= 0 then
					local var_220_23 = manager.audio:GetVoiceLength("story_v_out_322031", "322031052", "story_v_out_322031.awb") / 1000

					if var_220_23 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_15
					end

					if var_220_18.prefab_name ~= "" and arg_217_1.actors_[var_220_18.prefab_name] ~= nil then
						local var_220_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_18.prefab_name].transform, "story_v_out_322031", "322031052", "story_v_out_322031.awb")

						arg_217_1:RecordAudio("322031052", var_220_24)
						arg_217_1:RecordAudio("322031052", var_220_24)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_322031", "322031052", "story_v_out_322031.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_322031", "322031052", "story_v_out_322031.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_25 = math.max(var_220_16, arg_217_1.talkMaxDuration)

			if var_220_15 <= arg_217_1.time_ and arg_217_1.time_ < var_220_15 + var_220_25 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_15) / var_220_25

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_15 + var_220_25 and arg_217_1.time_ < var_220_15 + var_220_25 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play322031053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 322031053
		arg_221_1.duration_ = 2

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play322031054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10150ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10150ui_story = var_224_0.localPosition

				local var_224_2 = GameObjectTools.GetOrAddComponent(var_224_0.gameObject, typeof(DynamicBoneHelper))

				if var_224_2 then
					var_224_2:EnableDynamicBone(false)
				end
			end

			local var_224_3 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_3 then
				local var_224_4 = (arg_221_1.time_ - var_224_1) / var_224_3
				local var_224_5 = Vector3.New(0.9, -1.73, -5.5)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10150ui_story, var_224_5, var_224_4)

				local var_224_6 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_6.x, var_224_6.y, var_224_6.z)

				local var_224_7 = var_224_0.localEulerAngles

				var_224_7.z = 0
				var_224_7.x = 0
				var_224_0.localEulerAngles = var_224_7
			end

			if arg_221_1.time_ >= var_224_1 + var_224_3 and arg_221_1.time_ < var_224_1 + var_224_3 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0.9, -1.73, -5.5)

				local var_224_8 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_8.x, var_224_8.y, var_224_8.z)

				local var_224_9 = var_224_0.localEulerAngles

				var_224_9.z = 0
				var_224_9.x = 0
				var_224_0.localEulerAngles = var_224_9

				local var_224_10 = GameObjectTools.GetOrAddComponent(var_224_0.gameObject, typeof(DynamicBoneHelper))

				if var_224_10 then
					var_224_10:EnableDynamicBone(true)
				end
			end

			local var_224_11 = arg_221_1.actors_["10150ui_story"]
			local var_224_12 = 0

			if var_224_12 < arg_221_1.time_ and arg_221_1.time_ <= var_224_12 + arg_224_0 and not isNil(var_224_11) and arg_221_1.var_.characterEffect10150ui_story == nil then
				arg_221_1.var_.characterEffect10150ui_story = var_224_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_13 = 0.200000002980232

			if var_224_12 <= arg_221_1.time_ and arg_221_1.time_ < var_224_12 + var_224_13 and not isNil(var_224_11) then
				local var_224_14 = (arg_221_1.time_ - var_224_12) / var_224_13

				if arg_221_1.var_.characterEffect10150ui_story and not isNil(var_224_11) then
					arg_221_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_12 + var_224_13 and arg_221_1.time_ < var_224_12 + var_224_13 + arg_224_0 and not isNil(var_224_11) and arg_221_1.var_.characterEffect10150ui_story then
				arg_221_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_224_15 = arg_221_1.actors_["10100ui_story"]
			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.characterEffect10100ui_story == nil then
				arg_221_1.var_.characterEffect10100ui_story = var_224_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_17 = 0.200000002980232

			if var_224_16 <= arg_221_1.time_ and arg_221_1.time_ < var_224_16 + var_224_17 and not isNil(var_224_15) then
				local var_224_18 = (arg_221_1.time_ - var_224_16) / var_224_17

				if arg_221_1.var_.characterEffect10100ui_story and not isNil(var_224_15) then
					local var_224_19 = Mathf.Lerp(0, 0.5, var_224_18)

					arg_221_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_221_1.var_.characterEffect10100ui_story.fillRatio = var_224_19
				end
			end

			if arg_221_1.time_ >= var_224_16 + var_224_17 and arg_221_1.time_ < var_224_16 + var_224_17 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.characterEffect10100ui_story then
				local var_224_20 = 0.5

				arg_221_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_221_1.var_.characterEffect10100ui_story.fillRatio = var_224_20
			end

			local var_224_21 = 0

			if var_224_21 < arg_221_1.time_ and arg_221_1.time_ <= var_224_21 + arg_224_0 then
				arg_221_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_1")
			end

			local var_224_22 = 0

			if var_224_22 < arg_221_1.time_ and arg_221_1.time_ <= var_224_22 + arg_224_0 then
				arg_221_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_224_23 = arg_221_1.actors_["10100ui_story"].transform
			local var_224_24 = 0

			if var_224_24 < arg_221_1.time_ and arg_221_1.time_ <= var_224_24 + arg_224_0 then
				arg_221_1.var_.moveOldPos10100ui_story = var_224_23.localPosition
			end

			local var_224_25 = 0.001

			if var_224_24 <= arg_221_1.time_ and arg_221_1.time_ < var_224_24 + var_224_25 then
				local var_224_26 = (arg_221_1.time_ - var_224_24) / var_224_25
				local var_224_27 = Vector3.New(-0.7, -1.16, -6.25)

				var_224_23.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10100ui_story, var_224_27, var_224_26)

				local var_224_28 = manager.ui.mainCamera.transform.position - var_224_23.position

				var_224_23.forward = Vector3.New(var_224_28.x, var_224_28.y, var_224_28.z)

				local var_224_29 = var_224_23.localEulerAngles

				var_224_29.z = 0
				var_224_29.x = 0
				var_224_23.localEulerAngles = var_224_29
			end

			if arg_221_1.time_ >= var_224_24 + var_224_25 and arg_221_1.time_ < var_224_24 + var_224_25 + arg_224_0 then
				var_224_23.localPosition = Vector3.New(-0.7, -1.16, -6.25)

				local var_224_30 = manager.ui.mainCamera.transform.position - var_224_23.position

				var_224_23.forward = Vector3.New(var_224_30.x, var_224_30.y, var_224_30.z)

				local var_224_31 = var_224_23.localEulerAngles

				var_224_31.z = 0
				var_224_31.x = 0
				var_224_23.localEulerAngles = var_224_31
			end

			local var_224_32 = 0
			local var_224_33 = 0.075

			if var_224_32 < arg_221_1.time_ and arg_221_1.time_ <= var_224_32 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_34 = arg_221_1:FormatText(StoryNameCfg[1361].name)

				arg_221_1.leftNameTxt_.text = var_224_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_35 = arg_221_1:GetWordFromCfg(322031053)
				local var_224_36 = arg_221_1:FormatText(var_224_35.content)

				arg_221_1.text_.text = var_224_36

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_37 = 3
				local var_224_38 = utf8.len(var_224_36)
				local var_224_39 = var_224_37 <= 0 and var_224_33 or var_224_33 * (var_224_38 / var_224_37)

				if var_224_39 > 0 and var_224_33 < var_224_39 then
					arg_221_1.talkMaxDuration = var_224_39

					if var_224_39 + var_224_32 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_39 + var_224_32
					end
				end

				arg_221_1.text_.text = var_224_36
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031053", "story_v_out_322031.awb") ~= 0 then
					local var_224_40 = manager.audio:GetVoiceLength("story_v_out_322031", "322031053", "story_v_out_322031.awb") / 1000

					if var_224_40 + var_224_32 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_40 + var_224_32
					end

					if var_224_35.prefab_name ~= "" and arg_221_1.actors_[var_224_35.prefab_name] ~= nil then
						local var_224_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_35.prefab_name].transform, "story_v_out_322031", "322031053", "story_v_out_322031.awb")

						arg_221_1:RecordAudio("322031053", var_224_41)
						arg_221_1:RecordAudio("322031053", var_224_41)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_322031", "322031053", "story_v_out_322031.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_322031", "322031053", "story_v_out_322031.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_42 = math.max(var_224_33, arg_221_1.talkMaxDuration)

			if var_224_32 <= arg_221_1.time_ and arg_221_1.time_ < var_224_32 + var_224_42 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_32) / var_224_42

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_32 + var_224_42 and arg_221_1.time_ < var_224_32 + var_224_42 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play322031054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 322031054
		arg_225_1.duration_ = 8.2

		local var_225_0 = {
			zh = 8.2,
			ja = 8.133
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
				arg_225_0:Play322031055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10100ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos10100ui_story = var_228_0.localPosition
			end

			local var_228_2 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2
				local var_228_4 = Vector3.New(-0.7, -1.16, -6.25)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10100ui_story, var_228_4, var_228_3)

				local var_228_5 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_5.x, var_228_5.y, var_228_5.z)

				local var_228_6 = var_228_0.localEulerAngles

				var_228_6.z = 0
				var_228_6.x = 0
				var_228_0.localEulerAngles = var_228_6
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(-0.7, -1.16, -6.25)

				local var_228_7 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_7.x, var_228_7.y, var_228_7.z)

				local var_228_8 = var_228_0.localEulerAngles

				var_228_8.z = 0
				var_228_8.x = 0
				var_228_0.localEulerAngles = var_228_8
			end

			local var_228_9 = arg_225_1.actors_["10100ui_story"]
			local var_228_10 = 0

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect10100ui_story == nil then
				arg_225_1.var_.characterEffect10100ui_story = var_228_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_11 = 0.200000002980232

			if var_228_10 <= arg_225_1.time_ and arg_225_1.time_ < var_228_10 + var_228_11 and not isNil(var_228_9) then
				local var_228_12 = (arg_225_1.time_ - var_228_10) / var_228_11

				if arg_225_1.var_.characterEffect10100ui_story and not isNil(var_228_9) then
					arg_225_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_10 + var_228_11 and arg_225_1.time_ < var_228_10 + var_228_11 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect10100ui_story then
				arg_225_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_228_13 = arg_225_1.actors_["10150ui_story"]
			local var_228_14 = 0

			if var_228_14 < arg_225_1.time_ and arg_225_1.time_ <= var_228_14 + arg_228_0 and not isNil(var_228_13) and arg_225_1.var_.characterEffect10150ui_story == nil then
				arg_225_1.var_.characterEffect10150ui_story = var_228_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_15 = 0.200000002980232

			if var_228_14 <= arg_225_1.time_ and arg_225_1.time_ < var_228_14 + var_228_15 and not isNil(var_228_13) then
				local var_228_16 = (arg_225_1.time_ - var_228_14) / var_228_15

				if arg_225_1.var_.characterEffect10150ui_story and not isNil(var_228_13) then
					local var_228_17 = Mathf.Lerp(0, 0.5, var_228_16)

					arg_225_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10150ui_story.fillRatio = var_228_17
				end
			end

			if arg_225_1.time_ >= var_228_14 + var_228_15 and arg_225_1.time_ < var_228_14 + var_228_15 + arg_228_0 and not isNil(var_228_13) and arg_225_1.var_.characterEffect10150ui_story then
				local var_228_18 = 0.5

				arg_225_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10150ui_story.fillRatio = var_228_18
			end

			local var_228_19 = 0

			if var_228_19 < arg_225_1.time_ and arg_225_1.time_ <= var_228_19 + arg_228_0 then
				arg_225_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action5_1")
			end

			local var_228_20 = 0

			if var_228_20 < arg_225_1.time_ and arg_225_1.time_ <= var_228_20 + arg_228_0 then
				arg_225_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_228_21 = 0
			local var_228_22 = 0.775

			if var_228_21 < arg_225_1.time_ and arg_225_1.time_ <= var_228_21 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_23 = arg_225_1:FormatText(StoryNameCfg[1021].name)

				arg_225_1.leftNameTxt_.text = var_228_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_24 = arg_225_1:GetWordFromCfg(322031054)
				local var_228_25 = arg_225_1:FormatText(var_228_24.content)

				arg_225_1.text_.text = var_228_25

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_26 = 31
				local var_228_27 = utf8.len(var_228_25)
				local var_228_28 = var_228_26 <= 0 and var_228_22 or var_228_22 * (var_228_27 / var_228_26)

				if var_228_28 > 0 and var_228_22 < var_228_28 then
					arg_225_1.talkMaxDuration = var_228_28

					if var_228_28 + var_228_21 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_28 + var_228_21
					end
				end

				arg_225_1.text_.text = var_228_25
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031054", "story_v_out_322031.awb") ~= 0 then
					local var_228_29 = manager.audio:GetVoiceLength("story_v_out_322031", "322031054", "story_v_out_322031.awb") / 1000

					if var_228_29 + var_228_21 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_29 + var_228_21
					end

					if var_228_24.prefab_name ~= "" and arg_225_1.actors_[var_228_24.prefab_name] ~= nil then
						local var_228_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_24.prefab_name].transform, "story_v_out_322031", "322031054", "story_v_out_322031.awb")

						arg_225_1:RecordAudio("322031054", var_228_30)
						arg_225_1:RecordAudio("322031054", var_228_30)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_322031", "322031054", "story_v_out_322031.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_322031", "322031054", "story_v_out_322031.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_31 = math.max(var_228_22, arg_225_1.talkMaxDuration)

			if var_228_21 <= arg_225_1.time_ and arg_225_1.time_ < var_228_21 + var_228_31 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_21) / var_228_31

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_21 + var_228_31 and arg_225_1.time_ < var_228_21 + var_228_31 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play322031055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 322031055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play322031056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10100ui_story"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos10100ui_story = var_232_0.localPosition
			end

			local var_232_2 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2
				local var_232_4 = Vector3.New(0, 100, 0)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10100ui_story, var_232_4, var_232_3)

				local var_232_5 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_5.x, var_232_5.y, var_232_5.z)

				local var_232_6 = var_232_0.localEulerAngles

				var_232_6.z = 0
				var_232_6.x = 0
				var_232_0.localEulerAngles = var_232_6
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(0, 100, 0)

				local var_232_7 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_7.x, var_232_7.y, var_232_7.z)

				local var_232_8 = var_232_0.localEulerAngles

				var_232_8.z = 0
				var_232_8.x = 0
				var_232_0.localEulerAngles = var_232_8
			end

			local var_232_9 = arg_229_1.actors_["10150ui_story"].transform
			local var_232_10 = 0

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 then
				arg_229_1.var_.moveOldPos10150ui_story = var_232_9.localPosition

				local var_232_11 = GameObjectTools.GetOrAddComponent(var_232_9.gameObject, typeof(DynamicBoneHelper))

				if var_232_11 then
					var_232_11:EnableDynamicBone(false)
				end
			end

			local var_232_12 = 0.001

			if var_232_10 <= arg_229_1.time_ and arg_229_1.time_ < var_232_10 + var_232_12 then
				local var_232_13 = (arg_229_1.time_ - var_232_10) / var_232_12
				local var_232_14 = Vector3.New(0, 100, 0)

				var_232_9.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10150ui_story, var_232_14, var_232_13)

				local var_232_15 = manager.ui.mainCamera.transform.position - var_232_9.position

				var_232_9.forward = Vector3.New(var_232_15.x, var_232_15.y, var_232_15.z)

				local var_232_16 = var_232_9.localEulerAngles

				var_232_16.z = 0
				var_232_16.x = 0
				var_232_9.localEulerAngles = var_232_16
			end

			if arg_229_1.time_ >= var_232_10 + var_232_12 and arg_229_1.time_ < var_232_10 + var_232_12 + arg_232_0 then
				var_232_9.localPosition = Vector3.New(0, 100, 0)

				local var_232_17 = manager.ui.mainCamera.transform.position - var_232_9.position

				var_232_9.forward = Vector3.New(var_232_17.x, var_232_17.y, var_232_17.z)

				local var_232_18 = var_232_9.localEulerAngles

				var_232_18.z = 0
				var_232_18.x = 0
				var_232_9.localEulerAngles = var_232_18

				local var_232_19 = GameObjectTools.GetOrAddComponent(var_232_9.gameObject, typeof(DynamicBoneHelper))

				if var_232_19 then
					var_232_19:EnableDynamicBone(true)
				end
			end

			local var_232_20 = 0.1
			local var_232_21 = 1

			if var_232_20 < arg_229_1.time_ and arg_229_1.time_ <= var_232_20 + arg_232_0 then
				local var_232_22 = "play"
				local var_232_23 = "effect"

				arg_229_1:AudioAction(var_232_22, var_232_23, "se_story_145", "se_story_145_flame", "")
			end

			local var_232_24 = manager.ui.mainCamera.transform
			local var_232_25 = 0.1

			if var_232_25 < arg_229_1.time_ and arg_229_1.time_ <= var_232_25 + arg_232_0 then
				arg_229_1.var_.shakeOldPos = var_232_24.localPosition
			end

			local var_232_26 = 0.709093396645039

			if var_232_25 <= arg_229_1.time_ and arg_229_1.time_ < var_232_25 + var_232_26 then
				local var_232_27 = (arg_229_1.time_ - var_232_25) / 0.066
				local var_232_28, var_232_29 = math.modf(var_232_27)

				var_232_24.localPosition = Vector3.New(var_232_29 * 0.13, var_232_29 * 0.13, var_232_29 * 0.13) + arg_229_1.var_.shakeOldPos
			end

			if arg_229_1.time_ >= var_232_25 + var_232_26 and arg_229_1.time_ < var_232_25 + var_232_26 + arg_232_0 then
				var_232_24.localPosition = arg_229_1.var_.shakeOldPos
			end

			local var_232_30 = 0
			local var_232_31 = 1.825

			if var_232_30 < arg_229_1.time_ and arg_229_1.time_ <= var_232_30 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_32 = arg_229_1:GetWordFromCfg(322031055)
				local var_232_33 = arg_229_1:FormatText(var_232_32.content)

				arg_229_1.text_.text = var_232_33

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_34 = 73
				local var_232_35 = utf8.len(var_232_33)
				local var_232_36 = var_232_34 <= 0 and var_232_31 or var_232_31 * (var_232_35 / var_232_34)

				if var_232_36 > 0 and var_232_31 < var_232_36 then
					arg_229_1.talkMaxDuration = var_232_36

					if var_232_36 + var_232_30 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_36 + var_232_30
					end
				end

				arg_229_1.text_.text = var_232_33
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_37 = math.max(var_232_31, arg_229_1.talkMaxDuration)

			if var_232_30 <= arg_229_1.time_ and arg_229_1.time_ < var_232_30 + var_232_37 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_30) / var_232_37

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_30 + var_232_37 and arg_229_1.time_ < var_232_30 + var_232_37 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322031056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 322031056
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play322031057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.766666666666667
			local var_236_1 = 1

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				local var_236_2 = "play"
				local var_236_3 = "effect"

				arg_233_1:AudioAction(var_236_2, var_236_3, "se_story_121_04", "se_story_121_04_walk", "")
			end

			local var_236_4 = 0
			local var_236_5 = 1.125

			if var_236_4 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(322031056)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_8 = 45
				local var_236_9 = utf8.len(var_236_7)
				local var_236_10 = var_236_8 <= 0 and var_236_5 or var_236_5 * (var_236_9 / var_236_8)

				if var_236_10 > 0 and var_236_5 < var_236_10 then
					arg_233_1.talkMaxDuration = var_236_10

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_11 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_11 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_11

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_11 and arg_233_1.time_ < var_236_4 + var_236_11 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play322031057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 322031057
		arg_237_1.duration_ = 8.93

		local var_237_0 = {
			zh = 7.166,
			ja = 8.933
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
				arg_237_0:Play322031058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = "ST61a"

			if arg_237_1.bgs_[var_240_0] == nil then
				local var_240_1 = Object.Instantiate(arg_237_1.paintGo_)

				var_240_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_240_0)
				var_240_1.name = var_240_0
				var_240_1.transform.parent = arg_237_1.stage_.transform
				var_240_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.bgs_[var_240_0] = var_240_1
			end

			local var_240_2 = 2.00000000298023

			if var_240_2 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				local var_240_3 = manager.ui.mainCamera.transform.localPosition
				local var_240_4 = Vector3.New(0, 0, 10) + Vector3.New(var_240_3.x, var_240_3.y, 0)
				local var_240_5 = arg_237_1.bgs_.ST61a

				var_240_5.transform.localPosition = var_240_4
				var_240_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_240_6 = var_240_5:GetComponent("SpriteRenderer")

				if var_240_6 and var_240_6.sprite then
					local var_240_7 = (var_240_5.transform.localPosition - var_240_3).z
					local var_240_8 = manager.ui.mainCameraCom_
					local var_240_9 = 2 * var_240_7 * Mathf.Tan(var_240_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_240_10 = var_240_9 * var_240_8.aspect
					local var_240_11 = var_240_6.sprite.bounds.size.x
					local var_240_12 = var_240_6.sprite.bounds.size.y
					local var_240_13 = var_240_10 / var_240_11
					local var_240_14 = var_240_9 / var_240_12
					local var_240_15 = var_240_14 < var_240_13 and var_240_13 or var_240_14

					var_240_5.transform.localScale = Vector3.New(var_240_15, var_240_15, 0)
				end

				for iter_240_0, iter_240_1 in pairs(arg_237_1.bgs_) do
					if iter_240_0 ~= "ST61a" then
						iter_240_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_240_16 = 4

			if var_240_16 < arg_237_1.time_ and arg_237_1.time_ <= var_240_16 + arg_240_0 then
				arg_237_1.allBtn_.enabled = false
			end

			local var_240_17 = 0.3

			if arg_237_1.time_ >= var_240_16 + var_240_17 and arg_237_1.time_ < var_240_16 + var_240_17 + arg_240_0 then
				arg_237_1.allBtn_.enabled = true
			end

			local var_240_18 = 0

			if var_240_18 < arg_237_1.time_ and arg_237_1.time_ <= var_240_18 + arg_240_0 then
				arg_237_1.mask_.enabled = true
				arg_237_1.mask_.raycastTarget = true

				arg_237_1:SetGaussion(false)
			end

			local var_240_19 = 2

			if var_240_18 <= arg_237_1.time_ and arg_237_1.time_ < var_240_18 + var_240_19 then
				local var_240_20 = (arg_237_1.time_ - var_240_18) / var_240_19
				local var_240_21 = Color.New(0, 0, 0)

				var_240_21.a = Mathf.Lerp(0, 1, var_240_20)
				arg_237_1.mask_.color = var_240_21
			end

			if arg_237_1.time_ >= var_240_18 + var_240_19 and arg_237_1.time_ < var_240_18 + var_240_19 + arg_240_0 then
				local var_240_22 = Color.New(0, 0, 0)

				var_240_22.a = 1
				arg_237_1.mask_.color = var_240_22
			end

			local var_240_23 = 2

			if var_240_23 < arg_237_1.time_ and arg_237_1.time_ <= var_240_23 + arg_240_0 then
				arg_237_1.mask_.enabled = true
				arg_237_1.mask_.raycastTarget = true

				arg_237_1:SetGaussion(false)
			end

			local var_240_24 = 2

			if var_240_23 <= arg_237_1.time_ and arg_237_1.time_ < var_240_23 + var_240_24 then
				local var_240_25 = (arg_237_1.time_ - var_240_23) / var_240_24
				local var_240_26 = Color.New(0, 0, 0)

				var_240_26.a = Mathf.Lerp(1, 0, var_240_25)
				arg_237_1.mask_.color = var_240_26
			end

			if arg_237_1.time_ >= var_240_23 + var_240_24 and arg_237_1.time_ < var_240_23 + var_240_24 + arg_240_0 then
				local var_240_27 = Color.New(0, 0, 0)
				local var_240_28 = 0

				arg_237_1.mask_.enabled = false
				var_240_27.a = var_240_28
				arg_237_1.mask_.color = var_240_27
			end

			local var_240_29 = "1089ui_story"

			if arg_237_1.actors_[var_240_29] == nil then
				local var_240_30 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_240_30) then
					local var_240_31 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_237_1.stage_.transform)

					var_240_31.name = var_240_29
					var_240_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_237_1.actors_[var_240_29] = var_240_31

					local var_240_32 = var_240_31:GetComponentInChildren(typeof(CharacterEffect))

					var_240_32.enabled = true

					local var_240_33 = GameObjectTools.GetOrAddComponent(var_240_31, typeof(DynamicBoneHelper))

					if var_240_33 then
						var_240_33:EnableDynamicBone(false)
					end

					arg_237_1:ShowWeapon(var_240_32.transform, false)

					arg_237_1.var_[var_240_29 .. "Animator"] = var_240_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_237_1.var_[var_240_29 .. "Animator"].applyRootMotion = true
					arg_237_1.var_[var_240_29 .. "LipSync"] = var_240_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_240_34 = arg_237_1.actors_["1089ui_story"].transform
			local var_240_35 = 3.8

			if var_240_35 < arg_237_1.time_ and arg_237_1.time_ <= var_240_35 + arg_240_0 then
				arg_237_1.var_.moveOldPos1089ui_story = var_240_34.localPosition

				local var_240_36 = "1089ui_story"

				arg_237_1:ShowWeapon(arg_237_1.var_[var_240_36 .. "Animator"].transform, false)
			end

			local var_240_37 = 0.001

			if var_240_35 <= arg_237_1.time_ and arg_237_1.time_ < var_240_35 + var_240_37 then
				local var_240_38 = (arg_237_1.time_ - var_240_35) / var_240_37
				local var_240_39 = Vector3.New(0, -1.1, -6.17)

				var_240_34.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1089ui_story, var_240_39, var_240_38)

				local var_240_40 = manager.ui.mainCamera.transform.position - var_240_34.position

				var_240_34.forward = Vector3.New(var_240_40.x, var_240_40.y, var_240_40.z)

				local var_240_41 = var_240_34.localEulerAngles

				var_240_41.z = 0
				var_240_41.x = 0
				var_240_34.localEulerAngles = var_240_41
			end

			if arg_237_1.time_ >= var_240_35 + var_240_37 and arg_237_1.time_ < var_240_35 + var_240_37 + arg_240_0 then
				var_240_34.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_240_42 = manager.ui.mainCamera.transform.position - var_240_34.position

				var_240_34.forward = Vector3.New(var_240_42.x, var_240_42.y, var_240_42.z)

				local var_240_43 = var_240_34.localEulerAngles

				var_240_43.z = 0
				var_240_43.x = 0
				var_240_34.localEulerAngles = var_240_43
			end

			local var_240_44 = arg_237_1.actors_["1089ui_story"]
			local var_240_45 = 3.8

			if var_240_45 < arg_237_1.time_ and arg_237_1.time_ <= var_240_45 + arg_240_0 and not isNil(var_240_44) and arg_237_1.var_.characterEffect1089ui_story == nil then
				arg_237_1.var_.characterEffect1089ui_story = var_240_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_46 = 0.200000002980232

			if var_240_45 <= arg_237_1.time_ and arg_237_1.time_ < var_240_45 + var_240_46 and not isNil(var_240_44) then
				local var_240_47 = (arg_237_1.time_ - var_240_45) / var_240_46

				if arg_237_1.var_.characterEffect1089ui_story and not isNil(var_240_44) then
					arg_237_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_45 + var_240_46 and arg_237_1.time_ < var_240_45 + var_240_46 + arg_240_0 and not isNil(var_240_44) and arg_237_1.var_.characterEffect1089ui_story then
				arg_237_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_240_48 = 3.8

			if var_240_48 < arg_237_1.time_ and arg_237_1.time_ <= var_240_48 + arg_240_0 then
				arg_237_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_240_49 = 3.8

			if var_240_49 < arg_237_1.time_ and arg_237_1.time_ <= var_240_49 + arg_240_0 then
				arg_237_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_240_50 = 0
			local var_240_51 = 0.3

			if var_240_50 < arg_237_1.time_ and arg_237_1.time_ <= var_240_50 + arg_240_0 then
				local var_240_52 = "play"
				local var_240_53 = "music"

				arg_237_1:AudioAction(var_240_52, var_240_53, "ui_battle", "ui_battle_stopbgm", "")

				local var_240_54 = ""
				local var_240_55 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_240_55 ~= "" then
					if arg_237_1.bgmTxt_.text ~= var_240_55 and arg_237_1.bgmTxt_.text ~= "" then
						if arg_237_1.bgmTxt2_.text ~= "" then
							arg_237_1.bgmTxt_.text = arg_237_1.bgmTxt2_.text
						end

						arg_237_1.bgmTxt2_.text = var_240_55

						arg_237_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_237_1.bgmTxt_.text = var_240_55
						arg_237_1.bgmTxt2_.text = var_240_55
					end

					if arg_237_1.bgmTimer then
						arg_237_1.bgmTimer:Stop()

						arg_237_1.bgmTimer = nil
					end

					if arg_237_1.settingData.show_music_name == 1 then
						arg_237_1.musicController:SetSelectedState("show")
						arg_237_1.musicAnimator_:Play("open", 0, 0)

						if arg_237_1.settingData.music_time ~= 0 then
							arg_237_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_237_1.settingData.music_time), function()
								if arg_237_1 == nil or isNil(arg_237_1.bgmTxt_) then
									return
								end

								arg_237_1.musicController:SetSelectedState("hide")
								arg_237_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_240_56 = 0.433333333333333
			local var_240_57 = 1

			if var_240_56 < arg_237_1.time_ and arg_237_1.time_ <= var_240_56 + arg_240_0 then
				local var_240_58 = "play"
				local var_240_59 = "music"

				arg_237_1:AudioAction(var_240_58, var_240_59, "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_240_60 = ""
				local var_240_61 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

				if var_240_61 ~= "" then
					if arg_237_1.bgmTxt_.text ~= var_240_61 and arg_237_1.bgmTxt_.text ~= "" then
						if arg_237_1.bgmTxt2_.text ~= "" then
							arg_237_1.bgmTxt_.text = arg_237_1.bgmTxt2_.text
						end

						arg_237_1.bgmTxt2_.text = var_240_61

						arg_237_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_237_1.bgmTxt_.text = var_240_61
						arg_237_1.bgmTxt2_.text = var_240_61
					end

					if arg_237_1.bgmTimer then
						arg_237_1.bgmTimer:Stop()

						arg_237_1.bgmTimer = nil
					end

					if arg_237_1.settingData.show_music_name == 1 then
						arg_237_1.musicController:SetSelectedState("show")
						arg_237_1.musicAnimator_:Play("open", 0, 0)

						if arg_237_1.settingData.music_time ~= 0 then
							arg_237_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_237_1.settingData.music_time), function()
								if arg_237_1 == nil or isNil(arg_237_1.bgmTxt_) then
									return
								end

								arg_237_1.musicController:SetSelectedState("hide")
								arg_237_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_240_62 = 0.166666666666667
			local var_240_63 = 1

			if var_240_62 < arg_237_1.time_ and arg_237_1.time_ <= var_240_62 + arg_240_0 then
				local var_240_64 = "stop"
				local var_240_65 = "effect"

				arg_237_1:AudioAction(var_240_64, var_240_65, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_240_66 = 1.53333333333333
			local var_240_67 = 1

			if var_240_66 < arg_237_1.time_ and arg_237_1.time_ <= var_240_66 + arg_240_0 then
				local var_240_68 = "play"
				local var_240_69 = "effect"

				arg_237_1:AudioAction(var_240_68, var_240_69, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			local var_240_70 = manager.ui.mainCamera.transform
			local var_240_71 = 1.98333333631357

			if var_240_71 < arg_237_1.time_ and arg_237_1.time_ <= var_240_71 + arg_240_0 then
				local var_240_72 = arg_237_1.var_.effect1046

				if var_240_72 then
					Object.Destroy(var_240_72)

					arg_237_1.var_.effect1046 = nil
				end
			end

			local var_240_73 = manager.ui.mainCamera.transform
			local var_240_74 = 1.98333333631357

			if var_240_74 < arg_237_1.time_ and arg_237_1.time_ <= var_240_74 + arg_240_0 then
				local var_240_75 = arg_237_1.var_.effect10461

				if var_240_75 then
					Object.Destroy(var_240_75)

					arg_237_1.var_.effect10461 = nil
				end
			end

			local var_240_76 = 1.98333333631357

			arg_237_1.isInRecall_ = false

			if var_240_76 < arg_237_1.time_ and arg_237_1.time_ <= var_240_76 + arg_240_0 then
				arg_237_1.screenFilterGo_:SetActive(false)

				for iter_240_2, iter_240_3 in pairs(arg_237_1.actors_) do
					local var_240_77 = iter_240_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_240_4, iter_240_5 in ipairs(var_240_77) do
						if iter_240_5.color.r > 0.51 then
							iter_240_5.color = Color.New(1, 1, 1)
						else
							iter_240_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_240_78 = 0.0166666666666667

			if var_240_76 <= arg_237_1.time_ and arg_237_1.time_ < var_240_76 + var_240_78 then
				local var_240_79 = (arg_237_1.time_ - var_240_76) / var_240_78

				arg_237_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_240_79)
			end

			if arg_237_1.time_ >= var_240_76 + var_240_78 and arg_237_1.time_ < var_240_76 + var_240_78 + arg_240_0 then
				arg_237_1.screenFilterEffect_.weight = 0
			end

			if arg_237_1.frameCnt_ <= 1 then
				arg_237_1.dialog_:SetActive(false)
			end

			local var_240_80 = 4
			local var_240_81 = 0.35

			if var_240_80 < arg_237_1.time_ and arg_237_1.time_ <= var_240_80 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				arg_237_1.dialog_:SetActive(true)

				arg_237_1.dialogCg_.alpha = 0

				local var_240_82 = LeanTween.value(arg_237_1.dialog_, 0, 1, 0.3)

				var_240_82:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_237_1.dialogCg_.alpha = arg_243_0
				end))
				var_240_82:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_237_1.dialog_)
					var_240_82:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_237_1.duration_ = arg_237_1.duration_ + 0.3

				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_83 = arg_237_1:FormatText(StoryNameCfg[1031].name)

				arg_237_1.leftNameTxt_.text = var_240_83

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_84 = arg_237_1:GetWordFromCfg(322031057)
				local var_240_85 = arg_237_1:FormatText(var_240_84.content)

				arg_237_1.text_.text = var_240_85

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_86 = 14
				local var_240_87 = utf8.len(var_240_85)
				local var_240_88 = var_240_86 <= 0 and var_240_81 or var_240_81 * (var_240_87 / var_240_86)

				if var_240_88 > 0 and var_240_81 < var_240_88 then
					arg_237_1.talkMaxDuration = var_240_88
					var_240_80 = var_240_80 + 0.3

					if var_240_88 + var_240_80 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_88 + var_240_80
					end
				end

				arg_237_1.text_.text = var_240_85
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031057", "story_v_out_322031.awb") ~= 0 then
					local var_240_89 = manager.audio:GetVoiceLength("story_v_out_322031", "322031057", "story_v_out_322031.awb") / 1000

					if var_240_89 + var_240_80 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_89 + var_240_80
					end

					if var_240_84.prefab_name ~= "" and arg_237_1.actors_[var_240_84.prefab_name] ~= nil then
						local var_240_90 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_84.prefab_name].transform, "story_v_out_322031", "322031057", "story_v_out_322031.awb")

						arg_237_1:RecordAudio("322031057", var_240_90)
						arg_237_1:RecordAudio("322031057", var_240_90)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_322031", "322031057", "story_v_out_322031.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_322031", "322031057", "story_v_out_322031.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_91 = var_240_80 + 0.3
			local var_240_92 = math.max(var_240_81, arg_237_1.talkMaxDuration)

			if var_240_91 <= arg_237_1.time_ and arg_237_1.time_ < var_240_91 + var_240_92 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_91) / var_240_92

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_91 + var_240_92 and arg_237_1.time_ < var_240_91 + var_240_92 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play322031058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 322031058
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play322031059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1089ui_story"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos1089ui_story = var_248_0.localPosition
			end

			local var_248_2 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2
				local var_248_4 = Vector3.New(0, 100, 0)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1089ui_story, var_248_4, var_248_3)

				local var_248_5 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_5.x, var_248_5.y, var_248_5.z)

				local var_248_6 = var_248_0.localEulerAngles

				var_248_6.z = 0
				var_248_6.x = 0
				var_248_0.localEulerAngles = var_248_6
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(0, 100, 0)

				local var_248_7 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_7.x, var_248_7.y, var_248_7.z)

				local var_248_8 = var_248_0.localEulerAngles

				var_248_8.z = 0
				var_248_8.x = 0
				var_248_0.localEulerAngles = var_248_8
			end

			local var_248_9 = 0
			local var_248_10 = 1.7

			if var_248_9 < arg_245_1.time_ and arg_245_1.time_ <= var_248_9 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_11 = arg_245_1:GetWordFromCfg(322031058)
				local var_248_12 = arg_245_1:FormatText(var_248_11.content)

				arg_245_1.text_.text = var_248_12

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_13 = 68
				local var_248_14 = utf8.len(var_248_12)
				local var_248_15 = var_248_13 <= 0 and var_248_10 or var_248_10 * (var_248_14 / var_248_13)

				if var_248_15 > 0 and var_248_10 < var_248_15 then
					arg_245_1.talkMaxDuration = var_248_15

					if var_248_15 + var_248_9 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_15 + var_248_9
					end
				end

				arg_245_1.text_.text = var_248_12
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_16 = math.max(var_248_10, arg_245_1.talkMaxDuration)

			if var_248_9 <= arg_245_1.time_ and arg_245_1.time_ < var_248_9 + var_248_16 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_9) / var_248_16

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_9 + var_248_16 and arg_245_1.time_ < var_248_9 + var_248_16 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play322031059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 322031059
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play322031060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 1.6

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_2 = arg_249_1:GetWordFromCfg(322031059)
				local var_252_3 = arg_249_1:FormatText(var_252_2.content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 64
				local var_252_5 = utf8.len(var_252_3)
				local var_252_6 = var_252_4 <= 0 and var_252_1 or var_252_1 * (var_252_5 / var_252_4)

				if var_252_6 > 0 and var_252_1 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_7 and arg_249_1.time_ < var_252_0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play322031060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 322031060
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play322031061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.275

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[7].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(322031060)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 11
				local var_256_6 = utf8.len(var_256_4)
				local var_256_7 = var_256_5 <= 0 and var_256_1 or var_256_1 * (var_256_6 / var_256_5)

				if var_256_7 > 0 and var_256_1 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_8 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_8 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_8

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_8 and arg_253_1.time_ < var_256_0 + var_256_8 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play322031061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 322031061
		arg_257_1.duration_ = 5.87

		local var_257_0 = {
			zh = 3.833,
			ja = 5.866
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play322031062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1089ui_story"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos1089ui_story = var_260_0.localPosition
			end

			local var_260_2 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2
				local var_260_4 = Vector3.New(0, -1.1, -6.17)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1089ui_story, var_260_4, var_260_3)

				local var_260_5 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_5.x, var_260_5.y, var_260_5.z)

				local var_260_6 = var_260_0.localEulerAngles

				var_260_6.z = 0
				var_260_6.x = 0
				var_260_0.localEulerAngles = var_260_6
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_260_7 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_7.x, var_260_7.y, var_260_7.z)

				local var_260_8 = var_260_0.localEulerAngles

				var_260_8.z = 0
				var_260_8.x = 0
				var_260_0.localEulerAngles = var_260_8
			end

			local var_260_9 = arg_257_1.actors_["1089ui_story"]
			local var_260_10 = 0

			if var_260_10 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 and not isNil(var_260_9) and arg_257_1.var_.characterEffect1089ui_story == nil then
				arg_257_1.var_.characterEffect1089ui_story = var_260_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_11 = 0.200000002980232

			if var_260_10 <= arg_257_1.time_ and arg_257_1.time_ < var_260_10 + var_260_11 and not isNil(var_260_9) then
				local var_260_12 = (arg_257_1.time_ - var_260_10) / var_260_11

				if arg_257_1.var_.characterEffect1089ui_story and not isNil(var_260_9) then
					arg_257_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_10 + var_260_11 and arg_257_1.time_ < var_260_10 + var_260_11 + arg_260_0 and not isNil(var_260_9) and arg_257_1.var_.characterEffect1089ui_story then
				arg_257_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_260_13 = 0

			if var_260_13 < arg_257_1.time_ and arg_257_1.time_ <= var_260_13 + arg_260_0 then
				arg_257_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_260_14 = 0

			if var_260_14 < arg_257_1.time_ and arg_257_1.time_ <= var_260_14 + arg_260_0 then
				arg_257_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_260_15 = 0
			local var_260_16 = 0.4

			if var_260_15 < arg_257_1.time_ and arg_257_1.time_ <= var_260_15 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_17 = arg_257_1:FormatText(StoryNameCfg[1031].name)

				arg_257_1.leftNameTxt_.text = var_260_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_18 = arg_257_1:GetWordFromCfg(322031061)
				local var_260_19 = arg_257_1:FormatText(var_260_18.content)

				arg_257_1.text_.text = var_260_19

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_20 = 16
				local var_260_21 = utf8.len(var_260_19)
				local var_260_22 = var_260_20 <= 0 and var_260_16 or var_260_16 * (var_260_21 / var_260_20)

				if var_260_22 > 0 and var_260_16 < var_260_22 then
					arg_257_1.talkMaxDuration = var_260_22

					if var_260_22 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_22 + var_260_15
					end
				end

				arg_257_1.text_.text = var_260_19
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031061", "story_v_out_322031.awb") ~= 0 then
					local var_260_23 = manager.audio:GetVoiceLength("story_v_out_322031", "322031061", "story_v_out_322031.awb") / 1000

					if var_260_23 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_23 + var_260_15
					end

					if var_260_18.prefab_name ~= "" and arg_257_1.actors_[var_260_18.prefab_name] ~= nil then
						local var_260_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_18.prefab_name].transform, "story_v_out_322031", "322031061", "story_v_out_322031.awb")

						arg_257_1:RecordAudio("322031061", var_260_24)
						arg_257_1:RecordAudio("322031061", var_260_24)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_322031", "322031061", "story_v_out_322031.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_322031", "322031061", "story_v_out_322031.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_25 = math.max(var_260_16, arg_257_1.talkMaxDuration)

			if var_260_15 <= arg_257_1.time_ and arg_257_1.time_ < var_260_15 + var_260_25 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_15) / var_260_25

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_15 + var_260_25 and arg_257_1.time_ < var_260_15 + var_260_25 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play322031062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 322031062
		arg_261_1.duration_ = 5.33

		local var_261_0 = {
			zh = 3.5,
			ja = 5.333
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play322031063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1089ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1089ui_story = var_264_0.localPosition
			end

			local var_264_2 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2
				local var_264_4 = Vector3.New(0, -1.1, -6.17)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1089ui_story, var_264_4, var_264_3)

				local var_264_5 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_5.x, var_264_5.y, var_264_5.z)

				local var_264_6 = var_264_0.localEulerAngles

				var_264_6.z = 0
				var_264_6.x = 0
				var_264_0.localEulerAngles = var_264_6
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_264_7 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_7.x, var_264_7.y, var_264_7.z)

				local var_264_8 = var_264_0.localEulerAngles

				var_264_8.z = 0
				var_264_8.x = 0
				var_264_0.localEulerAngles = var_264_8
			end

			local var_264_9 = 0

			if var_264_9 < arg_261_1.time_ and arg_261_1.time_ <= var_264_9 + arg_264_0 then
				arg_261_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			local var_264_10 = 0

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 then
				arg_261_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_264_11 = 0
			local var_264_12 = 0.475

			if var_264_11 < arg_261_1.time_ and arg_261_1.time_ <= var_264_11 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_13 = arg_261_1:FormatText(StoryNameCfg[1031].name)

				arg_261_1.leftNameTxt_.text = var_264_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_14 = arg_261_1:GetWordFromCfg(322031062)
				local var_264_15 = arg_261_1:FormatText(var_264_14.content)

				arg_261_1.text_.text = var_264_15

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_16 = 19
				local var_264_17 = utf8.len(var_264_15)
				local var_264_18 = var_264_16 <= 0 and var_264_12 or var_264_12 * (var_264_17 / var_264_16)

				if var_264_18 > 0 and var_264_12 < var_264_18 then
					arg_261_1.talkMaxDuration = var_264_18

					if var_264_18 + var_264_11 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_18 + var_264_11
					end
				end

				arg_261_1.text_.text = var_264_15
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031062", "story_v_out_322031.awb") ~= 0 then
					local var_264_19 = manager.audio:GetVoiceLength("story_v_out_322031", "322031062", "story_v_out_322031.awb") / 1000

					if var_264_19 + var_264_11 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_19 + var_264_11
					end

					if var_264_14.prefab_name ~= "" and arg_261_1.actors_[var_264_14.prefab_name] ~= nil then
						local var_264_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_14.prefab_name].transform, "story_v_out_322031", "322031062", "story_v_out_322031.awb")

						arg_261_1:RecordAudio("322031062", var_264_20)
						arg_261_1:RecordAudio("322031062", var_264_20)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_322031", "322031062", "story_v_out_322031.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_322031", "322031062", "story_v_out_322031.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_21 = math.max(var_264_12, arg_261_1.talkMaxDuration)

			if var_264_11 <= arg_261_1.time_ and arg_261_1.time_ < var_264_11 + var_264_21 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_11) / var_264_21

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_11 + var_264_21 and arg_261_1.time_ < var_264_11 + var_264_21 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play322031063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 322031063
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play322031064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1089ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1089ui_story == nil then
				arg_265_1.var_.characterEffect1089ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1089ui_story and not isNil(var_268_0) then
					local var_268_4 = Mathf.Lerp(0, 0.5, var_268_3)

					arg_265_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1089ui_story.fillRatio = var_268_4
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1089ui_story then
				local var_268_5 = 0.5

				arg_265_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1089ui_story.fillRatio = var_268_5
			end

			local var_268_6 = 0
			local var_268_7 = 1.025

			if var_268_6 < arg_265_1.time_ and arg_265_1.time_ <= var_268_6 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_8 = arg_265_1:FormatText(StoryNameCfg[7].name)

				arg_265_1.leftNameTxt_.text = var_268_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_9 = arg_265_1:GetWordFromCfg(322031063)
				local var_268_10 = arg_265_1:FormatText(var_268_9.content)

				arg_265_1.text_.text = var_268_10

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_11 = 41
				local var_268_12 = utf8.len(var_268_10)
				local var_268_13 = var_268_11 <= 0 and var_268_7 or var_268_7 * (var_268_12 / var_268_11)

				if var_268_13 > 0 and var_268_7 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_6 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_6
					end
				end

				arg_265_1.text_.text = var_268_10
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_14 = math.max(var_268_7, arg_265_1.talkMaxDuration)

			if var_268_6 <= arg_265_1.time_ and arg_265_1.time_ < var_268_6 + var_268_14 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_6) / var_268_14

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_6 + var_268_14 and arg_265_1.time_ < var_268_6 + var_268_14 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play322031064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 322031064
		arg_269_1.duration_ = 11.7

		local var_269_0 = {
			zh = 8.833,
			ja = 11.7
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play322031065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1089ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1089ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(0, -1.1, -6.17)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1089ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = arg_269_1.actors_["1089ui_story"]
			local var_272_10 = 0

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1089ui_story == nil then
				arg_269_1.var_.characterEffect1089ui_story = var_272_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_11 = 0.200000002980232

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 and not isNil(var_272_9) then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11

				if arg_269_1.var_.characterEffect1089ui_story and not isNil(var_272_9) then
					arg_269_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1089ui_story then
				arg_269_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_272_13 = 0

			if var_272_13 < arg_269_1.time_ and arg_269_1.time_ <= var_272_13 + arg_272_0 then
				arg_269_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_272_14 = 0
			local var_272_15 = 0.95

			if var_272_14 < arg_269_1.time_ and arg_269_1.time_ <= var_272_14 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_16 = arg_269_1:FormatText(StoryNameCfg[1031].name)

				arg_269_1.leftNameTxt_.text = var_272_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_17 = arg_269_1:GetWordFromCfg(322031064)
				local var_272_18 = arg_269_1:FormatText(var_272_17.content)

				arg_269_1.text_.text = var_272_18

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_19 = 38
				local var_272_20 = utf8.len(var_272_18)
				local var_272_21 = var_272_19 <= 0 and var_272_15 or var_272_15 * (var_272_20 / var_272_19)

				if var_272_21 > 0 and var_272_15 < var_272_21 then
					arg_269_1.talkMaxDuration = var_272_21

					if var_272_21 + var_272_14 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_21 + var_272_14
					end
				end

				arg_269_1.text_.text = var_272_18
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031064", "story_v_out_322031.awb") ~= 0 then
					local var_272_22 = manager.audio:GetVoiceLength("story_v_out_322031", "322031064", "story_v_out_322031.awb") / 1000

					if var_272_22 + var_272_14 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_22 + var_272_14
					end

					if var_272_17.prefab_name ~= "" and arg_269_1.actors_[var_272_17.prefab_name] ~= nil then
						local var_272_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_17.prefab_name].transform, "story_v_out_322031", "322031064", "story_v_out_322031.awb")

						arg_269_1:RecordAudio("322031064", var_272_23)
						arg_269_1:RecordAudio("322031064", var_272_23)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_322031", "322031064", "story_v_out_322031.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_322031", "322031064", "story_v_out_322031.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_24 = math.max(var_272_15, arg_269_1.talkMaxDuration)

			if var_272_14 <= arg_269_1.time_ and arg_269_1.time_ < var_272_14 + var_272_24 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_14) / var_272_24

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_14 + var_272_24 and arg_269_1.time_ < var_272_14 + var_272_24 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play322031065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322031065
		arg_273_1.duration_ = 5.47

		local var_273_0 = {
			zh = 3,
			ja = 5.466
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play322031066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1089ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1089ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(0, -1.1, -6.17)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1089ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = 0

			if var_276_9 < arg_273_1.time_ and arg_273_1.time_ <= var_276_9 + arg_276_0 then
				arg_273_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			local var_276_10 = 0
			local var_276_11 = 0.275

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_12 = arg_273_1:FormatText(StoryNameCfg[1031].name)

				arg_273_1.leftNameTxt_.text = var_276_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_13 = arg_273_1:GetWordFromCfg(322031065)
				local var_276_14 = arg_273_1:FormatText(var_276_13.content)

				arg_273_1.text_.text = var_276_14

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_15 = 11
				local var_276_16 = utf8.len(var_276_14)
				local var_276_17 = var_276_15 <= 0 and var_276_11 or var_276_11 * (var_276_16 / var_276_15)

				if var_276_17 > 0 and var_276_11 < var_276_17 then
					arg_273_1.talkMaxDuration = var_276_17

					if var_276_17 + var_276_10 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_17 + var_276_10
					end
				end

				arg_273_1.text_.text = var_276_14
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031065", "story_v_out_322031.awb") ~= 0 then
					local var_276_18 = manager.audio:GetVoiceLength("story_v_out_322031", "322031065", "story_v_out_322031.awb") / 1000

					if var_276_18 + var_276_10 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_18 + var_276_10
					end

					if var_276_13.prefab_name ~= "" and arg_273_1.actors_[var_276_13.prefab_name] ~= nil then
						local var_276_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_13.prefab_name].transform, "story_v_out_322031", "322031065", "story_v_out_322031.awb")

						arg_273_1:RecordAudio("322031065", var_276_19)
						arg_273_1:RecordAudio("322031065", var_276_19)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322031", "322031065", "story_v_out_322031.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322031", "322031065", "story_v_out_322031.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_20 = math.max(var_276_11, arg_273_1.talkMaxDuration)

			if var_276_10 <= arg_273_1.time_ and arg_273_1.time_ < var_276_10 + var_276_20 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_10) / var_276_20

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_10 + var_276_20 and arg_273_1.time_ < var_276_10 + var_276_20 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play322031066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322031066
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play322031067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1089ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1089ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(0, 100, 0)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1089ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0, 100, 0)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = 0
			local var_280_10 = 0.9

			if var_280_9 < arg_277_1.time_ and arg_277_1.time_ <= var_280_9 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_11 = arg_277_1:GetWordFromCfg(322031066)
				local var_280_12 = arg_277_1:FormatText(var_280_11.content)

				arg_277_1.text_.text = var_280_12

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_13 = 36
				local var_280_14 = utf8.len(var_280_12)
				local var_280_15 = var_280_13 <= 0 and var_280_10 or var_280_10 * (var_280_14 / var_280_13)

				if var_280_15 > 0 and var_280_10 < var_280_15 then
					arg_277_1.talkMaxDuration = var_280_15

					if var_280_15 + var_280_9 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_15 + var_280_9
					end
				end

				arg_277_1.text_.text = var_280_12
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_16 = math.max(var_280_10, arg_277_1.talkMaxDuration)

			if var_280_9 <= arg_277_1.time_ and arg_277_1.time_ < var_280_9 + var_280_16 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_9) / var_280_16

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_9 + var_280_16 and arg_277_1.time_ < var_280_9 + var_280_16 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play322031067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322031067
		arg_281_1.duration_ = 11.43

		local var_281_0 = {
			zh = 7.466,
			ja = 11.433
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
				arg_281_0:Play322031068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1089ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos1089ui_story = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(0, -1.1, -6.17)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1089ui_story, var_284_4, var_284_3)

				local var_284_5 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_5.x, var_284_5.y, var_284_5.z)

				local var_284_6 = var_284_0.localEulerAngles

				var_284_6.z = 0
				var_284_6.x = 0
				var_284_0.localEulerAngles = var_284_6
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_284_7 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_7.x, var_284_7.y, var_284_7.z)

				local var_284_8 = var_284_0.localEulerAngles

				var_284_8.z = 0
				var_284_8.x = 0
				var_284_0.localEulerAngles = var_284_8
			end

			local var_284_9 = arg_281_1.actors_["1089ui_story"]
			local var_284_10 = 0

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 and not isNil(var_284_9) and arg_281_1.var_.characterEffect1089ui_story == nil then
				arg_281_1.var_.characterEffect1089ui_story = var_284_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_11 = 0.200000002980232

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_11 and not isNil(var_284_9) then
				local var_284_12 = (arg_281_1.time_ - var_284_10) / var_284_11

				if arg_281_1.var_.characterEffect1089ui_story and not isNil(var_284_9) then
					arg_281_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_10 + var_284_11 and arg_281_1.time_ < var_284_10 + var_284_11 + arg_284_0 and not isNil(var_284_9) and arg_281_1.var_.characterEffect1089ui_story then
				arg_281_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_284_13 = 0

			if var_284_13 < arg_281_1.time_ and arg_281_1.time_ <= var_284_13 + arg_284_0 then
				arg_281_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_1")
			end

			local var_284_14 = 0

			if var_284_14 < arg_281_1.time_ and arg_281_1.time_ <= var_284_14 + arg_284_0 then
				arg_281_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_284_15 = 0
			local var_284_16 = 0.65

			if var_284_15 < arg_281_1.time_ and arg_281_1.time_ <= var_284_15 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_17 = arg_281_1:FormatText(StoryNameCfg[1031].name)

				arg_281_1.leftNameTxt_.text = var_284_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_18 = arg_281_1:GetWordFromCfg(322031067)
				local var_284_19 = arg_281_1:FormatText(var_284_18.content)

				arg_281_1.text_.text = var_284_19

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_20 = 26
				local var_284_21 = utf8.len(var_284_19)
				local var_284_22 = var_284_20 <= 0 and var_284_16 or var_284_16 * (var_284_21 / var_284_20)

				if var_284_22 > 0 and var_284_16 < var_284_22 then
					arg_281_1.talkMaxDuration = var_284_22

					if var_284_22 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_22 + var_284_15
					end
				end

				arg_281_1.text_.text = var_284_19
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031067", "story_v_out_322031.awb") ~= 0 then
					local var_284_23 = manager.audio:GetVoiceLength("story_v_out_322031", "322031067", "story_v_out_322031.awb") / 1000

					if var_284_23 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_23 + var_284_15
					end

					if var_284_18.prefab_name ~= "" and arg_281_1.actors_[var_284_18.prefab_name] ~= nil then
						local var_284_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_18.prefab_name].transform, "story_v_out_322031", "322031067", "story_v_out_322031.awb")

						arg_281_1:RecordAudio("322031067", var_284_24)
						arg_281_1:RecordAudio("322031067", var_284_24)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_322031", "322031067", "story_v_out_322031.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_322031", "322031067", "story_v_out_322031.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_25 = math.max(var_284_16, arg_281_1.talkMaxDuration)

			if var_284_15 <= arg_281_1.time_ and arg_281_1.time_ < var_284_15 + var_284_25 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_15) / var_284_25

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_15 + var_284_25 and arg_281_1.time_ < var_284_15 + var_284_25 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play322031068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322031068
		arg_285_1.duration_ = 8.23

		local var_285_0 = {
			zh = 3.6,
			ja = 8.233
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
				arg_285_0:Play322031069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_2")
			end

			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_288_2 = 0
			local var_288_3 = 0.425

			if var_288_2 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_4 = arg_285_1:FormatText(StoryNameCfg[1031].name)

				arg_285_1.leftNameTxt_.text = var_288_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_5 = arg_285_1:GetWordFromCfg(322031068)
				local var_288_6 = arg_285_1:FormatText(var_288_5.content)

				arg_285_1.text_.text = var_288_6

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_7 = 17
				local var_288_8 = utf8.len(var_288_6)
				local var_288_9 = var_288_7 <= 0 and var_288_3 or var_288_3 * (var_288_8 / var_288_7)

				if var_288_9 > 0 and var_288_3 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_2
					end
				end

				arg_285_1.text_.text = var_288_6
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031068", "story_v_out_322031.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_out_322031", "322031068", "story_v_out_322031.awb") / 1000

					if var_288_10 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_2
					end

					if var_288_5.prefab_name ~= "" and arg_285_1.actors_[var_288_5.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_5.prefab_name].transform, "story_v_out_322031", "322031068", "story_v_out_322031.awb")

						arg_285_1:RecordAudio("322031068", var_288_11)
						arg_285_1:RecordAudio("322031068", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_322031", "322031068", "story_v_out_322031.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_322031", "322031068", "story_v_out_322031.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_3, arg_285_1.talkMaxDuration)

			if var_288_2 <= arg_285_1.time_ and arg_285_1.time_ < var_288_2 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_2) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_2 + var_288_12 and arg_285_1.time_ < var_288_2 + var_288_12 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play322031069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322031069
		arg_289_1.duration_ = 2.53

		local var_289_0 = {
			zh = 2.266,
			ja = 2.533
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
				arg_289_0:Play322031070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1284ui_story"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos1284ui_story = var_292_0.localPosition
			end

			local var_292_2 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2
				local var_292_4 = Vector3.New(0.7, -0.985, -6.22)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1284ui_story, var_292_4, var_292_3)

				local var_292_5 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_5.x, var_292_5.y, var_292_5.z)

				local var_292_6 = var_292_0.localEulerAngles

				var_292_6.z = 0
				var_292_6.x = 0
				var_292_0.localEulerAngles = var_292_6
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_292_7 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_7.x, var_292_7.y, var_292_7.z)

				local var_292_8 = var_292_0.localEulerAngles

				var_292_8.z = 0
				var_292_8.x = 0
				var_292_0.localEulerAngles = var_292_8
			end

			local var_292_9 = arg_289_1.actors_["1089ui_story"].transform
			local var_292_10 = 0

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 then
				arg_289_1.var_.moveOldPos1089ui_story = var_292_9.localPosition
			end

			local var_292_11 = 0.001

			if var_292_10 <= arg_289_1.time_ and arg_289_1.time_ < var_292_10 + var_292_11 then
				local var_292_12 = (arg_289_1.time_ - var_292_10) / var_292_11
				local var_292_13 = Vector3.New(-0.7, -1.1, -6.17)

				var_292_9.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1089ui_story, var_292_13, var_292_12)

				local var_292_14 = manager.ui.mainCamera.transform.position - var_292_9.position

				var_292_9.forward = Vector3.New(var_292_14.x, var_292_14.y, var_292_14.z)

				local var_292_15 = var_292_9.localEulerAngles

				var_292_15.z = 0
				var_292_15.x = 0
				var_292_9.localEulerAngles = var_292_15
			end

			if arg_289_1.time_ >= var_292_10 + var_292_11 and arg_289_1.time_ < var_292_10 + var_292_11 + arg_292_0 then
				var_292_9.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_292_16 = manager.ui.mainCamera.transform.position - var_292_9.position

				var_292_9.forward = Vector3.New(var_292_16.x, var_292_16.y, var_292_16.z)

				local var_292_17 = var_292_9.localEulerAngles

				var_292_17.z = 0
				var_292_17.x = 0
				var_292_9.localEulerAngles = var_292_17
			end

			local var_292_18 = arg_289_1.actors_["1284ui_story"]
			local var_292_19 = 0

			if var_292_19 < arg_289_1.time_ and arg_289_1.time_ <= var_292_19 + arg_292_0 and not isNil(var_292_18) and arg_289_1.var_.characterEffect1284ui_story == nil then
				arg_289_1.var_.characterEffect1284ui_story = var_292_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_20 = 0.200000002980232

			if var_292_19 <= arg_289_1.time_ and arg_289_1.time_ < var_292_19 + var_292_20 and not isNil(var_292_18) then
				local var_292_21 = (arg_289_1.time_ - var_292_19) / var_292_20

				if arg_289_1.var_.characterEffect1284ui_story and not isNil(var_292_18) then
					arg_289_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_19 + var_292_20 and arg_289_1.time_ < var_292_19 + var_292_20 + arg_292_0 and not isNil(var_292_18) and arg_289_1.var_.characterEffect1284ui_story then
				arg_289_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_292_22 = arg_289_1.actors_["1089ui_story"]
			local var_292_23 = 0

			if var_292_23 < arg_289_1.time_ and arg_289_1.time_ <= var_292_23 + arg_292_0 and not isNil(var_292_22) and arg_289_1.var_.characterEffect1089ui_story == nil then
				arg_289_1.var_.characterEffect1089ui_story = var_292_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_24 = 0.200000002980232

			if var_292_23 <= arg_289_1.time_ and arg_289_1.time_ < var_292_23 + var_292_24 and not isNil(var_292_22) then
				local var_292_25 = (arg_289_1.time_ - var_292_23) / var_292_24

				if arg_289_1.var_.characterEffect1089ui_story and not isNil(var_292_22) then
					local var_292_26 = Mathf.Lerp(0, 0.5, var_292_25)

					arg_289_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1089ui_story.fillRatio = var_292_26
				end
			end

			if arg_289_1.time_ >= var_292_23 + var_292_24 and arg_289_1.time_ < var_292_23 + var_292_24 + arg_292_0 and not isNil(var_292_22) and arg_289_1.var_.characterEffect1089ui_story then
				local var_292_27 = 0.5

				arg_289_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1089ui_story.fillRatio = var_292_27
			end

			local var_292_28 = 0

			if var_292_28 < arg_289_1.time_ and arg_289_1.time_ <= var_292_28 + arg_292_0 then
				arg_289_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_292_29 = 0

			if var_292_29 < arg_289_1.time_ and arg_289_1.time_ <= var_292_29 + arg_292_0 then
				arg_289_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_292_30 = 0
			local var_292_31 = 0.2

			if var_292_30 < arg_289_1.time_ and arg_289_1.time_ <= var_292_30 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_32 = arg_289_1:FormatText(StoryNameCfg[6].name)

				arg_289_1.leftNameTxt_.text = var_292_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_33 = arg_289_1:GetWordFromCfg(322031069)
				local var_292_34 = arg_289_1:FormatText(var_292_33.content)

				arg_289_1.text_.text = var_292_34

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_35 = 8
				local var_292_36 = utf8.len(var_292_34)
				local var_292_37 = var_292_35 <= 0 and var_292_31 or var_292_31 * (var_292_36 / var_292_35)

				if var_292_37 > 0 and var_292_31 < var_292_37 then
					arg_289_1.talkMaxDuration = var_292_37

					if var_292_37 + var_292_30 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_37 + var_292_30
					end
				end

				arg_289_1.text_.text = var_292_34
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031069", "story_v_out_322031.awb") ~= 0 then
					local var_292_38 = manager.audio:GetVoiceLength("story_v_out_322031", "322031069", "story_v_out_322031.awb") / 1000

					if var_292_38 + var_292_30 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_38 + var_292_30
					end

					if var_292_33.prefab_name ~= "" and arg_289_1.actors_[var_292_33.prefab_name] ~= nil then
						local var_292_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_33.prefab_name].transform, "story_v_out_322031", "322031069", "story_v_out_322031.awb")

						arg_289_1:RecordAudio("322031069", var_292_39)
						arg_289_1:RecordAudio("322031069", var_292_39)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_322031", "322031069", "story_v_out_322031.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_322031", "322031069", "story_v_out_322031.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_40 = math.max(var_292_31, arg_289_1.talkMaxDuration)

			if var_292_30 <= arg_289_1.time_ and arg_289_1.time_ < var_292_30 + var_292_40 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_30) / var_292_40

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_30 + var_292_40 and arg_289_1.time_ < var_292_30 + var_292_40 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
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
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play322031070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 322031070
		arg_293_1.duration_ = 2

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play322031071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1089ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1089ui_story == nil then
				arg_293_1.var_.characterEffect1089ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1089ui_story and not isNil(var_296_0) then
					arg_293_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1089ui_story then
				arg_293_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_296_4 = arg_293_1.actors_["1284ui_story"]
			local var_296_5 = 0

			if var_296_5 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 and not isNil(var_296_4) and arg_293_1.var_.characterEffect1284ui_story == nil then
				arg_293_1.var_.characterEffect1284ui_story = var_296_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_6 = 0.200000002980232

			if var_296_5 <= arg_293_1.time_ and arg_293_1.time_ < var_296_5 + var_296_6 and not isNil(var_296_4) then
				local var_296_7 = (arg_293_1.time_ - var_296_5) / var_296_6

				if arg_293_1.var_.characterEffect1284ui_story and not isNil(var_296_4) then
					local var_296_8 = Mathf.Lerp(0, 0.5, var_296_7)

					arg_293_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1284ui_story.fillRatio = var_296_8
				end
			end

			if arg_293_1.time_ >= var_296_5 + var_296_6 and arg_293_1.time_ < var_296_5 + var_296_6 + arg_296_0 and not isNil(var_296_4) and arg_293_1.var_.characterEffect1284ui_story then
				local var_296_9 = 0.5

				arg_293_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1284ui_story.fillRatio = var_296_9
			end

			local var_296_10 = 0

			if var_296_10 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 then
				arg_293_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_296_11 = 0
			local var_296_12 = 0.05

			if var_296_11 < arg_293_1.time_ and arg_293_1.time_ <= var_296_11 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_13 = arg_293_1:FormatText(StoryNameCfg[1031].name)

				arg_293_1.leftNameTxt_.text = var_296_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_14 = arg_293_1:GetWordFromCfg(322031070)
				local var_296_15 = arg_293_1:FormatText(var_296_14.content)

				arg_293_1.text_.text = var_296_15

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_16 = 2
				local var_296_17 = utf8.len(var_296_15)
				local var_296_18 = var_296_16 <= 0 and var_296_12 or var_296_12 * (var_296_17 / var_296_16)

				if var_296_18 > 0 and var_296_12 < var_296_18 then
					arg_293_1.talkMaxDuration = var_296_18

					if var_296_18 + var_296_11 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_18 + var_296_11
					end
				end

				arg_293_1.text_.text = var_296_15
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031070", "story_v_out_322031.awb") ~= 0 then
					local var_296_19 = manager.audio:GetVoiceLength("story_v_out_322031", "322031070", "story_v_out_322031.awb") / 1000

					if var_296_19 + var_296_11 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_19 + var_296_11
					end

					if var_296_14.prefab_name ~= "" and arg_293_1.actors_[var_296_14.prefab_name] ~= nil then
						local var_296_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_14.prefab_name].transform, "story_v_out_322031", "322031070", "story_v_out_322031.awb")

						arg_293_1:RecordAudio("322031070", var_296_20)
						arg_293_1:RecordAudio("322031070", var_296_20)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_322031", "322031070", "story_v_out_322031.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_322031", "322031070", "story_v_out_322031.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_21 = math.max(var_296_12, arg_293_1.talkMaxDuration)

			if var_296_11 <= arg_293_1.time_ and arg_293_1.time_ < var_296_11 + var_296_21 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_11) / var_296_21

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_11 + var_296_21 and arg_293_1.time_ < var_296_11 + var_296_21 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play322031071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 322031071
		arg_297_1.duration_ = 5.13

		local var_297_0 = {
			zh = 4.3,
			ja = 5.133
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play322031072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1284ui_story"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1284ui_story == nil then
				arg_297_1.var_.characterEffect1284ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.characterEffect1284ui_story and not isNil(var_300_0) then
					arg_297_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1284ui_story then
				arg_297_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_300_4 = arg_297_1.actors_["1089ui_story"]
			local var_300_5 = 0

			if var_300_5 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 and not isNil(var_300_4) and arg_297_1.var_.characterEffect1089ui_story == nil then
				arg_297_1.var_.characterEffect1089ui_story = var_300_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_6 = 0.200000002980232

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_6 and not isNil(var_300_4) then
				local var_300_7 = (arg_297_1.time_ - var_300_5) / var_300_6

				if arg_297_1.var_.characterEffect1089ui_story and not isNil(var_300_4) then
					local var_300_8 = Mathf.Lerp(0, 0.5, var_300_7)

					arg_297_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1089ui_story.fillRatio = var_300_8
				end
			end

			if arg_297_1.time_ >= var_300_5 + var_300_6 and arg_297_1.time_ < var_300_5 + var_300_6 + arg_300_0 and not isNil(var_300_4) and arg_297_1.var_.characterEffect1089ui_story then
				local var_300_9 = 0.5

				arg_297_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1089ui_story.fillRatio = var_300_9
			end

			local var_300_10 = 0

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 then
				arg_297_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			local var_300_11 = 0

			if var_300_11 < arg_297_1.time_ and arg_297_1.time_ <= var_300_11 + arg_300_0 then
				arg_297_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_300_12 = 0
			local var_300_13 = 0.525

			if var_300_12 < arg_297_1.time_ and arg_297_1.time_ <= var_300_12 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_14 = arg_297_1:FormatText(StoryNameCfg[6].name)

				arg_297_1.leftNameTxt_.text = var_300_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_15 = arg_297_1:GetWordFromCfg(322031071)
				local var_300_16 = arg_297_1:FormatText(var_300_15.content)

				arg_297_1.text_.text = var_300_16

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_17 = 21
				local var_300_18 = utf8.len(var_300_16)
				local var_300_19 = var_300_17 <= 0 and var_300_13 or var_300_13 * (var_300_18 / var_300_17)

				if var_300_19 > 0 and var_300_13 < var_300_19 then
					arg_297_1.talkMaxDuration = var_300_19

					if var_300_19 + var_300_12 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_19 + var_300_12
					end
				end

				arg_297_1.text_.text = var_300_16
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031071", "story_v_out_322031.awb") ~= 0 then
					local var_300_20 = manager.audio:GetVoiceLength("story_v_out_322031", "322031071", "story_v_out_322031.awb") / 1000

					if var_300_20 + var_300_12 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_20 + var_300_12
					end

					if var_300_15.prefab_name ~= "" and arg_297_1.actors_[var_300_15.prefab_name] ~= nil then
						local var_300_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_15.prefab_name].transform, "story_v_out_322031", "322031071", "story_v_out_322031.awb")

						arg_297_1:RecordAudio("322031071", var_300_21)
						arg_297_1:RecordAudio("322031071", var_300_21)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_322031", "322031071", "story_v_out_322031.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_322031", "322031071", "story_v_out_322031.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_22 = math.max(var_300_13, arg_297_1.talkMaxDuration)

			if var_300_12 <= arg_297_1.time_ and arg_297_1.time_ < var_300_12 + var_300_22 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_12) / var_300_22

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_12 + var_300_22 and arg_297_1.time_ < var_300_12 + var_300_22 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play322031072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 322031072
		arg_301_1.duration_ = 4.5

		local var_301_0 = {
			zh = 3.966,
			ja = 4.5
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play322031073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1089ui_story"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1089ui_story == nil then
				arg_301_1.var_.characterEffect1089ui_story = var_304_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.characterEffect1089ui_story and not isNil(var_304_0) then
					arg_301_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1089ui_story then
				arg_301_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_304_4 = arg_301_1.actors_["1284ui_story"]
			local var_304_5 = 0

			if var_304_5 < arg_301_1.time_ and arg_301_1.time_ <= var_304_5 + arg_304_0 and not isNil(var_304_4) and arg_301_1.var_.characterEffect1284ui_story == nil then
				arg_301_1.var_.characterEffect1284ui_story = var_304_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_6 = 0.200000002980232

			if var_304_5 <= arg_301_1.time_ and arg_301_1.time_ < var_304_5 + var_304_6 and not isNil(var_304_4) then
				local var_304_7 = (arg_301_1.time_ - var_304_5) / var_304_6

				if arg_301_1.var_.characterEffect1284ui_story and not isNil(var_304_4) then
					local var_304_8 = Mathf.Lerp(0, 0.5, var_304_7)

					arg_301_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1284ui_story.fillRatio = var_304_8
				end
			end

			if arg_301_1.time_ >= var_304_5 + var_304_6 and arg_301_1.time_ < var_304_5 + var_304_6 + arg_304_0 and not isNil(var_304_4) and arg_301_1.var_.characterEffect1284ui_story then
				local var_304_9 = 0.5

				arg_301_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1284ui_story.fillRatio = var_304_9
			end

			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 then
				arg_301_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_304_11 = 0
			local var_304_12 = 0.45

			if var_304_11 < arg_301_1.time_ and arg_301_1.time_ <= var_304_11 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_13 = arg_301_1:FormatText(StoryNameCfg[1031].name)

				arg_301_1.leftNameTxt_.text = var_304_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_14 = arg_301_1:GetWordFromCfg(322031072)
				local var_304_15 = arg_301_1:FormatText(var_304_14.content)

				arg_301_1.text_.text = var_304_15

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_16 = 18
				local var_304_17 = utf8.len(var_304_15)
				local var_304_18 = var_304_16 <= 0 and var_304_12 or var_304_12 * (var_304_17 / var_304_16)

				if var_304_18 > 0 and var_304_12 < var_304_18 then
					arg_301_1.talkMaxDuration = var_304_18

					if var_304_18 + var_304_11 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_18 + var_304_11
					end
				end

				arg_301_1.text_.text = var_304_15
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031072", "story_v_out_322031.awb") ~= 0 then
					local var_304_19 = manager.audio:GetVoiceLength("story_v_out_322031", "322031072", "story_v_out_322031.awb") / 1000

					if var_304_19 + var_304_11 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_19 + var_304_11
					end

					if var_304_14.prefab_name ~= "" and arg_301_1.actors_[var_304_14.prefab_name] ~= nil then
						local var_304_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_14.prefab_name].transform, "story_v_out_322031", "322031072", "story_v_out_322031.awb")

						arg_301_1:RecordAudio("322031072", var_304_20)
						arg_301_1:RecordAudio("322031072", var_304_20)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_322031", "322031072", "story_v_out_322031.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_322031", "322031072", "story_v_out_322031.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_21 = math.max(var_304_12, arg_301_1.talkMaxDuration)

			if var_304_11 <= arg_301_1.time_ and arg_301_1.time_ < var_304_11 + var_304_21 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_11) / var_304_21

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_11 + var_304_21 and arg_301_1.time_ < var_304_11 + var_304_21 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play322031073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 322031073
		arg_305_1.duration_ = 8.37

		local var_305_0 = {
			zh = 5.1,
			ja = 8.366
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
				arg_305_0:Play322031074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.625

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[1031].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_3 = arg_305_1:GetWordFromCfg(322031073)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 25
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031073", "story_v_out_322031.awb") ~= 0 then
					local var_308_8 = manager.audio:GetVoiceLength("story_v_out_322031", "322031073", "story_v_out_322031.awb") / 1000

					if var_308_8 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_0
					end

					if var_308_3.prefab_name ~= "" and arg_305_1.actors_[var_308_3.prefab_name] ~= nil then
						local var_308_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_3.prefab_name].transform, "story_v_out_322031", "322031073", "story_v_out_322031.awb")

						arg_305_1:RecordAudio("322031073", var_308_9)
						arg_305_1:RecordAudio("322031073", var_308_9)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_322031", "322031073", "story_v_out_322031.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_322031", "322031073", "story_v_out_322031.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_10 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_10 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_10

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_10 and arg_305_1.time_ < var_308_0 + var_308_10 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play322031074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 322031074
		arg_309_1.duration_ = 3.7

		local var_309_0 = {
			zh = 3.633,
			ja = 3.7
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play322031075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1284ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1284ui_story == nil then
				arg_309_1.var_.characterEffect1284ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect1284ui_story and not isNil(var_312_0) then
					arg_309_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1284ui_story then
				arg_309_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_312_4 = arg_309_1.actors_["1089ui_story"]
			local var_312_5 = 0

			if var_312_5 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 and not isNil(var_312_4) and arg_309_1.var_.characterEffect1089ui_story == nil then
				arg_309_1.var_.characterEffect1089ui_story = var_312_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_6 = 0.200000002980232

			if var_312_5 <= arg_309_1.time_ and arg_309_1.time_ < var_312_5 + var_312_6 and not isNil(var_312_4) then
				local var_312_7 = (arg_309_1.time_ - var_312_5) / var_312_6

				if arg_309_1.var_.characterEffect1089ui_story and not isNil(var_312_4) then
					local var_312_8 = Mathf.Lerp(0, 0.5, var_312_7)

					arg_309_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1089ui_story.fillRatio = var_312_8
				end
			end

			if arg_309_1.time_ >= var_312_5 + var_312_6 and arg_309_1.time_ < var_312_5 + var_312_6 + arg_312_0 and not isNil(var_312_4) and arg_309_1.var_.characterEffect1089ui_story then
				local var_312_9 = 0.5

				arg_309_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1089ui_story.fillRatio = var_312_9
			end

			local var_312_10 = 0

			if var_312_10 < arg_309_1.time_ and arg_309_1.time_ <= var_312_10 + arg_312_0 then
				arg_309_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_2")
			end

			local var_312_11 = 0

			if var_312_11 < arg_309_1.time_ and arg_309_1.time_ <= var_312_11 + arg_312_0 then
				arg_309_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_312_12 = 0
			local var_312_13 = 0.325

			if var_312_12 < arg_309_1.time_ and arg_309_1.time_ <= var_312_12 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_14 = arg_309_1:FormatText(StoryNameCfg[6].name)

				arg_309_1.leftNameTxt_.text = var_312_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_15 = arg_309_1:GetWordFromCfg(322031074)
				local var_312_16 = arg_309_1:FormatText(var_312_15.content)

				arg_309_1.text_.text = var_312_16

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_17 = 13
				local var_312_18 = utf8.len(var_312_16)
				local var_312_19 = var_312_17 <= 0 and var_312_13 or var_312_13 * (var_312_18 / var_312_17)

				if var_312_19 > 0 and var_312_13 < var_312_19 then
					arg_309_1.talkMaxDuration = var_312_19

					if var_312_19 + var_312_12 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_19 + var_312_12
					end
				end

				arg_309_1.text_.text = var_312_16
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031074", "story_v_out_322031.awb") ~= 0 then
					local var_312_20 = manager.audio:GetVoiceLength("story_v_out_322031", "322031074", "story_v_out_322031.awb") / 1000

					if var_312_20 + var_312_12 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_20 + var_312_12
					end

					if var_312_15.prefab_name ~= "" and arg_309_1.actors_[var_312_15.prefab_name] ~= nil then
						local var_312_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_15.prefab_name].transform, "story_v_out_322031", "322031074", "story_v_out_322031.awb")

						arg_309_1:RecordAudio("322031074", var_312_21)
						arg_309_1:RecordAudio("322031074", var_312_21)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_322031", "322031074", "story_v_out_322031.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_322031", "322031074", "story_v_out_322031.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_22 = math.max(var_312_13, arg_309_1.talkMaxDuration)

			if var_312_12 <= arg_309_1.time_ and arg_309_1.time_ < var_312_12 + var_312_22 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_12) / var_312_22

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_12 + var_312_22 and arg_309_1.time_ < var_312_12 + var_312_22 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play322031075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 322031075
		arg_313_1.duration_ = 10.03

		local var_313_0 = {
			zh = 7.166,
			ja = 10.033
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play322031076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1089ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1089ui_story == nil then
				arg_313_1.var_.characterEffect1089ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1089ui_story and not isNil(var_316_0) then
					arg_313_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1089ui_story then
				arg_313_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_316_4 = arg_313_1.actors_["1284ui_story"]
			local var_316_5 = 0

			if var_316_5 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 and not isNil(var_316_4) and arg_313_1.var_.characterEffect1284ui_story == nil then
				arg_313_1.var_.characterEffect1284ui_story = var_316_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_6 = 0.200000002980232

			if var_316_5 <= arg_313_1.time_ and arg_313_1.time_ < var_316_5 + var_316_6 and not isNil(var_316_4) then
				local var_316_7 = (arg_313_1.time_ - var_316_5) / var_316_6

				if arg_313_1.var_.characterEffect1284ui_story and not isNil(var_316_4) then
					local var_316_8 = Mathf.Lerp(0, 0.5, var_316_7)

					arg_313_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1284ui_story.fillRatio = var_316_8
				end
			end

			if arg_313_1.time_ >= var_316_5 + var_316_6 and arg_313_1.time_ < var_316_5 + var_316_6 + arg_316_0 and not isNil(var_316_4) and arg_313_1.var_.characterEffect1284ui_story then
				local var_316_9 = 0.5

				arg_313_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1284ui_story.fillRatio = var_316_9
			end

			local var_316_10 = 0

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 then
				arg_313_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_316_11 = 0

			if var_316_11 < arg_313_1.time_ and arg_313_1.time_ <= var_316_11 + arg_316_0 then
				arg_313_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_316_12 = 0
			local var_316_13 = 0.85

			if var_316_12 < arg_313_1.time_ and arg_313_1.time_ <= var_316_12 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_14 = arg_313_1:FormatText(StoryNameCfg[1031].name)

				arg_313_1.leftNameTxt_.text = var_316_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_15 = arg_313_1:GetWordFromCfg(322031075)
				local var_316_16 = arg_313_1:FormatText(var_316_15.content)

				arg_313_1.text_.text = var_316_16

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_17 = 34
				local var_316_18 = utf8.len(var_316_16)
				local var_316_19 = var_316_17 <= 0 and var_316_13 or var_316_13 * (var_316_18 / var_316_17)

				if var_316_19 > 0 and var_316_13 < var_316_19 then
					arg_313_1.talkMaxDuration = var_316_19

					if var_316_19 + var_316_12 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_19 + var_316_12
					end
				end

				arg_313_1.text_.text = var_316_16
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031075", "story_v_out_322031.awb") ~= 0 then
					local var_316_20 = manager.audio:GetVoiceLength("story_v_out_322031", "322031075", "story_v_out_322031.awb") / 1000

					if var_316_20 + var_316_12 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_20 + var_316_12
					end

					if var_316_15.prefab_name ~= "" and arg_313_1.actors_[var_316_15.prefab_name] ~= nil then
						local var_316_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_15.prefab_name].transform, "story_v_out_322031", "322031075", "story_v_out_322031.awb")

						arg_313_1:RecordAudio("322031075", var_316_21)
						arg_313_1:RecordAudio("322031075", var_316_21)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_322031", "322031075", "story_v_out_322031.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_322031", "322031075", "story_v_out_322031.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_22 = math.max(var_316_13, arg_313_1.talkMaxDuration)

			if var_316_12 <= arg_313_1.time_ and arg_313_1.time_ < var_316_12 + var_316_22 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_12) / var_316_22

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_12 + var_316_22 and arg_313_1.time_ < var_316_12 + var_316_22 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play322031076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 322031076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play322031077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1089ui_story"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos1089ui_story = var_320_0.localPosition
			end

			local var_320_2 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2
				local var_320_4 = Vector3.New(0, 100, 0)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1089ui_story, var_320_4, var_320_3)

				local var_320_5 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_5.x, var_320_5.y, var_320_5.z)

				local var_320_6 = var_320_0.localEulerAngles

				var_320_6.z = 0
				var_320_6.x = 0
				var_320_0.localEulerAngles = var_320_6
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(0, 100, 0)

				local var_320_7 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_7.x, var_320_7.y, var_320_7.z)

				local var_320_8 = var_320_0.localEulerAngles

				var_320_8.z = 0
				var_320_8.x = 0
				var_320_0.localEulerAngles = var_320_8
			end

			local var_320_9 = arg_317_1.actors_["1284ui_story"].transform
			local var_320_10 = 0

			if var_320_10 < arg_317_1.time_ and arg_317_1.time_ <= var_320_10 + arg_320_0 then
				arg_317_1.var_.moveOldPos1284ui_story = var_320_9.localPosition
			end

			local var_320_11 = 0.001

			if var_320_10 <= arg_317_1.time_ and arg_317_1.time_ < var_320_10 + var_320_11 then
				local var_320_12 = (arg_317_1.time_ - var_320_10) / var_320_11
				local var_320_13 = Vector3.New(0, 100, 0)

				var_320_9.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1284ui_story, var_320_13, var_320_12)

				local var_320_14 = manager.ui.mainCamera.transform.position - var_320_9.position

				var_320_9.forward = Vector3.New(var_320_14.x, var_320_14.y, var_320_14.z)

				local var_320_15 = var_320_9.localEulerAngles

				var_320_15.z = 0
				var_320_15.x = 0
				var_320_9.localEulerAngles = var_320_15
			end

			if arg_317_1.time_ >= var_320_10 + var_320_11 and arg_317_1.time_ < var_320_10 + var_320_11 + arg_320_0 then
				var_320_9.localPosition = Vector3.New(0, 100, 0)

				local var_320_16 = manager.ui.mainCamera.transform.position - var_320_9.position

				var_320_9.forward = Vector3.New(var_320_16.x, var_320_16.y, var_320_16.z)

				local var_320_17 = var_320_9.localEulerAngles

				var_320_17.z = 0
				var_320_17.x = 0
				var_320_9.localEulerAngles = var_320_17
			end

			local var_320_18 = 0.866666666666667
			local var_320_19 = 1

			if var_320_18 < arg_317_1.time_ and arg_317_1.time_ <= var_320_18 + arg_320_0 then
				local var_320_20 = "play"
				local var_320_21 = "effect"

				arg_317_1:AudioAction(var_320_20, var_320_21, "se_story_1310", "se_story_1310_clap", "")
			end

			local var_320_22 = 0
			local var_320_23 = 1.125

			if var_320_22 < arg_317_1.time_ and arg_317_1.time_ <= var_320_22 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_24 = arg_317_1:GetWordFromCfg(322031076)
				local var_320_25 = arg_317_1:FormatText(var_320_24.content)

				arg_317_1.text_.text = var_320_25

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_26 = 45
				local var_320_27 = utf8.len(var_320_25)
				local var_320_28 = var_320_26 <= 0 and var_320_23 or var_320_23 * (var_320_27 / var_320_26)

				if var_320_28 > 0 and var_320_23 < var_320_28 then
					arg_317_1.talkMaxDuration = var_320_28

					if var_320_28 + var_320_22 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_28 + var_320_22
					end
				end

				arg_317_1.text_.text = var_320_25
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_29 = math.max(var_320_23, arg_317_1.talkMaxDuration)

			if var_320_22 <= arg_317_1.time_ and arg_317_1.time_ < var_320_22 + var_320_29 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_22) / var_320_29

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_22 + var_320_29 and arg_317_1.time_ < var_320_22 + var_320_29 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
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

		arg_317_1:InitPlayNodeList()
	end,
	Play322031077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 322031077
		arg_321_1.duration_ = 11.27

		local var_321_0 = {
			zh = 7.466,
			ja = 11.266
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play322031078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1089ui_story"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos1089ui_story = var_324_0.localPosition
			end

			local var_324_2 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2
				local var_324_4 = Vector3.New(0, -1.1, -6.17)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1089ui_story, var_324_4, var_324_3)

				local var_324_5 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_5.x, var_324_5.y, var_324_5.z)

				local var_324_6 = var_324_0.localEulerAngles

				var_324_6.z = 0
				var_324_6.x = 0
				var_324_0.localEulerAngles = var_324_6
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_324_7 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_7.x, var_324_7.y, var_324_7.z)

				local var_324_8 = var_324_0.localEulerAngles

				var_324_8.z = 0
				var_324_8.x = 0
				var_324_0.localEulerAngles = var_324_8
			end

			local var_324_9 = arg_321_1.actors_["1089ui_story"]
			local var_324_10 = 0

			if var_324_10 < arg_321_1.time_ and arg_321_1.time_ <= var_324_10 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect1089ui_story == nil then
				arg_321_1.var_.characterEffect1089ui_story = var_324_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_11 = 0.200000002980232

			if var_324_10 <= arg_321_1.time_ and arg_321_1.time_ < var_324_10 + var_324_11 and not isNil(var_324_9) then
				local var_324_12 = (arg_321_1.time_ - var_324_10) / var_324_11

				if arg_321_1.var_.characterEffect1089ui_story and not isNil(var_324_9) then
					arg_321_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_10 + var_324_11 and arg_321_1.time_ < var_324_10 + var_324_11 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect1089ui_story then
				arg_321_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_324_13 = 0

			if var_324_13 < arg_321_1.time_ and arg_321_1.time_ <= var_324_13 + arg_324_0 then
				arg_321_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			local var_324_14 = 0

			if var_324_14 < arg_321_1.time_ and arg_321_1.time_ <= var_324_14 + arg_324_0 then
				arg_321_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_324_15 = 0
			local var_324_16 = 0.825

			if var_324_15 < arg_321_1.time_ and arg_321_1.time_ <= var_324_15 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_17 = arg_321_1:FormatText(StoryNameCfg[1031].name)

				arg_321_1.leftNameTxt_.text = var_324_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_18 = arg_321_1:GetWordFromCfg(322031077)
				local var_324_19 = arg_321_1:FormatText(var_324_18.content)

				arg_321_1.text_.text = var_324_19

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_20 = 33
				local var_324_21 = utf8.len(var_324_19)
				local var_324_22 = var_324_20 <= 0 and var_324_16 or var_324_16 * (var_324_21 / var_324_20)

				if var_324_22 > 0 and var_324_16 < var_324_22 then
					arg_321_1.talkMaxDuration = var_324_22

					if var_324_22 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_22 + var_324_15
					end
				end

				arg_321_1.text_.text = var_324_19
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031077", "story_v_out_322031.awb") ~= 0 then
					local var_324_23 = manager.audio:GetVoiceLength("story_v_out_322031", "322031077", "story_v_out_322031.awb") / 1000

					if var_324_23 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_23 + var_324_15
					end

					if var_324_18.prefab_name ~= "" and arg_321_1.actors_[var_324_18.prefab_name] ~= nil then
						local var_324_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_18.prefab_name].transform, "story_v_out_322031", "322031077", "story_v_out_322031.awb")

						arg_321_1:RecordAudio("322031077", var_324_24)
						arg_321_1:RecordAudio("322031077", var_324_24)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_322031", "322031077", "story_v_out_322031.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_322031", "322031077", "story_v_out_322031.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_25 = math.max(var_324_16, arg_321_1.talkMaxDuration)

			if var_324_15 <= arg_321_1.time_ and arg_321_1.time_ < var_324_15 + var_324_25 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_15) / var_324_25

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_15 + var_324_25 and arg_321_1.time_ < var_324_15 + var_324_25 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play322031078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 322031078
		arg_325_1.duration_ = 7.73

		local var_325_0 = {
			zh = 4.666,
			ja = 7.733
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play322031079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 0.65

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_2 = arg_325_1:FormatText(StoryNameCfg[1031].name)

				arg_325_1.leftNameTxt_.text = var_328_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_3 = arg_325_1:GetWordFromCfg(322031078)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 26
				local var_328_6 = utf8.len(var_328_4)
				local var_328_7 = var_328_5 <= 0 and var_328_1 or var_328_1 * (var_328_6 / var_328_5)

				if var_328_7 > 0 and var_328_1 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031078", "story_v_out_322031.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_out_322031", "322031078", "story_v_out_322031.awb") / 1000

					if var_328_8 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_0
					end

					if var_328_3.prefab_name ~= "" and arg_325_1.actors_[var_328_3.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_3.prefab_name].transform, "story_v_out_322031", "322031078", "story_v_out_322031.awb")

						arg_325_1:RecordAudio("322031078", var_328_9)
						arg_325_1:RecordAudio("322031078", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_322031", "322031078", "story_v_out_322031.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_322031", "322031078", "story_v_out_322031.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_10 and arg_325_1.time_ < var_328_0 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play322031079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 322031079
		arg_329_1.duration_ = 8.93

		local var_329_0 = {
			zh = 5.766,
			ja = 8.933
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play322031080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_332_2 = 0
			local var_332_3 = 0.75

			if var_332_2 < arg_329_1.time_ and arg_329_1.time_ <= var_332_2 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_4 = arg_329_1:FormatText(StoryNameCfg[1031].name)

				arg_329_1.leftNameTxt_.text = var_332_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_5 = arg_329_1:GetWordFromCfg(322031079)
				local var_332_6 = arg_329_1:FormatText(var_332_5.content)

				arg_329_1.text_.text = var_332_6

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_7 = 28
				local var_332_8 = utf8.len(var_332_6)
				local var_332_9 = var_332_7 <= 0 and var_332_3 or var_332_3 * (var_332_8 / var_332_7)

				if var_332_9 > 0 and var_332_3 < var_332_9 then
					arg_329_1.talkMaxDuration = var_332_9

					if var_332_9 + var_332_2 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_9 + var_332_2
					end
				end

				arg_329_1.text_.text = var_332_6
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031079", "story_v_out_322031.awb") ~= 0 then
					local var_332_10 = manager.audio:GetVoiceLength("story_v_out_322031", "322031079", "story_v_out_322031.awb") / 1000

					if var_332_10 + var_332_2 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_2
					end

					if var_332_5.prefab_name ~= "" and arg_329_1.actors_[var_332_5.prefab_name] ~= nil then
						local var_332_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_5.prefab_name].transform, "story_v_out_322031", "322031079", "story_v_out_322031.awb")

						arg_329_1:RecordAudio("322031079", var_332_11)
						arg_329_1:RecordAudio("322031079", var_332_11)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_322031", "322031079", "story_v_out_322031.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_322031", "322031079", "story_v_out_322031.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_12 = math.max(var_332_3, arg_329_1.talkMaxDuration)

			if var_332_2 <= arg_329_1.time_ and arg_329_1.time_ < var_332_2 + var_332_12 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_2) / var_332_12

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_2 + var_332_12 and arg_329_1.time_ < var_332_2 + var_332_12 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play322031080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 322031080
		arg_333_1.duration_ = 3.67

		local var_333_0 = {
			zh = 2.366,
			ja = 3.666
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play322031081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1284ui_story"].transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.moveOldPos1284ui_story = var_336_0.localPosition
			end

			local var_336_2 = 0.001

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2
				local var_336_4 = Vector3.New(-0.7, -0.985, -6.22)

				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1284ui_story, var_336_4, var_336_3)

				local var_336_5 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_5.x, var_336_5.y, var_336_5.z)

				local var_336_6 = var_336_0.localEulerAngles

				var_336_6.z = 0
				var_336_6.x = 0
				var_336_0.localEulerAngles = var_336_6
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_336_7 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_7.x, var_336_7.y, var_336_7.z)

				local var_336_8 = var_336_0.localEulerAngles

				var_336_8.z = 0
				var_336_8.x = 0
				var_336_0.localEulerAngles = var_336_8
			end

			local var_336_9 = arg_333_1.actors_["1089ui_story"].transform
			local var_336_10 = 0

			if var_336_10 < arg_333_1.time_ and arg_333_1.time_ <= var_336_10 + arg_336_0 then
				arg_333_1.var_.moveOldPos1089ui_story = var_336_9.localPosition
			end

			local var_336_11 = 0.001

			if var_336_10 <= arg_333_1.time_ and arg_333_1.time_ < var_336_10 + var_336_11 then
				local var_336_12 = (arg_333_1.time_ - var_336_10) / var_336_11
				local var_336_13 = Vector3.New(0.7, -1.1, -6.17)

				var_336_9.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1089ui_story, var_336_13, var_336_12)

				local var_336_14 = manager.ui.mainCamera.transform.position - var_336_9.position

				var_336_9.forward = Vector3.New(var_336_14.x, var_336_14.y, var_336_14.z)

				local var_336_15 = var_336_9.localEulerAngles

				var_336_15.z = 0
				var_336_15.x = 0
				var_336_9.localEulerAngles = var_336_15
			end

			if arg_333_1.time_ >= var_336_10 + var_336_11 and arg_333_1.time_ < var_336_10 + var_336_11 + arg_336_0 then
				var_336_9.localPosition = Vector3.New(0.7, -1.1, -6.17)

				local var_336_16 = manager.ui.mainCamera.transform.position - var_336_9.position

				var_336_9.forward = Vector3.New(var_336_16.x, var_336_16.y, var_336_16.z)

				local var_336_17 = var_336_9.localEulerAngles

				var_336_17.z = 0
				var_336_17.x = 0
				var_336_9.localEulerAngles = var_336_17
			end

			local var_336_18 = arg_333_1.actors_["1284ui_story"]
			local var_336_19 = 0

			if var_336_19 < arg_333_1.time_ and arg_333_1.time_ <= var_336_19 + arg_336_0 and not isNil(var_336_18) and arg_333_1.var_.characterEffect1284ui_story == nil then
				arg_333_1.var_.characterEffect1284ui_story = var_336_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_20 = 0.200000002980232

			if var_336_19 <= arg_333_1.time_ and arg_333_1.time_ < var_336_19 + var_336_20 and not isNil(var_336_18) then
				local var_336_21 = (arg_333_1.time_ - var_336_19) / var_336_20

				if arg_333_1.var_.characterEffect1284ui_story and not isNil(var_336_18) then
					arg_333_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_19 + var_336_20 and arg_333_1.time_ < var_336_19 + var_336_20 + arg_336_0 and not isNil(var_336_18) and arg_333_1.var_.characterEffect1284ui_story then
				arg_333_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_336_22 = arg_333_1.actors_["1089ui_story"]
			local var_336_23 = 0

			if var_336_23 < arg_333_1.time_ and arg_333_1.time_ <= var_336_23 + arg_336_0 and not isNil(var_336_22) and arg_333_1.var_.characterEffect1089ui_story == nil then
				arg_333_1.var_.characterEffect1089ui_story = var_336_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_24 = 0.200000002980232

			if var_336_23 <= arg_333_1.time_ and arg_333_1.time_ < var_336_23 + var_336_24 and not isNil(var_336_22) then
				local var_336_25 = (arg_333_1.time_ - var_336_23) / var_336_24

				if arg_333_1.var_.characterEffect1089ui_story and not isNil(var_336_22) then
					local var_336_26 = Mathf.Lerp(0, 0.5, var_336_25)

					arg_333_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1089ui_story.fillRatio = var_336_26
				end
			end

			if arg_333_1.time_ >= var_336_23 + var_336_24 and arg_333_1.time_ < var_336_23 + var_336_24 + arg_336_0 and not isNil(var_336_22) and arg_333_1.var_.characterEffect1089ui_story then
				local var_336_27 = 0.5

				arg_333_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1089ui_story.fillRatio = var_336_27
			end

			local var_336_28 = 0

			if var_336_28 < arg_333_1.time_ and arg_333_1.time_ <= var_336_28 + arg_336_0 then
				arg_333_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			local var_336_29 = 0

			if var_336_29 < arg_333_1.time_ and arg_333_1.time_ <= var_336_29 + arg_336_0 then
				arg_333_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_336_30 = 0
			local var_336_31 = 0.325

			if var_336_30 < arg_333_1.time_ and arg_333_1.time_ <= var_336_30 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_32 = arg_333_1:FormatText(StoryNameCfg[6].name)

				arg_333_1.leftNameTxt_.text = var_336_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_33 = arg_333_1:GetWordFromCfg(322031080)
				local var_336_34 = arg_333_1:FormatText(var_336_33.content)

				arg_333_1.text_.text = var_336_34

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_35 = 13
				local var_336_36 = utf8.len(var_336_34)
				local var_336_37 = var_336_35 <= 0 and var_336_31 or var_336_31 * (var_336_36 / var_336_35)

				if var_336_37 > 0 and var_336_31 < var_336_37 then
					arg_333_1.talkMaxDuration = var_336_37

					if var_336_37 + var_336_30 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_37 + var_336_30
					end
				end

				arg_333_1.text_.text = var_336_34
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031080", "story_v_out_322031.awb") ~= 0 then
					local var_336_38 = manager.audio:GetVoiceLength("story_v_out_322031", "322031080", "story_v_out_322031.awb") / 1000

					if var_336_38 + var_336_30 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_38 + var_336_30
					end

					if var_336_33.prefab_name ~= "" and arg_333_1.actors_[var_336_33.prefab_name] ~= nil then
						local var_336_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_33.prefab_name].transform, "story_v_out_322031", "322031080", "story_v_out_322031.awb")

						arg_333_1:RecordAudio("322031080", var_336_39)
						arg_333_1:RecordAudio("322031080", var_336_39)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_322031", "322031080", "story_v_out_322031.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_322031", "322031080", "story_v_out_322031.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_40 = math.max(var_336_31, arg_333_1.talkMaxDuration)

			if var_336_30 <= arg_333_1.time_ and arg_333_1.time_ < var_336_30 + var_336_40 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_30) / var_336_40

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_30 + var_336_40 and arg_333_1.time_ < var_336_30 + var_336_40 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
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
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play322031081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 322031081
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play322031082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1284ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1284ui_story == nil then
				arg_337_1.var_.characterEffect1284ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect1284ui_story and not isNil(var_340_0) then
					local var_340_4 = Mathf.Lerp(0, 0.5, var_340_3)

					arg_337_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1284ui_story.fillRatio = var_340_4
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1284ui_story then
				local var_340_5 = 0.5

				arg_337_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1284ui_story.fillRatio = var_340_5
			end

			local var_340_6 = 0
			local var_340_7 = 0.075

			if var_340_6 < arg_337_1.time_ and arg_337_1.time_ <= var_340_6 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_8 = arg_337_1:FormatText(StoryNameCfg[7].name)

				arg_337_1.leftNameTxt_.text = var_340_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_9 = arg_337_1:GetWordFromCfg(322031081)
				local var_340_10 = arg_337_1:FormatText(var_340_9.content)

				arg_337_1.text_.text = var_340_10

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_11 = 3
				local var_340_12 = utf8.len(var_340_10)
				local var_340_13 = var_340_11 <= 0 and var_340_7 or var_340_7 * (var_340_12 / var_340_11)

				if var_340_13 > 0 and var_340_7 < var_340_13 then
					arg_337_1.talkMaxDuration = var_340_13

					if var_340_13 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_13 + var_340_6
					end
				end

				arg_337_1.text_.text = var_340_10
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_14 = math.max(var_340_7, arg_337_1.talkMaxDuration)

			if var_340_6 <= arg_337_1.time_ and arg_337_1.time_ < var_340_6 + var_340_14 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_6) / var_340_14

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_6 + var_340_14 and arg_337_1.time_ < var_340_6 + var_340_14 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play322031082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 322031082
		arg_341_1.duration_ = 2

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play322031083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1284ui_story"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1284ui_story == nil then
				arg_341_1.var_.characterEffect1284ui_story = var_344_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.characterEffect1284ui_story and not isNil(var_344_0) then
					arg_341_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1284ui_story then
				arg_341_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_344_4 = 0

			if var_344_4 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_2")
			end

			local var_344_5 = 0

			if var_344_5 < arg_341_1.time_ and arg_341_1.time_ <= var_344_5 + arg_344_0 then
				arg_341_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_344_6 = 0
			local var_344_7 = 0.05

			if var_344_6 < arg_341_1.time_ and arg_341_1.time_ <= var_344_6 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_8 = arg_341_1:FormatText(StoryNameCfg[6].name)

				arg_341_1.leftNameTxt_.text = var_344_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_9 = arg_341_1:GetWordFromCfg(322031082)
				local var_344_10 = arg_341_1:FormatText(var_344_9.content)

				arg_341_1.text_.text = var_344_10

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_11 = 2
				local var_344_12 = utf8.len(var_344_10)
				local var_344_13 = var_344_11 <= 0 and var_344_7 or var_344_7 * (var_344_12 / var_344_11)

				if var_344_13 > 0 and var_344_7 < var_344_13 then
					arg_341_1.talkMaxDuration = var_344_13

					if var_344_13 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_13 + var_344_6
					end
				end

				arg_341_1.text_.text = var_344_10
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031082", "story_v_out_322031.awb") ~= 0 then
					local var_344_14 = manager.audio:GetVoiceLength("story_v_out_322031", "322031082", "story_v_out_322031.awb") / 1000

					if var_344_14 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_14 + var_344_6
					end

					if var_344_9.prefab_name ~= "" and arg_341_1.actors_[var_344_9.prefab_name] ~= nil then
						local var_344_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_9.prefab_name].transform, "story_v_out_322031", "322031082", "story_v_out_322031.awb")

						arg_341_1:RecordAudio("322031082", var_344_15)
						arg_341_1:RecordAudio("322031082", var_344_15)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_322031", "322031082", "story_v_out_322031.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_322031", "322031082", "story_v_out_322031.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_16 = math.max(var_344_7, arg_341_1.talkMaxDuration)

			if var_344_6 <= arg_341_1.time_ and arg_341_1.time_ < var_344_6 + var_344_16 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_6) / var_344_16

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_6 + var_344_16 and arg_341_1.time_ < var_344_6 + var_344_16 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play322031083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 322031083
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play322031084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1284ui_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1284ui_story == nil then
				arg_345_1.var_.characterEffect1284ui_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect1284ui_story and not isNil(var_348_0) then
					local var_348_4 = Mathf.Lerp(0, 0.5, var_348_3)

					arg_345_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1284ui_story.fillRatio = var_348_4
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1284ui_story then
				local var_348_5 = 0.5

				arg_345_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1284ui_story.fillRatio = var_348_5
			end

			local var_348_6 = 0
			local var_348_7 = 0.825

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_8 = arg_345_1:FormatText(StoryNameCfg[7].name)

				arg_345_1.leftNameTxt_.text = var_348_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_9 = arg_345_1:GetWordFromCfg(322031083)
				local var_348_10 = arg_345_1:FormatText(var_348_9.content)

				arg_345_1.text_.text = var_348_10

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_11 = 33
				local var_348_12 = utf8.len(var_348_10)
				local var_348_13 = var_348_11 <= 0 and var_348_7 or var_348_7 * (var_348_12 / var_348_11)

				if var_348_13 > 0 and var_348_7 < var_348_13 then
					arg_345_1.talkMaxDuration = var_348_13

					if var_348_13 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_10
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_14 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_14 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_14

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_14 and arg_345_1.time_ < var_348_6 + var_348_14 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play322031084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 322031084
		arg_349_1.duration_ = 2.4

		local var_349_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play322031085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1284ui_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1284ui_story == nil then
				arg_349_1.var_.characterEffect1284ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect1284ui_story and not isNil(var_352_0) then
					arg_349_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1284ui_story then
				arg_349_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_352_4 = 0

			if var_352_4 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			local var_352_5 = 0

			if var_352_5 < arg_349_1.time_ and arg_349_1.time_ <= var_352_5 + arg_352_0 then
				arg_349_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_352_6 = 0
			local var_352_7 = 0.15

			if var_352_6 < arg_349_1.time_ and arg_349_1.time_ <= var_352_6 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_8 = arg_349_1:FormatText(StoryNameCfg[6].name)

				arg_349_1.leftNameTxt_.text = var_352_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_9 = arg_349_1:GetWordFromCfg(322031084)
				local var_352_10 = arg_349_1:FormatText(var_352_9.content)

				arg_349_1.text_.text = var_352_10

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_11 = 6
				local var_352_12 = utf8.len(var_352_10)
				local var_352_13 = var_352_11 <= 0 and var_352_7 or var_352_7 * (var_352_12 / var_352_11)

				if var_352_13 > 0 and var_352_7 < var_352_13 then
					arg_349_1.talkMaxDuration = var_352_13

					if var_352_13 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_13 + var_352_6
					end
				end

				arg_349_1.text_.text = var_352_10
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031084", "story_v_out_322031.awb") ~= 0 then
					local var_352_14 = manager.audio:GetVoiceLength("story_v_out_322031", "322031084", "story_v_out_322031.awb") / 1000

					if var_352_14 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_14 + var_352_6
					end

					if var_352_9.prefab_name ~= "" and arg_349_1.actors_[var_352_9.prefab_name] ~= nil then
						local var_352_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_9.prefab_name].transform, "story_v_out_322031", "322031084", "story_v_out_322031.awb")

						arg_349_1:RecordAudio("322031084", var_352_15)
						arg_349_1:RecordAudio("322031084", var_352_15)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_322031", "322031084", "story_v_out_322031.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_322031", "322031084", "story_v_out_322031.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_16 = math.max(var_352_7, arg_349_1.talkMaxDuration)

			if var_352_6 <= arg_349_1.time_ and arg_349_1.time_ < var_352_6 + var_352_16 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_6) / var_352_16

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_6 + var_352_16 and arg_349_1.time_ < var_352_6 + var_352_16 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play322031085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 322031085
		arg_353_1.duration_ = 5.97

		local var_353_0 = {
			zh = 5.966,
			ja = 5.9
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play322031086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = "STblack"

			if arg_353_1.bgs_[var_356_0] == nil then
				local var_356_1 = Object.Instantiate(arg_353_1.paintGo_)

				var_356_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_356_0)
				var_356_1.name = var_356_0
				var_356_1.transform.parent = arg_353_1.stage_.transform
				var_356_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_353_1.bgs_[var_356_0] = var_356_1
			end

			local var_356_2 = 2

			if var_356_2 < arg_353_1.time_ and arg_353_1.time_ <= var_356_2 + arg_356_0 then
				local var_356_3 = manager.ui.mainCamera.transform.localPosition
				local var_356_4 = Vector3.New(0, 0, 10) + Vector3.New(var_356_3.x, var_356_3.y, 0)
				local var_356_5 = arg_353_1.bgs_.STblack

				var_356_5.transform.localPosition = var_356_4
				var_356_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_356_6 = var_356_5:GetComponent("SpriteRenderer")

				if var_356_6 and var_356_6.sprite then
					local var_356_7 = (var_356_5.transform.localPosition - var_356_3).z
					local var_356_8 = manager.ui.mainCameraCom_
					local var_356_9 = 2 * var_356_7 * Mathf.Tan(var_356_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_356_10 = var_356_9 * var_356_8.aspect
					local var_356_11 = var_356_6.sprite.bounds.size.x
					local var_356_12 = var_356_6.sprite.bounds.size.y
					local var_356_13 = var_356_10 / var_356_11
					local var_356_14 = var_356_9 / var_356_12
					local var_356_15 = var_356_14 < var_356_13 and var_356_13 or var_356_14

					var_356_5.transform.localScale = Vector3.New(var_356_15, var_356_15, 0)
				end

				for iter_356_0, iter_356_1 in pairs(arg_353_1.bgs_) do
					if iter_356_0 ~= "STblack" then
						iter_356_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_356_16 = 4

			if var_356_16 < arg_353_1.time_ and arg_353_1.time_ <= var_356_16 + arg_356_0 then
				arg_353_1.allBtn_.enabled = false
			end

			local var_356_17 = 0.3

			if arg_353_1.time_ >= var_356_16 + var_356_17 and arg_353_1.time_ < var_356_16 + var_356_17 + arg_356_0 then
				arg_353_1.allBtn_.enabled = true
			end

			local var_356_18 = 0

			if var_356_18 < arg_353_1.time_ and arg_353_1.time_ <= var_356_18 + arg_356_0 then
				arg_353_1.mask_.enabled = true
				arg_353_1.mask_.raycastTarget = true

				arg_353_1:SetGaussion(false)
			end

			local var_356_19 = 2

			if var_356_18 <= arg_353_1.time_ and arg_353_1.time_ < var_356_18 + var_356_19 then
				local var_356_20 = (arg_353_1.time_ - var_356_18) / var_356_19
				local var_356_21 = Color.New(0, 0, 0)

				var_356_21.a = Mathf.Lerp(0, 1, var_356_20)
				arg_353_1.mask_.color = var_356_21
			end

			if arg_353_1.time_ >= var_356_18 + var_356_19 and arg_353_1.time_ < var_356_18 + var_356_19 + arg_356_0 then
				local var_356_22 = Color.New(0, 0, 0)

				var_356_22.a = 1
				arg_353_1.mask_.color = var_356_22
			end

			local var_356_23 = 2

			if var_356_23 < arg_353_1.time_ and arg_353_1.time_ <= var_356_23 + arg_356_0 then
				arg_353_1.mask_.enabled = true
				arg_353_1.mask_.raycastTarget = true

				arg_353_1:SetGaussion(false)
			end

			local var_356_24 = 2

			if var_356_23 <= arg_353_1.time_ and arg_353_1.time_ < var_356_23 + var_356_24 then
				local var_356_25 = (arg_353_1.time_ - var_356_23) / var_356_24
				local var_356_26 = Color.New(0, 0, 0)

				var_356_26.a = Mathf.Lerp(1, 0, var_356_25)
				arg_353_1.mask_.color = var_356_26
			end

			if arg_353_1.time_ >= var_356_23 + var_356_24 and arg_353_1.time_ < var_356_23 + var_356_24 + arg_356_0 then
				local var_356_27 = Color.New(0, 0, 0)
				local var_356_28 = 0

				arg_353_1.mask_.enabled = false
				var_356_27.a = var_356_28
				arg_353_1.mask_.color = var_356_27
			end

			local var_356_29 = arg_353_1.actors_["1089ui_story"].transform
			local var_356_30 = 1.96599999815226

			if var_356_30 < arg_353_1.time_ and arg_353_1.time_ <= var_356_30 + arg_356_0 then
				arg_353_1.var_.moveOldPos1089ui_story = var_356_29.localPosition
			end

			local var_356_31 = 0.001

			if var_356_30 <= arg_353_1.time_ and arg_353_1.time_ < var_356_30 + var_356_31 then
				local var_356_32 = (arg_353_1.time_ - var_356_30) / var_356_31
				local var_356_33 = Vector3.New(0, 100, 0)

				var_356_29.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1089ui_story, var_356_33, var_356_32)

				local var_356_34 = manager.ui.mainCamera.transform.position - var_356_29.position

				var_356_29.forward = Vector3.New(var_356_34.x, var_356_34.y, var_356_34.z)

				local var_356_35 = var_356_29.localEulerAngles

				var_356_35.z = 0
				var_356_35.x = 0
				var_356_29.localEulerAngles = var_356_35
			end

			if arg_353_1.time_ >= var_356_30 + var_356_31 and arg_353_1.time_ < var_356_30 + var_356_31 + arg_356_0 then
				var_356_29.localPosition = Vector3.New(0, 100, 0)

				local var_356_36 = manager.ui.mainCamera.transform.position - var_356_29.position

				var_356_29.forward = Vector3.New(var_356_36.x, var_356_36.y, var_356_36.z)

				local var_356_37 = var_356_29.localEulerAngles

				var_356_37.z = 0
				var_356_37.x = 0
				var_356_29.localEulerAngles = var_356_37
			end

			local var_356_38 = arg_353_1.actors_["1284ui_story"].transform
			local var_356_39 = 1.96599999815226

			if var_356_39 < arg_353_1.time_ and arg_353_1.time_ <= var_356_39 + arg_356_0 then
				arg_353_1.var_.moveOldPos1284ui_story = var_356_38.localPosition
			end

			local var_356_40 = 0.001

			if var_356_39 <= arg_353_1.time_ and arg_353_1.time_ < var_356_39 + var_356_40 then
				local var_356_41 = (arg_353_1.time_ - var_356_39) / var_356_40
				local var_356_42 = Vector3.New(0, 100, 0)

				var_356_38.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1284ui_story, var_356_42, var_356_41)

				local var_356_43 = manager.ui.mainCamera.transform.position - var_356_38.position

				var_356_38.forward = Vector3.New(var_356_43.x, var_356_43.y, var_356_43.z)

				local var_356_44 = var_356_38.localEulerAngles

				var_356_44.z = 0
				var_356_44.x = 0
				var_356_38.localEulerAngles = var_356_44
			end

			if arg_353_1.time_ >= var_356_39 + var_356_40 and arg_353_1.time_ < var_356_39 + var_356_40 + arg_356_0 then
				var_356_38.localPosition = Vector3.New(0, 100, 0)

				local var_356_45 = manager.ui.mainCamera.transform.position - var_356_38.position

				var_356_38.forward = Vector3.New(var_356_45.x, var_356_45.y, var_356_45.z)

				local var_356_46 = var_356_38.localEulerAngles

				var_356_46.z = 0
				var_356_46.x = 0
				var_356_38.localEulerAngles = var_356_46
			end

			local var_356_47 = arg_353_1.actors_["1284ui_story"]
			local var_356_48 = 1.98333333333333

			if var_356_48 < arg_353_1.time_ and arg_353_1.time_ <= var_356_48 + arg_356_0 and not isNil(var_356_47) and arg_353_1.var_.characterEffect1284ui_story == nil then
				arg_353_1.var_.characterEffect1284ui_story = var_356_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_49 = 0.0166666666666667

			if var_356_48 <= arg_353_1.time_ and arg_353_1.time_ < var_356_48 + var_356_49 and not isNil(var_356_47) then
				local var_356_50 = (arg_353_1.time_ - var_356_48) / var_356_49

				if arg_353_1.var_.characterEffect1284ui_story and not isNil(var_356_47) then
					local var_356_51 = Mathf.Lerp(0, 0.5, var_356_50)

					arg_353_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1284ui_story.fillRatio = var_356_51
				end
			end

			if arg_353_1.time_ >= var_356_48 + var_356_49 and arg_353_1.time_ < var_356_48 + var_356_49 + arg_356_0 and not isNil(var_356_47) and arg_353_1.var_.characterEffect1284ui_story then
				local var_356_52 = 0.5

				arg_353_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1284ui_story.fillRatio = var_356_52
			end

			local var_356_53 = 3
			local var_356_54 = 1

			if var_356_53 < arg_353_1.time_ and arg_353_1.time_ <= var_356_53 + arg_356_0 then
				local var_356_55 = "play"
				local var_356_56 = "effect"

				arg_353_1:AudioAction(var_356_55, var_356_56, "se_story_141", "se_story_141_footstep_upstairs", "")
			end

			local var_356_57 = 0.166666666666667
			local var_356_58 = 0.3

			if var_356_57 < arg_353_1.time_ and arg_353_1.time_ <= var_356_57 + arg_356_0 then
				local var_356_59 = "play"
				local var_356_60 = "music"

				arg_353_1:AudioAction(var_356_59, var_356_60, "ui_battle", "ui_battle_stopbgm", "")

				local var_356_61 = ""
				local var_356_62 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_356_62 ~= "" then
					if arg_353_1.bgmTxt_.text ~= var_356_62 and arg_353_1.bgmTxt_.text ~= "" then
						if arg_353_1.bgmTxt2_.text ~= "" then
							arg_353_1.bgmTxt_.text = arg_353_1.bgmTxt2_.text
						end

						arg_353_1.bgmTxt2_.text = var_356_62

						arg_353_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_353_1.bgmTxt_.text = var_356_62
						arg_353_1.bgmTxt2_.text = var_356_62
					end

					if arg_353_1.bgmTimer then
						arg_353_1.bgmTimer:Stop()

						arg_353_1.bgmTimer = nil
					end

					if arg_353_1.settingData.show_music_name == 1 then
						arg_353_1.musicController:SetSelectedState("show")
						arg_353_1.musicAnimator_:Play("open", 0, 0)

						if arg_353_1.settingData.music_time ~= 0 then
							arg_353_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_353_1.settingData.music_time), function()
								if arg_353_1 == nil or isNil(arg_353_1.bgmTxt_) then
									return
								end

								arg_353_1.musicController:SetSelectedState("hide")
								arg_353_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_353_1.frameCnt_ <= 1 then
				arg_353_1.dialog_:SetActive(false)
			end

			local var_356_63 = 4
			local var_356_64 = 0.125

			if var_356_63 < arg_353_1.time_ and arg_353_1.time_ <= var_356_63 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0

				arg_353_1.dialog_:SetActive(true)

				arg_353_1.dialogCg_.alpha = 0

				local var_356_65 = LeanTween.value(arg_353_1.dialog_, 0, 1, 0.3)

				var_356_65:setOnUpdate(LuaHelper.FloatAction(function(arg_358_0)
					arg_353_1.dialogCg_.alpha = arg_358_0
				end))
				var_356_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_353_1.dialog_)
					var_356_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_353_1.duration_ = arg_353_1.duration_ + 0.3

				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_66 = arg_353_1:FormatText(StoryNameCfg[1031].name)

				arg_353_1.leftNameTxt_.text = var_356_66

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_67 = arg_353_1:GetWordFromCfg(322031085)
				local var_356_68 = arg_353_1:FormatText(var_356_67.content)

				arg_353_1.text_.text = var_356_68

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_69 = 5
				local var_356_70 = utf8.len(var_356_68)
				local var_356_71 = var_356_69 <= 0 and var_356_64 or var_356_64 * (var_356_70 / var_356_69)

				if var_356_71 > 0 and var_356_64 < var_356_71 then
					arg_353_1.talkMaxDuration = var_356_71
					var_356_63 = var_356_63 + 0.3

					if var_356_71 + var_356_63 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_71 + var_356_63
					end
				end

				arg_353_1.text_.text = var_356_68
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031085", "story_v_out_322031.awb") ~= 0 then
					local var_356_72 = manager.audio:GetVoiceLength("story_v_out_322031", "322031085", "story_v_out_322031.awb") / 1000

					if var_356_72 + var_356_63 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_72 + var_356_63
					end

					if var_356_67.prefab_name ~= "" and arg_353_1.actors_[var_356_67.prefab_name] ~= nil then
						local var_356_73 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_67.prefab_name].transform, "story_v_out_322031", "322031085", "story_v_out_322031.awb")

						arg_353_1:RecordAudio("322031085", var_356_73)
						arg_353_1:RecordAudio("322031085", var_356_73)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_322031", "322031085", "story_v_out_322031.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_322031", "322031085", "story_v_out_322031.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_74 = var_356_63 + 0.3
			local var_356_75 = math.max(var_356_64, arg_353_1.talkMaxDuration)

			if var_356_74 <= arg_353_1.time_ and arg_353_1.time_ < var_356_74 + var_356_75 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_74) / var_356_75

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_74 + var_356_75 and arg_353_1.time_ < var_356_74 + var_356_75 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play322031086 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 322031086
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play322031087(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 0.075

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_2 = arg_360_1:FormatText(StoryNameCfg[7].name)

				arg_360_1.leftNameTxt_.text = var_363_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_3 = arg_360_1:GetWordFromCfg(322031086)
				local var_363_4 = arg_360_1:FormatText(var_363_3.content)

				arg_360_1.text_.text = var_363_4

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 3
				local var_363_6 = utf8.len(var_363_4)
				local var_363_7 = var_363_5 <= 0 and var_363_1 or var_363_1 * (var_363_6 / var_363_5)

				if var_363_7 > 0 and var_363_1 < var_363_7 then
					arg_360_1.talkMaxDuration = var_363_7

					if var_363_7 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_4
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_8 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_8 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_8

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_8 and arg_360_1.time_ < var_363_0 + var_363_8 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play322031087 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 322031087
		arg_364_1.duration_ = 2.5

		local var_364_0 = {
			zh = 1.533,
			ja = 2.5
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
				arg_364_0:Play322031088(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 0.125

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_2 = arg_364_1:FormatText(StoryNameCfg[1031].name)

				arg_364_1.leftNameTxt_.text = var_367_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_3 = arg_364_1:GetWordFromCfg(322031087)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031087", "story_v_out_322031.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_out_322031", "322031087", "story_v_out_322031.awb") / 1000

					if var_367_8 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_0
					end

					if var_367_3.prefab_name ~= "" and arg_364_1.actors_[var_367_3.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_3.prefab_name].transform, "story_v_out_322031", "322031087", "story_v_out_322031.awb")

						arg_364_1:RecordAudio("322031087", var_367_9)
						arg_364_1:RecordAudio("322031087", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_322031", "322031087", "story_v_out_322031.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_322031", "322031087", "story_v_out_322031.awb")
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
	Play322031088 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 322031088
		arg_368_1.duration_ = 7

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play322031089(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = "ST0510"

			if arg_368_1.bgs_[var_371_0] == nil then
				local var_371_1 = Object.Instantiate(arg_368_1.paintGo_)

				var_371_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_371_0)
				var_371_1.name = var_371_0
				var_371_1.transform.parent = arg_368_1.stage_.transform
				var_371_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_368_1.bgs_[var_371_0] = var_371_1
			end

			local var_371_2 = 0

			if var_371_2 < arg_368_1.time_ and arg_368_1.time_ <= var_371_2 + arg_371_0 then
				local var_371_3 = manager.ui.mainCamera.transform.localPosition
				local var_371_4 = Vector3.New(0, 0, 10) + Vector3.New(var_371_3.x, var_371_3.y, 0)
				local var_371_5 = arg_368_1.bgs_.ST0510

				var_371_5.transform.localPosition = var_371_4
				var_371_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_371_6 = var_371_5:GetComponent("SpriteRenderer")

				if var_371_6 and var_371_6.sprite then
					local var_371_7 = (var_371_5.transform.localPosition - var_371_3).z
					local var_371_8 = manager.ui.mainCameraCom_
					local var_371_9 = 2 * var_371_7 * Mathf.Tan(var_371_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_371_10 = var_371_9 * var_371_8.aspect
					local var_371_11 = var_371_6.sprite.bounds.size.x
					local var_371_12 = var_371_6.sprite.bounds.size.y
					local var_371_13 = var_371_10 / var_371_11
					local var_371_14 = var_371_9 / var_371_12
					local var_371_15 = var_371_14 < var_371_13 and var_371_13 or var_371_14

					var_371_5.transform.localScale = Vector3.New(var_371_15, var_371_15, 0)
				end

				for iter_371_0, iter_371_1 in pairs(arg_368_1.bgs_) do
					if iter_371_0 ~= "ST0510" then
						iter_371_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_371_16 = 2

			if var_371_16 < arg_368_1.time_ and arg_368_1.time_ <= var_371_16 + arg_371_0 then
				arg_368_1.allBtn_.enabled = false
			end

			local var_371_17 = 0.3

			if arg_368_1.time_ >= var_371_16 + var_371_17 and arg_368_1.time_ < var_371_16 + var_371_17 + arg_371_0 then
				arg_368_1.allBtn_.enabled = true
			end

			local var_371_18 = 0

			if var_371_18 < arg_368_1.time_ and arg_368_1.time_ <= var_371_18 + arg_371_0 then
				arg_368_1.mask_.enabled = true
				arg_368_1.mask_.raycastTarget = true

				arg_368_1:SetGaussion(false)
			end

			local var_371_19 = 2

			if var_371_18 <= arg_368_1.time_ and arg_368_1.time_ < var_371_18 + var_371_19 then
				local var_371_20 = (arg_368_1.time_ - var_371_18) / var_371_19
				local var_371_21 = Color.New(0, 0, 0)

				var_371_21.a = Mathf.Lerp(1, 0, var_371_20)
				arg_368_1.mask_.color = var_371_21
			end

			if arg_368_1.time_ >= var_371_18 + var_371_19 and arg_368_1.time_ < var_371_18 + var_371_19 + arg_371_0 then
				local var_371_22 = Color.New(0, 0, 0)
				local var_371_23 = 0

				arg_368_1.mask_.enabled = false
				var_371_22.a = var_371_23
				arg_368_1.mask_.color = var_371_22
			end

			local var_371_24 = 0
			local var_371_25 = 0.3

			if var_371_24 < arg_368_1.time_ and arg_368_1.time_ <= var_371_24 + arg_371_0 then
				local var_371_26 = "play"
				local var_371_27 = "music"

				arg_368_1:AudioAction(var_371_26, var_371_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_371_28 = ""
				local var_371_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_371_29 ~= "" then
					if arg_368_1.bgmTxt_.text ~= var_371_29 and arg_368_1.bgmTxt_.text ~= "" then
						if arg_368_1.bgmTxt2_.text ~= "" then
							arg_368_1.bgmTxt_.text = arg_368_1.bgmTxt2_.text
						end

						arg_368_1.bgmTxt2_.text = var_371_29

						arg_368_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_368_1.bgmTxt_.text = var_371_29
						arg_368_1.bgmTxt2_.text = var_371_29
					end

					if arg_368_1.bgmTimer then
						arg_368_1.bgmTimer:Stop()

						arg_368_1.bgmTimer = nil
					end

					if arg_368_1.settingData.show_music_name == 1 then
						arg_368_1.musicController:SetSelectedState("show")
						arg_368_1.musicAnimator_:Play("open", 0, 0)

						if arg_368_1.settingData.music_time ~= 0 then
							arg_368_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_368_1.settingData.music_time), function()
								if arg_368_1 == nil or isNil(arg_368_1.bgmTxt_) then
									return
								end

								arg_368_1.musicController:SetSelectedState("hide")
								arg_368_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_371_30 = 0.433333333333333
			local var_371_31 = 1

			if var_371_30 < arg_368_1.time_ and arg_368_1.time_ <= var_371_30 + arg_371_0 then
				local var_371_32 = "play"
				local var_371_33 = "music"

				arg_368_1:AudioAction(var_371_32, var_371_33, "bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab.awb")

				local var_371_34 = ""
				local var_371_35 = manager.audio:GetAudioName("bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab")

				if var_371_35 ~= "" then
					if arg_368_1.bgmTxt_.text ~= var_371_35 and arg_368_1.bgmTxt_.text ~= "" then
						if arg_368_1.bgmTxt2_.text ~= "" then
							arg_368_1.bgmTxt_.text = arg_368_1.bgmTxt2_.text
						end

						arg_368_1.bgmTxt2_.text = var_371_35

						arg_368_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_368_1.bgmTxt_.text = var_371_35
						arg_368_1.bgmTxt2_.text = var_371_35
					end

					if arg_368_1.bgmTimer then
						arg_368_1.bgmTimer:Stop()

						arg_368_1.bgmTimer = nil
					end

					if arg_368_1.settingData.show_music_name == 1 then
						arg_368_1.musicController:SetSelectedState("show")
						arg_368_1.musicAnimator_:Play("open", 0, 0)

						if arg_368_1.settingData.music_time ~= 0 then
							arg_368_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_368_1.settingData.music_time), function()
								if arg_368_1 == nil or isNil(arg_368_1.bgmTxt_) then
									return
								end

								arg_368_1.musicController:SetSelectedState("hide")
								arg_368_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_371_36 = 0.1
			local var_371_37 = 1

			if var_371_36 < arg_368_1.time_ and arg_368_1.time_ <= var_371_36 + arg_371_0 then
				local var_371_38 = "stop"
				local var_371_39 = "effect"

				arg_368_1:AudioAction(var_371_38, var_371_39, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			local var_371_40 = 0.3
			local var_371_41 = 1

			if var_371_40 < arg_368_1.time_ and arg_368_1.time_ <= var_371_40 + arg_371_0 then
				local var_371_42 = "play"
				local var_371_43 = "effect"

				arg_368_1:AudioAction(var_371_42, var_371_43, "se_story_145", "se_story_145_amb_data", "")
			end

			local var_371_44 = 0.2
			local var_371_45 = 1

			if var_371_44 < arg_368_1.time_ and arg_368_1.time_ <= var_371_44 + arg_371_0 then
				local var_371_46 = "play"
				local var_371_47 = "effect"

				arg_368_1:AudioAction(var_371_46, var_371_47, "se_story_145", "se_story_145_door", "")
			end

			local var_371_48 = 2.3
			local var_371_49 = 1

			if var_371_48 < arg_368_1.time_ and arg_368_1.time_ <= var_371_48 + arg_371_0 then
				local var_371_50 = "play"
				local var_371_51 = "effect"

				arg_368_1:AudioAction(var_371_50, var_371_51, "se_story_1311", "se_story_1311_uav02", "")
			end

			if arg_368_1.frameCnt_ <= 1 then
				arg_368_1.dialog_:SetActive(false)
			end

			local var_371_52 = 2
			local var_371_53 = 1.15

			if var_371_52 < arg_368_1.time_ and arg_368_1.time_ <= var_371_52 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0

				arg_368_1.dialog_:SetActive(true)

				arg_368_1.dialogCg_.alpha = 0

				local var_371_54 = LeanTween.value(arg_368_1.dialog_, 0, 1, 0.3)

				var_371_54:setOnUpdate(LuaHelper.FloatAction(function(arg_374_0)
					arg_368_1.dialogCg_.alpha = arg_374_0
				end))
				var_371_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_368_1.dialog_)
					var_371_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_368_1.duration_ = arg_368_1.duration_ + 0.3

				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_55 = arg_368_1:GetWordFromCfg(322031088)
				local var_371_56 = arg_368_1:FormatText(var_371_55.content)

				arg_368_1.text_.text = var_371_56

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_57 = 46
				local var_371_58 = utf8.len(var_371_56)
				local var_371_59 = var_371_57 <= 0 and var_371_53 or var_371_53 * (var_371_58 / var_371_57)

				if var_371_59 > 0 and var_371_53 < var_371_59 then
					arg_368_1.talkMaxDuration = var_371_59
					var_371_52 = var_371_52 + 0.3

					if var_371_59 + var_371_52 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_59 + var_371_52
					end
				end

				arg_368_1.text_.text = var_371_56
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_60 = var_371_52 + 0.3
			local var_371_61 = math.max(var_371_53, arg_368_1.talkMaxDuration)

			if var_371_60 <= arg_368_1.time_ and arg_368_1.time_ < var_371_60 + var_371_61 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_60) / var_371_61

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_60 + var_371_61 and arg_368_1.time_ < var_371_60 + var_371_61 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play322031089 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 322031089
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play322031090(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0
			local var_379_1 = 0.85

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_2 = arg_376_1:GetWordFromCfg(322031089)
				local var_379_3 = arg_376_1:FormatText(var_379_2.content)

				arg_376_1.text_.text = var_379_3

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_4 = 34
				local var_379_5 = utf8.len(var_379_3)
				local var_379_6 = var_379_4 <= 0 and var_379_1 or var_379_1 * (var_379_5 / var_379_4)

				if var_379_6 > 0 and var_379_1 < var_379_6 then
					arg_376_1.talkMaxDuration = var_379_6

					if var_379_6 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_6 + var_379_0
					end
				end

				arg_376_1.text_.text = var_379_3
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_7 = math.max(var_379_1, arg_376_1.talkMaxDuration)

			if var_379_0 <= arg_376_1.time_ and arg_376_1.time_ < var_379_0 + var_379_7 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_0) / var_379_7

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_0 + var_379_7 and arg_376_1.time_ < var_379_0 + var_379_7 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play322031090 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 322031090
		arg_380_1.duration_ = 13.87

		local var_380_0 = {
			zh = 9.833,
			ja = 13.866
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play322031091(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["1089ui_story"].transform
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.var_.moveOldPos1089ui_story = var_383_0.localPosition
			end

			local var_383_2 = 0.001

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2
				local var_383_4 = Vector3.New(0, -1.1, -6.17)

				var_383_0.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1089ui_story, var_383_4, var_383_3)

				local var_383_5 = manager.ui.mainCamera.transform.position - var_383_0.position

				var_383_0.forward = Vector3.New(var_383_5.x, var_383_5.y, var_383_5.z)

				local var_383_6 = var_383_0.localEulerAngles

				var_383_6.z = 0
				var_383_6.x = 0
				var_383_0.localEulerAngles = var_383_6
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 then
				var_383_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_383_7 = manager.ui.mainCamera.transform.position - var_383_0.position

				var_383_0.forward = Vector3.New(var_383_7.x, var_383_7.y, var_383_7.z)

				local var_383_8 = var_383_0.localEulerAngles

				var_383_8.z = 0
				var_383_8.x = 0
				var_383_0.localEulerAngles = var_383_8
			end

			local var_383_9 = arg_380_1.actors_["1089ui_story"]
			local var_383_10 = 0

			if var_383_10 < arg_380_1.time_ and arg_380_1.time_ <= var_383_10 + arg_383_0 and not isNil(var_383_9) and arg_380_1.var_.characterEffect1089ui_story == nil then
				arg_380_1.var_.characterEffect1089ui_story = var_383_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_11 = 0.200000002980232

			if var_383_10 <= arg_380_1.time_ and arg_380_1.time_ < var_383_10 + var_383_11 and not isNil(var_383_9) then
				local var_383_12 = (arg_380_1.time_ - var_383_10) / var_383_11

				if arg_380_1.var_.characterEffect1089ui_story and not isNil(var_383_9) then
					arg_380_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= var_383_10 + var_383_11 and arg_380_1.time_ < var_383_10 + var_383_11 + arg_383_0 and not isNil(var_383_9) and arg_380_1.var_.characterEffect1089ui_story then
				arg_380_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_383_13 = 0

			if var_383_13 < arg_380_1.time_ and arg_380_1.time_ <= var_383_13 + arg_383_0 then
				arg_380_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_383_14 = 0

			if var_383_14 < arg_380_1.time_ and arg_380_1.time_ <= var_383_14 + arg_383_0 then
				arg_380_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_383_15 = 0
			local var_383_16 = 1.075

			if var_383_15 < arg_380_1.time_ and arg_380_1.time_ <= var_383_15 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_17 = arg_380_1:FormatText(StoryNameCfg[1031].name)

				arg_380_1.leftNameTxt_.text = var_383_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_18 = arg_380_1:GetWordFromCfg(322031090)
				local var_383_19 = arg_380_1:FormatText(var_383_18.content)

				arg_380_1.text_.text = var_383_19

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_20 = 43
				local var_383_21 = utf8.len(var_383_19)
				local var_383_22 = var_383_20 <= 0 and var_383_16 or var_383_16 * (var_383_21 / var_383_20)

				if var_383_22 > 0 and var_383_16 < var_383_22 then
					arg_380_1.talkMaxDuration = var_383_22

					if var_383_22 + var_383_15 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_22 + var_383_15
					end
				end

				arg_380_1.text_.text = var_383_19
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031090", "story_v_out_322031.awb") ~= 0 then
					local var_383_23 = manager.audio:GetVoiceLength("story_v_out_322031", "322031090", "story_v_out_322031.awb") / 1000

					if var_383_23 + var_383_15 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_23 + var_383_15
					end

					if var_383_18.prefab_name ~= "" and arg_380_1.actors_[var_383_18.prefab_name] ~= nil then
						local var_383_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_18.prefab_name].transform, "story_v_out_322031", "322031090", "story_v_out_322031.awb")

						arg_380_1:RecordAudio("322031090", var_383_24)
						arg_380_1:RecordAudio("322031090", var_383_24)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_322031", "322031090", "story_v_out_322031.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_322031", "322031090", "story_v_out_322031.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_25 = math.max(var_383_16, arg_380_1.talkMaxDuration)

			if var_383_15 <= arg_380_1.time_ and arg_380_1.time_ < var_383_15 + var_383_25 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_15) / var_383_25

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_15 + var_383_25 and arg_380_1.time_ < var_383_15 + var_383_25 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play322031091 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 322031091
		arg_384_1.duration_ = 1

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"

			SetActive(arg_384_1.choicesGo_, true)

			for iter_385_0, iter_385_1 in ipairs(arg_384_1.choices_) do
				local var_385_0 = iter_385_0 <= 2

				SetActive(iter_385_1.go, var_385_0)
			end

			arg_384_1.choices_[1].txt.text = arg_384_1:FormatText(StoryChoiceCfg[1404].name)
			arg_384_1.choices_[2].txt.text = arg_384_1:FormatText(StoryChoiceCfg[1405].name)
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play322031092(arg_384_1)
			end

			if arg_386_0 == 2 then
				arg_384_0:Play322031093(arg_384_1)
			end

			arg_384_1:RecordChoiceLog(322031091, 1404, 1405)
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["1089ui_story"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect1089ui_story == nil then
				arg_384_1.var_.characterEffect1089ui_story = var_387_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.200000002980232

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.characterEffect1089ui_story and not isNil(var_387_0) then
					local var_387_4 = Mathf.Lerp(0, 0.5, var_387_3)

					arg_384_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_384_1.var_.characterEffect1089ui_story.fillRatio = var_387_4
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect1089ui_story then
				local var_387_5 = 0.5

				arg_384_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_384_1.var_.characterEffect1089ui_story.fillRatio = var_387_5
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play322031092 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 322031092
		arg_388_1.duration_ = 5.57

		local var_388_0 = {
			zh = 2.8,
			ja = 5.566
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
				arg_388_0:Play322031095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["1089ui_story"].transform
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.var_.moveOldPos1089ui_story = var_391_0.localPosition
			end

			local var_391_2 = 0.001

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2
				local var_391_4 = Vector3.New(0, -1.1, -6.17)

				var_391_0.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1089ui_story, var_391_4, var_391_3)

				local var_391_5 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_5.x, var_391_5.y, var_391_5.z)

				local var_391_6 = var_391_0.localEulerAngles

				var_391_6.z = 0
				var_391_6.x = 0
				var_391_0.localEulerAngles = var_391_6
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 then
				var_391_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_391_7 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_7.x, var_391_7.y, var_391_7.z)

				local var_391_8 = var_391_0.localEulerAngles

				var_391_8.z = 0
				var_391_8.x = 0
				var_391_0.localEulerAngles = var_391_8
			end

			local var_391_9 = arg_388_1.actors_["1089ui_story"]
			local var_391_10 = 0

			if var_391_10 < arg_388_1.time_ and arg_388_1.time_ <= var_391_10 + arg_391_0 and not isNil(var_391_9) and arg_388_1.var_.characterEffect1089ui_story == nil then
				arg_388_1.var_.characterEffect1089ui_story = var_391_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_11 = 0.200000002980232

			if var_391_10 <= arg_388_1.time_ and arg_388_1.time_ < var_391_10 + var_391_11 and not isNil(var_391_9) then
				local var_391_12 = (arg_388_1.time_ - var_391_10) / var_391_11

				if arg_388_1.var_.characterEffect1089ui_story and not isNil(var_391_9) then
					arg_388_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= var_391_10 + var_391_11 and arg_388_1.time_ < var_391_10 + var_391_11 + arg_391_0 and not isNil(var_391_9) and arg_388_1.var_.characterEffect1089ui_story then
				arg_388_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_391_13 = 0

			if var_391_13 < arg_388_1.time_ and arg_388_1.time_ <= var_391_13 + arg_391_0 then
				arg_388_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			local var_391_14 = 0

			if var_391_14 < arg_388_1.time_ and arg_388_1.time_ <= var_391_14 + arg_391_0 then
				arg_388_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_391_15 = 0
			local var_391_16 = 0.35

			if var_391_15 < arg_388_1.time_ and arg_388_1.time_ <= var_391_15 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_17 = arg_388_1:FormatText(StoryNameCfg[1031].name)

				arg_388_1.leftNameTxt_.text = var_391_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_18 = arg_388_1:GetWordFromCfg(322031092)
				local var_391_19 = arg_388_1:FormatText(var_391_18.content)

				arg_388_1.text_.text = var_391_19

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031092", "story_v_out_322031.awb") ~= 0 then
					local var_391_23 = manager.audio:GetVoiceLength("story_v_out_322031", "322031092", "story_v_out_322031.awb") / 1000

					if var_391_23 + var_391_15 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_23 + var_391_15
					end

					if var_391_18.prefab_name ~= "" and arg_388_1.actors_[var_391_18.prefab_name] ~= nil then
						local var_391_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_18.prefab_name].transform, "story_v_out_322031", "322031092", "story_v_out_322031.awb")

						arg_388_1:RecordAudio("322031092", var_391_24)
						arg_388_1:RecordAudio("322031092", var_391_24)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_322031", "322031092", "story_v_out_322031.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_322031", "322031092", "story_v_out_322031.awb")
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
				actorName = "1089ui_story",
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
	Play322031095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 322031095
		arg_392_1.duration_ = 13.93

		local var_392_0 = {
			zh = 7.766,
			ja = 13.933
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
				arg_392_0:Play322031096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1089ui_story"].transform
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.var_.moveOldPos1089ui_story = var_395_0.localPosition
			end

			local var_395_2 = 0.001

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2
				local var_395_4 = Vector3.New(0, -1.1, -6.17)

				var_395_0.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1089ui_story, var_395_4, var_395_3)

				local var_395_5 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_5.x, var_395_5.y, var_395_5.z)

				local var_395_6 = var_395_0.localEulerAngles

				var_395_6.z = 0
				var_395_6.x = 0
				var_395_0.localEulerAngles = var_395_6
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 then
				var_395_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_395_7 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_7.x, var_395_7.y, var_395_7.z)

				local var_395_8 = var_395_0.localEulerAngles

				var_395_8.z = 0
				var_395_8.x = 0
				var_395_0.localEulerAngles = var_395_8
			end

			local var_395_9 = arg_392_1.actors_["1089ui_story"]
			local var_395_10 = 0

			if var_395_10 < arg_392_1.time_ and arg_392_1.time_ <= var_395_10 + arg_395_0 and not isNil(var_395_9) and arg_392_1.var_.characterEffect1089ui_story == nil then
				arg_392_1.var_.characterEffect1089ui_story = var_395_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_11 = 0.200000002980232

			if var_395_10 <= arg_392_1.time_ and arg_392_1.time_ < var_395_10 + var_395_11 and not isNil(var_395_9) then
				local var_395_12 = (arg_392_1.time_ - var_395_10) / var_395_11

				if arg_392_1.var_.characterEffect1089ui_story and not isNil(var_395_9) then
					arg_392_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= var_395_10 + var_395_11 and arg_392_1.time_ < var_395_10 + var_395_11 + arg_395_0 and not isNil(var_395_9) and arg_392_1.var_.characterEffect1089ui_story then
				arg_392_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_395_13 = 0

			if var_395_13 < arg_392_1.time_ and arg_392_1.time_ <= var_395_13 + arg_395_0 then
				arg_392_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			local var_395_14 = 0

			if var_395_14 < arg_392_1.time_ and arg_392_1.time_ <= var_395_14 + arg_395_0 then
				arg_392_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_395_15 = 0
			local var_395_16 = 0.675

			if var_395_15 < arg_392_1.time_ and arg_392_1.time_ <= var_395_15 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_17 = arg_392_1:FormatText(StoryNameCfg[1031].name)

				arg_392_1.leftNameTxt_.text = var_395_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_18 = arg_392_1:GetWordFromCfg(322031095)
				local var_395_19 = arg_392_1:FormatText(var_395_18.content)

				arg_392_1.text_.text = var_395_19

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_20 = 27
				local var_395_21 = utf8.len(var_395_19)
				local var_395_22 = var_395_20 <= 0 and var_395_16 or var_395_16 * (var_395_21 / var_395_20)

				if var_395_22 > 0 and var_395_16 < var_395_22 then
					arg_392_1.talkMaxDuration = var_395_22

					if var_395_22 + var_395_15 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_22 + var_395_15
					end
				end

				arg_392_1.text_.text = var_395_19
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031095", "story_v_out_322031.awb") ~= 0 then
					local var_395_23 = manager.audio:GetVoiceLength("story_v_out_322031", "322031095", "story_v_out_322031.awb") / 1000

					if var_395_23 + var_395_15 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_23 + var_395_15
					end

					if var_395_18.prefab_name ~= "" and arg_392_1.actors_[var_395_18.prefab_name] ~= nil then
						local var_395_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_18.prefab_name].transform, "story_v_out_322031", "322031095", "story_v_out_322031.awb")

						arg_392_1:RecordAudio("322031095", var_395_24)
						arg_392_1:RecordAudio("322031095", var_395_24)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_322031", "322031095", "story_v_out_322031.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_322031", "322031095", "story_v_out_322031.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_25 = math.max(var_395_16, arg_392_1.talkMaxDuration)

			if var_395_15 <= arg_392_1.time_ and arg_392_1.time_ < var_395_15 + var_395_25 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_15) / var_395_25

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_15 + var_395_25 and arg_392_1.time_ < var_395_15 + var_395_25 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play322031096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 322031096
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play322031097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["1089ui_story"]
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect1089ui_story == nil then
				arg_396_1.var_.characterEffect1089ui_story = var_399_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_2 = 0.200000002980232

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 and not isNil(var_399_0) then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2

				if arg_396_1.var_.characterEffect1089ui_story and not isNil(var_399_0) then
					local var_399_4 = Mathf.Lerp(0, 0.5, var_399_3)

					arg_396_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_396_1.var_.characterEffect1089ui_story.fillRatio = var_399_4
				end
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect1089ui_story then
				local var_399_5 = 0.5

				arg_396_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_396_1.var_.characterEffect1089ui_story.fillRatio = var_399_5
			end

			local var_399_6 = 0
			local var_399_7 = 0.175

			if var_399_6 < arg_396_1.time_ and arg_396_1.time_ <= var_399_6 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_8 = arg_396_1:FormatText(StoryNameCfg[7].name)

				arg_396_1.leftNameTxt_.text = var_399_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_9 = arg_396_1:GetWordFromCfg(322031096)
				local var_399_10 = arg_396_1:FormatText(var_399_9.content)

				arg_396_1.text_.text = var_399_10

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_11 = 7
				local var_399_12 = utf8.len(var_399_10)
				local var_399_13 = var_399_11 <= 0 and var_399_7 or var_399_7 * (var_399_12 / var_399_11)

				if var_399_13 > 0 and var_399_7 < var_399_13 then
					arg_396_1.talkMaxDuration = var_399_13

					if var_399_13 + var_399_6 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_13 + var_399_6
					end
				end

				arg_396_1.text_.text = var_399_10
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_14 = math.max(var_399_7, arg_396_1.talkMaxDuration)

			if var_399_6 <= arg_396_1.time_ and arg_396_1.time_ < var_399_6 + var_399_14 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_6) / var_399_14

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_6 + var_399_14 and arg_396_1.time_ < var_399_6 + var_399_14 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play322031097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 322031097
		arg_400_1.duration_ = 11.87

		local var_400_0 = {
			zh = 8,
			ja = 11.866
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play322031098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["1089ui_story"]
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 and not isNil(var_403_0) and arg_400_1.var_.characterEffect1089ui_story == nil then
				arg_400_1.var_.characterEffect1089ui_story = var_403_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_2 = 0.200000002980232

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_2 and not isNil(var_403_0) then
				local var_403_3 = (arg_400_1.time_ - var_403_1) / var_403_2

				if arg_400_1.var_.characterEffect1089ui_story and not isNil(var_403_0) then
					arg_400_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= var_403_1 + var_403_2 and arg_400_1.time_ < var_403_1 + var_403_2 + arg_403_0 and not isNil(var_403_0) and arg_400_1.var_.characterEffect1089ui_story then
				arg_400_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_403_4 = 0

			if var_403_4 < arg_400_1.time_ and arg_400_1.time_ <= var_403_4 + arg_403_0 then
				arg_400_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_403_5 = 0

			if var_403_5 < arg_400_1.time_ and arg_400_1.time_ <= var_403_5 + arg_403_0 then
				arg_400_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_403_6 = 0
			local var_403_7 = 0.925

			if var_403_6 < arg_400_1.time_ and arg_400_1.time_ <= var_403_6 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_8 = arg_400_1:FormatText(StoryNameCfg[1031].name)

				arg_400_1.leftNameTxt_.text = var_403_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_9 = arg_400_1:GetWordFromCfg(322031097)
				local var_403_10 = arg_400_1:FormatText(var_403_9.content)

				arg_400_1.text_.text = var_403_10

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_11 = 37
				local var_403_12 = utf8.len(var_403_10)
				local var_403_13 = var_403_11 <= 0 and var_403_7 or var_403_7 * (var_403_12 / var_403_11)

				if var_403_13 > 0 and var_403_7 < var_403_13 then
					arg_400_1.talkMaxDuration = var_403_13

					if var_403_13 + var_403_6 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_13 + var_403_6
					end
				end

				arg_400_1.text_.text = var_403_10
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031097", "story_v_out_322031.awb") ~= 0 then
					local var_403_14 = manager.audio:GetVoiceLength("story_v_out_322031", "322031097", "story_v_out_322031.awb") / 1000

					if var_403_14 + var_403_6 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_14 + var_403_6
					end

					if var_403_9.prefab_name ~= "" and arg_400_1.actors_[var_403_9.prefab_name] ~= nil then
						local var_403_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_9.prefab_name].transform, "story_v_out_322031", "322031097", "story_v_out_322031.awb")

						arg_400_1:RecordAudio("322031097", var_403_15)
						arg_400_1:RecordAudio("322031097", var_403_15)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_322031", "322031097", "story_v_out_322031.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_322031", "322031097", "story_v_out_322031.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_16 = math.max(var_403_7, arg_400_1.talkMaxDuration)

			if var_403_6 <= arg_400_1.time_ and arg_400_1.time_ < var_403_6 + var_403_16 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_6) / var_403_16

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_6 + var_403_16 and arg_400_1.time_ < var_403_6 + var_403_16 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play322031098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 322031098
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play322031099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["1089ui_story"]
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect1089ui_story == nil then
				arg_404_1.var_.characterEffect1089ui_story = var_407_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 and not isNil(var_407_0) then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2

				if arg_404_1.var_.characterEffect1089ui_story and not isNil(var_407_0) then
					local var_407_4 = Mathf.Lerp(0, 0.5, var_407_3)

					arg_404_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1089ui_story.fillRatio = var_407_4
				end
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect1089ui_story then
				local var_407_5 = 0.5

				arg_404_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1089ui_story.fillRatio = var_407_5
			end

			local var_407_6 = 0
			local var_407_7 = 0.4

			if var_407_6 < arg_404_1.time_ and arg_404_1.time_ <= var_407_6 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_8 = arg_404_1:FormatText(StoryNameCfg[7].name)

				arg_404_1.leftNameTxt_.text = var_407_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_9 = arg_404_1:GetWordFromCfg(322031098)
				local var_407_10 = arg_404_1:FormatText(var_407_9.content)

				arg_404_1.text_.text = var_407_10

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_11 = 16
				local var_407_12 = utf8.len(var_407_10)
				local var_407_13 = var_407_11 <= 0 and var_407_7 or var_407_7 * (var_407_12 / var_407_11)

				if var_407_13 > 0 and var_407_7 < var_407_13 then
					arg_404_1.talkMaxDuration = var_407_13

					if var_407_13 + var_407_6 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_13 + var_407_6
					end
				end

				arg_404_1.text_.text = var_407_10
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_14 = math.max(var_407_7, arg_404_1.talkMaxDuration)

			if var_407_6 <= arg_404_1.time_ and arg_404_1.time_ < var_407_6 + var_407_14 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_6) / var_407_14

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_6 + var_407_14 and arg_404_1.time_ < var_407_6 + var_407_14 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play322031099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 322031099
		arg_408_1.duration_ = 9.63

		local var_408_0 = {
			zh = 7.933,
			ja = 9.633
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play322031100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.actors_["1089ui_story"]
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.characterEffect1089ui_story == nil then
				arg_408_1.var_.characterEffect1089ui_story = var_411_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_2 = 0.200000002980232

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_2 and not isNil(var_411_0) then
				local var_411_3 = (arg_408_1.time_ - var_411_1) / var_411_2

				if arg_408_1.var_.characterEffect1089ui_story and not isNil(var_411_0) then
					arg_408_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_408_1.time_ >= var_411_1 + var_411_2 and arg_408_1.time_ < var_411_1 + var_411_2 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.characterEffect1089ui_story then
				arg_408_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_411_4 = 0

			if var_411_4 < arg_408_1.time_ and arg_408_1.time_ <= var_411_4 + arg_411_0 then
				arg_408_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_1")
			end

			local var_411_5 = 0

			if var_411_5 < arg_408_1.time_ and arg_408_1.time_ <= var_411_5 + arg_411_0 then
				arg_408_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_411_6 = 0
			local var_411_7 = 0.65

			if var_411_6 < arg_408_1.time_ and arg_408_1.time_ <= var_411_6 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_8 = arg_408_1:FormatText(StoryNameCfg[1031].name)

				arg_408_1.leftNameTxt_.text = var_411_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_9 = arg_408_1:GetWordFromCfg(322031099)
				local var_411_10 = arg_408_1:FormatText(var_411_9.content)

				arg_408_1.text_.text = var_411_10

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_11 = 26
				local var_411_12 = utf8.len(var_411_10)
				local var_411_13 = var_411_11 <= 0 and var_411_7 or var_411_7 * (var_411_12 / var_411_11)

				if var_411_13 > 0 and var_411_7 < var_411_13 then
					arg_408_1.talkMaxDuration = var_411_13

					if var_411_13 + var_411_6 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_13 + var_411_6
					end
				end

				arg_408_1.text_.text = var_411_10
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031099", "story_v_out_322031.awb") ~= 0 then
					local var_411_14 = manager.audio:GetVoiceLength("story_v_out_322031", "322031099", "story_v_out_322031.awb") / 1000

					if var_411_14 + var_411_6 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_14 + var_411_6
					end

					if var_411_9.prefab_name ~= "" and arg_408_1.actors_[var_411_9.prefab_name] ~= nil then
						local var_411_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_9.prefab_name].transform, "story_v_out_322031", "322031099", "story_v_out_322031.awb")

						arg_408_1:RecordAudio("322031099", var_411_15)
						arg_408_1:RecordAudio("322031099", var_411_15)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_322031", "322031099", "story_v_out_322031.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_322031", "322031099", "story_v_out_322031.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_16 = math.max(var_411_7, arg_408_1.talkMaxDuration)

			if var_411_6 <= arg_408_1.time_ and arg_408_1.time_ < var_411_6 + var_411_16 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_6) / var_411_16

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_6 + var_411_16 and arg_408_1.time_ < var_411_6 + var_411_16 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play322031100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 322031100
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play322031101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["1089ui_story"]
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.characterEffect1089ui_story == nil then
				arg_412_1.var_.characterEffect1089ui_story = var_415_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_2 = 0.200000002980232

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 and not isNil(var_415_0) then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2

				if arg_412_1.var_.characterEffect1089ui_story and not isNil(var_415_0) then
					local var_415_4 = Mathf.Lerp(0, 0.5, var_415_3)

					arg_412_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_412_1.var_.characterEffect1089ui_story.fillRatio = var_415_4
				end
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.characterEffect1089ui_story then
				local var_415_5 = 0.5

				arg_412_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_412_1.var_.characterEffect1089ui_story.fillRatio = var_415_5
			end

			local var_415_6 = 0
			local var_415_7 = 0.125

			if var_415_6 < arg_412_1.time_ and arg_412_1.time_ <= var_415_6 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_8 = arg_412_1:FormatText(StoryNameCfg[7].name)

				arg_412_1.leftNameTxt_.text = var_415_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_9 = arg_412_1:GetWordFromCfg(322031100)
				local var_415_10 = arg_412_1:FormatText(var_415_9.content)

				arg_412_1.text_.text = var_415_10

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_11 = 5
				local var_415_12 = utf8.len(var_415_10)
				local var_415_13 = var_415_11 <= 0 and var_415_7 or var_415_7 * (var_415_12 / var_415_11)

				if var_415_13 > 0 and var_415_7 < var_415_13 then
					arg_412_1.talkMaxDuration = var_415_13

					if var_415_13 + var_415_6 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_13 + var_415_6
					end
				end

				arg_412_1.text_.text = var_415_10
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_14 = math.max(var_415_7, arg_412_1.talkMaxDuration)

			if var_415_6 <= arg_412_1.time_ and arg_412_1.time_ < var_415_6 + var_415_14 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_6) / var_415_14

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_6 + var_415_14 and arg_412_1.time_ < var_415_6 + var_415_14 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play322031101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 322031101
		arg_416_1.duration_ = 5.77

		local var_416_0 = {
			zh = 3.666,
			ja = 5.766
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play322031102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["1089ui_story"]
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.characterEffect1089ui_story == nil then
				arg_416_1.var_.characterEffect1089ui_story = var_419_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_2 = 0.200000002980232

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_2 and not isNil(var_419_0) then
				local var_419_3 = (arg_416_1.time_ - var_419_1) / var_419_2

				if arg_416_1.var_.characterEffect1089ui_story and not isNil(var_419_0) then
					arg_416_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_416_1.time_ >= var_419_1 + var_419_2 and arg_416_1.time_ < var_419_1 + var_419_2 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.characterEffect1089ui_story then
				arg_416_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_419_4 = 0

			if var_419_4 < arg_416_1.time_ and arg_416_1.time_ <= var_419_4 + arg_419_0 then
				arg_416_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_2")
			end

			local var_419_5 = 0

			if var_419_5 < arg_416_1.time_ and arg_416_1.time_ <= var_419_5 + arg_419_0 then
				arg_416_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_419_6 = 0
			local var_419_7 = 0.25

			if var_419_6 < arg_416_1.time_ and arg_416_1.time_ <= var_419_6 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_8 = arg_416_1:FormatText(StoryNameCfg[1031].name)

				arg_416_1.leftNameTxt_.text = var_419_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_9 = arg_416_1:GetWordFromCfg(322031101)
				local var_419_10 = arg_416_1:FormatText(var_419_9.content)

				arg_416_1.text_.text = var_419_10

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_11 = 10
				local var_419_12 = utf8.len(var_419_10)
				local var_419_13 = var_419_11 <= 0 and var_419_7 or var_419_7 * (var_419_12 / var_419_11)

				if var_419_13 > 0 and var_419_7 < var_419_13 then
					arg_416_1.talkMaxDuration = var_419_13

					if var_419_13 + var_419_6 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_13 + var_419_6
					end
				end

				arg_416_1.text_.text = var_419_10
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031101", "story_v_out_322031.awb") ~= 0 then
					local var_419_14 = manager.audio:GetVoiceLength("story_v_out_322031", "322031101", "story_v_out_322031.awb") / 1000

					if var_419_14 + var_419_6 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_14 + var_419_6
					end

					if var_419_9.prefab_name ~= "" and arg_416_1.actors_[var_419_9.prefab_name] ~= nil then
						local var_419_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_9.prefab_name].transform, "story_v_out_322031", "322031101", "story_v_out_322031.awb")

						arg_416_1:RecordAudio("322031101", var_419_15)
						arg_416_1:RecordAudio("322031101", var_419_15)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_322031", "322031101", "story_v_out_322031.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_322031", "322031101", "story_v_out_322031.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_16 = math.max(var_419_7, arg_416_1.talkMaxDuration)

			if var_419_6 <= arg_416_1.time_ and arg_416_1.time_ < var_419_6 + var_419_16 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_6) / var_419_16

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_6 + var_419_16 and arg_416_1.time_ < var_419_6 + var_419_16 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play322031102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 322031102
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play322031103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["1089ui_story"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect1089ui_story == nil then
				arg_420_1.var_.characterEffect1089ui_story = var_423_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.characterEffect1089ui_story and not isNil(var_423_0) then
					local var_423_4 = Mathf.Lerp(0, 0.5, var_423_3)

					arg_420_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_420_1.var_.characterEffect1089ui_story.fillRatio = var_423_4
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect1089ui_story then
				local var_423_5 = 0.5

				arg_420_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_420_1.var_.characterEffect1089ui_story.fillRatio = var_423_5
			end

			local var_423_6 = 0
			local var_423_7 = 1.125

			if var_423_6 < arg_420_1.time_ and arg_420_1.time_ <= var_423_6 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_8 = arg_420_1:FormatText(StoryNameCfg[7].name)

				arg_420_1.leftNameTxt_.text = var_423_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, true)
				arg_420_1.iconController_:SetSelectedState("hero")

				arg_420_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_420_1.callingController_:SetSelectedState("normal")

				arg_420_1.keyicon_.color = Color.New(1, 1, 1)
				arg_420_1.icon_.color = Color.New(1, 1, 1)

				local var_423_9 = arg_420_1:GetWordFromCfg(322031102)
				local var_423_10 = arg_420_1:FormatText(var_423_9.content)

				arg_420_1.text_.text = var_423_10

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_11 = 45
				local var_423_12 = utf8.len(var_423_10)
				local var_423_13 = var_423_11 <= 0 and var_423_7 or var_423_7 * (var_423_12 / var_423_11)

				if var_423_13 > 0 and var_423_7 < var_423_13 then
					arg_420_1.talkMaxDuration = var_423_13

					if var_423_13 + var_423_6 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_13 + var_423_6
					end
				end

				arg_420_1.text_.text = var_423_10
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_14 = math.max(var_423_7, arg_420_1.talkMaxDuration)

			if var_423_6 <= arg_420_1.time_ and arg_420_1.time_ < var_423_6 + var_423_14 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_6) / var_423_14

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_6 + var_423_14 and arg_420_1.time_ < var_423_6 + var_423_14 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play322031103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 322031103
		arg_424_1.duration_ = 5.77

		local var_424_0 = {
			zh = 4.966,
			ja = 5.766
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play322031104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["1089ui_story"]
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect1089ui_story == nil then
				arg_424_1.var_.characterEffect1089ui_story = var_427_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.200000002980232

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 and not isNil(var_427_0) then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2

				if arg_424_1.var_.characterEffect1089ui_story and not isNil(var_427_0) then
					arg_424_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect1089ui_story then
				arg_424_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_427_4 = 0
			local var_427_5 = 0.525

			if var_427_4 < arg_424_1.time_ and arg_424_1.time_ <= var_427_4 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_6 = arg_424_1:FormatText(StoryNameCfg[1031].name)

				arg_424_1.leftNameTxt_.text = var_427_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_7 = arg_424_1:GetWordFromCfg(322031103)
				local var_427_8 = arg_424_1:FormatText(var_427_7.content)

				arg_424_1.text_.text = var_427_8

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_9 = 21
				local var_427_10 = utf8.len(var_427_8)
				local var_427_11 = var_427_9 <= 0 and var_427_5 or var_427_5 * (var_427_10 / var_427_9)

				if var_427_11 > 0 and var_427_5 < var_427_11 then
					arg_424_1.talkMaxDuration = var_427_11

					if var_427_11 + var_427_4 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_11 + var_427_4
					end
				end

				arg_424_1.text_.text = var_427_8
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031103", "story_v_out_322031.awb") ~= 0 then
					local var_427_12 = manager.audio:GetVoiceLength("story_v_out_322031", "322031103", "story_v_out_322031.awb") / 1000

					if var_427_12 + var_427_4 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_12 + var_427_4
					end

					if var_427_7.prefab_name ~= "" and arg_424_1.actors_[var_427_7.prefab_name] ~= nil then
						local var_427_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_7.prefab_name].transform, "story_v_out_322031", "322031103", "story_v_out_322031.awb")

						arg_424_1:RecordAudio("322031103", var_427_13)
						arg_424_1:RecordAudio("322031103", var_427_13)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_322031", "322031103", "story_v_out_322031.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_322031", "322031103", "story_v_out_322031.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_14 = math.max(var_427_5, arg_424_1.talkMaxDuration)

			if var_427_4 <= arg_424_1.time_ and arg_424_1.time_ < var_427_4 + var_427_14 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_4) / var_427_14

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_4 + var_427_14 and arg_424_1.time_ < var_427_4 + var_427_14 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play322031104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 322031104
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play322031105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["1089ui_story"]
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect1089ui_story == nil then
				arg_428_1.var_.characterEffect1089ui_story = var_431_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_2 = 0.200000002980232

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 and not isNil(var_431_0) then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2

				if arg_428_1.var_.characterEffect1089ui_story and not isNil(var_431_0) then
					local var_431_4 = Mathf.Lerp(0, 0.5, var_431_3)

					arg_428_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_428_1.var_.characterEffect1089ui_story.fillRatio = var_431_4
				end
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect1089ui_story then
				local var_431_5 = 0.5

				arg_428_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_428_1.var_.characterEffect1089ui_story.fillRatio = var_431_5
			end

			local var_431_6 = 0
			local var_431_7 = 0.15

			if var_431_6 < arg_428_1.time_ and arg_428_1.time_ <= var_431_6 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_8 = arg_428_1:FormatText(StoryNameCfg[7].name)

				arg_428_1.leftNameTxt_.text = var_431_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_9 = arg_428_1:GetWordFromCfg(322031104)
				local var_431_10 = arg_428_1:FormatText(var_431_9.content)

				arg_428_1.text_.text = var_431_10

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_11 = 6
				local var_431_12 = utf8.len(var_431_10)
				local var_431_13 = var_431_11 <= 0 and var_431_7 or var_431_7 * (var_431_12 / var_431_11)

				if var_431_13 > 0 and var_431_7 < var_431_13 then
					arg_428_1.talkMaxDuration = var_431_13

					if var_431_13 + var_431_6 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_13 + var_431_6
					end
				end

				arg_428_1.text_.text = var_431_10
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_14 = math.max(var_431_7, arg_428_1.talkMaxDuration)

			if var_431_6 <= arg_428_1.time_ and arg_428_1.time_ < var_431_6 + var_431_14 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_6) / var_431_14

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_6 + var_431_14 and arg_428_1.time_ < var_431_6 + var_431_14 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play322031105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 322031105
		arg_432_1.duration_ = 3.6

		local var_432_0 = {
			zh = 1.5,
			ja = 3.6
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play322031106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = arg_432_1.actors_["1089ui_story"]
			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.characterEffect1089ui_story == nil then
				arg_432_1.var_.characterEffect1089ui_story = var_435_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_2 = 0.200000002980232

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_2 and not isNil(var_435_0) then
				local var_435_3 = (arg_432_1.time_ - var_435_1) / var_435_2

				if arg_432_1.var_.characterEffect1089ui_story and not isNil(var_435_0) then
					arg_432_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_432_1.time_ >= var_435_1 + var_435_2 and arg_432_1.time_ < var_435_1 + var_435_2 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.characterEffect1089ui_story then
				arg_432_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_435_4 = 0
			local var_435_5 = 0.15

			if var_435_4 < arg_432_1.time_ and arg_432_1.time_ <= var_435_4 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_6 = arg_432_1:FormatText(StoryNameCfg[1031].name)

				arg_432_1.leftNameTxt_.text = var_435_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_7 = arg_432_1:GetWordFromCfg(322031105)
				local var_435_8 = arg_432_1:FormatText(var_435_7.content)

				arg_432_1.text_.text = var_435_8

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_9 = 6
				local var_435_10 = utf8.len(var_435_8)
				local var_435_11 = var_435_9 <= 0 and var_435_5 or var_435_5 * (var_435_10 / var_435_9)

				if var_435_11 > 0 and var_435_5 < var_435_11 then
					arg_432_1.talkMaxDuration = var_435_11

					if var_435_11 + var_435_4 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_11 + var_435_4
					end
				end

				arg_432_1.text_.text = var_435_8
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031105", "story_v_out_322031.awb") ~= 0 then
					local var_435_12 = manager.audio:GetVoiceLength("story_v_out_322031", "322031105", "story_v_out_322031.awb") / 1000

					if var_435_12 + var_435_4 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_12 + var_435_4
					end

					if var_435_7.prefab_name ~= "" and arg_432_1.actors_[var_435_7.prefab_name] ~= nil then
						local var_435_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_7.prefab_name].transform, "story_v_out_322031", "322031105", "story_v_out_322031.awb")

						arg_432_1:RecordAudio("322031105", var_435_13)
						arg_432_1:RecordAudio("322031105", var_435_13)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_322031", "322031105", "story_v_out_322031.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_322031", "322031105", "story_v_out_322031.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_14 = math.max(var_435_5, arg_432_1.talkMaxDuration)

			if var_435_4 <= arg_432_1.time_ and arg_432_1.time_ < var_435_4 + var_435_14 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_4) / var_435_14

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_4 + var_435_14 and arg_432_1.time_ < var_435_4 + var_435_14 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play322031106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 322031106
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play322031107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["1089ui_story"]
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect1089ui_story == nil then
				arg_436_1.var_.characterEffect1089ui_story = var_439_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_2 = 0.200000002980232

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 and not isNil(var_439_0) then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2

				if arg_436_1.var_.characterEffect1089ui_story and not isNil(var_439_0) then
					local var_439_4 = Mathf.Lerp(0, 0.5, var_439_3)

					arg_436_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_436_1.var_.characterEffect1089ui_story.fillRatio = var_439_4
				end
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect1089ui_story then
				local var_439_5 = 0.5

				arg_436_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_436_1.var_.characterEffect1089ui_story.fillRatio = var_439_5
			end

			local var_439_6 = 0
			local var_439_7 = 1.7

			if var_439_6 < arg_436_1.time_ and arg_436_1.time_ <= var_439_6 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_8 = arg_436_1:FormatText(StoryNameCfg[7].name)

				arg_436_1.leftNameTxt_.text = var_439_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, true)
				arg_436_1.iconController_:SetSelectedState("hero")

				arg_436_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_436_1.callingController_:SetSelectedState("normal")

				arg_436_1.keyicon_.color = Color.New(1, 1, 1)
				arg_436_1.icon_.color = Color.New(1, 1, 1)

				local var_439_9 = arg_436_1:GetWordFromCfg(322031106)
				local var_439_10 = arg_436_1:FormatText(var_439_9.content)

				arg_436_1.text_.text = var_439_10

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_11 = 68
				local var_439_12 = utf8.len(var_439_10)
				local var_439_13 = var_439_11 <= 0 and var_439_7 or var_439_7 * (var_439_12 / var_439_11)

				if var_439_13 > 0 and var_439_7 < var_439_13 then
					arg_436_1.talkMaxDuration = var_439_13

					if var_439_13 + var_439_6 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_13 + var_439_6
					end
				end

				arg_436_1.text_.text = var_439_10
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_14 = math.max(var_439_7, arg_436_1.talkMaxDuration)

			if var_439_6 <= arg_436_1.time_ and arg_436_1.time_ < var_439_6 + var_439_14 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_6) / var_439_14

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_6 + var_439_14 and arg_436_1.time_ < var_439_6 + var_439_14 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play322031107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 322031107
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play322031108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0
			local var_443_1 = 1.4

			if var_443_0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_2 = arg_440_1:FormatText(StoryNameCfg[7].name)

				arg_440_1.leftNameTxt_.text = var_443_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_3 = arg_440_1:GetWordFromCfg(322031107)
				local var_443_4 = arg_440_1:FormatText(var_443_3.content)

				arg_440_1.text_.text = var_443_4

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_5 = 56
				local var_443_6 = utf8.len(var_443_4)
				local var_443_7 = var_443_5 <= 0 and var_443_1 or var_443_1 * (var_443_6 / var_443_5)

				if var_443_7 > 0 and var_443_1 < var_443_7 then
					arg_440_1.talkMaxDuration = var_443_7

					if var_443_7 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_7 + var_443_0
					end
				end

				arg_440_1.text_.text = var_443_4
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_8 = math.max(var_443_1, arg_440_1.talkMaxDuration)

			if var_443_0 <= arg_440_1.time_ and arg_440_1.time_ < var_443_0 + var_443_8 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_0) / var_443_8

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_0 + var_443_8 and arg_440_1.time_ < var_443_0 + var_443_8 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play322031108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 322031108
		arg_444_1.duration_ = 4.93

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play322031109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["1089ui_story"]
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.characterEffect1089ui_story == nil then
				arg_444_1.var_.characterEffect1089ui_story = var_447_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_2 = 0.200000002980232

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 and not isNil(var_447_0) then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2

				if arg_444_1.var_.characterEffect1089ui_story and not isNil(var_447_0) then
					arg_444_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.characterEffect1089ui_story then
				arg_444_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_447_4 = 0
			local var_447_5 = 0.05

			if var_447_4 < arg_444_1.time_ and arg_444_1.time_ <= var_447_4 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_6 = arg_444_1:FormatText(StoryNameCfg[1031].name)

				arg_444_1.leftNameTxt_.text = var_447_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_7 = arg_444_1:GetWordFromCfg(322031108)
				local var_447_8 = arg_444_1:FormatText(var_447_7.content)

				arg_444_1.text_.text = var_447_8

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_9 = 2
				local var_447_10 = utf8.len(var_447_8)
				local var_447_11 = var_447_9 <= 0 and var_447_5 or var_447_5 * (var_447_10 / var_447_9)

				if var_447_11 > 0 and var_447_5 < var_447_11 then
					arg_444_1.talkMaxDuration = var_447_11

					if var_447_11 + var_447_4 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_11 + var_447_4
					end
				end

				arg_444_1.text_.text = var_447_8
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031108", "story_v_out_322031.awb") ~= 0 then
					local var_447_12 = manager.audio:GetVoiceLength("story_v_out_322031", "322031108", "story_v_out_322031.awb") / 1000

					if var_447_12 + var_447_4 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_12 + var_447_4
					end

					if var_447_7.prefab_name ~= "" and arg_444_1.actors_[var_447_7.prefab_name] ~= nil then
						local var_447_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_7.prefab_name].transform, "story_v_out_322031", "322031108", "story_v_out_322031.awb")

						arg_444_1:RecordAudio("322031108", var_447_13)
						arg_444_1:RecordAudio("322031108", var_447_13)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_322031", "322031108", "story_v_out_322031.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_322031", "322031108", "story_v_out_322031.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_14 = math.max(var_447_5, arg_444_1.talkMaxDuration)

			if var_447_4 <= arg_444_1.time_ and arg_444_1.time_ < var_447_4 + var_447_14 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_4) / var_447_14

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_4 + var_447_14 and arg_444_1.time_ < var_447_4 + var_447_14 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play322031109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 322031109
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play322031110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["1089ui_story"]
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect1089ui_story == nil then
				arg_448_1.var_.characterEffect1089ui_story = var_451_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_2 = 0.200000002980232

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 and not isNil(var_451_0) then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2

				if arg_448_1.var_.characterEffect1089ui_story and not isNil(var_451_0) then
					local var_451_4 = Mathf.Lerp(0, 0.5, var_451_3)

					arg_448_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_448_1.var_.characterEffect1089ui_story.fillRatio = var_451_4
				end
			end

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect1089ui_story then
				local var_451_5 = 0.5

				arg_448_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_448_1.var_.characterEffect1089ui_story.fillRatio = var_451_5
			end

			local var_451_6 = 0
			local var_451_7 = 1.125

			if var_451_6 < arg_448_1.time_ and arg_448_1.time_ <= var_451_6 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_8 = arg_448_1:FormatText(StoryNameCfg[7].name)

				arg_448_1.leftNameTxt_.text = var_451_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_9 = arg_448_1:GetWordFromCfg(322031109)
				local var_451_10 = arg_448_1:FormatText(var_451_9.content)

				arg_448_1.text_.text = var_451_10

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_11 = 45
				local var_451_12 = utf8.len(var_451_10)
				local var_451_13 = var_451_11 <= 0 and var_451_7 or var_451_7 * (var_451_12 / var_451_11)

				if var_451_13 > 0 and var_451_7 < var_451_13 then
					arg_448_1.talkMaxDuration = var_451_13

					if var_451_13 + var_451_6 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_13 + var_451_6
					end
				end

				arg_448_1.text_.text = var_451_10
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_14 = math.max(var_451_7, arg_448_1.talkMaxDuration)

			if var_451_6 <= arg_448_1.time_ and arg_448_1.time_ < var_451_6 + var_451_14 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_6) / var_451_14

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_6 + var_451_14 and arg_448_1.time_ < var_451_6 + var_451_14 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play322031110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 322031110
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play322031111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0
			local var_455_1 = 0.525

			if var_455_0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_2 = arg_452_1:FormatText(StoryNameCfg[7].name)

				arg_452_1.leftNameTxt_.text = var_455_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_3 = arg_452_1:GetWordFromCfg(322031110)
				local var_455_4 = arg_452_1:FormatText(var_455_3.content)

				arg_452_1.text_.text = var_455_4

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_5 = 21
				local var_455_6 = utf8.len(var_455_4)
				local var_455_7 = var_455_5 <= 0 and var_455_1 or var_455_1 * (var_455_6 / var_455_5)

				if var_455_7 > 0 and var_455_1 < var_455_7 then
					arg_452_1.talkMaxDuration = var_455_7

					if var_455_7 + var_455_0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_7 + var_455_0
					end
				end

				arg_452_1.text_.text = var_455_4
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_8 = math.max(var_455_1, arg_452_1.talkMaxDuration)

			if var_455_0 <= arg_452_1.time_ and arg_452_1.time_ < var_455_0 + var_455_8 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_0) / var_455_8

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_0 + var_455_8 and arg_452_1.time_ < var_455_0 + var_455_8 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play322031111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 322031111
		arg_456_1.duration_ = 8.2

		local var_456_0 = {
			zh = 7.466,
			ja = 8.2
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play322031112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["1089ui_story"]
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.characterEffect1089ui_story == nil then
				arg_456_1.var_.characterEffect1089ui_story = var_459_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_2 = 0.200000002980232

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 and not isNil(var_459_0) then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2

				if arg_456_1.var_.characterEffect1089ui_story and not isNil(var_459_0) then
					arg_456_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.characterEffect1089ui_story then
				arg_456_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_459_4 = 0

			if var_459_4 < arg_456_1.time_ and arg_456_1.time_ <= var_459_4 + arg_459_0 then
				arg_456_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			local var_459_5 = 0

			if var_459_5 < arg_456_1.time_ and arg_456_1.time_ <= var_459_5 + arg_459_0 then
				arg_456_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_459_6 = 0
			local var_459_7 = 0.825

			if var_459_6 < arg_456_1.time_ and arg_456_1.time_ <= var_459_6 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_8 = arg_456_1:FormatText(StoryNameCfg[1031].name)

				arg_456_1.leftNameTxt_.text = var_459_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_9 = arg_456_1:GetWordFromCfg(322031111)
				local var_459_10 = arg_456_1:FormatText(var_459_9.content)

				arg_456_1.text_.text = var_459_10

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_11 = 33
				local var_459_12 = utf8.len(var_459_10)
				local var_459_13 = var_459_11 <= 0 and var_459_7 or var_459_7 * (var_459_12 / var_459_11)

				if var_459_13 > 0 and var_459_7 < var_459_13 then
					arg_456_1.talkMaxDuration = var_459_13

					if var_459_13 + var_459_6 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_13 + var_459_6
					end
				end

				arg_456_1.text_.text = var_459_10
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031111", "story_v_out_322031.awb") ~= 0 then
					local var_459_14 = manager.audio:GetVoiceLength("story_v_out_322031", "322031111", "story_v_out_322031.awb") / 1000

					if var_459_14 + var_459_6 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_14 + var_459_6
					end

					if var_459_9.prefab_name ~= "" and arg_456_1.actors_[var_459_9.prefab_name] ~= nil then
						local var_459_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_9.prefab_name].transform, "story_v_out_322031", "322031111", "story_v_out_322031.awb")

						arg_456_1:RecordAudio("322031111", var_459_15)
						arg_456_1:RecordAudio("322031111", var_459_15)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_322031", "322031111", "story_v_out_322031.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_322031", "322031111", "story_v_out_322031.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_16 = math.max(var_459_7, arg_456_1.talkMaxDuration)

			if var_459_6 <= arg_456_1.time_ and arg_456_1.time_ < var_459_6 + var_459_16 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_6) / var_459_16

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_6 + var_459_16 and arg_456_1.time_ < var_459_6 + var_459_16 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play322031112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 322031112
		arg_460_1.duration_ = 1

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"

			SetActive(arg_460_1.choicesGo_, true)

			for iter_461_0, iter_461_1 in ipairs(arg_460_1.choices_) do
				local var_461_0 = iter_461_0 <= 3

				SetActive(iter_461_1.go, var_461_0)
			end

			arg_460_1.choices_[1].txt.text = arg_460_1:FormatText(StoryChoiceCfg[1406].name)
			arg_460_1.choices_[2].txt.text = arg_460_1:FormatText(StoryChoiceCfg[1407].name)
			arg_460_1.choices_[3].txt.text = arg_460_1:FormatText(StoryChoiceCfg[1408].name)
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play322031113(arg_460_1)
			end

			if arg_462_0 == 2 then
				arg_460_0:Play322031113(arg_460_1)
			end

			if arg_462_0 == 3 then
				arg_460_0:Play322031113(arg_460_1)
			end

			arg_460_1:RecordChoiceLog(322031112, 1406, 1407, 1408)
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["1089ui_story"]
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.characterEffect1089ui_story == nil then
				arg_460_1.var_.characterEffect1089ui_story = var_463_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_2 = 0.200000002980232

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_2 and not isNil(var_463_0) then
				local var_463_3 = (arg_460_1.time_ - var_463_1) / var_463_2

				if arg_460_1.var_.characterEffect1089ui_story and not isNil(var_463_0) then
					local var_463_4 = Mathf.Lerp(0, 0.5, var_463_3)

					arg_460_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_460_1.var_.characterEffect1089ui_story.fillRatio = var_463_4
				end
			end

			if arg_460_1.time_ >= var_463_1 + var_463_2 and arg_460_1.time_ < var_463_1 + var_463_2 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.characterEffect1089ui_story then
				local var_463_5 = 0.5

				arg_460_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_460_1.var_.characterEffect1089ui_story.fillRatio = var_463_5
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play322031113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 322031113
		arg_464_1.duration_ = 8.8

		local var_464_0 = {
			zh = 6.3,
			ja = 8.8
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play322031114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["1089ui_story"].transform
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 then
				arg_464_1.var_.moveOldPos1089ui_story = var_467_0.localPosition
			end

			local var_467_2 = 0.001

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_2 then
				local var_467_3 = (arg_464_1.time_ - var_467_1) / var_467_2
				local var_467_4 = Vector3.New(0, -1.1, -6.17)

				var_467_0.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos1089ui_story, var_467_4, var_467_3)

				local var_467_5 = manager.ui.mainCamera.transform.position - var_467_0.position

				var_467_0.forward = Vector3.New(var_467_5.x, var_467_5.y, var_467_5.z)

				local var_467_6 = var_467_0.localEulerAngles

				var_467_6.z = 0
				var_467_6.x = 0
				var_467_0.localEulerAngles = var_467_6
			end

			if arg_464_1.time_ >= var_467_1 + var_467_2 and arg_464_1.time_ < var_467_1 + var_467_2 + arg_467_0 then
				var_467_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_467_7 = manager.ui.mainCamera.transform.position - var_467_0.position

				var_467_0.forward = Vector3.New(var_467_7.x, var_467_7.y, var_467_7.z)

				local var_467_8 = var_467_0.localEulerAngles

				var_467_8.z = 0
				var_467_8.x = 0
				var_467_0.localEulerAngles = var_467_8
			end

			local var_467_9 = arg_464_1.actors_["1089ui_story"]
			local var_467_10 = 0

			if var_467_10 < arg_464_1.time_ and arg_464_1.time_ <= var_467_10 + arg_467_0 and not isNil(var_467_9) and arg_464_1.var_.characterEffect1089ui_story == nil then
				arg_464_1.var_.characterEffect1089ui_story = var_467_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_11 = 0.200000002980232

			if var_467_10 <= arg_464_1.time_ and arg_464_1.time_ < var_467_10 + var_467_11 and not isNil(var_467_9) then
				local var_467_12 = (arg_464_1.time_ - var_467_10) / var_467_11

				if arg_464_1.var_.characterEffect1089ui_story and not isNil(var_467_9) then
					arg_464_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_464_1.time_ >= var_467_10 + var_467_11 and arg_464_1.time_ < var_467_10 + var_467_11 + arg_467_0 and not isNil(var_467_9) and arg_464_1.var_.characterEffect1089ui_story then
				arg_464_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_467_13 = "1089ui_story"

			if arg_464_1.actors_[var_467_13] == nil then
				local var_467_14 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_467_14) then
					local var_467_15 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_464_1.stage_.transform)

					var_467_15.name = var_467_13
					var_467_15.transform.localPosition = Vector3.New(0, 100, 0)
					arg_464_1.actors_[var_467_13] = var_467_15

					local var_467_16 = var_467_15:GetComponentInChildren(typeof(CharacterEffect))

					var_467_16.enabled = true

					local var_467_17 = GameObjectTools.GetOrAddComponent(var_467_15, typeof(DynamicBoneHelper))

					if var_467_17 then
						var_467_17:EnableDynamicBone(false)
					end

					arg_464_1:ShowWeapon(var_467_16.transform, false)

					arg_464_1.var_[var_467_13 .. "Animator"] = var_467_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_464_1.var_[var_467_13 .. "Animator"].applyRootMotion = true
					arg_464_1.var_[var_467_13 .. "LipSync"] = var_467_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_467_18 = 0

			if var_467_18 < arg_464_1.time_ and arg_464_1.time_ <= var_467_18 + arg_467_0 then
				arg_464_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_2")
			end

			local var_467_19 = "1089ui_story"

			if arg_464_1.actors_[var_467_19] == nil then
				local var_467_20 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_467_20) then
					local var_467_21 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_464_1.stage_.transform)

					var_467_21.name = var_467_19
					var_467_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_464_1.actors_[var_467_19] = var_467_21

					local var_467_22 = var_467_21:GetComponentInChildren(typeof(CharacterEffect))

					var_467_22.enabled = true

					local var_467_23 = GameObjectTools.GetOrAddComponent(var_467_21, typeof(DynamicBoneHelper))

					if var_467_23 then
						var_467_23:EnableDynamicBone(false)
					end

					arg_464_1:ShowWeapon(var_467_22.transform, false)

					arg_464_1.var_[var_467_19 .. "Animator"] = var_467_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_464_1.var_[var_467_19 .. "Animator"].applyRootMotion = true
					arg_464_1.var_[var_467_19 .. "LipSync"] = var_467_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_467_24 = 0

			if var_467_24 < arg_464_1.time_ and arg_464_1.time_ <= var_467_24 + arg_467_0 then
				arg_464_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_467_25 = 0
			local var_467_26 = 0.575

			if var_467_25 < arg_464_1.time_ and arg_464_1.time_ <= var_467_25 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_27 = arg_464_1:FormatText(StoryNameCfg[1031].name)

				arg_464_1.leftNameTxt_.text = var_467_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_28 = arg_464_1:GetWordFromCfg(322031113)
				local var_467_29 = arg_464_1:FormatText(var_467_28.content)

				arg_464_1.text_.text = var_467_29

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_30 = 23
				local var_467_31 = utf8.len(var_467_29)
				local var_467_32 = var_467_30 <= 0 and var_467_26 or var_467_26 * (var_467_31 / var_467_30)

				if var_467_32 > 0 and var_467_26 < var_467_32 then
					arg_464_1.talkMaxDuration = var_467_32

					if var_467_32 + var_467_25 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_32 + var_467_25
					end
				end

				arg_464_1.text_.text = var_467_29
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031113", "story_v_out_322031.awb") ~= 0 then
					local var_467_33 = manager.audio:GetVoiceLength("story_v_out_322031", "322031113", "story_v_out_322031.awb") / 1000

					if var_467_33 + var_467_25 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_33 + var_467_25
					end

					if var_467_28.prefab_name ~= "" and arg_464_1.actors_[var_467_28.prefab_name] ~= nil then
						local var_467_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_28.prefab_name].transform, "story_v_out_322031", "322031113", "story_v_out_322031.awb")

						arg_464_1:RecordAudio("322031113", var_467_34)
						arg_464_1:RecordAudio("322031113", var_467_34)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_322031", "322031113", "story_v_out_322031.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_322031", "322031113", "story_v_out_322031.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_35 = math.max(var_467_26, arg_464_1.talkMaxDuration)

			if var_467_25 <= arg_464_1.time_ and arg_464_1.time_ < var_467_25 + var_467_35 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_25) / var_467_35

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_25 + var_467_35 and arg_464_1.time_ < var_467_25 + var_467_35 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play322031114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 322031114
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play322031115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = arg_468_1.actors_["1089ui_story"]
			local var_471_1 = 0

			if var_471_1 < arg_468_1.time_ and arg_468_1.time_ <= var_471_1 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.characterEffect1089ui_story == nil then
				arg_468_1.var_.characterEffect1089ui_story = var_471_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_2 = 0.200000002980232

			if var_471_1 <= arg_468_1.time_ and arg_468_1.time_ < var_471_1 + var_471_2 and not isNil(var_471_0) then
				local var_471_3 = (arg_468_1.time_ - var_471_1) / var_471_2

				if arg_468_1.var_.characterEffect1089ui_story and not isNil(var_471_0) then
					local var_471_4 = Mathf.Lerp(0, 0.5, var_471_3)

					arg_468_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_468_1.var_.characterEffect1089ui_story.fillRatio = var_471_4
				end
			end

			if arg_468_1.time_ >= var_471_1 + var_471_2 and arg_468_1.time_ < var_471_1 + var_471_2 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.characterEffect1089ui_story then
				local var_471_5 = 0.5

				arg_468_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_468_1.var_.characterEffect1089ui_story.fillRatio = var_471_5
			end

			local var_471_6 = 0
			local var_471_7 = 0.25

			if var_471_6 < arg_468_1.time_ and arg_468_1.time_ <= var_471_6 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_8 = arg_468_1:FormatText(StoryNameCfg[7].name)

				arg_468_1.leftNameTxt_.text = var_471_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, true)
				arg_468_1.iconController_:SetSelectedState("hero")

				arg_468_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_468_1.callingController_:SetSelectedState("normal")

				arg_468_1.keyicon_.color = Color.New(1, 1, 1)
				arg_468_1.icon_.color = Color.New(1, 1, 1)

				local var_471_9 = arg_468_1:GetWordFromCfg(322031114)
				local var_471_10 = arg_468_1:FormatText(var_471_9.content)

				arg_468_1.text_.text = var_471_10

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_11 = 10
				local var_471_12 = utf8.len(var_471_10)
				local var_471_13 = var_471_11 <= 0 and var_471_7 or var_471_7 * (var_471_12 / var_471_11)

				if var_471_13 > 0 and var_471_7 < var_471_13 then
					arg_468_1.talkMaxDuration = var_471_13

					if var_471_13 + var_471_6 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_13 + var_471_6
					end
				end

				arg_468_1.text_.text = var_471_10
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_14 = math.max(var_471_7, arg_468_1.talkMaxDuration)

			if var_471_6 <= arg_468_1.time_ and arg_468_1.time_ < var_471_6 + var_471_14 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_6) / var_471_14

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_6 + var_471_14 and arg_468_1.time_ < var_471_6 + var_471_14 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play322031115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 322031115
		arg_472_1.duration_ = 4.1

		local var_472_0 = {
			zh = 3.3,
			ja = 4.1
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play322031116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["1089ui_story"]
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.characterEffect1089ui_story == nil then
				arg_472_1.var_.characterEffect1089ui_story = var_475_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_2 = 0.200000002980232

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_2 and not isNil(var_475_0) then
				local var_475_3 = (arg_472_1.time_ - var_475_1) / var_475_2

				if arg_472_1.var_.characterEffect1089ui_story and not isNil(var_475_0) then
					arg_472_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_472_1.time_ >= var_475_1 + var_475_2 and arg_472_1.time_ < var_475_1 + var_475_2 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.characterEffect1089ui_story then
				arg_472_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_475_4 = 0

			if var_475_4 < arg_472_1.time_ and arg_472_1.time_ <= var_475_4 + arg_475_0 then
				arg_472_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_475_5 = 0

			if var_475_5 < arg_472_1.time_ and arg_472_1.time_ <= var_475_5 + arg_475_0 then
				arg_472_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_475_6 = 0
			local var_475_7 = 0.375

			if var_475_6 < arg_472_1.time_ and arg_472_1.time_ <= var_475_6 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_8 = arg_472_1:FormatText(StoryNameCfg[1031].name)

				arg_472_1.leftNameTxt_.text = var_475_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_9 = arg_472_1:GetWordFromCfg(322031115)
				local var_475_10 = arg_472_1:FormatText(var_475_9.content)

				arg_472_1.text_.text = var_475_10

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_11 = 15
				local var_475_12 = utf8.len(var_475_10)
				local var_475_13 = var_475_11 <= 0 and var_475_7 or var_475_7 * (var_475_12 / var_475_11)

				if var_475_13 > 0 and var_475_7 < var_475_13 then
					arg_472_1.talkMaxDuration = var_475_13

					if var_475_13 + var_475_6 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_13 + var_475_6
					end
				end

				arg_472_1.text_.text = var_475_10
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031115", "story_v_out_322031.awb") ~= 0 then
					local var_475_14 = manager.audio:GetVoiceLength("story_v_out_322031", "322031115", "story_v_out_322031.awb") / 1000

					if var_475_14 + var_475_6 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_14 + var_475_6
					end

					if var_475_9.prefab_name ~= "" and arg_472_1.actors_[var_475_9.prefab_name] ~= nil then
						local var_475_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_9.prefab_name].transform, "story_v_out_322031", "322031115", "story_v_out_322031.awb")

						arg_472_1:RecordAudio("322031115", var_475_15)
						arg_472_1:RecordAudio("322031115", var_475_15)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_322031", "322031115", "story_v_out_322031.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_322031", "322031115", "story_v_out_322031.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_16 = math.max(var_475_7, arg_472_1.talkMaxDuration)

			if var_475_6 <= arg_472_1.time_ and arg_472_1.time_ < var_475_6 + var_475_16 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_6) / var_475_16

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_6 + var_475_16 and arg_472_1.time_ < var_475_6 + var_475_16 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play322031116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 322031116
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play322031117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = arg_476_1.actors_["1089ui_story"]
			local var_479_1 = 0

			if var_479_1 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect1089ui_story == nil then
				arg_476_1.var_.characterEffect1089ui_story = var_479_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_2 = 0.200000002980232

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_2 and not isNil(var_479_0) then
				local var_479_3 = (arg_476_1.time_ - var_479_1) / var_479_2

				if arg_476_1.var_.characterEffect1089ui_story and not isNil(var_479_0) then
					local var_479_4 = Mathf.Lerp(0, 0.5, var_479_3)

					arg_476_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_476_1.var_.characterEffect1089ui_story.fillRatio = var_479_4
				end
			end

			if arg_476_1.time_ >= var_479_1 + var_479_2 and arg_476_1.time_ < var_479_1 + var_479_2 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect1089ui_story then
				local var_479_5 = 0.5

				arg_476_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_476_1.var_.characterEffect1089ui_story.fillRatio = var_479_5
			end

			local var_479_6 = 0
			local var_479_7 = 0.2

			if var_479_6 < arg_476_1.time_ and arg_476_1.time_ <= var_479_6 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_8 = arg_476_1:FormatText(StoryNameCfg[7].name)

				arg_476_1.leftNameTxt_.text = var_479_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_9 = arg_476_1:GetWordFromCfg(322031116)
				local var_479_10 = arg_476_1:FormatText(var_479_9.content)

				arg_476_1.text_.text = var_479_10

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_11 = 8
				local var_479_12 = utf8.len(var_479_10)
				local var_479_13 = var_479_11 <= 0 and var_479_7 or var_479_7 * (var_479_12 / var_479_11)

				if var_479_13 > 0 and var_479_7 < var_479_13 then
					arg_476_1.talkMaxDuration = var_479_13

					if var_479_13 + var_479_6 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_13 + var_479_6
					end
				end

				arg_476_1.text_.text = var_479_10
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_14 = math.max(var_479_7, arg_476_1.talkMaxDuration)

			if var_479_6 <= arg_476_1.time_ and arg_476_1.time_ < var_479_6 + var_479_14 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_6) / var_479_14

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_6 + var_479_14 and arg_476_1.time_ < var_479_6 + var_479_14 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play322031117 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 322031117
		arg_480_1.duration_ = 9.4

		local var_480_0 = {
			zh = 6.733,
			ja = 9.4
		}
		local var_480_1 = manager.audio:GetLocalizationFlag()

		if var_480_0[var_480_1] ~= nil then
			arg_480_1.duration_ = var_480_0[var_480_1]
		end

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play322031118(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = arg_480_1.actors_["1089ui_story"]
			local var_483_1 = 0

			if var_483_1 < arg_480_1.time_ and arg_480_1.time_ <= var_483_1 + arg_483_0 and not isNil(var_483_0) and arg_480_1.var_.characterEffect1089ui_story == nil then
				arg_480_1.var_.characterEffect1089ui_story = var_483_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_483_2 = 0.200000002980232

			if var_483_1 <= arg_480_1.time_ and arg_480_1.time_ < var_483_1 + var_483_2 and not isNil(var_483_0) then
				local var_483_3 = (arg_480_1.time_ - var_483_1) / var_483_2

				if arg_480_1.var_.characterEffect1089ui_story and not isNil(var_483_0) then
					arg_480_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_480_1.time_ >= var_483_1 + var_483_2 and arg_480_1.time_ < var_483_1 + var_483_2 + arg_483_0 and not isNil(var_483_0) and arg_480_1.var_.characterEffect1089ui_story then
				arg_480_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_483_4 = 0

			if var_483_4 < arg_480_1.time_ and arg_480_1.time_ <= var_483_4 + arg_483_0 then
				arg_480_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			local var_483_5 = 0

			if var_483_5 < arg_480_1.time_ and arg_480_1.time_ <= var_483_5 + arg_483_0 then
				arg_480_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_483_6 = 0
			local var_483_7 = 0.675

			if var_483_6 < arg_480_1.time_ and arg_480_1.time_ <= var_483_6 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_8 = arg_480_1:FormatText(StoryNameCfg[1031].name)

				arg_480_1.leftNameTxt_.text = var_483_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_9 = arg_480_1:GetWordFromCfg(322031117)
				local var_483_10 = arg_480_1:FormatText(var_483_9.content)

				arg_480_1.text_.text = var_483_10

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_11 = 27
				local var_483_12 = utf8.len(var_483_10)
				local var_483_13 = var_483_11 <= 0 and var_483_7 or var_483_7 * (var_483_12 / var_483_11)

				if var_483_13 > 0 and var_483_7 < var_483_13 then
					arg_480_1.talkMaxDuration = var_483_13

					if var_483_13 + var_483_6 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_13 + var_483_6
					end
				end

				arg_480_1.text_.text = var_483_10
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031117", "story_v_out_322031.awb") ~= 0 then
					local var_483_14 = manager.audio:GetVoiceLength("story_v_out_322031", "322031117", "story_v_out_322031.awb") / 1000

					if var_483_14 + var_483_6 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_14 + var_483_6
					end

					if var_483_9.prefab_name ~= "" and arg_480_1.actors_[var_483_9.prefab_name] ~= nil then
						local var_483_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_9.prefab_name].transform, "story_v_out_322031", "322031117", "story_v_out_322031.awb")

						arg_480_1:RecordAudio("322031117", var_483_15)
						arg_480_1:RecordAudio("322031117", var_483_15)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_322031", "322031117", "story_v_out_322031.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_322031", "322031117", "story_v_out_322031.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_16 = math.max(var_483_7, arg_480_1.talkMaxDuration)

			if var_483_6 <= arg_480_1.time_ and arg_480_1.time_ < var_483_6 + var_483_16 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_6) / var_483_16

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_6 + var_483_16 and arg_480_1.time_ < var_483_6 + var_483_16 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play322031118 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 322031118
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play322031119(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = arg_484_1.actors_["1089ui_story"].transform
			local var_487_1 = 0

			if var_487_1 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 then
				arg_484_1.var_.moveOldPos1089ui_story = var_487_0.localPosition
			end

			local var_487_2 = 0.001

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_2 then
				local var_487_3 = (arg_484_1.time_ - var_487_1) / var_487_2
				local var_487_4 = Vector3.New(0, 100, 0)

				var_487_0.localPosition = Vector3.Lerp(arg_484_1.var_.moveOldPos1089ui_story, var_487_4, var_487_3)

				local var_487_5 = manager.ui.mainCamera.transform.position - var_487_0.position

				var_487_0.forward = Vector3.New(var_487_5.x, var_487_5.y, var_487_5.z)

				local var_487_6 = var_487_0.localEulerAngles

				var_487_6.z = 0
				var_487_6.x = 0
				var_487_0.localEulerAngles = var_487_6
			end

			if arg_484_1.time_ >= var_487_1 + var_487_2 and arg_484_1.time_ < var_487_1 + var_487_2 + arg_487_0 then
				var_487_0.localPosition = Vector3.New(0, 100, 0)

				local var_487_7 = manager.ui.mainCamera.transform.position - var_487_0.position

				var_487_0.forward = Vector3.New(var_487_7.x, var_487_7.y, var_487_7.z)

				local var_487_8 = var_487_0.localEulerAngles

				var_487_8.z = 0
				var_487_8.x = 0
				var_487_0.localEulerAngles = var_487_8
			end

			local var_487_9 = arg_484_1.actors_["1089ui_story"]
			local var_487_10 = 0

			if var_487_10 < arg_484_1.time_ and arg_484_1.time_ <= var_487_10 + arg_487_0 and not isNil(var_487_9) and arg_484_1.var_.characterEffect1089ui_story == nil then
				arg_484_1.var_.characterEffect1089ui_story = var_487_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_11 = 0.200000002980232

			if var_487_10 <= arg_484_1.time_ and arg_484_1.time_ < var_487_10 + var_487_11 and not isNil(var_487_9) then
				local var_487_12 = (arg_484_1.time_ - var_487_10) / var_487_11

				if arg_484_1.var_.characterEffect1089ui_story and not isNil(var_487_9) then
					local var_487_13 = Mathf.Lerp(0, 0.5, var_487_12)

					arg_484_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_484_1.var_.characterEffect1089ui_story.fillRatio = var_487_13
				end
			end

			if arg_484_1.time_ >= var_487_10 + var_487_11 and arg_484_1.time_ < var_487_10 + var_487_11 + arg_487_0 and not isNil(var_487_9) and arg_484_1.var_.characterEffect1089ui_story then
				local var_487_14 = 0.5

				arg_484_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_484_1.var_.characterEffect1089ui_story.fillRatio = var_487_14
			end

			local var_487_15 = 0.666666666666667
			local var_487_16 = 1

			if var_487_15 < arg_484_1.time_ and arg_484_1.time_ <= var_487_15 + arg_487_0 then
				local var_487_17 = "play"
				local var_487_18 = "effect"

				arg_484_1:AudioAction(var_487_17, var_487_18, "se_story_145", "se_story_145_draw_gun", "")
			end

			local var_487_19 = manager.ui.mainCamera.transform
			local var_487_20 = 0.766666666666667

			if var_487_20 < arg_484_1.time_ and arg_484_1.time_ <= var_487_20 + arg_487_0 then
				arg_484_1.var_.shakeOldPos = var_487_19.localPosition
			end

			local var_487_21 = 0.233333333333333

			if var_487_20 <= arg_484_1.time_ and arg_484_1.time_ < var_487_20 + var_487_21 then
				local var_487_22 = (arg_484_1.time_ - var_487_20) / 0.165
				local var_487_23, var_487_24 = math.modf(var_487_22)

				var_487_19.localPosition = Vector3.New(var_487_24 * 0.13, var_487_24 * 0.13, var_487_24 * 0.13) + arg_484_1.var_.shakeOldPos
			end

			if arg_484_1.time_ >= var_487_20 + var_487_21 and arg_484_1.time_ < var_487_20 + var_487_21 + arg_487_0 then
				var_487_19.localPosition = arg_484_1.var_.shakeOldPos
			end

			local var_487_25 = 0
			local var_487_26 = 1.4

			if var_487_25 < arg_484_1.time_ and arg_484_1.time_ <= var_487_25 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, false)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_27 = arg_484_1:GetWordFromCfg(322031118)
				local var_487_28 = arg_484_1:FormatText(var_487_27.content)

				arg_484_1.text_.text = var_487_28

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_29 = 56
				local var_487_30 = utf8.len(var_487_28)
				local var_487_31 = var_487_29 <= 0 and var_487_26 or var_487_26 * (var_487_30 / var_487_29)

				if var_487_31 > 0 and var_487_26 < var_487_31 then
					arg_484_1.talkMaxDuration = var_487_31

					if var_487_31 + var_487_25 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_31 + var_487_25
					end
				end

				arg_484_1.text_.text = var_487_28
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_32 = math.max(var_487_26, arg_484_1.talkMaxDuration)

			if var_487_25 <= arg_484_1.time_ and arg_484_1.time_ < var_487_25 + var_487_32 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_25) / var_487_32

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_25 + var_487_32 and arg_484_1.time_ < var_487_25 + var_487_32 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_484_1:InitPlayNodeList()
	end,
	Play322031119 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 322031119
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play322031120(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 0
			local var_491_1 = 0.3

			if var_491_0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_0 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_2 = arg_488_1:FormatText(StoryNameCfg[7].name)

				arg_488_1.leftNameTxt_.text = var_491_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, true)
				arg_488_1.iconController_:SetSelectedState("hero")

				arg_488_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_488_1.callingController_:SetSelectedState("normal")

				arg_488_1.keyicon_.color = Color.New(1, 1, 1)
				arg_488_1.icon_.color = Color.New(1, 1, 1)

				local var_491_3 = arg_488_1:GetWordFromCfg(322031119)
				local var_491_4 = arg_488_1:FormatText(var_491_3.content)

				arg_488_1.text_.text = var_491_4

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_5 = 12
				local var_491_6 = utf8.len(var_491_4)
				local var_491_7 = var_491_5 <= 0 and var_491_1 or var_491_1 * (var_491_6 / var_491_5)

				if var_491_7 > 0 and var_491_1 < var_491_7 then
					arg_488_1.talkMaxDuration = var_491_7

					if var_491_7 + var_491_0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_7 + var_491_0
					end
				end

				arg_488_1.text_.text = var_491_4
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_8 = math.max(var_491_1, arg_488_1.talkMaxDuration)

			if var_491_0 <= arg_488_1.time_ and arg_488_1.time_ < var_491_0 + var_491_8 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_0) / var_491_8

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_0 + var_491_8 and arg_488_1.time_ < var_491_0 + var_491_8 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play322031120 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 322031120
		arg_492_1.duration_ = 9.3

		local var_492_0 = {
			zh = 5.866,
			ja = 9.3
		}
		local var_492_1 = manager.audio:GetLocalizationFlag()

		if var_492_0[var_492_1] ~= nil then
			arg_492_1.duration_ = var_492_0[var_492_1]
		end

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play322031121(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = arg_492_1.actors_["1089ui_story"]
			local var_495_1 = 0

			if var_495_1 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 and not isNil(var_495_0) and arg_492_1.var_.characterEffect1089ui_story == nil then
				arg_492_1.var_.characterEffect1089ui_story = var_495_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_2 = 0.200000002980232

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_2 and not isNil(var_495_0) then
				local var_495_3 = (arg_492_1.time_ - var_495_1) / var_495_2

				if arg_492_1.var_.characterEffect1089ui_story and not isNil(var_495_0) then
					arg_492_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_492_1.time_ >= var_495_1 + var_495_2 and arg_492_1.time_ < var_495_1 + var_495_2 + arg_495_0 and not isNil(var_495_0) and arg_492_1.var_.characterEffect1089ui_story then
				arg_492_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_495_4 = 0

			if var_495_4 < arg_492_1.time_ and arg_492_1.time_ <= var_495_4 + arg_495_0 then
				arg_492_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action4_1")
			end

			local var_495_5 = 0

			if var_495_5 < arg_492_1.time_ and arg_492_1.time_ <= var_495_5 + arg_495_0 then
				arg_492_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_495_6 = arg_492_1.actors_["1089ui_story"].transform
			local var_495_7 = 0

			if var_495_7 < arg_492_1.time_ and arg_492_1.time_ <= var_495_7 + arg_495_0 then
				arg_492_1.var_.moveOldPos1089ui_story = var_495_6.localPosition
			end

			local var_495_8 = 0.001

			if var_495_7 <= arg_492_1.time_ and arg_492_1.time_ < var_495_7 + var_495_8 then
				local var_495_9 = (arg_492_1.time_ - var_495_7) / var_495_8
				local var_495_10 = Vector3.New(0, -1.1, -6.17)

				var_495_6.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos1089ui_story, var_495_10, var_495_9)

				local var_495_11 = manager.ui.mainCamera.transform.position - var_495_6.position

				var_495_6.forward = Vector3.New(var_495_11.x, var_495_11.y, var_495_11.z)

				local var_495_12 = var_495_6.localEulerAngles

				var_495_12.z = 0
				var_495_12.x = 0
				var_495_6.localEulerAngles = var_495_12
			end

			if arg_492_1.time_ >= var_495_7 + var_495_8 and arg_492_1.time_ < var_495_7 + var_495_8 + arg_495_0 then
				var_495_6.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_495_13 = manager.ui.mainCamera.transform.position - var_495_6.position

				var_495_6.forward = Vector3.New(var_495_13.x, var_495_13.y, var_495_13.z)

				local var_495_14 = var_495_6.localEulerAngles

				var_495_14.z = 0
				var_495_14.x = 0
				var_495_6.localEulerAngles = var_495_14
			end

			local var_495_15 = 0
			local var_495_16 = 0.55

			if var_495_15 < arg_492_1.time_ and arg_492_1.time_ <= var_495_15 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_17 = arg_492_1:FormatText(StoryNameCfg[1031].name)

				arg_492_1.leftNameTxt_.text = var_495_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_18 = arg_492_1:GetWordFromCfg(322031120)
				local var_495_19 = arg_492_1:FormatText(var_495_18.content)

				arg_492_1.text_.text = var_495_19

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_20 = 22
				local var_495_21 = utf8.len(var_495_19)
				local var_495_22 = var_495_20 <= 0 and var_495_16 or var_495_16 * (var_495_21 / var_495_20)

				if var_495_22 > 0 and var_495_16 < var_495_22 then
					arg_492_1.talkMaxDuration = var_495_22

					if var_495_22 + var_495_15 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_22 + var_495_15
					end
				end

				arg_492_1.text_.text = var_495_19
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031120", "story_v_out_322031.awb") ~= 0 then
					local var_495_23 = manager.audio:GetVoiceLength("story_v_out_322031", "322031120", "story_v_out_322031.awb") / 1000

					if var_495_23 + var_495_15 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_23 + var_495_15
					end

					if var_495_18.prefab_name ~= "" and arg_492_1.actors_[var_495_18.prefab_name] ~= nil then
						local var_495_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_18.prefab_name].transform, "story_v_out_322031", "322031120", "story_v_out_322031.awb")

						arg_492_1:RecordAudio("322031120", var_495_24)
						arg_492_1:RecordAudio("322031120", var_495_24)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_322031", "322031120", "story_v_out_322031.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_322031", "322031120", "story_v_out_322031.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_25 = math.max(var_495_16, arg_492_1.talkMaxDuration)

			if var_495_15 <= arg_492_1.time_ and arg_492_1.time_ < var_495_15 + var_495_25 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_15) / var_495_25

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_15 + var_495_25 and arg_492_1.time_ < var_495_15 + var_495_25 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	Play322031121 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 322031121
		arg_496_1.duration_ = 6

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play322031122(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = arg_496_1.actors_["1089ui_story"].transform
			local var_499_1 = 0

			if var_499_1 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 then
				arg_496_1.var_.moveOldPos1089ui_story = var_499_0.localPosition
			end

			local var_499_2 = 0.001

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_2 then
				local var_499_3 = (arg_496_1.time_ - var_499_1) / var_499_2
				local var_499_4 = Vector3.New(0, 100, 0)

				var_499_0.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos1089ui_story, var_499_4, var_499_3)

				local var_499_5 = manager.ui.mainCamera.transform.position - var_499_0.position

				var_499_0.forward = Vector3.New(var_499_5.x, var_499_5.y, var_499_5.z)

				local var_499_6 = var_499_0.localEulerAngles

				var_499_6.z = 0
				var_499_6.x = 0
				var_499_0.localEulerAngles = var_499_6
			end

			if arg_496_1.time_ >= var_499_1 + var_499_2 and arg_496_1.time_ < var_499_1 + var_499_2 + arg_499_0 then
				var_499_0.localPosition = Vector3.New(0, 100, 0)

				local var_499_7 = manager.ui.mainCamera.transform.position - var_499_0.position

				var_499_0.forward = Vector3.New(var_499_7.x, var_499_7.y, var_499_7.z)

				local var_499_8 = var_499_0.localEulerAngles

				var_499_8.z = 0
				var_499_8.x = 0
				var_499_0.localEulerAngles = var_499_8
			end

			local var_499_9 = 0.034000001847744
			local var_499_10 = 1

			if var_499_9 < arg_496_1.time_ and arg_496_1.time_ <= var_499_9 + arg_499_0 then
				local var_499_11 = "play"
				local var_499_12 = "effect"

				arg_496_1:AudioAction(var_499_11, var_499_12, "se_story_145", "se_story_145_wind", "")
			end

			local var_499_13 = manager.ui.mainCamera.transform
			local var_499_14 = 0

			if var_499_14 < arg_496_1.time_ and arg_496_1.time_ <= var_499_14 + arg_499_0 then
				local var_499_15 = arg_496_1.var_.effect1121
				local var_499_16
				local var_499_17 = var_499_13

				if not var_499_15 then
					var_499_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), var_499_17)
					var_499_15.name = "1121"
					arg_496_1.var_.effect1121 = var_499_15
				else
					var_499_15.transform:SetParent(var_499_17)
				end

				var_499_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_499_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_499_18 = manager.ui.mainCamera.transform
			local var_499_19 = 1.7

			if var_499_19 < arg_496_1.time_ and arg_496_1.time_ <= var_499_19 + arg_499_0 then
				local var_499_20 = arg_496_1.var_.effect1121

				if var_499_20 then
					Object.Destroy(var_499_20)

					arg_496_1.var_.effect1121 = nil
				end
			end

			local var_499_21 = manager.ui.mainCamera.transform
			local var_499_22 = 0

			if var_499_22 < arg_496_1.time_ and arg_496_1.time_ <= var_499_22 + arg_499_0 then
				arg_496_1.var_.shakeOldPos = var_499_21.localPosition
			end

			local var_499_23 = 0.566666666666667

			if var_499_22 <= arg_496_1.time_ and arg_496_1.time_ < var_499_22 + var_499_23 then
				local var_499_24 = (arg_496_1.time_ - var_499_22) / 0.099
				local var_499_25, var_499_26 = math.modf(var_499_24)

				var_499_21.localPosition = Vector3.New(var_499_26 * 0.05, var_499_26 * 0.05, var_499_26 * 0.05) + arg_496_1.var_.shakeOldPos
			end

			if arg_496_1.time_ >= var_499_22 + var_499_23 and arg_496_1.time_ < var_499_22 + var_499_23 + arg_499_0 then
				var_499_21.localPosition = arg_496_1.var_.shakeOldPos
			end

			if arg_496_1.frameCnt_ <= 1 then
				arg_496_1.dialog_:SetActive(false)
			end

			local var_499_27 = 1
			local var_499_28 = 1.075

			if var_499_27 < arg_496_1.time_ and arg_496_1.time_ <= var_499_27 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0

				arg_496_1.dialog_:SetActive(true)

				arg_496_1.dialogCg_.alpha = 0

				local var_499_29 = LeanTween.value(arg_496_1.dialog_, 0, 1, 0.3)

				var_499_29:setOnUpdate(LuaHelper.FloatAction(function(arg_500_0)
					arg_496_1.dialogCg_.alpha = arg_500_0
				end))
				var_499_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_496_1.dialog_)
					var_499_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_496_1.duration_ = arg_496_1.duration_ + 0.3

				SetActive(arg_496_1.leftNameGo_, false)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_30 = arg_496_1:GetWordFromCfg(322031121)
				local var_499_31 = arg_496_1:FormatText(var_499_30.content)

				arg_496_1.text_.text = var_499_31

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_32 = 43
				local var_499_33 = utf8.len(var_499_31)
				local var_499_34 = var_499_32 <= 0 and var_499_28 or var_499_28 * (var_499_33 / var_499_32)

				if var_499_34 > 0 and var_499_28 < var_499_34 then
					arg_496_1.talkMaxDuration = var_499_34
					var_499_27 = var_499_27 + 0.3

					if var_499_34 + var_499_27 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_34 + var_499_27
					end
				end

				arg_496_1.text_.text = var_499_31
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_35 = var_499_27 + 0.3
			local var_499_36 = math.max(var_499_28, arg_496_1.talkMaxDuration)

			if var_499_35 <= arg_496_1.time_ and arg_496_1.time_ < var_499_35 + var_499_36 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_35) / var_499_36

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_35 + var_499_36 and arg_496_1.time_ < var_499_35 + var_499_36 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play322031122 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 322031122
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play322031123(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0
			local var_505_1 = 0.075

			if var_505_0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_2 = arg_502_1:FormatText(StoryNameCfg[7].name)

				arg_502_1.leftNameTxt_.text = var_505_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_3 = arg_502_1:GetWordFromCfg(322031122)
				local var_505_4 = arg_502_1:FormatText(var_505_3.content)

				arg_502_1.text_.text = var_505_4

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_5 = 3
				local var_505_6 = utf8.len(var_505_4)
				local var_505_7 = var_505_5 <= 0 and var_505_1 or var_505_1 * (var_505_6 / var_505_5)

				if var_505_7 > 0 and var_505_1 < var_505_7 then
					arg_502_1.talkMaxDuration = var_505_7

					if var_505_7 + var_505_0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_7 + var_505_0
					end
				end

				arg_502_1.text_.text = var_505_4
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_8 = math.max(var_505_1, arg_502_1.talkMaxDuration)

			if var_505_0 <= arg_502_1.time_ and arg_502_1.time_ < var_505_0 + var_505_8 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_0) / var_505_8

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_0 + var_505_8 and arg_502_1.time_ < var_505_0 + var_505_8 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play322031123 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 322031123
		arg_506_1.duration_ = 8.73

		local var_506_0 = {
			zh = 5.733,
			ja = 8.733
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play322031124(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = arg_506_1.actors_["1089ui_story"]
			local var_509_1 = 0

			if var_509_1 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 and not isNil(var_509_0) and arg_506_1.var_.characterEffect1089ui_story == nil then
				arg_506_1.var_.characterEffect1089ui_story = var_509_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_2 = 0.200000002980232

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_2 and not isNil(var_509_0) then
				local var_509_3 = (arg_506_1.time_ - var_509_1) / var_509_2

				if arg_506_1.var_.characterEffect1089ui_story and not isNil(var_509_0) then
					arg_506_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= var_509_1 + var_509_2 and arg_506_1.time_ < var_509_1 + var_509_2 + arg_509_0 and not isNil(var_509_0) and arg_506_1.var_.characterEffect1089ui_story then
				arg_506_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_509_4 = 0

			if var_509_4 < arg_506_1.time_ and arg_506_1.time_ <= var_509_4 + arg_509_0 then
				arg_506_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			local var_509_5 = 0

			if var_509_5 < arg_506_1.time_ and arg_506_1.time_ <= var_509_5 + arg_509_0 then
				arg_506_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_509_6 = arg_506_1.actors_["1089ui_story"].transform
			local var_509_7 = 0

			if var_509_7 < arg_506_1.time_ and arg_506_1.time_ <= var_509_7 + arg_509_0 then
				arg_506_1.var_.moveOldPos1089ui_story = var_509_6.localPosition
			end

			local var_509_8 = 0.001

			if var_509_7 <= arg_506_1.time_ and arg_506_1.time_ < var_509_7 + var_509_8 then
				local var_509_9 = (arg_506_1.time_ - var_509_7) / var_509_8
				local var_509_10 = Vector3.New(0, -1.1, -6.17)

				var_509_6.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos1089ui_story, var_509_10, var_509_9)

				local var_509_11 = manager.ui.mainCamera.transform.position - var_509_6.position

				var_509_6.forward = Vector3.New(var_509_11.x, var_509_11.y, var_509_11.z)

				local var_509_12 = var_509_6.localEulerAngles

				var_509_12.z = 0
				var_509_12.x = 0
				var_509_6.localEulerAngles = var_509_12
			end

			if arg_506_1.time_ >= var_509_7 + var_509_8 and arg_506_1.time_ < var_509_7 + var_509_8 + arg_509_0 then
				var_509_6.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_509_13 = manager.ui.mainCamera.transform.position - var_509_6.position

				var_509_6.forward = Vector3.New(var_509_13.x, var_509_13.y, var_509_13.z)

				local var_509_14 = var_509_6.localEulerAngles

				var_509_14.z = 0
				var_509_14.x = 0
				var_509_6.localEulerAngles = var_509_14
			end

			local var_509_15 = 0
			local var_509_16 = 0.7

			if var_509_15 < arg_506_1.time_ and arg_506_1.time_ <= var_509_15 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_17 = arg_506_1:FormatText(StoryNameCfg[1031].name)

				arg_506_1.leftNameTxt_.text = var_509_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_18 = arg_506_1:GetWordFromCfg(322031123)
				local var_509_19 = arg_506_1:FormatText(var_509_18.content)

				arg_506_1.text_.text = var_509_19

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_20 = 28
				local var_509_21 = utf8.len(var_509_19)
				local var_509_22 = var_509_20 <= 0 and var_509_16 or var_509_16 * (var_509_21 / var_509_20)

				if var_509_22 > 0 and var_509_16 < var_509_22 then
					arg_506_1.talkMaxDuration = var_509_22

					if var_509_22 + var_509_15 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_22 + var_509_15
					end
				end

				arg_506_1.text_.text = var_509_19
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031123", "story_v_out_322031.awb") ~= 0 then
					local var_509_23 = manager.audio:GetVoiceLength("story_v_out_322031", "322031123", "story_v_out_322031.awb") / 1000

					if var_509_23 + var_509_15 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_23 + var_509_15
					end

					if var_509_18.prefab_name ~= "" and arg_506_1.actors_[var_509_18.prefab_name] ~= nil then
						local var_509_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_18.prefab_name].transform, "story_v_out_322031", "322031123", "story_v_out_322031.awb")

						arg_506_1:RecordAudio("322031123", var_509_24)
						arg_506_1:RecordAudio("322031123", var_509_24)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_322031", "322031123", "story_v_out_322031.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_322031", "322031123", "story_v_out_322031.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_25 = math.max(var_509_16, arg_506_1.talkMaxDuration)

			if var_509_15 <= arg_506_1.time_ and arg_506_1.time_ < var_509_15 + var_509_25 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_15) / var_509_25

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_15 + var_509_25 and arg_506_1.time_ < var_509_15 + var_509_25 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_506_1:InitPlayNodeList()
	end,
	Play322031124 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 322031124
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play322031125(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = arg_510_1.actors_["1089ui_story"].transform
			local var_513_1 = 0

			if var_513_1 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 then
				arg_510_1.var_.moveOldPos1089ui_story = var_513_0.localPosition
			end

			local var_513_2 = 0.001

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_2 then
				local var_513_3 = (arg_510_1.time_ - var_513_1) / var_513_2
				local var_513_4 = Vector3.New(0, 100, 0)

				var_513_0.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPos1089ui_story, var_513_4, var_513_3)

				local var_513_5 = manager.ui.mainCamera.transform.position - var_513_0.position

				var_513_0.forward = Vector3.New(var_513_5.x, var_513_5.y, var_513_5.z)

				local var_513_6 = var_513_0.localEulerAngles

				var_513_6.z = 0
				var_513_6.x = 0
				var_513_0.localEulerAngles = var_513_6
			end

			if arg_510_1.time_ >= var_513_1 + var_513_2 and arg_510_1.time_ < var_513_1 + var_513_2 + arg_513_0 then
				var_513_0.localPosition = Vector3.New(0, 100, 0)

				local var_513_7 = manager.ui.mainCamera.transform.position - var_513_0.position

				var_513_0.forward = Vector3.New(var_513_7.x, var_513_7.y, var_513_7.z)

				local var_513_8 = var_513_0.localEulerAngles

				var_513_8.z = 0
				var_513_8.x = 0
				var_513_0.localEulerAngles = var_513_8
			end

			local var_513_9 = 0.200000002980232
			local var_513_10 = 1

			if var_513_9 < arg_510_1.time_ and arg_510_1.time_ <= var_513_9 + arg_513_0 then
				local var_513_11 = "play"
				local var_513_12 = "effect"

				arg_510_1:AudioAction(var_513_11, var_513_12, "se_story_143", "se_story_143_foley_cloth02", "")
			end

			local var_513_13 = 0
			local var_513_14 = 1.225

			if var_513_13 < arg_510_1.time_ and arg_510_1.time_ <= var_513_13 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_15 = arg_510_1:GetWordFromCfg(322031124)
				local var_513_16 = arg_510_1:FormatText(var_513_15.content)

				arg_510_1.text_.text = var_513_16

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_17 = 49
				local var_513_18 = utf8.len(var_513_16)
				local var_513_19 = var_513_17 <= 0 and var_513_14 or var_513_14 * (var_513_18 / var_513_17)

				if var_513_19 > 0 and var_513_14 < var_513_19 then
					arg_510_1.talkMaxDuration = var_513_19

					if var_513_19 + var_513_13 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_19 + var_513_13
					end
				end

				arg_510_1.text_.text = var_513_16
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_20 = math.max(var_513_14, arg_510_1.talkMaxDuration)

			if var_513_13 <= arg_510_1.time_ and arg_510_1.time_ < var_513_13 + var_513_20 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_13) / var_513_20

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_13 + var_513_20 and arg_510_1.time_ < var_513_13 + var_513_20 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_510_1:InitPlayNodeList()
	end,
	Play322031125 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 322031125
		arg_514_1.duration_ = 8.77

		local var_514_0 = {
			zh = 5.633,
			ja = 8.766
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play322031126(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = arg_514_1.actors_["1089ui_story"].transform
			local var_517_1 = 0

			if var_517_1 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 then
				arg_514_1.var_.moveOldPos1089ui_story = var_517_0.localPosition
			end

			local var_517_2 = 0.001

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_2 then
				local var_517_3 = (arg_514_1.time_ - var_517_1) / var_517_2
				local var_517_4 = Vector3.New(0, -1.1, -6.17)

				var_517_0.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1089ui_story, var_517_4, var_517_3)

				local var_517_5 = manager.ui.mainCamera.transform.position - var_517_0.position

				var_517_0.forward = Vector3.New(var_517_5.x, var_517_5.y, var_517_5.z)

				local var_517_6 = var_517_0.localEulerAngles

				var_517_6.z = 0
				var_517_6.x = 0
				var_517_0.localEulerAngles = var_517_6
			end

			if arg_514_1.time_ >= var_517_1 + var_517_2 and arg_514_1.time_ < var_517_1 + var_517_2 + arg_517_0 then
				var_517_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_517_7 = manager.ui.mainCamera.transform.position - var_517_0.position

				var_517_0.forward = Vector3.New(var_517_7.x, var_517_7.y, var_517_7.z)

				local var_517_8 = var_517_0.localEulerAngles

				var_517_8.z = 0
				var_517_8.x = 0
				var_517_0.localEulerAngles = var_517_8
			end

			local var_517_9 = arg_514_1.actors_["1089ui_story"]
			local var_517_10 = 0

			if var_517_10 < arg_514_1.time_ and arg_514_1.time_ <= var_517_10 + arg_517_0 and not isNil(var_517_9) and arg_514_1.var_.characterEffect1089ui_story == nil then
				arg_514_1.var_.characterEffect1089ui_story = var_517_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_11 = 0.200000002980232

			if var_517_10 <= arg_514_1.time_ and arg_514_1.time_ < var_517_10 + var_517_11 and not isNil(var_517_9) then
				local var_517_12 = (arg_514_1.time_ - var_517_10) / var_517_11

				if arg_514_1.var_.characterEffect1089ui_story and not isNil(var_517_9) then
					arg_514_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= var_517_10 + var_517_11 and arg_514_1.time_ < var_517_10 + var_517_11 + arg_517_0 and not isNil(var_517_9) and arg_514_1.var_.characterEffect1089ui_story then
				arg_514_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_517_13 = 0

			if var_517_13 < arg_514_1.time_ and arg_514_1.time_ <= var_517_13 + arg_517_0 then
				arg_514_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			local var_517_14 = 0

			if var_517_14 < arg_514_1.time_ and arg_514_1.time_ <= var_517_14 + arg_517_0 then
				arg_514_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_517_15 = 0
			local var_517_16 = 0.6

			if var_517_15 < arg_514_1.time_ and arg_514_1.time_ <= var_517_15 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_17 = arg_514_1:FormatText(StoryNameCfg[1031].name)

				arg_514_1.leftNameTxt_.text = var_517_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_18 = arg_514_1:GetWordFromCfg(322031125)
				local var_517_19 = arg_514_1:FormatText(var_517_18.content)

				arg_514_1.text_.text = var_517_19

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_20 = 24
				local var_517_21 = utf8.len(var_517_19)
				local var_517_22 = var_517_20 <= 0 and var_517_16 or var_517_16 * (var_517_21 / var_517_20)

				if var_517_22 > 0 and var_517_16 < var_517_22 then
					arg_514_1.talkMaxDuration = var_517_22

					if var_517_22 + var_517_15 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_22 + var_517_15
					end
				end

				arg_514_1.text_.text = var_517_19
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031125", "story_v_out_322031.awb") ~= 0 then
					local var_517_23 = manager.audio:GetVoiceLength("story_v_out_322031", "322031125", "story_v_out_322031.awb") / 1000

					if var_517_23 + var_517_15 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_23 + var_517_15
					end

					if var_517_18.prefab_name ~= "" and arg_514_1.actors_[var_517_18.prefab_name] ~= nil then
						local var_517_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_18.prefab_name].transform, "story_v_out_322031", "322031125", "story_v_out_322031.awb")

						arg_514_1:RecordAudio("322031125", var_517_24)
						arg_514_1:RecordAudio("322031125", var_517_24)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_322031", "322031125", "story_v_out_322031.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_322031", "322031125", "story_v_out_322031.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_25 = math.max(var_517_16, arg_514_1.talkMaxDuration)

			if var_517_15 <= arg_514_1.time_ and arg_514_1.time_ < var_517_15 + var_517_25 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_15) / var_517_25

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_15 + var_517_25 and arg_514_1.time_ < var_517_15 + var_517_25 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play322031126 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 322031126
		arg_518_1.duration_ = 6.03

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
			arg_518_1.auto_ = false
		end

		function arg_518_1.playNext_(arg_520_0)
			arg_518_1.onStoryFinished_()
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = arg_518_1.actors_["1089ui_story"].transform
			local var_521_1 = 0.632666664817923

			if var_521_1 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 then
				arg_518_1.var_.moveOldPos1089ui_story = var_521_0.localPosition
			end

			local var_521_2 = 0.001

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_2 then
				local var_521_3 = (arg_518_1.time_ - var_521_1) / var_521_2
				local var_521_4 = Vector3.New(0, 100, 0)

				var_521_0.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos1089ui_story, var_521_4, var_521_3)

				local var_521_5 = manager.ui.mainCamera.transform.position - var_521_0.position

				var_521_0.forward = Vector3.New(var_521_5.x, var_521_5.y, var_521_5.z)

				local var_521_6 = var_521_0.localEulerAngles

				var_521_6.z = 0
				var_521_6.x = 0
				var_521_0.localEulerAngles = var_521_6
			end

			if arg_518_1.time_ >= var_521_1 + var_521_2 and arg_518_1.time_ < var_521_1 + var_521_2 + arg_521_0 then
				var_521_0.localPosition = Vector3.New(0, 100, 0)

				local var_521_7 = manager.ui.mainCamera.transform.position - var_521_0.position

				var_521_0.forward = Vector3.New(var_521_7.x, var_521_7.y, var_521_7.z)

				local var_521_8 = var_521_0.localEulerAngles

				var_521_8.z = 0
				var_521_8.x = 0
				var_521_0.localEulerAngles = var_521_8
			end

			local var_521_9 = 0

			if var_521_9 < arg_518_1.time_ and arg_518_1.time_ <= var_521_9 + arg_521_0 then
				arg_518_1.mask_.enabled = true
				arg_518_1.mask_.raycastTarget = false

				arg_518_1:SetGaussion(false)
			end

			local var_521_10 = 0.666666666665667

			if var_521_9 <= arg_518_1.time_ and arg_518_1.time_ < var_521_9 + var_521_10 then
				local var_521_11 = (arg_518_1.time_ - var_521_9) / var_521_10
				local var_521_12 = Color.New(0, 0, 0)

				var_521_12.a = Mathf.Lerp(0, 1, var_521_11)
				arg_518_1.mask_.color = var_521_12
			end

			if arg_518_1.time_ >= var_521_9 + var_521_10 and arg_518_1.time_ < var_521_9 + var_521_10 + arg_521_0 then
				local var_521_13 = Color.New(0, 0, 0)

				var_521_13.a = 1
				arg_518_1.mask_.color = var_521_13
			end

			local var_521_14 = 0.666666666665667

			if var_521_14 < arg_518_1.time_ and arg_518_1.time_ <= var_521_14 + arg_521_0 then
				arg_518_1.mask_.enabled = true
				arg_518_1.mask_.raycastTarget = false

				arg_518_1:SetGaussion(false)
			end

			local var_521_15 = 0.700000000001

			if var_521_14 <= arg_518_1.time_ and arg_518_1.time_ < var_521_14 + var_521_15 then
				local var_521_16 = (arg_518_1.time_ - var_521_14) / var_521_15
				local var_521_17 = Color.New(0, 0, 0)

				var_521_17.a = Mathf.Lerp(1, 0, var_521_16)
				arg_518_1.mask_.color = var_521_17
			end

			if arg_518_1.time_ >= var_521_14 + var_521_15 and arg_518_1.time_ < var_521_14 + var_521_15 + arg_521_0 then
				local var_521_18 = Color.New(0, 0, 0)
				local var_521_19 = 0

				arg_518_1.mask_.enabled = false
				var_521_18.a = var_521_19
				arg_518_1.mask_.color = var_521_18
			end

			local var_521_20 = 0.666666666665667

			if var_521_20 < arg_518_1.time_ and arg_518_1.time_ <= var_521_20 + arg_521_0 then
				local var_521_21 = manager.ui.mainCamera.transform.localPosition
				local var_521_22 = Vector3.New(0, 0, 10) + Vector3.New(var_521_21.x, var_521_21.y, 0)
				local var_521_23 = arg_518_1.bgs_.STblack

				var_521_23.transform.localPosition = var_521_22
				var_521_23.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_521_24 = var_521_23:GetComponent("SpriteRenderer")

				if var_521_24 and var_521_24.sprite then
					local var_521_25 = (var_521_23.transform.localPosition - var_521_21).z
					local var_521_26 = manager.ui.mainCameraCom_
					local var_521_27 = 2 * var_521_25 * Mathf.Tan(var_521_26.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_521_28 = var_521_27 * var_521_26.aspect
					local var_521_29 = var_521_24.sprite.bounds.size.x
					local var_521_30 = var_521_24.sprite.bounds.size.y
					local var_521_31 = var_521_28 / var_521_29
					local var_521_32 = var_521_27 / var_521_30
					local var_521_33 = var_521_32 < var_521_31 and var_521_31 or var_521_32

					var_521_23.transform.localScale = Vector3.New(var_521_33, var_521_33, 0)
				end

				for iter_521_0, iter_521_1 in pairs(arg_518_1.bgs_) do
					if iter_521_0 ~= "STblack" then
						iter_521_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_521_34 = 0.666666666665667
			local var_521_35 = 5.366
			local var_521_36 = manager.audio:GetVoiceLength("story_v_out_322031", "322031126", "story_v_out_322031.awb") / 1000

			if var_521_36 > 0 and var_521_35 < var_521_36 and var_521_36 + var_521_34 > arg_518_1.duration_ then
				local var_521_37 = var_521_36

				arg_518_1.duration_ = var_521_36 + var_521_34
			end

			if var_521_34 < arg_518_1.time_ and arg_518_1.time_ <= var_521_34 + arg_521_0 then
				local var_521_38 = "play"
				local var_521_39 = "voice"

				arg_518_1:AudioAction(var_521_38, var_521_39, "story_v_out_322031", "322031126", "story_v_out_322031.awb")
			end
		end

		arg_518_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.632666664817923,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322031126,
				charCount = 26,
				enableLayoutChange = true,
				duration = 1.73333333333333,
				groupID = "1126",
				startTime = 0.666666666665667,
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
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_518_1:InitPlayNodeList()
	end,
	Play322031093 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 322031093
		arg_522_1.duration_ = 3.9

		local var_522_0 = {
			zh = 2.366,
			ja = 3.9
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play322031094(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = arg_522_1.actors_["1089ui_story"].transform
			local var_525_1 = 0

			if var_525_1 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 then
				arg_522_1.var_.moveOldPos1089ui_story = var_525_0.localPosition
			end

			local var_525_2 = 0.001

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_2 then
				local var_525_3 = (arg_522_1.time_ - var_525_1) / var_525_2
				local var_525_4 = Vector3.New(0, -1.1, -6.17)

				var_525_0.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos1089ui_story, var_525_4, var_525_3)

				local var_525_5 = manager.ui.mainCamera.transform.position - var_525_0.position

				var_525_0.forward = Vector3.New(var_525_5.x, var_525_5.y, var_525_5.z)

				local var_525_6 = var_525_0.localEulerAngles

				var_525_6.z = 0
				var_525_6.x = 0
				var_525_0.localEulerAngles = var_525_6
			end

			if arg_522_1.time_ >= var_525_1 + var_525_2 and arg_522_1.time_ < var_525_1 + var_525_2 + arg_525_0 then
				var_525_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_525_7 = manager.ui.mainCamera.transform.position - var_525_0.position

				var_525_0.forward = Vector3.New(var_525_7.x, var_525_7.y, var_525_7.z)

				local var_525_8 = var_525_0.localEulerAngles

				var_525_8.z = 0
				var_525_8.x = 0
				var_525_0.localEulerAngles = var_525_8
			end

			local var_525_9 = arg_522_1.actors_["1089ui_story"]
			local var_525_10 = 0

			if var_525_10 < arg_522_1.time_ and arg_522_1.time_ <= var_525_10 + arg_525_0 and not isNil(var_525_9) and arg_522_1.var_.characterEffect1089ui_story == nil then
				arg_522_1.var_.characterEffect1089ui_story = var_525_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_11 = 0.200000002980232

			if var_525_10 <= arg_522_1.time_ and arg_522_1.time_ < var_525_10 + var_525_11 and not isNil(var_525_9) then
				local var_525_12 = (arg_522_1.time_ - var_525_10) / var_525_11

				if arg_522_1.var_.characterEffect1089ui_story and not isNil(var_525_9) then
					arg_522_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_522_1.time_ >= var_525_10 + var_525_11 and arg_522_1.time_ < var_525_10 + var_525_11 + arg_525_0 and not isNil(var_525_9) and arg_522_1.var_.characterEffect1089ui_story then
				arg_522_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_525_13 = "1089ui_story"

			if arg_522_1.actors_[var_525_13] == nil then
				local var_525_14 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_525_14) then
					local var_525_15 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_522_1.stage_.transform)

					var_525_15.name = var_525_13
					var_525_15.transform.localPosition = Vector3.New(0, 100, 0)
					arg_522_1.actors_[var_525_13] = var_525_15

					local var_525_16 = var_525_15:GetComponentInChildren(typeof(CharacterEffect))

					var_525_16.enabled = true

					local var_525_17 = GameObjectTools.GetOrAddComponent(var_525_15, typeof(DynamicBoneHelper))

					if var_525_17 then
						var_525_17:EnableDynamicBone(false)
					end

					arg_522_1:ShowWeapon(var_525_16.transform, false)

					arg_522_1.var_[var_525_13 .. "Animator"] = var_525_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_522_1.var_[var_525_13 .. "Animator"].applyRootMotion = true
					arg_522_1.var_[var_525_13 .. "LipSync"] = var_525_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_525_18 = 0

			if var_525_18 < arg_522_1.time_ and arg_522_1.time_ <= var_525_18 + arg_525_0 then
				arg_522_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			local var_525_19 = "1089ui_story"

			if arg_522_1.actors_[var_525_19] == nil then
				local var_525_20 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_525_20) then
					local var_525_21 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_522_1.stage_.transform)

					var_525_21.name = var_525_19
					var_525_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_522_1.actors_[var_525_19] = var_525_21

					local var_525_22 = var_525_21:GetComponentInChildren(typeof(CharacterEffect))

					var_525_22.enabled = true

					local var_525_23 = GameObjectTools.GetOrAddComponent(var_525_21, typeof(DynamicBoneHelper))

					if var_525_23 then
						var_525_23:EnableDynamicBone(false)
					end

					arg_522_1:ShowWeapon(var_525_22.transform, false)

					arg_522_1.var_[var_525_19 .. "Animator"] = var_525_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_522_1.var_[var_525_19 .. "Animator"].applyRootMotion = true
					arg_522_1.var_[var_525_19 .. "LipSync"] = var_525_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_525_24 = 0

			if var_525_24 < arg_522_1.time_ and arg_522_1.time_ <= var_525_24 + arg_525_0 then
				arg_522_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_525_25 = 0
			local var_525_26 = 0.325

			if var_525_25 < arg_522_1.time_ and arg_522_1.time_ <= var_525_25 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_27 = arg_522_1:FormatText(StoryNameCfg[1031].name)

				arg_522_1.leftNameTxt_.text = var_525_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_28 = arg_522_1:GetWordFromCfg(322031093)
				local var_525_29 = arg_522_1:FormatText(var_525_28.content)

				arg_522_1.text_.text = var_525_29

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_30 = 13
				local var_525_31 = utf8.len(var_525_29)
				local var_525_32 = var_525_30 <= 0 and var_525_26 or var_525_26 * (var_525_31 / var_525_30)

				if var_525_32 > 0 and var_525_26 < var_525_32 then
					arg_522_1.talkMaxDuration = var_525_32

					if var_525_32 + var_525_25 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_32 + var_525_25
					end
				end

				arg_522_1.text_.text = var_525_29
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322031", "322031093", "story_v_out_322031.awb") ~= 0 then
					local var_525_33 = manager.audio:GetVoiceLength("story_v_out_322031", "322031093", "story_v_out_322031.awb") / 1000

					if var_525_33 + var_525_25 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_33 + var_525_25
					end

					if var_525_28.prefab_name ~= "" and arg_522_1.actors_[var_525_28.prefab_name] ~= nil then
						local var_525_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_28.prefab_name].transform, "story_v_out_322031", "322031093", "story_v_out_322031.awb")

						arg_522_1:RecordAudio("322031093", var_525_34)
						arg_522_1:RecordAudio("322031093", var_525_34)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_322031", "322031093", "story_v_out_322031.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_322031", "322031093", "story_v_out_322031.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_35 = math.max(var_525_26, arg_522_1.talkMaxDuration)

			if var_525_25 <= arg_522_1.time_ and arg_522_1.time_ < var_525_25 + var_525_35 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_25) / var_525_35

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_25 + var_525_35 and arg_522_1.time_ < var_525_25 + var_525_35 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_522_1:InitPlayNodeList()
	end,
	Play322031094 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 322031094
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play322031095(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = arg_526_1.actors_["1089ui_story"]
			local var_529_1 = 0

			if var_529_1 < arg_526_1.time_ and arg_526_1.time_ <= var_529_1 + arg_529_0 and not isNil(var_529_0) and arg_526_1.var_.characterEffect1089ui_story == nil then
				arg_526_1.var_.characterEffect1089ui_story = var_529_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_2 = 0.200000002980232

			if var_529_1 <= arg_526_1.time_ and arg_526_1.time_ < var_529_1 + var_529_2 and not isNil(var_529_0) then
				local var_529_3 = (arg_526_1.time_ - var_529_1) / var_529_2

				if arg_526_1.var_.characterEffect1089ui_story and not isNil(var_529_0) then
					local var_529_4 = Mathf.Lerp(0, 0.5, var_529_3)

					arg_526_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_526_1.var_.characterEffect1089ui_story.fillRatio = var_529_4
				end
			end

			if arg_526_1.time_ >= var_529_1 + var_529_2 and arg_526_1.time_ < var_529_1 + var_529_2 + arg_529_0 and not isNil(var_529_0) and arg_526_1.var_.characterEffect1089ui_story then
				local var_529_5 = 0.5

				arg_526_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_526_1.var_.characterEffect1089ui_story.fillRatio = var_529_5
			end

			local var_529_6 = arg_526_1.actors_["1089ui_story"].transform
			local var_529_7 = 0

			if var_529_7 < arg_526_1.time_ and arg_526_1.time_ <= var_529_7 + arg_529_0 then
				arg_526_1.var_.moveOldPos1089ui_story = var_529_6.localPosition
			end

			local var_529_8 = 0.001

			if var_529_7 <= arg_526_1.time_ and arg_526_1.time_ < var_529_7 + var_529_8 then
				local var_529_9 = (arg_526_1.time_ - var_529_7) / var_529_8
				local var_529_10 = Vector3.New(0, -1.1, -6.17)

				var_529_6.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos1089ui_story, var_529_10, var_529_9)

				local var_529_11 = manager.ui.mainCamera.transform.position - var_529_6.position

				var_529_6.forward = Vector3.New(var_529_11.x, var_529_11.y, var_529_11.z)

				local var_529_12 = var_529_6.localEulerAngles

				var_529_12.z = 0
				var_529_12.x = 0
				var_529_6.localEulerAngles = var_529_12
			end

			if arg_526_1.time_ >= var_529_7 + var_529_8 and arg_526_1.time_ < var_529_7 + var_529_8 + arg_529_0 then
				var_529_6.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_529_13 = manager.ui.mainCamera.transform.position - var_529_6.position

				var_529_6.forward = Vector3.New(var_529_13.x, var_529_13.y, var_529_13.z)

				local var_529_14 = var_529_6.localEulerAngles

				var_529_14.z = 0
				var_529_14.x = 0
				var_529_6.localEulerAngles = var_529_14
			end

			local var_529_15 = 0
			local var_529_16 = 0.35

			if var_529_15 < arg_526_1.time_ and arg_526_1.time_ <= var_529_15 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				local var_529_17 = arg_526_1:FormatText(StoryNameCfg[7].name)

				arg_526_1.leftNameTxt_.text = var_529_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, true)
				arg_526_1.iconController_:SetSelectedState("hero")

				arg_526_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_526_1.callingController_:SetSelectedState("normal")

				arg_526_1.keyicon_.color = Color.New(1, 1, 1)
				arg_526_1.icon_.color = Color.New(1, 1, 1)

				local var_529_18 = arg_526_1:GetWordFromCfg(322031094)
				local var_529_19 = arg_526_1:FormatText(var_529_18.content)

				arg_526_1.text_.text = var_529_19

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_20 = 14
				local var_529_21 = utf8.len(var_529_19)
				local var_529_22 = var_529_20 <= 0 and var_529_16 or var_529_16 * (var_529_21 / var_529_20)

				if var_529_22 > 0 and var_529_16 < var_529_22 then
					arg_526_1.talkMaxDuration = var_529_22

					if var_529_22 + var_529_15 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_22 + var_529_15
					end
				end

				arg_526_1.text_.text = var_529_19
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_23 = math.max(var_529_16, arg_526_1.talkMaxDuration)

			if var_529_15 <= arg_526_1.time_ and arg_526_1.time_ < var_529_15 + var_529_23 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_15) / var_529_23

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_15 + var_529_23 and arg_526_1.time_ < var_529_15 + var_529_23 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_526_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L01h",
		"TextureConfig/Background/ST0511a",
		"TextureConfig/Background/ST61a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST0510"
	},
	voices = {
		"story_v_out_322031.awb"
	}
}
