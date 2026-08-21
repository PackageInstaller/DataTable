return {
	Play113131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113131001
		arg_1_1.duration_ = 21.9

		local var_1_0 = {
			ja = 13.6,
			ko = 17.5,
			zh = 21.866,
			en = 21.9
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
				arg_1_0:Play113131002(arg_1_1)
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_12 = 2
			local var_4_13 = 1.525

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_14 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_14:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_15 = arg_1_1:FormatText(StoryNameCfg[36].name)

				arg_1_1.leftNameTxt_.text = var_4_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:GetWordFromCfg(113131001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 61
				local var_4_19 = utf8.len(var_4_17)
				local var_4_20 = var_4_18 <= 0 and var_4_13 or var_4_13 * (var_4_19 / var_4_18)

				if var_4_20 > 0 and var_4_13 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_12 = var_4_12 + 0.3

					if var_4_20 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_12
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131001", "story_v_out_113131.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_113131", "113131001", "story_v_out_113131.awb") / 1000

					if var_4_21 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_12
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_out_113131", "113131001", "story_v_out_113131.awb")

						arg_1_1:RecordAudio("113131001", var_4_22)
						arg_1_1:RecordAudio("113131001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113131", "113131001", "story_v_out_113131.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113131", "113131001", "story_v_out_113131.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_12 + 0.3
			local var_4_24 = math.max(var_4_13, arg_1_1.talkMaxDuration)

			if var_4_23 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play113131002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 113131002
		arg_8_1.duration_ = 12.43

		local var_8_0 = {
			ja = 12.433,
			ko = 9.2,
			zh = 10.6,
			en = 10.933
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
				arg_8_0:Play113131003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.925

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[36].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:GetWordFromCfg(113131002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 37
				local var_11_6 = utf8.len(var_11_4)
				local var_11_7 = var_11_5 <= 0 and var_11_1 or var_11_1 * (var_11_6 / var_11_5)

				if var_11_7 > 0 and var_11_1 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131002", "story_v_out_113131.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_113131", "113131002", "story_v_out_113131.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_113131", "113131002", "story_v_out_113131.awb")

						arg_8_1:RecordAudio("113131002", var_11_9)
						arg_8_1:RecordAudio("113131002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_113131", "113131002", "story_v_out_113131.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_113131", "113131002", "story_v_out_113131.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_10 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_10 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_10

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_10 and arg_8_1.time_ < var_11_0 + var_11_10 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play113131003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 113131003
		arg_12_1.duration_ = 19.03

		local var_12_0 = {
			ja = 19.033,
			ko = 10.066,
			zh = 12.933,
			en = 12.7
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
				arg_12_0:Play113131004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_1 = 2

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_1 then
				local var_15_2 = (arg_12_1.time_ - var_15_0) / var_15_1
				local var_15_3 = Color.New(0, 0, 0)

				var_15_3.a = Mathf.Lerp(0, 1, var_15_2)
				arg_12_1.mask_.color = var_15_3
			end

			if arg_12_1.time_ >= var_15_0 + var_15_1 and arg_12_1.time_ < var_15_0 + var_15_1 + arg_15_0 then
				local var_15_4 = Color.New(0, 0, 0)

				var_15_4.a = 1
				arg_12_1.mask_.color = var_15_4
			end

			local var_15_5 = 2

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_6 = 2

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 then
				local var_15_7 = (arg_12_1.time_ - var_15_5) / var_15_6
				local var_15_8 = Color.New(0, 0, 0)

				var_15_8.a = Mathf.Lerp(1, 0, var_15_7)
				arg_12_1.mask_.color = var_15_8
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 then
				local var_15_9 = Color.New(0, 0, 0)
				local var_15_10 = 0

				arg_12_1.mask_.enabled = false
				var_15_9.a = var_15_10
				arg_12_1.mask_.color = var_15_9
			end

			local var_15_11 = "OM0108"

			if arg_12_1.bgs_[var_15_11] == nil then
				local var_15_12 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_15_11)
				var_15_12.name = var_15_11
				var_15_12.transform.parent = arg_12_1.stage_.transform
				var_15_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_[var_15_11] = var_15_12
			end

			local var_15_13 = 2

			if var_15_13 < arg_12_1.time_ and arg_12_1.time_ <= var_15_13 + arg_15_0 then
				local var_15_14 = manager.ui.mainCamera.transform.localPosition
				local var_15_15 = Vector3.New(0, 0, 10) + Vector3.New(var_15_14.x, var_15_14.y, 0)
				local var_15_16 = arg_12_1.bgs_.OM0108

				var_15_16.transform.localPosition = var_15_15
				var_15_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_17 = var_15_16:GetComponent("SpriteRenderer")

				if var_15_17 and var_15_17.sprite then
					local var_15_18 = (var_15_16.transform.localPosition - var_15_14).z
					local var_15_19 = manager.ui.mainCameraCom_
					local var_15_20 = 2 * var_15_18 * Mathf.Tan(var_15_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_15_21 = var_15_20 * var_15_19.aspect
					local var_15_22 = var_15_17.sprite.bounds.size.x
					local var_15_23 = var_15_17.sprite.bounds.size.y
					local var_15_24 = var_15_21 / var_15_22
					local var_15_25 = var_15_20 / var_15_23
					local var_15_26 = var_15_25 < var_15_24 and var_15_24 or var_15_25

					var_15_16.transform.localScale = Vector3.New(var_15_26, var_15_26, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "OM0108" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_27 = 4
			local var_15_28 = 0.425

			if var_15_27 < arg_12_1.time_ and arg_12_1.time_ <= var_15_27 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_29 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_29:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_30 = arg_12_1:FormatText(StoryNameCfg[36].name)

				arg_12_1.leftNameTxt_.text = var_15_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_31 = arg_12_1:GetWordFromCfg(113131003)
				local var_15_32 = arg_12_1:FormatText(var_15_31.content)

				arg_12_1.text_.text = var_15_32

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_33 = 17
				local var_15_34 = utf8.len(var_15_32)
				local var_15_35 = var_15_33 <= 0 and var_15_28 or var_15_28 * (var_15_34 / var_15_33)

				if var_15_35 > 0 and var_15_28 < var_15_35 then
					arg_12_1.talkMaxDuration = var_15_35
					var_15_27 = var_15_27 + 0.3

					if var_15_35 + var_15_27 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_35 + var_15_27
					end
				end

				arg_12_1.text_.text = var_15_32
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131003", "story_v_out_113131.awb") ~= 0 then
					local var_15_36 = manager.audio:GetVoiceLength("story_v_out_113131", "113131003", "story_v_out_113131.awb") / 1000

					if var_15_36 + var_15_27 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_36 + var_15_27
					end

					if var_15_31.prefab_name ~= "" and arg_12_1.actors_[var_15_31.prefab_name] ~= nil then
						local var_15_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_31.prefab_name].transform, "story_v_out_113131", "113131003", "story_v_out_113131.awb")

						arg_12_1:RecordAudio("113131003", var_15_37)
						arg_12_1:RecordAudio("113131003", var_15_37)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_113131", "113131003", "story_v_out_113131.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_113131", "113131003", "story_v_out_113131.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_38 = var_15_27 + 0.3
			local var_15_39 = math.max(var_15_28, arg_12_1.talkMaxDuration)

			if var_15_38 <= arg_12_1.time_ and arg_12_1.time_ < var_15_38 + var_15_39 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_38) / var_15_39

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_38 + var_15_39 and arg_12_1.time_ < var_15_38 + var_15_39 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play113131004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 113131004
		arg_18_1.duration_ = 13.47

		local var_18_0 = {
			ja = 10.4,
			ko = 12.2,
			zh = 12.966,
			en = 13.466
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play113131005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 1.225

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_2 = arg_18_1:FormatText(StoryNameCfg[36].name)

				arg_18_1.leftNameTxt_.text = var_21_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_3 = arg_18_1:GetWordFromCfg(113131004)
				local var_21_4 = arg_18_1:FormatText(var_21_3.content)

				arg_18_1.text_.text = var_21_4

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 49
				local var_21_6 = utf8.len(var_21_4)
				local var_21_7 = var_21_5 <= 0 and var_21_1 or var_21_1 * (var_21_6 / var_21_5)

				if var_21_7 > 0 and var_21_1 < var_21_7 then
					arg_18_1.talkMaxDuration = var_21_7

					if var_21_7 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_7 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_4
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131004", "story_v_out_113131.awb") ~= 0 then
					local var_21_8 = manager.audio:GetVoiceLength("story_v_out_113131", "113131004", "story_v_out_113131.awb") / 1000

					if var_21_8 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_0
					end

					if var_21_3.prefab_name ~= "" and arg_18_1.actors_[var_21_3.prefab_name] ~= nil then
						local var_21_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_3.prefab_name].transform, "story_v_out_113131", "113131004", "story_v_out_113131.awb")

						arg_18_1:RecordAudio("113131004", var_21_9)
						arg_18_1:RecordAudio("113131004", var_21_9)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_113131", "113131004", "story_v_out_113131.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_113131", "113131004", "story_v_out_113131.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_10 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_10 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_10

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_10 and arg_18_1.time_ < var_21_0 + var_21_10 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play113131005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 113131005
		arg_22_1.duration_ = 12.47

		local var_22_0 = {
			ja = 12.466,
			ko = 7.966,
			zh = 8.2,
			en = 9.066
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
				arg_22_0:Play113131006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0
			local var_25_1 = 0.8

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_2 = arg_22_1:FormatText(StoryNameCfg[36].name)

				arg_22_1.leftNameTxt_.text = var_25_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_3 = arg_22_1:GetWordFromCfg(113131005)
				local var_25_4 = arg_22_1:FormatText(var_25_3.content)

				arg_22_1.text_.text = var_25_4

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_5 = 32
				local var_25_6 = utf8.len(var_25_4)
				local var_25_7 = var_25_5 <= 0 and var_25_1 or var_25_1 * (var_25_6 / var_25_5)

				if var_25_7 > 0 and var_25_1 < var_25_7 then
					arg_22_1.talkMaxDuration = var_25_7

					if var_25_7 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_0
					end
				end

				arg_22_1.text_.text = var_25_4
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131005", "story_v_out_113131.awb") ~= 0 then
					local var_25_8 = manager.audio:GetVoiceLength("story_v_out_113131", "113131005", "story_v_out_113131.awb") / 1000

					if var_25_8 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_8 + var_25_0
					end

					if var_25_3.prefab_name ~= "" and arg_22_1.actors_[var_25_3.prefab_name] ~= nil then
						local var_25_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_3.prefab_name].transform, "story_v_out_113131", "113131005", "story_v_out_113131.awb")

						arg_22_1:RecordAudio("113131005", var_25_9)
						arg_22_1:RecordAudio("113131005", var_25_9)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_113131", "113131005", "story_v_out_113131.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_113131", "113131005", "story_v_out_113131.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_10 = math.max(var_25_1, arg_22_1.talkMaxDuration)

			if var_25_0 <= arg_22_1.time_ and arg_22_1.time_ < var_25_0 + var_25_10 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_0) / var_25_10

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_0 + var_25_10 and arg_22_1.time_ < var_25_0 + var_25_10 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play113131006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 113131006
		arg_26_1.duration_ = 8.27

		local var_26_0 = {
			ja = 8.266,
			ko = 2.733,
			zh = 4.533,
			en = 5.066
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play113131007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 0.375

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_2 = arg_26_1:FormatText(StoryNameCfg[36].name)

				arg_26_1.leftNameTxt_.text = var_29_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_3 = arg_26_1:GetWordFromCfg(113131006)
				local var_29_4 = arg_26_1:FormatText(var_29_3.content)

				arg_26_1.text_.text = var_29_4

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 15
				local var_29_6 = utf8.len(var_29_4)
				local var_29_7 = var_29_5 <= 0 and var_29_1 or var_29_1 * (var_29_6 / var_29_5)

				if var_29_7 > 0 and var_29_1 < var_29_7 then
					arg_26_1.talkMaxDuration = var_29_7

					if var_29_7 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_7 + var_29_0
					end
				end

				arg_26_1.text_.text = var_29_4
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131006", "story_v_out_113131.awb") ~= 0 then
					local var_29_8 = manager.audio:GetVoiceLength("story_v_out_113131", "113131006", "story_v_out_113131.awb") / 1000

					if var_29_8 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_0
					end

					if var_29_3.prefab_name ~= "" and arg_26_1.actors_[var_29_3.prefab_name] ~= nil then
						local var_29_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_3.prefab_name].transform, "story_v_out_113131", "113131006", "story_v_out_113131.awb")

						arg_26_1:RecordAudio("113131006", var_29_9)
						arg_26_1:RecordAudio("113131006", var_29_9)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_113131", "113131006", "story_v_out_113131.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_113131", "113131006", "story_v_out_113131.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_10 = math.max(var_29_1, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_10 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_0) / var_29_10

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_10 and arg_26_1.time_ < var_29_0 + var_29_10 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play113131007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 113131007
		arg_30_1.duration_ = 6.72

		local var_30_0 = {
			ja = 6.725,
			ko = 5.491,
			zh = 5.458,
			en = 6.291
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play113131008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = true

				arg_30_1:SetGaussion(false)
			end

			local var_33_1 = 2

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_1 then
				local var_33_2 = (arg_30_1.time_ - var_33_0) / var_33_1
				local var_33_3 = Color.New(0, 0, 0)

				var_33_3.a = Mathf.Lerp(0, 1, var_33_2)
				arg_30_1.mask_.color = var_33_3
			end

			if arg_30_1.time_ >= var_33_0 + var_33_1 and arg_30_1.time_ < var_33_0 + var_33_1 + arg_33_0 then
				local var_33_4 = Color.New(0, 0, 0)

				var_33_4.a = 1
				arg_30_1.mask_.color = var_33_4
			end

			local var_33_5 = 2

			if var_33_5 < arg_30_1.time_ and arg_30_1.time_ <= var_33_5 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = true

				arg_30_1:SetGaussion(false)
			end

			local var_33_6 = 2

			if var_33_5 <= arg_30_1.time_ and arg_30_1.time_ < var_33_5 + var_33_6 then
				local var_33_7 = (arg_30_1.time_ - var_33_5) / var_33_6
				local var_33_8 = Color.New(0, 0, 0)

				var_33_8.a = Mathf.Lerp(1, 0, var_33_7)
				arg_30_1.mask_.color = var_33_8
			end

			if arg_30_1.time_ >= var_33_5 + var_33_6 and arg_30_1.time_ < var_33_5 + var_33_6 + arg_33_0 then
				local var_33_9 = Color.New(0, 0, 0)
				local var_33_10 = 0

				arg_30_1.mask_.enabled = false
				var_33_9.a = var_33_10
				arg_30_1.mask_.color = var_33_9
			end

			local var_33_11 = "STblack"

			if arg_30_1.bgs_[var_33_11] == nil then
				local var_33_12 = Object.Instantiate(arg_30_1.paintGo_)

				var_33_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_33_11)
				var_33_12.name = var_33_11
				var_33_12.transform.parent = arg_30_1.stage_.transform
				var_33_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.bgs_[var_33_11] = var_33_12
			end

			local var_33_13 = 2

			if var_33_13 < arg_30_1.time_ and arg_30_1.time_ <= var_33_13 + arg_33_0 then
				local var_33_14 = manager.ui.mainCamera.transform.localPosition
				local var_33_15 = Vector3.New(0, 0, 10) + Vector3.New(var_33_14.x, var_33_14.y, 0)
				local var_33_16 = arg_30_1.bgs_.STblack

				var_33_16.transform.localPosition = var_33_15
				var_33_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_33_17 = var_33_16:GetComponent("SpriteRenderer")

				if var_33_17 and var_33_17.sprite then
					local var_33_18 = (var_33_16.transform.localPosition - var_33_14).z
					local var_33_19 = manager.ui.mainCameraCom_
					local var_33_20 = 2 * var_33_18 * Mathf.Tan(var_33_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_33_21 = var_33_20 * var_33_19.aspect
					local var_33_22 = var_33_17.sprite.bounds.size.x
					local var_33_23 = var_33_17.sprite.bounds.size.y
					local var_33_24 = var_33_21 / var_33_22
					local var_33_25 = var_33_20 / var_33_23
					local var_33_26 = var_33_25 < var_33_24 and var_33_24 or var_33_25

					var_33_16.transform.localScale = Vector3.New(var_33_26, var_33_26, 0)
				end

				for iter_33_0, iter_33_1 in pairs(arg_30_1.bgs_) do
					if iter_33_0 ~= "STblack" then
						iter_33_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_30_1.frameCnt_ <= 1 then
				arg_30_1.dialog_:SetActive(false)
			end

			local var_33_27 = 3.925
			local var_33_28 = 0.075

			if var_33_27 < arg_30_1.time_ and arg_30_1.time_ <= var_33_27 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				arg_30_1.dialog_:SetActive(true)

				arg_30_1.dialogCg_.alpha = 0

				local var_33_29 = LeanTween.value(arg_30_1.dialog_, 0, 1, 0.3)

				var_33_29:setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
					arg_30_1.dialogCg_.alpha = arg_34_0
				end))
				var_33_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_30_1.dialog_)
					var_33_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_30_1.duration_ = arg_30_1.duration_ + 0.3

				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_30 = arg_30_1:FormatText(StoryNameCfg[208].name)

				arg_30_1.leftNameTxt_.text = var_33_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_31 = arg_30_1:GetWordFromCfg(113131007)
				local var_33_32 = arg_30_1:FormatText(var_33_31.content)

				arg_30_1.text_.text = var_33_32

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_33 = 3
				local var_33_34 = utf8.len(var_33_32)
				local var_33_35 = var_33_33 <= 0 and var_33_28 or var_33_28 * (var_33_34 / var_33_33)

				if var_33_35 > 0 and var_33_28 < var_33_35 then
					arg_30_1.talkMaxDuration = var_33_35
					var_33_27 = var_33_27 + 0.3

					if var_33_35 + var_33_27 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_35 + var_33_27
					end
				end

				arg_30_1.text_.text = var_33_32
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131007", "story_v_out_113131.awb") ~= 0 then
					local var_33_36 = manager.audio:GetVoiceLength("story_v_out_113131", "113131007", "story_v_out_113131.awb") / 1000

					if var_33_36 + var_33_27 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_36 + var_33_27
					end

					if var_33_31.prefab_name ~= "" and arg_30_1.actors_[var_33_31.prefab_name] ~= nil then
						local var_33_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_31.prefab_name].transform, "story_v_out_113131", "113131007", "story_v_out_113131.awb")

						arg_30_1:RecordAudio("113131007", var_33_37)
						arg_30_1:RecordAudio("113131007", var_33_37)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_113131", "113131007", "story_v_out_113131.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_113131", "113131007", "story_v_out_113131.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_38 = var_33_27 + 0.3
			local var_33_39 = math.max(var_33_28, arg_30_1.talkMaxDuration)

			if var_33_38 <= arg_30_1.time_ and arg_30_1.time_ < var_33_38 + var_33_39 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_38) / var_33_39

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_38 + var_33_39 and arg_30_1.time_ < var_33_38 + var_33_39 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play113131008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 113131008
		arg_36_1.duration_ = 12.67

		local var_36_0 = {
			ja = 12.666,
			ko = 10.566,
			zh = 9.8,
			en = 5.566
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play113131009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.875

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[36].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:GetWordFromCfg(113131008)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 35
				local var_39_6 = utf8.len(var_39_4)
				local var_39_7 = var_39_5 <= 0 and var_39_1 or var_39_1 * (var_39_6 / var_39_5)

				if var_39_7 > 0 and var_39_1 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131008", "story_v_out_113131.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_113131", "113131008", "story_v_out_113131.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_113131", "113131008", "story_v_out_113131.awb")

						arg_36_1:RecordAudio("113131008", var_39_9)
						arg_36_1:RecordAudio("113131008", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_113131", "113131008", "story_v_out_113131.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_113131", "113131008", "story_v_out_113131.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_10 and arg_36_1.time_ < var_39_0 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play113131009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 113131009
		arg_40_1.duration_ = 8.63

		local var_40_0 = {
			ja = 8.633,
			ko = 3.8,
			zh = 5.666,
			en = 6.5
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play113131010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.375

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[36].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(113131009)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 15
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131009", "story_v_out_113131.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_113131", "113131009", "story_v_out_113131.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_113131", "113131009", "story_v_out_113131.awb")

						arg_40_1:RecordAudio("113131009", var_43_9)
						arg_40_1:RecordAudio("113131009", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_113131", "113131009", "story_v_out_113131.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_113131", "113131009", "story_v_out_113131.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play113131010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 113131010
		arg_44_1.duration_ = 14.63

		local var_44_0 = {
			ja = 9.933,
			ko = 7.9,
			zh = 10.333,
			en = 14.633
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
				arg_44_0:Play113131011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.7

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[36].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:GetWordFromCfg(113131010)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 28
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131010", "story_v_out_113131.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_113131", "113131010", "story_v_out_113131.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_113131", "113131010", "story_v_out_113131.awb")

						arg_44_1:RecordAudio("113131010", var_47_9)
						arg_44_1:RecordAudio("113131010", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_113131", "113131010", "story_v_out_113131.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_113131", "113131010", "story_v_out_113131.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play113131011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 113131011
		arg_48_1.duration_ = 7.57

		local var_48_0 = {
			ja = 7.566,
			ko = 6.1,
			zh = 6.466,
			en = 5.3
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
				arg_48_0:Play113131012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.4

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[36].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:GetWordFromCfg(113131011)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131011", "story_v_out_113131.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_113131", "113131011", "story_v_out_113131.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_113131", "113131011", "story_v_out_113131.awb")

						arg_48_1:RecordAudio("113131011", var_51_9)
						arg_48_1:RecordAudio("113131011", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_113131", "113131011", "story_v_out_113131.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_113131", "113131011", "story_v_out_113131.awb")
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
	Play113131012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 113131012
		arg_52_1.duration_ = 8.47

		local var_52_0 = {
			ja = 6.5,
			ko = 6.5,
			zh = 8.466,
			en = 5.8
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
				arg_52_0:Play113131013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "ST21a"

			if arg_52_1.bgs_[var_55_0] == nil then
				local var_55_1 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_0)
				var_55_1.name = var_55_0
				var_55_1.transform.parent = arg_52_1.stage_.transform
				var_55_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_0] = var_55_1
			end

			local var_55_2 = 0

			if var_55_2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				local var_55_3 = manager.ui.mainCamera.transform.localPosition
				local var_55_4 = Vector3.New(0, 0, 10) + Vector3.New(var_55_3.x, var_55_3.y, 0)
				local var_55_5 = arg_52_1.bgs_.ST21a

				var_55_5.transform.localPosition = var_55_4
				var_55_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_6 = var_55_5:GetComponent("SpriteRenderer")

				if var_55_6 and var_55_6.sprite then
					local var_55_7 = (var_55_5.transform.localPosition - var_55_3).z
					local var_55_8 = manager.ui.mainCameraCom_
					local var_55_9 = 2 * var_55_7 * Mathf.Tan(var_55_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_55_10 = var_55_9 * var_55_8.aspect
					local var_55_11 = var_55_6.sprite.bounds.size.x
					local var_55_12 = var_55_6.sprite.bounds.size.y
					local var_55_13 = var_55_10 / var_55_11
					local var_55_14 = var_55_9 / var_55_12
					local var_55_15 = var_55_14 < var_55_13 and var_55_13 or var_55_14

					var_55_5.transform.localScale = Vector3.New(var_55_15, var_55_15, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "ST21a" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_16 = 0

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_17 = 2

			if var_55_16 <= arg_52_1.time_ and arg_52_1.time_ < var_55_16 + var_55_17 then
				local var_55_18 = (arg_52_1.time_ - var_55_16) / var_55_17
				local var_55_19 = Color.New(1, 1, 1)

				var_55_19.a = Mathf.Lerp(1, 0, var_55_18)
				arg_52_1.mask_.color = var_55_19
			end

			if arg_52_1.time_ >= var_55_16 + var_55_17 and arg_52_1.time_ < var_55_16 + var_55_17 + arg_55_0 then
				local var_55_20 = Color.New(1, 1, 1)
				local var_55_21 = 0

				arg_52_1.mask_.enabled = false
				var_55_20.a = var_55_21
				arg_52_1.mask_.color = var_55_20
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_22 = 2
			local var_55_23 = 0.25

			if var_55_22 < arg_52_1.time_ and arg_52_1.time_ <= var_55_22 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_24 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_24:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_25 = arg_52_1:FormatText(StoryNameCfg[208].name)

				arg_52_1.leftNameTxt_.text = var_55_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_26 = arg_52_1:GetWordFromCfg(113131012)
				local var_55_27 = arg_52_1:FormatText(var_55_26.content)

				arg_52_1.text_.text = var_55_27

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_28 = 10
				local var_55_29 = utf8.len(var_55_27)
				local var_55_30 = var_55_28 <= 0 and var_55_23 or var_55_23 * (var_55_29 / var_55_28)

				if var_55_30 > 0 and var_55_23 < var_55_30 then
					arg_52_1.talkMaxDuration = var_55_30
					var_55_22 = var_55_22 + 0.3

					if var_55_30 + var_55_22 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_30 + var_55_22
					end
				end

				arg_52_1.text_.text = var_55_27
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131012", "story_v_out_113131.awb") ~= 0 then
					local var_55_31 = manager.audio:GetVoiceLength("story_v_out_113131", "113131012", "story_v_out_113131.awb") / 1000

					if var_55_31 + var_55_22 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_31 + var_55_22
					end

					if var_55_26.prefab_name ~= "" and arg_52_1.actors_[var_55_26.prefab_name] ~= nil then
						local var_55_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_26.prefab_name].transform, "story_v_out_113131", "113131012", "story_v_out_113131.awb")

						arg_52_1:RecordAudio("113131012", var_55_32)
						arg_52_1:RecordAudio("113131012", var_55_32)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_113131", "113131012", "story_v_out_113131.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_113131", "113131012", "story_v_out_113131.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_33 = var_55_22 + 0.3
			local var_55_34 = math.max(var_55_23, arg_52_1.talkMaxDuration)

			if var_55_33 <= arg_52_1.time_ and arg_52_1.time_ < var_55_33 + var_55_34 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_33) / var_55_34

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_33 + var_55_34 and arg_52_1.time_ < var_55_33 + var_55_34 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play113131013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 113131013
		arg_58_1.duration_ = 7.77

		local var_58_0 = {
			ja = 6.166,
			ko = 6.233,
			zh = 7.533,
			en = 7.766
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play113131014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 1

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				local var_61_2 = "play"
				local var_61_3 = "music"

				arg_58_1:AudioAction(var_61_2, var_61_3, "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_61_4 = ""
				local var_61_5 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if var_61_5 ~= "" then
					if arg_58_1.bgmTxt_.text ~= var_61_5 and arg_58_1.bgmTxt_.text ~= "" then
						if arg_58_1.bgmTxt2_.text ~= "" then
							arg_58_1.bgmTxt_.text = arg_58_1.bgmTxt2_.text
						end

						arg_58_1.bgmTxt2_.text = var_61_5

						arg_58_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_58_1.bgmTxt_.text = var_61_5
						arg_58_1.bgmTxt2_.text = var_61_5
					end

					if arg_58_1.bgmTimer then
						arg_58_1.bgmTimer:Stop()

						arg_58_1.bgmTimer = nil
					end

					if arg_58_1.settingData.show_music_name == 1 then
						arg_58_1.musicController:SetSelectedState("show")
						arg_58_1.musicAnimator_:Play("open", 0, 0)

						if arg_58_1.settingData.music_time ~= 0 then
							arg_58_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_58_1.settingData.music_time), function()
								if arg_58_1 == nil or isNil(arg_58_1.bgmTxt_) then
									return
								end

								arg_58_1.musicController:SetSelectedState("hide")
								arg_58_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_61_6 = 0
			local var_61_7 = 0.625

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_8 = arg_58_1:FormatText(StoryNameCfg[210].name)

				arg_58_1.leftNameTxt_.text = var_61_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_9 = arg_58_1:GetWordFromCfg(113131013)
				local var_61_10 = arg_58_1:FormatText(var_61_9.content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 25
				local var_61_12 = utf8.len(var_61_10)
				local var_61_13 = var_61_11 <= 0 and var_61_7 or var_61_7 * (var_61_12 / var_61_11)

				if var_61_13 > 0 and var_61_7 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_10
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131013", "story_v_out_113131.awb") ~= 0 then
					local var_61_14 = manager.audio:GetVoiceLength("story_v_out_113131", "113131013", "story_v_out_113131.awb") / 1000

					if var_61_14 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_14 + var_61_6
					end

					if var_61_9.prefab_name ~= "" and arg_58_1.actors_[var_61_9.prefab_name] ~= nil then
						local var_61_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_9.prefab_name].transform, "story_v_out_113131", "113131013", "story_v_out_113131.awb")

						arg_58_1:RecordAudio("113131013", var_61_15)
						arg_58_1:RecordAudio("113131013", var_61_15)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_113131", "113131013", "story_v_out_113131.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_113131", "113131013", "story_v_out_113131.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_16 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_16 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_16

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_16 and arg_58_1.time_ < var_61_6 + var_61_16 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play113131014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 113131014
		arg_63_1.duration_ = 7.3

		local var_63_0 = {
			ja = 7.3,
			ko = 2.733,
			zh = 4.566,
			en = 5.9
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
				arg_63_0:Play113131015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = "1041ui_story"

			if arg_63_1.actors_[var_66_0] == nil then
				local var_66_1 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_66_1) then
					local var_66_2 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_63_1.stage_.transform)

					var_66_2.name = var_66_0
					var_66_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_63_1.actors_[var_66_0] = var_66_2

					local var_66_3 = var_66_2:GetComponentInChildren(typeof(CharacterEffect))

					var_66_3.enabled = true

					local var_66_4 = GameObjectTools.GetOrAddComponent(var_66_2, typeof(DynamicBoneHelper))

					if var_66_4 then
						var_66_4:EnableDynamicBone(false)
					end

					arg_63_1:ShowWeapon(var_66_3.transform, false)

					arg_63_1.var_[var_66_0 .. "Animator"] = var_66_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_63_1.var_[var_66_0 .. "Animator"].applyRootMotion = true
					arg_63_1.var_[var_66_0 .. "LipSync"] = var_66_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_66_5 = arg_63_1.actors_["1041ui_story"].transform
			local var_66_6 = 0

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.var_.moveOldPos1041ui_story = var_66_5.localPosition
			end

			local var_66_7 = 0.001

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_7 then
				local var_66_8 = (arg_63_1.time_ - var_66_6) / var_66_7
				local var_66_9 = Vector3.New(0, -1.11, -5.9)

				var_66_5.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1041ui_story, var_66_9, var_66_8)

				local var_66_10 = manager.ui.mainCamera.transform.position - var_66_5.position

				var_66_5.forward = Vector3.New(var_66_10.x, var_66_10.y, var_66_10.z)

				local var_66_11 = var_66_5.localEulerAngles

				var_66_11.z = 0
				var_66_11.x = 0
				var_66_5.localEulerAngles = var_66_11
			end

			if arg_63_1.time_ >= var_66_6 + var_66_7 and arg_63_1.time_ < var_66_6 + var_66_7 + arg_66_0 then
				var_66_5.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_66_12 = manager.ui.mainCamera.transform.position - var_66_5.position

				var_66_5.forward = Vector3.New(var_66_12.x, var_66_12.y, var_66_12.z)

				local var_66_13 = var_66_5.localEulerAngles

				var_66_13.z = 0
				var_66_13.x = 0
				var_66_5.localEulerAngles = var_66_13
			end

			local var_66_14 = 0

			if var_66_14 < arg_63_1.time_ and arg_63_1.time_ <= var_66_14 + arg_66_0 then
				arg_63_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_66_15 = 0

			if var_66_15 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 then
				arg_63_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_66_16 = arg_63_1.actors_["1041ui_story"]
			local var_66_17 = 0

			if var_66_17 < arg_63_1.time_ and arg_63_1.time_ <= var_66_17 + arg_66_0 and not isNil(var_66_16) and arg_63_1.var_.characterEffect1041ui_story == nil then
				arg_63_1.var_.characterEffect1041ui_story = var_66_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_18 = 0.2

			if var_66_17 <= arg_63_1.time_ and arg_63_1.time_ < var_66_17 + var_66_18 and not isNil(var_66_16) then
				local var_66_19 = (arg_63_1.time_ - var_66_17) / var_66_18

				if arg_63_1.var_.characterEffect1041ui_story and not isNil(var_66_16) then
					arg_63_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_17 + var_66_18 and arg_63_1.time_ < var_66_17 + var_66_18 + arg_66_0 and not isNil(var_66_16) and arg_63_1.var_.characterEffect1041ui_story then
				arg_63_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_66_20 = 0
			local var_66_21 = 0.2

			if var_66_20 < arg_63_1.time_ and arg_63_1.time_ <= var_66_20 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_22 = arg_63_1:FormatText(StoryNameCfg[208].name)

				arg_63_1.leftNameTxt_.text = var_66_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_23 = arg_63_1:GetWordFromCfg(113131014)
				local var_66_24 = arg_63_1:FormatText(var_66_23.content)

				arg_63_1.text_.text = var_66_24

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_25 = 8
				local var_66_26 = utf8.len(var_66_24)
				local var_66_27 = var_66_25 <= 0 and var_66_21 or var_66_21 * (var_66_26 / var_66_25)

				if var_66_27 > 0 and var_66_21 < var_66_27 then
					arg_63_1.talkMaxDuration = var_66_27

					if var_66_27 + var_66_20 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_27 + var_66_20
					end
				end

				arg_63_1.text_.text = var_66_24
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131014", "story_v_out_113131.awb") ~= 0 then
					local var_66_28 = manager.audio:GetVoiceLength("story_v_out_113131", "113131014", "story_v_out_113131.awb") / 1000

					if var_66_28 + var_66_20 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_28 + var_66_20
					end

					if var_66_23.prefab_name ~= "" and arg_63_1.actors_[var_66_23.prefab_name] ~= nil then
						local var_66_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_23.prefab_name].transform, "story_v_out_113131", "113131014", "story_v_out_113131.awb")

						arg_63_1:RecordAudio("113131014", var_66_29)
						arg_63_1:RecordAudio("113131014", var_66_29)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_113131", "113131014", "story_v_out_113131.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_113131", "113131014", "story_v_out_113131.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_30 = math.max(var_66_21, arg_63_1.talkMaxDuration)

			if var_66_20 <= arg_63_1.time_ and arg_63_1.time_ < var_66_20 + var_66_30 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_20) / var_66_30

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_20 + var_66_30 and arg_63_1.time_ < var_66_20 + var_66_30 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play113131015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 113131015
		arg_67_1.duration_ = 8.13

		local var_67_0 = {
			ja = 7.466,
			ko = 7.633,
			zh = 7.233,
			en = 8.133
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
				arg_67_0:Play113131016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1041ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1041ui_story == nil then
				arg_67_1.var_.characterEffect1041ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.2

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect1041ui_story and not isNil(var_70_0) then
					local var_70_4 = Mathf.Lerp(0, 0.5, var_70_3)

					arg_67_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1041ui_story.fillRatio = var_70_4
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1041ui_story then
				local var_70_5 = 0.5

				arg_67_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1041ui_story.fillRatio = var_70_5
			end

			local var_70_6 = 0
			local var_70_7 = 0.825

			if var_70_6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_8 = arg_67_1:FormatText(StoryNameCfg[210].name)

				arg_67_1.leftNameTxt_.text = var_70_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_9 = arg_67_1:GetWordFromCfg(113131015)
				local var_70_10 = arg_67_1:FormatText(var_70_9.content)

				arg_67_1.text_.text = var_70_10

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_11 = 32
				local var_70_12 = utf8.len(var_70_10)
				local var_70_13 = var_70_11 <= 0 and var_70_7 or var_70_7 * (var_70_12 / var_70_11)

				if var_70_13 > 0 and var_70_7 < var_70_13 then
					arg_67_1.talkMaxDuration = var_70_13

					if var_70_13 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_13 + var_70_6
					end
				end

				arg_67_1.text_.text = var_70_10
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131015", "story_v_out_113131.awb") ~= 0 then
					local var_70_14 = manager.audio:GetVoiceLength("story_v_out_113131", "113131015", "story_v_out_113131.awb") / 1000

					if var_70_14 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_14 + var_70_6
					end

					if var_70_9.prefab_name ~= "" and arg_67_1.actors_[var_70_9.prefab_name] ~= nil then
						local var_70_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_9.prefab_name].transform, "story_v_out_113131", "113131015", "story_v_out_113131.awb")

						arg_67_1:RecordAudio("113131015", var_70_15)
						arg_67_1:RecordAudio("113131015", var_70_15)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_113131", "113131015", "story_v_out_113131.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_113131", "113131015", "story_v_out_113131.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_16 = math.max(var_70_7, arg_67_1.talkMaxDuration)

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_16 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_6) / var_70_16

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_6 + var_70_16 and arg_67_1.time_ < var_70_6 + var_70_16 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play113131016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 113131016
		arg_71_1.duration_ = 4.8

		local var_71_0 = {
			ja = 4.8,
			ko = 2.466,
			zh = 3.6,
			en = 2.8
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
				arg_71_0:Play113131017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_74_1 = arg_71_1.actors_["1041ui_story"]
			local var_74_2 = 0

			if var_74_2 < arg_71_1.time_ and arg_71_1.time_ <= var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1041ui_story == nil then
				arg_71_1.var_.characterEffect1041ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_3 = 0.2

			if var_74_2 <= arg_71_1.time_ and arg_71_1.time_ < var_74_2 + var_74_3 and not isNil(var_74_1) then
				local var_74_4 = (arg_71_1.time_ - var_74_2) / var_74_3

				if arg_71_1.var_.characterEffect1041ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_2 + var_74_3 and arg_71_1.time_ < var_74_2 + var_74_3 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1041ui_story then
				arg_71_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_74_5 = 0
			local var_74_6 = 0.225

			if var_74_5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_7 = arg_71_1:FormatText(StoryNameCfg[208].name)

				arg_71_1.leftNameTxt_.text = var_74_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:GetWordFromCfg(113131016)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 9
				local var_74_11 = utf8.len(var_74_9)
				local var_74_12 = var_74_10 <= 0 and var_74_6 or var_74_6 * (var_74_11 / var_74_10)

				if var_74_12 > 0 and var_74_6 < var_74_12 then
					arg_71_1.talkMaxDuration = var_74_12

					if var_74_12 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_5
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131016", "story_v_out_113131.awb") ~= 0 then
					local var_74_13 = manager.audio:GetVoiceLength("story_v_out_113131", "113131016", "story_v_out_113131.awb") / 1000

					if var_74_13 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_5
					end

					if var_74_8.prefab_name ~= "" and arg_71_1.actors_[var_74_8.prefab_name] ~= nil then
						local var_74_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_8.prefab_name].transform, "story_v_out_113131", "113131016", "story_v_out_113131.awb")

						arg_71_1:RecordAudio("113131016", var_74_14)
						arg_71_1:RecordAudio("113131016", var_74_14)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_113131", "113131016", "story_v_out_113131.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_113131", "113131016", "story_v_out_113131.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_15 = math.max(var_74_6, arg_71_1.talkMaxDuration)

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_15 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_5) / var_74_15

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_5 + var_74_15 and arg_71_1.time_ < var_74_5 + var_74_15 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play113131017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 113131017
		arg_75_1.duration_ = 11.27

		local var_75_0 = {
			ja = 9.5,
			ko = 10.066,
			zh = 7.333,
			en = 11.266
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
				arg_75_0:Play113131018(arg_75_1)
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
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1041ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1041ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1041ui_story.fillRatio = var_78_5
			end

			local var_78_6 = 0
			local var_78_7 = 0.875

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_8 = arg_75_1:FormatText(StoryNameCfg[210].name)

				arg_75_1.leftNameTxt_.text = var_78_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_9 = arg_75_1:GetWordFromCfg(113131017)
				local var_78_10 = arg_75_1:FormatText(var_78_9.content)

				arg_75_1.text_.text = var_78_10

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_11 = 35
				local var_78_12 = utf8.len(var_78_10)
				local var_78_13 = var_78_11 <= 0 and var_78_7 or var_78_7 * (var_78_12 / var_78_11)

				if var_78_13 > 0 and var_78_7 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_10
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131017", "story_v_out_113131.awb") ~= 0 then
					local var_78_14 = manager.audio:GetVoiceLength("story_v_out_113131", "113131017", "story_v_out_113131.awb") / 1000

					if var_78_14 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_14 + var_78_6
					end

					if var_78_9.prefab_name ~= "" and arg_75_1.actors_[var_78_9.prefab_name] ~= nil then
						local var_78_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_9.prefab_name].transform, "story_v_out_113131", "113131017", "story_v_out_113131.awb")

						arg_75_1:RecordAudio("113131017", var_78_15)
						arg_75_1:RecordAudio("113131017", var_78_15)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_113131", "113131017", "story_v_out_113131.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_113131", "113131017", "story_v_out_113131.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_16 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_16 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_16

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_16 and arg_75_1.time_ < var_78_6 + var_78_16 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play113131018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 113131018
		arg_79_1.duration_ = 5.07

		local var_79_0 = {
			ja = 3.366,
			ko = 4.766,
			zh = 5.066,
			en = 5
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
				arg_79_0:Play113131019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_82_1 = arg_79_1.actors_["1041ui_story"]
			local var_82_2 = 0

			if var_82_2 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1041ui_story == nil then
				arg_79_1.var_.characterEffect1041ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_3 = 0.2

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_3 and not isNil(var_82_1) then
				local var_82_4 = (arg_79_1.time_ - var_82_2) / var_82_3

				if arg_79_1.var_.characterEffect1041ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_2 + var_82_3 and arg_79_1.time_ < var_82_2 + var_82_3 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1041ui_story then
				arg_79_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_82_5 = 0
			local var_82_6 = 0.6

			if var_82_5 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_7 = arg_79_1:FormatText(StoryNameCfg[208].name)

				arg_79_1.leftNameTxt_.text = var_82_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_8 = arg_79_1:GetWordFromCfg(113131018)
				local var_82_9 = arg_79_1:FormatText(var_82_8.content)

				arg_79_1.text_.text = var_82_9

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_10 = 24
				local var_82_11 = utf8.len(var_82_9)
				local var_82_12 = var_82_10 <= 0 and var_82_6 or var_82_6 * (var_82_11 / var_82_10)

				if var_82_12 > 0 and var_82_6 < var_82_12 then
					arg_79_1.talkMaxDuration = var_82_12

					if var_82_12 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_5
					end
				end

				arg_79_1.text_.text = var_82_9
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131018", "story_v_out_113131.awb") ~= 0 then
					local var_82_13 = manager.audio:GetVoiceLength("story_v_out_113131", "113131018", "story_v_out_113131.awb") / 1000

					if var_82_13 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_5
					end

					if var_82_8.prefab_name ~= "" and arg_79_1.actors_[var_82_8.prefab_name] ~= nil then
						local var_82_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_8.prefab_name].transform, "story_v_out_113131", "113131018", "story_v_out_113131.awb")

						arg_79_1:RecordAudio("113131018", var_82_14)
						arg_79_1:RecordAudio("113131018", var_82_14)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_113131", "113131018", "story_v_out_113131.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_113131", "113131018", "story_v_out_113131.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_15 = math.max(var_82_6, arg_79_1.talkMaxDuration)

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_15 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_5) / var_82_15

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_5 + var_82_15 and arg_79_1.time_ < var_82_5 + var_82_15 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play113131019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 113131019
		arg_83_1.duration_ = 7.53

		local var_83_0 = {
			ja = 5.866,
			ko = 7.533,
			zh = 6.733,
			en = 6.433
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
				arg_83_0:Play113131020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1041ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1041ui_story == nil then
				arg_83_1.var_.characterEffect1041ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect1041ui_story and not isNil(var_86_0) then
					local var_86_4 = Mathf.Lerp(0, 0.5, var_86_3)

					arg_83_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1041ui_story.fillRatio = var_86_4
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1041ui_story then
				local var_86_5 = 0.5

				arg_83_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1041ui_story.fillRatio = var_86_5
			end

			local var_86_6 = 0
			local var_86_7 = 0.675

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_8 = arg_83_1:FormatText(StoryNameCfg[210].name)

				arg_83_1.leftNameTxt_.text = var_86_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_9 = arg_83_1:GetWordFromCfg(113131019)
				local var_86_10 = arg_83_1:FormatText(var_86_9.content)

				arg_83_1.text_.text = var_86_10

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_11 = 27
				local var_86_12 = utf8.len(var_86_10)
				local var_86_13 = var_86_11 <= 0 and var_86_7 or var_86_7 * (var_86_12 / var_86_11)

				if var_86_13 > 0 and var_86_7 < var_86_13 then
					arg_83_1.talkMaxDuration = var_86_13

					if var_86_13 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_10
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131019", "story_v_out_113131.awb") ~= 0 then
					local var_86_14 = manager.audio:GetVoiceLength("story_v_out_113131", "113131019", "story_v_out_113131.awb") / 1000

					if var_86_14 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_14 + var_86_6
					end

					if var_86_9.prefab_name ~= "" and arg_83_1.actors_[var_86_9.prefab_name] ~= nil then
						local var_86_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_9.prefab_name].transform, "story_v_out_113131", "113131019", "story_v_out_113131.awb")

						arg_83_1:RecordAudio("113131019", var_86_15)
						arg_83_1:RecordAudio("113131019", var_86_15)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_113131", "113131019", "story_v_out_113131.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_113131", "113131019", "story_v_out_113131.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_16 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_16 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_16

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_16 and arg_83_1.time_ < var_86_6 + var_86_16 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play113131020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 113131020
		arg_87_1.duration_ = 2.17

		local var_87_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.166,
			en = 1.999999999999
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
				arg_87_0:Play113131021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_90_1 = arg_87_1.actors_["1041ui_story"]
			local var_90_2 = 0

			if var_90_2 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1041ui_story == nil then
				arg_87_1.var_.characterEffect1041ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_3 = 0.2

			if var_90_2 <= arg_87_1.time_ and arg_87_1.time_ < var_90_2 + var_90_3 and not isNil(var_90_1) then
				local var_90_4 = (arg_87_1.time_ - var_90_2) / var_90_3

				if arg_87_1.var_.characterEffect1041ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_2 + var_90_3 and arg_87_1.time_ < var_90_2 + var_90_3 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1041ui_story then
				arg_87_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_90_5 = 0
			local var_90_6 = 0.05

			if var_90_5 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_7 = arg_87_1:FormatText(StoryNameCfg[208].name)

				arg_87_1.leftNameTxt_.text = var_90_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_8 = arg_87_1:GetWordFromCfg(113131020)
				local var_90_9 = arg_87_1:FormatText(var_90_8.content)

				arg_87_1.text_.text = var_90_9

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_10 = 2
				local var_90_11 = utf8.len(var_90_9)
				local var_90_12 = var_90_10 <= 0 and var_90_6 or var_90_6 * (var_90_11 / var_90_10)

				if var_90_12 > 0 and var_90_6 < var_90_12 then
					arg_87_1.talkMaxDuration = var_90_12

					if var_90_12 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_12 + var_90_5
					end
				end

				arg_87_1.text_.text = var_90_9
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131020", "story_v_out_113131.awb") ~= 0 then
					local var_90_13 = manager.audio:GetVoiceLength("story_v_out_113131", "113131020", "story_v_out_113131.awb") / 1000

					if var_90_13 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_13 + var_90_5
					end

					if var_90_8.prefab_name ~= "" and arg_87_1.actors_[var_90_8.prefab_name] ~= nil then
						local var_90_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_8.prefab_name].transform, "story_v_out_113131", "113131020", "story_v_out_113131.awb")

						arg_87_1:RecordAudio("113131020", var_90_14)
						arg_87_1:RecordAudio("113131020", var_90_14)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_113131", "113131020", "story_v_out_113131.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_113131", "113131020", "story_v_out_113131.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_15 = math.max(var_90_6, arg_87_1.talkMaxDuration)

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_15 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_5) / var_90_15

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_5 + var_90_15 and arg_87_1.time_ < var_90_5 + var_90_15 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play113131021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 113131021
		arg_91_1.duration_ = 9

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play113131022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = true

				arg_91_1:SetGaussion(false)
			end

			local var_94_1 = 2

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_1 then
				local var_94_2 = (arg_91_1.time_ - var_94_0) / var_94_1
				local var_94_3 = Color.New(0, 0, 0)

				var_94_3.a = Mathf.Lerp(0, 1, var_94_2)
				arg_91_1.mask_.color = var_94_3
			end

			if arg_91_1.time_ >= var_94_0 + var_94_1 and arg_91_1.time_ < var_94_0 + var_94_1 + arg_94_0 then
				local var_94_4 = Color.New(0, 0, 0)

				var_94_4.a = 1
				arg_91_1.mask_.color = var_94_4
			end

			local var_94_5 = 2

			if var_94_5 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = true

				arg_91_1:SetGaussion(false)
			end

			local var_94_6 = 2

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_6 then
				local var_94_7 = (arg_91_1.time_ - var_94_5) / var_94_6
				local var_94_8 = Color.New(0, 0, 0)

				var_94_8.a = Mathf.Lerp(1, 0, var_94_7)
				arg_91_1.mask_.color = var_94_8
			end

			if arg_91_1.time_ >= var_94_5 + var_94_6 and arg_91_1.time_ < var_94_5 + var_94_6 + arg_94_0 then
				local var_94_9 = Color.New(0, 0, 0)
				local var_94_10 = 0

				arg_91_1.mask_.enabled = false
				var_94_9.a = var_94_10
				arg_91_1.mask_.color = var_94_9
			end

			local var_94_11 = "ST21"

			if arg_91_1.bgs_[var_94_11] == nil then
				local var_94_12 = Object.Instantiate(arg_91_1.paintGo_)

				var_94_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_94_11)
				var_94_12.name = var_94_11
				var_94_12.transform.parent = arg_91_1.stage_.transform
				var_94_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.bgs_[var_94_11] = var_94_12
			end

			local var_94_13 = 2

			if var_94_13 < arg_91_1.time_ and arg_91_1.time_ <= var_94_13 + arg_94_0 then
				local var_94_14 = manager.ui.mainCamera.transform.localPosition
				local var_94_15 = Vector3.New(0, 0, 10) + Vector3.New(var_94_14.x, var_94_14.y, 0)
				local var_94_16 = arg_91_1.bgs_.ST21

				var_94_16.transform.localPosition = var_94_15
				var_94_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_17 = var_94_16:GetComponent("SpriteRenderer")

				if var_94_17 and var_94_17.sprite then
					local var_94_18 = (var_94_16.transform.localPosition - var_94_14).z
					local var_94_19 = manager.ui.mainCameraCom_
					local var_94_20 = 2 * var_94_18 * Mathf.Tan(var_94_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_94_21 = var_94_20 * var_94_19.aspect
					local var_94_22 = var_94_17.sprite.bounds.size.x
					local var_94_23 = var_94_17.sprite.bounds.size.y
					local var_94_24 = var_94_21 / var_94_22
					local var_94_25 = var_94_20 / var_94_23
					local var_94_26 = var_94_25 < var_94_24 and var_94_24 or var_94_25

					var_94_16.transform.localScale = Vector3.New(var_94_26, var_94_26, 0)
				end

				for iter_94_0, iter_94_1 in pairs(arg_91_1.bgs_) do
					if iter_94_0 ~= "ST21" then
						iter_94_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_94_27 = arg_91_1.actors_["1041ui_story"].transform
			local var_94_28 = 1.966

			if var_94_28 < arg_91_1.time_ and arg_91_1.time_ <= var_94_28 + arg_94_0 then
				arg_91_1.var_.moveOldPos1041ui_story = var_94_27.localPosition
			end

			local var_94_29 = 0.001

			if var_94_28 <= arg_91_1.time_ and arg_91_1.time_ < var_94_28 + var_94_29 then
				local var_94_30 = (arg_91_1.time_ - var_94_28) / var_94_29
				local var_94_31 = Vector3.New(0, 100, 0)

				var_94_27.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1041ui_story, var_94_31, var_94_30)

				local var_94_32 = manager.ui.mainCamera.transform.position - var_94_27.position

				var_94_27.forward = Vector3.New(var_94_32.x, var_94_32.y, var_94_32.z)

				local var_94_33 = var_94_27.localEulerAngles

				var_94_33.z = 0
				var_94_33.x = 0
				var_94_27.localEulerAngles = var_94_33
			end

			if arg_91_1.time_ >= var_94_28 + var_94_29 and arg_91_1.time_ < var_94_28 + var_94_29 + arg_94_0 then
				var_94_27.localPosition = Vector3.New(0, 100, 0)

				local var_94_34 = manager.ui.mainCamera.transform.position - var_94_27.position

				var_94_27.forward = Vector3.New(var_94_34.x, var_94_34.y, var_94_34.z)

				local var_94_35 = var_94_27.localEulerAngles

				var_94_35.z = 0
				var_94_35.x = 0
				var_94_27.localEulerAngles = var_94_35
			end

			if arg_91_1.frameCnt_ <= 1 then
				arg_91_1.dialog_:SetActive(false)
			end

			local var_94_36 = 4
			local var_94_37 = 0.275

			if var_94_36 < arg_91_1.time_ and arg_91_1.time_ <= var_94_36 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				arg_91_1.dialog_:SetActive(true)

				arg_91_1.dialogCg_.alpha = 0

				local var_94_38 = LeanTween.value(arg_91_1.dialog_, 0, 1, 0.3)

				var_94_38:setOnUpdate(LuaHelper.FloatAction(function(arg_95_0)
					arg_91_1.dialogCg_.alpha = arg_95_0
				end))
				var_94_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_91_1.dialog_)
					var_94_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_91_1.duration_ = arg_91_1.duration_ + 0.3

				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_39 = arg_91_1:GetWordFromCfg(113131021)
				local var_94_40 = arg_91_1:FormatText(var_94_39.content)

				arg_91_1.text_.text = var_94_40

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_41 = 11
				local var_94_42 = utf8.len(var_94_40)
				local var_94_43 = var_94_41 <= 0 and var_94_37 or var_94_37 * (var_94_42 / var_94_41)

				if var_94_43 > 0 and var_94_37 < var_94_43 then
					arg_91_1.talkMaxDuration = var_94_43
					var_94_36 = var_94_36 + 0.3

					if var_94_43 + var_94_36 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_43 + var_94_36
					end
				end

				arg_91_1.text_.text = var_94_40
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_44 = var_94_36 + 0.3
			local var_94_45 = math.max(var_94_37, arg_91_1.talkMaxDuration)

			if var_94_44 <= arg_91_1.time_ and arg_91_1.time_ < var_94_44 + var_94_45 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_44) / var_94_45

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_44 + var_94_45 and arg_91_1.time_ < var_94_44 + var_94_45 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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

		arg_91_1:InitPlayNodeList()
	end,
	Play113131022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 113131022
		arg_97_1.duration_ = 3.37

		local var_97_0 = {
			ja = 3.366,
			ko = 2.466,
			zh = 2.666,
			en = 2.1
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
				arg_97_0:Play113131023(arg_97_1)
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

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[218].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1068")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(113131022)
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

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131022", "story_v_out_113131.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_113131", "113131022", "story_v_out_113131.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_113131", "113131022", "story_v_out_113131.awb")

						arg_97_1:RecordAudio("113131022", var_100_9)
						arg_97_1:RecordAudio("113131022", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_113131", "113131022", "story_v_out_113131.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_113131", "113131022", "story_v_out_113131.awb")
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
	Play113131023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 113131023
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play113131024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.675

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(113131023)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 28
				local var_104_5 = utf8.len(var_104_3)
				local var_104_6 = var_104_4 <= 0 and var_104_1 or var_104_1 * (var_104_5 / var_104_4)

				if var_104_6 > 0 and var_104_1 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_7 and arg_101_1.time_ < var_104_0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play113131024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 113131024
		arg_105_1.duration_ = 9.5

		local var_105_0 = {
			ja = 9.5,
			ko = 7,
			zh = 7.433,
			en = 5.333
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play113131025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = "1068ui_story"

			if arg_105_1.actors_[var_108_0] == nil then
				local var_108_1 = Asset.Load("Char/" .. "1068ui_story")

				if not isNil(var_108_1) then
					local var_108_2 = Object.Instantiate(Asset.Load("Char/" .. "1068ui_story"), arg_105_1.stage_.transform)

					var_108_2.name = var_108_0
					var_108_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_105_1.actors_[var_108_0] = var_108_2

					local var_108_3 = var_108_2:GetComponentInChildren(typeof(CharacterEffect))

					var_108_3.enabled = true

					local var_108_4 = GameObjectTools.GetOrAddComponent(var_108_2, typeof(DynamicBoneHelper))

					if var_108_4 then
						var_108_4:EnableDynamicBone(false)
					end

					arg_105_1:ShowWeapon(var_108_3.transform, false)

					arg_105_1.var_[var_108_0 .. "Animator"] = var_108_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_105_1.var_[var_108_0 .. "Animator"].applyRootMotion = true
					arg_105_1.var_[var_108_0 .. "LipSync"] = var_108_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_108_5 = arg_105_1.actors_["1068ui_story"].transform
			local var_108_6 = 0

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.var_.moveOldPos1068ui_story = var_108_5.localPosition
			end

			local var_108_7 = 0.001

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_7 then
				local var_108_8 = (arg_105_1.time_ - var_108_6) / var_108_7
				local var_108_9 = Vector3.New(-0.7, -0.95, -5.88)

				var_108_5.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1068ui_story, var_108_9, var_108_8)

				local var_108_10 = manager.ui.mainCamera.transform.position - var_108_5.position

				var_108_5.forward = Vector3.New(var_108_10.x, var_108_10.y, var_108_10.z)

				local var_108_11 = var_108_5.localEulerAngles

				var_108_11.z = 0
				var_108_11.x = 0
				var_108_5.localEulerAngles = var_108_11
			end

			if arg_105_1.time_ >= var_108_6 + var_108_7 and arg_105_1.time_ < var_108_6 + var_108_7 + arg_108_0 then
				var_108_5.localPosition = Vector3.New(-0.7, -0.95, -5.88)

				local var_108_12 = manager.ui.mainCamera.transform.position - var_108_5.position

				var_108_5.forward = Vector3.New(var_108_12.x, var_108_12.y, var_108_12.z)

				local var_108_13 = var_108_5.localEulerAngles

				var_108_13.z = 0
				var_108_13.x = 0
				var_108_5.localEulerAngles = var_108_13
			end

			local var_108_14 = 0

			if var_108_14 < arg_105_1.time_ and arg_105_1.time_ <= var_108_14 + arg_108_0 then
				arg_105_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			local var_108_15 = 0

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_108_16 = arg_105_1.actors_["1068ui_story"]
			local var_108_17 = 0

			if var_108_17 < arg_105_1.time_ and arg_105_1.time_ <= var_108_17 + arg_108_0 and not isNil(var_108_16) and arg_105_1.var_.characterEffect1068ui_story == nil then
				arg_105_1.var_.characterEffect1068ui_story = var_108_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_18 = 0.2

			if var_108_17 <= arg_105_1.time_ and arg_105_1.time_ < var_108_17 + var_108_18 and not isNil(var_108_16) then
				local var_108_19 = (arg_105_1.time_ - var_108_17) / var_108_18

				if arg_105_1.var_.characterEffect1068ui_story and not isNil(var_108_16) then
					arg_105_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_17 + var_108_18 and arg_105_1.time_ < var_108_17 + var_108_18 + arg_108_0 and not isNil(var_108_16) and arg_105_1.var_.characterEffect1068ui_story then
				arg_105_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_108_20 = 0
			local var_108_21 = 0.725

			if var_108_20 < arg_105_1.time_ and arg_105_1.time_ <= var_108_20 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_22 = arg_105_1:FormatText(StoryNameCfg[218].name)

				arg_105_1.leftNameTxt_.text = var_108_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_23 = arg_105_1:GetWordFromCfg(113131024)
				local var_108_24 = arg_105_1:FormatText(var_108_23.content)

				arg_105_1.text_.text = var_108_24

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_25 = 29
				local var_108_26 = utf8.len(var_108_24)
				local var_108_27 = var_108_25 <= 0 and var_108_21 or var_108_21 * (var_108_26 / var_108_25)

				if var_108_27 > 0 and var_108_21 < var_108_27 then
					arg_105_1.talkMaxDuration = var_108_27

					if var_108_27 + var_108_20 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_27 + var_108_20
					end
				end

				arg_105_1.text_.text = var_108_24
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131024", "story_v_out_113131.awb") ~= 0 then
					local var_108_28 = manager.audio:GetVoiceLength("story_v_out_113131", "113131024", "story_v_out_113131.awb") / 1000

					if var_108_28 + var_108_20 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_28 + var_108_20
					end

					if var_108_23.prefab_name ~= "" and arg_105_1.actors_[var_108_23.prefab_name] ~= nil then
						local var_108_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_23.prefab_name].transform, "story_v_out_113131", "113131024", "story_v_out_113131.awb")

						arg_105_1:RecordAudio("113131024", var_108_29)
						arg_105_1:RecordAudio("113131024", var_108_29)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_113131", "113131024", "story_v_out_113131.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_113131", "113131024", "story_v_out_113131.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_30 = math.max(var_108_21, arg_105_1.talkMaxDuration)

			if var_108_20 <= arg_105_1.time_ and arg_105_1.time_ < var_108_20 + var_108_30 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_20) / var_108_30

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_20 + var_108_30 and arg_105_1.time_ < var_108_20 + var_108_30 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play113131025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 113131025
		arg_109_1.duration_ = 8.23

		local var_109_0 = {
			ja = 8.233,
			ko = 6.433,
			zh = 6.5,
			en = 7.466
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play113131026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = "1067ui_story"

			if arg_109_1.actors_[var_112_0] == nil then
				local var_112_1 = Asset.Load("Char/" .. "1067ui_story")

				if not isNil(var_112_1) then
					local var_112_2 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_109_1.stage_.transform)

					var_112_2.name = var_112_0
					var_112_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_109_1.actors_[var_112_0] = var_112_2

					local var_112_3 = var_112_2:GetComponentInChildren(typeof(CharacterEffect))

					var_112_3.enabled = true

					local var_112_4 = GameObjectTools.GetOrAddComponent(var_112_2, typeof(DynamicBoneHelper))

					if var_112_4 then
						var_112_4:EnableDynamicBone(false)
					end

					arg_109_1:ShowWeapon(var_112_3.transform, false)

					arg_109_1.var_[var_112_0 .. "Animator"] = var_112_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_109_1.var_[var_112_0 .. "Animator"].applyRootMotion = true
					arg_109_1.var_[var_112_0 .. "LipSync"] = var_112_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_112_5 = arg_109_1.actors_["1067ui_story"].transform
			local var_112_6 = 0

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.var_.moveOldPos1067ui_story = var_112_5.localPosition
			end

			local var_112_7 = 0.001

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_7 then
				local var_112_8 = (arg_109_1.time_ - var_112_6) / var_112_7
				local var_112_9 = Vector3.New(0.7, -1.06, -6.2)

				var_112_5.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1067ui_story, var_112_9, var_112_8)

				local var_112_10 = manager.ui.mainCamera.transform.position - var_112_5.position

				var_112_5.forward = Vector3.New(var_112_10.x, var_112_10.y, var_112_10.z)

				local var_112_11 = var_112_5.localEulerAngles

				var_112_11.z = 0
				var_112_11.x = 0
				var_112_5.localEulerAngles = var_112_11
			end

			if arg_109_1.time_ >= var_112_6 + var_112_7 and arg_109_1.time_ < var_112_6 + var_112_7 + arg_112_0 then
				var_112_5.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_112_12 = manager.ui.mainCamera.transform.position - var_112_5.position

				var_112_5.forward = Vector3.New(var_112_12.x, var_112_12.y, var_112_12.z)

				local var_112_13 = var_112_5.localEulerAngles

				var_112_13.z = 0
				var_112_13.x = 0
				var_112_5.localEulerAngles = var_112_13
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			local var_112_15 = 0

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_112_16 = arg_109_1.actors_["1067ui_story"]
			local var_112_17 = 0

			if var_112_17 < arg_109_1.time_ and arg_109_1.time_ <= var_112_17 + arg_112_0 and not isNil(var_112_16) and arg_109_1.var_.characterEffect1067ui_story == nil then
				arg_109_1.var_.characterEffect1067ui_story = var_112_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_18 = 0.2

			if var_112_17 <= arg_109_1.time_ and arg_109_1.time_ < var_112_17 + var_112_18 and not isNil(var_112_16) then
				local var_112_19 = (arg_109_1.time_ - var_112_17) / var_112_18

				if arg_109_1.var_.characterEffect1067ui_story and not isNil(var_112_16) then
					arg_109_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_17 + var_112_18 and arg_109_1.time_ < var_112_17 + var_112_18 + arg_112_0 and not isNil(var_112_16) and arg_109_1.var_.characterEffect1067ui_story then
				arg_109_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_112_20 = arg_109_1.actors_["1068ui_story"]
			local var_112_21 = 0

			if var_112_21 < arg_109_1.time_ and arg_109_1.time_ <= var_112_21 + arg_112_0 and not isNil(var_112_20) and arg_109_1.var_.characterEffect1068ui_story == nil then
				arg_109_1.var_.characterEffect1068ui_story = var_112_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_22 = 0.2

			if var_112_21 <= arg_109_1.time_ and arg_109_1.time_ < var_112_21 + var_112_22 and not isNil(var_112_20) then
				local var_112_23 = (arg_109_1.time_ - var_112_21) / var_112_22

				if arg_109_1.var_.characterEffect1068ui_story and not isNil(var_112_20) then
					local var_112_24 = Mathf.Lerp(0, 0.5, var_112_23)

					arg_109_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1068ui_story.fillRatio = var_112_24
				end
			end

			if arg_109_1.time_ >= var_112_21 + var_112_22 and arg_109_1.time_ < var_112_21 + var_112_22 + arg_112_0 and not isNil(var_112_20) and arg_109_1.var_.characterEffect1068ui_story then
				local var_112_25 = 0.5

				arg_109_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1068ui_story.fillRatio = var_112_25
			end

			local var_112_26 = 0
			local var_112_27 = 0.725

			if var_112_26 < arg_109_1.time_ and arg_109_1.time_ <= var_112_26 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_28 = arg_109_1:FormatText(StoryNameCfg[206].name)

				arg_109_1.leftNameTxt_.text = var_112_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_29 = arg_109_1:GetWordFromCfg(113131025)
				local var_112_30 = arg_109_1:FormatText(var_112_29.content)

				arg_109_1.text_.text = var_112_30

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_31 = 29
				local var_112_32 = utf8.len(var_112_30)
				local var_112_33 = var_112_31 <= 0 and var_112_27 or var_112_27 * (var_112_32 / var_112_31)

				if var_112_33 > 0 and var_112_27 < var_112_33 then
					arg_109_1.talkMaxDuration = var_112_33

					if var_112_33 + var_112_26 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_33 + var_112_26
					end
				end

				arg_109_1.text_.text = var_112_30
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131025", "story_v_out_113131.awb") ~= 0 then
					local var_112_34 = manager.audio:GetVoiceLength("story_v_out_113131", "113131025", "story_v_out_113131.awb") / 1000

					if var_112_34 + var_112_26 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_34 + var_112_26
					end

					if var_112_29.prefab_name ~= "" and arg_109_1.actors_[var_112_29.prefab_name] ~= nil then
						local var_112_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_29.prefab_name].transform, "story_v_out_113131", "113131025", "story_v_out_113131.awb")

						arg_109_1:RecordAudio("113131025", var_112_35)
						arg_109_1:RecordAudio("113131025", var_112_35)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_113131", "113131025", "story_v_out_113131.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_113131", "113131025", "story_v_out_113131.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_36 = math.max(var_112_27, arg_109_1.talkMaxDuration)

			if var_112_26 <= arg_109_1.time_ and arg_109_1.time_ < var_112_26 + var_112_36 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_26) / var_112_36

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_26 + var_112_36 and arg_109_1.time_ < var_112_26 + var_112_36 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play113131026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 113131026
		arg_113_1.duration_ = 8.53

		local var_113_0 = {
			ja = 8.533,
			ko = 4.866,
			zh = 4.966,
			en = 5.5
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
				arg_113_0:Play113131027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1068ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1068ui_story == nil then
				arg_113_1.var_.characterEffect1068ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1068ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1068ui_story then
				arg_113_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_116_4 = arg_113_1.actors_["1067ui_story"]
			local var_116_5 = 0

			if var_116_5 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect1067ui_story == nil then
				arg_113_1.var_.characterEffect1067ui_story = var_116_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_6 = 0.2

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_6 and not isNil(var_116_4) then
				local var_116_7 = (arg_113_1.time_ - var_116_5) / var_116_6

				if arg_113_1.var_.characterEffect1067ui_story and not isNil(var_116_4) then
					local var_116_8 = Mathf.Lerp(0, 0.5, var_116_7)

					arg_113_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1067ui_story.fillRatio = var_116_8
				end
			end

			if arg_113_1.time_ >= var_116_5 + var_116_6 and arg_113_1.time_ < var_116_5 + var_116_6 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect1067ui_story then
				local var_116_9 = 0.5

				arg_113_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1067ui_story.fillRatio = var_116_9
			end

			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 then
				arg_113_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_116_11 = 0
			local var_116_12 = 0.55

			if var_116_11 < arg_113_1.time_ and arg_113_1.time_ <= var_116_11 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_13 = arg_113_1:FormatText(StoryNameCfg[218].name)

				arg_113_1.leftNameTxt_.text = var_116_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_14 = arg_113_1:GetWordFromCfg(113131026)
				local var_116_15 = arg_113_1:FormatText(var_116_14.content)

				arg_113_1.text_.text = var_116_15

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_16 = 20
				local var_116_17 = utf8.len(var_116_15)
				local var_116_18 = var_116_16 <= 0 and var_116_12 or var_116_12 * (var_116_17 / var_116_16)

				if var_116_18 > 0 and var_116_12 < var_116_18 then
					arg_113_1.talkMaxDuration = var_116_18

					if var_116_18 + var_116_11 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_18 + var_116_11
					end
				end

				arg_113_1.text_.text = var_116_15
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131026", "story_v_out_113131.awb") ~= 0 then
					local var_116_19 = manager.audio:GetVoiceLength("story_v_out_113131", "113131026", "story_v_out_113131.awb") / 1000

					if var_116_19 + var_116_11 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_19 + var_116_11
					end

					if var_116_14.prefab_name ~= "" and arg_113_1.actors_[var_116_14.prefab_name] ~= nil then
						local var_116_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_14.prefab_name].transform, "story_v_out_113131", "113131026", "story_v_out_113131.awb")

						arg_113_1:RecordAudio("113131026", var_116_20)
						arg_113_1:RecordAudio("113131026", var_116_20)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_113131", "113131026", "story_v_out_113131.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_113131", "113131026", "story_v_out_113131.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_21 = math.max(var_116_12, arg_113_1.talkMaxDuration)

			if var_116_11 <= arg_113_1.time_ and arg_113_1.time_ < var_116_11 + var_116_21 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_11) / var_116_21

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_11 + var_116_21 and arg_113_1.time_ < var_116_11 + var_116_21 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play113131027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 113131027
		arg_117_1.duration_ = 5.87

		local var_117_0 = {
			ja = 5.866,
			ko = 4.166,
			zh = 4.066,
			en = 5.4
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
				arg_117_0:Play113131028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1068ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1068ui_story == nil then
				arg_117_1.var_.characterEffect1068ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.2

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1068ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1068ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1068ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1068ui_story.fillRatio = var_120_5
			end

			local var_120_6 = arg_117_1.actors_["1067ui_story"]
			local var_120_7 = 0

			if var_120_7 < arg_117_1.time_ and arg_117_1.time_ <= var_120_7 + arg_120_0 and not isNil(var_120_6) and arg_117_1.var_.characterEffect1067ui_story == nil then
				arg_117_1.var_.characterEffect1067ui_story = var_120_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_8 = 0.2

			if var_120_7 <= arg_117_1.time_ and arg_117_1.time_ < var_120_7 + var_120_8 and not isNil(var_120_6) then
				local var_120_9 = (arg_117_1.time_ - var_120_7) / var_120_8

				if arg_117_1.var_.characterEffect1067ui_story and not isNil(var_120_6) then
					arg_117_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_7 + var_120_8 and arg_117_1.time_ < var_120_7 + var_120_8 + arg_120_0 and not isNil(var_120_6) and arg_117_1.var_.characterEffect1067ui_story then
				arg_117_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 then
				arg_117_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_2")
			end

			local var_120_11 = 0

			if var_120_11 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 then
				arg_117_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_120_12 = 0
			local var_120_13 = 0.45

			if var_120_12 < arg_117_1.time_ and arg_117_1.time_ <= var_120_12 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_14 = arg_117_1:FormatText(StoryNameCfg[206].name)

				arg_117_1.leftNameTxt_.text = var_120_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_15 = arg_117_1:GetWordFromCfg(113131027)
				local var_120_16 = arg_117_1:FormatText(var_120_15.content)

				arg_117_1.text_.text = var_120_16

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_17 = 18
				local var_120_18 = utf8.len(var_120_16)
				local var_120_19 = var_120_17 <= 0 and var_120_13 or var_120_13 * (var_120_18 / var_120_17)

				if var_120_19 > 0 and var_120_13 < var_120_19 then
					arg_117_1.talkMaxDuration = var_120_19

					if var_120_19 + var_120_12 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_19 + var_120_12
					end
				end

				arg_117_1.text_.text = var_120_16
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131027", "story_v_out_113131.awb") ~= 0 then
					local var_120_20 = manager.audio:GetVoiceLength("story_v_out_113131", "113131027", "story_v_out_113131.awb") / 1000

					if var_120_20 + var_120_12 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_20 + var_120_12
					end

					if var_120_15.prefab_name ~= "" and arg_117_1.actors_[var_120_15.prefab_name] ~= nil then
						local var_120_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_15.prefab_name].transform, "story_v_out_113131", "113131027", "story_v_out_113131.awb")

						arg_117_1:RecordAudio("113131027", var_120_21)
						arg_117_1:RecordAudio("113131027", var_120_21)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_113131", "113131027", "story_v_out_113131.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_113131", "113131027", "story_v_out_113131.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_22 = math.max(var_120_13, arg_117_1.talkMaxDuration)

			if var_120_12 <= arg_117_1.time_ and arg_117_1.time_ < var_120_12 + var_120_22 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_12) / var_120_22

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_12 + var_120_22 and arg_117_1.time_ < var_120_12 + var_120_22 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play113131028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 113131028
		arg_121_1.duration_ = 6.87

		local var_121_0 = {
			ja = 6.866,
			ko = 5.6,
			zh = 6.1,
			en = 5.033
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
				arg_121_0:Play113131029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1067ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1067ui_story == nil then
				arg_121_1.var_.characterEffect1067ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.2

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1067ui_story and not isNil(var_124_0) then
					local var_124_4 = Mathf.Lerp(0, 0.5, var_124_3)

					arg_121_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1067ui_story.fillRatio = var_124_4
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1067ui_story then
				local var_124_5 = 0.5

				arg_121_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1067ui_story.fillRatio = var_124_5
			end

			local var_124_6 = arg_121_1.actors_["1068ui_story"]
			local var_124_7 = 0

			if var_124_7 < arg_121_1.time_ and arg_121_1.time_ <= var_124_7 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect1068ui_story == nil then
				arg_121_1.var_.characterEffect1068ui_story = var_124_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_8 = 0.2

			if var_124_7 <= arg_121_1.time_ and arg_121_1.time_ < var_124_7 + var_124_8 and not isNil(var_124_6) then
				local var_124_9 = (arg_121_1.time_ - var_124_7) / var_124_8

				if arg_121_1.var_.characterEffect1068ui_story and not isNil(var_124_6) then
					arg_121_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_7 + var_124_8 and arg_121_1.time_ < var_124_7 + var_124_8 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect1068ui_story then
				arg_121_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 then
				arg_121_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action3_1")
			end

			local var_124_11 = 0

			if var_124_11 < arg_121_1.time_ and arg_121_1.time_ <= var_124_11 + arg_124_0 then
				arg_121_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_124_12 = 0
			local var_124_13 = 0.5

			if var_124_12 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_14 = arg_121_1:FormatText(StoryNameCfg[218].name)

				arg_121_1.leftNameTxt_.text = var_124_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_15 = arg_121_1:GetWordFromCfg(113131028)
				local var_124_16 = arg_121_1:FormatText(var_124_15.content)

				arg_121_1.text_.text = var_124_16

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_17 = 20
				local var_124_18 = utf8.len(var_124_16)
				local var_124_19 = var_124_17 <= 0 and var_124_13 or var_124_13 * (var_124_18 / var_124_17)

				if var_124_19 > 0 and var_124_13 < var_124_19 then
					arg_121_1.talkMaxDuration = var_124_19

					if var_124_19 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_19 + var_124_12
					end
				end

				arg_121_1.text_.text = var_124_16
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131028", "story_v_out_113131.awb") ~= 0 then
					local var_124_20 = manager.audio:GetVoiceLength("story_v_out_113131", "113131028", "story_v_out_113131.awb") / 1000

					if var_124_20 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_20 + var_124_12
					end

					if var_124_15.prefab_name ~= "" and arg_121_1.actors_[var_124_15.prefab_name] ~= nil then
						local var_124_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_15.prefab_name].transform, "story_v_out_113131", "113131028", "story_v_out_113131.awb")

						arg_121_1:RecordAudio("113131028", var_124_21)
						arg_121_1:RecordAudio("113131028", var_124_21)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_113131", "113131028", "story_v_out_113131.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_113131", "113131028", "story_v_out_113131.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_22 = math.max(var_124_13, arg_121_1.talkMaxDuration)

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_22 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_12) / var_124_22

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_12 + var_124_22 and arg_121_1.time_ < var_124_12 + var_124_22 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play113131029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 113131029
		arg_125_1.duration_ = 3.5

		local var_125_0 = {
			ja = 3.5,
			ko = 3.2,
			zh = 2.3,
			en = 2.733
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
				arg_125_0:Play113131030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1068ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1068ui_story == nil then
				arg_125_1.var_.characterEffect1068ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1068ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1068ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1068ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1068ui_story.fillRatio = var_128_5
			end

			local var_128_6 = arg_125_1.actors_["1067ui_story"]
			local var_128_7 = 0

			if var_128_7 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect1067ui_story == nil then
				arg_125_1.var_.characterEffect1067ui_story = var_128_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_8 = 0.2

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_8 and not isNil(var_128_6) then
				local var_128_9 = (arg_125_1.time_ - var_128_7) / var_128_8

				if arg_125_1.var_.characterEffect1067ui_story and not isNil(var_128_6) then
					arg_125_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_7 + var_128_8 and arg_125_1.time_ < var_128_7 + var_128_8 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect1067ui_story then
				arg_125_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_128_11 = 0
			local var_128_12 = 0.2

			if var_128_11 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_13 = arg_125_1:FormatText(StoryNameCfg[206].name)

				arg_125_1.leftNameTxt_.text = var_128_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_14 = arg_125_1:GetWordFromCfg(113131029)
				local var_128_15 = arg_125_1:FormatText(var_128_14.content)

				arg_125_1.text_.text = var_128_15

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_16 = 8
				local var_128_17 = utf8.len(var_128_15)
				local var_128_18 = var_128_16 <= 0 and var_128_12 or var_128_12 * (var_128_17 / var_128_16)

				if var_128_18 > 0 and var_128_12 < var_128_18 then
					arg_125_1.talkMaxDuration = var_128_18

					if var_128_18 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_18 + var_128_11
					end
				end

				arg_125_1.text_.text = var_128_15
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131029", "story_v_out_113131.awb") ~= 0 then
					local var_128_19 = manager.audio:GetVoiceLength("story_v_out_113131", "113131029", "story_v_out_113131.awb") / 1000

					if var_128_19 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_19 + var_128_11
					end

					if var_128_14.prefab_name ~= "" and arg_125_1.actors_[var_128_14.prefab_name] ~= nil then
						local var_128_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_14.prefab_name].transform, "story_v_out_113131", "113131029", "story_v_out_113131.awb")

						arg_125_1:RecordAudio("113131029", var_128_20)
						arg_125_1:RecordAudio("113131029", var_128_20)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_113131", "113131029", "story_v_out_113131.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_113131", "113131029", "story_v_out_113131.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_21 = math.max(var_128_12, arg_125_1.talkMaxDuration)

			if var_128_11 <= arg_125_1.time_ and arg_125_1.time_ < var_128_11 + var_128_21 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_11) / var_128_21

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_11 + var_128_21 and arg_125_1.time_ < var_128_11 + var_128_21 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play113131030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 113131030
		arg_129_1.duration_ = 10

		local var_129_0 = {
			ja = 10,
			ko = 7.733,
			zh = 6.7,
			en = 7.466
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
				arg_129_0:Play113131031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1068ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1068ui_story == nil then
				arg_129_1.var_.characterEffect1068ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.2

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1068ui_story and not isNil(var_132_0) then
					arg_129_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1068ui_story then
				arg_129_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_132_4 = 0

			if var_132_4 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action3_2")
			end

			local var_132_5 = 0

			if var_132_5 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_132_6 = arg_129_1.actors_["1067ui_story"]
			local var_132_7 = 0

			if var_132_7 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 and not isNil(var_132_6) and arg_129_1.var_.characterEffect1067ui_story == nil then
				arg_129_1.var_.characterEffect1067ui_story = var_132_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_8 = 0.2

			if var_132_7 <= arg_129_1.time_ and arg_129_1.time_ < var_132_7 + var_132_8 and not isNil(var_132_6) then
				local var_132_9 = (arg_129_1.time_ - var_132_7) / var_132_8

				if arg_129_1.var_.characterEffect1067ui_story and not isNil(var_132_6) then
					local var_132_10 = Mathf.Lerp(0, 0.5, var_132_9)

					arg_129_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1067ui_story.fillRatio = var_132_10
				end
			end

			if arg_129_1.time_ >= var_132_7 + var_132_8 and arg_129_1.time_ < var_132_7 + var_132_8 + arg_132_0 and not isNil(var_132_6) and arg_129_1.var_.characterEffect1067ui_story then
				local var_132_11 = 0.5

				arg_129_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1067ui_story.fillRatio = var_132_11
			end

			local var_132_12 = 0
			local var_132_13 = 0.75

			if var_132_12 < arg_129_1.time_ and arg_129_1.time_ <= var_132_12 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_14 = arg_129_1:FormatText(StoryNameCfg[218].name)

				arg_129_1.leftNameTxt_.text = var_132_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_15 = arg_129_1:GetWordFromCfg(113131030)
				local var_132_16 = arg_129_1:FormatText(var_132_15.content)

				arg_129_1.text_.text = var_132_16

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_17 = 30
				local var_132_18 = utf8.len(var_132_16)
				local var_132_19 = var_132_17 <= 0 and var_132_13 or var_132_13 * (var_132_18 / var_132_17)

				if var_132_19 > 0 and var_132_13 < var_132_19 then
					arg_129_1.talkMaxDuration = var_132_19

					if var_132_19 + var_132_12 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_19 + var_132_12
					end
				end

				arg_129_1.text_.text = var_132_16
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131030", "story_v_out_113131.awb") ~= 0 then
					local var_132_20 = manager.audio:GetVoiceLength("story_v_out_113131", "113131030", "story_v_out_113131.awb") / 1000

					if var_132_20 + var_132_12 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_20 + var_132_12
					end

					if var_132_15.prefab_name ~= "" and arg_129_1.actors_[var_132_15.prefab_name] ~= nil then
						local var_132_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_15.prefab_name].transform, "story_v_out_113131", "113131030", "story_v_out_113131.awb")

						arg_129_1:RecordAudio("113131030", var_132_21)
						arg_129_1:RecordAudio("113131030", var_132_21)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_113131", "113131030", "story_v_out_113131.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_113131", "113131030", "story_v_out_113131.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_22 = math.max(var_132_13, arg_129_1.talkMaxDuration)

			if var_132_12 <= arg_129_1.time_ and arg_129_1.time_ < var_132_12 + var_132_22 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_12) / var_132_22

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_12 + var_132_22 and arg_129_1.time_ < var_132_12 + var_132_22 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play113131031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 113131031
		arg_133_1.duration_ = 3.3

		local var_133_0 = {
			ja = 2.066,
			ko = 2.133,
			zh = 3.3,
			en = 2.733
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play113131032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1067ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1067ui_story == nil then
				arg_133_1.var_.characterEffect1067ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1067ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1067ui_story then
				arg_133_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_136_4 = 0

			if var_136_4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_1")
			end

			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_136_6 = arg_133_1.actors_["1068ui_story"]
			local var_136_7 = 0

			if var_136_7 < arg_133_1.time_ and arg_133_1.time_ <= var_136_7 + arg_136_0 and not isNil(var_136_6) and arg_133_1.var_.characterEffect1068ui_story == nil then
				arg_133_1.var_.characterEffect1068ui_story = var_136_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_8 = 0.2

			if var_136_7 <= arg_133_1.time_ and arg_133_1.time_ < var_136_7 + var_136_8 and not isNil(var_136_6) then
				local var_136_9 = (arg_133_1.time_ - var_136_7) / var_136_8

				if arg_133_1.var_.characterEffect1068ui_story and not isNil(var_136_6) then
					local var_136_10 = Mathf.Lerp(0, 0.5, var_136_9)

					arg_133_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1068ui_story.fillRatio = var_136_10
				end
			end

			if arg_133_1.time_ >= var_136_7 + var_136_8 and arg_133_1.time_ < var_136_7 + var_136_8 + arg_136_0 and not isNil(var_136_6) and arg_133_1.var_.characterEffect1068ui_story then
				local var_136_11 = 0.5

				arg_133_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1068ui_story.fillRatio = var_136_11
			end

			local var_136_12 = 0
			local var_136_13 = 0.15

			if var_136_12 < arg_133_1.time_ and arg_133_1.time_ <= var_136_12 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_14 = arg_133_1:FormatText(StoryNameCfg[206].name)

				arg_133_1.leftNameTxt_.text = var_136_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_15 = arg_133_1:GetWordFromCfg(113131031)
				local var_136_16 = arg_133_1:FormatText(var_136_15.content)

				arg_133_1.text_.text = var_136_16

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_17 = 6
				local var_136_18 = utf8.len(var_136_16)
				local var_136_19 = var_136_17 <= 0 and var_136_13 or var_136_13 * (var_136_18 / var_136_17)

				if var_136_19 > 0 and var_136_13 < var_136_19 then
					arg_133_1.talkMaxDuration = var_136_19

					if var_136_19 + var_136_12 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_19 + var_136_12
					end
				end

				arg_133_1.text_.text = var_136_16
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131031", "story_v_out_113131.awb") ~= 0 then
					local var_136_20 = manager.audio:GetVoiceLength("story_v_out_113131", "113131031", "story_v_out_113131.awb") / 1000

					if var_136_20 + var_136_12 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_20 + var_136_12
					end

					if var_136_15.prefab_name ~= "" and arg_133_1.actors_[var_136_15.prefab_name] ~= nil then
						local var_136_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_15.prefab_name].transform, "story_v_out_113131", "113131031", "story_v_out_113131.awb")

						arg_133_1:RecordAudio("113131031", var_136_21)
						arg_133_1:RecordAudio("113131031", var_136_21)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_113131", "113131031", "story_v_out_113131.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_113131", "113131031", "story_v_out_113131.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_22 = math.max(var_136_13, arg_133_1.talkMaxDuration)

			if var_136_12 <= arg_133_1.time_ and arg_133_1.time_ < var_136_12 + var_136_22 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_12) / var_136_22

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_12 + var_136_22 and arg_133_1.time_ < var_136_12 + var_136_22 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play113131032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 113131032
		arg_137_1.duration_ = 4.27

		local var_137_0 = {
			ja = 3.7,
			ko = 4.1,
			zh = 4.266,
			en = 2.8
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
				arg_137_0:Play113131033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1067ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1067ui_story == nil then
				arg_137_1.var_.characterEffect1067ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1067ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1067ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1067ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1067ui_story.fillRatio = var_140_5
			end

			local var_140_6 = 0

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_2")
			end

			local var_140_7 = 0

			if var_140_7 < arg_137_1.time_ and arg_137_1.time_ <= var_140_7 + arg_140_0 then
				arg_137_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_140_8 = 0
			local var_140_9 = 0.475

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_10 = arg_137_1:FormatText(StoryNameCfg[205].name)

				arg_137_1.leftNameTxt_.text = var_140_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_11 = arg_137_1:GetWordFromCfg(113131032)
				local var_140_12 = arg_137_1:FormatText(var_140_11.content)

				arg_137_1.text_.text = var_140_12

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_13 = 19
				local var_140_14 = utf8.len(var_140_12)
				local var_140_15 = var_140_13 <= 0 and var_140_9 or var_140_9 * (var_140_14 / var_140_13)

				if var_140_15 > 0 and var_140_9 < var_140_15 then
					arg_137_1.talkMaxDuration = var_140_15

					if var_140_15 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_15 + var_140_8
					end
				end

				arg_137_1.text_.text = var_140_12
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131032", "story_v_out_113131.awb") ~= 0 then
					local var_140_16 = manager.audio:GetVoiceLength("story_v_out_113131", "113131032", "story_v_out_113131.awb") / 1000

					if var_140_16 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_16 + var_140_8
					end

					if var_140_11.prefab_name ~= "" and arg_137_1.actors_[var_140_11.prefab_name] ~= nil then
						local var_140_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_11.prefab_name].transform, "story_v_out_113131", "113131032", "story_v_out_113131.awb")

						arg_137_1:RecordAudio("113131032", var_140_17)
						arg_137_1:RecordAudio("113131032", var_140_17)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_113131", "113131032", "story_v_out_113131.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_113131", "113131032", "story_v_out_113131.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_18 = math.max(var_140_9, arg_137_1.talkMaxDuration)

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_18 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_8) / var_140_18

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_8 + var_140_18 and arg_137_1.time_ < var_140_8 + var_140_18 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play113131033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 113131033
		arg_141_1.duration_ = 4.93

		local var_141_0 = {
			ja = 3.2,
			ko = 4.933,
			zh = 4.466,
			en = 3.033
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
				arg_141_0:Play113131034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1068ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1068ui_story == nil then
				arg_141_1.var_.characterEffect1068ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect1068ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1068ui_story then
				arg_141_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_144_4 = 0

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_144_5 = 0
			local var_144_6 = 0.45

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_7 = arg_141_1:FormatText(StoryNameCfg[218].name)

				arg_141_1.leftNameTxt_.text = var_144_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_8 = arg_141_1:GetWordFromCfg(113131033)
				local var_144_9 = arg_141_1:FormatText(var_144_8.content)

				arg_141_1.text_.text = var_144_9

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 18
				local var_144_11 = utf8.len(var_144_9)
				local var_144_12 = var_144_10 <= 0 and var_144_6 or var_144_6 * (var_144_11 / var_144_10)

				if var_144_12 > 0 and var_144_6 < var_144_12 then
					arg_141_1.talkMaxDuration = var_144_12

					if var_144_12 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_12 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_9
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131033", "story_v_out_113131.awb") ~= 0 then
					local var_144_13 = manager.audio:GetVoiceLength("story_v_out_113131", "113131033", "story_v_out_113131.awb") / 1000

					if var_144_13 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_5
					end

					if var_144_8.prefab_name ~= "" and arg_141_1.actors_[var_144_8.prefab_name] ~= nil then
						local var_144_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_8.prefab_name].transform, "story_v_out_113131", "113131033", "story_v_out_113131.awb")

						arg_141_1:RecordAudio("113131033", var_144_14)
						arg_141_1:RecordAudio("113131033", var_144_14)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_113131", "113131033", "story_v_out_113131.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_113131", "113131033", "story_v_out_113131.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_15 = math.max(var_144_6, arg_141_1.talkMaxDuration)

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_15 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_5) / var_144_15

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_5 + var_144_15 and arg_141_1.time_ < var_144_5 + var_144_15 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play113131034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 113131034
		arg_145_1.duration_ = 8.97

		local var_145_0 = {
			ja = 8.966,
			ko = 5.9,
			zh = 5.566,
			en = 5.733
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
				arg_145_0:Play113131035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1067ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1067ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, 100, 0)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1067ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, 100, 0)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = "1042ui_story"

			if arg_145_1.actors_[var_148_9] == nil then
				local var_148_10 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_148_10) then
					local var_148_11 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_145_1.stage_.transform)

					var_148_11.name = var_148_9
					var_148_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_145_1.actors_[var_148_9] = var_148_11

					local var_148_12 = var_148_11:GetComponentInChildren(typeof(CharacterEffect))

					var_148_12.enabled = true

					local var_148_13 = GameObjectTools.GetOrAddComponent(var_148_11, typeof(DynamicBoneHelper))

					if var_148_13 then
						var_148_13:EnableDynamicBone(false)
					end

					arg_145_1:ShowWeapon(var_148_12.transform, false)

					arg_145_1.var_[var_148_9 .. "Animator"] = var_148_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_145_1.var_[var_148_9 .. "Animator"].applyRootMotion = true
					arg_145_1.var_[var_148_9 .. "LipSync"] = var_148_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_148_14 = arg_145_1.actors_["1042ui_story"].transform
			local var_148_15 = 0

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.var_.moveOldPos1042ui_story = var_148_14.localPosition
			end

			local var_148_16 = 0.001

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_16 then
				local var_148_17 = (arg_145_1.time_ - var_148_15) / var_148_16
				local var_148_18 = Vector3.New(0.7, -1.06, -6.2)

				var_148_14.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1042ui_story, var_148_18, var_148_17)

				local var_148_19 = manager.ui.mainCamera.transform.position - var_148_14.position

				var_148_14.forward = Vector3.New(var_148_19.x, var_148_19.y, var_148_19.z)

				local var_148_20 = var_148_14.localEulerAngles

				var_148_20.z = 0
				var_148_20.x = 0
				var_148_14.localEulerAngles = var_148_20
			end

			if arg_145_1.time_ >= var_148_15 + var_148_16 and arg_145_1.time_ < var_148_15 + var_148_16 + arg_148_0 then
				var_148_14.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_148_21 = manager.ui.mainCamera.transform.position - var_148_14.position

				var_148_14.forward = Vector3.New(var_148_21.x, var_148_21.y, var_148_21.z)

				local var_148_22 = var_148_14.localEulerAngles

				var_148_22.z = 0
				var_148_22.x = 0
				var_148_14.localEulerAngles = var_148_22
			end

			local var_148_23 = 0

			if var_148_23 < arg_145_1.time_ and arg_145_1.time_ <= var_148_23 + arg_148_0 then
				arg_145_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_148_24 = 0

			if var_148_24 < arg_145_1.time_ and arg_145_1.time_ <= var_148_24 + arg_148_0 then
				arg_145_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_148_25 = arg_145_1.actors_["1042ui_story"]
			local var_148_26 = 0

			if var_148_26 < arg_145_1.time_ and arg_145_1.time_ <= var_148_26 + arg_148_0 and not isNil(var_148_25) and arg_145_1.var_.characterEffect1042ui_story == nil then
				arg_145_1.var_.characterEffect1042ui_story = var_148_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_27 = 0.2

			if var_148_26 <= arg_145_1.time_ and arg_145_1.time_ < var_148_26 + var_148_27 and not isNil(var_148_25) then
				local var_148_28 = (arg_145_1.time_ - var_148_26) / var_148_27

				if arg_145_1.var_.characterEffect1042ui_story and not isNil(var_148_25) then
					arg_145_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_26 + var_148_27 and arg_145_1.time_ < var_148_26 + var_148_27 + arg_148_0 and not isNil(var_148_25) and arg_145_1.var_.characterEffect1042ui_story then
				arg_145_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_148_29 = arg_145_1.actors_["1068ui_story"]
			local var_148_30 = 0

			if var_148_30 < arg_145_1.time_ and arg_145_1.time_ <= var_148_30 + arg_148_0 and not isNil(var_148_29) and arg_145_1.var_.characterEffect1068ui_story == nil then
				arg_145_1.var_.characterEffect1068ui_story = var_148_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_31 = 0.2

			if var_148_30 <= arg_145_1.time_ and arg_145_1.time_ < var_148_30 + var_148_31 and not isNil(var_148_29) then
				local var_148_32 = (arg_145_1.time_ - var_148_30) / var_148_31

				if arg_145_1.var_.characterEffect1068ui_story and not isNil(var_148_29) then
					local var_148_33 = Mathf.Lerp(0, 0.5, var_148_32)

					arg_145_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1068ui_story.fillRatio = var_148_33
				end
			end

			if arg_145_1.time_ >= var_148_30 + var_148_31 and arg_145_1.time_ < var_148_30 + var_148_31 + arg_148_0 and not isNil(var_148_29) and arg_145_1.var_.characterEffect1068ui_story then
				local var_148_34 = 0.5

				arg_145_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1068ui_story.fillRatio = var_148_34
			end

			local var_148_35 = 0
			local var_148_36 = 0.65

			if var_148_35 < arg_145_1.time_ and arg_145_1.time_ <= var_148_35 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_37 = arg_145_1:FormatText(StoryNameCfg[205].name)

				arg_145_1.leftNameTxt_.text = var_148_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_38 = arg_145_1:GetWordFromCfg(113131034)
				local var_148_39 = arg_145_1:FormatText(var_148_38.content)

				arg_145_1.text_.text = var_148_39

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_40 = 26
				local var_148_41 = utf8.len(var_148_39)
				local var_148_42 = var_148_40 <= 0 and var_148_36 or var_148_36 * (var_148_41 / var_148_40)

				if var_148_42 > 0 and var_148_36 < var_148_42 then
					arg_145_1.talkMaxDuration = var_148_42

					if var_148_42 + var_148_35 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_42 + var_148_35
					end
				end

				arg_145_1.text_.text = var_148_39
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131034", "story_v_out_113131.awb") ~= 0 then
					local var_148_43 = manager.audio:GetVoiceLength("story_v_out_113131", "113131034", "story_v_out_113131.awb") / 1000

					if var_148_43 + var_148_35 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_43 + var_148_35
					end

					if var_148_38.prefab_name ~= "" and arg_145_1.actors_[var_148_38.prefab_name] ~= nil then
						local var_148_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_38.prefab_name].transform, "story_v_out_113131", "113131034", "story_v_out_113131.awb")

						arg_145_1:RecordAudio("113131034", var_148_44)
						arg_145_1:RecordAudio("113131034", var_148_44)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_113131", "113131034", "story_v_out_113131.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_113131", "113131034", "story_v_out_113131.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_45 = math.max(var_148_36, arg_145_1.talkMaxDuration)

			if var_148_35 <= arg_145_1.time_ and arg_145_1.time_ < var_148_35 + var_148_45 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_35) / var_148_45

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_35 + var_148_45 and arg_145_1.time_ < var_148_35 + var_148_45 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play113131035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 113131035
		arg_149_1.duration_ = 16.1

		local var_149_0 = {
			ja = 16.1,
			ko = 10.1,
			zh = 12,
			en = 13.666
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play113131036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action6_1")
			end

			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_152_2 = arg_149_1.actors_["1042ui_story"]
			local var_152_3 = 0

			if var_152_3 < arg_149_1.time_ and arg_149_1.time_ <= var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1042ui_story == nil then
				arg_149_1.var_.characterEffect1042ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_4 = 0.2

			if var_152_3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_3 + var_152_4 and not isNil(var_152_2) then
				local var_152_5 = (arg_149_1.time_ - var_152_3) / var_152_4

				if arg_149_1.var_.characterEffect1042ui_story and not isNil(var_152_2) then
					local var_152_6 = Mathf.Lerp(0, 0.5, var_152_5)

					arg_149_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1042ui_story.fillRatio = var_152_6
				end
			end

			if arg_149_1.time_ >= var_152_3 + var_152_4 and arg_149_1.time_ < var_152_3 + var_152_4 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1042ui_story then
				local var_152_7 = 0.5

				arg_149_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1042ui_story.fillRatio = var_152_7
			end

			local var_152_8 = arg_149_1.actors_["1068ui_story"]
			local var_152_9 = 0

			if var_152_9 < arg_149_1.time_ and arg_149_1.time_ <= var_152_9 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.characterEffect1068ui_story == nil then
				arg_149_1.var_.characterEffect1068ui_story = var_152_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_10 = 0.2

			if var_152_9 <= arg_149_1.time_ and arg_149_1.time_ < var_152_9 + var_152_10 and not isNil(var_152_8) then
				local var_152_11 = (arg_149_1.time_ - var_152_9) / var_152_10

				if arg_149_1.var_.characterEffect1068ui_story and not isNil(var_152_8) then
					arg_149_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_9 + var_152_10 and arg_149_1.time_ < var_152_9 + var_152_10 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.characterEffect1068ui_story then
				arg_149_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_152_12 = 0
			local var_152_13 = 1.4

			if var_152_12 < arg_149_1.time_ and arg_149_1.time_ <= var_152_12 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_14 = arg_149_1:FormatText(StoryNameCfg[218].name)

				arg_149_1.leftNameTxt_.text = var_152_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_15 = arg_149_1:GetWordFromCfg(113131035)
				local var_152_16 = arg_149_1:FormatText(var_152_15.content)

				arg_149_1.text_.text = var_152_16

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_17 = 56
				local var_152_18 = utf8.len(var_152_16)
				local var_152_19 = var_152_17 <= 0 and var_152_13 or var_152_13 * (var_152_18 / var_152_17)

				if var_152_19 > 0 and var_152_13 < var_152_19 then
					arg_149_1.talkMaxDuration = var_152_19

					if var_152_19 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_19 + var_152_12
					end
				end

				arg_149_1.text_.text = var_152_16
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131035", "story_v_out_113131.awb") ~= 0 then
					local var_152_20 = manager.audio:GetVoiceLength("story_v_out_113131", "113131035", "story_v_out_113131.awb") / 1000

					if var_152_20 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_20 + var_152_12
					end

					if var_152_15.prefab_name ~= "" and arg_149_1.actors_[var_152_15.prefab_name] ~= nil then
						local var_152_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_15.prefab_name].transform, "story_v_out_113131", "113131035", "story_v_out_113131.awb")

						arg_149_1:RecordAudio("113131035", var_152_21)
						arg_149_1:RecordAudio("113131035", var_152_21)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_113131", "113131035", "story_v_out_113131.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_113131", "113131035", "story_v_out_113131.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_22 = math.max(var_152_13, arg_149_1.talkMaxDuration)

			if var_152_12 <= arg_149_1.time_ and arg_149_1.time_ < var_152_12 + var_152_22 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_12) / var_152_22

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_12 + var_152_22 and arg_149_1.time_ < var_152_12 + var_152_22 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play113131036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 113131036
		arg_153_1.duration_ = 5.97

		local var_153_0 = {
			ja = 5.966,
			ko = 3.366,
			zh = 4.4,
			en = 4
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
				arg_153_0:Play113131037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1068ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1068ui_story == nil then
				arg_153_1.var_.characterEffect1068ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect1068ui_story and not isNil(var_156_0) then
					local var_156_4 = Mathf.Lerp(0, 0.5, var_156_3)

					arg_153_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1068ui_story.fillRatio = var_156_4
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1068ui_story then
				local var_156_5 = 0.5

				arg_153_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1068ui_story.fillRatio = var_156_5
			end

			local var_156_6 = 0
			local var_156_7 = 0.475

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_8 = arg_153_1:FormatText(StoryNameCfg[206].name)

				arg_153_1.leftNameTxt_.text = var_156_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1067")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_9 = arg_153_1:GetWordFromCfg(113131036)
				local var_156_10 = arg_153_1:FormatText(var_156_9.content)

				arg_153_1.text_.text = var_156_10

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 19
				local var_156_12 = utf8.len(var_156_10)
				local var_156_13 = var_156_11 <= 0 and var_156_7 or var_156_7 * (var_156_12 / var_156_11)

				if var_156_13 > 0 and var_156_7 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_10
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131036", "story_v_out_113131.awb") ~= 0 then
					local var_156_14 = manager.audio:GetVoiceLength("story_v_out_113131", "113131036", "story_v_out_113131.awb") / 1000

					if var_156_14 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_14 + var_156_6
					end

					if var_156_9.prefab_name ~= "" and arg_153_1.actors_[var_156_9.prefab_name] ~= nil then
						local var_156_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_9.prefab_name].transform, "story_v_out_113131", "113131036", "story_v_out_113131.awb")

						arg_153_1:RecordAudio("113131036", var_156_15)
						arg_153_1:RecordAudio("113131036", var_156_15)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_113131", "113131036", "story_v_out_113131.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_113131", "113131036", "story_v_out_113131.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_16 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_16 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_16

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_16 and arg_153_1.time_ < var_156_6 + var_156_16 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play113131037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 113131037
		arg_157_1.duration_ = 6.5

		local var_157_0 = {
			ja = 6.5,
			ko = 5.7,
			zh = 6.166,
			en = 6.5
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
				arg_157_0:Play113131038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_160_2 = arg_157_1.actors_["1042ui_story"]
			local var_160_3 = 0

			if var_160_3 < arg_157_1.time_ and arg_157_1.time_ <= var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect1042ui_story == nil then
				arg_157_1.var_.characterEffect1042ui_story = var_160_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_4 = 0.2

			if var_160_3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_3 + var_160_4 and not isNil(var_160_2) then
				local var_160_5 = (arg_157_1.time_ - var_160_3) / var_160_4

				if arg_157_1.var_.characterEffect1042ui_story and not isNil(var_160_2) then
					arg_157_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_3 + var_160_4 and arg_157_1.time_ < var_160_3 + var_160_4 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect1042ui_story then
				arg_157_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_160_6 = arg_157_1.actors_["1067ui_story"]
			local var_160_7 = 0

			if var_160_7 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect1067ui_story == nil then
				arg_157_1.var_.characterEffect1067ui_story = var_160_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_8 = 0.2

			if var_160_7 <= arg_157_1.time_ and arg_157_1.time_ < var_160_7 + var_160_8 and not isNil(var_160_6) then
				local var_160_9 = (arg_157_1.time_ - var_160_7) / var_160_8

				if arg_157_1.var_.characterEffect1067ui_story and not isNil(var_160_6) then
					local var_160_10 = Mathf.Lerp(0, 0.5, var_160_9)

					arg_157_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1067ui_story.fillRatio = var_160_10
				end
			end

			if arg_157_1.time_ >= var_160_7 + var_160_8 and arg_157_1.time_ < var_160_7 + var_160_8 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect1067ui_story then
				local var_160_11 = 0.5

				arg_157_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1067ui_story.fillRatio = var_160_11
			end

			local var_160_12 = 0
			local var_160_13 = 0.675

			if var_160_12 < arg_157_1.time_ and arg_157_1.time_ <= var_160_12 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_14 = arg_157_1:FormatText(StoryNameCfg[205].name)

				arg_157_1.leftNameTxt_.text = var_160_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_15 = arg_157_1:GetWordFromCfg(113131037)
				local var_160_16 = arg_157_1:FormatText(var_160_15.content)

				arg_157_1.text_.text = var_160_16

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_17 = 27
				local var_160_18 = utf8.len(var_160_16)
				local var_160_19 = var_160_17 <= 0 and var_160_13 or var_160_13 * (var_160_18 / var_160_17)

				if var_160_19 > 0 and var_160_13 < var_160_19 then
					arg_157_1.talkMaxDuration = var_160_19

					if var_160_19 + var_160_12 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_19 + var_160_12
					end
				end

				arg_157_1.text_.text = var_160_16
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131037", "story_v_out_113131.awb") ~= 0 then
					local var_160_20 = manager.audio:GetVoiceLength("story_v_out_113131", "113131037", "story_v_out_113131.awb") / 1000

					if var_160_20 + var_160_12 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_20 + var_160_12
					end

					if var_160_15.prefab_name ~= "" and arg_157_1.actors_[var_160_15.prefab_name] ~= nil then
						local var_160_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_15.prefab_name].transform, "story_v_out_113131", "113131037", "story_v_out_113131.awb")

						arg_157_1:RecordAudio("113131037", var_160_21)
						arg_157_1:RecordAudio("113131037", var_160_21)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_113131", "113131037", "story_v_out_113131.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_113131", "113131037", "story_v_out_113131.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_22 = math.max(var_160_13, arg_157_1.talkMaxDuration)

			if var_160_12 <= arg_157_1.time_ and arg_157_1.time_ < var_160_12 + var_160_22 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_12) / var_160_22

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_12 + var_160_22 and arg_157_1.time_ < var_160_12 + var_160_22 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play113131038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 113131038
		arg_161_1.duration_ = 9.43

		local var_161_0 = {
			ja = 9.433,
			ko = 5.066,
			zh = 4.533,
			en = 4.533
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
			arg_161_1.auto_ = false
		end

		function arg_161_1.playNext_(arg_163_0)
			arg_161_1.onStoryFinished_()
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_164_1 = arg_161_1.actors_["1042ui_story"]
			local var_164_2 = 0

			if var_164_2 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1042ui_story == nil then
				arg_161_1.var_.characterEffect1042ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_3 = 0.2

			if var_164_2 <= arg_161_1.time_ and arg_161_1.time_ < var_164_2 + var_164_3 and not isNil(var_164_1) then
				local var_164_4 = (arg_161_1.time_ - var_164_2) / var_164_3

				if arg_161_1.var_.characterEffect1042ui_story and not isNil(var_164_1) then
					local var_164_5 = Mathf.Lerp(0, 0.5, var_164_4)

					arg_161_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1042ui_story.fillRatio = var_164_5
				end
			end

			if arg_161_1.time_ >= var_164_2 + var_164_3 and arg_161_1.time_ < var_164_2 + var_164_3 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1042ui_story then
				local var_164_6 = 0.5

				arg_161_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1042ui_story.fillRatio = var_164_6
			end

			local var_164_7 = arg_161_1.actors_["1068ui_story"]
			local var_164_8 = 0

			if var_164_8 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 and not isNil(var_164_7) and arg_161_1.var_.characterEffect1068ui_story == nil then
				arg_161_1.var_.characterEffect1068ui_story = var_164_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_9 = 0.2

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_9 and not isNil(var_164_7) then
				local var_164_10 = (arg_161_1.time_ - var_164_8) / var_164_9

				if arg_161_1.var_.characterEffect1068ui_story and not isNil(var_164_7) then
					arg_161_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_8 + var_164_9 and arg_161_1.time_ < var_164_8 + var_164_9 + arg_164_0 and not isNil(var_164_7) and arg_161_1.var_.characterEffect1068ui_story then
				arg_161_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_164_11 = arg_161_1.actors_["1068ui_story"].transform
			local var_164_12 = 0

			if var_164_12 < arg_161_1.time_ and arg_161_1.time_ <= var_164_12 + arg_164_0 then
				arg_161_1.var_.moveOldPos1068ui_story = var_164_11.localPosition
			end

			local var_164_13 = 0.001

			if var_164_12 <= arg_161_1.time_ and arg_161_1.time_ < var_164_12 + var_164_13 then
				local var_164_14 = (arg_161_1.time_ - var_164_12) / var_164_13
				local var_164_15 = Vector3.New(-0.7, -0.95, -5.88)

				var_164_11.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1068ui_story, var_164_15, var_164_14)

				local var_164_16 = manager.ui.mainCamera.transform.position - var_164_11.position

				var_164_11.forward = Vector3.New(var_164_16.x, var_164_16.y, var_164_16.z)

				local var_164_17 = var_164_11.localEulerAngles

				var_164_17.z = 0
				var_164_17.x = 0
				var_164_11.localEulerAngles = var_164_17
			end

			if arg_161_1.time_ >= var_164_12 + var_164_13 and arg_161_1.time_ < var_164_12 + var_164_13 + arg_164_0 then
				var_164_11.localPosition = Vector3.New(-0.7, -0.95, -5.88)

				local var_164_18 = manager.ui.mainCamera.transform.position - var_164_11.position

				var_164_11.forward = Vector3.New(var_164_18.x, var_164_18.y, var_164_18.z)

				local var_164_19 = var_164_11.localEulerAngles

				var_164_19.z = 0
				var_164_19.x = 0
				var_164_11.localEulerAngles = var_164_19
			end

			local var_164_20 = arg_161_1.actors_["1067ui_story"].transform
			local var_164_21 = 0

			if var_164_21 < arg_161_1.time_ and arg_161_1.time_ <= var_164_21 + arg_164_0 then
				arg_161_1.var_.moveOldPos1067ui_story = var_164_20.localPosition
			end

			local var_164_22 = 0.001

			if var_164_21 <= arg_161_1.time_ and arg_161_1.time_ < var_164_21 + var_164_22 then
				local var_164_23 = (arg_161_1.time_ - var_164_21) / var_164_22
				local var_164_24 = Vector3.New(0, 100, 0)

				var_164_20.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1067ui_story, var_164_24, var_164_23)

				local var_164_25 = manager.ui.mainCamera.transform.position - var_164_20.position

				var_164_20.forward = Vector3.New(var_164_25.x, var_164_25.y, var_164_25.z)

				local var_164_26 = var_164_20.localEulerAngles

				var_164_26.z = 0
				var_164_26.x = 0
				var_164_20.localEulerAngles = var_164_26
			end

			if arg_161_1.time_ >= var_164_21 + var_164_22 and arg_161_1.time_ < var_164_21 + var_164_22 + arg_164_0 then
				var_164_20.localPosition = Vector3.New(0, 100, 0)

				local var_164_27 = manager.ui.mainCamera.transform.position - var_164_20.position

				var_164_20.forward = Vector3.New(var_164_27.x, var_164_27.y, var_164_27.z)

				local var_164_28 = var_164_20.localEulerAngles

				var_164_28.z = 0
				var_164_28.x = 0
				var_164_20.localEulerAngles = var_164_28
			end

			local var_164_29 = 0
			local var_164_30 = 0.5

			if var_164_29 < arg_161_1.time_ and arg_161_1.time_ <= var_164_29 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_31 = arg_161_1:FormatText(StoryNameCfg[218].name)

				arg_161_1.leftNameTxt_.text = var_164_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_32 = arg_161_1:GetWordFromCfg(113131038)
				local var_164_33 = arg_161_1:FormatText(var_164_32.content)

				arg_161_1.text_.text = var_164_33

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_34 = 20
				local var_164_35 = utf8.len(var_164_33)
				local var_164_36 = var_164_34 <= 0 and var_164_30 or var_164_30 * (var_164_35 / var_164_34)

				if var_164_36 > 0 and var_164_30 < var_164_36 then
					arg_161_1.talkMaxDuration = var_164_36

					if var_164_36 + var_164_29 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_36 + var_164_29
					end
				end

				arg_161_1.text_.text = var_164_33
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131038", "story_v_out_113131.awb") ~= 0 then
					local var_164_37 = manager.audio:GetVoiceLength("story_v_out_113131", "113131038", "story_v_out_113131.awb") / 1000

					if var_164_37 + var_164_29 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_37 + var_164_29
					end

					if var_164_32.prefab_name ~= "" and arg_161_1.actors_[var_164_32.prefab_name] ~= nil then
						local var_164_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_32.prefab_name].transform, "story_v_out_113131", "113131038", "story_v_out_113131.awb")

						arg_161_1:RecordAudio("113131038", var_164_38)
						arg_161_1:RecordAudio("113131038", var_164_38)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_113131", "113131038", "story_v_out_113131.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_113131", "113131038", "story_v_out_113131.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_39 = math.max(var_164_30, arg_161_1.talkMaxDuration)

			if var_164_29 <= arg_161_1.time_ and arg_161_1.time_ < var_164_29 + var_164_39 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_29) / var_164_39

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_29 + var_164_39 and arg_161_1.time_ < var_164_29 + var_164_39 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/OM0108",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST21a",
		"TextureConfig/Background/ST21"
	},
	voices = {
		"story_v_out_113131.awb"
	}
}
