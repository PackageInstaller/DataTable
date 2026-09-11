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
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_0 = 2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_0 then
				local var_4_1 = Color.New(0, 0, 0)

				var_4_1.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - 0) / var_4_0)
				arg_1_1.mask_.color = var_4_1
			end

			if arg_1_1.time_ >= 0 + var_4_0 and arg_1_1.time_ < 0 + var_4_0 + arg_4_0 then
				local var_4_2 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_2.a = 0
				arg_1_1.mask_.color = var_4_2
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_4_8 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_8 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_8

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_8
						arg_1_1.bgmTxt2_.text = var_4_8
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

			local var_4_9 = 2
			local var_4_10 = 0.275

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_11 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_11:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_12 = arg_1_1:GetWordFromCfg(113071001)
				local var_4_13 = arg_1_1:FormatText(var_4_12.content)

				arg_1_1.text_.text = var_4_13

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_15 = 11 <= 0 and var_4_10 or var_4_10 * (utf8.len(var_4_13) / 11)

				if (11 <= 0 and var_4_10 or var_4_10 * (utf8.len(var_4_13) / 11)) > 0 and var_4_10 < var_4_15 then
					arg_1_1.talkMaxDuration = var_4_15
					var_4_9 = var_4_9 + 0.3

					if var_4_15 + var_4_9 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_15 + var_4_9
					end
				end

				arg_1_1.text_.text = var_4_13
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071001", "story_v_out_113071.awb") ~= 0 then
					local var_4_16 = manager.audio:GetVoiceLength("story_v_out_113071", "113071001", "story_v_out_113071.awb") / 1000

					if var_4_16 + var_4_9 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_9
					end

					if var_4_12.prefab_name ~= "" and arg_1_1.actors_[var_4_12.prefab_name] ~= nil then
						local var_4_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_12.prefab_name].transform, "story_v_out_113071", "113071001", "story_v_out_113071.awb")

						arg_1_1:RecordAudio("113071001", var_4_17)
						arg_1_1:RecordAudio("113071001", var_4_17)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113071", "113071001", "story_v_out_113071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113071", "113071001", "story_v_out_113071.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_18 = var_4_9 + 0.3
			local var_4_19 = math.max(var_4_10, arg_1_1.talkMaxDuration)

			if var_4_9 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_18) / var_4_19

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
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
			local var_12_0 = 0.45

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(113071002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 18 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 18)

				if (18 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 18)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071002", "story_v_out_113071.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_113071", "113071002", "story_v_out_113071.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_113071", "113071002", "story_v_out_113071.awb")

						arg_9_1:RecordAudio("113071002", var_12_6)
						arg_9_1:RecordAudio("113071002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_113071", "113071002", "story_v_out_113071.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_113071", "113071002", "story_v_out_113071.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
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
			local var_16_0 = 0.575

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(113071003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 23 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 23)

				if (23 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 23)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071003", "story_v_out_113071.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_113071", "113071003", "story_v_out_113071.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_113071", "113071003", "story_v_out_113071.awb")

						arg_13_1:RecordAudio("113071003", var_16_6)
						arg_13_1:RecordAudio("113071003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_113071", "113071003", "story_v_out_113071.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_113071", "113071003", "story_v_out_113071.awb")
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
			local var_20_0 = 0.625

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(113071004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 25 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 25)

				if (25 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 25)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071004", "story_v_out_113071.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_113071", "113071004", "story_v_out_113071.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_113071", "113071004", "story_v_out_113071.awb")

						arg_17_1:RecordAudio("113071004", var_20_6)
						arg_17_1:RecordAudio("113071004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_113071", "113071004", "story_v_out_113071.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_113071", "113071004", "story_v_out_113071.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
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
			if arg_21_1.bgs_.F01 == nil then
				local var_24_0 = Object.Instantiate(arg_21_1.paintGo_)

				var_24_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01")
				var_24_0.name = "F01"
				var_24_0.transform.parent = arg_21_1.stage_.transform
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.bgs_.F01 = var_24_0
			end

			if 2 < arg_21_1.time_ and arg_21_1.time_ <= 2 + arg_24_0 then
				local var_24_1 = arg_21_1.bgs_.F01

				arg_21_1.bgs_.F01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_24_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_2 = var_24_1:GetComponent("SpriteRenderer")

				if var_24_2 and var_24_2.sprite then
					local var_24_3 = 2 * (var_24_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_24_1.transform.localScale = Vector3.New(var_24_3 / var_24_2.sprite.bounds.size.y < var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x and var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x or var_24_3 / var_24_2.sprite.bounds.size.y, var_24_3 / var_24_2.sprite.bounds.size.y < var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x and var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x or var_24_3 / var_24_2.sprite.bounds.size.y, 0)
				end

				for iter_24_0, iter_24_1 in pairs(arg_21_1.bgs_) do
					if iter_24_0 ~= "F01" then
						iter_24_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_24_4 = 0

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_5 = 2

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_5 then
				local var_24_6 = Color.New(0, 0, 0)

				var_24_6.a = Mathf.Lerp(0, 1, (arg_21_1.time_ - var_24_4) / var_24_5)
				arg_21_1.mask_.color = var_24_6
			end

			if arg_21_1.time_ >= var_24_4 + var_24_5 and arg_21_1.time_ < var_24_4 + var_24_5 + arg_24_0 then
				local var_24_7 = Color.New(0, 0, 0)

				var_24_7.a = 1
				arg_21_1.mask_.color = var_24_7
			end

			local var_24_8 = 2

			if 2 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_9 = 2

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_9 then
				local var_24_10 = Color.New(0, 0, 0)

				var_24_10.a = Mathf.Lerp(1, 0, (arg_21_1.time_ - var_24_8) / var_24_9)
				arg_21_1.mask_.color = var_24_10
			end

			if arg_21_1.time_ >= var_24_8 + var_24_9 and arg_21_1.time_ < var_24_8 + var_24_9 + arg_24_0 then
				local var_24_11 = Color.New(0, 0, 0)

				arg_21_1.mask_.enabled = false
				var_24_11.a = 0
				arg_21_1.mask_.color = var_24_11
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_12 = 4
			local var_24_13 = 0.1

			if 4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_14 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_14:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[208].name)

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

				local var_24_15 = arg_21_1:GetWordFromCfg(113071005)
				local var_24_16 = arg_21_1:FormatText(var_24_15.content)

				arg_21_1.text_.text = var_24_16

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_18 = 4 <= 0 and var_24_13 or var_24_13 * (utf8.len(var_24_16) / 4)

				if (4 <= 0 and var_24_13 or var_24_13 * (utf8.len(var_24_16) / 4)) > 0 and var_24_13 < var_24_18 then
					arg_21_1.talkMaxDuration = var_24_18
					var_24_12 = var_24_12 + 0.3

					if var_24_18 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_18 + var_24_12
					end
				end

				arg_21_1.text_.text = var_24_16
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071005", "story_v_out_113071.awb") ~= 0 then
					local var_24_19 = manager.audio:GetVoiceLength("story_v_out_113071", "113071005", "story_v_out_113071.awb") / 1000

					if var_24_19 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_12
					end

					if var_24_15.prefab_name ~= "" and arg_21_1.actors_[var_24_15.prefab_name] ~= nil then
						local var_24_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_15.prefab_name].transform, "story_v_out_113071", "113071005", "story_v_out_113071.awb")

						arg_21_1:RecordAudio("113071005", var_24_20)
						arg_21_1:RecordAudio("113071005", var_24_20)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_113071", "113071005", "story_v_out_113071.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_113071", "113071005", "story_v_out_113071.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_21 = var_24_12 + 0.3
			local var_24_22 = math.max(var_24_13, arg_21_1.talkMaxDuration)

			if var_24_12 + 0.3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_22 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_21) / var_24_22

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_21 + var_24_22 and arg_21_1.time_ < var_24_21 + var_24_22 + arg_24_0 then
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
			if arg_27_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_30_0 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_27_1.stage_.transform)

				var_30_0.name = "1038ui_story"
				var_30_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_["1038ui_story"] = var_30_0

				local var_30_1 = var_30_0:GetComponentInChildren(typeof(CharacterEffect))

				var_30_1.enabled = true

				local var_30_2 = GameObjectTools.GetOrAddComponent(var_30_0, typeof(DynamicBoneHelper))

				if var_30_2 then
					var_30_2:EnableDynamicBone(false)
				end

				arg_27_1:ShowWeapon(var_30_1.transform, false)

				arg_27_1.var_["1038ui_story" .. "Animator"] = var_30_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_27_1.var_["1038ui_story" .. "Animator"].applyRootMotion = true
				arg_27_1.var_["1038ui_story" .. "LipSync"] = var_30_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_30_3 = arg_27_1.actors_["1038ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1038ui_story = var_30_3.localPosition
			end

			local var_30_4 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				var_30_3.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1038ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_27_1.time_ - 0) / var_30_4)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				var_30_3.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_30_5 = arg_27_1.actors_["1038ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect1038ui_story == nil then
				arg_27_1.var_.characterEffect1038ui_story = var_30_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_6 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_6 and not isNil(var_30_5) then
				if arg_27_1.var_.characterEffect1038ui_story and not isNil(var_30_5) then
					arg_27_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_6 and arg_27_1.time_ < 0 + var_30_6 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect1038ui_story then
				arg_27_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_30_8 = 0
			local var_30_9 = 0.25

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_10 = arg_27_1:GetWordFromCfg(113071006)
				local var_30_11 = arg_27_1:FormatText(var_30_10.content)

				arg_27_1.text_.text = var_30_11

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_13 = 10 <= 0 and var_30_9 or var_30_9 * (utf8.len(var_30_11) / 10)

				if (10 <= 0 and var_30_9 or var_30_9 * (utf8.len(var_30_11) / 10)) > 0 and var_30_9 < var_30_13 then
					arg_27_1.talkMaxDuration = var_30_13

					if var_30_13 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_13 + var_30_8
					end
				end

				arg_27_1.text_.text = var_30_11
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071006", "story_v_out_113071.awb") ~= 0 then
					local var_30_14 = manager.audio:GetVoiceLength("story_v_out_113071", "113071006", "story_v_out_113071.awb") / 1000

					if var_30_14 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_14 + var_30_8
					end

					if var_30_10.prefab_name ~= "" and arg_27_1.actors_[var_30_10.prefab_name] ~= nil then
						local var_30_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_10.prefab_name].transform, "story_v_out_113071", "113071006", "story_v_out_113071.awb")

						arg_27_1:RecordAudio("113071006", var_30_15)
						arg_27_1:RecordAudio("113071006", var_30_15)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_113071", "113071006", "story_v_out_113071.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_113071", "113071006", "story_v_out_113071.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_16 = math.max(var_30_9, arg_27_1.talkMaxDuration)

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_16 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_8) / var_30_16

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_8 + var_30_16 and arg_27_1.time_ < var_30_8 + var_30_16 + arg_30_0 then
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
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1038ui_story"]) and arg_31_1.var_.characterEffect1038ui_story == nil then
				arg_31_1.var_.characterEffect1038ui_story = arg_31_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1038ui_story"]) then
				if arg_31_1.var_.characterEffect1038ui_story and not isNil(arg_31_1.actors_["1038ui_story"]) then
					arg_31_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_0)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1038ui_story"]) and arg_31_1.var_.characterEffect1038ui_story then
				arg_31_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_34_1 = "1041ui_story"

			if arg_31_1.actors_["1041ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1041ui_story"))) then
				local var_34_2 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_31_1.stage_.transform)

				var_34_2.name = var_34_1
				var_34_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_[var_34_1] = var_34_2

				local var_34_3 = var_34_2:GetComponentInChildren(typeof(CharacterEffect))

				var_34_3.enabled = true

				local var_34_4 = GameObjectTools.GetOrAddComponent(var_34_2, typeof(DynamicBoneHelper))

				if var_34_4 then
					var_34_4:EnableDynamicBone(false)
				end

				arg_31_1:ShowWeapon(var_34_3.transform, false)

				arg_31_1.var_[var_34_1 .. "Animator"] = var_34_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_31_1.var_[var_34_1 .. "Animator"].applyRootMotion = true
				arg_31_1.var_[var_34_1 .. "LipSync"] = var_34_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_34_5 = arg_31_1.actors_["1041ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1041ui_story = var_34_5.localPosition
			end

			local var_34_6 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_6 then
				var_34_5.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1041ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_31_1.time_ - 0) / var_34_6)
				var_34_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_5.position).x, (manager.ui.mainCamera.transform.position - var_34_5.position).y, (manager.ui.mainCamera.transform.position - var_34_5.position).z)
				var_34_5.localEulerAngles.z = 0
				var_34_5.localEulerAngles.x = 0
				var_34_5.localEulerAngles = var_34_5.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_6 and arg_31_1.time_ < 0 + var_34_6 + arg_34_0 then
				var_34_5.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_34_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_5.position).x, (manager.ui.mainCamera.transform.position - var_34_5.position).y, (manager.ui.mainCamera.transform.position - var_34_5.position).z)
				var_34_5.localEulerAngles.z = 0
				var_34_5.localEulerAngles.x = 0
				var_34_5.localEulerAngles = var_34_5.localEulerAngles
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_34_7 = arg_31_1.actors_["1041ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_7) and arg_31_1.var_.characterEffect1041ui_story == nil then
				arg_31_1.var_.characterEffect1041ui_story = var_34_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_8 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_8 and not isNil(var_34_7) then
				if arg_31_1.var_.characterEffect1041ui_story and not isNil(var_34_7) then
					arg_31_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_8 and arg_31_1.time_ < 0 + var_34_8 + arg_34_0 and not isNil(var_34_7) and arg_31_1.var_.characterEffect1041ui_story then
				arg_31_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_34_10 = 0
			local var_34_11 = 0.25

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_12 = arg_31_1:GetWordFromCfg(113071007)
				local var_34_13 = arg_31_1:FormatText(var_34_12.content)

				arg_31_1.text_.text = var_34_13

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_15 = 10 <= 0 and var_34_11 or var_34_11 * (utf8.len(var_34_13) / 10)

				if (10 <= 0 and var_34_11 or var_34_11 * (utf8.len(var_34_13) / 10)) > 0 and var_34_11 < var_34_15 then
					arg_31_1.talkMaxDuration = var_34_15

					if var_34_15 + var_34_10 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_15 + var_34_10
					end
				end

				arg_31_1.text_.text = var_34_13
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071007", "story_v_out_113071.awb") ~= 0 then
					local var_34_16 = manager.audio:GetVoiceLength("story_v_out_113071", "113071007", "story_v_out_113071.awb") / 1000

					if var_34_16 + var_34_10 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_16 + var_34_10
					end

					if var_34_12.prefab_name ~= "" and arg_31_1.actors_[var_34_12.prefab_name] ~= nil then
						local var_34_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_12.prefab_name].transform, "story_v_out_113071", "113071007", "story_v_out_113071.awb")

						arg_31_1:RecordAudio("113071007", var_34_17)
						arg_31_1:RecordAudio("113071007", var_34_17)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_113071", "113071007", "story_v_out_113071.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_113071", "113071007", "story_v_out_113071.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_18 = math.max(var_34_11, arg_31_1.talkMaxDuration)

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_18 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_10) / var_34_18

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_10 + var_34_18 and arg_31_1.time_ < var_34_10 + var_34_18 + arg_34_0 then
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
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1041ui_story"]) and arg_35_1.var_.characterEffect1041ui_story == nil then
				arg_35_1.var_.characterEffect1041ui_story = arg_35_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_0 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1041ui_story"]) then
				if arg_35_1.var_.characterEffect1041ui_story and not isNil(arg_35_1.actors_["1041ui_story"]) then
					arg_35_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_0)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1041ui_story"]) and arg_35_1.var_.characterEffect1041ui_story then
				arg_35_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_38_1 = 0
			local var_38_2 = 1.4

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_3 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(113071008).content)

				arg_35_1.text_.text = var_38_3

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 56 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_3) / 56)

				if (56 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_3) / 56)) > 0 and var_38_2 < var_38_5 then
					arg_35_1.talkMaxDuration = var_38_5

					if var_38_5 + var_38_1 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + var_38_1
					end
				end

				arg_35_1.text_.text = var_38_3
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_6 = math.max(var_38_2, arg_35_1.talkMaxDuration)

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_6 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_1) / var_38_6

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_1 + var_38_6 and arg_35_1.time_ < var_38_1 + var_38_6 + arg_38_0 then
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
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_42_0 = arg_39_1.actors_["1041ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1041ui_story == nil then
				arg_39_1.var_.characterEffect1041ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_1 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_1 and not isNil(var_42_0) then
				if arg_39_1.var_.characterEffect1041ui_story and not isNil(var_42_0) then
					arg_39_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_1 and arg_39_1.time_ < 0 + var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1041ui_story then
				arg_39_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_42_3 = 0
			local var_42_4 = 0.225

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_3 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_5 = arg_39_1:GetWordFromCfg(113071009)
				local var_42_6 = arg_39_1:FormatText(var_42_5.content)

				arg_39_1.text_.text = var_42_6

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_8 = 9 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_6) / 9)

				if (9 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_6) / 9)) > 0 and var_42_4 < var_42_8 then
					arg_39_1.talkMaxDuration = var_42_8

					if var_42_8 + var_42_3 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_3
					end
				end

				arg_39_1.text_.text = var_42_6
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071009", "story_v_out_113071.awb") ~= 0 then
					local var_42_9 = manager.audio:GetVoiceLength("story_v_out_113071", "113071009", "story_v_out_113071.awb") / 1000

					if var_42_9 + var_42_3 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_3
					end

					if var_42_5.prefab_name ~= "" and arg_39_1.actors_[var_42_5.prefab_name] ~= nil then
						local var_42_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_5.prefab_name].transform, "story_v_out_113071", "113071009", "story_v_out_113071.awb")

						arg_39_1:RecordAudio("113071009", var_42_10)
						arg_39_1:RecordAudio("113071009", var_42_10)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_113071", "113071009", "story_v_out_113071.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_113071", "113071009", "story_v_out_113071.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_11 = math.max(var_42_4, arg_39_1.talkMaxDuration)

			if var_42_3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_3 + var_42_11 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_3) / var_42_11

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_3 + var_42_11 and arg_39_1.time_ < var_42_3 + var_42_11 + arg_42_0 then
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
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1041ui_story"]) and arg_43_1.var_.characterEffect1041ui_story == nil then
				arg_43_1.var_.characterEffect1041ui_story = arg_43_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1041ui_story"]) then
				if arg_43_1.var_.characterEffect1041ui_story and not isNil(arg_43_1.actors_["1041ui_story"]) then
					arg_43_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_0)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1041ui_story"]) and arg_43_1.var_.characterEffect1041ui_story then
				arg_43_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_46_1 = arg_43_1.actors_["1038ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1038ui_story == nil then
				arg_43_1.var_.characterEffect1038ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1038ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1038ui_story then
				arg_43_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_46_4 = 0
			local var_46_5 = 0.35

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(113071010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 14 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 14)

				if (14 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 14)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071010", "story_v_out_113071.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_out_113071", "113071010", "story_v_out_113071.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_out_113071", "113071010", "story_v_out_113071.awb")

						arg_43_1:RecordAudio("113071010", var_46_11)
						arg_43_1:RecordAudio("113071010", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_113071", "113071010", "story_v_out_113071.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_113071", "113071010", "story_v_out_113071.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
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
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1038ui_story = arg_47_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1038ui_story"].transform.position).z)
				arg_47_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1038ui_story"].transform.localEulerAngles = arg_47_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1038ui_story"].transform.position).z)
				arg_47_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1038ui_story"].transform.localEulerAngles = arg_47_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["1041ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1041ui_story = var_50_1.localPosition
			end

			local var_50_2 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 then
				var_50_1.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_2)
				var_50_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_1.position).x, (manager.ui.mainCamera.transform.position - var_50_1.position).y, (manager.ui.mainCamera.transform.position - var_50_1.position).z)
				var_50_1.localEulerAngles.z = 0
				var_50_1.localEulerAngles.x = 0
				var_50_1.localEulerAngles = var_50_1.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 then
				var_50_1.localPosition = Vector3.New(0, 100, 0)
				var_50_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_1.position).x, (manager.ui.mainCamera.transform.position - var_50_1.position).y, (manager.ui.mainCamera.transform.position - var_50_1.position).z)
				var_50_1.localEulerAngles.z = 0
				var_50_1.localEulerAngles.x = 0
				var_50_1.localEulerAngles = var_50_1.localEulerAngles
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:AudioAction("play", "effect", "se_story_10", "se_story_10_boiling_loop", "")
			end

			local var_50_4 = 0
			local var_50_5 = 0.75

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(113071011).content)

				arg_47_1.text_.text = var_50_6

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_8 = 30 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_6) / 30)

				if (30 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_6) / 30)) > 0 and var_50_5 < var_50_8 then
					arg_47_1.talkMaxDuration = var_50_8

					if var_50_8 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_6
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_9 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_9 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_4) / var_50_9

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_4 + var_50_9 and arg_47_1.time_ < var_50_4 + var_50_9 + arg_50_0 then
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
			local var_54_0 = 0.75

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

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(113071012).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 30 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 30)

				if (30 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 30)) > 0 and var_54_0 < var_54_3 then
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
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1038ui_story = arg_55_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1038ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1038ui_story"].transform.position).z)
				arg_55_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1038ui_story"].transform.localEulerAngles = arg_55_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				arg_55_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1038ui_story"].transform.position).z)
				arg_55_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1038ui_story"].transform.localEulerAngles = arg_55_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_58_1 = arg_55_1.actors_["1038ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1038ui_story == nil then
				arg_55_1.var_.characterEffect1038ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect1038ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1038ui_story then
				arg_55_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_58_4 = 0
			local var_58_5 = 0.4

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(113071013)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 16 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 16)

				if (16 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 16)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071013", "story_v_out_113071.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_out_113071", "113071013", "story_v_out_113071.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_out_113071", "113071013", "story_v_out_113071.awb")

						arg_55_1:RecordAudio("113071013", var_58_11)
						arg_55_1:RecordAudio("113071013", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_113071", "113071013", "story_v_out_113071.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_113071", "113071013", "story_v_out_113071.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_12 and arg_55_1.time_ < var_58_4 + var_58_12 + arg_58_0 then
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
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1038ui_story"]) and arg_59_1.var_.characterEffect1038ui_story == nil then
				arg_59_1.var_.characterEffect1038ui_story = arg_59_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1038ui_story"]) then
				if arg_59_1.var_.characterEffect1038ui_story and not isNil(arg_59_1.actors_["1038ui_story"]) then
					arg_59_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1038ui_story"]) and arg_59_1.var_.characterEffect1038ui_story then
				arg_59_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_62_1 = arg_59_1.actors_["1041ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1041ui_story == nil then
				arg_59_1.var_.characterEffect1041ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect1041ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1041ui_story then
				arg_59_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_62_4 = arg_59_1.actors_["1041ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1041ui_story = var_62_4.localPosition
			end

			local var_62_5 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_5 then
				var_62_4.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1041ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_59_1.time_ - 0) / var_62_5)
				var_62_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_4.position).x, (manager.ui.mainCamera.transform.position - var_62_4.position).y, (manager.ui.mainCamera.transform.position - var_62_4.position).z)
				var_62_4.localEulerAngles.z = 0
				var_62_4.localEulerAngles.x = 0
				var_62_4.localEulerAngles = var_62_4.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_5 and arg_59_1.time_ < 0 + var_62_5 + arg_62_0 then
				var_62_4.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_62_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_4.position).x, (manager.ui.mainCamera.transform.position - var_62_4.position).y, (manager.ui.mainCamera.transform.position - var_62_4.position).z)
				var_62_4.localEulerAngles.z = 0
				var_62_4.localEulerAngles.x = 0
				var_62_4.localEulerAngles = var_62_4.localEulerAngles
			end

			local var_62_6 = 0
			local var_62_7 = 0.125

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_8 = arg_59_1:GetWordFromCfg(113071014)
				local var_62_9 = arg_59_1:FormatText(var_62_8.content)

				arg_59_1.text_.text = var_62_9

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 5 <= 0 and var_62_7 or var_62_7 * (utf8.len(var_62_9) / 5)

				if (5 <= 0 and var_62_7 or var_62_7 * (utf8.len(var_62_9) / 5)) > 0 and var_62_7 < var_62_11 then
					arg_59_1.talkMaxDuration = var_62_11

					if var_62_11 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_11 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_9
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071014", "story_v_out_113071.awb") ~= 0 then
					local var_62_12 = manager.audio:GetVoiceLength("story_v_out_113071", "113071014", "story_v_out_113071.awb") / 1000

					if var_62_12 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_6
					end

					if var_62_8.prefab_name ~= "" and arg_59_1.actors_[var_62_8.prefab_name] ~= nil then
						local var_62_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_8.prefab_name].transform, "story_v_out_113071", "113071014", "story_v_out_113071.awb")

						arg_59_1:RecordAudio("113071014", var_62_13)
						arg_59_1:RecordAudio("113071014", var_62_13)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_113071", "113071014", "story_v_out_113071.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_113071", "113071014", "story_v_out_113071.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_14 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_14 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_14

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_14 and arg_59_1.time_ < var_62_6 + var_62_14 + arg_62_0 then
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
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1038ui_story"]) and arg_63_1.var_.characterEffect1038ui_story == nil then
				arg_63_1.var_.characterEffect1038ui_story = arg_63_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1038ui_story"]) then
				if arg_63_1.var_.characterEffect1038ui_story and not isNil(arg_63_1.actors_["1038ui_story"]) then
					arg_63_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1038ui_story"]) and arg_63_1.var_.characterEffect1038ui_story then
				arg_63_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_66_2 = arg_63_1.actors_["1041ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.characterEffect1041ui_story == nil then
				arg_63_1.var_.characterEffect1041ui_story = var_66_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_3 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.characterEffect1041ui_story and not isNil(var_66_2) then
					arg_63_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_3)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.characterEffect1041ui_story then
				arg_63_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_66_4 = 0
			local var_66_5 = 0.6

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(113071015)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 24 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 24)

				if (24 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 24)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071015", "story_v_out_113071.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_out_113071", "113071015", "story_v_out_113071.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_out_113071", "113071015", "story_v_out_113071.awb")

						arg_63_1:RecordAudio("113071015", var_66_11)
						arg_63_1:RecordAudio("113071015", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_113071", "113071015", "story_v_out_113071.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_113071", "113071015", "story_v_out_113071.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_12 and arg_63_1.time_ < var_66_4 + var_66_12 + arg_66_0 then
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
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1038ui_story"]) and arg_67_1.var_.characterEffect1038ui_story == nil then
				arg_67_1.var_.characterEffect1038ui_story = arg_67_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1038ui_story"]) then
				if arg_67_1.var_.characterEffect1038ui_story and not isNil(arg_67_1.actors_["1038ui_story"]) then
					arg_67_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1038ui_story"]) and arg_67_1.var_.characterEffect1038ui_story then
				arg_67_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_70_1 = arg_67_1.actors_["1041ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1041ui_story == nil then
				arg_67_1.var_.characterEffect1041ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1041ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1041ui_story then
				arg_67_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_70_4 = 0
			local var_70_5 = 0.625

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_6 = arg_67_1:GetWordFromCfg(113071016)
				local var_70_7 = arg_67_1:FormatText(var_70_6.content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 25 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 25)

				if (25 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 25)) > 0 and var_70_5 < var_70_9 then
					arg_67_1.talkMaxDuration = var_70_9

					if var_70_9 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071016", "story_v_out_113071.awb") ~= 0 then
					local var_70_10 = manager.audio:GetVoiceLength("story_v_out_113071", "113071016", "story_v_out_113071.awb") / 1000

					if var_70_10 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_4
					end

					if var_70_6.prefab_name ~= "" and arg_67_1.actors_[var_70_6.prefab_name] ~= nil then
						local var_70_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_6.prefab_name].transform, "story_v_out_113071", "113071016", "story_v_out_113071.awb")

						arg_67_1:RecordAudio("113071016", var_70_11)
						arg_67_1:RecordAudio("113071016", var_70_11)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_113071", "113071016", "story_v_out_113071.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_113071", "113071016", "story_v_out_113071.awb")
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
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1041ui_story"]) and arg_71_1.var_.characterEffect1041ui_story == nil then
				arg_71_1.var_.characterEffect1041ui_story = arg_71_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1041ui_story"]) then
				if arg_71_1.var_.characterEffect1041ui_story and not isNil(arg_71_1.actors_["1041ui_story"]) then
					arg_71_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_0)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1041ui_story"]) and arg_71_1.var_.characterEffect1041ui_story then
				arg_71_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_74_1 = arg_71_1.actors_["1038ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1038ui_story == nil then
				arg_71_1.var_.characterEffect1038ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1038ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1038ui_story then
				arg_71_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_74_4 = 0
			local var_74_5 = 0.45

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(113071017)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 18 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 18)

				if (18 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 18)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071017", "story_v_out_113071.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_113071", "113071017", "story_v_out_113071.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_113071", "113071017", "story_v_out_113071.awb")

						arg_71_1:RecordAudio("113071017", var_74_11)
						arg_71_1:RecordAudio("113071017", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_113071", "113071017", "story_v_out_113071.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_113071", "113071017", "story_v_out_113071.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
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
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1041ui_story"]) and arg_75_1.var_.characterEffect1041ui_story == nil then
				arg_75_1.var_.characterEffect1041ui_story = arg_75_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1041ui_story"]) then
				if arg_75_1.var_.characterEffect1041ui_story and not isNil(arg_75_1.actors_["1041ui_story"]) then
					arg_75_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1041ui_story"]) and arg_75_1.var_.characterEffect1041ui_story then
				arg_75_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_78_2 = arg_75_1.actors_["1038ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.characterEffect1038ui_story == nil then
				arg_75_1.var_.characterEffect1038ui_story = var_78_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_3 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_2) then
				if arg_75_1.var_.characterEffect1038ui_story and not isNil(var_78_2) then
					arg_75_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_3)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.characterEffect1038ui_story then
				arg_75_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_2")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_78_4 = 0
			local var_78_5 = 0.7

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_6 = arg_75_1:GetWordFromCfg(113071018)
				local var_78_7 = arg_75_1:FormatText(var_78_6.content)

				arg_75_1.text_.text = var_78_7

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_9 = 28 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 28)

				if (28 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 28)) > 0 and var_78_5 < var_78_9 then
					arg_75_1.talkMaxDuration = var_78_9

					if var_78_9 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_4
					end
				end

				arg_75_1.text_.text = var_78_7
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071018", "story_v_out_113071.awb") ~= 0 then
					local var_78_10 = manager.audio:GetVoiceLength("story_v_out_113071", "113071018", "story_v_out_113071.awb") / 1000

					if var_78_10 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_4
					end

					if var_78_6.prefab_name ~= "" and arg_75_1.actors_[var_78_6.prefab_name] ~= nil then
						local var_78_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_6.prefab_name].transform, "story_v_out_113071", "113071018", "story_v_out_113071.awb")

						arg_75_1:RecordAudio("113071018", var_78_11)
						arg_75_1:RecordAudio("113071018", var_78_11)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_113071", "113071018", "story_v_out_113071.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_113071", "113071018", "story_v_out_113071.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_12 = math.max(var_78_5, arg_75_1.talkMaxDuration)

			if var_78_4 <= arg_75_1.time_ and arg_75_1.time_ < var_78_4 + var_78_12 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_4) / var_78_12

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_4 + var_78_12 and arg_75_1.time_ < var_78_4 + var_78_12 + arg_78_0 then
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
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1041ui_story"]) and arg_79_1.var_.characterEffect1041ui_story == nil then
				arg_79_1.var_.characterEffect1041ui_story = arg_79_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1041ui_story"]) then
				if arg_79_1.var_.characterEffect1041ui_story and not isNil(arg_79_1.actors_["1041ui_story"]) then
					arg_79_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_0)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1041ui_story"]) and arg_79_1.var_.characterEffect1041ui_story then
				arg_79_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_82_1 = arg_79_1.actors_["1038ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1038ui_story == nil then
				arg_79_1.var_.characterEffect1038ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect1038ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1038ui_story then
				arg_79_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_82_4 = 0
			local var_82_5 = 0.575

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(113071019)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 23 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 23)

				if (23 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 23)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071019", "story_v_out_113071.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_113071", "113071019", "story_v_out_113071.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_113071", "113071019", "story_v_out_113071.awb")

						arg_79_1:RecordAudio("113071019", var_82_11)
						arg_79_1:RecordAudio("113071019", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_113071", "113071019", "story_v_out_113071.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_113071", "113071019", "story_v_out_113071.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
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
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1038ui_story"]) and arg_83_1.var_.characterEffect1038ui_story == nil then
				arg_83_1.var_.characterEffect1038ui_story = arg_83_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1038ui_story"]) then
				if arg_83_1.var_.characterEffect1038ui_story and not isNil(arg_83_1.actors_["1038ui_story"]) then
					arg_83_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1038ui_story"]) and arg_83_1.var_.characterEffect1038ui_story then
				arg_83_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action6_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_86_1 = arg_83_1.actors_["1041ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1041ui_story == nil then
				arg_83_1.var_.characterEffect1041ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect1041ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1041ui_story then
				arg_83_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_86_4 = 0
			local var_86_5 = 0.65

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_6 = arg_83_1:GetWordFromCfg(113071020)
				local var_86_7 = arg_83_1:FormatText(var_86_6.content)

				arg_83_1.text_.text = var_86_7

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_9 = 26 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 26)

				if (26 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 26)) > 0 and var_86_5 < var_86_9 then
					arg_83_1.talkMaxDuration = var_86_9

					if var_86_9 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_7
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071020", "story_v_out_113071.awb") ~= 0 then
					local var_86_10 = manager.audio:GetVoiceLength("story_v_out_113071", "113071020", "story_v_out_113071.awb") / 1000

					if var_86_10 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_4
					end

					if var_86_6.prefab_name ~= "" and arg_83_1.actors_[var_86_6.prefab_name] ~= nil then
						local var_86_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_6.prefab_name].transform, "story_v_out_113071", "113071020", "story_v_out_113071.awb")

						arg_83_1:RecordAudio("113071020", var_86_11)
						arg_83_1:RecordAudio("113071020", var_86_11)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_113071", "113071020", "story_v_out_113071.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_113071", "113071020", "story_v_out_113071.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_12 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_12 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_4) / var_86_12

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_4 + var_86_12 and arg_83_1.time_ < var_86_4 + var_86_12 + arg_86_0 then
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
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1041ui_story"]) and arg_87_1.var_.characterEffect1041ui_story == nil then
				arg_87_1.var_.characterEffect1041ui_story = arg_87_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1041ui_story"]) then
				if arg_87_1.var_.characterEffect1041ui_story and not isNil(arg_87_1.actors_["1041ui_story"]) then
					arg_87_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_0)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1041ui_story"]) and arg_87_1.var_.characterEffect1041ui_story then
				arg_87_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_90_1 = arg_87_1.actors_["1038ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1038ui_story == nil then
				arg_87_1.var_.characterEffect1038ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1038ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1038ui_story then
				arg_87_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_90_4 = 0
			local var_90_5 = 0.775

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:GetWordFromCfg(113071021)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 31 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 31)

				if (31 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 31)) > 0 and var_90_5 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071021", "story_v_out_113071.awb") ~= 0 then
					local var_90_10 = manager.audio:GetVoiceLength("story_v_out_113071", "113071021", "story_v_out_113071.awb") / 1000

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end

					if var_90_6.prefab_name ~= "" and arg_87_1.actors_[var_90_6.prefab_name] ~= nil then
						local var_90_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_6.prefab_name].transform, "story_v_out_113071", "113071021", "story_v_out_113071.awb")

						arg_87_1:RecordAudio("113071021", var_90_11)
						arg_87_1:RecordAudio("113071021", var_90_11)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_113071", "113071021", "story_v_out_113071.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_113071", "113071021", "story_v_out_113071.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_12 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_12 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_12

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_12 and arg_87_1.time_ < var_90_4 + var_90_12 + arg_90_0 then
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
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1038ui_story"]) and arg_91_1.var_.characterEffect1038ui_story == nil then
				arg_91_1.var_.characterEffect1038ui_story = arg_91_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1038ui_story"]) then
				if arg_91_1.var_.characterEffect1038ui_story and not isNil(arg_91_1.actors_["1038ui_story"]) then
					arg_91_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_0)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1038ui_story"]) and arg_91_1.var_.characterEffect1038ui_story then
				arg_91_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_94_1 = arg_91_1.actors_["1041ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1041ui_story == nil then
				arg_91_1.var_.characterEffect1041ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect1041ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1041ui_story then
				arg_91_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action6_2")
			end

			local var_94_4 = 0
			local var_94_5 = 0.05

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:GetWordFromCfg(113071022)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 2 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 2)

				if (2 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 2)) > 0 and var_94_5 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071022", "story_v_out_113071.awb") ~= 0 then
					local var_94_10 = manager.audio:GetVoiceLength("story_v_out_113071", "113071022", "story_v_out_113071.awb") / 1000

					if var_94_10 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_4
					end

					if var_94_6.prefab_name ~= "" and arg_91_1.actors_[var_94_6.prefab_name] ~= nil then
						local var_94_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_6.prefab_name].transform, "story_v_out_113071", "113071022", "story_v_out_113071.awb")

						arg_91_1:RecordAudio("113071022", var_94_11)
						arg_91_1:RecordAudio("113071022", var_94_11)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_113071", "113071022", "story_v_out_113071.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_113071", "113071022", "story_v_out_113071.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_12 = math.max(var_94_5, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_12 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_4) / var_94_12

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_12 and arg_91_1.time_ < var_94_4 + var_94_12 + arg_94_0 then
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
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1041ui_story"]) and arg_95_1.var_.characterEffect1041ui_story == nil then
				arg_95_1.var_.characterEffect1041ui_story = arg_95_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1041ui_story"]) then
				if arg_95_1.var_.characterEffect1041ui_story and not isNil(arg_95_1.actors_["1041ui_story"]) then
					arg_95_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_0)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1041ui_story"]) and arg_95_1.var_.characterEffect1041ui_story then
				arg_95_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_98_1 = arg_95_1.actors_["1038ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1038ui_story == nil then
				arg_95_1.var_.characterEffect1038ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect1038ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1038ui_story then
				arg_95_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_98_4 = 0
			local var_98_5 = 0.625

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(113071023)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 25 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 25)

				if (25 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 25)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071023", "story_v_out_113071.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_out_113071", "113071023", "story_v_out_113071.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_out_113071", "113071023", "story_v_out_113071.awb")

						arg_95_1:RecordAudio("113071023", var_98_11)
						arg_95_1:RecordAudio("113071023", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_113071", "113071023", "story_v_out_113071.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_113071", "113071023", "story_v_out_113071.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
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
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1038ui_story"]) and arg_99_1.var_.characterEffect1038ui_story == nil then
				arg_99_1.var_.characterEffect1038ui_story = arg_99_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1038ui_story"]) then
				if arg_99_1.var_.characterEffect1038ui_story and not isNil(arg_99_1.actors_["1038ui_story"]) then
					arg_99_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_0)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1038ui_story"]) and arg_99_1.var_.characterEffect1038ui_story then
				arg_99_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_102_1 = arg_99_1.actors_["1041ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1041ui_story == nil then
				arg_99_1.var_.characterEffect1041ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect1041ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1041ui_story then
				arg_99_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_102_4 = 0
			local var_102_5 = 0.45

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_6 = arg_99_1:GetWordFromCfg(113071024)
				local var_102_7 = arg_99_1:FormatText(var_102_6.content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 18 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 18)

				if (18 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 18)) > 0 and var_102_5 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_4
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071024", "story_v_out_113071.awb") ~= 0 then
					local var_102_10 = manager.audio:GetVoiceLength("story_v_out_113071", "113071024", "story_v_out_113071.awb") / 1000

					if var_102_10 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_4
					end

					if var_102_6.prefab_name ~= "" and arg_99_1.actors_[var_102_6.prefab_name] ~= nil then
						local var_102_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_6.prefab_name].transform, "story_v_out_113071", "113071024", "story_v_out_113071.awb")

						arg_99_1:RecordAudio("113071024", var_102_11)
						arg_99_1:RecordAudio("113071024", var_102_11)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_113071", "113071024", "story_v_out_113071.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_113071", "113071024", "story_v_out_113071.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_12 = math.max(var_102_5, arg_99_1.talkMaxDuration)

			if var_102_4 <= arg_99_1.time_ and arg_99_1.time_ < var_102_4 + var_102_12 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_4) / var_102_12

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_4 + var_102_12 and arg_99_1.time_ < var_102_4 + var_102_12 + arg_102_0 then
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
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_106_0 = arg_103_1.actors_["1041ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1041ui_story == nil then
				arg_103_1.var_.characterEffect1041ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_1 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_1 and not isNil(var_106_0) then
				if arg_103_1.var_.characterEffect1041ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_1)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_1 and arg_103_1.time_ < 0 + var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1041ui_story then
				arg_103_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_106_2 = arg_103_1.actors_["1038ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.characterEffect1038ui_story == nil then
				arg_103_1.var_.characterEffect1038ui_story = var_106_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_3 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_3 and not isNil(var_106_2) then
				if arg_103_1.var_.characterEffect1038ui_story and not isNil(var_106_2) then
					arg_103_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_3 and arg_103_1.time_ < 0 + var_106_3 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.characterEffect1038ui_story then
				arg_103_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_106_5 = 0
			local var_106_6 = 0.225

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_7 = arg_103_1:GetWordFromCfg(113071025)
				local var_106_8 = arg_103_1:FormatText(var_106_7.content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 8 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 8)

				if (8 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 8)) > 0 and var_106_6 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_5
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071025", "story_v_out_113071.awb") ~= 0 then
					local var_106_11 = manager.audio:GetVoiceLength("story_v_out_113071", "113071025", "story_v_out_113071.awb") / 1000

					if var_106_11 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_5
					end

					if var_106_7.prefab_name ~= "" and arg_103_1.actors_[var_106_7.prefab_name] ~= nil then
						local var_106_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_7.prefab_name].transform, "story_v_out_113071", "113071025", "story_v_out_113071.awb")

						arg_103_1:RecordAudio("113071025", var_106_12)
						arg_103_1:RecordAudio("113071025", var_106_12)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_113071", "113071025", "story_v_out_113071.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_113071", "113071025", "story_v_out_113071.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_13 = math.max(var_106_6, arg_103_1.talkMaxDuration)

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_13 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_5) / var_106_13

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_5 + var_106_13 and arg_103_1.time_ < var_106_5 + var_106_13 + arg_106_0 then
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
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.mask_.enabled = true
				arg_107_1.mask_.raycastTarget = true

				arg_107_1:SetGaussion(false)
			end

			local var_110_0 = 2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				local var_110_1 = Color.New(0, 0, 0)

				var_110_1.a = Mathf.Lerp(0, 1, (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.mask_.color = var_110_1
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				local var_110_2 = Color.New(0, 0, 0)

				var_110_2.a = 1
				arg_107_1.mask_.color = var_110_2
			end

			local var_110_3 = 2

			if 2 < arg_107_1.time_ and arg_107_1.time_ <= var_110_3 + arg_110_0 then
				arg_107_1.mask_.enabled = true
				arg_107_1.mask_.raycastTarget = true

				arg_107_1:SetGaussion(false)
			end

			local var_110_4 = 2

			if var_110_3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_3 + var_110_4 then
				local var_110_5 = Color.New(0, 0, 0)

				var_110_5.a = Mathf.Lerp(1, 0, (arg_107_1.time_ - var_110_3) / var_110_4)
				arg_107_1.mask_.color = var_110_5
			end

			if arg_107_1.time_ >= var_110_3 + var_110_4 and arg_107_1.time_ < var_110_3 + var_110_4 + arg_110_0 then
				local var_110_6 = Color.New(0, 0, 0)

				arg_107_1.mask_.enabled = false
				var_110_6.a = 0
				arg_107_1.mask_.color = var_110_6
			end

			local var_110_7 = "OM0110"

			if arg_107_1.bgs_.OM0110 == nil then
				local var_110_8 = Object.Instantiate(arg_107_1.paintGo_)

				var_110_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_110_7)
				var_110_8.name = var_110_7
				var_110_8.transform.parent = arg_107_1.stage_.transform
				var_110_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_107_1.bgs_[var_110_7] = var_110_8
			end

			if 2 < arg_107_1.time_ and arg_107_1.time_ <= 2 + arg_110_0 then
				local var_110_9 = arg_107_1.bgs_.OM0110

				arg_107_1.bgs_.OM0110.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_110_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_110_10 = var_110_9:GetComponent("SpriteRenderer")

				if var_110_10 and var_110_10.sprite then
					local var_110_11 = 2 * (var_110_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_110_9.transform.localScale = Vector3.New(var_110_11 / var_110_10.sprite.bounds.size.y < var_110_11 * manager.ui.mainCameraCom_.aspect / var_110_10.sprite.bounds.size.x and var_110_11 * manager.ui.mainCameraCom_.aspect / var_110_10.sprite.bounds.size.x or var_110_11 / var_110_10.sprite.bounds.size.y, var_110_11 / var_110_10.sprite.bounds.size.y < var_110_11 * manager.ui.mainCameraCom_.aspect / var_110_10.sprite.bounds.size.x and var_110_11 * manager.ui.mainCameraCom_.aspect / var_110_10.sprite.bounds.size.x or var_110_11 / var_110_10.sprite.bounds.size.y, 0)
				end

				for iter_110_0, iter_110_1 in pairs(arg_107_1.bgs_) do
					if iter_110_0 ~= "OM0110" then
						iter_110_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_110_12 = arg_107_1.actors_["1038ui_story"].transform

			if 1.966 < arg_107_1.time_ and arg_107_1.time_ <= 1.966 + arg_110_0 then
				arg_107_1.var_.moveOldPos1038ui_story = var_110_12.localPosition
			end

			local var_110_13 = 0.001

			if 1.966 <= arg_107_1.time_ and arg_107_1.time_ < 1.966 + var_110_13 then
				var_110_12.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 1.966) / var_110_13)
				var_110_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_12.position).x, (manager.ui.mainCamera.transform.position - var_110_12.position).y, (manager.ui.mainCamera.transform.position - var_110_12.position).z)
				var_110_12.localEulerAngles.z = 0
				var_110_12.localEulerAngles.x = 0
				var_110_12.localEulerAngles = var_110_12.localEulerAngles
			end

			if arg_107_1.time_ >= 1.966 + var_110_13 and arg_107_1.time_ < 1.966 + var_110_13 + arg_110_0 then
				var_110_12.localPosition = Vector3.New(0, 100, 0)
				var_110_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_12.position).x, (manager.ui.mainCamera.transform.position - var_110_12.position).y, (manager.ui.mainCamera.transform.position - var_110_12.position).z)
				var_110_12.localEulerAngles.z = 0
				var_110_12.localEulerAngles.x = 0
				var_110_12.localEulerAngles = var_110_12.localEulerAngles
			end

			local var_110_14 = arg_107_1.actors_["1041ui_story"].transform

			if 1.966 < arg_107_1.time_ and arg_107_1.time_ <= 1.966 + arg_110_0 then
				arg_107_1.var_.moveOldPos1041ui_story = var_110_14.localPosition
			end

			local var_110_15 = 0.001

			if 1.966 <= arg_107_1.time_ and arg_107_1.time_ < 1.966 + var_110_15 then
				var_110_14.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 1.966) / var_110_15)
				var_110_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_14.position).x, (manager.ui.mainCamera.transform.position - var_110_14.position).y, (manager.ui.mainCamera.transform.position - var_110_14.position).z)
				var_110_14.localEulerAngles.z = 0
				var_110_14.localEulerAngles.x = 0
				var_110_14.localEulerAngles = var_110_14.localEulerAngles
			end

			if arg_107_1.time_ >= 1.966 + var_110_15 and arg_107_1.time_ < 1.966 + var_110_15 + arg_110_0 then
				var_110_14.localPosition = Vector3.New(0, 100, 0)
				var_110_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_14.position).x, (manager.ui.mainCamera.transform.position - var_110_14.position).y, (manager.ui.mainCamera.transform.position - var_110_14.position).z)
				var_110_14.localEulerAngles.z = 0
				var_110_14.localEulerAngles.x = 0
				var_110_14.localEulerAngles = var_110_14.localEulerAngles
			end

			if arg_107_1.frameCnt_ <= 1 then
				arg_107_1.dialog_:SetActive(false)
			end

			local var_110_16 = 4
			local var_110_17 = 0.925

			if 4 < arg_107_1.time_ and arg_107_1.time_ <= var_110_16 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0

				arg_107_1.dialog_:SetActive(true)

				arg_107_1.dialogCg_.alpha = 0

				local var_110_18 = LeanTween.value(arg_107_1.dialog_, 0, 1, 0.3)

				var_110_18:setOnUpdate(LuaHelper.FloatAction(function(arg_111_0)
					arg_107_1.dialogCg_.alpha = arg_111_0
				end))
				var_110_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_107_1.dialog_)
					var_110_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_107_1.duration_ = arg_107_1.duration_ + 0.3

				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_19 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(113071026).content)

				arg_107_1.text_.text = var_110_19

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_21 = 37 <= 0 and var_110_17 or var_110_17 * (utf8.len(var_110_19) / 37)

				if (37 <= 0 and var_110_17 or var_110_17 * (utf8.len(var_110_19) / 37)) > 0 and var_110_17 < var_110_21 then
					arg_107_1.talkMaxDuration = var_110_21
					var_110_16 = var_110_16 + 0.3

					if var_110_21 + var_110_16 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_21 + var_110_16
					end
				end

				arg_107_1.text_.text = var_110_19
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_22 = var_110_16 + 0.3
			local var_110_23 = math.max(var_110_17, arg_107_1.talkMaxDuration)

			if var_110_16 + 0.3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_22 + var_110_23 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_22) / var_110_23

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_22 + var_110_23 and arg_107_1.time_ < var_110_22 + var_110_23 + arg_110_0 then
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
			local var_116_0 = 0.5

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(113071027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 20 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 20)

				if (20 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 20)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071027", "story_v_out_113071.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_113071", "113071027", "story_v_out_113071.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_113071", "113071027", "story_v_out_113071.awb")

						arg_113_1:RecordAudio("113071027", var_116_6)
						arg_113_1:RecordAudio("113071027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_113071", "113071027", "story_v_out_113071.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_113071", "113071027", "story_v_out_113071.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
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
			local var_120_0 = 0.85

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:GetWordFromCfg(113071028)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 33 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 33)

				if (33 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 33)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071028", "story_v_out_113071.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_113071", "113071028", "story_v_out_113071.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_113071", "113071028", "story_v_out_113071.awb")

						arg_117_1:RecordAudio("113071028", var_120_6)
						arg_117_1:RecordAudio("113071028", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_113071", "113071028", "story_v_out_113071.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_113071", "113071028", "story_v_out_113071.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
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
			local var_124_0 = 0.225

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:GetWordFromCfg(113071029)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 9 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 9)

				if (9 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 9)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071029", "story_v_out_113071.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_113071", "113071029", "story_v_out_113071.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_113071", "113071029", "story_v_out_113071.awb")

						arg_121_1:RecordAudio("113071029", var_124_6)
						arg_121_1:RecordAudio("113071029", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_113071", "113071029", "story_v_out_113071.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_113071", "113071029", "story_v_out_113071.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
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
			local var_128_0 = 0.325

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:GetWordFromCfg(113071030)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 13 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 13)

				if (13 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 13)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071030", "story_v_out_113071.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_113071", "113071030", "story_v_out_113071.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_113071", "113071030", "story_v_out_113071.awb")

						arg_125_1:RecordAudio("113071030", var_128_6)
						arg_125_1:RecordAudio("113071030", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_113071", "113071030", "story_v_out_113071.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_113071", "113071030", "story_v_out_113071.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
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
			local var_132_0 = 0.275

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:GetWordFromCfg(113071031)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 11 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 11)

				if (11 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 11)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071031", "story_v_out_113071.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_113071", "113071031", "story_v_out_113071.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_113071", "113071031", "story_v_out_113071.awb")

						arg_129_1:RecordAudio("113071031", var_132_6)
						arg_129_1:RecordAudio("113071031", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_113071", "113071031", "story_v_out_113071.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_113071", "113071031", "story_v_out_113071.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
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
			local var_136_0 = 0.575

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(113071032).content)

				arg_133_1.text_.text = var_136_1

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_3 = 23 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 23)

				if (23 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 23)) > 0 and var_136_0 < var_136_3 then
					arg_133_1.talkMaxDuration = var_136_3

					if var_136_3 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_3 + 0
					end
				end

				arg_133_1.text_.text = var_136_1
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_4 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_4

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
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
			local var_140_0 = 0.775

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(113071033)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 31 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 31)

				if (31 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 31)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071033", "story_v_out_113071.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_113071", "113071033", "story_v_out_113071.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_113071", "113071033", "story_v_out_113071.awb")

						arg_137_1:RecordAudio("113071033", var_140_6)
						arg_137_1:RecordAudio("113071033", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_113071", "113071033", "story_v_out_113071.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_113071", "113071033", "story_v_out_113071.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
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
			local var_144_0 = 0.35

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:GetWordFromCfg(113071034)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 14 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 14)

				if (14 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 14)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071034", "story_v_out_113071.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_113071", "113071034", "story_v_out_113071.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_113071", "113071034", "story_v_out_113071.awb")

						arg_141_1:RecordAudio("113071034", var_144_6)
						arg_141_1:RecordAudio("113071034", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_113071", "113071034", "story_v_out_113071.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_113071", "113071034", "story_v_out_113071.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
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
			local var_148_0 = 0.05

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(113071035)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 2 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 2)

				if (2 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 2)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071035", "story_v_out_113071.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_113071", "113071035", "story_v_out_113071.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_113071", "113071035", "story_v_out_113071.awb")

						arg_145_1:RecordAudio("113071035", var_148_6)
						arg_145_1:RecordAudio("113071035", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_113071", "113071035", "story_v_out_113071.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_113071", "113071035", "story_v_out_113071.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
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
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_0 = 2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				local var_152_1 = Color.New(0, 0, 0)

				var_152_1.a = Mathf.Lerp(0, 1, (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.mask_.color = var_152_1
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				local var_152_2 = Color.New(0, 0, 0)

				var_152_2.a = 1
				arg_149_1.mask_.color = var_152_2
			end

			local var_152_3 = 2

			if 2 < arg_149_1.time_ and arg_149_1.time_ <= var_152_3 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_4 = 2

			if var_152_3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_3 + var_152_4 then
				local var_152_5 = Color.New(0, 0, 0)

				var_152_5.a = Mathf.Lerp(1, 0, (arg_149_1.time_ - var_152_3) / var_152_4)
				arg_149_1.mask_.color = var_152_5
			end

			if arg_149_1.time_ >= var_152_3 + var_152_4 and arg_149_1.time_ < var_152_3 + var_152_4 + arg_152_0 then
				local var_152_6 = Color.New(0, 0, 0)

				arg_149_1.mask_.enabled = false
				var_152_6.a = 0
				arg_149_1.mask_.color = var_152_6
			end

			if 2 < arg_149_1.time_ and arg_149_1.time_ <= 2 + arg_152_0 then
				local var_152_7 = arg_149_1.bgs_.F01

				arg_149_1.bgs_.F01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_152_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_152_8 = var_152_7:GetComponent("SpriteRenderer")

				if var_152_8 and var_152_8.sprite then
					local var_152_9 = 2 * (var_152_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_152_7.transform.localScale = Vector3.New(var_152_9 / var_152_8.sprite.bounds.size.y < var_152_9 * manager.ui.mainCameraCom_.aspect / var_152_8.sprite.bounds.size.x and var_152_9 * manager.ui.mainCameraCom_.aspect / var_152_8.sprite.bounds.size.x or var_152_9 / var_152_8.sprite.bounds.size.y, var_152_9 / var_152_8.sprite.bounds.size.y < var_152_9 * manager.ui.mainCameraCom_.aspect / var_152_8.sprite.bounds.size.x and var_152_9 * manager.ui.mainCameraCom_.aspect / var_152_8.sprite.bounds.size.x or var_152_9 / var_152_8.sprite.bounds.size.y, 0)
				end

				for iter_152_0, iter_152_1 in pairs(arg_149_1.bgs_) do
					if iter_152_0 ~= "F01" then
						iter_152_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:AudioAction("stop", "music", "se_story_10", "se_story_10_boiling_loop", "")

				local var_152_12 = manager.audio:GetAudioName("se_story_10", "se_story_10_boiling_loop")

				if "" ~= "" then
					if arg_149_1.bgmTxt_.text ~= var_152_12 and arg_149_1.bgmTxt_.text ~= "" then
						if arg_149_1.bgmTxt2_.text ~= "" then
							arg_149_1.bgmTxt_.text = arg_149_1.bgmTxt2_.text
						end

						arg_149_1.bgmTxt2_.text = var_152_12

						arg_149_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_149_1.bgmTxt_.text = var_152_12
						arg_149_1.bgmTxt2_.text = var_152_12
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

			if 1.04555149935186 < arg_149_1.time_ and arg_149_1.time_ <= 1.04555149935186 + arg_152_0 then
				arg_149_1:AudioAction("play", "effect", "se_story_10", "se_story_10_tea", "")
			end

			if arg_149_1.frameCnt_ <= 1 then
				arg_149_1.dialog_:SetActive(false)
			end

			local var_152_14 = 4
			local var_152_15 = 0.575

			if 4 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				arg_149_1.dialog_:SetActive(true)

				arg_149_1.dialogCg_.alpha = 0

				local var_152_16 = LeanTween.value(arg_149_1.dialog_, 0, 1, 0.3)

				var_152_16:setOnUpdate(LuaHelper.FloatAction(function(arg_154_0)
					arg_149_1.dialogCg_.alpha = arg_154_0
				end))
				var_152_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_149_1.dialog_)
					var_152_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_149_1.duration_ = arg_149_1.duration_ + 0.3

				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_17 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(113071036).content)

				arg_149_1.text_.text = var_152_17

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_19 = 23 <= 0 and var_152_15 or var_152_15 * (utf8.len(var_152_17) / 23)

				if (23 <= 0 and var_152_15 or var_152_15 * (utf8.len(var_152_17) / 23)) > 0 and var_152_15 < var_152_19 then
					arg_149_1.talkMaxDuration = var_152_19
					var_152_14 = var_152_14 + 0.3

					if var_152_19 + var_152_14 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_19 + var_152_14
					end
				end

				arg_149_1.text_.text = var_152_17
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_20 = var_152_14 + 0.3
			local var_152_21 = math.max(var_152_15, arg_149_1.talkMaxDuration)

			if var_152_14 + 0.3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_20 + var_152_21 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_20) / var_152_21

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_20 + var_152_21 and arg_149_1.time_ < var_152_20 + var_152_21 + arg_152_0 then
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
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1038ui_story = arg_156_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_159_0 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 then
				arg_156_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1038ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_156_1.time_ - 0) / var_159_0)
				arg_156_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1038ui_story"].transform.position).z)
				arg_156_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1038ui_story"].transform.localEulerAngles = arg_156_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 then
				arg_156_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				arg_156_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1038ui_story"].transform.position).z)
				arg_156_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1038ui_story"].transform.localEulerAngles = arg_156_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_159_1 = arg_156_1.actors_["1038ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1038ui_story == nil then
				arg_156_1.var_.characterEffect1038ui_story = var_159_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 and not isNil(var_159_1) then
				if arg_156_1.var_.characterEffect1038ui_story and not isNil(var_159_1) then
					arg_156_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1038ui_story then
				arg_156_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_159_4 = 0
			local var_159_5 = 0.05

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_6 = arg_156_1:GetWordFromCfg(113071037)
				local var_159_7 = arg_156_1:FormatText(var_159_6.content)

				arg_156_1.text_.text = var_159_7

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_9 = 2 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 2)

				if (2 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 2)) > 0 and var_159_5 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_4
					end
				end

				arg_156_1.text_.text = var_159_7
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071037", "story_v_out_113071.awb") ~= 0 then
					local var_159_10 = manager.audio:GetVoiceLength("story_v_out_113071", "113071037", "story_v_out_113071.awb") / 1000

					if var_159_10 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_4
					end

					if var_159_6.prefab_name ~= "" and arg_156_1.actors_[var_159_6.prefab_name] ~= nil then
						local var_159_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_6.prefab_name].transform, "story_v_out_113071", "113071037", "story_v_out_113071.awb")

						arg_156_1:RecordAudio("113071037", var_159_11)
						arg_156_1:RecordAudio("113071037", var_159_11)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_113071", "113071037", "story_v_out_113071.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_113071", "113071037", "story_v_out_113071.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_12 = math.max(var_159_5, arg_156_1.talkMaxDuration)

			if var_159_4 <= arg_156_1.time_ and arg_156_1.time_ < var_159_4 + var_159_12 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_4) / var_159_12

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_4 + var_159_12 and arg_156_1.time_ < var_159_4 + var_159_12 + arg_159_0 then
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
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1038ui_story"]) and arg_160_1.var_.characterEffect1038ui_story == nil then
				arg_160_1.var_.characterEffect1038ui_story = arg_160_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1038ui_story"]) then
				if arg_160_1.var_.characterEffect1038ui_story and not isNil(arg_160_1.actors_["1038ui_story"]) then
					arg_160_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_0)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1038ui_story"]) and arg_160_1.var_.characterEffect1038ui_story then
				arg_160_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_163_1 = arg_160_1.actors_["1041ui_story"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1041ui_story = var_163_1.localPosition
			end

			local var_163_2 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_2 then
				var_163_1.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1041ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_160_1.time_ - 0) / var_163_2)
				var_163_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_1.position).x, (manager.ui.mainCamera.transform.position - var_163_1.position).y, (manager.ui.mainCamera.transform.position - var_163_1.position).z)
				var_163_1.localEulerAngles.z = 0
				var_163_1.localEulerAngles.x = 0
				var_163_1.localEulerAngles = var_163_1.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_2 and arg_160_1.time_ < 0 + var_163_2 + arg_163_0 then
				var_163_1.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_163_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_1.position).x, (manager.ui.mainCamera.transform.position - var_163_1.position).y, (manager.ui.mainCamera.transform.position - var_163_1.position).z)
				var_163_1.localEulerAngles.z = 0
				var_163_1.localEulerAngles.x = 0
				var_163_1.localEulerAngles = var_163_1.localEulerAngles
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_163_3 = arg_160_1.actors_["1041ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_3) and arg_160_1.var_.characterEffect1041ui_story == nil then
				arg_160_1.var_.characterEffect1041ui_story = var_163_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_4 = 0.2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 and not isNil(var_163_3) then
				if arg_160_1.var_.characterEffect1041ui_story and not isNil(var_163_3) then
					arg_160_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 and not isNil(var_163_3) and arg_160_1.var_.characterEffect1041ui_story then
				arg_160_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_163_6 = 0
			local var_163_7 = 0.225

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_8 = arg_160_1:GetWordFromCfg(113071038)
				local var_163_9 = arg_160_1:FormatText(var_163_8.content)

				arg_160_1.text_.text = var_163_9

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 9 <= 0 and var_163_7 or var_163_7 * (utf8.len(var_163_9) / 9)

				if (9 <= 0 and var_163_7 or var_163_7 * (utf8.len(var_163_9) / 9)) > 0 and var_163_7 < var_163_11 then
					arg_160_1.talkMaxDuration = var_163_11

					if var_163_11 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_11 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_9
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071038", "story_v_out_113071.awb") ~= 0 then
					local var_163_12 = manager.audio:GetVoiceLength("story_v_out_113071", "113071038", "story_v_out_113071.awb") / 1000

					if var_163_12 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_12 + var_163_6
					end

					if var_163_8.prefab_name ~= "" and arg_160_1.actors_[var_163_8.prefab_name] ~= nil then
						local var_163_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_8.prefab_name].transform, "story_v_out_113071", "113071038", "story_v_out_113071.awb")

						arg_160_1:RecordAudio("113071038", var_163_13)
						arg_160_1:RecordAudio("113071038", var_163_13)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_113071", "113071038", "story_v_out_113071.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_113071", "113071038", "story_v_out_113071.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_14 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_14 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_14

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_14 and arg_160_1.time_ < var_163_6 + var_163_14 + arg_163_0 then
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
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_167_0 = arg_164_1.actors_["1038ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1038ui_story == nil then
				arg_164_1.var_.characterEffect1038ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_1 = 0.2

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_1 and not isNil(var_167_0) then
				if arg_164_1.var_.characterEffect1038ui_story and not isNil(var_167_0) then
					arg_164_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_1 and arg_164_1.time_ < 0 + var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1038ui_story then
				arg_164_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_167_3 = arg_164_1.actors_["1041ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_3) and arg_164_1.var_.characterEffect1041ui_story == nil then
				arg_164_1.var_.characterEffect1041ui_story = var_167_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_4 = 0.2

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 and not isNil(var_167_3) then
				if arg_164_1.var_.characterEffect1041ui_story and not isNil(var_167_3) then
					arg_164_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_4)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 and not isNil(var_167_3) and arg_164_1.var_.characterEffect1041ui_story then
				arg_164_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_167_5 = 0
			local var_167_6 = 0.6

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_7 = arg_164_1:GetWordFromCfg(113071039)
				local var_167_8 = arg_164_1:FormatText(var_167_7.content)

				arg_164_1.text_.text = var_167_8

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_10 = 24 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_8) / 24)

				if (24 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_8) / 24)) > 0 and var_167_6 < var_167_10 then
					arg_164_1.talkMaxDuration = var_167_10

					if var_167_10 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_10 + var_167_5
					end
				end

				arg_164_1.text_.text = var_167_8
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071039", "story_v_out_113071.awb") ~= 0 then
					local var_167_11 = manager.audio:GetVoiceLength("story_v_out_113071", "113071039", "story_v_out_113071.awb") / 1000

					if var_167_11 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_11 + var_167_5
					end

					if var_167_7.prefab_name ~= "" and arg_164_1.actors_[var_167_7.prefab_name] ~= nil then
						local var_167_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_7.prefab_name].transform, "story_v_out_113071", "113071039", "story_v_out_113071.awb")

						arg_164_1:RecordAudio("113071039", var_167_12)
						arg_164_1:RecordAudio("113071039", var_167_12)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_113071", "113071039", "story_v_out_113071.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_113071", "113071039", "story_v_out_113071.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_13 = math.max(var_167_6, arg_164_1.talkMaxDuration)

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_13 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_5) / var_167_13

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_5 + var_167_13 and arg_164_1.time_ < var_167_5 + var_167_13 + arg_167_0 then
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
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["1038ui_story"]) and arg_168_1.var_.characterEffect1038ui_story == nil then
				arg_168_1.var_.characterEffect1038ui_story = arg_168_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_0 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["1038ui_story"]) then
				if arg_168_1.var_.characterEffect1038ui_story and not isNil(arg_168_1.actors_["1038ui_story"]) then
					arg_168_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_168_1.time_ - 0) / var_171_0)
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["1038ui_story"]) and arg_168_1.var_.characterEffect1038ui_story then
				arg_168_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_171_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_168_1.bgmTxt_.text ~= var_171_3 and arg_168_1.bgmTxt_.text ~= "" then
						if arg_168_1.bgmTxt2_.text ~= "" then
							arg_168_1.bgmTxt_.text = arg_168_1.bgmTxt2_.text
						end

						arg_168_1.bgmTxt2_.text = var_171_3

						arg_168_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_168_1.bgmTxt_.text = var_171_3
						arg_168_1.bgmTxt2_.text = var_171_3
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

			if 0.175 < arg_168_1.time_ and arg_168_1.time_ <= 0.175 + arg_171_0 then
				arg_168_1:AudioAction("play", "effect", "se_story", "se_story_robot_e", "")
			end

			local var_171_5 = 0
			local var_171_6 = 0.175

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[68].name)

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

				local var_171_7 = arg_168_1:GetWordFromCfg(113071040)
				local var_171_8 = arg_168_1:FormatText(var_171_7.content)

				arg_168_1.text_.text = var_171_8

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_10 = 7 <= 0 and var_171_6 or var_171_6 * (utf8.len(var_171_8) / 7)

				if (7 <= 0 and var_171_6 or var_171_6 * (utf8.len(var_171_8) / 7)) > 0 and var_171_6 < var_171_10 then
					arg_168_1.talkMaxDuration = var_171_10

					if var_171_10 + var_171_5 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_10 + var_171_5
					end
				end

				arg_168_1.text_.text = var_171_8
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071040", "story_v_out_113071.awb") ~= 0 then
					local var_171_11 = manager.audio:GetVoiceLength("story_v_out_113071", "113071040", "story_v_out_113071.awb") / 1000

					if var_171_11 + var_171_5 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_11 + var_171_5
					end

					if var_171_7.prefab_name ~= "" and arg_168_1.actors_[var_171_7.prefab_name] ~= nil then
						local var_171_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_7.prefab_name].transform, "story_v_out_113071", "113071040", "story_v_out_113071.awb")

						arg_168_1:RecordAudio("113071040", var_171_12)
						arg_168_1:RecordAudio("113071040", var_171_12)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_113071", "113071040", "story_v_out_113071.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_113071", "113071040", "story_v_out_113071.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_13 = math.max(var_171_6, arg_168_1.talkMaxDuration)

			if var_171_5 <= arg_168_1.time_ and arg_168_1.time_ < var_171_5 + var_171_13 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_5) / var_171_13

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_5 + var_171_13 and arg_168_1.time_ < var_171_5 + var_171_13 + arg_171_0 then
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
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action457")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_176_0 = arg_173_1.actors_["1038ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1038ui_story == nil then
				arg_173_1.var_.characterEffect1038ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_1 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 and not isNil(var_176_0) then
				if arg_173_1.var_.characterEffect1038ui_story and not isNil(var_176_0) then
					arg_173_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1038ui_story then
				arg_173_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:AudioAction("play", "music", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_176_5 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

				if "" ~= "" then
					if arg_173_1.bgmTxt_.text ~= var_176_5 and arg_173_1.bgmTxt_.text ~= "" then
						if arg_173_1.bgmTxt2_.text ~= "" then
							arg_173_1.bgmTxt_.text = arg_173_1.bgmTxt2_.text
						end

						arg_173_1.bgmTxt2_.text = var_176_5

						arg_173_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_173_1.bgmTxt_.text = var_176_5
						arg_173_1.bgmTxt2_.text = var_176_5
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

			local var_176_6 = 0
			local var_176_7 = 0.15

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_8 = arg_173_1:GetWordFromCfg(113071041)
				local var_176_9 = arg_173_1:FormatText(var_176_8.content)

				arg_173_1.text_.text = var_176_9

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 6 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 6)

				if (6 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 6)) > 0 and var_176_7 < var_176_11 then
					arg_173_1.talkMaxDuration = var_176_11

					if var_176_11 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_11 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_9
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071041", "story_v_out_113071.awb") ~= 0 then
					local var_176_12 = manager.audio:GetVoiceLength("story_v_out_113071", "113071041", "story_v_out_113071.awb") / 1000

					if var_176_12 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_12 + var_176_6
					end

					if var_176_8.prefab_name ~= "" and arg_173_1.actors_[var_176_8.prefab_name] ~= nil then
						local var_176_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_8.prefab_name].transform, "story_v_out_113071", "113071041", "story_v_out_113071.awb")

						arg_173_1:RecordAudio("113071041", var_176_13)
						arg_173_1:RecordAudio("113071041", var_176_13)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_113071", "113071041", "story_v_out_113071.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_113071", "113071041", "story_v_out_113071.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_14 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_14 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_14

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_14 and arg_173_1.time_ < var_176_6 + var_176_14 + arg_176_0 then
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
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["1038ui_story"]) and arg_178_1.var_.characterEffect1038ui_story == nil then
				arg_178_1.var_.characterEffect1038ui_story = arg_178_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["1038ui_story"]) then
				if arg_178_1.var_.characterEffect1038ui_story and not isNil(arg_178_1.actors_["1038ui_story"]) then
					arg_178_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_0)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1038ui_story"]) and arg_178_1.var_.characterEffect1038ui_story then
				arg_178_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action4_1")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_181_1 = arg_178_1.actors_["1041ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1041ui_story == nil then
				arg_178_1.var_.characterEffect1041ui_story = var_181_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_2 and not isNil(var_181_1) then
				if arg_178_1.var_.characterEffect1041ui_story and not isNil(var_181_1) then
					arg_178_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_2 and arg_178_1.time_ < 0 + var_181_2 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1041ui_story then
				arg_178_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_181_4 = arg_178_1.actors_["1041ui_story"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1041ui_story = var_181_4.localPosition

				arg_178_1:ShowWeapon(arg_178_1.var_["1041ui_story" .. "Animator"].transform, true)
			end

			local var_181_5 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_5 then
				var_181_4.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1041ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_178_1.time_ - 0) / var_181_5)
				var_181_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_4.position).x, (manager.ui.mainCamera.transform.position - var_181_4.position).y, (manager.ui.mainCamera.transform.position - var_181_4.position).z)
				var_181_4.localEulerAngles.z = 0
				var_181_4.localEulerAngles.x = 0
				var_181_4.localEulerAngles = var_181_4.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_5 and arg_178_1.time_ < 0 + var_181_5 + arg_181_0 then
				var_181_4.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_181_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_4.position).x, (manager.ui.mainCamera.transform.position - var_181_4.position).y, (manager.ui.mainCamera.transform.position - var_181_4.position).z)
				var_181_4.localEulerAngles.z = 0
				var_181_4.localEulerAngles.x = 0
				var_181_4.localEulerAngles = var_181_4.localEulerAngles
			end

			local var_181_6 = 0
			local var_181_7 = 0.1

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_6 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_8 = arg_178_1:GetWordFromCfg(113071042)
				local var_181_9 = arg_178_1:FormatText(var_181_8.content)

				arg_178_1.text_.text = var_181_9

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_11 = 4 <= 0 and var_181_7 or var_181_7 * (utf8.len(var_181_9) / 4)

				if (4 <= 0 and var_181_7 or var_181_7 * (utf8.len(var_181_9) / 4)) > 0 and var_181_7 < var_181_11 then
					arg_178_1.talkMaxDuration = var_181_11

					if var_181_11 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_11 + var_181_6
					end
				end

				arg_178_1.text_.text = var_181_9
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071042", "story_v_out_113071.awb") ~= 0 then
					local var_181_12 = manager.audio:GetVoiceLength("story_v_out_113071", "113071042", "story_v_out_113071.awb") / 1000

					if var_181_12 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_12 + var_181_6
					end

					if var_181_8.prefab_name ~= "" and arg_178_1.actors_[var_181_8.prefab_name] ~= nil then
						local var_181_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_8.prefab_name].transform, "story_v_out_113071", "113071042", "story_v_out_113071.awb")

						arg_178_1:RecordAudio("113071042", var_181_13)
						arg_178_1:RecordAudio("113071042", var_181_13)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_113071", "113071042", "story_v_out_113071.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_113071", "113071042", "story_v_out_113071.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_14 = math.max(var_181_7, arg_178_1.talkMaxDuration)

			if var_181_6 <= arg_178_1.time_ and arg_178_1.time_ < var_181_6 + var_181_14 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_6) / var_181_14

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_6 + var_181_14 and arg_178_1.time_ < var_181_6 + var_181_14 + arg_181_0 then
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
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1041ui_story = arg_182_1.actors_["1041ui_story"].transform.localPosition

				arg_182_1:ShowWeapon(arg_182_1.var_["1041ui_story" .. "Animator"].transform, true)
			end

			local var_185_0 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 then
				arg_182_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_182_1.time_ - 0) / var_185_0)
				arg_182_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1041ui_story"].transform.position).z)
				arg_182_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1041ui_story"].transform.localEulerAngles = arg_182_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 then
				arg_182_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_182_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1041ui_story"].transform.position).z)
				arg_182_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1041ui_story"].transform.localEulerAngles = arg_182_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_185_1 = arg_182_1.actors_["1038ui_story"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1038ui_story = var_185_1.localPosition

				arg_182_1:ShowWeapon(arg_182_1.var_["1038ui_story" .. "Animator"].transform, true)
			end

			local var_185_2 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 then
				var_185_1.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_182_1.time_ - 0) / var_185_2)
				var_185_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_1.position).x, (manager.ui.mainCamera.transform.position - var_185_1.position).y, (manager.ui.mainCamera.transform.position - var_185_1.position).z)
				var_185_1.localEulerAngles.z = 0
				var_185_1.localEulerAngles.x = 0
				var_185_1.localEulerAngles = var_185_1.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 then
				var_185_1.localPosition = Vector3.New(0, 100, 0)
				var_185_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_1.position).x, (manager.ui.mainCamera.transform.position - var_185_1.position).y, (manager.ui.mainCamera.transform.position - var_185_1.position).z)
				var_185_1.localEulerAngles.z = 0
				var_185_1.localEulerAngles.x = 0
				var_185_1.localEulerAngles = var_185_1.localEulerAngles
			end

			local var_185_3 = 0
			local var_185_4 = 0.6

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_3 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_5 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(113071043).content)

				arg_182_1.text_.text = var_185_5

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_7 = 24 <= 0 and var_185_4 or var_185_4 * (utf8.len(var_185_5) / 24)

				if (24 <= 0 and var_185_4 or var_185_4 * (utf8.len(var_185_5) / 24)) > 0 and var_185_4 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_3 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_3
					end
				end

				arg_182_1.text_.text = var_185_5
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_8 = math.max(var_185_4, arg_182_1.talkMaxDuration)

			if var_185_3 <= arg_182_1.time_ and arg_182_1.time_ < var_185_3 + var_185_8 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_3) / var_185_8

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_3 + var_185_8 and arg_182_1.time_ < var_185_3 + var_185_8 + arg_185_0 then
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
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_189_0 = arg_186_1.actors_["1041ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1041ui_story == nil then
				arg_186_1.var_.characterEffect1041ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_1 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_1 and not isNil(var_189_0) then
				if arg_186_1.var_.characterEffect1041ui_story and not isNil(var_189_0) then
					arg_186_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_1 and arg_186_1.time_ < 0 + var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1041ui_story then
				arg_186_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_189_3 = arg_186_1.actors_["1041ui_story"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1041ui_story = var_189_3.localPosition

				arg_186_1:ShowWeapon(arg_186_1.var_["1041ui_story" .. "Animator"].transform, true)
			end

			local var_189_4 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 then
				var_189_3.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_186_1.time_ - 0) / var_189_4)
				var_189_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_3.position).x, (manager.ui.mainCamera.transform.position - var_189_3.position).y, (manager.ui.mainCamera.transform.position - var_189_3.position).z)
				var_189_3.localEulerAngles.z = 0
				var_189_3.localEulerAngles.x = 0
				var_189_3.localEulerAngles = var_189_3.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 then
				var_189_3.localPosition = Vector3.New(0, -1.11, -5.9)
				var_189_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_3.position).x, (manager.ui.mainCamera.transform.position - var_189_3.position).y, (manager.ui.mainCamera.transform.position - var_189_3.position).z)
				var_189_3.localEulerAngles.z = 0
				var_189_3.localEulerAngles.x = 0
				var_189_3.localEulerAngles = var_189_3.localEulerAngles
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action8_1")
			end

			local var_189_5 = 0
			local var_189_6 = 0.225

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_7 = arg_186_1:GetWordFromCfg(113071044)
				local var_189_8 = arg_186_1:FormatText(var_189_7.content)

				arg_186_1.text_.text = var_189_8

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_10 = 9 <= 0 and var_189_6 or var_189_6 * (utf8.len(var_189_8) / 9)

				if (9 <= 0 and var_189_6 or var_189_6 * (utf8.len(var_189_8) / 9)) > 0 and var_189_6 < var_189_10 then
					arg_186_1.talkMaxDuration = var_189_10

					if var_189_10 + var_189_5 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_10 + var_189_5
					end
				end

				arg_186_1.text_.text = var_189_8
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113071", "113071044", "story_v_out_113071.awb") ~= 0 then
					local var_189_11 = manager.audio:GetVoiceLength("story_v_out_113071", "113071044", "story_v_out_113071.awb") / 1000

					if var_189_11 + var_189_5 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_11 + var_189_5
					end

					if var_189_7.prefab_name ~= "" and arg_186_1.actors_[var_189_7.prefab_name] ~= nil then
						local var_189_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_7.prefab_name].transform, "story_v_out_113071", "113071044", "story_v_out_113071.awb")

						arg_186_1:RecordAudio("113071044", var_189_12)
						arg_186_1:RecordAudio("113071044", var_189_12)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_113071", "113071044", "story_v_out_113071.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_113071", "113071044", "story_v_out_113071.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_13 = math.max(var_189_6, arg_186_1.talkMaxDuration)

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_13 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_5) / var_189_13

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_5 + var_189_13 and arg_186_1.time_ < var_189_5 + var_189_13 + arg_189_0 then
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
