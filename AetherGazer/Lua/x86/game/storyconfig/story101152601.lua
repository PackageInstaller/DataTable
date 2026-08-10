return {
	Play115261001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115261001
		arg_1_1.duration_ = 6.43

		local var_1_0 = {
			ja = 5.1,
			ko = 6.433,
			zh = 5.633,
			en = 5.933
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
				arg_1_0:Play115261002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

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

			local var_4_6 = "ST22"

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
				local var_4_11 = arg_1_1.bgs_.ST22

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
					if iter_4_0 ~= "ST22" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_22 = 0
			local var_4_23 = 0.6

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

			local var_4_28 = 1.10700136857828
			local var_4_29 = 1.89299863142172

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess")

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
			local var_4_35 = 0.666666666666667

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

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[306].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_38 = arg_1_1:GetWordFromCfg(115261001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261001", "story_v_out_115261.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_115261", "115261001", "story_v_out_115261.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_115261", "115261001", "story_v_out_115261.awb")

						arg_1_1:RecordAudio("115261001", var_4_44)
						arg_1_1:RecordAudio("115261001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_115261", "115261001", "story_v_out_115261.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_115261", "115261001", "story_v_out_115261.awb")
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
	Play115261002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115261002
		arg_9_1.duration_ = 5.17

		local var_9_0 = {
			ja = 3.4,
			ko = 5.166,
			zh = 3.833,
			en = 3.6
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
				arg_9_0:Play115261003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.666666666666667

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[306].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(115261002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261002", "story_v_out_115261.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261002", "story_v_out_115261.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_115261", "115261002", "story_v_out_115261.awb")

						arg_9_1:RecordAudio("115261002", var_12_9)
						arg_9_1:RecordAudio("115261002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_115261", "115261002", "story_v_out_115261.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_115261", "115261002", "story_v_out_115261.awb")
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
	Play115261003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115261003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play115261004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 3

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

				local var_16_2 = arg_13_1:GetWordFromCfg(115261003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 56
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
	Play115261004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115261004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play115261005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 2.93333333333333

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

				local var_20_2 = arg_17_1:GetWordFromCfg(115261004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 53
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
	Play115261005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 115261005
		arg_21_1.duration_ = 2.93

		local var_21_0 = {
			ja = 1.499999999999,
			ko = 2.933,
			zh = 1.5,
			en = 1.6
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
				arg_21_0:Play115261006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.366666666666667

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[307].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(115261005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261005", "story_v_out_115261.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261005", "story_v_out_115261.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_115261", "115261005", "story_v_out_115261.awb")

						arg_21_1:RecordAudio("115261005", var_24_9)
						arg_21_1:RecordAudio("115261005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_115261", "115261005", "story_v_out_115261.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_115261", "115261005", "story_v_out_115261.awb")
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
	Play115261006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 115261006
		arg_25_1.duration_ = 3

		local var_25_0 = {
			ja = 2.499999999999,
			ko = 3,
			zh = 2.499999999999,
			en = 2.499999999999
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
				arg_25_0:Play115261007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 2

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[308].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(115261006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 11
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261006", "story_v_out_115261.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261006", "story_v_out_115261.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_115261", "115261006", "story_v_out_115261.awb")

						arg_25_1:RecordAudio("115261006", var_28_9)
						arg_25_1:RecordAudio("115261006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_115261", "115261006", "story_v_out_115261.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_115261", "115261006", "story_v_out_115261.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play115261007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 115261007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play115261008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 2.66666666666667

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(115261007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 47
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play115261008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 115261008
		arg_33_1.duration_ = 1.5

		local var_33_0 = {
			ja = 1.499999999999,
			ko = 1.5,
			zh = 1.499999999999,
			en = 1.499999999999
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
				arg_33_0:Play115261009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.333333333333333

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[205].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(115261008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261008", "story_v_out_115261.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261008", "story_v_out_115261.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_115261", "115261008", "story_v_out_115261.awb")

						arg_33_1:RecordAudio("115261008", var_36_9)
						arg_33_1:RecordAudio("115261008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_115261", "115261008", "story_v_out_115261.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_115261", "115261008", "story_v_out_115261.awb")
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
	Play115261009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 115261009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play115261010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 2.2

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_2 = arg_37_1:GetWordFromCfg(115261009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 39
				local var_40_5 = utf8.len(var_40_3)
				local var_40_6 = var_40_4 <= 0 and var_40_1 or var_40_1 * (var_40_5 / var_40_4)

				if var_40_6 > 0 and var_40_1 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_7 and arg_37_1.time_ < var_40_0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play115261010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 115261010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play115261011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 2.03333333333333

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(115261010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 46
				local var_44_5 = utf8.len(var_44_3)
				local var_44_6 = var_44_4 <= 0 and var_44_1 or var_44_1 * (var_44_5 / var_44_4)

				if var_44_6 > 0 and var_44_1 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_7 and arg_41_1.time_ < var_44_0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play115261011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 115261011
		arg_45_1.duration_ = 5.57

		local var_45_0 = {
			ja = 5.566,
			ko = 4.633,
			zh = 5.366,
			en = 4.466
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
				arg_45_0:Play115261012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.33333333333333

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[307].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(115261011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261011", "story_v_out_115261.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261011", "story_v_out_115261.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_115261", "115261011", "story_v_out_115261.awb")

						arg_45_1:RecordAudio("115261011", var_48_9)
						arg_45_1:RecordAudio("115261011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_115261", "115261011", "story_v_out_115261.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_115261", "115261011", "story_v_out_115261.awb")
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
	Play115261012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 115261012
		arg_49_1.duration_ = 9.03

		local var_49_0 = {
			ja = 3.9,
			ko = 9.033,
			zh = 6.533,
			en = 8.5
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
				arg_49_0:Play115261013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 1.93333333333333

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[308].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(115261012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 36
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261012", "story_v_out_115261.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261012", "story_v_out_115261.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_115261", "115261012", "story_v_out_115261.awb")

						arg_49_1:RecordAudio("115261012", var_52_9)
						arg_49_1:RecordAudio("115261012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_115261", "115261012", "story_v_out_115261.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_115261", "115261012", "story_v_out_115261.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play115261013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 115261013
		arg_53_1.duration_ = 10.37

		local var_53_0 = {
			ja = 10.366,
			ko = 3.933,
			zh = 3.333,
			en = 3.766
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
				arg_53_0:Play115261014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.16666666666667

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[308].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(115261013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 18
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261013", "story_v_out_115261.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261013", "story_v_out_115261.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_115261", "115261013", "story_v_out_115261.awb")

						arg_53_1:RecordAudio("115261013", var_56_9)
						arg_53_1:RecordAudio("115261013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_115261", "115261013", "story_v_out_115261.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_115261", "115261013", "story_v_out_115261.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play115261014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 115261014
		arg_57_1.duration_ = 9.67

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play115261015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 2.66666666666667

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				local var_60_1 = manager.ui.mainCamera.transform.localPosition
				local var_60_2 = Vector3.New(0, 0, 10) + Vector3.New(var_60_1.x, var_60_1.y, 0)
				local var_60_3 = arg_57_1.bgs_.ST22

				var_60_3.transform.localPosition = var_60_2
				var_60_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_60_4 = var_60_3:GetComponent("SpriteRenderer")

				if var_60_4 and var_60_4.sprite then
					local var_60_5 = (var_60_3.transform.localPosition - var_60_1).z
					local var_60_6 = manager.ui.mainCameraCom_
					local var_60_7 = 2 * var_60_5 * Mathf.Tan(var_60_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_60_8 = var_60_7 * var_60_6.aspect
					local var_60_9 = var_60_4.sprite.bounds.size.x
					local var_60_10 = var_60_4.sprite.bounds.size.y
					local var_60_11 = var_60_8 / var_60_9
					local var_60_12 = var_60_7 / var_60_10
					local var_60_13 = var_60_12 < var_60_11 and var_60_11 or var_60_12

					var_60_3.transform.localScale = Vector3.New(var_60_13, var_60_13, 0)
				end

				for iter_60_0, iter_60_1 in pairs(arg_57_1.bgs_) do
					if iter_60_0 ~= "ST22" then
						iter_60_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_15 = 2

			if var_60_14 <= arg_57_1.time_ and arg_57_1.time_ < var_60_14 + var_60_15 then
				local var_60_16 = (arg_57_1.time_ - var_60_14) / var_60_15
				local var_60_17 = Color.New(0, 0, 0)

				var_60_17.a = Mathf.Lerp(0, 1, var_60_16)
				arg_57_1.mask_.color = var_60_17
			end

			if arg_57_1.time_ >= var_60_14 + var_60_15 and arg_57_1.time_ < var_60_14 + var_60_15 + arg_60_0 then
				local var_60_18 = Color.New(0, 0, 0)

				var_60_18.a = 1
				arg_57_1.mask_.color = var_60_18
			end

			local var_60_19 = 2.66666666666667

			if var_60_19 < arg_57_1.time_ and arg_57_1.time_ <= var_60_19 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_20 = 2

			if var_60_19 <= arg_57_1.time_ and arg_57_1.time_ < var_60_19 + var_60_20 then
				local var_60_21 = (arg_57_1.time_ - var_60_19) / var_60_20
				local var_60_22 = Color.New(0, 0, 0)

				var_60_22.a = Mathf.Lerp(1, 0, var_60_21)
				arg_57_1.mask_.color = var_60_22
			end

			if arg_57_1.time_ >= var_60_19 + var_60_20 and arg_57_1.time_ < var_60_19 + var_60_20 + arg_60_0 then
				local var_60_23 = Color.New(0, 0, 0)
				local var_60_24 = 0

				arg_57_1.mask_.enabled = false
				var_60_23.a = var_60_24
				arg_57_1.mask_.color = var_60_23
			end

			local var_60_25 = 2

			arg_57_1.isInRecall_ = false

			if var_60_25 < arg_57_1.time_ and arg_57_1.time_ <= var_60_25 + arg_60_0 then
				arg_57_1.screenFilterGo_:SetActive(true)

				arg_57_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_60_2, iter_60_3 in pairs(arg_57_1.actors_) do
					local var_60_26 = iter_60_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_60_4, iter_60_5 in ipairs(var_60_26) do
						if iter_60_5.color.r > 0.51 then
							iter_60_5.color = Color.New(1, 1, 1)
						else
							iter_60_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_60_27 = 0.766666666666667

			if var_60_25 <= arg_57_1.time_ and arg_57_1.time_ < var_60_25 + var_60_27 then
				local var_60_28 = (arg_57_1.time_ - var_60_25) / var_60_27

				arg_57_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_60_28)
			end

			if arg_57_1.time_ >= var_60_25 + var_60_27 and arg_57_1.time_ < var_60_25 + var_60_27 + arg_60_0 then
				arg_57_1.screenFilterEffect_.weight = 1
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_29 = 4.66666666666667
			local var_60_30 = 0.466666666666667

			if var_60_29 < arg_57_1.time_ and arg_57_1.time_ <= var_60_29 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_31 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_31:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_32 = arg_57_1:GetWordFromCfg(115261014)
				local var_60_33 = arg_57_1:FormatText(var_60_32.content)

				arg_57_1.text_.text = var_60_33

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_34 = 2
				local var_60_35 = utf8.len(var_60_33)
				local var_60_36 = var_60_34 <= 0 and var_60_30 or var_60_30 * (var_60_35 / var_60_34)

				if var_60_36 > 0 and var_60_30 < var_60_36 then
					arg_57_1.talkMaxDuration = var_60_36
					var_60_29 = var_60_29 + 0.3

					if var_60_36 + var_60_29 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_36 + var_60_29
					end
				end

				arg_57_1.text_.text = var_60_33
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_37 = var_60_29 + 0.3
			local var_60_38 = math.max(var_60_30, arg_57_1.talkMaxDuration)

			if var_60_37 <= arg_57_1.time_ and arg_57_1.time_ < var_60_37 + var_60_38 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_37) / var_60_38

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_37 + var_60_38 and arg_57_1.time_ < var_60_37 + var_60_38 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play115261015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 115261015
		arg_63_1.duration_ = 12.03

		local var_63_0 = {
			ja = 8.3,
			ko = 12.033,
			zh = 10.1,
			en = 8.333
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
				arg_63_0:Play115261016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 1.125

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[205].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(115261015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 45
				local var_66_6 = utf8.len(var_66_4)
				local var_66_7 = var_66_5 <= 0 and var_66_1 or var_66_1 * (var_66_6 / var_66_5)

				if var_66_7 > 0 and var_66_1 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261015", "story_v_out_115261.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261015", "story_v_out_115261.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_115261", "115261015", "story_v_out_115261.awb")

						arg_63_1:RecordAudio("115261015", var_66_9)
						arg_63_1:RecordAudio("115261015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_115261", "115261015", "story_v_out_115261.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_115261", "115261015", "story_v_out_115261.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_10 and arg_63_1.time_ < var_66_0 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play115261016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 115261016
		arg_67_1.duration_ = 9.4

		local var_67_0 = {
			ja = 4.266,
			ko = 7.266,
			zh = 7.4,
			en = 9.4
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
				arg_67_0:Play115261017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 1.5

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[205].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(115261016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 28
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261016", "story_v_out_115261.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261016", "story_v_out_115261.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_115261", "115261016", "story_v_out_115261.awb")

						arg_67_1:RecordAudio("115261016", var_70_9)
						arg_67_1:RecordAudio("115261016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_115261", "115261016", "story_v_out_115261.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_115261", "115261016", "story_v_out_115261.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play115261017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 115261017
		arg_71_1.duration_ = 18.37

		local var_71_0 = {
			ja = 10.666,
			ko = 18.366,
			zh = 13.566,
			en = 14.2
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
				arg_71_0:Play115261018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = "1038"

			if arg_71_1.actors_[var_74_0] == nil then
				local var_74_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1038")

				if not isNil(var_74_1) then
					local var_74_2 = Object.Instantiate(var_74_1, arg_71_1.canvasGo_.transform)

					var_74_2.transform:SetSiblingIndex(1)

					var_74_2.name = var_74_0
					var_74_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_71_1.actors_[var_74_0] = var_74_2

					local var_74_3 = var_74_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_71_1.isInRecall_ then
						for iter_74_0, iter_74_1 in ipairs(var_74_3) do
							iter_74_1.color = arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_74_4 = arg_71_1.actors_["1038"].transform
			local var_74_5 = 0

			if var_74_5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1.var_.moveOldPos1038 = var_74_4.localPosition
				var_74_4.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1038", 3)

				local var_74_6 = var_74_4.childCount

				for iter_74_2 = 0, var_74_6 - 1 do
					local var_74_7 = var_74_4:GetChild(iter_74_2)

					if var_74_7.name == "split_9" or not string.find(var_74_7.name, "split") then
						var_74_7.gameObject:SetActive(true)
					else
						var_74_7.gameObject:SetActive(false)
					end
				end
			end

			local var_74_8 = 0.001

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_8 then
				local var_74_9 = (arg_71_1.time_ - var_74_5) / var_74_8
				local var_74_10 = Vector3.New(0, -400, 0)

				var_74_4.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1038, var_74_10, var_74_9)
			end

			if arg_71_1.time_ >= var_74_5 + var_74_8 and arg_71_1.time_ < var_74_5 + var_74_8 + arg_74_0 then
				var_74_4.localPosition = Vector3.New(0, -400, 0)
			end

			local var_74_11 = arg_71_1.actors_["1038"]
			local var_74_12 = 0

			if var_74_12 < arg_71_1.time_ and arg_71_1.time_ <= var_74_12 + arg_74_0 and not isNil(var_74_11) and arg_71_1.var_.actorSpriteComps1038 == nil then
				arg_71_1.var_.actorSpriteComps1038 = var_74_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_13 = 0.2

			if var_74_12 <= arg_71_1.time_ and arg_71_1.time_ < var_74_12 + var_74_13 and not isNil(var_74_11) then
				local var_74_14 = (arg_71_1.time_ - var_74_12) / var_74_13

				if arg_71_1.var_.actorSpriteComps1038 then
					for iter_74_3, iter_74_4 in pairs(arg_71_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_74_4 then
							if arg_71_1.isInRecall_ then
								local var_74_15 = Mathf.Lerp(iter_74_4.color.r, arg_71_1.hightColor1.r, var_74_14)
								local var_74_16 = Mathf.Lerp(iter_74_4.color.g, arg_71_1.hightColor1.g, var_74_14)
								local var_74_17 = Mathf.Lerp(iter_74_4.color.b, arg_71_1.hightColor1.b, var_74_14)

								iter_74_4.color = Color.New(var_74_15, var_74_16, var_74_17)
							else
								local var_74_18 = Mathf.Lerp(iter_74_4.color.r, 1, var_74_14)

								iter_74_4.color = Color.New(var_74_18, var_74_18, var_74_18)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= var_74_12 + var_74_13 and arg_71_1.time_ < var_74_12 + var_74_13 + arg_74_0 and not isNil(var_74_11) and arg_71_1.var_.actorSpriteComps1038 then
				for iter_74_5, iter_74_6 in pairs(arg_71_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_74_6 then
						if arg_71_1.isInRecall_ then
							iter_74_6.color = arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_74_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_71_1.var_.actorSpriteComps1038 = nil
			end

			local var_74_19 = arg_71_1.actors_["1038"]
			local var_74_20 = 0

			if var_74_20 < arg_71_1.time_ and arg_71_1.time_ <= var_74_20 + arg_74_0 then
				local var_74_21 = var_74_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_74_21 then
					arg_71_1.var_.alphaOldValue1038 = var_74_21.alpha
					arg_71_1.var_.characterEffect1038 = var_74_21
				end

				arg_71_1.var_.alphaOldValue1038 = 0
			end

			local var_74_22 = 0.5

			if var_74_20 <= arg_71_1.time_ and arg_71_1.time_ < var_74_20 + var_74_22 then
				local var_74_23 = (arg_71_1.time_ - var_74_20) / var_74_22
				local var_74_24 = Mathf.Lerp(arg_71_1.var_.alphaOldValue1038, 1, var_74_23)

				if arg_71_1.var_.characterEffect1038 then
					arg_71_1.var_.characterEffect1038.alpha = var_74_24
				end
			end

			if arg_71_1.time_ >= var_74_20 + var_74_22 and arg_71_1.time_ < var_74_20 + var_74_22 + arg_74_0 and arg_71_1.var_.characterEffect1038 then
				arg_71_1.var_.characterEffect1038.alpha = 1
			end

			local var_74_25 = 0
			local var_74_26 = 2.5

			if var_74_25 < arg_71_1.time_ and arg_71_1.time_ <= var_74_25 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_27 = arg_71_1:FormatText(StoryNameCfg[94].name)

				arg_71_1.leftNameTxt_.text = var_74_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_28 = arg_71_1:GetWordFromCfg(115261017)
				local var_74_29 = arg_71_1:FormatText(var_74_28.content)

				arg_71_1.text_.text = var_74_29

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_30 = 54
				local var_74_31 = utf8.len(var_74_29)
				local var_74_32 = var_74_30 <= 0 and var_74_26 or var_74_26 * (var_74_31 / var_74_30)

				if var_74_32 > 0 and var_74_26 < var_74_32 then
					arg_71_1.talkMaxDuration = var_74_32

					if var_74_32 + var_74_25 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_32 + var_74_25
					end
				end

				arg_71_1.text_.text = var_74_29
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261017", "story_v_out_115261.awb") ~= 0 then
					local var_74_33 = manager.audio:GetVoiceLength("story_v_out_115261", "115261017", "story_v_out_115261.awb") / 1000

					if var_74_33 + var_74_25 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_33 + var_74_25
					end

					if var_74_28.prefab_name ~= "" and arg_71_1.actors_[var_74_28.prefab_name] ~= nil then
						local var_74_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_28.prefab_name].transform, "story_v_out_115261", "115261017", "story_v_out_115261.awb")

						arg_71_1:RecordAudio("115261017", var_74_34)
						arg_71_1:RecordAudio("115261017", var_74_34)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_115261", "115261017", "story_v_out_115261.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_115261", "115261017", "story_v_out_115261.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_35 = math.max(var_74_26, arg_71_1.talkMaxDuration)

			if var_74_25 <= arg_71_1.time_ and arg_71_1.time_ < var_74_25 + var_74_35 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_25) / var_74_35

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_25 + var_74_35 and arg_71_1.time_ < var_74_25 + var_74_35 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play115261018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 115261018
		arg_75_1.duration_ = 9.47

		local var_75_0 = {
			ja = 4.033,
			ko = 9.466,
			zh = 7.066,
			en = 7.266
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
				arg_75_0:Play115261019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 1.33333333333333

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[94].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(115261018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 31
				local var_78_6 = utf8.len(var_78_4)
				local var_78_7 = var_78_5 <= 0 and var_78_1 or var_78_1 * (var_78_6 / var_78_5)

				if var_78_7 > 0 and var_78_1 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261018", "story_v_out_115261.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261018", "story_v_out_115261.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_115261", "115261018", "story_v_out_115261.awb")

						arg_75_1:RecordAudio("115261018", var_78_9)
						arg_75_1:RecordAudio("115261018", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_115261", "115261018", "story_v_out_115261.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_115261", "115261018", "story_v_out_115261.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_10 and arg_75_1.time_ < var_78_0 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play115261019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 115261019
		arg_79_1.duration_ = 12.9

		local var_79_0 = {
			ja = 9.6,
			ko = 12.9,
			zh = 9.3,
			en = 10.466
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
				arg_79_0:Play115261020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1038"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps1038 == nil then
				arg_79_1.var_.actorSpriteComps1038 = var_82_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_2 = 0.2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.actorSpriteComps1038 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								local var_82_4 = Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor2.r, var_82_3)
								local var_82_5 = Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor2.g, var_82_3)
								local var_82_6 = Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor2.b, var_82_3)

								iter_82_1.color = Color.New(var_82_4, var_82_5, var_82_6)
							else
								local var_82_7 = Mathf.Lerp(iter_82_1.color.r, 0.5, var_82_3)

								iter_82_1.color = Color.New(var_82_7, var_82_7, var_82_7)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps1038 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_82_3 then
						if arg_79_1.isInRecall_ then
							iter_82_3.color = arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_82_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps1038 = nil
			end

			local var_82_8 = 0
			local var_82_9 = 1.66666666666667

			if var_82_8 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_10 = arg_79_1:FormatText(StoryNameCfg[205].name)

				arg_79_1.leftNameTxt_.text = var_82_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_11 = arg_79_1:GetWordFromCfg(115261019)
				local var_82_12 = arg_79_1:FormatText(var_82_11.content)

				arg_79_1.text_.text = var_82_12

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_13 = 36
				local var_82_14 = utf8.len(var_82_12)
				local var_82_15 = var_82_13 <= 0 and var_82_9 or var_82_9 * (var_82_14 / var_82_13)

				if var_82_15 > 0 and var_82_9 < var_82_15 then
					arg_79_1.talkMaxDuration = var_82_15

					if var_82_15 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_15 + var_82_8
					end
				end

				arg_79_1.text_.text = var_82_12
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261019", "story_v_out_115261.awb") ~= 0 then
					local var_82_16 = manager.audio:GetVoiceLength("story_v_out_115261", "115261019", "story_v_out_115261.awb") / 1000

					if var_82_16 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_16 + var_82_8
					end

					if var_82_11.prefab_name ~= "" and arg_79_1.actors_[var_82_11.prefab_name] ~= nil then
						local var_82_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_11.prefab_name].transform, "story_v_out_115261", "115261019", "story_v_out_115261.awb")

						arg_79_1:RecordAudio("115261019", var_82_17)
						arg_79_1:RecordAudio("115261019", var_82_17)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_115261", "115261019", "story_v_out_115261.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_115261", "115261019", "story_v_out_115261.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_18 = math.max(var_82_9, arg_79_1.talkMaxDuration)

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_18 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_8) / var_82_18

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_8 + var_82_18 and arg_79_1.time_ < var_82_8 + var_82_18 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play115261020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 115261020
		arg_83_1.duration_ = 7.87

		local var_83_0 = {
			ja = 7.866,
			ko = 6.933,
			zh = 5.166,
			en = 5.566
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
				arg_83_0:Play115261021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 1.16666666666667

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[205].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(115261020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 20
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261020", "story_v_out_115261.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261020", "story_v_out_115261.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_115261", "115261020", "story_v_out_115261.awb")

						arg_83_1:RecordAudio("115261020", var_86_9)
						arg_83_1:RecordAudio("115261020", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_115261", "115261020", "story_v_out_115261.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_115261", "115261020", "story_v_out_115261.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_10 and arg_83_1.time_ < var_86_0 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play115261021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 115261021
		arg_87_1.duration_ = 2.63

		local var_87_0 = {
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 2.633,
			en = 1.2
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
				arg_87_0:Play115261022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1038"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.actorSpriteComps1038 == nil then
				arg_87_1.var_.actorSpriteComps1038 = var_90_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_2 = 0.2

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.actorSpriteComps1038 then
					for iter_90_0, iter_90_1 in pairs(arg_87_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_90_1 then
							if arg_87_1.isInRecall_ then
								local var_90_4 = Mathf.Lerp(iter_90_1.color.r, arg_87_1.hightColor1.r, var_90_3)
								local var_90_5 = Mathf.Lerp(iter_90_1.color.g, arg_87_1.hightColor1.g, var_90_3)
								local var_90_6 = Mathf.Lerp(iter_90_1.color.b, arg_87_1.hightColor1.b, var_90_3)

								iter_90_1.color = Color.New(var_90_4, var_90_5, var_90_6)
							else
								local var_90_7 = Mathf.Lerp(iter_90_1.color.r, 1, var_90_3)

								iter_90_1.color = Color.New(var_90_7, var_90_7, var_90_7)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.actorSpriteComps1038 then
				for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_90_3 then
						if arg_87_1.isInRecall_ then
							iter_90_3.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_90_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps1038 = nil
			end

			local var_90_8 = 0
			local var_90_9 = 0.333333333333333

			if var_90_8 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_10 = arg_87_1:FormatText(StoryNameCfg[94].name)

				arg_87_1.leftNameTxt_.text = var_90_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_11 = arg_87_1:GetWordFromCfg(115261021)
				local var_90_12 = arg_87_1:FormatText(var_90_11.content)

				arg_87_1.text_.text = var_90_12

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_13 = 2
				local var_90_14 = utf8.len(var_90_12)
				local var_90_15 = var_90_13 <= 0 and var_90_9 or var_90_9 * (var_90_14 / var_90_13)

				if var_90_15 > 0 and var_90_9 < var_90_15 then
					arg_87_1.talkMaxDuration = var_90_15

					if var_90_15 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_15 + var_90_8
					end
				end

				arg_87_1.text_.text = var_90_12
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261021", "story_v_out_115261.awb") ~= 0 then
					local var_90_16 = manager.audio:GetVoiceLength("story_v_out_115261", "115261021", "story_v_out_115261.awb") / 1000

					if var_90_16 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_16 + var_90_8
					end

					if var_90_11.prefab_name ~= "" and arg_87_1.actors_[var_90_11.prefab_name] ~= nil then
						local var_90_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_11.prefab_name].transform, "story_v_out_115261", "115261021", "story_v_out_115261.awb")

						arg_87_1:RecordAudio("115261021", var_90_17)
						arg_87_1:RecordAudio("115261021", var_90_17)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_115261", "115261021", "story_v_out_115261.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_115261", "115261021", "story_v_out_115261.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_18 = math.max(var_90_9, arg_87_1.talkMaxDuration)

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_18 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_8) / var_90_18

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_8 + var_90_18 and arg_87_1.time_ < var_90_8 + var_90_18 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play115261022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 115261022
		arg_91_1.duration_ = 9.6

		local var_91_0 = {
			ja = 7.1,
			ko = 9.566,
			zh = 9.6,
			en = 9.433
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play115261023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 1.5

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[94].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:GetWordFromCfg(115261022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 37
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261022", "story_v_out_115261.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261022", "story_v_out_115261.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_115261", "115261022", "story_v_out_115261.awb")

						arg_91_1:RecordAudio("115261022", var_94_9)
						arg_91_1:RecordAudio("115261022", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_115261", "115261022", "story_v_out_115261.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_115261", "115261022", "story_v_out_115261.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_10 and arg_91_1.time_ < var_94_0 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play115261023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 115261023
		arg_95_1.duration_ = 9.93

		local var_95_0 = {
			ja = 7.2,
			ko = 7.033,
			zh = 7.966,
			en = 9.933
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
				arg_95_0:Play115261024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 1.33333333333333

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[94].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:GetWordFromCfg(115261023)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 28
				local var_98_6 = utf8.len(var_98_4)
				local var_98_7 = var_98_5 <= 0 and var_98_1 or var_98_1 * (var_98_6 / var_98_5)

				if var_98_7 > 0 and var_98_1 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261023", "story_v_out_115261.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261023", "story_v_out_115261.awb") / 1000

					if var_98_8 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_0
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_115261", "115261023", "story_v_out_115261.awb")

						arg_95_1:RecordAudio("115261023", var_98_9)
						arg_95_1:RecordAudio("115261023", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_115261", "115261023", "story_v_out_115261.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_115261", "115261023", "story_v_out_115261.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_10 and arg_95_1.time_ < var_98_0 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play115261024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 115261024
		arg_99_1.duration_ = 4

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play115261025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = false

				arg_99_1:SetGaussion(false)
			end

			local var_102_1 = 2.00133333333333

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_1 then
				local var_102_2 = (arg_99_1.time_ - var_102_0) / var_102_1
				local var_102_3 = Color.New(0, 0, 0)

				var_102_3.a = Mathf.Lerp(0, 1, var_102_2)
				arg_99_1.mask_.color = var_102_3
			end

			if arg_99_1.time_ >= var_102_0 + var_102_1 and arg_99_1.time_ < var_102_0 + var_102_1 + arg_102_0 then
				local var_102_4 = Color.New(0, 0, 0)

				var_102_4.a = 1
				arg_99_1.mask_.color = var_102_4
			end

			local var_102_5 = 2.00133333333333

			if var_102_5 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = false

				arg_99_1:SetGaussion(false)
			end

			local var_102_6 = 0.165333333333335

			if var_102_5 <= arg_99_1.time_ and arg_99_1.time_ < var_102_5 + var_102_6 then
				local var_102_7 = (arg_99_1.time_ - var_102_5) / var_102_6
				local var_102_8 = Color.New(0, 0, 0)

				var_102_8.a = Mathf.Lerp(1, 0, var_102_7)
				arg_99_1.mask_.color = var_102_8
			end

			if arg_99_1.time_ >= var_102_5 + var_102_6 and arg_99_1.time_ < var_102_5 + var_102_6 + arg_102_0 then
				local var_102_9 = Color.New(0, 0, 0)
				local var_102_10 = 0

				arg_99_1.mask_.enabled = false
				var_102_9.a = var_102_10
				arg_99_1.mask_.color = var_102_9
			end

			local var_102_11 = 2

			if var_102_11 < arg_99_1.time_ and arg_99_1.time_ <= var_102_11 + arg_102_0 then
				arg_99_1.fswbg_:SetActive(true)
				arg_99_1.dialog_:SetActive(false)

				arg_99_1.fswtw_.percent = 0

				local var_102_12 = arg_99_1:GetWordFromCfg(115261024)
				local var_102_13 = arg_99_1:FormatText(var_102_12.content)

				arg_99_1.fswt_.text = var_102_13

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.fswt_)

				arg_99_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_99_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_99_1.fswtw_:SetDirty()

				arg_99_1.typewritterCharCountI18N = 0

				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_99_1:ShowNextGo(false)
			end

			local var_102_14 = 2.01666666666667

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				arg_99_1.var_.oldValueTypewriter = arg_99_1.fswtw_.percent

				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_99_1:ShowNextGo(false)
			end

			local var_102_15 = 15
			local var_102_16 = 1
			local var_102_17 = arg_99_1:GetWordFromCfg(115261024)
			local var_102_18 = arg_99_1:FormatText(var_102_17.content)
			local var_102_19, var_102_20 = arg_99_1:GetPercentByPara(var_102_18, 1)

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				local var_102_21 = var_102_15 <= 0 and var_102_16 or var_102_16 * ((var_102_20 - arg_99_1.typewritterCharCountI18N) / var_102_15)

				if var_102_21 > 0 and var_102_16 < var_102_21 then
					arg_99_1.talkMaxDuration = var_102_21

					if var_102_21 + var_102_14 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_21 + var_102_14
					end
				end
			end

			local var_102_22 = 1
			local var_102_23 = math.max(var_102_22, arg_99_1.talkMaxDuration)

			if var_102_14 <= arg_99_1.time_ and arg_99_1.time_ < var_102_14 + var_102_23 then
				local var_102_24 = (arg_99_1.time_ - var_102_14) / var_102_23

				arg_99_1.fswtw_.percent = Mathf.Lerp(arg_99_1.var_.oldValueTypewriter, var_102_19, var_102_24)
				arg_99_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_99_1.fswtw_:SetDirty()
			end

			if arg_99_1.time_ >= var_102_14 + var_102_23 and arg_99_1.time_ < var_102_14 + var_102_23 + arg_102_0 then
				arg_99_1.fswtw_.percent = var_102_19

				arg_99_1.fswtw_:SetDirty()
				arg_99_1:ShowNextGo(true)

				arg_99_1.typewritterCharCountI18N = var_102_20
			end

			local var_102_25 = 2.06666666666667

			if var_102_25 < arg_99_1.time_ and arg_99_1.time_ <= var_102_25 + arg_102_0 then
				arg_99_1.var_.oldValueTypewriter = arg_99_1.fswtw_.percent

				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_99_1:ShowNextGo(false)
			end

			local var_102_26 = 0
			local var_102_27 = 0
			local var_102_28 = arg_99_1:GetWordFromCfg(115261024)
			local var_102_29 = arg_99_1:FormatText(var_102_28.content)
			local var_102_30, var_102_31 = arg_99_1:GetPercentByPara(var_102_29, 1)

			if var_102_25 < arg_99_1.time_ and arg_99_1.time_ <= var_102_25 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				local var_102_32 = var_102_26 <= 0 and var_102_27 or var_102_27 * ((var_102_31 - arg_99_1.typewritterCharCountI18N) / var_102_26)

				if var_102_32 > 0 and var_102_27 < var_102_32 then
					arg_99_1.talkMaxDuration = var_102_32

					if var_102_32 + var_102_25 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_32 + var_102_25
					end
				end
			end

			local var_102_33 = 0
			local var_102_34 = math.max(var_102_33, arg_99_1.talkMaxDuration)

			if var_102_25 <= arg_99_1.time_ and arg_99_1.time_ < var_102_25 + var_102_34 then
				local var_102_35 = (arg_99_1.time_ - var_102_25) / var_102_34

				arg_99_1.fswtw_.percent = Mathf.Lerp(arg_99_1.var_.oldValueTypewriter, var_102_30, var_102_35)
				arg_99_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_99_1.fswtw_:SetDirty()
			end

			if arg_99_1.time_ >= var_102_25 + var_102_34 and arg_99_1.time_ < var_102_25 + var_102_34 + arg_102_0 then
				arg_99_1.fswtw_.percent = var_102_30

				arg_99_1.fswtw_:SetDirty()
				arg_99_1:ShowNextGo(true)

				arg_99_1.typewritterCharCountI18N = var_102_31
			end

			local var_102_36 = arg_99_1.actors_["1038"].transform
			local var_102_37 = 2

			if var_102_37 < arg_99_1.time_ and arg_99_1.time_ <= var_102_37 + arg_102_0 then
				arg_99_1.var_.moveOldPos1038 = var_102_36.localPosition
				var_102_36.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("1038", 7)

				local var_102_38 = var_102_36.childCount

				for iter_102_0 = 0, var_102_38 - 1 do
					local var_102_39 = var_102_36:GetChild(iter_102_0)

					if var_102_39.name == "split_9" or not string.find(var_102_39.name, "split") then
						var_102_39.gameObject:SetActive(true)
					else
						var_102_39.gameObject:SetActive(false)
					end
				end
			end

			local var_102_40 = 0.001

			if var_102_37 <= arg_99_1.time_ and arg_99_1.time_ < var_102_37 + var_102_40 then
				local var_102_41 = (arg_99_1.time_ - var_102_37) / var_102_40
				local var_102_42 = Vector3.New(0, -2000, -180)

				var_102_36.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1038, var_102_42, var_102_41)
			end

			if arg_99_1.time_ >= var_102_37 + var_102_40 and arg_99_1.time_ < var_102_37 + var_102_40 + arg_102_0 then
				var_102_36.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_102_43 = 2

			arg_99_1.isInRecall_ = false

			if var_102_43 < arg_99_1.time_ and arg_99_1.time_ <= var_102_43 + arg_102_0 then
				arg_99_1.screenFilterGo_:SetActive(false)

				for iter_102_1, iter_102_2 in pairs(arg_99_1.actors_) do
					local var_102_44 = iter_102_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_102_3, iter_102_4 in ipairs(var_102_44) do
						if iter_102_4.color.r > 0.51 then
							iter_102_4.color = Color.New(1, 1, 1)
						else
							iter_102_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_102_45 = 0.0166666666666667

			if var_102_43 <= arg_99_1.time_ and arg_99_1.time_ < var_102_43 + var_102_45 then
				local var_102_46 = (arg_99_1.time_ - var_102_43) / var_102_45

				arg_99_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_102_46)
			end

			if arg_99_1.time_ >= var_102_43 + var_102_45 and arg_99_1.time_ < var_102_43 + var_102_45 + arg_102_0 then
				arg_99_1.screenFilterEffect_.weight = 0
			end

			local var_102_47 = "STblack"

			if arg_99_1.bgs_[var_102_47] == nil then
				local var_102_48 = Object.Instantiate(arg_99_1.paintGo_)

				var_102_48:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_102_47)
				var_102_48.name = var_102_47
				var_102_48.transform.parent = arg_99_1.stage_.transform
				var_102_48.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.bgs_[var_102_47] = var_102_48
			end

			local var_102_49 = 2

			if var_102_49 < arg_99_1.time_ and arg_99_1.time_ <= var_102_49 + arg_102_0 then
				local var_102_50 = manager.ui.mainCamera.transform.localPosition
				local var_102_51 = Vector3.New(0, 0, 10) + Vector3.New(var_102_50.x, var_102_50.y, 0)
				local var_102_52 = arg_99_1.bgs_.STblack

				var_102_52.transform.localPosition = var_102_51
				var_102_52.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_53 = var_102_52:GetComponent("SpriteRenderer")

				if var_102_53 and var_102_53.sprite then
					local var_102_54 = (var_102_52.transform.localPosition - var_102_50).z
					local var_102_55 = manager.ui.mainCameraCom_
					local var_102_56 = 2 * var_102_54 * Mathf.Tan(var_102_55.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_102_57 = var_102_56 * var_102_55.aspect
					local var_102_58 = var_102_53.sprite.bounds.size.x
					local var_102_59 = var_102_53.sprite.bounds.size.y
					local var_102_60 = var_102_57 / var_102_58
					local var_102_61 = var_102_56 / var_102_59
					local var_102_62 = var_102_61 < var_102_60 and var_102_60 or var_102_61

					var_102_52.transform.localScale = Vector3.New(var_102_62, var_102_62, 0)
				end

				for iter_102_5, iter_102_6 in pairs(arg_99_1.bgs_) do
					if iter_102_5 ~= "STblack" then
						iter_102_6.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play115261025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 115261025
		arg_103_1.duration_ = 1

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play115261026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.var_.oldValueTypewriter = arg_103_1.fswtw_.percent

				SetActive(arg_103_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_103_1:ShowNextGo(false)
			end

			local var_106_1 = 14
			local var_106_2 = 0.933333333333333
			local var_106_3 = arg_103_1:GetWordFromCfg(115261024)
			local var_106_4 = arg_103_1:FormatText(var_106_3.content)
			local var_106_5, var_106_6 = arg_103_1:GetPercentByPara(var_106_4, 2)

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				local var_106_7 = var_106_1 <= 0 and var_106_2 or var_106_2 * ((var_106_6 - arg_103_1.typewritterCharCountI18N) / var_106_1)

				if var_106_7 > 0 and var_106_2 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end
			end

			local var_106_8 = 0.933333333333333
			local var_106_9 = math.max(var_106_8, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_9 then
				local var_106_10 = (arg_103_1.time_ - var_106_0) / var_106_9

				arg_103_1.fswtw_.percent = Mathf.Lerp(arg_103_1.var_.oldValueTypewriter, var_106_5, var_106_10)
				arg_103_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_103_1.fswtw_:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_9 and arg_103_1.time_ < var_106_0 + var_106_9 + arg_106_0 then
				arg_103_1.fswtw_.percent = var_106_5

				arg_103_1.fswtw_:SetDirty()
				arg_103_1:ShowNextGo(true)

				arg_103_1.typewritterCharCountI18N = var_106_6
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play115261026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 115261026
		arg_107_1.duration_ = 1.07

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play115261027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.var_.oldValueTypewriter = arg_107_1.fswtw_.percent

				SetActive(arg_107_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_107_1:ShowNextGo(false)
			end

			local var_110_1 = 16
			local var_110_2 = 1.06666666666667
			local var_110_3 = arg_107_1:GetWordFromCfg(115261024)
			local var_110_4 = arg_107_1:FormatText(var_110_3.content)
			local var_110_5, var_110_6 = arg_107_1:GetPercentByPara(var_110_4, 3)

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0

				local var_110_7 = var_110_1 <= 0 and var_110_2 or var_110_2 * ((var_110_6 - arg_107_1.typewritterCharCountI18N) / var_110_1)

				if var_110_7 > 0 and var_110_2 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_0
					end
				end
			end

			local var_110_8 = 1.06666666666667
			local var_110_9 = math.max(var_110_8, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_9 then
				local var_110_10 = (arg_107_1.time_ - var_110_0) / var_110_9

				arg_107_1.fswtw_.percent = Mathf.Lerp(arg_107_1.var_.oldValueTypewriter, var_110_5, var_110_10)
				arg_107_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_107_1.fswtw_:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_9 and arg_107_1.time_ < var_110_0 + var_110_9 + arg_110_0 then
				arg_107_1.fswtw_.percent = var_110_5

				arg_107_1.fswtw_:SetDirty()
				arg_107_1:ShowNextGo(true)

				arg_107_1.typewritterCharCountI18N = var_110_6
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play115261027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 115261027
		arg_111_1.duration_ = 1.13

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play115261028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.var_.oldValueTypewriter = arg_111_1.fswtw_.percent

				SetActive(arg_111_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_111_1:ShowNextGo(false)
			end

			local var_114_1 = 17
			local var_114_2 = 1.13333333333333
			local var_114_3 = arg_111_1:GetWordFromCfg(115261024)
			local var_114_4 = arg_111_1:FormatText(var_114_3.content)
			local var_114_5, var_114_6 = arg_111_1:GetPercentByPara(var_114_4, 4)

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				local var_114_7 = var_114_1 <= 0 and var_114_2 or var_114_2 * ((var_114_6 - arg_111_1.typewritterCharCountI18N) / var_114_1)

				if var_114_7 > 0 and var_114_2 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end
			end

			local var_114_8 = 1.13333333333333
			local var_114_9 = math.max(var_114_8, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_9 then
				local var_114_10 = (arg_111_1.time_ - var_114_0) / var_114_9

				arg_111_1.fswtw_.percent = Mathf.Lerp(arg_111_1.var_.oldValueTypewriter, var_114_5, var_114_10)
				arg_111_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_111_1.fswtw_:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_9 and arg_111_1.time_ < var_114_0 + var_114_9 + arg_114_0 then
				arg_111_1.fswtw_.percent = var_114_5

				arg_111_1.fswtw_:SetDirty()
				arg_111_1:ShowNextGo(true)

				arg_111_1.typewritterCharCountI18N = var_114_6
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play115261028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 115261028
		arg_115_1.duration_ = 1

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play115261029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.var_.oldValueTypewriter = arg_115_1.fswtw_.percent

				SetActive(arg_115_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_115_1:ShowNextGo(false)
			end

			local var_118_1 = 12
			local var_118_2 = 0.8
			local var_118_3 = arg_115_1:GetWordFromCfg(115261024)
			local var_118_4 = arg_115_1:FormatText(var_118_3.content)
			local var_118_5, var_118_6 = arg_115_1:GetPercentByPara(var_118_4, 5)

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				local var_118_7 = var_118_1 <= 0 and var_118_2 or var_118_2 * ((var_118_6 - arg_115_1.typewritterCharCountI18N) / var_118_1)

				if var_118_7 > 0 and var_118_2 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_0
					end
				end
			end

			local var_118_8 = 0.8
			local var_118_9 = math.max(var_118_8, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_9 then
				local var_118_10 = (arg_115_1.time_ - var_118_0) / var_118_9

				arg_115_1.fswtw_.percent = Mathf.Lerp(arg_115_1.var_.oldValueTypewriter, var_118_5, var_118_10)
				arg_115_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_115_1.fswtw_:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_9 and arg_115_1.time_ < var_118_0 + var_118_9 + arg_118_0 then
				arg_115_1.fswtw_.percent = var_118_5

				arg_115_1.fswtw_:SetDirty()
				arg_115_1:ShowNextGo(true)

				arg_115_1.typewritterCharCountI18N = var_118_6
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play115261029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 115261029
		arg_119_1.duration_ = 1

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play115261030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.var_.oldValueTypewriter = arg_119_1.fswtw_.percent

				SetActive(arg_119_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_119_1:ShowNextGo(false)
			end

			local var_122_1 = 14
			local var_122_2 = 0.933333333333333
			local var_122_3 = arg_119_1:GetWordFromCfg(115261024)
			local var_122_4 = arg_119_1:FormatText(var_122_3.content)
			local var_122_5, var_122_6 = arg_119_1:GetPercentByPara(var_122_4, 6)

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				local var_122_7 = var_122_1 <= 0 and var_122_2 or var_122_2 * ((var_122_6 - arg_119_1.typewritterCharCountI18N) / var_122_1)

				if var_122_7 > 0 and var_122_2 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_0
					end
				end
			end

			local var_122_8 = 0.933333333333333
			local var_122_9 = math.max(var_122_8, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_9 then
				local var_122_10 = (arg_119_1.time_ - var_122_0) / var_122_9

				arg_119_1.fswtw_.percent = Mathf.Lerp(arg_119_1.var_.oldValueTypewriter, var_122_5, var_122_10)
				arg_119_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_119_1.fswtw_:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_9 and arg_119_1.time_ < var_122_0 + var_122_9 + arg_122_0 then
				arg_119_1.fswtw_.percent = var_122_5

				arg_119_1.fswtw_:SetDirty()
				arg_119_1:ShowNextGo(true)

				arg_119_1.typewritterCharCountI18N = var_122_6
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play115261030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 115261030
		arg_123_1.duration_ = 1

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play115261031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.var_.oldValueTypewriter = arg_123_1.fswtw_.percent

				SetActive(arg_123_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_123_1:ShowNextGo(false)
			end

			local var_126_1 = 14
			local var_126_2 = 0.933333333333333
			local var_126_3 = arg_123_1:GetWordFromCfg(115261024)
			local var_126_4 = arg_123_1:FormatText(var_126_3.content)
			local var_126_5, var_126_6 = arg_123_1:GetPercentByPara(var_126_4, 7)

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				local var_126_7 = var_126_1 <= 0 and var_126_2 or var_126_2 * ((var_126_6 - arg_123_1.typewritterCharCountI18N) / var_126_1)

				if var_126_7 > 0 and var_126_2 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end
			end

			local var_126_8 = 0.933333333333333
			local var_126_9 = math.max(var_126_8, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_9 then
				local var_126_10 = (arg_123_1.time_ - var_126_0) / var_126_9

				arg_123_1.fswtw_.percent = Mathf.Lerp(arg_123_1.var_.oldValueTypewriter, var_126_5, var_126_10)
				arg_123_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_123_1.fswtw_:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_9 and arg_123_1.time_ < var_126_0 + var_126_9 + arg_126_0 then
				arg_123_1.fswtw_.percent = var_126_5

				arg_123_1.fswtw_:SetDirty()
				arg_123_1:ShowNextGo(true)

				arg_123_1.typewritterCharCountI18N = var_126_6
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play115261031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 115261031
		arg_127_1.duration_ = 8

		local var_127_0 = {
			ja = 6.99999999999999,
			ko = 7.06599999999999,
			zh = 7.99999999999999,
			en = 7.13299999999999
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play115261032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = "F01a"

			if arg_127_1.bgs_[var_130_0] == nil then
				local var_130_1 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_130_0)
				var_130_1.name = var_130_0
				var_130_1.transform.parent = arg_127_1.stage_.transform
				var_130_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_[var_130_0] = var_130_1
			end

			local var_130_2 = 4

			if var_130_2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				local var_130_3 = manager.ui.mainCamera.transform.localPosition
				local var_130_4 = Vector3.New(0, 0, 10) + Vector3.New(var_130_3.x, var_130_3.y, 0)
				local var_130_5 = arg_127_1.bgs_.F01a

				var_130_5.transform.localPosition = var_130_4
				var_130_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_6 = var_130_5:GetComponent("SpriteRenderer")

				if var_130_6 and var_130_6.sprite then
					local var_130_7 = (var_130_5.transform.localPosition - var_130_3).z
					local var_130_8 = manager.ui.mainCameraCom_
					local var_130_9 = 2 * var_130_7 * Mathf.Tan(var_130_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_130_10 = var_130_9 * var_130_8.aspect
					local var_130_11 = var_130_6.sprite.bounds.size.x
					local var_130_12 = var_130_6.sprite.bounds.size.y
					local var_130_13 = var_130_10 / var_130_11
					local var_130_14 = var_130_9 / var_130_12
					local var_130_15 = var_130_14 < var_130_13 and var_130_13 or var_130_14

					var_130_5.transform.localScale = Vector3.New(var_130_15, var_130_15, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "F01a" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_16 = 4

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = false

				arg_127_1:SetGaussion(false)
			end

			local var_130_17 = 2

			if var_130_16 <= arg_127_1.time_ and arg_127_1.time_ < var_130_16 + var_130_17 then
				local var_130_18 = (arg_127_1.time_ - var_130_16) / var_130_17
				local var_130_19 = Color.New(0, 0, 0)

				var_130_19.a = Mathf.Lerp(1, 0, var_130_18)
				arg_127_1.mask_.color = var_130_19
			end

			if arg_127_1.time_ >= var_130_16 + var_130_17 and arg_127_1.time_ < var_130_16 + var_130_17 + arg_130_0 then
				local var_130_20 = Color.New(0, 0, 0)
				local var_130_21 = 0

				arg_127_1.mask_.enabled = false
				var_130_20.a = var_130_21
				arg_127_1.mask_.color = var_130_20
			end

			local var_130_22 = 0

			if var_130_22 < arg_127_1.time_ and arg_127_1.time_ <= var_130_22 + arg_130_0 then
				arg_127_1.fswbg_:SetActive(false)
				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_127_1:ShowNextGo(false)
			end

			local var_130_23 = arg_127_1.actors_["1038"].transform
			local var_130_24 = 5.99999999999999

			if var_130_24 < arg_127_1.time_ and arg_127_1.time_ <= var_130_24 + arg_130_0 then
				arg_127_1.var_.moveOldPos1038 = var_130_23.localPosition
				var_130_23.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("1038", 2)

				local var_130_25 = var_130_23.childCount

				for iter_130_2 = 0, var_130_25 - 1 do
					local var_130_26 = var_130_23:GetChild(iter_130_2)

					if var_130_26.name == "split_1" or not string.find(var_130_26.name, "split") then
						var_130_26.gameObject:SetActive(true)
					else
						var_130_26.gameObject:SetActive(false)
					end
				end
			end

			local var_130_27 = 0.001

			if var_130_24 <= arg_127_1.time_ and arg_127_1.time_ < var_130_24 + var_130_27 then
				local var_130_28 = (arg_127_1.time_ - var_130_24) / var_130_27
				local var_130_29 = Vector3.New(-390, -400, 0)

				var_130_23.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1038, var_130_29, var_130_28)
			end

			if arg_127_1.time_ >= var_130_24 + var_130_27 and arg_127_1.time_ < var_130_24 + var_130_27 + arg_130_0 then
				var_130_23.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_130_30 = arg_127_1.actors_["1038"]
			local var_130_31 = 5.99999999999999

			if var_130_31 < arg_127_1.time_ and arg_127_1.time_ <= var_130_31 + arg_130_0 and not isNil(var_130_30) and arg_127_1.var_.actorSpriteComps1038 == nil then
				arg_127_1.var_.actorSpriteComps1038 = var_130_30:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_32 = 0.2

			if var_130_31 <= arg_127_1.time_ and arg_127_1.time_ < var_130_31 + var_130_32 and not isNil(var_130_30) then
				local var_130_33 = (arg_127_1.time_ - var_130_31) / var_130_32

				if arg_127_1.var_.actorSpriteComps1038 then
					for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_130_4 then
							if arg_127_1.isInRecall_ then
								local var_130_34 = Mathf.Lerp(iter_130_4.color.r, arg_127_1.hightColor1.r, var_130_33)
								local var_130_35 = Mathf.Lerp(iter_130_4.color.g, arg_127_1.hightColor1.g, var_130_33)
								local var_130_36 = Mathf.Lerp(iter_130_4.color.b, arg_127_1.hightColor1.b, var_130_33)

								iter_130_4.color = Color.New(var_130_34, var_130_35, var_130_36)
							else
								local var_130_37 = Mathf.Lerp(iter_130_4.color.r, 1, var_130_33)

								iter_130_4.color = Color.New(var_130_37, var_130_37, var_130_37)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_31 + var_130_32 and arg_127_1.time_ < var_130_31 + var_130_32 + arg_130_0 and not isNil(var_130_30) and arg_127_1.var_.actorSpriteComps1038 then
				for iter_130_5, iter_130_6 in pairs(arg_127_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_130_6 then
						if arg_127_1.isInRecall_ then
							iter_130_6.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps1038 = nil
			end

			local var_130_38 = arg_127_1.actors_["1038"]
			local var_130_39 = 5.99999999999999

			if var_130_39 < arg_127_1.time_ and arg_127_1.time_ <= var_130_39 + arg_130_0 then
				local var_130_40 = var_130_38:GetComponentInChildren(typeof(CanvasGroup))

				if var_130_40 then
					arg_127_1.var_.alphaOldValue1038 = var_130_40.alpha
					arg_127_1.var_.characterEffect1038 = var_130_40
				end

				arg_127_1.var_.alphaOldValue1038 = 0
			end

			local var_130_41 = 0.5

			if var_130_39 <= arg_127_1.time_ and arg_127_1.time_ < var_130_39 + var_130_41 then
				local var_130_42 = (arg_127_1.time_ - var_130_39) / var_130_41
				local var_130_43 = Mathf.Lerp(arg_127_1.var_.alphaOldValue1038, 1, var_130_42)

				if arg_127_1.var_.characterEffect1038 then
					arg_127_1.var_.characterEffect1038.alpha = var_130_43
				end
			end

			if arg_127_1.time_ >= var_130_39 + var_130_41 and arg_127_1.time_ < var_130_39 + var_130_41 + arg_130_0 and arg_127_1.var_.characterEffect1038 then
				arg_127_1.var_.characterEffect1038.alpha = 1
			end

			local var_130_44 = 0
			local var_130_45 = 1

			if var_130_44 < arg_127_1.time_ and arg_127_1.time_ <= var_130_44 + arg_130_0 then
				local var_130_46 = "play"
				local var_130_47 = "music"

				arg_127_1:AudioAction(var_130_46, var_130_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_130_48 = ""
				local var_130_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_130_49 ~= "" then
					if arg_127_1.bgmTxt_.text ~= var_130_49 and arg_127_1.bgmTxt_.text ~= "" then
						if arg_127_1.bgmTxt2_.text ~= "" then
							arg_127_1.bgmTxt_.text = arg_127_1.bgmTxt2_.text
						end

						arg_127_1.bgmTxt2_.text = var_130_49

						arg_127_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_127_1.bgmTxt_.text = var_130_49
						arg_127_1.bgmTxt2_.text = var_130_49
					end

					if arg_127_1.bgmTimer then
						arg_127_1.bgmTimer:Stop()

						arg_127_1.bgmTimer = nil
					end

					if arg_127_1.settingData.show_music_name == 1 then
						arg_127_1.musicController:SetSelectedState("show")
						arg_127_1.musicAnimator_:Play("open", 0, 0)

						if arg_127_1.settingData.music_time ~= 0 then
							arg_127_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_127_1.settingData.music_time), function()
								if arg_127_1 == nil or isNil(arg_127_1.bgmTxt_) then
									return
								end

								arg_127_1.musicController:SetSelectedState("hide")
								arg_127_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_130_50 = 1.03333333333333
			local var_130_51 = 1

			if var_130_50 < arg_127_1.time_ and arg_127_1.time_ <= var_130_50 + arg_130_0 then
				local var_130_52 = "play"
				local var_130_53 = "music"

				arg_127_1:AudioAction(var_130_52, var_130_53, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_130_54 = ""
				local var_130_55 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_130_55 ~= "" then
					if arg_127_1.bgmTxt_.text ~= var_130_55 and arg_127_1.bgmTxt_.text ~= "" then
						if arg_127_1.bgmTxt2_.text ~= "" then
							arg_127_1.bgmTxt_.text = arg_127_1.bgmTxt2_.text
						end

						arg_127_1.bgmTxt2_.text = var_130_55

						arg_127_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_127_1.bgmTxt_.text = var_130_55
						arg_127_1.bgmTxt2_.text = var_130_55
					end

					if arg_127_1.bgmTimer then
						arg_127_1.bgmTimer:Stop()

						arg_127_1.bgmTimer = nil
					end

					if arg_127_1.settingData.show_music_name == 1 then
						arg_127_1.musicController:SetSelectedState("show")
						arg_127_1.musicAnimator_:Play("open", 0, 0)

						if arg_127_1.settingData.music_time ~= 0 then
							arg_127_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_127_1.settingData.music_time), function()
								if arg_127_1 == nil or isNil(arg_127_1.bgmTxt_) then
									return
								end

								arg_127_1.musicController:SetSelectedState("hide")
								arg_127_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_56 = 5.99999999999999
			local var_130_57 = 0.1

			if var_130_56 < arg_127_1.time_ and arg_127_1.time_ <= var_130_56 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_58 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_58:setOnUpdate(LuaHelper.FloatAction(function(arg_133_0)
					arg_127_1.dialogCg_.alpha = arg_133_0
				end))
				var_130_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_59 = arg_127_1:FormatText(StoryNameCfg[94].name)

				arg_127_1.leftNameTxt_.text = var_130_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_60 = arg_127_1:GetWordFromCfg(115261031)
				local var_130_61 = arg_127_1:FormatText(var_130_60.content)

				arg_127_1.text_.text = var_130_61

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_62 = 4
				local var_130_63 = utf8.len(var_130_61)
				local var_130_64 = var_130_62 <= 0 and var_130_57 or var_130_57 * (var_130_63 / var_130_62)

				if var_130_64 > 0 and var_130_57 < var_130_64 then
					arg_127_1.talkMaxDuration = var_130_64
					var_130_56 = var_130_56 + 0.3

					if var_130_64 + var_130_56 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_64 + var_130_56
					end
				end

				arg_127_1.text_.text = var_130_61
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261031", "story_v_out_115261.awb") ~= 0 then
					local var_130_65 = manager.audio:GetVoiceLength("story_v_out_115261", "115261031", "story_v_out_115261.awb") / 1000

					if var_130_65 + var_130_56 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_65 + var_130_56
					end

					if var_130_60.prefab_name ~= "" and arg_127_1.actors_[var_130_60.prefab_name] ~= nil then
						local var_130_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_60.prefab_name].transform, "story_v_out_115261", "115261031", "story_v_out_115261.awb")

						arg_127_1:RecordAudio("115261031", var_130_66)
						arg_127_1:RecordAudio("115261031", var_130_66)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_115261", "115261031", "story_v_out_115261.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_115261", "115261031", "story_v_out_115261.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_67 = var_130_56 + 0.3
			local var_130_68 = math.max(var_130_57, arg_127_1.talkMaxDuration)

			if var_130_67 <= arg_127_1.time_ and arg_127_1.time_ < var_130_67 + var_130_68 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_67) / var_130_68

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_67 + var_130_68 and arg_127_1.time_ < var_130_67 + var_130_68 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.99999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play115261032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 115261032
		arg_135_1.duration_ = 1.2

		local var_135_0 = {
			ja = 0.999999999999,
			ko = 1.066,
			zh = 1.133,
			en = 1.2
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
				arg_135_0:Play115261033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1038"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps1038 == nil then
				arg_135_1.var_.actorSpriteComps1038 = var_138_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_2 = 0.2

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.actorSpriteComps1038 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								local var_138_4 = Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor2.r, var_138_3)
								local var_138_5 = Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor2.g, var_138_3)
								local var_138_6 = Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor2.b, var_138_3)

								iter_138_1.color = Color.New(var_138_4, var_138_5, var_138_6)
							else
								local var_138_7 = Mathf.Lerp(iter_138_1.color.r, 0.5, var_138_3)

								iter_138_1.color = Color.New(var_138_7, var_138_7, var_138_7)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps1038 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_138_3 then
						if arg_135_1.isInRecall_ then
							iter_138_3.color = arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_138_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps1038 = nil
			end

			local var_138_8 = "10030"

			if arg_135_1.actors_[var_138_8] == nil then
				local var_138_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10030")

				if not isNil(var_138_9) then
					local var_138_10 = Object.Instantiate(var_138_9, arg_135_1.canvasGo_.transform)

					var_138_10.transform:SetSiblingIndex(1)

					var_138_10.name = var_138_8
					var_138_10.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_135_1.actors_[var_138_8] = var_138_10

					local var_138_11 = var_138_10:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_135_1.isInRecall_ then
						for iter_138_4, iter_138_5 in ipairs(var_138_11) do
							iter_138_5.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_138_12 = arg_135_1.actors_["10030"].transform
			local var_138_13 = 0

			if var_138_13 < arg_135_1.time_ and arg_135_1.time_ <= var_138_13 + arg_138_0 then
				arg_135_1.var_.moveOldPos10030 = var_138_12.localPosition
				var_138_12.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10030", 4)

				local var_138_14 = var_138_12.childCount

				for iter_138_6 = 0, var_138_14 - 1 do
					local var_138_15 = var_138_12:GetChild(iter_138_6)

					if var_138_15.name == "split_1" or not string.find(var_138_15.name, "split") then
						var_138_15.gameObject:SetActive(true)
					else
						var_138_15.gameObject:SetActive(false)
					end
				end
			end

			local var_138_16 = 0.001

			if var_138_13 <= arg_135_1.time_ and arg_135_1.time_ < var_138_13 + var_138_16 then
				local var_138_17 = (arg_135_1.time_ - var_138_13) / var_138_16
				local var_138_18 = Vector3.New(390, -390, 150)

				var_138_12.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10030, var_138_18, var_138_17)
			end

			if arg_135_1.time_ >= var_138_13 + var_138_16 and arg_135_1.time_ < var_138_13 + var_138_16 + arg_138_0 then
				var_138_12.localPosition = Vector3.New(390, -390, 150)
			end

			local var_138_19 = arg_135_1.actors_["10030"]
			local var_138_20 = 0

			if var_138_20 < arg_135_1.time_ and arg_135_1.time_ <= var_138_20 + arg_138_0 and not isNil(var_138_19) and arg_135_1.var_.actorSpriteComps10030 == nil then
				arg_135_1.var_.actorSpriteComps10030 = var_138_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_21 = 0.2

			if var_138_20 <= arg_135_1.time_ and arg_135_1.time_ < var_138_20 + var_138_21 and not isNil(var_138_19) then
				local var_138_22 = (arg_135_1.time_ - var_138_20) / var_138_21

				if arg_135_1.var_.actorSpriteComps10030 then
					for iter_138_7, iter_138_8 in pairs(arg_135_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_138_8 then
							if arg_135_1.isInRecall_ then
								local var_138_23 = Mathf.Lerp(iter_138_8.color.r, arg_135_1.hightColor1.r, var_138_22)
								local var_138_24 = Mathf.Lerp(iter_138_8.color.g, arg_135_1.hightColor1.g, var_138_22)
								local var_138_25 = Mathf.Lerp(iter_138_8.color.b, arg_135_1.hightColor1.b, var_138_22)

								iter_138_8.color = Color.New(var_138_23, var_138_24, var_138_25)
							else
								local var_138_26 = Mathf.Lerp(iter_138_8.color.r, 1, var_138_22)

								iter_138_8.color = Color.New(var_138_26, var_138_26, var_138_26)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_20 + var_138_21 and arg_135_1.time_ < var_138_20 + var_138_21 + arg_138_0 and not isNil(var_138_19) and arg_135_1.var_.actorSpriteComps10030 then
				for iter_138_9, iter_138_10 in pairs(arg_135_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_138_10 then
						if arg_135_1.isInRecall_ then
							iter_138_10.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_10.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10030 = nil
			end

			local var_138_27 = arg_135_1.actors_["10030"]
			local var_138_28 = 0

			if var_138_28 < arg_135_1.time_ and arg_135_1.time_ <= var_138_28 + arg_138_0 then
				local var_138_29 = var_138_27:GetComponentInChildren(typeof(CanvasGroup))

				if var_138_29 then
					arg_135_1.var_.alphaOldValue10030 = var_138_29.alpha
					arg_135_1.var_.characterEffect10030 = var_138_29
				end

				arg_135_1.var_.alphaOldValue10030 = 0
			end

			local var_138_30 = 0.5

			if var_138_28 <= arg_135_1.time_ and arg_135_1.time_ < var_138_28 + var_138_30 then
				local var_138_31 = (arg_135_1.time_ - var_138_28) / var_138_30
				local var_138_32 = Mathf.Lerp(arg_135_1.var_.alphaOldValue10030, 1, var_138_31)

				if arg_135_1.var_.characterEffect10030 then
					arg_135_1.var_.characterEffect10030.alpha = var_138_32
				end
			end

			if arg_135_1.time_ >= var_138_28 + var_138_30 and arg_135_1.time_ < var_138_28 + var_138_30 + arg_138_0 and arg_135_1.var_.characterEffect10030 then
				arg_135_1.var_.characterEffect10030.alpha = 1
			end

			local var_138_33 = 0
			local var_138_34 = 0.1

			if var_138_33 < arg_135_1.time_ and arg_135_1.time_ <= var_138_33 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_35 = arg_135_1:FormatText(StoryNameCfg[309].name)

				arg_135_1.leftNameTxt_.text = var_138_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_36 = arg_135_1:GetWordFromCfg(115261032)
				local var_138_37 = arg_135_1:FormatText(var_138_36.content)

				arg_135_1.text_.text = var_138_37

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_38 = 4
				local var_138_39 = utf8.len(var_138_37)
				local var_138_40 = var_138_38 <= 0 and var_138_34 or var_138_34 * (var_138_39 / var_138_38)

				if var_138_40 > 0 and var_138_34 < var_138_40 then
					arg_135_1.talkMaxDuration = var_138_40

					if var_138_40 + var_138_33 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_40 + var_138_33
					end
				end

				arg_135_1.text_.text = var_138_37
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261032", "story_v_out_115261.awb") ~= 0 then
					local var_138_41 = manager.audio:GetVoiceLength("story_v_out_115261", "115261032", "story_v_out_115261.awb") / 1000

					if var_138_41 + var_138_33 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_41 + var_138_33
					end

					if var_138_36.prefab_name ~= "" and arg_135_1.actors_[var_138_36.prefab_name] ~= nil then
						local var_138_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_36.prefab_name].transform, "story_v_out_115261", "115261032", "story_v_out_115261.awb")

						arg_135_1:RecordAudio("115261032", var_138_42)
						arg_135_1:RecordAudio("115261032", var_138_42)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_115261", "115261032", "story_v_out_115261.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_115261", "115261032", "story_v_out_115261.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_43 = math.max(var_138_34, arg_135_1.talkMaxDuration)

			if var_138_33 <= arg_135_1.time_ and arg_135_1.time_ < var_138_33 + var_138_43 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_33) / var_138_43

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_33 + var_138_43 and arg_135_1.time_ < var_138_33 + var_138_43 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
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
	Play115261033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 115261033
		arg_139_1.duration_ = 5.4

		local var_139_0 = {
			ja = 4.8,
			ko = 5.4,
			zh = 4,
			en = 5
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
				arg_139_0:Play115261034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.4

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[309].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_3 = arg_139_1:GetWordFromCfg(115261033)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 16
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261033", "story_v_out_115261.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261033", "story_v_out_115261.awb") / 1000

					if var_142_8 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_0
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_115261", "115261033", "story_v_out_115261.awb")

						arg_139_1:RecordAudio("115261033", var_142_9)
						arg_139_1:RecordAudio("115261033", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_115261", "115261033", "story_v_out_115261.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_115261", "115261033", "story_v_out_115261.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_10 and arg_139_1.time_ < var_142_0 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play115261034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 115261034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play115261035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1038"].transform
			local var_146_1 = 0.5

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos1038 = var_146_0.localPosition
				var_146_0.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1038", 7)

				local var_146_2 = var_146_0.childCount

				for iter_146_0 = 0, var_146_2 - 1 do
					local var_146_3 = var_146_0:GetChild(iter_146_0)

					if var_146_3.name == "split_5" or not string.find(var_146_3.name, "split") then
						var_146_3.gameObject:SetActive(true)
					else
						var_146_3.gameObject:SetActive(false)
					end
				end
			end

			local var_146_4 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_4 then
				local var_146_5 = (arg_143_1.time_ - var_146_1) / var_146_4
				local var_146_6 = Vector3.New(0, -2000, 0)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1038, var_146_6, var_146_5)
			end

			if arg_143_1.time_ >= var_146_1 + var_146_4 and arg_143_1.time_ < var_146_1 + var_146_4 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_146_7 = arg_143_1.actors_["10030"].transform
			local var_146_8 = 0.5

			if var_146_8 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 then
				arg_143_1.var_.moveOldPos10030 = var_146_7.localPosition
				var_146_7.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10030", 7)

				local var_146_9 = var_146_7.childCount

				for iter_146_1 = 0, var_146_9 - 1 do
					local var_146_10 = var_146_7:GetChild(iter_146_1)

					if var_146_10.name == "split_1" or not string.find(var_146_10.name, "split") then
						var_146_10.gameObject:SetActive(true)
					else
						var_146_10.gameObject:SetActive(false)
					end
				end
			end

			local var_146_11 = 0.001

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_11 then
				local var_146_12 = (arg_143_1.time_ - var_146_8) / var_146_11
				local var_146_13 = Vector3.New(0, -2000, 150)

				var_146_7.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10030, var_146_13, var_146_12)
			end

			if arg_143_1.time_ >= var_146_8 + var_146_11 and arg_143_1.time_ < var_146_8 + var_146_11 + arg_146_0 then
				var_146_7.localPosition = Vector3.New(0, -2000, 150)
			end

			local var_146_14 = arg_143_1.actors_["10030"]
			local var_146_15 = 0

			if var_146_15 < arg_143_1.time_ and arg_143_1.time_ <= var_146_15 + arg_146_0 then
				local var_146_16 = var_146_14:GetComponentInChildren(typeof(CanvasGroup))

				if var_146_16 then
					arg_143_1.var_.alphaOldValue10030 = var_146_16.alpha
					arg_143_1.var_.characterEffect10030 = var_146_16
				end

				arg_143_1.var_.alphaOldValue10030 = 1
			end

			local var_146_17 = 0.2

			if var_146_15 <= arg_143_1.time_ and arg_143_1.time_ < var_146_15 + var_146_17 then
				local var_146_18 = (arg_143_1.time_ - var_146_15) / var_146_17
				local var_146_19 = Mathf.Lerp(arg_143_1.var_.alphaOldValue10030, 0, var_146_18)

				if arg_143_1.var_.characterEffect10030 then
					arg_143_1.var_.characterEffect10030.alpha = var_146_19
				end
			end

			if arg_143_1.time_ >= var_146_15 + var_146_17 and arg_143_1.time_ < var_146_15 + var_146_17 + arg_146_0 and arg_143_1.var_.characterEffect10030 then
				arg_143_1.var_.characterEffect10030.alpha = 0
			end

			local var_146_20 = arg_143_1.actors_["1038"]
			local var_146_21 = 0

			if var_146_21 < arg_143_1.time_ and arg_143_1.time_ <= var_146_21 + arg_146_0 then
				local var_146_22 = var_146_20:GetComponentInChildren(typeof(CanvasGroup))

				if var_146_22 then
					arg_143_1.var_.alphaOldValue1038 = var_146_22.alpha
					arg_143_1.var_.characterEffect1038 = var_146_22
				end

				arg_143_1.var_.alphaOldValue1038 = 1
			end

			local var_146_23 = 0.2

			if var_146_21 <= arg_143_1.time_ and arg_143_1.time_ < var_146_21 + var_146_23 then
				local var_146_24 = (arg_143_1.time_ - var_146_21) / var_146_23
				local var_146_25 = Mathf.Lerp(arg_143_1.var_.alphaOldValue1038, 0, var_146_24)

				if arg_143_1.var_.characterEffect1038 then
					arg_143_1.var_.characterEffect1038.alpha = var_146_25
				end
			end

			if arg_143_1.time_ >= var_146_21 + var_146_23 and arg_143_1.time_ < var_146_21 + var_146_23 + arg_146_0 and arg_143_1.var_.characterEffect1038 then
				arg_143_1.var_.characterEffect1038.alpha = 0
			end

			local var_146_26 = 0
			local var_146_27 = 0.7

			if var_146_26 < arg_143_1.time_ and arg_143_1.time_ <= var_146_26 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_28 = arg_143_1:GetWordFromCfg(115261034)
				local var_146_29 = arg_143_1:FormatText(var_146_28.content)

				arg_143_1.text_.text = var_146_29

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_30 = 28
				local var_146_31 = utf8.len(var_146_29)
				local var_146_32 = var_146_30 <= 0 and var_146_27 or var_146_27 * (var_146_31 / var_146_30)

				if var_146_32 > 0 and var_146_27 < var_146_32 then
					arg_143_1.talkMaxDuration = var_146_32

					if var_146_32 + var_146_26 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_32 + var_146_26
					end
				end

				arg_143_1.text_.text = var_146_29
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_33 = math.max(var_146_27, arg_143_1.talkMaxDuration)

			if var_146_26 <= arg_143_1.time_ and arg_143_1.time_ < var_146_26 + var_146_33 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_26) / var_146_33

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_26 + var_146_33 and arg_143_1.time_ < var_146_26 + var_146_33 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play115261035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 115261035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play115261036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 1.275

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

				local var_150_2 = arg_147_1:GetWordFromCfg(115261035)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 51
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
	Play115261036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 115261036
		arg_151_1.duration_ = 6.03

		local var_151_0 = {
			ja = 5.8,
			ko = 6.033,
			zh = 4.3,
			en = 3.766
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
				arg_151_0:Play115261037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10030"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10030 == nil then
				arg_151_1.var_.actorSpriteComps10030 = var_154_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.actorSpriteComps10030 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								local var_154_4 = Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor1.r, var_154_3)
								local var_154_5 = Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor1.g, var_154_3)
								local var_154_6 = Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor1.b, var_154_3)

								iter_154_1.color = Color.New(var_154_4, var_154_5, var_154_6)
							else
								local var_154_7 = Mathf.Lerp(iter_154_1.color.r, 1, var_154_3)

								iter_154_1.color = Color.New(var_154_7, var_154_7, var_154_7)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10030 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_154_3 then
						if arg_151_1.isInRecall_ then
							iter_154_3.color = arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_154_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10030 = nil
			end

			local var_154_8 = arg_151_1.actors_["10030"].transform
			local var_154_9 = 0

			if var_154_9 < arg_151_1.time_ and arg_151_1.time_ <= var_154_9 + arg_154_0 then
				arg_151_1.var_.moveOldPos10030 = var_154_8.localPosition
				var_154_8.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10030", 4)

				local var_154_10 = var_154_8.childCount

				for iter_154_4 = 0, var_154_10 - 1 do
					local var_154_11 = var_154_8:GetChild(iter_154_4)

					if var_154_11.name == "split_3" or not string.find(var_154_11.name, "split") then
						var_154_11.gameObject:SetActive(true)
					else
						var_154_11.gameObject:SetActive(false)
					end
				end
			end

			local var_154_12 = 0.001

			if var_154_9 <= arg_151_1.time_ and arg_151_1.time_ < var_154_9 + var_154_12 then
				local var_154_13 = (arg_151_1.time_ - var_154_9) / var_154_12
				local var_154_14 = Vector3.New(390, -390, 150)

				var_154_8.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10030, var_154_14, var_154_13)
			end

			if arg_151_1.time_ >= var_154_9 + var_154_12 and arg_151_1.time_ < var_154_9 + var_154_12 + arg_154_0 then
				var_154_8.localPosition = Vector3.New(390, -390, 150)
			end

			local var_154_15 = arg_151_1.actors_["10030"]
			local var_154_16 = 0

			if var_154_16 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 then
				local var_154_17 = var_154_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_154_17 then
					arg_151_1.var_.alphaOldValue10030 = var_154_17.alpha
					arg_151_1.var_.characterEffect10030 = var_154_17
				end

				arg_151_1.var_.alphaOldValue10030 = 0
			end

			local var_154_18 = 0.5

			if var_154_16 <= arg_151_1.time_ and arg_151_1.time_ < var_154_16 + var_154_18 then
				local var_154_19 = (arg_151_1.time_ - var_154_16) / var_154_18
				local var_154_20 = Mathf.Lerp(arg_151_1.var_.alphaOldValue10030, 1, var_154_19)

				if arg_151_1.var_.characterEffect10030 then
					arg_151_1.var_.characterEffect10030.alpha = var_154_20
				end
			end

			if arg_151_1.time_ >= var_154_16 + var_154_18 and arg_151_1.time_ < var_154_16 + var_154_18 + arg_154_0 and arg_151_1.var_.characterEffect10030 then
				arg_151_1.var_.characterEffect10030.alpha = 1
			end

			local var_154_21 = 0
			local var_154_22 = 0.35

			if var_154_21 < arg_151_1.time_ and arg_151_1.time_ <= var_154_21 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_23 = arg_151_1:FormatText(StoryNameCfg[309].name)

				arg_151_1.leftNameTxt_.text = var_154_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_24 = arg_151_1:GetWordFromCfg(115261036)
				local var_154_25 = arg_151_1:FormatText(var_154_24.content)

				arg_151_1.text_.text = var_154_25

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_26 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261036", "story_v_out_115261.awb") ~= 0 then
					local var_154_29 = manager.audio:GetVoiceLength("story_v_out_115261", "115261036", "story_v_out_115261.awb") / 1000

					if var_154_29 + var_154_21 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_29 + var_154_21
					end

					if var_154_24.prefab_name ~= "" and arg_151_1.actors_[var_154_24.prefab_name] ~= nil then
						local var_154_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_24.prefab_name].transform, "story_v_out_115261", "115261036", "story_v_out_115261.awb")

						arg_151_1:RecordAudio("115261036", var_154_30)
						arg_151_1:RecordAudio("115261036", var_154_30)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_115261", "115261036", "story_v_out_115261.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_115261", "115261036", "story_v_out_115261.awb")
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
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play115261037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 115261037
		arg_155_1.duration_ = 9.5

		local var_155_0 = {
			ja = 9.5,
			ko = 7,
			zh = 7.7,
			en = 8.133
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
				arg_155_0:Play115261038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10030"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps10030 == nil then
				arg_155_1.var_.actorSpriteComps10030 = var_158_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_2 = 0.2

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.actorSpriteComps10030 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								local var_158_4 = Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor2.r, var_158_3)
								local var_158_5 = Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor2.g, var_158_3)
								local var_158_6 = Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor2.b, var_158_3)

								iter_158_1.color = Color.New(var_158_4, var_158_5, var_158_6)
							else
								local var_158_7 = Mathf.Lerp(iter_158_1.color.r, 0.5, var_158_3)

								iter_158_1.color = Color.New(var_158_7, var_158_7, var_158_7)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps10030 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_158_3 then
						if arg_155_1.isInRecall_ then
							iter_158_3.color = arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_158_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10030 = nil
			end

			local var_158_8 = arg_155_1.actors_["1038"]
			local var_158_9 = 0

			if var_158_9 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.actorSpriteComps1038 == nil then
				arg_155_1.var_.actorSpriteComps1038 = var_158_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_10 = 0.2

			if var_158_9 <= arg_155_1.time_ and arg_155_1.time_ < var_158_9 + var_158_10 and not isNil(var_158_8) then
				local var_158_11 = (arg_155_1.time_ - var_158_9) / var_158_10

				if arg_155_1.var_.actorSpriteComps1038 then
					for iter_158_4, iter_158_5 in pairs(arg_155_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_158_5 then
							if arg_155_1.isInRecall_ then
								local var_158_12 = Mathf.Lerp(iter_158_5.color.r, arg_155_1.hightColor1.r, var_158_11)
								local var_158_13 = Mathf.Lerp(iter_158_5.color.g, arg_155_1.hightColor1.g, var_158_11)
								local var_158_14 = Mathf.Lerp(iter_158_5.color.b, arg_155_1.hightColor1.b, var_158_11)

								iter_158_5.color = Color.New(var_158_12, var_158_13, var_158_14)
							else
								local var_158_15 = Mathf.Lerp(iter_158_5.color.r, 1, var_158_11)

								iter_158_5.color = Color.New(var_158_15, var_158_15, var_158_15)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_9 + var_158_10 and arg_155_1.time_ < var_158_9 + var_158_10 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.actorSpriteComps1038 then
				for iter_158_6, iter_158_7 in pairs(arg_155_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_158_7 then
						if arg_155_1.isInRecall_ then
							iter_158_7.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps1038 = nil
			end

			local var_158_16 = arg_155_1.actors_["1038"].transform
			local var_158_17 = 0

			if var_158_17 < arg_155_1.time_ and arg_155_1.time_ <= var_158_17 + arg_158_0 then
				arg_155_1.var_.moveOldPos1038 = var_158_16.localPosition
				var_158_16.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1038", 2)

				local var_158_18 = var_158_16.childCount

				for iter_158_8 = 0, var_158_18 - 1 do
					local var_158_19 = var_158_16:GetChild(iter_158_8)

					if var_158_19.name == "split_1" or not string.find(var_158_19.name, "split") then
						var_158_19.gameObject:SetActive(true)
					else
						var_158_19.gameObject:SetActive(false)
					end
				end
			end

			local var_158_20 = 0.001

			if var_158_17 <= arg_155_1.time_ and arg_155_1.time_ < var_158_17 + var_158_20 then
				local var_158_21 = (arg_155_1.time_ - var_158_17) / var_158_20
				local var_158_22 = Vector3.New(-390, -400, 0)

				var_158_16.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1038, var_158_22, var_158_21)
			end

			if arg_155_1.time_ >= var_158_17 + var_158_20 and arg_155_1.time_ < var_158_17 + var_158_20 + arg_158_0 then
				var_158_16.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_158_23 = arg_155_1.actors_["1038"]
			local var_158_24 = 0

			if var_158_24 < arg_155_1.time_ and arg_155_1.time_ <= var_158_24 + arg_158_0 then
				local var_158_25 = var_158_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_158_25 then
					arg_155_1.var_.alphaOldValue1038 = var_158_25.alpha
					arg_155_1.var_.characterEffect1038 = var_158_25
				end

				arg_155_1.var_.alphaOldValue1038 = 0
			end

			local var_158_26 = 0.034

			if var_158_24 <= arg_155_1.time_ and arg_155_1.time_ < var_158_24 + var_158_26 then
				local var_158_27 = (arg_155_1.time_ - var_158_24) / var_158_26
				local var_158_28 = Mathf.Lerp(arg_155_1.var_.alphaOldValue1038, 1, var_158_27)

				if arg_155_1.var_.characterEffect1038 then
					arg_155_1.var_.characterEffect1038.alpha = var_158_28
				end
			end

			if arg_155_1.time_ >= var_158_24 + var_158_26 and arg_155_1.time_ < var_158_24 + var_158_26 + arg_158_0 and arg_155_1.var_.characterEffect1038 then
				arg_155_1.var_.characterEffect1038.alpha = 1
			end

			local var_158_29 = arg_155_1.actors_["1038"]
			local var_158_30 = 0

			if var_158_30 < arg_155_1.time_ and arg_155_1.time_ <= var_158_30 + arg_158_0 then
				local var_158_31 = var_158_29:GetComponentInChildren(typeof(CanvasGroup))

				if var_158_31 then
					arg_155_1.var_.alphaOldValue1038 = var_158_31.alpha
					arg_155_1.var_.characterEffect1038 = var_158_31
				end

				arg_155_1.var_.alphaOldValue1038 = 0
			end

			local var_158_32 = 0.5

			if var_158_30 <= arg_155_1.time_ and arg_155_1.time_ < var_158_30 + var_158_32 then
				local var_158_33 = (arg_155_1.time_ - var_158_30) / var_158_32
				local var_158_34 = Mathf.Lerp(arg_155_1.var_.alphaOldValue1038, 1, var_158_33)

				if arg_155_1.var_.characterEffect1038 then
					arg_155_1.var_.characterEffect1038.alpha = var_158_34
				end
			end

			if arg_155_1.time_ >= var_158_30 + var_158_32 and arg_155_1.time_ < var_158_30 + var_158_32 + arg_158_0 and arg_155_1.var_.characterEffect1038 then
				arg_155_1.var_.characterEffect1038.alpha = 1
			end

			local var_158_35 = 0
			local var_158_36 = 0.875

			if var_158_35 < arg_155_1.time_ and arg_155_1.time_ <= var_158_35 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_37 = arg_155_1:FormatText(StoryNameCfg[94].name)

				arg_155_1.leftNameTxt_.text = var_158_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_38 = arg_155_1:GetWordFromCfg(115261037)
				local var_158_39 = arg_155_1:FormatText(var_158_38.content)

				arg_155_1.text_.text = var_158_39

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_40 = 35
				local var_158_41 = utf8.len(var_158_39)
				local var_158_42 = var_158_40 <= 0 and var_158_36 or var_158_36 * (var_158_41 / var_158_40)

				if var_158_42 > 0 and var_158_36 < var_158_42 then
					arg_155_1.talkMaxDuration = var_158_42

					if var_158_42 + var_158_35 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_42 + var_158_35
					end
				end

				arg_155_1.text_.text = var_158_39
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261037", "story_v_out_115261.awb") ~= 0 then
					local var_158_43 = manager.audio:GetVoiceLength("story_v_out_115261", "115261037", "story_v_out_115261.awb") / 1000

					if var_158_43 + var_158_35 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_43 + var_158_35
					end

					if var_158_38.prefab_name ~= "" and arg_155_1.actors_[var_158_38.prefab_name] ~= nil then
						local var_158_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_38.prefab_name].transform, "story_v_out_115261", "115261037", "story_v_out_115261.awb")

						arg_155_1:RecordAudio("115261037", var_158_44)
						arg_155_1:RecordAudio("115261037", var_158_44)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_115261", "115261037", "story_v_out_115261.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_115261", "115261037", "story_v_out_115261.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_45 = math.max(var_158_36, arg_155_1.talkMaxDuration)

			if var_158_35 <= arg_155_1.time_ and arg_155_1.time_ < var_158_35 + var_158_45 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_35) / var_158_45

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_35 + var_158_45 and arg_155_1.time_ < var_158_35 + var_158_45 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play115261038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 115261038
		arg_159_1.duration_ = 4.4

		local var_159_0 = {
			ja = 4.4,
			ko = 2.933,
			zh = 2.366,
			en = 2.466
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
				arg_159_0:Play115261039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10030"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps10030 == nil then
				arg_159_1.var_.actorSpriteComps10030 = var_162_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_2 = 0.2

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.actorSpriteComps10030 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								local var_162_4 = Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor1.r, var_162_3)
								local var_162_5 = Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor1.g, var_162_3)
								local var_162_6 = Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor1.b, var_162_3)

								iter_162_1.color = Color.New(var_162_4, var_162_5, var_162_6)
							else
								local var_162_7 = Mathf.Lerp(iter_162_1.color.r, 1, var_162_3)

								iter_162_1.color = Color.New(var_162_7, var_162_7, var_162_7)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps10030 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_162_3 then
						if arg_159_1.isInRecall_ then
							iter_162_3.color = arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_162_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps10030 = nil
			end

			local var_162_8 = arg_159_1.actors_["1038"]
			local var_162_9 = 0

			if var_162_9 < arg_159_1.time_ and arg_159_1.time_ <= var_162_9 + arg_162_0 and not isNil(var_162_8) and arg_159_1.var_.actorSpriteComps1038 == nil then
				arg_159_1.var_.actorSpriteComps1038 = var_162_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_10 = 0.2

			if var_162_9 <= arg_159_1.time_ and arg_159_1.time_ < var_162_9 + var_162_10 and not isNil(var_162_8) then
				local var_162_11 = (arg_159_1.time_ - var_162_9) / var_162_10

				if arg_159_1.var_.actorSpriteComps1038 then
					for iter_162_4, iter_162_5 in pairs(arg_159_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_162_5 then
							if arg_159_1.isInRecall_ then
								local var_162_12 = Mathf.Lerp(iter_162_5.color.r, arg_159_1.hightColor2.r, var_162_11)
								local var_162_13 = Mathf.Lerp(iter_162_5.color.g, arg_159_1.hightColor2.g, var_162_11)
								local var_162_14 = Mathf.Lerp(iter_162_5.color.b, arg_159_1.hightColor2.b, var_162_11)

								iter_162_5.color = Color.New(var_162_12, var_162_13, var_162_14)
							else
								local var_162_15 = Mathf.Lerp(iter_162_5.color.r, 0.5, var_162_11)

								iter_162_5.color = Color.New(var_162_15, var_162_15, var_162_15)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= var_162_9 + var_162_10 and arg_159_1.time_ < var_162_9 + var_162_10 + arg_162_0 and not isNil(var_162_8) and arg_159_1.var_.actorSpriteComps1038 then
				for iter_162_6, iter_162_7 in pairs(arg_159_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_162_7 then
						if arg_159_1.isInRecall_ then
							iter_162_7.color = arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_162_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps1038 = nil
			end

			local var_162_16 = 0
			local var_162_17 = 0.175

			if var_162_16 < arg_159_1.time_ and arg_159_1.time_ <= var_162_16 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_18 = arg_159_1:FormatText(StoryNameCfg[309].name)

				arg_159_1.leftNameTxt_.text = var_162_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_19 = arg_159_1:GetWordFromCfg(115261038)
				local var_162_20 = arg_159_1:FormatText(var_162_19.content)

				arg_159_1.text_.text = var_162_20

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_21 = 7
				local var_162_22 = utf8.len(var_162_20)
				local var_162_23 = var_162_21 <= 0 and var_162_17 or var_162_17 * (var_162_22 / var_162_21)

				if var_162_23 > 0 and var_162_17 < var_162_23 then
					arg_159_1.talkMaxDuration = var_162_23

					if var_162_23 + var_162_16 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_23 + var_162_16
					end
				end

				arg_159_1.text_.text = var_162_20
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261038", "story_v_out_115261.awb") ~= 0 then
					local var_162_24 = manager.audio:GetVoiceLength("story_v_out_115261", "115261038", "story_v_out_115261.awb") / 1000

					if var_162_24 + var_162_16 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_24 + var_162_16
					end

					if var_162_19.prefab_name ~= "" and arg_159_1.actors_[var_162_19.prefab_name] ~= nil then
						local var_162_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_19.prefab_name].transform, "story_v_out_115261", "115261038", "story_v_out_115261.awb")

						arg_159_1:RecordAudio("115261038", var_162_25)
						arg_159_1:RecordAudio("115261038", var_162_25)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_115261", "115261038", "story_v_out_115261.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_115261", "115261038", "story_v_out_115261.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_26 = math.max(var_162_17, arg_159_1.talkMaxDuration)

			if var_162_16 <= arg_159_1.time_ and arg_159_1.time_ < var_162_16 + var_162_26 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_16) / var_162_26

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_16 + var_162_26 and arg_159_1.time_ < var_162_16 + var_162_26 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play115261039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 115261039
		arg_163_1.duration_ = 9.47

		local var_163_0 = {
			ja = 9.466,
			ko = 7.9,
			zh = 6.033,
			en = 8.766
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
				arg_163_0:Play115261040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.725

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[309].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_3 = arg_163_1:GetWordFromCfg(115261039)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 29
				local var_166_6 = utf8.len(var_166_4)
				local var_166_7 = var_166_5 <= 0 and var_166_1 or var_166_1 * (var_166_6 / var_166_5)

				if var_166_7 > 0 and var_166_1 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261039", "story_v_out_115261.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261039", "story_v_out_115261.awb") / 1000

					if var_166_8 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_0
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_115261", "115261039", "story_v_out_115261.awb")

						arg_163_1:RecordAudio("115261039", var_166_9)
						arg_163_1:RecordAudio("115261039", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_115261", "115261039", "story_v_out_115261.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_115261", "115261039", "story_v_out_115261.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_10 and arg_163_1.time_ < var_166_0 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play115261040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 115261040
		arg_167_1.duration_ = 15.93

		local var_167_0 = {
			ja = 15.933,
			ko = 11.033,
			zh = 9.5,
			en = 10.5
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
				arg_167_0:Play115261041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 1

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[309].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(115261040)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 40
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261040", "story_v_out_115261.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261040", "story_v_out_115261.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_115261", "115261040", "story_v_out_115261.awb")

						arg_167_1:RecordAudio("115261040", var_170_9)
						arg_167_1:RecordAudio("115261040", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_115261", "115261040", "story_v_out_115261.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_115261", "115261040", "story_v_out_115261.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play115261041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 115261041
		arg_171_1.duration_ = 6.1

		local var_171_0 = {
			ja = 4.133,
			ko = 3.633,
			zh = 3.833,
			en = 6.1
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
				arg_171_0:Play115261042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10030"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps10030 == nil then
				arg_171_1.var_.actorSpriteComps10030 = var_174_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_2 = 0.2

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.actorSpriteComps10030 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								local var_174_4 = Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor2.r, var_174_3)
								local var_174_5 = Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor2.g, var_174_3)
								local var_174_6 = Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor2.b, var_174_3)

								iter_174_1.color = Color.New(var_174_4, var_174_5, var_174_6)
							else
								local var_174_7 = Mathf.Lerp(iter_174_1.color.r, 0.5, var_174_3)

								iter_174_1.color = Color.New(var_174_7, var_174_7, var_174_7)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps10030 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_174_3 then
						if arg_171_1.isInRecall_ then
							iter_174_3.color = arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_174_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps10030 = nil
			end

			local var_174_8 = arg_171_1.actors_["1038"]
			local var_174_9 = 0

			if var_174_9 < arg_171_1.time_ and arg_171_1.time_ <= var_174_9 + arg_174_0 and not isNil(var_174_8) and arg_171_1.var_.actorSpriteComps1038 == nil then
				arg_171_1.var_.actorSpriteComps1038 = var_174_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_10 = 0.2

			if var_174_9 <= arg_171_1.time_ and arg_171_1.time_ < var_174_9 + var_174_10 and not isNil(var_174_8) then
				local var_174_11 = (arg_171_1.time_ - var_174_9) / var_174_10

				if arg_171_1.var_.actorSpriteComps1038 then
					for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_174_5 then
							if arg_171_1.isInRecall_ then
								local var_174_12 = Mathf.Lerp(iter_174_5.color.r, arg_171_1.hightColor1.r, var_174_11)
								local var_174_13 = Mathf.Lerp(iter_174_5.color.g, arg_171_1.hightColor1.g, var_174_11)
								local var_174_14 = Mathf.Lerp(iter_174_5.color.b, arg_171_1.hightColor1.b, var_174_11)

								iter_174_5.color = Color.New(var_174_12, var_174_13, var_174_14)
							else
								local var_174_15 = Mathf.Lerp(iter_174_5.color.r, 1, var_174_11)

								iter_174_5.color = Color.New(var_174_15, var_174_15, var_174_15)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_9 + var_174_10 and arg_171_1.time_ < var_174_9 + var_174_10 + arg_174_0 and not isNil(var_174_8) and arg_171_1.var_.actorSpriteComps1038 then
				for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_174_7 then
						if arg_171_1.isInRecall_ then
							iter_174_7.color = arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_174_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps1038 = nil
			end

			local var_174_16 = 0
			local var_174_17 = 0.325

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_18 = arg_171_1:FormatText(StoryNameCfg[94].name)

				arg_171_1.leftNameTxt_.text = var_174_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_19 = arg_171_1:GetWordFromCfg(115261041)
				local var_174_20 = arg_171_1:FormatText(var_174_19.content)

				arg_171_1.text_.text = var_174_20

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_21 = 13
				local var_174_22 = utf8.len(var_174_20)
				local var_174_23 = var_174_21 <= 0 and var_174_17 or var_174_17 * (var_174_22 / var_174_21)

				if var_174_23 > 0 and var_174_17 < var_174_23 then
					arg_171_1.talkMaxDuration = var_174_23

					if var_174_23 + var_174_16 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_23 + var_174_16
					end
				end

				arg_171_1.text_.text = var_174_20
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261041", "story_v_out_115261.awb") ~= 0 then
					local var_174_24 = manager.audio:GetVoiceLength("story_v_out_115261", "115261041", "story_v_out_115261.awb") / 1000

					if var_174_24 + var_174_16 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_24 + var_174_16
					end

					if var_174_19.prefab_name ~= "" and arg_171_1.actors_[var_174_19.prefab_name] ~= nil then
						local var_174_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_19.prefab_name].transform, "story_v_out_115261", "115261041", "story_v_out_115261.awb")

						arg_171_1:RecordAudio("115261041", var_174_25)
						arg_171_1:RecordAudio("115261041", var_174_25)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_115261", "115261041", "story_v_out_115261.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_115261", "115261041", "story_v_out_115261.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_26 = math.max(var_174_17, arg_171_1.talkMaxDuration)

			if var_174_16 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_26 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_16) / var_174_26

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_16 + var_174_26 and arg_171_1.time_ < var_174_16 + var_174_26 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play115261042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 115261042
		arg_175_1.duration_ = 12.3

		local var_175_0 = {
			ja = 12.3,
			ko = 10.366,
			zh = 8.2,
			en = 10.2
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
				arg_175_0:Play115261043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10030"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.actorSpriteComps10030 == nil then
				arg_175_1.var_.actorSpriteComps10030 = var_178_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_2 = 0.2

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.actorSpriteComps10030 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_178_1 then
							if arg_175_1.isInRecall_ then
								local var_178_4 = Mathf.Lerp(iter_178_1.color.r, arg_175_1.hightColor1.r, var_178_3)
								local var_178_5 = Mathf.Lerp(iter_178_1.color.g, arg_175_1.hightColor1.g, var_178_3)
								local var_178_6 = Mathf.Lerp(iter_178_1.color.b, arg_175_1.hightColor1.b, var_178_3)

								iter_178_1.color = Color.New(var_178_4, var_178_5, var_178_6)
							else
								local var_178_7 = Mathf.Lerp(iter_178_1.color.r, 1, var_178_3)

								iter_178_1.color = Color.New(var_178_7, var_178_7, var_178_7)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.actorSpriteComps10030 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_178_3 then
						if arg_175_1.isInRecall_ then
							iter_178_3.color = arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_178_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps10030 = nil
			end

			local var_178_8 = arg_175_1.actors_["1038"]
			local var_178_9 = 0

			if var_178_9 < arg_175_1.time_ and arg_175_1.time_ <= var_178_9 + arg_178_0 and not isNil(var_178_8) and arg_175_1.var_.actorSpriteComps1038 == nil then
				arg_175_1.var_.actorSpriteComps1038 = var_178_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_10 = 0.2

			if var_178_9 <= arg_175_1.time_ and arg_175_1.time_ < var_178_9 + var_178_10 and not isNil(var_178_8) then
				local var_178_11 = (arg_175_1.time_ - var_178_9) / var_178_10

				if arg_175_1.var_.actorSpriteComps1038 then
					for iter_178_4, iter_178_5 in pairs(arg_175_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_178_5 then
							if arg_175_1.isInRecall_ then
								local var_178_12 = Mathf.Lerp(iter_178_5.color.r, arg_175_1.hightColor2.r, var_178_11)
								local var_178_13 = Mathf.Lerp(iter_178_5.color.g, arg_175_1.hightColor2.g, var_178_11)
								local var_178_14 = Mathf.Lerp(iter_178_5.color.b, arg_175_1.hightColor2.b, var_178_11)

								iter_178_5.color = Color.New(var_178_12, var_178_13, var_178_14)
							else
								local var_178_15 = Mathf.Lerp(iter_178_5.color.r, 0.5, var_178_11)

								iter_178_5.color = Color.New(var_178_15, var_178_15, var_178_15)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_9 + var_178_10 and arg_175_1.time_ < var_178_9 + var_178_10 + arg_178_0 and not isNil(var_178_8) and arg_175_1.var_.actorSpriteComps1038 then
				for iter_178_6, iter_178_7 in pairs(arg_175_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_178_7 then
						if arg_175_1.isInRecall_ then
							iter_178_7.color = arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_178_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps1038 = nil
			end

			local var_178_16 = 0
			local var_178_17 = 0.95

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_18 = arg_175_1:FormatText(StoryNameCfg[309].name)

				arg_175_1.leftNameTxt_.text = var_178_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_19 = arg_175_1:GetWordFromCfg(115261042)
				local var_178_20 = arg_175_1:FormatText(var_178_19.content)

				arg_175_1.text_.text = var_178_20

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_21 = 38
				local var_178_22 = utf8.len(var_178_20)
				local var_178_23 = var_178_21 <= 0 and var_178_17 or var_178_17 * (var_178_22 / var_178_21)

				if var_178_23 > 0 and var_178_17 < var_178_23 then
					arg_175_1.talkMaxDuration = var_178_23

					if var_178_23 + var_178_16 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_23 + var_178_16
					end
				end

				arg_175_1.text_.text = var_178_20
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261042", "story_v_out_115261.awb") ~= 0 then
					local var_178_24 = manager.audio:GetVoiceLength("story_v_out_115261", "115261042", "story_v_out_115261.awb") / 1000

					if var_178_24 + var_178_16 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_24 + var_178_16
					end

					if var_178_19.prefab_name ~= "" and arg_175_1.actors_[var_178_19.prefab_name] ~= nil then
						local var_178_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_19.prefab_name].transform, "story_v_out_115261", "115261042", "story_v_out_115261.awb")

						arg_175_1:RecordAudio("115261042", var_178_25)
						arg_175_1:RecordAudio("115261042", var_178_25)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_115261", "115261042", "story_v_out_115261.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_115261", "115261042", "story_v_out_115261.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_26 = math.max(var_178_17, arg_175_1.talkMaxDuration)

			if var_178_16 <= arg_175_1.time_ and arg_175_1.time_ < var_178_16 + var_178_26 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_16) / var_178_26

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_16 + var_178_26 and arg_175_1.time_ < var_178_16 + var_178_26 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play115261043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 115261043
		arg_179_1.duration_ = 12

		local var_179_0 = {
			ja = 7.866,
			ko = 10.7,
			zh = 9.7,
			en = 12
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
				arg_179_0:Play115261044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10030"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps10030 == nil then
				arg_179_1.var_.actorSpriteComps10030 = var_182_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_2 = 0.2

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.actorSpriteComps10030 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								local var_182_4 = Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor2.r, var_182_3)
								local var_182_5 = Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor2.g, var_182_3)
								local var_182_6 = Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor2.b, var_182_3)

								iter_182_1.color = Color.New(var_182_4, var_182_5, var_182_6)
							else
								local var_182_7 = Mathf.Lerp(iter_182_1.color.r, 0.5, var_182_3)

								iter_182_1.color = Color.New(var_182_7, var_182_7, var_182_7)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps10030 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_182_3 then
						if arg_179_1.isInRecall_ then
							iter_182_3.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps10030 = nil
			end

			local var_182_8 = arg_179_1.actors_["1038"]
			local var_182_9 = 0

			if var_182_9 < arg_179_1.time_ and arg_179_1.time_ <= var_182_9 + arg_182_0 and not isNil(var_182_8) and arg_179_1.var_.actorSpriteComps1038 == nil then
				arg_179_1.var_.actorSpriteComps1038 = var_182_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_10 = 0.2

			if var_182_9 <= arg_179_1.time_ and arg_179_1.time_ < var_182_9 + var_182_10 and not isNil(var_182_8) then
				local var_182_11 = (arg_179_1.time_ - var_182_9) / var_182_10

				if arg_179_1.var_.actorSpriteComps1038 then
					for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_182_5 then
							if arg_179_1.isInRecall_ then
								local var_182_12 = Mathf.Lerp(iter_182_5.color.r, arg_179_1.hightColor1.r, var_182_11)
								local var_182_13 = Mathf.Lerp(iter_182_5.color.g, arg_179_1.hightColor1.g, var_182_11)
								local var_182_14 = Mathf.Lerp(iter_182_5.color.b, arg_179_1.hightColor1.b, var_182_11)

								iter_182_5.color = Color.New(var_182_12, var_182_13, var_182_14)
							else
								local var_182_15 = Mathf.Lerp(iter_182_5.color.r, 1, var_182_11)

								iter_182_5.color = Color.New(var_182_15, var_182_15, var_182_15)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_9 + var_182_10 and arg_179_1.time_ < var_182_9 + var_182_10 + arg_182_0 and not isNil(var_182_8) and arg_179_1.var_.actorSpriteComps1038 then
				for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_182_7 then
						if arg_179_1.isInRecall_ then
							iter_182_7.color = arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_182_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps1038 = nil
			end

			local var_182_16 = 0
			local var_182_17 = 0.875

			if var_182_16 < arg_179_1.time_ and arg_179_1.time_ <= var_182_16 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_18 = arg_179_1:FormatText(StoryNameCfg[94].name)

				arg_179_1.leftNameTxt_.text = var_182_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_19 = arg_179_1:GetWordFromCfg(115261043)
				local var_182_20 = arg_179_1:FormatText(var_182_19.content)

				arg_179_1.text_.text = var_182_20

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_21 = 35
				local var_182_22 = utf8.len(var_182_20)
				local var_182_23 = var_182_21 <= 0 and var_182_17 or var_182_17 * (var_182_22 / var_182_21)

				if var_182_23 > 0 and var_182_17 < var_182_23 then
					arg_179_1.talkMaxDuration = var_182_23

					if var_182_23 + var_182_16 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_23 + var_182_16
					end
				end

				arg_179_1.text_.text = var_182_20
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261043", "story_v_out_115261.awb") ~= 0 then
					local var_182_24 = manager.audio:GetVoiceLength("story_v_out_115261", "115261043", "story_v_out_115261.awb") / 1000

					if var_182_24 + var_182_16 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_24 + var_182_16
					end

					if var_182_19.prefab_name ~= "" and arg_179_1.actors_[var_182_19.prefab_name] ~= nil then
						local var_182_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_19.prefab_name].transform, "story_v_out_115261", "115261043", "story_v_out_115261.awb")

						arg_179_1:RecordAudio("115261043", var_182_25)
						arg_179_1:RecordAudio("115261043", var_182_25)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_115261", "115261043", "story_v_out_115261.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_115261", "115261043", "story_v_out_115261.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_26 = math.max(var_182_17, arg_179_1.talkMaxDuration)

			if var_182_16 <= arg_179_1.time_ and arg_179_1.time_ < var_182_16 + var_182_26 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_16) / var_182_26

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_16 + var_182_26 and arg_179_1.time_ < var_182_16 + var_182_26 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play115261044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 115261044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play115261045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10030"].transform
			local var_186_1 = 0.5

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos10030 = var_186_0.localPosition
				var_186_0.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10030", 0)

				local var_186_2 = var_186_0.childCount

				for iter_186_0 = 0, var_186_2 - 1 do
					local var_186_3 = var_186_0:GetChild(iter_186_0)

					if var_186_3.name == "split_3" or not string.find(var_186_3.name, "split") then
						var_186_3.gameObject:SetActive(true)
					else
						var_186_3.gameObject:SetActive(false)
					end
				end
			end

			local var_186_4 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_4 then
				local var_186_5 = (arg_183_1.time_ - var_186_1) / var_186_4
				local var_186_6 = Vector3.New(-2000, -390, 150)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10030, var_186_6, var_186_5)
			end

			if arg_183_1.time_ >= var_186_1 + var_186_4 and arg_183_1.time_ < var_186_1 + var_186_4 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(-2000, -390, 150)
			end

			local var_186_7 = arg_183_1.actors_["1038"].transform
			local var_186_8 = 0.5

			if var_186_8 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.var_.moveOldPos1038 = var_186_7.localPosition
				var_186_7.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1038", 0)

				local var_186_9 = var_186_7.childCount

				for iter_186_1 = 0, var_186_9 - 1 do
					local var_186_10 = var_186_7:GetChild(iter_186_1)

					if var_186_10.name == "split_1" or not string.find(var_186_10.name, "split") then
						var_186_10.gameObject:SetActive(true)
					else
						var_186_10.gameObject:SetActive(false)
					end
				end
			end

			local var_186_11 = 0.001

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_11 then
				local var_186_12 = (arg_183_1.time_ - var_186_8) / var_186_11
				local var_186_13 = Vector3.New(-2000, -400, 0)

				var_186_7.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1038, var_186_13, var_186_12)
			end

			if arg_183_1.time_ >= var_186_8 + var_186_11 and arg_183_1.time_ < var_186_8 + var_186_11 + arg_186_0 then
				var_186_7.localPosition = Vector3.New(-2000, -400, 0)
			end

			local var_186_14 = arg_183_1.actors_["10030"]
			local var_186_15 = 0

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				local var_186_16 = var_186_14:GetComponentInChildren(typeof(CanvasGroup))

				if var_186_16 then
					arg_183_1.var_.alphaOldValue10030 = var_186_16.alpha
					arg_183_1.var_.characterEffect10030 = var_186_16
				end

				arg_183_1.var_.alphaOldValue10030 = 1
			end

			local var_186_17 = 0.5

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_17 then
				local var_186_18 = (arg_183_1.time_ - var_186_15) / var_186_17
				local var_186_19 = Mathf.Lerp(arg_183_1.var_.alphaOldValue10030, 0, var_186_18)

				if arg_183_1.var_.characterEffect10030 then
					arg_183_1.var_.characterEffect10030.alpha = var_186_19
				end
			end

			if arg_183_1.time_ >= var_186_15 + var_186_17 and arg_183_1.time_ < var_186_15 + var_186_17 + arg_186_0 and arg_183_1.var_.characterEffect10030 then
				arg_183_1.var_.characterEffect10030.alpha = 0
			end

			local var_186_20 = arg_183_1.actors_["1038"]
			local var_186_21 = 0

			if var_186_21 < arg_183_1.time_ and arg_183_1.time_ <= var_186_21 + arg_186_0 then
				local var_186_22 = var_186_20:GetComponentInChildren(typeof(CanvasGroup))

				if var_186_22 then
					arg_183_1.var_.alphaOldValue1038 = var_186_22.alpha
					arg_183_1.var_.characterEffect1038 = var_186_22
				end

				arg_183_1.var_.alphaOldValue1038 = 1
			end

			local var_186_23 = 0.5

			if var_186_21 <= arg_183_1.time_ and arg_183_1.time_ < var_186_21 + var_186_23 then
				local var_186_24 = (arg_183_1.time_ - var_186_21) / var_186_23
				local var_186_25 = Mathf.Lerp(arg_183_1.var_.alphaOldValue1038, 0, var_186_24)

				if arg_183_1.var_.characterEffect1038 then
					arg_183_1.var_.characterEffect1038.alpha = var_186_25
				end
			end

			if arg_183_1.time_ >= var_186_21 + var_186_23 and arg_183_1.time_ < var_186_21 + var_186_23 + arg_186_0 and arg_183_1.var_.characterEffect1038 then
				arg_183_1.var_.characterEffect1038.alpha = 0
			end

			local var_186_26 = 0
			local var_186_27 = 1.175

			if var_186_26 < arg_183_1.time_ and arg_183_1.time_ <= var_186_26 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_28 = arg_183_1:GetWordFromCfg(115261044)
				local var_186_29 = arg_183_1:FormatText(var_186_28.content)

				arg_183_1.text_.text = var_186_29

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_30 = 47
				local var_186_31 = utf8.len(var_186_29)
				local var_186_32 = var_186_30 <= 0 and var_186_27 or var_186_27 * (var_186_31 / var_186_30)

				if var_186_32 > 0 and var_186_27 < var_186_32 then
					arg_183_1.talkMaxDuration = var_186_32

					if var_186_32 + var_186_26 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_32 + var_186_26
					end
				end

				arg_183_1.text_.text = var_186_29
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_33 = math.max(var_186_27, arg_183_1.talkMaxDuration)

			if var_186_26 <= arg_183_1.time_ and arg_183_1.time_ < var_186_26 + var_186_33 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_26) / var_186_33

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_26 + var_186_33 and arg_183_1.time_ < var_186_26 + var_186_33 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play115261045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 115261045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play115261046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 1.225

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

				local var_190_2 = arg_187_1:GetWordFromCfg(115261045)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 49
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
	Play115261046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 115261046
		arg_191_1.duration_ = 6.87

		local var_191_0 = {
			ja = 4.533,
			ko = 6.2,
			zh = 5.166,
			en = 6.866
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
				arg_191_0:Play115261047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10030"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos10030 = var_194_0.localPosition
				var_194_0.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10030", 4)

				local var_194_2 = var_194_0.childCount

				for iter_194_0 = 0, var_194_2 - 1 do
					local var_194_3 = var_194_0:GetChild(iter_194_0)

					if var_194_3.name == "split_3" or not string.find(var_194_3.name, "split") then
						var_194_3.gameObject:SetActive(true)
					else
						var_194_3.gameObject:SetActive(false)
					end
				end
			end

			local var_194_4 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_4 then
				local var_194_5 = (arg_191_1.time_ - var_194_1) / var_194_4
				local var_194_6 = Vector3.New(390, -390, 150)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10030, var_194_6, var_194_5)
			end

			if arg_191_1.time_ >= var_194_1 + var_194_4 and arg_191_1.time_ < var_194_1 + var_194_4 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_194_7 = arg_191_1.actors_["10030"]
			local var_194_8 = 0

			if var_194_8 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 and not isNil(var_194_7) and arg_191_1.var_.actorSpriteComps10030 == nil then
				arg_191_1.var_.actorSpriteComps10030 = var_194_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_9 = 0.2

			if var_194_8 <= arg_191_1.time_ and arg_191_1.time_ < var_194_8 + var_194_9 and not isNil(var_194_7) then
				local var_194_10 = (arg_191_1.time_ - var_194_8) / var_194_9

				if arg_191_1.var_.actorSpriteComps10030 then
					for iter_194_1, iter_194_2 in pairs(arg_191_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_194_2 then
							if arg_191_1.isInRecall_ then
								local var_194_11 = Mathf.Lerp(iter_194_2.color.r, arg_191_1.hightColor1.r, var_194_10)
								local var_194_12 = Mathf.Lerp(iter_194_2.color.g, arg_191_1.hightColor1.g, var_194_10)
								local var_194_13 = Mathf.Lerp(iter_194_2.color.b, arg_191_1.hightColor1.b, var_194_10)

								iter_194_2.color = Color.New(var_194_11, var_194_12, var_194_13)
							else
								local var_194_14 = Mathf.Lerp(iter_194_2.color.r, 1, var_194_10)

								iter_194_2.color = Color.New(var_194_14, var_194_14, var_194_14)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= var_194_8 + var_194_9 and arg_191_1.time_ < var_194_8 + var_194_9 + arg_194_0 and not isNil(var_194_7) and arg_191_1.var_.actorSpriteComps10030 then
				for iter_194_3, iter_194_4 in pairs(arg_191_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_194_4 then
						if arg_191_1.isInRecall_ then
							iter_194_4.color = arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_194_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps10030 = nil
			end

			local var_194_15 = arg_191_1.actors_["10030"]
			local var_194_16 = 0

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 then
				local var_194_17 = var_194_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_194_17 then
					arg_191_1.var_.alphaOldValue10030 = var_194_17.alpha
					arg_191_1.var_.characterEffect10030 = var_194_17
				end

				arg_191_1.var_.alphaOldValue10030 = 0
			end

			local var_194_18 = 0.5

			if var_194_16 <= arg_191_1.time_ and arg_191_1.time_ < var_194_16 + var_194_18 then
				local var_194_19 = (arg_191_1.time_ - var_194_16) / var_194_18
				local var_194_20 = Mathf.Lerp(arg_191_1.var_.alphaOldValue10030, 1, var_194_19)

				if arg_191_1.var_.characterEffect10030 then
					arg_191_1.var_.characterEffect10030.alpha = var_194_20
				end
			end

			if arg_191_1.time_ >= var_194_16 + var_194_18 and arg_191_1.time_ < var_194_16 + var_194_18 + arg_194_0 and arg_191_1.var_.characterEffect10030 then
				arg_191_1.var_.characterEffect10030.alpha = 1
			end

			local var_194_21 = 0
			local var_194_22 = 0.65

			if var_194_21 < arg_191_1.time_ and arg_191_1.time_ <= var_194_21 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_23 = arg_191_1:FormatText(StoryNameCfg[309].name)

				arg_191_1.leftNameTxt_.text = var_194_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_24 = arg_191_1:GetWordFromCfg(115261046)
				local var_194_25 = arg_191_1:FormatText(var_194_24.content)

				arg_191_1.text_.text = var_194_25

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_26 = 26
				local var_194_27 = utf8.len(var_194_25)
				local var_194_28 = var_194_26 <= 0 and var_194_22 or var_194_22 * (var_194_27 / var_194_26)

				if var_194_28 > 0 and var_194_22 < var_194_28 then
					arg_191_1.talkMaxDuration = var_194_28

					if var_194_28 + var_194_21 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_28 + var_194_21
					end
				end

				arg_191_1.text_.text = var_194_25
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261046", "story_v_out_115261.awb") ~= 0 then
					local var_194_29 = manager.audio:GetVoiceLength("story_v_out_115261", "115261046", "story_v_out_115261.awb") / 1000

					if var_194_29 + var_194_21 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_29 + var_194_21
					end

					if var_194_24.prefab_name ~= "" and arg_191_1.actors_[var_194_24.prefab_name] ~= nil then
						local var_194_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_24.prefab_name].transform, "story_v_out_115261", "115261046", "story_v_out_115261.awb")

						arg_191_1:RecordAudio("115261046", var_194_30)
						arg_191_1:RecordAudio("115261046", var_194_30)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_115261", "115261046", "story_v_out_115261.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_115261", "115261046", "story_v_out_115261.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_31 = math.max(var_194_22, arg_191_1.talkMaxDuration)

			if var_194_21 <= arg_191_1.time_ and arg_191_1.time_ < var_194_21 + var_194_31 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_21) / var_194_31

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_21 + var_194_31 and arg_191_1.time_ < var_194_21 + var_194_31 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play115261047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 115261047
		arg_195_1.duration_ = 13

		local var_195_0 = {
			ja = 12.933,
			ko = 11.533,
			zh = 13,
			en = 12.933
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
				arg_195_0:Play115261048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10030"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps10030 == nil then
				arg_195_1.var_.actorSpriteComps10030 = var_198_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_2 = 0.2

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.actorSpriteComps10030 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_198_1 then
							if arg_195_1.isInRecall_ then
								local var_198_4 = Mathf.Lerp(iter_198_1.color.r, arg_195_1.hightColor2.r, var_198_3)
								local var_198_5 = Mathf.Lerp(iter_198_1.color.g, arg_195_1.hightColor2.g, var_198_3)
								local var_198_6 = Mathf.Lerp(iter_198_1.color.b, arg_195_1.hightColor2.b, var_198_3)

								iter_198_1.color = Color.New(var_198_4, var_198_5, var_198_6)
							else
								local var_198_7 = Mathf.Lerp(iter_198_1.color.r, 0.5, var_198_3)

								iter_198_1.color = Color.New(var_198_7, var_198_7, var_198_7)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps10030 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_198_3 then
						if arg_195_1.isInRecall_ then
							iter_198_3.color = arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_198_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps10030 = nil
			end

			local var_198_8 = arg_195_1.actors_["1038"].transform
			local var_198_9 = 0

			if var_198_9 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 then
				arg_195_1.var_.moveOldPos1038 = var_198_8.localPosition
				var_198_8.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1038", 2)

				local var_198_10 = var_198_8.childCount

				for iter_198_4 = 0, var_198_10 - 1 do
					local var_198_11 = var_198_8:GetChild(iter_198_4)

					if var_198_11.name == "split_1" or not string.find(var_198_11.name, "split") then
						var_198_11.gameObject:SetActive(true)
					else
						var_198_11.gameObject:SetActive(false)
					end
				end
			end

			local var_198_12 = 0.001

			if var_198_9 <= arg_195_1.time_ and arg_195_1.time_ < var_198_9 + var_198_12 then
				local var_198_13 = (arg_195_1.time_ - var_198_9) / var_198_12
				local var_198_14 = Vector3.New(-390, -400, 0)

				var_198_8.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1038, var_198_14, var_198_13)
			end

			if arg_195_1.time_ >= var_198_9 + var_198_12 and arg_195_1.time_ < var_198_9 + var_198_12 + arg_198_0 then
				var_198_8.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_198_15 = arg_195_1.actors_["1038"]
			local var_198_16 = 0

			if var_198_16 < arg_195_1.time_ and arg_195_1.time_ <= var_198_16 + arg_198_0 and not isNil(var_198_15) and arg_195_1.var_.actorSpriteComps1038 == nil then
				arg_195_1.var_.actorSpriteComps1038 = var_198_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_17 = 0.2

			if var_198_16 <= arg_195_1.time_ and arg_195_1.time_ < var_198_16 + var_198_17 and not isNil(var_198_15) then
				local var_198_18 = (arg_195_1.time_ - var_198_16) / var_198_17

				if arg_195_1.var_.actorSpriteComps1038 then
					for iter_198_5, iter_198_6 in pairs(arg_195_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_198_6 then
							if arg_195_1.isInRecall_ then
								local var_198_19 = Mathf.Lerp(iter_198_6.color.r, arg_195_1.hightColor1.r, var_198_18)
								local var_198_20 = Mathf.Lerp(iter_198_6.color.g, arg_195_1.hightColor1.g, var_198_18)
								local var_198_21 = Mathf.Lerp(iter_198_6.color.b, arg_195_1.hightColor1.b, var_198_18)

								iter_198_6.color = Color.New(var_198_19, var_198_20, var_198_21)
							else
								local var_198_22 = Mathf.Lerp(iter_198_6.color.r, 1, var_198_18)

								iter_198_6.color = Color.New(var_198_22, var_198_22, var_198_22)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_16 + var_198_17 and arg_195_1.time_ < var_198_16 + var_198_17 + arg_198_0 and not isNil(var_198_15) and arg_195_1.var_.actorSpriteComps1038 then
				for iter_198_7, iter_198_8 in pairs(arg_195_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_198_8 then
						if arg_195_1.isInRecall_ then
							iter_198_8.color = arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_198_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps1038 = nil
			end

			local var_198_23 = arg_195_1.actors_["1038"]
			local var_198_24 = 0

			if var_198_24 < arg_195_1.time_ and arg_195_1.time_ <= var_198_24 + arg_198_0 then
				local var_198_25 = var_198_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_198_25 then
					arg_195_1.var_.alphaOldValue1038 = var_198_25.alpha
					arg_195_1.var_.characterEffect1038 = var_198_25
				end

				arg_195_1.var_.alphaOldValue1038 = 0
			end

			local var_198_26 = 0.5

			if var_198_24 <= arg_195_1.time_ and arg_195_1.time_ < var_198_24 + var_198_26 then
				local var_198_27 = (arg_195_1.time_ - var_198_24) / var_198_26
				local var_198_28 = Mathf.Lerp(arg_195_1.var_.alphaOldValue1038, 1, var_198_27)

				if arg_195_1.var_.characterEffect1038 then
					arg_195_1.var_.characterEffect1038.alpha = var_198_28
				end
			end

			if arg_195_1.time_ >= var_198_24 + var_198_26 and arg_195_1.time_ < var_198_24 + var_198_26 + arg_198_0 and arg_195_1.var_.characterEffect1038 then
				arg_195_1.var_.characterEffect1038.alpha = 1
			end

			local var_198_29 = arg_195_1.actors_["10030"]
			local var_198_30 = 0

			if var_198_30 < arg_195_1.time_ and arg_195_1.time_ <= var_198_30 + arg_198_0 then
				local var_198_31 = var_198_29:GetComponentInChildren(typeof(CanvasGroup))

				if var_198_31 then
					arg_195_1.var_.alphaOldValue10030 = var_198_31.alpha
					arg_195_1.var_.characterEffect10030 = var_198_31
				end

				arg_195_1.var_.alphaOldValue10030 = 0
			end

			local var_198_32 = 0.0166666666666667

			if var_198_30 <= arg_195_1.time_ and arg_195_1.time_ < var_198_30 + var_198_32 then
				local var_198_33 = (arg_195_1.time_ - var_198_30) / var_198_32
				local var_198_34 = Mathf.Lerp(arg_195_1.var_.alphaOldValue10030, 1, var_198_33)

				if arg_195_1.var_.characterEffect10030 then
					arg_195_1.var_.characterEffect10030.alpha = var_198_34
				end
			end

			if arg_195_1.time_ >= var_198_30 + var_198_32 and arg_195_1.time_ < var_198_30 + var_198_32 + arg_198_0 and arg_195_1.var_.characterEffect10030 then
				arg_195_1.var_.characterEffect10030.alpha = 1
			end

			local var_198_35 = 0
			local var_198_36 = 1.225

			if var_198_35 < arg_195_1.time_ and arg_195_1.time_ <= var_198_35 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_37 = arg_195_1:FormatText(StoryNameCfg[94].name)

				arg_195_1.leftNameTxt_.text = var_198_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_38 = arg_195_1:GetWordFromCfg(115261047)
				local var_198_39 = arg_195_1:FormatText(var_198_38.content)

				arg_195_1.text_.text = var_198_39

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_40 = 49
				local var_198_41 = utf8.len(var_198_39)
				local var_198_42 = var_198_40 <= 0 and var_198_36 or var_198_36 * (var_198_41 / var_198_40)

				if var_198_42 > 0 and var_198_36 < var_198_42 then
					arg_195_1.talkMaxDuration = var_198_42

					if var_198_42 + var_198_35 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_42 + var_198_35
					end
				end

				arg_195_1.text_.text = var_198_39
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261047", "story_v_out_115261.awb") ~= 0 then
					local var_198_43 = manager.audio:GetVoiceLength("story_v_out_115261", "115261047", "story_v_out_115261.awb") / 1000

					if var_198_43 + var_198_35 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_43 + var_198_35
					end

					if var_198_38.prefab_name ~= "" and arg_195_1.actors_[var_198_38.prefab_name] ~= nil then
						local var_198_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_38.prefab_name].transform, "story_v_out_115261", "115261047", "story_v_out_115261.awb")

						arg_195_1:RecordAudio("115261047", var_198_44)
						arg_195_1:RecordAudio("115261047", var_198_44)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_115261", "115261047", "story_v_out_115261.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_115261", "115261047", "story_v_out_115261.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_45 = math.max(var_198_36, arg_195_1.talkMaxDuration)

			if var_198_35 <= arg_195_1.time_ and arg_195_1.time_ < var_198_35 + var_198_45 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_35) / var_198_45

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_35 + var_198_45 and arg_195_1.time_ < var_198_35 + var_198_45 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play115261048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 115261048
		arg_199_1.duration_ = 8.5

		local var_199_0 = {
			ja = 8.5,
			ko = 5.1,
			zh = 4,
			en = 6.433
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
				arg_199_0:Play115261049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10030"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps10030 == nil then
				arg_199_1.var_.actorSpriteComps10030 = var_202_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_2 = 0.2

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.actorSpriteComps10030 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								local var_202_4 = Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor1.r, var_202_3)
								local var_202_5 = Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor1.g, var_202_3)
								local var_202_6 = Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor1.b, var_202_3)

								iter_202_1.color = Color.New(var_202_4, var_202_5, var_202_6)
							else
								local var_202_7 = Mathf.Lerp(iter_202_1.color.r, 1, var_202_3)

								iter_202_1.color = Color.New(var_202_7, var_202_7, var_202_7)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps10030 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_202_3 then
						if arg_199_1.isInRecall_ then
							iter_202_3.color = arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_202_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps10030 = nil
			end

			local var_202_8 = arg_199_1.actors_["1038"]
			local var_202_9 = 0

			if var_202_9 < arg_199_1.time_ and arg_199_1.time_ <= var_202_9 + arg_202_0 and not isNil(var_202_8) and arg_199_1.var_.actorSpriteComps1038 == nil then
				arg_199_1.var_.actorSpriteComps1038 = var_202_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_10 = 0.2

			if var_202_9 <= arg_199_1.time_ and arg_199_1.time_ < var_202_9 + var_202_10 and not isNil(var_202_8) then
				local var_202_11 = (arg_199_1.time_ - var_202_9) / var_202_10

				if arg_199_1.var_.actorSpriteComps1038 then
					for iter_202_4, iter_202_5 in pairs(arg_199_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_202_5 then
							if arg_199_1.isInRecall_ then
								local var_202_12 = Mathf.Lerp(iter_202_5.color.r, arg_199_1.hightColor2.r, var_202_11)
								local var_202_13 = Mathf.Lerp(iter_202_5.color.g, arg_199_1.hightColor2.g, var_202_11)
								local var_202_14 = Mathf.Lerp(iter_202_5.color.b, arg_199_1.hightColor2.b, var_202_11)

								iter_202_5.color = Color.New(var_202_12, var_202_13, var_202_14)
							else
								local var_202_15 = Mathf.Lerp(iter_202_5.color.r, 0.5, var_202_11)

								iter_202_5.color = Color.New(var_202_15, var_202_15, var_202_15)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_9 + var_202_10 and arg_199_1.time_ < var_202_9 + var_202_10 + arg_202_0 and not isNil(var_202_8) and arg_199_1.var_.actorSpriteComps1038 then
				for iter_202_6, iter_202_7 in pairs(arg_199_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_202_7 then
						if arg_199_1.isInRecall_ then
							iter_202_7.color = arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_202_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps1038 = nil
			end

			local var_202_16 = arg_199_1.actors_["10030"].transform
			local var_202_17 = 0

			if var_202_17 < arg_199_1.time_ and arg_199_1.time_ <= var_202_17 + arg_202_0 then
				arg_199_1.var_.moveOldPos10030 = var_202_16.localPosition
				var_202_16.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10030", 4)

				local var_202_18 = var_202_16.childCount

				for iter_202_8 = 0, var_202_18 - 1 do
					local var_202_19 = var_202_16:GetChild(iter_202_8)

					if var_202_19.name == "split_1" or not string.find(var_202_19.name, "split") then
						var_202_19.gameObject:SetActive(true)
					else
						var_202_19.gameObject:SetActive(false)
					end
				end
			end

			local var_202_20 = 0.001

			if var_202_17 <= arg_199_1.time_ and arg_199_1.time_ < var_202_17 + var_202_20 then
				local var_202_21 = (arg_199_1.time_ - var_202_17) / var_202_20
				local var_202_22 = Vector3.New(390, -390, 150)

				var_202_16.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10030, var_202_22, var_202_21)
			end

			if arg_199_1.time_ >= var_202_17 + var_202_20 and arg_199_1.time_ < var_202_17 + var_202_20 + arg_202_0 then
				var_202_16.localPosition = Vector3.New(390, -390, 150)
			end

			local var_202_23 = 0
			local var_202_24 = 0.45

			if var_202_23 < arg_199_1.time_ and arg_199_1.time_ <= var_202_23 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_25 = arg_199_1:FormatText(StoryNameCfg[309].name)

				arg_199_1.leftNameTxt_.text = var_202_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_26 = arg_199_1:GetWordFromCfg(115261048)
				local var_202_27 = arg_199_1:FormatText(var_202_26.content)

				arg_199_1.text_.text = var_202_27

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_28 = 18
				local var_202_29 = utf8.len(var_202_27)
				local var_202_30 = var_202_28 <= 0 and var_202_24 or var_202_24 * (var_202_29 / var_202_28)

				if var_202_30 > 0 and var_202_24 < var_202_30 then
					arg_199_1.talkMaxDuration = var_202_30

					if var_202_30 + var_202_23 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_30 + var_202_23
					end
				end

				arg_199_1.text_.text = var_202_27
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261048", "story_v_out_115261.awb") ~= 0 then
					local var_202_31 = manager.audio:GetVoiceLength("story_v_out_115261", "115261048", "story_v_out_115261.awb") / 1000

					if var_202_31 + var_202_23 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_31 + var_202_23
					end

					if var_202_26.prefab_name ~= "" and arg_199_1.actors_[var_202_26.prefab_name] ~= nil then
						local var_202_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_26.prefab_name].transform, "story_v_out_115261", "115261048", "story_v_out_115261.awb")

						arg_199_1:RecordAudio("115261048", var_202_32)
						arg_199_1:RecordAudio("115261048", var_202_32)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_115261", "115261048", "story_v_out_115261.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_115261", "115261048", "story_v_out_115261.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_33 = math.max(var_202_24, arg_199_1.talkMaxDuration)

			if var_202_23 <= arg_199_1.time_ and arg_199_1.time_ < var_202_23 + var_202_33 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_23) / var_202_33

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_23 + var_202_33 and arg_199_1.time_ < var_202_23 + var_202_33 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play115261049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 115261049
		arg_203_1.duration_ = 11.1

		local var_203_0 = {
			ja = 11.1,
			ko = 8.966,
			zh = 8.733,
			en = 8.8
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
				arg_203_0:Play115261050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10030"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps10030 == nil then
				arg_203_1.var_.actorSpriteComps10030 = var_206_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_2 = 0.2

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.actorSpriteComps10030 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								local var_206_4 = Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor2.r, var_206_3)
								local var_206_5 = Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor2.g, var_206_3)
								local var_206_6 = Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor2.b, var_206_3)

								iter_206_1.color = Color.New(var_206_4, var_206_5, var_206_6)
							else
								local var_206_7 = Mathf.Lerp(iter_206_1.color.r, 0.5, var_206_3)

								iter_206_1.color = Color.New(var_206_7, var_206_7, var_206_7)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps10030 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_206_3 then
						if arg_203_1.isInRecall_ then
							iter_206_3.color = arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_206_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps10030 = nil
			end

			local var_206_8 = arg_203_1.actors_["1038"]
			local var_206_9 = 0

			if var_206_9 < arg_203_1.time_ and arg_203_1.time_ <= var_206_9 + arg_206_0 and not isNil(var_206_8) and arg_203_1.var_.actorSpriteComps1038 == nil then
				arg_203_1.var_.actorSpriteComps1038 = var_206_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_10 = 0.2

			if var_206_9 <= arg_203_1.time_ and arg_203_1.time_ < var_206_9 + var_206_10 and not isNil(var_206_8) then
				local var_206_11 = (arg_203_1.time_ - var_206_9) / var_206_10

				if arg_203_1.var_.actorSpriteComps1038 then
					for iter_206_4, iter_206_5 in pairs(arg_203_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_206_5 then
							if arg_203_1.isInRecall_ then
								local var_206_12 = Mathf.Lerp(iter_206_5.color.r, arg_203_1.hightColor1.r, var_206_11)
								local var_206_13 = Mathf.Lerp(iter_206_5.color.g, arg_203_1.hightColor1.g, var_206_11)
								local var_206_14 = Mathf.Lerp(iter_206_5.color.b, arg_203_1.hightColor1.b, var_206_11)

								iter_206_5.color = Color.New(var_206_12, var_206_13, var_206_14)
							else
								local var_206_15 = Mathf.Lerp(iter_206_5.color.r, 1, var_206_11)

								iter_206_5.color = Color.New(var_206_15, var_206_15, var_206_15)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= var_206_9 + var_206_10 and arg_203_1.time_ < var_206_9 + var_206_10 + arg_206_0 and not isNil(var_206_8) and arg_203_1.var_.actorSpriteComps1038 then
				for iter_206_6, iter_206_7 in pairs(arg_203_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_206_7 then
						if arg_203_1.isInRecall_ then
							iter_206_7.color = arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_206_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps1038 = nil
			end

			local var_206_16 = 0
			local var_206_17 = 0.8

			if var_206_16 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_18 = arg_203_1:FormatText(StoryNameCfg[94].name)

				arg_203_1.leftNameTxt_.text = var_206_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_19 = arg_203_1:GetWordFromCfg(115261049)
				local var_206_20 = arg_203_1:FormatText(var_206_19.content)

				arg_203_1.text_.text = var_206_20

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_21 = 32
				local var_206_22 = utf8.len(var_206_20)
				local var_206_23 = var_206_21 <= 0 and var_206_17 or var_206_17 * (var_206_22 / var_206_21)

				if var_206_23 > 0 and var_206_17 < var_206_23 then
					arg_203_1.talkMaxDuration = var_206_23

					if var_206_23 + var_206_16 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_23 + var_206_16
					end
				end

				arg_203_1.text_.text = var_206_20
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261049", "story_v_out_115261.awb") ~= 0 then
					local var_206_24 = manager.audio:GetVoiceLength("story_v_out_115261", "115261049", "story_v_out_115261.awb") / 1000

					if var_206_24 + var_206_16 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_24 + var_206_16
					end

					if var_206_19.prefab_name ~= "" and arg_203_1.actors_[var_206_19.prefab_name] ~= nil then
						local var_206_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_19.prefab_name].transform, "story_v_out_115261", "115261049", "story_v_out_115261.awb")

						arg_203_1:RecordAudio("115261049", var_206_25)
						arg_203_1:RecordAudio("115261049", var_206_25)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_115261", "115261049", "story_v_out_115261.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_115261", "115261049", "story_v_out_115261.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_26 = math.max(var_206_17, arg_203_1.talkMaxDuration)

			if var_206_16 <= arg_203_1.time_ and arg_203_1.time_ < var_206_16 + var_206_26 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_16) / var_206_26

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_16 + var_206_26 and arg_203_1.time_ < var_206_16 + var_206_26 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play115261050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 115261050
		arg_207_1.duration_ = 6.17

		local var_207_0 = {
			ja = 6.166,
			ko = 4.7,
			zh = 4.633,
			en = 4.866
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play115261051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10030"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps10030 == nil then
				arg_207_1.var_.actorSpriteComps10030 = var_210_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_2 = 0.2

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.actorSpriteComps10030 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_210_1 then
							if arg_207_1.isInRecall_ then
								local var_210_4 = Mathf.Lerp(iter_210_1.color.r, arg_207_1.hightColor1.r, var_210_3)
								local var_210_5 = Mathf.Lerp(iter_210_1.color.g, arg_207_1.hightColor1.g, var_210_3)
								local var_210_6 = Mathf.Lerp(iter_210_1.color.b, arg_207_1.hightColor1.b, var_210_3)

								iter_210_1.color = Color.New(var_210_4, var_210_5, var_210_6)
							else
								local var_210_7 = Mathf.Lerp(iter_210_1.color.r, 1, var_210_3)

								iter_210_1.color = Color.New(var_210_7, var_210_7, var_210_7)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps10030 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_210_3 then
						if arg_207_1.isInRecall_ then
							iter_210_3.color = arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_210_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps10030 = nil
			end

			local var_210_8 = arg_207_1.actors_["1038"]
			local var_210_9 = 0

			if var_210_9 < arg_207_1.time_ and arg_207_1.time_ <= var_210_9 + arg_210_0 and not isNil(var_210_8) and arg_207_1.var_.actorSpriteComps1038 == nil then
				arg_207_1.var_.actorSpriteComps1038 = var_210_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_10 = 0.2

			if var_210_9 <= arg_207_1.time_ and arg_207_1.time_ < var_210_9 + var_210_10 and not isNil(var_210_8) then
				local var_210_11 = (arg_207_1.time_ - var_210_9) / var_210_10

				if arg_207_1.var_.actorSpriteComps1038 then
					for iter_210_4, iter_210_5 in pairs(arg_207_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_210_5 then
							if arg_207_1.isInRecall_ then
								local var_210_12 = Mathf.Lerp(iter_210_5.color.r, arg_207_1.hightColor2.r, var_210_11)
								local var_210_13 = Mathf.Lerp(iter_210_5.color.g, arg_207_1.hightColor2.g, var_210_11)
								local var_210_14 = Mathf.Lerp(iter_210_5.color.b, arg_207_1.hightColor2.b, var_210_11)

								iter_210_5.color = Color.New(var_210_12, var_210_13, var_210_14)
							else
								local var_210_15 = Mathf.Lerp(iter_210_5.color.r, 0.5, var_210_11)

								iter_210_5.color = Color.New(var_210_15, var_210_15, var_210_15)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= var_210_9 + var_210_10 and arg_207_1.time_ < var_210_9 + var_210_10 + arg_210_0 and not isNil(var_210_8) and arg_207_1.var_.actorSpriteComps1038 then
				for iter_210_6, iter_210_7 in pairs(arg_207_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_210_7 then
						if arg_207_1.isInRecall_ then
							iter_210_7.color = arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_210_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps1038 = nil
			end

			local var_210_16 = arg_207_1.actors_["10030"].transform
			local var_210_17 = 0

			if var_210_17 < arg_207_1.time_ and arg_207_1.time_ <= var_210_17 + arg_210_0 then
				arg_207_1.var_.moveOldPos10030 = var_210_16.localPosition
				var_210_16.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10030", 4)

				local var_210_18 = var_210_16.childCount

				for iter_210_8 = 0, var_210_18 - 1 do
					local var_210_19 = var_210_16:GetChild(iter_210_8)

					if var_210_19.name == "split_3" or not string.find(var_210_19.name, "split") then
						var_210_19.gameObject:SetActive(true)
					else
						var_210_19.gameObject:SetActive(false)
					end
				end
			end

			local var_210_20 = 0.001

			if var_210_17 <= arg_207_1.time_ and arg_207_1.time_ < var_210_17 + var_210_20 then
				local var_210_21 = (arg_207_1.time_ - var_210_17) / var_210_20
				local var_210_22 = Vector3.New(390, -390, 150)

				var_210_16.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10030, var_210_22, var_210_21)
			end

			if arg_207_1.time_ >= var_210_17 + var_210_20 and arg_207_1.time_ < var_210_17 + var_210_20 + arg_210_0 then
				var_210_16.localPosition = Vector3.New(390, -390, 150)
			end

			local var_210_23 = 0
			local var_210_24 = 0.45

			if var_210_23 < arg_207_1.time_ and arg_207_1.time_ <= var_210_23 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_25 = arg_207_1:FormatText(StoryNameCfg[309].name)

				arg_207_1.leftNameTxt_.text = var_210_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_26 = arg_207_1:GetWordFromCfg(115261050)
				local var_210_27 = arg_207_1:FormatText(var_210_26.content)

				arg_207_1.text_.text = var_210_27

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_28 = 18
				local var_210_29 = utf8.len(var_210_27)
				local var_210_30 = var_210_28 <= 0 and var_210_24 or var_210_24 * (var_210_29 / var_210_28)

				if var_210_30 > 0 and var_210_24 < var_210_30 then
					arg_207_1.talkMaxDuration = var_210_30

					if var_210_30 + var_210_23 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_30 + var_210_23
					end
				end

				arg_207_1.text_.text = var_210_27
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261050", "story_v_out_115261.awb") ~= 0 then
					local var_210_31 = manager.audio:GetVoiceLength("story_v_out_115261", "115261050", "story_v_out_115261.awb") / 1000

					if var_210_31 + var_210_23 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_31 + var_210_23
					end

					if var_210_26.prefab_name ~= "" and arg_207_1.actors_[var_210_26.prefab_name] ~= nil then
						local var_210_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_26.prefab_name].transform, "story_v_out_115261", "115261050", "story_v_out_115261.awb")

						arg_207_1:RecordAudio("115261050", var_210_32)
						arg_207_1:RecordAudio("115261050", var_210_32)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_115261", "115261050", "story_v_out_115261.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_115261", "115261050", "story_v_out_115261.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_33 = math.max(var_210_24, arg_207_1.talkMaxDuration)

			if var_210_23 <= arg_207_1.time_ and arg_207_1.time_ < var_210_23 + var_210_33 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_23) / var_210_33

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_23 + var_210_33 and arg_207_1.time_ < var_210_23 + var_210_33 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play115261051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 115261051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play115261052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10030"].transform
			local var_214_1 = 0.5

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos10030 = var_214_0.localPosition
				var_214_0.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10030", 4)

				local var_214_2 = var_214_0.childCount

				for iter_214_0 = 0, var_214_2 - 1 do
					local var_214_3 = var_214_0:GetChild(iter_214_0)

					if var_214_3.name == "split_3" or not string.find(var_214_3.name, "split") then
						var_214_3.gameObject:SetActive(true)
					else
						var_214_3.gameObject:SetActive(false)
					end
				end
			end

			local var_214_4 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_4 then
				local var_214_5 = (arg_211_1.time_ - var_214_1) / var_214_4
				local var_214_6 = Vector3.New(390, -390, 150)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10030, var_214_6, var_214_5)
			end

			if arg_211_1.time_ >= var_214_1 + var_214_4 and arg_211_1.time_ < var_214_1 + var_214_4 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_214_7 = arg_211_1.actors_["10030"]
			local var_214_8 = 0

			if var_214_8 < arg_211_1.time_ and arg_211_1.time_ <= var_214_8 + arg_214_0 then
				local var_214_9 = var_214_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_214_9 then
					arg_211_1.var_.alphaOldValue10030 = var_214_9.alpha
					arg_211_1.var_.characterEffect10030 = var_214_9
				end

				arg_211_1.var_.alphaOldValue10030 = 1
			end

			local var_214_10 = 0.5

			if var_214_8 <= arg_211_1.time_ and arg_211_1.time_ < var_214_8 + var_214_10 then
				local var_214_11 = (arg_211_1.time_ - var_214_8) / var_214_10
				local var_214_12 = Mathf.Lerp(arg_211_1.var_.alphaOldValue10030, 0, var_214_11)

				if arg_211_1.var_.characterEffect10030 then
					arg_211_1.var_.characterEffect10030.alpha = var_214_12
				end
			end

			if arg_211_1.time_ >= var_214_8 + var_214_10 and arg_211_1.time_ < var_214_8 + var_214_10 + arg_214_0 and arg_211_1.var_.characterEffect10030 then
				arg_211_1.var_.characterEffect10030.alpha = 0
			end

			local var_214_13 = arg_211_1.actors_["1038"]
			local var_214_14 = 0

			if var_214_14 < arg_211_1.time_ and arg_211_1.time_ <= var_214_14 + arg_214_0 then
				local var_214_15 = var_214_13:GetComponentInChildren(typeof(CanvasGroup))

				if var_214_15 then
					arg_211_1.var_.alphaOldValue1038 = var_214_15.alpha
					arg_211_1.var_.characterEffect1038 = var_214_15
				end

				arg_211_1.var_.alphaOldValue1038 = 1
			end

			local var_214_16 = 0.5

			if var_214_14 <= arg_211_1.time_ and arg_211_1.time_ < var_214_14 + var_214_16 then
				local var_214_17 = (arg_211_1.time_ - var_214_14) / var_214_16
				local var_214_18 = Mathf.Lerp(arg_211_1.var_.alphaOldValue1038, 0, var_214_17)

				if arg_211_1.var_.characterEffect1038 then
					arg_211_1.var_.characterEffect1038.alpha = var_214_18
				end
			end

			if arg_211_1.time_ >= var_214_14 + var_214_16 and arg_211_1.time_ < var_214_14 + var_214_16 + arg_214_0 and arg_211_1.var_.characterEffect1038 then
				arg_211_1.var_.characterEffect1038.alpha = 0
			end

			local var_214_19 = 0
			local var_214_20 = 0.525

			if var_214_19 < arg_211_1.time_ and arg_211_1.time_ <= var_214_19 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_21 = arg_211_1:GetWordFromCfg(115261051)
				local var_214_22 = arg_211_1:FormatText(var_214_21.content)

				arg_211_1.text_.text = var_214_22

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_23 = 21
				local var_214_24 = utf8.len(var_214_22)
				local var_214_25 = var_214_23 <= 0 and var_214_20 or var_214_20 * (var_214_24 / var_214_23)

				if var_214_25 > 0 and var_214_20 < var_214_25 then
					arg_211_1.talkMaxDuration = var_214_25

					if var_214_25 + var_214_19 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_25 + var_214_19
					end
				end

				arg_211_1.text_.text = var_214_22
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_26 = math.max(var_214_20, arg_211_1.talkMaxDuration)

			if var_214_19 <= arg_211_1.time_ and arg_211_1.time_ < var_214_19 + var_214_26 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_19) / var_214_26

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_19 + var_214_26 and arg_211_1.time_ < var_214_19 + var_214_26 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play115261052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 115261052
		arg_215_1.duration_ = 10.23

		local var_215_0 = {
			ja = 8.066,
			ko = 6.9,
			zh = 8.233,
			en = 10.233
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play115261053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1038"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.actorSpriteComps1038 == nil then
				arg_215_1.var_.actorSpriteComps1038 = var_218_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_2 = 0.2

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.actorSpriteComps1038 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_218_1 then
							if arg_215_1.isInRecall_ then
								local var_218_4 = Mathf.Lerp(iter_218_1.color.r, arg_215_1.hightColor1.r, var_218_3)
								local var_218_5 = Mathf.Lerp(iter_218_1.color.g, arg_215_1.hightColor1.g, var_218_3)
								local var_218_6 = Mathf.Lerp(iter_218_1.color.b, arg_215_1.hightColor1.b, var_218_3)

								iter_218_1.color = Color.New(var_218_4, var_218_5, var_218_6)
							else
								local var_218_7 = Mathf.Lerp(iter_218_1.color.r, 1, var_218_3)

								iter_218_1.color = Color.New(var_218_7, var_218_7, var_218_7)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.actorSpriteComps1038 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_218_3 then
						if arg_215_1.isInRecall_ then
							iter_218_3.color = arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_218_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps1038 = nil
			end

			local var_218_8 = arg_215_1.actors_["1038"].transform
			local var_218_9 = 0

			if var_218_9 < arg_215_1.time_ and arg_215_1.time_ <= var_218_9 + arg_218_0 then
				arg_215_1.var_.moveOldPos1038 = var_218_8.localPosition
				var_218_8.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1038", 2)

				local var_218_10 = var_218_8.childCount

				for iter_218_4 = 0, var_218_10 - 1 do
					local var_218_11 = var_218_8:GetChild(iter_218_4)

					if var_218_11.name == "split_1" or not string.find(var_218_11.name, "split") then
						var_218_11.gameObject:SetActive(true)
					else
						var_218_11.gameObject:SetActive(false)
					end
				end
			end

			local var_218_12 = 0.001

			if var_218_9 <= arg_215_1.time_ and arg_215_1.time_ < var_218_9 + var_218_12 then
				local var_218_13 = (arg_215_1.time_ - var_218_9) / var_218_12
				local var_218_14 = Vector3.New(-390, -400, 0)

				var_218_8.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1038, var_218_14, var_218_13)
			end

			if arg_215_1.time_ >= var_218_9 + var_218_12 and arg_215_1.time_ < var_218_9 + var_218_12 + arg_218_0 then
				var_218_8.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_218_15 = arg_215_1.actors_["1038"]
			local var_218_16 = 0

			if var_218_16 < arg_215_1.time_ and arg_215_1.time_ <= var_218_16 + arg_218_0 then
				local var_218_17 = var_218_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_218_17 then
					arg_215_1.var_.alphaOldValue1038 = var_218_17.alpha
					arg_215_1.var_.characterEffect1038 = var_218_17
				end

				arg_215_1.var_.alphaOldValue1038 = 0
			end

			local var_218_18 = 0.5

			if var_218_16 <= arg_215_1.time_ and arg_215_1.time_ < var_218_16 + var_218_18 then
				local var_218_19 = (arg_215_1.time_ - var_218_16) / var_218_18
				local var_218_20 = Mathf.Lerp(arg_215_1.var_.alphaOldValue1038, 1, var_218_19)

				if arg_215_1.var_.characterEffect1038 then
					arg_215_1.var_.characterEffect1038.alpha = var_218_20
				end
			end

			if arg_215_1.time_ >= var_218_16 + var_218_18 and arg_215_1.time_ < var_218_16 + var_218_18 + arg_218_0 and arg_215_1.var_.characterEffect1038 then
				arg_215_1.var_.characterEffect1038.alpha = 1
			end

			local var_218_21 = arg_215_1.actors_["10030"]
			local var_218_22 = 0

			if var_218_22 < arg_215_1.time_ and arg_215_1.time_ <= var_218_22 + arg_218_0 and not isNil(var_218_21) and arg_215_1.var_.actorSpriteComps10030 == nil then
				arg_215_1.var_.actorSpriteComps10030 = var_218_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_23 = 0.2

			if var_218_22 <= arg_215_1.time_ and arg_215_1.time_ < var_218_22 + var_218_23 and not isNil(var_218_21) then
				local var_218_24 = (arg_215_1.time_ - var_218_22) / var_218_23

				if arg_215_1.var_.actorSpriteComps10030 then
					for iter_218_5, iter_218_6 in pairs(arg_215_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_218_6 then
							if arg_215_1.isInRecall_ then
								local var_218_25 = Mathf.Lerp(iter_218_6.color.r, arg_215_1.hightColor2.r, var_218_24)
								local var_218_26 = Mathf.Lerp(iter_218_6.color.g, arg_215_1.hightColor2.g, var_218_24)
								local var_218_27 = Mathf.Lerp(iter_218_6.color.b, arg_215_1.hightColor2.b, var_218_24)

								iter_218_6.color = Color.New(var_218_25, var_218_26, var_218_27)
							else
								local var_218_28 = Mathf.Lerp(iter_218_6.color.r, 0.5, var_218_24)

								iter_218_6.color = Color.New(var_218_28, var_218_28, var_218_28)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_22 + var_218_23 and arg_215_1.time_ < var_218_22 + var_218_23 + arg_218_0 and not isNil(var_218_21) and arg_215_1.var_.actorSpriteComps10030 then
				for iter_218_7, iter_218_8 in pairs(arg_215_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_218_8 then
						if arg_215_1.isInRecall_ then
							iter_218_8.color = arg_215_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_218_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps10030 = nil
			end

			local var_218_29 = arg_215_1.actors_["10030"]
			local var_218_30 = 0

			if var_218_30 < arg_215_1.time_ and arg_215_1.time_ <= var_218_30 + arg_218_0 then
				local var_218_31 = var_218_29:GetComponentInChildren(typeof(CanvasGroup))

				if var_218_31 then
					arg_215_1.var_.alphaOldValue10030 = var_218_31.alpha
					arg_215_1.var_.characterEffect10030 = var_218_31
				end

				arg_215_1.var_.alphaOldValue10030 = 0
			end

			local var_218_32 = 0.333333333333333

			if var_218_30 <= arg_215_1.time_ and arg_215_1.time_ < var_218_30 + var_218_32 then
				local var_218_33 = (arg_215_1.time_ - var_218_30) / var_218_32
				local var_218_34 = Mathf.Lerp(arg_215_1.var_.alphaOldValue10030, 1, var_218_33)

				if arg_215_1.var_.characterEffect10030 then
					arg_215_1.var_.characterEffect10030.alpha = var_218_34
				end
			end

			if arg_215_1.time_ >= var_218_30 + var_218_32 and arg_215_1.time_ < var_218_30 + var_218_32 + arg_218_0 and arg_215_1.var_.characterEffect10030 then
				arg_215_1.var_.characterEffect10030.alpha = 1
			end

			local var_218_35 = 0
			local var_218_36 = 0.7

			if var_218_35 < arg_215_1.time_ and arg_215_1.time_ <= var_218_35 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_37 = arg_215_1:FormatText(StoryNameCfg[94].name)

				arg_215_1.leftNameTxt_.text = var_218_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_38 = arg_215_1:GetWordFromCfg(115261052)
				local var_218_39 = arg_215_1:FormatText(var_218_38.content)

				arg_215_1.text_.text = var_218_39

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_40 = 29
				local var_218_41 = utf8.len(var_218_39)
				local var_218_42 = var_218_40 <= 0 and var_218_36 or var_218_36 * (var_218_41 / var_218_40)

				if var_218_42 > 0 and var_218_36 < var_218_42 then
					arg_215_1.talkMaxDuration = var_218_42

					if var_218_42 + var_218_35 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_42 + var_218_35
					end
				end

				arg_215_1.text_.text = var_218_39
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261052", "story_v_out_115261.awb") ~= 0 then
					local var_218_43 = manager.audio:GetVoiceLength("story_v_out_115261", "115261052", "story_v_out_115261.awb") / 1000

					if var_218_43 + var_218_35 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_43 + var_218_35
					end

					if var_218_38.prefab_name ~= "" and arg_215_1.actors_[var_218_38.prefab_name] ~= nil then
						local var_218_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_38.prefab_name].transform, "story_v_out_115261", "115261052", "story_v_out_115261.awb")

						arg_215_1:RecordAudio("115261052", var_218_44)
						arg_215_1:RecordAudio("115261052", var_218_44)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_115261", "115261052", "story_v_out_115261.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_115261", "115261052", "story_v_out_115261.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_45 = math.max(var_218_36, arg_215_1.talkMaxDuration)

			if var_218_35 <= arg_215_1.time_ and arg_215_1.time_ < var_218_35 + var_218_45 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_35) / var_218_45

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_35 + var_218_45 and arg_215_1.time_ < var_218_35 + var_218_45 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play115261053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 115261053
		arg_219_1.duration_ = 14.77

		local var_219_0 = {
			ja = 14.766,
			ko = 9.4,
			zh = 9.433,
			en = 11.033
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play115261054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.925

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[94].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_3 = arg_219_1:GetWordFromCfg(115261053)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 37
				local var_222_6 = utf8.len(var_222_4)
				local var_222_7 = var_222_5 <= 0 and var_222_1 or var_222_1 * (var_222_6 / var_222_5)

				if var_222_7 > 0 and var_222_1 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261053", "story_v_out_115261.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261053", "story_v_out_115261.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_115261", "115261053", "story_v_out_115261.awb")

						arg_219_1:RecordAudio("115261053", var_222_9)
						arg_219_1:RecordAudio("115261053", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_115261", "115261053", "story_v_out_115261.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_115261", "115261053", "story_v_out_115261.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_10 and arg_219_1.time_ < var_222_0 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play115261054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 115261054
		arg_223_1.duration_ = 2.87

		local var_223_0 = {
			ja = 2.866,
			ko = 1.6,
			zh = 1.7,
			en = 2.6
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play115261055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10030"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps10030 == nil then
				arg_223_1.var_.actorSpriteComps10030 = var_226_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_2 = 0.2

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.actorSpriteComps10030 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_226_1 then
							if arg_223_1.isInRecall_ then
								local var_226_4 = Mathf.Lerp(iter_226_1.color.r, arg_223_1.hightColor1.r, var_226_3)
								local var_226_5 = Mathf.Lerp(iter_226_1.color.g, arg_223_1.hightColor1.g, var_226_3)
								local var_226_6 = Mathf.Lerp(iter_226_1.color.b, arg_223_1.hightColor1.b, var_226_3)

								iter_226_1.color = Color.New(var_226_4, var_226_5, var_226_6)
							else
								local var_226_7 = Mathf.Lerp(iter_226_1.color.r, 1, var_226_3)

								iter_226_1.color = Color.New(var_226_7, var_226_7, var_226_7)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps10030 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_226_3 then
						if arg_223_1.isInRecall_ then
							iter_226_3.color = arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_226_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps10030 = nil
			end

			local var_226_8 = arg_223_1.actors_["1038"]
			local var_226_9 = 0

			if var_226_9 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 and not isNil(var_226_8) and arg_223_1.var_.actorSpriteComps1038 == nil then
				arg_223_1.var_.actorSpriteComps1038 = var_226_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_10 = 0.2

			if var_226_9 <= arg_223_1.time_ and arg_223_1.time_ < var_226_9 + var_226_10 and not isNil(var_226_8) then
				local var_226_11 = (arg_223_1.time_ - var_226_9) / var_226_10

				if arg_223_1.var_.actorSpriteComps1038 then
					for iter_226_4, iter_226_5 in pairs(arg_223_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_226_5 then
							if arg_223_1.isInRecall_ then
								local var_226_12 = Mathf.Lerp(iter_226_5.color.r, arg_223_1.hightColor2.r, var_226_11)
								local var_226_13 = Mathf.Lerp(iter_226_5.color.g, arg_223_1.hightColor2.g, var_226_11)
								local var_226_14 = Mathf.Lerp(iter_226_5.color.b, arg_223_1.hightColor2.b, var_226_11)

								iter_226_5.color = Color.New(var_226_12, var_226_13, var_226_14)
							else
								local var_226_15 = Mathf.Lerp(iter_226_5.color.r, 0.5, var_226_11)

								iter_226_5.color = Color.New(var_226_15, var_226_15, var_226_15)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_9 + var_226_10 and arg_223_1.time_ < var_226_9 + var_226_10 + arg_226_0 and not isNil(var_226_8) and arg_223_1.var_.actorSpriteComps1038 then
				for iter_226_6, iter_226_7 in pairs(arg_223_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_226_7 then
						if arg_223_1.isInRecall_ then
							iter_226_7.color = arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_226_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps1038 = nil
			end

			local var_226_16 = 0
			local var_226_17 = 0.15

			if var_226_16 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_18 = arg_223_1:FormatText(StoryNameCfg[309].name)

				arg_223_1.leftNameTxt_.text = var_226_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_19 = arg_223_1:GetWordFromCfg(115261054)
				local var_226_20 = arg_223_1:FormatText(var_226_19.content)

				arg_223_1.text_.text = var_226_20

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_21 = 6
				local var_226_22 = utf8.len(var_226_20)
				local var_226_23 = var_226_21 <= 0 and var_226_17 or var_226_17 * (var_226_22 / var_226_21)

				if var_226_23 > 0 and var_226_17 < var_226_23 then
					arg_223_1.talkMaxDuration = var_226_23

					if var_226_23 + var_226_16 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_16
					end
				end

				arg_223_1.text_.text = var_226_20
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261054", "story_v_out_115261.awb") ~= 0 then
					local var_226_24 = manager.audio:GetVoiceLength("story_v_out_115261", "115261054", "story_v_out_115261.awb") / 1000

					if var_226_24 + var_226_16 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_24 + var_226_16
					end

					if var_226_19.prefab_name ~= "" and arg_223_1.actors_[var_226_19.prefab_name] ~= nil then
						local var_226_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_19.prefab_name].transform, "story_v_out_115261", "115261054", "story_v_out_115261.awb")

						arg_223_1:RecordAudio("115261054", var_226_25)
						arg_223_1:RecordAudio("115261054", var_226_25)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_115261", "115261054", "story_v_out_115261.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_115261", "115261054", "story_v_out_115261.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_26 = math.max(var_226_17, arg_223_1.talkMaxDuration)

			if var_226_16 <= arg_223_1.time_ and arg_223_1.time_ < var_226_16 + var_226_26 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_16) / var_226_26

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_16 + var_226_26 and arg_223_1.time_ < var_226_16 + var_226_26 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play115261055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 115261055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play115261056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1038"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				local var_230_2 = var_230_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_230_2 then
					arg_227_1.var_.alphaOldValue1038 = var_230_2.alpha
					arg_227_1.var_.characterEffect1038 = var_230_2
				end

				arg_227_1.var_.alphaOldValue1038 = 1
			end

			local var_230_3 = 0.5

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_3 then
				local var_230_4 = (arg_227_1.time_ - var_230_1) / var_230_3
				local var_230_5 = Mathf.Lerp(arg_227_1.var_.alphaOldValue1038, 0, var_230_4)

				if arg_227_1.var_.characterEffect1038 then
					arg_227_1.var_.characterEffect1038.alpha = var_230_5
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_3 and arg_227_1.time_ < var_230_1 + var_230_3 + arg_230_0 and arg_227_1.var_.characterEffect1038 then
				arg_227_1.var_.characterEffect1038.alpha = 0
			end

			local var_230_6 = arg_227_1.actors_["10030"]
			local var_230_7 = 0

			if var_230_7 < arg_227_1.time_ and arg_227_1.time_ <= var_230_7 + arg_230_0 then
				local var_230_8 = var_230_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_230_8 then
					arg_227_1.var_.alphaOldValue10030 = var_230_8.alpha
					arg_227_1.var_.characterEffect10030 = var_230_8
				end

				arg_227_1.var_.alphaOldValue10030 = 1
			end

			local var_230_9 = 0.5

			if var_230_7 <= arg_227_1.time_ and arg_227_1.time_ < var_230_7 + var_230_9 then
				local var_230_10 = (arg_227_1.time_ - var_230_7) / var_230_9
				local var_230_11 = Mathf.Lerp(arg_227_1.var_.alphaOldValue10030, 0, var_230_10)

				if arg_227_1.var_.characterEffect10030 then
					arg_227_1.var_.characterEffect10030.alpha = var_230_11
				end
			end

			if arg_227_1.time_ >= var_230_7 + var_230_9 and arg_227_1.time_ < var_230_7 + var_230_9 + arg_230_0 and arg_227_1.var_.characterEffect10030 then
				arg_227_1.var_.characterEffect10030.alpha = 0
			end

			local var_230_12 = 0
			local var_230_13 = 1.275

			if var_230_12 < arg_227_1.time_ and arg_227_1.time_ <= var_230_12 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_14 = arg_227_1:GetWordFromCfg(115261055)
				local var_230_15 = arg_227_1:FormatText(var_230_14.content)

				arg_227_1.text_.text = var_230_15

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_16 = 51
				local var_230_17 = utf8.len(var_230_15)
				local var_230_18 = var_230_16 <= 0 and var_230_13 or var_230_13 * (var_230_17 / var_230_16)

				if var_230_18 > 0 and var_230_13 < var_230_18 then
					arg_227_1.talkMaxDuration = var_230_18

					if var_230_18 + var_230_12 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_18 + var_230_12
					end
				end

				arg_227_1.text_.text = var_230_15
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_19 = math.max(var_230_13, arg_227_1.talkMaxDuration)

			if var_230_12 <= arg_227_1.time_ and arg_227_1.time_ < var_230_12 + var_230_19 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_12) / var_230_19

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_12 + var_230_19 and arg_227_1.time_ < var_230_12 + var_230_19 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play115261056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 115261056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play115261057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.875

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_2 = arg_231_1:GetWordFromCfg(115261056)
				local var_234_3 = arg_231_1:FormatText(var_234_2.content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 35
				local var_234_5 = utf8.len(var_234_3)
				local var_234_6 = var_234_4 <= 0 and var_234_1 or var_234_1 * (var_234_5 / var_234_4)

				if var_234_6 > 0 and var_234_1 < var_234_6 then
					arg_231_1.talkMaxDuration = var_234_6

					if var_234_6 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_6 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_7 and arg_231_1.time_ < var_234_0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play115261057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 115261057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play115261058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 0.65

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_2 = arg_235_1:GetWordFromCfg(115261057)
				local var_238_3 = arg_235_1:FormatText(var_238_2.content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 26
				local var_238_5 = utf8.len(var_238_3)
				local var_238_6 = var_238_4 <= 0 and var_238_1 or var_238_1 * (var_238_5 / var_238_4)

				if var_238_6 > 0 and var_238_1 < var_238_6 then
					arg_235_1.talkMaxDuration = var_238_6

					if var_238_6 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_7 and arg_235_1.time_ < var_238_0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play115261058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 115261058
		arg_239_1.duration_ = 3.37

		local var_239_0 = {
			ja = 3.366,
			ko = 1.933,
			zh = 2.966,
			en = 2.2
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play115261059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1038"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1038 = var_242_0.localPosition
				var_242_0.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("1038", 3)

				local var_242_2 = var_242_0.childCount

				for iter_242_0 = 0, var_242_2 - 1 do
					local var_242_3 = var_242_0:GetChild(iter_242_0)

					if var_242_3.name == "split_1" or not string.find(var_242_3.name, "split") then
						var_242_3.gameObject:SetActive(true)
					else
						var_242_3.gameObject:SetActive(false)
					end
				end
			end

			local var_242_4 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_4 then
				local var_242_5 = (arg_239_1.time_ - var_242_1) / var_242_4
				local var_242_6 = Vector3.New(0, -400, 0)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1038, var_242_6, var_242_5)
			end

			if arg_239_1.time_ >= var_242_1 + var_242_4 and arg_239_1.time_ < var_242_1 + var_242_4 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_242_7 = arg_239_1.actors_["1038"]
			local var_242_8 = 0

			if var_242_8 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 and not isNil(var_242_7) and arg_239_1.var_.actorSpriteComps1038 == nil then
				arg_239_1.var_.actorSpriteComps1038 = var_242_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_9 = 0.2

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_9 and not isNil(var_242_7) then
				local var_242_10 = (arg_239_1.time_ - var_242_8) / var_242_9

				if arg_239_1.var_.actorSpriteComps1038 then
					for iter_242_1, iter_242_2 in pairs(arg_239_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_242_2 then
							if arg_239_1.isInRecall_ then
								local var_242_11 = Mathf.Lerp(iter_242_2.color.r, arg_239_1.hightColor1.r, var_242_10)
								local var_242_12 = Mathf.Lerp(iter_242_2.color.g, arg_239_1.hightColor1.g, var_242_10)
								local var_242_13 = Mathf.Lerp(iter_242_2.color.b, arg_239_1.hightColor1.b, var_242_10)

								iter_242_2.color = Color.New(var_242_11, var_242_12, var_242_13)
							else
								local var_242_14 = Mathf.Lerp(iter_242_2.color.r, 1, var_242_10)

								iter_242_2.color = Color.New(var_242_14, var_242_14, var_242_14)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= var_242_8 + var_242_9 and arg_239_1.time_ < var_242_8 + var_242_9 + arg_242_0 and not isNil(var_242_7) and arg_239_1.var_.actorSpriteComps1038 then
				for iter_242_3, iter_242_4 in pairs(arg_239_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_242_4 then
						if arg_239_1.isInRecall_ then
							iter_242_4.color = arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_242_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps1038 = nil
			end

			local var_242_15 = arg_239_1.actors_["1038"]
			local var_242_16 = 0

			if var_242_16 < arg_239_1.time_ and arg_239_1.time_ <= var_242_16 + arg_242_0 then
				local var_242_17 = var_242_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_242_17 then
					arg_239_1.var_.alphaOldValue1038 = var_242_17.alpha
					arg_239_1.var_.characterEffect1038 = var_242_17
				end

				arg_239_1.var_.alphaOldValue1038 = 0
			end

			local var_242_18 = 0.5

			if var_242_16 <= arg_239_1.time_ and arg_239_1.time_ < var_242_16 + var_242_18 then
				local var_242_19 = (arg_239_1.time_ - var_242_16) / var_242_18
				local var_242_20 = Mathf.Lerp(arg_239_1.var_.alphaOldValue1038, 1, var_242_19)

				if arg_239_1.var_.characterEffect1038 then
					arg_239_1.var_.characterEffect1038.alpha = var_242_20
				end
			end

			if arg_239_1.time_ >= var_242_16 + var_242_18 and arg_239_1.time_ < var_242_16 + var_242_18 + arg_242_0 and arg_239_1.var_.characterEffect1038 then
				arg_239_1.var_.characterEffect1038.alpha = 1
			end

			local var_242_21 = 0
			local var_242_22 = 0.275

			if var_242_21 < arg_239_1.time_ and arg_239_1.time_ <= var_242_21 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_23 = arg_239_1:FormatText(StoryNameCfg[94].name)

				arg_239_1.leftNameTxt_.text = var_242_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_24 = arg_239_1:GetWordFromCfg(115261058)
				local var_242_25 = arg_239_1:FormatText(var_242_24.content)

				arg_239_1.text_.text = var_242_25

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_26 = 11
				local var_242_27 = utf8.len(var_242_25)
				local var_242_28 = var_242_26 <= 0 and var_242_22 or var_242_22 * (var_242_27 / var_242_26)

				if var_242_28 > 0 and var_242_22 < var_242_28 then
					arg_239_1.talkMaxDuration = var_242_28

					if var_242_28 + var_242_21 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_28 + var_242_21
					end
				end

				arg_239_1.text_.text = var_242_25
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261058", "story_v_out_115261.awb") ~= 0 then
					local var_242_29 = manager.audio:GetVoiceLength("story_v_out_115261", "115261058", "story_v_out_115261.awb") / 1000

					if var_242_29 + var_242_21 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_29 + var_242_21
					end

					if var_242_24.prefab_name ~= "" and arg_239_1.actors_[var_242_24.prefab_name] ~= nil then
						local var_242_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_24.prefab_name].transform, "story_v_out_115261", "115261058", "story_v_out_115261.awb")

						arg_239_1:RecordAudio("115261058", var_242_30)
						arg_239_1:RecordAudio("115261058", var_242_30)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_115261", "115261058", "story_v_out_115261.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_115261", "115261058", "story_v_out_115261.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_31 = math.max(var_242_22, arg_239_1.talkMaxDuration)

			if var_242_21 <= arg_239_1.time_ and arg_239_1.time_ < var_242_21 + var_242_31 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_21) / var_242_31

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_21 + var_242_31 and arg_239_1.time_ < var_242_21 + var_242_31 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play115261059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 115261059
		arg_243_1.duration_ = 7.43

		local var_243_0 = {
			ja = 7.433,
			ko = 6.066,
			zh = 4.1,
			en = 4.766
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play115261060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1038"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps1038 == nil then
				arg_243_1.var_.actorSpriteComps1038 = var_246_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_2 = 0.2

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.actorSpriteComps1038 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								local var_246_4 = Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor2.r, var_246_3)
								local var_246_5 = Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor2.g, var_246_3)
								local var_246_6 = Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor2.b, var_246_3)

								iter_246_1.color = Color.New(var_246_4, var_246_5, var_246_6)
							else
								local var_246_7 = Mathf.Lerp(iter_246_1.color.r, 0.5, var_246_3)

								iter_246_1.color = Color.New(var_246_7, var_246_7, var_246_7)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps1038 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_246_3 then
						if arg_243_1.isInRecall_ then
							iter_246_3.color = arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_246_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps1038 = nil
			end

			local var_246_8 = 0
			local var_246_9 = 0.5

			if var_246_8 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_10 = arg_243_1:FormatText(StoryNameCfg[205].name)

				arg_243_1.leftNameTxt_.text = var_246_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_11 = arg_243_1:GetWordFromCfg(115261059)
				local var_246_12 = arg_243_1:FormatText(var_246_11.content)

				arg_243_1.text_.text = var_246_12

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_13 = 22
				local var_246_14 = utf8.len(var_246_12)
				local var_246_15 = var_246_13 <= 0 and var_246_9 or var_246_9 * (var_246_14 / var_246_13)

				if var_246_15 > 0 and var_246_9 < var_246_15 then
					arg_243_1.talkMaxDuration = var_246_15

					if var_246_15 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_15 + var_246_8
					end
				end

				arg_243_1.text_.text = var_246_12
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261059", "story_v_out_115261.awb") ~= 0 then
					local var_246_16 = manager.audio:GetVoiceLength("story_v_out_115261", "115261059", "story_v_out_115261.awb") / 1000

					if var_246_16 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_16 + var_246_8
					end

					if var_246_11.prefab_name ~= "" and arg_243_1.actors_[var_246_11.prefab_name] ~= nil then
						local var_246_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_11.prefab_name].transform, "story_v_out_115261", "115261059", "story_v_out_115261.awb")

						arg_243_1:RecordAudio("115261059", var_246_17)
						arg_243_1:RecordAudio("115261059", var_246_17)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_115261", "115261059", "story_v_out_115261.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_115261", "115261059", "story_v_out_115261.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_18 = math.max(var_246_9, arg_243_1.talkMaxDuration)

			if var_246_8 <= arg_243_1.time_ and arg_243_1.time_ < var_246_8 + var_246_18 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_8) / var_246_18

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_8 + var_246_18 and arg_243_1.time_ < var_246_8 + var_246_18 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play115261060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 115261060
		arg_247_1.duration_ = 3

		local var_247_0 = {
			ja = 2.966,
			ko = 2.533,
			zh = 3,
			en = 2.8
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play115261061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 0.225

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_2 = arg_247_1:FormatText(StoryNameCfg[309].name)

				arg_247_1.leftNameTxt_.text = var_250_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10030_split_1")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_3 = arg_247_1:GetWordFromCfg(115261060)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 9
				local var_250_6 = utf8.len(var_250_4)
				local var_250_7 = var_250_5 <= 0 and var_250_1 or var_250_1 * (var_250_6 / var_250_5)

				if var_250_7 > 0 and var_250_1 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261060", "story_v_out_115261.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261060", "story_v_out_115261.awb") / 1000

					if var_250_8 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_0
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_out_115261", "115261060", "story_v_out_115261.awb")

						arg_247_1:RecordAudio("115261060", var_250_9)
						arg_247_1:RecordAudio("115261060", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_115261", "115261060", "story_v_out_115261.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_115261", "115261060", "story_v_out_115261.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_10 and arg_247_1.time_ < var_250_0 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play115261061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 115261061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play115261062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1038"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				local var_254_2 = var_254_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_254_2 then
					arg_251_1.var_.alphaOldValue1038 = var_254_2.alpha
					arg_251_1.var_.characterEffect1038 = var_254_2
				end

				arg_251_1.var_.alphaOldValue1038 = 1
			end

			local var_254_3 = 0.333333333333333

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_3 then
				local var_254_4 = (arg_251_1.time_ - var_254_1) / var_254_3
				local var_254_5 = Mathf.Lerp(arg_251_1.var_.alphaOldValue1038, 0, var_254_4)

				if arg_251_1.var_.characterEffect1038 then
					arg_251_1.var_.characterEffect1038.alpha = var_254_5
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_3 and arg_251_1.time_ < var_254_1 + var_254_3 + arg_254_0 and arg_251_1.var_.characterEffect1038 then
				arg_251_1.var_.characterEffect1038.alpha = 0
			end

			local var_254_6 = 0
			local var_254_7 = 0.8

			if var_254_6 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_8 = arg_251_1:GetWordFromCfg(115261061)
				local var_254_9 = arg_251_1:FormatText(var_254_8.content)

				arg_251_1.text_.text = var_254_9

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_10 = 32
				local var_254_11 = utf8.len(var_254_9)
				local var_254_12 = var_254_10 <= 0 and var_254_7 or var_254_7 * (var_254_11 / var_254_10)

				if var_254_12 > 0 and var_254_7 < var_254_12 then
					arg_251_1.talkMaxDuration = var_254_12

					if var_254_12 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_12 + var_254_6
					end
				end

				arg_251_1.text_.text = var_254_9
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_13 = math.max(var_254_7, arg_251_1.talkMaxDuration)

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_13 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_6) / var_254_13

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_6 + var_254_13 and arg_251_1.time_ < var_254_6 + var_254_13 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play115261062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 115261062
		arg_255_1.duration_ = 5.97

		local var_255_0 = {
			ja = 5.366,
			ko = 3.8,
			zh = 4.2,
			en = 5.966
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play115261063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.375

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[205].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:GetWordFromCfg(115261062)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 15
				local var_258_6 = utf8.len(var_258_4)
				local var_258_7 = var_258_5 <= 0 and var_258_1 or var_258_1 * (var_258_6 / var_258_5)

				if var_258_7 > 0 and var_258_1 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261062", "story_v_out_115261.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261062", "story_v_out_115261.awb") / 1000

					if var_258_8 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_0
					end

					if var_258_3.prefab_name ~= "" and arg_255_1.actors_[var_258_3.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_3.prefab_name].transform, "story_v_out_115261", "115261062", "story_v_out_115261.awb")

						arg_255_1:RecordAudio("115261062", var_258_9)
						arg_255_1:RecordAudio("115261062", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_115261", "115261062", "story_v_out_115261.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_115261", "115261062", "story_v_out_115261.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_10 and arg_255_1.time_ < var_258_0 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play115261063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 115261063
		arg_259_1.duration_ = 5.67

		local var_259_0 = {
			ja = 5.666,
			ko = 4.7,
			zh = 3.866,
			en = 4.966
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play115261064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 0.475

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_2 = arg_259_1:FormatText(StoryNameCfg[205].name)

				arg_259_1.leftNameTxt_.text = var_262_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_3 = arg_259_1:GetWordFromCfg(115261063)
				local var_262_4 = arg_259_1:FormatText(var_262_3.content)

				arg_259_1.text_.text = var_262_4

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 19
				local var_262_6 = utf8.len(var_262_4)
				local var_262_7 = var_262_5 <= 0 and var_262_1 or var_262_1 * (var_262_6 / var_262_5)

				if var_262_7 > 0 and var_262_1 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_4
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261063", "story_v_out_115261.awb") ~= 0 then
					local var_262_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261063", "story_v_out_115261.awb") / 1000

					if var_262_8 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_0
					end

					if var_262_3.prefab_name ~= "" and arg_259_1.actors_[var_262_3.prefab_name] ~= nil then
						local var_262_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_3.prefab_name].transform, "story_v_out_115261", "115261063", "story_v_out_115261.awb")

						arg_259_1:RecordAudio("115261063", var_262_9)
						arg_259_1:RecordAudio("115261063", var_262_9)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_115261", "115261063", "story_v_out_115261.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_115261", "115261063", "story_v_out_115261.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_10 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_10 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_10

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_10 and arg_259_1.time_ < var_262_0 + var_262_10 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play115261064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 115261064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play115261065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 0.275

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_2 = arg_263_1:GetWordFromCfg(115261064)
				local var_266_3 = arg_263_1:FormatText(var_266_2.content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 11
				local var_266_5 = utf8.len(var_266_3)
				local var_266_6 = var_266_4 <= 0 and var_266_1 or var_266_1 * (var_266_5 / var_266_4)

				if var_266_6 > 0 and var_266_1 < var_266_6 then
					arg_263_1.talkMaxDuration = var_266_6

					if var_266_6 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_0
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_1, arg_263_1.talkMaxDuration)

			if var_266_0 <= arg_263_1.time_ and arg_263_1.time_ < var_266_0 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_0) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_0 + var_266_7 and arg_263_1.time_ < var_266_0 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play115261065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 115261065
		arg_267_1.duration_ = 10.63

		local var_267_0 = {
			ja = 6.466,
			ko = 10.6,
			zh = 9.566,
			en = 10.633
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play115261066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1038"].transform
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.var_.moveOldPos1038 = var_270_0.localPosition
				var_270_0.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("1038", 3)

				local var_270_2 = var_270_0.childCount

				for iter_270_0 = 0, var_270_2 - 1 do
					local var_270_3 = var_270_0:GetChild(iter_270_0)

					if var_270_3.name == "split_9" or not string.find(var_270_3.name, "split") then
						var_270_3.gameObject:SetActive(true)
					else
						var_270_3.gameObject:SetActive(false)
					end
				end
			end

			local var_270_4 = 0.001

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_4 then
				local var_270_5 = (arg_267_1.time_ - var_270_1) / var_270_4
				local var_270_6 = Vector3.New(0, -400, 0)

				var_270_0.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1038, var_270_6, var_270_5)
			end

			if arg_267_1.time_ >= var_270_1 + var_270_4 and arg_267_1.time_ < var_270_1 + var_270_4 + arg_270_0 then
				var_270_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_270_7 = arg_267_1.actors_["1038"]
			local var_270_8 = 0

			if var_270_8 < arg_267_1.time_ and arg_267_1.time_ <= var_270_8 + arg_270_0 and not isNil(var_270_7) and arg_267_1.var_.actorSpriteComps1038 == nil then
				arg_267_1.var_.actorSpriteComps1038 = var_270_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_9 = 0.2

			if var_270_8 <= arg_267_1.time_ and arg_267_1.time_ < var_270_8 + var_270_9 and not isNil(var_270_7) then
				local var_270_10 = (arg_267_1.time_ - var_270_8) / var_270_9

				if arg_267_1.var_.actorSpriteComps1038 then
					for iter_270_1, iter_270_2 in pairs(arg_267_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_270_2 then
							if arg_267_1.isInRecall_ then
								local var_270_11 = Mathf.Lerp(iter_270_2.color.r, arg_267_1.hightColor1.r, var_270_10)
								local var_270_12 = Mathf.Lerp(iter_270_2.color.g, arg_267_1.hightColor1.g, var_270_10)
								local var_270_13 = Mathf.Lerp(iter_270_2.color.b, arg_267_1.hightColor1.b, var_270_10)

								iter_270_2.color = Color.New(var_270_11, var_270_12, var_270_13)
							else
								local var_270_14 = Mathf.Lerp(iter_270_2.color.r, 1, var_270_10)

								iter_270_2.color = Color.New(var_270_14, var_270_14, var_270_14)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_8 + var_270_9 and arg_267_1.time_ < var_270_8 + var_270_9 + arg_270_0 and not isNil(var_270_7) and arg_267_1.var_.actorSpriteComps1038 then
				for iter_270_3, iter_270_4 in pairs(arg_267_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_270_4 then
						if arg_267_1.isInRecall_ then
							iter_270_4.color = arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_270_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps1038 = nil
			end

			local var_270_15 = arg_267_1.actors_["1038"]
			local var_270_16 = 0

			if var_270_16 < arg_267_1.time_ and arg_267_1.time_ <= var_270_16 + arg_270_0 then
				local var_270_17 = var_270_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_270_17 then
					arg_267_1.var_.alphaOldValue1038 = var_270_17.alpha
					arg_267_1.var_.characterEffect1038 = var_270_17
				end

				arg_267_1.var_.alphaOldValue1038 = 0
			end

			local var_270_18 = 0.5

			if var_270_16 <= arg_267_1.time_ and arg_267_1.time_ < var_270_16 + var_270_18 then
				local var_270_19 = (arg_267_1.time_ - var_270_16) / var_270_18
				local var_270_20 = Mathf.Lerp(arg_267_1.var_.alphaOldValue1038, 1, var_270_19)

				if arg_267_1.var_.characterEffect1038 then
					arg_267_1.var_.characterEffect1038.alpha = var_270_20
				end
			end

			if arg_267_1.time_ >= var_270_16 + var_270_18 and arg_267_1.time_ < var_270_16 + var_270_18 + arg_270_0 and arg_267_1.var_.characterEffect1038 then
				arg_267_1.var_.characterEffect1038.alpha = 1
			end

			local var_270_21 = 0
			local var_270_22 = 0.8

			if var_270_21 < arg_267_1.time_ and arg_267_1.time_ <= var_270_21 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_23 = arg_267_1:FormatText(StoryNameCfg[94].name)

				arg_267_1.leftNameTxt_.text = var_270_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_24 = arg_267_1:GetWordFromCfg(115261065)
				local var_270_25 = arg_267_1:FormatText(var_270_24.content)

				arg_267_1.text_.text = var_270_25

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_26 = 32
				local var_270_27 = utf8.len(var_270_25)
				local var_270_28 = var_270_26 <= 0 and var_270_22 or var_270_22 * (var_270_27 / var_270_26)

				if var_270_28 > 0 and var_270_22 < var_270_28 then
					arg_267_1.talkMaxDuration = var_270_28

					if var_270_28 + var_270_21 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_28 + var_270_21
					end
				end

				arg_267_1.text_.text = var_270_25
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261065", "story_v_out_115261.awb") ~= 0 then
					local var_270_29 = manager.audio:GetVoiceLength("story_v_out_115261", "115261065", "story_v_out_115261.awb") / 1000

					if var_270_29 + var_270_21 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_29 + var_270_21
					end

					if var_270_24.prefab_name ~= "" and arg_267_1.actors_[var_270_24.prefab_name] ~= nil then
						local var_270_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_24.prefab_name].transform, "story_v_out_115261", "115261065", "story_v_out_115261.awb")

						arg_267_1:RecordAudio("115261065", var_270_30)
						arg_267_1:RecordAudio("115261065", var_270_30)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_115261", "115261065", "story_v_out_115261.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_115261", "115261065", "story_v_out_115261.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_31 = math.max(var_270_22, arg_267_1.talkMaxDuration)

			if var_270_21 <= arg_267_1.time_ and arg_267_1.time_ < var_270_21 + var_270_31 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_21) / var_270_31

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_21 + var_270_31 and arg_267_1.time_ < var_270_21 + var_270_31 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play115261066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 115261066
		arg_271_1.duration_ = 15.43

		local var_271_0 = {
			ja = 7.866,
			ko = 13.4,
			zh = 12.5,
			en = 15.433
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play115261067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 1.3

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_2 = arg_271_1:FormatText(StoryNameCfg[94].name)

				arg_271_1.leftNameTxt_.text = var_274_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_3 = arg_271_1:GetWordFromCfg(115261066)
				local var_274_4 = arg_271_1:FormatText(var_274_3.content)

				arg_271_1.text_.text = var_274_4

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 52
				local var_274_6 = utf8.len(var_274_4)
				local var_274_7 = var_274_5 <= 0 and var_274_1 or var_274_1 * (var_274_6 / var_274_5)

				if var_274_7 > 0 and var_274_1 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_4
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261066", "story_v_out_115261.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261066", "story_v_out_115261.awb") / 1000

					if var_274_8 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_0
					end

					if var_274_3.prefab_name ~= "" and arg_271_1.actors_[var_274_3.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_3.prefab_name].transform, "story_v_out_115261", "115261066", "story_v_out_115261.awb")

						arg_271_1:RecordAudio("115261066", var_274_9)
						arg_271_1:RecordAudio("115261066", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_115261", "115261066", "story_v_out_115261.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_115261", "115261066", "story_v_out_115261.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_10 and arg_271_1.time_ < var_274_0 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play115261067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 115261067
		arg_275_1.duration_ = 7.5

		local var_275_0 = {
			ja = 6.833,
			ko = 6.866,
			zh = 5.4,
			en = 7.5
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play115261068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1038"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps1038 == nil then
				arg_275_1.var_.actorSpriteComps1038 = var_278_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_2 = 0.2

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.actorSpriteComps1038 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								local var_278_4 = Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor2.r, var_278_3)
								local var_278_5 = Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor2.g, var_278_3)
								local var_278_6 = Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor2.b, var_278_3)

								iter_278_1.color = Color.New(var_278_4, var_278_5, var_278_6)
							else
								local var_278_7 = Mathf.Lerp(iter_278_1.color.r, 0.5, var_278_3)

								iter_278_1.color = Color.New(var_278_7, var_278_7, var_278_7)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps1038 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_278_3 then
						if arg_275_1.isInRecall_ then
							iter_278_3.color = arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_278_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps1038 = nil
			end

			local var_278_8 = 0
			local var_278_9 = 0.625

			if var_278_8 < arg_275_1.time_ and arg_275_1.time_ <= var_278_8 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_10 = arg_275_1:FormatText(StoryNameCfg[205].name)

				arg_275_1.leftNameTxt_.text = var_278_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_11 = arg_275_1:GetWordFromCfg(115261067)
				local var_278_12 = arg_275_1:FormatText(var_278_11.content)

				arg_275_1.text_.text = var_278_12

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_13 = 25
				local var_278_14 = utf8.len(var_278_12)
				local var_278_15 = var_278_13 <= 0 and var_278_9 or var_278_9 * (var_278_14 / var_278_13)

				if var_278_15 > 0 and var_278_9 < var_278_15 then
					arg_275_1.talkMaxDuration = var_278_15

					if var_278_15 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_15 + var_278_8
					end
				end

				arg_275_1.text_.text = var_278_12
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261067", "story_v_out_115261.awb") ~= 0 then
					local var_278_16 = manager.audio:GetVoiceLength("story_v_out_115261", "115261067", "story_v_out_115261.awb") / 1000

					if var_278_16 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_16 + var_278_8
					end

					if var_278_11.prefab_name ~= "" and arg_275_1.actors_[var_278_11.prefab_name] ~= nil then
						local var_278_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_11.prefab_name].transform, "story_v_out_115261", "115261067", "story_v_out_115261.awb")

						arg_275_1:RecordAudio("115261067", var_278_17)
						arg_275_1:RecordAudio("115261067", var_278_17)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_115261", "115261067", "story_v_out_115261.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_115261", "115261067", "story_v_out_115261.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_18 = math.max(var_278_9, arg_275_1.talkMaxDuration)

			if var_278_8 <= arg_275_1.time_ and arg_275_1.time_ < var_278_8 + var_278_18 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_8) / var_278_18

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_8 + var_278_18 and arg_275_1.time_ < var_278_8 + var_278_18 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play115261068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 115261068
		arg_279_1.duration_ = 2.4

		local var_279_0 = {
			ja = 0.999999999999,
			ko = 1.066,
			zh = 2.4,
			en = 0.999999999999
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play115261069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1038"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps1038 == nil then
				arg_279_1.var_.actorSpriteComps1038 = var_282_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_2 = 0.2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.actorSpriteComps1038 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_282_1 then
							if arg_279_1.isInRecall_ then
								local var_282_4 = Mathf.Lerp(iter_282_1.color.r, arg_279_1.hightColor1.r, var_282_3)
								local var_282_5 = Mathf.Lerp(iter_282_1.color.g, arg_279_1.hightColor1.g, var_282_3)
								local var_282_6 = Mathf.Lerp(iter_282_1.color.b, arg_279_1.hightColor1.b, var_282_3)

								iter_282_1.color = Color.New(var_282_4, var_282_5, var_282_6)
							else
								local var_282_7 = Mathf.Lerp(iter_282_1.color.r, 1, var_282_3)

								iter_282_1.color = Color.New(var_282_7, var_282_7, var_282_7)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps1038 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_282_3 then
						if arg_279_1.isInRecall_ then
							iter_282_3.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_282_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps1038 = nil
			end

			local var_282_8 = arg_279_1.actors_["1038"].transform
			local var_282_9 = 0

			if var_282_9 < arg_279_1.time_ and arg_279_1.time_ <= var_282_9 + arg_282_0 then
				arg_279_1.var_.moveOldPos1038 = var_282_8.localPosition
				var_282_8.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("1038", 3)

				local var_282_10 = var_282_8.childCount

				for iter_282_4 = 0, var_282_10 - 1 do
					local var_282_11 = var_282_8:GetChild(iter_282_4)

					if var_282_11.name == "split_9" or not string.find(var_282_11.name, "split") then
						var_282_11.gameObject:SetActive(true)
					else
						var_282_11.gameObject:SetActive(false)
					end
				end
			end

			local var_282_12 = 0.001

			if var_282_9 <= arg_279_1.time_ and arg_279_1.time_ < var_282_9 + var_282_12 then
				local var_282_13 = (arg_279_1.time_ - var_282_9) / var_282_12
				local var_282_14 = Vector3.New(0, -400, 0)

				var_282_8.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1038, var_282_14, var_282_13)
			end

			if arg_279_1.time_ >= var_282_9 + var_282_12 and arg_279_1.time_ < var_282_9 + var_282_12 + arg_282_0 then
				var_282_8.localPosition = Vector3.New(0, -400, 0)
			end

			local var_282_15 = 0
			local var_282_16 = 0.05

			if var_282_15 < arg_279_1.time_ and arg_279_1.time_ <= var_282_15 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_17 = arg_279_1:FormatText(StoryNameCfg[94].name)

				arg_279_1.leftNameTxt_.text = var_282_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_18 = arg_279_1:GetWordFromCfg(115261068)
				local var_282_19 = arg_279_1:FormatText(var_282_18.content)

				arg_279_1.text_.text = var_282_19

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_20 = 2
				local var_282_21 = utf8.len(var_282_19)
				local var_282_22 = var_282_20 <= 0 and var_282_16 or var_282_16 * (var_282_21 / var_282_20)

				if var_282_22 > 0 and var_282_16 < var_282_22 then
					arg_279_1.talkMaxDuration = var_282_22

					if var_282_22 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_22 + var_282_15
					end
				end

				arg_279_1.text_.text = var_282_19
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261068", "story_v_out_115261.awb") ~= 0 then
					local var_282_23 = manager.audio:GetVoiceLength("story_v_out_115261", "115261068", "story_v_out_115261.awb") / 1000

					if var_282_23 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_23 + var_282_15
					end

					if var_282_18.prefab_name ~= "" and arg_279_1.actors_[var_282_18.prefab_name] ~= nil then
						local var_282_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_18.prefab_name].transform, "story_v_out_115261", "115261068", "story_v_out_115261.awb")

						arg_279_1:RecordAudio("115261068", var_282_24)
						arg_279_1:RecordAudio("115261068", var_282_24)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_115261", "115261068", "story_v_out_115261.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_115261", "115261068", "story_v_out_115261.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_25 = math.max(var_282_16, arg_279_1.talkMaxDuration)

			if var_282_15 <= arg_279_1.time_ and arg_279_1.time_ < var_282_15 + var_282_25 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_15) / var_282_25

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_15 + var_282_25 and arg_279_1.time_ < var_282_15 + var_282_25 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play115261069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 115261069
		arg_283_1.duration_ = 4.4

		local var_283_0 = {
			ja = 3.333,
			ko = 3.433,
			zh = 4.4,
			en = 3.5
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play115261070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0
			local var_286_1 = 0.375

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_2 = arg_283_1:FormatText(StoryNameCfg[94].name)

				arg_283_1.leftNameTxt_.text = var_286_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_3 = arg_283_1:GetWordFromCfg(115261069)
				local var_286_4 = arg_283_1:FormatText(var_286_3.content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 15
				local var_286_6 = utf8.len(var_286_4)
				local var_286_7 = var_286_5 <= 0 and var_286_1 or var_286_1 * (var_286_6 / var_286_5)

				if var_286_7 > 0 and var_286_1 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_0
					end
				end

				arg_283_1.text_.text = var_286_4
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261069", "story_v_out_115261.awb") ~= 0 then
					local var_286_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261069", "story_v_out_115261.awb") / 1000

					if var_286_8 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_0
					end

					if var_286_3.prefab_name ~= "" and arg_283_1.actors_[var_286_3.prefab_name] ~= nil then
						local var_286_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_3.prefab_name].transform, "story_v_out_115261", "115261069", "story_v_out_115261.awb")

						arg_283_1:RecordAudio("115261069", var_286_9)
						arg_283_1:RecordAudio("115261069", var_286_9)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_115261", "115261069", "story_v_out_115261.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_115261", "115261069", "story_v_out_115261.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_10 = math.max(var_286_1, arg_283_1.talkMaxDuration)

			if var_286_0 <= arg_283_1.time_ and arg_283_1.time_ < var_286_0 + var_286_10 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_0) / var_286_10

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_0 + var_286_10 and arg_283_1.time_ < var_286_0 + var_286_10 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play115261070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 115261070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play115261071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1038"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				local var_290_2 = var_290_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_290_2 then
					arg_287_1.var_.alphaOldValue1038 = var_290_2.alpha
					arg_287_1.var_.characterEffect1038 = var_290_2
				end

				arg_287_1.var_.alphaOldValue1038 = 1
			end

			local var_290_3 = 0.333333333333333

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_3 then
				local var_290_4 = (arg_287_1.time_ - var_290_1) / var_290_3
				local var_290_5 = Mathf.Lerp(arg_287_1.var_.alphaOldValue1038, 0, var_290_4)

				if arg_287_1.var_.characterEffect1038 then
					arg_287_1.var_.characterEffect1038.alpha = var_290_5
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_3 and arg_287_1.time_ < var_290_1 + var_290_3 + arg_290_0 and arg_287_1.var_.characterEffect1038 then
				arg_287_1.var_.characterEffect1038.alpha = 0
			end

			local var_290_6 = 0
			local var_290_7 = 0.925

			if var_290_6 < arg_287_1.time_ and arg_287_1.time_ <= var_290_6 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_8 = arg_287_1:GetWordFromCfg(115261070)
				local var_290_9 = arg_287_1:FormatText(var_290_8.content)

				arg_287_1.text_.text = var_290_9

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_10 = 37
				local var_290_11 = utf8.len(var_290_9)
				local var_290_12 = var_290_10 <= 0 and var_290_7 or var_290_7 * (var_290_11 / var_290_10)

				if var_290_12 > 0 and var_290_7 < var_290_12 then
					arg_287_1.talkMaxDuration = var_290_12

					if var_290_12 + var_290_6 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_12 + var_290_6
					end
				end

				arg_287_1.text_.text = var_290_9
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_13 = math.max(var_290_7, arg_287_1.talkMaxDuration)

			if var_290_6 <= arg_287_1.time_ and arg_287_1.time_ < var_290_6 + var_290_13 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_6) / var_290_13

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_6 + var_290_13 and arg_287_1.time_ < var_290_6 + var_290_13 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play115261071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 115261071
		arg_291_1.duration_ = 7.73

		local var_291_0 = {
			ja = 5.433,
			ko = 5.733,
			zh = 7.733,
			en = 6.666
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play115261072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1038"].transform
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.var_.moveOldPos1038 = var_294_0.localPosition
				var_294_0.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("1038", 3)

				local var_294_2 = var_294_0.childCount

				for iter_294_0 = 0, var_294_2 - 1 do
					local var_294_3 = var_294_0:GetChild(iter_294_0)

					if var_294_3.name == "split_1" or not string.find(var_294_3.name, "split") then
						var_294_3.gameObject:SetActive(true)
					else
						var_294_3.gameObject:SetActive(false)
					end
				end
			end

			local var_294_4 = 0.001

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_4 then
				local var_294_5 = (arg_291_1.time_ - var_294_1) / var_294_4
				local var_294_6 = Vector3.New(0, -400, 0)

				var_294_0.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1038, var_294_6, var_294_5)
			end

			if arg_291_1.time_ >= var_294_1 + var_294_4 and arg_291_1.time_ < var_294_1 + var_294_4 + arg_294_0 then
				var_294_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_294_7 = arg_291_1.actors_["1038"]
			local var_294_8 = 0

			if var_294_8 < arg_291_1.time_ and arg_291_1.time_ <= var_294_8 + arg_294_0 and not isNil(var_294_7) and arg_291_1.var_.actorSpriteComps1038 == nil then
				arg_291_1.var_.actorSpriteComps1038 = var_294_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_9 = 0.2

			if var_294_8 <= arg_291_1.time_ and arg_291_1.time_ < var_294_8 + var_294_9 and not isNil(var_294_7) then
				local var_294_10 = (arg_291_1.time_ - var_294_8) / var_294_9

				if arg_291_1.var_.actorSpriteComps1038 then
					for iter_294_1, iter_294_2 in pairs(arg_291_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_294_2 then
							if arg_291_1.isInRecall_ then
								local var_294_11 = Mathf.Lerp(iter_294_2.color.r, arg_291_1.hightColor1.r, var_294_10)
								local var_294_12 = Mathf.Lerp(iter_294_2.color.g, arg_291_1.hightColor1.g, var_294_10)
								local var_294_13 = Mathf.Lerp(iter_294_2.color.b, arg_291_1.hightColor1.b, var_294_10)

								iter_294_2.color = Color.New(var_294_11, var_294_12, var_294_13)
							else
								local var_294_14 = Mathf.Lerp(iter_294_2.color.r, 1, var_294_10)

								iter_294_2.color = Color.New(var_294_14, var_294_14, var_294_14)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_8 + var_294_9 and arg_291_1.time_ < var_294_8 + var_294_9 + arg_294_0 and not isNil(var_294_7) and arg_291_1.var_.actorSpriteComps1038 then
				for iter_294_3, iter_294_4 in pairs(arg_291_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_294_4 then
						if arg_291_1.isInRecall_ then
							iter_294_4.color = arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_294_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps1038 = nil
			end

			local var_294_15 = arg_291_1.actors_["1038"]
			local var_294_16 = 0

			if var_294_16 < arg_291_1.time_ and arg_291_1.time_ <= var_294_16 + arg_294_0 then
				local var_294_17 = var_294_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_294_17 then
					arg_291_1.var_.alphaOldValue1038 = var_294_17.alpha
					arg_291_1.var_.characterEffect1038 = var_294_17
				end

				arg_291_1.var_.alphaOldValue1038 = 0
			end

			local var_294_18 = 0.5

			if var_294_16 <= arg_291_1.time_ and arg_291_1.time_ < var_294_16 + var_294_18 then
				local var_294_19 = (arg_291_1.time_ - var_294_16) / var_294_18
				local var_294_20 = Mathf.Lerp(arg_291_1.var_.alphaOldValue1038, 1, var_294_19)

				if arg_291_1.var_.characterEffect1038 then
					arg_291_1.var_.characterEffect1038.alpha = var_294_20
				end
			end

			if arg_291_1.time_ >= var_294_16 + var_294_18 and arg_291_1.time_ < var_294_16 + var_294_18 + arg_294_0 and arg_291_1.var_.characterEffect1038 then
				arg_291_1.var_.characterEffect1038.alpha = 1
			end

			local var_294_21 = 0
			local var_294_22 = 0.75

			if var_294_21 < arg_291_1.time_ and arg_291_1.time_ <= var_294_21 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_23 = arg_291_1:FormatText(StoryNameCfg[94].name)

				arg_291_1.leftNameTxt_.text = var_294_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_24 = arg_291_1:GetWordFromCfg(115261071)
				local var_294_25 = arg_291_1:FormatText(var_294_24.content)

				arg_291_1.text_.text = var_294_25

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_26 = 30
				local var_294_27 = utf8.len(var_294_25)
				local var_294_28 = var_294_26 <= 0 and var_294_22 or var_294_22 * (var_294_27 / var_294_26)

				if var_294_28 > 0 and var_294_22 < var_294_28 then
					arg_291_1.talkMaxDuration = var_294_28

					if var_294_28 + var_294_21 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_28 + var_294_21
					end
				end

				arg_291_1.text_.text = var_294_25
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261071", "story_v_out_115261.awb") ~= 0 then
					local var_294_29 = manager.audio:GetVoiceLength("story_v_out_115261", "115261071", "story_v_out_115261.awb") / 1000

					if var_294_29 + var_294_21 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_29 + var_294_21
					end

					if var_294_24.prefab_name ~= "" and arg_291_1.actors_[var_294_24.prefab_name] ~= nil then
						local var_294_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_24.prefab_name].transform, "story_v_out_115261", "115261071", "story_v_out_115261.awb")

						arg_291_1:RecordAudio("115261071", var_294_30)
						arg_291_1:RecordAudio("115261071", var_294_30)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_115261", "115261071", "story_v_out_115261.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_115261", "115261071", "story_v_out_115261.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_31 = math.max(var_294_22, arg_291_1.talkMaxDuration)

			if var_294_21 <= arg_291_1.time_ and arg_291_1.time_ < var_294_21 + var_294_31 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_21) / var_294_31

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_21 + var_294_31 and arg_291_1.time_ < var_294_21 + var_294_31 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play115261072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 115261072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play115261073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1038"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				local var_298_2 = var_298_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_298_2 then
					arg_295_1.var_.alphaOldValue1038 = var_298_2.alpha
					arg_295_1.var_.characterEffect1038 = var_298_2
				end

				arg_295_1.var_.alphaOldValue1038 = 1
			end

			local var_298_3 = 0.333333333333333

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_3 then
				local var_298_4 = (arg_295_1.time_ - var_298_1) / var_298_3
				local var_298_5 = Mathf.Lerp(arg_295_1.var_.alphaOldValue1038, 0, var_298_4)

				if arg_295_1.var_.characterEffect1038 then
					arg_295_1.var_.characterEffect1038.alpha = var_298_5
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_3 and arg_295_1.time_ < var_298_1 + var_298_3 + arg_298_0 and arg_295_1.var_.characterEffect1038 then
				arg_295_1.var_.characterEffect1038.alpha = 0
			end

			local var_298_6 = 0
			local var_298_7 = 0.3

			if var_298_6 < arg_295_1.time_ and arg_295_1.time_ <= var_298_6 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_8 = arg_295_1:GetWordFromCfg(115261072)
				local var_298_9 = arg_295_1:FormatText(var_298_8.content)

				arg_295_1.text_.text = var_298_9

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_10 = 12
				local var_298_11 = utf8.len(var_298_9)
				local var_298_12 = var_298_10 <= 0 and var_298_7 or var_298_7 * (var_298_11 / var_298_10)

				if var_298_12 > 0 and var_298_7 < var_298_12 then
					arg_295_1.talkMaxDuration = var_298_12

					if var_298_12 + var_298_6 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_12 + var_298_6
					end
				end

				arg_295_1.text_.text = var_298_9
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_13 = math.max(var_298_7, arg_295_1.talkMaxDuration)

			if var_298_6 <= arg_295_1.time_ and arg_295_1.time_ < var_298_6 + var_298_13 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_6) / var_298_13

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_6 + var_298_13 and arg_295_1.time_ < var_298_6 + var_298_13 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play115261073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 115261073
		arg_299_1.duration_ = 4.13

		local var_299_0 = {
			ja = 4.133,
			ko = 2.666,
			zh = 3.166,
			en = 2.333
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play115261074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1038"].transform
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.var_.moveOldPos1038 = var_302_0.localPosition
				var_302_0.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("1038", 2)

				local var_302_2 = var_302_0.childCount

				for iter_302_0 = 0, var_302_2 - 1 do
					local var_302_3 = var_302_0:GetChild(iter_302_0)

					if var_302_3.name == "split_1" or not string.find(var_302_3.name, "split") then
						var_302_3.gameObject:SetActive(true)
					else
						var_302_3.gameObject:SetActive(false)
					end
				end
			end

			local var_302_4 = 0.001

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_4 then
				local var_302_5 = (arg_299_1.time_ - var_302_1) / var_302_4
				local var_302_6 = Vector3.New(-390, -400, 0)

				var_302_0.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1038, var_302_6, var_302_5)
			end

			if arg_299_1.time_ >= var_302_1 + var_302_4 and arg_299_1.time_ < var_302_1 + var_302_4 + arg_302_0 then
				var_302_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_302_7 = arg_299_1.actors_["1038"]
			local var_302_8 = 0

			if var_302_8 < arg_299_1.time_ and arg_299_1.time_ <= var_302_8 + arg_302_0 and not isNil(var_302_7) and arg_299_1.var_.actorSpriteComps1038 == nil then
				arg_299_1.var_.actorSpriteComps1038 = var_302_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_9 = 0.2

			if var_302_8 <= arg_299_1.time_ and arg_299_1.time_ < var_302_8 + var_302_9 and not isNil(var_302_7) then
				local var_302_10 = (arg_299_1.time_ - var_302_8) / var_302_9

				if arg_299_1.var_.actorSpriteComps1038 then
					for iter_302_1, iter_302_2 in pairs(arg_299_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_302_2 then
							if arg_299_1.isInRecall_ then
								local var_302_11 = Mathf.Lerp(iter_302_2.color.r, arg_299_1.hightColor1.r, var_302_10)
								local var_302_12 = Mathf.Lerp(iter_302_2.color.g, arg_299_1.hightColor1.g, var_302_10)
								local var_302_13 = Mathf.Lerp(iter_302_2.color.b, arg_299_1.hightColor1.b, var_302_10)

								iter_302_2.color = Color.New(var_302_11, var_302_12, var_302_13)
							else
								local var_302_14 = Mathf.Lerp(iter_302_2.color.r, 1, var_302_10)

								iter_302_2.color = Color.New(var_302_14, var_302_14, var_302_14)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= var_302_8 + var_302_9 and arg_299_1.time_ < var_302_8 + var_302_9 + arg_302_0 and not isNil(var_302_7) and arg_299_1.var_.actorSpriteComps1038 then
				for iter_302_3, iter_302_4 in pairs(arg_299_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_302_4 then
						if arg_299_1.isInRecall_ then
							iter_302_4.color = arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_302_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps1038 = nil
			end

			local var_302_15 = arg_299_1.actors_["1038"]
			local var_302_16 = 0

			if var_302_16 < arg_299_1.time_ and arg_299_1.time_ <= var_302_16 + arg_302_0 then
				local var_302_17 = var_302_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_302_17 then
					arg_299_1.var_.alphaOldValue1038 = var_302_17.alpha
					arg_299_1.var_.characterEffect1038 = var_302_17
				end

				arg_299_1.var_.alphaOldValue1038 = 0
			end

			local var_302_18 = 0.5

			if var_302_16 <= arg_299_1.time_ and arg_299_1.time_ < var_302_16 + var_302_18 then
				local var_302_19 = (arg_299_1.time_ - var_302_16) / var_302_18
				local var_302_20 = Mathf.Lerp(arg_299_1.var_.alphaOldValue1038, 1, var_302_19)

				if arg_299_1.var_.characterEffect1038 then
					arg_299_1.var_.characterEffect1038.alpha = var_302_20
				end
			end

			if arg_299_1.time_ >= var_302_16 + var_302_18 and arg_299_1.time_ < var_302_16 + var_302_18 + arg_302_0 and arg_299_1.var_.characterEffect1038 then
				arg_299_1.var_.characterEffect1038.alpha = 1
			end

			local var_302_21 = arg_299_1.actors_["10030"].transform
			local var_302_22 = 0

			if var_302_22 < arg_299_1.time_ and arg_299_1.time_ <= var_302_22 + arg_302_0 then
				arg_299_1.var_.moveOldPos10030 = var_302_21.localPosition
				var_302_21.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10030", 4)

				local var_302_23 = var_302_21.childCount

				for iter_302_5 = 0, var_302_23 - 1 do
					local var_302_24 = var_302_21:GetChild(iter_302_5)

					if var_302_24.name == "split_1" or not string.find(var_302_24.name, "split") then
						var_302_24.gameObject:SetActive(true)
					else
						var_302_24.gameObject:SetActive(false)
					end
				end
			end

			local var_302_25 = 0.001

			if var_302_22 <= arg_299_1.time_ and arg_299_1.time_ < var_302_22 + var_302_25 then
				local var_302_26 = (arg_299_1.time_ - var_302_22) / var_302_25
				local var_302_27 = Vector3.New(390, -390, 150)

				var_302_21.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10030, var_302_27, var_302_26)
			end

			if arg_299_1.time_ >= var_302_22 + var_302_25 and arg_299_1.time_ < var_302_22 + var_302_25 + arg_302_0 then
				var_302_21.localPosition = Vector3.New(390, -390, 150)
			end

			local var_302_28 = arg_299_1.actors_["10030"]
			local var_302_29 = 0

			if var_302_29 < arg_299_1.time_ and arg_299_1.time_ <= var_302_29 + arg_302_0 then
				local var_302_30 = var_302_28:GetComponentInChildren(typeof(CanvasGroup))

				if var_302_30 then
					arg_299_1.var_.alphaOldValue10030 = var_302_30.alpha
					arg_299_1.var_.characterEffect10030 = var_302_30
				end

				arg_299_1.var_.alphaOldValue10030 = 0
			end

			local var_302_31 = 0.5

			if var_302_29 <= arg_299_1.time_ and arg_299_1.time_ < var_302_29 + var_302_31 then
				local var_302_32 = (arg_299_1.time_ - var_302_29) / var_302_31
				local var_302_33 = Mathf.Lerp(arg_299_1.var_.alphaOldValue10030, 1, var_302_32)

				if arg_299_1.var_.characterEffect10030 then
					arg_299_1.var_.characterEffect10030.alpha = var_302_33
				end
			end

			if arg_299_1.time_ >= var_302_29 + var_302_31 and arg_299_1.time_ < var_302_29 + var_302_31 + arg_302_0 and arg_299_1.var_.characterEffect10030 then
				arg_299_1.var_.characterEffect10030.alpha = 1
			end

			local var_302_34 = arg_299_1.actors_["10030"]
			local var_302_35 = 0

			if var_302_35 < arg_299_1.time_ and arg_299_1.time_ <= var_302_35 + arg_302_0 and not isNil(var_302_34) and arg_299_1.var_.actorSpriteComps10030 == nil then
				arg_299_1.var_.actorSpriteComps10030 = var_302_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_36 = 0.2

			if var_302_35 <= arg_299_1.time_ and arg_299_1.time_ < var_302_35 + var_302_36 and not isNil(var_302_34) then
				local var_302_37 = (arg_299_1.time_ - var_302_35) / var_302_36

				if arg_299_1.var_.actorSpriteComps10030 then
					for iter_302_6, iter_302_7 in pairs(arg_299_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_302_7 then
							if arg_299_1.isInRecall_ then
								local var_302_38 = Mathf.Lerp(iter_302_7.color.r, arg_299_1.hightColor2.r, var_302_37)
								local var_302_39 = Mathf.Lerp(iter_302_7.color.g, arg_299_1.hightColor2.g, var_302_37)
								local var_302_40 = Mathf.Lerp(iter_302_7.color.b, arg_299_1.hightColor2.b, var_302_37)

								iter_302_7.color = Color.New(var_302_38, var_302_39, var_302_40)
							else
								local var_302_41 = Mathf.Lerp(iter_302_7.color.r, 0.5, var_302_37)

								iter_302_7.color = Color.New(var_302_41, var_302_41, var_302_41)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= var_302_35 + var_302_36 and arg_299_1.time_ < var_302_35 + var_302_36 + arg_302_0 and not isNil(var_302_34) and arg_299_1.var_.actorSpriteComps10030 then
				for iter_302_8, iter_302_9 in pairs(arg_299_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_302_9 then
						if arg_299_1.isInRecall_ then
							iter_302_9.color = arg_299_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_302_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps10030 = nil
			end

			local var_302_42 = 0
			local var_302_43 = 0.275

			if var_302_42 < arg_299_1.time_ and arg_299_1.time_ <= var_302_42 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_44 = arg_299_1:FormatText(StoryNameCfg[94].name)

				arg_299_1.leftNameTxt_.text = var_302_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_45 = arg_299_1:GetWordFromCfg(115261073)
				local var_302_46 = arg_299_1:FormatText(var_302_45.content)

				arg_299_1.text_.text = var_302_46

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_47 = 11
				local var_302_48 = utf8.len(var_302_46)
				local var_302_49 = var_302_47 <= 0 and var_302_43 or var_302_43 * (var_302_48 / var_302_47)

				if var_302_49 > 0 and var_302_43 < var_302_49 then
					arg_299_1.talkMaxDuration = var_302_49

					if var_302_49 + var_302_42 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_49 + var_302_42
					end
				end

				arg_299_1.text_.text = var_302_46
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261073", "story_v_out_115261.awb") ~= 0 then
					local var_302_50 = manager.audio:GetVoiceLength("story_v_out_115261", "115261073", "story_v_out_115261.awb") / 1000

					if var_302_50 + var_302_42 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_50 + var_302_42
					end

					if var_302_45.prefab_name ~= "" and arg_299_1.actors_[var_302_45.prefab_name] ~= nil then
						local var_302_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_45.prefab_name].transform, "story_v_out_115261", "115261073", "story_v_out_115261.awb")

						arg_299_1:RecordAudio("115261073", var_302_51)
						arg_299_1:RecordAudio("115261073", var_302_51)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_115261", "115261073", "story_v_out_115261.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_115261", "115261073", "story_v_out_115261.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_52 = math.max(var_302_43, arg_299_1.talkMaxDuration)

			if var_302_42 <= arg_299_1.time_ and arg_299_1.time_ < var_302_42 + var_302_52 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_42) / var_302_52

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_42 + var_302_52 and arg_299_1.time_ < var_302_42 + var_302_52 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play115261074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 115261074
		arg_303_1.duration_ = 19.03

		local var_303_0 = {
			ja = 12.5,
			ko = 8.166,
			zh = 7.9,
			en = 19.033
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play115261075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0
			local var_306_1 = 0.875

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_2 = arg_303_1:FormatText(StoryNameCfg[94].name)

				arg_303_1.leftNameTxt_.text = var_306_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:GetWordFromCfg(115261074)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 35
				local var_306_6 = utf8.len(var_306_4)
				local var_306_7 = var_306_5 <= 0 and var_306_1 or var_306_1 * (var_306_6 / var_306_5)

				if var_306_7 > 0 and var_306_1 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_0
					end
				end

				arg_303_1.text_.text = var_306_4
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261074", "story_v_out_115261.awb") ~= 0 then
					local var_306_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261074", "story_v_out_115261.awb") / 1000

					if var_306_8 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_0
					end

					if var_306_3.prefab_name ~= "" and arg_303_1.actors_[var_306_3.prefab_name] ~= nil then
						local var_306_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_3.prefab_name].transform, "story_v_out_115261", "115261074", "story_v_out_115261.awb")

						arg_303_1:RecordAudio("115261074", var_306_9)
						arg_303_1:RecordAudio("115261074", var_306_9)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_115261", "115261074", "story_v_out_115261.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_115261", "115261074", "story_v_out_115261.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_10 = math.max(var_306_1, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_10 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_0) / var_306_10

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_10 and arg_303_1.time_ < var_306_0 + var_306_10 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play115261075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 115261075
		arg_307_1.duration_ = 3.83

		local var_307_0 = {
			ja = 2.7,
			ko = 2.8,
			zh = 3.333,
			en = 3.833
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play115261076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1038"].transform
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.var_.moveOldPos1038 = var_310_0.localPosition
				var_310_0.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("1038", 2)

				local var_310_2 = var_310_0.childCount

				for iter_310_0 = 0, var_310_2 - 1 do
					local var_310_3 = var_310_0:GetChild(iter_310_0)

					if var_310_3.name == "split_1" or not string.find(var_310_3.name, "split") then
						var_310_3.gameObject:SetActive(true)
					else
						var_310_3.gameObject:SetActive(false)
					end
				end
			end

			local var_310_4 = 0.001

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_4 then
				local var_310_5 = (arg_307_1.time_ - var_310_1) / var_310_4
				local var_310_6 = Vector3.New(-390, -400, 0)

				var_310_0.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1038, var_310_6, var_310_5)
			end

			if arg_307_1.time_ >= var_310_1 + var_310_4 and arg_307_1.time_ < var_310_1 + var_310_4 + arg_310_0 then
				var_310_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_310_7 = arg_307_1.actors_["1038"]
			local var_310_8 = 0

			if var_310_8 < arg_307_1.time_ and arg_307_1.time_ <= var_310_8 + arg_310_0 and not isNil(var_310_7) and arg_307_1.var_.actorSpriteComps1038 == nil then
				arg_307_1.var_.actorSpriteComps1038 = var_310_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_9 = 0.2

			if var_310_8 <= arg_307_1.time_ and arg_307_1.time_ < var_310_8 + var_310_9 and not isNil(var_310_7) then
				local var_310_10 = (arg_307_1.time_ - var_310_8) / var_310_9

				if arg_307_1.var_.actorSpriteComps1038 then
					for iter_310_1, iter_310_2 in pairs(arg_307_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_310_2 then
							if arg_307_1.isInRecall_ then
								local var_310_11 = Mathf.Lerp(iter_310_2.color.r, arg_307_1.hightColor2.r, var_310_10)
								local var_310_12 = Mathf.Lerp(iter_310_2.color.g, arg_307_1.hightColor2.g, var_310_10)
								local var_310_13 = Mathf.Lerp(iter_310_2.color.b, arg_307_1.hightColor2.b, var_310_10)

								iter_310_2.color = Color.New(var_310_11, var_310_12, var_310_13)
							else
								local var_310_14 = Mathf.Lerp(iter_310_2.color.r, 0.5, var_310_10)

								iter_310_2.color = Color.New(var_310_14, var_310_14, var_310_14)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= var_310_8 + var_310_9 and arg_307_1.time_ < var_310_8 + var_310_9 + arg_310_0 and not isNil(var_310_7) and arg_307_1.var_.actorSpriteComps1038 then
				for iter_310_3, iter_310_4 in pairs(arg_307_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_310_4 then
						if arg_307_1.isInRecall_ then
							iter_310_4.color = arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_310_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps1038 = nil
			end

			local var_310_15 = arg_307_1.actors_["10030"]
			local var_310_16 = 0

			if var_310_16 < arg_307_1.time_ and arg_307_1.time_ <= var_310_16 + arg_310_0 and not isNil(var_310_15) and arg_307_1.var_.actorSpriteComps10030 == nil then
				arg_307_1.var_.actorSpriteComps10030 = var_310_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_17 = 0.2

			if var_310_16 <= arg_307_1.time_ and arg_307_1.time_ < var_310_16 + var_310_17 and not isNil(var_310_15) then
				local var_310_18 = (arg_307_1.time_ - var_310_16) / var_310_17

				if arg_307_1.var_.actorSpriteComps10030 then
					for iter_310_5, iter_310_6 in pairs(arg_307_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_310_6 then
							if arg_307_1.isInRecall_ then
								local var_310_19 = Mathf.Lerp(iter_310_6.color.r, arg_307_1.hightColor1.r, var_310_18)
								local var_310_20 = Mathf.Lerp(iter_310_6.color.g, arg_307_1.hightColor1.g, var_310_18)
								local var_310_21 = Mathf.Lerp(iter_310_6.color.b, arg_307_1.hightColor1.b, var_310_18)

								iter_310_6.color = Color.New(var_310_19, var_310_20, var_310_21)
							else
								local var_310_22 = Mathf.Lerp(iter_310_6.color.r, 1, var_310_18)

								iter_310_6.color = Color.New(var_310_22, var_310_22, var_310_22)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= var_310_16 + var_310_17 and arg_307_1.time_ < var_310_16 + var_310_17 + arg_310_0 and not isNil(var_310_15) and arg_307_1.var_.actorSpriteComps10030 then
				for iter_310_7, iter_310_8 in pairs(arg_307_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_310_8 then
						if arg_307_1.isInRecall_ then
							iter_310_8.color = arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_310_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps10030 = nil
			end

			local var_310_23 = 0
			local var_310_24 = 0.225

			if var_310_23 < arg_307_1.time_ and arg_307_1.time_ <= var_310_23 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_25 = arg_307_1:FormatText(StoryNameCfg[309].name)

				arg_307_1.leftNameTxt_.text = var_310_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_26 = arg_307_1:GetWordFromCfg(115261075)
				local var_310_27 = arg_307_1:FormatText(var_310_26.content)

				arg_307_1.text_.text = var_310_27

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_28 = 9
				local var_310_29 = utf8.len(var_310_27)
				local var_310_30 = var_310_28 <= 0 and var_310_24 or var_310_24 * (var_310_29 / var_310_28)

				if var_310_30 > 0 and var_310_24 < var_310_30 then
					arg_307_1.talkMaxDuration = var_310_30

					if var_310_30 + var_310_23 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_30 + var_310_23
					end
				end

				arg_307_1.text_.text = var_310_27
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261075", "story_v_out_115261.awb") ~= 0 then
					local var_310_31 = manager.audio:GetVoiceLength("story_v_out_115261", "115261075", "story_v_out_115261.awb") / 1000

					if var_310_31 + var_310_23 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_31 + var_310_23
					end

					if var_310_26.prefab_name ~= "" and arg_307_1.actors_[var_310_26.prefab_name] ~= nil then
						local var_310_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_26.prefab_name].transform, "story_v_out_115261", "115261075", "story_v_out_115261.awb")

						arg_307_1:RecordAudio("115261075", var_310_32)
						arg_307_1:RecordAudio("115261075", var_310_32)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_115261", "115261075", "story_v_out_115261.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_115261", "115261075", "story_v_out_115261.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_33 = math.max(var_310_24, arg_307_1.talkMaxDuration)

			if var_310_23 <= arg_307_1.time_ and arg_307_1.time_ < var_310_23 + var_310_33 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_23) / var_310_33

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_23 + var_310_33 and arg_307_1.time_ < var_310_23 + var_310_33 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play115261076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 115261076
		arg_311_1.duration_ = 14.17

		local var_311_0 = {
			ja = 14.166,
			ko = 12.2,
			zh = 11.933,
			en = 14.166
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play115261077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1038"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps1038 == nil then
				arg_311_1.var_.actorSpriteComps1038 = var_314_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_2 = 0.2

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.actorSpriteComps1038 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								local var_314_4 = Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor1.r, var_314_3)
								local var_314_5 = Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor1.g, var_314_3)
								local var_314_6 = Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor1.b, var_314_3)

								iter_314_1.color = Color.New(var_314_4, var_314_5, var_314_6)
							else
								local var_314_7 = Mathf.Lerp(iter_314_1.color.r, 1, var_314_3)

								iter_314_1.color = Color.New(var_314_7, var_314_7, var_314_7)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps1038 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_314_3 then
						if arg_311_1.isInRecall_ then
							iter_314_3.color = arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_314_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps1038 = nil
			end

			local var_314_8 = arg_311_1.actors_["10030"]
			local var_314_9 = 0

			if var_314_9 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 and not isNil(var_314_8) and arg_311_1.var_.actorSpriteComps10030 == nil then
				arg_311_1.var_.actorSpriteComps10030 = var_314_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_10 = 0.2

			if var_314_9 <= arg_311_1.time_ and arg_311_1.time_ < var_314_9 + var_314_10 and not isNil(var_314_8) then
				local var_314_11 = (arg_311_1.time_ - var_314_9) / var_314_10

				if arg_311_1.var_.actorSpriteComps10030 then
					for iter_314_4, iter_314_5 in pairs(arg_311_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_314_5 then
							if arg_311_1.isInRecall_ then
								local var_314_12 = Mathf.Lerp(iter_314_5.color.r, arg_311_1.hightColor2.r, var_314_11)
								local var_314_13 = Mathf.Lerp(iter_314_5.color.g, arg_311_1.hightColor2.g, var_314_11)
								local var_314_14 = Mathf.Lerp(iter_314_5.color.b, arg_311_1.hightColor2.b, var_314_11)

								iter_314_5.color = Color.New(var_314_12, var_314_13, var_314_14)
							else
								local var_314_15 = Mathf.Lerp(iter_314_5.color.r, 0.5, var_314_11)

								iter_314_5.color = Color.New(var_314_15, var_314_15, var_314_15)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_9 + var_314_10 and arg_311_1.time_ < var_314_9 + var_314_10 + arg_314_0 and not isNil(var_314_8) and arg_311_1.var_.actorSpriteComps10030 then
				for iter_314_6, iter_314_7 in pairs(arg_311_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_314_7 then
						if arg_311_1.isInRecall_ then
							iter_314_7.color = arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_314_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps10030 = nil
			end

			local var_314_16 = 0
			local var_314_17 = 1.325

			if var_314_16 < arg_311_1.time_ and arg_311_1.time_ <= var_314_16 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_18 = arg_311_1:FormatText(StoryNameCfg[94].name)

				arg_311_1.leftNameTxt_.text = var_314_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_19 = arg_311_1:GetWordFromCfg(115261076)
				local var_314_20 = arg_311_1:FormatText(var_314_19.content)

				arg_311_1.text_.text = var_314_20

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_21 = 53
				local var_314_22 = utf8.len(var_314_20)
				local var_314_23 = var_314_21 <= 0 and var_314_17 or var_314_17 * (var_314_22 / var_314_21)

				if var_314_23 > 0 and var_314_17 < var_314_23 then
					arg_311_1.talkMaxDuration = var_314_23

					if var_314_23 + var_314_16 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_23 + var_314_16
					end
				end

				arg_311_1.text_.text = var_314_20
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261076", "story_v_out_115261.awb") ~= 0 then
					local var_314_24 = manager.audio:GetVoiceLength("story_v_out_115261", "115261076", "story_v_out_115261.awb") / 1000

					if var_314_24 + var_314_16 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_24 + var_314_16
					end

					if var_314_19.prefab_name ~= "" and arg_311_1.actors_[var_314_19.prefab_name] ~= nil then
						local var_314_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_19.prefab_name].transform, "story_v_out_115261", "115261076", "story_v_out_115261.awb")

						arg_311_1:RecordAudio("115261076", var_314_25)
						arg_311_1:RecordAudio("115261076", var_314_25)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_115261", "115261076", "story_v_out_115261.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_115261", "115261076", "story_v_out_115261.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_26 = math.max(var_314_17, arg_311_1.talkMaxDuration)

			if var_314_16 <= arg_311_1.time_ and arg_311_1.time_ < var_314_16 + var_314_26 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_16) / var_314_26

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_16 + var_314_26 and arg_311_1.time_ < var_314_16 + var_314_26 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play115261077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 115261077
		arg_315_1.duration_ = 10.4

		local var_315_0 = {
			ja = 10.4,
			ko = 7.766,
			zh = 10.166,
			en = 8.333
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play115261078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1038"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps1038 == nil then
				arg_315_1.var_.actorSpriteComps1038 = var_318_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_2 = 0.2

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.actorSpriteComps1038 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								local var_318_4 = Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor2.r, var_318_3)
								local var_318_5 = Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor2.g, var_318_3)
								local var_318_6 = Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor2.b, var_318_3)

								iter_318_1.color = Color.New(var_318_4, var_318_5, var_318_6)
							else
								local var_318_7 = Mathf.Lerp(iter_318_1.color.r, 0.5, var_318_3)

								iter_318_1.color = Color.New(var_318_7, var_318_7, var_318_7)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps1038 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_318_3 then
						if arg_315_1.isInRecall_ then
							iter_318_3.color = arg_315_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_318_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps1038 = nil
			end

			local var_318_8 = arg_315_1.actors_["10030"]
			local var_318_9 = 0

			if var_318_9 < arg_315_1.time_ and arg_315_1.time_ <= var_318_9 + arg_318_0 and not isNil(var_318_8) and arg_315_1.var_.actorSpriteComps10030 == nil then
				arg_315_1.var_.actorSpriteComps10030 = var_318_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_10 = 0.2

			if var_318_9 <= arg_315_1.time_ and arg_315_1.time_ < var_318_9 + var_318_10 and not isNil(var_318_8) then
				local var_318_11 = (arg_315_1.time_ - var_318_9) / var_318_10

				if arg_315_1.var_.actorSpriteComps10030 then
					for iter_318_4, iter_318_5 in pairs(arg_315_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_318_5 then
							if arg_315_1.isInRecall_ then
								local var_318_12 = Mathf.Lerp(iter_318_5.color.r, arg_315_1.hightColor1.r, var_318_11)
								local var_318_13 = Mathf.Lerp(iter_318_5.color.g, arg_315_1.hightColor1.g, var_318_11)
								local var_318_14 = Mathf.Lerp(iter_318_5.color.b, arg_315_1.hightColor1.b, var_318_11)

								iter_318_5.color = Color.New(var_318_12, var_318_13, var_318_14)
							else
								local var_318_15 = Mathf.Lerp(iter_318_5.color.r, 1, var_318_11)

								iter_318_5.color = Color.New(var_318_15, var_318_15, var_318_15)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= var_318_9 + var_318_10 and arg_315_1.time_ < var_318_9 + var_318_10 + arg_318_0 and not isNil(var_318_8) and arg_315_1.var_.actorSpriteComps10030 then
				for iter_318_6, iter_318_7 in pairs(arg_315_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_318_7 then
						if arg_315_1.isInRecall_ then
							iter_318_7.color = arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_318_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps10030 = nil
			end

			local var_318_16 = arg_315_1.actors_["10030"].transform
			local var_318_17 = 0

			if var_318_17 < arg_315_1.time_ and arg_315_1.time_ <= var_318_17 + arg_318_0 then
				arg_315_1.var_.moveOldPos10030 = var_318_16.localPosition
				var_318_16.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("10030", 4)

				local var_318_18 = var_318_16.childCount

				for iter_318_8 = 0, var_318_18 - 1 do
					local var_318_19 = var_318_16:GetChild(iter_318_8)

					if var_318_19.name == "split_5" or not string.find(var_318_19.name, "split") then
						var_318_19.gameObject:SetActive(true)
					else
						var_318_19.gameObject:SetActive(false)
					end
				end
			end

			local var_318_20 = 0.001

			if var_318_17 <= arg_315_1.time_ and arg_315_1.time_ < var_318_17 + var_318_20 then
				local var_318_21 = (arg_315_1.time_ - var_318_17) / var_318_20
				local var_318_22 = Vector3.New(390, -390, 150)

				var_318_16.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos10030, var_318_22, var_318_21)
			end

			if arg_315_1.time_ >= var_318_17 + var_318_20 and arg_315_1.time_ < var_318_17 + var_318_20 + arg_318_0 then
				var_318_16.localPosition = Vector3.New(390, -390, 150)
			end

			local var_318_23 = 0
			local var_318_24 = 0.75

			if var_318_23 < arg_315_1.time_ and arg_315_1.time_ <= var_318_23 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_25 = arg_315_1:FormatText(StoryNameCfg[309].name)

				arg_315_1.leftNameTxt_.text = var_318_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_26 = arg_315_1:GetWordFromCfg(115261077)
				local var_318_27 = arg_315_1:FormatText(var_318_26.content)

				arg_315_1.text_.text = var_318_27

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_28 = 38
				local var_318_29 = utf8.len(var_318_27)
				local var_318_30 = var_318_28 <= 0 and var_318_24 or var_318_24 * (var_318_29 / var_318_28)

				if var_318_30 > 0 and var_318_24 < var_318_30 then
					arg_315_1.talkMaxDuration = var_318_30

					if var_318_30 + var_318_23 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_30 + var_318_23
					end
				end

				arg_315_1.text_.text = var_318_27
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261077", "story_v_out_115261.awb") ~= 0 then
					local var_318_31 = manager.audio:GetVoiceLength("story_v_out_115261", "115261077", "story_v_out_115261.awb") / 1000

					if var_318_31 + var_318_23 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_31 + var_318_23
					end

					if var_318_26.prefab_name ~= "" and arg_315_1.actors_[var_318_26.prefab_name] ~= nil then
						local var_318_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_26.prefab_name].transform, "story_v_out_115261", "115261077", "story_v_out_115261.awb")

						arg_315_1:RecordAudio("115261077", var_318_32)
						arg_315_1:RecordAudio("115261077", var_318_32)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_115261", "115261077", "story_v_out_115261.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_115261", "115261077", "story_v_out_115261.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_33 = math.max(var_318_24, arg_315_1.talkMaxDuration)

			if var_318_23 <= arg_315_1.time_ and arg_315_1.time_ < var_318_23 + var_318_33 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_23) / var_318_33

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_23 + var_318_33 and arg_315_1.time_ < var_318_23 + var_318_33 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play115261078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 115261078
		arg_319_1.duration_ = 12.17

		local var_319_0 = {
			ja = 12.166,
			ko = 7.4,
			zh = 6.2,
			en = 7.933
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play115261079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["10030"].transform
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.var_.moveOldPos10030 = var_322_0.localPosition
				var_322_0.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("10030", 4)

				local var_322_2 = var_322_0.childCount

				for iter_322_0 = 0, var_322_2 - 1 do
					local var_322_3 = var_322_0:GetChild(iter_322_0)

					if var_322_3.name == "split_3" or not string.find(var_322_3.name, "split") then
						var_322_3.gameObject:SetActive(true)
					else
						var_322_3.gameObject:SetActive(false)
					end
				end
			end

			local var_322_4 = 0.001

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_4 then
				local var_322_5 = (arg_319_1.time_ - var_322_1) / var_322_4
				local var_322_6 = Vector3.New(390, -390, 150)

				var_322_0.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10030, var_322_6, var_322_5)
			end

			if arg_319_1.time_ >= var_322_1 + var_322_4 and arg_319_1.time_ < var_322_1 + var_322_4 + arg_322_0 then
				var_322_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_322_7 = arg_319_1.actors_["10030"]
			local var_322_8 = 0

			if var_322_8 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 then
				local var_322_9 = var_322_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_322_9 then
					arg_319_1.var_.alphaOldValue10030 = var_322_9.alpha
					arg_319_1.var_.characterEffect10030 = var_322_9
				end

				arg_319_1.var_.alphaOldValue10030 = 0
			end

			local var_322_10 = 0.0166666666666667

			if var_322_8 <= arg_319_1.time_ and arg_319_1.time_ < var_322_8 + var_322_10 then
				local var_322_11 = (arg_319_1.time_ - var_322_8) / var_322_10
				local var_322_12 = Mathf.Lerp(arg_319_1.var_.alphaOldValue10030, 1, var_322_11)

				if arg_319_1.var_.characterEffect10030 then
					arg_319_1.var_.characterEffect10030.alpha = var_322_12
				end
			end

			if arg_319_1.time_ >= var_322_8 + var_322_10 and arg_319_1.time_ < var_322_8 + var_322_10 + arg_322_0 and arg_319_1.var_.characterEffect10030 then
				arg_319_1.var_.characterEffect10030.alpha = 1
			end

			local var_322_13 = 0
			local var_322_14 = 0.75

			if var_322_13 < arg_319_1.time_ and arg_319_1.time_ <= var_322_13 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_15 = arg_319_1:FormatText(StoryNameCfg[309].name)

				arg_319_1.leftNameTxt_.text = var_322_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_16 = arg_319_1:GetWordFromCfg(115261078)
				local var_322_17 = arg_319_1:FormatText(var_322_16.content)

				arg_319_1.text_.text = var_322_17

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_18 = 30
				local var_322_19 = utf8.len(var_322_17)
				local var_322_20 = var_322_18 <= 0 and var_322_14 or var_322_14 * (var_322_19 / var_322_18)

				if var_322_20 > 0 and var_322_14 < var_322_20 then
					arg_319_1.talkMaxDuration = var_322_20

					if var_322_20 + var_322_13 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_20 + var_322_13
					end
				end

				arg_319_1.text_.text = var_322_17
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261078", "story_v_out_115261.awb") ~= 0 then
					local var_322_21 = manager.audio:GetVoiceLength("story_v_out_115261", "115261078", "story_v_out_115261.awb") / 1000

					if var_322_21 + var_322_13 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_21 + var_322_13
					end

					if var_322_16.prefab_name ~= "" and arg_319_1.actors_[var_322_16.prefab_name] ~= nil then
						local var_322_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_16.prefab_name].transform, "story_v_out_115261", "115261078", "story_v_out_115261.awb")

						arg_319_1:RecordAudio("115261078", var_322_22)
						arg_319_1:RecordAudio("115261078", var_322_22)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_115261", "115261078", "story_v_out_115261.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_115261", "115261078", "story_v_out_115261.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_23 = math.max(var_322_14, arg_319_1.talkMaxDuration)

			if var_322_13 <= arg_319_1.time_ and arg_319_1.time_ < var_322_13 + var_322_23 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_13) / var_322_23

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_13 + var_322_23 and arg_319_1.time_ < var_322_13 + var_322_23 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play115261079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 115261079
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play115261080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["10030"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				local var_326_2 = var_326_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_326_2 then
					arg_323_1.var_.alphaOldValue10030 = var_326_2.alpha
					arg_323_1.var_.characterEffect10030 = var_326_2
				end

				arg_323_1.var_.alphaOldValue10030 = 1
			end

			local var_326_3 = 0.333333333333333

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_3 then
				local var_326_4 = (arg_323_1.time_ - var_326_1) / var_326_3
				local var_326_5 = Mathf.Lerp(arg_323_1.var_.alphaOldValue10030, 0, var_326_4)

				if arg_323_1.var_.characterEffect10030 then
					arg_323_1.var_.characterEffect10030.alpha = var_326_5
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_3 and arg_323_1.time_ < var_326_1 + var_326_3 + arg_326_0 and arg_323_1.var_.characterEffect10030 then
				arg_323_1.var_.characterEffect10030.alpha = 0
			end

			local var_326_6 = arg_323_1.actors_["1038"]
			local var_326_7 = 0

			if var_326_7 < arg_323_1.time_ and arg_323_1.time_ <= var_326_7 + arg_326_0 then
				local var_326_8 = var_326_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_326_8 then
					arg_323_1.var_.alphaOldValue1038 = var_326_8.alpha
					arg_323_1.var_.characterEffect1038 = var_326_8
				end

				arg_323_1.var_.alphaOldValue1038 = 1
			end

			local var_326_9 = 0.333333333333333

			if var_326_7 <= arg_323_1.time_ and arg_323_1.time_ < var_326_7 + var_326_9 then
				local var_326_10 = (arg_323_1.time_ - var_326_7) / var_326_9
				local var_326_11 = Mathf.Lerp(arg_323_1.var_.alphaOldValue1038, 0, var_326_10)

				if arg_323_1.var_.characterEffect1038 then
					arg_323_1.var_.characterEffect1038.alpha = var_326_11
				end
			end

			if arg_323_1.time_ >= var_326_7 + var_326_9 and arg_323_1.time_ < var_326_7 + var_326_9 + arg_326_0 and arg_323_1.var_.characterEffect1038 then
				arg_323_1.var_.characterEffect1038.alpha = 0
			end

			local var_326_12 = 0
			local var_326_13 = 0.85

			if var_326_12 < arg_323_1.time_ and arg_323_1.time_ <= var_326_12 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_14 = arg_323_1:GetWordFromCfg(115261079)
				local var_326_15 = arg_323_1:FormatText(var_326_14.content)

				arg_323_1.text_.text = var_326_15

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_16 = 34
				local var_326_17 = utf8.len(var_326_15)
				local var_326_18 = var_326_16 <= 0 and var_326_13 or var_326_13 * (var_326_17 / var_326_16)

				if var_326_18 > 0 and var_326_13 < var_326_18 then
					arg_323_1.talkMaxDuration = var_326_18

					if var_326_18 + var_326_12 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_18 + var_326_12
					end
				end

				arg_323_1.text_.text = var_326_15
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_19 = math.max(var_326_13, arg_323_1.talkMaxDuration)

			if var_326_12 <= arg_323_1.time_ and arg_323_1.time_ < var_326_12 + var_326_19 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_12) / var_326_19

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_12 + var_326_19 and arg_323_1.time_ < var_326_12 + var_326_19 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play115261080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 115261080
		arg_327_1.duration_ = 4.6

		local var_327_0 = {
			ja = 2.633,
			ko = 2.433,
			zh = 4.6,
			en = 3.266
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play115261081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1038"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.actorSpriteComps1038 == nil then
				arg_327_1.var_.actorSpriteComps1038 = var_330_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_2 = 0.2

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.actorSpriteComps1038 then
					for iter_330_0, iter_330_1 in pairs(arg_327_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_330_1 then
							if arg_327_1.isInRecall_ then
								local var_330_4 = Mathf.Lerp(iter_330_1.color.r, arg_327_1.hightColor1.r, var_330_3)
								local var_330_5 = Mathf.Lerp(iter_330_1.color.g, arg_327_1.hightColor1.g, var_330_3)
								local var_330_6 = Mathf.Lerp(iter_330_1.color.b, arg_327_1.hightColor1.b, var_330_3)

								iter_330_1.color = Color.New(var_330_4, var_330_5, var_330_6)
							else
								local var_330_7 = Mathf.Lerp(iter_330_1.color.r, 1, var_330_3)

								iter_330_1.color = Color.New(var_330_7, var_330_7, var_330_7)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.actorSpriteComps1038 then
				for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_330_3 then
						if arg_327_1.isInRecall_ then
							iter_330_3.color = arg_327_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_330_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_327_1.var_.actorSpriteComps1038 = nil
			end

			local var_330_8 = arg_327_1.actors_["1038"].transform
			local var_330_9 = 0

			if var_330_9 < arg_327_1.time_ and arg_327_1.time_ <= var_330_9 + arg_330_0 then
				arg_327_1.var_.moveOldPos1038 = var_330_8.localPosition
				var_330_8.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("1038", 3)

				local var_330_10 = var_330_8.childCount

				for iter_330_4 = 0, var_330_10 - 1 do
					local var_330_11 = var_330_8:GetChild(iter_330_4)

					if var_330_11.name == "split_1" or not string.find(var_330_11.name, "split") then
						var_330_11.gameObject:SetActive(true)
					else
						var_330_11.gameObject:SetActive(false)
					end
				end
			end

			local var_330_12 = 0.001

			if var_330_9 <= arg_327_1.time_ and arg_327_1.time_ < var_330_9 + var_330_12 then
				local var_330_13 = (arg_327_1.time_ - var_330_9) / var_330_12
				local var_330_14 = Vector3.New(0, -400, 0)

				var_330_8.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1038, var_330_14, var_330_13)
			end

			if arg_327_1.time_ >= var_330_9 + var_330_12 and arg_327_1.time_ < var_330_9 + var_330_12 + arg_330_0 then
				var_330_8.localPosition = Vector3.New(0, -400, 0)
			end

			local var_330_15 = arg_327_1.actors_["1038"]
			local var_330_16 = 0

			if var_330_16 < arg_327_1.time_ and arg_327_1.time_ <= var_330_16 + arg_330_0 then
				local var_330_17 = var_330_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_330_17 then
					arg_327_1.var_.alphaOldValue1038 = var_330_17.alpha
					arg_327_1.var_.characterEffect1038 = var_330_17
				end

				arg_327_1.var_.alphaOldValue1038 = 0
			end

			local var_330_18 = 0.333333333333333

			if var_330_16 <= arg_327_1.time_ and arg_327_1.time_ < var_330_16 + var_330_18 then
				local var_330_19 = (arg_327_1.time_ - var_330_16) / var_330_18
				local var_330_20 = Mathf.Lerp(arg_327_1.var_.alphaOldValue1038, 1, var_330_19)

				if arg_327_1.var_.characterEffect1038 then
					arg_327_1.var_.characterEffect1038.alpha = var_330_20
				end
			end

			if arg_327_1.time_ >= var_330_16 + var_330_18 and arg_327_1.time_ < var_330_16 + var_330_18 + arg_330_0 and arg_327_1.var_.characterEffect1038 then
				arg_327_1.var_.characterEffect1038.alpha = 1
			end

			local var_330_21 = 0
			local var_330_22 = 0.225

			if var_330_21 < arg_327_1.time_ and arg_327_1.time_ <= var_330_21 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_23 = arg_327_1:FormatText(StoryNameCfg[94].name)

				arg_327_1.leftNameTxt_.text = var_330_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_24 = arg_327_1:GetWordFromCfg(115261080)
				local var_330_25 = arg_327_1:FormatText(var_330_24.content)

				arg_327_1.text_.text = var_330_25

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_26 = 9
				local var_330_27 = utf8.len(var_330_25)
				local var_330_28 = var_330_26 <= 0 and var_330_22 or var_330_22 * (var_330_27 / var_330_26)

				if var_330_28 > 0 and var_330_22 < var_330_28 then
					arg_327_1.talkMaxDuration = var_330_28

					if var_330_28 + var_330_21 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_28 + var_330_21
					end
				end

				arg_327_1.text_.text = var_330_25
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261080", "story_v_out_115261.awb") ~= 0 then
					local var_330_29 = manager.audio:GetVoiceLength("story_v_out_115261", "115261080", "story_v_out_115261.awb") / 1000

					if var_330_29 + var_330_21 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_29 + var_330_21
					end

					if var_330_24.prefab_name ~= "" and arg_327_1.actors_[var_330_24.prefab_name] ~= nil then
						local var_330_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_24.prefab_name].transform, "story_v_out_115261", "115261080", "story_v_out_115261.awb")

						arg_327_1:RecordAudio("115261080", var_330_30)
						arg_327_1:RecordAudio("115261080", var_330_30)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_115261", "115261080", "story_v_out_115261.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_115261", "115261080", "story_v_out_115261.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_31 = math.max(var_330_22, arg_327_1.talkMaxDuration)

			if var_330_21 <= arg_327_1.time_ and arg_327_1.time_ < var_330_21 + var_330_31 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_21) / var_330_31

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_21 + var_330_31 and arg_327_1.time_ < var_330_21 + var_330_31 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play115261081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 115261081
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play115261082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1038"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps1038 == nil then
				arg_331_1.var_.actorSpriteComps1038 = var_334_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_2 = 0.2

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.actorSpriteComps1038 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_334_1 then
							if arg_331_1.isInRecall_ then
								local var_334_4 = Mathf.Lerp(iter_334_1.color.r, arg_331_1.hightColor2.r, var_334_3)
								local var_334_5 = Mathf.Lerp(iter_334_1.color.g, arg_331_1.hightColor2.g, var_334_3)
								local var_334_6 = Mathf.Lerp(iter_334_1.color.b, arg_331_1.hightColor2.b, var_334_3)

								iter_334_1.color = Color.New(var_334_4, var_334_5, var_334_6)
							else
								local var_334_7 = Mathf.Lerp(iter_334_1.color.r, 0.5, var_334_3)

								iter_334_1.color = Color.New(var_334_7, var_334_7, var_334_7)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps1038 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_334_3 then
						if arg_331_1.isInRecall_ then
							iter_334_3.color = arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_334_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps1038 = nil
			end

			local var_334_8 = 1.999999999999
			local var_334_9 = 1

			if var_334_8 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 then
				local var_334_10 = "play"
				local var_334_11 = "effect"

				arg_331_1:AudioAction(var_334_10, var_334_11, "se_story_activity_1_5_3", "se_story_activity_1_5_3_cup", "")
			end

			local var_334_12 = arg_331_1.actors_["1038"].transform
			local var_334_13 = 0

			if var_334_13 < arg_331_1.time_ and arg_331_1.time_ <= var_334_13 + arg_334_0 then
				arg_331_1.var_.moveOldPos1038 = var_334_12.localPosition
				var_334_12.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("1038", 7)

				local var_334_14 = var_334_12.childCount

				for iter_334_4 = 0, var_334_14 - 1 do
					local var_334_15 = var_334_12:GetChild(iter_334_4)

					if var_334_15.name == "split_1" or not string.find(var_334_15.name, "split") then
						var_334_15.gameObject:SetActive(true)
					else
						var_334_15.gameObject:SetActive(false)
					end
				end
			end

			local var_334_16 = 0.001

			if var_334_13 <= arg_331_1.time_ and arg_331_1.time_ < var_334_13 + var_334_16 then
				local var_334_17 = (arg_331_1.time_ - var_334_13) / var_334_16
				local var_334_18 = Vector3.New(0, -2000, 0)

				var_334_12.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1038, var_334_18, var_334_17)
			end

			if arg_331_1.time_ >= var_334_13 + var_334_16 and arg_331_1.time_ < var_334_13 + var_334_16 + arg_334_0 then
				var_334_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_334_19 = 0
			local var_334_20 = 0.9

			if var_334_19 < arg_331_1.time_ and arg_331_1.time_ <= var_334_19 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_21 = arg_331_1:GetWordFromCfg(115261081)
				local var_334_22 = arg_331_1:FormatText(var_334_21.content)

				arg_331_1.text_.text = var_334_22

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_23 = 36
				local var_334_24 = utf8.len(var_334_22)
				local var_334_25 = var_334_23 <= 0 and var_334_20 or var_334_20 * (var_334_24 / var_334_23)

				if var_334_25 > 0 and var_334_20 < var_334_25 then
					arg_331_1.talkMaxDuration = var_334_25

					if var_334_25 + var_334_19 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_25 + var_334_19
					end
				end

				arg_331_1.text_.text = var_334_22
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_26 = math.max(var_334_20, arg_331_1.talkMaxDuration)

			if var_334_19 <= arg_331_1.time_ and arg_331_1.time_ < var_334_19 + var_334_26 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_19) / var_334_26

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_19 + var_334_26 and arg_331_1.time_ < var_334_19 + var_334_26 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play115261082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 115261082
		arg_335_1.duration_ = 5.47

		local var_335_0 = {
			ja = 5.4,
			ko = 4.833,
			zh = 5.466,
			en = 5
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play115261083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1038"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps1038 == nil then
				arg_335_1.var_.actorSpriteComps1038 = var_338_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_2 = 0.2

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 and not isNil(var_338_0) then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.actorSpriteComps1038 then
					for iter_338_0, iter_338_1 in pairs(arg_335_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_338_1 then
							if arg_335_1.isInRecall_ then
								local var_338_4 = Mathf.Lerp(iter_338_1.color.r, arg_335_1.hightColor1.r, var_338_3)
								local var_338_5 = Mathf.Lerp(iter_338_1.color.g, arg_335_1.hightColor1.g, var_338_3)
								local var_338_6 = Mathf.Lerp(iter_338_1.color.b, arg_335_1.hightColor1.b, var_338_3)

								iter_338_1.color = Color.New(var_338_4, var_338_5, var_338_6)
							else
								local var_338_7 = Mathf.Lerp(iter_338_1.color.r, 1, var_338_3)

								iter_338_1.color = Color.New(var_338_7, var_338_7, var_338_7)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps1038 then
				for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_338_3 then
						if arg_335_1.isInRecall_ then
							iter_338_3.color = arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_338_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps1038 = nil
			end

			local var_338_8 = arg_335_1.actors_["1038"].transform
			local var_338_9 = 0

			if var_338_9 < arg_335_1.time_ and arg_335_1.time_ <= var_338_9 + arg_338_0 then
				arg_335_1.var_.moveOldPos1038 = var_338_8.localPosition
				var_338_8.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("1038", 3)

				local var_338_10 = var_338_8.childCount

				for iter_338_4 = 0, var_338_10 - 1 do
					local var_338_11 = var_338_8:GetChild(iter_338_4)

					if var_338_11.name == "split_9" or not string.find(var_338_11.name, "split") then
						var_338_11.gameObject:SetActive(true)
					else
						var_338_11.gameObject:SetActive(false)
					end
				end
			end

			local var_338_12 = 0.001

			if var_338_9 <= arg_335_1.time_ and arg_335_1.time_ < var_338_9 + var_338_12 then
				local var_338_13 = (arg_335_1.time_ - var_338_9) / var_338_12
				local var_338_14 = Vector3.New(0, -400, 0)

				var_338_8.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1038, var_338_14, var_338_13)
			end

			if arg_335_1.time_ >= var_338_9 + var_338_12 and arg_335_1.time_ < var_338_9 + var_338_12 + arg_338_0 then
				var_338_8.localPosition = Vector3.New(0, -400, 0)
			end

			local var_338_15 = arg_335_1.actors_["1038"]
			local var_338_16 = 0

			if var_338_16 < arg_335_1.time_ and arg_335_1.time_ <= var_338_16 + arg_338_0 then
				local var_338_17 = var_338_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_338_17 then
					arg_335_1.var_.alphaOldValue1038 = var_338_17.alpha
					arg_335_1.var_.characterEffect1038 = var_338_17
				end

				arg_335_1.var_.alphaOldValue1038 = 0
			end

			local var_338_18 = 0.5

			if var_338_16 <= arg_335_1.time_ and arg_335_1.time_ < var_338_16 + var_338_18 then
				local var_338_19 = (arg_335_1.time_ - var_338_16) / var_338_18
				local var_338_20 = Mathf.Lerp(arg_335_1.var_.alphaOldValue1038, 1, var_338_19)

				if arg_335_1.var_.characterEffect1038 then
					arg_335_1.var_.characterEffect1038.alpha = var_338_20
				end
			end

			if arg_335_1.time_ >= var_338_16 + var_338_18 and arg_335_1.time_ < var_338_16 + var_338_18 + arg_338_0 and arg_335_1.var_.characterEffect1038 then
				arg_335_1.var_.characterEffect1038.alpha = 1
			end

			local var_338_21 = 0
			local var_338_22 = 0.45

			if var_338_21 < arg_335_1.time_ and arg_335_1.time_ <= var_338_21 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_23 = arg_335_1:FormatText(StoryNameCfg[94].name)

				arg_335_1.leftNameTxt_.text = var_338_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_24 = arg_335_1:GetWordFromCfg(115261082)
				local var_338_25 = arg_335_1:FormatText(var_338_24.content)

				arg_335_1.text_.text = var_338_25

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_26 = 18
				local var_338_27 = utf8.len(var_338_25)
				local var_338_28 = var_338_26 <= 0 and var_338_22 or var_338_22 * (var_338_27 / var_338_26)

				if var_338_28 > 0 and var_338_22 < var_338_28 then
					arg_335_1.talkMaxDuration = var_338_28

					if var_338_28 + var_338_21 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_28 + var_338_21
					end
				end

				arg_335_1.text_.text = var_338_25
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261082", "story_v_out_115261.awb") ~= 0 then
					local var_338_29 = manager.audio:GetVoiceLength("story_v_out_115261", "115261082", "story_v_out_115261.awb") / 1000

					if var_338_29 + var_338_21 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_29 + var_338_21
					end

					if var_338_24.prefab_name ~= "" and arg_335_1.actors_[var_338_24.prefab_name] ~= nil then
						local var_338_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_24.prefab_name].transform, "story_v_out_115261", "115261082", "story_v_out_115261.awb")

						arg_335_1:RecordAudio("115261082", var_338_30)
						arg_335_1:RecordAudio("115261082", var_338_30)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_115261", "115261082", "story_v_out_115261.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_115261", "115261082", "story_v_out_115261.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_31 = math.max(var_338_22, arg_335_1.talkMaxDuration)

			if var_338_21 <= arg_335_1.time_ and arg_335_1.time_ < var_338_21 + var_338_31 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_21) / var_338_31

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_21 + var_338_31 and arg_335_1.time_ < var_338_21 + var_338_31 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play115261083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 115261083
		arg_339_1.duration_ = 8.33

		local var_339_0 = {
			ja = 8.333,
			ko = 7.5,
			zh = 8.3,
			en = 7.4
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play115261084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = "ST27a"

			if arg_339_1.bgs_[var_342_0] == nil then
				local var_342_1 = Object.Instantiate(arg_339_1.paintGo_)

				var_342_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_342_0)
				var_342_1.name = var_342_0
				var_342_1.transform.parent = arg_339_1.stage_.transform
				var_342_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_339_1.bgs_[var_342_0] = var_342_1
			end

			local var_342_2 = 2

			if var_342_2 < arg_339_1.time_ and arg_339_1.time_ <= var_342_2 + arg_342_0 then
				local var_342_3 = manager.ui.mainCamera.transform.localPosition
				local var_342_4 = Vector3.New(0, 0, 10) + Vector3.New(var_342_3.x, var_342_3.y, 0)
				local var_342_5 = arg_339_1.bgs_.ST27a

				var_342_5.transform.localPosition = var_342_4
				var_342_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_342_6 = var_342_5:GetComponent("SpriteRenderer")

				if var_342_6 and var_342_6.sprite then
					local var_342_7 = (var_342_5.transform.localPosition - var_342_3).z
					local var_342_8 = manager.ui.mainCameraCom_
					local var_342_9 = 2 * var_342_7 * Mathf.Tan(var_342_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_342_10 = var_342_9 * var_342_8.aspect
					local var_342_11 = var_342_6.sprite.bounds.size.x
					local var_342_12 = var_342_6.sprite.bounds.size.y
					local var_342_13 = var_342_10 / var_342_11
					local var_342_14 = var_342_9 / var_342_12
					local var_342_15 = var_342_14 < var_342_13 and var_342_13 or var_342_14

					var_342_5.transform.localScale = Vector3.New(var_342_15, var_342_15, 0)
				end

				for iter_342_0, iter_342_1 in pairs(arg_339_1.bgs_) do
					if iter_342_0 ~= "ST27a" then
						iter_342_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_342_16 = arg_339_1.actors_["1038"].transform
			local var_342_17 = 1.99933333333333

			if var_342_17 < arg_339_1.time_ and arg_339_1.time_ <= var_342_17 + arg_342_0 then
				arg_339_1.var_.moveOldPos1038 = var_342_16.localPosition
				var_342_16.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("1038", 0)

				local var_342_18 = var_342_16.childCount

				for iter_342_2 = 0, var_342_18 - 1 do
					local var_342_19 = var_342_16:GetChild(iter_342_2)

					if var_342_19.name == "split_9" or not string.find(var_342_19.name, "split") then
						var_342_19.gameObject:SetActive(true)
					else
						var_342_19.gameObject:SetActive(false)
					end
				end
			end

			local var_342_20 = 0.001

			if var_342_17 <= arg_339_1.time_ and arg_339_1.time_ < var_342_17 + var_342_20 then
				local var_342_21 = (arg_339_1.time_ - var_342_17) / var_342_20
				local var_342_22 = Vector3.New(-2000, -400, 0)

				var_342_16.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1038, var_342_22, var_342_21)
			end

			if arg_339_1.time_ >= var_342_17 + var_342_20 and arg_339_1.time_ < var_342_17 + var_342_20 + arg_342_0 then
				var_342_16.localPosition = Vector3.New(-2000, -400, 0)
			end

			local var_342_23 = arg_339_1.actors_["10030"].transform
			local var_342_24 = 4

			if var_342_24 < arg_339_1.time_ and arg_339_1.time_ <= var_342_24 + arg_342_0 then
				arg_339_1.var_.moveOldPos10030 = var_342_23.localPosition
				var_342_23.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("10030", 3)

				local var_342_25 = var_342_23.childCount

				for iter_342_3 = 0, var_342_25 - 1 do
					local var_342_26 = var_342_23:GetChild(iter_342_3)

					if var_342_26.name == "split_3" or not string.find(var_342_26.name, "split") then
						var_342_26.gameObject:SetActive(true)
					else
						var_342_26.gameObject:SetActive(false)
					end
				end
			end

			local var_342_27 = 0.001

			if var_342_24 <= arg_339_1.time_ and arg_339_1.time_ < var_342_24 + var_342_27 then
				local var_342_28 = (arg_339_1.time_ - var_342_24) / var_342_27
				local var_342_29 = Vector3.New(0, -390, 150)

				var_342_23.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos10030, var_342_29, var_342_28)
			end

			if arg_339_1.time_ >= var_342_24 + var_342_27 and arg_339_1.time_ < var_342_24 + var_342_27 + arg_342_0 then
				var_342_23.localPosition = Vector3.New(0, -390, 150)
			end

			local var_342_30 = arg_339_1.actors_["10030"]
			local var_342_31 = 4

			if var_342_31 < arg_339_1.time_ and arg_339_1.time_ <= var_342_31 + arg_342_0 and not isNil(var_342_30) and arg_339_1.var_.actorSpriteComps10030 == nil then
				arg_339_1.var_.actorSpriteComps10030 = var_342_30:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_32 = 0.2

			if var_342_31 <= arg_339_1.time_ and arg_339_1.time_ < var_342_31 + var_342_32 and not isNil(var_342_30) then
				local var_342_33 = (arg_339_1.time_ - var_342_31) / var_342_32

				if arg_339_1.var_.actorSpriteComps10030 then
					for iter_342_4, iter_342_5 in pairs(arg_339_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_342_5 then
							if arg_339_1.isInRecall_ then
								local var_342_34 = Mathf.Lerp(iter_342_5.color.r, arg_339_1.hightColor1.r, var_342_33)
								local var_342_35 = Mathf.Lerp(iter_342_5.color.g, arg_339_1.hightColor1.g, var_342_33)
								local var_342_36 = Mathf.Lerp(iter_342_5.color.b, arg_339_1.hightColor1.b, var_342_33)

								iter_342_5.color = Color.New(var_342_34, var_342_35, var_342_36)
							else
								local var_342_37 = Mathf.Lerp(iter_342_5.color.r, 1, var_342_33)

								iter_342_5.color = Color.New(var_342_37, var_342_37, var_342_37)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= var_342_31 + var_342_32 and arg_339_1.time_ < var_342_31 + var_342_32 + arg_342_0 and not isNil(var_342_30) and arg_339_1.var_.actorSpriteComps10030 then
				for iter_342_6, iter_342_7 in pairs(arg_339_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_342_7 then
						if arg_339_1.isInRecall_ then
							iter_342_7.color = arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_342_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_339_1.var_.actorSpriteComps10030 = nil
			end

			local var_342_38 = 0

			if var_342_38 < arg_339_1.time_ and arg_339_1.time_ <= var_342_38 + arg_342_0 then
				arg_339_1.mask_.enabled = true
				arg_339_1.mask_.raycastTarget = true

				arg_339_1:SetGaussion(false)
			end

			local var_342_39 = 2

			if var_342_38 <= arg_339_1.time_ and arg_339_1.time_ < var_342_38 + var_342_39 then
				local var_342_40 = (arg_339_1.time_ - var_342_38) / var_342_39
				local var_342_41 = Color.New(0, 0, 0)

				var_342_41.a = Mathf.Lerp(0, 1, var_342_40)
				arg_339_1.mask_.color = var_342_41
			end

			if arg_339_1.time_ >= var_342_38 + var_342_39 and arg_339_1.time_ < var_342_38 + var_342_39 + arg_342_0 then
				local var_342_42 = Color.New(0, 0, 0)

				var_342_42.a = 1
				arg_339_1.mask_.color = var_342_42
			end

			local var_342_43 = 2

			if var_342_43 < arg_339_1.time_ and arg_339_1.time_ <= var_342_43 + arg_342_0 then
				arg_339_1.mask_.enabled = true
				arg_339_1.mask_.raycastTarget = true

				arg_339_1:SetGaussion(false)
			end

			local var_342_44 = 2

			if var_342_43 <= arg_339_1.time_ and arg_339_1.time_ < var_342_43 + var_342_44 then
				local var_342_45 = (arg_339_1.time_ - var_342_43) / var_342_44
				local var_342_46 = Color.New(0, 0, 0)

				var_342_46.a = Mathf.Lerp(1, 0, var_342_45)
				arg_339_1.mask_.color = var_342_46
			end

			if arg_339_1.time_ >= var_342_43 + var_342_44 and arg_339_1.time_ < var_342_43 + var_342_44 + arg_342_0 then
				local var_342_47 = Color.New(0, 0, 0)
				local var_342_48 = 0

				arg_339_1.mask_.enabled = false
				var_342_47.a = var_342_48
				arg_339_1.mask_.color = var_342_47
			end

			local var_342_49 = arg_339_1.actors_["10030"]
			local var_342_50 = 4

			if var_342_50 < arg_339_1.time_ and arg_339_1.time_ <= var_342_50 + arg_342_0 then
				local var_342_51 = var_342_49:GetComponentInChildren(typeof(CanvasGroup))

				if var_342_51 then
					arg_339_1.var_.alphaOldValue10030 = var_342_51.alpha
					arg_339_1.var_.characterEffect10030 = var_342_51
				end

				arg_339_1.var_.alphaOldValue10030 = 0
			end

			local var_342_52 = 0.333333333333333

			if var_342_50 <= arg_339_1.time_ and arg_339_1.time_ < var_342_50 + var_342_52 then
				local var_342_53 = (arg_339_1.time_ - var_342_50) / var_342_52
				local var_342_54 = Mathf.Lerp(arg_339_1.var_.alphaOldValue10030, 1, var_342_53)

				if arg_339_1.var_.characterEffect10030 then
					arg_339_1.var_.characterEffect10030.alpha = var_342_54
				end
			end

			if arg_339_1.time_ >= var_342_50 + var_342_52 and arg_339_1.time_ < var_342_50 + var_342_52 + arg_342_0 and arg_339_1.var_.characterEffect10030 then
				arg_339_1.var_.characterEffect10030.alpha = 1
			end

			if arg_339_1.frameCnt_ <= 1 then
				arg_339_1.dialog_:SetActive(false)
			end

			local var_342_55 = 4
			local var_342_56 = 0.4

			if var_342_55 < arg_339_1.time_ and arg_339_1.time_ <= var_342_55 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0

				arg_339_1.dialog_:SetActive(true)

				arg_339_1.dialogCg_.alpha = 0

				local var_342_57 = LeanTween.value(arg_339_1.dialog_, 0, 1, 0.3)

				var_342_57:setOnUpdate(LuaHelper.FloatAction(function(arg_343_0)
					arg_339_1.dialogCg_.alpha = arg_343_0
				end))
				var_342_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_339_1.dialog_)
					var_342_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_339_1.duration_ = arg_339_1.duration_ + 0.3

				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_58 = arg_339_1:FormatText(StoryNameCfg[309].name)

				arg_339_1.leftNameTxt_.text = var_342_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_59 = arg_339_1:GetWordFromCfg(115261083)
				local var_342_60 = arg_339_1:FormatText(var_342_59.content)

				arg_339_1.text_.text = var_342_60

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_61 = 16
				local var_342_62 = utf8.len(var_342_60)
				local var_342_63 = var_342_61 <= 0 and var_342_56 or var_342_56 * (var_342_62 / var_342_61)

				if var_342_63 > 0 and var_342_56 < var_342_63 then
					arg_339_1.talkMaxDuration = var_342_63
					var_342_55 = var_342_55 + 0.3

					if var_342_63 + var_342_55 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_63 + var_342_55
					end
				end

				arg_339_1.text_.text = var_342_60
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261083", "story_v_out_115261.awb") ~= 0 then
					local var_342_64 = manager.audio:GetVoiceLength("story_v_out_115261", "115261083", "story_v_out_115261.awb") / 1000

					if var_342_64 + var_342_55 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_64 + var_342_55
					end

					if var_342_59.prefab_name ~= "" and arg_339_1.actors_[var_342_59.prefab_name] ~= nil then
						local var_342_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_59.prefab_name].transform, "story_v_out_115261", "115261083", "story_v_out_115261.awb")

						arg_339_1:RecordAudio("115261083", var_342_65)
						arg_339_1:RecordAudio("115261083", var_342_65)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_115261", "115261083", "story_v_out_115261.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_115261", "115261083", "story_v_out_115261.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_66 = var_342_55 + 0.3
			local var_342_67 = math.max(var_342_56, arg_339_1.talkMaxDuration)

			if var_342_66 <= arg_339_1.time_ and arg_339_1.time_ < var_342_66 + var_342_67 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_66) / var_342_67

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_66 + var_342_67 and arg_339_1.time_ < var_342_66 + var_342_67 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.99933333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play115261084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 115261084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play115261085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["10030"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				local var_348_2 = var_348_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_348_2 then
					arg_345_1.var_.alphaOldValue10030 = var_348_2.alpha
					arg_345_1.var_.characterEffect10030 = var_348_2
				end

				arg_345_1.var_.alphaOldValue10030 = 1
			end

			local var_348_3 = 0.333333333333333

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_3 then
				local var_348_4 = (arg_345_1.time_ - var_348_1) / var_348_3
				local var_348_5 = Mathf.Lerp(arg_345_1.var_.alphaOldValue10030, 0, var_348_4)

				if arg_345_1.var_.characterEffect10030 then
					arg_345_1.var_.characterEffect10030.alpha = var_348_5
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_3 and arg_345_1.time_ < var_348_1 + var_348_3 + arg_348_0 and arg_345_1.var_.characterEffect10030 then
				arg_345_1.var_.characterEffect10030.alpha = 0
			end

			local var_348_6 = 0
			local var_348_7 = 0.6

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_8 = arg_345_1:GetWordFromCfg(115261084)
				local var_348_9 = arg_345_1:FormatText(var_348_8.content)

				arg_345_1.text_.text = var_348_9

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_10 = 24
				local var_348_11 = utf8.len(var_348_9)
				local var_348_12 = var_348_10 <= 0 and var_348_7 or var_348_7 * (var_348_11 / var_348_10)

				if var_348_12 > 0 and var_348_7 < var_348_12 then
					arg_345_1.talkMaxDuration = var_348_12

					if var_348_12 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_12 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_9
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_13 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_13 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_13

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_13 and arg_345_1.time_ < var_348_6 + var_348_13 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play115261085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 115261085
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play115261086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0
			local var_352_1 = 1.325

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_2 = arg_349_1:GetWordFromCfg(115261085)
				local var_352_3 = arg_349_1:FormatText(var_352_2.content)

				arg_349_1.text_.text = var_352_3

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_4 = 53
				local var_352_5 = utf8.len(var_352_3)
				local var_352_6 = var_352_4 <= 0 and var_352_1 or var_352_1 * (var_352_5 / var_352_4)

				if var_352_6 > 0 and var_352_1 < var_352_6 then
					arg_349_1.talkMaxDuration = var_352_6

					if var_352_6 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_6 + var_352_0
					end
				end

				arg_349_1.text_.text = var_352_3
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_7 = math.max(var_352_1, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_7 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_0) / var_352_7

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_7 and arg_349_1.time_ < var_352_0 + var_352_7 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play115261086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 115261086
		arg_353_1.duration_ = 7.4

		local var_353_0 = {
			ja = 6.866,
			ko = 7.166,
			zh = 7.4,
			en = 5.866
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
				arg_353_0:Play115261087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0
			local var_356_1 = 0.65

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_2 = arg_353_1:FormatText(StoryNameCfg[310].name)

				arg_353_1.leftNameTxt_.text = var_356_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_3 = arg_353_1:GetWordFromCfg(115261086)
				local var_356_4 = arg_353_1:FormatText(var_356_3.content)

				arg_353_1.text_.text = var_356_4

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261086", "story_v_out_115261.awb") ~= 0 then
					local var_356_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261086", "story_v_out_115261.awb") / 1000

					if var_356_8 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_8 + var_356_0
					end

					if var_356_3.prefab_name ~= "" and arg_353_1.actors_[var_356_3.prefab_name] ~= nil then
						local var_356_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_3.prefab_name].transform, "story_v_out_115261", "115261086", "story_v_out_115261.awb")

						arg_353_1:RecordAudio("115261086", var_356_9)
						arg_353_1:RecordAudio("115261086", var_356_9)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_115261", "115261086", "story_v_out_115261.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_115261", "115261086", "story_v_out_115261.awb")
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
	Play115261087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 115261087
		arg_357_1.duration_ = 9.97

		local var_357_0 = {
			ja = 7.166,
			ko = 9.9,
			zh = 8.7,
			en = 9.966
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play115261088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0
			local var_360_1 = 1.075

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_2 = arg_357_1:FormatText(StoryNameCfg[311].name)

				arg_357_1.leftNameTxt_.text = var_360_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_3 = arg_357_1:GetWordFromCfg(115261087)
				local var_360_4 = arg_357_1:FormatText(var_360_3.content)

				arg_357_1.text_.text = var_360_4

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_5 = 43
				local var_360_6 = utf8.len(var_360_4)
				local var_360_7 = var_360_5 <= 0 and var_360_1 or var_360_1 * (var_360_6 / var_360_5)

				if var_360_7 > 0 and var_360_1 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_0
					end
				end

				arg_357_1.text_.text = var_360_4
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261087", "story_v_out_115261.awb") ~= 0 then
					local var_360_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261087", "story_v_out_115261.awb") / 1000

					if var_360_8 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_8 + var_360_0
					end

					if var_360_3.prefab_name ~= "" and arg_357_1.actors_[var_360_3.prefab_name] ~= nil then
						local var_360_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_3.prefab_name].transform, "story_v_out_115261", "115261087", "story_v_out_115261.awb")

						arg_357_1:RecordAudio("115261087", var_360_9)
						arg_357_1:RecordAudio("115261087", var_360_9)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_115261", "115261087", "story_v_out_115261.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_115261", "115261087", "story_v_out_115261.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_10 = math.max(var_360_1, arg_357_1.talkMaxDuration)

			if var_360_0 <= arg_357_1.time_ and arg_357_1.time_ < var_360_0 + var_360_10 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_0) / var_360_10

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_0 + var_360_10 and arg_357_1.time_ < var_360_0 + var_360_10 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play115261088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 115261088
		arg_361_1.duration_ = 14.77

		local var_361_0 = {
			ja = 10.933,
			ko = 14.766,
			zh = 12.866,
			en = 14.166
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
				arg_361_0:Play115261089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 1.125

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_2 = arg_361_1:FormatText(StoryNameCfg[310].name)

				arg_361_1.leftNameTxt_.text = var_364_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:GetWordFromCfg(115261088)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261088", "story_v_out_115261.awb") ~= 0 then
					local var_364_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261088", "story_v_out_115261.awb") / 1000

					if var_364_8 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_8 + var_364_0
					end

					if var_364_3.prefab_name ~= "" and arg_361_1.actors_[var_364_3.prefab_name] ~= nil then
						local var_364_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_3.prefab_name].transform, "story_v_out_115261", "115261088", "story_v_out_115261.awb")

						arg_361_1:RecordAudio("115261088", var_364_9)
						arg_361_1:RecordAudio("115261088", var_364_9)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_115261", "115261088", "story_v_out_115261.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_115261", "115261088", "story_v_out_115261.awb")
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
	Play115261089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 115261089
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play115261090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 1.575

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_2 = arg_365_1:GetWordFromCfg(115261089)
				local var_368_3 = arg_365_1:FormatText(var_368_2.content)

				arg_365_1.text_.text = var_368_3

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 63
				local var_368_5 = utf8.len(var_368_3)
				local var_368_6 = var_368_4 <= 0 and var_368_1 or var_368_1 * (var_368_5 / var_368_4)

				if var_368_6 > 0 and var_368_1 < var_368_6 then
					arg_365_1.talkMaxDuration = var_368_6

					if var_368_6 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_6 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_3
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_7 and arg_365_1.time_ < var_368_0 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play115261090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 115261090
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play115261091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0
			local var_372_1 = 0.325

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_2 = arg_369_1:GetWordFromCfg(115261090)
				local var_372_3 = arg_369_1:FormatText(var_372_2.content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_4 = 13
				local var_372_5 = utf8.len(var_372_3)
				local var_372_6 = var_372_4 <= 0 and var_372_1 or var_372_1 * (var_372_5 / var_372_4)

				if var_372_6 > 0 and var_372_1 < var_372_6 then
					arg_369_1.talkMaxDuration = var_372_6

					if var_372_6 + var_372_0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_6 + var_372_0
					end
				end

				arg_369_1.text_.text = var_372_3
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_7 = math.max(var_372_1, arg_369_1.talkMaxDuration)

			if var_372_0 <= arg_369_1.time_ and arg_369_1.time_ < var_372_0 + var_372_7 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_0) / var_372_7

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_0 + var_372_7 and arg_369_1.time_ < var_372_0 + var_372_7 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play115261091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 115261091
		arg_373_1.duration_ = 14.47

		local var_373_0 = {
			ja = 12.8,
			ko = 13.866,
			zh = 12.066,
			en = 14.466
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play115261092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = "10029"

			if arg_373_1.actors_[var_376_0] == nil then
				local var_376_1 = Object.Instantiate(arg_373_1.imageGo_, arg_373_1.canvasGo_.transform)

				var_376_1.transform:SetSiblingIndex(1)

				var_376_1.name = var_376_0

				local var_376_2 = var_376_1:GetComponent(typeof(Image))

				var_376_2.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10029")

				var_376_2:SetNativeSize()

				var_376_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_373_1.actors_[var_376_0] = var_376_1
			end

			local var_376_3 = arg_373_1.actors_["10029"].transform
			local var_376_4 = 0

			if var_376_4 < arg_373_1.time_ and arg_373_1.time_ <= var_376_4 + arg_376_0 then
				arg_373_1.var_.moveOldPos10029 = var_376_3.localPosition
				var_376_3.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("10029", 3)
			end

			local var_376_5 = 0.001

			if var_376_4 <= arg_373_1.time_ and arg_373_1.time_ < var_376_4 + var_376_5 then
				local var_376_6 = (arg_373_1.time_ - var_376_4) / var_376_5
				local var_376_7 = Vector3.New(0, -350, -180)

				var_376_3.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10029, var_376_7, var_376_6)
			end

			if arg_373_1.time_ >= var_376_4 + var_376_5 and arg_373_1.time_ < var_376_4 + var_376_5 + arg_376_0 then
				var_376_3.localPosition = Vector3.New(0, -350, -180)
			end

			local var_376_8 = arg_373_1.actors_["10029"]
			local var_376_9 = 0

			if var_376_9 < arg_373_1.time_ and arg_373_1.time_ <= var_376_9 + arg_376_0 then
				local var_376_10 = var_376_8:GetComponent("Image")

				if var_376_10 then
					arg_373_1.var_.alphaMatValue10029 = var_376_10
					arg_373_1.var_.alphaOldValue10029 = var_376_10.color.a
				end

				arg_373_1.var_.alphaOldValue10029 = 0
			end

			local var_376_11 = 0.333333333333333

			if var_376_9 <= arg_373_1.time_ and arg_373_1.time_ < var_376_9 + var_376_11 then
				local var_376_12 = (arg_373_1.time_ - var_376_9) / var_376_11
				local var_376_13 = Mathf.Lerp(arg_373_1.var_.alphaOldValue10029, 1, var_376_12)

				if arg_373_1.var_.alphaMatValue10029 then
					local var_376_14 = arg_373_1.var_.alphaMatValue10029.color

					var_376_14.a = var_376_13
					arg_373_1.var_.alphaMatValue10029.color = var_376_14
				end
			end

			if arg_373_1.time_ >= var_376_9 + var_376_11 and arg_373_1.time_ < var_376_9 + var_376_11 + arg_376_0 and arg_373_1.var_.alphaMatValue10029 then
				local var_376_15 = arg_373_1.var_.alphaMatValue10029
				local var_376_16 = var_376_15.color

				var_376_16.a = 1
				var_376_15.color = var_376_16
			end

			local var_376_17 = 0
			local var_376_18 = 1.1

			if var_376_17 < arg_373_1.time_ and arg_373_1.time_ <= var_376_17 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_19 = arg_373_1:FormatText(StoryNameCfg[312].name)

				arg_373_1.leftNameTxt_.text = var_376_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_20 = arg_373_1:GetWordFromCfg(115261091)
				local var_376_21 = arg_373_1:FormatText(var_376_20.content)

				arg_373_1.text_.text = var_376_21

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_22 = 43
				local var_376_23 = utf8.len(var_376_21)
				local var_376_24 = var_376_22 <= 0 and var_376_18 or var_376_18 * (var_376_23 / var_376_22)

				if var_376_24 > 0 and var_376_18 < var_376_24 then
					arg_373_1.talkMaxDuration = var_376_24

					if var_376_24 + var_376_17 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_24 + var_376_17
					end
				end

				arg_373_1.text_.text = var_376_21
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261091", "story_v_out_115261.awb") ~= 0 then
					local var_376_25 = manager.audio:GetVoiceLength("story_v_out_115261", "115261091", "story_v_out_115261.awb") / 1000

					if var_376_25 + var_376_17 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_25 + var_376_17
					end

					if var_376_20.prefab_name ~= "" and arg_373_1.actors_[var_376_20.prefab_name] ~= nil then
						local var_376_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_20.prefab_name].transform, "story_v_out_115261", "115261091", "story_v_out_115261.awb")

						arg_373_1:RecordAudio("115261091", var_376_26)
						arg_373_1:RecordAudio("115261091", var_376_26)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_115261", "115261091", "story_v_out_115261.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_115261", "115261091", "story_v_out_115261.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_27 = math.max(var_376_18, arg_373_1.talkMaxDuration)

			if var_376_17 <= arg_373_1.time_ and arg_373_1.time_ < var_376_17 + var_376_27 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_17) / var_376_27

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_17 + var_376_27 and arg_373_1.time_ < var_376_17 + var_376_27 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play115261092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 115261092
		arg_377_1.duration_ = 12.17

		local var_377_0 = {
			ja = 3.033,
			ko = 8.933,
			zh = 7.833,
			en = 12.166
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
				arg_377_0:Play115261093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0
			local var_380_1 = 0.925

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_2 = arg_377_1:FormatText(StoryNameCfg[312].name)

				arg_377_1.leftNameTxt_.text = var_380_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_3 = arg_377_1:GetWordFromCfg(115261092)
				local var_380_4 = arg_377_1:FormatText(var_380_3.content)

				arg_377_1.text_.text = var_380_4

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261092", "story_v_out_115261.awb") ~= 0 then
					local var_380_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261092", "story_v_out_115261.awb") / 1000

					if var_380_8 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_8 + var_380_0
					end

					if var_380_3.prefab_name ~= "" and arg_377_1.actors_[var_380_3.prefab_name] ~= nil then
						local var_380_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_3.prefab_name].transform, "story_v_out_115261", "115261092", "story_v_out_115261.awb")

						arg_377_1:RecordAudio("115261092", var_380_9)
						arg_377_1:RecordAudio("115261092", var_380_9)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_115261", "115261092", "story_v_out_115261.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_115261", "115261092", "story_v_out_115261.awb")
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
	Play115261093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 115261093
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play115261094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["10029"]
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				local var_384_2 = var_384_0:GetComponent("Image")

				if var_384_2 then
					arg_381_1.var_.alphaMatValue10029 = var_384_2
					arg_381_1.var_.alphaOldValue10029 = var_384_2.color.a
				end

				arg_381_1.var_.alphaOldValue10029 = 1
			end

			local var_384_3 = 0.333333333333333

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_3 then
				local var_384_4 = (arg_381_1.time_ - var_384_1) / var_384_3
				local var_384_5 = Mathf.Lerp(arg_381_1.var_.alphaOldValue10029, 0, var_384_4)

				if arg_381_1.var_.alphaMatValue10029 then
					local var_384_6 = arg_381_1.var_.alphaMatValue10029.color

					var_384_6.a = var_384_5
					arg_381_1.var_.alphaMatValue10029.color = var_384_6
				end
			end

			if arg_381_1.time_ >= var_384_1 + var_384_3 and arg_381_1.time_ < var_384_1 + var_384_3 + arg_384_0 and arg_381_1.var_.alphaMatValue10029 then
				local var_384_7 = arg_381_1.var_.alphaMatValue10029
				local var_384_8 = var_384_7.color

				var_384_8.a = 0
				var_384_7.color = var_384_8
			end

			local var_384_9 = 0
			local var_384_10 = 1.225

			if var_384_9 < arg_381_1.time_ and arg_381_1.time_ <= var_384_9 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_11 = arg_381_1:GetWordFromCfg(115261093)
				local var_384_12 = arg_381_1:FormatText(var_384_11.content)

				arg_381_1.text_.text = var_384_12

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_13 = 49
				local var_384_14 = utf8.len(var_384_12)
				local var_384_15 = var_384_13 <= 0 and var_384_10 or var_384_10 * (var_384_14 / var_384_13)

				if var_384_15 > 0 and var_384_10 < var_384_15 then
					arg_381_1.talkMaxDuration = var_384_15

					if var_384_15 + var_384_9 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_15 + var_384_9
					end
				end

				arg_381_1.text_.text = var_384_12
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_16 = math.max(var_384_10, arg_381_1.talkMaxDuration)

			if var_384_9 <= arg_381_1.time_ and arg_381_1.time_ < var_384_9 + var_384_16 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_9) / var_384_16

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_9 + var_384_16 and arg_381_1.time_ < var_384_9 + var_384_16 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play115261094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 115261094
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play115261095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0
			local var_388_1 = 1.2

			if var_388_0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_2 = arg_385_1:GetWordFromCfg(115261094)
				local var_388_3 = arg_385_1:FormatText(var_388_2.content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 48
				local var_388_5 = utf8.len(var_388_3)
				local var_388_6 = var_388_4 <= 0 and var_388_1 or var_388_1 * (var_388_5 / var_388_4)

				if var_388_6 > 0 and var_388_1 < var_388_6 then
					arg_385_1.talkMaxDuration = var_388_6

					if var_388_6 + var_388_0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_6 + var_388_0
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_1, arg_385_1.talkMaxDuration)

			if var_388_0 <= arg_385_1.time_ and arg_385_1.time_ < var_388_0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_0 + var_388_7 and arg_385_1.time_ < var_388_0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play115261095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 115261095
		arg_389_1.duration_ = 10.4

		local var_389_0 = {
			ja = 10.4,
			ko = 7.533,
			zh = 6.033,
			en = 9.233
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
				arg_389_0:Play115261096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["10030"].transform
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.var_.moveOldPos10030 = var_392_0.localPosition
				var_392_0.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("10030", 4)

				local var_392_2 = var_392_0.childCount

				for iter_392_0 = 0, var_392_2 - 1 do
					local var_392_3 = var_392_0:GetChild(iter_392_0)

					if var_392_3.name == "split_3" or not string.find(var_392_3.name, "split") then
						var_392_3.gameObject:SetActive(true)
					else
						var_392_3.gameObject:SetActive(false)
					end
				end
			end

			local var_392_4 = 0.001

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_4 then
				local var_392_5 = (arg_389_1.time_ - var_392_1) / var_392_4
				local var_392_6 = Vector3.New(390, -390, 150)

				var_392_0.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10030, var_392_6, var_392_5)
			end

			if arg_389_1.time_ >= var_392_1 + var_392_4 and arg_389_1.time_ < var_392_1 + var_392_4 + arg_392_0 then
				var_392_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_392_7 = arg_389_1.actors_["10030"]
			local var_392_8 = 0

			if var_392_8 < arg_389_1.time_ and arg_389_1.time_ <= var_392_8 + arg_392_0 then
				local var_392_9 = var_392_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_392_9 then
					arg_389_1.var_.alphaOldValue10030 = var_392_9.alpha
					arg_389_1.var_.characterEffect10030 = var_392_9
				end

				arg_389_1.var_.alphaOldValue10030 = 0
			end

			local var_392_10 = 0.333333333333333

			if var_392_8 <= arg_389_1.time_ and arg_389_1.time_ < var_392_8 + var_392_10 then
				local var_392_11 = (arg_389_1.time_ - var_392_8) / var_392_10
				local var_392_12 = Mathf.Lerp(arg_389_1.var_.alphaOldValue10030, 1, var_392_11)

				if arg_389_1.var_.characterEffect10030 then
					arg_389_1.var_.characterEffect10030.alpha = var_392_12
				end
			end

			if arg_389_1.time_ >= var_392_8 + var_392_10 and arg_389_1.time_ < var_392_8 + var_392_10 + arg_392_0 and arg_389_1.var_.characterEffect10030 then
				arg_389_1.var_.characterEffect10030.alpha = 1
			end

			local var_392_13 = arg_389_1.actors_["10029"].transform
			local var_392_14 = 0

			if var_392_14 < arg_389_1.time_ and arg_389_1.time_ <= var_392_14 + arg_392_0 then
				arg_389_1.var_.moveOldPos10029 = var_392_13.localPosition
				var_392_13.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_392_15 = 0.001

			if var_392_14 <= arg_389_1.time_ and arg_389_1.time_ < var_392_14 + var_392_15 then
				local var_392_16 = (arg_389_1.time_ - var_392_14) / var_392_15
				local var_392_17 = Vector3.New(-390, -350, -180)

				var_392_13.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10029, var_392_17, var_392_16)
			end

			if arg_389_1.time_ >= var_392_14 + var_392_15 and arg_389_1.time_ < var_392_14 + var_392_15 + arg_392_0 then
				var_392_13.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_392_18 = arg_389_1.actors_["10029"]
			local var_392_19 = 0

			if var_392_19 < arg_389_1.time_ and arg_389_1.time_ <= var_392_19 + arg_392_0 then
				local var_392_20 = var_392_18:GetComponent("Image")

				if var_392_20 then
					arg_389_1.var_.alphaMatValue10029 = var_392_20
					arg_389_1.var_.alphaOldValue10029 = var_392_20.color.a
				end

				arg_389_1.var_.alphaOldValue10029 = 0
			end

			local var_392_21 = 0.333333333333333

			if var_392_19 <= arg_389_1.time_ and arg_389_1.time_ < var_392_19 + var_392_21 then
				local var_392_22 = (arg_389_1.time_ - var_392_19) / var_392_21
				local var_392_23 = Mathf.Lerp(arg_389_1.var_.alphaOldValue10029, 1, var_392_22)

				if arg_389_1.var_.alphaMatValue10029 then
					local var_392_24 = arg_389_1.var_.alphaMatValue10029.color

					var_392_24.a = var_392_23
					arg_389_1.var_.alphaMatValue10029.color = var_392_24
				end
			end

			if arg_389_1.time_ >= var_392_19 + var_392_21 and arg_389_1.time_ < var_392_19 + var_392_21 + arg_392_0 and arg_389_1.var_.alphaMatValue10029 then
				local var_392_25 = arg_389_1.var_.alphaMatValue10029
				local var_392_26 = var_392_25.color

				var_392_26.a = 1
				var_392_25.color = var_392_26
			end

			local var_392_27 = arg_389_1.actors_["10030"]
			local var_392_28 = 0

			if var_392_28 < arg_389_1.time_ and arg_389_1.time_ <= var_392_28 + arg_392_0 and not isNil(var_392_27) and arg_389_1.var_.actorSpriteComps10030 == nil then
				arg_389_1.var_.actorSpriteComps10030 = var_392_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_29 = 0.2

			if var_392_28 <= arg_389_1.time_ and arg_389_1.time_ < var_392_28 + var_392_29 and not isNil(var_392_27) then
				local var_392_30 = (arg_389_1.time_ - var_392_28) / var_392_29

				if arg_389_1.var_.actorSpriteComps10030 then
					for iter_392_1, iter_392_2 in pairs(arg_389_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_392_2 then
							if arg_389_1.isInRecall_ then
								local var_392_31 = Mathf.Lerp(iter_392_2.color.r, arg_389_1.hightColor1.r, var_392_30)
								local var_392_32 = Mathf.Lerp(iter_392_2.color.g, arg_389_1.hightColor1.g, var_392_30)
								local var_392_33 = Mathf.Lerp(iter_392_2.color.b, arg_389_1.hightColor1.b, var_392_30)

								iter_392_2.color = Color.New(var_392_31, var_392_32, var_392_33)
							else
								local var_392_34 = Mathf.Lerp(iter_392_2.color.r, 1, var_392_30)

								iter_392_2.color = Color.New(var_392_34, var_392_34, var_392_34)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= var_392_28 + var_392_29 and arg_389_1.time_ < var_392_28 + var_392_29 + arg_392_0 and not isNil(var_392_27) and arg_389_1.var_.actorSpriteComps10030 then
				for iter_392_3, iter_392_4 in pairs(arg_389_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_392_4 then
						if arg_389_1.isInRecall_ then
							iter_392_4.color = arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_392_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_389_1.var_.actorSpriteComps10030 = nil
			end

			local var_392_35 = arg_389_1.actors_["10029"]
			local var_392_36 = 0

			if var_392_36 < arg_389_1.time_ and arg_389_1.time_ <= var_392_36 + arg_392_0 and not isNil(var_392_35) then
				local var_392_37 = var_392_35:GetComponent("Image")

				if var_392_37 then
					arg_389_1.var_.highlightMatValue10029 = var_392_37
				end
			end

			local var_392_38 = 0.2

			if var_392_36 <= arg_389_1.time_ and arg_389_1.time_ < var_392_36 + var_392_38 and not isNil(var_392_35) then
				local var_392_39 = (arg_389_1.time_ - var_392_36) / var_392_38

				if arg_389_1.var_.highlightMatValue10029 then
					local var_392_40 = Mathf.Lerp(1, 0.5, var_392_39)
					local var_392_41 = arg_389_1.var_.highlightMatValue10029
					local var_392_42 = var_392_41.color

					var_392_42.r = var_392_40
					var_392_42.g = var_392_40
					var_392_42.b = var_392_40
					var_392_41.color = var_392_42
				end
			end

			if arg_389_1.time_ >= var_392_36 + var_392_38 and arg_389_1.time_ < var_392_36 + var_392_38 + arg_392_0 and not isNil(var_392_35) and arg_389_1.var_.highlightMatValue10029 then
				local var_392_43 = 0.5
				local var_392_44 = arg_389_1.var_.highlightMatValue10029
				local var_392_45 = var_392_44.color

				var_392_45.r = var_392_43
				var_392_45.g = var_392_43
				var_392_45.b = var_392_43
				var_392_44.color = var_392_45
			end

			local var_392_46 = 0
			local var_392_47 = 0.8

			if var_392_46 < arg_389_1.time_ and arg_389_1.time_ <= var_392_46 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_48 = arg_389_1:FormatText(StoryNameCfg[309].name)

				arg_389_1.leftNameTxt_.text = var_392_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_49 = arg_389_1:GetWordFromCfg(115261095)
				local var_392_50 = arg_389_1:FormatText(var_392_49.content)

				arg_389_1.text_.text = var_392_50

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_51 = 32
				local var_392_52 = utf8.len(var_392_50)
				local var_392_53 = var_392_51 <= 0 and var_392_47 or var_392_47 * (var_392_52 / var_392_51)

				if var_392_53 > 0 and var_392_47 < var_392_53 then
					arg_389_1.talkMaxDuration = var_392_53

					if var_392_53 + var_392_46 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_53 + var_392_46
					end
				end

				arg_389_1.text_.text = var_392_50
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261095", "story_v_out_115261.awb") ~= 0 then
					local var_392_54 = manager.audio:GetVoiceLength("story_v_out_115261", "115261095", "story_v_out_115261.awb") / 1000

					if var_392_54 + var_392_46 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_54 + var_392_46
					end

					if var_392_49.prefab_name ~= "" and arg_389_1.actors_[var_392_49.prefab_name] ~= nil then
						local var_392_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_49.prefab_name].transform, "story_v_out_115261", "115261095", "story_v_out_115261.awb")

						arg_389_1:RecordAudio("115261095", var_392_55)
						arg_389_1:RecordAudio("115261095", var_392_55)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_115261", "115261095", "story_v_out_115261.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_115261", "115261095", "story_v_out_115261.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_56 = math.max(var_392_47, arg_389_1.talkMaxDuration)

			if var_392_46 <= arg_389_1.time_ and arg_389_1.time_ < var_392_46 + var_392_56 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_46) / var_392_56

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_46 + var_392_56 and arg_389_1.time_ < var_392_46 + var_392_56 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play115261096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 115261096
		arg_393_1.duration_ = 13.07

		local var_393_0 = {
			ja = 10.8,
			ko = 9.9,
			zh = 10.5,
			en = 13.066
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play115261097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["10030"]
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.actorSpriteComps10030 == nil then
				arg_393_1.var_.actorSpriteComps10030 = var_396_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_2 = 0.2

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 and not isNil(var_396_0) then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2

				if arg_393_1.var_.actorSpriteComps10030 then
					for iter_396_0, iter_396_1 in pairs(arg_393_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_396_1 then
							if arg_393_1.isInRecall_ then
								local var_396_4 = Mathf.Lerp(iter_396_1.color.r, arg_393_1.hightColor2.r, var_396_3)
								local var_396_5 = Mathf.Lerp(iter_396_1.color.g, arg_393_1.hightColor2.g, var_396_3)
								local var_396_6 = Mathf.Lerp(iter_396_1.color.b, arg_393_1.hightColor2.b, var_396_3)

								iter_396_1.color = Color.New(var_396_4, var_396_5, var_396_6)
							else
								local var_396_7 = Mathf.Lerp(iter_396_1.color.r, 0.5, var_396_3)

								iter_396_1.color = Color.New(var_396_7, var_396_7, var_396_7)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.actorSpriteComps10030 then
				for iter_396_2, iter_396_3 in pairs(arg_393_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_396_3 then
						if arg_393_1.isInRecall_ then
							iter_396_3.color = arg_393_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_396_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_393_1.var_.actorSpriteComps10030 = nil
			end

			local var_396_8 = arg_393_1.actors_["10029"]
			local var_396_9 = 0

			if var_396_9 < arg_393_1.time_ and arg_393_1.time_ <= var_396_9 + arg_396_0 and not isNil(var_396_8) then
				local var_396_10 = var_396_8:GetComponent("Image")

				if var_396_10 then
					arg_393_1.var_.highlightMatValue10029 = var_396_10
				end
			end

			local var_396_11 = 0.2

			if var_396_9 <= arg_393_1.time_ and arg_393_1.time_ < var_396_9 + var_396_11 and not isNil(var_396_8) then
				local var_396_12 = (arg_393_1.time_ - var_396_9) / var_396_11

				if arg_393_1.var_.highlightMatValue10029 then
					local var_396_13 = Mathf.Lerp(0.5, 1, var_396_12)
					local var_396_14 = arg_393_1.var_.highlightMatValue10029
					local var_396_15 = var_396_14.color

					var_396_15.r = var_396_13
					var_396_15.g = var_396_13
					var_396_15.b = var_396_13
					var_396_14.color = var_396_15
				end
			end

			if arg_393_1.time_ >= var_396_9 + var_396_11 and arg_393_1.time_ < var_396_9 + var_396_11 + arg_396_0 and not isNil(var_396_8) and arg_393_1.var_.highlightMatValue10029 then
				local var_396_16 = 1

				var_396_8.transform:SetSiblingIndex(1)

				local var_396_17 = arg_393_1.var_.highlightMatValue10029
				local var_396_18 = var_396_17.color

				var_396_18.r = var_396_16
				var_396_18.g = var_396_16
				var_396_18.b = var_396_16
				var_396_17.color = var_396_18
			end

			local var_396_19 = 0
			local var_396_20 = 0.9

			if var_396_19 < arg_393_1.time_ and arg_393_1.time_ <= var_396_19 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_21 = arg_393_1:FormatText(StoryNameCfg[312].name)

				arg_393_1.leftNameTxt_.text = var_396_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_22 = arg_393_1:GetWordFromCfg(115261096)
				local var_396_23 = arg_393_1:FormatText(var_396_22.content)

				arg_393_1.text_.text = var_396_23

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_24 = 36
				local var_396_25 = utf8.len(var_396_23)
				local var_396_26 = var_396_24 <= 0 and var_396_20 or var_396_20 * (var_396_25 / var_396_24)

				if var_396_26 > 0 and var_396_20 < var_396_26 then
					arg_393_1.talkMaxDuration = var_396_26

					if var_396_26 + var_396_19 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_26 + var_396_19
					end
				end

				arg_393_1.text_.text = var_396_23
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261096", "story_v_out_115261.awb") ~= 0 then
					local var_396_27 = manager.audio:GetVoiceLength("story_v_out_115261", "115261096", "story_v_out_115261.awb") / 1000

					if var_396_27 + var_396_19 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_27 + var_396_19
					end

					if var_396_22.prefab_name ~= "" and arg_393_1.actors_[var_396_22.prefab_name] ~= nil then
						local var_396_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_22.prefab_name].transform, "story_v_out_115261", "115261096", "story_v_out_115261.awb")

						arg_393_1:RecordAudio("115261096", var_396_28)
						arg_393_1:RecordAudio("115261096", var_396_28)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_115261", "115261096", "story_v_out_115261.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_115261", "115261096", "story_v_out_115261.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_29 = math.max(var_396_20, arg_393_1.talkMaxDuration)

			if var_396_19 <= arg_393_1.time_ and arg_393_1.time_ < var_396_19 + var_396_29 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_19) / var_396_29

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_19 + var_396_29 and arg_393_1.time_ < var_396_19 + var_396_29 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play115261097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 115261097
		arg_397_1.duration_ = 18.03

		local var_397_0 = {
			ja = 8.666,
			ko = 14.9,
			zh = 11.933,
			en = 18.033
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play115261098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0
			local var_400_1 = 1.25

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_2 = arg_397_1:FormatText(StoryNameCfg[312].name)

				arg_397_1.leftNameTxt_.text = var_400_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_3 = arg_397_1:GetWordFromCfg(115261097)
				local var_400_4 = arg_397_1:FormatText(var_400_3.content)

				arg_397_1.text_.text = var_400_4

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_5 = 50
				local var_400_6 = utf8.len(var_400_4)
				local var_400_7 = var_400_5 <= 0 and var_400_1 or var_400_1 * (var_400_6 / var_400_5)

				if var_400_7 > 0 and var_400_1 < var_400_7 then
					arg_397_1.talkMaxDuration = var_400_7

					if var_400_7 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_7 + var_400_0
					end
				end

				arg_397_1.text_.text = var_400_4
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261097", "story_v_out_115261.awb") ~= 0 then
					local var_400_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261097", "story_v_out_115261.awb") / 1000

					if var_400_8 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_8 + var_400_0
					end

					if var_400_3.prefab_name ~= "" and arg_397_1.actors_[var_400_3.prefab_name] ~= nil then
						local var_400_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_3.prefab_name].transform, "story_v_out_115261", "115261097", "story_v_out_115261.awb")

						arg_397_1:RecordAudio("115261097", var_400_9)
						arg_397_1:RecordAudio("115261097", var_400_9)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_115261", "115261097", "story_v_out_115261.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_115261", "115261097", "story_v_out_115261.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_10 = math.max(var_400_1, arg_397_1.talkMaxDuration)

			if var_400_0 <= arg_397_1.time_ and arg_397_1.time_ < var_400_0 + var_400_10 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_0) / var_400_10

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_0 + var_400_10 and arg_397_1.time_ < var_400_0 + var_400_10 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play115261098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 115261098
		arg_401_1.duration_ = 1.63

		local var_401_0 = {
			ja = 1.066,
			ko = 1.366,
			zh = 1.633,
			en = 1.466
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
				arg_401_0:Play115261099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["10030"]
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.actorSpriteComps10030 == nil then
				arg_401_1.var_.actorSpriteComps10030 = var_404_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_2 = 0.2

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 and not isNil(var_404_0) then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2

				if arg_401_1.var_.actorSpriteComps10030 then
					for iter_404_0, iter_404_1 in pairs(arg_401_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_404_1 then
							if arg_401_1.isInRecall_ then
								local var_404_4 = Mathf.Lerp(iter_404_1.color.r, arg_401_1.hightColor1.r, var_404_3)
								local var_404_5 = Mathf.Lerp(iter_404_1.color.g, arg_401_1.hightColor1.g, var_404_3)
								local var_404_6 = Mathf.Lerp(iter_404_1.color.b, arg_401_1.hightColor1.b, var_404_3)

								iter_404_1.color = Color.New(var_404_4, var_404_5, var_404_6)
							else
								local var_404_7 = Mathf.Lerp(iter_404_1.color.r, 1, var_404_3)

								iter_404_1.color = Color.New(var_404_7, var_404_7, var_404_7)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.actorSpriteComps10030 then
				for iter_404_2, iter_404_3 in pairs(arg_401_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_404_3 then
						if arg_401_1.isInRecall_ then
							iter_404_3.color = arg_401_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_404_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_401_1.var_.actorSpriteComps10030 = nil
			end

			local var_404_8 = arg_401_1.actors_["10029"]
			local var_404_9 = 0

			if var_404_9 < arg_401_1.time_ and arg_401_1.time_ <= var_404_9 + arg_404_0 and not isNil(var_404_8) then
				local var_404_10 = var_404_8:GetComponent("Image")

				if var_404_10 then
					arg_401_1.var_.highlightMatValue10029 = var_404_10
				end
			end

			local var_404_11 = 0.2

			if var_404_9 <= arg_401_1.time_ and arg_401_1.time_ < var_404_9 + var_404_11 and not isNil(var_404_8) then
				local var_404_12 = (arg_401_1.time_ - var_404_9) / var_404_11

				if arg_401_1.var_.highlightMatValue10029 then
					local var_404_13 = Mathf.Lerp(1, 0.5, var_404_12)
					local var_404_14 = arg_401_1.var_.highlightMatValue10029
					local var_404_15 = var_404_14.color

					var_404_15.r = var_404_13
					var_404_15.g = var_404_13
					var_404_15.b = var_404_13
					var_404_14.color = var_404_15
				end
			end

			if arg_401_1.time_ >= var_404_9 + var_404_11 and arg_401_1.time_ < var_404_9 + var_404_11 + arg_404_0 and not isNil(var_404_8) and arg_401_1.var_.highlightMatValue10029 then
				local var_404_16 = 0.5
				local var_404_17 = arg_401_1.var_.highlightMatValue10029
				local var_404_18 = var_404_17.color

				var_404_18.r = var_404_16
				var_404_18.g = var_404_16
				var_404_18.b = var_404_16
				var_404_17.color = var_404_18
			end

			local var_404_19 = 0
			local var_404_20 = 0.1

			if var_404_19 < arg_401_1.time_ and arg_401_1.time_ <= var_404_19 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_21 = arg_401_1:FormatText(StoryNameCfg[309].name)

				arg_401_1.leftNameTxt_.text = var_404_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_22 = arg_401_1:GetWordFromCfg(115261098)
				local var_404_23 = arg_401_1:FormatText(var_404_22.content)

				arg_401_1.text_.text = var_404_23

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_24 = 4
				local var_404_25 = utf8.len(var_404_23)
				local var_404_26 = var_404_24 <= 0 and var_404_20 or var_404_20 * (var_404_25 / var_404_24)

				if var_404_26 > 0 and var_404_20 < var_404_26 then
					arg_401_1.talkMaxDuration = var_404_26

					if var_404_26 + var_404_19 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_26 + var_404_19
					end
				end

				arg_401_1.text_.text = var_404_23
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261098", "story_v_out_115261.awb") ~= 0 then
					local var_404_27 = manager.audio:GetVoiceLength("story_v_out_115261", "115261098", "story_v_out_115261.awb") / 1000

					if var_404_27 + var_404_19 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_27 + var_404_19
					end

					if var_404_22.prefab_name ~= "" and arg_401_1.actors_[var_404_22.prefab_name] ~= nil then
						local var_404_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_22.prefab_name].transform, "story_v_out_115261", "115261098", "story_v_out_115261.awb")

						arg_401_1:RecordAudio("115261098", var_404_28)
						arg_401_1:RecordAudio("115261098", var_404_28)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_115261", "115261098", "story_v_out_115261.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_115261", "115261098", "story_v_out_115261.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_29 = math.max(var_404_20, arg_401_1.talkMaxDuration)

			if var_404_19 <= arg_401_1.time_ and arg_401_1.time_ < var_404_19 + var_404_29 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_19) / var_404_29

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_19 + var_404_29 and arg_401_1.time_ < var_404_19 + var_404_29 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play115261099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 115261099
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play115261100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["10030"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				local var_408_2 = var_408_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_408_2 then
					arg_405_1.var_.alphaOldValue10030 = var_408_2.alpha
					arg_405_1.var_.characterEffect10030 = var_408_2
				end

				arg_405_1.var_.alphaOldValue10030 = 1
			end

			local var_408_3 = 0.333333333333333

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_3 then
				local var_408_4 = (arg_405_1.time_ - var_408_1) / var_408_3
				local var_408_5 = Mathf.Lerp(arg_405_1.var_.alphaOldValue10030, 0, var_408_4)

				if arg_405_1.var_.characterEffect10030 then
					arg_405_1.var_.characterEffect10030.alpha = var_408_5
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_3 and arg_405_1.time_ < var_408_1 + var_408_3 + arg_408_0 and arg_405_1.var_.characterEffect10030 then
				arg_405_1.var_.characterEffect10030.alpha = 0
			end

			local var_408_6 = arg_405_1.actors_["10029"]
			local var_408_7 = 0

			if var_408_7 < arg_405_1.time_ and arg_405_1.time_ <= var_408_7 + arg_408_0 then
				local var_408_8 = var_408_6:GetComponent("Image")

				if var_408_8 then
					arg_405_1.var_.alphaMatValue10029 = var_408_8
					arg_405_1.var_.alphaOldValue10029 = var_408_8.color.a
				end

				arg_405_1.var_.alphaOldValue10029 = 1
			end

			local var_408_9 = 0.333333333333333

			if var_408_7 <= arg_405_1.time_ and arg_405_1.time_ < var_408_7 + var_408_9 then
				local var_408_10 = (arg_405_1.time_ - var_408_7) / var_408_9
				local var_408_11 = Mathf.Lerp(arg_405_1.var_.alphaOldValue10029, 0, var_408_10)

				if arg_405_1.var_.alphaMatValue10029 then
					local var_408_12 = arg_405_1.var_.alphaMatValue10029.color

					var_408_12.a = var_408_11
					arg_405_1.var_.alphaMatValue10029.color = var_408_12
				end
			end

			if arg_405_1.time_ >= var_408_7 + var_408_9 and arg_405_1.time_ < var_408_7 + var_408_9 + arg_408_0 and arg_405_1.var_.alphaMatValue10029 then
				local var_408_13 = arg_405_1.var_.alphaMatValue10029
				local var_408_14 = var_408_13.color

				var_408_14.a = 0
				var_408_13.color = var_408_14
			end

			local var_408_15 = 0
			local var_408_16 = 0.575

			if var_408_15 < arg_405_1.time_ and arg_405_1.time_ <= var_408_15 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_17 = arg_405_1:GetWordFromCfg(115261099)
				local var_408_18 = arg_405_1:FormatText(var_408_17.content)

				arg_405_1.text_.text = var_408_18

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_19 = 23
				local var_408_20 = utf8.len(var_408_18)
				local var_408_21 = var_408_19 <= 0 and var_408_16 or var_408_16 * (var_408_20 / var_408_19)

				if var_408_21 > 0 and var_408_16 < var_408_21 then
					arg_405_1.talkMaxDuration = var_408_21

					if var_408_21 + var_408_15 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_21 + var_408_15
					end
				end

				arg_405_1.text_.text = var_408_18
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_22 = math.max(var_408_16, arg_405_1.talkMaxDuration)

			if var_408_15 <= arg_405_1.time_ and arg_405_1.time_ < var_408_15 + var_408_22 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_15) / var_408_22

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_15 + var_408_22 and arg_405_1.time_ < var_408_15 + var_408_22 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play115261100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 115261100
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play115261101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0
			local var_412_1 = 0.75

			if var_412_0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_2 = arg_409_1:GetWordFromCfg(115261100)
				local var_412_3 = arg_409_1:FormatText(var_412_2.content)

				arg_409_1.text_.text = var_412_3

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_4 = 30
				local var_412_5 = utf8.len(var_412_3)
				local var_412_6 = var_412_4 <= 0 and var_412_1 or var_412_1 * (var_412_5 / var_412_4)

				if var_412_6 > 0 and var_412_1 < var_412_6 then
					arg_409_1.talkMaxDuration = var_412_6

					if var_412_6 + var_412_0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_6 + var_412_0
					end
				end

				arg_409_1.text_.text = var_412_3
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_7 = math.max(var_412_1, arg_409_1.talkMaxDuration)

			if var_412_0 <= arg_409_1.time_ and arg_409_1.time_ < var_412_0 + var_412_7 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_0) / var_412_7

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_0 + var_412_7 and arg_409_1.time_ < var_412_0 + var_412_7 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play115261101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 115261101
		arg_413_1.duration_ = 3.97

		local var_413_0 = {
			ja = 2.666,
			ko = 3.433,
			zh = 3.966,
			en = 3.066
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play115261102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["10029"].transform
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.var_.moveOldPos10029 = var_416_0.localPosition
				var_416_0.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("10029", 3)
			end

			local var_416_2 = 0.001

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2
				local var_416_4 = Vector3.New(0, -350, -180)

				var_416_0.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos10029, var_416_4, var_416_3)
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 then
				var_416_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_416_5 = arg_413_1.actors_["10029"]
			local var_416_6 = 0

			if var_416_6 < arg_413_1.time_ and arg_413_1.time_ <= var_416_6 + arg_416_0 and not isNil(var_416_5) then
				local var_416_7 = var_416_5:GetComponent("Image")

				if var_416_7 then
					arg_413_1.var_.highlightMatValue10029 = var_416_7
				end
			end

			local var_416_8 = 0.2

			if var_416_6 <= arg_413_1.time_ and arg_413_1.time_ < var_416_6 + var_416_8 and not isNil(var_416_5) then
				local var_416_9 = (arg_413_1.time_ - var_416_6) / var_416_8

				if arg_413_1.var_.highlightMatValue10029 then
					local var_416_10 = Mathf.Lerp(0.5, 1, var_416_9)
					local var_416_11 = arg_413_1.var_.highlightMatValue10029
					local var_416_12 = var_416_11.color

					var_416_12.r = var_416_10
					var_416_12.g = var_416_10
					var_416_12.b = var_416_10
					var_416_11.color = var_416_12
				end
			end

			if arg_413_1.time_ >= var_416_6 + var_416_8 and arg_413_1.time_ < var_416_6 + var_416_8 + arg_416_0 and not isNil(var_416_5) and arg_413_1.var_.highlightMatValue10029 then
				local var_416_13 = 1

				var_416_5.transform:SetSiblingIndex(1)

				local var_416_14 = arg_413_1.var_.highlightMatValue10029
				local var_416_15 = var_416_14.color

				var_416_15.r = var_416_13
				var_416_15.g = var_416_13
				var_416_15.b = var_416_13
				var_416_14.color = var_416_15
			end

			local var_416_16 = arg_413_1.actors_["10029"]
			local var_416_17 = 0

			if var_416_17 < arg_413_1.time_ and arg_413_1.time_ <= var_416_17 + arg_416_0 then
				local var_416_18 = var_416_16:GetComponent("Image")

				if var_416_18 then
					arg_413_1.var_.alphaMatValue10029 = var_416_18
					arg_413_1.var_.alphaOldValue10029 = var_416_18.color.a
				end

				arg_413_1.var_.alphaOldValue10029 = 0
			end

			local var_416_19 = 0.333333333333333

			if var_416_17 <= arg_413_1.time_ and arg_413_1.time_ < var_416_17 + var_416_19 then
				local var_416_20 = (arg_413_1.time_ - var_416_17) / var_416_19
				local var_416_21 = Mathf.Lerp(arg_413_1.var_.alphaOldValue10029, 1, var_416_20)

				if arg_413_1.var_.alphaMatValue10029 then
					local var_416_22 = arg_413_1.var_.alphaMatValue10029.color

					var_416_22.a = var_416_21
					arg_413_1.var_.alphaMatValue10029.color = var_416_22
				end
			end

			if arg_413_1.time_ >= var_416_17 + var_416_19 and arg_413_1.time_ < var_416_17 + var_416_19 + arg_416_0 and arg_413_1.var_.alphaMatValue10029 then
				local var_416_23 = arg_413_1.var_.alphaMatValue10029
				local var_416_24 = var_416_23.color

				var_416_24.a = 1
				var_416_23.color = var_416_24
			end

			local var_416_25 = 0
			local var_416_26 = 0.175

			if var_416_25 < arg_413_1.time_ and arg_413_1.time_ <= var_416_25 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_27 = arg_413_1:FormatText(StoryNameCfg[312].name)

				arg_413_1.leftNameTxt_.text = var_416_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_28 = arg_413_1:GetWordFromCfg(115261101)
				local var_416_29 = arg_413_1:FormatText(var_416_28.content)

				arg_413_1.text_.text = var_416_29

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_30 = 7
				local var_416_31 = utf8.len(var_416_29)
				local var_416_32 = var_416_30 <= 0 and var_416_26 or var_416_26 * (var_416_31 / var_416_30)

				if var_416_32 > 0 and var_416_26 < var_416_32 then
					arg_413_1.talkMaxDuration = var_416_32

					if var_416_32 + var_416_25 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_32 + var_416_25
					end
				end

				arg_413_1.text_.text = var_416_29
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261101", "story_v_out_115261.awb") ~= 0 then
					local var_416_33 = manager.audio:GetVoiceLength("story_v_out_115261", "115261101", "story_v_out_115261.awb") / 1000

					if var_416_33 + var_416_25 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_33 + var_416_25
					end

					if var_416_28.prefab_name ~= "" and arg_413_1.actors_[var_416_28.prefab_name] ~= nil then
						local var_416_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_28.prefab_name].transform, "story_v_out_115261", "115261101", "story_v_out_115261.awb")

						arg_413_1:RecordAudio("115261101", var_416_34)
						arg_413_1:RecordAudio("115261101", var_416_34)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_115261", "115261101", "story_v_out_115261.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_115261", "115261101", "story_v_out_115261.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_35 = math.max(var_416_26, arg_413_1.talkMaxDuration)

			if var_416_25 <= arg_413_1.time_ and arg_413_1.time_ < var_416_25 + var_416_35 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_25) / var_416_35

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_25 + var_416_35 and arg_413_1.time_ < var_416_25 + var_416_35 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play115261102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 115261102
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play115261103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["10029"]
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 and not isNil(var_420_0) then
				local var_420_2 = var_420_0:GetComponent("Image")

				if var_420_2 then
					arg_417_1.var_.highlightMatValue10029 = var_420_2
				end
			end

			local var_420_3 = 0.2

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_3 and not isNil(var_420_0) then
				local var_420_4 = (arg_417_1.time_ - var_420_1) / var_420_3

				if arg_417_1.var_.highlightMatValue10029 then
					local var_420_5 = Mathf.Lerp(1, 0.5, var_420_4)
					local var_420_6 = arg_417_1.var_.highlightMatValue10029
					local var_420_7 = var_420_6.color

					var_420_7.r = var_420_5
					var_420_7.g = var_420_5
					var_420_7.b = var_420_5
					var_420_6.color = var_420_7
				end
			end

			if arg_417_1.time_ >= var_420_1 + var_420_3 and arg_417_1.time_ < var_420_1 + var_420_3 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.highlightMatValue10029 then
				local var_420_8 = 0.5
				local var_420_9 = arg_417_1.var_.highlightMatValue10029
				local var_420_10 = var_420_9.color

				var_420_10.r = var_420_8
				var_420_10.g = var_420_8
				var_420_10.b = var_420_8
				var_420_9.color = var_420_10
			end

			local var_420_11 = 0
			local var_420_12 = 0.95

			if var_420_11 < arg_417_1.time_ and arg_417_1.time_ <= var_420_11 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, false)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_13 = arg_417_1:GetWordFromCfg(115261102)
				local var_420_14 = arg_417_1:FormatText(var_420_13.content)

				arg_417_1.text_.text = var_420_14

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_15 = 38
				local var_420_16 = utf8.len(var_420_14)
				local var_420_17 = var_420_15 <= 0 and var_420_12 or var_420_12 * (var_420_16 / var_420_15)

				if var_420_17 > 0 and var_420_12 < var_420_17 then
					arg_417_1.talkMaxDuration = var_420_17

					if var_420_17 + var_420_11 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_17 + var_420_11
					end
				end

				arg_417_1.text_.text = var_420_14
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_18 = math.max(var_420_12, arg_417_1.talkMaxDuration)

			if var_420_11 <= arg_417_1.time_ and arg_417_1.time_ < var_420_11 + var_420_18 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_11) / var_420_18

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_11 + var_420_18 and arg_417_1.time_ < var_420_11 + var_420_18 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play115261103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 115261103
		arg_421_1.duration_ = 9.07

		local var_421_0 = {
			ja = 9.066,
			ko = 5.866,
			zh = 8.133,
			en = 6.5
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play115261104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0
			local var_424_1 = 0.575

			if var_424_0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_2 = arg_421_1:FormatText(StoryNameCfg[310].name)

				arg_421_1.leftNameTxt_.text = var_424_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_3 = arg_421_1:GetWordFromCfg(115261103)
				local var_424_4 = arg_421_1:FormatText(var_424_3.content)

				arg_421_1.text_.text = var_424_4

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_5 = 23
				local var_424_6 = utf8.len(var_424_4)
				local var_424_7 = var_424_5 <= 0 and var_424_1 or var_424_1 * (var_424_6 / var_424_5)

				if var_424_7 > 0 and var_424_1 < var_424_7 then
					arg_421_1.talkMaxDuration = var_424_7

					if var_424_7 + var_424_0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_7 + var_424_0
					end
				end

				arg_421_1.text_.text = var_424_4
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261103", "story_v_out_115261.awb") ~= 0 then
					local var_424_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261103", "story_v_out_115261.awb") / 1000

					if var_424_8 + var_424_0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_8 + var_424_0
					end

					if var_424_3.prefab_name ~= "" and arg_421_1.actors_[var_424_3.prefab_name] ~= nil then
						local var_424_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_3.prefab_name].transform, "story_v_out_115261", "115261103", "story_v_out_115261.awb")

						arg_421_1:RecordAudio("115261103", var_424_9)
						arg_421_1:RecordAudio("115261103", var_424_9)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_115261", "115261103", "story_v_out_115261.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_115261", "115261103", "story_v_out_115261.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_10 = math.max(var_424_1, arg_421_1.talkMaxDuration)

			if var_424_0 <= arg_421_1.time_ and arg_421_1.time_ < var_424_0 + var_424_10 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_0) / var_424_10

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_0 + var_424_10 and arg_421_1.time_ < var_424_0 + var_424_10 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play115261104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 115261104
		arg_425_1.duration_ = 6.87

		local var_425_0 = {
			ja = 6.833,
			ko = 6.866,
			zh = 6.166,
			en = 6.133
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
				arg_425_0:Play115261105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["10029"]
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 and not isNil(var_428_0) then
				local var_428_2 = var_428_0:GetComponent("Image")

				if var_428_2 then
					arg_425_1.var_.highlightMatValue10029 = var_428_2
				end
			end

			local var_428_3 = 0.2

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_3 and not isNil(var_428_0) then
				local var_428_4 = (arg_425_1.time_ - var_428_1) / var_428_3

				if arg_425_1.var_.highlightMatValue10029 then
					local var_428_5 = Mathf.Lerp(0.5, 1, var_428_4)
					local var_428_6 = arg_425_1.var_.highlightMatValue10029
					local var_428_7 = var_428_6.color

					var_428_7.r = var_428_5
					var_428_7.g = var_428_5
					var_428_7.b = var_428_5
					var_428_6.color = var_428_7
				end
			end

			if arg_425_1.time_ >= var_428_1 + var_428_3 and arg_425_1.time_ < var_428_1 + var_428_3 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.highlightMatValue10029 then
				local var_428_8 = 1

				var_428_0.transform:SetSiblingIndex(1)

				local var_428_9 = arg_425_1.var_.highlightMatValue10029
				local var_428_10 = var_428_9.color

				var_428_10.r = var_428_8
				var_428_10.g = var_428_8
				var_428_10.b = var_428_8
				var_428_9.color = var_428_10
			end

			local var_428_11 = 0
			local var_428_12 = 0.625

			if var_428_11 < arg_425_1.time_ and arg_425_1.time_ <= var_428_11 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_13 = arg_425_1:FormatText(StoryNameCfg[312].name)

				arg_425_1.leftNameTxt_.text = var_428_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_14 = arg_425_1:GetWordFromCfg(115261104)
				local var_428_15 = arg_425_1:FormatText(var_428_14.content)

				arg_425_1.text_.text = var_428_15

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_16 = 24
				local var_428_17 = utf8.len(var_428_15)
				local var_428_18 = var_428_16 <= 0 and var_428_12 or var_428_12 * (var_428_17 / var_428_16)

				if var_428_18 > 0 and var_428_12 < var_428_18 then
					arg_425_1.talkMaxDuration = var_428_18

					if var_428_18 + var_428_11 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_18 + var_428_11
					end
				end

				arg_425_1.text_.text = var_428_15
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261104", "story_v_out_115261.awb") ~= 0 then
					local var_428_19 = manager.audio:GetVoiceLength("story_v_out_115261", "115261104", "story_v_out_115261.awb") / 1000

					if var_428_19 + var_428_11 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_19 + var_428_11
					end

					if var_428_14.prefab_name ~= "" and arg_425_1.actors_[var_428_14.prefab_name] ~= nil then
						local var_428_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_14.prefab_name].transform, "story_v_out_115261", "115261104", "story_v_out_115261.awb")

						arg_425_1:RecordAudio("115261104", var_428_20)
						arg_425_1:RecordAudio("115261104", var_428_20)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_115261", "115261104", "story_v_out_115261.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_115261", "115261104", "story_v_out_115261.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_21 = math.max(var_428_12, arg_425_1.talkMaxDuration)

			if var_428_11 <= arg_425_1.time_ and arg_425_1.time_ < var_428_11 + var_428_21 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_11) / var_428_21

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_11 + var_428_21 and arg_425_1.time_ < var_428_11 + var_428_21 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play115261105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 115261105
		arg_429_1.duration_ = 8.7

		local var_429_0 = {
			ja = 8,
			ko = 8.7,
			zh = 7.8,
			en = 8.066
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play115261106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["10029"]
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 and not isNil(var_432_0) then
				local var_432_2 = var_432_0:GetComponent("Image")

				if var_432_2 then
					arg_429_1.var_.highlightMatValue10029 = var_432_2
				end
			end

			local var_432_3 = 0.2

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_3 and not isNil(var_432_0) then
				local var_432_4 = (arg_429_1.time_ - var_432_1) / var_432_3

				if arg_429_1.var_.highlightMatValue10029 then
					local var_432_5 = Mathf.Lerp(1, 0.5, var_432_4)
					local var_432_6 = arg_429_1.var_.highlightMatValue10029
					local var_432_7 = var_432_6.color

					var_432_7.r = var_432_5
					var_432_7.g = var_432_5
					var_432_7.b = var_432_5
					var_432_6.color = var_432_7
				end
			end

			if arg_429_1.time_ >= var_432_1 + var_432_3 and arg_429_1.time_ < var_432_1 + var_432_3 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.highlightMatValue10029 then
				local var_432_8 = 0.5
				local var_432_9 = arg_429_1.var_.highlightMatValue10029
				local var_432_10 = var_432_9.color

				var_432_10.r = var_432_8
				var_432_10.g = var_432_8
				var_432_10.b = var_432_8
				var_432_9.color = var_432_10
			end

			local var_432_11 = 0
			local var_432_12 = 0.7

			if var_432_11 < arg_429_1.time_ and arg_429_1.time_ <= var_432_11 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_13 = arg_429_1:FormatText(StoryNameCfg[310].name)

				arg_429_1.leftNameTxt_.text = var_432_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_14 = arg_429_1:GetWordFromCfg(115261105)
				local var_432_15 = arg_429_1:FormatText(var_432_14.content)

				arg_429_1.text_.text = var_432_15

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_16 = 28
				local var_432_17 = utf8.len(var_432_15)
				local var_432_18 = var_432_16 <= 0 and var_432_12 or var_432_12 * (var_432_17 / var_432_16)

				if var_432_18 > 0 and var_432_12 < var_432_18 then
					arg_429_1.talkMaxDuration = var_432_18

					if var_432_18 + var_432_11 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_18 + var_432_11
					end
				end

				arg_429_1.text_.text = var_432_15
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261105", "story_v_out_115261.awb") ~= 0 then
					local var_432_19 = manager.audio:GetVoiceLength("story_v_out_115261", "115261105", "story_v_out_115261.awb") / 1000

					if var_432_19 + var_432_11 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_19 + var_432_11
					end

					if var_432_14.prefab_name ~= "" and arg_429_1.actors_[var_432_14.prefab_name] ~= nil then
						local var_432_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_14.prefab_name].transform, "story_v_out_115261", "115261105", "story_v_out_115261.awb")

						arg_429_1:RecordAudio("115261105", var_432_20)
						arg_429_1:RecordAudio("115261105", var_432_20)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_115261", "115261105", "story_v_out_115261.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_115261", "115261105", "story_v_out_115261.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_21 = math.max(var_432_12, arg_429_1.talkMaxDuration)

			if var_432_11 <= arg_429_1.time_ and arg_429_1.time_ < var_432_11 + var_432_21 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_11) / var_432_21

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_11 + var_432_21 and arg_429_1.time_ < var_432_11 + var_432_21 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play115261106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 115261106
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play115261107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0
			local var_436_1 = 0.6

			if var_436_0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_2 = arg_433_1:GetWordFromCfg(115261106)
				local var_436_3 = arg_433_1:FormatText(var_436_2.content)

				arg_433_1.text_.text = var_436_3

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_4 = 24
				local var_436_5 = utf8.len(var_436_3)
				local var_436_6 = var_436_4 <= 0 and var_436_1 or var_436_1 * (var_436_5 / var_436_4)

				if var_436_6 > 0 and var_436_1 < var_436_6 then
					arg_433_1.talkMaxDuration = var_436_6

					if var_436_6 + var_436_0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_6 + var_436_0
					end
				end

				arg_433_1.text_.text = var_436_3
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_7 = math.max(var_436_1, arg_433_1.talkMaxDuration)

			if var_436_0 <= arg_433_1.time_ and arg_433_1.time_ < var_436_0 + var_436_7 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_0) / var_436_7

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_0 + var_436_7 and arg_433_1.time_ < var_436_0 + var_436_7 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play115261107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 115261107
		arg_437_1.duration_ = 17.57

		local var_437_0 = {
			ja = 11.533,
			ko = 17.566,
			zh = 17.333,
			en = 13.633
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play115261108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0
			local var_440_1 = 1.15

			if var_440_0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_2 = arg_437_1:FormatText(StoryNameCfg[310].name)

				arg_437_1.leftNameTxt_.text = var_440_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_3 = arg_437_1:GetWordFromCfg(115261107)
				local var_440_4 = arg_437_1:FormatText(var_440_3.content)

				arg_437_1.text_.text = var_440_4

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 45
				local var_440_6 = utf8.len(var_440_4)
				local var_440_7 = var_440_5 <= 0 and var_440_1 or var_440_1 * (var_440_6 / var_440_5)

				if var_440_7 > 0 and var_440_1 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_0
					end
				end

				arg_437_1.text_.text = var_440_4
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261107", "story_v_out_115261.awb") ~= 0 then
					local var_440_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261107", "story_v_out_115261.awb") / 1000

					if var_440_8 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_8 + var_440_0
					end

					if var_440_3.prefab_name ~= "" and arg_437_1.actors_[var_440_3.prefab_name] ~= nil then
						local var_440_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_3.prefab_name].transform, "story_v_out_115261", "115261107", "story_v_out_115261.awb")

						arg_437_1:RecordAudio("115261107", var_440_9)
						arg_437_1:RecordAudio("115261107", var_440_9)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_115261", "115261107", "story_v_out_115261.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_115261", "115261107", "story_v_out_115261.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_10 = math.max(var_440_1, arg_437_1.talkMaxDuration)

			if var_440_0 <= arg_437_1.time_ and arg_437_1.time_ < var_440_0 + var_440_10 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_0) / var_440_10

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_0 + var_440_10 and arg_437_1.time_ < var_440_0 + var_440_10 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play115261108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 115261108
		arg_441_1.duration_ = 9

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play115261109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = "ST22a"

			if arg_441_1.bgs_[var_444_0] == nil then
				local var_444_1 = Object.Instantiate(arg_441_1.paintGo_)

				var_444_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_444_0)
				var_444_1.name = var_444_0
				var_444_1.transform.parent = arg_441_1.stage_.transform
				var_444_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_441_1.bgs_[var_444_0] = var_444_1
			end

			local var_444_2 = 2

			if var_444_2 < arg_441_1.time_ and arg_441_1.time_ <= var_444_2 + arg_444_0 then
				local var_444_3 = manager.ui.mainCamera.transform.localPosition
				local var_444_4 = Vector3.New(0, 0, 10) + Vector3.New(var_444_3.x, var_444_3.y, 0)
				local var_444_5 = arg_441_1.bgs_.ST22a

				var_444_5.transform.localPosition = var_444_4
				var_444_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_444_6 = var_444_5:GetComponent("SpriteRenderer")

				if var_444_6 and var_444_6.sprite then
					local var_444_7 = (var_444_5.transform.localPosition - var_444_3).z
					local var_444_8 = manager.ui.mainCameraCom_
					local var_444_9 = 2 * var_444_7 * Mathf.Tan(var_444_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_444_10 = var_444_9 * var_444_8.aspect
					local var_444_11 = var_444_6.sprite.bounds.size.x
					local var_444_12 = var_444_6.sprite.bounds.size.y
					local var_444_13 = var_444_10 / var_444_11
					local var_444_14 = var_444_9 / var_444_12
					local var_444_15 = var_444_14 < var_444_13 and var_444_13 or var_444_14

					var_444_5.transform.localScale = Vector3.New(var_444_15, var_444_15, 0)
				end

				for iter_444_0, iter_444_1 in pairs(arg_441_1.bgs_) do
					if iter_444_0 ~= "ST22a" then
						iter_444_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_444_16 = 0

			if var_444_16 < arg_441_1.time_ and arg_441_1.time_ <= var_444_16 + arg_444_0 then
				arg_441_1.mask_.enabled = true
				arg_441_1.mask_.raycastTarget = false

				arg_441_1:SetGaussion(false)
			end

			local var_444_17 = 2

			if var_444_16 <= arg_441_1.time_ and arg_441_1.time_ < var_444_16 + var_444_17 then
				local var_444_18 = (arg_441_1.time_ - var_444_16) / var_444_17
				local var_444_19 = Color.New(0, 0, 0)

				var_444_19.a = Mathf.Lerp(0, 1, var_444_18)
				arg_441_1.mask_.color = var_444_19
			end

			if arg_441_1.time_ >= var_444_16 + var_444_17 and arg_441_1.time_ < var_444_16 + var_444_17 + arg_444_0 then
				local var_444_20 = Color.New(0, 0, 0)

				var_444_20.a = 1
				arg_441_1.mask_.color = var_444_20
			end

			local var_444_21 = 2

			if var_444_21 < arg_441_1.time_ and arg_441_1.time_ <= var_444_21 + arg_444_0 then
				arg_441_1.mask_.enabled = true
				arg_441_1.mask_.raycastTarget = false

				arg_441_1:SetGaussion(false)
			end

			local var_444_22 = 2

			if var_444_21 <= arg_441_1.time_ and arg_441_1.time_ < var_444_21 + var_444_22 then
				local var_444_23 = (arg_441_1.time_ - var_444_21) / var_444_22
				local var_444_24 = Color.New(0, 0, 0)

				var_444_24.a = Mathf.Lerp(1, 0, var_444_23)
				arg_441_1.mask_.color = var_444_24
			end

			if arg_441_1.time_ >= var_444_21 + var_444_22 and arg_441_1.time_ < var_444_21 + var_444_22 + arg_444_0 then
				local var_444_25 = Color.New(0, 0, 0)
				local var_444_26 = 0

				arg_441_1.mask_.enabled = false
				var_444_25.a = var_444_26
				arg_441_1.mask_.color = var_444_25
			end

			local var_444_27 = arg_441_1.actors_["10029"].transform
			local var_444_28 = 2

			if var_444_28 < arg_441_1.time_ and arg_441_1.time_ <= var_444_28 + arg_444_0 then
				arg_441_1.var_.moveOldPos10029 = var_444_27.localPosition
				var_444_27.localScale = Vector3.New(1, 1, 1)

				arg_441_1:CheckSpriteTmpPos("10029", 0)
			end

			local var_444_29 = 0.001

			if var_444_28 <= arg_441_1.time_ and arg_441_1.time_ < var_444_28 + var_444_29 then
				local var_444_30 = (arg_441_1.time_ - var_444_28) / var_444_29
				local var_444_31 = Vector3.New(-1500, -350, -180)

				var_444_27.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos10029, var_444_31, var_444_30)
			end

			if arg_441_1.time_ >= var_444_28 + var_444_29 and arg_441_1.time_ < var_444_28 + var_444_29 + arg_444_0 then
				var_444_27.localPosition = Vector3.New(-1500, -350, -180)
			end

			if arg_441_1.frameCnt_ <= 1 then
				arg_441_1.dialog_:SetActive(false)
			end

			local var_444_32 = 4
			local var_444_33 = 1.45

			if var_444_32 < arg_441_1.time_ and arg_441_1.time_ <= var_444_32 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0

				arg_441_1.dialog_:SetActive(true)

				arg_441_1.dialogCg_.alpha = 0

				local var_444_34 = LeanTween.value(arg_441_1.dialog_, 0, 1, 0.3)

				var_444_34:setOnUpdate(LuaHelper.FloatAction(function(arg_445_0)
					arg_441_1.dialogCg_.alpha = arg_445_0
				end))
				var_444_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_441_1.dialog_)
					var_444_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_441_1.duration_ = arg_441_1.duration_ + 0.3

				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_35 = arg_441_1:GetWordFromCfg(115261108)
				local var_444_36 = arg_441_1:FormatText(var_444_35.content)

				arg_441_1.text_.text = var_444_36

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_37 = 58
				local var_444_38 = utf8.len(var_444_36)
				local var_444_39 = var_444_37 <= 0 and var_444_33 or var_444_33 * (var_444_38 / var_444_37)

				if var_444_39 > 0 and var_444_33 < var_444_39 then
					arg_441_1.talkMaxDuration = var_444_39
					var_444_32 = var_444_32 + 0.3

					if var_444_39 + var_444_32 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_39 + var_444_32
					end
				end

				arg_441_1.text_.text = var_444_36
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_40 = var_444_32 + 0.3
			local var_444_41 = math.max(var_444_33, arg_441_1.talkMaxDuration)

			if var_444_40 <= arg_441_1.time_ and arg_441_1.time_ < var_444_40 + var_444_41 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_40) / var_444_41

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_40 + var_444_41 and arg_441_1.time_ < var_444_40 + var_444_41 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play115261109 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 115261109
		arg_447_1.duration_ = 5.7

		local var_447_0 = {
			ja = 5.7,
			ko = 3.366,
			zh = 3.766,
			en = 4.233
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
				arg_447_0:Play115261110(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = arg_447_1.actors_["10030"].transform
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1.var_.moveOldPos10030 = var_450_0.localPosition
				var_450_0.localScale = Vector3.New(1, 1, 1)

				arg_447_1:CheckSpriteTmpPos("10030", 3)

				local var_450_2 = var_450_0.childCount

				for iter_450_0 = 0, var_450_2 - 1 do
					local var_450_3 = var_450_0:GetChild(iter_450_0)

					if var_450_3.name == "split_3" or not string.find(var_450_3.name, "split") then
						var_450_3.gameObject:SetActive(true)
					else
						var_450_3.gameObject:SetActive(false)
					end
				end
			end

			local var_450_4 = 0.001

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_4 then
				local var_450_5 = (arg_447_1.time_ - var_450_1) / var_450_4
				local var_450_6 = Vector3.New(0, -390, 150)

				var_450_0.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos10030, var_450_6, var_450_5)
			end

			if arg_447_1.time_ >= var_450_1 + var_450_4 and arg_447_1.time_ < var_450_1 + var_450_4 + arg_450_0 then
				var_450_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_450_7 = arg_447_1.actors_["10030"]
			local var_450_8 = 0

			if var_450_8 < arg_447_1.time_ and arg_447_1.time_ <= var_450_8 + arg_450_0 then
				local var_450_9 = var_450_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_450_9 then
					arg_447_1.var_.alphaOldValue10030 = var_450_9.alpha
					arg_447_1.var_.characterEffect10030 = var_450_9
				end

				arg_447_1.var_.alphaOldValue10030 = 0
			end

			local var_450_10 = 0.325

			if var_450_8 <= arg_447_1.time_ and arg_447_1.time_ < var_450_8 + var_450_10 then
				local var_450_11 = (arg_447_1.time_ - var_450_8) / var_450_10
				local var_450_12 = Mathf.Lerp(arg_447_1.var_.alphaOldValue10030, 1, var_450_11)

				if arg_447_1.var_.characterEffect10030 then
					arg_447_1.var_.characterEffect10030.alpha = var_450_12
				end
			end

			if arg_447_1.time_ >= var_450_8 + var_450_10 and arg_447_1.time_ < var_450_8 + var_450_10 + arg_450_0 and arg_447_1.var_.characterEffect10030 then
				arg_447_1.var_.characterEffect10030.alpha = 1
			end

			local var_450_13 = 0
			local var_450_14 = 0.325

			if var_450_13 < arg_447_1.time_ and arg_447_1.time_ <= var_450_13 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_15 = arg_447_1:FormatText(StoryNameCfg[309].name)

				arg_447_1.leftNameTxt_.text = var_450_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_16 = arg_447_1:GetWordFromCfg(115261109)
				local var_450_17 = arg_447_1:FormatText(var_450_16.content)

				arg_447_1.text_.text = var_450_17

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_18 = 13
				local var_450_19 = utf8.len(var_450_17)
				local var_450_20 = var_450_18 <= 0 and var_450_14 or var_450_14 * (var_450_19 / var_450_18)

				if var_450_20 > 0 and var_450_14 < var_450_20 then
					arg_447_1.talkMaxDuration = var_450_20

					if var_450_20 + var_450_13 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_20 + var_450_13
					end
				end

				arg_447_1.text_.text = var_450_17
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261109", "story_v_out_115261.awb") ~= 0 then
					local var_450_21 = manager.audio:GetVoiceLength("story_v_out_115261", "115261109", "story_v_out_115261.awb") / 1000

					if var_450_21 + var_450_13 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_21 + var_450_13
					end

					if var_450_16.prefab_name ~= "" and arg_447_1.actors_[var_450_16.prefab_name] ~= nil then
						local var_450_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_16.prefab_name].transform, "story_v_out_115261", "115261109", "story_v_out_115261.awb")

						arg_447_1:RecordAudio("115261109", var_450_22)
						arg_447_1:RecordAudio("115261109", var_450_22)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_115261", "115261109", "story_v_out_115261.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_115261", "115261109", "story_v_out_115261.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_23 = math.max(var_450_14, arg_447_1.talkMaxDuration)

			if var_450_13 <= arg_447_1.time_ and arg_447_1.time_ < var_450_13 + var_450_23 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_13) / var_450_23

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_13 + var_450_23 and arg_447_1.time_ < var_450_13 + var_450_23 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play115261110 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 115261110
		arg_451_1.duration_ = 12.6

		local var_451_0 = {
			ja = 12.6,
			ko = 7.566,
			zh = 9.7,
			en = 9.966
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
				arg_451_0:Play115261111(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["10030"].transform
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 then
				arg_451_1.var_.moveOldPos10030 = var_454_0.localPosition
				var_454_0.localScale = Vector3.New(1, 1, 1)

				arg_451_1:CheckSpriteTmpPos("10030", 3)

				local var_454_2 = var_454_0.childCount

				for iter_454_0 = 0, var_454_2 - 1 do
					local var_454_3 = var_454_0:GetChild(iter_454_0)

					if var_454_3.name == "split_5" or not string.find(var_454_3.name, "split") then
						var_454_3.gameObject:SetActive(true)
					else
						var_454_3.gameObject:SetActive(false)
					end
				end
			end

			local var_454_4 = 0.001

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_4 then
				local var_454_5 = (arg_451_1.time_ - var_454_1) / var_454_4
				local var_454_6 = Vector3.New(0, -390, 150)

				var_454_0.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos10030, var_454_6, var_454_5)
			end

			if arg_451_1.time_ >= var_454_1 + var_454_4 and arg_451_1.time_ < var_454_1 + var_454_4 + arg_454_0 then
				var_454_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_454_7 = 0
			local var_454_8 = 0.7

			if var_454_7 < arg_451_1.time_ and arg_451_1.time_ <= var_454_7 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_9 = arg_451_1:FormatText(StoryNameCfg[309].name)

				arg_451_1.leftNameTxt_.text = var_454_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_10 = arg_451_1:GetWordFromCfg(115261110)
				local var_454_11 = arg_451_1:FormatText(var_454_10.content)

				arg_451_1.text_.text = var_454_11

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_12 = 28
				local var_454_13 = utf8.len(var_454_11)
				local var_454_14 = var_454_12 <= 0 and var_454_8 or var_454_8 * (var_454_13 / var_454_12)

				if var_454_14 > 0 and var_454_8 < var_454_14 then
					arg_451_1.talkMaxDuration = var_454_14

					if var_454_14 + var_454_7 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_14 + var_454_7
					end
				end

				arg_451_1.text_.text = var_454_11
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261110", "story_v_out_115261.awb") ~= 0 then
					local var_454_15 = manager.audio:GetVoiceLength("story_v_out_115261", "115261110", "story_v_out_115261.awb") / 1000

					if var_454_15 + var_454_7 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_15 + var_454_7
					end

					if var_454_10.prefab_name ~= "" and arg_451_1.actors_[var_454_10.prefab_name] ~= nil then
						local var_454_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_10.prefab_name].transform, "story_v_out_115261", "115261110", "story_v_out_115261.awb")

						arg_451_1:RecordAudio("115261110", var_454_16)
						arg_451_1:RecordAudio("115261110", var_454_16)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_115261", "115261110", "story_v_out_115261.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_115261", "115261110", "story_v_out_115261.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_17 = math.max(var_454_8, arg_451_1.talkMaxDuration)

			if var_454_7 <= arg_451_1.time_ and arg_451_1.time_ < var_454_7 + var_454_17 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_7) / var_454_17

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_7 + var_454_17 and arg_451_1.time_ < var_454_7 + var_454_17 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play115261111 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 115261111
		arg_455_1.duration_ = 4.9

		local var_455_0 = {
			ja = 4.9,
			ko = 2.7,
			zh = 4.066,
			en = 3.9
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play115261112(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["10030"].transform
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1.var_.moveOldPos10030 = var_458_0.localPosition
				var_458_0.localScale = Vector3.New(1, 1, 1)

				arg_455_1:CheckSpriteTmpPos("10030", 3)

				local var_458_2 = var_458_0.childCount

				for iter_458_0 = 0, var_458_2 - 1 do
					local var_458_3 = var_458_0:GetChild(iter_458_0)

					if var_458_3.name == "split_3" or not string.find(var_458_3.name, "split") then
						var_458_3.gameObject:SetActive(true)
					else
						var_458_3.gameObject:SetActive(false)
					end
				end
			end

			local var_458_4 = 0.001

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_4 then
				local var_458_5 = (arg_455_1.time_ - var_458_1) / var_458_4
				local var_458_6 = Vector3.New(0, -390, 150)

				var_458_0.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos10030, var_458_6, var_458_5)
			end

			if arg_455_1.time_ >= var_458_1 + var_458_4 and arg_455_1.time_ < var_458_1 + var_458_4 + arg_458_0 then
				var_458_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_458_7 = 0
			local var_458_8 = 0.175

			if var_458_7 < arg_455_1.time_ and arg_455_1.time_ <= var_458_7 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_9 = arg_455_1:FormatText(StoryNameCfg[309].name)

				arg_455_1.leftNameTxt_.text = var_458_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_10 = arg_455_1:GetWordFromCfg(115261111)
				local var_458_11 = arg_455_1:FormatText(var_458_10.content)

				arg_455_1.text_.text = var_458_11

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_12 = 7
				local var_458_13 = utf8.len(var_458_11)
				local var_458_14 = var_458_12 <= 0 and var_458_8 or var_458_8 * (var_458_13 / var_458_12)

				if var_458_14 > 0 and var_458_8 < var_458_14 then
					arg_455_1.talkMaxDuration = var_458_14

					if var_458_14 + var_458_7 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_14 + var_458_7
					end
				end

				arg_455_1.text_.text = var_458_11
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261111", "story_v_out_115261.awb") ~= 0 then
					local var_458_15 = manager.audio:GetVoiceLength("story_v_out_115261", "115261111", "story_v_out_115261.awb") / 1000

					if var_458_15 + var_458_7 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_15 + var_458_7
					end

					if var_458_10.prefab_name ~= "" and arg_455_1.actors_[var_458_10.prefab_name] ~= nil then
						local var_458_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_10.prefab_name].transform, "story_v_out_115261", "115261111", "story_v_out_115261.awb")

						arg_455_1:RecordAudio("115261111", var_458_16)
						arg_455_1:RecordAudio("115261111", var_458_16)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_115261", "115261111", "story_v_out_115261.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_115261", "115261111", "story_v_out_115261.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_17 = math.max(var_458_8, arg_455_1.talkMaxDuration)

			if var_458_7 <= arg_455_1.time_ and arg_455_1.time_ < var_458_7 + var_458_17 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_7) / var_458_17

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_7 + var_458_17 and arg_455_1.time_ < var_458_7 + var_458_17 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play115261112 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 115261112
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play115261113(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = arg_459_1.actors_["10030"]
			local var_462_1 = 0

			if var_462_1 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 then
				local var_462_2 = var_462_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_462_2 then
					arg_459_1.var_.alphaOldValue10030 = var_462_2.alpha
					arg_459_1.var_.characterEffect10030 = var_462_2
				end

				arg_459_1.var_.alphaOldValue10030 = 1
			end

			local var_462_3 = 0.333333333333333

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_3 then
				local var_462_4 = (arg_459_1.time_ - var_462_1) / var_462_3
				local var_462_5 = Mathf.Lerp(arg_459_1.var_.alphaOldValue10030, 0, var_462_4)

				if arg_459_1.var_.characterEffect10030 then
					arg_459_1.var_.characterEffect10030.alpha = var_462_5
				end
			end

			if arg_459_1.time_ >= var_462_1 + var_462_3 and arg_459_1.time_ < var_462_1 + var_462_3 + arg_462_0 and arg_459_1.var_.characterEffect10030 then
				arg_459_1.var_.characterEffect10030.alpha = 0
			end

			local var_462_6 = 0
			local var_462_7 = 0.975

			if var_462_6 < arg_459_1.time_ and arg_459_1.time_ <= var_462_6 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_8 = arg_459_1:GetWordFromCfg(115261112)
				local var_462_9 = arg_459_1:FormatText(var_462_8.content)

				arg_459_1.text_.text = var_462_9

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_10 = 39
				local var_462_11 = utf8.len(var_462_9)
				local var_462_12 = var_462_10 <= 0 and var_462_7 or var_462_7 * (var_462_11 / var_462_10)

				if var_462_12 > 0 and var_462_7 < var_462_12 then
					arg_459_1.talkMaxDuration = var_462_12

					if var_462_12 + var_462_6 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_12 + var_462_6
					end
				end

				arg_459_1.text_.text = var_462_9
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_13 = math.max(var_462_7, arg_459_1.talkMaxDuration)

			if var_462_6 <= arg_459_1.time_ and arg_459_1.time_ < var_462_6 + var_462_13 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_6) / var_462_13

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_6 + var_462_13 and arg_459_1.time_ < var_462_6 + var_462_13 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play115261113 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 115261113
		arg_463_1.duration_ = 3.7

		local var_463_0 = {
			ja = 2.1,
			ko = 1.766,
			zh = 3.7,
			en = 1.1
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play115261114(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = arg_463_1.actors_["10030"].transform
			local var_466_1 = 0

			if var_466_1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 then
				arg_463_1.var_.moveOldPos10030 = var_466_0.localPosition
				var_466_0.localScale = Vector3.New(1, 1, 1)

				arg_463_1:CheckSpriteTmpPos("10030", 3)

				local var_466_2 = var_466_0.childCount

				for iter_466_0 = 0, var_466_2 - 1 do
					local var_466_3 = var_466_0:GetChild(iter_466_0)

					if var_466_3.name == "split_1" or not string.find(var_466_3.name, "split") then
						var_466_3.gameObject:SetActive(true)
					else
						var_466_3.gameObject:SetActive(false)
					end
				end
			end

			local var_466_4 = 0.001

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_4 then
				local var_466_5 = (arg_463_1.time_ - var_466_1) / var_466_4
				local var_466_6 = Vector3.New(0, -390, 150)

				var_466_0.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos10030, var_466_6, var_466_5)
			end

			if arg_463_1.time_ >= var_466_1 + var_466_4 and arg_463_1.time_ < var_466_1 + var_466_4 + arg_466_0 then
				var_466_0.localPosition = Vector3.New(0, -390, 150)
			end

			local var_466_7 = arg_463_1.actors_["10030"]
			local var_466_8 = 0

			if var_466_8 < arg_463_1.time_ and arg_463_1.time_ <= var_466_8 + arg_466_0 and not isNil(var_466_7) and arg_463_1.var_.actorSpriteComps10030 == nil then
				arg_463_1.var_.actorSpriteComps10030 = var_466_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_466_9 = 0.2

			if var_466_8 <= arg_463_1.time_ and arg_463_1.time_ < var_466_8 + var_466_9 and not isNil(var_466_7) then
				local var_466_10 = (arg_463_1.time_ - var_466_8) / var_466_9

				if arg_463_1.var_.actorSpriteComps10030 then
					for iter_466_1, iter_466_2 in pairs(arg_463_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_466_2 then
							if arg_463_1.isInRecall_ then
								local var_466_11 = Mathf.Lerp(iter_466_2.color.r, arg_463_1.hightColor1.r, var_466_10)
								local var_466_12 = Mathf.Lerp(iter_466_2.color.g, arg_463_1.hightColor1.g, var_466_10)
								local var_466_13 = Mathf.Lerp(iter_466_2.color.b, arg_463_1.hightColor1.b, var_466_10)

								iter_466_2.color = Color.New(var_466_11, var_466_12, var_466_13)
							else
								local var_466_14 = Mathf.Lerp(iter_466_2.color.r, 1, var_466_10)

								iter_466_2.color = Color.New(var_466_14, var_466_14, var_466_14)
							end
						end
					end
				end
			end

			if arg_463_1.time_ >= var_466_8 + var_466_9 and arg_463_1.time_ < var_466_8 + var_466_9 + arg_466_0 and not isNil(var_466_7) and arg_463_1.var_.actorSpriteComps10030 then
				for iter_466_3, iter_466_4 in pairs(arg_463_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_466_4 then
						if arg_463_1.isInRecall_ then
							iter_466_4.color = arg_463_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_466_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_463_1.var_.actorSpriteComps10030 = nil
			end

			local var_466_15 = arg_463_1.actors_["10030"]
			local var_466_16 = 0

			if var_466_16 < arg_463_1.time_ and arg_463_1.time_ <= var_466_16 + arg_466_0 then
				local var_466_17 = var_466_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_466_17 then
					arg_463_1.var_.alphaOldValue10030 = var_466_17.alpha
					arg_463_1.var_.characterEffect10030 = var_466_17
				end

				arg_463_1.var_.alphaOldValue10030 = 0
			end

			local var_466_18 = 0.333333333333333

			if var_466_16 <= arg_463_1.time_ and arg_463_1.time_ < var_466_16 + var_466_18 then
				local var_466_19 = (arg_463_1.time_ - var_466_16) / var_466_18
				local var_466_20 = Mathf.Lerp(arg_463_1.var_.alphaOldValue10030, 1, var_466_19)

				if arg_463_1.var_.characterEffect10030 then
					arg_463_1.var_.characterEffect10030.alpha = var_466_20
				end
			end

			if arg_463_1.time_ >= var_466_16 + var_466_18 and arg_463_1.time_ < var_466_16 + var_466_18 + arg_466_0 and arg_463_1.var_.characterEffect10030 then
				arg_463_1.var_.characterEffect10030.alpha = 1
			end

			local var_466_21 = 0
			local var_466_22 = 0.125

			if var_466_21 < arg_463_1.time_ and arg_463_1.time_ <= var_466_21 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_23 = arg_463_1:FormatText(StoryNameCfg[309].name)

				arg_463_1.leftNameTxt_.text = var_466_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_24 = arg_463_1:GetWordFromCfg(115261113)
				local var_466_25 = arg_463_1:FormatText(var_466_24.content)

				arg_463_1.text_.text = var_466_25

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_26 = 5
				local var_466_27 = utf8.len(var_466_25)
				local var_466_28 = var_466_26 <= 0 and var_466_22 or var_466_22 * (var_466_27 / var_466_26)

				if var_466_28 > 0 and var_466_22 < var_466_28 then
					arg_463_1.talkMaxDuration = var_466_28

					if var_466_28 + var_466_21 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_28 + var_466_21
					end
				end

				arg_463_1.text_.text = var_466_25
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261113", "story_v_out_115261.awb") ~= 0 then
					local var_466_29 = manager.audio:GetVoiceLength("story_v_out_115261", "115261113", "story_v_out_115261.awb") / 1000

					if var_466_29 + var_466_21 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_29 + var_466_21
					end

					if var_466_24.prefab_name ~= "" and arg_463_1.actors_[var_466_24.prefab_name] ~= nil then
						local var_466_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_24.prefab_name].transform, "story_v_out_115261", "115261113", "story_v_out_115261.awb")

						arg_463_1:RecordAudio("115261113", var_466_30)
						arg_463_1:RecordAudio("115261113", var_466_30)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_115261", "115261113", "story_v_out_115261.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_115261", "115261113", "story_v_out_115261.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_31 = math.max(var_466_22, arg_463_1.talkMaxDuration)

			if var_466_21 <= arg_463_1.time_ and arg_463_1.time_ < var_466_21 + var_466_31 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_21) / var_466_31

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_21 + var_466_31 and arg_463_1.time_ < var_466_21 + var_466_31 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_463_1:InitPlayNodeList()
	end,
	Play115261114 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 115261114
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play115261115(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = arg_467_1.actors_["10030"]
			local var_470_1 = 0

			if var_470_1 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 then
				local var_470_2 = var_470_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_470_2 then
					arg_467_1.var_.alphaOldValue10030 = var_470_2.alpha
					arg_467_1.var_.characterEffect10030 = var_470_2
				end

				arg_467_1.var_.alphaOldValue10030 = 1
			end

			local var_470_3 = 0.333333333333333

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_3 then
				local var_470_4 = (arg_467_1.time_ - var_470_1) / var_470_3
				local var_470_5 = Mathf.Lerp(arg_467_1.var_.alphaOldValue10030, 0, var_470_4)

				if arg_467_1.var_.characterEffect10030 then
					arg_467_1.var_.characterEffect10030.alpha = var_470_5
				end
			end

			if arg_467_1.time_ >= var_470_1 + var_470_3 and arg_467_1.time_ < var_470_1 + var_470_3 + arg_470_0 and arg_467_1.var_.characterEffect10030 then
				arg_467_1.var_.characterEffect10030.alpha = 0
			end

			local var_470_6 = 0
			local var_470_7 = 0.6

			if var_470_6 < arg_467_1.time_ and arg_467_1.time_ <= var_470_6 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, false)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_8 = arg_467_1:GetWordFromCfg(115261114)
				local var_470_9 = arg_467_1:FormatText(var_470_8.content)

				arg_467_1.text_.text = var_470_9

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_10 = 24
				local var_470_11 = utf8.len(var_470_9)
				local var_470_12 = var_470_10 <= 0 and var_470_7 or var_470_7 * (var_470_11 / var_470_10)

				if var_470_12 > 0 and var_470_7 < var_470_12 then
					arg_467_1.talkMaxDuration = var_470_12

					if var_470_12 + var_470_6 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_12 + var_470_6
					end
				end

				arg_467_1.text_.text = var_470_9
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_13 = math.max(var_470_7, arg_467_1.talkMaxDuration)

			if var_470_6 <= arg_467_1.time_ and arg_467_1.time_ < var_470_6 + var_470_13 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_6) / var_470_13

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_6 + var_470_13 and arg_467_1.time_ < var_470_6 + var_470_13 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play115261115 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 115261115
		arg_471_1.duration_ = 3.87

		local var_471_0 = {
			ja = 3.666,
			ko = 3.866,
			zh = 2.966,
			en = 3.366
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play115261116(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = arg_471_1.actors_["10029"].transform
			local var_474_1 = 0

			if var_474_1 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 then
				arg_471_1.var_.moveOldPos10029 = var_474_0.localPosition
				var_474_0.localScale = Vector3.New(1, 1, 1)

				arg_471_1:CheckSpriteTmpPos("10029", 3)
			end

			local var_474_2 = 0.001

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_2 then
				local var_474_3 = (arg_471_1.time_ - var_474_1) / var_474_2
				local var_474_4 = Vector3.New(0, -350, -180)

				var_474_0.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos10029, var_474_4, var_474_3)
			end

			if arg_471_1.time_ >= var_474_1 + var_474_2 and arg_471_1.time_ < var_474_1 + var_474_2 + arg_474_0 then
				var_474_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_474_5 = arg_471_1.actors_["10029"]
			local var_474_6 = 0

			if var_474_6 < arg_471_1.time_ and arg_471_1.time_ <= var_474_6 + arg_474_0 and not isNil(var_474_5) then
				local var_474_7 = var_474_5:GetComponent("Image")

				if var_474_7 then
					arg_471_1.var_.highlightMatValue10029 = var_474_7
				end
			end

			local var_474_8 = 0.2

			if var_474_6 <= arg_471_1.time_ and arg_471_1.time_ < var_474_6 + var_474_8 and not isNil(var_474_5) then
				local var_474_9 = (arg_471_1.time_ - var_474_6) / var_474_8

				if arg_471_1.var_.highlightMatValue10029 then
					local var_474_10 = Mathf.Lerp(0.5, 1, var_474_9)
					local var_474_11 = arg_471_1.var_.highlightMatValue10029
					local var_474_12 = var_474_11.color

					var_474_12.r = var_474_10
					var_474_12.g = var_474_10
					var_474_12.b = var_474_10
					var_474_11.color = var_474_12
				end
			end

			if arg_471_1.time_ >= var_474_6 + var_474_8 and arg_471_1.time_ < var_474_6 + var_474_8 + arg_474_0 and not isNil(var_474_5) and arg_471_1.var_.highlightMatValue10029 then
				local var_474_13 = 1

				var_474_5.transform:SetSiblingIndex(1)

				local var_474_14 = arg_471_1.var_.highlightMatValue10029
				local var_474_15 = var_474_14.color

				var_474_15.r = var_474_13
				var_474_15.g = var_474_13
				var_474_15.b = var_474_13
				var_474_14.color = var_474_15
			end

			local var_474_16 = arg_471_1.actors_["10029"]
			local var_474_17 = 0

			if var_474_17 < arg_471_1.time_ and arg_471_1.time_ <= var_474_17 + arg_474_0 then
				local var_474_18 = var_474_16:GetComponent("Image")

				if var_474_18 then
					arg_471_1.var_.alphaMatValue10029 = var_474_18
					arg_471_1.var_.alphaOldValue10029 = var_474_18.color.a
				end

				arg_471_1.var_.alphaOldValue10029 = 0
			end

			local var_474_19 = 0.333333333333333

			if var_474_17 <= arg_471_1.time_ and arg_471_1.time_ < var_474_17 + var_474_19 then
				local var_474_20 = (arg_471_1.time_ - var_474_17) / var_474_19
				local var_474_21 = Mathf.Lerp(arg_471_1.var_.alphaOldValue10029, 1, var_474_20)

				if arg_471_1.var_.alphaMatValue10029 then
					local var_474_22 = arg_471_1.var_.alphaMatValue10029.color

					var_474_22.a = var_474_21
					arg_471_1.var_.alphaMatValue10029.color = var_474_22
				end
			end

			if arg_471_1.time_ >= var_474_17 + var_474_19 and arg_471_1.time_ < var_474_17 + var_474_19 + arg_474_0 and arg_471_1.var_.alphaMatValue10029 then
				local var_474_23 = arg_471_1.var_.alphaMatValue10029
				local var_474_24 = var_474_23.color

				var_474_24.a = 1
				var_474_23.color = var_474_24
			end

			local var_474_25 = 0
			local var_474_26 = 0.25

			if var_474_25 < arg_471_1.time_ and arg_471_1.time_ <= var_474_25 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				local var_474_27 = arg_471_1:FormatText(StoryNameCfg[312].name)

				arg_471_1.leftNameTxt_.text = var_474_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_28 = arg_471_1:GetWordFromCfg(115261115)
				local var_474_29 = arg_471_1:FormatText(var_474_28.content)

				arg_471_1.text_.text = var_474_29

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_30 = 10
				local var_474_31 = utf8.len(var_474_29)
				local var_474_32 = var_474_30 <= 0 and var_474_26 or var_474_26 * (var_474_31 / var_474_30)

				if var_474_32 > 0 and var_474_26 < var_474_32 then
					arg_471_1.talkMaxDuration = var_474_32

					if var_474_32 + var_474_25 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_32 + var_474_25
					end
				end

				arg_471_1.text_.text = var_474_29
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261115", "story_v_out_115261.awb") ~= 0 then
					local var_474_33 = manager.audio:GetVoiceLength("story_v_out_115261", "115261115", "story_v_out_115261.awb") / 1000

					if var_474_33 + var_474_25 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_33 + var_474_25
					end

					if var_474_28.prefab_name ~= "" and arg_471_1.actors_[var_474_28.prefab_name] ~= nil then
						local var_474_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_28.prefab_name].transform, "story_v_out_115261", "115261115", "story_v_out_115261.awb")

						arg_471_1:RecordAudio("115261115", var_474_34)
						arg_471_1:RecordAudio("115261115", var_474_34)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_115261", "115261115", "story_v_out_115261.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_115261", "115261115", "story_v_out_115261.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_35 = math.max(var_474_26, arg_471_1.talkMaxDuration)

			if var_474_25 <= arg_471_1.time_ and arg_471_1.time_ < var_474_25 + var_474_35 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_25) / var_474_35

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_25 + var_474_35 and arg_471_1.time_ < var_474_25 + var_474_35 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play115261116 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 115261116
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play115261117(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = arg_475_1.actors_["10029"]
			local var_478_1 = 0

			if var_478_1 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 and not isNil(var_478_0) then
				local var_478_2 = var_478_0:GetComponent("Image")

				if var_478_2 then
					arg_475_1.var_.highlightMatValue10029 = var_478_2
				end
			end

			local var_478_3 = 0.2

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_3 and not isNil(var_478_0) then
				local var_478_4 = (arg_475_1.time_ - var_478_1) / var_478_3

				if arg_475_1.var_.highlightMatValue10029 then
					local var_478_5 = Mathf.Lerp(1, 0.5, var_478_4)
					local var_478_6 = arg_475_1.var_.highlightMatValue10029
					local var_478_7 = var_478_6.color

					var_478_7.r = var_478_5
					var_478_7.g = var_478_5
					var_478_7.b = var_478_5
					var_478_6.color = var_478_7
				end
			end

			if arg_475_1.time_ >= var_478_1 + var_478_3 and arg_475_1.time_ < var_478_1 + var_478_3 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.highlightMatValue10029 then
				local var_478_8 = 0.5
				local var_478_9 = arg_475_1.var_.highlightMatValue10029
				local var_478_10 = var_478_9.color

				var_478_10.r = var_478_8
				var_478_10.g = var_478_8
				var_478_10.b = var_478_8
				var_478_9.color = var_478_10
			end

			local var_478_11 = 0
			local var_478_12 = 0.725

			if var_478_11 < arg_475_1.time_ and arg_475_1.time_ <= var_478_11 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, false)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_13 = arg_475_1:GetWordFromCfg(115261116)
				local var_478_14 = arg_475_1:FormatText(var_478_13.content)

				arg_475_1.text_.text = var_478_14

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_15 = 29
				local var_478_16 = utf8.len(var_478_14)
				local var_478_17 = var_478_15 <= 0 and var_478_12 or var_478_12 * (var_478_16 / var_478_15)

				if var_478_17 > 0 and var_478_12 < var_478_17 then
					arg_475_1.talkMaxDuration = var_478_17

					if var_478_17 + var_478_11 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_17 + var_478_11
					end
				end

				arg_475_1.text_.text = var_478_14
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_18 = math.max(var_478_12, arg_475_1.talkMaxDuration)

			if var_478_11 <= arg_475_1.time_ and arg_475_1.time_ < var_478_11 + var_478_18 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_11) / var_478_18

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_11 + var_478_18 and arg_475_1.time_ < var_478_11 + var_478_18 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play115261117 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 115261117
		arg_479_1.duration_ = 9.4

		local var_479_0 = {
			ja = 5.433,
			ko = 6.733,
			zh = 5.5,
			en = 9.4
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play115261118(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = arg_479_1.actors_["10029"].transform
			local var_482_1 = 0

			if var_482_1 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 then
				arg_479_1.var_.moveOldPos10029 = var_482_0.localPosition
				var_482_0.localScale = Vector3.New(1, 1, 1)

				arg_479_1:CheckSpriteTmpPos("10029", 3)
			end

			local var_482_2 = 0.001

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_2 then
				local var_482_3 = (arg_479_1.time_ - var_482_1) / var_482_2
				local var_482_4 = Vector3.New(0, -350, -180)

				var_482_0.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos10029, var_482_4, var_482_3)
			end

			if arg_479_1.time_ >= var_482_1 + var_482_2 and arg_479_1.time_ < var_482_1 + var_482_2 + arg_482_0 then
				var_482_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_482_5 = arg_479_1.actors_["10029"]
			local var_482_6 = 0

			if var_482_6 < arg_479_1.time_ and arg_479_1.time_ <= var_482_6 + arg_482_0 and not isNil(var_482_5) then
				local var_482_7 = var_482_5:GetComponent("Image")

				if var_482_7 then
					arg_479_1.var_.highlightMatValue10029 = var_482_7
				end
			end

			local var_482_8 = 0.2

			if var_482_6 <= arg_479_1.time_ and arg_479_1.time_ < var_482_6 + var_482_8 and not isNil(var_482_5) then
				local var_482_9 = (arg_479_1.time_ - var_482_6) / var_482_8

				if arg_479_1.var_.highlightMatValue10029 then
					local var_482_10 = Mathf.Lerp(0.5, 1, var_482_9)
					local var_482_11 = arg_479_1.var_.highlightMatValue10029
					local var_482_12 = var_482_11.color

					var_482_12.r = var_482_10
					var_482_12.g = var_482_10
					var_482_12.b = var_482_10
					var_482_11.color = var_482_12
				end
			end

			if arg_479_1.time_ >= var_482_6 + var_482_8 and arg_479_1.time_ < var_482_6 + var_482_8 + arg_482_0 and not isNil(var_482_5) and arg_479_1.var_.highlightMatValue10029 then
				local var_482_13 = 1

				var_482_5.transform:SetSiblingIndex(1)

				local var_482_14 = arg_479_1.var_.highlightMatValue10029
				local var_482_15 = var_482_14.color

				var_482_15.r = var_482_13
				var_482_15.g = var_482_13
				var_482_15.b = var_482_13
				var_482_14.color = var_482_15
			end

			local var_482_16 = 0
			local var_482_17 = 0.65

			if var_482_16 < arg_479_1.time_ and arg_479_1.time_ <= var_482_16 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_18 = arg_479_1:FormatText(StoryNameCfg[312].name)

				arg_479_1.leftNameTxt_.text = var_482_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_19 = arg_479_1:GetWordFromCfg(115261117)
				local var_482_20 = arg_479_1:FormatText(var_482_19.content)

				arg_479_1.text_.text = var_482_20

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_21 = 26
				local var_482_22 = utf8.len(var_482_20)
				local var_482_23 = var_482_21 <= 0 and var_482_17 or var_482_17 * (var_482_22 / var_482_21)

				if var_482_23 > 0 and var_482_17 < var_482_23 then
					arg_479_1.talkMaxDuration = var_482_23

					if var_482_23 + var_482_16 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_23 + var_482_16
					end
				end

				arg_479_1.text_.text = var_482_20
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261117", "story_v_out_115261.awb") ~= 0 then
					local var_482_24 = manager.audio:GetVoiceLength("story_v_out_115261", "115261117", "story_v_out_115261.awb") / 1000

					if var_482_24 + var_482_16 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_24 + var_482_16
					end

					if var_482_19.prefab_name ~= "" and arg_479_1.actors_[var_482_19.prefab_name] ~= nil then
						local var_482_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_19.prefab_name].transform, "story_v_out_115261", "115261117", "story_v_out_115261.awb")

						arg_479_1:RecordAudio("115261117", var_482_25)
						arg_479_1:RecordAudio("115261117", var_482_25)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_115261", "115261117", "story_v_out_115261.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_115261", "115261117", "story_v_out_115261.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_26 = math.max(var_482_17, arg_479_1.talkMaxDuration)

			if var_482_16 <= arg_479_1.time_ and arg_479_1.time_ < var_482_16 + var_482_26 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_16) / var_482_26

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_16 + var_482_26 and arg_479_1.time_ < var_482_16 + var_482_26 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_479_1:InitPlayNodeList()
	end,
	Play115261118 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 115261118
		arg_483_1.duration_ = 6.37

		local var_483_0 = {
			ja = 6.366,
			ko = 4.833,
			zh = 2.266,
			en = 4.133
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
				arg_483_0:Play115261119(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0
			local var_486_1 = 0.325

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				local var_486_2 = arg_483_1:FormatText(StoryNameCfg[312].name)

				arg_483_1.leftNameTxt_.text = var_486_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_3 = arg_483_1:GetWordFromCfg(115261118)
				local var_486_4 = arg_483_1:FormatText(var_486_3.content)

				arg_483_1.text_.text = var_486_4

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261118", "story_v_out_115261.awb") ~= 0 then
					local var_486_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261118", "story_v_out_115261.awb") / 1000

					if var_486_8 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_8 + var_486_0
					end

					if var_486_3.prefab_name ~= "" and arg_483_1.actors_[var_486_3.prefab_name] ~= nil then
						local var_486_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_3.prefab_name].transform, "story_v_out_115261", "115261118", "story_v_out_115261.awb")

						arg_483_1:RecordAudio("115261118", var_486_9)
						arg_483_1:RecordAudio("115261118", var_486_9)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_115261", "115261118", "story_v_out_115261.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_115261", "115261118", "story_v_out_115261.awb")
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
	Play115261119 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 115261119
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play115261120(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = arg_487_1.actors_["10029"].transform
			local var_490_1 = 0.299333333333333

			if var_490_1 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 then
				arg_487_1.var_.moveOldPos10029 = var_490_0.localPosition
				var_490_0.localScale = Vector3.New(1, 1, 1)

				arg_487_1:CheckSpriteTmpPos("10029", 0)
			end

			local var_490_2 = 0.001

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_2 then
				local var_490_3 = (arg_487_1.time_ - var_490_1) / var_490_2
				local var_490_4 = Vector3.New(-1500, -350, -180)

				var_490_0.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos10029, var_490_4, var_490_3)
			end

			if arg_487_1.time_ >= var_490_1 + var_490_2 and arg_487_1.time_ < var_490_1 + var_490_2 + arg_490_0 then
				var_490_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_490_5 = arg_487_1.actors_["10029"]
			local var_490_6 = 0

			if var_490_6 < arg_487_1.time_ and arg_487_1.time_ <= var_490_6 + arg_490_0 then
				local var_490_7 = var_490_5:GetComponent("Image")

				if var_490_7 then
					arg_487_1.var_.alphaMatValue10029 = var_490_7
					arg_487_1.var_.alphaOldValue10029 = var_490_7.color.a
				end

				arg_487_1.var_.alphaOldValue10029 = 1
			end

			local var_490_8 = 0.333333333333333

			if var_490_6 <= arg_487_1.time_ and arg_487_1.time_ < var_490_6 + var_490_8 then
				local var_490_9 = (arg_487_1.time_ - var_490_6) / var_490_8
				local var_490_10 = Mathf.Lerp(arg_487_1.var_.alphaOldValue10029, 0, var_490_9)

				if arg_487_1.var_.alphaMatValue10029 then
					local var_490_11 = arg_487_1.var_.alphaMatValue10029.color

					var_490_11.a = var_490_10
					arg_487_1.var_.alphaMatValue10029.color = var_490_11
				end
			end

			if arg_487_1.time_ >= var_490_6 + var_490_8 and arg_487_1.time_ < var_490_6 + var_490_8 + arg_490_0 and arg_487_1.var_.alphaMatValue10029 then
				local var_490_12 = arg_487_1.var_.alphaMatValue10029
				local var_490_13 = var_490_12.color

				var_490_13.a = 0
				var_490_12.color = var_490_13
			end

			local var_490_14 = 0
			local var_490_15 = 0.575

			if var_490_14 < arg_487_1.time_ and arg_487_1.time_ <= var_490_14 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_16 = arg_487_1:GetWordFromCfg(115261119)
				local var_490_17 = arg_487_1:FormatText(var_490_16.content)

				arg_487_1.text_.text = var_490_17

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_18 = 23
				local var_490_19 = utf8.len(var_490_17)
				local var_490_20 = var_490_18 <= 0 and var_490_15 or var_490_15 * (var_490_19 / var_490_18)

				if var_490_20 > 0 and var_490_15 < var_490_20 then
					arg_487_1.talkMaxDuration = var_490_20

					if var_490_20 + var_490_14 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_20 + var_490_14
					end
				end

				arg_487_1.text_.text = var_490_17
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_21 = math.max(var_490_15, arg_487_1.talkMaxDuration)

			if var_490_14 <= arg_487_1.time_ and arg_487_1.time_ < var_490_14 + var_490_21 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_14) / var_490_21

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_14 + var_490_21 and arg_487_1.time_ < var_490_14 + var_490_21 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.299333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_487_1:InitPlayNodeList()
	end,
	Play115261120 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 115261120
		arg_491_1.duration_ = 4.93

		local var_491_0 = {
			ja = 1.8,
			ko = 2.866,
			zh = 3.1,
			en = 4.933
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play115261121(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = arg_491_1.actors_["10030"].transform
			local var_494_1 = 0

			if var_494_1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 then
				arg_491_1.var_.moveOldPos10030 = var_494_0.localPosition
				var_494_0.localScale = Vector3.New(1, 1, 1)

				arg_491_1:CheckSpriteTmpPos("10030", 4)

				local var_494_2 = var_494_0.childCount

				for iter_494_0 = 0, var_494_2 - 1 do
					local var_494_3 = var_494_0:GetChild(iter_494_0)

					if var_494_3.name == "split_1" or not string.find(var_494_3.name, "split") then
						var_494_3.gameObject:SetActive(true)
					else
						var_494_3.gameObject:SetActive(false)
					end
				end
			end

			local var_494_4 = 0.001

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_4 then
				local var_494_5 = (arg_491_1.time_ - var_494_1) / var_494_4
				local var_494_6 = Vector3.New(390, -390, 150)

				var_494_0.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos10030, var_494_6, var_494_5)
			end

			if arg_491_1.time_ >= var_494_1 + var_494_4 and arg_491_1.time_ < var_494_1 + var_494_4 + arg_494_0 then
				var_494_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_494_7 = arg_491_1.actors_["10030"]
			local var_494_8 = 0

			if var_494_8 < arg_491_1.time_ and arg_491_1.time_ <= var_494_8 + arg_494_0 then
				local var_494_9 = var_494_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_494_9 then
					arg_491_1.var_.alphaOldValue10030 = var_494_9.alpha
					arg_491_1.var_.characterEffect10030 = var_494_9
				end

				arg_491_1.var_.alphaOldValue10030 = 0
			end

			local var_494_10 = 0.333333333333333

			if var_494_8 <= arg_491_1.time_ and arg_491_1.time_ < var_494_8 + var_494_10 then
				local var_494_11 = (arg_491_1.time_ - var_494_8) / var_494_10
				local var_494_12 = Mathf.Lerp(arg_491_1.var_.alphaOldValue10030, 1, var_494_11)

				if arg_491_1.var_.characterEffect10030 then
					arg_491_1.var_.characterEffect10030.alpha = var_494_12
				end
			end

			if arg_491_1.time_ >= var_494_8 + var_494_10 and arg_491_1.time_ < var_494_8 + var_494_10 + arg_494_0 and arg_491_1.var_.characterEffect10030 then
				arg_491_1.var_.characterEffect10030.alpha = 1
			end

			local var_494_13 = arg_491_1.actors_["10029"].transform
			local var_494_14 = 0

			if var_494_14 < arg_491_1.time_ and arg_491_1.time_ <= var_494_14 + arg_494_0 then
				arg_491_1.var_.moveOldPos10029 = var_494_13.localPosition
				var_494_13.localScale = Vector3.New(1, 1, 1)

				arg_491_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_494_15 = 0.001

			if var_494_14 <= arg_491_1.time_ and arg_491_1.time_ < var_494_14 + var_494_15 then
				local var_494_16 = (arg_491_1.time_ - var_494_14) / var_494_15
				local var_494_17 = Vector3.New(-390, -350, -180)

				var_494_13.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos10029, var_494_17, var_494_16)
			end

			if arg_491_1.time_ >= var_494_14 + var_494_15 and arg_491_1.time_ < var_494_14 + var_494_15 + arg_494_0 then
				var_494_13.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_494_18 = arg_491_1.actors_["10029"]
			local var_494_19 = 0

			if var_494_19 < arg_491_1.time_ and arg_491_1.time_ <= var_494_19 + arg_494_0 then
				local var_494_20 = var_494_18:GetComponent("Image")

				if var_494_20 then
					arg_491_1.var_.alphaMatValue10029 = var_494_20
					arg_491_1.var_.alphaOldValue10029 = var_494_20.color.a
				end

				arg_491_1.var_.alphaOldValue10029 = 0
			end

			local var_494_21 = 0.333333333333333

			if var_494_19 <= arg_491_1.time_ and arg_491_1.time_ < var_494_19 + var_494_21 then
				local var_494_22 = (arg_491_1.time_ - var_494_19) / var_494_21
				local var_494_23 = Mathf.Lerp(arg_491_1.var_.alphaOldValue10029, 1, var_494_22)

				if arg_491_1.var_.alphaMatValue10029 then
					local var_494_24 = arg_491_1.var_.alphaMatValue10029.color

					var_494_24.a = var_494_23
					arg_491_1.var_.alphaMatValue10029.color = var_494_24
				end
			end

			if arg_491_1.time_ >= var_494_19 + var_494_21 and arg_491_1.time_ < var_494_19 + var_494_21 + arg_494_0 and arg_491_1.var_.alphaMatValue10029 then
				local var_494_25 = arg_491_1.var_.alphaMatValue10029
				local var_494_26 = var_494_25.color

				var_494_26.a = 1
				var_494_25.color = var_494_26
			end

			local var_494_27 = arg_491_1.actors_["10030"]
			local var_494_28 = 0

			if var_494_28 < arg_491_1.time_ and arg_491_1.time_ <= var_494_28 + arg_494_0 and not isNil(var_494_27) and arg_491_1.var_.actorSpriteComps10030 == nil then
				arg_491_1.var_.actorSpriteComps10030 = var_494_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_29 = 0.2

			if var_494_28 <= arg_491_1.time_ and arg_491_1.time_ < var_494_28 + var_494_29 and not isNil(var_494_27) then
				local var_494_30 = (arg_491_1.time_ - var_494_28) / var_494_29

				if arg_491_1.var_.actorSpriteComps10030 then
					for iter_494_1, iter_494_2 in pairs(arg_491_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_494_2 then
							if arg_491_1.isInRecall_ then
								local var_494_31 = Mathf.Lerp(iter_494_2.color.r, arg_491_1.hightColor1.r, var_494_30)
								local var_494_32 = Mathf.Lerp(iter_494_2.color.g, arg_491_1.hightColor1.g, var_494_30)
								local var_494_33 = Mathf.Lerp(iter_494_2.color.b, arg_491_1.hightColor1.b, var_494_30)

								iter_494_2.color = Color.New(var_494_31, var_494_32, var_494_33)
							else
								local var_494_34 = Mathf.Lerp(iter_494_2.color.r, 1, var_494_30)

								iter_494_2.color = Color.New(var_494_34, var_494_34, var_494_34)
							end
						end
					end
				end
			end

			if arg_491_1.time_ >= var_494_28 + var_494_29 and arg_491_1.time_ < var_494_28 + var_494_29 + arg_494_0 and not isNil(var_494_27) and arg_491_1.var_.actorSpriteComps10030 then
				for iter_494_3, iter_494_4 in pairs(arg_491_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_494_4 then
						if arg_491_1.isInRecall_ then
							iter_494_4.color = arg_491_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_494_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_491_1.var_.actorSpriteComps10030 = nil
			end

			local var_494_35 = arg_491_1.actors_["10029"]
			local var_494_36 = 0

			if var_494_36 < arg_491_1.time_ and arg_491_1.time_ <= var_494_36 + arg_494_0 and not isNil(var_494_35) then
				local var_494_37 = var_494_35:GetComponent("Image")

				if var_494_37 then
					arg_491_1.var_.highlightMatValue10029 = var_494_37
				end
			end

			local var_494_38 = 0.2

			if var_494_36 <= arg_491_1.time_ and arg_491_1.time_ < var_494_36 + var_494_38 and not isNil(var_494_35) then
				local var_494_39 = (arg_491_1.time_ - var_494_36) / var_494_38

				if arg_491_1.var_.highlightMatValue10029 then
					local var_494_40 = Mathf.Lerp(1, 0.5, var_494_39)
					local var_494_41 = arg_491_1.var_.highlightMatValue10029
					local var_494_42 = var_494_41.color

					var_494_42.r = var_494_40
					var_494_42.g = var_494_40
					var_494_42.b = var_494_40
					var_494_41.color = var_494_42
				end
			end

			if arg_491_1.time_ >= var_494_36 + var_494_38 and arg_491_1.time_ < var_494_36 + var_494_38 + arg_494_0 and not isNil(var_494_35) and arg_491_1.var_.highlightMatValue10029 then
				local var_494_43 = 0.5
				local var_494_44 = arg_491_1.var_.highlightMatValue10029
				local var_494_45 = var_494_44.color

				var_494_45.r = var_494_43
				var_494_45.g = var_494_43
				var_494_45.b = var_494_43
				var_494_44.color = var_494_45
			end

			local var_494_46 = 0
			local var_494_47 = 0.225

			if var_494_46 < arg_491_1.time_ and arg_491_1.time_ <= var_494_46 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_48 = arg_491_1:FormatText(StoryNameCfg[309].name)

				arg_491_1.leftNameTxt_.text = var_494_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_49 = arg_491_1:GetWordFromCfg(115261120)
				local var_494_50 = arg_491_1:FormatText(var_494_49.content)

				arg_491_1.text_.text = var_494_50

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_51 = 9
				local var_494_52 = utf8.len(var_494_50)
				local var_494_53 = var_494_51 <= 0 and var_494_47 or var_494_47 * (var_494_52 / var_494_51)

				if var_494_53 > 0 and var_494_47 < var_494_53 then
					arg_491_1.talkMaxDuration = var_494_53

					if var_494_53 + var_494_46 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_53 + var_494_46
					end
				end

				arg_491_1.text_.text = var_494_50
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261120", "story_v_out_115261.awb") ~= 0 then
					local var_494_54 = manager.audio:GetVoiceLength("story_v_out_115261", "115261120", "story_v_out_115261.awb") / 1000

					if var_494_54 + var_494_46 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_54 + var_494_46
					end

					if var_494_49.prefab_name ~= "" and arg_491_1.actors_[var_494_49.prefab_name] ~= nil then
						local var_494_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_49.prefab_name].transform, "story_v_out_115261", "115261120", "story_v_out_115261.awb")

						arg_491_1:RecordAudio("115261120", var_494_55)
						arg_491_1:RecordAudio("115261120", var_494_55)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_115261", "115261120", "story_v_out_115261.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_115261", "115261120", "story_v_out_115261.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_56 = math.max(var_494_47, arg_491_1.talkMaxDuration)

			if var_494_46 <= arg_491_1.time_ and arg_491_1.time_ < var_494_46 + var_494_56 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_46) / var_494_56

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_46 + var_494_56 and arg_491_1.time_ < var_494_46 + var_494_56 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_491_1:InitPlayNodeList()
	end,
	Play115261121 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 115261121
		arg_495_1.duration_ = 12.87

		local var_495_0 = {
			ja = 12.866,
			ko = 12.666,
			zh = 11.5,
			en = 11.833
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play115261122(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = arg_495_1.actors_["10029"].transform
			local var_498_1 = 0

			if var_498_1 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 then
				arg_495_1.var_.moveOldPos10029 = var_498_0.localPosition
				var_498_0.localScale = Vector3.New(1, 1, 1)

				arg_495_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_498_2 = 0.001

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_2 then
				local var_498_3 = (arg_495_1.time_ - var_498_1) / var_498_2
				local var_498_4 = Vector3.New(-390, -350, -180)

				var_498_0.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos10029, var_498_4, var_498_3)
			end

			if arg_495_1.time_ >= var_498_1 + var_498_2 and arg_495_1.time_ < var_498_1 + var_498_2 + arg_498_0 then
				var_498_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_498_5 = arg_495_1.actors_["10030"]
			local var_498_6 = 0

			if var_498_6 < arg_495_1.time_ and arg_495_1.time_ <= var_498_6 + arg_498_0 and not isNil(var_498_5) and arg_495_1.var_.actorSpriteComps10030 == nil then
				arg_495_1.var_.actorSpriteComps10030 = var_498_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_7 = 0.2

			if var_498_6 <= arg_495_1.time_ and arg_495_1.time_ < var_498_6 + var_498_7 and not isNil(var_498_5) then
				local var_498_8 = (arg_495_1.time_ - var_498_6) / var_498_7

				if arg_495_1.var_.actorSpriteComps10030 then
					for iter_498_0, iter_498_1 in pairs(arg_495_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_498_1 then
							if arg_495_1.isInRecall_ then
								local var_498_9 = Mathf.Lerp(iter_498_1.color.r, arg_495_1.hightColor2.r, var_498_8)
								local var_498_10 = Mathf.Lerp(iter_498_1.color.g, arg_495_1.hightColor2.g, var_498_8)
								local var_498_11 = Mathf.Lerp(iter_498_1.color.b, arg_495_1.hightColor2.b, var_498_8)

								iter_498_1.color = Color.New(var_498_9, var_498_10, var_498_11)
							else
								local var_498_12 = Mathf.Lerp(iter_498_1.color.r, 0.5, var_498_8)

								iter_498_1.color = Color.New(var_498_12, var_498_12, var_498_12)
							end
						end
					end
				end
			end

			if arg_495_1.time_ >= var_498_6 + var_498_7 and arg_495_1.time_ < var_498_6 + var_498_7 + arg_498_0 and not isNil(var_498_5) and arg_495_1.var_.actorSpriteComps10030 then
				for iter_498_2, iter_498_3 in pairs(arg_495_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_498_3 then
						if arg_495_1.isInRecall_ then
							iter_498_3.color = arg_495_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_498_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_495_1.var_.actorSpriteComps10030 = nil
			end

			local var_498_13 = arg_495_1.actors_["10029"]
			local var_498_14 = 0

			if var_498_14 < arg_495_1.time_ and arg_495_1.time_ <= var_498_14 + arg_498_0 and not isNil(var_498_13) then
				local var_498_15 = var_498_13:GetComponent("Image")

				if var_498_15 then
					arg_495_1.var_.highlightMatValue10029 = var_498_15
				end
			end

			local var_498_16 = 0.2

			if var_498_14 <= arg_495_1.time_ and arg_495_1.time_ < var_498_14 + var_498_16 and not isNil(var_498_13) then
				local var_498_17 = (arg_495_1.time_ - var_498_14) / var_498_16

				if arg_495_1.var_.highlightMatValue10029 then
					local var_498_18 = Mathf.Lerp(0.5, 1, var_498_17)
					local var_498_19 = arg_495_1.var_.highlightMatValue10029
					local var_498_20 = var_498_19.color

					var_498_20.r = var_498_18
					var_498_20.g = var_498_18
					var_498_20.b = var_498_18
					var_498_19.color = var_498_20
				end
			end

			if arg_495_1.time_ >= var_498_14 + var_498_16 and arg_495_1.time_ < var_498_14 + var_498_16 + arg_498_0 and not isNil(var_498_13) and arg_495_1.var_.highlightMatValue10029 then
				local var_498_21 = 1

				var_498_13.transform:SetSiblingIndex(1)

				local var_498_22 = arg_495_1.var_.highlightMatValue10029
				local var_498_23 = var_498_22.color

				var_498_23.r = var_498_21
				var_498_23.g = var_498_21
				var_498_23.b = var_498_21
				var_498_22.color = var_498_23
			end

			local var_498_24 = 0
			local var_498_25 = 1.1

			if var_498_24 < arg_495_1.time_ and arg_495_1.time_ <= var_498_24 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_26 = arg_495_1:FormatText(StoryNameCfg[312].name)

				arg_495_1.leftNameTxt_.text = var_498_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_27 = arg_495_1:GetWordFromCfg(115261121)
				local var_498_28 = arg_495_1:FormatText(var_498_27.content)

				arg_495_1.text_.text = var_498_28

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_29 = 44
				local var_498_30 = utf8.len(var_498_28)
				local var_498_31 = var_498_29 <= 0 and var_498_25 or var_498_25 * (var_498_30 / var_498_29)

				if var_498_31 > 0 and var_498_25 < var_498_31 then
					arg_495_1.talkMaxDuration = var_498_31

					if var_498_31 + var_498_24 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_31 + var_498_24
					end
				end

				arg_495_1.text_.text = var_498_28
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261121", "story_v_out_115261.awb") ~= 0 then
					local var_498_32 = manager.audio:GetVoiceLength("story_v_out_115261", "115261121", "story_v_out_115261.awb") / 1000

					if var_498_32 + var_498_24 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_32 + var_498_24
					end

					if var_498_27.prefab_name ~= "" and arg_495_1.actors_[var_498_27.prefab_name] ~= nil then
						local var_498_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_27.prefab_name].transform, "story_v_out_115261", "115261121", "story_v_out_115261.awb")

						arg_495_1:RecordAudio("115261121", var_498_33)
						arg_495_1:RecordAudio("115261121", var_498_33)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_115261", "115261121", "story_v_out_115261.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_115261", "115261121", "story_v_out_115261.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_34 = math.max(var_498_25, arg_495_1.talkMaxDuration)

			if var_498_24 <= arg_495_1.time_ and arg_495_1.time_ < var_498_24 + var_498_34 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_24) / var_498_34

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_24 + var_498_34 and arg_495_1.time_ < var_498_24 + var_498_34 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_495_1:InitPlayNodeList()
	end,
	Play115261122 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 115261122
		arg_499_1.duration_ = 18.47

		local var_499_0 = {
			ja = 14.4,
			ko = 14.133,
			zh = 13.2,
			en = 18.466
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play115261123(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0
			local var_502_1 = 1.375

			if var_502_0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_2 = arg_499_1:FormatText(StoryNameCfg[312].name)

				arg_499_1.leftNameTxt_.text = var_502_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_3 = arg_499_1:GetWordFromCfg(115261122)
				local var_502_4 = arg_499_1:FormatText(var_502_3.content)

				arg_499_1.text_.text = var_502_4

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_5 = 54
				local var_502_6 = utf8.len(var_502_4)
				local var_502_7 = var_502_5 <= 0 and var_502_1 or var_502_1 * (var_502_6 / var_502_5)

				if var_502_7 > 0 and var_502_1 < var_502_7 then
					arg_499_1.talkMaxDuration = var_502_7

					if var_502_7 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_7 + var_502_0
					end
				end

				arg_499_1.text_.text = var_502_4
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261122", "story_v_out_115261.awb") ~= 0 then
					local var_502_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261122", "story_v_out_115261.awb") / 1000

					if var_502_8 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_8 + var_502_0
					end

					if var_502_3.prefab_name ~= "" and arg_499_1.actors_[var_502_3.prefab_name] ~= nil then
						local var_502_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_3.prefab_name].transform, "story_v_out_115261", "115261122", "story_v_out_115261.awb")

						arg_499_1:RecordAudio("115261122", var_502_9)
						arg_499_1:RecordAudio("115261122", var_502_9)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_115261", "115261122", "story_v_out_115261.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_115261", "115261122", "story_v_out_115261.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_10 = math.max(var_502_1, arg_499_1.talkMaxDuration)

			if var_502_0 <= arg_499_1.time_ and arg_499_1.time_ < var_502_0 + var_502_10 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_0) / var_502_10

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_0 + var_502_10 and arg_499_1.time_ < var_502_0 + var_502_10 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play115261123 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 115261123
		arg_503_1.duration_ = 13.4

		local var_503_0 = {
			ja = 9.133,
			ko = 9.1,
			zh = 9.4,
			en = 13.4
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play115261124(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0
			local var_506_1 = 0.975

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_2 = arg_503_1:FormatText(StoryNameCfg[312].name)

				arg_503_1.leftNameTxt_.text = var_506_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_3 = arg_503_1:GetWordFromCfg(115261123)
				local var_506_4 = arg_503_1:FormatText(var_506_3.content)

				arg_503_1.text_.text = var_506_4

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_5 = 38
				local var_506_6 = utf8.len(var_506_4)
				local var_506_7 = var_506_5 <= 0 and var_506_1 or var_506_1 * (var_506_6 / var_506_5)

				if var_506_7 > 0 and var_506_1 < var_506_7 then
					arg_503_1.talkMaxDuration = var_506_7

					if var_506_7 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_7 + var_506_0
					end
				end

				arg_503_1.text_.text = var_506_4
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261123", "story_v_out_115261.awb") ~= 0 then
					local var_506_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261123", "story_v_out_115261.awb") / 1000

					if var_506_8 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_8 + var_506_0
					end

					if var_506_3.prefab_name ~= "" and arg_503_1.actors_[var_506_3.prefab_name] ~= nil then
						local var_506_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_3.prefab_name].transform, "story_v_out_115261", "115261123", "story_v_out_115261.awb")

						arg_503_1:RecordAudio("115261123", var_506_9)
						arg_503_1:RecordAudio("115261123", var_506_9)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_115261", "115261123", "story_v_out_115261.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_115261", "115261123", "story_v_out_115261.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_10 = math.max(var_506_1, arg_503_1.talkMaxDuration)

			if var_506_0 <= arg_503_1.time_ and arg_503_1.time_ < var_506_0 + var_506_10 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_0) / var_506_10

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_0 + var_506_10 and arg_503_1.time_ < var_506_0 + var_506_10 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play115261124 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 115261124
		arg_507_1.duration_ = 11.7

		local var_507_0 = {
			ja = 11.133,
			ko = 9.566,
			zh = 9.9,
			en = 11.7
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play115261125(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0
			local var_510_1 = 0.95

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_2 = arg_507_1:FormatText(StoryNameCfg[312].name)

				arg_507_1.leftNameTxt_.text = var_510_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_3 = arg_507_1:GetWordFromCfg(115261124)
				local var_510_4 = arg_507_1:FormatText(var_510_3.content)

				arg_507_1.text_.text = var_510_4

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 38
				local var_510_6 = utf8.len(var_510_4)
				local var_510_7 = var_510_5 <= 0 and var_510_1 or var_510_1 * (var_510_6 / var_510_5)

				if var_510_7 > 0 and var_510_1 < var_510_7 then
					arg_507_1.talkMaxDuration = var_510_7

					if var_510_7 + var_510_0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_7 + var_510_0
					end
				end

				arg_507_1.text_.text = var_510_4
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261124", "story_v_out_115261.awb") ~= 0 then
					local var_510_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261124", "story_v_out_115261.awb") / 1000

					if var_510_8 + var_510_0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_8 + var_510_0
					end

					if var_510_3.prefab_name ~= "" and arg_507_1.actors_[var_510_3.prefab_name] ~= nil then
						local var_510_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_3.prefab_name].transform, "story_v_out_115261", "115261124", "story_v_out_115261.awb")

						arg_507_1:RecordAudio("115261124", var_510_9)
						arg_507_1:RecordAudio("115261124", var_510_9)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_115261", "115261124", "story_v_out_115261.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_115261", "115261124", "story_v_out_115261.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_10 = math.max(var_510_1, arg_507_1.talkMaxDuration)

			if var_510_0 <= arg_507_1.time_ and arg_507_1.time_ < var_510_0 + var_510_10 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_0) / var_510_10

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_0 + var_510_10 and arg_507_1.time_ < var_510_0 + var_510_10 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play115261125 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 115261125
		arg_511_1.duration_ = 4.77

		local var_511_0 = {
			ja = 1.9,
			ko = 3.8,
			zh = 4.3,
			en = 4.766
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play115261126(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["10030"].transform
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.var_.moveOldPos10030 = var_514_0.localPosition
				var_514_0.localScale = Vector3.New(1, 1, 1)

				arg_511_1:CheckSpriteTmpPos("10030", 4)

				local var_514_2 = var_514_0.childCount

				for iter_514_0 = 0, var_514_2 - 1 do
					local var_514_3 = var_514_0:GetChild(iter_514_0)

					if var_514_3.name == "split_3" or not string.find(var_514_3.name, "split") then
						var_514_3.gameObject:SetActive(true)
					else
						var_514_3.gameObject:SetActive(false)
					end
				end
			end

			local var_514_4 = 0.001

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_4 then
				local var_514_5 = (arg_511_1.time_ - var_514_1) / var_514_4
				local var_514_6 = Vector3.New(390, -390, 150)

				var_514_0.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos10030, var_514_6, var_514_5)
			end

			if arg_511_1.time_ >= var_514_1 + var_514_4 and arg_511_1.time_ < var_514_1 + var_514_4 + arg_514_0 then
				var_514_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_514_7 = arg_511_1.actors_["10029"]
			local var_514_8 = 0

			if var_514_8 < arg_511_1.time_ and arg_511_1.time_ <= var_514_8 + arg_514_0 and not isNil(var_514_7) then
				local var_514_9 = var_514_7:GetComponent("Image")

				if var_514_9 then
					arg_511_1.var_.highlightMatValue10029 = var_514_9
				end
			end

			local var_514_10 = 0.2

			if var_514_8 <= arg_511_1.time_ and arg_511_1.time_ < var_514_8 + var_514_10 and not isNil(var_514_7) then
				local var_514_11 = (arg_511_1.time_ - var_514_8) / var_514_10

				if arg_511_1.var_.highlightMatValue10029 then
					local var_514_12 = Mathf.Lerp(1, 0.5, var_514_11)
					local var_514_13 = arg_511_1.var_.highlightMatValue10029
					local var_514_14 = var_514_13.color

					var_514_14.r = var_514_12
					var_514_14.g = var_514_12
					var_514_14.b = var_514_12
					var_514_13.color = var_514_14
				end
			end

			if arg_511_1.time_ >= var_514_8 + var_514_10 and arg_511_1.time_ < var_514_8 + var_514_10 + arg_514_0 and not isNil(var_514_7) and arg_511_1.var_.highlightMatValue10029 then
				local var_514_15 = 0.5
				local var_514_16 = arg_511_1.var_.highlightMatValue10029
				local var_514_17 = var_514_16.color

				var_514_17.r = var_514_15
				var_514_17.g = var_514_15
				var_514_17.b = var_514_15
				var_514_16.color = var_514_17
			end

			local var_514_18 = arg_511_1.actors_["10030"]
			local var_514_19 = 0

			if var_514_19 < arg_511_1.time_ and arg_511_1.time_ <= var_514_19 + arg_514_0 then
				local var_514_20 = var_514_18:GetComponentInChildren(typeof(CanvasGroup))

				if var_514_20 then
					arg_511_1.var_.alphaOldValue10030 = var_514_20.alpha
					arg_511_1.var_.characterEffect10030 = var_514_20
				end

				arg_511_1.var_.alphaOldValue10030 = 0
			end

			local var_514_21 = 0.0166666666666667

			if var_514_19 <= arg_511_1.time_ and arg_511_1.time_ < var_514_19 + var_514_21 then
				local var_514_22 = (arg_511_1.time_ - var_514_19) / var_514_21
				local var_514_23 = Mathf.Lerp(arg_511_1.var_.alphaOldValue10030, 1, var_514_22)

				if arg_511_1.var_.characterEffect10030 then
					arg_511_1.var_.characterEffect10030.alpha = var_514_23
				end
			end

			if arg_511_1.time_ >= var_514_19 + var_514_21 and arg_511_1.time_ < var_514_19 + var_514_21 + arg_514_0 and arg_511_1.var_.characterEffect10030 then
				arg_511_1.var_.characterEffect10030.alpha = 1
			end

			local var_514_24 = 0
			local var_514_25 = 0.25

			if var_514_24 < arg_511_1.time_ and arg_511_1.time_ <= var_514_24 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_26 = arg_511_1:FormatText(StoryNameCfg[309].name)

				arg_511_1.leftNameTxt_.text = var_514_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_27 = arg_511_1:GetWordFromCfg(115261125)
				local var_514_28 = arg_511_1:FormatText(var_514_27.content)

				arg_511_1.text_.text = var_514_28

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_29 = 10
				local var_514_30 = utf8.len(var_514_28)
				local var_514_31 = var_514_29 <= 0 and var_514_25 or var_514_25 * (var_514_30 / var_514_29)

				if var_514_31 > 0 and var_514_25 < var_514_31 then
					arg_511_1.talkMaxDuration = var_514_31

					if var_514_31 + var_514_24 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_31 + var_514_24
					end
				end

				arg_511_1.text_.text = var_514_28
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261125", "story_v_out_115261.awb") ~= 0 then
					local var_514_32 = manager.audio:GetVoiceLength("story_v_out_115261", "115261125", "story_v_out_115261.awb") / 1000

					if var_514_32 + var_514_24 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_32 + var_514_24
					end

					if var_514_27.prefab_name ~= "" and arg_511_1.actors_[var_514_27.prefab_name] ~= nil then
						local var_514_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_27.prefab_name].transform, "story_v_out_115261", "115261125", "story_v_out_115261.awb")

						arg_511_1:RecordAudio("115261125", var_514_33)
						arg_511_1:RecordAudio("115261125", var_514_33)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_115261", "115261125", "story_v_out_115261.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_115261", "115261125", "story_v_out_115261.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_34 = math.max(var_514_25, arg_511_1.talkMaxDuration)

			if var_514_24 <= arg_511_1.time_ and arg_511_1.time_ < var_514_24 + var_514_34 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_24) / var_514_34

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_24 + var_514_34 and arg_511_1.time_ < var_514_24 + var_514_34 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play115261126 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 115261126
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play115261127(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["10030"]
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 then
				local var_518_2 = var_518_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_518_2 then
					arg_515_1.var_.alphaOldValue10030 = var_518_2.alpha
					arg_515_1.var_.characterEffect10030 = var_518_2
				end

				arg_515_1.var_.alphaOldValue10030 = 1
			end

			local var_518_3 = 0.333333333333333

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_3 then
				local var_518_4 = (arg_515_1.time_ - var_518_1) / var_518_3
				local var_518_5 = Mathf.Lerp(arg_515_1.var_.alphaOldValue10030, 0, var_518_4)

				if arg_515_1.var_.characterEffect10030 then
					arg_515_1.var_.characterEffect10030.alpha = var_518_5
				end
			end

			if arg_515_1.time_ >= var_518_1 + var_518_3 and arg_515_1.time_ < var_518_1 + var_518_3 + arg_518_0 and arg_515_1.var_.characterEffect10030 then
				arg_515_1.var_.characterEffect10030.alpha = 0
			end

			local var_518_6 = arg_515_1.actors_["10029"]
			local var_518_7 = 0

			if var_518_7 < arg_515_1.time_ and arg_515_1.time_ <= var_518_7 + arg_518_0 then
				local var_518_8 = var_518_6:GetComponent("Image")

				if var_518_8 then
					arg_515_1.var_.alphaMatValue10029 = var_518_8
					arg_515_1.var_.alphaOldValue10029 = var_518_8.color.a
				end

				arg_515_1.var_.alphaOldValue10029 = 1
			end

			local var_518_9 = 0.333333333333333

			if var_518_7 <= arg_515_1.time_ and arg_515_1.time_ < var_518_7 + var_518_9 then
				local var_518_10 = (arg_515_1.time_ - var_518_7) / var_518_9
				local var_518_11 = Mathf.Lerp(arg_515_1.var_.alphaOldValue10029, 0, var_518_10)

				if arg_515_1.var_.alphaMatValue10029 then
					local var_518_12 = arg_515_1.var_.alphaMatValue10029.color

					var_518_12.a = var_518_11
					arg_515_1.var_.alphaMatValue10029.color = var_518_12
				end
			end

			if arg_515_1.time_ >= var_518_7 + var_518_9 and arg_515_1.time_ < var_518_7 + var_518_9 + arg_518_0 and arg_515_1.var_.alphaMatValue10029 then
				local var_518_13 = arg_515_1.var_.alphaMatValue10029
				local var_518_14 = var_518_13.color

				var_518_14.a = 0
				var_518_13.color = var_518_14
			end

			local var_518_15 = 0
			local var_518_16 = 1.325

			if var_518_15 < arg_515_1.time_ and arg_515_1.time_ <= var_518_15 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, false)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_17 = arg_515_1:GetWordFromCfg(115261126)
				local var_518_18 = arg_515_1:FormatText(var_518_17.content)

				arg_515_1.text_.text = var_518_18

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_19 = 53
				local var_518_20 = utf8.len(var_518_18)
				local var_518_21 = var_518_19 <= 0 and var_518_16 or var_518_16 * (var_518_20 / var_518_19)

				if var_518_21 > 0 and var_518_16 < var_518_21 then
					arg_515_1.talkMaxDuration = var_518_21

					if var_518_21 + var_518_15 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_21 + var_518_15
					end
				end

				arg_515_1.text_.text = var_518_18
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_22 = math.max(var_518_16, arg_515_1.talkMaxDuration)

			if var_518_15 <= arg_515_1.time_ and arg_515_1.time_ < var_518_15 + var_518_22 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_15) / var_518_22

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_15 + var_518_22 and arg_515_1.time_ < var_518_15 + var_518_22 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play115261127 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 115261127
		arg_519_1.duration_ = 6.53

		local var_519_0 = {
			ja = 5.533,
			ko = 4.9,
			zh = 3.4,
			en = 6.533
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play115261128(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = arg_519_1.actors_["10029"].transform
			local var_522_1 = 0

			if var_522_1 < arg_519_1.time_ and arg_519_1.time_ <= var_522_1 + arg_522_0 then
				arg_519_1.var_.moveOldPos10029 = var_522_0.localPosition
				var_522_0.localScale = Vector3.New(1, 1, 1)

				arg_519_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_522_2 = 0.001

			if var_522_1 <= arg_519_1.time_ and arg_519_1.time_ < var_522_1 + var_522_2 then
				local var_522_3 = (arg_519_1.time_ - var_522_1) / var_522_2
				local var_522_4 = Vector3.New(-390, -350, -180)

				var_522_0.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10029, var_522_4, var_522_3)
			end

			if arg_519_1.time_ >= var_522_1 + var_522_2 and arg_519_1.time_ < var_522_1 + var_522_2 + arg_522_0 then
				var_522_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_522_5 = arg_519_1.actors_["10029"]
			local var_522_6 = 0

			if var_522_6 < arg_519_1.time_ and arg_519_1.time_ <= var_522_6 + arg_522_0 and not isNil(var_522_5) then
				local var_522_7 = var_522_5:GetComponent("Image")

				if var_522_7 then
					arg_519_1.var_.highlightMatValue10029 = var_522_7
				end
			end

			local var_522_8 = 0.2

			if var_522_6 <= arg_519_1.time_ and arg_519_1.time_ < var_522_6 + var_522_8 and not isNil(var_522_5) then
				local var_522_9 = (arg_519_1.time_ - var_522_6) / var_522_8

				if arg_519_1.var_.highlightMatValue10029 then
					local var_522_10 = Mathf.Lerp(0.5, 1, var_522_9)
					local var_522_11 = arg_519_1.var_.highlightMatValue10029
					local var_522_12 = var_522_11.color

					var_522_12.r = var_522_10
					var_522_12.g = var_522_10
					var_522_12.b = var_522_10
					var_522_11.color = var_522_12
				end
			end

			if arg_519_1.time_ >= var_522_6 + var_522_8 and arg_519_1.time_ < var_522_6 + var_522_8 + arg_522_0 and not isNil(var_522_5) and arg_519_1.var_.highlightMatValue10029 then
				local var_522_13 = 1

				var_522_5.transform:SetSiblingIndex(1)

				local var_522_14 = arg_519_1.var_.highlightMatValue10029
				local var_522_15 = var_522_14.color

				var_522_15.r = var_522_13
				var_522_15.g = var_522_13
				var_522_15.b = var_522_13
				var_522_14.color = var_522_15
			end

			local var_522_16 = arg_519_1.actors_["10030"].transform
			local var_522_17 = 0

			if var_522_17 < arg_519_1.time_ and arg_519_1.time_ <= var_522_17 + arg_522_0 then
				arg_519_1.var_.moveOldPos10030 = var_522_16.localPosition
				var_522_16.localScale = Vector3.New(1, 1, 1)

				arg_519_1:CheckSpriteTmpPos("10030", 4)

				local var_522_18 = var_522_16.childCount

				for iter_522_0 = 0, var_522_18 - 1 do
					local var_522_19 = var_522_16:GetChild(iter_522_0)

					if var_522_19.name == "split_3" or not string.find(var_522_19.name, "split") then
						var_522_19.gameObject:SetActive(true)
					else
						var_522_19.gameObject:SetActive(false)
					end
				end
			end

			local var_522_20 = 0.001

			if var_522_17 <= arg_519_1.time_ and arg_519_1.time_ < var_522_17 + var_522_20 then
				local var_522_21 = (arg_519_1.time_ - var_522_17) / var_522_20
				local var_522_22 = Vector3.New(390, -390, 150)

				var_522_16.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10030, var_522_22, var_522_21)
			end

			if arg_519_1.time_ >= var_522_17 + var_522_20 and arg_519_1.time_ < var_522_17 + var_522_20 + arg_522_0 then
				var_522_16.localPosition = Vector3.New(390, -390, 150)
			end

			local var_522_23 = arg_519_1.actors_["10030"]
			local var_522_24 = 0

			if var_522_24 < arg_519_1.time_ and arg_519_1.time_ <= var_522_24 + arg_522_0 and not isNil(var_522_23) and arg_519_1.var_.actorSpriteComps10030 == nil then
				arg_519_1.var_.actorSpriteComps10030 = var_522_23:GetComponentsInChildren(typeof(Image), true)
			end

			local var_522_25 = 0.2

			if var_522_24 <= arg_519_1.time_ and arg_519_1.time_ < var_522_24 + var_522_25 and not isNil(var_522_23) then
				local var_522_26 = (arg_519_1.time_ - var_522_24) / var_522_25

				if arg_519_1.var_.actorSpriteComps10030 then
					for iter_522_1, iter_522_2 in pairs(arg_519_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_522_2 then
							if arg_519_1.isInRecall_ then
								local var_522_27 = Mathf.Lerp(iter_522_2.color.r, arg_519_1.hightColor2.r, var_522_26)
								local var_522_28 = Mathf.Lerp(iter_522_2.color.g, arg_519_1.hightColor2.g, var_522_26)
								local var_522_29 = Mathf.Lerp(iter_522_2.color.b, arg_519_1.hightColor2.b, var_522_26)

								iter_522_2.color = Color.New(var_522_27, var_522_28, var_522_29)
							else
								local var_522_30 = Mathf.Lerp(iter_522_2.color.r, 0.5, var_522_26)

								iter_522_2.color = Color.New(var_522_30, var_522_30, var_522_30)
							end
						end
					end
				end
			end

			if arg_519_1.time_ >= var_522_24 + var_522_25 and arg_519_1.time_ < var_522_24 + var_522_25 + arg_522_0 and not isNil(var_522_23) and arg_519_1.var_.actorSpriteComps10030 then
				for iter_522_3, iter_522_4 in pairs(arg_519_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_522_4 then
						if arg_519_1.isInRecall_ then
							iter_522_4.color = arg_519_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_522_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_519_1.var_.actorSpriteComps10030 = nil
			end

			local var_522_31 = arg_519_1.actors_["10030"]
			local var_522_32 = 0

			if var_522_32 < arg_519_1.time_ and arg_519_1.time_ <= var_522_32 + arg_522_0 then
				local var_522_33 = var_522_31:GetComponentInChildren(typeof(CanvasGroup))

				if var_522_33 then
					arg_519_1.var_.alphaOldValue10030 = var_522_33.alpha
					arg_519_1.var_.characterEffect10030 = var_522_33
				end

				arg_519_1.var_.alphaOldValue10030 = 0
			end

			local var_522_34 = 0.333333333333333

			if var_522_32 <= arg_519_1.time_ and arg_519_1.time_ < var_522_32 + var_522_34 then
				local var_522_35 = (arg_519_1.time_ - var_522_32) / var_522_34
				local var_522_36 = Mathf.Lerp(arg_519_1.var_.alphaOldValue10030, 1, var_522_35)

				if arg_519_1.var_.characterEffect10030 then
					arg_519_1.var_.characterEffect10030.alpha = var_522_36
				end
			end

			if arg_519_1.time_ >= var_522_32 + var_522_34 and arg_519_1.time_ < var_522_32 + var_522_34 + arg_522_0 and arg_519_1.var_.characterEffect10030 then
				arg_519_1.var_.characterEffect10030.alpha = 1
			end

			local var_522_37 = arg_519_1.actors_["10029"]
			local var_522_38 = 0

			if var_522_38 < arg_519_1.time_ and arg_519_1.time_ <= var_522_38 + arg_522_0 then
				local var_522_39 = var_522_37:GetComponent("Image")

				if var_522_39 then
					arg_519_1.var_.alphaMatValue10029 = var_522_39
					arg_519_1.var_.alphaOldValue10029 = var_522_39.color.a
				end

				arg_519_1.var_.alphaOldValue10029 = 0
			end

			local var_522_40 = 0.333333333333333

			if var_522_38 <= arg_519_1.time_ and arg_519_1.time_ < var_522_38 + var_522_40 then
				local var_522_41 = (arg_519_1.time_ - var_522_38) / var_522_40
				local var_522_42 = Mathf.Lerp(arg_519_1.var_.alphaOldValue10029, 1, var_522_41)

				if arg_519_1.var_.alphaMatValue10029 then
					local var_522_43 = arg_519_1.var_.alphaMatValue10029.color

					var_522_43.a = var_522_42
					arg_519_1.var_.alphaMatValue10029.color = var_522_43
				end
			end

			if arg_519_1.time_ >= var_522_38 + var_522_40 and arg_519_1.time_ < var_522_38 + var_522_40 + arg_522_0 and arg_519_1.var_.alphaMatValue10029 then
				local var_522_44 = arg_519_1.var_.alphaMatValue10029
				local var_522_45 = var_522_44.color

				var_522_45.a = 1
				var_522_44.color = var_522_45
			end

			local var_522_46 = 0
			local var_522_47 = 0.325

			if var_522_46 < arg_519_1.time_ and arg_519_1.time_ <= var_522_46 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_48 = arg_519_1:FormatText(StoryNameCfg[312].name)

				arg_519_1.leftNameTxt_.text = var_522_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_49 = arg_519_1:GetWordFromCfg(115261127)
				local var_522_50 = arg_519_1:FormatText(var_522_49.content)

				arg_519_1.text_.text = var_522_50

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_51 = 13
				local var_522_52 = utf8.len(var_522_50)
				local var_522_53 = var_522_51 <= 0 and var_522_47 or var_522_47 * (var_522_52 / var_522_51)

				if var_522_53 > 0 and var_522_47 < var_522_53 then
					arg_519_1.talkMaxDuration = var_522_53

					if var_522_53 + var_522_46 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_53 + var_522_46
					end
				end

				arg_519_1.text_.text = var_522_50
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261127", "story_v_out_115261.awb") ~= 0 then
					local var_522_54 = manager.audio:GetVoiceLength("story_v_out_115261", "115261127", "story_v_out_115261.awb") / 1000

					if var_522_54 + var_522_46 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_54 + var_522_46
					end

					if var_522_49.prefab_name ~= "" and arg_519_1.actors_[var_522_49.prefab_name] ~= nil then
						local var_522_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_49.prefab_name].transform, "story_v_out_115261", "115261127", "story_v_out_115261.awb")

						arg_519_1:RecordAudio("115261127", var_522_55)
						arg_519_1:RecordAudio("115261127", var_522_55)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_115261", "115261127", "story_v_out_115261.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_115261", "115261127", "story_v_out_115261.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_56 = math.max(var_522_47, arg_519_1.talkMaxDuration)

			if var_522_46 <= arg_519_1.time_ and arg_519_1.time_ < var_522_46 + var_522_56 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_46) / var_522_56

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_46 + var_522_56 and arg_519_1.time_ < var_522_46 + var_522_56 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play115261128 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 115261128
		arg_523_1.duration_ = 11.2

		local var_523_0 = {
			ja = 9.833,
			ko = 9.133,
			zh = 9.6,
			en = 11.2
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play115261129(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0
			local var_526_1 = 1

			if var_526_0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_2 = arg_523_1:FormatText(StoryNameCfg[312].name)

				arg_523_1.leftNameTxt_.text = var_526_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_3 = arg_523_1:GetWordFromCfg(115261128)
				local var_526_4 = arg_523_1:FormatText(var_526_3.content)

				arg_523_1.text_.text = var_526_4

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 40
				local var_526_6 = utf8.len(var_526_4)
				local var_526_7 = var_526_5 <= 0 and var_526_1 or var_526_1 * (var_526_6 / var_526_5)

				if var_526_7 > 0 and var_526_1 < var_526_7 then
					arg_523_1.talkMaxDuration = var_526_7

					if var_526_7 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_7 + var_526_0
					end
				end

				arg_523_1.text_.text = var_526_4
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261128", "story_v_out_115261.awb") ~= 0 then
					local var_526_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261128", "story_v_out_115261.awb") / 1000

					if var_526_8 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_8 + var_526_0
					end

					if var_526_3.prefab_name ~= "" and arg_523_1.actors_[var_526_3.prefab_name] ~= nil then
						local var_526_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_3.prefab_name].transform, "story_v_out_115261", "115261128", "story_v_out_115261.awb")

						arg_523_1:RecordAudio("115261128", var_526_9)
						arg_523_1:RecordAudio("115261128", var_526_9)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_115261", "115261128", "story_v_out_115261.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_115261", "115261128", "story_v_out_115261.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_10 = math.max(var_526_1, arg_523_1.talkMaxDuration)

			if var_526_0 <= arg_523_1.time_ and arg_523_1.time_ < var_526_0 + var_526_10 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_0) / var_526_10

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_0 + var_526_10 and arg_523_1.time_ < var_526_0 + var_526_10 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play115261129 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 115261129
		arg_527_1.duration_ = 3.37

		local var_527_0 = {
			ja = 3.3,
			ko = 3.033,
			zh = 3.366,
			en = 2
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play115261130(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = arg_527_1.actors_["10030"]
			local var_530_1 = 0

			if var_530_1 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 and not isNil(var_530_0) and arg_527_1.var_.actorSpriteComps10030 == nil then
				arg_527_1.var_.actorSpriteComps10030 = var_530_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_530_2 = 0.2

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_2 and not isNil(var_530_0) then
				local var_530_3 = (arg_527_1.time_ - var_530_1) / var_530_2

				if arg_527_1.var_.actorSpriteComps10030 then
					for iter_530_0, iter_530_1 in pairs(arg_527_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_530_1 then
							if arg_527_1.isInRecall_ then
								local var_530_4 = Mathf.Lerp(iter_530_1.color.r, arg_527_1.hightColor1.r, var_530_3)
								local var_530_5 = Mathf.Lerp(iter_530_1.color.g, arg_527_1.hightColor1.g, var_530_3)
								local var_530_6 = Mathf.Lerp(iter_530_1.color.b, arg_527_1.hightColor1.b, var_530_3)

								iter_530_1.color = Color.New(var_530_4, var_530_5, var_530_6)
							else
								local var_530_7 = Mathf.Lerp(iter_530_1.color.r, 1, var_530_3)

								iter_530_1.color = Color.New(var_530_7, var_530_7, var_530_7)
							end
						end
					end
				end
			end

			if arg_527_1.time_ >= var_530_1 + var_530_2 and arg_527_1.time_ < var_530_1 + var_530_2 + arg_530_0 and not isNil(var_530_0) and arg_527_1.var_.actorSpriteComps10030 then
				for iter_530_2, iter_530_3 in pairs(arg_527_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_530_3 then
						if arg_527_1.isInRecall_ then
							iter_530_3.color = arg_527_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_530_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_527_1.var_.actorSpriteComps10030 = nil
			end

			local var_530_8 = arg_527_1.actors_["10029"]
			local var_530_9 = 0

			if var_530_9 < arg_527_1.time_ and arg_527_1.time_ <= var_530_9 + arg_530_0 and not isNil(var_530_8) then
				local var_530_10 = var_530_8:GetComponent("Image")

				if var_530_10 then
					arg_527_1.var_.highlightMatValue10029 = var_530_10
				end
			end

			local var_530_11 = 0.2

			if var_530_9 <= arg_527_1.time_ and arg_527_1.time_ < var_530_9 + var_530_11 and not isNil(var_530_8) then
				local var_530_12 = (arg_527_1.time_ - var_530_9) / var_530_11

				if arg_527_1.var_.highlightMatValue10029 then
					local var_530_13 = Mathf.Lerp(1, 0.5, var_530_12)
					local var_530_14 = arg_527_1.var_.highlightMatValue10029
					local var_530_15 = var_530_14.color

					var_530_15.r = var_530_13
					var_530_15.g = var_530_13
					var_530_15.b = var_530_13
					var_530_14.color = var_530_15
				end
			end

			if arg_527_1.time_ >= var_530_9 + var_530_11 and arg_527_1.time_ < var_530_9 + var_530_11 + arg_530_0 and not isNil(var_530_8) and arg_527_1.var_.highlightMatValue10029 then
				local var_530_16 = 0.5
				local var_530_17 = arg_527_1.var_.highlightMatValue10029
				local var_530_18 = var_530_17.color

				var_530_18.r = var_530_16
				var_530_18.g = var_530_16
				var_530_18.b = var_530_16
				var_530_17.color = var_530_18
			end

			local var_530_19 = arg_527_1.actors_["10030"].transform
			local var_530_20 = 0

			if var_530_20 < arg_527_1.time_ and arg_527_1.time_ <= var_530_20 + arg_530_0 then
				arg_527_1.var_.moveOldPos10030 = var_530_19.localPosition
				var_530_19.localScale = Vector3.New(1, 1, 1)

				arg_527_1:CheckSpriteTmpPos("10030", 4)

				local var_530_21 = var_530_19.childCount

				for iter_530_4 = 0, var_530_21 - 1 do
					local var_530_22 = var_530_19:GetChild(iter_530_4)

					if var_530_22.name == "split_1" or not string.find(var_530_22.name, "split") then
						var_530_22.gameObject:SetActive(true)
					else
						var_530_22.gameObject:SetActive(false)
					end
				end
			end

			local var_530_23 = 0.001

			if var_530_20 <= arg_527_1.time_ and arg_527_1.time_ < var_530_20 + var_530_23 then
				local var_530_24 = (arg_527_1.time_ - var_530_20) / var_530_23
				local var_530_25 = Vector3.New(390, -390, 150)

				var_530_19.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos10030, var_530_25, var_530_24)
			end

			if arg_527_1.time_ >= var_530_20 + var_530_23 and arg_527_1.time_ < var_530_20 + var_530_23 + arg_530_0 then
				var_530_19.localPosition = Vector3.New(390, -390, 150)
			end

			local var_530_26 = 0
			local var_530_27 = 0.2

			if var_530_26 < arg_527_1.time_ and arg_527_1.time_ <= var_530_26 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_28 = arg_527_1:FormatText(StoryNameCfg[309].name)

				arg_527_1.leftNameTxt_.text = var_530_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_29 = arg_527_1:GetWordFromCfg(115261129)
				local var_530_30 = arg_527_1:FormatText(var_530_29.content)

				arg_527_1.text_.text = var_530_30

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_31 = 8
				local var_530_32 = utf8.len(var_530_30)
				local var_530_33 = var_530_31 <= 0 and var_530_27 or var_530_27 * (var_530_32 / var_530_31)

				if var_530_33 > 0 and var_530_27 < var_530_33 then
					arg_527_1.talkMaxDuration = var_530_33

					if var_530_33 + var_530_26 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_33 + var_530_26
					end
				end

				arg_527_1.text_.text = var_530_30
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261129", "story_v_out_115261.awb") ~= 0 then
					local var_530_34 = manager.audio:GetVoiceLength("story_v_out_115261", "115261129", "story_v_out_115261.awb") / 1000

					if var_530_34 + var_530_26 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_34 + var_530_26
					end

					if var_530_29.prefab_name ~= "" and arg_527_1.actors_[var_530_29.prefab_name] ~= nil then
						local var_530_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_29.prefab_name].transform, "story_v_out_115261", "115261129", "story_v_out_115261.awb")

						arg_527_1:RecordAudio("115261129", var_530_35)
						arg_527_1:RecordAudio("115261129", var_530_35)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_115261", "115261129", "story_v_out_115261.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_115261", "115261129", "story_v_out_115261.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_36 = math.max(var_530_27, arg_527_1.talkMaxDuration)

			if var_530_26 <= arg_527_1.time_ and arg_527_1.time_ < var_530_26 + var_530_36 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_26) / var_530_36

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_26 + var_530_36 and arg_527_1.time_ < var_530_26 + var_530_36 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_527_1:InitPlayNodeList()
	end,
	Play115261130 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 115261130
		arg_531_1.duration_ = 12.97

		local var_531_0 = {
			ja = 12.966,
			ko = 12.733,
			zh = 10.766,
			en = 12.533
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play115261131(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = arg_531_1.actors_["10030"]
			local var_534_1 = 0

			if var_534_1 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 and not isNil(var_534_0) and arg_531_1.var_.actorSpriteComps10030 == nil then
				arg_531_1.var_.actorSpriteComps10030 = var_534_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_534_2 = 0.2

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_2 and not isNil(var_534_0) then
				local var_534_3 = (arg_531_1.time_ - var_534_1) / var_534_2

				if arg_531_1.var_.actorSpriteComps10030 then
					for iter_534_0, iter_534_1 in pairs(arg_531_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_534_1 then
							if arg_531_1.isInRecall_ then
								local var_534_4 = Mathf.Lerp(iter_534_1.color.r, arg_531_1.hightColor2.r, var_534_3)
								local var_534_5 = Mathf.Lerp(iter_534_1.color.g, arg_531_1.hightColor2.g, var_534_3)
								local var_534_6 = Mathf.Lerp(iter_534_1.color.b, arg_531_1.hightColor2.b, var_534_3)

								iter_534_1.color = Color.New(var_534_4, var_534_5, var_534_6)
							else
								local var_534_7 = Mathf.Lerp(iter_534_1.color.r, 0.5, var_534_3)

								iter_534_1.color = Color.New(var_534_7, var_534_7, var_534_7)
							end
						end
					end
				end
			end

			if arg_531_1.time_ >= var_534_1 + var_534_2 and arg_531_1.time_ < var_534_1 + var_534_2 + arg_534_0 and not isNil(var_534_0) and arg_531_1.var_.actorSpriteComps10030 then
				for iter_534_2, iter_534_3 in pairs(arg_531_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_534_3 then
						if arg_531_1.isInRecall_ then
							iter_534_3.color = arg_531_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_534_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_531_1.var_.actorSpriteComps10030 = nil
			end

			local var_534_8 = arg_531_1.actors_["10029"]
			local var_534_9 = 0

			if var_534_9 < arg_531_1.time_ and arg_531_1.time_ <= var_534_9 + arg_534_0 and not isNil(var_534_8) then
				local var_534_10 = var_534_8:GetComponent("Image")

				if var_534_10 then
					arg_531_1.var_.highlightMatValue10029 = var_534_10
				end
			end

			local var_534_11 = 0.2

			if var_534_9 <= arg_531_1.time_ and arg_531_1.time_ < var_534_9 + var_534_11 and not isNil(var_534_8) then
				local var_534_12 = (arg_531_1.time_ - var_534_9) / var_534_11

				if arg_531_1.var_.highlightMatValue10029 then
					local var_534_13 = Mathf.Lerp(0.5, 1, var_534_12)
					local var_534_14 = arg_531_1.var_.highlightMatValue10029
					local var_534_15 = var_534_14.color

					var_534_15.r = var_534_13
					var_534_15.g = var_534_13
					var_534_15.b = var_534_13
					var_534_14.color = var_534_15
				end
			end

			if arg_531_1.time_ >= var_534_9 + var_534_11 and arg_531_1.time_ < var_534_9 + var_534_11 + arg_534_0 and not isNil(var_534_8) and arg_531_1.var_.highlightMatValue10029 then
				local var_534_16 = 1

				var_534_8.transform:SetSiblingIndex(1)

				local var_534_17 = arg_531_1.var_.highlightMatValue10029
				local var_534_18 = var_534_17.color

				var_534_18.r = var_534_16
				var_534_18.g = var_534_16
				var_534_18.b = var_534_16
				var_534_17.color = var_534_18
			end

			local var_534_19 = 0
			local var_534_20 = 1.15

			if var_534_19 < arg_531_1.time_ and arg_531_1.time_ <= var_534_19 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_21 = arg_531_1:FormatText(StoryNameCfg[312].name)

				arg_531_1.leftNameTxt_.text = var_534_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_22 = arg_531_1:GetWordFromCfg(115261130)
				local var_534_23 = arg_531_1:FormatText(var_534_22.content)

				arg_531_1.text_.text = var_534_23

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_24 = 46
				local var_534_25 = utf8.len(var_534_23)
				local var_534_26 = var_534_24 <= 0 and var_534_20 or var_534_20 * (var_534_25 / var_534_24)

				if var_534_26 > 0 and var_534_20 < var_534_26 then
					arg_531_1.talkMaxDuration = var_534_26

					if var_534_26 + var_534_19 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_26 + var_534_19
					end
				end

				arg_531_1.text_.text = var_534_23
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261130", "story_v_out_115261.awb") ~= 0 then
					local var_534_27 = manager.audio:GetVoiceLength("story_v_out_115261", "115261130", "story_v_out_115261.awb") / 1000

					if var_534_27 + var_534_19 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_27 + var_534_19
					end

					if var_534_22.prefab_name ~= "" and arg_531_1.actors_[var_534_22.prefab_name] ~= nil then
						local var_534_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_22.prefab_name].transform, "story_v_out_115261", "115261130", "story_v_out_115261.awb")

						arg_531_1:RecordAudio("115261130", var_534_28)
						arg_531_1:RecordAudio("115261130", var_534_28)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_115261", "115261130", "story_v_out_115261.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_115261", "115261130", "story_v_out_115261.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_29 = math.max(var_534_20, arg_531_1.talkMaxDuration)

			if var_534_19 <= arg_531_1.time_ and arg_531_1.time_ < var_534_19 + var_534_29 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_19) / var_534_29

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_19 + var_534_29 and arg_531_1.time_ < var_534_19 + var_534_29 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play115261131 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 115261131
		arg_535_1.duration_ = 3.5

		local var_535_0 = {
			ja = 3.5,
			ko = 2.966,
			zh = 2.366,
			en = 3.333
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play115261132(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = arg_535_1.actors_["10030"]
			local var_538_1 = 0

			if var_538_1 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 and not isNil(var_538_0) and arg_535_1.var_.actorSpriteComps10030 == nil then
				arg_535_1.var_.actorSpriteComps10030 = var_538_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_538_2 = 0.2

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_2 and not isNil(var_538_0) then
				local var_538_3 = (arg_535_1.time_ - var_538_1) / var_538_2

				if arg_535_1.var_.actorSpriteComps10030 then
					for iter_538_0, iter_538_1 in pairs(arg_535_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_538_1 then
							if arg_535_1.isInRecall_ then
								local var_538_4 = Mathf.Lerp(iter_538_1.color.r, arg_535_1.hightColor1.r, var_538_3)
								local var_538_5 = Mathf.Lerp(iter_538_1.color.g, arg_535_1.hightColor1.g, var_538_3)
								local var_538_6 = Mathf.Lerp(iter_538_1.color.b, arg_535_1.hightColor1.b, var_538_3)

								iter_538_1.color = Color.New(var_538_4, var_538_5, var_538_6)
							else
								local var_538_7 = Mathf.Lerp(iter_538_1.color.r, 1, var_538_3)

								iter_538_1.color = Color.New(var_538_7, var_538_7, var_538_7)
							end
						end
					end
				end
			end

			if arg_535_1.time_ >= var_538_1 + var_538_2 and arg_535_1.time_ < var_538_1 + var_538_2 + arg_538_0 and not isNil(var_538_0) and arg_535_1.var_.actorSpriteComps10030 then
				for iter_538_2, iter_538_3 in pairs(arg_535_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_538_3 then
						if arg_535_1.isInRecall_ then
							iter_538_3.color = arg_535_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_538_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_535_1.var_.actorSpriteComps10030 = nil
			end

			local var_538_8 = arg_535_1.actors_["10029"]
			local var_538_9 = 0

			if var_538_9 < arg_535_1.time_ and arg_535_1.time_ <= var_538_9 + arg_538_0 and not isNil(var_538_8) then
				local var_538_10 = var_538_8:GetComponent("Image")

				if var_538_10 then
					arg_535_1.var_.highlightMatValue10029 = var_538_10
				end
			end

			local var_538_11 = 0.2

			if var_538_9 <= arg_535_1.time_ and arg_535_1.time_ < var_538_9 + var_538_11 and not isNil(var_538_8) then
				local var_538_12 = (arg_535_1.time_ - var_538_9) / var_538_11

				if arg_535_1.var_.highlightMatValue10029 then
					local var_538_13 = Mathf.Lerp(1, 0.5, var_538_12)
					local var_538_14 = arg_535_1.var_.highlightMatValue10029
					local var_538_15 = var_538_14.color

					var_538_15.r = var_538_13
					var_538_15.g = var_538_13
					var_538_15.b = var_538_13
					var_538_14.color = var_538_15
				end
			end

			if arg_535_1.time_ >= var_538_9 + var_538_11 and arg_535_1.time_ < var_538_9 + var_538_11 + arg_538_0 and not isNil(var_538_8) and arg_535_1.var_.highlightMatValue10029 then
				local var_538_16 = 0.5
				local var_538_17 = arg_535_1.var_.highlightMatValue10029
				local var_538_18 = var_538_17.color

				var_538_18.r = var_538_16
				var_538_18.g = var_538_16
				var_538_18.b = var_538_16
				var_538_17.color = var_538_18
			end

			local var_538_19 = arg_535_1.actors_["10030"].transform
			local var_538_20 = 0

			if var_538_20 < arg_535_1.time_ and arg_535_1.time_ <= var_538_20 + arg_538_0 then
				arg_535_1.var_.moveOldPos10030 = var_538_19.localPosition
				var_538_19.localScale = Vector3.New(1, 1, 1)

				arg_535_1:CheckSpriteTmpPos("10030", 4)

				local var_538_21 = var_538_19.childCount

				for iter_538_4 = 0, var_538_21 - 1 do
					local var_538_22 = var_538_19:GetChild(iter_538_4)

					if var_538_22.name == "split_3" or not string.find(var_538_22.name, "split") then
						var_538_22.gameObject:SetActive(true)
					else
						var_538_22.gameObject:SetActive(false)
					end
				end
			end

			local var_538_23 = 0.001

			if var_538_20 <= arg_535_1.time_ and arg_535_1.time_ < var_538_20 + var_538_23 then
				local var_538_24 = (arg_535_1.time_ - var_538_20) / var_538_23
				local var_538_25 = Vector3.New(390, -390, 150)

				var_538_19.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos10030, var_538_25, var_538_24)
			end

			if arg_535_1.time_ >= var_538_20 + var_538_23 and arg_535_1.time_ < var_538_20 + var_538_23 + arg_538_0 then
				var_538_19.localPosition = Vector3.New(390, -390, 150)
			end

			local var_538_26 = arg_535_1.actors_["10030"]
			local var_538_27 = 0

			if var_538_27 < arg_535_1.time_ and arg_535_1.time_ <= var_538_27 + arg_538_0 then
				local var_538_28 = var_538_26:GetComponentInChildren(typeof(CanvasGroup))

				if var_538_28 then
					arg_535_1.var_.alphaOldValue10030 = var_538_28.alpha
					arg_535_1.var_.characterEffect10030 = var_538_28
				end

				arg_535_1.var_.alphaOldValue10030 = 0
			end

			local var_538_29 = 0.0166666666666667

			if var_538_27 <= arg_535_1.time_ and arg_535_1.time_ < var_538_27 + var_538_29 then
				local var_538_30 = (arg_535_1.time_ - var_538_27) / var_538_29
				local var_538_31 = Mathf.Lerp(arg_535_1.var_.alphaOldValue10030, 1, var_538_30)

				if arg_535_1.var_.characterEffect10030 then
					arg_535_1.var_.characterEffect10030.alpha = var_538_31
				end
			end

			if arg_535_1.time_ >= var_538_27 + var_538_29 and arg_535_1.time_ < var_538_27 + var_538_29 + arg_538_0 and arg_535_1.var_.characterEffect10030 then
				arg_535_1.var_.characterEffect10030.alpha = 1
			end

			local var_538_32 = 0
			local var_538_33 = 0.2

			if var_538_32 < arg_535_1.time_ and arg_535_1.time_ <= var_538_32 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				local var_538_34 = arg_535_1:FormatText(StoryNameCfg[309].name)

				arg_535_1.leftNameTxt_.text = var_538_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_35 = arg_535_1:GetWordFromCfg(115261131)
				local var_538_36 = arg_535_1:FormatText(var_538_35.content)

				arg_535_1.text_.text = var_538_36

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_37 = 8
				local var_538_38 = utf8.len(var_538_36)
				local var_538_39 = var_538_37 <= 0 and var_538_33 or var_538_33 * (var_538_38 / var_538_37)

				if var_538_39 > 0 and var_538_33 < var_538_39 then
					arg_535_1.talkMaxDuration = var_538_39

					if var_538_39 + var_538_32 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_39 + var_538_32
					end
				end

				arg_535_1.text_.text = var_538_36
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261131", "story_v_out_115261.awb") ~= 0 then
					local var_538_40 = manager.audio:GetVoiceLength("story_v_out_115261", "115261131", "story_v_out_115261.awb") / 1000

					if var_538_40 + var_538_32 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_40 + var_538_32
					end

					if var_538_35.prefab_name ~= "" and arg_535_1.actors_[var_538_35.prefab_name] ~= nil then
						local var_538_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_35.prefab_name].transform, "story_v_out_115261", "115261131", "story_v_out_115261.awb")

						arg_535_1:RecordAudio("115261131", var_538_41)
						arg_535_1:RecordAudio("115261131", var_538_41)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_115261", "115261131", "story_v_out_115261.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_115261", "115261131", "story_v_out_115261.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_42 = math.max(var_538_33, arg_535_1.talkMaxDuration)

			if var_538_32 <= arg_535_1.time_ and arg_535_1.time_ < var_538_32 + var_538_42 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_32) / var_538_42

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_32 + var_538_42 and arg_535_1.time_ < var_538_32 + var_538_42 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play115261132 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 115261132
		arg_539_1.duration_ = 7.67

		local var_539_0 = {
			ja = 6,
			ko = 6.7,
			zh = 7.1,
			en = 7.666
		}
		local var_539_1 = manager.audio:GetLocalizationFlag()

		if var_539_0[var_539_1] ~= nil then
			arg_539_1.duration_ = var_539_0[var_539_1]
		end

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play115261133(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = arg_539_1.actors_["10030"]
			local var_542_1 = 0

			if var_542_1 < arg_539_1.time_ and arg_539_1.time_ <= var_542_1 + arg_542_0 and not isNil(var_542_0) and arg_539_1.var_.actorSpriteComps10030 == nil then
				arg_539_1.var_.actorSpriteComps10030 = var_542_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_542_2 = 0.2

			if var_542_1 <= arg_539_1.time_ and arg_539_1.time_ < var_542_1 + var_542_2 and not isNil(var_542_0) then
				local var_542_3 = (arg_539_1.time_ - var_542_1) / var_542_2

				if arg_539_1.var_.actorSpriteComps10030 then
					for iter_542_0, iter_542_1 in pairs(arg_539_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_542_1 then
							if arg_539_1.isInRecall_ then
								local var_542_4 = Mathf.Lerp(iter_542_1.color.r, arg_539_1.hightColor2.r, var_542_3)
								local var_542_5 = Mathf.Lerp(iter_542_1.color.g, arg_539_1.hightColor2.g, var_542_3)
								local var_542_6 = Mathf.Lerp(iter_542_1.color.b, arg_539_1.hightColor2.b, var_542_3)

								iter_542_1.color = Color.New(var_542_4, var_542_5, var_542_6)
							else
								local var_542_7 = Mathf.Lerp(iter_542_1.color.r, 0.5, var_542_3)

								iter_542_1.color = Color.New(var_542_7, var_542_7, var_542_7)
							end
						end
					end
				end
			end

			if arg_539_1.time_ >= var_542_1 + var_542_2 and arg_539_1.time_ < var_542_1 + var_542_2 + arg_542_0 and not isNil(var_542_0) and arg_539_1.var_.actorSpriteComps10030 then
				for iter_542_2, iter_542_3 in pairs(arg_539_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_542_3 then
						if arg_539_1.isInRecall_ then
							iter_542_3.color = arg_539_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_542_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_539_1.var_.actorSpriteComps10030 = nil
			end

			local var_542_8 = arg_539_1.actors_["10029"]
			local var_542_9 = 0

			if var_542_9 < arg_539_1.time_ and arg_539_1.time_ <= var_542_9 + arg_542_0 and not isNil(var_542_8) then
				local var_542_10 = var_542_8:GetComponent("Image")

				if var_542_10 then
					arg_539_1.var_.highlightMatValue10029 = var_542_10
				end
			end

			local var_542_11 = 0.2

			if var_542_9 <= arg_539_1.time_ and arg_539_1.time_ < var_542_9 + var_542_11 and not isNil(var_542_8) then
				local var_542_12 = (arg_539_1.time_ - var_542_9) / var_542_11

				if arg_539_1.var_.highlightMatValue10029 then
					local var_542_13 = Mathf.Lerp(0.5, 1, var_542_12)
					local var_542_14 = arg_539_1.var_.highlightMatValue10029
					local var_542_15 = var_542_14.color

					var_542_15.r = var_542_13
					var_542_15.g = var_542_13
					var_542_15.b = var_542_13
					var_542_14.color = var_542_15
				end
			end

			if arg_539_1.time_ >= var_542_9 + var_542_11 and arg_539_1.time_ < var_542_9 + var_542_11 + arg_542_0 and not isNil(var_542_8) and arg_539_1.var_.highlightMatValue10029 then
				local var_542_16 = 1

				var_542_8.transform:SetSiblingIndex(1)

				local var_542_17 = arg_539_1.var_.highlightMatValue10029
				local var_542_18 = var_542_17.color

				var_542_18.r = var_542_16
				var_542_18.g = var_542_16
				var_542_18.b = var_542_16
				var_542_17.color = var_542_18
			end

			local var_542_19 = 0
			local var_542_20 = 0.625

			if var_542_19 < arg_539_1.time_ and arg_539_1.time_ <= var_542_19 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_21 = arg_539_1:FormatText(StoryNameCfg[312].name)

				arg_539_1.leftNameTxt_.text = var_542_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_22 = arg_539_1:GetWordFromCfg(115261132)
				local var_542_23 = arg_539_1:FormatText(var_542_22.content)

				arg_539_1.text_.text = var_542_23

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_24 = 29
				local var_542_25 = utf8.len(var_542_23)
				local var_542_26 = var_542_24 <= 0 and var_542_20 or var_542_20 * (var_542_25 / var_542_24)

				if var_542_26 > 0 and var_542_20 < var_542_26 then
					arg_539_1.talkMaxDuration = var_542_26

					if var_542_26 + var_542_19 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_26 + var_542_19
					end
				end

				arg_539_1.text_.text = var_542_23
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261132", "story_v_out_115261.awb") ~= 0 then
					local var_542_27 = manager.audio:GetVoiceLength("story_v_out_115261", "115261132", "story_v_out_115261.awb") / 1000

					if var_542_27 + var_542_19 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_27 + var_542_19
					end

					if var_542_22.prefab_name ~= "" and arg_539_1.actors_[var_542_22.prefab_name] ~= nil then
						local var_542_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_22.prefab_name].transform, "story_v_out_115261", "115261132", "story_v_out_115261.awb")

						arg_539_1:RecordAudio("115261132", var_542_28)
						arg_539_1:RecordAudio("115261132", var_542_28)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_out_115261", "115261132", "story_v_out_115261.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_out_115261", "115261132", "story_v_out_115261.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_29 = math.max(var_542_20, arg_539_1.talkMaxDuration)

			if var_542_19 <= arg_539_1.time_ and arg_539_1.time_ < var_542_19 + var_542_29 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_19) / var_542_29

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_19 + var_542_29 and arg_539_1.time_ < var_542_19 + var_542_29 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play115261133 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 115261133
		arg_543_1.duration_ = 17.3

		local var_543_0 = {
			ja = 10.9,
			ko = 16.4,
			zh = 12.533,
			en = 17.3
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play115261134(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0
			local var_546_1 = 1.4

			if var_546_0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_2 = arg_543_1:FormatText(StoryNameCfg[312].name)

				arg_543_1.leftNameTxt_.text = var_546_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_3 = arg_543_1:GetWordFromCfg(115261133)
				local var_546_4 = arg_543_1:FormatText(var_546_3.content)

				arg_543_1.text_.text = var_546_4

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_5 = 56
				local var_546_6 = utf8.len(var_546_4)
				local var_546_7 = var_546_5 <= 0 and var_546_1 or var_546_1 * (var_546_6 / var_546_5)

				if var_546_7 > 0 and var_546_1 < var_546_7 then
					arg_543_1.talkMaxDuration = var_546_7

					if var_546_7 + var_546_0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_7 + var_546_0
					end
				end

				arg_543_1.text_.text = var_546_4
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261133", "story_v_out_115261.awb") ~= 0 then
					local var_546_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261133", "story_v_out_115261.awb") / 1000

					if var_546_8 + var_546_0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_8 + var_546_0
					end

					if var_546_3.prefab_name ~= "" and arg_543_1.actors_[var_546_3.prefab_name] ~= nil then
						local var_546_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_3.prefab_name].transform, "story_v_out_115261", "115261133", "story_v_out_115261.awb")

						arg_543_1:RecordAudio("115261133", var_546_9)
						arg_543_1:RecordAudio("115261133", var_546_9)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_115261", "115261133", "story_v_out_115261.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_115261", "115261133", "story_v_out_115261.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_10 = math.max(var_546_1, arg_543_1.talkMaxDuration)

			if var_546_0 <= arg_543_1.time_ and arg_543_1.time_ < var_546_0 + var_546_10 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_0) / var_546_10

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_0 + var_546_10 and arg_543_1.time_ < var_546_0 + var_546_10 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play115261134 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 115261134
		arg_547_1.duration_ = 6.53

		local var_547_0 = {
			ja = 6.533,
			ko = 6.533,
			zh = 5.166,
			en = 5.633
		}
		local var_547_1 = manager.audio:GetLocalizationFlag()

		if var_547_0[var_547_1] ~= nil then
			arg_547_1.duration_ = var_547_0[var_547_1]
		end

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play115261135(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = arg_547_1.actors_["10030"]
			local var_550_1 = 0

			if var_550_1 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 and not isNil(var_550_0) and arg_547_1.var_.actorSpriteComps10030 == nil then
				arg_547_1.var_.actorSpriteComps10030 = var_550_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_550_2 = 0.2

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_2 and not isNil(var_550_0) then
				local var_550_3 = (arg_547_1.time_ - var_550_1) / var_550_2

				if arg_547_1.var_.actorSpriteComps10030 then
					for iter_550_0, iter_550_1 in pairs(arg_547_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_550_1 then
							if arg_547_1.isInRecall_ then
								local var_550_4 = Mathf.Lerp(iter_550_1.color.r, arg_547_1.hightColor1.r, var_550_3)
								local var_550_5 = Mathf.Lerp(iter_550_1.color.g, arg_547_1.hightColor1.g, var_550_3)
								local var_550_6 = Mathf.Lerp(iter_550_1.color.b, arg_547_1.hightColor1.b, var_550_3)

								iter_550_1.color = Color.New(var_550_4, var_550_5, var_550_6)
							else
								local var_550_7 = Mathf.Lerp(iter_550_1.color.r, 1, var_550_3)

								iter_550_1.color = Color.New(var_550_7, var_550_7, var_550_7)
							end
						end
					end
				end
			end

			if arg_547_1.time_ >= var_550_1 + var_550_2 and arg_547_1.time_ < var_550_1 + var_550_2 + arg_550_0 and not isNil(var_550_0) and arg_547_1.var_.actorSpriteComps10030 then
				for iter_550_2, iter_550_3 in pairs(arg_547_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_550_3 then
						if arg_547_1.isInRecall_ then
							iter_550_3.color = arg_547_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_550_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_547_1.var_.actorSpriteComps10030 = nil
			end

			local var_550_8 = arg_547_1.actors_["10029"]
			local var_550_9 = 0

			if var_550_9 < arg_547_1.time_ and arg_547_1.time_ <= var_550_9 + arg_550_0 and not isNil(var_550_8) then
				local var_550_10 = var_550_8:GetComponent("Image")

				if var_550_10 then
					arg_547_1.var_.highlightMatValue10029 = var_550_10
				end
			end

			local var_550_11 = 0.2

			if var_550_9 <= arg_547_1.time_ and arg_547_1.time_ < var_550_9 + var_550_11 and not isNil(var_550_8) then
				local var_550_12 = (arg_547_1.time_ - var_550_9) / var_550_11

				if arg_547_1.var_.highlightMatValue10029 then
					local var_550_13 = Mathf.Lerp(1, 0.5, var_550_12)
					local var_550_14 = arg_547_1.var_.highlightMatValue10029
					local var_550_15 = var_550_14.color

					var_550_15.r = var_550_13
					var_550_15.g = var_550_13
					var_550_15.b = var_550_13
					var_550_14.color = var_550_15
				end
			end

			if arg_547_1.time_ >= var_550_9 + var_550_11 and arg_547_1.time_ < var_550_9 + var_550_11 + arg_550_0 and not isNil(var_550_8) and arg_547_1.var_.highlightMatValue10029 then
				local var_550_16 = 0.5
				local var_550_17 = arg_547_1.var_.highlightMatValue10029
				local var_550_18 = var_550_17.color

				var_550_18.r = var_550_16
				var_550_18.g = var_550_16
				var_550_18.b = var_550_16
				var_550_17.color = var_550_18
			end

			local var_550_19 = arg_547_1.actors_["10030"].transform
			local var_550_20 = 0

			if var_550_20 < arg_547_1.time_ and arg_547_1.time_ <= var_550_20 + arg_550_0 then
				arg_547_1.var_.moveOldPos10030 = var_550_19.localPosition
				var_550_19.localScale = Vector3.New(1, 1, 1)

				arg_547_1:CheckSpriteTmpPos("10030", 4)

				local var_550_21 = var_550_19.childCount

				for iter_550_4 = 0, var_550_21 - 1 do
					local var_550_22 = var_550_19:GetChild(iter_550_4)

					if var_550_22.name == "split_1" or not string.find(var_550_22.name, "split") then
						var_550_22.gameObject:SetActive(true)
					else
						var_550_22.gameObject:SetActive(false)
					end
				end
			end

			local var_550_23 = 0.001

			if var_550_20 <= arg_547_1.time_ and arg_547_1.time_ < var_550_20 + var_550_23 then
				local var_550_24 = (arg_547_1.time_ - var_550_20) / var_550_23
				local var_550_25 = Vector3.New(390, -390, 150)

				var_550_19.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos10030, var_550_25, var_550_24)
			end

			if arg_547_1.time_ >= var_550_20 + var_550_23 and arg_547_1.time_ < var_550_20 + var_550_23 + arg_550_0 then
				var_550_19.localPosition = Vector3.New(390, -390, 150)
			end

			local var_550_26 = arg_547_1.actors_["10030"]
			local var_550_27 = 0

			if var_550_27 < arg_547_1.time_ and arg_547_1.time_ <= var_550_27 + arg_550_0 then
				local var_550_28 = var_550_26:GetComponentInChildren(typeof(CanvasGroup))

				if var_550_28 then
					arg_547_1.var_.alphaOldValue10030 = var_550_28.alpha
					arg_547_1.var_.characterEffect10030 = var_550_28
				end

				arg_547_1.var_.alphaOldValue10030 = 0
			end

			local var_550_29 = 0.0166666666666667

			if var_550_27 <= arg_547_1.time_ and arg_547_1.time_ < var_550_27 + var_550_29 then
				local var_550_30 = (arg_547_1.time_ - var_550_27) / var_550_29
				local var_550_31 = Mathf.Lerp(arg_547_1.var_.alphaOldValue10030, 1, var_550_30)

				if arg_547_1.var_.characterEffect10030 then
					arg_547_1.var_.characterEffect10030.alpha = var_550_31
				end
			end

			if arg_547_1.time_ >= var_550_27 + var_550_29 and arg_547_1.time_ < var_550_27 + var_550_29 + arg_550_0 and arg_547_1.var_.characterEffect10030 then
				arg_547_1.var_.characterEffect10030.alpha = 1
			end

			local var_550_32 = 0
			local var_550_33 = 0.5

			if var_550_32 < arg_547_1.time_ and arg_547_1.time_ <= var_550_32 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				local var_550_34 = arg_547_1:FormatText(StoryNameCfg[309].name)

				arg_547_1.leftNameTxt_.text = var_550_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_35 = arg_547_1:GetWordFromCfg(115261134)
				local var_550_36 = arg_547_1:FormatText(var_550_35.content)

				arg_547_1.text_.text = var_550_36

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_37 = 20
				local var_550_38 = utf8.len(var_550_36)
				local var_550_39 = var_550_37 <= 0 and var_550_33 or var_550_33 * (var_550_38 / var_550_37)

				if var_550_39 > 0 and var_550_33 < var_550_39 then
					arg_547_1.talkMaxDuration = var_550_39

					if var_550_39 + var_550_32 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_39 + var_550_32
					end
				end

				arg_547_1.text_.text = var_550_36
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261134", "story_v_out_115261.awb") ~= 0 then
					local var_550_40 = manager.audio:GetVoiceLength("story_v_out_115261", "115261134", "story_v_out_115261.awb") / 1000

					if var_550_40 + var_550_32 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_40 + var_550_32
					end

					if var_550_35.prefab_name ~= "" and arg_547_1.actors_[var_550_35.prefab_name] ~= nil then
						local var_550_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_35.prefab_name].transform, "story_v_out_115261", "115261134", "story_v_out_115261.awb")

						arg_547_1:RecordAudio("115261134", var_550_41)
						arg_547_1:RecordAudio("115261134", var_550_41)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_out_115261", "115261134", "story_v_out_115261.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_out_115261", "115261134", "story_v_out_115261.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_42 = math.max(var_550_33, arg_547_1.talkMaxDuration)

			if var_550_32 <= arg_547_1.time_ and arg_547_1.time_ < var_550_32 + var_550_42 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_32) / var_550_42

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_32 + var_550_42 and arg_547_1.time_ < var_550_32 + var_550_42 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_547_1:InitPlayNodeList()
	end,
	Play115261135 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 115261135
		arg_551_1.duration_ = 2.67

		local var_551_0 = {
			ja = 2.666,
			ko = 1.633,
			zh = 2,
			en = 2.533
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play115261136(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = arg_551_1.actors_["10030"].transform
			local var_554_1 = 0

			if var_554_1 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 then
				arg_551_1.var_.moveOldPos10030 = var_554_0.localPosition
				var_554_0.localScale = Vector3.New(1, 1, 1)

				arg_551_1:CheckSpriteTmpPos("10030", 4)

				local var_554_2 = var_554_0.childCount

				for iter_554_0 = 0, var_554_2 - 1 do
					local var_554_3 = var_554_0:GetChild(iter_554_0)

					if var_554_3.name == "split_5" or not string.find(var_554_3.name, "split") then
						var_554_3.gameObject:SetActive(true)
					else
						var_554_3.gameObject:SetActive(false)
					end
				end
			end

			local var_554_4 = 0.001

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_4 then
				local var_554_5 = (arg_551_1.time_ - var_554_1) / var_554_4
				local var_554_6 = Vector3.New(390, -390, 150)

				var_554_0.localPosition = Vector3.Lerp(arg_551_1.var_.moveOldPos10030, var_554_6, var_554_5)
			end

			if arg_551_1.time_ >= var_554_1 + var_554_4 and arg_551_1.time_ < var_554_1 + var_554_4 + arg_554_0 then
				var_554_0.localPosition = Vector3.New(390, -390, 150)
			end

			local var_554_7 = 0
			local var_554_8 = 0.15

			if var_554_7 < arg_551_1.time_ and arg_551_1.time_ <= var_554_7 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_9 = arg_551_1:FormatText(StoryNameCfg[309].name)

				arg_551_1.leftNameTxt_.text = var_554_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_10 = arg_551_1:GetWordFromCfg(115261135)
				local var_554_11 = arg_551_1:FormatText(var_554_10.content)

				arg_551_1.text_.text = var_554_11

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_12 = 6
				local var_554_13 = utf8.len(var_554_11)
				local var_554_14 = var_554_12 <= 0 and var_554_8 or var_554_8 * (var_554_13 / var_554_12)

				if var_554_14 > 0 and var_554_8 < var_554_14 then
					arg_551_1.talkMaxDuration = var_554_14

					if var_554_14 + var_554_7 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_14 + var_554_7
					end
				end

				arg_551_1.text_.text = var_554_11
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261135", "story_v_out_115261.awb") ~= 0 then
					local var_554_15 = manager.audio:GetVoiceLength("story_v_out_115261", "115261135", "story_v_out_115261.awb") / 1000

					if var_554_15 + var_554_7 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_15 + var_554_7
					end

					if var_554_10.prefab_name ~= "" and arg_551_1.actors_[var_554_10.prefab_name] ~= nil then
						local var_554_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_10.prefab_name].transform, "story_v_out_115261", "115261135", "story_v_out_115261.awb")

						arg_551_1:RecordAudio("115261135", var_554_16)
						arg_551_1:RecordAudio("115261135", var_554_16)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_115261", "115261135", "story_v_out_115261.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_115261", "115261135", "story_v_out_115261.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_17 = math.max(var_554_8, arg_551_1.talkMaxDuration)

			if var_554_7 <= arg_551_1.time_ and arg_551_1.time_ < var_554_7 + var_554_17 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_7) / var_554_17

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_7 + var_554_17 and arg_551_1.time_ < var_554_7 + var_554_17 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_551_1:InitPlayNodeList()
	end,
	Play115261136 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 115261136
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
			arg_555_1.auto_ = false
		end

		function arg_555_1.playNext_(arg_557_0)
			arg_555_1.onStoryFinished_()
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = arg_555_1.actors_["10030"]
			local var_558_1 = 0

			if var_558_1 < arg_555_1.time_ and arg_555_1.time_ <= var_558_1 + arg_558_0 then
				local var_558_2 = var_558_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_558_2 then
					arg_555_1.var_.alphaOldValue10030 = var_558_2.alpha
					arg_555_1.var_.characterEffect10030 = var_558_2
				end

				arg_555_1.var_.alphaOldValue10030 = 1
			end

			local var_558_3 = 0.333333333333333

			if var_558_1 <= arg_555_1.time_ and arg_555_1.time_ < var_558_1 + var_558_3 then
				local var_558_4 = (arg_555_1.time_ - var_558_1) / var_558_3
				local var_558_5 = Mathf.Lerp(arg_555_1.var_.alphaOldValue10030, 0, var_558_4)

				if arg_555_1.var_.characterEffect10030 then
					arg_555_1.var_.characterEffect10030.alpha = var_558_5
				end
			end

			if arg_555_1.time_ >= var_558_1 + var_558_3 and arg_555_1.time_ < var_558_1 + var_558_3 + arg_558_0 and arg_555_1.var_.characterEffect10030 then
				arg_555_1.var_.characterEffect10030.alpha = 0
			end

			local var_558_6 = arg_555_1.actors_["10029"]
			local var_558_7 = 0

			if var_558_7 < arg_555_1.time_ and arg_555_1.time_ <= var_558_7 + arg_558_0 then
				local var_558_8 = var_558_6:GetComponent("Image")

				if var_558_8 then
					arg_555_1.var_.alphaMatValue10029 = var_558_8
					arg_555_1.var_.alphaOldValue10029 = var_558_8.color.a
				end

				arg_555_1.var_.alphaOldValue10029 = 1
			end

			local var_558_9 = 0.333333333333333

			if var_558_7 <= arg_555_1.time_ and arg_555_1.time_ < var_558_7 + var_558_9 then
				local var_558_10 = (arg_555_1.time_ - var_558_7) / var_558_9
				local var_558_11 = Mathf.Lerp(arg_555_1.var_.alphaOldValue10029, 0, var_558_10)

				if arg_555_1.var_.alphaMatValue10029 then
					local var_558_12 = arg_555_1.var_.alphaMatValue10029.color

					var_558_12.a = var_558_11
					arg_555_1.var_.alphaMatValue10029.color = var_558_12
				end
			end

			if arg_555_1.time_ >= var_558_7 + var_558_9 and arg_555_1.time_ < var_558_7 + var_558_9 + arg_558_0 and arg_555_1.var_.alphaMatValue10029 then
				local var_558_13 = arg_555_1.var_.alphaMatValue10029
				local var_558_14 = var_558_13.color

				var_558_14.a = 0
				var_558_13.color = var_558_14
			end

			local var_558_15 = 0
			local var_558_16 = 0.825

			if var_558_15 < arg_555_1.time_ and arg_555_1.time_ <= var_558_15 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, false)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_17 = arg_555_1:GetWordFromCfg(115261136)
				local var_558_18 = arg_555_1:FormatText(var_558_17.content)

				arg_555_1.text_.text = var_558_18

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_19 = 33
				local var_558_20 = utf8.len(var_558_18)
				local var_558_21 = var_558_19 <= 0 and var_558_16 or var_558_16 * (var_558_20 / var_558_19)

				if var_558_21 > 0 and var_558_16 < var_558_21 then
					arg_555_1.talkMaxDuration = var_558_21

					if var_558_21 + var_558_15 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_21 + var_558_15
					end
				end

				arg_555_1.text_.text = var_558_18
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_22 = math.max(var_558_16, arg_555_1.talkMaxDuration)

			if var_558_15 <= arg_555_1.time_ and arg_555_1.time_ < var_558_15 + var_558_22 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_15) / var_558_22

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_15 + var_558_22 and arg_555_1.time_ < var_558_15 + var_558_22 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST22",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/F01a",
		"TextureConfig/Background/ST27a",
		"TextureConfig/Background/ST22a"
	},
	voices = {
		"story_v_out_115261.awb"
	}
}
