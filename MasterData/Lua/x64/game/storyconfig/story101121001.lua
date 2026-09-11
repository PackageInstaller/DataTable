return {
	Play112101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112101001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
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

			local var_4_3 = 0
			local var_4_4 = 1.025

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_5 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(112101001).content)

				arg_1_1.text_.text = var_4_5

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_7 = 41 <= 0 and var_4_4 or var_4_4 * (utf8.len(var_4_5) / 41)

				if (41 <= 0 and var_4_4 or var_4_4 * (utf8.len(var_4_5) / 41)) > 0 and var_4_4 < var_4_7 then
					arg_1_1.talkMaxDuration = var_4_7

					if var_4_7 + var_4_3 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_7 + var_4_3
					end
				end

				arg_1_1.text_.text = var_4_5
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_8 = math.max(var_4_4, arg_1_1.talkMaxDuration)

			if var_4_3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_3 + var_4_8 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_3) / var_4_8

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_3 + var_4_8 and arg_1_1.time_ < var_4_3 + var_4_8 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play112101002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 112101002
		arg_6_1.duration_ = 5

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play112101003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = 0.725

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0
				arg_6_1.dialogCg_.alpha = 1

				arg_6_1.dialog_:SetActive(true)
				SetActive(arg_6_1.leftNameGo_, false)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_1 = arg_6_1:FormatText(arg_6_1:GetWordFromCfg(112101002).content)

				arg_6_1.text_.text = var_9_1

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_3 = 29 <= 0 and var_9_0 or var_9_0 * (utf8.len(var_9_1) / 29)

				if (29 <= 0 and var_9_0 or var_9_0 * (utf8.len(var_9_1) / 29)) > 0 and var_9_0 < var_9_3 then
					arg_6_1.talkMaxDuration = var_9_3

					if var_9_3 + 0 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_3 + 0
					end
				end

				arg_6_1.text_.text = var_9_1
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)
				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_4 = math.max(var_9_0, arg_6_1.talkMaxDuration)

			if 0 <= arg_6_1.time_ and arg_6_1.time_ < 0 + var_9_4 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - 0) / var_9_4

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= 0 + var_9_4 and arg_6_1.time_ < 0 + var_9_4 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play112101003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 112101003
		arg_10_1.duration_ = 8.17

		local var_10_0 = {
			ja = 8.166,
			ko = 6.433,
			zh = 4.466,
			en = 4.8
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
				arg_10_0:Play112101004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0.625

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				arg_10_1.leftNameTxt_.text = arg_10_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, true)
				arg_10_1.iconController_:SetSelectedState("hero")

				arg_10_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_10_1.callingController_:SetSelectedState("normal")

				arg_10_1.keyicon_.color = Color.New(1, 1, 1)
				arg_10_1.icon_.color = Color.New(1, 1, 1)

				local var_13_1 = arg_10_1:GetWordFromCfg(112101003)
				local var_13_2 = arg_10_1:FormatText(var_13_1.content)

				arg_10_1.text_.text = var_13_2

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_4 = 25 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_2) / 25)

				if (25 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_2) / 25)) > 0 and var_13_0 < var_13_4 then
					arg_10_1.talkMaxDuration = var_13_4

					if var_13_4 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_4 + 0
					end
				end

				arg_10_1.text_.text = var_13_2
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112101", "112101003", "story_v_out_112101.awb") ~= 0 then
					local var_13_5 = manager.audio:GetVoiceLength("story_v_out_112101", "112101003", "story_v_out_112101.awb") / 1000

					if var_13_5 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_5 + 0
					end

					if var_13_1.prefab_name ~= "" and arg_10_1.actors_[var_13_1.prefab_name] ~= nil then
						local var_13_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_1.prefab_name].transform, "story_v_out_112101", "112101003", "story_v_out_112101.awb")

						arg_10_1:RecordAudio("112101003", var_13_6)
						arg_10_1:RecordAudio("112101003", var_13_6)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_112101", "112101003", "story_v_out_112101.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_112101", "112101003", "story_v_out_112101.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_7 = math.max(var_13_0, arg_10_1.talkMaxDuration)

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_7 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - 0) / var_13_7

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= 0 + var_13_7 and arg_10_1.time_ < 0 + var_13_7 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play112101004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 112101004
		arg_14_1.duration_ = 2.03

		local var_14_0 = {
			ja = 2.033,
			ko = 1.6,
			zh = 2,
			en = 1.3
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play112101005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0.15

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_1 = arg_14_1:GetWordFromCfg(112101004)
				local var_17_2 = arg_14_1:FormatText(var_17_1.content)

				arg_14_1.text_.text = var_17_2

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_4 = 6 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_2) / 6)

				if (6 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_2) / 6)) > 0 and var_17_0 < var_17_4 then
					arg_14_1.talkMaxDuration = var_17_4

					if var_17_4 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_4 + 0
					end
				end

				arg_14_1.text_.text = var_17_2
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112101", "112101004", "story_v_out_112101.awb") ~= 0 then
					local var_17_5 = manager.audio:GetVoiceLength("story_v_out_112101", "112101004", "story_v_out_112101.awb") / 1000

					if var_17_5 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_5 + 0
					end

					if var_17_1.prefab_name ~= "" and arg_14_1.actors_[var_17_1.prefab_name] ~= nil then
						local var_17_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_1.prefab_name].transform, "story_v_out_112101", "112101004", "story_v_out_112101.awb")

						arg_14_1:RecordAudio("112101004", var_17_6)
						arg_14_1:RecordAudio("112101004", var_17_6)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_112101", "112101004", "story_v_out_112101.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_112101", "112101004", "story_v_out_112101.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_7 = math.max(var_17_0, arg_14_1.talkMaxDuration)

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_7 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - 0) / var_17_7

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= 0 + var_17_7 and arg_14_1.time_ < 0 + var_17_7 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play112101005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 112101005
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play112101006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0.125

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_1 = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(112101005).content)

				arg_18_1.text_.text = var_21_1

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_3 = 5 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_1) / 5)

				if (5 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_1) / 5)) > 0 and var_21_0 < var_21_3 then
					arg_18_1.talkMaxDuration = var_21_3

					if var_21_3 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_3 + 0
					end
				end

				arg_18_1.text_.text = var_21_1
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_4 = math.max(var_21_0, arg_18_1.talkMaxDuration)

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_4 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - 0) / var_21_4

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= 0 + var_21_4 and arg_18_1.time_ < 0 + var_21_4 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play112101006 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 112101006
		arg_22_1.duration_ = 6.2

		local var_22_0 = {
			ja = 6.2,
			ko = 3.066,
			zh = 3.033,
			en = 5.733
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
				arg_22_0:Play112101007(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.225

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_1 = arg_22_1:GetWordFromCfg(112101006)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.text_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 9 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 9)

				if (9 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 9)) > 0 and var_25_0 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end

				arg_22_1.text_.text = var_25_2
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112101", "112101006", "story_v_out_112101.awb") ~= 0 then
					local var_25_5 = manager.audio:GetVoiceLength("story_v_out_112101", "112101006", "story_v_out_112101.awb") / 1000

					if var_25_5 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + 0
					end

					if var_25_1.prefab_name ~= "" and arg_22_1.actors_[var_25_1.prefab_name] ~= nil then
						local var_25_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_1.prefab_name].transform, "story_v_out_112101", "112101006", "story_v_out_112101.awb")

						arg_22_1:RecordAudio("112101006", var_25_6)
						arg_22_1:RecordAudio("112101006", var_25_6)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_112101", "112101006", "story_v_out_112101.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_112101", "112101006", "story_v_out_112101.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_7 = math.max(var_25_0, arg_22_1.talkMaxDuration)

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_7 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - 0) / var_25_7

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= 0 + var_25_7 and arg_22_1.time_ < 0 + var_25_7 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play112101007 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 112101007
		arg_26_1.duration_ = 7

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play112101008(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_9000

			if arg_26_1.bgs_.SA0104 == nil then
				local var_29_0 = Object.Instantiate(arg_26_1.paintGo_)

				var_29_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SA0104")
				var_29_0.name = "SA0104"
				var_29_0.transform.parent = arg_26_1.stage_.transform
				var_29_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_26_1.bgs_.SA0104 = var_29_0
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				local var_29_1 = arg_26_1.bgs_.SA0104

				arg_26_1.bgs_.SA0104.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_29_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_29_2 = var_29_1:GetComponent("SpriteRenderer")

				if var_29_2 and var_29_2.sprite then
					local var_29_3 = 2 * (var_29_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_29_1.transform.localScale = Vector3.New(var_29_3 / var_29_2.sprite.bounds.size.y < var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x and var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x or var_29_3 / var_29_2.sprite.bounds.size.y, var_29_3 / var_29_2.sprite.bounds.size.y < var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x and var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x or var_29_3 / var_29_2.sprite.bounds.size.y, 0)
				end

				for iter_29_0, iter_29_1 in pairs(arg_26_1.bgs_) do
					if iter_29_0 ~= "SA0104" then
						iter_29_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_29_4 = 0

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_5 = 2

			if var_29_4 <= arg_26_1.time_ and arg_26_1.time_ < var_29_4 + var_29_5 then
				local var_29_6 = Color.New(0, 0, 0)

				var_29_6.a = Mathf.Lerp(1, 0, (arg_26_1.time_ - var_29_4) / var_29_5)
				arg_26_1.mask_.color = var_29_6
			end

			if arg_26_1.time_ >= var_29_4 + var_29_5 and arg_26_1.time_ < var_29_4 + var_29_5 + arg_29_0 then
				local var_29_7 = Color.New(0, 0, 0)

				arg_26_1.mask_.enabled = false
				var_29_7.a = 0
				arg_26_1.mask_.color = var_29_7
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				local var_29_8 = arg_26_1.var_.effectSA0104shuidi1

				if not arg_26_1.var_.effectSA0104shuidi1 then
					var_29_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), arg_26_1.bgs_.SA0104.transform)
					var_29_8.name = "shuidi1"
					arg_26_1.var_.effectSA0104shuidi1 = var_29_8
				else
					var_29_8.transform:SetParent(var_29_9000)
				end

				var_29_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_29_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_26_1.time_ and arg_26_1.time_ <= 2 + arg_29_0 then
				arg_26_1:AudioAction("play", "music", "bgm_activity_1_2_1_summer2_story_general", "bgm_activity_1_2_1_summer2_story_general", "bgm_activity_1_2_1_summer2_story_general.awb")

				local var_29_12 = manager.audio:GetAudioName("bgm_activity_1_2_1_summer2_story_general", "bgm_activity_1_2_1_summer2_story_general")

				if "" ~= "" then
					if arg_26_1.bgmTxt_.text ~= var_29_12 and arg_26_1.bgmTxt_.text ~= "" then
						if arg_26_1.bgmTxt2_.text ~= "" then
							arg_26_1.bgmTxt_.text = arg_26_1.bgmTxt2_.text
						end

						arg_26_1.bgmTxt2_.text = var_29_12

						arg_26_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_26_1.bgmTxt_.text = var_29_12
						arg_26_1.bgmTxt2_.text = var_29_12
					end

					if arg_26_1.bgmTimer then
						arg_26_1.bgmTimer:Stop()

						arg_26_1.bgmTimer = nil
					end

					if arg_26_1.settingData.show_music_name == 1 then
						arg_26_1.musicController:SetSelectedState("show")
						arg_26_1.musicAnimator_:Play("open", 0, 0)

						if arg_26_1.settingData.music_time ~= 0 then
							arg_26_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_26_1.settingData.music_time), function()
								if arg_26_1 == nil or isNil(arg_26_1.bgmTxt_) then
									return
								end

								arg_26_1.musicController:SetSelectedState("hide")
								arg_26_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_26_1.frameCnt_ <= 1 then
				arg_26_1.dialog_:SetActive(false)
			end

			local var_29_13 = 2
			local var_29_14 = 1.05

			if 2 < arg_26_1.time_ and arg_26_1.time_ <= var_29_13 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				arg_26_1.dialog_:SetActive(true)

				arg_26_1.dialogCg_.alpha = 0

				local var_29_15 = LeanTween.value(arg_26_1.dialog_, 0, 1, 0.3)

				var_29_15:setOnUpdate(LuaHelper.FloatAction(function(arg_31_0)
					arg_26_1.dialogCg_.alpha = arg_31_0
				end))
				var_29_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_26_1.dialog_)
					var_29_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_26_1.duration_ = arg_26_1.duration_ + 0.3

				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_16 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(112101007).content)

				arg_26_1.text_.text = var_29_16

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_18 = 42 <= 0 and var_29_14 or var_29_14 * (utf8.len(var_29_16) / 42)

				if (42 <= 0 and var_29_14 or var_29_14 * (utf8.len(var_29_16) / 42)) > 0 and var_29_14 < var_29_18 then
					arg_26_1.talkMaxDuration = var_29_18
					var_29_13 = var_29_13 + 0.3

					if var_29_18 + var_29_13 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_18 + var_29_13
					end
				end

				arg_26_1.text_.text = var_29_16
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_19 = var_29_13 + 0.3
			local var_29_20 = math.max(var_29_14, arg_26_1.talkMaxDuration)

			if var_29_13 + 0.3 <= arg_26_1.time_ and arg_26_1.time_ < var_29_19 + var_29_20 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_19) / var_29_20

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_19 + var_29_20 and arg_26_1.time_ < var_29_19 + var_29_20 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play112101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 112101008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play112101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1.475

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(112101008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 59 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 59)

				if (59 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 59)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play112101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 112101009
		arg_37_1.duration_ = 8.57

		local var_37_0 = {
			ja = 8.566,
			ko = 8.2,
			zh = 6.733,
			en = 5.7
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
				arg_37_0:Play112101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.475

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(112101009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 19 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 19)

				if (19 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 19)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112101", "112101009", "story_v_out_112101.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_112101", "112101009", "story_v_out_112101.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_112101", "112101009", "story_v_out_112101.awb")

						arg_37_1:RecordAudio("112101009", var_40_6)
						arg_37_1:RecordAudio("112101009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_112101", "112101009", "story_v_out_112101.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_112101", "112101009", "story_v_out_112101.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play112101010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 112101010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play112101011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.95

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(112101010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 38 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 38)

				if (38 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 38)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play112101011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 112101011
		arg_45_1.duration_ = 4.1

		local var_45_0 = {
			ja = 3.733,
			ko = 3.6,
			zh = 3.3,
			en = 4.1
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
				arg_45_0:Play112101012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.4

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:GetWordFromCfg(112101011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 16 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 16)

				if (16 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 16)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112101", "112101011", "story_v_out_112101.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_112101", "112101011", "story_v_out_112101.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_112101", "112101011", "story_v_out_112101.awb")

						arg_45_1:RecordAudio("112101011", var_48_6)
						arg_45_1:RecordAudio("112101011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_112101", "112101011", "story_v_out_112101.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_112101", "112101011", "story_v_out_112101.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play112101012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 112101012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play112101013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.5

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(112101012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 20 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 20)

				if (20 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 20)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play112101013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 112101013
		arg_53_1.duration_ = 8.4

		local var_53_0 = {
			ja = 8.4,
			ko = 7.866,
			zh = 7.566,
			en = 7.8
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
				arg_53_0:Play112101014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.925

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:GetWordFromCfg(112101013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 37 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 37)

				if (37 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 37)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112101", "112101013", "story_v_out_112101.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_112101", "112101013", "story_v_out_112101.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_112101", "112101013", "story_v_out_112101.awb")

						arg_53_1:RecordAudio("112101013", var_56_6)
						arg_53_1:RecordAudio("112101013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_112101", "112101013", "story_v_out_112101.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_112101", "112101013", "story_v_out_112101.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play112101014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 112101014
		arg_57_1.duration_ = 8.4

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play112101015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if arg_57_1.bgs_.H04 == nil then
				local var_60_0 = Object.Instantiate(arg_57_1.paintGo_)

				var_60_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H04")
				var_60_0.name = "H04"
				var_60_0.transform.parent = arg_57_1.stage_.transform
				var_60_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.bgs_.H04 = var_60_0
			end

			if 2 < arg_57_1.time_ and arg_57_1.time_ <= 2 + arg_60_0 then
				local var_60_1 = arg_57_1.bgs_.H04

				arg_57_1.bgs_.H04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_60_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_60_2 = var_60_1:GetComponent("SpriteRenderer")

				if var_60_2 and var_60_2.sprite then
					local var_60_3 = 2 * (var_60_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_60_1.transform.localScale = Vector3.New(var_60_3 / var_60_2.sprite.bounds.size.y < var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x and var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x or var_60_3 / var_60_2.sprite.bounds.size.y, var_60_3 / var_60_2.sprite.bounds.size.y < var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x and var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x or var_60_3 / var_60_2.sprite.bounds.size.y, 0)
				end

				for iter_60_0, iter_60_1 in pairs(arg_57_1.bgs_) do
					if iter_60_0 ~= "H04" then
						iter_60_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_60_4 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_5 = 2

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_5 then
				local var_60_6 = Color.New(0, 0, 0)

				var_60_6.a = Mathf.Lerp(0, 1, (arg_57_1.time_ - var_60_4) / var_60_5)
				arg_57_1.mask_.color = var_60_6
			end

			if arg_57_1.time_ >= var_60_4 + var_60_5 and arg_57_1.time_ < var_60_4 + var_60_5 + arg_60_0 then
				local var_60_7 = Color.New(0, 0, 0)

				var_60_7.a = 1
				arg_57_1.mask_.color = var_60_7
			end

			local var_60_8 = 2

			if 2 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_9 = 2

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_9 then
				local var_60_10 = Color.New(0, 0, 0)

				var_60_10.a = Mathf.Lerp(1, 0, (arg_57_1.time_ - var_60_8) / var_60_9)
				arg_57_1.mask_.color = var_60_10
			end

			if arg_57_1.time_ >= var_60_8 + var_60_9 and arg_57_1.time_ < var_60_8 + var_60_9 + arg_60_0 then
				local var_60_11 = Color.New(0, 0, 0)

				arg_57_1.mask_.enabled = false
				var_60_11.a = 0
				arg_57_1.mask_.color = var_60_11
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				if arg_57_1.var_.effectSA0104shuidi1 then
					Object.Destroy(arg_57_1.var_.effectSA0104shuidi1)

					arg_57_1.var_.effectSA0104shuidi1 = nil
				end
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_13 = 3.4
			local var_60_14 = 0.6

			if 3.4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_15 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_15:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_16 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(112101014).content)

				arg_57_1.text_.text = var_60_16

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_18 = 24 <= 0 and var_60_14 or var_60_14 * (utf8.len(var_60_16) / 24)

				if (24 <= 0 and var_60_14 or var_60_14 * (utf8.len(var_60_16) / 24)) > 0 and var_60_14 < var_60_18 then
					arg_57_1.talkMaxDuration = var_60_18
					var_60_13 = var_60_13 + 0.3

					if var_60_18 + var_60_13 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_18 + var_60_13
					end
				end

				arg_57_1.text_.text = var_60_16
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_19 = var_60_13 + 0.3
			local var_60_20 = math.max(var_60_14, arg_57_1.talkMaxDuration)

			if var_60_13 + 0.3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_19 + var_60_20 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_19) / var_60_20

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_19 + var_60_20 and arg_57_1.time_ < var_60_19 + var_60_20 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play112101015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 112101015
		arg_63_1.duration_ = 5.7

		local var_63_0 = {
			ja = 5.6,
			ko = 3.5,
			zh = 5.7,
			en = 3.833
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
				arg_63_0:Play112101016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if arg_63_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_66_0 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_63_1.stage_.transform)

				var_66_0.name = "1081ui_story"
				var_66_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.actors_["1081ui_story"] = var_66_0

				local var_66_1 = var_66_0:GetComponentInChildren(typeof(CharacterEffect))

				var_66_1.enabled = true

				local var_66_2 = GameObjectTools.GetOrAddComponent(var_66_0, typeof(DynamicBoneHelper))

				if var_66_2 then
					var_66_2:EnableDynamicBone(false)
				end

				arg_63_1:ShowWeapon(var_66_1.transform, false)

				arg_63_1.var_["1081ui_story" .. "Animator"] = var_66_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_63_1.var_["1081ui_story" .. "Animator"].applyRootMotion = true
				arg_63_1.var_["1081ui_story" .. "LipSync"] = var_66_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_66_3 = arg_63_1.actors_["1081ui_story"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1081ui_story = var_66_3.localPosition
			end

			local var_66_4 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				var_66_3.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_63_1.time_ - 0) / var_66_4)
				var_66_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_3.position).x, (manager.ui.mainCamera.transform.position - var_66_3.position).y, (manager.ui.mainCamera.transform.position - var_66_3.position).z)
				var_66_3.localEulerAngles.z = 0
				var_66_3.localEulerAngles.x = 0
				var_66_3.localEulerAngles = var_66_3.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				var_66_3.localPosition = Vector3.New(0, -0.92, -5.8)
				var_66_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_3.position).x, (manager.ui.mainCamera.transform.position - var_66_3.position).y, (manager.ui.mainCamera.transform.position - var_66_3.position).z)
				var_66_3.localEulerAngles.z = 0
				var_66_3.localEulerAngles.x = 0
				var_66_3.localEulerAngles = var_66_3.localEulerAngles
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_66_5 = arg_63_1.actors_["1081ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.characterEffect1081ui_story == nil then
				arg_63_1.var_.characterEffect1081ui_story = var_66_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_6 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_6 and not isNil(var_66_5) then
				if arg_63_1.var_.characterEffect1081ui_story and not isNil(var_66_5) then
					arg_63_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_6 and arg_63_1.time_ < 0 + var_66_6 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.characterEffect1081ui_story then
				arg_63_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_66_8 = 0
			local var_66_9 = 0.5

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_10 = arg_63_1:GetWordFromCfg(112101015)
				local var_66_11 = arg_63_1:FormatText(var_66_10.content)

				arg_63_1.text_.text = var_66_11

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_13 = 20 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 20)

				if (20 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 20)) > 0 and var_66_9 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_8
					end
				end

				arg_63_1.text_.text = var_66_11
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112101", "112101015", "story_v_out_112101.awb") ~= 0 then
					local var_66_14 = manager.audio:GetVoiceLength("story_v_out_112101", "112101015", "story_v_out_112101.awb") / 1000

					if var_66_14 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_14 + var_66_8
					end

					if var_66_10.prefab_name ~= "" and arg_63_1.actors_[var_66_10.prefab_name] ~= nil then
						local var_66_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_10.prefab_name].transform, "story_v_out_112101", "112101015", "story_v_out_112101.awb")

						arg_63_1:RecordAudio("112101015", var_66_15)
						arg_63_1:RecordAudio("112101015", var_66_15)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_112101", "112101015", "story_v_out_112101.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_112101", "112101015", "story_v_out_112101.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_16 = math.max(var_66_9, arg_63_1.talkMaxDuration)

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_16 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_8) / var_66_16

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_8 + var_66_16 and arg_63_1.time_ < var_66_8 + var_66_16 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play112101016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 112101016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play112101017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1081ui_story"]) and arg_67_1.var_.characterEffect1081ui_story == nil then
				arg_67_1.var_.characterEffect1081ui_story = arg_67_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1081ui_story"]) then
				if arg_67_1.var_.characterEffect1081ui_story and not isNil(arg_67_1.actors_["1081ui_story"]) then
					arg_67_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1081ui_story"]) and arg_67_1.var_.characterEffect1081ui_story then
				arg_67_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_70_1 = 0
			local var_70_2 = 0.8

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(112101016).content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 32 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 32)

				if (32 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 32)) > 0 and var_70_2 < var_70_5 then
					arg_67_1.talkMaxDuration = var_70_5

					if var_70_5 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_6 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_6 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_6

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_6 and arg_67_1.time_ < var_70_1 + var_70_6 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play112101017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 112101017
		arg_71_1.duration_ = 8.07

		local var_71_0 = {
			ja = 6.833,
			ko = 8.066,
			zh = 5.366,
			en = 6.866
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
			arg_71_1.auto_ = false
		end

		function arg_71_1.playNext_(arg_73_0)
			arg_71_1.onStoryFinished_()
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_74_0 = arg_71_1.actors_["1081ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1081ui_story == nil then
				arg_71_1.var_.characterEffect1081ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_1 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 and not isNil(var_74_0) then
				if arg_71_1.var_.characterEffect1081ui_story and not isNil(var_74_0) then
					arg_71_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1081ui_story then
				arg_71_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_74_3 = 0
			local var_74_4 = 0.75

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_3 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_5 = arg_71_1:GetWordFromCfg(112101017)
				local var_74_6 = arg_71_1:FormatText(var_74_5.content)

				arg_71_1.text_.text = var_74_6

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_8 = 30 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_6) / 30)

				if (30 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_6) / 30)) > 0 and var_74_4 < var_74_8 then
					arg_71_1.talkMaxDuration = var_74_8

					if var_74_8 + var_74_3 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_3
					end
				end

				arg_71_1.text_.text = var_74_6
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112101", "112101017", "story_v_out_112101.awb") ~= 0 then
					local var_74_9 = manager.audio:GetVoiceLength("story_v_out_112101", "112101017", "story_v_out_112101.awb") / 1000

					if var_74_9 + var_74_3 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_3
					end

					if var_74_5.prefab_name ~= "" and arg_71_1.actors_[var_74_5.prefab_name] ~= nil then
						local var_74_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_5.prefab_name].transform, "story_v_out_112101", "112101017", "story_v_out_112101.awb")

						arg_71_1:RecordAudio("112101017", var_74_10)
						arg_71_1:RecordAudio("112101017", var_74_10)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_112101", "112101017", "story_v_out_112101.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_112101", "112101017", "story_v_out_112101.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_11 = math.max(var_74_4, arg_71_1.talkMaxDuration)

			if var_74_3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_3 + var_74_11 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_3) / var_74_11

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_3 + var_74_11 and arg_71_1.time_ < var_74_3 + var_74_11 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/SA0104",
		"TextureConfig/Background/H04"
	},
	voices = {
		"story_v_out_112101.awb"
	}
}
