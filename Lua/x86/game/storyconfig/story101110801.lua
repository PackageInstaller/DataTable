return {
	Play111081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111081001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_5 ~= "" then
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

			local var_4_6 = 0
			local var_4_7 = 0.5

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_8 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_8:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_9 = arg_1_1:GetWordFromCfg(111081001)
				local var_4_10 = arg_1_1:FormatText(var_4_9.content)

				arg_1_1.text_.text = var_4_10

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_11 = 20
				local var_4_12 = utf8.len(var_4_10)
				local var_4_13 = var_4_11 <= 0 and var_4_7 or var_4_7 * (var_4_12 / var_4_11)

				if var_4_13 > 0 and var_4_7 < var_4_13 then
					arg_1_1.talkMaxDuration = var_4_13
					var_4_6 = var_4_6 + 0.3

					if var_4_13 + var_4_6 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_13 + var_4_6
					end
				end

				arg_1_1.text_.text = var_4_10
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_14 = var_4_6 + 0.3
			local var_4_15 = math.max(var_4_7, arg_1_1.talkMaxDuration)

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_14) / var_4_15

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play111081002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111081002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play111081003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "effect"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story", "se_story_rainloop", "")
			end

			local var_11_4 = 0
			local var_11_5 = 1

			if var_11_4 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_6 = arg_8_1:GetWordFromCfg(111081002)
				local var_11_7 = arg_8_1:FormatText(var_11_6.content)

				arg_8_1.text_.text = var_11_7

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_8 = 40
				local var_11_9 = utf8.len(var_11_7)
				local var_11_10 = var_11_8 <= 0 and var_11_5 or var_11_5 * (var_11_9 / var_11_8)

				if var_11_10 > 0 and var_11_5 < var_11_10 then
					arg_8_1.talkMaxDuration = var_11_10

					if var_11_10 + var_11_4 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_10 + var_11_4
					end
				end

				arg_8_1.text_.text = var_11_7
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_11 = math.max(var_11_5, arg_8_1.talkMaxDuration)

			if var_11_4 <= arg_8_1.time_ and arg_8_1.time_ < var_11_4 + var_11_11 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_4) / var_11_11

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_4 + var_11_11 and arg_8_1.time_ < var_11_4 + var_11_11 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play111081003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 111081003
		arg_12_1.duration_ = 5.1

		local var_12_0 = {
			ja = 2.6,
			ko = 5.1,
			zh = 3.766,
			en = 4.666
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
				arg_12_0:Play111081004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = manager.ui.mainCamera.transform
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.shakeOldPos = var_15_0.localPosition
			end

			local var_15_2 = 0.233333333333333

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / 0.066
				local var_15_4, var_15_5 = math.modf(var_15_3)

				var_15_0.localPosition = Vector3.New(var_15_5 * 0.13, var_15_5 * 0.13, var_15_5 * 0.13) + arg_12_1.var_.shakeOldPos
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 then
				var_15_0.localPosition = arg_12_1.var_.shakeOldPos
			end

			local var_15_6 = 0
			local var_15_7 = 1

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				local var_15_8 = "play"
				local var_15_9 = "effect"

				arg_12_1:AudioAction(var_15_8, var_15_9, "se_story_activity_1_1", "se_story_activity_1_1_bottle", "")
			end

			local var_15_10 = 0
			local var_15_11 = 0.425

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_12 = arg_12_1:FormatText(StoryNameCfg[186].name)

				arg_12_1.leftNameTxt_.text = var_15_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_13 = arg_12_1:GetWordFromCfg(111081003)
				local var_15_14 = arg_12_1:FormatText(var_15_13.content)

				arg_12_1.text_.text = var_15_14

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 17
				local var_15_16 = utf8.len(var_15_14)
				local var_15_17 = var_15_15 <= 0 and var_15_11 or var_15_11 * (var_15_16 / var_15_15)

				if var_15_17 > 0 and var_15_11 < var_15_17 then
					arg_12_1.talkMaxDuration = var_15_17

					if var_15_17 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_17 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_14
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081003", "story_v_out_111081.awb") ~= 0 then
					local var_15_18 = manager.audio:GetVoiceLength("story_v_out_111081", "111081003", "story_v_out_111081.awb") / 1000

					if var_15_18 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_18 + var_15_10
					end

					if var_15_13.prefab_name ~= "" and arg_12_1.actors_[var_15_13.prefab_name] ~= nil then
						local var_15_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_13.prefab_name].transform, "story_v_out_111081", "111081003", "story_v_out_111081.awb")

						arg_12_1:RecordAudio("111081003", var_15_19)
						arg_12_1:RecordAudio("111081003", var_15_19)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_111081", "111081003", "story_v_out_111081.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_111081", "111081003", "story_v_out_111081.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_20 = math.max(var_15_11, arg_12_1.talkMaxDuration)

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_20 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_10) / var_15_20

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_10 + var_15_20 and arg_12_1.time_ < var_15_10 + var_15_20 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play111081004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 111081004
		arg_16_1.duration_ = 9.93

		local var_16_0 = {
			ja = 7.033,
			ko = 8.066,
			zh = 9.933,
			en = 9.4
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
				arg_16_0:Play111081005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.025

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[186].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(111081004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 41
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081004", "story_v_out_111081.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081004", "story_v_out_111081.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_111081", "111081004", "story_v_out_111081.awb")

						arg_16_1:RecordAudio("111081004", var_19_9)
						arg_16_1:RecordAudio("111081004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_111081", "111081004", "story_v_out_111081.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_111081", "111081004", "story_v_out_111081.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_10 and arg_16_1.time_ < var_19_0 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play111081005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 111081005
		arg_20_1.duration_ = 5.73

		local var_20_0 = {
			ja = 2.3,
			ko = 5.5,
			zh = 3.833,
			en = 5.733
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
				arg_20_0:Play111081006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.325

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[186].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(111081005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 13
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081005", "story_v_out_111081.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081005", "story_v_out_111081.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_111081", "111081005", "story_v_out_111081.awb")

						arg_20_1:RecordAudio("111081005", var_23_9)
						arg_20_1:RecordAudio("111081005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_111081", "111081005", "story_v_out_111081.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_111081", "111081005", "story_v_out_111081.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_10 and arg_20_1.time_ < var_23_0 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play111081006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 111081006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play111081007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.6

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(111081006)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 24
				local var_27_5 = utf8.len(var_27_3)
				local var_27_6 = var_27_4 <= 0 and var_27_1 or var_27_1 * (var_27_5 / var_27_4)

				if var_27_6 > 0 and var_27_1 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_7 and arg_24_1.time_ < var_27_0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play111081007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 111081007
		arg_28_1.duration_ = 8.33

		local var_28_0 = {
			ja = 6.533,
			ko = 4.6,
			zh = 8.333,
			en = 4.433
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
				arg_28_0:Play111081008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.425

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[176].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(111081007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081007", "story_v_out_111081.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081007", "story_v_out_111081.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_111081", "111081007", "story_v_out_111081.awb")

						arg_28_1:RecordAudio("111081007", var_31_9)
						arg_28_1:RecordAudio("111081007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_111081", "111081007", "story_v_out_111081.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_111081", "111081007", "story_v_out_111081.awb")
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
	Play111081008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 111081008
		arg_32_1.duration_ = 11.5

		local var_32_0 = {
			ja = 11.166,
			ko = 10.233,
			zh = 11.5,
			en = 9
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
				arg_32_0:Play111081009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.75

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[186].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(111081008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081008", "story_v_out_111081.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081008", "story_v_out_111081.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_111081", "111081008", "story_v_out_111081.awb")

						arg_32_1:RecordAudio("111081008", var_35_9)
						arg_32_1:RecordAudio("111081008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_111081", "111081008", "story_v_out_111081.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_111081", "111081008", "story_v_out_111081.awb")
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
	Play111081009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 111081009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play111081010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 1.175

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_2 = arg_36_1:GetWordFromCfg(111081009)
				local var_39_3 = arg_36_1:FormatText(var_39_2.content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 46
				local var_39_5 = utf8.len(var_39_3)
				local var_39_6 = var_39_4 <= 0 and var_39_1 or var_39_1 * (var_39_5 / var_39_4)

				if var_39_6 > 0 and var_39_1 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_7 and arg_36_1.time_ < var_39_0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play111081010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 111081010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play111081011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.675

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_2 = arg_40_1:GetWordFromCfg(111081010)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 27
				local var_43_5 = utf8.len(var_43_3)
				local var_43_6 = var_43_4 <= 0 and var_43_1 or var_43_1 * (var_43_5 / var_43_4)

				if var_43_6 > 0 and var_43_1 < var_43_6 then
					arg_40_1.talkMaxDuration = var_43_6

					if var_43_6 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_7 and arg_40_1.time_ < var_43_0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play111081011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 111081011
		arg_44_1.duration_ = 10.6

		local var_44_0 = {
			ja = 6.066,
			ko = 4,
			zh = 6.333,
			en = 10.6
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
				arg_44_0:Play111081012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = manager.ui.mainCamera.transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.shakeOldPos = var_47_0.localPosition
			end

			local var_47_2 = 0.133333333333333

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / 0.066
				local var_47_4, var_47_5 = math.modf(var_47_3)

				var_47_0.localPosition = Vector3.New(var_47_5 * 0.13, var_47_5 * 0.13, var_47_5 * 0.13) + arg_44_1.var_.shakeOldPos
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = arg_44_1.var_.shakeOldPos
			end

			local var_47_6 = 0
			local var_47_7 = 0.3

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_8 = arg_44_1:FormatText(StoryNameCfg[186].name)

				arg_44_1.leftNameTxt_.text = var_47_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_9 = arg_44_1:GetWordFromCfg(111081011)
				local var_47_10 = arg_44_1:FormatText(var_47_9.content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081011", "story_v_out_111081.awb") ~= 0 then
					local var_47_14 = manager.audio:GetVoiceLength("story_v_out_111081", "111081011", "story_v_out_111081.awb") / 1000

					if var_47_14 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_6
					end

					if var_47_9.prefab_name ~= "" and arg_44_1.actors_[var_47_9.prefab_name] ~= nil then
						local var_47_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_9.prefab_name].transform, "story_v_out_111081", "111081011", "story_v_out_111081.awb")

						arg_44_1:RecordAudio("111081011", var_47_15)
						arg_44_1:RecordAudio("111081011", var_47_15)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_111081", "111081011", "story_v_out_111081.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_111081", "111081011", "story_v_out_111081.awb")
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
	Play111081012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 111081012
		arg_48_1.duration_ = 4.67

		local var_48_0 = {
			ja = 4.3,
			ko = 2.933,
			zh = 4.666,
			en = 1.8
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
				arg_48_0:Play111081013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.175

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[176].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(111081012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081012", "story_v_out_111081.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081012", "story_v_out_111081.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_111081", "111081012", "story_v_out_111081.awb")

						arg_48_1:RecordAudio("111081012", var_51_9)
						arg_48_1:RecordAudio("111081012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_111081", "111081012", "story_v_out_111081.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_111081", "111081012", "story_v_out_111081.awb")
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
	Play111081013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 111081013
		arg_52_1.duration_ = 7.2

		local var_52_0 = {
			ja = 5.4,
			ko = 4.7,
			zh = 7.2,
			en = 5.3
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
				arg_52_0:Play111081014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.425

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[176].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(111081013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081013", "story_v_out_111081.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081013", "story_v_out_111081.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_111081", "111081013", "story_v_out_111081.awb")

						arg_52_1:RecordAudio("111081013", var_55_9)
						arg_52_1:RecordAudio("111081013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_111081", "111081013", "story_v_out_111081.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_111081", "111081013", "story_v_out_111081.awb")
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
	Play111081014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 111081014
		arg_56_1.duration_ = 11.63

		local var_56_0 = {
			ja = 9.066,
			ko = 6.266,
			zh = 11.633,
			en = 8.5
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
				arg_56_0:Play111081015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.825

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[186].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(111081014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081014", "story_v_out_111081.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081014", "story_v_out_111081.awb") / 1000

					if var_59_8 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_0
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_111081", "111081014", "story_v_out_111081.awb")

						arg_56_1:RecordAudio("111081014", var_59_9)
						arg_56_1:RecordAudio("111081014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_111081", "111081014", "story_v_out_111081.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_111081", "111081014", "story_v_out_111081.awb")
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
	Play111081015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 111081015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play111081016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.825

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_2 = arg_60_1:GetWordFromCfg(111081015)
				local var_63_3 = arg_60_1:FormatText(var_63_2.content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 33
				local var_63_5 = utf8.len(var_63_3)
				local var_63_6 = var_63_4 <= 0 and var_63_1 or var_63_1 * (var_63_5 / var_63_4)

				if var_63_6 > 0 and var_63_1 < var_63_6 then
					arg_60_1.talkMaxDuration = var_63_6

					if var_63_6 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_7 and arg_60_1.time_ < var_63_0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play111081016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 111081016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play111081017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.8

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_2 = arg_64_1:GetWordFromCfg(111081016)
				local var_67_3 = arg_64_1:FormatText(var_67_2.content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 32
				local var_67_5 = utf8.len(var_67_3)
				local var_67_6 = var_67_4 <= 0 and var_67_1 or var_67_1 * (var_67_5 / var_67_4)

				if var_67_6 > 0 and var_67_1 < var_67_6 then
					arg_64_1.talkMaxDuration = var_67_6

					if var_67_6 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_7 and arg_64_1.time_ < var_67_0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play111081017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 111081017
		arg_68_1.duration_ = 5.5

		local var_68_0 = {
			ja = 5,
			ko = 5.2,
			zh = 5.5,
			en = 5
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
				arg_68_0:Play111081018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = "D999"

			if arg_68_1.bgs_[var_71_0] == nil then
				local var_71_1 = Object.Instantiate(arg_68_1.paintGo_)

				var_71_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_71_0)
				var_71_1.name = var_71_0
				var_71_1.transform.parent = arg_68_1.stage_.transform
				var_71_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.bgs_[var_71_0] = var_71_1
			end

			local var_71_2 = 0

			if var_71_2 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				local var_71_3 = manager.ui.mainCamera.transform.localPosition
				local var_71_4 = Vector3.New(0, 0, 10) + Vector3.New(var_71_3.x, var_71_3.y, 0)
				local var_71_5 = arg_68_1.bgs_.D999

				var_71_5.transform.localPosition = var_71_4
				var_71_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_71_6 = var_71_5:GetComponent("SpriteRenderer")

				if var_71_6 and var_71_6.sprite then
					local var_71_7 = (var_71_5.transform.localPosition - var_71_3).z
					local var_71_8 = manager.ui.mainCameraCom_
					local var_71_9 = 2 * var_71_7 * Mathf.Tan(var_71_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_71_10 = var_71_9 * var_71_8.aspect
					local var_71_11 = var_71_6.sprite.bounds.size.x
					local var_71_12 = var_71_6.sprite.bounds.size.y
					local var_71_13 = var_71_10 / var_71_11
					local var_71_14 = var_71_9 / var_71_12
					local var_71_15 = var_71_14 < var_71_13 and var_71_13 or var_71_14

					var_71_5.transform.localScale = Vector3.New(var_71_15, var_71_15, 0)
				end

				for iter_71_0, iter_71_1 in pairs(arg_68_1.bgs_) do
					if iter_71_0 ~= "D999" then
						iter_71_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_71_16 = 0

			if var_71_16 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 then
				arg_68_1.mask_.enabled = true
				arg_68_1.mask_.raycastTarget = true

				arg_68_1:SetGaussion(false)
			end

			local var_71_17 = 1.5

			if var_71_16 <= arg_68_1.time_ and arg_68_1.time_ < var_71_16 + var_71_17 then
				local var_71_18 = (arg_68_1.time_ - var_71_16) / var_71_17
				local var_71_19 = Color.New(1, 1, 1)

				var_71_19.a = Mathf.Lerp(1, 0, var_71_18)
				arg_68_1.mask_.color = var_71_19
			end

			if arg_68_1.time_ >= var_71_16 + var_71_17 and arg_68_1.time_ < var_71_16 + var_71_17 + arg_71_0 then
				local var_71_20 = Color.New(1, 1, 1)
				local var_71_21 = 0

				arg_68_1.mask_.enabled = false
				var_71_20.a = var_71_21
				arg_68_1.mask_.color = var_71_20
			end

			local var_71_22 = 0

			if var_71_22 < arg_68_1.time_ and arg_68_1.time_ <= var_71_22 + arg_71_0 then
				arg_68_1.allBtn_.enabled = false
			end

			local var_71_23 = 2

			if arg_68_1.time_ >= var_71_22 + var_71_23 and arg_68_1.time_ < var_71_22 + var_71_23 + arg_71_0 then
				arg_68_1.allBtn_.enabled = true
			end

			if arg_68_1.frameCnt_ <= 1 then
				arg_68_1.dialog_:SetActive(false)
			end

			local var_71_24 = 2
			local var_71_25 = 0.25

			if var_71_24 < arg_68_1.time_ and arg_68_1.time_ <= var_71_24 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0

				arg_68_1.dialog_:SetActive(true)

				arg_68_1.dialogCg_.alpha = 0

				local var_71_26 = LeanTween.value(arg_68_1.dialog_, 0, 1, 0.3)

				var_71_26:setOnUpdate(LuaHelper.FloatAction(function(arg_72_0)
					arg_68_1.dialogCg_.alpha = arg_72_0
				end))
				var_71_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_68_1.dialog_)
					var_71_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_68_1.duration_ = arg_68_1.duration_ + 0.3

				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_27 = arg_68_1:FormatText(StoryNameCfg[182].name)

				arg_68_1.leftNameTxt_.text = var_71_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_28 = arg_68_1:GetWordFromCfg(111081017)
				local var_71_29 = arg_68_1:FormatText(var_71_28.content)

				arg_68_1.text_.text = var_71_29

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_30 = 10
				local var_71_31 = utf8.len(var_71_29)
				local var_71_32 = var_71_30 <= 0 and var_71_25 or var_71_25 * (var_71_31 / var_71_30)

				if var_71_32 > 0 and var_71_25 < var_71_32 then
					arg_68_1.talkMaxDuration = var_71_32
					var_71_24 = var_71_24 + 0.3

					if var_71_32 + var_71_24 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_32 + var_71_24
					end
				end

				arg_68_1.text_.text = var_71_29
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081017", "story_v_out_111081.awb") ~= 0 then
					local var_71_33 = manager.audio:GetVoiceLength("story_v_out_111081", "111081017", "story_v_out_111081.awb") / 1000

					if var_71_33 + var_71_24 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_33 + var_71_24
					end

					if var_71_28.prefab_name ~= "" and arg_68_1.actors_[var_71_28.prefab_name] ~= nil then
						local var_71_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_28.prefab_name].transform, "story_v_out_111081", "111081017", "story_v_out_111081.awb")

						arg_68_1:RecordAudio("111081017", var_71_34)
						arg_68_1:RecordAudio("111081017", var_71_34)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_111081", "111081017", "story_v_out_111081.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_111081", "111081017", "story_v_out_111081.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_35 = var_71_24 + 0.3
			local var_71_36 = math.max(var_71_25, arg_68_1.talkMaxDuration)

			if var_71_35 <= arg_68_1.time_ and arg_68_1.time_ < var_71_35 + var_71_36 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_35) / var_71_36

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_35 + var_71_36 and arg_68_1.time_ < var_71_35 + var_71_36 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play111081018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 111081018
		arg_74_1.duration_ = 5.5

		local var_74_0 = {
			ja = 1.5,
			ko = 1.433,
			zh = 5.5,
			en = 2.9
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
				arg_74_0:Play111081019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.05

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[176].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_3 = arg_74_1:GetWordFromCfg(111081018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081018", "story_v_out_111081.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081018", "story_v_out_111081.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_111081", "111081018", "story_v_out_111081.awb")

						arg_74_1:RecordAudio("111081018", var_77_9)
						arg_74_1:RecordAudio("111081018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_111081", "111081018", "story_v_out_111081.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_111081", "111081018", "story_v_out_111081.awb")
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
	Play111081019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 111081019
		arg_78_1.duration_ = 2.67

		local var_78_0 = {
			ja = 1.2,
			ko = 1.333,
			zh = 2.1,
			en = 2.666
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
				arg_78_0:Play111081020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.275

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[182].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_3 = arg_78_1:GetWordFromCfg(111081019)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081019", "story_v_out_111081.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081019", "story_v_out_111081.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_111081", "111081019", "story_v_out_111081.awb")

						arg_78_1:RecordAudio("111081019", var_81_9)
						arg_78_1:RecordAudio("111081019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_111081", "111081019", "story_v_out_111081.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_111081", "111081019", "story_v_out_111081.awb")
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
	Play111081020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 111081020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play111081021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 1.05

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_2 = arg_82_1:GetWordFromCfg(111081020)
				local var_85_3 = arg_82_1:FormatText(var_85_2.content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 42
				local var_85_5 = utf8.len(var_85_3)
				local var_85_6 = var_85_4 <= 0 and var_85_1 or var_85_1 * (var_85_5 / var_85_4)

				if var_85_6 > 0 and var_85_1 < var_85_6 then
					arg_82_1.talkMaxDuration = var_85_6

					if var_85_6 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_6 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_7 and arg_82_1.time_ < var_85_0 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play111081021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 111081021
		arg_86_1.duration_ = 5.4

		local var_86_0 = {
			ja = 3.466,
			ko = 3.633,
			zh = 5.4,
			en = 4.166
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
				arg_86_0:Play111081022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 0.5

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_2 = arg_86_1:FormatText(StoryNameCfg[182].name)

				arg_86_1.leftNameTxt_.text = var_89_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_3 = arg_86_1:GetWordFromCfg(111081021)
				local var_89_4 = arg_86_1:FormatText(var_89_3.content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081021", "story_v_out_111081.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081021", "story_v_out_111081.awb") / 1000

					if var_89_8 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_0
					end

					if var_89_3.prefab_name ~= "" and arg_86_1.actors_[var_89_3.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_3.prefab_name].transform, "story_v_out_111081", "111081021", "story_v_out_111081.awb")

						arg_86_1:RecordAudio("111081021", var_89_9)
						arg_86_1:RecordAudio("111081021", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_111081", "111081021", "story_v_out_111081.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_111081", "111081021", "story_v_out_111081.awb")
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
	Play111081022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 111081022
		arg_90_1.duration_ = 5.97

		local var_90_0 = {
			ja = 0.999999999999,
			ko = 1.8,
			zh = 5.966,
			en = 2.366
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
				arg_90_0:Play111081023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.125

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[176].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:GetWordFromCfg(111081022)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081022", "story_v_out_111081.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081022", "story_v_out_111081.awb") / 1000

					if var_93_8 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_0
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_111081", "111081022", "story_v_out_111081.awb")

						arg_90_1:RecordAudio("111081022", var_93_9)
						arg_90_1:RecordAudio("111081022", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_111081", "111081022", "story_v_out_111081.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_111081", "111081022", "story_v_out_111081.awb")
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
	Play111081023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 111081023
		arg_94_1.duration_ = 15.2

		local var_94_0 = {
			ja = 15.2,
			ko = 10.7,
			zh = 9.566,
			en = 8.7
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
				arg_94_0:Play111081024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.9

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[182].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_3 = arg_94_1:GetWordFromCfg(111081023)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081023", "story_v_out_111081.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081023", "story_v_out_111081.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_111081", "111081023", "story_v_out_111081.awb")

						arg_94_1:RecordAudio("111081023", var_97_9)
						arg_94_1:RecordAudio("111081023", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_111081", "111081023", "story_v_out_111081.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_111081", "111081023", "story_v_out_111081.awb")
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
	Play111081024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 111081024
		arg_98_1.duration_ = 8.17

		local var_98_0 = {
			ja = 8.166,
			ko = 4.733,
			zh = 5,
			en = 6.7
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
				arg_98_0:Play111081025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.3

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[176].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_3 = arg_98_1:GetWordFromCfg(111081024)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081024", "story_v_out_111081.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081024", "story_v_out_111081.awb") / 1000

					if var_101_8 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_0
					end

					if var_101_3.prefab_name ~= "" and arg_98_1.actors_[var_101_3.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_3.prefab_name].transform, "story_v_out_111081", "111081024", "story_v_out_111081.awb")

						arg_98_1:RecordAudio("111081024", var_101_9)
						arg_98_1:RecordAudio("111081024", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_111081", "111081024", "story_v_out_111081.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_111081", "111081024", "story_v_out_111081.awb")
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
	Play111081025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 111081025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play111081026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.725

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_2 = arg_102_1:GetWordFromCfg(111081025)
				local var_105_3 = arg_102_1:FormatText(var_105_2.content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 29
				local var_105_5 = utf8.len(var_105_3)
				local var_105_6 = var_105_4 <= 0 and var_105_1 or var_105_1 * (var_105_5 / var_105_4)

				if var_105_6 > 0 and var_105_1 < var_105_6 then
					arg_102_1.talkMaxDuration = var_105_6

					if var_105_6 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_6 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_7 and arg_102_1.time_ < var_105_0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play111081026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 111081026
		arg_106_1.duration_ = 7.17

		local var_106_0 = {
			ja = 7.166,
			ko = 3.833,
			zh = 5.666,
			en = 4.5
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
				arg_106_0:Play111081027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.425

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[182].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:GetWordFromCfg(111081026)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081026", "story_v_out_111081.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081026", "story_v_out_111081.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_111081", "111081026", "story_v_out_111081.awb")

						arg_106_1:RecordAudio("111081026", var_109_9)
						arg_106_1:RecordAudio("111081026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_111081", "111081026", "story_v_out_111081.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_111081", "111081026", "story_v_out_111081.awb")
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
	Play111081027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 111081027
		arg_110_1.duration_ = 11.67

		local var_110_0 = {
			ja = 11.666,
			ko = 6.9,
			zh = 7.766,
			en = 8
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play111081028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.7

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[182].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:GetWordFromCfg(111081027)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 27
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081027", "story_v_out_111081.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081027", "story_v_out_111081.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_111081", "111081027", "story_v_out_111081.awb")

						arg_110_1:RecordAudio("111081027", var_113_9)
						arg_110_1:RecordAudio("111081027", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_111081", "111081027", "story_v_out_111081.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_111081", "111081027", "story_v_out_111081.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_10 and arg_110_1.time_ < var_113_0 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play111081028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 111081028
		arg_114_1.duration_ = 4.9

		local var_114_0 = {
			ja = 3.566,
			ko = 2.2,
			zh = 4.9,
			en = 1.5
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play111081029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.175

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[176].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_3 = arg_114_1:GetWordFromCfg(111081028)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 7
				local var_117_6 = utf8.len(var_117_4)
				local var_117_7 = var_117_5 <= 0 and var_117_1 or var_117_1 * (var_117_6 / var_117_5)

				if var_117_7 > 0 and var_117_1 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081028", "story_v_out_111081.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081028", "story_v_out_111081.awb") / 1000

					if var_117_8 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_0
					end

					if var_117_3.prefab_name ~= "" and arg_114_1.actors_[var_117_3.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_3.prefab_name].transform, "story_v_out_111081", "111081028", "story_v_out_111081.awb")

						arg_114_1:RecordAudio("111081028", var_117_9)
						arg_114_1:RecordAudio("111081028", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_111081", "111081028", "story_v_out_111081.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_111081", "111081028", "story_v_out_111081.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_10 and arg_114_1.time_ < var_117_0 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play111081029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 111081029
		arg_118_1.duration_ = 8.4

		local var_118_0 = {
			ja = 8.4,
			ko = 5.233,
			zh = 7.266,
			en = 7.333
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play111081030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.65

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_2 = arg_118_1:FormatText(StoryNameCfg[182].name)

				arg_118_1.leftNameTxt_.text = var_121_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_3 = arg_118_1:GetWordFromCfg(111081029)
				local var_121_4 = arg_118_1:FormatText(var_121_3.content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 26
				local var_121_6 = utf8.len(var_121_4)
				local var_121_7 = var_121_5 <= 0 and var_121_1 or var_121_1 * (var_121_6 / var_121_5)

				if var_121_7 > 0 and var_121_1 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_4
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081029", "story_v_out_111081.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081029", "story_v_out_111081.awb") / 1000

					if var_121_8 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_0
					end

					if var_121_3.prefab_name ~= "" and arg_118_1.actors_[var_121_3.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_3.prefab_name].transform, "story_v_out_111081", "111081029", "story_v_out_111081.awb")

						arg_118_1:RecordAudio("111081029", var_121_9)
						arg_118_1:RecordAudio("111081029", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_111081", "111081029", "story_v_out_111081.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_111081", "111081029", "story_v_out_111081.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_10 and arg_118_1.time_ < var_121_0 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play111081030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 111081030
		arg_122_1.duration_ = 3.87

		local var_122_0 = {
			ja = 3.733,
			ko = 2.9,
			zh = 3.866,
			en = 3.3
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play111081031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.425

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_2 = arg_122_1:FormatText(StoryNameCfg[182].name)

				arg_122_1.leftNameTxt_.text = var_125_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_3 = arg_122_1:GetWordFromCfg(111081030)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 17
				local var_125_6 = utf8.len(var_125_4)
				local var_125_7 = var_125_5 <= 0 and var_125_1 or var_125_1 * (var_125_6 / var_125_5)

				if var_125_7 > 0 and var_125_1 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081030", "story_v_out_111081.awb") ~= 0 then
					local var_125_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081030", "story_v_out_111081.awb") / 1000

					if var_125_8 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_0
					end

					if var_125_3.prefab_name ~= "" and arg_122_1.actors_[var_125_3.prefab_name] ~= nil then
						local var_125_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_3.prefab_name].transform, "story_v_out_111081", "111081030", "story_v_out_111081.awb")

						arg_122_1:RecordAudio("111081030", var_125_9)
						arg_122_1:RecordAudio("111081030", var_125_9)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_111081", "111081030", "story_v_out_111081.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_111081", "111081030", "story_v_out_111081.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_10 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_10 and arg_122_1.time_ < var_125_0 + var_125_10 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play111081031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 111081031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play111081032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 0.5

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_2 = arg_126_1:GetWordFromCfg(111081031)
				local var_129_3 = arg_126_1:FormatText(var_129_2.content)

				arg_126_1.text_.text = var_129_3

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 20
				local var_129_5 = utf8.len(var_129_3)
				local var_129_6 = var_129_4 <= 0 and var_129_1 or var_129_1 * (var_129_5 / var_129_4)

				if var_129_6 > 0 and var_129_1 < var_129_6 then
					arg_126_1.talkMaxDuration = var_129_6

					if var_129_6 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_6 + var_129_0
					end
				end

				arg_126_1.text_.text = var_129_3
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_7 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_7 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_7

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_7 and arg_126_1.time_ < var_129_0 + var_129_7 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play111081032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 111081032
		arg_130_1.duration_ = 8.13

		local var_130_0 = {
			ja = 8.133,
			ko = 5.7,
			zh = 8.1,
			en = 7.5
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play111081033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.6

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_2 = arg_130_1:FormatText(StoryNameCfg[182].name)

				arg_130_1.leftNameTxt_.text = var_133_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vena")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_3 = arg_130_1:GetWordFromCfg(111081032)
				local var_133_4 = arg_130_1:FormatText(var_133_3.content)

				arg_130_1.text_.text = var_133_4

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 24
				local var_133_6 = utf8.len(var_133_4)
				local var_133_7 = var_133_5 <= 0 and var_133_1 or var_133_1 * (var_133_6 / var_133_5)

				if var_133_7 > 0 and var_133_1 < var_133_7 then
					arg_130_1.talkMaxDuration = var_133_7

					if var_133_7 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_7 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_4
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081032", "story_v_out_111081.awb") ~= 0 then
					local var_133_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081032", "story_v_out_111081.awb") / 1000

					if var_133_8 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_8 + var_133_0
					end

					if var_133_3.prefab_name ~= "" and arg_130_1.actors_[var_133_3.prefab_name] ~= nil then
						local var_133_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_3.prefab_name].transform, "story_v_out_111081", "111081032", "story_v_out_111081.awb")

						arg_130_1:RecordAudio("111081032", var_133_9)
						arg_130_1:RecordAudio("111081032", var_133_9)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_111081", "111081032", "story_v_out_111081.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_111081", "111081032", "story_v_out_111081.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_10 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_10 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_10

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_10 and arg_130_1.time_ < var_133_0 + var_133_10 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play111081033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 111081033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play111081034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 1

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				local var_137_2 = "stop"
				local var_137_3 = "effect"

				arg_134_1:AudioAction(var_137_2, var_137_3, "se_story", "se_story_rainloop", "")
			end

			local var_137_4 = 0
			local var_137_5 = 1.2

			if var_137_4 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:GetWordFromCfg(111081033)
				local var_137_7 = arg_134_1:FormatText(var_137_6.content)

				arg_134_1.text_.text = var_137_7

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_8 = 48
				local var_137_9 = utf8.len(var_137_7)
				local var_137_10 = var_137_8 <= 0 and var_137_5 or var_137_5 * (var_137_9 / var_137_8)

				if var_137_10 > 0 and var_137_5 < var_137_10 then
					arg_134_1.talkMaxDuration = var_137_10

					if var_137_10 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_7
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_11 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_11 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_11

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_11 and arg_134_1.time_ < var_137_4 + var_137_11 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play111081034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 111081034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play111081035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 0.525

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_2 = arg_138_1:GetWordFromCfg(111081034)
				local var_141_3 = arg_138_1:FormatText(var_141_2.content)

				arg_138_1.text_.text = var_141_3

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_4 = 21
				local var_141_5 = utf8.len(var_141_3)
				local var_141_6 = var_141_4 <= 0 and var_141_1 or var_141_1 * (var_141_5 / var_141_4)

				if var_141_6 > 0 and var_141_1 < var_141_6 then
					arg_138_1.talkMaxDuration = var_141_6

					if var_141_6 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_6 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_3
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_7 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_7 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_7

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_7 and arg_138_1.time_ < var_141_0 + var_141_7 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play111081035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 111081035
		arg_142_1.duration_ = 4.9

		local var_142_0 = {
			ja = 4.9,
			ko = 4.6,
			zh = 3.933,
			en = 3.533
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
				arg_142_0:Play111081036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.225

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[176].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:GetWordFromCfg(111081035)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081035", "story_v_out_111081.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081035", "story_v_out_111081.awb") / 1000

					if var_145_8 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_0
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_out_111081", "111081035", "story_v_out_111081.awb")

						arg_142_1:RecordAudio("111081035", var_145_9)
						arg_142_1:RecordAudio("111081035", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_111081", "111081035", "story_v_out_111081.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_111081", "111081035", "story_v_out_111081.awb")
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
	Play111081036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 111081036
		arg_146_1.duration_ = 8.77

		local var_146_0 = {
			ja = 8.766,
			ko = 2.233,
			zh = 4.7,
			en = 5.1
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
				arg_146_0:Play111081037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.25

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_2 = arg_146_1:FormatText(StoryNameCfg[176].name)

				arg_146_1.leftNameTxt_.text = var_149_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_helena")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_3 = arg_146_1:GetWordFromCfg(111081036)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081036", "story_v_out_111081.awb") ~= 0 then
					local var_149_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081036", "story_v_out_111081.awb") / 1000

					if var_149_8 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_0
					end

					if var_149_3.prefab_name ~= "" and arg_146_1.actors_[var_149_3.prefab_name] ~= nil then
						local var_149_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_3.prefab_name].transform, "story_v_out_111081", "111081036", "story_v_out_111081.awb")

						arg_146_1:RecordAudio("111081036", var_149_9)
						arg_146_1:RecordAudio("111081036", var_149_9)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_111081", "111081036", "story_v_out_111081.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_111081", "111081036", "story_v_out_111081.awb")
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
	Play111081037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 111081037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play111081038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.3

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_2 = arg_150_1:GetWordFromCfg(111081037)
				local var_153_3 = arg_150_1:FormatText(var_153_2.content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 12
				local var_153_5 = utf8.len(var_153_3)
				local var_153_6 = var_153_4 <= 0 and var_153_1 or var_153_1 * (var_153_5 / var_153_4)

				if var_153_6 > 0 and var_153_1 < var_153_6 then
					arg_150_1.talkMaxDuration = var_153_6

					if var_153_6 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_6 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_7 and arg_150_1.time_ < var_153_0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play111081038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 111081038
		arg_154_1.duration_ = 8.13

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play111081039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = "D06_1"

			if arg_154_1.bgs_[var_157_0] == nil then
				local var_157_1 = Object.Instantiate(arg_154_1.paintGo_)

				var_157_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_157_0)
				var_157_1.name = var_157_0
				var_157_1.transform.parent = arg_154_1.stage_.transform
				var_157_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_154_1.bgs_[var_157_0] = var_157_1
			end

			local var_157_2 = 1.5

			if var_157_2 < arg_154_1.time_ and arg_154_1.time_ <= var_157_2 + arg_157_0 then
				local var_157_3 = manager.ui.mainCamera.transform.localPosition
				local var_157_4 = Vector3.New(0, 0, 10) + Vector3.New(var_157_3.x, var_157_3.y, 0)
				local var_157_5 = arg_154_1.bgs_.D06_1

				var_157_5.transform.localPosition = var_157_4
				var_157_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_157_6 = var_157_5:GetComponent("SpriteRenderer")

				if var_157_6 and var_157_6.sprite then
					local var_157_7 = (var_157_5.transform.localPosition - var_157_3).z
					local var_157_8 = manager.ui.mainCameraCom_
					local var_157_9 = 2 * var_157_7 * Mathf.Tan(var_157_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_157_10 = var_157_9 * var_157_8.aspect
					local var_157_11 = var_157_6.sprite.bounds.size.x
					local var_157_12 = var_157_6.sprite.bounds.size.y
					local var_157_13 = var_157_10 / var_157_11
					local var_157_14 = var_157_9 / var_157_12
					local var_157_15 = var_157_14 < var_157_13 and var_157_13 or var_157_14

					var_157_5.transform.localScale = Vector3.New(var_157_15, var_157_15, 0)
				end

				for iter_157_0, iter_157_1 in pairs(arg_154_1.bgs_) do
					if iter_157_0 ~= "D06_1" then
						iter_157_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_157_16 = arg_154_1.bgs_.D06_1
			local var_157_17 = 1.5

			if var_157_17 < arg_154_1.time_ and arg_154_1.time_ <= var_157_17 + arg_157_0 then
				local var_157_18 = var_157_16:GetComponent("SpriteRenderer")

				if var_157_18 then
					arg_154_1.var_.alphaOldValueD06_1 = var_157_18.color.a
					arg_154_1.var_.alphaMatValueD06_1 = var_157_18
				end

				arg_154_1.var_.alphaOldValueD06_1 = 0
			end

			local var_157_19 = 1.5

			if var_157_17 <= arg_154_1.time_ and arg_154_1.time_ < var_157_17 + var_157_19 then
				local var_157_20 = (arg_154_1.time_ - var_157_17) / var_157_19
				local var_157_21 = Mathf.Lerp(arg_154_1.var_.alphaOldValueD06_1, 1, var_157_20)

				if arg_154_1.var_.alphaMatValueD06_1 then
					local var_157_22 = arg_154_1.var_.alphaMatValueD06_1.color

					var_157_22.a = var_157_21
					arg_154_1.var_.alphaMatValueD06_1.color = var_157_22
				end
			end

			if arg_154_1.time_ >= var_157_17 + var_157_19 and arg_154_1.time_ < var_157_17 + var_157_19 + arg_157_0 and arg_154_1.var_.alphaMatValueD06_1 then
				local var_157_23 = arg_154_1.var_.alphaMatValueD06_1
				local var_157_24 = var_157_23.color

				var_157_24.a = 1
				var_157_23.color = var_157_24
			end

			local var_157_25 = arg_154_1.bgs_.D999
			local var_157_26 = 0

			if var_157_26 < arg_154_1.time_ and arg_154_1.time_ <= var_157_26 + arg_157_0 then
				local var_157_27 = var_157_25:GetComponent("SpriteRenderer")

				if var_157_27 then
					arg_154_1.var_.alphaOldValueD999 = var_157_27.color.a
					arg_154_1.var_.alphaMatValueD999 = var_157_27
				end

				arg_154_1.var_.alphaOldValueD999 = 1
			end

			local var_157_28 = 1.5

			if var_157_26 <= arg_154_1.time_ and arg_154_1.time_ < var_157_26 + var_157_28 then
				local var_157_29 = (arg_154_1.time_ - var_157_26) / var_157_28
				local var_157_30 = Mathf.Lerp(arg_154_1.var_.alphaOldValueD999, 0, var_157_29)

				if arg_154_1.var_.alphaMatValueD999 then
					local var_157_31 = arg_154_1.var_.alphaMatValueD999.color

					var_157_31.a = var_157_30
					arg_154_1.var_.alphaMatValueD999.color = var_157_31
				end
			end

			if arg_154_1.time_ >= var_157_26 + var_157_28 and arg_154_1.time_ < var_157_26 + var_157_28 + arg_157_0 and arg_154_1.var_.alphaMatValueD999 then
				local var_157_32 = arg_154_1.var_.alphaMatValueD999
				local var_157_33 = var_157_32.color

				var_157_33.a = 0
				var_157_32.color = var_157_33
			end

			local var_157_34 = 0

			if var_157_34 < arg_154_1.time_ and arg_154_1.time_ <= var_157_34 + arg_157_0 then
				arg_154_1.allBtn_.enabled = false
			end

			local var_157_35 = 2.56666666666667

			if arg_154_1.time_ >= var_157_34 + var_157_35 and arg_154_1.time_ < var_157_34 + var_157_35 + arg_157_0 then
				arg_154_1.allBtn_.enabled = true
			end

			local var_157_36 = 1.4

			arg_154_1.isInRecall_ = false

			if var_157_36 < arg_154_1.time_ and arg_154_1.time_ <= var_157_36 + arg_157_0 then
				arg_154_1.screenFilterGo_:SetActive(false)

				for iter_157_2, iter_157_3 in pairs(arg_154_1.actors_) do
					local var_157_37 = iter_157_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_157_4, iter_157_5 in ipairs(var_157_37) do
						if iter_157_5.color.r > 0.51 then
							iter_157_5.color = Color.New(1, 1, 1)
						else
							iter_157_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_157_38 = 0.2

			if var_157_36 <= arg_154_1.time_ and arg_154_1.time_ < var_157_36 + var_157_38 then
				local var_157_39 = (arg_154_1.time_ - var_157_36) / var_157_38

				arg_154_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_157_39)
			end

			if arg_154_1.time_ >= var_157_36 + var_157_38 and arg_154_1.time_ < var_157_36 + var_157_38 + arg_157_0 then
				arg_154_1.screenFilterEffect_.weight = 0
			end

			if arg_154_1.frameCnt_ <= 1 then
				arg_154_1.dialog_:SetActive(false)
			end

			local var_157_40 = 3.13333333333333
			local var_157_41 = 0.75

			if var_157_40 < arg_154_1.time_ and arg_154_1.time_ <= var_157_40 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0

				arg_154_1.dialog_:SetActive(true)

				arg_154_1.dialogCg_.alpha = 0

				local var_157_42 = LeanTween.value(arg_154_1.dialog_, 0, 1, 0.3)

				var_157_42:setOnUpdate(LuaHelper.FloatAction(function(arg_158_0)
					arg_154_1.dialogCg_.alpha = arg_158_0
				end))
				var_157_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_154_1.dialog_)
					var_157_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_154_1.duration_ = arg_154_1.duration_ + 0.3

				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_43 = arg_154_1:GetWordFromCfg(111081038)
				local var_157_44 = arg_154_1:FormatText(var_157_43.content)

				arg_154_1.text_.text = var_157_44

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_45 = 30
				local var_157_46 = utf8.len(var_157_44)
				local var_157_47 = var_157_45 <= 0 and var_157_41 or var_157_41 * (var_157_46 / var_157_45)

				if var_157_47 > 0 and var_157_41 < var_157_47 then
					arg_154_1.talkMaxDuration = var_157_47
					var_157_40 = var_157_40 + 0.3

					if var_157_47 + var_157_40 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_47 + var_157_40
					end
				end

				arg_154_1.text_.text = var_157_44
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_48 = var_157_40 + 0.3
			local var_157_49 = math.max(var_157_41, arg_154_1.talkMaxDuration)

			if var_157_48 <= arg_154_1.time_ and arg_154_1.time_ < var_157_48 + var_157_49 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_48) / var_157_49

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_48 + var_157_49 and arg_154_1.time_ < var_157_48 + var_157_49 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play111081039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 111081039
		arg_160_1.duration_ = 3.07

		local var_160_0 = {
			ja = 2.833,
			ko = 2.6,
			zh = 3.066,
			en = 2.066
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
				arg_160_0:Play111081040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 1

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				local var_163_2 = "play"
				local var_163_3 = "music"

				arg_160_1:AudioAction(var_163_2, var_163_3, "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story.awb")

				local var_163_4 = ""
				local var_163_5 = manager.audio:GetAudioName("bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story")

				if var_163_5 ~= "" then
					if arg_160_1.bgmTxt_.text ~= var_163_5 and arg_160_1.bgmTxt_.text ~= "" then
						if arg_160_1.bgmTxt2_.text ~= "" then
							arg_160_1.bgmTxt_.text = arg_160_1.bgmTxt2_.text
						end

						arg_160_1.bgmTxt2_.text = var_163_5

						arg_160_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_160_1.bgmTxt_.text = var_163_5
						arg_160_1.bgmTxt2_.text = var_163_5
					end

					if arg_160_1.bgmTimer then
						arg_160_1.bgmTimer:Stop()

						arg_160_1.bgmTimer = nil
					end

					if arg_160_1.settingData.show_music_name == 1 then
						arg_160_1.musicController:SetSelectedState("show")
						arg_160_1.musicAnimator_:Play("open", 0, 0)

						if arg_160_1.settingData.music_time ~= 0 then
							arg_160_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_160_1.settingData.music_time), function()
								if arg_160_1 == nil or isNil(arg_160_1.bgmTxt_) then
									return
								end

								arg_160_1.musicController:SetSelectedState("hide")
								arg_160_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_163_6 = 0
			local var_163_7 = 0.25

			if var_163_6 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_8 = arg_160_1:FormatText(StoryNameCfg[189].name)

				arg_160_1.leftNameTxt_.text = var_163_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_9 = arg_160_1:GetWordFromCfg(111081039)
				local var_163_10 = arg_160_1:FormatText(var_163_9.content)

				arg_160_1.text_.text = var_163_10

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 10
				local var_163_12 = utf8.len(var_163_10)
				local var_163_13 = var_163_11 <= 0 and var_163_7 or var_163_7 * (var_163_12 / var_163_11)

				if var_163_13 > 0 and var_163_7 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_10
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081039", "story_v_out_111081.awb") ~= 0 then
					local var_163_14 = manager.audio:GetVoiceLength("story_v_out_111081", "111081039", "story_v_out_111081.awb") / 1000

					if var_163_14 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_14 + var_163_6
					end

					if var_163_9.prefab_name ~= "" and arg_160_1.actors_[var_163_9.prefab_name] ~= nil then
						local var_163_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_9.prefab_name].transform, "story_v_out_111081", "111081039", "story_v_out_111081.awb")

						arg_160_1:RecordAudio("111081039", var_163_15)
						arg_160_1:RecordAudio("111081039", var_163_15)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_111081", "111081039", "story_v_out_111081.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_111081", "111081039", "story_v_out_111081.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_16 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_16 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_16

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_16 and arg_160_1.time_ < var_163_6 + var_163_16 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play111081040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 111081040
		arg_165_1.duration_ = 3.93

		local var_165_0 = {
			ja = 2.3,
			ko = 3.933,
			zh = 2.166,
			en = 2.266
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play111081041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.45

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[189].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:GetWordFromCfg(111081040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 7
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081040", "story_v_out_111081.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081040", "story_v_out_111081.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_111081", "111081040", "story_v_out_111081.awb")

						arg_165_1:RecordAudio("111081040", var_168_9)
						arg_165_1:RecordAudio("111081040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_111081", "111081040", "story_v_out_111081.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_111081", "111081040", "story_v_out_111081.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_10 and arg_165_1.time_ < var_168_0 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play111081041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 111081041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play111081042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.975

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_2 = arg_169_1:GetWordFromCfg(111081041)
				local var_172_3 = arg_169_1:FormatText(var_172_2.content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 39
				local var_172_5 = utf8.len(var_172_3)
				local var_172_6 = var_172_4 <= 0 and var_172_1 or var_172_1 * (var_172_5 / var_172_4)

				if var_172_6 > 0 and var_172_1 < var_172_6 then
					arg_169_1.talkMaxDuration = var_172_6

					if var_172_6 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_7 and arg_169_1.time_ < var_172_0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play111081042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 111081042
		arg_173_1.duration_ = 3.8

		local var_173_0 = {
			ja = 3.8,
			ko = 2.1,
			zh = 2,
			en = 2
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
				arg_173_0:Play111081043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = "1094ui_story"

			if arg_173_1.actors_[var_176_0] == nil then
				local var_176_1 = Asset.Load("Char/" .. "1094ui_story")

				if not isNil(var_176_1) then
					local var_176_2 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_173_1.stage_.transform)

					var_176_2.name = var_176_0
					var_176_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_173_1.actors_[var_176_0] = var_176_2

					local var_176_3 = var_176_2:GetComponentInChildren(typeof(CharacterEffect))

					var_176_3.enabled = true

					local var_176_4 = GameObjectTools.GetOrAddComponent(var_176_2, typeof(DynamicBoneHelper))

					if var_176_4 then
						var_176_4:EnableDynamicBone(false)
					end

					arg_173_1:ShowWeapon(var_176_3.transform, false)

					arg_173_1.var_[var_176_0 .. "Animator"] = var_176_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_173_1.var_[var_176_0 .. "Animator"].applyRootMotion = true
					arg_173_1.var_[var_176_0 .. "LipSync"] = var_176_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_176_5 = arg_173_1.actors_["1094ui_story"].transform
			local var_176_6 = 0

			if var_176_6 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.var_.moveOldPos1094ui_story = var_176_5.localPosition
			end

			local var_176_7 = 0.001

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_7 then
				local var_176_8 = (arg_173_1.time_ - var_176_6) / var_176_7
				local var_176_9 = Vector3.New(0, -0.84, -6.1)

				var_176_5.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1094ui_story, var_176_9, var_176_8)

				local var_176_10 = manager.ui.mainCamera.transform.position - var_176_5.position

				var_176_5.forward = Vector3.New(var_176_10.x, var_176_10.y, var_176_10.z)

				local var_176_11 = var_176_5.localEulerAngles

				var_176_11.z = 0
				var_176_11.x = 0
				var_176_5.localEulerAngles = var_176_11
			end

			if arg_173_1.time_ >= var_176_6 + var_176_7 and arg_173_1.time_ < var_176_6 + var_176_7 + arg_176_0 then
				var_176_5.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_176_12 = manager.ui.mainCamera.transform.position - var_176_5.position

				var_176_5.forward = Vector3.New(var_176_12.x, var_176_12.y, var_176_12.z)

				local var_176_13 = var_176_5.localEulerAngles

				var_176_13.z = 0
				var_176_13.x = 0
				var_176_5.localEulerAngles = var_176_13
			end

			local var_176_14 = 0

			if var_176_14 < arg_173_1.time_ and arg_173_1.time_ <= var_176_14 + arg_176_0 then
				arg_173_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_176_15 = 0

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_176_16 = arg_173_1.actors_["1094ui_story"]
			local var_176_17 = 0

			if var_176_17 < arg_173_1.time_ and arg_173_1.time_ <= var_176_17 + arg_176_0 and not isNil(var_176_16) and arg_173_1.var_.characterEffect1094ui_story == nil then
				arg_173_1.var_.characterEffect1094ui_story = var_176_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_18 = 0.2

			if var_176_17 <= arg_173_1.time_ and arg_173_1.time_ < var_176_17 + var_176_18 and not isNil(var_176_16) then
				local var_176_19 = (arg_173_1.time_ - var_176_17) / var_176_18

				if arg_173_1.var_.characterEffect1094ui_story and not isNil(var_176_16) then
					arg_173_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_17 + var_176_18 and arg_173_1.time_ < var_176_17 + var_176_18 + arg_176_0 and not isNil(var_176_16) and arg_173_1.var_.characterEffect1094ui_story then
				arg_173_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_176_20 = 0
			local var_176_21 = 0.15

			if var_176_20 < arg_173_1.time_ and arg_173_1.time_ <= var_176_20 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_22 = arg_173_1:FormatText(StoryNameCfg[181].name)

				arg_173_1.leftNameTxt_.text = var_176_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_23 = arg_173_1:GetWordFromCfg(111081042)
				local var_176_24 = arg_173_1:FormatText(var_176_23.content)

				arg_173_1.text_.text = var_176_24

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_25 = 6
				local var_176_26 = utf8.len(var_176_24)
				local var_176_27 = var_176_25 <= 0 and var_176_21 or var_176_21 * (var_176_26 / var_176_25)

				if var_176_27 > 0 and var_176_21 < var_176_27 then
					arg_173_1.talkMaxDuration = var_176_27

					if var_176_27 + var_176_20 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_27 + var_176_20
					end
				end

				arg_173_1.text_.text = var_176_24
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081042", "story_v_out_111081.awb") ~= 0 then
					local var_176_28 = manager.audio:GetVoiceLength("story_v_out_111081", "111081042", "story_v_out_111081.awb") / 1000

					if var_176_28 + var_176_20 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_28 + var_176_20
					end

					if var_176_23.prefab_name ~= "" and arg_173_1.actors_[var_176_23.prefab_name] ~= nil then
						local var_176_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_23.prefab_name].transform, "story_v_out_111081", "111081042", "story_v_out_111081.awb")

						arg_173_1:RecordAudio("111081042", var_176_29)
						arg_173_1:RecordAudio("111081042", var_176_29)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_111081", "111081042", "story_v_out_111081.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_111081", "111081042", "story_v_out_111081.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_30 = math.max(var_176_21, arg_173_1.talkMaxDuration)

			if var_176_20 <= arg_173_1.time_ and arg_173_1.time_ < var_176_20 + var_176_30 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_20) / var_176_30

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_20 + var_176_30 and arg_173_1.time_ < var_176_20 + var_176_30 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play111081043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 111081043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play111081044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1094ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1094ui_story == nil then
				arg_177_1.var_.characterEffect1094ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.2

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1094ui_story and not isNil(var_180_0) then
					local var_180_4 = Mathf.Lerp(0, 0.5, var_180_3)

					arg_177_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1094ui_story.fillRatio = var_180_4
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1094ui_story then
				local var_180_5 = 0.5

				arg_177_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1094ui_story.fillRatio = var_180_5
			end

			local var_180_6 = 0
			local var_180_7 = 0.375

			if var_180_6 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_8 = arg_177_1:FormatText(StoryNameCfg[7].name)

				arg_177_1.leftNameTxt_.text = var_180_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_9 = arg_177_1:GetWordFromCfg(111081043)
				local var_180_10 = arg_177_1:FormatText(var_180_9.content)

				arg_177_1.text_.text = var_180_10

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 15
				local var_180_12 = utf8.len(var_180_10)
				local var_180_13 = var_180_11 <= 0 and var_180_7 or var_180_7 * (var_180_12 / var_180_11)

				if var_180_13 > 0 and var_180_7 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_10
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_14 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_14 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_14

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_14 and arg_177_1.time_ < var_180_6 + var_180_14 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play111081044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 111081044
		arg_181_1.duration_ = 3.8

		local var_181_0 = {
			ja = 3.8,
			ko = 1.999999999999,
			zh = 2.5,
			en = 1.999999999999
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
				arg_181_0:Play111081045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_184_1 = arg_181_1.actors_["1094ui_story"]
			local var_184_2 = 0

			if var_184_2 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1094ui_story == nil then
				arg_181_1.var_.characterEffect1094ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_3 = 0.2

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_3 and not isNil(var_184_1) then
				local var_184_4 = (arg_181_1.time_ - var_184_2) / var_184_3

				if arg_181_1.var_.characterEffect1094ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_2 + var_184_3 and arg_181_1.time_ < var_184_2 + var_184_3 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1094ui_story then
				arg_181_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_184_5 = 0
			local var_184_6 = 0.125

			if var_184_5 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_7 = arg_181_1:FormatText(StoryNameCfg[181].name)

				arg_181_1.leftNameTxt_.text = var_184_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_8 = arg_181_1:GetWordFromCfg(111081044)
				local var_184_9 = arg_181_1:FormatText(var_184_8.content)

				arg_181_1.text_.text = var_184_9

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_10 = 5
				local var_184_11 = utf8.len(var_184_9)
				local var_184_12 = var_184_10 <= 0 and var_184_6 or var_184_6 * (var_184_11 / var_184_10)

				if var_184_12 > 0 and var_184_6 < var_184_12 then
					arg_181_1.talkMaxDuration = var_184_12

					if var_184_12 + var_184_5 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_5
					end
				end

				arg_181_1.text_.text = var_184_9
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081044", "story_v_out_111081.awb") ~= 0 then
					local var_184_13 = manager.audio:GetVoiceLength("story_v_out_111081", "111081044", "story_v_out_111081.awb") / 1000

					if var_184_13 + var_184_5 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_5
					end

					if var_184_8.prefab_name ~= "" and arg_181_1.actors_[var_184_8.prefab_name] ~= nil then
						local var_184_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_8.prefab_name].transform, "story_v_out_111081", "111081044", "story_v_out_111081.awb")

						arg_181_1:RecordAudio("111081044", var_184_14)
						arg_181_1:RecordAudio("111081044", var_184_14)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_111081", "111081044", "story_v_out_111081.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_111081", "111081044", "story_v_out_111081.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_15 = math.max(var_184_6, arg_181_1.talkMaxDuration)

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_15 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_5) / var_184_15

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_5 + var_184_15 and arg_181_1.time_ < var_184_5 + var_184_15 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play111081045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 111081045
		arg_185_1.duration_ = 15.17

		local var_185_0 = {
			ja = 13,
			ko = 15.166,
			zh = 12.333,
			en = 12.4
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play111081046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1094ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1094ui_story == nil then
				arg_185_1.var_.characterEffect1094ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1094ui_story and not isNil(var_188_0) then
					local var_188_4 = Mathf.Lerp(0, 0.5, var_188_3)

					arg_185_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1094ui_story.fillRatio = var_188_4
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1094ui_story then
				local var_188_5 = 0.5

				arg_185_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1094ui_story.fillRatio = var_188_5
			end

			local var_188_6 = 0
			local var_188_7 = 1.475

			if var_188_6 < arg_185_1.time_ and arg_185_1.time_ <= var_188_6 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_8 = arg_185_1:FormatText(StoryNameCfg[177].name)

				arg_185_1.leftNameTxt_.text = var_188_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_9 = arg_185_1:GetWordFromCfg(111081045)
				local var_188_10 = arg_185_1:FormatText(var_188_9.content)

				arg_185_1.text_.text = var_188_10

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_11 = 59
				local var_188_12 = utf8.len(var_188_10)
				local var_188_13 = var_188_11 <= 0 and var_188_7 or var_188_7 * (var_188_12 / var_188_11)

				if var_188_13 > 0 and var_188_7 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_6
					end
				end

				arg_185_1.text_.text = var_188_10
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081045", "story_v_out_111081.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_111081", "111081045", "story_v_out_111081.awb") / 1000

					if var_188_14 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_6
					end

					if var_188_9.prefab_name ~= "" and arg_185_1.actors_[var_188_9.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_9.prefab_name].transform, "story_v_out_111081", "111081045", "story_v_out_111081.awb")

						arg_185_1:RecordAudio("111081045", var_188_15)
						arg_185_1:RecordAudio("111081045", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_111081", "111081045", "story_v_out_111081.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_111081", "111081045", "story_v_out_111081.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_7, arg_185_1.talkMaxDuration)

			if var_188_6 <= arg_185_1.time_ and arg_185_1.time_ < var_188_6 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_6) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_6 + var_188_16 and arg_185_1.time_ < var_188_6 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play111081046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 111081046
		arg_189_1.duration_ = 3.83

		local var_189_0 = {
			ja = 3.833,
			ko = 2.766,
			zh = 2.566,
			en = 2.8
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
				arg_189_0:Play111081047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.275

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[189].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:GetWordFromCfg(111081046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 9
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081046", "story_v_out_111081.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081046", "story_v_out_111081.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_111081", "111081046", "story_v_out_111081.awb")

						arg_189_1:RecordAudio("111081046", var_192_9)
						arg_189_1:RecordAudio("111081046", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_111081", "111081046", "story_v_out_111081.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_111081", "111081046", "story_v_out_111081.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_10 and arg_189_1.time_ < var_192_0 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play111081047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 111081047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play111081048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.875

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:GetWordFromCfg(111081047)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 35
				local var_196_5 = utf8.len(var_196_3)
				local var_196_6 = var_196_4 <= 0 and var_196_1 or var_196_1 * (var_196_5 / var_196_4)

				if var_196_6 > 0 and var_196_1 < var_196_6 then
					arg_193_1.talkMaxDuration = var_196_6

					if var_196_6 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_7 and arg_193_1.time_ < var_196_0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play111081048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 111081048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play111081049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 1.325

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_2 = arg_197_1:GetWordFromCfg(111081048)
				local var_200_3 = arg_197_1:FormatText(var_200_2.content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 53
				local var_200_5 = utf8.len(var_200_3)
				local var_200_6 = var_200_4 <= 0 and var_200_1 or var_200_1 * (var_200_5 / var_200_4)

				if var_200_6 > 0 and var_200_1 < var_200_6 then
					arg_197_1.talkMaxDuration = var_200_6

					if var_200_6 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_6 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_7 and arg_197_1.time_ < var_200_0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play111081049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 111081049
		arg_201_1.duration_ = 5.07

		local var_201_0 = {
			ja = 5.066,
			ko = 2.066,
			zh = 3.7,
			en = 1.566
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
				arg_201_0:Play111081050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.225

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[189].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:GetWordFromCfg(111081049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081049", "story_v_out_111081.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081049", "story_v_out_111081.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_111081", "111081049", "story_v_out_111081.awb")

						arg_201_1:RecordAudio("111081049", var_204_9)
						arg_201_1:RecordAudio("111081049", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_111081", "111081049", "story_v_out_111081.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_111081", "111081049", "story_v_out_111081.awb")
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
	Play111081050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 111081050
		arg_205_1.duration_ = 2

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play111081051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_208_1 = arg_205_1.actors_["1094ui_story"]
			local var_208_2 = 0

			if var_208_2 < arg_205_1.time_ and arg_205_1.time_ <= var_208_2 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1094ui_story == nil then
				arg_205_1.var_.characterEffect1094ui_story = var_208_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_3 = 0.2

			if var_208_2 <= arg_205_1.time_ and arg_205_1.time_ < var_208_2 + var_208_3 and not isNil(var_208_1) then
				local var_208_4 = (arg_205_1.time_ - var_208_2) / var_208_3

				if arg_205_1.var_.characterEffect1094ui_story and not isNil(var_208_1) then
					arg_205_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_2 + var_208_3 and arg_205_1.time_ < var_208_2 + var_208_3 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1094ui_story then
				arg_205_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_208_5 = 0

			if var_208_5 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_208_6 = 0
			local var_208_7 = 0.05

			if var_208_6 < arg_205_1.time_ and arg_205_1.time_ <= var_208_6 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_8 = arg_205_1:FormatText(StoryNameCfg[181].name)

				arg_205_1.leftNameTxt_.text = var_208_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_9 = arg_205_1:GetWordFromCfg(111081050)
				local var_208_10 = arg_205_1:FormatText(var_208_9.content)

				arg_205_1.text_.text = var_208_10

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_11 = 2
				local var_208_12 = utf8.len(var_208_10)
				local var_208_13 = var_208_11 <= 0 and var_208_7 or var_208_7 * (var_208_12 / var_208_11)

				if var_208_13 > 0 and var_208_7 < var_208_13 then
					arg_205_1.talkMaxDuration = var_208_13

					if var_208_13 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_13 + var_208_6
					end
				end

				arg_205_1.text_.text = var_208_10
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081050", "story_v_out_111081.awb") ~= 0 then
					local var_208_14 = manager.audio:GetVoiceLength("story_v_out_111081", "111081050", "story_v_out_111081.awb") / 1000

					if var_208_14 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_14 + var_208_6
					end

					if var_208_9.prefab_name ~= "" and arg_205_1.actors_[var_208_9.prefab_name] ~= nil then
						local var_208_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_9.prefab_name].transform, "story_v_out_111081", "111081050", "story_v_out_111081.awb")

						arg_205_1:RecordAudio("111081050", var_208_15)
						arg_205_1:RecordAudio("111081050", var_208_15)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_111081", "111081050", "story_v_out_111081.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_111081", "111081050", "story_v_out_111081.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_16 = math.max(var_208_7, arg_205_1.talkMaxDuration)

			if var_208_6 <= arg_205_1.time_ and arg_205_1.time_ < var_208_6 + var_208_16 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_6) / var_208_16

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_6 + var_208_16 and arg_205_1.time_ < var_208_6 + var_208_16 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play111081051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 111081051
		arg_209_1.duration_ = 7.8

		local var_209_0 = {
			ja = 7.8,
			ko = 3.5,
			zh = 3.533,
			en = 2.866
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
				arg_209_0:Play111081052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1094ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1094ui_story == nil then
				arg_209_1.var_.characterEffect1094ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.2

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1094ui_story and not isNil(var_212_0) then
					local var_212_4 = Mathf.Lerp(0, 0.5, var_212_3)

					arg_209_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1094ui_story.fillRatio = var_212_4
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1094ui_story then
				local var_212_5 = 0.5

				arg_209_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1094ui_story.fillRatio = var_212_5
			end

			local var_212_6 = 0
			local var_212_7 = 0.375

			if var_212_6 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_8 = arg_209_1:FormatText(StoryNameCfg[189].name)

				arg_209_1.leftNameTxt_.text = var_212_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_9 = arg_209_1:GetWordFromCfg(111081051)
				local var_212_10 = arg_209_1:FormatText(var_212_9.content)

				arg_209_1.text_.text = var_212_10

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 15
				local var_212_12 = utf8.len(var_212_10)
				local var_212_13 = var_212_11 <= 0 and var_212_7 or var_212_7 * (var_212_12 / var_212_11)

				if var_212_13 > 0 and var_212_7 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_10
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081051", "story_v_out_111081.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_out_111081", "111081051", "story_v_out_111081.awb") / 1000

					if var_212_14 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_6
					end

					if var_212_9.prefab_name ~= "" and arg_209_1.actors_[var_212_9.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_9.prefab_name].transform, "story_v_out_111081", "111081051", "story_v_out_111081.awb")

						arg_209_1:RecordAudio("111081051", var_212_15)
						arg_209_1:RecordAudio("111081051", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_111081", "111081051", "story_v_out_111081.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_111081", "111081051", "story_v_out_111081.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_16 and arg_209_1.time_ < var_212_6 + var_212_16 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play111081052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 111081052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play111081053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.525

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[7].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(111081052)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 21
				local var_216_6 = utf8.len(var_216_4)
				local var_216_7 = var_216_5 <= 0 and var_216_1 or var_216_1 * (var_216_6 / var_216_5)

				if var_216_7 > 0 and var_216_1 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_8 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_8 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_8

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_8 and arg_213_1.time_ < var_216_0 + var_216_8 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play111081053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 111081053
		arg_217_1.duration_ = 4.87

		local var_217_0 = {
			ja = 4.866,
			ko = 3.433,
			zh = 4.8,
			en = 3.966
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
				arg_217_0:Play111081054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.425

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[189].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(111081053)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 17
				local var_220_6 = utf8.len(var_220_4)
				local var_220_7 = var_220_5 <= 0 and var_220_1 or var_220_1 * (var_220_6 / var_220_5)

				if var_220_7 > 0 and var_220_1 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081053", "story_v_out_111081.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081053", "story_v_out_111081.awb") / 1000

					if var_220_8 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_0
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_out_111081", "111081053", "story_v_out_111081.awb")

						arg_217_1:RecordAudio("111081053", var_220_9)
						arg_217_1:RecordAudio("111081053", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_111081", "111081053", "story_v_out_111081.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_111081", "111081053", "story_v_out_111081.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_10 and arg_217_1.time_ < var_220_0 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play111081054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 111081054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play111081055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 1.025

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[7].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:GetWordFromCfg(111081054)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 41
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_8 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_8 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_8

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_8 and arg_221_1.time_ < var_224_0 + var_224_8 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play111081055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 111081055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play111081056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.85

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_2 = arg_225_1:GetWordFromCfg(111081055)
				local var_228_3 = arg_225_1:FormatText(var_228_2.content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 34
				local var_228_5 = utf8.len(var_228_3)
				local var_228_6 = var_228_4 <= 0 and var_228_1 or var_228_1 * (var_228_5 / var_228_4)

				if var_228_6 > 0 and var_228_1 < var_228_6 then
					arg_225_1.talkMaxDuration = var_228_6

					if var_228_6 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_7 and arg_225_1.time_ < var_228_0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play111081056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 111081056
		arg_229_1.duration_ = 3.1

		local var_229_0 = {
			ja = 3.1,
			ko = 1.266,
			zh = 1.666,
			en = 1.533
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
				arg_229_0:Play111081057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.125

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[189].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:GetWordFromCfg(111081056)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 5
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081056", "story_v_out_111081.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081056", "story_v_out_111081.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_111081", "111081056", "story_v_out_111081.awb")

						arg_229_1:RecordAudio("111081056", var_232_9)
						arg_229_1:RecordAudio("111081056", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_111081", "111081056", "story_v_out_111081.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_111081", "111081056", "story_v_out_111081.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_10 and arg_229_1.time_ < var_232_0 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play111081057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 111081057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play111081058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 0.05

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_2 = arg_233_1:FormatText(StoryNameCfg[7].name)

				arg_233_1.leftNameTxt_.text = var_236_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_3 = arg_233_1:GetWordFromCfg(111081057)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 2
				local var_236_6 = utf8.len(var_236_4)
				local var_236_7 = var_236_5 <= 0 and var_236_1 or var_236_1 * (var_236_6 / var_236_5)

				if var_236_7 > 0 and var_236_1 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_4
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_8 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_8 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_8

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_8 and arg_233_1.time_ < var_236_0 + var_236_8 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play111081058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 111081058
		arg_237_1.duration_ = 3.27

		local var_237_0 = {
			ja = 2.833,
			ko = 2.7,
			zh = 3.266,
			en = 3.033
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
				arg_237_0:Play111081059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.2

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_2 = arg_237_1:FormatText(StoryNameCfg[189].name)

				arg_237_1.leftNameTxt_.text = var_240_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:GetWordFromCfg(111081058)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 8
				local var_240_6 = utf8.len(var_240_4)
				local var_240_7 = var_240_5 <= 0 and var_240_1 or var_240_1 * (var_240_6 / var_240_5)

				if var_240_7 > 0 and var_240_1 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081058", "story_v_out_111081.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081058", "story_v_out_111081.awb") / 1000

					if var_240_8 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_0
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_111081", "111081058", "story_v_out_111081.awb")

						arg_237_1:RecordAudio("111081058", var_240_9)
						arg_237_1:RecordAudio("111081058", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_111081", "111081058", "story_v_out_111081.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_111081", "111081058", "story_v_out_111081.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_10 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_10 and arg_237_1.time_ < var_240_0 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play111081059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 111081059
		arg_241_1.duration_ = 10.63

		local var_241_0 = {
			ja = 10.133,
			ko = 7.2,
			zh = 7.033,
			en = 10.633
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play111081060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.6

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[189].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:GetWordFromCfg(111081059)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 21
				local var_244_6 = utf8.len(var_244_4)
				local var_244_7 = var_244_5 <= 0 and var_244_1 or var_244_1 * (var_244_6 / var_244_5)

				if var_244_7 > 0 and var_244_1 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081059", "story_v_out_111081.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081059", "story_v_out_111081.awb") / 1000

					if var_244_8 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_0
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_111081", "111081059", "story_v_out_111081.awb")

						arg_241_1:RecordAudio("111081059", var_244_9)
						arg_241_1:RecordAudio("111081059", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_111081", "111081059", "story_v_out_111081.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_111081", "111081059", "story_v_out_111081.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_10 and arg_241_1.time_ < var_244_0 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play111081060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 111081060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play111081061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1094ui_story"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos1094ui_story = var_248_0.localPosition
			end

			local var_248_2 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2
				local var_248_4 = Vector3.New(0, 100, 0)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1094ui_story, var_248_4, var_248_3)

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
			local var_248_10 = 0.9

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

				local var_248_11 = arg_245_1:GetWordFromCfg(111081060)
				local var_248_12 = arg_245_1:FormatText(var_248_11.content)

				arg_245_1.text_.text = var_248_12

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_13 = 36
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
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play111081061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 111081061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play111081062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 1.05

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

				local var_252_2 = arg_249_1:GetWordFromCfg(111081061)
				local var_252_3 = arg_249_1:FormatText(var_252_2.content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 42
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
	Play111081062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 111081062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play111081063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.8

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_2 = arg_253_1:GetWordFromCfg(111081062)
				local var_256_3 = arg_253_1:FormatText(var_256_2.content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 32
				local var_256_5 = utf8.len(var_256_3)
				local var_256_6 = var_256_4 <= 0 and var_256_1 or var_256_1 * (var_256_5 / var_256_4)

				if var_256_6 > 0 and var_256_1 < var_256_6 then
					arg_253_1.talkMaxDuration = var_256_6

					if var_256_6 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_7 and arg_253_1.time_ < var_256_0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play111081063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 111081063
		arg_257_1.duration_ = 5.73

		local var_257_0 = {
			ja = 4.766,
			ko = 4.7,
			zh = 5.733,
			en = 1.666
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
				arg_257_0:Play111081064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.775

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[189].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(111081063)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 24
				local var_260_6 = utf8.len(var_260_4)
				local var_260_7 = var_260_5 <= 0 and var_260_1 or var_260_1 * (var_260_6 / var_260_5)

				if var_260_7 > 0 and var_260_1 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081063", "story_v_out_111081.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081063", "story_v_out_111081.awb") / 1000

					if var_260_8 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_0
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_111081", "111081063", "story_v_out_111081.awb")

						arg_257_1:RecordAudio("111081063", var_260_9)
						arg_257_1:RecordAudio("111081063", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_111081", "111081063", "story_v_out_111081.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_111081", "111081063", "story_v_out_111081.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_10 and arg_257_1.time_ < var_260_0 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play111081064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 111081064
		arg_261_1.duration_ = 4.2

		local var_261_0 = {
			ja = 3.2,
			ko = 4.2,
			zh = 1.9,
			en = 2
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
				arg_261_0:Play111081065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.425

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[189].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:GetWordFromCfg(111081064)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 7
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081064", "story_v_out_111081.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081064", "story_v_out_111081.awb") / 1000

					if var_264_8 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_0
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_111081", "111081064", "story_v_out_111081.awb")

						arg_261_1:RecordAudio("111081064", var_264_9)
						arg_261_1:RecordAudio("111081064", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_111081", "111081064", "story_v_out_111081.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_111081", "111081064", "story_v_out_111081.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_10 and arg_261_1.time_ < var_264_0 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play111081065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 111081065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play111081066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.7

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[7].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:GetWordFromCfg(111081065)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 28
				local var_268_6 = utf8.len(var_268_4)
				local var_268_7 = var_268_5 <= 0 and var_268_1 or var_268_1 * (var_268_6 / var_268_5)

				if var_268_7 > 0 and var_268_1 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_8 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_8 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_8

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_8 and arg_265_1.time_ < var_268_0 + var_268_8 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play111081066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 111081066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play111081067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.55

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[7].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_3 = arg_269_1:GetWordFromCfg(111081066)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 22
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_8 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_8 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_8

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_8 and arg_269_1.time_ < var_272_0 + var_272_8 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play111081067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 111081067
		arg_273_1.duration_ = 9.07

		local var_273_0 = {
			ja = 9.066,
			ko = 6.633,
			zh = 7.2,
			en = 7.366
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
				arg_273_0:Play111081068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 0.725

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[189].name)

				arg_273_1.leftNameTxt_.text = var_276_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_3 = arg_273_1:GetWordFromCfg(111081067)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 29
				local var_276_6 = utf8.len(var_276_4)
				local var_276_7 = var_276_5 <= 0 and var_276_1 or var_276_1 * (var_276_6 / var_276_5)

				if var_276_7 > 0 and var_276_1 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081067", "story_v_out_111081.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081067", "story_v_out_111081.awb") / 1000

					if var_276_8 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_0
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_out_111081", "111081067", "story_v_out_111081.awb")

						arg_273_1:RecordAudio("111081067", var_276_9)
						arg_273_1:RecordAudio("111081067", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_111081", "111081067", "story_v_out_111081.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_111081", "111081067", "story_v_out_111081.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_10 and arg_273_1.time_ < var_276_0 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play111081068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 111081068
		arg_277_1.duration_ = 4.17

		local var_277_0 = {
			ja = 4.066,
			ko = 4.066,
			zh = 4.166,
			en = 3.4
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play111081069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.375

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[189].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:GetWordFromCfg(111081068)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 15
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081068", "story_v_out_111081.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081068", "story_v_out_111081.awb") / 1000

					if var_280_8 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_0
					end

					if var_280_3.prefab_name ~= "" and arg_277_1.actors_[var_280_3.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_3.prefab_name].transform, "story_v_out_111081", "111081068", "story_v_out_111081.awb")

						arg_277_1:RecordAudio("111081068", var_280_9)
						arg_277_1:RecordAudio("111081068", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_111081", "111081068", "story_v_out_111081.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_111081", "111081068", "story_v_out_111081.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_10 and arg_277_1.time_ < var_280_0 + var_280_10 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play111081069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 111081069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play111081070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 1.025

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[7].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_3 = arg_281_1:GetWordFromCfg(111081069)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 41
				local var_284_6 = utf8.len(var_284_4)
				local var_284_7 = var_284_5 <= 0 and var_284_1 or var_284_1 * (var_284_6 / var_284_5)

				if var_284_7 > 0 and var_284_1 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_8 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_8 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_8

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_8 and arg_281_1.time_ < var_284_0 + var_284_8 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play111081070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 111081070
		arg_285_1.duration_ = 4.37

		local var_285_0 = {
			ja = 2.933,
			ko = 3.8,
			zh = 4.366,
			en = 3.5
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
				arg_285_0:Play111081071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.325

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_2 = arg_285_1:FormatText(StoryNameCfg[189].name)

				arg_285_1.leftNameTxt_.text = var_288_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_3 = arg_285_1:GetWordFromCfg(111081070)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 13
				local var_288_6 = utf8.len(var_288_4)
				local var_288_7 = var_288_5 <= 0 and var_288_1 or var_288_1 * (var_288_6 / var_288_5)

				if var_288_7 > 0 and var_288_1 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081070", "story_v_out_111081.awb") ~= 0 then
					local var_288_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081070", "story_v_out_111081.awb") / 1000

					if var_288_8 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_0
					end

					if var_288_3.prefab_name ~= "" and arg_285_1.actors_[var_288_3.prefab_name] ~= nil then
						local var_288_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_3.prefab_name].transform, "story_v_out_111081", "111081070", "story_v_out_111081.awb")

						arg_285_1:RecordAudio("111081070", var_288_9)
						arg_285_1:RecordAudio("111081070", var_288_9)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_111081", "111081070", "story_v_out_111081.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_111081", "111081070", "story_v_out_111081.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_10 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_10 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_10

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_10 and arg_285_1.time_ < var_288_0 + var_288_10 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play111081071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 111081071
		arg_289_1.duration_ = 2.13

		local var_289_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.133,
			en = 2.133
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
				arg_289_0:Play111081072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_292_2 = arg_289_1.actors_["1094ui_story"]
			local var_292_3 = 0

			if var_292_3 < arg_289_1.time_ and arg_289_1.time_ <= var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.characterEffect1094ui_story == nil then
				arg_289_1.var_.characterEffect1094ui_story = var_292_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_4 = 0.2

			if var_292_3 <= arg_289_1.time_ and arg_289_1.time_ < var_292_3 + var_292_4 and not isNil(var_292_2) then
				local var_292_5 = (arg_289_1.time_ - var_292_3) / var_292_4

				if arg_289_1.var_.characterEffect1094ui_story and not isNil(var_292_2) then
					arg_289_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_3 + var_292_4 and arg_289_1.time_ < var_292_3 + var_292_4 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.characterEffect1094ui_story then
				arg_289_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_292_6 = arg_289_1.actors_["1094ui_story"].transform
			local var_292_7 = 0

			if var_292_7 < arg_289_1.time_ and arg_289_1.time_ <= var_292_7 + arg_292_0 then
				arg_289_1.var_.moveOldPos1094ui_story = var_292_6.localPosition
			end

			local var_292_8 = 0.001

			if var_292_7 <= arg_289_1.time_ and arg_289_1.time_ < var_292_7 + var_292_8 then
				local var_292_9 = (arg_289_1.time_ - var_292_7) / var_292_8
				local var_292_10 = Vector3.New(0, -0.84, -6.1)

				var_292_6.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1094ui_story, var_292_10, var_292_9)

				local var_292_11 = manager.ui.mainCamera.transform.position - var_292_6.position

				var_292_6.forward = Vector3.New(var_292_11.x, var_292_11.y, var_292_11.z)

				local var_292_12 = var_292_6.localEulerAngles

				var_292_12.z = 0
				var_292_12.x = 0
				var_292_6.localEulerAngles = var_292_12
			end

			if arg_289_1.time_ >= var_292_7 + var_292_8 and arg_289_1.time_ < var_292_7 + var_292_8 + arg_292_0 then
				var_292_6.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_292_13 = manager.ui.mainCamera.transform.position - var_292_6.position

				var_292_6.forward = Vector3.New(var_292_13.x, var_292_13.y, var_292_13.z)

				local var_292_14 = var_292_6.localEulerAngles

				var_292_14.z = 0
				var_292_14.x = 0
				var_292_6.localEulerAngles = var_292_14
			end

			local var_292_15 = 0
			local var_292_16 = 0.075

			if var_292_15 < arg_289_1.time_ and arg_289_1.time_ <= var_292_15 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_17 = arg_289_1:FormatText(StoryNameCfg[181].name)

				arg_289_1.leftNameTxt_.text = var_292_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_18 = arg_289_1:GetWordFromCfg(111081071)
				local var_292_19 = arg_289_1:FormatText(var_292_18.content)

				arg_289_1.text_.text = var_292_19

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_20 = 3
				local var_292_21 = utf8.len(var_292_19)
				local var_292_22 = var_292_20 <= 0 and var_292_16 or var_292_16 * (var_292_21 / var_292_20)

				if var_292_22 > 0 and var_292_16 < var_292_22 then
					arg_289_1.talkMaxDuration = var_292_22

					if var_292_22 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_22 + var_292_15
					end
				end

				arg_289_1.text_.text = var_292_19
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081071", "story_v_out_111081.awb") ~= 0 then
					local var_292_23 = manager.audio:GetVoiceLength("story_v_out_111081", "111081071", "story_v_out_111081.awb") / 1000

					if var_292_23 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_23 + var_292_15
					end

					if var_292_18.prefab_name ~= "" and arg_289_1.actors_[var_292_18.prefab_name] ~= nil then
						local var_292_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_18.prefab_name].transform, "story_v_out_111081", "111081071", "story_v_out_111081.awb")

						arg_289_1:RecordAudio("111081071", var_292_24)
						arg_289_1:RecordAudio("111081071", var_292_24)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_111081", "111081071", "story_v_out_111081.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_111081", "111081071", "story_v_out_111081.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_25 = math.max(var_292_16, arg_289_1.talkMaxDuration)

			if var_292_15 <= arg_289_1.time_ and arg_289_1.time_ < var_292_15 + var_292_25 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_15) / var_292_25

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_15 + var_292_25 and arg_289_1.time_ < var_292_15 + var_292_25 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play111081072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 111081072
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play111081073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1094ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1094ui_story == nil then
				arg_293_1.var_.characterEffect1094ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.2

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1094ui_story and not isNil(var_296_0) then
					local var_296_4 = Mathf.Lerp(0, 0.5, var_296_3)

					arg_293_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1094ui_story.fillRatio = var_296_4
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1094ui_story then
				local var_296_5 = 0.5

				arg_293_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1094ui_story.fillRatio = var_296_5
			end

			local var_296_6 = 0
			local var_296_7 = 0.2

			if var_296_6 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_8 = arg_293_1:FormatText(StoryNameCfg[7].name)

				arg_293_1.leftNameTxt_.text = var_296_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_9 = arg_293_1:GetWordFromCfg(111081072)
				local var_296_10 = arg_293_1:FormatText(var_296_9.content)

				arg_293_1.text_.text = var_296_10

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_11 = 8
				local var_296_12 = utf8.len(var_296_10)
				local var_296_13 = var_296_11 <= 0 and var_296_7 or var_296_7 * (var_296_12 / var_296_11)

				if var_296_13 > 0 and var_296_7 < var_296_13 then
					arg_293_1.talkMaxDuration = var_296_13

					if var_296_13 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_13 + var_296_6
					end
				end

				arg_293_1.text_.text = var_296_10
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_14 = math.max(var_296_7, arg_293_1.talkMaxDuration)

			if var_296_6 <= arg_293_1.time_ and arg_293_1.time_ < var_296_6 + var_296_14 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_6) / var_296_14

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_6 + var_296_14 and arg_293_1.time_ < var_296_6 + var_296_14 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play111081073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 111081073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play111081074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 1.95

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_2 = arg_297_1:GetWordFromCfg(111081073)
				local var_300_3 = arg_297_1:FormatText(var_300_2.content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_4 = 78
				local var_300_5 = utf8.len(var_300_3)
				local var_300_6 = var_300_4 <= 0 and var_300_1 or var_300_1 * (var_300_5 / var_300_4)

				if var_300_6 > 0 and var_300_1 < var_300_6 then
					arg_297_1.talkMaxDuration = var_300_6

					if var_300_6 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_6 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_7 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_7 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_7

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_7 and arg_297_1.time_ < var_300_0 + var_300_7 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play111081074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 111081074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play111081075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 1.075

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_2 = arg_301_1:GetWordFromCfg(111081074)
				local var_304_3 = arg_301_1:FormatText(var_304_2.content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 43
				local var_304_5 = utf8.len(var_304_3)
				local var_304_6 = var_304_4 <= 0 and var_304_1 or var_304_1 * (var_304_5 / var_304_4)

				if var_304_6 > 0 and var_304_1 < var_304_6 then
					arg_301_1.talkMaxDuration = var_304_6

					if var_304_6 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_6 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_7 and arg_301_1.time_ < var_304_0 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play111081075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 111081075
		arg_305_1.duration_ = 5

		local var_305_0 = {
			ja = 5,
			ko = 2.933,
			zh = 3.066,
			en = 2.2
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
				arg_305_0:Play111081076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.3

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[189].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:GetWordFromCfg(111081075)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081075", "story_v_out_111081.awb") ~= 0 then
					local var_308_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081075", "story_v_out_111081.awb") / 1000

					if var_308_8 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_0
					end

					if var_308_3.prefab_name ~= "" and arg_305_1.actors_[var_308_3.prefab_name] ~= nil then
						local var_308_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_3.prefab_name].transform, "story_v_out_111081", "111081075", "story_v_out_111081.awb")

						arg_305_1:RecordAudio("111081075", var_308_9)
						arg_305_1:RecordAudio("111081075", var_308_9)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_111081", "111081075", "story_v_out_111081.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_111081", "111081075", "story_v_out_111081.awb")
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
	Play111081076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 111081076
		arg_309_1.duration_ = 4.6

		local var_309_0 = {
			ja = 3.4,
			ko = 2.8,
			zh = 4.6,
			en = 2.566
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
				arg_309_0:Play111081077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.375

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[189].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:GetWordFromCfg(111081076)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 15
				local var_312_6 = utf8.len(var_312_4)
				local var_312_7 = var_312_5 <= 0 and var_312_1 or var_312_1 * (var_312_6 / var_312_5)

				if var_312_7 > 0 and var_312_1 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081076", "story_v_out_111081.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081076", "story_v_out_111081.awb") / 1000

					if var_312_8 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_0
					end

					if var_312_3.prefab_name ~= "" and arg_309_1.actors_[var_312_3.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_3.prefab_name].transform, "story_v_out_111081", "111081076", "story_v_out_111081.awb")

						arg_309_1:RecordAudio("111081076", var_312_9)
						arg_309_1:RecordAudio("111081076", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_111081", "111081076", "story_v_out_111081.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_111081", "111081076", "story_v_out_111081.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_10 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_10 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_10

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_10 and arg_309_1.time_ < var_312_0 + var_312_10 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play111081077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 111081077
		arg_313_1.duration_ = 2

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play111081078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_2")
			end

			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_316_2 = arg_313_1.actors_["1094ui_story"]
			local var_316_3 = 0

			if var_316_3 < arg_313_1.time_ and arg_313_1.time_ <= var_316_3 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.characterEffect1094ui_story == nil then
				arg_313_1.var_.characterEffect1094ui_story = var_316_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_4 = 0.2

			if var_316_3 <= arg_313_1.time_ and arg_313_1.time_ < var_316_3 + var_316_4 and not isNil(var_316_2) then
				local var_316_5 = (arg_313_1.time_ - var_316_3) / var_316_4

				if arg_313_1.var_.characterEffect1094ui_story and not isNil(var_316_2) then
					arg_313_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_3 + var_316_4 and arg_313_1.time_ < var_316_3 + var_316_4 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.characterEffect1094ui_story then
				arg_313_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_316_6 = 0
			local var_316_7 = 0.05

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_8 = arg_313_1:FormatText(StoryNameCfg[181].name)

				arg_313_1.leftNameTxt_.text = var_316_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_9 = arg_313_1:GetWordFromCfg(111081077)
				local var_316_10 = arg_313_1:FormatText(var_316_9.content)

				arg_313_1.text_.text = var_316_10

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_11 = 2
				local var_316_12 = utf8.len(var_316_10)
				local var_316_13 = var_316_11 <= 0 and var_316_7 or var_316_7 * (var_316_12 / var_316_11)

				if var_316_13 > 0 and var_316_7 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_6
					end
				end

				arg_313_1.text_.text = var_316_10
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081077", "story_v_out_111081.awb") ~= 0 then
					local var_316_14 = manager.audio:GetVoiceLength("story_v_out_111081", "111081077", "story_v_out_111081.awb") / 1000

					if var_316_14 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_14 + var_316_6
					end

					if var_316_9.prefab_name ~= "" and arg_313_1.actors_[var_316_9.prefab_name] ~= nil then
						local var_316_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_9.prefab_name].transform, "story_v_out_111081", "111081077", "story_v_out_111081.awb")

						arg_313_1:RecordAudio("111081077", var_316_15)
						arg_313_1:RecordAudio("111081077", var_316_15)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_111081", "111081077", "story_v_out_111081.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_111081", "111081077", "story_v_out_111081.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_7, arg_313_1.talkMaxDuration)

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_6) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_6 + var_316_16 and arg_313_1.time_ < var_316_6 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play111081078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 111081078
		arg_317_1.duration_ = 2

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play111081079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_320_1 = arg_317_1.actors_["1094ui_story"]
			local var_320_2 = 0

			if var_320_2 < arg_317_1.time_ and arg_317_1.time_ <= var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1094ui_story == nil then
				arg_317_1.var_.characterEffect1094ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_3 = 0.2

			if var_320_2 <= arg_317_1.time_ and arg_317_1.time_ < var_320_2 + var_320_3 and not isNil(var_320_1) then
				local var_320_4 = (arg_317_1.time_ - var_320_2) / var_320_3

				if arg_317_1.var_.characterEffect1094ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_2 + var_320_3 and arg_317_1.time_ < var_320_2 + var_320_3 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1094ui_story then
				arg_317_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_320_5 = 0
			local var_320_6 = 0.05

			if var_320_5 < arg_317_1.time_ and arg_317_1.time_ <= var_320_5 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_7 = arg_317_1:FormatText(StoryNameCfg[181].name)

				arg_317_1.leftNameTxt_.text = var_320_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_8 = arg_317_1:GetWordFromCfg(111081078)
				local var_320_9 = arg_317_1:FormatText(var_320_8.content)

				arg_317_1.text_.text = var_320_9

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_10 = 2
				local var_320_11 = utf8.len(var_320_9)
				local var_320_12 = var_320_10 <= 0 and var_320_6 or var_320_6 * (var_320_11 / var_320_10)

				if var_320_12 > 0 and var_320_6 < var_320_12 then
					arg_317_1.talkMaxDuration = var_320_12

					if var_320_12 + var_320_5 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_12 + var_320_5
					end
				end

				arg_317_1.text_.text = var_320_9
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081078", "story_v_out_111081.awb") ~= 0 then
					local var_320_13 = manager.audio:GetVoiceLength("story_v_out_111081", "111081078", "story_v_out_111081.awb") / 1000

					if var_320_13 + var_320_5 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_13 + var_320_5
					end

					if var_320_8.prefab_name ~= "" and arg_317_1.actors_[var_320_8.prefab_name] ~= nil then
						local var_320_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_8.prefab_name].transform, "story_v_out_111081", "111081078", "story_v_out_111081.awb")

						arg_317_1:RecordAudio("111081078", var_320_14)
						arg_317_1:RecordAudio("111081078", var_320_14)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_111081", "111081078", "story_v_out_111081.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_111081", "111081078", "story_v_out_111081.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_15 = math.max(var_320_6, arg_317_1.talkMaxDuration)

			if var_320_5 <= arg_317_1.time_ and arg_317_1.time_ < var_320_5 + var_320_15 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_5) / var_320_15

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_5 + var_320_15 and arg_317_1.time_ < var_320_5 + var_320_15 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play111081079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 111081079
		arg_321_1.duration_ = 2

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play111081080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_324_1 = arg_321_1.actors_["1094ui_story"]
			local var_324_2 = 0

			if var_324_2 < arg_321_1.time_ and arg_321_1.time_ <= var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1094ui_story == nil then
				arg_321_1.var_.characterEffect1094ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_3 = 0.2

			if var_324_2 <= arg_321_1.time_ and arg_321_1.time_ < var_324_2 + var_324_3 and not isNil(var_324_1) then
				local var_324_4 = (arg_321_1.time_ - var_324_2) / var_324_3

				if arg_321_1.var_.characterEffect1094ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_2 + var_324_3 and arg_321_1.time_ < var_324_2 + var_324_3 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1094ui_story then
				arg_321_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_324_5 = 0
			local var_324_6 = 0.075

			if var_324_5 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_7 = arg_321_1:FormatText(StoryNameCfg[181].name)

				arg_321_1.leftNameTxt_.text = var_324_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_8 = arg_321_1:GetWordFromCfg(111081079)
				local var_324_9 = arg_321_1:FormatText(var_324_8.content)

				arg_321_1.text_.text = var_324_9

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_10 = 3
				local var_324_11 = utf8.len(var_324_9)
				local var_324_12 = var_324_10 <= 0 and var_324_6 or var_324_6 * (var_324_11 / var_324_10)

				if var_324_12 > 0 and var_324_6 < var_324_12 then
					arg_321_1.talkMaxDuration = var_324_12

					if var_324_12 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_12 + var_324_5
					end
				end

				arg_321_1.text_.text = var_324_9
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081079", "story_v_out_111081.awb") ~= 0 then
					local var_324_13 = manager.audio:GetVoiceLength("story_v_out_111081", "111081079", "story_v_out_111081.awb") / 1000

					if var_324_13 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_5
					end

					if var_324_8.prefab_name ~= "" and arg_321_1.actors_[var_324_8.prefab_name] ~= nil then
						local var_324_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_8.prefab_name].transform, "story_v_out_111081", "111081079", "story_v_out_111081.awb")

						arg_321_1:RecordAudio("111081079", var_324_14)
						arg_321_1:RecordAudio("111081079", var_324_14)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_111081", "111081079", "story_v_out_111081.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_111081", "111081079", "story_v_out_111081.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_15 = math.max(var_324_6, arg_321_1.talkMaxDuration)

			if var_324_5 <= arg_321_1.time_ and arg_321_1.time_ < var_324_5 + var_324_15 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_5) / var_324_15

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_5 + var_324_15 and arg_321_1.time_ < var_324_5 + var_324_15 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play111081080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 111081080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play111081081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1094ui_story"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1094ui_story == nil then
				arg_325_1.var_.characterEffect1094ui_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.2

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.characterEffect1094ui_story and not isNil(var_328_0) then
					local var_328_4 = Mathf.Lerp(0, 0.5, var_328_3)

					arg_325_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1094ui_story.fillRatio = var_328_4
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1094ui_story then
				local var_328_5 = 0.5

				arg_325_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1094ui_story.fillRatio = var_328_5
			end

			local var_328_6 = 0
			local var_328_7 = 1.6

			if var_328_6 < arg_325_1.time_ and arg_325_1.time_ <= var_328_6 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_8 = arg_325_1:GetWordFromCfg(111081080)
				local var_328_9 = arg_325_1:FormatText(var_328_8.content)

				arg_325_1.text_.text = var_328_9

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_10 = 64
				local var_328_11 = utf8.len(var_328_9)
				local var_328_12 = var_328_10 <= 0 and var_328_7 or var_328_7 * (var_328_11 / var_328_10)

				if var_328_12 > 0 and var_328_7 < var_328_12 then
					arg_325_1.talkMaxDuration = var_328_12

					if var_328_12 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_12 + var_328_6
					end
				end

				arg_325_1.text_.text = var_328_9
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_13 = math.max(var_328_7, arg_325_1.talkMaxDuration)

			if var_328_6 <= arg_325_1.time_ and arg_325_1.time_ < var_328_6 + var_328_13 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_6) / var_328_13

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_6 + var_328_13 and arg_325_1.time_ < var_328_6 + var_328_13 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play111081081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 111081081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play111081082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 0.975

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_2 = arg_329_1:GetWordFromCfg(111081081)
				local var_332_3 = arg_329_1:FormatText(var_332_2.content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_4 = 39
				local var_332_5 = utf8.len(var_332_3)
				local var_332_6 = var_332_4 <= 0 and var_332_1 or var_332_1 * (var_332_5 / var_332_4)

				if var_332_6 > 0 and var_332_1 < var_332_6 then
					arg_329_1.talkMaxDuration = var_332_6

					if var_332_6 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_6 + var_332_0
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_7 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_7 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_7

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_7 and arg_329_1.time_ < var_332_0 + var_332_7 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play111081082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 111081082
		arg_333_1.duration_ = 2.67

		local var_333_0 = {
			ja = 2.666,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_333_0:Play111081083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_336_2 = arg_333_1.actors_["1094ui_story"]
			local var_336_3 = 0

			if var_336_3 < arg_333_1.time_ and arg_333_1.time_ <= var_336_3 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.characterEffect1094ui_story == nil then
				arg_333_1.var_.characterEffect1094ui_story = var_336_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_4 = 0.2

			if var_336_3 <= arg_333_1.time_ and arg_333_1.time_ < var_336_3 + var_336_4 and not isNil(var_336_2) then
				local var_336_5 = (arg_333_1.time_ - var_336_3) / var_336_4

				if arg_333_1.var_.characterEffect1094ui_story and not isNil(var_336_2) then
					arg_333_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_3 + var_336_4 and arg_333_1.time_ < var_336_3 + var_336_4 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.characterEffect1094ui_story then
				arg_333_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_336_6 = 0
			local var_336_7 = 0.125

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_8 = arg_333_1:FormatText(StoryNameCfg[181].name)

				arg_333_1.leftNameTxt_.text = var_336_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_9 = arg_333_1:GetWordFromCfg(111081082)
				local var_336_10 = arg_333_1:FormatText(var_336_9.content)

				arg_333_1.text_.text = var_336_10

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_11 = 5
				local var_336_12 = utf8.len(var_336_10)
				local var_336_13 = var_336_11 <= 0 and var_336_7 or var_336_7 * (var_336_12 / var_336_11)

				if var_336_13 > 0 and var_336_7 < var_336_13 then
					arg_333_1.talkMaxDuration = var_336_13

					if var_336_13 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_13 + var_336_6
					end
				end

				arg_333_1.text_.text = var_336_10
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081082", "story_v_out_111081.awb") ~= 0 then
					local var_336_14 = manager.audio:GetVoiceLength("story_v_out_111081", "111081082", "story_v_out_111081.awb") / 1000

					if var_336_14 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_14 + var_336_6
					end

					if var_336_9.prefab_name ~= "" and arg_333_1.actors_[var_336_9.prefab_name] ~= nil then
						local var_336_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_9.prefab_name].transform, "story_v_out_111081", "111081082", "story_v_out_111081.awb")

						arg_333_1:RecordAudio("111081082", var_336_15)
						arg_333_1:RecordAudio("111081082", var_336_15)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_111081", "111081082", "story_v_out_111081.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_111081", "111081082", "story_v_out_111081.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_16 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_16 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_6) / var_336_16

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_6 + var_336_16 and arg_333_1.time_ < var_336_6 + var_336_16 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play111081083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 111081083
		arg_337_1.duration_ = 3.5

		local var_337_0 = {
			ja = 2.8,
			ko = 2.8,
			zh = 3.5,
			en = 1.766
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play111081084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1094ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1094ui_story == nil then
				arg_337_1.var_.characterEffect1094ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.2

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect1094ui_story and not isNil(var_340_0) then
					local var_340_4 = Mathf.Lerp(0, 0.5, var_340_3)

					arg_337_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1094ui_story.fillRatio = var_340_4
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1094ui_story then
				local var_340_5 = 0.5

				arg_337_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1094ui_story.fillRatio = var_340_5
			end

			local var_340_6 = 0
			local var_340_7 = 0.3

			if var_340_6 < arg_337_1.time_ and arg_337_1.time_ <= var_340_6 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_8 = arg_337_1:FormatText(StoryNameCfg[189].name)

				arg_337_1.leftNameTxt_.text = var_340_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_9 = arg_337_1:GetWordFromCfg(111081083)
				local var_340_10 = arg_337_1:FormatText(var_340_9.content)

				arg_337_1.text_.text = var_340_10

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_11 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081083", "story_v_out_111081.awb") ~= 0 then
					local var_340_14 = manager.audio:GetVoiceLength("story_v_out_111081", "111081083", "story_v_out_111081.awb") / 1000

					if var_340_14 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_14 + var_340_6
					end

					if var_340_9.prefab_name ~= "" and arg_337_1.actors_[var_340_9.prefab_name] ~= nil then
						local var_340_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_9.prefab_name].transform, "story_v_out_111081", "111081083", "story_v_out_111081.awb")

						arg_337_1:RecordAudio("111081083", var_340_15)
						arg_337_1:RecordAudio("111081083", var_340_15)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_111081", "111081083", "story_v_out_111081.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_111081", "111081083", "story_v_out_111081.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_16 = math.max(var_340_7, arg_337_1.talkMaxDuration)

			if var_340_6 <= arg_337_1.time_ and arg_337_1.time_ < var_340_6 + var_340_16 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_6) / var_340_16

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_6 + var_340_16 and arg_337_1.time_ < var_340_6 + var_340_16 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play111081084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 111081084
		arg_341_1.duration_ = 3.13

		local var_341_0 = {
			ja = 2.833,
			ko = 1.999999999999,
			zh = 3.133,
			en = 3
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play111081085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_2")
			end

			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_344_2 = arg_341_1.actors_["1094ui_story"]
			local var_344_3 = 0

			if var_344_3 < arg_341_1.time_ and arg_341_1.time_ <= var_344_3 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.characterEffect1094ui_story == nil then
				arg_341_1.var_.characterEffect1094ui_story = var_344_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_4 = 0.2

			if var_344_3 <= arg_341_1.time_ and arg_341_1.time_ < var_344_3 + var_344_4 and not isNil(var_344_2) then
				local var_344_5 = (arg_341_1.time_ - var_344_3) / var_344_4

				if arg_341_1.var_.characterEffect1094ui_story and not isNil(var_344_2) then
					arg_341_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_3 + var_344_4 and arg_341_1.time_ < var_344_3 + var_344_4 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.characterEffect1094ui_story then
				arg_341_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_344_6 = 0
			local var_344_7 = 0.15

			if var_344_6 < arg_341_1.time_ and arg_341_1.time_ <= var_344_6 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_8 = arg_341_1:FormatText(StoryNameCfg[181].name)

				arg_341_1.leftNameTxt_.text = var_344_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_9 = arg_341_1:GetWordFromCfg(111081084)
				local var_344_10 = arg_341_1:FormatText(var_344_9.content)

				arg_341_1.text_.text = var_344_10

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_11 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081084", "story_v_out_111081.awb") ~= 0 then
					local var_344_14 = manager.audio:GetVoiceLength("story_v_out_111081", "111081084", "story_v_out_111081.awb") / 1000

					if var_344_14 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_14 + var_344_6
					end

					if var_344_9.prefab_name ~= "" and arg_341_1.actors_[var_344_9.prefab_name] ~= nil then
						local var_344_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_9.prefab_name].transform, "story_v_out_111081", "111081084", "story_v_out_111081.awb")

						arg_341_1:RecordAudio("111081084", var_344_15)
						arg_341_1:RecordAudio("111081084", var_344_15)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_111081", "111081084", "story_v_out_111081.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_111081", "111081084", "story_v_out_111081.awb")
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
	Play111081085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 111081085
		arg_345_1.duration_ = 4.7

		local var_345_0 = {
			ja = 4.7,
			ko = 2.666,
			zh = 3.033,
			en = 1.666
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play111081086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0
			local var_348_1 = 0.3

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_2 = arg_345_1:FormatText(StoryNameCfg[189].name)

				arg_345_1.leftNameTxt_.text = var_348_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_3 = arg_345_1:GetWordFromCfg(111081085)
				local var_348_4 = arg_345_1:FormatText(var_348_3.content)

				arg_345_1.text_.text = var_348_4

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 12
				local var_348_6 = utf8.len(var_348_4)
				local var_348_7 = var_348_5 <= 0 and var_348_1 or var_348_1 * (var_348_6 / var_348_5)

				if var_348_7 > 0 and var_348_1 < var_348_7 then
					arg_345_1.talkMaxDuration = var_348_7

					if var_348_7 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_7 + var_348_0
					end
				end

				arg_345_1.text_.text = var_348_4
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081085", "story_v_out_111081.awb") ~= 0 then
					local var_348_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081085", "story_v_out_111081.awb") / 1000

					if var_348_8 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_8 + var_348_0
					end

					if var_348_3.prefab_name ~= "" and arg_345_1.actors_[var_348_3.prefab_name] ~= nil then
						local var_348_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_3.prefab_name].transform, "story_v_out_111081", "111081085", "story_v_out_111081.awb")

						arg_345_1:RecordAudio("111081085", var_348_9)
						arg_345_1:RecordAudio("111081085", var_348_9)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_111081", "111081085", "story_v_out_111081.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_111081", "111081085", "story_v_out_111081.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_10 = math.max(var_348_1, arg_345_1.talkMaxDuration)

			if var_348_0 <= arg_345_1.time_ and arg_345_1.time_ < var_348_0 + var_348_10 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_0) / var_348_10

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_0 + var_348_10 and arg_345_1.time_ < var_348_0 + var_348_10 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play111081086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 111081086
		arg_349_1.duration_ = 3.13

		local var_349_0 = {
			ja = 3.133,
			ko = 0.999999999999,
			zh = 1.733,
			en = 1.066
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
				arg_349_0:Play111081087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0
			local var_352_1 = 0.1

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_2 = arg_349_1:FormatText(StoryNameCfg[183].name)

				arg_349_1.leftNameTxt_.text = var_352_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_3 = arg_349_1:GetWordFromCfg(111081086)
				local var_352_4 = arg_349_1:FormatText(var_352_3.content)

				arg_349_1.text_.text = var_352_4

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 4
				local var_352_6 = utf8.len(var_352_4)
				local var_352_7 = var_352_5 <= 0 and var_352_1 or var_352_1 * (var_352_6 / var_352_5)

				if var_352_7 > 0 and var_352_1 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7

					if var_352_7 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_0
					end
				end

				arg_349_1.text_.text = var_352_4
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081086", "story_v_out_111081.awb") ~= 0 then
					local var_352_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081086", "story_v_out_111081.awb") / 1000

					if var_352_8 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_8 + var_352_0
					end

					if var_352_3.prefab_name ~= "" and arg_349_1.actors_[var_352_3.prefab_name] ~= nil then
						local var_352_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_3.prefab_name].transform, "story_v_out_111081", "111081086", "story_v_out_111081.awb")

						arg_349_1:RecordAudio("111081086", var_352_9)
						arg_349_1:RecordAudio("111081086", var_352_9)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_111081", "111081086", "story_v_out_111081.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_111081", "111081086", "story_v_out_111081.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_10 = math.max(var_352_1, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_10 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_0) / var_352_10

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_10 and arg_349_1.time_ < var_352_0 + var_352_10 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play111081087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 111081087
		arg_353_1.duration_ = 4

		local var_353_0 = {
			ja = 3,
			ko = 1.733,
			zh = 4,
			en = 2.066
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
				arg_353_0:Play111081088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0
			local var_356_1 = 0.15

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_2 = arg_353_1:FormatText(StoryNameCfg[189].name)

				arg_353_1.leftNameTxt_.text = var_356_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_3 = arg_353_1:GetWordFromCfg(111081087)
				local var_356_4 = arg_353_1:FormatText(var_356_3.content)

				arg_353_1.text_.text = var_356_4

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 6
				local var_356_6 = utf8.len(var_356_4)
				local var_356_7 = var_356_5 <= 0 and var_356_1 or var_356_1 * (var_356_6 / var_356_5)

				if var_356_7 > 0 and var_356_1 < var_356_7 then
					arg_353_1.talkMaxDuration = var_356_7

					if var_356_7 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_0
					end
				end

				arg_353_1.text_.text = var_356_4
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081087", "story_v_out_111081.awb") ~= 0 then
					local var_356_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081087", "story_v_out_111081.awb") / 1000

					if var_356_8 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_8 + var_356_0
					end

					if var_356_3.prefab_name ~= "" and arg_353_1.actors_[var_356_3.prefab_name] ~= nil then
						local var_356_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_3.prefab_name].transform, "story_v_out_111081", "111081087", "story_v_out_111081.awb")

						arg_353_1:RecordAudio("111081087", var_356_9)
						arg_353_1:RecordAudio("111081087", var_356_9)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_111081", "111081087", "story_v_out_111081.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_111081", "111081087", "story_v_out_111081.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_10 = math.max(var_356_1, arg_353_1.talkMaxDuration)

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_10 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_0) / var_356_10

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_0 + var_356_10 and arg_353_1.time_ < var_356_0 + var_356_10 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play111081088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 111081088
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play111081089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1094ui_story"].transform
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.var_.moveOldPos1094ui_story = var_360_0.localPosition
			end

			local var_360_2 = 0.001

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2
				local var_360_4 = Vector3.New(0, 100, 0)

				var_360_0.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1094ui_story, var_360_4, var_360_3)

				local var_360_5 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_5.x, var_360_5.y, var_360_5.z)

				local var_360_6 = var_360_0.localEulerAngles

				var_360_6.z = 0
				var_360_6.x = 0
				var_360_0.localEulerAngles = var_360_6
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 then
				var_360_0.localPosition = Vector3.New(0, 100, 0)

				local var_360_7 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_7.x, var_360_7.y, var_360_7.z)

				local var_360_8 = var_360_0.localEulerAngles

				var_360_8.z = 0
				var_360_8.x = 0
				var_360_0.localEulerAngles = var_360_8
			end

			local var_360_9 = 0
			local var_360_10 = 1.675

			if var_360_9 < arg_357_1.time_ and arg_357_1.time_ <= var_360_9 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_11 = arg_357_1:GetWordFromCfg(111081088)
				local var_360_12 = arg_357_1:FormatText(var_360_11.content)

				arg_357_1.text_.text = var_360_12

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_13 = 67
				local var_360_14 = utf8.len(var_360_12)
				local var_360_15 = var_360_13 <= 0 and var_360_10 or var_360_10 * (var_360_14 / var_360_13)

				if var_360_15 > 0 and var_360_10 < var_360_15 then
					arg_357_1.talkMaxDuration = var_360_15

					if var_360_15 + var_360_9 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_15 + var_360_9
					end
				end

				arg_357_1.text_.text = var_360_12
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_16 = math.max(var_360_10, arg_357_1.talkMaxDuration)

			if var_360_9 <= arg_357_1.time_ and arg_357_1.time_ < var_360_9 + var_360_16 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_9) / var_360_16

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_9 + var_360_16 and arg_357_1.time_ < var_360_9 + var_360_16 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play111081089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 111081089
		arg_361_1.duration_ = 4.43

		local var_361_0 = {
			ja = 4.433,
			ko = 2.866,
			zh = 3.766,
			en = 3.733
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play111081090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 0.3

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_2 = arg_361_1:FormatText(StoryNameCfg[183].name)

				arg_361_1.leftNameTxt_.text = var_364_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:GetWordFromCfg(111081089)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 12
				local var_364_6 = utf8.len(var_364_4)
				local var_364_7 = var_364_5 <= 0 and var_364_1 or var_364_1 * (var_364_6 / var_364_5)

				if var_364_7 > 0 and var_364_1 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081089", "story_v_out_111081.awb") ~= 0 then
					local var_364_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081089", "story_v_out_111081.awb") / 1000

					if var_364_8 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_8 + var_364_0
					end

					if var_364_3.prefab_name ~= "" and arg_361_1.actors_[var_364_3.prefab_name] ~= nil then
						local var_364_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_3.prefab_name].transform, "story_v_out_111081", "111081089", "story_v_out_111081.awb")

						arg_361_1:RecordAudio("111081089", var_364_9)
						arg_361_1:RecordAudio("111081089", var_364_9)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_111081", "111081089", "story_v_out_111081.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_111081", "111081089", "story_v_out_111081.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_10 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_10 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_10

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_10 and arg_361_1.time_ < var_364_0 + var_364_10 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play111081090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 111081090
		arg_365_1.duration_ = 5.7

		local var_365_0 = {
			ja = 4.033,
			ko = 4.3,
			zh = 5.7,
			en = 4.466
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play111081091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.4

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[189].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_3 = arg_365_1:GetWordFromCfg(111081090)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 16
				local var_368_6 = utf8.len(var_368_4)
				local var_368_7 = var_368_5 <= 0 and var_368_1 or var_368_1 * (var_368_6 / var_368_5)

				if var_368_7 > 0 and var_368_1 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081090", "story_v_out_111081.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081090", "story_v_out_111081.awb") / 1000

					if var_368_8 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_0
					end

					if var_368_3.prefab_name ~= "" and arg_365_1.actors_[var_368_3.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_3.prefab_name].transform, "story_v_out_111081", "111081090", "story_v_out_111081.awb")

						arg_365_1:RecordAudio("111081090", var_368_9)
						arg_365_1:RecordAudio("111081090", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_111081", "111081090", "story_v_out_111081.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_111081", "111081090", "story_v_out_111081.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_10 and arg_365_1.time_ < var_368_0 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play111081091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 111081091
		arg_369_1.duration_ = 4.43

		local var_369_0 = {
			ja = 3.1,
			ko = 3.133,
			zh = 4.433,
			en = 3.166
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play111081092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0
			local var_372_1 = 0.3

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_2 = arg_369_1:FormatText(StoryNameCfg[183].name)

				arg_369_1.leftNameTxt_.text = var_372_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_3 = arg_369_1:GetWordFromCfg(111081091)
				local var_372_4 = arg_369_1:FormatText(var_372_3.content)

				arg_369_1.text_.text = var_372_4

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 12
				local var_372_6 = utf8.len(var_372_4)
				local var_372_7 = var_372_5 <= 0 and var_372_1 or var_372_1 * (var_372_6 / var_372_5)

				if var_372_7 > 0 and var_372_1 < var_372_7 then
					arg_369_1.talkMaxDuration = var_372_7

					if var_372_7 + var_372_0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_0
					end
				end

				arg_369_1.text_.text = var_372_4
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081091", "story_v_out_111081.awb") ~= 0 then
					local var_372_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081091", "story_v_out_111081.awb") / 1000

					if var_372_8 + var_372_0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_8 + var_372_0
					end

					if var_372_3.prefab_name ~= "" and arg_369_1.actors_[var_372_3.prefab_name] ~= nil then
						local var_372_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_3.prefab_name].transform, "story_v_out_111081", "111081091", "story_v_out_111081.awb")

						arg_369_1:RecordAudio("111081091", var_372_9)
						arg_369_1:RecordAudio("111081091", var_372_9)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_111081", "111081091", "story_v_out_111081.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_111081", "111081091", "story_v_out_111081.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_10 = math.max(var_372_1, arg_369_1.talkMaxDuration)

			if var_372_0 <= arg_369_1.time_ and arg_369_1.time_ < var_372_0 + var_372_10 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_0) / var_372_10

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_0 + var_372_10 and arg_369_1.time_ < var_372_0 + var_372_10 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play111081092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 111081092
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play111081093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0
			local var_376_1 = 0.125

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_2 = arg_373_1:FormatText(StoryNameCfg[7].name)

				arg_373_1.leftNameTxt_.text = var_376_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_3 = arg_373_1:GetWordFromCfg(111081092)
				local var_376_4 = arg_373_1:FormatText(var_376_3.content)

				arg_373_1.text_.text = var_376_4

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_5 = 5
				local var_376_6 = utf8.len(var_376_4)
				local var_376_7 = var_376_5 <= 0 and var_376_1 or var_376_1 * (var_376_6 / var_376_5)

				if var_376_7 > 0 and var_376_1 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_0
					end
				end

				arg_373_1.text_.text = var_376_4
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_8 = math.max(var_376_1, arg_373_1.talkMaxDuration)

			if var_376_0 <= arg_373_1.time_ and arg_373_1.time_ < var_376_0 + var_376_8 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_0) / var_376_8

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_0 + var_376_8 and arg_373_1.time_ < var_376_0 + var_376_8 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play111081093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 111081093
		arg_377_1.duration_ = 7.57

		local var_377_0 = {
			ja = 7.566,
			ko = 5.066,
			zh = 7.166,
			en = 5.8
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play111081094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0
			local var_380_1 = 0.575

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_2 = arg_377_1:FormatText(StoryNameCfg[183].name)

				arg_377_1.leftNameTxt_.text = var_380_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_3 = arg_377_1:GetWordFromCfg(111081093)
				local var_380_4 = arg_377_1:FormatText(var_380_3.content)

				arg_377_1.text_.text = var_380_4

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 23
				local var_380_6 = utf8.len(var_380_4)
				local var_380_7 = var_380_5 <= 0 and var_380_1 or var_380_1 * (var_380_6 / var_380_5)

				if var_380_7 > 0 and var_380_1 < var_380_7 then
					arg_377_1.talkMaxDuration = var_380_7

					if var_380_7 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_0
					end
				end

				arg_377_1.text_.text = var_380_4
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081093", "story_v_out_111081.awb") ~= 0 then
					local var_380_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081093", "story_v_out_111081.awb") / 1000

					if var_380_8 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_8 + var_380_0
					end

					if var_380_3.prefab_name ~= "" and arg_377_1.actors_[var_380_3.prefab_name] ~= nil then
						local var_380_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_3.prefab_name].transform, "story_v_out_111081", "111081093", "story_v_out_111081.awb")

						arg_377_1:RecordAudio("111081093", var_380_9)
						arg_377_1:RecordAudio("111081093", var_380_9)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_111081", "111081093", "story_v_out_111081.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_111081", "111081093", "story_v_out_111081.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_10 = math.max(var_380_1, arg_377_1.talkMaxDuration)

			if var_380_0 <= arg_377_1.time_ and arg_377_1.time_ < var_380_0 + var_380_10 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_0) / var_380_10

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_0 + var_380_10 and arg_377_1.time_ < var_380_0 + var_380_10 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play111081094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 111081094
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play111081095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0
			local var_384_1 = 0.45

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_2 = arg_381_1:FormatText(StoryNameCfg[7].name)

				arg_381_1.leftNameTxt_.text = var_384_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_3 = arg_381_1:GetWordFromCfg(111081094)
				local var_384_4 = arg_381_1:FormatText(var_384_3.content)

				arg_381_1.text_.text = var_384_4

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_5 = 18
				local var_384_6 = utf8.len(var_384_4)
				local var_384_7 = var_384_5 <= 0 and var_384_1 or var_384_1 * (var_384_6 / var_384_5)

				if var_384_7 > 0 and var_384_1 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_0
					end
				end

				arg_381_1.text_.text = var_384_4
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_8 = math.max(var_384_1, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_8 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_0) / var_384_8

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_8 and arg_381_1.time_ < var_384_0 + var_384_8 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play111081095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 111081095
		arg_385_1.duration_ = 12.6

		local var_385_0 = {
			ja = 8.2,
			ko = 9.8,
			zh = 10.633,
			en = 12.6
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play111081096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0
			local var_388_1 = 1.075

			if var_388_0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_2 = arg_385_1:FormatText(StoryNameCfg[183].name)

				arg_385_1.leftNameTxt_.text = var_388_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_3 = arg_385_1:GetWordFromCfg(111081095)
				local var_388_4 = arg_385_1:FormatText(var_388_3.content)

				arg_385_1.text_.text = var_388_4

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 43
				local var_388_6 = utf8.len(var_388_4)
				local var_388_7 = var_388_5 <= 0 and var_388_1 or var_388_1 * (var_388_6 / var_388_5)

				if var_388_7 > 0 and var_388_1 < var_388_7 then
					arg_385_1.talkMaxDuration = var_388_7

					if var_388_7 + var_388_0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_7 + var_388_0
					end
				end

				arg_385_1.text_.text = var_388_4
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081095", "story_v_out_111081.awb") ~= 0 then
					local var_388_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081095", "story_v_out_111081.awb") / 1000

					if var_388_8 + var_388_0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_8 + var_388_0
					end

					if var_388_3.prefab_name ~= "" and arg_385_1.actors_[var_388_3.prefab_name] ~= nil then
						local var_388_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_3.prefab_name].transform, "story_v_out_111081", "111081095", "story_v_out_111081.awb")

						arg_385_1:RecordAudio("111081095", var_388_9)
						arg_385_1:RecordAudio("111081095", var_388_9)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_111081", "111081095", "story_v_out_111081.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_111081", "111081095", "story_v_out_111081.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_10 = math.max(var_388_1, arg_385_1.talkMaxDuration)

			if var_388_0 <= arg_385_1.time_ and arg_385_1.time_ < var_388_0 + var_388_10 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_0) / var_388_10

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_0 + var_388_10 and arg_385_1.time_ < var_388_0 + var_388_10 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play111081096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 111081096
		arg_389_1.duration_ = 11.7

		local var_389_0 = {
			ja = 11.7,
			ko = 8.433,
			zh = 10.1,
			en = 7.2
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play111081097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0
			local var_392_1 = 1.175

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_2 = arg_389_1:FormatText(StoryNameCfg[189].name)

				arg_389_1.leftNameTxt_.text = var_392_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_3 = arg_389_1:GetWordFromCfg(111081096)
				local var_392_4 = arg_389_1:FormatText(var_392_3.content)

				arg_389_1.text_.text = var_392_4

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 45
				local var_392_6 = utf8.len(var_392_4)
				local var_392_7 = var_392_5 <= 0 and var_392_1 or var_392_1 * (var_392_6 / var_392_5)

				if var_392_7 > 0 and var_392_1 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_0
					end
				end

				arg_389_1.text_.text = var_392_4
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081096", "story_v_out_111081.awb") ~= 0 then
					local var_392_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081096", "story_v_out_111081.awb") / 1000

					if var_392_8 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_8 + var_392_0
					end

					if var_392_3.prefab_name ~= "" and arg_389_1.actors_[var_392_3.prefab_name] ~= nil then
						local var_392_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_3.prefab_name].transform, "story_v_out_111081", "111081096", "story_v_out_111081.awb")

						arg_389_1:RecordAudio("111081096", var_392_9)
						arg_389_1:RecordAudio("111081096", var_392_9)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_111081", "111081096", "story_v_out_111081.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_111081", "111081096", "story_v_out_111081.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_10 = math.max(var_392_1, arg_389_1.talkMaxDuration)

			if var_392_0 <= arg_389_1.time_ and arg_389_1.time_ < var_392_0 + var_392_10 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_0) / var_392_10

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_0 + var_392_10 and arg_389_1.time_ < var_392_0 + var_392_10 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play111081097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 111081097
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play111081098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0
			local var_396_1 = 0.25

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_2 = arg_393_1:FormatText(StoryNameCfg[7].name)

				arg_393_1.leftNameTxt_.text = var_396_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_3 = arg_393_1:GetWordFromCfg(111081097)
				local var_396_4 = arg_393_1:FormatText(var_396_3.content)

				arg_393_1.text_.text = var_396_4

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 10
				local var_396_6 = utf8.len(var_396_4)
				local var_396_7 = var_396_5 <= 0 and var_396_1 or var_396_1 * (var_396_6 / var_396_5)

				if var_396_7 > 0 and var_396_1 < var_396_7 then
					arg_393_1.talkMaxDuration = var_396_7

					if var_396_7 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_7 + var_396_0
					end
				end

				arg_393_1.text_.text = var_396_4
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_8 = math.max(var_396_1, arg_393_1.talkMaxDuration)

			if var_396_0 <= arg_393_1.time_ and arg_393_1.time_ < var_396_0 + var_396_8 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_0) / var_396_8

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_0 + var_396_8 and arg_393_1.time_ < var_396_0 + var_396_8 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play111081098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 111081098
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play111081099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0
			local var_400_1 = 0.775

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_2 = arg_397_1:GetWordFromCfg(111081098)
				local var_400_3 = arg_397_1:FormatText(var_400_2.content)

				arg_397_1.text_.text = var_400_3

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_4 = 31
				local var_400_5 = utf8.len(var_400_3)
				local var_400_6 = var_400_4 <= 0 and var_400_1 or var_400_1 * (var_400_5 / var_400_4)

				if var_400_6 > 0 and var_400_1 < var_400_6 then
					arg_397_1.talkMaxDuration = var_400_6

					if var_400_6 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_6 + var_400_0
					end
				end

				arg_397_1.text_.text = var_400_3
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_1, arg_397_1.talkMaxDuration)

			if var_400_0 <= arg_397_1.time_ and arg_397_1.time_ < var_400_0 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_0) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_0 + var_400_7 and arg_397_1.time_ < var_400_0 + var_400_7 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play111081099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 111081099
		arg_401_1.duration_ = 7.33

		local var_401_0 = {
			ja = 7.166,
			ko = 5.833,
			zh = 7.333,
			en = 5.866
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play111081100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 0.725

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_2 = arg_401_1:FormatText(StoryNameCfg[183].name)

				arg_401_1.leftNameTxt_.text = var_404_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_3 = arg_401_1:GetWordFromCfg(111081099)
				local var_404_4 = arg_401_1:FormatText(var_404_3.content)

				arg_401_1.text_.text = var_404_4

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_5 = 23
				local var_404_6 = utf8.len(var_404_4)
				local var_404_7 = var_404_5 <= 0 and var_404_1 or var_404_1 * (var_404_6 / var_404_5)

				if var_404_7 > 0 and var_404_1 < var_404_7 then
					arg_401_1.talkMaxDuration = var_404_7

					if var_404_7 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_7 + var_404_0
					end
				end

				arg_401_1.text_.text = var_404_4
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081099", "story_v_out_111081.awb") ~= 0 then
					local var_404_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081099", "story_v_out_111081.awb") / 1000

					if var_404_8 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_8 + var_404_0
					end

					if var_404_3.prefab_name ~= "" and arg_401_1.actors_[var_404_3.prefab_name] ~= nil then
						local var_404_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_3.prefab_name].transform, "story_v_out_111081", "111081099", "story_v_out_111081.awb")

						arg_401_1:RecordAudio("111081099", var_404_9)
						arg_401_1:RecordAudio("111081099", var_404_9)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_111081", "111081099", "story_v_out_111081.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_111081", "111081099", "story_v_out_111081.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_10 = math.max(var_404_1, arg_401_1.talkMaxDuration)

			if var_404_0 <= arg_401_1.time_ and arg_401_1.time_ < var_404_0 + var_404_10 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_0) / var_404_10

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_0 + var_404_10 and arg_401_1.time_ < var_404_0 + var_404_10 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play111081100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 111081100
		arg_405_1.duration_ = 5.7

		local var_405_0 = {
			ja = 5.7,
			ko = 3.166,
			zh = 2.533,
			en = 4.533
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play111081101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0
			local var_408_1 = 0.25

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_2 = arg_405_1:FormatText(StoryNameCfg[189].name)

				arg_405_1.leftNameTxt_.text = var_408_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_3 = arg_405_1:GetWordFromCfg(111081100)
				local var_408_4 = arg_405_1:FormatText(var_408_3.content)

				arg_405_1.text_.text = var_408_4

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 10
				local var_408_6 = utf8.len(var_408_4)
				local var_408_7 = var_408_5 <= 0 and var_408_1 or var_408_1 * (var_408_6 / var_408_5)

				if var_408_7 > 0 and var_408_1 < var_408_7 then
					arg_405_1.talkMaxDuration = var_408_7

					if var_408_7 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_7 + var_408_0
					end
				end

				arg_405_1.text_.text = var_408_4
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081100", "story_v_out_111081.awb") ~= 0 then
					local var_408_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081100", "story_v_out_111081.awb") / 1000

					if var_408_8 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_8 + var_408_0
					end

					if var_408_3.prefab_name ~= "" and arg_405_1.actors_[var_408_3.prefab_name] ~= nil then
						local var_408_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_3.prefab_name].transform, "story_v_out_111081", "111081100", "story_v_out_111081.awb")

						arg_405_1:RecordAudio("111081100", var_408_9)
						arg_405_1:RecordAudio("111081100", var_408_9)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_111081", "111081100", "story_v_out_111081.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_111081", "111081100", "story_v_out_111081.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_10 = math.max(var_408_1, arg_405_1.talkMaxDuration)

			if var_408_0 <= arg_405_1.time_ and arg_405_1.time_ < var_408_0 + var_408_10 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_0) / var_408_10

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_0 + var_408_10 and arg_405_1.time_ < var_408_0 + var_408_10 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play111081101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 111081101
		arg_409_1.duration_ = 7.9

		local var_409_0 = {
			ja = 7.9,
			ko = 6.4,
			zh = 7.1,
			en = 6.6
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play111081102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0
			local var_412_1 = 0.775

			if var_412_0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_2 = arg_409_1:FormatText(StoryNameCfg[183].name)

				arg_409_1.leftNameTxt_.text = var_412_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_3 = arg_409_1:GetWordFromCfg(111081101)
				local var_412_4 = arg_409_1:FormatText(var_412_3.content)

				arg_409_1.text_.text = var_412_4

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 31
				local var_412_6 = utf8.len(var_412_4)
				local var_412_7 = var_412_5 <= 0 and var_412_1 or var_412_1 * (var_412_6 / var_412_5)

				if var_412_7 > 0 and var_412_1 < var_412_7 then
					arg_409_1.talkMaxDuration = var_412_7

					if var_412_7 + var_412_0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_0
					end
				end

				arg_409_1.text_.text = var_412_4
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081101", "story_v_out_111081.awb") ~= 0 then
					local var_412_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081101", "story_v_out_111081.awb") / 1000

					if var_412_8 + var_412_0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_8 + var_412_0
					end

					if var_412_3.prefab_name ~= "" and arg_409_1.actors_[var_412_3.prefab_name] ~= nil then
						local var_412_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_3.prefab_name].transform, "story_v_out_111081", "111081101", "story_v_out_111081.awb")

						arg_409_1:RecordAudio("111081101", var_412_9)
						arg_409_1:RecordAudio("111081101", var_412_9)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_111081", "111081101", "story_v_out_111081.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_111081", "111081101", "story_v_out_111081.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_10 = math.max(var_412_1, arg_409_1.talkMaxDuration)

			if var_412_0 <= arg_409_1.time_ and arg_409_1.time_ < var_412_0 + var_412_10 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_0) / var_412_10

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_0 + var_412_10 and arg_409_1.time_ < var_412_0 + var_412_10 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play111081102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 111081102
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play111081103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0
			local var_416_1 = 0.6

			if var_416_0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_2 = arg_413_1:FormatText(StoryNameCfg[7].name)

				arg_413_1.leftNameTxt_.text = var_416_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_3 = arg_413_1:GetWordFromCfg(111081102)
				local var_416_4 = arg_413_1:FormatText(var_416_3.content)

				arg_413_1.text_.text = var_416_4

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_5 = 24
				local var_416_6 = utf8.len(var_416_4)
				local var_416_7 = var_416_5 <= 0 and var_416_1 or var_416_1 * (var_416_6 / var_416_5)

				if var_416_7 > 0 and var_416_1 < var_416_7 then
					arg_413_1.talkMaxDuration = var_416_7

					if var_416_7 + var_416_0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_7 + var_416_0
					end
				end

				arg_413_1.text_.text = var_416_4
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_8 = math.max(var_416_1, arg_413_1.talkMaxDuration)

			if var_416_0 <= arg_413_1.time_ and arg_413_1.time_ < var_416_0 + var_416_8 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_0) / var_416_8

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_0 + var_416_8 and arg_413_1.time_ < var_416_0 + var_416_8 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play111081103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 111081103
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play111081104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0
			local var_420_1 = 0.175

			if var_420_0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_2 = arg_417_1:FormatText(StoryNameCfg[7].name)

				arg_417_1.leftNameTxt_.text = var_420_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_3 = arg_417_1:GetWordFromCfg(111081103)
				local var_420_4 = arg_417_1:FormatText(var_420_3.content)

				arg_417_1.text_.text = var_420_4

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 7
				local var_420_6 = utf8.len(var_420_4)
				local var_420_7 = var_420_5 <= 0 and var_420_1 or var_420_1 * (var_420_6 / var_420_5)

				if var_420_7 > 0 and var_420_1 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_0
					end
				end

				arg_417_1.text_.text = var_420_4
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_8 = math.max(var_420_1, arg_417_1.talkMaxDuration)

			if var_420_0 <= arg_417_1.time_ and arg_417_1.time_ < var_420_0 + var_420_8 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_0) / var_420_8

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_0 + var_420_8 and arg_417_1.time_ < var_420_0 + var_420_8 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play111081104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 111081104
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play111081105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0
			local var_424_1 = 1.125

			if var_424_0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_2 = arg_421_1:GetWordFromCfg(111081104)
				local var_424_3 = arg_421_1:FormatText(var_424_2.content)

				arg_421_1.text_.text = var_424_3

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_4 = 45
				local var_424_5 = utf8.len(var_424_3)
				local var_424_6 = var_424_4 <= 0 and var_424_1 or var_424_1 * (var_424_5 / var_424_4)

				if var_424_6 > 0 and var_424_1 < var_424_6 then
					arg_421_1.talkMaxDuration = var_424_6

					if var_424_6 + var_424_0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_6 + var_424_0
					end
				end

				arg_421_1.text_.text = var_424_3
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_7 = math.max(var_424_1, arg_421_1.talkMaxDuration)

			if var_424_0 <= arg_421_1.time_ and arg_421_1.time_ < var_424_0 + var_424_7 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_0) / var_424_7

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_0 + var_424_7 and arg_421_1.time_ < var_424_0 + var_424_7 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play111081105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 111081105
		arg_425_1.duration_ = 10.4

		local var_425_0 = {
			ja = 10.4,
			ko = 2.333,
			zh = 3.533,
			en = 3.4
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
				arg_425_0:Play111081106(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0
			local var_428_1 = 0.325

			if var_428_0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_2 = arg_425_1:FormatText(StoryNameCfg[183].name)

				arg_425_1.leftNameTxt_.text = var_428_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_3 = arg_425_1:GetWordFromCfg(111081105)
				local var_428_4 = arg_425_1:FormatText(var_428_3.content)

				arg_425_1.text_.text = var_428_4

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_5 = 13
				local var_428_6 = utf8.len(var_428_4)
				local var_428_7 = var_428_5 <= 0 and var_428_1 or var_428_1 * (var_428_6 / var_428_5)

				if var_428_7 > 0 and var_428_1 < var_428_7 then
					arg_425_1.talkMaxDuration = var_428_7

					if var_428_7 + var_428_0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_7 + var_428_0
					end
				end

				arg_425_1.text_.text = var_428_4
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081105", "story_v_out_111081.awb") ~= 0 then
					local var_428_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081105", "story_v_out_111081.awb") / 1000

					if var_428_8 + var_428_0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_8 + var_428_0
					end

					if var_428_3.prefab_name ~= "" and arg_425_1.actors_[var_428_3.prefab_name] ~= nil then
						local var_428_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_3.prefab_name].transform, "story_v_out_111081", "111081105", "story_v_out_111081.awb")

						arg_425_1:RecordAudio("111081105", var_428_9)
						arg_425_1:RecordAudio("111081105", var_428_9)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_111081", "111081105", "story_v_out_111081.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_111081", "111081105", "story_v_out_111081.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_10 = math.max(var_428_1, arg_425_1.talkMaxDuration)

			if var_428_0 <= arg_425_1.time_ and arg_425_1.time_ < var_428_0 + var_428_10 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_0) / var_428_10

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_0 + var_428_10 and arg_425_1.time_ < var_428_0 + var_428_10 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play111081106 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 111081106
		arg_429_1.duration_ = 8

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play111081107(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = "ST07b"

			if arg_429_1.bgs_[var_432_0] == nil then
				local var_432_1 = Object.Instantiate(arg_429_1.paintGo_)

				var_432_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_432_0)
				var_432_1.name = var_432_0
				var_432_1.transform.parent = arg_429_1.stage_.transform
				var_432_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_429_1.bgs_[var_432_0] = var_432_1
			end

			local var_432_2 = 1.5

			if var_432_2 < arg_429_1.time_ and arg_429_1.time_ <= var_432_2 + arg_432_0 then
				local var_432_3 = manager.ui.mainCamera.transform.localPosition
				local var_432_4 = Vector3.New(0, 0, 10) + Vector3.New(var_432_3.x, var_432_3.y, 0)
				local var_432_5 = arg_429_1.bgs_.ST07b

				var_432_5.transform.localPosition = var_432_4
				var_432_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_432_6 = var_432_5:GetComponent("SpriteRenderer")

				if var_432_6 and var_432_6.sprite then
					local var_432_7 = (var_432_5.transform.localPosition - var_432_3).z
					local var_432_8 = manager.ui.mainCameraCom_
					local var_432_9 = 2 * var_432_7 * Mathf.Tan(var_432_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_432_10 = var_432_9 * var_432_8.aspect
					local var_432_11 = var_432_6.sprite.bounds.size.x
					local var_432_12 = var_432_6.sprite.bounds.size.y
					local var_432_13 = var_432_10 / var_432_11
					local var_432_14 = var_432_9 / var_432_12
					local var_432_15 = var_432_14 < var_432_13 and var_432_13 or var_432_14

					var_432_5.transform.localScale = Vector3.New(var_432_15, var_432_15, 0)
				end

				for iter_432_0, iter_432_1 in pairs(arg_429_1.bgs_) do
					if iter_432_0 ~= "ST07b" then
						iter_432_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_432_16 = arg_429_1.bgs_.ST07b
			local var_432_17 = 1.5

			if var_432_17 < arg_429_1.time_ and arg_429_1.time_ <= var_432_17 + arg_432_0 then
				local var_432_18 = var_432_16:GetComponent("SpriteRenderer")

				if var_432_18 then
					arg_429_1.var_.alphaOldValueST07b = var_432_18.color.a
					arg_429_1.var_.alphaMatValueST07b = var_432_18
				end

				arg_429_1.var_.alphaOldValueST07b = 0
			end

			local var_432_19 = 1.5

			if var_432_17 <= arg_429_1.time_ and arg_429_1.time_ < var_432_17 + var_432_19 then
				local var_432_20 = (arg_429_1.time_ - var_432_17) / var_432_19
				local var_432_21 = Mathf.Lerp(arg_429_1.var_.alphaOldValueST07b, 1, var_432_20)

				if arg_429_1.var_.alphaMatValueST07b then
					local var_432_22 = arg_429_1.var_.alphaMatValueST07b.color

					var_432_22.a = var_432_21
					arg_429_1.var_.alphaMatValueST07b.color = var_432_22
				end
			end

			if arg_429_1.time_ >= var_432_17 + var_432_19 and arg_429_1.time_ < var_432_17 + var_432_19 + arg_432_0 and arg_429_1.var_.alphaMatValueST07b then
				local var_432_23 = arg_429_1.var_.alphaMatValueST07b
				local var_432_24 = var_432_23.color

				var_432_24.a = 1
				var_432_23.color = var_432_24
			end

			local var_432_25 = arg_429_1.actors_["1094ui_story"].transform
			local var_432_26 = 0

			if var_432_26 < arg_429_1.time_ and arg_429_1.time_ <= var_432_26 + arg_432_0 then
				arg_429_1.var_.moveOldPos1094ui_story = var_432_25.localPosition
			end

			local var_432_27 = 0.001

			if var_432_26 <= arg_429_1.time_ and arg_429_1.time_ < var_432_26 + var_432_27 then
				local var_432_28 = (arg_429_1.time_ - var_432_26) / var_432_27
				local var_432_29 = Vector3.New(0, 100, 0)

				var_432_25.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1094ui_story, var_432_29, var_432_28)

				local var_432_30 = manager.ui.mainCamera.transform.position - var_432_25.position

				var_432_25.forward = Vector3.New(var_432_30.x, var_432_30.y, var_432_30.z)

				local var_432_31 = var_432_25.localEulerAngles

				var_432_31.z = 0
				var_432_31.x = 0
				var_432_25.localEulerAngles = var_432_31
			end

			if arg_429_1.time_ >= var_432_26 + var_432_27 and arg_429_1.time_ < var_432_26 + var_432_27 + arg_432_0 then
				var_432_25.localPosition = Vector3.New(0, 100, 0)

				local var_432_32 = manager.ui.mainCamera.transform.position - var_432_25.position

				var_432_25.forward = Vector3.New(var_432_32.x, var_432_32.y, var_432_32.z)

				local var_432_33 = var_432_25.localEulerAngles

				var_432_33.z = 0
				var_432_33.x = 0
				var_432_25.localEulerAngles = var_432_33
			end

			local var_432_34 = arg_429_1.bgs_.D06_1
			local var_432_35 = 0

			if var_432_35 < arg_429_1.time_ and arg_429_1.time_ <= var_432_35 + arg_432_0 then
				local var_432_36 = var_432_34:GetComponent("SpriteRenderer")

				if var_432_36 then
					arg_429_1.var_.alphaOldValueD06_1 = var_432_36.color.a
					arg_429_1.var_.alphaMatValueD06_1 = var_432_36
				end

				arg_429_1.var_.alphaOldValueD06_1 = 1
			end

			local var_432_37 = 1.5

			if var_432_35 <= arg_429_1.time_ and arg_429_1.time_ < var_432_35 + var_432_37 then
				local var_432_38 = (arg_429_1.time_ - var_432_35) / var_432_37
				local var_432_39 = Mathf.Lerp(arg_429_1.var_.alphaOldValueD06_1, 0, var_432_38)

				if arg_429_1.var_.alphaMatValueD06_1 then
					local var_432_40 = arg_429_1.var_.alphaMatValueD06_1.color

					var_432_40.a = var_432_39
					arg_429_1.var_.alphaMatValueD06_1.color = var_432_40
				end
			end

			if arg_429_1.time_ >= var_432_35 + var_432_37 and arg_429_1.time_ < var_432_35 + var_432_37 + arg_432_0 and arg_429_1.var_.alphaMatValueD06_1 then
				local var_432_41 = arg_429_1.var_.alphaMatValueD06_1
				local var_432_42 = var_432_41.color

				var_432_42.a = 0
				var_432_41.color = var_432_42
			end

			local var_432_43 = 0

			if var_432_43 < arg_429_1.time_ and arg_429_1.time_ <= var_432_43 + arg_432_0 then
				arg_429_1.allBtn_.enabled = false
			end

			local var_432_44 = 3

			if arg_429_1.time_ >= var_432_43 + var_432_44 and arg_429_1.time_ < var_432_43 + var_432_44 + arg_432_0 then
				arg_429_1.allBtn_.enabled = true
			end

			if arg_429_1.frameCnt_ <= 1 then
				arg_429_1.dialog_:SetActive(false)
			end

			local var_432_45 = 3
			local var_432_46 = 1.35

			if var_432_45 < arg_429_1.time_ and arg_429_1.time_ <= var_432_45 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0

				arg_429_1.dialog_:SetActive(true)

				arg_429_1.dialogCg_.alpha = 0

				local var_432_47 = LeanTween.value(arg_429_1.dialog_, 0, 1, 0.3)

				var_432_47:setOnUpdate(LuaHelper.FloatAction(function(arg_433_0)
					arg_429_1.dialogCg_.alpha = arg_433_0
				end))
				var_432_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_429_1.dialog_)
					var_432_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_429_1.duration_ = arg_429_1.duration_ + 0.3

				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_48 = arg_429_1:GetWordFromCfg(111081106)
				local var_432_49 = arg_429_1:FormatText(var_432_48.content)

				arg_429_1.text_.text = var_432_49

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_50 = 54
				local var_432_51 = utf8.len(var_432_49)
				local var_432_52 = var_432_50 <= 0 and var_432_46 or var_432_46 * (var_432_51 / var_432_50)

				if var_432_52 > 0 and var_432_46 < var_432_52 then
					arg_429_1.talkMaxDuration = var_432_52
					var_432_45 = var_432_45 + 0.3

					if var_432_52 + var_432_45 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_52 + var_432_45
					end
				end

				arg_429_1.text_.text = var_432_49
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_53 = var_432_45 + 0.3
			local var_432_54 = math.max(var_432_46, arg_429_1.talkMaxDuration)

			if var_432_53 <= arg_429_1.time_ and arg_429_1.time_ < var_432_53 + var_432_54 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_53) / var_432_54

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_53 + var_432_54 and arg_429_1.time_ < var_432_53 + var_432_54 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play111081107 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 111081107
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play111081108(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0
			local var_438_1 = 0.9

			if var_438_0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_2 = arg_435_1:GetWordFromCfg(111081107)
				local var_438_3 = arg_435_1:FormatText(var_438_2.content)

				arg_435_1.text_.text = var_438_3

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_4 = 36
				local var_438_5 = utf8.len(var_438_3)
				local var_438_6 = var_438_4 <= 0 and var_438_1 or var_438_1 * (var_438_5 / var_438_4)

				if var_438_6 > 0 and var_438_1 < var_438_6 then
					arg_435_1.talkMaxDuration = var_438_6

					if var_438_6 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_6 + var_438_0
					end
				end

				arg_435_1.text_.text = var_438_3
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_7 = math.max(var_438_1, arg_435_1.talkMaxDuration)

			if var_438_0 <= arg_435_1.time_ and arg_435_1.time_ < var_438_0 + var_438_7 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_0) / var_438_7

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_0 + var_438_7 and arg_435_1.time_ < var_438_0 + var_438_7 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play111081108 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 111081108
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play111081109(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 0.85

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_2 = arg_439_1:GetWordFromCfg(111081108)
				local var_442_3 = arg_439_1:FormatText(var_442_2.content)

				arg_439_1.text_.text = var_442_3

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_4 = 34
				local var_442_5 = utf8.len(var_442_3)
				local var_442_6 = var_442_4 <= 0 and var_442_1 or var_442_1 * (var_442_5 / var_442_4)

				if var_442_6 > 0 and var_442_1 < var_442_6 then
					arg_439_1.talkMaxDuration = var_442_6

					if var_442_6 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_6 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_3
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_7 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_7 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_7

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_7 and arg_439_1.time_ < var_442_0 + var_442_7 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play111081109 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 111081109
		arg_443_1.duration_ = 4.03

		local var_443_0 = {
			ja = 3,
			ko = 3,
			zh = 4.033,
			en = 2.566
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play111081110(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0
			local var_446_1 = 0.35

			if var_446_0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_2 = arg_443_1:FormatText(StoryNameCfg[189].name)

				arg_443_1.leftNameTxt_.text = var_446_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_3 = arg_443_1:GetWordFromCfg(111081109)
				local var_446_4 = arg_443_1:FormatText(var_446_3.content)

				arg_443_1.text_.text = var_446_4

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 16
				local var_446_6 = utf8.len(var_446_4)
				local var_446_7 = var_446_5 <= 0 and var_446_1 or var_446_1 * (var_446_6 / var_446_5)

				if var_446_7 > 0 and var_446_1 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_0
					end
				end

				arg_443_1.text_.text = var_446_4
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081109", "story_v_out_111081.awb") ~= 0 then
					local var_446_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081109", "story_v_out_111081.awb") / 1000

					if var_446_8 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_8 + var_446_0
					end

					if var_446_3.prefab_name ~= "" and arg_443_1.actors_[var_446_3.prefab_name] ~= nil then
						local var_446_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_3.prefab_name].transform, "story_v_out_111081", "111081109", "story_v_out_111081.awb")

						arg_443_1:RecordAudio("111081109", var_446_9)
						arg_443_1:RecordAudio("111081109", var_446_9)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_111081", "111081109", "story_v_out_111081.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_111081", "111081109", "story_v_out_111081.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_10 = math.max(var_446_1, arg_443_1.talkMaxDuration)

			if var_446_0 <= arg_443_1.time_ and arg_443_1.time_ < var_446_0 + var_446_10 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_0) / var_446_10

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_0 + var_446_10 and arg_443_1.time_ < var_446_0 + var_446_10 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play111081110 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 111081110
		arg_447_1.duration_ = 3.03

		local var_447_0 = {
			ja = 2.9,
			ko = 1.999999999999,
			zh = 3.033,
			en = 2.166
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play111081111(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = arg_447_1.actors_["1094ui_story"].transform
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1.var_.moveOldPos1094ui_story = var_450_0.localPosition
			end

			local var_450_2 = 0.001

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_2 then
				local var_450_3 = (arg_447_1.time_ - var_450_1) / var_450_2
				local var_450_4 = Vector3.New(0, -0.84, -6.1)

				var_450_0.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1094ui_story, var_450_4, var_450_3)

				local var_450_5 = manager.ui.mainCamera.transform.position - var_450_0.position

				var_450_0.forward = Vector3.New(var_450_5.x, var_450_5.y, var_450_5.z)

				local var_450_6 = var_450_0.localEulerAngles

				var_450_6.z = 0
				var_450_6.x = 0
				var_450_0.localEulerAngles = var_450_6
			end

			if arg_447_1.time_ >= var_450_1 + var_450_2 and arg_447_1.time_ < var_450_1 + var_450_2 + arg_450_0 then
				var_450_0.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_450_7 = manager.ui.mainCamera.transform.position - var_450_0.position

				var_450_0.forward = Vector3.New(var_450_7.x, var_450_7.y, var_450_7.z)

				local var_450_8 = var_450_0.localEulerAngles

				var_450_8.z = 0
				var_450_8.x = 0
				var_450_0.localEulerAngles = var_450_8
			end

			local var_450_9 = 0

			if var_450_9 < arg_447_1.time_ and arg_447_1.time_ <= var_450_9 + arg_450_0 then
				arg_447_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_1")
			end

			local var_450_10 = 0

			if var_450_10 < arg_447_1.time_ and arg_447_1.time_ <= var_450_10 + arg_450_0 then
				arg_447_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_450_11 = arg_447_1.actors_["1094ui_story"]
			local var_450_12 = 0

			if var_450_12 < arg_447_1.time_ and arg_447_1.time_ <= var_450_12 + arg_450_0 and not isNil(var_450_11) and arg_447_1.var_.characterEffect1094ui_story == nil then
				arg_447_1.var_.characterEffect1094ui_story = var_450_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_13 = 0.2

			if var_450_12 <= arg_447_1.time_ and arg_447_1.time_ < var_450_12 + var_450_13 and not isNil(var_450_11) then
				local var_450_14 = (arg_447_1.time_ - var_450_12) / var_450_13

				if arg_447_1.var_.characterEffect1094ui_story and not isNil(var_450_11) then
					arg_447_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= var_450_12 + var_450_13 and arg_447_1.time_ < var_450_12 + var_450_13 + arg_450_0 and not isNil(var_450_11) and arg_447_1.var_.characterEffect1094ui_story then
				arg_447_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_450_15 = 0
			local var_450_16 = 0.15

			if var_450_15 < arg_447_1.time_ and arg_447_1.time_ <= var_450_15 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_17 = arg_447_1:FormatText(StoryNameCfg[181].name)

				arg_447_1.leftNameTxt_.text = var_450_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_18 = arg_447_1:GetWordFromCfg(111081110)
				local var_450_19 = arg_447_1:FormatText(var_450_18.content)

				arg_447_1.text_.text = var_450_19

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_20 = 6
				local var_450_21 = utf8.len(var_450_19)
				local var_450_22 = var_450_20 <= 0 and var_450_16 or var_450_16 * (var_450_21 / var_450_20)

				if var_450_22 > 0 and var_450_16 < var_450_22 then
					arg_447_1.talkMaxDuration = var_450_22

					if var_450_22 + var_450_15 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_22 + var_450_15
					end
				end

				arg_447_1.text_.text = var_450_19
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081110", "story_v_out_111081.awb") ~= 0 then
					local var_450_23 = manager.audio:GetVoiceLength("story_v_out_111081", "111081110", "story_v_out_111081.awb") / 1000

					if var_450_23 + var_450_15 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_23 + var_450_15
					end

					if var_450_18.prefab_name ~= "" and arg_447_1.actors_[var_450_18.prefab_name] ~= nil then
						local var_450_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_18.prefab_name].transform, "story_v_out_111081", "111081110", "story_v_out_111081.awb")

						arg_447_1:RecordAudio("111081110", var_450_24)
						arg_447_1:RecordAudio("111081110", var_450_24)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_111081", "111081110", "story_v_out_111081.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_111081", "111081110", "story_v_out_111081.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_25 = math.max(var_450_16, arg_447_1.talkMaxDuration)

			if var_450_15 <= arg_447_1.time_ and arg_447_1.time_ < var_450_15 + var_450_25 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_15) / var_450_25

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_15 + var_450_25 and arg_447_1.time_ < var_450_15 + var_450_25 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play111081111 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 111081111
		arg_451_1.duration_ = 13

		local var_451_0 = {
			ja = 11.233,
			ko = 11.833,
			zh = 13,
			en = 12.2
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play111081112(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["1094ui_story"]
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.characterEffect1094ui_story == nil then
				arg_451_1.var_.characterEffect1094ui_story = var_454_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_2 = 0.2

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_2 and not isNil(var_454_0) then
				local var_454_3 = (arg_451_1.time_ - var_454_1) / var_454_2

				if arg_451_1.var_.characterEffect1094ui_story and not isNil(var_454_0) then
					local var_454_4 = Mathf.Lerp(0, 0.5, var_454_3)

					arg_451_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1094ui_story.fillRatio = var_454_4
				end
			end

			if arg_451_1.time_ >= var_454_1 + var_454_2 and arg_451_1.time_ < var_454_1 + var_454_2 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.characterEffect1094ui_story then
				local var_454_5 = 0.5

				arg_451_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1094ui_story.fillRatio = var_454_5
			end

			local var_454_6 = 0
			local var_454_7 = 1.4

			if var_454_6 < arg_451_1.time_ and arg_451_1.time_ <= var_454_6 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_8 = arg_451_1:FormatText(StoryNameCfg[183].name)

				arg_451_1.leftNameTxt_.text = var_454_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_9 = arg_451_1:GetWordFromCfg(111081111)
				local var_454_10 = arg_451_1:FormatText(var_454_9.content)

				arg_451_1.text_.text = var_454_10

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_11 = 56
				local var_454_12 = utf8.len(var_454_10)
				local var_454_13 = var_454_11 <= 0 and var_454_7 or var_454_7 * (var_454_12 / var_454_11)

				if var_454_13 > 0 and var_454_7 < var_454_13 then
					arg_451_1.talkMaxDuration = var_454_13

					if var_454_13 + var_454_6 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_13 + var_454_6
					end
				end

				arg_451_1.text_.text = var_454_10
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081111", "story_v_out_111081.awb") ~= 0 then
					local var_454_14 = manager.audio:GetVoiceLength("story_v_out_111081", "111081111", "story_v_out_111081.awb") / 1000

					if var_454_14 + var_454_6 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_14 + var_454_6
					end

					if var_454_9.prefab_name ~= "" and arg_451_1.actors_[var_454_9.prefab_name] ~= nil then
						local var_454_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_9.prefab_name].transform, "story_v_out_111081", "111081111", "story_v_out_111081.awb")

						arg_451_1:RecordAudio("111081111", var_454_15)
						arg_451_1:RecordAudio("111081111", var_454_15)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_111081", "111081111", "story_v_out_111081.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_111081", "111081111", "story_v_out_111081.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_16 = math.max(var_454_7, arg_451_1.talkMaxDuration)

			if var_454_6 <= arg_451_1.time_ and arg_451_1.time_ < var_454_6 + var_454_16 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_6) / var_454_16

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_6 + var_454_16 and arg_451_1.time_ < var_454_6 + var_454_16 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play111081112 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 111081112
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play111081113(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0
			local var_458_1 = 0.2

			if var_458_0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_2 = arg_455_1:FormatText(StoryNameCfg[7].name)

				arg_455_1.leftNameTxt_.text = var_458_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_3 = arg_455_1:GetWordFromCfg(111081112)
				local var_458_4 = arg_455_1:FormatText(var_458_3.content)

				arg_455_1.text_.text = var_458_4

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_5 = 14
				local var_458_6 = utf8.len(var_458_4)
				local var_458_7 = var_458_5 <= 0 and var_458_1 or var_458_1 * (var_458_6 / var_458_5)

				if var_458_7 > 0 and var_458_1 < var_458_7 then
					arg_455_1.talkMaxDuration = var_458_7

					if var_458_7 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_7 + var_458_0
					end
				end

				arg_455_1.text_.text = var_458_4
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_8 = math.max(var_458_1, arg_455_1.talkMaxDuration)

			if var_458_0 <= arg_455_1.time_ and arg_455_1.time_ < var_458_0 + var_458_8 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_0) / var_458_8

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_0 + var_458_8 and arg_455_1.time_ < var_458_0 + var_458_8 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play111081113 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 111081113
		arg_459_1.duration_ = 14

		local var_459_0 = {
			ja = 14,
			ko = 9.666,
			zh = 9.966,
			en = 9.666
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play111081114(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0
			local var_462_1 = 1

			if var_462_0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_2 = arg_459_1:FormatText(StoryNameCfg[183].name)

				arg_459_1.leftNameTxt_.text = var_462_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, true)
				arg_459_1.iconController_:SetSelectedState("hero")

				arg_459_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_459_1.callingController_:SetSelectedState("normal")

				arg_459_1.keyicon_.color = Color.New(1, 1, 1)
				arg_459_1.icon_.color = Color.New(1, 1, 1)

				local var_462_3 = arg_459_1:GetWordFromCfg(111081113)
				local var_462_4 = arg_459_1:FormatText(var_462_3.content)

				arg_459_1.text_.text = var_462_4

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_5 = 40
				local var_462_6 = utf8.len(var_462_4)
				local var_462_7 = var_462_5 <= 0 and var_462_1 or var_462_1 * (var_462_6 / var_462_5)

				if var_462_7 > 0 and var_462_1 < var_462_7 then
					arg_459_1.talkMaxDuration = var_462_7

					if var_462_7 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_7 + var_462_0
					end
				end

				arg_459_1.text_.text = var_462_4
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081113", "story_v_out_111081.awb") ~= 0 then
					local var_462_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081113", "story_v_out_111081.awb") / 1000

					if var_462_8 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_8 + var_462_0
					end

					if var_462_3.prefab_name ~= "" and arg_459_1.actors_[var_462_3.prefab_name] ~= nil then
						local var_462_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_3.prefab_name].transform, "story_v_out_111081", "111081113", "story_v_out_111081.awb")

						arg_459_1:RecordAudio("111081113", var_462_9)
						arg_459_1:RecordAudio("111081113", var_462_9)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_111081", "111081113", "story_v_out_111081.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_111081", "111081113", "story_v_out_111081.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_10 = math.max(var_462_1, arg_459_1.talkMaxDuration)

			if var_462_0 <= arg_459_1.time_ and arg_459_1.time_ < var_462_0 + var_462_10 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_0) / var_462_10

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_0 + var_462_10 and arg_459_1.time_ < var_462_0 + var_462_10 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play111081114 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 111081114
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play111081115(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0
			local var_466_1 = 0.525

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_2 = arg_463_1:FormatText(StoryNameCfg[7].name)

				arg_463_1.leftNameTxt_.text = var_466_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_3 = arg_463_1:GetWordFromCfg(111081114)
				local var_466_4 = arg_463_1:FormatText(var_466_3.content)

				arg_463_1.text_.text = var_466_4

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_5 = 21
				local var_466_6 = utf8.len(var_466_4)
				local var_466_7 = var_466_5 <= 0 and var_466_1 or var_466_1 * (var_466_6 / var_466_5)

				if var_466_7 > 0 and var_466_1 < var_466_7 then
					arg_463_1.talkMaxDuration = var_466_7

					if var_466_7 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_7 + var_466_0
					end
				end

				arg_463_1.text_.text = var_466_4
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_8 = math.max(var_466_1, arg_463_1.talkMaxDuration)

			if var_466_0 <= arg_463_1.time_ and arg_463_1.time_ < var_466_0 + var_466_8 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_0) / var_466_8

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_0 + var_466_8 and arg_463_1.time_ < var_466_0 + var_466_8 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play111081115 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 111081115
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play111081116(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0
			local var_470_1 = 0.95

			if var_470_0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, false)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_2 = arg_467_1:GetWordFromCfg(111081115)
				local var_470_3 = arg_467_1:FormatText(var_470_2.content)

				arg_467_1.text_.text = var_470_3

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_4 = 38
				local var_470_5 = utf8.len(var_470_3)
				local var_470_6 = var_470_4 <= 0 and var_470_1 or var_470_1 * (var_470_5 / var_470_4)

				if var_470_6 > 0 and var_470_1 < var_470_6 then
					arg_467_1.talkMaxDuration = var_470_6

					if var_470_6 + var_470_0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_6 + var_470_0
					end
				end

				arg_467_1.text_.text = var_470_3
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_7 = math.max(var_470_1, arg_467_1.talkMaxDuration)

			if var_470_0 <= arg_467_1.time_ and arg_467_1.time_ < var_470_0 + var_470_7 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_0) / var_470_7

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_0 + var_470_7 and arg_467_1.time_ < var_470_0 + var_470_7 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play111081116 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 111081116
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play111081117(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0
			local var_474_1 = 1.05

			if var_474_0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_2 = arg_471_1:GetWordFromCfg(111081116)
				local var_474_3 = arg_471_1:FormatText(var_474_2.content)

				arg_471_1.text_.text = var_474_3

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_4 = 42
				local var_474_5 = utf8.len(var_474_3)
				local var_474_6 = var_474_4 <= 0 and var_474_1 or var_474_1 * (var_474_5 / var_474_4)

				if var_474_6 > 0 and var_474_1 < var_474_6 then
					arg_471_1.talkMaxDuration = var_474_6

					if var_474_6 + var_474_0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_6 + var_474_0
					end
				end

				arg_471_1.text_.text = var_474_3
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_7 = math.max(var_474_1, arg_471_1.talkMaxDuration)

			if var_474_0 <= arg_471_1.time_ and arg_471_1.time_ < var_474_0 + var_474_7 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_0) / var_474_7

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_0 + var_474_7 and arg_471_1.time_ < var_474_0 + var_474_7 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play111081117 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 111081117
		arg_475_1.duration_ = 5.1

		local var_475_0 = {
			ja = 5.1,
			ko = 4.666,
			zh = 4.033,
			en = 3.666
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play111081118(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0
			local var_478_1 = 0.375

			if var_478_0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_2 = arg_475_1:FormatText(StoryNameCfg[189].name)

				arg_475_1.leftNameTxt_.text = var_478_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_3 = arg_475_1:GetWordFromCfg(111081117)
				local var_478_4 = arg_475_1:FormatText(var_478_3.content)

				arg_475_1.text_.text = var_478_4

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_5 = 14
				local var_478_6 = utf8.len(var_478_4)
				local var_478_7 = var_478_5 <= 0 and var_478_1 or var_478_1 * (var_478_6 / var_478_5)

				if var_478_7 > 0 and var_478_1 < var_478_7 then
					arg_475_1.talkMaxDuration = var_478_7

					if var_478_7 + var_478_0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_7 + var_478_0
					end
				end

				arg_475_1.text_.text = var_478_4
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081117", "story_v_out_111081.awb") ~= 0 then
					local var_478_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081117", "story_v_out_111081.awb") / 1000

					if var_478_8 + var_478_0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_8 + var_478_0
					end

					if var_478_3.prefab_name ~= "" and arg_475_1.actors_[var_478_3.prefab_name] ~= nil then
						local var_478_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_3.prefab_name].transform, "story_v_out_111081", "111081117", "story_v_out_111081.awb")

						arg_475_1:RecordAudio("111081117", var_478_9)
						arg_475_1:RecordAudio("111081117", var_478_9)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_111081", "111081117", "story_v_out_111081.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_111081", "111081117", "story_v_out_111081.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_10 = math.max(var_478_1, arg_475_1.talkMaxDuration)

			if var_478_0 <= arg_475_1.time_ and arg_475_1.time_ < var_478_0 + var_478_10 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_0) / var_478_10

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_0 + var_478_10 and arg_475_1.time_ < var_478_0 + var_478_10 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play111081118 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 111081118
		arg_479_1.duration_ = 2

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play111081119(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0

			if var_482_0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_0 + arg_482_0 then
				arg_479_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_482_1 = arg_479_1.actors_["1094ui_story"]
			local var_482_2 = 0

			if var_482_2 < arg_479_1.time_ and arg_479_1.time_ <= var_482_2 + arg_482_0 and not isNil(var_482_1) and arg_479_1.var_.characterEffect1094ui_story == nil then
				arg_479_1.var_.characterEffect1094ui_story = var_482_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_3 = 0.2

			if var_482_2 <= arg_479_1.time_ and arg_479_1.time_ < var_482_2 + var_482_3 and not isNil(var_482_1) then
				local var_482_4 = (arg_479_1.time_ - var_482_2) / var_482_3

				if arg_479_1.var_.characterEffect1094ui_story and not isNil(var_482_1) then
					arg_479_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_479_1.time_ >= var_482_2 + var_482_3 and arg_479_1.time_ < var_482_2 + var_482_3 + arg_482_0 and not isNil(var_482_1) and arg_479_1.var_.characterEffect1094ui_story then
				arg_479_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_482_5 = 0
			local var_482_6 = 0.075

			if var_482_5 < arg_479_1.time_ and arg_479_1.time_ <= var_482_5 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_7 = arg_479_1:FormatText(StoryNameCfg[181].name)

				arg_479_1.leftNameTxt_.text = var_482_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_8 = arg_479_1:GetWordFromCfg(111081118)
				local var_482_9 = arg_479_1:FormatText(var_482_8.content)

				arg_479_1.text_.text = var_482_9

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_10 = 3
				local var_482_11 = utf8.len(var_482_9)
				local var_482_12 = var_482_10 <= 0 and var_482_6 or var_482_6 * (var_482_11 / var_482_10)

				if var_482_12 > 0 and var_482_6 < var_482_12 then
					arg_479_1.talkMaxDuration = var_482_12

					if var_482_12 + var_482_5 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_12 + var_482_5
					end
				end

				arg_479_1.text_.text = var_482_9
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081118", "story_v_out_111081.awb") ~= 0 then
					local var_482_13 = manager.audio:GetVoiceLength("story_v_out_111081", "111081118", "story_v_out_111081.awb") / 1000

					if var_482_13 + var_482_5 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_13 + var_482_5
					end

					if var_482_8.prefab_name ~= "" and arg_479_1.actors_[var_482_8.prefab_name] ~= nil then
						local var_482_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_8.prefab_name].transform, "story_v_out_111081", "111081118", "story_v_out_111081.awb")

						arg_479_1:RecordAudio("111081118", var_482_14)
						arg_479_1:RecordAudio("111081118", var_482_14)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_111081", "111081118", "story_v_out_111081.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_111081", "111081118", "story_v_out_111081.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_15 = math.max(var_482_6, arg_479_1.talkMaxDuration)

			if var_482_5 <= arg_479_1.time_ and arg_479_1.time_ < var_482_5 + var_482_15 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_5) / var_482_15

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_5 + var_482_15 and arg_479_1.time_ < var_482_5 + var_482_15 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play111081119 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 111081119
		arg_483_1.duration_ = 7.03

		local var_483_0 = {
			ja = 7.033,
			ko = 1.8,
			zh = 3.266,
			en = 3
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play111081120(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0
			local var_486_1 = 0.15

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				local var_486_2 = arg_483_1:FormatText(StoryNameCfg[189].name)

				arg_483_1.leftNameTxt_.text = var_486_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, true)
				arg_483_1.iconController_:SetSelectedState("hero")

				arg_483_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_483_1.callingController_:SetSelectedState("normal")

				arg_483_1.keyicon_.color = Color.New(1, 1, 1)
				arg_483_1.icon_.color = Color.New(1, 1, 1)

				local var_486_3 = arg_483_1:GetWordFromCfg(111081119)
				local var_486_4 = arg_483_1:FormatText(var_486_3.content)

				arg_483_1.text_.text = var_486_4

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_5 = 6
				local var_486_6 = utf8.len(var_486_4)
				local var_486_7 = var_486_5 <= 0 and var_486_1 or var_486_1 * (var_486_6 / var_486_5)

				if var_486_7 > 0 and var_486_1 < var_486_7 then
					arg_483_1.talkMaxDuration = var_486_7

					if var_486_7 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_7 + var_486_0
					end
				end

				arg_483_1.text_.text = var_486_4
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111081", "111081119", "story_v_out_111081.awb") ~= 0 then
					local var_486_8 = manager.audio:GetVoiceLength("story_v_out_111081", "111081119", "story_v_out_111081.awb") / 1000

					if var_486_8 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_8 + var_486_0
					end

					if var_486_3.prefab_name ~= "" and arg_483_1.actors_[var_486_3.prefab_name] ~= nil then
						local var_486_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_3.prefab_name].transform, "story_v_out_111081", "111081119", "story_v_out_111081.awb")

						arg_483_1:RecordAudio("111081119", var_486_9)
						arg_483_1:RecordAudio("111081119", var_486_9)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_111081", "111081119", "story_v_out_111081.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_111081", "111081119", "story_v_out_111081.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_10 = math.max(var_486_1, arg_483_1.talkMaxDuration)

			if var_486_0 <= arg_483_1.time_ and arg_483_1.time_ < var_486_0 + var_486_10 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_0) / var_486_10

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_0 + var_486_10 and arg_483_1.time_ < var_486_0 + var_486_10 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play111081120 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 111081120
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
			arg_487_1.auto_ = false
		end

		function arg_487_1.playNext_(arg_489_0)
			arg_487_1.onStoryFinished_()
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0
			local var_490_1 = 0.225

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_2 = arg_487_1:GetWordFromCfg(111081120)
				local var_490_3 = arg_487_1:FormatText(var_490_2.content)

				arg_487_1.text_.text = var_490_3

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_4 = 9
				local var_490_5 = utf8.len(var_490_3)
				local var_490_6 = var_490_4 <= 0 and var_490_1 or var_490_1 * (var_490_5 / var_490_4)

				if var_490_6 > 0 and var_490_1 < var_490_6 then
					arg_487_1.talkMaxDuration = var_490_6

					if var_490_6 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_6 + var_490_0
					end
				end

				arg_487_1.text_.text = var_490_3
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_7 = math.max(var_490_1, arg_487_1.talkMaxDuration)

			if var_490_0 <= arg_487_1.time_ and arg_487_1.time_ < var_490_0 + var_490_7 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_0) / var_490_7

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_0 + var_490_7 and arg_487_1.time_ < var_490_0 + var_490_7 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D999",
		"TextureConfig/Background/D06_1",
		"TextureConfig/Background/ST07b"
	},
	voices = {
		"story_v_out_111081.awb"
	}
}
