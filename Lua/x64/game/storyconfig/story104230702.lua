return {
	Play423072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423072001
		arg_1_1.duration_ = 6.07

		local var_1_0 = {
			zh = 6.065999999999,
			ja = 4.232999999999
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
				arg_1_0:Play423072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I25h"

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
				local var_4_5 = arg_1_1.bgs_.I25h

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
					if iter_4_0 ~= "I25h" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999999

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

			local var_4_24 = 0.1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			local var_4_28 = 0.466666666666667
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "se_story_16", "se_story_16_gun03", "")
			end

			local var_4_32 = 0
			local var_4_33 = 0.3

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_37 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_37 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_37

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_37
						arg_1_1.bgmTxt2_.text = var_4_37
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

			local var_4_38 = 0.500666666666667
			local var_4_39 = 1

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				local var_4_40 = "play"
				local var_4_41 = "music"

				arg_1_1:AudioAction(var_4_40, var_4_41, "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous.awb")

				local var_4_42 = ""
				local var_4_43 = manager.audio:GetAudioName("bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous")

				if var_4_43 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_43 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_43

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_43
						arg_1_1.bgmTxt2_.text = var_4_43
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

			local var_4_44 = 1.999999999999
			local var_4_45 = 0.3

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_46 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_46:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_47 = arg_1_1:FormatText(StoryNameCfg[1335].name)

				arg_1_1.leftNameTxt_.text = var_4_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_48 = arg_1_1:GetWordFromCfg(423072001)
				local var_4_49 = arg_1_1:FormatText(var_4_48.content)

				arg_1_1.text_.text = var_4_49

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_50 = 12
				local var_4_51 = utf8.len(var_4_49)
				local var_4_52 = var_4_50 <= 0 and var_4_45 or var_4_45 * (var_4_51 / var_4_50)

				if var_4_52 > 0 and var_4_45 < var_4_52 then
					arg_1_1.talkMaxDuration = var_4_52
					var_4_44 = var_4_44 + 0.3

					if var_4_52 + var_4_44 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_52 + var_4_44
					end
				end

				arg_1_1.text_.text = var_4_49
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423072", "423072001", "story_v_out_423072.awb") ~= 0 then
					local var_4_53 = manager.audio:GetVoiceLength("story_v_out_423072", "423072001", "story_v_out_423072.awb") / 1000

					if var_4_53 + var_4_44 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_53 + var_4_44
					end

					if var_4_48.prefab_name ~= "" and arg_1_1.actors_[var_4_48.prefab_name] ~= nil then
						local var_4_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_48.prefab_name].transform, "story_v_out_423072", "423072001", "story_v_out_423072.awb")

						arg_1_1:RecordAudio("423072001", var_4_54)
						arg_1_1:RecordAudio("423072001", var_4_54)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423072", "423072001", "story_v_out_423072.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423072", "423072001", "story_v_out_423072.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_55 = var_4_44 + 0.3
			local var_4_56 = math.max(var_4_45, arg_1_1.talkMaxDuration)

			if var_4_55 <= arg_1_1.time_ and arg_1_1.time_ < var_4_55 + var_4_56 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_55) / var_4_56

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_55 + var_4_56 and arg_1_1.time_ < var_4_55 + var_4_56 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play423072002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423072002
		arg_9_1.duration_ = 5.6

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play423072003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = manager.ui.mainCamera.transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.shakeOldPos = var_12_0.localPosition
			end

			local var_12_2 = 0.6

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / 0.066
				local var_12_4, var_12_5 = math.modf(var_12_3)

				var_12_0.localPosition = Vector3.New(var_12_5 * 0.13, var_12_5 * 0.13, var_12_5 * 0.13) + arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 then
				var_12_0.localPosition = arg_9_1.var_.shakeOldPos
			end

			local var_12_6 = manager.ui.mainCamera.transform
			local var_12_7 = 0

			if var_12_7 < arg_9_1.time_ and arg_9_1.time_ <= var_12_7 + arg_12_0 then
				local var_12_8 = arg_9_1.var_.effectzhuijizhan1
				local var_12_9
				local var_12_10 = var_12_6

				if not var_12_8 then
					var_12_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), var_12_10)
					var_12_8.name = "zhuijizhan1"
					arg_9_1.var_.effectzhuijizhan1 = var_12_8
				else
					var_12_8.transform:SetParent(var_12_10)
				end

				var_12_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_12_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_12_11 = 0

			if var_12_11 < arg_9_1.time_ and arg_9_1.time_ <= var_12_11 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			local var_12_12 = 0.6

			if arg_9_1.time_ >= var_12_11 + var_12_12 and arg_9_1.time_ < var_12_11 + var_12_12 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end

			local var_12_13 = 0.166666666666667
			local var_12_14 = 1

			if var_12_13 < arg_9_1.time_ and arg_9_1.time_ <= var_12_13 + arg_12_0 then
				local var_12_15 = "play"
				local var_12_16 = "effect"

				arg_9_1:AudioAction(var_12_15, var_12_16, "se_story_144", "se_story_144_motorcyclegun", "")
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_17 = 0.6
			local var_12_18 = 1.2

			if var_12_17 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_19 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_19:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_20 = arg_9_1:GetWordFromCfg(423072002)
				local var_12_21 = arg_9_1:FormatText(var_12_20.content)

				arg_9_1.text_.text = var_12_21

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_22 = 48
				local var_12_23 = utf8.len(var_12_21)
				local var_12_24 = var_12_22 <= 0 and var_12_18 or var_12_18 * (var_12_23 / var_12_22)

				if var_12_24 > 0 and var_12_18 < var_12_24 then
					arg_9_1.talkMaxDuration = var_12_24
					var_12_17 = var_12_17 + 0.3

					if var_12_24 + var_12_17 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_24 + var_12_17
					end
				end

				arg_9_1.text_.text = var_12_21
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_25 = var_12_17 + 0.3
			local var_12_26 = math.max(var_12_18, arg_9_1.talkMaxDuration)

			if var_12_25 <= arg_9_1.time_ and arg_9_1.time_ < var_12_25 + var_12_26 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_25) / var_12_26

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_25 + var_12_26 and arg_9_1.time_ < var_12_25 + var_12_26 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play423072003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 423072003
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play423072004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 1.325

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_2 = arg_15_1:GetWordFromCfg(423072003)
				local var_18_3 = arg_15_1:FormatText(var_18_2.content)

				arg_15_1.text_.text = var_18_3

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 53
				local var_18_5 = utf8.len(var_18_3)
				local var_18_6 = var_18_4 <= 0 and var_18_1 or var_18_1 * (var_18_5 / var_18_4)

				if var_18_6 > 0 and var_18_1 < var_18_6 then
					arg_15_1.talkMaxDuration = var_18_6

					if var_18_6 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_6 + var_18_0
					end
				end

				arg_15_1.text_.text = var_18_3
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_1, arg_15_1.talkMaxDuration)

			if var_18_0 <= arg_15_1.time_ and arg_15_1.time_ < var_18_0 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_0) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_0 + var_18_7 and arg_15_1.time_ < var_18_0 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play423072004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 423072004
		arg_19_1.duration_ = 5.2

		local var_19_0 = {
			zh = 4.066,
			ja = 5.2
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play423072005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = "1083"

			if arg_19_1.actors_[var_22_0] == nil then
				local var_22_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

				if not isNil(var_22_1) then
					local var_22_2 = Object.Instantiate(var_22_1, arg_19_1.canvasGo_.transform)

					var_22_2.transform:SetSiblingIndex(1)

					var_22_2.name = var_22_0
					var_22_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_19_1.actors_[var_22_0] = var_22_2

					local var_22_3 = var_22_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_19_1.isInRecall_ then
						for iter_22_0, iter_22_1 in ipairs(var_22_3) do
							iter_22_1.color = arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_22_4 = arg_19_1.actors_["1083"]
			local var_22_5 = 0

			if var_22_5 < arg_19_1.time_ and arg_19_1.time_ <= var_22_5 + arg_22_0 and not isNil(var_22_4) and arg_19_1.var_.actorSpriteComps1083 == nil then
				arg_19_1.var_.actorSpriteComps1083 = var_22_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_6 = 0.2

			if var_22_5 <= arg_19_1.time_ and arg_19_1.time_ < var_22_5 + var_22_6 and not isNil(var_22_4) then
				local var_22_7 = (arg_19_1.time_ - var_22_5) / var_22_6

				if arg_19_1.var_.actorSpriteComps1083 then
					for iter_22_2, iter_22_3 in pairs(arg_19_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_22_3 then
							if arg_19_1.isInRecall_ then
								local var_22_8 = Mathf.Lerp(iter_22_3.color.r, arg_19_1.hightColor1.r, var_22_7)
								local var_22_9 = Mathf.Lerp(iter_22_3.color.g, arg_19_1.hightColor1.g, var_22_7)
								local var_22_10 = Mathf.Lerp(iter_22_3.color.b, arg_19_1.hightColor1.b, var_22_7)

								iter_22_3.color = Color.New(var_22_8, var_22_9, var_22_10)
							else
								local var_22_11 = Mathf.Lerp(iter_22_3.color.r, 1, var_22_7)

								iter_22_3.color = Color.New(var_22_11, var_22_11, var_22_11)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= var_22_5 + var_22_6 and arg_19_1.time_ < var_22_5 + var_22_6 + arg_22_0 and not isNil(var_22_4) and arg_19_1.var_.actorSpriteComps1083 then
				for iter_22_4, iter_22_5 in pairs(arg_19_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_22_5 then
						if arg_19_1.isInRecall_ then
							iter_22_5.color = arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_22_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_19_1.var_.actorSpriteComps1083 = nil
			end

			local var_22_12 = arg_19_1.actors_["1083"].transform
			local var_22_13 = 0

			if var_22_13 < arg_19_1.time_ and arg_19_1.time_ <= var_22_13 + arg_22_0 then
				arg_19_1.var_.moveOldPos1083 = var_22_12.localPosition
				var_22_12.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("1083", 3)

				local var_22_14 = var_22_12.childCount

				for iter_22_6 = 0, var_22_14 - 1 do
					local var_22_15 = var_22_12:GetChild(iter_22_6)

					if var_22_15.name == "split_7" or not string.find(var_22_15.name, "split") then
						var_22_15.gameObject:SetActive(true)
					else
						var_22_15.gameObject:SetActive(false)
					end
				end
			end

			local var_22_16 = 0.001

			if var_22_13 <= arg_19_1.time_ and arg_19_1.time_ < var_22_13 + var_22_16 then
				local var_22_17 = (arg_19_1.time_ - var_22_13) / var_22_16
				local var_22_18 = Vector3.New(-50, -345, -345)

				var_22_12.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1083, var_22_18, var_22_17)
			end

			if arg_19_1.time_ >= var_22_13 + var_22_16 and arg_19_1.time_ < var_22_13 + var_22_16 + arg_22_0 then
				var_22_12.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_22_19 = arg_19_1.actors_["1083"]
			local var_22_20 = 0

			if var_22_20 < arg_19_1.time_ and arg_19_1.time_ <= var_22_20 + arg_22_0 then
				local var_22_21 = var_22_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_22_21 then
					arg_19_1.var_.alphaOldValue1083 = var_22_21.alpha
					arg_19_1.var_.characterEffect1083 = var_22_21
				end

				arg_19_1.var_.alphaOldValue1083 = 0
			end

			local var_22_22 = 0.3

			if var_22_20 <= arg_19_1.time_ and arg_19_1.time_ < var_22_20 + var_22_22 then
				local var_22_23 = (arg_19_1.time_ - var_22_20) / var_22_22
				local var_22_24 = Mathf.Lerp(arg_19_1.var_.alphaOldValue1083, 1, var_22_23)

				if arg_19_1.var_.characterEffect1083 then
					arg_19_1.var_.characterEffect1083.alpha = var_22_24
				end
			end

			if arg_19_1.time_ >= var_22_20 + var_22_22 and arg_19_1.time_ < var_22_20 + var_22_22 + arg_22_0 and arg_19_1.var_.characterEffect1083 then
				arg_19_1.var_.characterEffect1083.alpha = 1
			end

			local var_22_25 = manager.ui.mainCamera.transform
			local var_22_26 = 0

			if var_22_26 < arg_19_1.time_ and arg_19_1.time_ <= var_22_26 + arg_22_0 then
				local var_22_27 = arg_19_1.var_.effectzhuijizhan1

				if var_22_27 then
					Object.Destroy(var_22_27)

					arg_19_1.var_.effectzhuijizhan1 = nil
				end
			end

			local var_22_28 = manager.ui.mainCamera.transform
			local var_22_29 = 0

			if var_22_29 < arg_19_1.time_ and arg_19_1.time_ <= var_22_29 + arg_22_0 then
				local var_22_30 = arg_19_1.var_.effectzhuijizhan2
				local var_22_31
				local var_22_32 = var_22_28

				if not var_22_30 then
					var_22_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_out"), var_22_32)
					var_22_30.name = "zhuijizhan2"
					arg_19_1.var_.effectzhuijizhan2 = var_22_30
				else
					var_22_30.transform:SetParent(var_22_32)
				end

				var_22_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_22_30.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_22_33 = manager.ui.mainCamera.transform
			local var_22_34 = 1

			if var_22_34 < arg_19_1.time_ and arg_19_1.time_ <= var_22_34 + arg_22_0 then
				local var_22_35 = arg_19_1.var_.effectzhuijizhan2

				if var_22_35 then
					Object.Destroy(var_22_35)

					arg_19_1.var_.effectzhuijizhan2 = nil
				end
			end

			local var_22_36 = 0
			local var_22_37 = 0.575

			if var_22_36 < arg_19_1.time_ and arg_19_1.time_ <= var_22_36 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_38 = arg_19_1:FormatText(StoryNameCfg[1332].name)

				arg_19_1.leftNameTxt_.text = var_22_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_39 = arg_19_1:GetWordFromCfg(423072004)
				local var_22_40 = arg_19_1:FormatText(var_22_39.content)

				arg_19_1.text_.text = var_22_40

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_41 = 23
				local var_22_42 = utf8.len(var_22_40)
				local var_22_43 = var_22_41 <= 0 and var_22_37 or var_22_37 * (var_22_42 / var_22_41)

				if var_22_43 > 0 and var_22_37 < var_22_43 then
					arg_19_1.talkMaxDuration = var_22_43

					if var_22_43 + var_22_36 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_43 + var_22_36
					end
				end

				arg_19_1.text_.text = var_22_40
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423072", "423072004", "story_v_out_423072.awb") ~= 0 then
					local var_22_44 = manager.audio:GetVoiceLength("story_v_out_423072", "423072004", "story_v_out_423072.awb") / 1000

					if var_22_44 + var_22_36 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_44 + var_22_36
					end

					if var_22_39.prefab_name ~= "" and arg_19_1.actors_[var_22_39.prefab_name] ~= nil then
						local var_22_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_39.prefab_name].transform, "story_v_out_423072", "423072004", "story_v_out_423072.awb")

						arg_19_1:RecordAudio("423072004", var_22_45)
						arg_19_1:RecordAudio("423072004", var_22_45)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_423072", "423072004", "story_v_out_423072.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_423072", "423072004", "story_v_out_423072.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_46 = math.max(var_22_37, arg_19_1.talkMaxDuration)

			if var_22_36 <= arg_19_1.time_ and arg_19_1.time_ < var_22_36 + var_22_46 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_36) / var_22_46

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_36 + var_22_46 and arg_19_1.time_ < var_22_36 + var_22_46 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play423072005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 423072005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play423072006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1083"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.actorSpriteComps1083 == nil then
				arg_23_1.var_.actorSpriteComps1083 = var_26_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_2 = 0.2

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 and not isNil(var_26_0) then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.actorSpriteComps1083 then
					for iter_26_0, iter_26_1 in pairs(arg_23_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_26_1 then
							if arg_23_1.isInRecall_ then
								local var_26_4 = Mathf.Lerp(iter_26_1.color.r, arg_23_1.hightColor2.r, var_26_3)
								local var_26_5 = Mathf.Lerp(iter_26_1.color.g, arg_23_1.hightColor2.g, var_26_3)
								local var_26_6 = Mathf.Lerp(iter_26_1.color.b, arg_23_1.hightColor2.b, var_26_3)

								iter_26_1.color = Color.New(var_26_4, var_26_5, var_26_6)
							else
								local var_26_7 = Mathf.Lerp(iter_26_1.color.r, 0.5, var_26_3)

								iter_26_1.color = Color.New(var_26_7, var_26_7, var_26_7)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.actorSpriteComps1083 then
				for iter_26_2, iter_26_3 in pairs(arg_23_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_26_3 then
						if arg_23_1.isInRecall_ then
							iter_26_3.color = arg_23_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_26_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_23_1.var_.actorSpriteComps1083 = nil
			end

			local var_26_8 = 0
			local var_26_9 = 0.675

			if var_26_8 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_10 = arg_23_1:FormatText(StoryNameCfg[7].name)

				arg_23_1.leftNameTxt_.text = var_26_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_11 = arg_23_1:GetWordFromCfg(423072005)
				local var_26_12 = arg_23_1:FormatText(var_26_11.content)

				arg_23_1.text_.text = var_26_12

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_13 = 27
				local var_26_14 = utf8.len(var_26_12)
				local var_26_15 = var_26_13 <= 0 and var_26_9 or var_26_9 * (var_26_14 / var_26_13)

				if var_26_15 > 0 and var_26_9 < var_26_15 then
					arg_23_1.talkMaxDuration = var_26_15

					if var_26_15 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_15 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_12
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_16 = math.max(var_26_9, arg_23_1.talkMaxDuration)

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_16 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_8) / var_26_16

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_8 + var_26_16 and arg_23_1.time_ < var_26_8 + var_26_16 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play423072006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 423072006
		arg_27_1.duration_ = 4.3

		local var_27_0 = {
			zh = 4.266,
			ja = 4.3
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play423072007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1083"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.actorSpriteComps1083 == nil then
				arg_27_1.var_.actorSpriteComps1083 = var_30_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_2 = 0.2

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.actorSpriteComps1083 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_30_1 then
							if arg_27_1.isInRecall_ then
								local var_30_4 = Mathf.Lerp(iter_30_1.color.r, arg_27_1.hightColor1.r, var_30_3)
								local var_30_5 = Mathf.Lerp(iter_30_1.color.g, arg_27_1.hightColor1.g, var_30_3)
								local var_30_6 = Mathf.Lerp(iter_30_1.color.b, arg_27_1.hightColor1.b, var_30_3)

								iter_30_1.color = Color.New(var_30_4, var_30_5, var_30_6)
							else
								local var_30_7 = Mathf.Lerp(iter_30_1.color.r, 1, var_30_3)

								iter_30_1.color = Color.New(var_30_7, var_30_7, var_30_7)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.actorSpriteComps1083 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_30_3 then
						if arg_27_1.isInRecall_ then
							iter_30_3.color = arg_27_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_30_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_27_1.var_.actorSpriteComps1083 = nil
			end

			local var_30_8 = arg_27_1.actors_["1083"].transform
			local var_30_9 = 0

			if var_30_9 < arg_27_1.time_ and arg_27_1.time_ <= var_30_9 + arg_30_0 then
				arg_27_1.var_.moveOldPos1083 = var_30_8.localPosition
				var_30_8.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("1083", 3)

				local var_30_10 = var_30_8.childCount

				for iter_30_4 = 0, var_30_10 - 1 do
					local var_30_11 = var_30_8:GetChild(iter_30_4)

					if var_30_11.name == "" or not string.find(var_30_11.name, "split") then
						var_30_11.gameObject:SetActive(true)
					else
						var_30_11.gameObject:SetActive(false)
					end
				end
			end

			local var_30_12 = 0.001

			if var_30_9 <= arg_27_1.time_ and arg_27_1.time_ < var_30_9 + var_30_12 then
				local var_30_13 = (arg_27_1.time_ - var_30_9) / var_30_12
				local var_30_14 = Vector3.New(-50, -345, -345)

				var_30_8.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1083, var_30_14, var_30_13)
			end

			if arg_27_1.time_ >= var_30_9 + var_30_12 and arg_27_1.time_ < var_30_9 + var_30_12 + arg_30_0 then
				var_30_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_30_15 = 0
			local var_30_16 = 0.5

			if var_30_15 < arg_27_1.time_ and arg_27_1.time_ <= var_30_15 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_17 = arg_27_1:FormatText(StoryNameCfg[1332].name)

				arg_27_1.leftNameTxt_.text = var_30_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_18 = arg_27_1:GetWordFromCfg(423072006)
				local var_30_19 = arg_27_1:FormatText(var_30_18.content)

				arg_27_1.text_.text = var_30_19

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_20 = 20
				local var_30_21 = utf8.len(var_30_19)
				local var_30_22 = var_30_20 <= 0 and var_30_16 or var_30_16 * (var_30_21 / var_30_20)

				if var_30_22 > 0 and var_30_16 < var_30_22 then
					arg_27_1.talkMaxDuration = var_30_22

					if var_30_22 + var_30_15 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_22 + var_30_15
					end
				end

				arg_27_1.text_.text = var_30_19
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423072", "423072006", "story_v_out_423072.awb") ~= 0 then
					local var_30_23 = manager.audio:GetVoiceLength("story_v_out_423072", "423072006", "story_v_out_423072.awb") / 1000

					if var_30_23 + var_30_15 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_23 + var_30_15
					end

					if var_30_18.prefab_name ~= "" and arg_27_1.actors_[var_30_18.prefab_name] ~= nil then
						local var_30_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_18.prefab_name].transform, "story_v_out_423072", "423072006", "story_v_out_423072.awb")

						arg_27_1:RecordAudio("423072006", var_30_24)
						arg_27_1:RecordAudio("423072006", var_30_24)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_423072", "423072006", "story_v_out_423072.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_423072", "423072006", "story_v_out_423072.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_25 = math.max(var_30_16, arg_27_1.talkMaxDuration)

			if var_30_15 <= arg_27_1.time_ and arg_27_1.time_ < var_30_15 + var_30_25 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_15) / var_30_25

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_15 + var_30_25 and arg_27_1.time_ < var_30_15 + var_30_25 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play423072007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 423072007
		arg_31_1.duration_ = 7.2

		local var_31_0 = {
			zh = 6.1,
			ja = 7.2
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play423072008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1083"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1083 = var_34_0.localPosition
				var_34_0.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("1083", 3)

				local var_34_2 = var_34_0.childCount

				for iter_34_0 = 0, var_34_2 - 1 do
					local var_34_3 = var_34_0:GetChild(iter_34_0)

					if var_34_3.name == "" or not string.find(var_34_3.name, "split") then
						var_34_3.gameObject:SetActive(true)
					else
						var_34_3.gameObject:SetActive(false)
					end
				end
			end

			local var_34_4 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_4 then
				local var_34_5 = (arg_31_1.time_ - var_34_1) / var_34_4
				local var_34_6 = Vector3.New(-50, -345, -345)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1083, var_34_6, var_34_5)
			end

			if arg_31_1.time_ >= var_34_1 + var_34_4 and arg_31_1.time_ < var_34_1 + var_34_4 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_34_7 = 0
			local var_34_8 = 0.7

			if var_34_7 < arg_31_1.time_ and arg_31_1.time_ <= var_34_7 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_9 = arg_31_1:FormatText(StoryNameCfg[1332].name)

				arg_31_1.leftNameTxt_.text = var_34_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_10 = arg_31_1:GetWordFromCfg(423072007)
				local var_34_11 = arg_31_1:FormatText(var_34_10.content)

				arg_31_1.text_.text = var_34_11

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_12 = 28
				local var_34_13 = utf8.len(var_34_11)
				local var_34_14 = var_34_12 <= 0 and var_34_8 or var_34_8 * (var_34_13 / var_34_12)

				if var_34_14 > 0 and var_34_8 < var_34_14 then
					arg_31_1.talkMaxDuration = var_34_14

					if var_34_14 + var_34_7 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_14 + var_34_7
					end
				end

				arg_31_1.text_.text = var_34_11
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423072", "423072007", "story_v_out_423072.awb") ~= 0 then
					local var_34_15 = manager.audio:GetVoiceLength("story_v_out_423072", "423072007", "story_v_out_423072.awb") / 1000

					if var_34_15 + var_34_7 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_15 + var_34_7
					end

					if var_34_10.prefab_name ~= "" and arg_31_1.actors_[var_34_10.prefab_name] ~= nil then
						local var_34_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_10.prefab_name].transform, "story_v_out_423072", "423072007", "story_v_out_423072.awb")

						arg_31_1:RecordAudio("423072007", var_34_16)
						arg_31_1:RecordAudio("423072007", var_34_16)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_423072", "423072007", "story_v_out_423072.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_423072", "423072007", "story_v_out_423072.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_17 = math.max(var_34_8, arg_31_1.talkMaxDuration)

			if var_34_7 <= arg_31_1.time_ and arg_31_1.time_ < var_34_7 + var_34_17 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_7) / var_34_17

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_7 + var_34_17 and arg_31_1.time_ < var_34_7 + var_34_17 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play423072008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 423072008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play423072009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1083"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.actorSpriteComps1083 == nil then
				arg_35_1.var_.actorSpriteComps1083 = var_38_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_2 = 0.2

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.actorSpriteComps1083 then
					for iter_38_0, iter_38_1 in pairs(arg_35_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_38_1 then
							if arg_35_1.isInRecall_ then
								local var_38_4 = Mathf.Lerp(iter_38_1.color.r, arg_35_1.hightColor2.r, var_38_3)
								local var_38_5 = Mathf.Lerp(iter_38_1.color.g, arg_35_1.hightColor2.g, var_38_3)
								local var_38_6 = Mathf.Lerp(iter_38_1.color.b, arg_35_1.hightColor2.b, var_38_3)

								iter_38_1.color = Color.New(var_38_4, var_38_5, var_38_6)
							else
								local var_38_7 = Mathf.Lerp(iter_38_1.color.r, 0.5, var_38_3)

								iter_38_1.color = Color.New(var_38_7, var_38_7, var_38_7)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.actorSpriteComps1083 then
				for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_38_3 then
						if arg_35_1.isInRecall_ then
							iter_38_3.color = arg_35_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_38_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_35_1.var_.actorSpriteComps1083 = nil
			end

			local var_38_8 = 0
			local var_38_9 = 0.375

			if var_38_8 < arg_35_1.time_ and arg_35_1.time_ <= var_38_8 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_10 = arg_35_1:FormatText(StoryNameCfg[7].name)

				arg_35_1.leftNameTxt_.text = var_38_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_11 = arg_35_1:GetWordFromCfg(423072008)
				local var_38_12 = arg_35_1:FormatText(var_38_11.content)

				arg_35_1.text_.text = var_38_12

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_13 = 15
				local var_38_14 = utf8.len(var_38_12)
				local var_38_15 = var_38_13 <= 0 and var_38_9 or var_38_9 * (var_38_14 / var_38_13)

				if var_38_15 > 0 and var_38_9 < var_38_15 then
					arg_35_1.talkMaxDuration = var_38_15

					if var_38_15 + var_38_8 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_15 + var_38_8
					end
				end

				arg_35_1.text_.text = var_38_12
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
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

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play423072009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 423072009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play423072010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.575

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_2 = arg_39_1:FormatText(StoryNameCfg[7].name)

				arg_39_1.leftNameTxt_.text = var_42_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:GetWordFromCfg(423072009)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 23
				local var_42_6 = utf8.len(var_42_4)
				local var_42_7 = var_42_5 <= 0 and var_42_1 or var_42_1 * (var_42_6 / var_42_5)

				if var_42_7 > 0 and var_42_1 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_8 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_8 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_8

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_8 and arg_39_1.time_ < var_42_0 + var_42_8 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play423072010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 423072010
		arg_43_1.duration_ = 5.47

		local var_43_0 = {
			zh = 5.466,
			ja = 4.866
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
				arg_43_0:Play423072011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = "I25f"

			if arg_43_1.bgs_[var_46_0] == nil then
				local var_46_1 = Object.Instantiate(arg_43_1.paintGo_)

				var_46_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_46_0)
				var_46_1.name = var_46_0
				var_46_1.transform.parent = arg_43_1.stage_.transform
				var_46_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.bgs_[var_46_0] = var_46_1
			end

			local var_46_2 = 2

			if var_46_2 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 then
				local var_46_3 = manager.ui.mainCamera.transform.localPosition
				local var_46_4 = Vector3.New(0, 0, 10) + Vector3.New(var_46_3.x, var_46_3.y, 0)
				local var_46_5 = arg_43_1.bgs_.I25f

				var_46_5.transform.localPosition = var_46_4
				var_46_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_6 = var_46_5:GetComponent("SpriteRenderer")

				if var_46_6 and var_46_6.sprite then
					local var_46_7 = (var_46_5.transform.localPosition - var_46_3).z
					local var_46_8 = manager.ui.mainCameraCom_
					local var_46_9 = 2 * var_46_7 * Mathf.Tan(var_46_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_46_10 = var_46_9 * var_46_8.aspect
					local var_46_11 = var_46_6.sprite.bounds.size.x
					local var_46_12 = var_46_6.sprite.bounds.size.y
					local var_46_13 = var_46_10 / var_46_11
					local var_46_14 = var_46_9 / var_46_12
					local var_46_15 = var_46_14 < var_46_13 and var_46_13 or var_46_14

					var_46_5.transform.localScale = Vector3.New(var_46_15, var_46_15, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "I25f" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_16 = 4

			if var_46_16 < arg_43_1.time_ and arg_43_1.time_ <= var_46_16 + arg_46_0 then
				arg_43_1.allBtn_.enabled = false
			end

			local var_46_17 = 0.3

			if arg_43_1.time_ >= var_46_16 + var_46_17 and arg_43_1.time_ < var_46_16 + var_46_17 + arg_46_0 then
				arg_43_1.allBtn_.enabled = true
			end

			local var_46_18 = 0

			if var_46_18 < arg_43_1.time_ and arg_43_1.time_ <= var_46_18 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_19 = 2

			if var_46_18 <= arg_43_1.time_ and arg_43_1.time_ < var_46_18 + var_46_19 then
				local var_46_20 = (arg_43_1.time_ - var_46_18) / var_46_19
				local var_46_21 = Color.New(0, 0, 0)

				var_46_21.a = Mathf.Lerp(0, 1, var_46_20)
				arg_43_1.mask_.color = var_46_21
			end

			if arg_43_1.time_ >= var_46_18 + var_46_19 and arg_43_1.time_ < var_46_18 + var_46_19 + arg_46_0 then
				local var_46_22 = Color.New(0, 0, 0)

				var_46_22.a = 1
				arg_43_1.mask_.color = var_46_22
			end

			local var_46_23 = 2

			if var_46_23 < arg_43_1.time_ and arg_43_1.time_ <= var_46_23 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_24 = 2

			if var_46_23 <= arg_43_1.time_ and arg_43_1.time_ < var_46_23 + var_46_24 then
				local var_46_25 = (arg_43_1.time_ - var_46_23) / var_46_24
				local var_46_26 = Color.New(0, 0, 0)

				var_46_26.a = Mathf.Lerp(1, 0, var_46_25)
				arg_43_1.mask_.color = var_46_26
			end

			if arg_43_1.time_ >= var_46_23 + var_46_24 and arg_43_1.time_ < var_46_23 + var_46_24 + arg_46_0 then
				local var_46_27 = Color.New(0, 0, 0)
				local var_46_28 = 0

				arg_43_1.mask_.enabled = false
				var_46_27.a = var_46_28
				arg_43_1.mask_.color = var_46_27
			end

			local var_46_29 = arg_43_1.actors_["1083"].transform
			local var_46_30 = 4

			if var_46_30 < arg_43_1.time_ and arg_43_1.time_ <= var_46_30 + arg_46_0 then
				arg_43_1.var_.moveOldPos1083 = var_46_29.localPosition
				var_46_29.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("1083", 3)

				local var_46_31 = var_46_29.childCount

				for iter_46_2 = 0, var_46_31 - 1 do
					local var_46_32 = var_46_29:GetChild(iter_46_2)

					if var_46_32.name == "split_6" or not string.find(var_46_32.name, "split") then
						var_46_32.gameObject:SetActive(true)
					else
						var_46_32.gameObject:SetActive(false)
					end
				end
			end

			local var_46_33 = 0.001

			if var_46_30 <= arg_43_1.time_ and arg_43_1.time_ < var_46_30 + var_46_33 then
				local var_46_34 = (arg_43_1.time_ - var_46_30) / var_46_33
				local var_46_35 = Vector3.New(-50, -345, -345)

				var_46_29.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1083, var_46_35, var_46_34)
			end

			if arg_43_1.time_ >= var_46_30 + var_46_33 and arg_43_1.time_ < var_46_30 + var_46_33 + arg_46_0 then
				var_46_29.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_46_36 = arg_43_1.actors_["1083"]
			local var_46_37 = 4

			if var_46_37 < arg_43_1.time_ and arg_43_1.time_ <= var_46_37 + arg_46_0 and not isNil(var_46_36) and arg_43_1.var_.actorSpriteComps1083 == nil then
				arg_43_1.var_.actorSpriteComps1083 = var_46_36:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_38 = 0.2

			if var_46_37 <= arg_43_1.time_ and arg_43_1.time_ < var_46_37 + var_46_38 and not isNil(var_46_36) then
				local var_46_39 = (arg_43_1.time_ - var_46_37) / var_46_38

				if arg_43_1.var_.actorSpriteComps1083 then
					for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_46_4 then
							if arg_43_1.isInRecall_ then
								local var_46_40 = Mathf.Lerp(iter_46_4.color.r, arg_43_1.hightColor1.r, var_46_39)
								local var_46_41 = Mathf.Lerp(iter_46_4.color.g, arg_43_1.hightColor1.g, var_46_39)
								local var_46_42 = Mathf.Lerp(iter_46_4.color.b, arg_43_1.hightColor1.b, var_46_39)

								iter_46_4.color = Color.New(var_46_40, var_46_41, var_46_42)
							else
								local var_46_43 = Mathf.Lerp(iter_46_4.color.r, 1, var_46_39)

								iter_46_4.color = Color.New(var_46_43, var_46_43, var_46_43)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_37 + var_46_38 and arg_43_1.time_ < var_46_37 + var_46_38 + arg_46_0 and not isNil(var_46_36) and arg_43_1.var_.actorSpriteComps1083 then
				for iter_46_5, iter_46_6 in pairs(arg_43_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_46_6 then
						if arg_43_1.isInRecall_ then
							iter_46_6.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_46_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps1083 = nil
			end

			local var_46_44 = arg_43_1.actors_["1083"].transform
			local var_46_45 = 1.966

			if var_46_45 < arg_43_1.time_ and arg_43_1.time_ <= var_46_45 + arg_46_0 then
				arg_43_1.var_.moveOldPos1083 = var_46_44.localPosition
				var_46_44.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("1083", 7)

				local var_46_46 = var_46_44.childCount

				for iter_46_7 = 0, var_46_46 - 1 do
					local var_46_47 = var_46_44:GetChild(iter_46_7)

					if var_46_47.name == "split_6" or not string.find(var_46_47.name, "split") then
						var_46_47.gameObject:SetActive(true)
					else
						var_46_47.gameObject:SetActive(false)
					end
				end
			end

			local var_46_48 = 0.001

			if var_46_45 <= arg_43_1.time_ and arg_43_1.time_ < var_46_45 + var_46_48 then
				local var_46_49 = (arg_43_1.time_ - var_46_45) / var_46_48
				local var_46_50 = Vector3.New(0, -2000, 0)

				var_46_44.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1083, var_46_50, var_46_49)
			end

			if arg_43_1.time_ >= var_46_45 + var_46_48 and arg_43_1.time_ < var_46_45 + var_46_48 + arg_46_0 then
				var_46_44.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_46_51 = 0.3
			local var_46_52 = 1

			if var_46_51 < arg_43_1.time_ and arg_43_1.time_ <= var_46_51 + arg_46_0 then
				local var_46_53 = "stop"
				local var_46_54 = "effect"

				arg_43_1:AudioAction(var_46_53, var_46_54, "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			local var_46_55 = 1.63333333333333
			local var_46_56 = 1

			if var_46_55 < arg_43_1.time_ and arg_43_1.time_ <= var_46_55 + arg_46_0 then
				local var_46_57 = "play"
				local var_46_58 = "effect"

				arg_43_1:AudioAction(var_46_57, var_46_58, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_59 = 4
			local var_46_60 = 0.1

			if var_46_59 < arg_43_1.time_ and arg_43_1.time_ <= var_46_59 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_61 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_61:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_62 = arg_43_1:FormatText(StoryNameCfg[1341].name)

				arg_43_1.leftNameTxt_.text = var_46_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_63 = arg_43_1:GetWordFromCfg(423072010)
				local var_46_64 = arg_43_1:FormatText(var_46_63.content)

				arg_43_1.text_.text = var_46_64

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_65 = 4
				local var_46_66 = utf8.len(var_46_64)
				local var_46_67 = var_46_65 <= 0 and var_46_60 or var_46_60 * (var_46_66 / var_46_65)

				if var_46_67 > 0 and var_46_60 < var_46_67 then
					arg_43_1.talkMaxDuration = var_46_67
					var_46_59 = var_46_59 + 0.3

					if var_46_67 + var_46_59 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_67 + var_46_59
					end
				end

				arg_43_1.text_.text = var_46_64
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423072", "423072010", "story_v_out_423072.awb") ~= 0 then
					local var_46_68 = manager.audio:GetVoiceLength("story_v_out_423072", "423072010", "story_v_out_423072.awb") / 1000

					if var_46_68 + var_46_59 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_68 + var_46_59
					end

					if var_46_63.prefab_name ~= "" and arg_43_1.actors_[var_46_63.prefab_name] ~= nil then
						local var_46_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_63.prefab_name].transform, "story_v_out_423072", "423072010", "story_v_out_423072.awb")

						arg_43_1:RecordAudio("423072010", var_46_69)
						arg_43_1:RecordAudio("423072010", var_46_69)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_423072", "423072010", "story_v_out_423072.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_423072", "423072010", "story_v_out_423072.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_70 = var_46_59 + 0.3
			local var_46_71 = math.max(var_46_60, arg_43_1.talkMaxDuration)

			if var_46_70 <= arg_43_1.time_ and arg_43_1.time_ < var_46_70 + var_46_71 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_70) / var_46_71

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_70 + var_46_71 and arg_43_1.time_ < var_46_70 + var_46_71 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play423072011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 423072011
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play423072012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1083"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1083 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1083", 7)

				local var_52_2 = var_52_0.childCount

				for iter_52_0 = 0, var_52_2 - 1 do
					local var_52_3 = var_52_0:GetChild(iter_52_0)

					if var_52_3.name == "" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_4 then
				local var_52_5 = (arg_49_1.time_ - var_52_1) / var_52_4
				local var_52_6 = Vector3.New(0, -2000, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1083, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_7 = 0
			local var_52_8 = 1.175

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_9 = arg_49_1:GetWordFromCfg(423072011)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 47
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_8 or var_52_8 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_8 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_7 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_7
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_8, arg_49_1.talkMaxDuration)

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_7) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_7 + var_52_14 and arg_49_1.time_ < var_52_7 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play423072012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 423072012
		arg_53_1.duration_ = 3.63

		local var_53_0 = {
			zh = 2.6,
			ja = 3.633
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
				arg_53_0:Play423072013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1083"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1083 == nil then
				arg_53_1.var_.actorSpriteComps1083 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps1083 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								local var_56_4 = Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor1.r, var_56_3)
								local var_56_5 = Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor1.g, var_56_3)
								local var_56_6 = Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor1.b, var_56_3)

								iter_56_1.color = Color.New(var_56_4, var_56_5, var_56_6)
							else
								local var_56_7 = Mathf.Lerp(iter_56_1.color.r, 1, var_56_3)

								iter_56_1.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1083 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1083 = nil
			end

			local var_56_8 = arg_53_1.actors_["1083"].transform
			local var_56_9 = 0

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 then
				arg_53_1.var_.moveOldPos1083 = var_56_8.localPosition
				var_56_8.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1083", 3)

				local var_56_10 = var_56_8.childCount

				for iter_56_4 = 0, var_56_10 - 1 do
					local var_56_11 = var_56_8:GetChild(iter_56_4)

					if var_56_11.name == "split_3" or not string.find(var_56_11.name, "split") then
						var_56_11.gameObject:SetActive(true)
					else
						var_56_11.gameObject:SetActive(false)
					end
				end
			end

			local var_56_12 = 0.001

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_12 then
				local var_56_13 = (arg_53_1.time_ - var_56_9) / var_56_12
				local var_56_14 = Vector3.New(-50, -345, -345)

				var_56_8.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1083, var_56_14, var_56_13)
			end

			if arg_53_1.time_ >= var_56_9 + var_56_12 and arg_53_1.time_ < var_56_9 + var_56_12 + arg_56_0 then
				var_56_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_56_15 = 0
			local var_56_16 = 0.325

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_17 = arg_53_1:FormatText(StoryNameCfg[1332].name)

				arg_53_1.leftNameTxt_.text = var_56_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_18 = arg_53_1:GetWordFromCfg(423072012)
				local var_56_19 = arg_53_1:FormatText(var_56_18.content)

				arg_53_1.text_.text = var_56_19

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_20 = 13
				local var_56_21 = utf8.len(var_56_19)
				local var_56_22 = var_56_20 <= 0 and var_56_16 or var_56_16 * (var_56_21 / var_56_20)

				if var_56_22 > 0 and var_56_16 < var_56_22 then
					arg_53_1.talkMaxDuration = var_56_22

					if var_56_22 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_22 + var_56_15
					end
				end

				arg_53_1.text_.text = var_56_19
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423072", "423072012", "story_v_out_423072.awb") ~= 0 then
					local var_56_23 = manager.audio:GetVoiceLength("story_v_out_423072", "423072012", "story_v_out_423072.awb") / 1000

					if var_56_23 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_15
					end

					if var_56_18.prefab_name ~= "" and arg_53_1.actors_[var_56_18.prefab_name] ~= nil then
						local var_56_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_18.prefab_name].transform, "story_v_out_423072", "423072012", "story_v_out_423072.awb")

						arg_53_1:RecordAudio("423072012", var_56_24)
						arg_53_1:RecordAudio("423072012", var_56_24)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_423072", "423072012", "story_v_out_423072.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_423072", "423072012", "story_v_out_423072.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_25 = math.max(var_56_16, arg_53_1.talkMaxDuration)

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_25 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_15) / var_56_25

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_15 + var_56_25 and arg_53_1.time_ < var_56_15 + var_56_25 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play423072013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 423072013
		arg_57_1.duration_ = 3.47

		local var_57_0 = {
			zh = 3.466,
			ja = 2.2
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
			arg_57_1.auto_ = false
		end

		function arg_57_1.playNext_(arg_59_0)
			arg_57_1.onStoryFinished_()
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.225

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[1332].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(423072013)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_423072", "423072013", "story_v_out_423072.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_423072", "423072013", "story_v_out_423072.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_423072", "423072013", "story_v_out_423072.awb")

						arg_57_1:RecordAudio("423072013", var_60_9)
						arg_57_1:RecordAudio("423072013", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_423072", "423072013", "story_v_out_423072.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_423072", "423072013", "story_v_out_423072.awb")
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
	assets = {
		"TextureConfig/Background/I25h",
		"TextureConfig/Background/I25f"
	},
	voices = {
		"story_v_out_423072.awb"
	}
}
