return {
	Play416011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416011001
		arg_1_1.duration_ = 22.2

		local var_1_0 = {
			zh = 15.4,
			ja = 22.2
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
				arg_1_0:Play416011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

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
				local var_4_5 = arg_1_1.bgs_.STblack

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
					if iter_4_0 ~= "STblack" then
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
			local var_4_23 = 0.2

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

			local var_4_28 = 1
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "se_story_138", "se_story_138_carloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_32 = 2
			local var_4_33 = 1.425

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_34 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_34:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_35 = arg_1_1:GetWordFromCfg(416011001)
				local var_4_36 = arg_1_1:FormatText(var_4_35.content)

				arg_1_1.text_.text = var_4_36

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_37 = 57
				local var_4_38 = utf8.len(var_4_36)
				local var_4_39 = var_4_37 <= 0 and var_4_33 or var_4_33 * (var_4_38 / var_4_37)

				if var_4_39 > 0 and var_4_33 < var_4_39 then
					arg_1_1.talkMaxDuration = var_4_39
					var_4_32 = var_4_32 + 0.3

					if var_4_39 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_32
					end
				end

				arg_1_1.text_.text = var_4_36
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011001", "story_v_out_416011.awb") ~= 0 then
					local var_4_40 = manager.audio:GetVoiceLength("story_v_out_416011", "416011001", "story_v_out_416011.awb") / 1000

					if var_4_40 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_40 + var_4_32
					end

					if var_4_35.prefab_name ~= "" and arg_1_1.actors_[var_4_35.prefab_name] ~= nil then
						local var_4_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_35.prefab_name].transform, "story_v_out_416011", "416011001", "story_v_out_416011.awb")

						arg_1_1:RecordAudio("416011001", var_4_41)
						arg_1_1:RecordAudio("416011001", var_4_41)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416011", "416011001", "story_v_out_416011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416011", "416011001", "story_v_out_416011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_32 + 0.3
			local var_4_43 = math.max(var_4_33, arg_1_1.talkMaxDuration)

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
	Play416011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 416011002
		arg_8_1.duration_ = 8

		local var_8_0 = {
			zh = 7.3,
			ja = 8
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play416011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.9

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(416011002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 36
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011002", "story_v_out_416011.awb") ~= 0 then
					local var_11_7 = manager.audio:GetVoiceLength("story_v_out_416011", "416011002", "story_v_out_416011.awb") / 1000

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end

					if var_11_2.prefab_name ~= "" and arg_8_1.actors_[var_11_2.prefab_name] ~= nil then
						local var_11_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_2.prefab_name].transform, "story_v_out_416011", "416011002", "story_v_out_416011.awb")

						arg_8_1:RecordAudio("416011002", var_11_8)
						arg_8_1:RecordAudio("416011002", var_11_8)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_416011", "416011002", "story_v_out_416011.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_416011", "416011002", "story_v_out_416011.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_9 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_9 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_9

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_9 and arg_8_1.time_ < var_11_0 + var_11_9 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play416011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 416011003
		arg_12_1.duration_ = 4.83

		local var_12_0 = {
			zh = 3.033,
			ja = 4.833
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
				arg_12_0:Play416011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.325

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(416011003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 13
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011003", "story_v_out_416011.awb") ~= 0 then
					local var_15_7 = manager.audio:GetVoiceLength("story_v_out_416011", "416011003", "story_v_out_416011.awb") / 1000

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end

					if var_15_2.prefab_name ~= "" and arg_12_1.actors_[var_15_2.prefab_name] ~= nil then
						local var_15_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_2.prefab_name].transform, "story_v_out_416011", "416011003", "story_v_out_416011.awb")

						arg_12_1:RecordAudio("416011003", var_15_8)
						arg_12_1:RecordAudio("416011003", var_15_8)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_416011", "416011003", "story_v_out_416011.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_416011", "416011003", "story_v_out_416011.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_9 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_9 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_9

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_9 and arg_12_1.time_ < var_15_0 + var_15_9 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play416011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 416011004
		arg_16_1.duration_ = 4.5

		local var_16_0 = {
			zh = 4.5,
			ja = 4.466
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
				arg_16_0:Play416011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.166666666666667
			local var_19_1 = 0.833333333333333

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				local var_19_2 = "stop"
				local var_19_3 = "effect"

				arg_16_1:AudioAction(var_19_2, var_19_3, "se_story_138", "se_story_138_carloop", "")
			end

			local var_19_4 = 0.166666666666667
			local var_19_5 = 0.833333333333333

			if var_19_4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				local var_19_6 = "play"
				local var_19_7 = "effect"

				arg_16_1:AudioAction(var_19_6, var_19_7, "se_story_138", "se_story_138_carloop_stop", "")
			end

			local var_19_8 = 0
			local var_19_9 = 1

			if var_19_8 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				local var_19_10 = "play"
				local var_19_11 = "effect"

				arg_16_1:AudioAction(var_19_10, var_19_11, "se_story_side_1094", "se_story_1094_alarmclock", "")
			end

			local var_19_12 = 0
			local var_19_13 = 0.6

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_14 = arg_16_1:FormatText(StoryNameCfg[646].name)

				arg_16_1.leftNameTxt_.text = var_19_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_15 = arg_16_1:GetWordFromCfg(416011004)
				local var_19_16 = arg_16_1:FormatText(var_19_15.content)

				arg_16_1.text_.text = var_19_16

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_17 = 24
				local var_19_18 = utf8.len(var_19_16)
				local var_19_19 = var_19_17 <= 0 and var_19_13 or var_19_13 * (var_19_18 / var_19_17)

				if var_19_19 > 0 and var_19_13 < var_19_19 then
					arg_16_1.talkMaxDuration = var_19_19

					if var_19_19 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_19 + var_19_12
					end
				end

				arg_16_1.text_.text = var_19_16
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011004", "story_v_out_416011.awb") ~= 0 then
					local var_19_20 = manager.audio:GetVoiceLength("story_v_out_416011", "416011004", "story_v_out_416011.awb") / 1000

					if var_19_20 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_20 + var_19_12
					end

					if var_19_15.prefab_name ~= "" and arg_16_1.actors_[var_19_15.prefab_name] ~= nil then
						local var_19_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_15.prefab_name].transform, "story_v_out_416011", "416011004", "story_v_out_416011.awb")

						arg_16_1:RecordAudio("416011004", var_19_21)
						arg_16_1:RecordAudio("416011004", var_19_21)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_416011", "416011004", "story_v_out_416011.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_416011", "416011004", "story_v_out_416011.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_22 = math.max(var_19_13, arg_16_1.talkMaxDuration)

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_22 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_12) / var_19_22

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_12 + var_19_22 and arg_16_1.time_ < var_19_12 + var_19_22 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play416011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 416011005
		arg_20_1.duration_ = 7.3

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play416011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 1.3

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				local var_23_1 = manager.ui.mainCamera.transform.localPosition
				local var_23_2 = Vector3.New(0, 0, 10) + Vector3.New(var_23_1.x, var_23_1.y, 0)
				local var_23_3 = arg_20_1.bgs_.STblack

				var_23_3.transform.localPosition = var_23_2
				var_23_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_4 = var_23_3:GetComponent("SpriteRenderer")

				if var_23_4 and var_23_4.sprite then
					local var_23_5 = (var_23_3.transform.localPosition - var_23_1).z
					local var_23_6 = manager.ui.mainCameraCom_
					local var_23_7 = 2 * var_23_5 * Mathf.Tan(var_23_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_23_8 = var_23_7 * var_23_6.aspect
					local var_23_9 = var_23_4.sprite.bounds.size.x
					local var_23_10 = var_23_4.sprite.bounds.size.y
					local var_23_11 = var_23_8 / var_23_9
					local var_23_12 = var_23_7 / var_23_10
					local var_23_13 = var_23_12 < var_23_11 and var_23_11 or var_23_12

					var_23_3.transform.localScale = Vector3.New(var_23_13, var_23_13, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "STblack" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_14 = 0

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_15 = 1.3

			if var_23_14 <= arg_20_1.time_ and arg_20_1.time_ < var_23_14 + var_23_15 then
				local var_23_16 = (arg_20_1.time_ - var_23_14) / var_23_15
				local var_23_17 = Color.New(0, 0, 0)

				var_23_17.a = Mathf.Lerp(0, 1, var_23_16)
				arg_20_1.mask_.color = var_23_17
			end

			if arg_20_1.time_ >= var_23_14 + var_23_15 and arg_20_1.time_ < var_23_14 + var_23_15 + arg_23_0 then
				local var_23_18 = Color.New(0, 0, 0)

				var_23_18.a = 1
				arg_20_1.mask_.color = var_23_18
			end

			local var_23_19 = 1.3

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_20 = 1.33333333333333

			if var_23_19 <= arg_20_1.time_ and arg_20_1.time_ < var_23_19 + var_23_20 then
				local var_23_21 = (arg_20_1.time_ - var_23_19) / var_23_20
				local var_23_22 = Color.New(0, 0, 0)

				var_23_22.a = Mathf.Lerp(1, 0, var_23_21)
				arg_20_1.mask_.color = var_23_22
			end

			if arg_20_1.time_ >= var_23_19 + var_23_20 and arg_20_1.time_ < var_23_19 + var_23_20 + arg_23_0 then
				local var_23_23 = Color.New(0, 0, 0)
				local var_23_24 = 0

				arg_20_1.mask_.enabled = false
				var_23_23.a = var_23_24
				arg_20_1.mask_.color = var_23_23
			end

			local var_23_25 = 2.299999999999

			if var_23_25 < arg_20_1.time_ and arg_20_1.time_ <= var_23_25 + arg_23_0 then
				local var_23_26 = arg_20_1.fswbg_.transform:Find("textbox/adapt/content") or arg_20_1.fswbg_.transform:Find("textbox/content")
				local var_23_27 = arg_20_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_23_28 = var_23_26:GetComponent("Text")
				local var_23_29 = var_23_26:GetComponent("RectTransform")

				var_23_28.alignment = UnityEngine.TextAnchor.MiddleLeft
				var_23_29.offsetMin = Vector2.New(0, 0)
				var_23_29.offsetMax = Vector2.New(0, 0)
			end

			local var_23_30 = 1.3

			if var_23_30 < arg_20_1.time_ and arg_20_1.time_ <= var_23_30 + arg_23_0 then
				arg_20_1.fswbg_:SetActive(true)
				arg_20_1.dialog_:SetActive(false)

				arg_20_1.fswtw_.percent = 0

				local var_23_31 = arg_20_1:GetWordFromCfg(416011005)
				local var_23_32 = arg_20_1:FormatText(var_23_31.content)

				arg_20_1.fswt_.text = var_23_32

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.fswt_)

				arg_20_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_20_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_20_1.fswtw_:SetDirty()

				arg_20_1.typewritterCharCountI18N = 0

				SetActive(arg_20_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_20_1:ShowNextGo(false)
			end

			local var_23_33 = 2.299999999999

			if var_23_33 < arg_20_1.time_ and arg_20_1.time_ <= var_23_33 + arg_23_0 then
				arg_20_1.var_.oldValueTypewriter = arg_20_1.fswtw_.percent

				SetActive(arg_20_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_20_1:ShowNextGo(false)
			end

			local var_23_34 = 30
			local var_23_35 = 2
			local var_23_36 = arg_20_1:GetWordFromCfg(416011005)
			local var_23_37 = arg_20_1:FormatText(var_23_36.content)
			local var_23_38, var_23_39 = arg_20_1:GetPercentByPara(var_23_37, 2)

			if var_23_33 < arg_20_1.time_ and arg_20_1.time_ <= var_23_33 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				local var_23_40 = var_23_34 <= 0 and var_23_35 or var_23_35 * ((var_23_39 - arg_20_1.typewritterCharCountI18N) / var_23_34)

				if var_23_40 > 0 and var_23_35 < var_23_40 then
					arg_20_1.talkMaxDuration = var_23_40

					if var_23_40 + var_23_33 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_40 + var_23_33
					end
				end
			end

			local var_23_41 = 2
			local var_23_42 = math.max(var_23_41, arg_20_1.talkMaxDuration)

			if var_23_33 <= arg_20_1.time_ and arg_20_1.time_ < var_23_33 + var_23_42 then
				local var_23_43 = (arg_20_1.time_ - var_23_33) / var_23_42

				arg_20_1.fswtw_.percent = Mathf.Lerp(arg_20_1.var_.oldValueTypewriter, var_23_38, var_23_43)
				arg_20_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_20_1.fswtw_:SetDirty()
			end

			if arg_20_1.time_ >= var_23_33 + var_23_42 and arg_20_1.time_ < var_23_33 + var_23_42 + arg_23_0 then
				arg_20_1.fswtw_.percent = var_23_38

				arg_20_1.fswtw_:SetDirty()
				arg_20_1:ShowNextGo(true)

				arg_20_1.typewritterCharCountI18N = var_23_39
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play416011006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 416011006
		arg_24_1.duration_ = 8.77

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play416011007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "I13g"

			if arg_24_1.bgs_[var_27_0] == nil then
				local var_27_1 = Object.Instantiate(arg_24_1.paintGo_)

				var_27_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_27_0)
				var_27_1.name = var_27_0
				var_27_1.transform.parent = arg_24_1.stage_.transform
				var_27_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.bgs_[var_27_0] = var_27_1
			end

			local var_27_2 = 1.96666666666667

			if var_27_2 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				local var_27_3 = manager.ui.mainCamera.transform.localPosition
				local var_27_4 = Vector3.New(0, 0, 10) + Vector3.New(var_27_3.x, var_27_3.y, 0)
				local var_27_5 = arg_24_1.bgs_.I13g

				var_27_5.transform.localPosition = var_27_4
				var_27_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_27_6 = var_27_5:GetComponent("SpriteRenderer")

				if var_27_6 and var_27_6.sprite then
					local var_27_7 = (var_27_5.transform.localPosition - var_27_3).z
					local var_27_8 = manager.ui.mainCameraCom_
					local var_27_9 = 2 * var_27_7 * Mathf.Tan(var_27_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_27_10 = var_27_9 * var_27_8.aspect
					local var_27_11 = var_27_6.sprite.bounds.size.x
					local var_27_12 = var_27_6.sprite.bounds.size.y
					local var_27_13 = var_27_10 / var_27_11
					local var_27_14 = var_27_9 / var_27_12
					local var_27_15 = var_27_14 < var_27_13 and var_27_13 or var_27_14

					var_27_5.transform.localScale = Vector3.New(var_27_15, var_27_15, 0)
				end

				for iter_27_0, iter_27_1 in pairs(arg_24_1.bgs_) do
					if iter_27_0 ~= "I13g" then
						iter_27_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_27_16 = 0

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_17 = 1.96666666666667

			if var_27_16 <= arg_24_1.time_ and arg_24_1.time_ < var_27_16 + var_27_17 then
				local var_27_18 = (arg_24_1.time_ - var_27_16) / var_27_17
				local var_27_19 = Color.New(0, 0, 0)

				var_27_19.a = Mathf.Lerp(0, 1, var_27_18)
				arg_24_1.mask_.color = var_27_19
			end

			if arg_24_1.time_ >= var_27_16 + var_27_17 and arg_24_1.time_ < var_27_16 + var_27_17 + arg_27_0 then
				local var_27_20 = Color.New(0, 0, 0)

				var_27_20.a = 1
				arg_24_1.mask_.color = var_27_20
			end

			local var_27_21 = 1.96666666666667

			if var_27_21 < arg_24_1.time_ and arg_24_1.time_ <= var_27_21 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_22 = 1.8

			if var_27_21 <= arg_24_1.time_ and arg_24_1.time_ < var_27_21 + var_27_22 then
				local var_27_23 = (arg_24_1.time_ - var_27_21) / var_27_22
				local var_27_24 = Color.New(0, 0, 0)

				var_27_24.a = Mathf.Lerp(1, 0, var_27_23)
				arg_24_1.mask_.color = var_27_24
			end

			if arg_24_1.time_ >= var_27_21 + var_27_22 and arg_24_1.time_ < var_27_21 + var_27_22 + arg_27_0 then
				local var_27_25 = Color.New(0, 0, 0)
				local var_27_26 = 0

				arg_24_1.mask_.enabled = false
				var_27_25.a = var_27_26
				arg_24_1.mask_.color = var_27_25
			end

			local var_27_27 = 1.96666666666667

			if var_27_27 < arg_24_1.time_ and arg_24_1.time_ <= var_27_27 + arg_27_0 then
				arg_24_1.fswbg_:SetActive(false)
				arg_24_1.dialog_:SetActive(false)
				SetActive(arg_24_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_24_1:ShowNextGo(false)
			end

			local var_27_28 = 1.98333333333333

			if var_27_28 < arg_24_1.time_ and arg_24_1.time_ <= var_27_28 + arg_27_0 then
				arg_24_1.fswbg_:SetActive(false)
				arg_24_1.dialog_:SetActive(false)
				SetActive(arg_24_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_24_1:ShowNextGo(false)
			end

			local var_27_29 = 1.83333333333333
			local var_27_30 = 1

			if var_27_29 < arg_24_1.time_ and arg_24_1.time_ <= var_27_29 + arg_27_0 then
				local var_27_31 = "play"
				local var_27_32 = "effect"

				arg_24_1:AudioAction(var_27_31, var_27_32, "se_story_side_1080", "se_story_1080_door", "")
			end

			local var_27_33 = 1.83333333333333
			local var_27_34 = 1

			if var_27_33 < arg_24_1.time_ and arg_24_1.time_ <= var_27_33 + arg_27_0 then
				local var_27_35 = "play"
				local var_27_36 = "effect"

				arg_24_1:AudioAction(var_27_35, var_27_36, "se_story_133", "se_story_133_sea", "")
			end

			local var_27_37 = 1.36666666666667
			local var_27_38 = 1

			if var_27_37 < arg_24_1.time_ and arg_24_1.time_ <= var_27_37 + arg_27_0 then
				local var_27_39 = "play"
				local var_27_40 = "music"

				arg_24_1:AudioAction(var_27_39, var_27_40, "bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1.awb")

				local var_27_41 = ""
				local var_27_42 = manager.audio:GetAudioName("bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1")

				if var_27_42 ~= "" then
					if arg_24_1.bgmTxt_.text ~= var_27_42 and arg_24_1.bgmTxt_.text ~= "" then
						if arg_24_1.bgmTxt2_.text ~= "" then
							arg_24_1.bgmTxt_.text = arg_24_1.bgmTxt2_.text
						end

						arg_24_1.bgmTxt2_.text = var_27_42

						arg_24_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_24_1.bgmTxt_.text = var_27_42
						arg_24_1.bgmTxt2_.text = var_27_42
					end

					if arg_24_1.bgmTimer then
						arg_24_1.bgmTimer:Stop()

						arg_24_1.bgmTimer = nil
					end

					if arg_24_1.settingData.show_music_name == 1 then
						arg_24_1.musicController:SetSelectedState("show")
						arg_24_1.musicAnimator_:Play("open", 0, 0)

						if arg_24_1.settingData.music_time ~= 0 then
							arg_24_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_24_1.settingData.music_time), function()
								if arg_24_1 == nil or isNil(arg_24_1.bgmTxt_) then
									return
								end

								arg_24_1.musicController:SetSelectedState("hide")
								arg_24_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_43 = 3.76666666666667
			local var_27_44 = 1.95

			if var_27_43 < arg_24_1.time_ and arg_24_1.time_ <= var_27_43 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_45 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_45:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_24_1.dialogCg_.alpha = arg_29_0
				end))
				var_27_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_46 = arg_24_1:GetWordFromCfg(416011006)
				local var_27_47 = arg_24_1:FormatText(var_27_46.content)

				arg_24_1.text_.text = var_27_47

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_48 = 78
				local var_27_49 = utf8.len(var_27_47)
				local var_27_50 = var_27_48 <= 0 and var_27_44 or var_27_44 * (var_27_49 / var_27_48)

				if var_27_50 > 0 and var_27_44 < var_27_50 then
					arg_24_1.talkMaxDuration = var_27_50
					var_27_43 = var_27_43 + 0.3

					if var_27_50 + var_27_43 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_50 + var_27_43
					end
				end

				arg_24_1.text_.text = var_27_47
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_51 = var_27_43 + 0.3
			local var_27_52 = math.max(var_27_44, arg_24_1.talkMaxDuration)

			if var_27_51 <= arg_24_1.time_ and arg_24_1.time_ < var_27_51 + var_27_52 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_51) / var_27_52

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_51 + var_27_52 and arg_24_1.time_ < var_27_51 + var_27_52 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play416011007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 416011007
		arg_31_1.duration_ = 8.67

		local var_31_0 = {
			zh = 6.933,
			ja = 8.666
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
				arg_31_0:Play416011008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = "1086"

			if arg_31_1.actors_[var_34_0] == nil then
				local var_34_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_34_1) then
					local var_34_2 = Object.Instantiate(var_34_1, arg_31_1.canvasGo_.transform)

					var_34_2.transform:SetSiblingIndex(1)

					var_34_2.name = var_34_0
					var_34_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_31_1.actors_[var_34_0] = var_34_2

					local var_34_3 = var_34_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_31_1.isInRecall_ then
						for iter_34_0, iter_34_1 in ipairs(var_34_3) do
							iter_34_1.color = arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_34_4 = arg_31_1.actors_["1086"].transform
			local var_34_5 = 0

			if var_34_5 < arg_31_1.time_ and arg_31_1.time_ <= var_34_5 + arg_34_0 then
				arg_31_1.var_.moveOldPos1086 = var_34_4.localPosition
				var_34_4.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("1086", 3)

				local var_34_6 = var_34_4.childCount

				for iter_34_2 = 0, var_34_6 - 1 do
					local var_34_7 = var_34_4:GetChild(iter_34_2)

					if var_34_7.name == "split_1" or not string.find(var_34_7.name, "split") then
						var_34_7.gameObject:SetActive(true)
					else
						var_34_7.gameObject:SetActive(false)
					end
				end
			end

			local var_34_8 = 0.001

			if var_34_5 <= arg_31_1.time_ and arg_31_1.time_ < var_34_5 + var_34_8 then
				local var_34_9 = (arg_31_1.time_ - var_34_5) / var_34_8
				local var_34_10 = Vector3.New(0, -404.2, -237.9)

				var_34_4.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1086, var_34_10, var_34_9)
			end

			if arg_31_1.time_ >= var_34_5 + var_34_8 and arg_31_1.time_ < var_34_5 + var_34_8 + arg_34_0 then
				var_34_4.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_34_11 = arg_31_1.actors_["1086"]
			local var_34_12 = 0

			if var_34_12 < arg_31_1.time_ and arg_31_1.time_ <= var_34_12 + arg_34_0 and not isNil(var_34_11) and arg_31_1.var_.actorSpriteComps1086 == nil then
				arg_31_1.var_.actorSpriteComps1086 = var_34_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_13 = 0.125

			if var_34_12 <= arg_31_1.time_ and arg_31_1.time_ < var_34_12 + var_34_13 and not isNil(var_34_11) then
				local var_34_14 = (arg_31_1.time_ - var_34_12) / var_34_13

				if arg_31_1.var_.actorSpriteComps1086 then
					for iter_34_3, iter_34_4 in pairs(arg_31_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_34_4 then
							if arg_31_1.isInRecall_ then
								local var_34_15 = Mathf.Lerp(iter_34_4.color.r, arg_31_1.hightColor1.r, var_34_14)
								local var_34_16 = Mathf.Lerp(iter_34_4.color.g, arg_31_1.hightColor1.g, var_34_14)
								local var_34_17 = Mathf.Lerp(iter_34_4.color.b, arg_31_1.hightColor1.b, var_34_14)

								iter_34_4.color = Color.New(var_34_15, var_34_16, var_34_17)
							else
								local var_34_18 = Mathf.Lerp(iter_34_4.color.r, 1, var_34_14)

								iter_34_4.color = Color.New(var_34_18, var_34_18, var_34_18)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= var_34_12 + var_34_13 and arg_31_1.time_ < var_34_12 + var_34_13 + arg_34_0 and not isNil(var_34_11) and arg_31_1.var_.actorSpriteComps1086 then
				for iter_34_5, iter_34_6 in pairs(arg_31_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_34_6 then
						if arg_31_1.isInRecall_ then
							iter_34_6.color = arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_34_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_31_1.var_.actorSpriteComps1086 = nil
			end

			local var_34_19 = 0
			local var_34_20 = 0.725

			if var_34_19 < arg_31_1.time_ and arg_31_1.time_ <= var_34_19 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_21 = arg_31_1:FormatText(StoryNameCfg[36].name)

				arg_31_1.leftNameTxt_.text = var_34_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_22 = arg_31_1:GetWordFromCfg(416011007)
				local var_34_23 = arg_31_1:FormatText(var_34_22.content)

				arg_31_1.text_.text = var_34_23

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_24 = 29
				local var_34_25 = utf8.len(var_34_23)
				local var_34_26 = var_34_24 <= 0 and var_34_20 or var_34_20 * (var_34_25 / var_34_24)

				if var_34_26 > 0 and var_34_20 < var_34_26 then
					arg_31_1.talkMaxDuration = var_34_26

					if var_34_26 + var_34_19 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_26 + var_34_19
					end
				end

				arg_31_1.text_.text = var_34_23
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011007", "story_v_out_416011.awb") ~= 0 then
					local var_34_27 = manager.audio:GetVoiceLength("story_v_out_416011", "416011007", "story_v_out_416011.awb") / 1000

					if var_34_27 + var_34_19 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_27 + var_34_19
					end

					if var_34_22.prefab_name ~= "" and arg_31_1.actors_[var_34_22.prefab_name] ~= nil then
						local var_34_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_22.prefab_name].transform, "story_v_out_416011", "416011007", "story_v_out_416011.awb")

						arg_31_1:RecordAudio("416011007", var_34_28)
						arg_31_1:RecordAudio("416011007", var_34_28)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_416011", "416011007", "story_v_out_416011.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_416011", "416011007", "story_v_out_416011.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_29 = math.max(var_34_20, arg_31_1.talkMaxDuration)

			if var_34_19 <= arg_31_1.time_ and arg_31_1.time_ < var_34_19 + var_34_29 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_19) / var_34_29

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_19 + var_34_29 and arg_31_1.time_ < var_34_19 + var_34_29 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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
	Play416011008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 416011008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play416011009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1086"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.actorSpriteComps1086 == nil then
				arg_35_1.var_.actorSpriteComps1086 = var_38_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_2 = 0.125

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.actorSpriteComps1086 then
					for iter_38_0, iter_38_1 in pairs(arg_35_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.actorSpriteComps1086 then
				for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_38_3 then
						if arg_35_1.isInRecall_ then
							iter_38_3.color = arg_35_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_38_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_35_1.var_.actorSpriteComps1086 = nil
			end

			local var_38_8 = 0
			local var_38_9 = 1.75

			if var_38_8 < arg_35_1.time_ and arg_35_1.time_ <= var_38_8 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_10 = arg_35_1:GetWordFromCfg(416011008)
				local var_38_11 = arg_35_1:FormatText(var_38_10.content)

				arg_35_1.text_.text = var_38_11

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_12 = 70
				local var_38_13 = utf8.len(var_38_11)
				local var_38_14 = var_38_12 <= 0 and var_38_9 or var_38_9 * (var_38_13 / var_38_12)

				if var_38_14 > 0 and var_38_9 < var_38_14 then
					arg_35_1.talkMaxDuration = var_38_14

					if var_38_14 + var_38_8 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_14 + var_38_8
					end
				end

				arg_35_1.text_.text = var_38_11
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_15 = math.max(var_38_9, arg_35_1.talkMaxDuration)

			if var_38_8 <= arg_35_1.time_ and arg_35_1.time_ < var_38_8 + var_38_15 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_8) / var_38_15

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_8 + var_38_15 and arg_35_1.time_ < var_38_8 + var_38_15 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play416011009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 416011009
		arg_39_1.duration_ = 8.83

		local var_39_0 = {
			zh = 5.8,
			ja = 8.833
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
				arg_39_0:Play416011010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1086"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.actorSpriteComps1086 == nil then
				arg_39_1.var_.actorSpriteComps1086 = var_42_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_2 = 0.125

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.actorSpriteComps1086 then
					for iter_42_0, iter_42_1 in pairs(arg_39_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_42_1 then
							if arg_39_1.isInRecall_ then
								local var_42_4 = Mathf.Lerp(iter_42_1.color.r, arg_39_1.hightColor1.r, var_42_3)
								local var_42_5 = Mathf.Lerp(iter_42_1.color.g, arg_39_1.hightColor1.g, var_42_3)
								local var_42_6 = Mathf.Lerp(iter_42_1.color.b, arg_39_1.hightColor1.b, var_42_3)

								iter_42_1.color = Color.New(var_42_4, var_42_5, var_42_6)
							else
								local var_42_7 = Mathf.Lerp(iter_42_1.color.r, 1, var_42_3)

								iter_42_1.color = Color.New(var_42_7, var_42_7, var_42_7)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.actorSpriteComps1086 then
				for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_42_3 then
						if arg_39_1.isInRecall_ then
							iter_42_3.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_42_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps1086 = nil
			end

			local var_42_8 = arg_39_1.actors_["1086"].transform
			local var_42_9 = 0

			if var_42_9 < arg_39_1.time_ and arg_39_1.time_ <= var_42_9 + arg_42_0 then
				arg_39_1.var_.moveOldPos1086 = var_42_8.localPosition
				var_42_8.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("1086", 3)

				local var_42_10 = var_42_8.childCount

				for iter_42_4 = 0, var_42_10 - 1 do
					local var_42_11 = var_42_8:GetChild(iter_42_4)

					if var_42_11.name == "split_2" or not string.find(var_42_11.name, "split") then
						var_42_11.gameObject:SetActive(true)
					else
						var_42_11.gameObject:SetActive(false)
					end
				end
			end

			local var_42_12 = 0.001

			if var_42_9 <= arg_39_1.time_ and arg_39_1.time_ < var_42_9 + var_42_12 then
				local var_42_13 = (arg_39_1.time_ - var_42_9) / var_42_12
				local var_42_14 = Vector3.New(0, -404.2, -237.9)

				var_42_8.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1086, var_42_14, var_42_13)
			end

			if arg_39_1.time_ >= var_42_9 + var_42_12 and arg_39_1.time_ < var_42_9 + var_42_12 + arg_42_0 then
				var_42_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_42_15 = 0
			local var_42_16 = 0.65

			if var_42_15 < arg_39_1.time_ and arg_39_1.time_ <= var_42_15 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_17 = arg_39_1:FormatText(StoryNameCfg[36].name)

				arg_39_1.leftNameTxt_.text = var_42_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_18 = arg_39_1:GetWordFromCfg(416011009)
				local var_42_19 = arg_39_1:FormatText(var_42_18.content)

				arg_39_1.text_.text = var_42_19

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_20 = 26
				local var_42_21 = utf8.len(var_42_19)
				local var_42_22 = var_42_20 <= 0 and var_42_16 or var_42_16 * (var_42_21 / var_42_20)

				if var_42_22 > 0 and var_42_16 < var_42_22 then
					arg_39_1.talkMaxDuration = var_42_22

					if var_42_22 + var_42_15 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_22 + var_42_15
					end
				end

				arg_39_1.text_.text = var_42_19
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011009", "story_v_out_416011.awb") ~= 0 then
					local var_42_23 = manager.audio:GetVoiceLength("story_v_out_416011", "416011009", "story_v_out_416011.awb") / 1000

					if var_42_23 + var_42_15 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_23 + var_42_15
					end

					if var_42_18.prefab_name ~= "" and arg_39_1.actors_[var_42_18.prefab_name] ~= nil then
						local var_42_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_18.prefab_name].transform, "story_v_out_416011", "416011009", "story_v_out_416011.awb")

						arg_39_1:RecordAudio("416011009", var_42_24)
						arg_39_1:RecordAudio("416011009", var_42_24)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_416011", "416011009", "story_v_out_416011.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_416011", "416011009", "story_v_out_416011.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_25 = math.max(var_42_16, arg_39_1.talkMaxDuration)

			if var_42_15 <= arg_39_1.time_ and arg_39_1.time_ < var_42_15 + var_42_25 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_15) / var_42_25

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_15 + var_42_25 and arg_39_1.time_ < var_42_15 + var_42_25 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play416011010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 416011010
		arg_43_1.duration_ = 2.37

		local var_43_0 = {
			zh = 1.1,
			ja = 2.366
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
				arg_43_0:Play416011011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = "10120"

			if arg_43_1.actors_[var_46_0] == nil then
				local var_46_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10120")

				if not isNil(var_46_1) then
					local var_46_2 = Object.Instantiate(var_46_1, arg_43_1.canvasGo_.transform)

					var_46_2.transform:SetSiblingIndex(1)

					var_46_2.name = var_46_0
					var_46_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_43_1.actors_[var_46_0] = var_46_2

					local var_46_3 = var_46_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_43_1.isInRecall_ then
						for iter_46_0, iter_46_1 in ipairs(var_46_3) do
							iter_46_1.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_46_4 = arg_43_1.actors_["10120"].transform
			local var_46_5 = 0

			if var_46_5 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 then
				arg_43_1.var_.moveOldPos10120 = var_46_4.localPosition
				var_46_4.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10120", 4)

				local var_46_6 = var_46_4.childCount

				for iter_46_2 = 0, var_46_6 - 1 do
					local var_46_7 = var_46_4:GetChild(iter_46_2)

					if var_46_7.name == "" or not string.find(var_46_7.name, "split") then
						var_46_7.gameObject:SetActive(true)
					else
						var_46_7.gameObject:SetActive(false)
					end
				end
			end

			local var_46_8 = 0.001

			if var_46_5 <= arg_43_1.time_ and arg_43_1.time_ < var_46_5 + var_46_8 then
				local var_46_9 = (arg_43_1.time_ - var_46_5) / var_46_8
				local var_46_10 = Vector3.New(390, -260.5, -275)

				var_46_4.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10120, var_46_10, var_46_9)
			end

			if arg_43_1.time_ >= var_46_5 + var_46_8 and arg_43_1.time_ < var_46_5 + var_46_8 + arg_46_0 then
				var_46_4.localPosition = Vector3.New(390, -260.5, -275)
			end

			local var_46_11 = arg_43_1.actors_["10120"]
			local var_46_12 = 0

			if var_46_12 < arg_43_1.time_ and arg_43_1.time_ <= var_46_12 + arg_46_0 and not isNil(var_46_11) and arg_43_1.var_.actorSpriteComps10120 == nil then
				arg_43_1.var_.actorSpriteComps10120 = var_46_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_13 = 0.125

			if var_46_12 <= arg_43_1.time_ and arg_43_1.time_ < var_46_12 + var_46_13 and not isNil(var_46_11) then
				local var_46_14 = (arg_43_1.time_ - var_46_12) / var_46_13

				if arg_43_1.var_.actorSpriteComps10120 then
					for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_46_4 then
							if arg_43_1.isInRecall_ then
								local var_46_15 = Mathf.Lerp(iter_46_4.color.r, arg_43_1.hightColor1.r, var_46_14)
								local var_46_16 = Mathf.Lerp(iter_46_4.color.g, arg_43_1.hightColor1.g, var_46_14)
								local var_46_17 = Mathf.Lerp(iter_46_4.color.b, arg_43_1.hightColor1.b, var_46_14)

								iter_46_4.color = Color.New(var_46_15, var_46_16, var_46_17)
							else
								local var_46_18 = Mathf.Lerp(iter_46_4.color.r, 1, var_46_14)

								iter_46_4.color = Color.New(var_46_18, var_46_18, var_46_18)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_12 + var_46_13 and arg_43_1.time_ < var_46_12 + var_46_13 + arg_46_0 and not isNil(var_46_11) and arg_43_1.var_.actorSpriteComps10120 then
				for iter_46_5, iter_46_6 in pairs(arg_43_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_46_6 then
						if arg_43_1.isInRecall_ then
							iter_46_6.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_46_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps10120 = nil
			end

			local var_46_19 = arg_43_1.actors_["1086"].transform
			local var_46_20 = 0

			if var_46_20 < arg_43_1.time_ and arg_43_1.time_ <= var_46_20 + arg_46_0 then
				arg_43_1.var_.moveOldPos1086 = var_46_19.localPosition
				var_46_19.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("1086", 2)

				local var_46_21 = var_46_19.childCount

				for iter_46_7 = 0, var_46_21 - 1 do
					local var_46_22 = var_46_19:GetChild(iter_46_7)

					if var_46_22.name == "split_2" or not string.find(var_46_22.name, "split") then
						var_46_22.gameObject:SetActive(true)
					else
						var_46_22.gameObject:SetActive(false)
					end
				end
			end

			local var_46_23 = 0.001

			if var_46_20 <= arg_43_1.time_ and arg_43_1.time_ < var_46_20 + var_46_23 then
				local var_46_24 = (arg_43_1.time_ - var_46_20) / var_46_23
				local var_46_25 = Vector3.New(-390, -404.2, -237.9)

				var_46_19.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1086, var_46_25, var_46_24)
			end

			if arg_43_1.time_ >= var_46_20 + var_46_23 and arg_43_1.time_ < var_46_20 + var_46_23 + arg_46_0 then
				var_46_19.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_46_26 = arg_43_1.actors_["1086"]
			local var_46_27 = 0

			if var_46_27 < arg_43_1.time_ and arg_43_1.time_ <= var_46_27 + arg_46_0 and not isNil(var_46_26) and arg_43_1.var_.actorSpriteComps1086 == nil then
				arg_43_1.var_.actorSpriteComps1086 = var_46_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_28 = 0.125

			if var_46_27 <= arg_43_1.time_ and arg_43_1.time_ < var_46_27 + var_46_28 and not isNil(var_46_26) then
				local var_46_29 = (arg_43_1.time_ - var_46_27) / var_46_28

				if arg_43_1.var_.actorSpriteComps1086 then
					for iter_46_8, iter_46_9 in pairs(arg_43_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_46_9 then
							if arg_43_1.isInRecall_ then
								local var_46_30 = Mathf.Lerp(iter_46_9.color.r, arg_43_1.hightColor2.r, var_46_29)
								local var_46_31 = Mathf.Lerp(iter_46_9.color.g, arg_43_1.hightColor2.g, var_46_29)
								local var_46_32 = Mathf.Lerp(iter_46_9.color.b, arg_43_1.hightColor2.b, var_46_29)

								iter_46_9.color = Color.New(var_46_30, var_46_31, var_46_32)
							else
								local var_46_33 = Mathf.Lerp(iter_46_9.color.r, 0.5, var_46_29)

								iter_46_9.color = Color.New(var_46_33, var_46_33, var_46_33)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_27 + var_46_28 and arg_43_1.time_ < var_46_27 + var_46_28 + arg_46_0 and not isNil(var_46_26) and arg_43_1.var_.actorSpriteComps1086 then
				for iter_46_10, iter_46_11 in pairs(arg_43_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_46_11 then
						if arg_43_1.isInRecall_ then
							iter_46_11.color = arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_46_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps1086 = nil
			end

			local var_46_34 = 0
			local var_46_35 = 0.125

			if var_46_34 < arg_43_1.time_ and arg_43_1.time_ <= var_46_34 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_36 = arg_43_1:FormatText(StoryNameCfg[646].name)

				arg_43_1.leftNameTxt_.text = var_46_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_37 = arg_43_1:GetWordFromCfg(416011010)
				local var_46_38 = arg_43_1:FormatText(var_46_37.content)

				arg_43_1.text_.text = var_46_38

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_39 = 5
				local var_46_40 = utf8.len(var_46_38)
				local var_46_41 = var_46_39 <= 0 and var_46_35 or var_46_35 * (var_46_40 / var_46_39)

				if var_46_41 > 0 and var_46_35 < var_46_41 then
					arg_43_1.talkMaxDuration = var_46_41

					if var_46_41 + var_46_34 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_41 + var_46_34
					end
				end

				arg_43_1.text_.text = var_46_38
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011010", "story_v_out_416011.awb") ~= 0 then
					local var_46_42 = manager.audio:GetVoiceLength("story_v_out_416011", "416011010", "story_v_out_416011.awb") / 1000

					if var_46_42 + var_46_34 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_42 + var_46_34
					end

					if var_46_37.prefab_name ~= "" and arg_43_1.actors_[var_46_37.prefab_name] ~= nil then
						local var_46_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_37.prefab_name].transform, "story_v_out_416011", "416011010", "story_v_out_416011.awb")

						arg_43_1:RecordAudio("416011010", var_46_43)
						arg_43_1:RecordAudio("416011010", var_46_43)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_416011", "416011010", "story_v_out_416011.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_416011", "416011010", "story_v_out_416011.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_44 = math.max(var_46_35, arg_43_1.talkMaxDuration)

			if var_46_34 <= arg_43_1.time_ and arg_43_1.time_ < var_46_34 + var_46_44 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_34) / var_46_44

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_34 + var_46_44 and arg_43_1.time_ < var_46_34 + var_46_44 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10120",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play416011011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 416011011
		arg_47_1.duration_ = 3.73

		local var_47_0 = {
			zh = 2.466,
			ja = 3.733
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play416011012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10120"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.actorSpriteComps10120 == nil then
				arg_47_1.var_.actorSpriteComps10120 = var_50_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_2 = 0.125

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.actorSpriteComps10120 then
					for iter_50_0, iter_50_1 in pairs(arg_47_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_50_1 then
							if arg_47_1.isInRecall_ then
								local var_50_4 = Mathf.Lerp(iter_50_1.color.r, arg_47_1.hightColor2.r, var_50_3)
								local var_50_5 = Mathf.Lerp(iter_50_1.color.g, arg_47_1.hightColor2.g, var_50_3)
								local var_50_6 = Mathf.Lerp(iter_50_1.color.b, arg_47_1.hightColor2.b, var_50_3)

								iter_50_1.color = Color.New(var_50_4, var_50_5, var_50_6)
							else
								local var_50_7 = Mathf.Lerp(iter_50_1.color.r, 0.5, var_50_3)

								iter_50_1.color = Color.New(var_50_7, var_50_7, var_50_7)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.actorSpriteComps10120 then
				for iter_50_2, iter_50_3 in pairs(arg_47_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_50_3 then
						if arg_47_1.isInRecall_ then
							iter_50_3.color = arg_47_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_50_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps10120 = nil
			end

			local var_50_8 = arg_47_1.actors_["1086"]
			local var_50_9 = 0

			if var_50_9 < arg_47_1.time_ and arg_47_1.time_ <= var_50_9 + arg_50_0 and not isNil(var_50_8) and arg_47_1.var_.actorSpriteComps1086 == nil then
				arg_47_1.var_.actorSpriteComps1086 = var_50_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_10 = 0.125

			if var_50_9 <= arg_47_1.time_ and arg_47_1.time_ < var_50_9 + var_50_10 and not isNil(var_50_8) then
				local var_50_11 = (arg_47_1.time_ - var_50_9) / var_50_10

				if arg_47_1.var_.actorSpriteComps1086 then
					for iter_50_4, iter_50_5 in pairs(arg_47_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_50_5 then
							if arg_47_1.isInRecall_ then
								local var_50_12 = Mathf.Lerp(iter_50_5.color.r, arg_47_1.hightColor1.r, var_50_11)
								local var_50_13 = Mathf.Lerp(iter_50_5.color.g, arg_47_1.hightColor1.g, var_50_11)
								local var_50_14 = Mathf.Lerp(iter_50_5.color.b, arg_47_1.hightColor1.b, var_50_11)

								iter_50_5.color = Color.New(var_50_12, var_50_13, var_50_14)
							else
								local var_50_15 = Mathf.Lerp(iter_50_5.color.r, 1, var_50_11)

								iter_50_5.color = Color.New(var_50_15, var_50_15, var_50_15)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_9 + var_50_10 and arg_47_1.time_ < var_50_9 + var_50_10 + arg_50_0 and not isNil(var_50_8) and arg_47_1.var_.actorSpriteComps1086 then
				for iter_50_6, iter_50_7 in pairs(arg_47_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_50_7 then
						if arg_47_1.isInRecall_ then
							iter_50_7.color = arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_50_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps1086 = nil
			end

			local var_50_16 = arg_47_1.actors_["1086"].transform
			local var_50_17 = 0

			if var_50_17 < arg_47_1.time_ and arg_47_1.time_ <= var_50_17 + arg_50_0 then
				arg_47_1.var_.moveOldPos1086 = var_50_16.localPosition
				var_50_16.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("1086", 2)

				local var_50_18 = var_50_16.childCount

				for iter_50_8 = 0, var_50_18 - 1 do
					local var_50_19 = var_50_16:GetChild(iter_50_8)

					if var_50_19.name == "split_1" or not string.find(var_50_19.name, "split") then
						var_50_19.gameObject:SetActive(true)
					else
						var_50_19.gameObject:SetActive(false)
					end
				end
			end

			local var_50_20 = 0.001

			if var_50_17 <= arg_47_1.time_ and arg_47_1.time_ < var_50_17 + var_50_20 then
				local var_50_21 = (arg_47_1.time_ - var_50_17) / var_50_20
				local var_50_22 = Vector3.New(-390, -404.2, -237.9)

				var_50_16.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1086, var_50_22, var_50_21)
			end

			if arg_47_1.time_ >= var_50_17 + var_50_20 and arg_47_1.time_ < var_50_17 + var_50_20 + arg_50_0 then
				var_50_16.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_50_23 = 0
			local var_50_24 = 0.25

			if var_50_23 < arg_47_1.time_ and arg_47_1.time_ <= var_50_23 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_25 = arg_47_1:FormatText(StoryNameCfg[36].name)

				arg_47_1.leftNameTxt_.text = var_50_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_26 = arg_47_1:GetWordFromCfg(416011011)
				local var_50_27 = arg_47_1:FormatText(var_50_26.content)

				arg_47_1.text_.text = var_50_27

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_28 = 10
				local var_50_29 = utf8.len(var_50_27)
				local var_50_30 = var_50_28 <= 0 and var_50_24 or var_50_24 * (var_50_29 / var_50_28)

				if var_50_30 > 0 and var_50_24 < var_50_30 then
					arg_47_1.talkMaxDuration = var_50_30

					if var_50_30 + var_50_23 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_30 + var_50_23
					end
				end

				arg_47_1.text_.text = var_50_27
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011011", "story_v_out_416011.awb") ~= 0 then
					local var_50_31 = manager.audio:GetVoiceLength("story_v_out_416011", "416011011", "story_v_out_416011.awb") / 1000

					if var_50_31 + var_50_23 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_31 + var_50_23
					end

					if var_50_26.prefab_name ~= "" and arg_47_1.actors_[var_50_26.prefab_name] ~= nil then
						local var_50_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_26.prefab_name].transform, "story_v_out_416011", "416011011", "story_v_out_416011.awb")

						arg_47_1:RecordAudio("416011011", var_50_32)
						arg_47_1:RecordAudio("416011011", var_50_32)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_416011", "416011011", "story_v_out_416011.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_416011", "416011011", "story_v_out_416011.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_33 = math.max(var_50_24, arg_47_1.talkMaxDuration)

			if var_50_23 <= arg_47_1.time_ and arg_47_1.time_ < var_50_23 + var_50_33 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_23) / var_50_33

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_23 + var_50_33 and arg_47_1.time_ < var_50_23 + var_50_33 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play416011012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 416011012
		arg_51_1.duration_ = 9.97

		local var_51_0 = {
			zh = 5.933,
			ja = 9.966
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
				arg_51_0:Play416011013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["10120"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.actorSpriteComps10120 == nil then
				arg_51_1.var_.actorSpriteComps10120 = var_54_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_2 = 0.125

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.actorSpriteComps10120 then
					for iter_54_0, iter_54_1 in pairs(arg_51_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_54_1 then
							if arg_51_1.isInRecall_ then
								local var_54_4 = Mathf.Lerp(iter_54_1.color.r, arg_51_1.hightColor1.r, var_54_3)
								local var_54_5 = Mathf.Lerp(iter_54_1.color.g, arg_51_1.hightColor1.g, var_54_3)
								local var_54_6 = Mathf.Lerp(iter_54_1.color.b, arg_51_1.hightColor1.b, var_54_3)

								iter_54_1.color = Color.New(var_54_4, var_54_5, var_54_6)
							else
								local var_54_7 = Mathf.Lerp(iter_54_1.color.r, 1, var_54_3)

								iter_54_1.color = Color.New(var_54_7, var_54_7, var_54_7)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.actorSpriteComps10120 then
				for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_54_3 then
						if arg_51_1.isInRecall_ then
							iter_54_3.color = arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_54_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps10120 = nil
			end

			local var_54_8 = arg_51_1.actors_["1086"]
			local var_54_9 = 0

			if var_54_9 < arg_51_1.time_ and arg_51_1.time_ <= var_54_9 + arg_54_0 and not isNil(var_54_8) and arg_51_1.var_.actorSpriteComps1086 == nil then
				arg_51_1.var_.actorSpriteComps1086 = var_54_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_10 = 0.125

			if var_54_9 <= arg_51_1.time_ and arg_51_1.time_ < var_54_9 + var_54_10 and not isNil(var_54_8) then
				local var_54_11 = (arg_51_1.time_ - var_54_9) / var_54_10

				if arg_51_1.var_.actorSpriteComps1086 then
					for iter_54_4, iter_54_5 in pairs(arg_51_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_54_5 then
							if arg_51_1.isInRecall_ then
								local var_54_12 = Mathf.Lerp(iter_54_5.color.r, arg_51_1.hightColor2.r, var_54_11)
								local var_54_13 = Mathf.Lerp(iter_54_5.color.g, arg_51_1.hightColor2.g, var_54_11)
								local var_54_14 = Mathf.Lerp(iter_54_5.color.b, arg_51_1.hightColor2.b, var_54_11)

								iter_54_5.color = Color.New(var_54_12, var_54_13, var_54_14)
							else
								local var_54_15 = Mathf.Lerp(iter_54_5.color.r, 0.5, var_54_11)

								iter_54_5.color = Color.New(var_54_15, var_54_15, var_54_15)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_9 + var_54_10 and arg_51_1.time_ < var_54_9 + var_54_10 + arg_54_0 and not isNil(var_54_8) and arg_51_1.var_.actorSpriteComps1086 then
				for iter_54_6, iter_54_7 in pairs(arg_51_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_54_7 then
						if arg_51_1.isInRecall_ then
							iter_54_7.color = arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_54_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps1086 = nil
			end

			local var_54_16 = 0
			local var_54_17 = 0.9

			if var_54_16 < arg_51_1.time_ and arg_51_1.time_ <= var_54_16 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_18 = arg_51_1:FormatText(StoryNameCfg[646].name)

				arg_51_1.leftNameTxt_.text = var_54_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_19 = arg_51_1:GetWordFromCfg(416011012)
				local var_54_20 = arg_51_1:FormatText(var_54_19.content)

				arg_51_1.text_.text = var_54_20

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_21 = 36
				local var_54_22 = utf8.len(var_54_20)
				local var_54_23 = var_54_21 <= 0 and var_54_17 or var_54_17 * (var_54_22 / var_54_21)

				if var_54_23 > 0 and var_54_17 < var_54_23 then
					arg_51_1.talkMaxDuration = var_54_23

					if var_54_23 + var_54_16 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_23 + var_54_16
					end
				end

				arg_51_1.text_.text = var_54_20
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011012", "story_v_out_416011.awb") ~= 0 then
					local var_54_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011012", "story_v_out_416011.awb") / 1000

					if var_54_24 + var_54_16 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_24 + var_54_16
					end

					if var_54_19.prefab_name ~= "" and arg_51_1.actors_[var_54_19.prefab_name] ~= nil then
						local var_54_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_19.prefab_name].transform, "story_v_out_416011", "416011012", "story_v_out_416011.awb")

						arg_51_1:RecordAudio("416011012", var_54_25)
						arg_51_1:RecordAudio("416011012", var_54_25)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_416011", "416011012", "story_v_out_416011.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_416011", "416011012", "story_v_out_416011.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_26 = math.max(var_54_17, arg_51_1.talkMaxDuration)

			if var_54_16 <= arg_51_1.time_ and arg_51_1.time_ < var_54_16 + var_54_26 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_16) / var_54_26

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_16 + var_54_26 and arg_51_1.time_ < var_54_16 + var_54_26 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play416011013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 416011013
		arg_55_1.duration_ = 10.1

		local var_55_0 = {
			zh = 6.566,
			ja = 10.1
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
				arg_55_0:Play416011014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.9

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[646].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_3 = arg_55_1:GetWordFromCfg(416011013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 36
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011013", "story_v_out_416011.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011013", "story_v_out_416011.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_416011", "416011013", "story_v_out_416011.awb")

						arg_55_1:RecordAudio("416011013", var_58_9)
						arg_55_1:RecordAudio("416011013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_416011", "416011013", "story_v_out_416011.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_416011", "416011013", "story_v_out_416011.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_10 and arg_55_1.time_ < var_58_0 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play416011014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 416011014
		arg_59_1.duration_ = 13.37

		local var_59_0 = {
			zh = 8.666,
			ja = 13.366
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
				arg_59_0:Play416011015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1086"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.actorSpriteComps1086 == nil then
				arg_59_1.var_.actorSpriteComps1086 = var_62_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_2 = 0.125

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.actorSpriteComps1086 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_62_1 then
							if arg_59_1.isInRecall_ then
								local var_62_4 = Mathf.Lerp(iter_62_1.color.r, arg_59_1.hightColor1.r, var_62_3)
								local var_62_5 = Mathf.Lerp(iter_62_1.color.g, arg_59_1.hightColor1.g, var_62_3)
								local var_62_6 = Mathf.Lerp(iter_62_1.color.b, arg_59_1.hightColor1.b, var_62_3)

								iter_62_1.color = Color.New(var_62_4, var_62_5, var_62_6)
							else
								local var_62_7 = Mathf.Lerp(iter_62_1.color.r, 1, var_62_3)

								iter_62_1.color = Color.New(var_62_7, var_62_7, var_62_7)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.actorSpriteComps1086 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_62_3 then
						if arg_59_1.isInRecall_ then
							iter_62_3.color = arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_62_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_59_1.var_.actorSpriteComps1086 = nil
			end

			local var_62_8 = arg_59_1.actors_["10120"]
			local var_62_9 = 0

			if var_62_9 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 and not isNil(var_62_8) and arg_59_1.var_.actorSpriteComps10120 == nil then
				arg_59_1.var_.actorSpriteComps10120 = var_62_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_10 = 0.125

			if var_62_9 <= arg_59_1.time_ and arg_59_1.time_ < var_62_9 + var_62_10 and not isNil(var_62_8) then
				local var_62_11 = (arg_59_1.time_ - var_62_9) / var_62_10

				if arg_59_1.var_.actorSpriteComps10120 then
					for iter_62_4, iter_62_5 in pairs(arg_59_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_62_5 then
							if arg_59_1.isInRecall_ then
								local var_62_12 = Mathf.Lerp(iter_62_5.color.r, arg_59_1.hightColor2.r, var_62_11)
								local var_62_13 = Mathf.Lerp(iter_62_5.color.g, arg_59_1.hightColor2.g, var_62_11)
								local var_62_14 = Mathf.Lerp(iter_62_5.color.b, arg_59_1.hightColor2.b, var_62_11)

								iter_62_5.color = Color.New(var_62_12, var_62_13, var_62_14)
							else
								local var_62_15 = Mathf.Lerp(iter_62_5.color.r, 0.5, var_62_11)

								iter_62_5.color = Color.New(var_62_15, var_62_15, var_62_15)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_9 + var_62_10 and arg_59_1.time_ < var_62_9 + var_62_10 + arg_62_0 and not isNil(var_62_8) and arg_59_1.var_.actorSpriteComps10120 then
				for iter_62_6, iter_62_7 in pairs(arg_59_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_62_7 then
						if arg_59_1.isInRecall_ then
							iter_62_7.color = arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_62_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_59_1.var_.actorSpriteComps10120 = nil
			end

			local var_62_16 = arg_59_1.actors_["1086"].transform
			local var_62_17 = 0

			if var_62_17 < arg_59_1.time_ and arg_59_1.time_ <= var_62_17 + arg_62_0 then
				arg_59_1.var_.moveOldPos1086 = var_62_16.localPosition
				var_62_16.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("1086", 2)

				local var_62_18 = var_62_16.childCount

				for iter_62_8 = 0, var_62_18 - 1 do
					local var_62_19 = var_62_16:GetChild(iter_62_8)

					if var_62_19.name == "split_1" or not string.find(var_62_19.name, "split") then
						var_62_19.gameObject:SetActive(true)
					else
						var_62_19.gameObject:SetActive(false)
					end
				end
			end

			local var_62_20 = 0.001

			if var_62_17 <= arg_59_1.time_ and arg_59_1.time_ < var_62_17 + var_62_20 then
				local var_62_21 = (arg_59_1.time_ - var_62_17) / var_62_20
				local var_62_22 = Vector3.New(-390, -404.2, -237.9)

				var_62_16.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1086, var_62_22, var_62_21)
			end

			if arg_59_1.time_ >= var_62_17 + var_62_20 and arg_59_1.time_ < var_62_17 + var_62_20 + arg_62_0 then
				var_62_16.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_62_23 = 0
			local var_62_24 = 1.05

			if var_62_23 < arg_59_1.time_ and arg_59_1.time_ <= var_62_23 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_25 = arg_59_1:FormatText(StoryNameCfg[1080].name)

				arg_59_1.leftNameTxt_.text = var_62_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_26 = arg_59_1:GetWordFromCfg(416011014)
				local var_62_27 = arg_59_1:FormatText(var_62_26.content)

				arg_59_1.text_.text = var_62_27

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_28 = 42
				local var_62_29 = utf8.len(var_62_27)
				local var_62_30 = var_62_28 <= 0 and var_62_24 or var_62_24 * (var_62_29 / var_62_28)

				if var_62_30 > 0 and var_62_24 < var_62_30 then
					arg_59_1.talkMaxDuration = var_62_30

					if var_62_30 + var_62_23 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_30 + var_62_23
					end
				end

				arg_59_1.text_.text = var_62_27
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011014", "story_v_out_416011.awb") ~= 0 then
					local var_62_31 = manager.audio:GetVoiceLength("story_v_out_416011", "416011014", "story_v_out_416011.awb") / 1000

					if var_62_31 + var_62_23 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_31 + var_62_23
					end

					if var_62_26.prefab_name ~= "" and arg_59_1.actors_[var_62_26.prefab_name] ~= nil then
						local var_62_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_26.prefab_name].transform, "story_v_out_416011", "416011014", "story_v_out_416011.awb")

						arg_59_1:RecordAudio("416011014", var_62_32)
						arg_59_1:RecordAudio("416011014", var_62_32)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_416011", "416011014", "story_v_out_416011.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_416011", "416011014", "story_v_out_416011.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_33 = math.max(var_62_24, arg_59_1.talkMaxDuration)

			if var_62_23 <= arg_59_1.time_ and arg_59_1.time_ < var_62_23 + var_62_33 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_23) / var_62_33

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_23 + var_62_33 and arg_59_1.time_ < var_62_23 + var_62_33 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play416011015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 416011015
		arg_63_1.duration_ = 4.87

		local var_63_0 = {
			zh = 3.3,
			ja = 4.866
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
				arg_63_0:Play416011016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["10120"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.actorSpriteComps10120 == nil then
				arg_63_1.var_.actorSpriteComps10120 = var_66_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_2 = 0.125

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.actorSpriteComps10120 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								local var_66_4 = Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor1.r, var_66_3)
								local var_66_5 = Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor1.g, var_66_3)
								local var_66_6 = Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor1.b, var_66_3)

								iter_66_1.color = Color.New(var_66_4, var_66_5, var_66_6)
							else
								local var_66_7 = Mathf.Lerp(iter_66_1.color.r, 1, var_66_3)

								iter_66_1.color = Color.New(var_66_7, var_66_7, var_66_7)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.actorSpriteComps10120 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_66_3 then
						if arg_63_1.isInRecall_ then
							iter_66_3.color = arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_66_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps10120 = nil
			end

			local var_66_8 = arg_63_1.actors_["1086"]
			local var_66_9 = 0

			if var_66_9 < arg_63_1.time_ and arg_63_1.time_ <= var_66_9 + arg_66_0 and not isNil(var_66_8) and arg_63_1.var_.actorSpriteComps1086 == nil then
				arg_63_1.var_.actorSpriteComps1086 = var_66_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_10 = 0.125

			if var_66_9 <= arg_63_1.time_ and arg_63_1.time_ < var_66_9 + var_66_10 and not isNil(var_66_8) then
				local var_66_11 = (arg_63_1.time_ - var_66_9) / var_66_10

				if arg_63_1.var_.actorSpriteComps1086 then
					for iter_66_4, iter_66_5 in pairs(arg_63_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_66_5 then
							if arg_63_1.isInRecall_ then
								local var_66_12 = Mathf.Lerp(iter_66_5.color.r, arg_63_1.hightColor2.r, var_66_11)
								local var_66_13 = Mathf.Lerp(iter_66_5.color.g, arg_63_1.hightColor2.g, var_66_11)
								local var_66_14 = Mathf.Lerp(iter_66_5.color.b, arg_63_1.hightColor2.b, var_66_11)

								iter_66_5.color = Color.New(var_66_12, var_66_13, var_66_14)
							else
								local var_66_15 = Mathf.Lerp(iter_66_5.color.r, 0.5, var_66_11)

								iter_66_5.color = Color.New(var_66_15, var_66_15, var_66_15)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_9 + var_66_10 and arg_63_1.time_ < var_66_9 + var_66_10 + arg_66_0 and not isNil(var_66_8) and arg_63_1.var_.actorSpriteComps1086 then
				for iter_66_6, iter_66_7 in pairs(arg_63_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_66_7 then
						if arg_63_1.isInRecall_ then
							iter_66_7.color = arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_66_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps1086 = nil
			end

			local var_66_16 = 0
			local var_66_17 = 0.475

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_18 = arg_63_1:FormatText(StoryNameCfg[646].name)

				arg_63_1.leftNameTxt_.text = var_66_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_19 = arg_63_1:GetWordFromCfg(416011015)
				local var_66_20 = arg_63_1:FormatText(var_66_19.content)

				arg_63_1.text_.text = var_66_20

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_21 = 19
				local var_66_22 = utf8.len(var_66_20)
				local var_66_23 = var_66_21 <= 0 and var_66_17 or var_66_17 * (var_66_22 / var_66_21)

				if var_66_23 > 0 and var_66_17 < var_66_23 then
					arg_63_1.talkMaxDuration = var_66_23

					if var_66_23 + var_66_16 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_23 + var_66_16
					end
				end

				arg_63_1.text_.text = var_66_20
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011015", "story_v_out_416011.awb") ~= 0 then
					local var_66_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011015", "story_v_out_416011.awb") / 1000

					if var_66_24 + var_66_16 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_24 + var_66_16
					end

					if var_66_19.prefab_name ~= "" and arg_63_1.actors_[var_66_19.prefab_name] ~= nil then
						local var_66_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_19.prefab_name].transform, "story_v_out_416011", "416011015", "story_v_out_416011.awb")

						arg_63_1:RecordAudio("416011015", var_66_25)
						arg_63_1:RecordAudio("416011015", var_66_25)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_416011", "416011015", "story_v_out_416011.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_416011", "416011015", "story_v_out_416011.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_26 = math.max(var_66_17, arg_63_1.talkMaxDuration)

			if var_66_16 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_26 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_16) / var_66_26

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_16 + var_66_26 and arg_63_1.time_ < var_66_16 + var_66_26 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play416011016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 416011016
		arg_67_1.duration_ = 10

		local var_67_0 = {
			zh = 4.6,
			ja = 10
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
				arg_67_0:Play416011017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["10120"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.actorSpriteComps10120 == nil then
				arg_67_1.var_.actorSpriteComps10120 = var_70_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_2 = 0.125

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.actorSpriteComps10120 then
					for iter_70_0, iter_70_1 in pairs(arg_67_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_70_1 then
							if arg_67_1.isInRecall_ then
								local var_70_4 = Mathf.Lerp(iter_70_1.color.r, arg_67_1.hightColor2.r, var_70_3)
								local var_70_5 = Mathf.Lerp(iter_70_1.color.g, arg_67_1.hightColor2.g, var_70_3)
								local var_70_6 = Mathf.Lerp(iter_70_1.color.b, arg_67_1.hightColor2.b, var_70_3)

								iter_70_1.color = Color.New(var_70_4, var_70_5, var_70_6)
							else
								local var_70_7 = Mathf.Lerp(iter_70_1.color.r, 0.5, var_70_3)

								iter_70_1.color = Color.New(var_70_7, var_70_7, var_70_7)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.actorSpriteComps10120 then
				for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_70_3 then
						if arg_67_1.isInRecall_ then
							iter_70_3.color = arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_70_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_67_1.var_.actorSpriteComps10120 = nil
			end

			local var_70_8 = arg_67_1.actors_["1086"]
			local var_70_9 = 0

			if var_70_9 < arg_67_1.time_ and arg_67_1.time_ <= var_70_9 + arg_70_0 and not isNil(var_70_8) and arg_67_1.var_.actorSpriteComps1086 == nil then
				arg_67_1.var_.actorSpriteComps1086 = var_70_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_10 = 0.125

			if var_70_9 <= arg_67_1.time_ and arg_67_1.time_ < var_70_9 + var_70_10 and not isNil(var_70_8) then
				local var_70_11 = (arg_67_1.time_ - var_70_9) / var_70_10

				if arg_67_1.var_.actorSpriteComps1086 then
					for iter_70_4, iter_70_5 in pairs(arg_67_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_70_5 then
							if arg_67_1.isInRecall_ then
								local var_70_12 = Mathf.Lerp(iter_70_5.color.r, arg_67_1.hightColor1.r, var_70_11)
								local var_70_13 = Mathf.Lerp(iter_70_5.color.g, arg_67_1.hightColor1.g, var_70_11)
								local var_70_14 = Mathf.Lerp(iter_70_5.color.b, arg_67_1.hightColor1.b, var_70_11)

								iter_70_5.color = Color.New(var_70_12, var_70_13, var_70_14)
							else
								local var_70_15 = Mathf.Lerp(iter_70_5.color.r, 1, var_70_11)

								iter_70_5.color = Color.New(var_70_15, var_70_15, var_70_15)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= var_70_9 + var_70_10 and arg_67_1.time_ < var_70_9 + var_70_10 + arg_70_0 and not isNil(var_70_8) and arg_67_1.var_.actorSpriteComps1086 then
				for iter_70_6, iter_70_7 in pairs(arg_67_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_70_7 then
						if arg_67_1.isInRecall_ then
							iter_70_7.color = arg_67_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_70_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_67_1.var_.actorSpriteComps1086 = nil
			end

			local var_70_16 = arg_67_1.actors_["1086"].transform
			local var_70_17 = 0

			if var_70_17 < arg_67_1.time_ and arg_67_1.time_ <= var_70_17 + arg_70_0 then
				arg_67_1.var_.moveOldPos1086 = var_70_16.localPosition
				var_70_16.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("1086", 2)

				local var_70_18 = var_70_16.childCount

				for iter_70_8 = 0, var_70_18 - 1 do
					local var_70_19 = var_70_16:GetChild(iter_70_8)

					if var_70_19.name == "split_2" or not string.find(var_70_19.name, "split") then
						var_70_19.gameObject:SetActive(true)
					else
						var_70_19.gameObject:SetActive(false)
					end
				end
			end

			local var_70_20 = 0.001

			if var_70_17 <= arg_67_1.time_ and arg_67_1.time_ < var_70_17 + var_70_20 then
				local var_70_21 = (arg_67_1.time_ - var_70_17) / var_70_20
				local var_70_22 = Vector3.New(-390, -404.2, -237.9)

				var_70_16.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1086, var_70_22, var_70_21)
			end

			if arg_67_1.time_ >= var_70_17 + var_70_20 and arg_67_1.time_ < var_70_17 + var_70_20 + arg_70_0 then
				var_70_16.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_70_23 = 0
			local var_70_24 = 0.55

			if var_70_23 < arg_67_1.time_ and arg_67_1.time_ <= var_70_23 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_25 = arg_67_1:FormatText(StoryNameCfg[1080].name)

				arg_67_1.leftNameTxt_.text = var_70_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_26 = arg_67_1:GetWordFromCfg(416011016)
				local var_70_27 = arg_67_1:FormatText(var_70_26.content)

				arg_67_1.text_.text = var_70_27

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_28 = 22
				local var_70_29 = utf8.len(var_70_27)
				local var_70_30 = var_70_28 <= 0 and var_70_24 or var_70_24 * (var_70_29 / var_70_28)

				if var_70_30 > 0 and var_70_24 < var_70_30 then
					arg_67_1.talkMaxDuration = var_70_30

					if var_70_30 + var_70_23 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_30 + var_70_23
					end
				end

				arg_67_1.text_.text = var_70_27
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011016", "story_v_out_416011.awb") ~= 0 then
					local var_70_31 = manager.audio:GetVoiceLength("story_v_out_416011", "416011016", "story_v_out_416011.awb") / 1000

					if var_70_31 + var_70_23 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_31 + var_70_23
					end

					if var_70_26.prefab_name ~= "" and arg_67_1.actors_[var_70_26.prefab_name] ~= nil then
						local var_70_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_26.prefab_name].transform, "story_v_out_416011", "416011016", "story_v_out_416011.awb")

						arg_67_1:RecordAudio("416011016", var_70_32)
						arg_67_1:RecordAudio("416011016", var_70_32)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_416011", "416011016", "story_v_out_416011.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_416011", "416011016", "story_v_out_416011.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_33 = math.max(var_70_24, arg_67_1.talkMaxDuration)

			if var_70_23 <= arg_67_1.time_ and arg_67_1.time_ < var_70_23 + var_70_33 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_23) / var_70_33

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_23 + var_70_33 and arg_67_1.time_ < var_70_23 + var_70_33 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play416011017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 416011017
		arg_71_1.duration_ = 7.8

		local var_71_0 = {
			zh = 4.366,
			ja = 7.8
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
				arg_71_0:Play416011018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1086"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.actorSpriteComps1086 == nil then
				arg_71_1.var_.actorSpriteComps1086 = var_74_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_2 = 0.125

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.actorSpriteComps1086 then
					for iter_74_0, iter_74_1 in pairs(arg_71_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_74_1 then
							if arg_71_1.isInRecall_ then
								local var_74_4 = Mathf.Lerp(iter_74_1.color.r, arg_71_1.hightColor2.r, var_74_3)
								local var_74_5 = Mathf.Lerp(iter_74_1.color.g, arg_71_1.hightColor2.g, var_74_3)
								local var_74_6 = Mathf.Lerp(iter_74_1.color.b, arg_71_1.hightColor2.b, var_74_3)

								iter_74_1.color = Color.New(var_74_4, var_74_5, var_74_6)
							else
								local var_74_7 = Mathf.Lerp(iter_74_1.color.r, 0.5, var_74_3)

								iter_74_1.color = Color.New(var_74_7, var_74_7, var_74_7)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.actorSpriteComps1086 then
				for iter_74_2, iter_74_3 in pairs(arg_71_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_74_3 then
						if arg_71_1.isInRecall_ then
							iter_74_3.color = arg_71_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_74_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_71_1.var_.actorSpriteComps1086 = nil
			end

			local var_74_8 = arg_71_1.actors_["10120"]
			local var_74_9 = 0

			if var_74_9 < arg_71_1.time_ and arg_71_1.time_ <= var_74_9 + arg_74_0 and not isNil(var_74_8) and arg_71_1.var_.actorSpriteComps10120 == nil then
				arg_71_1.var_.actorSpriteComps10120 = var_74_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_10 = 0.125

			if var_74_9 <= arg_71_1.time_ and arg_71_1.time_ < var_74_9 + var_74_10 and not isNil(var_74_8) then
				local var_74_11 = (arg_71_1.time_ - var_74_9) / var_74_10

				if arg_71_1.var_.actorSpriteComps10120 then
					for iter_74_4, iter_74_5 in pairs(arg_71_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_74_5 then
							if arg_71_1.isInRecall_ then
								local var_74_12 = Mathf.Lerp(iter_74_5.color.r, arg_71_1.hightColor1.r, var_74_11)
								local var_74_13 = Mathf.Lerp(iter_74_5.color.g, arg_71_1.hightColor1.g, var_74_11)
								local var_74_14 = Mathf.Lerp(iter_74_5.color.b, arg_71_1.hightColor1.b, var_74_11)

								iter_74_5.color = Color.New(var_74_12, var_74_13, var_74_14)
							else
								local var_74_15 = Mathf.Lerp(iter_74_5.color.r, 1, var_74_11)

								iter_74_5.color = Color.New(var_74_15, var_74_15, var_74_15)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= var_74_9 + var_74_10 and arg_71_1.time_ < var_74_9 + var_74_10 + arg_74_0 and not isNil(var_74_8) and arg_71_1.var_.actorSpriteComps10120 then
				for iter_74_6, iter_74_7 in pairs(arg_71_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_74_7 then
						if arg_71_1.isInRecall_ then
							iter_74_7.color = arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_74_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_71_1.var_.actorSpriteComps10120 = nil
			end

			local var_74_16 = 0
			local var_74_17 = 0.55

			if var_74_16 < arg_71_1.time_ and arg_71_1.time_ <= var_74_16 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_18 = arg_71_1:FormatText(StoryNameCfg[646].name)

				arg_71_1.leftNameTxt_.text = var_74_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_19 = arg_71_1:GetWordFromCfg(416011017)
				local var_74_20 = arg_71_1:FormatText(var_74_19.content)

				arg_71_1.text_.text = var_74_20

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_21 = 22
				local var_74_22 = utf8.len(var_74_20)
				local var_74_23 = var_74_21 <= 0 and var_74_17 or var_74_17 * (var_74_22 / var_74_21)

				if var_74_23 > 0 and var_74_17 < var_74_23 then
					arg_71_1.talkMaxDuration = var_74_23

					if var_74_23 + var_74_16 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_23 + var_74_16
					end
				end

				arg_71_1.text_.text = var_74_20
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011017", "story_v_out_416011.awb") ~= 0 then
					local var_74_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011017", "story_v_out_416011.awb") / 1000

					if var_74_24 + var_74_16 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_24 + var_74_16
					end

					if var_74_19.prefab_name ~= "" and arg_71_1.actors_[var_74_19.prefab_name] ~= nil then
						local var_74_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_19.prefab_name].transform, "story_v_out_416011", "416011017", "story_v_out_416011.awb")

						arg_71_1:RecordAudio("416011017", var_74_25)
						arg_71_1:RecordAudio("416011017", var_74_25)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_416011", "416011017", "story_v_out_416011.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_416011", "416011017", "story_v_out_416011.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_26 = math.max(var_74_17, arg_71_1.talkMaxDuration)

			if var_74_16 <= arg_71_1.time_ and arg_71_1.time_ < var_74_16 + var_74_26 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_16) / var_74_26

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_16 + var_74_26 and arg_71_1.time_ < var_74_16 + var_74_26 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play416011018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 416011018
		arg_75_1.duration_ = 5.77

		local var_75_0 = {
			zh = 5.766,
			ja = 4.4
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
				arg_75_0:Play416011019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["10120"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.actorSpriteComps10120 == nil then
				arg_75_1.var_.actorSpriteComps10120 = var_78_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_2 = 0.125

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.actorSpriteComps10120 then
					for iter_78_0, iter_78_1 in pairs(arg_75_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_78_1 then
							if arg_75_1.isInRecall_ then
								local var_78_4 = Mathf.Lerp(iter_78_1.color.r, arg_75_1.hightColor2.r, var_78_3)
								local var_78_5 = Mathf.Lerp(iter_78_1.color.g, arg_75_1.hightColor2.g, var_78_3)
								local var_78_6 = Mathf.Lerp(iter_78_1.color.b, arg_75_1.hightColor2.b, var_78_3)

								iter_78_1.color = Color.New(var_78_4, var_78_5, var_78_6)
							else
								local var_78_7 = Mathf.Lerp(iter_78_1.color.r, 0.5, var_78_3)

								iter_78_1.color = Color.New(var_78_7, var_78_7, var_78_7)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.actorSpriteComps10120 then
				for iter_78_2, iter_78_3 in pairs(arg_75_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_78_3 then
						if arg_75_1.isInRecall_ then
							iter_78_3.color = arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_78_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_75_1.var_.actorSpriteComps10120 = nil
			end

			local var_78_8 = arg_75_1.actors_["1086"]
			local var_78_9 = 0

			if var_78_9 < arg_75_1.time_ and arg_75_1.time_ <= var_78_9 + arg_78_0 and not isNil(var_78_8) and arg_75_1.var_.actorSpriteComps1086 == nil then
				arg_75_1.var_.actorSpriteComps1086 = var_78_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_10 = 0.125

			if var_78_9 <= arg_75_1.time_ and arg_75_1.time_ < var_78_9 + var_78_10 and not isNil(var_78_8) then
				local var_78_11 = (arg_75_1.time_ - var_78_9) / var_78_10

				if arg_75_1.var_.actorSpriteComps1086 then
					for iter_78_4, iter_78_5 in pairs(arg_75_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_78_5 then
							if arg_75_1.isInRecall_ then
								local var_78_12 = Mathf.Lerp(iter_78_5.color.r, arg_75_1.hightColor1.r, var_78_11)
								local var_78_13 = Mathf.Lerp(iter_78_5.color.g, arg_75_1.hightColor1.g, var_78_11)
								local var_78_14 = Mathf.Lerp(iter_78_5.color.b, arg_75_1.hightColor1.b, var_78_11)

								iter_78_5.color = Color.New(var_78_12, var_78_13, var_78_14)
							else
								local var_78_15 = Mathf.Lerp(iter_78_5.color.r, 1, var_78_11)

								iter_78_5.color = Color.New(var_78_15, var_78_15, var_78_15)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= var_78_9 + var_78_10 and arg_75_1.time_ < var_78_9 + var_78_10 + arg_78_0 and not isNil(var_78_8) and arg_75_1.var_.actorSpriteComps1086 then
				for iter_78_6, iter_78_7 in pairs(arg_75_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_78_7 then
						if arg_75_1.isInRecall_ then
							iter_78_7.color = arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_78_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_75_1.var_.actorSpriteComps1086 = nil
			end

			local var_78_16 = 0
			local var_78_17 = 0.6

			if var_78_16 < arg_75_1.time_ and arg_75_1.time_ <= var_78_16 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_18 = arg_75_1:FormatText(StoryNameCfg[1080].name)

				arg_75_1.leftNameTxt_.text = var_78_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_19 = arg_75_1:GetWordFromCfg(416011018)
				local var_78_20 = arg_75_1:FormatText(var_78_19.content)

				arg_75_1.text_.text = var_78_20

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_21 = 24
				local var_78_22 = utf8.len(var_78_20)
				local var_78_23 = var_78_21 <= 0 and var_78_17 or var_78_17 * (var_78_22 / var_78_21)

				if var_78_23 > 0 and var_78_17 < var_78_23 then
					arg_75_1.talkMaxDuration = var_78_23

					if var_78_23 + var_78_16 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_23 + var_78_16
					end
				end

				arg_75_1.text_.text = var_78_20
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011018", "story_v_out_416011.awb") ~= 0 then
					local var_78_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011018", "story_v_out_416011.awb") / 1000

					if var_78_24 + var_78_16 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_24 + var_78_16
					end

					if var_78_19.prefab_name ~= "" and arg_75_1.actors_[var_78_19.prefab_name] ~= nil then
						local var_78_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_19.prefab_name].transform, "story_v_out_416011", "416011018", "story_v_out_416011.awb")

						arg_75_1:RecordAudio("416011018", var_78_25)
						arg_75_1:RecordAudio("416011018", var_78_25)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_416011", "416011018", "story_v_out_416011.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_416011", "416011018", "story_v_out_416011.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_26 = math.max(var_78_17, arg_75_1.talkMaxDuration)

			if var_78_16 <= arg_75_1.time_ and arg_75_1.time_ < var_78_16 + var_78_26 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_16) / var_78_26

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_16 + var_78_26 and arg_75_1.time_ < var_78_16 + var_78_26 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play416011019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 416011019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play416011020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10120"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos10120 = var_82_0.localPosition
				var_82_0.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10120", 7)

				local var_82_2 = var_82_0.childCount

				for iter_82_0 = 0, var_82_2 - 1 do
					local var_82_3 = var_82_0:GetChild(iter_82_0)

					if var_82_3.name == "" or not string.find(var_82_3.name, "split") then
						var_82_3.gameObject:SetActive(true)
					else
						var_82_3.gameObject:SetActive(false)
					end
				end
			end

			local var_82_4 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_4 then
				local var_82_5 = (arg_79_1.time_ - var_82_1) / var_82_4
				local var_82_6 = Vector3.New(0, -2000, 0)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10120, var_82_6, var_82_5)
			end

			if arg_79_1.time_ >= var_82_1 + var_82_4 and arg_79_1.time_ < var_82_1 + var_82_4 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_7 = arg_79_1.actors_["1086"].transform
			local var_82_8 = 0

			if var_82_8 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.var_.moveOldPos1086 = var_82_7.localPosition
				var_82_7.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("1086", 7)

				local var_82_9 = var_82_7.childCount

				for iter_82_1 = 0, var_82_9 - 1 do
					local var_82_10 = var_82_7:GetChild(iter_82_1)

					if var_82_10.name == "" or not string.find(var_82_10.name, "split") then
						var_82_10.gameObject:SetActive(true)
					else
						var_82_10.gameObject:SetActive(false)
					end
				end
			end

			local var_82_11 = 0.001

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_11 then
				local var_82_12 = (arg_79_1.time_ - var_82_8) / var_82_11
				local var_82_13 = Vector3.New(0, -2000, 0)

				var_82_7.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1086, var_82_13, var_82_12)
			end

			if arg_79_1.time_ >= var_82_8 + var_82_11 and arg_79_1.time_ < var_82_8 + var_82_11 + arg_82_0 then
				var_82_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_14 = 0
			local var_82_15 = 1.55

			if var_82_14 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_16 = arg_79_1:GetWordFromCfg(416011019)
				local var_82_17 = arg_79_1:FormatText(var_82_16.content)

				arg_79_1.text_.text = var_82_17

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_18 = 62
				local var_82_19 = utf8.len(var_82_17)
				local var_82_20 = var_82_18 <= 0 and var_82_15 or var_82_15 * (var_82_19 / var_82_18)

				if var_82_20 > 0 and var_82_15 < var_82_20 then
					arg_79_1.talkMaxDuration = var_82_20

					if var_82_20 + var_82_14 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_20 + var_82_14
					end
				end

				arg_79_1.text_.text = var_82_17
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_21 = math.max(var_82_15, arg_79_1.talkMaxDuration)

			if var_82_14 <= arg_79_1.time_ and arg_79_1.time_ < var_82_14 + var_82_21 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_14) / var_82_21

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_14 + var_82_21 and arg_79_1.time_ < var_82_14 + var_82_21 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10120",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
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
	Play416011020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 416011020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play416011021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 1

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				local var_86_2 = "stop"
				local var_86_3 = "effect"

				arg_83_1:AudioAction(var_86_2, var_86_3, "se_story_8", "se_story_8_water02_loop", "")
			end

			local var_86_4 = 0
			local var_86_5 = 1.85

			if var_86_4 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_6 = arg_83_1:GetWordFromCfg(416011020)
				local var_86_7 = arg_83_1:FormatText(var_86_6.content)

				arg_83_1.text_.text = var_86_7

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_8 = 74
				local var_86_9 = utf8.len(var_86_7)
				local var_86_10 = var_86_8 <= 0 and var_86_5 or var_86_5 * (var_86_9 / var_86_8)

				if var_86_10 > 0 and var_86_5 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10

					if var_86_10 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_7
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_11 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_11 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_4) / var_86_11

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_4 + var_86_11 and arg_83_1.time_ < var_86_4 + var_86_11 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play416011021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 416011021
		arg_87_1.duration_ = 7.03

		local var_87_0 = {
			zh = 6.533,
			ja = 7.033
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
				arg_87_0:Play416011022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1086"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1086 = var_90_0.localPosition
				var_90_0.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("1086", 3)

				local var_90_2 = var_90_0.childCount

				for iter_90_0 = 0, var_90_2 - 1 do
					local var_90_3 = var_90_0:GetChild(iter_90_0)

					if var_90_3.name == "split_1" or not string.find(var_90_3.name, "split") then
						var_90_3.gameObject:SetActive(true)
					else
						var_90_3.gameObject:SetActive(false)
					end
				end
			end

			local var_90_4 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_4 then
				local var_90_5 = (arg_87_1.time_ - var_90_1) / var_90_4
				local var_90_6 = Vector3.New(0, -404.2, -237.9)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1086, var_90_6, var_90_5)
			end

			if arg_87_1.time_ >= var_90_1 + var_90_4 and arg_87_1.time_ < var_90_1 + var_90_4 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_90_7 = arg_87_1.actors_["1086"]
			local var_90_8 = 0

			if var_90_8 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 and not isNil(var_90_7) and arg_87_1.var_.actorSpriteComps1086 == nil then
				arg_87_1.var_.actorSpriteComps1086 = var_90_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_9 = 0.125

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_9 and not isNil(var_90_7) then
				local var_90_10 = (arg_87_1.time_ - var_90_8) / var_90_9

				if arg_87_1.var_.actorSpriteComps1086 then
					for iter_90_1, iter_90_2 in pairs(arg_87_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_90_2 then
							if arg_87_1.isInRecall_ then
								local var_90_11 = Mathf.Lerp(iter_90_2.color.r, arg_87_1.hightColor1.r, var_90_10)
								local var_90_12 = Mathf.Lerp(iter_90_2.color.g, arg_87_1.hightColor1.g, var_90_10)
								local var_90_13 = Mathf.Lerp(iter_90_2.color.b, arg_87_1.hightColor1.b, var_90_10)

								iter_90_2.color = Color.New(var_90_11, var_90_12, var_90_13)
							else
								local var_90_14 = Mathf.Lerp(iter_90_2.color.r, 1, var_90_10)

								iter_90_2.color = Color.New(var_90_14, var_90_14, var_90_14)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_8 + var_90_9 and arg_87_1.time_ < var_90_8 + var_90_9 + arg_90_0 and not isNil(var_90_7) and arg_87_1.var_.actorSpriteComps1086 then
				for iter_90_3, iter_90_4 in pairs(arg_87_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_90_4 then
						if arg_87_1.isInRecall_ then
							iter_90_4.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_90_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps1086 = nil
			end

			local var_90_15 = 0
			local var_90_16 = 0.5

			if var_90_15 < arg_87_1.time_ and arg_87_1.time_ <= var_90_15 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_17 = arg_87_1:FormatText(StoryNameCfg[1080].name)

				arg_87_1.leftNameTxt_.text = var_90_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_18 = arg_87_1:GetWordFromCfg(416011021)
				local var_90_19 = arg_87_1:FormatText(var_90_18.content)

				arg_87_1.text_.text = var_90_19

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_20 = 20
				local var_90_21 = utf8.len(var_90_19)
				local var_90_22 = var_90_20 <= 0 and var_90_16 or var_90_16 * (var_90_21 / var_90_20)

				if var_90_22 > 0 and var_90_16 < var_90_22 then
					arg_87_1.talkMaxDuration = var_90_22

					if var_90_22 + var_90_15 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_22 + var_90_15
					end
				end

				arg_87_1.text_.text = var_90_19
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011021", "story_v_out_416011.awb") ~= 0 then
					local var_90_23 = manager.audio:GetVoiceLength("story_v_out_416011", "416011021", "story_v_out_416011.awb") / 1000

					if var_90_23 + var_90_15 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_23 + var_90_15
					end

					if var_90_18.prefab_name ~= "" and arg_87_1.actors_[var_90_18.prefab_name] ~= nil then
						local var_90_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_18.prefab_name].transform, "story_v_out_416011", "416011021", "story_v_out_416011.awb")

						arg_87_1:RecordAudio("416011021", var_90_24)
						arg_87_1:RecordAudio("416011021", var_90_24)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_416011", "416011021", "story_v_out_416011.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_416011", "416011021", "story_v_out_416011.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_25 = math.max(var_90_16, arg_87_1.talkMaxDuration)

			if var_90_15 <= arg_87_1.time_ and arg_87_1.time_ < var_90_15 + var_90_25 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_15) / var_90_25

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_15 + var_90_25 and arg_87_1.time_ < var_90_15 + var_90_25 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play416011022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 416011022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play416011023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1086"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1086 = var_94_0.localPosition
				var_94_0.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("1086", 7)

				local var_94_2 = var_94_0.childCount

				for iter_94_0 = 0, var_94_2 - 1 do
					local var_94_3 = var_94_0:GetChild(iter_94_0)

					if var_94_3.name == "" or not string.find(var_94_3.name, "split") then
						var_94_3.gameObject:SetActive(true)
					else
						var_94_3.gameObject:SetActive(false)
					end
				end
			end

			local var_94_4 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_4 then
				local var_94_5 = (arg_91_1.time_ - var_94_1) / var_94_4
				local var_94_6 = Vector3.New(0, -2000, 0)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1086, var_94_6, var_94_5)
			end

			if arg_91_1.time_ >= var_94_1 + var_94_4 and arg_91_1.time_ < var_94_1 + var_94_4 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_94_7 = 0
			local var_94_8 = 1.625

			if var_94_7 < arg_91_1.time_ and arg_91_1.time_ <= var_94_7 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_9 = arg_91_1:GetWordFromCfg(416011022)
				local var_94_10 = arg_91_1:FormatText(var_94_9.content)

				arg_91_1.text_.text = var_94_10

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_11 = 65
				local var_94_12 = utf8.len(var_94_10)
				local var_94_13 = var_94_11 <= 0 and var_94_8 or var_94_8 * (var_94_12 / var_94_11)

				if var_94_13 > 0 and var_94_8 < var_94_13 then
					arg_91_1.talkMaxDuration = var_94_13

					if var_94_13 + var_94_7 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_13 + var_94_7
					end
				end

				arg_91_1.text_.text = var_94_10
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_14 = math.max(var_94_8, arg_91_1.talkMaxDuration)

			if var_94_7 <= arg_91_1.time_ and arg_91_1.time_ < var_94_7 + var_94_14 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_7) / var_94_14

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_7 + var_94_14 and arg_91_1.time_ < var_94_7 + var_94_14 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play416011023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 416011023
		arg_95_1.duration_ = 2.73

		local var_95_0 = {
			zh = 2.233,
			ja = 2.733
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
				arg_95_0:Play416011024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10120"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos10120 = var_98_0.localPosition
				var_98_0.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10120", 3)

				local var_98_2 = var_98_0.childCount

				for iter_98_0 = 0, var_98_2 - 1 do
					local var_98_3 = var_98_0:GetChild(iter_98_0)

					if var_98_3.name == "" or not string.find(var_98_3.name, "split") then
						var_98_3.gameObject:SetActive(true)
					else
						var_98_3.gameObject:SetActive(false)
					end
				end
			end

			local var_98_4 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_4 then
				local var_98_5 = (arg_95_1.time_ - var_98_1) / var_98_4
				local var_98_6 = Vector3.New(0, -260.5, -275)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10120, var_98_6, var_98_5)
			end

			if arg_95_1.time_ >= var_98_1 + var_98_4 and arg_95_1.time_ < var_98_1 + var_98_4 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, -260.5, -275)
			end

			local var_98_7 = arg_95_1.actors_["10120"]
			local var_98_8 = 0

			if var_98_8 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 and not isNil(var_98_7) and arg_95_1.var_.actorSpriteComps10120 == nil then
				arg_95_1.var_.actorSpriteComps10120 = var_98_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_9 = 0.125

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_9 and not isNil(var_98_7) then
				local var_98_10 = (arg_95_1.time_ - var_98_8) / var_98_9

				if arg_95_1.var_.actorSpriteComps10120 then
					for iter_98_1, iter_98_2 in pairs(arg_95_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_98_2 then
							if arg_95_1.isInRecall_ then
								local var_98_11 = Mathf.Lerp(iter_98_2.color.r, arg_95_1.hightColor1.r, var_98_10)
								local var_98_12 = Mathf.Lerp(iter_98_2.color.g, arg_95_1.hightColor1.g, var_98_10)
								local var_98_13 = Mathf.Lerp(iter_98_2.color.b, arg_95_1.hightColor1.b, var_98_10)

								iter_98_2.color = Color.New(var_98_11, var_98_12, var_98_13)
							else
								local var_98_14 = Mathf.Lerp(iter_98_2.color.r, 1, var_98_10)

								iter_98_2.color = Color.New(var_98_14, var_98_14, var_98_14)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= var_98_8 + var_98_9 and arg_95_1.time_ < var_98_8 + var_98_9 + arg_98_0 and not isNil(var_98_7) and arg_95_1.var_.actorSpriteComps10120 then
				for iter_98_3, iter_98_4 in pairs(arg_95_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_98_4 then
						if arg_95_1.isInRecall_ then
							iter_98_4.color = arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_98_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_95_1.var_.actorSpriteComps10120 = nil
			end

			local var_98_15 = 1.13333333333333
			local var_98_16 = 0.2

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				local var_98_17 = "play"
				local var_98_18 = "effect"

				arg_95_1:AudioAction(var_98_17, var_98_18, "se_story_15", "se_story_15_gun02", "")
			end

			local var_98_19 = 0
			local var_98_20 = 0.175

			if var_98_19 < arg_95_1.time_ and arg_95_1.time_ <= var_98_19 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_21 = arg_95_1:FormatText(StoryNameCfg[646].name)

				arg_95_1.leftNameTxt_.text = var_98_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_22 = arg_95_1:GetWordFromCfg(416011023)
				local var_98_23 = arg_95_1:FormatText(var_98_22.content)

				arg_95_1.text_.text = var_98_23

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_24 = 7
				local var_98_25 = utf8.len(var_98_23)
				local var_98_26 = var_98_24 <= 0 and var_98_20 or var_98_20 * (var_98_25 / var_98_24)

				if var_98_26 > 0 and var_98_20 < var_98_26 then
					arg_95_1.talkMaxDuration = var_98_26

					if var_98_26 + var_98_19 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_26 + var_98_19
					end
				end

				arg_95_1.text_.text = var_98_23
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011023", "story_v_out_416011.awb") ~= 0 then
					local var_98_27 = manager.audio:GetVoiceLength("story_v_out_416011", "416011023", "story_v_out_416011.awb") / 1000

					if var_98_27 + var_98_19 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_27 + var_98_19
					end

					if var_98_22.prefab_name ~= "" and arg_95_1.actors_[var_98_22.prefab_name] ~= nil then
						local var_98_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_22.prefab_name].transform, "story_v_out_416011", "416011023", "story_v_out_416011.awb")

						arg_95_1:RecordAudio("416011023", var_98_28)
						arg_95_1:RecordAudio("416011023", var_98_28)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_416011", "416011023", "story_v_out_416011.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_416011", "416011023", "story_v_out_416011.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_29 = math.max(var_98_20, arg_95_1.talkMaxDuration)

			if var_98_19 <= arg_95_1.time_ and arg_95_1.time_ < var_98_19 + var_98_29 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_19) / var_98_29

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_19 + var_98_29 and arg_95_1.time_ < var_98_19 + var_98_29 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10120",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play416011024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 416011024
		arg_99_1.duration_ = 7.88

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play416011025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = "ST10"

			if arg_99_1.bgs_[var_102_0] == nil then
				local var_102_1 = Object.Instantiate(arg_99_1.paintGo_)

				var_102_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_102_0)
				var_102_1.name = var_102_0
				var_102_1.transform.parent = arg_99_1.stage_.transform
				var_102_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.bgs_[var_102_0] = var_102_1
			end

			local var_102_2 = 0.967333333333332

			if var_102_2 < arg_99_1.time_ and arg_99_1.time_ <= var_102_2 + arg_102_0 then
				local var_102_3 = manager.ui.mainCamera.transform.localPosition
				local var_102_4 = Vector3.New(0, 0, 10) + Vector3.New(var_102_3.x, var_102_3.y, 0)
				local var_102_5 = arg_99_1.bgs_.ST10

				var_102_5.transform.localPosition = var_102_4
				var_102_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_6 = var_102_5:GetComponent("SpriteRenderer")

				if var_102_6 and var_102_6.sprite then
					local var_102_7 = (var_102_5.transform.localPosition - var_102_3).z
					local var_102_8 = manager.ui.mainCameraCom_
					local var_102_9 = 2 * var_102_7 * Mathf.Tan(var_102_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_102_10 = var_102_9 * var_102_8.aspect
					local var_102_11 = var_102_6.sprite.bounds.size.x
					local var_102_12 = var_102_6.sprite.bounds.size.y
					local var_102_13 = var_102_10 / var_102_11
					local var_102_14 = var_102_9 / var_102_12
					local var_102_15 = var_102_14 < var_102_13 and var_102_13 or var_102_14

					var_102_5.transform.localScale = Vector3.New(var_102_15, var_102_15, 0)
				end

				for iter_102_0, iter_102_1 in pairs(arg_99_1.bgs_) do
					if iter_102_0 ~= "ST10" then
						iter_102_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_102_16 = 0

			if var_102_16 < arg_99_1.time_ and arg_99_1.time_ <= var_102_16 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_17 = 0.967333333333333

			if var_102_16 <= arg_99_1.time_ and arg_99_1.time_ < var_102_16 + var_102_17 then
				local var_102_18 = (arg_99_1.time_ - var_102_16) / var_102_17
				local var_102_19 = Color.New(0, 0, 0)

				var_102_19.a = Mathf.Lerp(0, 1, var_102_18)
				arg_99_1.mask_.color = var_102_19
			end

			if arg_99_1.time_ >= var_102_16 + var_102_17 and arg_99_1.time_ < var_102_16 + var_102_17 + arg_102_0 then
				local var_102_20 = Color.New(0, 0, 0)

				var_102_20.a = 1
				arg_99_1.mask_.color = var_102_20
			end

			local var_102_21 = 0.967333333333332

			if var_102_21 < arg_99_1.time_ and arg_99_1.time_ <= var_102_21 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_22 = 1.91666666666667

			if var_102_21 <= arg_99_1.time_ and arg_99_1.time_ < var_102_21 + var_102_22 then
				local var_102_23 = (arg_99_1.time_ - var_102_21) / var_102_22
				local var_102_24 = Color.New(0, 0, 0)

				var_102_24.a = Mathf.Lerp(1, 0, var_102_23)
				arg_99_1.mask_.color = var_102_24
			end

			if arg_99_1.time_ >= var_102_21 + var_102_22 and arg_99_1.time_ < var_102_21 + var_102_22 + arg_102_0 then
				local var_102_25 = Color.New(0, 0, 0)
				local var_102_26 = 0

				arg_99_1.mask_.enabled = false
				var_102_25.a = var_102_26
				arg_99_1.mask_.color = var_102_25
			end

			local var_102_27 = arg_99_1.actors_["10120"].transform
			local var_102_28 = 0.933333333333333

			if var_102_28 < arg_99_1.time_ and arg_99_1.time_ <= var_102_28 + arg_102_0 then
				arg_99_1.var_.moveOldPos10120 = var_102_27.localPosition
				var_102_27.localScale = Vector3.New(1, 1, 1)

				local var_102_29 = var_102_27.childCount

				for iter_102_2 = 0, var_102_29 - 1 do
					local var_102_30 = var_102_27:GetChild(iter_102_2)

					if var_102_30.name == "" or not string.find(var_102_30.name, "split") then
						var_102_30.gameObject:SetActive(true)
					else
						var_102_30.gameObject:SetActive(false)
					end
				end
			end

			local var_102_31 = 0.001

			if var_102_28 <= arg_99_1.time_ and arg_99_1.time_ < var_102_28 + var_102_31 then
				local var_102_32 = (arg_99_1.time_ - var_102_28) / var_102_31
				local var_102_33 = Vector3.New(0, -2000, 0)

				var_102_27.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10120, var_102_33, var_102_32)
			end

			if arg_99_1.time_ >= var_102_28 + var_102_31 and arg_99_1.time_ < var_102_28 + var_102_31 + arg_102_0 then
				var_102_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_102_34 = 4.36666666666667
			local var_102_35 = 0.5

			if var_102_34 < arg_99_1.time_ and arg_99_1.time_ <= var_102_34 + arg_102_0 then
				local var_102_36 = "play"
				local var_102_37 = "effect"

				arg_99_1:AudioAction(var_102_36, var_102_37, "se_story_16", "se_story_16_smash02", "")
			end

			local var_102_38 = 0
			local var_102_39 = 0.2

			if var_102_38 < arg_99_1.time_ and arg_99_1.time_ <= var_102_38 + arg_102_0 then
				local var_102_40 = "play"
				local var_102_41 = "music"

				arg_99_1:AudioAction(var_102_40, var_102_41, "ui_battle", "ui_battle_stopbgm", "")

				local var_102_42 = ""
				local var_102_43 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_102_43 ~= "" then
					if arg_99_1.bgmTxt_.text ~= var_102_43 and arg_99_1.bgmTxt_.text ~= "" then
						if arg_99_1.bgmTxt2_.text ~= "" then
							arg_99_1.bgmTxt_.text = arg_99_1.bgmTxt2_.text
						end

						arg_99_1.bgmTxt2_.text = var_102_43

						arg_99_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_99_1.bgmTxt_.text = var_102_43
						arg_99_1.bgmTxt2_.text = var_102_43
					end

					if arg_99_1.bgmTimer then
						arg_99_1.bgmTimer:Stop()

						arg_99_1.bgmTimer = nil
					end

					if arg_99_1.settingData.show_music_name == 1 then
						arg_99_1.musicController:SetSelectedState("show")
						arg_99_1.musicAnimator_:Play("open", 0, 0)

						if arg_99_1.settingData.music_time ~= 0 then
							arg_99_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_99_1.settingData.music_time), function()
								if arg_99_1 == nil or isNil(arg_99_1.bgmTxt_) then
									return
								end

								arg_99_1.musicController:SetSelectedState("hide")
								arg_99_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_102_44 = 1
			local var_102_45 = 1

			if var_102_44 < arg_99_1.time_ and arg_99_1.time_ <= var_102_44 + arg_102_0 then
				local var_102_46 = "play"
				local var_102_47 = "music"

				arg_99_1:AudioAction(var_102_46, var_102_47, "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_102_48 = ""
				local var_102_49 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if var_102_49 ~= "" then
					if arg_99_1.bgmTxt_.text ~= var_102_49 and arg_99_1.bgmTxt_.text ~= "" then
						if arg_99_1.bgmTxt2_.text ~= "" then
							arg_99_1.bgmTxt_.text = arg_99_1.bgmTxt2_.text
						end

						arg_99_1.bgmTxt2_.text = var_102_49

						arg_99_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_99_1.bgmTxt_.text = var_102_49
						arg_99_1.bgmTxt2_.text = var_102_49
					end

					if arg_99_1.bgmTimer then
						arg_99_1.bgmTimer:Stop()

						arg_99_1.bgmTimer = nil
					end

					if arg_99_1.settingData.show_music_name == 1 then
						arg_99_1.musicController:SetSelectedState("show")
						arg_99_1.musicAnimator_:Play("open", 0, 0)

						if arg_99_1.settingData.music_time ~= 0 then
							arg_99_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_99_1.settingData.music_time), function()
								if arg_99_1 == nil or isNil(arg_99_1.bgmTxt_) then
									return
								end

								arg_99_1.musicController:SetSelectedState("hide")
								arg_99_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_102_50 = 0
			local var_102_51 = 1

			if var_102_50 < arg_99_1.time_ and arg_99_1.time_ <= var_102_50 + arg_102_0 then
				local var_102_52 = "stop"
				local var_102_53 = "effect"

				arg_99_1:AudioAction(var_102_52, var_102_53, "se_story_133", "se_story_133_sea", "")
			end

			local var_102_54 = 0
			local var_102_55 = 0.4

			if var_102_54 < arg_99_1.time_ and arg_99_1.time_ <= var_102_54 + arg_102_0 then
				local var_102_56 = "stop"
				local var_102_57 = "effect"

				arg_99_1:AudioAction(var_102_56, var_102_57, "se_story_15", "se_story_15_gun02", "")
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_58 = 2.884
			local var_102_59 = 1.85

			if var_102_58 < arg_99_1.time_ and arg_99_1.time_ <= var_102_58 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_60 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_60:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_99_1.dialogCg_.alpha = arg_105_0
				end))
				var_102_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_61 = arg_99_1:GetWordFromCfg(416011024)
				local var_102_62 = arg_99_1:FormatText(var_102_61.content)

				arg_99_1.text_.text = var_102_62

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_63 = 74
				local var_102_64 = utf8.len(var_102_62)
				local var_102_65 = var_102_63 <= 0 and var_102_59 or var_102_59 * (var_102_64 / var_102_63)

				if var_102_65 > 0 and var_102_59 < var_102_65 then
					arg_99_1.talkMaxDuration = var_102_65
					var_102_58 = var_102_58 + 0.3

					if var_102_65 + var_102_58 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_65 + var_102_58
					end
				end

				arg_99_1.text_.text = var_102_62
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_66 = var_102_58 + 0.3
			local var_102_67 = math.max(var_102_59, arg_99_1.talkMaxDuration)

			if var_102_66 <= arg_99_1.time_ and arg_99_1.time_ < var_102_66 + var_102_67 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_66) / var_102_67

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_66 + var_102_67 and arg_99_1.time_ < var_102_66 + var_102_67 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10120",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.933333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play416011025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 416011025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play416011026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 1.075

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_2 = arg_107_1:GetWordFromCfg(416011025)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 43
				local var_110_5 = utf8.len(var_110_3)
				local var_110_6 = var_110_4 <= 0 and var_110_1 or var_110_1 * (var_110_5 / var_110_4)

				if var_110_6 > 0 and var_110_1 < var_110_6 then
					arg_107_1.talkMaxDuration = var_110_6

					if var_110_6 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_7 and arg_107_1.time_ < var_110_0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play416011026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 416011026
		arg_111_1.duration_ = 9.97

		local var_111_0 = {
			zh = 8.1,
			ja = 9.966
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
				arg_111_0:Play416011027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = "1033"

			if arg_111_1.actors_[var_114_0] == nil then
				local var_114_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_114_1) then
					local var_114_2 = Object.Instantiate(var_114_1, arg_111_1.canvasGo_.transform)

					var_114_2.transform:SetSiblingIndex(1)

					var_114_2.name = var_114_0
					var_114_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_111_1.actors_[var_114_0] = var_114_2

					local var_114_3 = var_114_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_111_1.isInRecall_ then
						for iter_114_0, iter_114_1 in ipairs(var_114_3) do
							iter_114_1.color = arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_114_4 = arg_111_1.actors_["1033"].transform
			local var_114_5 = 0

			if var_114_5 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1.var_.moveOldPos1033 = var_114_4.localPosition
				var_114_4.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("1033", 3)

				local var_114_6 = var_114_4.childCount

				for iter_114_2 = 0, var_114_6 - 1 do
					local var_114_7 = var_114_4:GetChild(iter_114_2)

					if var_114_7.name == "split_1" or not string.find(var_114_7.name, "split") then
						var_114_7.gameObject:SetActive(true)
					else
						var_114_7.gameObject:SetActive(false)
					end
				end
			end

			local var_114_8 = 0.001

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_8 then
				local var_114_9 = (arg_111_1.time_ - var_114_5) / var_114_8
				local var_114_10 = Vector3.New(0, -420, 0)

				var_114_4.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1033, var_114_10, var_114_9)
			end

			if arg_111_1.time_ >= var_114_5 + var_114_8 and arg_111_1.time_ < var_114_5 + var_114_8 + arg_114_0 then
				var_114_4.localPosition = Vector3.New(0, -420, 0)
			end

			local var_114_11 = arg_111_1.actors_["1033"]
			local var_114_12 = 0

			if var_114_12 < arg_111_1.time_ and arg_111_1.time_ <= var_114_12 + arg_114_0 and not isNil(var_114_11) and arg_111_1.var_.actorSpriteComps1033 == nil then
				arg_111_1.var_.actorSpriteComps1033 = var_114_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_13 = 0.125

			if var_114_12 <= arg_111_1.time_ and arg_111_1.time_ < var_114_12 + var_114_13 and not isNil(var_114_11) then
				local var_114_14 = (arg_111_1.time_ - var_114_12) / var_114_13

				if arg_111_1.var_.actorSpriteComps1033 then
					for iter_114_3, iter_114_4 in pairs(arg_111_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_114_4 then
							if arg_111_1.isInRecall_ then
								local var_114_15 = Mathf.Lerp(iter_114_4.color.r, arg_111_1.hightColor1.r, var_114_14)
								local var_114_16 = Mathf.Lerp(iter_114_4.color.g, arg_111_1.hightColor1.g, var_114_14)
								local var_114_17 = Mathf.Lerp(iter_114_4.color.b, arg_111_1.hightColor1.b, var_114_14)

								iter_114_4.color = Color.New(var_114_15, var_114_16, var_114_17)
							else
								local var_114_18 = Mathf.Lerp(iter_114_4.color.r, 1, var_114_14)

								iter_114_4.color = Color.New(var_114_18, var_114_18, var_114_18)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_12 + var_114_13 and arg_111_1.time_ < var_114_12 + var_114_13 + arg_114_0 and not isNil(var_114_11) and arg_111_1.var_.actorSpriteComps1033 then
				for iter_114_5, iter_114_6 in pairs(arg_111_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_114_6 then
						if arg_111_1.isInRecall_ then
							iter_114_6.color = arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_114_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps1033 = nil
			end

			local var_114_19 = 0
			local var_114_20 = 1.05

			if var_114_19 < arg_111_1.time_ and arg_111_1.time_ <= var_114_19 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_21 = arg_111_1:FormatText(StoryNameCfg[236].name)

				arg_111_1.leftNameTxt_.text = var_114_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_22 = arg_111_1:GetWordFromCfg(416011026)
				local var_114_23 = arg_111_1:FormatText(var_114_22.content)

				arg_111_1.text_.text = var_114_23

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_24 = 42
				local var_114_25 = utf8.len(var_114_23)
				local var_114_26 = var_114_24 <= 0 and var_114_20 or var_114_20 * (var_114_25 / var_114_24)

				if var_114_26 > 0 and var_114_20 < var_114_26 then
					arg_111_1.talkMaxDuration = var_114_26

					if var_114_26 + var_114_19 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_26 + var_114_19
					end
				end

				arg_111_1.text_.text = var_114_23
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011026", "story_v_out_416011.awb") ~= 0 then
					local var_114_27 = manager.audio:GetVoiceLength("story_v_out_416011", "416011026", "story_v_out_416011.awb") / 1000

					if var_114_27 + var_114_19 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_27 + var_114_19
					end

					if var_114_22.prefab_name ~= "" and arg_111_1.actors_[var_114_22.prefab_name] ~= nil then
						local var_114_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_22.prefab_name].transform, "story_v_out_416011", "416011026", "story_v_out_416011.awb")

						arg_111_1:RecordAudio("416011026", var_114_28)
						arg_111_1:RecordAudio("416011026", var_114_28)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_416011", "416011026", "story_v_out_416011.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_416011", "416011026", "story_v_out_416011.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_29 = math.max(var_114_20, arg_111_1.talkMaxDuration)

			if var_114_19 <= arg_111_1.time_ and arg_111_1.time_ < var_114_19 + var_114_29 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_19) / var_114_29

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_19 + var_114_29 and arg_111_1.time_ < var_114_19 + var_114_29 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play416011027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 416011027
		arg_115_1.duration_ = 4.07

		local var_115_0 = {
			zh = 4.066,
			ja = 3.533
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
				arg_115_0:Play416011028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1033"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos1033 = var_118_0.localPosition
				var_118_0.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1033", 2)

				local var_118_2 = var_118_0.childCount

				for iter_118_0 = 0, var_118_2 - 1 do
					local var_118_3 = var_118_0:GetChild(iter_118_0)

					if var_118_3.name == "" or not string.find(var_118_3.name, "split") then
						var_118_3.gameObject:SetActive(true)
					else
						var_118_3.gameObject:SetActive(false)
					end
				end
			end

			local var_118_4 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_4 then
				local var_118_5 = (arg_115_1.time_ - var_118_1) / var_118_4
				local var_118_6 = Vector3.New(-390, -420, 0)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1033, var_118_6, var_118_5)
			end

			if arg_115_1.time_ >= var_118_1 + var_118_4 and arg_115_1.time_ < var_118_1 + var_118_4 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_118_7 = arg_115_1.actors_["1033"]
			local var_118_8 = 0

			if var_118_8 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.actorSpriteComps1033 == nil then
				arg_115_1.var_.actorSpriteComps1033 = var_118_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_9 = 0.125

			if var_118_8 <= arg_115_1.time_ and arg_115_1.time_ < var_118_8 + var_118_9 and not isNil(var_118_7) then
				local var_118_10 = (arg_115_1.time_ - var_118_8) / var_118_9

				if arg_115_1.var_.actorSpriteComps1033 then
					for iter_118_1, iter_118_2 in pairs(arg_115_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_118_2 then
							if arg_115_1.isInRecall_ then
								local var_118_11 = Mathf.Lerp(iter_118_2.color.r, arg_115_1.hightColor2.r, var_118_10)
								local var_118_12 = Mathf.Lerp(iter_118_2.color.g, arg_115_1.hightColor2.g, var_118_10)
								local var_118_13 = Mathf.Lerp(iter_118_2.color.b, arg_115_1.hightColor2.b, var_118_10)

								iter_118_2.color = Color.New(var_118_11, var_118_12, var_118_13)
							else
								local var_118_14 = Mathf.Lerp(iter_118_2.color.r, 0.5, var_118_10)

								iter_118_2.color = Color.New(var_118_14, var_118_14, var_118_14)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_8 + var_118_9 and arg_115_1.time_ < var_118_8 + var_118_9 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.actorSpriteComps1033 then
				for iter_118_3, iter_118_4 in pairs(arg_115_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_118_4 then
						if arg_115_1.isInRecall_ then
							iter_118_4.color = arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_118_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps1033 = nil
			end

			local var_118_15 = "1148"

			if arg_115_1.actors_[var_118_15] == nil then
				local var_118_16 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

				if not isNil(var_118_16) then
					local var_118_17 = Object.Instantiate(var_118_16, arg_115_1.canvasGo_.transform)

					var_118_17.transform:SetSiblingIndex(1)

					var_118_17.name = var_118_15
					var_118_17.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_115_1.actors_[var_118_15] = var_118_17

					local var_118_18 = var_118_17:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_115_1.isInRecall_ then
						for iter_118_5, iter_118_6 in ipairs(var_118_18) do
							iter_118_6.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_118_19 = arg_115_1.actors_["1148"].transform
			local var_118_20 = 0

			if var_118_20 < arg_115_1.time_ and arg_115_1.time_ <= var_118_20 + arg_118_0 then
				arg_115_1.var_.moveOldPos1148 = var_118_19.localPosition
				var_118_19.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1148", 4)

				local var_118_21 = var_118_19.childCount

				for iter_118_7 = 0, var_118_21 - 1 do
					local var_118_22 = var_118_19:GetChild(iter_118_7)

					if var_118_22.name == "split_2" or not string.find(var_118_22.name, "split") then
						var_118_22.gameObject:SetActive(true)
					else
						var_118_22.gameObject:SetActive(false)
					end
				end
			end

			local var_118_23 = 0.001

			if var_118_20 <= arg_115_1.time_ and arg_115_1.time_ < var_118_20 + var_118_23 then
				local var_118_24 = (arg_115_1.time_ - var_118_20) / var_118_23
				local var_118_25 = Vector3.New(390, -429, -180)

				var_118_19.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1148, var_118_25, var_118_24)
			end

			if arg_115_1.time_ >= var_118_20 + var_118_23 and arg_115_1.time_ < var_118_20 + var_118_23 + arg_118_0 then
				var_118_19.localPosition = Vector3.New(390, -429, -180)
			end

			local var_118_26 = arg_115_1.actors_["1148"]
			local var_118_27 = 0

			if var_118_27 < arg_115_1.time_ and arg_115_1.time_ <= var_118_27 + arg_118_0 and not isNil(var_118_26) and arg_115_1.var_.actorSpriteComps1148 == nil then
				arg_115_1.var_.actorSpriteComps1148 = var_118_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_28 = 0.125

			if var_118_27 <= arg_115_1.time_ and arg_115_1.time_ < var_118_27 + var_118_28 and not isNil(var_118_26) then
				local var_118_29 = (arg_115_1.time_ - var_118_27) / var_118_28

				if arg_115_1.var_.actorSpriteComps1148 then
					for iter_118_8, iter_118_9 in pairs(arg_115_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_118_9 then
							if arg_115_1.isInRecall_ then
								local var_118_30 = Mathf.Lerp(iter_118_9.color.r, arg_115_1.hightColor1.r, var_118_29)
								local var_118_31 = Mathf.Lerp(iter_118_9.color.g, arg_115_1.hightColor1.g, var_118_29)
								local var_118_32 = Mathf.Lerp(iter_118_9.color.b, arg_115_1.hightColor1.b, var_118_29)

								iter_118_9.color = Color.New(var_118_30, var_118_31, var_118_32)
							else
								local var_118_33 = Mathf.Lerp(iter_118_9.color.r, 1, var_118_29)

								iter_118_9.color = Color.New(var_118_33, var_118_33, var_118_33)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_27 + var_118_28 and arg_115_1.time_ < var_118_27 + var_118_28 + arg_118_0 and not isNil(var_118_26) and arg_115_1.var_.actorSpriteComps1148 then
				for iter_118_10, iter_118_11 in pairs(arg_115_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_118_11 then
						if arg_115_1.isInRecall_ then
							iter_118_11.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps1148 = nil
			end

			local var_118_34 = 0
			local var_118_35 = 0.45

			if var_118_34 < arg_115_1.time_ and arg_115_1.time_ <= var_118_34 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_36 = arg_115_1:FormatText(StoryNameCfg[8].name)

				arg_115_1.leftNameTxt_.text = var_118_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_37 = arg_115_1:GetWordFromCfg(416011027)
				local var_118_38 = arg_115_1:FormatText(var_118_37.content)

				arg_115_1.text_.text = var_118_38

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_39 = 18
				local var_118_40 = utf8.len(var_118_38)
				local var_118_41 = var_118_39 <= 0 and var_118_35 or var_118_35 * (var_118_40 / var_118_39)

				if var_118_41 > 0 and var_118_35 < var_118_41 then
					arg_115_1.talkMaxDuration = var_118_41

					if var_118_41 + var_118_34 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_41 + var_118_34
					end
				end

				arg_115_1.text_.text = var_118_38
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011027", "story_v_out_416011.awb") ~= 0 then
					local var_118_42 = manager.audio:GetVoiceLength("story_v_out_416011", "416011027", "story_v_out_416011.awb") / 1000

					if var_118_42 + var_118_34 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_42 + var_118_34
					end

					if var_118_37.prefab_name ~= "" and arg_115_1.actors_[var_118_37.prefab_name] ~= nil then
						local var_118_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_37.prefab_name].transform, "story_v_out_416011", "416011027", "story_v_out_416011.awb")

						arg_115_1:RecordAudio("416011027", var_118_43)
						arg_115_1:RecordAudio("416011027", var_118_43)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_416011", "416011027", "story_v_out_416011.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_416011", "416011027", "story_v_out_416011.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_44 = math.max(var_118_35, arg_115_1.talkMaxDuration)

			if var_118_34 <= arg_115_1.time_ and arg_115_1.time_ < var_118_34 + var_118_44 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_34) / var_118_44

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_34 + var_118_44 and arg_115_1.time_ < var_118_34 + var_118_44 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play416011028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416011028
		arg_119_1.duration_ = 9.57

		local var_119_0 = {
			zh = 6.566,
			ja = 9.566
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
				arg_119_0:Play416011029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1033"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps1033 == nil then
				arg_119_1.var_.actorSpriteComps1033 = var_122_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_2 = 0.125

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.actorSpriteComps1033 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								local var_122_4 = Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor1.r, var_122_3)
								local var_122_5 = Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor1.g, var_122_3)
								local var_122_6 = Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor1.b, var_122_3)

								iter_122_1.color = Color.New(var_122_4, var_122_5, var_122_6)
							else
								local var_122_7 = Mathf.Lerp(iter_122_1.color.r, 1, var_122_3)

								iter_122_1.color = Color.New(var_122_7, var_122_7, var_122_7)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps1033 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_122_3 then
						if arg_119_1.isInRecall_ then
							iter_122_3.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps1033 = nil
			end

			local var_122_8 = arg_119_1.actors_["1148"]
			local var_122_9 = 0

			if var_122_9 < arg_119_1.time_ and arg_119_1.time_ <= var_122_9 + arg_122_0 and not isNil(var_122_8) and arg_119_1.var_.actorSpriteComps1148 == nil then
				arg_119_1.var_.actorSpriteComps1148 = var_122_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_10 = 0.125

			if var_122_9 <= arg_119_1.time_ and arg_119_1.time_ < var_122_9 + var_122_10 and not isNil(var_122_8) then
				local var_122_11 = (arg_119_1.time_ - var_122_9) / var_122_10

				if arg_119_1.var_.actorSpriteComps1148 then
					for iter_122_4, iter_122_5 in pairs(arg_119_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_122_5 then
							if arg_119_1.isInRecall_ then
								local var_122_12 = Mathf.Lerp(iter_122_5.color.r, arg_119_1.hightColor2.r, var_122_11)
								local var_122_13 = Mathf.Lerp(iter_122_5.color.g, arg_119_1.hightColor2.g, var_122_11)
								local var_122_14 = Mathf.Lerp(iter_122_5.color.b, arg_119_1.hightColor2.b, var_122_11)

								iter_122_5.color = Color.New(var_122_12, var_122_13, var_122_14)
							else
								local var_122_15 = Mathf.Lerp(iter_122_5.color.r, 0.5, var_122_11)

								iter_122_5.color = Color.New(var_122_15, var_122_15, var_122_15)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_9 + var_122_10 and arg_119_1.time_ < var_122_9 + var_122_10 + arg_122_0 and not isNil(var_122_8) and arg_119_1.var_.actorSpriteComps1148 then
				for iter_122_6, iter_122_7 in pairs(arg_119_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_122_7 then
						if arg_119_1.isInRecall_ then
							iter_122_7.color = arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_122_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps1148 = nil
			end

			local var_122_16 = 0
			local var_122_17 = 0.9

			if var_122_16 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_18 = arg_119_1:FormatText(StoryNameCfg[236].name)

				arg_119_1.leftNameTxt_.text = var_122_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_19 = arg_119_1:GetWordFromCfg(416011028)
				local var_122_20 = arg_119_1:FormatText(var_122_19.content)

				arg_119_1.text_.text = var_122_20

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_21 = 36
				local var_122_22 = utf8.len(var_122_20)
				local var_122_23 = var_122_21 <= 0 and var_122_17 or var_122_17 * (var_122_22 / var_122_21)

				if var_122_23 > 0 and var_122_17 < var_122_23 then
					arg_119_1.talkMaxDuration = var_122_23

					if var_122_23 + var_122_16 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_23 + var_122_16
					end
				end

				arg_119_1.text_.text = var_122_20
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011028", "story_v_out_416011.awb") ~= 0 then
					local var_122_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011028", "story_v_out_416011.awb") / 1000

					if var_122_24 + var_122_16 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_24 + var_122_16
					end

					if var_122_19.prefab_name ~= "" and arg_119_1.actors_[var_122_19.prefab_name] ~= nil then
						local var_122_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_19.prefab_name].transform, "story_v_out_416011", "416011028", "story_v_out_416011.awb")

						arg_119_1:RecordAudio("416011028", var_122_25)
						arg_119_1:RecordAudio("416011028", var_122_25)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_416011", "416011028", "story_v_out_416011.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_416011", "416011028", "story_v_out_416011.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_26 = math.max(var_122_17, arg_119_1.talkMaxDuration)

			if var_122_16 <= arg_119_1.time_ and arg_119_1.time_ < var_122_16 + var_122_26 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_16) / var_122_26

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_16 + var_122_26 and arg_119_1.time_ < var_122_16 + var_122_26 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play416011029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 416011029
		arg_123_1.duration_ = 7.23

		local var_123_0 = {
			zh = 4.366,
			ja = 7.233
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
				arg_123_0:Play416011030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1033"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps1033 == nil then
				arg_123_1.var_.actorSpriteComps1033 = var_126_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_2 = 0.125

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.actorSpriteComps1033 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								local var_126_4 = Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor2.r, var_126_3)
								local var_126_5 = Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor2.g, var_126_3)
								local var_126_6 = Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor2.b, var_126_3)

								iter_126_1.color = Color.New(var_126_4, var_126_5, var_126_6)
							else
								local var_126_7 = Mathf.Lerp(iter_126_1.color.r, 0.5, var_126_3)

								iter_126_1.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps1033 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_126_3 then
						if arg_123_1.isInRecall_ then
							iter_126_3.color = arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_126_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps1033 = nil
			end

			local var_126_8 = arg_123_1.actors_["1148"]
			local var_126_9 = 0

			if var_126_9 < arg_123_1.time_ and arg_123_1.time_ <= var_126_9 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.actorSpriteComps1148 == nil then
				arg_123_1.var_.actorSpriteComps1148 = var_126_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_10 = 0.125

			if var_126_9 <= arg_123_1.time_ and arg_123_1.time_ < var_126_9 + var_126_10 and not isNil(var_126_8) then
				local var_126_11 = (arg_123_1.time_ - var_126_9) / var_126_10

				if arg_123_1.var_.actorSpriteComps1148 then
					for iter_126_4, iter_126_5 in pairs(arg_123_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_126_5 then
							if arg_123_1.isInRecall_ then
								local var_126_12 = Mathf.Lerp(iter_126_5.color.r, arg_123_1.hightColor1.r, var_126_11)
								local var_126_13 = Mathf.Lerp(iter_126_5.color.g, arg_123_1.hightColor1.g, var_126_11)
								local var_126_14 = Mathf.Lerp(iter_126_5.color.b, arg_123_1.hightColor1.b, var_126_11)

								iter_126_5.color = Color.New(var_126_12, var_126_13, var_126_14)
							else
								local var_126_15 = Mathf.Lerp(iter_126_5.color.r, 1, var_126_11)

								iter_126_5.color = Color.New(var_126_15, var_126_15, var_126_15)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_9 + var_126_10 and arg_123_1.time_ < var_126_9 + var_126_10 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.actorSpriteComps1148 then
				for iter_126_6, iter_126_7 in pairs(arg_123_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_126_7 then
						if arg_123_1.isInRecall_ then
							iter_126_7.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_126_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps1148 = nil
			end

			local var_126_16 = arg_123_1.actors_["1148"].transform
			local var_126_17 = 0

			if var_126_17 < arg_123_1.time_ and arg_123_1.time_ <= var_126_17 + arg_126_0 then
				arg_123_1.var_.moveOldPos1148 = var_126_16.localPosition
				var_126_16.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("1148", 4)

				local var_126_18 = var_126_16.childCount

				for iter_126_8 = 0, var_126_18 - 1 do
					local var_126_19 = var_126_16:GetChild(iter_126_8)

					if var_126_19.name == "split_1_1" or not string.find(var_126_19.name, "split") then
						var_126_19.gameObject:SetActive(true)
					else
						var_126_19.gameObject:SetActive(false)
					end
				end
			end

			local var_126_20 = 0.001

			if var_126_17 <= arg_123_1.time_ and arg_123_1.time_ < var_126_17 + var_126_20 then
				local var_126_21 = (arg_123_1.time_ - var_126_17) / var_126_20
				local var_126_22 = Vector3.New(390, -429, -180)

				var_126_16.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1148, var_126_22, var_126_21)
			end

			if arg_123_1.time_ >= var_126_17 + var_126_20 and arg_123_1.time_ < var_126_17 + var_126_20 + arg_126_0 then
				var_126_16.localPosition = Vector3.New(390, -429, -180)
			end

			local var_126_23 = 0
			local var_126_24 = 0.525

			if var_126_23 < arg_123_1.time_ and arg_123_1.time_ <= var_126_23 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_25 = arg_123_1:FormatText(StoryNameCfg[8].name)

				arg_123_1.leftNameTxt_.text = var_126_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_26 = arg_123_1:GetWordFromCfg(416011029)
				local var_126_27 = arg_123_1:FormatText(var_126_26.content)

				arg_123_1.text_.text = var_126_27

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_28 = 21
				local var_126_29 = utf8.len(var_126_27)
				local var_126_30 = var_126_28 <= 0 and var_126_24 or var_126_24 * (var_126_29 / var_126_28)

				if var_126_30 > 0 and var_126_24 < var_126_30 then
					arg_123_1.talkMaxDuration = var_126_30

					if var_126_30 + var_126_23 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_30 + var_126_23
					end
				end

				arg_123_1.text_.text = var_126_27
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011029", "story_v_out_416011.awb") ~= 0 then
					local var_126_31 = manager.audio:GetVoiceLength("story_v_out_416011", "416011029", "story_v_out_416011.awb") / 1000

					if var_126_31 + var_126_23 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_31 + var_126_23
					end

					if var_126_26.prefab_name ~= "" and arg_123_1.actors_[var_126_26.prefab_name] ~= nil then
						local var_126_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_26.prefab_name].transform, "story_v_out_416011", "416011029", "story_v_out_416011.awb")

						arg_123_1:RecordAudio("416011029", var_126_32)
						arg_123_1:RecordAudio("416011029", var_126_32)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_416011", "416011029", "story_v_out_416011.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_416011", "416011029", "story_v_out_416011.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_33 = math.max(var_126_24, arg_123_1.talkMaxDuration)

			if var_126_23 <= arg_123_1.time_ and arg_123_1.time_ < var_126_23 + var_126_33 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_23) / var_126_33

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_23 + var_126_33 and arg_123_1.time_ < var_126_23 + var_126_33 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play416011030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 416011030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play416011031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1033"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps1033 == nil then
				arg_127_1.var_.actorSpriteComps1033 = var_130_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_2 = 0.125

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.actorSpriteComps1033 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								local var_130_4 = Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor2.r, var_130_3)
								local var_130_5 = Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor2.g, var_130_3)
								local var_130_6 = Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor2.b, var_130_3)

								iter_130_1.color = Color.New(var_130_4, var_130_5, var_130_6)
							else
								local var_130_7 = Mathf.Lerp(iter_130_1.color.r, 0.5, var_130_3)

								iter_130_1.color = Color.New(var_130_7, var_130_7, var_130_7)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps1033 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_130_3 then
						if arg_127_1.isInRecall_ then
							iter_130_3.color = arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_130_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps1033 = nil
			end

			local var_130_8 = arg_127_1.actors_["1148"]
			local var_130_9 = 0

			if var_130_9 < arg_127_1.time_ and arg_127_1.time_ <= var_130_9 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps1148 == nil then
				arg_127_1.var_.actorSpriteComps1148 = var_130_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_10 = 0.125

			if var_130_9 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_10 and not isNil(var_130_8) then
				local var_130_11 = (arg_127_1.time_ - var_130_9) / var_130_10

				if arg_127_1.var_.actorSpriteComps1148 then
					for iter_130_4, iter_130_5 in pairs(arg_127_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_130_5 then
							if arg_127_1.isInRecall_ then
								local var_130_12 = Mathf.Lerp(iter_130_5.color.r, arg_127_1.hightColor2.r, var_130_11)
								local var_130_13 = Mathf.Lerp(iter_130_5.color.g, arg_127_1.hightColor2.g, var_130_11)
								local var_130_14 = Mathf.Lerp(iter_130_5.color.b, arg_127_1.hightColor2.b, var_130_11)

								iter_130_5.color = Color.New(var_130_12, var_130_13, var_130_14)
							else
								local var_130_15 = Mathf.Lerp(iter_130_5.color.r, 0.5, var_130_11)

								iter_130_5.color = Color.New(var_130_15, var_130_15, var_130_15)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_9 + var_130_10 and arg_127_1.time_ < var_130_9 + var_130_10 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps1148 then
				for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_130_7 then
						if arg_127_1.isInRecall_ then
							iter_130_7.color = arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_130_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps1148 = nil
			end

			local var_130_16 = 0
			local var_130_17 = 2

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_18 = arg_127_1:GetWordFromCfg(416011030)
				local var_130_19 = arg_127_1:FormatText(var_130_18.content)

				arg_127_1.text_.text = var_130_19

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_20 = 80
				local var_130_21 = utf8.len(var_130_19)
				local var_130_22 = var_130_20 <= 0 and var_130_17 or var_130_17 * (var_130_21 / var_130_20)

				if var_130_22 > 0 and var_130_17 < var_130_22 then
					arg_127_1.talkMaxDuration = var_130_22

					if var_130_22 + var_130_16 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_22 + var_130_16
					end
				end

				arg_127_1.text_.text = var_130_19
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_23 = math.max(var_130_17, arg_127_1.talkMaxDuration)

			if var_130_16 <= arg_127_1.time_ and arg_127_1.time_ < var_130_16 + var_130_23 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_16) / var_130_23

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_16 + var_130_23 and arg_127_1.time_ < var_130_16 + var_130_23 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play416011031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 416011031
		arg_131_1.duration_ = 7.43

		local var_131_0 = {
			zh = 7.3,
			ja = 7.433
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
				arg_131_0:Play416011032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1148"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps1148 == nil then
				arg_131_1.var_.actorSpriteComps1148 = var_134_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_2 = 0.125

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.actorSpriteComps1148 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								local var_134_4 = Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor1.r, var_134_3)
								local var_134_5 = Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor1.g, var_134_3)
								local var_134_6 = Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor1.b, var_134_3)

								iter_134_1.color = Color.New(var_134_4, var_134_5, var_134_6)
							else
								local var_134_7 = Mathf.Lerp(iter_134_1.color.r, 1, var_134_3)

								iter_134_1.color = Color.New(var_134_7, var_134_7, var_134_7)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps1148 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_134_3 then
						if arg_131_1.isInRecall_ then
							iter_134_3.color = arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_134_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps1148 = nil
			end

			local var_134_8 = arg_131_1.actors_["1148"].transform
			local var_134_9 = 0

			if var_134_9 < arg_131_1.time_ and arg_131_1.time_ <= var_134_9 + arg_134_0 then
				arg_131_1.var_.moveOldPos1148 = var_134_8.localPosition
				var_134_8.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1148", 4)

				local var_134_10 = var_134_8.childCount

				for iter_134_4 = 0, var_134_10 - 1 do
					local var_134_11 = var_134_8:GetChild(iter_134_4)

					if var_134_11.name == "split_2" or not string.find(var_134_11.name, "split") then
						var_134_11.gameObject:SetActive(true)
					else
						var_134_11.gameObject:SetActive(false)
					end
				end
			end

			local var_134_12 = 0.001

			if var_134_9 <= arg_131_1.time_ and arg_131_1.time_ < var_134_9 + var_134_12 then
				local var_134_13 = (arg_131_1.time_ - var_134_9) / var_134_12
				local var_134_14 = Vector3.New(390, -429, -180)

				var_134_8.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1148, var_134_14, var_134_13)
			end

			if arg_131_1.time_ >= var_134_9 + var_134_12 and arg_131_1.time_ < var_134_9 + var_134_12 + arg_134_0 then
				var_134_8.localPosition = Vector3.New(390, -429, -180)
			end

			local var_134_15 = 0
			local var_134_16 = 0.7

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_17 = arg_131_1:FormatText(StoryNameCfg[8].name)

				arg_131_1.leftNameTxt_.text = var_134_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_18 = arg_131_1:GetWordFromCfg(416011031)
				local var_134_19 = arg_131_1:FormatText(var_134_18.content)

				arg_131_1.text_.text = var_134_19

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_20 = 28
				local var_134_21 = utf8.len(var_134_19)
				local var_134_22 = var_134_20 <= 0 and var_134_16 or var_134_16 * (var_134_21 / var_134_20)

				if var_134_22 > 0 and var_134_16 < var_134_22 then
					arg_131_1.talkMaxDuration = var_134_22

					if var_134_22 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_22 + var_134_15
					end
				end

				arg_131_1.text_.text = var_134_19
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011031", "story_v_out_416011.awb") ~= 0 then
					local var_134_23 = manager.audio:GetVoiceLength("story_v_out_416011", "416011031", "story_v_out_416011.awb") / 1000

					if var_134_23 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_23 + var_134_15
					end

					if var_134_18.prefab_name ~= "" and arg_131_1.actors_[var_134_18.prefab_name] ~= nil then
						local var_134_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_18.prefab_name].transform, "story_v_out_416011", "416011031", "story_v_out_416011.awb")

						arg_131_1:RecordAudio("416011031", var_134_24)
						arg_131_1:RecordAudio("416011031", var_134_24)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_416011", "416011031", "story_v_out_416011.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_416011", "416011031", "story_v_out_416011.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_25 = math.max(var_134_16, arg_131_1.talkMaxDuration)

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_25 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_15) / var_134_25

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_15 + var_134_25 and arg_131_1.time_ < var_134_15 + var_134_25 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play416011032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 416011032
		arg_135_1.duration_ = 12.57

		local var_135_0 = {
			zh = 9.6,
			ja = 12.566
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
				arg_135_0:Play416011033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1033"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos1033 = var_138_0.localPosition
				var_138_0.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1033", 2)

				local var_138_2 = var_138_0.childCount

				for iter_138_0 = 0, var_138_2 - 1 do
					local var_138_3 = var_138_0:GetChild(iter_138_0)

					if var_138_3.name == "split_6" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_4 then
				local var_138_5 = (arg_135_1.time_ - var_138_1) / var_138_4
				local var_138_6 = Vector3.New(-390, -420, 0)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1033, var_138_6, var_138_5)
			end

			if arg_135_1.time_ >= var_138_1 + var_138_4 and arg_135_1.time_ < var_138_1 + var_138_4 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_138_7 = arg_135_1.actors_["1033"]
			local var_138_8 = 0

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps1033 == nil then
				arg_135_1.var_.actorSpriteComps1033 = var_138_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_9 = 0.125

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_9 and not isNil(var_138_7) then
				local var_138_10 = (arg_135_1.time_ - var_138_8) / var_138_9

				if arg_135_1.var_.actorSpriteComps1033 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_138_2 then
							if arg_135_1.isInRecall_ then
								local var_138_11 = Mathf.Lerp(iter_138_2.color.r, arg_135_1.hightColor1.r, var_138_10)
								local var_138_12 = Mathf.Lerp(iter_138_2.color.g, arg_135_1.hightColor1.g, var_138_10)
								local var_138_13 = Mathf.Lerp(iter_138_2.color.b, arg_135_1.hightColor1.b, var_138_10)

								iter_138_2.color = Color.New(var_138_11, var_138_12, var_138_13)
							else
								local var_138_14 = Mathf.Lerp(iter_138_2.color.r, 1, var_138_10)

								iter_138_2.color = Color.New(var_138_14, var_138_14, var_138_14)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_8 + var_138_9 and arg_135_1.time_ < var_138_8 + var_138_9 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps1033 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_138_4 then
						if arg_135_1.isInRecall_ then
							iter_138_4.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps1033 = nil
			end

			local var_138_15 = arg_135_1.actors_["1148"]
			local var_138_16 = 0

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 and not isNil(var_138_15) and arg_135_1.var_.actorSpriteComps1148 == nil then
				arg_135_1.var_.actorSpriteComps1148 = var_138_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_17 = 0.125

			if var_138_16 <= arg_135_1.time_ and arg_135_1.time_ < var_138_16 + var_138_17 and not isNil(var_138_15) then
				local var_138_18 = (arg_135_1.time_ - var_138_16) / var_138_17

				if arg_135_1.var_.actorSpriteComps1148 then
					for iter_138_5, iter_138_6 in pairs(arg_135_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_138_6 then
							if arg_135_1.isInRecall_ then
								local var_138_19 = Mathf.Lerp(iter_138_6.color.r, arg_135_1.hightColor2.r, var_138_18)
								local var_138_20 = Mathf.Lerp(iter_138_6.color.g, arg_135_1.hightColor2.g, var_138_18)
								local var_138_21 = Mathf.Lerp(iter_138_6.color.b, arg_135_1.hightColor2.b, var_138_18)

								iter_138_6.color = Color.New(var_138_19, var_138_20, var_138_21)
							else
								local var_138_22 = Mathf.Lerp(iter_138_6.color.r, 0.5, var_138_18)

								iter_138_6.color = Color.New(var_138_22, var_138_22, var_138_22)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_16 + var_138_17 and arg_135_1.time_ < var_138_16 + var_138_17 + arg_138_0 and not isNil(var_138_15) and arg_135_1.var_.actorSpriteComps1148 then
				for iter_138_7, iter_138_8 in pairs(arg_135_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_138_8 then
						if arg_135_1.isInRecall_ then
							iter_138_8.color = arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_138_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps1148 = nil
			end

			local var_138_23 = 0
			local var_138_24 = 1.15

			if var_138_23 < arg_135_1.time_ and arg_135_1.time_ <= var_138_23 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_25 = arg_135_1:FormatText(StoryNameCfg[236].name)

				arg_135_1.leftNameTxt_.text = var_138_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_26 = arg_135_1:GetWordFromCfg(416011032)
				local var_138_27 = arg_135_1:FormatText(var_138_26.content)

				arg_135_1.text_.text = var_138_27

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_28 = 46
				local var_138_29 = utf8.len(var_138_27)
				local var_138_30 = var_138_28 <= 0 and var_138_24 or var_138_24 * (var_138_29 / var_138_28)

				if var_138_30 > 0 and var_138_24 < var_138_30 then
					arg_135_1.talkMaxDuration = var_138_30

					if var_138_30 + var_138_23 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_30 + var_138_23
					end
				end

				arg_135_1.text_.text = var_138_27
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011032", "story_v_out_416011.awb") ~= 0 then
					local var_138_31 = manager.audio:GetVoiceLength("story_v_out_416011", "416011032", "story_v_out_416011.awb") / 1000

					if var_138_31 + var_138_23 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_31 + var_138_23
					end

					if var_138_26.prefab_name ~= "" and arg_135_1.actors_[var_138_26.prefab_name] ~= nil then
						local var_138_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_26.prefab_name].transform, "story_v_out_416011", "416011032", "story_v_out_416011.awb")

						arg_135_1:RecordAudio("416011032", var_138_32)
						arg_135_1:RecordAudio("416011032", var_138_32)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_416011", "416011032", "story_v_out_416011.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_416011", "416011032", "story_v_out_416011.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_33 = math.max(var_138_24, arg_135_1.talkMaxDuration)

			if var_138_23 <= arg_135_1.time_ and arg_135_1.time_ < var_138_23 + var_138_33 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_23) / var_138_33

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_23 + var_138_33 and arg_135_1.time_ < var_138_23 + var_138_33 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play416011033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 416011033
		arg_139_1.duration_ = 6.27

		local var_139_0 = {
			zh = 5.266,
			ja = 6.266
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
				arg_139_0:Play416011034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1148"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1148 = var_142_0.localPosition
				var_142_0.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1148", 4)

				local var_142_2 = var_142_0.childCount

				for iter_142_0 = 0, var_142_2 - 1 do
					local var_142_3 = var_142_0:GetChild(iter_142_0)

					if var_142_3.name == "split_6" or not string.find(var_142_3.name, "split") then
						var_142_3.gameObject:SetActive(true)
					else
						var_142_3.gameObject:SetActive(false)
					end
				end
			end

			local var_142_4 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_4 then
				local var_142_5 = (arg_139_1.time_ - var_142_1) / var_142_4
				local var_142_6 = Vector3.New(390, -429, -180)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1148, var_142_6, var_142_5)
			end

			if arg_139_1.time_ >= var_142_1 + var_142_4 and arg_139_1.time_ < var_142_1 + var_142_4 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(390, -429, -180)
			end

			local var_142_7 = arg_139_1.actors_["1148"]
			local var_142_8 = 0

			if var_142_8 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.actorSpriteComps1148 == nil then
				arg_139_1.var_.actorSpriteComps1148 = var_142_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_9 = 0.125

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_9 and not isNil(var_142_7) then
				local var_142_10 = (arg_139_1.time_ - var_142_8) / var_142_9

				if arg_139_1.var_.actorSpriteComps1148 then
					for iter_142_1, iter_142_2 in pairs(arg_139_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_142_2 then
							if arg_139_1.isInRecall_ then
								local var_142_11 = Mathf.Lerp(iter_142_2.color.r, arg_139_1.hightColor1.r, var_142_10)
								local var_142_12 = Mathf.Lerp(iter_142_2.color.g, arg_139_1.hightColor1.g, var_142_10)
								local var_142_13 = Mathf.Lerp(iter_142_2.color.b, arg_139_1.hightColor1.b, var_142_10)

								iter_142_2.color = Color.New(var_142_11, var_142_12, var_142_13)
							else
								local var_142_14 = Mathf.Lerp(iter_142_2.color.r, 1, var_142_10)

								iter_142_2.color = Color.New(var_142_14, var_142_14, var_142_14)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_8 + var_142_9 and arg_139_1.time_ < var_142_8 + var_142_9 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.actorSpriteComps1148 then
				for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_142_4 then
						if arg_139_1.isInRecall_ then
							iter_142_4.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_142_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps1148 = nil
			end

			local var_142_15 = arg_139_1.actors_["1033"]
			local var_142_16 = 0

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 and not isNil(var_142_15) and arg_139_1.var_.actorSpriteComps1033 == nil then
				arg_139_1.var_.actorSpriteComps1033 = var_142_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_17 = 0.125

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_17 and not isNil(var_142_15) then
				local var_142_18 = (arg_139_1.time_ - var_142_16) / var_142_17

				if arg_139_1.var_.actorSpriteComps1033 then
					for iter_142_5, iter_142_6 in pairs(arg_139_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_142_6 then
							if arg_139_1.isInRecall_ then
								local var_142_19 = Mathf.Lerp(iter_142_6.color.r, arg_139_1.hightColor2.r, var_142_18)
								local var_142_20 = Mathf.Lerp(iter_142_6.color.g, arg_139_1.hightColor2.g, var_142_18)
								local var_142_21 = Mathf.Lerp(iter_142_6.color.b, arg_139_1.hightColor2.b, var_142_18)

								iter_142_6.color = Color.New(var_142_19, var_142_20, var_142_21)
							else
								local var_142_22 = Mathf.Lerp(iter_142_6.color.r, 0.5, var_142_18)

								iter_142_6.color = Color.New(var_142_22, var_142_22, var_142_22)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_16 + var_142_17 and arg_139_1.time_ < var_142_16 + var_142_17 + arg_142_0 and not isNil(var_142_15) and arg_139_1.var_.actorSpriteComps1033 then
				for iter_142_7, iter_142_8 in pairs(arg_139_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_142_8 then
						if arg_139_1.isInRecall_ then
							iter_142_8.color = arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_142_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps1033 = nil
			end

			local var_142_23 = 0
			local var_142_24 = 0.575

			if var_142_23 < arg_139_1.time_ and arg_139_1.time_ <= var_142_23 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_25 = arg_139_1:FormatText(StoryNameCfg[8].name)

				arg_139_1.leftNameTxt_.text = var_142_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_26 = arg_139_1:GetWordFromCfg(416011033)
				local var_142_27 = arg_139_1:FormatText(var_142_26.content)

				arg_139_1.text_.text = var_142_27

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_28 = 23
				local var_142_29 = utf8.len(var_142_27)
				local var_142_30 = var_142_28 <= 0 and var_142_24 or var_142_24 * (var_142_29 / var_142_28)

				if var_142_30 > 0 and var_142_24 < var_142_30 then
					arg_139_1.talkMaxDuration = var_142_30

					if var_142_30 + var_142_23 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_30 + var_142_23
					end
				end

				arg_139_1.text_.text = var_142_27
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011033", "story_v_out_416011.awb") ~= 0 then
					local var_142_31 = manager.audio:GetVoiceLength("story_v_out_416011", "416011033", "story_v_out_416011.awb") / 1000

					if var_142_31 + var_142_23 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_31 + var_142_23
					end

					if var_142_26.prefab_name ~= "" and arg_139_1.actors_[var_142_26.prefab_name] ~= nil then
						local var_142_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_26.prefab_name].transform, "story_v_out_416011", "416011033", "story_v_out_416011.awb")

						arg_139_1:RecordAudio("416011033", var_142_32)
						arg_139_1:RecordAudio("416011033", var_142_32)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_416011", "416011033", "story_v_out_416011.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_416011", "416011033", "story_v_out_416011.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_33 = math.max(var_142_24, arg_139_1.talkMaxDuration)

			if var_142_23 <= arg_139_1.time_ and arg_139_1.time_ < var_142_23 + var_142_33 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_23) / var_142_33

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_23 + var_142_33 and arg_139_1.time_ < var_142_23 + var_142_33 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play416011034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 416011034
		arg_143_1.duration_ = 10.33

		local var_143_0 = {
			zh = 9.3,
			ja = 10.333
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
				arg_143_0:Play416011035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1148"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.actorSpriteComps1148 == nil then
				arg_143_1.var_.actorSpriteComps1148 = var_146_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_2 = 0.125

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.actorSpriteComps1148 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								local var_146_4 = Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor2.r, var_146_3)
								local var_146_5 = Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor2.g, var_146_3)
								local var_146_6 = Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor2.b, var_146_3)

								iter_146_1.color = Color.New(var_146_4, var_146_5, var_146_6)
							else
								local var_146_7 = Mathf.Lerp(iter_146_1.color.r, 0.5, var_146_3)

								iter_146_1.color = Color.New(var_146_7, var_146_7, var_146_7)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.actorSpriteComps1148 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_146_3 then
						if arg_143_1.isInRecall_ then
							iter_146_3.color = arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_146_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps1148 = nil
			end

			local var_146_8 = arg_143_1.actors_["1033"]
			local var_146_9 = 0

			if var_146_9 < arg_143_1.time_ and arg_143_1.time_ <= var_146_9 + arg_146_0 and not isNil(var_146_8) and arg_143_1.var_.actorSpriteComps1033 == nil then
				arg_143_1.var_.actorSpriteComps1033 = var_146_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_10 = 0.125

			if var_146_9 <= arg_143_1.time_ and arg_143_1.time_ < var_146_9 + var_146_10 and not isNil(var_146_8) then
				local var_146_11 = (arg_143_1.time_ - var_146_9) / var_146_10

				if arg_143_1.var_.actorSpriteComps1033 then
					for iter_146_4, iter_146_5 in pairs(arg_143_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_146_5 then
							if arg_143_1.isInRecall_ then
								local var_146_12 = Mathf.Lerp(iter_146_5.color.r, arg_143_1.hightColor1.r, var_146_11)
								local var_146_13 = Mathf.Lerp(iter_146_5.color.g, arg_143_1.hightColor1.g, var_146_11)
								local var_146_14 = Mathf.Lerp(iter_146_5.color.b, arg_143_1.hightColor1.b, var_146_11)

								iter_146_5.color = Color.New(var_146_12, var_146_13, var_146_14)
							else
								local var_146_15 = Mathf.Lerp(iter_146_5.color.r, 1, var_146_11)

								iter_146_5.color = Color.New(var_146_15, var_146_15, var_146_15)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_9 + var_146_10 and arg_143_1.time_ < var_146_9 + var_146_10 + arg_146_0 and not isNil(var_146_8) and arg_143_1.var_.actorSpriteComps1033 then
				for iter_146_6, iter_146_7 in pairs(arg_143_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_146_7 then
						if arg_143_1.isInRecall_ then
							iter_146_7.color = arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_146_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps1033 = nil
			end

			local var_146_16 = 0
			local var_146_17 = 1.05

			if var_146_16 < arg_143_1.time_ and arg_143_1.time_ <= var_146_16 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_18 = arg_143_1:FormatText(StoryNameCfg[236].name)

				arg_143_1.leftNameTxt_.text = var_146_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_19 = arg_143_1:GetWordFromCfg(416011034)
				local var_146_20 = arg_143_1:FormatText(var_146_19.content)

				arg_143_1.text_.text = var_146_20

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_21 = 42
				local var_146_22 = utf8.len(var_146_20)
				local var_146_23 = var_146_21 <= 0 and var_146_17 or var_146_17 * (var_146_22 / var_146_21)

				if var_146_23 > 0 and var_146_17 < var_146_23 then
					arg_143_1.talkMaxDuration = var_146_23

					if var_146_23 + var_146_16 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_23 + var_146_16
					end
				end

				arg_143_1.text_.text = var_146_20
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011034", "story_v_out_416011.awb") ~= 0 then
					local var_146_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011034", "story_v_out_416011.awb") / 1000

					if var_146_24 + var_146_16 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_24 + var_146_16
					end

					if var_146_19.prefab_name ~= "" and arg_143_1.actors_[var_146_19.prefab_name] ~= nil then
						local var_146_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_19.prefab_name].transform, "story_v_out_416011", "416011034", "story_v_out_416011.awb")

						arg_143_1:RecordAudio("416011034", var_146_25)
						arg_143_1:RecordAudio("416011034", var_146_25)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_416011", "416011034", "story_v_out_416011.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_416011", "416011034", "story_v_out_416011.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_26 = math.max(var_146_17, arg_143_1.talkMaxDuration)

			if var_146_16 <= arg_143_1.time_ and arg_143_1.time_ < var_146_16 + var_146_26 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_16) / var_146_26

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_16 + var_146_26 and arg_143_1.time_ < var_146_16 + var_146_26 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play416011035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 416011035
		arg_147_1.duration_ = 7.97

		local var_147_0 = {
			zh = 6,
			ja = 7.966
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play416011036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1148"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.actorSpriteComps1148 == nil then
				arg_147_1.var_.actorSpriteComps1148 = var_150_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_2 = 0.125

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.actorSpriteComps1148 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_150_1 then
							if arg_147_1.isInRecall_ then
								local var_150_4 = Mathf.Lerp(iter_150_1.color.r, arg_147_1.hightColor1.r, var_150_3)
								local var_150_5 = Mathf.Lerp(iter_150_1.color.g, arg_147_1.hightColor1.g, var_150_3)
								local var_150_6 = Mathf.Lerp(iter_150_1.color.b, arg_147_1.hightColor1.b, var_150_3)

								iter_150_1.color = Color.New(var_150_4, var_150_5, var_150_6)
							else
								local var_150_7 = Mathf.Lerp(iter_150_1.color.r, 1, var_150_3)

								iter_150_1.color = Color.New(var_150_7, var_150_7, var_150_7)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.actorSpriteComps1148 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_150_3 then
						if arg_147_1.isInRecall_ then
							iter_150_3.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_150_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps1148 = nil
			end

			local var_150_8 = arg_147_1.actors_["1033"]
			local var_150_9 = 0

			if var_150_9 < arg_147_1.time_ and arg_147_1.time_ <= var_150_9 + arg_150_0 and not isNil(var_150_8) and arg_147_1.var_.actorSpriteComps1033 == nil then
				arg_147_1.var_.actorSpriteComps1033 = var_150_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_10 = 0.125

			if var_150_9 <= arg_147_1.time_ and arg_147_1.time_ < var_150_9 + var_150_10 and not isNil(var_150_8) then
				local var_150_11 = (arg_147_1.time_ - var_150_9) / var_150_10

				if arg_147_1.var_.actorSpriteComps1033 then
					for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_150_5 then
							if arg_147_1.isInRecall_ then
								local var_150_12 = Mathf.Lerp(iter_150_5.color.r, arg_147_1.hightColor2.r, var_150_11)
								local var_150_13 = Mathf.Lerp(iter_150_5.color.g, arg_147_1.hightColor2.g, var_150_11)
								local var_150_14 = Mathf.Lerp(iter_150_5.color.b, arg_147_1.hightColor2.b, var_150_11)

								iter_150_5.color = Color.New(var_150_12, var_150_13, var_150_14)
							else
								local var_150_15 = Mathf.Lerp(iter_150_5.color.r, 0.5, var_150_11)

								iter_150_5.color = Color.New(var_150_15, var_150_15, var_150_15)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_9 + var_150_10 and arg_147_1.time_ < var_150_9 + var_150_10 + arg_150_0 and not isNil(var_150_8) and arg_147_1.var_.actorSpriteComps1033 then
				for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_150_7 then
						if arg_147_1.isInRecall_ then
							iter_150_7.color = arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_150_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps1033 = nil
			end

			local var_150_16 = arg_147_1.actors_["1148"].transform
			local var_150_17 = 0

			if var_150_17 < arg_147_1.time_ and arg_147_1.time_ <= var_150_17 + arg_150_0 then
				arg_147_1.var_.moveOldPos1148 = var_150_16.localPosition
				var_150_16.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1148", 4)

				local var_150_18 = var_150_16.childCount

				for iter_150_8 = 0, var_150_18 - 1 do
					local var_150_19 = var_150_16:GetChild(iter_150_8)

					if var_150_19.name == "split_4" or not string.find(var_150_19.name, "split") then
						var_150_19.gameObject:SetActive(true)
					else
						var_150_19.gameObject:SetActive(false)
					end
				end
			end

			local var_150_20 = 0.001

			if var_150_17 <= arg_147_1.time_ and arg_147_1.time_ < var_150_17 + var_150_20 then
				local var_150_21 = (arg_147_1.time_ - var_150_17) / var_150_20
				local var_150_22 = Vector3.New(390, -429, -180)

				var_150_16.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1148, var_150_22, var_150_21)
			end

			if arg_147_1.time_ >= var_150_17 + var_150_20 and arg_147_1.time_ < var_150_17 + var_150_20 + arg_150_0 then
				var_150_16.localPosition = Vector3.New(390, -429, -180)
			end

			local var_150_23 = 0
			local var_150_24 = 0.625

			if var_150_23 < arg_147_1.time_ and arg_147_1.time_ <= var_150_23 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_25 = arg_147_1:FormatText(StoryNameCfg[8].name)

				arg_147_1.leftNameTxt_.text = var_150_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_26 = arg_147_1:GetWordFromCfg(416011035)
				local var_150_27 = arg_147_1:FormatText(var_150_26.content)

				arg_147_1.text_.text = var_150_27

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_28 = 25
				local var_150_29 = utf8.len(var_150_27)
				local var_150_30 = var_150_28 <= 0 and var_150_24 or var_150_24 * (var_150_29 / var_150_28)

				if var_150_30 > 0 and var_150_24 < var_150_30 then
					arg_147_1.talkMaxDuration = var_150_30

					if var_150_30 + var_150_23 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_30 + var_150_23
					end
				end

				arg_147_1.text_.text = var_150_27
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011035", "story_v_out_416011.awb") ~= 0 then
					local var_150_31 = manager.audio:GetVoiceLength("story_v_out_416011", "416011035", "story_v_out_416011.awb") / 1000

					if var_150_31 + var_150_23 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_31 + var_150_23
					end

					if var_150_26.prefab_name ~= "" and arg_147_1.actors_[var_150_26.prefab_name] ~= nil then
						local var_150_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_26.prefab_name].transform, "story_v_out_416011", "416011035", "story_v_out_416011.awb")

						arg_147_1:RecordAudio("416011035", var_150_32)
						arg_147_1:RecordAudio("416011035", var_150_32)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_416011", "416011035", "story_v_out_416011.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_416011", "416011035", "story_v_out_416011.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_33 = math.max(var_150_24, arg_147_1.talkMaxDuration)

			if var_150_23 <= arg_147_1.time_ and arg_147_1.time_ < var_150_23 + var_150_33 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_23) / var_150_33

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_23 + var_150_33 and arg_147_1.time_ < var_150_23 + var_150_33 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play416011036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 416011036
		arg_151_1.duration_ = 11.4

		local var_151_0 = {
			zh = 6.766,
			ja = 11.4
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
				arg_151_0:Play416011037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1033"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps1033 == nil then
				arg_151_1.var_.actorSpriteComps1033 = var_154_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_2 = 0.125

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.actorSpriteComps1033 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps1033 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_154_3 then
						if arg_151_1.isInRecall_ then
							iter_154_3.color = arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_154_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps1033 = nil
			end

			local var_154_8 = arg_151_1.actors_["1148"]
			local var_154_9 = 0

			if var_154_9 < arg_151_1.time_ and arg_151_1.time_ <= var_154_9 + arg_154_0 and not isNil(var_154_8) and arg_151_1.var_.actorSpriteComps1148 == nil then
				arg_151_1.var_.actorSpriteComps1148 = var_154_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_10 = 0.125

			if var_154_9 <= arg_151_1.time_ and arg_151_1.time_ < var_154_9 + var_154_10 and not isNil(var_154_8) then
				local var_154_11 = (arg_151_1.time_ - var_154_9) / var_154_10

				if arg_151_1.var_.actorSpriteComps1148 then
					for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_154_5 then
							if arg_151_1.isInRecall_ then
								local var_154_12 = Mathf.Lerp(iter_154_5.color.r, arg_151_1.hightColor2.r, var_154_11)
								local var_154_13 = Mathf.Lerp(iter_154_5.color.g, arg_151_1.hightColor2.g, var_154_11)
								local var_154_14 = Mathf.Lerp(iter_154_5.color.b, arg_151_1.hightColor2.b, var_154_11)

								iter_154_5.color = Color.New(var_154_12, var_154_13, var_154_14)
							else
								local var_154_15 = Mathf.Lerp(iter_154_5.color.r, 0.5, var_154_11)

								iter_154_5.color = Color.New(var_154_15, var_154_15, var_154_15)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_9 + var_154_10 and arg_151_1.time_ < var_154_9 + var_154_10 + arg_154_0 and not isNil(var_154_8) and arg_151_1.var_.actorSpriteComps1148 then
				for iter_154_6, iter_154_7 in pairs(arg_151_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_154_7 then
						if arg_151_1.isInRecall_ then
							iter_154_7.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps1148 = nil
			end

			local var_154_16 = 0
			local var_154_17 = 0.9

			if var_154_16 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_18 = arg_151_1:FormatText(StoryNameCfg[236].name)

				arg_151_1.leftNameTxt_.text = var_154_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_19 = arg_151_1:GetWordFromCfg(416011036)
				local var_154_20 = arg_151_1:FormatText(var_154_19.content)

				arg_151_1.text_.text = var_154_20

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_21 = 36
				local var_154_22 = utf8.len(var_154_20)
				local var_154_23 = var_154_21 <= 0 and var_154_17 or var_154_17 * (var_154_22 / var_154_21)

				if var_154_23 > 0 and var_154_17 < var_154_23 then
					arg_151_1.talkMaxDuration = var_154_23

					if var_154_23 + var_154_16 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_23 + var_154_16
					end
				end

				arg_151_1.text_.text = var_154_20
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011036", "story_v_out_416011.awb") ~= 0 then
					local var_154_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011036", "story_v_out_416011.awb") / 1000

					if var_154_24 + var_154_16 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_24 + var_154_16
					end

					if var_154_19.prefab_name ~= "" and arg_151_1.actors_[var_154_19.prefab_name] ~= nil then
						local var_154_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_19.prefab_name].transform, "story_v_out_416011", "416011036", "story_v_out_416011.awb")

						arg_151_1:RecordAudio("416011036", var_154_25)
						arg_151_1:RecordAudio("416011036", var_154_25)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_416011", "416011036", "story_v_out_416011.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_416011", "416011036", "story_v_out_416011.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_26 = math.max(var_154_17, arg_151_1.talkMaxDuration)

			if var_154_16 <= arg_151_1.time_ and arg_151_1.time_ < var_154_16 + var_154_26 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_16) / var_154_26

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_16 + var_154_26 and arg_151_1.time_ < var_154_16 + var_154_26 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play416011037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 416011037
		arg_155_1.duration_ = 8.7

		local var_155_0 = {
			zh = 8.7,
			ja = 7.366
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
				arg_155_0:Play416011038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1148"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps1148 == nil then
				arg_155_1.var_.actorSpriteComps1148 = var_158_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_2 = 0.125

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.actorSpriteComps1148 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								local var_158_4 = Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor1.r, var_158_3)
								local var_158_5 = Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor1.g, var_158_3)
								local var_158_6 = Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor1.b, var_158_3)

								iter_158_1.color = Color.New(var_158_4, var_158_5, var_158_6)
							else
								local var_158_7 = Mathf.Lerp(iter_158_1.color.r, 1, var_158_3)

								iter_158_1.color = Color.New(var_158_7, var_158_7, var_158_7)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps1148 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_158_3 then
						if arg_155_1.isInRecall_ then
							iter_158_3.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps1148 = nil
			end

			local var_158_8 = arg_155_1.actors_["1033"]
			local var_158_9 = 0

			if var_158_9 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.actorSpriteComps1033 == nil then
				arg_155_1.var_.actorSpriteComps1033 = var_158_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_10 = 0.125

			if var_158_9 <= arg_155_1.time_ and arg_155_1.time_ < var_158_9 + var_158_10 and not isNil(var_158_8) then
				local var_158_11 = (arg_155_1.time_ - var_158_9) / var_158_10

				if arg_155_1.var_.actorSpriteComps1033 then
					for iter_158_4, iter_158_5 in pairs(arg_155_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_158_5 then
							if arg_155_1.isInRecall_ then
								local var_158_12 = Mathf.Lerp(iter_158_5.color.r, arg_155_1.hightColor2.r, var_158_11)
								local var_158_13 = Mathf.Lerp(iter_158_5.color.g, arg_155_1.hightColor2.g, var_158_11)
								local var_158_14 = Mathf.Lerp(iter_158_5.color.b, arg_155_1.hightColor2.b, var_158_11)

								iter_158_5.color = Color.New(var_158_12, var_158_13, var_158_14)
							else
								local var_158_15 = Mathf.Lerp(iter_158_5.color.r, 0.5, var_158_11)

								iter_158_5.color = Color.New(var_158_15, var_158_15, var_158_15)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_9 + var_158_10 and arg_155_1.time_ < var_158_9 + var_158_10 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.actorSpriteComps1033 then
				for iter_158_6, iter_158_7 in pairs(arg_155_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_158_7 then
						if arg_155_1.isInRecall_ then
							iter_158_7.color = arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_158_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps1033 = nil
			end

			local var_158_16 = arg_155_1.actors_["1148"].transform
			local var_158_17 = 0

			if var_158_17 < arg_155_1.time_ and arg_155_1.time_ <= var_158_17 + arg_158_0 then
				arg_155_1.var_.moveOldPos1148 = var_158_16.localPosition
				var_158_16.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1148", 4)

				local var_158_18 = var_158_16.childCount

				for iter_158_8 = 0, var_158_18 - 1 do
					local var_158_19 = var_158_16:GetChild(iter_158_8)

					if var_158_19.name == "split_4" or not string.find(var_158_19.name, "split") then
						var_158_19.gameObject:SetActive(true)
					else
						var_158_19.gameObject:SetActive(false)
					end
				end
			end

			local var_158_20 = 0.001

			if var_158_17 <= arg_155_1.time_ and arg_155_1.time_ < var_158_17 + var_158_20 then
				local var_158_21 = (arg_155_1.time_ - var_158_17) / var_158_20
				local var_158_22 = Vector3.New(390, -429, -180)

				var_158_16.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1148, var_158_22, var_158_21)
			end

			if arg_155_1.time_ >= var_158_17 + var_158_20 and arg_155_1.time_ < var_158_17 + var_158_20 + arg_158_0 then
				var_158_16.localPosition = Vector3.New(390, -429, -180)
			end

			local var_158_23 = 0
			local var_158_24 = 0.75

			if var_158_23 < arg_155_1.time_ and arg_155_1.time_ <= var_158_23 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_25 = arg_155_1:FormatText(StoryNameCfg[8].name)

				arg_155_1.leftNameTxt_.text = var_158_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_26 = arg_155_1:GetWordFromCfg(416011037)
				local var_158_27 = arg_155_1:FormatText(var_158_26.content)

				arg_155_1.text_.text = var_158_27

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_28 = 30
				local var_158_29 = utf8.len(var_158_27)
				local var_158_30 = var_158_28 <= 0 and var_158_24 or var_158_24 * (var_158_29 / var_158_28)

				if var_158_30 > 0 and var_158_24 < var_158_30 then
					arg_155_1.talkMaxDuration = var_158_30

					if var_158_30 + var_158_23 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_30 + var_158_23
					end
				end

				arg_155_1.text_.text = var_158_27
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011037", "story_v_out_416011.awb") ~= 0 then
					local var_158_31 = manager.audio:GetVoiceLength("story_v_out_416011", "416011037", "story_v_out_416011.awb") / 1000

					if var_158_31 + var_158_23 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_31 + var_158_23
					end

					if var_158_26.prefab_name ~= "" and arg_155_1.actors_[var_158_26.prefab_name] ~= nil then
						local var_158_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_26.prefab_name].transform, "story_v_out_416011", "416011037", "story_v_out_416011.awb")

						arg_155_1:RecordAudio("416011037", var_158_32)
						arg_155_1:RecordAudio("416011037", var_158_32)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_416011", "416011037", "story_v_out_416011.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_416011", "416011037", "story_v_out_416011.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_33 = math.max(var_158_24, arg_155_1.talkMaxDuration)

			if var_158_23 <= arg_155_1.time_ and arg_155_1.time_ < var_158_23 + var_158_33 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_23) / var_158_33

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_23 + var_158_33 and arg_155_1.time_ < var_158_23 + var_158_33 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416011038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 416011038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play416011039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1148"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps1148 == nil then
				arg_159_1.var_.actorSpriteComps1148 = var_162_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_2 = 0.125

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.actorSpriteComps1148 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								local var_162_4 = Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor2.r, var_162_3)
								local var_162_5 = Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor2.g, var_162_3)
								local var_162_6 = Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor2.b, var_162_3)

								iter_162_1.color = Color.New(var_162_4, var_162_5, var_162_6)
							else
								local var_162_7 = Mathf.Lerp(iter_162_1.color.r, 0.5, var_162_3)

								iter_162_1.color = Color.New(var_162_7, var_162_7, var_162_7)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps1148 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_162_3 then
						if arg_159_1.isInRecall_ then
							iter_162_3.color = arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_162_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps1148 = nil
			end

			local var_162_8 = 0
			local var_162_9 = 1.225

			if var_162_8 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_10 = arg_159_1:GetWordFromCfg(416011038)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_12 = 49
				local var_162_13 = utf8.len(var_162_11)
				local var_162_14 = var_162_12 <= 0 and var_162_9 or var_162_9 * (var_162_13 / var_162_12)

				if var_162_14 > 0 and var_162_9 < var_162_14 then
					arg_159_1.talkMaxDuration = var_162_14

					if var_162_14 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_8
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_15 = math.max(var_162_9, arg_159_1.talkMaxDuration)

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_15 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_8) / var_162_15

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_8 + var_162_15 and arg_159_1.time_ < var_162_8 + var_162_15 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play416011039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 416011039
		arg_163_1.duration_ = 8.53

		local var_163_0 = {
			zh = 8.533,
			ja = 8.166
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
				arg_163_0:Play416011040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1148"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps1148 == nil then
				arg_163_1.var_.actorSpriteComps1148 = var_166_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_2 = 0.125

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.actorSpriteComps1148 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								local var_166_4 = Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor1.r, var_166_3)
								local var_166_5 = Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor1.g, var_166_3)
								local var_166_6 = Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor1.b, var_166_3)

								iter_166_1.color = Color.New(var_166_4, var_166_5, var_166_6)
							else
								local var_166_7 = Mathf.Lerp(iter_166_1.color.r, 1, var_166_3)

								iter_166_1.color = Color.New(var_166_7, var_166_7, var_166_7)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps1148 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_166_3 then
						if arg_163_1.isInRecall_ then
							iter_166_3.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps1148 = nil
			end

			local var_166_8 = arg_163_1.actors_["1148"].transform
			local var_166_9 = 0

			if var_166_9 < arg_163_1.time_ and arg_163_1.time_ <= var_166_9 + arg_166_0 then
				arg_163_1.var_.moveOldPos1148 = var_166_8.localPosition
				var_166_8.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1148", 4)

				local var_166_10 = var_166_8.childCount

				for iter_166_4 = 0, var_166_10 - 1 do
					local var_166_11 = var_166_8:GetChild(iter_166_4)

					if var_166_11.name == "split_1_1" or not string.find(var_166_11.name, "split") then
						var_166_11.gameObject:SetActive(true)
					else
						var_166_11.gameObject:SetActive(false)
					end
				end
			end

			local var_166_12 = 0.001

			if var_166_9 <= arg_163_1.time_ and arg_163_1.time_ < var_166_9 + var_166_12 then
				local var_166_13 = (arg_163_1.time_ - var_166_9) / var_166_12
				local var_166_14 = Vector3.New(390, -429, -180)

				var_166_8.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1148, var_166_14, var_166_13)
			end

			if arg_163_1.time_ >= var_166_9 + var_166_12 and arg_163_1.time_ < var_166_9 + var_166_12 + arg_166_0 then
				var_166_8.localPosition = Vector3.New(390, -429, -180)
			end

			local var_166_15 = 0
			local var_166_16 = 0.725

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_17 = arg_163_1:FormatText(StoryNameCfg[8].name)

				arg_163_1.leftNameTxt_.text = var_166_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_18 = arg_163_1:GetWordFromCfg(416011039)
				local var_166_19 = arg_163_1:FormatText(var_166_18.content)

				arg_163_1.text_.text = var_166_19

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_20 = 29
				local var_166_21 = utf8.len(var_166_19)
				local var_166_22 = var_166_20 <= 0 and var_166_16 or var_166_16 * (var_166_21 / var_166_20)

				if var_166_22 > 0 and var_166_16 < var_166_22 then
					arg_163_1.talkMaxDuration = var_166_22

					if var_166_22 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_22 + var_166_15
					end
				end

				arg_163_1.text_.text = var_166_19
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011039", "story_v_out_416011.awb") ~= 0 then
					local var_166_23 = manager.audio:GetVoiceLength("story_v_out_416011", "416011039", "story_v_out_416011.awb") / 1000

					if var_166_23 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_23 + var_166_15
					end

					if var_166_18.prefab_name ~= "" and arg_163_1.actors_[var_166_18.prefab_name] ~= nil then
						local var_166_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_18.prefab_name].transform, "story_v_out_416011", "416011039", "story_v_out_416011.awb")

						arg_163_1:RecordAudio("416011039", var_166_24)
						arg_163_1:RecordAudio("416011039", var_166_24)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_416011", "416011039", "story_v_out_416011.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_416011", "416011039", "story_v_out_416011.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_25 = math.max(var_166_16, arg_163_1.talkMaxDuration)

			if var_166_15 <= arg_163_1.time_ and arg_163_1.time_ < var_166_15 + var_166_25 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_15) / var_166_25

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_15 + var_166_25 and arg_163_1.time_ < var_166_15 + var_166_25 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play416011040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 416011040
		arg_167_1.duration_ = 8.33

		local var_167_0 = {
			zh = 6.266,
			ja = 8.333
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
				arg_167_0:Play416011041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1148"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps1148 == nil then
				arg_167_1.var_.actorSpriteComps1148 = var_170_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_2 = 0.125

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.actorSpriteComps1148 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps1148 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_170_3 then
						if arg_167_1.isInRecall_ then
							iter_170_3.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps1148 = nil
			end

			local var_170_8 = arg_167_1.actors_["1033"]
			local var_170_9 = 0

			if var_170_9 < arg_167_1.time_ and arg_167_1.time_ <= var_170_9 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.actorSpriteComps1033 == nil then
				arg_167_1.var_.actorSpriteComps1033 = var_170_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_10 = 0.125

			if var_170_9 <= arg_167_1.time_ and arg_167_1.time_ < var_170_9 + var_170_10 and not isNil(var_170_8) then
				local var_170_11 = (arg_167_1.time_ - var_170_9) / var_170_10

				if arg_167_1.var_.actorSpriteComps1033 then
					for iter_170_4, iter_170_5 in pairs(arg_167_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_170_5 then
							if arg_167_1.isInRecall_ then
								local var_170_12 = Mathf.Lerp(iter_170_5.color.r, arg_167_1.hightColor1.r, var_170_11)
								local var_170_13 = Mathf.Lerp(iter_170_5.color.g, arg_167_1.hightColor1.g, var_170_11)
								local var_170_14 = Mathf.Lerp(iter_170_5.color.b, arg_167_1.hightColor1.b, var_170_11)

								iter_170_5.color = Color.New(var_170_12, var_170_13, var_170_14)
							else
								local var_170_15 = Mathf.Lerp(iter_170_5.color.r, 1, var_170_11)

								iter_170_5.color = Color.New(var_170_15, var_170_15, var_170_15)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_9 + var_170_10 and arg_167_1.time_ < var_170_9 + var_170_10 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.actorSpriteComps1033 then
				for iter_170_6, iter_170_7 in pairs(arg_167_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_170_7 then
						if arg_167_1.isInRecall_ then
							iter_170_7.color = arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_170_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps1033 = nil
			end

			local var_170_16 = 0
			local var_170_17 = 0.5

			if var_170_16 < arg_167_1.time_ and arg_167_1.time_ <= var_170_16 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_18 = arg_167_1:FormatText(StoryNameCfg[236].name)

				arg_167_1.leftNameTxt_.text = var_170_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_19 = arg_167_1:GetWordFromCfg(416011040)
				local var_170_20 = arg_167_1:FormatText(var_170_19.content)

				arg_167_1.text_.text = var_170_20

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_21 = 20
				local var_170_22 = utf8.len(var_170_20)
				local var_170_23 = var_170_21 <= 0 and var_170_17 or var_170_17 * (var_170_22 / var_170_21)

				if var_170_23 > 0 and var_170_17 < var_170_23 then
					arg_167_1.talkMaxDuration = var_170_23

					if var_170_23 + var_170_16 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_23 + var_170_16
					end
				end

				arg_167_1.text_.text = var_170_20
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011040", "story_v_out_416011.awb") ~= 0 then
					local var_170_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011040", "story_v_out_416011.awb") / 1000

					if var_170_24 + var_170_16 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_24 + var_170_16
					end

					if var_170_19.prefab_name ~= "" and arg_167_1.actors_[var_170_19.prefab_name] ~= nil then
						local var_170_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_19.prefab_name].transform, "story_v_out_416011", "416011040", "story_v_out_416011.awb")

						arg_167_1:RecordAudio("416011040", var_170_25)
						arg_167_1:RecordAudio("416011040", var_170_25)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_416011", "416011040", "story_v_out_416011.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_416011", "416011040", "story_v_out_416011.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_26 = math.max(var_170_17, arg_167_1.talkMaxDuration)

			if var_170_16 <= arg_167_1.time_ and arg_167_1.time_ < var_170_16 + var_170_26 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_16) / var_170_26

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_16 + var_170_26 and arg_167_1.time_ < var_170_16 + var_170_26 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play416011041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 416011041
		arg_171_1.duration_ = 10.4

		local var_171_0 = {
			zh = 8.2,
			ja = 10.4
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
				arg_171_0:Play416011042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1033"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps1033 == nil then
				arg_171_1.var_.actorSpriteComps1033 = var_174_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_2 = 0.125

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.actorSpriteComps1033 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps1033 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_174_3 then
						if arg_171_1.isInRecall_ then
							iter_174_3.color = arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_174_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps1033 = nil
			end

			local var_174_8 = arg_171_1.actors_["1148"]
			local var_174_9 = 0

			if var_174_9 < arg_171_1.time_ and arg_171_1.time_ <= var_174_9 + arg_174_0 and not isNil(var_174_8) and arg_171_1.var_.actorSpriteComps1148 == nil then
				arg_171_1.var_.actorSpriteComps1148 = var_174_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_10 = 0.125

			if var_174_9 <= arg_171_1.time_ and arg_171_1.time_ < var_174_9 + var_174_10 and not isNil(var_174_8) then
				local var_174_11 = (arg_171_1.time_ - var_174_9) / var_174_10

				if arg_171_1.var_.actorSpriteComps1148 then
					for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_171_1.time_ >= var_174_9 + var_174_10 and arg_171_1.time_ < var_174_9 + var_174_10 + arg_174_0 and not isNil(var_174_8) and arg_171_1.var_.actorSpriteComps1148 then
				for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_174_7 then
						if arg_171_1.isInRecall_ then
							iter_174_7.color = arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_174_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps1148 = nil
			end

			local var_174_16 = 0
			local var_174_17 = 0.925

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_18 = arg_171_1:FormatText(StoryNameCfg[8].name)

				arg_171_1.leftNameTxt_.text = var_174_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_19 = arg_171_1:GetWordFromCfg(416011041)
				local var_174_20 = arg_171_1:FormatText(var_174_19.content)

				arg_171_1.text_.text = var_174_20

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_21 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011041", "story_v_out_416011.awb") ~= 0 then
					local var_174_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011041", "story_v_out_416011.awb") / 1000

					if var_174_24 + var_174_16 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_24 + var_174_16
					end

					if var_174_19.prefab_name ~= "" and arg_171_1.actors_[var_174_19.prefab_name] ~= nil then
						local var_174_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_19.prefab_name].transform, "story_v_out_416011", "416011041", "story_v_out_416011.awb")

						arg_171_1:RecordAudio("416011041", var_174_25)
						arg_171_1:RecordAudio("416011041", var_174_25)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_416011", "416011041", "story_v_out_416011.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_416011", "416011041", "story_v_out_416011.awb")
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
	Play416011042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 416011042
		arg_175_1.duration_ = 7.63

		local var_175_0 = {
			zh = 6.6,
			ja = 7.633
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
				arg_175_0:Play416011043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1033"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.actorSpriteComps1033 == nil then
				arg_175_1.var_.actorSpriteComps1033 = var_178_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_2 = 0.125

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.actorSpriteComps1033 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.actorSpriteComps1033 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_178_3 then
						if arg_175_1.isInRecall_ then
							iter_178_3.color = arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_178_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps1033 = nil
			end

			local var_178_8 = arg_175_1.actors_["1148"]
			local var_178_9 = 0

			if var_178_9 < arg_175_1.time_ and arg_175_1.time_ <= var_178_9 + arg_178_0 and not isNil(var_178_8) and arg_175_1.var_.actorSpriteComps1148 == nil then
				arg_175_1.var_.actorSpriteComps1148 = var_178_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_10 = 0.125

			if var_178_9 <= arg_175_1.time_ and arg_175_1.time_ < var_178_9 + var_178_10 and not isNil(var_178_8) then
				local var_178_11 = (arg_175_1.time_ - var_178_9) / var_178_10

				if arg_175_1.var_.actorSpriteComps1148 then
					for iter_178_4, iter_178_5 in pairs(arg_175_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_175_1.time_ >= var_178_9 + var_178_10 and arg_175_1.time_ < var_178_9 + var_178_10 + arg_178_0 and not isNil(var_178_8) and arg_175_1.var_.actorSpriteComps1148 then
				for iter_178_6, iter_178_7 in pairs(arg_175_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_178_7 then
						if arg_175_1.isInRecall_ then
							iter_178_7.color = arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_178_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps1148 = nil
			end

			local var_178_16 = 0
			local var_178_17 = 0.825

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_18 = arg_175_1:FormatText(StoryNameCfg[236].name)

				arg_175_1.leftNameTxt_.text = var_178_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_19 = arg_175_1:GetWordFromCfg(416011042)
				local var_178_20 = arg_175_1:FormatText(var_178_19.content)

				arg_175_1.text_.text = var_178_20

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_21 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011042", "story_v_out_416011.awb") ~= 0 then
					local var_178_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011042", "story_v_out_416011.awb") / 1000

					if var_178_24 + var_178_16 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_24 + var_178_16
					end

					if var_178_19.prefab_name ~= "" and arg_175_1.actors_[var_178_19.prefab_name] ~= nil then
						local var_178_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_19.prefab_name].transform, "story_v_out_416011", "416011042", "story_v_out_416011.awb")

						arg_175_1:RecordAudio("416011042", var_178_25)
						arg_175_1:RecordAudio("416011042", var_178_25)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_416011", "416011042", "story_v_out_416011.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_416011", "416011042", "story_v_out_416011.awb")
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
	Play416011043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 416011043
		arg_179_1.duration_ = 10.33

		local var_179_0 = {
			zh = 8,
			ja = 10.333
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
				arg_179_0:Play416011044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1033"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps1033 == nil then
				arg_179_1.var_.actorSpriteComps1033 = var_182_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_2 = 0.125

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.actorSpriteComps1033 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps1033 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_182_3 then
						if arg_179_1.isInRecall_ then
							iter_182_3.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps1033 = nil
			end

			local var_182_8 = arg_179_1.actors_["1148"]
			local var_182_9 = 0

			if var_182_9 < arg_179_1.time_ and arg_179_1.time_ <= var_182_9 + arg_182_0 and not isNil(var_182_8) and arg_179_1.var_.actorSpriteComps1148 == nil then
				arg_179_1.var_.actorSpriteComps1148 = var_182_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_10 = 0.125

			if var_182_9 <= arg_179_1.time_ and arg_179_1.time_ < var_182_9 + var_182_10 and not isNil(var_182_8) then
				local var_182_11 = (arg_179_1.time_ - var_182_9) / var_182_10

				if arg_179_1.var_.actorSpriteComps1148 then
					for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_179_1.time_ >= var_182_9 + var_182_10 and arg_179_1.time_ < var_182_9 + var_182_10 + arg_182_0 and not isNil(var_182_8) and arg_179_1.var_.actorSpriteComps1148 then
				for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_182_7 then
						if arg_179_1.isInRecall_ then
							iter_182_7.color = arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_182_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps1148 = nil
			end

			local var_182_16 = 0
			local var_182_17 = 0.85

			if var_182_16 < arg_179_1.time_ and arg_179_1.time_ <= var_182_16 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_18 = arg_179_1:FormatText(StoryNameCfg[8].name)

				arg_179_1.leftNameTxt_.text = var_182_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_19 = arg_179_1:GetWordFromCfg(416011043)
				local var_182_20 = arg_179_1:FormatText(var_182_19.content)

				arg_179_1.text_.text = var_182_20

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_21 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011043", "story_v_out_416011.awb") ~= 0 then
					local var_182_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011043", "story_v_out_416011.awb") / 1000

					if var_182_24 + var_182_16 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_24 + var_182_16
					end

					if var_182_19.prefab_name ~= "" and arg_179_1.actors_[var_182_19.prefab_name] ~= nil then
						local var_182_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_19.prefab_name].transform, "story_v_out_416011", "416011043", "story_v_out_416011.awb")

						arg_179_1:RecordAudio("416011043", var_182_25)
						arg_179_1:RecordAudio("416011043", var_182_25)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_416011", "416011043", "story_v_out_416011.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_416011", "416011043", "story_v_out_416011.awb")
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
	Play416011044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 416011044
		arg_183_1.duration_ = 10.97

		local var_183_0 = {
			zh = 6.466,
			ja = 10.966
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play416011045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1033"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps1033 == nil then
				arg_183_1.var_.actorSpriteComps1033 = var_186_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_2 = 0.125

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.actorSpriteComps1033 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								local var_186_4 = Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor1.r, var_186_3)
								local var_186_5 = Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor1.g, var_186_3)
								local var_186_6 = Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor1.b, var_186_3)

								iter_186_1.color = Color.New(var_186_4, var_186_5, var_186_6)
							else
								local var_186_7 = Mathf.Lerp(iter_186_1.color.r, 1, var_186_3)

								iter_186_1.color = Color.New(var_186_7, var_186_7, var_186_7)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps1033 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_186_3 then
						if arg_183_1.isInRecall_ then
							iter_186_3.color = arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_186_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps1033 = nil
			end

			local var_186_8 = arg_183_1.actors_["1148"]
			local var_186_9 = 0

			if var_186_9 < arg_183_1.time_ and arg_183_1.time_ <= var_186_9 + arg_186_0 and not isNil(var_186_8) and arg_183_1.var_.actorSpriteComps1148 == nil then
				arg_183_1.var_.actorSpriteComps1148 = var_186_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_10 = 0.125

			if var_186_9 <= arg_183_1.time_ and arg_183_1.time_ < var_186_9 + var_186_10 and not isNil(var_186_8) then
				local var_186_11 = (arg_183_1.time_ - var_186_9) / var_186_10

				if arg_183_1.var_.actorSpriteComps1148 then
					for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_186_5 then
							if arg_183_1.isInRecall_ then
								local var_186_12 = Mathf.Lerp(iter_186_5.color.r, arg_183_1.hightColor2.r, var_186_11)
								local var_186_13 = Mathf.Lerp(iter_186_5.color.g, arg_183_1.hightColor2.g, var_186_11)
								local var_186_14 = Mathf.Lerp(iter_186_5.color.b, arg_183_1.hightColor2.b, var_186_11)

								iter_186_5.color = Color.New(var_186_12, var_186_13, var_186_14)
							else
								local var_186_15 = Mathf.Lerp(iter_186_5.color.r, 0.5, var_186_11)

								iter_186_5.color = Color.New(var_186_15, var_186_15, var_186_15)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_9 + var_186_10 and arg_183_1.time_ < var_186_9 + var_186_10 + arg_186_0 and not isNil(var_186_8) and arg_183_1.var_.actorSpriteComps1148 then
				for iter_186_6, iter_186_7 in pairs(arg_183_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_186_7 then
						if arg_183_1.isInRecall_ then
							iter_186_7.color = arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_186_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps1148 = nil
			end

			local var_186_16 = 0.666666666666667
			local var_186_17 = 0.333333333333333

			if var_186_16 < arg_183_1.time_ and arg_183_1.time_ <= var_186_16 + arg_186_0 then
				local var_186_18 = "play"
				local var_186_19 = "effect"

				arg_183_1:AudioAction(var_186_18, var_186_19, "se_story_side_1094", "se_story_1094_alarmclock", "")
			end

			local var_186_20 = 0
			local var_186_21 = 0.95

			if var_186_20 < arg_183_1.time_ and arg_183_1.time_ <= var_186_20 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_22 = arg_183_1:FormatText(StoryNameCfg[236].name)

				arg_183_1.leftNameTxt_.text = var_186_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_23 = arg_183_1:GetWordFromCfg(416011044)
				local var_186_24 = arg_183_1:FormatText(var_186_23.content)

				arg_183_1.text_.text = var_186_24

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_25 = 38
				local var_186_26 = utf8.len(var_186_24)
				local var_186_27 = var_186_25 <= 0 and var_186_21 or var_186_21 * (var_186_26 / var_186_25)

				if var_186_27 > 0 and var_186_21 < var_186_27 then
					arg_183_1.talkMaxDuration = var_186_27

					if var_186_27 + var_186_20 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_27 + var_186_20
					end
				end

				arg_183_1.text_.text = var_186_24
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011044", "story_v_out_416011.awb") ~= 0 then
					local var_186_28 = manager.audio:GetVoiceLength("story_v_out_416011", "416011044", "story_v_out_416011.awb") / 1000

					if var_186_28 + var_186_20 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_28 + var_186_20
					end

					if var_186_23.prefab_name ~= "" and arg_183_1.actors_[var_186_23.prefab_name] ~= nil then
						local var_186_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_23.prefab_name].transform, "story_v_out_416011", "416011044", "story_v_out_416011.awb")

						arg_183_1:RecordAudio("416011044", var_186_29)
						arg_183_1:RecordAudio("416011044", var_186_29)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_416011", "416011044", "story_v_out_416011.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_416011", "416011044", "story_v_out_416011.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_30 = math.max(var_186_21, arg_183_1.talkMaxDuration)

			if var_186_20 <= arg_183_1.time_ and arg_183_1.time_ < var_186_20 + var_186_30 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_20) / var_186_30

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_20 + var_186_30 and arg_183_1.time_ < var_186_20 + var_186_30 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play416011045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 416011045
		arg_187_1.duration_ = 22.27

		local var_187_0 = {
			zh = 10.533,
			ja = 22.266
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play416011046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1033"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos1033 = var_190_0.localPosition
				var_190_0.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("1033", 2)

				local var_190_2 = var_190_0.childCount

				for iter_190_0 = 0, var_190_2 - 1 do
					local var_190_3 = var_190_0:GetChild(iter_190_0)

					if var_190_3.name == "split_6" or not string.find(var_190_3.name, "split") then
						var_190_3.gameObject:SetActive(true)
					else
						var_190_3.gameObject:SetActive(false)
					end
				end
			end

			local var_190_4 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_4 then
				local var_190_5 = (arg_187_1.time_ - var_190_1) / var_190_4
				local var_190_6 = Vector3.New(-390, -420, 0)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1033, var_190_6, var_190_5)
			end

			if arg_187_1.time_ >= var_190_1 + var_190_4 and arg_187_1.time_ < var_190_1 + var_190_4 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_190_7 = 0
			local var_190_8 = 1.125

			if var_190_7 < arg_187_1.time_ and arg_187_1.time_ <= var_190_7 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_9 = arg_187_1:FormatText(StoryNameCfg[236].name)

				arg_187_1.leftNameTxt_.text = var_190_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_10 = arg_187_1:GetWordFromCfg(416011045)
				local var_190_11 = arg_187_1:FormatText(var_190_10.content)

				arg_187_1.text_.text = var_190_11

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_12 = 45
				local var_190_13 = utf8.len(var_190_11)
				local var_190_14 = var_190_12 <= 0 and var_190_8 or var_190_8 * (var_190_13 / var_190_12)

				if var_190_14 > 0 and var_190_8 < var_190_14 then
					arg_187_1.talkMaxDuration = var_190_14

					if var_190_14 + var_190_7 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_7
					end
				end

				arg_187_1.text_.text = var_190_11
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011045", "story_v_out_416011.awb") ~= 0 then
					local var_190_15 = manager.audio:GetVoiceLength("story_v_out_416011", "416011045", "story_v_out_416011.awb") / 1000

					if var_190_15 + var_190_7 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_15 + var_190_7
					end

					if var_190_10.prefab_name ~= "" and arg_187_1.actors_[var_190_10.prefab_name] ~= nil then
						local var_190_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_10.prefab_name].transform, "story_v_out_416011", "416011045", "story_v_out_416011.awb")

						arg_187_1:RecordAudio("416011045", var_190_16)
						arg_187_1:RecordAudio("416011045", var_190_16)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_416011", "416011045", "story_v_out_416011.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_416011", "416011045", "story_v_out_416011.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_17 = math.max(var_190_8, arg_187_1.talkMaxDuration)

			if var_190_7 <= arg_187_1.time_ and arg_187_1.time_ < var_190_7 + var_190_17 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_7) / var_190_17

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_7 + var_190_17 and arg_187_1.time_ < var_190_7 + var_190_17 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play416011046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 416011046
		arg_191_1.duration_ = 8.6

		local var_191_0 = {
			zh = 5.4,
			ja = 8.6
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
				arg_191_0:Play416011047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1033"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.actorSpriteComps1033 == nil then
				arg_191_1.var_.actorSpriteComps1033 = var_194_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_2 = 0.125

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.actorSpriteComps1033 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_194_1 then
							if arg_191_1.isInRecall_ then
								local var_194_4 = Mathf.Lerp(iter_194_1.color.r, arg_191_1.hightColor2.r, var_194_3)
								local var_194_5 = Mathf.Lerp(iter_194_1.color.g, arg_191_1.hightColor2.g, var_194_3)
								local var_194_6 = Mathf.Lerp(iter_194_1.color.b, arg_191_1.hightColor2.b, var_194_3)

								iter_194_1.color = Color.New(var_194_4, var_194_5, var_194_6)
							else
								local var_194_7 = Mathf.Lerp(iter_194_1.color.r, 0.5, var_194_3)

								iter_194_1.color = Color.New(var_194_7, var_194_7, var_194_7)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.actorSpriteComps1033 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_194_3 then
						if arg_191_1.isInRecall_ then
							iter_194_3.color = arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_194_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps1033 = nil
			end

			local var_194_8 = arg_191_1.actors_["1148"]
			local var_194_9 = 0

			if var_194_9 < arg_191_1.time_ and arg_191_1.time_ <= var_194_9 + arg_194_0 and not isNil(var_194_8) and arg_191_1.var_.actorSpriteComps1148 == nil then
				arg_191_1.var_.actorSpriteComps1148 = var_194_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_10 = 0.125

			if var_194_9 <= arg_191_1.time_ and arg_191_1.time_ < var_194_9 + var_194_10 and not isNil(var_194_8) then
				local var_194_11 = (arg_191_1.time_ - var_194_9) / var_194_10

				if arg_191_1.var_.actorSpriteComps1148 then
					for iter_194_4, iter_194_5 in pairs(arg_191_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_194_5 then
							if arg_191_1.isInRecall_ then
								local var_194_12 = Mathf.Lerp(iter_194_5.color.r, arg_191_1.hightColor1.r, var_194_11)
								local var_194_13 = Mathf.Lerp(iter_194_5.color.g, arg_191_1.hightColor1.g, var_194_11)
								local var_194_14 = Mathf.Lerp(iter_194_5.color.b, arg_191_1.hightColor1.b, var_194_11)

								iter_194_5.color = Color.New(var_194_12, var_194_13, var_194_14)
							else
								local var_194_15 = Mathf.Lerp(iter_194_5.color.r, 1, var_194_11)

								iter_194_5.color = Color.New(var_194_15, var_194_15, var_194_15)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= var_194_9 + var_194_10 and arg_191_1.time_ < var_194_9 + var_194_10 + arg_194_0 and not isNil(var_194_8) and arg_191_1.var_.actorSpriteComps1148 then
				for iter_194_6, iter_194_7 in pairs(arg_191_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_194_7 then
						if arg_191_1.isInRecall_ then
							iter_194_7.color = arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_194_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps1148 = nil
			end

			local var_194_16 = arg_191_1.actors_["1148"].transform
			local var_194_17 = 0

			if var_194_17 < arg_191_1.time_ and arg_191_1.time_ <= var_194_17 + arg_194_0 then
				arg_191_1.var_.moveOldPos1148 = var_194_16.localPosition
				var_194_16.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("1148", 4)

				local var_194_18 = var_194_16.childCount

				for iter_194_8 = 0, var_194_18 - 1 do
					local var_194_19 = var_194_16:GetChild(iter_194_8)

					if var_194_19.name == "split_1_1" or not string.find(var_194_19.name, "split") then
						var_194_19.gameObject:SetActive(true)
					else
						var_194_19.gameObject:SetActive(false)
					end
				end
			end

			local var_194_20 = 0.001

			if var_194_17 <= arg_191_1.time_ and arg_191_1.time_ < var_194_17 + var_194_20 then
				local var_194_21 = (arg_191_1.time_ - var_194_17) / var_194_20
				local var_194_22 = Vector3.New(390, -429, -180)

				var_194_16.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1148, var_194_22, var_194_21)
			end

			if arg_191_1.time_ >= var_194_17 + var_194_20 and arg_191_1.time_ < var_194_17 + var_194_20 + arg_194_0 then
				var_194_16.localPosition = Vector3.New(390, -429, -180)
			end

			local var_194_23 = 0
			local var_194_24 = 0.55

			if var_194_23 < arg_191_1.time_ and arg_191_1.time_ <= var_194_23 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_25 = arg_191_1:FormatText(StoryNameCfg[8].name)

				arg_191_1.leftNameTxt_.text = var_194_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_26 = arg_191_1:GetWordFromCfg(416011046)
				local var_194_27 = arg_191_1:FormatText(var_194_26.content)

				arg_191_1.text_.text = var_194_27

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_28 = 22
				local var_194_29 = utf8.len(var_194_27)
				local var_194_30 = var_194_28 <= 0 and var_194_24 or var_194_24 * (var_194_29 / var_194_28)

				if var_194_30 > 0 and var_194_24 < var_194_30 then
					arg_191_1.talkMaxDuration = var_194_30

					if var_194_30 + var_194_23 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_30 + var_194_23
					end
				end

				arg_191_1.text_.text = var_194_27
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011046", "story_v_out_416011.awb") ~= 0 then
					local var_194_31 = manager.audio:GetVoiceLength("story_v_out_416011", "416011046", "story_v_out_416011.awb") / 1000

					if var_194_31 + var_194_23 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_31 + var_194_23
					end

					if var_194_26.prefab_name ~= "" and arg_191_1.actors_[var_194_26.prefab_name] ~= nil then
						local var_194_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_26.prefab_name].transform, "story_v_out_416011", "416011046", "story_v_out_416011.awb")

						arg_191_1:RecordAudio("416011046", var_194_32)
						arg_191_1:RecordAudio("416011046", var_194_32)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_416011", "416011046", "story_v_out_416011.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_416011", "416011046", "story_v_out_416011.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_33 = math.max(var_194_24, arg_191_1.talkMaxDuration)

			if var_194_23 <= arg_191_1.time_ and arg_191_1.time_ < var_194_23 + var_194_33 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_23) / var_194_33

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_23 + var_194_33 and arg_191_1.time_ < var_194_23 + var_194_33 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416011047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 416011047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play416011048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1148"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps1148 == nil then
				arg_195_1.var_.actorSpriteComps1148 = var_198_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_2 = 0.125

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.actorSpriteComps1148 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps1148 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_198_3 then
						if arg_195_1.isInRecall_ then
							iter_198_3.color = arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_198_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps1148 = nil
			end

			local var_198_8 = arg_195_1.actors_["1033"].transform
			local var_198_9 = 0

			if var_198_9 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 then
				arg_195_1.var_.moveOldPos1033 = var_198_8.localPosition
				var_198_8.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1033", 7)

				local var_198_10 = var_198_8.childCount

				for iter_198_4 = 0, var_198_10 - 1 do
					local var_198_11 = var_198_8:GetChild(iter_198_4)

					if var_198_11.name == "" or not string.find(var_198_11.name, "split") then
						var_198_11.gameObject:SetActive(true)
					else
						var_198_11.gameObject:SetActive(false)
					end
				end
			end

			local var_198_12 = 0.001

			if var_198_9 <= arg_195_1.time_ and arg_195_1.time_ < var_198_9 + var_198_12 then
				local var_198_13 = (arg_195_1.time_ - var_198_9) / var_198_12
				local var_198_14 = Vector3.New(0, -2000, 0)

				var_198_8.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1033, var_198_14, var_198_13)
			end

			if arg_195_1.time_ >= var_198_9 + var_198_12 and arg_195_1.time_ < var_198_9 + var_198_12 + arg_198_0 then
				var_198_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_15 = arg_195_1.actors_["1148"].transform
			local var_198_16 = 0

			if var_198_16 < arg_195_1.time_ and arg_195_1.time_ <= var_198_16 + arg_198_0 then
				arg_195_1.var_.moveOldPos1148 = var_198_15.localPosition
				var_198_15.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1148", 7)

				local var_198_17 = var_198_15.childCount

				for iter_198_5 = 0, var_198_17 - 1 do
					local var_198_18 = var_198_15:GetChild(iter_198_5)

					if var_198_18.name == "" or not string.find(var_198_18.name, "split") then
						var_198_18.gameObject:SetActive(true)
					else
						var_198_18.gameObject:SetActive(false)
					end
				end
			end

			local var_198_19 = 0.001

			if var_198_16 <= arg_195_1.time_ and arg_195_1.time_ < var_198_16 + var_198_19 then
				local var_198_20 = (arg_195_1.time_ - var_198_16) / var_198_19
				local var_198_21 = Vector3.New(0, -2000, 0)

				var_198_15.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1148, var_198_21, var_198_20)
			end

			if arg_195_1.time_ >= var_198_16 + var_198_19 and arg_195_1.time_ < var_198_16 + var_198_19 + arg_198_0 then
				var_198_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_22 = 0
			local var_198_23 = 1.35

			if var_198_22 < arg_195_1.time_ and arg_195_1.time_ <= var_198_22 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_24 = arg_195_1:GetWordFromCfg(416011047)
				local var_198_25 = arg_195_1:FormatText(var_198_24.content)

				arg_195_1.text_.text = var_198_25

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_26 = 54
				local var_198_27 = utf8.len(var_198_25)
				local var_198_28 = var_198_26 <= 0 and var_198_23 or var_198_23 * (var_198_27 / var_198_26)

				if var_198_28 > 0 and var_198_23 < var_198_28 then
					arg_195_1.talkMaxDuration = var_198_28

					if var_198_28 + var_198_22 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_28 + var_198_22
					end
				end

				arg_195_1.text_.text = var_198_25
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_29 = math.max(var_198_23, arg_195_1.talkMaxDuration)

			if var_198_22 <= arg_195_1.time_ and arg_195_1.time_ < var_198_22 + var_198_29 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_22) / var_198_29

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_22 + var_198_29 and arg_195_1.time_ < var_198_22 + var_198_29 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
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
	Play416011048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 416011048
		arg_199_1.duration_ = 9.53

		local var_199_0 = {
			zh = 6.4,
			ja = 9.533
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
				arg_199_0:Play416011049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1033"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps1033 == nil then
				arg_199_1.var_.actorSpriteComps1033 = var_202_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_2 = 0.125

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.actorSpriteComps1033 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps1033 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_202_3 then
						if arg_199_1.isInRecall_ then
							iter_202_3.color = arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_202_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps1033 = nil
			end

			local var_202_8 = arg_199_1.actors_["1033"].transform
			local var_202_9 = 0

			if var_202_9 < arg_199_1.time_ and arg_199_1.time_ <= var_202_9 + arg_202_0 then
				arg_199_1.var_.moveOldPos1033 = var_202_8.localPosition
				var_202_8.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("1033", 3)

				local var_202_10 = var_202_8.childCount

				for iter_202_4 = 0, var_202_10 - 1 do
					local var_202_11 = var_202_8:GetChild(iter_202_4)

					if var_202_11.name == "split_6" or not string.find(var_202_11.name, "split") then
						var_202_11.gameObject:SetActive(true)
					else
						var_202_11.gameObject:SetActive(false)
					end
				end
			end

			local var_202_12 = 0.001

			if var_202_9 <= arg_199_1.time_ and arg_199_1.time_ < var_202_9 + var_202_12 then
				local var_202_13 = (arg_199_1.time_ - var_202_9) / var_202_12
				local var_202_14 = Vector3.New(0, -420, 0)

				var_202_8.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1033, var_202_14, var_202_13)
			end

			if arg_199_1.time_ >= var_202_9 + var_202_12 and arg_199_1.time_ < var_202_9 + var_202_12 + arg_202_0 then
				var_202_8.localPosition = Vector3.New(0, -420, 0)
			end

			local var_202_15 = 0
			local var_202_16 = 0.85

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_17 = arg_199_1:FormatText(StoryNameCfg[236].name)

				arg_199_1.leftNameTxt_.text = var_202_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_18 = arg_199_1:GetWordFromCfg(416011048)
				local var_202_19 = arg_199_1:FormatText(var_202_18.content)

				arg_199_1.text_.text = var_202_19

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_20 = 34
				local var_202_21 = utf8.len(var_202_19)
				local var_202_22 = var_202_20 <= 0 and var_202_16 or var_202_16 * (var_202_21 / var_202_20)

				if var_202_22 > 0 and var_202_16 < var_202_22 then
					arg_199_1.talkMaxDuration = var_202_22

					if var_202_22 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_22 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_19
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011048", "story_v_out_416011.awb") ~= 0 then
					local var_202_23 = manager.audio:GetVoiceLength("story_v_out_416011", "416011048", "story_v_out_416011.awb") / 1000

					if var_202_23 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_23 + var_202_15
					end

					if var_202_18.prefab_name ~= "" and arg_199_1.actors_[var_202_18.prefab_name] ~= nil then
						local var_202_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_18.prefab_name].transform, "story_v_out_416011", "416011048", "story_v_out_416011.awb")

						arg_199_1:RecordAudio("416011048", var_202_24)
						arg_199_1:RecordAudio("416011048", var_202_24)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_416011", "416011048", "story_v_out_416011.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_416011", "416011048", "story_v_out_416011.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_25 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_25 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_25

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_25 and arg_199_1.time_ < var_202_15 + var_202_25 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play416011049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 416011049
		arg_203_1.duration_ = 7.2

		local var_203_0 = {
			zh = 5.4,
			ja = 7.2
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
				arg_203_0:Play416011050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1033"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps1033 == nil then
				arg_203_1.var_.actorSpriteComps1033 = var_206_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_2 = 0.125

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.actorSpriteComps1033 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps1033 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_206_3 then
						if arg_203_1.isInRecall_ then
							iter_206_3.color = arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_206_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps1033 = nil
			end

			local var_206_8 = arg_203_1.actors_["1148"]
			local var_206_9 = 0

			if var_206_9 < arg_203_1.time_ and arg_203_1.time_ <= var_206_9 + arg_206_0 and not isNil(var_206_8) and arg_203_1.var_.actorSpriteComps1148 == nil then
				arg_203_1.var_.actorSpriteComps1148 = var_206_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_10 = 0.125

			if var_206_9 <= arg_203_1.time_ and arg_203_1.time_ < var_206_9 + var_206_10 and not isNil(var_206_8) then
				local var_206_11 = (arg_203_1.time_ - var_206_9) / var_206_10

				if arg_203_1.var_.actorSpriteComps1148 then
					for iter_206_4, iter_206_5 in pairs(arg_203_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_203_1.time_ >= var_206_9 + var_206_10 and arg_203_1.time_ < var_206_9 + var_206_10 + arg_206_0 and not isNil(var_206_8) and arg_203_1.var_.actorSpriteComps1148 then
				for iter_206_6, iter_206_7 in pairs(arg_203_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_206_7 then
						if arg_203_1.isInRecall_ then
							iter_206_7.color = arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_206_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps1148 = nil
			end

			local var_206_16 = arg_203_1.actors_["1148"].transform
			local var_206_17 = 0

			if var_206_17 < arg_203_1.time_ and arg_203_1.time_ <= var_206_17 + arg_206_0 then
				arg_203_1.var_.moveOldPos1148 = var_206_16.localPosition
				var_206_16.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1148", 4)

				local var_206_18 = var_206_16.childCount

				for iter_206_8 = 0, var_206_18 - 1 do
					local var_206_19 = var_206_16:GetChild(iter_206_8)

					if var_206_19.name == "split_4" or not string.find(var_206_19.name, "split") then
						var_206_19.gameObject:SetActive(true)
					else
						var_206_19.gameObject:SetActive(false)
					end
				end
			end

			local var_206_20 = 0.001

			if var_206_17 <= arg_203_1.time_ and arg_203_1.time_ < var_206_17 + var_206_20 then
				local var_206_21 = (arg_203_1.time_ - var_206_17) / var_206_20
				local var_206_22 = Vector3.New(390, -429, -180)

				var_206_16.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1148, var_206_22, var_206_21)
			end

			if arg_203_1.time_ >= var_206_17 + var_206_20 and arg_203_1.time_ < var_206_17 + var_206_20 + arg_206_0 then
				var_206_16.localPosition = Vector3.New(390, -429, -180)
			end

			local var_206_23 = arg_203_1.actors_["1033"].transform
			local var_206_24 = 0

			if var_206_24 < arg_203_1.time_ and arg_203_1.time_ <= var_206_24 + arg_206_0 then
				arg_203_1.var_.moveOldPos1033 = var_206_23.localPosition
				var_206_23.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1033", 2)

				local var_206_25 = var_206_23.childCount

				for iter_206_9 = 0, var_206_25 - 1 do
					local var_206_26 = var_206_23:GetChild(iter_206_9)

					if var_206_26.name == "" or not string.find(var_206_26.name, "split") then
						var_206_26.gameObject:SetActive(true)
					else
						var_206_26.gameObject:SetActive(false)
					end
				end
			end

			local var_206_27 = 0.001

			if var_206_24 <= arg_203_1.time_ and arg_203_1.time_ < var_206_24 + var_206_27 then
				local var_206_28 = (arg_203_1.time_ - var_206_24) / var_206_27
				local var_206_29 = Vector3.New(-390, -420, 0)

				var_206_23.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1033, var_206_29, var_206_28)
			end

			if arg_203_1.time_ >= var_206_24 + var_206_27 and arg_203_1.time_ < var_206_24 + var_206_27 + arg_206_0 then
				var_206_23.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_206_30 = 0
			local var_206_31 = 0.475

			if var_206_30 < arg_203_1.time_ and arg_203_1.time_ <= var_206_30 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_32 = arg_203_1:FormatText(StoryNameCfg[8].name)

				arg_203_1.leftNameTxt_.text = var_206_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_33 = arg_203_1:GetWordFromCfg(416011049)
				local var_206_34 = arg_203_1:FormatText(var_206_33.content)

				arg_203_1.text_.text = var_206_34

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_35 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011049", "story_v_out_416011.awb") ~= 0 then
					local var_206_38 = manager.audio:GetVoiceLength("story_v_out_416011", "416011049", "story_v_out_416011.awb") / 1000

					if var_206_38 + var_206_30 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_38 + var_206_30
					end

					if var_206_33.prefab_name ~= "" and arg_203_1.actors_[var_206_33.prefab_name] ~= nil then
						local var_206_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_33.prefab_name].transform, "story_v_out_416011", "416011049", "story_v_out_416011.awb")

						arg_203_1:RecordAudio("416011049", var_206_39)
						arg_203_1:RecordAudio("416011049", var_206_39)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_416011", "416011049", "story_v_out_416011.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_416011", "416011049", "story_v_out_416011.awb")
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
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play416011050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 416011050
		arg_207_1.duration_ = 10.5

		local var_207_0 = {
			zh = 5.2,
			ja = 10.5
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
				arg_207_0:Play416011051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1033"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps1033 == nil then
				arg_207_1.var_.actorSpriteComps1033 = var_210_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_2 = 0.125

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.actorSpriteComps1033 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps1033 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_210_3 then
						if arg_207_1.isInRecall_ then
							iter_210_3.color = arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_210_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps1033 = nil
			end

			local var_210_8 = arg_207_1.actors_["1148"]
			local var_210_9 = 0

			if var_210_9 < arg_207_1.time_ and arg_207_1.time_ <= var_210_9 + arg_210_0 and not isNil(var_210_8) and arg_207_1.var_.actorSpriteComps1148 == nil then
				arg_207_1.var_.actorSpriteComps1148 = var_210_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_10 = 0.125

			if var_210_9 <= arg_207_1.time_ and arg_207_1.time_ < var_210_9 + var_210_10 and not isNil(var_210_8) then
				local var_210_11 = (arg_207_1.time_ - var_210_9) / var_210_10

				if arg_207_1.var_.actorSpriteComps1148 then
					for iter_210_4, iter_210_5 in pairs(arg_207_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_207_1.time_ >= var_210_9 + var_210_10 and arg_207_1.time_ < var_210_9 + var_210_10 + arg_210_0 and not isNil(var_210_8) and arg_207_1.var_.actorSpriteComps1148 then
				for iter_210_6, iter_210_7 in pairs(arg_207_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_210_7 then
						if arg_207_1.isInRecall_ then
							iter_210_7.color = arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_210_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps1148 = nil
			end

			local var_210_16 = arg_207_1.actors_["1033"].transform
			local var_210_17 = 0

			if var_210_17 < arg_207_1.time_ and arg_207_1.time_ <= var_210_17 + arg_210_0 then
				arg_207_1.var_.moveOldPos1033 = var_210_16.localPosition
				var_210_16.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("1033", 2)

				local var_210_18 = var_210_16.childCount

				for iter_210_8 = 0, var_210_18 - 1 do
					local var_210_19 = var_210_16:GetChild(iter_210_8)

					if var_210_19.name == "split_6" or not string.find(var_210_19.name, "split") then
						var_210_19.gameObject:SetActive(true)
					else
						var_210_19.gameObject:SetActive(false)
					end
				end
			end

			local var_210_20 = 0.001

			if var_210_17 <= arg_207_1.time_ and arg_207_1.time_ < var_210_17 + var_210_20 then
				local var_210_21 = (arg_207_1.time_ - var_210_17) / var_210_20
				local var_210_22 = Vector3.New(-390, -420, 0)

				var_210_16.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1033, var_210_22, var_210_21)
			end

			if arg_207_1.time_ >= var_210_17 + var_210_20 and arg_207_1.time_ < var_210_17 + var_210_20 + arg_210_0 then
				var_210_16.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_210_23 = 0
			local var_210_24 = 0.625

			if var_210_23 < arg_207_1.time_ and arg_207_1.time_ <= var_210_23 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_25 = arg_207_1:FormatText(StoryNameCfg[236].name)

				arg_207_1.leftNameTxt_.text = var_210_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_26 = arg_207_1:GetWordFromCfg(416011050)
				local var_210_27 = arg_207_1:FormatText(var_210_26.content)

				arg_207_1.text_.text = var_210_27

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_28 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011050", "story_v_out_416011.awb") ~= 0 then
					local var_210_31 = manager.audio:GetVoiceLength("story_v_out_416011", "416011050", "story_v_out_416011.awb") / 1000

					if var_210_31 + var_210_23 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_31 + var_210_23
					end

					if var_210_26.prefab_name ~= "" and arg_207_1.actors_[var_210_26.prefab_name] ~= nil then
						local var_210_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_26.prefab_name].transform, "story_v_out_416011", "416011050", "story_v_out_416011.awb")

						arg_207_1:RecordAudio("416011050", var_210_32)
						arg_207_1:RecordAudio("416011050", var_210_32)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_416011", "416011050", "story_v_out_416011.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_416011", "416011050", "story_v_out_416011.awb")
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
				actorName = "1033",
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
	Play416011051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 416011051
		arg_211_1.duration_ = 5.4

		local var_211_0 = {
			zh = 5.4,
			ja = 5.066
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
				arg_211_0:Play416011052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1033"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps1033 == nil then
				arg_211_1.var_.actorSpriteComps1033 = var_214_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_2 = 0.125

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.actorSpriteComps1033 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								local var_214_4 = Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor2.r, var_214_3)
								local var_214_5 = Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor2.g, var_214_3)
								local var_214_6 = Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor2.b, var_214_3)

								iter_214_1.color = Color.New(var_214_4, var_214_5, var_214_6)
							else
								local var_214_7 = Mathf.Lerp(iter_214_1.color.r, 0.5, var_214_3)

								iter_214_1.color = Color.New(var_214_7, var_214_7, var_214_7)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps1033 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_214_3 then
						if arg_211_1.isInRecall_ then
							iter_214_3.color = arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_214_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps1033 = nil
			end

			local var_214_8 = arg_211_1.actors_["1148"]
			local var_214_9 = 0

			if var_214_9 < arg_211_1.time_ and arg_211_1.time_ <= var_214_9 + arg_214_0 and not isNil(var_214_8) and arg_211_1.var_.actorSpriteComps1148 == nil then
				arg_211_1.var_.actorSpriteComps1148 = var_214_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_10 = 0.125

			if var_214_9 <= arg_211_1.time_ and arg_211_1.time_ < var_214_9 + var_214_10 and not isNil(var_214_8) then
				local var_214_11 = (arg_211_1.time_ - var_214_9) / var_214_10

				if arg_211_1.var_.actorSpriteComps1148 then
					for iter_214_4, iter_214_5 in pairs(arg_211_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_214_5 then
							if arg_211_1.isInRecall_ then
								local var_214_12 = Mathf.Lerp(iter_214_5.color.r, arg_211_1.hightColor1.r, var_214_11)
								local var_214_13 = Mathf.Lerp(iter_214_5.color.g, arg_211_1.hightColor1.g, var_214_11)
								local var_214_14 = Mathf.Lerp(iter_214_5.color.b, arg_211_1.hightColor1.b, var_214_11)

								iter_214_5.color = Color.New(var_214_12, var_214_13, var_214_14)
							else
								local var_214_15 = Mathf.Lerp(iter_214_5.color.r, 1, var_214_11)

								iter_214_5.color = Color.New(var_214_15, var_214_15, var_214_15)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_9 + var_214_10 and arg_211_1.time_ < var_214_9 + var_214_10 + arg_214_0 and not isNil(var_214_8) and arg_211_1.var_.actorSpriteComps1148 then
				for iter_214_6, iter_214_7 in pairs(arg_211_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_214_7 then
						if arg_211_1.isInRecall_ then
							iter_214_7.color = arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_214_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps1148 = nil
			end

			local var_214_16 = 0
			local var_214_17 = 0.525

			if var_214_16 < arg_211_1.time_ and arg_211_1.time_ <= var_214_16 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_18 = arg_211_1:FormatText(StoryNameCfg[8].name)

				arg_211_1.leftNameTxt_.text = var_214_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_19 = arg_211_1:GetWordFromCfg(416011051)
				local var_214_20 = arg_211_1:FormatText(var_214_19.content)

				arg_211_1.text_.text = var_214_20

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_21 = 21
				local var_214_22 = utf8.len(var_214_20)
				local var_214_23 = var_214_21 <= 0 and var_214_17 or var_214_17 * (var_214_22 / var_214_21)

				if var_214_23 > 0 and var_214_17 < var_214_23 then
					arg_211_1.talkMaxDuration = var_214_23

					if var_214_23 + var_214_16 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_23 + var_214_16
					end
				end

				arg_211_1.text_.text = var_214_20
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011051", "story_v_out_416011.awb") ~= 0 then
					local var_214_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011051", "story_v_out_416011.awb") / 1000

					if var_214_24 + var_214_16 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_24 + var_214_16
					end

					if var_214_19.prefab_name ~= "" and arg_211_1.actors_[var_214_19.prefab_name] ~= nil then
						local var_214_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_19.prefab_name].transform, "story_v_out_416011", "416011051", "story_v_out_416011.awb")

						arg_211_1:RecordAudio("416011051", var_214_25)
						arg_211_1:RecordAudio("416011051", var_214_25)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_416011", "416011051", "story_v_out_416011.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_416011", "416011051", "story_v_out_416011.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_26 = math.max(var_214_17, arg_211_1.talkMaxDuration)

			if var_214_16 <= arg_211_1.time_ and arg_211_1.time_ < var_214_16 + var_214_26 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_16) / var_214_26

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_16 + var_214_26 and arg_211_1.time_ < var_214_16 + var_214_26 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play416011052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 416011052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play416011053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1033"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos1033 = var_218_0.localPosition
				var_218_0.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1033", 7)

				local var_218_2 = var_218_0.childCount

				for iter_218_0 = 0, var_218_2 - 1 do
					local var_218_3 = var_218_0:GetChild(iter_218_0)

					if var_218_3.name == "" or not string.find(var_218_3.name, "split") then
						var_218_3.gameObject:SetActive(true)
					else
						var_218_3.gameObject:SetActive(false)
					end
				end
			end

			local var_218_4 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_4 then
				local var_218_5 = (arg_215_1.time_ - var_218_1) / var_218_4
				local var_218_6 = Vector3.New(0, -2000, 0)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1033, var_218_6, var_218_5)
			end

			if arg_215_1.time_ >= var_218_1 + var_218_4 and arg_215_1.time_ < var_218_1 + var_218_4 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_218_7 = arg_215_1.actors_["1148"].transform
			local var_218_8 = 0

			if var_218_8 < arg_215_1.time_ and arg_215_1.time_ <= var_218_8 + arg_218_0 then
				arg_215_1.var_.moveOldPos1148 = var_218_7.localPosition
				var_218_7.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1148", 7)

				local var_218_9 = var_218_7.childCount

				for iter_218_1 = 0, var_218_9 - 1 do
					local var_218_10 = var_218_7:GetChild(iter_218_1)

					if var_218_10.name == "" or not string.find(var_218_10.name, "split") then
						var_218_10.gameObject:SetActive(true)
					else
						var_218_10.gameObject:SetActive(false)
					end
				end
			end

			local var_218_11 = 0.001

			if var_218_8 <= arg_215_1.time_ and arg_215_1.time_ < var_218_8 + var_218_11 then
				local var_218_12 = (arg_215_1.time_ - var_218_8) / var_218_11
				local var_218_13 = Vector3.New(0, -2000, 0)

				var_218_7.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1148, var_218_13, var_218_12)
			end

			if arg_215_1.time_ >= var_218_8 + var_218_11 and arg_215_1.time_ < var_218_8 + var_218_11 + arg_218_0 then
				var_218_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_218_14 = 0
			local var_218_15 = 1.475

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_16 = arg_215_1:GetWordFromCfg(416011052)
				local var_218_17 = arg_215_1:FormatText(var_218_16.content)

				arg_215_1.text_.text = var_218_17

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_18 = 59
				local var_218_19 = utf8.len(var_218_17)
				local var_218_20 = var_218_18 <= 0 and var_218_15 or var_218_15 * (var_218_19 / var_218_18)

				if var_218_20 > 0 and var_218_15 < var_218_20 then
					arg_215_1.talkMaxDuration = var_218_20

					if var_218_20 + var_218_14 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_20 + var_218_14
					end
				end

				arg_215_1.text_.text = var_218_17
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_21 = math.max(var_218_15, arg_215_1.talkMaxDuration)

			if var_218_14 <= arg_215_1.time_ and arg_215_1.time_ < var_218_14 + var_218_21 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_14) / var_218_21

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_14 + var_218_21 and arg_215_1.time_ < var_218_14 + var_218_21 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
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
	Play416011053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 416011053
		arg_219_1.duration_ = 10.9

		local var_219_0 = {
			zh = 8.233,
			ja = 10.9
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
				arg_219_0:Play416011054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1148"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1148 = var_222_0.localPosition
				var_222_0.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("1148", 3)

				local var_222_2 = var_222_0.childCount

				for iter_222_0 = 0, var_222_2 - 1 do
					local var_222_3 = var_222_0:GetChild(iter_222_0)

					if var_222_3.name == "" or not string.find(var_222_3.name, "split") then
						var_222_3.gameObject:SetActive(true)
					else
						var_222_3.gameObject:SetActive(false)
					end
				end
			end

			local var_222_4 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_4 then
				local var_222_5 = (arg_219_1.time_ - var_222_1) / var_222_4
				local var_222_6 = Vector3.New(0, -429, -180)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1148, var_222_6, var_222_5)
			end

			if arg_219_1.time_ >= var_222_1 + var_222_4 and arg_219_1.time_ < var_222_1 + var_222_4 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_222_7 = arg_219_1.actors_["1148"]
			local var_222_8 = 0

			if var_222_8 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 and not isNil(var_222_7) and arg_219_1.var_.actorSpriteComps1148 == nil then
				arg_219_1.var_.actorSpriteComps1148 = var_222_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_9 = 0.125

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_9 and not isNil(var_222_7) then
				local var_222_10 = (arg_219_1.time_ - var_222_8) / var_222_9

				if arg_219_1.var_.actorSpriteComps1148 then
					for iter_222_1, iter_222_2 in pairs(arg_219_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_222_2 then
							if arg_219_1.isInRecall_ then
								local var_222_11 = Mathf.Lerp(iter_222_2.color.r, arg_219_1.hightColor1.r, var_222_10)
								local var_222_12 = Mathf.Lerp(iter_222_2.color.g, arg_219_1.hightColor1.g, var_222_10)
								local var_222_13 = Mathf.Lerp(iter_222_2.color.b, arg_219_1.hightColor1.b, var_222_10)

								iter_222_2.color = Color.New(var_222_11, var_222_12, var_222_13)
							else
								local var_222_14 = Mathf.Lerp(iter_222_2.color.r, 1, var_222_10)

								iter_222_2.color = Color.New(var_222_14, var_222_14, var_222_14)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= var_222_8 + var_222_9 and arg_219_1.time_ < var_222_8 + var_222_9 + arg_222_0 and not isNil(var_222_7) and arg_219_1.var_.actorSpriteComps1148 then
				for iter_222_3, iter_222_4 in pairs(arg_219_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_222_4 then
						if arg_219_1.isInRecall_ then
							iter_222_4.color = arg_219_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_222_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_219_1.var_.actorSpriteComps1148 = nil
			end

			local var_222_15 = 0.691
			local var_222_16 = 0.334

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				local var_222_17 = "play"
				local var_222_18 = "effect"

				arg_219_1:AudioAction(var_222_17, var_222_18, "se_story_17", "se_story_17_door_close02", "")
			end

			local var_222_19 = 0
			local var_222_20 = 1.025

			if var_222_19 < arg_219_1.time_ and arg_219_1.time_ <= var_222_19 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_21 = arg_219_1:FormatText(StoryNameCfg[8].name)

				arg_219_1.leftNameTxt_.text = var_222_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_22 = arg_219_1:GetWordFromCfg(416011053)
				local var_222_23 = arg_219_1:FormatText(var_222_22.content)

				arg_219_1.text_.text = var_222_23

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_24 = 41
				local var_222_25 = utf8.len(var_222_23)
				local var_222_26 = var_222_24 <= 0 and var_222_20 or var_222_20 * (var_222_25 / var_222_24)

				if var_222_26 > 0 and var_222_20 < var_222_26 then
					arg_219_1.talkMaxDuration = var_222_26

					if var_222_26 + var_222_19 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_26 + var_222_19
					end
				end

				arg_219_1.text_.text = var_222_23
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011053", "story_v_out_416011.awb") ~= 0 then
					local var_222_27 = manager.audio:GetVoiceLength("story_v_out_416011", "416011053", "story_v_out_416011.awb") / 1000

					if var_222_27 + var_222_19 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_27 + var_222_19
					end

					if var_222_22.prefab_name ~= "" and arg_219_1.actors_[var_222_22.prefab_name] ~= nil then
						local var_222_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_22.prefab_name].transform, "story_v_out_416011", "416011053", "story_v_out_416011.awb")

						arg_219_1:RecordAudio("416011053", var_222_28)
						arg_219_1:RecordAudio("416011053", var_222_28)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_416011", "416011053", "story_v_out_416011.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_416011", "416011053", "story_v_out_416011.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_29 = math.max(var_222_20, arg_219_1.talkMaxDuration)

			if var_222_19 <= arg_219_1.time_ and arg_219_1.time_ < var_222_19 + var_222_29 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_19) / var_222_29

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_19 + var_222_29 and arg_219_1.time_ < var_222_19 + var_222_29 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play416011054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 416011054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play416011055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1148"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos1148 = var_226_0.localPosition
				var_226_0.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("1148", 7)

				local var_226_2 = var_226_0.childCount

				for iter_226_0 = 0, var_226_2 - 1 do
					local var_226_3 = var_226_0:GetChild(iter_226_0)

					if var_226_3.name == "" or not string.find(var_226_3.name, "split") then
						var_226_3.gameObject:SetActive(true)
					else
						var_226_3.gameObject:SetActive(false)
					end
				end
			end

			local var_226_4 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_4 then
				local var_226_5 = (arg_223_1.time_ - var_226_1) / var_226_4
				local var_226_6 = Vector3.New(0, -2000, 0)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1148, var_226_6, var_226_5)
			end

			if arg_223_1.time_ >= var_226_1 + var_226_4 and arg_223_1.time_ < var_226_1 + var_226_4 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_226_7 = 0
			local var_226_8 = 1.35

			if var_226_7 < arg_223_1.time_ and arg_223_1.time_ <= var_226_7 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_9 = arg_223_1:GetWordFromCfg(416011054)
				local var_226_10 = arg_223_1:FormatText(var_226_9.content)

				arg_223_1.text_.text = var_226_10

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 54
				local var_226_12 = utf8.len(var_226_10)
				local var_226_13 = var_226_11 <= 0 and var_226_8 or var_226_8 * (var_226_12 / var_226_11)

				if var_226_13 > 0 and var_226_8 < var_226_13 then
					arg_223_1.talkMaxDuration = var_226_13

					if var_226_13 + var_226_7 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_13 + var_226_7
					end
				end

				arg_223_1.text_.text = var_226_10
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_14 = math.max(var_226_8, arg_223_1.talkMaxDuration)

			if var_226_7 <= arg_223_1.time_ and arg_223_1.time_ < var_226_7 + var_226_14 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_7) / var_226_14

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_7 + var_226_14 and arg_223_1.time_ < var_226_7 + var_226_14 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play416011055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 416011055
		arg_227_1.duration_ = 8.67

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play416011056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = "I14f"

			if arg_227_1.bgs_[var_230_0] == nil then
				local var_230_1 = Object.Instantiate(arg_227_1.paintGo_)

				var_230_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_230_0)
				var_230_1.name = var_230_0
				var_230_1.transform.parent = arg_227_1.stage_.transform
				var_230_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.bgs_[var_230_0] = var_230_1
			end

			local var_230_2 = 2.03333333333333

			if var_230_2 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				local var_230_3 = manager.ui.mainCamera.transform.localPosition
				local var_230_4 = Vector3.New(0, 0, 10) + Vector3.New(var_230_3.x, var_230_3.y, 0)
				local var_230_5 = arg_227_1.bgs_.I14f

				var_230_5.transform.localPosition = var_230_4
				var_230_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_230_6 = var_230_5:GetComponent("SpriteRenderer")

				if var_230_6 and var_230_6.sprite then
					local var_230_7 = (var_230_5.transform.localPosition - var_230_3).z
					local var_230_8 = manager.ui.mainCameraCom_
					local var_230_9 = 2 * var_230_7 * Mathf.Tan(var_230_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_230_10 = var_230_9 * var_230_8.aspect
					local var_230_11 = var_230_6.sprite.bounds.size.x
					local var_230_12 = var_230_6.sprite.bounds.size.y
					local var_230_13 = var_230_10 / var_230_11
					local var_230_14 = var_230_9 / var_230_12
					local var_230_15 = var_230_14 < var_230_13 and var_230_13 or var_230_14

					var_230_5.transform.localScale = Vector3.New(var_230_15, var_230_15, 0)
				end

				for iter_230_0, iter_230_1 in pairs(arg_227_1.bgs_) do
					if iter_230_0 ~= "I14f" then
						iter_230_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_230_16 = 0

			if var_230_16 < arg_227_1.time_ and arg_227_1.time_ <= var_230_16 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_17 = 2.03333333333333

			if var_230_16 <= arg_227_1.time_ and arg_227_1.time_ < var_230_16 + var_230_17 then
				local var_230_18 = (arg_227_1.time_ - var_230_16) / var_230_17
				local var_230_19 = Color.New(0, 0, 0)

				var_230_19.a = Mathf.Lerp(0, 1, var_230_18)
				arg_227_1.mask_.color = var_230_19
			end

			if arg_227_1.time_ >= var_230_16 + var_230_17 and arg_227_1.time_ < var_230_16 + var_230_17 + arg_230_0 then
				local var_230_20 = Color.New(0, 0, 0)

				var_230_20.a = 1
				arg_227_1.mask_.color = var_230_20
			end

			local var_230_21 = 2.03333333333333

			if var_230_21 < arg_227_1.time_ and arg_227_1.time_ <= var_230_21 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_22 = 2

			if var_230_21 <= arg_227_1.time_ and arg_227_1.time_ < var_230_21 + var_230_22 then
				local var_230_23 = (arg_227_1.time_ - var_230_21) / var_230_22
				local var_230_24 = Color.New(0, 0, 0)

				var_230_24.a = Mathf.Lerp(1, 0, var_230_23)
				arg_227_1.mask_.color = var_230_24
			end

			if arg_227_1.time_ >= var_230_21 + var_230_22 and arg_227_1.time_ < var_230_21 + var_230_22 + arg_230_0 then
				local var_230_25 = Color.New(0, 0, 0)
				local var_230_26 = 0

				arg_227_1.mask_.enabled = false
				var_230_25.a = var_230_26
				arg_227_1.mask_.color = var_230_25
			end

			local var_230_27 = 1.63333333333333
			local var_230_28 = 1

			if var_230_27 < arg_227_1.time_ and arg_227_1.time_ <= var_230_27 + arg_230_0 then
				local var_230_29 = "play"
				local var_230_30 = "effect"

				arg_227_1:AudioAction(var_230_29, var_230_30, "se_story_121_04", "se_story_121_04_aerobat", "")
			end

			local var_230_31 = 0
			local var_230_32 = 0.2

			if var_230_31 < arg_227_1.time_ and arg_227_1.time_ <= var_230_31 + arg_230_0 then
				local var_230_33 = "play"
				local var_230_34 = "music"

				arg_227_1:AudioAction(var_230_33, var_230_34, "ui_battle", "ui_battle_stopbgm", "")

				local var_230_35 = ""
				local var_230_36 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_230_36 ~= "" then
					if arg_227_1.bgmTxt_.text ~= var_230_36 and arg_227_1.bgmTxt_.text ~= "" then
						if arg_227_1.bgmTxt2_.text ~= "" then
							arg_227_1.bgmTxt_.text = arg_227_1.bgmTxt2_.text
						end

						arg_227_1.bgmTxt2_.text = var_230_36

						arg_227_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_227_1.bgmTxt_.text = var_230_36
						arg_227_1.bgmTxt2_.text = var_230_36
					end

					if arg_227_1.bgmTimer then
						arg_227_1.bgmTimer:Stop()

						arg_227_1.bgmTimer = nil
					end

					if arg_227_1.settingData.show_music_name == 1 then
						arg_227_1.musicController:SetSelectedState("show")
						arg_227_1.musicAnimator_:Play("open", 0, 0)

						if arg_227_1.settingData.music_time ~= 0 then
							arg_227_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_227_1.settingData.music_time), function()
								if arg_227_1 == nil or isNil(arg_227_1.bgmTxt_) then
									return
								end

								arg_227_1.musicController:SetSelectedState("hide")
								arg_227_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_230_37 = 1.33333333333333
			local var_230_38 = 1

			if var_230_37 < arg_227_1.time_ and arg_227_1.time_ <= var_230_37 + arg_230_0 then
				local var_230_39 = "play"
				local var_230_40 = "music"

				arg_227_1:AudioAction(var_230_39, var_230_40, "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village.awb")

				local var_230_41 = ""
				local var_230_42 = manager.audio:GetAudioName("bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village")

				if var_230_42 ~= "" then
					if arg_227_1.bgmTxt_.text ~= var_230_42 and arg_227_1.bgmTxt_.text ~= "" then
						if arg_227_1.bgmTxt2_.text ~= "" then
							arg_227_1.bgmTxt_.text = arg_227_1.bgmTxt2_.text
						end

						arg_227_1.bgmTxt2_.text = var_230_42

						arg_227_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_227_1.bgmTxt_.text = var_230_42
						arg_227_1.bgmTxt2_.text = var_230_42
					end

					if arg_227_1.bgmTimer then
						arg_227_1.bgmTimer:Stop()

						arg_227_1.bgmTimer = nil
					end

					if arg_227_1.settingData.show_music_name == 1 then
						arg_227_1.musicController:SetSelectedState("show")
						arg_227_1.musicAnimator_:Play("open", 0, 0)

						if arg_227_1.settingData.music_time ~= 0 then
							arg_227_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_227_1.settingData.music_time), function()
								if arg_227_1 == nil or isNil(arg_227_1.bgmTxt_) then
									return
								end

								arg_227_1.musicController:SetSelectedState("hide")
								arg_227_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_227_1.frameCnt_ <= 1 then
				arg_227_1.dialog_:SetActive(false)
			end

			local var_230_43 = 3.66666666666667
			local var_230_44 = 1.675

			if var_230_43 < arg_227_1.time_ and arg_227_1.time_ <= var_230_43 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0

				arg_227_1.dialog_:SetActive(true)

				arg_227_1.dialogCg_.alpha = 0

				local var_230_45 = LeanTween.value(arg_227_1.dialog_, 0, 1, 0.3)

				var_230_45:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_227_1.dialogCg_.alpha = arg_233_0
				end))
				var_230_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_227_1.dialog_)
					var_230_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_227_1.duration_ = arg_227_1.duration_ + 0.3

				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_46 = arg_227_1:GetWordFromCfg(416011055)
				local var_230_47 = arg_227_1:FormatText(var_230_46.content)

				arg_227_1.text_.text = var_230_47

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_48 = 67
				local var_230_49 = utf8.len(var_230_47)
				local var_230_50 = var_230_48 <= 0 and var_230_44 or var_230_44 * (var_230_49 / var_230_48)

				if var_230_50 > 0 and var_230_44 < var_230_50 then
					arg_227_1.talkMaxDuration = var_230_50
					var_230_43 = var_230_43 + 0.3

					if var_230_50 + var_230_43 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_50 + var_230_43
					end
				end

				arg_227_1.text_.text = var_230_47
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_51 = var_230_43 + 0.3
			local var_230_52 = math.max(var_230_44, arg_227_1.talkMaxDuration)

			if var_230_51 <= arg_227_1.time_ and arg_227_1.time_ < var_230_51 + var_230_52 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_51) / var_230_52

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_51 + var_230_52 and arg_227_1.time_ < var_230_51 + var_230_52 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play416011056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 416011056
		arg_235_1.duration_ = 4.1

		local var_235_0 = {
			zh = 2.2,
			ja = 4.1
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play416011057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = manager.ui.mainCamera.transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				local var_238_2 = arg_235_1.var_.effect1055

				if var_238_2 then
					Object.Destroy(var_238_2)

					arg_235_1.var_.effect1055 = nil
				end
			end

			local var_238_3 = 0.25
			local var_238_4 = 0.75

			if var_238_3 < arg_235_1.time_ and arg_235_1.time_ <= var_238_3 + arg_238_0 then
				local var_238_5 = "stop"
				local var_238_6 = "effect"

				arg_235_1:AudioAction(var_238_5, var_238_6, "se_story_121_04", "se_story_121_04_aerobat", "")
			end

			local var_238_7 = 0
			local var_238_8 = 0.25

			if var_238_7 < arg_235_1.time_ and arg_235_1.time_ <= var_238_7 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_9 = arg_235_1:FormatText(StoryNameCfg[327].name)

				arg_235_1.leftNameTxt_.text = var_238_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_6")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_10 = arg_235_1:GetWordFromCfg(416011056)
				local var_238_11 = arg_235_1:FormatText(var_238_10.content)

				arg_235_1.text_.text = var_238_11

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_12 = 10
				local var_238_13 = utf8.len(var_238_11)
				local var_238_14 = var_238_12 <= 0 and var_238_8 or var_238_8 * (var_238_13 / var_238_12)

				if var_238_14 > 0 and var_238_8 < var_238_14 then
					arg_235_1.talkMaxDuration = var_238_14

					if var_238_14 + var_238_7 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_14 + var_238_7
					end
				end

				arg_235_1.text_.text = var_238_11
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011056", "story_v_out_416011.awb") ~= 0 then
					local var_238_15 = manager.audio:GetVoiceLength("story_v_out_416011", "416011056", "story_v_out_416011.awb") / 1000

					if var_238_15 + var_238_7 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_15 + var_238_7
					end

					if var_238_10.prefab_name ~= "" and arg_235_1.actors_[var_238_10.prefab_name] ~= nil then
						local var_238_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_10.prefab_name].transform, "story_v_out_416011", "416011056", "story_v_out_416011.awb")

						arg_235_1:RecordAudio("416011056", var_238_16)
						arg_235_1:RecordAudio("416011056", var_238_16)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_416011", "416011056", "story_v_out_416011.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_416011", "416011056", "story_v_out_416011.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_17 = math.max(var_238_8, arg_235_1.talkMaxDuration)

			if var_238_7 <= arg_235_1.time_ and arg_235_1.time_ < var_238_7 + var_238_17 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_7) / var_238_17

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_7 + var_238_17 and arg_235_1.time_ < var_238_7 + var_238_17 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play416011057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 416011057
		arg_239_1.duration_ = 6.67

		local var_239_0 = {
			zh = 3.266,
			ja = 6.666
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
				arg_239_0:Play416011058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.35

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[585].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:GetWordFromCfg(416011057)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 14
				local var_242_6 = utf8.len(var_242_4)
				local var_242_7 = var_242_5 <= 0 and var_242_1 or var_242_1 * (var_242_6 / var_242_5)

				if var_242_7 > 0 and var_242_1 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011057", "story_v_out_416011.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011057", "story_v_out_416011.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_416011", "416011057", "story_v_out_416011.awb")

						arg_239_1:RecordAudio("416011057", var_242_9)
						arg_239_1:RecordAudio("416011057", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_416011", "416011057", "story_v_out_416011.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_416011", "416011057", "story_v_out_416011.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_10 and arg_239_1.time_ < var_242_0 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play416011058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 416011058
		arg_243_1.duration_ = 11.6

		local var_243_0 = {
			zh = 9.233,
			ja = 11.6
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
				arg_243_0:Play416011059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 1

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				local var_246_2 = "play"
				local var_246_3 = "effect"

				arg_243_1:AudioAction(var_246_2, var_246_3, "se_story_138", "se_story_138_engine", "")
			end

			local var_246_4 = 0
			local var_246_5 = 0.675

			if var_246_4 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_6 = arg_243_1:FormatText(StoryNameCfg[327].name)

				arg_243_1.leftNameTxt_.text = var_246_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_6")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_7 = arg_243_1:GetWordFromCfg(416011058)
				local var_246_8 = arg_243_1:FormatText(var_246_7.content)

				arg_243_1.text_.text = var_246_8

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_9 = 27
				local var_246_10 = utf8.len(var_246_8)
				local var_246_11 = var_246_9 <= 0 and var_246_5 or var_246_5 * (var_246_10 / var_246_9)

				if var_246_11 > 0 and var_246_5 < var_246_11 then
					arg_243_1.talkMaxDuration = var_246_11

					if var_246_11 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_11 + var_246_4
					end
				end

				arg_243_1.text_.text = var_246_8
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011058", "story_v_out_416011.awb") ~= 0 then
					local var_246_12 = manager.audio:GetVoiceLength("story_v_out_416011", "416011058", "story_v_out_416011.awb") / 1000

					if var_246_12 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_12 + var_246_4
					end

					if var_246_7.prefab_name ~= "" and arg_243_1.actors_[var_246_7.prefab_name] ~= nil then
						local var_246_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_7.prefab_name].transform, "story_v_out_416011", "416011058", "story_v_out_416011.awb")

						arg_243_1:RecordAudio("416011058", var_246_13)
						arg_243_1:RecordAudio("416011058", var_246_13)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_416011", "416011058", "story_v_out_416011.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_416011", "416011058", "story_v_out_416011.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_14 = math.max(var_246_5, arg_243_1.talkMaxDuration)

			if var_246_4 <= arg_243_1.time_ and arg_243_1.time_ < var_246_4 + var_246_14 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_4) / var_246_14

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_4 + var_246_14 and arg_243_1.time_ < var_246_4 + var_246_14 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play416011059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 416011059
		arg_247_1.duration_ = 3.6

		local var_247_0 = {
			zh = 3.066,
			ja = 3.6
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
				arg_247_0:Play416011060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = "10121"

			if arg_247_1.actors_[var_250_0] == nil then
				local var_250_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10121")

				if not isNil(var_250_1) then
					local var_250_2 = Object.Instantiate(var_250_1, arg_247_1.canvasGo_.transform)

					var_250_2.transform:SetSiblingIndex(1)

					var_250_2.name = var_250_0
					var_250_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_247_1.actors_[var_250_0] = var_250_2

					local var_250_3 = var_250_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_247_1.isInRecall_ then
						for iter_250_0, iter_250_1 in ipairs(var_250_3) do
							iter_250_1.color = arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_250_4 = arg_247_1.actors_["10121"].transform
			local var_250_5 = 0

			if var_250_5 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 then
				arg_247_1.var_.moveOldPos10121 = var_250_4.localPosition
				var_250_4.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10121", 3)

				local var_250_6 = var_250_4.childCount

				for iter_250_2 = 0, var_250_6 - 1 do
					local var_250_7 = var_250_4:GetChild(iter_250_2)

					if var_250_7.name == "" or not string.find(var_250_7.name, "split") then
						var_250_7.gameObject:SetActive(true)
					else
						var_250_7.gameObject:SetActive(false)
					end
				end
			end

			local var_250_8 = 0.001

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_8 then
				local var_250_9 = (arg_247_1.time_ - var_250_5) / var_250_8
				local var_250_10 = Vector3.New(0, -260.5, -275)

				var_250_4.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10121, var_250_10, var_250_9)
			end

			if arg_247_1.time_ >= var_250_5 + var_250_8 and arg_247_1.time_ < var_250_5 + var_250_8 + arg_250_0 then
				var_250_4.localPosition = Vector3.New(0, -260.5, -275)
			end

			local var_250_11 = arg_247_1.actors_["10121"]
			local var_250_12 = 0

			if var_250_12 < arg_247_1.time_ and arg_247_1.time_ <= var_250_12 + arg_250_0 and not isNil(var_250_11) and arg_247_1.var_.actorSpriteComps10121 == nil then
				arg_247_1.var_.actorSpriteComps10121 = var_250_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_13 = 2

			if var_250_12 <= arg_247_1.time_ and arg_247_1.time_ < var_250_12 + var_250_13 and not isNil(var_250_11) then
				local var_250_14 = (arg_247_1.time_ - var_250_12) / var_250_13

				if arg_247_1.var_.actorSpriteComps10121 then
					for iter_250_3, iter_250_4 in pairs(arg_247_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_250_4 then
							if arg_247_1.isInRecall_ then
								local var_250_15 = Mathf.Lerp(iter_250_4.color.r, arg_247_1.hightColor1.r, var_250_14)
								local var_250_16 = Mathf.Lerp(iter_250_4.color.g, arg_247_1.hightColor1.g, var_250_14)
								local var_250_17 = Mathf.Lerp(iter_250_4.color.b, arg_247_1.hightColor1.b, var_250_14)

								iter_250_4.color = Color.New(var_250_15, var_250_16, var_250_17)
							else
								local var_250_18 = Mathf.Lerp(iter_250_4.color.r, 1, var_250_14)

								iter_250_4.color = Color.New(var_250_18, var_250_18, var_250_18)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_12 + var_250_13 and arg_247_1.time_ < var_250_12 + var_250_13 + arg_250_0 and not isNil(var_250_11) and arg_247_1.var_.actorSpriteComps10121 then
				for iter_250_5, iter_250_6 in pairs(arg_247_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_250_6 then
						if arg_247_1.isInRecall_ then
							iter_250_6.color = arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_250_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps10121 = nil
			end

			local var_250_19 = 0
			local var_250_20 = 0.375

			if var_250_19 < arg_247_1.time_ and arg_247_1.time_ <= var_250_19 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_21 = arg_247_1:FormatText(StoryNameCfg[1081].name)

				arg_247_1.leftNameTxt_.text = var_250_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_22 = arg_247_1:GetWordFromCfg(416011059)
				local var_250_23 = arg_247_1:FormatText(var_250_22.content)

				arg_247_1.text_.text = var_250_23

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_24 = 15
				local var_250_25 = utf8.len(var_250_23)
				local var_250_26 = var_250_24 <= 0 and var_250_20 or var_250_20 * (var_250_25 / var_250_24)

				if var_250_26 > 0 and var_250_20 < var_250_26 then
					arg_247_1.talkMaxDuration = var_250_26

					if var_250_26 + var_250_19 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_26 + var_250_19
					end
				end

				arg_247_1.text_.text = var_250_23
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011059", "story_v_out_416011.awb") ~= 0 then
					local var_250_27 = manager.audio:GetVoiceLength("story_v_out_416011", "416011059", "story_v_out_416011.awb") / 1000

					if var_250_27 + var_250_19 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_27 + var_250_19
					end

					if var_250_22.prefab_name ~= "" and arg_247_1.actors_[var_250_22.prefab_name] ~= nil then
						local var_250_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_22.prefab_name].transform, "story_v_out_416011", "416011059", "story_v_out_416011.awb")

						arg_247_1:RecordAudio("416011059", var_250_28)
						arg_247_1:RecordAudio("416011059", var_250_28)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_416011", "416011059", "story_v_out_416011.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_416011", "416011059", "story_v_out_416011.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_29 = math.max(var_250_20, arg_247_1.talkMaxDuration)

			if var_250_19 <= arg_247_1.time_ and arg_247_1.time_ < var_250_19 + var_250_29 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_19) / var_250_29

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_19 + var_250_29 and arg_247_1.time_ < var_250_19 + var_250_29 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10121",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play416011060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 416011060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play416011061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10121"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10121 == nil then
				arg_251_1.var_.actorSpriteComps10121 = var_254_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_2 = 2

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.actorSpriteComps10121 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								local var_254_4 = Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor2.r, var_254_3)
								local var_254_5 = Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor2.g, var_254_3)
								local var_254_6 = Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor2.b, var_254_3)

								iter_254_1.color = Color.New(var_254_4, var_254_5, var_254_6)
							else
								local var_254_7 = Mathf.Lerp(iter_254_1.color.r, 0.5, var_254_3)

								iter_254_1.color = Color.New(var_254_7, var_254_7, var_254_7)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10121 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_254_3 then
						if arg_251_1.isInRecall_ then
							iter_254_3.color = arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_254_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps10121 = nil
			end

			local var_254_8 = 0
			local var_254_9 = 1.7

			if var_254_8 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_10 = arg_251_1:GetWordFromCfg(416011060)
				local var_254_11 = arg_251_1:FormatText(var_254_10.content)

				arg_251_1.text_.text = var_254_11

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_12 = 68
				local var_254_13 = utf8.len(var_254_11)
				local var_254_14 = var_254_12 <= 0 and var_254_9 or var_254_9 * (var_254_13 / var_254_12)

				if var_254_14 > 0 and var_254_9 < var_254_14 then
					arg_251_1.talkMaxDuration = var_254_14

					if var_254_14 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_14 + var_254_8
					end
				end

				arg_251_1.text_.text = var_254_11
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_15 = math.max(var_254_9, arg_251_1.talkMaxDuration)

			if var_254_8 <= arg_251_1.time_ and arg_251_1.time_ < var_254_8 + var_254_15 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_8) / var_254_15

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_8 + var_254_15 and arg_251_1.time_ < var_254_8 + var_254_15 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play416011061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 416011061
		arg_255_1.duration_ = 10.13

		local var_255_0 = {
			zh = 6.166,
			ja = 10.133
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
				arg_255_0:Play416011062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = "1028"

			if arg_255_1.actors_[var_258_0] == nil then
				local var_258_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_258_1) then
					local var_258_2 = Object.Instantiate(var_258_1, arg_255_1.canvasGo_.transform)

					var_258_2.transform:SetSiblingIndex(1)

					var_258_2.name = var_258_0
					var_258_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_255_1.actors_[var_258_0] = var_258_2

					local var_258_3 = var_258_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_255_1.isInRecall_ then
						for iter_258_0, iter_258_1 in ipairs(var_258_3) do
							iter_258_1.color = arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_258_4 = arg_255_1.actors_["1028"].transform
			local var_258_5 = 0

			if var_258_5 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1.var_.moveOldPos1028 = var_258_4.localPosition
				var_258_4.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("1028", 4)

				local var_258_6 = var_258_4.childCount

				for iter_258_2 = 0, var_258_6 - 1 do
					local var_258_7 = var_258_4:GetChild(iter_258_2)

					if var_258_7.name == "split_2" or not string.find(var_258_7.name, "split") then
						var_258_7.gameObject:SetActive(true)
					else
						var_258_7.gameObject:SetActive(false)
					end
				end
			end

			local var_258_8 = 0.001

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_8 then
				local var_258_9 = (arg_255_1.time_ - var_258_5) / var_258_8
				local var_258_10 = Vector3.New(390, -402.7, -156.1)

				var_258_4.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1028, var_258_10, var_258_9)
			end

			if arg_255_1.time_ >= var_258_5 + var_258_8 and arg_255_1.time_ < var_258_5 + var_258_8 + arg_258_0 then
				var_258_4.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_258_11 = arg_255_1.actors_["1028"]
			local var_258_12 = 0

			if var_258_12 < arg_255_1.time_ and arg_255_1.time_ <= var_258_12 + arg_258_0 and not isNil(var_258_11) and arg_255_1.var_.actorSpriteComps1028 == nil then
				arg_255_1.var_.actorSpriteComps1028 = var_258_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_13 = 0.125

			if var_258_12 <= arg_255_1.time_ and arg_255_1.time_ < var_258_12 + var_258_13 and not isNil(var_258_11) then
				local var_258_14 = (arg_255_1.time_ - var_258_12) / var_258_13

				if arg_255_1.var_.actorSpriteComps1028 then
					for iter_258_3, iter_258_4 in pairs(arg_255_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_258_4 then
							if arg_255_1.isInRecall_ then
								local var_258_15 = Mathf.Lerp(iter_258_4.color.r, arg_255_1.hightColor1.r, var_258_14)
								local var_258_16 = Mathf.Lerp(iter_258_4.color.g, arg_255_1.hightColor1.g, var_258_14)
								local var_258_17 = Mathf.Lerp(iter_258_4.color.b, arg_255_1.hightColor1.b, var_258_14)

								iter_258_4.color = Color.New(var_258_15, var_258_16, var_258_17)
							else
								local var_258_18 = Mathf.Lerp(iter_258_4.color.r, 1, var_258_14)

								iter_258_4.color = Color.New(var_258_18, var_258_18, var_258_18)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_12 + var_258_13 and arg_255_1.time_ < var_258_12 + var_258_13 + arg_258_0 and not isNil(var_258_11) and arg_255_1.var_.actorSpriteComps1028 then
				for iter_258_5, iter_258_6 in pairs(arg_255_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_258_6 then
						if arg_255_1.isInRecall_ then
							iter_258_6.color = arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_258_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps1028 = nil
			end

			local var_258_19 = arg_255_1.actors_["10121"].transform
			local var_258_20 = 0

			if var_258_20 < arg_255_1.time_ and arg_255_1.time_ <= var_258_20 + arg_258_0 then
				arg_255_1.var_.moveOldPos10121 = var_258_19.localPosition
				var_258_19.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("10121", 2)

				local var_258_21 = var_258_19.childCount

				for iter_258_7 = 0, var_258_21 - 1 do
					local var_258_22 = var_258_19:GetChild(iter_258_7)

					if var_258_22.name == "" or not string.find(var_258_22.name, "split") then
						var_258_22.gameObject:SetActive(true)
					else
						var_258_22.gameObject:SetActive(false)
					end
				end
			end

			local var_258_23 = 0.001

			if var_258_20 <= arg_255_1.time_ and arg_255_1.time_ < var_258_20 + var_258_23 then
				local var_258_24 = (arg_255_1.time_ - var_258_20) / var_258_23
				local var_258_25 = Vector3.New(-390, -260.5, -275)

				var_258_19.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10121, var_258_25, var_258_24)
			end

			if arg_255_1.time_ >= var_258_20 + var_258_23 and arg_255_1.time_ < var_258_20 + var_258_23 + arg_258_0 then
				var_258_19.localPosition = Vector3.New(-390, -260.5, -275)
			end

			local var_258_26 = arg_255_1.actors_["10121"]
			local var_258_27 = 0

			if var_258_27 < arg_255_1.time_ and arg_255_1.time_ <= var_258_27 + arg_258_0 and not isNil(var_258_26) and arg_255_1.var_.actorSpriteComps10121 == nil then
				arg_255_1.var_.actorSpriteComps10121 = var_258_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_28 = 2

			if var_258_27 <= arg_255_1.time_ and arg_255_1.time_ < var_258_27 + var_258_28 and not isNil(var_258_26) then
				local var_258_29 = (arg_255_1.time_ - var_258_27) / var_258_28

				if arg_255_1.var_.actorSpriteComps10121 then
					for iter_258_8, iter_258_9 in pairs(arg_255_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_258_9 then
							if arg_255_1.isInRecall_ then
								local var_258_30 = Mathf.Lerp(iter_258_9.color.r, arg_255_1.hightColor2.r, var_258_29)
								local var_258_31 = Mathf.Lerp(iter_258_9.color.g, arg_255_1.hightColor2.g, var_258_29)
								local var_258_32 = Mathf.Lerp(iter_258_9.color.b, arg_255_1.hightColor2.b, var_258_29)

								iter_258_9.color = Color.New(var_258_30, var_258_31, var_258_32)
							else
								local var_258_33 = Mathf.Lerp(iter_258_9.color.r, 0.5, var_258_29)

								iter_258_9.color = Color.New(var_258_33, var_258_33, var_258_33)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_27 + var_258_28 and arg_255_1.time_ < var_258_27 + var_258_28 + arg_258_0 and not isNil(var_258_26) and arg_255_1.var_.actorSpriteComps10121 then
				for iter_258_10, iter_258_11 in pairs(arg_255_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_258_11 then
						if arg_255_1.isInRecall_ then
							iter_258_11.color = arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_258_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps10121 = nil
			end

			local var_258_34 = 0
			local var_258_35 = 0.725

			if var_258_34 < arg_255_1.time_ and arg_255_1.time_ <= var_258_34 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_36 = arg_255_1:FormatText(StoryNameCfg[327].name)

				arg_255_1.leftNameTxt_.text = var_258_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_37 = arg_255_1:GetWordFromCfg(416011061)
				local var_258_38 = arg_255_1:FormatText(var_258_37.content)

				arg_255_1.text_.text = var_258_38

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_39 = 29
				local var_258_40 = utf8.len(var_258_38)
				local var_258_41 = var_258_39 <= 0 and var_258_35 or var_258_35 * (var_258_40 / var_258_39)

				if var_258_41 > 0 and var_258_35 < var_258_41 then
					arg_255_1.talkMaxDuration = var_258_41

					if var_258_41 + var_258_34 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_41 + var_258_34
					end
				end

				arg_255_1.text_.text = var_258_38
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011061", "story_v_out_416011.awb") ~= 0 then
					local var_258_42 = manager.audio:GetVoiceLength("story_v_out_416011", "416011061", "story_v_out_416011.awb") / 1000

					if var_258_42 + var_258_34 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_42 + var_258_34
					end

					if var_258_37.prefab_name ~= "" and arg_255_1.actors_[var_258_37.prefab_name] ~= nil then
						local var_258_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_37.prefab_name].transform, "story_v_out_416011", "416011061", "story_v_out_416011.awb")

						arg_255_1:RecordAudio("416011061", var_258_43)
						arg_255_1:RecordAudio("416011061", var_258_43)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_416011", "416011061", "story_v_out_416011.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_416011", "416011061", "story_v_out_416011.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_44 = math.max(var_258_35, arg_255_1.talkMaxDuration)

			if var_258_34 <= arg_255_1.time_ and arg_255_1.time_ < var_258_34 + var_258_44 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_34) / var_258_44

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_34 + var_258_44 and arg_255_1.time_ < var_258_34 + var_258_44 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10121",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play416011062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 416011062
		arg_259_1.duration_ = 5.17

		local var_259_0 = {
			zh = 3.7,
			ja = 5.166
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
				arg_259_0:Play416011063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1028"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps1028 == nil then
				arg_259_1.var_.actorSpriteComps1028 = var_262_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_2 = 0.125

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.actorSpriteComps1028 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								local var_262_4 = Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor2.r, var_262_3)
								local var_262_5 = Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor2.g, var_262_3)
								local var_262_6 = Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor2.b, var_262_3)

								iter_262_1.color = Color.New(var_262_4, var_262_5, var_262_6)
							else
								local var_262_7 = Mathf.Lerp(iter_262_1.color.r, 0.5, var_262_3)

								iter_262_1.color = Color.New(var_262_7, var_262_7, var_262_7)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps1028 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_262_3 then
						if arg_259_1.isInRecall_ then
							iter_262_3.color = arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_262_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps1028 = nil
			end

			local var_262_8 = arg_259_1.actors_["10121"]
			local var_262_9 = 0

			if var_262_9 < arg_259_1.time_ and arg_259_1.time_ <= var_262_9 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.actorSpriteComps10121 == nil then
				arg_259_1.var_.actorSpriteComps10121 = var_262_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_10 = 0.125

			if var_262_9 <= arg_259_1.time_ and arg_259_1.time_ < var_262_9 + var_262_10 and not isNil(var_262_8) then
				local var_262_11 = (arg_259_1.time_ - var_262_9) / var_262_10

				if arg_259_1.var_.actorSpriteComps10121 then
					for iter_262_4, iter_262_5 in pairs(arg_259_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_262_5 then
							if arg_259_1.isInRecall_ then
								local var_262_12 = Mathf.Lerp(iter_262_5.color.r, arg_259_1.hightColor1.r, var_262_11)
								local var_262_13 = Mathf.Lerp(iter_262_5.color.g, arg_259_1.hightColor1.g, var_262_11)
								local var_262_14 = Mathf.Lerp(iter_262_5.color.b, arg_259_1.hightColor1.b, var_262_11)

								iter_262_5.color = Color.New(var_262_12, var_262_13, var_262_14)
							else
								local var_262_15 = Mathf.Lerp(iter_262_5.color.r, 1, var_262_11)

								iter_262_5.color = Color.New(var_262_15, var_262_15, var_262_15)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= var_262_9 + var_262_10 and arg_259_1.time_ < var_262_9 + var_262_10 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.actorSpriteComps10121 then
				for iter_262_6, iter_262_7 in pairs(arg_259_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_262_7 then
						if arg_259_1.isInRecall_ then
							iter_262_7.color = arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_262_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps10121 = nil
			end

			local var_262_16 = 0
			local var_262_17 = 0.4

			if var_262_16 < arg_259_1.time_ and arg_259_1.time_ <= var_262_16 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_18 = arg_259_1:FormatText(StoryNameCfg[1081].name)

				arg_259_1.leftNameTxt_.text = var_262_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_19 = arg_259_1:GetWordFromCfg(416011062)
				local var_262_20 = arg_259_1:FormatText(var_262_19.content)

				arg_259_1.text_.text = var_262_20

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_21 = 16
				local var_262_22 = utf8.len(var_262_20)
				local var_262_23 = var_262_21 <= 0 and var_262_17 or var_262_17 * (var_262_22 / var_262_21)

				if var_262_23 > 0 and var_262_17 < var_262_23 then
					arg_259_1.talkMaxDuration = var_262_23

					if var_262_23 + var_262_16 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_23 + var_262_16
					end
				end

				arg_259_1.text_.text = var_262_20
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011062", "story_v_out_416011.awb") ~= 0 then
					local var_262_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011062", "story_v_out_416011.awb") / 1000

					if var_262_24 + var_262_16 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_24 + var_262_16
					end

					if var_262_19.prefab_name ~= "" and arg_259_1.actors_[var_262_19.prefab_name] ~= nil then
						local var_262_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_19.prefab_name].transform, "story_v_out_416011", "416011062", "story_v_out_416011.awb")

						arg_259_1:RecordAudio("416011062", var_262_25)
						arg_259_1:RecordAudio("416011062", var_262_25)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_416011", "416011062", "story_v_out_416011.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_416011", "416011062", "story_v_out_416011.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_26 = math.max(var_262_17, arg_259_1.talkMaxDuration)

			if var_262_16 <= arg_259_1.time_ and arg_259_1.time_ < var_262_16 + var_262_26 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_16) / var_262_26

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_16 + var_262_26 and arg_259_1.time_ < var_262_16 + var_262_26 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play416011063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 416011063
		arg_263_1.duration_ = 6.5

		local var_263_0 = {
			zh = 3.8,
			ja = 6.5
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play416011064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1028"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps1028 == nil then
				arg_263_1.var_.actorSpriteComps1028 = var_266_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_2 = 0.125

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.actorSpriteComps1028 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								local var_266_4 = Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor1.r, var_266_3)
								local var_266_5 = Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor1.g, var_266_3)
								local var_266_6 = Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor1.b, var_266_3)

								iter_266_1.color = Color.New(var_266_4, var_266_5, var_266_6)
							else
								local var_266_7 = Mathf.Lerp(iter_266_1.color.r, 1, var_266_3)

								iter_266_1.color = Color.New(var_266_7, var_266_7, var_266_7)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps1028 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_266_3 then
						if arg_263_1.isInRecall_ then
							iter_266_3.color = arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_266_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps1028 = nil
			end

			local var_266_8 = arg_263_1.actors_["10121"]
			local var_266_9 = 0

			if var_266_9 < arg_263_1.time_ and arg_263_1.time_ <= var_266_9 + arg_266_0 and not isNil(var_266_8) and arg_263_1.var_.actorSpriteComps10121 == nil then
				arg_263_1.var_.actorSpriteComps10121 = var_266_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_10 = 0.125

			if var_266_9 <= arg_263_1.time_ and arg_263_1.time_ < var_266_9 + var_266_10 and not isNil(var_266_8) then
				local var_266_11 = (arg_263_1.time_ - var_266_9) / var_266_10

				if arg_263_1.var_.actorSpriteComps10121 then
					for iter_266_4, iter_266_5 in pairs(arg_263_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_266_5 then
							if arg_263_1.isInRecall_ then
								local var_266_12 = Mathf.Lerp(iter_266_5.color.r, arg_263_1.hightColor2.r, var_266_11)
								local var_266_13 = Mathf.Lerp(iter_266_5.color.g, arg_263_1.hightColor2.g, var_266_11)
								local var_266_14 = Mathf.Lerp(iter_266_5.color.b, arg_263_1.hightColor2.b, var_266_11)

								iter_266_5.color = Color.New(var_266_12, var_266_13, var_266_14)
							else
								local var_266_15 = Mathf.Lerp(iter_266_5.color.r, 0.5, var_266_11)

								iter_266_5.color = Color.New(var_266_15, var_266_15, var_266_15)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_9 + var_266_10 and arg_263_1.time_ < var_266_9 + var_266_10 + arg_266_0 and not isNil(var_266_8) and arg_263_1.var_.actorSpriteComps10121 then
				for iter_266_6, iter_266_7 in pairs(arg_263_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_266_7 then
						if arg_263_1.isInRecall_ then
							iter_266_7.color = arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_266_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps10121 = nil
			end

			local var_266_16 = 0
			local var_266_17 = 0.45

			if var_266_16 < arg_263_1.time_ and arg_263_1.time_ <= var_266_16 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_18 = arg_263_1:FormatText(StoryNameCfg[327].name)

				arg_263_1.leftNameTxt_.text = var_266_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_19 = arg_263_1:GetWordFromCfg(416011063)
				local var_266_20 = arg_263_1:FormatText(var_266_19.content)

				arg_263_1.text_.text = var_266_20

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_21 = 18
				local var_266_22 = utf8.len(var_266_20)
				local var_266_23 = var_266_21 <= 0 and var_266_17 or var_266_17 * (var_266_22 / var_266_21)

				if var_266_23 > 0 and var_266_17 < var_266_23 then
					arg_263_1.talkMaxDuration = var_266_23

					if var_266_23 + var_266_16 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_16
					end
				end

				arg_263_1.text_.text = var_266_20
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011063", "story_v_out_416011.awb") ~= 0 then
					local var_266_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011063", "story_v_out_416011.awb") / 1000

					if var_266_24 + var_266_16 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_24 + var_266_16
					end

					if var_266_19.prefab_name ~= "" and arg_263_1.actors_[var_266_19.prefab_name] ~= nil then
						local var_266_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_19.prefab_name].transform, "story_v_out_416011", "416011063", "story_v_out_416011.awb")

						arg_263_1:RecordAudio("416011063", var_266_25)
						arg_263_1:RecordAudio("416011063", var_266_25)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_416011", "416011063", "story_v_out_416011.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_416011", "416011063", "story_v_out_416011.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_26 = math.max(var_266_17, arg_263_1.talkMaxDuration)

			if var_266_16 <= arg_263_1.time_ and arg_263_1.time_ < var_266_16 + var_266_26 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_16) / var_266_26

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_16 + var_266_26 and arg_263_1.time_ < var_266_16 + var_266_26 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play416011064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 416011064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play416011065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1028"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps1028 == nil then
				arg_267_1.var_.actorSpriteComps1028 = var_270_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_2 = 0.125

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.actorSpriteComps1028 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								local var_270_4 = Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor2.r, var_270_3)
								local var_270_5 = Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor2.g, var_270_3)
								local var_270_6 = Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor2.b, var_270_3)

								iter_270_1.color = Color.New(var_270_4, var_270_5, var_270_6)
							else
								local var_270_7 = Mathf.Lerp(iter_270_1.color.r, 0.5, var_270_3)

								iter_270_1.color = Color.New(var_270_7, var_270_7, var_270_7)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps1028 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_270_3 then
						if arg_267_1.isInRecall_ then
							iter_270_3.color = arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_270_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps1028 = nil
			end

			local var_270_8 = 0
			local var_270_9 = 1.525

			if var_270_8 < arg_267_1.time_ and arg_267_1.time_ <= var_270_8 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_10 = arg_267_1:GetWordFromCfg(416011064)
				local var_270_11 = arg_267_1:FormatText(var_270_10.content)

				arg_267_1.text_.text = var_270_11

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_12 = 61
				local var_270_13 = utf8.len(var_270_11)
				local var_270_14 = var_270_12 <= 0 and var_270_9 or var_270_9 * (var_270_13 / var_270_12)

				if var_270_14 > 0 and var_270_9 < var_270_14 then
					arg_267_1.talkMaxDuration = var_270_14

					if var_270_14 + var_270_8 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_14 + var_270_8
					end
				end

				arg_267_1.text_.text = var_270_11
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_15 = math.max(var_270_9, arg_267_1.talkMaxDuration)

			if var_270_8 <= arg_267_1.time_ and arg_267_1.time_ < var_270_8 + var_270_15 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_8) / var_270_15

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_8 + var_270_15 and arg_267_1.time_ < var_270_8 + var_270_15 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play416011065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 416011065
		arg_271_1.duration_ = 11.9

		local var_271_0 = {
			zh = 6.466,
			ja = 11.9
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
				arg_271_0:Play416011066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1028"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps1028 == nil then
				arg_271_1.var_.actorSpriteComps1028 = var_274_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_2 = 0.125

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.actorSpriteComps1028 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_274_1 then
							if arg_271_1.isInRecall_ then
								local var_274_4 = Mathf.Lerp(iter_274_1.color.r, arg_271_1.hightColor2.r, var_274_3)
								local var_274_5 = Mathf.Lerp(iter_274_1.color.g, arg_271_1.hightColor2.g, var_274_3)
								local var_274_6 = Mathf.Lerp(iter_274_1.color.b, arg_271_1.hightColor2.b, var_274_3)

								iter_274_1.color = Color.New(var_274_4, var_274_5, var_274_6)
							else
								local var_274_7 = Mathf.Lerp(iter_274_1.color.r, 0.5, var_274_3)

								iter_274_1.color = Color.New(var_274_7, var_274_7, var_274_7)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps1028 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_274_3 then
						if arg_271_1.isInRecall_ then
							iter_274_3.color = arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_274_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps1028 = nil
			end

			local var_274_8 = arg_271_1.actors_["10121"]
			local var_274_9 = 0

			if var_274_9 < arg_271_1.time_ and arg_271_1.time_ <= var_274_9 + arg_274_0 and not isNil(var_274_8) and arg_271_1.var_.actorSpriteComps10121 == nil then
				arg_271_1.var_.actorSpriteComps10121 = var_274_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_10 = 0.125

			if var_274_9 <= arg_271_1.time_ and arg_271_1.time_ < var_274_9 + var_274_10 and not isNil(var_274_8) then
				local var_274_11 = (arg_271_1.time_ - var_274_9) / var_274_10

				if arg_271_1.var_.actorSpriteComps10121 then
					for iter_274_4, iter_274_5 in pairs(arg_271_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_274_5 then
							if arg_271_1.isInRecall_ then
								local var_274_12 = Mathf.Lerp(iter_274_5.color.r, arg_271_1.hightColor1.r, var_274_11)
								local var_274_13 = Mathf.Lerp(iter_274_5.color.g, arg_271_1.hightColor1.g, var_274_11)
								local var_274_14 = Mathf.Lerp(iter_274_5.color.b, arg_271_1.hightColor1.b, var_274_11)

								iter_274_5.color = Color.New(var_274_12, var_274_13, var_274_14)
							else
								local var_274_15 = Mathf.Lerp(iter_274_5.color.r, 1, var_274_11)

								iter_274_5.color = Color.New(var_274_15, var_274_15, var_274_15)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_9 + var_274_10 and arg_271_1.time_ < var_274_9 + var_274_10 + arg_274_0 and not isNil(var_274_8) and arg_271_1.var_.actorSpriteComps10121 then
				for iter_274_6, iter_274_7 in pairs(arg_271_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_274_7 then
						if arg_271_1.isInRecall_ then
							iter_274_7.color = arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_274_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps10121 = nil
			end

			local var_274_16 = 0
			local var_274_17 = 0.825

			if var_274_16 < arg_271_1.time_ and arg_271_1.time_ <= var_274_16 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_18 = arg_271_1:FormatText(StoryNameCfg[1081].name)

				arg_271_1.leftNameTxt_.text = var_274_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_19 = arg_271_1:GetWordFromCfg(416011065)
				local var_274_20 = arg_271_1:FormatText(var_274_19.content)

				arg_271_1.text_.text = var_274_20

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_21 = 33
				local var_274_22 = utf8.len(var_274_20)
				local var_274_23 = var_274_21 <= 0 and var_274_17 or var_274_17 * (var_274_22 / var_274_21)

				if var_274_23 > 0 and var_274_17 < var_274_23 then
					arg_271_1.talkMaxDuration = var_274_23

					if var_274_23 + var_274_16 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_23 + var_274_16
					end
				end

				arg_271_1.text_.text = var_274_20
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011065", "story_v_out_416011.awb") ~= 0 then
					local var_274_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011065", "story_v_out_416011.awb") / 1000

					if var_274_24 + var_274_16 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_24 + var_274_16
					end

					if var_274_19.prefab_name ~= "" and arg_271_1.actors_[var_274_19.prefab_name] ~= nil then
						local var_274_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_19.prefab_name].transform, "story_v_out_416011", "416011065", "story_v_out_416011.awb")

						arg_271_1:RecordAudio("416011065", var_274_25)
						arg_271_1:RecordAudio("416011065", var_274_25)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_416011", "416011065", "story_v_out_416011.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_416011", "416011065", "story_v_out_416011.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_26 = math.max(var_274_17, arg_271_1.talkMaxDuration)

			if var_274_16 <= arg_271_1.time_ and arg_271_1.time_ < var_274_16 + var_274_26 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_16) / var_274_26

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_16 + var_274_26 and arg_271_1.time_ < var_274_16 + var_274_26 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play416011066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 416011066
		arg_275_1.duration_ = 5.07

		local var_275_0 = {
			zh = 1.8,
			ja = 5.066
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
				arg_275_0:Play416011067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1028"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps1028 == nil then
				arg_275_1.var_.actorSpriteComps1028 = var_278_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_2 = 0.125

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.actorSpriteComps1028 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								local var_278_4 = Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor1.r, var_278_3)
								local var_278_5 = Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor1.g, var_278_3)
								local var_278_6 = Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor1.b, var_278_3)

								iter_278_1.color = Color.New(var_278_4, var_278_5, var_278_6)
							else
								local var_278_7 = Mathf.Lerp(iter_278_1.color.r, 1, var_278_3)

								iter_278_1.color = Color.New(var_278_7, var_278_7, var_278_7)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps1028 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_278_3 then
						if arg_275_1.isInRecall_ then
							iter_278_3.color = arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_278_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps1028 = nil
			end

			local var_278_8 = arg_275_1.actors_["10121"]
			local var_278_9 = 0

			if var_278_9 < arg_275_1.time_ and arg_275_1.time_ <= var_278_9 + arg_278_0 and not isNil(var_278_8) and arg_275_1.var_.actorSpriteComps10121 == nil then
				arg_275_1.var_.actorSpriteComps10121 = var_278_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_10 = 0.125

			if var_278_9 <= arg_275_1.time_ and arg_275_1.time_ < var_278_9 + var_278_10 and not isNil(var_278_8) then
				local var_278_11 = (arg_275_1.time_ - var_278_9) / var_278_10

				if arg_275_1.var_.actorSpriteComps10121 then
					for iter_278_4, iter_278_5 in pairs(arg_275_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_278_5 then
							if arg_275_1.isInRecall_ then
								local var_278_12 = Mathf.Lerp(iter_278_5.color.r, arg_275_1.hightColor2.r, var_278_11)
								local var_278_13 = Mathf.Lerp(iter_278_5.color.g, arg_275_1.hightColor2.g, var_278_11)
								local var_278_14 = Mathf.Lerp(iter_278_5.color.b, arg_275_1.hightColor2.b, var_278_11)

								iter_278_5.color = Color.New(var_278_12, var_278_13, var_278_14)
							else
								local var_278_15 = Mathf.Lerp(iter_278_5.color.r, 0.5, var_278_11)

								iter_278_5.color = Color.New(var_278_15, var_278_15, var_278_15)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_9 + var_278_10 and arg_275_1.time_ < var_278_9 + var_278_10 + arg_278_0 and not isNil(var_278_8) and arg_275_1.var_.actorSpriteComps10121 then
				for iter_278_6, iter_278_7 in pairs(arg_275_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_278_7 then
						if arg_275_1.isInRecall_ then
							iter_278_7.color = arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_278_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps10121 = nil
			end

			local var_278_16 = 0
			local var_278_17 = 0.2

			if var_278_16 < arg_275_1.time_ and arg_275_1.time_ <= var_278_16 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_18 = arg_275_1:FormatText(StoryNameCfg[327].name)

				arg_275_1.leftNameTxt_.text = var_278_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_19 = arg_275_1:GetWordFromCfg(416011066)
				local var_278_20 = arg_275_1:FormatText(var_278_19.content)

				arg_275_1.text_.text = var_278_20

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_21 = 8
				local var_278_22 = utf8.len(var_278_20)
				local var_278_23 = var_278_21 <= 0 and var_278_17 or var_278_17 * (var_278_22 / var_278_21)

				if var_278_23 > 0 and var_278_17 < var_278_23 then
					arg_275_1.talkMaxDuration = var_278_23

					if var_278_23 + var_278_16 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_23 + var_278_16
					end
				end

				arg_275_1.text_.text = var_278_20
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011066", "story_v_out_416011.awb") ~= 0 then
					local var_278_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011066", "story_v_out_416011.awb") / 1000

					if var_278_24 + var_278_16 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_24 + var_278_16
					end

					if var_278_19.prefab_name ~= "" and arg_275_1.actors_[var_278_19.prefab_name] ~= nil then
						local var_278_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_19.prefab_name].transform, "story_v_out_416011", "416011066", "story_v_out_416011.awb")

						arg_275_1:RecordAudio("416011066", var_278_25)
						arg_275_1:RecordAudio("416011066", var_278_25)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_416011", "416011066", "story_v_out_416011.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_416011", "416011066", "story_v_out_416011.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_26 = math.max(var_278_17, arg_275_1.talkMaxDuration)

			if var_278_16 <= arg_275_1.time_ and arg_275_1.time_ < var_278_16 + var_278_26 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_16) / var_278_26

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_16 + var_278_26 and arg_275_1.time_ < var_278_16 + var_278_26 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play416011067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 416011067
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play416011068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1028"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos1028 = var_282_0.localPosition
				var_282_0.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("1028", 7)

				local var_282_2 = var_282_0.childCount

				for iter_282_0 = 0, var_282_2 - 1 do
					local var_282_3 = var_282_0:GetChild(iter_282_0)

					if var_282_3.name == "" or not string.find(var_282_3.name, "split") then
						var_282_3.gameObject:SetActive(true)
					else
						var_282_3.gameObject:SetActive(false)
					end
				end
			end

			local var_282_4 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_4 then
				local var_282_5 = (arg_279_1.time_ - var_282_1) / var_282_4
				local var_282_6 = Vector3.New(0, -2000, 0)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1028, var_282_6, var_282_5)
			end

			if arg_279_1.time_ >= var_282_1 + var_282_4 and arg_279_1.time_ < var_282_1 + var_282_4 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_282_7 = arg_279_1.actors_["10121"].transform
			local var_282_8 = 0

			if var_282_8 < arg_279_1.time_ and arg_279_1.time_ <= var_282_8 + arg_282_0 then
				arg_279_1.var_.moveOldPos10121 = var_282_7.localPosition
				var_282_7.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("10121", 7)

				local var_282_9 = var_282_7.childCount

				for iter_282_1 = 0, var_282_9 - 1 do
					local var_282_10 = var_282_7:GetChild(iter_282_1)

					if var_282_10.name == "" or not string.find(var_282_10.name, "split") then
						var_282_10.gameObject:SetActive(true)
					else
						var_282_10.gameObject:SetActive(false)
					end
				end
			end

			local var_282_11 = 0.001

			if var_282_8 <= arg_279_1.time_ and arg_279_1.time_ < var_282_8 + var_282_11 then
				local var_282_12 = (arg_279_1.time_ - var_282_8) / var_282_11
				local var_282_13 = Vector3.New(0, -2000, 0)

				var_282_7.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10121, var_282_13, var_282_12)
			end

			if arg_279_1.time_ >= var_282_8 + var_282_11 and arg_279_1.time_ < var_282_8 + var_282_11 + arg_282_0 then
				var_282_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_282_14 = 0
			local var_282_15 = 1.9

			if var_282_14 < arg_279_1.time_ and arg_279_1.time_ <= var_282_14 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_16 = arg_279_1:GetWordFromCfg(416011067)
				local var_282_17 = arg_279_1:FormatText(var_282_16.content)

				arg_279_1.text_.text = var_282_17

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_18 = 76
				local var_282_19 = utf8.len(var_282_17)
				local var_282_20 = var_282_18 <= 0 and var_282_15 or var_282_15 * (var_282_19 / var_282_18)

				if var_282_20 > 0 and var_282_15 < var_282_20 then
					arg_279_1.talkMaxDuration = var_282_20

					if var_282_20 + var_282_14 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_20 + var_282_14
					end
				end

				arg_279_1.text_.text = var_282_17
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_21 = math.max(var_282_15, arg_279_1.talkMaxDuration)

			if var_282_14 <= arg_279_1.time_ and arg_279_1.time_ < var_282_14 + var_282_21 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_14) / var_282_21

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_14 + var_282_21 and arg_279_1.time_ < var_282_14 + var_282_21 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10121",
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
	Play416011068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 416011068
		arg_283_1.duration_ = 5.23

		local var_283_0 = {
			zh = 2.833,
			ja = 5.233
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
				arg_283_0:Play416011069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0
			local var_286_1 = 0.275

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_2 = arg_283_1:FormatText(StoryNameCfg[1082].name)

				arg_283_1.leftNameTxt_.text = var_286_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_3 = arg_283_1:GetWordFromCfg(416011068)
				local var_286_4 = arg_283_1:FormatText(var_286_3.content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011068", "story_v_out_416011.awb") ~= 0 then
					local var_286_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011068", "story_v_out_416011.awb") / 1000

					if var_286_8 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_0
					end

					if var_286_3.prefab_name ~= "" and arg_283_1.actors_[var_286_3.prefab_name] ~= nil then
						local var_286_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_3.prefab_name].transform, "story_v_out_416011", "416011068", "story_v_out_416011.awb")

						arg_283_1:RecordAudio("416011068", var_286_9)
						arg_283_1:RecordAudio("416011068", var_286_9)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_416011", "416011068", "story_v_out_416011.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_416011", "416011068", "story_v_out_416011.awb")
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
	Play416011069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 416011069
		arg_287_1.duration_ = 4.1

		local var_287_0 = {
			zh = 4.1,
			ja = 3.533
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play416011070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1028"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps1028 == nil then
				arg_287_1.var_.actorSpriteComps1028 = var_290_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_2 = 0.125

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.actorSpriteComps1028 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_290_1 then
							if arg_287_1.isInRecall_ then
								local var_290_4 = Mathf.Lerp(iter_290_1.color.r, arg_287_1.hightColor1.r, var_290_3)
								local var_290_5 = Mathf.Lerp(iter_290_1.color.g, arg_287_1.hightColor1.g, var_290_3)
								local var_290_6 = Mathf.Lerp(iter_290_1.color.b, arg_287_1.hightColor1.b, var_290_3)

								iter_290_1.color = Color.New(var_290_4, var_290_5, var_290_6)
							else
								local var_290_7 = Mathf.Lerp(iter_290_1.color.r, 1, var_290_3)

								iter_290_1.color = Color.New(var_290_7, var_290_7, var_290_7)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps1028 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_290_3 then
						if arg_287_1.isInRecall_ then
							iter_290_3.color = arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_290_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps1028 = nil
			end

			local var_290_8 = arg_287_1.actors_["1028"].transform
			local var_290_9 = 0

			if var_290_9 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 then
				arg_287_1.var_.moveOldPos1028 = var_290_8.localPosition
				var_290_8.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("1028", 3)

				local var_290_10 = var_290_8.childCount

				for iter_290_4 = 0, var_290_10 - 1 do
					local var_290_11 = var_290_8:GetChild(iter_290_4)

					if var_290_11.name == "split_6" or not string.find(var_290_11.name, "split") then
						var_290_11.gameObject:SetActive(true)
					else
						var_290_11.gameObject:SetActive(false)
					end
				end
			end

			local var_290_12 = 0.001

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_12 then
				local var_290_13 = (arg_287_1.time_ - var_290_9) / var_290_12
				local var_290_14 = Vector3.New(0, -402.7, -156.1)

				var_290_8.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1028, var_290_14, var_290_13)
			end

			if arg_287_1.time_ >= var_290_9 + var_290_12 and arg_287_1.time_ < var_290_9 + var_290_12 + arg_290_0 then
				var_290_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_290_15 = 0
			local var_290_16 = 0.375

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_17 = arg_287_1:FormatText(StoryNameCfg[327].name)

				arg_287_1.leftNameTxt_.text = var_290_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_18 = arg_287_1:GetWordFromCfg(416011069)
				local var_290_19 = arg_287_1:FormatText(var_290_18.content)

				arg_287_1.text_.text = var_290_19

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_20 = 15
				local var_290_21 = utf8.len(var_290_19)
				local var_290_22 = var_290_20 <= 0 and var_290_16 or var_290_16 * (var_290_21 / var_290_20)

				if var_290_22 > 0 and var_290_16 < var_290_22 then
					arg_287_1.talkMaxDuration = var_290_22

					if var_290_22 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_22 + var_290_15
					end
				end

				arg_287_1.text_.text = var_290_19
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011069", "story_v_out_416011.awb") ~= 0 then
					local var_290_23 = manager.audio:GetVoiceLength("story_v_out_416011", "416011069", "story_v_out_416011.awb") / 1000

					if var_290_23 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_23 + var_290_15
					end

					if var_290_18.prefab_name ~= "" and arg_287_1.actors_[var_290_18.prefab_name] ~= nil then
						local var_290_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_18.prefab_name].transform, "story_v_out_416011", "416011069", "story_v_out_416011.awb")

						arg_287_1:RecordAudio("416011069", var_290_24)
						arg_287_1:RecordAudio("416011069", var_290_24)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_416011", "416011069", "story_v_out_416011.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_416011", "416011069", "story_v_out_416011.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_25 = math.max(var_290_16, arg_287_1.talkMaxDuration)

			if var_290_15 <= arg_287_1.time_ and arg_287_1.time_ < var_290_15 + var_290_25 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_15) / var_290_25

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_15 + var_290_25 and arg_287_1.time_ < var_290_15 + var_290_25 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play416011070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 416011070
		arg_291_1.duration_ = 5.2

		local var_291_0 = {
			zh = 3.766,
			ja = 5.2
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
				arg_291_0:Play416011071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1028"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1028 == nil then
				arg_291_1.var_.actorSpriteComps1028 = var_294_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_2 = 0.125

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.actorSpriteComps1028 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								local var_294_4 = Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor2.r, var_294_3)
								local var_294_5 = Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor2.g, var_294_3)
								local var_294_6 = Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor2.b, var_294_3)

								iter_294_1.color = Color.New(var_294_4, var_294_5, var_294_6)
							else
								local var_294_7 = Mathf.Lerp(iter_294_1.color.r, 0.5, var_294_3)

								iter_294_1.color = Color.New(var_294_7, var_294_7, var_294_7)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1028 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_294_3 then
						if arg_291_1.isInRecall_ then
							iter_294_3.color = arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_294_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps1028 = nil
			end

			local var_294_8 = 0
			local var_294_9 = 0.375

			if var_294_8 < arg_291_1.time_ and arg_291_1.time_ <= var_294_8 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_10 = arg_291_1:FormatText(StoryNameCfg[1082].name)

				arg_291_1.leftNameTxt_.text = var_294_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_11 = arg_291_1:GetWordFromCfg(416011070)
				local var_294_12 = arg_291_1:FormatText(var_294_11.content)

				arg_291_1.text_.text = var_294_12

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_13 = 15
				local var_294_14 = utf8.len(var_294_12)
				local var_294_15 = var_294_13 <= 0 and var_294_9 or var_294_9 * (var_294_14 / var_294_13)

				if var_294_15 > 0 and var_294_9 < var_294_15 then
					arg_291_1.talkMaxDuration = var_294_15

					if var_294_15 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_15 + var_294_8
					end
				end

				arg_291_1.text_.text = var_294_12
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011070", "story_v_out_416011.awb") ~= 0 then
					local var_294_16 = manager.audio:GetVoiceLength("story_v_out_416011", "416011070", "story_v_out_416011.awb") / 1000

					if var_294_16 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_16 + var_294_8
					end

					if var_294_11.prefab_name ~= "" and arg_291_1.actors_[var_294_11.prefab_name] ~= nil then
						local var_294_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_11.prefab_name].transform, "story_v_out_416011", "416011070", "story_v_out_416011.awb")

						arg_291_1:RecordAudio("416011070", var_294_17)
						arg_291_1:RecordAudio("416011070", var_294_17)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_416011", "416011070", "story_v_out_416011.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_416011", "416011070", "story_v_out_416011.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_18 = math.max(var_294_9, arg_291_1.talkMaxDuration)

			if var_294_8 <= arg_291_1.time_ and arg_291_1.time_ < var_294_8 + var_294_18 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_8) / var_294_18

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_8 + var_294_18 and arg_291_1.time_ < var_294_8 + var_294_18 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play416011071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 416011071
		arg_295_1.duration_ = 7.8

		local var_295_0 = {
			zh = 5,
			ja = 7.8
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play416011072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1028"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps1028 == nil then
				arg_295_1.var_.actorSpriteComps1028 = var_298_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_2 = 0.125

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.actorSpriteComps1028 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								local var_298_4 = Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor1.r, var_298_3)
								local var_298_5 = Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor1.g, var_298_3)
								local var_298_6 = Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor1.b, var_298_3)

								iter_298_1.color = Color.New(var_298_4, var_298_5, var_298_6)
							else
								local var_298_7 = Mathf.Lerp(iter_298_1.color.r, 1, var_298_3)

								iter_298_1.color = Color.New(var_298_7, var_298_7, var_298_7)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps1028 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_298_3 then
						if arg_295_1.isInRecall_ then
							iter_298_3.color = arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_298_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps1028 = nil
			end

			local var_298_8 = 0
			local var_298_9 = 0.6

			if var_298_8 < arg_295_1.time_ and arg_295_1.time_ <= var_298_8 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_10 = arg_295_1:FormatText(StoryNameCfg[327].name)

				arg_295_1.leftNameTxt_.text = var_298_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_11 = arg_295_1:GetWordFromCfg(416011071)
				local var_298_12 = arg_295_1:FormatText(var_298_11.content)

				arg_295_1.text_.text = var_298_12

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_13 = 24
				local var_298_14 = utf8.len(var_298_12)
				local var_298_15 = var_298_13 <= 0 and var_298_9 or var_298_9 * (var_298_14 / var_298_13)

				if var_298_15 > 0 and var_298_9 < var_298_15 then
					arg_295_1.talkMaxDuration = var_298_15

					if var_298_15 + var_298_8 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_15 + var_298_8
					end
				end

				arg_295_1.text_.text = var_298_12
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011071", "story_v_out_416011.awb") ~= 0 then
					local var_298_16 = manager.audio:GetVoiceLength("story_v_out_416011", "416011071", "story_v_out_416011.awb") / 1000

					if var_298_16 + var_298_8 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_16 + var_298_8
					end

					if var_298_11.prefab_name ~= "" and arg_295_1.actors_[var_298_11.prefab_name] ~= nil then
						local var_298_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_11.prefab_name].transform, "story_v_out_416011", "416011071", "story_v_out_416011.awb")

						arg_295_1:RecordAudio("416011071", var_298_17)
						arg_295_1:RecordAudio("416011071", var_298_17)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_416011", "416011071", "story_v_out_416011.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_416011", "416011071", "story_v_out_416011.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_18 = math.max(var_298_9, arg_295_1.talkMaxDuration)

			if var_298_8 <= arg_295_1.time_ and arg_295_1.time_ < var_298_8 + var_298_18 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_8) / var_298_18

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_8 + var_298_18 and arg_295_1.time_ < var_298_8 + var_298_18 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play416011072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 416011072
		arg_299_1.duration_ = 2.57

		local var_299_0 = {
			zh = 2.333,
			ja = 2.566
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
				arg_299_0:Play416011073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 0.2

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_2 = arg_299_1:FormatText(StoryNameCfg[327].name)

				arg_299_1.leftNameTxt_.text = var_302_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_3 = arg_299_1:GetWordFromCfg(416011072)
				local var_302_4 = arg_299_1:FormatText(var_302_3.content)

				arg_299_1.text_.text = var_302_4

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 8
				local var_302_6 = utf8.len(var_302_4)
				local var_302_7 = var_302_5 <= 0 and var_302_1 or var_302_1 * (var_302_6 / var_302_5)

				if var_302_7 > 0 and var_302_1 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_0
					end
				end

				arg_299_1.text_.text = var_302_4
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011072", "story_v_out_416011.awb") ~= 0 then
					local var_302_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011072", "story_v_out_416011.awb") / 1000

					if var_302_8 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_8 + var_302_0
					end

					if var_302_3.prefab_name ~= "" and arg_299_1.actors_[var_302_3.prefab_name] ~= nil then
						local var_302_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_3.prefab_name].transform, "story_v_out_416011", "416011072", "story_v_out_416011.awb")

						arg_299_1:RecordAudio("416011072", var_302_9)
						arg_299_1:RecordAudio("416011072", var_302_9)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_416011", "416011072", "story_v_out_416011.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_416011", "416011072", "story_v_out_416011.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_10 = math.max(var_302_1, arg_299_1.talkMaxDuration)

			if var_302_0 <= arg_299_1.time_ and arg_299_1.time_ < var_302_0 + var_302_10 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_0) / var_302_10

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_0 + var_302_10 and arg_299_1.time_ < var_302_0 + var_302_10 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play416011073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 416011073
		arg_303_1.duration_ = 8.97

		local var_303_0 = {
			zh = 4.9,
			ja = 8.966
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
				arg_303_0:Play416011074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1028"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps1028 == nil then
				arg_303_1.var_.actorSpriteComps1028 = var_306_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_2 = 0.125

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.actorSpriteComps1028 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_306_1 then
							if arg_303_1.isInRecall_ then
								local var_306_4 = Mathf.Lerp(iter_306_1.color.r, arg_303_1.hightColor2.r, var_306_3)
								local var_306_5 = Mathf.Lerp(iter_306_1.color.g, arg_303_1.hightColor2.g, var_306_3)
								local var_306_6 = Mathf.Lerp(iter_306_1.color.b, arg_303_1.hightColor2.b, var_306_3)

								iter_306_1.color = Color.New(var_306_4, var_306_5, var_306_6)
							else
								local var_306_7 = Mathf.Lerp(iter_306_1.color.r, 0.5, var_306_3)

								iter_306_1.color = Color.New(var_306_7, var_306_7, var_306_7)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps1028 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_306_3 then
						if arg_303_1.isInRecall_ then
							iter_306_3.color = arg_303_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_306_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps1028 = nil
			end

			local var_306_8 = 0
			local var_306_9 = 0.575

			if var_306_8 < arg_303_1.time_ and arg_303_1.time_ <= var_306_8 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_10 = arg_303_1:FormatText(StoryNameCfg[1082].name)

				arg_303_1.leftNameTxt_.text = var_306_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_11 = arg_303_1:GetWordFromCfg(416011073)
				local var_306_12 = arg_303_1:FormatText(var_306_11.content)

				arg_303_1.text_.text = var_306_12

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_13 = 23
				local var_306_14 = utf8.len(var_306_12)
				local var_306_15 = var_306_13 <= 0 and var_306_9 or var_306_9 * (var_306_14 / var_306_13)

				if var_306_15 > 0 and var_306_9 < var_306_15 then
					arg_303_1.talkMaxDuration = var_306_15

					if var_306_15 + var_306_8 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_15 + var_306_8
					end
				end

				arg_303_1.text_.text = var_306_12
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011073", "story_v_out_416011.awb") ~= 0 then
					local var_306_16 = manager.audio:GetVoiceLength("story_v_out_416011", "416011073", "story_v_out_416011.awb") / 1000

					if var_306_16 + var_306_8 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_16 + var_306_8
					end

					if var_306_11.prefab_name ~= "" and arg_303_1.actors_[var_306_11.prefab_name] ~= nil then
						local var_306_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_11.prefab_name].transform, "story_v_out_416011", "416011073", "story_v_out_416011.awb")

						arg_303_1:RecordAudio("416011073", var_306_17)
						arg_303_1:RecordAudio("416011073", var_306_17)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_416011", "416011073", "story_v_out_416011.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_416011", "416011073", "story_v_out_416011.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_18 = math.max(var_306_9, arg_303_1.talkMaxDuration)

			if var_306_8 <= arg_303_1.time_ and arg_303_1.time_ < var_306_8 + var_306_18 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_8) / var_306_18

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_8 + var_306_18 and arg_303_1.time_ < var_306_8 + var_306_18 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play416011074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 416011074
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play416011075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1028"].transform
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.var_.moveOldPos1028 = var_310_0.localPosition
				var_310_0.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("1028", 7)

				local var_310_2 = var_310_0.childCount

				for iter_310_0 = 0, var_310_2 - 1 do
					local var_310_3 = var_310_0:GetChild(iter_310_0)

					if var_310_3.name == "" or not string.find(var_310_3.name, "split") then
						var_310_3.gameObject:SetActive(true)
					else
						var_310_3.gameObject:SetActive(false)
					end
				end
			end

			local var_310_4 = 0.001

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_4 then
				local var_310_5 = (arg_307_1.time_ - var_310_1) / var_310_4
				local var_310_6 = Vector3.New(0, -2000, 0)

				var_310_0.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1028, var_310_6, var_310_5)
			end

			if arg_307_1.time_ >= var_310_1 + var_310_4 and arg_307_1.time_ < var_310_1 + var_310_4 + arg_310_0 then
				var_310_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_310_7 = 0
			local var_310_8 = 1.225

			if var_310_7 < arg_307_1.time_ and arg_307_1.time_ <= var_310_7 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_9 = arg_307_1:GetWordFromCfg(416011074)
				local var_310_10 = arg_307_1:FormatText(var_310_9.content)

				arg_307_1.text_.text = var_310_10

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_11 = 49
				local var_310_12 = utf8.len(var_310_10)
				local var_310_13 = var_310_11 <= 0 and var_310_8 or var_310_8 * (var_310_12 / var_310_11)

				if var_310_13 > 0 and var_310_8 < var_310_13 then
					arg_307_1.talkMaxDuration = var_310_13

					if var_310_13 + var_310_7 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_13 + var_310_7
					end
				end

				arg_307_1.text_.text = var_310_10
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_14 = math.max(var_310_8, arg_307_1.talkMaxDuration)

			if var_310_7 <= arg_307_1.time_ and arg_307_1.time_ < var_310_7 + var_310_14 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_7) / var_310_14

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_7 + var_310_14 and arg_307_1.time_ < var_310_7 + var_310_14 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
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
	Play416011075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 416011075
		arg_311_1.duration_ = 5.27

		local var_311_0 = {
			zh = 4.266,
			ja = 5.266
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
				arg_311_0:Play416011076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1028"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps1028 == nil then
				arg_311_1.var_.actorSpriteComps1028 = var_314_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_2 = 0.125

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.actorSpriteComps1028 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps1028 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_314_3 then
						if arg_311_1.isInRecall_ then
							iter_314_3.color = arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_314_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps1028 = nil
			end

			local var_314_8 = arg_311_1.actors_["1028"].transform
			local var_314_9 = 0

			if var_314_9 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 then
				arg_311_1.var_.moveOldPos1028 = var_314_8.localPosition
				var_314_8.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("1028", 3)

				local var_314_10 = var_314_8.childCount

				for iter_314_4 = 0, var_314_10 - 1 do
					local var_314_11 = var_314_8:GetChild(iter_314_4)

					if var_314_11.name == "split_6" or not string.find(var_314_11.name, "split") then
						var_314_11.gameObject:SetActive(true)
					else
						var_314_11.gameObject:SetActive(false)
					end
				end
			end

			local var_314_12 = 0.001

			if var_314_9 <= arg_311_1.time_ and arg_311_1.time_ < var_314_9 + var_314_12 then
				local var_314_13 = (arg_311_1.time_ - var_314_9) / var_314_12
				local var_314_14 = Vector3.New(0, -402.7, -156.1)

				var_314_8.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1028, var_314_14, var_314_13)
			end

			if arg_311_1.time_ >= var_314_9 + var_314_12 and arg_311_1.time_ < var_314_9 + var_314_12 + arg_314_0 then
				var_314_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_314_15 = 0
			local var_314_16 = 0.55

			if var_314_15 < arg_311_1.time_ and arg_311_1.time_ <= var_314_15 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_17 = arg_311_1:FormatText(StoryNameCfg[327].name)

				arg_311_1.leftNameTxt_.text = var_314_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_18 = arg_311_1:GetWordFromCfg(416011075)
				local var_314_19 = arg_311_1:FormatText(var_314_18.content)

				arg_311_1.text_.text = var_314_19

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_20 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011075", "story_v_out_416011.awb") ~= 0 then
					local var_314_23 = manager.audio:GetVoiceLength("story_v_out_416011", "416011075", "story_v_out_416011.awb") / 1000

					if var_314_23 + var_314_15 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_23 + var_314_15
					end

					if var_314_18.prefab_name ~= "" and arg_311_1.actors_[var_314_18.prefab_name] ~= nil then
						local var_314_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_18.prefab_name].transform, "story_v_out_416011", "416011075", "story_v_out_416011.awb")

						arg_311_1:RecordAudio("416011075", var_314_24)
						arg_311_1:RecordAudio("416011075", var_314_24)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_416011", "416011075", "story_v_out_416011.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_416011", "416011075", "story_v_out_416011.awb")
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
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play416011076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 416011076
		arg_315_1.duration_ = 10.97

		local var_315_0 = {
			zh = 8.766,
			ja = 10.966
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
				arg_315_0:Play416011077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1028"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps1028 == nil then
				arg_315_1.var_.actorSpriteComps1028 = var_318_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_2 = 0.125

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.actorSpriteComps1028 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps1028 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_318_3 then
						if arg_315_1.isInRecall_ then
							iter_318_3.color = arg_315_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_318_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps1028 = nil
			end

			local var_318_8 = 0
			local var_318_9 = 1.05

			if var_318_8 < arg_315_1.time_ and arg_315_1.time_ <= var_318_8 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_10 = arg_315_1:FormatText(StoryNameCfg[1082].name)

				arg_315_1.leftNameTxt_.text = var_318_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_11 = arg_315_1:GetWordFromCfg(416011076)
				local var_318_12 = arg_315_1:FormatText(var_318_11.content)

				arg_315_1.text_.text = var_318_12

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_13 = 42
				local var_318_14 = utf8.len(var_318_12)
				local var_318_15 = var_318_13 <= 0 and var_318_9 or var_318_9 * (var_318_14 / var_318_13)

				if var_318_15 > 0 and var_318_9 < var_318_15 then
					arg_315_1.talkMaxDuration = var_318_15

					if var_318_15 + var_318_8 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_15 + var_318_8
					end
				end

				arg_315_1.text_.text = var_318_12
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011076", "story_v_out_416011.awb") ~= 0 then
					local var_318_16 = manager.audio:GetVoiceLength("story_v_out_416011", "416011076", "story_v_out_416011.awb") / 1000

					if var_318_16 + var_318_8 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_16 + var_318_8
					end

					if var_318_11.prefab_name ~= "" and arg_315_1.actors_[var_318_11.prefab_name] ~= nil then
						local var_318_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_11.prefab_name].transform, "story_v_out_416011", "416011076", "story_v_out_416011.awb")

						arg_315_1:RecordAudio("416011076", var_318_17)
						arg_315_1:RecordAudio("416011076", var_318_17)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_416011", "416011076", "story_v_out_416011.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_416011", "416011076", "story_v_out_416011.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_18 = math.max(var_318_9, arg_315_1.talkMaxDuration)

			if var_318_8 <= arg_315_1.time_ and arg_315_1.time_ < var_318_8 + var_318_18 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_8) / var_318_18

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_8 + var_318_18 and arg_315_1.time_ < var_318_8 + var_318_18 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play416011077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 416011077
		arg_319_1.duration_ = 6.03

		local var_319_0 = {
			zh = 5.566,
			ja = 6.033
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
				arg_319_0:Play416011078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1028"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps1028 == nil then
				arg_319_1.var_.actorSpriteComps1028 = var_322_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_2 = 0.125

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.actorSpriteComps1028 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								local var_322_4 = Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor1.r, var_322_3)
								local var_322_5 = Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor1.g, var_322_3)
								local var_322_6 = Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor1.b, var_322_3)

								iter_322_1.color = Color.New(var_322_4, var_322_5, var_322_6)
							else
								local var_322_7 = Mathf.Lerp(iter_322_1.color.r, 1, var_322_3)

								iter_322_1.color = Color.New(var_322_7, var_322_7, var_322_7)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps1028 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_322_3 then
						if arg_319_1.isInRecall_ then
							iter_322_3.color = arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_322_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps1028 = nil
			end

			local var_322_8 = 0
			local var_322_9 = 0.55

			if var_322_8 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_10 = arg_319_1:FormatText(StoryNameCfg[327].name)

				arg_319_1.leftNameTxt_.text = var_322_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_11 = arg_319_1:GetWordFromCfg(416011077)
				local var_322_12 = arg_319_1:FormatText(var_322_11.content)

				arg_319_1.text_.text = var_322_12

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_13 = 22
				local var_322_14 = utf8.len(var_322_12)
				local var_322_15 = var_322_13 <= 0 and var_322_9 or var_322_9 * (var_322_14 / var_322_13)

				if var_322_15 > 0 and var_322_9 < var_322_15 then
					arg_319_1.talkMaxDuration = var_322_15

					if var_322_15 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_15 + var_322_8
					end
				end

				arg_319_1.text_.text = var_322_12
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011077", "story_v_out_416011.awb") ~= 0 then
					local var_322_16 = manager.audio:GetVoiceLength("story_v_out_416011", "416011077", "story_v_out_416011.awb") / 1000

					if var_322_16 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_16 + var_322_8
					end

					if var_322_11.prefab_name ~= "" and arg_319_1.actors_[var_322_11.prefab_name] ~= nil then
						local var_322_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_11.prefab_name].transform, "story_v_out_416011", "416011077", "story_v_out_416011.awb")

						arg_319_1:RecordAudio("416011077", var_322_17)
						arg_319_1:RecordAudio("416011077", var_322_17)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_416011", "416011077", "story_v_out_416011.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_416011", "416011077", "story_v_out_416011.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_18 = math.max(var_322_9, arg_319_1.talkMaxDuration)

			if var_322_8 <= arg_319_1.time_ and arg_319_1.time_ < var_322_8 + var_322_18 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_8) / var_322_18

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_8 + var_322_18 and arg_319_1.time_ < var_322_8 + var_322_18 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play416011078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 416011078
		arg_323_1.duration_ = 4.03

		local var_323_0 = {
			zh = 2.133,
			ja = 4.033
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
				arg_323_0:Play416011079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1028"].transform
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.var_.moveOldPos1028 = var_326_0.localPosition
				var_326_0.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("1028", 7)

				local var_326_2 = var_326_0.childCount

				for iter_326_0 = 0, var_326_2 - 1 do
					local var_326_3 = var_326_0:GetChild(iter_326_0)

					if var_326_3.name == "" or not string.find(var_326_3.name, "split") then
						var_326_3.gameObject:SetActive(true)
					else
						var_326_3.gameObject:SetActive(false)
					end
				end
			end

			local var_326_4 = 0.001

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_4 then
				local var_326_5 = (arg_323_1.time_ - var_326_1) / var_326_4
				local var_326_6 = Vector3.New(0, -2000, 0)

				var_326_0.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1028, var_326_6, var_326_5)
			end

			if arg_323_1.time_ >= var_326_1 + var_326_4 and arg_323_1.time_ < var_326_1 + var_326_4 + arg_326_0 then
				var_326_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_326_7 = 0
			local var_326_8 = 0.275

			if var_326_7 < arg_323_1.time_ and arg_323_1.time_ <= var_326_7 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_9 = arg_323_1:FormatText(StoryNameCfg[1082].name)

				arg_323_1.leftNameTxt_.text = var_326_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_10 = arg_323_1:GetWordFromCfg(416011078)
				local var_326_11 = arg_323_1:FormatText(var_326_10.content)

				arg_323_1.text_.text = var_326_11

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_12 = 11
				local var_326_13 = utf8.len(var_326_11)
				local var_326_14 = var_326_12 <= 0 and var_326_8 or var_326_8 * (var_326_13 / var_326_12)

				if var_326_14 > 0 and var_326_8 < var_326_14 then
					arg_323_1.talkMaxDuration = var_326_14

					if var_326_14 + var_326_7 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_14 + var_326_7
					end
				end

				arg_323_1.text_.text = var_326_11
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011078", "story_v_out_416011.awb") ~= 0 then
					local var_326_15 = manager.audio:GetVoiceLength("story_v_out_416011", "416011078", "story_v_out_416011.awb") / 1000

					if var_326_15 + var_326_7 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_15 + var_326_7
					end

					if var_326_10.prefab_name ~= "" and arg_323_1.actors_[var_326_10.prefab_name] ~= nil then
						local var_326_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_10.prefab_name].transform, "story_v_out_416011", "416011078", "story_v_out_416011.awb")

						arg_323_1:RecordAudio("416011078", var_326_16)
						arg_323_1:RecordAudio("416011078", var_326_16)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_416011", "416011078", "story_v_out_416011.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_416011", "416011078", "story_v_out_416011.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_17 = math.max(var_326_8, arg_323_1.talkMaxDuration)

			if var_326_7 <= arg_323_1.time_ and arg_323_1.time_ < var_326_7 + var_326_17 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_7) / var_326_17

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_7 + var_326_17 and arg_323_1.time_ < var_326_7 + var_326_17 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play416011079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 416011079
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play416011080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0
			local var_330_1 = 1.625

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_2 = arg_327_1:GetWordFromCfg(416011079)
				local var_330_3 = arg_327_1:FormatText(var_330_2.content)

				arg_327_1.text_.text = var_330_3

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_4 = 65
				local var_330_5 = utf8.len(var_330_3)
				local var_330_6 = var_330_4 <= 0 and var_330_1 or var_330_1 * (var_330_5 / var_330_4)

				if var_330_6 > 0 and var_330_1 < var_330_6 then
					arg_327_1.talkMaxDuration = var_330_6

					if var_330_6 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_6 + var_330_0
					end
				end

				arg_327_1.text_.text = var_330_3
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_7 = math.max(var_330_1, arg_327_1.talkMaxDuration)

			if var_330_0 <= arg_327_1.time_ and arg_327_1.time_ < var_330_0 + var_330_7 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_0) / var_330_7

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_0 + var_330_7 and arg_327_1.time_ < var_330_0 + var_330_7 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play416011080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 416011080
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play416011081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0
			local var_334_1 = 1.55

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_2 = arg_331_1:GetWordFromCfg(416011080)
				local var_334_3 = arg_331_1:FormatText(var_334_2.content)

				arg_331_1.text_.text = var_334_3

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 62
				local var_334_5 = utf8.len(var_334_3)
				local var_334_6 = var_334_4 <= 0 and var_334_1 or var_334_1 * (var_334_5 / var_334_4)

				if var_334_6 > 0 and var_334_1 < var_334_6 then
					arg_331_1.talkMaxDuration = var_334_6

					if var_334_6 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_6 + var_334_0
					end
				end

				arg_331_1.text_.text = var_334_3
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_1, arg_331_1.talkMaxDuration)

			if var_334_0 <= arg_331_1.time_ and arg_331_1.time_ < var_334_0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_0 + var_334_7 and arg_331_1.time_ < var_334_0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play416011081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 416011081
		arg_335_1.duration_ = 6.43

		local var_335_0 = {
			zh = 3.633,
			ja = 6.433
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
				arg_335_0:Play416011082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = "10108"

			if arg_335_1.actors_[var_338_0] == nil then
				local var_338_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

				if not isNil(var_338_1) then
					local var_338_2 = Object.Instantiate(var_338_1, arg_335_1.canvasGo_.transform)

					var_338_2.transform:SetSiblingIndex(1)

					var_338_2.name = var_338_0
					var_338_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_335_1.actors_[var_338_0] = var_338_2

					local var_338_3 = var_338_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_335_1.isInRecall_ then
						for iter_338_0, iter_338_1 in ipairs(var_338_3) do
							iter_338_1.color = arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_338_4 = arg_335_1.actors_["10108"].transform
			local var_338_5 = 0

			if var_338_5 < arg_335_1.time_ and arg_335_1.time_ <= var_338_5 + arg_338_0 then
				arg_335_1.var_.moveOldPos10108 = var_338_4.localPosition
				var_338_4.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("10108", 3)

				local var_338_6 = var_338_4.childCount

				for iter_338_2 = 0, var_338_6 - 1 do
					local var_338_7 = var_338_4:GetChild(iter_338_2)

					if var_338_7.name == "split_2" or not string.find(var_338_7.name, "split") then
						var_338_7.gameObject:SetActive(true)
					else
						var_338_7.gameObject:SetActive(false)
					end
				end
			end

			local var_338_8 = 0.001

			if var_338_5 <= arg_335_1.time_ and arg_335_1.time_ < var_338_5 + var_338_8 then
				local var_338_9 = (arg_335_1.time_ - var_338_5) / var_338_8
				local var_338_10 = Vector3.New(0, -399.6, -130)

				var_338_4.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos10108, var_338_10, var_338_9)
			end

			if arg_335_1.time_ >= var_338_5 + var_338_8 and arg_335_1.time_ < var_338_5 + var_338_8 + arg_338_0 then
				var_338_4.localPosition = Vector3.New(0, -399.6, -130)
			end

			local var_338_11 = arg_335_1.actors_["10108"]
			local var_338_12 = 0

			if var_338_12 < arg_335_1.time_ and arg_335_1.time_ <= var_338_12 + arg_338_0 and not isNil(var_338_11) and arg_335_1.var_.actorSpriteComps10108 == nil then
				arg_335_1.var_.actorSpriteComps10108 = var_338_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_13 = 0.125

			if var_338_12 <= arg_335_1.time_ and arg_335_1.time_ < var_338_12 + var_338_13 and not isNil(var_338_11) then
				local var_338_14 = (arg_335_1.time_ - var_338_12) / var_338_13

				if arg_335_1.var_.actorSpriteComps10108 then
					for iter_338_3, iter_338_4 in pairs(arg_335_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_338_4 then
							if arg_335_1.isInRecall_ then
								local var_338_15 = Mathf.Lerp(iter_338_4.color.r, arg_335_1.hightColor1.r, var_338_14)
								local var_338_16 = Mathf.Lerp(iter_338_4.color.g, arg_335_1.hightColor1.g, var_338_14)
								local var_338_17 = Mathf.Lerp(iter_338_4.color.b, arg_335_1.hightColor1.b, var_338_14)

								iter_338_4.color = Color.New(var_338_15, var_338_16, var_338_17)
							else
								local var_338_18 = Mathf.Lerp(iter_338_4.color.r, 1, var_338_14)

								iter_338_4.color = Color.New(var_338_18, var_338_18, var_338_18)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_12 + var_338_13 and arg_335_1.time_ < var_338_12 + var_338_13 + arg_338_0 and not isNil(var_338_11) and arg_335_1.var_.actorSpriteComps10108 then
				for iter_338_5, iter_338_6 in pairs(arg_335_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_338_6 then
						if arg_335_1.isInRecall_ then
							iter_338_6.color = arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_338_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps10108 = nil
			end

			local var_338_19 = 0
			local var_338_20 = 0.25

			if var_338_19 < arg_335_1.time_ and arg_335_1.time_ <= var_338_19 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_21 = arg_335_1:FormatText(StoryNameCfg[1083].name)

				arg_335_1.leftNameTxt_.text = var_338_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_22 = arg_335_1:GetWordFromCfg(416011081)
				local var_338_23 = arg_335_1:FormatText(var_338_22.content)

				arg_335_1.text_.text = var_338_23

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_24 = 10
				local var_338_25 = utf8.len(var_338_23)
				local var_338_26 = var_338_24 <= 0 and var_338_20 or var_338_20 * (var_338_25 / var_338_24)

				if var_338_26 > 0 and var_338_20 < var_338_26 then
					arg_335_1.talkMaxDuration = var_338_26

					if var_338_26 + var_338_19 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_26 + var_338_19
					end
				end

				arg_335_1.text_.text = var_338_23
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011081", "story_v_out_416011.awb") ~= 0 then
					local var_338_27 = manager.audio:GetVoiceLength("story_v_out_416011", "416011081", "story_v_out_416011.awb") / 1000

					if var_338_27 + var_338_19 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_27 + var_338_19
					end

					if var_338_22.prefab_name ~= "" and arg_335_1.actors_[var_338_22.prefab_name] ~= nil then
						local var_338_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_22.prefab_name].transform, "story_v_out_416011", "416011081", "story_v_out_416011.awb")

						arg_335_1:RecordAudio("416011081", var_338_28)
						arg_335_1:RecordAudio("416011081", var_338_28)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_416011", "416011081", "story_v_out_416011.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_416011", "416011081", "story_v_out_416011.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_29 = math.max(var_338_20, arg_335_1.talkMaxDuration)

			if var_338_19 <= arg_335_1.time_ and arg_335_1.time_ < var_338_19 + var_338_29 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_19) / var_338_29

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_19 + var_338_29 and arg_335_1.time_ < var_338_19 + var_338_29 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
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
	Play416011082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 416011082
		arg_339_1.duration_ = 6.3

		local var_339_0 = {
			zh = 4.133,
			ja = 6.3
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
				arg_339_0:Play416011083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["10108"].transform
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.var_.moveOldPos10108 = var_342_0.localPosition
				var_342_0.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("10108", 2)

				local var_342_2 = var_342_0.childCount

				for iter_342_0 = 0, var_342_2 - 1 do
					local var_342_3 = var_342_0:GetChild(iter_342_0)

					if var_342_3.name == "split_2" or not string.find(var_342_3.name, "split") then
						var_342_3.gameObject:SetActive(true)
					else
						var_342_3.gameObject:SetActive(false)
					end
				end
			end

			local var_342_4 = 0.001

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_4 then
				local var_342_5 = (arg_339_1.time_ - var_342_1) / var_342_4
				local var_342_6 = Vector3.New(-390, -399.6, -130)

				var_342_0.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos10108, var_342_6, var_342_5)
			end

			if arg_339_1.time_ >= var_342_1 + var_342_4 and arg_339_1.time_ < var_342_1 + var_342_4 + arg_342_0 then
				var_342_0.localPosition = Vector3.New(-390, -399.6, -130)
			end

			local var_342_7 = arg_339_1.actors_["1028"].transform
			local var_342_8 = 0

			if var_342_8 < arg_339_1.time_ and arg_339_1.time_ <= var_342_8 + arg_342_0 then
				arg_339_1.var_.moveOldPos1028 = var_342_7.localPosition
				var_342_7.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("1028", 4)

				local var_342_9 = var_342_7.childCount

				for iter_342_1 = 0, var_342_9 - 1 do
					local var_342_10 = var_342_7:GetChild(iter_342_1)

					if var_342_10.name == "split_6" or not string.find(var_342_10.name, "split") then
						var_342_10.gameObject:SetActive(true)
					else
						var_342_10.gameObject:SetActive(false)
					end
				end
			end

			local var_342_11 = 0.001

			if var_342_8 <= arg_339_1.time_ and arg_339_1.time_ < var_342_8 + var_342_11 then
				local var_342_12 = (arg_339_1.time_ - var_342_8) / var_342_11
				local var_342_13 = Vector3.New(390, -402.7, -156.1)

				var_342_7.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1028, var_342_13, var_342_12)
			end

			if arg_339_1.time_ >= var_342_8 + var_342_11 and arg_339_1.time_ < var_342_8 + var_342_11 + arg_342_0 then
				var_342_7.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_342_14 = arg_339_1.actors_["10108"]
			local var_342_15 = 0

			if var_342_15 < arg_339_1.time_ and arg_339_1.time_ <= var_342_15 + arg_342_0 and not isNil(var_342_14) and arg_339_1.var_.actorSpriteComps10108 == nil then
				arg_339_1.var_.actorSpriteComps10108 = var_342_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_16 = 0.125

			if var_342_15 <= arg_339_1.time_ and arg_339_1.time_ < var_342_15 + var_342_16 and not isNil(var_342_14) then
				local var_342_17 = (arg_339_1.time_ - var_342_15) / var_342_16

				if arg_339_1.var_.actorSpriteComps10108 then
					for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_342_3 then
							if arg_339_1.isInRecall_ then
								local var_342_18 = Mathf.Lerp(iter_342_3.color.r, arg_339_1.hightColor2.r, var_342_17)
								local var_342_19 = Mathf.Lerp(iter_342_3.color.g, arg_339_1.hightColor2.g, var_342_17)
								local var_342_20 = Mathf.Lerp(iter_342_3.color.b, arg_339_1.hightColor2.b, var_342_17)

								iter_342_3.color = Color.New(var_342_18, var_342_19, var_342_20)
							else
								local var_342_21 = Mathf.Lerp(iter_342_3.color.r, 0.5, var_342_17)

								iter_342_3.color = Color.New(var_342_21, var_342_21, var_342_21)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= var_342_15 + var_342_16 and arg_339_1.time_ < var_342_15 + var_342_16 + arg_342_0 and not isNil(var_342_14) and arg_339_1.var_.actorSpriteComps10108 then
				for iter_342_4, iter_342_5 in pairs(arg_339_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_342_5 then
						if arg_339_1.isInRecall_ then
							iter_342_5.color = arg_339_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_342_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_339_1.var_.actorSpriteComps10108 = nil
			end

			local var_342_22 = arg_339_1.actors_["1028"]
			local var_342_23 = 0

			if var_342_23 < arg_339_1.time_ and arg_339_1.time_ <= var_342_23 + arg_342_0 and not isNil(var_342_22) and arg_339_1.var_.actorSpriteComps1028 == nil then
				arg_339_1.var_.actorSpriteComps1028 = var_342_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_24 = 0.125

			if var_342_23 <= arg_339_1.time_ and arg_339_1.time_ < var_342_23 + var_342_24 and not isNil(var_342_22) then
				local var_342_25 = (arg_339_1.time_ - var_342_23) / var_342_24

				if arg_339_1.var_.actorSpriteComps1028 then
					for iter_342_6, iter_342_7 in pairs(arg_339_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_342_7 then
							if arg_339_1.isInRecall_ then
								local var_342_26 = Mathf.Lerp(iter_342_7.color.r, arg_339_1.hightColor1.r, var_342_25)
								local var_342_27 = Mathf.Lerp(iter_342_7.color.g, arg_339_1.hightColor1.g, var_342_25)
								local var_342_28 = Mathf.Lerp(iter_342_7.color.b, arg_339_1.hightColor1.b, var_342_25)

								iter_342_7.color = Color.New(var_342_26, var_342_27, var_342_28)
							else
								local var_342_29 = Mathf.Lerp(iter_342_7.color.r, 1, var_342_25)

								iter_342_7.color = Color.New(var_342_29, var_342_29, var_342_29)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= var_342_23 + var_342_24 and arg_339_1.time_ < var_342_23 + var_342_24 + arg_342_0 and not isNil(var_342_22) and arg_339_1.var_.actorSpriteComps1028 then
				for iter_342_8, iter_342_9 in pairs(arg_339_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_342_9 then
						if arg_339_1.isInRecall_ then
							iter_342_9.color = arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_342_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_339_1.var_.actorSpriteComps1028 = nil
			end

			local var_342_30 = 0
			local var_342_31 = 0.4

			if var_342_30 < arg_339_1.time_ and arg_339_1.time_ <= var_342_30 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_32 = arg_339_1:FormatText(StoryNameCfg[327].name)

				arg_339_1.leftNameTxt_.text = var_342_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_33 = arg_339_1:GetWordFromCfg(416011082)
				local var_342_34 = arg_339_1:FormatText(var_342_33.content)

				arg_339_1.text_.text = var_342_34

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_35 = 16
				local var_342_36 = utf8.len(var_342_34)
				local var_342_37 = var_342_35 <= 0 and var_342_31 or var_342_31 * (var_342_36 / var_342_35)

				if var_342_37 > 0 and var_342_31 < var_342_37 then
					arg_339_1.talkMaxDuration = var_342_37

					if var_342_37 + var_342_30 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_37 + var_342_30
					end
				end

				arg_339_1.text_.text = var_342_34
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011082", "story_v_out_416011.awb") ~= 0 then
					local var_342_38 = manager.audio:GetVoiceLength("story_v_out_416011", "416011082", "story_v_out_416011.awb") / 1000

					if var_342_38 + var_342_30 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_38 + var_342_30
					end

					if var_342_33.prefab_name ~= "" and arg_339_1.actors_[var_342_33.prefab_name] ~= nil then
						local var_342_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_33.prefab_name].transform, "story_v_out_416011", "416011082", "story_v_out_416011.awb")

						arg_339_1:RecordAudio("416011082", var_342_39)
						arg_339_1:RecordAudio("416011082", var_342_39)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_416011", "416011082", "story_v_out_416011.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_416011", "416011082", "story_v_out_416011.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_40 = math.max(var_342_31, arg_339_1.talkMaxDuration)

			if var_342_30 <= arg_339_1.time_ and arg_339_1.time_ < var_342_30 + var_342_40 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_30) / var_342_40

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_30 + var_342_40 and arg_339_1.time_ < var_342_30 + var_342_40 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play416011083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 416011083
		arg_343_1.duration_ = 7.23

		local var_343_0 = {
			zh = 6.733,
			ja = 7.233
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play416011084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["10108"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps10108 == nil then
				arg_343_1.var_.actorSpriteComps10108 = var_346_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_2 = 0.125

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.actorSpriteComps10108 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_346_1 then
							if arg_343_1.isInRecall_ then
								local var_346_4 = Mathf.Lerp(iter_346_1.color.r, arg_343_1.hightColor1.r, var_346_3)
								local var_346_5 = Mathf.Lerp(iter_346_1.color.g, arg_343_1.hightColor1.g, var_346_3)
								local var_346_6 = Mathf.Lerp(iter_346_1.color.b, arg_343_1.hightColor1.b, var_346_3)

								iter_346_1.color = Color.New(var_346_4, var_346_5, var_346_6)
							else
								local var_346_7 = Mathf.Lerp(iter_346_1.color.r, 1, var_346_3)

								iter_346_1.color = Color.New(var_346_7, var_346_7, var_346_7)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps10108 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_346_3 then
						if arg_343_1.isInRecall_ then
							iter_346_3.color = arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_346_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps10108 = nil
			end

			local var_346_8 = arg_343_1.actors_["1028"]
			local var_346_9 = 0

			if var_346_9 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 and not isNil(var_346_8) and arg_343_1.var_.actorSpriteComps1028 == nil then
				arg_343_1.var_.actorSpriteComps1028 = var_346_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_10 = 0.125

			if var_346_9 <= arg_343_1.time_ and arg_343_1.time_ < var_346_9 + var_346_10 and not isNil(var_346_8) then
				local var_346_11 = (arg_343_1.time_ - var_346_9) / var_346_10

				if arg_343_1.var_.actorSpriteComps1028 then
					for iter_346_4, iter_346_5 in pairs(arg_343_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_346_5 then
							if arg_343_1.isInRecall_ then
								local var_346_12 = Mathf.Lerp(iter_346_5.color.r, arg_343_1.hightColor2.r, var_346_11)
								local var_346_13 = Mathf.Lerp(iter_346_5.color.g, arg_343_1.hightColor2.g, var_346_11)
								local var_346_14 = Mathf.Lerp(iter_346_5.color.b, arg_343_1.hightColor2.b, var_346_11)

								iter_346_5.color = Color.New(var_346_12, var_346_13, var_346_14)
							else
								local var_346_15 = Mathf.Lerp(iter_346_5.color.r, 0.5, var_346_11)

								iter_346_5.color = Color.New(var_346_15, var_346_15, var_346_15)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_9 + var_346_10 and arg_343_1.time_ < var_346_9 + var_346_10 + arg_346_0 and not isNil(var_346_8) and arg_343_1.var_.actorSpriteComps1028 then
				for iter_346_6, iter_346_7 in pairs(arg_343_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_346_7 then
						if arg_343_1.isInRecall_ then
							iter_346_7.color = arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_346_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps1028 = nil
			end

			local var_346_16 = 0
			local var_346_17 = 0.65

			if var_346_16 < arg_343_1.time_ and arg_343_1.time_ <= var_346_16 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_18 = arg_343_1:FormatText(StoryNameCfg[1083].name)

				arg_343_1.leftNameTxt_.text = var_346_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_19 = arg_343_1:GetWordFromCfg(416011083)
				local var_346_20 = arg_343_1:FormatText(var_346_19.content)

				arg_343_1.text_.text = var_346_20

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_21 = 26
				local var_346_22 = utf8.len(var_346_20)
				local var_346_23 = var_346_21 <= 0 and var_346_17 or var_346_17 * (var_346_22 / var_346_21)

				if var_346_23 > 0 and var_346_17 < var_346_23 then
					arg_343_1.talkMaxDuration = var_346_23

					if var_346_23 + var_346_16 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_23 + var_346_16
					end
				end

				arg_343_1.text_.text = var_346_20
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011083", "story_v_out_416011.awb") ~= 0 then
					local var_346_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011083", "story_v_out_416011.awb") / 1000

					if var_346_24 + var_346_16 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_24 + var_346_16
					end

					if var_346_19.prefab_name ~= "" and arg_343_1.actors_[var_346_19.prefab_name] ~= nil then
						local var_346_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_19.prefab_name].transform, "story_v_out_416011", "416011083", "story_v_out_416011.awb")

						arg_343_1:RecordAudio("416011083", var_346_25)
						arg_343_1:RecordAudio("416011083", var_346_25)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_416011", "416011083", "story_v_out_416011.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_416011", "416011083", "story_v_out_416011.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_26 = math.max(var_346_17, arg_343_1.talkMaxDuration)

			if var_346_16 <= arg_343_1.time_ and arg_343_1.time_ < var_346_16 + var_346_26 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_16) / var_346_26

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_16 + var_346_26 and arg_343_1.time_ < var_346_16 + var_346_26 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play416011084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 416011084
		arg_347_1.duration_ = 4.27

		local var_347_0 = {
			zh = 2.666,
			ja = 4.266
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
				arg_347_0:Play416011085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["10108"].transform
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.var_.moveOldPos10108 = var_350_0.localPosition
				var_350_0.localScale = Vector3.New(1, 1, 1)

				arg_347_1:CheckSpriteTmpPos("10108", 2)

				local var_350_2 = var_350_0.childCount

				for iter_350_0 = 0, var_350_2 - 1 do
					local var_350_3 = var_350_0:GetChild(iter_350_0)

					if var_350_3.name == "split_1" or not string.find(var_350_3.name, "split") then
						var_350_3.gameObject:SetActive(true)
					else
						var_350_3.gameObject:SetActive(false)
					end
				end
			end

			local var_350_4 = 0.001

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_4 then
				local var_350_5 = (arg_347_1.time_ - var_350_1) / var_350_4
				local var_350_6 = Vector3.New(-390, -399.6, -130)

				var_350_0.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10108, var_350_6, var_350_5)
			end

			if arg_347_1.time_ >= var_350_1 + var_350_4 and arg_347_1.time_ < var_350_1 + var_350_4 + arg_350_0 then
				var_350_0.localPosition = Vector3.New(-390, -399.6, -130)
			end

			local var_350_7 = 0
			local var_350_8 = 0.2

			if var_350_7 < arg_347_1.time_ and arg_347_1.time_ <= var_350_7 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_9 = arg_347_1:FormatText(StoryNameCfg[1083].name)

				arg_347_1.leftNameTxt_.text = var_350_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_10 = arg_347_1:GetWordFromCfg(416011084)
				local var_350_11 = arg_347_1:FormatText(var_350_10.content)

				arg_347_1.text_.text = var_350_11

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_12 = 8
				local var_350_13 = utf8.len(var_350_11)
				local var_350_14 = var_350_12 <= 0 and var_350_8 or var_350_8 * (var_350_13 / var_350_12)

				if var_350_14 > 0 and var_350_8 < var_350_14 then
					arg_347_1.talkMaxDuration = var_350_14

					if var_350_14 + var_350_7 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_14 + var_350_7
					end
				end

				arg_347_1.text_.text = var_350_11
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011084", "story_v_out_416011.awb") ~= 0 then
					local var_350_15 = manager.audio:GetVoiceLength("story_v_out_416011", "416011084", "story_v_out_416011.awb") / 1000

					if var_350_15 + var_350_7 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_15 + var_350_7
					end

					if var_350_10.prefab_name ~= "" and arg_347_1.actors_[var_350_10.prefab_name] ~= nil then
						local var_350_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_10.prefab_name].transform, "story_v_out_416011", "416011084", "story_v_out_416011.awb")

						arg_347_1:RecordAudio("416011084", var_350_16)
						arg_347_1:RecordAudio("416011084", var_350_16)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_416011", "416011084", "story_v_out_416011.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_416011", "416011084", "story_v_out_416011.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_17 = math.max(var_350_8, arg_347_1.talkMaxDuration)

			if var_350_7 <= arg_347_1.time_ and arg_347_1.time_ < var_350_7 + var_350_17 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_7) / var_350_17

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_7 + var_350_17 and arg_347_1.time_ < var_350_7 + var_350_17 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play416011085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 416011085
		arg_351_1.duration_ = 8.03

		local var_351_0 = {
			zh = 4.233,
			ja = 8.033
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
				arg_351_0:Play416011086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["10108"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.actorSpriteComps10108 == nil then
				arg_351_1.var_.actorSpriteComps10108 = var_354_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_2 = 0.125

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.actorSpriteComps10108 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_354_1 then
							if arg_351_1.isInRecall_ then
								local var_354_4 = Mathf.Lerp(iter_354_1.color.r, arg_351_1.hightColor2.r, var_354_3)
								local var_354_5 = Mathf.Lerp(iter_354_1.color.g, arg_351_1.hightColor2.g, var_354_3)
								local var_354_6 = Mathf.Lerp(iter_354_1.color.b, arg_351_1.hightColor2.b, var_354_3)

								iter_354_1.color = Color.New(var_354_4, var_354_5, var_354_6)
							else
								local var_354_7 = Mathf.Lerp(iter_354_1.color.r, 0.5, var_354_3)

								iter_354_1.color = Color.New(var_354_7, var_354_7, var_354_7)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.actorSpriteComps10108 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_354_3 then
						if arg_351_1.isInRecall_ then
							iter_354_3.color = arg_351_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_354_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_351_1.var_.actorSpriteComps10108 = nil
			end

			local var_354_8 = arg_351_1.actors_["1028"]
			local var_354_9 = 0

			if var_354_9 < arg_351_1.time_ and arg_351_1.time_ <= var_354_9 + arg_354_0 and not isNil(var_354_8) and arg_351_1.var_.actorSpriteComps1028 == nil then
				arg_351_1.var_.actorSpriteComps1028 = var_354_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_10 = 0.125

			if var_354_9 <= arg_351_1.time_ and arg_351_1.time_ < var_354_9 + var_354_10 and not isNil(var_354_8) then
				local var_354_11 = (arg_351_1.time_ - var_354_9) / var_354_10

				if arg_351_1.var_.actorSpriteComps1028 then
					for iter_354_4, iter_354_5 in pairs(arg_351_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_354_5 then
							if arg_351_1.isInRecall_ then
								local var_354_12 = Mathf.Lerp(iter_354_5.color.r, arg_351_1.hightColor1.r, var_354_11)
								local var_354_13 = Mathf.Lerp(iter_354_5.color.g, arg_351_1.hightColor1.g, var_354_11)
								local var_354_14 = Mathf.Lerp(iter_354_5.color.b, arg_351_1.hightColor1.b, var_354_11)

								iter_354_5.color = Color.New(var_354_12, var_354_13, var_354_14)
							else
								local var_354_15 = Mathf.Lerp(iter_354_5.color.r, 1, var_354_11)

								iter_354_5.color = Color.New(var_354_15, var_354_15, var_354_15)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= var_354_9 + var_354_10 and arg_351_1.time_ < var_354_9 + var_354_10 + arg_354_0 and not isNil(var_354_8) and arg_351_1.var_.actorSpriteComps1028 then
				for iter_354_6, iter_354_7 in pairs(arg_351_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_354_7 then
						if arg_351_1.isInRecall_ then
							iter_354_7.color = arg_351_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_354_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_351_1.var_.actorSpriteComps1028 = nil
			end

			local var_354_16 = 0
			local var_354_17 = 0.45

			if var_354_16 < arg_351_1.time_ and arg_351_1.time_ <= var_354_16 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_18 = arg_351_1:FormatText(StoryNameCfg[327].name)

				arg_351_1.leftNameTxt_.text = var_354_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_19 = arg_351_1:GetWordFromCfg(416011085)
				local var_354_20 = arg_351_1:FormatText(var_354_19.content)

				arg_351_1.text_.text = var_354_20

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_21 = 18
				local var_354_22 = utf8.len(var_354_20)
				local var_354_23 = var_354_21 <= 0 and var_354_17 or var_354_17 * (var_354_22 / var_354_21)

				if var_354_23 > 0 and var_354_17 < var_354_23 then
					arg_351_1.talkMaxDuration = var_354_23

					if var_354_23 + var_354_16 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_23 + var_354_16
					end
				end

				arg_351_1.text_.text = var_354_20
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011085", "story_v_out_416011.awb") ~= 0 then
					local var_354_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011085", "story_v_out_416011.awb") / 1000

					if var_354_24 + var_354_16 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_24 + var_354_16
					end

					if var_354_19.prefab_name ~= "" and arg_351_1.actors_[var_354_19.prefab_name] ~= nil then
						local var_354_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_19.prefab_name].transform, "story_v_out_416011", "416011085", "story_v_out_416011.awb")

						arg_351_1:RecordAudio("416011085", var_354_25)
						arg_351_1:RecordAudio("416011085", var_354_25)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_416011", "416011085", "story_v_out_416011.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_416011", "416011085", "story_v_out_416011.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_26 = math.max(var_354_17, arg_351_1.talkMaxDuration)

			if var_354_16 <= arg_351_1.time_ and arg_351_1.time_ < var_354_16 + var_354_26 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_16) / var_354_26

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_16 + var_354_26 and arg_351_1.time_ < var_354_16 + var_354_26 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play416011086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 416011086
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play416011087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["10108"].transform
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.var_.moveOldPos10108 = var_358_0.localPosition
				var_358_0.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10108", 7)

				local var_358_2 = var_358_0.childCount

				for iter_358_0 = 0, var_358_2 - 1 do
					local var_358_3 = var_358_0:GetChild(iter_358_0)

					if var_358_3.name == "" or not string.find(var_358_3.name, "split") then
						var_358_3.gameObject:SetActive(true)
					else
						var_358_3.gameObject:SetActive(false)
					end
				end
			end

			local var_358_4 = 0.001

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_4 then
				local var_358_5 = (arg_355_1.time_ - var_358_1) / var_358_4
				local var_358_6 = Vector3.New(0, -2000, 0)

				var_358_0.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10108, var_358_6, var_358_5)
			end

			if arg_355_1.time_ >= var_358_1 + var_358_4 and arg_355_1.time_ < var_358_1 + var_358_4 + arg_358_0 then
				var_358_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_358_7 = arg_355_1.actors_["1028"].transform
			local var_358_8 = 0

			if var_358_8 < arg_355_1.time_ and arg_355_1.time_ <= var_358_8 + arg_358_0 then
				arg_355_1.var_.moveOldPos1028 = var_358_7.localPosition
				var_358_7.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("1028", 7)

				local var_358_9 = var_358_7.childCount

				for iter_358_1 = 0, var_358_9 - 1 do
					local var_358_10 = var_358_7:GetChild(iter_358_1)

					if var_358_10.name == "split_2" or not string.find(var_358_10.name, "split") then
						var_358_10.gameObject:SetActive(true)
					else
						var_358_10.gameObject:SetActive(false)
					end
				end
			end

			local var_358_11 = 0.001

			if var_358_8 <= arg_355_1.time_ and arg_355_1.time_ < var_358_8 + var_358_11 then
				local var_358_12 = (arg_355_1.time_ - var_358_8) / var_358_11
				local var_358_13 = Vector3.New(0, -2000, 0)

				var_358_7.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1028, var_358_13, var_358_12)
			end

			if arg_355_1.time_ >= var_358_8 + var_358_11 and arg_355_1.time_ < var_358_8 + var_358_11 + arg_358_0 then
				var_358_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_358_14 = 0
			local var_358_15 = 0.925

			if var_358_14 < arg_355_1.time_ and arg_355_1.time_ <= var_358_14 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_16 = arg_355_1:GetWordFromCfg(416011086)
				local var_358_17 = arg_355_1:FormatText(var_358_16.content)

				arg_355_1.text_.text = var_358_17

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_18 = 37
				local var_358_19 = utf8.len(var_358_17)
				local var_358_20 = var_358_18 <= 0 and var_358_15 or var_358_15 * (var_358_19 / var_358_18)

				if var_358_20 > 0 and var_358_15 < var_358_20 then
					arg_355_1.talkMaxDuration = var_358_20

					if var_358_20 + var_358_14 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_20 + var_358_14
					end
				end

				arg_355_1.text_.text = var_358_17
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_21 = math.max(var_358_15, arg_355_1.talkMaxDuration)

			if var_358_14 <= arg_355_1.time_ and arg_355_1.time_ < var_358_14 + var_358_21 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_14) / var_358_21

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_14 + var_358_21 and arg_355_1.time_ < var_358_14 + var_358_21 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play416011087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 416011087
		arg_359_1.duration_ = 6.33

		local var_359_0 = {
			zh = 4.133,
			ja = 6.333
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play416011088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["10108"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.actorSpriteComps10108 == nil then
				arg_359_1.var_.actorSpriteComps10108 = var_362_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_2 = 0.125

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 and not isNil(var_362_0) then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2

				if arg_359_1.var_.actorSpriteComps10108 then
					for iter_362_0, iter_362_1 in pairs(arg_359_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_362_1 then
							if arg_359_1.isInRecall_ then
								local var_362_4 = Mathf.Lerp(iter_362_1.color.r, arg_359_1.hightColor1.r, var_362_3)
								local var_362_5 = Mathf.Lerp(iter_362_1.color.g, arg_359_1.hightColor1.g, var_362_3)
								local var_362_6 = Mathf.Lerp(iter_362_1.color.b, arg_359_1.hightColor1.b, var_362_3)

								iter_362_1.color = Color.New(var_362_4, var_362_5, var_362_6)
							else
								local var_362_7 = Mathf.Lerp(iter_362_1.color.r, 1, var_362_3)

								iter_362_1.color = Color.New(var_362_7, var_362_7, var_362_7)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.actorSpriteComps10108 then
				for iter_362_2, iter_362_3 in pairs(arg_359_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_362_3 then
						if arg_359_1.isInRecall_ then
							iter_362_3.color = arg_359_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_362_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_359_1.var_.actorSpriteComps10108 = nil
			end

			local var_362_8 = arg_359_1.actors_["10108"].transform
			local var_362_9 = 0

			if var_362_9 < arg_359_1.time_ and arg_359_1.time_ <= var_362_9 + arg_362_0 then
				arg_359_1.var_.moveOldPos10108 = var_362_8.localPosition
				var_362_8.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("10108", 3)

				local var_362_10 = var_362_8.childCount

				for iter_362_4 = 0, var_362_10 - 1 do
					local var_362_11 = var_362_8:GetChild(iter_362_4)

					if var_362_11.name == "split_4" or not string.find(var_362_11.name, "split") then
						var_362_11.gameObject:SetActive(true)
					else
						var_362_11.gameObject:SetActive(false)
					end
				end
			end

			local var_362_12 = 0.001

			if var_362_9 <= arg_359_1.time_ and arg_359_1.time_ < var_362_9 + var_362_12 then
				local var_362_13 = (arg_359_1.time_ - var_362_9) / var_362_12
				local var_362_14 = Vector3.New(0, -399.6, -130)

				var_362_8.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10108, var_362_14, var_362_13)
			end

			if arg_359_1.time_ >= var_362_9 + var_362_12 and arg_359_1.time_ < var_362_9 + var_362_12 + arg_362_0 then
				var_362_8.localPosition = Vector3.New(0, -399.6, -130)
			end

			local var_362_15 = 0
			local var_362_16 = 0.225

			if var_362_15 < arg_359_1.time_ and arg_359_1.time_ <= var_362_15 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_17 = arg_359_1:FormatText(StoryNameCfg[1083].name)

				arg_359_1.leftNameTxt_.text = var_362_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_18 = arg_359_1:GetWordFromCfg(416011087)
				local var_362_19 = arg_359_1:FormatText(var_362_18.content)

				arg_359_1.text_.text = var_362_19

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_20 = 9
				local var_362_21 = utf8.len(var_362_19)
				local var_362_22 = var_362_20 <= 0 and var_362_16 or var_362_16 * (var_362_21 / var_362_20)

				if var_362_22 > 0 and var_362_16 < var_362_22 then
					arg_359_1.talkMaxDuration = var_362_22

					if var_362_22 + var_362_15 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_22 + var_362_15
					end
				end

				arg_359_1.text_.text = var_362_19
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011087", "story_v_out_416011.awb") ~= 0 then
					local var_362_23 = manager.audio:GetVoiceLength("story_v_out_416011", "416011087", "story_v_out_416011.awb") / 1000

					if var_362_23 + var_362_15 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_23 + var_362_15
					end

					if var_362_18.prefab_name ~= "" and arg_359_1.actors_[var_362_18.prefab_name] ~= nil then
						local var_362_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_18.prefab_name].transform, "story_v_out_416011", "416011087", "story_v_out_416011.awb")

						arg_359_1:RecordAudio("416011087", var_362_24)
						arg_359_1:RecordAudio("416011087", var_362_24)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_416011", "416011087", "story_v_out_416011.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_416011", "416011087", "story_v_out_416011.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_25 = math.max(var_362_16, arg_359_1.talkMaxDuration)

			if var_362_15 <= arg_359_1.time_ and arg_359_1.time_ < var_362_15 + var_362_25 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_15) / var_362_25

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_15 + var_362_25 and arg_359_1.time_ < var_362_15 + var_362_25 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play416011088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 416011088
		arg_363_1.duration_ = 3.57

		local var_363_0 = {
			zh = 3.266,
			ja = 3.566
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
				arg_363_0:Play416011089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["10108"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.actorSpriteComps10108 == nil then
				arg_363_1.var_.actorSpriteComps10108 = var_366_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_2 = 0.125

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.actorSpriteComps10108 then
					for iter_366_0, iter_366_1 in pairs(arg_363_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_366_1 then
							if arg_363_1.isInRecall_ then
								local var_366_4 = Mathf.Lerp(iter_366_1.color.r, arg_363_1.hightColor2.r, var_366_3)
								local var_366_5 = Mathf.Lerp(iter_366_1.color.g, arg_363_1.hightColor2.g, var_366_3)
								local var_366_6 = Mathf.Lerp(iter_366_1.color.b, arg_363_1.hightColor2.b, var_366_3)

								iter_366_1.color = Color.New(var_366_4, var_366_5, var_366_6)
							else
								local var_366_7 = Mathf.Lerp(iter_366_1.color.r, 0.5, var_366_3)

								iter_366_1.color = Color.New(var_366_7, var_366_7, var_366_7)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.actorSpriteComps10108 then
				for iter_366_2, iter_366_3 in pairs(arg_363_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_366_3 then
						if arg_363_1.isInRecall_ then
							iter_366_3.color = arg_363_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_366_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_363_1.var_.actorSpriteComps10108 = nil
			end

			local var_366_8 = arg_363_1.actors_["1028"]
			local var_366_9 = 0

			if var_366_9 < arg_363_1.time_ and arg_363_1.time_ <= var_366_9 + arg_366_0 and not isNil(var_366_8) and arg_363_1.var_.actorSpriteComps1028 == nil then
				arg_363_1.var_.actorSpriteComps1028 = var_366_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_10 = 0.125

			if var_366_9 <= arg_363_1.time_ and arg_363_1.time_ < var_366_9 + var_366_10 and not isNil(var_366_8) then
				local var_366_11 = (arg_363_1.time_ - var_366_9) / var_366_10

				if arg_363_1.var_.actorSpriteComps1028 then
					for iter_366_4, iter_366_5 in pairs(arg_363_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_366_5 then
							if arg_363_1.isInRecall_ then
								local var_366_12 = Mathf.Lerp(iter_366_5.color.r, arg_363_1.hightColor1.r, var_366_11)
								local var_366_13 = Mathf.Lerp(iter_366_5.color.g, arg_363_1.hightColor1.g, var_366_11)
								local var_366_14 = Mathf.Lerp(iter_366_5.color.b, arg_363_1.hightColor1.b, var_366_11)

								iter_366_5.color = Color.New(var_366_12, var_366_13, var_366_14)
							else
								local var_366_15 = Mathf.Lerp(iter_366_5.color.r, 1, var_366_11)

								iter_366_5.color = Color.New(var_366_15, var_366_15, var_366_15)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= var_366_9 + var_366_10 and arg_363_1.time_ < var_366_9 + var_366_10 + arg_366_0 and not isNil(var_366_8) and arg_363_1.var_.actorSpriteComps1028 then
				for iter_366_6, iter_366_7 in pairs(arg_363_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_366_7 then
						if arg_363_1.isInRecall_ then
							iter_366_7.color = arg_363_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_366_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_363_1.var_.actorSpriteComps1028 = nil
			end

			local var_366_16 = arg_363_1.actors_["10108"].transform
			local var_366_17 = 0

			if var_366_17 < arg_363_1.time_ and arg_363_1.time_ <= var_366_17 + arg_366_0 then
				arg_363_1.var_.moveOldPos10108 = var_366_16.localPosition
				var_366_16.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("10108", 2)

				local var_366_18 = var_366_16.childCount

				for iter_366_8 = 0, var_366_18 - 1 do
					local var_366_19 = var_366_16:GetChild(iter_366_8)

					if var_366_19.name == "split_4" or not string.find(var_366_19.name, "split") then
						var_366_19.gameObject:SetActive(true)
					else
						var_366_19.gameObject:SetActive(false)
					end
				end
			end

			local var_366_20 = 0.001

			if var_366_17 <= arg_363_1.time_ and arg_363_1.time_ < var_366_17 + var_366_20 then
				local var_366_21 = (arg_363_1.time_ - var_366_17) / var_366_20
				local var_366_22 = Vector3.New(-390, -399.6, -130)

				var_366_16.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10108, var_366_22, var_366_21)
			end

			if arg_363_1.time_ >= var_366_17 + var_366_20 and arg_363_1.time_ < var_366_17 + var_366_20 + arg_366_0 then
				var_366_16.localPosition = Vector3.New(-390, -399.6, -130)
			end

			local var_366_23 = arg_363_1.actors_["1028"].transform
			local var_366_24 = 0

			if var_366_24 < arg_363_1.time_ and arg_363_1.time_ <= var_366_24 + arg_366_0 then
				arg_363_1.var_.moveOldPos1028 = var_366_23.localPosition
				var_366_23.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("1028", 4)

				local var_366_25 = var_366_23.childCount

				for iter_366_9 = 0, var_366_25 - 1 do
					local var_366_26 = var_366_23:GetChild(iter_366_9)

					if var_366_26.name == "split_2" or not string.find(var_366_26.name, "split") then
						var_366_26.gameObject:SetActive(true)
					else
						var_366_26.gameObject:SetActive(false)
					end
				end
			end

			local var_366_27 = 0.001

			if var_366_24 <= arg_363_1.time_ and arg_363_1.time_ < var_366_24 + var_366_27 then
				local var_366_28 = (arg_363_1.time_ - var_366_24) / var_366_27
				local var_366_29 = Vector3.New(390, -402.7, -156.1)

				var_366_23.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1028, var_366_29, var_366_28)
			end

			if arg_363_1.time_ >= var_366_24 + var_366_27 and arg_363_1.time_ < var_366_24 + var_366_27 + arg_366_0 then
				var_366_23.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_366_30 = 0
			local var_366_31 = 0.375

			if var_366_30 < arg_363_1.time_ and arg_363_1.time_ <= var_366_30 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_32 = arg_363_1:FormatText(StoryNameCfg[327].name)

				arg_363_1.leftNameTxt_.text = var_366_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_33 = arg_363_1:GetWordFromCfg(416011088)
				local var_366_34 = arg_363_1:FormatText(var_366_33.content)

				arg_363_1.text_.text = var_366_34

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_35 = 15
				local var_366_36 = utf8.len(var_366_34)
				local var_366_37 = var_366_35 <= 0 and var_366_31 or var_366_31 * (var_366_36 / var_366_35)

				if var_366_37 > 0 and var_366_31 < var_366_37 then
					arg_363_1.talkMaxDuration = var_366_37

					if var_366_37 + var_366_30 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_37 + var_366_30
					end
				end

				arg_363_1.text_.text = var_366_34
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011088", "story_v_out_416011.awb") ~= 0 then
					local var_366_38 = manager.audio:GetVoiceLength("story_v_out_416011", "416011088", "story_v_out_416011.awb") / 1000

					if var_366_38 + var_366_30 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_38 + var_366_30
					end

					if var_366_33.prefab_name ~= "" and arg_363_1.actors_[var_366_33.prefab_name] ~= nil then
						local var_366_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_33.prefab_name].transform, "story_v_out_416011", "416011088", "story_v_out_416011.awb")

						arg_363_1:RecordAudio("416011088", var_366_39)
						arg_363_1:RecordAudio("416011088", var_366_39)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_416011", "416011088", "story_v_out_416011.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_416011", "416011088", "story_v_out_416011.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_40 = math.max(var_366_31, arg_363_1.talkMaxDuration)

			if var_366_30 <= arg_363_1.time_ and arg_363_1.time_ < var_366_30 + var_366_40 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_30) / var_366_40

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_30 + var_366_40 and arg_363_1.time_ < var_366_30 + var_366_40 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play416011089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 416011089
		arg_367_1.duration_ = 5.7

		local var_367_0 = {
			zh = 5.2,
			ja = 5.7
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
				arg_367_0:Play416011090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1028"].transform
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.var_.moveOldPos1028 = var_370_0.localPosition
				var_370_0.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("1028", 4)

				local var_370_2 = var_370_0.childCount

				for iter_370_0 = 0, var_370_2 - 1 do
					local var_370_3 = var_370_0:GetChild(iter_370_0)

					if var_370_3.name == "split_4" or not string.find(var_370_3.name, "split") then
						var_370_3.gameObject:SetActive(true)
					else
						var_370_3.gameObject:SetActive(false)
					end
				end
			end

			local var_370_4 = 0.001

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_4 then
				local var_370_5 = (arg_367_1.time_ - var_370_1) / var_370_4
				local var_370_6 = Vector3.New(390, -402.7, -156.1)

				var_370_0.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1028, var_370_6, var_370_5)
			end

			if arg_367_1.time_ >= var_370_1 + var_370_4 and arg_367_1.time_ < var_370_1 + var_370_4 + arg_370_0 then
				var_370_0.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_370_7 = 0
			local var_370_8 = 0.65

			if var_370_7 < arg_367_1.time_ and arg_367_1.time_ <= var_370_7 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_9 = arg_367_1:FormatText(StoryNameCfg[327].name)

				arg_367_1.leftNameTxt_.text = var_370_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_10 = arg_367_1:GetWordFromCfg(416011089)
				local var_370_11 = arg_367_1:FormatText(var_370_10.content)

				arg_367_1.text_.text = var_370_11

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_12 = 26
				local var_370_13 = utf8.len(var_370_11)
				local var_370_14 = var_370_12 <= 0 and var_370_8 or var_370_8 * (var_370_13 / var_370_12)

				if var_370_14 > 0 and var_370_8 < var_370_14 then
					arg_367_1.talkMaxDuration = var_370_14

					if var_370_14 + var_370_7 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_14 + var_370_7
					end
				end

				arg_367_1.text_.text = var_370_11
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011089", "story_v_out_416011.awb") ~= 0 then
					local var_370_15 = manager.audio:GetVoiceLength("story_v_out_416011", "416011089", "story_v_out_416011.awb") / 1000

					if var_370_15 + var_370_7 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_15 + var_370_7
					end

					if var_370_10.prefab_name ~= "" and arg_367_1.actors_[var_370_10.prefab_name] ~= nil then
						local var_370_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_10.prefab_name].transform, "story_v_out_416011", "416011089", "story_v_out_416011.awb")

						arg_367_1:RecordAudio("416011089", var_370_16)
						arg_367_1:RecordAudio("416011089", var_370_16)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_416011", "416011089", "story_v_out_416011.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_416011", "416011089", "story_v_out_416011.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_17 = math.max(var_370_8, arg_367_1.talkMaxDuration)

			if var_370_7 <= arg_367_1.time_ and arg_367_1.time_ < var_370_7 + var_370_17 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_7) / var_370_17

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_7 + var_370_17 and arg_367_1.time_ < var_370_7 + var_370_17 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play416011090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 416011090
		arg_371_1.duration_ = 8.03

		local var_371_0 = {
			zh = 7.4,
			ja = 8.033
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
				arg_371_0:Play416011091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1028"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.actorSpriteComps1028 == nil then
				arg_371_1.var_.actorSpriteComps1028 = var_374_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_2 = 0.125

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 and not isNil(var_374_0) then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.actorSpriteComps1028 then
					for iter_374_0, iter_374_1 in pairs(arg_371_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_374_1 then
							if arg_371_1.isInRecall_ then
								local var_374_4 = Mathf.Lerp(iter_374_1.color.r, arg_371_1.hightColor2.r, var_374_3)
								local var_374_5 = Mathf.Lerp(iter_374_1.color.g, arg_371_1.hightColor2.g, var_374_3)
								local var_374_6 = Mathf.Lerp(iter_374_1.color.b, arg_371_1.hightColor2.b, var_374_3)

								iter_374_1.color = Color.New(var_374_4, var_374_5, var_374_6)
							else
								local var_374_7 = Mathf.Lerp(iter_374_1.color.r, 0.5, var_374_3)

								iter_374_1.color = Color.New(var_374_7, var_374_7, var_374_7)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.actorSpriteComps1028 then
				for iter_374_2, iter_374_3 in pairs(arg_371_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_374_3 then
						if arg_371_1.isInRecall_ then
							iter_374_3.color = arg_371_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_374_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_371_1.var_.actorSpriteComps1028 = nil
			end

			local var_374_8 = arg_371_1.actors_["10108"]
			local var_374_9 = 0

			if var_374_9 < arg_371_1.time_ and arg_371_1.time_ <= var_374_9 + arg_374_0 and not isNil(var_374_8) and arg_371_1.var_.actorSpriteComps10108 == nil then
				arg_371_1.var_.actorSpriteComps10108 = var_374_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_10 = 0.125

			if var_374_9 <= arg_371_1.time_ and arg_371_1.time_ < var_374_9 + var_374_10 and not isNil(var_374_8) then
				local var_374_11 = (arg_371_1.time_ - var_374_9) / var_374_10

				if arg_371_1.var_.actorSpriteComps10108 then
					for iter_374_4, iter_374_5 in pairs(arg_371_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_374_5 then
							if arg_371_1.isInRecall_ then
								local var_374_12 = Mathf.Lerp(iter_374_5.color.r, arg_371_1.hightColor1.r, var_374_11)
								local var_374_13 = Mathf.Lerp(iter_374_5.color.g, arg_371_1.hightColor1.g, var_374_11)
								local var_374_14 = Mathf.Lerp(iter_374_5.color.b, arg_371_1.hightColor1.b, var_374_11)

								iter_374_5.color = Color.New(var_374_12, var_374_13, var_374_14)
							else
								local var_374_15 = Mathf.Lerp(iter_374_5.color.r, 1, var_374_11)

								iter_374_5.color = Color.New(var_374_15, var_374_15, var_374_15)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= var_374_9 + var_374_10 and arg_371_1.time_ < var_374_9 + var_374_10 + arg_374_0 and not isNil(var_374_8) and arg_371_1.var_.actorSpriteComps10108 then
				for iter_374_6, iter_374_7 in pairs(arg_371_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_374_7 then
						if arg_371_1.isInRecall_ then
							iter_374_7.color = arg_371_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_374_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_371_1.var_.actorSpriteComps10108 = nil
			end

			local var_374_16 = 0
			local var_374_17 = 0.6

			if var_374_16 < arg_371_1.time_ and arg_371_1.time_ <= var_374_16 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_18 = arg_371_1:FormatText(StoryNameCfg[1083].name)

				arg_371_1.leftNameTxt_.text = var_374_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_19 = arg_371_1:GetWordFromCfg(416011090)
				local var_374_20 = arg_371_1:FormatText(var_374_19.content)

				arg_371_1.text_.text = var_374_20

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_21 = 24
				local var_374_22 = utf8.len(var_374_20)
				local var_374_23 = var_374_21 <= 0 and var_374_17 or var_374_17 * (var_374_22 / var_374_21)

				if var_374_23 > 0 and var_374_17 < var_374_23 then
					arg_371_1.talkMaxDuration = var_374_23

					if var_374_23 + var_374_16 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_23 + var_374_16
					end
				end

				arg_371_1.text_.text = var_374_20
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011090", "story_v_out_416011.awb") ~= 0 then
					local var_374_24 = manager.audio:GetVoiceLength("story_v_out_416011", "416011090", "story_v_out_416011.awb") / 1000

					if var_374_24 + var_374_16 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_24 + var_374_16
					end

					if var_374_19.prefab_name ~= "" and arg_371_1.actors_[var_374_19.prefab_name] ~= nil then
						local var_374_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_19.prefab_name].transform, "story_v_out_416011", "416011090", "story_v_out_416011.awb")

						arg_371_1:RecordAudio("416011090", var_374_25)
						arg_371_1:RecordAudio("416011090", var_374_25)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_416011", "416011090", "story_v_out_416011.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_416011", "416011090", "story_v_out_416011.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_26 = math.max(var_374_17, arg_371_1.talkMaxDuration)

			if var_374_16 <= arg_371_1.time_ and arg_371_1.time_ < var_374_16 + var_374_26 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_16) / var_374_26

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_16 + var_374_26 and arg_371_1.time_ < var_374_16 + var_374_26 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play416011091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 416011091
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play416011092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1028"].transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPos1028 = var_378_0.localPosition
				var_378_0.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("1028", 7)

				local var_378_2 = var_378_0.childCount

				for iter_378_0 = 0, var_378_2 - 1 do
					local var_378_3 = var_378_0:GetChild(iter_378_0)

					if var_378_3.name == "" or not string.find(var_378_3.name, "split") then
						var_378_3.gameObject:SetActive(true)
					else
						var_378_3.gameObject:SetActive(false)
					end
				end
			end

			local var_378_4 = 0.001

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_4 then
				local var_378_5 = (arg_375_1.time_ - var_378_1) / var_378_4
				local var_378_6 = Vector3.New(0, -2000, 0)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1028, var_378_6, var_378_5)
			end

			if arg_375_1.time_ >= var_378_1 + var_378_4 and arg_375_1.time_ < var_378_1 + var_378_4 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_378_7 = arg_375_1.actors_["10108"].transform
			local var_378_8 = 0

			if var_378_8 < arg_375_1.time_ and arg_375_1.time_ <= var_378_8 + arg_378_0 then
				arg_375_1.var_.moveOldPos10108 = var_378_7.localPosition
				var_378_7.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("10108", 7)

				local var_378_9 = var_378_7.childCount

				for iter_378_1 = 0, var_378_9 - 1 do
					local var_378_10 = var_378_7:GetChild(iter_378_1)

					if var_378_10.name == "" or not string.find(var_378_10.name, "split") then
						var_378_10.gameObject:SetActive(true)
					else
						var_378_10.gameObject:SetActive(false)
					end
				end
			end

			local var_378_11 = 0.001

			if var_378_8 <= arg_375_1.time_ and arg_375_1.time_ < var_378_8 + var_378_11 then
				local var_378_12 = (arg_375_1.time_ - var_378_8) / var_378_11
				local var_378_13 = Vector3.New(0, -2000, 0)

				var_378_7.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10108, var_378_13, var_378_12)
			end

			if arg_375_1.time_ >= var_378_8 + var_378_11 and arg_375_1.time_ < var_378_8 + var_378_11 + arg_378_0 then
				var_378_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_378_14 = 0
			local var_378_15 = 1.275

			if var_378_14 < arg_375_1.time_ and arg_375_1.time_ <= var_378_14 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_16 = arg_375_1:GetWordFromCfg(416011091)
				local var_378_17 = arg_375_1:FormatText(var_378_16.content)

				arg_375_1.text_.text = var_378_17

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_18 = 51
				local var_378_19 = utf8.len(var_378_17)
				local var_378_20 = var_378_18 <= 0 and var_378_15 or var_378_15 * (var_378_19 / var_378_18)

				if var_378_20 > 0 and var_378_15 < var_378_20 then
					arg_375_1.talkMaxDuration = var_378_20

					if var_378_20 + var_378_14 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_20 + var_378_14
					end
				end

				arg_375_1.text_.text = var_378_17
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_21 = math.max(var_378_15, arg_375_1.talkMaxDuration)

			if var_378_14 <= arg_375_1.time_ and arg_375_1.time_ < var_378_14 + var_378_21 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_14) / var_378_21

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_14 + var_378_21 and arg_375_1.time_ < var_378_14 + var_378_21 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play416011092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 416011092
		arg_379_1.duration_ = 4.97

		local var_379_0 = {
			zh = 2.5,
			ja = 4.966
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
				arg_379_0:Play416011093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["10108"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.actorSpriteComps10108 == nil then
				arg_379_1.var_.actorSpriteComps10108 = var_382_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_2 = 0.125

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.actorSpriteComps10108 then
					for iter_382_0, iter_382_1 in pairs(arg_379_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_382_1 then
							if arg_379_1.isInRecall_ then
								local var_382_4 = Mathf.Lerp(iter_382_1.color.r, arg_379_1.hightColor1.r, var_382_3)
								local var_382_5 = Mathf.Lerp(iter_382_1.color.g, arg_379_1.hightColor1.g, var_382_3)
								local var_382_6 = Mathf.Lerp(iter_382_1.color.b, arg_379_1.hightColor1.b, var_382_3)

								iter_382_1.color = Color.New(var_382_4, var_382_5, var_382_6)
							else
								local var_382_7 = Mathf.Lerp(iter_382_1.color.r, 1, var_382_3)

								iter_382_1.color = Color.New(var_382_7, var_382_7, var_382_7)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.actorSpriteComps10108 then
				for iter_382_2, iter_382_3 in pairs(arg_379_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_382_3 then
						if arg_379_1.isInRecall_ then
							iter_382_3.color = arg_379_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_382_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_379_1.var_.actorSpriteComps10108 = nil
			end

			local var_382_8 = arg_379_1.actors_["10108"].transform
			local var_382_9 = 0

			if var_382_9 < arg_379_1.time_ and arg_379_1.time_ <= var_382_9 + arg_382_0 then
				arg_379_1.var_.moveOldPos10108 = var_382_8.localPosition
				var_382_8.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("10108", 3)

				local var_382_10 = var_382_8.childCount

				for iter_382_4 = 0, var_382_10 - 1 do
					local var_382_11 = var_382_8:GetChild(iter_382_4)

					if var_382_11.name == "split_2" or not string.find(var_382_11.name, "split") then
						var_382_11.gameObject:SetActive(true)
					else
						var_382_11.gameObject:SetActive(false)
					end
				end
			end

			local var_382_12 = 0.001

			if var_382_9 <= arg_379_1.time_ and arg_379_1.time_ < var_382_9 + var_382_12 then
				local var_382_13 = (arg_379_1.time_ - var_382_9) / var_382_12
				local var_382_14 = Vector3.New(0, -399.6, -130)

				var_382_8.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos10108, var_382_14, var_382_13)
			end

			if arg_379_1.time_ >= var_382_9 + var_382_12 and arg_379_1.time_ < var_382_9 + var_382_12 + arg_382_0 then
				var_382_8.localPosition = Vector3.New(0, -399.6, -130)
			end

			local var_382_15 = 0
			local var_382_16 = 0.225

			if var_382_15 < arg_379_1.time_ and arg_379_1.time_ <= var_382_15 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_17 = arg_379_1:FormatText(StoryNameCfg[1083].name)

				arg_379_1.leftNameTxt_.text = var_382_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_18 = arg_379_1:GetWordFromCfg(416011092)
				local var_382_19 = arg_379_1:FormatText(var_382_18.content)

				arg_379_1.text_.text = var_382_19

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_20 = 9
				local var_382_21 = utf8.len(var_382_19)
				local var_382_22 = var_382_20 <= 0 and var_382_16 or var_382_16 * (var_382_21 / var_382_20)

				if var_382_22 > 0 and var_382_16 < var_382_22 then
					arg_379_1.talkMaxDuration = var_382_22

					if var_382_22 + var_382_15 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_22 + var_382_15
					end
				end

				arg_379_1.text_.text = var_382_19
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011092", "story_v_out_416011.awb") ~= 0 then
					local var_382_23 = manager.audio:GetVoiceLength("story_v_out_416011", "416011092", "story_v_out_416011.awb") / 1000

					if var_382_23 + var_382_15 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_23 + var_382_15
					end

					if var_382_18.prefab_name ~= "" and arg_379_1.actors_[var_382_18.prefab_name] ~= nil then
						local var_382_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_18.prefab_name].transform, "story_v_out_416011", "416011092", "story_v_out_416011.awb")

						arg_379_1:RecordAudio("416011092", var_382_24)
						arg_379_1:RecordAudio("416011092", var_382_24)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_416011", "416011092", "story_v_out_416011.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_416011", "416011092", "story_v_out_416011.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_25 = math.max(var_382_16, arg_379_1.talkMaxDuration)

			if var_382_15 <= arg_379_1.time_ and arg_379_1.time_ < var_382_15 + var_382_25 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_15) / var_382_25

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_15 + var_382_25 and arg_379_1.time_ < var_382_15 + var_382_25 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play416011093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 416011093
		arg_383_1.duration_ = 10.3

		local var_383_0 = {
			zh = 9.2,
			ja = 10.3
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
				arg_383_0:Play416011094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = "I13f"

			if arg_383_1.bgs_[var_386_0] == nil then
				local var_386_1 = Object.Instantiate(arg_383_1.paintGo_)

				var_386_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_386_0)
				var_386_1.name = var_386_0
				var_386_1.transform.parent = arg_383_1.stage_.transform
				var_386_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_383_1.bgs_[var_386_0] = var_386_1
			end

			local var_386_2 = 2

			if var_386_2 < arg_383_1.time_ and arg_383_1.time_ <= var_386_2 + arg_386_0 then
				local var_386_3 = manager.ui.mainCamera.transform.localPosition
				local var_386_4 = Vector3.New(0, 0, 10) + Vector3.New(var_386_3.x, var_386_3.y, 0)
				local var_386_5 = arg_383_1.bgs_.I13f

				var_386_5.transform.localPosition = var_386_4
				var_386_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_386_6 = var_386_5:GetComponent("SpriteRenderer")

				if var_386_6 and var_386_6.sprite then
					local var_386_7 = (var_386_5.transform.localPosition - var_386_3).z
					local var_386_8 = manager.ui.mainCameraCom_
					local var_386_9 = 2 * var_386_7 * Mathf.Tan(var_386_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_386_10 = var_386_9 * var_386_8.aspect
					local var_386_11 = var_386_6.sprite.bounds.size.x
					local var_386_12 = var_386_6.sprite.bounds.size.y
					local var_386_13 = var_386_10 / var_386_11
					local var_386_14 = var_386_9 / var_386_12
					local var_386_15 = var_386_14 < var_386_13 and var_386_13 or var_386_14

					var_386_5.transform.localScale = Vector3.New(var_386_15, var_386_15, 0)
				end

				for iter_386_0, iter_386_1 in pairs(arg_383_1.bgs_) do
					if iter_386_0 ~= "I13f" then
						iter_386_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_386_16 = 0

			if var_386_16 < arg_383_1.time_ and arg_383_1.time_ <= var_386_16 + arg_386_0 then
				arg_383_1.mask_.enabled = true
				arg_383_1.mask_.raycastTarget = true

				arg_383_1:SetGaussion(false)
			end

			local var_386_17 = 2

			if var_386_16 <= arg_383_1.time_ and arg_383_1.time_ < var_386_16 + var_386_17 then
				local var_386_18 = (arg_383_1.time_ - var_386_16) / var_386_17
				local var_386_19 = Color.New(0, 0, 0)

				var_386_19.a = Mathf.Lerp(0, 1, var_386_18)
				arg_383_1.mask_.color = var_386_19
			end

			if arg_383_1.time_ >= var_386_16 + var_386_17 and arg_383_1.time_ < var_386_16 + var_386_17 + arg_386_0 then
				local var_386_20 = Color.New(0, 0, 0)

				var_386_20.a = 1
				arg_383_1.mask_.color = var_386_20
			end

			local var_386_21 = 2

			if var_386_21 < arg_383_1.time_ and arg_383_1.time_ <= var_386_21 + arg_386_0 then
				arg_383_1.mask_.enabled = true
				arg_383_1.mask_.raycastTarget = true

				arg_383_1:SetGaussion(false)
			end

			local var_386_22 = 2

			if var_386_21 <= arg_383_1.time_ and arg_383_1.time_ < var_386_21 + var_386_22 then
				local var_386_23 = (arg_383_1.time_ - var_386_21) / var_386_22
				local var_386_24 = Color.New(0, 0, 0)

				var_386_24.a = Mathf.Lerp(1, 0, var_386_23)
				arg_383_1.mask_.color = var_386_24
			end

			if arg_383_1.time_ >= var_386_21 + var_386_22 and arg_383_1.time_ < var_386_21 + var_386_22 + arg_386_0 then
				local var_386_25 = Color.New(0, 0, 0)
				local var_386_26 = 0

				arg_383_1.mask_.enabled = false
				var_386_25.a = var_386_26
				arg_383_1.mask_.color = var_386_25
			end

			local var_386_27 = arg_383_1.actors_["10108"].transform
			local var_386_28 = 1.966

			if var_386_28 < arg_383_1.time_ and arg_383_1.time_ <= var_386_28 + arg_386_0 then
				arg_383_1.var_.moveOldPos10108 = var_386_27.localPosition
				var_386_27.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("10108", 7)

				local var_386_29 = var_386_27.childCount

				for iter_386_2 = 0, var_386_29 - 1 do
					local var_386_30 = var_386_27:GetChild(iter_386_2)

					if var_386_30.name == "" or not string.find(var_386_30.name, "split") then
						var_386_30.gameObject:SetActive(true)
					else
						var_386_30.gameObject:SetActive(false)
					end
				end
			end

			local var_386_31 = 0.001

			if var_386_28 <= arg_383_1.time_ and arg_383_1.time_ < var_386_28 + var_386_31 then
				local var_386_32 = (arg_383_1.time_ - var_386_28) / var_386_31
				local var_386_33 = Vector3.New(0, -2000, 0)

				var_386_27.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10108, var_386_33, var_386_32)
			end

			if arg_383_1.time_ >= var_386_28 + var_386_31 and arg_383_1.time_ < var_386_28 + var_386_31 + arg_386_0 then
				var_386_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_386_34 = 0
			local var_386_35 = 0.2

			if var_386_34 < arg_383_1.time_ and arg_383_1.time_ <= var_386_34 + arg_386_0 then
				local var_386_36 = "play"
				local var_386_37 = "music"

				arg_383_1:AudioAction(var_386_36, var_386_37, "ui_battle", "ui_battle_stopbgm", "")

				local var_386_38 = ""
				local var_386_39 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_386_39 ~= "" then
					if arg_383_1.bgmTxt_.text ~= var_386_39 and arg_383_1.bgmTxt_.text ~= "" then
						if arg_383_1.bgmTxt2_.text ~= "" then
							arg_383_1.bgmTxt_.text = arg_383_1.bgmTxt2_.text
						end

						arg_383_1.bgmTxt2_.text = var_386_39

						arg_383_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_383_1.bgmTxt_.text = var_386_39
						arg_383_1.bgmTxt2_.text = var_386_39
					end

					if arg_383_1.bgmTimer then
						arg_383_1.bgmTimer:Stop()

						arg_383_1.bgmTimer = nil
					end

					if arg_383_1.settingData.show_music_name == 1 then
						arg_383_1.musicController:SetSelectedState("show")
						arg_383_1.musicAnimator_:Play("open", 0, 0)

						if arg_383_1.settingData.music_time ~= 0 then
							arg_383_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_383_1.settingData.music_time), function()
								if arg_383_1 == nil or isNil(arg_383_1.bgmTxt_) then
									return
								end

								arg_383_1.musicController:SetSelectedState("hide")
								arg_383_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_383_1.frameCnt_ <= 1 then
				arg_383_1.dialog_:SetActive(false)
			end

			local var_386_40 = 4
			local var_386_41 = 0.525

			if var_386_40 < arg_383_1.time_ and arg_383_1.time_ <= var_386_40 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0

				arg_383_1.dialog_:SetActive(true)

				arg_383_1.dialogCg_.alpha = 0

				local var_386_42 = LeanTween.value(arg_383_1.dialog_, 0, 1, 0.3)

				var_386_42:setOnUpdate(LuaHelper.FloatAction(function(arg_388_0)
					arg_383_1.dialogCg_.alpha = arg_388_0
				end))
				var_386_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_383_1.dialog_)
					var_386_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_383_1.duration_ = arg_383_1.duration_ + 0.3

				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_43 = arg_383_1:FormatText(StoryNameCfg[585].name)

				arg_383_1.leftNameTxt_.text = var_386_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_44 = arg_383_1:GetWordFromCfg(416011093)
				local var_386_45 = arg_383_1:FormatText(var_386_44.content)

				arg_383_1.text_.text = var_386_45

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_46 = 21
				local var_386_47 = utf8.len(var_386_45)
				local var_386_48 = var_386_46 <= 0 and var_386_41 or var_386_41 * (var_386_47 / var_386_46)

				if var_386_48 > 0 and var_386_41 < var_386_48 then
					arg_383_1.talkMaxDuration = var_386_48
					var_386_40 = var_386_40 + 0.3

					if var_386_48 + var_386_40 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_48 + var_386_40
					end
				end

				arg_383_1.text_.text = var_386_45
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011093", "story_v_out_416011.awb") ~= 0 then
					local var_386_49 = manager.audio:GetVoiceLength("story_v_out_416011", "416011093", "story_v_out_416011.awb") / 1000

					if var_386_49 + var_386_40 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_49 + var_386_40
					end

					if var_386_44.prefab_name ~= "" and arg_383_1.actors_[var_386_44.prefab_name] ~= nil then
						local var_386_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_44.prefab_name].transform, "story_v_out_416011", "416011093", "story_v_out_416011.awb")

						arg_383_1:RecordAudio("416011093", var_386_50)
						arg_383_1:RecordAudio("416011093", var_386_50)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_416011", "416011093", "story_v_out_416011.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_416011", "416011093", "story_v_out_416011.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_51 = var_386_40 + 0.3
			local var_386_52 = math.max(var_386_41, arg_383_1.talkMaxDuration)

			if var_386_51 <= arg_383_1.time_ and arg_383_1.time_ < var_386_51 + var_386_52 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_51) / var_386_52

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_51 + var_386_52 and arg_383_1.time_ < var_386_51 + var_386_52 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play416011094 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 416011094
		arg_390_1.duration_ = 6.5

		local var_390_0 = {
			zh = 5,
			ja = 6.5
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play416011095(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["1148"].transform
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.var_.moveOldPos1148 = var_393_0.localPosition
				var_393_0.localScale = Vector3.New(1, 1, 1)

				arg_390_1:CheckSpriteTmpPos("1148", 3)

				local var_393_2 = var_393_0.childCount

				for iter_393_0 = 0, var_393_2 - 1 do
					local var_393_3 = var_393_0:GetChild(iter_393_0)

					if var_393_3.name == "" or not string.find(var_393_3.name, "split") then
						var_393_3.gameObject:SetActive(true)
					else
						var_393_3.gameObject:SetActive(false)
					end
				end
			end

			local var_393_4 = 0.001

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_4 then
				local var_393_5 = (arg_390_1.time_ - var_393_1) / var_393_4
				local var_393_6 = Vector3.New(0, -429, -180)

				var_393_0.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1148, var_393_6, var_393_5)
			end

			if arg_390_1.time_ >= var_393_1 + var_393_4 and arg_390_1.time_ < var_393_1 + var_393_4 + arg_393_0 then
				var_393_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_393_7 = arg_390_1.actors_["1148"]
			local var_393_8 = 0

			if var_393_8 < arg_390_1.time_ and arg_390_1.time_ <= var_393_8 + arg_393_0 and not isNil(var_393_7) and arg_390_1.var_.actorSpriteComps1148 == nil then
				arg_390_1.var_.actorSpriteComps1148 = var_393_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_9 = 0.125

			if var_393_8 <= arg_390_1.time_ and arg_390_1.time_ < var_393_8 + var_393_9 and not isNil(var_393_7) then
				local var_393_10 = (arg_390_1.time_ - var_393_8) / var_393_9

				if arg_390_1.var_.actorSpriteComps1148 then
					for iter_393_1, iter_393_2 in pairs(arg_390_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_393_2 then
							if arg_390_1.isInRecall_ then
								local var_393_11 = Mathf.Lerp(iter_393_2.color.r, arg_390_1.hightColor1.r, var_393_10)
								local var_393_12 = Mathf.Lerp(iter_393_2.color.g, arg_390_1.hightColor1.g, var_393_10)
								local var_393_13 = Mathf.Lerp(iter_393_2.color.b, arg_390_1.hightColor1.b, var_393_10)

								iter_393_2.color = Color.New(var_393_11, var_393_12, var_393_13)
							else
								local var_393_14 = Mathf.Lerp(iter_393_2.color.r, 1, var_393_10)

								iter_393_2.color = Color.New(var_393_14, var_393_14, var_393_14)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= var_393_8 + var_393_9 and arg_390_1.time_ < var_393_8 + var_393_9 + arg_393_0 and not isNil(var_393_7) and arg_390_1.var_.actorSpriteComps1148 then
				for iter_393_3, iter_393_4 in pairs(arg_390_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_393_4 then
						if arg_390_1.isInRecall_ then
							iter_393_4.color = arg_390_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_393_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_390_1.var_.actorSpriteComps1148 = nil
			end

			local var_393_15 = 0
			local var_393_16 = 0.6

			if var_393_15 < arg_390_1.time_ and arg_390_1.time_ <= var_393_15 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_17 = arg_390_1:FormatText(StoryNameCfg[8].name)

				arg_390_1.leftNameTxt_.text = var_393_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_18 = arg_390_1:GetWordFromCfg(416011094)
				local var_393_19 = arg_390_1:FormatText(var_393_18.content)

				arg_390_1.text_.text = var_393_19

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_20 = 24
				local var_393_21 = utf8.len(var_393_19)
				local var_393_22 = var_393_20 <= 0 and var_393_16 or var_393_16 * (var_393_21 / var_393_20)

				if var_393_22 > 0 and var_393_16 < var_393_22 then
					arg_390_1.talkMaxDuration = var_393_22

					if var_393_22 + var_393_15 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_22 + var_393_15
					end
				end

				arg_390_1.text_.text = var_393_19
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011094", "story_v_out_416011.awb") ~= 0 then
					local var_393_23 = manager.audio:GetVoiceLength("story_v_out_416011", "416011094", "story_v_out_416011.awb") / 1000

					if var_393_23 + var_393_15 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_23 + var_393_15
					end

					if var_393_18.prefab_name ~= "" and arg_390_1.actors_[var_393_18.prefab_name] ~= nil then
						local var_393_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_18.prefab_name].transform, "story_v_out_416011", "416011094", "story_v_out_416011.awb")

						arg_390_1:RecordAudio("416011094", var_393_24)
						arg_390_1:RecordAudio("416011094", var_393_24)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_416011", "416011094", "story_v_out_416011.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_416011", "416011094", "story_v_out_416011.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_25 = math.max(var_393_16, arg_390_1.talkMaxDuration)

			if var_393_15 <= arg_390_1.time_ and arg_390_1.time_ < var_393_15 + var_393_25 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_15) / var_393_25

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_15 + var_393_25 and arg_390_1.time_ < var_393_15 + var_393_25 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play416011095 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 416011095
		arg_394_1.duration_ = 6.67

		local var_394_0 = {
			zh = 4.5,
			ja = 6.666
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play416011096(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0
			local var_397_1 = 0.425

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_2 = arg_394_1:FormatText(StoryNameCfg[8].name)

				arg_394_1.leftNameTxt_.text = var_397_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_3 = arg_394_1:GetWordFromCfg(416011095)
				local var_397_4 = arg_394_1:FormatText(var_397_3.content)

				arg_394_1.text_.text = var_397_4

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_5 = 17
				local var_397_6 = utf8.len(var_397_4)
				local var_397_7 = var_397_5 <= 0 and var_397_1 or var_397_1 * (var_397_6 / var_397_5)

				if var_397_7 > 0 and var_397_1 < var_397_7 then
					arg_394_1.talkMaxDuration = var_397_7

					if var_397_7 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_7 + var_397_0
					end
				end

				arg_394_1.text_.text = var_397_4
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011095", "story_v_out_416011.awb") ~= 0 then
					local var_397_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011095", "story_v_out_416011.awb") / 1000

					if var_397_8 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_8 + var_397_0
					end

					if var_397_3.prefab_name ~= "" and arg_394_1.actors_[var_397_3.prefab_name] ~= nil then
						local var_397_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_3.prefab_name].transform, "story_v_out_416011", "416011095", "story_v_out_416011.awb")

						arg_394_1:RecordAudio("416011095", var_397_9)
						arg_394_1:RecordAudio("416011095", var_397_9)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_416011", "416011095", "story_v_out_416011.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_416011", "416011095", "story_v_out_416011.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_10 = math.max(var_397_1, arg_394_1.talkMaxDuration)

			if var_397_0 <= arg_394_1.time_ and arg_394_1.time_ < var_397_0 + var_397_10 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_0) / var_397_10

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_0 + var_397_10 and arg_394_1.time_ < var_397_0 + var_397_10 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play416011096 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 416011096
		arg_398_1.duration_ = 4.7

		local var_398_0 = {
			zh = 3.433,
			ja = 4.7
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play416011097(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["1148"]
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.actorSpriteComps1148 == nil then
				arg_398_1.var_.actorSpriteComps1148 = var_401_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_401_2 = 0.125

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_2 and not isNil(var_401_0) then
				local var_401_3 = (arg_398_1.time_ - var_401_1) / var_401_2

				if arg_398_1.var_.actorSpriteComps1148 then
					for iter_401_0, iter_401_1 in pairs(arg_398_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_401_1 then
							if arg_398_1.isInRecall_ then
								local var_401_4 = Mathf.Lerp(iter_401_1.color.r, arg_398_1.hightColor2.r, var_401_3)
								local var_401_5 = Mathf.Lerp(iter_401_1.color.g, arg_398_1.hightColor2.g, var_401_3)
								local var_401_6 = Mathf.Lerp(iter_401_1.color.b, arg_398_1.hightColor2.b, var_401_3)

								iter_401_1.color = Color.New(var_401_4, var_401_5, var_401_6)
							else
								local var_401_7 = Mathf.Lerp(iter_401_1.color.r, 0.5, var_401_3)

								iter_401_1.color = Color.New(var_401_7, var_401_7, var_401_7)
							end
						end
					end
				end
			end

			if arg_398_1.time_ >= var_401_1 + var_401_2 and arg_398_1.time_ < var_401_1 + var_401_2 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.actorSpriteComps1148 then
				for iter_401_2, iter_401_3 in pairs(arg_398_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_401_3 then
						if arg_398_1.isInRecall_ then
							iter_401_3.color = arg_398_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_401_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_398_1.var_.actorSpriteComps1148 = nil
			end

			local var_401_8 = 0
			local var_401_9 = 0.275

			if var_401_8 < arg_398_1.time_ and arg_398_1.time_ <= var_401_8 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_10 = arg_398_1:FormatText(StoryNameCfg[585].name)

				arg_398_1.leftNameTxt_.text = var_401_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_11 = arg_398_1:GetWordFromCfg(416011096)
				local var_401_12 = arg_398_1:FormatText(var_401_11.content)

				arg_398_1.text_.text = var_401_12

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_13 = 11
				local var_401_14 = utf8.len(var_401_12)
				local var_401_15 = var_401_13 <= 0 and var_401_9 or var_401_9 * (var_401_14 / var_401_13)

				if var_401_15 > 0 and var_401_9 < var_401_15 then
					arg_398_1.talkMaxDuration = var_401_15

					if var_401_15 + var_401_8 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_15 + var_401_8
					end
				end

				arg_398_1.text_.text = var_401_12
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011096", "story_v_out_416011.awb") ~= 0 then
					local var_401_16 = manager.audio:GetVoiceLength("story_v_out_416011", "416011096", "story_v_out_416011.awb") / 1000

					if var_401_16 + var_401_8 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_16 + var_401_8
					end

					if var_401_11.prefab_name ~= "" and arg_398_1.actors_[var_401_11.prefab_name] ~= nil then
						local var_401_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_11.prefab_name].transform, "story_v_out_416011", "416011096", "story_v_out_416011.awb")

						arg_398_1:RecordAudio("416011096", var_401_17)
						arg_398_1:RecordAudio("416011096", var_401_17)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_416011", "416011096", "story_v_out_416011.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_416011", "416011096", "story_v_out_416011.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_18 = math.max(var_401_9, arg_398_1.talkMaxDuration)

			if var_401_8 <= arg_398_1.time_ and arg_398_1.time_ < var_401_8 + var_401_18 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_8) / var_401_18

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_8 + var_401_18 and arg_398_1.time_ < var_401_8 + var_401_18 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play416011097 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 416011097
		arg_402_1.duration_ = 3.67

		local var_402_0 = {
			zh = 2.4,
			ja = 3.666
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play416011098(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["1148"]
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.actorSpriteComps1148 == nil then
				arg_402_1.var_.actorSpriteComps1148 = var_405_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_2 = 0.125

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_2 and not isNil(var_405_0) then
				local var_405_3 = (arg_402_1.time_ - var_405_1) / var_405_2

				if arg_402_1.var_.actorSpriteComps1148 then
					for iter_405_0, iter_405_1 in pairs(arg_402_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_405_1 then
							if arg_402_1.isInRecall_ then
								local var_405_4 = Mathf.Lerp(iter_405_1.color.r, arg_402_1.hightColor1.r, var_405_3)
								local var_405_5 = Mathf.Lerp(iter_405_1.color.g, arg_402_1.hightColor1.g, var_405_3)
								local var_405_6 = Mathf.Lerp(iter_405_1.color.b, arg_402_1.hightColor1.b, var_405_3)

								iter_405_1.color = Color.New(var_405_4, var_405_5, var_405_6)
							else
								local var_405_7 = Mathf.Lerp(iter_405_1.color.r, 1, var_405_3)

								iter_405_1.color = Color.New(var_405_7, var_405_7, var_405_7)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= var_405_1 + var_405_2 and arg_402_1.time_ < var_405_1 + var_405_2 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.actorSpriteComps1148 then
				for iter_405_2, iter_405_3 in pairs(arg_402_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_405_3 then
						if arg_402_1.isInRecall_ then
							iter_405_3.color = arg_402_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_405_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_402_1.var_.actorSpriteComps1148 = nil
			end

			local var_405_8 = 0
			local var_405_9 = 0.25

			if var_405_8 < arg_402_1.time_ and arg_402_1.time_ <= var_405_8 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_10 = arg_402_1:FormatText(StoryNameCfg[8].name)

				arg_402_1.leftNameTxt_.text = var_405_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_11 = arg_402_1:GetWordFromCfg(416011097)
				local var_405_12 = arg_402_1:FormatText(var_405_11.content)

				arg_402_1.text_.text = var_405_12

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_13 = 10
				local var_405_14 = utf8.len(var_405_12)
				local var_405_15 = var_405_13 <= 0 and var_405_9 or var_405_9 * (var_405_14 / var_405_13)

				if var_405_15 > 0 and var_405_9 < var_405_15 then
					arg_402_1.talkMaxDuration = var_405_15

					if var_405_15 + var_405_8 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_15 + var_405_8
					end
				end

				arg_402_1.text_.text = var_405_12
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011097", "story_v_out_416011.awb") ~= 0 then
					local var_405_16 = manager.audio:GetVoiceLength("story_v_out_416011", "416011097", "story_v_out_416011.awb") / 1000

					if var_405_16 + var_405_8 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_16 + var_405_8
					end

					if var_405_11.prefab_name ~= "" and arg_402_1.actors_[var_405_11.prefab_name] ~= nil then
						local var_405_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_11.prefab_name].transform, "story_v_out_416011", "416011097", "story_v_out_416011.awb")

						arg_402_1:RecordAudio("416011097", var_405_17)
						arg_402_1:RecordAudio("416011097", var_405_17)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_416011", "416011097", "story_v_out_416011.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_416011", "416011097", "story_v_out_416011.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_18 = math.max(var_405_9, arg_402_1.talkMaxDuration)

			if var_405_8 <= arg_402_1.time_ and arg_402_1.time_ < var_405_8 + var_405_18 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_8) / var_405_18

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_8 + var_405_18 and arg_402_1.time_ < var_405_8 + var_405_18 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play416011098 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 416011098
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play416011099(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["1148"].transform
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 then
				arg_406_1.var_.moveOldPos1148 = var_409_0.localPosition
				var_409_0.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("1148", 7)

				local var_409_2 = var_409_0.childCount

				for iter_409_0 = 0, var_409_2 - 1 do
					local var_409_3 = var_409_0:GetChild(iter_409_0)

					if var_409_3.name == "" or not string.find(var_409_3.name, "split") then
						var_409_3.gameObject:SetActive(true)
					else
						var_409_3.gameObject:SetActive(false)
					end
				end
			end

			local var_409_4 = 0.001

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_4 then
				local var_409_5 = (arg_406_1.time_ - var_409_1) / var_409_4
				local var_409_6 = Vector3.New(0, -2000, 0)

				var_409_0.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1148, var_409_6, var_409_5)
			end

			if arg_406_1.time_ >= var_409_1 + var_409_4 and arg_406_1.time_ < var_409_1 + var_409_4 + arg_409_0 then
				var_409_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_409_7 = 0
			local var_409_8 = 1

			if var_409_7 < arg_406_1.time_ and arg_406_1.time_ <= var_409_7 + arg_409_0 then
				local var_409_9 = "play"
				local var_409_10 = "effect"

				arg_406_1:AudioAction(var_409_9, var_409_10, "se_story_133", "se_story_133_sea", "")
			end

			local var_409_11 = 0
			local var_409_12 = 2.075

			if var_409_11 < arg_406_1.time_ and arg_406_1.time_ <= var_409_11 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, false)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_13 = arg_406_1:GetWordFromCfg(416011098)
				local var_409_14 = arg_406_1:FormatText(var_409_13.content)

				arg_406_1.text_.text = var_409_14

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_15 = 83
				local var_409_16 = utf8.len(var_409_14)
				local var_409_17 = var_409_15 <= 0 and var_409_12 or var_409_12 * (var_409_16 / var_409_15)

				if var_409_17 > 0 and var_409_12 < var_409_17 then
					arg_406_1.talkMaxDuration = var_409_17

					if var_409_17 + var_409_11 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_17 + var_409_11
					end
				end

				arg_406_1.text_.text = var_409_14
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_18 = math.max(var_409_12, arg_406_1.talkMaxDuration)

			if var_409_11 <= arg_406_1.time_ and arg_406_1.time_ < var_409_11 + var_409_18 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_11) / var_409_18

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_11 + var_409_18 and arg_406_1.time_ < var_409_11 + var_409_18 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play416011099 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 416011099
		arg_410_1.duration_ = 7.93

		local var_410_0 = {
			zh = 4.933,
			ja = 7.933
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play416011100(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["1148"].transform
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.var_.moveOldPos1148 = var_413_0.localPosition
				var_413_0.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("1148", 3)

				local var_413_2 = var_413_0.childCount

				for iter_413_0 = 0, var_413_2 - 1 do
					local var_413_3 = var_413_0:GetChild(iter_413_0)

					if var_413_3.name == "" or not string.find(var_413_3.name, "split") then
						var_413_3.gameObject:SetActive(true)
					else
						var_413_3.gameObject:SetActive(false)
					end
				end
			end

			local var_413_4 = 0.001

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_4 then
				local var_413_5 = (arg_410_1.time_ - var_413_1) / var_413_4
				local var_413_6 = Vector3.New(0, -429, -180)

				var_413_0.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1148, var_413_6, var_413_5)
			end

			if arg_410_1.time_ >= var_413_1 + var_413_4 and arg_410_1.time_ < var_413_1 + var_413_4 + arg_413_0 then
				var_413_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_413_7 = arg_410_1.actors_["1148"]
			local var_413_8 = 0

			if var_413_8 < arg_410_1.time_ and arg_410_1.time_ <= var_413_8 + arg_413_0 and not isNil(var_413_7) and arg_410_1.var_.actorSpriteComps1148 == nil then
				arg_410_1.var_.actorSpriteComps1148 = var_413_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_9 = 0.125

			if var_413_8 <= arg_410_1.time_ and arg_410_1.time_ < var_413_8 + var_413_9 and not isNil(var_413_7) then
				local var_413_10 = (arg_410_1.time_ - var_413_8) / var_413_9

				if arg_410_1.var_.actorSpriteComps1148 then
					for iter_413_1, iter_413_2 in pairs(arg_410_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_413_2 then
							if arg_410_1.isInRecall_ then
								local var_413_11 = Mathf.Lerp(iter_413_2.color.r, arg_410_1.hightColor1.r, var_413_10)
								local var_413_12 = Mathf.Lerp(iter_413_2.color.g, arg_410_1.hightColor1.g, var_413_10)
								local var_413_13 = Mathf.Lerp(iter_413_2.color.b, arg_410_1.hightColor1.b, var_413_10)

								iter_413_2.color = Color.New(var_413_11, var_413_12, var_413_13)
							else
								local var_413_14 = Mathf.Lerp(iter_413_2.color.r, 1, var_413_10)

								iter_413_2.color = Color.New(var_413_14, var_413_14, var_413_14)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= var_413_8 + var_413_9 and arg_410_1.time_ < var_413_8 + var_413_9 + arg_413_0 and not isNil(var_413_7) and arg_410_1.var_.actorSpriteComps1148 then
				for iter_413_3, iter_413_4 in pairs(arg_410_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_413_4 then
						if arg_410_1.isInRecall_ then
							iter_413_4.color = arg_410_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_413_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_410_1.var_.actorSpriteComps1148 = nil
			end

			local var_413_15 = 0
			local var_413_16 = 0.5

			if var_413_15 < arg_410_1.time_ and arg_410_1.time_ <= var_413_15 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_17 = arg_410_1:FormatText(StoryNameCfg[8].name)

				arg_410_1.leftNameTxt_.text = var_413_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_18 = arg_410_1:GetWordFromCfg(416011099)
				local var_413_19 = arg_410_1:FormatText(var_413_18.content)

				arg_410_1.text_.text = var_413_19

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_20 = 20
				local var_413_21 = utf8.len(var_413_19)
				local var_413_22 = var_413_20 <= 0 and var_413_16 or var_413_16 * (var_413_21 / var_413_20)

				if var_413_22 > 0 and var_413_16 < var_413_22 then
					arg_410_1.talkMaxDuration = var_413_22

					if var_413_22 + var_413_15 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_22 + var_413_15
					end
				end

				arg_410_1.text_.text = var_413_19
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011099", "story_v_out_416011.awb") ~= 0 then
					local var_413_23 = manager.audio:GetVoiceLength("story_v_out_416011", "416011099", "story_v_out_416011.awb") / 1000

					if var_413_23 + var_413_15 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_23 + var_413_15
					end

					if var_413_18.prefab_name ~= "" and arg_410_1.actors_[var_413_18.prefab_name] ~= nil then
						local var_413_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_18.prefab_name].transform, "story_v_out_416011", "416011099", "story_v_out_416011.awb")

						arg_410_1:RecordAudio("416011099", var_413_24)
						arg_410_1:RecordAudio("416011099", var_413_24)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_416011", "416011099", "story_v_out_416011.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_416011", "416011099", "story_v_out_416011.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_25 = math.max(var_413_16, arg_410_1.talkMaxDuration)

			if var_413_15 <= arg_410_1.time_ and arg_410_1.time_ < var_413_15 + var_413_25 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_15) / var_413_25

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_15 + var_413_25 and arg_410_1.time_ < var_413_15 + var_413_25 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play416011100 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 416011100
		arg_414_1.duration_ = 8.6

		local var_414_0 = {
			zh = 8.566,
			ja = 8.6
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play416011101(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0
			local var_417_1 = 0.7

			if var_417_0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_2 = arg_414_1:FormatText(StoryNameCfg[8].name)

				arg_414_1.leftNameTxt_.text = var_417_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_3 = arg_414_1:GetWordFromCfg(416011100)
				local var_417_4 = arg_414_1:FormatText(var_417_3.content)

				arg_414_1.text_.text = var_417_4

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_5 = 28
				local var_417_6 = utf8.len(var_417_4)
				local var_417_7 = var_417_5 <= 0 and var_417_1 or var_417_1 * (var_417_6 / var_417_5)

				if var_417_7 > 0 and var_417_1 < var_417_7 then
					arg_414_1.talkMaxDuration = var_417_7

					if var_417_7 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_7 + var_417_0
					end
				end

				arg_414_1.text_.text = var_417_4
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011100", "story_v_out_416011.awb") ~= 0 then
					local var_417_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011100", "story_v_out_416011.awb") / 1000

					if var_417_8 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_8 + var_417_0
					end

					if var_417_3.prefab_name ~= "" and arg_414_1.actors_[var_417_3.prefab_name] ~= nil then
						local var_417_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_3.prefab_name].transform, "story_v_out_416011", "416011100", "story_v_out_416011.awb")

						arg_414_1:RecordAudio("416011100", var_417_9)
						arg_414_1:RecordAudio("416011100", var_417_9)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_416011", "416011100", "story_v_out_416011.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_416011", "416011100", "story_v_out_416011.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_10 = math.max(var_417_1, arg_414_1.talkMaxDuration)

			if var_417_0 <= arg_414_1.time_ and arg_414_1.time_ < var_417_0 + var_417_10 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_0) / var_417_10

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_0 + var_417_10 and arg_414_1.time_ < var_417_0 + var_417_10 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play416011101 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 416011101
		arg_418_1.duration_ = 9

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play416011102(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = "SS1601"

			if arg_418_1.bgs_[var_421_0] == nil then
				local var_421_1 = Object.Instantiate(arg_418_1.paintGo_)

				var_421_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_421_0)
				var_421_1.name = var_421_0
				var_421_1.transform.parent = arg_418_1.stage_.transform
				var_421_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_418_1.bgs_[var_421_0] = var_421_1
			end

			local var_421_2 = 2

			if var_421_2 < arg_418_1.time_ and arg_418_1.time_ <= var_421_2 + arg_421_0 then
				local var_421_3 = manager.ui.mainCamera.transform.localPosition
				local var_421_4 = Vector3.New(0, 0, 10) + Vector3.New(var_421_3.x, var_421_3.y, 0)
				local var_421_5 = arg_418_1.bgs_.SS1601

				var_421_5.transform.localPosition = var_421_4
				var_421_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_421_6 = var_421_5:GetComponent("SpriteRenderer")

				if var_421_6 and var_421_6.sprite then
					local var_421_7 = (var_421_5.transform.localPosition - var_421_3).z
					local var_421_8 = manager.ui.mainCameraCom_
					local var_421_9 = 2 * var_421_7 * Mathf.Tan(var_421_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_421_10 = var_421_9 * var_421_8.aspect
					local var_421_11 = var_421_6.sprite.bounds.size.x
					local var_421_12 = var_421_6.sprite.bounds.size.y
					local var_421_13 = var_421_10 / var_421_11
					local var_421_14 = var_421_9 / var_421_12
					local var_421_15 = var_421_14 < var_421_13 and var_421_13 or var_421_14

					var_421_5.transform.localScale = Vector3.New(var_421_15, var_421_15, 0)
				end

				for iter_421_0, iter_421_1 in pairs(arg_418_1.bgs_) do
					if iter_421_0 ~= "SS1601" then
						iter_421_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_421_16 = 0

			if var_421_16 < arg_418_1.time_ and arg_418_1.time_ <= var_421_16 + arg_421_0 then
				arg_418_1.mask_.enabled = true
				arg_418_1.mask_.raycastTarget = true

				arg_418_1:SetGaussion(false)
			end

			local var_421_17 = 2

			if var_421_16 <= arg_418_1.time_ and arg_418_1.time_ < var_421_16 + var_421_17 then
				local var_421_18 = (arg_418_1.time_ - var_421_16) / var_421_17
				local var_421_19 = Color.New(0, 0, 0)

				var_421_19.a = Mathf.Lerp(0, 1, var_421_18)
				arg_418_1.mask_.color = var_421_19
			end

			if arg_418_1.time_ >= var_421_16 + var_421_17 and arg_418_1.time_ < var_421_16 + var_421_17 + arg_421_0 then
				local var_421_20 = Color.New(0, 0, 0)

				var_421_20.a = 1
				arg_418_1.mask_.color = var_421_20
			end

			local var_421_21 = 2

			if var_421_21 < arg_418_1.time_ and arg_418_1.time_ <= var_421_21 + arg_421_0 then
				arg_418_1.mask_.enabled = true
				arg_418_1.mask_.raycastTarget = true

				arg_418_1:SetGaussion(false)
			end

			local var_421_22 = 2

			if var_421_21 <= arg_418_1.time_ and arg_418_1.time_ < var_421_21 + var_421_22 then
				local var_421_23 = (arg_418_1.time_ - var_421_21) / var_421_22
				local var_421_24 = Color.New(0, 0, 0)

				var_421_24.a = Mathf.Lerp(1, 0, var_421_23)
				arg_418_1.mask_.color = var_421_24
			end

			if arg_418_1.time_ >= var_421_21 + var_421_22 and arg_418_1.time_ < var_421_21 + var_421_22 + arg_421_0 then
				local var_421_25 = Color.New(0, 0, 0)
				local var_421_26 = 0

				arg_418_1.mask_.enabled = false
				var_421_25.a = var_421_26
				arg_418_1.mask_.color = var_421_25
			end

			local var_421_27 = arg_418_1.actors_["1148"].transform
			local var_421_28 = 1.966

			if var_421_28 < arg_418_1.time_ and arg_418_1.time_ <= var_421_28 + arg_421_0 then
				arg_418_1.var_.moveOldPos1148 = var_421_27.localPosition
				var_421_27.localScale = Vector3.New(1, 1, 1)

				arg_418_1:CheckSpriteTmpPos("1148", 7)

				local var_421_29 = var_421_27.childCount

				for iter_421_2 = 0, var_421_29 - 1 do
					local var_421_30 = var_421_27:GetChild(iter_421_2)

					if var_421_30.name == "" or not string.find(var_421_30.name, "split") then
						var_421_30.gameObject:SetActive(true)
					else
						var_421_30.gameObject:SetActive(false)
					end
				end
			end

			local var_421_31 = 0.001

			if var_421_28 <= arg_418_1.time_ and arg_418_1.time_ < var_421_28 + var_421_31 then
				local var_421_32 = (arg_418_1.time_ - var_421_28) / var_421_31
				local var_421_33 = Vector3.New(0, -2000, 0)

				var_421_27.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos1148, var_421_33, var_421_32)
			end

			if arg_418_1.time_ >= var_421_28 + var_421_31 and arg_418_1.time_ < var_421_28 + var_421_31 + arg_421_0 then
				var_421_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_421_34 = manager.ui.mainCamera.transform
			local var_421_35 = 2.03333333333333

			if var_421_35 < arg_418_1.time_ and arg_418_1.time_ <= var_421_35 + arg_421_0 then
				local var_421_36 = arg_418_1.var_.effect1055
				local var_421_37
				local var_421_38 = var_421_34

				if not var_421_36 then
					var_421_36 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_mist_keep"), var_421_38)
					var_421_36.name = "1055"
					arg_418_1.var_.effect1055 = var_421_36
				else
					var_421_36.transform:SetParent(var_421_38)
				end

				var_421_36.transform.localPosition = Vector3.New(0, 0, 0)
				var_421_36.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_421_39 = manager.ui.mainCameraCom_
				local var_421_40 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_421_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_421_41 = var_421_36.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_421_42 = 15
				local var_421_43 = 2 * var_421_42 * Mathf.Tan(var_421_39.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_421_39.aspect
				local var_421_44 = 1
				local var_421_45 = 1.7777777777777777

				if var_421_45 < var_421_39.aspect then
					var_421_44 = var_421_43 / (2 * var_421_42 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_421_45)
				end

				for iter_421_3, iter_421_4 in ipairs(var_421_41) do
					local var_421_46 = iter_421_4.transform.localScale

					iter_421_4.transform.localScale = Vector3.New(var_421_46.x / var_421_40 * var_421_44, var_421_46.y / var_421_40, var_421_46.z)
				end
			end

			local var_421_47 = 0
			local var_421_48 = 0.2

			if var_421_47 < arg_418_1.time_ and arg_418_1.time_ <= var_421_47 + arg_421_0 then
				local var_421_49 = "play"
				local var_421_50 = "music"

				arg_418_1:AudioAction(var_421_49, var_421_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_421_51 = ""
				local var_421_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_421_52 ~= "" then
					if arg_418_1.bgmTxt_.text ~= var_421_52 and arg_418_1.bgmTxt_.text ~= "" then
						if arg_418_1.bgmTxt2_.text ~= "" then
							arg_418_1.bgmTxt_.text = arg_418_1.bgmTxt2_.text
						end

						arg_418_1.bgmTxt2_.text = var_421_52

						arg_418_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_418_1.bgmTxt_.text = var_421_52
						arg_418_1.bgmTxt2_.text = var_421_52
					end

					if arg_418_1.bgmTimer then
						arg_418_1.bgmTimer:Stop()

						arg_418_1.bgmTimer = nil
					end

					if arg_418_1.settingData.show_music_name == 1 then
						arg_418_1.musicController:SetSelectedState("show")
						arg_418_1.musicAnimator_:Play("open", 0, 0)

						if arg_418_1.settingData.music_time ~= 0 then
							arg_418_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_418_1.settingData.music_time), function()
								if arg_418_1 == nil or isNil(arg_418_1.bgmTxt_) then
									return
								end

								arg_418_1.musicController:SetSelectedState("hide")
								arg_418_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_421_53 = 1.43333333333333
			local var_421_54 = 1

			if var_421_53 < arg_418_1.time_ and arg_418_1.time_ <= var_421_53 + arg_421_0 then
				local var_421_55 = "play"
				local var_421_56 = "music"

				arg_418_1:AudioAction(var_421_55, var_421_56, "bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide.awb")

				local var_421_57 = ""
				local var_421_58 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide")

				if var_421_58 ~= "" then
					if arg_418_1.bgmTxt_.text ~= var_421_58 and arg_418_1.bgmTxt_.text ~= "" then
						if arg_418_1.bgmTxt2_.text ~= "" then
							arg_418_1.bgmTxt_.text = arg_418_1.bgmTxt2_.text
						end

						arg_418_1.bgmTxt2_.text = var_421_58

						arg_418_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_418_1.bgmTxt_.text = var_421_58
						arg_418_1.bgmTxt2_.text = var_421_58
					end

					if arg_418_1.bgmTimer then
						arg_418_1.bgmTimer:Stop()

						arg_418_1.bgmTimer = nil
					end

					if arg_418_1.settingData.show_music_name == 1 then
						arg_418_1.musicController:SetSelectedState("show")
						arg_418_1.musicAnimator_:Play("open", 0, 0)

						if arg_418_1.settingData.music_time ~= 0 then
							arg_418_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_418_1.settingData.music_time), function()
								if arg_418_1 == nil or isNil(arg_418_1.bgmTxt_) then
									return
								end

								arg_418_1.musicController:SetSelectedState("hide")
								arg_418_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_418_1.frameCnt_ <= 1 then
				arg_418_1.dialog_:SetActive(false)
			end

			local var_421_59 = 4
			local var_421_60 = 1.625

			if var_421_59 < arg_418_1.time_ and arg_418_1.time_ <= var_421_59 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0

				arg_418_1.dialog_:SetActive(true)

				arg_418_1.dialogCg_.alpha = 0

				local var_421_61 = LeanTween.value(arg_418_1.dialog_, 0, 1, 0.3)

				var_421_61:setOnUpdate(LuaHelper.FloatAction(function(arg_424_0)
					arg_418_1.dialogCg_.alpha = arg_424_0
				end))
				var_421_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_418_1.dialog_)
					var_421_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_418_1.duration_ = arg_418_1.duration_ + 0.3

				SetActive(arg_418_1.leftNameGo_, false)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_62 = arg_418_1:GetWordFromCfg(416011101)
				local var_421_63 = arg_418_1:FormatText(var_421_62.content)

				arg_418_1.text_.text = var_421_63

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_64 = 65
				local var_421_65 = utf8.len(var_421_63)
				local var_421_66 = var_421_64 <= 0 and var_421_60 or var_421_60 * (var_421_65 / var_421_64)

				if var_421_66 > 0 and var_421_60 < var_421_66 then
					arg_418_1.talkMaxDuration = var_421_66
					var_421_59 = var_421_59 + 0.3

					if var_421_66 + var_421_59 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_66 + var_421_59
					end
				end

				arg_418_1.text_.text = var_421_63
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_67 = var_421_59 + 0.3
			local var_421_68 = math.max(var_421_60, arg_418_1.talkMaxDuration)

			if var_421_67 <= arg_418_1.time_ and arg_418_1.time_ < var_421_67 + var_421_68 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_67) / var_421_68

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_67 + var_421_68 and arg_418_1.time_ < var_421_67 + var_421_68 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_418_1:InitPlayNodeList()
	end,
	Play416011102 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 416011102
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play416011103(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0
			local var_429_1 = 1.675

			if var_429_0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_2 = arg_426_1:GetWordFromCfg(416011102)
				local var_429_3 = arg_426_1:FormatText(var_429_2.content)

				arg_426_1.text_.text = var_429_3

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_4 = 67
				local var_429_5 = utf8.len(var_429_3)
				local var_429_6 = var_429_4 <= 0 and var_429_1 or var_429_1 * (var_429_5 / var_429_4)

				if var_429_6 > 0 and var_429_1 < var_429_6 then
					arg_426_1.talkMaxDuration = var_429_6

					if var_429_6 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_6 + var_429_0
					end
				end

				arg_426_1.text_.text = var_429_3
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_7 = math.max(var_429_1, arg_426_1.talkMaxDuration)

			if var_429_0 <= arg_426_1.time_ and arg_426_1.time_ < var_429_0 + var_429_7 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_0) / var_429_7

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_0 + var_429_7 and arg_426_1.time_ < var_429_0 + var_429_7 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play416011103 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 416011103
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play416011104(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0
			local var_433_1 = 1.05

			if var_433_0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, false)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_2 = arg_430_1:GetWordFromCfg(416011103)
				local var_433_3 = arg_430_1:FormatText(var_433_2.content)

				arg_430_1.text_.text = var_433_3

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_4 = 42
				local var_433_5 = utf8.len(var_433_3)
				local var_433_6 = var_433_4 <= 0 and var_433_1 or var_433_1 * (var_433_5 / var_433_4)

				if var_433_6 > 0 and var_433_1 < var_433_6 then
					arg_430_1.talkMaxDuration = var_433_6

					if var_433_6 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_6 + var_433_0
					end
				end

				arg_430_1.text_.text = var_433_3
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_7 = math.max(var_433_1, arg_430_1.talkMaxDuration)

			if var_433_0 <= arg_430_1.time_ and arg_430_1.time_ < var_433_0 + var_433_7 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_0) / var_433_7

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_0 + var_433_7 and arg_430_1.time_ < var_433_0 + var_433_7 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play416011104 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 416011104
		arg_434_1.duration_ = 7.17

		local var_434_0 = {
			zh = 5.3,
			ja = 7.166
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play416011105(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0
			local var_437_1 = 0.4

			if var_437_0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_2 = arg_434_1:FormatText(StoryNameCfg[171].name)

				arg_434_1.leftNameTxt_.text = var_437_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_3 = arg_434_1:GetWordFromCfg(416011104)
				local var_437_4 = arg_434_1:FormatText(var_437_3.content)

				arg_434_1.text_.text = var_437_4

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 16
				local var_437_6 = utf8.len(var_437_4)
				local var_437_7 = var_437_5 <= 0 and var_437_1 or var_437_1 * (var_437_6 / var_437_5)

				if var_437_7 > 0 and var_437_1 < var_437_7 then
					arg_434_1.talkMaxDuration = var_437_7

					if var_437_7 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_7 + var_437_0
					end
				end

				arg_434_1.text_.text = var_437_4
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011104", "story_v_out_416011.awb") ~= 0 then
					local var_437_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011104", "story_v_out_416011.awb") / 1000

					if var_437_8 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_8 + var_437_0
					end

					if var_437_3.prefab_name ~= "" and arg_434_1.actors_[var_437_3.prefab_name] ~= nil then
						local var_437_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_3.prefab_name].transform, "story_v_out_416011", "416011104", "story_v_out_416011.awb")

						arg_434_1:RecordAudio("416011104", var_437_9)
						arg_434_1:RecordAudio("416011104", var_437_9)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_416011", "416011104", "story_v_out_416011.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_416011", "416011104", "story_v_out_416011.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_10 = math.max(var_437_1, arg_434_1.talkMaxDuration)

			if var_437_0 <= arg_434_1.time_ and arg_434_1.time_ < var_437_0 + var_437_10 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_0) / var_437_10

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_0 + var_437_10 and arg_434_1.time_ < var_437_0 + var_437_10 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play416011105 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 416011105
		arg_438_1.duration_ = 2.6

		local var_438_0 = {
			zh = 1.666,
			ja = 2.6
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play416011106(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["1148"].transform
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 then
				arg_438_1.var_.moveOldPos1148 = var_441_0.localPosition
				var_441_0.localScale = Vector3.New(1, 1, 1)

				arg_438_1:CheckSpriteTmpPos("1148", 3)

				local var_441_2 = var_441_0.childCount

				for iter_441_0 = 0, var_441_2 - 1 do
					local var_441_3 = var_441_0:GetChild(iter_441_0)

					if var_441_3.name == "" or not string.find(var_441_3.name, "split") then
						var_441_3.gameObject:SetActive(true)
					else
						var_441_3.gameObject:SetActive(false)
					end
				end
			end

			local var_441_4 = 0.001

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_4 then
				local var_441_5 = (arg_438_1.time_ - var_441_1) / var_441_4
				local var_441_6 = Vector3.New(0, -429, -180)

				var_441_0.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1148, var_441_6, var_441_5)
			end

			if arg_438_1.time_ >= var_441_1 + var_441_4 and arg_438_1.time_ < var_441_1 + var_441_4 + arg_441_0 then
				var_441_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_441_7 = arg_438_1.actors_["1148"]
			local var_441_8 = 0

			if var_441_8 < arg_438_1.time_ and arg_438_1.time_ <= var_441_8 + arg_441_0 and not isNil(var_441_7) and arg_438_1.var_.actorSpriteComps1148 == nil then
				arg_438_1.var_.actorSpriteComps1148 = var_441_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_441_9 = 0.125

			if var_441_8 <= arg_438_1.time_ and arg_438_1.time_ < var_441_8 + var_441_9 and not isNil(var_441_7) then
				local var_441_10 = (arg_438_1.time_ - var_441_8) / var_441_9

				if arg_438_1.var_.actorSpriteComps1148 then
					for iter_441_1, iter_441_2 in pairs(arg_438_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_441_2 then
							if arg_438_1.isInRecall_ then
								local var_441_11 = Mathf.Lerp(iter_441_2.color.r, arg_438_1.hightColor1.r, var_441_10)
								local var_441_12 = Mathf.Lerp(iter_441_2.color.g, arg_438_1.hightColor1.g, var_441_10)
								local var_441_13 = Mathf.Lerp(iter_441_2.color.b, arg_438_1.hightColor1.b, var_441_10)

								iter_441_2.color = Color.New(var_441_11, var_441_12, var_441_13)
							else
								local var_441_14 = Mathf.Lerp(iter_441_2.color.r, 1, var_441_10)

								iter_441_2.color = Color.New(var_441_14, var_441_14, var_441_14)
							end
						end
					end
				end
			end

			if arg_438_1.time_ >= var_441_8 + var_441_9 and arg_438_1.time_ < var_441_8 + var_441_9 + arg_441_0 and not isNil(var_441_7) and arg_438_1.var_.actorSpriteComps1148 then
				for iter_441_3, iter_441_4 in pairs(arg_438_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_441_4 then
						if arg_438_1.isInRecall_ then
							iter_441_4.color = arg_438_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_441_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_438_1.var_.actorSpriteComps1148 = nil
			end

			local var_441_15 = 0
			local var_441_16 = 0.2

			if var_441_15 < arg_438_1.time_ and arg_438_1.time_ <= var_441_15 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_17 = arg_438_1:FormatText(StoryNameCfg[8].name)

				arg_438_1.leftNameTxt_.text = var_441_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_18 = arg_438_1:GetWordFromCfg(416011105)
				local var_441_19 = arg_438_1:FormatText(var_441_18.content)

				arg_438_1.text_.text = var_441_19

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_20 = 8
				local var_441_21 = utf8.len(var_441_19)
				local var_441_22 = var_441_20 <= 0 and var_441_16 or var_441_16 * (var_441_21 / var_441_20)

				if var_441_22 > 0 and var_441_16 < var_441_22 then
					arg_438_1.talkMaxDuration = var_441_22

					if var_441_22 + var_441_15 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_22 + var_441_15
					end
				end

				arg_438_1.text_.text = var_441_19
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011105", "story_v_out_416011.awb") ~= 0 then
					local var_441_23 = manager.audio:GetVoiceLength("story_v_out_416011", "416011105", "story_v_out_416011.awb") / 1000

					if var_441_23 + var_441_15 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_23 + var_441_15
					end

					if var_441_18.prefab_name ~= "" and arg_438_1.actors_[var_441_18.prefab_name] ~= nil then
						local var_441_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_18.prefab_name].transform, "story_v_out_416011", "416011105", "story_v_out_416011.awb")

						arg_438_1:RecordAudio("416011105", var_441_24)
						arg_438_1:RecordAudio("416011105", var_441_24)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_416011", "416011105", "story_v_out_416011.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_416011", "416011105", "story_v_out_416011.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_25 = math.max(var_441_16, arg_438_1.talkMaxDuration)

			if var_441_15 <= arg_438_1.time_ and arg_438_1.time_ < var_441_15 + var_441_25 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_15) / var_441_25

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_15 + var_441_25 and arg_438_1.time_ < var_441_15 + var_441_25 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play416011106 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 416011106
		arg_442_1.duration_ = 3.97

		local var_442_0 = {
			zh = 3.966,
			ja = 2.833
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play416011107(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["1148"]
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.actorSpriteComps1148 == nil then
				arg_442_1.var_.actorSpriteComps1148 = var_445_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_445_2 = 0.125

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 and not isNil(var_445_0) then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2

				if arg_442_1.var_.actorSpriteComps1148 then
					for iter_445_0, iter_445_1 in pairs(arg_442_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_445_1 then
							if arg_442_1.isInRecall_ then
								local var_445_4 = Mathf.Lerp(iter_445_1.color.r, arg_442_1.hightColor2.r, var_445_3)
								local var_445_5 = Mathf.Lerp(iter_445_1.color.g, arg_442_1.hightColor2.g, var_445_3)
								local var_445_6 = Mathf.Lerp(iter_445_1.color.b, arg_442_1.hightColor2.b, var_445_3)

								iter_445_1.color = Color.New(var_445_4, var_445_5, var_445_6)
							else
								local var_445_7 = Mathf.Lerp(iter_445_1.color.r, 0.5, var_445_3)

								iter_445_1.color = Color.New(var_445_7, var_445_7, var_445_7)
							end
						end
					end
				end
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.actorSpriteComps1148 then
				for iter_445_2, iter_445_3 in pairs(arg_442_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_445_3 then
						if arg_442_1.isInRecall_ then
							iter_445_3.color = arg_442_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_445_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_442_1.var_.actorSpriteComps1148 = nil
			end

			local var_445_8 = 0
			local var_445_9 = 0.2

			if var_445_8 < arg_442_1.time_ and arg_442_1.time_ <= var_445_8 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_10 = arg_442_1:FormatText(StoryNameCfg[171].name)

				arg_442_1.leftNameTxt_.text = var_445_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_11 = arg_442_1:GetWordFromCfg(416011106)
				local var_445_12 = arg_442_1:FormatText(var_445_11.content)

				arg_442_1.text_.text = var_445_12

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_13 = 8
				local var_445_14 = utf8.len(var_445_12)
				local var_445_15 = var_445_13 <= 0 and var_445_9 or var_445_9 * (var_445_14 / var_445_13)

				if var_445_15 > 0 and var_445_9 < var_445_15 then
					arg_442_1.talkMaxDuration = var_445_15

					if var_445_15 + var_445_8 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_15 + var_445_8
					end
				end

				arg_442_1.text_.text = var_445_12
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011106", "story_v_out_416011.awb") ~= 0 then
					local var_445_16 = manager.audio:GetVoiceLength("story_v_out_416011", "416011106", "story_v_out_416011.awb") / 1000

					if var_445_16 + var_445_8 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_16 + var_445_8
					end

					if var_445_11.prefab_name ~= "" and arg_442_1.actors_[var_445_11.prefab_name] ~= nil then
						local var_445_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_11.prefab_name].transform, "story_v_out_416011", "416011106", "story_v_out_416011.awb")

						arg_442_1:RecordAudio("416011106", var_445_17)
						arg_442_1:RecordAudio("416011106", var_445_17)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_416011", "416011106", "story_v_out_416011.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_416011", "416011106", "story_v_out_416011.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_18 = math.max(var_445_9, arg_442_1.talkMaxDuration)

			if var_445_8 <= arg_442_1.time_ and arg_442_1.time_ < var_445_8 + var_445_18 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_8) / var_445_18

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_8 + var_445_18 and arg_442_1.time_ < var_445_8 + var_445_18 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play416011107 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 416011107
		arg_446_1.duration_ = 9.63

		local var_446_0 = {
			zh = 6.6,
			ja = 9.633
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play416011108(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["1148"]
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.actorSpriteComps1148 == nil then
				arg_446_1.var_.actorSpriteComps1148 = var_449_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_449_2 = 0.125

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_2 and not isNil(var_449_0) then
				local var_449_3 = (arg_446_1.time_ - var_449_1) / var_449_2

				if arg_446_1.var_.actorSpriteComps1148 then
					for iter_449_0, iter_449_1 in pairs(arg_446_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_449_1 then
							if arg_446_1.isInRecall_ then
								local var_449_4 = Mathf.Lerp(iter_449_1.color.r, arg_446_1.hightColor1.r, var_449_3)
								local var_449_5 = Mathf.Lerp(iter_449_1.color.g, arg_446_1.hightColor1.g, var_449_3)
								local var_449_6 = Mathf.Lerp(iter_449_1.color.b, arg_446_1.hightColor1.b, var_449_3)

								iter_449_1.color = Color.New(var_449_4, var_449_5, var_449_6)
							else
								local var_449_7 = Mathf.Lerp(iter_449_1.color.r, 1, var_449_3)

								iter_449_1.color = Color.New(var_449_7, var_449_7, var_449_7)
							end
						end
					end
				end
			end

			if arg_446_1.time_ >= var_449_1 + var_449_2 and arg_446_1.time_ < var_449_1 + var_449_2 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.actorSpriteComps1148 then
				for iter_449_2, iter_449_3 in pairs(arg_446_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_449_3 then
						if arg_446_1.isInRecall_ then
							iter_449_3.color = arg_446_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_449_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_446_1.var_.actorSpriteComps1148 = nil
			end

			local var_449_8 = 0
			local var_449_9 = 0.7

			if var_449_8 < arg_446_1.time_ and arg_446_1.time_ <= var_449_8 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_10 = arg_446_1:FormatText(StoryNameCfg[8].name)

				arg_446_1.leftNameTxt_.text = var_449_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_11 = arg_446_1:GetWordFromCfg(416011107)
				local var_449_12 = arg_446_1:FormatText(var_449_11.content)

				arg_446_1.text_.text = var_449_12

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_13 = 28
				local var_449_14 = utf8.len(var_449_12)
				local var_449_15 = var_449_13 <= 0 and var_449_9 or var_449_9 * (var_449_14 / var_449_13)

				if var_449_15 > 0 and var_449_9 < var_449_15 then
					arg_446_1.talkMaxDuration = var_449_15

					if var_449_15 + var_449_8 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_15 + var_449_8
					end
				end

				arg_446_1.text_.text = var_449_12
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011107", "story_v_out_416011.awb") ~= 0 then
					local var_449_16 = manager.audio:GetVoiceLength("story_v_out_416011", "416011107", "story_v_out_416011.awb") / 1000

					if var_449_16 + var_449_8 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_16 + var_449_8
					end

					if var_449_11.prefab_name ~= "" and arg_446_1.actors_[var_449_11.prefab_name] ~= nil then
						local var_449_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_11.prefab_name].transform, "story_v_out_416011", "416011107", "story_v_out_416011.awb")

						arg_446_1:RecordAudio("416011107", var_449_17)
						arg_446_1:RecordAudio("416011107", var_449_17)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_416011", "416011107", "story_v_out_416011.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_416011", "416011107", "story_v_out_416011.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_18 = math.max(var_449_9, arg_446_1.talkMaxDuration)

			if var_449_8 <= arg_446_1.time_ and arg_446_1.time_ < var_449_8 + var_449_18 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_8) / var_449_18

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_8 + var_449_18 and arg_446_1.time_ < var_449_8 + var_449_18 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play416011108 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 416011108
		arg_450_1.duration_ = 9.43

		local var_450_0 = {
			zh = 6.866,
			ja = 9.433
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play416011109(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = arg_450_1.actors_["1148"]
			local var_453_1 = 0

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.actorSpriteComps1148 == nil then
				arg_450_1.var_.actorSpriteComps1148 = var_453_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_453_2 = 0.125

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_2 and not isNil(var_453_0) then
				local var_453_3 = (arg_450_1.time_ - var_453_1) / var_453_2

				if arg_450_1.var_.actorSpriteComps1148 then
					for iter_453_0, iter_453_1 in pairs(arg_450_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_453_1 then
							if arg_450_1.isInRecall_ then
								local var_453_4 = Mathf.Lerp(iter_453_1.color.r, arg_450_1.hightColor2.r, var_453_3)
								local var_453_5 = Mathf.Lerp(iter_453_1.color.g, arg_450_1.hightColor2.g, var_453_3)
								local var_453_6 = Mathf.Lerp(iter_453_1.color.b, arg_450_1.hightColor2.b, var_453_3)

								iter_453_1.color = Color.New(var_453_4, var_453_5, var_453_6)
							else
								local var_453_7 = Mathf.Lerp(iter_453_1.color.r, 0.5, var_453_3)

								iter_453_1.color = Color.New(var_453_7, var_453_7, var_453_7)
							end
						end
					end
				end
			end

			if arg_450_1.time_ >= var_453_1 + var_453_2 and arg_450_1.time_ < var_453_1 + var_453_2 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.actorSpriteComps1148 then
				for iter_453_2, iter_453_3 in pairs(arg_450_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_453_3 then
						if arg_450_1.isInRecall_ then
							iter_453_3.color = arg_450_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_453_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_450_1.var_.actorSpriteComps1148 = nil
			end

			local var_453_8 = 0
			local var_453_9 = 0.65

			if var_453_8 < arg_450_1.time_ and arg_450_1.time_ <= var_453_8 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_10 = arg_450_1:FormatText(StoryNameCfg[171].name)

				arg_450_1.leftNameTxt_.text = var_453_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_11 = arg_450_1:GetWordFromCfg(416011108)
				local var_453_12 = arg_450_1:FormatText(var_453_11.content)

				arg_450_1.text_.text = var_453_12

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_13 = 26
				local var_453_14 = utf8.len(var_453_12)
				local var_453_15 = var_453_13 <= 0 and var_453_9 or var_453_9 * (var_453_14 / var_453_13)

				if var_453_15 > 0 and var_453_9 < var_453_15 then
					arg_450_1.talkMaxDuration = var_453_15

					if var_453_15 + var_453_8 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_15 + var_453_8
					end
				end

				arg_450_1.text_.text = var_453_12
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011108", "story_v_out_416011.awb") ~= 0 then
					local var_453_16 = manager.audio:GetVoiceLength("story_v_out_416011", "416011108", "story_v_out_416011.awb") / 1000

					if var_453_16 + var_453_8 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_16 + var_453_8
					end

					if var_453_11.prefab_name ~= "" and arg_450_1.actors_[var_453_11.prefab_name] ~= nil then
						local var_453_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_11.prefab_name].transform, "story_v_out_416011", "416011108", "story_v_out_416011.awb")

						arg_450_1:RecordAudio("416011108", var_453_17)
						arg_450_1:RecordAudio("416011108", var_453_17)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_416011", "416011108", "story_v_out_416011.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_416011", "416011108", "story_v_out_416011.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_18 = math.max(var_453_9, arg_450_1.talkMaxDuration)

			if var_453_8 <= arg_450_1.time_ and arg_450_1.time_ < var_453_8 + var_453_18 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_8) / var_453_18

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_8 + var_453_18 and arg_450_1.time_ < var_453_8 + var_453_18 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play416011109 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 416011109
		arg_454_1.duration_ = 7.5

		local var_454_0 = {
			zh = 3.466,
			ja = 7.5
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play416011110(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = arg_454_1.actors_["1148"]
			local var_457_1 = 0

			if var_457_1 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.actorSpriteComps1148 == nil then
				arg_454_1.var_.actorSpriteComps1148 = var_457_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_457_2 = 0.125

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_2 and not isNil(var_457_0) then
				local var_457_3 = (arg_454_1.time_ - var_457_1) / var_457_2

				if arg_454_1.var_.actorSpriteComps1148 then
					for iter_457_0, iter_457_1 in pairs(arg_454_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_457_1 then
							if arg_454_1.isInRecall_ then
								local var_457_4 = Mathf.Lerp(iter_457_1.color.r, arg_454_1.hightColor1.r, var_457_3)
								local var_457_5 = Mathf.Lerp(iter_457_1.color.g, arg_454_1.hightColor1.g, var_457_3)
								local var_457_6 = Mathf.Lerp(iter_457_1.color.b, arg_454_1.hightColor1.b, var_457_3)

								iter_457_1.color = Color.New(var_457_4, var_457_5, var_457_6)
							else
								local var_457_7 = Mathf.Lerp(iter_457_1.color.r, 1, var_457_3)

								iter_457_1.color = Color.New(var_457_7, var_457_7, var_457_7)
							end
						end
					end
				end
			end

			if arg_454_1.time_ >= var_457_1 + var_457_2 and arg_454_1.time_ < var_457_1 + var_457_2 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.actorSpriteComps1148 then
				for iter_457_2, iter_457_3 in pairs(arg_454_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_457_3 then
						if arg_454_1.isInRecall_ then
							iter_457_3.color = arg_454_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_457_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_454_1.var_.actorSpriteComps1148 = nil
			end

			local var_457_8 = 0
			local var_457_9 = 0.425

			if var_457_8 < arg_454_1.time_ and arg_454_1.time_ <= var_457_8 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_10 = arg_454_1:FormatText(StoryNameCfg[8].name)

				arg_454_1.leftNameTxt_.text = var_457_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_11 = arg_454_1:GetWordFromCfg(416011109)
				local var_457_12 = arg_454_1:FormatText(var_457_11.content)

				arg_454_1.text_.text = var_457_12

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_13 = 17
				local var_457_14 = utf8.len(var_457_12)
				local var_457_15 = var_457_13 <= 0 and var_457_9 or var_457_9 * (var_457_14 / var_457_13)

				if var_457_15 > 0 and var_457_9 < var_457_15 then
					arg_454_1.talkMaxDuration = var_457_15

					if var_457_15 + var_457_8 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_15 + var_457_8
					end
				end

				arg_454_1.text_.text = var_457_12
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011109", "story_v_out_416011.awb") ~= 0 then
					local var_457_16 = manager.audio:GetVoiceLength("story_v_out_416011", "416011109", "story_v_out_416011.awb") / 1000

					if var_457_16 + var_457_8 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_16 + var_457_8
					end

					if var_457_11.prefab_name ~= "" and arg_454_1.actors_[var_457_11.prefab_name] ~= nil then
						local var_457_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_11.prefab_name].transform, "story_v_out_416011", "416011109", "story_v_out_416011.awb")

						arg_454_1:RecordAudio("416011109", var_457_17)
						arg_454_1:RecordAudio("416011109", var_457_17)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_416011", "416011109", "story_v_out_416011.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_416011", "416011109", "story_v_out_416011.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_18 = math.max(var_457_9, arg_454_1.talkMaxDuration)

			if var_457_8 <= arg_454_1.time_ and arg_454_1.time_ < var_457_8 + var_457_18 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_8) / var_457_18

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_8 + var_457_18 and arg_454_1.time_ < var_457_8 + var_457_18 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play416011110 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 416011110
		arg_458_1.duration_ = 5.1

		local var_458_0 = {
			zh = 4.766,
			ja = 5.1
		}
		local var_458_1 = manager.audio:GetLocalizationFlag()

		if var_458_0[var_458_1] ~= nil then
			arg_458_1.duration_ = var_458_0[var_458_1]
		end

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play416011111(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = 0
			local var_461_1 = 0.575

			if var_461_0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_0 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_2 = arg_458_1:FormatText(StoryNameCfg[8].name)

				arg_458_1.leftNameTxt_.text = var_461_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_3 = arg_458_1:GetWordFromCfg(416011110)
				local var_461_4 = arg_458_1:FormatText(var_461_3.content)

				arg_458_1.text_.text = var_461_4

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_5 = 23
				local var_461_6 = utf8.len(var_461_4)
				local var_461_7 = var_461_5 <= 0 and var_461_1 or var_461_1 * (var_461_6 / var_461_5)

				if var_461_7 > 0 and var_461_1 < var_461_7 then
					arg_458_1.talkMaxDuration = var_461_7

					if var_461_7 + var_461_0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_7 + var_461_0
					end
				end

				arg_458_1.text_.text = var_461_4
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011110", "story_v_out_416011.awb") ~= 0 then
					local var_461_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011110", "story_v_out_416011.awb") / 1000

					if var_461_8 + var_461_0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_8 + var_461_0
					end

					if var_461_3.prefab_name ~= "" and arg_458_1.actors_[var_461_3.prefab_name] ~= nil then
						local var_461_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_3.prefab_name].transform, "story_v_out_416011", "416011110", "story_v_out_416011.awb")

						arg_458_1:RecordAudio("416011110", var_461_9)
						arg_458_1:RecordAudio("416011110", var_461_9)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_out_416011", "416011110", "story_v_out_416011.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_out_416011", "416011110", "story_v_out_416011.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_10 = math.max(var_461_1, arg_458_1.talkMaxDuration)

			if var_461_0 <= arg_458_1.time_ and arg_458_1.time_ < var_461_0 + var_461_10 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_0) / var_461_10

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_0 + var_461_10 and arg_458_1.time_ < var_461_0 + var_461_10 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play416011111 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 416011111
		arg_462_1.duration_ = 6.6

		local var_462_0 = {
			zh = 6.6,
			ja = 6.233
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play416011112(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["1148"]
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.actorSpriteComps1148 == nil then
				arg_462_1.var_.actorSpriteComps1148 = var_465_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_465_2 = 0.125

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 and not isNil(var_465_0) then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2

				if arg_462_1.var_.actorSpriteComps1148 then
					for iter_465_0, iter_465_1 in pairs(arg_462_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_465_1 then
							if arg_462_1.isInRecall_ then
								local var_465_4 = Mathf.Lerp(iter_465_1.color.r, arg_462_1.hightColor2.r, var_465_3)
								local var_465_5 = Mathf.Lerp(iter_465_1.color.g, arg_462_1.hightColor2.g, var_465_3)
								local var_465_6 = Mathf.Lerp(iter_465_1.color.b, arg_462_1.hightColor2.b, var_465_3)

								iter_465_1.color = Color.New(var_465_4, var_465_5, var_465_6)
							else
								local var_465_7 = Mathf.Lerp(iter_465_1.color.r, 0.5, var_465_3)

								iter_465_1.color = Color.New(var_465_7, var_465_7, var_465_7)
							end
						end
					end
				end
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.actorSpriteComps1148 then
				for iter_465_2, iter_465_3 in pairs(arg_462_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_465_3 then
						if arg_462_1.isInRecall_ then
							iter_465_3.color = arg_462_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_465_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_462_1.var_.actorSpriteComps1148 = nil
			end

			local var_465_8 = 0
			local var_465_9 = 0.475

			if var_465_8 < arg_462_1.time_ and arg_462_1.time_ <= var_465_8 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_10 = arg_462_1:FormatText(StoryNameCfg[1084].name)

				arg_462_1.leftNameTxt_.text = var_465_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, true)
				arg_462_1.iconController_:SetSelectedState("hero")

				arg_462_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_462_1.callingController_:SetSelectedState("normal")

				arg_462_1.keyicon_.color = Color.New(1, 1, 1)
				arg_462_1.icon_.color = Color.New(1, 1, 1)

				local var_465_11 = arg_462_1:GetWordFromCfg(416011111)
				local var_465_12 = arg_462_1:FormatText(var_465_11.content)

				arg_462_1.text_.text = var_465_12

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_13 = 19
				local var_465_14 = utf8.len(var_465_12)
				local var_465_15 = var_465_13 <= 0 and var_465_9 or var_465_9 * (var_465_14 / var_465_13)

				if var_465_15 > 0 and var_465_9 < var_465_15 then
					arg_462_1.talkMaxDuration = var_465_15

					if var_465_15 + var_465_8 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_15 + var_465_8
					end
				end

				arg_462_1.text_.text = var_465_12
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011111", "story_v_out_416011.awb") ~= 0 then
					local var_465_16 = manager.audio:GetVoiceLength("story_v_out_416011", "416011111", "story_v_out_416011.awb") / 1000

					if var_465_16 + var_465_8 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_16 + var_465_8
					end

					if var_465_11.prefab_name ~= "" and arg_462_1.actors_[var_465_11.prefab_name] ~= nil then
						local var_465_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_11.prefab_name].transform, "story_v_out_416011", "416011111", "story_v_out_416011.awb")

						arg_462_1:RecordAudio("416011111", var_465_17)
						arg_462_1:RecordAudio("416011111", var_465_17)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_416011", "416011111", "story_v_out_416011.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_416011", "416011111", "story_v_out_416011.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_18 = math.max(var_465_9, arg_462_1.talkMaxDuration)

			if var_465_8 <= arg_462_1.time_ and arg_462_1.time_ < var_465_8 + var_465_18 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_8) / var_465_18

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_8 + var_465_18 and arg_462_1.time_ < var_465_8 + var_465_18 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play416011112 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 416011112
		arg_466_1.duration_ = 5.4

		local var_466_0 = {
			zh = 5.4,
			ja = 3.7
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play416011113(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["1148"]
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.actorSpriteComps1148 == nil then
				arg_466_1.var_.actorSpriteComps1148 = var_469_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_469_2 = 0.125

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 and not isNil(var_469_0) then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2

				if arg_466_1.var_.actorSpriteComps1148 then
					for iter_469_0, iter_469_1 in pairs(arg_466_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_469_1 then
							if arg_466_1.isInRecall_ then
								local var_469_4 = Mathf.Lerp(iter_469_1.color.r, arg_466_1.hightColor1.r, var_469_3)
								local var_469_5 = Mathf.Lerp(iter_469_1.color.g, arg_466_1.hightColor1.g, var_469_3)
								local var_469_6 = Mathf.Lerp(iter_469_1.color.b, arg_466_1.hightColor1.b, var_469_3)

								iter_469_1.color = Color.New(var_469_4, var_469_5, var_469_6)
							else
								local var_469_7 = Mathf.Lerp(iter_469_1.color.r, 1, var_469_3)

								iter_469_1.color = Color.New(var_469_7, var_469_7, var_469_7)
							end
						end
					end
				end
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.actorSpriteComps1148 then
				for iter_469_2, iter_469_3 in pairs(arg_466_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_469_3 then
						if arg_466_1.isInRecall_ then
							iter_469_3.color = arg_466_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_469_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_466_1.var_.actorSpriteComps1148 = nil
			end

			local var_469_8 = 0
			local var_469_9 = 0.6

			if var_469_8 < arg_466_1.time_ and arg_466_1.time_ <= var_469_8 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_10 = arg_466_1:FormatText(StoryNameCfg[8].name)

				arg_466_1.leftNameTxt_.text = var_469_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_11 = arg_466_1:GetWordFromCfg(416011112)
				local var_469_12 = arg_466_1:FormatText(var_469_11.content)

				arg_466_1.text_.text = var_469_12

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_13 = 24
				local var_469_14 = utf8.len(var_469_12)
				local var_469_15 = var_469_13 <= 0 and var_469_9 or var_469_9 * (var_469_14 / var_469_13)

				if var_469_15 > 0 and var_469_9 < var_469_15 then
					arg_466_1.talkMaxDuration = var_469_15

					if var_469_15 + var_469_8 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_15 + var_469_8
					end
				end

				arg_466_1.text_.text = var_469_12
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011112", "story_v_out_416011.awb") ~= 0 then
					local var_469_16 = manager.audio:GetVoiceLength("story_v_out_416011", "416011112", "story_v_out_416011.awb") / 1000

					if var_469_16 + var_469_8 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_16 + var_469_8
					end

					if var_469_11.prefab_name ~= "" and arg_466_1.actors_[var_469_11.prefab_name] ~= nil then
						local var_469_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_11.prefab_name].transform, "story_v_out_416011", "416011112", "story_v_out_416011.awb")

						arg_466_1:RecordAudio("416011112", var_469_17)
						arg_466_1:RecordAudio("416011112", var_469_17)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_416011", "416011112", "story_v_out_416011.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_416011", "416011112", "story_v_out_416011.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_18 = math.max(var_469_9, arg_466_1.talkMaxDuration)

			if var_469_8 <= arg_466_1.time_ and arg_466_1.time_ < var_469_8 + var_469_18 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_8) / var_469_18

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_8 + var_469_18 and arg_466_1.time_ < var_469_8 + var_469_18 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play416011113 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 416011113
		arg_470_1.duration_ = 5.47

		local var_470_0 = {
			zh = 1.9,
			ja = 5.466
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play416011114(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0
			local var_473_1 = 0.225

			if var_473_0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_2 = arg_470_1:FormatText(StoryNameCfg[8].name)

				arg_470_1.leftNameTxt_.text = var_473_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_3 = arg_470_1:GetWordFromCfg(416011113)
				local var_473_4 = arg_470_1:FormatText(var_473_3.content)

				arg_470_1.text_.text = var_473_4

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_5 = 9
				local var_473_6 = utf8.len(var_473_4)
				local var_473_7 = var_473_5 <= 0 and var_473_1 or var_473_1 * (var_473_6 / var_473_5)

				if var_473_7 > 0 and var_473_1 < var_473_7 then
					arg_470_1.talkMaxDuration = var_473_7

					if var_473_7 + var_473_0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_7 + var_473_0
					end
				end

				arg_470_1.text_.text = var_473_4
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011113", "story_v_out_416011.awb") ~= 0 then
					local var_473_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011113", "story_v_out_416011.awb") / 1000

					if var_473_8 + var_473_0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_8 + var_473_0
					end

					if var_473_3.prefab_name ~= "" and arg_470_1.actors_[var_473_3.prefab_name] ~= nil then
						local var_473_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_3.prefab_name].transform, "story_v_out_416011", "416011113", "story_v_out_416011.awb")

						arg_470_1:RecordAudio("416011113", var_473_9)
						arg_470_1:RecordAudio("416011113", var_473_9)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_416011", "416011113", "story_v_out_416011.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_416011", "416011113", "story_v_out_416011.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_10 = math.max(var_473_1, arg_470_1.talkMaxDuration)

			if var_473_0 <= arg_470_1.time_ and arg_470_1.time_ < var_473_0 + var_473_10 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_0) / var_473_10

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_0 + var_473_10 and arg_470_1.time_ < var_473_0 + var_473_10 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play416011114 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 416011114
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
			arg_474_1.auto_ = false
		end

		function arg_474_1.playNext_(arg_476_0)
			arg_474_1.onStoryFinished_()
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["1148"].transform
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.var_.moveOldPos1148 = var_477_0.localPosition
				var_477_0.localScale = Vector3.New(1, 1, 1)

				arg_474_1:CheckSpriteTmpPos("1148", 7)

				local var_477_2 = var_477_0.childCount

				for iter_477_0 = 0, var_477_2 - 1 do
					local var_477_3 = var_477_0:GetChild(iter_477_0)

					if var_477_3.name == "" or not string.find(var_477_3.name, "split") then
						var_477_3.gameObject:SetActive(true)
					else
						var_477_3.gameObject:SetActive(false)
					end
				end
			end

			local var_477_4 = 0.001

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_4 then
				local var_477_5 = (arg_474_1.time_ - var_477_1) / var_477_4
				local var_477_6 = Vector3.New(0, -2000, 0)

				var_477_0.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1148, var_477_6, var_477_5)
			end

			if arg_474_1.time_ >= var_477_1 + var_477_4 and arg_474_1.time_ < var_477_1 + var_477_4 + arg_477_0 then
				var_477_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_477_7 = 0
			local var_477_8 = 1

			if var_477_7 < arg_474_1.time_ and arg_474_1.time_ <= var_477_7 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, false)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_9 = arg_474_1:GetWordFromCfg(416011114)
				local var_477_10 = arg_474_1:FormatText(var_477_9.content)

				arg_474_1.text_.text = var_477_10

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_11 = 41
				local var_477_12 = utf8.len(var_477_10)
				local var_477_13 = var_477_11 <= 0 and var_477_8 or var_477_8 * (var_477_12 / var_477_11)

				if var_477_13 > 0 and var_477_8 < var_477_13 then
					arg_474_1.talkMaxDuration = var_477_13

					if var_477_13 + var_477_7 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_13 + var_477_7
					end
				end

				arg_474_1.text_.text = var_477_10
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_14 = math.max(var_477_8, arg_474_1.talkMaxDuration)

			if var_477_7 <= arg_474_1.time_ and arg_474_1.time_ < var_477_7 + var_477_14 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_7) / var_477_14

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_7 + var_477_14 and arg_474_1.time_ < var_477_7 + var_477_14 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I13g",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/I14f",
		"TextureConfig/Background/I13f",
		"TextureConfig/Background/SS1601"
	},
	voices = {
		"story_v_out_416011.awb"
	}
}
