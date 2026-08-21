return {
	Play114202001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114202001
		arg_1_1.duration_ = 4.9

		local var_1_0 = {
			ja = 4.9,
			ko = 3.866
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
				arg_1_0:Play114202002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_1 = 2

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_1 then
				local var_4_2 = (arg_1_1.time_ - var_4_0) / var_4_1
				local var_4_3 = Color.New(0, 0, 0)

				var_4_3.a = Mathf.Lerp(1, 0, var_4_2)
				arg_1_1.mask_.color = var_4_3
			end

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				local var_4_4 = Color.New(0, 0, 0)
				local var_4_5 = 0

				arg_1_1.mask_.enabled = false
				var_4_4.a = var_4_5
				arg_1_1.mask_.color = var_4_4
			end

			local var_4_6 = "F04"

			if arg_1_1.bgs_[var_4_6] == nil then
				local var_4_7 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_6)
				var_4_7.name = var_4_6
				var_4_7.transform.parent = arg_1_1.stage_.transform
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_6] = var_4_7
			end

			local var_4_8 = 0

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				local var_4_9 = manager.ui.mainCamera.transform.localPosition
				local var_4_10 = Vector3.New(0, 0, 10) + Vector3.New(var_4_9.x, var_4_9.y, 0)
				local var_4_11 = arg_1_1.bgs_.F04

				var_4_11.transform.localPosition = var_4_10
				var_4_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_12 = var_4_11:GetComponent("SpriteRenderer")

				if var_4_12 and var_4_12.sprite then
					local var_4_13 = (var_4_11.transform.localPosition - var_4_9).z
					local var_4_14 = manager.ui.mainCameraCom_
					local var_4_15 = 2 * var_4_13 * Mathf.Tan(var_4_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_16 = var_4_15 * var_4_14.aspect
					local var_4_17 = var_4_12.sprite.bounds.size.x
					local var_4_18 = var_4_12.sprite.bounds.size.y
					local var_4_19 = var_4_16 / var_4_17
					local var_4_20 = var_4_15 / var_4_18
					local var_4_21 = var_4_20 < var_4_19 and var_4_19 or var_4_20

					var_4_11.transform.localScale = Vector3.New(var_4_21, var_4_21, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F04" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_22 = 0
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 2
			local var_4_29 = 0.333333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 2
			local var_4_35 = 0.05

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[234].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_38 = arg_1_1:GetWordFromCfg(114202001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 2
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202001", "story_v_out_114202.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_114202", "114202001", "story_v_out_114202.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_114202", "114202001", "story_v_out_114202.awb")

						arg_1_1:RecordAudio("114202001", var_4_44)
						arg_1_1:RecordAudio("114202001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_114202", "114202001", "story_v_out_114202.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_114202", "114202001", "story_v_out_114202.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_34 + 0.3
			local var_4_46 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play114202002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114202002
		arg_9_1.duration_ = 3.2

		local var_9_0 = {
			ja = 3.2,
			ko = 1.933,
			zh = 1.433,
			en = 1.1
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
				arg_9_0:Play114202003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.15

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[209].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(114202002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202002", "story_v_out_114202.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_114202", "114202002", "story_v_out_114202.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_114202", "114202002", "story_v_out_114202.awb")

						arg_9_1:RecordAudio("114202002", var_12_9)
						arg_9_1:RecordAudio("114202002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_114202", "114202002", "story_v_out_114202.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_114202", "114202002", "story_v_out_114202.awb")
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
	Play114202003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114202003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play114202004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.95

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(114202003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 38
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play114202004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114202004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play114202005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.65

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(114202004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 26
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play114202005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114202005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play114202006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.25

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(114202005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 50
				local var_24_5 = utf8.len(var_24_3)
				local var_24_6 = var_24_4 <= 0 and var_24_1 or var_24_1 * (var_24_5 / var_24_4)

				if var_24_6 > 0 and var_24_1 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_7 and arg_21_1.time_ < var_24_0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play114202006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114202006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play114202007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.65

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(114202006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 26
				local var_28_5 = utf8.len(var_28_3)
				local var_28_6 = var_28_4 <= 0 and var_28_1 or var_28_1 * (var_28_5 / var_28_4)

				if var_28_6 > 0 and var_28_1 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_7 and arg_25_1.time_ < var_28_0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play114202007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114202007
		arg_29_1.duration_ = 4.53

		local var_29_0 = {
			ja = 2.6,
			ko = 1.833,
			zh = 1.766,
			en = 4.533
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
				arg_29_0:Play114202008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "10017"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Object.Instantiate(arg_29_1.imageGo_, arg_29_1.canvasGo_.transform)

				var_32_1.transform:SetSiblingIndex(1)

				var_32_1.name = var_32_0

				local var_32_2 = var_32_1:GetComponent(typeof(Image))

				var_32_2.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10017")

				var_32_2:SetNativeSize()

				var_32_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_29_1.actors_[var_32_0] = var_32_1
			end

			local var_32_3 = arg_29_1.actors_["10017"].transform
			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.var_.moveOldPos10017 = var_32_3.localPosition
				var_32_3.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10017", 2)
			end

			local var_32_5 = 0.001

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_5 then
				local var_32_6 = (arg_29_1.time_ - var_32_4) / var_32_5
				local var_32_7 = Vector3.New(-390, -350, -180)

				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10017, var_32_7, var_32_6)
			end

			if arg_29_1.time_ >= var_32_4 + var_32_5 and arg_29_1.time_ < var_32_4 + var_32_5 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_32_8 = arg_29_1.actors_["10017"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) then
				local var_32_10 = var_32_8:GetComponent("Image")

				if var_32_10 then
					arg_29_1.var_.highlightMatValue10017 = var_32_10
				end
			end

			local var_32_11 = 0.034

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_11 and not isNil(var_32_8) then
				local var_32_12 = (arg_29_1.time_ - var_32_9) / var_32_11

				if arg_29_1.var_.highlightMatValue10017 then
					local var_32_13 = Mathf.Lerp(0.5, 1, var_32_12)
					local var_32_14 = arg_29_1.var_.highlightMatValue10017
					local var_32_15 = var_32_14.color

					var_32_15.r = var_32_13
					var_32_15.g = var_32_13
					var_32_15.b = var_32_13
					var_32_14.color = var_32_15
				end
			end

			if arg_29_1.time_ >= var_32_9 + var_32_11 and arg_29_1.time_ < var_32_9 + var_32_11 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.highlightMatValue10017 then
				local var_32_16 = 1

				var_32_8.transform:SetSiblingIndex(1)

				local var_32_17 = arg_29_1.var_.highlightMatValue10017
				local var_32_18 = var_32_17.color

				var_32_18.r = var_32_16
				var_32_18.g = var_32_16
				var_32_18.b = var_32_16
				var_32_17.color = var_32_18
			end

			local var_32_19 = arg_29_1.actors_["10017"]
			local var_32_20 = 0

			if var_32_20 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 then
				local var_32_21 = var_32_19:GetComponent("Image")

				if var_32_21 then
					arg_29_1.var_.alphaMatValue10017 = var_32_21
					arg_29_1.var_.alphaOldValue10017 = var_32_21.color.a
				end

				arg_29_1.var_.alphaOldValue10017 = 0
			end

			local var_32_22 = 0.5

			if var_32_20 <= arg_29_1.time_ and arg_29_1.time_ < var_32_20 + var_32_22 then
				local var_32_23 = (arg_29_1.time_ - var_32_20) / var_32_22
				local var_32_24 = Mathf.Lerp(arg_29_1.var_.alphaOldValue10017, 1, var_32_23)

				if arg_29_1.var_.alphaMatValue10017 then
					local var_32_25 = arg_29_1.var_.alphaMatValue10017.color

					var_32_25.a = var_32_24
					arg_29_1.var_.alphaMatValue10017.color = var_32_25
				end
			end

			if arg_29_1.time_ >= var_32_20 + var_32_22 and arg_29_1.time_ < var_32_20 + var_32_22 + arg_32_0 and arg_29_1.var_.alphaMatValue10017 then
				local var_32_26 = arg_29_1.var_.alphaMatValue10017
				local var_32_27 = var_32_26.color

				var_32_27.a = 1
				var_32_26.color = var_32_27
			end

			local var_32_28 = 0
			local var_32_29 = 0.175

			if var_32_28 < arg_29_1.time_ and arg_29_1.time_ <= var_32_28 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_30 = arg_29_1:FormatText(StoryNameCfg[255].name)

				arg_29_1.leftNameTxt_.text = var_32_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_31 = arg_29_1:GetWordFromCfg(114202007)
				local var_32_32 = arg_29_1:FormatText(var_32_31.content)

				arg_29_1.text_.text = var_32_32

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_33 = 7
				local var_32_34 = utf8.len(var_32_32)
				local var_32_35 = var_32_33 <= 0 and var_32_29 or var_32_29 * (var_32_34 / var_32_33)

				if var_32_35 > 0 and var_32_29 < var_32_35 then
					arg_29_1.talkMaxDuration = var_32_35

					if var_32_35 + var_32_28 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_35 + var_32_28
					end
				end

				arg_29_1.text_.text = var_32_32
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202007", "story_v_out_114202.awb") ~= 0 then
					local var_32_36 = manager.audio:GetVoiceLength("story_v_out_114202", "114202007", "story_v_out_114202.awb") / 1000

					if var_32_36 + var_32_28 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_36 + var_32_28
					end

					if var_32_31.prefab_name ~= "" and arg_29_1.actors_[var_32_31.prefab_name] ~= nil then
						local var_32_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_31.prefab_name].transform, "story_v_out_114202", "114202007", "story_v_out_114202.awb")

						arg_29_1:RecordAudio("114202007", var_32_37)
						arg_29_1:RecordAudio("114202007", var_32_37)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_114202", "114202007", "story_v_out_114202.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_114202", "114202007", "story_v_out_114202.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_38 = math.max(var_32_29, arg_29_1.talkMaxDuration)

			if var_32_28 <= arg_29_1.time_ and arg_29_1.time_ < var_32_28 + var_32_38 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_28) / var_32_38

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_28 + var_32_38 and arg_29_1.time_ < var_32_28 + var_32_38 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play114202008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114202008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play114202009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10017"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) then
				local var_36_2 = var_36_0:GetComponent("Image")

				if var_36_2 then
					arg_33_1.var_.highlightMatValue10017 = var_36_2
				end
			end

			local var_36_3 = 0.5

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_3 and not isNil(var_36_0) then
				local var_36_4 = (arg_33_1.time_ - var_36_1) / var_36_3

				if arg_33_1.var_.highlightMatValue10017 then
					local var_36_5 = Mathf.Lerp(1, 0.5, var_36_4)
					local var_36_6 = arg_33_1.var_.highlightMatValue10017
					local var_36_7 = var_36_6.color

					var_36_7.r = var_36_5
					var_36_7.g = var_36_5
					var_36_7.b = var_36_5
					var_36_6.color = var_36_7
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_3 and arg_33_1.time_ < var_36_1 + var_36_3 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.highlightMatValue10017 then
				local var_36_8 = 0.5
				local var_36_9 = arg_33_1.var_.highlightMatValue10017
				local var_36_10 = var_36_9.color

				var_36_10.r = var_36_8
				var_36_10.g = var_36_8
				var_36_10.b = var_36_8
				var_36_9.color = var_36_10
			end

			local var_36_11 = 0
			local var_36_12 = 1

			if var_36_11 < arg_33_1.time_ and arg_33_1.time_ <= var_36_11 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_13 = arg_33_1:GetWordFromCfg(114202008)
				local var_36_14 = arg_33_1:FormatText(var_36_13.content)

				arg_33_1.text_.text = var_36_14

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_15 = 40
				local var_36_16 = utf8.len(var_36_14)
				local var_36_17 = var_36_15 <= 0 and var_36_12 or var_36_12 * (var_36_16 / var_36_15)

				if var_36_17 > 0 and var_36_12 < var_36_17 then
					arg_33_1.talkMaxDuration = var_36_17

					if var_36_17 + var_36_11 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_17 + var_36_11
					end
				end

				arg_33_1.text_.text = var_36_14
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_18 = math.max(var_36_12, arg_33_1.talkMaxDuration)

			if var_36_11 <= arg_33_1.time_ and arg_33_1.time_ < var_36_11 + var_36_18 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_11) / var_36_18

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_11 + var_36_18 and arg_33_1.time_ < var_36_11 + var_36_18 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play114202009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114202009
		arg_37_1.duration_ = 1.23

		local var_37_0 = {
			ja = 1.233,
			ko = 1.1,
			zh = 1.133,
			en = 1.2
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
				arg_37_0:Play114202010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = "10015"

			if arg_37_1.actors_[var_40_0] == nil then
				local var_40_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10015")

				if not isNil(var_40_1) then
					local var_40_2 = Object.Instantiate(var_40_1, arg_37_1.canvasGo_.transform)

					var_40_2.transform:SetSiblingIndex(1)

					var_40_2.name = var_40_0
					var_40_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_37_1.actors_[var_40_0] = var_40_2

					local var_40_3 = var_40_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_37_1.isInRecall_ then
						for iter_40_0, iter_40_1 in ipairs(var_40_3) do
							iter_40_1.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_40_4 = arg_37_1.actors_["10015"].transform
			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.var_.moveOldPos10015 = var_40_4.localPosition
				var_40_4.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10015", 4)

				local var_40_6 = var_40_4.childCount

				for iter_40_2 = 0, var_40_6 - 1 do
					local var_40_7 = var_40_4:GetChild(iter_40_2)

					if var_40_7.name == "split_1" or not string.find(var_40_7.name, "split") then
						var_40_7.gameObject:SetActive(true)
					else
						var_40_7.gameObject:SetActive(false)
					end
				end
			end

			local var_40_8 = 0.001

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_8 then
				local var_40_9 = (arg_37_1.time_ - var_40_5) / var_40_8
				local var_40_10 = Vector3.New(390, -350, -180)

				var_40_4.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10015, var_40_10, var_40_9)
			end

			if arg_37_1.time_ >= var_40_5 + var_40_8 and arg_37_1.time_ < var_40_5 + var_40_8 + arg_40_0 then
				var_40_4.localPosition = Vector3.New(390, -350, -180)
			end

			local var_40_11 = arg_37_1.actors_["10015"]
			local var_40_12 = 0

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 and not isNil(var_40_11) and arg_37_1.var_.actorSpriteComps10015 == nil then
				arg_37_1.var_.actorSpriteComps10015 = var_40_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_13 = 0.034

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_13 and not isNil(var_40_11) then
				local var_40_14 = (arg_37_1.time_ - var_40_12) / var_40_13

				if arg_37_1.var_.actorSpriteComps10015 then
					for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_40_4 then
							if arg_37_1.isInRecall_ then
								local var_40_15 = Mathf.Lerp(iter_40_4.color.r, arg_37_1.hightColor1.r, var_40_14)
								local var_40_16 = Mathf.Lerp(iter_40_4.color.g, arg_37_1.hightColor1.g, var_40_14)
								local var_40_17 = Mathf.Lerp(iter_40_4.color.b, arg_37_1.hightColor1.b, var_40_14)

								iter_40_4.color = Color.New(var_40_15, var_40_16, var_40_17)
							else
								local var_40_18 = Mathf.Lerp(iter_40_4.color.r, 1, var_40_14)

								iter_40_4.color = Color.New(var_40_18, var_40_18, var_40_18)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_12 + var_40_13 and arg_37_1.time_ < var_40_12 + var_40_13 + arg_40_0 and not isNil(var_40_11) and arg_37_1.var_.actorSpriteComps10015 then
				for iter_40_5, iter_40_6 in pairs(arg_37_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_40_6 then
						if arg_37_1.isInRecall_ then
							iter_40_6.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10015 = nil
			end

			local var_40_19 = arg_37_1.actors_["10015"]
			local var_40_20 = 0

			if var_40_20 < arg_37_1.time_ and arg_37_1.time_ <= var_40_20 + arg_40_0 then
				local var_40_21 = var_40_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_40_21 then
					arg_37_1.var_.alphaOldValue10015 = var_40_21.alpha
					arg_37_1.var_.characterEffect10015 = var_40_21
				end

				arg_37_1.var_.alphaOldValue10015 = 0
			end

			local var_40_22 = 0.5

			if var_40_20 <= arg_37_1.time_ and arg_37_1.time_ < var_40_20 + var_40_22 then
				local var_40_23 = (arg_37_1.time_ - var_40_20) / var_40_22
				local var_40_24 = Mathf.Lerp(arg_37_1.var_.alphaOldValue10015, 1, var_40_23)

				if arg_37_1.var_.characterEffect10015 then
					arg_37_1.var_.characterEffect10015.alpha = var_40_24
				end
			end

			if arg_37_1.time_ >= var_40_20 + var_40_22 and arg_37_1.time_ < var_40_20 + var_40_22 + arg_40_0 and arg_37_1.var_.characterEffect10015 then
				arg_37_1.var_.characterEffect10015.alpha = 1
			end

			local var_40_25 = 0
			local var_40_26 = 0.075

			if var_40_25 < arg_37_1.time_ and arg_37_1.time_ <= var_40_25 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_27 = arg_37_1:FormatText(StoryNameCfg[208].name)

				arg_37_1.leftNameTxt_.text = var_40_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_28 = arg_37_1:GetWordFromCfg(114202009)
				local var_40_29 = arg_37_1:FormatText(var_40_28.content)

				arg_37_1.text_.text = var_40_29

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_30 = 3
				local var_40_31 = utf8.len(var_40_29)
				local var_40_32 = var_40_30 <= 0 and var_40_26 or var_40_26 * (var_40_31 / var_40_30)

				if var_40_32 > 0 and var_40_26 < var_40_32 then
					arg_37_1.talkMaxDuration = var_40_32

					if var_40_32 + var_40_25 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_32 + var_40_25
					end
				end

				arg_37_1.text_.text = var_40_29
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202009", "story_v_out_114202.awb") ~= 0 then
					local var_40_33 = manager.audio:GetVoiceLength("story_v_out_114202", "114202009", "story_v_out_114202.awb") / 1000

					if var_40_33 + var_40_25 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_33 + var_40_25
					end

					if var_40_28.prefab_name ~= "" and arg_37_1.actors_[var_40_28.prefab_name] ~= nil then
						local var_40_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_28.prefab_name].transform, "story_v_out_114202", "114202009", "story_v_out_114202.awb")

						arg_37_1:RecordAudio("114202009", var_40_34)
						arg_37_1:RecordAudio("114202009", var_40_34)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114202", "114202009", "story_v_out_114202.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114202", "114202009", "story_v_out_114202.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_35 = math.max(var_40_26, arg_37_1.talkMaxDuration)

			if var_40_25 <= arg_37_1.time_ and arg_37_1.time_ < var_40_25 + var_40_35 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_25) / var_40_35

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_25 + var_40_35 and arg_37_1.time_ < var_40_25 + var_40_35 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play114202010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114202010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play114202011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10015"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10015 == nil then
				arg_41_1.var_.actorSpriteComps10015 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.034

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps10015 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								local var_44_4 = Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor2.r, var_44_3)
								local var_44_5 = Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor2.g, var_44_3)
								local var_44_6 = Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor2.b, var_44_3)

								iter_44_1.color = Color.New(var_44_4, var_44_5, var_44_6)
							else
								local var_44_7 = Mathf.Lerp(iter_44_1.color.r, 0.5, var_44_3)

								iter_44_1.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10015 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10015 = nil
			end

			local var_44_8 = 0
			local var_44_9 = 0.6

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(114202010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_12 = 24
				local var_44_13 = utf8.len(var_44_11)
				local var_44_14 = var_44_12 <= 0 and var_44_9 or var_44_9 * (var_44_13 / var_44_12)

				if var_44_14 > 0 and var_44_9 < var_44_14 then
					arg_41_1.talkMaxDuration = var_44_14

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_15 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_15 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_15

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_15 and arg_41_1.time_ < var_44_8 + var_44_15 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play114202011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114202011
		arg_45_1.duration_ = 3.1

		local var_45_0 = {
			ja = 3.1,
			ko = 2.466,
			zh = 1.5,
			en = 1.466
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
				arg_45_0:Play114202012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10015"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10015 == nil then
				arg_45_1.var_.actorSpriteComps10015 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.034

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps10015 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								local var_48_4 = Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor1.r, var_48_3)
								local var_48_5 = Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor1.g, var_48_3)
								local var_48_6 = Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor1.b, var_48_3)

								iter_48_1.color = Color.New(var_48_4, var_48_5, var_48_6)
							else
								local var_48_7 = Mathf.Lerp(iter_48_1.color.r, 1, var_48_3)

								iter_48_1.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10015 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10015 = nil
			end

			local var_48_8 = arg_45_1.actors_["10015"].transform
			local var_48_9 = 0

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1.var_.moveOldPos10015 = var_48_8.localPosition
				var_48_8.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10015", 4)

				local var_48_10 = var_48_8.childCount

				for iter_48_4 = 0, var_48_10 - 1 do
					local var_48_11 = var_48_8:GetChild(iter_48_4)

					if var_48_11.name == "split_2" or not string.find(var_48_11.name, "split") then
						var_48_11.gameObject:SetActive(true)
					else
						var_48_11.gameObject:SetActive(false)
					end
				end
			end

			local var_48_12 = 0.001

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_12 then
				local var_48_13 = (arg_45_1.time_ - var_48_9) / var_48_12
				local var_48_14 = Vector3.New(390, -350, -180)

				var_48_8.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10015, var_48_14, var_48_13)
			end

			if arg_45_1.time_ >= var_48_9 + var_48_12 and arg_45_1.time_ < var_48_9 + var_48_12 + arg_48_0 then
				var_48_8.localPosition = Vector3.New(390, -350, -180)
			end

			local var_48_15 = 0
			local var_48_16 = 0.15

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_17 = arg_45_1:FormatText(StoryNameCfg[208].name)

				arg_45_1.leftNameTxt_.text = var_48_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_18 = arg_45_1:GetWordFromCfg(114202011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_20 = 6
				local var_48_21 = utf8.len(var_48_19)
				local var_48_22 = var_48_20 <= 0 and var_48_16 or var_48_16 * (var_48_21 / var_48_20)

				if var_48_22 > 0 and var_48_16 < var_48_22 then
					arg_45_1.talkMaxDuration = var_48_22

					if var_48_22 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_22 + var_48_15
					end
				end

				arg_45_1.text_.text = var_48_19
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202011", "story_v_out_114202.awb") ~= 0 then
					local var_48_23 = manager.audio:GetVoiceLength("story_v_out_114202", "114202011", "story_v_out_114202.awb") / 1000

					if var_48_23 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_15
					end

					if var_48_18.prefab_name ~= "" and arg_45_1.actors_[var_48_18.prefab_name] ~= nil then
						local var_48_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_18.prefab_name].transform, "story_v_out_114202", "114202011", "story_v_out_114202.awb")

						arg_45_1:RecordAudio("114202011", var_48_24)
						arg_45_1:RecordAudio("114202011", var_48_24)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_114202", "114202011", "story_v_out_114202.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_114202", "114202011", "story_v_out_114202.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_16, arg_45_1.talkMaxDuration)

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_15) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_15 + var_48_25 and arg_45_1.time_ < var_48_15 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play114202012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114202012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play114202013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10015"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10015 == nil then
				arg_49_1.var_.actorSpriteComps10015 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.034

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps10015 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								local var_52_4 = Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor2.r, var_52_3)
								local var_52_5 = Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor2.g, var_52_3)
								local var_52_6 = Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor2.b, var_52_3)

								iter_52_1.color = Color.New(var_52_4, var_52_5, var_52_6)
							else
								local var_52_7 = Mathf.Lerp(iter_52_1.color.r, 0.5, var_52_3)

								iter_52_1.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10015 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10015 = nil
			end

			local var_52_8 = 0
			local var_52_9 = 0.625

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:GetWordFromCfg(114202012)
				local var_52_11 = arg_49_1:FormatText(var_52_10.content)

				arg_49_1.text_.text = var_52_11

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_12 = 25
				local var_52_13 = utf8.len(var_52_11)
				local var_52_14 = var_52_12 <= 0 and var_52_9 or var_52_9 * (var_52_13 / var_52_12)

				if var_52_14 > 0 and var_52_9 < var_52_14 then
					arg_49_1.talkMaxDuration = var_52_14

					if var_52_14 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_11
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_15 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_15 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_15

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_15 and arg_49_1.time_ < var_52_8 + var_52_15 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114202013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114202013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play114202014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10015"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10015 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10015", 7)

				local var_56_2 = var_56_0.childCount

				for iter_56_0 = 0, var_56_2 - 1 do
					local var_56_3 = var_56_0:GetChild(iter_56_0)

					if var_56_3.name == "split_2" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_4 then
				local var_56_5 = (arg_53_1.time_ - var_56_1) / var_56_4
				local var_56_6 = Vector3.New(0, -2000, -180)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10015, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_56_7 = arg_53_1.actors_["10015"].transform
			local var_56_8 = 0

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.var_.moveOldPos10015 = var_56_7.localPosition
				var_56_7.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10015", 3)

				local var_56_9 = var_56_7.childCount

				for iter_56_1 = 0, var_56_9 - 1 do
					local var_56_10 = var_56_7:GetChild(iter_56_1)

					if var_56_10.name == "split_1" or not string.find(var_56_10.name, "split") then
						var_56_10.gameObject:SetActive(true)
					else
						var_56_10.gameObject:SetActive(false)
					end
				end
			end

			local var_56_11 = 0.001

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_11 then
				local var_56_12 = (arg_53_1.time_ - var_56_8) / var_56_11
				local var_56_13 = Vector3.New(0, -350, -180)

				var_56_7.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10015, var_56_13, var_56_12)
			end

			if arg_53_1.time_ >= var_56_8 + var_56_11 and arg_53_1.time_ < var_56_8 + var_56_11 + arg_56_0 then
				var_56_7.localPosition = Vector3.New(0, -350, -180)
			end

			local var_56_14 = arg_53_1.actors_["10017"]
			local var_56_15 = 0

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 and not isNil(var_56_14) then
				local var_56_16 = var_56_14:GetComponent("Image")

				if var_56_16 then
					arg_53_1.var_.highlightMatValue10017 = var_56_16
				end
			end

			local var_56_17 = 0.034

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_17 and not isNil(var_56_14) then
				local var_56_18 = (arg_53_1.time_ - var_56_15) / var_56_17

				if arg_53_1.var_.highlightMatValue10017 then
					local var_56_19 = Mathf.Lerp(1, 0.5, var_56_18)
					local var_56_20 = arg_53_1.var_.highlightMatValue10017
					local var_56_21 = var_56_20.color

					var_56_21.r = var_56_19
					var_56_21.g = var_56_19
					var_56_21.b = var_56_19
					var_56_20.color = var_56_21
				end
			end

			if arg_53_1.time_ >= var_56_15 + var_56_17 and arg_53_1.time_ < var_56_15 + var_56_17 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.highlightMatValue10017 then
				local var_56_22 = 0.5
				local var_56_23 = arg_53_1.var_.highlightMatValue10017
				local var_56_24 = var_56_23.color

				var_56_24.r = var_56_22
				var_56_24.g = var_56_22
				var_56_24.b = var_56_22
				var_56_23.color = var_56_24
			end

			local var_56_25 = arg_53_1.actors_["10015"]
			local var_56_26 = 0

			if var_56_26 < arg_53_1.time_ and arg_53_1.time_ <= var_56_26 + arg_56_0 then
				local var_56_27 = var_56_25:GetComponentInChildren(typeof(CanvasGroup))

				if var_56_27 then
					arg_53_1.var_.alphaOldValue10015 = var_56_27.alpha
					arg_53_1.var_.characterEffect10015 = var_56_27
				end

				arg_53_1.var_.alphaOldValue10015 = 0
			end

			local var_56_28 = 0.5

			if var_56_26 <= arg_53_1.time_ and arg_53_1.time_ < var_56_26 + var_56_28 then
				local var_56_29 = (arg_53_1.time_ - var_56_26) / var_56_28
				local var_56_30 = Mathf.Lerp(arg_53_1.var_.alphaOldValue10015, 1, var_56_29)

				if arg_53_1.var_.characterEffect10015 then
					arg_53_1.var_.characterEffect10015.alpha = var_56_30
				end
			end

			if arg_53_1.time_ >= var_56_26 + var_56_28 and arg_53_1.time_ < var_56_26 + var_56_28 + arg_56_0 and arg_53_1.var_.characterEffect10015 then
				arg_53_1.var_.characterEffect10015.alpha = 1
			end

			local var_56_31 = arg_53_1.actors_["10017"].transform
			local var_56_32 = 0

			if var_56_32 < arg_53_1.time_ and arg_53_1.time_ <= var_56_32 + arg_56_0 then
				arg_53_1.var_.moveOldPos10017 = var_56_31.localPosition
				var_56_31.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10017", 7)
			end

			local var_56_33 = 0.001

			if var_56_32 <= arg_53_1.time_ and arg_53_1.time_ < var_56_32 + var_56_33 then
				local var_56_34 = (arg_53_1.time_ - var_56_32) / var_56_33
				local var_56_35 = Vector3.New(0, -2000, 300)

				var_56_31.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10017, var_56_35, var_56_34)
			end

			if arg_53_1.time_ >= var_56_32 + var_56_33 and arg_53_1.time_ < var_56_32 + var_56_33 + arg_56_0 then
				var_56_31.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_56_36 = arg_53_1.actors_["10015"]
			local var_56_37 = 0

			if var_56_37 < arg_53_1.time_ and arg_53_1.time_ <= var_56_37 + arg_56_0 and not isNil(var_56_36) and arg_53_1.var_.actorSpriteComps10015 == nil then
				arg_53_1.var_.actorSpriteComps10015 = var_56_36:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_38 = 0.034

			if var_56_37 <= arg_53_1.time_ and arg_53_1.time_ < var_56_37 + var_56_38 and not isNil(var_56_36) then
				local var_56_39 = (arg_53_1.time_ - var_56_37) / var_56_38

				if arg_53_1.var_.actorSpriteComps10015 then
					for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_56_3 then
							if arg_53_1.isInRecall_ then
								local var_56_40 = Mathf.Lerp(iter_56_3.color.r, arg_53_1.hightColor1.r, var_56_39)
								local var_56_41 = Mathf.Lerp(iter_56_3.color.g, arg_53_1.hightColor1.g, var_56_39)
								local var_56_42 = Mathf.Lerp(iter_56_3.color.b, arg_53_1.hightColor1.b, var_56_39)

								iter_56_3.color = Color.New(var_56_40, var_56_41, var_56_42)
							else
								local var_56_43 = Mathf.Lerp(iter_56_3.color.r, 1, var_56_39)

								iter_56_3.color = Color.New(var_56_43, var_56_43, var_56_43)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_37 + var_56_38 and arg_53_1.time_ < var_56_37 + var_56_38 + arg_56_0 and not isNil(var_56_36) and arg_53_1.var_.actorSpriteComps10015 then
				for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_56_5 then
						if arg_53_1.isInRecall_ then
							iter_56_5.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10015 = nil
			end

			local var_56_44 = 0
			local var_56_45 = 0.675

			if var_56_44 < arg_53_1.time_ and arg_53_1.time_ <= var_56_44 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_46 = arg_53_1:GetWordFromCfg(114202013)
				local var_56_47 = arg_53_1:FormatText(var_56_46.content)

				arg_53_1.text_.text = var_56_47

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_48 = 27
				local var_56_49 = utf8.len(var_56_47)
				local var_56_50 = var_56_48 <= 0 and var_56_45 or var_56_45 * (var_56_49 / var_56_48)

				if var_56_50 > 0 and var_56_45 < var_56_50 then
					arg_53_1.talkMaxDuration = var_56_50

					if var_56_50 + var_56_44 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_50 + var_56_44
					end
				end

				arg_53_1.text_.text = var_56_47
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_51 = math.max(var_56_45, arg_53_1.talkMaxDuration)

			if var_56_44 <= arg_53_1.time_ and arg_53_1.time_ < var_56_44 + var_56_51 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_44) / var_56_51

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_44 + var_56_51 and arg_53_1.time_ < var_56_44 + var_56_51 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play114202014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114202014
		arg_57_1.duration_ = 10.2

		local var_57_0 = {
			ja = 10.2,
			ko = 5.733,
			zh = 5.4,
			en = 6.833
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
				arg_57_0:Play114202015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10015"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10015 == nil then
				arg_57_1.var_.actorSpriteComps10015 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.034

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps10015 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								local var_60_4 = Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor1.r, var_60_3)
								local var_60_5 = Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor1.g, var_60_3)
								local var_60_6 = Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor1.b, var_60_3)

								iter_60_1.color = Color.New(var_60_4, var_60_5, var_60_6)
							else
								local var_60_7 = Mathf.Lerp(iter_60_1.color.r, 1, var_60_3)

								iter_60_1.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10015 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10015 = nil
			end

			local var_60_8 = 0
			local var_60_9 = 0.7

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_10 = arg_57_1:FormatText(StoryNameCfg[208].name)

				arg_57_1.leftNameTxt_.text = var_60_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_11 = arg_57_1:GetWordFromCfg(114202014)
				local var_60_12 = arg_57_1:FormatText(var_60_11.content)

				arg_57_1.text_.text = var_60_12

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 27
				local var_60_14 = utf8.len(var_60_12)
				local var_60_15 = var_60_13 <= 0 and var_60_9 or var_60_9 * (var_60_14 / var_60_13)

				if var_60_15 > 0 and var_60_9 < var_60_15 then
					arg_57_1.talkMaxDuration = var_60_15

					if var_60_15 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_12
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202014", "story_v_out_114202.awb") ~= 0 then
					local var_60_16 = manager.audio:GetVoiceLength("story_v_out_114202", "114202014", "story_v_out_114202.awb") / 1000

					if var_60_16 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_16 + var_60_8
					end

					if var_60_11.prefab_name ~= "" and arg_57_1.actors_[var_60_11.prefab_name] ~= nil then
						local var_60_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_11.prefab_name].transform, "story_v_out_114202", "114202014", "story_v_out_114202.awb")

						arg_57_1:RecordAudio("114202014", var_60_17)
						arg_57_1:RecordAudio("114202014", var_60_17)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_114202", "114202014", "story_v_out_114202.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_114202", "114202014", "story_v_out_114202.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_18 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_18 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_18

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_18 and arg_57_1.time_ < var_60_8 + var_60_18 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play114202015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114202015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play114202016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10015"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				local var_64_2 = var_64_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_64_2 then
					arg_61_1.var_.alphaOldValue10015 = var_64_2.alpha
					arg_61_1.var_.characterEffect10015 = var_64_2
				end

				arg_61_1.var_.alphaOldValue10015 = 1
			end

			local var_64_3 = 0.5

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_3 then
				local var_64_4 = (arg_61_1.time_ - var_64_1) / var_64_3
				local var_64_5 = Mathf.Lerp(arg_61_1.var_.alphaOldValue10015, 0, var_64_4)

				if arg_61_1.var_.characterEffect10015 then
					arg_61_1.var_.characterEffect10015.alpha = var_64_5
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_3 and arg_61_1.time_ < var_64_1 + var_64_3 + arg_64_0 and arg_61_1.var_.characterEffect10015 then
				arg_61_1.var_.characterEffect10015.alpha = 0
			end

			local var_64_6 = 0
			local var_64_7 = 0.8

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:GetWordFromCfg(114202015)
				local var_64_9 = arg_61_1:FormatText(var_64_8.content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 32
				local var_64_11 = utf8.len(var_64_9)
				local var_64_12 = var_64_10 <= 0 and var_64_7 or var_64_7 * (var_64_11 / var_64_10)

				if var_64_12 > 0 and var_64_7 < var_64_12 then
					arg_61_1.talkMaxDuration = var_64_12

					if var_64_12 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_13 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_13 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_13

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_13 and arg_61_1.time_ < var_64_6 + var_64_13 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play114202016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114202016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play114202017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 1.175

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(114202016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 47
				local var_68_5 = utf8.len(var_68_3)
				local var_68_6 = var_68_4 <= 0 and var_68_1 or var_68_1 * (var_68_5 / var_68_4)

				if var_68_6 > 0 and var_68_1 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_7 and arg_65_1.time_ < var_68_0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play114202017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114202017
		arg_69_1.duration_ = 9

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play114202018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = "ST21"

			if arg_69_1.bgs_[var_72_0] == nil then
				local var_72_1 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_72_0)
				var_72_1.name = var_72_0
				var_72_1.transform.parent = arg_69_1.stage_.transform
				var_72_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_[var_72_0] = var_72_1
			end

			local var_72_2 = 2

			if var_72_2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				local var_72_3 = manager.ui.mainCamera.transform.localPosition
				local var_72_4 = Vector3.New(0, 0, 10) + Vector3.New(var_72_3.x, var_72_3.y, 0)
				local var_72_5 = arg_69_1.bgs_.ST21

				var_72_5.transform.localPosition = var_72_4
				var_72_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_6 = var_72_5:GetComponent("SpriteRenderer")

				if var_72_6 and var_72_6.sprite then
					local var_72_7 = (var_72_5.transform.localPosition - var_72_3).z
					local var_72_8 = manager.ui.mainCameraCom_
					local var_72_9 = 2 * var_72_7 * Mathf.Tan(var_72_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_72_10 = var_72_9 * var_72_8.aspect
					local var_72_11 = var_72_6.sprite.bounds.size.x
					local var_72_12 = var_72_6.sprite.bounds.size.y
					local var_72_13 = var_72_10 / var_72_11
					local var_72_14 = var_72_9 / var_72_12
					local var_72_15 = var_72_14 < var_72_13 and var_72_13 or var_72_14

					var_72_5.transform.localScale = Vector3.New(var_72_15, var_72_15, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "ST21" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_17 = 1.999999999999

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_17 then
				local var_72_18 = (arg_69_1.time_ - var_72_16) / var_72_17
				local var_72_19 = Color.New(0, 0, 0)

				var_72_19.a = Mathf.Lerp(0, 1, var_72_18)
				arg_69_1.mask_.color = var_72_19
			end

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 then
				local var_72_20 = Color.New(0, 0, 0)

				var_72_20.a = 1
				arg_69_1.mask_.color = var_72_20
			end

			local var_72_21 = 1.999999999999

			if var_72_21 < arg_69_1.time_ and arg_69_1.time_ <= var_72_21 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_22 = 2

			if var_72_21 <= arg_69_1.time_ and arg_69_1.time_ < var_72_21 + var_72_22 then
				local var_72_23 = (arg_69_1.time_ - var_72_21) / var_72_22
				local var_72_24 = Color.New(0, 0, 0)

				var_72_24.a = Mathf.Lerp(1, 0, var_72_23)
				arg_69_1.mask_.color = var_72_24
			end

			if arg_69_1.time_ >= var_72_21 + var_72_22 and arg_69_1.time_ < var_72_21 + var_72_22 + arg_72_0 then
				local var_72_25 = Color.New(0, 0, 0)
				local var_72_26 = 0

				arg_69_1.mask_.enabled = false
				var_72_25.a = var_72_26
				arg_69_1.mask_.color = var_72_25
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_27 = 3.999999999999
			local var_72_28 = 0.175

			if var_72_27 < arg_69_1.time_ and arg_69_1.time_ <= var_72_27 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_29 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_29:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_30 = arg_69_1:GetWordFromCfg(114202017)
				local var_72_31 = arg_69_1:FormatText(var_72_30.content)

				arg_69_1.text_.text = var_72_31

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_32 = 7
				local var_72_33 = utf8.len(var_72_31)
				local var_72_34 = var_72_32 <= 0 and var_72_28 or var_72_28 * (var_72_33 / var_72_32)

				if var_72_34 > 0 and var_72_28 < var_72_34 then
					arg_69_1.talkMaxDuration = var_72_34
					var_72_27 = var_72_27 + 0.3

					if var_72_34 + var_72_27 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_34 + var_72_27
					end
				end

				arg_69_1.text_.text = var_72_31
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_35 = var_72_27 + 0.3
			local var_72_36 = math.max(var_72_28, arg_69_1.talkMaxDuration)

			if var_72_35 <= arg_69_1.time_ and arg_69_1.time_ < var_72_35 + var_72_36 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_35) / var_72_36

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_35 + var_72_36 and arg_69_1.time_ < var_72_35 + var_72_36 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114202018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 114202018
		arg_75_1.duration_ = 6.53

		local var_75_0 = {
			ja = 6.533,
			ko = 5.766,
			zh = 3.866,
			en = 5.666
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play114202019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["10017"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos10017 = var_78_0.localPosition
				var_78_0.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("10017", 2)
			end

			local var_78_2 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(-390, -350, -180)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10017, var_78_4, var_78_3)
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_78_5 = arg_75_1.actors_["10017"]
			local var_78_6 = 0

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 and not isNil(var_78_5) then
				local var_78_7 = var_78_5:GetComponent("Image")

				if var_78_7 then
					arg_75_1.var_.highlightMatValue10017 = var_78_7
				end
			end

			local var_78_8 = 0.034

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_8 and not isNil(var_78_5) then
				local var_78_9 = (arg_75_1.time_ - var_78_6) / var_78_8

				if arg_75_1.var_.highlightMatValue10017 then
					local var_78_10 = Mathf.Lerp(0.5, 1, var_78_9)
					local var_78_11 = arg_75_1.var_.highlightMatValue10017
					local var_78_12 = var_78_11.color

					var_78_12.r = var_78_10
					var_78_12.g = var_78_10
					var_78_12.b = var_78_10
					var_78_11.color = var_78_12
				end
			end

			if arg_75_1.time_ >= var_78_6 + var_78_8 and arg_75_1.time_ < var_78_6 + var_78_8 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.highlightMatValue10017 then
				local var_78_13 = 1

				var_78_5.transform:SetSiblingIndex(1)

				local var_78_14 = arg_75_1.var_.highlightMatValue10017
				local var_78_15 = var_78_14.color

				var_78_15.r = var_78_13
				var_78_15.g = var_78_13
				var_78_15.b = var_78_13
				var_78_14.color = var_78_15
			end

			local var_78_16 = arg_75_1.actors_["10017"]
			local var_78_17 = 0

			if var_78_17 < arg_75_1.time_ and arg_75_1.time_ <= var_78_17 + arg_78_0 then
				local var_78_18 = var_78_16:GetComponent("Image")

				if var_78_18 then
					arg_75_1.var_.alphaMatValue10017 = var_78_18
					arg_75_1.var_.alphaOldValue10017 = var_78_18.color.a
				end

				arg_75_1.var_.alphaOldValue10017 = 0
			end

			local var_78_19 = 0.5

			if var_78_17 <= arg_75_1.time_ and arg_75_1.time_ < var_78_17 + var_78_19 then
				local var_78_20 = (arg_75_1.time_ - var_78_17) / var_78_19
				local var_78_21 = Mathf.Lerp(arg_75_1.var_.alphaOldValue10017, 1, var_78_20)

				if arg_75_1.var_.alphaMatValue10017 then
					local var_78_22 = arg_75_1.var_.alphaMatValue10017.color

					var_78_22.a = var_78_21
					arg_75_1.var_.alphaMatValue10017.color = var_78_22
				end
			end

			if arg_75_1.time_ >= var_78_17 + var_78_19 and arg_75_1.time_ < var_78_17 + var_78_19 + arg_78_0 and arg_75_1.var_.alphaMatValue10017 then
				local var_78_23 = arg_75_1.var_.alphaMatValue10017
				local var_78_24 = var_78_23.color

				var_78_24.a = 1
				var_78_23.color = var_78_24
			end

			local var_78_25 = 0
			local var_78_26 = 0.4

			if var_78_25 < arg_75_1.time_ and arg_75_1.time_ <= var_78_25 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_27 = arg_75_1:FormatText(StoryNameCfg[255].name)

				arg_75_1.leftNameTxt_.text = var_78_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_28 = arg_75_1:GetWordFromCfg(114202018)
				local var_78_29 = arg_75_1:FormatText(var_78_28.content)

				arg_75_1.text_.text = var_78_29

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_30 = 16
				local var_78_31 = utf8.len(var_78_29)
				local var_78_32 = var_78_30 <= 0 and var_78_26 or var_78_26 * (var_78_31 / var_78_30)

				if var_78_32 > 0 and var_78_26 < var_78_32 then
					arg_75_1.talkMaxDuration = var_78_32

					if var_78_32 + var_78_25 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_32 + var_78_25
					end
				end

				arg_75_1.text_.text = var_78_29
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202018", "story_v_out_114202.awb") ~= 0 then
					local var_78_33 = manager.audio:GetVoiceLength("story_v_out_114202", "114202018", "story_v_out_114202.awb") / 1000

					if var_78_33 + var_78_25 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_33 + var_78_25
					end

					if var_78_28.prefab_name ~= "" and arg_75_1.actors_[var_78_28.prefab_name] ~= nil then
						local var_78_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_28.prefab_name].transform, "story_v_out_114202", "114202018", "story_v_out_114202.awb")

						arg_75_1:RecordAudio("114202018", var_78_34)
						arg_75_1:RecordAudio("114202018", var_78_34)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_114202", "114202018", "story_v_out_114202.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_114202", "114202018", "story_v_out_114202.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_35 = math.max(var_78_26, arg_75_1.talkMaxDuration)

			if var_78_25 <= arg_75_1.time_ and arg_75_1.time_ < var_78_25 + var_78_35 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_25) / var_78_35

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_25 + var_78_35 and arg_75_1.time_ < var_78_25 + var_78_35 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play114202019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 114202019
		arg_79_1.duration_ = 7.43

		local var_79_0 = {
			ja = 6.833,
			ko = 7.433,
			zh = 5.033,
			en = 5.266
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
				arg_79_0:Play114202020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10015"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos10015 = var_82_0.localPosition
				var_82_0.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10015", 4)

				local var_82_2 = var_82_0.childCount

				for iter_82_0 = 0, var_82_2 - 1 do
					local var_82_3 = var_82_0:GetChild(iter_82_0)

					if var_82_3.name == "split_1" or not string.find(var_82_3.name, "split") then
						var_82_3.gameObject:SetActive(true)
					else
						var_82_3.gameObject:SetActive(false)
					end
				end
			end

			local var_82_4 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_4 then
				local var_82_5 = (arg_79_1.time_ - var_82_1) / var_82_4
				local var_82_6 = Vector3.New(390, -350, -180)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10015, var_82_6, var_82_5)
			end

			if arg_79_1.time_ >= var_82_1 + var_82_4 and arg_79_1.time_ < var_82_1 + var_82_4 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_82_7 = arg_79_1.actors_["10017"]
			local var_82_8 = 0

			if var_82_8 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 and not isNil(var_82_7) then
				local var_82_9 = var_82_7:GetComponent("Image")

				if var_82_9 then
					arg_79_1.var_.highlightMatValue10017 = var_82_9
				end
			end

			local var_82_10 = 0.034

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_10 and not isNil(var_82_7) then
				local var_82_11 = (arg_79_1.time_ - var_82_8) / var_82_10

				if arg_79_1.var_.highlightMatValue10017 then
					local var_82_12 = Mathf.Lerp(1, 0.5, var_82_11)
					local var_82_13 = arg_79_1.var_.highlightMatValue10017
					local var_82_14 = var_82_13.color

					var_82_14.r = var_82_12
					var_82_14.g = var_82_12
					var_82_14.b = var_82_12
					var_82_13.color = var_82_14
				end
			end

			if arg_79_1.time_ >= var_82_8 + var_82_10 and arg_79_1.time_ < var_82_8 + var_82_10 + arg_82_0 and not isNil(var_82_7) and arg_79_1.var_.highlightMatValue10017 then
				local var_82_15 = 0.5
				local var_82_16 = arg_79_1.var_.highlightMatValue10017
				local var_82_17 = var_82_16.color

				var_82_17.r = var_82_15
				var_82_17.g = var_82_15
				var_82_17.b = var_82_15
				var_82_16.color = var_82_17
			end

			local var_82_18 = arg_79_1.actors_["10015"]
			local var_82_19 = 0

			if var_82_19 < arg_79_1.time_ and arg_79_1.time_ <= var_82_19 + arg_82_0 and not isNil(var_82_18) and arg_79_1.var_.actorSpriteComps10015 == nil then
				arg_79_1.var_.actorSpriteComps10015 = var_82_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_20 = 0.034

			if var_82_19 <= arg_79_1.time_ and arg_79_1.time_ < var_82_19 + var_82_20 and not isNil(var_82_18) then
				local var_82_21 = (arg_79_1.time_ - var_82_19) / var_82_20

				if arg_79_1.var_.actorSpriteComps10015 then
					for iter_82_1, iter_82_2 in pairs(arg_79_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_82_2 then
							if arg_79_1.isInRecall_ then
								local var_82_22 = Mathf.Lerp(iter_82_2.color.r, arg_79_1.hightColor1.r, var_82_21)
								local var_82_23 = Mathf.Lerp(iter_82_2.color.g, arg_79_1.hightColor1.g, var_82_21)
								local var_82_24 = Mathf.Lerp(iter_82_2.color.b, arg_79_1.hightColor1.b, var_82_21)

								iter_82_2.color = Color.New(var_82_22, var_82_23, var_82_24)
							else
								local var_82_25 = Mathf.Lerp(iter_82_2.color.r, 1, var_82_21)

								iter_82_2.color = Color.New(var_82_25, var_82_25, var_82_25)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_19 + var_82_20 and arg_79_1.time_ < var_82_19 + var_82_20 + arg_82_0 and not isNil(var_82_18) and arg_79_1.var_.actorSpriteComps10015 then
				for iter_82_3, iter_82_4 in pairs(arg_79_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_82_4 then
						if arg_79_1.isInRecall_ then
							iter_82_4.color = arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_82_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps10015 = nil
			end

			local var_82_26 = arg_79_1.actors_["10015"]
			local var_82_27 = 0

			if var_82_27 < arg_79_1.time_ and arg_79_1.time_ <= var_82_27 + arg_82_0 then
				local var_82_28 = var_82_26:GetComponentInChildren(typeof(CanvasGroup))

				if var_82_28 then
					arg_79_1.var_.alphaOldValue10015 = var_82_28.alpha
					arg_79_1.var_.characterEffect10015 = var_82_28
				end

				arg_79_1.var_.alphaOldValue10015 = 0
			end

			local var_82_29 = 0.5

			if var_82_27 <= arg_79_1.time_ and arg_79_1.time_ < var_82_27 + var_82_29 then
				local var_82_30 = (arg_79_1.time_ - var_82_27) / var_82_29
				local var_82_31 = Mathf.Lerp(arg_79_1.var_.alphaOldValue10015, 1, var_82_30)

				if arg_79_1.var_.characterEffect10015 then
					arg_79_1.var_.characterEffect10015.alpha = var_82_31
				end
			end

			if arg_79_1.time_ >= var_82_27 + var_82_29 and arg_79_1.time_ < var_82_27 + var_82_29 + arg_82_0 and arg_79_1.var_.characterEffect10015 then
				arg_79_1.var_.characterEffect10015.alpha = 1
			end

			local var_82_32 = 0
			local var_82_33 = 0.6

			if var_82_32 < arg_79_1.time_ and arg_79_1.time_ <= var_82_32 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_34 = arg_79_1:FormatText(StoryNameCfg[208].name)

				arg_79_1.leftNameTxt_.text = var_82_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_35 = arg_79_1:GetWordFromCfg(114202019)
				local var_82_36 = arg_79_1:FormatText(var_82_35.content)

				arg_79_1.text_.text = var_82_36

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_37 = 24
				local var_82_38 = utf8.len(var_82_36)
				local var_82_39 = var_82_37 <= 0 and var_82_33 or var_82_33 * (var_82_38 / var_82_37)

				if var_82_39 > 0 and var_82_33 < var_82_39 then
					arg_79_1.talkMaxDuration = var_82_39

					if var_82_39 + var_82_32 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_39 + var_82_32
					end
				end

				arg_79_1.text_.text = var_82_36
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202019", "story_v_out_114202.awb") ~= 0 then
					local var_82_40 = manager.audio:GetVoiceLength("story_v_out_114202", "114202019", "story_v_out_114202.awb") / 1000

					if var_82_40 + var_82_32 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_40 + var_82_32
					end

					if var_82_35.prefab_name ~= "" and arg_79_1.actors_[var_82_35.prefab_name] ~= nil then
						local var_82_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_35.prefab_name].transform, "story_v_out_114202", "114202019", "story_v_out_114202.awb")

						arg_79_1:RecordAudio("114202019", var_82_41)
						arg_79_1:RecordAudio("114202019", var_82_41)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_114202", "114202019", "story_v_out_114202.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_114202", "114202019", "story_v_out_114202.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_42 = math.max(var_82_33, arg_79_1.talkMaxDuration)

			if var_82_32 <= arg_79_1.time_ and arg_79_1.time_ < var_82_32 + var_82_42 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_32) / var_82_42

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_32 + var_82_42 and arg_79_1.time_ < var_82_32 + var_82_42 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play114202020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 114202020
		arg_83_1.duration_ = 7.63

		local var_83_0 = {
			ja = 7.633,
			ko = 3.833,
			zh = 2.933,
			en = 4.3
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
				arg_83_0:Play114202021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10017"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) then
				local var_86_2 = var_86_0:GetComponent("Image")

				if var_86_2 then
					arg_83_1.var_.highlightMatValue10017 = var_86_2
				end
			end

			local var_86_3 = 0.034

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_3 and not isNil(var_86_0) then
				local var_86_4 = (arg_83_1.time_ - var_86_1) / var_86_3

				if arg_83_1.var_.highlightMatValue10017 then
					local var_86_5 = Mathf.Lerp(0.5, 1, var_86_4)
					local var_86_6 = arg_83_1.var_.highlightMatValue10017
					local var_86_7 = var_86_6.color

					var_86_7.r = var_86_5
					var_86_7.g = var_86_5
					var_86_7.b = var_86_5
					var_86_6.color = var_86_7
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_3 and arg_83_1.time_ < var_86_1 + var_86_3 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.highlightMatValue10017 then
				local var_86_8 = 1

				var_86_0.transform:SetSiblingIndex(1)

				local var_86_9 = arg_83_1.var_.highlightMatValue10017
				local var_86_10 = var_86_9.color

				var_86_10.r = var_86_8
				var_86_10.g = var_86_8
				var_86_10.b = var_86_8
				var_86_9.color = var_86_10
			end

			local var_86_11 = arg_83_1.actors_["10015"]
			local var_86_12 = 0

			if var_86_12 < arg_83_1.time_ and arg_83_1.time_ <= var_86_12 + arg_86_0 and not isNil(var_86_11) and arg_83_1.var_.actorSpriteComps10015 == nil then
				arg_83_1.var_.actorSpriteComps10015 = var_86_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_13 = 0.034

			if var_86_12 <= arg_83_1.time_ and arg_83_1.time_ < var_86_12 + var_86_13 and not isNil(var_86_11) then
				local var_86_14 = (arg_83_1.time_ - var_86_12) / var_86_13

				if arg_83_1.var_.actorSpriteComps10015 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_86_1 then
							if arg_83_1.isInRecall_ then
								local var_86_15 = Mathf.Lerp(iter_86_1.color.r, arg_83_1.hightColor2.r, var_86_14)
								local var_86_16 = Mathf.Lerp(iter_86_1.color.g, arg_83_1.hightColor2.g, var_86_14)
								local var_86_17 = Mathf.Lerp(iter_86_1.color.b, arg_83_1.hightColor2.b, var_86_14)

								iter_86_1.color = Color.New(var_86_15, var_86_16, var_86_17)
							else
								local var_86_18 = Mathf.Lerp(iter_86_1.color.r, 0.5, var_86_14)

								iter_86_1.color = Color.New(var_86_18, var_86_18, var_86_18)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= var_86_12 + var_86_13 and arg_83_1.time_ < var_86_12 + var_86_13 + arg_86_0 and not isNil(var_86_11) and arg_83_1.var_.actorSpriteComps10015 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_86_3 then
						if arg_83_1.isInRecall_ then
							iter_86_3.color = arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_86_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps10015 = nil
			end

			local var_86_19 = 0
			local var_86_20 = 0.35

			if var_86_19 < arg_83_1.time_ and arg_83_1.time_ <= var_86_19 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_21 = arg_83_1:FormatText(StoryNameCfg[255].name)

				arg_83_1.leftNameTxt_.text = var_86_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_22 = arg_83_1:GetWordFromCfg(114202020)
				local var_86_23 = arg_83_1:FormatText(var_86_22.content)

				arg_83_1.text_.text = var_86_23

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_24 = 14
				local var_86_25 = utf8.len(var_86_23)
				local var_86_26 = var_86_24 <= 0 and var_86_20 or var_86_20 * (var_86_25 / var_86_24)

				if var_86_26 > 0 and var_86_20 < var_86_26 then
					arg_83_1.talkMaxDuration = var_86_26

					if var_86_26 + var_86_19 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_26 + var_86_19
					end
				end

				arg_83_1.text_.text = var_86_23
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202020", "story_v_out_114202.awb") ~= 0 then
					local var_86_27 = manager.audio:GetVoiceLength("story_v_out_114202", "114202020", "story_v_out_114202.awb") / 1000

					if var_86_27 + var_86_19 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_27 + var_86_19
					end

					if var_86_22.prefab_name ~= "" and arg_83_1.actors_[var_86_22.prefab_name] ~= nil then
						local var_86_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_22.prefab_name].transform, "story_v_out_114202", "114202020", "story_v_out_114202.awb")

						arg_83_1:RecordAudio("114202020", var_86_28)
						arg_83_1:RecordAudio("114202020", var_86_28)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_114202", "114202020", "story_v_out_114202.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_114202", "114202020", "story_v_out_114202.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_29 = math.max(var_86_20, arg_83_1.talkMaxDuration)

			if var_86_19 <= arg_83_1.time_ and arg_83_1.time_ < var_86_19 + var_86_29 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_19) / var_86_29

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_19 + var_86_29 and arg_83_1.time_ < var_86_19 + var_86_29 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play114202021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 114202021
		arg_87_1.duration_ = 7.37

		local var_87_0 = {
			ja = 7.366,
			ko = 6.733,
			zh = 5.566,
			en = 5.9
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
				arg_87_0:Play114202022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["10017"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) then
				local var_90_2 = var_90_0:GetComponent("Image")

				if var_90_2 then
					arg_87_1.var_.highlightMatValue10017 = var_90_2
				end
			end

			local var_90_3 = 0.034

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_3 and not isNil(var_90_0) then
				local var_90_4 = (arg_87_1.time_ - var_90_1) / var_90_3

				if arg_87_1.var_.highlightMatValue10017 then
					local var_90_5 = Mathf.Lerp(1, 0.5, var_90_4)
					local var_90_6 = arg_87_1.var_.highlightMatValue10017
					local var_90_7 = var_90_6.color

					var_90_7.r = var_90_5
					var_90_7.g = var_90_5
					var_90_7.b = var_90_5
					var_90_6.color = var_90_7
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_3 and arg_87_1.time_ < var_90_1 + var_90_3 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.highlightMatValue10017 then
				local var_90_8 = 0.5
				local var_90_9 = arg_87_1.var_.highlightMatValue10017
				local var_90_10 = var_90_9.color

				var_90_10.r = var_90_8
				var_90_10.g = var_90_8
				var_90_10.b = var_90_8
				var_90_9.color = var_90_10
			end

			local var_90_11 = arg_87_1.actors_["10015"]
			local var_90_12 = 0

			if var_90_12 < arg_87_1.time_ and arg_87_1.time_ <= var_90_12 + arg_90_0 and not isNil(var_90_11) and arg_87_1.var_.actorSpriteComps10015 == nil then
				arg_87_1.var_.actorSpriteComps10015 = var_90_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_13 = 0.034

			if var_90_12 <= arg_87_1.time_ and arg_87_1.time_ < var_90_12 + var_90_13 and not isNil(var_90_11) then
				local var_90_14 = (arg_87_1.time_ - var_90_12) / var_90_13

				if arg_87_1.var_.actorSpriteComps10015 then
					for iter_90_0, iter_90_1 in pairs(arg_87_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_90_1 then
							if arg_87_1.isInRecall_ then
								local var_90_15 = Mathf.Lerp(iter_90_1.color.r, arg_87_1.hightColor1.r, var_90_14)
								local var_90_16 = Mathf.Lerp(iter_90_1.color.g, arg_87_1.hightColor1.g, var_90_14)
								local var_90_17 = Mathf.Lerp(iter_90_1.color.b, arg_87_1.hightColor1.b, var_90_14)

								iter_90_1.color = Color.New(var_90_15, var_90_16, var_90_17)
							else
								local var_90_18 = Mathf.Lerp(iter_90_1.color.r, 1, var_90_14)

								iter_90_1.color = Color.New(var_90_18, var_90_18, var_90_18)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_12 + var_90_13 and arg_87_1.time_ < var_90_12 + var_90_13 + arg_90_0 and not isNil(var_90_11) and arg_87_1.var_.actorSpriteComps10015 then
				for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_90_3 then
						if arg_87_1.isInRecall_ then
							iter_90_3.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_90_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps10015 = nil
			end

			local var_90_19 = 0
			local var_90_20 = 0.625

			if var_90_19 < arg_87_1.time_ and arg_87_1.time_ <= var_90_19 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_21 = arg_87_1:FormatText(StoryNameCfg[208].name)

				arg_87_1.leftNameTxt_.text = var_90_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_22 = arg_87_1:GetWordFromCfg(114202021)
				local var_90_23 = arg_87_1:FormatText(var_90_22.content)

				arg_87_1.text_.text = var_90_23

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_24 = 25
				local var_90_25 = utf8.len(var_90_23)
				local var_90_26 = var_90_24 <= 0 and var_90_20 or var_90_20 * (var_90_25 / var_90_24)

				if var_90_26 > 0 and var_90_20 < var_90_26 then
					arg_87_1.talkMaxDuration = var_90_26

					if var_90_26 + var_90_19 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_26 + var_90_19
					end
				end

				arg_87_1.text_.text = var_90_23
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202021", "story_v_out_114202.awb") ~= 0 then
					local var_90_27 = manager.audio:GetVoiceLength("story_v_out_114202", "114202021", "story_v_out_114202.awb") / 1000

					if var_90_27 + var_90_19 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_27 + var_90_19
					end

					if var_90_22.prefab_name ~= "" and arg_87_1.actors_[var_90_22.prefab_name] ~= nil then
						local var_90_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_22.prefab_name].transform, "story_v_out_114202", "114202021", "story_v_out_114202.awb")

						arg_87_1:RecordAudio("114202021", var_90_28)
						arg_87_1:RecordAudio("114202021", var_90_28)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_114202", "114202021", "story_v_out_114202.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_114202", "114202021", "story_v_out_114202.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_29 = math.max(var_90_20, arg_87_1.talkMaxDuration)

			if var_90_19 <= arg_87_1.time_ and arg_87_1.time_ < var_90_19 + var_90_29 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_19) / var_90_29

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_19 + var_90_29 and arg_87_1.time_ < var_90_19 + var_90_29 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play114202022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 114202022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play114202023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10015"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.actorSpriteComps10015 == nil then
				arg_91_1.var_.actorSpriteComps10015 = var_94_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_2 = 0.034

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.actorSpriteComps10015 then
					for iter_94_0, iter_94_1 in pairs(arg_91_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_94_1 then
							if arg_91_1.isInRecall_ then
								local var_94_4 = Mathf.Lerp(iter_94_1.color.r, arg_91_1.hightColor2.r, var_94_3)
								local var_94_5 = Mathf.Lerp(iter_94_1.color.g, arg_91_1.hightColor2.g, var_94_3)
								local var_94_6 = Mathf.Lerp(iter_94_1.color.b, arg_91_1.hightColor2.b, var_94_3)

								iter_94_1.color = Color.New(var_94_4, var_94_5, var_94_6)
							else
								local var_94_7 = Mathf.Lerp(iter_94_1.color.r, 0.5, var_94_3)

								iter_94_1.color = Color.New(var_94_7, var_94_7, var_94_7)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.actorSpriteComps10015 then
				for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_94_3 then
						if arg_91_1.isInRecall_ then
							iter_94_3.color = arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_94_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps10015 = nil
			end

			local var_94_8 = 0
			local var_94_9 = 1.35

			if var_94_8 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_10 = arg_91_1:GetWordFromCfg(114202022)
				local var_94_11 = arg_91_1:FormatText(var_94_10.content)

				arg_91_1.text_.text = var_94_11

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_12 = 54
				local var_94_13 = utf8.len(var_94_11)
				local var_94_14 = var_94_12 <= 0 and var_94_9 or var_94_9 * (var_94_13 / var_94_12)

				if var_94_14 > 0 and var_94_9 < var_94_14 then
					arg_91_1.talkMaxDuration = var_94_14

					if var_94_14 + var_94_8 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_14 + var_94_8
					end
				end

				arg_91_1.text_.text = var_94_11
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_15 = math.max(var_94_9, arg_91_1.talkMaxDuration)

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_15 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_8) / var_94_15

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_8 + var_94_15 and arg_91_1.time_ < var_94_8 + var_94_15 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play114202023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 114202023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play114202024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.875

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_2 = arg_95_1:GetWordFromCfg(114202023)
				local var_98_3 = arg_95_1:FormatText(var_98_2.content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 35
				local var_98_5 = utf8.len(var_98_3)
				local var_98_6 = var_98_4 <= 0 and var_98_1 or var_98_1 * (var_98_5 / var_98_4)

				if var_98_6 > 0 and var_98_1 < var_98_6 then
					arg_95_1.talkMaxDuration = var_98_6

					if var_98_6 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_7 and arg_95_1.time_ < var_98_0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play114202024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 114202024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play114202025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.7

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_2 = arg_99_1:GetWordFromCfg(114202024)
				local var_102_3 = arg_99_1:FormatText(var_102_2.content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 28
				local var_102_5 = utf8.len(var_102_3)
				local var_102_6 = var_102_4 <= 0 and var_102_1 or var_102_1 * (var_102_5 / var_102_4)

				if var_102_6 > 0 and var_102_1 < var_102_6 then
					arg_99_1.talkMaxDuration = var_102_6

					if var_102_6 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_7 and arg_99_1.time_ < var_102_0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play114202025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 114202025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play114202026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.225

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_2 = arg_103_1:GetWordFromCfg(114202025)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 9
				local var_106_5 = utf8.len(var_106_3)
				local var_106_6 = var_106_4 <= 0 and var_106_1 or var_106_1 * (var_106_5 / var_106_4)

				if var_106_6 > 0 and var_106_1 < var_106_6 then
					arg_103_1.talkMaxDuration = var_106_6

					if var_106_6 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_7 and arg_103_1.time_ < var_106_0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play114202026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 114202026
		arg_107_1.duration_ = 7.73

		local var_107_0 = {
			ja = 4.2,
			ko = 5.666,
			zh = 7.733,
			en = 5.333
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
				arg_107_0:Play114202027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10017"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) then
				local var_110_2 = var_110_0:GetComponent("Image")

				if var_110_2 then
					arg_107_1.var_.highlightMatValue10017 = var_110_2
				end
			end

			local var_110_3 = 0.034

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_3 and not isNil(var_110_0) then
				local var_110_4 = (arg_107_1.time_ - var_110_1) / var_110_3

				if arg_107_1.var_.highlightMatValue10017 then
					local var_110_5 = Mathf.Lerp(0.5, 1, var_110_4)
					local var_110_6 = arg_107_1.var_.highlightMatValue10017
					local var_110_7 = var_110_6.color

					var_110_7.r = var_110_5
					var_110_7.g = var_110_5
					var_110_7.b = var_110_5
					var_110_6.color = var_110_7
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_3 and arg_107_1.time_ < var_110_1 + var_110_3 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.highlightMatValue10017 then
				local var_110_8 = 1

				var_110_0.transform:SetSiblingIndex(1)

				local var_110_9 = arg_107_1.var_.highlightMatValue10017
				local var_110_10 = var_110_9.color

				var_110_10.r = var_110_8
				var_110_10.g = var_110_8
				var_110_10.b = var_110_8
				var_110_9.color = var_110_10
			end

			local var_110_11 = 0
			local var_110_12 = 0.7

			if var_110_11 < arg_107_1.time_ and arg_107_1.time_ <= var_110_11 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_13 = arg_107_1:FormatText(StoryNameCfg[255].name)

				arg_107_1.leftNameTxt_.text = var_110_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_14 = arg_107_1:GetWordFromCfg(114202026)
				local var_110_15 = arg_107_1:FormatText(var_110_14.content)

				arg_107_1.text_.text = var_110_15

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_16 = 28
				local var_110_17 = utf8.len(var_110_15)
				local var_110_18 = var_110_16 <= 0 and var_110_12 or var_110_12 * (var_110_17 / var_110_16)

				if var_110_18 > 0 and var_110_12 < var_110_18 then
					arg_107_1.talkMaxDuration = var_110_18

					if var_110_18 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_18 + var_110_11
					end
				end

				arg_107_1.text_.text = var_110_15
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202026", "story_v_out_114202.awb") ~= 0 then
					local var_110_19 = manager.audio:GetVoiceLength("story_v_out_114202", "114202026", "story_v_out_114202.awb") / 1000

					if var_110_19 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_19 + var_110_11
					end

					if var_110_14.prefab_name ~= "" and arg_107_1.actors_[var_110_14.prefab_name] ~= nil then
						local var_110_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_14.prefab_name].transform, "story_v_out_114202", "114202026", "story_v_out_114202.awb")

						arg_107_1:RecordAudio("114202026", var_110_20)
						arg_107_1:RecordAudio("114202026", var_110_20)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_114202", "114202026", "story_v_out_114202.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_114202", "114202026", "story_v_out_114202.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_21 = math.max(var_110_12, arg_107_1.talkMaxDuration)

			if var_110_11 <= arg_107_1.time_ and arg_107_1.time_ < var_110_11 + var_110_21 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_11) / var_110_21

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_11 + var_110_21 and arg_107_1.time_ < var_110_11 + var_110_21 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play114202027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 114202027
		arg_111_1.duration_ = 5.93

		local var_111_0 = {
			ja = 5.933,
			ko = 3.633,
			zh = 3.366,
			en = 3.8
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
				arg_111_0:Play114202028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.45

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[255].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:GetWordFromCfg(114202027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202027", "story_v_out_114202.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_114202", "114202027", "story_v_out_114202.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_114202", "114202027", "story_v_out_114202.awb")

						arg_111_1:RecordAudio("114202027", var_114_9)
						arg_111_1:RecordAudio("114202027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_114202", "114202027", "story_v_out_114202.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_114202", "114202027", "story_v_out_114202.awb")
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
	Play114202028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 114202028
		arg_115_1.duration_ = 11.17

		local var_115_0 = {
			ja = 9.5,
			ko = 8.666,
			zh = 7.3,
			en = 11.166
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
				arg_115_0:Play114202029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.85

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[255].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:GetWordFromCfg(114202028)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202028", "story_v_out_114202.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_114202", "114202028", "story_v_out_114202.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_114202", "114202028", "story_v_out_114202.awb")

						arg_115_1:RecordAudio("114202028", var_118_9)
						arg_115_1:RecordAudio("114202028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_114202", "114202028", "story_v_out_114202.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_114202", "114202028", "story_v_out_114202.awb")
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
	Play114202029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 114202029
		arg_119_1.duration_ = 10.6

		local var_119_0 = {
			ja = 8.666,
			ko = 8.9,
			zh = 9.166,
			en = 10.6
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
				arg_119_0:Play114202030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10017"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) then
				local var_122_2 = var_122_0:GetComponent("Image")

				if var_122_2 then
					arg_119_1.var_.highlightMatValue10017 = var_122_2
				end
			end

			local var_122_3 = 0.034

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_3 and not isNil(var_122_0) then
				local var_122_4 = (arg_119_1.time_ - var_122_1) / var_122_3

				if arg_119_1.var_.highlightMatValue10017 then
					local var_122_5 = Mathf.Lerp(1, 0.5, var_122_4)
					local var_122_6 = arg_119_1.var_.highlightMatValue10017
					local var_122_7 = var_122_6.color

					var_122_7.r = var_122_5
					var_122_7.g = var_122_5
					var_122_7.b = var_122_5
					var_122_6.color = var_122_7
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_3 and arg_119_1.time_ < var_122_1 + var_122_3 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.highlightMatValue10017 then
				local var_122_8 = 0.5
				local var_122_9 = arg_119_1.var_.highlightMatValue10017
				local var_122_10 = var_122_9.color

				var_122_10.r = var_122_8
				var_122_10.g = var_122_8
				var_122_10.b = var_122_8
				var_122_9.color = var_122_10
			end

			local var_122_11 = arg_119_1.actors_["10015"]
			local var_122_12 = 0

			if var_122_12 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 and not isNil(var_122_11) and arg_119_1.var_.actorSpriteComps10015 == nil then
				arg_119_1.var_.actorSpriteComps10015 = var_122_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_13 = 0.034

			if var_122_12 <= arg_119_1.time_ and arg_119_1.time_ < var_122_12 + var_122_13 and not isNil(var_122_11) then
				local var_122_14 = (arg_119_1.time_ - var_122_12) / var_122_13

				if arg_119_1.var_.actorSpriteComps10015 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								local var_122_15 = Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor1.r, var_122_14)
								local var_122_16 = Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor1.g, var_122_14)
								local var_122_17 = Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor1.b, var_122_14)

								iter_122_1.color = Color.New(var_122_15, var_122_16, var_122_17)
							else
								local var_122_18 = Mathf.Lerp(iter_122_1.color.r, 1, var_122_14)

								iter_122_1.color = Color.New(var_122_18, var_122_18, var_122_18)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_12 + var_122_13 and arg_119_1.time_ < var_122_12 + var_122_13 + arg_122_0 and not isNil(var_122_11) and arg_119_1.var_.actorSpriteComps10015 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_122_3 then
						if arg_119_1.isInRecall_ then
							iter_122_3.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10015 = nil
			end

			local var_122_19 = 0
			local var_122_20 = 1.025

			if var_122_19 < arg_119_1.time_ and arg_119_1.time_ <= var_122_19 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_21 = arg_119_1:FormatText(StoryNameCfg[208].name)

				arg_119_1.leftNameTxt_.text = var_122_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_22 = arg_119_1:GetWordFromCfg(114202029)
				local var_122_23 = arg_119_1:FormatText(var_122_22.content)

				arg_119_1.text_.text = var_122_23

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_24 = 41
				local var_122_25 = utf8.len(var_122_23)
				local var_122_26 = var_122_24 <= 0 and var_122_20 or var_122_20 * (var_122_25 / var_122_24)

				if var_122_26 > 0 and var_122_20 < var_122_26 then
					arg_119_1.talkMaxDuration = var_122_26

					if var_122_26 + var_122_19 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_26 + var_122_19
					end
				end

				arg_119_1.text_.text = var_122_23
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202029", "story_v_out_114202.awb") ~= 0 then
					local var_122_27 = manager.audio:GetVoiceLength("story_v_out_114202", "114202029", "story_v_out_114202.awb") / 1000

					if var_122_27 + var_122_19 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_27 + var_122_19
					end

					if var_122_22.prefab_name ~= "" and arg_119_1.actors_[var_122_22.prefab_name] ~= nil then
						local var_122_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_22.prefab_name].transform, "story_v_out_114202", "114202029", "story_v_out_114202.awb")

						arg_119_1:RecordAudio("114202029", var_122_28)
						arg_119_1:RecordAudio("114202029", var_122_28)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_114202", "114202029", "story_v_out_114202.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_114202", "114202029", "story_v_out_114202.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_29 = math.max(var_122_20, arg_119_1.talkMaxDuration)

			if var_122_19 <= arg_119_1.time_ and arg_119_1.time_ < var_122_19 + var_122_29 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_19) / var_122_29

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_19 + var_122_29 and arg_119_1.time_ < var_122_19 + var_122_29 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play114202030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 114202030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play114202031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10015"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				local var_126_2 = var_126_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_126_2 then
					arg_123_1.var_.alphaOldValue10015 = var_126_2.alpha
					arg_123_1.var_.characterEffect10015 = var_126_2
				end

				arg_123_1.var_.alphaOldValue10015 = 1
			end

			local var_126_3 = 0.5

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_3 then
				local var_126_4 = (arg_123_1.time_ - var_126_1) / var_126_3
				local var_126_5 = Mathf.Lerp(arg_123_1.var_.alphaOldValue10015, 0, var_126_4)

				if arg_123_1.var_.characterEffect10015 then
					arg_123_1.var_.characterEffect10015.alpha = var_126_5
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_3 and arg_123_1.time_ < var_126_1 + var_126_3 + arg_126_0 and arg_123_1.var_.characterEffect10015 then
				arg_123_1.var_.characterEffect10015.alpha = 0
			end

			local var_126_6 = arg_123_1.actors_["10017"]
			local var_126_7 = 0

			if var_126_7 < arg_123_1.time_ and arg_123_1.time_ <= var_126_7 + arg_126_0 then
				local var_126_8 = var_126_6:GetComponent("Image")

				if var_126_8 then
					arg_123_1.var_.alphaMatValue10017 = var_126_8
					arg_123_1.var_.alphaOldValue10017 = var_126_8.color.a
				end

				arg_123_1.var_.alphaOldValue10017 = 1
			end

			local var_126_9 = 0.5

			if var_126_7 <= arg_123_1.time_ and arg_123_1.time_ < var_126_7 + var_126_9 then
				local var_126_10 = (arg_123_1.time_ - var_126_7) / var_126_9
				local var_126_11 = Mathf.Lerp(arg_123_1.var_.alphaOldValue10017, 0, var_126_10)

				if arg_123_1.var_.alphaMatValue10017 then
					local var_126_12 = arg_123_1.var_.alphaMatValue10017.color

					var_126_12.a = var_126_11
					arg_123_1.var_.alphaMatValue10017.color = var_126_12
				end
			end

			if arg_123_1.time_ >= var_126_7 + var_126_9 and arg_123_1.time_ < var_126_7 + var_126_9 + arg_126_0 and arg_123_1.var_.alphaMatValue10017 then
				local var_126_13 = arg_123_1.var_.alphaMatValue10017
				local var_126_14 = var_126_13.color

				var_126_14.a = 0
				var_126_13.color = var_126_14
			end

			local var_126_15 = 0
			local var_126_16 = 0.9

			if var_126_15 < arg_123_1.time_ and arg_123_1.time_ <= var_126_15 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_17 = arg_123_1:GetWordFromCfg(114202030)
				local var_126_18 = arg_123_1:FormatText(var_126_17.content)

				arg_123_1.text_.text = var_126_18

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_19 = 36
				local var_126_20 = utf8.len(var_126_18)
				local var_126_21 = var_126_19 <= 0 and var_126_16 or var_126_16 * (var_126_20 / var_126_19)

				if var_126_21 > 0 and var_126_16 < var_126_21 then
					arg_123_1.talkMaxDuration = var_126_21

					if var_126_21 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_21 + var_126_15
					end
				end

				arg_123_1.text_.text = var_126_18
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_22 = math.max(var_126_16, arg_123_1.talkMaxDuration)

			if var_126_15 <= arg_123_1.time_ and arg_123_1.time_ < var_126_15 + var_126_22 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_15) / var_126_22

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_15 + var_126_22 and arg_123_1.time_ < var_126_15 + var_126_22 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play114202031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 114202031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play114202032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.7

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_2 = arg_127_1:GetWordFromCfg(114202031)
				local var_130_3 = arg_127_1:FormatText(var_130_2.content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 28
				local var_130_5 = utf8.len(var_130_3)
				local var_130_6 = var_130_4 <= 0 and var_130_1 or var_130_1 * (var_130_5 / var_130_4)

				if var_130_6 > 0 and var_130_1 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_7 and arg_127_1.time_ < var_130_0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play114202032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 114202032
		arg_131_1.duration_ = 13.53

		local var_131_0 = {
			ja = 4.266,
			ko = 9.6,
			zh = 10.966,
			en = 13.533
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
				arg_131_0:Play114202033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10017"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos10017 = var_134_0.localPosition
				var_134_0.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10017", 2)
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(-390, -350, -180)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10017, var_134_4, var_134_3)
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_134_5 = arg_131_1.actors_["10017"]
			local var_134_6 = 0

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 and not isNil(var_134_5) then
				local var_134_7 = var_134_5:GetComponent("Image")

				if var_134_7 then
					arg_131_1.var_.highlightMatValue10017 = var_134_7
				end
			end

			local var_134_8 = 0.034

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_8 and not isNil(var_134_5) then
				local var_134_9 = (arg_131_1.time_ - var_134_6) / var_134_8

				if arg_131_1.var_.highlightMatValue10017 then
					local var_134_10 = Mathf.Lerp(0.5, 1, var_134_9)
					local var_134_11 = arg_131_1.var_.highlightMatValue10017
					local var_134_12 = var_134_11.color

					var_134_12.r = var_134_10
					var_134_12.g = var_134_10
					var_134_12.b = var_134_10
					var_134_11.color = var_134_12
				end
			end

			if arg_131_1.time_ >= var_134_6 + var_134_8 and arg_131_1.time_ < var_134_6 + var_134_8 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.highlightMatValue10017 then
				local var_134_13 = 1

				var_134_5.transform:SetSiblingIndex(1)

				local var_134_14 = arg_131_1.var_.highlightMatValue10017
				local var_134_15 = var_134_14.color

				var_134_15.r = var_134_13
				var_134_15.g = var_134_13
				var_134_15.b = var_134_13
				var_134_14.color = var_134_15
			end

			local var_134_16 = arg_131_1.actors_["10017"]
			local var_134_17 = 0

			if var_134_17 < arg_131_1.time_ and arg_131_1.time_ <= var_134_17 + arg_134_0 and not isNil(var_134_16) then
				local var_134_18 = var_134_16:GetComponent("Image")

				if var_134_18 then
					arg_131_1.var_.highlightMatValue10017 = var_134_18
				end
			end

			local var_134_19 = 0.2

			if var_134_17 <= arg_131_1.time_ and arg_131_1.time_ < var_134_17 + var_134_19 and not isNil(var_134_16) then
				local var_134_20 = (arg_131_1.time_ - var_134_17) / var_134_19

				if arg_131_1.var_.highlightMatValue10017 then
					local var_134_21 = Mathf.Lerp(0.5, 1, var_134_20)
					local var_134_22 = arg_131_1.var_.highlightMatValue10017
					local var_134_23 = var_134_22.color

					var_134_23.r = var_134_21
					var_134_23.g = var_134_21
					var_134_23.b = var_134_21
					var_134_22.color = var_134_23
				end
			end

			if arg_131_1.time_ >= var_134_17 + var_134_19 and arg_131_1.time_ < var_134_17 + var_134_19 + arg_134_0 and not isNil(var_134_16) and arg_131_1.var_.highlightMatValue10017 then
				local var_134_24 = 1

				var_134_16.transform:SetSiblingIndex(1)

				local var_134_25 = arg_131_1.var_.highlightMatValue10017
				local var_134_26 = var_134_25.color

				var_134_26.r = var_134_24
				var_134_26.g = var_134_24
				var_134_26.b = var_134_24
				var_134_25.color = var_134_26
			end

			local var_134_27 = arg_131_1.actors_["10017"]
			local var_134_28 = 0

			if var_134_28 < arg_131_1.time_ and arg_131_1.time_ <= var_134_28 + arg_134_0 then
				local var_134_29 = var_134_27:GetComponent("Image")

				if var_134_29 then
					arg_131_1.var_.alphaMatValue10017 = var_134_29
					arg_131_1.var_.alphaOldValue10017 = var_134_29.color.a
				end

				arg_131_1.var_.alphaOldValue10017 = 0
			end

			local var_134_30 = 0.5

			if var_134_28 <= arg_131_1.time_ and arg_131_1.time_ < var_134_28 + var_134_30 then
				local var_134_31 = (arg_131_1.time_ - var_134_28) / var_134_30
				local var_134_32 = Mathf.Lerp(arg_131_1.var_.alphaOldValue10017, 1, var_134_31)

				if arg_131_1.var_.alphaMatValue10017 then
					local var_134_33 = arg_131_1.var_.alphaMatValue10017.color

					var_134_33.a = var_134_32
					arg_131_1.var_.alphaMatValue10017.color = var_134_33
				end
			end

			if arg_131_1.time_ >= var_134_28 + var_134_30 and arg_131_1.time_ < var_134_28 + var_134_30 + arg_134_0 and arg_131_1.var_.alphaMatValue10017 then
				local var_134_34 = arg_131_1.var_.alphaMatValue10017
				local var_134_35 = var_134_34.color

				var_134_35.a = 1
				var_134_34.color = var_134_35
			end

			local var_134_36 = 0
			local var_134_37 = 1

			if var_134_36 < arg_131_1.time_ and arg_131_1.time_ <= var_134_36 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_38 = arg_131_1:FormatText(StoryNameCfg[255].name)

				arg_131_1.leftNameTxt_.text = var_134_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_39 = arg_131_1:GetWordFromCfg(114202032)
				local var_134_40 = arg_131_1:FormatText(var_134_39.content)

				arg_131_1.text_.text = var_134_40

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_41 = 40
				local var_134_42 = utf8.len(var_134_40)
				local var_134_43 = var_134_41 <= 0 and var_134_37 or var_134_37 * (var_134_42 / var_134_41)

				if var_134_43 > 0 and var_134_37 < var_134_43 then
					arg_131_1.talkMaxDuration = var_134_43

					if var_134_43 + var_134_36 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_43 + var_134_36
					end
				end

				arg_131_1.text_.text = var_134_40
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202032", "story_v_out_114202.awb") ~= 0 then
					local var_134_44 = manager.audio:GetVoiceLength("story_v_out_114202", "114202032", "story_v_out_114202.awb") / 1000

					if var_134_44 + var_134_36 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_44 + var_134_36
					end

					if var_134_39.prefab_name ~= "" and arg_131_1.actors_[var_134_39.prefab_name] ~= nil then
						local var_134_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_39.prefab_name].transform, "story_v_out_114202", "114202032", "story_v_out_114202.awb")

						arg_131_1:RecordAudio("114202032", var_134_45)
						arg_131_1:RecordAudio("114202032", var_134_45)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_114202", "114202032", "story_v_out_114202.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_114202", "114202032", "story_v_out_114202.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_46 = math.max(var_134_37, arg_131_1.talkMaxDuration)

			if var_134_36 <= arg_131_1.time_ and arg_131_1.time_ < var_134_36 + var_134_46 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_36) / var_134_46

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_36 + var_134_46 and arg_131_1.time_ < var_134_36 + var_134_46 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play114202033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 114202033
		arg_135_1.duration_ = 3.6

		local var_135_0 = {
			ja = 2.2,
			ko = 2.733,
			zh = 1.7,
			en = 3.6
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
				arg_135_0:Play114202034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10015"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos10015 = var_138_0.localPosition
				var_138_0.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10015", 4)

				local var_138_2 = var_138_0.childCount

				for iter_138_0 = 0, var_138_2 - 1 do
					local var_138_3 = var_138_0:GetChild(iter_138_0)

					if var_138_3.name == "split_1" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_4 then
				local var_138_5 = (arg_135_1.time_ - var_138_1) / var_138_4
				local var_138_6 = Vector3.New(390, -350, -180)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10015, var_138_6, var_138_5)
			end

			if arg_135_1.time_ >= var_138_1 + var_138_4 and arg_135_1.time_ < var_138_1 + var_138_4 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_138_7 = arg_135_1.actors_["10017"]
			local var_138_8 = 0

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 and not isNil(var_138_7) then
				local var_138_9 = var_138_7:GetComponent("Image")

				if var_138_9 then
					arg_135_1.var_.highlightMatValue10017 = var_138_9
				end
			end

			local var_138_10 = 0.034

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_10 and not isNil(var_138_7) then
				local var_138_11 = (arg_135_1.time_ - var_138_8) / var_138_10

				if arg_135_1.var_.highlightMatValue10017 then
					local var_138_12 = Mathf.Lerp(1, 0.5, var_138_11)
					local var_138_13 = arg_135_1.var_.highlightMatValue10017
					local var_138_14 = var_138_13.color

					var_138_14.r = var_138_12
					var_138_14.g = var_138_12
					var_138_14.b = var_138_12
					var_138_13.color = var_138_14
				end
			end

			if arg_135_1.time_ >= var_138_8 + var_138_10 and arg_135_1.time_ < var_138_8 + var_138_10 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.highlightMatValue10017 then
				local var_138_15 = 0.5
				local var_138_16 = arg_135_1.var_.highlightMatValue10017
				local var_138_17 = var_138_16.color

				var_138_17.r = var_138_15
				var_138_17.g = var_138_15
				var_138_17.b = var_138_15
				var_138_16.color = var_138_17
			end

			local var_138_18 = arg_135_1.actors_["10015"]
			local var_138_19 = 0

			if var_138_19 < arg_135_1.time_ and arg_135_1.time_ <= var_138_19 + arg_138_0 and not isNil(var_138_18) and arg_135_1.var_.actorSpriteComps10015 == nil then
				arg_135_1.var_.actorSpriteComps10015 = var_138_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_20 = 0.034

			if var_138_19 <= arg_135_1.time_ and arg_135_1.time_ < var_138_19 + var_138_20 and not isNil(var_138_18) then
				local var_138_21 = (arg_135_1.time_ - var_138_19) / var_138_20

				if arg_135_1.var_.actorSpriteComps10015 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_138_2 then
							if arg_135_1.isInRecall_ then
								local var_138_22 = Mathf.Lerp(iter_138_2.color.r, arg_135_1.hightColor1.r, var_138_21)
								local var_138_23 = Mathf.Lerp(iter_138_2.color.g, arg_135_1.hightColor1.g, var_138_21)
								local var_138_24 = Mathf.Lerp(iter_138_2.color.b, arg_135_1.hightColor1.b, var_138_21)

								iter_138_2.color = Color.New(var_138_22, var_138_23, var_138_24)
							else
								local var_138_25 = Mathf.Lerp(iter_138_2.color.r, 1, var_138_21)

								iter_138_2.color = Color.New(var_138_25, var_138_25, var_138_25)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_19 + var_138_20 and arg_135_1.time_ < var_138_19 + var_138_20 + arg_138_0 and not isNil(var_138_18) and arg_135_1.var_.actorSpriteComps10015 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_138_4 then
						if arg_135_1.isInRecall_ then
							iter_138_4.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10015 = nil
			end

			local var_138_26 = arg_135_1.actors_["10015"]
			local var_138_27 = 0

			if var_138_27 < arg_135_1.time_ and arg_135_1.time_ <= var_138_27 + arg_138_0 then
				local var_138_28 = var_138_26:GetComponentInChildren(typeof(CanvasGroup))

				if var_138_28 then
					arg_135_1.var_.alphaOldValue10015 = var_138_28.alpha
					arg_135_1.var_.characterEffect10015 = var_138_28
				end

				arg_135_1.var_.alphaOldValue10015 = 0
			end

			local var_138_29 = 0.5

			if var_138_27 <= arg_135_1.time_ and arg_135_1.time_ < var_138_27 + var_138_29 then
				local var_138_30 = (arg_135_1.time_ - var_138_27) / var_138_29
				local var_138_31 = Mathf.Lerp(arg_135_1.var_.alphaOldValue10015, 1, var_138_30)

				if arg_135_1.var_.characterEffect10015 then
					arg_135_1.var_.characterEffect10015.alpha = var_138_31
				end
			end

			if arg_135_1.time_ >= var_138_27 + var_138_29 and arg_135_1.time_ < var_138_27 + var_138_29 + arg_138_0 and arg_135_1.var_.characterEffect10015 then
				arg_135_1.var_.characterEffect10015.alpha = 1
			end

			local var_138_32 = 0
			local var_138_33 = 0.275

			if var_138_32 < arg_135_1.time_ and arg_135_1.time_ <= var_138_32 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_34 = arg_135_1:FormatText(StoryNameCfg[208].name)

				arg_135_1.leftNameTxt_.text = var_138_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_35 = arg_135_1:GetWordFromCfg(114202033)
				local var_138_36 = arg_135_1:FormatText(var_138_35.content)

				arg_135_1.text_.text = var_138_36

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_37 = 11
				local var_138_38 = utf8.len(var_138_36)
				local var_138_39 = var_138_37 <= 0 and var_138_33 or var_138_33 * (var_138_38 / var_138_37)

				if var_138_39 > 0 and var_138_33 < var_138_39 then
					arg_135_1.talkMaxDuration = var_138_39

					if var_138_39 + var_138_32 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_39 + var_138_32
					end
				end

				arg_135_1.text_.text = var_138_36
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202033", "story_v_out_114202.awb") ~= 0 then
					local var_138_40 = manager.audio:GetVoiceLength("story_v_out_114202", "114202033", "story_v_out_114202.awb") / 1000

					if var_138_40 + var_138_32 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_40 + var_138_32
					end

					if var_138_35.prefab_name ~= "" and arg_135_1.actors_[var_138_35.prefab_name] ~= nil then
						local var_138_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_35.prefab_name].transform, "story_v_out_114202", "114202033", "story_v_out_114202.awb")

						arg_135_1:RecordAudio("114202033", var_138_41)
						arg_135_1:RecordAudio("114202033", var_138_41)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_114202", "114202033", "story_v_out_114202.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_114202", "114202033", "story_v_out_114202.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_42 = math.max(var_138_33, arg_135_1.talkMaxDuration)

			if var_138_32 <= arg_135_1.time_ and arg_135_1.time_ < var_138_32 + var_138_42 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_32) / var_138_42

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_32 + var_138_42 and arg_135_1.time_ < var_138_32 + var_138_42 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play114202034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 114202034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play114202035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10015"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10015 == nil then
				arg_139_1.var_.actorSpriteComps10015 = var_142_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_2 = 0.034

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.actorSpriteComps10015 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								local var_142_4 = Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor2.r, var_142_3)
								local var_142_5 = Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor2.g, var_142_3)
								local var_142_6 = Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor2.b, var_142_3)

								iter_142_1.color = Color.New(var_142_4, var_142_5, var_142_6)
							else
								local var_142_7 = Mathf.Lerp(iter_142_1.color.r, 0.5, var_142_3)

								iter_142_1.color = Color.New(var_142_7, var_142_7, var_142_7)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10015 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_142_3 then
						if arg_139_1.isInRecall_ then
							iter_142_3.color = arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_142_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10015 = nil
			end

			local var_142_8 = 0
			local var_142_9 = 1.3

			if var_142_8 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(114202034)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_12 = 52
				local var_142_13 = utf8.len(var_142_11)
				local var_142_14 = var_142_12 <= 0 and var_142_9 or var_142_9 * (var_142_13 / var_142_12)

				if var_142_14 > 0 and var_142_9 < var_142_14 then
					arg_139_1.talkMaxDuration = var_142_14

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_15 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_15 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_15

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_15 and arg_139_1.time_ < var_142_8 + var_142_15 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play114202035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 114202035
		arg_143_1.duration_ = 2.03

		local var_143_0 = {
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 2.033,
			en = 1.133
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
				arg_143_0:Play114202036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10017"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) then
				local var_146_2 = var_146_0:GetComponent("Image")

				if var_146_2 then
					arg_143_1.var_.highlightMatValue10017 = var_146_2
				end
			end

			local var_146_3 = 0.034

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_3 and not isNil(var_146_0) then
				local var_146_4 = (arg_143_1.time_ - var_146_1) / var_146_3

				if arg_143_1.var_.highlightMatValue10017 then
					local var_146_5 = Mathf.Lerp(0.5, 1, var_146_4)
					local var_146_6 = arg_143_1.var_.highlightMatValue10017
					local var_146_7 = var_146_6.color

					var_146_7.r = var_146_5
					var_146_7.g = var_146_5
					var_146_7.b = var_146_5
					var_146_6.color = var_146_7
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_3 and arg_143_1.time_ < var_146_1 + var_146_3 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.highlightMatValue10017 then
				local var_146_8 = 1

				var_146_0.transform:SetSiblingIndex(1)

				local var_146_9 = arg_143_1.var_.highlightMatValue10017
				local var_146_10 = var_146_9.color

				var_146_10.r = var_146_8
				var_146_10.g = var_146_8
				var_146_10.b = var_146_8
				var_146_9.color = var_146_10
			end

			local var_146_11 = arg_143_1.actors_["10015"]
			local var_146_12 = 0

			if var_146_12 < arg_143_1.time_ and arg_143_1.time_ <= var_146_12 + arg_146_0 and not isNil(var_146_11) and arg_143_1.var_.actorSpriteComps10015 == nil then
				arg_143_1.var_.actorSpriteComps10015 = var_146_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_13 = 0.034

			if var_146_12 <= arg_143_1.time_ and arg_143_1.time_ < var_146_12 + var_146_13 and not isNil(var_146_11) then
				local var_146_14 = (arg_143_1.time_ - var_146_12) / var_146_13

				if arg_143_1.var_.actorSpriteComps10015 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								local var_146_15 = Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor2.r, var_146_14)
								local var_146_16 = Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor2.g, var_146_14)
								local var_146_17 = Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor2.b, var_146_14)

								iter_146_1.color = Color.New(var_146_15, var_146_16, var_146_17)
							else
								local var_146_18 = Mathf.Lerp(iter_146_1.color.r, 0.5, var_146_14)

								iter_146_1.color = Color.New(var_146_18, var_146_18, var_146_18)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_12 + var_146_13 and arg_143_1.time_ < var_146_12 + var_146_13 + arg_146_0 and not isNil(var_146_11) and arg_143_1.var_.actorSpriteComps10015 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_146_3 then
						if arg_143_1.isInRecall_ then
							iter_146_3.color = arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_146_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps10015 = nil
			end

			local var_146_19 = 0
			local var_146_20 = 0.075

			if var_146_19 < arg_143_1.time_ and arg_143_1.time_ <= var_146_19 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_21 = arg_143_1:FormatText(StoryNameCfg[255].name)

				arg_143_1.leftNameTxt_.text = var_146_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_22 = arg_143_1:GetWordFromCfg(114202035)
				local var_146_23 = arg_143_1:FormatText(var_146_22.content)

				arg_143_1.text_.text = var_146_23

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_24 = 3
				local var_146_25 = utf8.len(var_146_23)
				local var_146_26 = var_146_24 <= 0 and var_146_20 or var_146_20 * (var_146_25 / var_146_24)

				if var_146_26 > 0 and var_146_20 < var_146_26 then
					arg_143_1.talkMaxDuration = var_146_26

					if var_146_26 + var_146_19 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_26 + var_146_19
					end
				end

				arg_143_1.text_.text = var_146_23
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202035", "story_v_out_114202.awb") ~= 0 then
					local var_146_27 = manager.audio:GetVoiceLength("story_v_out_114202", "114202035", "story_v_out_114202.awb") / 1000

					if var_146_27 + var_146_19 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_27 + var_146_19
					end

					if var_146_22.prefab_name ~= "" and arg_143_1.actors_[var_146_22.prefab_name] ~= nil then
						local var_146_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_22.prefab_name].transform, "story_v_out_114202", "114202035", "story_v_out_114202.awb")

						arg_143_1:RecordAudio("114202035", var_146_28)
						arg_143_1:RecordAudio("114202035", var_146_28)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_114202", "114202035", "story_v_out_114202.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_114202", "114202035", "story_v_out_114202.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_29 = math.max(var_146_20, arg_143_1.talkMaxDuration)

			if var_146_19 <= arg_143_1.time_ and arg_143_1.time_ < var_146_19 + var_146_29 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_19) / var_146_29

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_19 + var_146_29 and arg_143_1.time_ < var_146_19 + var_146_29 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play114202036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 114202036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play114202037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10017"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) then
				local var_150_2 = var_150_0:GetComponent("Image")

				if var_150_2 then
					arg_147_1.var_.highlightMatValue10017 = var_150_2
				end
			end

			local var_150_3 = 0.034

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_3 and not isNil(var_150_0) then
				local var_150_4 = (arg_147_1.time_ - var_150_1) / var_150_3

				if arg_147_1.var_.highlightMatValue10017 then
					local var_150_5 = Mathf.Lerp(1, 0.5, var_150_4)
					local var_150_6 = arg_147_1.var_.highlightMatValue10017
					local var_150_7 = var_150_6.color

					var_150_7.r = var_150_5
					var_150_7.g = var_150_5
					var_150_7.b = var_150_5
					var_150_6.color = var_150_7
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_3 and arg_147_1.time_ < var_150_1 + var_150_3 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.highlightMatValue10017 then
				local var_150_8 = 0.5
				local var_150_9 = arg_147_1.var_.highlightMatValue10017
				local var_150_10 = var_150_9.color

				var_150_10.r = var_150_8
				var_150_10.g = var_150_8
				var_150_10.b = var_150_8
				var_150_9.color = var_150_10
			end

			local var_150_11 = 0
			local var_150_12 = 1.475

			if var_150_11 < arg_147_1.time_ and arg_147_1.time_ <= var_150_11 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_13 = arg_147_1:GetWordFromCfg(114202036)
				local var_150_14 = arg_147_1:FormatText(var_150_13.content)

				arg_147_1.text_.text = var_150_14

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_15 = 59
				local var_150_16 = utf8.len(var_150_14)
				local var_150_17 = var_150_15 <= 0 and var_150_12 or var_150_12 * (var_150_16 / var_150_15)

				if var_150_17 > 0 and var_150_12 < var_150_17 then
					arg_147_1.talkMaxDuration = var_150_17

					if var_150_17 + var_150_11 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_17 + var_150_11
					end
				end

				arg_147_1.text_.text = var_150_14
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_18 = math.max(var_150_12, arg_147_1.talkMaxDuration)

			if var_150_11 <= arg_147_1.time_ and arg_147_1.time_ < var_150_11 + var_150_18 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_11) / var_150_18

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_11 + var_150_18 and arg_147_1.time_ < var_150_11 + var_150_18 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play114202037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 114202037
		arg_151_1.duration_ = 10.6

		local var_151_0 = {
			ja = 7.5,
			ko = 10.3,
			zh = 8.9,
			en = 10.6
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
				arg_151_0:Play114202038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10017"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) then
				local var_154_2 = var_154_0:GetComponent("Image")

				if var_154_2 then
					arg_151_1.var_.highlightMatValue10017 = var_154_2
				end
			end

			local var_154_3 = 0.034

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_3 and not isNil(var_154_0) then
				local var_154_4 = (arg_151_1.time_ - var_154_1) / var_154_3

				if arg_151_1.var_.highlightMatValue10017 then
					local var_154_5 = Mathf.Lerp(0.5, 1, var_154_4)
					local var_154_6 = arg_151_1.var_.highlightMatValue10017
					local var_154_7 = var_154_6.color

					var_154_7.r = var_154_5
					var_154_7.g = var_154_5
					var_154_7.b = var_154_5
					var_154_6.color = var_154_7
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_3 and arg_151_1.time_ < var_154_1 + var_154_3 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.highlightMatValue10017 then
				local var_154_8 = 1

				var_154_0.transform:SetSiblingIndex(1)

				local var_154_9 = arg_151_1.var_.highlightMatValue10017
				local var_154_10 = var_154_9.color

				var_154_10.r = var_154_8
				var_154_10.g = var_154_8
				var_154_10.b = var_154_8
				var_154_9.color = var_154_10
			end

			local var_154_11 = 0
			local var_154_12 = 1

			if var_154_11 < arg_151_1.time_ and arg_151_1.time_ <= var_154_11 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_13 = arg_151_1:FormatText(StoryNameCfg[255].name)

				arg_151_1.leftNameTxt_.text = var_154_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_14 = arg_151_1:GetWordFromCfg(114202037)
				local var_154_15 = arg_151_1:FormatText(var_154_14.content)

				arg_151_1.text_.text = var_154_15

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_16 = 40
				local var_154_17 = utf8.len(var_154_15)
				local var_154_18 = var_154_16 <= 0 and var_154_12 or var_154_12 * (var_154_17 / var_154_16)

				if var_154_18 > 0 and var_154_12 < var_154_18 then
					arg_151_1.talkMaxDuration = var_154_18

					if var_154_18 + var_154_11 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_18 + var_154_11
					end
				end

				arg_151_1.text_.text = var_154_15
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202037", "story_v_out_114202.awb") ~= 0 then
					local var_154_19 = manager.audio:GetVoiceLength("story_v_out_114202", "114202037", "story_v_out_114202.awb") / 1000

					if var_154_19 + var_154_11 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_19 + var_154_11
					end

					if var_154_14.prefab_name ~= "" and arg_151_1.actors_[var_154_14.prefab_name] ~= nil then
						local var_154_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_14.prefab_name].transform, "story_v_out_114202", "114202037", "story_v_out_114202.awb")

						arg_151_1:RecordAudio("114202037", var_154_20)
						arg_151_1:RecordAudio("114202037", var_154_20)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_114202", "114202037", "story_v_out_114202.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_114202", "114202037", "story_v_out_114202.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_21 = math.max(var_154_12, arg_151_1.talkMaxDuration)

			if var_154_11 <= arg_151_1.time_ and arg_151_1.time_ < var_154_11 + var_154_21 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_11) / var_154_21

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_11 + var_154_21 and arg_151_1.time_ < var_154_11 + var_154_21 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play114202038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 114202038
		arg_155_1.duration_ = 14.03

		local var_155_0 = {
			ja = 10.466,
			ko = 12.3,
			zh = 10.966,
			en = 14.033
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
				arg_155_0:Play114202039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 1.325

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[255].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:GetWordFromCfg(114202038)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 53
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202038", "story_v_out_114202.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_114202", "114202038", "story_v_out_114202.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_114202", "114202038", "story_v_out_114202.awb")

						arg_155_1:RecordAudio("114202038", var_158_9)
						arg_155_1:RecordAudio("114202038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_114202", "114202038", "story_v_out_114202.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_114202", "114202038", "story_v_out_114202.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_10 and arg_155_1.time_ < var_158_0 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play114202039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 114202039
		arg_159_1.duration_ = 12.4

		local var_159_0 = {
			ja = 9,
			ko = 10.233,
			zh = 12.4,
			en = 12.1
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
				arg_159_0:Play114202040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 1.225

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[255].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:GetWordFromCfg(114202039)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 49
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202039", "story_v_out_114202.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_114202", "114202039", "story_v_out_114202.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_114202", "114202039", "story_v_out_114202.awb")

						arg_159_1:RecordAudio("114202039", var_162_9)
						arg_159_1:RecordAudio("114202039", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_114202", "114202039", "story_v_out_114202.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_114202", "114202039", "story_v_out_114202.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_10 and arg_159_1.time_ < var_162_0 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play114202040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 114202040
		arg_163_1.duration_ = 2.47

		local var_163_0 = {
			ja = 2.466,
			ko = 1.5,
			zh = 0.999999999999,
			en = 1.266
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
				arg_163_0:Play114202041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10017"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) then
				local var_166_2 = var_166_0:GetComponent("Image")

				if var_166_2 then
					arg_163_1.var_.highlightMatValue10017 = var_166_2
				end
			end

			local var_166_3 = 0.034

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_3 and not isNil(var_166_0) then
				local var_166_4 = (arg_163_1.time_ - var_166_1) / var_166_3

				if arg_163_1.var_.highlightMatValue10017 then
					local var_166_5 = Mathf.Lerp(1, 0.5, var_166_4)
					local var_166_6 = arg_163_1.var_.highlightMatValue10017
					local var_166_7 = var_166_6.color

					var_166_7.r = var_166_5
					var_166_7.g = var_166_5
					var_166_7.b = var_166_5
					var_166_6.color = var_166_7
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_3 and arg_163_1.time_ < var_166_1 + var_166_3 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.highlightMatValue10017 then
				local var_166_8 = 0.5
				local var_166_9 = arg_163_1.var_.highlightMatValue10017
				local var_166_10 = var_166_9.color

				var_166_10.r = var_166_8
				var_166_10.g = var_166_8
				var_166_10.b = var_166_8
				var_166_9.color = var_166_10
			end

			local var_166_11 = arg_163_1.actors_["10015"]
			local var_166_12 = 0

			if var_166_12 < arg_163_1.time_ and arg_163_1.time_ <= var_166_12 + arg_166_0 and not isNil(var_166_11) and arg_163_1.var_.actorSpriteComps10015 == nil then
				arg_163_1.var_.actorSpriteComps10015 = var_166_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_13 = 0.034

			if var_166_12 <= arg_163_1.time_ and arg_163_1.time_ < var_166_12 + var_166_13 and not isNil(var_166_11) then
				local var_166_14 = (arg_163_1.time_ - var_166_12) / var_166_13

				if arg_163_1.var_.actorSpriteComps10015 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								local var_166_15 = Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor1.r, var_166_14)
								local var_166_16 = Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor1.g, var_166_14)
								local var_166_17 = Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor1.b, var_166_14)

								iter_166_1.color = Color.New(var_166_15, var_166_16, var_166_17)
							else
								local var_166_18 = Mathf.Lerp(iter_166_1.color.r, 1, var_166_14)

								iter_166_1.color = Color.New(var_166_18, var_166_18, var_166_18)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_12 + var_166_13 and arg_163_1.time_ < var_166_12 + var_166_13 + arg_166_0 and not isNil(var_166_11) and arg_163_1.var_.actorSpriteComps10015 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_166_3 then
						if arg_163_1.isInRecall_ then
							iter_166_3.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10015 = nil
			end

			local var_166_19 = 0
			local var_166_20 = 0.05

			if var_166_19 < arg_163_1.time_ and arg_163_1.time_ <= var_166_19 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_21 = arg_163_1:FormatText(StoryNameCfg[208].name)

				arg_163_1.leftNameTxt_.text = var_166_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_22 = arg_163_1:GetWordFromCfg(114202040)
				local var_166_23 = arg_163_1:FormatText(var_166_22.content)

				arg_163_1.text_.text = var_166_23

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_24 = 2
				local var_166_25 = utf8.len(var_166_23)
				local var_166_26 = var_166_24 <= 0 and var_166_20 or var_166_20 * (var_166_25 / var_166_24)

				if var_166_26 > 0 and var_166_20 < var_166_26 then
					arg_163_1.talkMaxDuration = var_166_26

					if var_166_26 + var_166_19 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_26 + var_166_19
					end
				end

				arg_163_1.text_.text = var_166_23
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202040", "story_v_out_114202.awb") ~= 0 then
					local var_166_27 = manager.audio:GetVoiceLength("story_v_out_114202", "114202040", "story_v_out_114202.awb") / 1000

					if var_166_27 + var_166_19 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_27 + var_166_19
					end

					if var_166_22.prefab_name ~= "" and arg_163_1.actors_[var_166_22.prefab_name] ~= nil then
						local var_166_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_22.prefab_name].transform, "story_v_out_114202", "114202040", "story_v_out_114202.awb")

						arg_163_1:RecordAudio("114202040", var_166_28)
						arg_163_1:RecordAudio("114202040", var_166_28)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_114202", "114202040", "story_v_out_114202.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_114202", "114202040", "story_v_out_114202.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_29 = math.max(var_166_20, arg_163_1.talkMaxDuration)

			if var_166_19 <= arg_163_1.time_ and arg_163_1.time_ < var_166_19 + var_166_29 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_19) / var_166_29

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_19 + var_166_29 and arg_163_1.time_ < var_166_19 + var_166_29 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play114202041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 114202041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play114202042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10015"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps10015 == nil then
				arg_167_1.var_.actorSpriteComps10015 = var_170_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_2 = 0.034

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.actorSpriteComps10015 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								local var_170_4 = Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor2.r, var_170_3)
								local var_170_5 = Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor2.g, var_170_3)
								local var_170_6 = Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor2.b, var_170_3)

								iter_170_1.color = Color.New(var_170_4, var_170_5, var_170_6)
							else
								local var_170_7 = Mathf.Lerp(iter_170_1.color.r, 0.5, var_170_3)

								iter_170_1.color = Color.New(var_170_7, var_170_7, var_170_7)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps10015 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_170_3 then
						if arg_167_1.isInRecall_ then
							iter_170_3.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10015 = nil
			end

			local var_170_8 = 0
			local var_170_9 = 1.65

			if var_170_8 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_10 = arg_167_1:GetWordFromCfg(114202041)
				local var_170_11 = arg_167_1:FormatText(var_170_10.content)

				arg_167_1.text_.text = var_170_11

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_12 = 66
				local var_170_13 = utf8.len(var_170_11)
				local var_170_14 = var_170_12 <= 0 and var_170_9 or var_170_9 * (var_170_13 / var_170_12)

				if var_170_14 > 0 and var_170_9 < var_170_14 then
					arg_167_1.talkMaxDuration = var_170_14

					if var_170_14 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_11
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_15 = math.max(var_170_9, arg_167_1.talkMaxDuration)

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_15 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_8) / var_170_15

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_8 + var_170_15 and arg_167_1.time_ < var_170_8 + var_170_15 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play114202042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 114202042
		arg_171_1.duration_ = 15.3

		local var_171_0 = {
			ja = 8.266,
			ko = 12.366,
			zh = 11.7,
			en = 15.3
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
				arg_171_0:Play114202043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10017"].transform
			local var_174_1 = 2

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos10017 = var_174_0.localPosition
				var_174_0.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10017", 3)
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0, -350, -180)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10017, var_174_4, var_174_3)
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_174_5 = arg_171_1.actors_["10017"]
			local var_174_6 = 2

			if var_174_6 < arg_171_1.time_ and arg_171_1.time_ <= var_174_6 + arg_174_0 and not isNil(var_174_5) then
				local var_174_7 = var_174_5:GetComponent("Image")

				if var_174_7 then
					arg_171_1.var_.highlightMatValue10017 = var_174_7
				end
			end

			local var_174_8 = 0.034

			if var_174_6 <= arg_171_1.time_ and arg_171_1.time_ < var_174_6 + var_174_8 and not isNil(var_174_5) then
				local var_174_9 = (arg_171_1.time_ - var_174_6) / var_174_8

				if arg_171_1.var_.highlightMatValue10017 then
					local var_174_10 = Mathf.Lerp(0.5, 1, var_174_9)
					local var_174_11 = arg_171_1.var_.highlightMatValue10017
					local var_174_12 = var_174_11.color

					var_174_12.r = var_174_10
					var_174_12.g = var_174_10
					var_174_12.b = var_174_10
					var_174_11.color = var_174_12
				end
			end

			if arg_171_1.time_ >= var_174_6 + var_174_8 and arg_171_1.time_ < var_174_6 + var_174_8 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.highlightMatValue10017 then
				local var_174_13 = 1

				var_174_5.transform:SetSiblingIndex(1)

				local var_174_14 = arg_171_1.var_.highlightMatValue10017
				local var_174_15 = var_174_14.color

				var_174_15.r = var_174_13
				var_174_15.g = var_174_13
				var_174_15.b = var_174_13
				var_174_14.color = var_174_15
			end

			local var_174_16 = 0

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_17 = 2

			if var_174_16 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_17 then
				local var_174_18 = (arg_171_1.time_ - var_174_16) / var_174_17
				local var_174_19 = Color.New(1, 1, 1)

				var_174_19.a = Mathf.Lerp(1, 0, var_174_18)
				arg_171_1.mask_.color = var_174_19
			end

			if arg_171_1.time_ >= var_174_16 + var_174_17 and arg_171_1.time_ < var_174_16 + var_174_17 + arg_174_0 then
				local var_174_20 = Color.New(1, 1, 1)
				local var_174_21 = 0

				arg_171_1.mask_.enabled = false
				var_174_20.a = var_174_21
				arg_171_1.mask_.color = var_174_20
			end

			local var_174_22 = arg_171_1.actors_["10017"]
			local var_174_23 = 2

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 then
				local var_174_24 = var_174_22:GetComponent("Image")

				if var_174_24 then
					arg_171_1.var_.alphaMatValue10017 = var_174_24
					arg_171_1.var_.alphaOldValue10017 = var_174_24.color.a
				end

				arg_171_1.var_.alphaOldValue10017 = 0
			end

			local var_174_25 = 0.5

			if var_174_23 <= arg_171_1.time_ and arg_171_1.time_ < var_174_23 + var_174_25 then
				local var_174_26 = (arg_171_1.time_ - var_174_23) / var_174_25
				local var_174_27 = Mathf.Lerp(arg_171_1.var_.alphaOldValue10017, 1, var_174_26)

				if arg_171_1.var_.alphaMatValue10017 then
					local var_174_28 = arg_171_1.var_.alphaMatValue10017.color

					var_174_28.a = var_174_27
					arg_171_1.var_.alphaMatValue10017.color = var_174_28
				end
			end

			if arg_171_1.time_ >= var_174_23 + var_174_25 and arg_171_1.time_ < var_174_23 + var_174_25 + arg_174_0 and arg_171_1.var_.alphaMatValue10017 then
				local var_174_29 = arg_171_1.var_.alphaMatValue10017
				local var_174_30 = var_174_29.color

				var_174_30.a = 1
				var_174_29.color = var_174_30
			end

			local var_174_31 = arg_171_1.actors_["10017"].transform
			local var_174_32 = 0

			if var_174_32 < arg_171_1.time_ and arg_171_1.time_ <= var_174_32 + arg_174_0 then
				arg_171_1.var_.moveOldPos10017 = var_174_31.localPosition
				var_174_31.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10017", 7)
			end

			local var_174_33 = 0.001

			if var_174_32 <= arg_171_1.time_ and arg_171_1.time_ < var_174_32 + var_174_33 then
				local var_174_34 = (arg_171_1.time_ - var_174_32) / var_174_33
				local var_174_35 = Vector3.New(0, -2000, 300)

				var_174_31.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10017, var_174_35, var_174_34)
			end

			if arg_171_1.time_ >= var_174_32 + var_174_33 and arg_171_1.time_ < var_174_32 + var_174_33 + arg_174_0 then
				var_174_31.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_174_36 = arg_171_1.actors_["10015"].transform
			local var_174_37 = 0

			if var_174_37 < arg_171_1.time_ and arg_171_1.time_ <= var_174_37 + arg_174_0 then
				arg_171_1.var_.moveOldPos10015 = var_174_36.localPosition
				var_174_36.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10015", 7)

				local var_174_38 = var_174_36.childCount

				for iter_174_0 = 0, var_174_38 - 1 do
					local var_174_39 = var_174_36:GetChild(iter_174_0)

					if var_174_39.name == "split_1" or not string.find(var_174_39.name, "split") then
						var_174_39.gameObject:SetActive(true)
					else
						var_174_39.gameObject:SetActive(false)
					end
				end
			end

			local var_174_40 = 0.001

			if var_174_37 <= arg_171_1.time_ and arg_171_1.time_ < var_174_37 + var_174_40 then
				local var_174_41 = (arg_171_1.time_ - var_174_37) / var_174_40
				local var_174_42 = Vector3.New(0, -2000, 300)

				var_174_36.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10015, var_174_42, var_174_41)
			end

			if arg_171_1.time_ >= var_174_37 + var_174_40 and arg_171_1.time_ < var_174_37 + var_174_40 + arg_174_0 then
				var_174_36.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_174_43 = 0

			if var_174_43 < arg_171_1.time_ and arg_171_1.time_ <= var_174_43 + arg_174_0 then
				local var_174_44 = manager.ui.mainCamera.transform.localPosition
				local var_174_45 = Vector3.New(0, 0, 10) + Vector3.New(var_174_44.x, var_174_44.y, 0)
				local var_174_46 = arg_171_1.bgs_.F04

				var_174_46.transform.localPosition = var_174_45
				var_174_46.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_47 = var_174_46:GetComponent("SpriteRenderer")

				if var_174_47 and var_174_47.sprite then
					local var_174_48 = (var_174_46.transform.localPosition - var_174_44).z
					local var_174_49 = manager.ui.mainCameraCom_
					local var_174_50 = 2 * var_174_48 * Mathf.Tan(var_174_49.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_174_51 = var_174_50 * var_174_49.aspect
					local var_174_52 = var_174_47.sprite.bounds.size.x
					local var_174_53 = var_174_47.sprite.bounds.size.y
					local var_174_54 = var_174_51 / var_174_52
					local var_174_55 = var_174_50 / var_174_53
					local var_174_56 = var_174_55 < var_174_54 and var_174_54 or var_174_55

					var_174_46.transform.localScale = Vector3.New(var_174_56, var_174_56, 0)
				end

				for iter_174_1, iter_174_2 in pairs(arg_171_1.bgs_) do
					if iter_174_1 ~= "F04" then
						iter_174_2.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_57 = 2
			local var_174_58 = 1.125

			if var_174_57 < arg_171_1.time_ and arg_171_1.time_ <= var_174_57 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_59 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_59:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_171_1.dialogCg_.alpha = arg_175_0
				end))
				var_174_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_60 = arg_171_1:FormatText(StoryNameCfg[255].name)

				arg_171_1.leftNameTxt_.text = var_174_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_61 = arg_171_1:GetWordFromCfg(114202042)
				local var_174_62 = arg_171_1:FormatText(var_174_61.content)

				arg_171_1.text_.text = var_174_62

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_63 = 45
				local var_174_64 = utf8.len(var_174_62)
				local var_174_65 = var_174_63 <= 0 and var_174_58 or var_174_58 * (var_174_64 / var_174_63)

				if var_174_65 > 0 and var_174_58 < var_174_65 then
					arg_171_1.talkMaxDuration = var_174_65
					var_174_57 = var_174_57 + 0.3

					if var_174_65 + var_174_57 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_65 + var_174_57
					end
				end

				arg_171_1.text_.text = var_174_62
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202042", "story_v_out_114202.awb") ~= 0 then
					local var_174_66 = manager.audio:GetVoiceLength("story_v_out_114202", "114202042", "story_v_out_114202.awb") / 1000

					if var_174_66 + var_174_57 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_66 + var_174_57
					end

					if var_174_61.prefab_name ~= "" and arg_171_1.actors_[var_174_61.prefab_name] ~= nil then
						local var_174_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_61.prefab_name].transform, "story_v_out_114202", "114202042", "story_v_out_114202.awb")

						arg_171_1:RecordAudio("114202042", var_174_67)
						arg_171_1:RecordAudio("114202042", var_174_67)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_114202", "114202042", "story_v_out_114202.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_114202", "114202042", "story_v_out_114202.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_68 = var_174_57 + 0.3
			local var_174_69 = math.max(var_174_58, arg_171_1.talkMaxDuration)

			if var_174_68 <= arg_171_1.time_ and arg_171_1.time_ < var_174_68 + var_174_69 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_68) / var_174_69

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_68 + var_174_69 and arg_171_1.time_ < var_174_68 + var_174_69 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play114202043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 114202043
		arg_177_1.duration_ = 6.9

		local var_177_0 = {
			ja = 5.9,
			ko = 6.9,
			zh = 4.9,
			en = 5.466
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play114202044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10017"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) then
				local var_180_2 = var_180_0:GetComponent("Image")

				if var_180_2 then
					arg_177_1.var_.highlightMatValue10017 = var_180_2
				end
			end

			local var_180_3 = 0.034

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_3 and not isNil(var_180_0) then
				local var_180_4 = (arg_177_1.time_ - var_180_1) / var_180_3

				if arg_177_1.var_.highlightMatValue10017 then
					local var_180_5 = Mathf.Lerp(1, 0.5, var_180_4)
					local var_180_6 = arg_177_1.var_.highlightMatValue10017
					local var_180_7 = var_180_6.color

					var_180_7.r = var_180_5
					var_180_7.g = var_180_5
					var_180_7.b = var_180_5
					var_180_6.color = var_180_7
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_3 and arg_177_1.time_ < var_180_1 + var_180_3 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.highlightMatValue10017 then
				local var_180_8 = 0.5
				local var_180_9 = arg_177_1.var_.highlightMatValue10017
				local var_180_10 = var_180_9.color

				var_180_10.r = var_180_8
				var_180_10.g = var_180_8
				var_180_10.b = var_180_8
				var_180_9.color = var_180_10
			end

			local var_180_11 = 0
			local var_180_12 = 0.55

			if var_180_11 < arg_177_1.time_ and arg_177_1.time_ <= var_180_11 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_13 = arg_177_1:FormatText(StoryNameCfg[209].name)

				arg_177_1.leftNameTxt_.text = var_180_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_14 = arg_177_1:GetWordFromCfg(114202043)
				local var_180_15 = arg_177_1:FormatText(var_180_14.content)

				arg_177_1.text_.text = var_180_15

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_16 = 22
				local var_180_17 = utf8.len(var_180_15)
				local var_180_18 = var_180_16 <= 0 and var_180_12 or var_180_12 * (var_180_17 / var_180_16)

				if var_180_18 > 0 and var_180_12 < var_180_18 then
					arg_177_1.talkMaxDuration = var_180_18

					if var_180_18 + var_180_11 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_18 + var_180_11
					end
				end

				arg_177_1.text_.text = var_180_15
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202043", "story_v_out_114202.awb") ~= 0 then
					local var_180_19 = manager.audio:GetVoiceLength("story_v_out_114202", "114202043", "story_v_out_114202.awb") / 1000

					if var_180_19 + var_180_11 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_19 + var_180_11
					end

					if var_180_14.prefab_name ~= "" and arg_177_1.actors_[var_180_14.prefab_name] ~= nil then
						local var_180_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_14.prefab_name].transform, "story_v_out_114202", "114202043", "story_v_out_114202.awb")

						arg_177_1:RecordAudio("114202043", var_180_20)
						arg_177_1:RecordAudio("114202043", var_180_20)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_114202", "114202043", "story_v_out_114202.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_114202", "114202043", "story_v_out_114202.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_21 = math.max(var_180_12, arg_177_1.talkMaxDuration)

			if var_180_11 <= arg_177_1.time_ and arg_177_1.time_ < var_180_11 + var_180_21 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_11) / var_180_21

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_11 + var_180_21 and arg_177_1.time_ < var_180_11 + var_180_21 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play114202044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 114202044
		arg_181_1.duration_ = 5.43

		local var_181_0 = {
			ja = 5.433,
			ko = 4.9,
			zh = 4.466,
			en = 4.566
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play114202045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10017"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) then
				local var_184_2 = var_184_0:GetComponent("Image")

				if var_184_2 then
					arg_181_1.var_.highlightMatValue10017 = var_184_2
				end
			end

			local var_184_3 = 0.034

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_3 and not isNil(var_184_0) then
				local var_184_4 = (arg_181_1.time_ - var_184_1) / var_184_3

				if arg_181_1.var_.highlightMatValue10017 then
					local var_184_5 = Mathf.Lerp(0.5, 1, var_184_4)
					local var_184_6 = arg_181_1.var_.highlightMatValue10017
					local var_184_7 = var_184_6.color

					var_184_7.r = var_184_5
					var_184_7.g = var_184_5
					var_184_7.b = var_184_5
					var_184_6.color = var_184_7
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_3 and arg_181_1.time_ < var_184_1 + var_184_3 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.highlightMatValue10017 then
				local var_184_8 = 1

				var_184_0.transform:SetSiblingIndex(1)

				local var_184_9 = arg_181_1.var_.highlightMatValue10017
				local var_184_10 = var_184_9.color

				var_184_10.r = var_184_8
				var_184_10.g = var_184_8
				var_184_10.b = var_184_8
				var_184_9.color = var_184_10
			end

			local var_184_11 = 0
			local var_184_12 = 0.425

			if var_184_11 < arg_181_1.time_ and arg_181_1.time_ <= var_184_11 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_13 = arg_181_1:FormatText(StoryNameCfg[255].name)

				arg_181_1.leftNameTxt_.text = var_184_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_14 = arg_181_1:GetWordFromCfg(114202044)
				local var_184_15 = arg_181_1:FormatText(var_184_14.content)

				arg_181_1.text_.text = var_184_15

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_16 = 17
				local var_184_17 = utf8.len(var_184_15)
				local var_184_18 = var_184_16 <= 0 and var_184_12 or var_184_12 * (var_184_17 / var_184_16)

				if var_184_18 > 0 and var_184_12 < var_184_18 then
					arg_181_1.talkMaxDuration = var_184_18

					if var_184_18 + var_184_11 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_18 + var_184_11
					end
				end

				arg_181_1.text_.text = var_184_15
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202044", "story_v_out_114202.awb") ~= 0 then
					local var_184_19 = manager.audio:GetVoiceLength("story_v_out_114202", "114202044", "story_v_out_114202.awb") / 1000

					if var_184_19 + var_184_11 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_19 + var_184_11
					end

					if var_184_14.prefab_name ~= "" and arg_181_1.actors_[var_184_14.prefab_name] ~= nil then
						local var_184_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_14.prefab_name].transform, "story_v_out_114202", "114202044", "story_v_out_114202.awb")

						arg_181_1:RecordAudio("114202044", var_184_20)
						arg_181_1:RecordAudio("114202044", var_184_20)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_114202", "114202044", "story_v_out_114202.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_114202", "114202044", "story_v_out_114202.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_21 = math.max(var_184_12, arg_181_1.talkMaxDuration)

			if var_184_11 <= arg_181_1.time_ and arg_181_1.time_ < var_184_11 + var_184_21 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_11) / var_184_21

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_11 + var_184_21 and arg_181_1.time_ < var_184_11 + var_184_21 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play114202045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 114202045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play114202046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10017"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				local var_188_2 = var_188_0:GetComponent("Image")

				if var_188_2 then
					arg_185_1.var_.alphaMatValue10017 = var_188_2
					arg_185_1.var_.alphaOldValue10017 = var_188_2.color.a
				end

				arg_185_1.var_.alphaOldValue10017 = 0
			end

			local var_188_3 = 0.5

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_3 then
				local var_188_4 = (arg_185_1.time_ - var_188_1) / var_188_3
				local var_188_5 = Mathf.Lerp(arg_185_1.var_.alphaOldValue10017, 1, var_188_4)

				if arg_185_1.var_.alphaMatValue10017 then
					local var_188_6 = arg_185_1.var_.alphaMatValue10017.color

					var_188_6.a = var_188_5
					arg_185_1.var_.alphaMatValue10017.color = var_188_6
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_3 and arg_185_1.time_ < var_188_1 + var_188_3 + arg_188_0 and arg_185_1.var_.alphaMatValue10017 then
				local var_188_7 = arg_185_1.var_.alphaMatValue10017
				local var_188_8 = var_188_7.color

				var_188_8.a = 1
				var_188_7.color = var_188_8
			end

			local var_188_9 = 0
			local var_188_10 = 0.725

			if var_188_9 < arg_185_1.time_ and arg_185_1.time_ <= var_188_9 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_11 = arg_185_1:GetWordFromCfg(114202045)
				local var_188_12 = arg_185_1:FormatText(var_188_11.content)

				arg_185_1.text_.text = var_188_12

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 29
				local var_188_14 = utf8.len(var_188_12)
				local var_188_15 = var_188_13 <= 0 and var_188_10 or var_188_10 * (var_188_14 / var_188_13)

				if var_188_15 > 0 and var_188_10 < var_188_15 then
					arg_185_1.talkMaxDuration = var_188_15

					if var_188_15 + var_188_9 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_15 + var_188_9
					end
				end

				arg_185_1.text_.text = var_188_12
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_10, arg_185_1.talkMaxDuration)

			if var_188_9 <= arg_185_1.time_ and arg_185_1.time_ < var_188_9 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_9) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_9 + var_188_16 and arg_185_1.time_ < var_188_9 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play114202046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 114202046
		arg_189_1.duration_ = 17.2

		local var_189_0 = {
			ja = 4.133,
			ko = 11.333,
			zh = 11.166,
			en = 17.2
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
				arg_189_0:Play114202047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10017"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10017 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10017", 2)
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(-390, -350, -180)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10017, var_192_4, var_192_3)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_192_5 = arg_189_1.actors_["10017"]
			local var_192_6 = 0

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 and not isNil(var_192_5) then
				local var_192_7 = var_192_5:GetComponent("Image")

				if var_192_7 then
					arg_189_1.var_.highlightMatValue10017 = var_192_7
				end
			end

			local var_192_8 = 0.034

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_8 and not isNil(var_192_5) then
				local var_192_9 = (arg_189_1.time_ - var_192_6) / var_192_8

				if arg_189_1.var_.highlightMatValue10017 then
					local var_192_10 = Mathf.Lerp(0.5, 1, var_192_9)
					local var_192_11 = arg_189_1.var_.highlightMatValue10017
					local var_192_12 = var_192_11.color

					var_192_12.r = var_192_10
					var_192_12.g = var_192_10
					var_192_12.b = var_192_10
					var_192_11.color = var_192_12
				end
			end

			if arg_189_1.time_ >= var_192_6 + var_192_8 and arg_189_1.time_ < var_192_6 + var_192_8 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.highlightMatValue10017 then
				local var_192_13 = 1

				var_192_5.transform:SetSiblingIndex(1)

				local var_192_14 = arg_189_1.var_.highlightMatValue10017
				local var_192_15 = var_192_14.color

				var_192_15.r = var_192_13
				var_192_15.g = var_192_13
				var_192_15.b = var_192_13
				var_192_14.color = var_192_15
			end

			local var_192_16 = arg_189_1.actors_["10017"]
			local var_192_17 = 0

			if var_192_17 < arg_189_1.time_ and arg_189_1.time_ <= var_192_17 + arg_192_0 then
				local var_192_18 = var_192_16:GetComponent("Image")

				if var_192_18 then
					arg_189_1.var_.alphaMatValue10017 = var_192_18
					arg_189_1.var_.alphaOldValue10017 = var_192_18.color.a
				end

				arg_189_1.var_.alphaOldValue10017 = 0
			end

			local var_192_19 = 0.5

			if var_192_17 <= arg_189_1.time_ and arg_189_1.time_ < var_192_17 + var_192_19 then
				local var_192_20 = (arg_189_1.time_ - var_192_17) / var_192_19
				local var_192_21 = Mathf.Lerp(arg_189_1.var_.alphaOldValue10017, 1, var_192_20)

				if arg_189_1.var_.alphaMatValue10017 then
					local var_192_22 = arg_189_1.var_.alphaMatValue10017.color

					var_192_22.a = var_192_21
					arg_189_1.var_.alphaMatValue10017.color = var_192_22
				end
			end

			if arg_189_1.time_ >= var_192_17 + var_192_19 and arg_189_1.time_ < var_192_17 + var_192_19 + arg_192_0 and arg_189_1.var_.alphaMatValue10017 then
				local var_192_23 = arg_189_1.var_.alphaMatValue10017
				local var_192_24 = var_192_23.color

				var_192_24.a = 1
				var_192_23.color = var_192_24
			end

			local var_192_25 = 0
			local var_192_26 = 1.1

			if var_192_25 < arg_189_1.time_ and arg_189_1.time_ <= var_192_25 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_27 = arg_189_1:FormatText(StoryNameCfg[255].name)

				arg_189_1.leftNameTxt_.text = var_192_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_28 = arg_189_1:GetWordFromCfg(114202046)
				local var_192_29 = arg_189_1:FormatText(var_192_28.content)

				arg_189_1.text_.text = var_192_29

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_30 = 44
				local var_192_31 = utf8.len(var_192_29)
				local var_192_32 = var_192_30 <= 0 and var_192_26 or var_192_26 * (var_192_31 / var_192_30)

				if var_192_32 > 0 and var_192_26 < var_192_32 then
					arg_189_1.talkMaxDuration = var_192_32

					if var_192_32 + var_192_25 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_32 + var_192_25
					end
				end

				arg_189_1.text_.text = var_192_29
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202046", "story_v_out_114202.awb") ~= 0 then
					local var_192_33 = manager.audio:GetVoiceLength("story_v_out_114202", "114202046", "story_v_out_114202.awb") / 1000

					if var_192_33 + var_192_25 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_33 + var_192_25
					end

					if var_192_28.prefab_name ~= "" and arg_189_1.actors_[var_192_28.prefab_name] ~= nil then
						local var_192_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_28.prefab_name].transform, "story_v_out_114202", "114202046", "story_v_out_114202.awb")

						arg_189_1:RecordAudio("114202046", var_192_34)
						arg_189_1:RecordAudio("114202046", var_192_34)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_114202", "114202046", "story_v_out_114202.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_114202", "114202046", "story_v_out_114202.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_35 = math.max(var_192_26, arg_189_1.talkMaxDuration)

			if var_192_25 <= arg_189_1.time_ and arg_189_1.time_ < var_192_25 + var_192_35 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_25) / var_192_35

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_25 + var_192_35 and arg_189_1.time_ < var_192_25 + var_192_35 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play114202047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 114202047
		arg_193_1.duration_ = 4.1

		local var_193_0 = {
			ja = 2.733,
			ko = 3.733,
			zh = 4.1,
			en = 3.266
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
				arg_193_0:Play114202048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10015"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos10015 = var_196_0.localPosition
				var_196_0.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10015", 4)

				local var_196_2 = var_196_0.childCount

				for iter_196_0 = 0, var_196_2 - 1 do
					local var_196_3 = var_196_0:GetChild(iter_196_0)

					if var_196_3.name == "split_1" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_4 then
				local var_196_5 = (arg_193_1.time_ - var_196_1) / var_196_4
				local var_196_6 = Vector3.New(390, -350, -180)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10015, var_196_6, var_196_5)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_4 and arg_193_1.time_ < var_196_1 + var_196_4 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_196_7 = arg_193_1.actors_["10017"]
			local var_196_8 = 0

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 and not isNil(var_196_7) then
				local var_196_9 = var_196_7:GetComponent("Image")

				if var_196_9 then
					arg_193_1.var_.highlightMatValue10017 = var_196_9
				end
			end

			local var_196_10 = 0.034

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_10 and not isNil(var_196_7) then
				local var_196_11 = (arg_193_1.time_ - var_196_8) / var_196_10

				if arg_193_1.var_.highlightMatValue10017 then
					local var_196_12 = Mathf.Lerp(1, 0.5, var_196_11)
					local var_196_13 = arg_193_1.var_.highlightMatValue10017
					local var_196_14 = var_196_13.color

					var_196_14.r = var_196_12
					var_196_14.g = var_196_12
					var_196_14.b = var_196_12
					var_196_13.color = var_196_14
				end
			end

			if arg_193_1.time_ >= var_196_8 + var_196_10 and arg_193_1.time_ < var_196_8 + var_196_10 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.highlightMatValue10017 then
				local var_196_15 = 0.5
				local var_196_16 = arg_193_1.var_.highlightMatValue10017
				local var_196_17 = var_196_16.color

				var_196_17.r = var_196_15
				var_196_17.g = var_196_15
				var_196_17.b = var_196_15
				var_196_16.color = var_196_17
			end

			local var_196_18 = arg_193_1.actors_["10015"]
			local var_196_19 = 0

			if var_196_19 < arg_193_1.time_ and arg_193_1.time_ <= var_196_19 + arg_196_0 and not isNil(var_196_18) and arg_193_1.var_.actorSpriteComps10015 == nil then
				arg_193_1.var_.actorSpriteComps10015 = var_196_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_20 = 0.034

			if var_196_19 <= arg_193_1.time_ and arg_193_1.time_ < var_196_19 + var_196_20 and not isNil(var_196_18) then
				local var_196_21 = (arg_193_1.time_ - var_196_19) / var_196_20

				if arg_193_1.var_.actorSpriteComps10015 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								local var_196_22 = Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor1.r, var_196_21)
								local var_196_23 = Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor1.g, var_196_21)
								local var_196_24 = Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor1.b, var_196_21)

								iter_196_2.color = Color.New(var_196_22, var_196_23, var_196_24)
							else
								local var_196_25 = Mathf.Lerp(iter_196_2.color.r, 1, var_196_21)

								iter_196_2.color = Color.New(var_196_25, var_196_25, var_196_25)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_19 + var_196_20 and arg_193_1.time_ < var_196_19 + var_196_20 + arg_196_0 and not isNil(var_196_18) and arg_193_1.var_.actorSpriteComps10015 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_196_4 then
						if arg_193_1.isInRecall_ then
							iter_196_4.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10015 = nil
			end

			local var_196_26 = arg_193_1.actors_["10015"]
			local var_196_27 = 0

			if var_196_27 < arg_193_1.time_ and arg_193_1.time_ <= var_196_27 + arg_196_0 then
				local var_196_28 = var_196_26:GetComponentInChildren(typeof(CanvasGroup))

				if var_196_28 then
					arg_193_1.var_.alphaOldValue10015 = var_196_28.alpha
					arg_193_1.var_.characterEffect10015 = var_196_28
				end

				arg_193_1.var_.alphaOldValue10015 = 0
			end

			local var_196_29 = 0.5

			if var_196_27 <= arg_193_1.time_ and arg_193_1.time_ < var_196_27 + var_196_29 then
				local var_196_30 = (arg_193_1.time_ - var_196_27) / var_196_29
				local var_196_31 = Mathf.Lerp(arg_193_1.var_.alphaOldValue10015, 1, var_196_30)

				if arg_193_1.var_.characterEffect10015 then
					arg_193_1.var_.characterEffect10015.alpha = var_196_31
				end
			end

			if arg_193_1.time_ >= var_196_27 + var_196_29 and arg_193_1.time_ < var_196_27 + var_196_29 + arg_196_0 and arg_193_1.var_.characterEffect10015 then
				arg_193_1.var_.characterEffect10015.alpha = 1
			end

			local var_196_32 = 0
			local var_196_33 = 0.375

			if var_196_32 < arg_193_1.time_ and arg_193_1.time_ <= var_196_32 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_34 = arg_193_1:FormatText(StoryNameCfg[208].name)

				arg_193_1.leftNameTxt_.text = var_196_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_35 = arg_193_1:GetWordFromCfg(114202047)
				local var_196_36 = arg_193_1:FormatText(var_196_35.content)

				arg_193_1.text_.text = var_196_36

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_37 = 15
				local var_196_38 = utf8.len(var_196_36)
				local var_196_39 = var_196_37 <= 0 and var_196_33 or var_196_33 * (var_196_38 / var_196_37)

				if var_196_39 > 0 and var_196_33 < var_196_39 then
					arg_193_1.talkMaxDuration = var_196_39

					if var_196_39 + var_196_32 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_39 + var_196_32
					end
				end

				arg_193_1.text_.text = var_196_36
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202047", "story_v_out_114202.awb") ~= 0 then
					local var_196_40 = manager.audio:GetVoiceLength("story_v_out_114202", "114202047", "story_v_out_114202.awb") / 1000

					if var_196_40 + var_196_32 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_40 + var_196_32
					end

					if var_196_35.prefab_name ~= "" and arg_193_1.actors_[var_196_35.prefab_name] ~= nil then
						local var_196_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_35.prefab_name].transform, "story_v_out_114202", "114202047", "story_v_out_114202.awb")

						arg_193_1:RecordAudio("114202047", var_196_41)
						arg_193_1:RecordAudio("114202047", var_196_41)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_114202", "114202047", "story_v_out_114202.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_114202", "114202047", "story_v_out_114202.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_42 = math.max(var_196_33, arg_193_1.talkMaxDuration)

			if var_196_32 <= arg_193_1.time_ and arg_193_1.time_ < var_196_32 + var_196_42 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_32) / var_196_42

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_32 + var_196_42 and arg_193_1.time_ < var_196_32 + var_196_42 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play114202048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 114202048
		arg_197_1.duration_ = 7.57

		local var_197_0 = {
			ja = 4.933,
			ko = 5.9,
			zh = 5.733,
			en = 7.566
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
				arg_197_0:Play114202049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10017"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) then
				local var_200_2 = var_200_0:GetComponent("Image")

				if var_200_2 then
					arg_197_1.var_.highlightMatValue10017 = var_200_2
				end
			end

			local var_200_3 = 0.034

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_3 and not isNil(var_200_0) then
				local var_200_4 = (arg_197_1.time_ - var_200_1) / var_200_3

				if arg_197_1.var_.highlightMatValue10017 then
					local var_200_5 = Mathf.Lerp(0.5, 1, var_200_4)
					local var_200_6 = arg_197_1.var_.highlightMatValue10017
					local var_200_7 = var_200_6.color

					var_200_7.r = var_200_5
					var_200_7.g = var_200_5
					var_200_7.b = var_200_5
					var_200_6.color = var_200_7
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_3 and arg_197_1.time_ < var_200_1 + var_200_3 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.highlightMatValue10017 then
				local var_200_8 = 1

				var_200_0.transform:SetSiblingIndex(1)

				local var_200_9 = arg_197_1.var_.highlightMatValue10017
				local var_200_10 = var_200_9.color

				var_200_10.r = var_200_8
				var_200_10.g = var_200_8
				var_200_10.b = var_200_8
				var_200_9.color = var_200_10
			end

			local var_200_11 = arg_197_1.actors_["10015"]
			local var_200_12 = 0

			if var_200_12 < arg_197_1.time_ and arg_197_1.time_ <= var_200_12 + arg_200_0 and not isNil(var_200_11) and arg_197_1.var_.actorSpriteComps10015 == nil then
				arg_197_1.var_.actorSpriteComps10015 = var_200_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_13 = 0.034

			if var_200_12 <= arg_197_1.time_ and arg_197_1.time_ < var_200_12 + var_200_13 and not isNil(var_200_11) then
				local var_200_14 = (arg_197_1.time_ - var_200_12) / var_200_13

				if arg_197_1.var_.actorSpriteComps10015 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_200_1 then
							if arg_197_1.isInRecall_ then
								local var_200_15 = Mathf.Lerp(iter_200_1.color.r, arg_197_1.hightColor2.r, var_200_14)
								local var_200_16 = Mathf.Lerp(iter_200_1.color.g, arg_197_1.hightColor2.g, var_200_14)
								local var_200_17 = Mathf.Lerp(iter_200_1.color.b, arg_197_1.hightColor2.b, var_200_14)

								iter_200_1.color = Color.New(var_200_15, var_200_16, var_200_17)
							else
								local var_200_18 = Mathf.Lerp(iter_200_1.color.r, 0.5, var_200_14)

								iter_200_1.color = Color.New(var_200_18, var_200_18, var_200_18)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_12 + var_200_13 and arg_197_1.time_ < var_200_12 + var_200_13 + arg_200_0 and not isNil(var_200_11) and arg_197_1.var_.actorSpriteComps10015 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_200_3 then
						if arg_197_1.isInRecall_ then
							iter_200_3.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10015 = nil
			end

			local var_200_19 = 0
			local var_200_20 = 0.6

			if var_200_19 < arg_197_1.time_ and arg_197_1.time_ <= var_200_19 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_21 = arg_197_1:FormatText(StoryNameCfg[255].name)

				arg_197_1.leftNameTxt_.text = var_200_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_22 = arg_197_1:GetWordFromCfg(114202048)
				local var_200_23 = arg_197_1:FormatText(var_200_22.content)

				arg_197_1.text_.text = var_200_23

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_24 = 24
				local var_200_25 = utf8.len(var_200_23)
				local var_200_26 = var_200_24 <= 0 and var_200_20 or var_200_20 * (var_200_25 / var_200_24)

				if var_200_26 > 0 and var_200_20 < var_200_26 then
					arg_197_1.talkMaxDuration = var_200_26

					if var_200_26 + var_200_19 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_26 + var_200_19
					end
				end

				arg_197_1.text_.text = var_200_23
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202048", "story_v_out_114202.awb") ~= 0 then
					local var_200_27 = manager.audio:GetVoiceLength("story_v_out_114202", "114202048", "story_v_out_114202.awb") / 1000

					if var_200_27 + var_200_19 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_27 + var_200_19
					end

					if var_200_22.prefab_name ~= "" and arg_197_1.actors_[var_200_22.prefab_name] ~= nil then
						local var_200_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_22.prefab_name].transform, "story_v_out_114202", "114202048", "story_v_out_114202.awb")

						arg_197_1:RecordAudio("114202048", var_200_28)
						arg_197_1:RecordAudio("114202048", var_200_28)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_114202", "114202048", "story_v_out_114202.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_114202", "114202048", "story_v_out_114202.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_29 = math.max(var_200_20, arg_197_1.talkMaxDuration)

			if var_200_19 <= arg_197_1.time_ and arg_197_1.time_ < var_200_19 + var_200_29 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_19) / var_200_29

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_19 + var_200_29 and arg_197_1.time_ < var_200_19 + var_200_29 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play114202049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 114202049
		arg_201_1.duration_ = 15.6

		local var_201_0 = {
			ja = 15.6,
			ko = 9.533,
			zh = 8.866,
			en = 8.7
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
				arg_201_0:Play114202050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.95

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[255].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(114202049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 38
				local var_204_6 = utf8.len(var_204_4)
				local var_204_7 = var_204_5 <= 0 and var_204_1 or var_204_1 * (var_204_6 / var_204_5)

				if var_204_7 > 0 and var_204_1 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202049", "story_v_out_114202.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_114202", "114202049", "story_v_out_114202.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_114202", "114202049", "story_v_out_114202.awb")

						arg_201_1:RecordAudio("114202049", var_204_9)
						arg_201_1:RecordAudio("114202049", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_114202", "114202049", "story_v_out_114202.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_114202", "114202049", "story_v_out_114202.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_10 and arg_201_1.time_ < var_204_0 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play114202050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 114202050
		arg_205_1.duration_ = 2.33

		local var_205_0 = {
			ja = 2.333,
			ko = 2.266,
			zh = 1.4,
			en = 1.5
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
			arg_205_1.auto_ = false
		end

		function arg_205_1.playNext_(arg_207_0)
			arg_205_1.onStoryFinished_()
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10015"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos10015 = var_208_0.localPosition
				var_208_0.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10015", 7)

				local var_208_2 = var_208_0.childCount

				for iter_208_0 = 0, var_208_2 - 1 do
					local var_208_3 = var_208_0:GetChild(iter_208_0)

					if var_208_3.name == "split_1" or not string.find(var_208_3.name, "split") then
						var_208_3.gameObject:SetActive(true)
					else
						var_208_3.gameObject:SetActive(false)
					end
				end
			end

			local var_208_4 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_4 then
				local var_208_5 = (arg_205_1.time_ - var_208_1) / var_208_4
				local var_208_6 = Vector3.New(0, -2000, 300)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10015, var_208_6, var_208_5)
			end

			if arg_205_1.time_ >= var_208_1 + var_208_4 and arg_205_1.time_ < var_208_1 + var_208_4 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_208_7 = arg_205_1.actors_["10017"]
			local var_208_8 = 0

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 and not isNil(var_208_7) then
				local var_208_9 = var_208_7:GetComponent("Image")

				if var_208_9 then
					arg_205_1.var_.highlightMatValue10017 = var_208_9
				end
			end

			local var_208_10 = 0.034

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_10 and not isNil(var_208_7) then
				local var_208_11 = (arg_205_1.time_ - var_208_8) / var_208_10

				if arg_205_1.var_.highlightMatValue10017 then
					local var_208_12 = Mathf.Lerp(1, 0.5, var_208_11)
					local var_208_13 = arg_205_1.var_.highlightMatValue10017
					local var_208_14 = var_208_13.color

					var_208_14.r = var_208_12
					var_208_14.g = var_208_12
					var_208_14.b = var_208_12
					var_208_13.color = var_208_14
				end
			end

			if arg_205_1.time_ >= var_208_8 + var_208_10 and arg_205_1.time_ < var_208_8 + var_208_10 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.highlightMatValue10017 then
				local var_208_15 = 0.5
				local var_208_16 = arg_205_1.var_.highlightMatValue10017
				local var_208_17 = var_208_16.color

				var_208_17.r = var_208_15
				var_208_17.g = var_208_15
				var_208_17.b = var_208_15
				var_208_16.color = var_208_17
			end

			local var_208_18 = arg_205_1.actors_["10015"]
			local var_208_19 = 0

			if var_208_19 < arg_205_1.time_ and arg_205_1.time_ <= var_208_19 + arg_208_0 and not isNil(var_208_18) and arg_205_1.var_.actorSpriteComps10015 == nil then
				arg_205_1.var_.actorSpriteComps10015 = var_208_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_20 = 0.034

			if var_208_19 <= arg_205_1.time_ and arg_205_1.time_ < var_208_19 + var_208_20 and not isNil(var_208_18) then
				local var_208_21 = (arg_205_1.time_ - var_208_19) / var_208_20

				if arg_205_1.var_.actorSpriteComps10015 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								local var_208_22 = Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor1.r, var_208_21)
								local var_208_23 = Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor1.g, var_208_21)
								local var_208_24 = Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor1.b, var_208_21)

								iter_208_2.color = Color.New(var_208_22, var_208_23, var_208_24)
							else
								local var_208_25 = Mathf.Lerp(iter_208_2.color.r, 1, var_208_21)

								iter_208_2.color = Color.New(var_208_25, var_208_25, var_208_25)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_19 + var_208_20 and arg_205_1.time_ < var_208_19 + var_208_20 + arg_208_0 and not isNil(var_208_18) and arg_205_1.var_.actorSpriteComps10015 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_208_4 then
						if arg_205_1.isInRecall_ then
							iter_208_4.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10015 = nil
			end

			local var_208_26 = arg_205_1.actors_["10015"].transform
			local var_208_27 = 0

			if var_208_27 < arg_205_1.time_ and arg_205_1.time_ <= var_208_27 + arg_208_0 then
				arg_205_1.var_.moveOldPos10015 = var_208_26.localPosition
				var_208_26.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10015", 4)

				local var_208_28 = var_208_26.childCount

				for iter_208_5 = 0, var_208_28 - 1 do
					local var_208_29 = var_208_26:GetChild(iter_208_5)

					if var_208_29.name == "split_5" or not string.find(var_208_29.name, "split") then
						var_208_29.gameObject:SetActive(true)
					else
						var_208_29.gameObject:SetActive(false)
					end
				end
			end

			local var_208_30 = 0.001

			if var_208_27 <= arg_205_1.time_ and arg_205_1.time_ < var_208_27 + var_208_30 then
				local var_208_31 = (arg_205_1.time_ - var_208_27) / var_208_30
				local var_208_32 = Vector3.New(390, -350, -180)

				var_208_26.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10015, var_208_32, var_208_31)
			end

			if arg_205_1.time_ >= var_208_27 + var_208_30 and arg_205_1.time_ < var_208_27 + var_208_30 + arg_208_0 then
				var_208_26.localPosition = Vector3.New(390, -350, -180)
			end

			local var_208_33 = 0
			local var_208_34 = 0.125

			if var_208_33 < arg_205_1.time_ and arg_205_1.time_ <= var_208_33 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_35 = arg_205_1:FormatText(StoryNameCfg[208].name)

				arg_205_1.leftNameTxt_.text = var_208_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_36 = arg_205_1:GetWordFromCfg(114202050)
				local var_208_37 = arg_205_1:FormatText(var_208_36.content)

				arg_205_1.text_.text = var_208_37

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_38 = 5
				local var_208_39 = utf8.len(var_208_37)
				local var_208_40 = var_208_38 <= 0 and var_208_34 or var_208_34 * (var_208_39 / var_208_38)

				if var_208_40 > 0 and var_208_34 < var_208_40 then
					arg_205_1.talkMaxDuration = var_208_40

					if var_208_40 + var_208_33 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_40 + var_208_33
					end
				end

				arg_205_1.text_.text = var_208_37
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202050", "story_v_out_114202.awb") ~= 0 then
					local var_208_41 = manager.audio:GetVoiceLength("story_v_out_114202", "114202050", "story_v_out_114202.awb") / 1000

					if var_208_41 + var_208_33 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_41 + var_208_33
					end

					if var_208_36.prefab_name ~= "" and arg_205_1.actors_[var_208_36.prefab_name] ~= nil then
						local var_208_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_36.prefab_name].transform, "story_v_out_114202", "114202050", "story_v_out_114202.awb")

						arg_205_1:RecordAudio("114202050", var_208_42)
						arg_205_1:RecordAudio("114202050", var_208_42)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_114202", "114202050", "story_v_out_114202.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_114202", "114202050", "story_v_out_114202.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_43 = math.max(var_208_34, arg_205_1.talkMaxDuration)

			if var_208_33 <= arg_205_1.time_ and arg_205_1.time_ < var_208_33 + var_208_43 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_33) / var_208_43

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_33 + var_208_43 and arg_205_1.time_ < var_208_33 + var_208_43 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F04",
		"TextureConfig/Background/ST21"
	},
	voices = {
		"story_v_out_114202.awb"
	}
}
