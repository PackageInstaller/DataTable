return {
	Play113071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113071001
		arg_1_1.duration_ = 6.57

		local var_1_0 = {
			ja = 5.233,
			ko = 5,
			zh = 6.566,
			en = 5.866
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
				arg_1_0:Play113071002(arg_1_1)
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

			local var_4_6 = 0
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "music"

				arg_1_1:AudioAction(var_4_8, var_4_9, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = ""
				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_11 ~= "" then
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

			local var_4_12 = 2
			local var_4_13 = 0.5

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				local var_4_14 = "play"
				local var_4_15 = "music"

				arg_1_1:AudioAction(var_4_14, var_4_15, "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_4_16 = ""
				local var_4_17 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if var_4_17 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_17 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_17

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_17
						arg_1_1.bgmTxt2_.text = var_4_17
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

			local var_4_18 = 2
			local var_4_19 = 0.275

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_20 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_20:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_21 = arg_1_1:FormatText(StoryNameCfg[36].name)

				arg_1_1.leftNameTxt_.text = var_4_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_22 = arg_1_1:GetWordFromCfg(113071001)
				local var_4_23 = arg_1_1:FormatText(var_4_22.content)

				arg_1_1.text_.text = var_4_23

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 11
				local var_4_25 = utf8.len(var_4_23)
				local var_4_26 = var_4_24 <= 0 and var_4_19 or var_4_19 * (var_4_25 / var_4_24)

				if var_4_26 > 0 and var_4_19 < var_4_26 then
					arg_1_1.talkMaxDuration = var_4_26
					var_4_18 = var_4_18 + 0.3

					if var_4_26 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_23
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071001", "story_v_out_113071.awb") ~= 0 then
					local var_4_27 = manager.audio:GetVoiceLength("story_v_out_113071", "113071001", "story_v_out_113071.awb") / 1000

					if var_4_27 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_18
					end

					if var_4_22.prefab_name ~= "" and arg_1_1.actors_[var_4_22.prefab_name] ~= nil then
						local var_4_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_22.prefab_name].transform, "story_v_out_113071", "113071001", "story_v_out_113071.awb")

						arg_1_1:RecordAudio("113071001", var_4_28)
						arg_1_1:RecordAudio("113071001", var_4_28)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113071", "113071001", "story_v_out_113071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113071", "113071001", "story_v_out_113071.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_29 = var_4_18 + 0.3
			local var_4_30 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_29) / var_4_30

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play113071002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 113071002
		arg_9_1.duration_ = 5.9

		local var_9_0 = {
			ja = 5.9,
			ko = 4,
			zh = 4.266,
			en = 5.866
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
				arg_9_0:Play113071003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.45

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[36].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(113071002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071002", "story_v_out_113071.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_113071", "113071002", "story_v_out_113071.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_113071", "113071002", "story_v_out_113071.awb")

						arg_9_1:RecordAudio("113071002", var_12_9)
						arg_9_1:RecordAudio("113071002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_113071", "113071002", "story_v_out_113071.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_113071", "113071002", "story_v_out_113071.awb")
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
	Play113071003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 113071003
		arg_13_1.duration_ = 6.3

		local var_13_0 = {
			ja = 6.3,
			ko = 3.366,
			zh = 4.7,
			en = 3.566
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
				arg_13_0:Play113071004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.575

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[36].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:GetWordFromCfg(113071003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 23
				local var_16_6 = utf8.len(var_16_4)
				local var_16_7 = var_16_5 <= 0 and var_16_1 or var_16_1 * (var_16_6 / var_16_5)

				if var_16_7 > 0 and var_16_1 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071003", "story_v_out_113071.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_113071", "113071003", "story_v_out_113071.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_113071", "113071003", "story_v_out_113071.awb")

						arg_13_1:RecordAudio("113071003", var_16_9)
						arg_13_1:RecordAudio("113071003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_113071", "113071003", "story_v_out_113071.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_113071", "113071003", "story_v_out_113071.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_10 and arg_13_1.time_ < var_16_0 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play113071004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 113071004
		arg_17_1.duration_ = 10.73

		local var_17_0 = {
			ja = 10.733,
			ko = 4.766,
			zh = 5.6,
			en = 7.1
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
				arg_17_0:Play113071005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.625

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[36].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(113071004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071004", "story_v_out_113071.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_113071", "113071004", "story_v_out_113071.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_113071", "113071004", "story_v_out_113071.awb")

						arg_17_1:RecordAudio("113071004", var_20_9)
						arg_17_1:RecordAudio("113071004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_113071", "113071004", "story_v_out_113071.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_113071", "113071004", "story_v_out_113071.awb")
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
	Play113071005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 113071005
		arg_21_1.duration_ = 7.63

		local var_21_0 = {
			ja = 4.9,
			ko = 7.633,
			zh = 5.6,
			en = 5.2
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
				arg_21_0:Play113071006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "F01"

			if arg_21_1.bgs_[var_24_0] == nil then
				local var_24_1 = Object.Instantiate(arg_21_1.paintGo_)

				var_24_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_24_0)
				var_24_1.name = var_24_0
				var_24_1.transform.parent = arg_21_1.stage_.transform
				var_24_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.bgs_[var_24_0] = var_24_1
			end

			local var_24_2 = 2

			if var_24_2 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				local var_24_3 = manager.ui.mainCamera.transform.localPosition
				local var_24_4 = Vector3.New(0, 0, 10) + Vector3.New(var_24_3.x, var_24_3.y, 0)
				local var_24_5 = arg_21_1.bgs_.F01

				var_24_5.transform.localPosition = var_24_4
				var_24_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_6 = var_24_5:GetComponent("SpriteRenderer")

				if var_24_6 and var_24_6.sprite then
					local var_24_7 = (var_24_5.transform.localPosition - var_24_3).z
					local var_24_8 = manager.ui.mainCameraCom_
					local var_24_9 = 2 * var_24_7 * Mathf.Tan(var_24_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_24_10 = var_24_9 * var_24_8.aspect
					local var_24_11 = var_24_6.sprite.bounds.size.x
					local var_24_12 = var_24_6.sprite.bounds.size.y
					local var_24_13 = var_24_10 / var_24_11
					local var_24_14 = var_24_9 / var_24_12
					local var_24_15 = var_24_14 < var_24_13 and var_24_13 or var_24_14

					var_24_5.transform.localScale = Vector3.New(var_24_15, var_24_15, 0)
				end

				for iter_24_0, iter_24_1 in pairs(arg_21_1.bgs_) do
					if iter_24_0 ~= "F01" then
						iter_24_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_17 = 2

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_17 then
				local var_24_18 = (arg_21_1.time_ - var_24_16) / var_24_17
				local var_24_19 = Color.New(0, 0, 0)

				var_24_19.a = Mathf.Lerp(0, 1, var_24_18)
				arg_21_1.mask_.color = var_24_19
			end

			if arg_21_1.time_ >= var_24_16 + var_24_17 and arg_21_1.time_ < var_24_16 + var_24_17 + arg_24_0 then
				local var_24_20 = Color.New(0, 0, 0)

				var_24_20.a = 1
				arg_21_1.mask_.color = var_24_20
			end

			local var_24_21 = 2

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_22 = 2

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_22 then
				local var_24_23 = (arg_21_1.time_ - var_24_21) / var_24_22
				local var_24_24 = Color.New(0, 0, 0)

				var_24_24.a = Mathf.Lerp(1, 0, var_24_23)
				arg_21_1.mask_.color = var_24_24
			end

			if arg_21_1.time_ >= var_24_21 + var_24_22 and arg_21_1.time_ < var_24_21 + var_24_22 + arg_24_0 then
				local var_24_25 = Color.New(0, 0, 0)
				local var_24_26 = 0

				arg_21_1.mask_.enabled = false
				var_24_25.a = var_24_26
				arg_21_1.mask_.color = var_24_25
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_27 = 4
			local var_24_28 = 0.1

			if var_24_27 < arg_21_1.time_ and arg_21_1.time_ <= var_24_27 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_29 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_29:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_30 = arg_21_1:FormatText(StoryNameCfg[208].name)

				arg_21_1.leftNameTxt_.text = var_24_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_31 = arg_21_1:GetWordFromCfg(113071005)
				local var_24_32 = arg_21_1:FormatText(var_24_31.content)

				arg_21_1.text_.text = var_24_32

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_33 = 4
				local var_24_34 = utf8.len(var_24_32)
				local var_24_35 = var_24_33 <= 0 and var_24_28 or var_24_28 * (var_24_34 / var_24_33)

				if var_24_35 > 0 and var_24_28 < var_24_35 then
					arg_21_1.talkMaxDuration = var_24_35
					var_24_27 = var_24_27 + 0.3

					if var_24_35 + var_24_27 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_35 + var_24_27
					end
				end

				arg_21_1.text_.text = var_24_32
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071005", "story_v_out_113071.awb") ~= 0 then
					local var_24_36 = manager.audio:GetVoiceLength("story_v_out_113071", "113071005", "story_v_out_113071.awb") / 1000

					if var_24_36 + var_24_27 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_36 + var_24_27
					end

					if var_24_31.prefab_name ~= "" and arg_21_1.actors_[var_24_31.prefab_name] ~= nil then
						local var_24_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_31.prefab_name].transform, "story_v_out_113071", "113071005", "story_v_out_113071.awb")

						arg_21_1:RecordAudio("113071005", var_24_37)
						arg_21_1:RecordAudio("113071005", var_24_37)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_113071", "113071005", "story_v_out_113071.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_113071", "113071005", "story_v_out_113071.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_38 = var_24_27 + 0.3
			local var_24_39 = math.max(var_24_28, arg_21_1.talkMaxDuration)

			if var_24_38 <= arg_21_1.time_ and arg_21_1.time_ < var_24_38 + var_24_39 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_38) / var_24_39

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_38 + var_24_39 and arg_21_1.time_ < var_24_38 + var_24_39 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play113071006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 113071006
		arg_27_1.duration_ = 3.47

		local var_27_0 = {
			ja = 2.733,
			ko = 3.466,
			zh = 2.933,
			en = 3.3
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
				arg_27_0:Play113071007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = "1038ui_story"

			if arg_27_1.actors_[var_30_0] == nil then
				local var_30_1 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_30_1) then
					local var_30_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_27_1.stage_.transform)

					var_30_2.name = var_30_0
					var_30_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_27_1.actors_[var_30_0] = var_30_2

					local var_30_3 = var_30_2:GetComponentInChildren(typeof(CharacterEffect))

					var_30_3.enabled = true

					local var_30_4 = GameObjectTools.GetOrAddComponent(var_30_2, typeof(DynamicBoneHelper))

					if var_30_4 then
						var_30_4:EnableDynamicBone(false)
					end

					arg_27_1:ShowWeapon(var_30_3.transform, false)

					arg_27_1.var_[var_30_0 .. "Animator"] = var_30_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_27_1.var_[var_30_0 .. "Animator"].applyRootMotion = true
					arg_27_1.var_[var_30_0 .. "LipSync"] = var_30_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_30_5 = arg_27_1.actors_["1038ui_story"].transform
			local var_30_6 = 0

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.var_.moveOldPos1038ui_story = var_30_5.localPosition
			end

			local var_30_7 = 0.001

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_7 then
				local var_30_8 = (arg_27_1.time_ - var_30_6) / var_30_7
				local var_30_9 = Vector3.New(-0.7, -1.11, -5.9)

				var_30_5.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1038ui_story, var_30_9, var_30_8)

				local var_30_10 = manager.ui.mainCamera.transform.position - var_30_5.position

				var_30_5.forward = Vector3.New(var_30_10.x, var_30_10.y, var_30_10.z)

				local var_30_11 = var_30_5.localEulerAngles

				var_30_11.z = 0
				var_30_11.x = 0
				var_30_5.localEulerAngles = var_30_11
			end

			if arg_27_1.time_ >= var_30_6 + var_30_7 and arg_27_1.time_ < var_30_6 + var_30_7 + arg_30_0 then
				var_30_5.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_30_12 = manager.ui.mainCamera.transform.position - var_30_5.position

				var_30_5.forward = Vector3.New(var_30_12.x, var_30_12.y, var_30_12.z)

				local var_30_13 = var_30_5.localEulerAngles

				var_30_13.z = 0
				var_30_13.x = 0
				var_30_5.localEulerAngles = var_30_13
			end

			local var_30_14 = 0

			if var_30_14 < arg_27_1.time_ and arg_27_1.time_ <= var_30_14 + arg_30_0 then
				arg_27_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_30_15 = 0

			if var_30_15 < arg_27_1.time_ and arg_27_1.time_ <= var_30_15 + arg_30_0 then
				arg_27_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_30_16 = arg_27_1.actors_["1038ui_story"]
			local var_30_17 = 0

			if var_30_17 < arg_27_1.time_ and arg_27_1.time_ <= var_30_17 + arg_30_0 and not isNil(var_30_16) and arg_27_1.var_.characterEffect1038ui_story == nil then
				arg_27_1.var_.characterEffect1038ui_story = var_30_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_18 = 0.2

			if var_30_17 <= arg_27_1.time_ and arg_27_1.time_ < var_30_17 + var_30_18 and not isNil(var_30_16) then
				local var_30_19 = (arg_27_1.time_ - var_30_17) / var_30_18

				if arg_27_1.var_.characterEffect1038ui_story and not isNil(var_30_16) then
					arg_27_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_17 + var_30_18 and arg_27_1.time_ < var_30_17 + var_30_18 + arg_30_0 and not isNil(var_30_16) and arg_27_1.var_.characterEffect1038ui_story then
				arg_27_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_30_20 = 0
			local var_30_21 = 0.25

			if var_30_20 < arg_27_1.time_ and arg_27_1.time_ <= var_30_20 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_22 = arg_27_1:FormatText(StoryNameCfg[94].name)

				arg_27_1.leftNameTxt_.text = var_30_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_23 = arg_27_1:GetWordFromCfg(113071006)
				local var_30_24 = arg_27_1:FormatText(var_30_23.content)

				arg_27_1.text_.text = var_30_24

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_25 = 10
				local var_30_26 = utf8.len(var_30_24)
				local var_30_27 = var_30_25 <= 0 and var_30_21 or var_30_21 * (var_30_26 / var_30_25)

				if var_30_27 > 0 and var_30_21 < var_30_27 then
					arg_27_1.talkMaxDuration = var_30_27

					if var_30_27 + var_30_20 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_27 + var_30_20
					end
				end

				arg_27_1.text_.text = var_30_24
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071006", "story_v_out_113071.awb") ~= 0 then
					local var_30_28 = manager.audio:GetVoiceLength("story_v_out_113071", "113071006", "story_v_out_113071.awb") / 1000

					if var_30_28 + var_30_20 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_28 + var_30_20
					end

					if var_30_23.prefab_name ~= "" and arg_27_1.actors_[var_30_23.prefab_name] ~= nil then
						local var_30_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_23.prefab_name].transform, "story_v_out_113071", "113071006", "story_v_out_113071.awb")

						arg_27_1:RecordAudio("113071006", var_30_29)
						arg_27_1:RecordAudio("113071006", var_30_29)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_113071", "113071006", "story_v_out_113071.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_113071", "113071006", "story_v_out_113071.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_30 = math.max(var_30_21, arg_27_1.talkMaxDuration)

			if var_30_20 <= arg_27_1.time_ and arg_27_1.time_ < var_30_20 + var_30_30 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_20) / var_30_30

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_20 + var_30_30 and arg_27_1.time_ < var_30_20 + var_30_30 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play113071007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 113071007
		arg_31_1.duration_ = 3.77

		local var_31_0 = {
			ja = 2.166,
			ko = 3.766,
			zh = 2.666,
			en = 3.033
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
				arg_31_0:Play113071008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1038ui_story"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect1038ui_story == nil then
				arg_31_1.var_.characterEffect1038ui_story = var_34_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.2

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 and not isNil(var_34_0) then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.characterEffect1038ui_story and not isNil(var_34_0) then
					local var_34_4 = Mathf.Lerp(0, 0.5, var_34_3)

					arg_31_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1038ui_story.fillRatio = var_34_4
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect1038ui_story then
				local var_34_5 = 0.5

				arg_31_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1038ui_story.fillRatio = var_34_5
			end

			local var_34_6 = "1041ui_story"

			if arg_31_1.actors_[var_34_6] == nil then
				local var_34_7 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_34_7) then
					local var_34_8 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_31_1.stage_.transform)

					var_34_8.name = var_34_6
					var_34_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_31_1.actors_[var_34_6] = var_34_8

					local var_34_9 = var_34_8:GetComponentInChildren(typeof(CharacterEffect))

					var_34_9.enabled = true

					local var_34_10 = GameObjectTools.GetOrAddComponent(var_34_8, typeof(DynamicBoneHelper))

					if var_34_10 then
						var_34_10:EnableDynamicBone(false)
					end

					arg_31_1:ShowWeapon(var_34_9.transform, false)

					arg_31_1.var_[var_34_6 .. "Animator"] = var_34_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_31_1.var_[var_34_6 .. "Animator"].applyRootMotion = true
					arg_31_1.var_[var_34_6 .. "LipSync"] = var_34_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_34_11 = arg_31_1.actors_["1041ui_story"].transform
			local var_34_12 = 0

			if var_34_12 < arg_31_1.time_ and arg_31_1.time_ <= var_34_12 + arg_34_0 then
				arg_31_1.var_.moveOldPos1041ui_story = var_34_11.localPosition
			end

			local var_34_13 = 0.001

			if var_34_12 <= arg_31_1.time_ and arg_31_1.time_ < var_34_12 + var_34_13 then
				local var_34_14 = (arg_31_1.time_ - var_34_12) / var_34_13
				local var_34_15 = Vector3.New(0.7, -1.11, -5.9)

				var_34_11.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1041ui_story, var_34_15, var_34_14)

				local var_34_16 = manager.ui.mainCamera.transform.position - var_34_11.position

				var_34_11.forward = Vector3.New(var_34_16.x, var_34_16.y, var_34_16.z)

				local var_34_17 = var_34_11.localEulerAngles

				var_34_17.z = 0
				var_34_17.x = 0
				var_34_11.localEulerAngles = var_34_17
			end

			if arg_31_1.time_ >= var_34_12 + var_34_13 and arg_31_1.time_ < var_34_12 + var_34_13 + arg_34_0 then
				var_34_11.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_34_18 = manager.ui.mainCamera.transform.position - var_34_11.position

				var_34_11.forward = Vector3.New(var_34_18.x, var_34_18.y, var_34_18.z)

				local var_34_19 = var_34_11.localEulerAngles

				var_34_19.z = 0
				var_34_19.x = 0
				var_34_11.localEulerAngles = var_34_19
			end

			local var_34_20 = 0

			if var_34_20 < arg_31_1.time_ and arg_31_1.time_ <= var_34_20 + arg_34_0 then
				arg_31_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_34_21 = 0

			if var_34_21 < arg_31_1.time_ and arg_31_1.time_ <= var_34_21 + arg_34_0 then
				arg_31_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_34_22 = arg_31_1.actors_["1041ui_story"]
			local var_34_23 = 0

			if var_34_23 < arg_31_1.time_ and arg_31_1.time_ <= var_34_23 + arg_34_0 and not isNil(var_34_22) and arg_31_1.var_.characterEffect1041ui_story == nil then
				arg_31_1.var_.characterEffect1041ui_story = var_34_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_24 = 0.2

			if var_34_23 <= arg_31_1.time_ and arg_31_1.time_ < var_34_23 + var_34_24 and not isNil(var_34_22) then
				local var_34_25 = (arg_31_1.time_ - var_34_23) / var_34_24

				if arg_31_1.var_.characterEffect1041ui_story and not isNil(var_34_22) then
					arg_31_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_23 + var_34_24 and arg_31_1.time_ < var_34_23 + var_34_24 + arg_34_0 and not isNil(var_34_22) and arg_31_1.var_.characterEffect1041ui_story then
				arg_31_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_34_26 = 0
			local var_34_27 = 0.25

			if var_34_26 < arg_31_1.time_ and arg_31_1.time_ <= var_34_26 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_28 = arg_31_1:FormatText(StoryNameCfg[208].name)

				arg_31_1.leftNameTxt_.text = var_34_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_29 = arg_31_1:GetWordFromCfg(113071007)
				local var_34_30 = arg_31_1:FormatText(var_34_29.content)

				arg_31_1.text_.text = var_34_30

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_31 = 10
				local var_34_32 = utf8.len(var_34_30)
				local var_34_33 = var_34_31 <= 0 and var_34_27 or var_34_27 * (var_34_32 / var_34_31)

				if var_34_33 > 0 and var_34_27 < var_34_33 then
					arg_31_1.talkMaxDuration = var_34_33

					if var_34_33 + var_34_26 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_33 + var_34_26
					end
				end

				arg_31_1.text_.text = var_34_30
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071007", "story_v_out_113071.awb") ~= 0 then
					local var_34_34 = manager.audio:GetVoiceLength("story_v_out_113071", "113071007", "story_v_out_113071.awb") / 1000

					if var_34_34 + var_34_26 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_34 + var_34_26
					end

					if var_34_29.prefab_name ~= "" and arg_31_1.actors_[var_34_29.prefab_name] ~= nil then
						local var_34_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_29.prefab_name].transform, "story_v_out_113071", "113071007", "story_v_out_113071.awb")

						arg_31_1:RecordAudio("113071007", var_34_35)
						arg_31_1:RecordAudio("113071007", var_34_35)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_113071", "113071007", "story_v_out_113071.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_113071", "113071007", "story_v_out_113071.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_36 = math.max(var_34_27, arg_31_1.talkMaxDuration)

			if var_34_26 <= arg_31_1.time_ and arg_31_1.time_ < var_34_26 + var_34_36 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_26) / var_34_36

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_26 + var_34_36 and arg_31_1.time_ < var_34_26 + var_34_36 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play113071008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 113071008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play113071009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1041ui_story"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1041ui_story == nil then
				arg_35_1.var_.characterEffect1041ui_story = var_38_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.2

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.characterEffect1041ui_story and not isNil(var_38_0) then
					local var_38_4 = Mathf.Lerp(0, 0.5, var_38_3)

					arg_35_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1041ui_story.fillRatio = var_38_4
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1041ui_story then
				local var_38_5 = 0.5

				arg_35_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1041ui_story.fillRatio = var_38_5
			end

			local var_38_6 = 0
			local var_38_7 = 1.4

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_8 = arg_35_1:GetWordFromCfg(113071008)
				local var_38_9 = arg_35_1:FormatText(var_38_8.content)

				arg_35_1.text_.text = var_38_9

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_10 = 56
				local var_38_11 = utf8.len(var_38_9)
				local var_38_12 = var_38_10 <= 0 and var_38_7 or var_38_7 * (var_38_11 / var_38_10)

				if var_38_12 > 0 and var_38_7 < var_38_12 then
					arg_35_1.talkMaxDuration = var_38_12

					if var_38_12 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_12 + var_38_6
					end
				end

				arg_35_1.text_.text = var_38_9
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_13 = math.max(var_38_7, arg_35_1.talkMaxDuration)

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_13 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_6) / var_38_13

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_6 + var_38_13 and arg_35_1.time_ < var_38_6 + var_38_13 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play113071009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 113071009
		arg_39_1.duration_ = 3.2

		local var_39_0 = {
			ja = 3.2,
			ko = 2.8,
			zh = 1.999999999999,
			en = 2.9
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
				arg_39_0:Play113071010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_42_1 = arg_39_1.actors_["1041ui_story"]
			local var_42_2 = 0

			if var_42_2 < arg_39_1.time_ and arg_39_1.time_ <= var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1041ui_story == nil then
				arg_39_1.var_.characterEffect1041ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_3 = 0.2

			if var_42_2 <= arg_39_1.time_ and arg_39_1.time_ < var_42_2 + var_42_3 and not isNil(var_42_1) then
				local var_42_4 = (arg_39_1.time_ - var_42_2) / var_42_3

				if arg_39_1.var_.characterEffect1041ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_2 + var_42_3 and arg_39_1.time_ < var_42_2 + var_42_3 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1041ui_story then
				arg_39_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_42_5 = 0
			local var_42_6 = 0.225

			if var_42_5 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_7 = arg_39_1:FormatText(StoryNameCfg[208].name)

				arg_39_1.leftNameTxt_.text = var_42_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_8 = arg_39_1:GetWordFromCfg(113071009)
				local var_42_9 = arg_39_1:FormatText(var_42_8.content)

				arg_39_1.text_.text = var_42_9

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_10 = 9
				local var_42_11 = utf8.len(var_42_9)
				local var_42_12 = var_42_10 <= 0 and var_42_6 or var_42_6 * (var_42_11 / var_42_10)

				if var_42_12 > 0 and var_42_6 < var_42_12 then
					arg_39_1.talkMaxDuration = var_42_12

					if var_42_12 + var_42_5 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_12 + var_42_5
					end
				end

				arg_39_1.text_.text = var_42_9
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071009", "story_v_out_113071.awb") ~= 0 then
					local var_42_13 = manager.audio:GetVoiceLength("story_v_out_113071", "113071009", "story_v_out_113071.awb") / 1000

					if var_42_13 + var_42_5 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_5
					end

					if var_42_8.prefab_name ~= "" and arg_39_1.actors_[var_42_8.prefab_name] ~= nil then
						local var_42_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_8.prefab_name].transform, "story_v_out_113071", "113071009", "story_v_out_113071.awb")

						arg_39_1:RecordAudio("113071009", var_42_14)
						arg_39_1:RecordAudio("113071009", var_42_14)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_113071", "113071009", "story_v_out_113071.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_113071", "113071009", "story_v_out_113071.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_15 = math.max(var_42_6, arg_39_1.talkMaxDuration)

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_15 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_5) / var_42_15

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_5 + var_42_15 and arg_39_1.time_ < var_42_5 + var_42_15 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play113071010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 113071010
		arg_43_1.duration_ = 5.9

		local var_43_0 = {
			ja = 5.9,
			ko = 5.366,
			zh = 3.666,
			en = 3.166
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
				arg_43_0:Play113071011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1041ui_story"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1041ui_story == nil then
				arg_43_1.var_.characterEffect1041ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.2

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.characterEffect1041ui_story and not isNil(var_46_0) then
					local var_46_4 = Mathf.Lerp(0, 0.5, var_46_3)

					arg_43_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1041ui_story.fillRatio = var_46_4
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1041ui_story then
				local var_46_5 = 0.5

				arg_43_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1041ui_story.fillRatio = var_46_5
			end

			local var_46_6 = 0

			if var_46_6 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				arg_43_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_46_7 = 0

			if var_46_7 < arg_43_1.time_ and arg_43_1.time_ <= var_46_7 + arg_46_0 then
				arg_43_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_46_8 = arg_43_1.actors_["1038ui_story"]
			local var_46_9 = 0

			if var_46_9 < arg_43_1.time_ and arg_43_1.time_ <= var_46_9 + arg_46_0 and not isNil(var_46_8) and arg_43_1.var_.characterEffect1038ui_story == nil then
				arg_43_1.var_.characterEffect1038ui_story = var_46_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_10 = 0.2

			if var_46_9 <= arg_43_1.time_ and arg_43_1.time_ < var_46_9 + var_46_10 and not isNil(var_46_8) then
				local var_46_11 = (arg_43_1.time_ - var_46_9) / var_46_10

				if arg_43_1.var_.characterEffect1038ui_story and not isNil(var_46_8) then
					arg_43_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_9 + var_46_10 and arg_43_1.time_ < var_46_9 + var_46_10 + arg_46_0 and not isNil(var_46_8) and arg_43_1.var_.characterEffect1038ui_story then
				arg_43_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_46_12 = 0
			local var_46_13 = 0.35

			if var_46_12 < arg_43_1.time_ and arg_43_1.time_ <= var_46_12 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_14 = arg_43_1:FormatText(StoryNameCfg[94].name)

				arg_43_1.leftNameTxt_.text = var_46_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_15 = arg_43_1:GetWordFromCfg(113071010)
				local var_46_16 = arg_43_1:FormatText(var_46_15.content)

				arg_43_1.text_.text = var_46_16

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_17 = 14
				local var_46_18 = utf8.len(var_46_16)
				local var_46_19 = var_46_17 <= 0 and var_46_13 or var_46_13 * (var_46_18 / var_46_17)

				if var_46_19 > 0 and var_46_13 < var_46_19 then
					arg_43_1.talkMaxDuration = var_46_19

					if var_46_19 + var_46_12 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_19 + var_46_12
					end
				end

				arg_43_1.text_.text = var_46_16
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071010", "story_v_out_113071.awb") ~= 0 then
					local var_46_20 = manager.audio:GetVoiceLength("story_v_out_113071", "113071010", "story_v_out_113071.awb") / 1000

					if var_46_20 + var_46_12 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_20 + var_46_12
					end

					if var_46_15.prefab_name ~= "" and arg_43_1.actors_[var_46_15.prefab_name] ~= nil then
						local var_46_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_15.prefab_name].transform, "story_v_out_113071", "113071010", "story_v_out_113071.awb")

						arg_43_1:RecordAudio("113071010", var_46_21)
						arg_43_1:RecordAudio("113071010", var_46_21)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_113071", "113071010", "story_v_out_113071.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_113071", "113071010", "story_v_out_113071.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_22 = math.max(var_46_13, arg_43_1.talkMaxDuration)

			if var_46_12 <= arg_43_1.time_ and arg_43_1.time_ < var_46_12 + var_46_22 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_12) / var_46_22

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_12 + var_46_22 and arg_43_1.time_ < var_46_12 + var_46_22 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play113071011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 113071011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play113071012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1038ui_story"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos1038ui_story = var_50_0.localPosition
			end

			local var_50_2 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2
				local var_50_4 = Vector3.New(0, 100, 0)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1038ui_story, var_50_4, var_50_3)

				local var_50_5 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_5.x, var_50_5.y, var_50_5.z)

				local var_50_6 = var_50_0.localEulerAngles

				var_50_6.z = 0
				var_50_6.x = 0
				var_50_0.localEulerAngles = var_50_6
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0, 100, 0)

				local var_50_7 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_7.x, var_50_7.y, var_50_7.z)

				local var_50_8 = var_50_0.localEulerAngles

				var_50_8.z = 0
				var_50_8.x = 0
				var_50_0.localEulerAngles = var_50_8
			end

			local var_50_9 = arg_47_1.actors_["1041ui_story"].transform
			local var_50_10 = 0

			if var_50_10 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 then
				arg_47_1.var_.moveOldPos1041ui_story = var_50_9.localPosition
			end

			local var_50_11 = 0.001

			if var_50_10 <= arg_47_1.time_ and arg_47_1.time_ < var_50_10 + var_50_11 then
				local var_50_12 = (arg_47_1.time_ - var_50_10) / var_50_11
				local var_50_13 = Vector3.New(0, 100, 0)

				var_50_9.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1041ui_story, var_50_13, var_50_12)

				local var_50_14 = manager.ui.mainCamera.transform.position - var_50_9.position

				var_50_9.forward = Vector3.New(var_50_14.x, var_50_14.y, var_50_14.z)

				local var_50_15 = var_50_9.localEulerAngles

				var_50_15.z = 0
				var_50_15.x = 0
				var_50_9.localEulerAngles = var_50_15
			end

			if arg_47_1.time_ >= var_50_10 + var_50_11 and arg_47_1.time_ < var_50_10 + var_50_11 + arg_50_0 then
				var_50_9.localPosition = Vector3.New(0, 100, 0)

				local var_50_16 = manager.ui.mainCamera.transform.position - var_50_9.position

				var_50_9.forward = Vector3.New(var_50_16.x, var_50_16.y, var_50_16.z)

				local var_50_17 = var_50_9.localEulerAngles

				var_50_17.z = 0
				var_50_17.x = 0
				var_50_9.localEulerAngles = var_50_17
			end

			local var_50_18 = 0
			local var_50_19 = 0.75

			if var_50_18 < arg_47_1.time_ and arg_47_1.time_ <= var_50_18 + arg_50_0 then
				local var_50_20 = "play"
				local var_50_21 = "effect"

				arg_47_1:AudioAction(var_50_20, var_50_21, "se_story_10", "se_story_10_boiling_loop", "")
			end

			local var_50_22 = 0
			local var_50_23 = 0.75

			if var_50_22 < arg_47_1.time_ and arg_47_1.time_ <= var_50_22 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_24 = arg_47_1:GetWordFromCfg(113071011)
				local var_50_25 = arg_47_1:FormatText(var_50_24.content)

				arg_47_1.text_.text = var_50_25

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_26 = 30
				local var_50_27 = utf8.len(var_50_25)
				local var_50_28 = var_50_26 <= 0 and var_50_23 or var_50_23 * (var_50_27 / var_50_26)

				if var_50_28 > 0 and var_50_23 < var_50_28 then
					arg_47_1.talkMaxDuration = var_50_28

					if var_50_28 + var_50_22 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_28 + var_50_22
					end
				end

				arg_47_1.text_.text = var_50_25
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_29 = math.max(var_50_23, arg_47_1.talkMaxDuration)

			if var_50_22 <= arg_47_1.time_ and arg_47_1.time_ < var_50_22 + var_50_29 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_22) / var_50_29

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_22 + var_50_29 and arg_47_1.time_ < var_50_22 + var_50_29 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play113071012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 113071012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play113071013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.75

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_2 = arg_51_1:GetWordFromCfg(113071012)
				local var_54_3 = arg_51_1:FormatText(var_54_2.content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 30
				local var_54_5 = utf8.len(var_54_3)
				local var_54_6 = var_54_4 <= 0 and var_54_1 or var_54_1 * (var_54_5 / var_54_4)

				if var_54_6 > 0 and var_54_1 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_7 and arg_51_1.time_ < var_54_0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play113071013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 113071013
		arg_55_1.duration_ = 7.63

		local var_55_0 = {
			ja = 7.633,
			ko = 2.533,
			zh = 3.033,
			en = 2.433
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
				arg_55_0:Play113071014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1038ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1038ui_story = var_58_0.localPosition
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(-0.7, -1.11, -5.9)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1038ui_story, var_58_4, var_58_3)

				local var_58_5 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_5.x, var_58_5.y, var_58_5.z)

				local var_58_6 = var_58_0.localEulerAngles

				var_58_6.z = 0
				var_58_6.x = 0
				var_58_0.localEulerAngles = var_58_6
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_58_7 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_7.x, var_58_7.y, var_58_7.z)

				local var_58_8 = var_58_0.localEulerAngles

				var_58_8.z = 0
				var_58_8.x = 0
				var_58_0.localEulerAngles = var_58_8
			end

			local var_58_9 = 0

			if var_58_9 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 then
				arg_55_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_58_10 = 0

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 then
				arg_55_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_58_11 = arg_55_1.actors_["1038ui_story"]
			local var_58_12 = 0

			if var_58_12 < arg_55_1.time_ and arg_55_1.time_ <= var_58_12 + arg_58_0 and not isNil(var_58_11) and arg_55_1.var_.characterEffect1038ui_story == nil then
				arg_55_1.var_.characterEffect1038ui_story = var_58_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_13 = 0.2

			if var_58_12 <= arg_55_1.time_ and arg_55_1.time_ < var_58_12 + var_58_13 and not isNil(var_58_11) then
				local var_58_14 = (arg_55_1.time_ - var_58_12) / var_58_13

				if arg_55_1.var_.characterEffect1038ui_story and not isNil(var_58_11) then
					arg_55_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_12 + var_58_13 and arg_55_1.time_ < var_58_12 + var_58_13 + arg_58_0 and not isNil(var_58_11) and arg_55_1.var_.characterEffect1038ui_story then
				arg_55_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_58_15 = 0
			local var_58_16 = 0.4

			if var_58_15 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_17 = arg_55_1:FormatText(StoryNameCfg[94].name)

				arg_55_1.leftNameTxt_.text = var_58_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_18 = arg_55_1:GetWordFromCfg(113071013)
				local var_58_19 = arg_55_1:FormatText(var_58_18.content)

				arg_55_1.text_.text = var_58_19

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_20 = 16
				local var_58_21 = utf8.len(var_58_19)
				local var_58_22 = var_58_20 <= 0 and var_58_16 or var_58_16 * (var_58_21 / var_58_20)

				if var_58_22 > 0 and var_58_16 < var_58_22 then
					arg_55_1.talkMaxDuration = var_58_22

					if var_58_22 + var_58_15 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_22 + var_58_15
					end
				end

				arg_55_1.text_.text = var_58_19
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071013", "story_v_out_113071.awb") ~= 0 then
					local var_58_23 = manager.audio:GetVoiceLength("story_v_out_113071", "113071013", "story_v_out_113071.awb") / 1000

					if var_58_23 + var_58_15 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_23 + var_58_15
					end

					if var_58_18.prefab_name ~= "" and arg_55_1.actors_[var_58_18.prefab_name] ~= nil then
						local var_58_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_18.prefab_name].transform, "story_v_out_113071", "113071013", "story_v_out_113071.awb")

						arg_55_1:RecordAudio("113071013", var_58_24)
						arg_55_1:RecordAudio("113071013", var_58_24)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_113071", "113071013", "story_v_out_113071.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_113071", "113071013", "story_v_out_113071.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_25 = math.max(var_58_16, arg_55_1.talkMaxDuration)

			if var_58_15 <= arg_55_1.time_ and arg_55_1.time_ < var_58_15 + var_58_25 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_15) / var_58_25

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_15 + var_58_25 and arg_55_1.time_ < var_58_15 + var_58_25 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play113071014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 113071014
		arg_59_1.duration_ = 2.7

		local var_59_0 = {
			ja = 2.7,
			ko = 1.999999999999,
			zh = 2.3,
			en = 2.433
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
				arg_59_0:Play113071015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1038ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1038ui_story == nil then
				arg_59_1.var_.characterEffect1038ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.2

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect1038ui_story and not isNil(var_62_0) then
					local var_62_4 = Mathf.Lerp(0, 0.5, var_62_3)

					arg_59_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1038ui_story.fillRatio = var_62_4
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1038ui_story then
				local var_62_5 = 0.5

				arg_59_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1038ui_story.fillRatio = var_62_5
			end

			local var_62_6 = 0

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_62_7 = arg_59_1.actors_["1041ui_story"]
			local var_62_8 = 0

			if var_62_8 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 and not isNil(var_62_7) and arg_59_1.var_.characterEffect1041ui_story == nil then
				arg_59_1.var_.characterEffect1041ui_story = var_62_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_9 = 0.2

			if var_62_8 <= arg_59_1.time_ and arg_59_1.time_ < var_62_8 + var_62_9 and not isNil(var_62_7) then
				local var_62_10 = (arg_59_1.time_ - var_62_8) / var_62_9

				if arg_59_1.var_.characterEffect1041ui_story and not isNil(var_62_7) then
					arg_59_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_8 + var_62_9 and arg_59_1.time_ < var_62_8 + var_62_9 + arg_62_0 and not isNil(var_62_7) and arg_59_1.var_.characterEffect1041ui_story then
				arg_59_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_62_11 = arg_59_1.actors_["1041ui_story"].transform
			local var_62_12 = 0

			if var_62_12 < arg_59_1.time_ and arg_59_1.time_ <= var_62_12 + arg_62_0 then
				arg_59_1.var_.moveOldPos1041ui_story = var_62_11.localPosition
			end

			local var_62_13 = 0.001

			if var_62_12 <= arg_59_1.time_ and arg_59_1.time_ < var_62_12 + var_62_13 then
				local var_62_14 = (arg_59_1.time_ - var_62_12) / var_62_13
				local var_62_15 = Vector3.New(0.7, -1.11, -5.9)

				var_62_11.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1041ui_story, var_62_15, var_62_14)

				local var_62_16 = manager.ui.mainCamera.transform.position - var_62_11.position

				var_62_11.forward = Vector3.New(var_62_16.x, var_62_16.y, var_62_16.z)

				local var_62_17 = var_62_11.localEulerAngles

				var_62_17.z = 0
				var_62_17.x = 0
				var_62_11.localEulerAngles = var_62_17
			end

			if arg_59_1.time_ >= var_62_12 + var_62_13 and arg_59_1.time_ < var_62_12 + var_62_13 + arg_62_0 then
				var_62_11.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_62_18 = manager.ui.mainCamera.transform.position - var_62_11.position

				var_62_11.forward = Vector3.New(var_62_18.x, var_62_18.y, var_62_18.z)

				local var_62_19 = var_62_11.localEulerAngles

				var_62_19.z = 0
				var_62_19.x = 0
				var_62_11.localEulerAngles = var_62_19
			end

			local var_62_20 = 0
			local var_62_21 = 0.125

			if var_62_20 < arg_59_1.time_ and arg_59_1.time_ <= var_62_20 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_22 = arg_59_1:FormatText(StoryNameCfg[208].name)

				arg_59_1.leftNameTxt_.text = var_62_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_23 = arg_59_1:GetWordFromCfg(113071014)
				local var_62_24 = arg_59_1:FormatText(var_62_23.content)

				arg_59_1.text_.text = var_62_24

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_25 = 5
				local var_62_26 = utf8.len(var_62_24)
				local var_62_27 = var_62_25 <= 0 and var_62_21 or var_62_21 * (var_62_26 / var_62_25)

				if var_62_27 > 0 and var_62_21 < var_62_27 then
					arg_59_1.talkMaxDuration = var_62_27

					if var_62_27 + var_62_20 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_27 + var_62_20
					end
				end

				arg_59_1.text_.text = var_62_24
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071014", "story_v_out_113071.awb") ~= 0 then
					local var_62_28 = manager.audio:GetVoiceLength("story_v_out_113071", "113071014", "story_v_out_113071.awb") / 1000

					if var_62_28 + var_62_20 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_28 + var_62_20
					end

					if var_62_23.prefab_name ~= "" and arg_59_1.actors_[var_62_23.prefab_name] ~= nil then
						local var_62_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_23.prefab_name].transform, "story_v_out_113071", "113071014", "story_v_out_113071.awb")

						arg_59_1:RecordAudio("113071014", var_62_29)
						arg_59_1:RecordAudio("113071014", var_62_29)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_113071", "113071014", "story_v_out_113071.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_113071", "113071014", "story_v_out_113071.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_30 = math.max(var_62_21, arg_59_1.talkMaxDuration)

			if var_62_20 <= arg_59_1.time_ and arg_59_1.time_ < var_62_20 + var_62_30 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_20) / var_62_30

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_20 + var_62_30 and arg_59_1.time_ < var_62_20 + var_62_30 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play113071015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 113071015
		arg_63_1.duration_ = 6.4

		local var_63_0 = {
			ja = 6.366,
			ko = 5.6,
			zh = 4.766,
			en = 6.4
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
				arg_63_0:Play113071016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1038ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1038ui_story == nil then
				arg_63_1.var_.characterEffect1038ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.2

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect1038ui_story and not isNil(var_66_0) then
					arg_63_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1038ui_story then
				arg_63_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_66_4 = arg_63_1.actors_["1041ui_story"]
			local var_66_5 = 0

			if var_66_5 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1041ui_story == nil then
				arg_63_1.var_.characterEffect1041ui_story = var_66_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_6 = 0.2

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_6 and not isNil(var_66_4) then
				local var_66_7 = (arg_63_1.time_ - var_66_5) / var_66_6

				if arg_63_1.var_.characterEffect1041ui_story and not isNil(var_66_4) then
					local var_66_8 = Mathf.Lerp(0, 0.5, var_66_7)

					arg_63_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1041ui_story.fillRatio = var_66_8
				end
			end

			if arg_63_1.time_ >= var_66_5 + var_66_6 and arg_63_1.time_ < var_66_5 + var_66_6 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1041ui_story then
				local var_66_9 = 0.5

				arg_63_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1041ui_story.fillRatio = var_66_9
			end

			local var_66_10 = 0

			if var_66_10 < arg_63_1.time_ and arg_63_1.time_ <= var_66_10 + arg_66_0 then
				arg_63_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_66_11 = 0

			if var_66_11 < arg_63_1.time_ and arg_63_1.time_ <= var_66_11 + arg_66_0 then
				arg_63_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_66_12 = 0
			local var_66_13 = 0.6

			if var_66_12 < arg_63_1.time_ and arg_63_1.time_ <= var_66_12 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_14 = arg_63_1:FormatText(StoryNameCfg[94].name)

				arg_63_1.leftNameTxt_.text = var_66_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_15 = arg_63_1:GetWordFromCfg(113071015)
				local var_66_16 = arg_63_1:FormatText(var_66_15.content)

				arg_63_1.text_.text = var_66_16

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_17 = 24
				local var_66_18 = utf8.len(var_66_16)
				local var_66_19 = var_66_17 <= 0 and var_66_13 or var_66_13 * (var_66_18 / var_66_17)

				if var_66_19 > 0 and var_66_13 < var_66_19 then
					arg_63_1.talkMaxDuration = var_66_19

					if var_66_19 + var_66_12 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_19 + var_66_12
					end
				end

				arg_63_1.text_.text = var_66_16
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071015", "story_v_out_113071.awb") ~= 0 then
					local var_66_20 = manager.audio:GetVoiceLength("story_v_out_113071", "113071015", "story_v_out_113071.awb") / 1000

					if var_66_20 + var_66_12 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_20 + var_66_12
					end

					if var_66_15.prefab_name ~= "" and arg_63_1.actors_[var_66_15.prefab_name] ~= nil then
						local var_66_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_15.prefab_name].transform, "story_v_out_113071", "113071015", "story_v_out_113071.awb")

						arg_63_1:RecordAudio("113071015", var_66_21)
						arg_63_1:RecordAudio("113071015", var_66_21)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_113071", "113071015", "story_v_out_113071.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_113071", "113071015", "story_v_out_113071.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_22 = math.max(var_66_13, arg_63_1.talkMaxDuration)

			if var_66_12 <= arg_63_1.time_ and arg_63_1.time_ < var_66_12 + var_66_22 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_12) / var_66_22

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_12 + var_66_22 and arg_63_1.time_ < var_66_12 + var_66_22 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play113071016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 113071016
		arg_67_1.duration_ = 7.63

		local var_67_0 = {
			ja = 6.9,
			ko = 6.066,
			zh = 5.2,
			en = 7.633
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
				arg_67_0:Play113071017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1038ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1038ui_story == nil then
				arg_67_1.var_.characterEffect1038ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.2

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect1038ui_story and not isNil(var_70_0) then
					local var_70_4 = Mathf.Lerp(0, 0.5, var_70_3)

					arg_67_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1038ui_story.fillRatio = var_70_4
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1038ui_story then
				local var_70_5 = 0.5

				arg_67_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1038ui_story.fillRatio = var_70_5
			end

			local var_70_6 = arg_67_1.actors_["1041ui_story"]
			local var_70_7 = 0

			if var_70_7 < arg_67_1.time_ and arg_67_1.time_ <= var_70_7 + arg_70_0 and not isNil(var_70_6) and arg_67_1.var_.characterEffect1041ui_story == nil then
				arg_67_1.var_.characterEffect1041ui_story = var_70_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_8 = 0.2

			if var_70_7 <= arg_67_1.time_ and arg_67_1.time_ < var_70_7 + var_70_8 and not isNil(var_70_6) then
				local var_70_9 = (arg_67_1.time_ - var_70_7) / var_70_8

				if arg_67_1.var_.characterEffect1041ui_story and not isNil(var_70_6) then
					arg_67_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_7 + var_70_8 and arg_67_1.time_ < var_70_7 + var_70_8 + arg_70_0 and not isNil(var_70_6) and arg_67_1.var_.characterEffect1041ui_story then
				arg_67_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 then
				arg_67_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_1")
			end

			local var_70_11 = 0

			if var_70_11 < arg_67_1.time_ and arg_67_1.time_ <= var_70_11 + arg_70_0 then
				arg_67_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_70_12 = 0
			local var_70_13 = 0.625

			if var_70_12 < arg_67_1.time_ and arg_67_1.time_ <= var_70_12 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_14 = arg_67_1:FormatText(StoryNameCfg[208].name)

				arg_67_1.leftNameTxt_.text = var_70_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_15 = arg_67_1:GetWordFromCfg(113071016)
				local var_70_16 = arg_67_1:FormatText(var_70_15.content)

				arg_67_1.text_.text = var_70_16

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_17 = 25
				local var_70_18 = utf8.len(var_70_16)
				local var_70_19 = var_70_17 <= 0 and var_70_13 or var_70_13 * (var_70_18 / var_70_17)

				if var_70_19 > 0 and var_70_13 < var_70_19 then
					arg_67_1.talkMaxDuration = var_70_19

					if var_70_19 + var_70_12 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_19 + var_70_12
					end
				end

				arg_67_1.text_.text = var_70_16
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071016", "story_v_out_113071.awb") ~= 0 then
					local var_70_20 = manager.audio:GetVoiceLength("story_v_out_113071", "113071016", "story_v_out_113071.awb") / 1000

					if var_70_20 + var_70_12 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_20 + var_70_12
					end

					if var_70_15.prefab_name ~= "" and arg_67_1.actors_[var_70_15.prefab_name] ~= nil then
						local var_70_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_15.prefab_name].transform, "story_v_out_113071", "113071016", "story_v_out_113071.awb")

						arg_67_1:RecordAudio("113071016", var_70_21)
						arg_67_1:RecordAudio("113071016", var_70_21)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_113071", "113071016", "story_v_out_113071.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_113071", "113071016", "story_v_out_113071.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_22 = math.max(var_70_13, arg_67_1.talkMaxDuration)

			if var_70_12 <= arg_67_1.time_ and arg_67_1.time_ < var_70_12 + var_70_22 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_12) / var_70_22

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_12 + var_70_22 and arg_67_1.time_ < var_70_12 + var_70_22 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play113071017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 113071017
		arg_71_1.duration_ = 6.17

		local var_71_0 = {
			ja = 6.166,
			ko = 4.566,
			zh = 3.666,
			en = 2.866
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
				arg_71_0:Play113071018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1041ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1041ui_story == nil then
				arg_71_1.var_.characterEffect1041ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.2

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect1041ui_story and not isNil(var_74_0) then
					local var_74_4 = Mathf.Lerp(0, 0.5, var_74_3)

					arg_71_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1041ui_story.fillRatio = var_74_4
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1041ui_story then
				local var_74_5 = 0.5

				arg_71_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1041ui_story.fillRatio = var_74_5
			end

			local var_74_6 = arg_71_1.actors_["1038ui_story"]
			local var_74_7 = 0

			if var_74_7 < arg_71_1.time_ and arg_71_1.time_ <= var_74_7 + arg_74_0 and not isNil(var_74_6) and arg_71_1.var_.characterEffect1038ui_story == nil then
				arg_71_1.var_.characterEffect1038ui_story = var_74_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_8 = 0.2

			if var_74_7 <= arg_71_1.time_ and arg_71_1.time_ < var_74_7 + var_74_8 and not isNil(var_74_6) then
				local var_74_9 = (arg_71_1.time_ - var_74_7) / var_74_8

				if arg_71_1.var_.characterEffect1038ui_story and not isNil(var_74_6) then
					arg_71_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_7 + var_74_8 and arg_71_1.time_ < var_74_7 + var_74_8 + arg_74_0 and not isNil(var_74_6) and arg_71_1.var_.characterEffect1038ui_story then
				arg_71_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_74_11 = 0
			local var_74_12 = 0.45

			if var_74_11 < arg_71_1.time_ and arg_71_1.time_ <= var_74_11 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_13 = arg_71_1:FormatText(StoryNameCfg[94].name)

				arg_71_1.leftNameTxt_.text = var_74_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_14 = arg_71_1:GetWordFromCfg(113071017)
				local var_74_15 = arg_71_1:FormatText(var_74_14.content)

				arg_71_1.text_.text = var_74_15

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_16 = 18
				local var_74_17 = utf8.len(var_74_15)
				local var_74_18 = var_74_16 <= 0 and var_74_12 or var_74_12 * (var_74_17 / var_74_16)

				if var_74_18 > 0 and var_74_12 < var_74_18 then
					arg_71_1.talkMaxDuration = var_74_18

					if var_74_18 + var_74_11 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_18 + var_74_11
					end
				end

				arg_71_1.text_.text = var_74_15
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071017", "story_v_out_113071.awb") ~= 0 then
					local var_74_19 = manager.audio:GetVoiceLength("story_v_out_113071", "113071017", "story_v_out_113071.awb") / 1000

					if var_74_19 + var_74_11 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_19 + var_74_11
					end

					if var_74_14.prefab_name ~= "" and arg_71_1.actors_[var_74_14.prefab_name] ~= nil then
						local var_74_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_14.prefab_name].transform, "story_v_out_113071", "113071017", "story_v_out_113071.awb")

						arg_71_1:RecordAudio("113071017", var_74_20)
						arg_71_1:RecordAudio("113071017", var_74_20)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_113071", "113071017", "story_v_out_113071.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_113071", "113071017", "story_v_out_113071.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_21 = math.max(var_74_12, arg_71_1.talkMaxDuration)

			if var_74_11 <= arg_71_1.time_ and arg_71_1.time_ < var_74_11 + var_74_21 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_11) / var_74_21

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_11 + var_74_21 and arg_71_1.time_ < var_74_11 + var_74_21 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play113071018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 113071018
		arg_75_1.duration_ = 7.7

		local var_75_0 = {
			ja = 6.866,
			ko = 5.5,
			zh = 5.166,
			en = 7.7
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
				arg_75_0:Play113071019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1041ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1041ui_story == nil then
				arg_75_1.var_.characterEffect1041ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.2

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1041ui_story and not isNil(var_78_0) then
					arg_75_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1041ui_story then
				arg_75_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_78_4 = arg_75_1.actors_["1038ui_story"]
			local var_78_5 = 0

			if var_78_5 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 and not isNil(var_78_4) and arg_75_1.var_.characterEffect1038ui_story == nil then
				arg_75_1.var_.characterEffect1038ui_story = var_78_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_6 = 0.2

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_6 and not isNil(var_78_4) then
				local var_78_7 = (arg_75_1.time_ - var_78_5) / var_78_6

				if arg_75_1.var_.characterEffect1038ui_story and not isNil(var_78_4) then
					local var_78_8 = Mathf.Lerp(0, 0.5, var_78_7)

					arg_75_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1038ui_story.fillRatio = var_78_8
				end
			end

			if arg_75_1.time_ >= var_78_5 + var_78_6 and arg_75_1.time_ < var_78_5 + var_78_6 + arg_78_0 and not isNil(var_78_4) and arg_75_1.var_.characterEffect1038ui_story then
				local var_78_9 = 0.5

				arg_75_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1038ui_story.fillRatio = var_78_9
			end

			local var_78_10 = 0

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 then
				arg_75_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_2")
			end

			local var_78_11 = 0

			if var_78_11 < arg_75_1.time_ and arg_75_1.time_ <= var_78_11 + arg_78_0 then
				arg_75_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_78_12 = 0
			local var_78_13 = 0.7

			if var_78_12 < arg_75_1.time_ and arg_75_1.time_ <= var_78_12 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_14 = arg_75_1:FormatText(StoryNameCfg[208].name)

				arg_75_1.leftNameTxt_.text = var_78_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_15 = arg_75_1:GetWordFromCfg(113071018)
				local var_78_16 = arg_75_1:FormatText(var_78_15.content)

				arg_75_1.text_.text = var_78_16

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_17 = 28
				local var_78_18 = utf8.len(var_78_16)
				local var_78_19 = var_78_17 <= 0 and var_78_13 or var_78_13 * (var_78_18 / var_78_17)

				if var_78_19 > 0 and var_78_13 < var_78_19 then
					arg_75_1.talkMaxDuration = var_78_19

					if var_78_19 + var_78_12 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_19 + var_78_12
					end
				end

				arg_75_1.text_.text = var_78_16
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071018", "story_v_out_113071.awb") ~= 0 then
					local var_78_20 = manager.audio:GetVoiceLength("story_v_out_113071", "113071018", "story_v_out_113071.awb") / 1000

					if var_78_20 + var_78_12 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_20 + var_78_12
					end

					if var_78_15.prefab_name ~= "" and arg_75_1.actors_[var_78_15.prefab_name] ~= nil then
						local var_78_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_15.prefab_name].transform, "story_v_out_113071", "113071018", "story_v_out_113071.awb")

						arg_75_1:RecordAudio("113071018", var_78_21)
						arg_75_1:RecordAudio("113071018", var_78_21)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_113071", "113071018", "story_v_out_113071.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_113071", "113071018", "story_v_out_113071.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_22 = math.max(var_78_13, arg_75_1.talkMaxDuration)

			if var_78_12 <= arg_75_1.time_ and arg_75_1.time_ < var_78_12 + var_78_22 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_12) / var_78_22

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_12 + var_78_22 and arg_75_1.time_ < var_78_12 + var_78_22 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play113071019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 113071019
		arg_79_1.duration_ = 8.63

		local var_79_0 = {
			ja = 8.633,
			ko = 5.6,
			zh = 5.3,
			en = 5.7
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
				arg_79_0:Play113071020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1041ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1041ui_story == nil then
				arg_79_1.var_.characterEffect1041ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect1041ui_story and not isNil(var_82_0) then
					local var_82_4 = Mathf.Lerp(0, 0.5, var_82_3)

					arg_79_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1041ui_story.fillRatio = var_82_4
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1041ui_story then
				local var_82_5 = 0.5

				arg_79_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1041ui_story.fillRatio = var_82_5
			end

			local var_82_6 = arg_79_1.actors_["1038ui_story"]
			local var_82_7 = 0

			if var_82_7 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect1038ui_story == nil then
				arg_79_1.var_.characterEffect1038ui_story = var_82_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_8 = 0.2

			if var_82_7 <= arg_79_1.time_ and arg_79_1.time_ < var_82_7 + var_82_8 and not isNil(var_82_6) then
				local var_82_9 = (arg_79_1.time_ - var_82_7) / var_82_8

				if arg_79_1.var_.characterEffect1038ui_story and not isNil(var_82_6) then
					arg_79_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_7 + var_82_8 and arg_79_1.time_ < var_82_7 + var_82_8 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect1038ui_story then
				arg_79_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 then
				arg_79_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_82_11 = 0
			local var_82_12 = 0.575

			if var_82_11 < arg_79_1.time_ and arg_79_1.time_ <= var_82_11 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_13 = arg_79_1:FormatText(StoryNameCfg[94].name)

				arg_79_1.leftNameTxt_.text = var_82_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_14 = arg_79_1:GetWordFromCfg(113071019)
				local var_82_15 = arg_79_1:FormatText(var_82_14.content)

				arg_79_1.text_.text = var_82_15

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_16 = 23
				local var_82_17 = utf8.len(var_82_15)
				local var_82_18 = var_82_16 <= 0 and var_82_12 or var_82_12 * (var_82_17 / var_82_16)

				if var_82_18 > 0 and var_82_12 < var_82_18 then
					arg_79_1.talkMaxDuration = var_82_18

					if var_82_18 + var_82_11 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_18 + var_82_11
					end
				end

				arg_79_1.text_.text = var_82_15
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071019", "story_v_out_113071.awb") ~= 0 then
					local var_82_19 = manager.audio:GetVoiceLength("story_v_out_113071", "113071019", "story_v_out_113071.awb") / 1000

					if var_82_19 + var_82_11 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_19 + var_82_11
					end

					if var_82_14.prefab_name ~= "" and arg_79_1.actors_[var_82_14.prefab_name] ~= nil then
						local var_82_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_14.prefab_name].transform, "story_v_out_113071", "113071019", "story_v_out_113071.awb")

						arg_79_1:RecordAudio("113071019", var_82_20)
						arg_79_1:RecordAudio("113071019", var_82_20)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_113071", "113071019", "story_v_out_113071.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_113071", "113071019", "story_v_out_113071.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_21 = math.max(var_82_12, arg_79_1.talkMaxDuration)

			if var_82_11 <= arg_79_1.time_ and arg_79_1.time_ < var_82_11 + var_82_21 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_11) / var_82_21

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_11 + var_82_21 and arg_79_1.time_ < var_82_11 + var_82_21 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play113071020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 113071020
		arg_83_1.duration_ = 7.57

		local var_83_0 = {
			ja = 7.566,
			ko = 4.7,
			zh = 5.3,
			en = 6.933
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
				arg_83_0:Play113071021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1038ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1038ui_story == nil then
				arg_83_1.var_.characterEffect1038ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect1038ui_story and not isNil(var_86_0) then
					local var_86_4 = Mathf.Lerp(0, 0.5, var_86_3)

					arg_83_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1038ui_story.fillRatio = var_86_4
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1038ui_story then
				local var_86_5 = 0.5

				arg_83_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1038ui_story.fillRatio = var_86_5
			end

			local var_86_6 = 0

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action6_1")
			end

			local var_86_7 = 0

			if var_86_7 < arg_83_1.time_ and arg_83_1.time_ <= var_86_7 + arg_86_0 then
				arg_83_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_86_8 = arg_83_1.actors_["1041ui_story"]
			local var_86_9 = 0

			if var_86_9 < arg_83_1.time_ and arg_83_1.time_ <= var_86_9 + arg_86_0 and not isNil(var_86_8) and arg_83_1.var_.characterEffect1041ui_story == nil then
				arg_83_1.var_.characterEffect1041ui_story = var_86_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_10 = 0.2

			if var_86_9 <= arg_83_1.time_ and arg_83_1.time_ < var_86_9 + var_86_10 and not isNil(var_86_8) then
				local var_86_11 = (arg_83_1.time_ - var_86_9) / var_86_10

				if arg_83_1.var_.characterEffect1041ui_story and not isNil(var_86_8) then
					arg_83_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_9 + var_86_10 and arg_83_1.time_ < var_86_9 + var_86_10 + arg_86_0 and not isNil(var_86_8) and arg_83_1.var_.characterEffect1041ui_story then
				arg_83_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_86_12 = 0
			local var_86_13 = 0.65

			if var_86_12 < arg_83_1.time_ and arg_83_1.time_ <= var_86_12 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_14 = arg_83_1:FormatText(StoryNameCfg[208].name)

				arg_83_1.leftNameTxt_.text = var_86_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_15 = arg_83_1:GetWordFromCfg(113071020)
				local var_86_16 = arg_83_1:FormatText(var_86_15.content)

				arg_83_1.text_.text = var_86_16

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_17 = 26
				local var_86_18 = utf8.len(var_86_16)
				local var_86_19 = var_86_17 <= 0 and var_86_13 or var_86_13 * (var_86_18 / var_86_17)

				if var_86_19 > 0 and var_86_13 < var_86_19 then
					arg_83_1.talkMaxDuration = var_86_19

					if var_86_19 + var_86_12 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_19 + var_86_12
					end
				end

				arg_83_1.text_.text = var_86_16
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071020", "story_v_out_113071.awb") ~= 0 then
					local var_86_20 = manager.audio:GetVoiceLength("story_v_out_113071", "113071020", "story_v_out_113071.awb") / 1000

					if var_86_20 + var_86_12 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_20 + var_86_12
					end

					if var_86_15.prefab_name ~= "" and arg_83_1.actors_[var_86_15.prefab_name] ~= nil then
						local var_86_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_15.prefab_name].transform, "story_v_out_113071", "113071020", "story_v_out_113071.awb")

						arg_83_1:RecordAudio("113071020", var_86_21)
						arg_83_1:RecordAudio("113071020", var_86_21)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_113071", "113071020", "story_v_out_113071.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_113071", "113071020", "story_v_out_113071.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_22 = math.max(var_86_13, arg_83_1.talkMaxDuration)

			if var_86_12 <= arg_83_1.time_ and arg_83_1.time_ < var_86_12 + var_86_22 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_12) / var_86_22

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_12 + var_86_22 and arg_83_1.time_ < var_86_12 + var_86_22 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play113071021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 113071021
		arg_87_1.duration_ = 9.37

		local var_87_0 = {
			ja = 9.366,
			ko = 8.366,
			zh = 7.7,
			en = 8.033
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
				arg_87_0:Play113071022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1041ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1041ui_story == nil then
				arg_87_1.var_.characterEffect1041ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.2

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect1041ui_story and not isNil(var_90_0) then
					local var_90_4 = Mathf.Lerp(0, 0.5, var_90_3)

					arg_87_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1041ui_story.fillRatio = var_90_4
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1041ui_story then
				local var_90_5 = 0.5

				arg_87_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1041ui_story.fillRatio = var_90_5
			end

			local var_90_6 = arg_87_1.actors_["1038ui_story"]
			local var_90_7 = 0

			if var_90_7 < arg_87_1.time_ and arg_87_1.time_ <= var_90_7 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect1038ui_story == nil then
				arg_87_1.var_.characterEffect1038ui_story = var_90_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_8 = 0.2

			if var_90_7 <= arg_87_1.time_ and arg_87_1.time_ < var_90_7 + var_90_8 and not isNil(var_90_6) then
				local var_90_9 = (arg_87_1.time_ - var_90_7) / var_90_8

				if arg_87_1.var_.characterEffect1038ui_story and not isNil(var_90_6) then
					arg_87_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_7 + var_90_8 and arg_87_1.time_ < var_90_7 + var_90_8 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect1038ui_story then
				arg_87_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 then
				arg_87_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_90_11 = 0
			local var_90_12 = 0.775

			if var_90_11 < arg_87_1.time_ and arg_87_1.time_ <= var_90_11 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_13 = arg_87_1:FormatText(StoryNameCfg[94].name)

				arg_87_1.leftNameTxt_.text = var_90_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_14 = arg_87_1:GetWordFromCfg(113071021)
				local var_90_15 = arg_87_1:FormatText(var_90_14.content)

				arg_87_1.text_.text = var_90_15

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_16 = 31
				local var_90_17 = utf8.len(var_90_15)
				local var_90_18 = var_90_16 <= 0 and var_90_12 or var_90_12 * (var_90_17 / var_90_16)

				if var_90_18 > 0 and var_90_12 < var_90_18 then
					arg_87_1.talkMaxDuration = var_90_18

					if var_90_18 + var_90_11 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_18 + var_90_11
					end
				end

				arg_87_1.text_.text = var_90_15
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071021", "story_v_out_113071.awb") ~= 0 then
					local var_90_19 = manager.audio:GetVoiceLength("story_v_out_113071", "113071021", "story_v_out_113071.awb") / 1000

					if var_90_19 + var_90_11 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_19 + var_90_11
					end

					if var_90_14.prefab_name ~= "" and arg_87_1.actors_[var_90_14.prefab_name] ~= nil then
						local var_90_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_14.prefab_name].transform, "story_v_out_113071", "113071021", "story_v_out_113071.awb")

						arg_87_1:RecordAudio("113071021", var_90_20)
						arg_87_1:RecordAudio("113071021", var_90_20)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_113071", "113071021", "story_v_out_113071.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_113071", "113071021", "story_v_out_113071.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_21 = math.max(var_90_12, arg_87_1.talkMaxDuration)

			if var_90_11 <= arg_87_1.time_ and arg_87_1.time_ < var_90_11 + var_90_21 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_11) / var_90_21

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_11 + var_90_21 and arg_87_1.time_ < var_90_11 + var_90_21 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play113071022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 113071022
		arg_91_1.duration_ = 2

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play113071023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1038ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1038ui_story == nil then
				arg_91_1.var_.characterEffect1038ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.2

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect1038ui_story and not isNil(var_94_0) then
					local var_94_4 = Mathf.Lerp(0, 0.5, var_94_3)

					arg_91_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1038ui_story.fillRatio = var_94_4
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1038ui_story then
				local var_94_5 = 0.5

				arg_91_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1038ui_story.fillRatio = var_94_5
			end

			local var_94_6 = arg_91_1.actors_["1041ui_story"]
			local var_94_7 = 0

			if var_94_7 < arg_91_1.time_ and arg_91_1.time_ <= var_94_7 + arg_94_0 and not isNil(var_94_6) and arg_91_1.var_.characterEffect1041ui_story == nil then
				arg_91_1.var_.characterEffect1041ui_story = var_94_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_8 = 0.2

			if var_94_7 <= arg_91_1.time_ and arg_91_1.time_ < var_94_7 + var_94_8 and not isNil(var_94_6) then
				local var_94_9 = (arg_91_1.time_ - var_94_7) / var_94_8

				if arg_91_1.var_.characterEffect1041ui_story and not isNil(var_94_6) then
					arg_91_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_7 + var_94_8 and arg_91_1.time_ < var_94_7 + var_94_8 + arg_94_0 and not isNil(var_94_6) and arg_91_1.var_.characterEffect1041ui_story then
				arg_91_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 then
				arg_91_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_94_11 = 0

			if var_94_11 < arg_91_1.time_ and arg_91_1.time_ <= var_94_11 + arg_94_0 then
				arg_91_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action6_2")
			end

			local var_94_12 = 0
			local var_94_13 = 0.05

			if var_94_12 < arg_91_1.time_ and arg_91_1.time_ <= var_94_12 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_14 = arg_91_1:FormatText(StoryNameCfg[208].name)

				arg_91_1.leftNameTxt_.text = var_94_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_15 = arg_91_1:GetWordFromCfg(113071022)
				local var_94_16 = arg_91_1:FormatText(var_94_15.content)

				arg_91_1.text_.text = var_94_16

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_17 = 2
				local var_94_18 = utf8.len(var_94_16)
				local var_94_19 = var_94_17 <= 0 and var_94_13 or var_94_13 * (var_94_18 / var_94_17)

				if var_94_19 > 0 and var_94_13 < var_94_19 then
					arg_91_1.talkMaxDuration = var_94_19

					if var_94_19 + var_94_12 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_19 + var_94_12
					end
				end

				arg_91_1.text_.text = var_94_16
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071022", "story_v_out_113071.awb") ~= 0 then
					local var_94_20 = manager.audio:GetVoiceLength("story_v_out_113071", "113071022", "story_v_out_113071.awb") / 1000

					if var_94_20 + var_94_12 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_20 + var_94_12
					end

					if var_94_15.prefab_name ~= "" and arg_91_1.actors_[var_94_15.prefab_name] ~= nil then
						local var_94_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_15.prefab_name].transform, "story_v_out_113071", "113071022", "story_v_out_113071.awb")

						arg_91_1:RecordAudio("113071022", var_94_21)
						arg_91_1:RecordAudio("113071022", var_94_21)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_113071", "113071022", "story_v_out_113071.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_113071", "113071022", "story_v_out_113071.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_22 = math.max(var_94_13, arg_91_1.talkMaxDuration)

			if var_94_12 <= arg_91_1.time_ and arg_91_1.time_ < var_94_12 + var_94_22 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_12) / var_94_22

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_12 + var_94_22 and arg_91_1.time_ < var_94_12 + var_94_22 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play113071023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 113071023
		arg_95_1.duration_ = 7.8

		local var_95_0 = {
			ja = 7.8,
			ko = 6.633,
			zh = 6.066,
			en = 5.966
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
				arg_95_0:Play113071024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1041ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1041ui_story == nil then
				arg_95_1.var_.characterEffect1041ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.2

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1041ui_story and not isNil(var_98_0) then
					local var_98_4 = Mathf.Lerp(0, 0.5, var_98_3)

					arg_95_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1041ui_story.fillRatio = var_98_4
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1041ui_story then
				local var_98_5 = 0.5

				arg_95_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1041ui_story.fillRatio = var_98_5
			end

			local var_98_6 = arg_95_1.actors_["1038ui_story"]
			local var_98_7 = 0

			if var_98_7 < arg_95_1.time_ and arg_95_1.time_ <= var_98_7 + arg_98_0 and not isNil(var_98_6) and arg_95_1.var_.characterEffect1038ui_story == nil then
				arg_95_1.var_.characterEffect1038ui_story = var_98_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_8 = 0.2

			if var_98_7 <= arg_95_1.time_ and arg_95_1.time_ < var_98_7 + var_98_8 and not isNil(var_98_6) then
				local var_98_9 = (arg_95_1.time_ - var_98_7) / var_98_8

				if arg_95_1.var_.characterEffect1038ui_story and not isNil(var_98_6) then
					arg_95_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_7 + var_98_8 and arg_95_1.time_ < var_98_7 + var_98_8 + arg_98_0 and not isNil(var_98_6) and arg_95_1.var_.characterEffect1038ui_story then
				arg_95_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 then
				arg_95_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_98_11 = 0
			local var_98_12 = 0.625

			if var_98_11 < arg_95_1.time_ and arg_95_1.time_ <= var_98_11 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_13 = arg_95_1:FormatText(StoryNameCfg[94].name)

				arg_95_1.leftNameTxt_.text = var_98_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_14 = arg_95_1:GetWordFromCfg(113071023)
				local var_98_15 = arg_95_1:FormatText(var_98_14.content)

				arg_95_1.text_.text = var_98_15

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_16 = 25
				local var_98_17 = utf8.len(var_98_15)
				local var_98_18 = var_98_16 <= 0 and var_98_12 or var_98_12 * (var_98_17 / var_98_16)

				if var_98_18 > 0 and var_98_12 < var_98_18 then
					arg_95_1.talkMaxDuration = var_98_18

					if var_98_18 + var_98_11 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_18 + var_98_11
					end
				end

				arg_95_1.text_.text = var_98_15
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071023", "story_v_out_113071.awb") ~= 0 then
					local var_98_19 = manager.audio:GetVoiceLength("story_v_out_113071", "113071023", "story_v_out_113071.awb") / 1000

					if var_98_19 + var_98_11 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_19 + var_98_11
					end

					if var_98_14.prefab_name ~= "" and arg_95_1.actors_[var_98_14.prefab_name] ~= nil then
						local var_98_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_14.prefab_name].transform, "story_v_out_113071", "113071023", "story_v_out_113071.awb")

						arg_95_1:RecordAudio("113071023", var_98_20)
						arg_95_1:RecordAudio("113071023", var_98_20)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_113071", "113071023", "story_v_out_113071.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_113071", "113071023", "story_v_out_113071.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_21 = math.max(var_98_12, arg_95_1.talkMaxDuration)

			if var_98_11 <= arg_95_1.time_ and arg_95_1.time_ < var_98_11 + var_98_21 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_11) / var_98_21

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_11 + var_98_21 and arg_95_1.time_ < var_98_11 + var_98_21 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play113071024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 113071024
		arg_99_1.duration_ = 8.2

		local var_99_0 = {
			ja = 8.2,
			ko = 4,
			zh = 4.8,
			en = 5.566
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
				arg_99_0:Play113071025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1038ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1038ui_story == nil then
				arg_99_1.var_.characterEffect1038ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.2

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect1038ui_story and not isNil(var_102_0) then
					local var_102_4 = Mathf.Lerp(0, 0.5, var_102_3)

					arg_99_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1038ui_story.fillRatio = var_102_4
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1038ui_story then
				local var_102_5 = 0.5

				arg_99_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1038ui_story.fillRatio = var_102_5
			end

			local var_102_6 = arg_99_1.actors_["1041ui_story"]
			local var_102_7 = 0

			if var_102_7 < arg_99_1.time_ and arg_99_1.time_ <= var_102_7 + arg_102_0 and not isNil(var_102_6) and arg_99_1.var_.characterEffect1041ui_story == nil then
				arg_99_1.var_.characterEffect1041ui_story = var_102_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_8 = 0.2

			if var_102_7 <= arg_99_1.time_ and arg_99_1.time_ < var_102_7 + var_102_8 and not isNil(var_102_6) then
				local var_102_9 = (arg_99_1.time_ - var_102_7) / var_102_8

				if arg_99_1.var_.characterEffect1041ui_story and not isNil(var_102_6) then
					arg_99_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_7 + var_102_8 and arg_99_1.time_ < var_102_7 + var_102_8 + arg_102_0 and not isNil(var_102_6) and arg_99_1.var_.characterEffect1041ui_story then
				arg_99_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_102_10 = 0

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 then
				arg_99_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_102_11 = 0
			local var_102_12 = 0.45

			if var_102_11 < arg_99_1.time_ and arg_99_1.time_ <= var_102_11 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_13 = arg_99_1:FormatText(StoryNameCfg[208].name)

				arg_99_1.leftNameTxt_.text = var_102_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_14 = arg_99_1:GetWordFromCfg(113071024)
				local var_102_15 = arg_99_1:FormatText(var_102_14.content)

				arg_99_1.text_.text = var_102_15

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_16 = 18
				local var_102_17 = utf8.len(var_102_15)
				local var_102_18 = var_102_16 <= 0 and var_102_12 or var_102_12 * (var_102_17 / var_102_16)

				if var_102_18 > 0 and var_102_12 < var_102_18 then
					arg_99_1.talkMaxDuration = var_102_18

					if var_102_18 + var_102_11 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_18 + var_102_11
					end
				end

				arg_99_1.text_.text = var_102_15
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071024", "story_v_out_113071.awb") ~= 0 then
					local var_102_19 = manager.audio:GetVoiceLength("story_v_out_113071", "113071024", "story_v_out_113071.awb") / 1000

					if var_102_19 + var_102_11 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_19 + var_102_11
					end

					if var_102_14.prefab_name ~= "" and arg_99_1.actors_[var_102_14.prefab_name] ~= nil then
						local var_102_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_14.prefab_name].transform, "story_v_out_113071", "113071024", "story_v_out_113071.awb")

						arg_99_1:RecordAudio("113071024", var_102_20)
						arg_99_1:RecordAudio("113071024", var_102_20)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_113071", "113071024", "story_v_out_113071.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_113071", "113071024", "story_v_out_113071.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_21 = math.max(var_102_12, arg_99_1.talkMaxDuration)

			if var_102_11 <= arg_99_1.time_ and arg_99_1.time_ < var_102_11 + var_102_21 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_11) / var_102_21

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_11 + var_102_21 and arg_99_1.time_ < var_102_11 + var_102_21 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play113071025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 113071025
		arg_103_1.duration_ = 3.57

		local var_103_0 = {
			ja = 2.933,
			ko = 2.366,
			zh = 2.133,
			en = 3.566
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
				arg_103_0:Play113071026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_106_1 = arg_103_1.actors_["1041ui_story"]
			local var_106_2 = 0

			if var_106_2 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1041ui_story == nil then
				arg_103_1.var_.characterEffect1041ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_3 = 0.2

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_3 and not isNil(var_106_1) then
				local var_106_4 = (arg_103_1.time_ - var_106_2) / var_106_3

				if arg_103_1.var_.characterEffect1041ui_story and not isNil(var_106_1) then
					local var_106_5 = Mathf.Lerp(0, 0.5, var_106_4)

					arg_103_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1041ui_story.fillRatio = var_106_5
				end
			end

			if arg_103_1.time_ >= var_106_2 + var_106_3 and arg_103_1.time_ < var_106_2 + var_106_3 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1041ui_story then
				local var_106_6 = 0.5

				arg_103_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1041ui_story.fillRatio = var_106_6
			end

			local var_106_7 = arg_103_1.actors_["1038ui_story"]
			local var_106_8 = 0

			if var_106_8 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 and not isNil(var_106_7) and arg_103_1.var_.characterEffect1038ui_story == nil then
				arg_103_1.var_.characterEffect1038ui_story = var_106_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_9 = 0.2

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_9 and not isNil(var_106_7) then
				local var_106_10 = (arg_103_1.time_ - var_106_8) / var_106_9

				if arg_103_1.var_.characterEffect1038ui_story and not isNil(var_106_7) then
					arg_103_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_8 + var_106_9 and arg_103_1.time_ < var_106_8 + var_106_9 + arg_106_0 and not isNil(var_106_7) and arg_103_1.var_.characterEffect1038ui_story then
				arg_103_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_106_11 = 0
			local var_106_12 = 0.225

			if var_106_11 < arg_103_1.time_ and arg_103_1.time_ <= var_106_11 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_13 = arg_103_1:FormatText(StoryNameCfg[94].name)

				arg_103_1.leftNameTxt_.text = var_106_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_14 = arg_103_1:GetWordFromCfg(113071025)
				local var_106_15 = arg_103_1:FormatText(var_106_14.content)

				arg_103_1.text_.text = var_106_15

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_16 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071025", "story_v_out_113071.awb") ~= 0 then
					local var_106_19 = manager.audio:GetVoiceLength("story_v_out_113071", "113071025", "story_v_out_113071.awb") / 1000

					if var_106_19 + var_106_11 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_19 + var_106_11
					end

					if var_106_14.prefab_name ~= "" and arg_103_1.actors_[var_106_14.prefab_name] ~= nil then
						local var_106_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_14.prefab_name].transform, "story_v_out_113071", "113071025", "story_v_out_113071.awb")

						arg_103_1:RecordAudio("113071025", var_106_20)
						arg_103_1:RecordAudio("113071025", var_106_20)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_113071", "113071025", "story_v_out_113071.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_113071", "113071025", "story_v_out_113071.awb")
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
	Play113071026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 113071026
		arg_107_1.duration_ = 9

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play113071027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.mask_.enabled = true
				arg_107_1.mask_.raycastTarget = true

				arg_107_1:SetGaussion(false)
			end

			local var_110_1 = 2

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_1 then
				local var_110_2 = (arg_107_1.time_ - var_110_0) / var_110_1
				local var_110_3 = Color.New(0, 0, 0)

				var_110_3.a = Mathf.Lerp(0, 1, var_110_2)
				arg_107_1.mask_.color = var_110_3
			end

			if arg_107_1.time_ >= var_110_0 + var_110_1 and arg_107_1.time_ < var_110_0 + var_110_1 + arg_110_0 then
				local var_110_4 = Color.New(0, 0, 0)

				var_110_4.a = 1
				arg_107_1.mask_.color = var_110_4
			end

			local var_110_5 = 2

			if var_110_5 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 then
				arg_107_1.mask_.enabled = true
				arg_107_1.mask_.raycastTarget = true

				arg_107_1:SetGaussion(false)
			end

			local var_110_6 = 2

			if var_110_5 <= arg_107_1.time_ and arg_107_1.time_ < var_110_5 + var_110_6 then
				local var_110_7 = (arg_107_1.time_ - var_110_5) / var_110_6
				local var_110_8 = Color.New(0, 0, 0)

				var_110_8.a = Mathf.Lerp(1, 0, var_110_7)
				arg_107_1.mask_.color = var_110_8
			end

			if arg_107_1.time_ >= var_110_5 + var_110_6 and arg_107_1.time_ < var_110_5 + var_110_6 + arg_110_0 then
				local var_110_9 = Color.New(0, 0, 0)
				local var_110_10 = 0

				arg_107_1.mask_.enabled = false
				var_110_9.a = var_110_10
				arg_107_1.mask_.color = var_110_9
			end

			local var_110_11 = "OM0110"

			if arg_107_1.bgs_[var_110_11] == nil then
				local var_110_12 = Object.Instantiate(arg_107_1.paintGo_)

				var_110_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_110_11)
				var_110_12.name = var_110_11
				var_110_12.transform.parent = arg_107_1.stage_.transform
				var_110_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_107_1.bgs_[var_110_11] = var_110_12
			end

			local var_110_13 = 2

			if var_110_13 < arg_107_1.time_ and arg_107_1.time_ <= var_110_13 + arg_110_0 then
				local var_110_14 = manager.ui.mainCamera.transform.localPosition
				local var_110_15 = Vector3.New(0, 0, 10) + Vector3.New(var_110_14.x, var_110_14.y, 0)
				local var_110_16 = arg_107_1.bgs_.OM0110

				var_110_16.transform.localPosition = var_110_15
				var_110_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_110_17 = var_110_16:GetComponent("SpriteRenderer")

				if var_110_17 and var_110_17.sprite then
					local var_110_18 = (var_110_16.transform.localPosition - var_110_14).z
					local var_110_19 = manager.ui.mainCameraCom_
					local var_110_20 = 2 * var_110_18 * Mathf.Tan(var_110_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_110_21 = var_110_20 * var_110_19.aspect
					local var_110_22 = var_110_17.sprite.bounds.size.x
					local var_110_23 = var_110_17.sprite.bounds.size.y
					local var_110_24 = var_110_21 / var_110_22
					local var_110_25 = var_110_20 / var_110_23
					local var_110_26 = var_110_25 < var_110_24 and var_110_24 or var_110_25

					var_110_16.transform.localScale = Vector3.New(var_110_26, var_110_26, 0)
				end

				for iter_110_0, iter_110_1 in pairs(arg_107_1.bgs_) do
					if iter_110_0 ~= "OM0110" then
						iter_110_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_110_27 = arg_107_1.actors_["1038ui_story"].transform
			local var_110_28 = 1.966

			if var_110_28 < arg_107_1.time_ and arg_107_1.time_ <= var_110_28 + arg_110_0 then
				arg_107_1.var_.moveOldPos1038ui_story = var_110_27.localPosition
			end

			local var_110_29 = 0.001

			if var_110_28 <= arg_107_1.time_ and arg_107_1.time_ < var_110_28 + var_110_29 then
				local var_110_30 = (arg_107_1.time_ - var_110_28) / var_110_29
				local var_110_31 = Vector3.New(0, 100, 0)

				var_110_27.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1038ui_story, var_110_31, var_110_30)

				local var_110_32 = manager.ui.mainCamera.transform.position - var_110_27.position

				var_110_27.forward = Vector3.New(var_110_32.x, var_110_32.y, var_110_32.z)

				local var_110_33 = var_110_27.localEulerAngles

				var_110_33.z = 0
				var_110_33.x = 0
				var_110_27.localEulerAngles = var_110_33
			end

			if arg_107_1.time_ >= var_110_28 + var_110_29 and arg_107_1.time_ < var_110_28 + var_110_29 + arg_110_0 then
				var_110_27.localPosition = Vector3.New(0, 100, 0)

				local var_110_34 = manager.ui.mainCamera.transform.position - var_110_27.position

				var_110_27.forward = Vector3.New(var_110_34.x, var_110_34.y, var_110_34.z)

				local var_110_35 = var_110_27.localEulerAngles

				var_110_35.z = 0
				var_110_35.x = 0
				var_110_27.localEulerAngles = var_110_35
			end

			local var_110_36 = arg_107_1.actors_["1041ui_story"].transform
			local var_110_37 = 1.966

			if var_110_37 < arg_107_1.time_ and arg_107_1.time_ <= var_110_37 + arg_110_0 then
				arg_107_1.var_.moveOldPos1041ui_story = var_110_36.localPosition
			end

			local var_110_38 = 0.001

			if var_110_37 <= arg_107_1.time_ and arg_107_1.time_ < var_110_37 + var_110_38 then
				local var_110_39 = (arg_107_1.time_ - var_110_37) / var_110_38
				local var_110_40 = Vector3.New(0, 100, 0)

				var_110_36.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1041ui_story, var_110_40, var_110_39)

				local var_110_41 = manager.ui.mainCamera.transform.position - var_110_36.position

				var_110_36.forward = Vector3.New(var_110_41.x, var_110_41.y, var_110_41.z)

				local var_110_42 = var_110_36.localEulerAngles

				var_110_42.z = 0
				var_110_42.x = 0
				var_110_36.localEulerAngles = var_110_42
			end

			if arg_107_1.time_ >= var_110_37 + var_110_38 and arg_107_1.time_ < var_110_37 + var_110_38 + arg_110_0 then
				var_110_36.localPosition = Vector3.New(0, 100, 0)

				local var_110_43 = manager.ui.mainCamera.transform.position - var_110_36.position

				var_110_36.forward = Vector3.New(var_110_43.x, var_110_43.y, var_110_43.z)

				local var_110_44 = var_110_36.localEulerAngles

				var_110_44.z = 0
				var_110_44.x = 0
				var_110_36.localEulerAngles = var_110_44
			end

			if arg_107_1.frameCnt_ <= 1 then
				arg_107_1.dialog_:SetActive(false)
			end

			local var_110_45 = 4
			local var_110_46 = 0.925

			if var_110_45 < arg_107_1.time_ and arg_107_1.time_ <= var_110_45 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0

				arg_107_1.dialog_:SetActive(true)

				arg_107_1.dialogCg_.alpha = 0

				local var_110_47 = LeanTween.value(arg_107_1.dialog_, 0, 1, 0.3)

				var_110_47:setOnUpdate(LuaHelper.FloatAction(function(arg_111_0)
					arg_107_1.dialogCg_.alpha = arg_111_0
				end))
				var_110_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_107_1.dialog_)
					var_110_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_107_1.duration_ = arg_107_1.duration_ + 0.3

				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_48 = arg_107_1:GetWordFromCfg(113071026)
				local var_110_49 = arg_107_1:FormatText(var_110_48.content)

				arg_107_1.text_.text = var_110_49

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_50 = 37
				local var_110_51 = utf8.len(var_110_49)
				local var_110_52 = var_110_50 <= 0 and var_110_46 or var_110_46 * (var_110_51 / var_110_50)

				if var_110_52 > 0 and var_110_46 < var_110_52 then
					arg_107_1.talkMaxDuration = var_110_52
					var_110_45 = var_110_45 + 0.3

					if var_110_52 + var_110_45 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_52 + var_110_45
					end
				end

				arg_107_1.text_.text = var_110_49
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_53 = var_110_45 + 0.3
			local var_110_54 = math.max(var_110_46, arg_107_1.talkMaxDuration)

			if var_110_53 <= arg_107_1.time_ and arg_107_1.time_ < var_110_53 + var_110_54 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_53) / var_110_54

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_53 + var_110_54 and arg_107_1.time_ < var_110_53 + var_110_54 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play113071027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 113071027
		arg_113_1.duration_ = 6.5

		local var_113_0 = {
			ja = 6.4,
			ko = 4.3,
			zh = 4.633,
			en = 6.5
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play113071028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.5

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[94].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(113071027)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 20
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071027", "story_v_out_113071.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_113071", "113071027", "story_v_out_113071.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_113071", "113071027", "story_v_out_113071.awb")

						arg_113_1:RecordAudio("113071027", var_116_9)
						arg_113_1:RecordAudio("113071027", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_113071", "113071027", "story_v_out_113071.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_113071", "113071027", "story_v_out_113071.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_10 and arg_113_1.time_ < var_116_0 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play113071028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 113071028
		arg_117_1.duration_ = 7.53

		local var_117_0 = {
			ja = 7.533,
			ko = 7.233,
			zh = 6.8,
			en = 5.933
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play113071029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.85

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[94].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(113071028)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 33
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071028", "story_v_out_113071.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_113071", "113071028", "story_v_out_113071.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_113071", "113071028", "story_v_out_113071.awb")

						arg_117_1:RecordAudio("113071028", var_120_9)
						arg_117_1:RecordAudio("113071028", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_113071", "113071028", "story_v_out_113071.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_113071", "113071028", "story_v_out_113071.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_10 and arg_117_1.time_ < var_120_0 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play113071029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 113071029
		arg_121_1.duration_ = 2.93

		local var_121_0 = {
			ja = 2.933,
			ko = 2.2,
			zh = 2.7,
			en = 1.6
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play113071030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.225

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[94].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:GetWordFromCfg(113071029)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 9
				local var_124_6 = utf8.len(var_124_4)
				local var_124_7 = var_124_5 <= 0 and var_124_1 or var_124_1 * (var_124_6 / var_124_5)

				if var_124_7 > 0 and var_124_1 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071029", "story_v_out_113071.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_out_113071", "113071029", "story_v_out_113071.awb") / 1000

					if var_124_8 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_113071", "113071029", "story_v_out_113071.awb")

						arg_121_1:RecordAudio("113071029", var_124_9)
						arg_121_1:RecordAudio("113071029", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_113071", "113071029", "story_v_out_113071.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_113071", "113071029", "story_v_out_113071.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_10 and arg_121_1.time_ < var_124_0 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play113071030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 113071030
		arg_125_1.duration_ = 3.4

		local var_125_0 = {
			ja = 3.4,
			ko = 2.4,
			zh = 3.033,
			en = 3.4
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play113071031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.325

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[208].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:GetWordFromCfg(113071030)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 13
				local var_128_6 = utf8.len(var_128_4)
				local var_128_7 = var_128_5 <= 0 and var_128_1 or var_128_1 * (var_128_6 / var_128_5)

				if var_128_7 > 0 and var_128_1 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071030", "story_v_out_113071.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_113071", "113071030", "story_v_out_113071.awb") / 1000

					if var_128_8 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_0
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_out_113071", "113071030", "story_v_out_113071.awb")

						arg_125_1:RecordAudio("113071030", var_128_9)
						arg_125_1:RecordAudio("113071030", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_113071", "113071030", "story_v_out_113071.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_113071", "113071030", "story_v_out_113071.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_10 and arg_125_1.time_ < var_128_0 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play113071031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 113071031
		arg_129_1.duration_ = 3.57

		local var_129_0 = {
			ja = 3.566,
			ko = 3.466,
			zh = 2.766,
			en = 2.733
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
				arg_129_0:Play113071032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.275

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[94].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:GetWordFromCfg(113071031)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 11
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071031", "story_v_out_113071.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_113071", "113071031", "story_v_out_113071.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_113071", "113071031", "story_v_out_113071.awb")

						arg_129_1:RecordAudio("113071031", var_132_9)
						arg_129_1:RecordAudio("113071031", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_113071", "113071031", "story_v_out_113071.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_113071", "113071031", "story_v_out_113071.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_10 and arg_129_1.time_ < var_132_0 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play113071032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 113071032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play113071033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.575

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_2 = arg_133_1:GetWordFromCfg(113071032)
				local var_136_3 = arg_133_1:FormatText(var_136_2.content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 23
				local var_136_5 = utf8.len(var_136_3)
				local var_136_6 = var_136_4 <= 0 and var_136_1 or var_136_1 * (var_136_5 / var_136_4)

				if var_136_6 > 0 and var_136_1 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_7 and arg_133_1.time_ < var_136_0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play113071033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 113071033
		arg_137_1.duration_ = 8.33

		local var_137_0 = {
			ja = 7.5,
			ko = 8.333,
			zh = 7.366,
			en = 6.133
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
				arg_137_0:Play113071034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.775

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[94].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:GetWordFromCfg(113071033)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 31
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071033", "story_v_out_113071.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_113071", "113071033", "story_v_out_113071.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_113071", "113071033", "story_v_out_113071.awb")

						arg_137_1:RecordAudio("113071033", var_140_9)
						arg_137_1:RecordAudio("113071033", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_113071", "113071033", "story_v_out_113071.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_113071", "113071033", "story_v_out_113071.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_10 and arg_137_1.time_ < var_140_0 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play113071034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 113071034
		arg_141_1.duration_ = 5.03

		local var_141_0 = {
			ja = 3.3,
			ko = 5.033,
			zh = 3.166,
			en = 5
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
				arg_141_0:Play113071035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.35

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[94].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(113071034)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071034", "story_v_out_113071.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_113071", "113071034", "story_v_out_113071.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_113071", "113071034", "story_v_out_113071.awb")

						arg_141_1:RecordAudio("113071034", var_144_9)
						arg_141_1:RecordAudio("113071034", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_113071", "113071034", "story_v_out_113071.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_113071", "113071034", "story_v_out_113071.awb")
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
	Play113071035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 113071035
		arg_145_1.duration_ = 1.3

		local var_145_0 = {
			ja = 1.2,
			ko = 0.999999999999,
			zh = 1.233,
			en = 1.3
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
				arg_145_0:Play113071036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.05

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[208].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:GetWordFromCfg(113071035)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 2
				local var_148_6 = utf8.len(var_148_4)
				local var_148_7 = var_148_5 <= 0 and var_148_1 or var_148_1 * (var_148_6 / var_148_5)

				if var_148_7 > 0 and var_148_1 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071035", "story_v_out_113071.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_113071", "113071035", "story_v_out_113071.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_113071", "113071035", "story_v_out_113071.awb")

						arg_145_1:RecordAudio("113071035", var_148_9)
						arg_145_1:RecordAudio("113071035", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_113071", "113071035", "story_v_out_113071.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_113071", "113071035", "story_v_out_113071.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_10 and arg_145_1.time_ < var_148_0 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play113071036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 113071036
		arg_149_1.duration_ = 9

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play113071037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_1 = 2

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_1 then
				local var_152_2 = (arg_149_1.time_ - var_152_0) / var_152_1
				local var_152_3 = Color.New(0, 0, 0)

				var_152_3.a = Mathf.Lerp(0, 1, var_152_2)
				arg_149_1.mask_.color = var_152_3
			end

			if arg_149_1.time_ >= var_152_0 + var_152_1 and arg_149_1.time_ < var_152_0 + var_152_1 + arg_152_0 then
				local var_152_4 = Color.New(0, 0, 0)

				var_152_4.a = 1
				arg_149_1.mask_.color = var_152_4
			end

			local var_152_5 = 2

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_6 = 2

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_6 then
				local var_152_7 = (arg_149_1.time_ - var_152_5) / var_152_6
				local var_152_8 = Color.New(0, 0, 0)

				var_152_8.a = Mathf.Lerp(1, 0, var_152_7)
				arg_149_1.mask_.color = var_152_8
			end

			if arg_149_1.time_ >= var_152_5 + var_152_6 and arg_149_1.time_ < var_152_5 + var_152_6 + arg_152_0 then
				local var_152_9 = Color.New(0, 0, 0)
				local var_152_10 = 0

				arg_149_1.mask_.enabled = false
				var_152_9.a = var_152_10
				arg_149_1.mask_.color = var_152_9
			end

			local var_152_11 = 2

			if var_152_11 < arg_149_1.time_ and arg_149_1.time_ <= var_152_11 + arg_152_0 then
				local var_152_12 = manager.ui.mainCamera.transform.localPosition
				local var_152_13 = Vector3.New(0, 0, 10) + Vector3.New(var_152_12.x, var_152_12.y, 0)
				local var_152_14 = arg_149_1.bgs_.F01

				var_152_14.transform.localPosition = var_152_13
				var_152_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_152_15 = var_152_14:GetComponent("SpriteRenderer")

				if var_152_15 and var_152_15.sprite then
					local var_152_16 = (var_152_14.transform.localPosition - var_152_12).z
					local var_152_17 = manager.ui.mainCameraCom_
					local var_152_18 = 2 * var_152_16 * Mathf.Tan(var_152_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_152_19 = var_152_18 * var_152_17.aspect
					local var_152_20 = var_152_15.sprite.bounds.size.x
					local var_152_21 = var_152_15.sprite.bounds.size.y
					local var_152_22 = var_152_19 / var_152_20
					local var_152_23 = var_152_18 / var_152_21
					local var_152_24 = var_152_23 < var_152_22 and var_152_22 or var_152_23

					var_152_14.transform.localScale = Vector3.New(var_152_24, var_152_24, 0)
				end

				for iter_152_0, iter_152_1 in pairs(arg_149_1.bgs_) do
					if iter_152_0 ~= "F01" then
						iter_152_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_152_25 = 0
			local var_152_26 = 1.04555149935186

			if var_152_25 < arg_149_1.time_ and arg_149_1.time_ <= var_152_25 + arg_152_0 then
				local var_152_27 = "stop"
				local var_152_28 = "music"

				arg_149_1:AudioAction(var_152_27, var_152_28, "se_story_10", "se_story_10_boiling_loop", "")

				local var_152_29 = ""
				local var_152_30 = manager.audio:GetAudioName("se_story_10", "se_story_10_boiling_loop")

				if var_152_30 ~= "" then
					if arg_149_1.bgmTxt_.text ~= var_152_30 and arg_149_1.bgmTxt_.text ~= "" then
						if arg_149_1.bgmTxt2_.text ~= "" then
							arg_149_1.bgmTxt_.text = arg_149_1.bgmTxt2_.text
						end

						arg_149_1.bgmTxt2_.text = var_152_30

						arg_149_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_149_1.bgmTxt_.text = var_152_30
						arg_149_1.bgmTxt2_.text = var_152_30
					end

					if arg_149_1.bgmTimer then
						arg_149_1.bgmTimer:Stop()

						arg_149_1.bgmTimer = nil
					end

					if arg_149_1.settingData.show_music_name == 1 then
						arg_149_1.musicController:SetSelectedState("show")
						arg_149_1.musicAnimator_:Play("open", 0, 0)

						if arg_149_1.settingData.music_time ~= 0 then
							arg_149_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_149_1.settingData.music_time), function()
								if arg_149_1 == nil or isNil(arg_149_1.bgmTxt_) then
									return
								end

								arg_149_1.musicController:SetSelectedState("hide")
								arg_149_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_152_31 = 1.04555149935186
			local var_152_32 = 1

			if var_152_31 < arg_149_1.time_ and arg_149_1.time_ <= var_152_31 + arg_152_0 then
				local var_152_33 = "play"
				local var_152_34 = "effect"

				arg_149_1:AudioAction(var_152_33, var_152_34, "se_story_10", "se_story_10_tea", "")
			end

			if arg_149_1.frameCnt_ <= 1 then
				arg_149_1.dialog_:SetActive(false)
			end

			local var_152_35 = 4
			local var_152_36 = 0.575

			if var_152_35 < arg_149_1.time_ and arg_149_1.time_ <= var_152_35 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				arg_149_1.dialog_:SetActive(true)

				arg_149_1.dialogCg_.alpha = 0

				local var_152_37 = LeanTween.value(arg_149_1.dialog_, 0, 1, 0.3)

				var_152_37:setOnUpdate(LuaHelper.FloatAction(function(arg_154_0)
					arg_149_1.dialogCg_.alpha = arg_154_0
				end))
				var_152_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_149_1.dialog_)
					var_152_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_149_1.duration_ = arg_149_1.duration_ + 0.3

				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_38 = arg_149_1:GetWordFromCfg(113071036)
				local var_152_39 = arg_149_1:FormatText(var_152_38.content)

				arg_149_1.text_.text = var_152_39

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_40 = 23
				local var_152_41 = utf8.len(var_152_39)
				local var_152_42 = var_152_40 <= 0 and var_152_36 or var_152_36 * (var_152_41 / var_152_40)

				if var_152_42 > 0 and var_152_36 < var_152_42 then
					arg_149_1.talkMaxDuration = var_152_42
					var_152_35 = var_152_35 + 0.3

					if var_152_42 + var_152_35 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_42 + var_152_35
					end
				end

				arg_149_1.text_.text = var_152_39
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_43 = var_152_35 + 0.3
			local var_152_44 = math.max(var_152_36, arg_149_1.talkMaxDuration)

			if var_152_43 <= arg_149_1.time_ and arg_149_1.time_ < var_152_43 + var_152_44 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_43) / var_152_44

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_43 + var_152_44 and arg_149_1.time_ < var_152_43 + var_152_44 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play113071037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 113071037
		arg_156_1.duration_ = 2

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play113071038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1038ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos1038ui_story = var_159_0.localPosition
			end

			local var_159_2 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2
				local var_159_4 = Vector3.New(-0.7, -1.11, -5.9)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1038ui_story, var_159_4, var_159_3)

				local var_159_5 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_5.x, var_159_5.y, var_159_5.z)

				local var_159_6 = var_159_0.localEulerAngles

				var_159_6.z = 0
				var_159_6.x = 0
				var_159_0.localEulerAngles = var_159_6
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_159_7 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_7.x, var_159_7.y, var_159_7.z)

				local var_159_8 = var_159_0.localEulerAngles

				var_159_8.z = 0
				var_159_8.x = 0
				var_159_0.localEulerAngles = var_159_8
			end

			local var_159_9 = 0

			if var_159_9 < arg_156_1.time_ and arg_156_1.time_ <= var_159_9 + arg_159_0 then
				arg_156_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 then
				arg_156_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_159_11 = arg_156_1.actors_["1038ui_story"]
			local var_159_12 = 0

			if var_159_12 < arg_156_1.time_ and arg_156_1.time_ <= var_159_12 + arg_159_0 and not isNil(var_159_11) and arg_156_1.var_.characterEffect1038ui_story == nil then
				arg_156_1.var_.characterEffect1038ui_story = var_159_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_13 = 0.2

			if var_159_12 <= arg_156_1.time_ and arg_156_1.time_ < var_159_12 + var_159_13 and not isNil(var_159_11) then
				local var_159_14 = (arg_156_1.time_ - var_159_12) / var_159_13

				if arg_156_1.var_.characterEffect1038ui_story and not isNil(var_159_11) then
					arg_156_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_12 + var_159_13 and arg_156_1.time_ < var_159_12 + var_159_13 + arg_159_0 and not isNil(var_159_11) and arg_156_1.var_.characterEffect1038ui_story then
				arg_156_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_159_15 = 0
			local var_159_16 = 0.05

			if var_159_15 < arg_156_1.time_ and arg_156_1.time_ <= var_159_15 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_17 = arg_156_1:FormatText(StoryNameCfg[94].name)

				arg_156_1.leftNameTxt_.text = var_159_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_18 = arg_156_1:GetWordFromCfg(113071037)
				local var_159_19 = arg_156_1:FormatText(var_159_18.content)

				arg_156_1.text_.text = var_159_19

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_20 = 2
				local var_159_21 = utf8.len(var_159_19)
				local var_159_22 = var_159_20 <= 0 and var_159_16 or var_159_16 * (var_159_21 / var_159_20)

				if var_159_22 > 0 and var_159_16 < var_159_22 then
					arg_156_1.talkMaxDuration = var_159_22

					if var_159_22 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_22 + var_159_15
					end
				end

				arg_156_1.text_.text = var_159_19
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071037", "story_v_out_113071.awb") ~= 0 then
					local var_159_23 = manager.audio:GetVoiceLength("story_v_out_113071", "113071037", "story_v_out_113071.awb") / 1000

					if var_159_23 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_23 + var_159_15
					end

					if var_159_18.prefab_name ~= "" and arg_156_1.actors_[var_159_18.prefab_name] ~= nil then
						local var_159_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_18.prefab_name].transform, "story_v_out_113071", "113071037", "story_v_out_113071.awb")

						arg_156_1:RecordAudio("113071037", var_159_24)
						arg_156_1:RecordAudio("113071037", var_159_24)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_113071", "113071037", "story_v_out_113071.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_113071", "113071037", "story_v_out_113071.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_25 = math.max(var_159_16, arg_156_1.talkMaxDuration)

			if var_159_15 <= arg_156_1.time_ and arg_156_1.time_ < var_159_15 + var_159_25 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_15) / var_159_25

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_15 + var_159_25 and arg_156_1.time_ < var_159_15 + var_159_25 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play113071038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 113071038
		arg_160_1.duration_ = 7.2

		local var_160_0 = {
			ja = 7.2,
			ko = 2.233,
			zh = 3.866,
			en = 6
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
				arg_160_0:Play113071039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1038ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1038ui_story == nil then
				arg_160_1.var_.characterEffect1038ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.2

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1038ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1038ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1038ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1038ui_story.fillRatio = var_163_5
			end

			local var_163_6 = arg_160_1.actors_["1041ui_story"].transform
			local var_163_7 = 0

			if var_163_7 < arg_160_1.time_ and arg_160_1.time_ <= var_163_7 + arg_163_0 then
				arg_160_1.var_.moveOldPos1041ui_story = var_163_6.localPosition
			end

			local var_163_8 = 0.001

			if var_163_7 <= arg_160_1.time_ and arg_160_1.time_ < var_163_7 + var_163_8 then
				local var_163_9 = (arg_160_1.time_ - var_163_7) / var_163_8
				local var_163_10 = Vector3.New(0.7, -1.11, -5.9)

				var_163_6.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1041ui_story, var_163_10, var_163_9)

				local var_163_11 = manager.ui.mainCamera.transform.position - var_163_6.position

				var_163_6.forward = Vector3.New(var_163_11.x, var_163_11.y, var_163_11.z)

				local var_163_12 = var_163_6.localEulerAngles

				var_163_12.z = 0
				var_163_12.x = 0
				var_163_6.localEulerAngles = var_163_12
			end

			if arg_160_1.time_ >= var_163_7 + var_163_8 and arg_160_1.time_ < var_163_7 + var_163_8 + arg_163_0 then
				var_163_6.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_163_13 = manager.ui.mainCamera.transform.position - var_163_6.position

				var_163_6.forward = Vector3.New(var_163_13.x, var_163_13.y, var_163_13.z)

				local var_163_14 = var_163_6.localEulerAngles

				var_163_14.z = 0
				var_163_14.x = 0
				var_163_6.localEulerAngles = var_163_14
			end

			local var_163_15 = 0

			if var_163_15 < arg_160_1.time_ and arg_160_1.time_ <= var_163_15 + arg_163_0 then
				arg_160_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_163_16 = 0

			if var_163_16 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 then
				arg_160_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_163_17 = arg_160_1.actors_["1041ui_story"]
			local var_163_18 = 0

			if var_163_18 < arg_160_1.time_ and arg_160_1.time_ <= var_163_18 + arg_163_0 and not isNil(var_163_17) and arg_160_1.var_.characterEffect1041ui_story == nil then
				arg_160_1.var_.characterEffect1041ui_story = var_163_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_19 = 0.2

			if var_163_18 <= arg_160_1.time_ and arg_160_1.time_ < var_163_18 + var_163_19 and not isNil(var_163_17) then
				local var_163_20 = (arg_160_1.time_ - var_163_18) / var_163_19

				if arg_160_1.var_.characterEffect1041ui_story and not isNil(var_163_17) then
					arg_160_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_18 + var_163_19 and arg_160_1.time_ < var_163_18 + var_163_19 + arg_163_0 and not isNil(var_163_17) and arg_160_1.var_.characterEffect1041ui_story then
				arg_160_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_163_21 = 0
			local var_163_22 = 0.225

			if var_163_21 < arg_160_1.time_ and arg_160_1.time_ <= var_163_21 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_23 = arg_160_1:FormatText(StoryNameCfg[208].name)

				arg_160_1.leftNameTxt_.text = var_163_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_24 = arg_160_1:GetWordFromCfg(113071038)
				local var_163_25 = arg_160_1:FormatText(var_163_24.content)

				arg_160_1.text_.text = var_163_25

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_26 = 9
				local var_163_27 = utf8.len(var_163_25)
				local var_163_28 = var_163_26 <= 0 and var_163_22 or var_163_22 * (var_163_27 / var_163_26)

				if var_163_28 > 0 and var_163_22 < var_163_28 then
					arg_160_1.talkMaxDuration = var_163_28

					if var_163_28 + var_163_21 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_28 + var_163_21
					end
				end

				arg_160_1.text_.text = var_163_25
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071038", "story_v_out_113071.awb") ~= 0 then
					local var_163_29 = manager.audio:GetVoiceLength("story_v_out_113071", "113071038", "story_v_out_113071.awb") / 1000

					if var_163_29 + var_163_21 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_29 + var_163_21
					end

					if var_163_24.prefab_name ~= "" and arg_160_1.actors_[var_163_24.prefab_name] ~= nil then
						local var_163_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_24.prefab_name].transform, "story_v_out_113071", "113071038", "story_v_out_113071.awb")

						arg_160_1:RecordAudio("113071038", var_163_30)
						arg_160_1:RecordAudio("113071038", var_163_30)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_113071", "113071038", "story_v_out_113071.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_113071", "113071038", "story_v_out_113071.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_31 = math.max(var_163_22, arg_160_1.talkMaxDuration)

			if var_163_21 <= arg_160_1.time_ and arg_160_1.time_ < var_163_21 + var_163_31 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_21) / var_163_31

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_21 + var_163_31 and arg_160_1.time_ < var_163_21 + var_163_31 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play113071039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 113071039
		arg_164_1.duration_ = 6.77

		local var_164_0 = {
			ja = 5.833,
			ko = 5.866,
			zh = 5.266,
			en = 6.766
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
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play113071040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_167_2 = arg_164_1.actors_["1038ui_story"]
			local var_167_3 = 0

			if var_167_3 < arg_164_1.time_ and arg_164_1.time_ <= var_167_3 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.characterEffect1038ui_story == nil then
				arg_164_1.var_.characterEffect1038ui_story = var_167_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_4 = 0.2

			if var_167_3 <= arg_164_1.time_ and arg_164_1.time_ < var_167_3 + var_167_4 and not isNil(var_167_2) then
				local var_167_5 = (arg_164_1.time_ - var_167_3) / var_167_4

				if arg_164_1.var_.characterEffect1038ui_story and not isNil(var_167_2) then
					arg_164_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_3 + var_167_4 and arg_164_1.time_ < var_167_3 + var_167_4 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.characterEffect1038ui_story then
				arg_164_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_167_6 = arg_164_1.actors_["1041ui_story"]
			local var_167_7 = 0

			if var_167_7 < arg_164_1.time_ and arg_164_1.time_ <= var_167_7 + arg_167_0 and not isNil(var_167_6) and arg_164_1.var_.characterEffect1041ui_story == nil then
				arg_164_1.var_.characterEffect1041ui_story = var_167_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_8 = 0.2

			if var_167_7 <= arg_164_1.time_ and arg_164_1.time_ < var_167_7 + var_167_8 and not isNil(var_167_6) then
				local var_167_9 = (arg_164_1.time_ - var_167_7) / var_167_8

				if arg_164_1.var_.characterEffect1041ui_story and not isNil(var_167_6) then
					local var_167_10 = Mathf.Lerp(0, 0.5, var_167_9)

					arg_164_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1041ui_story.fillRatio = var_167_10
				end
			end

			if arg_164_1.time_ >= var_167_7 + var_167_8 and arg_164_1.time_ < var_167_7 + var_167_8 + arg_167_0 and not isNil(var_167_6) and arg_164_1.var_.characterEffect1041ui_story then
				local var_167_11 = 0.5

				arg_164_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1041ui_story.fillRatio = var_167_11
			end

			local var_167_12 = 0
			local var_167_13 = 0.6

			if var_167_12 < arg_164_1.time_ and arg_164_1.time_ <= var_167_12 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_14 = arg_164_1:FormatText(StoryNameCfg[94].name)

				arg_164_1.leftNameTxt_.text = var_167_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_15 = arg_164_1:GetWordFromCfg(113071039)
				local var_167_16 = arg_164_1:FormatText(var_167_15.content)

				arg_164_1.text_.text = var_167_16

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_17 = 24
				local var_167_18 = utf8.len(var_167_16)
				local var_167_19 = var_167_17 <= 0 and var_167_13 or var_167_13 * (var_167_18 / var_167_17)

				if var_167_19 > 0 and var_167_13 < var_167_19 then
					arg_164_1.talkMaxDuration = var_167_19

					if var_167_19 + var_167_12 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_19 + var_167_12
					end
				end

				arg_164_1.text_.text = var_167_16
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071039", "story_v_out_113071.awb") ~= 0 then
					local var_167_20 = manager.audio:GetVoiceLength("story_v_out_113071", "113071039", "story_v_out_113071.awb") / 1000

					if var_167_20 + var_167_12 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_20 + var_167_12
					end

					if var_167_15.prefab_name ~= "" and arg_164_1.actors_[var_167_15.prefab_name] ~= nil then
						local var_167_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_15.prefab_name].transform, "story_v_out_113071", "113071039", "story_v_out_113071.awb")

						arg_164_1:RecordAudio("113071039", var_167_21)
						arg_164_1:RecordAudio("113071039", var_167_21)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_113071", "113071039", "story_v_out_113071.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_113071", "113071039", "story_v_out_113071.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_22 = math.max(var_167_13, arg_164_1.talkMaxDuration)

			if var_167_12 <= arg_164_1.time_ and arg_164_1.time_ < var_167_12 + var_167_22 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_12) / var_167_22

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_12 + var_167_22 and arg_164_1.time_ < var_167_12 + var_167_22 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play113071040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 113071040
		arg_168_1.duration_ = 3.03

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play113071041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1038ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1038ui_story == nil then
				arg_168_1.var_.characterEffect1038ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.2

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect1038ui_story and not isNil(var_171_0) then
					local var_171_4 = Mathf.Lerp(0, 0.5, var_171_3)

					arg_168_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1038ui_story.fillRatio = var_171_4
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1038ui_story then
				local var_171_5 = 0.5

				arg_168_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1038ui_story.fillRatio = var_171_5
			end

			local var_171_6 = 0
			local var_171_7 = 1

			if var_171_6 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				local var_171_8 = "play"
				local var_171_9 = "music"

				arg_168_1:AudioAction(var_171_8, var_171_9, "ui_battle", "ui_battle_stopbgm", "")

				local var_171_10 = ""
				local var_171_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_171_11 ~= "" then
					if arg_168_1.bgmTxt_.text ~= var_171_11 and arg_168_1.bgmTxt_.text ~= "" then
						if arg_168_1.bgmTxt2_.text ~= "" then
							arg_168_1.bgmTxt_.text = arg_168_1.bgmTxt2_.text
						end

						arg_168_1.bgmTxt2_.text = var_171_11

						arg_168_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_168_1.bgmTxt_.text = var_171_11
						arg_168_1.bgmTxt2_.text = var_171_11
					end

					if arg_168_1.bgmTimer then
						arg_168_1.bgmTimer:Stop()

						arg_168_1.bgmTimer = nil
					end

					if arg_168_1.settingData.show_music_name == 1 then
						arg_168_1.musicController:SetSelectedState("show")
						arg_168_1.musicAnimator_:Play("open", 0, 0)

						if arg_168_1.settingData.music_time ~= 0 then
							arg_168_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_168_1.settingData.music_time), function()
								if arg_168_1 == nil or isNil(arg_168_1.bgmTxt_) then
									return
								end

								arg_168_1.musicController:SetSelectedState("hide")
								arg_168_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_171_12 = 0.175
			local var_171_13 = 1

			if var_171_12 < arg_168_1.time_ and arg_168_1.time_ <= var_171_12 + arg_171_0 then
				local var_171_14 = "play"
				local var_171_15 = "effect"

				arg_168_1:AudioAction(var_171_14, var_171_15, "se_story", "se_story_robot_e", "")
			end

			local var_171_16 = 0
			local var_171_17 = 0.175

			if var_171_16 < arg_168_1.time_ and arg_168_1.time_ <= var_171_16 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_18 = arg_168_1:FormatText(StoryNameCfg[68].name)

				arg_168_1.leftNameTxt_.text = var_171_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2037")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_19 = arg_168_1:GetWordFromCfg(113071040)
				local var_171_20 = arg_168_1:FormatText(var_171_19.content)

				arg_168_1.text_.text = var_171_20

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_21 = 7
				local var_171_22 = utf8.len(var_171_20)
				local var_171_23 = var_171_21 <= 0 and var_171_17 or var_171_17 * (var_171_22 / var_171_21)

				if var_171_23 > 0 and var_171_17 < var_171_23 then
					arg_168_1.talkMaxDuration = var_171_23

					if var_171_23 + var_171_16 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_23 + var_171_16
					end
				end

				arg_168_1.text_.text = var_171_20
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071040", "story_v_out_113071.awb") ~= 0 then
					local var_171_24 = manager.audio:GetVoiceLength("story_v_out_113071", "113071040", "story_v_out_113071.awb") / 1000

					if var_171_24 + var_171_16 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_24 + var_171_16
					end

					if var_171_19.prefab_name ~= "" and arg_168_1.actors_[var_171_19.prefab_name] ~= nil then
						local var_171_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_19.prefab_name].transform, "story_v_out_113071", "113071040", "story_v_out_113071.awb")

						arg_168_1:RecordAudio("113071040", var_171_25)
						arg_168_1:RecordAudio("113071040", var_171_25)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_113071", "113071040", "story_v_out_113071.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_113071", "113071040", "story_v_out_113071.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_26 = math.max(var_171_17, arg_168_1.talkMaxDuration)

			if var_171_16 <= arg_168_1.time_ and arg_168_1.time_ < var_171_16 + var_171_26 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_16) / var_171_26

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_16 + var_171_26 and arg_168_1.time_ < var_171_16 + var_171_26 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play113071041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 113071041
		arg_173_1.duration_ = 2.73

		local var_173_0 = {
			ja = 1.999999999999,
			ko = 2.733,
			zh = 2.2,
			en = 1.999999999999
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play113071042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action457")
			end

			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_176_2 = arg_173_1.actors_["1038ui_story"]
			local var_176_3 = 0

			if var_176_3 < arg_173_1.time_ and arg_173_1.time_ <= var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect1038ui_story == nil then
				arg_173_1.var_.characterEffect1038ui_story = var_176_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_4 = 0.2

			if var_176_3 <= arg_173_1.time_ and arg_173_1.time_ < var_176_3 + var_176_4 and not isNil(var_176_2) then
				local var_176_5 = (arg_173_1.time_ - var_176_3) / var_176_4

				if arg_173_1.var_.characterEffect1038ui_story and not isNil(var_176_2) then
					arg_173_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_3 + var_176_4 and arg_173_1.time_ < var_176_3 + var_176_4 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect1038ui_story then
				arg_173_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_176_6 = 0
			local var_176_7 = 0.5

			if var_176_6 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				local var_176_8 = "play"
				local var_176_9 = "music"

				arg_173_1:AudioAction(var_176_8, var_176_9, "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_176_10 = ""
				local var_176_11 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

				if var_176_11 ~= "" then
					if arg_173_1.bgmTxt_.text ~= var_176_11 and arg_173_1.bgmTxt_.text ~= "" then
						if arg_173_1.bgmTxt2_.text ~= "" then
							arg_173_1.bgmTxt_.text = arg_173_1.bgmTxt2_.text
						end

						arg_173_1.bgmTxt2_.text = var_176_11

						arg_173_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_173_1.bgmTxt_.text = var_176_11
						arg_173_1.bgmTxt2_.text = var_176_11
					end

					if arg_173_1.bgmTimer then
						arg_173_1.bgmTimer:Stop()

						arg_173_1.bgmTimer = nil
					end

					if arg_173_1.settingData.show_music_name == 1 then
						arg_173_1.musicController:SetSelectedState("show")
						arg_173_1.musicAnimator_:Play("open", 0, 0)

						if arg_173_1.settingData.music_time ~= 0 then
							arg_173_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_173_1.settingData.music_time), function()
								if arg_173_1 == nil or isNil(arg_173_1.bgmTxt_) then
									return
								end

								arg_173_1.musicController:SetSelectedState("hide")
								arg_173_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_176_12 = 0
			local var_176_13 = 0.15

			if var_176_12 < arg_173_1.time_ and arg_173_1.time_ <= var_176_12 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_14 = arg_173_1:FormatText(StoryNameCfg[94].name)

				arg_173_1.leftNameTxt_.text = var_176_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_15 = arg_173_1:GetWordFromCfg(113071041)
				local var_176_16 = arg_173_1:FormatText(var_176_15.content)

				arg_173_1.text_.text = var_176_16

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_17 = 6
				local var_176_18 = utf8.len(var_176_16)
				local var_176_19 = var_176_17 <= 0 and var_176_13 or var_176_13 * (var_176_18 / var_176_17)

				if var_176_19 > 0 and var_176_13 < var_176_19 then
					arg_173_1.talkMaxDuration = var_176_19

					if var_176_19 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_19 + var_176_12
					end
				end

				arg_173_1.text_.text = var_176_16
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071041", "story_v_out_113071.awb") ~= 0 then
					local var_176_20 = manager.audio:GetVoiceLength("story_v_out_113071", "113071041", "story_v_out_113071.awb") / 1000

					if var_176_20 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_20 + var_176_12
					end

					if var_176_15.prefab_name ~= "" and arg_173_1.actors_[var_176_15.prefab_name] ~= nil then
						local var_176_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_15.prefab_name].transform, "story_v_out_113071", "113071041", "story_v_out_113071.awb")

						arg_173_1:RecordAudio("113071041", var_176_21)
						arg_173_1:RecordAudio("113071041", var_176_21)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_113071", "113071041", "story_v_out_113071.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_113071", "113071041", "story_v_out_113071.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_22 = math.max(var_176_13, arg_173_1.talkMaxDuration)

			if var_176_12 <= arg_173_1.time_ and arg_173_1.time_ < var_176_12 + var_176_22 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_12) / var_176_22

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_12 + var_176_22 and arg_173_1.time_ < var_176_12 + var_176_22 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play113071042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 113071042
		arg_178_1.duration_ = 2.33

		local var_178_0 = {
			ja = 2.333,
			ko = 1.999999999999,
			zh = 2,
			en = 1.999999999999
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play113071043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1038ui_story"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect1038ui_story == nil then
				arg_178_1.var_.characterEffect1038ui_story = var_181_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.2

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.characterEffect1038ui_story and not isNil(var_181_0) then
					local var_181_4 = Mathf.Lerp(0, 0.5, var_181_3)

					arg_178_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1038ui_story.fillRatio = var_181_4
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect1038ui_story then
				local var_181_5 = 0.5

				arg_178_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1038ui_story.fillRatio = var_181_5
			end

			local var_181_6 = 0

			if var_181_6 < arg_178_1.time_ and arg_178_1.time_ <= var_181_6 + arg_181_0 then
				arg_178_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action4_1")
			end

			local var_181_7 = 0

			if var_181_7 < arg_178_1.time_ and arg_178_1.time_ <= var_181_7 + arg_181_0 then
				arg_178_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_181_8 = arg_178_1.actors_["1041ui_story"]
			local var_181_9 = 0

			if var_181_9 < arg_178_1.time_ and arg_178_1.time_ <= var_181_9 + arg_181_0 and not isNil(var_181_8) and arg_178_1.var_.characterEffect1041ui_story == nil then
				arg_178_1.var_.characterEffect1041ui_story = var_181_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_10 = 0.2

			if var_181_9 <= arg_178_1.time_ and arg_178_1.time_ < var_181_9 + var_181_10 and not isNil(var_181_8) then
				local var_181_11 = (arg_178_1.time_ - var_181_9) / var_181_10

				if arg_178_1.var_.characterEffect1041ui_story and not isNil(var_181_8) then
					arg_178_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_9 + var_181_10 and arg_178_1.time_ < var_181_9 + var_181_10 + arg_181_0 and not isNil(var_181_8) and arg_178_1.var_.characterEffect1041ui_story then
				arg_178_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_181_12 = arg_178_1.actors_["1041ui_story"].transform
			local var_181_13 = 0

			if var_181_13 < arg_178_1.time_ and arg_178_1.time_ <= var_181_13 + arg_181_0 then
				arg_178_1.var_.moveOldPos1041ui_story = var_181_12.localPosition

				local var_181_14 = "1041ui_story"

				arg_178_1:ShowWeapon(arg_178_1.var_[var_181_14 .. "Animator"].transform, true)
			end

			local var_181_15 = 0.001

			if var_181_13 <= arg_178_1.time_ and arg_178_1.time_ < var_181_13 + var_181_15 then
				local var_181_16 = (arg_178_1.time_ - var_181_13) / var_181_15
				local var_181_17 = Vector3.New(0.7, -1.11, -5.9)

				var_181_12.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1041ui_story, var_181_17, var_181_16)

				local var_181_18 = manager.ui.mainCamera.transform.position - var_181_12.position

				var_181_12.forward = Vector3.New(var_181_18.x, var_181_18.y, var_181_18.z)

				local var_181_19 = var_181_12.localEulerAngles

				var_181_19.z = 0
				var_181_19.x = 0
				var_181_12.localEulerAngles = var_181_19
			end

			if arg_178_1.time_ >= var_181_13 + var_181_15 and arg_178_1.time_ < var_181_13 + var_181_15 + arg_181_0 then
				var_181_12.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_181_20 = manager.ui.mainCamera.transform.position - var_181_12.position

				var_181_12.forward = Vector3.New(var_181_20.x, var_181_20.y, var_181_20.z)

				local var_181_21 = var_181_12.localEulerAngles

				var_181_21.z = 0
				var_181_21.x = 0
				var_181_12.localEulerAngles = var_181_21
			end

			local var_181_22 = 0
			local var_181_23 = 0.1

			if var_181_22 < arg_178_1.time_ and arg_178_1.time_ <= var_181_22 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_24 = arg_178_1:FormatText(StoryNameCfg[208].name)

				arg_178_1.leftNameTxt_.text = var_181_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_25 = arg_178_1:GetWordFromCfg(113071042)
				local var_181_26 = arg_178_1:FormatText(var_181_25.content)

				arg_178_1.text_.text = var_181_26

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_27 = 4
				local var_181_28 = utf8.len(var_181_26)
				local var_181_29 = var_181_27 <= 0 and var_181_23 or var_181_23 * (var_181_28 / var_181_27)

				if var_181_29 > 0 and var_181_23 < var_181_29 then
					arg_178_1.talkMaxDuration = var_181_29

					if var_181_29 + var_181_22 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_29 + var_181_22
					end
				end

				arg_178_1.text_.text = var_181_26
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071042", "story_v_out_113071.awb") ~= 0 then
					local var_181_30 = manager.audio:GetVoiceLength("story_v_out_113071", "113071042", "story_v_out_113071.awb") / 1000

					if var_181_30 + var_181_22 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_30 + var_181_22
					end

					if var_181_25.prefab_name ~= "" and arg_178_1.actors_[var_181_25.prefab_name] ~= nil then
						local var_181_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_25.prefab_name].transform, "story_v_out_113071", "113071042", "story_v_out_113071.awb")

						arg_178_1:RecordAudio("113071042", var_181_31)
						arg_178_1:RecordAudio("113071042", var_181_31)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_113071", "113071042", "story_v_out_113071.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_113071", "113071042", "story_v_out_113071.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_32 = math.max(var_181_23, arg_178_1.talkMaxDuration)

			if var_181_22 <= arg_178_1.time_ and arg_178_1.time_ < var_181_22 + var_181_32 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_22) / var_181_32

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_22 + var_181_32 and arg_178_1.time_ < var_181_22 + var_181_32 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play113071043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 113071043
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play113071044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1041ui_story"].transform
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.var_.moveOldPos1041ui_story = var_185_0.localPosition

				local var_185_2 = "1041ui_story"

				arg_182_1:ShowWeapon(arg_182_1.var_[var_185_2 .. "Animator"].transform, true)
			end

			local var_185_3 = 0.001

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_3 then
				local var_185_4 = (arg_182_1.time_ - var_185_1) / var_185_3
				local var_185_5 = Vector3.New(0, 100, 0)

				var_185_0.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1041ui_story, var_185_5, var_185_4)

				local var_185_6 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_6.x, var_185_6.y, var_185_6.z)

				local var_185_7 = var_185_0.localEulerAngles

				var_185_7.z = 0
				var_185_7.x = 0
				var_185_0.localEulerAngles = var_185_7
			end

			if arg_182_1.time_ >= var_185_1 + var_185_3 and arg_182_1.time_ < var_185_1 + var_185_3 + arg_185_0 then
				var_185_0.localPosition = Vector3.New(0, 100, 0)

				local var_185_8 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_8.x, var_185_8.y, var_185_8.z)

				local var_185_9 = var_185_0.localEulerAngles

				var_185_9.z = 0
				var_185_9.x = 0
				var_185_0.localEulerAngles = var_185_9
			end

			local var_185_10 = arg_182_1.actors_["1038ui_story"].transform
			local var_185_11 = 0

			if var_185_11 < arg_182_1.time_ and arg_182_1.time_ <= var_185_11 + arg_185_0 then
				arg_182_1.var_.moveOldPos1038ui_story = var_185_10.localPosition

				local var_185_12 = "1038ui_story"

				arg_182_1:ShowWeapon(arg_182_1.var_[var_185_12 .. "Animator"].transform, true)
			end

			local var_185_13 = 0.001

			if var_185_11 <= arg_182_1.time_ and arg_182_1.time_ < var_185_11 + var_185_13 then
				local var_185_14 = (arg_182_1.time_ - var_185_11) / var_185_13
				local var_185_15 = Vector3.New(0, 100, 0)

				var_185_10.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1038ui_story, var_185_15, var_185_14)

				local var_185_16 = manager.ui.mainCamera.transform.position - var_185_10.position

				var_185_10.forward = Vector3.New(var_185_16.x, var_185_16.y, var_185_16.z)

				local var_185_17 = var_185_10.localEulerAngles

				var_185_17.z = 0
				var_185_17.x = 0
				var_185_10.localEulerAngles = var_185_17
			end

			if arg_182_1.time_ >= var_185_11 + var_185_13 and arg_182_1.time_ < var_185_11 + var_185_13 + arg_185_0 then
				var_185_10.localPosition = Vector3.New(0, 100, 0)

				local var_185_18 = manager.ui.mainCamera.transform.position - var_185_10.position

				var_185_10.forward = Vector3.New(var_185_18.x, var_185_18.y, var_185_18.z)

				local var_185_19 = var_185_10.localEulerAngles

				var_185_19.z = 0
				var_185_19.x = 0
				var_185_10.localEulerAngles = var_185_19
			end

			local var_185_20 = 0
			local var_185_21 = 0.6

			if var_185_20 < arg_182_1.time_ and arg_182_1.time_ <= var_185_20 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_22 = arg_182_1:GetWordFromCfg(113071043)
				local var_185_23 = arg_182_1:FormatText(var_185_22.content)

				arg_182_1.text_.text = var_185_23

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_24 = 24
				local var_185_25 = utf8.len(var_185_23)
				local var_185_26 = var_185_24 <= 0 and var_185_21 or var_185_21 * (var_185_25 / var_185_24)

				if var_185_26 > 0 and var_185_21 < var_185_26 then
					arg_182_1.talkMaxDuration = var_185_26

					if var_185_26 + var_185_20 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_26 + var_185_20
					end
				end

				arg_182_1.text_.text = var_185_23
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_27 = math.max(var_185_21, arg_182_1.talkMaxDuration)

			if var_185_20 <= arg_182_1.time_ and arg_182_1.time_ < var_185_20 + var_185_27 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_20) / var_185_27

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_20 + var_185_27 and arg_182_1.time_ < var_185_20 + var_185_27 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play113071044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 113071044
		arg_186_1.duration_ = 2.47

		local var_186_0 = {
			ja = 2.466,
			ko = 2.333,
			zh = 2.433,
			en = 2.433
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
			arg_186_1.auto_ = false
		end

		function arg_186_1.playNext_(arg_188_0)
			arg_186_1.onStoryFinished_()
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_189_1 = arg_186_1.actors_["1041ui_story"]
			local var_189_2 = 0

			if var_189_2 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1041ui_story == nil then
				arg_186_1.var_.characterEffect1041ui_story = var_189_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_3 = 0.2

			if var_189_2 <= arg_186_1.time_ and arg_186_1.time_ < var_189_2 + var_189_3 and not isNil(var_189_1) then
				local var_189_4 = (arg_186_1.time_ - var_189_2) / var_189_3

				if arg_186_1.var_.characterEffect1041ui_story and not isNil(var_189_1) then
					arg_186_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_2 + var_189_3 and arg_186_1.time_ < var_189_2 + var_189_3 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1041ui_story then
				arg_186_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_189_5 = arg_186_1.actors_["1041ui_story"].transform
			local var_189_6 = 0

			if var_189_6 < arg_186_1.time_ and arg_186_1.time_ <= var_189_6 + arg_189_0 then
				arg_186_1.var_.moveOldPos1041ui_story = var_189_5.localPosition

				local var_189_7 = "1041ui_story"

				arg_186_1:ShowWeapon(arg_186_1.var_[var_189_7 .. "Animator"].transform, true)
			end

			local var_189_8 = 0.001

			if var_189_6 <= arg_186_1.time_ and arg_186_1.time_ < var_189_6 + var_189_8 then
				local var_189_9 = (arg_186_1.time_ - var_189_6) / var_189_8
				local var_189_10 = Vector3.New(0, -1.11, -5.9)

				var_189_5.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1041ui_story, var_189_10, var_189_9)

				local var_189_11 = manager.ui.mainCamera.transform.position - var_189_5.position

				var_189_5.forward = Vector3.New(var_189_11.x, var_189_11.y, var_189_11.z)

				local var_189_12 = var_189_5.localEulerAngles

				var_189_12.z = 0
				var_189_12.x = 0
				var_189_5.localEulerAngles = var_189_12
			end

			if arg_186_1.time_ >= var_189_6 + var_189_8 and arg_186_1.time_ < var_189_6 + var_189_8 + arg_189_0 then
				var_189_5.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_189_13 = manager.ui.mainCamera.transform.position - var_189_5.position

				var_189_5.forward = Vector3.New(var_189_13.x, var_189_13.y, var_189_13.z)

				local var_189_14 = var_189_5.localEulerAngles

				var_189_14.z = 0
				var_189_14.x = 0
				var_189_5.localEulerAngles = var_189_14
			end

			local var_189_15 = 0

			if var_189_15 < arg_186_1.time_ and arg_186_1.time_ <= var_189_15 + arg_189_0 then
				arg_186_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action8_1")
			end

			local var_189_16 = 0
			local var_189_17 = 0.225

			if var_189_16 < arg_186_1.time_ and arg_186_1.time_ <= var_189_16 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_18 = arg_186_1:FormatText(StoryNameCfg[208].name)

				arg_186_1.leftNameTxt_.text = var_189_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_19 = arg_186_1:GetWordFromCfg(113071044)
				local var_189_20 = arg_186_1:FormatText(var_189_19.content)

				arg_186_1.text_.text = var_189_20

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_21 = 9
				local var_189_22 = utf8.len(var_189_20)
				local var_189_23 = var_189_21 <= 0 and var_189_17 or var_189_17 * (var_189_22 / var_189_21)

				if var_189_23 > 0 and var_189_17 < var_189_23 then
					arg_186_1.talkMaxDuration = var_189_23

					if var_189_23 + var_189_16 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_23 + var_189_16
					end
				end

				arg_186_1.text_.text = var_189_20
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071044", "story_v_out_113071.awb") ~= 0 then
					local var_189_24 = manager.audio:GetVoiceLength("story_v_out_113071", "113071044", "story_v_out_113071.awb") / 1000

					if var_189_24 + var_189_16 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_24 + var_189_16
					end

					if var_189_19.prefab_name ~= "" and arg_186_1.actors_[var_189_19.prefab_name] ~= nil then
						local var_189_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_19.prefab_name].transform, "story_v_out_113071", "113071044", "story_v_out_113071.awb")

						arg_186_1:RecordAudio("113071044", var_189_25)
						arg_186_1:RecordAudio("113071044", var_189_25)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_113071", "113071044", "story_v_out_113071.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_113071", "113071044", "story_v_out_113071.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_26 = math.max(var_189_17, arg_186_1.talkMaxDuration)

			if var_189_16 <= arg_186_1.time_ and arg_186_1.time_ < var_189_16 + var_189_26 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_16) / var_189_26

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_16 + var_189_26 and arg_186_1.time_ < var_189_16 + var_189_26 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F01",
		"TextureConfig/Background/OM0110"
	},
	voices = {
		"story_v_out_113071.awb"
	}
}
