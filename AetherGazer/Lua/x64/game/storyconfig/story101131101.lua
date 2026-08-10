return {
	Play113111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113111001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play113111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F02_1"

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
				local var_4_5 = arg_1_1.bgs_.F02_1

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
					if iter_4_0 ~= "F02_1" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
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
			local var_4_29 = 1

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
			local var_4_35 = 0.275

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(113111001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 11
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play113111002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 113111002
		arg_9_1.duration_ = 2.57

		local var_9_0 = {
			ja = 2.566,
			ko = 1.866,
			zh = 1.466,
			en = 2.466
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
				arg_9_0:Play113111003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.25

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

				local var_12_3 = arg_9_1:GetWordFromCfg(113111002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111002", "story_v_out_113111.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_113111", "113111002", "story_v_out_113111.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_113111", "113111002", "story_v_out_113111.awb")

						arg_9_1:RecordAudio("113111002", var_12_9)
						arg_9_1:RecordAudio("113111002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_113111", "113111002", "story_v_out_113111.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_113111", "113111002", "story_v_out_113111.awb")
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
	Play113111003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 113111003
		arg_13_1.duration_ = 8.2

		local var_13_0 = {
			ja = 8.2,
			ko = 5.3,
			zh = 5.3,
			en = 6.466
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
				arg_13_0:Play113111004(arg_13_1)
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

				local var_16_3 = arg_13_1:GetWordFromCfg(113111003)
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

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111003", "story_v_out_113111.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_113111", "113111003", "story_v_out_113111.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_113111", "113111003", "story_v_out_113111.awb")

						arg_13_1:RecordAudio("113111003", var_16_9)
						arg_13_1:RecordAudio("113111003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_113111", "113111003", "story_v_out_113111.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_113111", "113111003", "story_v_out_113111.awb")
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
	Play113111004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 113111004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play113111005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.6

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

				local var_20_2 = arg_17_1:GetWordFromCfg(113111004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 24
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
	Play113111005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 113111005
		arg_21_1.duration_ = 6.6

		local var_21_0 = {
			ja = 6.6,
			ko = 5.566,
			zh = 6.366,
			en = 6.566
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
				arg_21_0:Play113111006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.75

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[36].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(113111005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111005", "story_v_out_113111.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_113111", "113111005", "story_v_out_113111.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_113111", "113111005", "story_v_out_113111.awb")

						arg_21_1:RecordAudio("113111005", var_24_9)
						arg_21_1:RecordAudio("113111005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_113111", "113111005", "story_v_out_113111.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_113111", "113111005", "story_v_out_113111.awb")
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
	Play113111006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 113111006
		arg_25_1.duration_ = 13.17

		local var_25_0 = {
			ja = 13.166,
			ko = 9.766,
			zh = 9.766,
			en = 8.4
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
				arg_25_0:Play113111007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.675

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[36].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(113111006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111006", "story_v_out_113111.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_113111", "113111006", "story_v_out_113111.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_113111", "113111006", "story_v_out_113111.awb")

						arg_25_1:RecordAudio("113111006", var_28_9)
						arg_25_1:RecordAudio("113111006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_113111", "113111006", "story_v_out_113111.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_113111", "113111006", "story_v_out_113111.awb")
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
	Play113111007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 113111007
		arg_29_1.duration_ = 3.57

		local var_29_0 = {
			ja = 3.566,
			ko = 2.2,
			zh = 2.266,
			en = 2.3
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
				arg_29_0:Play113111008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.25

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[36].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(113111007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 10
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111007", "story_v_out_113111.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_113111", "113111007", "story_v_out_113111.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_113111", "113111007", "story_v_out_113111.awb")

						arg_29_1:RecordAudio("113111007", var_32_9)
						arg_29_1:RecordAudio("113111007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_113111", "113111007", "story_v_out_113111.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_113111", "113111007", "story_v_out_113111.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play113111008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 113111008
		arg_33_1.duration_ = 2.33

		local var_33_0 = {
			ja = 2.333,
			ko = 0.999999999999,
			zh = 1.7,
			en = 1.233
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
				arg_33_0:Play113111009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.05

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[36].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(113111008)
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

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111008", "story_v_out_113111.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_113111", "113111008", "story_v_out_113111.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_113111", "113111008", "story_v_out_113111.awb")

						arg_33_1:RecordAudio("113111008", var_36_9)
						arg_33_1:RecordAudio("113111008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_113111", "113111008", "story_v_out_113111.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_113111", "113111008", "story_v_out_113111.awb")
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
	Play113111009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 113111009
		arg_37_1.duration_ = 3.53

		local var_37_0 = {
			ja = 3.5,
			ko = 2.8,
			zh = 3.533,
			en = 3.5
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
				arg_37_0:Play113111010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.475

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[36].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(113111009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111009", "story_v_out_113111.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_113111", "113111009", "story_v_out_113111.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_113111", "113111009", "story_v_out_113111.awb")

						arg_37_1:RecordAudio("113111009", var_40_9)
						arg_37_1:RecordAudio("113111009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_113111", "113111009", "story_v_out_113111.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_113111", "113111009", "story_v_out_113111.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play113111010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 113111010
		arg_41_1.duration_ = 15.43

		local var_41_0 = {
			ja = 13.833,
			ko = 15.433,
			zh = 11.733,
			en = 14.033
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
				arg_41_0:Play113111011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.125

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[36].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:GetWordFromCfg(113111010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111010", "story_v_out_113111.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_113111", "113111010", "story_v_out_113111.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_113111", "113111010", "story_v_out_113111.awb")

						arg_41_1:RecordAudio("113111010", var_44_9)
						arg_41_1:RecordAudio("113111010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_113111", "113111010", "story_v_out_113111.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_113111", "113111010", "story_v_out_113111.awb")
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
	Play113111011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 113111011
		arg_45_1.duration_ = 8.17

		local var_45_0 = {
			ja = 8.166,
			ko = 7.033,
			zh = 7.233,
			en = 6.866
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
				arg_45_0:Play113111012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = "F01"

			if arg_45_1.bgs_[var_48_0] == nil then
				local var_48_1 = Object.Instantiate(arg_45_1.paintGo_)

				var_48_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_48_0)
				var_48_1.name = var_48_0
				var_48_1.transform.parent = arg_45_1.stage_.transform
				var_48_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.bgs_[var_48_0] = var_48_1
			end

			local var_48_2 = 2

			if var_48_2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				local var_48_3 = manager.ui.mainCamera.transform.localPosition
				local var_48_4 = Vector3.New(0, 0, 10) + Vector3.New(var_48_3.x, var_48_3.y, 0)
				local var_48_5 = arg_45_1.bgs_.F01

				var_48_5.transform.localPosition = var_48_4
				var_48_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_6 = var_48_5:GetComponent("SpriteRenderer")

				if var_48_6 and var_48_6.sprite then
					local var_48_7 = (var_48_5.transform.localPosition - var_48_3).z
					local var_48_8 = manager.ui.mainCameraCom_
					local var_48_9 = 2 * var_48_7 * Mathf.Tan(var_48_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_48_10 = var_48_9 * var_48_8.aspect
					local var_48_11 = var_48_6.sprite.bounds.size.x
					local var_48_12 = var_48_6.sprite.bounds.size.y
					local var_48_13 = var_48_10 / var_48_11
					local var_48_14 = var_48_9 / var_48_12
					local var_48_15 = var_48_14 < var_48_13 and var_48_13 or var_48_14

					var_48_5.transform.localScale = Vector3.New(var_48_15, var_48_15, 0)
				end

				for iter_48_0, iter_48_1 in pairs(arg_45_1.bgs_) do
					if iter_48_0 ~= "F01" then
						iter_48_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_17 = 2

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_17 then
				local var_48_18 = (arg_45_1.time_ - var_48_16) / var_48_17
				local var_48_19 = Color.New(0, 0, 0)

				var_48_19.a = Mathf.Lerp(0, 1, var_48_18)
				arg_45_1.mask_.color = var_48_19
			end

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 then
				local var_48_20 = Color.New(0, 0, 0)

				var_48_20.a = 1
				arg_45_1.mask_.color = var_48_20
			end

			local var_48_21 = 2

			if var_48_21 < arg_45_1.time_ and arg_45_1.time_ <= var_48_21 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_22 = 2

			if var_48_21 <= arg_45_1.time_ and arg_45_1.time_ < var_48_21 + var_48_22 then
				local var_48_23 = (arg_45_1.time_ - var_48_21) / var_48_22
				local var_48_24 = Color.New(0, 0, 0)

				var_48_24.a = Mathf.Lerp(1, 0, var_48_23)
				arg_45_1.mask_.color = var_48_24
			end

			if arg_45_1.time_ >= var_48_21 + var_48_22 and arg_45_1.time_ < var_48_21 + var_48_22 + arg_48_0 then
				local var_48_25 = Color.New(0, 0, 0)
				local var_48_26 = 0

				arg_45_1.mask_.enabled = false
				var_48_25.a = var_48_26
				arg_45_1.mask_.color = var_48_25
			end

			local var_48_27 = "6046_story"

			if arg_45_1.actors_[var_48_27] == nil then
				local var_48_28 = Asset.Load("Char/" .. "6046_story")

				if not isNil(var_48_28) then
					local var_48_29 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_45_1.stage_.transform)

					var_48_29.name = var_48_27
					var_48_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_45_1.actors_[var_48_27] = var_48_29

					local var_48_30 = var_48_29:GetComponentInChildren(typeof(CharacterEffect))

					var_48_30.enabled = true

					local var_48_31 = GameObjectTools.GetOrAddComponent(var_48_29, typeof(DynamicBoneHelper))

					if var_48_31 then
						var_48_31:EnableDynamicBone(false)
					end

					arg_45_1:ShowWeapon(var_48_30.transform, false)

					arg_45_1.var_[var_48_27 .. "Animator"] = var_48_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_45_1.var_[var_48_27 .. "Animator"].applyRootMotion = true
					arg_45_1.var_[var_48_27 .. "LipSync"] = var_48_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_48_32 = arg_45_1.actors_["6046_story"].transform
			local var_48_33 = 3.8

			if var_48_33 < arg_45_1.time_ and arg_45_1.time_ <= var_48_33 + arg_48_0 then
				arg_45_1.var_.moveOldPos6046_story = var_48_32.localPosition

				local var_48_34 = GameObjectTools.GetOrAddComponent(var_48_32.gameObject, typeof(DynamicBoneHelper))

				if var_48_34 then
					var_48_34:EnableDynamicBone(false)
				end
			end

			local var_48_35 = 0.001

			if var_48_33 <= arg_45_1.time_ and arg_45_1.time_ < var_48_33 + var_48_35 then
				local var_48_36 = (arg_45_1.time_ - var_48_33) / var_48_35
				local var_48_37 = Vector3.New(-0.7, -0.5, -6.3)

				var_48_32.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos6046_story, var_48_37, var_48_36)

				local var_48_38 = manager.ui.mainCamera.transform.position - var_48_32.position

				var_48_32.forward = Vector3.New(var_48_38.x, var_48_38.y, var_48_38.z)

				local var_48_39 = var_48_32.localEulerAngles

				var_48_39.z = 0
				var_48_39.x = 0
				var_48_32.localEulerAngles = var_48_39
			end

			if arg_45_1.time_ >= var_48_33 + var_48_35 and arg_45_1.time_ < var_48_33 + var_48_35 + arg_48_0 then
				var_48_32.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_48_40 = manager.ui.mainCamera.transform.position - var_48_32.position

				var_48_32.forward = Vector3.New(var_48_40.x, var_48_40.y, var_48_40.z)

				local var_48_41 = var_48_32.localEulerAngles

				var_48_41.z = 0
				var_48_41.x = 0
				var_48_32.localEulerAngles = var_48_41

				local var_48_42 = GameObjectTools.GetOrAddComponent(var_48_32.gameObject, typeof(DynamicBoneHelper))

				if var_48_42 then
					var_48_42:EnableDynamicBone(true)
				end
			end

			local var_48_43 = 3.8

			if var_48_43 < arg_45_1.time_ and arg_45_1.time_ <= var_48_43 + arg_48_0 then
				arg_45_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_1")
			end

			local var_48_44 = 3.8

			if var_48_44 < arg_45_1.time_ and arg_45_1.time_ <= var_48_44 + arg_48_0 then
				arg_45_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_48_45 = arg_45_1.actors_["6046_story"]
			local var_48_46 = 3.8

			if var_48_46 < arg_45_1.time_ and arg_45_1.time_ <= var_48_46 + arg_48_0 and not isNil(var_48_45) and arg_45_1.var_.characterEffect6046_story == nil then
				arg_45_1.var_.characterEffect6046_story = var_48_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_47 = 0.2

			if var_48_46 <= arg_45_1.time_ and arg_45_1.time_ < var_48_46 + var_48_47 and not isNil(var_48_45) then
				local var_48_48 = (arg_45_1.time_ - var_48_46) / var_48_47

				if arg_45_1.var_.characterEffect6046_story and not isNil(var_48_45) then
					arg_45_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_46 + var_48_47 and arg_45_1.time_ < var_48_46 + var_48_47 + arg_48_0 and not isNil(var_48_45) and arg_45_1.var_.characterEffect6046_story then
				arg_45_1.var_.characterEffect6046_story.fillFlat = false
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_49 = 4
			local var_48_50 = 0.325

			if var_48_49 < arg_45_1.time_ and arg_45_1.time_ <= var_48_49 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_51 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_51:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_52 = arg_45_1:FormatText(StoryNameCfg[214].name)

				arg_45_1.leftNameTxt_.text = var_48_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_53 = arg_45_1:GetWordFromCfg(113111011)
				local var_48_54 = arg_45_1:FormatText(var_48_53.content)

				arg_45_1.text_.text = var_48_54

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_55 = 13
				local var_48_56 = utf8.len(var_48_54)
				local var_48_57 = var_48_55 <= 0 and var_48_50 or var_48_50 * (var_48_56 / var_48_55)

				if var_48_57 > 0 and var_48_50 < var_48_57 then
					arg_45_1.talkMaxDuration = var_48_57
					var_48_49 = var_48_49 + 0.3

					if var_48_57 + var_48_49 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_57 + var_48_49
					end
				end

				arg_45_1.text_.text = var_48_54
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111011", "story_v_out_113111.awb") ~= 0 then
					local var_48_58 = manager.audio:GetVoiceLength("story_v_out_113111", "113111011", "story_v_out_113111.awb") / 1000

					if var_48_58 + var_48_49 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_58 + var_48_49
					end

					if var_48_53.prefab_name ~= "" and arg_45_1.actors_[var_48_53.prefab_name] ~= nil then
						local var_48_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_53.prefab_name].transform, "story_v_out_113111", "113111011", "story_v_out_113111.awb")

						arg_45_1:RecordAudio("113111011", var_48_59)
						arg_45_1:RecordAudio("113111011", var_48_59)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_113111", "113111011", "story_v_out_113111.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_113111", "113111011", "story_v_out_113111.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_60 = var_48_49 + 0.3
			local var_48_61 = math.max(var_48_50, arg_45_1.talkMaxDuration)

			if var_48_60 <= arg_45_1.time_ and arg_45_1.time_ < var_48_60 + var_48_61 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_60) / var_48_61

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_60 + var_48_61 and arg_45_1.time_ < var_48_60 + var_48_61 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play113111012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 113111012
		arg_51_1.duration_ = 2.57

		local var_51_0 = {
			ja = 2.3,
			ko = 1.999999999999,
			zh = 2.566,
			en = 1.999999999999
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play113111013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = "6045_story"

			if arg_51_1.actors_[var_54_0] == nil then
				local var_54_1 = Asset.Load("Char/" .. "6045_story")

				if not isNil(var_54_1) then
					local var_54_2 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_51_1.stage_.transform)

					var_54_2.name = var_54_0
					var_54_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_51_1.actors_[var_54_0] = var_54_2

					local var_54_3 = var_54_2:GetComponentInChildren(typeof(CharacterEffect))

					var_54_3.enabled = true

					local var_54_4 = GameObjectTools.GetOrAddComponent(var_54_2, typeof(DynamicBoneHelper))

					if var_54_4 then
						var_54_4:EnableDynamicBone(false)
					end

					arg_51_1:ShowWeapon(var_54_3.transform, false)

					arg_51_1.var_[var_54_0 .. "Animator"] = var_54_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_51_1.var_[var_54_0 .. "Animator"].applyRootMotion = true
					arg_51_1.var_[var_54_0 .. "LipSync"] = var_54_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_54_5 = arg_51_1.actors_["6045_story"].transform
			local var_54_6 = 0

			if var_54_6 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1.var_.moveOldPos6045_story = var_54_5.localPosition

				local var_54_7 = GameObjectTools.GetOrAddComponent(var_54_5.gameObject, typeof(DynamicBoneHelper))

				if var_54_7 then
					var_54_7:EnableDynamicBone(false)
				end
			end

			local var_54_8 = 0.001

			if var_54_6 <= arg_51_1.time_ and arg_51_1.time_ < var_54_6 + var_54_8 then
				local var_54_9 = (arg_51_1.time_ - var_54_6) / var_54_8
				local var_54_10 = Vector3.New(0.7, -0.5, -6.3)

				var_54_5.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos6045_story, var_54_10, var_54_9)

				local var_54_11 = manager.ui.mainCamera.transform.position - var_54_5.position

				var_54_5.forward = Vector3.New(var_54_11.x, var_54_11.y, var_54_11.z)

				local var_54_12 = var_54_5.localEulerAngles

				var_54_12.z = 0
				var_54_12.x = 0
				var_54_5.localEulerAngles = var_54_12
			end

			if arg_51_1.time_ >= var_54_6 + var_54_8 and arg_51_1.time_ < var_54_6 + var_54_8 + arg_54_0 then
				var_54_5.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_54_13 = manager.ui.mainCamera.transform.position - var_54_5.position

				var_54_5.forward = Vector3.New(var_54_13.x, var_54_13.y, var_54_13.z)

				local var_54_14 = var_54_5.localEulerAngles

				var_54_14.z = 0
				var_54_14.x = 0
				var_54_5.localEulerAngles = var_54_14

				local var_54_15 = GameObjectTools.GetOrAddComponent(var_54_5.gameObject, typeof(DynamicBoneHelper))

				if var_54_15 then
					var_54_15:EnableDynamicBone(true)
				end
			end

			local var_54_16 = 0

			if var_54_16 < arg_51_1.time_ and arg_51_1.time_ <= var_54_16 + arg_54_0 then
				arg_51_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_54_17 = 0

			if var_54_17 < arg_51_1.time_ and arg_51_1.time_ <= var_54_17 + arg_54_0 then
				arg_51_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_54_18 = arg_51_1.actors_["6045_story"]
			local var_54_19 = 0

			if var_54_19 < arg_51_1.time_ and arg_51_1.time_ <= var_54_19 + arg_54_0 and not isNil(var_54_18) and arg_51_1.var_.characterEffect6045_story == nil then
				arg_51_1.var_.characterEffect6045_story = var_54_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_20 = 0.2

			if var_54_19 <= arg_51_1.time_ and arg_51_1.time_ < var_54_19 + var_54_20 and not isNil(var_54_18) then
				local var_54_21 = (arg_51_1.time_ - var_54_19) / var_54_20

				if arg_51_1.var_.characterEffect6045_story and not isNil(var_54_18) then
					arg_51_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_19 + var_54_20 and arg_51_1.time_ < var_54_19 + var_54_20 + arg_54_0 and not isNil(var_54_18) and arg_51_1.var_.characterEffect6045_story then
				arg_51_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_54_22 = arg_51_1.actors_["6046_story"]
			local var_54_23 = 0

			if var_54_23 < arg_51_1.time_ and arg_51_1.time_ <= var_54_23 + arg_54_0 and not isNil(var_54_22) and arg_51_1.var_.characterEffect6046_story == nil then
				arg_51_1.var_.characterEffect6046_story = var_54_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_24 = 0.2

			if var_54_23 <= arg_51_1.time_ and arg_51_1.time_ < var_54_23 + var_54_24 and not isNil(var_54_22) then
				local var_54_25 = (arg_51_1.time_ - var_54_23) / var_54_24

				if arg_51_1.var_.characterEffect6046_story and not isNil(var_54_22) then
					local var_54_26 = Mathf.Lerp(0, 0.5, var_54_25)

					arg_51_1.var_.characterEffect6046_story.fillFlat = true
					arg_51_1.var_.characterEffect6046_story.fillRatio = var_54_26
				end
			end

			if arg_51_1.time_ >= var_54_23 + var_54_24 and arg_51_1.time_ < var_54_23 + var_54_24 + arg_54_0 and not isNil(var_54_22) and arg_51_1.var_.characterEffect6046_story then
				local var_54_27 = 0.5

				arg_51_1.var_.characterEffect6046_story.fillFlat = true
				arg_51_1.var_.characterEffect6046_story.fillRatio = var_54_27
			end

			local var_54_28 = 0
			local var_54_29 = 0.175

			if var_54_28 < arg_51_1.time_ and arg_51_1.time_ <= var_54_28 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_30 = arg_51_1:FormatText(StoryNameCfg[215].name)

				arg_51_1.leftNameTxt_.text = var_54_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_31 = arg_51_1:GetWordFromCfg(113111012)
				local var_54_32 = arg_51_1:FormatText(var_54_31.content)

				arg_51_1.text_.text = var_54_32

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_33 = 7
				local var_54_34 = utf8.len(var_54_32)
				local var_54_35 = var_54_33 <= 0 and var_54_29 or var_54_29 * (var_54_34 / var_54_33)

				if var_54_35 > 0 and var_54_29 < var_54_35 then
					arg_51_1.talkMaxDuration = var_54_35

					if var_54_35 + var_54_28 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_35 + var_54_28
					end
				end

				arg_51_1.text_.text = var_54_32
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111012", "story_v_out_113111.awb") ~= 0 then
					local var_54_36 = manager.audio:GetVoiceLength("story_v_out_113111", "113111012", "story_v_out_113111.awb") / 1000

					if var_54_36 + var_54_28 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_36 + var_54_28
					end

					if var_54_31.prefab_name ~= "" and arg_51_1.actors_[var_54_31.prefab_name] ~= nil then
						local var_54_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_31.prefab_name].transform, "story_v_out_113111", "113111012", "story_v_out_113111.awb")

						arg_51_1:RecordAudio("113111012", var_54_37)
						arg_51_1:RecordAudio("113111012", var_54_37)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_113111", "113111012", "story_v_out_113111.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_113111", "113111012", "story_v_out_113111.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_38 = math.max(var_54_29, arg_51_1.talkMaxDuration)

			if var_54_28 <= arg_51_1.time_ and arg_51_1.time_ < var_54_28 + var_54_38 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_28) / var_54_38

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_28 + var_54_38 and arg_51_1.time_ < var_54_28 + var_54_38 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play113111013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 113111013
		arg_55_1.duration_ = 6.83

		local var_55_0 = {
			ja = 5.533,
			ko = 6.7,
			zh = 6.833,
			en = 6
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
				arg_55_0:Play113111014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_58_1 = arg_55_1.actors_["6046_story"]
			local var_58_2 = 0

			if var_58_2 < arg_55_1.time_ and arg_55_1.time_ <= var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect6046_story == nil then
				arg_55_1.var_.characterEffect6046_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_3 = 0.2

			if var_58_2 <= arg_55_1.time_ and arg_55_1.time_ < var_58_2 + var_58_3 and not isNil(var_58_1) then
				local var_58_4 = (arg_55_1.time_ - var_58_2) / var_58_3

				if arg_55_1.var_.characterEffect6046_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_2 + var_58_3 and arg_55_1.time_ < var_58_2 + var_58_3 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect6046_story then
				arg_55_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_58_5 = 0

			if var_58_5 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 then
				arg_55_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_2")
			end

			local var_58_6 = arg_55_1.actors_["6045_story"]
			local var_58_7 = 0

			if var_58_7 < arg_55_1.time_ and arg_55_1.time_ <= var_58_7 + arg_58_0 and not isNil(var_58_6) and arg_55_1.var_.characterEffect6045_story == nil then
				arg_55_1.var_.characterEffect6045_story = var_58_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_8 = 0.2

			if var_58_7 <= arg_55_1.time_ and arg_55_1.time_ < var_58_7 + var_58_8 and not isNil(var_58_6) then
				local var_58_9 = (arg_55_1.time_ - var_58_7) / var_58_8

				if arg_55_1.var_.characterEffect6045_story and not isNil(var_58_6) then
					local var_58_10 = Mathf.Lerp(0, 0.5, var_58_9)

					arg_55_1.var_.characterEffect6045_story.fillFlat = true
					arg_55_1.var_.characterEffect6045_story.fillRatio = var_58_10
				end
			end

			if arg_55_1.time_ >= var_58_7 + var_58_8 and arg_55_1.time_ < var_58_7 + var_58_8 + arg_58_0 and not isNil(var_58_6) and arg_55_1.var_.characterEffect6045_story then
				local var_58_11 = 0.5

				arg_55_1.var_.characterEffect6045_story.fillFlat = true
				arg_55_1.var_.characterEffect6045_story.fillRatio = var_58_11
			end

			local var_58_12 = 0
			local var_58_13 = 0.55

			if var_58_12 < arg_55_1.time_ and arg_55_1.time_ <= var_58_12 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_14 = arg_55_1:FormatText(StoryNameCfg[214].name)

				arg_55_1.leftNameTxt_.text = var_58_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_15 = arg_55_1:GetWordFromCfg(113111013)
				local var_58_16 = arg_55_1:FormatText(var_58_15.content)

				arg_55_1.text_.text = var_58_16

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_17 = 22
				local var_58_18 = utf8.len(var_58_16)
				local var_58_19 = var_58_17 <= 0 and var_58_13 or var_58_13 * (var_58_18 / var_58_17)

				if var_58_19 > 0 and var_58_13 < var_58_19 then
					arg_55_1.talkMaxDuration = var_58_19

					if var_58_19 + var_58_12 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_19 + var_58_12
					end
				end

				arg_55_1.text_.text = var_58_16
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111013", "story_v_out_113111.awb") ~= 0 then
					local var_58_20 = manager.audio:GetVoiceLength("story_v_out_113111", "113111013", "story_v_out_113111.awb") / 1000

					if var_58_20 + var_58_12 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_20 + var_58_12
					end

					if var_58_15.prefab_name ~= "" and arg_55_1.actors_[var_58_15.prefab_name] ~= nil then
						local var_58_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_15.prefab_name].transform, "story_v_out_113111", "113111013", "story_v_out_113111.awb")

						arg_55_1:RecordAudio("113111013", var_58_21)
						arg_55_1:RecordAudio("113111013", var_58_21)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_113111", "113111013", "story_v_out_113111.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_113111", "113111013", "story_v_out_113111.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_22 = math.max(var_58_13, arg_55_1.talkMaxDuration)

			if var_58_12 <= arg_55_1.time_ and arg_55_1.time_ < var_58_12 + var_58_22 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_12) / var_58_22

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_12 + var_58_22 and arg_55_1.time_ < var_58_12 + var_58_22 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play113111014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 113111014
		arg_59_1.duration_ = 3.4

		local var_59_0 = {
			ja = 2.433,
			ko = 2.8,
			zh = 3.4,
			en = 2.933
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
				arg_59_0:Play113111015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_2")
			end

			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_62_2 = arg_59_1.actors_["6045_story"]
			local var_62_3 = 0

			if var_62_3 < arg_59_1.time_ and arg_59_1.time_ <= var_62_3 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.characterEffect6045_story == nil then
				arg_59_1.var_.characterEffect6045_story = var_62_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_4 = 0.2

			if var_62_3 <= arg_59_1.time_ and arg_59_1.time_ < var_62_3 + var_62_4 and not isNil(var_62_2) then
				local var_62_5 = (arg_59_1.time_ - var_62_3) / var_62_4

				if arg_59_1.var_.characterEffect6045_story and not isNil(var_62_2) then
					arg_59_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_3 + var_62_4 and arg_59_1.time_ < var_62_3 + var_62_4 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.characterEffect6045_story then
				arg_59_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_62_6 = arg_59_1.actors_["6046_story"]
			local var_62_7 = 0

			if var_62_7 < arg_59_1.time_ and arg_59_1.time_ <= var_62_7 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect6046_story == nil then
				arg_59_1.var_.characterEffect6046_story = var_62_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_8 = 0.2

			if var_62_7 <= arg_59_1.time_ and arg_59_1.time_ < var_62_7 + var_62_8 and not isNil(var_62_6) then
				local var_62_9 = (arg_59_1.time_ - var_62_7) / var_62_8

				if arg_59_1.var_.characterEffect6046_story and not isNil(var_62_6) then
					local var_62_10 = Mathf.Lerp(0, 0.5, var_62_9)

					arg_59_1.var_.characterEffect6046_story.fillFlat = true
					arg_59_1.var_.characterEffect6046_story.fillRatio = var_62_10
				end
			end

			if arg_59_1.time_ >= var_62_7 + var_62_8 and arg_59_1.time_ < var_62_7 + var_62_8 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect6046_story then
				local var_62_11 = 0.5

				arg_59_1.var_.characterEffect6046_story.fillFlat = true
				arg_59_1.var_.characterEffect6046_story.fillRatio = var_62_11
			end

			local var_62_12 = 0
			local var_62_13 = 0.2

			if var_62_12 < arg_59_1.time_ and arg_59_1.time_ <= var_62_12 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_14 = arg_59_1:FormatText(StoryNameCfg[215].name)

				arg_59_1.leftNameTxt_.text = var_62_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_15 = arg_59_1:GetWordFromCfg(113111014)
				local var_62_16 = arg_59_1:FormatText(var_62_15.content)

				arg_59_1.text_.text = var_62_16

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_17 = 8
				local var_62_18 = utf8.len(var_62_16)
				local var_62_19 = var_62_17 <= 0 and var_62_13 or var_62_13 * (var_62_18 / var_62_17)

				if var_62_19 > 0 and var_62_13 < var_62_19 then
					arg_59_1.talkMaxDuration = var_62_19

					if var_62_19 + var_62_12 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_19 + var_62_12
					end
				end

				arg_59_1.text_.text = var_62_16
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111014", "story_v_out_113111.awb") ~= 0 then
					local var_62_20 = manager.audio:GetVoiceLength("story_v_out_113111", "113111014", "story_v_out_113111.awb") / 1000

					if var_62_20 + var_62_12 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_20 + var_62_12
					end

					if var_62_15.prefab_name ~= "" and arg_59_1.actors_[var_62_15.prefab_name] ~= nil then
						local var_62_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_15.prefab_name].transform, "story_v_out_113111", "113111014", "story_v_out_113111.awb")

						arg_59_1:RecordAudio("113111014", var_62_21)
						arg_59_1:RecordAudio("113111014", var_62_21)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_113111", "113111014", "story_v_out_113111.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_113111", "113111014", "story_v_out_113111.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_22 = math.max(var_62_13, arg_59_1.talkMaxDuration)

			if var_62_12 <= arg_59_1.time_ and arg_59_1.time_ < var_62_12 + var_62_22 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_12) / var_62_22

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_12 + var_62_22 and arg_59_1.time_ < var_62_12 + var_62_22 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play113111015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 113111015
		arg_63_1.duration_ = 15.33

		local var_63_0 = {
			ja = 7.733,
			ko = 11.333,
			zh = 15.333,
			en = 9.033
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
				arg_63_0:Play113111016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_66_1 = arg_63_1.actors_["6046_story"]
			local var_66_2 = 0

			if var_66_2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect6046_story == nil then
				arg_63_1.var_.characterEffect6046_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_3 = 0.2

			if var_66_2 <= arg_63_1.time_ and arg_63_1.time_ < var_66_2 + var_66_3 and not isNil(var_66_1) then
				local var_66_4 = (arg_63_1.time_ - var_66_2) / var_66_3

				if arg_63_1.var_.characterEffect6046_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_2 + var_66_3 and arg_63_1.time_ < var_66_2 + var_66_3 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect6046_story then
				arg_63_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_66_5 = 0

			if var_66_5 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_66_6 = arg_63_1.actors_["6045_story"]
			local var_66_7 = 0

			if var_66_7 < arg_63_1.time_ and arg_63_1.time_ <= var_66_7 + arg_66_0 and not isNil(var_66_6) and arg_63_1.var_.characterEffect6045_story == nil then
				arg_63_1.var_.characterEffect6045_story = var_66_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_8 = 0.2

			if var_66_7 <= arg_63_1.time_ and arg_63_1.time_ < var_66_7 + var_66_8 and not isNil(var_66_6) then
				local var_66_9 = (arg_63_1.time_ - var_66_7) / var_66_8

				if arg_63_1.var_.characterEffect6045_story and not isNil(var_66_6) then
					local var_66_10 = Mathf.Lerp(0, 0.5, var_66_9)

					arg_63_1.var_.characterEffect6045_story.fillFlat = true
					arg_63_1.var_.characterEffect6045_story.fillRatio = var_66_10
				end
			end

			if arg_63_1.time_ >= var_66_7 + var_66_8 and arg_63_1.time_ < var_66_7 + var_66_8 + arg_66_0 and not isNil(var_66_6) and arg_63_1.var_.characterEffect6045_story then
				local var_66_11 = 0.5

				arg_63_1.var_.characterEffect6045_story.fillFlat = true
				arg_63_1.var_.characterEffect6045_story.fillRatio = var_66_11
			end

			local var_66_12 = 0
			local var_66_13 = 1.4

			if var_66_12 < arg_63_1.time_ and arg_63_1.time_ <= var_66_12 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_14 = arg_63_1:FormatText(StoryNameCfg[214].name)

				arg_63_1.leftNameTxt_.text = var_66_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_15 = arg_63_1:GetWordFromCfg(113111015)
				local var_66_16 = arg_63_1:FormatText(var_66_15.content)

				arg_63_1.text_.text = var_66_16

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_17 = 56
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

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111015", "story_v_out_113111.awb") ~= 0 then
					local var_66_20 = manager.audio:GetVoiceLength("story_v_out_113111", "113111015", "story_v_out_113111.awb") / 1000

					if var_66_20 + var_66_12 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_20 + var_66_12
					end

					if var_66_15.prefab_name ~= "" and arg_63_1.actors_[var_66_15.prefab_name] ~= nil then
						local var_66_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_15.prefab_name].transform, "story_v_out_113111", "113111015", "story_v_out_113111.awb")

						arg_63_1:RecordAudio("113111015", var_66_21)
						arg_63_1:RecordAudio("113111015", var_66_21)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_113111", "113111015", "story_v_out_113111.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_113111", "113111015", "story_v_out_113111.awb")
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
	Play113111016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 113111016
		arg_67_1.duration_ = 4.53

		local var_67_0 = {
			ja = 4.533,
			ko = 3.266,
			zh = 4.3,
			en = 4.166
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
				arg_67_0:Play113111017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action2_1")
			end

			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_70_2 = arg_67_1.actors_["6045_story"]
			local var_70_3 = 0

			if var_70_3 < arg_67_1.time_ and arg_67_1.time_ <= var_70_3 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.characterEffect6045_story == nil then
				arg_67_1.var_.characterEffect6045_story = var_70_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_4 = 0.2

			if var_70_3 <= arg_67_1.time_ and arg_67_1.time_ < var_70_3 + var_70_4 and not isNil(var_70_2) then
				local var_70_5 = (arg_67_1.time_ - var_70_3) / var_70_4

				if arg_67_1.var_.characterEffect6045_story and not isNil(var_70_2) then
					arg_67_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_3 + var_70_4 and arg_67_1.time_ < var_70_3 + var_70_4 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.characterEffect6045_story then
				arg_67_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_70_6 = arg_67_1.actors_["6046_story"]
			local var_70_7 = 0

			if var_70_7 < arg_67_1.time_ and arg_67_1.time_ <= var_70_7 + arg_70_0 and not isNil(var_70_6) and arg_67_1.var_.characterEffect6046_story == nil then
				arg_67_1.var_.characterEffect6046_story = var_70_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_8 = 0.2

			if var_70_7 <= arg_67_1.time_ and arg_67_1.time_ < var_70_7 + var_70_8 and not isNil(var_70_6) then
				local var_70_9 = (arg_67_1.time_ - var_70_7) / var_70_8

				if arg_67_1.var_.characterEffect6046_story and not isNil(var_70_6) then
					local var_70_10 = Mathf.Lerp(0, 0.5, var_70_9)

					arg_67_1.var_.characterEffect6046_story.fillFlat = true
					arg_67_1.var_.characterEffect6046_story.fillRatio = var_70_10
				end
			end

			if arg_67_1.time_ >= var_70_7 + var_70_8 and arg_67_1.time_ < var_70_7 + var_70_8 + arg_70_0 and not isNil(var_70_6) and arg_67_1.var_.characterEffect6046_story then
				local var_70_11 = 0.5

				arg_67_1.var_.characterEffect6046_story.fillFlat = true
				arg_67_1.var_.characterEffect6046_story.fillRatio = var_70_11
			end

			local var_70_12 = 0
			local var_70_13 = 0.35

			if var_70_12 < arg_67_1.time_ and arg_67_1.time_ <= var_70_12 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_14 = arg_67_1:FormatText(StoryNameCfg[215].name)

				arg_67_1.leftNameTxt_.text = var_70_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_15 = arg_67_1:GetWordFromCfg(113111016)
				local var_70_16 = arg_67_1:FormatText(var_70_15.content)

				arg_67_1.text_.text = var_70_16

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_17 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111016", "story_v_out_113111.awb") ~= 0 then
					local var_70_20 = manager.audio:GetVoiceLength("story_v_out_113111", "113111016", "story_v_out_113111.awb") / 1000

					if var_70_20 + var_70_12 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_20 + var_70_12
					end

					if var_70_15.prefab_name ~= "" and arg_67_1.actors_[var_70_15.prefab_name] ~= nil then
						local var_70_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_15.prefab_name].transform, "story_v_out_113111", "113111016", "story_v_out_113111.awb")

						arg_67_1:RecordAudio("113111016", var_70_21)
						arg_67_1:RecordAudio("113111016", var_70_21)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_113111", "113111016", "story_v_out_113111.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_113111", "113111016", "story_v_out_113111.awb")
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
	Play113111017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 113111017
		arg_71_1.duration_ = 4.87

		local var_71_0 = {
			ja = 4.866,
			ko = 3.566,
			zh = 4.2,
			en = 3.666
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
				arg_71_0:Play113111018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_74_1 = arg_71_1.actors_["6046_story"]
			local var_74_2 = 0

			if var_74_2 < arg_71_1.time_ and arg_71_1.time_ <= var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect6046_story == nil then
				arg_71_1.var_.characterEffect6046_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_3 = 0.2

			if var_74_2 <= arg_71_1.time_ and arg_71_1.time_ < var_74_2 + var_74_3 and not isNil(var_74_1) then
				local var_74_4 = (arg_71_1.time_ - var_74_2) / var_74_3

				if arg_71_1.var_.characterEffect6046_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_2 + var_74_3 and arg_71_1.time_ < var_74_2 + var_74_3 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect6046_story then
				arg_71_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_74_5 = 0

			if var_74_5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046actionlink/6046action445")
			end

			local var_74_6 = arg_71_1.actors_["6045_story"]
			local var_74_7 = 0

			if var_74_7 < arg_71_1.time_ and arg_71_1.time_ <= var_74_7 + arg_74_0 and not isNil(var_74_6) and arg_71_1.var_.characterEffect6045_story == nil then
				arg_71_1.var_.characterEffect6045_story = var_74_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_8 = 0.2

			if var_74_7 <= arg_71_1.time_ and arg_71_1.time_ < var_74_7 + var_74_8 and not isNil(var_74_6) then
				local var_74_9 = (arg_71_1.time_ - var_74_7) / var_74_8

				if arg_71_1.var_.characterEffect6045_story and not isNil(var_74_6) then
					local var_74_10 = Mathf.Lerp(0, 0.5, var_74_9)

					arg_71_1.var_.characterEffect6045_story.fillFlat = true
					arg_71_1.var_.characterEffect6045_story.fillRatio = var_74_10
				end
			end

			if arg_71_1.time_ >= var_74_7 + var_74_8 and arg_71_1.time_ < var_74_7 + var_74_8 + arg_74_0 and not isNil(var_74_6) and arg_71_1.var_.characterEffect6045_story then
				local var_74_11 = 0.5

				arg_71_1.var_.characterEffect6045_story.fillFlat = true
				arg_71_1.var_.characterEffect6045_story.fillRatio = var_74_11
			end

			local var_74_12 = 0
			local var_74_13 = 0.35

			if var_74_12 < arg_71_1.time_ and arg_71_1.time_ <= var_74_12 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_14 = arg_71_1:FormatText(StoryNameCfg[214].name)

				arg_71_1.leftNameTxt_.text = var_74_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_15 = arg_71_1:GetWordFromCfg(113111017)
				local var_74_16 = arg_71_1:FormatText(var_74_15.content)

				arg_71_1.text_.text = var_74_16

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_17 = 14
				local var_74_18 = utf8.len(var_74_16)
				local var_74_19 = var_74_17 <= 0 and var_74_13 or var_74_13 * (var_74_18 / var_74_17)

				if var_74_19 > 0 and var_74_13 < var_74_19 then
					arg_71_1.talkMaxDuration = var_74_19

					if var_74_19 + var_74_12 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_19 + var_74_12
					end
				end

				arg_71_1.text_.text = var_74_16
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111017", "story_v_out_113111.awb") ~= 0 then
					local var_74_20 = manager.audio:GetVoiceLength("story_v_out_113111", "113111017", "story_v_out_113111.awb") / 1000

					if var_74_20 + var_74_12 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_20 + var_74_12
					end

					if var_74_15.prefab_name ~= "" and arg_71_1.actors_[var_74_15.prefab_name] ~= nil then
						local var_74_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_15.prefab_name].transform, "story_v_out_113111", "113111017", "story_v_out_113111.awb")

						arg_71_1:RecordAudio("113111017", var_74_21)
						arg_71_1:RecordAudio("113111017", var_74_21)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_113111", "113111017", "story_v_out_113111.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_113111", "113111017", "story_v_out_113111.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_22 = math.max(var_74_13, arg_71_1.talkMaxDuration)

			if var_74_12 <= arg_71_1.time_ and arg_71_1.time_ < var_74_12 + var_74_22 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_12) / var_74_22

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_12 + var_74_22 and arg_71_1.time_ < var_74_12 + var_74_22 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play113111018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 113111018
		arg_75_1.duration_ = 2.33

		local var_75_0 = {
			ja = 1.999999999999,
			ko = 2.333,
			zh = 2.233,
			en = 2.2
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
				arg_75_0:Play113111019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action2_2")
			end

			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_78_2 = arg_75_1.actors_["6045_story"]
			local var_78_3 = 0

			if var_78_3 < arg_75_1.time_ and arg_75_1.time_ <= var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.characterEffect6045_story == nil then
				arg_75_1.var_.characterEffect6045_story = var_78_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_4 = 0.2

			if var_78_3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_3 + var_78_4 and not isNil(var_78_2) then
				local var_78_5 = (arg_75_1.time_ - var_78_3) / var_78_4

				if arg_75_1.var_.characterEffect6045_story and not isNil(var_78_2) then
					arg_75_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_3 + var_78_4 and arg_75_1.time_ < var_78_3 + var_78_4 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.characterEffect6045_story then
				arg_75_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_78_6 = arg_75_1.actors_["6046_story"]
			local var_78_7 = 0

			if var_78_7 < arg_75_1.time_ and arg_75_1.time_ <= var_78_7 + arg_78_0 and not isNil(var_78_6) and arg_75_1.var_.characterEffect6046_story == nil then
				arg_75_1.var_.characterEffect6046_story = var_78_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_8 = 0.2

			if var_78_7 <= arg_75_1.time_ and arg_75_1.time_ < var_78_7 + var_78_8 and not isNil(var_78_6) then
				local var_78_9 = (arg_75_1.time_ - var_78_7) / var_78_8

				if arg_75_1.var_.characterEffect6046_story and not isNil(var_78_6) then
					local var_78_10 = Mathf.Lerp(0, 0.5, var_78_9)

					arg_75_1.var_.characterEffect6046_story.fillFlat = true
					arg_75_1.var_.characterEffect6046_story.fillRatio = var_78_10
				end
			end

			if arg_75_1.time_ >= var_78_7 + var_78_8 and arg_75_1.time_ < var_78_7 + var_78_8 + arg_78_0 and not isNil(var_78_6) and arg_75_1.var_.characterEffect6046_story then
				local var_78_11 = 0.5

				arg_75_1.var_.characterEffect6046_story.fillFlat = true
				arg_75_1.var_.characterEffect6046_story.fillRatio = var_78_11
			end

			local var_78_12 = 0
			local var_78_13 = 0.15

			if var_78_12 < arg_75_1.time_ and arg_75_1.time_ <= var_78_12 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_14 = arg_75_1:FormatText(StoryNameCfg[215].name)

				arg_75_1.leftNameTxt_.text = var_78_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_15 = arg_75_1:GetWordFromCfg(113111018)
				local var_78_16 = arg_75_1:FormatText(var_78_15.content)

				arg_75_1.text_.text = var_78_16

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_17 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111018", "story_v_out_113111.awb") ~= 0 then
					local var_78_20 = manager.audio:GetVoiceLength("story_v_out_113111", "113111018", "story_v_out_113111.awb") / 1000

					if var_78_20 + var_78_12 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_20 + var_78_12
					end

					if var_78_15.prefab_name ~= "" and arg_75_1.actors_[var_78_15.prefab_name] ~= nil then
						local var_78_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_15.prefab_name].transform, "story_v_out_113111", "113111018", "story_v_out_113111.awb")

						arg_75_1:RecordAudio("113111018", var_78_21)
						arg_75_1:RecordAudio("113111018", var_78_21)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_113111", "113111018", "story_v_out_113111.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_113111", "113111018", "story_v_out_113111.awb")
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
	Play113111019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 113111019
		arg_79_1.duration_ = 9

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play113111020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_1 = 2

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_1 then
				local var_82_2 = (arg_79_1.time_ - var_82_0) / var_82_1
				local var_82_3 = Color.New(0, 0, 0)

				var_82_3.a = Mathf.Lerp(0, 1, var_82_2)
				arg_79_1.mask_.color = var_82_3
			end

			if arg_79_1.time_ >= var_82_0 + var_82_1 and arg_79_1.time_ < var_82_0 + var_82_1 + arg_82_0 then
				local var_82_4 = Color.New(0, 0, 0)

				var_82_4.a = 1
				arg_79_1.mask_.color = var_82_4
			end

			local var_82_5 = 2

			if var_82_5 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_6 = 2

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_6 then
				local var_82_7 = (arg_79_1.time_ - var_82_5) / var_82_6
				local var_82_8 = Color.New(0, 0, 0)

				var_82_8.a = Mathf.Lerp(1, 0, var_82_7)
				arg_79_1.mask_.color = var_82_8
			end

			if arg_79_1.time_ >= var_82_5 + var_82_6 and arg_79_1.time_ < var_82_5 + var_82_6 + arg_82_0 then
				local var_82_9 = Color.New(0, 0, 0)
				local var_82_10 = 0

				arg_79_1.mask_.enabled = false
				var_82_9.a = var_82_10
				arg_79_1.mask_.color = var_82_9
			end

			local var_82_11 = 2

			if var_82_11 < arg_79_1.time_ and arg_79_1.time_ <= var_82_11 + arg_82_0 then
				local var_82_12 = manager.ui.mainCamera.transform.localPosition
				local var_82_13 = Vector3.New(0, 0, 10) + Vector3.New(var_82_12.x, var_82_12.y, 0)
				local var_82_14 = arg_79_1.bgs_.F02_1

				var_82_14.transform.localPosition = var_82_13
				var_82_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_82_15 = var_82_14:GetComponent("SpriteRenderer")

				if var_82_15 and var_82_15.sprite then
					local var_82_16 = (var_82_14.transform.localPosition - var_82_12).z
					local var_82_17 = manager.ui.mainCameraCom_
					local var_82_18 = 2 * var_82_16 * Mathf.Tan(var_82_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_82_19 = var_82_18 * var_82_17.aspect
					local var_82_20 = var_82_15.sprite.bounds.size.x
					local var_82_21 = var_82_15.sprite.bounds.size.y
					local var_82_22 = var_82_19 / var_82_20
					local var_82_23 = var_82_18 / var_82_21
					local var_82_24 = var_82_23 < var_82_22 and var_82_22 or var_82_23

					var_82_14.transform.localScale = Vector3.New(var_82_24, var_82_24, 0)
				end

				for iter_82_0, iter_82_1 in pairs(arg_79_1.bgs_) do
					if iter_82_0 ~= "F02_1" then
						iter_82_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_82_25 = arg_79_1.actors_["6046_story"].transform
			local var_82_26 = 1.966

			if var_82_26 < arg_79_1.time_ and arg_79_1.time_ <= var_82_26 + arg_82_0 then
				arg_79_1.var_.moveOldPos6046_story = var_82_25.localPosition

				local var_82_27 = GameObjectTools.GetOrAddComponent(var_82_25.gameObject, typeof(DynamicBoneHelper))

				if var_82_27 then
					var_82_27:EnableDynamicBone(false)
				end
			end

			local var_82_28 = 0.001

			if var_82_26 <= arg_79_1.time_ and arg_79_1.time_ < var_82_26 + var_82_28 then
				local var_82_29 = (arg_79_1.time_ - var_82_26) / var_82_28
				local var_82_30 = Vector3.New(0, 100, 0)

				var_82_25.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos6046_story, var_82_30, var_82_29)

				local var_82_31 = manager.ui.mainCamera.transform.position - var_82_25.position

				var_82_25.forward = Vector3.New(var_82_31.x, var_82_31.y, var_82_31.z)

				local var_82_32 = var_82_25.localEulerAngles

				var_82_32.z = 0
				var_82_32.x = 0
				var_82_25.localEulerAngles = var_82_32
			end

			if arg_79_1.time_ >= var_82_26 + var_82_28 and arg_79_1.time_ < var_82_26 + var_82_28 + arg_82_0 then
				var_82_25.localPosition = Vector3.New(0, 100, 0)

				local var_82_33 = manager.ui.mainCamera.transform.position - var_82_25.position

				var_82_25.forward = Vector3.New(var_82_33.x, var_82_33.y, var_82_33.z)

				local var_82_34 = var_82_25.localEulerAngles

				var_82_34.z = 0
				var_82_34.x = 0
				var_82_25.localEulerAngles = var_82_34

				local var_82_35 = GameObjectTools.GetOrAddComponent(var_82_25.gameObject, typeof(DynamicBoneHelper))

				if var_82_35 then
					var_82_35:EnableDynamicBone(true)
				end
			end

			local var_82_36 = arg_79_1.actors_["6045_story"].transform
			local var_82_37 = 1.966

			if var_82_37 < arg_79_1.time_ and arg_79_1.time_ <= var_82_37 + arg_82_0 then
				arg_79_1.var_.moveOldPos6045_story = var_82_36.localPosition

				local var_82_38 = GameObjectTools.GetOrAddComponent(var_82_36.gameObject, typeof(DynamicBoneHelper))

				if var_82_38 then
					var_82_38:EnableDynamicBone(false)
				end
			end

			local var_82_39 = 0.001

			if var_82_37 <= arg_79_1.time_ and arg_79_1.time_ < var_82_37 + var_82_39 then
				local var_82_40 = (arg_79_1.time_ - var_82_37) / var_82_39
				local var_82_41 = Vector3.New(0, 100, 0)

				var_82_36.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos6045_story, var_82_41, var_82_40)

				local var_82_42 = manager.ui.mainCamera.transform.position - var_82_36.position

				var_82_36.forward = Vector3.New(var_82_42.x, var_82_42.y, var_82_42.z)

				local var_82_43 = var_82_36.localEulerAngles

				var_82_43.z = 0
				var_82_43.x = 0
				var_82_36.localEulerAngles = var_82_43
			end

			if arg_79_1.time_ >= var_82_37 + var_82_39 and arg_79_1.time_ < var_82_37 + var_82_39 + arg_82_0 then
				var_82_36.localPosition = Vector3.New(0, 100, 0)

				local var_82_44 = manager.ui.mainCamera.transform.position - var_82_36.position

				var_82_36.forward = Vector3.New(var_82_44.x, var_82_44.y, var_82_44.z)

				local var_82_45 = var_82_36.localEulerAngles

				var_82_45.z = 0
				var_82_45.x = 0
				var_82_36.localEulerAngles = var_82_45

				local var_82_46 = GameObjectTools.GetOrAddComponent(var_82_36.gameObject, typeof(DynamicBoneHelper))

				if var_82_46 then
					var_82_46:EnableDynamicBone(true)
				end
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_47 = 4
			local var_82_48 = 0.125

			if var_82_47 < arg_79_1.time_ and arg_79_1.time_ <= var_82_47 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_49 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_49:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_50 = arg_79_1:GetWordFromCfg(113111019)
				local var_82_51 = arg_79_1:FormatText(var_82_50.content)

				arg_79_1.text_.text = var_82_51

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_52 = 5
				local var_82_53 = utf8.len(var_82_51)
				local var_82_54 = var_82_52 <= 0 and var_82_48 or var_82_48 * (var_82_53 / var_82_52)

				if var_82_54 > 0 and var_82_48 < var_82_54 then
					arg_79_1.talkMaxDuration = var_82_54
					var_82_47 = var_82_47 + 0.3

					if var_82_54 + var_82_47 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_54 + var_82_47
					end
				end

				arg_79_1.text_.text = var_82_51
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_55 = var_82_47 + 0.3
			local var_82_56 = math.max(var_82_48, arg_79_1.talkMaxDuration)

			if var_82_55 <= arg_79_1.time_ and arg_79_1.time_ < var_82_55 + var_82_56 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_55) / var_82_56

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_55 + var_82_56 and arg_79_1.time_ < var_82_55 + var_82_56 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play113111020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 113111020
		arg_85_1.duration_ = 15.43

		local var_85_0 = {
			ja = 15.433,
			ko = 13.733,
			zh = 13.7,
			en = 14.133
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play113111021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = "10006ui_story"

			if arg_85_1.actors_[var_88_0] == nil then
				local var_88_1 = Asset.Load("Char/" .. "10006ui_story")

				if not isNil(var_88_1) then
					local var_88_2 = Object.Instantiate(Asset.Load("Char/" .. "10006ui_story"), arg_85_1.stage_.transform)

					var_88_2.name = var_88_0
					var_88_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_85_1.actors_[var_88_0] = var_88_2

					local var_88_3 = var_88_2:GetComponentInChildren(typeof(CharacterEffect))

					var_88_3.enabled = true

					local var_88_4 = GameObjectTools.GetOrAddComponent(var_88_2, typeof(DynamicBoneHelper))

					if var_88_4 then
						var_88_4:EnableDynamicBone(false)
					end

					arg_85_1:ShowWeapon(var_88_3.transform, false)

					arg_85_1.var_[var_88_0 .. "Animator"] = var_88_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_85_1.var_[var_88_0 .. "Animator"].applyRootMotion = true
					arg_85_1.var_[var_88_0 .. "LipSync"] = var_88_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_88_5 = arg_85_1.actors_["10006ui_story"].transform
			local var_88_6 = 0

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.var_.moveOldPos10006ui_story = var_88_5.localPosition
			end

			local var_88_7 = 0.001

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_7 then
				local var_88_8 = (arg_85_1.time_ - var_88_6) / var_88_7
				local var_88_9 = Vector3.New(0, -0.98, -5.65)

				var_88_5.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10006ui_story, var_88_9, var_88_8)

				local var_88_10 = manager.ui.mainCamera.transform.position - var_88_5.position

				var_88_5.forward = Vector3.New(var_88_10.x, var_88_10.y, var_88_10.z)

				local var_88_11 = var_88_5.localEulerAngles

				var_88_11.z = 0
				var_88_11.x = 0
				var_88_5.localEulerAngles = var_88_11
			end

			if arg_85_1.time_ >= var_88_6 + var_88_7 and arg_85_1.time_ < var_88_6 + var_88_7 + arg_88_0 then
				var_88_5.localPosition = Vector3.New(0, -0.98, -5.65)

				local var_88_12 = manager.ui.mainCamera.transform.position - var_88_5.position

				var_88_5.forward = Vector3.New(var_88_12.x, var_88_12.y, var_88_12.z)

				local var_88_13 = var_88_5.localEulerAngles

				var_88_13.z = 0
				var_88_13.x = 0
				var_88_5.localEulerAngles = var_88_13
			end

			local var_88_14 = 0

			if var_88_14 < arg_85_1.time_ and arg_85_1.time_ <= var_88_14 + arg_88_0 then
				arg_85_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			local var_88_15 = 0

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_88_16 = arg_85_1.actors_["10006ui_story"]
			local var_88_17 = 0

			if var_88_17 < arg_85_1.time_ and arg_85_1.time_ <= var_88_17 + arg_88_0 and not isNil(var_88_16) and arg_85_1.var_.characterEffect10006ui_story == nil then
				arg_85_1.var_.characterEffect10006ui_story = var_88_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_18 = 0.2

			if var_88_17 <= arg_85_1.time_ and arg_85_1.time_ < var_88_17 + var_88_18 and not isNil(var_88_16) then
				local var_88_19 = (arg_85_1.time_ - var_88_17) / var_88_18

				if arg_85_1.var_.characterEffect10006ui_story and not isNil(var_88_16) then
					arg_85_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_17 + var_88_18 and arg_85_1.time_ < var_88_17 + var_88_18 + arg_88_0 and not isNil(var_88_16) and arg_85_1.var_.characterEffect10006ui_story then
				arg_85_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_88_20 = 0
			local var_88_21 = 1.3

			if var_88_20 < arg_85_1.time_ and arg_85_1.time_ <= var_88_20 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_22 = arg_85_1:FormatText(StoryNameCfg[212].name)

				arg_85_1.leftNameTxt_.text = var_88_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_23 = arg_85_1:GetWordFromCfg(113111020)
				local var_88_24 = arg_85_1:FormatText(var_88_23.content)

				arg_85_1.text_.text = var_88_24

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_25 = 52
				local var_88_26 = utf8.len(var_88_24)
				local var_88_27 = var_88_25 <= 0 and var_88_21 or var_88_21 * (var_88_26 / var_88_25)

				if var_88_27 > 0 and var_88_21 < var_88_27 then
					arg_85_1.talkMaxDuration = var_88_27

					if var_88_27 + var_88_20 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_27 + var_88_20
					end
				end

				arg_85_1.text_.text = var_88_24
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111020", "story_v_out_113111.awb") ~= 0 then
					local var_88_28 = manager.audio:GetVoiceLength("story_v_out_113111", "113111020", "story_v_out_113111.awb") / 1000

					if var_88_28 + var_88_20 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_28 + var_88_20
					end

					if var_88_23.prefab_name ~= "" and arg_85_1.actors_[var_88_23.prefab_name] ~= nil then
						local var_88_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_23.prefab_name].transform, "story_v_out_113111", "113111020", "story_v_out_113111.awb")

						arg_85_1:RecordAudio("113111020", var_88_29)
						arg_85_1:RecordAudio("113111020", var_88_29)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_113111", "113111020", "story_v_out_113111.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_113111", "113111020", "story_v_out_113111.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_30 = math.max(var_88_21, arg_85_1.talkMaxDuration)

			if var_88_20 <= arg_85_1.time_ and arg_85_1.time_ < var_88_20 + var_88_30 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_20) / var_88_30

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_20 + var_88_30 and arg_85_1.time_ < var_88_20 + var_88_30 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play113111021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 113111021
		arg_89_1.duration_ = 9.43

		local var_89_0 = {
			ja = 6.366,
			ko = 8.266,
			zh = 8.9,
			en = 9.433
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
				arg_89_0:Play113111022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = "10006_tpose"

			if arg_89_1.actors_[var_92_0] == nil then
				local var_92_1 = Asset.Load("Char/" .. "10006_tpose")

				if not isNil(var_92_1) then
					local var_92_2 = Object.Instantiate(Asset.Load("Char/" .. "10006_tpose"), arg_89_1.stage_.transform)

					var_92_2.name = var_92_0
					var_92_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_89_1.actors_[var_92_0] = var_92_2

					local var_92_3 = var_92_2:GetComponentInChildren(typeof(CharacterEffect))

					var_92_3.enabled = true

					local var_92_4 = GameObjectTools.GetOrAddComponent(var_92_2, typeof(DynamicBoneHelper))

					if var_92_4 then
						var_92_4:EnableDynamicBone(false)
					end

					arg_89_1:ShowWeapon(var_92_3.transform, false)

					arg_89_1.var_[var_92_0 .. "Animator"] = var_92_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_89_1.var_[var_92_0 .. "Animator"].applyRootMotion = true
					arg_89_1.var_[var_92_0 .. "LipSync"] = var_92_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_92_5 = 0

			if var_92_5 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1:PlayTimeline("10006_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_92_6 = 0
			local var_92_7 = 0.725

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_8 = arg_89_1:FormatText(StoryNameCfg[212].name)

				arg_89_1.leftNameTxt_.text = var_92_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_9 = arg_89_1:GetWordFromCfg(113111021)
				local var_92_10 = arg_89_1:FormatText(var_92_9.content)

				arg_89_1.text_.text = var_92_10

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 29
				local var_92_12 = utf8.len(var_92_10)
				local var_92_13 = var_92_11 <= 0 and var_92_7 or var_92_7 * (var_92_12 / var_92_11)

				if var_92_13 > 0 and var_92_7 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_10
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111021", "story_v_out_113111.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_out_113111", "113111021", "story_v_out_113111.awb") / 1000

					if var_92_14 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_6
					end

					if var_92_9.prefab_name ~= "" and arg_89_1.actors_[var_92_9.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_9.prefab_name].transform, "story_v_out_113111", "113111021", "story_v_out_113111.awb")

						arg_89_1:RecordAudio("113111021", var_92_15)
						arg_89_1:RecordAudio("113111021", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_113111", "113111021", "story_v_out_113111.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_113111", "113111021", "story_v_out_113111.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_16 and arg_89_1.time_ < var_92_6 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play113111022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 113111022
		arg_93_1.duration_ = 1.8

		local var_93_0 = {
			ja = 1.8,
			ko = 1.4,
			zh = 1.566,
			en = 1.333
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play113111023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10006ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10006ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, 100, 0)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10006ui_story, var_96_4, var_96_3)

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

			local var_96_9 = 0
			local var_96_10 = 0.125

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_11 = arg_93_1:FormatText(StoryNameCfg[214].name)

				arg_93_1.leftNameTxt_.text = var_96_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6046")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_12 = arg_93_1:GetWordFromCfg(113111022)
				local var_96_13 = arg_93_1:FormatText(var_96_12.content)

				arg_93_1.text_.text = var_96_13

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_14 = 5
				local var_96_15 = utf8.len(var_96_13)
				local var_96_16 = var_96_14 <= 0 and var_96_10 or var_96_10 * (var_96_15 / var_96_14)

				if var_96_16 > 0 and var_96_10 < var_96_16 then
					arg_93_1.talkMaxDuration = var_96_16

					if var_96_16 + var_96_9 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_9
					end
				end

				arg_93_1.text_.text = var_96_13
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111022", "story_v_out_113111.awb") ~= 0 then
					local var_96_17 = manager.audio:GetVoiceLength("story_v_out_113111", "113111022", "story_v_out_113111.awb") / 1000

					if var_96_17 + var_96_9 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_9
					end

					if var_96_12.prefab_name ~= "" and arg_93_1.actors_[var_96_12.prefab_name] ~= nil then
						local var_96_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_12.prefab_name].transform, "story_v_out_113111", "113111022", "story_v_out_113111.awb")

						arg_93_1:RecordAudio("113111022", var_96_18)
						arg_93_1:RecordAudio("113111022", var_96_18)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_113111", "113111022", "story_v_out_113111.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_113111", "113111022", "story_v_out_113111.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_19 = math.max(var_96_10, arg_93_1.talkMaxDuration)

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_19 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_9) / var_96_19

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_9 + var_96_19 and arg_93_1.time_ < var_96_9 + var_96_19 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play113111023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 113111023
		arg_97_1.duration_ = 2.7

		local var_97_0 = {
			ja = 2.566,
			ko = 1.666,
			zh = 2.033,
			en = 2.7
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play113111024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.3

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[36].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(113111023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 12
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111023", "story_v_out_113111.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_113111", "113111023", "story_v_out_113111.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_113111", "113111023", "story_v_out_113111.awb")

						arg_97_1:RecordAudio("113111023", var_100_9)
						arg_97_1:RecordAudio("113111023", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_113111", "113111023", "story_v_out_113111.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_113111", "113111023", "story_v_out_113111.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play113111024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 113111024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play113111025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = "F02"

			if arg_101_1.bgs_[var_104_0] == nil then
				local var_104_1 = Object.Instantiate(arg_101_1.paintGo_)

				var_104_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_104_0)
				var_104_1.name = var_104_0
				var_104_1.transform.parent = arg_101_1.stage_.transform
				var_104_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.bgs_[var_104_0] = var_104_1
			end

			local var_104_2 = arg_101_1.bgs_.F02.transform
			local var_104_3 = 0

			if var_104_3 < arg_101_1.time_ and arg_101_1.time_ <= var_104_3 + arg_104_0 then
				arg_101_1.var_.shakeOldPosF02 = var_104_2.localPosition
			end

			local var_104_4 = 0.6

			if var_104_3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_3 + var_104_4 then
				local var_104_5 = (arg_101_1.time_ - var_104_3) / 0.066
				local var_104_6, var_104_7 = math.modf(var_104_5)

				var_104_2.localPosition = Vector3.New(var_104_7 * 0.1, var_104_7 * 0.1, var_104_7 * 0.1) + arg_101_1.var_.shakeOldPosF02
			end

			if arg_101_1.time_ >= var_104_3 + var_104_4 and arg_101_1.time_ < var_104_3 + var_104_4 + arg_104_0 then
				var_104_2.localPosition = arg_101_1.var_.shakeOldPosF02
			end

			local var_104_8 = 0

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			local var_104_9 = 0.6

			if arg_101_1.time_ >= var_104_8 + var_104_9 and arg_101_1.time_ < var_104_8 + var_104_9 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end

			local var_104_10 = 0
			local var_104_11 = 0.8

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 then
				local var_104_12 = "play"
				local var_104_13 = "effect"

				arg_101_1:AudioAction(var_104_12, var_104_13, "se_story_10", "se_story_10_burst", "")
			end

			local var_104_14 = 0
			local var_104_15 = 0.1

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_16 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_16:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_17 = arg_101_1:GetWordFromCfg(113111024)
				local var_104_18 = arg_101_1:FormatText(var_104_17.content)

				arg_101_1.text_.text = var_104_18

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_19 = 4
				local var_104_20 = utf8.len(var_104_18)
				local var_104_21 = var_104_19 <= 0 and var_104_15 or var_104_15 * (var_104_20 / var_104_19)

				if var_104_21 > 0 and var_104_15 < var_104_21 then
					arg_101_1.talkMaxDuration = var_104_21
					var_104_14 = var_104_14 + 0.3

					if var_104_21 + var_104_14 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_21 + var_104_14
					end
				end

				arg_101_1.text_.text = var_104_18
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_22 = var_104_14 + 0.3
			local var_104_23 = math.max(var_104_15, arg_101_1.talkMaxDuration)

			if var_104_22 <= arg_101_1.time_ and arg_101_1.time_ < var_104_22 + var_104_23 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_22) / var_104_23

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_22 + var_104_23 and arg_101_1.time_ < var_104_22 + var_104_23 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play113111025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 113111025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play113111026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 1

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				local var_110_2 = "play"
				local var_110_3 = "effect"

				arg_107_1:AudioAction(var_110_2, var_110_3, "se_story_10", "se_story_10_mouse", "")
			end

			local var_110_4 = 0
			local var_110_5 = 1.475

			if var_110_4 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(113111025)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_8 = 58
				local var_110_9 = utf8.len(var_110_7)
				local var_110_10 = var_110_8 <= 0 and var_110_5 or var_110_5 * (var_110_9 / var_110_8)

				if var_110_10 > 0 and var_110_5 < var_110_10 then
					arg_107_1.talkMaxDuration = var_110_10

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_11 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_11 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_11

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_11 and arg_107_1.time_ < var_110_4 + var_110_11 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play113111026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 113111026
		arg_111_1.duration_ = 3.8

		local var_111_0 = {
			ja = 3.8,
			ko = 2.1,
			zh = 2.566,
			en = 3.1
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
				arg_111_0:Play113111027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["6046_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos6046_story = var_114_0.localPosition

				local var_114_2 = GameObjectTools.GetOrAddComponent(var_114_0.gameObject, typeof(DynamicBoneHelper))

				if var_114_2 then
					var_114_2:EnableDynamicBone(false)
				end
			end

			local var_114_3 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_3 then
				local var_114_4 = (arg_111_1.time_ - var_114_1) / var_114_3
				local var_114_5 = Vector3.New(0, -0.5, -6.3)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos6046_story, var_114_5, var_114_4)

				local var_114_6 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_6.x, var_114_6.y, var_114_6.z)

				local var_114_7 = var_114_0.localEulerAngles

				var_114_7.z = 0
				var_114_7.x = 0
				var_114_0.localEulerAngles = var_114_7
			end

			if arg_111_1.time_ >= var_114_1 + var_114_3 and arg_111_1.time_ < var_114_1 + var_114_3 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_114_8 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_8.x, var_114_8.y, var_114_8.z)

				local var_114_9 = var_114_0.localEulerAngles

				var_114_9.z = 0
				var_114_9.x = 0
				var_114_0.localEulerAngles = var_114_9

				local var_114_10 = GameObjectTools.GetOrAddComponent(var_114_0.gameObject, typeof(DynamicBoneHelper))

				if var_114_10 then
					var_114_10:EnableDynamicBone(true)
				end
			end

			local var_114_11 = 0

			if var_114_11 < arg_111_1.time_ and arg_111_1.time_ <= var_114_11 + arg_114_0 then
				arg_111_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_114_12 = 0

			if var_114_12 < arg_111_1.time_ and arg_111_1.time_ <= var_114_12 + arg_114_0 then
				arg_111_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_114_13 = arg_111_1.actors_["6046_story"]
			local var_114_14 = 0

			if var_114_14 < arg_111_1.time_ and arg_111_1.time_ <= var_114_14 + arg_114_0 and not isNil(var_114_13) and arg_111_1.var_.characterEffect6046_story == nil then
				arg_111_1.var_.characterEffect6046_story = var_114_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_15 = 0.2

			if var_114_14 <= arg_111_1.time_ and arg_111_1.time_ < var_114_14 + var_114_15 and not isNil(var_114_13) then
				local var_114_16 = (arg_111_1.time_ - var_114_14) / var_114_15

				if arg_111_1.var_.characterEffect6046_story and not isNil(var_114_13) then
					arg_111_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_14 + var_114_15 and arg_111_1.time_ < var_114_14 + var_114_15 + arg_114_0 and not isNil(var_114_13) and arg_111_1.var_.characterEffect6046_story then
				arg_111_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_114_17 = 0
			local var_114_18 = 0.225

			if var_114_17 < arg_111_1.time_ and arg_111_1.time_ <= var_114_17 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_19 = arg_111_1:FormatText(StoryNameCfg[214].name)

				arg_111_1.leftNameTxt_.text = var_114_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_20 = arg_111_1:GetWordFromCfg(113111026)
				local var_114_21 = arg_111_1:FormatText(var_114_20.content)

				arg_111_1.text_.text = var_114_21

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_22 = 8
				local var_114_23 = utf8.len(var_114_21)
				local var_114_24 = var_114_22 <= 0 and var_114_18 or var_114_18 * (var_114_23 / var_114_22)

				if var_114_24 > 0 and var_114_18 < var_114_24 then
					arg_111_1.talkMaxDuration = var_114_24

					if var_114_24 + var_114_17 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_24 + var_114_17
					end
				end

				arg_111_1.text_.text = var_114_21
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111026", "story_v_out_113111.awb") ~= 0 then
					local var_114_25 = manager.audio:GetVoiceLength("story_v_out_113111", "113111026", "story_v_out_113111.awb") / 1000

					if var_114_25 + var_114_17 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_25 + var_114_17
					end

					if var_114_20.prefab_name ~= "" and arg_111_1.actors_[var_114_20.prefab_name] ~= nil then
						local var_114_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_20.prefab_name].transform, "story_v_out_113111", "113111026", "story_v_out_113111.awb")

						arg_111_1:RecordAudio("113111026", var_114_26)
						arg_111_1:RecordAudio("113111026", var_114_26)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_113111", "113111026", "story_v_out_113111.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_113111", "113111026", "story_v_out_113111.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_27 = math.max(var_114_18, arg_111_1.talkMaxDuration)

			if var_114_17 <= arg_111_1.time_ and arg_111_1.time_ < var_114_17 + var_114_27 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_17) / var_114_27

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_17 + var_114_27 and arg_111_1.time_ < var_114_17 + var_114_27 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play113111027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 113111027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play113111028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["6046_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos6046_story = var_118_0.localPosition

				local var_118_2 = GameObjectTools.GetOrAddComponent(var_118_0.gameObject, typeof(DynamicBoneHelper))

				if var_118_2 then
					var_118_2:EnableDynamicBone(false)
				end
			end

			local var_118_3 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_3 then
				local var_118_4 = (arg_115_1.time_ - var_118_1) / var_118_3
				local var_118_5 = Vector3.New(0, 100, 0)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos6046_story, var_118_5, var_118_4)

				local var_118_6 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_6.x, var_118_6.y, var_118_6.z)

				local var_118_7 = var_118_0.localEulerAngles

				var_118_7.z = 0
				var_118_7.x = 0
				var_118_0.localEulerAngles = var_118_7
			end

			if arg_115_1.time_ >= var_118_1 + var_118_3 and arg_115_1.time_ < var_118_1 + var_118_3 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0, 100, 0)

				local var_118_8 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_8.x, var_118_8.y, var_118_8.z)

				local var_118_9 = var_118_0.localEulerAngles

				var_118_9.z = 0
				var_118_9.x = 0
				var_118_0.localEulerAngles = var_118_9

				local var_118_10 = GameObjectTools.GetOrAddComponent(var_118_0.gameObject, typeof(DynamicBoneHelper))

				if var_118_10 then
					var_118_10:EnableDynamicBone(true)
				end
			end

			local var_118_11 = 0
			local var_118_12 = 0.7

			if var_118_11 < arg_115_1.time_ and arg_115_1.time_ <= var_118_11 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_13 = arg_115_1:GetWordFromCfg(113111027)
				local var_118_14 = arg_115_1:FormatText(var_118_13.content)

				arg_115_1.text_.text = var_118_14

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_15 = 28
				local var_118_16 = utf8.len(var_118_14)
				local var_118_17 = var_118_15 <= 0 and var_118_12 or var_118_12 * (var_118_16 / var_118_15)

				if var_118_17 > 0 and var_118_12 < var_118_17 then
					arg_115_1.talkMaxDuration = var_118_17

					if var_118_17 + var_118_11 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_17 + var_118_11
					end
				end

				arg_115_1.text_.text = var_118_14
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_18 = math.max(var_118_12, arg_115_1.talkMaxDuration)

			if var_118_11 <= arg_115_1.time_ and arg_115_1.time_ < var_118_11 + var_118_18 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_11) / var_118_18

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_11 + var_118_18 and arg_115_1.time_ < var_118_11 + var_118_18 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play113111028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 113111028
		arg_119_1.duration_ = 8.1

		local var_119_0 = {
			ja = 7.133,
			ko = 8.1,
			zh = 7.033,
			en = 6.3
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
				arg_119_0:Play113111029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 0.675

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_2 = arg_119_1:FormatText(StoryNameCfg[214].name)

				arg_119_1.leftNameTxt_.text = var_122_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6046")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_3 = arg_119_1:GetWordFromCfg(113111028)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111028", "story_v_out_113111.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_113111", "113111028", "story_v_out_113111.awb") / 1000

					if var_122_8 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_0
					end

					if var_122_3.prefab_name ~= "" and arg_119_1.actors_[var_122_3.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_3.prefab_name].transform, "story_v_out_113111", "113111028", "story_v_out_113111.awb")

						arg_119_1:RecordAudio("113111028", var_122_9)
						arg_119_1:RecordAudio("113111028", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_113111", "113111028", "story_v_out_113111.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_113111", "113111028", "story_v_out_113111.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_10 and arg_119_1.time_ < var_122_0 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play113111029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 113111029
		arg_123_1.duration_ = 3.53

		local var_123_0 = {
			ja = 3.533,
			ko = 3.533,
			zh = 3.466,
			en = 3.2
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
				arg_123_0:Play113111030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.2

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[212].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:GetWordFromCfg(113111029)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 8
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111029", "story_v_out_113111.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_113111", "113111029", "story_v_out_113111.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_113111", "113111029", "story_v_out_113111.awb")

						arg_123_1:RecordAudio("113111029", var_126_9)
						arg_123_1:RecordAudio("113111029", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_113111", "113111029", "story_v_out_113111.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_113111", "113111029", "story_v_out_113111.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_10 and arg_123_1.time_ < var_126_0 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play113111030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 113111030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play113111031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10006_tpose"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect10006_tpose == nil then
				arg_127_1.var_.characterEffect10006_tpose = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect10006_tpose and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect10006_tpose.fillFlat = true
					arg_127_1.var_.characterEffect10006_tpose.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect10006_tpose then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect10006_tpose.fillFlat = true
				arg_127_1.var_.characterEffect10006_tpose.fillRatio = var_130_5
			end

			local var_130_6 = 0
			local var_130_7 = 0.65

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_8 = arg_127_1:GetWordFromCfg(113111030)
				local var_130_9 = arg_127_1:FormatText(var_130_8.content)

				arg_127_1.text_.text = var_130_9

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 26
				local var_130_11 = utf8.len(var_130_9)
				local var_130_12 = var_130_10 <= 0 and var_130_7 or var_130_7 * (var_130_11 / var_130_10)

				if var_130_12 > 0 and var_130_7 < var_130_12 then
					arg_127_1.talkMaxDuration = var_130_12

					if var_130_12 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_12 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_9
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_13 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_13 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_13

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_13 and arg_127_1.time_ < var_130_6 + var_130_13 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play113111031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 113111031
		arg_131_1.duration_ = 4

		local var_131_0 = {
			ja = 3.333,
			ko = 2.9,
			zh = 2.133,
			en = 4
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
				arg_131_0:Play113111032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.3

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[36].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:GetWordFromCfg(113111031)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111031", "story_v_out_113111.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_113111", "113111031", "story_v_out_113111.awb") / 1000

					if var_134_8 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_0
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_113111", "113111031", "story_v_out_113111.awb")

						arg_131_1:RecordAudio("113111031", var_134_9)
						arg_131_1:RecordAudio("113111031", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_113111", "113111031", "story_v_out_113111.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_113111", "113111031", "story_v_out_113111.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_10 and arg_131_1.time_ < var_134_0 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play113111032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 113111032
		arg_135_1.duration_ = 5.73

		local var_135_0 = {
			ja = 5.733,
			ko = 5.4,
			zh = 4.333,
			en = 3.5
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
				arg_135_0:Play113111033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10006ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos10006ui_story = var_138_0.localPosition
			end

			local var_138_2 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2
				local var_138_4 = Vector3.New(0, -0.98, -5.65)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10006ui_story, var_138_4, var_138_3)

				local var_138_5 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_5.x, var_138_5.y, var_138_5.z)

				local var_138_6 = var_138_0.localEulerAngles

				var_138_6.z = 0
				var_138_6.x = 0
				var_138_0.localEulerAngles = var_138_6
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(0, -0.98, -5.65)

				local var_138_7 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_7.x, var_138_7.y, var_138_7.z)

				local var_138_8 = var_138_0.localEulerAngles

				var_138_8.z = 0
				var_138_8.x = 0
				var_138_0.localEulerAngles = var_138_8
			end

			local var_138_9 = 0

			if var_138_9 < arg_135_1.time_ and arg_135_1.time_ <= var_138_9 + arg_138_0 then
				arg_135_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action6_1")
			end

			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_138_11 = arg_135_1.actors_["10006ui_story"]
			local var_138_12 = 0

			if var_138_12 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 and not isNil(var_138_11) and arg_135_1.var_.characterEffect10006ui_story == nil then
				arg_135_1.var_.characterEffect10006ui_story = var_138_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_13 = 0.2

			if var_138_12 <= arg_135_1.time_ and arg_135_1.time_ < var_138_12 + var_138_13 and not isNil(var_138_11) then
				local var_138_14 = (arg_135_1.time_ - var_138_12) / var_138_13

				if arg_135_1.var_.characterEffect10006ui_story and not isNil(var_138_11) then
					arg_135_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_12 + var_138_13 and arg_135_1.time_ < var_138_12 + var_138_13 + arg_138_0 and not isNil(var_138_11) and arg_135_1.var_.characterEffect10006ui_story then
				arg_135_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_138_15 = 0
			local var_138_16 = 0.45

			if var_138_15 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_17 = arg_135_1:FormatText(StoryNameCfg[212].name)

				arg_135_1.leftNameTxt_.text = var_138_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_18 = arg_135_1:GetWordFromCfg(113111032)
				local var_138_19 = arg_135_1:FormatText(var_138_18.content)

				arg_135_1.text_.text = var_138_19

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_20 = 18
				local var_138_21 = utf8.len(var_138_19)
				local var_138_22 = var_138_20 <= 0 and var_138_16 or var_138_16 * (var_138_21 / var_138_20)

				if var_138_22 > 0 and var_138_16 < var_138_22 then
					arg_135_1.talkMaxDuration = var_138_22

					if var_138_22 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_22 + var_138_15
					end
				end

				arg_135_1.text_.text = var_138_19
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111032", "story_v_out_113111.awb") ~= 0 then
					local var_138_23 = manager.audio:GetVoiceLength("story_v_out_113111", "113111032", "story_v_out_113111.awb") / 1000

					if var_138_23 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_23 + var_138_15
					end

					if var_138_18.prefab_name ~= "" and arg_135_1.actors_[var_138_18.prefab_name] ~= nil then
						local var_138_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_18.prefab_name].transform, "story_v_out_113111", "113111032", "story_v_out_113111.awb")

						arg_135_1:RecordAudio("113111032", var_138_24)
						arg_135_1:RecordAudio("113111032", var_138_24)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_113111", "113111032", "story_v_out_113111.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_113111", "113111032", "story_v_out_113111.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_25 = math.max(var_138_16, arg_135_1.talkMaxDuration)

			if var_138_15 <= arg_135_1.time_ and arg_135_1.time_ < var_138_15 + var_138_25 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_15) / var_138_25

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_15 + var_138_25 and arg_135_1.time_ < var_138_15 + var_138_25 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play113111033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 113111033
		arg_139_1.duration_ = 8.7

		local var_139_0 = {
			ja = 8.7,
			ko = 4.933,
			zh = 6.7,
			en = 6.766
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
				arg_139_0:Play113111034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10006ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect10006ui_story == nil then
				arg_139_1.var_.characterEffect10006ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.2

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect10006ui_story and not isNil(var_142_0) then
					local var_142_4 = Mathf.Lerp(0, 0.5, var_142_3)

					arg_139_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10006ui_story.fillRatio = var_142_4
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect10006ui_story then
				local var_142_5 = 0.5

				arg_139_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10006ui_story.fillRatio = var_142_5
			end

			local var_142_6 = 0
			local var_142_7 = 0.725

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_8 = arg_139_1:FormatText(StoryNameCfg[36].name)

				arg_139_1.leftNameTxt_.text = var_142_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_9 = arg_139_1:GetWordFromCfg(113111033)
				local var_142_10 = arg_139_1:FormatText(var_142_9.content)

				arg_139_1.text_.text = var_142_10

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111033", "story_v_out_113111.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_113111", "113111033", "story_v_out_113111.awb") / 1000

					if var_142_14 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_6
					end

					if var_142_9.prefab_name ~= "" and arg_139_1.actors_[var_142_9.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_9.prefab_name].transform, "story_v_out_113111", "113111033", "story_v_out_113111.awb")

						arg_139_1:RecordAudio("113111033", var_142_15)
						arg_139_1:RecordAudio("113111033", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_113111", "113111033", "story_v_out_113111.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_113111", "113111033", "story_v_out_113111.awb")
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
	Play113111034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 113111034
		arg_143_1.duration_ = 6.47

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play113111035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = "OM0111"

			if arg_143_1.bgs_[var_146_0] == nil then
				local var_146_1 = Object.Instantiate(arg_143_1.paintGo_)

				var_146_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_146_0)
				var_146_1.name = var_146_0
				var_146_1.transform.parent = arg_143_1.stage_.transform
				var_146_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_143_1.bgs_[var_146_0] = var_146_1
			end

			local var_146_2 = 0

			if var_146_2 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				local var_146_3 = manager.ui.mainCamera.transform.localPosition
				local var_146_4 = Vector3.New(0, 0, 10) + Vector3.New(var_146_3.x, var_146_3.y, 0)
				local var_146_5 = arg_143_1.bgs_.OM0111

				var_146_5.transform.localPosition = var_146_4
				var_146_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_146_6 = var_146_5:GetComponent("SpriteRenderer")

				if var_146_6 and var_146_6.sprite then
					local var_146_7 = (var_146_5.transform.localPosition - var_146_3).z
					local var_146_8 = manager.ui.mainCameraCom_
					local var_146_9 = 2 * var_146_7 * Mathf.Tan(var_146_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_146_10 = var_146_9 * var_146_8.aspect
					local var_146_11 = var_146_6.sprite.bounds.size.x
					local var_146_12 = var_146_6.sprite.bounds.size.y
					local var_146_13 = var_146_10 / var_146_11
					local var_146_14 = var_146_9 / var_146_12
					local var_146_15 = var_146_14 < var_146_13 and var_146_13 or var_146_14

					var_146_5.transform.localScale = Vector3.New(var_146_15, var_146_15, 0)
				end

				for iter_146_0, iter_146_1 in pairs(arg_143_1.bgs_) do
					if iter_146_0 ~= "OM0111" then
						iter_146_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_146_16 = 0

			if var_146_16 < arg_143_1.time_ and arg_143_1.time_ <= var_146_16 + arg_146_0 then
				arg_143_1.mask_.enabled = true
				arg_143_1.mask_.raycastTarget = false

				arg_143_1:SetGaussion(false)
			end

			local var_146_17 = 2

			if var_146_16 <= arg_143_1.time_ and arg_143_1.time_ < var_146_16 + var_146_17 then
				local var_146_18 = (arg_143_1.time_ - var_146_16) / var_146_17
				local var_146_19 = Color.New(1, 1, 1)

				var_146_19.a = Mathf.Lerp(1, 0, var_146_18)
				arg_143_1.mask_.color = var_146_19
			end

			if arg_143_1.time_ >= var_146_16 + var_146_17 and arg_143_1.time_ < var_146_16 + var_146_17 + arg_146_0 then
				local var_146_20 = Color.New(1, 1, 1)
				local var_146_21 = 0

				arg_143_1.mask_.enabled = false
				var_146_20.a = var_146_21
				arg_143_1.mask_.color = var_146_20
			end

			local var_146_22 = manager.ui.mainCamera.transform
			local var_146_23 = 1.4

			if var_146_23 < arg_143_1.time_ and arg_143_1.time_ <= var_146_23 + arg_146_0 then
				arg_143_1.var_.shakeOldPos = var_146_22.localPosition
			end

			local var_146_24 = 1.2

			if var_146_23 <= arg_143_1.time_ and arg_143_1.time_ < var_146_23 + var_146_24 then
				local var_146_25 = (arg_143_1.time_ - var_146_23) / 0.066
				local var_146_26, var_146_27 = math.modf(var_146_25)

				var_146_22.localPosition = Vector3.New(var_146_27 * 0.13, var_146_27 * 0.13, var_146_27 * 0.13) + arg_143_1.var_.shakeOldPos
			end

			if arg_143_1.time_ >= var_146_23 + var_146_24 and arg_143_1.time_ < var_146_23 + var_146_24 + arg_146_0 then
				var_146_22.localPosition = arg_143_1.var_.shakeOldPos
			end

			local var_146_28 = arg_143_1.bgs_.OM0111.transform
			local var_146_29 = 0

			if var_146_29 < arg_143_1.time_ and arg_143_1.time_ <= var_146_29 + arg_146_0 then
				arg_143_1.var_.moveOldPosOM0111 = var_146_28.localPosition
			end

			local var_146_30 = 0.001

			if var_146_29 <= arg_143_1.time_ and arg_143_1.time_ < var_146_29 + var_146_30 then
				local var_146_31 = (arg_143_1.time_ - var_146_29) / var_146_30
				local var_146_32 = Vector3.New(-4, 1.2, 3)

				var_146_28.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPosOM0111, var_146_32, var_146_31)
			end

			if arg_143_1.time_ >= var_146_29 + var_146_30 and arg_143_1.time_ < var_146_29 + var_146_30 + arg_146_0 then
				var_146_28.localPosition = Vector3.New(-4, 1.2, 3)
			end

			local var_146_33 = arg_143_1.bgs_.OM0111.transform
			local var_146_34 = 0.0166666666666667

			if var_146_34 < arg_143_1.time_ and arg_143_1.time_ <= var_146_34 + arg_146_0 then
				arg_143_1.var_.moveOldPosOM0111 = var_146_33.localPosition
			end

			local var_146_35 = 6

			if var_146_34 <= arg_143_1.time_ and arg_143_1.time_ < var_146_34 + var_146_35 then
				local var_146_36 = (arg_143_1.time_ - var_146_34) / var_146_35
				local var_146_37 = Vector3.New(-4, 0.55, 3)

				var_146_33.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPosOM0111, var_146_37, var_146_36)
			end

			if arg_143_1.time_ >= var_146_34 + var_146_35 and arg_143_1.time_ < var_146_34 + var_146_35 + arg_146_0 then
				var_146_33.localPosition = Vector3.New(-4, 0.55, 3)
			end

			local var_146_38 = 0

			if var_146_38 < arg_143_1.time_ and arg_143_1.time_ <= var_146_38 + arg_146_0 then
				arg_143_1.allBtn_.enabled = false
			end

			local var_146_39 = 6.016666666666

			if arg_143_1.time_ >= var_146_38 + var_146_39 and arg_143_1.time_ < var_146_38 + var_146_39 + arg_146_0 then
				arg_143_1.allBtn_.enabled = true
			end

			local var_146_40 = arg_143_1.actors_["10006ui_story"].transform
			local var_146_41 = 0

			if var_146_41 < arg_143_1.time_ and arg_143_1.time_ <= var_146_41 + arg_146_0 then
				arg_143_1.var_.moveOldPos10006ui_story = var_146_40.localPosition
			end

			local var_146_42 = 0.001

			if var_146_41 <= arg_143_1.time_ and arg_143_1.time_ < var_146_41 + var_146_42 then
				local var_146_43 = (arg_143_1.time_ - var_146_41) / var_146_42
				local var_146_44 = Vector3.New(0, 100, 0)

				var_146_40.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10006ui_story, var_146_44, var_146_43)

				local var_146_45 = manager.ui.mainCamera.transform.position - var_146_40.position

				var_146_40.forward = Vector3.New(var_146_45.x, var_146_45.y, var_146_45.z)

				local var_146_46 = var_146_40.localEulerAngles

				var_146_46.z = 0
				var_146_46.x = 0
				var_146_40.localEulerAngles = var_146_46
			end

			if arg_143_1.time_ >= var_146_41 + var_146_42 and arg_143_1.time_ < var_146_41 + var_146_42 + arg_146_0 then
				var_146_40.localPosition = Vector3.New(0, 100, 0)

				local var_146_47 = manager.ui.mainCamera.transform.position - var_146_40.position

				var_146_40.forward = Vector3.New(var_146_47.x, var_146_47.y, var_146_47.z)

				local var_146_48 = var_146_40.localEulerAngles

				var_146_48.z = 0
				var_146_48.x = 0
				var_146_40.localEulerAngles = var_146_48
			end

			local var_146_49 = 0
			local var_146_50 = 1

			if var_146_49 < arg_143_1.time_ and arg_143_1.time_ <= var_146_49 + arg_146_0 then
				local var_146_51 = "play"
				local var_146_52 = "effect"

				arg_143_1:AudioAction(var_146_51, var_146_52, "se_story_10", "se_story_10_burst", "")
			end

			local var_146_53 = 0
			local var_146_54 = 0.075

			if var_146_53 < arg_143_1.time_ and arg_143_1.time_ <= var_146_53 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_55 = arg_143_1:GetWordFromCfg(113111034)
				local var_146_56 = arg_143_1:FormatText(var_146_55.content)

				arg_143_1.text_.text = var_146_56

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_57 = 3
				local var_146_58 = utf8.len(var_146_56)
				local var_146_59 = var_146_57 <= 0 and var_146_54 or var_146_54 * (var_146_58 / var_146_57)

				if var_146_59 > 0 and var_146_54 < var_146_59 then
					arg_143_1.talkMaxDuration = var_146_59

					if var_146_59 + var_146_53 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_59 + var_146_53
					end
				end

				arg_143_1.text_.text = var_146_56
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_60 = math.max(var_146_54, arg_143_1.talkMaxDuration)

			if var_146_53 <= arg_143_1.time_ and arg_143_1.time_ < var_146_53 + var_146_60 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_53) / var_146_60

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_53 + var_146_60 and arg_143_1.time_ < var_146_53 + var_146_60 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 6,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play113111035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 113111035
		arg_147_1.duration_ = 2.23

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play113111036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.05

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_2 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_2:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_147_1.dialogCg_.alpha = arg_151_0
				end))
				var_150_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_3 = arg_147_1:FormatText(StoryNameCfg[212].name)

				arg_147_1.leftNameTxt_.text = var_150_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_4 = arg_147_1:GetWordFromCfg(113111035)
				local var_150_5 = arg_147_1:FormatText(var_150_4.content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_6 = 2
				local var_150_7 = utf8.len(var_150_5)
				local var_150_8 = var_150_6 <= 0 and var_150_1 or var_150_1 * (var_150_7 / var_150_6)

				if var_150_8 > 0 and var_150_1 < var_150_8 then
					arg_147_1.talkMaxDuration = var_150_8
					var_150_0 = var_150_0 + 0.3

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111035", "story_v_out_113111.awb") ~= 0 then
					local var_150_9 = manager.audio:GetVoiceLength("story_v_out_113111", "113111035", "story_v_out_113111.awb") / 1000

					if var_150_9 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_0
					end

					if var_150_4.prefab_name ~= "" and arg_147_1.actors_[var_150_4.prefab_name] ~= nil then
						local var_150_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_4.prefab_name].transform, "story_v_out_113111", "113111035", "story_v_out_113111.awb")

						arg_147_1:RecordAudio("113111035", var_150_10)
						arg_147_1:RecordAudio("113111035", var_150_10)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_113111", "113111035", "story_v_out_113111.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_113111", "113111035", "story_v_out_113111.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_11 = var_150_0 + 0.3
			local var_150_12 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_11 <= arg_147_1.time_ and arg_147_1.time_ < var_150_11 + var_150_12 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_11) / var_150_12

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_11 + var_150_12 and arg_147_1.time_ < var_150_11 + var_150_12 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play113111036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 113111036
		arg_153_1.duration_ = 7

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play113111037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_1 = 2

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_1 then
				local var_156_2 = (arg_153_1.time_ - var_156_0) / var_156_1
				local var_156_3 = Color.New(1, 1, 1)

				var_156_3.a = Mathf.Lerp(1, 0, var_156_2)
				arg_153_1.mask_.color = var_156_3
			end

			if arg_153_1.time_ >= var_156_0 + var_156_1 and arg_153_1.time_ < var_156_0 + var_156_1 + arg_156_0 then
				local var_156_4 = Color.New(1, 1, 1)
				local var_156_5 = 0

				arg_153_1.mask_.enabled = false
				var_156_4.a = var_156_5
				arg_153_1.mask_.color = var_156_4
			end

			local var_156_6 = arg_153_1.bgs_.OM0111.transform
			local var_156_7 = 0

			if var_156_7 < arg_153_1.time_ and arg_153_1.time_ <= var_156_7 + arg_156_0 then
				arg_153_1.var_.moveOldPosOM0111 = var_156_6.localPosition
			end

			local var_156_8 = 0.001

			if var_156_7 <= arg_153_1.time_ and arg_153_1.time_ < var_156_7 + var_156_8 then
				local var_156_9 = (arg_153_1.time_ - var_156_7) / var_156_8
				local var_156_10 = Vector3.New(0, 1, 9.5)

				var_156_6.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPosOM0111, var_156_10, var_156_9)
			end

			if arg_153_1.time_ >= var_156_7 + var_156_8 and arg_153_1.time_ < var_156_7 + var_156_8 + arg_156_0 then
				var_156_6.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_156_11 = arg_153_1.bgs_.OM0111.transform
			local var_156_12 = 0.0166666666666667

			if var_156_12 < arg_153_1.time_ and arg_153_1.time_ <= var_156_12 + arg_156_0 then
				arg_153_1.var_.moveOldPosOM0111 = var_156_11.localPosition
			end

			local var_156_13 = 3.53333333333333

			if var_156_12 <= arg_153_1.time_ and arg_153_1.time_ < var_156_12 + var_156_13 then
				local var_156_14 = (arg_153_1.time_ - var_156_12) / var_156_13
				local var_156_15 = Vector3.New(0, 1, 10)

				var_156_11.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPosOM0111, var_156_15, var_156_14)
			end

			if arg_153_1.time_ >= var_156_12 + var_156_13 and arg_153_1.time_ < var_156_12 + var_156_13 + arg_156_0 then
				var_156_11.localPosition = Vector3.New(0, 1, 10)
			end

			local var_156_16 = 2

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 then
				arg_153_1.allBtn_.enabled = false
			end

			local var_156_17 = 1.55

			if arg_153_1.time_ >= var_156_16 + var_156_17 and arg_153_1.time_ < var_156_16 + var_156_17 + arg_156_0 then
				arg_153_1.allBtn_.enabled = true
			end

			if arg_153_1.frameCnt_ <= 1 then
				arg_153_1.dialog_:SetActive(false)
			end

			local var_156_18 = 2
			local var_156_19 = 1.55

			if var_156_18 < arg_153_1.time_ and arg_153_1.time_ <= var_156_18 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				arg_153_1.dialog_:SetActive(true)

				arg_153_1.dialogCg_.alpha = 0

				local var_156_20 = LeanTween.value(arg_153_1.dialog_, 0, 1, 0.3)

				var_156_20:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_153_1.dialogCg_.alpha = arg_157_0
				end))
				var_156_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_153_1.dialog_)
					var_156_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_153_1.duration_ = arg_153_1.duration_ + 0.3

				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_21 = arg_153_1:GetWordFromCfg(113111036)
				local var_156_22 = arg_153_1:FormatText(var_156_21.content)

				arg_153_1.text_.text = var_156_22

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_23 = 62
				local var_156_24 = utf8.len(var_156_22)
				local var_156_25 = var_156_23 <= 0 and var_156_19 or var_156_19 * (var_156_24 / var_156_23)

				if var_156_25 > 0 and var_156_19 < var_156_25 then
					arg_153_1.talkMaxDuration = var_156_25
					var_156_18 = var_156_18 + 0.3

					if var_156_25 + var_156_18 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_25 + var_156_18
					end
				end

				arg_153_1.text_.text = var_156_22
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_26 = var_156_18 + 0.3
			local var_156_27 = math.max(var_156_19, arg_153_1.talkMaxDuration)

			if var_156_26 <= arg_153_1.time_ and arg_153_1.time_ < var_156_26 + var_156_27 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_26) / var_156_27

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_26 + var_156_27 and arg_153_1.time_ < var_156_26 + var_156_27 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.53333333333333,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play113111037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 113111037
		arg_159_1.duration_ = 5.67

		local var_159_0 = {
			ja = 4.466,
			ko = 4.8,
			zh = 5.666,
			en = 3.933
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
				arg_159_0:Play113111038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.4

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[214].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:GetWordFromCfg(113111037)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111037", "story_v_out_113111.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_113111", "113111037", "story_v_out_113111.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_113111", "113111037", "story_v_out_113111.awb")

						arg_159_1:RecordAudio("113111037", var_162_9)
						arg_159_1:RecordAudio("113111037", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_113111", "113111037", "story_v_out_113111.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_113111", "113111037", "story_v_out_113111.awb")
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
	Play113111038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 113111038
		arg_163_1.duration_ = 4.6

		local var_163_0 = {
			ja = 4.6,
			ko = 3,
			zh = 1.833,
			en = 3.266
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
				arg_163_0:Play113111039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = manager.ui.mainCamera.transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.shakeOldPos = var_166_0.localPosition
			end

			local var_166_2 = 1

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / 0.066
				local var_166_4, var_166_5 = math.modf(var_166_3)

				var_166_0.localPosition = Vector3.New(var_166_5 * 0.13, var_166_5 * 0.13, var_166_5 * 0.13) + arg_163_1.var_.shakeOldPos
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = arg_163_1.var_.shakeOldPos
			end

			local var_166_6 = 0

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.allBtn_.enabled = false
			end

			local var_166_7 = 1

			if arg_163_1.time_ >= var_166_6 + var_166_7 and arg_163_1.time_ < var_166_6 + var_166_7 + arg_166_0 then
				arg_163_1.allBtn_.enabled = true
			end

			local var_166_8 = 0
			local var_166_9 = 0.275

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_10 = arg_163_1:FormatText(StoryNameCfg[212].name)

				arg_163_1.leftNameTxt_.text = var_166_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_11 = arg_163_1:GetWordFromCfg(113111038)
				local var_166_12 = arg_163_1:FormatText(var_166_11.content)

				arg_163_1.text_.text = var_166_12

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 11
				local var_166_14 = utf8.len(var_166_12)
				local var_166_15 = var_166_13 <= 0 and var_166_9 or var_166_9 * (var_166_14 / var_166_13)

				if var_166_15 > 0 and var_166_9 < var_166_15 then
					arg_163_1.talkMaxDuration = var_166_15

					if var_166_15 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_15 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_12
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111038", "story_v_out_113111.awb") ~= 0 then
					local var_166_16 = manager.audio:GetVoiceLength("story_v_out_113111", "113111038", "story_v_out_113111.awb") / 1000

					if var_166_16 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_16 + var_166_8
					end

					if var_166_11.prefab_name ~= "" and arg_163_1.actors_[var_166_11.prefab_name] ~= nil then
						local var_166_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_11.prefab_name].transform, "story_v_out_113111", "113111038", "story_v_out_113111.awb")

						arg_163_1:RecordAudio("113111038", var_166_17)
						arg_163_1:RecordAudio("113111038", var_166_17)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_113111", "113111038", "story_v_out_113111.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_113111", "113111038", "story_v_out_113111.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_18 = math.max(var_166_9, arg_163_1.talkMaxDuration)

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_18 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_8) / var_166_18

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_8 + var_166_18 and arg_163_1.time_ < var_166_8 + var_166_18 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play113111039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 113111039
		arg_167_1.duration_ = 4.4

		local var_167_0 = {
			ja = 4.4,
			ko = 2.066,
			zh = 2.133,
			en = 2.066
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
			arg_167_1.auto_ = false
		end

		function arg_167_1.playNext_(arg_169_0)
			arg_167_1.onStoryFinished_()
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.3

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[36].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(113111039)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_113111", "113111039", "story_v_out_113111.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_113111", "113111039", "story_v_out_113111.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_113111", "113111039", "story_v_out_113111.awb")

						arg_167_1:RecordAudio("113111039", var_170_9)
						arg_167_1:RecordAudio("113111039", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_113111", "113111039", "story_v_out_113111.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_113111", "113111039", "story_v_out_113111.awb")
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
	assets = {
		"TextureConfig/Background/F02_1",
		"TextureConfig/Background/F01",
		"TextureConfig/Background/OM0111"
	},
	voices = {
		"story_v_out_113111.awb"
	}
}
