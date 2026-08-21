return {
	Play412031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 412031001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play412031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I09j"

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
				local var_4_5 = arg_1_1.bgs_.I09j

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
					if iter_4_0 ~= "I09j" then
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

			local var_4_24 = 0
			local var_4_25 = 0.233333333333333

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

			local var_4_30 = 1.1
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_2_story_corridor_slow", "bgm_activity_3_2_story_corridor_slow", "bgm_activity_3_2_story_corridor_slow.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_2_story_corridor_slow", "bgm_activity_3_2_story_corridor_slow")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_36 = 2
			local var_4_37 = 0.475

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_39 = arg_1_1:GetWordFromCfg(412031001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 19
				local var_4_42 = utf8.len(var_4_40)
				local var_4_43 = var_4_41 <= 0 and var_4_37 or var_4_37 * (var_4_42 / var_4_41)

				if var_4_43 > 0 and var_4_37 < var_4_43 then
					arg_1_1.talkMaxDuration = var_4_43
					var_4_36 = var_4_36 + 0.3

					if var_4_43 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_40
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = var_4_36 + 0.3
			local var_4_45 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_45 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_44) / var_4_45

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play412031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 412031002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play412031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.875

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(412031002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 35
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play412031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 412031003
		arg_13_1.duration_ = 3.67

		local var_13_0 = {
			zh = 3.666,
			ja = 2.9
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
				arg_13_0:Play412031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.25

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[216].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(412031003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031003", "story_v_out_412031.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031003", "story_v_out_412031.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_412031", "412031003", "story_v_out_412031.awb")

						arg_13_1:RecordAudio("412031003", var_16_9)
						arg_13_1:RecordAudio("412031003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_412031", "412031003", "story_v_out_412031.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_412031", "412031003", "story_v_out_412031.awb")
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
	Play412031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 412031004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play412031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.05

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

				local var_20_2 = arg_17_1:GetWordFromCfg(412031004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 42
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
	Play412031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 412031005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play412031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.125

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

				local var_24_2 = arg_21_1:GetWordFromCfg(412031005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 5
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
	Play412031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 412031006
		arg_25_1.duration_ = 5.13

		local var_25_0 = {
			zh = 5.133,
			ja = 4.233
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
				arg_25_0:Play412031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "1097ui_story"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Char/" .. "1097ui_story")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_25_1.stage_.transform)

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

			local var_28_5 = arg_25_1.actors_["1097ui_story"].transform
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.var_.moveOldPos1097ui_story = var_28_5.localPosition
			end

			local var_28_7 = 0.001

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 then
				local var_28_8 = (arg_25_1.time_ - var_28_6) / var_28_7
				local var_28_9 = Vector3.New(0, -0.54, -6.3)

				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1097ui_story, var_28_9, var_28_8)

				local var_28_10 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_10.x, var_28_10.y, var_28_10.z)

				local var_28_11 = var_28_5.localEulerAngles

				var_28_11.z = 0
				var_28_11.x = 0
				var_28_5.localEulerAngles = var_28_11
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_28_12 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_12.x, var_28_12.y, var_28_12.z)

				local var_28_13 = var_28_5.localEulerAngles

				var_28_13.z = 0
				var_28_13.x = 0
				var_28_5.localEulerAngles = var_28_13
			end

			local var_28_14 = 0

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_28_16 = arg_25_1.actors_["1097ui_story"]
			local var_28_17 = 0

			if var_28_17 < arg_25_1.time_ and arg_25_1.time_ <= var_28_17 + arg_28_0 and not isNil(var_28_16) and arg_25_1.var_.characterEffect1097ui_story == nil then
				arg_25_1.var_.characterEffect1097ui_story = var_28_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_18 = 0.2

			if var_28_17 <= arg_25_1.time_ and arg_25_1.time_ < var_28_17 + var_28_18 and not isNil(var_28_16) then
				local var_28_19 = (arg_25_1.time_ - var_28_17) / var_28_18

				if arg_25_1.var_.characterEffect1097ui_story and not isNil(var_28_16) then
					arg_25_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_17 + var_28_18 and arg_25_1.time_ < var_28_17 + var_28_18 + arg_28_0 and not isNil(var_28_16) and arg_25_1.var_.characterEffect1097ui_story then
				arg_25_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_28_20 = 0
			local var_28_21 = 0.275

			if var_28_20 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_22 = arg_25_1:FormatText(StoryNameCfg[216].name)

				arg_25_1.leftNameTxt_.text = var_28_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_23 = arg_25_1:GetWordFromCfg(412031006)
				local var_28_24 = arg_25_1:FormatText(var_28_23.content)

				arg_25_1.text_.text = var_28_24

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_25 = 11
				local var_28_26 = utf8.len(var_28_24)
				local var_28_27 = var_28_25 <= 0 and var_28_21 or var_28_21 * (var_28_26 / var_28_25)

				if var_28_27 > 0 and var_28_21 < var_28_27 then
					arg_25_1.talkMaxDuration = var_28_27

					if var_28_27 + var_28_20 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_27 + var_28_20
					end
				end

				arg_25_1.text_.text = var_28_24
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031006", "story_v_out_412031.awb") ~= 0 then
					local var_28_28 = manager.audio:GetVoiceLength("story_v_out_412031", "412031006", "story_v_out_412031.awb") / 1000

					if var_28_28 + var_28_20 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_20
					end

					if var_28_23.prefab_name ~= "" and arg_25_1.actors_[var_28_23.prefab_name] ~= nil then
						local var_28_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_23.prefab_name].transform, "story_v_out_412031", "412031006", "story_v_out_412031.awb")

						arg_25_1:RecordAudio("412031006", var_28_29)
						arg_25_1:RecordAudio("412031006", var_28_29)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_412031", "412031006", "story_v_out_412031.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_412031", "412031006", "story_v_out_412031.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_30 = math.max(var_28_21, arg_25_1.talkMaxDuration)

			if var_28_20 <= arg_25_1.time_ and arg_25_1.time_ < var_28_20 + var_28_30 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_20) / var_28_30

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_20 + var_28_30 and arg_25_1.time_ < var_28_20 + var_28_30 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play412031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 412031007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play412031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1097ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1097ui_story == nil then
				arg_29_1.var_.characterEffect1097ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1097ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1097ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1097ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1097ui_story.fillRatio = var_32_5
			end

			local var_32_6 = arg_29_1.actors_["1097ui_story"].transform
			local var_32_7 = 0

			if var_32_7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.var_.moveOldPos1097ui_story = var_32_6.localPosition
			end

			local var_32_8 = 0.001

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_8 then
				local var_32_9 = (arg_29_1.time_ - var_32_7) / var_32_8
				local var_32_10 = Vector3.New(0, 100, 0)

				var_32_6.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1097ui_story, var_32_10, var_32_9)

				local var_32_11 = manager.ui.mainCamera.transform.position - var_32_6.position

				var_32_6.forward = Vector3.New(var_32_11.x, var_32_11.y, var_32_11.z)

				local var_32_12 = var_32_6.localEulerAngles

				var_32_12.z = 0
				var_32_12.x = 0
				var_32_6.localEulerAngles = var_32_12
			end

			if arg_29_1.time_ >= var_32_7 + var_32_8 and arg_29_1.time_ < var_32_7 + var_32_8 + arg_32_0 then
				var_32_6.localPosition = Vector3.New(0, 100, 0)

				local var_32_13 = manager.ui.mainCamera.transform.position - var_32_6.position

				var_32_6.forward = Vector3.New(var_32_13.x, var_32_13.y, var_32_13.z)

				local var_32_14 = var_32_6.localEulerAngles

				var_32_14.z = 0
				var_32_14.x = 0
				var_32_6.localEulerAngles = var_32_14
			end

			local var_32_15 = 0
			local var_32_16 = 1.35

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_17 = arg_29_1:GetWordFromCfg(412031007)
				local var_32_18 = arg_29_1:FormatText(var_32_17.content)

				arg_29_1.text_.text = var_32_18

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_19 = 54
				local var_32_20 = utf8.len(var_32_18)
				local var_32_21 = var_32_19 <= 0 and var_32_16 or var_32_16 * (var_32_20 / var_32_19)

				if var_32_21 > 0 and var_32_16 < var_32_21 then
					arg_29_1.talkMaxDuration = var_32_21

					if var_32_21 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_21 + var_32_15
					end
				end

				arg_29_1.text_.text = var_32_18
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_22 = math.max(var_32_16, arg_29_1.talkMaxDuration)

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_22 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_15) / var_32_22

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_15 + var_32_22 and arg_29_1.time_ < var_32_15 + var_32_22 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play412031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 412031008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play412031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.5

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(412031008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 20
				local var_36_5 = utf8.len(var_36_3)
				local var_36_6 = var_36_4 <= 0 and var_36_1 or var_36_1 * (var_36_5 / var_36_4)

				if var_36_6 > 0 and var_36_1 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_7 and arg_33_1.time_ < var_36_0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play412031009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 412031009
		arg_37_1.duration_ = 5.07

		local var_37_0 = {
			zh = 5.066,
			ja = 4.066
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
				arg_37_0:Play412031010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = "3043ui_story"

			if arg_37_1.actors_[var_40_0] == nil then
				local var_40_1 = Asset.Load("Char/" .. "3043ui_story")

				if not isNil(var_40_1) then
					local var_40_2 = Object.Instantiate(Asset.Load("Char/" .. "3043ui_story"), arg_37_1.stage_.transform)

					var_40_2.name = var_40_0
					var_40_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_37_1.actors_[var_40_0] = var_40_2

					local var_40_3 = var_40_2:GetComponentInChildren(typeof(CharacterEffect))

					var_40_3.enabled = true

					local var_40_4 = GameObjectTools.GetOrAddComponent(var_40_2, typeof(DynamicBoneHelper))

					if var_40_4 then
						var_40_4:EnableDynamicBone(false)
					end

					arg_37_1:ShowWeapon(var_40_3.transform, false)

					arg_37_1.var_[var_40_0 .. "Animator"] = var_40_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_37_1.var_[var_40_0 .. "Animator"].applyRootMotion = true
					arg_37_1.var_[var_40_0 .. "LipSync"] = var_40_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_40_5 = arg_37_1.actors_["3043ui_story"].transform
			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.var_.moveOldPos3043ui_story = var_40_5.localPosition
			end

			local var_40_7 = 0.001

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_7 then
				local var_40_8 = (arg_37_1.time_ - var_40_6) / var_40_7
				local var_40_9 = Vector3.New(0, -1.41, -5.7)

				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos3043ui_story, var_40_9, var_40_8)

				local var_40_10 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_10.x, var_40_10.y, var_40_10.z)

				local var_40_11 = var_40_5.localEulerAngles

				var_40_11.z = 0
				var_40_11.x = 0
				var_40_5.localEulerAngles = var_40_11
			end

			if arg_37_1.time_ >= var_40_6 + var_40_7 and arg_37_1.time_ < var_40_6 + var_40_7 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(0, -1.41, -5.7)

				local var_40_12 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_12.x, var_40_12.y, var_40_12.z)

				local var_40_13 = var_40_5.localEulerAngles

				var_40_13.z = 0
				var_40_13.x = 0
				var_40_5.localEulerAngles = var_40_13
			end

			local var_40_14 = 0

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_40_15 = arg_37_1.actors_["3043ui_story"]
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.characterEffect3043ui_story == nil then
				arg_37_1.var_.characterEffect3043ui_story = var_40_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_17 = 0.2

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 and not isNil(var_40_15) then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / var_40_17

				if arg_37_1.var_.characterEffect3043ui_story and not isNil(var_40_15) then
					arg_37_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.characterEffect3043ui_story then
				arg_37_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_40_19 = 0
			local var_40_20 = 0.425

			if var_40_19 < arg_37_1.time_ and arg_37_1.time_ <= var_40_19 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_21 = arg_37_1:FormatText(StoryNameCfg[36].name)

				arg_37_1.leftNameTxt_.text = var_40_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_22 = arg_37_1:GetWordFromCfg(412031009)
				local var_40_23 = arg_37_1:FormatText(var_40_22.content)

				arg_37_1.text_.text = var_40_23

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_24 = 17
				local var_40_25 = utf8.len(var_40_23)
				local var_40_26 = var_40_24 <= 0 and var_40_20 or var_40_20 * (var_40_25 / var_40_24)

				if var_40_26 > 0 and var_40_20 < var_40_26 then
					arg_37_1.talkMaxDuration = var_40_26

					if var_40_26 + var_40_19 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_26 + var_40_19
					end
				end

				arg_37_1.text_.text = var_40_23
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031009", "story_v_out_412031.awb") ~= 0 then
					local var_40_27 = manager.audio:GetVoiceLength("story_v_out_412031", "412031009", "story_v_out_412031.awb") / 1000

					if var_40_27 + var_40_19 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_27 + var_40_19
					end

					if var_40_22.prefab_name ~= "" and arg_37_1.actors_[var_40_22.prefab_name] ~= nil then
						local var_40_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_22.prefab_name].transform, "story_v_out_412031", "412031009", "story_v_out_412031.awb")

						arg_37_1:RecordAudio("412031009", var_40_28)
						arg_37_1:RecordAudio("412031009", var_40_28)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_412031", "412031009", "story_v_out_412031.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_412031", "412031009", "story_v_out_412031.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_29 = math.max(var_40_20, arg_37_1.talkMaxDuration)

			if var_40_19 <= arg_37_1.time_ and arg_37_1.time_ < var_40_19 + var_40_29 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_19) / var_40_29

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_19 + var_40_29 and arg_37_1.time_ < var_40_19 + var_40_29 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play412031010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 412031010
		arg_41_1.duration_ = 5.03

		local var_41_0 = {
			zh = 5.033,
			ja = 3.933
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
				arg_41_0:Play412031011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1097ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1097ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1097ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["1097ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1097ui_story == nil then
				arg_41_1.var_.characterEffect1097ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect1097ui_story and not isNil(var_44_9) then
					arg_41_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1097ui_story then
				arg_41_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_44_13 = 0

			if var_44_13 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				arg_41_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_44_14 = 0

			if var_44_14 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_15 = arg_41_1.actors_["3043ui_story"].transform
			local var_44_16 = 0

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.var_.moveOldPos3043ui_story = var_44_15.localPosition
			end

			local var_44_17 = 0.001

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_17 then
				local var_44_18 = (arg_41_1.time_ - var_44_16) / var_44_17
				local var_44_19 = Vector3.New(0.7, -1.41, -5.7)

				var_44_15.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos3043ui_story, var_44_19, var_44_18)

				local var_44_20 = manager.ui.mainCamera.transform.position - var_44_15.position

				var_44_15.forward = Vector3.New(var_44_20.x, var_44_20.y, var_44_20.z)

				local var_44_21 = var_44_15.localEulerAngles

				var_44_21.z = 0
				var_44_21.x = 0
				var_44_15.localEulerAngles = var_44_21
			end

			if arg_41_1.time_ >= var_44_16 + var_44_17 and arg_41_1.time_ < var_44_16 + var_44_17 + arg_44_0 then
				var_44_15.localPosition = Vector3.New(0.7, -1.41, -5.7)

				local var_44_22 = manager.ui.mainCamera.transform.position - var_44_15.position

				var_44_15.forward = Vector3.New(var_44_22.x, var_44_22.y, var_44_22.z)

				local var_44_23 = var_44_15.localEulerAngles

				var_44_23.z = 0
				var_44_23.x = 0
				var_44_15.localEulerAngles = var_44_23
			end

			local var_44_24 = arg_41_1.actors_["3043ui_story"]
			local var_44_25 = 0

			if var_44_25 < arg_41_1.time_ and arg_41_1.time_ <= var_44_25 + arg_44_0 and not isNil(var_44_24) and arg_41_1.var_.characterEffect3043ui_story == nil then
				arg_41_1.var_.characterEffect3043ui_story = var_44_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_26 = 0.200000002980232

			if var_44_25 <= arg_41_1.time_ and arg_41_1.time_ < var_44_25 + var_44_26 and not isNil(var_44_24) then
				local var_44_27 = (arg_41_1.time_ - var_44_25) / var_44_26

				if arg_41_1.var_.characterEffect3043ui_story and not isNil(var_44_24) then
					local var_44_28 = Mathf.Lerp(0, 0.5, var_44_27)

					arg_41_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_41_1.var_.characterEffect3043ui_story.fillRatio = var_44_28
				end
			end

			if arg_41_1.time_ >= var_44_25 + var_44_26 and arg_41_1.time_ < var_44_25 + var_44_26 + arg_44_0 and not isNil(var_44_24) and arg_41_1.var_.characterEffect3043ui_story then
				local var_44_29 = 0.5

				arg_41_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_41_1.var_.characterEffect3043ui_story.fillRatio = var_44_29
			end

			local var_44_30 = 0
			local var_44_31 = 0.425

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_32 = arg_41_1:FormatText(StoryNameCfg[216].name)

				arg_41_1.leftNameTxt_.text = var_44_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_33 = arg_41_1:GetWordFromCfg(412031010)
				local var_44_34 = arg_41_1:FormatText(var_44_33.content)

				arg_41_1.text_.text = var_44_34

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_35 = 17
				local var_44_36 = utf8.len(var_44_34)
				local var_44_37 = var_44_35 <= 0 and var_44_31 or var_44_31 * (var_44_36 / var_44_35)

				if var_44_37 > 0 and var_44_31 < var_44_37 then
					arg_41_1.talkMaxDuration = var_44_37

					if var_44_37 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_37 + var_44_30
					end
				end

				arg_41_1.text_.text = var_44_34
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031010", "story_v_out_412031.awb") ~= 0 then
					local var_44_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031010", "story_v_out_412031.awb") / 1000

					if var_44_38 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_38 + var_44_30
					end

					if var_44_33.prefab_name ~= "" and arg_41_1.actors_[var_44_33.prefab_name] ~= nil then
						local var_44_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_33.prefab_name].transform, "story_v_out_412031", "412031010", "story_v_out_412031.awb")

						arg_41_1:RecordAudio("412031010", var_44_39)
						arg_41_1:RecordAudio("412031010", var_44_39)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_412031", "412031010", "story_v_out_412031.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_412031", "412031010", "story_v_out_412031.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_40 = math.max(var_44_31, arg_41_1.talkMaxDuration)

			if var_44_30 <= arg_41_1.time_ and arg_41_1.time_ < var_44_30 + var_44_40 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_30) / var_44_40

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_30 + var_44_40 and arg_41_1.time_ < var_44_30 + var_44_40 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play412031011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 412031011
		arg_45_1.duration_ = 5

		local var_45_0 = {
			zh = 3.4,
			ja = 5
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
				arg_45_0:Play412031012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["3043ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos3043ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0.7, -1.41, -5.7)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos3043ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0.7, -1.41, -5.7)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["3043ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect3043ui_story == nil then
				arg_45_1.var_.characterEffect3043ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect3043ui_story and not isNil(var_48_9) then
					arg_45_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect3043ui_story then
				arg_45_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_15 = arg_45_1.actors_["1097ui_story"]
			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.characterEffect1097ui_story == nil then
				arg_45_1.var_.characterEffect1097ui_story = var_48_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_17 = 0.200000002980232

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_17 and not isNil(var_48_15) then
				local var_48_18 = (arg_45_1.time_ - var_48_16) / var_48_17

				if arg_45_1.var_.characterEffect1097ui_story and not isNil(var_48_15) then
					local var_48_19 = Mathf.Lerp(0, 0.5, var_48_18)

					arg_45_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1097ui_story.fillRatio = var_48_19
				end
			end

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.characterEffect1097ui_story then
				local var_48_20 = 0.5

				arg_45_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1097ui_story.fillRatio = var_48_20
			end

			local var_48_21 = 0
			local var_48_22 = 0.375

			if var_48_21 < arg_45_1.time_ and arg_45_1.time_ <= var_48_21 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_23 = arg_45_1:FormatText(StoryNameCfg[920].name)

				arg_45_1.leftNameTxt_.text = var_48_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_24 = arg_45_1:GetWordFromCfg(412031011)
				local var_48_25 = arg_45_1:FormatText(var_48_24.content)

				arg_45_1.text_.text = var_48_25

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_26 = 15
				local var_48_27 = utf8.len(var_48_25)
				local var_48_28 = var_48_26 <= 0 and var_48_22 or var_48_22 * (var_48_27 / var_48_26)

				if var_48_28 > 0 and var_48_22 < var_48_28 then
					arg_45_1.talkMaxDuration = var_48_28

					if var_48_28 + var_48_21 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_28 + var_48_21
					end
				end

				arg_45_1.text_.text = var_48_25
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031011", "story_v_out_412031.awb") ~= 0 then
					local var_48_29 = manager.audio:GetVoiceLength("story_v_out_412031", "412031011", "story_v_out_412031.awb") / 1000

					if var_48_29 + var_48_21 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_29 + var_48_21
					end

					if var_48_24.prefab_name ~= "" and arg_45_1.actors_[var_48_24.prefab_name] ~= nil then
						local var_48_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_24.prefab_name].transform, "story_v_out_412031", "412031011", "story_v_out_412031.awb")

						arg_45_1:RecordAudio("412031011", var_48_30)
						arg_45_1:RecordAudio("412031011", var_48_30)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_412031", "412031011", "story_v_out_412031.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_412031", "412031011", "story_v_out_412031.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_31 = math.max(var_48_22, arg_45_1.talkMaxDuration)

			if var_48_21 <= arg_45_1.time_ and arg_45_1.time_ < var_48_21 + var_48_31 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_21) / var_48_31

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_21 + var_48_31 and arg_45_1.time_ < var_48_21 + var_48_31 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play412031012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 412031012
		arg_49_1.duration_ = 8

		local var_49_0 = {
			zh = 6.033,
			ja = 8
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
				arg_49_0:Play412031013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1097ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1097ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1097ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["1097ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1097ui_story == nil then
				arg_49_1.var_.characterEffect1097ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect1097ui_story and not isNil(var_52_9) then
					arg_49_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1097ui_story then
				arg_49_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_52_13 = 0

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_52_14 = 0

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_15 = arg_49_1.actors_["3043ui_story"]
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.characterEffect3043ui_story == nil then
				arg_49_1.var_.characterEffect3043ui_story = var_52_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_17 = 0.200000002980232

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 and not isNil(var_52_15) then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17

				if arg_49_1.var_.characterEffect3043ui_story and not isNil(var_52_15) then
					local var_52_19 = Mathf.Lerp(0, 0.5, var_52_18)

					arg_49_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_49_1.var_.characterEffect3043ui_story.fillRatio = var_52_19
				end
			end

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.characterEffect3043ui_story then
				local var_52_20 = 0.5

				arg_49_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_49_1.var_.characterEffect3043ui_story.fillRatio = var_52_20
			end

			local var_52_21 = 0
			local var_52_22 = 0.475

			if var_52_21 < arg_49_1.time_ and arg_49_1.time_ <= var_52_21 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_23 = arg_49_1:FormatText(StoryNameCfg[216].name)

				arg_49_1.leftNameTxt_.text = var_52_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_24 = arg_49_1:GetWordFromCfg(412031012)
				local var_52_25 = arg_49_1:FormatText(var_52_24.content)

				arg_49_1.text_.text = var_52_25

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_26 = 19
				local var_52_27 = utf8.len(var_52_25)
				local var_52_28 = var_52_26 <= 0 and var_52_22 or var_52_22 * (var_52_27 / var_52_26)

				if var_52_28 > 0 and var_52_22 < var_52_28 then
					arg_49_1.talkMaxDuration = var_52_28

					if var_52_28 + var_52_21 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_28 + var_52_21
					end
				end

				arg_49_1.text_.text = var_52_25
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031012", "story_v_out_412031.awb") ~= 0 then
					local var_52_29 = manager.audio:GetVoiceLength("story_v_out_412031", "412031012", "story_v_out_412031.awb") / 1000

					if var_52_29 + var_52_21 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_29 + var_52_21
					end

					if var_52_24.prefab_name ~= "" and arg_49_1.actors_[var_52_24.prefab_name] ~= nil then
						local var_52_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_24.prefab_name].transform, "story_v_out_412031", "412031012", "story_v_out_412031.awb")

						arg_49_1:RecordAudio("412031012", var_52_30)
						arg_49_1:RecordAudio("412031012", var_52_30)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_412031", "412031012", "story_v_out_412031.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_412031", "412031012", "story_v_out_412031.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_31 = math.max(var_52_22, arg_49_1.talkMaxDuration)

			if var_52_21 <= arg_49_1.time_ and arg_49_1.time_ < var_52_21 + var_52_31 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_21) / var_52_31

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_21 + var_52_31 and arg_49_1.time_ < var_52_21 + var_52_31 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play412031013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 412031013
		arg_53_1.duration_ = 11.77

		local var_53_0 = {
			zh = 5.666,
			ja = 11.766
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
				arg_53_0:Play412031014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["3043ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect3043ui_story == nil then
				arg_53_1.var_.characterEffect3043ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect3043ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect3043ui_story then
				arg_53_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_56_4 = 0

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_56_5 = 0

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_6 = arg_53_1.actors_["1097ui_story"]
			local var_56_7 = 0

			if var_56_7 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect1097ui_story == nil then
				arg_53_1.var_.characterEffect1097ui_story = var_56_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_8 = 0.200000002980232

			if var_56_7 <= arg_53_1.time_ and arg_53_1.time_ < var_56_7 + var_56_8 and not isNil(var_56_6) then
				local var_56_9 = (arg_53_1.time_ - var_56_7) / var_56_8

				if arg_53_1.var_.characterEffect1097ui_story and not isNil(var_56_6) then
					local var_56_10 = Mathf.Lerp(0, 0.5, var_56_9)

					arg_53_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1097ui_story.fillRatio = var_56_10
				end
			end

			if arg_53_1.time_ >= var_56_7 + var_56_8 and arg_53_1.time_ < var_56_7 + var_56_8 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect1097ui_story then
				local var_56_11 = 0.5

				arg_53_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1097ui_story.fillRatio = var_56_11
			end

			local var_56_12 = 0
			local var_56_13 = 0.6

			if var_56_12 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_14 = arg_53_1:FormatText(StoryNameCfg[920].name)

				arg_53_1.leftNameTxt_.text = var_56_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_15 = arg_53_1:GetWordFromCfg(412031013)
				local var_56_16 = arg_53_1:FormatText(var_56_15.content)

				arg_53_1.text_.text = var_56_16

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_17 = 24
				local var_56_18 = utf8.len(var_56_16)
				local var_56_19 = var_56_17 <= 0 and var_56_13 or var_56_13 * (var_56_18 / var_56_17)

				if var_56_19 > 0 and var_56_13 < var_56_19 then
					arg_53_1.talkMaxDuration = var_56_19

					if var_56_19 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_19 + var_56_12
					end
				end

				arg_53_1.text_.text = var_56_16
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031013", "story_v_out_412031.awb") ~= 0 then
					local var_56_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031013", "story_v_out_412031.awb") / 1000

					if var_56_20 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_20 + var_56_12
					end

					if var_56_15.prefab_name ~= "" and arg_53_1.actors_[var_56_15.prefab_name] ~= nil then
						local var_56_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_15.prefab_name].transform, "story_v_out_412031", "412031013", "story_v_out_412031.awb")

						arg_53_1:RecordAudio("412031013", var_56_21)
						arg_53_1:RecordAudio("412031013", var_56_21)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_412031", "412031013", "story_v_out_412031.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_412031", "412031013", "story_v_out_412031.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_22 = math.max(var_56_13, arg_53_1.talkMaxDuration)

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_22 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_12) / var_56_22

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_12 + var_56_22 and arg_53_1.time_ < var_56_12 + var_56_22 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play412031014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 412031014
		arg_57_1.duration_ = 4.43

		local var_57_0 = {
			zh = 2.766,
			ja = 4.433
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
				arg_57_0:Play412031015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1097ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1097ui_story == nil then
				arg_57_1.var_.characterEffect1097ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1097ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1097ui_story then
				arg_57_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_60_4 = 0

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_6 = arg_57_1.actors_["3043ui_story"]
			local var_60_7 = 0

			if var_60_7 < arg_57_1.time_ and arg_57_1.time_ <= var_60_7 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect3043ui_story == nil then
				arg_57_1.var_.characterEffect3043ui_story = var_60_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_8 = 0.200000002980232

			if var_60_7 <= arg_57_1.time_ and arg_57_1.time_ < var_60_7 + var_60_8 and not isNil(var_60_6) then
				local var_60_9 = (arg_57_1.time_ - var_60_7) / var_60_8

				if arg_57_1.var_.characterEffect3043ui_story and not isNil(var_60_6) then
					local var_60_10 = Mathf.Lerp(0, 0.5, var_60_9)

					arg_57_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_57_1.var_.characterEffect3043ui_story.fillRatio = var_60_10
				end
			end

			if arg_57_1.time_ >= var_60_7 + var_60_8 and arg_57_1.time_ < var_60_7 + var_60_8 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect3043ui_story then
				local var_60_11 = 0.5

				arg_57_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_57_1.var_.characterEffect3043ui_story.fillRatio = var_60_11
			end

			local var_60_12 = 0
			local var_60_13 = 0.175

			if var_60_12 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_14 = arg_57_1:FormatText(StoryNameCfg[216].name)

				arg_57_1.leftNameTxt_.text = var_60_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_15 = arg_57_1:GetWordFromCfg(412031014)
				local var_60_16 = arg_57_1:FormatText(var_60_15.content)

				arg_57_1.text_.text = var_60_16

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_17 = 7
				local var_60_18 = utf8.len(var_60_16)
				local var_60_19 = var_60_17 <= 0 and var_60_13 or var_60_13 * (var_60_18 / var_60_17)

				if var_60_19 > 0 and var_60_13 < var_60_19 then
					arg_57_1.talkMaxDuration = var_60_19

					if var_60_19 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_19 + var_60_12
					end
				end

				arg_57_1.text_.text = var_60_16
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031014", "story_v_out_412031.awb") ~= 0 then
					local var_60_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031014", "story_v_out_412031.awb") / 1000

					if var_60_20 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_20 + var_60_12
					end

					if var_60_15.prefab_name ~= "" and arg_57_1.actors_[var_60_15.prefab_name] ~= nil then
						local var_60_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_15.prefab_name].transform, "story_v_out_412031", "412031014", "story_v_out_412031.awb")

						arg_57_1:RecordAudio("412031014", var_60_21)
						arg_57_1:RecordAudio("412031014", var_60_21)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_412031", "412031014", "story_v_out_412031.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_412031", "412031014", "story_v_out_412031.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_22 = math.max(var_60_13, arg_57_1.talkMaxDuration)

			if var_60_12 <= arg_57_1.time_ and arg_57_1.time_ < var_60_12 + var_60_22 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_12) / var_60_22

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_12 + var_60_22 and arg_57_1.time_ < var_60_12 + var_60_22 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play412031015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 412031015
		arg_61_1.duration_ = 8.57

		local var_61_0 = {
			zh = 4.3,
			ja = 8.566
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play412031016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["3043ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect3043ui_story == nil then
				arg_61_1.var_.characterEffect3043ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect3043ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect3043ui_story then
				arg_61_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_64_4 = arg_61_1.actors_["1097ui_story"]
			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect1097ui_story == nil then
				arg_61_1.var_.characterEffect1097ui_story = var_64_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_6 = 0.200000002980232

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_6 and not isNil(var_64_4) then
				local var_64_7 = (arg_61_1.time_ - var_64_5) / var_64_6

				if arg_61_1.var_.characterEffect1097ui_story and not isNil(var_64_4) then
					local var_64_8 = Mathf.Lerp(0, 0.5, var_64_7)

					arg_61_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1097ui_story.fillRatio = var_64_8
				end
			end

			if arg_61_1.time_ >= var_64_5 + var_64_6 and arg_61_1.time_ < var_64_5 + var_64_6 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect1097ui_story then
				local var_64_9 = 0.5

				arg_61_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1097ui_story.fillRatio = var_64_9
			end

			local var_64_10 = 0
			local var_64_11 = 0.375

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_12 = arg_61_1:FormatText(StoryNameCfg[920].name)

				arg_61_1.leftNameTxt_.text = var_64_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_13 = arg_61_1:GetWordFromCfg(412031015)
				local var_64_14 = arg_61_1:FormatText(var_64_13.content)

				arg_61_1.text_.text = var_64_14

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_15 = 15
				local var_64_16 = utf8.len(var_64_14)
				local var_64_17 = var_64_15 <= 0 and var_64_11 or var_64_11 * (var_64_16 / var_64_15)

				if var_64_17 > 0 and var_64_11 < var_64_17 then
					arg_61_1.talkMaxDuration = var_64_17

					if var_64_17 + var_64_10 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_17 + var_64_10
					end
				end

				arg_61_1.text_.text = var_64_14
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031015", "story_v_out_412031.awb") ~= 0 then
					local var_64_18 = manager.audio:GetVoiceLength("story_v_out_412031", "412031015", "story_v_out_412031.awb") / 1000

					if var_64_18 + var_64_10 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_18 + var_64_10
					end

					if var_64_13.prefab_name ~= "" and arg_61_1.actors_[var_64_13.prefab_name] ~= nil then
						local var_64_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_13.prefab_name].transform, "story_v_out_412031", "412031015", "story_v_out_412031.awb")

						arg_61_1:RecordAudio("412031015", var_64_19)
						arg_61_1:RecordAudio("412031015", var_64_19)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_412031", "412031015", "story_v_out_412031.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_412031", "412031015", "story_v_out_412031.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_20 = math.max(var_64_11, arg_61_1.talkMaxDuration)

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_20 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_10) / var_64_20

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_10 + var_64_20 and arg_61_1.time_ < var_64_10 + var_64_20 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play412031016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 412031016
		arg_65_1.duration_ = 6.63

		local var_65_0 = {
			zh = 6.333,
			ja = 6.633
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play412031017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = "10083ui_story"

			if arg_65_1.actors_[var_68_0] == nil then
				local var_68_1 = Asset.Load("Char/" .. "10083ui_story")

				if not isNil(var_68_1) then
					local var_68_2 = Object.Instantiate(Asset.Load("Char/" .. "10083ui_story"), arg_65_1.stage_.transform)

					var_68_2.name = var_68_0
					var_68_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_65_1.actors_[var_68_0] = var_68_2

					local var_68_3 = var_68_2:GetComponentInChildren(typeof(CharacterEffect))

					var_68_3.enabled = true

					local var_68_4 = GameObjectTools.GetOrAddComponent(var_68_2, typeof(DynamicBoneHelper))

					if var_68_4 then
						var_68_4:EnableDynamicBone(false)
					end

					arg_65_1:ShowWeapon(var_68_3.transform, false)

					arg_65_1.var_[var_68_0 .. "Animator"] = var_68_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_65_1.var_[var_68_0 .. "Animator"].applyRootMotion = true
					arg_65_1.var_[var_68_0 .. "LipSync"] = var_68_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_68_5 = arg_65_1.actors_["10083ui_story"].transform
			local var_68_6 = 0

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.var_.moveOldPos10083ui_story = var_68_5.localPosition
			end

			local var_68_7 = 0.001

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_7 then
				local var_68_8 = (arg_65_1.time_ - var_68_6) / var_68_7
				local var_68_9 = Vector3.New(0, -2.6, -2.8)

				var_68_5.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10083ui_story, var_68_9, var_68_8)

				local var_68_10 = manager.ui.mainCamera.transform.position - var_68_5.position

				var_68_5.forward = Vector3.New(var_68_10.x, var_68_10.y, var_68_10.z)

				local var_68_11 = var_68_5.localEulerAngles

				var_68_11.z = 0
				var_68_11.x = 0
				var_68_5.localEulerAngles = var_68_11
			end

			if arg_65_1.time_ >= var_68_6 + var_68_7 and arg_65_1.time_ < var_68_6 + var_68_7 + arg_68_0 then
				var_68_5.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_68_12 = manager.ui.mainCamera.transform.position - var_68_5.position

				var_68_5.forward = Vector3.New(var_68_12.x, var_68_12.y, var_68_12.z)

				local var_68_13 = var_68_5.localEulerAngles

				var_68_13.z = 0
				var_68_13.x = 0
				var_68_5.localEulerAngles = var_68_13
			end

			local var_68_14 = arg_65_1.actors_["10083ui_story"]
			local var_68_15 = 0

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 and not isNil(var_68_14) and arg_65_1.var_.characterEffect10083ui_story == nil then
				arg_65_1.var_.characterEffect10083ui_story = var_68_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_16 = 0.200000002980232

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_16 and not isNil(var_68_14) then
				local var_68_17 = (arg_65_1.time_ - var_68_15) / var_68_16

				if arg_65_1.var_.characterEffect10083ui_story and not isNil(var_68_14) then
					arg_65_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_15 + var_68_16 and arg_65_1.time_ < var_68_15 + var_68_16 + arg_68_0 and not isNil(var_68_14) and arg_65_1.var_.characterEffect10083ui_story then
				arg_65_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_68_18 = 0

			if var_68_18 < arg_65_1.time_ and arg_65_1.time_ <= var_68_18 + arg_68_0 then
				arg_65_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_1")
			end

			local var_68_19 = 0

			if var_68_19 < arg_65_1.time_ and arg_65_1.time_ <= var_68_19 + arg_68_0 then
				arg_65_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_20 = arg_65_1.actors_["3043ui_story"].transform
			local var_68_21 = 0

			if var_68_21 < arg_65_1.time_ and arg_65_1.time_ <= var_68_21 + arg_68_0 then
				arg_65_1.var_.moveOldPos3043ui_story = var_68_20.localPosition
			end

			local var_68_22 = 0.001

			if var_68_21 <= arg_65_1.time_ and arg_65_1.time_ < var_68_21 + var_68_22 then
				local var_68_23 = (arg_65_1.time_ - var_68_21) / var_68_22
				local var_68_24 = Vector3.New(0, 100, 0)

				var_68_20.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos3043ui_story, var_68_24, var_68_23)

				local var_68_25 = manager.ui.mainCamera.transform.position - var_68_20.position

				var_68_20.forward = Vector3.New(var_68_25.x, var_68_25.y, var_68_25.z)

				local var_68_26 = var_68_20.localEulerAngles

				var_68_26.z = 0
				var_68_26.x = 0
				var_68_20.localEulerAngles = var_68_26
			end

			if arg_65_1.time_ >= var_68_21 + var_68_22 and arg_65_1.time_ < var_68_21 + var_68_22 + arg_68_0 then
				var_68_20.localPosition = Vector3.New(0, 100, 0)

				local var_68_27 = manager.ui.mainCamera.transform.position - var_68_20.position

				var_68_20.forward = Vector3.New(var_68_27.x, var_68_27.y, var_68_27.z)

				local var_68_28 = var_68_20.localEulerAngles

				var_68_28.z = 0
				var_68_28.x = 0
				var_68_20.localEulerAngles = var_68_28
			end

			local var_68_29 = arg_65_1.actors_["3043ui_story"]
			local var_68_30 = 0

			if var_68_30 < arg_65_1.time_ and arg_65_1.time_ <= var_68_30 + arg_68_0 and not isNil(var_68_29) and arg_65_1.var_.characterEffect3043ui_story == nil then
				arg_65_1.var_.characterEffect3043ui_story = var_68_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_31 = 0.200000002980232

			if var_68_30 <= arg_65_1.time_ and arg_65_1.time_ < var_68_30 + var_68_31 and not isNil(var_68_29) then
				local var_68_32 = (arg_65_1.time_ - var_68_30) / var_68_31

				if arg_65_1.var_.characterEffect3043ui_story and not isNil(var_68_29) then
					local var_68_33 = Mathf.Lerp(0, 0.5, var_68_32)

					arg_65_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_65_1.var_.characterEffect3043ui_story.fillRatio = var_68_33
				end
			end

			if arg_65_1.time_ >= var_68_30 + var_68_31 and arg_65_1.time_ < var_68_30 + var_68_31 + arg_68_0 and not isNil(var_68_29) and arg_65_1.var_.characterEffect3043ui_story then
				local var_68_34 = 0.5

				arg_65_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_65_1.var_.characterEffect3043ui_story.fillRatio = var_68_34
			end

			local var_68_35 = arg_65_1.actors_["1097ui_story"].transform
			local var_68_36 = 0

			if var_68_36 < arg_65_1.time_ and arg_65_1.time_ <= var_68_36 + arg_68_0 then
				arg_65_1.var_.moveOldPos1097ui_story = var_68_35.localPosition
			end

			local var_68_37 = 0.001

			if var_68_36 <= arg_65_1.time_ and arg_65_1.time_ < var_68_36 + var_68_37 then
				local var_68_38 = (arg_65_1.time_ - var_68_36) / var_68_37
				local var_68_39 = Vector3.New(0, 100, 0)

				var_68_35.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1097ui_story, var_68_39, var_68_38)

				local var_68_40 = manager.ui.mainCamera.transform.position - var_68_35.position

				var_68_35.forward = Vector3.New(var_68_40.x, var_68_40.y, var_68_40.z)

				local var_68_41 = var_68_35.localEulerAngles

				var_68_41.z = 0
				var_68_41.x = 0
				var_68_35.localEulerAngles = var_68_41
			end

			if arg_65_1.time_ >= var_68_36 + var_68_37 and arg_65_1.time_ < var_68_36 + var_68_37 + arg_68_0 then
				var_68_35.localPosition = Vector3.New(0, 100, 0)

				local var_68_42 = manager.ui.mainCamera.transform.position - var_68_35.position

				var_68_35.forward = Vector3.New(var_68_42.x, var_68_42.y, var_68_42.z)

				local var_68_43 = var_68_35.localEulerAngles

				var_68_43.z = 0
				var_68_43.x = 0
				var_68_35.localEulerAngles = var_68_43
			end

			local var_68_44 = arg_65_1.actors_["1097ui_story"]
			local var_68_45 = 0

			if var_68_45 < arg_65_1.time_ and arg_65_1.time_ <= var_68_45 + arg_68_0 and not isNil(var_68_44) and arg_65_1.var_.characterEffect1097ui_story == nil then
				arg_65_1.var_.characterEffect1097ui_story = var_68_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_46 = 0.200000002980232

			if var_68_45 <= arg_65_1.time_ and arg_65_1.time_ < var_68_45 + var_68_46 and not isNil(var_68_44) then
				local var_68_47 = (arg_65_1.time_ - var_68_45) / var_68_46

				if arg_65_1.var_.characterEffect1097ui_story and not isNil(var_68_44) then
					local var_68_48 = Mathf.Lerp(0, 0.5, var_68_47)

					arg_65_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1097ui_story.fillRatio = var_68_48
				end
			end

			if arg_65_1.time_ >= var_68_45 + var_68_46 and arg_65_1.time_ < var_68_45 + var_68_46 + arg_68_0 and not isNil(var_68_44) and arg_65_1.var_.characterEffect1097ui_story then
				local var_68_49 = 0.5

				arg_65_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1097ui_story.fillRatio = var_68_49
			end

			local var_68_50 = 0
			local var_68_51 = 0.625

			if var_68_50 < arg_65_1.time_ and arg_65_1.time_ <= var_68_50 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_52 = arg_65_1:FormatText(StoryNameCfg[918].name)

				arg_65_1.leftNameTxt_.text = var_68_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_53 = arg_65_1:GetWordFromCfg(412031016)
				local var_68_54 = arg_65_1:FormatText(var_68_53.content)

				arg_65_1.text_.text = var_68_54

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_55 = 25
				local var_68_56 = utf8.len(var_68_54)
				local var_68_57 = var_68_55 <= 0 and var_68_51 or var_68_51 * (var_68_56 / var_68_55)

				if var_68_57 > 0 and var_68_51 < var_68_57 then
					arg_65_1.talkMaxDuration = var_68_57

					if var_68_57 + var_68_50 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_57 + var_68_50
					end
				end

				arg_65_1.text_.text = var_68_54
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031016", "story_v_out_412031.awb") ~= 0 then
					local var_68_58 = manager.audio:GetVoiceLength("story_v_out_412031", "412031016", "story_v_out_412031.awb") / 1000

					if var_68_58 + var_68_50 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_58 + var_68_50
					end

					if var_68_53.prefab_name ~= "" and arg_65_1.actors_[var_68_53.prefab_name] ~= nil then
						local var_68_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_53.prefab_name].transform, "story_v_out_412031", "412031016", "story_v_out_412031.awb")

						arg_65_1:RecordAudio("412031016", var_68_59)
						arg_65_1:RecordAudio("412031016", var_68_59)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_412031", "412031016", "story_v_out_412031.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_412031", "412031016", "story_v_out_412031.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_60 = math.max(var_68_51, arg_65_1.talkMaxDuration)

			if var_68_50 <= arg_65_1.time_ and arg_65_1.time_ < var_68_50 + var_68_60 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_50) / var_68_60

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_50 + var_68_60 and arg_65_1.time_ < var_68_50 + var_68_60 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play412031017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 412031017
		arg_69_1.duration_ = 5.47

		local var_69_0 = {
			zh = 5.466,
			ja = 3.833
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
				arg_69_0:Play412031018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = "10076ui_story"

			if arg_69_1.actors_[var_72_0] == nil then
				local var_72_1 = Asset.Load("Char/" .. "10076ui_story")

				if not isNil(var_72_1) then
					local var_72_2 = Object.Instantiate(Asset.Load("Char/" .. "10076ui_story"), arg_69_1.stage_.transform)

					var_72_2.name = var_72_0
					var_72_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_69_1.actors_[var_72_0] = var_72_2

					local var_72_3 = var_72_2:GetComponentInChildren(typeof(CharacterEffect))

					var_72_3.enabled = true

					local var_72_4 = GameObjectTools.GetOrAddComponent(var_72_2, typeof(DynamicBoneHelper))

					if var_72_4 then
						var_72_4:EnableDynamicBone(false)
					end

					arg_69_1:ShowWeapon(var_72_3.transform, false)

					arg_69_1.var_[var_72_0 .. "Animator"] = var_72_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_69_1.var_[var_72_0 .. "Animator"].applyRootMotion = true
					arg_69_1.var_[var_72_0 .. "LipSync"] = var_72_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_72_5 = arg_69_1.actors_["10076ui_story"].transform
			local var_72_6 = 0

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.var_.moveOldPos10076ui_story = var_72_5.localPosition
			end

			local var_72_7 = 0.001

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_7 then
				local var_72_8 = (arg_69_1.time_ - var_72_6) / var_72_7
				local var_72_9 = Vector3.New(0, -0.35, -4)

				var_72_5.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10076ui_story, var_72_9, var_72_8)

				local var_72_10 = manager.ui.mainCamera.transform.position - var_72_5.position

				var_72_5.forward = Vector3.New(var_72_10.x, var_72_10.y, var_72_10.z)

				local var_72_11 = var_72_5.localEulerAngles

				var_72_11.z = 0
				var_72_11.x = 0
				var_72_5.localEulerAngles = var_72_11
			end

			if arg_69_1.time_ >= var_72_6 + var_72_7 and arg_69_1.time_ < var_72_6 + var_72_7 + arg_72_0 then
				var_72_5.localPosition = Vector3.New(0, -0.35, -4)

				local var_72_12 = manager.ui.mainCamera.transform.position - var_72_5.position

				var_72_5.forward = Vector3.New(var_72_12.x, var_72_12.y, var_72_12.z)

				local var_72_13 = var_72_5.localEulerAngles

				var_72_13.z = 0
				var_72_13.x = 0
				var_72_5.localEulerAngles = var_72_13
			end

			local var_72_14 = arg_69_1.actors_["10076ui_story"]
			local var_72_15 = 0

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 and not isNil(var_72_14) and arg_69_1.var_.characterEffect10076ui_story == nil then
				arg_69_1.var_.characterEffect10076ui_story = var_72_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_16 = 0.200000002980232

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_16 and not isNil(var_72_14) then
				local var_72_17 = (arg_69_1.time_ - var_72_15) / var_72_16

				if arg_69_1.var_.characterEffect10076ui_story and not isNil(var_72_14) then
					arg_69_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_15 + var_72_16 and arg_69_1.time_ < var_72_15 + var_72_16 + arg_72_0 and not isNil(var_72_14) and arg_69_1.var_.characterEffect10076ui_story then
				arg_69_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_72_18 = 0

			if var_72_18 < arg_69_1.time_ and arg_69_1.time_ <= var_72_18 + arg_72_0 then
				arg_69_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action2_1")
			end

			local var_72_19 = 0

			if var_72_19 < arg_69_1.time_ and arg_69_1.time_ <= var_72_19 + arg_72_0 then
				arg_69_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_20 = arg_69_1.actors_["10083ui_story"].transform
			local var_72_21 = 0

			if var_72_21 < arg_69_1.time_ and arg_69_1.time_ <= var_72_21 + arg_72_0 then
				arg_69_1.var_.moveOldPos10083ui_story = var_72_20.localPosition
			end

			local var_72_22 = 0.001

			if var_72_21 <= arg_69_1.time_ and arg_69_1.time_ < var_72_21 + var_72_22 then
				local var_72_23 = (arg_69_1.time_ - var_72_21) / var_72_22
				local var_72_24 = Vector3.New(0, 100, 0)

				var_72_20.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10083ui_story, var_72_24, var_72_23)

				local var_72_25 = manager.ui.mainCamera.transform.position - var_72_20.position

				var_72_20.forward = Vector3.New(var_72_25.x, var_72_25.y, var_72_25.z)

				local var_72_26 = var_72_20.localEulerAngles

				var_72_26.z = 0
				var_72_26.x = 0
				var_72_20.localEulerAngles = var_72_26
			end

			if arg_69_1.time_ >= var_72_21 + var_72_22 and arg_69_1.time_ < var_72_21 + var_72_22 + arg_72_0 then
				var_72_20.localPosition = Vector3.New(0, 100, 0)

				local var_72_27 = manager.ui.mainCamera.transform.position - var_72_20.position

				var_72_20.forward = Vector3.New(var_72_27.x, var_72_27.y, var_72_27.z)

				local var_72_28 = var_72_20.localEulerAngles

				var_72_28.z = 0
				var_72_28.x = 0
				var_72_20.localEulerAngles = var_72_28
			end

			local var_72_29 = arg_69_1.actors_["10083ui_story"]
			local var_72_30 = 0

			if var_72_30 < arg_69_1.time_ and arg_69_1.time_ <= var_72_30 + arg_72_0 and not isNil(var_72_29) and arg_69_1.var_.characterEffect10083ui_story == nil then
				arg_69_1.var_.characterEffect10083ui_story = var_72_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_31 = 0.200000002980232

			if var_72_30 <= arg_69_1.time_ and arg_69_1.time_ < var_72_30 + var_72_31 and not isNil(var_72_29) then
				local var_72_32 = (arg_69_1.time_ - var_72_30) / var_72_31

				if arg_69_1.var_.characterEffect10083ui_story and not isNil(var_72_29) then
					local var_72_33 = Mathf.Lerp(0, 0.5, var_72_32)

					arg_69_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10083ui_story.fillRatio = var_72_33
				end
			end

			if arg_69_1.time_ >= var_72_30 + var_72_31 and arg_69_1.time_ < var_72_30 + var_72_31 + arg_72_0 and not isNil(var_72_29) and arg_69_1.var_.characterEffect10083ui_story then
				local var_72_34 = 0.5

				arg_69_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10083ui_story.fillRatio = var_72_34
			end

			local var_72_35 = 0
			local var_72_36 = 0.675

			if var_72_35 < arg_69_1.time_ and arg_69_1.time_ <= var_72_35 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_37 = arg_69_1:FormatText(StoryNameCfg[917].name)

				arg_69_1.leftNameTxt_.text = var_72_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_38 = arg_69_1:GetWordFromCfg(412031017)
				local var_72_39 = arg_69_1:FormatText(var_72_38.content)

				arg_69_1.text_.text = var_72_39

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_40 = 27
				local var_72_41 = utf8.len(var_72_39)
				local var_72_42 = var_72_40 <= 0 and var_72_36 or var_72_36 * (var_72_41 / var_72_40)

				if var_72_42 > 0 and var_72_36 < var_72_42 then
					arg_69_1.talkMaxDuration = var_72_42

					if var_72_42 + var_72_35 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_42 + var_72_35
					end
				end

				arg_69_1.text_.text = var_72_39
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031017", "story_v_out_412031.awb") ~= 0 then
					local var_72_43 = manager.audio:GetVoiceLength("story_v_out_412031", "412031017", "story_v_out_412031.awb") / 1000

					if var_72_43 + var_72_35 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_43 + var_72_35
					end

					if var_72_38.prefab_name ~= "" and arg_69_1.actors_[var_72_38.prefab_name] ~= nil then
						local var_72_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_38.prefab_name].transform, "story_v_out_412031", "412031017", "story_v_out_412031.awb")

						arg_69_1:RecordAudio("412031017", var_72_44)
						arg_69_1:RecordAudio("412031017", var_72_44)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_412031", "412031017", "story_v_out_412031.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_412031", "412031017", "story_v_out_412031.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_45 = math.max(var_72_36, arg_69_1.talkMaxDuration)

			if var_72_35 <= arg_69_1.time_ and arg_69_1.time_ < var_72_35 + var_72_45 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_35) / var_72_45

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_35 + var_72_45 and arg_69_1.time_ < var_72_35 + var_72_45 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play412031018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 412031018
		arg_73_1.duration_ = 2

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play412031019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = "10078ui_story"

			if arg_73_1.actors_[var_76_0] == nil then
				local var_76_1 = Asset.Load("Char/" .. "10078ui_story")

				if not isNil(var_76_1) then
					local var_76_2 = Object.Instantiate(Asset.Load("Char/" .. "10078ui_story"), arg_73_1.stage_.transform)

					var_76_2.name = var_76_0
					var_76_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_73_1.actors_[var_76_0] = var_76_2

					local var_76_3 = var_76_2:GetComponentInChildren(typeof(CharacterEffect))

					var_76_3.enabled = true

					local var_76_4 = GameObjectTools.GetOrAddComponent(var_76_2, typeof(DynamicBoneHelper))

					if var_76_4 then
						var_76_4:EnableDynamicBone(false)
					end

					arg_73_1:ShowWeapon(var_76_3.transform, false)

					arg_73_1.var_[var_76_0 .. "Animator"] = var_76_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_73_1.var_[var_76_0 .. "Animator"].applyRootMotion = true
					arg_73_1.var_[var_76_0 .. "LipSync"] = var_76_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_76_5 = arg_73_1.actors_["10078ui_story"].transform
			local var_76_6 = 0

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.var_.moveOldPos10078ui_story = var_76_5.localPosition
			end

			local var_76_7 = 0.001

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_7 then
				local var_76_8 = (arg_73_1.time_ - var_76_6) / var_76_7
				local var_76_9 = Vector3.New(0, -0.5, -6.3)

				var_76_5.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10078ui_story, var_76_9, var_76_8)

				local var_76_10 = manager.ui.mainCamera.transform.position - var_76_5.position

				var_76_5.forward = Vector3.New(var_76_10.x, var_76_10.y, var_76_10.z)

				local var_76_11 = var_76_5.localEulerAngles

				var_76_11.z = 0
				var_76_11.x = 0
				var_76_5.localEulerAngles = var_76_11
			end

			if arg_73_1.time_ >= var_76_6 + var_76_7 and arg_73_1.time_ < var_76_6 + var_76_7 + arg_76_0 then
				var_76_5.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_76_12 = manager.ui.mainCamera.transform.position - var_76_5.position

				var_76_5.forward = Vector3.New(var_76_12.x, var_76_12.y, var_76_12.z)

				local var_76_13 = var_76_5.localEulerAngles

				var_76_13.z = 0
				var_76_13.x = 0
				var_76_5.localEulerAngles = var_76_13
			end

			local var_76_14 = arg_73_1.actors_["10078ui_story"]
			local var_76_15 = 0

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 and not isNil(var_76_14) and arg_73_1.var_.characterEffect10078ui_story == nil then
				arg_73_1.var_.characterEffect10078ui_story = var_76_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_16 = 0.200000002980232

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_16 and not isNil(var_76_14) then
				local var_76_17 = (arg_73_1.time_ - var_76_15) / var_76_16

				if arg_73_1.var_.characterEffect10078ui_story and not isNil(var_76_14) then
					arg_73_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_15 + var_76_16 and arg_73_1.time_ < var_76_15 + var_76_16 + arg_76_0 and not isNil(var_76_14) and arg_73_1.var_.characterEffect10078ui_story then
				arg_73_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_76_18 = 0

			if var_76_18 < arg_73_1.time_ and arg_73_1.time_ <= var_76_18 + arg_76_0 then
				arg_73_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_76_19 = 0

			if var_76_19 < arg_73_1.time_ and arg_73_1.time_ <= var_76_19 + arg_76_0 then
				arg_73_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_76_20 = arg_73_1.actors_["10076ui_story"].transform
			local var_76_21 = 0

			if var_76_21 < arg_73_1.time_ and arg_73_1.time_ <= var_76_21 + arg_76_0 then
				arg_73_1.var_.moveOldPos10076ui_story = var_76_20.localPosition
			end

			local var_76_22 = 0.001

			if var_76_21 <= arg_73_1.time_ and arg_73_1.time_ < var_76_21 + var_76_22 then
				local var_76_23 = (arg_73_1.time_ - var_76_21) / var_76_22
				local var_76_24 = Vector3.New(0, 100, 0)

				var_76_20.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10076ui_story, var_76_24, var_76_23)

				local var_76_25 = manager.ui.mainCamera.transform.position - var_76_20.position

				var_76_20.forward = Vector3.New(var_76_25.x, var_76_25.y, var_76_25.z)

				local var_76_26 = var_76_20.localEulerAngles

				var_76_26.z = 0
				var_76_26.x = 0
				var_76_20.localEulerAngles = var_76_26
			end

			if arg_73_1.time_ >= var_76_21 + var_76_22 and arg_73_1.time_ < var_76_21 + var_76_22 + arg_76_0 then
				var_76_20.localPosition = Vector3.New(0, 100, 0)

				local var_76_27 = manager.ui.mainCamera.transform.position - var_76_20.position

				var_76_20.forward = Vector3.New(var_76_27.x, var_76_27.y, var_76_27.z)

				local var_76_28 = var_76_20.localEulerAngles

				var_76_28.z = 0
				var_76_28.x = 0
				var_76_20.localEulerAngles = var_76_28
			end

			local var_76_29 = arg_73_1.actors_["10076ui_story"]
			local var_76_30 = 0

			if var_76_30 < arg_73_1.time_ and arg_73_1.time_ <= var_76_30 + arg_76_0 and not isNil(var_76_29) and arg_73_1.var_.characterEffect10076ui_story == nil then
				arg_73_1.var_.characterEffect10076ui_story = var_76_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_31 = 0.200000002980232

			if var_76_30 <= arg_73_1.time_ and arg_73_1.time_ < var_76_30 + var_76_31 and not isNil(var_76_29) then
				local var_76_32 = (arg_73_1.time_ - var_76_30) / var_76_31

				if arg_73_1.var_.characterEffect10076ui_story and not isNil(var_76_29) then
					local var_76_33 = Mathf.Lerp(0, 0.5, var_76_32)

					arg_73_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10076ui_story.fillRatio = var_76_33
				end
			end

			if arg_73_1.time_ >= var_76_30 + var_76_31 and arg_73_1.time_ < var_76_30 + var_76_31 + arg_76_0 and not isNil(var_76_29) and arg_73_1.var_.characterEffect10076ui_story then
				local var_76_34 = 0.5

				arg_73_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10076ui_story.fillRatio = var_76_34
			end

			local var_76_35 = 0
			local var_76_36 = 0.05

			if var_76_35 < arg_73_1.time_ and arg_73_1.time_ <= var_76_35 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_37 = arg_73_1:FormatText(StoryNameCfg[919].name)

				arg_73_1.leftNameTxt_.text = var_76_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_38 = arg_73_1:GetWordFromCfg(412031018)
				local var_76_39 = arg_73_1:FormatText(var_76_38.content)

				arg_73_1.text_.text = var_76_39

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_40 = 2
				local var_76_41 = utf8.len(var_76_39)
				local var_76_42 = var_76_40 <= 0 and var_76_36 or var_76_36 * (var_76_41 / var_76_40)

				if var_76_42 > 0 and var_76_36 < var_76_42 then
					arg_73_1.talkMaxDuration = var_76_42

					if var_76_42 + var_76_35 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_42 + var_76_35
					end
				end

				arg_73_1.text_.text = var_76_39
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031018", "story_v_out_412031.awb") ~= 0 then
					local var_76_43 = manager.audio:GetVoiceLength("story_v_out_412031", "412031018", "story_v_out_412031.awb") / 1000

					if var_76_43 + var_76_35 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_43 + var_76_35
					end

					if var_76_38.prefab_name ~= "" and arg_73_1.actors_[var_76_38.prefab_name] ~= nil then
						local var_76_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_38.prefab_name].transform, "story_v_out_412031", "412031018", "story_v_out_412031.awb")

						arg_73_1:RecordAudio("412031018", var_76_44)
						arg_73_1:RecordAudio("412031018", var_76_44)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_412031", "412031018", "story_v_out_412031.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_412031", "412031018", "story_v_out_412031.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_45 = math.max(var_76_36, arg_73_1.talkMaxDuration)

			if var_76_35 <= arg_73_1.time_ and arg_73_1.time_ < var_76_35 + var_76_45 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_35) / var_76_45

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_35 + var_76_45 and arg_73_1.time_ < var_76_35 + var_76_45 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play412031019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 412031019
		arg_77_1.duration_ = 5.07

		local var_77_0 = {
			zh = 4.966,
			ja = 5.066
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
				arg_77_0:Play412031020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1097ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1097ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1097ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["1097ui_story"]
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect1097ui_story == nil then
				arg_77_1.var_.characterEffect1097ui_story = var_80_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 and not isNil(var_80_9) then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11

				if arg_77_1.var_.characterEffect1097ui_story and not isNil(var_80_9) then
					arg_77_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect1097ui_story then
				arg_77_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_80_13 = 0

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_80_14 = 0

			if var_80_14 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 then
				arg_77_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_15 = arg_77_1.actors_["10078ui_story"].transform
			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1.var_.moveOldPos10078ui_story = var_80_15.localPosition
			end

			local var_80_17 = 0.001

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_17 then
				local var_80_18 = (arg_77_1.time_ - var_80_16) / var_80_17
				local var_80_19 = Vector3.New(0, 100, 0)

				var_80_15.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10078ui_story, var_80_19, var_80_18)

				local var_80_20 = manager.ui.mainCamera.transform.position - var_80_15.position

				var_80_15.forward = Vector3.New(var_80_20.x, var_80_20.y, var_80_20.z)

				local var_80_21 = var_80_15.localEulerAngles

				var_80_21.z = 0
				var_80_21.x = 0
				var_80_15.localEulerAngles = var_80_21
			end

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 then
				var_80_15.localPosition = Vector3.New(0, 100, 0)

				local var_80_22 = manager.ui.mainCamera.transform.position - var_80_15.position

				var_80_15.forward = Vector3.New(var_80_22.x, var_80_22.y, var_80_22.z)

				local var_80_23 = var_80_15.localEulerAngles

				var_80_23.z = 0
				var_80_23.x = 0
				var_80_15.localEulerAngles = var_80_23
			end

			local var_80_24 = arg_77_1.actors_["10078ui_story"]
			local var_80_25 = 0

			if var_80_25 < arg_77_1.time_ and arg_77_1.time_ <= var_80_25 + arg_80_0 and not isNil(var_80_24) and arg_77_1.var_.characterEffect10078ui_story == nil then
				arg_77_1.var_.characterEffect10078ui_story = var_80_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_26 = 0.200000002980232

			if var_80_25 <= arg_77_1.time_ and arg_77_1.time_ < var_80_25 + var_80_26 and not isNil(var_80_24) then
				local var_80_27 = (arg_77_1.time_ - var_80_25) / var_80_26

				if arg_77_1.var_.characterEffect10078ui_story and not isNil(var_80_24) then
					local var_80_28 = Mathf.Lerp(0, 0.5, var_80_27)

					arg_77_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10078ui_story.fillRatio = var_80_28
				end
			end

			if arg_77_1.time_ >= var_80_25 + var_80_26 and arg_77_1.time_ < var_80_25 + var_80_26 + arg_80_0 and not isNil(var_80_24) and arg_77_1.var_.characterEffect10078ui_story then
				local var_80_29 = 0.5

				arg_77_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10078ui_story.fillRatio = var_80_29
			end

			local var_80_30 = 0
			local var_80_31 = 0.45

			if var_80_30 < arg_77_1.time_ and arg_77_1.time_ <= var_80_30 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_32 = arg_77_1:FormatText(StoryNameCfg[216].name)

				arg_77_1.leftNameTxt_.text = var_80_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_33 = arg_77_1:GetWordFromCfg(412031019)
				local var_80_34 = arg_77_1:FormatText(var_80_33.content)

				arg_77_1.text_.text = var_80_34

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_35 = 18
				local var_80_36 = utf8.len(var_80_34)
				local var_80_37 = var_80_35 <= 0 and var_80_31 or var_80_31 * (var_80_36 / var_80_35)

				if var_80_37 > 0 and var_80_31 < var_80_37 then
					arg_77_1.talkMaxDuration = var_80_37

					if var_80_37 + var_80_30 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_37 + var_80_30
					end
				end

				arg_77_1.text_.text = var_80_34
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031019", "story_v_out_412031.awb") ~= 0 then
					local var_80_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031019", "story_v_out_412031.awb") / 1000

					if var_80_38 + var_80_30 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_38 + var_80_30
					end

					if var_80_33.prefab_name ~= "" and arg_77_1.actors_[var_80_33.prefab_name] ~= nil then
						local var_80_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_33.prefab_name].transform, "story_v_out_412031", "412031019", "story_v_out_412031.awb")

						arg_77_1:RecordAudio("412031019", var_80_39)
						arg_77_1:RecordAudio("412031019", var_80_39)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_412031", "412031019", "story_v_out_412031.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_412031", "412031019", "story_v_out_412031.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_40 = math.max(var_80_31, arg_77_1.talkMaxDuration)

			if var_80_30 <= arg_77_1.time_ and arg_77_1.time_ < var_80_30 + var_80_40 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_30) / var_80_40

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_30 + var_80_40 and arg_77_1.time_ < var_80_30 + var_80_40 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play412031020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 412031020
		arg_81_1.duration_ = 7.37

		local var_81_0 = {
			zh = 5.066,
			ja = 7.366
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play412031021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["3043ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos3043ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0.7, -1.41, -5.7)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos3043ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0.7, -1.41, -5.7)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["3043ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect3043ui_story == nil then
				arg_81_1.var_.characterEffect3043ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect3043ui_story and not isNil(var_84_9) then
					arg_81_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect3043ui_story then
				arg_81_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_84_13 = 0

			if var_84_13 < arg_81_1.time_ and arg_81_1.time_ <= var_84_13 + arg_84_0 then
				arg_81_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action2_1")
			end

			local var_84_14 = 0

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_15 = arg_81_1.actors_["1097ui_story"]
			local var_84_16 = 0

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.characterEffect1097ui_story == nil then
				arg_81_1.var_.characterEffect1097ui_story = var_84_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_17 = 0.200000002980232

			if var_84_16 <= arg_81_1.time_ and arg_81_1.time_ < var_84_16 + var_84_17 and not isNil(var_84_15) then
				local var_84_18 = (arg_81_1.time_ - var_84_16) / var_84_17

				if arg_81_1.var_.characterEffect1097ui_story and not isNil(var_84_15) then
					local var_84_19 = Mathf.Lerp(0, 0.5, var_84_18)

					arg_81_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1097ui_story.fillRatio = var_84_19
				end
			end

			if arg_81_1.time_ >= var_84_16 + var_84_17 and arg_81_1.time_ < var_84_16 + var_84_17 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.characterEffect1097ui_story then
				local var_84_20 = 0.5

				arg_81_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1097ui_story.fillRatio = var_84_20
			end

			local var_84_21 = 0
			local var_84_22 = 0.525

			if var_84_21 < arg_81_1.time_ and arg_81_1.time_ <= var_84_21 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_23 = arg_81_1:FormatText(StoryNameCfg[920].name)

				arg_81_1.leftNameTxt_.text = var_84_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_24 = arg_81_1:GetWordFromCfg(412031020)
				local var_84_25 = arg_81_1:FormatText(var_84_24.content)

				arg_81_1.text_.text = var_84_25

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_26 = 21
				local var_84_27 = utf8.len(var_84_25)
				local var_84_28 = var_84_26 <= 0 and var_84_22 or var_84_22 * (var_84_27 / var_84_26)

				if var_84_28 > 0 and var_84_22 < var_84_28 then
					arg_81_1.talkMaxDuration = var_84_28

					if var_84_28 + var_84_21 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_28 + var_84_21
					end
				end

				arg_81_1.text_.text = var_84_25
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031020", "story_v_out_412031.awb") ~= 0 then
					local var_84_29 = manager.audio:GetVoiceLength("story_v_out_412031", "412031020", "story_v_out_412031.awb") / 1000

					if var_84_29 + var_84_21 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_29 + var_84_21
					end

					if var_84_24.prefab_name ~= "" and arg_81_1.actors_[var_84_24.prefab_name] ~= nil then
						local var_84_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_24.prefab_name].transform, "story_v_out_412031", "412031020", "story_v_out_412031.awb")

						arg_81_1:RecordAudio("412031020", var_84_30)
						arg_81_1:RecordAudio("412031020", var_84_30)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_412031", "412031020", "story_v_out_412031.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_412031", "412031020", "story_v_out_412031.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_31 = math.max(var_84_22, arg_81_1.talkMaxDuration)

			if var_84_21 <= arg_81_1.time_ and arg_81_1.time_ < var_84_21 + var_84_31 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_21) / var_84_31

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_21 + var_84_31 and arg_81_1.time_ < var_84_21 + var_84_31 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play412031021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 412031021
		arg_85_1.duration_ = 12.7

		local var_85_0 = {
			zh = 10.8,
			ja = 12.7
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
				arg_85_0:Play412031022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = "ST30"

			if arg_85_1.bgs_[var_88_0] == nil then
				local var_88_1 = Object.Instantiate(arg_85_1.paintGo_)

				var_88_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_88_0)
				var_88_1.name = var_88_0
				var_88_1.transform.parent = arg_85_1.stage_.transform
				var_88_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.bgs_[var_88_0] = var_88_1
			end

			local var_88_2 = 2

			if var_88_2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				local var_88_3 = manager.ui.mainCamera.transform.localPosition
				local var_88_4 = Vector3.New(0, 0, 10) + Vector3.New(var_88_3.x, var_88_3.y, 0)
				local var_88_5 = arg_85_1.bgs_.ST30

				var_88_5.transform.localPosition = var_88_4
				var_88_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_6 = var_88_5:GetComponent("SpriteRenderer")

				if var_88_6 and var_88_6.sprite then
					local var_88_7 = (var_88_5.transform.localPosition - var_88_3).z
					local var_88_8 = manager.ui.mainCameraCom_
					local var_88_9 = 2 * var_88_7 * Mathf.Tan(var_88_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_88_10 = var_88_9 * var_88_8.aspect
					local var_88_11 = var_88_6.sprite.bounds.size.x
					local var_88_12 = var_88_6.sprite.bounds.size.y
					local var_88_13 = var_88_10 / var_88_11
					local var_88_14 = var_88_9 / var_88_12
					local var_88_15 = var_88_14 < var_88_13 and var_88_13 or var_88_14

					var_88_5.transform.localScale = Vector3.New(var_88_15, var_88_15, 0)
				end

				for iter_88_0, iter_88_1 in pairs(arg_85_1.bgs_) do
					if iter_88_0 ~= "ST30" then
						iter_88_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_16 = 4

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1.allBtn_.enabled = false
			end

			local var_88_17 = 0.3

			if arg_85_1.time_ >= var_88_16 + var_88_17 and arg_85_1.time_ < var_88_16 + var_88_17 + arg_88_0 then
				arg_85_1.allBtn_.enabled = true
			end

			local var_88_18 = 0

			if var_88_18 < arg_85_1.time_ and arg_85_1.time_ <= var_88_18 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_19 = 2

			if var_88_18 <= arg_85_1.time_ and arg_85_1.time_ < var_88_18 + var_88_19 then
				local var_88_20 = (arg_85_1.time_ - var_88_18) / var_88_19
				local var_88_21 = Color.New(0, 0, 0)

				var_88_21.a = Mathf.Lerp(0, 1, var_88_20)
				arg_85_1.mask_.color = var_88_21
			end

			if arg_85_1.time_ >= var_88_18 + var_88_19 and arg_85_1.time_ < var_88_18 + var_88_19 + arg_88_0 then
				local var_88_22 = Color.New(0, 0, 0)

				var_88_22.a = 1
				arg_85_1.mask_.color = var_88_22
			end

			local var_88_23 = 2

			if var_88_23 < arg_85_1.time_ and arg_85_1.time_ <= var_88_23 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_24 = 2

			if var_88_23 <= arg_85_1.time_ and arg_85_1.time_ < var_88_23 + var_88_24 then
				local var_88_25 = (arg_85_1.time_ - var_88_23) / var_88_24
				local var_88_26 = Color.New(0, 0, 0)

				var_88_26.a = Mathf.Lerp(1, 0, var_88_25)
				arg_85_1.mask_.color = var_88_26
			end

			if arg_85_1.time_ >= var_88_23 + var_88_24 and arg_85_1.time_ < var_88_23 + var_88_24 + arg_88_0 then
				local var_88_27 = Color.New(0, 0, 0)
				local var_88_28 = 0

				arg_85_1.mask_.enabled = false
				var_88_27.a = var_88_28
				arg_85_1.mask_.color = var_88_27
			end

			local var_88_29 = arg_85_1.actors_["3043ui_story"].transform
			local var_88_30 = 3.8

			if var_88_30 < arg_85_1.time_ and arg_85_1.time_ <= var_88_30 + arg_88_0 then
				arg_85_1.var_.moveOldPos3043ui_story = var_88_29.localPosition
			end

			local var_88_31 = 0.001

			if var_88_30 <= arg_85_1.time_ and arg_85_1.time_ < var_88_30 + var_88_31 then
				local var_88_32 = (arg_85_1.time_ - var_88_30) / var_88_31
				local var_88_33 = Vector3.New(0, -1.41, -5.7)

				var_88_29.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos3043ui_story, var_88_33, var_88_32)

				local var_88_34 = manager.ui.mainCamera.transform.position - var_88_29.position

				var_88_29.forward = Vector3.New(var_88_34.x, var_88_34.y, var_88_34.z)

				local var_88_35 = var_88_29.localEulerAngles

				var_88_35.z = 0
				var_88_35.x = 0
				var_88_29.localEulerAngles = var_88_35
			end

			if arg_85_1.time_ >= var_88_30 + var_88_31 and arg_85_1.time_ < var_88_30 + var_88_31 + arg_88_0 then
				var_88_29.localPosition = Vector3.New(0, -1.41, -5.7)

				local var_88_36 = manager.ui.mainCamera.transform.position - var_88_29.position

				var_88_29.forward = Vector3.New(var_88_36.x, var_88_36.y, var_88_36.z)

				local var_88_37 = var_88_29.localEulerAngles

				var_88_37.z = 0
				var_88_37.x = 0
				var_88_29.localEulerAngles = var_88_37
			end

			local var_88_38 = arg_85_1.actors_["3043ui_story"]
			local var_88_39 = 3.8

			if var_88_39 < arg_85_1.time_ and arg_85_1.time_ <= var_88_39 + arg_88_0 and not isNil(var_88_38) and arg_85_1.var_.characterEffect3043ui_story == nil then
				arg_85_1.var_.characterEffect3043ui_story = var_88_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_40 = 0.200000002980232

			if var_88_39 <= arg_85_1.time_ and arg_85_1.time_ < var_88_39 + var_88_40 and not isNil(var_88_38) then
				local var_88_41 = (arg_85_1.time_ - var_88_39) / var_88_40

				if arg_85_1.var_.characterEffect3043ui_story and not isNil(var_88_38) then
					arg_85_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_39 + var_88_40 and arg_85_1.time_ < var_88_39 + var_88_40 + arg_88_0 and not isNil(var_88_38) and arg_85_1.var_.characterEffect3043ui_story then
				arg_85_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_88_42 = 3.8

			if var_88_42 < arg_85_1.time_ and arg_85_1.time_ <= var_88_42 + arg_88_0 then
				arg_85_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_88_43 = 3.8

			if var_88_43 < arg_85_1.time_ and arg_85_1.time_ <= var_88_43 + arg_88_0 then
				arg_85_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_44 = arg_85_1.actors_["3043ui_story"].transform
			local var_88_45 = 1.96599999815226

			if var_88_45 < arg_85_1.time_ and arg_85_1.time_ <= var_88_45 + arg_88_0 then
				arg_85_1.var_.moveOldPos3043ui_story = var_88_44.localPosition
			end

			local var_88_46 = 0.001

			if var_88_45 <= arg_85_1.time_ and arg_85_1.time_ < var_88_45 + var_88_46 then
				local var_88_47 = (arg_85_1.time_ - var_88_45) / var_88_46
				local var_88_48 = Vector3.New(0, 100, 0)

				var_88_44.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos3043ui_story, var_88_48, var_88_47)

				local var_88_49 = manager.ui.mainCamera.transform.position - var_88_44.position

				var_88_44.forward = Vector3.New(var_88_49.x, var_88_49.y, var_88_49.z)

				local var_88_50 = var_88_44.localEulerAngles

				var_88_50.z = 0
				var_88_50.x = 0
				var_88_44.localEulerAngles = var_88_50
			end

			if arg_85_1.time_ >= var_88_45 + var_88_46 and arg_85_1.time_ < var_88_45 + var_88_46 + arg_88_0 then
				var_88_44.localPosition = Vector3.New(0, 100, 0)

				local var_88_51 = manager.ui.mainCamera.transform.position - var_88_44.position

				var_88_44.forward = Vector3.New(var_88_51.x, var_88_51.y, var_88_51.z)

				local var_88_52 = var_88_44.localEulerAngles

				var_88_52.z = 0
				var_88_52.x = 0
				var_88_44.localEulerAngles = var_88_52
			end

			local var_88_53 = arg_85_1.actors_["1097ui_story"].transform
			local var_88_54 = 1.96599999815226

			if var_88_54 < arg_85_1.time_ and arg_85_1.time_ <= var_88_54 + arg_88_0 then
				arg_85_1.var_.moveOldPos1097ui_story = var_88_53.localPosition
			end

			local var_88_55 = 0.001

			if var_88_54 <= arg_85_1.time_ and arg_85_1.time_ < var_88_54 + var_88_55 then
				local var_88_56 = (arg_85_1.time_ - var_88_54) / var_88_55
				local var_88_57 = Vector3.New(0, 100, 0)

				var_88_53.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1097ui_story, var_88_57, var_88_56)

				local var_88_58 = manager.ui.mainCamera.transform.position - var_88_53.position

				var_88_53.forward = Vector3.New(var_88_58.x, var_88_58.y, var_88_58.z)

				local var_88_59 = var_88_53.localEulerAngles

				var_88_59.z = 0
				var_88_59.x = 0
				var_88_53.localEulerAngles = var_88_59
			end

			if arg_85_1.time_ >= var_88_54 + var_88_55 and arg_85_1.time_ < var_88_54 + var_88_55 + arg_88_0 then
				var_88_53.localPosition = Vector3.New(0, 100, 0)

				local var_88_60 = manager.ui.mainCamera.transform.position - var_88_53.position

				var_88_53.forward = Vector3.New(var_88_60.x, var_88_60.y, var_88_60.z)

				local var_88_61 = var_88_53.localEulerAngles

				var_88_61.z = 0
				var_88_61.x = 0
				var_88_53.localEulerAngles = var_88_61
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_62 = 4
			local var_88_63 = 0.675

			if var_88_62 < arg_85_1.time_ and arg_85_1.time_ <= var_88_62 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_64 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_64:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_65 = arg_85_1:FormatText(StoryNameCfg[920].name)

				arg_85_1.leftNameTxt_.text = var_88_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_66 = arg_85_1:GetWordFromCfg(412031021)
				local var_88_67 = arg_85_1:FormatText(var_88_66.content)

				arg_85_1.text_.text = var_88_67

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_68 = 27
				local var_88_69 = utf8.len(var_88_67)
				local var_88_70 = var_88_68 <= 0 and var_88_63 or var_88_63 * (var_88_69 / var_88_68)

				if var_88_70 > 0 and var_88_63 < var_88_70 then
					arg_85_1.talkMaxDuration = var_88_70
					var_88_62 = var_88_62 + 0.3

					if var_88_70 + var_88_62 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_70 + var_88_62
					end
				end

				arg_85_1.text_.text = var_88_67
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031021", "story_v_out_412031.awb") ~= 0 then
					local var_88_71 = manager.audio:GetVoiceLength("story_v_out_412031", "412031021", "story_v_out_412031.awb") / 1000

					if var_88_71 + var_88_62 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_71 + var_88_62
					end

					if var_88_66.prefab_name ~= "" and arg_85_1.actors_[var_88_66.prefab_name] ~= nil then
						local var_88_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_66.prefab_name].transform, "story_v_out_412031", "412031021", "story_v_out_412031.awb")

						arg_85_1:RecordAudio("412031021", var_88_72)
						arg_85_1:RecordAudio("412031021", var_88_72)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_412031", "412031021", "story_v_out_412031.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_412031", "412031021", "story_v_out_412031.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_73 = var_88_62 + 0.3
			local var_88_74 = math.max(var_88_63, arg_85_1.talkMaxDuration)

			if var_88_73 <= arg_85_1.time_ and arg_85_1.time_ < var_88_73 + var_88_74 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_73) / var_88_74

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_73 + var_88_74 and arg_85_1.time_ < var_88_73 + var_88_74 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play412031022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 412031022
		arg_91_1.duration_ = 6.6

		local var_91_0 = {
			zh = 3.466,
			ja = 6.6
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
				arg_91_0:Play412031023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1097ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1097ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1097ui_story, var_94_4, var_94_3)

				local var_94_5 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_5.x, var_94_5.y, var_94_5.z)

				local var_94_6 = var_94_0.localEulerAngles

				var_94_6.z = 0
				var_94_6.x = 0
				var_94_0.localEulerAngles = var_94_6
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_94_7 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_7.x, var_94_7.y, var_94_7.z)

				local var_94_8 = var_94_0.localEulerAngles

				var_94_8.z = 0
				var_94_8.x = 0
				var_94_0.localEulerAngles = var_94_8
			end

			local var_94_9 = arg_91_1.actors_["1097ui_story"]
			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect1097ui_story == nil then
				arg_91_1.var_.characterEffect1097ui_story = var_94_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_11 = 0.200000002980232

			if var_94_10 <= arg_91_1.time_ and arg_91_1.time_ < var_94_10 + var_94_11 and not isNil(var_94_9) then
				local var_94_12 = (arg_91_1.time_ - var_94_10) / var_94_11

				if arg_91_1.var_.characterEffect1097ui_story and not isNil(var_94_9) then
					arg_91_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_10 + var_94_11 and arg_91_1.time_ < var_94_10 + var_94_11 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect1097ui_story then
				arg_91_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_94_13 = 0

			if var_94_13 < arg_91_1.time_ and arg_91_1.time_ <= var_94_13 + arg_94_0 then
				arg_91_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_94_14 = 0

			if var_94_14 < arg_91_1.time_ and arg_91_1.time_ <= var_94_14 + arg_94_0 then
				arg_91_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_94_15 = arg_91_1.actors_["3043ui_story"]
			local var_94_16 = 0

			if var_94_16 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 and not isNil(var_94_15) and arg_91_1.var_.characterEffect3043ui_story == nil then
				arg_91_1.var_.characterEffect3043ui_story = var_94_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_17 = 0.200000002980232

			if var_94_16 <= arg_91_1.time_ and arg_91_1.time_ < var_94_16 + var_94_17 and not isNil(var_94_15) then
				local var_94_18 = (arg_91_1.time_ - var_94_16) / var_94_17

				if arg_91_1.var_.characterEffect3043ui_story and not isNil(var_94_15) then
					local var_94_19 = Mathf.Lerp(0, 0.5, var_94_18)

					arg_91_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_91_1.var_.characterEffect3043ui_story.fillRatio = var_94_19
				end
			end

			if arg_91_1.time_ >= var_94_16 + var_94_17 and arg_91_1.time_ < var_94_16 + var_94_17 + arg_94_0 and not isNil(var_94_15) and arg_91_1.var_.characterEffect3043ui_story then
				local var_94_20 = 0.5

				arg_91_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_91_1.var_.characterEffect3043ui_story.fillRatio = var_94_20
			end

			local var_94_21 = arg_91_1.actors_["3043ui_story"].transform
			local var_94_22 = 0

			if var_94_22 < arg_91_1.time_ and arg_91_1.time_ <= var_94_22 + arg_94_0 then
				arg_91_1.var_.moveOldPos3043ui_story = var_94_21.localPosition
			end

			local var_94_23 = 0.001

			if var_94_22 <= arg_91_1.time_ and arg_91_1.time_ < var_94_22 + var_94_23 then
				local var_94_24 = (arg_91_1.time_ - var_94_22) / var_94_23
				local var_94_25 = Vector3.New(0.7, -1.41, -5.7)

				var_94_21.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos3043ui_story, var_94_25, var_94_24)

				local var_94_26 = manager.ui.mainCamera.transform.position - var_94_21.position

				var_94_21.forward = Vector3.New(var_94_26.x, var_94_26.y, var_94_26.z)

				local var_94_27 = var_94_21.localEulerAngles

				var_94_27.z = 0
				var_94_27.x = 0
				var_94_21.localEulerAngles = var_94_27
			end

			if arg_91_1.time_ >= var_94_22 + var_94_23 and arg_91_1.time_ < var_94_22 + var_94_23 + arg_94_0 then
				var_94_21.localPosition = Vector3.New(0.7, -1.41, -5.7)

				local var_94_28 = manager.ui.mainCamera.transform.position - var_94_21.position

				var_94_21.forward = Vector3.New(var_94_28.x, var_94_28.y, var_94_28.z)

				local var_94_29 = var_94_21.localEulerAngles

				var_94_29.z = 0
				var_94_29.x = 0
				var_94_21.localEulerAngles = var_94_29
			end

			local var_94_30 = 0
			local var_94_31 = 0.275

			if var_94_30 < arg_91_1.time_ and arg_91_1.time_ <= var_94_30 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_32 = arg_91_1:FormatText(StoryNameCfg[216].name)

				arg_91_1.leftNameTxt_.text = var_94_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_33 = arg_91_1:GetWordFromCfg(412031022)
				local var_94_34 = arg_91_1:FormatText(var_94_33.content)

				arg_91_1.text_.text = var_94_34

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_35 = 11
				local var_94_36 = utf8.len(var_94_34)
				local var_94_37 = var_94_35 <= 0 and var_94_31 or var_94_31 * (var_94_36 / var_94_35)

				if var_94_37 > 0 and var_94_31 < var_94_37 then
					arg_91_1.talkMaxDuration = var_94_37

					if var_94_37 + var_94_30 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_37 + var_94_30
					end
				end

				arg_91_1.text_.text = var_94_34
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031022", "story_v_out_412031.awb") ~= 0 then
					local var_94_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031022", "story_v_out_412031.awb") / 1000

					if var_94_38 + var_94_30 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_38 + var_94_30
					end

					if var_94_33.prefab_name ~= "" and arg_91_1.actors_[var_94_33.prefab_name] ~= nil then
						local var_94_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_33.prefab_name].transform, "story_v_out_412031", "412031022", "story_v_out_412031.awb")

						arg_91_1:RecordAudio("412031022", var_94_39)
						arg_91_1:RecordAudio("412031022", var_94_39)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_412031", "412031022", "story_v_out_412031.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_412031", "412031022", "story_v_out_412031.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_40 = math.max(var_94_31, arg_91_1.talkMaxDuration)

			if var_94_30 <= arg_91_1.time_ and arg_91_1.time_ < var_94_30 + var_94_40 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_30) / var_94_40

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_30 + var_94_40 and arg_91_1.time_ < var_94_30 + var_94_40 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play412031023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 412031023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play412031024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1097ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1097ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(0, 100, 0)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1097ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, 100, 0)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = arg_95_1.actors_["1097ui_story"]
			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1097ui_story == nil then
				arg_95_1.var_.characterEffect1097ui_story = var_98_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_11 = 0.200000002980232

			if var_98_10 <= arg_95_1.time_ and arg_95_1.time_ < var_98_10 + var_98_11 and not isNil(var_98_9) then
				local var_98_12 = (arg_95_1.time_ - var_98_10) / var_98_11

				if arg_95_1.var_.characterEffect1097ui_story and not isNil(var_98_9) then
					local var_98_13 = Mathf.Lerp(0, 0.5, var_98_12)

					arg_95_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1097ui_story.fillRatio = var_98_13
				end
			end

			if arg_95_1.time_ >= var_98_10 + var_98_11 and arg_95_1.time_ < var_98_10 + var_98_11 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1097ui_story then
				local var_98_14 = 0.5

				arg_95_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1097ui_story.fillRatio = var_98_14
			end

			local var_98_15 = arg_95_1.actors_["3043ui_story"].transform
			local var_98_16 = 0

			if var_98_16 < arg_95_1.time_ and arg_95_1.time_ <= var_98_16 + arg_98_0 then
				arg_95_1.var_.moveOldPos3043ui_story = var_98_15.localPosition
			end

			local var_98_17 = 0.001

			if var_98_16 <= arg_95_1.time_ and arg_95_1.time_ < var_98_16 + var_98_17 then
				local var_98_18 = (arg_95_1.time_ - var_98_16) / var_98_17
				local var_98_19 = Vector3.New(0, 100, 0)

				var_98_15.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos3043ui_story, var_98_19, var_98_18)

				local var_98_20 = manager.ui.mainCamera.transform.position - var_98_15.position

				var_98_15.forward = Vector3.New(var_98_20.x, var_98_20.y, var_98_20.z)

				local var_98_21 = var_98_15.localEulerAngles

				var_98_21.z = 0
				var_98_21.x = 0
				var_98_15.localEulerAngles = var_98_21
			end

			if arg_95_1.time_ >= var_98_16 + var_98_17 and arg_95_1.time_ < var_98_16 + var_98_17 + arg_98_0 then
				var_98_15.localPosition = Vector3.New(0, 100, 0)

				local var_98_22 = manager.ui.mainCamera.transform.position - var_98_15.position

				var_98_15.forward = Vector3.New(var_98_22.x, var_98_22.y, var_98_22.z)

				local var_98_23 = var_98_15.localEulerAngles

				var_98_23.z = 0
				var_98_23.x = 0
				var_98_15.localEulerAngles = var_98_23
			end

			local var_98_24 = arg_95_1.actors_["3043ui_story"]
			local var_98_25 = 0

			if var_98_25 < arg_95_1.time_ and arg_95_1.time_ <= var_98_25 + arg_98_0 and not isNil(var_98_24) and arg_95_1.var_.characterEffect3043ui_story == nil then
				arg_95_1.var_.characterEffect3043ui_story = var_98_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_26 = 0.200000002980232

			if var_98_25 <= arg_95_1.time_ and arg_95_1.time_ < var_98_25 + var_98_26 and not isNil(var_98_24) then
				local var_98_27 = (arg_95_1.time_ - var_98_25) / var_98_26

				if arg_95_1.var_.characterEffect3043ui_story and not isNil(var_98_24) then
					local var_98_28 = Mathf.Lerp(0, 0.5, var_98_27)

					arg_95_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_95_1.var_.characterEffect3043ui_story.fillRatio = var_98_28
				end
			end

			if arg_95_1.time_ >= var_98_25 + var_98_26 and arg_95_1.time_ < var_98_25 + var_98_26 + arg_98_0 and not isNil(var_98_24) and arg_95_1.var_.characterEffect3043ui_story then
				local var_98_29 = 0.5

				arg_95_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_95_1.var_.characterEffect3043ui_story.fillRatio = var_98_29
			end

			local var_98_30 = 0
			local var_98_31 = 0.375

			if var_98_30 < arg_95_1.time_ and arg_95_1.time_ <= var_98_30 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_32 = arg_95_1:GetWordFromCfg(412031023)
				local var_98_33 = arg_95_1:FormatText(var_98_32.content)

				arg_95_1.text_.text = var_98_33

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_34 = 15
				local var_98_35 = utf8.len(var_98_33)
				local var_98_36 = var_98_34 <= 0 and var_98_31 or var_98_31 * (var_98_35 / var_98_34)

				if var_98_36 > 0 and var_98_31 < var_98_36 then
					arg_95_1.talkMaxDuration = var_98_36

					if var_98_36 + var_98_30 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_36 + var_98_30
					end
				end

				arg_95_1.text_.text = var_98_33
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_37 = math.max(var_98_31, arg_95_1.talkMaxDuration)

			if var_98_30 <= arg_95_1.time_ and arg_95_1.time_ < var_98_30 + var_98_37 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_30) / var_98_37

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_30 + var_98_37 and arg_95_1.time_ < var_98_30 + var_98_37 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
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
	Play412031024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 412031024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play412031025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.9

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

				local var_102_2 = arg_99_1:GetWordFromCfg(412031024)
				local var_102_3 = arg_99_1:FormatText(var_102_2.content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 36
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
	Play412031025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 412031025
		arg_103_1.duration_ = 7.5

		local var_103_0 = {
			zh = 7.233,
			ja = 7.5
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
				arg_103_0:Play412031026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["3043ui_story"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos3043ui_story = var_106_0.localPosition
			end

			local var_106_2 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2
				local var_106_4 = Vector3.New(0, -1.41, -5.7)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos3043ui_story, var_106_4, var_106_3)

				local var_106_5 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_5.x, var_106_5.y, var_106_5.z)

				local var_106_6 = var_106_0.localEulerAngles

				var_106_6.z = 0
				var_106_6.x = 0
				var_106_0.localEulerAngles = var_106_6
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(0, -1.41, -5.7)

				local var_106_7 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_7.x, var_106_7.y, var_106_7.z)

				local var_106_8 = var_106_0.localEulerAngles

				var_106_8.z = 0
				var_106_8.x = 0
				var_106_0.localEulerAngles = var_106_8
			end

			local var_106_9 = arg_103_1.actors_["3043ui_story"]
			local var_106_10 = 0

			if var_106_10 < arg_103_1.time_ and arg_103_1.time_ <= var_106_10 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect3043ui_story == nil then
				arg_103_1.var_.characterEffect3043ui_story = var_106_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_11 = 0.200000002980232

			if var_106_10 <= arg_103_1.time_ and arg_103_1.time_ < var_106_10 + var_106_11 and not isNil(var_106_9) then
				local var_106_12 = (arg_103_1.time_ - var_106_10) / var_106_11

				if arg_103_1.var_.characterEffect3043ui_story and not isNil(var_106_9) then
					arg_103_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_10 + var_106_11 and arg_103_1.time_ < var_106_10 + var_106_11 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect3043ui_story then
				arg_103_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_106_13 = 0

			if var_106_13 < arg_103_1.time_ and arg_103_1.time_ <= var_106_13 + arg_106_0 then
				arg_103_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_106_14 = 0

			if var_106_14 < arg_103_1.time_ and arg_103_1.time_ <= var_106_14 + arg_106_0 then
				arg_103_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_106_15 = 0
			local var_106_16 = 0.8

			if var_106_15 < arg_103_1.time_ and arg_103_1.time_ <= var_106_15 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_17 = arg_103_1:FormatText(StoryNameCfg[920].name)

				arg_103_1.leftNameTxt_.text = var_106_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_18 = arg_103_1:GetWordFromCfg(412031025)
				local var_106_19 = arg_103_1:FormatText(var_106_18.content)

				arg_103_1.text_.text = var_106_19

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_20 = 32
				local var_106_21 = utf8.len(var_106_19)
				local var_106_22 = var_106_20 <= 0 and var_106_16 or var_106_16 * (var_106_21 / var_106_20)

				if var_106_22 > 0 and var_106_16 < var_106_22 then
					arg_103_1.talkMaxDuration = var_106_22

					if var_106_22 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_22 + var_106_15
					end
				end

				arg_103_1.text_.text = var_106_19
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031025", "story_v_out_412031.awb") ~= 0 then
					local var_106_23 = manager.audio:GetVoiceLength("story_v_out_412031", "412031025", "story_v_out_412031.awb") / 1000

					if var_106_23 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_15
					end

					if var_106_18.prefab_name ~= "" and arg_103_1.actors_[var_106_18.prefab_name] ~= nil then
						local var_106_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_18.prefab_name].transform, "story_v_out_412031", "412031025", "story_v_out_412031.awb")

						arg_103_1:RecordAudio("412031025", var_106_24)
						arg_103_1:RecordAudio("412031025", var_106_24)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_412031", "412031025", "story_v_out_412031.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_412031", "412031025", "story_v_out_412031.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_25 = math.max(var_106_16, arg_103_1.talkMaxDuration)

			if var_106_15 <= arg_103_1.time_ and arg_103_1.time_ < var_106_15 + var_106_25 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_15) / var_106_25

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_15 + var_106_25 and arg_103_1.time_ < var_106_15 + var_106_25 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play412031026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 412031026
		arg_107_1.duration_ = 7.2

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play412031027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1097ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos1097ui_story = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1097ui_story, var_110_4, var_110_3)

				local var_110_5 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_5.x, var_110_5.y, var_110_5.z)

				local var_110_6 = var_110_0.localEulerAngles

				var_110_6.z = 0
				var_110_6.x = 0
				var_110_0.localEulerAngles = var_110_6
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_110_7 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_7.x, var_110_7.y, var_110_7.z)

				local var_110_8 = var_110_0.localEulerAngles

				var_110_8.z = 0
				var_110_8.x = 0
				var_110_0.localEulerAngles = var_110_8
			end

			local var_110_9 = arg_107_1.actors_["1097ui_story"]
			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect1097ui_story == nil then
				arg_107_1.var_.characterEffect1097ui_story = var_110_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_11 = 0.200000002980232

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_11 and not isNil(var_110_9) then
				local var_110_12 = (arg_107_1.time_ - var_110_10) / var_110_11

				if arg_107_1.var_.characterEffect1097ui_story and not isNil(var_110_9) then
					arg_107_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_10 + var_110_11 and arg_107_1.time_ < var_110_10 + var_110_11 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect1097ui_story then
				arg_107_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_110_13 = 0

			if var_110_13 < arg_107_1.time_ and arg_107_1.time_ <= var_110_13 + arg_110_0 then
				arg_107_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_110_14 = 0

			if var_110_14 < arg_107_1.time_ and arg_107_1.time_ <= var_110_14 + arg_110_0 then
				arg_107_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_110_15 = arg_107_1.actors_["3043ui_story"]
			local var_110_16 = 0

			if var_110_16 < arg_107_1.time_ and arg_107_1.time_ <= var_110_16 + arg_110_0 and not isNil(var_110_15) and arg_107_1.var_.characterEffect3043ui_story == nil then
				arg_107_1.var_.characterEffect3043ui_story = var_110_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_17 = 0.200000002980232

			if var_110_16 <= arg_107_1.time_ and arg_107_1.time_ < var_110_16 + var_110_17 and not isNil(var_110_15) then
				local var_110_18 = (arg_107_1.time_ - var_110_16) / var_110_17

				if arg_107_1.var_.characterEffect3043ui_story and not isNil(var_110_15) then
					local var_110_19 = Mathf.Lerp(0, 0.5, var_110_18)

					arg_107_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_107_1.var_.characterEffect3043ui_story.fillRatio = var_110_19
				end
			end

			if arg_107_1.time_ >= var_110_16 + var_110_17 and arg_107_1.time_ < var_110_16 + var_110_17 + arg_110_0 and not isNil(var_110_15) and arg_107_1.var_.characterEffect3043ui_story then
				local var_110_20 = 0.5

				arg_107_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_107_1.var_.characterEffect3043ui_story.fillRatio = var_110_20
			end

			local var_110_21 = arg_107_1.actors_["3043ui_story"].transform
			local var_110_22 = 0

			if var_110_22 < arg_107_1.time_ and arg_107_1.time_ <= var_110_22 + arg_110_0 then
				arg_107_1.var_.moveOldPos3043ui_story = var_110_21.localPosition
			end

			local var_110_23 = 0.001

			if var_110_22 <= arg_107_1.time_ and arg_107_1.time_ < var_110_22 + var_110_23 then
				local var_110_24 = (arg_107_1.time_ - var_110_22) / var_110_23
				local var_110_25 = Vector3.New(0.7, -1.41, -5.7)

				var_110_21.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos3043ui_story, var_110_25, var_110_24)

				local var_110_26 = manager.ui.mainCamera.transform.position - var_110_21.position

				var_110_21.forward = Vector3.New(var_110_26.x, var_110_26.y, var_110_26.z)

				local var_110_27 = var_110_21.localEulerAngles

				var_110_27.z = 0
				var_110_27.x = 0
				var_110_21.localEulerAngles = var_110_27
			end

			if arg_107_1.time_ >= var_110_22 + var_110_23 and arg_107_1.time_ < var_110_22 + var_110_23 + arg_110_0 then
				var_110_21.localPosition = Vector3.New(0.7, -1.41, -5.7)

				local var_110_28 = manager.ui.mainCamera.transform.position - var_110_21.position

				var_110_21.forward = Vector3.New(var_110_28.x, var_110_28.y, var_110_28.z)

				local var_110_29 = var_110_21.localEulerAngles

				var_110_29.z = 0
				var_110_29.x = 0
				var_110_21.localEulerAngles = var_110_29
			end

			local var_110_30 = 0
			local var_110_31 = 0.575

			if var_110_30 < arg_107_1.time_ and arg_107_1.time_ <= var_110_30 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_32 = arg_107_1:FormatText(StoryNameCfg[216].name)

				arg_107_1.leftNameTxt_.text = var_110_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_33 = arg_107_1:GetWordFromCfg(412031026)
				local var_110_34 = arg_107_1:FormatText(var_110_33.content)

				arg_107_1.text_.text = var_110_34

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_35 = 23
				local var_110_36 = utf8.len(var_110_34)
				local var_110_37 = var_110_35 <= 0 and var_110_31 or var_110_31 * (var_110_36 / var_110_35)

				if var_110_37 > 0 and var_110_31 < var_110_37 then
					arg_107_1.talkMaxDuration = var_110_37

					if var_110_37 + var_110_30 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_37 + var_110_30
					end
				end

				arg_107_1.text_.text = var_110_34
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031026", "story_v_out_412031.awb") ~= 0 then
					local var_110_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031026", "story_v_out_412031.awb") / 1000

					if var_110_38 + var_110_30 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_38 + var_110_30
					end

					if var_110_33.prefab_name ~= "" and arg_107_1.actors_[var_110_33.prefab_name] ~= nil then
						local var_110_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_33.prefab_name].transform, "story_v_out_412031", "412031026", "story_v_out_412031.awb")

						arg_107_1:RecordAudio("412031026", var_110_39)
						arg_107_1:RecordAudio("412031026", var_110_39)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_412031", "412031026", "story_v_out_412031.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_412031", "412031026", "story_v_out_412031.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_40 = math.max(var_110_31, arg_107_1.talkMaxDuration)

			if var_110_30 <= arg_107_1.time_ and arg_107_1.time_ < var_110_30 + var_110_40 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_30) / var_110_40

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_30 + var_110_40 and arg_107_1.time_ < var_110_30 + var_110_40 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play412031027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 412031027
		arg_111_1.duration_ = 7.4

		local var_111_0 = {
			zh = 7.2,
			ja = 7.4
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
				arg_111_0:Play412031028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1097ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1097ui_story == nil then
				arg_111_1.var_.characterEffect1097ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1097ui_story and not isNil(var_114_0) then
					local var_114_4 = Mathf.Lerp(0, 0.5, var_114_3)

					arg_111_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1097ui_story.fillRatio = var_114_4
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1097ui_story then
				local var_114_5 = 0.5

				arg_111_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1097ui_story.fillRatio = var_114_5
			end

			local var_114_6 = 0

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action2_1")
			end

			local var_114_7 = 0

			if var_114_7 < arg_111_1.time_ and arg_111_1.time_ <= var_114_7 + arg_114_0 then
				arg_111_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_114_8 = arg_111_1.actors_["3043ui_story"]
			local var_114_9 = 0

			if var_114_9 < arg_111_1.time_ and arg_111_1.time_ <= var_114_9 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.characterEffect3043ui_story == nil then
				arg_111_1.var_.characterEffect3043ui_story = var_114_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_10 = 0.200000002980232

			if var_114_9 <= arg_111_1.time_ and arg_111_1.time_ < var_114_9 + var_114_10 and not isNil(var_114_8) then
				local var_114_11 = (arg_111_1.time_ - var_114_9) / var_114_10

				if arg_111_1.var_.characterEffect3043ui_story and not isNil(var_114_8) then
					arg_111_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_9 + var_114_10 and arg_111_1.time_ < var_114_9 + var_114_10 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.characterEffect3043ui_story then
				arg_111_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_114_12 = 0
			local var_114_13 = 0.55

			if var_114_12 < arg_111_1.time_ and arg_111_1.time_ <= var_114_12 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_14 = arg_111_1:FormatText(StoryNameCfg[920].name)

				arg_111_1.leftNameTxt_.text = var_114_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_15 = arg_111_1:GetWordFromCfg(412031027)
				local var_114_16 = arg_111_1:FormatText(var_114_15.content)

				arg_111_1.text_.text = var_114_16

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_17 = 22
				local var_114_18 = utf8.len(var_114_16)
				local var_114_19 = var_114_17 <= 0 and var_114_13 or var_114_13 * (var_114_18 / var_114_17)

				if var_114_19 > 0 and var_114_13 < var_114_19 then
					arg_111_1.talkMaxDuration = var_114_19

					if var_114_19 + var_114_12 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_19 + var_114_12
					end
				end

				arg_111_1.text_.text = var_114_16
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031027", "story_v_out_412031.awb") ~= 0 then
					local var_114_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031027", "story_v_out_412031.awb") / 1000

					if var_114_20 + var_114_12 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_20 + var_114_12
					end

					if var_114_15.prefab_name ~= "" and arg_111_1.actors_[var_114_15.prefab_name] ~= nil then
						local var_114_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_15.prefab_name].transform, "story_v_out_412031", "412031027", "story_v_out_412031.awb")

						arg_111_1:RecordAudio("412031027", var_114_21)
						arg_111_1:RecordAudio("412031027", var_114_21)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_412031", "412031027", "story_v_out_412031.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_412031", "412031027", "story_v_out_412031.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_22 = math.max(var_114_13, arg_111_1.talkMaxDuration)

			if var_114_12 <= arg_111_1.time_ and arg_111_1.time_ < var_114_12 + var_114_22 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_12) / var_114_22

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_12 + var_114_22 and arg_111_1.time_ < var_114_12 + var_114_22 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play412031028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 412031028
		arg_115_1.duration_ = 3.33

		local var_115_0 = {
			zh = 2.5,
			ja = 3.333
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
				arg_115_0:Play412031029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1097ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1097ui_story == nil then
				arg_115_1.var_.characterEffect1097ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1097ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1097ui_story then
				arg_115_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_118_4 = 0

			if var_118_4 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_118_5 = 0

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_6 = arg_115_1.actors_["3043ui_story"]
			local var_118_7 = 0

			if var_118_7 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect3043ui_story == nil then
				arg_115_1.var_.characterEffect3043ui_story = var_118_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_8 = 0.200000002980232

			if var_118_7 <= arg_115_1.time_ and arg_115_1.time_ < var_118_7 + var_118_8 and not isNil(var_118_6) then
				local var_118_9 = (arg_115_1.time_ - var_118_7) / var_118_8

				if arg_115_1.var_.characterEffect3043ui_story and not isNil(var_118_6) then
					local var_118_10 = Mathf.Lerp(0, 0.5, var_118_9)

					arg_115_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_115_1.var_.characterEffect3043ui_story.fillRatio = var_118_10
				end
			end

			if arg_115_1.time_ >= var_118_7 + var_118_8 and arg_115_1.time_ < var_118_7 + var_118_8 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect3043ui_story then
				local var_118_11 = 0.5

				arg_115_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_115_1.var_.characterEffect3043ui_story.fillRatio = var_118_11
			end

			local var_118_12 = 0
			local var_118_13 = 0.125

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_14 = arg_115_1:FormatText(StoryNameCfg[216].name)

				arg_115_1.leftNameTxt_.text = var_118_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_15 = arg_115_1:GetWordFromCfg(412031028)
				local var_118_16 = arg_115_1:FormatText(var_118_15.content)

				arg_115_1.text_.text = var_118_16

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_17 = 5
				local var_118_18 = utf8.len(var_118_16)
				local var_118_19 = var_118_17 <= 0 and var_118_13 or var_118_13 * (var_118_18 / var_118_17)

				if var_118_19 > 0 and var_118_13 < var_118_19 then
					arg_115_1.talkMaxDuration = var_118_19

					if var_118_19 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_19 + var_118_12
					end
				end

				arg_115_1.text_.text = var_118_16
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031028", "story_v_out_412031.awb") ~= 0 then
					local var_118_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031028", "story_v_out_412031.awb") / 1000

					if var_118_20 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_20 + var_118_12
					end

					if var_118_15.prefab_name ~= "" and arg_115_1.actors_[var_118_15.prefab_name] ~= nil then
						local var_118_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_15.prefab_name].transform, "story_v_out_412031", "412031028", "story_v_out_412031.awb")

						arg_115_1:RecordAudio("412031028", var_118_21)
						arg_115_1:RecordAudio("412031028", var_118_21)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_412031", "412031028", "story_v_out_412031.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_412031", "412031028", "story_v_out_412031.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_22 = math.max(var_118_13, arg_115_1.talkMaxDuration)

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_22 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_12) / var_118_22

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_12 + var_118_22 and arg_115_1.time_ < var_118_12 + var_118_22 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play412031029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 412031029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play412031030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1097ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos1097ui_story = var_122_0.localPosition
			end

			local var_122_2 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2
				local var_122_4 = Vector3.New(0, 100, 0)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1097ui_story, var_122_4, var_122_3)

				local var_122_5 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_5.x, var_122_5.y, var_122_5.z)

				local var_122_6 = var_122_0.localEulerAngles

				var_122_6.z = 0
				var_122_6.x = 0
				var_122_0.localEulerAngles = var_122_6
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, 100, 0)

				local var_122_7 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_7.x, var_122_7.y, var_122_7.z)

				local var_122_8 = var_122_0.localEulerAngles

				var_122_8.z = 0
				var_122_8.x = 0
				var_122_0.localEulerAngles = var_122_8
			end

			local var_122_9 = arg_119_1.actors_["1097ui_story"]
			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect1097ui_story == nil then
				arg_119_1.var_.characterEffect1097ui_story = var_122_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_11 = 0.200000002980232

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_11 and not isNil(var_122_9) then
				local var_122_12 = (arg_119_1.time_ - var_122_10) / var_122_11

				if arg_119_1.var_.characterEffect1097ui_story and not isNil(var_122_9) then
					local var_122_13 = Mathf.Lerp(0, 0.5, var_122_12)

					arg_119_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1097ui_story.fillRatio = var_122_13
				end
			end

			if arg_119_1.time_ >= var_122_10 + var_122_11 and arg_119_1.time_ < var_122_10 + var_122_11 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect1097ui_story then
				local var_122_14 = 0.5

				arg_119_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1097ui_story.fillRatio = var_122_14
			end

			local var_122_15 = arg_119_1.actors_["3043ui_story"].transform
			local var_122_16 = 0

			if var_122_16 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 then
				arg_119_1.var_.moveOldPos3043ui_story = var_122_15.localPosition
			end

			local var_122_17 = 0.001

			if var_122_16 <= arg_119_1.time_ and arg_119_1.time_ < var_122_16 + var_122_17 then
				local var_122_18 = (arg_119_1.time_ - var_122_16) / var_122_17
				local var_122_19 = Vector3.New(0, 100, 0)

				var_122_15.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos3043ui_story, var_122_19, var_122_18)

				local var_122_20 = manager.ui.mainCamera.transform.position - var_122_15.position

				var_122_15.forward = Vector3.New(var_122_20.x, var_122_20.y, var_122_20.z)

				local var_122_21 = var_122_15.localEulerAngles

				var_122_21.z = 0
				var_122_21.x = 0
				var_122_15.localEulerAngles = var_122_21
			end

			if arg_119_1.time_ >= var_122_16 + var_122_17 and arg_119_1.time_ < var_122_16 + var_122_17 + arg_122_0 then
				var_122_15.localPosition = Vector3.New(0, 100, 0)

				local var_122_22 = manager.ui.mainCamera.transform.position - var_122_15.position

				var_122_15.forward = Vector3.New(var_122_22.x, var_122_22.y, var_122_22.z)

				local var_122_23 = var_122_15.localEulerAngles

				var_122_23.z = 0
				var_122_23.x = 0
				var_122_15.localEulerAngles = var_122_23
			end

			local var_122_24 = arg_119_1.actors_["3043ui_story"]
			local var_122_25 = 0

			if var_122_25 < arg_119_1.time_ and arg_119_1.time_ <= var_122_25 + arg_122_0 and not isNil(var_122_24) and arg_119_1.var_.characterEffect3043ui_story == nil then
				arg_119_1.var_.characterEffect3043ui_story = var_122_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_26 = 0.200000002980232

			if var_122_25 <= arg_119_1.time_ and arg_119_1.time_ < var_122_25 + var_122_26 and not isNil(var_122_24) then
				local var_122_27 = (arg_119_1.time_ - var_122_25) / var_122_26

				if arg_119_1.var_.characterEffect3043ui_story and not isNil(var_122_24) then
					local var_122_28 = Mathf.Lerp(0, 0.5, var_122_27)

					arg_119_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_119_1.var_.characterEffect3043ui_story.fillRatio = var_122_28
				end
			end

			if arg_119_1.time_ >= var_122_25 + var_122_26 and arg_119_1.time_ < var_122_25 + var_122_26 + arg_122_0 and not isNil(var_122_24) and arg_119_1.var_.characterEffect3043ui_story then
				local var_122_29 = 0.5

				arg_119_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_119_1.var_.characterEffect3043ui_story.fillRatio = var_122_29
			end

			local var_122_30 = 0
			local var_122_31 = 0.925

			if var_122_30 < arg_119_1.time_ and arg_119_1.time_ <= var_122_30 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_32 = arg_119_1:GetWordFromCfg(412031029)
				local var_122_33 = arg_119_1:FormatText(var_122_32.content)

				arg_119_1.text_.text = var_122_33

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_34 = 37
				local var_122_35 = utf8.len(var_122_33)
				local var_122_36 = var_122_34 <= 0 and var_122_31 or var_122_31 * (var_122_35 / var_122_34)

				if var_122_36 > 0 and var_122_31 < var_122_36 then
					arg_119_1.talkMaxDuration = var_122_36

					if var_122_36 + var_122_30 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_36 + var_122_30
					end
				end

				arg_119_1.text_.text = var_122_33
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_37 = math.max(var_122_31, arg_119_1.talkMaxDuration)

			if var_122_30 <= arg_119_1.time_ and arg_119_1.time_ < var_122_30 + var_122_37 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_30) / var_122_37

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_30 + var_122_37 and arg_119_1.time_ < var_122_30 + var_122_37 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
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
	Play412031030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 412031030
		arg_123_1.duration_ = 6.37

		local var_123_0 = {
			zh = 5.166,
			ja = 6.366
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
				arg_123_0:Play412031031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1097ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1097ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(0, -0.54, -6.3)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1097ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["1097ui_story"]
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1097ui_story == nil then
				arg_123_1.var_.characterEffect1097ui_story = var_126_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 and not isNil(var_126_9) then
				local var_126_12 = (arg_123_1.time_ - var_126_10) / var_126_11

				if arg_123_1.var_.characterEffect1097ui_story and not isNil(var_126_9) then
					arg_123_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1097ui_story then
				arg_123_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_126_13 = 0

			if var_126_13 < arg_123_1.time_ and arg_123_1.time_ <= var_126_13 + arg_126_0 then
				arg_123_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_126_14 = 0

			if var_126_14 < arg_123_1.time_ and arg_123_1.time_ <= var_126_14 + arg_126_0 then
				arg_123_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_126_15 = 0
			local var_126_16 = 0.475

			if var_126_15 < arg_123_1.time_ and arg_123_1.time_ <= var_126_15 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_17 = arg_123_1:FormatText(StoryNameCfg[216].name)

				arg_123_1.leftNameTxt_.text = var_126_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_18 = arg_123_1:GetWordFromCfg(412031030)
				local var_126_19 = arg_123_1:FormatText(var_126_18.content)

				arg_123_1.text_.text = var_126_19

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_20 = 19
				local var_126_21 = utf8.len(var_126_19)
				local var_126_22 = var_126_20 <= 0 and var_126_16 or var_126_16 * (var_126_21 / var_126_20)

				if var_126_22 > 0 and var_126_16 < var_126_22 then
					arg_123_1.talkMaxDuration = var_126_22

					if var_126_22 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_22 + var_126_15
					end
				end

				arg_123_1.text_.text = var_126_19
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031030", "story_v_out_412031.awb") ~= 0 then
					local var_126_23 = manager.audio:GetVoiceLength("story_v_out_412031", "412031030", "story_v_out_412031.awb") / 1000

					if var_126_23 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_23 + var_126_15
					end

					if var_126_18.prefab_name ~= "" and arg_123_1.actors_[var_126_18.prefab_name] ~= nil then
						local var_126_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_18.prefab_name].transform, "story_v_out_412031", "412031030", "story_v_out_412031.awb")

						arg_123_1:RecordAudio("412031030", var_126_24)
						arg_123_1:RecordAudio("412031030", var_126_24)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_412031", "412031030", "story_v_out_412031.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_412031", "412031030", "story_v_out_412031.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_25 = math.max(var_126_16, arg_123_1.talkMaxDuration)

			if var_126_15 <= arg_123_1.time_ and arg_123_1.time_ < var_126_15 + var_126_25 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_15) / var_126_25

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_15 + var_126_25 and arg_123_1.time_ < var_126_15 + var_126_25 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412031031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 412031031
		arg_127_1.duration_ = 10.6

		local var_127_0 = {
			zh = 8.5,
			ja = 10.6
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
				arg_127_0:Play412031032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.75

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[216].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:GetWordFromCfg(412031031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 30
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031031", "story_v_out_412031.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031031", "story_v_out_412031.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_412031", "412031031", "story_v_out_412031.awb")

						arg_127_1:RecordAudio("412031031", var_130_9)
						arg_127_1:RecordAudio("412031031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_412031", "412031031", "story_v_out_412031.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_412031", "412031031", "story_v_out_412031.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_10 and arg_127_1.time_ < var_130_0 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play412031032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 412031032
		arg_131_1.duration_ = 8.73

		local var_131_0 = {
			zh = 8.733,
			ja = 7.1
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
				arg_131_0:Play412031033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["3043ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos3043ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0, -1.41, -5.7)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos3043ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, -1.41, -5.7)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["3043ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect3043ui_story == nil then
				arg_131_1.var_.characterEffect3043ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 and not isNil(var_134_9) then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect3043ui_story and not isNil(var_134_9) then
					arg_131_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect3043ui_story then
				arg_131_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_134_13 = 0

			if var_134_13 < arg_131_1.time_ and arg_131_1.time_ <= var_134_13 + arg_134_0 then
				arg_131_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 then
				arg_131_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_15 = arg_131_1.actors_["1097ui_story"].transform
			local var_134_16 = 0

			if var_134_16 < arg_131_1.time_ and arg_131_1.time_ <= var_134_16 + arg_134_0 then
				arg_131_1.var_.moveOldPos1097ui_story = var_134_15.localPosition
			end

			local var_134_17 = 0.001

			if var_134_16 <= arg_131_1.time_ and arg_131_1.time_ < var_134_16 + var_134_17 then
				local var_134_18 = (arg_131_1.time_ - var_134_16) / var_134_17
				local var_134_19 = Vector3.New(0, 100, 0)

				var_134_15.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1097ui_story, var_134_19, var_134_18)

				local var_134_20 = manager.ui.mainCamera.transform.position - var_134_15.position

				var_134_15.forward = Vector3.New(var_134_20.x, var_134_20.y, var_134_20.z)

				local var_134_21 = var_134_15.localEulerAngles

				var_134_21.z = 0
				var_134_21.x = 0
				var_134_15.localEulerAngles = var_134_21
			end

			if arg_131_1.time_ >= var_134_16 + var_134_17 and arg_131_1.time_ < var_134_16 + var_134_17 + arg_134_0 then
				var_134_15.localPosition = Vector3.New(0, 100, 0)

				local var_134_22 = manager.ui.mainCamera.transform.position - var_134_15.position

				var_134_15.forward = Vector3.New(var_134_22.x, var_134_22.y, var_134_22.z)

				local var_134_23 = var_134_15.localEulerAngles

				var_134_23.z = 0
				var_134_23.x = 0
				var_134_15.localEulerAngles = var_134_23
			end

			local var_134_24 = arg_131_1.actors_["1097ui_story"]
			local var_134_25 = 0

			if var_134_25 < arg_131_1.time_ and arg_131_1.time_ <= var_134_25 + arg_134_0 and not isNil(var_134_24) and arg_131_1.var_.characterEffect1097ui_story == nil then
				arg_131_1.var_.characterEffect1097ui_story = var_134_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_26 = 0.200000002980232

			if var_134_25 <= arg_131_1.time_ and arg_131_1.time_ < var_134_25 + var_134_26 and not isNil(var_134_24) then
				local var_134_27 = (arg_131_1.time_ - var_134_25) / var_134_26

				if arg_131_1.var_.characterEffect1097ui_story and not isNil(var_134_24) then
					local var_134_28 = Mathf.Lerp(0, 0.5, var_134_27)

					arg_131_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1097ui_story.fillRatio = var_134_28
				end
			end

			if arg_131_1.time_ >= var_134_25 + var_134_26 and arg_131_1.time_ < var_134_25 + var_134_26 + arg_134_0 and not isNil(var_134_24) and arg_131_1.var_.characterEffect1097ui_story then
				local var_134_29 = 0.5

				arg_131_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1097ui_story.fillRatio = var_134_29
			end

			local var_134_30 = 0
			local var_134_31 = 0.925

			if var_134_30 < arg_131_1.time_ and arg_131_1.time_ <= var_134_30 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_32 = arg_131_1:FormatText(StoryNameCfg[920].name)

				arg_131_1.leftNameTxt_.text = var_134_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_33 = arg_131_1:GetWordFromCfg(412031032)
				local var_134_34 = arg_131_1:FormatText(var_134_33.content)

				arg_131_1.text_.text = var_134_34

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_35 = 37
				local var_134_36 = utf8.len(var_134_34)
				local var_134_37 = var_134_35 <= 0 and var_134_31 or var_134_31 * (var_134_36 / var_134_35)

				if var_134_37 > 0 and var_134_31 < var_134_37 then
					arg_131_1.talkMaxDuration = var_134_37

					if var_134_37 + var_134_30 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_37 + var_134_30
					end
				end

				arg_131_1.text_.text = var_134_34
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031032", "story_v_out_412031.awb") ~= 0 then
					local var_134_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031032", "story_v_out_412031.awb") / 1000

					if var_134_38 + var_134_30 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_38 + var_134_30
					end

					if var_134_33.prefab_name ~= "" and arg_131_1.actors_[var_134_33.prefab_name] ~= nil then
						local var_134_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_33.prefab_name].transform, "story_v_out_412031", "412031032", "story_v_out_412031.awb")

						arg_131_1:RecordAudio("412031032", var_134_39)
						arg_131_1:RecordAudio("412031032", var_134_39)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_412031", "412031032", "story_v_out_412031.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_412031", "412031032", "story_v_out_412031.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_40 = math.max(var_134_31, arg_131_1.talkMaxDuration)

			if var_134_30 <= arg_131_1.time_ and arg_131_1.time_ < var_134_30 + var_134_40 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_30) / var_134_40

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_30 + var_134_40 and arg_131_1.time_ < var_134_30 + var_134_40 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play412031033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 412031033
		arg_135_1.duration_ = 7.23

		local var_135_0 = {
			zh = 7.233,
			ja = 6.033
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
				arg_135_0:Play412031034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10083ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos10083ui_story = var_138_0.localPosition
			end

			local var_138_2 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2
				local var_138_4 = Vector3.New(0, -2.6, -2.8)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10083ui_story, var_138_4, var_138_3)

				local var_138_5 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_5.x, var_138_5.y, var_138_5.z)

				local var_138_6 = var_138_0.localEulerAngles

				var_138_6.z = 0
				var_138_6.x = 0
				var_138_0.localEulerAngles = var_138_6
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_138_7 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_7.x, var_138_7.y, var_138_7.z)

				local var_138_8 = var_138_0.localEulerAngles

				var_138_8.z = 0
				var_138_8.x = 0
				var_138_0.localEulerAngles = var_138_8
			end

			local var_138_9 = arg_135_1.actors_["10083ui_story"]
			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 and not isNil(var_138_9) and arg_135_1.var_.characterEffect10083ui_story == nil then
				arg_135_1.var_.characterEffect10083ui_story = var_138_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_11 = 0.200000002980232

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_11 and not isNil(var_138_9) then
				local var_138_12 = (arg_135_1.time_ - var_138_10) / var_138_11

				if arg_135_1.var_.characterEffect10083ui_story and not isNil(var_138_9) then
					arg_135_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_10 + var_138_11 and arg_135_1.time_ < var_138_10 + var_138_11 + arg_138_0 and not isNil(var_138_9) and arg_135_1.var_.characterEffect10083ui_story then
				arg_135_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_138_13 = 0

			if var_138_13 < arg_135_1.time_ and arg_135_1.time_ <= var_138_13 + arg_138_0 then
				arg_135_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action3_1")
			end

			local var_138_14 = 0

			if var_138_14 < arg_135_1.time_ and arg_135_1.time_ <= var_138_14 + arg_138_0 then
				arg_135_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_15 = arg_135_1.actors_["3043ui_story"].transform
			local var_138_16 = 0

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 then
				arg_135_1.var_.moveOldPos3043ui_story = var_138_15.localPosition
			end

			local var_138_17 = 0.001

			if var_138_16 <= arg_135_1.time_ and arg_135_1.time_ < var_138_16 + var_138_17 then
				local var_138_18 = (arg_135_1.time_ - var_138_16) / var_138_17
				local var_138_19 = Vector3.New(0, 100, 0)

				var_138_15.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos3043ui_story, var_138_19, var_138_18)

				local var_138_20 = manager.ui.mainCamera.transform.position - var_138_15.position

				var_138_15.forward = Vector3.New(var_138_20.x, var_138_20.y, var_138_20.z)

				local var_138_21 = var_138_15.localEulerAngles

				var_138_21.z = 0
				var_138_21.x = 0
				var_138_15.localEulerAngles = var_138_21
			end

			if arg_135_1.time_ >= var_138_16 + var_138_17 and arg_135_1.time_ < var_138_16 + var_138_17 + arg_138_0 then
				var_138_15.localPosition = Vector3.New(0, 100, 0)

				local var_138_22 = manager.ui.mainCamera.transform.position - var_138_15.position

				var_138_15.forward = Vector3.New(var_138_22.x, var_138_22.y, var_138_22.z)

				local var_138_23 = var_138_15.localEulerAngles

				var_138_23.z = 0
				var_138_23.x = 0
				var_138_15.localEulerAngles = var_138_23
			end

			local var_138_24 = arg_135_1.actors_["3043ui_story"]
			local var_138_25 = 0

			if var_138_25 < arg_135_1.time_ and arg_135_1.time_ <= var_138_25 + arg_138_0 and not isNil(var_138_24) and arg_135_1.var_.characterEffect3043ui_story == nil then
				arg_135_1.var_.characterEffect3043ui_story = var_138_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_26 = 0.200000002980232

			if var_138_25 <= arg_135_1.time_ and arg_135_1.time_ < var_138_25 + var_138_26 and not isNil(var_138_24) then
				local var_138_27 = (arg_135_1.time_ - var_138_25) / var_138_26

				if arg_135_1.var_.characterEffect3043ui_story and not isNil(var_138_24) then
					local var_138_28 = Mathf.Lerp(0, 0.5, var_138_27)

					arg_135_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_135_1.var_.characterEffect3043ui_story.fillRatio = var_138_28
				end
			end

			if arg_135_1.time_ >= var_138_25 + var_138_26 and arg_135_1.time_ < var_138_25 + var_138_26 + arg_138_0 and not isNil(var_138_24) and arg_135_1.var_.characterEffect3043ui_story then
				local var_138_29 = 0.5

				arg_135_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_135_1.var_.characterEffect3043ui_story.fillRatio = var_138_29
			end

			local var_138_30 = 0
			local var_138_31 = 0.925

			if var_138_30 < arg_135_1.time_ and arg_135_1.time_ <= var_138_30 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_32 = arg_135_1:FormatText(StoryNameCfg[918].name)

				arg_135_1.leftNameTxt_.text = var_138_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_33 = arg_135_1:GetWordFromCfg(412031033)
				local var_138_34 = arg_135_1:FormatText(var_138_33.content)

				arg_135_1.text_.text = var_138_34

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_35 = 37
				local var_138_36 = utf8.len(var_138_34)
				local var_138_37 = var_138_35 <= 0 and var_138_31 or var_138_31 * (var_138_36 / var_138_35)

				if var_138_37 > 0 and var_138_31 < var_138_37 then
					arg_135_1.talkMaxDuration = var_138_37

					if var_138_37 + var_138_30 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_37 + var_138_30
					end
				end

				arg_135_1.text_.text = var_138_34
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031033", "story_v_out_412031.awb") ~= 0 then
					local var_138_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031033", "story_v_out_412031.awb") / 1000

					if var_138_38 + var_138_30 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_38 + var_138_30
					end

					if var_138_33.prefab_name ~= "" and arg_135_1.actors_[var_138_33.prefab_name] ~= nil then
						local var_138_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_33.prefab_name].transform, "story_v_out_412031", "412031033", "story_v_out_412031.awb")

						arg_135_1:RecordAudio("412031033", var_138_39)
						arg_135_1:RecordAudio("412031033", var_138_39)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_412031", "412031033", "story_v_out_412031.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_412031", "412031033", "story_v_out_412031.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_40 = math.max(var_138_31, arg_135_1.talkMaxDuration)

			if var_138_30 <= arg_135_1.time_ and arg_135_1.time_ < var_138_30 + var_138_40 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_30) / var_138_40

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_30 + var_138_40 and arg_135_1.time_ < var_138_30 + var_138_40 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play412031034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 412031034
		arg_139_1.duration_ = 8.87

		local var_139_0 = {
			zh = 8.866,
			ja = 5.4
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
				arg_139_0:Play412031035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.95

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[918].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_3 = arg_139_1:GetWordFromCfg(412031034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031034", "story_v_out_412031.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031034", "story_v_out_412031.awb") / 1000

					if var_142_8 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_0
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_412031", "412031034", "story_v_out_412031.awb")

						arg_139_1:RecordAudio("412031034", var_142_9)
						arg_139_1:RecordAudio("412031034", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_412031", "412031034", "story_v_out_412031.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_412031", "412031034", "story_v_out_412031.awb")
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
	Play412031035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 412031035
		arg_143_1.duration_ = 5.4

		local var_143_0 = {
			zh = 1.999999999999,
			ja = 5.4
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
				arg_143_0:Play412031036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["3043ui_story"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos3043ui_story = var_146_0.localPosition
			end

			local var_146_2 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2
				local var_146_4 = Vector3.New(0, -1.41, -5.7)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos3043ui_story, var_146_4, var_146_3)

				local var_146_5 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_5.x, var_146_5.y, var_146_5.z)

				local var_146_6 = var_146_0.localEulerAngles

				var_146_6.z = 0
				var_146_6.x = 0
				var_146_0.localEulerAngles = var_146_6
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(0, -1.41, -5.7)

				local var_146_7 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_7.x, var_146_7.y, var_146_7.z)

				local var_146_8 = var_146_0.localEulerAngles

				var_146_8.z = 0
				var_146_8.x = 0
				var_146_0.localEulerAngles = var_146_8
			end

			local var_146_9 = arg_143_1.actors_["3043ui_story"]
			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 and not isNil(var_146_9) and arg_143_1.var_.characterEffect3043ui_story == nil then
				arg_143_1.var_.characterEffect3043ui_story = var_146_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_11 = 0.200000002980232

			if var_146_10 <= arg_143_1.time_ and arg_143_1.time_ < var_146_10 + var_146_11 and not isNil(var_146_9) then
				local var_146_12 = (arg_143_1.time_ - var_146_10) / var_146_11

				if arg_143_1.var_.characterEffect3043ui_story and not isNil(var_146_9) then
					arg_143_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_10 + var_146_11 and arg_143_1.time_ < var_146_10 + var_146_11 + arg_146_0 and not isNil(var_146_9) and arg_143_1.var_.characterEffect3043ui_story then
				arg_143_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_146_13 = 0

			if var_146_13 < arg_143_1.time_ and arg_143_1.time_ <= var_146_13 + arg_146_0 then
				arg_143_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_146_14 = 0

			if var_146_14 < arg_143_1.time_ and arg_143_1.time_ <= var_146_14 + arg_146_0 then
				arg_143_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_15 = arg_143_1.actors_["10083ui_story"].transform
			local var_146_16 = 0

			if var_146_16 < arg_143_1.time_ and arg_143_1.time_ <= var_146_16 + arg_146_0 then
				arg_143_1.var_.moveOldPos10083ui_story = var_146_15.localPosition
			end

			local var_146_17 = 0.001

			if var_146_16 <= arg_143_1.time_ and arg_143_1.time_ < var_146_16 + var_146_17 then
				local var_146_18 = (arg_143_1.time_ - var_146_16) / var_146_17
				local var_146_19 = Vector3.New(0, 100, 0)

				var_146_15.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10083ui_story, var_146_19, var_146_18)

				local var_146_20 = manager.ui.mainCamera.transform.position - var_146_15.position

				var_146_15.forward = Vector3.New(var_146_20.x, var_146_20.y, var_146_20.z)

				local var_146_21 = var_146_15.localEulerAngles

				var_146_21.z = 0
				var_146_21.x = 0
				var_146_15.localEulerAngles = var_146_21
			end

			if arg_143_1.time_ >= var_146_16 + var_146_17 and arg_143_1.time_ < var_146_16 + var_146_17 + arg_146_0 then
				var_146_15.localPosition = Vector3.New(0, 100, 0)

				local var_146_22 = manager.ui.mainCamera.transform.position - var_146_15.position

				var_146_15.forward = Vector3.New(var_146_22.x, var_146_22.y, var_146_22.z)

				local var_146_23 = var_146_15.localEulerAngles

				var_146_23.z = 0
				var_146_23.x = 0
				var_146_15.localEulerAngles = var_146_23
			end

			local var_146_24 = arg_143_1.actors_["10083ui_story"]
			local var_146_25 = 0

			if var_146_25 < arg_143_1.time_ and arg_143_1.time_ <= var_146_25 + arg_146_0 and not isNil(var_146_24) and arg_143_1.var_.characterEffect10083ui_story == nil then
				arg_143_1.var_.characterEffect10083ui_story = var_146_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_26 = 0.200000002980232

			if var_146_25 <= arg_143_1.time_ and arg_143_1.time_ < var_146_25 + var_146_26 and not isNil(var_146_24) then
				local var_146_27 = (arg_143_1.time_ - var_146_25) / var_146_26

				if arg_143_1.var_.characterEffect10083ui_story and not isNil(var_146_24) then
					local var_146_28 = Mathf.Lerp(0, 0.5, var_146_27)

					arg_143_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10083ui_story.fillRatio = var_146_28
				end
			end

			if arg_143_1.time_ >= var_146_25 + var_146_26 and arg_143_1.time_ < var_146_25 + var_146_26 + arg_146_0 and not isNil(var_146_24) and arg_143_1.var_.characterEffect10083ui_story then
				local var_146_29 = 0.5

				arg_143_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10083ui_story.fillRatio = var_146_29
			end

			local var_146_30 = 0
			local var_146_31 = 0.25

			if var_146_30 < arg_143_1.time_ and arg_143_1.time_ <= var_146_30 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_32 = arg_143_1:FormatText(StoryNameCfg[920].name)

				arg_143_1.leftNameTxt_.text = var_146_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_33 = arg_143_1:GetWordFromCfg(412031035)
				local var_146_34 = arg_143_1:FormatText(var_146_33.content)

				arg_143_1.text_.text = var_146_34

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_35 = 10
				local var_146_36 = utf8.len(var_146_34)
				local var_146_37 = var_146_35 <= 0 and var_146_31 or var_146_31 * (var_146_36 / var_146_35)

				if var_146_37 > 0 and var_146_31 < var_146_37 then
					arg_143_1.talkMaxDuration = var_146_37

					if var_146_37 + var_146_30 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_37 + var_146_30
					end
				end

				arg_143_1.text_.text = var_146_34
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031035", "story_v_out_412031.awb") ~= 0 then
					local var_146_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031035", "story_v_out_412031.awb") / 1000

					if var_146_38 + var_146_30 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_38 + var_146_30
					end

					if var_146_33.prefab_name ~= "" and arg_143_1.actors_[var_146_33.prefab_name] ~= nil then
						local var_146_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_33.prefab_name].transform, "story_v_out_412031", "412031035", "story_v_out_412031.awb")

						arg_143_1:RecordAudio("412031035", var_146_39)
						arg_143_1:RecordAudio("412031035", var_146_39)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_412031", "412031035", "story_v_out_412031.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_412031", "412031035", "story_v_out_412031.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_40 = math.max(var_146_31, arg_143_1.talkMaxDuration)

			if var_146_30 <= arg_143_1.time_ and arg_143_1.time_ < var_146_30 + var_146_40 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_30) / var_146_40

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_30 + var_146_40 and arg_143_1.time_ < var_146_30 + var_146_40 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play412031036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 412031036
		arg_147_1.duration_ = 7

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play412031037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = "EN0101"

			if arg_147_1.bgs_[var_150_0] == nil then
				local var_150_1 = Object.Instantiate(arg_147_1.paintGo_)

				var_150_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_150_0)
				var_150_1.name = var_150_0
				var_150_1.transform.parent = arg_147_1.stage_.transform
				var_150_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.bgs_[var_150_0] = var_150_1
			end

			local var_150_2 = 0.5

			if var_150_2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				local var_150_3 = manager.ui.mainCamera.transform.localPosition
				local var_150_4 = Vector3.New(0, 0, 10) + Vector3.New(var_150_3.x, var_150_3.y, 0)
				local var_150_5 = arg_147_1.bgs_.EN0101

				var_150_5.transform.localPosition = var_150_4
				var_150_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_6 = var_150_5:GetComponent("SpriteRenderer")

				if var_150_6 and var_150_6.sprite then
					local var_150_7 = (var_150_5.transform.localPosition - var_150_3).z
					local var_150_8 = manager.ui.mainCameraCom_
					local var_150_9 = 2 * var_150_7 * Mathf.Tan(var_150_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_150_10 = var_150_9 * var_150_8.aspect
					local var_150_11 = var_150_6.sprite.bounds.size.x
					local var_150_12 = var_150_6.sprite.bounds.size.y
					local var_150_13 = var_150_10 / var_150_11
					local var_150_14 = var_150_9 / var_150_12
					local var_150_15 = var_150_14 < var_150_13 and var_150_13 or var_150_14

					var_150_5.transform.localScale = Vector3.New(var_150_15, var_150_15, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "EN0101" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_16 = 2

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			local var_150_17 = 0.3

			if arg_147_1.time_ >= var_150_16 + var_150_17 and arg_147_1.time_ < var_150_16 + var_150_17 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end

			local var_150_18 = 0

			if var_150_18 < arg_147_1.time_ and arg_147_1.time_ <= var_150_18 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_19 = 0.5

			if var_150_18 <= arg_147_1.time_ and arg_147_1.time_ < var_150_18 + var_150_19 then
				local var_150_20 = (arg_147_1.time_ - var_150_18) / var_150_19
				local var_150_21 = Color.New(0, 0, 0)

				var_150_21.a = Mathf.Lerp(0, 1, var_150_20)
				arg_147_1.mask_.color = var_150_21
			end

			if arg_147_1.time_ >= var_150_18 + var_150_19 and arg_147_1.time_ < var_150_18 + var_150_19 + arg_150_0 then
				local var_150_22 = Color.New(0, 0, 0)

				var_150_22.a = 1
				arg_147_1.mask_.color = var_150_22
			end

			local var_150_23 = 0.5

			if var_150_23 < arg_147_1.time_ and arg_147_1.time_ <= var_150_23 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_24 = 1.5

			if var_150_23 <= arg_147_1.time_ and arg_147_1.time_ < var_150_23 + var_150_24 then
				local var_150_25 = (arg_147_1.time_ - var_150_23) / var_150_24
				local var_150_26 = Color.New(0, 0, 0)

				var_150_26.a = Mathf.Lerp(1, 0, var_150_25)
				arg_147_1.mask_.color = var_150_26
			end

			if arg_147_1.time_ >= var_150_23 + var_150_24 and arg_147_1.time_ < var_150_23 + var_150_24 + arg_150_0 then
				local var_150_27 = Color.New(0, 0, 0)
				local var_150_28 = 0

				arg_147_1.mask_.enabled = false
				var_150_27.a = var_150_28
				arg_147_1.mask_.color = var_150_27
			end

			local var_150_29 = arg_147_1.actors_["3043ui_story"].transform
			local var_150_30 = 0

			if var_150_30 < arg_147_1.time_ and arg_147_1.time_ <= var_150_30 + arg_150_0 then
				arg_147_1.var_.moveOldPos3043ui_story = var_150_29.localPosition
			end

			local var_150_31 = 0.001

			if var_150_30 <= arg_147_1.time_ and arg_147_1.time_ < var_150_30 + var_150_31 then
				local var_150_32 = (arg_147_1.time_ - var_150_30) / var_150_31
				local var_150_33 = Vector3.New(0, 100, 0)

				var_150_29.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos3043ui_story, var_150_33, var_150_32)

				local var_150_34 = manager.ui.mainCamera.transform.position - var_150_29.position

				var_150_29.forward = Vector3.New(var_150_34.x, var_150_34.y, var_150_34.z)

				local var_150_35 = var_150_29.localEulerAngles

				var_150_35.z = 0
				var_150_35.x = 0
				var_150_29.localEulerAngles = var_150_35
			end

			if arg_147_1.time_ >= var_150_30 + var_150_31 and arg_147_1.time_ < var_150_30 + var_150_31 + arg_150_0 then
				var_150_29.localPosition = Vector3.New(0, 100, 0)

				local var_150_36 = manager.ui.mainCamera.transform.position - var_150_29.position

				var_150_29.forward = Vector3.New(var_150_36.x, var_150_36.y, var_150_36.z)

				local var_150_37 = var_150_29.localEulerAngles

				var_150_37.z = 0
				var_150_37.x = 0
				var_150_29.localEulerAngles = var_150_37
			end

			local var_150_38 = arg_147_1.actors_["3043ui_story"]
			local var_150_39 = 0

			if var_150_39 < arg_147_1.time_ and arg_147_1.time_ <= var_150_39 + arg_150_0 and not isNil(var_150_38) and arg_147_1.var_.characterEffect3043ui_story == nil then
				arg_147_1.var_.characterEffect3043ui_story = var_150_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_40 = 0.034000001847744

			if var_150_39 <= arg_147_1.time_ and arg_147_1.time_ < var_150_39 + var_150_40 and not isNil(var_150_38) then
				local var_150_41 = (arg_147_1.time_ - var_150_39) / var_150_40

				if arg_147_1.var_.characterEffect3043ui_story and not isNil(var_150_38) then
					local var_150_42 = Mathf.Lerp(0, 0.5, var_150_41)

					arg_147_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_147_1.var_.characterEffect3043ui_story.fillRatio = var_150_42
				end
			end

			if arg_147_1.time_ >= var_150_39 + var_150_40 and arg_147_1.time_ < var_150_39 + var_150_40 + arg_150_0 and not isNil(var_150_38) and arg_147_1.var_.characterEffect3043ui_story then
				local var_150_43 = 0.5

				arg_147_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_147_1.var_.characterEffect3043ui_story.fillRatio = var_150_43
			end

			local var_150_44 = arg_147_1.bgs_.EN0101.transform
			local var_150_45 = 0.5

			if var_150_45 < arg_147_1.time_ and arg_147_1.time_ <= var_150_45 + arg_150_0 then
				arg_147_1.var_.moveOldPosEN0101 = var_150_44.localPosition
			end

			local var_150_46 = 0.001

			if var_150_45 <= arg_147_1.time_ and arg_147_1.time_ < var_150_45 + var_150_46 then
				local var_150_47 = (arg_147_1.time_ - var_150_45) / var_150_46
				local var_150_48 = Vector3.New(0, 1, 9)

				var_150_44.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPosEN0101, var_150_48, var_150_47)
			end

			if arg_147_1.time_ >= var_150_45 + var_150_46 and arg_147_1.time_ < var_150_45 + var_150_46 + arg_150_0 then
				var_150_44.localPosition = Vector3.New(0, 1, 9)
			end

			local var_150_49 = arg_147_1.bgs_.EN0101.transform
			local var_150_50 = 0.534000001847744

			if var_150_50 < arg_147_1.time_ and arg_147_1.time_ <= var_150_50 + arg_150_0 then
				arg_147_1.var_.moveOldPosEN0101 = var_150_49.localPosition
			end

			local var_150_51 = 4.5

			if var_150_50 <= arg_147_1.time_ and arg_147_1.time_ < var_150_50 + var_150_51 then
				local var_150_52 = (arg_147_1.time_ - var_150_50) / var_150_51
				local var_150_53 = Vector3.New(0, 1, 10)

				var_150_49.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPosEN0101, var_150_53, var_150_52)
			end

			if arg_147_1.time_ >= var_150_50 + var_150_51 and arg_147_1.time_ < var_150_50 + var_150_51 + arg_150_0 then
				var_150_49.localPosition = Vector3.New(0, 1, 10)
			end

			local var_150_54 = 2

			if var_150_54 < arg_147_1.time_ and arg_147_1.time_ <= var_150_54 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			local var_150_55 = 2.53400000184774

			if arg_147_1.time_ >= var_150_54 + var_150_55 and arg_147_1.time_ < var_150_54 + var_150_55 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_56 = 2
			local var_150_57 = 0.95

			if var_150_56 < arg_147_1.time_ and arg_147_1.time_ <= var_150_56 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_58 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_58:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_147_1.dialogCg_.alpha = arg_151_0
				end))
				var_150_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_59 = arg_147_1:GetWordFromCfg(412031036)
				local var_150_60 = arg_147_1:FormatText(var_150_59.content)

				arg_147_1.text_.text = var_150_60

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_61 = 38
				local var_150_62 = utf8.len(var_150_60)
				local var_150_63 = var_150_61 <= 0 and var_150_57 or var_150_57 * (var_150_62 / var_150_61)

				if var_150_63 > 0 and var_150_57 < var_150_63 then
					arg_147_1.talkMaxDuration = var_150_63
					var_150_56 = var_150_56 + 0.3

					if var_150_63 + var_150_56 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_63 + var_150_56
					end
				end

				arg_147_1.text_.text = var_150_60
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_64 = var_150_56 + 0.3
			local var_150_65 = math.max(var_150_57, arg_147_1.talkMaxDuration)

			if var_150_64 <= arg_147_1.time_ and arg_147_1.time_ < var_150_64 + var_150_65 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_64) / var_150_65

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_64 + var_150_65 and arg_147_1.time_ < var_150_64 + var_150_65 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "EN0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "EN0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0.534000001847744,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play412031037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 412031037
		arg_153_1.duration_ = 4.63

		local var_153_0 = {
			zh = 3.5,
			ja = 4.633
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play412031038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.4

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[920].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(412031037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 16
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031037", "story_v_out_412031.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031037", "story_v_out_412031.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_412031", "412031037", "story_v_out_412031.awb")

						arg_153_1:RecordAudio("412031037", var_156_9)
						arg_153_1:RecordAudio("412031037", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_412031", "412031037", "story_v_out_412031.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_412031", "412031037", "story_v_out_412031.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_10 and arg_153_1.time_ < var_156_0 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play412031038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 412031038
		arg_157_1.duration_ = 7.07

		local var_157_0 = {
			zh = 5.6,
			ja = 7.066
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play412031039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.425

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[216].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_3 = arg_157_1:GetWordFromCfg(412031038)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 17
				local var_160_6 = utf8.len(var_160_4)
				local var_160_7 = var_160_5 <= 0 and var_160_1 or var_160_1 * (var_160_6 / var_160_5)

				if var_160_7 > 0 and var_160_1 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031038", "story_v_out_412031.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031038", "story_v_out_412031.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_412031", "412031038", "story_v_out_412031.awb")

						arg_157_1:RecordAudio("412031038", var_160_9)
						arg_157_1:RecordAudio("412031038", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_412031", "412031038", "story_v_out_412031.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_412031", "412031038", "story_v_out_412031.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_10 and arg_157_1.time_ < var_160_0 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play412031039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 412031039
		arg_161_1.duration_ = 1.9

		local var_161_0 = {
			zh = 1.2,
			ja = 1.9
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play412031040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.1

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[920].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(412031039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 4
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031039", "story_v_out_412031.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031039", "story_v_out_412031.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_412031", "412031039", "story_v_out_412031.awb")

						arg_161_1:RecordAudio("412031039", var_164_9)
						arg_161_1:RecordAudio("412031039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_412031", "412031039", "story_v_out_412031.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_412031", "412031039", "story_v_out_412031.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_10 and arg_161_1.time_ < var_164_0 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play412031040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 412031040
		arg_165_1.duration_ = 8.97

		local var_165_0 = {
			zh = 7.333,
			ja = 8.966
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
				arg_165_0:Play412031041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.55

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[216].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:GetWordFromCfg(412031040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031040", "story_v_out_412031.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031040", "story_v_out_412031.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_412031", "412031040", "story_v_out_412031.awb")

						arg_165_1:RecordAudio("412031040", var_168_9)
						arg_165_1:RecordAudio("412031040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_412031", "412031040", "story_v_out_412031.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_412031", "412031040", "story_v_out_412031.awb")
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
	Play412031041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 412031041
		arg_169_1.duration_ = 6.23

		local var_169_0 = {
			zh = 3.466,
			ja = 6.233
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play412031042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.35

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[920].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:GetWordFromCfg(412031041)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 14
				local var_172_6 = utf8.len(var_172_4)
				local var_172_7 = var_172_5 <= 0 and var_172_1 or var_172_1 * (var_172_6 / var_172_5)

				if var_172_7 > 0 and var_172_1 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031041", "story_v_out_412031.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031041", "story_v_out_412031.awb") / 1000

					if var_172_8 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_0
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_412031", "412031041", "story_v_out_412031.awb")

						arg_169_1:RecordAudio("412031041", var_172_9)
						arg_169_1:RecordAudio("412031041", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_412031", "412031041", "story_v_out_412031.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_412031", "412031041", "story_v_out_412031.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_10 and arg_169_1.time_ < var_172_0 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play412031042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 412031042
		arg_173_1.duration_ = 4.93

		local var_173_0 = {
			zh = 3,
			ja = 4.933
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
				arg_173_0:Play412031043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.2

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[216].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:GetWordFromCfg(412031042)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 8
				local var_176_6 = utf8.len(var_176_4)
				local var_176_7 = var_176_5 <= 0 and var_176_1 or var_176_1 * (var_176_6 / var_176_5)

				if var_176_7 > 0 and var_176_1 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031042", "story_v_out_412031.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031042", "story_v_out_412031.awb") / 1000

					if var_176_8 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_0
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_out_412031", "412031042", "story_v_out_412031.awb")

						arg_173_1:RecordAudio("412031042", var_176_9)
						arg_173_1:RecordAudio("412031042", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_412031", "412031042", "story_v_out_412031.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_412031", "412031042", "story_v_out_412031.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_10 and arg_173_1.time_ < var_176_0 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play412031043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 412031043
		arg_177_1.duration_ = 4.87

		local var_177_0 = {
			zh = 3.3,
			ja = 4.866
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
				arg_177_0:Play412031044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.35

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[920].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:GetWordFromCfg(412031043)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 14
				local var_180_6 = utf8.len(var_180_4)
				local var_180_7 = var_180_5 <= 0 and var_180_1 or var_180_1 * (var_180_6 / var_180_5)

				if var_180_7 > 0 and var_180_1 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031043", "story_v_out_412031.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031043", "story_v_out_412031.awb") / 1000

					if var_180_8 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_0
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_412031", "412031043", "story_v_out_412031.awb")

						arg_177_1:RecordAudio("412031043", var_180_9)
						arg_177_1:RecordAudio("412031043", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_412031", "412031043", "story_v_out_412031.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_412031", "412031043", "story_v_out_412031.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_10 and arg_177_1.time_ < var_180_0 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play412031044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 412031044
		arg_181_1.duration_ = 9.7

		local var_181_0 = {
			zh = 9.7,
			ja = 6.8
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
				arg_181_0:Play412031045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.975

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[920].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:GetWordFromCfg(412031044)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 39
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031044", "story_v_out_412031.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031044", "story_v_out_412031.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_412031", "412031044", "story_v_out_412031.awb")

						arg_181_1:RecordAudio("412031044", var_184_9)
						arg_181_1:RecordAudio("412031044", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_412031", "412031044", "story_v_out_412031.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_412031", "412031044", "story_v_out_412031.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_10 and arg_181_1.time_ < var_184_0 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play412031045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 412031045
		arg_185_1.duration_ = 9.9

		local var_185_0 = {
			zh = 8.333,
			ja = 9.9
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
				arg_185_0:Play412031046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.65

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[920].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:GetWordFromCfg(412031045)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 26
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031045", "story_v_out_412031.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031045", "story_v_out_412031.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_412031", "412031045", "story_v_out_412031.awb")

						arg_185_1:RecordAudio("412031045", var_188_9)
						arg_185_1:RecordAudio("412031045", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_412031", "412031045", "story_v_out_412031.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_412031", "412031045", "story_v_out_412031.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_10 and arg_185_1.time_ < var_188_0 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play412031046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 412031046
		arg_189_1.duration_ = 7

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play412031047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				local var_192_1 = manager.ui.mainCamera.transform.localPosition
				local var_192_2 = Vector3.New(0, 0, 10) + Vector3.New(var_192_1.x, var_192_1.y, 0)
				local var_192_3 = arg_189_1.bgs_.ST30

				var_192_3.transform.localPosition = var_192_2
				var_192_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_192_4 = var_192_3:GetComponent("SpriteRenderer")

				if var_192_4 and var_192_4.sprite then
					local var_192_5 = (var_192_3.transform.localPosition - var_192_1).z
					local var_192_6 = manager.ui.mainCameraCom_
					local var_192_7 = 2 * var_192_5 * Mathf.Tan(var_192_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_192_8 = var_192_7 * var_192_6.aspect
					local var_192_9 = var_192_4.sprite.bounds.size.x
					local var_192_10 = var_192_4.sprite.bounds.size.y
					local var_192_11 = var_192_8 / var_192_9
					local var_192_12 = var_192_7 / var_192_10
					local var_192_13 = var_192_12 < var_192_11 and var_192_11 or var_192_12

					var_192_3.transform.localScale = Vector3.New(var_192_13, var_192_13, 0)
				end

				for iter_192_0, iter_192_1 in pairs(arg_189_1.bgs_) do
					if iter_192_0 ~= "ST30" then
						iter_192_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_192_14 = 1.999999999999

			if var_192_14 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1.allBtn_.enabled = false
			end

			local var_192_15 = 0.3

			if arg_189_1.time_ >= var_192_14 + var_192_15 and arg_189_1.time_ < var_192_14 + var_192_15 + arg_192_0 then
				arg_189_1.allBtn_.enabled = true
			end

			local var_192_16 = 0

			if var_192_16 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_17 = 2

			if var_192_16 <= arg_189_1.time_ and arg_189_1.time_ < var_192_16 + var_192_17 then
				local var_192_18 = (arg_189_1.time_ - var_192_16) / var_192_17
				local var_192_19 = Color.New(1, 1, 1)

				var_192_19.a = Mathf.Lerp(1, 0, var_192_18)
				arg_189_1.mask_.color = var_192_19
			end

			if arg_189_1.time_ >= var_192_16 + var_192_17 and arg_189_1.time_ < var_192_16 + var_192_17 + arg_192_0 then
				local var_192_20 = Color.New(1, 1, 1)
				local var_192_21 = 0

				arg_189_1.mask_.enabled = false
				var_192_20.a = var_192_21
				arg_189_1.mask_.color = var_192_20
			end

			if arg_189_1.frameCnt_ <= 1 then
				arg_189_1.dialog_:SetActive(false)
			end

			local var_192_22 = 2
			local var_192_23 = 0.375

			if var_192_22 < arg_189_1.time_ and arg_189_1.time_ <= var_192_22 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				arg_189_1.dialog_:SetActive(true)

				arg_189_1.dialogCg_.alpha = 0

				local var_192_24 = LeanTween.value(arg_189_1.dialog_, 0, 1, 0.3)

				var_192_24:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_189_1.dialogCg_.alpha = arg_193_0
				end))
				var_192_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_189_1.dialog_)
					var_192_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_189_1.duration_ = arg_189_1.duration_ + 0.3

				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_25 = arg_189_1:GetWordFromCfg(412031046)
				local var_192_26 = arg_189_1:FormatText(var_192_25.content)

				arg_189_1.text_.text = var_192_26

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_27 = 15
				local var_192_28 = utf8.len(var_192_26)
				local var_192_29 = var_192_27 <= 0 and var_192_23 or var_192_23 * (var_192_28 / var_192_27)

				if var_192_29 > 0 and var_192_23 < var_192_29 then
					arg_189_1.talkMaxDuration = var_192_29
					var_192_22 = var_192_22 + 0.3

					if var_192_29 + var_192_22 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_29 + var_192_22
					end
				end

				arg_189_1.text_.text = var_192_26
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_30 = var_192_22 + 0.3
			local var_192_31 = math.max(var_192_23, arg_189_1.talkMaxDuration)

			if var_192_30 <= arg_189_1.time_ and arg_189_1.time_ < var_192_30 + var_192_31 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_30) / var_192_31

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_30 + var_192_31 and arg_189_1.time_ < var_192_30 + var_192_31 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play412031047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 412031047
		arg_195_1.duration_ = 8.57

		local var_195_0 = {
			zh = 6.633,
			ja = 8.566
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
				arg_195_0:Play412031048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10076ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos10076ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(0, -0.35, -4)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10076ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, -0.35, -4)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = arg_195_1.actors_["10076ui_story"]
			local var_198_10 = 0

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect10076ui_story == nil then
				arg_195_1.var_.characterEffect10076ui_story = var_198_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_11 = 0.200000002980232

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_11 and not isNil(var_198_9) then
				local var_198_12 = (arg_195_1.time_ - var_198_10) / var_198_11

				if arg_195_1.var_.characterEffect10076ui_story and not isNil(var_198_9) then
					arg_195_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_10 + var_198_11 and arg_195_1.time_ < var_198_10 + var_198_11 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect10076ui_story then
				arg_195_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_198_13 = 0

			if var_198_13 < arg_195_1.time_ and arg_195_1.time_ <= var_198_13 + arg_198_0 then
				arg_195_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			local var_198_14 = 0

			if var_198_14 < arg_195_1.time_ and arg_195_1.time_ <= var_198_14 + arg_198_0 then
				arg_195_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_198_15 = 0
			local var_198_16 = 0.75

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_17 = arg_195_1:FormatText(StoryNameCfg[917].name)

				arg_195_1.leftNameTxt_.text = var_198_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_18 = arg_195_1:GetWordFromCfg(412031047)
				local var_198_19 = arg_195_1:FormatText(var_198_18.content)

				arg_195_1.text_.text = var_198_19

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_20 = 30
				local var_198_21 = utf8.len(var_198_19)
				local var_198_22 = var_198_20 <= 0 and var_198_16 or var_198_16 * (var_198_21 / var_198_20)

				if var_198_22 > 0 and var_198_16 < var_198_22 then
					arg_195_1.talkMaxDuration = var_198_22

					if var_198_22 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_22 + var_198_15
					end
				end

				arg_195_1.text_.text = var_198_19
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031047", "story_v_out_412031.awb") ~= 0 then
					local var_198_23 = manager.audio:GetVoiceLength("story_v_out_412031", "412031047", "story_v_out_412031.awb") / 1000

					if var_198_23 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_23 + var_198_15
					end

					if var_198_18.prefab_name ~= "" and arg_195_1.actors_[var_198_18.prefab_name] ~= nil then
						local var_198_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_18.prefab_name].transform, "story_v_out_412031", "412031047", "story_v_out_412031.awb")

						arg_195_1:RecordAudio("412031047", var_198_24)
						arg_195_1:RecordAudio("412031047", var_198_24)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_412031", "412031047", "story_v_out_412031.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_412031", "412031047", "story_v_out_412031.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_25 = math.max(var_198_16, arg_195_1.talkMaxDuration)

			if var_198_15 <= arg_195_1.time_ and arg_195_1.time_ < var_198_15 + var_198_25 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_15) / var_198_25

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_15 + var_198_25 and arg_195_1.time_ < var_198_15 + var_198_25 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play412031048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 412031048
		arg_199_1.duration_ = 9.7

		local var_199_0 = {
			zh = 6.933,
			ja = 9.7
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
				arg_199_0:Play412031049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1097ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos1097ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(0, -0.54, -6.3)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1097ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = arg_199_1.actors_["1097ui_story"]
			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect1097ui_story == nil then
				arg_199_1.var_.characterEffect1097ui_story = var_202_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_11 = 0.200000002980232

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_11 and not isNil(var_202_9) then
				local var_202_12 = (arg_199_1.time_ - var_202_10) / var_202_11

				if arg_199_1.var_.characterEffect1097ui_story and not isNil(var_202_9) then
					arg_199_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_10 + var_202_11 and arg_199_1.time_ < var_202_10 + var_202_11 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect1097ui_story then
				arg_199_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_202_13 = 0

			if var_202_13 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				arg_199_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_202_14 = 0

			if var_202_14 < arg_199_1.time_ and arg_199_1.time_ <= var_202_14 + arg_202_0 then
				arg_199_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_202_15 = arg_199_1.actors_["10076ui_story"].transform
			local var_202_16 = 0

			if var_202_16 < arg_199_1.time_ and arg_199_1.time_ <= var_202_16 + arg_202_0 then
				arg_199_1.var_.moveOldPos10076ui_story = var_202_15.localPosition
			end

			local var_202_17 = 0.001

			if var_202_16 <= arg_199_1.time_ and arg_199_1.time_ < var_202_16 + var_202_17 then
				local var_202_18 = (arg_199_1.time_ - var_202_16) / var_202_17
				local var_202_19 = Vector3.New(0, 100, 0)

				var_202_15.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10076ui_story, var_202_19, var_202_18)

				local var_202_20 = manager.ui.mainCamera.transform.position - var_202_15.position

				var_202_15.forward = Vector3.New(var_202_20.x, var_202_20.y, var_202_20.z)

				local var_202_21 = var_202_15.localEulerAngles

				var_202_21.z = 0
				var_202_21.x = 0
				var_202_15.localEulerAngles = var_202_21
			end

			if arg_199_1.time_ >= var_202_16 + var_202_17 and arg_199_1.time_ < var_202_16 + var_202_17 + arg_202_0 then
				var_202_15.localPosition = Vector3.New(0, 100, 0)

				local var_202_22 = manager.ui.mainCamera.transform.position - var_202_15.position

				var_202_15.forward = Vector3.New(var_202_22.x, var_202_22.y, var_202_22.z)

				local var_202_23 = var_202_15.localEulerAngles

				var_202_23.z = 0
				var_202_23.x = 0
				var_202_15.localEulerAngles = var_202_23
			end

			local var_202_24 = arg_199_1.actors_["10076ui_story"]
			local var_202_25 = 0

			if var_202_25 < arg_199_1.time_ and arg_199_1.time_ <= var_202_25 + arg_202_0 and not isNil(var_202_24) and arg_199_1.var_.characterEffect10076ui_story == nil then
				arg_199_1.var_.characterEffect10076ui_story = var_202_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_26 = 0.200000002980232

			if var_202_25 <= arg_199_1.time_ and arg_199_1.time_ < var_202_25 + var_202_26 and not isNil(var_202_24) then
				local var_202_27 = (arg_199_1.time_ - var_202_25) / var_202_26

				if arg_199_1.var_.characterEffect10076ui_story and not isNil(var_202_24) then
					local var_202_28 = Mathf.Lerp(0, 0.5, var_202_27)

					arg_199_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_199_1.var_.characterEffect10076ui_story.fillRatio = var_202_28
				end
			end

			if arg_199_1.time_ >= var_202_25 + var_202_26 and arg_199_1.time_ < var_202_25 + var_202_26 + arg_202_0 and not isNil(var_202_24) and arg_199_1.var_.characterEffect10076ui_story then
				local var_202_29 = 0.5

				arg_199_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_199_1.var_.characterEffect10076ui_story.fillRatio = var_202_29
			end

			local var_202_30 = 0
			local var_202_31 = 0.55

			if var_202_30 < arg_199_1.time_ and arg_199_1.time_ <= var_202_30 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_32 = arg_199_1:FormatText(StoryNameCfg[216].name)

				arg_199_1.leftNameTxt_.text = var_202_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_33 = arg_199_1:GetWordFromCfg(412031048)
				local var_202_34 = arg_199_1:FormatText(var_202_33.content)

				arg_199_1.text_.text = var_202_34

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_35 = 22
				local var_202_36 = utf8.len(var_202_34)
				local var_202_37 = var_202_35 <= 0 and var_202_31 or var_202_31 * (var_202_36 / var_202_35)

				if var_202_37 > 0 and var_202_31 < var_202_37 then
					arg_199_1.talkMaxDuration = var_202_37

					if var_202_37 + var_202_30 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_37 + var_202_30
					end
				end

				arg_199_1.text_.text = var_202_34
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031048", "story_v_out_412031.awb") ~= 0 then
					local var_202_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031048", "story_v_out_412031.awb") / 1000

					if var_202_38 + var_202_30 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_38 + var_202_30
					end

					if var_202_33.prefab_name ~= "" and arg_199_1.actors_[var_202_33.prefab_name] ~= nil then
						local var_202_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_33.prefab_name].transform, "story_v_out_412031", "412031048", "story_v_out_412031.awb")

						arg_199_1:RecordAudio("412031048", var_202_39)
						arg_199_1:RecordAudio("412031048", var_202_39)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_412031", "412031048", "story_v_out_412031.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_412031", "412031048", "story_v_out_412031.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_40 = math.max(var_202_31, arg_199_1.talkMaxDuration)

			if var_202_30 <= arg_199_1.time_ and arg_199_1.time_ < var_202_30 + var_202_40 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_30) / var_202_40

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_30 + var_202_40 and arg_199_1.time_ < var_202_30 + var_202_40 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play412031049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 412031049
		arg_203_1.duration_ = 6.4

		local var_203_0 = {
			zh = 4.833,
			ja = 6.4
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
				arg_203_0:Play412031050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10078ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos10078ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(0, -0.5, -6.3)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10078ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["10078ui_story"]
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect10078ui_story == nil then
				arg_203_1.var_.characterEffect10078ui_story = var_206_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_11 = 0.200000002980232

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 and not isNil(var_206_9) then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11

				if arg_203_1.var_.characterEffect10078ui_story and not isNil(var_206_9) then
					arg_203_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect10078ui_story then
				arg_203_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_206_13 = 0

			if var_206_13 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_206_14 = 0

			if var_206_14 < arg_203_1.time_ and arg_203_1.time_ <= var_206_14 + arg_206_0 then
				arg_203_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_15 = arg_203_1.actors_["1097ui_story"].transform
			local var_206_16 = 0

			if var_206_16 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 then
				arg_203_1.var_.moveOldPos1097ui_story = var_206_15.localPosition
			end

			local var_206_17 = 0.001

			if var_206_16 <= arg_203_1.time_ and arg_203_1.time_ < var_206_16 + var_206_17 then
				local var_206_18 = (arg_203_1.time_ - var_206_16) / var_206_17
				local var_206_19 = Vector3.New(0, 100, 0)

				var_206_15.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1097ui_story, var_206_19, var_206_18)

				local var_206_20 = manager.ui.mainCamera.transform.position - var_206_15.position

				var_206_15.forward = Vector3.New(var_206_20.x, var_206_20.y, var_206_20.z)

				local var_206_21 = var_206_15.localEulerAngles

				var_206_21.z = 0
				var_206_21.x = 0
				var_206_15.localEulerAngles = var_206_21
			end

			if arg_203_1.time_ >= var_206_16 + var_206_17 and arg_203_1.time_ < var_206_16 + var_206_17 + arg_206_0 then
				var_206_15.localPosition = Vector3.New(0, 100, 0)

				local var_206_22 = manager.ui.mainCamera.transform.position - var_206_15.position

				var_206_15.forward = Vector3.New(var_206_22.x, var_206_22.y, var_206_22.z)

				local var_206_23 = var_206_15.localEulerAngles

				var_206_23.z = 0
				var_206_23.x = 0
				var_206_15.localEulerAngles = var_206_23
			end

			local var_206_24 = arg_203_1.actors_["1097ui_story"]
			local var_206_25 = 0

			if var_206_25 < arg_203_1.time_ and arg_203_1.time_ <= var_206_25 + arg_206_0 and not isNil(var_206_24) and arg_203_1.var_.characterEffect1097ui_story == nil then
				arg_203_1.var_.characterEffect1097ui_story = var_206_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_26 = 0.200000002980232

			if var_206_25 <= arg_203_1.time_ and arg_203_1.time_ < var_206_25 + var_206_26 and not isNil(var_206_24) then
				local var_206_27 = (arg_203_1.time_ - var_206_25) / var_206_26

				if arg_203_1.var_.characterEffect1097ui_story and not isNil(var_206_24) then
					local var_206_28 = Mathf.Lerp(0, 0.5, var_206_27)

					arg_203_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1097ui_story.fillRatio = var_206_28
				end
			end

			if arg_203_1.time_ >= var_206_25 + var_206_26 and arg_203_1.time_ < var_206_25 + var_206_26 + arg_206_0 and not isNil(var_206_24) and arg_203_1.var_.characterEffect1097ui_story then
				local var_206_29 = 0.5

				arg_203_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1097ui_story.fillRatio = var_206_29
			end

			local var_206_30 = 0
			local var_206_31 = 0.375

			if var_206_30 < arg_203_1.time_ and arg_203_1.time_ <= var_206_30 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_32 = arg_203_1:FormatText(StoryNameCfg[919].name)

				arg_203_1.leftNameTxt_.text = var_206_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_33 = arg_203_1:GetWordFromCfg(412031049)
				local var_206_34 = arg_203_1:FormatText(var_206_33.content)

				arg_203_1.text_.text = var_206_34

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_35 = 15
				local var_206_36 = utf8.len(var_206_34)
				local var_206_37 = var_206_35 <= 0 and var_206_31 or var_206_31 * (var_206_36 / var_206_35)

				if var_206_37 > 0 and var_206_31 < var_206_37 then
					arg_203_1.talkMaxDuration = var_206_37

					if var_206_37 + var_206_30 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_37 + var_206_30
					end
				end

				arg_203_1.text_.text = var_206_34
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031049", "story_v_out_412031.awb") ~= 0 then
					local var_206_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031049", "story_v_out_412031.awb") / 1000

					if var_206_38 + var_206_30 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_38 + var_206_30
					end

					if var_206_33.prefab_name ~= "" and arg_203_1.actors_[var_206_33.prefab_name] ~= nil then
						local var_206_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_33.prefab_name].transform, "story_v_out_412031", "412031049", "story_v_out_412031.awb")

						arg_203_1:RecordAudio("412031049", var_206_39)
						arg_203_1:RecordAudio("412031049", var_206_39)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_412031", "412031049", "story_v_out_412031.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_412031", "412031049", "story_v_out_412031.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_40 = math.max(var_206_31, arg_203_1.talkMaxDuration)

			if var_206_30 <= arg_203_1.time_ and arg_203_1.time_ < var_206_30 + var_206_40 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_30) / var_206_40

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_30 + var_206_40 and arg_203_1.time_ < var_206_30 + var_206_40 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play412031050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 412031050
		arg_207_1.duration_ = 13.17

		local var_207_0 = {
			zh = 13.166,
			ja = 11.933
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
				arg_207_0:Play412031051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10083ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos10083ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(-1, -2.6, -2.8)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10083ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(-1, -2.6, -2.8)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["10083ui_story"]
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect10083ui_story == nil then
				arg_207_1.var_.characterEffect10083ui_story = var_210_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_11 = 0.200000002980232

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 and not isNil(var_210_9) then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11

				if arg_207_1.var_.characterEffect10083ui_story and not isNil(var_210_9) then
					arg_207_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect10083ui_story then
				arg_207_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_210_13 = 0

			if var_210_13 < arg_207_1.time_ and arg_207_1.time_ <= var_210_13 + arg_210_0 then
				arg_207_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			local var_210_14 = 0

			if var_210_14 < arg_207_1.time_ and arg_207_1.time_ <= var_210_14 + arg_210_0 then
				arg_207_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_210_15 = arg_207_1.actors_["10078ui_story"].transform
			local var_210_16 = 0

			if var_210_16 < arg_207_1.time_ and arg_207_1.time_ <= var_210_16 + arg_210_0 then
				arg_207_1.var_.moveOldPos10078ui_story = var_210_15.localPosition
			end

			local var_210_17 = 0.001

			if var_210_16 <= arg_207_1.time_ and arg_207_1.time_ < var_210_16 + var_210_17 then
				local var_210_18 = (arg_207_1.time_ - var_210_16) / var_210_17
				local var_210_19 = Vector3.New(0, 100, 0)

				var_210_15.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10078ui_story, var_210_19, var_210_18)

				local var_210_20 = manager.ui.mainCamera.transform.position - var_210_15.position

				var_210_15.forward = Vector3.New(var_210_20.x, var_210_20.y, var_210_20.z)

				local var_210_21 = var_210_15.localEulerAngles

				var_210_21.z = 0
				var_210_21.x = 0
				var_210_15.localEulerAngles = var_210_21
			end

			if arg_207_1.time_ >= var_210_16 + var_210_17 and arg_207_1.time_ < var_210_16 + var_210_17 + arg_210_0 then
				var_210_15.localPosition = Vector3.New(0, 100, 0)

				local var_210_22 = manager.ui.mainCamera.transform.position - var_210_15.position

				var_210_15.forward = Vector3.New(var_210_22.x, var_210_22.y, var_210_22.z)

				local var_210_23 = var_210_15.localEulerAngles

				var_210_23.z = 0
				var_210_23.x = 0
				var_210_15.localEulerAngles = var_210_23
			end

			local var_210_24 = arg_207_1.actors_["10078ui_story"]
			local var_210_25 = 0

			if var_210_25 < arg_207_1.time_ and arg_207_1.time_ <= var_210_25 + arg_210_0 and not isNil(var_210_24) and arg_207_1.var_.characterEffect10078ui_story == nil then
				arg_207_1.var_.characterEffect10078ui_story = var_210_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_26 = 0.200000002980232

			if var_210_25 <= arg_207_1.time_ and arg_207_1.time_ < var_210_25 + var_210_26 and not isNil(var_210_24) then
				local var_210_27 = (arg_207_1.time_ - var_210_25) / var_210_26

				if arg_207_1.var_.characterEffect10078ui_story and not isNil(var_210_24) then
					local var_210_28 = Mathf.Lerp(0, 0.5, var_210_27)

					arg_207_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10078ui_story.fillRatio = var_210_28
				end
			end

			if arg_207_1.time_ >= var_210_25 + var_210_26 and arg_207_1.time_ < var_210_25 + var_210_26 + arg_210_0 and not isNil(var_210_24) and arg_207_1.var_.characterEffect10078ui_story then
				local var_210_29 = 0.5

				arg_207_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10078ui_story.fillRatio = var_210_29
			end

			local var_210_30 = 0
			local var_210_31 = 1.475

			if var_210_30 < arg_207_1.time_ and arg_207_1.time_ <= var_210_30 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_32 = arg_207_1:FormatText(StoryNameCfg[918].name)

				arg_207_1.leftNameTxt_.text = var_210_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_33 = arg_207_1:GetWordFromCfg(412031050)
				local var_210_34 = arg_207_1:FormatText(var_210_33.content)

				arg_207_1.text_.text = var_210_34

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_35 = 58
				local var_210_36 = utf8.len(var_210_34)
				local var_210_37 = var_210_35 <= 0 and var_210_31 or var_210_31 * (var_210_36 / var_210_35)

				if var_210_37 > 0 and var_210_31 < var_210_37 then
					arg_207_1.talkMaxDuration = var_210_37

					if var_210_37 + var_210_30 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_37 + var_210_30
					end
				end

				arg_207_1.text_.text = var_210_34
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031050", "story_v_out_412031.awb") ~= 0 then
					local var_210_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031050", "story_v_out_412031.awb") / 1000

					if var_210_38 + var_210_30 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_38 + var_210_30
					end

					if var_210_33.prefab_name ~= "" and arg_207_1.actors_[var_210_33.prefab_name] ~= nil then
						local var_210_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_33.prefab_name].transform, "story_v_out_412031", "412031050", "story_v_out_412031.awb")

						arg_207_1:RecordAudio("412031050", var_210_39)
						arg_207_1:RecordAudio("412031050", var_210_39)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_412031", "412031050", "story_v_out_412031.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_412031", "412031050", "story_v_out_412031.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_40 = math.max(var_210_31, arg_207_1.talkMaxDuration)

			if var_210_30 <= arg_207_1.time_ and arg_207_1.time_ < var_210_30 + var_210_40 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_30) / var_210_40

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_30 + var_210_40 and arg_207_1.time_ < var_210_30 + var_210_40 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play412031051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 412031051
		arg_211_1.duration_ = 9.03

		local var_211_0 = {
			zh = 9.033,
			ja = 5.466
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play412031052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1097ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1097ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0.7, -0.54, -6.3)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1097ui_story, var_214_4, var_214_3)

				local var_214_5 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_5.x, var_214_5.y, var_214_5.z)

				local var_214_6 = var_214_0.localEulerAngles

				var_214_6.z = 0
				var_214_6.x = 0
				var_214_0.localEulerAngles = var_214_6
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0.7, -0.54, -6.3)

				local var_214_7 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_7.x, var_214_7.y, var_214_7.z)

				local var_214_8 = var_214_0.localEulerAngles

				var_214_8.z = 0
				var_214_8.x = 0
				var_214_0.localEulerAngles = var_214_8
			end

			local var_214_9 = arg_211_1.actors_["1097ui_story"]
			local var_214_10 = 0

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect1097ui_story == nil then
				arg_211_1.var_.characterEffect1097ui_story = var_214_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_11 = 0.200000002980232

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_11 and not isNil(var_214_9) then
				local var_214_12 = (arg_211_1.time_ - var_214_10) / var_214_11

				if arg_211_1.var_.characterEffect1097ui_story and not isNil(var_214_9) then
					arg_211_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_10 + var_214_11 and arg_211_1.time_ < var_214_10 + var_214_11 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect1097ui_story then
				arg_211_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_214_13 = 0

			if var_214_13 < arg_211_1.time_ and arg_211_1.time_ <= var_214_13 + arg_214_0 then
				arg_211_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_214_14 = 0

			if var_214_14 < arg_211_1.time_ and arg_211_1.time_ <= var_214_14 + arg_214_0 then
				arg_211_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_214_15 = arg_211_1.actors_["10083ui_story"]
			local var_214_16 = 0

			if var_214_16 < arg_211_1.time_ and arg_211_1.time_ <= var_214_16 + arg_214_0 and not isNil(var_214_15) and arg_211_1.var_.characterEffect10083ui_story == nil then
				arg_211_1.var_.characterEffect10083ui_story = var_214_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_17 = 0.200000002980232

			if var_214_16 <= arg_211_1.time_ and arg_211_1.time_ < var_214_16 + var_214_17 and not isNil(var_214_15) then
				local var_214_18 = (arg_211_1.time_ - var_214_16) / var_214_17

				if arg_211_1.var_.characterEffect10083ui_story and not isNil(var_214_15) then
					local var_214_19 = Mathf.Lerp(0, 0.5, var_214_18)

					arg_211_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_211_1.var_.characterEffect10083ui_story.fillRatio = var_214_19
				end
			end

			if arg_211_1.time_ >= var_214_16 + var_214_17 and arg_211_1.time_ < var_214_16 + var_214_17 + arg_214_0 and not isNil(var_214_15) and arg_211_1.var_.characterEffect10083ui_story then
				local var_214_20 = 0.5

				arg_211_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_211_1.var_.characterEffect10083ui_story.fillRatio = var_214_20
			end

			local var_214_21 = 0
			local var_214_22 = 0.65

			if var_214_21 < arg_211_1.time_ and arg_211_1.time_ <= var_214_21 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_23 = arg_211_1:FormatText(StoryNameCfg[216].name)

				arg_211_1.leftNameTxt_.text = var_214_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_24 = arg_211_1:GetWordFromCfg(412031051)
				local var_214_25 = arg_211_1:FormatText(var_214_24.content)

				arg_211_1.text_.text = var_214_25

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_26 = 26
				local var_214_27 = utf8.len(var_214_25)
				local var_214_28 = var_214_26 <= 0 and var_214_22 or var_214_22 * (var_214_27 / var_214_26)

				if var_214_28 > 0 and var_214_22 < var_214_28 then
					arg_211_1.talkMaxDuration = var_214_28

					if var_214_28 + var_214_21 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_28 + var_214_21
					end
				end

				arg_211_1.text_.text = var_214_25
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031051", "story_v_out_412031.awb") ~= 0 then
					local var_214_29 = manager.audio:GetVoiceLength("story_v_out_412031", "412031051", "story_v_out_412031.awb") / 1000

					if var_214_29 + var_214_21 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_29 + var_214_21
					end

					if var_214_24.prefab_name ~= "" and arg_211_1.actors_[var_214_24.prefab_name] ~= nil then
						local var_214_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_24.prefab_name].transform, "story_v_out_412031", "412031051", "story_v_out_412031.awb")

						arg_211_1:RecordAudio("412031051", var_214_30)
						arg_211_1:RecordAudio("412031051", var_214_30)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_412031", "412031051", "story_v_out_412031.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_412031", "412031051", "story_v_out_412031.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_31 = math.max(var_214_22, arg_211_1.talkMaxDuration)

			if var_214_21 <= arg_211_1.time_ and arg_211_1.time_ < var_214_21 + var_214_31 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_21) / var_214_31

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_21 + var_214_31 and arg_211_1.time_ < var_214_21 + var_214_31 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play412031052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 412031052
		arg_215_1.duration_ = 5.2

		local var_215_0 = {
			zh = 5.2,
			ja = 4.666
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
				arg_215_0:Play412031053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10083ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos10083ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(-1, -2.6, -2.8)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10083ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(-1, -2.6, -2.8)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["10083ui_story"]
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect10083ui_story == nil then
				arg_215_1.var_.characterEffect10083ui_story = var_218_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_11 = 0.200000002980232

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 and not isNil(var_218_9) then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11

				if arg_215_1.var_.characterEffect10083ui_story and not isNil(var_218_9) then
					arg_215_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect10083ui_story then
				arg_215_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_218_13 = 0

			if var_218_13 < arg_215_1.time_ and arg_215_1.time_ <= var_218_13 + arg_218_0 then
				arg_215_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_1")
			end

			local var_218_14 = 0

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_218_15 = arg_215_1.actors_["1097ui_story"]
			local var_218_16 = 0

			if var_218_16 < arg_215_1.time_ and arg_215_1.time_ <= var_218_16 + arg_218_0 and not isNil(var_218_15) and arg_215_1.var_.characterEffect1097ui_story == nil then
				arg_215_1.var_.characterEffect1097ui_story = var_218_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_17 = 0.200000002980232

			if var_218_16 <= arg_215_1.time_ and arg_215_1.time_ < var_218_16 + var_218_17 and not isNil(var_218_15) then
				local var_218_18 = (arg_215_1.time_ - var_218_16) / var_218_17

				if arg_215_1.var_.characterEffect1097ui_story and not isNil(var_218_15) then
					local var_218_19 = Mathf.Lerp(0, 0.5, var_218_18)

					arg_215_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1097ui_story.fillRatio = var_218_19
				end
			end

			if arg_215_1.time_ >= var_218_16 + var_218_17 and arg_215_1.time_ < var_218_16 + var_218_17 + arg_218_0 and not isNil(var_218_15) and arg_215_1.var_.characterEffect1097ui_story then
				local var_218_20 = 0.5

				arg_215_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1097ui_story.fillRatio = var_218_20
			end

			local var_218_21 = 0
			local var_218_22 = 0.625

			if var_218_21 < arg_215_1.time_ and arg_215_1.time_ <= var_218_21 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_23 = arg_215_1:FormatText(StoryNameCfg[918].name)

				arg_215_1.leftNameTxt_.text = var_218_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_24 = arg_215_1:GetWordFromCfg(412031052)
				local var_218_25 = arg_215_1:FormatText(var_218_24.content)

				arg_215_1.text_.text = var_218_25

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_26 = 25
				local var_218_27 = utf8.len(var_218_25)
				local var_218_28 = var_218_26 <= 0 and var_218_22 or var_218_22 * (var_218_27 / var_218_26)

				if var_218_28 > 0 and var_218_22 < var_218_28 then
					arg_215_1.talkMaxDuration = var_218_28

					if var_218_28 + var_218_21 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_28 + var_218_21
					end
				end

				arg_215_1.text_.text = var_218_25
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031052", "story_v_out_412031.awb") ~= 0 then
					local var_218_29 = manager.audio:GetVoiceLength("story_v_out_412031", "412031052", "story_v_out_412031.awb") / 1000

					if var_218_29 + var_218_21 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_29 + var_218_21
					end

					if var_218_24.prefab_name ~= "" and arg_215_1.actors_[var_218_24.prefab_name] ~= nil then
						local var_218_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_24.prefab_name].transform, "story_v_out_412031", "412031052", "story_v_out_412031.awb")

						arg_215_1:RecordAudio("412031052", var_218_30)
						arg_215_1:RecordAudio("412031052", var_218_30)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_412031", "412031052", "story_v_out_412031.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_412031", "412031052", "story_v_out_412031.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_31 = math.max(var_218_22, arg_215_1.talkMaxDuration)

			if var_218_21 <= arg_215_1.time_ and arg_215_1.time_ < var_218_21 + var_218_31 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_21) / var_218_31

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_21 + var_218_31 and arg_215_1.time_ < var_218_21 + var_218_31 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play412031053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 412031053
		arg_219_1.duration_ = 10.97

		local var_219_0 = {
			zh = 5.233,
			ja = 10.966
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
				arg_219_0:Play412031054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1097ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1097ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(0.7, -0.54, -6.3)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1097ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0.7, -0.54, -6.3)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = arg_219_1.actors_["1097ui_story"]
			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect1097ui_story == nil then
				arg_219_1.var_.characterEffect1097ui_story = var_222_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_11 = 0.200000002980232

			if var_222_10 <= arg_219_1.time_ and arg_219_1.time_ < var_222_10 + var_222_11 and not isNil(var_222_9) then
				local var_222_12 = (arg_219_1.time_ - var_222_10) / var_222_11

				if arg_219_1.var_.characterEffect1097ui_story and not isNil(var_222_9) then
					arg_219_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_10 + var_222_11 and arg_219_1.time_ < var_222_10 + var_222_11 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect1097ui_story then
				arg_219_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_222_13 = 0

			if var_222_13 < arg_219_1.time_ and arg_219_1.time_ <= var_222_13 + arg_222_0 then
				arg_219_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_222_14 = 0

			if var_222_14 < arg_219_1.time_ and arg_219_1.time_ <= var_222_14 + arg_222_0 then
				arg_219_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_222_15 = arg_219_1.actors_["10083ui_story"]
			local var_222_16 = 0

			if var_222_16 < arg_219_1.time_ and arg_219_1.time_ <= var_222_16 + arg_222_0 and not isNil(var_222_15) and arg_219_1.var_.characterEffect10083ui_story == nil then
				arg_219_1.var_.characterEffect10083ui_story = var_222_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_17 = 0.200000002980232

			if var_222_16 <= arg_219_1.time_ and arg_219_1.time_ < var_222_16 + var_222_17 and not isNil(var_222_15) then
				local var_222_18 = (arg_219_1.time_ - var_222_16) / var_222_17

				if arg_219_1.var_.characterEffect10083ui_story and not isNil(var_222_15) then
					local var_222_19 = Mathf.Lerp(0, 0.5, var_222_18)

					arg_219_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_219_1.var_.characterEffect10083ui_story.fillRatio = var_222_19
				end
			end

			if arg_219_1.time_ >= var_222_16 + var_222_17 and arg_219_1.time_ < var_222_16 + var_222_17 + arg_222_0 and not isNil(var_222_15) and arg_219_1.var_.characterEffect10083ui_story then
				local var_222_20 = 0.5

				arg_219_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_219_1.var_.characterEffect10083ui_story.fillRatio = var_222_20
			end

			local var_222_21 = 0
			local var_222_22 = 0.4

			if var_222_21 < arg_219_1.time_ and arg_219_1.time_ <= var_222_21 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_23 = arg_219_1:FormatText(StoryNameCfg[216].name)

				arg_219_1.leftNameTxt_.text = var_222_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_24 = arg_219_1:GetWordFromCfg(412031053)
				local var_222_25 = arg_219_1:FormatText(var_222_24.content)

				arg_219_1.text_.text = var_222_25

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_26 = 16
				local var_222_27 = utf8.len(var_222_25)
				local var_222_28 = var_222_26 <= 0 and var_222_22 or var_222_22 * (var_222_27 / var_222_26)

				if var_222_28 > 0 and var_222_22 < var_222_28 then
					arg_219_1.talkMaxDuration = var_222_28

					if var_222_28 + var_222_21 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_28 + var_222_21
					end
				end

				arg_219_1.text_.text = var_222_25
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031053", "story_v_out_412031.awb") ~= 0 then
					local var_222_29 = manager.audio:GetVoiceLength("story_v_out_412031", "412031053", "story_v_out_412031.awb") / 1000

					if var_222_29 + var_222_21 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_29 + var_222_21
					end

					if var_222_24.prefab_name ~= "" and arg_219_1.actors_[var_222_24.prefab_name] ~= nil then
						local var_222_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_24.prefab_name].transform, "story_v_out_412031", "412031053", "story_v_out_412031.awb")

						arg_219_1:RecordAudio("412031053", var_222_30)
						arg_219_1:RecordAudio("412031053", var_222_30)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_412031", "412031053", "story_v_out_412031.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_412031", "412031053", "story_v_out_412031.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_31 = math.max(var_222_22, arg_219_1.talkMaxDuration)

			if var_222_21 <= arg_219_1.time_ and arg_219_1.time_ < var_222_21 + var_222_31 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_21) / var_222_31

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_21 + var_222_31 and arg_219_1.time_ < var_222_21 + var_222_31 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play412031054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 412031054
		arg_223_1.duration_ = 10.17

		local var_223_0 = {
			zh = 10.165999999999,
			ja = 9.265999999999
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
				arg_223_0:Play412031055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = "STblack"

			if arg_223_1.bgs_[var_226_0] == nil then
				local var_226_1 = Object.Instantiate(arg_223_1.paintGo_)

				var_226_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_226_0)
				var_226_1.name = var_226_0
				var_226_1.transform.parent = arg_223_1.stage_.transform
				var_226_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_223_1.bgs_[var_226_0] = var_226_1
			end

			local var_226_2 = 2

			if var_226_2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				local var_226_3 = manager.ui.mainCamera.transform.localPosition
				local var_226_4 = Vector3.New(0, 0, 10) + Vector3.New(var_226_3.x, var_226_3.y, 0)
				local var_226_5 = arg_223_1.bgs_.STblack

				var_226_5.transform.localPosition = var_226_4
				var_226_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_226_6 = var_226_5:GetComponent("SpriteRenderer")

				if var_226_6 and var_226_6.sprite then
					local var_226_7 = (var_226_5.transform.localPosition - var_226_3).z
					local var_226_8 = manager.ui.mainCameraCom_
					local var_226_9 = 2 * var_226_7 * Mathf.Tan(var_226_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_226_10 = var_226_9 * var_226_8.aspect
					local var_226_11 = var_226_6.sprite.bounds.size.x
					local var_226_12 = var_226_6.sprite.bounds.size.y
					local var_226_13 = var_226_10 / var_226_11
					local var_226_14 = var_226_9 / var_226_12
					local var_226_15 = var_226_14 < var_226_13 and var_226_13 or var_226_14

					var_226_5.transform.localScale = Vector3.New(var_226_15, var_226_15, 0)
				end

				for iter_226_0, iter_226_1 in pairs(arg_223_1.bgs_) do
					if iter_226_0 ~= "STblack" then
						iter_226_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_226_16 = 3.999999999999

			if var_226_16 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			local var_226_17 = 0.3

			if arg_223_1.time_ >= var_226_16 + var_226_17 and arg_223_1.time_ < var_226_16 + var_226_17 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end

			local var_226_18 = 0

			if var_226_18 < arg_223_1.time_ and arg_223_1.time_ <= var_226_18 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_19 = 2

			if var_226_18 <= arg_223_1.time_ and arg_223_1.time_ < var_226_18 + var_226_19 then
				local var_226_20 = (arg_223_1.time_ - var_226_18) / var_226_19
				local var_226_21 = Color.New(0, 0, 0)

				var_226_21.a = Mathf.Lerp(0, 1, var_226_20)
				arg_223_1.mask_.color = var_226_21
			end

			if arg_223_1.time_ >= var_226_18 + var_226_19 and arg_223_1.time_ < var_226_18 + var_226_19 + arg_226_0 then
				local var_226_22 = Color.New(0, 0, 0)

				var_226_22.a = 1
				arg_223_1.mask_.color = var_226_22
			end

			local var_226_23 = 2

			if var_226_23 < arg_223_1.time_ and arg_223_1.time_ <= var_226_23 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_24 = 2

			if var_226_23 <= arg_223_1.time_ and arg_223_1.time_ < var_226_23 + var_226_24 then
				local var_226_25 = (arg_223_1.time_ - var_226_23) / var_226_24
				local var_226_26 = Color.New(0, 0, 0)

				var_226_26.a = Mathf.Lerp(1, 0, var_226_25)
				arg_223_1.mask_.color = var_226_26
			end

			if arg_223_1.time_ >= var_226_23 + var_226_24 and arg_223_1.time_ < var_226_23 + var_226_24 + arg_226_0 then
				local var_226_27 = Color.New(0, 0, 0)
				local var_226_28 = 0

				arg_223_1.mask_.enabled = false
				var_226_27.a = var_226_28
				arg_223_1.mask_.color = var_226_27
			end

			local var_226_29 = arg_223_1.actors_["1097ui_story"].transform
			local var_226_30 = 1.966

			if var_226_30 < arg_223_1.time_ and arg_223_1.time_ <= var_226_30 + arg_226_0 then
				arg_223_1.var_.moveOldPos1097ui_story = var_226_29.localPosition
			end

			local var_226_31 = 0.001

			if var_226_30 <= arg_223_1.time_ and arg_223_1.time_ < var_226_30 + var_226_31 then
				local var_226_32 = (arg_223_1.time_ - var_226_30) / var_226_31
				local var_226_33 = Vector3.New(0, 100, 0)

				var_226_29.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1097ui_story, var_226_33, var_226_32)

				local var_226_34 = manager.ui.mainCamera.transform.position - var_226_29.position

				var_226_29.forward = Vector3.New(var_226_34.x, var_226_34.y, var_226_34.z)

				local var_226_35 = var_226_29.localEulerAngles

				var_226_35.z = 0
				var_226_35.x = 0
				var_226_29.localEulerAngles = var_226_35
			end

			if arg_223_1.time_ >= var_226_30 + var_226_31 and arg_223_1.time_ < var_226_30 + var_226_31 + arg_226_0 then
				var_226_29.localPosition = Vector3.New(0, 100, 0)

				local var_226_36 = manager.ui.mainCamera.transform.position - var_226_29.position

				var_226_29.forward = Vector3.New(var_226_36.x, var_226_36.y, var_226_36.z)

				local var_226_37 = var_226_29.localEulerAngles

				var_226_37.z = 0
				var_226_37.x = 0
				var_226_29.localEulerAngles = var_226_37
			end

			local var_226_38 = arg_223_1.actors_["10083ui_story"].transform
			local var_226_39 = 1.966

			if var_226_39 < arg_223_1.time_ and arg_223_1.time_ <= var_226_39 + arg_226_0 then
				arg_223_1.var_.moveOldPos10083ui_story = var_226_38.localPosition
			end

			local var_226_40 = 0.001

			if var_226_39 <= arg_223_1.time_ and arg_223_1.time_ < var_226_39 + var_226_40 then
				local var_226_41 = (arg_223_1.time_ - var_226_39) / var_226_40
				local var_226_42 = Vector3.New(0, 100, 0)

				var_226_38.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10083ui_story, var_226_42, var_226_41)

				local var_226_43 = manager.ui.mainCamera.transform.position - var_226_38.position

				var_226_38.forward = Vector3.New(var_226_43.x, var_226_43.y, var_226_43.z)

				local var_226_44 = var_226_38.localEulerAngles

				var_226_44.z = 0
				var_226_44.x = 0
				var_226_38.localEulerAngles = var_226_44
			end

			if arg_223_1.time_ >= var_226_39 + var_226_40 and arg_223_1.time_ < var_226_39 + var_226_40 + arg_226_0 then
				var_226_38.localPosition = Vector3.New(0, 100, 0)

				local var_226_45 = manager.ui.mainCamera.transform.position - var_226_38.position

				var_226_38.forward = Vector3.New(var_226_45.x, var_226_45.y, var_226_45.z)

				local var_226_46 = var_226_38.localEulerAngles

				var_226_46.z = 0
				var_226_46.x = 0
				var_226_38.localEulerAngles = var_226_46
			end

			if arg_223_1.frameCnt_ <= 1 then
				arg_223_1.dialog_:SetActive(false)
			end

			local var_226_47 = 3.999999999999
			local var_226_48 = 0.55

			if var_226_47 < arg_223_1.time_ and arg_223_1.time_ <= var_226_47 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				arg_223_1.dialog_:SetActive(true)

				arg_223_1.dialogCg_.alpha = 0

				local var_226_49 = LeanTween.value(arg_223_1.dialog_, 0, 1, 0.3)

				var_226_49:setOnUpdate(LuaHelper.FloatAction(function(arg_227_0)
					arg_223_1.dialogCg_.alpha = arg_227_0
				end))
				var_226_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_223_1.dialog_)
					var_226_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_223_1.duration_ = arg_223_1.duration_ + 0.3

				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_50 = arg_223_1:FormatText(StoryNameCfg[216].name)

				arg_223_1.leftNameTxt_.text = var_226_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_51 = arg_223_1:GetWordFromCfg(412031054)
				local var_226_52 = arg_223_1:FormatText(var_226_51.content)

				arg_223_1.text_.text = var_226_52

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_53 = 22
				local var_226_54 = utf8.len(var_226_52)
				local var_226_55 = var_226_53 <= 0 and var_226_48 or var_226_48 * (var_226_54 / var_226_53)

				if var_226_55 > 0 and var_226_48 < var_226_55 then
					arg_223_1.talkMaxDuration = var_226_55
					var_226_47 = var_226_47 + 0.3

					if var_226_55 + var_226_47 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_55 + var_226_47
					end
				end

				arg_223_1.text_.text = var_226_52
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031054", "story_v_out_412031.awb") ~= 0 then
					local var_226_56 = manager.audio:GetVoiceLength("story_v_out_412031", "412031054", "story_v_out_412031.awb") / 1000

					if var_226_56 + var_226_47 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_56 + var_226_47
					end

					if var_226_51.prefab_name ~= "" and arg_223_1.actors_[var_226_51.prefab_name] ~= nil then
						local var_226_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_51.prefab_name].transform, "story_v_out_412031", "412031054", "story_v_out_412031.awb")

						arg_223_1:RecordAudio("412031054", var_226_57)
						arg_223_1:RecordAudio("412031054", var_226_57)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_412031", "412031054", "story_v_out_412031.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_412031", "412031054", "story_v_out_412031.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_58 = var_226_47 + 0.3
			local var_226_59 = math.max(var_226_48, arg_223_1.talkMaxDuration)

			if var_226_58 <= arg_223_1.time_ and arg_223_1.time_ < var_226_58 + var_226_59 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_58) / var_226_59

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_58 + var_226_59 and arg_223_1.time_ < var_226_58 + var_226_59 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play412031055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 412031055
		arg_229_1.duration_ = 6.9

		local var_229_0 = {
			zh = 6.765999999999,
			ja = 6.899999999999
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
				arg_229_0:Play412031056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 1.999999999999

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				local var_232_1 = manager.ui.mainCamera.transform.localPosition
				local var_232_2 = Vector3.New(0, 0, 10) + Vector3.New(var_232_1.x, var_232_1.y, 0)
				local var_232_3 = arg_229_1.bgs_.ST30

				var_232_3.transform.localPosition = var_232_2
				var_232_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_232_4 = var_232_3:GetComponent("SpriteRenderer")

				if var_232_4 and var_232_4.sprite then
					local var_232_5 = (var_232_3.transform.localPosition - var_232_1).z
					local var_232_6 = manager.ui.mainCameraCom_
					local var_232_7 = 2 * var_232_5 * Mathf.Tan(var_232_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_232_8 = var_232_7 * var_232_6.aspect
					local var_232_9 = var_232_4.sprite.bounds.size.x
					local var_232_10 = var_232_4.sprite.bounds.size.y
					local var_232_11 = var_232_8 / var_232_9
					local var_232_12 = var_232_7 / var_232_10
					local var_232_13 = var_232_12 < var_232_11 and var_232_11 or var_232_12

					var_232_3.transform.localScale = Vector3.New(var_232_13, var_232_13, 0)
				end

				for iter_232_0, iter_232_1 in pairs(arg_229_1.bgs_) do
					if iter_232_0 ~= "ST30" then
						iter_232_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_232_14 = 3.999999999999

			if var_232_14 < arg_229_1.time_ and arg_229_1.time_ <= var_232_14 + arg_232_0 then
				arg_229_1.allBtn_.enabled = false
			end

			local var_232_15 = 0.299999997018768

			if arg_229_1.time_ >= var_232_14 + var_232_15 and arg_229_1.time_ < var_232_14 + var_232_15 + arg_232_0 then
				arg_229_1.allBtn_.enabled = true
			end

			local var_232_16 = 0

			if var_232_16 < arg_229_1.time_ and arg_229_1.time_ <= var_232_16 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_17 = 2

			if var_232_16 <= arg_229_1.time_ and arg_229_1.time_ < var_232_16 + var_232_17 then
				local var_232_18 = (arg_229_1.time_ - var_232_16) / var_232_17
				local var_232_19 = Color.New(0, 0, 0)

				var_232_19.a = Mathf.Lerp(0, 1, var_232_18)
				arg_229_1.mask_.color = var_232_19
			end

			if arg_229_1.time_ >= var_232_16 + var_232_17 and arg_229_1.time_ < var_232_16 + var_232_17 + arg_232_0 then
				local var_232_20 = Color.New(0, 0, 0)

				var_232_20.a = 1
				arg_229_1.mask_.color = var_232_20
			end

			local var_232_21 = 1.999999999999

			if var_232_21 < arg_229_1.time_ and arg_229_1.time_ <= var_232_21 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_22 = 2

			if var_232_21 <= arg_229_1.time_ and arg_229_1.time_ < var_232_21 + var_232_22 then
				local var_232_23 = (arg_229_1.time_ - var_232_21) / var_232_22
				local var_232_24 = Color.New(0, 0, 0)

				var_232_24.a = Mathf.Lerp(1, 0, var_232_23)
				arg_229_1.mask_.color = var_232_24
			end

			if arg_229_1.time_ >= var_232_21 + var_232_22 and arg_229_1.time_ < var_232_21 + var_232_22 + arg_232_0 then
				local var_232_25 = Color.New(0, 0, 0)
				local var_232_26 = 0

				arg_229_1.mask_.enabled = false
				var_232_25.a = var_232_26
				arg_229_1.mask_.color = var_232_25
			end

			local var_232_27 = arg_229_1.actors_["10078ui_story"].transform
			local var_232_28 = 3.8

			if var_232_28 < arg_229_1.time_ and arg_229_1.time_ <= var_232_28 + arg_232_0 then
				arg_229_1.var_.moveOldPos10078ui_story = var_232_27.localPosition
			end

			local var_232_29 = 0.001

			if var_232_28 <= arg_229_1.time_ and arg_229_1.time_ < var_232_28 + var_232_29 then
				local var_232_30 = (arg_229_1.time_ - var_232_28) / var_232_29
				local var_232_31 = Vector3.New(0, -0.5, -6.3)

				var_232_27.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10078ui_story, var_232_31, var_232_30)

				local var_232_32 = manager.ui.mainCamera.transform.position - var_232_27.position

				var_232_27.forward = Vector3.New(var_232_32.x, var_232_32.y, var_232_32.z)

				local var_232_33 = var_232_27.localEulerAngles

				var_232_33.z = 0
				var_232_33.x = 0
				var_232_27.localEulerAngles = var_232_33
			end

			if arg_229_1.time_ >= var_232_28 + var_232_29 and arg_229_1.time_ < var_232_28 + var_232_29 + arg_232_0 then
				var_232_27.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_232_34 = manager.ui.mainCamera.transform.position - var_232_27.position

				var_232_27.forward = Vector3.New(var_232_34.x, var_232_34.y, var_232_34.z)

				local var_232_35 = var_232_27.localEulerAngles

				var_232_35.z = 0
				var_232_35.x = 0
				var_232_27.localEulerAngles = var_232_35
			end

			local var_232_36 = arg_229_1.actors_["10078ui_story"]
			local var_232_37 = 3.8

			if var_232_37 < arg_229_1.time_ and arg_229_1.time_ <= var_232_37 + arg_232_0 and not isNil(var_232_36) and arg_229_1.var_.characterEffect10078ui_story == nil then
				arg_229_1.var_.characterEffect10078ui_story = var_232_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_38 = 0.200000002980232

			if var_232_37 <= arg_229_1.time_ and arg_229_1.time_ < var_232_37 + var_232_38 and not isNil(var_232_36) then
				local var_232_39 = (arg_229_1.time_ - var_232_37) / var_232_38

				if arg_229_1.var_.characterEffect10078ui_story and not isNil(var_232_36) then
					arg_229_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_37 + var_232_38 and arg_229_1.time_ < var_232_37 + var_232_38 + arg_232_0 and not isNil(var_232_36) and arg_229_1.var_.characterEffect10078ui_story then
				arg_229_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_232_40 = 3.8

			if var_232_40 < arg_229_1.time_ and arg_229_1.time_ <= var_232_40 + arg_232_0 then
				arg_229_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_232_41 = 3.8

			if var_232_41 < arg_229_1.time_ and arg_229_1.time_ <= var_232_41 + arg_232_0 then
				arg_229_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_232_42 = arg_229_1.actors_["1097ui_story"].transform
			local var_232_43 = 1.966

			if var_232_43 < arg_229_1.time_ and arg_229_1.time_ <= var_232_43 + arg_232_0 then
				arg_229_1.var_.moveOldPos1097ui_story = var_232_42.localPosition
			end

			local var_232_44 = 0.001

			if var_232_43 <= arg_229_1.time_ and arg_229_1.time_ < var_232_43 + var_232_44 then
				local var_232_45 = (arg_229_1.time_ - var_232_43) / var_232_44
				local var_232_46 = Vector3.New(0, 100, 0)

				var_232_42.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1097ui_story, var_232_46, var_232_45)

				local var_232_47 = manager.ui.mainCamera.transform.position - var_232_42.position

				var_232_42.forward = Vector3.New(var_232_47.x, var_232_47.y, var_232_47.z)

				local var_232_48 = var_232_42.localEulerAngles

				var_232_48.z = 0
				var_232_48.x = 0
				var_232_42.localEulerAngles = var_232_48
			end

			if arg_229_1.time_ >= var_232_43 + var_232_44 and arg_229_1.time_ < var_232_43 + var_232_44 + arg_232_0 then
				var_232_42.localPosition = Vector3.New(0, 100, 0)

				local var_232_49 = manager.ui.mainCamera.transform.position - var_232_42.position

				var_232_42.forward = Vector3.New(var_232_49.x, var_232_49.y, var_232_49.z)

				local var_232_50 = var_232_42.localEulerAngles

				var_232_50.z = 0
				var_232_50.x = 0
				var_232_42.localEulerAngles = var_232_50
			end

			local var_232_51 = arg_229_1.actors_["10083ui_story"].transform
			local var_232_52 = 1.966

			if var_232_52 < arg_229_1.time_ and arg_229_1.time_ <= var_232_52 + arg_232_0 then
				arg_229_1.var_.moveOldPos10083ui_story = var_232_51.localPosition
			end

			local var_232_53 = 0.001

			if var_232_52 <= arg_229_1.time_ and arg_229_1.time_ < var_232_52 + var_232_53 then
				local var_232_54 = (arg_229_1.time_ - var_232_52) / var_232_53
				local var_232_55 = Vector3.New(0, 100, 0)

				var_232_51.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10083ui_story, var_232_55, var_232_54)

				local var_232_56 = manager.ui.mainCamera.transform.position - var_232_51.position

				var_232_51.forward = Vector3.New(var_232_56.x, var_232_56.y, var_232_56.z)

				local var_232_57 = var_232_51.localEulerAngles

				var_232_57.z = 0
				var_232_57.x = 0
				var_232_51.localEulerAngles = var_232_57
			end

			if arg_229_1.time_ >= var_232_52 + var_232_53 and arg_229_1.time_ < var_232_52 + var_232_53 + arg_232_0 then
				var_232_51.localPosition = Vector3.New(0, 100, 0)

				local var_232_58 = manager.ui.mainCamera.transform.position - var_232_51.position

				var_232_51.forward = Vector3.New(var_232_58.x, var_232_58.y, var_232_58.z)

				local var_232_59 = var_232_51.localEulerAngles

				var_232_59.z = 0
				var_232_59.x = 0
				var_232_51.localEulerAngles = var_232_59
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_60 = 3.999999999999
			local var_232_61 = 0.2

			if var_232_60 < arg_229_1.time_ and arg_229_1.time_ <= var_232_60 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_62 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_62:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_63 = arg_229_1:FormatText(StoryNameCfg[919].name)

				arg_229_1.leftNameTxt_.text = var_232_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_64 = arg_229_1:GetWordFromCfg(412031055)
				local var_232_65 = arg_229_1:FormatText(var_232_64.content)

				arg_229_1.text_.text = var_232_65

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_66 = 8
				local var_232_67 = utf8.len(var_232_65)
				local var_232_68 = var_232_66 <= 0 and var_232_61 or var_232_61 * (var_232_67 / var_232_66)

				if var_232_68 > 0 and var_232_61 < var_232_68 then
					arg_229_1.talkMaxDuration = var_232_68
					var_232_60 = var_232_60 + 0.3

					if var_232_68 + var_232_60 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_68 + var_232_60
					end
				end

				arg_229_1.text_.text = var_232_65
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031055", "story_v_out_412031.awb") ~= 0 then
					local var_232_69 = manager.audio:GetVoiceLength("story_v_out_412031", "412031055", "story_v_out_412031.awb") / 1000

					if var_232_69 + var_232_60 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_69 + var_232_60
					end

					if var_232_64.prefab_name ~= "" and arg_229_1.actors_[var_232_64.prefab_name] ~= nil then
						local var_232_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_64.prefab_name].transform, "story_v_out_412031", "412031055", "story_v_out_412031.awb")

						arg_229_1:RecordAudio("412031055", var_232_70)
						arg_229_1:RecordAudio("412031055", var_232_70)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_412031", "412031055", "story_v_out_412031.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_412031", "412031055", "story_v_out_412031.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_71 = var_232_60 + 0.3
			local var_232_72 = math.max(var_232_61, arg_229_1.talkMaxDuration)

			if var_232_71 <= arg_229_1.time_ and arg_229_1.time_ < var_232_71 + var_232_72 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_71) / var_232_72

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_71 + var_232_72 and arg_229_1.time_ < var_232_71 + var_232_72 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play412031056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 412031056
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play412031057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10078ui_story"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos10078ui_story = var_238_0.localPosition
			end

			local var_238_2 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2
				local var_238_4 = Vector3.New(0, 100, 0)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10078ui_story, var_238_4, var_238_3)

				local var_238_5 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_5.x, var_238_5.y, var_238_5.z)

				local var_238_6 = var_238_0.localEulerAngles

				var_238_6.z = 0
				var_238_6.x = 0
				var_238_0.localEulerAngles = var_238_6
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(0, 100, 0)

				local var_238_7 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_7.x, var_238_7.y, var_238_7.z)

				local var_238_8 = var_238_0.localEulerAngles

				var_238_8.z = 0
				var_238_8.x = 0
				var_238_0.localEulerAngles = var_238_8
			end

			local var_238_9 = arg_235_1.actors_["10078ui_story"]
			local var_238_10 = 0

			if var_238_10 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 and not isNil(var_238_9) and arg_235_1.var_.characterEffect10078ui_story == nil then
				arg_235_1.var_.characterEffect10078ui_story = var_238_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_11 = 0.200000002980232

			if var_238_10 <= arg_235_1.time_ and arg_235_1.time_ < var_238_10 + var_238_11 and not isNil(var_238_9) then
				local var_238_12 = (arg_235_1.time_ - var_238_10) / var_238_11

				if arg_235_1.var_.characterEffect10078ui_story and not isNil(var_238_9) then
					local var_238_13 = Mathf.Lerp(0, 0.5, var_238_12)

					arg_235_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_235_1.var_.characterEffect10078ui_story.fillRatio = var_238_13
				end
			end

			if arg_235_1.time_ >= var_238_10 + var_238_11 and arg_235_1.time_ < var_238_10 + var_238_11 + arg_238_0 and not isNil(var_238_9) and arg_235_1.var_.characterEffect10078ui_story then
				local var_238_14 = 0.5

				arg_235_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_235_1.var_.characterEffect10078ui_story.fillRatio = var_238_14
			end

			local var_238_15 = 0
			local var_238_16 = 1.35

			if var_238_15 < arg_235_1.time_ and arg_235_1.time_ <= var_238_15 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_17 = arg_235_1:GetWordFromCfg(412031056)
				local var_238_18 = arg_235_1:FormatText(var_238_17.content)

				arg_235_1.text_.text = var_238_18

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_19 = 54
				local var_238_20 = utf8.len(var_238_18)
				local var_238_21 = var_238_19 <= 0 and var_238_16 or var_238_16 * (var_238_20 / var_238_19)

				if var_238_21 > 0 and var_238_16 < var_238_21 then
					arg_235_1.talkMaxDuration = var_238_21

					if var_238_21 + var_238_15 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_21 + var_238_15
					end
				end

				arg_235_1.text_.text = var_238_18
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_22 = math.max(var_238_16, arg_235_1.talkMaxDuration)

			if var_238_15 <= arg_235_1.time_ and arg_235_1.time_ < var_238_15 + var_238_22 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_15) / var_238_22

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_15 + var_238_22 and arg_235_1.time_ < var_238_15 + var_238_22 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play412031057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 412031057
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play412031058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.925

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_2 = arg_239_1:GetWordFromCfg(412031057)
				local var_242_3 = arg_239_1:FormatText(var_242_2.content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 37
				local var_242_5 = utf8.len(var_242_3)
				local var_242_6 = var_242_4 <= 0 and var_242_1 or var_242_1 * (var_242_5 / var_242_4)

				if var_242_6 > 0 and var_242_1 < var_242_6 then
					arg_239_1.talkMaxDuration = var_242_6

					if var_242_6 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_7 and arg_239_1.time_ < var_242_0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play412031058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 412031058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play412031059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 0.675

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_2 = arg_243_1:GetWordFromCfg(412031058)
				local var_246_3 = arg_243_1:FormatText(var_246_2.content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 27
				local var_246_5 = utf8.len(var_246_3)
				local var_246_6 = var_246_4 <= 0 and var_246_1 or var_246_1 * (var_246_5 / var_246_4)

				if var_246_6 > 0 and var_246_1 < var_246_6 then
					arg_243_1.talkMaxDuration = var_246_6

					if var_246_6 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_7 and arg_243_1.time_ < var_246_0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play412031059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 412031059
		arg_247_1.duration_ = 11.03

		local var_247_0 = {
			zh = 5.5,
			ja = 11.033
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
				arg_247_0:Play412031060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10078ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos10078ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(0, -0.5, -6.3)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10078ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = arg_247_1.actors_["10078ui_story"]
			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect10078ui_story == nil then
				arg_247_1.var_.characterEffect10078ui_story = var_250_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_11 = 0.200000002980232

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_11 and not isNil(var_250_9) then
				local var_250_12 = (arg_247_1.time_ - var_250_10) / var_250_11

				if arg_247_1.var_.characterEffect10078ui_story and not isNil(var_250_9) then
					arg_247_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_10 + var_250_11 and arg_247_1.time_ < var_250_10 + var_250_11 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect10078ui_story then
				arg_247_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_250_13 = 0

			if var_250_13 < arg_247_1.time_ and arg_247_1.time_ <= var_250_13 + arg_250_0 then
				arg_247_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_2")
			end

			local var_250_14 = 0

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				arg_247_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_250_15 = 0
			local var_250_16 = 0.375

			if var_250_15 < arg_247_1.time_ and arg_247_1.time_ <= var_250_15 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_17 = arg_247_1:FormatText(StoryNameCfg[919].name)

				arg_247_1.leftNameTxt_.text = var_250_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_18 = arg_247_1:GetWordFromCfg(412031059)
				local var_250_19 = arg_247_1:FormatText(var_250_18.content)

				arg_247_1.text_.text = var_250_19

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_20 = 15
				local var_250_21 = utf8.len(var_250_19)
				local var_250_22 = var_250_20 <= 0 and var_250_16 or var_250_16 * (var_250_21 / var_250_20)

				if var_250_22 > 0 and var_250_16 < var_250_22 then
					arg_247_1.talkMaxDuration = var_250_22

					if var_250_22 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_22 + var_250_15
					end
				end

				arg_247_1.text_.text = var_250_19
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031059", "story_v_out_412031.awb") ~= 0 then
					local var_250_23 = manager.audio:GetVoiceLength("story_v_out_412031", "412031059", "story_v_out_412031.awb") / 1000

					if var_250_23 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_23 + var_250_15
					end

					if var_250_18.prefab_name ~= "" and arg_247_1.actors_[var_250_18.prefab_name] ~= nil then
						local var_250_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_18.prefab_name].transform, "story_v_out_412031", "412031059", "story_v_out_412031.awb")

						arg_247_1:RecordAudio("412031059", var_250_24)
						arg_247_1:RecordAudio("412031059", var_250_24)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_412031", "412031059", "story_v_out_412031.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_412031", "412031059", "story_v_out_412031.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_25 = math.max(var_250_16, arg_247_1.talkMaxDuration)

			if var_250_15 <= arg_247_1.time_ and arg_247_1.time_ < var_250_15 + var_250_25 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_15) / var_250_25

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_15 + var_250_25 and arg_247_1.time_ < var_250_15 + var_250_25 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play412031060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 412031060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play412031061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10078ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos10078ui_story = var_254_0.localPosition
			end

			local var_254_2 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2
				local var_254_4 = Vector3.New(0, 100, 0)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10078ui_story, var_254_4, var_254_3)

				local var_254_5 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_5.x, var_254_5.y, var_254_5.z)

				local var_254_6 = var_254_0.localEulerAngles

				var_254_6.z = 0
				var_254_6.x = 0
				var_254_0.localEulerAngles = var_254_6
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(0, 100, 0)

				local var_254_7 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_7.x, var_254_7.y, var_254_7.z)

				local var_254_8 = var_254_0.localEulerAngles

				var_254_8.z = 0
				var_254_8.x = 0
				var_254_0.localEulerAngles = var_254_8
			end

			local var_254_9 = arg_251_1.actors_["10078ui_story"]
			local var_254_10 = 0

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect10078ui_story == nil then
				arg_251_1.var_.characterEffect10078ui_story = var_254_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_11 = 0.200000002980232

			if var_254_10 <= arg_251_1.time_ and arg_251_1.time_ < var_254_10 + var_254_11 and not isNil(var_254_9) then
				local var_254_12 = (arg_251_1.time_ - var_254_10) / var_254_11

				if arg_251_1.var_.characterEffect10078ui_story and not isNil(var_254_9) then
					local var_254_13 = Mathf.Lerp(0, 0.5, var_254_12)

					arg_251_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_251_1.var_.characterEffect10078ui_story.fillRatio = var_254_13
				end
			end

			if arg_251_1.time_ >= var_254_10 + var_254_11 and arg_251_1.time_ < var_254_10 + var_254_11 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect10078ui_story then
				local var_254_14 = 0.5

				arg_251_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_251_1.var_.characterEffect10078ui_story.fillRatio = var_254_14
			end

			local var_254_15 = 0
			local var_254_16 = 0.725

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_17 = arg_251_1:GetWordFromCfg(412031060)
				local var_254_18 = arg_251_1:FormatText(var_254_17.content)

				arg_251_1.text_.text = var_254_18

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_19 = 29
				local var_254_20 = utf8.len(var_254_18)
				local var_254_21 = var_254_19 <= 0 and var_254_16 or var_254_16 * (var_254_20 / var_254_19)

				if var_254_21 > 0 and var_254_16 < var_254_21 then
					arg_251_1.talkMaxDuration = var_254_21

					if var_254_21 + var_254_15 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_21 + var_254_15
					end
				end

				arg_251_1.text_.text = var_254_18
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_22 = math.max(var_254_16, arg_251_1.talkMaxDuration)

			if var_254_15 <= arg_251_1.time_ and arg_251_1.time_ < var_254_15 + var_254_22 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_15) / var_254_22

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_15 + var_254_22 and arg_251_1.time_ < var_254_15 + var_254_22 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412031061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 412031061
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play412031062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.55

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0

				arg_255_1.dialog_:SetActive(true)

				arg_255_1.dialogCg_.alpha = 0

				local var_258_2 = LeanTween.value(arg_255_1.dialog_, 0, 1, 0.3)

				var_258_2:setOnUpdate(LuaHelper.FloatAction(function(arg_259_0)
					arg_255_1.dialogCg_.alpha = arg_259_0
				end))
				var_258_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_255_1.dialog_)
					var_258_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_255_1.duration_ = arg_255_1.duration_ + 0.3

				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_3 = arg_255_1:GetWordFromCfg(412031061)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 22
				local var_258_6 = utf8.len(var_258_4)
				local var_258_7 = var_258_5 <= 0 and var_258_1 or var_258_1 * (var_258_6 / var_258_5)

				if var_258_7 > 0 and var_258_1 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7
					var_258_0 = var_258_0 + 0.3

					if var_258_7 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_8 = var_258_0 + 0.3
			local var_258_9 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_8 <= arg_255_1.time_ and arg_255_1.time_ < var_258_8 + var_258_9 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_8) / var_258_9

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_8 + var_258_9 and arg_255_1.time_ < var_258_8 + var_258_9 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play412031062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 412031062
		arg_261_1.duration_ = 13.93

		local var_261_0 = {
			zh = 12.166,
			ja = 13.933
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
				arg_261_0:Play412031063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 2.00000000298023

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				local var_264_1 = manager.ui.mainCamera.transform.localPosition
				local var_264_2 = Vector3.New(0, 0, 10) + Vector3.New(var_264_1.x, var_264_1.y, 0)
				local var_264_3 = arg_261_1.bgs_.ST30

				var_264_3.transform.localPosition = var_264_2
				var_264_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_264_4 = var_264_3:GetComponent("SpriteRenderer")

				if var_264_4 and var_264_4.sprite then
					local var_264_5 = (var_264_3.transform.localPosition - var_264_1).z
					local var_264_6 = manager.ui.mainCameraCom_
					local var_264_7 = 2 * var_264_5 * Mathf.Tan(var_264_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_264_8 = var_264_7 * var_264_6.aspect
					local var_264_9 = var_264_4.sprite.bounds.size.x
					local var_264_10 = var_264_4.sprite.bounds.size.y
					local var_264_11 = var_264_8 / var_264_9
					local var_264_12 = var_264_7 / var_264_10
					local var_264_13 = var_264_12 < var_264_11 and var_264_11 or var_264_12

					var_264_3.transform.localScale = Vector3.New(var_264_13, var_264_13, 0)
				end

				for iter_264_0, iter_264_1 in pairs(arg_261_1.bgs_) do
					if iter_264_0 ~= "ST30" then
						iter_264_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_264_14 = 4.00000000298023

			if var_264_14 < arg_261_1.time_ and arg_261_1.time_ <= var_264_14 + arg_264_0 then
				arg_261_1.allBtn_.enabled = false
			end

			local var_264_15 = 0.3

			if arg_261_1.time_ >= var_264_14 + var_264_15 and arg_261_1.time_ < var_264_14 + var_264_15 + arg_264_0 then
				arg_261_1.allBtn_.enabled = true
			end

			local var_264_16 = 0

			if var_264_16 < arg_261_1.time_ and arg_261_1.time_ <= var_264_16 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_17 = 2

			if var_264_16 <= arg_261_1.time_ and arg_261_1.time_ < var_264_16 + var_264_17 then
				local var_264_18 = (arg_261_1.time_ - var_264_16) / var_264_17
				local var_264_19 = Color.New(0, 0, 0)

				var_264_19.a = Mathf.Lerp(0, 1, var_264_18)
				arg_261_1.mask_.color = var_264_19
			end

			if arg_261_1.time_ >= var_264_16 + var_264_17 and arg_261_1.time_ < var_264_16 + var_264_17 + arg_264_0 then
				local var_264_20 = Color.New(0, 0, 0)

				var_264_20.a = 1
				arg_261_1.mask_.color = var_264_20
			end

			local var_264_21 = 2

			if var_264_21 < arg_261_1.time_ and arg_261_1.time_ <= var_264_21 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_22 = 2

			if var_264_21 <= arg_261_1.time_ and arg_261_1.time_ < var_264_21 + var_264_22 then
				local var_264_23 = (arg_261_1.time_ - var_264_21) / var_264_22
				local var_264_24 = Color.New(0, 0, 0)

				var_264_24.a = Mathf.Lerp(1, 0, var_264_23)
				arg_261_1.mask_.color = var_264_24
			end

			if arg_261_1.time_ >= var_264_21 + var_264_22 and arg_261_1.time_ < var_264_21 + var_264_22 + arg_264_0 then
				local var_264_25 = Color.New(0, 0, 0)
				local var_264_26 = 0

				arg_261_1.mask_.enabled = false
				var_264_25.a = var_264_26
				arg_261_1.mask_.color = var_264_25
			end

			local var_264_27 = arg_261_1.actors_["10083ui_story"].transform
			local var_264_28 = 3.8

			if var_264_28 < arg_261_1.time_ and arg_261_1.time_ <= var_264_28 + arg_264_0 then
				arg_261_1.var_.moveOldPos10083ui_story = var_264_27.localPosition
			end

			local var_264_29 = 0.001

			if var_264_28 <= arg_261_1.time_ and arg_261_1.time_ < var_264_28 + var_264_29 then
				local var_264_30 = (arg_261_1.time_ - var_264_28) / var_264_29
				local var_264_31 = Vector3.New(0, -2.6, -2.8)

				var_264_27.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10083ui_story, var_264_31, var_264_30)

				local var_264_32 = manager.ui.mainCamera.transform.position - var_264_27.position

				var_264_27.forward = Vector3.New(var_264_32.x, var_264_32.y, var_264_32.z)

				local var_264_33 = var_264_27.localEulerAngles

				var_264_33.z = 0
				var_264_33.x = 0
				var_264_27.localEulerAngles = var_264_33
			end

			if arg_261_1.time_ >= var_264_28 + var_264_29 and arg_261_1.time_ < var_264_28 + var_264_29 + arg_264_0 then
				var_264_27.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_264_34 = manager.ui.mainCamera.transform.position - var_264_27.position

				var_264_27.forward = Vector3.New(var_264_34.x, var_264_34.y, var_264_34.z)

				local var_264_35 = var_264_27.localEulerAngles

				var_264_35.z = 0
				var_264_35.x = 0
				var_264_27.localEulerAngles = var_264_35
			end

			local var_264_36 = arg_261_1.actors_["10083ui_story"]
			local var_264_37 = 3.8

			if var_264_37 < arg_261_1.time_ and arg_261_1.time_ <= var_264_37 + arg_264_0 and not isNil(var_264_36) and arg_261_1.var_.characterEffect10083ui_story == nil then
				arg_261_1.var_.characterEffect10083ui_story = var_264_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_38 = 0.200000002980232

			if var_264_37 <= arg_261_1.time_ and arg_261_1.time_ < var_264_37 + var_264_38 and not isNil(var_264_36) then
				local var_264_39 = (arg_261_1.time_ - var_264_37) / var_264_38

				if arg_261_1.var_.characterEffect10083ui_story and not isNil(var_264_36) then
					arg_261_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_37 + var_264_38 and arg_261_1.time_ < var_264_37 + var_264_38 + arg_264_0 and not isNil(var_264_36) and arg_261_1.var_.characterEffect10083ui_story then
				arg_261_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_264_40 = 3.8

			if var_264_40 < arg_261_1.time_ and arg_261_1.time_ <= var_264_40 + arg_264_0 then
				arg_261_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_1")
			end

			local var_264_41 = 3.8

			if var_264_41 < arg_261_1.time_ and arg_261_1.time_ <= var_264_41 + arg_264_0 then
				arg_261_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_264_42 = arg_261_1.actors_["10078ui_story"].transform
			local var_264_43 = 1.96599999815226

			if var_264_43 < arg_261_1.time_ and arg_261_1.time_ <= var_264_43 + arg_264_0 then
				arg_261_1.var_.moveOldPos10078ui_story = var_264_42.localPosition
			end

			local var_264_44 = 0.001

			if var_264_43 <= arg_261_1.time_ and arg_261_1.time_ < var_264_43 + var_264_44 then
				local var_264_45 = (arg_261_1.time_ - var_264_43) / var_264_44
				local var_264_46 = Vector3.New(0, 100, 0)

				var_264_42.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10078ui_story, var_264_46, var_264_45)

				local var_264_47 = manager.ui.mainCamera.transform.position - var_264_42.position

				var_264_42.forward = Vector3.New(var_264_47.x, var_264_47.y, var_264_47.z)

				local var_264_48 = var_264_42.localEulerAngles

				var_264_48.z = 0
				var_264_48.x = 0
				var_264_42.localEulerAngles = var_264_48
			end

			if arg_261_1.time_ >= var_264_43 + var_264_44 and arg_261_1.time_ < var_264_43 + var_264_44 + arg_264_0 then
				var_264_42.localPosition = Vector3.New(0, 100, 0)

				local var_264_49 = manager.ui.mainCamera.transform.position - var_264_42.position

				var_264_42.forward = Vector3.New(var_264_49.x, var_264_49.y, var_264_49.z)

				local var_264_50 = var_264_42.localEulerAngles

				var_264_50.z = 0
				var_264_50.x = 0
				var_264_42.localEulerAngles = var_264_50
			end

			if arg_261_1.frameCnt_ <= 1 then
				arg_261_1.dialog_:SetActive(false)
			end

			local var_264_51 = 4
			local var_264_52 = 0.875

			if var_264_51 < arg_261_1.time_ and arg_261_1.time_ <= var_264_51 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_53 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_53:setOnUpdate(LuaHelper.FloatAction(function(arg_265_0)
					arg_261_1.dialogCg_.alpha = arg_265_0
				end))
				var_264_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_54 = arg_261_1:FormatText(StoryNameCfg[918].name)

				arg_261_1.leftNameTxt_.text = var_264_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_55 = arg_261_1:GetWordFromCfg(412031062)
				local var_264_56 = arg_261_1:FormatText(var_264_55.content)

				arg_261_1.text_.text = var_264_56

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_57 = 35
				local var_264_58 = utf8.len(var_264_56)
				local var_264_59 = var_264_57 <= 0 and var_264_52 or var_264_52 * (var_264_58 / var_264_57)

				if var_264_59 > 0 and var_264_52 < var_264_59 then
					arg_261_1.talkMaxDuration = var_264_59
					var_264_51 = var_264_51 + 0.3

					if var_264_59 + var_264_51 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_59 + var_264_51
					end
				end

				arg_261_1.text_.text = var_264_56
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031062", "story_v_out_412031.awb") ~= 0 then
					local var_264_60 = manager.audio:GetVoiceLength("story_v_out_412031", "412031062", "story_v_out_412031.awb") / 1000

					if var_264_60 + var_264_51 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_60 + var_264_51
					end

					if var_264_55.prefab_name ~= "" and arg_261_1.actors_[var_264_55.prefab_name] ~= nil then
						local var_264_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_55.prefab_name].transform, "story_v_out_412031", "412031062", "story_v_out_412031.awb")

						arg_261_1:RecordAudio("412031062", var_264_61)
						arg_261_1:RecordAudio("412031062", var_264_61)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_412031", "412031062", "story_v_out_412031.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_412031", "412031062", "story_v_out_412031.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_62 = var_264_51 + 0.3
			local var_264_63 = math.max(var_264_52, arg_261_1.talkMaxDuration)

			if var_264_62 <= arg_261_1.time_ and arg_261_1.time_ < var_264_62 + var_264_63 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_62) / var_264_63

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_62 + var_264_63 and arg_261_1.time_ < var_264_62 + var_264_63 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play412031063 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 412031063
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play412031064(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["10083ui_story"].transform
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.var_.moveOldPos10083ui_story = var_270_0.localPosition
			end

			local var_270_2 = 0.001

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2
				local var_270_4 = Vector3.New(0, 100, 0)

				var_270_0.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10083ui_story, var_270_4, var_270_3)

				local var_270_5 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_5.x, var_270_5.y, var_270_5.z)

				local var_270_6 = var_270_0.localEulerAngles

				var_270_6.z = 0
				var_270_6.x = 0
				var_270_0.localEulerAngles = var_270_6
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 then
				var_270_0.localPosition = Vector3.New(0, 100, 0)

				local var_270_7 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_7.x, var_270_7.y, var_270_7.z)

				local var_270_8 = var_270_0.localEulerAngles

				var_270_8.z = 0
				var_270_8.x = 0
				var_270_0.localEulerAngles = var_270_8
			end

			local var_270_9 = arg_267_1.actors_["10083ui_story"]
			local var_270_10 = 0

			if var_270_10 < arg_267_1.time_ and arg_267_1.time_ <= var_270_10 + arg_270_0 and not isNil(var_270_9) and arg_267_1.var_.characterEffect10083ui_story == nil then
				arg_267_1.var_.characterEffect10083ui_story = var_270_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_11 = 0.200000002980232

			if var_270_10 <= arg_267_1.time_ and arg_267_1.time_ < var_270_10 + var_270_11 and not isNil(var_270_9) then
				local var_270_12 = (arg_267_1.time_ - var_270_10) / var_270_11

				if arg_267_1.var_.characterEffect10083ui_story and not isNil(var_270_9) then
					local var_270_13 = Mathf.Lerp(0, 0.5, var_270_12)

					arg_267_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_267_1.var_.characterEffect10083ui_story.fillRatio = var_270_13
				end
			end

			if arg_267_1.time_ >= var_270_10 + var_270_11 and arg_267_1.time_ < var_270_10 + var_270_11 + arg_270_0 and not isNil(var_270_9) and arg_267_1.var_.characterEffect10083ui_story then
				local var_270_14 = 0.5

				arg_267_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_267_1.var_.characterEffect10083ui_story.fillRatio = var_270_14
			end

			local var_270_15 = 0
			local var_270_16 = 1.475

			if var_270_15 < arg_267_1.time_ and arg_267_1.time_ <= var_270_15 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_17 = arg_267_1:GetWordFromCfg(412031063)
				local var_270_18 = arg_267_1:FormatText(var_270_17.content)

				arg_267_1.text_.text = var_270_18

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_19 = 59
				local var_270_20 = utf8.len(var_270_18)
				local var_270_21 = var_270_19 <= 0 and var_270_16 or var_270_16 * (var_270_20 / var_270_19)

				if var_270_21 > 0 and var_270_16 < var_270_21 then
					arg_267_1.talkMaxDuration = var_270_21

					if var_270_21 + var_270_15 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_21 + var_270_15
					end
				end

				arg_267_1.text_.text = var_270_18
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_22 = math.max(var_270_16, arg_267_1.talkMaxDuration)

			if var_270_15 <= arg_267_1.time_ and arg_267_1.time_ < var_270_15 + var_270_22 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_15) / var_270_22

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_15 + var_270_22 and arg_267_1.time_ < var_270_15 + var_270_22 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play412031064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 412031064
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play412031065(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 1.4

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_2 = arg_271_1:GetWordFromCfg(412031064)
				local var_274_3 = arg_271_1:FormatText(var_274_2.content)

				arg_271_1.text_.text = var_274_3

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 56
				local var_274_5 = utf8.len(var_274_3)
				local var_274_6 = var_274_4 <= 0 and var_274_1 or var_274_1 * (var_274_5 / var_274_4)

				if var_274_6 > 0 and var_274_1 < var_274_6 then
					arg_271_1.talkMaxDuration = var_274_6

					if var_274_6 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_6 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_3
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_7 and arg_271_1.time_ < var_274_0 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play412031065 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 412031065
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play412031066(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0
			local var_278_1 = 0.75

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_2 = arg_275_1:GetWordFromCfg(412031065)
				local var_278_3 = arg_275_1:FormatText(var_278_2.content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 30
				local var_278_5 = utf8.len(var_278_3)
				local var_278_6 = var_278_4 <= 0 and var_278_1 or var_278_1 * (var_278_5 / var_278_4)

				if var_278_6 > 0 and var_278_1 < var_278_6 then
					arg_275_1.talkMaxDuration = var_278_6

					if var_278_6 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_6 + var_278_0
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_1, arg_275_1.talkMaxDuration)

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_0) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_0 + var_278_7 and arg_275_1.time_ < var_278_0 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play412031066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 412031066
		arg_279_1.duration_ = 9.57

		local var_279_0 = {
			zh = 9.566,
			ja = 5.733
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
				arg_279_0:Play412031067(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10083ui_story"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos10083ui_story = var_282_0.localPosition
			end

			local var_282_2 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2
				local var_282_4 = Vector3.New(0, -2.6, -2.8)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10083ui_story, var_282_4, var_282_3)

				local var_282_5 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_5.x, var_282_5.y, var_282_5.z)

				local var_282_6 = var_282_0.localEulerAngles

				var_282_6.z = 0
				var_282_6.x = 0
				var_282_0.localEulerAngles = var_282_6
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_282_7 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_7.x, var_282_7.y, var_282_7.z)

				local var_282_8 = var_282_0.localEulerAngles

				var_282_8.z = 0
				var_282_8.x = 0
				var_282_0.localEulerAngles = var_282_8
			end

			local var_282_9 = arg_279_1.actors_["10083ui_story"]
			local var_282_10 = 0

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect10083ui_story == nil then
				arg_279_1.var_.characterEffect10083ui_story = var_282_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_11 = 0.200000002980232

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_11 and not isNil(var_282_9) then
				local var_282_12 = (arg_279_1.time_ - var_282_10) / var_282_11

				if arg_279_1.var_.characterEffect10083ui_story and not isNil(var_282_9) then
					arg_279_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_10 + var_282_11 and arg_279_1.time_ < var_282_10 + var_282_11 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect10083ui_story then
				arg_279_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_282_13 = 0

			if var_282_13 < arg_279_1.time_ and arg_279_1.time_ <= var_282_13 + arg_282_0 then
				arg_279_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083actionlink/10083action445")
			end

			local var_282_14 = 0

			if var_282_14 < arg_279_1.time_ and arg_279_1.time_ <= var_282_14 + arg_282_0 then
				arg_279_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_282_15 = 0
			local var_282_16 = 1.1

			if var_282_15 < arg_279_1.time_ and arg_279_1.time_ <= var_282_15 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_17 = arg_279_1:FormatText(StoryNameCfg[918].name)

				arg_279_1.leftNameTxt_.text = var_282_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_18 = arg_279_1:GetWordFromCfg(412031066)
				local var_282_19 = arg_279_1:FormatText(var_282_18.content)

				arg_279_1.text_.text = var_282_19

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_20 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031066", "story_v_out_412031.awb") ~= 0 then
					local var_282_23 = manager.audio:GetVoiceLength("story_v_out_412031", "412031066", "story_v_out_412031.awb") / 1000

					if var_282_23 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_23 + var_282_15
					end

					if var_282_18.prefab_name ~= "" and arg_279_1.actors_[var_282_18.prefab_name] ~= nil then
						local var_282_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_18.prefab_name].transform, "story_v_out_412031", "412031066", "story_v_out_412031.awb")

						arg_279_1:RecordAudio("412031066", var_282_24)
						arg_279_1:RecordAudio("412031066", var_282_24)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_412031", "412031066", "story_v_out_412031.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_412031", "412031066", "story_v_out_412031.awb")
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
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play412031067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 412031067
		arg_283_1.duration_ = 8.53

		local var_283_0 = {
			zh = 8.533,
			ja = 7.4
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
				arg_283_0:Play412031068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0
			local var_286_1 = 0.875

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_2 = arg_283_1:FormatText(StoryNameCfg[918].name)

				arg_283_1.leftNameTxt_.text = var_286_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_3 = arg_283_1:GetWordFromCfg(412031067)
				local var_286_4 = arg_283_1:FormatText(var_286_3.content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031067", "story_v_out_412031.awb") ~= 0 then
					local var_286_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031067", "story_v_out_412031.awb") / 1000

					if var_286_8 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_0
					end

					if var_286_3.prefab_name ~= "" and arg_283_1.actors_[var_286_3.prefab_name] ~= nil then
						local var_286_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_3.prefab_name].transform, "story_v_out_412031", "412031067", "story_v_out_412031.awb")

						arg_283_1:RecordAudio("412031067", var_286_9)
						arg_283_1:RecordAudio("412031067", var_286_9)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_412031", "412031067", "story_v_out_412031.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_412031", "412031067", "story_v_out_412031.awb")
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
	Play412031068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 412031068
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play412031069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10083ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos10083ui_story = var_290_0.localPosition
			end

			local var_290_2 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2
				local var_290_4 = Vector3.New(0, 100, 0)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10083ui_story, var_290_4, var_290_3)

				local var_290_5 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_5.x, var_290_5.y, var_290_5.z)

				local var_290_6 = var_290_0.localEulerAngles

				var_290_6.z = 0
				var_290_6.x = 0
				var_290_0.localEulerAngles = var_290_6
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(0, 100, 0)

				local var_290_7 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_7.x, var_290_7.y, var_290_7.z)

				local var_290_8 = var_290_0.localEulerAngles

				var_290_8.z = 0
				var_290_8.x = 0
				var_290_0.localEulerAngles = var_290_8
			end

			local var_290_9 = arg_287_1.actors_["10083ui_story"]
			local var_290_10 = 0

			if var_290_10 < arg_287_1.time_ and arg_287_1.time_ <= var_290_10 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect10083ui_story == nil then
				arg_287_1.var_.characterEffect10083ui_story = var_290_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_11 = 0.034000001847744

			if var_290_10 <= arg_287_1.time_ and arg_287_1.time_ < var_290_10 + var_290_11 and not isNil(var_290_9) then
				local var_290_12 = (arg_287_1.time_ - var_290_10) / var_290_11

				if arg_287_1.var_.characterEffect10083ui_story and not isNil(var_290_9) then
					local var_290_13 = Mathf.Lerp(0, 0.5, var_290_12)

					arg_287_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_287_1.var_.characterEffect10083ui_story.fillRatio = var_290_13
				end
			end

			if arg_287_1.time_ >= var_290_10 + var_290_11 and arg_287_1.time_ < var_290_10 + var_290_11 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect10083ui_story then
				local var_290_14 = 0.5

				arg_287_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_287_1.var_.characterEffect10083ui_story.fillRatio = var_290_14
			end

			local var_290_15 = 0
			local var_290_16 = 0.475

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0

				arg_287_1.dialog_:SetActive(true)

				arg_287_1.dialogCg_.alpha = 0

				local var_290_17 = LeanTween.value(arg_287_1.dialog_, 0, 1, 0.3)

				var_290_17:setOnUpdate(LuaHelper.FloatAction(function(arg_291_0)
					arg_287_1.dialogCg_.alpha = arg_291_0
				end))
				var_290_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_287_1.dialog_)
					var_290_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_287_1.duration_ = arg_287_1.duration_ + 0.3

				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_18 = arg_287_1:GetWordFromCfg(412031068)
				local var_290_19 = arg_287_1:FormatText(var_290_18.content)

				arg_287_1.text_.text = var_290_19

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_20 = 19
				local var_290_21 = utf8.len(var_290_19)
				local var_290_22 = var_290_20 <= 0 and var_290_16 or var_290_16 * (var_290_21 / var_290_20)

				if var_290_22 > 0 and var_290_16 < var_290_22 then
					arg_287_1.talkMaxDuration = var_290_22
					var_290_15 = var_290_15 + 0.3

					if var_290_22 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_22 + var_290_15
					end
				end

				arg_287_1.text_.text = var_290_19
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_23 = var_290_15 + 0.3
			local var_290_24 = math.max(var_290_16, arg_287_1.talkMaxDuration)

			if var_290_23 <= arg_287_1.time_ and arg_287_1.time_ < var_290_23 + var_290_24 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_23) / var_290_24

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_23 + var_290_24 and arg_287_1.time_ < var_290_23 + var_290_24 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play412031069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 412031069
		arg_293_1.duration_ = 10.83

		local var_293_0 = {
			zh = 10.832999999999,
			ja = 9.99999999999899
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play412031070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 4

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				local var_296_1 = manager.ui.mainCamera.transform.localPosition
				local var_296_2 = Vector3.New(0, 0, 10) + Vector3.New(var_296_1.x, var_296_1.y, 0)
				local var_296_3 = arg_293_1.bgs_.ST30

				var_296_3.transform.localPosition = var_296_2
				var_296_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_296_4 = var_296_3:GetComponent("SpriteRenderer")

				if var_296_4 and var_296_4.sprite then
					local var_296_5 = (var_296_3.transform.localPosition - var_296_1).z
					local var_296_6 = manager.ui.mainCameraCom_
					local var_296_7 = 2 * var_296_5 * Mathf.Tan(var_296_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_296_8 = var_296_7 * var_296_6.aspect
					local var_296_9 = var_296_4.sprite.bounds.size.x
					local var_296_10 = var_296_4.sprite.bounds.size.y
					local var_296_11 = var_296_8 / var_296_9
					local var_296_12 = var_296_7 / var_296_10
					local var_296_13 = var_296_12 < var_296_11 and var_296_11 or var_296_12

					var_296_3.transform.localScale = Vector3.New(var_296_13, var_296_13, 0)
				end

				for iter_296_0, iter_296_1 in pairs(arg_293_1.bgs_) do
					if iter_296_0 ~= "ST30" then
						iter_296_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_296_14 = 5.99999999999999

			if var_296_14 < arg_293_1.time_ and arg_293_1.time_ <= var_296_14 + arg_296_0 then
				arg_293_1.allBtn_.enabled = false
			end

			local var_296_15 = 0.3

			if arg_293_1.time_ >= var_296_14 + var_296_15 and arg_293_1.time_ < var_296_14 + var_296_15 + arg_296_0 then
				arg_293_1.allBtn_.enabled = true
			end

			local var_296_16 = 0

			if var_296_16 < arg_293_1.time_ and arg_293_1.time_ <= var_296_16 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_17 = 3

			if var_296_16 <= arg_293_1.time_ and arg_293_1.time_ < var_296_16 + var_296_17 then
				local var_296_18 = (arg_293_1.time_ - var_296_16) / var_296_17
				local var_296_19 = Color.New(0, 0, 0)

				var_296_19.a = Mathf.Lerp(0, 1, var_296_18)
				arg_293_1.mask_.color = var_296_19
			end

			if arg_293_1.time_ >= var_296_16 + var_296_17 and arg_293_1.time_ < var_296_16 + var_296_17 + arg_296_0 then
				local var_296_20 = Color.New(0, 0, 0)

				var_296_20.a = 1
				arg_293_1.mask_.color = var_296_20
			end

			local var_296_21 = 3

			if var_296_21 < arg_293_1.time_ and arg_293_1.time_ <= var_296_21 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_22 = 3

			if var_296_21 <= arg_293_1.time_ and arg_293_1.time_ < var_296_21 + var_296_22 then
				local var_296_23 = (arg_293_1.time_ - var_296_21) / var_296_22
				local var_296_24 = Color.New(0, 0, 0)

				var_296_24.a = Mathf.Lerp(1, 0, var_296_23)
				arg_293_1.mask_.color = var_296_24
			end

			if arg_293_1.time_ >= var_296_21 + var_296_22 and arg_293_1.time_ < var_296_21 + var_296_22 + arg_296_0 then
				local var_296_25 = Color.New(0, 0, 0)
				local var_296_26 = 0

				arg_293_1.mask_.enabled = false
				var_296_25.a = var_296_26
				arg_293_1.mask_.color = var_296_25
			end

			local var_296_27 = arg_293_1.actors_["10076ui_story"].transform
			local var_296_28 = 5.8

			if var_296_28 < arg_293_1.time_ and arg_293_1.time_ <= var_296_28 + arg_296_0 then
				arg_293_1.var_.moveOldPos10076ui_story = var_296_27.localPosition
			end

			local var_296_29 = 0.001

			if var_296_28 <= arg_293_1.time_ and arg_293_1.time_ < var_296_28 + var_296_29 then
				local var_296_30 = (arg_293_1.time_ - var_296_28) / var_296_29
				local var_296_31 = Vector3.New(-1, -0.35, -4)

				var_296_27.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10076ui_story, var_296_31, var_296_30)

				local var_296_32 = manager.ui.mainCamera.transform.position - var_296_27.position

				var_296_27.forward = Vector3.New(var_296_32.x, var_296_32.y, var_296_32.z)

				local var_296_33 = var_296_27.localEulerAngles

				var_296_33.z = 0
				var_296_33.x = 0
				var_296_27.localEulerAngles = var_296_33
			end

			if arg_293_1.time_ >= var_296_28 + var_296_29 and arg_293_1.time_ < var_296_28 + var_296_29 + arg_296_0 then
				var_296_27.localPosition = Vector3.New(-1, -0.35, -4)

				local var_296_34 = manager.ui.mainCamera.transform.position - var_296_27.position

				var_296_27.forward = Vector3.New(var_296_34.x, var_296_34.y, var_296_34.z)

				local var_296_35 = var_296_27.localEulerAngles

				var_296_35.z = 0
				var_296_35.x = 0
				var_296_27.localEulerAngles = var_296_35
			end

			local var_296_36 = arg_293_1.actors_["10076ui_story"]
			local var_296_37 = 5.8

			if var_296_37 < arg_293_1.time_ and arg_293_1.time_ <= var_296_37 + arg_296_0 and not isNil(var_296_36) and arg_293_1.var_.characterEffect10076ui_story == nil then
				arg_293_1.var_.characterEffect10076ui_story = var_296_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_38 = 0.200000002980232

			if var_296_37 <= arg_293_1.time_ and arg_293_1.time_ < var_296_37 + var_296_38 and not isNil(var_296_36) then
				local var_296_39 = (arg_293_1.time_ - var_296_37) / var_296_38

				if arg_293_1.var_.characterEffect10076ui_story and not isNil(var_296_36) then
					arg_293_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_37 + var_296_38 and arg_293_1.time_ < var_296_37 + var_296_38 + arg_296_0 and not isNil(var_296_36) and arg_293_1.var_.characterEffect10076ui_story then
				arg_293_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_296_40 = 5.8

			if var_296_40 < arg_293_1.time_ and arg_293_1.time_ <= var_296_40 + arg_296_0 then
				arg_293_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			local var_296_41 = 5.8

			if var_296_41 < arg_293_1.time_ and arg_293_1.time_ <= var_296_41 + arg_296_0 then
				arg_293_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_293_1.frameCnt_ <= 1 then
				arg_293_1.dialog_:SetActive(false)
			end

			local var_296_42 = 5.99999999999899
			local var_296_43 = 0.5

			if var_296_42 < arg_293_1.time_ and arg_293_1.time_ <= var_296_42 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0

				arg_293_1.dialog_:SetActive(true)

				arg_293_1.dialogCg_.alpha = 0

				local var_296_44 = LeanTween.value(arg_293_1.dialog_, 0, 1, 0.3)

				var_296_44:setOnUpdate(LuaHelper.FloatAction(function(arg_297_0)
					arg_293_1.dialogCg_.alpha = arg_297_0
				end))
				var_296_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_293_1.dialog_)
					var_296_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_293_1.duration_ = arg_293_1.duration_ + 0.3

				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_45 = arg_293_1:FormatText(StoryNameCfg[917].name)

				arg_293_1.leftNameTxt_.text = var_296_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_46 = arg_293_1:GetWordFromCfg(412031069)
				local var_296_47 = arg_293_1:FormatText(var_296_46.content)

				arg_293_1.text_.text = var_296_47

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_48 = 20
				local var_296_49 = utf8.len(var_296_47)
				local var_296_50 = var_296_48 <= 0 and var_296_43 or var_296_43 * (var_296_49 / var_296_48)

				if var_296_50 > 0 and var_296_43 < var_296_50 then
					arg_293_1.talkMaxDuration = var_296_50
					var_296_42 = var_296_42 + 0.3

					if var_296_50 + var_296_42 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_50 + var_296_42
					end
				end

				arg_293_1.text_.text = var_296_47
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031069", "story_v_out_412031.awb") ~= 0 then
					local var_296_51 = manager.audio:GetVoiceLength("story_v_out_412031", "412031069", "story_v_out_412031.awb") / 1000

					if var_296_51 + var_296_42 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_51 + var_296_42
					end

					if var_296_46.prefab_name ~= "" and arg_293_1.actors_[var_296_46.prefab_name] ~= nil then
						local var_296_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_46.prefab_name].transform, "story_v_out_412031", "412031069", "story_v_out_412031.awb")

						arg_293_1:RecordAudio("412031069", var_296_52)
						arg_293_1:RecordAudio("412031069", var_296_52)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_412031", "412031069", "story_v_out_412031.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_412031", "412031069", "story_v_out_412031.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_53 = var_296_42 + 0.3
			local var_296_54 = math.max(var_296_43, arg_293_1.talkMaxDuration)

			if var_296_53 <= arg_293_1.time_ and arg_293_1.time_ < var_296_53 + var_296_54 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_53) / var_296_54

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_53 + var_296_54 and arg_293_1.time_ < var_296_53 + var_296_54 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 5.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play412031070 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 412031070
		arg_299_1.duration_ = 3.2

		local var_299_0 = {
			zh = 2.6,
			ja = 3.2
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
				arg_299_0:Play412031071(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1097ui_story"].transform
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.var_.moveOldPos1097ui_story = var_302_0.localPosition
			end

			local var_302_2 = 0.001

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2
				local var_302_4 = Vector3.New(0.7, -0.54, -6.3)

				var_302_0.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1097ui_story, var_302_4, var_302_3)

				local var_302_5 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_5.x, var_302_5.y, var_302_5.z)

				local var_302_6 = var_302_0.localEulerAngles

				var_302_6.z = 0
				var_302_6.x = 0
				var_302_0.localEulerAngles = var_302_6
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 then
				var_302_0.localPosition = Vector3.New(0.7, -0.54, -6.3)

				local var_302_7 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_7.x, var_302_7.y, var_302_7.z)

				local var_302_8 = var_302_0.localEulerAngles

				var_302_8.z = 0
				var_302_8.x = 0
				var_302_0.localEulerAngles = var_302_8
			end

			local var_302_9 = arg_299_1.actors_["1097ui_story"]
			local var_302_10 = 0

			if var_302_10 < arg_299_1.time_ and arg_299_1.time_ <= var_302_10 + arg_302_0 and not isNil(var_302_9) and arg_299_1.var_.characterEffect1097ui_story == nil then
				arg_299_1.var_.characterEffect1097ui_story = var_302_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_11 = 0.200000002980232

			if var_302_10 <= arg_299_1.time_ and arg_299_1.time_ < var_302_10 + var_302_11 and not isNil(var_302_9) then
				local var_302_12 = (arg_299_1.time_ - var_302_10) / var_302_11

				if arg_299_1.var_.characterEffect1097ui_story and not isNil(var_302_9) then
					arg_299_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_10 + var_302_11 and arg_299_1.time_ < var_302_10 + var_302_11 + arg_302_0 and not isNil(var_302_9) and arg_299_1.var_.characterEffect1097ui_story then
				arg_299_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_302_13 = 0

			if var_302_13 < arg_299_1.time_ and arg_299_1.time_ <= var_302_13 + arg_302_0 then
				arg_299_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_302_14 = 0

			if var_302_14 < arg_299_1.time_ and arg_299_1.time_ <= var_302_14 + arg_302_0 then
				arg_299_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_302_15 = arg_299_1.actors_["10076ui_story"]
			local var_302_16 = 0

			if var_302_16 < arg_299_1.time_ and arg_299_1.time_ <= var_302_16 + arg_302_0 and not isNil(var_302_15) and arg_299_1.var_.characterEffect10076ui_story == nil then
				arg_299_1.var_.characterEffect10076ui_story = var_302_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_17 = 0.200000002980232

			if var_302_16 <= arg_299_1.time_ and arg_299_1.time_ < var_302_16 + var_302_17 and not isNil(var_302_15) then
				local var_302_18 = (arg_299_1.time_ - var_302_16) / var_302_17

				if arg_299_1.var_.characterEffect10076ui_story and not isNil(var_302_15) then
					local var_302_19 = Mathf.Lerp(0, 0.5, var_302_18)

					arg_299_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_299_1.var_.characterEffect10076ui_story.fillRatio = var_302_19
				end
			end

			if arg_299_1.time_ >= var_302_16 + var_302_17 and arg_299_1.time_ < var_302_16 + var_302_17 + arg_302_0 and not isNil(var_302_15) and arg_299_1.var_.characterEffect10076ui_story then
				local var_302_20 = 0.5

				arg_299_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_299_1.var_.characterEffect10076ui_story.fillRatio = var_302_20
			end

			local var_302_21 = 0
			local var_302_22 = 0.15

			if var_302_21 < arg_299_1.time_ and arg_299_1.time_ <= var_302_21 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_23 = arg_299_1:FormatText(StoryNameCfg[216].name)

				arg_299_1.leftNameTxt_.text = var_302_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_24 = arg_299_1:GetWordFromCfg(412031070)
				local var_302_25 = arg_299_1:FormatText(var_302_24.content)

				arg_299_1.text_.text = var_302_25

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_26 = 6
				local var_302_27 = utf8.len(var_302_25)
				local var_302_28 = var_302_26 <= 0 and var_302_22 or var_302_22 * (var_302_27 / var_302_26)

				if var_302_28 > 0 and var_302_22 < var_302_28 then
					arg_299_1.talkMaxDuration = var_302_28

					if var_302_28 + var_302_21 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_28 + var_302_21
					end
				end

				arg_299_1.text_.text = var_302_25
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031070", "story_v_out_412031.awb") ~= 0 then
					local var_302_29 = manager.audio:GetVoiceLength("story_v_out_412031", "412031070", "story_v_out_412031.awb") / 1000

					if var_302_29 + var_302_21 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_29 + var_302_21
					end

					if var_302_24.prefab_name ~= "" and arg_299_1.actors_[var_302_24.prefab_name] ~= nil then
						local var_302_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_24.prefab_name].transform, "story_v_out_412031", "412031070", "story_v_out_412031.awb")

						arg_299_1:RecordAudio("412031070", var_302_30)
						arg_299_1:RecordAudio("412031070", var_302_30)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_412031", "412031070", "story_v_out_412031.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_412031", "412031070", "story_v_out_412031.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_31 = math.max(var_302_22, arg_299_1.talkMaxDuration)

			if var_302_21 <= arg_299_1.time_ and arg_299_1.time_ < var_302_21 + var_302_31 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_21) / var_302_31

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_21 + var_302_31 and arg_299_1.time_ < var_302_21 + var_302_31 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play412031071 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 412031071
		arg_303_1.duration_ = 10.67

		local var_303_0 = {
			zh = 9.566,
			ja = 10.666
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
				arg_303_0:Play412031072(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["10076ui_story"].transform
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.var_.moveOldPos10076ui_story = var_306_0.localPosition
			end

			local var_306_2 = 0.001

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2
				local var_306_4 = Vector3.New(-1, -0.35, -4)

				var_306_0.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10076ui_story, var_306_4, var_306_3)

				local var_306_5 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_5.x, var_306_5.y, var_306_5.z)

				local var_306_6 = var_306_0.localEulerAngles

				var_306_6.z = 0
				var_306_6.x = 0
				var_306_0.localEulerAngles = var_306_6
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 then
				var_306_0.localPosition = Vector3.New(-1, -0.35, -4)

				local var_306_7 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_7.x, var_306_7.y, var_306_7.z)

				local var_306_8 = var_306_0.localEulerAngles

				var_306_8.z = 0
				var_306_8.x = 0
				var_306_0.localEulerAngles = var_306_8
			end

			local var_306_9 = arg_303_1.actors_["10076ui_story"]
			local var_306_10 = 0

			if var_306_10 < arg_303_1.time_ and arg_303_1.time_ <= var_306_10 + arg_306_0 and not isNil(var_306_9) and arg_303_1.var_.characterEffect10076ui_story == nil then
				arg_303_1.var_.characterEffect10076ui_story = var_306_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_11 = 0.200000002980232

			if var_306_10 <= arg_303_1.time_ and arg_303_1.time_ < var_306_10 + var_306_11 and not isNil(var_306_9) then
				local var_306_12 = (arg_303_1.time_ - var_306_10) / var_306_11

				if arg_303_1.var_.characterEffect10076ui_story and not isNil(var_306_9) then
					arg_303_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_10 + var_306_11 and arg_303_1.time_ < var_306_10 + var_306_11 + arg_306_0 and not isNil(var_306_9) and arg_303_1.var_.characterEffect10076ui_story then
				arg_303_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_306_13 = 0

			if var_306_13 < arg_303_1.time_ and arg_303_1.time_ <= var_306_13 + arg_306_0 then
				arg_303_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action3_1")
			end

			local var_306_14 = 0

			if var_306_14 < arg_303_1.time_ and arg_303_1.time_ <= var_306_14 + arg_306_0 then
				arg_303_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_306_15 = arg_303_1.actors_["1097ui_story"]
			local var_306_16 = 0

			if var_306_16 < arg_303_1.time_ and arg_303_1.time_ <= var_306_16 + arg_306_0 and not isNil(var_306_15) and arg_303_1.var_.characterEffect1097ui_story == nil then
				arg_303_1.var_.characterEffect1097ui_story = var_306_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_17 = 0.200000002980232

			if var_306_16 <= arg_303_1.time_ and arg_303_1.time_ < var_306_16 + var_306_17 and not isNil(var_306_15) then
				local var_306_18 = (arg_303_1.time_ - var_306_16) / var_306_17

				if arg_303_1.var_.characterEffect1097ui_story and not isNil(var_306_15) then
					local var_306_19 = Mathf.Lerp(0, 0.5, var_306_18)

					arg_303_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1097ui_story.fillRatio = var_306_19
				end
			end

			if arg_303_1.time_ >= var_306_16 + var_306_17 and arg_303_1.time_ < var_306_16 + var_306_17 + arg_306_0 and not isNil(var_306_15) and arg_303_1.var_.characterEffect1097ui_story then
				local var_306_20 = 0.5

				arg_303_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1097ui_story.fillRatio = var_306_20
			end

			local var_306_21 = 0
			local var_306_22 = 1.2

			if var_306_21 < arg_303_1.time_ and arg_303_1.time_ <= var_306_21 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_23 = arg_303_1:FormatText(StoryNameCfg[917].name)

				arg_303_1.leftNameTxt_.text = var_306_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_24 = arg_303_1:GetWordFromCfg(412031071)
				local var_306_25 = arg_303_1:FormatText(var_306_24.content)

				arg_303_1.text_.text = var_306_25

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_26 = 48
				local var_306_27 = utf8.len(var_306_25)
				local var_306_28 = var_306_26 <= 0 and var_306_22 or var_306_22 * (var_306_27 / var_306_26)

				if var_306_28 > 0 and var_306_22 < var_306_28 then
					arg_303_1.talkMaxDuration = var_306_28

					if var_306_28 + var_306_21 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_28 + var_306_21
					end
				end

				arg_303_1.text_.text = var_306_25
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031071", "story_v_out_412031.awb") ~= 0 then
					local var_306_29 = manager.audio:GetVoiceLength("story_v_out_412031", "412031071", "story_v_out_412031.awb") / 1000

					if var_306_29 + var_306_21 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_29 + var_306_21
					end

					if var_306_24.prefab_name ~= "" and arg_303_1.actors_[var_306_24.prefab_name] ~= nil then
						local var_306_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_24.prefab_name].transform, "story_v_out_412031", "412031071", "story_v_out_412031.awb")

						arg_303_1:RecordAudio("412031071", var_306_30)
						arg_303_1:RecordAudio("412031071", var_306_30)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_412031", "412031071", "story_v_out_412031.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_412031", "412031071", "story_v_out_412031.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_31 = math.max(var_306_22, arg_303_1.talkMaxDuration)

			if var_306_21 <= arg_303_1.time_ and arg_303_1.time_ < var_306_21 + var_306_31 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_21) / var_306_31

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_21 + var_306_31 and arg_303_1.time_ < var_306_21 + var_306_31 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play412031072 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 412031072
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play412031073(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["10076ui_story"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect10076ui_story == nil then
				arg_307_1.var_.characterEffect10076ui_story = var_310_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.characterEffect10076ui_story and not isNil(var_310_0) then
					local var_310_4 = Mathf.Lerp(0, 0.5, var_310_3)

					arg_307_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_307_1.var_.characterEffect10076ui_story.fillRatio = var_310_4
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect10076ui_story then
				local var_310_5 = 0.5

				arg_307_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_307_1.var_.characterEffect10076ui_story.fillRatio = var_310_5
			end

			local var_310_6 = 0
			local var_310_7 = 1.3

			if var_310_6 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_8 = arg_307_1:GetWordFromCfg(412031072)
				local var_310_9 = arg_307_1:FormatText(var_310_8.content)

				arg_307_1.text_.text = var_310_9

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_10 = 52
				local var_310_11 = utf8.len(var_310_9)
				local var_310_12 = var_310_10 <= 0 and var_310_7 or var_310_7 * (var_310_11 / var_310_10)

				if var_310_12 > 0 and var_310_7 < var_310_12 then
					arg_307_1.talkMaxDuration = var_310_12

					if var_310_12 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_12 + var_310_6
					end
				end

				arg_307_1.text_.text = var_310_9
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_13 = math.max(var_310_7, arg_307_1.talkMaxDuration)

			if var_310_6 <= arg_307_1.time_ and arg_307_1.time_ < var_310_6 + var_310_13 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_6) / var_310_13

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_6 + var_310_13 and arg_307_1.time_ < var_310_6 + var_310_13 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play412031073 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 412031073
		arg_311_1.duration_ = 9.43

		local var_311_0 = {
			zh = 9.433,
			ja = 7.933
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
				arg_311_0:Play412031074(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1097ui_story"].transform
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.var_.moveOldPos1097ui_story = var_314_0.localPosition
			end

			local var_314_2 = 0.001

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2
				local var_314_4 = Vector3.New(0.7, -0.54, -6.3)

				var_314_0.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1097ui_story, var_314_4, var_314_3)

				local var_314_5 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_5.x, var_314_5.y, var_314_5.z)

				local var_314_6 = var_314_0.localEulerAngles

				var_314_6.z = 0
				var_314_6.x = 0
				var_314_0.localEulerAngles = var_314_6
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 then
				var_314_0.localPosition = Vector3.New(0.7, -0.54, -6.3)

				local var_314_7 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_7.x, var_314_7.y, var_314_7.z)

				local var_314_8 = var_314_0.localEulerAngles

				var_314_8.z = 0
				var_314_8.x = 0
				var_314_0.localEulerAngles = var_314_8
			end

			local var_314_9 = arg_311_1.actors_["1097ui_story"]
			local var_314_10 = 0

			if var_314_10 < arg_311_1.time_ and arg_311_1.time_ <= var_314_10 + arg_314_0 and not isNil(var_314_9) and arg_311_1.var_.characterEffect1097ui_story == nil then
				arg_311_1.var_.characterEffect1097ui_story = var_314_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_11 = 0.200000002980232

			if var_314_10 <= arg_311_1.time_ and arg_311_1.time_ < var_314_10 + var_314_11 and not isNil(var_314_9) then
				local var_314_12 = (arg_311_1.time_ - var_314_10) / var_314_11

				if arg_311_1.var_.characterEffect1097ui_story and not isNil(var_314_9) then
					arg_311_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= var_314_10 + var_314_11 and arg_311_1.time_ < var_314_10 + var_314_11 + arg_314_0 and not isNil(var_314_9) and arg_311_1.var_.characterEffect1097ui_story then
				arg_311_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_314_13 = 0

			if var_314_13 < arg_311_1.time_ and arg_311_1.time_ <= var_314_13 + arg_314_0 then
				arg_311_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_314_14 = 0

			if var_314_14 < arg_311_1.time_ and arg_311_1.time_ <= var_314_14 + arg_314_0 then
				arg_311_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_314_15 = 0
			local var_314_16 = 0.775

			if var_314_15 < arg_311_1.time_ and arg_311_1.time_ <= var_314_15 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_17 = arg_311_1:FormatText(StoryNameCfg[216].name)

				arg_311_1.leftNameTxt_.text = var_314_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_18 = arg_311_1:GetWordFromCfg(412031073)
				local var_314_19 = arg_311_1:FormatText(var_314_18.content)

				arg_311_1.text_.text = var_314_19

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_20 = 31
				local var_314_21 = utf8.len(var_314_19)
				local var_314_22 = var_314_20 <= 0 and var_314_16 or var_314_16 * (var_314_21 / var_314_20)

				if var_314_22 > 0 and var_314_16 < var_314_22 then
					arg_311_1.talkMaxDuration = var_314_22

					if var_314_22 + var_314_15 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_22 + var_314_15
					end
				end

				arg_311_1.text_.text = var_314_19
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031073", "story_v_out_412031.awb") ~= 0 then
					local var_314_23 = manager.audio:GetVoiceLength("story_v_out_412031", "412031073", "story_v_out_412031.awb") / 1000

					if var_314_23 + var_314_15 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_23 + var_314_15
					end

					if var_314_18.prefab_name ~= "" and arg_311_1.actors_[var_314_18.prefab_name] ~= nil then
						local var_314_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_18.prefab_name].transform, "story_v_out_412031", "412031073", "story_v_out_412031.awb")

						arg_311_1:RecordAudio("412031073", var_314_24)
						arg_311_1:RecordAudio("412031073", var_314_24)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_412031", "412031073", "story_v_out_412031.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_412031", "412031073", "story_v_out_412031.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_25 = math.max(var_314_16, arg_311_1.talkMaxDuration)

			if var_314_15 <= arg_311_1.time_ and arg_311_1.time_ < var_314_15 + var_314_25 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_15) / var_314_25

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_15 + var_314_25 and arg_311_1.time_ < var_314_15 + var_314_25 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play412031074 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 412031074
		arg_315_1.duration_ = 14.4

		local var_315_0 = {
			zh = 10.566,
			ja = 14.4
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
				arg_315_0:Play412031075(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0
			local var_318_1 = 0.975

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_2 = arg_315_1:FormatText(StoryNameCfg[216].name)

				arg_315_1.leftNameTxt_.text = var_318_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_3 = arg_315_1:GetWordFromCfg(412031074)
				local var_318_4 = arg_315_1:FormatText(var_318_3.content)

				arg_315_1.text_.text = var_318_4

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 39
				local var_318_6 = utf8.len(var_318_4)
				local var_318_7 = var_318_5 <= 0 and var_318_1 or var_318_1 * (var_318_6 / var_318_5)

				if var_318_7 > 0 and var_318_1 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_0
					end
				end

				arg_315_1.text_.text = var_318_4
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031074", "story_v_out_412031.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031074", "story_v_out_412031.awb") / 1000

					if var_318_8 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_0
					end

					if var_318_3.prefab_name ~= "" and arg_315_1.actors_[var_318_3.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_3.prefab_name].transform, "story_v_out_412031", "412031074", "story_v_out_412031.awb")

						arg_315_1:RecordAudio("412031074", var_318_9)
						arg_315_1:RecordAudio("412031074", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_412031", "412031074", "story_v_out_412031.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_412031", "412031074", "story_v_out_412031.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_10 = math.max(var_318_1, arg_315_1.talkMaxDuration)

			if var_318_0 <= arg_315_1.time_ and arg_315_1.time_ < var_318_0 + var_318_10 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_0) / var_318_10

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_0 + var_318_10 and arg_315_1.time_ < var_318_0 + var_318_10 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play412031075 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 412031075
		arg_319_1.duration_ = 5.97

		local var_319_0 = {
			zh = 5.966,
			ja = 3.5
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
				arg_319_0:Play412031076(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["10076ui_story"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect10076ui_story == nil then
				arg_319_1.var_.characterEffect10076ui_story = var_322_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.characterEffect10076ui_story and not isNil(var_322_0) then
					arg_319_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect10076ui_story then
				arg_319_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_322_4 = 0

			if var_322_4 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action3_2")
			end

			local var_322_5 = 0

			if var_322_5 < arg_319_1.time_ and arg_319_1.time_ <= var_322_5 + arg_322_0 then
				arg_319_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_322_6 = arg_319_1.actors_["1097ui_story"]
			local var_322_7 = 0

			if var_322_7 < arg_319_1.time_ and arg_319_1.time_ <= var_322_7 + arg_322_0 and not isNil(var_322_6) and arg_319_1.var_.characterEffect1097ui_story == nil then
				arg_319_1.var_.characterEffect1097ui_story = var_322_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_8 = 0.200000002980232

			if var_322_7 <= arg_319_1.time_ and arg_319_1.time_ < var_322_7 + var_322_8 and not isNil(var_322_6) then
				local var_322_9 = (arg_319_1.time_ - var_322_7) / var_322_8

				if arg_319_1.var_.characterEffect1097ui_story and not isNil(var_322_6) then
					local var_322_10 = Mathf.Lerp(0, 0.5, var_322_9)

					arg_319_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1097ui_story.fillRatio = var_322_10
				end
			end

			if arg_319_1.time_ >= var_322_7 + var_322_8 and arg_319_1.time_ < var_322_7 + var_322_8 + arg_322_0 and not isNil(var_322_6) and arg_319_1.var_.characterEffect1097ui_story then
				local var_322_11 = 0.5

				arg_319_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1097ui_story.fillRatio = var_322_11
			end

			local var_322_12 = 0
			local var_322_13 = 0.675

			if var_322_12 < arg_319_1.time_ and arg_319_1.time_ <= var_322_12 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_14 = arg_319_1:FormatText(StoryNameCfg[917].name)

				arg_319_1.leftNameTxt_.text = var_322_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_15 = arg_319_1:GetWordFromCfg(412031075)
				local var_322_16 = arg_319_1:FormatText(var_322_15.content)

				arg_319_1.text_.text = var_322_16

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_17 = 27
				local var_322_18 = utf8.len(var_322_16)
				local var_322_19 = var_322_17 <= 0 and var_322_13 or var_322_13 * (var_322_18 / var_322_17)

				if var_322_19 > 0 and var_322_13 < var_322_19 then
					arg_319_1.talkMaxDuration = var_322_19

					if var_322_19 + var_322_12 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_19 + var_322_12
					end
				end

				arg_319_1.text_.text = var_322_16
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031075", "story_v_out_412031.awb") ~= 0 then
					local var_322_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031075", "story_v_out_412031.awb") / 1000

					if var_322_20 + var_322_12 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_20 + var_322_12
					end

					if var_322_15.prefab_name ~= "" and arg_319_1.actors_[var_322_15.prefab_name] ~= nil then
						local var_322_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_15.prefab_name].transform, "story_v_out_412031", "412031075", "story_v_out_412031.awb")

						arg_319_1:RecordAudio("412031075", var_322_21)
						arg_319_1:RecordAudio("412031075", var_322_21)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_412031", "412031075", "story_v_out_412031.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_412031", "412031075", "story_v_out_412031.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_22 = math.max(var_322_13, arg_319_1.talkMaxDuration)

			if var_322_12 <= arg_319_1.time_ and arg_319_1.time_ < var_322_12 + var_322_22 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_12) / var_322_22

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_12 + var_322_22 and arg_319_1.time_ < var_322_12 + var_322_22 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play412031076 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 412031076
		arg_323_1.duration_ = 13.1

		local var_323_0 = {
			zh = 13.1,
			ja = 12
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play412031077(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["10083ui_story"].transform
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.var_.moveOldPos10083ui_story = var_326_0.localPosition
			end

			local var_326_2 = 0.001

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2
				local var_326_4 = Vector3.New(0, -2.6, -2.8)

				var_326_0.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10083ui_story, var_326_4, var_326_3)

				local var_326_5 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_5.x, var_326_5.y, var_326_5.z)

				local var_326_6 = var_326_0.localEulerAngles

				var_326_6.z = 0
				var_326_6.x = 0
				var_326_0.localEulerAngles = var_326_6
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 then
				var_326_0.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_326_7 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_7.x, var_326_7.y, var_326_7.z)

				local var_326_8 = var_326_0.localEulerAngles

				var_326_8.z = 0
				var_326_8.x = 0
				var_326_0.localEulerAngles = var_326_8
			end

			local var_326_9 = arg_323_1.actors_["10083ui_story"]
			local var_326_10 = 0

			if var_326_10 < arg_323_1.time_ and arg_323_1.time_ <= var_326_10 + arg_326_0 and not isNil(var_326_9) and arg_323_1.var_.characterEffect10083ui_story == nil then
				arg_323_1.var_.characterEffect10083ui_story = var_326_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_11 = 0.200000002980232

			if var_326_10 <= arg_323_1.time_ and arg_323_1.time_ < var_326_10 + var_326_11 and not isNil(var_326_9) then
				local var_326_12 = (arg_323_1.time_ - var_326_10) / var_326_11

				if arg_323_1.var_.characterEffect10083ui_story and not isNil(var_326_9) then
					arg_323_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_10 + var_326_11 and arg_323_1.time_ < var_326_10 + var_326_11 + arg_326_0 and not isNil(var_326_9) and arg_323_1.var_.characterEffect10083ui_story then
				arg_323_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_326_13 = 0

			if var_326_13 < arg_323_1.time_ and arg_323_1.time_ <= var_326_13 + arg_326_0 then
				arg_323_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action2_1")
			end

			local var_326_14 = 0

			if var_326_14 < arg_323_1.time_ and arg_323_1.time_ <= var_326_14 + arg_326_0 then
				arg_323_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_326_15 = arg_323_1.actors_["1097ui_story"].transform
			local var_326_16 = 0

			if var_326_16 < arg_323_1.time_ and arg_323_1.time_ <= var_326_16 + arg_326_0 then
				arg_323_1.var_.moveOldPos1097ui_story = var_326_15.localPosition
			end

			local var_326_17 = 0.001

			if var_326_16 <= arg_323_1.time_ and arg_323_1.time_ < var_326_16 + var_326_17 then
				local var_326_18 = (arg_323_1.time_ - var_326_16) / var_326_17
				local var_326_19 = Vector3.New(0, 100, 0)

				var_326_15.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1097ui_story, var_326_19, var_326_18)

				local var_326_20 = manager.ui.mainCamera.transform.position - var_326_15.position

				var_326_15.forward = Vector3.New(var_326_20.x, var_326_20.y, var_326_20.z)

				local var_326_21 = var_326_15.localEulerAngles

				var_326_21.z = 0
				var_326_21.x = 0
				var_326_15.localEulerAngles = var_326_21
			end

			if arg_323_1.time_ >= var_326_16 + var_326_17 and arg_323_1.time_ < var_326_16 + var_326_17 + arg_326_0 then
				var_326_15.localPosition = Vector3.New(0, 100, 0)

				local var_326_22 = manager.ui.mainCamera.transform.position - var_326_15.position

				var_326_15.forward = Vector3.New(var_326_22.x, var_326_22.y, var_326_22.z)

				local var_326_23 = var_326_15.localEulerAngles

				var_326_23.z = 0
				var_326_23.x = 0
				var_326_15.localEulerAngles = var_326_23
			end

			local var_326_24 = arg_323_1.actors_["1097ui_story"]
			local var_326_25 = 0

			if var_326_25 < arg_323_1.time_ and arg_323_1.time_ <= var_326_25 + arg_326_0 and not isNil(var_326_24) and arg_323_1.var_.characterEffect1097ui_story == nil then
				arg_323_1.var_.characterEffect1097ui_story = var_326_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_26 = 0.200000002980232

			if var_326_25 <= arg_323_1.time_ and arg_323_1.time_ < var_326_25 + var_326_26 and not isNil(var_326_24) then
				local var_326_27 = (arg_323_1.time_ - var_326_25) / var_326_26

				if arg_323_1.var_.characterEffect1097ui_story and not isNil(var_326_24) then
					local var_326_28 = Mathf.Lerp(0, 0.5, var_326_27)

					arg_323_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1097ui_story.fillRatio = var_326_28
				end
			end

			if arg_323_1.time_ >= var_326_25 + var_326_26 and arg_323_1.time_ < var_326_25 + var_326_26 + arg_326_0 and not isNil(var_326_24) and arg_323_1.var_.characterEffect1097ui_story then
				local var_326_29 = 0.5

				arg_323_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1097ui_story.fillRatio = var_326_29
			end

			local var_326_30 = arg_323_1.actors_["10076ui_story"].transform
			local var_326_31 = 0

			if var_326_31 < arg_323_1.time_ and arg_323_1.time_ <= var_326_31 + arg_326_0 then
				arg_323_1.var_.moveOldPos10076ui_story = var_326_30.localPosition
			end

			local var_326_32 = 0.001

			if var_326_31 <= arg_323_1.time_ and arg_323_1.time_ < var_326_31 + var_326_32 then
				local var_326_33 = (arg_323_1.time_ - var_326_31) / var_326_32
				local var_326_34 = Vector3.New(0, 100, 0)

				var_326_30.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10076ui_story, var_326_34, var_326_33)

				local var_326_35 = manager.ui.mainCamera.transform.position - var_326_30.position

				var_326_30.forward = Vector3.New(var_326_35.x, var_326_35.y, var_326_35.z)

				local var_326_36 = var_326_30.localEulerAngles

				var_326_36.z = 0
				var_326_36.x = 0
				var_326_30.localEulerAngles = var_326_36
			end

			if arg_323_1.time_ >= var_326_31 + var_326_32 and arg_323_1.time_ < var_326_31 + var_326_32 + arg_326_0 then
				var_326_30.localPosition = Vector3.New(0, 100, 0)

				local var_326_37 = manager.ui.mainCamera.transform.position - var_326_30.position

				var_326_30.forward = Vector3.New(var_326_37.x, var_326_37.y, var_326_37.z)

				local var_326_38 = var_326_30.localEulerAngles

				var_326_38.z = 0
				var_326_38.x = 0
				var_326_30.localEulerAngles = var_326_38
			end

			local var_326_39 = arg_323_1.actors_["10076ui_story"]
			local var_326_40 = 0

			if var_326_40 < arg_323_1.time_ and arg_323_1.time_ <= var_326_40 + arg_326_0 and not isNil(var_326_39) and arg_323_1.var_.characterEffect10076ui_story == nil then
				arg_323_1.var_.characterEffect10076ui_story = var_326_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_41 = 0.200000002980232

			if var_326_40 <= arg_323_1.time_ and arg_323_1.time_ < var_326_40 + var_326_41 and not isNil(var_326_39) then
				local var_326_42 = (arg_323_1.time_ - var_326_40) / var_326_41

				if arg_323_1.var_.characterEffect10076ui_story and not isNil(var_326_39) then
					local var_326_43 = Mathf.Lerp(0, 0.5, var_326_42)

					arg_323_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_323_1.var_.characterEffect10076ui_story.fillRatio = var_326_43
				end
			end

			if arg_323_1.time_ >= var_326_40 + var_326_41 and arg_323_1.time_ < var_326_40 + var_326_41 + arg_326_0 and not isNil(var_326_39) and arg_323_1.var_.characterEffect10076ui_story then
				local var_326_44 = 0.5

				arg_323_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_323_1.var_.characterEffect10076ui_story.fillRatio = var_326_44
			end

			local var_326_45 = 0
			local var_326_46 = 1.675

			if var_326_45 < arg_323_1.time_ and arg_323_1.time_ <= var_326_45 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_47 = arg_323_1:FormatText(StoryNameCfg[918].name)

				arg_323_1.leftNameTxt_.text = var_326_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_48 = arg_323_1:GetWordFromCfg(412031076)
				local var_326_49 = arg_323_1:FormatText(var_326_48.content)

				arg_323_1.text_.text = var_326_49

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_50 = 67
				local var_326_51 = utf8.len(var_326_49)
				local var_326_52 = var_326_50 <= 0 and var_326_46 or var_326_46 * (var_326_51 / var_326_50)

				if var_326_52 > 0 and var_326_46 < var_326_52 then
					arg_323_1.talkMaxDuration = var_326_52

					if var_326_52 + var_326_45 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_52 + var_326_45
					end
				end

				arg_323_1.text_.text = var_326_49
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031076", "story_v_out_412031.awb") ~= 0 then
					local var_326_53 = manager.audio:GetVoiceLength("story_v_out_412031", "412031076", "story_v_out_412031.awb") / 1000

					if var_326_53 + var_326_45 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_53 + var_326_45
					end

					if var_326_48.prefab_name ~= "" and arg_323_1.actors_[var_326_48.prefab_name] ~= nil then
						local var_326_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_48.prefab_name].transform, "story_v_out_412031", "412031076", "story_v_out_412031.awb")

						arg_323_1:RecordAudio("412031076", var_326_54)
						arg_323_1:RecordAudio("412031076", var_326_54)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_412031", "412031076", "story_v_out_412031.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_412031", "412031076", "story_v_out_412031.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_55 = math.max(var_326_46, arg_323_1.talkMaxDuration)

			if var_326_45 <= arg_323_1.time_ and arg_323_1.time_ < var_326_45 + var_326_55 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_45) / var_326_55

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_45 + var_326_55 and arg_323_1.time_ < var_326_45 + var_326_55 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play412031077 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 412031077
		arg_327_1.duration_ = 5.03

		local var_327_0 = {
			zh = 3.433,
			ja = 5.033
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
				arg_327_0:Play412031078(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["10078ui_story"].transform
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.var_.moveOldPos10078ui_story = var_330_0.localPosition
			end

			local var_330_2 = 0.001

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2
				local var_330_4 = Vector3.New(0, -0.5, -6.3)

				var_330_0.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10078ui_story, var_330_4, var_330_3)

				local var_330_5 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_5.x, var_330_5.y, var_330_5.z)

				local var_330_6 = var_330_0.localEulerAngles

				var_330_6.z = 0
				var_330_6.x = 0
				var_330_0.localEulerAngles = var_330_6
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 then
				var_330_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_330_7 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_7.x, var_330_7.y, var_330_7.z)

				local var_330_8 = var_330_0.localEulerAngles

				var_330_8.z = 0
				var_330_8.x = 0
				var_330_0.localEulerAngles = var_330_8
			end

			local var_330_9 = arg_327_1.actors_["10078ui_story"]
			local var_330_10 = 0

			if var_330_10 < arg_327_1.time_ and arg_327_1.time_ <= var_330_10 + arg_330_0 and not isNil(var_330_9) and arg_327_1.var_.characterEffect10078ui_story == nil then
				arg_327_1.var_.characterEffect10078ui_story = var_330_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_11 = 0.200000002980232

			if var_330_10 <= arg_327_1.time_ and arg_327_1.time_ < var_330_10 + var_330_11 and not isNil(var_330_9) then
				local var_330_12 = (arg_327_1.time_ - var_330_10) / var_330_11

				if arg_327_1.var_.characterEffect10078ui_story and not isNil(var_330_9) then
					arg_327_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= var_330_10 + var_330_11 and arg_327_1.time_ < var_330_10 + var_330_11 + arg_330_0 and not isNil(var_330_9) and arg_327_1.var_.characterEffect10078ui_story then
				arg_327_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_330_13 = 0

			if var_330_13 < arg_327_1.time_ and arg_327_1.time_ <= var_330_13 + arg_330_0 then
				arg_327_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_330_14 = 0

			if var_330_14 < arg_327_1.time_ and arg_327_1.time_ <= var_330_14 + arg_330_0 then
				arg_327_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_330_15 = arg_327_1.actors_["10083ui_story"].transform
			local var_330_16 = 0

			if var_330_16 < arg_327_1.time_ and arg_327_1.time_ <= var_330_16 + arg_330_0 then
				arg_327_1.var_.moveOldPos10083ui_story = var_330_15.localPosition
			end

			local var_330_17 = 0.001

			if var_330_16 <= arg_327_1.time_ and arg_327_1.time_ < var_330_16 + var_330_17 then
				local var_330_18 = (arg_327_1.time_ - var_330_16) / var_330_17
				local var_330_19 = Vector3.New(0, 100, 0)

				var_330_15.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10083ui_story, var_330_19, var_330_18)

				local var_330_20 = manager.ui.mainCamera.transform.position - var_330_15.position

				var_330_15.forward = Vector3.New(var_330_20.x, var_330_20.y, var_330_20.z)

				local var_330_21 = var_330_15.localEulerAngles

				var_330_21.z = 0
				var_330_21.x = 0
				var_330_15.localEulerAngles = var_330_21
			end

			if arg_327_1.time_ >= var_330_16 + var_330_17 and arg_327_1.time_ < var_330_16 + var_330_17 + arg_330_0 then
				var_330_15.localPosition = Vector3.New(0, 100, 0)

				local var_330_22 = manager.ui.mainCamera.transform.position - var_330_15.position

				var_330_15.forward = Vector3.New(var_330_22.x, var_330_22.y, var_330_22.z)

				local var_330_23 = var_330_15.localEulerAngles

				var_330_23.z = 0
				var_330_23.x = 0
				var_330_15.localEulerAngles = var_330_23
			end

			local var_330_24 = arg_327_1.actors_["10083ui_story"]
			local var_330_25 = 0

			if var_330_25 < arg_327_1.time_ and arg_327_1.time_ <= var_330_25 + arg_330_0 and not isNil(var_330_24) and arg_327_1.var_.characterEffect10083ui_story == nil then
				arg_327_1.var_.characterEffect10083ui_story = var_330_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_26 = 0.200000002980232

			if var_330_25 <= arg_327_1.time_ and arg_327_1.time_ < var_330_25 + var_330_26 and not isNil(var_330_24) then
				local var_330_27 = (arg_327_1.time_ - var_330_25) / var_330_26

				if arg_327_1.var_.characterEffect10083ui_story and not isNil(var_330_24) then
					local var_330_28 = Mathf.Lerp(0, 0.5, var_330_27)

					arg_327_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_327_1.var_.characterEffect10083ui_story.fillRatio = var_330_28
				end
			end

			if arg_327_1.time_ >= var_330_25 + var_330_26 and arg_327_1.time_ < var_330_25 + var_330_26 + arg_330_0 and not isNil(var_330_24) and arg_327_1.var_.characterEffect10083ui_story then
				local var_330_29 = 0.5

				arg_327_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_327_1.var_.characterEffect10083ui_story.fillRatio = var_330_29
			end

			local var_330_30 = 0
			local var_330_31 = 0.2

			if var_330_30 < arg_327_1.time_ and arg_327_1.time_ <= var_330_30 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_32 = arg_327_1:FormatText(StoryNameCfg[919].name)

				arg_327_1.leftNameTxt_.text = var_330_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_33 = arg_327_1:GetWordFromCfg(412031077)
				local var_330_34 = arg_327_1:FormatText(var_330_33.content)

				arg_327_1.text_.text = var_330_34

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_35 = 8
				local var_330_36 = utf8.len(var_330_34)
				local var_330_37 = var_330_35 <= 0 and var_330_31 or var_330_31 * (var_330_36 / var_330_35)

				if var_330_37 > 0 and var_330_31 < var_330_37 then
					arg_327_1.talkMaxDuration = var_330_37

					if var_330_37 + var_330_30 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_37 + var_330_30
					end
				end

				arg_327_1.text_.text = var_330_34
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031077", "story_v_out_412031.awb") ~= 0 then
					local var_330_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031077", "story_v_out_412031.awb") / 1000

					if var_330_38 + var_330_30 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_38 + var_330_30
					end

					if var_330_33.prefab_name ~= "" and arg_327_1.actors_[var_330_33.prefab_name] ~= nil then
						local var_330_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_33.prefab_name].transform, "story_v_out_412031", "412031077", "story_v_out_412031.awb")

						arg_327_1:RecordAudio("412031077", var_330_39)
						arg_327_1:RecordAudio("412031077", var_330_39)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_412031", "412031077", "story_v_out_412031.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_412031", "412031077", "story_v_out_412031.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_40 = math.max(var_330_31, arg_327_1.talkMaxDuration)

			if var_330_30 <= arg_327_1.time_ and arg_327_1.time_ < var_330_30 + var_330_40 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_30) / var_330_40

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_30 + var_330_40 and arg_327_1.time_ < var_330_30 + var_330_40 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play412031078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 412031078
		arg_331_1.duration_ = 13.57

		local var_331_0 = {
			zh = 8.766,
			ja = 13.566
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play412031079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1097ui_story"].transform
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.var_.moveOldPos1097ui_story = var_334_0.localPosition
			end

			local var_334_2 = 0.001

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2
				local var_334_4 = Vector3.New(0, -0.54, -6.3)

				var_334_0.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1097ui_story, var_334_4, var_334_3)

				local var_334_5 = manager.ui.mainCamera.transform.position - var_334_0.position

				var_334_0.forward = Vector3.New(var_334_5.x, var_334_5.y, var_334_5.z)

				local var_334_6 = var_334_0.localEulerAngles

				var_334_6.z = 0
				var_334_6.x = 0
				var_334_0.localEulerAngles = var_334_6
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 then
				var_334_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_334_7 = manager.ui.mainCamera.transform.position - var_334_0.position

				var_334_0.forward = Vector3.New(var_334_7.x, var_334_7.y, var_334_7.z)

				local var_334_8 = var_334_0.localEulerAngles

				var_334_8.z = 0
				var_334_8.x = 0
				var_334_0.localEulerAngles = var_334_8
			end

			local var_334_9 = arg_331_1.actors_["1097ui_story"]
			local var_334_10 = 0

			if var_334_10 < arg_331_1.time_ and arg_331_1.time_ <= var_334_10 + arg_334_0 and not isNil(var_334_9) and arg_331_1.var_.characterEffect1097ui_story == nil then
				arg_331_1.var_.characterEffect1097ui_story = var_334_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_11 = 0.200000002980232

			if var_334_10 <= arg_331_1.time_ and arg_331_1.time_ < var_334_10 + var_334_11 and not isNil(var_334_9) then
				local var_334_12 = (arg_331_1.time_ - var_334_10) / var_334_11

				if arg_331_1.var_.characterEffect1097ui_story and not isNil(var_334_9) then
					arg_331_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= var_334_10 + var_334_11 and arg_331_1.time_ < var_334_10 + var_334_11 + arg_334_0 and not isNil(var_334_9) and arg_331_1.var_.characterEffect1097ui_story then
				arg_331_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_334_13 = 0

			if var_334_13 < arg_331_1.time_ and arg_331_1.time_ <= var_334_13 + arg_334_0 then
				arg_331_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_334_14 = 0

			if var_334_14 < arg_331_1.time_ and arg_331_1.time_ <= var_334_14 + arg_334_0 then
				arg_331_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_334_15 = arg_331_1.actors_["10078ui_story"].transform
			local var_334_16 = 0

			if var_334_16 < arg_331_1.time_ and arg_331_1.time_ <= var_334_16 + arg_334_0 then
				arg_331_1.var_.moveOldPos10078ui_story = var_334_15.localPosition
			end

			local var_334_17 = 0.001

			if var_334_16 <= arg_331_1.time_ and arg_331_1.time_ < var_334_16 + var_334_17 then
				local var_334_18 = (arg_331_1.time_ - var_334_16) / var_334_17
				local var_334_19 = Vector3.New(0, 100, 0)

				var_334_15.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10078ui_story, var_334_19, var_334_18)

				local var_334_20 = manager.ui.mainCamera.transform.position - var_334_15.position

				var_334_15.forward = Vector3.New(var_334_20.x, var_334_20.y, var_334_20.z)

				local var_334_21 = var_334_15.localEulerAngles

				var_334_21.z = 0
				var_334_21.x = 0
				var_334_15.localEulerAngles = var_334_21
			end

			if arg_331_1.time_ >= var_334_16 + var_334_17 and arg_331_1.time_ < var_334_16 + var_334_17 + arg_334_0 then
				var_334_15.localPosition = Vector3.New(0, 100, 0)

				local var_334_22 = manager.ui.mainCamera.transform.position - var_334_15.position

				var_334_15.forward = Vector3.New(var_334_22.x, var_334_22.y, var_334_22.z)

				local var_334_23 = var_334_15.localEulerAngles

				var_334_23.z = 0
				var_334_23.x = 0
				var_334_15.localEulerAngles = var_334_23
			end

			local var_334_24 = arg_331_1.actors_["10078ui_story"]
			local var_334_25 = 0

			if var_334_25 < arg_331_1.time_ and arg_331_1.time_ <= var_334_25 + arg_334_0 and not isNil(var_334_24) and arg_331_1.var_.characterEffect10078ui_story == nil then
				arg_331_1.var_.characterEffect10078ui_story = var_334_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_26 = 0.200000002980232

			if var_334_25 <= arg_331_1.time_ and arg_331_1.time_ < var_334_25 + var_334_26 and not isNil(var_334_24) then
				local var_334_27 = (arg_331_1.time_ - var_334_25) / var_334_26

				if arg_331_1.var_.characterEffect10078ui_story and not isNil(var_334_24) then
					local var_334_28 = Mathf.Lerp(0, 0.5, var_334_27)

					arg_331_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_331_1.var_.characterEffect10078ui_story.fillRatio = var_334_28
				end
			end

			if arg_331_1.time_ >= var_334_25 + var_334_26 and arg_331_1.time_ < var_334_25 + var_334_26 + arg_334_0 and not isNil(var_334_24) and arg_331_1.var_.characterEffect10078ui_story then
				local var_334_29 = 0.5

				arg_331_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_331_1.var_.characterEffect10078ui_story.fillRatio = var_334_29
			end

			local var_334_30 = 0
			local var_334_31 = 0.85

			if var_334_30 < arg_331_1.time_ and arg_331_1.time_ <= var_334_30 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_32 = arg_331_1:FormatText(StoryNameCfg[216].name)

				arg_331_1.leftNameTxt_.text = var_334_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_33 = arg_331_1:GetWordFromCfg(412031078)
				local var_334_34 = arg_331_1:FormatText(var_334_33.content)

				arg_331_1.text_.text = var_334_34

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_35 = 34
				local var_334_36 = utf8.len(var_334_34)
				local var_334_37 = var_334_35 <= 0 and var_334_31 or var_334_31 * (var_334_36 / var_334_35)

				if var_334_37 > 0 and var_334_31 < var_334_37 then
					arg_331_1.talkMaxDuration = var_334_37

					if var_334_37 + var_334_30 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_37 + var_334_30
					end
				end

				arg_331_1.text_.text = var_334_34
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031078", "story_v_out_412031.awb") ~= 0 then
					local var_334_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031078", "story_v_out_412031.awb") / 1000

					if var_334_38 + var_334_30 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_38 + var_334_30
					end

					if var_334_33.prefab_name ~= "" and arg_331_1.actors_[var_334_33.prefab_name] ~= nil then
						local var_334_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_33.prefab_name].transform, "story_v_out_412031", "412031078", "story_v_out_412031.awb")

						arg_331_1:RecordAudio("412031078", var_334_39)
						arg_331_1:RecordAudio("412031078", var_334_39)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_412031", "412031078", "story_v_out_412031.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_412031", "412031078", "story_v_out_412031.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_40 = math.max(var_334_31, arg_331_1.talkMaxDuration)

			if var_334_30 <= arg_331_1.time_ and arg_331_1.time_ < var_334_30 + var_334_40 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_30) / var_334_40

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_30 + var_334_40 and arg_331_1.time_ < var_334_30 + var_334_40 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play412031079 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 412031079
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play412031080(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1097ui_story"].transform
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.var_.moveOldPos1097ui_story = var_338_0.localPosition
			end

			local var_338_2 = 0.001

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2
				local var_338_4 = Vector3.New(0, 100, 0)

				var_338_0.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1097ui_story, var_338_4, var_338_3)

				local var_338_5 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_5.x, var_338_5.y, var_338_5.z)

				local var_338_6 = var_338_0.localEulerAngles

				var_338_6.z = 0
				var_338_6.x = 0
				var_338_0.localEulerAngles = var_338_6
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 then
				var_338_0.localPosition = Vector3.New(0, 100, 0)

				local var_338_7 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_7.x, var_338_7.y, var_338_7.z)

				local var_338_8 = var_338_0.localEulerAngles

				var_338_8.z = 0
				var_338_8.x = 0
				var_338_0.localEulerAngles = var_338_8
			end

			local var_338_9 = arg_335_1.actors_["1097ui_story"]
			local var_338_10 = 0

			if var_338_10 < arg_335_1.time_ and arg_335_1.time_ <= var_338_10 + arg_338_0 and not isNil(var_338_9) and arg_335_1.var_.characterEffect1097ui_story == nil then
				arg_335_1.var_.characterEffect1097ui_story = var_338_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_11 = 0.200000002980232

			if var_338_10 <= arg_335_1.time_ and arg_335_1.time_ < var_338_10 + var_338_11 and not isNil(var_338_9) then
				local var_338_12 = (arg_335_1.time_ - var_338_10) / var_338_11

				if arg_335_1.var_.characterEffect1097ui_story and not isNil(var_338_9) then
					local var_338_13 = Mathf.Lerp(0, 0.5, var_338_12)

					arg_335_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1097ui_story.fillRatio = var_338_13
				end
			end

			if arg_335_1.time_ >= var_338_10 + var_338_11 and arg_335_1.time_ < var_338_10 + var_338_11 + arg_338_0 and not isNil(var_338_9) and arg_335_1.var_.characterEffect1097ui_story then
				local var_338_14 = 0.5

				arg_335_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1097ui_story.fillRatio = var_338_14
			end

			local var_338_15 = 0
			local var_338_16 = 1.075

			if var_338_15 < arg_335_1.time_ and arg_335_1.time_ <= var_338_15 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_17 = arg_335_1:GetWordFromCfg(412031079)
				local var_338_18 = arg_335_1:FormatText(var_338_17.content)

				arg_335_1.text_.text = var_338_18

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_19 = 43
				local var_338_20 = utf8.len(var_338_18)
				local var_338_21 = var_338_19 <= 0 and var_338_16 or var_338_16 * (var_338_20 / var_338_19)

				if var_338_21 > 0 and var_338_16 < var_338_21 then
					arg_335_1.talkMaxDuration = var_338_21

					if var_338_21 + var_338_15 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_21 + var_338_15
					end
				end

				arg_335_1.text_.text = var_338_18
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_22 = math.max(var_338_16, arg_335_1.talkMaxDuration)

			if var_338_15 <= arg_335_1.time_ and arg_335_1.time_ < var_338_15 + var_338_22 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_15) / var_338_22

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_15 + var_338_22 and arg_335_1.time_ < var_338_15 + var_338_22 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play412031080 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 412031080
		arg_339_1.duration_ = 2

		local var_339_0 = {
			zh = 2,
			ja = 1.999999999999
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
				arg_339_0:Play412031081(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1097ui_story"].transform
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.var_.moveOldPos1097ui_story = var_342_0.localPosition
			end

			local var_342_2 = 0.001

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2
				local var_342_4 = Vector3.New(0, -0.54, -6.3)

				var_342_0.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1097ui_story, var_342_4, var_342_3)

				local var_342_5 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_5.x, var_342_5.y, var_342_5.z)

				local var_342_6 = var_342_0.localEulerAngles

				var_342_6.z = 0
				var_342_6.x = 0
				var_342_0.localEulerAngles = var_342_6
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 then
				var_342_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_342_7 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_7.x, var_342_7.y, var_342_7.z)

				local var_342_8 = var_342_0.localEulerAngles

				var_342_8.z = 0
				var_342_8.x = 0
				var_342_0.localEulerAngles = var_342_8
			end

			local var_342_9 = arg_339_1.actors_["1097ui_story"]
			local var_342_10 = 0

			if var_342_10 < arg_339_1.time_ and arg_339_1.time_ <= var_342_10 + arg_342_0 and not isNil(var_342_9) and arg_339_1.var_.characterEffect1097ui_story == nil then
				arg_339_1.var_.characterEffect1097ui_story = var_342_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_11 = 0.200000002980232

			if var_342_10 <= arg_339_1.time_ and arg_339_1.time_ < var_342_10 + var_342_11 and not isNil(var_342_9) then
				local var_342_12 = (arg_339_1.time_ - var_342_10) / var_342_11

				if arg_339_1.var_.characterEffect1097ui_story and not isNil(var_342_9) then
					arg_339_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_10 + var_342_11 and arg_339_1.time_ < var_342_10 + var_342_11 + arg_342_0 and not isNil(var_342_9) and arg_339_1.var_.characterEffect1097ui_story then
				arg_339_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_342_13 = 0

			if var_342_13 < arg_339_1.time_ and arg_339_1.time_ <= var_342_13 + arg_342_0 then
				arg_339_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_342_14 = 0

			if var_342_14 < arg_339_1.time_ and arg_339_1.time_ <= var_342_14 + arg_342_0 then
				arg_339_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_342_15 = 0
			local var_342_16 = 0.15

			if var_342_15 < arg_339_1.time_ and arg_339_1.time_ <= var_342_15 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_17 = arg_339_1:FormatText(StoryNameCfg[216].name)

				arg_339_1.leftNameTxt_.text = var_342_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_18 = arg_339_1:GetWordFromCfg(412031080)
				local var_342_19 = arg_339_1:FormatText(var_342_18.content)

				arg_339_1.text_.text = var_342_19

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_20 = 6
				local var_342_21 = utf8.len(var_342_19)
				local var_342_22 = var_342_20 <= 0 and var_342_16 or var_342_16 * (var_342_21 / var_342_20)

				if var_342_22 > 0 and var_342_16 < var_342_22 then
					arg_339_1.talkMaxDuration = var_342_22

					if var_342_22 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_22 + var_342_15
					end
				end

				arg_339_1.text_.text = var_342_19
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031080", "story_v_out_412031.awb") ~= 0 then
					local var_342_23 = manager.audio:GetVoiceLength("story_v_out_412031", "412031080", "story_v_out_412031.awb") / 1000

					if var_342_23 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_23 + var_342_15
					end

					if var_342_18.prefab_name ~= "" and arg_339_1.actors_[var_342_18.prefab_name] ~= nil then
						local var_342_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_18.prefab_name].transform, "story_v_out_412031", "412031080", "story_v_out_412031.awb")

						arg_339_1:RecordAudio("412031080", var_342_24)
						arg_339_1:RecordAudio("412031080", var_342_24)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_412031", "412031080", "story_v_out_412031.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_412031", "412031080", "story_v_out_412031.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_25 = math.max(var_342_16, arg_339_1.talkMaxDuration)

			if var_342_15 <= arg_339_1.time_ and arg_339_1.time_ < var_342_15 + var_342_25 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_15) / var_342_25

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_15 + var_342_25 and arg_339_1.time_ < var_342_15 + var_342_25 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play412031081 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 412031081
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play412031082(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1097ui_story"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect1097ui_story == nil then
				arg_343_1.var_.characterEffect1097ui_story = var_346_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.200000002980232

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.characterEffect1097ui_story and not isNil(var_346_0) then
					local var_346_4 = Mathf.Lerp(0, 0.5, var_346_3)

					arg_343_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1097ui_story.fillRatio = var_346_4
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect1097ui_story then
				local var_346_5 = 0.5

				arg_343_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1097ui_story.fillRatio = var_346_5
			end

			local var_346_6 = 0
			local var_346_7 = 1.125

			if var_346_6 < arg_343_1.time_ and arg_343_1.time_ <= var_346_6 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_8 = arg_343_1:GetWordFromCfg(412031081)
				local var_346_9 = arg_343_1:FormatText(var_346_8.content)

				arg_343_1.text_.text = var_346_9

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_10 = 45
				local var_346_11 = utf8.len(var_346_9)
				local var_346_12 = var_346_10 <= 0 and var_346_7 or var_346_7 * (var_346_11 / var_346_10)

				if var_346_12 > 0 and var_346_7 < var_346_12 then
					arg_343_1.talkMaxDuration = var_346_12

					if var_346_12 + var_346_6 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_12 + var_346_6
					end
				end

				arg_343_1.text_.text = var_346_9
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_13 = math.max(var_346_7, arg_343_1.talkMaxDuration)

			if var_346_6 <= arg_343_1.time_ and arg_343_1.time_ < var_346_6 + var_346_13 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_6) / var_346_13

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_6 + var_346_13 and arg_343_1.time_ < var_346_6 + var_346_13 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play412031082 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 412031082
		arg_347_1.duration_ = 3.87

		local var_347_0 = {
			zh = 3.866,
			ja = 3.1
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play412031083(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["10076ui_story"].transform
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.var_.moveOldPos10076ui_story = var_350_0.localPosition
			end

			local var_350_2 = 0.001

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2
				local var_350_4 = Vector3.New(-1, -0.35, -4)

				var_350_0.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10076ui_story, var_350_4, var_350_3)

				local var_350_5 = manager.ui.mainCamera.transform.position - var_350_0.position

				var_350_0.forward = Vector3.New(var_350_5.x, var_350_5.y, var_350_5.z)

				local var_350_6 = var_350_0.localEulerAngles

				var_350_6.z = 0
				var_350_6.x = 0
				var_350_0.localEulerAngles = var_350_6
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 then
				var_350_0.localPosition = Vector3.New(-1, -0.35, -4)

				local var_350_7 = manager.ui.mainCamera.transform.position - var_350_0.position

				var_350_0.forward = Vector3.New(var_350_7.x, var_350_7.y, var_350_7.z)

				local var_350_8 = var_350_0.localEulerAngles

				var_350_8.z = 0
				var_350_8.x = 0
				var_350_0.localEulerAngles = var_350_8
			end

			local var_350_9 = arg_347_1.actors_["10076ui_story"]
			local var_350_10 = 0

			if var_350_10 < arg_347_1.time_ and arg_347_1.time_ <= var_350_10 + arg_350_0 and not isNil(var_350_9) and arg_347_1.var_.characterEffect10076ui_story == nil then
				arg_347_1.var_.characterEffect10076ui_story = var_350_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_11 = 0.200000002980232

			if var_350_10 <= arg_347_1.time_ and arg_347_1.time_ < var_350_10 + var_350_11 and not isNil(var_350_9) then
				local var_350_12 = (arg_347_1.time_ - var_350_10) / var_350_11

				if arg_347_1.var_.characterEffect10076ui_story and not isNil(var_350_9) then
					arg_347_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= var_350_10 + var_350_11 and arg_347_1.time_ < var_350_10 + var_350_11 + arg_350_0 and not isNil(var_350_9) and arg_347_1.var_.characterEffect10076ui_story then
				arg_347_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_350_13 = 0

			if var_350_13 < arg_347_1.time_ and arg_347_1.time_ <= var_350_13 + arg_350_0 then
				arg_347_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			local var_350_14 = 0

			if var_350_14 < arg_347_1.time_ and arg_347_1.time_ <= var_350_14 + arg_350_0 then
				arg_347_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_350_15 = arg_347_1.actors_["1097ui_story"].transform
			local var_350_16 = 0

			if var_350_16 < arg_347_1.time_ and arg_347_1.time_ <= var_350_16 + arg_350_0 then
				arg_347_1.var_.moveOldPos1097ui_story = var_350_15.localPosition
			end

			local var_350_17 = 0.001

			if var_350_16 <= arg_347_1.time_ and arg_347_1.time_ < var_350_16 + var_350_17 then
				local var_350_18 = (arg_347_1.time_ - var_350_16) / var_350_17
				local var_350_19 = Vector3.New(0.7, -0.54, -6.3)

				var_350_15.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1097ui_story, var_350_19, var_350_18)

				local var_350_20 = manager.ui.mainCamera.transform.position - var_350_15.position

				var_350_15.forward = Vector3.New(var_350_20.x, var_350_20.y, var_350_20.z)

				local var_350_21 = var_350_15.localEulerAngles

				var_350_21.z = 0
				var_350_21.x = 0
				var_350_15.localEulerAngles = var_350_21
			end

			if arg_347_1.time_ >= var_350_16 + var_350_17 and arg_347_1.time_ < var_350_16 + var_350_17 + arg_350_0 then
				var_350_15.localPosition = Vector3.New(0.7, -0.54, -6.3)

				local var_350_22 = manager.ui.mainCamera.transform.position - var_350_15.position

				var_350_15.forward = Vector3.New(var_350_22.x, var_350_22.y, var_350_22.z)

				local var_350_23 = var_350_15.localEulerAngles

				var_350_23.z = 0
				var_350_23.x = 0
				var_350_15.localEulerAngles = var_350_23
			end

			local var_350_24 = 0
			local var_350_25 = 0.45

			if var_350_24 < arg_347_1.time_ and arg_347_1.time_ <= var_350_24 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_26 = arg_347_1:FormatText(StoryNameCfg[917].name)

				arg_347_1.leftNameTxt_.text = var_350_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_27 = arg_347_1:GetWordFromCfg(412031082)
				local var_350_28 = arg_347_1:FormatText(var_350_27.content)

				arg_347_1.text_.text = var_350_28

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_29 = 18
				local var_350_30 = utf8.len(var_350_28)
				local var_350_31 = var_350_29 <= 0 and var_350_25 or var_350_25 * (var_350_30 / var_350_29)

				if var_350_31 > 0 and var_350_25 < var_350_31 then
					arg_347_1.talkMaxDuration = var_350_31

					if var_350_31 + var_350_24 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_31 + var_350_24
					end
				end

				arg_347_1.text_.text = var_350_28
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031082", "story_v_out_412031.awb") ~= 0 then
					local var_350_32 = manager.audio:GetVoiceLength("story_v_out_412031", "412031082", "story_v_out_412031.awb") / 1000

					if var_350_32 + var_350_24 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_32 + var_350_24
					end

					if var_350_27.prefab_name ~= "" and arg_347_1.actors_[var_350_27.prefab_name] ~= nil then
						local var_350_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_27.prefab_name].transform, "story_v_out_412031", "412031082", "story_v_out_412031.awb")

						arg_347_1:RecordAudio("412031082", var_350_33)
						arg_347_1:RecordAudio("412031082", var_350_33)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_412031", "412031082", "story_v_out_412031.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_412031", "412031082", "story_v_out_412031.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_34 = math.max(var_350_25, arg_347_1.talkMaxDuration)

			if var_350_24 <= arg_347_1.time_ and arg_347_1.time_ < var_350_24 + var_350_34 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_24) / var_350_34

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_24 + var_350_34 and arg_347_1.time_ < var_350_24 + var_350_34 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play412031083 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 412031083
		arg_351_1.duration_ = 12.67

		local var_351_0 = {
			zh = 6.666,
			ja = 12.666
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play412031084(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1097ui_story"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1097ui_story == nil then
				arg_351_1.var_.characterEffect1097ui_story = var_354_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.characterEffect1097ui_story and not isNil(var_354_0) then
					arg_351_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1097ui_story then
				arg_351_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_354_4 = 0

			if var_354_4 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_354_5 = 0

			if var_354_5 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 then
				arg_351_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_354_6 = arg_351_1.actors_["10076ui_story"]
			local var_354_7 = 0

			if var_354_7 < arg_351_1.time_ and arg_351_1.time_ <= var_354_7 + arg_354_0 and not isNil(var_354_6) and arg_351_1.var_.characterEffect10076ui_story == nil then
				arg_351_1.var_.characterEffect10076ui_story = var_354_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_8 = 0.200000002980232

			if var_354_7 <= arg_351_1.time_ and arg_351_1.time_ < var_354_7 + var_354_8 and not isNil(var_354_6) then
				local var_354_9 = (arg_351_1.time_ - var_354_7) / var_354_8

				if arg_351_1.var_.characterEffect10076ui_story and not isNil(var_354_6) then
					local var_354_10 = Mathf.Lerp(0, 0.5, var_354_9)

					arg_351_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_351_1.var_.characterEffect10076ui_story.fillRatio = var_354_10
				end
			end

			if arg_351_1.time_ >= var_354_7 + var_354_8 and arg_351_1.time_ < var_354_7 + var_354_8 + arg_354_0 and not isNil(var_354_6) and arg_351_1.var_.characterEffect10076ui_story then
				local var_354_11 = 0.5

				arg_351_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_351_1.var_.characterEffect10076ui_story.fillRatio = var_354_11
			end

			local var_354_12 = 0
			local var_354_13 = 0.6

			if var_354_12 < arg_351_1.time_ and arg_351_1.time_ <= var_354_12 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_14 = arg_351_1:FormatText(StoryNameCfg[216].name)

				arg_351_1.leftNameTxt_.text = var_354_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_15 = arg_351_1:GetWordFromCfg(412031083)
				local var_354_16 = arg_351_1:FormatText(var_354_15.content)

				arg_351_1.text_.text = var_354_16

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_17 = 24
				local var_354_18 = utf8.len(var_354_16)
				local var_354_19 = var_354_17 <= 0 and var_354_13 or var_354_13 * (var_354_18 / var_354_17)

				if var_354_19 > 0 and var_354_13 < var_354_19 then
					arg_351_1.talkMaxDuration = var_354_19

					if var_354_19 + var_354_12 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_19 + var_354_12
					end
				end

				arg_351_1.text_.text = var_354_16
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031083", "story_v_out_412031.awb") ~= 0 then
					local var_354_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031083", "story_v_out_412031.awb") / 1000

					if var_354_20 + var_354_12 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_20 + var_354_12
					end

					if var_354_15.prefab_name ~= "" and arg_351_1.actors_[var_354_15.prefab_name] ~= nil then
						local var_354_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_15.prefab_name].transform, "story_v_out_412031", "412031083", "story_v_out_412031.awb")

						arg_351_1:RecordAudio("412031083", var_354_21)
						arg_351_1:RecordAudio("412031083", var_354_21)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_412031", "412031083", "story_v_out_412031.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_412031", "412031083", "story_v_out_412031.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_22 = math.max(var_354_13, arg_351_1.talkMaxDuration)

			if var_354_12 <= arg_351_1.time_ and arg_351_1.time_ < var_354_12 + var_354_22 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_12) / var_354_22

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_12 + var_354_22 and arg_351_1.time_ < var_354_12 + var_354_22 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play412031084 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 412031084
		arg_355_1.duration_ = 5.67

		local var_355_0 = {
			zh = 5.666,
			ja = 2.833
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play412031085(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0
			local var_358_1 = 0.35

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_2 = arg_355_1:FormatText(StoryNameCfg[216].name)

				arg_355_1.leftNameTxt_.text = var_358_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_3 = arg_355_1:GetWordFromCfg(412031084)
				local var_358_4 = arg_355_1:FormatText(var_358_3.content)

				arg_355_1.text_.text = var_358_4

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 14
				local var_358_6 = utf8.len(var_358_4)
				local var_358_7 = var_358_5 <= 0 and var_358_1 or var_358_1 * (var_358_6 / var_358_5)

				if var_358_7 > 0 and var_358_1 < var_358_7 then
					arg_355_1.talkMaxDuration = var_358_7

					if var_358_7 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_7 + var_358_0
					end
				end

				arg_355_1.text_.text = var_358_4
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031084", "story_v_out_412031.awb") ~= 0 then
					local var_358_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031084", "story_v_out_412031.awb") / 1000

					if var_358_8 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_8 + var_358_0
					end

					if var_358_3.prefab_name ~= "" and arg_355_1.actors_[var_358_3.prefab_name] ~= nil then
						local var_358_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_3.prefab_name].transform, "story_v_out_412031", "412031084", "story_v_out_412031.awb")

						arg_355_1:RecordAudio("412031084", var_358_9)
						arg_355_1:RecordAudio("412031084", var_358_9)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_412031", "412031084", "story_v_out_412031.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_412031", "412031084", "story_v_out_412031.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_10 = math.max(var_358_1, arg_355_1.talkMaxDuration)

			if var_358_0 <= arg_355_1.time_ and arg_355_1.time_ < var_358_0 + var_358_10 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_0) / var_358_10

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_0 + var_358_10 and arg_355_1.time_ < var_358_0 + var_358_10 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play412031085 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 412031085
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play412031086(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["10076ui_story"].transform
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.var_.moveOldPos10076ui_story = var_362_0.localPosition
			end

			local var_362_2 = 0.001

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2
				local var_362_4 = Vector3.New(0, 100, 0)

				var_362_0.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10076ui_story, var_362_4, var_362_3)

				local var_362_5 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_5.x, var_362_5.y, var_362_5.z)

				local var_362_6 = var_362_0.localEulerAngles

				var_362_6.z = 0
				var_362_6.x = 0
				var_362_0.localEulerAngles = var_362_6
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 then
				var_362_0.localPosition = Vector3.New(0, 100, 0)

				local var_362_7 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_7.x, var_362_7.y, var_362_7.z)

				local var_362_8 = var_362_0.localEulerAngles

				var_362_8.z = 0
				var_362_8.x = 0
				var_362_0.localEulerAngles = var_362_8
			end

			local var_362_9 = arg_359_1.actors_["10076ui_story"]
			local var_362_10 = 0

			if var_362_10 < arg_359_1.time_ and arg_359_1.time_ <= var_362_10 + arg_362_0 and not isNil(var_362_9) and arg_359_1.var_.characterEffect10076ui_story == nil then
				arg_359_1.var_.characterEffect10076ui_story = var_362_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_11 = 0.200000002980232

			if var_362_10 <= arg_359_1.time_ and arg_359_1.time_ < var_362_10 + var_362_11 and not isNil(var_362_9) then
				local var_362_12 = (arg_359_1.time_ - var_362_10) / var_362_11

				if arg_359_1.var_.characterEffect10076ui_story and not isNil(var_362_9) then
					local var_362_13 = Mathf.Lerp(0, 0.5, var_362_12)

					arg_359_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_359_1.var_.characterEffect10076ui_story.fillRatio = var_362_13
				end
			end

			if arg_359_1.time_ >= var_362_10 + var_362_11 and arg_359_1.time_ < var_362_10 + var_362_11 + arg_362_0 and not isNil(var_362_9) and arg_359_1.var_.characterEffect10076ui_story then
				local var_362_14 = 0.5

				arg_359_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_359_1.var_.characterEffect10076ui_story.fillRatio = var_362_14
			end

			local var_362_15 = arg_359_1.actors_["1097ui_story"].transform
			local var_362_16 = 0

			if var_362_16 < arg_359_1.time_ and arg_359_1.time_ <= var_362_16 + arg_362_0 then
				arg_359_1.var_.moveOldPos1097ui_story = var_362_15.localPosition
			end

			local var_362_17 = 0.001

			if var_362_16 <= arg_359_1.time_ and arg_359_1.time_ < var_362_16 + var_362_17 then
				local var_362_18 = (arg_359_1.time_ - var_362_16) / var_362_17
				local var_362_19 = Vector3.New(0, 100, 0)

				var_362_15.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1097ui_story, var_362_19, var_362_18)

				local var_362_20 = manager.ui.mainCamera.transform.position - var_362_15.position

				var_362_15.forward = Vector3.New(var_362_20.x, var_362_20.y, var_362_20.z)

				local var_362_21 = var_362_15.localEulerAngles

				var_362_21.z = 0
				var_362_21.x = 0
				var_362_15.localEulerAngles = var_362_21
			end

			if arg_359_1.time_ >= var_362_16 + var_362_17 and arg_359_1.time_ < var_362_16 + var_362_17 + arg_362_0 then
				var_362_15.localPosition = Vector3.New(0, 100, 0)

				local var_362_22 = manager.ui.mainCamera.transform.position - var_362_15.position

				var_362_15.forward = Vector3.New(var_362_22.x, var_362_22.y, var_362_22.z)

				local var_362_23 = var_362_15.localEulerAngles

				var_362_23.z = 0
				var_362_23.x = 0
				var_362_15.localEulerAngles = var_362_23
			end

			local var_362_24 = arg_359_1.actors_["1097ui_story"]
			local var_362_25 = 0

			if var_362_25 < arg_359_1.time_ and arg_359_1.time_ <= var_362_25 + arg_362_0 and not isNil(var_362_24) and arg_359_1.var_.characterEffect1097ui_story == nil then
				arg_359_1.var_.characterEffect1097ui_story = var_362_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_26 = 0.200000002980232

			if var_362_25 <= arg_359_1.time_ and arg_359_1.time_ < var_362_25 + var_362_26 and not isNil(var_362_24) then
				local var_362_27 = (arg_359_1.time_ - var_362_25) / var_362_26

				if arg_359_1.var_.characterEffect1097ui_story and not isNil(var_362_24) then
					local var_362_28 = Mathf.Lerp(0, 0.5, var_362_27)

					arg_359_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1097ui_story.fillRatio = var_362_28
				end
			end

			if arg_359_1.time_ >= var_362_25 + var_362_26 and arg_359_1.time_ < var_362_25 + var_362_26 + arg_362_0 and not isNil(var_362_24) and arg_359_1.var_.characterEffect1097ui_story then
				local var_362_29 = 0.5

				arg_359_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1097ui_story.fillRatio = var_362_29
			end

			local var_362_30 = 0
			local var_362_31 = 0.375

			if var_362_30 < arg_359_1.time_ and arg_359_1.time_ <= var_362_30 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_32 = arg_359_1:GetWordFromCfg(412031085)
				local var_362_33 = arg_359_1:FormatText(var_362_32.content)

				arg_359_1.text_.text = var_362_33

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_34 = 15
				local var_362_35 = utf8.len(var_362_33)
				local var_362_36 = var_362_34 <= 0 and var_362_31 or var_362_31 * (var_362_35 / var_362_34)

				if var_362_36 > 0 and var_362_31 < var_362_36 then
					arg_359_1.talkMaxDuration = var_362_36

					if var_362_36 + var_362_30 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_36 + var_362_30
					end
				end

				arg_359_1.text_.text = var_362_33
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_37 = math.max(var_362_31, arg_359_1.talkMaxDuration)

			if var_362_30 <= arg_359_1.time_ and arg_359_1.time_ < var_362_30 + var_362_37 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_30) / var_362_37

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_30 + var_362_37 and arg_359_1.time_ < var_362_30 + var_362_37 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play412031086 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 412031086
		arg_363_1.duration_ = 2.47

		local var_363_0 = {
			zh = 1.999999999999,
			ja = 2.466
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play412031087(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["3043ui_story"].transform
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.var_.moveOldPos3043ui_story = var_366_0.localPosition
			end

			local var_366_2 = 0.001

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2
				local var_366_4 = Vector3.New(0, -1.41, -5.7)

				var_366_0.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos3043ui_story, var_366_4, var_366_3)

				local var_366_5 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_5.x, var_366_5.y, var_366_5.z)

				local var_366_6 = var_366_0.localEulerAngles

				var_366_6.z = 0
				var_366_6.x = 0
				var_366_0.localEulerAngles = var_366_6
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 then
				var_366_0.localPosition = Vector3.New(0, -1.41, -5.7)

				local var_366_7 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_7.x, var_366_7.y, var_366_7.z)

				local var_366_8 = var_366_0.localEulerAngles

				var_366_8.z = 0
				var_366_8.x = 0
				var_366_0.localEulerAngles = var_366_8
			end

			local var_366_9 = arg_363_1.actors_["3043ui_story"]
			local var_366_10 = 0

			if var_366_10 < arg_363_1.time_ and arg_363_1.time_ <= var_366_10 + arg_366_0 and not isNil(var_366_9) and arg_363_1.var_.characterEffect3043ui_story == nil then
				arg_363_1.var_.characterEffect3043ui_story = var_366_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_11 = 0.200000002980232

			if var_366_10 <= arg_363_1.time_ and arg_363_1.time_ < var_366_10 + var_366_11 and not isNil(var_366_9) then
				local var_366_12 = (arg_363_1.time_ - var_366_10) / var_366_11

				if arg_363_1.var_.characterEffect3043ui_story and not isNil(var_366_9) then
					arg_363_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= var_366_10 + var_366_11 and arg_363_1.time_ < var_366_10 + var_366_11 + arg_366_0 and not isNil(var_366_9) and arg_363_1.var_.characterEffect3043ui_story then
				arg_363_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_366_13 = 0

			if var_366_13 < arg_363_1.time_ and arg_363_1.time_ <= var_366_13 + arg_366_0 then
				arg_363_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_366_14 = 0

			if var_366_14 < arg_363_1.time_ and arg_363_1.time_ <= var_366_14 + arg_366_0 then
				arg_363_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_366_15 = 0
			local var_366_16 = 0.15

			if var_366_15 < arg_363_1.time_ and arg_363_1.time_ <= var_366_15 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_17 = arg_363_1:FormatText(StoryNameCfg[920].name)

				arg_363_1.leftNameTxt_.text = var_366_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_18 = arg_363_1:GetWordFromCfg(412031086)
				local var_366_19 = arg_363_1:FormatText(var_366_18.content)

				arg_363_1.text_.text = var_366_19

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_20 = 6
				local var_366_21 = utf8.len(var_366_19)
				local var_366_22 = var_366_20 <= 0 and var_366_16 or var_366_16 * (var_366_21 / var_366_20)

				if var_366_22 > 0 and var_366_16 < var_366_22 then
					arg_363_1.talkMaxDuration = var_366_22

					if var_366_22 + var_366_15 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_22 + var_366_15
					end
				end

				arg_363_1.text_.text = var_366_19
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031086", "story_v_out_412031.awb") ~= 0 then
					local var_366_23 = manager.audio:GetVoiceLength("story_v_out_412031", "412031086", "story_v_out_412031.awb") / 1000

					if var_366_23 + var_366_15 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_23 + var_366_15
					end

					if var_366_18.prefab_name ~= "" and arg_363_1.actors_[var_366_18.prefab_name] ~= nil then
						local var_366_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_18.prefab_name].transform, "story_v_out_412031", "412031086", "story_v_out_412031.awb")

						arg_363_1:RecordAudio("412031086", var_366_24)
						arg_363_1:RecordAudio("412031086", var_366_24)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_412031", "412031086", "story_v_out_412031.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_412031", "412031086", "story_v_out_412031.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_25 = math.max(var_366_16, arg_363_1.talkMaxDuration)

			if var_366_15 <= arg_363_1.time_ and arg_363_1.time_ < var_366_15 + var_366_25 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_15) / var_366_25

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_15 + var_366_25 and arg_363_1.time_ < var_366_15 + var_366_25 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play412031087 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 412031087
		arg_367_1.duration_ = 10.3

		local var_367_0 = {
			zh = 5.966,
			ja = 10.3
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play412031088(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1097ui_story"].transform
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.var_.moveOldPos1097ui_story = var_370_0.localPosition
			end

			local var_370_2 = 0.001

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2
				local var_370_4 = Vector3.New(0.7, -0.54, -6.3)

				var_370_0.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1097ui_story, var_370_4, var_370_3)

				local var_370_5 = manager.ui.mainCamera.transform.position - var_370_0.position

				var_370_0.forward = Vector3.New(var_370_5.x, var_370_5.y, var_370_5.z)

				local var_370_6 = var_370_0.localEulerAngles

				var_370_6.z = 0
				var_370_6.x = 0
				var_370_0.localEulerAngles = var_370_6
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 then
				var_370_0.localPosition = Vector3.New(0.7, -0.54, -6.3)

				local var_370_7 = manager.ui.mainCamera.transform.position - var_370_0.position

				var_370_0.forward = Vector3.New(var_370_7.x, var_370_7.y, var_370_7.z)

				local var_370_8 = var_370_0.localEulerAngles

				var_370_8.z = 0
				var_370_8.x = 0
				var_370_0.localEulerAngles = var_370_8
			end

			local var_370_9 = arg_367_1.actors_["1097ui_story"]
			local var_370_10 = 0

			if var_370_10 < arg_367_1.time_ and arg_367_1.time_ <= var_370_10 + arg_370_0 and not isNil(var_370_9) and arg_367_1.var_.characterEffect1097ui_story == nil then
				arg_367_1.var_.characterEffect1097ui_story = var_370_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_11 = 0.200000002980232

			if var_370_10 <= arg_367_1.time_ and arg_367_1.time_ < var_370_10 + var_370_11 and not isNil(var_370_9) then
				local var_370_12 = (arg_367_1.time_ - var_370_10) / var_370_11

				if arg_367_1.var_.characterEffect1097ui_story and not isNil(var_370_9) then
					arg_367_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= var_370_10 + var_370_11 and arg_367_1.time_ < var_370_10 + var_370_11 + arg_370_0 and not isNil(var_370_9) and arg_367_1.var_.characterEffect1097ui_story then
				arg_367_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_370_13 = 0

			if var_370_13 < arg_367_1.time_ and arg_367_1.time_ <= var_370_13 + arg_370_0 then
				arg_367_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_370_14 = 0

			if var_370_14 < arg_367_1.time_ and arg_367_1.time_ <= var_370_14 + arg_370_0 then
				arg_367_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_370_15 = arg_367_1.actors_["3043ui_story"]
			local var_370_16 = 0

			if var_370_16 < arg_367_1.time_ and arg_367_1.time_ <= var_370_16 + arg_370_0 and not isNil(var_370_15) and arg_367_1.var_.characterEffect3043ui_story == nil then
				arg_367_1.var_.characterEffect3043ui_story = var_370_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_17 = 0.200000002980232

			if var_370_16 <= arg_367_1.time_ and arg_367_1.time_ < var_370_16 + var_370_17 and not isNil(var_370_15) then
				local var_370_18 = (arg_367_1.time_ - var_370_16) / var_370_17

				if arg_367_1.var_.characterEffect3043ui_story and not isNil(var_370_15) then
					local var_370_19 = Mathf.Lerp(0, 0.5, var_370_18)

					arg_367_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_367_1.var_.characterEffect3043ui_story.fillRatio = var_370_19
				end
			end

			if arg_367_1.time_ >= var_370_16 + var_370_17 and arg_367_1.time_ < var_370_16 + var_370_17 + arg_370_0 and not isNil(var_370_15) and arg_367_1.var_.characterEffect3043ui_story then
				local var_370_20 = 0.5

				arg_367_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_367_1.var_.characterEffect3043ui_story.fillRatio = var_370_20
			end

			local var_370_21 = arg_367_1.actors_["3043ui_story"].transform
			local var_370_22 = 0

			if var_370_22 < arg_367_1.time_ and arg_367_1.time_ <= var_370_22 + arg_370_0 then
				arg_367_1.var_.moveOldPos3043ui_story = var_370_21.localPosition
			end

			local var_370_23 = 0.001

			if var_370_22 <= arg_367_1.time_ and arg_367_1.time_ < var_370_22 + var_370_23 then
				local var_370_24 = (arg_367_1.time_ - var_370_22) / var_370_23
				local var_370_25 = Vector3.New(-0.7, -1.41, -5.7)

				var_370_21.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos3043ui_story, var_370_25, var_370_24)

				local var_370_26 = manager.ui.mainCamera.transform.position - var_370_21.position

				var_370_21.forward = Vector3.New(var_370_26.x, var_370_26.y, var_370_26.z)

				local var_370_27 = var_370_21.localEulerAngles

				var_370_27.z = 0
				var_370_27.x = 0
				var_370_21.localEulerAngles = var_370_27
			end

			if arg_367_1.time_ >= var_370_22 + var_370_23 and arg_367_1.time_ < var_370_22 + var_370_23 + arg_370_0 then
				var_370_21.localPosition = Vector3.New(-0.7, -1.41, -5.7)

				local var_370_28 = manager.ui.mainCamera.transform.position - var_370_21.position

				var_370_21.forward = Vector3.New(var_370_28.x, var_370_28.y, var_370_28.z)

				local var_370_29 = var_370_21.localEulerAngles

				var_370_29.z = 0
				var_370_29.x = 0
				var_370_21.localEulerAngles = var_370_29
			end

			local var_370_30 = 0
			local var_370_31 = 0.525

			if var_370_30 < arg_367_1.time_ and arg_367_1.time_ <= var_370_30 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_32 = arg_367_1:FormatText(StoryNameCfg[216].name)

				arg_367_1.leftNameTxt_.text = var_370_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_33 = arg_367_1:GetWordFromCfg(412031087)
				local var_370_34 = arg_367_1:FormatText(var_370_33.content)

				arg_367_1.text_.text = var_370_34

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_35 = 21
				local var_370_36 = utf8.len(var_370_34)
				local var_370_37 = var_370_35 <= 0 and var_370_31 or var_370_31 * (var_370_36 / var_370_35)

				if var_370_37 > 0 and var_370_31 < var_370_37 then
					arg_367_1.talkMaxDuration = var_370_37

					if var_370_37 + var_370_30 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_37 + var_370_30
					end
				end

				arg_367_1.text_.text = var_370_34
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031087", "story_v_out_412031.awb") ~= 0 then
					local var_370_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031087", "story_v_out_412031.awb") / 1000

					if var_370_38 + var_370_30 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_38 + var_370_30
					end

					if var_370_33.prefab_name ~= "" and arg_367_1.actors_[var_370_33.prefab_name] ~= nil then
						local var_370_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_33.prefab_name].transform, "story_v_out_412031", "412031087", "story_v_out_412031.awb")

						arg_367_1:RecordAudio("412031087", var_370_39)
						arg_367_1:RecordAudio("412031087", var_370_39)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_412031", "412031087", "story_v_out_412031.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_412031", "412031087", "story_v_out_412031.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_40 = math.max(var_370_31, arg_367_1.talkMaxDuration)

			if var_370_30 <= arg_367_1.time_ and arg_367_1.time_ < var_370_30 + var_370_40 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_30) / var_370_40

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_30 + var_370_40 and arg_367_1.time_ < var_370_30 + var_370_40 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play412031088 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 412031088
		arg_371_1.duration_ = 7.27

		local var_371_0 = {
			zh = 3.333,
			ja = 7.266
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play412031089(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["3043ui_story"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect3043ui_story == nil then
				arg_371_1.var_.characterEffect3043ui_story = var_374_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 and not isNil(var_374_0) then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.characterEffect3043ui_story and not isNil(var_374_0) then
					arg_371_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect3043ui_story then
				arg_371_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_374_4 = 0

			if var_374_4 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_374_5 = 0

			if var_374_5 < arg_371_1.time_ and arg_371_1.time_ <= var_374_5 + arg_374_0 then
				arg_371_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_374_6 = arg_371_1.actors_["1097ui_story"]
			local var_374_7 = 0

			if var_374_7 < arg_371_1.time_ and arg_371_1.time_ <= var_374_7 + arg_374_0 and not isNil(var_374_6) and arg_371_1.var_.characterEffect1097ui_story == nil then
				arg_371_1.var_.characterEffect1097ui_story = var_374_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_8 = 0.200000002980232

			if var_374_7 <= arg_371_1.time_ and arg_371_1.time_ < var_374_7 + var_374_8 and not isNil(var_374_6) then
				local var_374_9 = (arg_371_1.time_ - var_374_7) / var_374_8

				if arg_371_1.var_.characterEffect1097ui_story and not isNil(var_374_6) then
					local var_374_10 = Mathf.Lerp(0, 0.5, var_374_9)

					arg_371_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1097ui_story.fillRatio = var_374_10
				end
			end

			if arg_371_1.time_ >= var_374_7 + var_374_8 and arg_371_1.time_ < var_374_7 + var_374_8 + arg_374_0 and not isNil(var_374_6) and arg_371_1.var_.characterEffect1097ui_story then
				local var_374_11 = 0.5

				arg_371_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1097ui_story.fillRatio = var_374_11
			end

			local var_374_12 = 0
			local var_374_13 = 0.275

			if var_374_12 < arg_371_1.time_ and arg_371_1.time_ <= var_374_12 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_14 = arg_371_1:FormatText(StoryNameCfg[920].name)

				arg_371_1.leftNameTxt_.text = var_374_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_15 = arg_371_1:GetWordFromCfg(412031088)
				local var_374_16 = arg_371_1:FormatText(var_374_15.content)

				arg_371_1.text_.text = var_374_16

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_17 = 11
				local var_374_18 = utf8.len(var_374_16)
				local var_374_19 = var_374_17 <= 0 and var_374_13 or var_374_13 * (var_374_18 / var_374_17)

				if var_374_19 > 0 and var_374_13 < var_374_19 then
					arg_371_1.talkMaxDuration = var_374_19

					if var_374_19 + var_374_12 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_19 + var_374_12
					end
				end

				arg_371_1.text_.text = var_374_16
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031088", "story_v_out_412031.awb") ~= 0 then
					local var_374_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031088", "story_v_out_412031.awb") / 1000

					if var_374_20 + var_374_12 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_20 + var_374_12
					end

					if var_374_15.prefab_name ~= "" and arg_371_1.actors_[var_374_15.prefab_name] ~= nil then
						local var_374_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_15.prefab_name].transform, "story_v_out_412031", "412031088", "story_v_out_412031.awb")

						arg_371_1:RecordAudio("412031088", var_374_21)
						arg_371_1:RecordAudio("412031088", var_374_21)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_412031", "412031088", "story_v_out_412031.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_412031", "412031088", "story_v_out_412031.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_22 = math.max(var_374_13, arg_371_1.talkMaxDuration)

			if var_374_12 <= arg_371_1.time_ and arg_371_1.time_ < var_374_12 + var_374_22 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_12) / var_374_22

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_12 + var_374_22 and arg_371_1.time_ < var_374_12 + var_374_22 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play412031089 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 412031089
		arg_375_1.duration_ = 3.93

		local var_375_0 = {
			zh = 2.633,
			ja = 3.933
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play412031090(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1097ui_story"]
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.characterEffect1097ui_story == nil then
				arg_375_1.var_.characterEffect1097ui_story = var_378_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 and not isNil(var_378_0) then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2

				if arg_375_1.var_.characterEffect1097ui_story and not isNil(var_378_0) then
					arg_375_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.characterEffect1097ui_story then
				arg_375_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_378_4 = 0

			if var_378_4 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_378_5 = 0

			if var_378_5 < arg_375_1.time_ and arg_375_1.time_ <= var_378_5 + arg_378_0 then
				arg_375_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_378_6 = arg_375_1.actors_["3043ui_story"]
			local var_378_7 = 0

			if var_378_7 < arg_375_1.time_ and arg_375_1.time_ <= var_378_7 + arg_378_0 and not isNil(var_378_6) and arg_375_1.var_.characterEffect3043ui_story == nil then
				arg_375_1.var_.characterEffect3043ui_story = var_378_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_8 = 0.200000002980232

			if var_378_7 <= arg_375_1.time_ and arg_375_1.time_ < var_378_7 + var_378_8 and not isNil(var_378_6) then
				local var_378_9 = (arg_375_1.time_ - var_378_7) / var_378_8

				if arg_375_1.var_.characterEffect3043ui_story and not isNil(var_378_6) then
					local var_378_10 = Mathf.Lerp(0, 0.5, var_378_9)

					arg_375_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_375_1.var_.characterEffect3043ui_story.fillRatio = var_378_10
				end
			end

			if arg_375_1.time_ >= var_378_7 + var_378_8 and arg_375_1.time_ < var_378_7 + var_378_8 + arg_378_0 and not isNil(var_378_6) and arg_375_1.var_.characterEffect3043ui_story then
				local var_378_11 = 0.5

				arg_375_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_375_1.var_.characterEffect3043ui_story.fillRatio = var_378_11
			end

			local var_378_12 = 0
			local var_378_13 = 0.175

			if var_378_12 < arg_375_1.time_ and arg_375_1.time_ <= var_378_12 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_14 = arg_375_1:FormatText(StoryNameCfg[216].name)

				arg_375_1.leftNameTxt_.text = var_378_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_15 = arg_375_1:GetWordFromCfg(412031089)
				local var_378_16 = arg_375_1:FormatText(var_378_15.content)

				arg_375_1.text_.text = var_378_16

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_17 = 7
				local var_378_18 = utf8.len(var_378_16)
				local var_378_19 = var_378_17 <= 0 and var_378_13 or var_378_13 * (var_378_18 / var_378_17)

				if var_378_19 > 0 and var_378_13 < var_378_19 then
					arg_375_1.talkMaxDuration = var_378_19

					if var_378_19 + var_378_12 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_19 + var_378_12
					end
				end

				arg_375_1.text_.text = var_378_16
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031089", "story_v_out_412031.awb") ~= 0 then
					local var_378_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031089", "story_v_out_412031.awb") / 1000

					if var_378_20 + var_378_12 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_20 + var_378_12
					end

					if var_378_15.prefab_name ~= "" and arg_375_1.actors_[var_378_15.prefab_name] ~= nil then
						local var_378_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_15.prefab_name].transform, "story_v_out_412031", "412031089", "story_v_out_412031.awb")

						arg_375_1:RecordAudio("412031089", var_378_21)
						arg_375_1:RecordAudio("412031089", var_378_21)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_412031", "412031089", "story_v_out_412031.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_412031", "412031089", "story_v_out_412031.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_22 = math.max(var_378_13, arg_375_1.talkMaxDuration)

			if var_378_12 <= arg_375_1.time_ and arg_375_1.time_ < var_378_12 + var_378_22 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_12) / var_378_22

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_12 + var_378_22 and arg_375_1.time_ < var_378_12 + var_378_22 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play412031090 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 412031090
		arg_379_1.duration_ = 7.9

		local var_379_0 = {
			zh = 5.9,
			ja = 7.9
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play412031091(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["3043ui_story"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect3043ui_story == nil then
				arg_379_1.var_.characterEffect3043ui_story = var_382_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.characterEffect3043ui_story and not isNil(var_382_0) then
					arg_379_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect3043ui_story then
				arg_379_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_382_4 = 0

			if var_382_4 < arg_379_1.time_ and arg_379_1.time_ <= var_382_4 + arg_382_0 then
				arg_379_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_382_5 = 0

			if var_382_5 < arg_379_1.time_ and arg_379_1.time_ <= var_382_5 + arg_382_0 then
				arg_379_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_382_6 = arg_379_1.actors_["1097ui_story"]
			local var_382_7 = 0

			if var_382_7 < arg_379_1.time_ and arg_379_1.time_ <= var_382_7 + arg_382_0 and not isNil(var_382_6) and arg_379_1.var_.characterEffect1097ui_story == nil then
				arg_379_1.var_.characterEffect1097ui_story = var_382_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_8 = 0.200000002980232

			if var_382_7 <= arg_379_1.time_ and arg_379_1.time_ < var_382_7 + var_382_8 and not isNil(var_382_6) then
				local var_382_9 = (arg_379_1.time_ - var_382_7) / var_382_8

				if arg_379_1.var_.characterEffect1097ui_story and not isNil(var_382_6) then
					local var_382_10 = Mathf.Lerp(0, 0.5, var_382_9)

					arg_379_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1097ui_story.fillRatio = var_382_10
				end
			end

			if arg_379_1.time_ >= var_382_7 + var_382_8 and arg_379_1.time_ < var_382_7 + var_382_8 + arg_382_0 and not isNil(var_382_6) and arg_379_1.var_.characterEffect1097ui_story then
				local var_382_11 = 0.5

				arg_379_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1097ui_story.fillRatio = var_382_11
			end

			local var_382_12 = 0
			local var_382_13 = 0.55

			if var_382_12 < arg_379_1.time_ and arg_379_1.time_ <= var_382_12 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_14 = arg_379_1:FormatText(StoryNameCfg[920].name)

				arg_379_1.leftNameTxt_.text = var_382_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_15 = arg_379_1:GetWordFromCfg(412031090)
				local var_382_16 = arg_379_1:FormatText(var_382_15.content)

				arg_379_1.text_.text = var_382_16

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_17 = 22
				local var_382_18 = utf8.len(var_382_16)
				local var_382_19 = var_382_17 <= 0 and var_382_13 or var_382_13 * (var_382_18 / var_382_17)

				if var_382_19 > 0 and var_382_13 < var_382_19 then
					arg_379_1.talkMaxDuration = var_382_19

					if var_382_19 + var_382_12 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_19 + var_382_12
					end
				end

				arg_379_1.text_.text = var_382_16
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031090", "story_v_out_412031.awb") ~= 0 then
					local var_382_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031090", "story_v_out_412031.awb") / 1000

					if var_382_20 + var_382_12 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_20 + var_382_12
					end

					if var_382_15.prefab_name ~= "" and arg_379_1.actors_[var_382_15.prefab_name] ~= nil then
						local var_382_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_15.prefab_name].transform, "story_v_out_412031", "412031090", "story_v_out_412031.awb")

						arg_379_1:RecordAudio("412031090", var_382_21)
						arg_379_1:RecordAudio("412031090", var_382_21)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_412031", "412031090", "story_v_out_412031.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_412031", "412031090", "story_v_out_412031.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_22 = math.max(var_382_13, arg_379_1.talkMaxDuration)

			if var_382_12 <= arg_379_1.time_ and arg_379_1.time_ < var_382_12 + var_382_22 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_12) / var_382_22

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_12 + var_382_22 and arg_379_1.time_ < var_382_12 + var_382_22 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play412031091 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 412031091
		arg_383_1.duration_ = 8.53

		local var_383_0 = {
			zh = 4.966,
			ja = 8.533
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play412031092(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["10078ui_story"].transform
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.var_.moveOldPos10078ui_story = var_386_0.localPosition
			end

			local var_386_2 = 0.001

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2
				local var_386_4 = Vector3.New(0, -0.5, -6.3)

				var_386_0.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10078ui_story, var_386_4, var_386_3)

				local var_386_5 = manager.ui.mainCamera.transform.position - var_386_0.position

				var_386_0.forward = Vector3.New(var_386_5.x, var_386_5.y, var_386_5.z)

				local var_386_6 = var_386_0.localEulerAngles

				var_386_6.z = 0
				var_386_6.x = 0
				var_386_0.localEulerAngles = var_386_6
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 then
				var_386_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_386_7 = manager.ui.mainCamera.transform.position - var_386_0.position

				var_386_0.forward = Vector3.New(var_386_7.x, var_386_7.y, var_386_7.z)

				local var_386_8 = var_386_0.localEulerAngles

				var_386_8.z = 0
				var_386_8.x = 0
				var_386_0.localEulerAngles = var_386_8
			end

			local var_386_9 = arg_383_1.actors_["10078ui_story"]
			local var_386_10 = 0

			if var_386_10 < arg_383_1.time_ and arg_383_1.time_ <= var_386_10 + arg_386_0 and not isNil(var_386_9) and arg_383_1.var_.characterEffect10078ui_story == nil then
				arg_383_1.var_.characterEffect10078ui_story = var_386_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_11 = 0.200000002980232

			if var_386_10 <= arg_383_1.time_ and arg_383_1.time_ < var_386_10 + var_386_11 and not isNil(var_386_9) then
				local var_386_12 = (arg_383_1.time_ - var_386_10) / var_386_11

				if arg_383_1.var_.characterEffect10078ui_story and not isNil(var_386_9) then
					arg_383_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= var_386_10 + var_386_11 and arg_383_1.time_ < var_386_10 + var_386_11 + arg_386_0 and not isNil(var_386_9) and arg_383_1.var_.characterEffect10078ui_story then
				arg_383_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_386_13 = 0

			if var_386_13 < arg_383_1.time_ and arg_383_1.time_ <= var_386_13 + arg_386_0 then
				arg_383_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_386_14 = 0

			if var_386_14 < arg_383_1.time_ and arg_383_1.time_ <= var_386_14 + arg_386_0 then
				arg_383_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_386_15 = arg_383_1.actors_["1097ui_story"].transform
			local var_386_16 = 0

			if var_386_16 < arg_383_1.time_ and arg_383_1.time_ <= var_386_16 + arg_386_0 then
				arg_383_1.var_.moveOldPos1097ui_story = var_386_15.localPosition
			end

			local var_386_17 = 0.001

			if var_386_16 <= arg_383_1.time_ and arg_383_1.time_ < var_386_16 + var_386_17 then
				local var_386_18 = (arg_383_1.time_ - var_386_16) / var_386_17
				local var_386_19 = Vector3.New(0, 100, 0)

				var_386_15.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1097ui_story, var_386_19, var_386_18)

				local var_386_20 = manager.ui.mainCamera.transform.position - var_386_15.position

				var_386_15.forward = Vector3.New(var_386_20.x, var_386_20.y, var_386_20.z)

				local var_386_21 = var_386_15.localEulerAngles

				var_386_21.z = 0
				var_386_21.x = 0
				var_386_15.localEulerAngles = var_386_21
			end

			if arg_383_1.time_ >= var_386_16 + var_386_17 and arg_383_1.time_ < var_386_16 + var_386_17 + arg_386_0 then
				var_386_15.localPosition = Vector3.New(0, 100, 0)

				local var_386_22 = manager.ui.mainCamera.transform.position - var_386_15.position

				var_386_15.forward = Vector3.New(var_386_22.x, var_386_22.y, var_386_22.z)

				local var_386_23 = var_386_15.localEulerAngles

				var_386_23.z = 0
				var_386_23.x = 0
				var_386_15.localEulerAngles = var_386_23
			end

			local var_386_24 = arg_383_1.actors_["1097ui_story"]
			local var_386_25 = 0

			if var_386_25 < arg_383_1.time_ and arg_383_1.time_ <= var_386_25 + arg_386_0 and not isNil(var_386_24) and arg_383_1.var_.characterEffect1097ui_story == nil then
				arg_383_1.var_.characterEffect1097ui_story = var_386_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_26 = 0.200000002980232

			if var_386_25 <= arg_383_1.time_ and arg_383_1.time_ < var_386_25 + var_386_26 and not isNil(var_386_24) then
				local var_386_27 = (arg_383_1.time_ - var_386_25) / var_386_26

				if arg_383_1.var_.characterEffect1097ui_story and not isNil(var_386_24) then
					local var_386_28 = Mathf.Lerp(0, 0.5, var_386_27)

					arg_383_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1097ui_story.fillRatio = var_386_28
				end
			end

			if arg_383_1.time_ >= var_386_25 + var_386_26 and arg_383_1.time_ < var_386_25 + var_386_26 + arg_386_0 and not isNil(var_386_24) and arg_383_1.var_.characterEffect1097ui_story then
				local var_386_29 = 0.5

				arg_383_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1097ui_story.fillRatio = var_386_29
			end

			local var_386_30 = arg_383_1.actors_["3043ui_story"].transform
			local var_386_31 = 0

			if var_386_31 < arg_383_1.time_ and arg_383_1.time_ <= var_386_31 + arg_386_0 then
				arg_383_1.var_.moveOldPos3043ui_story = var_386_30.localPosition
			end

			local var_386_32 = 0.001

			if var_386_31 <= arg_383_1.time_ and arg_383_1.time_ < var_386_31 + var_386_32 then
				local var_386_33 = (arg_383_1.time_ - var_386_31) / var_386_32
				local var_386_34 = Vector3.New(0, 100, 0)

				var_386_30.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos3043ui_story, var_386_34, var_386_33)

				local var_386_35 = manager.ui.mainCamera.transform.position - var_386_30.position

				var_386_30.forward = Vector3.New(var_386_35.x, var_386_35.y, var_386_35.z)

				local var_386_36 = var_386_30.localEulerAngles

				var_386_36.z = 0
				var_386_36.x = 0
				var_386_30.localEulerAngles = var_386_36
			end

			if arg_383_1.time_ >= var_386_31 + var_386_32 and arg_383_1.time_ < var_386_31 + var_386_32 + arg_386_0 then
				var_386_30.localPosition = Vector3.New(0, 100, 0)

				local var_386_37 = manager.ui.mainCamera.transform.position - var_386_30.position

				var_386_30.forward = Vector3.New(var_386_37.x, var_386_37.y, var_386_37.z)

				local var_386_38 = var_386_30.localEulerAngles

				var_386_38.z = 0
				var_386_38.x = 0
				var_386_30.localEulerAngles = var_386_38
			end

			local var_386_39 = arg_383_1.actors_["3043ui_story"]
			local var_386_40 = 0

			if var_386_40 < arg_383_1.time_ and arg_383_1.time_ <= var_386_40 + arg_386_0 and not isNil(var_386_39) and arg_383_1.var_.characterEffect3043ui_story == nil then
				arg_383_1.var_.characterEffect3043ui_story = var_386_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_41 = 0.200000002980232

			if var_386_40 <= arg_383_1.time_ and arg_383_1.time_ < var_386_40 + var_386_41 and not isNil(var_386_39) then
				local var_386_42 = (arg_383_1.time_ - var_386_40) / var_386_41

				if arg_383_1.var_.characterEffect3043ui_story and not isNil(var_386_39) then
					local var_386_43 = Mathf.Lerp(0, 0.5, var_386_42)

					arg_383_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_383_1.var_.characterEffect3043ui_story.fillRatio = var_386_43
				end
			end

			if arg_383_1.time_ >= var_386_40 + var_386_41 and arg_383_1.time_ < var_386_40 + var_386_41 + arg_386_0 and not isNil(var_386_39) and arg_383_1.var_.characterEffect3043ui_story then
				local var_386_44 = 0.5

				arg_383_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_383_1.var_.characterEffect3043ui_story.fillRatio = var_386_44
			end

			local var_386_45 = 0
			local var_386_46 = 0.475

			if var_386_45 < arg_383_1.time_ and arg_383_1.time_ <= var_386_45 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_47 = arg_383_1:FormatText(StoryNameCfg[919].name)

				arg_383_1.leftNameTxt_.text = var_386_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_48 = arg_383_1:GetWordFromCfg(412031091)
				local var_386_49 = arg_383_1:FormatText(var_386_48.content)

				arg_383_1.text_.text = var_386_49

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_50 = 19
				local var_386_51 = utf8.len(var_386_49)
				local var_386_52 = var_386_50 <= 0 and var_386_46 or var_386_46 * (var_386_51 / var_386_50)

				if var_386_52 > 0 and var_386_46 < var_386_52 then
					arg_383_1.talkMaxDuration = var_386_52

					if var_386_52 + var_386_45 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_52 + var_386_45
					end
				end

				arg_383_1.text_.text = var_386_49
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031091", "story_v_out_412031.awb") ~= 0 then
					local var_386_53 = manager.audio:GetVoiceLength("story_v_out_412031", "412031091", "story_v_out_412031.awb") / 1000

					if var_386_53 + var_386_45 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_53 + var_386_45
					end

					if var_386_48.prefab_name ~= "" and arg_383_1.actors_[var_386_48.prefab_name] ~= nil then
						local var_386_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_48.prefab_name].transform, "story_v_out_412031", "412031091", "story_v_out_412031.awb")

						arg_383_1:RecordAudio("412031091", var_386_54)
						arg_383_1:RecordAudio("412031091", var_386_54)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_412031", "412031091", "story_v_out_412031.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_412031", "412031091", "story_v_out_412031.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_55 = math.max(var_386_46, arg_383_1.talkMaxDuration)

			if var_386_45 <= arg_383_1.time_ and arg_383_1.time_ < var_386_45 + var_386_55 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_45) / var_386_55

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_45 + var_386_55 and arg_383_1.time_ < var_386_45 + var_386_55 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play412031092 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 412031092
		arg_387_1.duration_ = 3.27

		local var_387_0 = {
			zh = 1.999999999999,
			ja = 3.266
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play412031093(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["10076ui_story"].transform
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.var_.moveOldPos10076ui_story = var_390_0.localPosition
			end

			local var_390_2 = 0.001

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2
				local var_390_4 = Vector3.New(0, -0.35, -4)

				var_390_0.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos10076ui_story, var_390_4, var_390_3)

				local var_390_5 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_5.x, var_390_5.y, var_390_5.z)

				local var_390_6 = var_390_0.localEulerAngles

				var_390_6.z = 0
				var_390_6.x = 0
				var_390_0.localEulerAngles = var_390_6
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 then
				var_390_0.localPosition = Vector3.New(0, -0.35, -4)

				local var_390_7 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_7.x, var_390_7.y, var_390_7.z)

				local var_390_8 = var_390_0.localEulerAngles

				var_390_8.z = 0
				var_390_8.x = 0
				var_390_0.localEulerAngles = var_390_8
			end

			local var_390_9 = arg_387_1.actors_["10076ui_story"]
			local var_390_10 = 0

			if var_390_10 < arg_387_1.time_ and arg_387_1.time_ <= var_390_10 + arg_390_0 and not isNil(var_390_9) and arg_387_1.var_.characterEffect10076ui_story == nil then
				arg_387_1.var_.characterEffect10076ui_story = var_390_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_11 = 0.200000002980232

			if var_390_10 <= arg_387_1.time_ and arg_387_1.time_ < var_390_10 + var_390_11 and not isNil(var_390_9) then
				local var_390_12 = (arg_387_1.time_ - var_390_10) / var_390_11

				if arg_387_1.var_.characterEffect10076ui_story and not isNil(var_390_9) then
					arg_387_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= var_390_10 + var_390_11 and arg_387_1.time_ < var_390_10 + var_390_11 + arg_390_0 and not isNil(var_390_9) and arg_387_1.var_.characterEffect10076ui_story then
				arg_387_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_390_13 = 0

			if var_390_13 < arg_387_1.time_ and arg_387_1.time_ <= var_390_13 + arg_390_0 then
				arg_387_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action2_1")
			end

			local var_390_14 = 0

			if var_390_14 < arg_387_1.time_ and arg_387_1.time_ <= var_390_14 + arg_390_0 then
				arg_387_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_390_15 = arg_387_1.actors_["10078ui_story"].transform
			local var_390_16 = 0

			if var_390_16 < arg_387_1.time_ and arg_387_1.time_ <= var_390_16 + arg_390_0 then
				arg_387_1.var_.moveOldPos10078ui_story = var_390_15.localPosition
			end

			local var_390_17 = 0.001

			if var_390_16 <= arg_387_1.time_ and arg_387_1.time_ < var_390_16 + var_390_17 then
				local var_390_18 = (arg_387_1.time_ - var_390_16) / var_390_17
				local var_390_19 = Vector3.New(0, 100, 0)

				var_390_15.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos10078ui_story, var_390_19, var_390_18)

				local var_390_20 = manager.ui.mainCamera.transform.position - var_390_15.position

				var_390_15.forward = Vector3.New(var_390_20.x, var_390_20.y, var_390_20.z)

				local var_390_21 = var_390_15.localEulerAngles

				var_390_21.z = 0
				var_390_21.x = 0
				var_390_15.localEulerAngles = var_390_21
			end

			if arg_387_1.time_ >= var_390_16 + var_390_17 and arg_387_1.time_ < var_390_16 + var_390_17 + arg_390_0 then
				var_390_15.localPosition = Vector3.New(0, 100, 0)

				local var_390_22 = manager.ui.mainCamera.transform.position - var_390_15.position

				var_390_15.forward = Vector3.New(var_390_22.x, var_390_22.y, var_390_22.z)

				local var_390_23 = var_390_15.localEulerAngles

				var_390_23.z = 0
				var_390_23.x = 0
				var_390_15.localEulerAngles = var_390_23
			end

			local var_390_24 = arg_387_1.actors_["10078ui_story"]
			local var_390_25 = 0

			if var_390_25 < arg_387_1.time_ and arg_387_1.time_ <= var_390_25 + arg_390_0 and not isNil(var_390_24) and arg_387_1.var_.characterEffect10078ui_story == nil then
				arg_387_1.var_.characterEffect10078ui_story = var_390_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_26 = 0.200000002980232

			if var_390_25 <= arg_387_1.time_ and arg_387_1.time_ < var_390_25 + var_390_26 and not isNil(var_390_24) then
				local var_390_27 = (arg_387_1.time_ - var_390_25) / var_390_26

				if arg_387_1.var_.characterEffect10078ui_story and not isNil(var_390_24) then
					local var_390_28 = Mathf.Lerp(0, 0.5, var_390_27)

					arg_387_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_387_1.var_.characterEffect10078ui_story.fillRatio = var_390_28
				end
			end

			if arg_387_1.time_ >= var_390_25 + var_390_26 and arg_387_1.time_ < var_390_25 + var_390_26 + arg_390_0 and not isNil(var_390_24) and arg_387_1.var_.characterEffect10078ui_story then
				local var_390_29 = 0.5

				arg_387_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_387_1.var_.characterEffect10078ui_story.fillRatio = var_390_29
			end

			local var_390_30 = 0
			local var_390_31 = 0.25

			if var_390_30 < arg_387_1.time_ and arg_387_1.time_ <= var_390_30 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_32 = arg_387_1:FormatText(StoryNameCfg[917].name)

				arg_387_1.leftNameTxt_.text = var_390_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_33 = arg_387_1:GetWordFromCfg(412031092)
				local var_390_34 = arg_387_1:FormatText(var_390_33.content)

				arg_387_1.text_.text = var_390_34

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_35 = 10
				local var_390_36 = utf8.len(var_390_34)
				local var_390_37 = var_390_35 <= 0 and var_390_31 or var_390_31 * (var_390_36 / var_390_35)

				if var_390_37 > 0 and var_390_31 < var_390_37 then
					arg_387_1.talkMaxDuration = var_390_37

					if var_390_37 + var_390_30 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_37 + var_390_30
					end
				end

				arg_387_1.text_.text = var_390_34
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031092", "story_v_out_412031.awb") ~= 0 then
					local var_390_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031092", "story_v_out_412031.awb") / 1000

					if var_390_38 + var_390_30 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_38 + var_390_30
					end

					if var_390_33.prefab_name ~= "" and arg_387_1.actors_[var_390_33.prefab_name] ~= nil then
						local var_390_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_33.prefab_name].transform, "story_v_out_412031", "412031092", "story_v_out_412031.awb")

						arg_387_1:RecordAudio("412031092", var_390_39)
						arg_387_1:RecordAudio("412031092", var_390_39)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_412031", "412031092", "story_v_out_412031.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_412031", "412031092", "story_v_out_412031.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_40 = math.max(var_390_31, arg_387_1.talkMaxDuration)

			if var_390_30 <= arg_387_1.time_ and arg_387_1.time_ < var_390_30 + var_390_40 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_30) / var_390_40

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_30 + var_390_40 and arg_387_1.time_ < var_390_30 + var_390_40 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play412031093 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 412031093
		arg_391_1.duration_ = 9.53

		local var_391_0 = {
			zh = 6.133,
			ja = 9.533
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play412031094(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1097ui_story"].transform
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.var_.moveOldPos1097ui_story = var_394_0.localPosition
			end

			local var_394_2 = 0.001

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2
				local var_394_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_394_0.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1097ui_story, var_394_4, var_394_3)

				local var_394_5 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_5.x, var_394_5.y, var_394_5.z)

				local var_394_6 = var_394_0.localEulerAngles

				var_394_6.z = 0
				var_394_6.x = 0
				var_394_0.localEulerAngles = var_394_6
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 then
				var_394_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_394_7 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_7.x, var_394_7.y, var_394_7.z)

				local var_394_8 = var_394_0.localEulerAngles

				var_394_8.z = 0
				var_394_8.x = 0
				var_394_0.localEulerAngles = var_394_8
			end

			local var_394_9 = arg_391_1.actors_["1097ui_story"]
			local var_394_10 = 0

			if var_394_10 < arg_391_1.time_ and arg_391_1.time_ <= var_394_10 + arg_394_0 and not isNil(var_394_9) and arg_391_1.var_.characterEffect1097ui_story == nil then
				arg_391_1.var_.characterEffect1097ui_story = var_394_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_11 = 0.200000002980232

			if var_394_10 <= arg_391_1.time_ and arg_391_1.time_ < var_394_10 + var_394_11 and not isNil(var_394_9) then
				local var_394_12 = (arg_391_1.time_ - var_394_10) / var_394_11

				if arg_391_1.var_.characterEffect1097ui_story and not isNil(var_394_9) then
					arg_391_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= var_394_10 + var_394_11 and arg_391_1.time_ < var_394_10 + var_394_11 + arg_394_0 and not isNil(var_394_9) and arg_391_1.var_.characterEffect1097ui_story then
				arg_391_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_394_13 = 0

			if var_394_13 < arg_391_1.time_ and arg_391_1.time_ <= var_394_13 + arg_394_0 then
				arg_391_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_394_14 = 0

			if var_394_14 < arg_391_1.time_ and arg_391_1.time_ <= var_394_14 + arg_394_0 then
				arg_391_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_394_15 = arg_391_1.actors_["10076ui_story"].transform
			local var_394_16 = 0

			if var_394_16 < arg_391_1.time_ and arg_391_1.time_ <= var_394_16 + arg_394_0 then
				arg_391_1.var_.moveOldPos10076ui_story = var_394_15.localPosition
			end

			local var_394_17 = 0.001

			if var_394_16 <= arg_391_1.time_ and arg_391_1.time_ < var_394_16 + var_394_17 then
				local var_394_18 = (arg_391_1.time_ - var_394_16) / var_394_17
				local var_394_19 = Vector3.New(0, 100, 0)

				var_394_15.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos10076ui_story, var_394_19, var_394_18)

				local var_394_20 = manager.ui.mainCamera.transform.position - var_394_15.position

				var_394_15.forward = Vector3.New(var_394_20.x, var_394_20.y, var_394_20.z)

				local var_394_21 = var_394_15.localEulerAngles

				var_394_21.z = 0
				var_394_21.x = 0
				var_394_15.localEulerAngles = var_394_21
			end

			if arg_391_1.time_ >= var_394_16 + var_394_17 and arg_391_1.time_ < var_394_16 + var_394_17 + arg_394_0 then
				var_394_15.localPosition = Vector3.New(0, 100, 0)

				local var_394_22 = manager.ui.mainCamera.transform.position - var_394_15.position

				var_394_15.forward = Vector3.New(var_394_22.x, var_394_22.y, var_394_22.z)

				local var_394_23 = var_394_15.localEulerAngles

				var_394_23.z = 0
				var_394_23.x = 0
				var_394_15.localEulerAngles = var_394_23
			end

			local var_394_24 = arg_391_1.actors_["10076ui_story"]
			local var_394_25 = 0

			if var_394_25 < arg_391_1.time_ and arg_391_1.time_ <= var_394_25 + arg_394_0 and not isNil(var_394_24) and arg_391_1.var_.characterEffect10076ui_story == nil then
				arg_391_1.var_.characterEffect10076ui_story = var_394_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_26 = 0.200000002980232

			if var_394_25 <= arg_391_1.time_ and arg_391_1.time_ < var_394_25 + var_394_26 and not isNil(var_394_24) then
				local var_394_27 = (arg_391_1.time_ - var_394_25) / var_394_26

				if arg_391_1.var_.characterEffect10076ui_story and not isNil(var_394_24) then
					local var_394_28 = Mathf.Lerp(0, 0.5, var_394_27)

					arg_391_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_391_1.var_.characterEffect10076ui_story.fillRatio = var_394_28
				end
			end

			if arg_391_1.time_ >= var_394_25 + var_394_26 and arg_391_1.time_ < var_394_25 + var_394_26 + arg_394_0 and not isNil(var_394_24) and arg_391_1.var_.characterEffect10076ui_story then
				local var_394_29 = 0.5

				arg_391_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_391_1.var_.characterEffect10076ui_story.fillRatio = var_394_29
			end

			local var_394_30 = 0
			local var_394_31 = 0.575

			if var_394_30 < arg_391_1.time_ and arg_391_1.time_ <= var_394_30 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_32 = arg_391_1:FormatText(StoryNameCfg[216].name)

				arg_391_1.leftNameTxt_.text = var_394_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_33 = arg_391_1:GetWordFromCfg(412031093)
				local var_394_34 = arg_391_1:FormatText(var_394_33.content)

				arg_391_1.text_.text = var_394_34

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_35 = 23
				local var_394_36 = utf8.len(var_394_34)
				local var_394_37 = var_394_35 <= 0 and var_394_31 or var_394_31 * (var_394_36 / var_394_35)

				if var_394_37 > 0 and var_394_31 < var_394_37 then
					arg_391_1.talkMaxDuration = var_394_37

					if var_394_37 + var_394_30 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_37 + var_394_30
					end
				end

				arg_391_1.text_.text = var_394_34
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031093", "story_v_out_412031.awb") ~= 0 then
					local var_394_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031093", "story_v_out_412031.awb") / 1000

					if var_394_38 + var_394_30 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_38 + var_394_30
					end

					if var_394_33.prefab_name ~= "" and arg_391_1.actors_[var_394_33.prefab_name] ~= nil then
						local var_394_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_33.prefab_name].transform, "story_v_out_412031", "412031093", "story_v_out_412031.awb")

						arg_391_1:RecordAudio("412031093", var_394_39)
						arg_391_1:RecordAudio("412031093", var_394_39)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_412031", "412031093", "story_v_out_412031.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_412031", "412031093", "story_v_out_412031.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_40 = math.max(var_394_31, arg_391_1.talkMaxDuration)

			if var_394_30 <= arg_391_1.time_ and arg_391_1.time_ < var_394_30 + var_394_40 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_30) / var_394_40

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_30 + var_394_40 and arg_391_1.time_ < var_394_30 + var_394_40 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play412031094 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 412031094
		arg_395_1.duration_ = 8.1

		local var_395_0 = {
			zh = 7.033,
			ja = 8.1
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play412031095(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["3043ui_story"].transform
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 then
				arg_395_1.var_.moveOldPos3043ui_story = var_398_0.localPosition
			end

			local var_398_2 = 0.001

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_2 then
				local var_398_3 = (arg_395_1.time_ - var_398_1) / var_398_2
				local var_398_4 = Vector3.New(0.7, -1.41, -5.7)

				var_398_0.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos3043ui_story, var_398_4, var_398_3)

				local var_398_5 = manager.ui.mainCamera.transform.position - var_398_0.position

				var_398_0.forward = Vector3.New(var_398_5.x, var_398_5.y, var_398_5.z)

				local var_398_6 = var_398_0.localEulerAngles

				var_398_6.z = 0
				var_398_6.x = 0
				var_398_0.localEulerAngles = var_398_6
			end

			if arg_395_1.time_ >= var_398_1 + var_398_2 and arg_395_1.time_ < var_398_1 + var_398_2 + arg_398_0 then
				var_398_0.localPosition = Vector3.New(0.7, -1.41, -5.7)

				local var_398_7 = manager.ui.mainCamera.transform.position - var_398_0.position

				var_398_0.forward = Vector3.New(var_398_7.x, var_398_7.y, var_398_7.z)

				local var_398_8 = var_398_0.localEulerAngles

				var_398_8.z = 0
				var_398_8.x = 0
				var_398_0.localEulerAngles = var_398_8
			end

			local var_398_9 = arg_395_1.actors_["3043ui_story"]
			local var_398_10 = 0

			if var_398_10 < arg_395_1.time_ and arg_395_1.time_ <= var_398_10 + arg_398_0 and not isNil(var_398_9) and arg_395_1.var_.characterEffect3043ui_story == nil then
				arg_395_1.var_.characterEffect3043ui_story = var_398_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_11 = 0.200000002980232

			if var_398_10 <= arg_395_1.time_ and arg_395_1.time_ < var_398_10 + var_398_11 and not isNil(var_398_9) then
				local var_398_12 = (arg_395_1.time_ - var_398_10) / var_398_11

				if arg_395_1.var_.characterEffect3043ui_story and not isNil(var_398_9) then
					arg_395_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= var_398_10 + var_398_11 and arg_395_1.time_ < var_398_10 + var_398_11 + arg_398_0 and not isNil(var_398_9) and arg_395_1.var_.characterEffect3043ui_story then
				arg_395_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_398_13 = 0

			if var_398_13 < arg_395_1.time_ and arg_395_1.time_ <= var_398_13 + arg_398_0 then
				arg_395_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_398_14 = 0

			if var_398_14 < arg_395_1.time_ and arg_395_1.time_ <= var_398_14 + arg_398_0 then
				arg_395_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_398_15 = arg_395_1.actors_["1097ui_story"]
			local var_398_16 = 0

			if var_398_16 < arg_395_1.time_ and arg_395_1.time_ <= var_398_16 + arg_398_0 and not isNil(var_398_15) and arg_395_1.var_.characterEffect1097ui_story == nil then
				arg_395_1.var_.characterEffect1097ui_story = var_398_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_17 = 0.200000002980232

			if var_398_16 <= arg_395_1.time_ and arg_395_1.time_ < var_398_16 + var_398_17 and not isNil(var_398_15) then
				local var_398_18 = (arg_395_1.time_ - var_398_16) / var_398_17

				if arg_395_1.var_.characterEffect1097ui_story and not isNil(var_398_15) then
					local var_398_19 = Mathf.Lerp(0, 0.5, var_398_18)

					arg_395_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1097ui_story.fillRatio = var_398_19
				end
			end

			if arg_395_1.time_ >= var_398_16 + var_398_17 and arg_395_1.time_ < var_398_16 + var_398_17 + arg_398_0 and not isNil(var_398_15) and arg_395_1.var_.characterEffect1097ui_story then
				local var_398_20 = 0.5

				arg_395_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1097ui_story.fillRatio = var_398_20
			end

			local var_398_21 = 0
			local var_398_22 = 0.75

			if var_398_21 < arg_395_1.time_ and arg_395_1.time_ <= var_398_21 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_23 = arg_395_1:FormatText(StoryNameCfg[920].name)

				arg_395_1.leftNameTxt_.text = var_398_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_24 = arg_395_1:GetWordFromCfg(412031094)
				local var_398_25 = arg_395_1:FormatText(var_398_24.content)

				arg_395_1.text_.text = var_398_25

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_26 = 30
				local var_398_27 = utf8.len(var_398_25)
				local var_398_28 = var_398_26 <= 0 and var_398_22 or var_398_22 * (var_398_27 / var_398_26)

				if var_398_28 > 0 and var_398_22 < var_398_28 then
					arg_395_1.talkMaxDuration = var_398_28

					if var_398_28 + var_398_21 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_28 + var_398_21
					end
				end

				arg_395_1.text_.text = var_398_25
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031094", "story_v_out_412031.awb") ~= 0 then
					local var_398_29 = manager.audio:GetVoiceLength("story_v_out_412031", "412031094", "story_v_out_412031.awb") / 1000

					if var_398_29 + var_398_21 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_29 + var_398_21
					end

					if var_398_24.prefab_name ~= "" and arg_395_1.actors_[var_398_24.prefab_name] ~= nil then
						local var_398_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_24.prefab_name].transform, "story_v_out_412031", "412031094", "story_v_out_412031.awb")

						arg_395_1:RecordAudio("412031094", var_398_30)
						arg_395_1:RecordAudio("412031094", var_398_30)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_412031", "412031094", "story_v_out_412031.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_412031", "412031094", "story_v_out_412031.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_31 = math.max(var_398_22, arg_395_1.talkMaxDuration)

			if var_398_21 <= arg_395_1.time_ and arg_395_1.time_ < var_398_21 + var_398_31 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_21) / var_398_31

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_21 + var_398_31 and arg_395_1.time_ < var_398_21 + var_398_31 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play412031095 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 412031095
		arg_399_1.duration_ = 6.33

		local var_399_0 = {
			zh = 6.333,
			ja = 6
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play412031096(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["1097ui_story"]
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1097ui_story == nil then
				arg_399_1.var_.characterEffect1097ui_story = var_402_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.200000002980232

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 and not isNil(var_402_0) then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2

				if arg_399_1.var_.characterEffect1097ui_story and not isNil(var_402_0) then
					arg_399_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1097ui_story then
				arg_399_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_402_4 = 0

			if var_402_4 < arg_399_1.time_ and arg_399_1.time_ <= var_402_4 + arg_402_0 then
				arg_399_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_402_5 = 0

			if var_402_5 < arg_399_1.time_ and arg_399_1.time_ <= var_402_5 + arg_402_0 then
				arg_399_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_402_6 = arg_399_1.actors_["3043ui_story"]
			local var_402_7 = 0

			if var_402_7 < arg_399_1.time_ and arg_399_1.time_ <= var_402_7 + arg_402_0 and not isNil(var_402_6) and arg_399_1.var_.characterEffect3043ui_story == nil then
				arg_399_1.var_.characterEffect3043ui_story = var_402_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_8 = 0.200000002980232

			if var_402_7 <= arg_399_1.time_ and arg_399_1.time_ < var_402_7 + var_402_8 and not isNil(var_402_6) then
				local var_402_9 = (arg_399_1.time_ - var_402_7) / var_402_8

				if arg_399_1.var_.characterEffect3043ui_story and not isNil(var_402_6) then
					local var_402_10 = Mathf.Lerp(0, 0.5, var_402_9)

					arg_399_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_399_1.var_.characterEffect3043ui_story.fillRatio = var_402_10
				end
			end

			if arg_399_1.time_ >= var_402_7 + var_402_8 and arg_399_1.time_ < var_402_7 + var_402_8 + arg_402_0 and not isNil(var_402_6) and arg_399_1.var_.characterEffect3043ui_story then
				local var_402_11 = 0.5

				arg_399_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_399_1.var_.characterEffect3043ui_story.fillRatio = var_402_11
			end

			local var_402_12 = 0
			local var_402_13 = 0.575

			if var_402_12 < arg_399_1.time_ and arg_399_1.time_ <= var_402_12 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_14 = arg_399_1:FormatText(StoryNameCfg[216].name)

				arg_399_1.leftNameTxt_.text = var_402_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_15 = arg_399_1:GetWordFromCfg(412031095)
				local var_402_16 = arg_399_1:FormatText(var_402_15.content)

				arg_399_1.text_.text = var_402_16

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_17 = 23
				local var_402_18 = utf8.len(var_402_16)
				local var_402_19 = var_402_17 <= 0 and var_402_13 or var_402_13 * (var_402_18 / var_402_17)

				if var_402_19 > 0 and var_402_13 < var_402_19 then
					arg_399_1.talkMaxDuration = var_402_19

					if var_402_19 + var_402_12 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_19 + var_402_12
					end
				end

				arg_399_1.text_.text = var_402_16
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031095", "story_v_out_412031.awb") ~= 0 then
					local var_402_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031095", "story_v_out_412031.awb") / 1000

					if var_402_20 + var_402_12 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_20 + var_402_12
					end

					if var_402_15.prefab_name ~= "" and arg_399_1.actors_[var_402_15.prefab_name] ~= nil then
						local var_402_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_15.prefab_name].transform, "story_v_out_412031", "412031095", "story_v_out_412031.awb")

						arg_399_1:RecordAudio("412031095", var_402_21)
						arg_399_1:RecordAudio("412031095", var_402_21)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_412031", "412031095", "story_v_out_412031.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_412031", "412031095", "story_v_out_412031.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_22 = math.max(var_402_13, arg_399_1.talkMaxDuration)

			if var_402_12 <= arg_399_1.time_ and arg_399_1.time_ < var_402_12 + var_402_22 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_12) / var_402_22

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_12 + var_402_22 and arg_399_1.time_ < var_402_12 + var_402_22 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play412031096 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 412031096
		arg_403_1.duration_ = 9.6

		local var_403_0 = {
			zh = 9.6,
			ja = 7.6
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play412031097(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["3043ui_story"]
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.characterEffect3043ui_story == nil then
				arg_403_1.var_.characterEffect3043ui_story = var_406_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_2 and not isNil(var_406_0) then
				local var_406_3 = (arg_403_1.time_ - var_406_1) / var_406_2

				if arg_403_1.var_.characterEffect3043ui_story and not isNil(var_406_0) then
					arg_403_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= var_406_1 + var_406_2 and arg_403_1.time_ < var_406_1 + var_406_2 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.characterEffect3043ui_story then
				arg_403_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_406_4 = 0

			if var_406_4 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_406_5 = 0

			if var_406_5 < arg_403_1.time_ and arg_403_1.time_ <= var_406_5 + arg_406_0 then
				arg_403_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_406_6 = arg_403_1.actors_["1097ui_story"]
			local var_406_7 = 0

			if var_406_7 < arg_403_1.time_ and arg_403_1.time_ <= var_406_7 + arg_406_0 and not isNil(var_406_6) and arg_403_1.var_.characterEffect1097ui_story == nil then
				arg_403_1.var_.characterEffect1097ui_story = var_406_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_8 = 0.200000002980232

			if var_406_7 <= arg_403_1.time_ and arg_403_1.time_ < var_406_7 + var_406_8 and not isNil(var_406_6) then
				local var_406_9 = (arg_403_1.time_ - var_406_7) / var_406_8

				if arg_403_1.var_.characterEffect1097ui_story and not isNil(var_406_6) then
					local var_406_10 = Mathf.Lerp(0, 0.5, var_406_9)

					arg_403_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1097ui_story.fillRatio = var_406_10
				end
			end

			if arg_403_1.time_ >= var_406_7 + var_406_8 and arg_403_1.time_ < var_406_7 + var_406_8 + arg_406_0 and not isNil(var_406_6) and arg_403_1.var_.characterEffect1097ui_story then
				local var_406_11 = 0.5

				arg_403_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1097ui_story.fillRatio = var_406_11
			end

			local var_406_12 = 0
			local var_406_13 = 0.95

			if var_406_12 < arg_403_1.time_ and arg_403_1.time_ <= var_406_12 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_14 = arg_403_1:FormatText(StoryNameCfg[920].name)

				arg_403_1.leftNameTxt_.text = var_406_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_15 = arg_403_1:GetWordFromCfg(412031096)
				local var_406_16 = arg_403_1:FormatText(var_406_15.content)

				arg_403_1.text_.text = var_406_16

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_17 = 38
				local var_406_18 = utf8.len(var_406_16)
				local var_406_19 = var_406_17 <= 0 and var_406_13 or var_406_13 * (var_406_18 / var_406_17)

				if var_406_19 > 0 and var_406_13 < var_406_19 then
					arg_403_1.talkMaxDuration = var_406_19

					if var_406_19 + var_406_12 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_19 + var_406_12
					end
				end

				arg_403_1.text_.text = var_406_16
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031096", "story_v_out_412031.awb") ~= 0 then
					local var_406_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031096", "story_v_out_412031.awb") / 1000

					if var_406_20 + var_406_12 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_20 + var_406_12
					end

					if var_406_15.prefab_name ~= "" and arg_403_1.actors_[var_406_15.prefab_name] ~= nil then
						local var_406_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_15.prefab_name].transform, "story_v_out_412031", "412031096", "story_v_out_412031.awb")

						arg_403_1:RecordAudio("412031096", var_406_21)
						arg_403_1:RecordAudio("412031096", var_406_21)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_412031", "412031096", "story_v_out_412031.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_412031", "412031096", "story_v_out_412031.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_22 = math.max(var_406_13, arg_403_1.talkMaxDuration)

			if var_406_12 <= arg_403_1.time_ and arg_403_1.time_ < var_406_12 + var_406_22 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_12) / var_406_22

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_12 + var_406_22 and arg_403_1.time_ < var_406_12 + var_406_22 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play412031097 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 412031097
		arg_407_1.duration_ = 3.17

		local var_407_0 = {
			zh = 3.133,
			ja = 3.166
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play412031098(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1097ui_story"]
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1097ui_story == nil then
				arg_407_1.var_.characterEffect1097ui_story = var_410_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.200000002980232

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 and not isNil(var_410_0) then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2

				if arg_407_1.var_.characterEffect1097ui_story and not isNil(var_410_0) then
					arg_407_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1097ui_story then
				arg_407_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_410_4 = 0

			if var_410_4 < arg_407_1.time_ and arg_407_1.time_ <= var_410_4 + arg_410_0 then
				arg_407_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_410_5 = 0

			if var_410_5 < arg_407_1.time_ and arg_407_1.time_ <= var_410_5 + arg_410_0 then
				arg_407_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_410_6 = arg_407_1.actors_["3043ui_story"]
			local var_410_7 = 0

			if var_410_7 < arg_407_1.time_ and arg_407_1.time_ <= var_410_7 + arg_410_0 and not isNil(var_410_6) and arg_407_1.var_.characterEffect3043ui_story == nil then
				arg_407_1.var_.characterEffect3043ui_story = var_410_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_8 = 0.200000002980232

			if var_410_7 <= arg_407_1.time_ and arg_407_1.time_ < var_410_7 + var_410_8 and not isNil(var_410_6) then
				local var_410_9 = (arg_407_1.time_ - var_410_7) / var_410_8

				if arg_407_1.var_.characterEffect3043ui_story and not isNil(var_410_6) then
					local var_410_10 = Mathf.Lerp(0, 0.5, var_410_9)

					arg_407_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_407_1.var_.characterEffect3043ui_story.fillRatio = var_410_10
				end
			end

			if arg_407_1.time_ >= var_410_7 + var_410_8 and arg_407_1.time_ < var_410_7 + var_410_8 + arg_410_0 and not isNil(var_410_6) and arg_407_1.var_.characterEffect3043ui_story then
				local var_410_11 = 0.5

				arg_407_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_407_1.var_.characterEffect3043ui_story.fillRatio = var_410_11
			end

			local var_410_12 = 0
			local var_410_13 = 0.2

			if var_410_12 < arg_407_1.time_ and arg_407_1.time_ <= var_410_12 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_14 = arg_407_1:FormatText(StoryNameCfg[216].name)

				arg_407_1.leftNameTxt_.text = var_410_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_15 = arg_407_1:GetWordFromCfg(412031097)
				local var_410_16 = arg_407_1:FormatText(var_410_15.content)

				arg_407_1.text_.text = var_410_16

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_17 = 8
				local var_410_18 = utf8.len(var_410_16)
				local var_410_19 = var_410_17 <= 0 and var_410_13 or var_410_13 * (var_410_18 / var_410_17)

				if var_410_19 > 0 and var_410_13 < var_410_19 then
					arg_407_1.talkMaxDuration = var_410_19

					if var_410_19 + var_410_12 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_19 + var_410_12
					end
				end

				arg_407_1.text_.text = var_410_16
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031097", "story_v_out_412031.awb") ~= 0 then
					local var_410_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031097", "story_v_out_412031.awb") / 1000

					if var_410_20 + var_410_12 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_20 + var_410_12
					end

					if var_410_15.prefab_name ~= "" and arg_407_1.actors_[var_410_15.prefab_name] ~= nil then
						local var_410_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_15.prefab_name].transform, "story_v_out_412031", "412031097", "story_v_out_412031.awb")

						arg_407_1:RecordAudio("412031097", var_410_21)
						arg_407_1:RecordAudio("412031097", var_410_21)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_412031", "412031097", "story_v_out_412031.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_412031", "412031097", "story_v_out_412031.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_22 = math.max(var_410_13, arg_407_1.talkMaxDuration)

			if var_410_12 <= arg_407_1.time_ and arg_407_1.time_ < var_410_12 + var_410_22 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_12) / var_410_22

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_12 + var_410_22 and arg_407_1.time_ < var_410_12 + var_410_22 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play412031098 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 412031098
		arg_411_1.duration_ = 4.1

		local var_411_0 = {
			zh = 2.533,
			ja = 4.1
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play412031099(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["3043ui_story"]
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect3043ui_story == nil then
				arg_411_1.var_.characterEffect3043ui_story = var_414_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.200000002980232

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 and not isNil(var_414_0) then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2

				if arg_411_1.var_.characterEffect3043ui_story and not isNil(var_414_0) then
					arg_411_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect3043ui_story then
				arg_411_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_414_4 = arg_411_1.actors_["1097ui_story"]
			local var_414_5 = 0

			if var_414_5 < arg_411_1.time_ and arg_411_1.time_ <= var_414_5 + arg_414_0 and not isNil(var_414_4) and arg_411_1.var_.characterEffect1097ui_story == nil then
				arg_411_1.var_.characterEffect1097ui_story = var_414_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_6 = 0.200000002980232

			if var_414_5 <= arg_411_1.time_ and arg_411_1.time_ < var_414_5 + var_414_6 and not isNil(var_414_4) then
				local var_414_7 = (arg_411_1.time_ - var_414_5) / var_414_6

				if arg_411_1.var_.characterEffect1097ui_story and not isNil(var_414_4) then
					local var_414_8 = Mathf.Lerp(0, 0.5, var_414_7)

					arg_411_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1097ui_story.fillRatio = var_414_8
				end
			end

			if arg_411_1.time_ >= var_414_5 + var_414_6 and arg_411_1.time_ < var_414_5 + var_414_6 + arg_414_0 and not isNil(var_414_4) and arg_411_1.var_.characterEffect1097ui_story then
				local var_414_9 = 0.5

				arg_411_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1097ui_story.fillRatio = var_414_9
			end

			local var_414_10 = 0
			local var_414_11 = 0.25

			if var_414_10 < arg_411_1.time_ and arg_411_1.time_ <= var_414_10 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_12 = arg_411_1:FormatText(StoryNameCfg[920].name)

				arg_411_1.leftNameTxt_.text = var_414_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_13 = arg_411_1:GetWordFromCfg(412031098)
				local var_414_14 = arg_411_1:FormatText(var_414_13.content)

				arg_411_1.text_.text = var_414_14

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_15 = 10
				local var_414_16 = utf8.len(var_414_14)
				local var_414_17 = var_414_15 <= 0 and var_414_11 or var_414_11 * (var_414_16 / var_414_15)

				if var_414_17 > 0 and var_414_11 < var_414_17 then
					arg_411_1.talkMaxDuration = var_414_17

					if var_414_17 + var_414_10 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_17 + var_414_10
					end
				end

				arg_411_1.text_.text = var_414_14
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031098", "story_v_out_412031.awb") ~= 0 then
					local var_414_18 = manager.audio:GetVoiceLength("story_v_out_412031", "412031098", "story_v_out_412031.awb") / 1000

					if var_414_18 + var_414_10 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_18 + var_414_10
					end

					if var_414_13.prefab_name ~= "" and arg_411_1.actors_[var_414_13.prefab_name] ~= nil then
						local var_414_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_13.prefab_name].transform, "story_v_out_412031", "412031098", "story_v_out_412031.awb")

						arg_411_1:RecordAudio("412031098", var_414_19)
						arg_411_1:RecordAudio("412031098", var_414_19)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_412031", "412031098", "story_v_out_412031.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_412031", "412031098", "story_v_out_412031.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_20 = math.max(var_414_11, arg_411_1.talkMaxDuration)

			if var_414_10 <= arg_411_1.time_ and arg_411_1.time_ < var_414_10 + var_414_20 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_10) / var_414_20

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_10 + var_414_20 and arg_411_1.time_ < var_414_10 + var_414_20 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play412031099 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 412031099
		arg_415_1.duration_ = 4.53

		local var_415_0 = {
			zh = 3.233,
			ja = 4.533
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play412031100(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["3043ui_story"]
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect3043ui_story == nil then
				arg_415_1.var_.characterEffect3043ui_story = var_418_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.200000002980232

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 and not isNil(var_418_0) then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2

				if arg_415_1.var_.characterEffect3043ui_story and not isNil(var_418_0) then
					local var_418_4 = Mathf.Lerp(0, 0.5, var_418_3)

					arg_415_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_415_1.var_.characterEffect3043ui_story.fillRatio = var_418_4
				end
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect3043ui_story then
				local var_418_5 = 0.5

				arg_415_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_415_1.var_.characterEffect3043ui_story.fillRatio = var_418_5
			end

			local var_418_6 = arg_415_1.actors_["1097ui_story"]
			local var_418_7 = 0

			if var_418_7 < arg_415_1.time_ and arg_415_1.time_ <= var_418_7 + arg_418_0 and not isNil(var_418_6) and arg_415_1.var_.characterEffect1097ui_story == nil then
				arg_415_1.var_.characterEffect1097ui_story = var_418_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_8 = 0.200000002980232

			if var_418_7 <= arg_415_1.time_ and arg_415_1.time_ < var_418_7 + var_418_8 and not isNil(var_418_6) then
				local var_418_9 = (arg_415_1.time_ - var_418_7) / var_418_8

				if arg_415_1.var_.characterEffect1097ui_story and not isNil(var_418_6) then
					arg_415_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= var_418_7 + var_418_8 and arg_415_1.time_ < var_418_7 + var_418_8 + arg_418_0 and not isNil(var_418_6) and arg_415_1.var_.characterEffect1097ui_story then
				arg_415_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_418_10 = 0
			local var_418_11 = 0.35

			if var_418_10 < arg_415_1.time_ and arg_415_1.time_ <= var_418_10 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_12 = arg_415_1:FormatText(StoryNameCfg[216].name)

				arg_415_1.leftNameTxt_.text = var_418_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_13 = arg_415_1:GetWordFromCfg(412031099)
				local var_418_14 = arg_415_1:FormatText(var_418_13.content)

				arg_415_1.text_.text = var_418_14

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_15 = 13
				local var_418_16 = utf8.len(var_418_14)
				local var_418_17 = var_418_15 <= 0 and var_418_11 or var_418_11 * (var_418_16 / var_418_15)

				if var_418_17 > 0 and var_418_11 < var_418_17 then
					arg_415_1.talkMaxDuration = var_418_17

					if var_418_17 + var_418_10 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_17 + var_418_10
					end
				end

				arg_415_1.text_.text = var_418_14
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031099", "story_v_out_412031.awb") ~= 0 then
					local var_418_18 = manager.audio:GetVoiceLength("story_v_out_412031", "412031099", "story_v_out_412031.awb") / 1000

					if var_418_18 + var_418_10 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_18 + var_418_10
					end

					if var_418_13.prefab_name ~= "" and arg_415_1.actors_[var_418_13.prefab_name] ~= nil then
						local var_418_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_13.prefab_name].transform, "story_v_out_412031", "412031099", "story_v_out_412031.awb")

						arg_415_1:RecordAudio("412031099", var_418_19)
						arg_415_1:RecordAudio("412031099", var_418_19)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_412031", "412031099", "story_v_out_412031.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_412031", "412031099", "story_v_out_412031.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_20 = math.max(var_418_11, arg_415_1.talkMaxDuration)

			if var_418_10 <= arg_415_1.time_ and arg_415_1.time_ < var_418_10 + var_418_20 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_10) / var_418_20

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_10 + var_418_20 and arg_415_1.time_ < var_418_10 + var_418_20 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play412031100 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 412031100
		arg_419_1.duration_ = 1.4

		local var_419_0 = {
			zh = 1.4,
			ja = 1.3
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play412031101(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["3043ui_story"]
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 and not isNil(var_422_0) and arg_419_1.var_.characterEffect3043ui_story == nil then
				arg_419_1.var_.characterEffect3043ui_story = var_422_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_2 = 0.200000002980232

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 and not isNil(var_422_0) then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2

				if arg_419_1.var_.characterEffect3043ui_story and not isNil(var_422_0) then
					arg_419_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 and not isNil(var_422_0) and arg_419_1.var_.characterEffect3043ui_story then
				arg_419_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_422_4 = arg_419_1.actors_["1097ui_story"]
			local var_422_5 = 0

			if var_422_5 < arg_419_1.time_ and arg_419_1.time_ <= var_422_5 + arg_422_0 and not isNil(var_422_4) and arg_419_1.var_.characterEffect1097ui_story == nil then
				arg_419_1.var_.characterEffect1097ui_story = var_422_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_6 = 0.200000002980232

			if var_422_5 <= arg_419_1.time_ and arg_419_1.time_ < var_422_5 + var_422_6 and not isNil(var_422_4) then
				local var_422_7 = (arg_419_1.time_ - var_422_5) / var_422_6

				if arg_419_1.var_.characterEffect1097ui_story and not isNil(var_422_4) then
					local var_422_8 = Mathf.Lerp(0, 0.5, var_422_7)

					arg_419_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_419_1.var_.characterEffect1097ui_story.fillRatio = var_422_8
				end
			end

			if arg_419_1.time_ >= var_422_5 + var_422_6 and arg_419_1.time_ < var_422_5 + var_422_6 + arg_422_0 and not isNil(var_422_4) and arg_419_1.var_.characterEffect1097ui_story then
				local var_422_9 = 0.5

				arg_419_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_419_1.var_.characterEffect1097ui_story.fillRatio = var_422_9
			end

			local var_422_10 = 0
			local var_422_11 = 0.1

			if var_422_10 < arg_419_1.time_ and arg_419_1.time_ <= var_422_10 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_12 = arg_419_1:FormatText(StoryNameCfg[920].name)

				arg_419_1.leftNameTxt_.text = var_422_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_13 = arg_419_1:GetWordFromCfg(412031100)
				local var_422_14 = arg_419_1:FormatText(var_422_13.content)

				arg_419_1.text_.text = var_422_14

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_15 = 4
				local var_422_16 = utf8.len(var_422_14)
				local var_422_17 = var_422_15 <= 0 and var_422_11 or var_422_11 * (var_422_16 / var_422_15)

				if var_422_17 > 0 and var_422_11 < var_422_17 then
					arg_419_1.talkMaxDuration = var_422_17

					if var_422_17 + var_422_10 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_17 + var_422_10
					end
				end

				arg_419_1.text_.text = var_422_14
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031100", "story_v_out_412031.awb") ~= 0 then
					local var_422_18 = manager.audio:GetVoiceLength("story_v_out_412031", "412031100", "story_v_out_412031.awb") / 1000

					if var_422_18 + var_422_10 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_18 + var_422_10
					end

					if var_422_13.prefab_name ~= "" and arg_419_1.actors_[var_422_13.prefab_name] ~= nil then
						local var_422_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_13.prefab_name].transform, "story_v_out_412031", "412031100", "story_v_out_412031.awb")

						arg_419_1:RecordAudio("412031100", var_422_19)
						arg_419_1:RecordAudio("412031100", var_422_19)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_412031", "412031100", "story_v_out_412031.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_412031", "412031100", "story_v_out_412031.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_20 = math.max(var_422_11, arg_419_1.talkMaxDuration)

			if var_422_10 <= arg_419_1.time_ and arg_419_1.time_ < var_422_10 + var_422_20 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_10) / var_422_20

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_10 + var_422_20 and arg_419_1.time_ < var_422_10 + var_422_20 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play412031101 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 412031101
		arg_423_1.duration_ = 6.5

		local var_423_0 = {
			zh = 3.566,
			ja = 6.5
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play412031102(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1097ui_story"]
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect1097ui_story == nil then
				arg_423_1.var_.characterEffect1097ui_story = var_426_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.200000002980232

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 and not isNil(var_426_0) then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2

				if arg_423_1.var_.characterEffect1097ui_story and not isNil(var_426_0) then
					arg_423_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect1097ui_story then
				arg_423_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_426_4 = 0

			if var_426_4 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_426_5 = 0

			if var_426_5 < arg_423_1.time_ and arg_423_1.time_ <= var_426_5 + arg_426_0 then
				arg_423_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_426_6 = arg_423_1.actors_["3043ui_story"]
			local var_426_7 = 0

			if var_426_7 < arg_423_1.time_ and arg_423_1.time_ <= var_426_7 + arg_426_0 and not isNil(var_426_6) and arg_423_1.var_.characterEffect3043ui_story == nil then
				arg_423_1.var_.characterEffect3043ui_story = var_426_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_8 = 0.200000002980232

			if var_426_7 <= arg_423_1.time_ and arg_423_1.time_ < var_426_7 + var_426_8 and not isNil(var_426_6) then
				local var_426_9 = (arg_423_1.time_ - var_426_7) / var_426_8

				if arg_423_1.var_.characterEffect3043ui_story and not isNil(var_426_6) then
					local var_426_10 = Mathf.Lerp(0, 0.5, var_426_9)

					arg_423_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_423_1.var_.characterEffect3043ui_story.fillRatio = var_426_10
				end
			end

			if arg_423_1.time_ >= var_426_7 + var_426_8 and arg_423_1.time_ < var_426_7 + var_426_8 + arg_426_0 and not isNil(var_426_6) and arg_423_1.var_.characterEffect3043ui_story then
				local var_426_11 = 0.5

				arg_423_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_423_1.var_.characterEffect3043ui_story.fillRatio = var_426_11
			end

			local var_426_12 = 0
			local var_426_13 = 0.3

			if var_426_12 < arg_423_1.time_ and arg_423_1.time_ <= var_426_12 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_14 = arg_423_1:FormatText(StoryNameCfg[216].name)

				arg_423_1.leftNameTxt_.text = var_426_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_15 = arg_423_1:GetWordFromCfg(412031101)
				local var_426_16 = arg_423_1:FormatText(var_426_15.content)

				arg_423_1.text_.text = var_426_16

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_17 = 12
				local var_426_18 = utf8.len(var_426_16)
				local var_426_19 = var_426_17 <= 0 and var_426_13 or var_426_13 * (var_426_18 / var_426_17)

				if var_426_19 > 0 and var_426_13 < var_426_19 then
					arg_423_1.talkMaxDuration = var_426_19

					if var_426_19 + var_426_12 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_19 + var_426_12
					end
				end

				arg_423_1.text_.text = var_426_16
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031101", "story_v_out_412031.awb") ~= 0 then
					local var_426_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031101", "story_v_out_412031.awb") / 1000

					if var_426_20 + var_426_12 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_20 + var_426_12
					end

					if var_426_15.prefab_name ~= "" and arg_423_1.actors_[var_426_15.prefab_name] ~= nil then
						local var_426_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_15.prefab_name].transform, "story_v_out_412031", "412031101", "story_v_out_412031.awb")

						arg_423_1:RecordAudio("412031101", var_426_21)
						arg_423_1:RecordAudio("412031101", var_426_21)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_412031", "412031101", "story_v_out_412031.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_412031", "412031101", "story_v_out_412031.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_22 = math.max(var_426_13, arg_423_1.talkMaxDuration)

			if var_426_12 <= arg_423_1.time_ and arg_423_1.time_ < var_426_12 + var_426_22 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_12) / var_426_22

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_12 + var_426_22 and arg_423_1.time_ < var_426_12 + var_426_22 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play412031102 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 412031102
		arg_427_1.duration_ = 2.93

		local var_427_0 = {
			zh = 1.999999999999,
			ja = 2.933
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play412031103(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["3043ui_story"]
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect3043ui_story == nil then
				arg_427_1.var_.characterEffect3043ui_story = var_430_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.200000002980232

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_2 and not isNil(var_430_0) then
				local var_430_3 = (arg_427_1.time_ - var_430_1) / var_430_2

				if arg_427_1.var_.characterEffect3043ui_story and not isNil(var_430_0) then
					arg_427_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= var_430_1 + var_430_2 and arg_427_1.time_ < var_430_1 + var_430_2 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect3043ui_story then
				arg_427_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_430_4 = 0

			if var_430_4 < arg_427_1.time_ and arg_427_1.time_ <= var_430_4 + arg_430_0 then
				arg_427_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_430_5 = 0

			if var_430_5 < arg_427_1.time_ and arg_427_1.time_ <= var_430_5 + arg_430_0 then
				arg_427_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_430_6 = arg_427_1.actors_["1097ui_story"]
			local var_430_7 = 0

			if var_430_7 < arg_427_1.time_ and arg_427_1.time_ <= var_430_7 + arg_430_0 and not isNil(var_430_6) and arg_427_1.var_.characterEffect1097ui_story == nil then
				arg_427_1.var_.characterEffect1097ui_story = var_430_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_8 = 0.200000002980232

			if var_430_7 <= arg_427_1.time_ and arg_427_1.time_ < var_430_7 + var_430_8 and not isNil(var_430_6) then
				local var_430_9 = (arg_427_1.time_ - var_430_7) / var_430_8

				if arg_427_1.var_.characterEffect1097ui_story and not isNil(var_430_6) then
					local var_430_10 = Mathf.Lerp(0, 0.5, var_430_9)

					arg_427_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1097ui_story.fillRatio = var_430_10
				end
			end

			if arg_427_1.time_ >= var_430_7 + var_430_8 and arg_427_1.time_ < var_430_7 + var_430_8 + arg_430_0 and not isNil(var_430_6) and arg_427_1.var_.characterEffect1097ui_story then
				local var_430_11 = 0.5

				arg_427_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1097ui_story.fillRatio = var_430_11
			end

			local var_430_12 = 0
			local var_430_13 = 0.125

			if var_430_12 < arg_427_1.time_ and arg_427_1.time_ <= var_430_12 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_14 = arg_427_1:FormatText(StoryNameCfg[920].name)

				arg_427_1.leftNameTxt_.text = var_430_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_15 = arg_427_1:GetWordFromCfg(412031102)
				local var_430_16 = arg_427_1:FormatText(var_430_15.content)

				arg_427_1.text_.text = var_430_16

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_17 = 5
				local var_430_18 = utf8.len(var_430_16)
				local var_430_19 = var_430_17 <= 0 and var_430_13 or var_430_13 * (var_430_18 / var_430_17)

				if var_430_19 > 0 and var_430_13 < var_430_19 then
					arg_427_1.talkMaxDuration = var_430_19

					if var_430_19 + var_430_12 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_19 + var_430_12
					end
				end

				arg_427_1.text_.text = var_430_16
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031102", "story_v_out_412031.awb") ~= 0 then
					local var_430_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031102", "story_v_out_412031.awb") / 1000

					if var_430_20 + var_430_12 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_20 + var_430_12
					end

					if var_430_15.prefab_name ~= "" and arg_427_1.actors_[var_430_15.prefab_name] ~= nil then
						local var_430_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_15.prefab_name].transform, "story_v_out_412031", "412031102", "story_v_out_412031.awb")

						arg_427_1:RecordAudio("412031102", var_430_21)
						arg_427_1:RecordAudio("412031102", var_430_21)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_412031", "412031102", "story_v_out_412031.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_412031", "412031102", "story_v_out_412031.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_22 = math.max(var_430_13, arg_427_1.talkMaxDuration)

			if var_430_12 <= arg_427_1.time_ and arg_427_1.time_ < var_430_12 + var_430_22 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_12) / var_430_22

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_12 + var_430_22 and arg_427_1.time_ < var_430_12 + var_430_22 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play412031103 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 412031103
		arg_431_1.duration_ = 4.13

		local var_431_0 = {
			zh = 4.133,
			ja = 1.999999999999
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play412031104(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1097ui_story"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1097ui_story == nil then
				arg_431_1.var_.characterEffect1097ui_story = var_434_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.200000002980232

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 and not isNil(var_434_0) then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.characterEffect1097ui_story and not isNil(var_434_0) then
					arg_431_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1097ui_story then
				arg_431_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_434_4 = 0

			if var_434_4 < arg_431_1.time_ and arg_431_1.time_ <= var_434_4 + arg_434_0 then
				arg_431_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_434_5 = 0

			if var_434_5 < arg_431_1.time_ and arg_431_1.time_ <= var_434_5 + arg_434_0 then
				arg_431_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_434_6 = arg_431_1.actors_["3043ui_story"]
			local var_434_7 = 0

			if var_434_7 < arg_431_1.time_ and arg_431_1.time_ <= var_434_7 + arg_434_0 and not isNil(var_434_6) and arg_431_1.var_.characterEffect3043ui_story == nil then
				arg_431_1.var_.characterEffect3043ui_story = var_434_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_8 = 0.200000002980232

			if var_434_7 <= arg_431_1.time_ and arg_431_1.time_ < var_434_7 + var_434_8 and not isNil(var_434_6) then
				local var_434_9 = (arg_431_1.time_ - var_434_7) / var_434_8

				if arg_431_1.var_.characterEffect3043ui_story and not isNil(var_434_6) then
					local var_434_10 = Mathf.Lerp(0, 0.5, var_434_9)

					arg_431_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_431_1.var_.characterEffect3043ui_story.fillRatio = var_434_10
				end
			end

			if arg_431_1.time_ >= var_434_7 + var_434_8 and arg_431_1.time_ < var_434_7 + var_434_8 + arg_434_0 and not isNil(var_434_6) and arg_431_1.var_.characterEffect3043ui_story then
				local var_434_11 = 0.5

				arg_431_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_431_1.var_.characterEffect3043ui_story.fillRatio = var_434_11
			end

			local var_434_12 = 0
			local var_434_13 = 0.325

			if var_434_12 < arg_431_1.time_ and arg_431_1.time_ <= var_434_12 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_14 = arg_431_1:FormatText(StoryNameCfg[216].name)

				arg_431_1.leftNameTxt_.text = var_434_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_15 = arg_431_1:GetWordFromCfg(412031103)
				local var_434_16 = arg_431_1:FormatText(var_434_15.content)

				arg_431_1.text_.text = var_434_16

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_17 = 13
				local var_434_18 = utf8.len(var_434_16)
				local var_434_19 = var_434_17 <= 0 and var_434_13 or var_434_13 * (var_434_18 / var_434_17)

				if var_434_19 > 0 and var_434_13 < var_434_19 then
					arg_431_1.talkMaxDuration = var_434_19

					if var_434_19 + var_434_12 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_19 + var_434_12
					end
				end

				arg_431_1.text_.text = var_434_16
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031103", "story_v_out_412031.awb") ~= 0 then
					local var_434_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031103", "story_v_out_412031.awb") / 1000

					if var_434_20 + var_434_12 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_20 + var_434_12
					end

					if var_434_15.prefab_name ~= "" and arg_431_1.actors_[var_434_15.prefab_name] ~= nil then
						local var_434_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_15.prefab_name].transform, "story_v_out_412031", "412031103", "story_v_out_412031.awb")

						arg_431_1:RecordAudio("412031103", var_434_21)
						arg_431_1:RecordAudio("412031103", var_434_21)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_412031", "412031103", "story_v_out_412031.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_412031", "412031103", "story_v_out_412031.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_22 = math.max(var_434_13, arg_431_1.talkMaxDuration)

			if var_434_12 <= arg_431_1.time_ and arg_431_1.time_ < var_434_12 + var_434_22 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_12) / var_434_22

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_12 + var_434_22 and arg_431_1.time_ < var_434_12 + var_434_22 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play412031104 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 412031104
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play412031105(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1097ui_story"].transform
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.var_.moveOldPos1097ui_story = var_438_0.localPosition
			end

			local var_438_2 = 0.001

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2
				local var_438_4 = Vector3.New(0, 100, 0)

				var_438_0.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1097ui_story, var_438_4, var_438_3)

				local var_438_5 = manager.ui.mainCamera.transform.position - var_438_0.position

				var_438_0.forward = Vector3.New(var_438_5.x, var_438_5.y, var_438_5.z)

				local var_438_6 = var_438_0.localEulerAngles

				var_438_6.z = 0
				var_438_6.x = 0
				var_438_0.localEulerAngles = var_438_6
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 then
				var_438_0.localPosition = Vector3.New(0, 100, 0)

				local var_438_7 = manager.ui.mainCamera.transform.position - var_438_0.position

				var_438_0.forward = Vector3.New(var_438_7.x, var_438_7.y, var_438_7.z)

				local var_438_8 = var_438_0.localEulerAngles

				var_438_8.z = 0
				var_438_8.x = 0
				var_438_0.localEulerAngles = var_438_8
			end

			local var_438_9 = arg_435_1.actors_["1097ui_story"]
			local var_438_10 = 0

			if var_438_10 < arg_435_1.time_ and arg_435_1.time_ <= var_438_10 + arg_438_0 and not isNil(var_438_9) and arg_435_1.var_.characterEffect1097ui_story == nil then
				arg_435_1.var_.characterEffect1097ui_story = var_438_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_11 = 0.034000001847744

			if var_438_10 <= arg_435_1.time_ and arg_435_1.time_ < var_438_10 + var_438_11 and not isNil(var_438_9) then
				local var_438_12 = (arg_435_1.time_ - var_438_10) / var_438_11

				if arg_435_1.var_.characterEffect1097ui_story and not isNil(var_438_9) then
					local var_438_13 = Mathf.Lerp(0, 0.5, var_438_12)

					arg_435_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1097ui_story.fillRatio = var_438_13
				end
			end

			if arg_435_1.time_ >= var_438_10 + var_438_11 and arg_435_1.time_ < var_438_10 + var_438_11 + arg_438_0 and not isNil(var_438_9) and arg_435_1.var_.characterEffect1097ui_story then
				local var_438_14 = 0.5

				arg_435_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1097ui_story.fillRatio = var_438_14
			end

			local var_438_15 = arg_435_1.actors_["3043ui_story"].transform
			local var_438_16 = 0

			if var_438_16 < arg_435_1.time_ and arg_435_1.time_ <= var_438_16 + arg_438_0 then
				arg_435_1.var_.moveOldPos3043ui_story = var_438_15.localPosition
			end

			local var_438_17 = 0.001

			if var_438_16 <= arg_435_1.time_ and arg_435_1.time_ < var_438_16 + var_438_17 then
				local var_438_18 = (arg_435_1.time_ - var_438_16) / var_438_17
				local var_438_19 = Vector3.New(0, 100, 0)

				var_438_15.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos3043ui_story, var_438_19, var_438_18)

				local var_438_20 = manager.ui.mainCamera.transform.position - var_438_15.position

				var_438_15.forward = Vector3.New(var_438_20.x, var_438_20.y, var_438_20.z)

				local var_438_21 = var_438_15.localEulerAngles

				var_438_21.z = 0
				var_438_21.x = 0
				var_438_15.localEulerAngles = var_438_21
			end

			if arg_435_1.time_ >= var_438_16 + var_438_17 and arg_435_1.time_ < var_438_16 + var_438_17 + arg_438_0 then
				var_438_15.localPosition = Vector3.New(0, 100, 0)

				local var_438_22 = manager.ui.mainCamera.transform.position - var_438_15.position

				var_438_15.forward = Vector3.New(var_438_22.x, var_438_22.y, var_438_22.z)

				local var_438_23 = var_438_15.localEulerAngles

				var_438_23.z = 0
				var_438_23.x = 0
				var_438_15.localEulerAngles = var_438_23
			end

			local var_438_24 = arg_435_1.actors_["3043ui_story"]
			local var_438_25 = 0

			if var_438_25 < arg_435_1.time_ and arg_435_1.time_ <= var_438_25 + arg_438_0 and not isNil(var_438_24) and arg_435_1.var_.characterEffect3043ui_story == nil then
				arg_435_1.var_.characterEffect3043ui_story = var_438_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_26 = 0.034000001847744

			if var_438_25 <= arg_435_1.time_ and arg_435_1.time_ < var_438_25 + var_438_26 and not isNil(var_438_24) then
				local var_438_27 = (arg_435_1.time_ - var_438_25) / var_438_26

				if arg_435_1.var_.characterEffect3043ui_story and not isNil(var_438_24) then
					local var_438_28 = Mathf.Lerp(0, 0.5, var_438_27)

					arg_435_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_435_1.var_.characterEffect3043ui_story.fillRatio = var_438_28
				end
			end

			if arg_435_1.time_ >= var_438_25 + var_438_26 and arg_435_1.time_ < var_438_25 + var_438_26 + arg_438_0 and not isNil(var_438_24) and arg_435_1.var_.characterEffect3043ui_story then
				local var_438_29 = 0.5

				arg_435_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_435_1.var_.characterEffect3043ui_story.fillRatio = var_438_29
			end

			local var_438_30 = 0
			local var_438_31 = 0.15

			if var_438_30 < arg_435_1.time_ and arg_435_1.time_ <= var_438_30 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_32 = arg_435_1:GetWordFromCfg(412031104)
				local var_438_33 = arg_435_1:FormatText(var_438_32.content)

				arg_435_1.text_.text = var_438_33

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_34 = 6
				local var_438_35 = utf8.len(var_438_33)
				local var_438_36 = var_438_34 <= 0 and var_438_31 or var_438_31 * (var_438_35 / var_438_34)

				if var_438_36 > 0 and var_438_31 < var_438_36 then
					arg_435_1.talkMaxDuration = var_438_36

					if var_438_36 + var_438_30 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_36 + var_438_30
					end
				end

				arg_435_1.text_.text = var_438_33
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_37 = math.max(var_438_31, arg_435_1.talkMaxDuration)

			if var_438_30 <= arg_435_1.time_ and arg_435_1.time_ < var_438_30 + var_438_37 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_30) / var_438_37

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_30 + var_438_37 and arg_435_1.time_ < var_438_30 + var_438_37 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play412031105 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 412031105
		arg_439_1.duration_ = 2

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play412031106(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = arg_439_1.actors_["1097ui_story"].transform
			local var_442_1 = 0

			if var_442_1 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 then
				arg_439_1.var_.moveOldPos1097ui_story = var_442_0.localPosition
			end

			local var_442_2 = 0.001

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_2 then
				local var_442_3 = (arg_439_1.time_ - var_442_1) / var_442_2
				local var_442_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_442_0.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos1097ui_story, var_442_4, var_442_3)

				local var_442_5 = manager.ui.mainCamera.transform.position - var_442_0.position

				var_442_0.forward = Vector3.New(var_442_5.x, var_442_5.y, var_442_5.z)

				local var_442_6 = var_442_0.localEulerAngles

				var_442_6.z = 0
				var_442_6.x = 0
				var_442_0.localEulerAngles = var_442_6
			end

			if arg_439_1.time_ >= var_442_1 + var_442_2 and arg_439_1.time_ < var_442_1 + var_442_2 + arg_442_0 then
				var_442_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_442_7 = manager.ui.mainCamera.transform.position - var_442_0.position

				var_442_0.forward = Vector3.New(var_442_7.x, var_442_7.y, var_442_7.z)

				local var_442_8 = var_442_0.localEulerAngles

				var_442_8.z = 0
				var_442_8.x = 0
				var_442_0.localEulerAngles = var_442_8
			end

			local var_442_9 = arg_439_1.actors_["1097ui_story"]
			local var_442_10 = 0

			if var_442_10 < arg_439_1.time_ and arg_439_1.time_ <= var_442_10 + arg_442_0 and not isNil(var_442_9) and arg_439_1.var_.characterEffect1097ui_story == nil then
				arg_439_1.var_.characterEffect1097ui_story = var_442_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_11 = 0.200000002980232

			if var_442_10 <= arg_439_1.time_ and arg_439_1.time_ < var_442_10 + var_442_11 and not isNil(var_442_9) then
				local var_442_12 = (arg_439_1.time_ - var_442_10) / var_442_11

				if arg_439_1.var_.characterEffect1097ui_story and not isNil(var_442_9) then
					arg_439_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= var_442_10 + var_442_11 and arg_439_1.time_ < var_442_10 + var_442_11 + arg_442_0 and not isNil(var_442_9) and arg_439_1.var_.characterEffect1097ui_story then
				arg_439_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_442_13 = 0

			if var_442_13 < arg_439_1.time_ and arg_439_1.time_ <= var_442_13 + arg_442_0 then
				arg_439_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_442_14 = 0

			if var_442_14 < arg_439_1.time_ and arg_439_1.time_ <= var_442_14 + arg_442_0 then
				arg_439_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_442_15 = 0
			local var_442_16 = 0.1

			if var_442_15 < arg_439_1.time_ and arg_439_1.time_ <= var_442_15 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_17 = arg_439_1:FormatText(StoryNameCfg[216].name)

				arg_439_1.leftNameTxt_.text = var_442_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_18 = arg_439_1:GetWordFromCfg(412031105)
				local var_442_19 = arg_439_1:FormatText(var_442_18.content)

				arg_439_1.text_.text = var_442_19

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_20 = 4
				local var_442_21 = utf8.len(var_442_19)
				local var_442_22 = var_442_20 <= 0 and var_442_16 or var_442_16 * (var_442_21 / var_442_20)

				if var_442_22 > 0 and var_442_16 < var_442_22 then
					arg_439_1.talkMaxDuration = var_442_22

					if var_442_22 + var_442_15 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_22 + var_442_15
					end
				end

				arg_439_1.text_.text = var_442_19
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031105", "story_v_out_412031.awb") ~= 0 then
					local var_442_23 = manager.audio:GetVoiceLength("story_v_out_412031", "412031105", "story_v_out_412031.awb") / 1000

					if var_442_23 + var_442_15 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_23 + var_442_15
					end

					if var_442_18.prefab_name ~= "" and arg_439_1.actors_[var_442_18.prefab_name] ~= nil then
						local var_442_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_18.prefab_name].transform, "story_v_out_412031", "412031105", "story_v_out_412031.awb")

						arg_439_1:RecordAudio("412031105", var_442_24)
						arg_439_1:RecordAudio("412031105", var_442_24)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_412031", "412031105", "story_v_out_412031.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_412031", "412031105", "story_v_out_412031.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_25 = math.max(var_442_16, arg_439_1.talkMaxDuration)

			if var_442_15 <= arg_439_1.time_ and arg_439_1.time_ < var_442_15 + var_442_25 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_15) / var_442_25

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_15 + var_442_25 and arg_439_1.time_ < var_442_15 + var_442_25 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_439_1:InitPlayNodeList()
	end,
	Play412031106 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 412031106
		arg_443_1.duration_ = 6.5

		local var_443_0 = {
			zh = 5.966,
			ja = 6.5
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
				arg_443_0:Play412031107(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = arg_443_1.actors_["3043ui_story"].transform
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				arg_443_1.var_.moveOldPos3043ui_story = var_446_0.localPosition
			end

			local var_446_2 = 0.001

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_2 then
				local var_446_3 = (arg_443_1.time_ - var_446_1) / var_446_2
				local var_446_4 = Vector3.New(0.7, -1.41, -5.7)

				var_446_0.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos3043ui_story, var_446_4, var_446_3)

				local var_446_5 = manager.ui.mainCamera.transform.position - var_446_0.position

				var_446_0.forward = Vector3.New(var_446_5.x, var_446_5.y, var_446_5.z)

				local var_446_6 = var_446_0.localEulerAngles

				var_446_6.z = 0
				var_446_6.x = 0
				var_446_0.localEulerAngles = var_446_6
			end

			if arg_443_1.time_ >= var_446_1 + var_446_2 and arg_443_1.time_ < var_446_1 + var_446_2 + arg_446_0 then
				var_446_0.localPosition = Vector3.New(0.7, -1.41, -5.7)

				local var_446_7 = manager.ui.mainCamera.transform.position - var_446_0.position

				var_446_0.forward = Vector3.New(var_446_7.x, var_446_7.y, var_446_7.z)

				local var_446_8 = var_446_0.localEulerAngles

				var_446_8.z = 0
				var_446_8.x = 0
				var_446_0.localEulerAngles = var_446_8
			end

			local var_446_9 = arg_443_1.actors_["3043ui_story"]
			local var_446_10 = 0

			if var_446_10 < arg_443_1.time_ and arg_443_1.time_ <= var_446_10 + arg_446_0 and not isNil(var_446_9) and arg_443_1.var_.characterEffect3043ui_story == nil then
				arg_443_1.var_.characterEffect3043ui_story = var_446_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_11 = 0.200000002980232

			if var_446_10 <= arg_443_1.time_ and arg_443_1.time_ < var_446_10 + var_446_11 and not isNil(var_446_9) then
				local var_446_12 = (arg_443_1.time_ - var_446_10) / var_446_11

				if arg_443_1.var_.characterEffect3043ui_story and not isNil(var_446_9) then
					arg_443_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_443_1.time_ >= var_446_10 + var_446_11 and arg_443_1.time_ < var_446_10 + var_446_11 + arg_446_0 and not isNil(var_446_9) and arg_443_1.var_.characterEffect3043ui_story then
				arg_443_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_446_13 = 0

			if var_446_13 < arg_443_1.time_ and arg_443_1.time_ <= var_446_13 + arg_446_0 then
				arg_443_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_446_14 = 0

			if var_446_14 < arg_443_1.time_ and arg_443_1.time_ <= var_446_14 + arg_446_0 then
				arg_443_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_446_15 = arg_443_1.actors_["1097ui_story"]
			local var_446_16 = 0

			if var_446_16 < arg_443_1.time_ and arg_443_1.time_ <= var_446_16 + arg_446_0 and not isNil(var_446_15) and arg_443_1.var_.characterEffect1097ui_story == nil then
				arg_443_1.var_.characterEffect1097ui_story = var_446_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_17 = 0.200000002980232

			if var_446_16 <= arg_443_1.time_ and arg_443_1.time_ < var_446_16 + var_446_17 and not isNil(var_446_15) then
				local var_446_18 = (arg_443_1.time_ - var_446_16) / var_446_17

				if arg_443_1.var_.characterEffect1097ui_story and not isNil(var_446_15) then
					local var_446_19 = Mathf.Lerp(0, 0.5, var_446_18)

					arg_443_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_443_1.var_.characterEffect1097ui_story.fillRatio = var_446_19
				end
			end

			if arg_443_1.time_ >= var_446_16 + var_446_17 and arg_443_1.time_ < var_446_16 + var_446_17 + arg_446_0 and not isNil(var_446_15) and arg_443_1.var_.characterEffect1097ui_story then
				local var_446_20 = 0.5

				arg_443_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_443_1.var_.characterEffect1097ui_story.fillRatio = var_446_20
			end

			local var_446_21 = 0
			local var_446_22 = 0.625

			if var_446_21 < arg_443_1.time_ and arg_443_1.time_ <= var_446_21 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_23 = arg_443_1:FormatText(StoryNameCfg[920].name)

				arg_443_1.leftNameTxt_.text = var_446_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_24 = arg_443_1:GetWordFromCfg(412031106)
				local var_446_25 = arg_443_1:FormatText(var_446_24.content)

				arg_443_1.text_.text = var_446_25

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_26 = 25
				local var_446_27 = utf8.len(var_446_25)
				local var_446_28 = var_446_26 <= 0 and var_446_22 or var_446_22 * (var_446_27 / var_446_26)

				if var_446_28 > 0 and var_446_22 < var_446_28 then
					arg_443_1.talkMaxDuration = var_446_28

					if var_446_28 + var_446_21 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_28 + var_446_21
					end
				end

				arg_443_1.text_.text = var_446_25
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031106", "story_v_out_412031.awb") ~= 0 then
					local var_446_29 = manager.audio:GetVoiceLength("story_v_out_412031", "412031106", "story_v_out_412031.awb") / 1000

					if var_446_29 + var_446_21 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_29 + var_446_21
					end

					if var_446_24.prefab_name ~= "" and arg_443_1.actors_[var_446_24.prefab_name] ~= nil then
						local var_446_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_24.prefab_name].transform, "story_v_out_412031", "412031106", "story_v_out_412031.awb")

						arg_443_1:RecordAudio("412031106", var_446_30)
						arg_443_1:RecordAudio("412031106", var_446_30)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_412031", "412031106", "story_v_out_412031.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_412031", "412031106", "story_v_out_412031.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_31 = math.max(var_446_22, arg_443_1.talkMaxDuration)

			if var_446_21 <= arg_443_1.time_ and arg_443_1.time_ < var_446_21 + var_446_31 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_21) / var_446_31

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_21 + var_446_31 and arg_443_1.time_ < var_446_21 + var_446_31 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play412031107 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 412031107
		arg_447_1.duration_ = 8.6

		local var_447_0 = {
			zh = 8.6,
			ja = 8.4
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
				arg_447_0:Play412031108(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0
			local var_450_1 = 0.8

			if var_450_0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_2 = arg_447_1:FormatText(StoryNameCfg[920].name)

				arg_447_1.leftNameTxt_.text = var_450_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_3 = arg_447_1:GetWordFromCfg(412031107)
				local var_450_4 = arg_447_1:FormatText(var_450_3.content)

				arg_447_1.text_.text = var_450_4

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_5 = 32
				local var_450_6 = utf8.len(var_450_4)
				local var_450_7 = var_450_5 <= 0 and var_450_1 or var_450_1 * (var_450_6 / var_450_5)

				if var_450_7 > 0 and var_450_1 < var_450_7 then
					arg_447_1.talkMaxDuration = var_450_7

					if var_450_7 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_7 + var_450_0
					end
				end

				arg_447_1.text_.text = var_450_4
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031107", "story_v_out_412031.awb") ~= 0 then
					local var_450_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031107", "story_v_out_412031.awb") / 1000

					if var_450_8 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_8 + var_450_0
					end

					if var_450_3.prefab_name ~= "" and arg_447_1.actors_[var_450_3.prefab_name] ~= nil then
						local var_450_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_3.prefab_name].transform, "story_v_out_412031", "412031107", "story_v_out_412031.awb")

						arg_447_1:RecordAudio("412031107", var_450_9)
						arg_447_1:RecordAudio("412031107", var_450_9)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_412031", "412031107", "story_v_out_412031.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_412031", "412031107", "story_v_out_412031.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_10 = math.max(var_450_1, arg_447_1.talkMaxDuration)

			if var_450_0 <= arg_447_1.time_ and arg_447_1.time_ < var_450_0 + var_450_10 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_0) / var_450_10

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_0 + var_450_10 and arg_447_1.time_ < var_450_0 + var_450_10 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play412031108 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 412031108
		arg_451_1.duration_ = 12.67

		local var_451_0 = {
			zh = 12.666,
			ja = 7.466
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
				arg_451_0:Play412031109(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0
			local var_454_1 = 1.2

			if var_454_0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_2 = arg_451_1:FormatText(StoryNameCfg[920].name)

				arg_451_1.leftNameTxt_.text = var_454_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_3 = arg_451_1:GetWordFromCfg(412031108)
				local var_454_4 = arg_451_1:FormatText(var_454_3.content)

				arg_451_1.text_.text = var_454_4

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_5 = 48
				local var_454_6 = utf8.len(var_454_4)
				local var_454_7 = var_454_5 <= 0 and var_454_1 or var_454_1 * (var_454_6 / var_454_5)

				if var_454_7 > 0 and var_454_1 < var_454_7 then
					arg_451_1.talkMaxDuration = var_454_7

					if var_454_7 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_7 + var_454_0
					end
				end

				arg_451_1.text_.text = var_454_4
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031108", "story_v_out_412031.awb") ~= 0 then
					local var_454_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031108", "story_v_out_412031.awb") / 1000

					if var_454_8 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_8 + var_454_0
					end

					if var_454_3.prefab_name ~= "" and arg_451_1.actors_[var_454_3.prefab_name] ~= nil then
						local var_454_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_3.prefab_name].transform, "story_v_out_412031", "412031108", "story_v_out_412031.awb")

						arg_451_1:RecordAudio("412031108", var_454_9)
						arg_451_1:RecordAudio("412031108", var_454_9)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_412031", "412031108", "story_v_out_412031.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_412031", "412031108", "story_v_out_412031.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_10 = math.max(var_454_1, arg_451_1.talkMaxDuration)

			if var_454_0 <= arg_451_1.time_ and arg_451_1.time_ < var_454_0 + var_454_10 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_0) / var_454_10

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_0 + var_454_10 and arg_451_1.time_ < var_454_0 + var_454_10 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play412031109 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 412031109
		arg_455_1.duration_ = 7.43

		local var_455_0 = {
			zh = 7.333,
			ja = 7.433
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
				arg_455_0:Play412031110(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["1097ui_story"]
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.characterEffect1097ui_story == nil then
				arg_455_1.var_.characterEffect1097ui_story = var_458_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_2 = 0.200000002980232

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_2 and not isNil(var_458_0) then
				local var_458_3 = (arg_455_1.time_ - var_458_1) / var_458_2

				if arg_455_1.var_.characterEffect1097ui_story and not isNil(var_458_0) then
					arg_455_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_455_1.time_ >= var_458_1 + var_458_2 and arg_455_1.time_ < var_458_1 + var_458_2 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.characterEffect1097ui_story then
				arg_455_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_458_4 = 0

			if var_458_4 < arg_455_1.time_ and arg_455_1.time_ <= var_458_4 + arg_458_0 then
				arg_455_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_458_5 = 0

			if var_458_5 < arg_455_1.time_ and arg_455_1.time_ <= var_458_5 + arg_458_0 then
				arg_455_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_458_6 = arg_455_1.actors_["3043ui_story"]
			local var_458_7 = 0

			if var_458_7 < arg_455_1.time_ and arg_455_1.time_ <= var_458_7 + arg_458_0 and not isNil(var_458_6) and arg_455_1.var_.characterEffect3043ui_story == nil then
				arg_455_1.var_.characterEffect3043ui_story = var_458_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_8 = 0.200000002980232

			if var_458_7 <= arg_455_1.time_ and arg_455_1.time_ < var_458_7 + var_458_8 and not isNil(var_458_6) then
				local var_458_9 = (arg_455_1.time_ - var_458_7) / var_458_8

				if arg_455_1.var_.characterEffect3043ui_story and not isNil(var_458_6) then
					local var_458_10 = Mathf.Lerp(0, 0.5, var_458_9)

					arg_455_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_455_1.var_.characterEffect3043ui_story.fillRatio = var_458_10
				end
			end

			if arg_455_1.time_ >= var_458_7 + var_458_8 and arg_455_1.time_ < var_458_7 + var_458_8 + arg_458_0 and not isNil(var_458_6) and arg_455_1.var_.characterEffect3043ui_story then
				local var_458_11 = 0.5

				arg_455_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_455_1.var_.characterEffect3043ui_story.fillRatio = var_458_11
			end

			local var_458_12 = 0
			local var_458_13 = 0.675

			if var_458_12 < arg_455_1.time_ and arg_455_1.time_ <= var_458_12 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_14 = arg_455_1:FormatText(StoryNameCfg[216].name)

				arg_455_1.leftNameTxt_.text = var_458_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_15 = arg_455_1:GetWordFromCfg(412031109)
				local var_458_16 = arg_455_1:FormatText(var_458_15.content)

				arg_455_1.text_.text = var_458_16

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_17 = 27
				local var_458_18 = utf8.len(var_458_16)
				local var_458_19 = var_458_17 <= 0 and var_458_13 or var_458_13 * (var_458_18 / var_458_17)

				if var_458_19 > 0 and var_458_13 < var_458_19 then
					arg_455_1.talkMaxDuration = var_458_19

					if var_458_19 + var_458_12 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_19 + var_458_12
					end
				end

				arg_455_1.text_.text = var_458_16
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031109", "story_v_out_412031.awb") ~= 0 then
					local var_458_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031109", "story_v_out_412031.awb") / 1000

					if var_458_20 + var_458_12 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_20 + var_458_12
					end

					if var_458_15.prefab_name ~= "" and arg_455_1.actors_[var_458_15.prefab_name] ~= nil then
						local var_458_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_15.prefab_name].transform, "story_v_out_412031", "412031109", "story_v_out_412031.awb")

						arg_455_1:RecordAudio("412031109", var_458_21)
						arg_455_1:RecordAudio("412031109", var_458_21)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_412031", "412031109", "story_v_out_412031.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_412031", "412031109", "story_v_out_412031.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_22 = math.max(var_458_13, arg_455_1.talkMaxDuration)

			if var_458_12 <= arg_455_1.time_ and arg_455_1.time_ < var_458_12 + var_458_22 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_12) / var_458_22

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_12 + var_458_22 and arg_455_1.time_ < var_458_12 + var_458_22 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play412031110 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 412031110
		arg_459_1.duration_ = 10.23

		local var_459_0 = {
			zh = 10.233,
			ja = 6.3
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
				arg_459_0:Play412031111(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0
			local var_462_1 = 0.95

			if var_462_0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_2 = arg_459_1:FormatText(StoryNameCfg[216].name)

				arg_459_1.leftNameTxt_.text = var_462_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_3 = arg_459_1:GetWordFromCfg(412031110)
				local var_462_4 = arg_459_1:FormatText(var_462_3.content)

				arg_459_1.text_.text = var_462_4

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031110", "story_v_out_412031.awb") ~= 0 then
					local var_462_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031110", "story_v_out_412031.awb") / 1000

					if var_462_8 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_8 + var_462_0
					end

					if var_462_3.prefab_name ~= "" and arg_459_1.actors_[var_462_3.prefab_name] ~= nil then
						local var_462_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_3.prefab_name].transform, "story_v_out_412031", "412031110", "story_v_out_412031.awb")

						arg_459_1:RecordAudio("412031110", var_462_9)
						arg_459_1:RecordAudio("412031110", var_462_9)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_412031", "412031110", "story_v_out_412031.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_412031", "412031110", "story_v_out_412031.awb")
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
	Play412031111 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 412031111
		arg_463_1.duration_ = 8.6

		local var_463_0 = {
			zh = 8.6,
			ja = 4.166
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
				arg_463_0:Play412031112(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0
			local var_466_1 = 0.85

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_2 = arg_463_1:FormatText(StoryNameCfg[216].name)

				arg_463_1.leftNameTxt_.text = var_466_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_3 = arg_463_1:GetWordFromCfg(412031111)
				local var_466_4 = arg_463_1:FormatText(var_466_3.content)

				arg_463_1.text_.text = var_466_4

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031111", "story_v_out_412031.awb") ~= 0 then
					local var_466_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031111", "story_v_out_412031.awb") / 1000

					if var_466_8 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_8 + var_466_0
					end

					if var_466_3.prefab_name ~= "" and arg_463_1.actors_[var_466_3.prefab_name] ~= nil then
						local var_466_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_3.prefab_name].transform, "story_v_out_412031", "412031111", "story_v_out_412031.awb")

						arg_463_1:RecordAudio("412031111", var_466_9)
						arg_463_1:RecordAudio("412031111", var_466_9)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_412031", "412031111", "story_v_out_412031.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_412031", "412031111", "story_v_out_412031.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_10 = math.max(var_466_1, arg_463_1.talkMaxDuration)

			if var_466_0 <= arg_463_1.time_ and arg_463_1.time_ < var_466_0 + var_466_10 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_0) / var_466_10

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_0 + var_466_10 and arg_463_1.time_ < var_466_0 + var_466_10 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play412031112 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 412031112
		arg_467_1.duration_ = 8.3

		local var_467_0 = {
			zh = 8.3,
			ja = 4.9
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play412031113(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = arg_467_1.actors_["3043ui_story"]
			local var_470_1 = 0

			if var_470_1 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 and not isNil(var_470_0) and arg_467_1.var_.characterEffect3043ui_story == nil then
				arg_467_1.var_.characterEffect3043ui_story = var_470_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_2 = 0.200000002980232

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_2 and not isNil(var_470_0) then
				local var_470_3 = (arg_467_1.time_ - var_470_1) / var_470_2

				if arg_467_1.var_.characterEffect3043ui_story and not isNil(var_470_0) then
					arg_467_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= var_470_1 + var_470_2 and arg_467_1.time_ < var_470_1 + var_470_2 + arg_470_0 and not isNil(var_470_0) and arg_467_1.var_.characterEffect3043ui_story then
				arg_467_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_470_4 = 0

			if var_470_4 < arg_467_1.time_ and arg_467_1.time_ <= var_470_4 + arg_470_0 then
				arg_467_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action2_1")
			end

			local var_470_5 = 0

			if var_470_5 < arg_467_1.time_ and arg_467_1.time_ <= var_470_5 + arg_470_0 then
				arg_467_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_470_6 = arg_467_1.actors_["1097ui_story"]
			local var_470_7 = 0

			if var_470_7 < arg_467_1.time_ and arg_467_1.time_ <= var_470_7 + arg_470_0 and not isNil(var_470_6) and arg_467_1.var_.characterEffect1097ui_story == nil then
				arg_467_1.var_.characterEffect1097ui_story = var_470_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_8 = 0.200000002980232

			if var_470_7 <= arg_467_1.time_ and arg_467_1.time_ < var_470_7 + var_470_8 and not isNil(var_470_6) then
				local var_470_9 = (arg_467_1.time_ - var_470_7) / var_470_8

				if arg_467_1.var_.characterEffect1097ui_story and not isNil(var_470_6) then
					local var_470_10 = Mathf.Lerp(0, 0.5, var_470_9)

					arg_467_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_467_1.var_.characterEffect1097ui_story.fillRatio = var_470_10
				end
			end

			if arg_467_1.time_ >= var_470_7 + var_470_8 and arg_467_1.time_ < var_470_7 + var_470_8 + arg_470_0 and not isNil(var_470_6) and arg_467_1.var_.characterEffect1097ui_story then
				local var_470_11 = 0.5

				arg_467_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_467_1.var_.characterEffect1097ui_story.fillRatio = var_470_11
			end

			local var_470_12 = 0
			local var_470_13 = 0.7

			if var_470_12 < arg_467_1.time_ and arg_467_1.time_ <= var_470_12 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_14 = arg_467_1:FormatText(StoryNameCfg[920].name)

				arg_467_1.leftNameTxt_.text = var_470_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_15 = arg_467_1:GetWordFromCfg(412031112)
				local var_470_16 = arg_467_1:FormatText(var_470_15.content)

				arg_467_1.text_.text = var_470_16

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_17 = 28
				local var_470_18 = utf8.len(var_470_16)
				local var_470_19 = var_470_17 <= 0 and var_470_13 or var_470_13 * (var_470_18 / var_470_17)

				if var_470_19 > 0 and var_470_13 < var_470_19 then
					arg_467_1.talkMaxDuration = var_470_19

					if var_470_19 + var_470_12 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_19 + var_470_12
					end
				end

				arg_467_1.text_.text = var_470_16
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031112", "story_v_out_412031.awb") ~= 0 then
					local var_470_20 = manager.audio:GetVoiceLength("story_v_out_412031", "412031112", "story_v_out_412031.awb") / 1000

					if var_470_20 + var_470_12 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_20 + var_470_12
					end

					if var_470_15.prefab_name ~= "" and arg_467_1.actors_[var_470_15.prefab_name] ~= nil then
						local var_470_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_15.prefab_name].transform, "story_v_out_412031", "412031112", "story_v_out_412031.awb")

						arg_467_1:RecordAudio("412031112", var_470_21)
						arg_467_1:RecordAudio("412031112", var_470_21)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_412031", "412031112", "story_v_out_412031.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_412031", "412031112", "story_v_out_412031.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_22 = math.max(var_470_13, arg_467_1.talkMaxDuration)

			if var_470_12 <= arg_467_1.time_ and arg_467_1.time_ < var_470_12 + var_470_22 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_12) / var_470_22

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_12 + var_470_22 and arg_467_1.time_ < var_470_12 + var_470_22 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play412031113 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 412031113
		arg_471_1.duration_ = 4.57

		local var_471_0 = {
			zh = 4.566,
			ja = 3.5
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
				arg_471_0:Play412031114(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = arg_471_1.actors_["10076ui_story"].transform
			local var_474_1 = 0

			if var_474_1 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 then
				arg_471_1.var_.moveOldPos10076ui_story = var_474_0.localPosition
			end

			local var_474_2 = 0.001

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_2 then
				local var_474_3 = (arg_471_1.time_ - var_474_1) / var_474_2
				local var_474_4 = Vector3.New(0, -0.35, -4)

				var_474_0.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos10076ui_story, var_474_4, var_474_3)

				local var_474_5 = manager.ui.mainCamera.transform.position - var_474_0.position

				var_474_0.forward = Vector3.New(var_474_5.x, var_474_5.y, var_474_5.z)

				local var_474_6 = var_474_0.localEulerAngles

				var_474_6.z = 0
				var_474_6.x = 0
				var_474_0.localEulerAngles = var_474_6
			end

			if arg_471_1.time_ >= var_474_1 + var_474_2 and arg_471_1.time_ < var_474_1 + var_474_2 + arg_474_0 then
				var_474_0.localPosition = Vector3.New(0, -0.35, -4)

				local var_474_7 = manager.ui.mainCamera.transform.position - var_474_0.position

				var_474_0.forward = Vector3.New(var_474_7.x, var_474_7.y, var_474_7.z)

				local var_474_8 = var_474_0.localEulerAngles

				var_474_8.z = 0
				var_474_8.x = 0
				var_474_0.localEulerAngles = var_474_8
			end

			local var_474_9 = arg_471_1.actors_["10076ui_story"]
			local var_474_10 = 0

			if var_474_10 < arg_471_1.time_ and arg_471_1.time_ <= var_474_10 + arg_474_0 and not isNil(var_474_9) and arg_471_1.var_.characterEffect10076ui_story == nil then
				arg_471_1.var_.characterEffect10076ui_story = var_474_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_11 = 0.200000002980232

			if var_474_10 <= arg_471_1.time_ and arg_471_1.time_ < var_474_10 + var_474_11 and not isNil(var_474_9) then
				local var_474_12 = (arg_471_1.time_ - var_474_10) / var_474_11

				if arg_471_1.var_.characterEffect10076ui_story and not isNil(var_474_9) then
					arg_471_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_471_1.time_ >= var_474_10 + var_474_11 and arg_471_1.time_ < var_474_10 + var_474_11 + arg_474_0 and not isNil(var_474_9) and arg_471_1.var_.characterEffect10076ui_story then
				arg_471_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_474_13 = 0

			if var_474_13 < arg_471_1.time_ and arg_471_1.time_ <= var_474_13 + arg_474_0 then
				arg_471_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action3_1")
			end

			local var_474_14 = 0

			if var_474_14 < arg_471_1.time_ and arg_471_1.time_ <= var_474_14 + arg_474_0 then
				arg_471_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_474_15 = arg_471_1.actors_["1097ui_story"].transform
			local var_474_16 = 0

			if var_474_16 < arg_471_1.time_ and arg_471_1.time_ <= var_474_16 + arg_474_0 then
				arg_471_1.var_.moveOldPos1097ui_story = var_474_15.localPosition
			end

			local var_474_17 = 0.001

			if var_474_16 <= arg_471_1.time_ and arg_471_1.time_ < var_474_16 + var_474_17 then
				local var_474_18 = (arg_471_1.time_ - var_474_16) / var_474_17
				local var_474_19 = Vector3.New(0, 100, 0)

				var_474_15.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos1097ui_story, var_474_19, var_474_18)

				local var_474_20 = manager.ui.mainCamera.transform.position - var_474_15.position

				var_474_15.forward = Vector3.New(var_474_20.x, var_474_20.y, var_474_20.z)

				local var_474_21 = var_474_15.localEulerAngles

				var_474_21.z = 0
				var_474_21.x = 0
				var_474_15.localEulerAngles = var_474_21
			end

			if arg_471_1.time_ >= var_474_16 + var_474_17 and arg_471_1.time_ < var_474_16 + var_474_17 + arg_474_0 then
				var_474_15.localPosition = Vector3.New(0, 100, 0)

				local var_474_22 = manager.ui.mainCamera.transform.position - var_474_15.position

				var_474_15.forward = Vector3.New(var_474_22.x, var_474_22.y, var_474_22.z)

				local var_474_23 = var_474_15.localEulerAngles

				var_474_23.z = 0
				var_474_23.x = 0
				var_474_15.localEulerAngles = var_474_23
			end

			local var_474_24 = arg_471_1.actors_["1097ui_story"]
			local var_474_25 = 0

			if var_474_25 < arg_471_1.time_ and arg_471_1.time_ <= var_474_25 + arg_474_0 and not isNil(var_474_24) and arg_471_1.var_.characterEffect1097ui_story == nil then
				arg_471_1.var_.characterEffect1097ui_story = var_474_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_26 = 0.200000002980232

			if var_474_25 <= arg_471_1.time_ and arg_471_1.time_ < var_474_25 + var_474_26 and not isNil(var_474_24) then
				local var_474_27 = (arg_471_1.time_ - var_474_25) / var_474_26

				if arg_471_1.var_.characterEffect1097ui_story and not isNil(var_474_24) then
					local var_474_28 = Mathf.Lerp(0, 0.5, var_474_27)

					arg_471_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_471_1.var_.characterEffect1097ui_story.fillRatio = var_474_28
				end
			end

			if arg_471_1.time_ >= var_474_25 + var_474_26 and arg_471_1.time_ < var_474_25 + var_474_26 + arg_474_0 and not isNil(var_474_24) and arg_471_1.var_.characterEffect1097ui_story then
				local var_474_29 = 0.5

				arg_471_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_471_1.var_.characterEffect1097ui_story.fillRatio = var_474_29
			end

			local var_474_30 = arg_471_1.actors_["3043ui_story"].transform
			local var_474_31 = 0

			if var_474_31 < arg_471_1.time_ and arg_471_1.time_ <= var_474_31 + arg_474_0 then
				arg_471_1.var_.moveOldPos3043ui_story = var_474_30.localPosition
			end

			local var_474_32 = 0.001

			if var_474_31 <= arg_471_1.time_ and arg_471_1.time_ < var_474_31 + var_474_32 then
				local var_474_33 = (arg_471_1.time_ - var_474_31) / var_474_32
				local var_474_34 = Vector3.New(0, 100, 0)

				var_474_30.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos3043ui_story, var_474_34, var_474_33)

				local var_474_35 = manager.ui.mainCamera.transform.position - var_474_30.position

				var_474_30.forward = Vector3.New(var_474_35.x, var_474_35.y, var_474_35.z)

				local var_474_36 = var_474_30.localEulerAngles

				var_474_36.z = 0
				var_474_36.x = 0
				var_474_30.localEulerAngles = var_474_36
			end

			if arg_471_1.time_ >= var_474_31 + var_474_32 and arg_471_1.time_ < var_474_31 + var_474_32 + arg_474_0 then
				var_474_30.localPosition = Vector3.New(0, 100, 0)

				local var_474_37 = manager.ui.mainCamera.transform.position - var_474_30.position

				var_474_30.forward = Vector3.New(var_474_37.x, var_474_37.y, var_474_37.z)

				local var_474_38 = var_474_30.localEulerAngles

				var_474_38.z = 0
				var_474_38.x = 0
				var_474_30.localEulerAngles = var_474_38
			end

			local var_474_39 = arg_471_1.actors_["3043ui_story"]
			local var_474_40 = 0

			if var_474_40 < arg_471_1.time_ and arg_471_1.time_ <= var_474_40 + arg_474_0 and not isNil(var_474_39) and arg_471_1.var_.characterEffect3043ui_story == nil then
				arg_471_1.var_.characterEffect3043ui_story = var_474_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_41 = 0.200000002980232

			if var_474_40 <= arg_471_1.time_ and arg_471_1.time_ < var_474_40 + var_474_41 and not isNil(var_474_39) then
				local var_474_42 = (arg_471_1.time_ - var_474_40) / var_474_41

				if arg_471_1.var_.characterEffect3043ui_story and not isNil(var_474_39) then
					local var_474_43 = Mathf.Lerp(0, 0.5, var_474_42)

					arg_471_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_471_1.var_.characterEffect3043ui_story.fillRatio = var_474_43
				end
			end

			if arg_471_1.time_ >= var_474_40 + var_474_41 and arg_471_1.time_ < var_474_40 + var_474_41 + arg_474_0 and not isNil(var_474_39) and arg_471_1.var_.characterEffect3043ui_story then
				local var_474_44 = 0.5

				arg_471_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_471_1.var_.characterEffect3043ui_story.fillRatio = var_474_44
			end

			local var_474_45 = 0
			local var_474_46 = 0.6

			if var_474_45 < arg_471_1.time_ and arg_471_1.time_ <= var_474_45 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				local var_474_47 = arg_471_1:FormatText(StoryNameCfg[917].name)

				arg_471_1.leftNameTxt_.text = var_474_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_48 = arg_471_1:GetWordFromCfg(412031113)
				local var_474_49 = arg_471_1:FormatText(var_474_48.content)

				arg_471_1.text_.text = var_474_49

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_50 = 24
				local var_474_51 = utf8.len(var_474_49)
				local var_474_52 = var_474_50 <= 0 and var_474_46 or var_474_46 * (var_474_51 / var_474_50)

				if var_474_52 > 0 and var_474_46 < var_474_52 then
					arg_471_1.talkMaxDuration = var_474_52

					if var_474_52 + var_474_45 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_52 + var_474_45
					end
				end

				arg_471_1.text_.text = var_474_49
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031113", "story_v_out_412031.awb") ~= 0 then
					local var_474_53 = manager.audio:GetVoiceLength("story_v_out_412031", "412031113", "story_v_out_412031.awb") / 1000

					if var_474_53 + var_474_45 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_53 + var_474_45
					end

					if var_474_48.prefab_name ~= "" and arg_471_1.actors_[var_474_48.prefab_name] ~= nil then
						local var_474_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_48.prefab_name].transform, "story_v_out_412031", "412031113", "story_v_out_412031.awb")

						arg_471_1:RecordAudio("412031113", var_474_54)
						arg_471_1:RecordAudio("412031113", var_474_54)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_412031", "412031113", "story_v_out_412031.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_412031", "412031113", "story_v_out_412031.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_55 = math.max(var_474_46, arg_471_1.talkMaxDuration)

			if var_474_45 <= arg_471_1.time_ and arg_471_1.time_ < var_474_45 + var_474_55 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_45) / var_474_55

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_45 + var_474_55 and arg_471_1.time_ < var_474_45 + var_474_55 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play412031114 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 412031114
		arg_475_1.duration_ = 2

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play412031115(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = arg_475_1.actors_["1097ui_story"].transform
			local var_478_1 = 0

			if var_478_1 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 then
				arg_475_1.var_.moveOldPos1097ui_story = var_478_0.localPosition
			end

			local var_478_2 = 0.001

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_2 then
				local var_478_3 = (arg_475_1.time_ - var_478_1) / var_478_2
				local var_478_4 = Vector3.New(0, -0.54, -6.3)

				var_478_0.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1097ui_story, var_478_4, var_478_3)

				local var_478_5 = manager.ui.mainCamera.transform.position - var_478_0.position

				var_478_0.forward = Vector3.New(var_478_5.x, var_478_5.y, var_478_5.z)

				local var_478_6 = var_478_0.localEulerAngles

				var_478_6.z = 0
				var_478_6.x = 0
				var_478_0.localEulerAngles = var_478_6
			end

			if arg_475_1.time_ >= var_478_1 + var_478_2 and arg_475_1.time_ < var_478_1 + var_478_2 + arg_478_0 then
				var_478_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_478_7 = manager.ui.mainCamera.transform.position - var_478_0.position

				var_478_0.forward = Vector3.New(var_478_7.x, var_478_7.y, var_478_7.z)

				local var_478_8 = var_478_0.localEulerAngles

				var_478_8.z = 0
				var_478_8.x = 0
				var_478_0.localEulerAngles = var_478_8
			end

			local var_478_9 = arg_475_1.actors_["1097ui_story"]
			local var_478_10 = 0

			if var_478_10 < arg_475_1.time_ and arg_475_1.time_ <= var_478_10 + arg_478_0 and not isNil(var_478_9) and arg_475_1.var_.characterEffect1097ui_story == nil then
				arg_475_1.var_.characterEffect1097ui_story = var_478_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_11 = 0.200000002980232

			if var_478_10 <= arg_475_1.time_ and arg_475_1.time_ < var_478_10 + var_478_11 and not isNil(var_478_9) then
				local var_478_12 = (arg_475_1.time_ - var_478_10) / var_478_11

				if arg_475_1.var_.characterEffect1097ui_story and not isNil(var_478_9) then
					arg_475_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= var_478_10 + var_478_11 and arg_475_1.time_ < var_478_10 + var_478_11 + arg_478_0 and not isNil(var_478_9) and arg_475_1.var_.characterEffect1097ui_story then
				arg_475_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_478_13 = 0

			if var_478_13 < arg_475_1.time_ and arg_475_1.time_ <= var_478_13 + arg_478_0 then
				arg_475_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_478_14 = 0

			if var_478_14 < arg_475_1.time_ and arg_475_1.time_ <= var_478_14 + arg_478_0 then
				arg_475_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_478_15 = arg_475_1.actors_["10076ui_story"].transform
			local var_478_16 = 0

			if var_478_16 < arg_475_1.time_ and arg_475_1.time_ <= var_478_16 + arg_478_0 then
				arg_475_1.var_.moveOldPos10076ui_story = var_478_15.localPosition
			end

			local var_478_17 = 0.001

			if var_478_16 <= arg_475_1.time_ and arg_475_1.time_ < var_478_16 + var_478_17 then
				local var_478_18 = (arg_475_1.time_ - var_478_16) / var_478_17
				local var_478_19 = Vector3.New(0, 100, 0)

				var_478_15.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos10076ui_story, var_478_19, var_478_18)

				local var_478_20 = manager.ui.mainCamera.transform.position - var_478_15.position

				var_478_15.forward = Vector3.New(var_478_20.x, var_478_20.y, var_478_20.z)

				local var_478_21 = var_478_15.localEulerAngles

				var_478_21.z = 0
				var_478_21.x = 0
				var_478_15.localEulerAngles = var_478_21
			end

			if arg_475_1.time_ >= var_478_16 + var_478_17 and arg_475_1.time_ < var_478_16 + var_478_17 + arg_478_0 then
				var_478_15.localPosition = Vector3.New(0, 100, 0)

				local var_478_22 = manager.ui.mainCamera.transform.position - var_478_15.position

				var_478_15.forward = Vector3.New(var_478_22.x, var_478_22.y, var_478_22.z)

				local var_478_23 = var_478_15.localEulerAngles

				var_478_23.z = 0
				var_478_23.x = 0
				var_478_15.localEulerAngles = var_478_23
			end

			local var_478_24 = arg_475_1.actors_["10076ui_story"]
			local var_478_25 = 0

			if var_478_25 < arg_475_1.time_ and arg_475_1.time_ <= var_478_25 + arg_478_0 and not isNil(var_478_24) and arg_475_1.var_.characterEffect10076ui_story == nil then
				arg_475_1.var_.characterEffect10076ui_story = var_478_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_26 = 0.200000002980232

			if var_478_25 <= arg_475_1.time_ and arg_475_1.time_ < var_478_25 + var_478_26 and not isNil(var_478_24) then
				local var_478_27 = (arg_475_1.time_ - var_478_25) / var_478_26

				if arg_475_1.var_.characterEffect10076ui_story and not isNil(var_478_24) then
					local var_478_28 = Mathf.Lerp(0, 0.5, var_478_27)

					arg_475_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_475_1.var_.characterEffect10076ui_story.fillRatio = var_478_28
				end
			end

			if arg_475_1.time_ >= var_478_25 + var_478_26 and arg_475_1.time_ < var_478_25 + var_478_26 + arg_478_0 and not isNil(var_478_24) and arg_475_1.var_.characterEffect10076ui_story then
				local var_478_29 = 0.5

				arg_475_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_475_1.var_.characterEffect10076ui_story.fillRatio = var_478_29
			end

			local var_478_30 = 0
			local var_478_31 = 0.125

			if var_478_30 < arg_475_1.time_ and arg_475_1.time_ <= var_478_30 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_32 = arg_475_1:FormatText(StoryNameCfg[216].name)

				arg_475_1.leftNameTxt_.text = var_478_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_33 = arg_475_1:GetWordFromCfg(412031114)
				local var_478_34 = arg_475_1:FormatText(var_478_33.content)

				arg_475_1.text_.text = var_478_34

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_35 = 5
				local var_478_36 = utf8.len(var_478_34)
				local var_478_37 = var_478_35 <= 0 and var_478_31 or var_478_31 * (var_478_36 / var_478_35)

				if var_478_37 > 0 and var_478_31 < var_478_37 then
					arg_475_1.talkMaxDuration = var_478_37

					if var_478_37 + var_478_30 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_37 + var_478_30
					end
				end

				arg_475_1.text_.text = var_478_34
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031114", "story_v_out_412031.awb") ~= 0 then
					local var_478_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031114", "story_v_out_412031.awb") / 1000

					if var_478_38 + var_478_30 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_38 + var_478_30
					end

					if var_478_33.prefab_name ~= "" and arg_475_1.actors_[var_478_33.prefab_name] ~= nil then
						local var_478_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_33.prefab_name].transform, "story_v_out_412031", "412031114", "story_v_out_412031.awb")

						arg_475_1:RecordAudio("412031114", var_478_39)
						arg_475_1:RecordAudio("412031114", var_478_39)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_412031", "412031114", "story_v_out_412031.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_412031", "412031114", "story_v_out_412031.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_40 = math.max(var_478_31, arg_475_1.talkMaxDuration)

			if var_478_30 <= arg_475_1.time_ and arg_475_1.time_ < var_478_30 + var_478_40 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_30) / var_478_40

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_30 + var_478_40 and arg_475_1.time_ < var_478_30 + var_478_40 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_475_1:InitPlayNodeList()
	end,
	Play412031115 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 412031115
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play412031116(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = arg_479_1.actors_["1097ui_story"].transform
			local var_482_1 = 0

			if var_482_1 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 then
				arg_479_1.var_.moveOldPos1097ui_story = var_482_0.localPosition
			end

			local var_482_2 = 0.001

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_2 then
				local var_482_3 = (arg_479_1.time_ - var_482_1) / var_482_2
				local var_482_4 = Vector3.New(0, 100, 0)

				var_482_0.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos1097ui_story, var_482_4, var_482_3)

				local var_482_5 = manager.ui.mainCamera.transform.position - var_482_0.position

				var_482_0.forward = Vector3.New(var_482_5.x, var_482_5.y, var_482_5.z)

				local var_482_6 = var_482_0.localEulerAngles

				var_482_6.z = 0
				var_482_6.x = 0
				var_482_0.localEulerAngles = var_482_6
			end

			if arg_479_1.time_ >= var_482_1 + var_482_2 and arg_479_1.time_ < var_482_1 + var_482_2 + arg_482_0 then
				var_482_0.localPosition = Vector3.New(0, 100, 0)

				local var_482_7 = manager.ui.mainCamera.transform.position - var_482_0.position

				var_482_0.forward = Vector3.New(var_482_7.x, var_482_7.y, var_482_7.z)

				local var_482_8 = var_482_0.localEulerAngles

				var_482_8.z = 0
				var_482_8.x = 0
				var_482_0.localEulerAngles = var_482_8
			end

			local var_482_9 = arg_479_1.actors_["1097ui_story"]
			local var_482_10 = 0

			if var_482_10 < arg_479_1.time_ and arg_479_1.time_ <= var_482_10 + arg_482_0 and not isNil(var_482_9) and arg_479_1.var_.characterEffect1097ui_story == nil then
				arg_479_1.var_.characterEffect1097ui_story = var_482_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_11 = 0.200000002980232

			if var_482_10 <= arg_479_1.time_ and arg_479_1.time_ < var_482_10 + var_482_11 and not isNil(var_482_9) then
				local var_482_12 = (arg_479_1.time_ - var_482_10) / var_482_11

				if arg_479_1.var_.characterEffect1097ui_story and not isNil(var_482_9) then
					local var_482_13 = Mathf.Lerp(0, 0.5, var_482_12)

					arg_479_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_479_1.var_.characterEffect1097ui_story.fillRatio = var_482_13
				end
			end

			if arg_479_1.time_ >= var_482_10 + var_482_11 and arg_479_1.time_ < var_482_10 + var_482_11 + arg_482_0 and not isNil(var_482_9) and arg_479_1.var_.characterEffect1097ui_story then
				local var_482_14 = 0.5

				arg_479_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_479_1.var_.characterEffect1097ui_story.fillRatio = var_482_14
			end

			local var_482_15 = 0
			local var_482_16 = 1.25

			if var_482_15 < arg_479_1.time_ and arg_479_1.time_ <= var_482_15 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, false)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_17 = arg_479_1:GetWordFromCfg(412031115)
				local var_482_18 = arg_479_1:FormatText(var_482_17.content)

				arg_479_1.text_.text = var_482_18

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_19 = 50
				local var_482_20 = utf8.len(var_482_18)
				local var_482_21 = var_482_19 <= 0 and var_482_16 or var_482_16 * (var_482_20 / var_482_19)

				if var_482_21 > 0 and var_482_16 < var_482_21 then
					arg_479_1.talkMaxDuration = var_482_21

					if var_482_21 + var_482_15 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_21 + var_482_15
					end
				end

				arg_479_1.text_.text = var_482_18
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_22 = math.max(var_482_16, arg_479_1.talkMaxDuration)

			if var_482_15 <= arg_479_1.time_ and arg_479_1.time_ < var_482_15 + var_482_22 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_15) / var_482_22

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_15 + var_482_22 and arg_479_1.time_ < var_482_15 + var_482_22 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_479_1:InitPlayNodeList()
	end,
	Play412031116 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 412031116
		arg_483_1.duration_ = 5.47

		local var_483_0 = {
			zh = 3.933,
			ja = 5.466
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
				arg_483_0:Play412031117(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = arg_483_1.actors_["10076ui_story"].transform
			local var_486_1 = 0

			if var_486_1 < arg_483_1.time_ and arg_483_1.time_ <= var_486_1 + arg_486_0 then
				arg_483_1.var_.moveOldPos10076ui_story = var_486_0.localPosition
			end

			local var_486_2 = 0.001

			if var_486_1 <= arg_483_1.time_ and arg_483_1.time_ < var_486_1 + var_486_2 then
				local var_486_3 = (arg_483_1.time_ - var_486_1) / var_486_2
				local var_486_4 = Vector3.New(0, -0.35, -4)

				var_486_0.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos10076ui_story, var_486_4, var_486_3)

				local var_486_5 = manager.ui.mainCamera.transform.position - var_486_0.position

				var_486_0.forward = Vector3.New(var_486_5.x, var_486_5.y, var_486_5.z)

				local var_486_6 = var_486_0.localEulerAngles

				var_486_6.z = 0
				var_486_6.x = 0
				var_486_0.localEulerAngles = var_486_6
			end

			if arg_483_1.time_ >= var_486_1 + var_486_2 and arg_483_1.time_ < var_486_1 + var_486_2 + arg_486_0 then
				var_486_0.localPosition = Vector3.New(0, -0.35, -4)

				local var_486_7 = manager.ui.mainCamera.transform.position - var_486_0.position

				var_486_0.forward = Vector3.New(var_486_7.x, var_486_7.y, var_486_7.z)

				local var_486_8 = var_486_0.localEulerAngles

				var_486_8.z = 0
				var_486_8.x = 0
				var_486_0.localEulerAngles = var_486_8
			end

			local var_486_9 = arg_483_1.actors_["10076ui_story"]
			local var_486_10 = 0

			if var_486_10 < arg_483_1.time_ and arg_483_1.time_ <= var_486_10 + arg_486_0 and not isNil(var_486_9) and arg_483_1.var_.characterEffect10076ui_story == nil then
				arg_483_1.var_.characterEffect10076ui_story = var_486_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_11 = 0.200000002980232

			if var_486_10 <= arg_483_1.time_ and arg_483_1.time_ < var_486_10 + var_486_11 and not isNil(var_486_9) then
				local var_486_12 = (arg_483_1.time_ - var_486_10) / var_486_11

				if arg_483_1.var_.characterEffect10076ui_story and not isNil(var_486_9) then
					arg_483_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_483_1.time_ >= var_486_10 + var_486_11 and arg_483_1.time_ < var_486_10 + var_486_11 + arg_486_0 and not isNil(var_486_9) and arg_483_1.var_.characterEffect10076ui_story then
				arg_483_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_486_13 = 0

			if var_486_13 < arg_483_1.time_ and arg_483_1.time_ <= var_486_13 + arg_486_0 then
				arg_483_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			local var_486_14 = 0

			if var_486_14 < arg_483_1.time_ and arg_483_1.time_ <= var_486_14 + arg_486_0 then
				arg_483_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_486_15 = 0
			local var_486_16 = 0.5

			if var_486_15 < arg_483_1.time_ and arg_483_1.time_ <= var_486_15 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				local var_486_17 = arg_483_1:FormatText(StoryNameCfg[917].name)

				arg_483_1.leftNameTxt_.text = var_486_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_18 = arg_483_1:GetWordFromCfg(412031116)
				local var_486_19 = arg_483_1:FormatText(var_486_18.content)

				arg_483_1.text_.text = var_486_19

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_20 = 20
				local var_486_21 = utf8.len(var_486_19)
				local var_486_22 = var_486_20 <= 0 and var_486_16 or var_486_16 * (var_486_21 / var_486_20)

				if var_486_22 > 0 and var_486_16 < var_486_22 then
					arg_483_1.talkMaxDuration = var_486_22

					if var_486_22 + var_486_15 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_22 + var_486_15
					end
				end

				arg_483_1.text_.text = var_486_19
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031116", "story_v_out_412031.awb") ~= 0 then
					local var_486_23 = manager.audio:GetVoiceLength("story_v_out_412031", "412031116", "story_v_out_412031.awb") / 1000

					if var_486_23 + var_486_15 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_23 + var_486_15
					end

					if var_486_18.prefab_name ~= "" and arg_483_1.actors_[var_486_18.prefab_name] ~= nil then
						local var_486_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_18.prefab_name].transform, "story_v_out_412031", "412031116", "story_v_out_412031.awb")

						arg_483_1:RecordAudio("412031116", var_486_24)
						arg_483_1:RecordAudio("412031116", var_486_24)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_412031", "412031116", "story_v_out_412031.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_412031", "412031116", "story_v_out_412031.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_25 = math.max(var_486_16, arg_483_1.talkMaxDuration)

			if var_486_15 <= arg_483_1.time_ and arg_483_1.time_ < var_486_15 + var_486_25 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_15) / var_486_25

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_15 + var_486_25 and arg_483_1.time_ < var_486_15 + var_486_25 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_483_1:InitPlayNodeList()
	end,
	Play412031117 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 412031117
		arg_487_1.duration_ = 8.8

		local var_487_0 = {
			zh = 6.066,
			ja = 8.8
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play412031118(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0
			local var_490_1 = 0.85

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_2 = arg_487_1:FormatText(StoryNameCfg[917].name)

				arg_487_1.leftNameTxt_.text = var_490_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_3 = arg_487_1:GetWordFromCfg(412031117)
				local var_490_4 = arg_487_1:FormatText(var_490_3.content)

				arg_487_1.text_.text = var_490_4

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_5 = 34
				local var_490_6 = utf8.len(var_490_4)
				local var_490_7 = var_490_5 <= 0 and var_490_1 or var_490_1 * (var_490_6 / var_490_5)

				if var_490_7 > 0 and var_490_1 < var_490_7 then
					arg_487_1.talkMaxDuration = var_490_7

					if var_490_7 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_7 + var_490_0
					end
				end

				arg_487_1.text_.text = var_490_4
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031117", "story_v_out_412031.awb") ~= 0 then
					local var_490_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031117", "story_v_out_412031.awb") / 1000

					if var_490_8 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_8 + var_490_0
					end

					if var_490_3.prefab_name ~= "" and arg_487_1.actors_[var_490_3.prefab_name] ~= nil then
						local var_490_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_3.prefab_name].transform, "story_v_out_412031", "412031117", "story_v_out_412031.awb")

						arg_487_1:RecordAudio("412031117", var_490_9)
						arg_487_1:RecordAudio("412031117", var_490_9)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_412031", "412031117", "story_v_out_412031.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_412031", "412031117", "story_v_out_412031.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_10 = math.max(var_490_1, arg_487_1.talkMaxDuration)

			if var_490_0 <= arg_487_1.time_ and arg_487_1.time_ < var_490_0 + var_490_10 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_0) / var_490_10

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_0 + var_490_10 and arg_487_1.time_ < var_490_0 + var_490_10 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play412031118 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 412031118
		arg_491_1.duration_ = 11.37

		local var_491_0 = {
			zh = 11.366,
			ja = 8.633
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
				arg_491_0:Play412031119(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0
			local var_494_1 = 1.425

			if var_494_0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_2 = arg_491_1:FormatText(StoryNameCfg[917].name)

				arg_491_1.leftNameTxt_.text = var_494_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_3 = arg_491_1:GetWordFromCfg(412031118)
				local var_494_4 = arg_491_1:FormatText(var_494_3.content)

				arg_491_1.text_.text = var_494_4

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_5 = 57
				local var_494_6 = utf8.len(var_494_4)
				local var_494_7 = var_494_5 <= 0 and var_494_1 or var_494_1 * (var_494_6 / var_494_5)

				if var_494_7 > 0 and var_494_1 < var_494_7 then
					arg_491_1.talkMaxDuration = var_494_7

					if var_494_7 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_7 + var_494_0
					end
				end

				arg_491_1.text_.text = var_494_4
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031118", "story_v_out_412031.awb") ~= 0 then
					local var_494_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031118", "story_v_out_412031.awb") / 1000

					if var_494_8 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_8 + var_494_0
					end

					if var_494_3.prefab_name ~= "" and arg_491_1.actors_[var_494_3.prefab_name] ~= nil then
						local var_494_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_3.prefab_name].transform, "story_v_out_412031", "412031118", "story_v_out_412031.awb")

						arg_491_1:RecordAudio("412031118", var_494_9)
						arg_491_1:RecordAudio("412031118", var_494_9)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_412031", "412031118", "story_v_out_412031.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_412031", "412031118", "story_v_out_412031.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_10 = math.max(var_494_1, arg_491_1.talkMaxDuration)

			if var_494_0 <= arg_491_1.time_ and arg_491_1.time_ < var_494_0 + var_494_10 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_0) / var_494_10

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_0 + var_494_10 and arg_491_1.time_ < var_494_0 + var_494_10 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play412031119 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 412031119
		arg_495_1.duration_ = 4.8

		local var_495_0 = {
			zh = 4.8,
			ja = 3.133
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
				arg_495_0:Play412031120(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = arg_495_1.actors_["3043ui_story"].transform
			local var_498_1 = 0

			if var_498_1 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 then
				arg_495_1.var_.moveOldPos3043ui_story = var_498_0.localPosition
			end

			local var_498_2 = 0.001

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_2 then
				local var_498_3 = (arg_495_1.time_ - var_498_1) / var_498_2
				local var_498_4 = Vector3.New(0, -1.41, -5.7)

				var_498_0.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos3043ui_story, var_498_4, var_498_3)

				local var_498_5 = manager.ui.mainCamera.transform.position - var_498_0.position

				var_498_0.forward = Vector3.New(var_498_5.x, var_498_5.y, var_498_5.z)

				local var_498_6 = var_498_0.localEulerAngles

				var_498_6.z = 0
				var_498_6.x = 0
				var_498_0.localEulerAngles = var_498_6
			end

			if arg_495_1.time_ >= var_498_1 + var_498_2 and arg_495_1.time_ < var_498_1 + var_498_2 + arg_498_0 then
				var_498_0.localPosition = Vector3.New(0, -1.41, -5.7)

				local var_498_7 = manager.ui.mainCamera.transform.position - var_498_0.position

				var_498_0.forward = Vector3.New(var_498_7.x, var_498_7.y, var_498_7.z)

				local var_498_8 = var_498_0.localEulerAngles

				var_498_8.z = 0
				var_498_8.x = 0
				var_498_0.localEulerAngles = var_498_8
			end

			local var_498_9 = arg_495_1.actors_["3043ui_story"]
			local var_498_10 = 0

			if var_498_10 < arg_495_1.time_ and arg_495_1.time_ <= var_498_10 + arg_498_0 and not isNil(var_498_9) and arg_495_1.var_.characterEffect3043ui_story == nil then
				arg_495_1.var_.characterEffect3043ui_story = var_498_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_11 = 0.200000002980232

			if var_498_10 <= arg_495_1.time_ and arg_495_1.time_ < var_498_10 + var_498_11 and not isNil(var_498_9) then
				local var_498_12 = (arg_495_1.time_ - var_498_10) / var_498_11

				if arg_495_1.var_.characterEffect3043ui_story and not isNil(var_498_9) then
					arg_495_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_495_1.time_ >= var_498_10 + var_498_11 and arg_495_1.time_ < var_498_10 + var_498_11 + arg_498_0 and not isNil(var_498_9) and arg_495_1.var_.characterEffect3043ui_story then
				arg_495_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_498_13 = 0

			if var_498_13 < arg_495_1.time_ and arg_495_1.time_ <= var_498_13 + arg_498_0 then
				arg_495_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_498_14 = 0

			if var_498_14 < arg_495_1.time_ and arg_495_1.time_ <= var_498_14 + arg_498_0 then
				arg_495_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_498_15 = arg_495_1.actors_["10076ui_story"].transform
			local var_498_16 = 0

			if var_498_16 < arg_495_1.time_ and arg_495_1.time_ <= var_498_16 + arg_498_0 then
				arg_495_1.var_.moveOldPos10076ui_story = var_498_15.localPosition
			end

			local var_498_17 = 0.001

			if var_498_16 <= arg_495_1.time_ and arg_495_1.time_ < var_498_16 + var_498_17 then
				local var_498_18 = (arg_495_1.time_ - var_498_16) / var_498_17
				local var_498_19 = Vector3.New(0, 100, 0)

				var_498_15.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos10076ui_story, var_498_19, var_498_18)

				local var_498_20 = manager.ui.mainCamera.transform.position - var_498_15.position

				var_498_15.forward = Vector3.New(var_498_20.x, var_498_20.y, var_498_20.z)

				local var_498_21 = var_498_15.localEulerAngles

				var_498_21.z = 0
				var_498_21.x = 0
				var_498_15.localEulerAngles = var_498_21
			end

			if arg_495_1.time_ >= var_498_16 + var_498_17 and arg_495_1.time_ < var_498_16 + var_498_17 + arg_498_0 then
				var_498_15.localPosition = Vector3.New(0, 100, 0)

				local var_498_22 = manager.ui.mainCamera.transform.position - var_498_15.position

				var_498_15.forward = Vector3.New(var_498_22.x, var_498_22.y, var_498_22.z)

				local var_498_23 = var_498_15.localEulerAngles

				var_498_23.z = 0
				var_498_23.x = 0
				var_498_15.localEulerAngles = var_498_23
			end

			local var_498_24 = arg_495_1.actors_["10076ui_story"]
			local var_498_25 = 0

			if var_498_25 < arg_495_1.time_ and arg_495_1.time_ <= var_498_25 + arg_498_0 and not isNil(var_498_24) and arg_495_1.var_.characterEffect10076ui_story == nil then
				arg_495_1.var_.characterEffect10076ui_story = var_498_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_26 = 0.200000002980232

			if var_498_25 <= arg_495_1.time_ and arg_495_1.time_ < var_498_25 + var_498_26 and not isNil(var_498_24) then
				local var_498_27 = (arg_495_1.time_ - var_498_25) / var_498_26

				if arg_495_1.var_.characterEffect10076ui_story and not isNil(var_498_24) then
					local var_498_28 = Mathf.Lerp(0, 0.5, var_498_27)

					arg_495_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_495_1.var_.characterEffect10076ui_story.fillRatio = var_498_28
				end
			end

			if arg_495_1.time_ >= var_498_25 + var_498_26 and arg_495_1.time_ < var_498_25 + var_498_26 + arg_498_0 and not isNil(var_498_24) and arg_495_1.var_.characterEffect10076ui_story then
				local var_498_29 = 0.5

				arg_495_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_495_1.var_.characterEffect10076ui_story.fillRatio = var_498_29
			end

			local var_498_30 = 0
			local var_498_31 = 0.525

			if var_498_30 < arg_495_1.time_ and arg_495_1.time_ <= var_498_30 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_32 = arg_495_1:FormatText(StoryNameCfg[920].name)

				arg_495_1.leftNameTxt_.text = var_498_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_33 = arg_495_1:GetWordFromCfg(412031119)
				local var_498_34 = arg_495_1:FormatText(var_498_33.content)

				arg_495_1.text_.text = var_498_34

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_35 = 21
				local var_498_36 = utf8.len(var_498_34)
				local var_498_37 = var_498_35 <= 0 and var_498_31 or var_498_31 * (var_498_36 / var_498_35)

				if var_498_37 > 0 and var_498_31 < var_498_37 then
					arg_495_1.talkMaxDuration = var_498_37

					if var_498_37 + var_498_30 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_37 + var_498_30
					end
				end

				arg_495_1.text_.text = var_498_34
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031119", "story_v_out_412031.awb") ~= 0 then
					local var_498_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031119", "story_v_out_412031.awb") / 1000

					if var_498_38 + var_498_30 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_38 + var_498_30
					end

					if var_498_33.prefab_name ~= "" and arg_495_1.actors_[var_498_33.prefab_name] ~= nil then
						local var_498_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_33.prefab_name].transform, "story_v_out_412031", "412031119", "story_v_out_412031.awb")

						arg_495_1:RecordAudio("412031119", var_498_39)
						arg_495_1:RecordAudio("412031119", var_498_39)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_412031", "412031119", "story_v_out_412031.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_412031", "412031119", "story_v_out_412031.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_40 = math.max(var_498_31, arg_495_1.talkMaxDuration)

			if var_498_30 <= arg_495_1.time_ and arg_495_1.time_ < var_498_30 + var_498_40 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_30) / var_498_40

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_30 + var_498_40 and arg_495_1.time_ < var_498_30 + var_498_40 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_495_1:InitPlayNodeList()
	end,
	Play412031120 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 412031120
		arg_499_1.duration_ = 6.67

		local var_499_0 = {
			zh = 2.7,
			ja = 6.666
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
				arg_499_0:Play412031121(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["10076ui_story"].transform
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 then
				arg_499_1.var_.moveOldPos10076ui_story = var_502_0.localPosition
			end

			local var_502_2 = 0.001

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_2 then
				local var_502_3 = (arg_499_1.time_ - var_502_1) / var_502_2
				local var_502_4 = Vector3.New(0, -0.35, -4)

				var_502_0.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10076ui_story, var_502_4, var_502_3)

				local var_502_5 = manager.ui.mainCamera.transform.position - var_502_0.position

				var_502_0.forward = Vector3.New(var_502_5.x, var_502_5.y, var_502_5.z)

				local var_502_6 = var_502_0.localEulerAngles

				var_502_6.z = 0
				var_502_6.x = 0
				var_502_0.localEulerAngles = var_502_6
			end

			if arg_499_1.time_ >= var_502_1 + var_502_2 and arg_499_1.time_ < var_502_1 + var_502_2 + arg_502_0 then
				var_502_0.localPosition = Vector3.New(0, -0.35, -4)

				local var_502_7 = manager.ui.mainCamera.transform.position - var_502_0.position

				var_502_0.forward = Vector3.New(var_502_7.x, var_502_7.y, var_502_7.z)

				local var_502_8 = var_502_0.localEulerAngles

				var_502_8.z = 0
				var_502_8.x = 0
				var_502_0.localEulerAngles = var_502_8
			end

			local var_502_9 = arg_499_1.actors_["10076ui_story"]
			local var_502_10 = 0

			if var_502_10 < arg_499_1.time_ and arg_499_1.time_ <= var_502_10 + arg_502_0 and not isNil(var_502_9) and arg_499_1.var_.characterEffect10076ui_story == nil then
				arg_499_1.var_.characterEffect10076ui_story = var_502_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_11 = 0.200000002980232

			if var_502_10 <= arg_499_1.time_ and arg_499_1.time_ < var_502_10 + var_502_11 and not isNil(var_502_9) then
				local var_502_12 = (arg_499_1.time_ - var_502_10) / var_502_11

				if arg_499_1.var_.characterEffect10076ui_story and not isNil(var_502_9) then
					arg_499_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= var_502_10 + var_502_11 and arg_499_1.time_ < var_502_10 + var_502_11 + arg_502_0 and not isNil(var_502_9) and arg_499_1.var_.characterEffect10076ui_story then
				arg_499_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_502_13 = 0

			if var_502_13 < arg_499_1.time_ and arg_499_1.time_ <= var_502_13 + arg_502_0 then
				arg_499_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action2_1")
			end

			local var_502_14 = 0

			if var_502_14 < arg_499_1.time_ and arg_499_1.time_ <= var_502_14 + arg_502_0 then
				arg_499_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_502_15 = arg_499_1.actors_["3043ui_story"].transform
			local var_502_16 = 0

			if var_502_16 < arg_499_1.time_ and arg_499_1.time_ <= var_502_16 + arg_502_0 then
				arg_499_1.var_.moveOldPos3043ui_story = var_502_15.localPosition
			end

			local var_502_17 = 0.001

			if var_502_16 <= arg_499_1.time_ and arg_499_1.time_ < var_502_16 + var_502_17 then
				local var_502_18 = (arg_499_1.time_ - var_502_16) / var_502_17
				local var_502_19 = Vector3.New(0, 100, 0)

				var_502_15.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos3043ui_story, var_502_19, var_502_18)

				local var_502_20 = manager.ui.mainCamera.transform.position - var_502_15.position

				var_502_15.forward = Vector3.New(var_502_20.x, var_502_20.y, var_502_20.z)

				local var_502_21 = var_502_15.localEulerAngles

				var_502_21.z = 0
				var_502_21.x = 0
				var_502_15.localEulerAngles = var_502_21
			end

			if arg_499_1.time_ >= var_502_16 + var_502_17 and arg_499_1.time_ < var_502_16 + var_502_17 + arg_502_0 then
				var_502_15.localPosition = Vector3.New(0, 100, 0)

				local var_502_22 = manager.ui.mainCamera.transform.position - var_502_15.position

				var_502_15.forward = Vector3.New(var_502_22.x, var_502_22.y, var_502_22.z)

				local var_502_23 = var_502_15.localEulerAngles

				var_502_23.z = 0
				var_502_23.x = 0
				var_502_15.localEulerAngles = var_502_23
			end

			local var_502_24 = arg_499_1.actors_["3043ui_story"]
			local var_502_25 = 0

			if var_502_25 < arg_499_1.time_ and arg_499_1.time_ <= var_502_25 + arg_502_0 and not isNil(var_502_24) and arg_499_1.var_.characterEffect3043ui_story == nil then
				arg_499_1.var_.characterEffect3043ui_story = var_502_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_26 = 0.200000002980232

			if var_502_25 <= arg_499_1.time_ and arg_499_1.time_ < var_502_25 + var_502_26 and not isNil(var_502_24) then
				local var_502_27 = (arg_499_1.time_ - var_502_25) / var_502_26

				if arg_499_1.var_.characterEffect3043ui_story and not isNil(var_502_24) then
					local var_502_28 = Mathf.Lerp(0, 0.5, var_502_27)

					arg_499_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_499_1.var_.characterEffect3043ui_story.fillRatio = var_502_28
				end
			end

			if arg_499_1.time_ >= var_502_25 + var_502_26 and arg_499_1.time_ < var_502_25 + var_502_26 + arg_502_0 and not isNil(var_502_24) and arg_499_1.var_.characterEffect3043ui_story then
				local var_502_29 = 0.5

				arg_499_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_499_1.var_.characterEffect3043ui_story.fillRatio = var_502_29
			end

			local var_502_30 = 0
			local var_502_31 = 0.35

			if var_502_30 < arg_499_1.time_ and arg_499_1.time_ <= var_502_30 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_32 = arg_499_1:FormatText(StoryNameCfg[917].name)

				arg_499_1.leftNameTxt_.text = var_502_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_33 = arg_499_1:GetWordFromCfg(412031120)
				local var_502_34 = arg_499_1:FormatText(var_502_33.content)

				arg_499_1.text_.text = var_502_34

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_35 = 14
				local var_502_36 = utf8.len(var_502_34)
				local var_502_37 = var_502_35 <= 0 and var_502_31 or var_502_31 * (var_502_36 / var_502_35)

				if var_502_37 > 0 and var_502_31 < var_502_37 then
					arg_499_1.talkMaxDuration = var_502_37

					if var_502_37 + var_502_30 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_37 + var_502_30
					end
				end

				arg_499_1.text_.text = var_502_34
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031120", "story_v_out_412031.awb") ~= 0 then
					local var_502_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031120", "story_v_out_412031.awb") / 1000

					if var_502_38 + var_502_30 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_38 + var_502_30
					end

					if var_502_33.prefab_name ~= "" and arg_499_1.actors_[var_502_33.prefab_name] ~= nil then
						local var_502_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_33.prefab_name].transform, "story_v_out_412031", "412031120", "story_v_out_412031.awb")

						arg_499_1:RecordAudio("412031120", var_502_39)
						arg_499_1:RecordAudio("412031120", var_502_39)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_412031", "412031120", "story_v_out_412031.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_412031", "412031120", "story_v_out_412031.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_40 = math.max(var_502_31, arg_499_1.talkMaxDuration)

			if var_502_30 <= arg_499_1.time_ and arg_499_1.time_ < var_502_30 + var_502_40 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_30) / var_502_40

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_30 + var_502_40 and arg_499_1.time_ < var_502_30 + var_502_40 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play412031121 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 412031121
		arg_503_1.duration_ = 4.13

		local var_503_0 = {
			zh = 4.133,
			ja = 2.7
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
				arg_503_0:Play412031122(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = arg_503_1.actors_["3043ui_story"].transform
			local var_506_1 = 0

			if var_506_1 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 then
				arg_503_1.var_.moveOldPos3043ui_story = var_506_0.localPosition
			end

			local var_506_2 = 0.001

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_2 then
				local var_506_3 = (arg_503_1.time_ - var_506_1) / var_506_2
				local var_506_4 = Vector3.New(0, -1.41, -5.7)

				var_506_0.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos3043ui_story, var_506_4, var_506_3)

				local var_506_5 = manager.ui.mainCamera.transform.position - var_506_0.position

				var_506_0.forward = Vector3.New(var_506_5.x, var_506_5.y, var_506_5.z)

				local var_506_6 = var_506_0.localEulerAngles

				var_506_6.z = 0
				var_506_6.x = 0
				var_506_0.localEulerAngles = var_506_6
			end

			if arg_503_1.time_ >= var_506_1 + var_506_2 and arg_503_1.time_ < var_506_1 + var_506_2 + arg_506_0 then
				var_506_0.localPosition = Vector3.New(0, -1.41, -5.7)

				local var_506_7 = manager.ui.mainCamera.transform.position - var_506_0.position

				var_506_0.forward = Vector3.New(var_506_7.x, var_506_7.y, var_506_7.z)

				local var_506_8 = var_506_0.localEulerAngles

				var_506_8.z = 0
				var_506_8.x = 0
				var_506_0.localEulerAngles = var_506_8
			end

			local var_506_9 = arg_503_1.actors_["3043ui_story"]
			local var_506_10 = 0

			if var_506_10 < arg_503_1.time_ and arg_503_1.time_ <= var_506_10 + arg_506_0 and not isNil(var_506_9) and arg_503_1.var_.characterEffect3043ui_story == nil then
				arg_503_1.var_.characterEffect3043ui_story = var_506_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_11 = 0.200000002980232

			if var_506_10 <= arg_503_1.time_ and arg_503_1.time_ < var_506_10 + var_506_11 and not isNil(var_506_9) then
				local var_506_12 = (arg_503_1.time_ - var_506_10) / var_506_11

				if arg_503_1.var_.characterEffect3043ui_story and not isNil(var_506_9) then
					arg_503_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_503_1.time_ >= var_506_10 + var_506_11 and arg_503_1.time_ < var_506_10 + var_506_11 + arg_506_0 and not isNil(var_506_9) and arg_503_1.var_.characterEffect3043ui_story then
				arg_503_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			local var_506_13 = 0

			if var_506_13 < arg_503_1.time_ and arg_503_1.time_ <= var_506_13 + arg_506_0 then
				arg_503_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			local var_506_14 = 0

			if var_506_14 < arg_503_1.time_ and arg_503_1.time_ <= var_506_14 + arg_506_0 then
				arg_503_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_506_15 = arg_503_1.actors_["10076ui_story"].transform
			local var_506_16 = 0

			if var_506_16 < arg_503_1.time_ and arg_503_1.time_ <= var_506_16 + arg_506_0 then
				arg_503_1.var_.moveOldPos10076ui_story = var_506_15.localPosition
			end

			local var_506_17 = 0.001

			if var_506_16 <= arg_503_1.time_ and arg_503_1.time_ < var_506_16 + var_506_17 then
				local var_506_18 = (arg_503_1.time_ - var_506_16) / var_506_17
				local var_506_19 = Vector3.New(0, 100, 0)

				var_506_15.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos10076ui_story, var_506_19, var_506_18)

				local var_506_20 = manager.ui.mainCamera.transform.position - var_506_15.position

				var_506_15.forward = Vector3.New(var_506_20.x, var_506_20.y, var_506_20.z)

				local var_506_21 = var_506_15.localEulerAngles

				var_506_21.z = 0
				var_506_21.x = 0
				var_506_15.localEulerAngles = var_506_21
			end

			if arg_503_1.time_ >= var_506_16 + var_506_17 and arg_503_1.time_ < var_506_16 + var_506_17 + arg_506_0 then
				var_506_15.localPosition = Vector3.New(0, 100, 0)

				local var_506_22 = manager.ui.mainCamera.transform.position - var_506_15.position

				var_506_15.forward = Vector3.New(var_506_22.x, var_506_22.y, var_506_22.z)

				local var_506_23 = var_506_15.localEulerAngles

				var_506_23.z = 0
				var_506_23.x = 0
				var_506_15.localEulerAngles = var_506_23
			end

			local var_506_24 = arg_503_1.actors_["10076ui_story"]
			local var_506_25 = 0

			if var_506_25 < arg_503_1.time_ and arg_503_1.time_ <= var_506_25 + arg_506_0 and not isNil(var_506_24) and arg_503_1.var_.characterEffect10076ui_story == nil then
				arg_503_1.var_.characterEffect10076ui_story = var_506_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_26 = 0.200000002980232

			if var_506_25 <= arg_503_1.time_ and arg_503_1.time_ < var_506_25 + var_506_26 and not isNil(var_506_24) then
				local var_506_27 = (arg_503_1.time_ - var_506_25) / var_506_26

				if arg_503_1.var_.characterEffect10076ui_story and not isNil(var_506_24) then
					local var_506_28 = Mathf.Lerp(0, 0.5, var_506_27)

					arg_503_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_503_1.var_.characterEffect10076ui_story.fillRatio = var_506_28
				end
			end

			if arg_503_1.time_ >= var_506_25 + var_506_26 and arg_503_1.time_ < var_506_25 + var_506_26 + arg_506_0 and not isNil(var_506_24) and arg_503_1.var_.characterEffect10076ui_story then
				local var_506_29 = 0.5

				arg_503_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_503_1.var_.characterEffect10076ui_story.fillRatio = var_506_29
			end

			local var_506_30 = 0
			local var_506_31 = 0.475

			if var_506_30 < arg_503_1.time_ and arg_503_1.time_ <= var_506_30 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_32 = arg_503_1:FormatText(StoryNameCfg[920].name)

				arg_503_1.leftNameTxt_.text = var_506_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_33 = arg_503_1:GetWordFromCfg(412031121)
				local var_506_34 = arg_503_1:FormatText(var_506_33.content)

				arg_503_1.text_.text = var_506_34

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_35 = 19
				local var_506_36 = utf8.len(var_506_34)
				local var_506_37 = var_506_35 <= 0 and var_506_31 or var_506_31 * (var_506_36 / var_506_35)

				if var_506_37 > 0 and var_506_31 < var_506_37 then
					arg_503_1.talkMaxDuration = var_506_37

					if var_506_37 + var_506_30 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_37 + var_506_30
					end
				end

				arg_503_1.text_.text = var_506_34
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031121", "story_v_out_412031.awb") ~= 0 then
					local var_506_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031121", "story_v_out_412031.awb") / 1000

					if var_506_38 + var_506_30 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_38 + var_506_30
					end

					if var_506_33.prefab_name ~= "" and arg_503_1.actors_[var_506_33.prefab_name] ~= nil then
						local var_506_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_33.prefab_name].transform, "story_v_out_412031", "412031121", "story_v_out_412031.awb")

						arg_503_1:RecordAudio("412031121", var_506_39)
						arg_503_1:RecordAudio("412031121", var_506_39)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_412031", "412031121", "story_v_out_412031.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_412031", "412031121", "story_v_out_412031.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_40 = math.max(var_506_31, arg_503_1.talkMaxDuration)

			if var_506_30 <= arg_503_1.time_ and arg_503_1.time_ < var_506_30 + var_506_40 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_30) / var_506_40

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_30 + var_506_40 and arg_503_1.time_ < var_506_30 + var_506_40 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_503_1:InitPlayNodeList()
	end,
	Play412031122 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 412031122
		arg_507_1.duration_ = 9.67

		local var_507_0 = {
			zh = 8.533,
			ja = 9.666
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
				arg_507_0:Play412031123(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0
			local var_510_1 = 0.8

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_2 = arg_507_1:FormatText(StoryNameCfg[920].name)

				arg_507_1.leftNameTxt_.text = var_510_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_3 = arg_507_1:GetWordFromCfg(412031122)
				local var_510_4 = arg_507_1:FormatText(var_510_3.content)

				arg_507_1.text_.text = var_510_4

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031122", "story_v_out_412031.awb") ~= 0 then
					local var_510_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031122", "story_v_out_412031.awb") / 1000

					if var_510_8 + var_510_0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_8 + var_510_0
					end

					if var_510_3.prefab_name ~= "" and arg_507_1.actors_[var_510_3.prefab_name] ~= nil then
						local var_510_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_3.prefab_name].transform, "story_v_out_412031", "412031122", "story_v_out_412031.awb")

						arg_507_1:RecordAudio("412031122", var_510_9)
						arg_507_1:RecordAudio("412031122", var_510_9)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_412031", "412031122", "story_v_out_412031.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_412031", "412031122", "story_v_out_412031.awb")
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
	Play412031123 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 412031123
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play412031124(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["3043ui_story"].transform
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.var_.moveOldPos3043ui_story = var_514_0.localPosition
			end

			local var_514_2 = 0.001

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2
				local var_514_4 = Vector3.New(0, 100, 0)

				var_514_0.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos3043ui_story, var_514_4, var_514_3)

				local var_514_5 = manager.ui.mainCamera.transform.position - var_514_0.position

				var_514_0.forward = Vector3.New(var_514_5.x, var_514_5.y, var_514_5.z)

				local var_514_6 = var_514_0.localEulerAngles

				var_514_6.z = 0
				var_514_6.x = 0
				var_514_0.localEulerAngles = var_514_6
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 then
				var_514_0.localPosition = Vector3.New(0, 100, 0)

				local var_514_7 = manager.ui.mainCamera.transform.position - var_514_0.position

				var_514_0.forward = Vector3.New(var_514_7.x, var_514_7.y, var_514_7.z)

				local var_514_8 = var_514_0.localEulerAngles

				var_514_8.z = 0
				var_514_8.x = 0
				var_514_0.localEulerAngles = var_514_8
			end

			local var_514_9 = arg_511_1.actors_["3043ui_story"]
			local var_514_10 = 0

			if var_514_10 < arg_511_1.time_ and arg_511_1.time_ <= var_514_10 + arg_514_0 and not isNil(var_514_9) and arg_511_1.var_.characterEffect3043ui_story == nil then
				arg_511_1.var_.characterEffect3043ui_story = var_514_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_11 = 0.200000002980232

			if var_514_10 <= arg_511_1.time_ and arg_511_1.time_ < var_514_10 + var_514_11 and not isNil(var_514_9) then
				local var_514_12 = (arg_511_1.time_ - var_514_10) / var_514_11

				if arg_511_1.var_.characterEffect3043ui_story and not isNil(var_514_9) then
					local var_514_13 = Mathf.Lerp(0, 0.5, var_514_12)

					arg_511_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_511_1.var_.characterEffect3043ui_story.fillRatio = var_514_13
				end
			end

			if arg_511_1.time_ >= var_514_10 + var_514_11 and arg_511_1.time_ < var_514_10 + var_514_11 + arg_514_0 and not isNil(var_514_9) and arg_511_1.var_.characterEffect3043ui_story then
				local var_514_14 = 0.5

				arg_511_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_511_1.var_.characterEffect3043ui_story.fillRatio = var_514_14
			end

			local var_514_15 = 0
			local var_514_16 = 0.35

			if var_514_15 < arg_511_1.time_ and arg_511_1.time_ <= var_514_15 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_17 = arg_511_1:GetWordFromCfg(412031123)
				local var_514_18 = arg_511_1:FormatText(var_514_17.content)

				arg_511_1.text_.text = var_514_18

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_19 = 14
				local var_514_20 = utf8.len(var_514_18)
				local var_514_21 = var_514_19 <= 0 and var_514_16 or var_514_16 * (var_514_20 / var_514_19)

				if var_514_21 > 0 and var_514_16 < var_514_21 then
					arg_511_1.talkMaxDuration = var_514_21

					if var_514_21 + var_514_15 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_21 + var_514_15
					end
				end

				arg_511_1.text_.text = var_514_18
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_22 = math.max(var_514_16, arg_511_1.talkMaxDuration)

			if var_514_15 <= arg_511_1.time_ and arg_511_1.time_ < var_514_15 + var_514_22 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_15) / var_514_22

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_15 + var_514_22 and arg_511_1.time_ < var_514_15 + var_514_22 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play412031124 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 412031124
		arg_515_1.duration_ = 3.23

		local var_515_0 = {
			zh = 3.233,
			ja = 1.999999999999
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play412031125(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["1097ui_story"].transform
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 then
				arg_515_1.var_.moveOldPos1097ui_story = var_518_0.localPosition
			end

			local var_518_2 = 0.001

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2
				local var_518_4 = Vector3.New(0, -0.54, -6.3)

				var_518_0.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1097ui_story, var_518_4, var_518_3)

				local var_518_5 = manager.ui.mainCamera.transform.position - var_518_0.position

				var_518_0.forward = Vector3.New(var_518_5.x, var_518_5.y, var_518_5.z)

				local var_518_6 = var_518_0.localEulerAngles

				var_518_6.z = 0
				var_518_6.x = 0
				var_518_0.localEulerAngles = var_518_6
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 then
				var_518_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_518_7 = manager.ui.mainCamera.transform.position - var_518_0.position

				var_518_0.forward = Vector3.New(var_518_7.x, var_518_7.y, var_518_7.z)

				local var_518_8 = var_518_0.localEulerAngles

				var_518_8.z = 0
				var_518_8.x = 0
				var_518_0.localEulerAngles = var_518_8
			end

			local var_518_9 = arg_515_1.actors_["1097ui_story"]
			local var_518_10 = 0

			if var_518_10 < arg_515_1.time_ and arg_515_1.time_ <= var_518_10 + arg_518_0 and not isNil(var_518_9) and arg_515_1.var_.characterEffect1097ui_story == nil then
				arg_515_1.var_.characterEffect1097ui_story = var_518_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_11 = 0.200000002980232

			if var_518_10 <= arg_515_1.time_ and arg_515_1.time_ < var_518_10 + var_518_11 and not isNil(var_518_9) then
				local var_518_12 = (arg_515_1.time_ - var_518_10) / var_518_11

				if arg_515_1.var_.characterEffect1097ui_story and not isNil(var_518_9) then
					arg_515_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= var_518_10 + var_518_11 and arg_515_1.time_ < var_518_10 + var_518_11 + arg_518_0 and not isNil(var_518_9) and arg_515_1.var_.characterEffect1097ui_story then
				arg_515_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_518_13 = 0

			if var_518_13 < arg_515_1.time_ and arg_515_1.time_ <= var_518_13 + arg_518_0 then
				arg_515_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action3_1")
			end

			local var_518_14 = 0

			if var_518_14 < arg_515_1.time_ and arg_515_1.time_ <= var_518_14 + arg_518_0 then
				arg_515_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_518_15 = arg_515_1.actors_["3043ui_story"].transform
			local var_518_16 = 0

			if var_518_16 < arg_515_1.time_ and arg_515_1.time_ <= var_518_16 + arg_518_0 then
				arg_515_1.var_.moveOldPos3043ui_story = var_518_15.localPosition
			end

			local var_518_17 = 0.001

			if var_518_16 <= arg_515_1.time_ and arg_515_1.time_ < var_518_16 + var_518_17 then
				local var_518_18 = (arg_515_1.time_ - var_518_16) / var_518_17
				local var_518_19 = Vector3.New(0, 100, 0)

				var_518_15.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos3043ui_story, var_518_19, var_518_18)

				local var_518_20 = manager.ui.mainCamera.transform.position - var_518_15.position

				var_518_15.forward = Vector3.New(var_518_20.x, var_518_20.y, var_518_20.z)

				local var_518_21 = var_518_15.localEulerAngles

				var_518_21.z = 0
				var_518_21.x = 0
				var_518_15.localEulerAngles = var_518_21
			end

			if arg_515_1.time_ >= var_518_16 + var_518_17 and arg_515_1.time_ < var_518_16 + var_518_17 + arg_518_0 then
				var_518_15.localPosition = Vector3.New(0, 100, 0)

				local var_518_22 = manager.ui.mainCamera.transform.position - var_518_15.position

				var_518_15.forward = Vector3.New(var_518_22.x, var_518_22.y, var_518_22.z)

				local var_518_23 = var_518_15.localEulerAngles

				var_518_23.z = 0
				var_518_23.x = 0
				var_518_15.localEulerAngles = var_518_23
			end

			local var_518_24 = 0
			local var_518_25 = 0.3

			if var_518_24 < arg_515_1.time_ and arg_515_1.time_ <= var_518_24 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_26 = arg_515_1:FormatText(StoryNameCfg[216].name)

				arg_515_1.leftNameTxt_.text = var_518_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_27 = arg_515_1:GetWordFromCfg(412031124)
				local var_518_28 = arg_515_1:FormatText(var_518_27.content)

				arg_515_1.text_.text = var_518_28

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_29 = 12
				local var_518_30 = utf8.len(var_518_28)
				local var_518_31 = var_518_29 <= 0 and var_518_25 or var_518_25 * (var_518_30 / var_518_29)

				if var_518_31 > 0 and var_518_25 < var_518_31 then
					arg_515_1.talkMaxDuration = var_518_31

					if var_518_31 + var_518_24 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_31 + var_518_24
					end
				end

				arg_515_1.text_.text = var_518_28
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031124", "story_v_out_412031.awb") ~= 0 then
					local var_518_32 = manager.audio:GetVoiceLength("story_v_out_412031", "412031124", "story_v_out_412031.awb") / 1000

					if var_518_32 + var_518_24 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_32 + var_518_24
					end

					if var_518_27.prefab_name ~= "" and arg_515_1.actors_[var_518_27.prefab_name] ~= nil then
						local var_518_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_27.prefab_name].transform, "story_v_out_412031", "412031124", "story_v_out_412031.awb")

						arg_515_1:RecordAudio("412031124", var_518_33)
						arg_515_1:RecordAudio("412031124", var_518_33)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_412031", "412031124", "story_v_out_412031.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_412031", "412031124", "story_v_out_412031.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_34 = math.max(var_518_25, arg_515_1.talkMaxDuration)

			if var_518_24 <= arg_515_1.time_ and arg_515_1.time_ < var_518_24 + var_518_34 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_24) / var_518_34

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_24 + var_518_34 and arg_515_1.time_ < var_518_24 + var_518_34 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_515_1:InitPlayNodeList()
	end,
	Play412031125 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 412031125
		arg_519_1.duration_ = 3.5

		local var_519_0 = {
			zh = 2.6,
			ja = 3.5
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
				arg_519_0:Play412031126(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = arg_519_1.actors_["10078ui_story"].transform
			local var_522_1 = 0

			if var_522_1 < arg_519_1.time_ and arg_519_1.time_ <= var_522_1 + arg_522_0 then
				arg_519_1.var_.moveOldPos10078ui_story = var_522_0.localPosition
			end

			local var_522_2 = 0.001

			if var_522_1 <= arg_519_1.time_ and arg_519_1.time_ < var_522_1 + var_522_2 then
				local var_522_3 = (arg_519_1.time_ - var_522_1) / var_522_2
				local var_522_4 = Vector3.New(0, -0.5, -6.3)

				var_522_0.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10078ui_story, var_522_4, var_522_3)

				local var_522_5 = manager.ui.mainCamera.transform.position - var_522_0.position

				var_522_0.forward = Vector3.New(var_522_5.x, var_522_5.y, var_522_5.z)

				local var_522_6 = var_522_0.localEulerAngles

				var_522_6.z = 0
				var_522_6.x = 0
				var_522_0.localEulerAngles = var_522_6
			end

			if arg_519_1.time_ >= var_522_1 + var_522_2 and arg_519_1.time_ < var_522_1 + var_522_2 + arg_522_0 then
				var_522_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_522_7 = manager.ui.mainCamera.transform.position - var_522_0.position

				var_522_0.forward = Vector3.New(var_522_7.x, var_522_7.y, var_522_7.z)

				local var_522_8 = var_522_0.localEulerAngles

				var_522_8.z = 0
				var_522_8.x = 0
				var_522_0.localEulerAngles = var_522_8
			end

			local var_522_9 = arg_519_1.actors_["10078ui_story"]
			local var_522_10 = 0

			if var_522_10 < arg_519_1.time_ and arg_519_1.time_ <= var_522_10 + arg_522_0 and not isNil(var_522_9) and arg_519_1.var_.characterEffect10078ui_story == nil then
				arg_519_1.var_.characterEffect10078ui_story = var_522_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_11 = 0.200000002980232

			if var_522_10 <= arg_519_1.time_ and arg_519_1.time_ < var_522_10 + var_522_11 and not isNil(var_522_9) then
				local var_522_12 = (arg_519_1.time_ - var_522_10) / var_522_11

				if arg_519_1.var_.characterEffect10078ui_story and not isNil(var_522_9) then
					arg_519_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= var_522_10 + var_522_11 and arg_519_1.time_ < var_522_10 + var_522_11 + arg_522_0 and not isNil(var_522_9) and arg_519_1.var_.characterEffect10078ui_story then
				arg_519_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_522_13 = 0

			if var_522_13 < arg_519_1.time_ and arg_519_1.time_ <= var_522_13 + arg_522_0 then
				arg_519_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_2")
			end

			local var_522_14 = 0

			if var_522_14 < arg_519_1.time_ and arg_519_1.time_ <= var_522_14 + arg_522_0 then
				arg_519_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_522_15 = arg_519_1.actors_["1097ui_story"].transform
			local var_522_16 = 0

			if var_522_16 < arg_519_1.time_ and arg_519_1.time_ <= var_522_16 + arg_522_0 then
				arg_519_1.var_.moveOldPos1097ui_story = var_522_15.localPosition
			end

			local var_522_17 = 0.001

			if var_522_16 <= arg_519_1.time_ and arg_519_1.time_ < var_522_16 + var_522_17 then
				local var_522_18 = (arg_519_1.time_ - var_522_16) / var_522_17
				local var_522_19 = Vector3.New(0, 100, 0)

				var_522_15.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos1097ui_story, var_522_19, var_522_18)

				local var_522_20 = manager.ui.mainCamera.transform.position - var_522_15.position

				var_522_15.forward = Vector3.New(var_522_20.x, var_522_20.y, var_522_20.z)

				local var_522_21 = var_522_15.localEulerAngles

				var_522_21.z = 0
				var_522_21.x = 0
				var_522_15.localEulerAngles = var_522_21
			end

			if arg_519_1.time_ >= var_522_16 + var_522_17 and arg_519_1.time_ < var_522_16 + var_522_17 + arg_522_0 then
				var_522_15.localPosition = Vector3.New(0, 100, 0)

				local var_522_22 = manager.ui.mainCamera.transform.position - var_522_15.position

				var_522_15.forward = Vector3.New(var_522_22.x, var_522_22.y, var_522_22.z)

				local var_522_23 = var_522_15.localEulerAngles

				var_522_23.z = 0
				var_522_23.x = 0
				var_522_15.localEulerAngles = var_522_23
			end

			local var_522_24 = arg_519_1.actors_["1097ui_story"]
			local var_522_25 = 0

			if var_522_25 < arg_519_1.time_ and arg_519_1.time_ <= var_522_25 + arg_522_0 and not isNil(var_522_24) and arg_519_1.var_.characterEffect1097ui_story == nil then
				arg_519_1.var_.characterEffect1097ui_story = var_522_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_26 = 0.200000002980232

			if var_522_25 <= arg_519_1.time_ and arg_519_1.time_ < var_522_25 + var_522_26 and not isNil(var_522_24) then
				local var_522_27 = (arg_519_1.time_ - var_522_25) / var_522_26

				if arg_519_1.var_.characterEffect1097ui_story and not isNil(var_522_24) then
					local var_522_28 = Mathf.Lerp(0, 0.5, var_522_27)

					arg_519_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_519_1.var_.characterEffect1097ui_story.fillRatio = var_522_28
				end
			end

			if arg_519_1.time_ >= var_522_25 + var_522_26 and arg_519_1.time_ < var_522_25 + var_522_26 + arg_522_0 and not isNil(var_522_24) and arg_519_1.var_.characterEffect1097ui_story then
				local var_522_29 = 0.5

				arg_519_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_519_1.var_.characterEffect1097ui_story.fillRatio = var_522_29
			end

			local var_522_30 = 0
			local var_522_31 = 0.175

			if var_522_30 < arg_519_1.time_ and arg_519_1.time_ <= var_522_30 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_32 = arg_519_1:FormatText(StoryNameCfg[919].name)

				arg_519_1.leftNameTxt_.text = var_522_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_33 = arg_519_1:GetWordFromCfg(412031125)
				local var_522_34 = arg_519_1:FormatText(var_522_33.content)

				arg_519_1.text_.text = var_522_34

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_35 = 7
				local var_522_36 = utf8.len(var_522_34)
				local var_522_37 = var_522_35 <= 0 and var_522_31 or var_522_31 * (var_522_36 / var_522_35)

				if var_522_37 > 0 and var_522_31 < var_522_37 then
					arg_519_1.talkMaxDuration = var_522_37

					if var_522_37 + var_522_30 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_37 + var_522_30
					end
				end

				arg_519_1.text_.text = var_522_34
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031125", "story_v_out_412031.awb") ~= 0 then
					local var_522_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031125", "story_v_out_412031.awb") / 1000

					if var_522_38 + var_522_30 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_38 + var_522_30
					end

					if var_522_33.prefab_name ~= "" and arg_519_1.actors_[var_522_33.prefab_name] ~= nil then
						local var_522_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_33.prefab_name].transform, "story_v_out_412031", "412031125", "story_v_out_412031.awb")

						arg_519_1:RecordAudio("412031125", var_522_39)
						arg_519_1:RecordAudio("412031125", var_522_39)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_412031", "412031125", "story_v_out_412031.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_412031", "412031125", "story_v_out_412031.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_40 = math.max(var_522_31, arg_519_1.talkMaxDuration)

			if var_522_30 <= arg_519_1.time_ and arg_519_1.time_ < var_522_30 + var_522_40 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_30) / var_522_40

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_30 + var_522_40 and arg_519_1.time_ < var_522_30 + var_522_40 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play412031126 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 412031126
		arg_523_1.duration_ = 9.17

		local var_523_0 = {
			zh = 8.266,
			ja = 9.166
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
				arg_523_0:Play412031127(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = arg_523_1.actors_["10083ui_story"].transform
			local var_526_1 = 0

			if var_526_1 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 then
				arg_523_1.var_.moveOldPos10083ui_story = var_526_0.localPosition
			end

			local var_526_2 = 0.001

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_2 then
				local var_526_3 = (arg_523_1.time_ - var_526_1) / var_526_2
				local var_526_4 = Vector3.New(0, -2.6, -2.8)

				var_526_0.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos10083ui_story, var_526_4, var_526_3)

				local var_526_5 = manager.ui.mainCamera.transform.position - var_526_0.position

				var_526_0.forward = Vector3.New(var_526_5.x, var_526_5.y, var_526_5.z)

				local var_526_6 = var_526_0.localEulerAngles

				var_526_6.z = 0
				var_526_6.x = 0
				var_526_0.localEulerAngles = var_526_6
			end

			if arg_523_1.time_ >= var_526_1 + var_526_2 and arg_523_1.time_ < var_526_1 + var_526_2 + arg_526_0 then
				var_526_0.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_526_7 = manager.ui.mainCamera.transform.position - var_526_0.position

				var_526_0.forward = Vector3.New(var_526_7.x, var_526_7.y, var_526_7.z)

				local var_526_8 = var_526_0.localEulerAngles

				var_526_8.z = 0
				var_526_8.x = 0
				var_526_0.localEulerAngles = var_526_8
			end

			local var_526_9 = arg_523_1.actors_["10083ui_story"]
			local var_526_10 = 0

			if var_526_10 < arg_523_1.time_ and arg_523_1.time_ <= var_526_10 + arg_526_0 and not isNil(var_526_9) and arg_523_1.var_.characterEffect10083ui_story == nil then
				arg_523_1.var_.characterEffect10083ui_story = var_526_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_11 = 0.200000002980232

			if var_526_10 <= arg_523_1.time_ and arg_523_1.time_ < var_526_10 + var_526_11 and not isNil(var_526_9) then
				local var_526_12 = (arg_523_1.time_ - var_526_10) / var_526_11

				if arg_523_1.var_.characterEffect10083ui_story and not isNil(var_526_9) then
					arg_523_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_523_1.time_ >= var_526_10 + var_526_11 and arg_523_1.time_ < var_526_10 + var_526_11 + arg_526_0 and not isNil(var_526_9) and arg_523_1.var_.characterEffect10083ui_story then
				arg_523_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_526_13 = 0

			if var_526_13 < arg_523_1.time_ and arg_523_1.time_ <= var_526_13 + arg_526_0 then
				arg_523_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			local var_526_14 = 0

			if var_526_14 < arg_523_1.time_ and arg_523_1.time_ <= var_526_14 + arg_526_0 then
				arg_523_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_526_15 = arg_523_1.actors_["10078ui_story"].transform
			local var_526_16 = 0

			if var_526_16 < arg_523_1.time_ and arg_523_1.time_ <= var_526_16 + arg_526_0 then
				arg_523_1.var_.moveOldPos10078ui_story = var_526_15.localPosition
			end

			local var_526_17 = 0.001

			if var_526_16 <= arg_523_1.time_ and arg_523_1.time_ < var_526_16 + var_526_17 then
				local var_526_18 = (arg_523_1.time_ - var_526_16) / var_526_17
				local var_526_19 = Vector3.New(0, 100, 0)

				var_526_15.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos10078ui_story, var_526_19, var_526_18)

				local var_526_20 = manager.ui.mainCamera.transform.position - var_526_15.position

				var_526_15.forward = Vector3.New(var_526_20.x, var_526_20.y, var_526_20.z)

				local var_526_21 = var_526_15.localEulerAngles

				var_526_21.z = 0
				var_526_21.x = 0
				var_526_15.localEulerAngles = var_526_21
			end

			if arg_523_1.time_ >= var_526_16 + var_526_17 and arg_523_1.time_ < var_526_16 + var_526_17 + arg_526_0 then
				var_526_15.localPosition = Vector3.New(0, 100, 0)

				local var_526_22 = manager.ui.mainCamera.transform.position - var_526_15.position

				var_526_15.forward = Vector3.New(var_526_22.x, var_526_22.y, var_526_22.z)

				local var_526_23 = var_526_15.localEulerAngles

				var_526_23.z = 0
				var_526_23.x = 0
				var_526_15.localEulerAngles = var_526_23
			end

			local var_526_24 = arg_523_1.actors_["10078ui_story"]
			local var_526_25 = 0

			if var_526_25 < arg_523_1.time_ and arg_523_1.time_ <= var_526_25 + arg_526_0 and not isNil(var_526_24) and arg_523_1.var_.characterEffect10078ui_story == nil then
				arg_523_1.var_.characterEffect10078ui_story = var_526_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_26 = 0.200000002980232

			if var_526_25 <= arg_523_1.time_ and arg_523_1.time_ < var_526_25 + var_526_26 and not isNil(var_526_24) then
				local var_526_27 = (arg_523_1.time_ - var_526_25) / var_526_26

				if arg_523_1.var_.characterEffect10078ui_story and not isNil(var_526_24) then
					local var_526_28 = Mathf.Lerp(0, 0.5, var_526_27)

					arg_523_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_523_1.var_.characterEffect10078ui_story.fillRatio = var_526_28
				end
			end

			if arg_523_1.time_ >= var_526_25 + var_526_26 and arg_523_1.time_ < var_526_25 + var_526_26 + arg_526_0 and not isNil(var_526_24) and arg_523_1.var_.characterEffect10078ui_story then
				local var_526_29 = 0.5

				arg_523_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_523_1.var_.characterEffect10078ui_story.fillRatio = var_526_29
			end

			local var_526_30 = 0
			local var_526_31 = 0.85

			if var_526_30 < arg_523_1.time_ and arg_523_1.time_ <= var_526_30 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_32 = arg_523_1:FormatText(StoryNameCfg[918].name)

				arg_523_1.leftNameTxt_.text = var_526_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_33 = arg_523_1:GetWordFromCfg(412031126)
				local var_526_34 = arg_523_1:FormatText(var_526_33.content)

				arg_523_1.text_.text = var_526_34

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_35 = 34
				local var_526_36 = utf8.len(var_526_34)
				local var_526_37 = var_526_35 <= 0 and var_526_31 or var_526_31 * (var_526_36 / var_526_35)

				if var_526_37 > 0 and var_526_31 < var_526_37 then
					arg_523_1.talkMaxDuration = var_526_37

					if var_526_37 + var_526_30 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_37 + var_526_30
					end
				end

				arg_523_1.text_.text = var_526_34
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031126", "story_v_out_412031.awb") ~= 0 then
					local var_526_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031126", "story_v_out_412031.awb") / 1000

					if var_526_38 + var_526_30 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_38 + var_526_30
					end

					if var_526_33.prefab_name ~= "" and arg_523_1.actors_[var_526_33.prefab_name] ~= nil then
						local var_526_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_33.prefab_name].transform, "story_v_out_412031", "412031126", "story_v_out_412031.awb")

						arg_523_1:RecordAudio("412031126", var_526_39)
						arg_523_1:RecordAudio("412031126", var_526_39)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_412031", "412031126", "story_v_out_412031.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_412031", "412031126", "story_v_out_412031.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_40 = math.max(var_526_31, arg_523_1.talkMaxDuration)

			if var_526_30 <= arg_523_1.time_ and arg_523_1.time_ < var_526_30 + var_526_40 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_30) / var_526_40

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_30 + var_526_40 and arg_523_1.time_ < var_526_30 + var_526_40 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_523_1:InitPlayNodeList()
	end,
	Play412031127 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 412031127
		arg_527_1.duration_ = 10.97

		local var_527_0 = {
			zh = 4.833,
			ja = 10.966
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
				arg_527_0:Play412031128(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = arg_527_1.actors_["1097ui_story"].transform
			local var_530_1 = 0

			if var_530_1 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 then
				arg_527_1.var_.moveOldPos1097ui_story = var_530_0.localPosition
			end

			local var_530_2 = 0.001

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_2 then
				local var_530_3 = (arg_527_1.time_ - var_530_1) / var_530_2
				local var_530_4 = Vector3.New(0, -0.54, -6.3)

				var_530_0.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos1097ui_story, var_530_4, var_530_3)

				local var_530_5 = manager.ui.mainCamera.transform.position - var_530_0.position

				var_530_0.forward = Vector3.New(var_530_5.x, var_530_5.y, var_530_5.z)

				local var_530_6 = var_530_0.localEulerAngles

				var_530_6.z = 0
				var_530_6.x = 0
				var_530_0.localEulerAngles = var_530_6
			end

			if arg_527_1.time_ >= var_530_1 + var_530_2 and arg_527_1.time_ < var_530_1 + var_530_2 + arg_530_0 then
				var_530_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_530_7 = manager.ui.mainCamera.transform.position - var_530_0.position

				var_530_0.forward = Vector3.New(var_530_7.x, var_530_7.y, var_530_7.z)

				local var_530_8 = var_530_0.localEulerAngles

				var_530_8.z = 0
				var_530_8.x = 0
				var_530_0.localEulerAngles = var_530_8
			end

			local var_530_9 = arg_527_1.actors_["1097ui_story"]
			local var_530_10 = 0

			if var_530_10 < arg_527_1.time_ and arg_527_1.time_ <= var_530_10 + arg_530_0 and not isNil(var_530_9) and arg_527_1.var_.characterEffect1097ui_story == nil then
				arg_527_1.var_.characterEffect1097ui_story = var_530_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_11 = 0.200000002980232

			if var_530_10 <= arg_527_1.time_ and arg_527_1.time_ < var_530_10 + var_530_11 and not isNil(var_530_9) then
				local var_530_12 = (arg_527_1.time_ - var_530_10) / var_530_11

				if arg_527_1.var_.characterEffect1097ui_story and not isNil(var_530_9) then
					arg_527_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= var_530_10 + var_530_11 and arg_527_1.time_ < var_530_10 + var_530_11 + arg_530_0 and not isNil(var_530_9) and arg_527_1.var_.characterEffect1097ui_story then
				arg_527_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_530_13 = 0

			if var_530_13 < arg_527_1.time_ and arg_527_1.time_ <= var_530_13 + arg_530_0 then
				arg_527_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_530_14 = 0

			if var_530_14 < arg_527_1.time_ and arg_527_1.time_ <= var_530_14 + arg_530_0 then
				arg_527_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_530_15 = arg_527_1.actors_["10083ui_story"].transform
			local var_530_16 = 0

			if var_530_16 < arg_527_1.time_ and arg_527_1.time_ <= var_530_16 + arg_530_0 then
				arg_527_1.var_.moveOldPos10083ui_story = var_530_15.localPosition
			end

			local var_530_17 = 0.001

			if var_530_16 <= arg_527_1.time_ and arg_527_1.time_ < var_530_16 + var_530_17 then
				local var_530_18 = (arg_527_1.time_ - var_530_16) / var_530_17
				local var_530_19 = Vector3.New(0, 100, 0)

				var_530_15.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos10083ui_story, var_530_19, var_530_18)

				local var_530_20 = manager.ui.mainCamera.transform.position - var_530_15.position

				var_530_15.forward = Vector3.New(var_530_20.x, var_530_20.y, var_530_20.z)

				local var_530_21 = var_530_15.localEulerAngles

				var_530_21.z = 0
				var_530_21.x = 0
				var_530_15.localEulerAngles = var_530_21
			end

			if arg_527_1.time_ >= var_530_16 + var_530_17 and arg_527_1.time_ < var_530_16 + var_530_17 + arg_530_0 then
				var_530_15.localPosition = Vector3.New(0, 100, 0)

				local var_530_22 = manager.ui.mainCamera.transform.position - var_530_15.position

				var_530_15.forward = Vector3.New(var_530_22.x, var_530_22.y, var_530_22.z)

				local var_530_23 = var_530_15.localEulerAngles

				var_530_23.z = 0
				var_530_23.x = 0
				var_530_15.localEulerAngles = var_530_23
			end

			local var_530_24 = arg_527_1.actors_["10083ui_story"]
			local var_530_25 = 0

			if var_530_25 < arg_527_1.time_ and arg_527_1.time_ <= var_530_25 + arg_530_0 and not isNil(var_530_24) and arg_527_1.var_.characterEffect10083ui_story == nil then
				arg_527_1.var_.characterEffect10083ui_story = var_530_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_26 = 0.200000002980232

			if var_530_25 <= arg_527_1.time_ and arg_527_1.time_ < var_530_25 + var_530_26 and not isNil(var_530_24) then
				local var_530_27 = (arg_527_1.time_ - var_530_25) / var_530_26

				if arg_527_1.var_.characterEffect10083ui_story and not isNil(var_530_24) then
					local var_530_28 = Mathf.Lerp(0, 0.5, var_530_27)

					arg_527_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_527_1.var_.characterEffect10083ui_story.fillRatio = var_530_28
				end
			end

			if arg_527_1.time_ >= var_530_25 + var_530_26 and arg_527_1.time_ < var_530_25 + var_530_26 + arg_530_0 and not isNil(var_530_24) and arg_527_1.var_.characterEffect10083ui_story then
				local var_530_29 = 0.5

				arg_527_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_527_1.var_.characterEffect10083ui_story.fillRatio = var_530_29
			end

			local var_530_30 = 0
			local var_530_31 = 0.425

			if var_530_30 < arg_527_1.time_ and arg_527_1.time_ <= var_530_30 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_32 = arg_527_1:FormatText(StoryNameCfg[216].name)

				arg_527_1.leftNameTxt_.text = var_530_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_33 = arg_527_1:GetWordFromCfg(412031127)
				local var_530_34 = arg_527_1:FormatText(var_530_33.content)

				arg_527_1.text_.text = var_530_34

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_35 = 17
				local var_530_36 = utf8.len(var_530_34)
				local var_530_37 = var_530_35 <= 0 and var_530_31 or var_530_31 * (var_530_36 / var_530_35)

				if var_530_37 > 0 and var_530_31 < var_530_37 then
					arg_527_1.talkMaxDuration = var_530_37

					if var_530_37 + var_530_30 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_37 + var_530_30
					end
				end

				arg_527_1.text_.text = var_530_34
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031127", "story_v_out_412031.awb") ~= 0 then
					local var_530_38 = manager.audio:GetVoiceLength("story_v_out_412031", "412031127", "story_v_out_412031.awb") / 1000

					if var_530_38 + var_530_30 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_38 + var_530_30
					end

					if var_530_33.prefab_name ~= "" and arg_527_1.actors_[var_530_33.prefab_name] ~= nil then
						local var_530_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_33.prefab_name].transform, "story_v_out_412031", "412031127", "story_v_out_412031.awb")

						arg_527_1:RecordAudio("412031127", var_530_39)
						arg_527_1:RecordAudio("412031127", var_530_39)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_412031", "412031127", "story_v_out_412031.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_412031", "412031127", "story_v_out_412031.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_40 = math.max(var_530_31, arg_527_1.talkMaxDuration)

			if var_530_30 <= arg_527_1.time_ and arg_527_1.time_ < var_530_30 + var_530_40 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_30) / var_530_40

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_30 + var_530_40 and arg_527_1.time_ < var_530_30 + var_530_40 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_527_1:InitPlayNodeList()
	end,
	Play412031128 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 412031128
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play412031129(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = arg_531_1.actors_["1097ui_story"].transform
			local var_534_1 = 0

			if var_534_1 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 then
				arg_531_1.var_.moveOldPos1097ui_story = var_534_0.localPosition
			end

			local var_534_2 = 0.001

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_2 then
				local var_534_3 = (arg_531_1.time_ - var_534_1) / var_534_2
				local var_534_4 = Vector3.New(0, 100, 0)

				var_534_0.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1097ui_story, var_534_4, var_534_3)

				local var_534_5 = manager.ui.mainCamera.transform.position - var_534_0.position

				var_534_0.forward = Vector3.New(var_534_5.x, var_534_5.y, var_534_5.z)

				local var_534_6 = var_534_0.localEulerAngles

				var_534_6.z = 0
				var_534_6.x = 0
				var_534_0.localEulerAngles = var_534_6
			end

			if arg_531_1.time_ >= var_534_1 + var_534_2 and arg_531_1.time_ < var_534_1 + var_534_2 + arg_534_0 then
				var_534_0.localPosition = Vector3.New(0, 100, 0)

				local var_534_7 = manager.ui.mainCamera.transform.position - var_534_0.position

				var_534_0.forward = Vector3.New(var_534_7.x, var_534_7.y, var_534_7.z)

				local var_534_8 = var_534_0.localEulerAngles

				var_534_8.z = 0
				var_534_8.x = 0
				var_534_0.localEulerAngles = var_534_8
			end

			local var_534_9 = arg_531_1.actors_["1097ui_story"]
			local var_534_10 = 0

			if var_534_10 < arg_531_1.time_ and arg_531_1.time_ <= var_534_10 + arg_534_0 and not isNil(var_534_9) and arg_531_1.var_.characterEffect1097ui_story == nil then
				arg_531_1.var_.characterEffect1097ui_story = var_534_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_11 = 0.200000002980232

			if var_534_10 <= arg_531_1.time_ and arg_531_1.time_ < var_534_10 + var_534_11 and not isNil(var_534_9) then
				local var_534_12 = (arg_531_1.time_ - var_534_10) / var_534_11

				if arg_531_1.var_.characterEffect1097ui_story and not isNil(var_534_9) then
					local var_534_13 = Mathf.Lerp(0, 0.5, var_534_12)

					arg_531_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_531_1.var_.characterEffect1097ui_story.fillRatio = var_534_13
				end
			end

			if arg_531_1.time_ >= var_534_10 + var_534_11 and arg_531_1.time_ < var_534_10 + var_534_11 + arg_534_0 and not isNil(var_534_9) and arg_531_1.var_.characterEffect1097ui_story then
				local var_534_14 = 0.5

				arg_531_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_531_1.var_.characterEffect1097ui_story.fillRatio = var_534_14
			end

			local var_534_15 = 0
			local var_534_16 = 1.1

			if var_534_15 < arg_531_1.time_ and arg_531_1.time_ <= var_534_15 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, false)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_17 = arg_531_1:GetWordFromCfg(412031128)
				local var_534_18 = arg_531_1:FormatText(var_534_17.content)

				arg_531_1.text_.text = var_534_18

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_19 = 44
				local var_534_20 = utf8.len(var_534_18)
				local var_534_21 = var_534_19 <= 0 and var_534_16 or var_534_16 * (var_534_20 / var_534_19)

				if var_534_21 > 0 and var_534_16 < var_534_21 then
					arg_531_1.talkMaxDuration = var_534_21

					if var_534_21 + var_534_15 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_21 + var_534_15
					end
				end

				arg_531_1.text_.text = var_534_18
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_22 = math.max(var_534_16, arg_531_1.talkMaxDuration)

			if var_534_15 <= arg_531_1.time_ and arg_531_1.time_ < var_534_15 + var_534_22 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_15) / var_534_22

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_15 + var_534_22 and arg_531_1.time_ < var_534_15 + var_534_22 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play412031129 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 412031129
		arg_535_1.duration_ = 9

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play412031130(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = "EN0103"

			if arg_535_1.bgs_[var_538_0] == nil then
				local var_538_1 = Object.Instantiate(arg_535_1.paintGo_)

				var_538_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_538_0)
				var_538_1.name = var_538_0
				var_538_1.transform.parent = arg_535_1.stage_.transform
				var_538_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_535_1.bgs_[var_538_0] = var_538_1
			end

			local var_538_2 = 2

			if var_538_2 < arg_535_1.time_ and arg_535_1.time_ <= var_538_2 + arg_538_0 then
				local var_538_3 = manager.ui.mainCamera.transform.localPosition
				local var_538_4 = Vector3.New(0, 0, 10) + Vector3.New(var_538_3.x, var_538_3.y, 0)
				local var_538_5 = arg_535_1.bgs_.EN0103

				var_538_5.transform.localPosition = var_538_4
				var_538_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_538_6 = var_538_5:GetComponent("SpriteRenderer")

				if var_538_6 and var_538_6.sprite then
					local var_538_7 = (var_538_5.transform.localPosition - var_538_3).z
					local var_538_8 = manager.ui.mainCameraCom_
					local var_538_9 = 2 * var_538_7 * Mathf.Tan(var_538_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_538_10 = var_538_9 * var_538_8.aspect
					local var_538_11 = var_538_6.sprite.bounds.size.x
					local var_538_12 = var_538_6.sprite.bounds.size.y
					local var_538_13 = var_538_10 / var_538_11
					local var_538_14 = var_538_9 / var_538_12
					local var_538_15 = var_538_14 < var_538_13 and var_538_13 or var_538_14

					var_538_5.transform.localScale = Vector3.New(var_538_15, var_538_15, 0)
				end

				for iter_538_0, iter_538_1 in pairs(arg_535_1.bgs_) do
					if iter_538_0 ~= "EN0103" then
						iter_538_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_538_16 = 4

			if var_538_16 < arg_535_1.time_ and arg_535_1.time_ <= var_538_16 + arg_538_0 then
				arg_535_1.allBtn_.enabled = false
			end

			local var_538_17 = 0.3

			if arg_535_1.time_ >= var_538_16 + var_538_17 and arg_535_1.time_ < var_538_16 + var_538_17 + arg_538_0 then
				arg_535_1.allBtn_.enabled = true
			end

			local var_538_18 = 0

			if var_538_18 < arg_535_1.time_ and arg_535_1.time_ <= var_538_18 + arg_538_0 then
				arg_535_1.mask_.enabled = true
				arg_535_1.mask_.raycastTarget = true

				arg_535_1:SetGaussion(false)
			end

			local var_538_19 = 2

			if var_538_18 <= arg_535_1.time_ and arg_535_1.time_ < var_538_18 + var_538_19 then
				local var_538_20 = (arg_535_1.time_ - var_538_18) / var_538_19
				local var_538_21 = Color.New(0, 0, 0)

				var_538_21.a = Mathf.Lerp(0, 1, var_538_20)
				arg_535_1.mask_.color = var_538_21
			end

			if arg_535_1.time_ >= var_538_18 + var_538_19 and arg_535_1.time_ < var_538_18 + var_538_19 + arg_538_0 then
				local var_538_22 = Color.New(0, 0, 0)

				var_538_22.a = 1
				arg_535_1.mask_.color = var_538_22
			end

			local var_538_23 = 2

			if var_538_23 < arg_535_1.time_ and arg_535_1.time_ <= var_538_23 + arg_538_0 then
				arg_535_1.mask_.enabled = true
				arg_535_1.mask_.raycastTarget = true

				arg_535_1:SetGaussion(false)
			end

			local var_538_24 = 2

			if var_538_23 <= arg_535_1.time_ and arg_535_1.time_ < var_538_23 + var_538_24 then
				local var_538_25 = (arg_535_1.time_ - var_538_23) / var_538_24
				local var_538_26 = Color.New(0, 0, 0)

				var_538_26.a = Mathf.Lerp(1, 0, var_538_25)
				arg_535_1.mask_.color = var_538_26
			end

			if arg_535_1.time_ >= var_538_23 + var_538_24 and arg_535_1.time_ < var_538_23 + var_538_24 + arg_538_0 then
				local var_538_27 = Color.New(0, 0, 0)
				local var_538_28 = 0

				arg_535_1.mask_.enabled = false
				var_538_27.a = var_538_28
				arg_535_1.mask_.color = var_538_27
			end

			local var_538_29 = 0
			local var_538_30 = 0.233333333333333

			if var_538_29 < arg_535_1.time_ and arg_535_1.time_ <= var_538_29 + arg_538_0 then
				local var_538_31 = "play"
				local var_538_32 = "music"

				arg_535_1:AudioAction(var_538_31, var_538_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_538_33 = ""
				local var_538_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_538_34 ~= "" then
					if arg_535_1.bgmTxt_.text ~= var_538_34 and arg_535_1.bgmTxt_.text ~= "" then
						if arg_535_1.bgmTxt2_.text ~= "" then
							arg_535_1.bgmTxt_.text = arg_535_1.bgmTxt2_.text
						end

						arg_535_1.bgmTxt2_.text = var_538_34

						arg_535_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_535_1.bgmTxt_.text = var_538_34
						arg_535_1.bgmTxt2_.text = var_538_34
					end

					if arg_535_1.bgmTimer then
						arg_535_1.bgmTimer:Stop()

						arg_535_1.bgmTimer = nil
					end

					if arg_535_1.settingData.show_music_name == 1 then
						arg_535_1.musicController:SetSelectedState("show")
						arg_535_1.musicAnimator_:Play("open", 0, 0)

						if arg_535_1.settingData.music_time ~= 0 then
							arg_535_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_535_1.settingData.music_time), function()
								if arg_535_1 == nil or isNil(arg_535_1.bgmTxt_) then
									return
								end

								arg_535_1.musicController:SetSelectedState("hide")
								arg_535_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_538_35 = arg_535_1.bgs_.EN0103.transform
			local var_538_36 = 2

			if var_538_36 < arg_535_1.time_ and arg_535_1.time_ <= var_538_36 + arg_538_0 then
				arg_535_1.var_.moveOldPosEN0103 = var_538_35.localPosition
			end

			local var_538_37 = 3

			if var_538_36 <= arg_535_1.time_ and arg_535_1.time_ < var_538_36 + var_538_37 then
				local var_538_38 = (arg_535_1.time_ - var_538_36) / var_538_37
				local var_538_39 = Vector3.New(0, 1, 9)

				var_538_35.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPosEN0103, var_538_39, var_538_38)
			end

			if arg_535_1.time_ >= var_538_36 + var_538_37 and arg_535_1.time_ < var_538_36 + var_538_37 + arg_538_0 then
				var_538_35.localPosition = Vector3.New(0, 1, 9)
			end

			local var_538_40 = 4

			if var_538_40 < arg_535_1.time_ and arg_535_1.time_ <= var_538_40 + arg_538_0 then
				arg_535_1.allBtn_.enabled = false
			end

			local var_538_41 = 1

			if arg_535_1.time_ >= var_538_40 + var_538_41 and arg_535_1.time_ < var_538_40 + var_538_41 + arg_538_0 then
				arg_535_1.allBtn_.enabled = true
			end

			if arg_535_1.frameCnt_ <= 1 then
				arg_535_1.dialog_:SetActive(false)
			end

			local var_538_42 = 4
			local var_538_43 = 0.45

			if var_538_42 < arg_535_1.time_ and arg_535_1.time_ <= var_538_42 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0

				arg_535_1.dialog_:SetActive(true)

				arg_535_1.dialogCg_.alpha = 0

				local var_538_44 = LeanTween.value(arg_535_1.dialog_, 0, 1, 0.3)

				var_538_44:setOnUpdate(LuaHelper.FloatAction(function(arg_540_0)
					arg_535_1.dialogCg_.alpha = arg_540_0
				end))
				var_538_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_535_1.dialog_)
					var_538_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_535_1.duration_ = arg_535_1.duration_ + 0.3

				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_45 = arg_535_1:GetWordFromCfg(412031129)
				local var_538_46 = arg_535_1:FormatText(var_538_45.content)

				arg_535_1.text_.text = var_538_46

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_47 = 18
				local var_538_48 = utf8.len(var_538_46)
				local var_538_49 = var_538_47 <= 0 and var_538_43 or var_538_43 * (var_538_48 / var_538_47)

				if var_538_49 > 0 and var_538_43 < var_538_49 then
					arg_535_1.talkMaxDuration = var_538_49
					var_538_42 = var_538_42 + 0.3

					if var_538_49 + var_538_42 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_49 + var_538_42
					end
				end

				arg_535_1.text_.text = var_538_46
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_50 = var_538_42 + 0.3
			local var_538_51 = math.max(var_538_43, arg_535_1.talkMaxDuration)

			if var_538_50 <= arg_535_1.time_ and arg_535_1.time_ < var_538_50 + var_538_51 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_50) / var_538_51

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_50 + var_538_51 and arg_535_1.time_ < var_538_50 + var_538_51 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "EN0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play412031130 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 412031130
		arg_542_1.duration_ = 5

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play412031131(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 0
			local var_545_1 = 0.85

			if var_545_0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_0 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, false)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_2 = arg_542_1:GetWordFromCfg(412031130)
				local var_545_3 = arg_542_1:FormatText(var_545_2.content)

				arg_542_1.text_.text = var_545_3

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_4 = 34
				local var_545_5 = utf8.len(var_545_3)
				local var_545_6 = var_545_4 <= 0 and var_545_1 or var_545_1 * (var_545_5 / var_545_4)

				if var_545_6 > 0 and var_545_1 < var_545_6 then
					arg_542_1.talkMaxDuration = var_545_6

					if var_545_6 + var_545_0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_6 + var_545_0
					end
				end

				arg_542_1.text_.text = var_545_3
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_7 = math.max(var_545_1, arg_542_1.talkMaxDuration)

			if var_545_0 <= arg_542_1.time_ and arg_542_1.time_ < var_545_0 + var_545_7 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_0) / var_545_7

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_0 + var_545_7 and arg_542_1.time_ < var_545_0 + var_545_7 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play412031131 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 412031131
		arg_546_1.duration_ = 5

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play412031132(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0
			local var_549_1 = 0.45

			if var_549_0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, false)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_2 = arg_546_1:GetWordFromCfg(412031131)
				local var_549_3 = arg_546_1:FormatText(var_549_2.content)

				arg_546_1.text_.text = var_549_3

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_4 = 18
				local var_549_5 = utf8.len(var_549_3)
				local var_549_6 = var_549_4 <= 0 and var_549_1 or var_549_1 * (var_549_5 / var_549_4)

				if var_549_6 > 0 and var_549_1 < var_549_6 then
					arg_546_1.talkMaxDuration = var_549_6

					if var_549_6 + var_549_0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_6 + var_549_0
					end
				end

				arg_546_1.text_.text = var_549_3
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_7 = math.max(var_549_1, arg_546_1.talkMaxDuration)

			if var_549_0 <= arg_546_1.time_ and arg_546_1.time_ < var_549_0 + var_549_7 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_0) / var_549_7

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_0 + var_549_7 and arg_546_1.time_ < var_549_0 + var_549_7 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play412031132 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 412031132
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play412031133(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0
			local var_553_1 = 1.075

			if var_553_0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, false)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_2 = arg_550_1:GetWordFromCfg(412031132)
				local var_553_3 = arg_550_1:FormatText(var_553_2.content)

				arg_550_1.text_.text = var_553_3

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_4 = 43
				local var_553_5 = utf8.len(var_553_3)
				local var_553_6 = var_553_4 <= 0 and var_553_1 or var_553_1 * (var_553_5 / var_553_4)

				if var_553_6 > 0 and var_553_1 < var_553_6 then
					arg_550_1.talkMaxDuration = var_553_6

					if var_553_6 + var_553_0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_6 + var_553_0
					end
				end

				arg_550_1.text_.text = var_553_3
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_7 = math.max(var_553_1, arg_550_1.talkMaxDuration)

			if var_553_0 <= arg_550_1.time_ and arg_550_1.time_ < var_553_0 + var_553_7 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_0) / var_553_7

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_0 + var_553_7 and arg_550_1.time_ < var_553_0 + var_553_7 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play412031133 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 412031133
		arg_554_1.duration_ = 6.33

		local var_554_0 = {
			zh = 6.1,
			ja = 6.333
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play412031134(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 0
			local var_557_1 = 0.6

			if var_557_0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				local var_557_2 = arg_554_1:FormatText(StoryNameCfg[917].name)

				arg_554_1.leftNameTxt_.text = var_557_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, true)
				arg_554_1.iconController_:SetSelectedState("hero")

				arg_554_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10076")

				arg_554_1.callingController_:SetSelectedState("normal")

				arg_554_1.keyicon_.color = Color.New(1, 1, 1)
				arg_554_1.icon_.color = Color.New(1, 1, 1)

				local var_557_3 = arg_554_1:GetWordFromCfg(412031133)
				local var_557_4 = arg_554_1:FormatText(var_557_3.content)

				arg_554_1.text_.text = var_557_4

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_5 = 24
				local var_557_6 = utf8.len(var_557_4)
				local var_557_7 = var_557_5 <= 0 and var_557_1 or var_557_1 * (var_557_6 / var_557_5)

				if var_557_7 > 0 and var_557_1 < var_557_7 then
					arg_554_1.talkMaxDuration = var_557_7

					if var_557_7 + var_557_0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_7 + var_557_0
					end
				end

				arg_554_1.text_.text = var_557_4
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031133", "story_v_out_412031.awb") ~= 0 then
					local var_557_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031133", "story_v_out_412031.awb") / 1000

					if var_557_8 + var_557_0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_8 + var_557_0
					end

					if var_557_3.prefab_name ~= "" and arg_554_1.actors_[var_557_3.prefab_name] ~= nil then
						local var_557_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_3.prefab_name].transform, "story_v_out_412031", "412031133", "story_v_out_412031.awb")

						arg_554_1:RecordAudio("412031133", var_557_9)
						arg_554_1:RecordAudio("412031133", var_557_9)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_out_412031", "412031133", "story_v_out_412031.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_out_412031", "412031133", "story_v_out_412031.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_10 = math.max(var_557_1, arg_554_1.talkMaxDuration)

			if var_557_0 <= arg_554_1.time_ and arg_554_1.time_ < var_557_0 + var_557_10 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_0) / var_557_10

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_0 + var_557_10 and arg_554_1.time_ < var_557_0 + var_557_10 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play412031134 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 412031134
		arg_558_1.duration_ = 5

		local var_558_0 = {
			zh = 4,
			ja = 5
		}
		local var_558_1 = manager.audio:GetLocalizationFlag()

		if var_558_0[var_558_1] ~= nil then
			arg_558_1.duration_ = var_558_0[var_558_1]
		end

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play412031135(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0
			local var_561_1 = 0.275

			if var_561_0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				local var_561_2 = arg_558_1:FormatText(StoryNameCfg[216].name)

				arg_558_1.leftNameTxt_.text = var_561_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_3 = arg_558_1:GetWordFromCfg(412031134)
				local var_561_4 = arg_558_1:FormatText(var_561_3.content)

				arg_558_1.text_.text = var_561_4

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_5 = 11
				local var_561_6 = utf8.len(var_561_4)
				local var_561_7 = var_561_5 <= 0 and var_561_1 or var_561_1 * (var_561_6 / var_561_5)

				if var_561_7 > 0 and var_561_1 < var_561_7 then
					arg_558_1.talkMaxDuration = var_561_7

					if var_561_7 + var_561_0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_7 + var_561_0
					end
				end

				arg_558_1.text_.text = var_561_4
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031134", "story_v_out_412031.awb") ~= 0 then
					local var_561_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031134", "story_v_out_412031.awb") / 1000

					if var_561_8 + var_561_0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_8 + var_561_0
					end

					if var_561_3.prefab_name ~= "" and arg_558_1.actors_[var_561_3.prefab_name] ~= nil then
						local var_561_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_3.prefab_name].transform, "story_v_out_412031", "412031134", "story_v_out_412031.awb")

						arg_558_1:RecordAudio("412031134", var_561_9)
						arg_558_1:RecordAudio("412031134", var_561_9)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_out_412031", "412031134", "story_v_out_412031.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_out_412031", "412031134", "story_v_out_412031.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_10 = math.max(var_561_1, arg_558_1.talkMaxDuration)

			if var_561_0 <= arg_558_1.time_ and arg_558_1.time_ < var_561_0 + var_561_10 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_0) / var_561_10

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_0 + var_561_10 and arg_558_1.time_ < var_561_0 + var_561_10 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play412031135 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 412031135
		arg_562_1.duration_ = 5.13

		local var_562_0 = {
			zh = 3.833,
			ja = 5.133
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
			arg_562_1.auto_ = false
		end

		function arg_562_1.playNext_(arg_564_0)
			arg_562_1.onStoryFinished_()
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0
			local var_565_1 = 0.25

			if var_565_0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				local var_565_2 = arg_562_1:FormatText(StoryNameCfg[216].name)

				arg_562_1.leftNameTxt_.text = var_565_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_3 = arg_562_1:GetWordFromCfg(412031135)
				local var_565_4 = arg_562_1:FormatText(var_565_3.content)

				arg_562_1.text_.text = var_565_4

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_5 = 10
				local var_565_6 = utf8.len(var_565_4)
				local var_565_7 = var_565_5 <= 0 and var_565_1 or var_565_1 * (var_565_6 / var_565_5)

				if var_565_7 > 0 and var_565_1 < var_565_7 then
					arg_562_1.talkMaxDuration = var_565_7

					if var_565_7 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_7 + var_565_0
					end
				end

				arg_562_1.text_.text = var_565_4
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412031", "412031135", "story_v_out_412031.awb") ~= 0 then
					local var_565_8 = manager.audio:GetVoiceLength("story_v_out_412031", "412031135", "story_v_out_412031.awb") / 1000

					if var_565_8 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_8 + var_565_0
					end

					if var_565_3.prefab_name ~= "" and arg_562_1.actors_[var_565_3.prefab_name] ~= nil then
						local var_565_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_3.prefab_name].transform, "story_v_out_412031", "412031135", "story_v_out_412031.awb")

						arg_562_1:RecordAudio("412031135", var_565_9)
						arg_562_1:RecordAudio("412031135", var_565_9)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_out_412031", "412031135", "story_v_out_412031.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_out_412031", "412031135", "story_v_out_412031.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_10 = math.max(var_565_1, arg_562_1.talkMaxDuration)

			if var_565_0 <= arg_562_1.time_ and arg_562_1.time_ < var_565_0 + var_565_10 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_0) / var_565_10

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_0 + var_565_10 and arg_562_1.time_ < var_565_0 + var_565_10 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I09j",
		"TextureConfig/Background/ST30",
		"TextureConfig/Background/EN0101",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/EN0103"
	},
	voices = {
		"story_v_out_412031.awb"
	}
}
